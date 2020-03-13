/* Interface to _parse() */

#ifndef _C_PARSE_H_
#define _C_PARSE_H_

#include <c-env.h>
#include <stdarg.h>

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* cusys:parse.c */
#if SYS_T20+SYS_10X
extern int _parse P_((const char *path,int iflags,int (*rtn )(char *, int, va_list),...));
#endif 

#undef P_

/* flags bits passed to _parse() call */
#define _PARSE_IN_DIR	1<<0	/* Parse a directory specification */

/* The predicate routine 'rtn' takes the following arguments:
**	char *path	Parsed TOPS20 path
**	int pflags	Parse flags (see below)
**	va_list		Pointer to optional arguments passed to _parse()
*/

/* pflags bits passed to predicate routine */
#define _PARSE_OUT_TMP	1<<0	/* Parsed "/tmp" */
#define _PARSE_OUT_DIR	1<<1	/* Parsed directory */
#define _PARSE_OUT_NATIVE 1<<2	/* Native filespec, no parse required */
#endif
