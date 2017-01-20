/*
**	FLOAT.C - Floating-point data for <float.h> (new for ANSI C)
**
**	(c) Copyright Ken Harrenstien 1989
**
** Because the values defined in <float.h> are impossible to express as
** lexical constants, a data file is necessary.  Note that because
** union initialization cannot be done by pre-ANSI KCC, we have to use
** "type punning" across module boundaries -- <float.h> thinks these
** externals are defined with the proper data types.  Ha.
*/

#include <c-env.h>		/* Get site-dependent info */
#include <limits.h>

#if CPU_PDP10

/* All values must be normalized! */

/* PDP-10 float format is identical on all machines */
#define FLT_MAX		INT_MAX
#define FLT_EPSILON	((129-26)<<27) + (1<<26)
#define FLT_MIN		(1<<26)

#if CENV_DFL_H	/* PDP-10 Hardware format doubles */
#define DBL_MAX		INT_MAX,	INT_MAX
#define DBL_EPSILON	((129-(26+35))<<27) + (1<<26),	0
#define DBL_MIN		(1<<26),	0
#elif CENV_DFL_S	/* Software format doubles (KA-10) */
#define DBL_MAX		INT_MAX, (INT_MAX - (27<<27))
#define DBL_EPSILON	((129-(26+27))<<27) + (1<<26), (129-(26+27+27))<<27
#define DBL_MIN		(27<<27)+(1<<26), 0	/* Not sure about this */
#endif

#define LDBL_MAX	DBL_MAX
#define LDBL_EPSILON	DBL_EPSILON
#define LDBL_MIN	DBL_MIN

/* Maximum values */
int _fltmax =	{ FLT_MAX };
int _dblmax[2] = { DBL_MAX };
int _ldbmax[2] = { LDBL_MAX };

/* Epsilon values */
int _flteps =	{ FLT_EPSILON };
int _dbleps[2] = { DBL_EPSILON };
int _ldbeps[2] = { LDBL_EPSILON };

/* Minimum positive values */
int _fltmin = 	{ FLT_MIN };
int _dblmin[2] = { DBL_MIN };
int _ldbmin[2] = { LDBL_MIN };

#endif /* CPU_PDP10 */
