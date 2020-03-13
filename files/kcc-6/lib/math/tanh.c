/*
 *	+++ NAME +++
 *
 *	 TANH   Double precision hyperbolic tangent
 *
 *	+++ INDEX +++
 *
 *	 TANH
 *	 machine independent routines
 *	 math libraries
 *
 *	+++ DESCRIPTION +++
 *
 *	Returns double precision hyperbolic tangent of double precision
 *	floating point number.
 *
 *	+++ USAGE +++
 *
 *	 double tanh(x)
 *	 double x;
 *
 *	+++ REFERENCES +++
 *
 *	Fortran IV plus user's guide, Digital Equipment Corp. pp B-5
 *
 *	+++ RESTRICTIONS +++
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
 *	Additional modifications after v.4, 2-Jul-1986 are
 *	(c) Copyright Ken Harrenstien 1989
 *
 *	This routine now conforms with the description of the tanh()
 *	function as defined in
 *	Harbison & Steele's "C: A Reference Manual", section 11.3.26
 *
 *	+++ INTERNALS +++
 *
 *	Computes hyperbolic tangent from:
 *
 *		tanh(X) = 1.0 for X > TANH_MAXARG
 *			 = -1.0 for X < -TANH_MAXARG
 *			 =  sinh(X) / cosh(X) otherwise
 *
 *	---
 */

#include <math.h>
#include <errno.h>
#include "pml.h"

double tanh(x)
double x;
{
    if (x > TANH_MAXARG)
	return 1.0;
    if (x < -TANH_MAXARG)
	return -1.0;
    return sinh(x) / cosh(x);
}
