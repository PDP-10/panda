/* "PML.H" - Internal Portable Math Library definitions
**
**	(c) Copyright Ken Harrenstien 1989
**	Adapted from PML.H by Fred Fish.
*/

#ifndef _PML_INCLUDED
#define _PML_INCLUDED

#ifndef __STDC__	/* Canonicalize this indicator to avoid err msgs */
#define __STDC__ 0
#endif

#include <c-env.h>	/* For CPU_PDP10 */

/* Define some common mathematical constants for internal library use. */

#define TWOPI		6.2831853071795864769
#define PI		3.1415926535897932384
#define HALFPI		1.5707963267948966192
#define FOURTHPI	0.7853981633974483096
#define SIXTHPI		0.523598776
#define LOG2E		1.4426950408889634073
#define LOG10E		0.4342944819032518276
#define SQRT2		1.4142135623730950488
#define SQRT3		1.7320508075688772935
#define LN2		0.6931471805599453094
#define LNSQRT2		0.3465735902799726547

/* Hardware-dependent constants */

#if CPU_PDP10	/* PDP-10 Hardware dependencies */

extern struct pmlcon {
    double
	recip_min,		/* DBL_MAX >= 1/RECIP_MIN	*/
	recip_max,		/* DBL_MIN <= 1/RECIP_MAX	*/
	ln_maxposdbl,		/* LN(DBL_MAX)		*/
	ln_minposdbl,		/* LN(DBL_MIN)		*/
	tanh_maxarg,		/* |TANH(maxarg)| = 1.0		*/
	x6_underflows,		/* X**6 almost underflows	*/
	x16_underflows;		/* X**16 almost underflows	*/
} _pmlcon;

#define RECIP_MIN	_pmlcon.recip_min	/* pow */
#define RECIP_MAX	_pmlcon.recip_max	/* atan */
#define LN_MAXPOSDBL	_pmlcon.ln_maxposdbl	/* cosh, exp, sinh */
#define LN_MINPOSDBL	_pmlcon.ln_minposdbl	/* cosh, exp, sinh */
#define TANH_MAXARG	_pmlcon.tanh_maxarg	/* tanh */
#define X6_UNDERFLOWS	_pmlcon.x6_underflows	/* cos, sin */
#define X16_UNDERFLOWS	_pmlcon.x16_underflows	/* atan */

#if 0		/* Old versions of hardware-dependent constants */
#define RECIP_MIN 5.877471e-39		/* DBL_MAX >= 1/RECIP_MIN	*/
#define RECIP_MAX 1.7014118e38		/* DBL_MIN <= 1/RECIP_MAX	*/
#define LN_MAXPOSDBL 88.0		/* LN(DBL_MAX)		*/
#define LN_MINPOSDBL -89.4		/* LN(DBL_MIN)		*/
#define TANH_MAXARG 16			/* |TANH(maxarg)| = 1.0		*/
#define X6_UNDERFLOWS 3.37174e-7	/* X**6 almost underflows	*/
#define X16_UNDERFLOWS 3.74063e-3	/* X**16 almost underflows	*/
#endif

#elif CPU_PDP11		/* PDP-11 hardware dependencies, just for reference */
#define RECIP_MIN 5.877471e-39		/* DBL_MAX >= 1/RECIP_MIN	*/
#define RECIP_MAX 1.7014118e38		/* DBL_MIN <= 1/RECIP_MAX	*/
#define LN_MAXPOSDBL 88.0		/* LN(DBL_MAX)		*/
#define LN_MINPOSDBL -89.4		/* LN(DBL_MIN)		*/
#define DTANH_MAXARG 16			/* |DTANH(maxarg)| = 1.0	*/
#define X6_UNDERFLOWS 3.37174e-7	/* X**6 almost underflows	*/
#define X16_UNDERFLOWS 3.74063e-3	/* X**16 almost underflows	*/
#endif /* CPU_PDP11 */

/* Internal routines not available to user. */

#if __STDC__
extern double
	_sign(double, double),
	_poly(int, double*, double),
	_poly4(double*, double);

#else	/* Old-style non-ANSI compilation */

extern double _sign(), _poly(), _poly4();

#endif	/* if !__STDC__ */

#endif /* ifndef _PML_INCLUDED */
