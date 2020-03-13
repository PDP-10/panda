/* <UUOSYM.H> - Provide access to TOPS-10 monitor call symbols
**
**	(c) Copyright Ken Harrenstien 1989
**
** To get the 36-bit integer value of a monitor call symbol, say (e.g.)
**		uuosym(".FOOUT")
** The argument must be a string literal and may be upper or lower case.
** The resulting value has type (int) and is a compile-time constant which
** can also be used in #if tests.  A compiler error will occur if the
** symbol is not found.
**
** To merely test whether a symbol is defined, use
**		uuosymdefined(".FOOUT")
** which will have the value 1 if the symbol is defined, 0 otherwise.
**
*/

#ifndef _UUOSYM_INCLUDED
#define _UUOSYM_INCLUDED

#define uuosym(s)	 _KCCsymval("UNV:UUOSYM.UNV",s)
#define uuosymdefined(s) _KCCsymfnd("UNV:UUOSYM.UNV",s)

/* Note the use of the special KCC built-in functions.
** Make sure the file location is correct for your system.
*/
#endif /* ifndef _UUOSYM_INCLUDED */
