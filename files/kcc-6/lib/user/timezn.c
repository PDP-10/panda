/* TIME_LZONE		return local timezone info.
** TIME_TZSET		reset local timezone info.
**
** 	Copyright (c) 1980, 1987 by Ken Harrenstien, SRI International.
**
**	This code is quasi-public; it may be used freely in like software.
**	It is not to be sold, nor used in licensed software without
**	permission of the author.
**	For everyone's benefit, please report bugs and improvements!
**	(Internet: <KLH@SRI-NIC.ARPA>)
*/

#include <c-env.h>	/* For system-dependent switches */
#include <timex.h>

#ifndef SYS_V6
#define SYS_V6 0
#endif
#ifndef SYS_SYSV
#define SYS_SYSV 0
#endif

#if !(SYS_V6||SYS_SYSV)	/* V7 and BSD */
#include <sys/types.h>
#include <sys/timeb.h>
#endif

/* TIME_LZONE - return local timezone structure.
**	First time, asks system for timezone, then stores it so future
** calls can avoid overhead of system call.
**	The system call used is V7 ftime() rather than BSD gettimeofday()
** because the former is more likely to be widely supported, in case this
** code is used elsewhere.  There is however a subtle assumption that ftime()
** will return 1 for "dstflag" if a USA type DST algorithm is to be used.
*/

int
time_lzone(zp)
register struct tmz *zp;
{
    static struct tmz *tlzknown = 0;	/* Set when tmz structure known */

    if (!tlzknown && !(tlzknown = time_tzset()))
	return 0;
    if (zp) *zp = *tlzknown;
    return 1;
}

struct tmz *
time_tzset()
{
    static struct tmz tlz;

#if SYS_V6
    extern int timezone;

    tlz.tmz_minwest = timezone;
    tlz.tmz_secwest = timezone * 60L;
    tlz.tmz_dsttype = 1;		/* Assume USA */
#else
#if SYS_SYSV
    extern long timezone;	/* timezone in secs */
    extern int daylight;
    extern char *tzname[2];
    extern void tzset();

    tzset();				/* Supposedly never fails */
    tlz.tmz_secwest = timezone;		/* Get zone in secs */
    tlz.tmz_minwest = timezone/60;	/* Get zone in mins */
    tlz.tmz_dsttype = daylight;		/* Get type of DST to apply */
    tlz.tmz_name = tzname[0];
    tlz.tmz_dname = tzname[1];

#else	/* Vanilla V7 and BSD */
#if 0
    extern void ftime();
#endif
    extern char *timezone();
    extern char *strncpy();
    struct timeb tmb;
    static char znam[20], znam2[20];

    ftime(&tmb);			/* Supposedly this call never fails. */
    tlz.tmz_minwest = tmb.timezone;	/* Get zone in mins */
    tlz.tmz_secwest = tmb.timezone * 60L;	/* and in secs */
    tlz.tmz_dsttype = tmb.dstflag;		/* Get type of DST to apply */
    strncpy(znam, timezone(tmb.timezone, 0), 20);
    strncpy(znam2,timezone(tmb.timezone, 1), 20);
    tlz.tmz_name = znam;
    tlz.tmz_dname = znam2;
#endif /* V7 || BSD */
#endif /* SYS_SYSV */

    return &tlz;
}
