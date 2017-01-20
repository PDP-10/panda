/*
 *	+++ NAME +++
 *
 *	 SINH   Double precision hyperbolic sine
 *
 *	+++ INDEX +++
 *
 *	 SINH
 *	 machine independent routines
 *	 math libraries
 *
 *	+++ DESCRIPTION +++
 *
 *	Returns double precision hyperbolic sine of double precision
 *	floating point number.
 *
 *	+++ USAGE +++
 *
 *	 double sinh(x)
 *	 double x;
 *
 *	+++ REFERENCES +++
 *
 *	Fortran IV plus user's guide, Digital Equipment Corp. pp B-5
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
 *	This routine now conforms with the description of the sinh()
 *	function as defined in
 *	Harbison & Steele's "C: A Reference Manual", section 11.3.22
 *
 *	+++ INTERNALS +++
 *
 *	Computes hyperbolic sine from:
 *
 *		sinh(X) = 0.5 * (exp(X) - exp(-X))
 *
 *	---
 */

#include <math.h>
#include <errno.h>
#include "pml.h"

double sinh(x)
double x;
{
    if (x > LN_MAXPOSDBL) {
	errno = ERANGE;
	return HUGE_VAL;
    }
    if (x < LN_MINPOSDBL) {
	errno = ERANGE;
	return 0.0;
    }
    return 0.5 * (exp(x) - exp(-x));
}
