/*
**	CRT - C Run Time machine-language support routines
**
**	(c) Copyright Ken Harrenstien 1989
**	Edits for ITS:  Copyright (C) 1988 Alan Bawden
**
**	Revised for new syntax features by KLH, Sep 1986
**	Split out and rewritten from TOPS20.FAI by KLH@SRI-NIC, June 1985
**
**	CRT consists of the essential machine-language support needed
** to run any KCC-compiled program.  All possible routines are included
** in this one module, and no others; in particular there are no
** URT (Unix RunTime simulation) aspects except for the variables
** _END, _ETEXT, _EDATA, and _EALLOC.
**	Note that there are several global symbols defined in this module,
** but only $$$CRT is explicitly intended to serve as the "entry" hook
** which will pull this module in when referenced.  Everything compiled by
** KCC will ask for $$$CRT.
*/

#include <c-env.h>
#include <sys/param.h>
#include <sys/usydat.h>
#include <urtsud.h>
#include <monsym.h>
#include <sys/c-debug.h>

/* Some externally visible data cells */

		/* UNIX loader symbol simulation */
char	*_etext,	/* 1st addr above program text (code) region */
	*_edata,	/* 1st addr above initialized data region */
	*_end,		/* Program "break". */
			/* Unix: 1st addr above uninitialized data */
			/* KCC: 1st addr of dynamically allocated stuff. */
	*_ealloc;	/* KCC: 1st addr above space for dynamic allocation */

int `$STOFF`;		/* Start address offset (either 0 or 1) */
int `$STACS`[16];	/* Saved ACs at startup */
int `$STCOM`;		/* Compliant startup (environment passed) */
int `$STDIR`;		/* Starting directory from environment */
char **`$SARGV`;	/* argv array from environment */
int `$SARGC`;		/* argc for argv */
char **`$ENVPT`;	/* environ array */
int `$ENVSZ`;		/* size of environ array */
char *`$RSCPT`;		/* RSCAN data pointer */
int `$UMASK`;		/* Default umask */
int `$STDER`;		/* stderr redirection */
int `$TMPDR`;		/* /tmp directory */
char *`$HERIT` = USYS_VAR_REF(heritage);
			/* Relative fork handle heritage pointer */
int `$DEBUG` = 0;	/* Debugging flags */
double `$ZERO` = 0.0;	/* Double zero, for floating constant reference */
int `$KCCID` = 0534343604755;	/* Sixbit /KCCPGM/ to identify KCC pgms */
#define ENVSLOP 040	/* Pad environ array by this many entries */

#if SYS_T20+SYS_10X
static int `ENVPTR`;		/* Saved environment byte pointer */
static int `ENVLEN`;		/* Saved length of environment data */
static int `ENVDON`;		/* Complete environment passed */
static int `HERPTR`;		/* Saved pointer from *HERIT= */
static char *`ENVHOM`;		/* Default "HOME=" */
static char *`STRHOM`=("HOME="-1);
static char *`ENDHOM`;
static char *`ENVUSR`;		/* Default "USER=" */
static char *`STRUSR`=("USER="-1);
static char *`ENVPTH`;		/* Default "PATH=" */
static char *`STRPTH`=("PATH=/sys"-1);
static char *`ENVTRM`;		/* Default "TERM=" */
static char *`STRTRM`=("TERM="-1);
static int *`PATHO` = &_urtsud.su_path_out_type;
#endif

static int *`URTEND` = (((int *)&_urt) + ((sizeof(_urt)/sizeof(int)) - 1));

#if SYS_ITS+SYS_WTS+SYS_T10+SYS_CSI
static int `$STKSZ` = 030000;	/* Min stack size to allocate at startup */
#endif				/* This is a variable so it can be patched */

static int `startf` = 0;	/* Start flag.  Non-zero if already started */
static int `pdlp` = 0;		/* Saved pushdown list pointer */

`$$$CRT`()			/* Start of moby assembler code stuff */
{
    if (0) `startf` = `pdlp`;	/* Avoid KCC warning of unreffed vars */
    if (0) `URTEND`++;		/* 	"	 */
#asm
RV==1		/* Return-Value register */
A==3		/* A,B,C,D sequential miscellaneous regs */
B==4		/* Please keep these half-killed so that */
C==5		/* ITS hackers don't go nuts */
D==6
S==16		/* Runtime scratch register */
P==17		/* PDL pointer */

	EXTERN	.RUNTM
	EXTERN $$SECT, $$BPPS
	EXTERN $$BP9Z, $$BP90, $$BP91, $$BP92, $$BP93
	EXTERN $$BP7Z, $$BP70, $$BP71, $$BP72, $$BP73, $$BP74

; System-dependent runtime code should contain the following:
;	(1) A "SSTART" label, jumped to at program startup.  This code should:
;		- Test STARTT flag, give error if appropriate, and set
;		- Set up the stack and point P at it.
;		- Arrange for whatever memory shuffling is desired,
;			including extended addressing.
;		- Set the global vars .END, .ETEXT, .EDATA, .EALLOC
;			as word (not char) addresses.
;		- Finally, jump back to SREADY.
;	(2) A "..EXIT" label, for a function that should halt the process
;		normally with the exit status provided by arg 1.

	INTERN $START
$START:	JRST START0		/* Start offset is 0 */
	SETZM $STOFF		/* Start offset is 1 */
	AOSA $STOFF
START0:	 SETZM $STOFF
	MOVEM 17,$STACS+17	/* Save Start AC 17 */
	MOVEI 17,$STACS		/* Set up BLT from ACs to storage block */
	BLT 17,$STACS+16	/* Save remaining ACs. */
	SETZM $STCOM		/* Assume no compliant startup */
	SETZM $STDIR		/* Assume no starting directory */
	SETZM $ENVPT		/* No environment yet */
	SETZM $ENVSZ		/* Zero size */
	SETZM $SARGV		/* No arguments passed yet */
	SETZM $SARGC		/* Zero size */
	SETZM $RSCPT		/* No RSCAN data */
	SETZM .URT		/* Init first work of system data */
	MOVE A,[.URT,,.URT+1]	/* Make blt pointer */
	HRRZ B,URTEND		/* Force local address */
	BLT A,(B)		/* Clear entire system data structure */
	MOVEI A,002		/* Initialize default umask */
	MOVEM A,$UMASK		/* For setup in URT */
	SETZM $STDER		/* No stderr redirect yet */
	JRST SSTART		/* Else perform sys-dependent startup! */

	; Jump back here when system-dependent startup is complete.
SREADY:	SETOM STARTF	/* Flag we have been started */
	MOVSI A,$$BP90	/* Set up proper bits for byte pointer conversion */
	IORM A,.END	/* Convert the word addrs to KCC char pointers */
	IORM A,.EDATA
	IORM A,.ETEXT
	IORM A,.EALLOC
	SETZ 0,		; Make sure any refs to 0 just get 0.
	SKIPE S,INITS	; Are there any inits set up by loader?
	 PUSHJ P,1(S)	; Yeah, go hack them (obscure feature)
	PUSHJ P,.RUNTM	; Invoke higher level setup.  This will call MAIN.

			; This should exit by itself, but just in case
	PUSH P,RV	; we return, pass on the return value
	PUSHJ P,..EXIT	; and exit forcibly, without any cleanup.
	JRST .-1	; Insist.

	/* Link for runtime initializations.  KCC cannot always
	** initialize some variables at compile time, and so it uses
	** a link chain to tie together the code it generates to
	** perform the initializations at run time.
	*/
INITS:	BLOCK	1		;Make space for LINK to fill in with init chain
	.LNKEND	1,INITS		;Tell it to head the chain here
#endasm

#asm

$RETF:
$RETZ:	SETZ RV,		; Return Zero (also False)
$RET:	POPJ P,

$RETT:
$RETP:	MOVEI RV,1		; Return Positive (also True)
	POPJ P,
$RETN:	SETO RV,		; Return Negative
	POPJ P,

	INTERN	$RET,$RETP,$RETT,$RETZ,$RETF,$RETN
#endasm

/* Byte pointer tables.
*/
#asm
	EXTERN $$BMP6, $$BMP7, $$BMP8, $$BMP9, $$BMPH
	INTERN $BPMUL, $BPADT
	INTERN $BADL6, $BADL7, $BADL8, $BADL9, $BADLH
	INTERN $BADX6, $BADX7, $BADX8, $BADX9, $BADXH

/* The tables $BPMUL and $BPADT are both indexed by either the
** S field (for local-format BPs) or the P+S field (for OWGBPs).
** The index values can thus be from 00 to 77, but only those corresponding
** to 6, 7, 8, 9, or 18 bits are ever actually used.
**	$BPMUL contains the value that P_SUBBP should use for multiplication.
**	$BPADT points to the table that P_SUBBP should use for addition.
**
** The values for the $BPMUL table should actually be <size>_$$BSHF
** but FAIL interprets _ as assignment instead of left-shift!  Barf.
*/
$BPMUL:	BLOCK 6		; 0 Local sizes 0-5
	$$BMP6		; 6 Local size 6  
	$$BMP7		; 7 Local size 7  
	$$BMP8		; 10 Local size 8  
	$$BMP9		; 11 Local size 9  
	BLOCK 10	; 12 Local sizes 10-17
	$$BMPH		; 22 Local size 18  
	BLOCK 22	; 23 Local sizes 19-36
	0		; 45 OWGBP 6-bit offset -1
	$$BMP6		; 46 OWGBP 6-bit offset 0
	$$BMP6		; 47 OWGBP 6-bit offset 1
	$$BMP6		; 50 OWGBP 6-bit offset 2
	$$BMP6		; 51 OWGBP 6-bit offset 3
	$$BMP6		; 52 OWGBP 6-bit offset 4
	$$BMP6		; 53 OWGBP 6-bit offset 5
 	0		; 54 OWGBP 8-bit offset -1
	$$BMP8		; 55 OWGBP 8-bit offset 0
	$$BMP8		; 56 OWGBP 8-bit offset 1
	$$BMP8		; 57 OWGBP 8-bit offset 2
	$$BMP8		; 60 OWGBP 8-bit offset 3
 	0		; 61 OWGBP 7-bit offset -1
	$$BMP7		; 62 OWGBP 7-bit offset 0
	$$BMP7		; 63 OWGBP 7-bit offset 1
	$$BMP7		; 64 OWGBP 7-bit offset 2
	$$BMP7		; 65 OWGBP 7-bit offset 3
	$$BMP7		; 66 OWGBP 7-bit offset 4
 	0		; 67 OWGBP 9-bit offset -1
	$$BMP9		; 70 OWGBP 9-bit offset 0
	$$BMP9		; 71 OWGBP 9-bit offset 1
	$$BMP9		; 72 OWGBP 9-bit offset 2
	$$BMP9		; 73 OWGBP 9-bit offset 3
 	0		; 74 OWGBP 18-bit offset -1
	$$BMPH		; 75 OWGBP 18-bit offset 0
	$$BMPH		; 76 OWGBP 18-bit offset 1
	0		; 77 illegal

$BPADT:	BLOCK 6		; 0 Local sizes 0-5
	$BADL6		; 6 Local size 6  
	$BADL7		; 7 Local size 7  
	$BADL8		; 10 Local size 8  
	$BADL9		; 11 Local size 9  
	BLOCK 10	; 12 Local sizes 10-17
	$BADLH		; 22 Local size 18  
	BLOCK 22	; 23 Local sizes 19-36
	0		; 45 OWGBP 6-bit offset -1
	$BADX6		; 46 OWGBP 6-bit offset 0
	$BADX6		; 47 OWGBP 6-bit offset 1
	$BADX6		; 50 OWGBP 6-bit offset 2
	$BADX6		; 51 OWGBP 6-bit offset 3
	$BADX6		; 52 OWGBP 6-bit offset 4
	$BADX6		; 53 OWGBP 6-bit offset 5
 	0		; 54 OWGBP 8-bit offset -1
	$BADX8		; 55 OWGBP 8-bit offset 0
	$BADX8		; 56 OWGBP 8-bit offset 1
	$BADX8		; 57 OWGBP 8-bit offset 2
	$BADX8		; 60 OWGBP 8-bit offset 3
 	0		; 61 OWGBP 7-bit offset -1
	$BADX7		; 62 OWGBP 7-bit offset 0
	$BADX7		; 63 OWGBP 7-bit offset 1
	$BADX7		; 64 OWGBP 7-bit offset 2
	$BADX7		; 65 OWGBP 7-bit offset 3
	$BADX7		; 66 OWGBP 7-bit offset 4
 	0		; 67 OWGBP 9-bit offset -1
	$BADX9		; 70 OWGBP 9-bit offset 0
	$BADX9		; 71 OWGBP 9-bit offset 1
	$BADX9		; 72 OWGBP 9-bit offset 2
	$BADX9		; 73 OWGBP 9-bit offset 3
 	0		; 74 OWGBP 18-bit offset -1
	$BADXH		; 75 OWGBP 18-bit offset 0
	$BADXH		; 76 OWGBP 18-bit offset 1
	0		; 77 illegal

/* Addition tables for P_SUBBP.
**	These are indexed by the high-order word resulting from
** a multiplication of the byte-pointer difference.  Note that the
** tables extend on both sides of the labels so that negative indices
** are kept happy.
**	Some of the tables are much sparser than they need to be,
** because of a $$BSHF value higher than necessary for that particular
** BP size; the reason for this is so we can use a single value of
** $$BSHF (depending on whether using local-format or global-format BPs)
** and avoid having to look up a size-dependent shift value.  Thus
** $$BSHF is set to the lowest possible value that satisfies ALL of the
** BP sizes (the main problem is the 18-bit one).
**
** The PARITH.C program in the KCC source directory was used to
** generate and test this stuff.
**
** Don't look at the values too hard; let magic be magic.
*/

	/*  6-bit local-format P_SUBBP fixup table */

	<40000,,5>	; -12.
	    0 ;unused	; -11.
	<0,,4>  	; -10.
	<200000,,4>	; -9.
	    0 ;unused	; -8.
	<140000,,3>	; -7.
	    0 ;unused	; -6.
	<100000,,2>	; -5.
	    0 ;unused	; -4.
	<40000,,1>	; -3.
	    0 ;unused	; -2.
	    0 ;unused	; -1.
$BADL6:	0		; 0.
	    0 ;unused	; 1.
	-<40000,,1>	; 2.
	    0 ;unused	; 3.
	-<100000,,2>	; 4.
	    0 ;unused	; 5.
	-<140000,,3>	; 6.
	    0 ;unused	; 7.
	-<200000,,4>	; 8.
	-<0,,4>		; 9.
	    0 ;unused	; 10.
	-<40000,,5>	; 11.


	/*  7-bit local-format P_SUBBP fixup table */

	<140000,,4>	; -9.
	    0 ;unused	; -8.
	<110000,,3>	; -7.
	    0 ;unused	; -6.
	<60000,,2>	; -5.
	    0 ;unused	; -4.
	<30000,,1>	; -3.
	    0 ;unused	; -2.
	    0 ;unused	; -1.
$BADL7:	0		; 0.
	    0 ;unused	; 1.
	-<30000,,1>	; 2.
	    0 ;unused	; 3.
	-<60000,,2>	; 4.
	    0 ;unused	; 5.
	-<110000,,3>	; 6.
	    0 ;unused	; 7.
	-<140000,,4>	; 8.


	/*  8-bit local-format P_SUBBP fixup table */

	<0,,3>		; -7.
	<200000,,3>	; -6.
	<0,,2>		; -5.
	<200000,,2>	; -4.
	<0,,1>		; -3.
	<200000,,1>	; -2.
	    0 ;unused	; -1.
$BADL8:	0		; 0.
	-<200000,,1>	; 1.
	-<0,,1>		; 2.
	-<200000,,2>	; 3.
	-<0,,2>		; 4.
	-<200000,,3>	; 5.
	-<0,,3>		; 6.


	/*  9-bit local-format P_SUBBP fixup table */

	<140000,,3>	; -7.
	    0 ;unused	; -6.
	<100000,,2>	; -5.
	    0 ;unused	; -4.
	<40000,,1>	; -3.
	    0 ;unused	; -2.
	    0 ;unused	; -1.
$BADL9:	0		; 0.
	    0 ;unused	; 1.
	-<40000,,1>	; 2.
	    0 ;unused	; 3.
	-<100000,,2>	; 4.
	    0 ;unused	; 5.
	-<140000,,3>	; 6.


	/* 18-bit local-format P_SUBBP fixup table */

	<40000,,1>	; -3.
	    0 ;unused	; -2.
	    0 ;unused	; -1.
$BADLH:	0		; 0.
	    0 ;unused	; 1.
	-<40000,,1>	; 2.


	/*  6-bit OWGBP-format P_SUBBP fixup table */

	-<0,,5>		; -31.
	-<770000,,5>	; -30.
	    0 ;unused	; -29.
	    0 ;unused	; -28.
	    0 ;unused	; -27.
	    0 ;unused	; -26.
	-<0,,4>		; -25.
	-<770000,,4>	; -24.
	    0 ;unused	; -23.
	    0 ;unused	; -22.
	    0 ;unused	; -21.
	    0 ;unused	; -20.
	-<0,,3>		; -19.
	-<770000,,3>	; -18.
	    0 ;unused	; -17.
	    0 ;unused	; -16.
	    0 ;unused	; -15.
	    0 ;unused	; -14.
	-<0,,2>		; -13.
	-<770000,,2>	; -12.
	    0 ;unused	; -11.
	    0 ;unused	; -10.
	    0 ;unused	; -9.
	    0 ;unused	; -8.
	-<0,,1>		; -7.
	-<770000,,1>	; -6.
	    0 ;unused	; -5.
	    0 ;unused	; -4.
	    0 ;unused	; -3.
	    0 ;unused	; -2.
	    0 ;unused	; -1.
$BADX6:	0		; 0.
	    0 ;unused	; 1.
	    0 ;unused	; 2.
	    0 ;unused	; 3.
	    0 ;unused	; 4.
	<770000,,1>	; 5.
	<0,,1>		; 6.
	    0 ;unused	; 7.
	    0 ;unused	; 8.
	    0 ;unused	; 9.
	    0 ;unused	; 10.
	<770000,,2>	; 11.
	<0,,2>		; 12.
	    0 ;unused	; 13.
	    0 ;unused	; 14.
	    0 ;unused	; 15.
	    0 ;unused	; 16.
	<770000,,3>	; 17.
	<0,,3>		; 18.
	    0 ;unused	; 19.
	    0 ;unused	; 20.
	    0 ;unused	; 21.
	    0 ;unused	; 22.
	<770000,,4>	; 23.
	<0,,4>		; 24.
	    0 ;unused	; 25.
	    0 ;unused	; 26.
	    0 ;unused	; 27.
	    0 ;unused	; 28.
	<770000,,5>	; 29.
	<0,,5>		; 30.


	/*  7-bit OWGBP-format P_SUBBP fixup table */

	-<0,,4>		; -21.
	-<770000,,4>	; -20.
	    0 ;unused	; -19.
	    0 ;unused	; -18.
	    0 ;unused	; -17.
	-<0,,3>		; -16.
	-<770000,,3>	; -15.
	    0 ;unused	; -14.
	    0 ;unused	; -13.
	    0 ;unused	; -12.
	-<0,,2>		; -11.
	-<770000,,2>	; -10.
	    0 ;unused	; -9.
	    0 ;unused	; -8.
	    0 ;unused	; -7.
	-<0,,1>		; -6.
	-<770000,,1>	; -5.
	    0 ;unused	; -4.
	    0 ;unused	; -3.
	    0 ;unused	; -2.
	    0 ;unused	; -1.
$BADX7:	0		; 0.
	    0 ;unused	; 1.
	    0 ;unused	; 2.
	    0 ;unused	; 3.
	<770000,,1>	; 4.
	<0,,1>		; 5.
	    0 ;unused	; 6.
	    0 ;unused	; 7.
	    0 ;unused	; 8.
	<770000,,2>	; 9.
	<0,,2>		; 10.
	    0 ;unused	; 11.
	    0 ;unused	; 12.
	    0 ;unused	; 13.
	<770000,,3>	; 14.
	<0,,3>		; 15.
	    0 ;unused	; 16.
	    0 ;unused	; 17.
	    0 ;unused	; 18.
	<770000,,4>	; 19.
	<0,,4>		; 20.


	/*  8-bit OWGBP-format P_SUBBP fixup table */

	-<0,,3>		; -13.
	-<770000,,3>	; -12.
	    0 ;unused	; -11.
	    0 ;unused	; -10.
	-<0,,2>		; -9.
	-<770000,,2>	; -8.
	    0 ;unused	; -7.
	    0 ;unused	; -6.
	-<0,,1>		; -5.
	-<770000,,1>	; -4.
	    0 ;unused	; -3.
	    0 ;unused	; -2.
	    0 ;unused	; -1.
$BADX8:	0		; 0.
	    0 ;unused	; 1.
	    0 ;unused	; 2.
	<770000,,1>	; 3.
	<0,,1>		; 4.
	    0 ;unused	; 5.
	    0 ;unused	; 6.
	<770000,,2>	; 7.
	<0,,2>		; 8.
	    0 ;unused	; 9.
	    0 ;unused	; 10.
	<770000,,3>	; 11.
	<0,,3>		; 12.


	/*  9-bit OWGBP-format P_SUBBP fixup table */

	-<0,,3>		; -13.
	-<770000,,3>	; -12.
	    0 ;unused	; -11.
	    0 ;unused	; -10.
	-<0,,2>		; -9.
	-<770000,,2>	; -8.
	    0 ;unused	; -7.
	    0 ;unused	; -6.
	-<0,,1>		; -5.
	-<770000,,1>	; -4.
	    0 ;unused	; -3.
	    0 ;unused	; -2.
	    0 ;unused	; -1.
$BADX9:	0		; 0.
	    0 ;unused	; 1.
	    0 ;unused	; 2.
	<770000,,1>	; 3.
	<0,,1>		; 4.
	    0 ;unused	; 5.
	    0 ;unused	; 6.
	<770000,,2>	; 7.
	<0,,2>		; 8.
	    0 ;unused	; 9.
	    0 ;unused	; 10.
	<770000,,3>	; 11.
	<0,,3>		; 12.


	/* 18-bit OWGBP-format P_SUBBP fixup table */

	-<0,,1>		; -3.
	-<770000,,1>	; -2.
	    0 ;unused	; -1.
$BADXH:	0		; 0.
	<770000,,1>	; 1.
	<0,,1>		; 2.
#endasm

/* $ADJBP - Support for ADJBP instruction simulation.
**	For KA-10s and any other CPU which does not have the ADJBP instruction,
** KCC will define an ADJBP macro which expands into:
**	ADJBP AC,MEM 
**		MOVE 16,MEM
**		EXCH 15,AC
**		PUSHJ 17,$ADJBP
**		EXCH 15,AC
**
**	The routine here (from KLH's UUO package) is completely general
** and simulates the KL ADJBP instruction exactly, including alignment
** preservation.
**	Note that for most cases this hair is unnecessary, and you can get
** MUCH better efficiency by
**	(1) using prior knowledge of the byte size, and
**	(2) assuming alignment is always a normal byte boundary, and
**	(3) assuming 44 is never used as a P field value.
** This also permits inline coding.  Nevertheless, because much C library
** support uses the ADJBP instruction, an assembler macro (and thus
** a runtime routine for it to call) are needed.
*/

#asm

; $ADJBP - Software simulation of ADJBP instruction, which is just
;	IBP with non-zero AC.
; Following description taken from DEC hardware manual.  Integer
; divisions, of course.
; Let A = rem((36-P)/S)
; If S > 36-A	set no divide & exit
; If S = 0	set (E) -> (AC)
; If 0 < S <= 36-A:		NOTE: Dumb DEC doc claims < instead of <= !!!
;	L = (36-P)/S = # bytes to left of P
;	B = L + P/S  = # bytes to left + # bytes to right = # bytes/word
;	Find Q and R, Q*B + R = (AC) + L
;		where 1 <= R <= B	; that is, not neg or zero!
;	Then:
;		Y + Q	-> new Y	; must wraparound correctly.
;	36 - R*S - A	-> new P
;	Put new BP in AC.  Only P and Y fields changed, not S, I, X.

	INTERN $ADJBP

$ADJBP:	PUSH P,A
	PUSH P,B
	PUSH P,C
	PUSH P,D

	; First get S
	LDB A,[300600,,15]	; Get S
	JUMPE A,UIBP9		; If S = 0 just set (AC) to (E).
	CAILE A,44
	 JRST UIBP9		; In theory should set "no divide"

	; Now get A and test.
	LDB C,[360600,,15]	; Get P
	MOVE B,C		; Save copy
	SUBI C,44		; Get -(36-P)
	IDIVI C,(A)		; Get -( Alignment = rem (36-P)/s )
	CAILE A,44(D)		; Compare S <= 36 - A
	 JRST UIBP9		; Ugh, error return.

	; Get L and B
	PUSH P,D		; Save - rem = A = # unbyted bits to left of P
	MOVM D,C		; Save quotient = L = # bytes to left of P
	IDIVI B,(A)		; Now get P/S
	ADDI B,(D)		; L + P/S = B bytes per wd.
	MOVE C,16		; Get # bytes to adjust by. Don't optimize if 0
				; because want canonicalization effect.
	ADDI C,(D)		; Get (AC) + L
	IDIVI C,(B)		; Find  (AC + L)/B = Q and R
	JUMPLE D,[ADDI D,(B)	; If R <= 0 then adjust to 0 < R.
		SOJA C,.+1]	; which means adjusting Q also.
	
	IMULI D,(A)		; Get R*S
	POP P,A			; Restore -A
	SUBI A,-44(D)		; Now have new P = (36 - R*S - A)

	DPB A,[360600,,15]	; Deposit new P in byte pointer
	ADDI C,(15)		; Find new Y = Y + Q
	HRRI 15,(C)		; Set this way to wrap properly.

UIBP9:			; In theory should set Trap 1, Ovfl, No Div.
	POP P,D
	POP P,C
	POP P,B
	POP P,A
	POPJ P,
#endasm
}	/* End of dummy routine! */

#if SYS_T20+SYS_10X
/************************************************************
**	C low-level Runtime Support Routines
**	TOPS-20/TENEX Operating System
************************************************************
*/

void
__exit(status)
int status;
{
    if (0) `ENVPTR`++;
    if (0) `ENVLEN`++;
    if (0) `ENVDON`++;
    if (0) `ENVHOM`++;
    if (0) `HERPTR`++;
    if (0) `STRHOM`++;
    if (0) `ENDHOM`++;
    if (0) `ENVUSR`++;
    if (0) `STRUSR`++;
    if (0) `ENVPTH`++;
    if (0) `STRPTH`++;
    if (0) `ENVTRM`++;
    if (0) `STRTRM`++;
    if (0) `PATHO`++;
#asm
	SEARCH	MONSYM

	SETZM PDLP		; Prevent restart
	MOVE 0,$KCCID		; Get KCC identifier into AC 0
EXIT1:	MOVE 1,-1(P)		; Get possible argument into AC 1
	HALTF%			; Exit to monitor.
	HRROI 1,[ASCIZ/Cannot continue/]
	ESOUT%			; Complain if continued
	JRST EXIT1		; and stop again.

RESTART:HRROI 1,[ASCIZ /Cannot restart/]
	ESOUT%
	HALTF%
	JRST RESTART

.JBHSO==75		; Contains page number of start of high seg
.JBHRL==115		; Contains <high seg first free addr>,,<highest addr>
.JBSYM==116		; Contains -<# wds in symtab>,,<addr of symtab>
.JBSA==120		; Contains <low seg first free addr>,,<start addr>
PG$BTS==11		; log 2 of T20/TNX page size
PG$SIZ==1000		; # words in T20/TNX page
PG$MSK==<PG$SIZ-1>


	/* Start of TOPS-20/TENEX program */
SSTART:	MOVE 1,$STACS+15
	CAME 1,['ENVIRO']	/* Check for handshake */
	 JRST SSTRT1
	HRRZ 1,$STACS+16
	CAIE 1,'KCC'		/* Second handshake */
	 JRST SSTRT1		/* Non-compliant startup */
	AOSA $STCOM		/* Flag compliant startup */
SSTRT1:	 HRRZS $STACS+16	/* Clear environment JFN */
	SKIPE P,PDLP		/* Get saved stack, if set up */
	 JRST ENVSET		/* Go process environment setup */
	SKIPE STARTF		/* In case of confusion */
	 JRST RESTART		/* If no stack, no restart */
	MOVEI 1,.FHSLF		/* Ensure stupid PA1050 compat pkg is */
	SETO 2,			/* thoroughly disabled, to help track down */
	SCVEC%			/* any bugs! */
#if SYS_T20
	XMOVEI 1,.		/* See if loaded into non-zero section */
	HLRZS 1			/* Get section # into RH */
	JUMPE 1,STRT05		/* Jump if plain zero section */
	CAIE 1,$$SECT		/* Non-zero, had better match what we think */
	 0			/* Ugh!!!  Fail horribly for now. */
	JRST ESTART		/* Great, already mapped right! */
STRT05:
#endif
	SKIPN A,.JBHSO		/* Get page # of start of high seg */
	 JRST DOPSCT		/* If no highseg, assume PSECTed code */
	HLRZ P,.JBSA		/* Get top of low core as start of stack */
	MOVEM P,.EDATA		/* Save as ptr to end of data */
	LSH A,PG$BTS		/* Shift 9 bits to get <hiseg addr> */
	MOVN B,A		/* Make it -<hiseg addr> */
	ADD B,P			/* Find -<hiseg - edata> (ie -<# wds avail>) */
	HRL P,B			/* Put count in LH of PDL pointer */

	HLRZ	B,.JBHRL	/* Get first free high seg. relative address */
	ADD	A,B		/* Add to <hiseg addr> to make it absolute */
	JRST	DOETXT		/* Skip over PSECT stuff */

	/* No high segment.  Assume we were loaded with data & code PSECTs.
	** Further assume that the symbol table was put into the data PSECT,
	** and the code PSECT starts at 400000.
	** Thus the gap between these can be used for the stack.  The LH of
	** .JBSA has the highest free address, which will be above the code
	** PSECT.
	*/
DOPSCT:	HRRZ	P,.JBSYM	/* Get start addr of symtab */
	HLRE	A,.JBSYM	/* Get -<# wds in symtab> */
	SUB	P,A		/* Add to address to get 1st free addr */
	MOVEI	A,400000	/* Assume this is start of code psect */
	SUB	A,P		/* Find # words gap between data & code */
	MOVNS	A		/* Negate, and insert */
	HRL	P,A		/* -<count> in LH of of PDL pointer */
	HLRZ	A,.JBSA		/* Get top of code seg */

DOETXT:				/* Rejoin original code here */
	TRZE	A,PG$MSK	/* Round up to page boundry, since */
	 ADDI	A,PG$SIZ	/* hiseg may be write-protected */
	MOVEM	A,.END		/* Save addr in A as the END */

	MOVEM	A,.ETEXT	/* Same as END */
	MOVEI	A,770000-2000	/* Set this as allocation limit, so that */
	MOVEM	A,.EALLOC	/* DDT can be mapped in pages 770-777 */
				/* (with 2 data pages saved for $@#! UDDT) */
#if SYS_T20
	SKIPE	[$$SECT]	/* Want extended addressing? */
	 JRST	DOEXTA		/* Yeah, must do hairy setup */
#endif
ENVSET:	MOVEM	P,PDLP		/* Save stack for auto restart */
#endasm

#asm
#if SYS_T20
	SETOB	1,ENVDON	/* Assume complete environment passed */
	ADJBP	1,$HERIT	/* Get pointer to heritage string buffer */
	MOVEI	2,"0"		/* Start with us as 0 */
	IDPB	2,1		/* Deposit character */
	SETZ	2,
	IDPB	2,1		/* Terminate with null */
	SETZM	HERPTR		/* And no *HERIT= pointer yet */

	/* Setup default tmpdir */

	MOVNI	1,1		/* Our job */
	HRROI	2,$TMPDR	/* Store here */
	MOVEI	3,.JILNO	/* Logged in directory */
	GETJI%			/* Get it */
	 JFCL			/* Ignore error */

	/* Setup default "PATH=" variable */

	XMOVEI	1,1(P)		/* Get pointer to stack space */
	ADJSP	P,3		/* allocate 12 9-bit characters */
	TLO	1,$$BP9Z	/* Make byte pointer */
	MOVEM	1,ENVPTH	/* Save it */
	IBP	ENVPTH		/* Make it point to first char */
	MOVE	2,STRPTH	/* Start with "PATH=/sys" */
	SETZ	3,
	SOUT%

	/* Setup default "USER=" variable */

	GJINF%
	MOVE	D,1		/* Save user number */
	XMOVEI	1,1(P)		/* Get pointer to stack space */
	ADJSP	P,16		/* allocate 48 9-bit characters */
	TLO	1,$$BP9Z	/* Make byte pointer */
	MOVEM	1,ENVUSR	/* Save it */
	IBP	ENVUSR		/* Make it point to first char */
	MOVE	2,STRUSR	/* Start with "USER=" */
	SETZ	3,
	SOUT%
	MOVE	2,D		/* Get user number */
	DIRST%			/* Convert to string */
	 JFCL			/* Ignore error */
	SETZ	2,
	IDPB	2,1		/* Terminate with NULL */

	/* Setup default "TERM=" variable */

	MOVEI	1,.CTTRM	/* Get controlling terminal */
	GTTYP%			/* Get type */
	MOVE	D,2		/* Save it */
	XMOVEI	1,1(P)		/* Get pointer to stack space */
	ADJSP	P,12		/* allocate 40 9-bit characters */
	TLO	1,$$BP9Z	/* Make byte pointer */
	MOVEM	1,ENVTRM	/* Save it */
	IBP	ENVTRM		/* Make it point to first char */
	MOVE	2,STRTRM	/* Start with "TERM=" */
	SETZ	3,
	SOUT%
	MOVSI	B,-TRMLEN	/* Get table length */
TRMTYP:	HLRZ	C,TRMTAB(B)	/* Get type value */
	CAIE	D,(C)		/* Is it ours? */
	 AOBJN	B,TRMTYP	/* No, keep looking */
	HRRO	2,TRMTAB(B)	/* Get string pointer */
	SETZ	3,
	SOUT%			/* Add to "TERM=" */

	/* Setup default "HOME=" variable */

	MOVNI	1,1		/* Current job */
	HRROI	2,D		/* Store 1 word in D */
	MOVEI	3,.JILNO	/* Get logged in directory */
	GETJI%
	 SETZ	D,		/* Clear directory on error */
	XMOVEI	1,1(P)		/* Get pointer to stack space */
	ADJSP	P,26		/* allocate 88 9-bit characters */
	TLO	1,$$BP9Z	/* Make byte pointer */
	MOVEM	1,ENVHOM	/* Save it */
	IBP	ENVHOM		/* Make it point to first char */
	MOVE	2,STRHOM	/* Start with "HOME=" */
	SETZ	3,
	SOUT%
	MOVE	2,D		/* Get user number */
	MOVE	D,1		/* Save pointer to start of DEV:<DIR> */
	SKIPE	2		/* Skip DIRST if no dir */
	 DIRST%			/* Convert to string */
	  MOVE 1,D		/* Restore pointer on error */
	MOVEM	1,ENDHOM	/* Save pointer to end for later */

	/* Now check for JFN passed in */

	MOVE	S,P		/* Save pointer to temp space */
	HLRZ	1,$STACS+16	/* Get environment JFN */
	JUMPN	1,ENVST1	/* Jump if already set up */
	SETZM	ENVDON		/* Complete environment not passed */
	ADJSP	P,2		/* Get some temp space */
	MOVE	1,ENDHOM	/* Tack onto end of "HOME=" string */
	HRROI	2,[ASCIZ /KCC.ENV/]
	SETZ	3,
	SOUT%
	MOVSI	1,(<GJ%SHT+GJ%OLD>) /* Get old file */
	MOVE	2,D		/* Get pointer to filename */
	GTJFN%
	 ERJMP	ENVSTE		/* Jump on error */
	MOVE	2,[7B5+OF%RD]	/* Open for 7 bit read */
	OPENF%
	 ERJMP	ENVSTE		/* Jump on error */
ENVST1:	SETZ	2,		/* Force to beginning of file */
	SFPTR%
ENVSTE:	 SETZ	1,		/* Clear JFN on error */
	MOVE	P,S		/* Reset stack above filename */
	MOVEM	1,ENVLEN	/* Save JFN here temporarily */

	/* If _urtsud.su_path_out_type is set to
	   _URTSUD_PATH_OUT_NATIVE, we leave the value as:

		DEV:<DIR>

	   otherwise, we change the string to:

		/DEV/DIR
	*/

	MOVE	A,@PATHO	/* Get _urtsud.su_path_out_type value */
	CAIE	A,_URTSUD_PATH_OUT_UNIX
	 JRST	ENVHM1		/* Native output requested, don't fix */
	SETZ	A,
	DPB	A,ENDHOM	/* Clobber trailing "/" */
	MOVE	A,D		/* Get pointer to first character */
	ILDB	B,A		/* Get first character */
	MOVEI	C,"/"		/* Initial slash */
	JRST	ENVHM4		/* And go store */

ENVHM2:	CAIE	C,"V"-100	/* ^V quote? */
	 JRST	ENVHM3		/* No */
	MOVE	C,B		/* Yes, discard it, get following character */
	ILDB	B,A		/* Get next character */
	JRST	ENVHM4		/* Now go do store without checking */

ENVHM3:	CAIL	C,"A"		/* Upper case A */
	 CAILE	C,"Z"		/* thru upper case Z? */
	  CAIA			/* No */
	   TRO	C,40		/* Yes, make lower case */
	CAIE	C,"<"		/* Start directory? */
	 CAIN	C,"."		/* Dot? */
	  MOVEI	C,"/"		/* Yes, convert to slash */
	CAIN	C,"$"		/* Dollar sign?*/
	 MOVEI	C,"."		/* Yes, change to . */
	CAIE	C,":"		/* Colon? */
	 CAIN	C,">"		/* Or end directory? */
	  CAIA			/* Yes, skip store */
ENVHM4:	   IDPB	C,D		/* Store new character */
	MOVE	C,B		/* Get old character */
	ILDB	B,A		/* Get next character */
	JUMPN	C,ENVHM2	/* And loop */
ENVHM1:	XMOVEI	2,1(P)		/* Get pointer to stack space */
	TLO	2,$$BP9Z	/* Make it 9 bit byte pointer */
	MOVEM	2,ENVPTR	/* Save it for later */
	SKIPE	ENVDON		/* Complete environment passed? */
	 JRST	ENVLGE		/* Yes, skip logicals */
	MOVSI	D,.INLJB	/* Initialize function,,index */
ENVLOG:	XMOVEI	2,1(P)		/* Get pointer to stack */
	TLO	2,$$BP9Z	/* Make it 9-bit byte pointer */
	MOVE	S,P		/* Save stack frame */
	ADJSP	P,2000		/* Allocate two pages */
	MOVE	1,D		/* Get function,,index */
	INLNM%			/* Get next logical name */
	 JRST	ENVLG1		/* Error, try next table */
	MOVE	A,1(S)		/* Get first word of logical name */
	CAME	A,[byte (9) "C","E","N","V"] /* Is it our special prefix? */
	 JRST	ENVLG2		/* No, not one of ours */
	XMOVEI	C,2(S)		/* Get pointer to second word */
	TLO	C,$$BP90	/* Make it pointer to first byte */
	LDB	C,C		/* Get character following "CENV" */
	CAIE	C,"-"		/* Is it "-"? */
	 JRST	ENVLG2		/* No, not one of ours */
	IBP	2		/* Advance past end of name */
	MOVE	C,2		/* Save for later use */
        XMOVEI	1,1(S)		/* Get pointer to logical name */
	TLO	1,$$BP9Z	/* Make it 9-bit byte pointer */
ENVLGQ:	MOVEI	3,"V"-100	/* Get quote character */
	IDPB	3,2		/* Store in destination */
	ILDB	3,1		/* Get byte from source */
	IDPB	3,2		/* Copy to destination */
	JUMPN	3,ENVLGQ	/* Loop until null */
	SETO	1,		/* Prepare to backup destination */
	ADJBP	1,2		/* Backup destination pointer */
	DPB	3,1		/* Clobber last quote to null */
	HLRZ	1,D		/* Get function code */
	CAIN	1,.INLJB	/* Job table? */
	 SKIPA	1,[.LNSJB]	/* Yes, read from job table */
	  MOVEI	1,.LNSSY	/* No, read from system table */
	MOVE	2,C		/* Point to quoted logical name */
	MOVE	3,C		/* And overwrite it with definition */
	LNMST%			/* Get definition */
	 JRST	ENVLG2		/* Error, try next entry */
	MOVEI	1,"="
	DPB	1,C		/* Splice name+"="+def */
	XMOVEI	1,1(S)		/* Get pointer to first word */
	TLO	1,$$BP9Z	/* Make it 9-bit byte pointer */
	MOVEI	2,5		/* Skip first 5 characters */
	ADJBP	2,1		/* After start of string */
	SETZ	3,		/* Process until null */
	SOUT%			/* Move name down over "CENV-" */
	MOVEI	2,12		/* Get LF */
	IDPB	2,1		/* And terminate definition */
	SETZ	2,		/* Store NULLs */
	IDPB	2,1		/* At end of string */
	MOVE	C,1		/* Save pointer to end word */
	IDPB	2,1		/* Fill out word with NULLs */
	IDPB	2,1		/* Fill out word with NULLs */
	IDPB	2,1		/* Fill out word with NULLs */
	TLZ	C,$$BPPS	/* Get just pointer to last word */
	XMOVEI	B,(P)		/* Get pointer to top of stack */
	SUB	C,B		/* Compute difference */
	ADJSP	P,(C)		/* Adjust stack to end of definition */
	CAIA			/* and skip restore */
ENVLG2:	 MOVE	P,S		/* Restore stack frame */
	AOJA	D,ENVLOG	/* Increment index and loop */

ENVLG1:	MOVE	P,S		/* Restore stack frame */
	HLRZ	A,D		/* Get function code */
	CAIN	A,.INLSY	/* Have we done system table yet? */
	 JRST	ENVLGE		/* Yes, all done */
	MOVSI	D,.INLSY	/* No, do it now, reset index */
	JRST ENVLOG

ENVLGE:	XMOVEI	2,1(P)		/* Get pointer to first unused word on stack */
	TLO	2,$$BP9Z	/* Make it 9-bit byte pointer */
	SETZ	3,		/* In case no file */
	SKIPN	1,ENVLEN	/* Get JFN back */
	 JRST	ENVST3		/* Jump if no file to read */
ENVST2:	ADJSP	P,1000		/* Get another page of space */
	MOVNI	3,4000		/* Which is this many 9 bit characters */
	SIN%			/* Read up to that much */
	 ERJMP	.+1		/* Ignore errors */
	JUMPE	3,ENVST2	/* Loop until end */
	TLO	1,(<CZ%ABT>)	/* Close with abort */
	CLOSF%
	 ERJMP	.+1		/* Ignore errors */
ENVST3:	MOVE	C,2		/* Save byte pointer to last byte */
	SETZ	D,		/* Insure remainder of word is null */
	IDPB	D,2
	IDPB	D,2
	IDPB	D,2
	TLZ	C,$$BPPS	/* Get address of last word */
	XMOVEI	D,(P)		/* Get current stack address */
	SUB	C,D		/* Compute difference */
	ADJSP	P,(C)		/* Move stack pointer to end of data */
	XMOVEI	A,1(P)		/* Get pointer to end */
	SUB	A,ENVPTR	/* Less beginning */
	TLZ	A,$$BPPS	/* Clear extraneous bits */
	LSH	A,2		/* Make it byte count */
	MOVEM	A,ENVLEN	/* And save it here */
	/* We now have the environment data on the stack */
	XMOVEI	A,1(P)		/* Get pointer to first word of environment */
	MOVEM	A,$ENVPT	/* Save pointer to environ array */
ENVLOP:	SOSGE	ENVLEN		/* Any data remaining? */
	 JRST	ENVEND		/* No */
	ILDB	A,ENVPTR	/* Get next character */
	JUMPE	A,ENVLOP	/* Skip nulls, */
	SKIPN	$SARGV		/* If already collecting argv, */
	 CAIE	A,"*"		/* Or not special entry */
	  JRST	ENVENT		/* enter in environment or argv */
	/* Here we process special values from environment */
	SETZ	B,		/* Initialize name register */
ENVSP:	SOSGE	ENVLEN
	 JRST	ENVEND
	ILDB	A,ENVPTR
	CAIN	A,"="
	 JRST	ENVSP1
	TRZE	A,100		/* Truncate to 6 bits */
	 TRZ	A,40		/* Force LC to UC */
	TRC	A,40		/* Convert to 6 bit */
	LSH	B,6
	IOR	B,A		/* In B */
	JRST ENVSP

ENVSP1:	CAME	B,['UMASK']	/* Set umask()? */
	 CAIN	B,'CWD'		/* Set current directory? */
	  JRST	ENVOCT		/* Yes, go collect octal number */
	CAME	B,['DEBUG']	/* Debug flags? */
	 CAMN	B,['STDERR']	/* Set stderr? */
	  JRST	ENVOCT		/* Yes, go collect octal number */
	CAMN	B,['HERIT']	/* Setting heritage? */
	 JRST	ENVHER		/* Yes, store pointer */
	CAIN	B,'TMP'		/* Set /tmp dir? */
	 JRST	ENVTMP		/* Yes, go parse directory spec */
	CAMN	B,['ARGV']	/* Program arguments? */
	 JRST	ENVARG		/* Yes */
ENVEOL:	SETZ	B,		/* Start with no copy pointer */
	LDB	A,ENVPTR	/* Load current character */
ENVEL2:	CAIN	A,026		/* ^V quote? */
	 JRST	ENVEL1		/* Yes */
	CAIE	A,15		/* On CR */
	 CAIN	A,12		/* or LF */
	  CAIA			/* Yes */
	   JRST	ENVEL3		/* Else keep looking */
	SETZ	A,
	DPB	A,ENVPTR	/* Terminate line with null */
	SKIPE	B		/* Moving string? */
	 IDPB	A,B		/* Terminate moved string */
	JRST	ENVLOP		/* And go process another line */

ENVEL1:	SOS	ENVLEN		/* Get next character */
	ILDB	A,ENVPTR
	SKIPE	B		/* Is copy pointer setup? */
	 JRST ENVEL3		/* Yes */
	MOVNI	B,2		/* Get IDPB pointer to quote character */
	ADJBP	B,ENVPTR	/* Adjust */
ENVEL3:	SKIPE	B		/* Moving string? */
	 IDPB	A,B		/* Yes, desposit character */
ENVEL4:	SOSGE	ENVLEN		/* Count down characters left in env */
	 JRST	ENVEND		/* All gone */
	ILDB	A,ENVPTR	/* Get next character */
	JRST	ENVEL2		/* And go check it */

ENVHER:	MOVE	A,ENVPTR	/* Get pointer to heritage string passed */
	MOVEM	A,HERPTR	/* Save pointer for copying */
	JRST	ENVEOL		/* Advance over string */

ENVTMP:	XMOVEI	A,1(P)		/* Get pointer to scratch space */
	TLO	A,$$BP7Z	/* Make it appropriate 7 bit pointer */
	MOVE	B,ENVPTR	/* Get copy of environment pointer */
ENVTM1:	ILDB	C,B		/* Yes, get next */
	CAIE	C,12		/* Line feed? */
	 CAIN	C,15		/* or carriage return? */
	  SETZ	C,		/* Yes, make it null */
	IDPB	C,A		/* Copy character to new string */
	JUMPN	C,ENVTM1	/* Continue if not null */
	HRLI	1,(RC%EMO)	/* Exact match only */
	XMOVEI	2,1(P)		/* Get pointer to scratch space again */
	TLO	2,$$BP7Z	/* Make it 7 bit byte pointer */
	RCDIR%			/* Translate */
	 ERJMP	ENVEOL		/* Error, go find next entry */
	TLNN	1,(RC%NOM)	/* Match? */
	 MOVEM	3,$TMPDR	/* Yes, store tmp directory number */
	JRST	ENVEOL		/* And go find next entry */

ENVOCT:	SETZ	C,		/* Init octal value */
ENVOC1:	SOSGE	ENVLEN		/* Count down characters left in env */
	 JRST	ENVEND		/* All gone */
	ILDB	A,ENVPTR	/* Get next character */
	CAIL	A,"0"		/* Legal octal digit? */
	 CAILE	A,"7"		/* 	"	      */
	  JRST	ENVOC2		/* No, end number */
	LSH	C,3		/* Accumulate octal digits */
	TRO	C,-"0"(A)	/* Add new digit */
	JRST	ENVOC1		/* Try for another */

ENVOC2:	CAIE	A,15		/* Did we end on CR? */
	 CAIN	A,12		/* or LF? */
	  CAIA			/* Yes */
	   JRST	ENVEOL		/* No, error, discard this line */
	CAIE	B,'CWD'		/* Setting current dir? */
	 JRST	ENVOC3		/* No, umask, debug or stderr */
	MOVEM	C,$STDIR	/* Yes, store current directory */
	JRST	ENVEOL		/* Done, get to end of line */

ENVOC3:	CAME	B,['UMASK']	/* Setting umask? */
	 JRST	ENVOC4		/* No, debug or stderr */
	MOVEM	C,$UMASK	/* Store in system data */
	JRST	ENVEOL		/* Done, get to end of line */

ENVOC4:	CAME	B,['DEBUG']	/* Setting debug flags? */
	 JRST	ENVOC5		/* No, stderr */
	IORM	C,$DEBUG	/* Add to any debug flags already set */
	JRST	ENVEOL		/* Done, get to end of line */

ENVOC5:	MOVEM	C,$STDER	/* Store for URT.C */
	JRST	ENVEOL		/* Done, get to end of line */

ENVARG:	SKIPN	ENVDON		/* Are we processing user file? */
	 JRST	ENVEND		/* Yes, don't process argv array */
	JSP	S,ENVFIN	/* Finish environ array */
	SOSG	ENVLEN		/* First argv entry is on current line */
	 JRST	ENVEND
	ILDB	A,ENVPTR	/* Enter with first character set up */
	PUSH	P,ENVPTR	/* Save pointer to first arg on stack */
	XMOVEI	B,(P)		/* Get address of first argv entry */
	MOVEM	B,$SARGV	/* Save pointer to argv array */
	AOS	$SARGC		/* Count first argv entry */
	JRST	ENVEOL		/* Find end of line and terminate */

ENVENT:	SKIPN	$SARGV		/* In argv array? */
	 SKIPE	ENVDON		/* or not processing user file? */
	  JRST	ENVNT1		/* Yes, no duplicate/default check */
	CAIE	A,15		/* Immediate end (null environment entry)? */
	 CAIN	A,12		/* 	"	*/
	  JRST ENVLOP		/* Yup, skip this one */
	MOVE	B,A		/* Save first character of env var name */
	MOVE	C,ENVPTR	/* Get temp copy of pointer */
	MOVE	D,ENVLEN	/* Get temp copy of count */
ENVDEF:	SOJL	D,ENVEND	/* Done if no more characters */
	ILDB	A,C		/* Get next character */
	CAIN	A,"="		/* End name? */
	 JRST	ENVDF1		/* Yes */
	TLNE	B,777770	/* Do we have 4 characters already? */
	 JRST	ENVDF2		/* Yes, not default name */
	LSH	B,7
	IOR	B,A		/* Add character of name */
	JRST	ENVDEF

ENVDF1:	TLNN	B,777770	/* Do we have 4 characters? */
	 JRST	ENVDF3		/* No, not default name */
	CAMN	B,["HOME"]	/* Is it "HOME="? */
	 JRST	[SKIPN ENVHOM	/* Yes, already seen it? */
		  JRST ENVEOL	/* Yes, skip it completely */
		 SETZM ENVHOM	/* No, flag seen */
		 JRST ENVNT1]	/* and enter it */
	CAMN	B,["USER"]	/* Is it "USER="? */
	 JRST	[SKIPN ENVUSR	/* Yes, already seen it? */
		  JRST ENVEOL	/* Yes, skip it completely */
		 SETZM ENVUSR	/* No, flag seen */
		 JRST ENVNT1]	/* and enter it */
	CAMN	B,["PATH"]	/* Is it "PATH="? */
	 JRST	[SKIPN ENVPTH	/* Yes, already seen it? */
		  JRST ENVEOL	/* Yes, skip it completely */
		 SETZM ENVPTH	/* No, flag seen */
		 JRST ENVNT1]	/* and enter it */
	CAMN	B,["TERM"]	/* Is it "TERM="? */
	 JRST	[SKIPN ENVTRM	/* Yes, already seen it? */
		  JRST ENVEOL	/* Yes, skip it completely */
		 SETZM ENVTRM	/* No, flag seen */
		 JRST ENVNT1]	/* and enter it */
	JRST ENVDF3

ENVDF2:	SOJL	D,ENVEND	/* Continue to scan candidate */
	ILDB	A,C		/* Looking for */
	CAIE	A,"="		/* "=" */
	 JRST	ENVDF2		/* Keep looking */
/* Here we know candidate is valid up to "=" */
ENVDF3:	XMOVEI	A,1(P)		/* Get address of next new entry */
	SUB	A,$ENVPT	/* Compute size of current table */
	MOVEM	A,$ENVSZ	/* Save here */
	MOVE	S,$ENVPT	/* Get pointer to current entries */
ENVDF4:	SOSGE	$ENVSZ		/* Count down entries */
	 JRST ENVNT1		/* End of list, not a duplicate */
	MOVE	A,(S)		/* Pick up byte pointer to entry */
	MOVE	B,ENVPTR	/* Get pointer to candidate */
	LDB	C,A		/* Get first byte of entry */
	LDB	D,B		/* Get first byte of candidate */
	JRST	ENVDF6		/* Enter loop */

ENVDF5:	ILDB	C,A		/* Get next byte of entry */
	ILDB	D,B		/* Get next byte of candidate */
ENVDF6:	CAME	C,D		/* Match? */
	 AOJA	S,ENVDF4	/* No, advance to next entry */
	CAIE	C,"="		/* Yes, are we at end of name? */
	 JRST	ENVDF5		/* No, keep comparing */
	JRST	ENVEOL		/* Yes, discard duplicate */

ENVNT1:	PUSH	P,ENVPTR	/* Save pointer in environ or argv array */
	SKIPE	$SARGV		/* In argv array? */
	 AOS	$SARGC		/* Yes, count another argv entry */
	JRST	ENVEOL		/* Find end of line and terminate */

ENVEND:	SKIPN	$SARGV		/* In argv array? */
	 JRST	ENVEN1		/* No, finish up and do RSCAN */
	PUSH	P,[0]		/* Terminate argv array with NULL */
	HRROI	1,[0]		/* Byte pointer to 0 */
	RSCAN%			/* Clear RSCAN buffer */
	 JFCL			/* Ignore failure */
	JRST SRESET		/* All done */

ENVEN1:	 JSP	S,ENVFIN	/* No,  finish environ array */
	SKIPN	A,HERPTR	/* Any *HERIT= pointer? */
	 JRST	ENVEN2		/* No */
	SETO	B,
	ADJBP	B,$HERIT	/* Get pointer to where to store it */
	MOVEI	C,^D<_MAXHERIT>	/* Get max characters to move */
ENVHR1:	ILDB	D,A		/* Get a character */
	IDPB	D,B		/* Copy to destination */
	SKIPE	D		/* Done if moved null */
	 SOJG	C,ENVHR1	/* Loop if room left */
ENVEN2:	MOVEI	1,.RSINI	/* Get RSCAN info */
	RSCAN%
	 SETZ	1,		/* Flag no data on error */
	JUMPLE	1,SRESET	/* All done if no data */
	XMOVEI	2,1(P)		/* Get pointer to stack buffer */
	TLO	2,$$BP9Z	/* Make it 9-bit byte pointer */
	MOVEM	2,$RSCPT	/* Save pointer */
	IBP	$RSCPT		/* Point to first character */
	MOVN	3,1		/* Get -count to read */
	LSH	1,-2		/* Make it count of words - 1 */
	ADJSP	P,1(1)		/* Allocate words on stack */
	MOVEI	1,.CTTRM	/* Read controlling terminal for data */
	SIN%			/* Read command line onto stack */
	SETZ	1,
	IDPB	1,2		/* Terminate with NULL */
	JRST	SRESET		/* All done with environment/argv/rescan */

/* End of environ processing, add defaults and extra space */
ENVFIN:	SKIPE	ENVDON		/* Are we processing user file? */
	 JRST	ENVFN1		/* No, no logicals/defaults */
	SETZ	A,
	IDPB	A,ENDHOM	/* Clean up end of "HOME=" string */
	SKIPE	ENVHOM		/* Did we get "HOME="? */
	 PUSH	P,ENVHOM	/* No, add default */
	SKIPE	ENVUSR		/* Did we get "USER="? */
	 PUSH	P,ENVUSR	/* No, add default */
	SKIPE	ENVPTH		/* Did we get "PATH="? */
	 PUSH	P,ENVPTH	/* No, add default */
	SKIPE	ENVTRM		/* Did we get "TERM="? */
	 PUSH	P,ENVTRM	/* No, add default */
ENVFN1:	PUSH	P,[0]		/* Terminate list with NULL */
	ADJSP	P,ENVSLOP	/* Leave some slop for new entries */
	XMOVEI	B,1(P)		/* Get address of word following environment */
	SUB	B,$ENVPT	/* Subtract beginning of environment */
	MOVEM	B,$ENVSZ	/* This is array size */
	JRST	(S)		/* Return to caller */

TRMTAB:
#if monsymdefined(".TT33")
    .TT33,,[ASCIZ /tty33/]
#endif
#if monsymdefined(".TT35")
    .TT35,,[ASCIZ /tty35/]
#endif
#if monsymdefined(".TT37")
    .TT37,,[ASCIZ /tty37/]
#endif
#if monsymdefined(".TTEXE")
    .TTEXE,,[ASCIZ /execuport/]
#endif
#if monsymdefined(".TTDEF")
    .TTDEF,,[ASCIZ /DEFAULT/]
#endif
#if monsymdefined(".TTIDL")
    .TTIDL,,[ASCIZ /IDEAL/]
#endif
#if monsymdefined(".TTV05")
    .TTV05,,[ASCIZ /vt05/]
#endif
#if monsymdefined(".TTV50")
    .TTV50,,[ASCIZ /vt50/]
#endif
#if monsymdefined(".TTL30")
    .TTL30,,[ASCIZ /la30/]
#endif
#if monsymdefined(".TTG40")
    .TTG40,,[ASCIZ /gt40/]
#endif
#if monsymdefined(".TTL36")
    .TTL36,,[ASCIZ /la36/]
#endif
#if monsymdefined(".TTV52")
    .TTV52,,[ASCIZ /vt52/]
#endif
#if monsymdefined(".TT100")
    .TT100,,[ASCIZ /vt100/]
#endif
#if monsymdefined(".TTL38")
    .TTL38,,[ASCIZ /la38/]
#endif
#if monsymdefined(".TT120")
    .TT120,,[ASCIZ /la120/]
#endif
#if monsymdefined(".TT125")
    .TT125,,[ASCIZ /vt125/]
#endif
#if monsymdefined(".TTK10")
    .TTK10,,[ASCIZ /gigi/]
#endif
#if monsymdefined(".TT102")
    .TT102,,[ASCIZ /vt102/]
#endif
#if monsymdefined(".TTH19")
    .TTH19,,[ASCIZ /h19/]
#endif
#if monsymdefined(".TT131")
    .TT131,,[ASCIZ /vt131/]
#endif
#if monsymdefined(".TT200")
    .TT200,,[ASCIZ /vt200/]
#endif
#if monsymdefined(".TTADM")
    .TTADM,,[ASCIZ /adm3a/]
#endif
#if monsymdefined(".TTDAM")
    .TTDAM,,[ASCIZ /dm2500/]
#endif
#if monsymdefined(".TTHP")
    .TTHP,,[ASCIZ /hp2645/]
#endif
#if monsymdefined(".TTHAZ")
    .TTHAZ,,[ASCIZ /h1500/]
#endif
#if monsymdefined(".TT43")
    .TT43,,[ASCIZ /tty43/]
#endif
#if monsymdefined(".TTSRC")
    .TTSRC,,[ASCIZ /soroc/]
#endif
#if monsymdefined(".TTGIL")
    .TTGIL,,[ASCIZ /gillotine/]
#endif
#if monsymdefined(".TTTEL")
    .TTTEL,,[ASCIZ /t1061/]
#endif
#if monsymdefined(".TTTEK")
    .TTTEK,,[ASCIZ /tek4025/]
#endif
#if monsymdefined(".TTANN")
    .TTANN,,[ASCIZ /aaa/]
#endif
#if monsymdefined(".TTCPT")
    .TTCPT,,[ASCIZ /concept100/]
#endif
#if monsymdefined(".TTIBM")
    .TTIBM,,[ASCIZ /ibm3101/]
#endif
#if monsymdefined(".TTTVI")
    .TTTVI,,[ASCIZ /tvi912/]
#endif
#if monsymdefined(".TTTK3")
    .TTTK3,,[ASCIZ /tek4023/]
#endif
#if monsymdefined(".TTDM2")
    .TTDM2,,[ASCIZ /dm1520/]
#endif
#if monsymdefined(".TTAMB")
    .TTAMB,,[ASCIZ /ambassador/]
#endif
#if monsymdefined(".TTESP")
    .TTESP,,[ASCIZ /esprit/]
#endif
#if monsymdefined(".TTFRD")
    .TTFRD,,[ASCIZ /freedom100/]
#endif
#if monsymdefined(".TTFR2")
    .TTFR2,,[ASCIZ /freedom200/]
#endif
#if monsymdefined(".TTANS")
    .TTANS,,[ASCIZ /ansi/]
#endif
#if monsymdefined(".TTAVT")
    .TTAVT,,[ASCIZ /avt/]
#endif
TRMLEN==.-TRMTAB
	 0,,[ASCIZ /Unknown/]
#endif

SRESET:	RESET%			/* Initialize the world monitor-wise. */
	JRST SREADY		/* All ready to go, jump to start the rest. */
#endasm

#asm
#if SYS_T20
/* Perform extended addressing setup */

DOEXTA:	SETZ	11,		; From section zero
	MOVEI	10,$$SECT	; to Destination section
	MOVEI	6,.FHSLF
	MOVEI	7,.FHSLF	; From and to ourself
	PUSHJ P,$MAPSC		; Map section!

	; Mapped ourselves into a non-zero section, now start executing there.
	MOVE 16,[XCODE,,1]	; Copy code into ACs for extended-addr start.
	BLT 16,1+XCODEL-1
	JRST 4			; Go!

XCODE:	-1			; 1 PMAP arg: unmap
	.FHSLF,,0		; 2 PMAP arg: starting on page 0 of self
	PM%CNT!PM%EPN!1000	; 3 PMAP arg: All pages of section zero
	PMAP%			; 4 Code: execute PMAP to flush sect 0
	XJRSTF 6		; 5 Code: then jump into non-zero section!
	0			; 6 Address: no PC flags
	$$SECT,,ESTART		; 7 Address: jump to here (extended addr)
XCODEL==<.-XCODE>

	; At this point we are now running in a non-zero section!
	; Need to set up new stack and adjust some variables.
ESTART:
	;; Make a stack in section N+1
	MOVSI P,$$SECT+1	; Get stack pointer to 1st loc in sect N+1
	SETZ	1,		; Creating
	HLRZ	2,P		; In stack section
	HRLI	2,.FHSLF	; On ourself
	MOVEI	3,1		; One section
	SMAP%			; Make it
	SETZM	(P)		; Create page 0 of stack section
	HLLOS	P		; Make max section address (n,,-1)
	SETZM	(P)		; Create high page (777) of stack section

	MOVE	1,P		; Use that address
	LSH	1,-PG$BTS	; to set up highest page number
	HRLI	1,.FHSLF	; On self
	SETZ	2,		; No access privileges
	SPACS%			; Write-protect the last page!
	TRZ	1,777		; Similarly write-protect page zero,
	SPACS%			; to bracket stack.
	HRRI	P,PG$SIZ	; Now point to page 1 as start of stack!

	; Set up EDATA, ETEXT, and END for memory allocation
	MOVSI 1,$$SECT+1	/* Set up <2,,0> as end of data and code */
	MOVEM	1,.EDATA	;Both initialized data and code
	MOVEM	1,.ETEXT	;are in section 1 only.
	SETZ	1,		;Make a new section
	HRRZI	2,$$SECT+2	;In section 3
	HRLI	2,.FHSLF	;For us
	MOVEI	3,1		;One section
	SMAP%
	MOVSI	1,$$SECT+2	/* Say <3,,0> (section 3) is */
	MOVEM	1,.END		/* the first location past end of program */
	MOVE	1,[37,,700000]	/* And this is the first location XDDT wants */
	MOVEM	1,.EALLOC	/* so stop allocating memory at that point. */
	JRST	ENVSET		/* Join common code */
#endif /* T20 */
#endasm

/* <KCC.LIB>CRT.C.14, 26-Jul-85 14:35:26, Edit by KRONJ */
/*  Fix $MAPSC to work for pre-release-5 TOPS-20 */
#asm
/*
** $MAPSC - Check map for one section and copy across to new fork.
** This auxiliary subroutine is also used by FORK().
** Call with
**    5/unchangeable by $mapsc
**    6/destination fork handle
**    7/source fork handle
**    10/destination section
**    11/source section
**
** We use the stack for scratch space, so have to be careful.
*/
	INTERN $MAPSC
$MAPSC:	MOVE 16,P		/* Copy stack pointer */
	ADJSP P,10000		/* Give us some stack space */

/*
** Normal TOPS-20 (releases 5 and beyond) code.
** Read in the map all at once, and then do individual copies.
**
** Note that no SMAP% is needed to create the destination section;
** it will be done implicitly by the PMAP%s.
*/

#if SYS_T20
	MOVE 1,11		/* Copy source section number */
	HRL 1,7			/* and source handle */
	RSMAP%			/* Read section map */
	 ERJMP mapsc3		/* lost, go try it the old way */
	AOJE 1,mapsc2		/* If unmapped, dont copy */

	/* Have section, read page maps */
	MOVEI 1,4		/* Length of argument block is 4 */
	MOVEI 2,1000		/* Want a full section of pages */
	DMOVEM 1,1(16)		/* Save as first two words of argument block */
	MOVE 1,11		/* Get source section number */
	LSH 1,11		/* into page number (9 bits) */
	XMOVEI 2,5(16)		/* and a pointer to some scratch space */
	DMOVEM 1,3(16)		/* as third and fourth words of block */
	HRLZ 1,7		/* On source handle */
	XMOVEI 2,1(16)		/* with argument block */
	XRMAP%			/* read in a bunch of paging info at once */

	/* Now set up for individual page loop */
	XMOVEI 13,4000(16)	/* Get a place above the top of XRMAP% info */
	LSH 13,-11		/* as page number (9 bits) */
	HRLI 13,.FHSLF		/* of self (not source) */
	MOVE 14,10		/* Get destination section this time */
	LSH 14,11		/* as page number (9 bits) */
	HRLI 14,-1000		/* make AOBJN pointer */
	XMOVEI 12,5(16)		/* point to start of XRMAP% block */

mapse0:	DMOVE 1,0(12)		/* Get # of page in 1, page access wd in 2 */
	PUSHJ 17,$mappg		/* Map that page */
	ADDI 12,2		/* Move over XRMAP% info to next page */
	AOBJN 14,mapse0		/* Loop over all pages in section */
	JRST mapsc4		/* Go on to cleanup and return */
#endif /* T20 */

/*
** Fall into here when not T20 (i.e. TENEX).
** Also come here if RSMAP% fails (pre-rel-5 TOPS20 or out of range section).
** Do it the old way, with a RPACS% per page.
*/

mapsc3:	CAIN 10,0		/* Make sure destination */
	 CAIE 11,0		/* and source sections are both zero */
	  JRST mapsc2		/* Can't handle non-zero, just return */
	MOVEI 13,777(16)
	LSH 13,-11		/* Get page # of a scratch page (9 bits) */
	HRLI 13,.FHSLF		/* Make page handle */
	MOVSI 14,-1000		/* Set up AOBJN pointer */

mapsc5:	MOVSI 1,(7)		/* Get source fork handle in LH */
	HRRI 1,(14)		/* Source page # */
	RPACS%			/* Get access of page */
	PUSHJ P,$MAPPG		/* Map the page over */
	AOBJN 14,mapsc5

/*
** Here after either sequence of code.
** Unmap the scratch page and return.
*/

mapsc4:	SETO 1,			/* Unmapping */
	MOVE 2,13		/* Into temporary page */
	MOVE 3,[PM%EPN]		/* One page, extended addressing */
	PMAP%			/* Do the unmap */

/*
** Here after scratch space unmapped or if error occurred.
** Give our space back to the stack and return.
*/

mapsc2:	ADJSP P,-10000		/* Get space back */
	POPJ P,			/* Done with mapping section */

; Map one page of fork into another (can be same) fork
; 1/ page handle (fork/file,,#) of source
; 2/ page access bits for above
; 6  / fork handle of destination
; 12 / <don't touch>
; 13 / page handle of temporary page on stack for our own use
; 14 / AOBJN pointer to page number of dest, including section

	INTERN $MAPPG
$MAPPG:	TDNN	2,[RM%PEX]	; Check page access bits - page exists?
	 POPJ P,		;No, dont map across
	CAMN	1,13		; Page handle same as our temporary page?
	 POPJ P,		;Yes, dont copy
	MOVE	4,2		; Save access bits.
	MOVEI	2,(14)		; OK, copy to this dest page number
	HRLI	2,(6)		; In new inferior fork
	MOVE	3,[PM%RD!PM%EX!PM%CPY!PM%EPN] ;Copy-on-write, one page
	PMAP%			;Copy across, creating section if empty
#if SYS_T20
	JUMPGE	1,MAPPG9	;If directly from file, done with mapping
#endif
#if SYS_10X
	TLNN	4,200		; See if "Private" access bit (1B10) is set.
	 JRST MAPPG9		; Nope.
#endif

	;; Here when page is private, break copy-on-write link
	MOVE	1,2		;Now get page again as source this time
	MOVE	2,13		;Get PMAP pointer to temporary page
	MOVE	3,[PM%RD!PM%WR!PM%EPN] ;Write not copy-on-write to self from fork
	PMAP%			;Copy the page
	 ERJMP	.+1		;Dont die if tried to make circular
	HRRZ	1,13		;Get pointer again
	LSH	1,11		;As address (9 bits)
	MOVES	(1)		;Break copy-on-write link in subfork to us
MAPPG9:	POPJ P,			;All done
#endasm
}
#endif /* T20+10X */

#if SYS_T10+SYS_CSI+SYS_WTS
/************************************************************
**	C low-level Runtime Support Routines
**	TOPS-10 type Operating Systems
************************************************************
** There are two possible memory configurations - one-seg or two-seg.
** A one-seg program has everything lumped together into a low segment,
**	and all of .EDATA, .ETEXT, and .END point to the first location past
**	this.  .EALLOC can then be the max allowed by the address space.
**		.JBHRL/ 0		; Indicates no high seg.
**		.JBFF/ <1st free location>
** A two-seg program has modifiable data in the low segment, and pure code
**	in a high segment.  The hiseg may start at any page boundary from
**	400000 on up (but WAITS only allows 400000).
**	.EDATA is the end of the loseg, .ETEXT the end of the hiseg, and
**	.END-.EALLOC encompass the space between the loseg and hiseg.  The
**	portion of address space above the hiseg is unavailable, sigh.
**		.JBHRL/ <# wds used by hiseg>,,<last legal addr in hiseg>
**		.JBFF/ <1st free loc in loseg>
**
** For both cases, .END is further adjusted to make room for a stack at the
** start of dynamically allocated space.
*/

void
__exit(status)
int status;
{
#asm
	MOVE 0,$KCCID		/* Get KCC identifier into AC 0 */
	MOVE 1,-1(P)		/* Get possible argument into AC 1 */
	EXIT 0,			/* exit to monitor */
	JRST .-1		/* no reentry */

RESTART:
	OUTSTR [ASCIZ /Cannot restart
/]
	EXIT 0,
	JRST .-1

.JBREL==44			/* Highest core usage for oneseg or loseg */
.JBHRL==115			/* Highest addr in high segment */
.JBFF==121			/* 1st free loc for monitor I/O buffers */
PG$SIZ==1000			/* # words in T10 page */
PG$MSK==<PG$SIZ-1>


SSTART:	SKIPE STARTF		/* Attempting to restart the program? */
	 JRST RESTART		/* Ugh!! Go fail loudly. */
	RESET			/* Zap everything, set .JBFF from .JBSA */
	MOVE P,.JBFF		/* 1st free addr is start of our stack */
	MOVEM P,.EDATA		/* Also marks end of data stuff */
	MOVEM P,.END		/* And start of allocatable free space */
	SKIPE 2,.JBHRL		/* Do we have a hiseg? */
	 JRST STRT05		/* Yes, go handle hiseg! */

	/* One segment case */
	MOVEM P,.ETEXT		/* Set end of text to same as end of data */
	MOVEI 1,-1		/* End of alloc is end of address space! */
	JRST STRT10		/* Use this instead of 1,,0 to avoid BP ovfl*/

	/* Two segment case */
STRT05:	HRRZM 2,.ETEXT		/* Get highest hiseg addr */
	AOS 1,.ETEXT		/* Make it 1st addr after text */
	HLRZ 2,2		/* Isolate hiseg length */
	SUB 1,2			/* Sub it from addr of 1st page after hiseg */
	TRZ 1,PG$MSK		/* Round down to get start addr of hiseg! */

	/* Now decide on stack length, and update .END */
STRT10:	MOVEM 1,.EALLOC		/* AC1 contains 1st non-allocatable addr */
	SUB 1,P			/* Find # words of free space avail */
	LSH 1,-1		/* halve it */
	CAMLE 1,$STKSZ		/* Is it greater than requested stack size? */
	 MOVE 1,$STKSZ		/* Yeah, use the smaller size */
	MOVN 2,1
	HRL P,2			/* Set up stack pointer -<max size>,,<jbff> */
	ADDB 1,.END		/* Update _end, this is 1st free space loc */
	MOVEI 2,-1(1)
	CORE 2,			/* Ensure we have that much core */
	 JRST 4,.-1		/* Ugh!!! If fail, die horribly. */
	MOVEM 1,.JBFF		/* Won, update this just in case */
	
	JRST SREADY		; All set, jump to start the rest.
#endasm
}
#endif /* T10+CSI+WAITS */

#if SYS_ITS
/************************************************************
**	C low-level Runtime Support Routines
**	ITS Operating System
*************************************************************
*/
void
__exit()
{
#asm
	MOVE 0,$KCCID
	MOVE 1,-1(P)		; Just in case, leave "exit status" in AC 1.
	.LOGOUT 1,		; Return to superior (log out if disowned)
	JRST .-1		; Never continue.

RESTART:
	.VALUE [ASCIZ /: Cannot restart 
/]
	JRST .-1

; Initially we are using the TOPS-20 linker.
; When we have our own, this protocol might change.
.JBHSP==75		; Contains (20X!) page number of start of high seg
.JBHRL==115		; Contains <high seg length>,,<highest hiseg addr>
.JBSA==120		; Contains <low seg first free addr>,,<start addr>

#if 0 /* Remember these hard-to-find values for posterity or future use (!). */
SSEGLO==20	; STINK sets this to <loseg org>,,<loseg top>	; org always 0
SSEGHI==21	; STINK sets this to <hiseg org>,,<hiseg top>
#endif

PG$BTS==12		; log 2 of ITS page size
PG$SIZ==2000		; # words in ITS page
PG$MSK==<PG$SIZ-1>

; For the time being, we duplicate the TOPS-20 arrangement of having
; the stack at the end of the low segment, and new allocated memory
; at the end of the high segment.  If we want to use all of the address
; space, we can always make malloc smarter.

SSTART:	;; Initialize .EDATA, .ETEXT, .END, and .EALLOC

	SKIPE STARTF		/* Attempting to restart the program? */
	 JRST RESTART		/* Ugh!! Go fail loudly. */
	HLRZ P,.JBSA		; P: 1st loc beyond data
	MOVEM P,.EDATA		; End of data
	MOVE A,.JBHSP		; Get (20X!) page # of start of high seg
	LSH A,9			; A: 1st loc of high seg
	HLRZ B,.JBHRL		; Get first free high seg. relative address
	ADDI B,(A)		; Add to <hiseg addr> to make it absolute
	MOVEM B,.ETEXT		; End of code
	ANDCMI A,PG$MSK		; A: 1ST loc of pure
	ADDI B,PG$SIZ-1
	ANDCMI B,PG$MSK		; B: 1st loc beyond pure
	MOVEM B,.END		; New memory starts there
	MOVEI C,777777		; Don't allocate past this address.
	MOVEM C,.EALLOC

	;; Now purify text (from A to B)

	MOVEI C,(A)
	LSH C,-PG$BTS
	LSH B,-PG$BTS
	SUBM C,B		; B: - # pages to purify
	HRLI C,(B)
	.CALL [	SETZ
		SIXBIT /CORBLK/
		MOVEI %CBNDR
		MOVEI %JSELF
		SETZ C ]
	 .LOSE %LSSYS

	;; Allocate PDL and initialize P

	MOVE B,$STKSZ
	ADDI B,PG$SIZ-1(P)
	ANDCMI B,PG$MSK		; B: 1st loc beyond stack 
	CAILE B,(A)
	 .LOSE			; Doesn't fit under hiseg
	MOVEI C,(P)
	SUBI C,(B)
	HRLI P,(C)
	HRRI P,-1(P)

	;; Create missing low pages (including PDL).
	;; We have to do this because the data area might contain large
	;; regions of zeros, and the linker won't create those pages.

	LSH B,-PG$BTS		; B: # pages to check
	MOVNI A,(B)
	HRLZI A,(A)		; A: page aobjn
SSTRT1:	.CALL [	SETZ
		SIXBIT /CORTYP/
		MOVEI (A)
		SETZM B ]
	 .LOSE %LSSYS
	JUMPN B,SSTRT2
	.CALL [	SETZ
		SIXBIT /CORBLK/
		MOVEI %CBNDW
		MOVEI %JSELF
		MOVEI (A)
		SETZI %JSNEW ]
	 .LOSE %LSSYS
SSTRT2:	AOBJN A,SSTRT1

	;; Prepare for UUOs and interrupts.

	SETZM 41		; No UUOs please
	MOVE A,[-1,,[P]]
	MOVEM A,42		; The null interrupt handler
	MOVE A,[-6,,[	SIXBIT /OPTION/
			TLO %OPINT+%OPOPC
			SIXBIT /MASK/
			MOVE [%PIPDL]
			SIXBIT /TTY/
			TLO %TBNVR	; Error if TTY not avail.
			]]
	.CALL [	SETZ
		SIXBIT /USRVAR/
		MOVEI %JSELF
		SETZ A ]
	 .LOSE %LSSYS
	JRST SREADY		; All set, jump to start the rest.
#endasm
}
#endif /* ITS */
