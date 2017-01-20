/* JSYS - perform TOPS-20/TENEX JSYS system call
**
**	Copyright (c) 1988 by Ken Harrenstien, SRI International
**
**	jsys(num, ablock);
**	int num, ablock[5];
**
** Returns:
**	-3 JSYS not executed -- bad arguments to jsys()
**	-2 JSYS not executed -- interrupted beforehand
**	-1 JSYS interrupted during execution
**	 0 JSYS failed; system error code in ablock[0]
**	+1 JSYS won, returned +1
**	+2 JSYS won, returned +2
**	+3 JSYS won, returned +3
*/

#include <c-env.h>
#if SYS_T20+SYS_10X		/* Systems supported for */

#include <jsys.h>
#include <sys/usysig.h>		/* Must interface with signal handling */

#if 0
	Stuff which must exist in jsys() so as to cooperate with
sigvec() and signal interrupt handling:

External symbols
	.JSBEG,	.JSEND	- range of instructions for which further checking
		will be done at PSI time.  .JSBEG should label the first and
		.JSEND the last (not the first-after-last!).
	.JSCCT - AOBJN pointer to the Critical Code Table.
		Each entry is the address of a critical instruction.
	.JSINT	- Location that control will jump to if an interrupt causes
		an abort of the jsys() call.

When a PSI happens, if the PC is not between .JSBEG and .JSEND
(inclusive) then nothing special is done.  But if it is, further
checking happens: if the PC is a monitor PC (i.e. interrupted from a
JSYS) OR if the PC matches any location listed in the critical code
table, AND the flags in AC15 permit interrupts, the PC is changed to
point to .JSINT and control after the interrupt will resume there.
Fine detail: if the PC was in the critical code table rather than
a monitor PC then control will resume at .JSINT-1 instead of .JSINT.
This indicates that the JSYS was never executed at all.

	if (.jsbeg <= PC && PC <= .jsend)
	  {	/* In checkable range of jsys() */
		if (  (monitor-PC || PC-in-.jscct)
		   && (ac15 & JSYS_OKINT))
			Return to .jsint;
	  }

AC15 should be set properly whenever in the checkable range.

When jsys() is invoked by a USYS routine (.sigusys is set) and the
interrupts are permitted for the call, then jsys() must do some special
checking to make sure that there are no pending signals.  If any are
pending then jsys() must return immediately without even invoking the JSYS
at all, by jumping to .JSINT-1.  The sole reason for the existence of the
.JSCCT table is so that there are no holes between the time this check
is made and the time the JSYS is actually executed.

	See the USYS files SIGVEC.C and SIGNAL.DOC for further details.
#endif


int
jsys(num, ablock)
int num, *ablock;
{
#asm
	SEARCH MONSYM		/* Uppercase so no conflict with monsym() */
	extern $$sect
	extern .sigusys, .sigblockmask, .sigpendmask	/* Imported syms */
	intern .jsbeg, .jsend, .jscct, .jsint	/* Exported syms */

	skipn	16,-2(17)	;get address of ac block
	 jrst jbad		; if null pointer, fail!
	move 15,-1(17)		;get the jsys arg, plus flags
	ldb 14,[360300,,15]	;extract the jsys' class (bits 3-5)
	caile 14,njclas		;range check the class code
	 jrst jbad		;  out of range, take lose return
	dmove	1,1(16)		;first two acs
	dmove	3,3(16)		;and next two
	hrrz 13,15		;put the jsys# in AC13

	/* Start range of PSI-checkable jsys() code.  Actually this only needs
	** to be the first critical-code address, but right here is a
	** convenient place as all ACs have been set up.
	*/
.jsbeg:
	skiple .sigusys		; Are we within USYS call?
	 tlnn 15,(<JSYS_OKINT>)	; Yes, are we interruptable?
	  jrst @clsdsp(14)	; No to either, just do the jsys

	/* Within USYS call, and must check for interrupts!
	** Must check carefully; .sigblockmask cannot change, but .sigpendmask
	** may change at any time!  All instructions between the
	** test and the actual JSYS invocation are critical!
	*/
	setcm 6,.sigblockmask	; Get block mask complement
	tdnn 6,.sigpendmask	; Are any unblocked ints pending?
jsccx:	 jrst @clsdsp(14)	; CRITICAL: no, go execute JSYS.
	jrst .jsint-1		; Signals are pending, abort immediately!

	/* This table had better be in the same section as the PSI
	** handler or the AOBJN pointer won't work.
	*/
.jscct:	njscct,,.+1
	$$SECT,,jsccx
clsdsp:	$$SECT,,jclas0		/* All JSYS calls are critical addrs! */
	$$SECT,,jclas1
	$$SECT,,jclas2
	$$SECT,,jclas3
	$$SECT,,jclas4
njclas==.-clsdsp		/* # of classes */
njscct==<.-<.jscct+1>>		/* # of critical code addrs */

/*	class 0: jsys always returns +1, generating an illegal instruction
**	interrupt on error.
*/
jclas0:	jsys (13)		;perform the jsys
	 erjmp j0lose
	jrst jsys1		;won
	jrst jsys2		;for catching default cases
	jrst jsys3		;extra sure for default cases

/*	class 1: jsys returns +1 on failure, +2 on winnage
*/
jclas1:	jsys (13)		;perform the jsys
	 erjmpa jsys0		;  lost, error code in AC1
	jrst jsys2		;won with +2
	jrst jsys3		;won with +3

/*	class 2: special class for ERSTR%
*/
jclas2:	jsys (13)		;perform the jsys
	 erjmpa jsys0		;  interrupt or +1 return
	jrst jsys0		;+2 return is also failure!
	jrst jsys3		;+3, finally a win!

/*	class 3: special class for SIBE% and SOBE%
*/
jclas3:	jsys (13)		;perform the jsys
	jrst jsys1		;  took +1 return, AC2 should have # bytes.
	jumpe 2,jsys2		;ac2=0, +2 return
	movem 2,0(16)		;ac2!=0 so it's an error code.  save it,
	jrst jsys0a		;and take +0 error return.

/*	class 4: special class for SOBF%
*/
jclas4:	jsys (13)		;perform the jsys
	jrst jsys1		;+1 return (or error, but can't distinguish!)
	jrst jsys2		;+2 return

.jsend:	/* End of PSI-checkable jsys() code */

j0lose:	dmove 6,1		/* Save ACs 1 and 2 */
	movei 1,.fhslf
	geter%			;get the last error code
	 erjmpa [movei 2,lstrx1
		 jrst .+1]
	hrrzm 2,0(16)		;store the system error code
	dmove 1,6		/* Restore ACs */
	jrst jsys0a		;join common 0 return code

	/* Return values */
	skipa 5,[-2]		; -2 Interrupted before JSYS executed
.jsint:	 seto 5,		; -1 Interrupted from within JSYS
	jrst jsyse

jsys0:	movem 1,0(16)		;0 Set ablock[0] to the system error code
jsys0a:	tdza 5,5		;0 these are the returns.  +0 means lost.
jsys1:	  movei 5,1		;+1 means win with a +1 return.
	jrst jsyse
jsys2:	skipa 5,[2]		;+2 means won with +2,
jsys3:	  movei 5,3		;+3 won with +3.
jsyse:	dmovem	1,1(16)		;put return values back
	dmovem	3,3(16)		;other two acs
	skipa 1,5		;get return value
jbad:	 setzb 1,(16)		; bad class or flags, return 0 with err# 0
				; (Note this is safe even if AC16 is 0!)
	popj 17,		;return to user

#endasm
}	/* End of jsys() */

#endif /* T20+10X */
