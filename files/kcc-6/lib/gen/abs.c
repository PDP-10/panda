/*
 *	ABS.C - integer absolute value for math library
 *
 *	(c) Copyright Ken Harrenstien 1989
 *		for all changes after v.5, 10-Dec-1985
 *	(c) Copyright Ian Macky, SRI International 1985
 *
 *	This code conforms with the description of the abs and labs function
 *	as defined in Harbison and Steele's "C: A Reference Manual",
 *	section 11.3.1
 *
 *	These are implemented as functions instead of macros like
 *
 *		#define abs(x)	((x) < 0) ? -(x) : (x))
 *
 *	because of the side-effect difference in a case like abs(n++)
 */

int abs(x)
int x;
{
	return (x < 0) ? -x : x;
}

long labs(x)
long x;
{
	return (x < 0) ? -x : x;
}

