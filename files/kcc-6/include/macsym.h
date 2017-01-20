/* <MACSYM.H> - Macros for TOPS-20 system hacking
**
**	(c) Copyright Ken Harrenstien 1989
**
** Unlike MONSYM, the symbols in MACSYM tend to be the same across all
** systems, and the bulk of the definitions are assembler macros rather than
** constants.  So there's no point in automatically generating this file
** or in referencing MACSYM.UNV; instead we define constants explicitly,
** and provide some similar macros useful in C.
*/

#ifndef _MACSYM_INCLUDED
#define _MACSYM_INCLUDED

/* MACRO assembler pseudo equivalents */
#define XWD(lh,rh) (((lh)<<18)|((rh)&0777777))	/* Same as XWD(lh,rh) */
#define BIT(n)  (1<<(35-(n)))			/* BIT(n) same as 1Bn */

/* DEC standard program version word fields */
#define VI_WHO 0700000000000	/* Customer edit code (0-1 DEC, 2-7 customer)*/
#define VI_MAJ  077700000000	/* Major version number */
#define VI_MIN     077000000	/* Minor version/update (1=A, 2=B, ...) */
#define VI_DEC       0400000	/* Flag: output in decimal, not octal */
#define VI_EDN       0377777	/* Program Edit number */
/* Someday PGVER_(maj,min,edn,who) may exist. */

/* Miscellaneous constants. */
#define _INFIN 0377777777777	/* Plus infinity */
#define _MINFI 0400000000000	/* Minus infinity */
#define _FWORD 0777777777777	/* Full word mask */
#define _LHALF 0777777000000	/* Left half mask */
#define _RHALF 0777777		/* Right half mask */

/* PDP-10 PC flags */
#define PC_OVF BIT(0)		/* Overflow */
#define PC_CY0 BIT(1)		/* Carry 0 */
#define PC_CY1 BIT(2)		/* Carry 1 */
#define PC_FOV BIT(3)		/* Floating Overflow */
#define PC_BIS BIT(4)		/* Byte Increment Suppress (First Part Done) */
#define PC_USR BIT(5)		/* User mode */
#define PC_UIO BIT(6)		/* User In-Out mode */
#define PC_LIP BIT(7)		/* Last Instruction Public (KL+KI; not KA+KS)*/
#define PC_AFI BIT(8)		/* Address Failure Inhibit (KL+KI+KS; not KA)*/
#define PC_ATN (BIT(9)|BIT(10))	/* APR Trap Num (Trap 2,1) (KL+KI+KS; not KA)*/
#define PC_FUF BIT(11)		/* Floating Underflow */
#define PC_NDV BIT(12)		/* No Divide */

/* FLD(val,mask) 	- Make field value from right-justified value */
/* (same as MACSYM's FLD(v,m) macro) */
#define FLD(val,mask) (((unsigned)(val)*((mask)&(-(mask))))&(mask))

/* FLDGET(wd,mask)     - Get right-justified value from field in word */
#define FLDGET(wd,mask) (((unsigned)(wd)&(mask))/((mask)&(-(mask))))

/* FLDPUT(wd,mask,val) - Put right-justified value into field in word */
#define FLDPUT(wd,mask,val) (((wd)&(~(mask)))|FLD(val,mask))

#endif /* ifndef _MACSYM_INCLUDED */
