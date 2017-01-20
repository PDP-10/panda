/*
**	SIGDAT - Signal Data module.
**
**	(c) Copyright Ken Harrenstien 1989
**
**	The reason this module exists is to define certain globals which
** must always exist whether or not the program actually invokes signal()
** or sigvec(); all USYS routines refer to these globals and hence they
** must always be present.  By separating them from the sigvec() code we
** can avoid loading the bulk of the signal stuff if it is never used.
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported for */

#include <signal.h>
#include <sys/usysig.h>		/* Check for type clashes */

int _sigusys;			/* Positive if within critical USYS code */
unsigned int _sigpendmask;	/* Mask of pending signals */
				/* Ints can add to this during _sigusys. */
unsigned int _sigblockmask;	/* Mask of signals to block */
				/* Ints cannot change this during _sigusys. */
struct sigstack _sigstk;	/* Alternate stack pointer */
				/* This is in SIGDAT so setjmp can find it. */
struct sigcontext *_sigframe;	/* Current signal stack frame, for debugging */

#if SYS_T20+SYS_10X	/* Additional globals for T20/10X */
unsigned _chnpendmask;		/* Mask of PSI channel ints pending */
unsigned _sigcmask[_NSIGS+1];	/* Chan bits for each signal */
int _intlev;			/* Current PSI interrupt level in progress */
int *_intpca;			/* Interrupt PC address */

static int dummy(){ return(0);}
int (*_doati)() = dummy;	/* Dispatch vector for TTY int setup */

/* _SIGTRIGPEND - Internal rtn called to process any pending signals.
**	Should ONLY be called when _sigusys is zero.  Thus, interrupts
** can be serviced during this call, and no further additions to _sigpendmask
** or _chnpendmask will happen.  We determine whether any signals can now
** be taken, and if so derive a mask of the PSI channel bits for those signals,
** and for those which are actually pending we trigger them all at once.
**	This routine returns one of three values:
**	0  - nothing happened.
**	-1 - interrupt was triggered.
**	+1 - interrupt was triggered, but handler permits restarting syscall.
** The latter return value can only happen if the PSI handling code in SIGVEC
** bumps the PC accordingly.  This is the reason for the _sigtx label, so
** the "pclsr" routine can check for this case.
*/
int
_sigtrigpend()
{	
#asm
	search monsym
	extern abort
	intern .sigtx		/* So sigvec can find this symbol */

	skipn 1,.sigpendmask
	 popj 17,		/* No pending signals, return 0 */
	andcm 1,.sigblockmask	/* Get (_sigpendmask & _sigblockmask) */
	skipn 4,1		/* If no pending signals permitted */
	 popj 17,		/* then return 0 without doing anything */
	jsp 15,.cnvmask		/* Convert sig mask to channel mask */
	and 2,.chnpendmask	/* Only pass on those chans actually pending */
	cain 2,			/* Double-check */
	 pushj 17,abort		/* No PSI bits?  Something's wrong!! */
	movei 1,.fhslf		/* Mask is ready, set up for IIC */
	iic%			/* Trigger the interrupts! */
.sigtx:
	skipa 1,[-1]		/* Normal return says interrupt happened */
	 movei 1,1		/* Special return if sigvec diddles PC */
	popj 17,		/* All done... */

/* _CNVMASK - special support.  Converts signal mask to channel mask.
**	This uses a JSP call so it can be used by the interrupt handlers
** in SIGVEC.C without touching the stack.
**	Calling sequence:
**		MOVE 4,<signal mask>
**		JSP 15,.CNVMASK
**		<returns channel mask in AC2>
** Clobbers 3,4,5 (and 15)
*/
	intern .cnvmask		/* So sigvec() module can get at this */
.cnvmask:
	setz 2,			/* Set up PSI channel mask */
	movei 3,44		/* Set up starting signal # */
cnvlup:	jffo 4,.+2		/* Find 1st 1 and skip if found */
	 jrst (15)		/* No ones left, return! */
	lsh 4,1(5)		/* Found a bit, shift that bit out */
	subi 3,1(5)		/* Bump current signal # down */
	ior 2,.sigcmask+1(3)	/* Add channel mask for this signal */
	jrst cnvlup		/* Back to get any remaining bits */
#endasm
}
#endif /* T20+10X */

/* Dummy _SIGTRIGPEND for systems that don't have interrupts */

#if SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS
extern void _panic();

int _sigtrigpend()
{
    /* We don't do interrupts yet, so this should never happen */
    _panic("_sigtrigpend: can't happen");
}
#endif /* T10+CSI+WAITS+ITS */

#endif /* T20+10X+T10+CSI+WAITS+ITS */
