/*
 *	FMOD.C - floating-point modulus for math library
 *
 *	(c) Copyright Ken Harrenstien 1989
 *		for all changes after v.4, 12-Apr-1988
 *	(c) Copyright Ian Macky, SRI International 1985
 *
 *	This code conforms with the description of the fmod function
 *	as defined in Harbison and Steele's "C: A Reference Manual",
 *	section 11.3.12
 */

#include <math.h>
#include <errno.h>

double fmod(x, y)
double x, y;
{
    double ipart;

    if (y == 0.0) {
	errno = EDOM;
	return 0.0;
    }
    modf((x / y), &ipart);	/* integer part in ipart, forget remainder */
    return x - (ipart * y);
}
