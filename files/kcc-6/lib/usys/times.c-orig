/*
**	TIMES - simulation of V7/BSD system call.
**
**	(c) Copyright Ken Harrenstien 1989
**
**	Fills in a structure with process runtimes for self and children.
**
** This is a pretty poor simulation, but it's unlikely anything will care.
*/
#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported for */

#include <sys/types.h>
#include <sys/times.h>		/* For struct tms definition */
#include <time.h>		/* For new ANSI clock stuff */
/* #include <sys/usysig.h> */	/* Not used - not vulnerable to interrupts */

void
times(tp)
struct tms *tp;
{
    tp->tms_utime =		/* Get user runtime from clock() */
#if CLOCKS_PER_SEC == HZ
		clock();
#else					/* Convert clock ticks to HZ */
		(double)(clock()*HZ) / CLOCKS_PER_SEC;
#endif
    tp->tms_stime = 0;				/* Can't get this */
    tp->tms_cutime = tp->tms_cstime = 0;	/* Ignore any children */
}

#endif /* T20+10X+T10+CSI+WAITS+ITS */
