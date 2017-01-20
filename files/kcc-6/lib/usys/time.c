/*
**	TIME	- Date and time system calls
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.75, 11-Sep-1987
**	(c) Copyright Ken Harrenstien, SRI International 1987
**
*/
/*
** TIME		- Get date/time value, of type "time_t", as per ANSI spec.
** GETTIMEOFDAY - Get date and time.  Simulation of 4.2BSD system call.
** FTIME	- obsolete form of above system call.
**
** Also the following non-standard functions:
**   tadl_t		Type to hold local TAD value
**   tadl_get()		Gets current date/time in local format.
**   tadl_to_utime()	Converts local TAD into Un*x time_t.
**   tadl_from_utime()	Converts Un*x time_t into local format.
** These are currently defined by <sys/time.h> with initial underscores.
**
** Note that none of these calls use the USYS_ macros;
** nothing they do is vulnerable to interrupts, and they do not set errno.
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported for */

#include <time.h>		/* For time_t and struct tm definition */
#include <sys/usydat.h>		/* System data references */
#include <sys/sitdep.h>		/* For local timezone/DST default values */
#include <sys/time.h>		/* For timeval and timezone structures */
#include <sys/timeb.h>		/* For timeb structure */

#if SYS_T20+SYS_10X
#include <jsys.h>		/* For IDCNV */
#include <sys/t20tim.h>		/* For _t20_tm structure for IDCNV */
#endif

#if SYS_T10+SYS_CSI+SYS_WTS
#include <muuo.h>
#include <macsym.h>
#endif

#define HBITS 18		/* # bits in a PDP-10 halfword */
#ifndef RH
#define RH ((1<<HBITS)-1)
#endif

#define DAYSECS (24*60*60)	/* # seconds in a day */
#define HRSECS	(60*60)		/* # seconds in an hour */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

#if SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS
static tadl_t _lmktime P_((struct tm *tm,int tim));
#endif 
static void _ltzget P_((void));

#undef P_

time_t
time(tloc)
time_t *tloc;
{
    struct timeval tv;
    struct timezone tz;

    if (gettimeofday(&tv, &tz))		/* Get date/time and timezone */
	return -1;			/* Failed */
    if (tloc) *tloc = tv.tv_sec;	/* Return the date/time */
    return tv.tv_sec;
}

int
ftime(tp)
struct timeb *tp;
{
    struct timeval tv;
    struct timezone tz;

    if (gettimeofday(&tv, &tz))
	return -1;			/* Non-zero return means failed */
    tp->time = tv.tv_sec;
    tp->millitm = tv.tv_usec / 1000;	/* Sigh */
    tp->timezone = tz.tz_minuteswest;
    tp->dstflag = tz.tz_dsttime;
    return 0;				/* Won */
}

/* Default values for local timezone and DST type */
static int
	_ltzmins = _SITE_TIMEZONE,	/* Local timezone in minutes */
	_ltzsecs = _SITE_TIMEZONE * 60,	/* Local timezone in seconds */
	_ltdstt = _SITE_DSTTIME;	/* Local DST type (a _DST_xxx value) */
#if SYS_T10
static int _ltzoff, _ltzgotoff = 0;	/* TOPS-10 GETTAB info */
#endif

#ifdef SYS_T20
/* Base values for time computation */
static unsigned int
  base_sec = 0,			/* Seconds */
  base_hptim = 0;		/* High precision time (10 uSec units) */

int
gettimeofday(tp,tzp)
struct timeval *tp;
struct timezone *tzp;
{
    unsigned int curr_sec, curr_hptim, chk_sec, diff_hptim, diff_sec;
    int acs[5], drift;

    if (!USYS_VAR_REF(ltzknown))	/* If timezone not known yet, */
	_ltzget();			/* get the info and set up stuff! */

    /* Get a stable time sample */
    do {
      acs[1] = monsym(".HPELP");
      curr_sec = tadl_get();
      if (!jsys(HPTIM, acs)) {
	acs[1] = 0;			/* No HPTIM, clear hptim */
	base_sec = 0;			/* and bypass computation */
	break;
      }
      chk_sec = tadl_get();
    } while (curr_sec != chk_sec);
    curr_hptim = acs[1];		/* Get HPTIM result */
    curr_sec = tadl_to_utime(curr_sec);	/* Compute seconds from TAD */

    if (base_sec) {			/* Do we have base times? */
      diff_sec = curr_sec - base_sec;	/* Compute difference in seconds */
      diff_hptim = curr_hptim - base_hptim; /* Compute difference in hptim */
      drift = diff_sec - (diff_hptim / 100000);
					/* Compute drift between clocks */
      if ((diff_sec < (86400 * 5))	/* If < 5 days since last call, */
	  && ((drift == 0) || (drift == 1))) { /* and no significant drift */
	base_sec += (diff_hptim / 100000); /* Adjust base seconds */
	base_hptim += ((diff_hptim / 100000) * 100000);	/* and hptim */
	diff_hptim %= 100000;		/* Get only remainder */
	tp->tv_sec = base_sec;		/* Get current time */
	tp->tv_usec = diff_hptim * 10;	/* Compute uSecs from hptim */
      }
      else base_sec = 0;		/* Else, force reset */
    }
    if (!base_sec) {			/* If no current base, */
      base_sec = curr_sec;		/* Set base */
      base_hptim = curr_hptim;		/* time values */
      tp->tv_sec = curr_sec;		/* Get current time */
      tp->tv_usec = 0;			/* And start with 0 uSecs */
    }

    tzp->tz_minuteswest = _ltzmins;	/* Get signed TZ in min */
    tzp->tz_dsttime = _ltdstt;		/* and DST correction type */
    return 0;				/* Return success */
}
#else
int
gettimeofday(tp,tzp)
struct timeval *tp;
struct timezone *tzp;
{
    if (!USYS_VAR_REF(ltzknown))	/* If timezone not known yet, */
	_ltzget();			/* get the info and set up stuff! */
    tp->tv_sec = tadl_to_utime(tadl_get());	/* Get current time */
    tp->tv_usec = 0;			/* Can't believe usec granularity */
    tzp->tz_minuteswest = _ltzmins;	/* Get signed TZ in min */
    tzp->tz_dsttime = _ltdstt;		/* and DST correction type */
    return 0;				/* Return success */
}
#endif

#if 0		/* Documentation on system-specific time representations */
/* UNX: UN*X 32-bit time word format:
**	<# of seconds since epoch>
**		where the epoch is 1-Jan-1970 00:00-GMT
**		This is good up until about 2037 when the sign bit gets hit,
**		and until 2105 if handled properly as unsigned value.
** Relevant system calls:
**	time()		V6 upwards
**	ftime()		V7 upwards
**	gettimeofday()	4.2BSD upwards
*/

/* SAF: TOPS-20 (and recent TOPS-10) time word format:
**	<# days since epoch>,,<fraction of day>
**		where the epoch is 17-Nov-1858 00:00-GMT
**		(Smithsonian Astronomical date standard, also Modified Julian)
**		This is good up until about 2216 when the sign bit gets hit.
**	RH is fraction of one day (1,,0 = 1 day), thus:
**		262144/86400 = 3.0340740 units per second
**		86400/262144 = .32958984 seconds per unit
** Relevant monitor calls:
**	GTAD%
**	IDTIM%, IDTNC%, IDCNV%
**	ODTIM%, ODTNC%, ODCNV%
*/

/* SAS: TENEX time word format:
**	<# days since epoch>,,<# seconds in day>
**		where the epoch is 17-Nov-1858 00:00-GMT
**		This is good up until about 2216 when the sign bit gets hit.
** Relevant monitor calls are same as for TOPS-20.
*/

/* 64S: WAITS (and old TOPS-10) time word format:
**	Old TOPS-10 systems had no single-word value combining the date
** and time, so WAITS invented the following format:
**		<date in T10 fmt>,,<# secs in day>
**
** The date format consists of the value:
**	< <year-1964>*12 + <month-1> >*31 + <day-1>
**		Note that only 15 bits are allocated in the system for this
**		value, limiting its range to about 88 years (until 2052).
** Relevant monitor calls:
**	DATE, MSTIME	(TOPS-10 and WAITS)
**	ACCTIM, DAYCNT	(WAITS only)
*/

/* ITS: ITS time word format:
** Mask    Field     Bits	Range	Var.    Variable range
** TM%SEC== 777776   2.9-1.2	0-131K	seconds	0-86399.
**		   ; 6 		0-63	secs	0-59
**		   ; 6		0-63	mins	0-59
**		   ; 5		0-31	hrs	0-23
** TM%DAY==   37,,0  3.5-3.1	0-31	days	1-31
** TM%MON==  740,,0  3.9-3.6	0-15	months	1-12
** TM%YR==177000,,0  4.7-4.1	0-127	years	0-127 rel to 1900 (1900-2027)
**		This is good up until 2156 with another bit added to year.
**
** Relevant system calls:
*/
	Documentation for ITS time stuff
----------------------------
.RYEAR ac,                              read year

        Returns in accumulator <ac> a word as follows:

        4.9     This year has 365. days, and it is after February 28.
        4.8     This year is a leap year (366. days).
        4.7     Daylight savings time is in effect.
        4.6     The time of year is known.
        4.2-3.9 If bit 4.6 set, the current day of the week.
                Sunday=0, Monday=1, etc.
        3.8-3.6 The day of the week of January 1 of this year.
        3.5-3.1 Zero.
        2.9-1.1 The year, not modulo 100., but as a full quantity,
                e.g. 1969. or 1975.

        If the system does not know the time, zero is returned.
----------------------
.RLPDTM ac,                             .PDTIME and .RYEAR

        This returns the time and date in ac and ac+1, in
        a binary form.  ac+1 contains the result of .RYEAR;
        see the description of that uuo for details.  ac
        contains the "localized" number of seconds since the
        beginning of the year.  If this is divided by the
        number of seconds in a day  (86400.), the remainder
        will be the number of seconds since midnight local
        time, and the quotient will be the number of days
        since the beginning of the year, with the (mis)feature
        that all years are considered to include February 29.
        This is done so that date-printing routines do not
        have to check for leap-year, but it does mean that
        during the last 10 months of non-leap years the day
        number is 1 greater than the correct Julian day.
        Bit 4.9 of ac+1 is set in this case.

        Note that .RLPDTM should be used instead of .PDTIME
        followed by .RYEAR, since it guarantees consistency
        of the two values returned.
----------------------
RQDATE: read disk format date

        val 1   Current date and time in disk format:
                4.7-4.1 Year (mod 100.).
                3.9-3.6 Month (January = 1).
                3.5-3.1 Day of month.
                2.9-1.1 Time in half-seconds after midnight.
                If date and time are unknown, -1 is returned.
        val 2   Date and time the system came up in disk format.
                If date and time are unknown, -1 is returned.
----------------------
#endif

/* Local-to-Un*x and Un*x-to-Local date/time val conversions.
*/

#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI
#define EPOCH_SADIFF (40587)		/* Days diff from UN*X epoch */
#define datetosecs(d) (((d) - EPOCH_SADIFF) * DAYSECS)
#define fractosecs(f) ((unsigned)((f)*DAYSECS+(1<<(HBITS-1)))>>HBITS)
#endif

#if SYS_T10+SYS_CSI+SYS_WTS
#define EPOCH_64DIFF (2192)	/* Days diff from UN*X epoch */
	/* There are (6 yrs * 365) + (2 leap days) = 2192 days
	** separating this epoch from the UN*X one of 1-Jan-1970.
	*/
#endif

#if SYS_ITS
struct _its_tm {
	unsigned	 : 2;	/* 4.9-4.8 unused */
	unsigned dt_year : 7;	/* 4.7-4.1 Year (1900 based) */
	unsigned dt_mon  : 4;	/* 3.9-3.6 Month (1 = January) */
	unsigned dt_day  : 5;	/* 3.5-3.1 Day of month (1-31.) */
	unsigned dt_tim2 : 18;	/* 2.9-1.2 Time in half-secs after midnight */
};
#endif

#if SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS
/* _TMONTB - Table of days thus far in year, assuming non-leap year.
** Indexed by month, with 0 = January.
*/
static int _tmontb[] = {
	0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
};
static tadl_t _lmktime();	/* Internal variant of mktime() */

/* Declare functions needed from CTIME.C */
extern struct tm *_lbrktime();	/* Internal version of localtime() */
extern int _tmisdst();		/* See if DST applies to a broken-down time */
#endif

#if SYS_CSI
struct tzone {
	int tz_fnc;	/* Function code */
	int tz_utc;	/* UTC in MJD.f fmt */
	int tz_lcl;	/* "local" MJD.f */
	int tz_nam;	/* Zone name */
	int tz_blk[3];	/* Timezone block */
};
#endif /* CSI */


/* TADL_GET - Get Local Time-And-Date value
*/
tadl_t
tadl_get()
{
#if SYS_T20+SYS_10X
    int acs[5];
    jsys(GTAD, acs);
    return acs[1];		/* Return GTAD% result from AC1 */

#elif SYS_ITS			/* Gets disk format date in return AC */
    asm("\t.CALL [SETZ\n\t\tSIXBIT/RQDATE/\n\t\tSETZM 1]\n");
    asm("\t SETO 1,\n");

#elif SYS_WTS
    int ret;
    WTSUUO_VAL("ACCTIM", &ret);	/* Returns <64date>,,<secs> */
    return ret;

#elif SYS_T10
    int date, tim1, tim;

    if (!USYS_VAR_REF(ltzknown))
	_ltzget();
    if (_ltzgotoff)
	return MUUO_ACVAL("GETTAB",
		XWD(uuosym("%CNDTM"),uuosym(".GTCNF")), &date) > 0
			? date+_ltzoff : -1;	/* TAD if won, -1 if lost */

    /* Default if universal date/time not available */
    MUUO_VAL("MSTIME", &tim1);	/* Find time-of-day in millisec */
    MUUO_VAL("DATE", &date);	/* and date in stupid T10 format */
    MUUO_VAL("MSTIME", &tim);	/* Get time again to see if */
    if (tim < tim1)		/* went past midnight? */
	MUUO_VAL("DATE", &date);	/* Ugh, timing glitch! Reget date */
    return XWD(date,tim/1000);	/* Get <64date>,,<secs> in return AC */

#elif SYS_CSI
    int ret;
    if (!CSIUUO_VAL("GTADU$", &ret))	/* Get MJD.f (SAF) format word, UTC */
	ret = -1;
    return ret;

#else
    return -1;
#endif
}

/* TADL_FROM_UTIME - Convert UN*X Time-And-Date value to Local TAD value
*/
tadl_t
tadl_from_utime(utad)
time_t utad;
{
#if SYS_10X
    return ((utad/DAYSECS + EPOCH_SADIFF) << HBITS) + (utad%DAYSECS);

#elif SYS_T20+SYS_T10+SYS_CSI
    /* To convert seconds to T20 time units, must multiply by (1<<18)/86400.
    ** Since KCC doesn't support double-word integers, we must extract
    ** halfwords and operate on them separately to avoid integer overflow.
    */
    return (
	((utad/DAYSECS + EPOCH_SADIFF) << HBITS)	/* Get # days, and */
	+ (((utad%DAYSECS)<<HBITS) + DAYSECS/2)/DAYSECS	/* # units of rem */
	);						/* (note roundup) */

#elif SYS_WTS
    return tad64s_from_utime(utad);

#elif SYS_ITS
    struct tm u;
    union {
	time_t xtad;
	struct _its_tm itm;
    } i;

    _lbrktime(&u, utad);	/* Break up Un*x time into a "tm" structure */
    i.xtad = 0;			/* Clear all fields */
    i.itm.dt_year = u.tm_year + 70;
    i.itm.dt_mon = u.tm_mon + 1;
    i.itm.dt_day = u.tm_mday;
    i.itm.dt_tim2 = (((u.tm_hour*60)+u.tm_min)*60+u.tm_sec) << 1;
    return i.xtad;

#else
    return -1;
#endif
}

/* TADL_TO_UTIME - Convert Local Time-And-Date value to UN*X TAD value
**	Note this does not take DST into account, so UN*X TAD value may
** be wrong (except for T20 and T10X which are already GMT).
*/
time_t
tadl_to_utime(ltad)
tadl_t ltad;
{
#if SYS_10X
    return datetosecs((unsigned)ltad>>HBITS) + (ltad&RH);

#elif SYS_T20+SYS_T10+SYS_CSI
    /* To convert T20 time units to seconds, must multiply by 86400/(1<<18).
    ** Since KCC doesn't support double-word integers, we must extract
    ** halfwords and operate on them separately to avoid integer overflow.
    */
#if SYS_T10			/* Allow 64S format as option */
    if (ltad < (1<<(HBITS+15)))
	return tad64s_to_utime(ltad);
#endif
    return datetosecs((unsigned)ltad>>HBITS) + fractosecs(ltad&RH);

#elif SYS_WTS
    return tad64s_to_utime(ltad);

#elif SYS_ITS
    struct tm dtm;			/* So we can use _lmktime */
    union {
	tadl_t xtad;
	struct _its_tm itm;
    } utad;
    utad.xtad = ltad;		/* Make fields accessible via union */
    dtm.tm_year = utad.itm.dt_year;	/* Get 1900-origin year */
    dtm.tm_mon = utad.itm.dt_mon-1;	/* Fix 1-origin month */
    dtm.tm_mday = utad.itm.dt_day;	/* Get 1-origin day of month */
    return _lmktime(&dtm, (utad.itm.dt_tim2 >> 1));

#else
    return -1;
#endif
}

#if SYS_T10+SYS_CSI+SYS_WTS

/* TAD64S_FROM_UTIME - Convert UN*X Time-And-Date value to 64S TAD value
*/
tadl_t
tad64s_from_utime(utad)
time_t utad;
{
    struct tm u;

    if (utad == -1)
	time(&utad);
    _lbrktime(&u, utad);	/* Break up Un*x time into a "tm" structure */
    return (((((u.tm_year+(1970-1964))*12)
		+ u.tm_mon)*31 + (u.tm_mday-1)) << HBITS)
	+ ((u.tm_hour*60) + u.tm_min)*60 + u.tm_sec;
}

/* TAD64S_TO_UTIME - Convert 64S (old TOPS-10) Time-And-Date value to UNX.
**	Note this does not take DST into account, so UN*X TAD value may
** be wrong.
*/
time_t
tad64s_to_utime(ltad)
tadl_t ltad;
{
    register int date;
    struct tm dtm;		/* So we can use _tmisdst */

    /* Now extract various fields from local-format TAD */
    date = (unsigned)ltad >> HBITS;	/* Isolate date (re-using "tim") */
    dtm.tm_mday =  (date % 31) + 1;		/* Fix 0-origin day of month */
    dtm.tm_mon  =  (date / 31) % 12;		/* Get 0-origin month */
    dtm.tm_year = ((date / 31) / 12) + 64;	/* Fix 1964-origin year */
    return _lmktime(&dtm, (ltad & RH));
}
#endif /* T10+WAITS+CSI */

#if SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS

/* _LMKTIME - compute Un*x time given a struct tm and other info.
**	This is very similar to the mktime() routine in CTIME.C but
**	must be independent to avoid loops (and overhead!)
*/
static tadl_t
_lmktime(tm, tim)
struct tm *tm;
int tim;		/* # secs in day */
{
    int days;

    /* Ensure that local variables are set up for timezone/DST values */
    if (!USYS_VAR_REF(ltzknown))	/* Ensure local static vars are set */
	_ltzget();

    tm->tm_yday = _tmontb[tm->tm_mon]	/* Find # days this yr (non-leap yr) */
		+ tm->tm_mday - 1;
    if ((tm->tm_year&03)==0		/* But if this is leap year, */
	  && tm->tm_mon > 1)		/* and after February, */
	    tm->tm_yday++;		/* add a leap day. */

    /* Find total days since 1/1/70 */
    days = tm->tm_yday			/* # days this year */
	    + (tm->tm_year-70)*365	/* plus # days in years so far */
	    + (tm->tm_year-70+1)/4;	/* plus # of leap days since 1970 */

    if ((tim += _ltzsecs) < 0) {	/* Make timezone adjustment */
	--days;				/* Oops, back up 1 day */
	tim += DAYSECS;			/* so time always positive */
    }
    if (_ltdstt != _DST_OFF) {		/* If we have to check for DST, */
	tm->tm_wday = (days+4) % 7;	/* set up day-of-week (4 = Thurs) */
	tm->tm_hour = tim / HRSECS;	/* and hour (can ignore min/sec) */
	if (_tmisdst(tm, _ltdstt))	/* Does DST apply? */
	    tim += HRSECS;		/* Yes, bump up 1 hour */
    }
    return (days * DAYSECS) + tim;	/* Return total # of secs */
}
#endif /* SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS */

static void
_ltzget()
{
#if SYS_T20+SYS_10X
	/* This code gets the local timezone information from the monitor
	** and attempts to find out what kind of DST should be applied.
	** It tests whether July 4,1976 and Jan 4,1976 have DST applied;
	** normally the first will and the second won't, implying we are
	** using U.S. type DST (_DST_USA).  If the first doesn't, we assume
	** DST is never applied (_DST_OFF); if both have DST, then we assume
	** DST is always applied (_DST_ON).
	*/
	union {
	    unsigned ac[5];
	    struct {
		int junk[2];	/* Ignore acs 0 and 1 */
		struct _t20_tm ttm;	/* TNX broken-down time in acs 2-4 */
	    } odval;
	} acblk;
	static struct _t20_tm chkdst = {
			1976, 7-1, 4-1, 0 };	/* July 4, 1976 had DST */

	acblk.odval.ttm = chkdst;	/* Set time to check for */
	jsys(IDCNV, (int *)acblk.ac);		/* Convert that time */
	acblk.ac[4] = acblk.ac[3];	/* Get stupid result in right place */
	_ltzmins = acblk.odval.ttm.dt_ictmz * 60;	/* signed TZ in min */
	_ltzsecs = _ltzmins * 60;			/* and secs */
	if (acblk.odval.ttm.dt_icads) {		/* Was DST applied? */
	    acblk.odval.ttm = chkdst;		/* Yes, check further... */
	    acblk.odval.ttm.dt_mon = 0;		/* Jan 4, 1976 had NO DST. */
	    jsys(IDCNV, (int *)acblk.ac);
	    acblk.ac[4] = acblk.ac[3];	/* Get stupid result in right place */
	    _ltdstt = acblk.odval.ttm.dt_icads	/* If DST was also applied, */
			? _DST_ON : _DST_USA;	/* then always on, else USA. */
	} else _ltdstt = _DST_OFF;		/* No DST, never apply it. */

#elif SYS_T10
    _ltzgotoff = MUUO_ACVAL("GETTAB",		/* 1 if won, 0 if lost */
		XWD(uuosym("%CNGMT"),uuosym(".GTCNF")), &_ltzoff);
    if (_ltzgotoff) {
	_ltzsecs = _ltzoff < 0 ? -fractosecs(-_ltzoff) : fractosecs(_ltzoff);
	_ltzmins = _ltzsecs/60;
	/* No way to determine DST info. */
    }

#elif SYS_CSI
    struct tzone tz1, tz2;
    int off1, off2;
    tz1.tz_fnc = tz2.tz_fnc = csisym("$TZU2L");
    tz1.tz_utc = 42778 << HBITS;	/* 1-Jan-1976 0000 UTC */
    tz2.tz_utc = 42963 << HBITS;	/* 4-Jul-1976 0000 UTC */
    if (CSIUUO_AC("TZONE$", XWD(3,(int)&tz1))) {
	CSIUUO_AC("TZONE$", XWD(3,(int)&tz2));
	off1 = tz1.tz_lcl - tz1.tz_utc;
	off2 = tz2.tz_lcl - tz2.tz_utc;
	if (off1 == off2) {
	    _ltdstt = _DST_OFF;		/* No change in offsets, no DST */
	    tz1.tz_utc = -1;		/* Find offset for now, not then */
	    CSIUUO_AC("TZONE$", XWD(3,(int)&tz1));
	    off1 = tz1.tz_lcl - tz1.tz_utc;
	}
	else
	    _ltdstt = _DST_USA;		/* Assume USA DST for now */
	_ltzsecs = off1 < 0 ? -fractosecs(-off1) : fractosecs(off1);
	_ltzmins = _ltzsecs/60;
    }

#endif

    USYS_VAR_REF(ltzknown)++;		/* Don't try again */
}
#endif /* T20+10X+T10+CSI+WAITS+ITS */
