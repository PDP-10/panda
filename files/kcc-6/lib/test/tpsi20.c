/* PSITST - hack to test PSI stuff
*/
#include "c-env.h"
#include <stdio.h>

int inthan();
main()
{	setbuf(stdout, NULL);
	printf("Testing PSI ints\n");
	psiset(inthan);
	asm("	jrst 100\n");
}

int pcs[3*2];
int *levtab[3] = { &pcs[0], &pcs[2], &pcs[4] };

inthan(chn)
int chn;
{
	printf("Interrupt on chan %d, PC = %o %o\n", chn, pcs[2], pcs[3]);
}

psiset()
{
#asm
	SEARCH	MONSYM
P==17
A==1
B==2
	SKIPN A,-1(P)		; Get arg (procedure addr)
	 JRST sigo2		; 0 = turn off
	movem a,brkvec		; Save it

	movsi 1,-44
	xmovei 2,psivec
	caige 17,
	 tloa 2,2		; single-section
	  tlo 2,020000		; multi-section
ilup:	movem 2,chntab(1)
	addi 2,1
	aobjn 1,ilup

	movei 1,.fhslf
	jumpge 17,xsetup
	move 2,[levtab,,chntab]
	sir%			; Set up PSI system
	jrst set5
xsetup:	xmovei 2,[3
		$$SECT,,levtab
		$$SECT,,chntab]
	xsir%

set5:	eir%			; Enable it
	move b,chnmsk		; Channel 1 mask
	aic%			; Arm interrupt channels
;	move a,[.ticco,,.ic.co]
;	ati%			; Map ^O to its interrupt chan

;	move a,[rt%dim+.fhslf]
;	rtiw%
;	tdz 3,[1B<.ticco>]
;	stiw%
	popj p,

sigo2:	movei a,.fhslf
	move b,chnmsk
	dic		; disable channel
	popj p,

%%DATA
chnmsk:	-1
;	200000,,0	; Channel 1 mask

brkvec:	0

chntab:	block 44
psivec:	repeat 44,<jsr psijsr>
psijsr:	0
	jrst psiint

%%CODE
	; Handle interrupt
psiint:	skipn brkvec
	 debrk%
	push p,16	; Save ACs on stack
	movsi 16,-16
	push p,(16)
	aobjn 16,.-1

	hrrz 1,psijsr
	subi 1,psivec+1		; Find channel #
	push p,1
	pushj p,@brkvec
	adjsp p,-1

	movei 16,15		; Restore ACs
	pop p,(16)
	sojge 16,.-1
	pop p,16
	debrk%
#endasm
}
