/* <STDDEF.H> - Common C definitions  (draft proposed ANSI C)
**
**	(c) Copyright Ken Harrenstien 1989
**
**	Specific to the KCC PDP-10 implementation!
*/

#ifndef _STDDEF_INCLUDED
#define _STDDEF_INCLUDED

typedef int ptrdiff_t;		/* Type of pointer difference expression */

#ifndef _WCHAR_T_DEFINED	/* Avoid conflict with other headers */
#define _WCHAR_T_DEFINED
typedef char wchar_t;		/* Type of "wide" chars */
#endif

#ifndef _SIZE_T_DEFINED		/* Avoid conflict with other headers */
#define _SIZE_T_DEFINED
typedef unsigned size_t;	/* Type of sizeof() (must be unsigned, ugh) */
#endif

#define NULL 0			/* Null pointer constant */

#define offsetof(t,m) _KCC_offsetof(t,m)	/* Must use KCC builtin */

#endif /* ifndef _STDDEF_INCLUDED */
