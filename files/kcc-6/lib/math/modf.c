/*
**	MODF.C - split floating point number into int and fractional parts
**
**	(c) Copyright Ken Harrenstien 1989
**
**	This code does NOT conform to the description of the modf function
**	as defined in Harbison and Steele's "C: A Reference Manual",
**	section 11.3.18.  H&S is wrong in saying that the
**	2nd arg to "modf" is an (int *); both ANSI and BSD say it is a
**	(double *).  Otherwise the description is accurate.
**
** Note that this only works for normalized values.  In particular, a number
** with only the sign bit set is unnormalized.  Fortunately the hardware never
** generates such numbers.
*/

#include <c-env.h>		/* So can see what format we're using */

#if CPU_PDP10			/* Currently PDP-10 only */

double
modf(x, iptr)
double x, *iptr;		/* Note 2nd arg is ptr to double, not int! */
{
#if CENV_DFL_H			/* PDP-10 hardware double precision fmt */

#asm
	EXTERN $ZERO	/* From CRT */

	DMOVE 1,-2(17)		/* Get double arg */
	SKIPGE 7,1		/* Check for neg number, remember sign in 7 */
	 DMOVN 1,1		/* Negative, so turn it over */
	CAMG 1,[201000,,0]	/* Do we have an integer part? */
	 JRST [	SETZB 3,4	/* No, set integer part to (double) 0 */
		DMOVEM 3,@-3(17)	/* Store via pointer */
		CAIG 7,0	/* If arg was negative, */
		 DMOVN 1,1	/* must return negative result. */
		POPJ 17,]
	CAML 1,[276000,,0]	/* Do we have a fraction part? */
	 JRST [	CAIG 7,0	/* No, just store arg as integer part */
		 DMOVN 1,1
		DMOVEM 1,@-3(17)
		SETZB 1,2	/* And return zero fractional part! */
		POPJ 17,]

	/* Have both integer and fraction part.  Find fraction bit mask. */
	LDB 4,[331000,,1]	/* Get exponent */
	MOVNI 4,-200(4)		/* Find -<# bits in integral part> */
	MOVSI 5,400000		/* Get a sign-bit-set doubleword mask */
	SETZ 6,
	ASHC 5,-10(4)		/* Shift mask over exponent & integer bits */
	DMOVE 3,1		/* Copy positive # for integer part */
	AND 3,5
	AND 4,6			/* Mask out fract bits, leave integer bits */
	TLZ 5,777000		/* After ensuring that exponent preserved, */
	ANDCM 1,5		/* apply reverse mask to get fraction bits. */
	ANDCM 2,6
	JUMPL 7,[		/* If negation needed,  */
		DMOVNM 3,@-3(17)	/* store negated integer part, and */
		DMOVN 1,1		/* negate returned fractional part */
		JRST .+2]		/* Skip over DMOVEM */
	DMOVEM 3,@-3(17)	/* Store integer part */
	DFAD 1,$ZERO		/* and normalize returned fraction. */

	/* Drop thru to return */
#endasm
#else
#error modf() not implemented for this double-precision format.
#endif
}

#endif /* CPU_PDP10 */
