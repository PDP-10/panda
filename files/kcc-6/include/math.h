/* <MATH.H> - Math library definitions
**
**	(c) Copyright Ken Harrenstien 1989
**
*/

#ifndef _MATH_INCLUDED
#define _MATH_INCLUDED

#ifndef __STDC__	/* Canonicalize this indicator to avoid err msgs */
#define __STDC__ 0
#endif

#include <float.h>

#define HUGE_VAL DBL_MAX

typedef struct {double x,y;} _cabs;

#if __STDC__
extern double
	acos(double), asin(double), atan(double), atan2(double, double),
	ceil(double), cos(double), cosh(double), exp(double),
	fabs(double), floor(double), fmod(double, double),
	frexp(double, int *), ldexp(double, int), log(double),
	log10(double), modf(double, double *), pow(double, double),
	sin(double), sinh(double), sqrt(double), tan(double), tanh(double),
	hypot(double, double),
	cabs(_cabs),
	z_abs(_cabs *);
#else
extern double
	acos(), asin(), atan(), atan2(), ceil(), cos(), cosh(),
	exp(), fabs(), floor(), fmod(), frexp(), ldexp(), log(),
	log10(), modf(), pow(), sin(), sinh(), sqrt(), tan(), tanh(),
	hypot(), cabs(), z_abs();

extern long labs();		/* These are elsewhere for ANSI C */
extern int abs(), rand();
extern void srand();
#endif	/* if !__STDC__ */

#endif /* ifndef _MATH_INCLUDED */
