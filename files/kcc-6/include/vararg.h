/* <VARARG.H> and <VARARGS.H> - BSD version of <stdarg.h> (OBSOLETE!)
**
** First version by David Eppstein / Stanford University / 24-Aug-85
** Further edits (c) Copyright Ken Harrenstien 1989
**
** NOTE: the two files vararg.h and varargs.h are identical copies.
** To avoid problems with filename lengths longer than 6 chars,
** neither includes the other; they are simply identical, so it is OK if
** something asks for <varargs.h> and gets <vararg.h> instead.
**
** This file is obsolete; use <stdarg.h> instead.  CARM explains how
** to use it, if compatibility with old BSD is required.
*/

#define va_dcl int va_alist;		/* declare args for fn */
typedef int *va_list;			/* use int pointers for lists */
#define va_start(pvar) (pvar = 1+&va_alist) /* point past first arg */
#define va_arg(pvar,type) (*(type *)(pvar-=(sizeof(type)+sizeof(int)-1) \
					    / sizeof(int))) /* get arg */
#define va_end(pvar)			/* finished with arglist */
