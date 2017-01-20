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
#include <time.h>		/* For new ANSI clock stuff */
#include <sys/times.h>		/* For struct tms definition */
/* #include <sys/usydat.h> */	/* Not used - not vulnerable to interrupts */
#if SYS_T20
#include <jsys.h>
#endif

clock_t
times(tp)
struct tms *tp;
{
    int acs[5];

    tp->tms_utime =		/* Get user runtime from clock() */
#if CLOCKS_PER_SEC == CLK_TCK
		clock();
#else					/* Convert clock ticks to CLK_TCK */
		(double)(clock()*CLK_TCK) / CLOCKS_PER_SEC;
#endif
    tp->tms_stime = (tp->tms_utime + 010) >> 4;	/* Can't get this, */
						/* assume fixed overhead */
    tp->tms_cutime = tp->tms_cstime = 0;	/* Ignore any children */

#if SYS_T20
    jsys(TIME,acs);		/* Get system time */
#if CLOCKS_PER_SEC == CLK_TCK
    return (acs[1]);
#else					/* Convert clock ticks to CLK_TCK */
    return ((((double)acs[1])*CLK_TCK) / CLOCKS_PER_SEC);
#endif
#else
    return 0;
#endif
}

#endif /* T20+10X+T10+CSI+WAITS+ITS */
