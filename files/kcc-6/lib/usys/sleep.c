/*
**	SLEEP - sleep for N seconds
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.15, 30-Aug-1987
**	(c) Copyright Ken Harrenstien, SRI International 1987
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_ITS+SYS_T10+SYS_CSI+SYS_WTS

#include <sys/usydat.h>
#if SYS_T20+SYS_10X
#include <jsys.h>
#endif

/* msleep(msecs) - Sleep for N milli-seconds
** unsigned msecs;
*/
static void
msleep(n)
int n;
{
#if SYS_T20+SYS_10X
    int acs[5];
    acs[1] = n;				/* Set time in milliseconds */
    jsys(DISMS|JSYS_OKINT, acs);	/* Sleep, return if signal */

#elif SYS_WTS+SYS_T10+SYS_CSI
    asm("	MOVE 1,-1(17)\n");	/* Get argument into AC 1 */
    asm("	CALLI 1,31\n");		/* SLEEP UUO (avoid label conflict) */

#elif SYS_ITS
    asm("	MOVE 1,-1(17)\n");	/* Get argument into AC 1 */
    asm("	IMULI 1,036\n");	/* Multiply by 30 to get 30ths */
    asm("	.SLEEP 1,\n");

#else
    return;
#endif
}

/* sleep(secs) - Sleep for N seconds
** unsigned secs
*/
void sleep(n)
{
  msleep((n * 1000) + 1);	/* Convert to milliseconds, force round-up */
}

/* usleep(usecs) - Sleep for N micro-seconds
** unsigned secs
*/
void usleep(n)
{
  msleep((n + 499) / 1000);	/* Convert to milliseconds, force round-up */
}

#endif /* T20+10X+T10+CSI+WAITS+ITS */
