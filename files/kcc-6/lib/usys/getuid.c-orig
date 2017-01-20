/*
**	GETUID, GETEUID - get user identity
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.3, 5-Jul-1987
**	(c) Copyright Ian Macky, SRI International 1987
*/

#include <c-env.h>

#if SYS_T20+SYS_10X		/* Systems supported for */

#if SYS_T20+SYS_10X
#include <jsys.h>
#endif

int getuid()
{
#if SYS_T20+SYS_10X
    int ablock[5];

    jsys(GJINF, ablock);			/* get job info */
    return ablock[1];				/* user# in AC1 */
#else
    return -1;
#endif
}

int geteuid()
{
    return getuid();
}

#endif /* T20+10X */
