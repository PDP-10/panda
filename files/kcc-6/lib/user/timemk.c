/*
** TIME_MAKE		derive 32-bit time value from TMX structure.
**
** 	Copyright (c) 1980, 1987 by Ken Harrenstien, SRI International.
**
**	This code is quasi-public; it may be used freely in like software.
**	It is not to be sold, nor used in licensed software without
**	permission of the author.
**	For everyone's benefit, please report bugs and improvements!
**	(Internet: <KLH@SRI-NIC.ARPA>)
**
** Usage:
**	#include <timex.h>
**	time_t time_make(struct tmx *tp);
**
** Returns:
**	A time_t value.
**	Will fail if parameters are out of range or nonsensical; the
**	return value will be (time_t)-1 and tmx_err will be set in the
**	tmx structure to point at a constant error-message string.
*/

#include <timex.h>

/* Days in year thus far, indexed by month (0-12!!)  Assumes non-leap year. */
static int daytb[] = {
	0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365
};

#define TERR(str) { tp->tmx_err = str; return -1; }

time_t
time_make(tp)
register struct tmx *tp;
{
    register int i;
    struct tm *tmp;
    int year, mon, day, yday, wday, dst, leap;
    time_t tres, curtim;

    if (tp->tm.tm_year == TMX_NULL
     || tp->tm.tm_mon  == TMX_NULL
     || tp->tm.tm_mday == TMX_NULL) {
	time(&curtim);
	tmp = localtime(&curtim);	/* Get breakdowns of current time */
	year = tmp->tm_year;		/* Get defaults to use */
	mon = tmp->tm_mon;
	day = tmp->tm_mday;
#ifdef DEBUG
	printf("first YMD: %d %d %d, T=%ld\n",year,mon,day,curtim);
#endif
    }

    /* First must find date, using specified year, month, day.
     * If one of these is unspecified, it defaults either to the
     * current date (if no more global spec was given) or to the
     * zero-value for that spec (i.e. a more global spec was seen).
     * Start with year... note 32 bits can only handle 135 years.
     */
    if (tp->tm.tm_year == TMX_NULL)
	tp->tm.tm_year = year;		/* Set to default */
    else {
	if ((year = tp->tm.tm_year) >= 1900)	/* Allow full yr # */
	    year = (tp->tm.tm_year -= 1900);	/* by making kosher */
	mon = 0;		/* Since year was given, default */
	day = 1;		/* for remaining specs is zero */
    }
    if (year < 70 || 70+134 < year)	/* Check range */
	TERR("year out of range")
    leap = year&03 ? 0 : 1;	/* See if leap year */
    year -= 70;			/* UNIX time starts at 1970 */

    /*
     * Find day of year.
     * YDAY is used only if it exists and either the month or day-of-month
     * is missing.
     */
    if (tp->tm.tm_yday != TMX_NULL
     && (tp->tm.tm_mon == TMX_NULL || tp->tm.tm_mday == TMX_NULL))
	yday = tp->tm.tm_yday;
    else {
	if (tp->tm.tm_mon == TMX_NULL)
	    tp->tm.tm_mon = mon;	/* Set month from default */
	else {
	    mon = tp->tm.tm_mon;	/* Month was specified */
	    day = 1;			/* so set remaining default */
	}
	if (mon < 0 || 11 < mon)
	    TERR("month out of range")
	if (tp->tm.tm_mday == TMX_NULL)
	    tp->tm.tm_mday = day;		/* Set day from default */
	else day = tp->tm.tm_mday;
	if (day < 1
	 || (((daytb[mon+1]-daytb[mon]) < day)
		&& (day!=29 || mon!=1 || !leap) ))
			TERR("day out of range")
	yday = daytb[mon]	/* Add # of days in months so far */
	  + ((leap		/* Leap year, and past Feb?  If */
	      && mon>1)? 1:0)	/* so, add leap day for this year */
	  + day-1;		/* And finally add # days this mon */
#if 1 /* Optional */
	if (tp->tm.tm_yday == TMX_NULL)	/* Confirm that YDAY correct */
	    tp->tm.tm_yday = yday;	/* Not specified, just set */
	else if (tp->tm.tm_yday != yday)
		TERR("yday conflict")
#endif
    }
    if (yday < 0 || (leap?366:365) <= yday)
	TERR("yday out of range")	/* ERR: bad YDAY or maketime bug */

    tres = year*365			/* Get # days of years so far */
	+ ((year+1)>>2)		/* plus # of leap days since 1970 */
	+ yday;			/* and finally add # days this year */

#if 1 /* Optional */
	wday = (tres+4)%7;	/* Derive day-of-week */
	if ((i = tp->tm.tm_wday) != TMX_NULL) {	/* Check WDAY if present */
	    if (i < 0 || 6 < i	/* Ensure within range */
	     || i != wday)	/* Matches? Jan 1,1970 was Thu = 4 */
		TERR("wday conflict")
	} else tp->tm.tm_wday = wday;
#endif

#ifdef DEBUG
printf("YMD: %d %d %d, T=%ld\n",year,mon,day,tres);
#endif
    /*
     * Now determine time.  If not given, default to zeros
     * (since time is always the least global spec)
     */
    tres *= 86400L;			/* Get # seconds (24*60*60) */

    if ((i = tp->tm.tm_min) == TMX_NULL) tp->tm.tm_min = i = 0;
    if (i < 0 || 60 <= i) TERR("min out of range")
    if ((i = tp->tm.tm_sec) == TMX_NULL) tp->tm.tm_sec = i = 0;
    if (i < 0 || 60 <= i) TERR("sec out of range")
    if ((i = tp->tm.tm_hour) == TMX_NULL) tp->tm.tm_hour = i = 0;
    if (i < 0 || 24 <= i)
	if (i != 24 || (tp->tm.tm_min+tp->tm.tm_sec) !=0)	/* 24:00 OK */
	    TERR("hour out of range")
#ifdef DEBUG
    printf("HMS: %d %d %d T=%ld\n",
	tp->tm.tm_hour, tp->tm.tm_min, tp->tm.tm_sec, tres);
#endif


    tres += tp->tm.tm_sec		/* Add in # secs of time */
		+ 60L * (tp->tm.tm_min + 60L * tp->tm.tm_hour);

    /*
    ** We now have the local date/time and must make final
    ** adjustment for the specified time zone, to get GMT.
    ** If no zone is specified, the local time-zone is assumed.
    */
    if (tp->tmz.tmz_secwest == TMX_NULL) {	/* If unspecified */
	if ((i = tp->tmz.tmz_minwest)==TMX_NULL)
	    i = 1;				/* Use local zone */
	tp->tmz.tmz_secwest = (i == 1 ? 1 : i*60L);
    }
    if (tp->tmz.tmz_secwest == 1) {	/* Forcing use of local zone? */
	time_lzone(&tp->tmz);		/* then set to local zone */
    }
    if (tp->tmz.tmz_secwest < -(12*60*60L)
      || 12*60*60L < tp->tmz.tmz_secwest)
	TERR("zone out of range")

    /* See if must apply Daylight Saving Time shift.
     * Note that if DST is specified, validity is not checked.
     */
    if((dst = tp->tm.tm_isdst) == TMX_NULL) {	/* Must we figure it out? */
	struct tmz lz;
	time_lzone(&lz);			/* Get our local tz stuff */
	if (lz.tmz_secwest == tp->tmz.tmz_secwest) {	/* Same as local? */
	    curtim = tres + lz.tmz_secwest;	/* Yes, get equiv local */
	    dst = localtime(&curtim)->tm_isdst;	/* time, and ask. */
	} else dst = 0;			/* No, cannot determine if OK. */
	tp->tm.tm_isdst = dst;
    }
    tres += tp->tmz.tmz_secwest - (dst==1 ? 3600 : 0);	/* Add in zone adj */

    tp->tmx_err = 0;		/* Won!  Clear error message ptr */
    return tres;
}
