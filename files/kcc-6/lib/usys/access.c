/*
**	ACCESS - determine accessibility of file.
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.10, 5-Jul-1987
**
** Original version by David Eppstein / Stanford University / 9-Aug-84
** TENEX additions by Ken Harrenstien, SRI 1-Jun-85
**	TENEX does not have the CHKAC JSYS.  This routine will at the moment
**	always succeed on TENEX (unless the file doesn't exist).
**	Eventually a simulation can be coded.
*/

#include <c-env.h>

#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS	/* Systems implemented for */

#include <errno.h>
#include <sys/urtint.h>

#if SYS_T20+SYS_10X
#include <jsys.h>
#include <sys/param.h>
#include <sys/c-parse.h>
#elif SYS_T10+SYS_CSI+SYS_WTS
#include <muuo.h>
#endif

#include <sys/file.h>
#include <sys/usydat.h>

int access(filnam, mode)
const char *filnam;
int  mode;
{
#if SYS_T20+SYS_10X
    int jfn;

    USYS_BEG();
    if (!(jfn = _gtjfn(filnam, O_RDONLY|O_T20_NO_DIR))
				/* get JFN on the file */
	&& !(jfn = _parse(filnam, _PARSE_IN_DIR, _prdir))) /* or dir # */
	    USYS_RETERR(ENOENT);
#endif
#if SYS_10X
    _rljfn(jfn);
    USYS_RET(0);		/* If TENEX always claim win for now,
				 * because we don't have CHKAC% */
#elif SYS_T20
    if ( ((mode & R_OK) && !_chkac(_CKARD, _CKADR, jfn)) /* can't read? */
      || ((mode & W_OK) && !_chkac(_CKAWR, _CKACF, jfn)) /* can't write? */
      || ((mode & X_OK) && !_chkac(_CKAEX, _CKADR, jfn))) /* can't execute? */
	USYS_RETERR(EACCES);		/* Say permission denied */
    if (!(jfn & LH)) _rljfn(jfn);	/* release the JFN */
    USYS_RET(0);			/* return success */

#elif SYS_T10+SYS_CSI+SYS_WTS
    struct chkblk {
	unsigned acode : 18;
	unsigned ufdpro : 9;
	unsigned filpro : 9;
	int filppn;
	int usrppn;
    } ckb;
    struct _filehack f;
    int err;

    USYS_BEG();
    if (err = _flookup(filnam, &f, LER_OLD))
	USYS_RETERR(err);		/* Doesn't exist or couldn't read */

    /* Now we know that F_OK and R_OK are OK, so check the rest */
    if (mode & (X_OK|W_OK)) {
#if !(SYS_WTS)
	ckb.ufdpro = 0;
	ckb.filpro = f.orb.s.rb_prv.rb.prv;
	if (!(ckb.filppn = f.lerppn))	/* If no PPN parsed, get from dev */
	    MUUO_ACVAL("DEVPPN",		/* which _flookup set up */
			f.filop.fo_dev,		/* in here. */
			&ckb.filppn);
	MUUO_VAL("GETPPN", &ckb.usrppn);
	if (mode & W_OK) {
	    ckb.acode = uuosym(".ACWRI");
	    if (MUUO_ACVAL("CHKACC", (int)&ckb, &err)==0)
		err = -1;
	}
	if (!err && (mode & X_OK)) {
	    ckb.acode = uuosym(".ACEXO");
	    if (MUUO_ACVAL("CHKACC", (int)&ckb, &err)==0)
		err = -1;
	}
	if (err)
	    USYS_RETERR(EACCES);
#endif /* !WTS */
    }
    USYS_RET(0);

#else
    return -1;
#endif
}

#endif /* T20+10X+T10+CSI+WTS */
