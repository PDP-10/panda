/* <LIMITS.H> - C environment limit defs (new; Draft Proposed ANSI C)
**
**	(c) Copyright Ken Harrenstien 1989
**
**	This file is only meaningful for the KCC PDP-10 implementation of C.
**
**	Note: the suffix "U" is avoided so pre-ANSI versions of KCC can still
**	use this file.
*/

#ifndef _LIMITS_INCLUDED
#define _LIMITS_INCLUDED

/* Basic type sizes */
#define CHAR_BIT	9		/* Bits in a char	*/
/* fine SHRT_BIT	18		// (sizeof(short)*CHAR_BIT) */
/* fine INT_BIT		36		// (sizeof(int)  *CHAR_BIT) */
/* fine LONG_BIT	36		// (sizeof(long) *CHAR_BIT) */
#define MB_LEN_MAX	1		/* Max # bytes in a multibyte char */

/* "char" min/max values.  Note that because an (int) is capable of
** holding any of these values, and the integral promotions preserve value
** rather than signedness, it is not necessary to explicitly cast these
** to specific types -- (int) is the right thing.
*/
#define SCHAR_MIN	(-0400)		/* (-1 << (CHAR_BIT-1)) */
#define SCHAR_MAX	0377		/* (~SCHAR_MIN)	*/
#define UCHAR_MAX	0777		/* (1<<CHAR_BIT - 1) */
#define CHAR_MIN	0		/* (char) == (unsigned char) */
#define CHAR_MAX	UCHAR_MAX	/* (char) == (unsigned char) */

/* "short int" min/max values.  Same situation as for chars. */ 
#define SHRT_MIN	(-0400000)	/* (-1 << (SHRT_BIT-1)) */
#define SHRT_MAX	0377777		/* (~SHRT_MIN)		*/
#define USHRT_MAX	0777777		/* (1<<SHRT_BIT - 1)	*/

/* "int" min/max values.  Have to be more careful about avoiding overflow
** and specifying right type (signed or unsigned).
*/
#define INT_MIN		((int)(1<<35))	/* Note (1<<35) alone wd be unsigned */
#define INT_MAX		0377777777777	/* (~INT_MIN) */
#define UINT_MAX	(~(unsigned)0)	/* Whole word.  Force unsigned. */

/* "long" min/max values.  Same as (int) but must ensure proper type. */
#define LONG_MIN	((long)(1<<35))	/* ((long)INT_MIN) */
#define LONG_MAX	0377777777777L	/* ((long)INT_MAX) */
#define ULONG_MAX	(~(unsigned long)0) /* ((unsigned long)(UINT_MAX)) */

#include <sys/param.h>

#endif /* ifndef _LIMITS_INCLUDED */
