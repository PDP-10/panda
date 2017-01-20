#include <c-env.h>

/* Only implemented for T20 and 10X */
#if SYS_T20+SYS_10X
#include <sys/param.h>
#include <sys/usydat.h>
#include <sys/c-parse.h>
#include <string.h>
#include <limits.h>
#include <errno.h>
#include <jsys.h>
#include <stdarg.h>
#include <urtsud.h>
#include <stdlib.h>
#include <sys/urtint.h>

extern int `$TMPDR`;

#include <sys/c-debug.h>

#define MAXLOG 2048
/* Unix '/' directory */
#define UNIXROOT "UNIX-ROOT"
/* Root directory for a structure */
#define ROOTDR "ROOT-DIRECTORY"
#define ROOTDRD "ROOT-DIRECTORY."
#define ROOTDRDL (sizeof(ROOTDRD)-1)
/* Unix null device */
#define UNULL "null"
/* TOPS20 null device */
#define TNULL "NUL"

/* Parser states */
typedef enum pstates {_TOP,_UDEV,_DEV,_DIR,_FIL} pstate;
typedef enum dvtyps {_NONE, _NODIRS, _DIRS, _NOLOGDIRS} dvtyp;

/* Structure to hold parse results */
typedef struct {
  int errno;			/* Error number to return */
  int anyunix;			/* Any unix syntax seen */
  int dotdot;			/* Number of defered ..'s */
  int iflags;			/* Parse input flags */
  int pflags;			/* Parse output flags */
  pstate pst;			/* Parse state */
  char dev[MAXPATHLEN];		/* Parsed device string (no colon) */
  char dir[MAXPATHLEN];		/* Parsed directory string  (no <>) */
  char tail[MAXPATHLEN];	/* Parsed remaining specification */
} parsed;

/* Logical name history structure */
typedef struct loghst_S {
  struct loghst_S *prv;		/* Link to previous block */
  int logtyp;			/* Type of logical (system/job) */
  char lognam[MAXPATHLEN];	/* Logical name string */
} loghst;

/* Initialize parse data and state */
static void iparsed(parsed *nfilep)
{
  nfilep->dev[0] = nfilep->dir[0] = nfilep->tail[0] = '\0';
  nfilep->pst = _TOP;
  nfilep->dotdot = 0;
}

/* Find next non-quoted character in 'str' from set 'brkset'. */
/* 'brkset' must contain \026 for quoting to work right. */
static char *nqbrk(char *str, char *brkset)
{
  int i = 0;

  while (1) {
    i += strcspn(&str[i], brkset); /* Skip to next break */
    if ((str[i] != '\026') || !str[i+1]) return &str[i];
				/* Return if not quote */
    i += 2;			/* Else skip quote and next character */
  }
}

/* Like strncpy, but translates "." to "$" up to 'trndot' times. */
static void tcopy(parsed *nfilep, char *dst, char *src, int len, int trndot)
{
  char c, lc;

  for (lc = 0; len--; lc = c) {	/* Process specified number of characters */
				/* Remember previous character */
    c = *src++;			/* Get next character */
    if ((trndot > 0) && (c == '.') && (lc != '\026')) {
				/* Is translation still in effect, */
				/* and do we have an unquoted "."? */
      nfilep->anyunix++;	/* Flag unix syntax seen */
      *dst++ = '$';		/* Yes, replace with "$" */
      trndot--;			/* And count one translated */
    }
    else *dst++ = c;		/* Else copy character to output */
  }
  *dst = '\0';			/* Terminate output with null */
}

static char *strput(char *op, char *str, int len)
{
  if (len >= 0) {
    strncpy(op, str, len);
    return op + len;
  }
  strcpy(op, str);
  return op + strlen(op);
}

/* Determine if device has directories.				*/
/* Returns:							*/
/*	_NONE		Invalid device				*/
/*	_NODIRS		Valid device with no directories	*/
/*	_DIRS		Multiple directory device in logical	*/
/*	_NOLOGDIRS	Multiple directory device		*/
static dvtyp devtype(char *dev)
{
  int acs[5], l;
  char devnam[40];

  if (!*dev) return _NONE;

  acs[1] = (int)(dev - 1);
  if (!jsys(STDEV, acs)) {
    for (l=0; l < 40; l++) {
      if ((dev[l] == ':') || (dev[l] == '\0')) break;
      devnam[l] = dev[l];
    }
    if (l >= 40) return _NONE;	/* Lose if name too long */
    devnam[l] = '\0';
    for (acs[1] = _LNSJB; acs[1] <= _LNSSY; acs[1]++) {
      acs[2] = (int)(devnam - 1); /* Potential logical name */
      acs[3] = 0;		/* Discard result */
      if (jsys(LNMST, acs))	/* If is logical name, */
	return _DIRS;		/* Return multiple directory on lognam */
    }
    return _NONE;		/* Else illegal */
  }

  acs[1] = acs[2];
  if (!jsys(DVCHR, acs)) return _NONE;

  if (!(acs[2] & monsym("DV%MDD"))) return _NODIRS;

  acs[2] = acs[1];
  acs[1] = (int)(devnam - 1);
  if (jsys(DEVST, acs)
      && !strncasecmp(devnam, dev, l = strlen(devnam))
      && ((dev[l] == '\0') || (dev[l] == ':')))
    return _NOLOGDIRS;		/* Actual device name */

  return _DIRS;			/* Just multiple directory on lognam */
}

static int dortn(char *npath, parsed *nfilep,
		 int(*rtn)(char *, int, va_list), va_list ap)
{
  int ret;

#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_PARSE_TRY) {
    _dbgl("PARSE&dortn(\"");
    _dbgs(npath);
    _dbgs("\")\r\n");
  }
#endif

  ret = rtn(npath, nfilep->pflags , ap);	/* Call predicate routine */

  if (!ret && !nfilep->errno) nfilep->errno = errno;
				/* Capture first error */
  return ret;
}

/* Assemble final file specification in 'npath' and call predicate routine */
static int try(char *npath, parsed *nfilep, char *ndev, char *ndir,
		  int(*rtn)(char *, int, va_list), va_list ap)
{
  char *op = npath, *sdp, *dp, *tp;
  int dotdot = nfilep->dotdot;
  dvtyp dtype;

  if (*ndev) {			/* Any device supplied? */
    op = strput(op, ndev, -1);	/* Yes, copy device to new path */
    *op++ = ':';		/* Add ":" */
  }

  *op++ = '<';			/* Start directory */
  sdp = op;			/* Remember start of directory */
  
  if (ndir)			/* Do we have a directory from logical? */
    op = strput(op, ndir, -1);	/* Yes, copy to new path */

  while (dotdot--) {		/* Process all pending ..'s */
    if (op == sdp) {		/* If finished dir, */
      op = npath;		/* Reset output pointer to beginning */
      break;			/* Further backup is ignored */
    }
    else do op--;		/* Else backup in directory until */
      while ((op != sdp) && ((*op != '.') || (op[-1] == '\026')));
				/* All gone, or got to unquoted dot */
  }

  if (op != npath) {		/* If any device, */
    dtype = devtype(npath);	/* Get type information */
    if (dtype == _NONE) return 0; /* Fail immediately if invalid device */
  }

  if (*nfilep->dir) {		/* Any directory from parse? */
    if (op == npath) {		/* Yes, did we delete device? */
      tp = nfilep->dir;		/* Get start of directory */
      if (*tp == '.') tp++;	/* Skip initial dot */
      dp = nqbrk(tp, "\026.");	/* Yes, find first dir comp */
      op = strput(op, tp, dp - tp); /* Copy to destination */
      sdp = op = strput(op, ":<", -1); /* Make it device and start dir */
    }
    else dp = nfilep->dir;	/* Yes, point to parsed dir */

    if (op != sdp)		/* Have patial dir? */
      *op++ = '.';		/* Yes, add separating "." */

    if (*dp == '.') dp++;	/* Skip any leading dot */
    op = strput(op, dp, -1);	/* Copy remaining directory components */
  }
  else if (op == npath) {	/* No dir from parse, dev deleted? */
    if (*nfilep->tail) {	/* No device or dir left, any tail?*/
      tcopy(nfilep, op, nfilep->tail, strlen(nfilep->tail), INT_MAX);
				/* Add tail, converting "." to "$" */
      *nfilep->tail = '\0';	/* Clear tail */
      op += strlen(op);		/* Advance pointer */
    }
    else {			/* No tail must be  "/" */
      if (!(nfilep->iflags & _PARSE_IN_DIR)) return 0;
				/* If already tried UNIX-ROOT:, */
				/* or not looking for dir, fail */
      op = strput(npath, UNIXROOT, -1);
				/* Try UNIX-ROOT: as dir */
    }
    sdp = op = strput(op, ":<", -1);	/* Add ":" and start dir */
  }
  else if (op == sdp)		/* No dir? */
    switch (dtype) {		/* Yes, determine device type */
    case _DIRS:			/* Multiple directory device */
      if (nfilep->iflags & _PARSE_IN_DIR) /* Need dir? */
    case _NOLOGDIRS:		/* Same, but not logical */
	op = strput(op, ROOTDR, -1); /* Use root directory of device */
      break;
    }

  if (op == sdp) op--;		/* If last was start dir, delete it */
  else {
    if (((op - sdp) > ROOTDRDL) && !strncasecmp(sdp, ROOTDRD, ROOTDRDL)) {
      strncpy(sdp, sdp + ROOTDRDL, (op - sdp) - ROOTDRDL);
      op -= ROOTDRDL;
    }
    *op++ = '>';		/* Else add close dir */
  }

  strcpy(op, nfilep->tail);	/* Copy tail */

  return dortn(npath, nfilep, rtn, ap);
}

/* Try using UNIX-ROOT: with current dev as new initial sub-directory */
static void tryunixroot(char *npath, parsed *nfilep)
{
  if (*nfilep->dev) {
    if (strcasecmp(nfilep->dev, "tmp") == 0)
      return;	/* For /tmp, let explog do its magic */
    if (nfilep->dotdot) {	/* If defered ..'s */
      nfilep->dotdot--;		/* Then reduce by one and discard device */
    }
    else {			/* No defered ..'s, move dev to dirs */
      if (*nfilep->dir) {	/* Have existing dir string? */
	*npath = '.';		/* Start with leading "." */
	strcpy(npath + 1, nfilep->dev); /* Add device as leading dir comp */
	strcat(npath, nfilep->dir); /* Tack on existing dirs */
	strcpy(nfilep->dir, npath); /* Move result back to dir string */
      }
      else {
	*nfilep->dir = '.';	/* Start with leading "." */
	strcpy(nfilep->dir + 1, nfilep->dev);
	/* Add device as leading dir comp */
      }
    }
  }
  strcpy(nfilep->dev, UNIXROOT); /* Try relative to UNIX-ROOT: */
}

/* Add component to parse structure */
static void addcomp
  (parsed *nfilep, char *src, int len, int trndot, int subdir)
{
  char *dp;

  if (!len) return;		/* If null component, done */
  switch (nfilep->pst) {	/* Check current state */
  case _DIR:			/* In directory */
    if (*nfilep->dir) strcat(nfilep->dir, ".");
				/* If not first, add separating dot */
    dp = nfilep->dir;		/* Destination is dir field */
    break;
  case _FIL:			/* In file name */
    dp = nfilep->tail;		/* Destination is tail field */
    break;
  case _UDEV:			/* Saw /dev last */
    if ((len == strlen(UNULL)) && !strncmp(UNULL, src, len)) {
				/* Is it unix null device? */
      src = TNULL;		/* Yes, change source to TOPS20 null device */
      len = strlen(TNULL);
    }
  case _TOP:			/* Start absolute path */
    nfilep->pst  = _DEV;	/* Now in device field */
    dp = nfilep->dev;		/* Destination is device field */
    break;
  case _DEV:			/* In device field? */
    nfilep->pst = _DIR;		/* Now in directory field */
    dp = nfilep->dir;		/* Destination is directory field */
    if (subdir) {		/* If first subdir */
      *dp++ = '.';		/* Start with leading dot for subdir */
      *dp = '\0';		/* Terminate with null */
    }
    break;
  }

  dp += strlen(dp);		/* Move to end of destination string */

  if ((nfilep->pst == _FIL) && (*src == '.')) {
				/* In file name and initial dot? */
    nfilep->anyunix++;		/* Flag unix syntax seen */
    len--;			/* Yes, not in source any more */
    trndot--;			/* Count dot translated */
    src++;			/* Advance source over dot */
    *dp++ = '$';		/* Store dollar in place of dot */
  }
  tcopy(nfilep, dp, src, len, trndot); /* Copy remainder translate as needed */
}

/* Check for special names ".", ".." and "/dev" */
static int special(parsed *nfilep, char *p, int i, int *sdone)
{
  char *tp;

  *sdone = 0;			/* Assume not special */

  /* No special names for native parse */
  if (_urtsud.su_path_in_type == _URTSUD_PATH_IN_NATIVE) {
    return 1;
  }

  if (i) {			/* If not null component, */
    if ((i==1) && !strncmp(p, ".", i))
      *sdone = 1;		/* If ".", just ignore, but say special */
    else if ((i == 2) && !strncmp(p, "..", i)) {
				/* If "..", */
      switch (nfilep->pst) {	/* Check current state */
      case _UDEV:		/* "/dev/.." is like "/" */
	iparsed(nfilep);	/* Initialize parse */
	break;
      case _TOP:		/* At top, */
	break;			/* ".." = ".", just ignore */
      case _FIL:		/* This can't happen? */
	return 0;		/* Return error */
      case _DEV:
	nfilep->dotdot++;	/* Backup later */
	break;
      case _DIR:		/* In directory, backup over last dir comp */
	tp = nfilep->dir + strlen(nfilep->dir);
				/* Get pointer to end of dir field */
	do tp--;		/* Backup */
	  while ((tp != nfilep->dir) && ((*tp != '.') || (tp[-1] == '\026')));
				/* Until beginning or unquoted dot */
	*tp = '\0';		/* Terminate with null */
	if (tp == nfilep->dir) nfilep->pst = _DEV;
				/* If at beginning, now in device field */
	break;
      }
      *sdone = 1;		/* Say special */
    }
    else if ((nfilep->pst == _TOP) && (i == 3) && !strncmp(p, "dev", i)) {
				/* "/dev"? */
      nfilep->pst = _UDEV;	/* Yes, change to UNIX device state */
      *sdone = 1;		/* Say special */
    }
  }

  return 1;			/* Return, no error */
}

static int explog(loghst *lghsp, char *npath, parsed *nfilep, char *dev,
		  int(*rtn)(char *, int, va_list), va_list ap)
{
  char *np, *p1, *p2, *p3;
  loghst lghs, *lghst;
  char exp[MAXLOG];
  int ret, acs[5], isdsk, istmp = 0;

#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_PARSE_EXP) {
    _dbgl("PARSE&explog(\"");
    _dbgs(dev);
    _dbgs("\")\r\n");
  }
#endif

  lghs.prv = lghsp;		/* Store pointer to previous loghst block */
  strcpy(lghs.lognam, dev);	/* Copy device as logical name */
  lghs.logtyp = _LNSJB;		/* Assume job logical */
  for (lghst = lghsp; lghst; lghst = lghst->prv) {
				/* Scan previous logicals */
    if (!strcasecmp(lghs.lognam, lghst->lognam)) {
				/* Match? */
      if (lghst->logtyp == _LNSSY) /* Yes, was it system logical? */
	return try(npath, nfilep, dev, NULL, rtn, ap);
				/* Yes, no further expansions, try it */
      else lghs.logtyp = _LNSSY; /* Matched job logical, try system */
      break;
    }
  }
  isdsk = (strcasecmp(lghs.lognam, "DSK") == 0);
				/* Are we doing DSK:? */
  if (isdsk && USYS_VAR_REF(curdir)) {
				/* If DSK: and we have current dir, */
    if (!_dirst(USYS_VAR_REF(curdir), exp)) /* Convert to current dir */
      return 0;
  }
  else {			/* Not DSK: or no current dir */
    acs[1] = lghs.logtyp;	/* Type of logical to find */
    acs[2] = (int)(lghs.lognam - 1); /* Logical name string */
    acs[3] = (int)(exp - 1);	/* Where to put expansion */
    if (!jsys(LNMST, acs)	/* If expansion fails, */
	&& ((lghs.logtyp == _LNSSY) /* and was system */
	    || (acs[1] = lghs.logtyp = _LNSSY, !jsys(LNMST, acs)))) {
				/* or try system and fail */
      if (isdsk) {		/* Expansion fail, DSK: */
	if (!jsys(GJINF, acs)) return 0; /* Get connected directory */
	if (!_dirst(acs[2], exp)) return 0; /* Put in expansion buffer */
      }
      else if (strcasecmp(lghs.lognam, "TMP") == 0) {
	if (!_dirst(`$TMPDR`, exp)) /* Put dir in expansion buffer */
	  return 0;		/* Return on failure */
	nfilep->pflags |= _PARSE_OUT_TMP;
	istmp = 1;
      }
      else return try(npath, nfilep, dev, NULL, rtn, ap);
				/* Not logical and not DSK:, try it */
    }
  }

#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_PARSE_EXP) {
    _dbgl("    => ");
    _dbgs(exp);
    _dbgs("\r\n");
  }
#endif

  np = exp;			/* Get pointer to logical expansion */
  ret = 0;			/* No success yet */
  while (*np) {			/* Process expansion */
    p2 = nqbrk(np, "\026,");	/* Break at commas */
    if (*p2) *p2++ = '\0';	/* Separate strings */
    p1 = np;			/* Remember pointer to this component */
    np = p2;			/* Save pointer to next component */
    p2 = nqbrk(p1, "\026:");	/* Find device */
    if (p2) *p2++ = '\0';	/* Replace colon with null if found */
    else p1 = "";		/* Flag no device if not found */
    p2 = nqbrk(p2 ? p2 : p1, "\026<");	/* Find start of directory */
    if (*p2) {			/* If have directory, */
      p3 = nqbrk(p2++, "\026>"); /* Find end */
      if (*p3) {		/* If found end, */
	*p3 = '\0';		/* Terminate it with null */
	if (ret = try(npath, nfilep, p1, p2, rtn, ap))
	  break;		/* Terminate on success */
      }
    }
    else			/* No directory in expansion */
     if (ret = explog(&lghs, npath, nfilep, p1, rtn, ap))
				/* Recur on this device */
	break;			/* Terminate on success */
  }

  if (istmp) nfilep->pflags &= ~_PARSE_OUT_TMP;
  return ret;			/* Failure */
}

int _parse(const char *path, int iflags,
	   int(*rtn)(char *, int, va_list), ...)
{
  va_list ap;
  parsed nfile;
  char *p, *dp, *dirchr, tmppath[MAXPATHLEN];
  int sdone, i, j, dots, ret, subdir, acs[5];
  int pdone = 0, devreset = 0;

#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_PARSE_INP) {
    _dbgl("PARSE&_parse(\"");
    _dbgs(path);
    if (iflags & _PARSE_IN_DIR) _dbgs("\", dir");
    else _dbgs("\", file");
    _dbgs(")\r\n");
  }
#endif

  if (!*path) return 0;		/* Quick check for no path */
  nfile.iflags = iflags;	/* Store input flags */
  nfile.pflags = iflags & _PARSE_IN_DIR ? _PARSE_OUT_DIR : 0;
				/* Initialize output flags */
  nfile.anyunix = 0;		/* Init to no UNIX syntax seen */
  if ((USYS_VAR_REF(curdir) != 0) /* If using curdir, */
    && (!jsys(GJINF,acs) || (acs[2] != USYS_VAR_REF(curdir))))
				/* and current != connected dir */
    nfile.anyunix++;		/* Flag unix syntax seen */
  errno = EINVAL;		/* Default error */
  if ((*path == '~') && (_urtsud.su_path_in_type != _URTSUD_PATH_IN_NATIVE)) {
				/* Initial tilda and UNIX OK? */
    nfile.anyunix++;		/* Flag unix syntax seen */
    if ((path[1] == '/') || (path[1] == '\0')) {
				/* Yes, slash or EOS next? */
      p = getenv("HOME");	/* Yes, substitute the value of $HOME */
      if (!p || !*p) return 0;	/* Error if none */
      strcpy(tmppath, p);	/* Copy to temp string */
      if ((tmppath[strlen(tmppath)-1] != '/')
				/* If doesn't end with slash */
	  && (path[1] != '/'))	/* And char after tilda is not slash */
	strcat(tmppath, "/");	/* Add slash */
    }
    else strcpy(tmppath, "/ps/"); /* Else assume "ps:<user>" (/ps/user) */
    strcat(tmppath, &path[1]);	/* Add remainder of path to temp */
  }
  else strcpy(tmppath, path);	/* If not tilda, just copy path to temp */

  /* For UNIX parse, convert backslash to ^V */
  if (_urtsud.su_path_in_type != _URTSUD_PATH_IN_NATIVE)
    for (i = 0; tmppath[i];) {	/* Scan string */
      i += strcspn(&tmppath[i], "\026\\");
				/* Scan to next ^V or backslash */
      switch (tmppath[i]) {	/* Handle each */
      case '\\':		/* Backslash */
	nfile.anyunix++;	/* Flag unix syntax seen */
	tmppath[i] = '\026';	/* Is replaced by ^V */
      case '\026':		/* ^V or backslash */
	if (tmppath[++i]) i++;	/* Skip next character if not end */
	break;
      }
    }

  iparsed(&nfile);		/* Initialize parse state */
  p = tmppath;			/* Get pointer to temp path */
  if ((*p != '/') || (_urtsud.su_path_in_type == _URTSUD_PATH_IN_NATIVE))
    addcomp(&nfile, "DSK", 3, INT_MAX, 0); /* Add device DSK: as start point */
  else nfile.anyunix++;		/* Else flag unix syntax seen */
  while (!pdone) {		/* If not done */
    switch (_urtsud.su_path_in_type) {
    case _URTSUD_PATH_IN_BOTH:
      dp = "\026/:[<;";		/* Special characters for both */
      break;
    case _URTSUD_PATH_IN_UNIX:
      dp = "\026/";		/* Special characters for UNIX */
      break;
    case _URTSUD_PATH_IN_NATIVE:
      dp = "\026:[<;";		/* Special characters for TOPS20 */
      break;
    }
    i = nqbrk(p, dp) - p;	/* Scan to next special character */
    switch (p[i]) {		/* Handle each */
    case ':':			/* Device terminator? */
      if (!i) return 0;		/* Null string is erro */
      if (devreset++) return 0;	/* Return if we see multiple devices */
      iparsed(&nfile);		/* Reset parse info when device seen */
      addcomp(&nfile, p, i, INT_MAX, 0); /* Add device to parse structure */
      break;
    case '[':			/* Start dir? */
      dirchr = "\026]";		/* Remember matching end */
      goto getdir;		/* Process dir */
    case '<':			/* Start dir? */
      dirchr = "\026>";		/* Remember matching end */
    getdir:			/* Process component preceding open dir */
      if (i) {			/* If field preceding dir open delim, */
	nfile.anyunix++;	/* Flag unix syntax seen */
	if (!special(&nfile, p, i, &sdone)) return 0;
				/* Check for special handling */
	if (!sdone) addcomp(&nfile, p, i, INT_MAX, 1);
				/* If not special, copy to parse structure */
      }
      p += (i + 1);		/* Advance pointer to dir */
      if (*p == '.') {		/* Initial '.' indicates subdir */
	subdir = 1;		/* Indicate subdir if first */
	if (*++p == '.') {	/* Skip first dot, second? */
	  p++;			/* Yes, skip it */
	  if (!special(&nfile, "..", 2, &sdone) || !sdone) return 0;
				/* Process .. on def dir; must work */
	}
      }
      dp = nqbrk(p, dirchr);	/* Skip to matching end dir comp */
      if (!*dp) return 0;	/* If no term, return error */
      i = dp - p;		/* Get length of dir */
      addcomp(&nfile, p, i, 0, subdir); /* Add to parse structure */
      break;
    case ';':			/* Attributes */
      if (_urtsud.su_path_in_type == _URTSUD_PATH_IN_UNIX)
	return 0;		/* Illegal in UNIX parse */
      i = strlen(p);		/* Start attribute, eat remainder of string */
    case '\0':			/* End of path? */
      pdone = 1;		/* Yes, flag done */
      if (!(nfile.iflags & _PARSE_IN_DIR)) { /* If not looking for directory */
	if (!special(&nfile, p, i, &sdone)) return 0;
				/* Check for special names */
	if (sdone) nfile.anyunix++; /* Flag unix syntax seen */
	else {			/* If not special */
	  dots = INT_MAX;	/* Assume all "."s to be translated  */
	  switch (nfile.pst) {	/* Check parse state */
	  case _DIR:		/* Done directory */
	  case _DEV:		/* or done device */
	    nfile.pst = _FIL;	/* then we are now in file field */
	    dots = -1;		/* Let last dot thru */
	    if (_urtsud.su_path_in_type != _URTSUD_PATH_IN_NATIVE) {
	      dp = NULL;		/* No pointer to last "." yet */
	      for (j=0; j<i; j++) { /* For each char in field */
		if (p[j] == '.') { /* Is it dot? */
		  dots++;		/* Yes, count dots */
		  dp = &p[j+1];	/* Remember pointer following last */
		}
		else if (p[j] == '\026') j++;
				/* If quote, skip following character */
	      }
	      if (dp) {
		if (*dp == '*') dp++; /* Skip over star (all generations) */
		else if ((*dp == '-') /* Minus followed by */
			 && ((dp[1] == '0') /* 0 */
			     || (dp[1] == '1') /* 1 */
			     || (dp[1] == '2') /* 2 */
			     || (dp[1] == '3'))) /* or 3 */
		  dp += 2;	/* Is special generation, skip it */
		else dp += strspn(dp,"0123456789"); /* All numeric gen */
		if (!*dp || (*dp == ';')) /* If end or attribute, */
		  dots--;	/* Then this was generation, allow dot */
	      }
	    }
	    break;
	  case _TOP:		/* If only / seen */
	  case _UDEV:		/* If /dev seen, */
	    break;		/* Must be device, translate all dots */
	  case _FIL:		/* shouldn't happen */
	    return 0;		/* Illegal case */
	  }
	  addcomp(&nfile, p, i, dots, 0);
				/* Add to parse structure */
	}
	break;
      }				/* If looking for directory, fall thru */
    case '/':			/* Normal path component */
      nfile.anyunix++;
      if (!special(&nfile, p, i, &sdone)) return 0;
				/* Check for special names */
      if (!sdone) addcomp(&nfile, p, i, INT_MAX, 1);
				/* If not special, add to parse structure */
      break;
    }
    p += (i + 1);		/* Advance over this component */
  }

  errno = ENOENT;		/* Parse OK, new default error */

  /* Check for something parsed */
  if ((nfile.pst == _UDEV)
      || (!(nfile.iflags & _PARSE_IN_DIR) && (nfile.pst == _TOP)))
      return 0;			/* These indicate nothing parsed, error */

#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_PARSE_PAR) {
    int i;

    _dbgl("PARSE&_parse(\"");
    _dbgs(path);
    if (nfile.iflags & _PARSE_IN_DIR) _dbgs("\", dir");
    else _dbgs("\", file");
    _dbgs(") parsed => ");

    if (nfile.anyunix) {
      if (*nfile.dev) {
	_dbgs(nfile.dev);
	_dbgs(":");
      }
      for (i=0; i < nfile.dotdot; i++)
	_dbgs("../");
      if (*nfile.dir) {
	_dbgs("<");
	_dbgs(nfile.dir);
	_dbgs(">");
      }
      _dbgs(nfile.tail);
    }
    else _dbgs(path);

    _dbgs("\r\n");
  }
#endif

  nfile.errno = 0;		/* Clear first error code storage */

  va_start(ap, rtn);		/* Get predicate arguments */

  if (!nfile.anyunix) {		/* If no unix syntax, */
    nfile.pflags |= _PARSE_OUT_NATIVE; /* Indicate native input */
    dp = strcpy(tmppath, path);
    ret = dortn(dp, &nfile, rtn, ap); /* And just use it */
  }
  else {
    dp = tmppath;
    if (*nfile.dev &&		/* Have device to expand, and */
	((*nfile.dir == '.')	/* Doing sub-directory? */
	 || (!*nfile.dir
	     && (USYS_VAR_REF(curdir) || (nfile.iflags & _PARSE_IN_DIR)))
				/* or no directory */
				/* and faking current dir or doing dir */
	 || nfile.dotdot))	/* or processing defered ..'s */
      ret = explog(NULL, tmppath, &nfile, nfile.dev, rtn, ap);
				/* Call recursive logical name expander */
    else ret = try(tmppath, &nfile, nfile.dev, NULL, rtn, ap);
				/* No logical expansion needed */
    if (!ret && (devtype(nfile.dev) == _NONE)) {
				/* No success and no valid device? */
      tryunixroot(tmppath, &nfile); /* Yes, try as UNIX-ROOT: sub-directory */
      ret = explog(NULL, tmppath, &nfile, nfile.dev, rtn, ap);
    }
  }

#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_PARSE_RES) {
    _dbgl("PARSE&_parse(\"");
    _dbgs(path);
    if (nfile.iflags & _PARSE_IN_DIR) _dbgs("\", dir");
    else _dbgs("\", file");
    if (ret) {
      _dbgs(") result => ");
      _dbgs(dp);
      _dbgs("\r\n");
    }
    else _dbgs(") failed\r\n");
  }
#endif

  if (!ret)
    errno = nfile.errno ? nfile.errno : ENOENT;		/* Default error */

  return ret;
}
#else /* SYS_T20+SYS_10X */
#error _parse() only provided for SYS_T20+SYS_10X
#endif /* SYS_T20+SYS_10X */
