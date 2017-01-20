/*
**	FREXP.C - split floating point number into fraction and exponent
**
**	(c) Copyright Ken Harrenstien 1989
**
**	This code conforms with the description of the frexp function
**	as defined in Harbison and Steele's "C: A Reference Manual",
**	section 11.3.13.
**	Ditto proposed ANSI C standard.
**
** Note that this only works for normalized values.  In particular, a number
** with only the sign bit set is unnormalized.  Fortunately the hardware never
** generates such numbers.
*/

#include <c-env.h>

#if CPU_PDP10			/* Currently PDP-10 only */

double frexp(x, nptr)
double x;
int *nptr;
{
#if CENV_DFL_H || CENV_DFL_S	/* PDP-10 hardware/software double prec fmt */

#asm
	DMOVE 1,-2(17)		/* Get double arg */
	SKIPN 7,1
	 JRST [	SETZM @-3(17)	/* If zero, clear returned exponent */
		POPJ 17,]
	LDB 3,[331100,,1]	/* Save old exponent */
	TLZ 1,777000		/* Zap it from the double */
	CAIGE 7,0		/* If was negative, do fixups */
	 TRCA 3,777		/* Neg: Exp was ones-complem, invert it */
	  TLOA 1,200000		/* Pos: Set new exp to 0 (=0200) */
	   TLO 1,577000		/* Neg: Set new exp to 0 (complem of 0200) */
	SUBI 3,200		/* Remove offset from old exponent */
	MOVEM 3,@-3(17)		/* Return old exponent to caller */
#if CENV_DFL_S
	TLZ 2,777000		/* KA-10 format must always set low-order */
	TLO 2,145000		/* exponent to 128-27 (0200-033) */
#endif
#endasm

#else
#error frexp() not implemented for this double-precision format.
#endif

}

#endif /* CPU_PDP10 */
