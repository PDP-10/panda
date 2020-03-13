/*
**	OPEN - URT lowest-level file-opening
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.226, 11-Aug-1988
**	Copyright (C) 1986 by Ian Macky, SRI International
**	Edits for ITS:  Copyright (C) 1988 Alan Bawden
**
**	Also provides low-level global routines for other I/O calls.
**	See the UIODAT.C module for definitions of the internal I/O tables
**	and comments on their use.
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported */

#include <limits.h>		/* For CHAR_BIT */
#include <errno.h>
#include <stddef.h>		/* for NULL */
#include <string.h>
#include <urtsud.h>
#include <sys/usysio.h>
#include <sys/urtint.h>
#include <sys/usydat.h>
#include <sys/c-parse.h>
#include <sys/c-debug.h>
#include <sys/file.h>
#include <sys/types.h>
#ifdef __STDC__
#include <stdarg.h>
#endif

#if SYS_T20+SYS_10X
#include <jsys.h>
#include <sys/param.h>
#include <stdarg.h>
#define FILENAME_SIZE MAXPATHLEN	/* Max size of a filespec */

#elif SYS_ITS
#include <sysits.h>
#define FILENAME_SIZE 200	/* Max size of a filespec */

#elif SYS_T10+SYS_CSI+SYS_WTS
#include <muuo.h>
#include <uuosym.h>
#include <macsym.h>
#include <ctype.h>		/* For filename parser */
#endif

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

static int _dvtype P_((int osfd));
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	
#if SYS_T20+SYS_10X	
static int opensys P_((struct _ufile *uf,const char *path,int flags,int mode));
#endif 
#if SYS_T20+SYS_10X
static int get_jfn P_((char *path,int pflags,va_list ap));
static int o_gtjfn P_((char *path,int flags));
static int o_openf P_((struct _ufile *uf,int flags));
#endif 
#if SYS_T10+SYS_CSI+SYS_WTS	
static int opensys P_((struct _ufile *uf,const char *path,int flags,int mode));
static int chopen P_((struct _ufile *uf,struct _filehack *f,int flags));
static int o_lookup P_((struct _ufile *uf,struct _filehack *f));
static int o_enter P_((struct _ufile *uf,struct _filehack *f,int op));
static int o_crupd P_((struct _ufile *uf,struct _filehack *f));
static int o_out P_((struct _ufile *uf));
static int o_close P_((struct _ufile *uf,int bits));
static int o_open P_((struct _ufile *uf,struct _filehack *f,int op,int lertyp));
static int o_findeof P_((struct _ufile *uf));
static int ringinit P_((struct _ufile *uf,int iof,int nbufs,int bufsiz));
static void ringfree P_((struct _iobring *br));
static void flerset P_((struct _filehack *f,struct _filespec *fs,int lertyp));
static int ppnparse P_((struct _filespec *f,struct word6 *beg,struct word6 *end));
static int rjust6 P_((unsigned wd));
static int sixoct P_((unsigned wd));
static char *getwd6 P_((char *cp,struct word6 *wp));
static unsigned sixbit P_((char *s));
#endif 
#if SYS_ITS	
static int opensys P_((struct _ufile *uf,const char *path,int flags,int mode));
static void cvt_filename P_((char *from,char *to));
#endif 
#endif 

#undef P_

#define WORD_BIT (sizeof(int)*CHAR_BIT)		/* Generality never hurts */

#if SYS_T20
#define PROGPOST ".EXE"		/* Postfix for executables */
#define DIRPOST ".DIRECTORY.1"	/* Postfix for directory files */

#elif SYS_10X
#define PROGPOST ".SAV"		/* Postfix for executables */

#elif SYS_T10+SYS_CSI
#define PROGPOST ""		/* Postfix for executables */

#elif SYS_WTS
#define PROGPOST ".DMP"		/* Postfix for executables */
#endif

/* Default internal terminal structure, used to initialize _tty structs. */
#define ctl(a) (a&037)
static struct _tty _deftty = {
	NULL, 0,		/* Zero UF ptr ensures more initialization */
#if SYS_T20+SYS_10X
	0, 0, 0, 0,				/* Various T20 words */
	{-1,-1,'\177',ctl('U'),EVENP|ODDP|CRMOD|ECHO},	/* sgtty */
	{-1, -1, ctl('Q'), ctl('S'), ctl('Z'), -1},	/* tchars */
	NTTYDISC, LCRTBS|LCRTERA|LCRTKIL|LCTLECH,	/* line disc, mode */
	{ctl('C'),ctl('C'),ctl('R'),ctl('O'),ctl('W'),ctl('V')}	/* ltchars */

#elif SYS_T10+SYS_CSI
	0,					/* T10: UDX # (.UXTRM+nnn) */
	{-1,-1,'\177',ctl('U'),EVENP|ODDP|CRMOD|ECHO},	/* sgtty */
	{-1, -1, ctl('Q'), ctl('S'), ctl('Z'), -1},	/* tchars */
	NTTYDISC, 0,					/* line disc, mode */
	{ctl('C'),ctl('C'),ctl('R'),ctl('O'),-1,-1}	/* ltchars */

#else	/* Defaults as per BSD UNIX */
	/* 0, 0, 0, 0,	 No T20/10X words */
	{B9600, B9600, '#', '@', CRMOD|ECHO},
	{'\177', ctl('\\'), ctl('Q'), ctl('S'), ctl('D'), -1},
	OTTYDISC, 0,
	{ctl('Z'),ctl('Y'),ctl('R'),ctl('O'),ctl('W'),ctl('V')}
#endif
};

int
creat(path, mode)
const char *path;
mode_t mode;
{
    return open(path, (O_WRONLY | O_CREAT | O_TRUNC), mode);
}

int
#ifdef __STDC__
open(const char *path, int flags, ...)
#else
open(path, flags, mode)
const char *path;
int flags, mode;
#endif
{
#ifdef __STDC__
    va_list ap;
    int mode;
#endif
    struct _ufile *uf;
    int fd, err;

    USYS_BEG();
    if ((fd = _uiofd()) == -1 || !(uf = _ufcreate()))
	USYS_RETERR(EMFILE);	/* Failed to get FD slot or UF struct */
#ifdef __STDC__
    if (flags & O_CREAT) {
      va_start(ap, flags);
      mode = va_arg(ap, int);
      va_end(ap);
    }
    else mode = 0;
#endif
    if (err = opensys(uf, path, flags, mode)) {
	uf->uf_nopen = 0;	/* Release uf quietly */
	USYS_RETERR(err);	/* Failed somehow */
    }
    _openuf(fd, uf, flags);	/* Set up UF with given flags */
    USYS_RET(fd);
}

/* _OPENUF - Auxiliary used by _runtm(), open(), pipe() to share common code.
**	uf_ch and uf_flgs must already be set.
**	uf_buf is either NULL or points to an allocated buffer for re-use.
**		(Currently it must always be NULL!)
**	Sets:
**		uf_flgs (OR'd in)
**		uf_type
**		uf_dnum
**		uf_buf
**		uf_cp
**		uf_cnt
**		uf_pos
**		uf_eof
**		uf_nopen
**		uf_zcnt (on ITS)
*/
void
_openuf(fd, uf, flags)
int fd;
struct _ufile *uf;
int flags;
{
    /* Set up UF mapping for the FD! */
    USYS_VAR_REF(uffd[fd]) = uf;

    /* Set various default values if nothing's already there. */
    if (!(uf->uf_flgs&(UIOF_READ|UIOF_WRITE))) {	/* Set R/W flags */
	if (flags & O_RDWR) uf->uf_flgs |= (UIOF_READ | UIOF_WRITE);
	else uf->uf_flgs |= ((flags & O_WRONLY) ? UIOF_WRITE : UIOF_READ);
    }
    if (flags & O_NDELAY) uf->uf_flgs |= UIOF_NDELAY; /* Set Non-blocking */
    if (!uf->uf_bsize) {
      int acs[5];

      acs[1] = uf->uf_ch;
      if (jsys(RFBSZ, acs)) uf->uf_bsize = acs[2];
      else uf->uf_bsize = CHAR_BIT;
    }
    if (!uf->uf_nbpw) uf->uf_nbpw = WORD_BIT / uf->uf_bsize;
    if (uf->uf_type < 0)		/* Get UIO_DVxxx device type */
	uf->uf_type = _dvtype(uf->uf_ch);

    /* See if device can hang waiting for input or not.  This should be
    ** system-dependent, actually.
    */
    if (uf->uf_type != UIO_DVDSK)	/* If not disk device, */
	uf->uf_flgs |= UIOF_CANHANG;	/* say input hangage possible */

    if (uf->uf_type == UIO_DVTTY) {	/* If TTY, fix up device number */
	int i;

	USYS_LOCK(USYS_VAR_REF(uflock)); /* Claim interlock */
	if (uf->uf_ch == UIO_CH_CTTRM) /* Always use 0 for control TTY */
	    i = 0;
	else {				/* If a random TTY, pick another */
	    for (i = 1; USYS_VAR_REF(ttys[i].tt_uf) != NULL;)
		if (++i >= _NTTYS) {
		    USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
		    _panic("open() - opening too many terminal devices");
		}
	}

	/* i now has index into ttys[] */
	if (USYS_VAR_REF(ttys[i].tt_uf) == NULL) {
	    USYS_VAR_REF(ttys[i]) = _deftty; /* Initialize whole struct! */
	    USYS_VAR_REF(ttys[i].tt_uf) = uf; /* Point back to UF */
	}
	USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
	uf->uf_dnum = i;		/* Point to tty struct # */
#if SYS_T10
	/* Attempt to get UDX, ignore error for now (what else to do??) */
	if (uf->uf_ch == UIO_CH_CTTRM)
	    MUUO_ACVAL("TRMNO.", -1, &USYS_VAR_REF(ttys[i].tt_udx));
	else {
	    int ln = 0;
	    _KCCtype_char6 nam[6];
	    MUUO_ACVAL("DEVNAM", uf->uf_ch, (int *)nam); /* Get TTYnnn */
	    if (nam[3]) {			/* Figure line # from SIXBIT */
		ln = nam[3] - 020;
		if (nam[4]) {
		    ln = (ln<<3) + (nam[4] - 020);
		    if (nam[5]) {
			ln = (ln<<3) + (nam[5] - 020);
		    }
		}
	    }
	    USYS_VAR_REF(ttys[i].tt_udx) = uuosym(".UXTRM") + ln;
	}
#elif SYS_CSI			/* CSI did this one right */
	USYS_VAR_REF(ttys[i].tt_udx)< = XWD(-1, uf->uf_ch);
#endif
    }

    /* OK, all ready to go!  Set confirmation that UF is open. */
#ifdef _KCC_DEBUG
      if (`$DEBUG` & _KCC_DEBUG_UIO_FDSHR){
	_dbgl("OPEN&_openuf(fd ");
	_dbgd(fd);
	_dbgs(", uf ");
	_dbgd(uf-USYS_VAR_REF(uftab));
	_dbgs(") nopen=");
	_dbgd(uf->uf_nopen);
	_dbgs(", jfn=");
	_dbgj(uf->uf_ch);
	_dbgs(", mode=");
	if (uf->uf_flgs & UIOF_READ) _dbgs("R");
	if (uf->uf_flgs & UIOF_WRITE) _dbgs("W");
	if (uf->uf_flgs & UIOF_CONVERTED) _dbgs("C");
	_dbgd(uf->uf_bsize);
	_dbgs("\r\n");
      }
#endif
}

/* _UIOFD - Find a spare FD (File Descriptor).
**	Returns -1 if no more FD slots available.
**	Used by open(), pipe(), URT startup.
*/
int
_uiofd()
{
    int fd;

    for (fd = 0; fd < OPEN_MAX; fd++)
	if (!USYS_VAR_REF(uffd[fd]))
	    return fd;
    errno = EMFILE;
    return -1;
}

/* _UFCREATE - Find a spare UF slot and return pointer to it.
**	May return NULL if there are no free slots left.
**	Used by open(), pipe(), and URT startup.
**
**	On ITS, TOPS-10, and WAITS, the uf_ch value is automatically set
**	to a corresponding channel number from 0-017 inclusive, since there
**	is a one-to-one correspondence between UF number and channel number.
*/
struct _ufile *
_ufcreate()
{
    register int i;
    struct _ufile *uf;

    USYS_LOCK(USYS_VAR_REF(uflock)); /* Claim interlock */
    for (i = 0, uf = USYS_VAR_REF(uftab); uf->uf_nopen > 0; ++uf)
	if (++i > OPEN_UF_MAX) {
	    USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
	    errno = EMFILE;		/* No free slots, fail */
	    return NULL;
	}

    /* Found a free slot! */
    if (uf->uf_buf)			/* Paranoia check; close() always */
	_panic("_ufcreate: unreleased IOB");	/* frees any buffers. */
    memset((char *)uf, 0, sizeof(*uf));	/* Clear UF struct completely! */
    uf->uf_nopen++;			/* Claim this uf */
    USYS_UNLOCK(USYS_VAR_REF(uflock));	/* Release interlock */

    uf->uf_type = -1;		/* Device type unknown */
    uf->uf_flen = -1;		/* File length unknown */

#if SYS_ITS	/* On ITS, store correct SYSCALL argument for channel */
    uf->uf_ch = SC_IMM(i);
#elif SYS_T10+SYS_CSI+SYS_WTS
    uf->uf_ch = i;		/* Just use plain channel # */
#endif
    return uf;
}

/* _UIOBUF - Set up buffer for a UF
**	uf_bsize and uf_nbpw must already be set.
**	Also used by read().
*/
int
_uiobuf(uf)
register struct _ufile *uf;
{
    if (!uf->uf_buf) {
	if (!(uf->uf_buf = _iobget())) {
	    errno = EMFILE;		/* Too many open files */
	    return 0;
	}
	switch (uf->uf_bsize) {
	case 7:
	    uf->uf_bpbeg = (char*)(int)(_KCCtype_char7*)(uf->uf_buf->b_data);
	    uf->uf_blen = uf->uf_nbpw
			* sizeof(uf->uf_buf->b_data)/sizeof(int); /* # wds */
	    break;
	case 8:
	    uf->uf_bpbeg = (char*)(int)(_KCCtype_char8*)(uf->uf_buf->b_data);
	    uf->uf_blen = uf->uf_nbpw
			* sizeof(uf->uf_buf->b_data)/sizeof(int); /* # wds */
	    break;
	case 9:
	default:
	    uf->uf_bpbeg = uf->uf_buf->b_data;
	    uf->uf_blen = sizeof(uf->uf_buf->b_data);
	    break;
	}
    }
    return 1;
}

/* _DVTYPE(osfd) - Get device type
*/
static int
_dvtype(osfd)
int osfd;
{
#if SYS_T20+SYS_10X
    int ablock[5];

    ablock[1] = osfd;		/* JFN */
    return jsys(DVCHR, ablock) > 0 ? FLDGET(ablock[2], monsym("DV%TYP")) : -1;

#elif SYS_ITS
    unsigned status;

    SYSCALL2_LOSE("status", osfd, SC_VAL(&status)); /* can't fail */
    switch (status & 077) {
	case 000:
	case 001:
	case 002:
	    return UIO_DVTTY;
	case 060:
	case 061:
	    return UIO_DVUSR;
	default:
	    return UIO_DVDSK;
    }
#elif SYS_T10+SYS_CSI+SYS_WTS
    int ret;

    if (osfd == UIO_CH_CTTRM)		/* Special case */
	return UIO_DVTTY;
    MUUO_ACVAL("DEVCHR", osfd, &ret);
    if (ret) {
	if (ret & uuosym("DV.DSK")) return UIO_DVDSK;
	if (ret & uuosym("DV.TTY")) return UIO_DVTTY;
    }
    return -1;

#if 0	/* Old code for TOPS-10; doesn't work on CSI or WAITS, so flushed */
    int ret;

    if (osfd == UIO_CH_CTTRM)		/* Special case */
	return UIO_DVTTY;
    if (MUUO_ACVAL("DEVTYP", osfd, &ret) > 0 && ret)
	return FLDGET(ret, uuosym("TY.DEV"));
    return -1;
#endif

#else
    return -1;
#endif
}

#if SYS_T20+SYS_10X	/* TOPS-20/TENEX OS-dependent file opening code */
extern int _jchmod();	/* Routine to change mode of file */

extern int _gtfdb();		/* used by various routines, defined in stat */

static int o_gtjfn();		/* lowest level gtjfn, which does the GTJFN% */

static int o_openf();		/* Call OPENF% */

/* OPENSYS for TOPS-20/TENEX
*/
static int
opensys(uf, path, flags, mode)
struct _ufile *uf;
const char *path;
int flags, mode;
{
    int jfn;

    if (flags & O_SYSFD) {
	jfn = (int) path;	/* "path" is actually JFN. */
    } else {
	errno = 0;
	if (!(jfn = _gtjfn(path, flags))) {
	    if (!errno) errno = ENOENT;
	    return errno;	/* Failed to get JFN for file */
	}
    }
    uf->uf_ch = jfn;		/* Store the JFN */
/*
 *	check to see if this is an old file, or a new one.  if FB_NXF
 *	is set then the file is new and doesn't exist (until closed)
 *	If new file, set mode.
 */

    if (!(_gtfdb(jfn, _FBCTL) & FB_NXF))
	uf->uf_flgs |= UIOF_OLD;
    else if ((flags & O_CREAT) && !(flags & O_T20_DEF_MODE)) {
      if (!(_gtfdb(jfn, monsym(".FBGNL")))) /* If no previous gen, */
        _jchmod(jfn, mode);	/* Set mode (includes <umask) */
      }
/*
 *	now open the file
 */
    if (errno = o_openf(uf, flags)) {
	if ((flags&O_SYSFD)==0)	/* Failed, release the JFN if we created one */
	    _rljfn(jfn);
	return errno;		/* and lose-return */
    }

    if (flags & O_APPEND) {	/* for append file, read starting position */
	int ablock[5];
	ablock[1] = uf->uf_ch;
	uf->uf_pos = (jsys(RFPTR, ablock)) ? ablock[2] : 0;
    }
    return 0;			/* Won, return without error! */
}
#endif /* SYS_T20+SYS_10X */

#if SYS_T20+SYS_10X
/*
 *	Get a JFN on a pathname.
 *	This is the routine that converts Unix-style pathnames into
 *	T20 filenames.
 */

/*
 *	do the real work of finding a file
 */

#define ROOTDR "ROOT-DIRECTORY"
#define ROOTDRL (sizeof(ROOTDR) - 1)

static int get_jfn(path, pflags, ap)
char *path;
int pflags;
va_list ap;
{
    int jfn, bits;
    int flags;
    int dodir;

    flags = va_arg(ap, int);
    dodir = va_arg(ap, int);

    if (dodir) {
      char *p, *pe;

      p = path + (strlen(path) - 1);
      if (*p != '>') {
	errno = EINVAL;
	return 0;
      }
      pe = p;			/* Save pointer to null */
      *p-- = '\0';		/* Remove directory terminator */

      while ((p != path)
	     && (((*p != '.') && (*p != '<')) || (p[-1] == '\026'))) p--;
      if (p == path) {
	errno = EINVAL;
	return 0;
      }

      if (*p == '<') {
	do pe[ROOTDRL+1] = *pe; while (--pe != p);
	p++;
	strcpy(p, ROOTDR);
	p += ROOTDRL;
      }
      *p = '>';
      strcat(p, DIRPOST);
    }
    
    bits = (pflags & _PARSE_OUT_TMP) ? monsym("GJ%TMP") : 0;
    if (flags & (O_RDWR | O_WRONLY | O_APPEND)) {
      /*
 *	Normally we always create a new version for writing.
 *	The O_T20_WROLD flag exists in order to override this and
 *	act like UNIX if such behavior is ever desirable (ugh).
 *	Note that if O_APPEND or O_RDWR is set, we always look
 *	for an existing file first.
 */
	if (!(flags & (O_APPEND | O_RDWR | O_T20_WROLD)))
	    jfn = o_gtjfn(path, GJ_FOU | bits);
	else if (jfn = o_gtjfn(path, GJ_OLD | bits)) {
	    if ((flags & O_CREAT) && (flags & O_EXCL)) {
		_rljfn(jfn);
		errno = EEXIST;
		return 0;
	   }
	} else {
	  if (!(flags & O_CREAT)) {
	    errno = EINVAL;
	    return 0;
	  }
	  jfn = o_gtjfn(path, GJ_FOU | bits);
	}
    }
    else
      jfn = o_gtjfn(path, GJ_OLD | ((flags & O_T20_WILD) ? GJ_IFG : 0) | bits);
    if (jfn && dodir && !(_gtfdb(jfn, _FBCTL) & FB_DIR)) {
      _rljfn(jfn);
      errno = ENOENT;
      return 0;
    }
    return jfn;
}

int _gtjfn(path, flags)
const char *path;
int flags;
{
    char epath[MAXPATHLEN];
    int ret;

    ret = _parse(path, 0, get_jfn, flags, 0);
#ifdef PROGPOST
    if (!ret && !(flags & (O_RDWR | O_WRONLY | O_APPEND))
	&& (_urtsud.su_path_in_type != _URTSUD_PATH_IN_NATIVE)) {
      strcpy(epath, path);
      strcat(epath, PROGPOST);
      ret = _parse(epath, 0, get_jfn, flags, 0);
    }
#endif
#ifdef DIRPOST
    if (!ret && !(flags & (O_RDWR | O_WRONLY | O_APPEND | O_T20_NO_DIR))
	&& (_urtsud.su_path_in_type != _URTSUD_PATH_IN_NATIVE)) {
      ret = _parse(path, _PARSE_IN_DIR, get_jfn, flags, 1);
    }
#endif
    return ret;
}

/*
 *	lowest level actual GTJFN% call
 */

static int o_gtjfn(path, flags)
char *path;
int flags;
{
    int acs[5];
    char *p;

    acs[1] = GJ_SHT | flags;
    acs[2] = (int)(path - 1);
    if (jsys(GTJFN, acs)) {
      p = (char *)acs[2];
      if (!*p) return acs[1];	/* Verify that entire name parsed */
      _rljfn(acs[1]);		/* Else release JFN */
      errno = EINVAL;		/* Return invalid argument error */
    }
    else switch (acs[1]) {
    case monsym("GJFX16"):	/* No such device */
    case monsym("GJFX17"):	/* No such directory name */
    case monsym("GJFX18"):	/* No such filename */
    case monsym("GJFX19"):	/* No such file type */
    case monsym("GJFX20"):	/* No such generation number */
    case monsym("GJFX21"):	/* File was expunged */
    case monsym("GJFX24"):	/* File not found */
    case monsym("GJFX32"):	/* No files match this specification */
      errno = ENOENT;		/* No such file or directory */
      break;

    case monsym("GJFX22"):	/* Insufficient system resources (Job */
				/* Storage Block full) */
     errno = ENFILE;		/* File table overflow */
     break;

    case monsym("GJFX23"):	/* Exceeded maximum number of files */
				/* per directory */
    case monsym("IOX34"):	/* Disk full */
     errno = ENOSPC;		/* No space left on device */
     break;

    case monsym("GJFX27"):	/* File already exists (new file required) */
     errno = EEXIST;		/* File exists */
     break;

    case monsym("GJFX35"):	/* Directory access privileges required */
     errno = EACCES;		/* Permission denied */
     break;

    case monsym("GJFX28"):	/* Device is not on-line */
    case monsym("GJFX38"):	/* File not found because output-only */
				/* device was specified */
    case monsym("DESX9"):	/* Invalid operation for this device */
    case monsym("STRX09"):	/* Prior structure mount required */
     errno = ENXIO;		/* No such device or address */
     break;

    case monsym("GJFX36"):	/* Internal format of directory is incorrect */
    case monsym("IOX35"):	/* Unable to allocate disk - structure */
				/* damaged */
     errno = EIO;		/* I/O error */
     break;

    case monsym("IOX11"):	/* Quota exceeded */
     errno = EDQUOT;		/* Disc quota exceeded */
     break;

    default:
      errno = EINVAL;		/* Invalid argument */
      break;
    }
    return 0;			/* And return error */
}

#define old_file(uf)	(uf->uf_flgs & UIOF_OLD)
#define new_file(uf)	(!(uf->uf_flgs & UIOF_OLD))

static int
o_openf(uf, flags)
struct _ufile *uf;
int flags;
{
    int byte_size;
    int open_mode = 0;
    int isdir;
    int acs[5];

/*
 *	convert file.h flags into OPENF% bit flags
 */
    switch (flags & (O_RDONLY | O_WRONLY | O_RDWR | O_APPEND)) {
	case (O_WRONLY | O_APPEND):
	case O_APPEND:	open_mode = OF_APP; break;
	case O_WRONLY:	open_mode = OF_WR; break;
	case O_RDWR:	open_mode = OF_RD | OF_WR | OF_PLN; break;
	case (O_RDWR | O_APPEND):
			open_mode = OF_RD | OF_WR | OF_APP | OF_PLN; break;
	default:	open_mode = OF_RD | OF_PLN; break;
    }
/*
 *	you can't open an existing file for write-only (not read-write),
 *	and not have it be truncated.  sorry, kids.
 */
    if (old_file(uf) && (open_mode == OF_WR) && !(flags & O_TRUNC)
	&& _dvtype(uf->uf_ch) == _DVDSK)
	return ETRUNC;			/* new T20 error code! */
/*
 *	to avoid truncating an existing file, you need to open it in
 *	r/w mode, even if you just want write.
 */
    if (old_file(uf) && !(flags & (O_TRUNC | O_APPEND)))
	open_mode |= OF_RD;
/*
 *	If existing file and OF_RD or OF_APP are set and O_TRUNC
 *	was requested, we must truncate manually.
 */
    if (old_file(uf) && (open_mode & (OF_APP | OF_RD)) && (flags & O_TRUNC)) {
	acs[1] = (_FBSIZ << 18) | uf->uf_ch; /* FDB Offset,,JFN */
	acs[2] = 0777777777777;		/* change whole word */
	acs[3] = 0;			/* set to 0 */
	if (!jsys(CHFDB, acs))		/* change EOF to 0 */
	    return ETRUNC;
    }
/*
 *	If a byte size is explicitly requested, use that.
 *	Otherwise:
 *		for a new file, use 9 if O_BINARY, else 7.
 *		for an old file, use the file bytesize.
 *			A size of 0 or 36 is handled as for a new file.
 *			Any other size is simply used - if this is not
 *			one of 7, 8, or 9 then the results are unpredictable.
 */
    switch (flags & O_BSIZE_MASK) {
	case O_BSIZE_7: byte_size = 7; break;
	case O_BSIZE_8: byte_size = 8; break;
	case O_BSIZE_9: byte_size = 9; break;
	default:	/* Error, but nothing we can do about it now. */
	case 0:
	    if (new_file(uf))
		byte_size = (flags & O_BINARY) ? 9 : 7 ;
	    else {
		byte_size = (_gtfdb(uf->uf_ch,_FBBYV) << FBBSZ_S) & FBBSZ_M;
		if (byte_size == 0 || byte_size == 36)
		    byte_size = (flags & O_BINARY) ? 9 : 7;
	    }
    }
    uf->uf_bsize = byte_size;			/* save for posterity */

    isdir = (_gtfdb(uf->uf_ch, _FBCTL) & FB_DIR);

/*	Open in thawed mode if requested, or if directory */
    if ((flags & O_T20_THAWED) || isdir)
      open_mode |= OF_THW;	/* thawed access? */
/*
 *	if they explicitly request converted i/o, then propagate the flag,
 *	else if they DIDN'T explicitly request UNconverted (e.g. it's up to
 *	us to decide), and the file is being opened for text in 7-bit bytes,
 *	then go for conversion.
 */
    if ((flags & O_CONVERTED) ||
	(byte_size == 7 && !(flags & (O_UNCONVERTED | O_BINARY))))
	uf->uf_flgs |= UIOF_CONVERTED;

    acs[1] = uf->uf_ch;
    acs[2] = (byte_size << 30) + open_mode;
    if (!jsys(OPENF, acs)) {
	switch (acs[0]) {		/* Open failed */
	case monsym("OPNX1"):
	case monsym("OPNX9"):
		return EBUSY;
	case monsym("OPNX13"):		/* Invalid access requested */
	case monsym("OPNX14"):		/* Invalid mode requested */
		if (isdir)		/* If directory, */
		  return EISDIR;	/* Say that is the reason */
					/* Else fall into EACCESS */
	case monsym("OPNX3"):
	case monsym("OPNX4"):
	case monsym("OPNX5"):
	case monsym("OPNX6"):
	case monsym("OPNX12"):
	case monsym("OPNX15"):
	case monsym("OPNX25"):
		return EACCES;
	case monsym("OPNX7"):
		return EPERM;
	case monsym("OPNX8"):
	case monsym("TTYX01"):
		return ENXIO;
	case monsym("OPNX10"):
		return ENOSPC;
	case monsym("OPNX26"):
	case monsym("DESX1"):
	case monsym("DESX3"):
	case monsym("DESX4"):
	case monsym("DESX7"):
	case monsym("SFBSX2"):
		return EINVAL;
	case monsym("OPNX16"):
		return EIO;
	case monsym("OPNX17"):
		return ENFILE;
	case monsym("OPNX18"):
		return ENODEV;
	case monsym("OPNX23"):
		return EDQUOT;
	}
	return ENOENT;			/* Default to no file */
    }

    /* We won!  Now do special hack if dealing with a new file -- we
    ** quickly close and then re-open it, so that the file will then
    ** actually exist and can be seen by access(), stat(), GTFDB%, and
    ** everything else.  This compensates for the T20 braindamage where
    ** a new file doesn't really exist (certainly not permanently) until
    ** it is CLOSF%'d.
    **
    ** RPH 11/19/92 Changed to use UFPGS instead of CLOSF/OPENF
    **		    This avoids the problem of not being able to re-open
    **		    the file the second time due to protection.
    */
    if (new_file(uf)) {
	acs[1] = (uf->uf_ch << 18); /* jfn,,0 */
	acs[2] = monsym("UF%NOW"); /* actual update may be defered  */
	(void)jsys(UFPGS, acs); /* ignore failure */
    }
    return 0;
}
#endif /* SYS_T20+SYS_10X */

#if SYS_T10+SYS_CSI+SYS_WTS	/* TOPS-10/WAITS OS-dependent file opening code */

/* OPENSYS for TOPS-10/WAITS/CSI
*/
static int chopen(), ringinit();
static int o_lookup(), o_enter(), o_crupd(), o_out(), o_close();
static int o_open(), o_findeof();
static void flerset(), ringfree();

static int
opensys(uf, path, flags, mode)
struct _ufile *uf;
const char *path;
int flags, mode;
{
    int err, devbits;
    int rwflag = 0;		/* R/W flags */
    int nbufs, bufsiz;
    struct _filehack f;

    /* Check out flags */
    switch (flags & (O_RDONLY | O_WRONLY | O_RDWR)) {
	case O_RDONLY:		/* Can read */
	    rwflag = UIOF_READ;
	    break;
	case O_WRONLY:		/* Can write */
	    rwflag = UIOF_WRITE;
	    break;
	case O_RDWR:
	    rwflag = UIOF_READ | UIOF_WRITE;
	    break;
	default:		/* Shouldn't happen */
	    return EINVAL;
    }
    if (!(rwflag & UIOF_WRITE))		/* If not writing, then ignore */
	flags &= ~(O_CREAT|O_TRUNC|O_APPEND|O_EXCL);	/* these flags */
    uf->uf_flgs |= rwflag | ((flags & O_APPEND) ? UIOF_APPEND : 0);	

    /* Now check bytesize, if any given */
    switch (flags & O_BSIZE_MASK) {
	case O_BSIZE_7: uf->uf_bsize = 7; break;
	case O_BSIZE_8: uf->uf_bsize = 8; break;
	case O_BSIZE_9: uf->uf_bsize = 9; break;
	case 0:		uf->uf_bsize = (flags & O_BINARY) ? 9 : 7; break;
	default: return EINVAL;		/* Bad arg */
    }
    uf->uf_nbpw = WORD_BIT / uf->uf_bsize;

    /* Decide whether to use converted I/O */
    if ((flags & O_CONVERTED) ||
	(uf->uf_bsize == 7 && !(flags & (O_UNCONVERTED | O_BINARY))))
	uf->uf_flgs |= UIOF_CONVERTED;

    /* Now attempt to parse the pathname */
    if (err = _fparse(&f.fs, path))
	return err;		/* Ugh, failed somehow */

    /* Parse won, set up other vars so we can OPEN device. */
    if (!(f.filop.fo_dev = f.fs.fs_dev))	/* If no device given, */
	f.filop.fo_dev = _SIXWRD("DSK");	/* use DSK: as default. */
    MUUO_ACVAL("DEVCHR", f.filop.fo_dev, &devbits);	/* Get dev bits */
    if (devbits == 0)
	return ENODEV;			/* Fail - "no such device" */

    if (devbits & uuosym("DV.DSK")) {
	/* Disk device gets special handling */
	uf->uf_type = UIO_DVDSK;
	uf->uf_flgs |= UIOF_BLKDEV;		/* Say block device */
	/* Decide whether we'll need dump mode or not (see t10io.doc!) */
	if ((rwflag&UIOF_WRITE)			/* Never if not writing */
	  && ( (rwflag&UIOF_READ)		/* Doing R/W (update) */
	    || !(flags&(O_CREAT|O_TRUNC|O_APPEND))	/* Special case 1 */
	    || !(flags&(O_TRUNC|O_APPEND|O_EXCL)) )) {	/* Special case 2 */
	    f.filop.fo_ios = uuosym(".IODMP");
	    f.filop.fo_brh = 0;			/* No buffer rings */
	    nbufs = 0;
	} else {				/* Plain R or W */
	    f.filop.fo_ios = uuosym(".IOIMG");
	    nbufs = 2;				/* Want 2 buffers */
	    bufsiz = UIO_T10_DSKWDS+3;		/* of this size */
	}
    } else {			
	/* Random device, probably TTY or something */
	f.filop.fo_ios = uuosym(".IOASL");	/* Use this in case terminal */
#if SYS_T10+SYS_CSI
	if (!MUUO_ACVAL("DEVSIZ", &f.filop.fo_ios, &bufsiz))
	    bufsiz = XWD(2,UIO_T10_DSKWDS+3);
	if (bufsiz <= 0)		/* If no such device or bad mode */
	    return ENXIO;		/* "no such device or address" */
	nbufs = FLDGET(bufsiz, _LHALF);	/* Get desired # buffers */
	bufsiz &= _RHALF;
#elif SYS_WTS
	WTSUUO_ACVAL("BUFLEN", f.filop.fo_dev, &bufsiz);
	if (bufsiz <= 0) bufsiz = UIO_T10_DSKWDS+1;
	bufsiz += 2;			/* Canonicalize to T10 value */
	nbufs = 2;
#endif
	if (bufsiz > (UIO_T10_DSKWDS+3))	/* Don't exceed our max */
	    bufsiz = UIO_T10_DSKWDS+3;		/* too big, use our max. */
    }

    /* Point to buffer rings we'll use if LOOKUP/ENTER succeeds. */
    if (nbufs) {
	f.filop.fo_brh = XWD(
		(rwflag&UIOF_WRITE ? (int)&uf->uf_boring : 0),
		(((rwflag&UIOF_READ) || (flags&O_APPEND))
				   ? (int)&uf->uf_biring : 0)
		);
    }

    if (err = chopen(uf, &f, flags))	/* Open the channel! */
	return _opnrel(uf), err;

    /* We won, channel is open!  Must now set up buffering, bletch.
    ** Note that input side may have been opened even if user didn't ask
    ** for it, in order to read last block.
    */
    if (nbufs == 0) {
	/* Using dump mode, set up just 1 buffer. */
	if (!_uiobuf(uf))
	    return _opnrel(uf), errno;
    } else {
	if (uf->uf_flgs&(UIOF_READ|UIOF_OREAD)) {
	    if (err = ringinit(uf, UIOF_READ, nbufs, bufsiz))
		return _opnrel(uf), err;
	}
	if (rwflag&UIOF_WRITE) {
	    if (err = ringinit(uf, UIOF_WRITE, nbufs, bufsiz))
		return _opnrel(uf), err;
	}
    }

    /* See whether to find true EOF or not (only applicable to block devs).
    ** For simplicity we always do this, even if read-only.  The alternative
    ** would be to set some flag for checking the last block when it's
    ** finally encountered during a read.
    */
    if (uf->uf_flgs & UIOF_BLKDEV) {
	if (err = o_findeof(uf))		/* Find true file EOF */
	    return _opnrel(uf), err;
	/* If write-only, buffered, and appending,
	** then we've got to preload the last block before closing the
	** input side of the channel!  After reading it in, it needs to
	** be copied into the output buffer.  All the flags will already
	** have been set correctly, however.
	*/
	if (nbufs && (uf->uf_flgs&UIOF_APPEND)
	  && !(uf->uf_flgs&UIOF_READ)
	  && uf->uf_flen > 0) {		/* Can also skip if file empty */
	    char *cp;
	    uf->uf_pos = uf->uf_flen;		/* Seek to EOF */
	    if (!_blkprime(uf, 0)		/* and ensure block read! */
	      || !(cp = uf->uf_boring.br_bp))	/* Get ptr to output blk */
		return _opnrel(uf), EIO;
	    /* Note bump of CP prior to use.  This is important! */
	    memcpy(++cp, uf->uf_bpbeg, uf->uf_blen);	/* Copy to out blk! */
	    uf->uf_bpbeg = cp;			/* This is new buffer start */
	}
	/* Clean up after seeks etc so initial pos always 0 even if
	** current block is somewhere else.
	*/
	uf->uf_pos = 0;
	uf->uf_rleft = uf->uf_wleft = uf->uf_eof = 0;
    }

    /* If a user mode doesn't allow reading but we still have channel open
    ** for input, close the input side.  This can happen when setting
    ** things up for O_APPEND to a write-only file.
    ** Avoid doing so if using dump mode (to leave the 2 special cases alone).
    */
    if (nbufs && !(uf->uf_flgs&UIOF_READ) && (uf->uf_flgs&UIOF_OREAD)) {
	o_close(uf, uuosym("CL.OUT"));	/* Close input side of chan */
	ringfree(&uf->uf_biring);
    }

    /* Everything's OK, last thing is to remember the filespec we used
    ** to open this channel, so fstat() has a chance at doing something
    ** useful.  TOPS-10 has almost no ways of interrogating channel status!
    */
    uf->uf_fs = f.fs;		/* Copy filespec info directly */
    return 0;			/* Won, return without error! */
}

/* CHOPEN - Open TOPS-10 I/O channel as per flags.
**	The "OPEN" block (starting at f->filop.fo_ios) is already set up.
**	Returns 0 on success, else error code.
**	Sets uf_flen to file size (rounded up to words).
**	Sets UIOF_OREAD if channel still open for reading.
*/
static int
chopen(uf, f, flags)
struct _ufile *uf;
struct _filehack *f;
{
    int err;

    if (flags & O_CREAT) {	/* Create file if doesn't exist? */
	if (flags & O_EXCL) {	/* Error if file exists? */
	    if (o_lookup(uf, f)==0)
		return EEXIST;			/* Error - File exists */
	    if (uf->uf_flgs & UIOF_READ)	/* Doesn't exist, reading? */
		return o_crupd(uf, f);		/* Update a new file! */
	    else return o_enter(uf, f, _FOWRT);	/* Write a new file! */
	}
	if (flags & O_TRUNC) {	/* Truncate if file exists? */
	    if (uf->uf_flgs & UIOF_READ)	/* Doesn't exist, reading? */
		return o_crupd(uf, f);		/* Update a new file! */
	    else return o_enter(uf, f, _FOWRT);	/* Write a new file! */
	}
	if (uf->uf_flgs & UIOF_READ) {		/* R/W? */
/* fix up (ineff) */
	    if (o_lookup(uf, f)!=0)		/* R/W with C */
		return o_crupd(uf, f);		/* Create if doesn't exist */
	    return o_enter(uf, f, _FOSAU);	/* Now get W */
	}

	/* Just writing (with create if file non-ex) */
	if (o_lookup(uf, f)!=0)
	    return o_enter(uf, f, _FOWRT);	/* Non-ex, write new file */
	return o_enter(uf, f, _FOSAU);	/* Open for update, caller closes R */
    }

    /* Not creating, file must exist. */
    if (err = o_lookup(uf, f))
	return err;			/* Doesn't exist, fail */
    if (!(uf->uf_flgs & UIOF_WRITE))	/* If just reading, that was all! */
	return 0;
    if (flags & O_TRUNC) {		/* Truncate existing? */
	o_close(uf, 0);			/* Yes, close chan */
	uf->uf_flen = -1;		/* Forget about length */
	if (uf->uf_flgs & UIOF_READ)	/* Reading too? */
	    return o_crupd(uf, f);	/* Update a new file! */
	return o_enter(uf, f, _FOWRT);	/* Supersede existing file */
    }

    /* Writing existing file, no truncate. */
    return o_enter(uf, f, _FOSAU);	/* File exists, open for update */
}

static int
o_lookup(uf, f)
struct _ufile *uf;
struct _filehack *f;
{
    int len;

#if SYS_WTS
    if (len = o_open(uf, f, _FORED, LER_OLD))	/* Read, old-style LER block */
	return len;			/* Failed, return error */
    len = f->orb.s.rb_ppn;		/* Get word with length in LH */
    len >>= WORD_BIT/2;			/* Get signed LH */
    if (len > 0) len = -len;		/* Neg means # words */
    else len *= UIO_DSKWDS;		/* Pos means # blocks (ugh) */
#else
    if (len = o_open(uf, f, _FORED, LER_RBSIZ))	/* Read, new extended LER block */
	return len;			/* Failed, return error */
    len = f->xrb.s.rb_siz;		/* Get word with length in it */
#endif
    uf->uf_flen = uf->uf_nbpw * len;	/* Get file length in bytes */
    uf->uf_flgs |= UIOF_OREAD;		/* Say opened for reading! */
    return 0;
}

static int
o_enter(uf, f, op)
struct _ufile *uf;
struct _filehack *f;
{
    int err;
    if (err = o_open(uf, f, op, LER_OLD))	/* Write, old-style LER block */
	return err;
    if (uf->uf_flen < 0)		/* Won!  If length not already set, */
	uf->uf_flen = 0;		/* just make it 0 */
    return 0;
}

static int
o_crupd(uf, f)
struct _ufile *uf;
struct _filehack *f;
{
    int err;
    if (err = o_open(uf, f, _FOWRT, LER_OLD)) /* First create empty file */
	return err;
    /* Let's hope an OUT is unnecessary to create 0-length file! */
    o_close(uf, 0);
    if (err = o_open(uf, f, _FOSAU, LER_OLD))	/* Now re-open */
	return err;
    uf->uf_flen = 0;			/* Won, length known to be 0! */
    return 0;
}

static int
o_out(uf)
struct _ufile *uf;
{
    if (!_filopuse)
	return !MUUO_IO("OUT", uf->uf_ch, 0);
    else {
	int argblk = XWD(uf->uf_ch, uuosym(".FOOUT"));
	return MUUO_AC("FILOP.", XWD(1,(int)&argblk));
    }
}

/* O_CLOSE - Close channel, but don't release it; leaves UIOF_OCHAN set.
*/
static int
o_close(uf, bits)
struct _ufile *uf;
{
    struct _foblk fo;

    uf->uf_flgs &= ~UIOF_OREAD;		/* Will no longer be open for read */
    if (!_filopuse)
	return MUUO_IO("CLOSE", uf->uf_ch, bits);
    fo.fo_chn = uf->uf_ch;
    fo.fo_fnc = uuosym(".FOCLS");
    fo.fo_ios = bits;
    return MUUO_AC("FILOP.", XWD(2,(int)&fo));
}

static int
o_open(uf, f, op, lertyp)
struct _ufile *uf;
struct _filehack *f;
{
    int ret;

    f->error = -1;

    if (!_filopuse) {			/* Old-style UUOs */
	int rbadr;

	/* Must ensure device is OPENed, sigh */
	if (!(uf->uf_flgs&(UIOF_OREAD|UIOF_OCHAN))	/* If needed, */
	  && !MUUO_IO("OPEN", uf->uf_ch, &f->filop.fo_ios)) {	/* open dev! */
	    return ENXIO;		/* "No such device or address" */
	}
	uf->uf_flgs |= UIOF_OCHAN;	/* Remember channel opened */
	rbadr = (lertyp == LER_OLD)	/* Old or extended lookup blk */
			? (int)&f->orb : (int)&f->xrb;
	ret = 1;
	if ((op == _FORED || op == _FOSAU)	/* Read or update */
	  && !(uf->uf_flgs&UIOF_OREAD)) {	/* and not already open? */
	    flerset(f, &f->fs, lertyp);		/* Set up LER block */
	    if (ret = MUUO_IO("LOOKUP", uf->uf_ch, rbadr)) {
		uf->uf_flgs |= UIOF_OREAD;
	    }
	}
	if (ret && (op == _FOWRT || op == _FOSAU)) {	/* Write or update */
	    flerset(f, &f->fs, lertyp = LER_OLD);	/* Use old LER blk */
	    ret = MUUO_IO("ENTER", uf->uf_ch, rbadr);
	}

	if (!ret) f->error = (lertyp == LER_OLD)	/* Get err if any */
			? f->orb.s.rb_ext.rbe.err
			: f->xrb.s.rb_ext.rbe.err;
    } else {
	flerset(f, &f->fs, lertyp);		/* Set up LER block */
	f->filop.fo_chn = uf->uf_ch;
#if !SYS_CSI			/* Normal T10's must allocate, barf */
	if (uf->uf_ch > 017) f->filop.fo_chn = uuosym("FO.ASC");
#endif
	f->filop.fo_fnc = op;
	f->filop.fo_nbf = 0;
	f->filop.fo_leb = (lertyp == LER_OLD)
			? XWD(0,(int)&f->orb) : XWD(0,(int)&f->xrb);
	if (!MUUO_ACVAL("FILOP.", XWD(6,(int)&f->filop), &ret))
	    f->error = ret;
	else if (op == _FORED || op == _FOSAU)
	    uf->uf_flgs |= UIOF_OREAD;
#if !SYS_CSI			/* Normal T10 must use ext chan we got */
	if (f->error == -1 && uf->uf_ch > 017)	/* If no err & extended chn */
	    uf->uf_ch = f->filop.fo_chn;
#endif
    }
    return  (f->error == -1)
	? 0			/* Won */
	: _t10error(f->error);	/* Failed, analyze error */
}

/* O_FINDEOF - Find actual EOF of file (ugh bletch)
**	For 8-bit files on CSI, attempt last-word check.
**	For converted files (any size), flush trailing NULs in last word.
**	For all others, give up and accept current uf_flen.
**	Current position is left random, caller is expected to reset.
*/
static int
o_findeof(uf)
struct _ufile *uf;
{
    int adj;

    if (uf->uf_flen <= 0 || !(uf->uf_flgs & UIOF_OREAD))
	return 0;
    if (
#if SYS_CSI
         (uf->uf_bsize == 8) ||
#endif
         (uf->uf_flgs&UIOF_CONVERTED)) {
	uf->uf_pos = uf->uf_flen - 1;	/* Want last byte of file */
	if (!_blkprime(uf, 0))		/* Attempt prime for reading */
	    return EIO;			/* Ugh, error!! */
#if SYS_CSI
	if (uf->uf_bsize == 8) {
	    /* Do special CSI hack for 8-bit files; check bottom 4 bits
	    ** of last word in file, which contain the # of unused bytes.
	    */
	    if ((adj = (*(int *)uf->uf_cp) & 017) > 3)
		adj = 0;			/* If bad, use all 4 bytes */
	} else
#endif
	if (uf->uf_flgs & UIOF_CONVERTED) {
	    /* Flush trailing NUL chars from N-bit converted file */
	    for (adj = 0; *(uf->uf_cp) == '\0'; uf->uf_cp--)
		if (++adj >= uf->uf_nbpw) break;
	}
	uf->uf_flen -= adj;			/* Adjust file length! */
    }
    return 0;
}

/* _OPNREL - Close and release I/O channel.
**	Called when an open() fails and needs to clean up.
**	Also invoked by close().
*/
int
_opnrel(uf)
struct _ufile *uf;
{
    if (!_filopuse)
	MUUO_IO("RELEAS", uf->uf_ch, 0);	/* Flush channel */
    else {
	int argblk = XWD(uf->uf_ch, uuosym(".FOREL"));
	MUUO_AC("FILOP.", XWD(1,(int)&argblk));
    }
    if (uf->uf_buf) {			/* If had a block or conversion buf, */
	_iobfre(uf->uf_buf);		/* free up the buffer! */
	uf->uf_buf = NULL;
    }
    ringfree(&uf->uf_biring);		/* Free up input ring if one */
    ringfree(&uf->uf_boring);		/* ditto output ring */
    return 0;
}

static int
ringinit(uf, iof, nbufs, bufsiz)
struct _ufile *uf;
{
    register struct _iobring *br;
    register struct _iob *b1, *b2;

    /* Point to input or output ring header */
    br = (iof & UIOF_READ) ? &uf->uf_biring : &uf->uf_boring;

    if (!(b1 = _iobget()))		/* At least one buffer... */
	return EMFILE;			/* No memory for more files */
    if (nbufs >= 2) {			/* Want double-buffering? */
	if (!(b2 = _iobget()))
	    return EMFILE;		/* Out of mem again */
	b1->bf_nba = ((int)b2)+1;	/* Point buffers to each other */
	b2->bf_nba = ((int)b1)+1;
	b2->bf_iou = 0;			/* Set up 2nd buffer */
	b2->bf_siz = bufsiz - 2;
    } else
	b1->bf_nba = ((int)b1)+1;	/* Point single buffer to itself */
    b1->bf_iou = 0;			/* Set up 1st buffer */
    b1->bf_siz = bufsiz - 2;

    /* Buffers all set up and linked together, now set up the
    ** buffer ring header (which evidently is not initialized at all by the
    ** the OPEN UUO).
    ** One thing we do is set the byte size of the BP into the buffer;
    ** but NOTE CAREFULLY that the monitor routines, when they initialize
    ** a buffer, ALWAYS zero out the P field of the BP and set the RH
    ** to point at the word before the actual start of data.  This is
    ** OK if a IDPB/ILDB is done, but is a screw for ADJBP because that
    ** preserves byte alignment!!!!!!  So anything that uses br_bp has
    ** to be aware of this.... ack ugh bletch barf.
    */
    br->br_use = 1;		/* Say no I/O yet */
    br->br_cnt = 0;		/* Clear just to be safe */
    br->br_buf = ((int)b1)+1;	/* Point ring header to 1st buffer */
    switch (uf->uf_bsize) {	/* Set up byte pointer with right bytesize */
	case 7:
	case 8:
	case 9:			/* Put bytesize into S field of byte ptr */
	    br->br_bp = (char *) ((uf->uf_bsize << 24)
		| (((int)(int *)b1->b_data)-1) );
	    break;
	default:
	    return ENXIO;	/* Bad bytesize */
    }
    if (iof == UIOF_READ) {
	/* Set up for buffered input using either block or char device.
	** Block devs look at uf_rleft, uf_cp, uf_blen.
	** Char devs just look at uf_biring.
	*/
	uf->uf_blen = uf->uf_nbpw * (bufsiz - 3);
	uf->uf_rleft = 0;
    } else {
	/* Set up for buffered output using either block or character device.
	** Block devices look at uf_wleft, uf_cp, and uf_blen.
	** Character devices just look at the uf_boring header.
	*/
	if (o_out(uf) <= 0)	/* Init buffers */
	    return EIO;		/* Some error on 1st out */
	uf->uf_blen = uf->uf_boring.br_cnt;	/* Remember # bytes avail! */
	uf->uf_bpbeg = uf->uf_boring.br_bp;

	/* Make CP and get right alignment!!!  Stupid T10 monitor always gives
	** us a byte pointer with a zero P field, which is incorrectly
	** aligned for most kinds of bytes.  Bumping this by one both gets
	** us a char pointer and restores proper alignment.
	** If this ever assembles into ADJBP instead of <IBP 0,> we lose big!
	*/
	++(uf->uf_bpbeg);
	uf->uf_wleft = 0;		/* Force init on blk-dev write */
    }
    return 0;			/* Success */
}


static void
ringfree(br)
register struct _iobring *br;		/* T10 I/O buffer ring header */
{
    struct _iob *b, *bf, *bx;

    if (br->br_buf) {			/* If have a buffer ring...  */
	bf = b = (struct _iob *)(br->br_buf-1);	/* Original ptr */
	do {
	    bx = (struct _iob *)(bf->bf_nba-1);	/* Remember next */
	    _iobfre(bf);			/* then flush buf */
	} while ((bf = bx) != b);		/* loop unless next is orig */
	br->br_buf = NULL;
	br->br_cnt = 0;				/* Clear just in case */
	br->br_bp = 0;
    }
}

/* _FLOOKUP -  T10/WAITS auxiliary file lookup routine.
**	This routine is only used by stat() to get information about a file,
**	thus it releases the channel immediately after opening.
** This serves the same function as _GTJFN does for T20; it gets a
** handle on a file (here a channel #) without any intention of doing I/O.
** The UF is not seized and so may be re-used (possibly by a signal handler,
** so be careful to have ints disabled).
** Returns 0 if succeeded, else an error number.
*/
int
_flookup(file, f, lertyp)
char *file;		/* Filename.  If NULL, assumes already parsed. */
struct _filehack *f;
int lertyp;		/* LER block type to use */
{
    struct _ufile *uf;
    int err;

    /* Say no lookup error so far */
    f->error = -1;		/* Must distinguish from ERFNF% (0), sigh. */

    /* First parse the filespec, if desired.  May be NULL to just use f->fs. */
    if (file && (err = _fparse(&f->fs, file)))
	return err;
    if (!(uf = _ufcreate()))	/* Find a free channel # */
	return EMFILE;		/* Too many files */

    /* Set up device and mode */
    f->filop.fo_ios = 0;		/* Simply zap all flags & mode */
    f->filop.fo_brh = 0;		/* Use no buffering */
    f->filop.fo_dev = f->fs.fs_dev ? f->fs.fs_dev : _SIXWRD("DSK");

    if (err = o_open(uf, f, _FORED, lertyp)) {	/* Open for read */
	uf->uf_nopen = 0;		/* Release uf quietly */
	_opnrel(uf);			/* Failed, flush channel used */
	return err;			/* Return error */
    }

    /* Have the info we wanted, now close channel ASAP */
    if (!_filopuse)
	MUUO_IO("RELEAS", uf->uf_ch, 0);
    else {
	int arg = XWD(uf->uf_ch, uuosym(".FOREL"));
	MUUO_AC("FILOP.", XWD(1,(int)&arg));
    }
    uf->uf_nopen = 0;			/* Release uf quietly */
    return 0;				/* Won, return success! */
}

/* _FRENAME -  T10/WAITS auxiliary file rename routine.
**	This is common code used by the USYS calls: unlink() and rename().
**	It is located here because of its heavy dependence on LOOKUP.
** Returns 0 if succeeded, else an error number.
** Always releases the channel.
*/
/* TO BE DONE: FIX ATTRIBUTE COPY (so they aren't all zapped to 0)??? */
int
_frename(fsold, fsnew)
struct _filespec *fsold, *fsnew;
{
    struct _filehack f, nf;
    struct _ufile *uf;

    if (!(uf = _ufcreate()))	/* Find a free channel # */
	return EMFILE;		/* Too many files */
    f.filop.fo_chn = uf->uf_ch;	/* Remember channel # we got */

    f.error = -1;
    f.filop.fo_ios = 0;		/* Simply zap all flags & mode */
    f.filop.fo_brh = 0;		/* Use no buffering */
    f.filop.fo_dev = fsold->fs_dev ? fsold->fs_dev : _SIXWRD("DSK");
    flerset(&f, fsold, LER_OLD);	/* Use short LER blk for old fspec */
    flerset(&nf, fsnew, LER_OLD);	/* Another for new filespec */
    if (!_filopuse) {
	if (!MUUO_IO("OPEN", f.filop.fo_chn, &f.filop.fo_ios)) {
	    uf->uf_nopen = 0;	/* Release uf quietly */
	    return ENXIO;	/* "No such device or address" (sigh) */
	}
	if (!MUUO_IO("LOOKUP", f.filop.fo_chn, &f.orb))
	    f.error = f.orb.s.rb_ext.rbe.err;
	else if (!MUUO_IO("RENAME", f.filop.fo_chn, &nf.orb))
	    f.error = nf.orb.s.rb_ext.rbe.err;
	MUUO_IO("RELEAS", f.filop.fo_chn, 0);
    } else {
	int ret;
#if !SYS_CSI
	if (f.filop.fo_chn > 017)	/* Normal T10's must allocate, barf */
	    f.filop.fo_chn = uuosym("FO.ASC");
#endif
	f.filop.fo_fnc = fsnew->fs_nam ? uuosym(".FORNM") : uuosym(".FODLT");
	f.filop.fo_nbf = 0;
	f.filop.fo_leb = XWD((int)&nf.orb,(int)&f.orb);
	if (!MUUO_ACVAL("FILOP.", XWD(6,(int)&f.filop), &ret))
	    f.error = ret;
	f.filop.fo_fnc = uuosym(".FOREL");
	MUUO_AC("FILOP.", XWD(1,(int)&f.filop));
    }
    uf->uf_nopen = 0;		/* Release uf quietly */
    return (f.error == -1) ? 0 : _t10error(f.error);
}

static void
flerset(f, fs, lertyp)
struct _filehack *f;
struct _filespec *fs;
{
    /* First determine right directory path to use (0 or PPN or path spec) */
    f->lerppn = (fs->fs_nfds > 1)	/* More than one dir given? */
		? (int)&fs->fs_path		/* Yeah, just point to it */
		: fs->fs_path.p_path.ppn;	/* No, just use PPN (or 0) */
    fs->fs_path.p_arg = 0;			/* Clear this just in case */

    /* Now set up LER block from filespec as appropriate */
    if (lertyp == LER_OLD) {
	f->orb.s.rb_nam = fs->fs_nam;
	f->orb.s.rb_ext.wd = fs->fs_ext;
	f->orb.s.rb_prv.wd = 0;
	f->orb.s.rb_ppn = f->lerppn;
    } else {
#if SYS_WTS
	_panic("flerset: extended fmt");	/* Not supported on WAITS */
#else
	/* Want extended block, set that up.  If caller plans to use it
	** with ENTER, it should zero f->xrb beforehand because of all
	** the additional values that the monitor might take from the
	** extra words.
	*/
	f->xrb.s.rb_cnt = lertyp;		/* # wds following */
	f->xrb.s.rb_ppn = f->lerppn;
	f->xrb.s.rb_nam = fs->fs_nam;
	f->xrb.s.rb_ext.wd = fs->fs_ext;
	f->xrb.s.rb_prv.wd = 0;
#endif
    }
}

/* LOOKUP/ENTER/RENAME/GETSEG/RUN ERROR CODES */
#define Eunk	EIO	/* No obvious mapping, maybe try again later */

static short t10errs[] = {
	ENOENT,	/* ERFNF% - FILE NOT FOUND */
	ENOTDIR,	/* ERIPP% - INCORRECT PPN */
	EACCES,	/* ERPRT% - PROTECTION FAILURE */
	EBUSY,	/* ERFBM% - FILE BEING MODIFIED */
	EEXIST,	/* ERAEF% - ALREADY EXISTING FILE NAME */
	EFAULT,	/* ERISU% - ILLEGAL SEQUENCE OF UUOS */
#if SYS_WTS
	EFAULT, EFAULT, EIO, EIO, ENOSPC
#else
	EIO,	/* ERTRN% - TRANSMISSION ERROR */
	ENOEXEC,	/* ERNSF% - NOT A SAVE FILE */
	ENOMEM,	/* ERNEC% - NOT ENOUGH CORE */
	ENXIO,	/* ERDNA% - DEVICE NOT AVAILABLE */
	ENODEV,	/* ERNSD% - NO SUCH DEVICE */
	Eunk,	/* ERILU% - ILLEGAL MONITOR CALL FOR GETSEG OR FILOP, OR SAVE. */
	EDQUOT,	/* ERNRM% - NO ROOM */
	EROFS,	/* ERWLK% - WRITE-LOCKED */
	ENFILE,	/* ERNET% - NOT ENOUGH TABLE SPACE */
	Eunk,	/* ERPOA% - PARTIAL ALLOCATION */
	Eunk,	/* ERBNF% - BLOCK NOT FREE */
	EISDIR,	/* ERCSD% - CAN'T SUPERSEDE A DIRECTORY */
	ENOTEMPTY,	/* ERDNE% - CAN'T DELETE NON-EMPTY DIRECTORY */
	ENOENT,	/* ERSNF% - SFD NOT FOUND */
	ENOENT,	/* ERSLE% - SEARCH LIST EMPTY */
	ELOOP,	/* ERLVL% - SFD NEST LEVEL TOO DEEP */
	Eunk,	/* ERNCE% - NO-CREATE FOR ALL S/L */
	ETXTBSY,	/* ERSNS% - SEGMENT NOT ON SWAP SPACE OR JOB LOCKED */
	EPERM,	/* ERFCU% - CAN'T UPDATE FILE */
	EFAULT,	/* ERLOH% - LOW SEG OVERLAPS HI SEG (GETSEG) */
	EACCES,	/* ERNLI% - NOT LOGGED IN (RUN, SAVE) */
	ETXTBSY,	/* ERENQ% - FILE STILL HAS OUTSTANDING LOCKS SET */
	ENOEXEC,	/* ERBED% - BAD .EXE FILE DIRECTORY (GETSEG,RUN) */
	ENOEXEC,	/* ERBEE% - BAD EXTENSION FOR .EXE FILE(GETSEG,RUN) */
	ENOEXEC,	/* ERDTB% - .EXE DIRECTORY TOO BIG(GETSEG,RUN,SAVE.) */
	Eunk,	/* ERENC% - TSK - EXCEEDED NETWORK CAPACITY */
	Eunk,	/* ERTNA% - TSK - TASK NOT AVAILABLE */
	Eunk,	/* ERUNN% - TSK - UNDEFINED NETWORK NODE */
	Eunk,	/* ERSIU% - RENAME - SFD IS IN USE */
	Eunk,	/* ERNDR% - DELETE - FILE HAS AN NDR LOCK */
	Eunk,	/* ERJCH% - JOB COUNT HIGH (A.T. READ COUNT OVERFLOW) */
	Eunk,	/* ERSSL% - CANNOT RENAME SFD TO A LOWER LEVEL */
	EBADF,	/* ERCNO% - CHANNEL NOT OPENED (FILOP.) */
	ENXIO,	/* ERDDU% - DEVICE "DOWN" AND UNUSEABLE */
	EACCES,	/* ERDRS% - DEVICE IS RESTRICTED */
	EACCES,	/* ERDCM% - DEVICE CONTROLLED BY MDA */
	EPERM,	/* ERDAJ% - DEVICE ALLOCATED TO ANOTHER JOB */
	EIO,	/* ERIDM% - ILLEGAL I/O DATA MODE */
	EINVAL,	/* ERUOB% - UNKNOWN/UNDEFINED OPEN BITS SET */
	EBUSY,	/* ERDUM% - DEVICE IN USE ON AN MPX CHANNEL */
	ENFILE,	/* ERNPC% - NO PER-PROCESS SPACE FOR EXTENDED I/O CHANNEL TABLE */
	EMFILE,	/* ERNFC% - NO FREE CHANNELS AVAILABLE */
	EINVAL,	/* ERUFF% - UNKNOWN FILOP. FUNCTION */
	EMFILE,	/* ERCTB% - CHANNEL TOO BIG */
	EINVAL,	/* ERCIF% - CHANNEL ILLEGAL FOR SPECIFIED FUNCTION */
	EFAULT,	/* ERACR% - ADDRESS CHECK READING ARGUMENTS */
	EFAULT,	/* ERACS% - ADDRESS CHECK STORING ANSWER */
	EINVAL,	/* ERNZA% - NEGATIVE OR ZERO ARGUMENT COUNT */
	EINVAL,	/* ERATS% - ARGUMENT BLOCK TOO SHORT */
	Eunk,	/* ERLBL% - MAGTAPE LABELING ERROR */
	Eunk,	/* ERDPS% - DUPLICATE SEGMENT IN ADDRESS SPACE */
	Eunk,	/* ERNFS% - NO FREE SECTION (SEGOP.) */
	Eunk,	/* ERSII% - SEGMENT INFORMATION INCONSISTENT (SEGMENT # AND NAME DON'T MATCH) */
	
#endif
};

int
_t10error(err)
{
    if (err < 0 || err > (sizeof(t10errs)/sizeof(t10errs[0])))
	return EIO;		/* for now */
    return t10errs[err];
}

/* T10/WAITS filespec parser
**	This parser is able to handle filename strings which are in standard
** TOPS-10 format, or UNIX format, or a combination thereof.
** The general syntax is:
**	 {node::} {dev:} {[dirpath]} {upath} {filename} {[dirpath]}
**
**	node - a TOPS-10 network site name (single word).
**	dev -	Device or logical structure name (single word).
**	[dirpath] - a TOPS-10 directory path, syntax: [P,PN{,sfds}]
**			If present, must always	contain the UFD (PPN).
**			It may contain SFDs after the PPN.
**			Only one [dirpath] may be given.
**	upath - a UNIX-style directory path, syntax: {/}{upath | name}/
**	filename - Syntax is: name{. | .ext}
**			i.e. "name", "name.", or "name.ext"
**
** The "upath" syntax has these peculiarities:
**	- An absolute dirpath (begins with "/") must have a PPN after the "/".
**		This PPN must not be enclosed in brackets.
**	- A PPN has the syntax "n,n" on TOPS-10; "nam,nam" on WAITS.
**		Due to possible future ambiguity ("n/n"), it is a bad
**		idea to use a PPN as the first part of a relative pathname.
**	- A relative dirpath is relative to the "default directory path"
**		as returned by PATH. if there is no device, or the "current
**		path" for the specified device.
**	- "." and ".." can be given as directory names.
**	- A upath can be combined with a [dirpath], however the upath cannot
**		start with a '/' or a PPN; it is considered to be relative
**		to [dirpath].
**	- It would be possible for "/dev/foo" to become FOO:, but it's hard
**		to think of a plausible use for this.
** Name components can be quoted in the following ways:
**	- System-independent quote char "\" quotes next char.
**	- System-dependent forms:
**		WAITS:	^A (down-arrow) encloses quoted word (no doubling)
**		T10:	" encloses quoted word (double to quote ")
**		CSI:	' or " enclose quoted word (double to quote ' or ")
** Incomplete PPNs can be specified:
**	A PPN of the form [,123] or [123,] or [,] will take the unspecified
**	fields from either the logged-in PPN (on T10, CSI) or the connected
**	disk PPN (on WAITS).  WAITS also permits [] or [FOO] to be the
**	same as [,] and [FOO,].
*/

static int ppnparse();
static char *getwd6();
static unsigned sixbit();
static int rjust6(), sixoct();

struct word6 {
    int len;		/* # chars actually in word */
    unsigned word;	/* word in SIXBIT, left justified */
    int term;		/* Character terminating word */
    int quoted;		/* Non-zero if anything was quoted in word */
};

#ifndef NFSCOMPS
#define NFSCOMPS 20
#endif

int
_fparse(f, path)
struct _filespec *f;
char *path;
{
    register struct word6 *wp;
    register int n;
    struct word6 wd[NFSCOMPS];		/* Parsed array of words */
    char *cp;
    struct word6 *beg, *end,		/* Terminator markers */
	*opnbrk = 0, *clsbrk = 0,
	*slash = 0, *firstslash = 0,
	*colon = 0, *dot = 0;
    int absupath;			/* TRUE if {dev:}/path... */

    memset((char *)f, 0, sizeof(*f));	/* Clear entire structure */

    /* Fill up parse array with words. */
    if (!(cp = path))
	return EINVAL;
    --cp;				/* Back up for PDP-10 efficiency */
    wp = beg = &wd[0];
    end = &wd[NFSCOMPS-1];		/* Last valid array entry */
    for (; cp = getwd6(cp, wp);) {
	switch (wp->term) {
	case '[':	if (opnbrk) return EINVAL;
		 	opnbrk = wp;	break;
	case ']':	if (clsbrk) return EINVAL;
			clsbrk = wp;	break;
	case '.':	if (dot)    return EINVAL;
			dot = wp;	break;
	case '/':	if (!firstslash) firstslash = wp;
			slash = wp;	break;
	case ':':	colon = wp;	break;
	}
	if (++wp >= end)	/* Check # components, leave 1 at end */
	    return ENAMETOOLONG;	/* File name too long */
    }
    if (wp->term)			/* If stopped due to parse error, */
	return wp->term;		/* return that error. */
    end = wp;				/* Done, remember last word we got */
    if (end->word == 0)			/* If last thing has nothing, */
	--end;				/* back up to simplify things */
    if (beg == end && !beg->word)	/* If nothing parsed, */
	return ENOENT;			/* return "No such file" */

    /* OK, now examine results! */
#if SYS_T10+SYS_CSI				/* 1st component "node::"? */
    if (colon) {
	if (beg->term != ':')		/* 1st thing better have colon term */
	    return EINVAL;
	if (beg < end && (beg+1)->term == ':' && (beg+1)->word==0) {
	    f->fs_nod = beg->word;	/* Yup, remember node name */
	    beg += 2;			/* and move on to next component */
	    if (colon < beg)		/* If that took care of last colon */
		colon = NULL;		/* needn't check for device. */
	}
    }	
#endif
    if (colon) {		/* 1st component now "dev:"? */
	if (colon != beg	/* Could be, check... */
	  || beg->term != ':'	/* Avoid stuff like "foo/bar:" or ":foo" */
	  || beg->word == 0)
	    return EINVAL;	/* Bad device spec */
	f->fs_dev = beg->word;	/* OK, get it! */
	if (++beg > end)	/* Move over it, and return if no more */
	    return 0;		/* win! */
    }

    /* Set flag if starts with absolute unix-style path */
    absupath = (firstslash == beg && beg->word==0);

    /* See whether we have a dreaded PPN and hack it if so */
    if (opnbrk || clsbrk) {	/* If have either of PPN delims, check. */
	if (!opnbrk || !clsbrk	/* unbalanced? */
	  || opnbrk >= clsbrk	/* backwards? */
	  || absupath		/* Conflicts with absolute unix path? */
	  || (clsbrk != end	/* Not at end of string */
	     && (opnbrk != beg	/*   or at beginning?  (if at beg, ensure */
		|| opnbrk->word)))	/* no preceding component) */ 
	    return EINVAL;
    } else if (absupath) {
	/* We have an absolute unix-style pathname, "/ppn ..." */
	opnbrk = beg;
	if (firstslash == slash) {		/* Allow "/ppn" alone */
	    clsbrk = end;
	    slash = NULL;
	} else {				/* Must be "/ppn/..." */ 
	    for (clsbrk = beg; (++clsbrk)->term != '/'; )
		if (clsbrk >= end)
		    return EINVAL;		/* Didn't find it??? */
	    if (slash <= clsbrk)		/* If this was last slash, */
		slash = NULL;			/* forget it, no upath. */
	}
    }
    if (opnbrk) {
	/* Seems OK, so hand off to a PPN parser. */
	if (n = ppnparse(f, opnbrk, clsbrk))
	    return n;			/* Failed, error of some kind. */

	/* Won, so take PPN off string (either at beg or end) */
	if (opnbrk == beg) beg = clsbrk+1;
	else end = opnbrk;
	if (beg > end)			/* If that was all, */
	    return 0;			/* we're done, win! */
    }

    /* beg-end inclusive now contain upath and/or filename.
    ** Check for existence of a upath (has slash) and handle if so.
    ** If PPN was parsed, f->fs_nfds will have # of directories
    ** that were already gobbled as part of absolute path.
    ** If no PPN was parsed, we need to ask monitor for current abs path.
    */
    if (slash) {		/* Have unix-style relative dir path? */
	if (slash < beg || slash > end)
	    return EINVAL;		/* Some weird syntax error */
	if (!(n = f->fs_nfds)) {	/* Already have abs part? */
	    /* No, must ask monitor where we currently are. */
#if SYS_T10+SYS_CSI
	    /* Ask for default directory path */
	    f->fs_path.p_arg = f->fs_dev ? f->fs_dev
				: uuosym(".PTFRD");
	    if (!MUUO_AC("PATH.",
		    XWD(sizeof(f->fs_path)/sizeof(int), (int)&f->fs_path)))
		return ENOENT;		/* Some problem... */
	    if (!f->fs_path.p_path.ppn)	/* ugh!! */
		return ENOENT;
	    for (n = 0; f->fs_path.p_path.sfd[n]; ++n);	/* # SFDs */
	    n++;			/* Plus one for UFD */
#elif SYS_WTS			/* Find current disk PPN */
	    WTSUUO_ACVAL("DSKPPN", 0, &(f->fs_path.p_path.ppn));
	    n = 1;
#endif 
	    f->fs_nfds = n;		/* Update count in filespec */
	}

	/* Now parse relative path, adding onto end of abs path. */
	--n;				/* Find # of SFDs so far */
	for (;; ++beg) {
	    if (beg->term != '/')
		break;
	    if (beg->word == 0)		/* "...//..." is OK, just ignore */
		continue;
	    if (beg->word == _SIXWRD(".")	/* Ditto "/./" */
		&& !beg->quoted)
		continue;
	    if (beg->word == _SIXWRD("..")
		&& !beg->quoted) {
		if (--n < 0) return EINVAL;	/* Don't allow "/ppn/../" */
		f->fs_path.p_path.sfd[n] = 0;	/* Restore terminating 0 */
		--(f->fs_nfds);
		continue;
	    }
	    if (n >= UIO_NSFDS)		/* Check for exceeding nest depth */
		return ENAMETOOLONG;
	    f->fs_path.p_path.sfd[n] = beg->word;
	    ++n;			/* Bump # of SFDs */
	    ++(f->fs_nfds);		/* and # of all FDs */
	}
	if (beg <= slash)		/* Make sure that took care of all */
	    return EINVAL;		/* slashes we saw! */
	if (beg > end)
	    return 0;			/* That's all, win! */
    }


    /* beg-end inclusive now should contain filename only.
    ** We may have any of these cases:
    **		1 word:  "name."  "name[" "name"
    **		2 words: "name. ext"  ". ext"
    **			 "name. ext[" ". ext["
    */
    switch (end-beg) {
	case 0:		/* One word */
	    if (beg->term != '.'
	      && beg->term != '['
	      && beg->term)
		return EINVAL;
	    f->fs_nam = beg->word;
	    break;
	case 1:		/* Two words */
	    if (beg->term != '.'
	      || (end->term != '['
		&& end->term != 0))
		return EINVAL;
	    f->fs_nam = beg->word;
	    f->fs_ext = end->word;
	    if (f->fs_ext & _RHALF)
		return ENAMETOOLONG;	/* Extension too long */
	    break;
	default:
	    return EINVAL;		/* Some syntax error */
    }

    return 0;				/* Won!! */    
}

/* T10 File parsing utilities */

/* PPNPARSE - parse a PPN, with optional dirpath.
**	"beg" points to the token BEFORE the PPN; its terminator will be
**		either '/' or '['.
**	"end" points to the last token of the PPN; its terminator should be
**		one of '/', ']', or NUL.
** Returns zero if parse succeeded, else an error number to be passed to user.
*/
static int
ppnparse(f, beg, end)
struct _filespec *f;
struct word6 *beg, *end;
{
    int term, cnt;
    int lh, rh;			/* Two halves of PPN */

    cnt = end - beg;		/* Find # words in dirpath */
#if SYS_WTS
    if (cnt < 1)		/* On WAITS, permit [] or [FOO] */
#else
    if (cnt < 2)		/* Normal TOPS-10, 2 words always required! */
#endif
	return EINVAL;
    switch (term = beg->term) {
	case '[':		/* Standard PPN/dirpath syntax */
	    term = ']';		/* must end with this terminator */
	    break;
	case '/':		/* upath syntax must end with this one */
	case 0:			/* Permit "/23,45" case (NUL terminator) */
	    if (cnt > 2)	/* But both are restricted to 2 wds only! */
		return ENAMETOOLONG;
	    break;
	default:
	    return EINVAL;	/* Bad PPN starting delimiter */
    }
    if (end->term != term)	/* Last word must have proper terminator */
	return EINVAL;
    ++beg;
    if (cnt > 1 && beg->term != ',')	/* 1st wd of 2 must end in comma */
	return EINVAL;		/* Ugh, bad syntax */

    /* Right-justify the first two SIXBIT words */
    lh = rjust6(beg->word);
    if (cnt > 1) rh = rjust6((++beg)->word);

    if ((!lh || !rh) && !USYS_VAR_REF(defppn))
				/* If will need default PPN, get it. */
#if SYS_T10+SYS_CSI
	MUUO_VAL("GETPPN", &USYS_VAR_REF(defppn));
				/* Use logged-in PPN as default */

    /* Re-interpret the two SIXBIT words as octal numbers */
    if (!lh) lh = FLDGET(USYS_VAR_REF(defppn), _LHALF);
    else lh = sixoct(lh);	/* Will return -1 if bad number */
    if (!rh) rh = FLDGET(USYS_VAR_REF(defppn), _RHALF);
    else rh = sixoct(rh);
    if (lh < 0 || rh < 0)
	return EINVAL;		/* Non-numeric PPN */
#elif SYS_WTS
	WTSUUO_VAL("DSKPPN", &USYS_VAR_REF(defppn));
				/* Use connected PPN as default */
    if (!lh) lh = FLDGET(USYS_VAR_REF(defppn), _LHALF);
    if (!rh) rh = FLDGET(USYS_VAR_REF(defppn), _RHALF);
    if ((lh & _LHALF) || (rh &_LHALF))	/* Ensure wds <= 3 chars long */
	return ENAMETOOLONG;		/* Ugh */
#endif
    f->fs_path.p_path.ppn = XWD(lh,rh);
    f->fs_nfds = 1;			/* Say PPN parsed */

    /* Now see if any SFDs follow the PPN */
    if (cnt > 2) {
	register int *ip;
	if ((cnt -= 2) > UIO_NSFDS)
	    return ENAMETOOLONG;	/* Too many SFDs */
	ip = &(f->fs_path.p_path.sfd[0]);
	while (--cnt >= 0) {
	    ++beg;
	    if (cnt && beg->term != ',')
		return EINVAL;		/* Non-comma SFD separator! */
	    *ip++ = beg->word;		/* Store SFD name */
	    ++(f->fs_nfds);		/* Bump count of dirs seen */
	}
    }
    return 0;
}

/* RJUST6 - right-justify a SIXBIT value */
static int
rjust6(wd)
register unsigned wd;
{
    if (wd)
	while ((wd & 077) == 0)
	    wd >>= 6;
    return wd;
}

/* SIXOCT - Interpret a right-justified SIXBIT word as an octal number,
**	and return the value.  Returns -1 if non-digit sixbit char seen.
*/
static int
sixoct(wd)
unsigned wd;
{
    register int digit;
    if (!wd)
	return wd;
    digit = (wd&077) - 020;
    if (digit >= 0 && digit <= 7
      && (digit += ((unsigned)sixoct(wd>>6)<<3)) >= 0)
	return digit;
    return -1;
}

#define tosixbit(c) (((c & 0100) ? c|040 : c&~040)&077)	/* Convert to SIXBIT */

/* GETWD6 - Scan a SIXBIT word, sets word6 struct and returns updated char ptr.
**	Note special hacking for "." and ".." -- they are recognized only
**	where meaningful.  The caller can distinguish between these and
**	explicitly quoted names by checking the "quoted" flag.
*/
static char *
getwd6(cp, wp)
register char *cp;
struct word6 *wp;
{
    register int c, n = 0, shift = 36;
    register unsigned wd = 0;

    wp->quoted = 0;
    for (;;) {
      switch (c = *++cp) {
	case '.':			/* Special delimiter */
	    if (n == 0 && strchr("./[", cp[1])) {	/* Chk . / [ or NUL */
		if (cp[1] == '.' && strchr("/[", cp[2])) {
		    wp->word = _SIXWRD("..");
		    c = *(cp += (n = 2));
		} else if (strchr("/[", cp[1])) {
		    wp->word = _SIXWRD(".");
		    c = *(cp += (n = 1));
		}
	    }
	case '\0':			/* Is char a normal delimiter? */
	case ':':	case '/':
	case '[':	case ']':
	case ',':
	    break;			/* Yup, break out of loop to return */

#if UIO_FSWORDQUOT1
	case UIO_FSWORDQUOT1:
#if UIO_FSWORDQUOT2
	case UIO_FSWORDQUOT2:
#endif
	    if (n)		/* If in middle of word, error. */
		return wp->term = ENOENT, (char *)NULL; /* Bad filespec. */

	    for (;;) {		/* Start gobbling a quoted word. */
		if (!*++cp)		/* If string ended before 2nd quote, */
		    return wp->term = ENOENT, (char *)NULL; /* Bad filespec. */
		if (*cp == c		/* Matches original quote char? */
		  && *++cp == c)	/* Yes, is it doubled? */
		    break;		/* Yes, so stop loop!  Else put in. */
		if (++n <= 6)		/* If have room, add to SIXBIT */
		    wd |= (unsigned) tosixbit(*cp) << (shift -= 6);
	    }

	    /* Check char following wd, must be valid terminator! */
	    if (strchr(".[,]/:", (c = *cp)) == NULL)
		return wp->term = ENOENT, (char *)NULL;	/* Bad filespec. */
	    break;			/* Won, break from loop. */
#endif

#if UIO_FSCHARQUOT1
	case UIO_FSCHARQUOT1:
#if UIO_FSCHARQUOT2
	case UIO_FSCHARQUOT2:		/* If it's quote char, */
#endif
	    c = *++cp;			/* ignore it and always use next */
	    wp->quoted++;
#endif
	default:
	    if (iscntrl(c)) {		/* Don't allow control chars */
	case ' ':			/* or unquoted spaces */
		wp->term = ENOENT;	/* Bad filespec, barf. */
		return NULL;
	    }
	    if (++n <= 6)		/* If have room, add to SIXBIT */
		wd |= (unsigned) tosixbit(c) << (shift -= 6);
	    continue;
      }
      break;	/* Breaking from switch also breaks from loop */
    }
    wp->len = n;			/* Won, return goodies */
    wp->word = wd;
    wp->term = c;
    return (c ? cp : NULL);
}

static unsigned
sixbit(s)
register char *s;
{
    register int c, n = 36;
    register unsigned wd = 0;

    c = *s;
    do {
	wd |= (unsigned)tosixbit(c) << (n -= 6);
    } while ((c = *s++) && n >= 6);
    return wd;
}
#endif /* SYS_T10+SYS_CSI+SYS_WTS */

#if SYS_ITS	/* ITS OS-dependent file opening code */

static void cvt_filename();	/* Convert filename for SOPEN */

/* OPENSYS for ITS
*/
static int
opensys(uf, path, flags, mode)
struct _ufile *uf;
const char *path;
int flags, mode;
{
    int bits;
    char realpath[FILENAME_SIZE+1];
    char *realpath_ptr = realpath-1;

    /* O_NDELAY: don't hang mode ignored for now */
    /* Bits other than the ones listed here are not handled. */
    switch (flags & ~(O_BINARY | O_CONVERTED | O_UNCONVERTED | O_BSIZE_MASK |
			O_NDELAY | O_ITS_IMAGE | O_ITS_NO_IMAGE)) {
	case (O_RDONLY):
	    bits = SC_IMC(_UAI);
	    uf->uf_flgs |= UIOF_OLD;	/* If we win, it will be old! */
	    break;
	case (O_WRONLY | O_CREAT | O_TRUNC):
	    bits = SC_IMC(_UAO);
	    break;
	default: return EINVAL;
    }

    switch (flags & O_BSIZE_MASK) {
	case O_BSIZE_7: uf->uf_bsize = 7; break;
	case O_BSIZE_8: uf->uf_bsize = 8; break;
	case O_BSIZE_9: uf->uf_bsize = 9; break;
	default: uf->uf_bsize = (flags & O_BINARY) ? 9 : 7; break;
    }

    if (uf->uf_bsize == 7) {
	/* Assume 7-bit bytes means ASCII, unless user explicitly asks */
	/* for image mode: */
	if (flags & O_ITS_IMAGE) bits |= _DOIMG;
    } else {
	/* Assume other byte sizes mean image mode, unless user */
	/* explicitly says not to.  Turn on block mode and signal */
	/* handpacking in either case. */
	bits |= ((flags & O_ITS_NO_IMAGE) ? _DOBLK : (_DOBLK | _DOIMG));
	uf->uf_flgs |= UIOF_HANDPACK;
    }

    if ((flags & O_CONVERTED) ||
	(uf->uf_bsize == 7 && !(flags & (O_UNCONVERTED | O_BINARY))))
	uf->uf_flgs |= UIOF_CONVERTED;

    if (strlen(path) > FILENAME_SIZE)
	return ENAMETOOLONG;

    cvt_filename(path, realpath);

    if (SYSCALL3("sopen", bits, uf->uf_ch, &realpath_ptr))
	return ENOENT;

    uf->uf_type = _dvtype(uf->uf_ch);
    if (uf->uf_type == _DVUSR) {
	int uind;
	SYSCALL3_LOSE("usrvar", uf->uf_ch, SC_SIX("uind"), SC_VAL(&uind));
	uf->uf_dnum = SC_IMM(_JSNUM | uind);
    }

    return 0;			/* Won, return without error! */
}

/*
 *	Convert an ITS filename to make it acceptable to SOPEN.
 *	"/" becomes ";"
 *	"." becomes space when embedded in name components
 *	tab becomes space
 *	^Q inhibits the above
 */

static void cvt_filename(from, to)
    char *from, *to;
{
    char *ptr, *start;
    int c, len;

    strcpy(to, from);

    ptr = to-1;
    start = NULL;
    do {
	switch (c = *++ptr) {
	    case '/':
		*ptr = ';';
	    case ';':
	    case ':':
		start = NULL;
		break;

	    case '\t':
		*ptr = ' ';
	    case ' ':
	    case '\0':
		if (start)
		    while (--len > 0)
			switch (*++start) {
			    case '.': *start = ' '; break;
			    case '\021': ++start; break;
			}
		start = NULL;
		break;

	    case '\021':
		c = *++ptr;
	    default:
		if (start) len++;
		else { start = ptr; len = 0; }
		break;
	}
    } while (c);
}

#endif /* SYS_ITS */

#if 0	/* OLD STUFF for T20/10X, no longer used. */

static char *
tnxprot(uprot, str)
int uprot;
char *str;
{
    char *s = str;
    *s++ = ';';
    *s++ = 'P';
    f = modprot(mode >> 6);		/* user prots */
    *s++ = (f >> 3) + '0';
    *s++ = (f & 7) + '0';
    f = modprot(mode >> 3);		/* group prots */
    *s++ = (f >> 3) + '0';
    *s++ = (f & 7) + '0';
    f = modprot(mode);		/* other prots */
    *s++ = (f >> 3) + '0';
    *s++ = (f & 7) + '0';
    return str;
}

/* Unix -> T20/10X file protection conversion
*/
static int
modprot(mod)
int mod;
{
    int prot = 0;
    if (mod & 1) prot |= 012;		/* execute (and list) access */
    if (mod & 2) prot |= 027;		/* write and append access */
    if (mod & 4) prot |= 042;		/* read (and list) access */
    return prot;
}

/* --------------------------------------------------------------------- */
/*      jacket routine for GTJFN% to mung filenames into submission      */
/* --------------------------------------------------------------------- */

int _gtjfn(name, flags)
char *name;
{
    char dirpart[80], filpart[80], *dirptr, *filptr, *_dirst();
    int anydir, indir;			/* marker for dir part changed */

    anydir = 0;				/* dir part remains default */
    indir = 0;				/* assume not in directory part */
    dirpart[0] = 'D';			/* start off with directory part */
    dirpart[1] = 'S';			/* pointing to "DSK:" */
    dirpart[2] = 'K';
    dirpart[3] = ':';
    dirptr = &dirpart[3];		/* point to just before the end */
    filptr = &filpart[-1];		/* of dir and file parts */

    while (1) {
	switch (*name) {
	case '\0':				/* run out of chars? */
	    *++filptr = 0;			/* yes, null terminate */
	    filptr = &filpart[-1];		/* start at top again */
	    while (*++dirptr = *++filptr) ;	/* append to dir part */
	    return gtjfn_(dirpart, flags);	/* do low level lookup */

	case ':':
	    if (anydir) return -1;	/* already have dir, lose */
	    anydir = 1;			/* now we have one */
	    *++filptr = '\0';		/* terminate file part */
	    dirptr = &dirpart[-1];	/* start at top */
	    filptr = &filpart[-1];	/* top of filename part */
	    while (*++dirptr = *++filptr); /* copy across */
	    *dirptr = ':';		/* put the colon on */
	    filptr = &filpart[-1];	/* reinitialize file pointer */
	    break;

	case '[':
	case '<':
	    *++filptr = '<';		/* open bracket becomes angle */
	    indir = 1;			/* remember we're in dir part */
	    break;

	case '.':
	    if (indir < 0) *++filptr = '\026'; /* quote extra dots */
	    else if (indir == 0) indir = -1; /* only allow one in file */
	    *++filptr = '.';		/* add the dot */
	    break;

	case '>':
	case ']':
	    if (*dirptr != ':') return -1; /* already have dir, lose */
	    anydir = 1;			/* remember we have a dir and dev */
	    indir = 0;			/* no longer in dir part */
	    *++filptr = '\0';		/* terminate file part */
	    filptr = &filpart[-1];	/* top of filename part */
	    while (*++dirptr = *++filptr); /* copy across */
	    *dirptr = '>';		/* add the close bracket */
	    filptr = &filpart[-1];	/* reinitialize file pointer */
	    break;

	case '\026':			/* control-V? */
	case '\\':			/* or quoteing backslash? */
	    *++filptr = '\026';		/* yes, add it */
	    *++filptr = *++name;	/* and the next char */
	    break;

	case '/':			/* slash UNIX dir delimiter? */
	    indir = 0;			/* yes, no longer in dir part */
	    *(dirptr+1) = '\0';		/* yes, terminate directory part */
	    *++filptr = '\0';		/* and filename part */
	    switch (filpart[0]) {	/* check out first part of name */
	    case '.':			/* period? */
		switch (filpart[1]) {	/* yes, look at what follows */
		case '\0':		/* ./x ? */
		    name++;		/* yes, skip slash */
		    filptr = &filpart[-1]; /* start again in file part */
		    continue;		/* and ignore this dir part */

		default:
		    return -1;		/* .x/y loses */

		case '\026':		/* maybe ..? */
		    break;		/* yes, handle outside switch */
		}

		/* dir starts with .. - hack superdirectory */
		if (filpart[2] != '.' || filpart[3] != '\0') return -1;
		if (*dirptr != '>') {	/* do we have a real dir part? */
		    dirptr = _dirst(dirpart); /* no, fix it up */
		    if (dirptr == NULL) return -1; /* lost */
		}
		while (*--dirptr != '.' && *dirptr != ':') ; /* find delim */
		if (*dirptr == '.') {	/* found subdir start? */
		    *dirptr = '>';	/* turn into dir end */
		    name++;		/* skip over slash */
		    filptr = &filpart[-1]; /* forget .. */
		    continue;		/* on with the show */
		}
		/* no subdirs, move back to dev:<root-dir> */

	    case '\0':			/* no name, want root dir */
		if (*dirptr != ':') return -1; /* must have only dev */
		filptr = "<ROOT-DIRECTORY" - 1; /* point to dir part */
		break;

	    default:
		if (*dirptr != '>') {
		    dirptr = _dirst(dirpart); /* fix up filename */
		    if (dirptr == NULL) return -1; /* lost */
		}
		*dirptr = '.';		/* drop period over close bracket */
		filptr = &filpart[-1];	/* normal name, just use it */
	    }
	    while (*++dirptr = *++filptr) ; /* append name */
	    *dirptr = '>';		/* and close bracket */
	    filptr = &filpart[-1];	/* restart file part */
	    break;

	default:
	    *++filptr = *name;		/* normal char, add to file part */
	    break;
	}
	name++;				/* move on to next char */
    }
}
#endif	/* Commented-out stuff */

#endif /* T20+10X+T10+CSI+WAITS+ITS */
   