/* <FLOAT.H> - ANSI floating-point limit definitions
**
**	(c) Copyright Ken Harrenstien 1989
**
*/

#ifndef _FLOAT_INCLUDED
#define _FLOAT_INCLUDED

#include <c-env.h>
#if !CPU_PDP10
#error <float.h> not supported for non-PDP10 machines
#else

/* Rounding mode for floating point addition */
#define FLT_ROUNDS	1		/* "to nearest" */

/* Radix of exponent representation */
#define FLT_RADIX	2

/* Base-FLT_RADIX digits in floating point significand */
#define FLT_MANT_DIG	27
#define DBL_MANT_DIG	62
#define LDBL_MANT_DIG	DBL_MANT_DIG	/* 59 if G format */

/* # of decimal digits of significance */
#define FLT_DIG		8
#define DBL_DIG		18
#define LDBL_DIG	DBL_DIG		/* 17 if G format */

/* Minimum negative integer such that FLT_RADIX raised to that power minus 1
** is a normalized floating-point number.
*/
#define FLT_MIN_EXP	-128
#define DBL_MIN_EXP	-128
#define LDBL_MIN_EXP	DBL_MIN_EXP	/* -1024 if G format */

/* Minimum negative integer such that 10 raised to that power is in the range
** of normalized floating-point numbers.
*/
#define FLT_MIN_10_EXP	-38
#define DBL_MIN_10_EXP	-38
#define LDBL_MIN_10_EXP	DBL_MIN_10_EXP	/* -309 if G format */

#define FLT_MAX_EXP	127
#define DBL_MAX_EXP	127
#define LDBL_MAX_EXP	DBL_MAX_EXP	/* +1023 if G format */

#define FLT_MAX_10_EXP	38
#define DBL_MAX_10_EXP	38
#define LDBL_MAX_10_EXP	DBL_MAX_10_EXP	/* +307 if G format */

/* Maximum representable finite floating-point number */
#define FLT_MAX		_fltmax		/* 1.70141183E+38F */
#define DBL_MAX		_dblmax		/* 1.701411834604692316E+38 */
#define LDBL_MAX	_ldbmax

/* Difference between 1.0 and the least value (normalized) greater than 1.0 */
#define FLT_EPSILON	_flteps		/* 1.4901161E-8F */
#define DBL_EPSILON	_dbleps		/* 4.336808689942017736E-19 */
#define LDBL_EPSILON	_ldbeps

/* Minimum normalized positive floating-point number */
#define FLT_MIN		_fltmin		/* 1.46936793E-39F */
#define DBL_MIN		_dblmin		/* 1.469367938527859384E-39 */
#define LDBL_MIN	_ldbmin

extern float _fltmax, _flteps, _fltmin;
extern double _dblmax, _dbleps, _dblmin;
extern long double _ldbmax, _ldbeps, _ldbmin;

#if CENV_DFL_S	/* Hacking KA-10 software format doubles?? */
#undef DBL_MANT_DIG
#undef DBL_DIG
#undef DBL_MIN_EXP
#undef DBL_MIN_10_EXP
#undef DBL_MAX_EXP
#undef DBL_MAX_10_EXP
#define DBL_MANT_DIG	(27+27)
#define DBL_DIG		16
#define DBL_MIN_EXP	-128	/* Not sure of this */
#define DBL_MIN_10_EXP	-38	/* Not sure of this */
#define DBL_MAX_EXP	127
#define DBL_MAX_10_EXP	38
#endif

#endif /* if CPU_PDP10 */
#endif /* ifndef _FLOAT_INCLUDED */
