/*
 *	+++ NAME +++
 *
 *	 POLY   Double precision polynomial evaluation
 *
 *	+++ INDEX +++
 *
 *	 POLY
 *	 machine independent routines
 *	 math libraries
 *
 *	+++ DESCRIPTION +++
 *
 *	Evaluates a polynomial and returns double precision
 *	result.  Is passed a the order of the polynomial,
 *	a pointer to an array of double precision polynomial
 *	coefficients (in ascending order), and the independent
 *	variable.
 *
 *	+++ USAGE +++
 *
 *	 double _poly(order,coeffs,x)
 *	 int order;
 *	 double *coeffs;
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
 *	Additional modifications after v.5, 18-May-1987 are
 *	(c) Copyright Ken Harrenstien 1989
 *
 *	+++ INTERNALS +++
 *
 *	Evalates the polynomial using recursion and the form:
 *
 *		P(x) = P0 + x(P1 + x(P2 +...x(Pn)))
 *
 *	---
 * KLH: modified to use iteration for efficiency, and a new routine _poly4()
 * provided to unroll the common case of 4 coefficients.
 */

#include "pml.h"

double _poly(order, coeffs, x)
register int order;
register double *coeffs;
double x;
{
#if 1				/* Use iteration (faster) */
    register double res;
    coeffs += order;		/* Point to last coeff in array */
    res = *coeffs;		/* Start result with it */
    while (--order >= 0) {
	res *= x;
	res += *--coeffs;
    }
    return res;
#else
    double curr_coeff;

    if (order <= 0)
	return *coeffs;
    else {
	curr_coeff = *coeffs++;		/* Ensure correct evaluation order */
	return curr_coeff + x * _poly(--order, coeffs, x);
    }
#endif
}

/* _POLY4 - Special case where we know we have exactly 4 coefficients.
**	This is currently used by sin, cos, and log.
*/
double _poly4(p, x)
register double *p;
double x;
{
    return p[0] + x*(p[1] + x*(p[2] + x*(p[3])));
}
