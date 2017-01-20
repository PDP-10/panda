/*
**	CLOCK	- get process CPU run time
**
**	(c) Copyright Ken Harrenstien 1989
**
**	As described in [H&S v2 sec 20.1]
** All of these PDP-10 implementations return time in milliseconds
** (that is, CLK_TCK is 1000)
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported for */

#include <time.h>

clock_t
clock()
{
#if SYS_T20
	asm("SEARCH MONSYM\n");
	asm("	MOVEI 1,.FHSLF\n");	/* For this process, */
	asm("	RUNTM%\n");		/* get runtime in AC 1 */

#elif SYS_10X
	asm("SEARCH MONSYM\n");
	asm("	JOBTM\n");		/* Puts result in AC 1 */

#elif SYS_WTS+SYS_T10+SYS_CSI
	asm("	SETZ	1,\n");		/* For our job, */
	asm("	RUNTIM	1,\n");		/* get runtime in return AC */

#elif SYS_ITS
	asm("	.SUSET [.RRUNT,,1]\n");	/* Get runtime in 4.096 usec units */
	asm("	MULI 1,07745\n");	/* mult by 4096 to convert to nsec, */
	asm("	DIV 1,[03641100]\n");	/* div by 1^6 to get msecs. */
#else
    return 0;
#endif
}
#endif /* T20+10X+T10+CSI+WAITS+ITS */
