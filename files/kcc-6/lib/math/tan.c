/*
 *	+++ NAME +++
 *
 *	 TAN   Double precision tangent
 *
 *	+++ INDEX +++
 *
 *	 TAN
 *	 machine independent routines
 *	 trigonometric functions
 *	 math libraries
 *
 *	+++ DESCRIPTION +++
 *
 *	Returns tangent of double precision floating point number.
 *
 *	+++ USAGE +++
 *
 *	 double tan(x)
 *	 double x;
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
 *	This routine now conforms with the description of the tan()
 *	function as defined in
 *	Harbison & Steele's "C: A Reference Manual", section 11.3.25
 *
 *	+++ INTERNALS +++
 *
 *	Computes the tangent from tan(x) = sin(x) / cos(x).
 *
 *	If cos(x) = 0 and sin(x) >= 0, then returns HUGE_VAL as per ANSI C.
 *
 *	If cos(x) = 0 and sin(x) < 0, then returns -HUGE_VAL as per ANSI C.
 *
 *	+++ REFERENCES +++
 *
 *	Fortran IV plus user's guide, Digital Equipment Corp. pp. B-8
 *
 *	---
 */

#include <math.h>
#include <errno.h>

double tan(x)
double x;
{
    double sinx, cosx;

    sinx = sin(x);
    cosx = cos(x);
    if (cosx == 0.0) {
	errno = ERANGE;
	return (sinx >= 0.0) ? HUGE_VAL : -HUGE_VAL;
    }
    return sinx / cosx;
}
