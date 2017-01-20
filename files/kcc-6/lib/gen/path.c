/* Implement UNIX path parsing routines */

#include <c-env.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#if SYS_T20+SYS_10X
#include <jsys.h>
#include <ctype.h>
#include <stdarg.h>
#include <sys/usydat.h>
#include <sys/c-debug.h>
#include <sys/c-parse.h>
#include <sys/urtint.h>
#include <urtsud.h>

static int
jfns(buf, jfn, flags)
char *buf;
int jfn, flags;
{
  int acs[5];

  acs[1] = (int)(buf - 1);
  acs[2] = jfn;
  acs[3] = flags;
  return jsys(JFNS, acs);
}

static int jfna(buf, jfn, tmpfil)
char *buf;
int jfn, tmpfil;
{
  int bits;

  /* Only output attributes for native format */
  if (_urtsud.su_path_out_type == _URTSUD_PATH_OUT_NATIVE) {
    bits = (monsym("JS%PAF") | monsym("JS%TMP") | monsym("JS%ATR")
	    | ((jfn & monsym("GJ%PRO")) ? monsym("JS%PRO") : 0)
	    | ((jfn & monsym("GJ%ACT")) ? monsym("JS%ACT") : 0));
    if (!jfns(buf, jfn, bits)) return 0;
    if (tmpfil) strcat(buf, ";T"); /* Add ;T manually? */
  }
  return 1;
}

typedef enum {FIELD_ALL, FIELD_DEVDIR, FIELD_FILE,
		FIELD_DEV, FIELD_DIR, FIELD_NAME, FIELD_TYPE,
		FIELD_GEN, FIELD_ATR, FIELD_END} fieldtype;

static int
pfields(jfn, dir, dodir, tmpfil, defver, fp)
int jfn, dir, dodir, tmpfil;
va_list fp;
{
  fieldtype ftype;
  char *fptr, *p;
  int ret = 1;

  /* Return requested fields of specification */
  while (ret) {			/* Loop until error */
    ftype = va_arg(fp, fieldtype); /* Get type of next field */
    if (ftype == FIELD_END) break; /* Done if END */
    fptr = va_arg(fp, char *);	/* Get pointer to where to put field */
    if (!fptr) continue;	/* If no pointer, skip this field */
    switch (ftype) {
    case FIELD_ALL:		/* Whole specification */
      if (!dodir) {
	if (jfns(fptr, jfn, 0111110000001)) { /* DEV:<DIR>NAME.TYPE.GEN */
	  _fncon(fptr, fptr, 1, defver);
	  if (!jfna(&fptr[strlen(fptr)], jfn, tmpfil)) /* Add attributes */
	    ret = 0;		/* Error */
	}
	else ret = 0;		/* Error */
	break;
      }				/* For dodir, fall into DEVDIR */

    case FIELD_DEVDIR:		/* Directory (& device) */
      if (dir) {
	if (!_dirst(dir, fptr)) ret = 0; /* Output directory */
	break;
      }
      if (jfns(fptr, jfn, 0110000000001)) /* DEV:<DIR> */
	_fncon(fptr, fptr, 1, 0);
      else ret = 0;
      break;

    case FIELD_FILE:		/* File part (name, type, gen, & attr) */
      if (dodir) *fptr = '\0';	/* Nothing for dodir */
      else if (jfns(fptr, jfn, 0001110000001)) { /* NAME.TYPE.GEN */
	_fncon(fptr, fptr, 0, defver);
	if (!jfna(&fptr[strlen(fptr)], jfn, tmpfil)) /* Add attributes */
	  ret = 0;		/* Error */
      }
      else ret = 0;
      break;

    case FIELD_DEV:		/* Device */
      if (dir) {
	if (!_dirst(dir, fptr)) ret = 0;
	else {
	  if (p = strchr(fptr, ':')) p[1] = '\0'; /* Terminate after device */
	  else *fptr = '\0';	/* Or return null if no device */
	}
	break;
      }
      if (jfns(fptr, jfn, 0100000000001)) /* DEV: */
	_fncon(fptr, fptr, 1, 0);
      else ret = 0;
      break;

    case FIELD_DIR:		/* Directory */
      if (dir) {
	if (!_dirst(dir, fptr)) ret = 0; /* Output DEV:<DIR> */
	else if (p = strchr(fptr, ':')) strcpy(fptr, p + 1); /* Move dir */
	break;
      }
      if (jfns(fptr, jfn, 0010000000001)) /* <DIR> */
	_fncon(fptr, fptr, 0, 0);
      else ret = 0;
      break;

    case FIELD_NAME:		/* File name */
      if (dodir) *fptr = '\0';	/* Nothing for dodir */
      else if (!jfns(fptr, jfn, 0001000000001)) /* NAME */
	ret = 0;
      break;

    case FIELD_TYPE:		/* File type */
      if (dodir) *fptr = '\0';	/* Nothing for dodir */
      else if (!jfns(fptr, jfn, 0000100000001)) /* TYPE */
	ret = 0;
      break;

    case FIELD_GEN:		/* Generation */
      if (dodir) *fptr = '\0';	/* Nothing for dodir */
      else {
	if (defver) strcpy(fptr, "."); /* If default, just copy '.' */
	else if (!jfns(fptr, jfn, 0000010000001)) /* GEN */
	  ret = 0;
      }
      break;

    case FIELD_ATR:		/* Return attributes */
      if (dodir) *fptr = '\0';	/* Nothing for dodir */
      else {
	if (!jfna(fptr, jfn, tmpfil)) /* Add attributes */
	  ret = 0;		/* Error */
      }
      break;

    default:			/* Anything else is an error */
      ret = 0;
    }
#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_PARSE_RES) {
      _dbgl("PATH&pfields(");
      if (jfn) {
	_dbgs("jfn ");
	_dbgj(jfn);
      }
      else {
	_dbgs("dir ");
	_dbgdn(dir);
      }
      _dbgs(") => ");
      switch (ftype) {
      case FIELD_ALL: _dbgs("ALL "); break;
      case FIELD_DEVDIR: _dbgs("DEVDIR "); break;
      case FIELD_FILE: _dbgs("FILE "); break;
      case FIELD_DEV: _dbgs("DEV "); break;
      case FIELD_DIR: _dbgs("DIR "); break;
      case FIELD_NAME: _dbgs("NAME "); break;
      case FIELD_TYPE: _dbgs("TYPE "); break;
      case FIELD_GEN: _dbgs("GEN "); break;
      case FIELD_ATR: _dbgs("ATR "); break;
      default: _dbgs("??? "); break;
      }
      if (ret) {
	_dbgs("\"");
	_dbgs(fptr);
	_dbgs("\"");
      }
      else _dbgs("failed");
      _dbgs("\r\n");
    }
#endif
  }

  if (jfn) _rljfn(jfn & RH);
  return ret;
}

static int jfnblk[] = {
  monsym("GJ%FLG") | monsym("GJ%OFG") | monsym("GJ%XTN"), /* .GJGEN */
  (monsym(".NULIO") << 18) | monsym(".NULIO"), /* .GJSRC */
  0,				/* .GJDEV */
  0,				/* .GJDIR */
  0,				/* .GJNAM */
  0,				/* .GJEXT */
  0,				/* .GJPRO */
  0,				/* .GJACT */
  0,				/* .GJJFN */
  monsym("G1%SLN"),			/* .GJF2 */
};
  
static int
tryone(path, pflags, ap)
char *path;
int pflags;
va_list ap;
{
  int doopen, dodir, tmpfil, acs[5], jfn = 0, dir = 0, found = 0, defver;
  va_list fp;

  doopen = va_arg(ap, int);
  fp = va_arg(ap, va_list);
  dodir = pflags & _PARSE_OUT_DIR;
  tmpfil = (pflags & _PARSE_OUT_TMP) ? monsym("GJ%TMP") : 0;

  if (dodir && doopen)
    dir = _rcdir(path);		/* Translate directory */
  else {
    if (doopen) {
      acs[1] = GJ_SHT | tmpfil | GJ_OLD;
      acs[2] = (int)(path - 1);
      if (jsys(GTJFN, acs)) {
	if (!*(char *)acs[2]) found++; /* Success, store JFN */
	_rljfn(acs[1] & RH);	/* Check for null terminator */
      }
    }
    if (!doopen || found) {
      jfnblk[0] &= ~monsym("GJ%TMP");
      jfnblk[0] |= tmpfil;
      acs[1] = (int)&jfnblk & RH;
      acs[2] = (int)(path - 1);
      if (jsys(GTJFN, acs)) {
	if (!*(char *)acs[2]) jfn = acs[1]; /* Null terminator, save JFN */
	else _rljfn(acs[1] & RH); /* Non-null terminator, error */
      }
      tmpfil |= jfn & monsym("GJ%TFS");
    }
  }

  if (!jfn && !dir) {
#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_PARSE_RES) {
      _dbgl("PATH&tryone(\"");
      _dbgs(path);
      _dbgs("\") => ");
      if (doopen && dodir) _dbgs("RCDIR");
      else _dbgs("GTJFN");
      _dbgs(" failed\r\n");
    }
#endif
    return 0;
  }

  defver = !dodir
    && ((jfn & (monsym("GJ%UHV") | monsym("GJ%NHV") | monsym("GJ%TFS")))
	|| tmpfil);

  return pfields(jfn, dir, dodir, tmpfil, defver, fp);
}

static int fparse(int fd, ...)
{
  struct _ufile *uf;
  int tmpfil, defver;
  va_list fp;

  va_start(fp, fd);

  if (!(uf = _UFGET(fd))) {
    errno = EBADF;
    return -1;
  }

  tmpfil = _gtfdb(uf->uf_ch, _FBCTL) & monsym("FB%TMP");
				/* Determine if temp file for printout */
  defver = 1;			/* Assume default version, no way to tell */
  if (!pfields(uf->uf_ch, 0, 0, tmpfil, defver, fp)) return -1;

  return 0;
}

static int
parse(const char *name, ...)
{
  va_list fp;

  USYS_BEG();
  va_start(fp, name);
  if (!_parse(name, _PARSE_IN_DIR, tryone, 1, fp)
      && !_parse(name, 0, tryone, 1, fp)
      && !_parse(name, 0, tryone, 0, fp)
      && !_parse(name, _PARSE_IN_DIR, tryone, 0, fp)) USYS_RET(-1);

  USYS_RET(0);
}

#define CVTUNIX(file) \
  (((_urtsud.su_path_out_type != _URTSUD_PATH_OUT_UNIX) \
    && ((file) && !*(file))) ? (*(file) = '.', (file)[1] = '\0') : 0)

/* Parse routines which work from path */

/* abspath() - Convert to canonical absolute path */
int
abspath(name, result)
const char *name;
char *result;
{
#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_PARSE_RES) {
    _dbgl("PATH&abspath(\"");
    _dbgs(name);
    _dbgs("\") Entry\r\n");
  }
#endif
  return parse(name, FIELD_ALL, result, FIELD_END);
}

/* path() - Separate directory and file parts of path */
int path(path, direc, file)
char *path, *direc, *file;
{
#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_PARSE_RES) {
    _dbgl("PATH&path(\"");
    _dbgs(path);
    _dbgs("\") Entry\r\n");
  }
#endif
  if (parse(path, FIELD_DEVDIR, direc, FIELD_FILE, file, FIELD_END))
    return -1;
  CVTUNIX(file);
  return 0;
}

/* decomp() - Completely decompose a file specification */
int
decomp(path, dev, dir, name, type, gen, atr)
const char *path;
char *dev, *dir, *name, *type, *gen, *atr;
{
#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_PARSE_RES) {
    _dbgl("PATH&decomp(\"");
    _dbgs(path);
    _dbgs("\") Entry\r\n");
  }
#endif
  return parse(path, FIELD_DEV, dev, FIELD_DIR, dir, FIELD_NAME, name,
	       FIELD_TYPE, type, FIELD_GEN, gen, FIELD_ATR, atr, FIELD_END);
}

/* Parse routines which work from open descriptor*/

/* fabspath() - Convert to canonical absolute path */
int
fabspath(fd, result)
int fd;
char *result;
{
#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_PARSE_RES) {
    _dbgl("PATH&fabspath(fd ");
    _dbgd(fd);
    _dbgs(") Entry\r\n");
  }
#endif
  return fparse(fd, FIELD_ALL, result, FIELD_END);
}

/* fpath() - Separate directory and file parts of path */
int fpath(fd, direc, file)
int fd;
char *direc, *file;
{
#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_PARSE_RES) {
    _dbgl("PATH&fpath(fd ");
    _dbgd(fd);
    _dbgs(") Entry\r\n");
  }
#endif
  if (fparse(fd, FIELD_DEVDIR, direc, FIELD_FILE, file, FIELD_END))
    return -1;
  CVTUNIX(file);
  return 0;
}

/* fdecomp() - Completely decompose a file specification */
int
fdecomp(fd, dev, dir, name, type, gen, atr)
int fd;
char *dev, *dir, *name, *type, *gen, *atr;
{
#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_PARSE_RES) {
    _dbgl("PATH&fdecomp(");
    _dbgd(fd);
    _dbgs(") Entry\r\n");
  }
#endif
  return fparse(fd, FIELD_DEV, dev, FIELD_DIR, dir, FIELD_NAME, name,
		FIELD_TYPE, type, FIELD_GEN, gen, FIELD_ATR, atr, FIELD_END);
}

#else /* SYS_T20+SYS_10X */
#error abspath only available under T20 or 10X
#endif /* SYS_T20+SYS_10X */
