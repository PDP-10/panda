/*
**	CPU	- CPU definition module for all KCC programs.
**
**	(c) Copyright Ken Harrenstien, SRI International 1986
**
**	For more details on the use of these symbols and the reasons
** for their existence, see the KCC files CCOUT.C (source) and
** CRTSYM.DOC (documentation).
*/

#include <c-env.h>		/* Include default definitions */

`$$$CPU`()			/* Dummy entry point for this module */
{
#asm

/* First define $$CPxxx (CPU types) as appropriate */
#if   CPU_KA
	$$CPKA==1
	INTERN $$CPKA
#elif CPU_KI
	$$CPKI==1
	INTERN $$CPKI
#elif CPU_KS
	$$CPKS==1
	INTERN $$CPKS
#elif CPU_KL0
	$$CPKL==1
	INTERN $$CPKL
#elif CPU_KLX
	$$CPKX==1
	INTERN $$CPKX
#endif

/* Now define $$SECT and $$BPmn as appropriate */
#if CPU_KLX		/* KL-10 in non-zero section (extended addressing) */
	$$SECT==1	/* Section # to load code & data into */
	$$BP6Z==450000	/* Byte-pointer LHs for 6-bit bytes */
	$$BP60==460000
	$$BP61==470000
	$$BP62==500000
	$$BP63==510000
	$$BP64==520000
	$$BP65==530000
	$$BP7Z==610000	/* Byte-pointer LHs for 7-bit bytes */
	$$BP70==620000
	$$BP71==630000
	$$BP72==640000
	$$BP73==650000
	$$BP74==660000
	$$BP8Z==540000	/* Byte-pointer LHs for 8-bit bytes */
	$$BP80==550000
	$$BP81==560000
	$$BP82==570000
	$$BP83==600000
	$$BP9Z==670000	/* Byte-pointer LHs for 9-bit bytes */
	$$BP90==700000
	$$BP91==710000
	$$BP92==720000
	$$BP93==730000
	$$BPHZ==740000	/* Byte-pointer LHs for 18-bit bytes */
	$$BPH0==750000
	$$BPH1==760000

	$$BPPS==770000	/* BP P&S mask */
	$$BPSZ==360600	/* BP LH to get size field (here, is both P&S) */
	$$BSHF==5	/* # bits to shift in P_SUBBP */
	$$BMP6==6*40	/* Value to MULI ptr diff by for P_SUBBP */
	$$BMP7==5*40	/*    These should all be "n_$$BSHF" but FAIL loses! */
	$$BMP8==4*40
	$$BMP9==4*40
	$$BMPH==2*40
	$BPAD6==$BADX6	/* Table locations for addition in P_SUBBP */
	$BPAD7==$BADX7
	$BPAD8==$BADX8
	$BPAD9==$BADX9
	$BPADH==$BADXH

	$$PH90==<TLZA 0,050000>	/* Ptr conversion, 18-bit to 9-bit, instr #0 */
	$$PH91==<0>		/* Ptr conversion, 18-bit to 9-bit, instr #1 */
	$$P9H0==<TLZ  0,010000>	/* Ptr conversion, 9-bit to 18-bit, instr #0 */
	$$P9H1==<TLON 0,060000>	/* Ptr conversion, 9-bit to 18-bit, instr #1 */
	$$P9H2==< TLC 0,030000>	/* Ptr conversion, 9-bit to 18-bit, instr #2 */

#else			/* Everything else is for zero section */

	$$SECT==0
	$$BP6Z==440600
	$$BP60==360600
	$$BP61==300600
	$$BP62==220600
	$$BP63==140600
	$$BP64==060600
	$$BP65==000600
	$$BP9Z==441100
	$$BP90==331100
	$$BP91==221100
	$$BP92==111100
	$$BP93==001100
	$$BP8Z==441000
	$$BP80==341000
	$$BP81==241000
	$$BP82==141000
	$$BP83==041000
	$$BP7Z==440700
	$$BP70==350700
	$$BP71==260700
	$$BP72==170700
	$$BP73==100700
	$$BP74==010700
	$$BPHZ==442200
	$$BPH0==222200
	$$BPH1==002200

	$$BPPS==777777	/* BP P&S field (all of LH, for robustness) */
	$$BPSZ==300600	/* BP LH to get size field (here, just S) */
	$$BSHF==1	/* # bits to shift in P_SUBBP */
	$$BMP6==6*2	/* Value to MULI ptr diff by for P_SUBBP */
	$$BMP7==5*2	/*    These should all be "n_$$BSHF" but FAIL loses! */
	$$BMP8==4*2
	$$BMP9==4*2
	$$BMPH==2*2
	$BPAD6==$BADL6	/* Table locations for addition in P_SUBBP */
	$BPAD7==$BADL7
	$BPAD8==$BADL8
	$BPAD9==$BADL9
	$BPADH==$BADLH

	$$PH90==<TLZE 0,007700>	/* Ptr conversion, 18-bit to 9-bit, instr #0 */
	$$PH91==< TLO 0,111100>	/* Ptr conversion, 18-bit to 9-bit, instr #1 */
	$$P9H0==<TLZE 0,117700>	/* Ptr conversion, 9-bit to 18-bit, instr #0 */
	$$P9H1==<TLOA 0,002200>	/* Ptr conversion, 9-bit to 18-bit, instr #1 */
	$$P9H2==< JFCL>		/* Ptr conversion, 9-bit to 18-bit, instr #2 */

#endif	/* End of section-0 stuff */

	/* Now finish off with stuff independent of section # */
	INTERN $$SECT
	INTERN $$BP6Z, $$BP60, $$BP61, $$BP62, $$BP63, $$BP64, $$BP65
	INTERN $$BP7Z, $$BP70, $$BP71, $$BP72, $$BP73, $$BP74
	INTERN $$BP8Z, $$BP80, $$BP81, $$BP82, $$BP83
	INTERN $$BP9Z, $$BP90, $$BP91, $$BP92, $$BP93
	INTERN $$BPHZ, $$BPH0, $$BPH1
	INTERN $$BPPS, $$BPSZ, $$BSHF
	INTERN $$BMP6, $$BMP7, $$BMP8, $$BMP9, $$BMPH
	INTERN $BPAD6, $BPAD7, $BPAD8, $BPAD9, $BPADH
	INTERN $$PH90, $$PH91, $$P9H0, $$P9H1, $$P9H2

	/* From CRT.C, used in $BPADn definitions */
	EXTERN $BADX6, $BADX7, $BADX8, $BADX9, $BADXH
	EXTERN $BADL6, $BADL7, $BADL8, $BADL9, $BADLH
#endasm
}		/* End of dummy $$$CPU shell */
