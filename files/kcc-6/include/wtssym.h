/* <WTSSYM.H> - Provide access to WAITS monitor call symbols
**
**	(c) Copyright Ken Harrenstien 1989
**
** To get the 36-bit integer value of a monitor call symbol, say (e.g.)
**		wtssym(".FOOUT")
** The argument must be a string literal and may be upper or lower case.
** The resulting value has type (int) and is a compile-time constant which
** can also be used in #if tests.  A compiler error will occur if the
** symbol is not found.
**
** To merely test whether a symbol is defined, use
**		wtssymdefined(".FOOUT")
** which will have the value 1 if the symbol is defined, 0 otherwise.
**
*/

#ifndef _WTSSYM_INCLUDED
#define _WTSSYM_INCLUDED

#define wtssym(s)	 _KCCsymval("UNV:WTSSYM.UNV",s)
#define wtssymdefined(s) _KCCsymfnd("UNV:WTSSYM.UNV",s)

/* Note the use of the special KCC built-in functions.
** Make sure the file location is correct for your system.
*/
#endif /* ifndef _WTSSYM_INCLUDED */
