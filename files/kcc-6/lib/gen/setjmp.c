/*
**	SETJMP	- setjmp() and longjmp().
**
**	(c) Copyright Ken Harrenstien, SRI International 1987
**
** Must be closely coordinated with signal code as we must be able
** to longjmp() out of a signal handler!
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported for */

#include <stddef.h>		/* for NULL */
#include <stdlib.h>		/* abort */
#include <sys/usydat.h>		/* System data */
#include <setjmp.h>

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* setjmp.c */
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	
static int `stojmp` P_((int stk,int pc,struct sigcontext *scp));
static void ljmpe P_((void));
static void _ljmps P_((int pc,int stk));
static void _debrk P_((int *pca));
static void _ljmp P_((struct sigcontext *scp,int val,int flag));
#endif 

#undef P_

int
_setjmp(env)
jmp_buf env;
{
	asm("	jrst setjmp\n");
}

static int `stojmp`(stk, pc, scp)
int stk, pc;
struct sigcontext *scp;
{
  if (0) `stojmp`(stk, pc, scp);	/* Make compiler happy */
  if (!scp) ljmpe();			/* Error if no jmp_buf */
  scp->sc_pc = pc;			/* Save return PC */
  scp->sc_acs[017] = stk;		/* Save return stack */
  scp->sc_stkflg = USYS_VAR_REF(sigstk.ss_onstack);
					/* Save signal stack flag */
  scp->sc_mask = USYS_VAR_REF(sigblockmask);
					/* Save current signal block mask */
#if SYS_T20+SYS_10X
  scp->sc_osinf = USYS_VAR_REF(intlev) >> 18;
					/* Save interrupt level indicator */
#else
  scp->sc_osinf = 0;
#endif
  scp->sc_acs[2] = (scp->sc_acs[017]	/* Compute checksum */
		    + scp->sc_pc
		    + scp->sc_stkflg
		    + scp->sc_mask
		    + scp->sc_osinf);
}

int
setjmp(env)
jmp_buf env;
{
#asm
	move 2,17		/* Get copy of stack */
	pop 2,1			/* Adjust for later return */
	push 17,2		/* Pass as first arg */
				/* other 2 are PC and env */
	pushj 17,stojmp		/* Fill jmp_buf */
	adjsp 17,-1		/* Remove our arg */
	setz 1,			/* Return zero */
#endasm
}

/* Local flags for _ljmp() use. */
#define LJ_SBMASK 01	/* Restore old signal block mask */
#define LJ_DEINT 02	/* Leave interrupt level */


void
_longjmp(env, val)
jmp_buf env;
int val;
{
    _ljmp(&env[0], val, 0);
}

void
longjmp(env, val)
jmp_buf env;
int val;
{
    int flag = LJ_SBMASK;	/* longjmp always restores block mask */
    register struct sigcontext *scp = &env[0];

    /* Check the jmp_buf environment carefully... */
    if (scp == NULL)		/* First check for valid pointer */
	ljmpe();

    /* Ensure saved PC not zero, and Check the checksum */
    if (scp->sc_pc == 0
      || ((scp->sc_pc + scp->sc_acs[017]
	  + scp->sc_stkflg + scp->sc_mask + scp->sc_osinf)
	!= scp->sc_acs[2]))
	ljmpe();

    /* Compare stack pointers if possible */
    if ((scp->sc_stkflg != 0) == (USYS_VAR_REF(sigstk.ss_onstack) != 0)) {
	/* If saved stack state is same as current stack state */
	if (scp->sc_acs[017] >= *(int *)017)	/* Compare stack ptrs! */
	    ljmpe();			/* Prev must be less than current! */
    } else if (scp->sc_stkflg)	/* States are different... */
	ljmpe();			/* error if prev was on sig stack! */

#if SYS_T20+SYS_10X
    if ((unsigned)scp->sc_osinf >> 18) {
	if (((unsigned)scp->sc_osinf >> 18) != USYS_VAR_REF(intlev))
	    ljmpe();		/* Cannot change to non-zero intlev */
    } else if (USYS_VAR_REF(intlev))
	flag |= LJ_DEINT;	/* Must get out of interrupt level */
#endif
    _ljmp(&env[0], val, flag);
}

/* What to do on longjmp errors */
static void
ljmpe()
{
    longjmperror();
    abort();
}

static void
_ljmps(pc, stk)
int pc, stk;
{
#asm
	move 1,-3(17)		/* Get return value */
	move 15,-2(17)		/* Get new PC */
	move 17,-1(17)		/* Get new stack */
	jrst (15)		/* Return! */
#endasm
}

static void
_debrk(pca)
int *pca;
{
#asm
	SEARCH MONSYM		/* for debrk% */

	move 7,-1(17)		/* Get address of PC to change */
	xmovei 6,ljmp99		/* Where to go */
	movem 6,(7)		/* Set it */
	debrk%			/* Get out of interrupt level */

ljmp99:				/* And then return */
#endasm
}

static void
_ljmp(scp, val, flag)
struct sigcontext *scp;
int val, flag;
{
  int pc, stk;

  if (!scp || !(pc = scp->sc_pc) || !(stk = scp->sc_acs[017]))
    ljmpe();			/* Bad values */
  if (val == 0) val = 1;	/* If return value = 0, substitute 1 */
  if (flag) {
    USYS_BEG();			/* Don't allow interrupts */
    USYS_VAR_REF(sigstk.ss_onstack) = scp->sc_stkflg;
				/* Restore signal stack flag */
    if (flag & LJ_SBMASK) USYS_VAR_REF(sigblockmask) = scp->sc_mask;
#if SYS_T20+SYS_10X
    if (flag & LJ_DEINT) {
      if (!USYS_VAR_REF(intpca)) ljmpe();
      _debrk(USYS_VAR_REF(intpca));
      USYS_VAR_REF(intlev) = 0;	/* No longer at interrupt level */
    }
#endif
    USYS_END();			/* Interrupts OK again */
  }
  _ljmps(stk, pc, val);		/* Now return to previous context */
}

#endif /* T20+10X+T10+CSI+WAITS+ITS */
