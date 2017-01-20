/* TOPS-20 routines for Logo by Mark Crispin */

/* Dummy module to help out the assembler, should never be called */
dummy () {
#asm
	SEARCH MACSYM,MONSYM
	EXTERN $RETZ,$RETT	; C return routines

	JRST $RETZ		; should never be called

SRCJFN:	BLOCK 1			; source file JFN
DSTJFN:	BLOCK 1			; destination JFN

TTYMOD:	BLOCK 1			; virgin TTY mode
TTYCOC:	BLOCK 1			; virgin TTY COC words
TTYTIW:	BLOCK 1			; virgin TTY interrupt word
#endasm
}

/* Initialize control-C capabilities for signals.  I don't know if
   this is really necessary in KCC (it was in PCC), but it doesn't
   hurt. */
capini () {
#asm
	MOVX 1,.FHSLF		; get current capabilities
	RPCAP%
	 ERJMP .+1
	IORB 2,3		; want capabilities merged
	EPCAP%			; enable all capabilities
	 ERJMP .+1		; ignore error
	JRST $RETT
#endasm
}

/* Save TOPS-20 terminal state before invoking an inferior process */
t20save () {
#asm
	MOVX 1,.PRIIN
	RFMOD%
	MOVEM 2,TTYMOD
	RFCOC%			; get COC words
	DMOVEM 2,TTYCOC
	MOVX 1,.FHJOB		; get terminal interrupt word
	RTIW%
	MOVEM 2,TTYTIW
	JRST $RETT
#endasm
}

/* Restore TOPS-20 terminal state after invoking an inferior process */
t20restore () {
#asm
	MOVX 1,.PRIIN
	MOVE 2,TTYMOD
	SFMOD%
	DMOVE 2,TTYCOC
	SFCOC%			; get COC words
	MOVX 1,.FHJOB		; get terminal interrupt word
	MOVE 2,TTYTIW
	STIW%
	JRST $RETT
#endasm
}

/* Painfully simple-minded routine to replace an invocation to the
   Unix "cat" program.  This is the least efficient way to do this,
   but fortunately all the files are small!*/
catfile (source,destination) {
#asm
	MOVX 1,GJ%SHT!GJ%OLD	; require old file
	%CHRBP 2,-1(17)		; pick up source filename
	GTJFN%
	IFJER.
	  TMSG <cat: can't find source file
>
	  JRST $RETZ
	ENDIF.
	MOVEM 1,SRCJFN		; save source JFN
	MOVX 2,<<FLD 7,OF%BSZ>!OF%RD> ; open file for read
	OPENF%
	IFJER.
	  TMSG <cat: can't open source file
>
	  MOVE 1,SRCJFN		; release this JFN
	  RLJFN%
	   ERJMP .+1
	  JRST $RETZ
	ENDIF.
	MOVX 1,GJ%SHT		; old or new, it's all the same
	%CHRBP 1,-2(17)		; pick up destination filename
	GTJFN%
	IFJER.
	  TMSG <cat: can't get destination file
>
	  MOVE 1,SRCJFN		; close the source file
	  CLOSF%
	   ERJMP .+1
	  JRST $RETZ
	ENDIF.
	MOVEM 1,DSTJFN		; save destination JFN
	MOVX 2,<<FLD 7,OF%BSZ>!OF%APP> ; open file for append
	OPENF%
	IFJER.
	  TMSG <cat: can't open destination file
>
	  MOVE 1,DSTJFN		; release this JFN
	  RLJFN%
	   ERJMP .+1
	  MOVE 1,SRCJFN		; close the source file
	  CLOSF%
	   ERJMP .+1
	  JRST $RETZ
	ENDIF.
	DO.
	  MOVE 1,SRCJFN		; read byte from source
	  BIN%
	  IFNJE.
	    MOVE 1,DSTJFN	; if not error, write to destination
	    BOUT%
	    LOOP.		; and do another byte
	  ENDIF.
	ENDDO.
	MOVE 1,SRCJFN		; close both files
	CLOSF%
	 ERJMP .+1
	MOVE 1,DSTJFN
	CLOSF%
	 ERJMP .+1
	JRST $RETT
#endasm
}

/* High precision time function*/
_hptim () {
#asm
	SETZ 1,			; time since system startup
	HPTIM%
	 NOP
	RET
#endasm
}

/* Dummy for Unix alarm function*/
alarm () {}
