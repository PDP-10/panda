/*
**	ABORT	- Abort process as illegally as possible
**
**	(c) Copyright Ken Harrenstien 1989
**
*/
#include <signal.h>	/* For raise() */

void
abort()
{
    raise(SIGABRT);	/* First attempt to trigger signal */
    for(;;)
	asm("\t0\n");	/* 0 is a good illegal instruction on PDP-10s */
	/* We loop just in case int handler checks the address for presence
	** of an ERJMP instruction.
	*/
}
