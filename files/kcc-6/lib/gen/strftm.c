/*
**	STRFTM.C - "strftime()" - Generate formatted date/time string
**
**	(c) Copyright Ken Harrenstien 1989
**
** This routine conforms to the draft proposed ANSI C standard as of
** 7-Dec-1988.
**
** Portability considerations:
**	The big problem as usual is timezones, which X3J11 completely wimped
**	out on.  To find the local timezone and print its name,
**	the V7/BSD functions ftime() and timezone() are used.
*/

#include <c-env.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>		/* For timezone() */
#include <sys/timeb.h>		/* For ftime() */

#if __STDC__
#define CONST const
#else
#define CONST
#endif

extern char *timezone(
#ifdef __STDC__
int, int
#endif
);

#define alldays \
	day("Sunday"),   day("Monday"), day("Tuesday"), day("Wednesday"), \
	day("Thursday"), day("Friday"), day("Saturday")
#define allmons \
	mon("January"),   mon("February"), mon("March"),    mon("April"), \
	mon("May"),       mon("June"),     mon("July"),     mon("August"), \
	mon("September"), mon("October"),  mon("November"), mon("December")

static char *_tmstday[] = {	/* Define table of day names */
#define day(str) str
		alldays
#undef day
};
static char _tmltday[] = {	/* and size of names */
#define day(str) sizeof(str)-1
		alldays
#undef day
};

static char *_tmstmon[] = {	/* Define table of month names */
#define mon(str) str
		allmons
#undef mon
};
static char _tmltmon[] = {	/* and size of names */
#define mon(str) sizeof(str)-1
		allmons
#undef mon
};

/* STRFTIME - format date/time string.
**
**	This routine may look a little strange to C traditionalists, because
** it attempts to use *++ptr instead of *ptr++ as much as possible.  This
** is so the code will be optimally efficient on PDP-10s.
*/

size_t
strftime(to, maxlen, fmt, t)
char *to;
size_t maxlen;
CONST char *fmt;
CONST struct tm *t;
{
    static char errstr[] = "???";	/* For use with wild indices */
    register int n = maxlen;		/* Our countdown */
    register char *s;
    int cols, i, max;

    if (!maxlen || !t) return 0;	/* Ensure can write at least 1 char! */

    for (*to = *fmt;; *++to = *++fmt) switch (*to) {
    default: 
	if (--n > 0) continue;		/* If still room, keep going */
	return 0;			/* Nope, fail. */

    case 0:				/* Done!  Already null-terminated, */
	return maxlen - n;		/* so just return count. */

    case '%':
	/* Start big switch to handle format command.
	** "to" points to the first place to deposit into, overwriting
	** the '%' that was already put there.
	** "n" has the # chars of room left.
	*/
	s = NULL;
	switch (*++fmt) {	/* Check next char */
	case 0:			/* Ugh, premature EOF! */
	default:		/* Or unknown format char! */
	    --fmt;		/* Fake out and pretend saw %% */

	case '%':		/* %% - OK, leave % in dest str */
	    if (--n > 0)
		continue;
	    return 0;		/* Fail */

	case 'a':		/* Abbrev weekday name */
	    s = (t->tm_wday >= 0 && t->tm_wday < 7)
		? _tmstday[t->tm_wday] : errstr;
	    cols = 3;
	    break;
	case 'b':		/* Abbrev month name */
	    s = (t->tm_mon >= 0 && t->tm_mon < 12)
		? _tmstmon[t->tm_mon] : errstr;
	    cols = 3;
	    break;
	case 'A':		/* Full weekday name */
	    if (t->tm_wday >= 0 && t->tm_wday < 7)
		s = _tmstday[t->tm_wday], cols = _tmltday[t->tm_wday];
	    else s = errstr, cols = 3;
	    break;
	case 'B':		/* Full month name */
	    if (t->tm_mon >= 0 && t->tm_mon < 12)
		s = _tmstmon[t->tm_mon], cols = _tmltmon[t->tm_mon];
	    else s = errstr, cols = 3;
	    break;
	case 'p':		/* AM/PM designations for 12-hr clock */
	    cols = 2;
	    s = (t->tm_hour < 12) ? "am" : "pm";
	    if (t->tm_sec == 0 && t->tm_min == 0) {
		if (t->tm_hour == 0) s = "midnight", cols = 8;
		else if (t->tm_hour == 12) s = "noon", cols = 4;
	    }
	    break;

	/* Simple numerical stuff */
	case 'H': cols=2, max=23, i = t->tm_hour; break;  /* hh (00-) */
	case 'M': cols=2, max=59, i = t->tm_min; break;   /* mm (00-) */
	case 'S': cols=2, max=61, i = t->tm_sec; break;   /* ss (00-) */
	case 'd': cols=2, max=31, i = t->tm_mday; break;  /* DD (01-) */
	case 'e': max=31, i = t->tm_mday, cols = i < 10 ? 1 : 2; break;  /* DD (1-) */
	case 'm': cols=2, max=12, i = t->tm_mon+1; break; /* MM (01-) */
	case 'y': cols=2, max=99, i = t->tm_year%100; break;  /* YY (00-) */
	case 'Y': cols=4, max=9999,i= t->tm_year+1900; break; /* YYYY (0000-)*/
	case 'w': cols=1, max=6,  i = t->tm_wday; break;    /* Weekday (0-) */
	case 'j': cols=3, max=366,i = t->tm_yday+1; break;  /* Julian (001-) */

	case 'I':		/* Hour (12-hr clock) (01-12) */
	    cols = 2, max = 12;
	    i = (t->tm_hour > 12) ? (t->tm_hour - 12)
			: (t->tm_hour==0 ? 12 : t->tm_hour);
	    break;

	case 'U':		/* Wk # of yr (1st Sun starts wk 1) (00-53) */
	    if (1) i = t->tm_wday;
	    else				/* Note skip over code! */
	case 'W':		/* Wk # of yr (1st Mon starts wk 1) (00-53) */
		i = (i = t->tm_wday-1) < 0	/* Modular subtract */
			? i = 6 : i;
	    if ((i = t->tm_yday - i) < 0)
		i = 0;
	    else i = (i/7) + 1;
	    cols = 2, max = 53;
	    break;

	/* Handle "appropriate" date & time representations.  Note
	** hack of using case labels and ifs in order to initialize
	** the format string "s" and thereafter share code.
	*/
	    if (0)
	case 'c': s = "%d-%b-%Y %H:%M:%S";	/* Date and Time */
	    else if (0)
	case 'x': s = "%d-%b-%Y";		/* Date only */
	    else if (0)
	case 'X': s = "%H:%M:%S";		/* Time only */
	    i = strftime(to, n, s, t);
	    if (!i || (n -= i) <= 0)
		return 0;
	    to += i-1;
	    continue;

	case 'Z':		/* Time zone name or abbrev */
	  { struct timeb tmb;
	    if (ftime(&tmb) !=0 || !(s = timezone(tmb.timezone, t->tm_isdst)))
		s = "TwilightZone";	/* What else to do??? */
	    cols = strlen(s);		/* Won, got timezone name */
	    break;
	  }
	}

	/* If we come here, "cols" has the # columns we need.
	** If "s" is NULL, then "max" and "i" are arguments for the
	** decimal printer, else "s" is copied.
	** If a number is out of range, asterisks are substituted so that
	** the field width is still filled out.
	*/
	if ((n -= cols) <= 0)
	    return 0;
	if (!s) {
	    if (i < 0 || max < i) s = "****";	/* Overflow, subst string */
	    else switch (cols) {
		case 4: *to++ = (i/1000) + '0';  i %= 1000;
		case 3: *to++ = (i/100)  + '0';  i %= 100;
		case 2: *to++ = (i/10)   + '0';  i %= 10;
		case 1: *to   =  i       + '0';
		    continue;
	    }
	}
	for (*to = *s; --cols > 0; *++to = *++s);	/* Copy string! */
	/* "to" is left pointing to last char written! */

    }	/* Resume big loop, never breaks out. */
}
