/*
 *	+++ NAME +++
 *
 *	 SIGN   Transfer of sign
 *
 *	+++ INDEX +++
 *
 *	 SIGN
 *	 machine independent routines
 *	 math libraries
 *
 *	+++ DESCRIPTION +++
 *
 *	Returns first argument with same sign as second argument.
 *
 *	+++ USAGE +++
 *
 *	 double _sign(x, y)
 *	 double x, y;
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
 *	Additional modifications after v.3, 18-May-1987 are
 *	(c) Copyright Ken Harrenstien 1989
 *
 */

#include <c-env.h>

double _sign(x, y)
double x, y;
{
#if CPU_PDP10
#asm
	DMOVE 1,-2(17)		/* Get 1st double arg (X) */
	MOVE 3,1
	XOR 3,-4(17)		/* XOR the sign bit with 2nd double arg */
	CAIL 3,			/* Test result */
	 POPJ 17,		/* Bits same, just return X */
	DMOVN 1,1		/* Different, so negate X */
#endasm
#else
    if (x > 0.0) {
	if (y > 0.0)
	    return x;
	else
	    return -x;
    } else {
	if (y < 0.0)
	    return x;
	else
	    return -x;
    }
#endif
}
