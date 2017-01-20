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

#include <sys/usydat.h>
#include <sys/urtint.h>
#include <errno.h>
#include <string.h>
#include <sys/wait.h>

#if SYS_ITS
#include <sysits.h>
#endif

#if SYS_T20+SYS_10X
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

#if SYS_T20
#include <signal.h>
#define _ICAOV  monsym(".ICAOV")
#define _ICDAE  monsym(".ICDAE")
#define _ICFOV  monsym(".ICFOV")
#define _ICIEX  monsym(".ICIEX")
#define _ICIFT  monsym(".ICIFT")
#define _ICILI  monsym(".ICILI")
#define _ICIRD  monsym(".ICIRD")
#define _ICIWR  monsym(".ICIWR")
#define _ICMSE  monsym(".ICMSE")
#define _ICNXP  monsym(".ICNXP")
#define _ICPOV  monsym(".ICPOV")
#define _ICQTA  monsym(".ICQTA")
#endif /* SYS_T20 */

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

static int
setrusage(fkhand, rusage)
int fkhand;
struct rusage *rusage;
{
  int acs[5];

  /* Init structure to 0 */
  memset(rusage, 0, sizeof(struct rusage));

  /* Try to get desired runtime */
  acs[1] = fkhand;
  if (!jsys(RUNTM, acs)) return 0;
				/* On error, return success with 0 runtime */

  rusage->ru_utime.tv_sec = acs[1]/1000; /* Seconds */
  rusage->ru_utime.tv_usec = (acs[1]%1000)*1000; /* uSeconds */

  /* Just guess that system overhead is about 1/32 of runtime (approx. 3%). */
  acs[1] >>=5;
  rusage->ru_stime.tv_sec = acs[1]/1000; /* Seconds */
  rusage->ru_stime.tv_usec = (acs[1]%1000)*1000; /* uSeconds */

  /* And you just don't get the rest... */

  return 0;
}

int
getrusage(who, rusage)
int who;
struct rusage *rusage;
{
  int fkhand;

  switch (who) {
  case RUSAGE_SELF:
    fkhand = monsym(".FHSLF");	/* Get usage of self */
    break;

  case RUSAGE_CHILDREN:
    fkhand = monsym(".FHINF");	/* All inferior forks */
    break;

  default:
    errno = EINVAL;
    return -1;
  }
  return setrusage(fkhand, rusage);
}

#define FRKPTR(ptr, offset)\
  ((struct frkblk *)(ptr ? ptr + offset : 0))

static void
_rfrkh(struct frkblk *fkp, int offset, int release)
{
    int i, acs[5];

    /* Process all forks parallel to this one */
    for (i = 0; fkp; fkp = FRKPTR(fkp->fk_parp, offset)) {

      if (release) {
	  acs[1] = fkp->fk_hand;
	  jsys(RFRKH, acs);		/* Release this handle */
      }

      /* Process inferiors recursively */
      if (fkp->fk_infp)
	_rfrkh(FRKPTR(fkp->fk_infp, offset), offset, 1);
    }
}

static int
_wait(status, nohang, pid, rusage)
int *status, nohang;
pid_t pid;
struct rusage *rusage;
{
#if SYS_T20+SYS_10X
    int acs[5], i;
    int offset;		/* offset to add to pointers in frkarr */
			/* to get relative offset from start of table */
    struct frkblk *fkp;
    struct frkarr stkarr;	/* Big array on stack */
#if SYS_T20			/* Stuff in case using extended addressing */
    static int wrkflg = 0;
    static struct frkarr wrkarr;	/* GFRKS% stores stuff here */
    int facs[020];	/* Where to read fork acs */
    union wait fsts;	/* Where to construct return status */
    static struct {
	unsigned int sic:18;
	unsigned int sig:18;
      } sicsig [] = {
	{_ICAOV, SIGFPE},
	{_ICDAE, SIGURG},
	{_ICFOV, SIGFPE},
	{_ICIEX, SIGSEGV},
	{_ICIFT, SIGCHLD},
	{_ICILI, SIGILL},
	{_ICIRD, SIGSEGV},
	{_ICIWR, SIGSEGV},
	{_ICMSE, SIGILL},
	{_ICNXP, SIGSEGV},
	{_ICPOV, SIGSEGV},
	{_ICQTA, SIGXFSZ},
    };
#define NSICSIG (sizeof(sicsig)/sizeof(sicsig[0]))
#define CLRWRKFLG (wrkflg = 0)
#else
#define CLRWRKFLG
#endif

    USYS_BEG();

    for (;;) {

	fkp = &stkarr.fb[0];		/* Get pointer to stack workspace */

	if (pid) {			/* Specific fork? */
	    /* For single fork, fake up GFRKS data */
	    stkarr.fb[0].fk_hand = _FHSLF;
	    stkarr.fb[0].fk_infp = ((int)&stkarr.fb[1]) & RH;
					/* Make 1 child process */
	    stkarr.fb[0].fk_parp
	      = stkarr.fb[0].fk_supp
		= stkarr.fb[0].fk_status
		  = stkarr.fb[1].fk_infp
		    = stkarr.fb[1].fk_parp = 0;
					/* And no others */
	    stkarr.fb[1].fk_supp = ((int)&stkarr.fb[0]) & RH;
					/* Point to parent */
	    acs[1] = stkarr.fb[1].fk_hand = (pid >> 9) | 0400000;
					/* Construct fork handle */
	    if (!jsys(RFSTS, acs))	/* If failure, */
	      USYS_RETERR(ECHILD);	/* Return this error */
	    stkarr.fb[1].fk_status = acs[1];
	}
	else {
#if SYS_T20
	    if ((int)fkp & (-1<<18)) {	/* Check if extended addressing */
		if (wrkflg) {
		    _panic("wait() trying to re-use storage!");
		}
		wrkflg++;		/* Say storage blk now in use */
		fkp = &wrkarr.fb[0];	/* Point to static block */
	    }
#endif
	    acs[1] = _FHSLF;
	    acs[2] = GF_GFH|GF_GFS;	/* Get handle & status for each fork */
	    acs[3] = (-(sizeof(wrkarr)/sizeof(int))<<18) + ((int)fkp & 0777777);
	    if (jsys(GFRKS, acs) <= 0) {
#if SYS_T20
		wrkflg = 0;		/* Ensure clear if bomb out */
#endif
		USYS_RETERR(EFAULT);	/* Shouldn't happen! */
	    }
	}
	offset = (int)&stkarr - (((int)fkp) & 0777777);
					/* Remember offset to stack table */
#if SYS_T20
	if (wrkflg) {			/* If extended addressing, */
	    stkarr = wrkarr;		/* Copy results onto stack */
	    wrkflg = 0;			/* Then can release storage! */
	    fkp = &stkarr.fb[0];	/* Point to new loc */
	}		/* Note ptrs in blocks are now wrong! */
#endif
	/* Now scan list of inferior forks */
	fkp = FRKPTR(fkp->fk_infp, offset);
					/* Start with 1st inferior */
	_rfrkh(fkp, offset, 0);		/* Release unneeded handles */
	for (i = 0; fkp; fkp = FRKPTR(fkp->fk_parp, offset)) {
	    if ((fkp->fk_hand == USYS_VAR_REF(clfork))
		|| (fkp->fk_hand == ((USYS_VAR_REF(pippid) >> 9) | 0400000)))
	      continue;			/* Ignore CLOSF and pipe forks */
	    i++;			/* Count a program fork */
	    switch (fkp->fk_stafld.rf_sts) {
		default:
		    continue;		/* Not status we want, keep looking */
		case _RFHLT:		/* Process halted? */
		case _RFFPT:		/* Forced process termination? */
		    break;		/* Found one!  Break out */
	    }
	    break;	/* Stop loop */
	}
	if (i == 0) USYS_RETERR(ECHILD);/* If no program inferiors, return */
	if ((fkp == 0) && !nohang) {	/* If no stopped inferiors found, */
	    /* and not nohang, Then must wait for one! */
	    /* NOTE: This is actually not the right thing, because we don't
	    ** want to wait for ALL processes to stop, just ANY one of them.
	    ** But T20 has no easy way to do this, short of using
	    ** the TFORK monitor call intercept facility!  Ugh!
	    */
	    if (pid) acs[1] = (pid >> 9) | 0400000; /* Wait for specific, or */
	    else acs[1] = _FHINF;	/* All inferiors of current process */
	    i = jsys(WFORK|JSYS_OKINT, acs); /* Wait for them all to stop */
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

	if (fkp != 0) {
	    /* Found a stopped fork!  Take care of it... */
	    if (rusage) setrusage(fkp->fk_hand, rusage);
#if SYS_T20
	    acs[1] = fkp->fk_hand;
	    acs[2] = (int)facs;		/* Read fork acs here */
	    if (!jsys(RFACS, acs) || (facs[1] > 0177) || (facs[1] < -128))
	      facs[1] = 0;		/* Assume success if can't read acs */
					/* or status out of bounds */
#endif
	    acs[1] = fkp->fk_hand;
	    jsys(KFORK, acs);		/* Flush the fork */
	    if (status) {		/* Return fork status? */
#if SYS_T20
		fsts.w_status = 0;	/* Initialize return status */
		if (fkp->fk_stafld.rf_sts == _RFHLT)
		    fsts.__w_retcode = facs[1]; /* Get fork exit() value */
		else {			/* sts == _RFFPT */
		    fsts.__w_termsig = SIGSYS; /* default signal type */
		    for (i=0; i<NSICSIG; i++)
			if (fkp->fk_stafld.rf_sic == sicsig[i].sic) {
			    fsts.__w_termsig = sicsig[i].sig;
			    break;
			}
		}
		*status = fsts.w_status; /* Return constructed value */
#else
		if (fkp->fk_stafld.rf_sts == _RFHLT)
		    *status = 0;	/* Normal termination */
		else *status = fkp->fk_status;	/* Return T20 status */
#endif
	    }
	    /* Now return fork handle as a USYS PID */
	    jsys(GJINF, acs);		/* Get job # in AC3 */
	    USYS_RET(((fkp->fk_hand & 0777)<<9)
			    | (acs[3] & 0777));
        }
	else USYS_RET(0);	/* return 0 for wait3 WNOHANG */
    }


#else	/* Other systems don't hack processes yet */

    errno = ECHILD;
    return -1;
#endif
}

pid_t
wait(status)
int *status;
{
  return _wait(status, 0, 0, 0);
}

pid_t
wait3(status, options, rusage)
int *status, options;
struct rusage *rusage;
{
  return _wait(status, options & WNOHANG, 0, rusage);
}

pid_t
waitpid(wpid, status, options)
pid_t wpid;
int *status, options;
{
  int pid = ((wpid == -1) || (wpid == 0)) ? 0 : (wpid < -1 ? -wpid : wpid);

  return _wait(status, options & WNOHANG, pid, 0);
}

pid_t
wait4(wpid, status, options, rusage)
pid_t wpid;
int *status, options;
struct rusage *rusage;
{
  int pid = ((wpid == -1) || (wpid == 0)) ? 0 : (wpid < -1 ? -wpid : wpid);

  return _wait(status, options & WNOHANG, pid, rusage);
}
#endif /* T20+10X+T10+CSI+WAITS+ITS */
