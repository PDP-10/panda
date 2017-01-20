/*
 *	POW.C - computes the power function
 *
 *	(c) Copyright Ken Harrenstien 1989
 *		for all changes after v.6, 12-Apr-1988
 *	(c) Copyright Ian Macky, SRI International 1985
 *
 *	This code conforms with the description of the pow function as
 *	described in Harbison & Steele's "C: A Reference Manual", section
 *	11.3.19
 */

#include <math.h>
#include <errno.h>
#include "pml.h"

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* pow.c */
static double power P_((double x,double y));
static double invpower P_((double x,double y));

#undef P_

double
pow(x, y)
double x, y;
{
    double i;

    if (x > 0) {
	if (y == 0)	return 1.0;
	else if (y > 0)	return power(x, y);
	else		return invpower(x, -y);
    } else if (x == 0) {
	if (y > 0)
	    return 0.0;
	errno = EDOM;
	return -HUGE_VAL;
    }
    /* (x < 0) */
    if (modf(y, &i) != 0.0) {	/* X negative, so Y must be integral value */
	errno = EDOM;		/* Y not an integral value, domain error */
	return -HUGE_VAL;
    }
    if (y == 0)			/* Trivial case */
	return 1.0;
    if (y > 0)	x = power(-x, y);
    else	x = invpower(-x, -y);
    return ((long)i & 01) ? -x : x;	/* X negative, so result is negative
					** if Y was an odd integer!
					*/
}

static double
power(x, y)
double x, y;
{
    /* x always positive here, so needn't duplicate log() domain check */
    return exp(y * log(x));
}

static double
invpower(x, y)
double x, y;
{
    /* x always positive here, so needn't duplicate log() domain check */
    x = exp(y * log(x));
    if (x < RECIP_MIN) {	/* See if 1/x would overflow */
	errno = ERANGE;
	return HUGE_VAL;
    }
    return 1.0 / x;		/* Return reciprocal */
}
