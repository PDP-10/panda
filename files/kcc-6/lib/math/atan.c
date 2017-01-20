/*
 *	+++ NAME +++
 *
 *	 ATAN   Double precision arc tangent
 *
 *	+++ INDEX +++
 *
 *	 ATAN
 *	 machine independent routines
 *	 trigonometric functions
 *	 math libraries
 *
 *	+++ DESCRIPTION +++
 *
 *	Returns double precision arc tangent of double precision
 *	floating point argument.
 *
 *	+++ USAGE +++
 *
 *	 double atan(x)
 *	 double x;
 *
 *	+++ REFERENCES +++
 *
 *	Fortran 77 user's guide, Digital Equipment Corp. pp B-3
 *
 *	Computer Approximations, J.F. Hart et al, John Wiley & Sons,
 *	1968, pp. 120-130.
 *
 *	+++ RESTRICTIONS +++
 *
 *	The maximum relative error for the approximating polynomial
 *	is 10**(-16.82).  However, this assumes exact arithmetic
 *	in the polynomial evaluation.  Additional rounding and
 *	truncation errors may occur as the argument is reduced
 *	to the range over which the polynomial approximation
 *	is valid, and as the polynomial is evaluated using
 *	finite-precision arithmetic.
 *
 *	+++ PROGRAMMER +++
 *
 *	 Fred Fish
 *	 Goodyear Aerospace Corp, Arizona Div.
 *	 (602) 932-7000 work
 *	 (602) 894-6881 home
 *
 *	Modifications for inclusion in standard C library are
 *	(c) Copyright Ian Macky, SRI International 1985
 *	Additional modifications after v.7, 16-Jun-1987 are
 *	(c) Copyright Ken Harrenstien 1989
 *
 *	This routine now conforms with the description of the atan()
 *	function as defined in
 *	Harbison & Steele's "C: A Reference Manual", section 11.3.4
 *
 *	+++ INTERNALS +++
 *
 *	Computes arctangent(X) from:
 *
 *		(1)	If X < 0 then negate X, perform steps
 *			2, 3, and 4, and negate the returned
 *			result.  This makes use of the identity
 *			atan(-X) = -atan(X).
 *
 *		(2)	If argument X > 1 at this point then
 *			test to be sure that X can be inverted
 *			without underflowing.  If not, reduce
 *			X to largest possible number that can
 *			be inverted, issue warning, and continue.
 *			Perform steps 3 and 4 with arg = 1/X
 *			and subtract returned result from
 *			pi/2.  This makes use of the identity
 *			atan(X) = pi/2 - atan(1/X) for X>0.
 *
 *		(3)	At this point 0 <= X <= 1.  If
 *			X > tan(pi/12) then perform step 4
 *			with arg = (X*sqrt(3)-1)/(sqrt(3)+X)
 *			and add pi/6 to returned result.  This
 *			last transformation maps arguments
 *			greater than tan(pi/12) to arguments
 *			in range 0..tan(pi/12).
 *
 *		(4)	At this point the argument has been
 *			transformed so that it lies in the
 *			range -tan(pi/12)..tan(pi/12).
 *			Since very small arguments may cause
 *			underflow in the polynomial evaluation,
 *			a final check is performed.  If the
 *			argument is less than the underflow
 *			bound, the function returns x, since
 *			atan(X) approaches asin(X) which
 *			approaches X as X goes to zero.
 *
 *		(5)	atan(X) is now computed by one of the
 *			approximations given in the cited
 *			reference (Hart).  That is:
 *
 *			atan(X) = X * SUM [ C[i] * X**(2*i) ]
 *			over i = {0,1,...8}.
 *
 *			Where:
 *
 *			C[0] =	.9999999999999999849899
 *			C[1] =	-.333333333333299308717
 *			C[2] =	.1999999999872944792
 *			C[3] =	-.142857141028255452
 *			C[4] =	.11111097898051048
 *			C[5] =	-.0909037114191074
 *			C[6] =	.0767936869066
 *			C[7] =	-.06483193510303
 *			C[8] =	.0443895157187
 *			(coefficients from HART table #4945 pg 267)
 *
 *	---
 */

#include <math.h>
#include <errno.h>
#include "pml.h"

static double atan_coeffs[] = {
    .9999999999999999849899,			/* P0 must be first	*/
    -.333333333333299308717,
    .1999999999872944792,
    -.142857141028255452,
    .11111097898051048,
    -.0909037114191074,
    .0767936869066,
    -.06483193510303,
    .0443895157187				/* Pn must be last	*/
};

#define LAST_BOUND 0.2679491924311227074725	/*  DTAN (PI/12)	*/

double atan(x)
double x;
{
    if (x < 0.0) {
	if ((x = -x) < 0.0)	/* Guard against max negative number */
	    x = DBL_MAX;
	return -atan(x);
    }
    if (x > 1.0) {
	if (x >= RECIP_MAX || x <= -RECIP_MAX)
	    x = _sign(RECIP_MAX, x);
	return HALFPI - atan(1.0 / x);
    }
    if (x > LAST_BOUND)
	return SIXTHPI + atan((x * SQRT3 - 1.0) / (SQRT3 + x));
    if (x < X16_UNDERFLOWS)
	return x;
    return x * _poly(8, atan_coeffs, (x * x));
}
