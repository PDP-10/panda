/*
 *	FABS.C - double-precision floating-point absolute value
 *
 *	(c) Copyright Ken Harrenstien 1989
 *		for all changes after v.4, 10-Dec-1985
 *	(c) Copyright Ian Macky, SRI International 1985
 *
 *	This code conforms with the description of the fabs function
 *	as defined in Harbison and Steele's "C: A Reference Manual",
 *	section 11.3.10
 *
 *	This is implemented as a function instead of a macro like
 *
 *		#define fabs(x)	((x) < 0) ? -(x) : (x))
 *
 *	because of the side-effect difference in a case like fabs(n++)
 */

double fabs(x)
double x;
{
	return (x < 0) ? -x : x;
}
