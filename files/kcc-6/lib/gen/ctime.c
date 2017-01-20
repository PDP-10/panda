/*
**	CTIME	- Date and time library routines
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.42, 7-Mar-1988
**	(c) Copyright Ken Harrenstien, SRI International 1987
**
**	These routines conform to those described by H&S (2nd ed) sec. 20.
** They are standard for V7, BSD, and SYSV, with two additional ANSI functions.
**
** However, the conventions for handling timezones and daylight savings time
** are NOT standardized.  The currently known mechanisms are:
**	V7: the ftime() syscall returns ".timezone" and ".dstflag" as
**		structure components.
**	    A function "timezone()" returns the string for a timezone+dst.
**	BSD: the gettimeofday() syscall returns ".tz_minuteswest" and
**		".tz_dsttime" as structure components.
**		V7 ftime() is emulated for compatibility.
**	    The V7 function "timezone()" also exists.
**	S5: There is no way to query the system re timezone.  That info is
**		furnished by the environment variable "TZ".
**	    A function "void tzset(void)" reads TZ and sets the vars below:
**	    	"extern long timezone" holds the timezone in seconds.
**	    	"extern int daylight" is nonzero only if USA DST is applicable.
**	    	"extern char *tzname[2]" holds timezone strings (STD & DST).
**
** Note the conflict for the "timezone" symbol between S5 and everything else.
** We chose to support BSD-compatible software.
*/

#include <c-env.h>
#include <time.h>		/* Note this is NOT sys/time.h ! */
#include <sys/time.h>		/* For _DST_ values */
#include <sys/timeb.h>		/* For ftime() syscall */

#if __STDC__
#define CONST const
#else
#define CONST
#endif

#define DAYSECS (24*60*60)	/* # seconds in a day */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* These two functions are only used externally by KCC's TIME.C
** Unix emulation code, and only on TOPS-10, WAITS, or ITS.
** This seems better than duplicating them just for modularity.
*/
struct tm *_lbrktime P_((struct tm *t,time_t utim));
int _tmisdst P_((struct tm *t,int dsttyp));

/* Purely internal functions */
static long _tzloc P_((void));
static char *_tad2str P_((CONST struct tm *t,char *str));
static struct tm *_gbrktime P_((struct tm *t,time_t utim));

#undef P_

static char cbuf[26];		/* Return value for asctime, ctime */
static struct tm ctm;		/* Return value for gmtime, localtime */

/* Define local enum values here for our convenience.  Unfortunately
** there is no standard for external symbols representing these values,
** so we cannot let user programs depend on them.  Sigh.
*/
enum dow {Sun=0, Mon, Tue, Wed, Thu, Fri, Sat };
enum month {Jan=0, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec };


/* CTMONTB - Table of days thus far in year, assuming non-leap year.
** CTLMONTB - ditto, assuming leap year.
**	Indexed by month, with 0 = January.
*/

static int ctmontb[] = {
	0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
};
static int ctlmontb[] = {
	0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335
};
static int ctdaysinmon[] = {
	/* J   F   M   A   M   J   J   A   S   O   N   D */
	  31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
};

static char *ctstrday[] = {
	"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
};
static char *ctstrmon[] = {
	"Jan", "Feb", "Mar", "Apr", "May", "Jun",
	"Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
};


/* Externally available library routines are all on this one page. */

/* CTIME - Given a time_t value, return pointer to date/time string
*/

char *
ctime(tp)
CONST time_t *tp;
{
    struct tm tmp;
    return _tad2str(_lbrktime(&tmp, *tp), cbuf);
}

/* ASCTIME - Given a broken-down tm struct, return pointer to date/time string
*/
char *
asctime(t)
CONST struct tm *t;
{
    return _tad2str(t, cbuf);
}

/* GMTIME - Break down time into structure, using GMT (no zone or DST)
*/
struct tm *
gmtime(tp)
CONST time_t *tp;
{
    return _gbrktime(&ctm, *tp);
}

/* LOCALTIME - Break down time into structure, using local timezone and DST
*/
struct tm *
localtime(tp)
CONST time_t *tp;
{
    return _lbrktime(&ctm, *tp);
}

/* TIMEZONE - V7/BSD specific function.
**	Given timezone in minutes, returns pointer to a string
** representing that timezone.
*/
/* Table indexed by hour difference */
static char *ctzonstr[] = {
	0, 0, 0, 0, 0, 0, 0, 0,	/* -12 to -9 */
	0, 0, 0, 0, 0, 0, 0, 0,	/* -8 to -5 */
	0, 0, 0, 0, 0, 0, 0, 0,	/* -4 to -1 */
	"GMT", "BST",		/* 0 Greenwich Mean (British Summer) */
	0, 0, 0, 0, 0, 0,	/* 1 to 3 */
	"AST", "ADT",		/* 4 Atlantic Standard */
	"EST", "EDT",		/* 5 Eastern Standard */
	"CST", "CDT",		/* 6 Central Standard */
	"MST", "MDT",		/* 7 Mountain */
	"PST", "PDT",		/* 8 Pacific */
	"YST", "YDT",		/* 9 Yukon */
	"HST", "HDT",		/* 10 Hawaii */
	"BST", "BDT",		/* 11 Bering */
	0, 0			/* 12 */
};
static char tzbuf[10];		/* For "GMT+hh:mm\0" */

char *
timezone(mwest, dstt)
int mwest, dstt;
{
    register int i, rem;
    register char *cp;

    if (mwest < 0) {
	i = -(-mwest/60);	/* Get pos or neg hour number */
	rem = -mwest%60;	/* Get positive remainder */
    } else {
	i = mwest/60;
	rem = mwest % 60;
    }

    /* See if name appears in table */
    if (rem == 0			/* Round multiple of hours? */
      && -12 <= i && i <= 12		/* Between -12 and +12? */
      && ctzonstr[12*2 + i*2])		/* And exists in table? */
	return ctzonstr[12*2 + i*2 + (dstt ? 1 : 0)];

    /* Not in table, generate string with difference from GMT */
    if (dstt) ++i;		/* Assume DST always means bump up 1 hour */
    cp = tzbuf;
    *cp   = 'G';
    *++cp = 'M';
    *++cp = 'T';
    if (mwest < 0) {	/* Neg means ahead of GMT */
	*++cp = '+';	/* Convention is to indicate "ahead" with plus sign */
	i = -i;
    } else *++cp = '-';	/* Convention is to indicate "behind" with minus */
    if (i > 10)
	*++cp = '0' + ((i % 100) / 10);	/* Output tens digit of hour */
    *++cp = '0' + i%10;			/* Output ones digit of hour */
    *++cp = ':';
    *++cp = '0' + (rem / 10);	/* tens digit of remainder (min) */
    *++cp = '0' + (rem % 10);	/* ones digit of remainder (min) */
    *++cp = '\0';		/* Polish off */
    return tzbuf;
}

/* Miscellaneous auxiliary routines */

/* _TZLOC - return local timezone in seconds.
**	First time, asks system for timezone, then stores it so future
** calls can avoid overhead of system call.  Note that this value is given
** type "long" so that the code can work on 16-bit systems.
**	The system call used is V7 ftime() rather than BSD gettimeofday()
** because the former is more likely to be widely supported, in case this
** code is used elsewhere.  There is however a subtle assumption that ftime()
** will return 1 for "dstflag" if a USA type DST algorithm is to be used.
*/
static int _tlzknown = 0;	/* Non-zero when next two values are known */
static long _tlzone;		/* Local timezone in secs */
static int _tldstf;		/* Local DST type to apply (a _DST_xxx val) */

static long
_tzloc()
{
    struct timeb tmb;

    if (!_tlzknown && ftime(&tmb) == 0) {
	_tlzknown++;				/* Say zone is known */
	_tlzone = tmb.timezone * 60;		/* Get zone in sec */
	_tldstf = tmb.dstflag;			/* Get type of DST to apply */
    }
    return _tlzone;
}

/* _TAD2STR - Time-And-Date to String.
**	Workhorse routine for asctime().
*/
static char *
_tad2str(t, str)
register CONST struct tm *t;
char *str;
{
    register char *cp = str;
    register char *src;
    register int i;

    /* First do day-of-week name (with range check) */
    src = (0 <= t->tm_wday && t->tm_wday < 7)
		? ctstrday[t->tm_wday] : "Badday";
    *cp = *src;			/* Copy 1st 3 chars of day name */
    *++cp = *++src;
    *++cp = *++src;
    *++cp = ' ';

    /* Then do month name (with range check) */
    src = (0 <= t->tm_mon && t->tm_mon < 12)
		? ctstrmon[t->tm_mon] : "Badember";
    *++cp = *src;		/* Copy 1st 3 chars of month name */
    *++cp = *++src;
    *++cp = *++src;
    *++cp = ' ';

    /* And then day of month */
    if (1 <= t->tm_mday && t->tm_mday <= 31 ) {
	*++cp = (i = (t->tm_mday / 10)) == 0 ? ' ' : (i + '0');
	*++cp = (t->tm_mday % 10) + '0';
    } else *++cp = '*', *++cp = '*';
    *++cp = ' ';


    /* Now do hours. */
    if (0 <= t->tm_hour && t->tm_hour < 24) {
	*++cp = (t->tm_hour / 10) + '0';
	*++cp = (t->tm_hour % 10) + '0';
    } else *++cp = '*', *++cp = '*';
    *++cp = ':';

    /* Minutes */
    if (0 <= t->tm_min && t->tm_min < 60) {
	*++cp = (t->tm_min / 10) + '0';
	*++cp = (t->tm_min % 10) + '0';
    } else *++cp = '*', *++cp = '*';
    *++cp = ':';

    /* Seconds */
    if (0 <= t->tm_sec && t->tm_sec < 60) {
	*++cp = (t->tm_sec / 10) + '0';
	*++cp = (t->tm_sec % 10) + '0';
    } else *++cp = '*', *++cp = '*';
    *++cp = ' ';

    /* Year (years since 1900) */
    if (0 <= t->tm_year && t->tm_year < (10000-1900)) {
	i = t->tm_year + 1900;
	*++cp =  (i /  1000)        + '0';
	*++cp = ((i %= 1000) / 100) + '0';
	*++cp = ((i %=  100) /  10) + '0';
	*++cp =  (i %    10)	    + '0';
    } else *++cp = '*', *++cp = '*', *++cp = '*', *++cp = '*';
    *++cp = '\n';

    *++cp = '\0';		/* Finally all done! */
    return str;			/* Return pointer to string */
}

/* _GBRKTIME - Workhorse routine for gmtime().
*/
static struct tm *
_gbrktime(t, utim)
struct tm *t;
time_t utim;
{
    register int i, days, secs, yday, year;

    /* Divide into days and seconds */
    days = utim / DAYSECS;		/* Get # of days */
    secs = utim % DAYSECS;		/* and remaining # secs in day */

    /* Now split up seconds into hh:mm:ss */
    t->tm_sec = secs % 60;
    t->tm_min = (secs / 60) % 60;
    t->tm_hour = (secs / 60) / 60;

    /* Now a few other things that are easy to do */
    t->tm_wday = (days + Thu) % 7;	/* epoch was a Thurs, must adjust. */
    t->tm_isdst = 0;			/* GMT, so DST never applies */
    
    /* Now use days to find year plus remaining # of days in that year */
    year = (days / 365);		/* Find # of "normal" years */
    yday = (days % 365) - ((year+1)/4);	/* Get rem days minus # of leap yrs */
    year += 70;				/* Now can make base 1900, not 1970 */
    if (yday < 0) {			/* Backed past beg of year? */
	year--;				/* decrement # years */
	yday += 365 			/* and adjust remaining # days */
	      + ((year&03)==0 ? 1 : 0);	/* If now in leap year, add one more */
    }
    t->tm_year = year;			/* Now can set these! */
    t->tm_yday = yday;

    /* Finally, find and set month and day in month */
    i = Dec;				/* Start from December backwards */
    if ((year&03)==0) {			/* If leap year, use leap table */
	while (yday < ctlmontb[i]) --i;	/* Find leap month this yday is in */
	t->tm_mday = (yday - ctlmontb[i]) + 1;
    } else {
	while (yday < ctmontb[i]) --i;	/* Find month this yday is in */
	t->tm_mday = (yday - ctmontb[i]) + 1;
    }
    t->tm_mon = i;

    return t;
}


struct tm *
_lbrktime(t, utim)
struct tm *t;
time_t utim;
{
    if (_gbrktime(t, utim - _tzloc()) == 0)	/* Crack zone-adjusted time */
	return 0;

    /* Now check for DST adjustment.  Note that the above call to _tzloc()
    ** ensures that _tldstf is already set.
    */
    if (t->tm_isdst = _tmisdst(t, _tldstf)) {	/* Set DST-applied flag */
	if (++(t->tm_hour) >= 24) {
	    /* Bumped into next day, sigh.  Rather than checking for more and
	    ** more global bumpings, just add an hour to the original time
	    ** and crack it again!
	    */
	    int savdst = t->tm_isdst;		/* Remember DST flag */
	    _gbrktime(t, (time_t)60*60 + utim - _tzloc());
	    t->tm_isdst = savdst;		/* Restore DST flag, */
	}					/*  this avoids re-asking */
    }
    return t;
}

/* _TMISDST - Given a broken-down time and DST type, determine whether DST
**	applies to that time.
**
** _DST_USA algorithm:
**	Congress enacted nationwide DST in 1967 such that it:
**		Starts at 2AM on the last Sunday of April, ends at 1AM standard
**		time on the last Sunday in October.
**		This is herein termed "old DST".
**	There was also forced daylight time in 1974 and 1975: "forced DST".
**	As of 1987 the new rule is that DST starts on the FIRST Sunday of
**	April (it still ends on the last Sunday of October): "new DST".
**	There will undoubtedly be future rule revisions.
*/
static struct {int beg, end; } _ctdstus[] = {
	115, 297,	/* 1970 old DST  26-Apr to 25-Oct */
	114, 303,	/* 1971 old DST  25-Apr to 31-Oct */
	120, 302,	/* 1972 old DST  30-Apr to 29-Oct */
	118, 300,	/* 1973 old DST  29-Apr to 28-Oct */
	  5, 299,	/* 1974 forced  5-Jan (first Sun), to 27-Oct */
	 53, 298,	/* 1975 forced 23-Feb (last  Sun), to 26-Oct */
/* Note: 4.3BSD claims 1974 DST ended on 24-Nov (last Sun in Nov) */
	115, 304,	/* 1976 old DST  25-Apr to 31-Oct */
	113, 302,	/* 1977 old DST  24-Apr to 30-Oct */
	119, 301,	/* 1978 old DST  30-Apr to 29-Oct */
	118, 300,	/* 1979 old DST  29-Apr to 28-Oct */
	117, 299,	/* 1980 old DST  27-Apr to 26-Oct */
	115, 297,	/* 1981 old DST  26-Apr to 25-Oct */
	114, 303,	/* 1982 old DST  25-Apr to 31-Oct */
	113, 302,	/* 1983 old DST  24-Apr to 30-Oct */
	119, 301,	/* 1984 old DST  29-Apr to 28-Oct */
	117, 299,	/* 1985 old DST  28-Apr to 27-Oct */
	116, 298,	/* 1986 old DST  27-Apr to 26-Oct */
};
#define NDSTYRS (int)(sizeof(_ctdstus)/sizeof(_ctdstus[0]))	/* # entries */

/* This is an explanation of how the 1st and last Sunday of a month is
** calculated here.  Given a tm structure with an already broken-down time,
** things are relatively straightforward:
**
**	First we find the day-of-week for day 1 of the month, by subtracting
** the current day-of-month from the wday (going backwards that many days),
** modulo 7.
**		dow1 = (35 + wday - (mday-1)) % 7;
** The addition of 35 ensures that we don't try to take the remainder
** of a negative number.
**
**	Second, given the wday for mday 1, we find how many days there are
** between that wday and the one we want (in this case Sunday); a simple
** modular subtraction.
**	desired-mday = (7 + desired-wday - dow1) % 7 + 1;
** Again, the addition of 7 ensures that the operand of % is positive.
** The result is zero-based, so 1 must be added to produce the desired
** day-of-month.
**
** The following macro combines the above two equations:
*/
#define newmday(dow, mday, wday) \
	((7 + (dow) - (35+(wday)-(mday-1))%7)%7 + 1)
/*	
**	Third, now that we have the desired day-of-month, we can
** get the desired day-of-year by removing the old mday value and adding
** the new one.
**	desired-yday = (yday - mday) + desired-mday;
**
** In order to find the LAST day-of-week in a month, we simply move up
** to a fictional "next month", find the desired-yday of the FIRST
** desired-wday within that new month, and subtract 7 (one week) to land
** back in the old month.
*/

int
_tmisdst(t, dsttyp)
struct tm *t;		/* Broken-down time.  Uses year,yday,wday,mon,hour */
int dsttyp;		/* DST type, a _DST_xxx value */
{
    register int i, beg, end;

    switch (dsttyp) {
    default:				/* Unknown DST type, ignore it. */
    case _DST_OFF:			/* DST always off */
	break;

    case _DST_ON:			/* DST always on */
	return 1;

    case _DST_USA:			/* Use US DST algorithms */
	if (0 <= (t->tm_year-70) && (t->tm_year-70) < NDSTYRS) {
						/* Within table? */
	    beg = _ctdstus[t->tm_year-70].beg;	/* Yes, get ranges from tbl */
	    end = _ctdstus[t->tm_year-70].end;
	} else {
	    /* Year not in precomputed table.  Assume we're using the
	    ** "new DST" rule (from 1st Sunday in April, to last Sunday in Oct)
	    ** and do hairy computations if necessary.
	    */
	    switch (t->tm_mon) {	/* Quick cheat */
		case Jan: case Feb: case Mar:	/* Before April? */
		case Nov: case Dec:		/* After October? */
		default:
		    return 0;		/* Yes, no DST - quick lossage! */

		case May: case Jun:	/* Or within normal DST range? */
		case Jul: case Aug:
		case Sep:
		    return 1;		/* Yes, in DST - quick winnage! */

		case Apr:		/* In April.  Find 1st Sunday */
		    beg = t->tm_yday - t->tm_mday	/* See explanation */
				+ newmday(Sun, t->tm_mday, t->tm_wday);
		    end = ctmontb[Oct];	/* Just needs to be bigger than Apr */
		    break;		/* Drop thru for check */

		case Oct:		/* In October.  Find last Sunday */
		    beg = ctmontb[Apr];	/* Just needs to be smaller than Oct */
		    i = ctdaysinmon[Oct] - t->tm_mday;	/* Days left in mon */

		    end = t->tm_yday + i		/* See explanation */
			+ newmday(Sun, 1, (t->tm_wday+i+1)%7)
			- 7;
		    break;
	    }
	}

	/* At this point, we have the Julian-day (tm_yday) ranges for which
	** DST applies during the current year.
	*/
	if ( t->tm_yday < beg		/* Check ranges */
	  || t->tm_yday > end)
	    return 0;			/* Outside range, no DST */

	if (t->tm_yday == beg)		/* Start day? */
	    return (t->tm_hour >= 2);	/* DST if 2AM or past */

	if (t->tm_yday == end)		/* End day? */
	    return (t->tm_hour < 2);	/* DST if before 2AM */

	return 1;			/* Assume inside range of DST */
    }
    return 0;
}

/* New ANSI routines - MKTIME and DIFFTIME */

/* MKTIME - Make a time_t value out of a broken-down time.
*/
time_t
mktime(t)
register struct tm *t;
{
    register int days, tim;
    int yday;
    time_t ret;

    /* Find # of days thus far in this year. */
    days = yday =
	((t->tm_year&03)==0 ?		/* Leap year? */
		  ctlmontb[t->tm_mon]	/* # days in leap months so far */
		: ctmontb[t->tm_mon])	/* # days in reg months so far */
	+ t->tm_mday - 1;		/* plus # days this month */

    /* Now add # days in years thus far */
    days += ((t->tm_year-70) * 365)	/* # days in years so far */
	 + (((t->tm_year-70) + 1)>>2);	/* plus # of leap days since 1970 */

    /* Now figure out the time in seconds, plus adjustments. */
    tim = ((t->tm_hour * 60) + t->tm_min) * 60 + t->tm_sec	/* Base time */
		+ _tzloc()			/* plus timezone */
		+ (t->tm_isdst ? -60*60 : 0);	/* plus DST adjust */

    ret = days * DAYSECS + tim;			/* Add together all the secs */

    /* Have time value, now check source structure to see if must fix up. */
    if (   tim < 0        || DAYSECS <= tim	/* time underflow/overflow? */
	|| t->tm_hour < 0 || 23 < t->tm_hour
	|| t->tm_min  < 0 || 59 < t->tm_min
	|| t->tm_sec  < 0 || 59 < t->tm_sec
	|| t->tm_mon  < 0 || 11 < t->tm_mon
	|| t->tm_mday < 1 || ctdaysinmon[t->tm_mon] < t->tm_mday
	|| t->tm_year < 0 || 135 < t->tm_year)
	    _lbrktime(t, ret);		/* Do full breakdown */
    else {
	t->tm_wday = (days + Thu) % 7;
	t->tm_yday = yday;
    }
    return ret;
}

double
difftime(t1, t0)
time_t t1, t0;
{
    return (double) (t1 - t0);
}
