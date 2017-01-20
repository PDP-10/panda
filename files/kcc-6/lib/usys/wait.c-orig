/*
**	WAIT - simulation of wait(2) system call
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.35, 15-Mar-1989
**	(c) Copyright Ken Harrenstien, SRI International 1987
**	Edits for ITS:  Copyright (C) 1988 Alan Bawden
**
**	Returns -1 if no more forks or if interrupted.
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported (?) */

#include <sys/usysig.h>
#include <errno.h>

#if SYS_ITS
#include <sysits.h>
#endif

#if SYS_T20+SYS_10X
extern void _panic();	/* From URT */

#if 0
	The miserable code here for T20 is necessary because of the
incredibly losing way that T20/10X handles forks.  For one thing,
WFORK% hangs forever if there are no inferiors!  For another, there is
no way to identify which fork has stopped other than by examining the
entire fork structure with GFRKS%!  And finally, GFRKS% can only work
within a single section, which is why extended-addressing code must
keep a temporary static buffer and copy it to the stack, hoping that
nothing else clobbers it in the meantime.  Barf, choke, puke.
#endif

#include <jsys.h>

#define MAXFRK 30		/* Max # of forks we expect to see */

struct frkblk {
	unsigned fk_parp : 18;	/* Parallel ptr */
	unsigned fk_infp : 18;	/* Inferior ptr */
	unsigned fk_supp : 18;	/* Superior ptr */
	unsigned fk_hand : 18;	/* Fork handle */
	union {
	    int wd;
	    struct {		/* Fork status word */
		unsigned rf_frz : 1;	/* Frozen bit */
		unsigned rf_sts : 17;	/* Status code */
		unsigned rf_sic : 18;	/* PSI channel causing termination */
	    } bits;
	} fk_stat;
};
#define fk_stafld fk_stat.bits		/* For getting at status bits */
#define fk_status fk_stat.wd		/* For getting at whole word */

struct frkarr {
	struct frkblk fb[MAXFRK];
};
#endif /* T20+10X */

int
wait(status)
int *status;
{
#if SYS_T20+SYS_10X
    int acs[5], i;
    int oldbase;	/* RH to subtract from pointers in frkarr */
			/* to get relative offset from start of table */
    struct frkblk *fkp;
    struct frkarr stkarr;	/* Big array on stack */
#if SYS_T20			/* Stuff in case using extended addressing */
    static int wrkflg = 0;
    static struct frkarr wrkarr;	/* GFRKS% stores stuff here */
#define CLRWRKFLG (wrkflg = 0)
#else
#define CLRWRKFLG
#endif

    USYS_BEG();

    for (;;) {

	fkp = &stkarr.fb[0];		/* Get pointer to stack workspace */
#if SYS_T20
	if ((int)fkp & (-1<<18)) {	/* Check if extended addressing */
	    if (wrkflg) {
		_panic("wait() trying to re-use storage!");
	    }
	    wrkflg++;			/* Say storage blk now in use */
	    fkp = &wrkarr.fb[0];	/* Point to static block */
	}
#endif
	oldbase = ((int)fkp) & 0777777;	/* Remember RH of table addr */
	acs[1] = _FHSLF;
	acs[2] = GF_GFH|GF_GFS;		/* Get handle & status for each fork */
	acs[3] = (-(sizeof(wrkarr)/sizeof(int))<<18) + ((int)fkp & 0777777);
	if (jsys(GFRKS, acs) <= 0) {
#if SYS_T20
	    wrkflg = 0;			/* Ensure clear if bomb out */
#endif
	    USYS_RETERR(EFAULT);	/* Shouldn't happen! */
	}
#if SYS_T20
	if (wrkflg) {			/* If extended addressing, */
	    stkarr = wrkarr;		/* Copy results onto stack */
	    wrkflg = 0;			/* Then can release storage! */
	    fkp = &stkarr.fb[0];	/* Point to new loc */
	}		/* Note ptrs in blocks are now wrong! */
#endif
	/* Now scan list of inferior forks */
	fkp = (struct frkblk *)fkp->fk_infp;	/* Start with 1st inferior */
	if (fkp == 0)			/* If no inferiors, */
	    USYS_RETERR(ECHILD);	/* WFORK lied, return failure! */
	for (; fkp; fkp = (struct frkblk *)fkp->fk_parp) {

	    /* Get real pointer by adding table addr to offset within table */
	    fkp = (struct frkblk *) ((int)&stkarr + ((int)fkp - oldbase));
	    switch (fkp->fk_stafld.rf_sts) {
		default:
		    continue;		/* Not status we want, keep looking */
		case _RFHLT:		/* Process halted? */
		case _RFFPT:		/* Forced process termination? */
		    break;		/* Found one!  Break out */
	    }
	    break;	/* Stop loop */
	}
	if (fkp == 0) {		/* If no stopped inferiors found, */
	    /* Then must wait for one! */
	    /* NOTE: This is actually not the right thing, because we don't
	    ** want to wait for ALL processes to stop, just ANY one of them.
	    ** But T20 has no easy way to do this, short of using
	    ** the TFORK monitor call intercept facility!  Ugh!
	    */
	    acs[1] = _FHINF;		/* All inferiors of current process */
	    i = jsys(WFORK|JSYS_OKINT, acs);	/* Wait for them all to stop */
	    if (i == 0)
		USYS_RETERR(ECHILD);	/* Assume no forks */
	    if (i < 0) {		/* Interrupted? */
		if (USYS_END() < 0) {	/* Yeah, take it, see if must fail */
		    errno = EINTR;	/* Fail, sigh */
		    return -1;
		}
		USYS_BEG();		/* Otherwise disable ints again */
		continue;		/* and re-try the call! */
	    }
	    continue;	/* A fork stopped!  Go try to identify it. */
	}

	/* Found a stopped fork!  Take care of it... */
	acs[1] = fkp->fk_hand;
	jsys(KFORK, acs);		/* Flush the fork */
	if (status) {			/* Return fork status? */
	    if (fkp->fk_stafld.rf_sts == _RFHLT)
		*status = 0;		/* Normal termination */
	    else *status = fkp->fk_status;	/* Return T20 status */
	}
	/* Now return fork handle as a USYS PID */
	jsys(GJINF, acs);		/* Get job # in AC3 */
	USYS_RET(((fkp->fk_hand & 0777)<<9)
			| (acs[3] & 0777));
    }


#else	/* Other systems don't hack processes yet */

    errno = ECHILD;
    return -1;
#endif
}

#endif /* T20+10X+T10+CSI+WAITS+ITS */
