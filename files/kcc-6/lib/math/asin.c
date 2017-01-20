/*
 *	+++ NAME +++
 *
 *	 ASIN   Double precision arc sine
 *
 *	+++ INDEX +++
 *
 *	 ASIN
 *	 machine independent routines
 *	 trigonometric functions
 *	 math libraries
 *
 *	+++ DESCRIPTION +++
 *
 *	Returns double precision arc sine of double precision
 *	floating point argument.
 *
 *	+++ USAGE +++
 *
 *	 double asin(x)
 *	 double x;
 *
 *	+++ REFERENCES +++
 *
 *	Fortran IV-plus user's guide, Digital Equipment Corp. pp B-2.
 *
 *	+++ RESTRICTIONS +++
 *
 *	For precision information refer to documentation of the floating
 *	point library primatives called.
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
 *	This routine now conforms with the description of the asin()
 *	function as defined in
 *	Harbison & Steele's "C: A Reference Manual", section 11.3.3
 *
 *	+++ INTERNALS +++
 *
 *	Computes arcsine(X) from:
 *
 *		(1)	If X = 0.0 then asin(X) = 0.0
 *
 *		(2)	If X = 1.0 then asin(X) = PI/2.
 *
 *		(3)	If X = -1.0 then asin(X) = -PI/2
 *
 *		(4)	If -1.0 < X < 1.0 then
 *			asin(X) = atan(Y)
 *			Y = X / sqrt[1-(X**2)]
 *
 *	---
 */

#include <math.h>
#include <errno.h>
#include "pml.h"

double asin(x)
double x;
{
    if (x > 1.0 || x < -1.0) {
	errno = EDOM;
	return 0.0;
    }
    if (x == 0.0)
	return 0.0;
    if (x == 1.0)
	return HALFPI;
    if (x == -1.0)
	return -HALFPI;
    return atan(x / sqrt(1.0 - x * x));
}
