/* PAUSE - stop until signal.
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.3, 30-Aug-1987
**	(c) Copyright Ken Harrenstien, SRI International 1987
*/

#include <c-env.h>

#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported for */

#include <sys/usysig.h>
#include <errno.h>	/* For EINTR */

#if SYS_T20+SYS_10X
#include <jsys.h>
#endif

#if SYS_WTS
#include <muuo.h>
#endif

int
pause()
{
#if SYS_T20+SYS_10X
    int acs[5];
    jsys(WAIT|JSYS_OKINT, acs);

#elif SYS_WTS
    WTSUUO("IWAIT");

#elif SYS_T10+SYS_CSI
    asm("	SETZ 1,\n	HIBER 1,\n");

#elif SYS_ITS
    asm("	SKIPA\n JFCL\n .HANG\n");
#endif

    errno = EINTR;
    return -1;
}

#endif /* T20+10X+T10+CSI+WAITS+ITS */
