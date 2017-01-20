/*
 *	+++ NAME +++
 *
 *	 LOG   Double precision natural log
 *
 *	+++ INDEX +++
 *
 *	 LOG
 *	 machine independent routines
 *	 math libraries
 *
 *	+++ DESCRIPTION +++
 *
 *	Returns double precision natural log of double precision
 *	floating point argument.
 *
 *	+++ USAGE +++
 *
 *	 double log(x)
 *	 double x;
 *
 *	+++ REFERENCES +++
 *
 *	Computer Approximations, J.F. Hart et al, John Wiley & Sons,
 *	1968, pp. 105-111.
 *
 *	+++ RESTRICTIONS +++
 *
 *	The absolute error in the approximating polynomial is
 *	10**(-19.38).  Note that contrary to DEC's assertion
 *	in the F4P user's guide, the error is absolute and not
 *	relative.
 *
 *	This error bound assumes exact arithmetic
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
 *	Additional modifications after v.8, 18-May-1987 are
 *	(c) Copyright Ken Harrenstien 1989
 *
 *	This routine now conforms with the description of the log()
 *	function as defined in
 *	Harbison & Steele's "C: A Reference Manual", section 11.3.16
 *
 *	+++ INTERNALS +++
 *
 *	Computes log(X) from:
 *
 *		(1)	If argument is zero then flag an error
 *			and return minus infinity (or rather its
 *			machine representation).
 *
 *		(2)	If argument is negative then flag an
 *			error and return minus infinity.
 *
 *		(3)	Given that x = m * 2**k then extract
 *			mantissa m and exponent k.
 *
 *		(4)	Transform m which is in range [0.5,1.0]
 *			to range [1/sqrt(2), sqrt(2)] by:
 *
 *				s = m * sqrt(2)
 *
 *		(4)	Compute z = (s - 1) / (s + 1)
 *
 *		(5)	Now use the approximation from HART
 *			page 111 to find ln(s):
 *
 *			log(s) = z * ( P(z**2) / Q(z**2) )
 *
 *			Where:
 *
 *			P(z**2) =  SUM [ Pj * (z**(2*j)) ]
 *			over j = {0,1,2,3}
 *
 *			Q(z**2) =  SUM [ Qj * (z**(2*j)) ]
 *			over j = {0,1,2,3}
 *
 *			P0 =  -0.240139179559210509868484e2
 *			P1 =  0.30957292821537650062264e2
 *			P2 =  -0.96376909336868659324e1
 *			P3 =  0.4210873712179797145
 *			Q0 =  -0.120069589779605254717525e2
 *			Q1 =  0.19480966070088973051623e2
 *			Q2 =  -0.89111090279378312337e1
 *			Q3 =  1.0000
 *
 *			(coefficients from HART table #2705 pg 229)
 *
 *			Note: according to a message in the Unix
 *			USENET, the accuracy of the routine
 *			can be improved by changing the definition
 *			of P2 above to:
 *
 *			P2 = -.963769093377840513e1;
 *
 *			Submitted by Guido van Rossum,
 *			{philabs,decvax}!mcvax!guido
 *			Centre for Mathematics and Computer Science,
 *			Amsterdam
 *
 *			(with thanks to Lambert Meertens)
 *
 *	(5)	Finally, compute log(x) from:
 *
 *			log(x) = (k * log(2)) - log(sqrt(2)) + log(s)
 *
 *	---
 */

#include <math.h>
#include <errno.h>
#include "pml.h"

static double log_pcoeffs[] = {
   -0.24013917955921050986e2,
    0.30957292821537650062e2,
#if 0
   -0.96376909336868659324e1,
#else
    -.963769093377840513e1,		/* See note above		*/
#endif
    0.4210873712179797145
};

static double log_qcoeffs[] = {
   -0.12006958977960525471e2,
    0.19480966070088973051e2,
   -0.89111090279378312337e1,
    1.0000
};

double log(x)
double x;
{
    int k;
    double s, z, zt2, pqofz;

    if (x <= 0.0) {
	errno = x ? EDOM : ERANGE;
	return -HUGE_VAL;
    }
    s = SQRT2 * frexp(x, &k);		/* Get mantissa and exponent */
    z = (s - 1.0) / (s + 1.0);
    zt2 = z * z;
    pqofz = z * _poly4(log_pcoeffs, zt2) / _poly4(log_qcoeffs, zt2);
    return (k * LN2) - LNSQRT2 + pqofz;
}
