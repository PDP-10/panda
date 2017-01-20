/*
 *	FLOOR.C - floor function for math library
 *
 *	(c) Copyright Ken Harrenstien 1989
 *		for all changes after v.8, 12-Apr-1988
 *	(c) Copyright Ian Macky, SRI International 1985
 *
 *	This code conforms with the description of the floor function
 *	as defined in Harbison and Steele's "C: A Reference Manual",
 *	section 11.3.11
 */

#include <math.h>

double floor(x)
double x;
{
    double ipart;

    if (modf(x, &ipart) < 0)	/* if has negative fractional part */
	ipart--;		/* then diddle the other direction! */
    return ipart;
}
