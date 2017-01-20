/*
**	LDEXP.C - scale exponent of double floating number
**
**	(c) Copyright Ken Harrenstien 1989
**
**	This code conforms with the description of the ldexp function
**	as defined in Harbison & Steele's "C: A Reference Manual",
**	section 11.3.15
**
** Note that this only works for normalized values.  In particular, a number
** with only the sign bit set is unnormalized.  Fortunately the hardware never
** generates such numbers.
*/

#include <c-env.h>		/* Find machine type */
#include <math.h>
#include <errno.h>

#if CPU_PDP10			/* Currently PDP-10 only */

double
ldexp(value, scale)
double value;
int scale;
{
#if CENV_DFL_H || CENV_DFL_S	/* PDP-10 hardware/software double prec fmt */

#asm
	DMOVE 1,-2(17)		/* Get value */
	SKIPN 7,1		/* Remember sign, test for zero */
	 POPJ 17,		/* Zero arg always becomes zero */
	LDB 3,[331100,,1]	/* Get exponent */
	CAIGE 7,0		/* If negative, undo ones-complement */
	 TRC 3,777
	ADDB 3,-3(17)		/* Add to scale argument */
	CAIL 3,0		/* Verify within range */
	 CAILE 3,377
	  JRST ovflow		/* Range error!  Let C code handle it. */
	DPB 3,[331100,,1]	/* Put exponent back in */
	CAIGE 7,0		/* If originally negative, */
	 TLC 1,777000		/* make exponent ones-complement again. */
#if CENV_DFL_S
	SUBI 3,33		/* Low-order word must have (exponent-27) */
	CAIGE 3,0		/* If exponent would be negative, */
	 TDZA 2,2		/* just clear low-order word completely */
	  DPB 3,[331100,,2]	/* else stick in the low-order exponent! */
#endif
	POPJ 17,
ovflow:
#endasm

#else
#error ldexp() not implemented for this double-precision format.
#endif
    errno = ERANGE;
    return (scale < 0) ? 0.0 :
		(value < 0) ? -HUGE_VAL : HUGE_VAL;
}

#endif /* CPU_PDP10 */
