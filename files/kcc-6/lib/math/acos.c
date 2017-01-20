/*
 *	+++ NAME +++
 *
 *	 ACOS   Double precision arc cosine
 *
 *	+++ INDEX +++
 *
 *	 ACOS
 *	 machine independent routines
 *	 trigonometric functions
 *	 math libraries
 *
 *	+++ DESCRIPTION +++
 *
 *	Returns double precision arc cosine of double precision
 *	floating point argument.
 *
 *	+++ USAGE +++
 *
 *	 double acos(x)
 *	 double x;
 *
 *	+++ REFERENCES +++
 *
 *	Fortran IV-plus user's guide, Digital Equipment Corp. pp B-1.
 *
 *	+++ RESTRICTIONS +++
 *
 *	The maximum relative error for the approximating polynomial
 *	in atan is 10**(-16.82).  However, this assumes exact arithmetic
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
 *	Additional modifications after v.3, 2-Jul-1986 are
 *	(c) Copyright Ken Harrenstien 1989
 *
 *	This routine now conforms with the description of the acos()
 *	function as defined in
 *	Harbison & Steele's "C: A Reference Manual", section 11.3.2
 *
 *	+++ INTERNALS +++
 *
 *	Computes arccosine(X) from:
 *
 *		(1)	If X = 0.0 then acos(X) = PI/2.
 *
 *		(2)	If X = 1.0 then acos(X) = 0.0
 *
 *		(3)	If X = -1.0 then acos(X) = PI.
 *
 *		(4)	If 0.0 < X < 1.0 then
 *			acos(X) = atan(Y)
 *			Y = sqrt[1-(X**2)] / X
 *
 *		(4)	If -1.0 < X < 0.0 then
 *			acos(X) = atan(Y) + PI
 *			Y = sqrt[1-(X**2)] / X
 *
 *	---
 */

#include <math.h>
#include <errno.h>
#include "pml.h"

double acos(x)
double x;
{
    double y;

    if (x > 1.0 || x < -1.0) {
	errno = EDOM;
	return 0.0;
    } 
    if (x == 0.0)
	return HALFPI;
    if (x == 1.0)
	return 0.0;
    if (x == -1.0)
	return PI;

    y = atan(sqrt(1.0 - x * x) / x);
    return (x > 0.0) ? y : (y + PI);
}
