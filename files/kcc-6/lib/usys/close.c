/*
**	CLOSE - lowest-level URT closefile
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.60, 11-Aug-1988
**	Copyright (C) 1986 by Ian Macky, SRI International
**	Edits for ITS: Copyright (C) 1988 Alan Bawden
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported for */

#include <errno.h>
#include <stddef.h>		/* for NULL */
#include <sys/usydat.h>
#include <sys/c-debug.h>

#if SYS_T20+SYS_10X
#include <jsys.h>
extern int `$STDER`;

#elif SYS_T10+SYS_CSI+SYS_WTS
#include <muuo.h>
int _blkfin();			/* From write() */
int _opnrel();			/* From open() */

#elif SYS_ITS
#include <sysits.h>
#endif

#if SYS_T20+SYS_10X

USYS_VAR_TO_ASM(clfork,`clfork`);
USYS_VAR_TO_ASM(nfork,`nforks`);
USYS_VAR_TO_ASM(sigusys,`sigusys`);

static void `fkclsx`()
{
  if (0) `fkclsx`();
  USYS_END();
}


static _fkclose(int jfn)
{
  if (0) (jfn++, `clfork`++, `nforks`++, `sigusys`++);
#asm
	SEARCH MONSYM			/* Uppercase to avoid monsym() clash */
	aos	USYS_VAR_ASM_REF(sigusys) /* Don't allow interrupts */
	skipe	1,USYS_VAR_ASM_REF(clfork)/* Do we have a CLOSF fork yet? */
	 jrst	fkcls1			/* Yes, use it */
fkrst1:	move	1,[cr%cap]		/* Same caps */
	cfork%				/* Make a fork */
	 erjmp	fkclse			/* Jump on error */
	movem	1,USYS_VAR_ASM_REF(clfork)/* Set CLOSF fork */
	aos	USYS_VAR_ASM_REF(nforks) /* Count a fork created */
	jrst	fkcls2			/* Bypass state checks */

fkcls1:	movei	4,10			/* Wait count */
fkcls4:	move	1,USYS_VAR_ASM_REF(clfork)/* Get fork handle again */
	rfsts%				/* Read fork status */
	 erjmp	fkrest			/* Jump on error, restart fork */
	hlrz	1,1			/* Get status code in RH */
	andi	1,(<rf%sts>)		/* 	"     */
	caie	1,.rfslp		/* Must be sleeping */
	 jrst	fkcls3			/* Else check if should wait */
	hrrz	2,2			/* Get RH of PC */
	caie	2,frkhlt-frkacs		/* And at this PC */
	 jrst	fkrest			/* Else restart fork */
	move	1,USYS_VAR_ASM_REF(clfork)/* Get fork handle again */
	ffork%				/* Freeze it */
	 erjmp	fkclse			/* Restart on error */
fkcls2:	xmovei	2,frkacs		/* Where to load regs from */
	move	3,-1(17)		/* Get JFN */
	movem	3,frkjfn		/* Place in subfork AC1 */
	movem	3,frkjf2		/* Place in subfork AC2 */
	sfacs%				/* Set subfork regs */
	 erjmp	fkclse			/* Restart on error */
	movei	2,frkst-frkacs		/* Start address */
	sfork				/* Start subfork */
	 erjmp	fkclse			/* Restart on error */
	rfork				/* Resume in case we froze it */
	 erjmp	fkclse			/* Restart on error */
	pushj	17,fkclsx		/* Allow interrupts */
	seto 1,				/* Indicate success */
	popj 17,

/* Come here if close subfork not haltf'd yet */
fkcls3:	sojl	4,fkclse		/* Jump if wait count out */
	movei	1,^D100			/* 1/10th second each time */
	disms%				/* Wait */
	jrst	fkcls4			/* And try again */

/* Come here to kill close subfork and restart */
fkrest:	move	1,USYS_VAR_ASM_REF(clfork)/* Get fork handle */
	setzm	USYS_VAR_ASM_REF(clfork) /* And clear it */
	kfork
	 erjmp	.+1
	jrst fkrst1

/* Come here if can't use close subfork */
fkclse:	pushj	17,fkclsx		/* Allow interrupts */
	setz 1,				/* Indicate failure */
	popj 17,

%%DATA

frkacs:	0				/* AC0 */
frkjfn:	0				/* AC1 JFN passed here */
frkjf2:	0				/* AC2 JFN passed here */
	0				/* AC3 */
	0				/* AC4 */
frkst:	closf%				/* AC5 Try normal close */
	 skipa 1,2			/* AC6 Copy JFN back into 1, skip */
	  jrst frklp-frkacs		/* AC7 Done */
	tlo 1,(<CZ%ABT>)		/* AC10 Set Abort */
	closf%				/* AC11 Try close and abort */
	 skipa 1,2			/* AC12 Copy JFN back into 1, skip */
	  jrst frklp-frkacs		/* AC13 Done */
	rljfn%				/* AC14 Try to release JFN */
	 jfcl				/* AC15 Can't win */
frklp:	wait%				/* AC16 */
frkhlt:	jrst frklp-frkacs		/* AC17 */

%%CODE

#endasm
}
#endif /* SYS_T20+SYS_10X */

int _ufclose(fd, uf)
int fd;
register struct _ufile *uf;
{
#if SYS_T20+SYS_10X
#define _NULIO monsym(".NULIO")
    int acs[5];
#endif
    struct _ufile tuf;
    int clchld = (uf != 0);
    int res;

    USYS_BEG();
    if (!uf) {
	if (!(uf = _UFGET(fd)))
	    USYS_RETERR(EBADF);

	/* FD is valid, always zap its mapping slot */
	USYS_VAR_REF(uffd[fd]) = 0; /* Zap it! */
    }

    USYS_LOCK(USYS_VAR_REF(uflock)); /* Claim interlock */
#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_UIO_FDSHR) {
	_dbgl("CLOSE&_ufclose(fd ");
	if (!clchld) _dbgd(fd);
	else _dbgs("child");
	_dbgs(", uf ");
	_dbgd(uf-USYS_VAR_REF(uftab));
	_dbgs("/ nopen=");
	_dbgd(uf->uf_nopen - 1);
	_dbgs(", jfn=");
	_dbgj(uf->uf_ch);
	_dbgs(")\r\n");
    }
#endif
    if (--uf->uf_nopen > 0) {		/* If still have FDs open for file, */
	USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
	USYS_RET(0);			/* and return successfully */
    }
    uf->uf_nopen = 0;			/* Ensure UF no longer in use */
    tuf = *uf;				/* Copy data structure to temp space */
    uf->uf_buf = NULL;			/* Clear buffer pointer */
    USYS_UNLOCK(USYS_VAR_REF(uflock));	/* Release interlock */

    /* No FDs left with this UF active, so must really close the UF now.
    ** From this point on, return value must be "res" unless outright error.
    */
    res = 0;
    if (tuf.uf_type == UIO_DVTTY)	/* If was a TTY device, */
	USYS_VAR_REF(ttys[tuf.uf_dnum].tt_uf) = 0; /* Release the tty struct */
#if SYS_T10+SYS_CSI+SYS_WTS
    if (tuf.uf_flgs & UIOF_BLKDEV)	/* If I/O to block device, */
	if (_blkfin(uf))		/* finalize current buffer! */
	    res = -1;			/* Ugh, fail later on. */
#endif
    if (tuf.uf_buf)			/* If had a block or conversion buf, */
	_iobfre(tuf.uf_buf);		/* free up the buffer! */

#if SYS_T20+SYS_10X
    switch (tuf.uf_ch) {
    case _CTTRM:			/* Controlling terminal */
    case _PRIIN:			/* Primary input */
    case _PRIOU:			/* Primary output */
	break;				/* Do nothing */
    default:				/* Close all others */
	acs[1] = _FHSLF;		/* Avoid closing primary JFNs */
	if (!jsys(GPJFN, acs)
	    || (((acs[2] & RH) != tuf.uf_ch)
		&& (((acs[2]>>18) & RH) != tuf.uf_ch))) {
	  acs[1] = acs[2] = tuf.uf_ch;	/* Put JFN in ACs 1 & 2 */


	  if (tuf.uf_ch != `$STDER`) {	/* Avoid close stderr passed via env */
	    if ((!clchld || !_fkclose(tuf.uf_ch))
					/* If close for child, try subfork */
		&& !jsys(CLOSF, acs)) {	/* Else close right here */
	      acs[1] = monsym("CZ%ABT")|tuf.uf_ch; /* Try abort version */
	      if (!jsys(CLOSF, acs)) {	/* Close hard! */
		acs[1] = tuf.uf_ch;	/* If that fails, restore JFN */
		jsys(RLJFN, acs);	/* and try to release JFN */
	      }
	      USYS_RETERR(ECLOSE);	/* Still return error */
	    }
	  }
	}
    }

#elif SYS_T10+SYS_CSI+SYS_WTS
    if (tuf.uf_ch == UIO_CH_CTTRM)	/* Can't close controlling term */
	USYS_RET(res);
    else {
	int err;
	if (err = _opnrel(uf))		/* Release I/O ch using open() code */
	    USYS_RETERR(err);
    }

#elif SYS_ITS
    if (tuf.uf_flgs & UIOF_WRITE) {
	if ((tuf.uf_flgs & UIOF_HANDPACK) && (tuf.uf_zcnt > 0)) {
	    int padcount = tuf.uf_nbpw - tuf.uf_zcnt;
	    /* You never pad > 35 bytes */
	    _outblock(uf, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", &padcount);
	    if (padcount != 0) USYS_RETERR(EIO);	/* Barf! */
	}
	SYSCALL1("finish", tuf.uf_ch);	/* Ignore failure */
    }
    SYSCALL1_LOSE("close", tuf.uf_ch);	/* Cannot fail */
#endif

    USYS_RET(res);			/* Return 0 for success, -1 if fail */
}

int close(fd)
int fd;
{
    return _ufclose(fd, (struct _ufile *)0);
}

#endif /* T20+10X+T10+CSI+WAITS+ITS */
