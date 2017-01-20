/* <STDARG.H> - Variable argument facility (draft proposed ANSI C)
**
**	(c) Copyright Ken Harrenstien 1989
**
** These macros are only valid for the KCC PDP-10 C compiler.
*/

#ifndef _STDARG_INCLUDED
#define _STDARG_INCLUDED

typedef int *va_list;		/* Type for holding pointer to arg list */

#define va_start(ap, pn) (ap = (va_list)&(pn))	/* Init va_list from parmN */
#define va_end(ap)				/* Clean up list when done */

#define va_arg(ap, type) \
    (sizeof(type) >= sizeof(int) \
	? *(type *)(ap -= sizeof(type)/sizeof(int)) \
	: (type)(*--(ap)) \
    )

/* The va_arg macro is somewhat hairy because we want to use a word (int)
** pointer to the args and still be able to obtain objects smaller
** than a word, e.g. char or short.
**
** The first line tests whether the object is word-sized or larger.
** If yes, the second line adjusts the pointer, casts it, and gets the
**	value.
** Otherwise, the third line adjusts the pointer by 1 word and casts the
**	integer word value to the type of the smaller-sized object.
*/

#endif /* ifndef _STDARG_INCLUDED */
