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
#include <sys/usysig.h>
#include <setjmp.h>

static void `ljmpe`(), _ljmp();	/* Internal routines.  ljmpe() quoted
				** so that ASM code can refer to it by name.
				*/

int
_setjmp(env)
jmp_buf env;
{
	asm("	jrst setjmp\n");
}

int
setjmp(env)
jmp_buf env;
{
	asm(SIGCONTEXT_ASM);	/* Define asm offsets into sigcontext struct */
#asm
#if SYS_T20+SYS_10X
	search monsym		/* for debrk% */
	extern .intlev, .intpca
#endif
	extern .sigstk, .sigblockmask

	skipn 16,-1(17)		/* Get address of sigcontext struct */
	 pushj 17,ljmpe
	move 2,17		/* Get copy of stack ptr */
	pop 2,sc.pc(16)		/* Save return PC, and get bumped ptr */
	movem 2,sc.acs+17(16)	/* Save stack ptr */
	move 3,.sigstk+1
	movem 3,sc.stkflg(16)	/* Save flag saying if this is signal stack */
	move 4,.sigblockmask
	movem 4,sc.mask(16)	/* Save current signal block mask */
#if SYS_T20+SYS_10X
	hrlz 5,.intlev		/* Save interrupt level indicator */
	movem 5,sc.osinf(16)
#else
	setzb 5,sc.osinf(16)
#endif
	add 2,sc.pc(16)	/* AC2 already has stack ptr, add return addr */
	add 2,3		/* Add flag */
	add 2,4		/* Add mask */
	add 2,5		/* Add intlev */
	movem 2,sc.acs+2(16)	/* Store checksum! */
	setz 1,		/* Return zero */
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
	`ljmpe`();

    /* Ensure saved PC not zero, and Check the checksum */
    if (scp->sc_pc == 0
      || ((scp->sc_pc + scp->sc_acs[017]
	  + scp->sc_stkflg + scp->sc_mask + scp->sc_osinf)
	!= scp->sc_acs[2]))
	`ljmpe`();

    /* Compare stack pointers if possible */
    if ((scp->sc_stkflg != 0) == (_sigstk.ss_onstack != 0)) {
	/* If saved stack state is same as current stack state */
	if (scp->sc_acs[017] >= *(int *)017)	/* Compare stack ptrs! */
	    `ljmpe`();			/* Prev must be less than current! */
    } else if (scp->sc_stkflg)	/* States are different... */
	`ljmpe`();			/* error if prev was on sig stack! */

#if SYS_T20+SYS_10X
    if ((unsigned)scp->sc_osinf >> 18) {
	if (((unsigned)scp->sc_osinf >> 18) != _intlev)
	    `ljmpe`();		/* Cannot change to non-zero intlev */
    } else if (_intlev)
	flag |= LJ_DEINT;	/* Must get out of interrupt level */
#endif
    _ljmp(&env[0], val, flag);
}

/* Aux rtn so longjmp asm code can call symbol which is actually macro. */

static void
`ljmpe`()
{
    longjmperror();
    abort();
}

static void
_ljmp(scp, val, flag)
struct sigcontext *scp;
int val, flag;
{
#asm
	extern .sigtrigpend
	extern .sigusys, .sigpendmask

	skipn 16,-1(17)	/* Get sigcontext pointer */
	 pushj 17,ljmpe	/* If null pointer, go barf! */
	skipn 1,-2(17)	/* Get return value */
	 movei 1,1	/* If zero, substitute 1 */
	skipe 2,-3(17)	/* Get flags */
	 jrst ljmp2	/* Something set, do fancy stuff */

	/* No fancy stuff */
	skipe 15,sc.pc(16)	/* Get return address */
	 skipn 2,sc.acs+17(16)	/* Get new stack ptr */
	  pushj 17,ljmpe	/* If either is zero, go barf. */
	move 17,2
	jrst (15)		/* Return! */

	/* Fancy stuff, sigh.  Get everything we need into ACs. */
ljmp2:	move 3,sc.stkflg(16)	/* Get sigstk and mask */
	move 4,sc.mask(16)
	aos .sigusys		/* Ignore interrupts for a bit */
	skipe 15,sc.pc(16)	/* Get return addr */
	 skipn 7,sc.acs+17(16)	/* Get stack ptr */
	  pushj 17,ljmpe	/* If either is zero, go barf! */
	move 17,7		/* Restore stack ptr! */
	movem 3,.sigstk+1	/* Restore signal stack flag */
	push 17,15		/* Save return addr on new stack */
	trne 2,<LJ_SBMASK>	/* And if flag requests it, */
	 movem 4,.sigblockmask	/* restore signal block mask. */

#if SYS_T20+SYS_10X
	trnn 2,<LJ_DEINT>	/* Need to leave int level? */
	 jrst ljmp99		/* No, skip hairy stuff */

	/* Must leave int level with DEBRK% */
	skipn 7,.intpca		/* Get address of interrupt PC */
	 pushj 17,ljmpe		/* Barf if not set */
	xmovei 6,ljmp98
	movem 6,(7)		/* Store new PC (just below!) */
	debrk%			/* Now get out of int level! */
ljmp98:	setzm .intlev		/* Control "drops thru" to here... */
				/* Restore software idea of int level state */
ljmp99:
#endif
	push 17,1		/* Save return value */
#endasm
	asm(USYS_END_ASM);	/* Permit interrupts, take any pending ones */
	asm("	pop 17,1\n");	/* Restore return value, */
}				/* and return! (Retaddr was pushed on stack) */

#endif /* T20+10X+T10+CSI+WAITS+ITS */
