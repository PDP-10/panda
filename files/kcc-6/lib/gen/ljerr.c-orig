/* LONGJMPERROR - Give error message for longjmp problems.
**
**	Copyright (c) 1987 by Ken Harrenstien, SRI International.
**
**	This is called by longjmp() whenever it detects that the jmp_buf
** contents have been trashed or it is about to make the stack bigger
** rather than smaller (implication is that the caller of setjmp() has
** already returned).
**	It is a separate routine in the library so that users can
** substitute their own function if desired.
*/

#include <setjmp.h>

#ifndef LONGJMPERRMSG
#define LONGJMPERRMSG "longjmp botch"
#endif

void
longjmperror()
{
    extern int write();		/* Syscall */

    write(2, LONGJMPERRMSG, sizeof(LONGJMPERRMSG)-1);
}
