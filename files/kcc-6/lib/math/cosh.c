/*
 *	+++ NAME +++
 *
 *	 COSH   Double precision hyperbolic cosine
 *
 *	+++ INDEX +++
 *
 *	 COSH
 *	 machine independent routines
 *	 math libraries
 *
 *	+++ DESCRIPTION +++
 *
 *	Returns double precision hyperbolic cosine of double precision
 *	floating point number.
 *
 *	+++ USAGE +++
 *
 *	 double cosh(x)
 *	 double x;
 *
 *	+++ REFERENCES +++
 *
 *	Fortran IV plus user's guide, Digital Equipment Corp. pp B-4
 *
 *	+++ RESTRICTIONS +++
 *
 *	Inputs greater than LN(DBL_MAX) result in overflow.
 *	Inputs less than LN(DBL_MIN) result in underflow.
 *
 *	For precision information refer to documentation of the
 *	floating point library routines called.
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
 *	Additional modifications after v.3, 2-Jul-1986 are
 *	(c) Copyright Ken Harrenstien 1989
 *
 *	This routine now conforms with the description of the cosh()
 *	function as defined in
 *	Harbison & Steele's "C: A Reference Manual", section 11.3.8
 *
 *	+++ INTERNALS +++
 *
 *	Computes hyperbolic cosine from:
 *
 *		cosh(X) = 0.5 * (exp(X) + exp(-X))
 *
 *	---
 */

#include <math.h>
#include <errno.h>
#include "pml.h"

double cosh(x)
double x;
{
    if (x > LN_MAXPOSDBL || x < LN_MINPOSDBL) {
	errno = ERANGE;
	return HUGE_VAL;
    }
    return 0.5 * (exp(x) + exp(-x));
}
