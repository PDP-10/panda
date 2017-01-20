/* <MONSYM.H> - Provide access to TOPS-20 monitor symbols
**
**	(c) Copyright Ken Harrenstien 1989
**	(c) Copyright Ken Harrenstien, SRI International 1988
**
** To get the 36-bit integer value of a monitor symbol, say (e.g.)
**		monsym(".FHSLF")
** The argument must be a string literal and may be upper or lower case.
** The resulting value has type (int) and is a compile-time constant which
** can also be used in #if tests.  A compiler error will occur if the
** symbol is not found.
**
** To merely test whether a symbol is defined, use
**		monsymdefined(".FHSLF")
** which will have the value 1 if the symbol is defined, 0 otherwise.
**
** Do not use monsym() to obtain JSYS numbers; use <jsys.h> for that.
*/

#ifndef _MONSYM_INCLUDED
#define _MONSYM_INCLUDED

#define monsym(s)	 _KCCsymval("UNV:MONSYM.UNV",s)
#define monsymdefined(s) _KCCsymfnd("UNV:MONSYM.UNV",s)

/* Note the use of the special KCC built-in functions.
** Make sure the file location is correct for your system.
*/
#endif /* ifndef _MONSYM_INCLUDED */
