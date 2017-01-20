/*
**	STAT - stat, fstat, xstat, xfstat
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.146, 20-Sep-1988
**	(c) Copyright Ken Harrenstien, SRI International 1988
**		for all changes after v.37, 28-Mar-1986
**	Edits for ITS:  Copyright (C) 1988 Alan Bawden
**
** Original version by Greg Satz / Stanford University / 12-Sep-84
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS

#include <errno.h>
#include <stddef.h>		/* for NULL */
#include <string.h>		/* memset() */
#include <sys/types.h>
#include <sys/file.h>
#include <sys/usysio.h>
#include <sys/usysig.h>
#include <sys/stat.h>

#if SYS_T20+SYS_10X
#include <jsys.h>
#include <sys/time.h>	/* For tadl_to_utime() to convert file times */

/* Exported implementation-internal functions */
extern void _rljfn();
extern int _gtjfn(), _get_pio(), _gtfdb(), _rcusr();
extern long _nfbsz();	/* For LSEEK */

static int dostat(), t2u_pro();

#elif SYS_ITS
#include <sysits.h>

#elif SYS_T10+SYS_CSI+SYS_WTS
#include <muuo.h>
#include <macsym.h>
#include <sys/time.h>	/* For tadl_to_utime() to convert file times */

extern int _flookup(), _fparse();	/* From open() */
static int dostat();

#endif

/* Exported functions */
extern int stat(), fstat(), xstat(), xfstat();
extern int _dvtype();

static int _stat(), _fstat();

/*
 *	stat(name, buf)
 */

int
stat(name, buf)
char *name;
struct stat *buf;
{
    return _stat(name, buf, 0);	/* Normal stat buffer */
}

int
xstat(name, buf)
char *name;
struct xstat *buf;
{
    return _stat(name, buf, 1);	/* Extended stat buffer */
}

static int
_stat(name, buf, extf)
char *name;
struct stat *buf;
int extf;
{
    int i;

    USYS_BEG();
#if SYS_T20+SYS_10X
    {	int jfn;

	if ((jfn = _gtjfn(name, O_RDONLY)) == 0)
	    USYS_RETERR(ENOENT);
	i = dostat(buf, (struct _ufile *)NULL, jfn, extf);	/* No UF */
	_rljfn(jfn);
	if (i) USYS_RETERR(i);
	USYS_RET(0);
    }
#elif SYS_ITS
    {	int fd;

	if ((fd = open(name, O_RDONLY, 0)) < 0)
	    USYS_RETERR(ENOENT);
	/* Most device-independent way to avoid setting reference date: */
	SYSCALL1("resrdt", _uffd[fd]->uf_ch);
	i = fstat(fd, buf);
	close(fd);
	USYS_RET(i);
    }
#elif SYS_T10+SYS_CSI+SYS_WTS
    {	struct _filespec fs;
	if ((i = _fparse(&fs, name))
	  || (i = dostat(buf, (struct _ufile *)NULL, &fs, extf)))
	    USYS_RETERR(i);	/* Parsing or dostat error */
	USYS_RET(0);
    }
#else
    USYS_RETERR(EINVAL);	/* Not implemented yet */
#endif
}


int
fstat(fd, buf)
int fd;
struct stat *buf;
{
    return _fstat(fd, buf, 0);	/* Normal stat buffer */
}

int
xfstat(fd, buf)
int fd;
struct xstat *buf;
{
    return _fstat(fd, buf, 1);	/* Extended stat buffer */
}

static int
_fstat(fd, buf, extf)
int fd, extf;
struct stat *buf;
{
    struct _ufile *uf;
    int ret;

    USYS_BEG();
    if (!(uf = _UFGET(fd)))
	USYS_RETERR(EBADF);
#if SYS_T20+SYS_10X
    if (ret = dostat(buf, uf, uf->uf_ch, extf))
	USYS_RETERR(ret);
    USYS_RET(0);
#elif SYS_ITS
    USYS_RETERR(EINVAL);	/* Not really implemented on ITS yet. */
#elif SYS_T10+SYS_CSI+SYS_WTS
    if (ret = dostat(buf, uf, &uf->uf_fs, extf))
	USYS_RETERR(ret);
    USYS_RET(0);
#else
    USYS_RETERR(EINVAL);	/* Not implemented yet. */
#endif
}

/* _DVTYPE(osfd) - Get device type
*/
int
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

#if SYS_T20+SYS_10X

/*
 *	dostat(buf, uf, jfn, extf) - worker routine for stat() and fstat()
 *		returns 0 if succeeded, else error #
 */

static int
dostat(buf, uf, jfn, extf)
struct stat *buf;
struct _ufile *uf;
int jfn, extf;
{
    register struct xstat *xst;
    register int i, bytsiz;
    int fdb[monsym(".FBLEN")];
    char name[50];	/* To hold username (max 40 but be generous) */
    unsigned prot;
    int acs[5];

    if (extf) xst = (struct xstat *)buf;	/* If extended, use ptr */

    if (jfn == _PRIIN) _get_pio(&jfn, 0);	/* Check for redirection */
    else if (jfn == _PRIOU) _get_pio(0, &jfn);

    acs[1] = jfn;
    acs[2] = XWD(monsym(".FBLEN"),0);		/* get the whole FDB */
    acs[3] = (int) fdb;
    if (!jsys(GTFDB, acs)) {
	/* If GTFDB failed, assume dealing with non-disk device. */
	/* Clear entire structure since we won't be setting much of it. */
	if (extf) memset((char *)xst, 0, sizeof(struct xstat));
	else memset((char *)buf, 0, sizeof(struct stat));

	buf->st_mode = S_IFCHR;		/* Pretend "char special" device */
	acs[1] = jfn;
	if (!jsys(DVCHR, acs))		/* Get device info */
	    return ENODEV;		/* Shouldn't fail, actually */
	buf->st_dev = acs[1];		/* Device designator */
	buf->st_rdev = acs[2];		/* Dev characteristics (incl .DVxxx)*/
	if (extf && FLDGET(buf->st_rdev, monsym("DV%TYP")) == _DVTCP) {
	    buf->st_mode = S_IFSOCK;		/* Say "socket" */
	    acs[1] = jfn;
	    if (jsys(GDSTS, acs) > 0) {		/* Fails if not open */
		xst->xst_state = acs[2];	/* Connection state */
		xst->xst_fhost = acs[3];	/* Foreign host netaddr */
		xst->xst_fport = acs[4];	/* Foreign port # */
	    }
	}
	return 0;
    }

    /* If GTFDB succeeded, we're dealing with a disk file. */
    buf->st_nlink = 1;			/* can it be anything else? */
    buf->st_gid = 0;			/* for now */

    acs[1] = jfn;
    if (!jsys(DVCHR, acs))		/* Get device info */
	return ENODEV;			/* Shouldn't fail */
    buf->st_dev = acs[1];		/* Device designator */
    buf->st_rdev = acs[2];		/* Dev characteristics (incl .DVxxx)*/

    buf->st_ino = fdb[monsym(".FBADR")];	/* Disk address */
    buf->st_mode = ((fdb[monsym(".FBCTL")] & FB_DIR) ? S_IFDIR : S_IFREG);
    prot = fdb[monsym(".FBPRT")];		/* Protection */
    buf->st_mode |= (t2u_pro(FLDGET(prot, 0770000)) << 6)	/* Owner */
		  | (t2u_pro(FLDGET(prot,   07700)) << 3)	/* Group */
		  | (t2u_pro(FLDGET(prot,     077)) << 0);	/* World */
#if SYS_10X
    buf->st_uid = FLDGET(fdb[monsym(".FBUSE")], LH);	/* Get directory # */
#elif SYS_T20
    acs[1] = XWD(monsym(".GFLWR"), jfn);	/* <funct>,,<jfn> */
    acs[2] = (int) (name-1);
    jsys(GFUST, acs);				/* Ignore failure */
    buf->st_uid = _rcusr(name);			/* Convert name to user # */
#endif
    buf->st_atime = tadl_to_utime(fdb[monsym(".FBREF")]);
    buf->st_mtime = tadl_to_utime(fdb[monsym(".FBWRT")]);
    buf->st_ctime = tadl_to_utime(fdb[monsym(".FBCRE")]);

    /* Set size vars. */
    /* TOPS-20 has several stupid screws with respect to newly created files,
    ** or files being updated.  Newly created files don't actually exist until
    ** they have been CLOSF%'d, so the FDB size information is all 0.  open()
    ** attempts to circumvent this by doing a quick CLOSF/OPENF; however, then
    ** the update problem comes up, because TOPS-20 doesn't update the FDB
    ** size info until a CLOSF% is done after writing!!  If we are writing the
    ** file ourselves, we look at our own info to see what's up.
    */
    buf->st_size = fdb[monsym(".FBSIZ")];	/* First try what FDB has */
    bytsiz = FLDGET(fdb[monsym(".FBBYV")], monsym("FB%BSZ"));	/* Get FDB bytesize */
    if (bytsiz == 0 || bytsiz == 36) {	/* Monitor assumes 0 means 36 */
	bytsiz = 9;			/* KCC reads words as 4 9-bit bytes */
	buf->st_size *= 4;
    }
    buf->st_blksize = (36/bytsiz)*512;	/* # bytes in page */
    buf->st_blocks =			/* # pages (blocks) in file */
		FLDGET(fdb[monsym(".FBBYV")], monsym("FB%PGC"));

    if (uf) {				/* Have it open ourselves? */
	if (bytsiz != uf->uf_bsize) {	/* Yes, check bytesize info */
	    /* Update length and # bytes in page */
	    buf->st_size = _nfbsz(uf->uf_bsize, bytsiz, buf->st_size);
	    buf->st_blksize = (36/uf->uf_bsize) * 512;
	}
	if (buf->st_size < uf->uf_pos)	/* If our len info is better */
	    buf->st_size = uf->uf_pos;	/* update it! */

	i = (buf->st_size + buf->st_blksize-1) / buf->st_blksize;
	if (buf->st_blocks < i)			/* If our page info better */
	    buf->st_blocks = i;			/* # pages (blocks) in file */
    }

    if (extf) {			/* Set extended vars if desired */
	xst->xst_version = FLDGET(fdb[monsym(".FBGEN")], LH);
	xst->xst_bytsiz = FLDGET(fdb[monsym(".FBBYV")], monsym("FB%BSZ"));
	xst->xst_pagcnt = buf->st_blocks;
    }

    return 0;				/* success */
}
#endif /* T20+10X */

#if SYS_T20+SYS_10X
/*
 *	get primary JFNs for ourself
 */

int
_get_pio(i, o)
int *i, *o;
{
    int ac[5];

    ac[1] = monsym(".FHSLF");		/* "Self" process handle */
    if (jsys(GPJFN, ac)) {
	if (i) *i = FLDGET(ac[2], LH);
	if (o) *o = FLDGET(ac[2], RH);
	return 1;
    } else return 0;
}

/*
 *	_GTFDB() - read (and return) a word from a file's fdb
 *	this routine is exported, don't make it static!
 */

int
_gtfdb(jfn, word)
int jfn, word;
{
    int arg_block[5];

    arg_block[1] = jfn;
    arg_block[2] = XWD(1,word);
    arg_block[3] = 3;				/* put the value in AC3 */
    return (jsys(GTFDB, arg_block)) ? arg_block[3] : 0;
}


/*
 *	Return username number for given user name
 */

int
_rcusr(name)
char *name;
{
    int ablock[5];

    ablock[1] = monsym("RC%EMO");
    ablock[2] = (int) (name - 1);
    if (!jsys(RCUSR, ablock) || (ablock[1] & monsym("RC%NOM")))
	return -1;
    return ablock[3];
}

/* _NFBSZ - convert file length in one bytesize to length in another bytesize.
**	Note we multiply by new bytesize before dividing by old; this prevents
**	integer division from forcing alignment to a word boundary.
*/
long
_nfbsz(ourbsz, filbsz, fillen)
int ourbsz, filbsz;
long fillen;
{
    register int ourbpw = ourbsz ? (36/ourbsz) : 1;	/* # bytes per wd */
    register int filbpw = filbsz ? (36/filbsz) : 1;
    return (ourbpw * fillen + filbpw-1) / filbpw;
}

/*
 *	Takes TOPS-20 protections right justified and returns Unix protections
 *	right justified.
 */
static int t2u_pro(prot)
unsigned prot;
{
    int i = 0;

    if (prot & monsym("FP%RD"))	i |= S_IREAD  >> 6;
    if (prot & monsym("FP%WR"))	i |= S_IWRITE >> 6;
    if (prot & monsym("FP%EX"))	i |= S_IEXEC  >> 6;
    return i;
}

#endif /* T20+10X */

#if SYS_T10+SYS_CSI+SYS_WTS

/* DOSTAT(buf, uf, fs, extf) - Fill out stat structure using parsed filespec.
**	Returns 0 if success, else errno value.
**	Note that fstat gives us a non-NULL uf pointer, but that doesn't
**	help us much since T10 has no good way to provide channel info.
*/
static unsigned t10prot();

static int
dostat(s, uf, fs, extf)
struct stat *s;
struct _ufile *uf;
struct _filespec *fs;
int extf;			/* Flag ignored */
{
    int nbpw;
    int err = 0;
    int typinf = 0, ret;
    int isdirdev;
    struct _filehack f;

    f.fs = *fs;			/* Copy filespec into big hack struct */

    /* Parsed filespec is in fs; check out device first. */
    if (!f.fs.fs_dev)			/* Device specified? */
	f.fs.fs_dev = _SIXWRD("DSK");	/* No, supply default */
    MUUO_ACVAL("DEVCHR", f.fs.fs_dev, &typinf);
    isdirdev = typinf & uuosym("DV.DIR");	/* See if directory device */

    if (!typinf)			/* Returns 0 if failed altogether */
	return ENODEV;

    if (!isdirdev) {			/* Handle non-directory devs */
#if SYS_T10+SYS_CSI
	if (MUUO_ACVAL("DEVNAM", f.fs.fs_dev, &ret) <= 0)
	    return ENODEV;		/* Barf??? */
#elif SYS_WTS
	if (WTSUUO_ACVAL("PNAME", f.fs.fs_dev, &ret) <= 0)
	    return ENODEV;		/* Barf??? */
#endif
	memset((char *)s, 0, sizeof(struct stat));	/* Clear struct */
	s->st_dev = ret;		/* Set SIXBIT phys device name */
	s->st_rdev = typinf;		/* Set device type (or charact) */
	s->st_mode =  S_IFCHR;		/* Say "char special" device */
	return 0;
    }

    /* Directory device, normally disk.  Do an OPEN and LOOKUP on file. */
#if SYS_T10+SYS_CSI
    if (err = _flookup((char *)NULL, &f, LER_RBTIM))	/* Use extended blk */
	return err;
    s->st_dev = f.xrb.s.rb_dev;
    s->st_ino = f.xrb.s.rb_pos;			/* Position on disk (??) */
    s->st_mode = ((f.xrb.s.rb_sts & uuosym("RP.DIR"))	/* Directory file? */
			? S_IFDIR : S_IFREG)
		 | t10prot(f.xrb.s.rb_prv.rb.prv);
    s->st_uid = f.xrb.s.rb_aut;			/* File author */
    s->st_size = f.xrb.s.rb_siz;		/* Get size in words */
    s->st_ctime = tadl_to_utime(f.xrb.s.rb_tim);
    /* Put together absurd T10 creation date/time format */
    s->st_mtime = tad64s_to_utime(XWD(		/* Convert stupid fmt */
	(f.xrb.s.rb_ext.rb.crx << 12) | f.xrb.s.rb_prv.rb.crd,	/* LH date */
	f.xrb.s.rb_prv.rb.crt * 60)		/* RH time in sec */
				 );
    if (s->st_ctime < s->st_mtime)	/* Ensure change date no earlier */
	s->st_ctime = s->st_mtime;	/* than last data-modify date */
    s->st_atime = tad64s_to_utime(XWD(f.xrb.s.rb_ext.rb.acd,0)); /* "ref" date */

#elif SYS_WTS
    if (err = _flookup((char *)NULL, &f, 0))	/* Use old short blk */
	return err;
    WTSUUO_ACVAL("PNAME", f.fs.fs_dev, &s->st_dev);
    s->st_ino = f.orb.arr[0] + f.orb.arr[1]	/* Make up a number */ 
	    + f.orb.arr[2] + f.orb.arr[3];	/* likely to be unique */
    s->st_mode = S_IFREG | t10prot(f.orb.s.rb_prv.rb.prv);
    s->st_uid = f.lerppn;			/* File owner - same as dir */

    s->st_size = ((unsigned) -f.orb.s.rb_ppn) >> 18;	/* Size in wds */

    /* Put together "last-written" time from absurd T10 format */
    s->st_mtime = tad64s_to_utime(XWD(		/* Convert stupid fmt */
	(f.orb.s.rb_ext.rb.crx << 12) | f.orb.s.rb_prv.rb.crd,	/* LH date */
	f.orb.s.rb_prv.rb.crt * 60)		/* RH time in sec */
				 );
    s->st_ctime = s->st_mtime;
    s->st_atime = tad64s_to_utime(XWD(f.orb.s.rb_ext.rb.acd,0)); /* "ref" date */
#endif

    /* Common T10-type code here */
    s->st_rdev = typinf;		/* Either DEVCHR or DEVTYP info */
    s->st_nlink = 1;			/* can it be anything else? */
    s->st_gid = ((unsigned)s->st_uid)>>18;
    if (s->st_atime < s->st_ctime)	/* Ensure access time always */
	s->st_atime = s->st_ctime;	/* has most recent date */

    /* Convert st_size for bytesize here ! */
    nbpw = sizeof(int);		/* Default # bytes per word */
    if (uf) {			/* If doing fstat, then know bytesize! */
	if (uf->uf_nbpw)
	    nbpw = uf->uf_nbpw;
	/* Worth trying to update length with CSI's GTEFS$ call?  Probably
	** not, would confuse block I/O which has to track EOF.
	*/
    }
    s->st_blocks = (s->st_size + UIO_T10_DSKWDS-1) / UIO_T10_DSKWDS;
    s->st_blksize = UIO_T10_DSKWDS * nbpw;	/* Size of a disk block */
    if (uf) s->st_size = uf->uf_flen;		/* If fstat, believe our EOF */
    else s->st_size *= nbpw;			/* Return # bytes */

    return 0;
}

/* T10PROT(prot) - convert a TOPS-10 disk protection code into UNIX format.
*/
#define UP_R 04		/* UNIX Read access */
#define UP_W 02		/* UNIX Write access */
#define UP_X 01		/* UNIX Execute/search access */

static unsigned
t10prot(prot)
unsigned prot;
{
	/* Protection-change, reName, Read, Write, eXecute, Update, Append */
    static unsigned map[8] = {
#if SYS_T10+SYS_CSI
	UP_R|UP_W|UP_X,		/* 0 .PTCPR  PNRWXUA	Full access */
	UP_R|UP_W|UP_X,		/* 1 .PTREN  -NRWXUA	*/
	UP_R|UP_W|UP_X,		/* 2 .PTWRI  --RWXUA	*/
	UP_R|UP_W|UP_X,		/* 3 .PTIPD  --R-XUA	*/
	UP_R|     UP_X,		/* 4 .PTAPP  --R-X-A	*/
	UP_R|     UP_X,		/* 5 .PTRED  --R-X--	Read-only (and xct) */
	          UP_X,		/* 6 .PTEXO  ----X--	Execute-only  */
	0,			/* 7 .PTNON  No access */
#elif SYS_WTS
	UP_R|UP_W|UP_X,		/* 0  PRW No protection */
	UP_R|     UP_X,		/* 1  PR- Write protect */
	     UP_W|UP_X,		/* 2  P-W Read protect */
	          UP_X,		/* 3  P-- R/W protect */
	UP_R|UP_W,		/* 4  -RW Protection protect */
	UP_R,			/* 5  -R-	*/
	     UP_W,		/* 6  --W	*/
	0,			/* 7  --- Full protection */
#endif
    };
    return map[prot&07]		/* Other (WAITS: not-logged-in) */
     | (map[(prot>>3)&07]<< 3)	/* Group (T10: project)(WAITS: logged-in) */
#if SYS_T10+SYS_CSI
     | (map[(prot>>6)&07]<< 6);	/* Owner */
#elif SYS_WTS
     | (map[(prot&0100) ? 1 : 0]<< 6);	/* Owner (only has 1 bit) */
#endif

}
#endif /* SYS_T10+SYS_CSI+SYS_WTS */

#endif /* T20+10X+T10+CSI+WAITS */
