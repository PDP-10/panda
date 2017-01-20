/*
**	GETPID - USYS simulation of getpid().
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.30, 8-Jul-1987
**	(c) Copyright Ken Harrenstien, SRI International 1987
**
**	GFRKS% algorithm by Greg Satz / Stanford University / 15-Sep-84
**
**	See USYS.DOC for an explanation of the T20/10X PID encoding.
*/

#include <c-env.h>

#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS

#if SYS_T20+SYS_10X
#include <jsys.h>
#include <sys/usydat.h>

#elif SYS_T10+SYS_CSI+SYS_WTS
#include <muuo.h>
#endif

#if SYS_10X
#define	MAP_SIZE 100
struct fork_map {
	unsigned parap : 18;
	unsigned infp : 18;
	unsigned supp : 18;
	unsigned handle : 18;
	unsigned status;
	};
#endif /* 10X */

/* These must be externals so fork() and kill() can hack them. */

#if SYS_ITS
static int _getpid()
{
    asm(".suset [.ruind,,1]\n"); /* Get user idx # as ret val. */
}
#endif

pid_t
getppid()
{
    return 0;
}

pid_t
getpid()
{
#if SYS_T10+SYS_CSI+SYS_WTS
    /* PJOB returns job # */
    if (!USYS_VAR_REF(pidslf))
	MUUO_VAL("PJOB", &USYS_VAR_REF(pidslf));
				/* Get and store our job # as PID */
    return USYS_VAR_REF(pidslf);
#elif SYS_ITS
    /* Get user index # */
    if (!USYS_VAR_REF(pidslf)) USYS_VAR_REF(pidslf) = _getpid();
#elif SYS_T20
    /* T20 and 10X need to be careful to suspend interrupts as otherwise
    ** successive calls might return different values if both decide
    ** to generate a PID!
    */
	int acs[5], argblk[3];
	USYS_BEG();
	if (USYS_VAR_REF(pidslf)) /* Check now that ints are off */
	    USYS_RET(USYS_VAR_REF(pidslf));
	acs[1] = 3;		/* Length of arg blk */
	acs[2] = (int)argblk;	/* Addr of arg blk */
	argblk[0] = _MUCRE;	/* Function: create new PID */
	argblk[1] = _FHSLF;	/* for this process */
	if (jsys(MUTIL, acs) <= 0	/* Get PID! */
	  || jsys(GJINF, acs) <= 0)	/* and job # */
	    USYS_RET(-1);
	USYS_VAR_REF(pidslf) = (argblk[2] & ~0777777) | (acs[3] & 0777);
	USYS_RET(USYS_VAR_REF(pidslf));
#elif SYS_10X
	int cnt, ablock[5];
	struct fork_map *sup, *fmp, *count();
	struct fork_map fma[MAP_SIZE];

	USYS_BEG();		/* Disable interrupts */
	if (USYS_VAR_REF(pidslf)) /* Check now that ints are off */
	    USYS_RET(USYS_VAR_REF(pidslf));
	fmp = fma;
	ablock[1] = _FHTOP;
	ablock[2] = (int)fmp;
	if (jsys(GFRKS, ablock) <= 0	/* Get fork tree info */
	  || jsys(GJINF, ablock) <= 0)	/* Get job info */
		USYS_RET(-1);
	while (fmp->supp != 0)		/* find superior */
		fmp = (struct fork_map *) fmp->supp;
	sup = fmp;			/* save ptr to superior */
	cnt = 0;			/* initialize count */
	if (count(fmp, &cnt) == sup)	/* didn't find _FHSLF */
		USYS_RET(-1);
	/* Return job # and node cnt */
	USYS_VAR_REF(pidslf) = (cnt << 18) | (ablock[3] & 0777);
	USYS_RET(USYS_VAR_REF(pidslf));
#else
    return -1;
#endif
}

#if SYS_10X
/*
 * Count fork map in preorder
 */
static struct fork_map *
count(ptr, cnt)
struct fork_map *ptr;
int *cnt;
{
	struct fork_map *sptr = 0;

	(*cnt)++;		/* count fork */
	if (ptr->handle == _FHSLF)
		return ptr;

	if (ptr->infp != 0)		/* does inferior exist (left) */
		sptr = count((struct fork_map *)(ptr->infp), cnt);
	if (sptr == 0 && ptr->parap != 0)	/* check for parallel */
		sptr = count((struct fork_map *)(ptr->parap), cnt);
	return sptr;
}
#endif /* 10X */

#include <errno.h>

pid_t
getpgrp(pid)
pid_t pid;
{
  if (!pid) return getpid();
  else return pid;
}

int
setpgid(pid, pgrp)
pid_t pid, pgrp;
{
  if ((!pid && (pgrp == getpid()))
      || (pid == pgrp)) return 0;
  errno = EPERM;
  return -1;
}

int
setpgrp(pid, pgrp)
pid_t pid, pgrp;
{
  return setpgid(pid, pgrp);
}

pid_t
setsid()
{
  return getpid();
}

#endif /* T20+10X+T10+CSI+WAITS+ITS */
