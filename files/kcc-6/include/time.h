/* <TIME.H> - Date and Time definitions and declarations
**
**	(c) Copyright Ken Harrenstien 1989
**
*/

#ifndef _TIME_INCLUDED
#define _TIME_INCLUDED
#ifndef __STDC__	/* Canonicalize this indicator to avoid err msgs */
#define __STDC__ 0
#endif

#ifndef _SIZE_T_DEFINED		/* Avoid conflict with other headers */
#define _SIZE_T_DEFINED
typedef unsigned size_t;	/* Type of sizeof() (must be unsigned, ugh) */
#endif

#define CLOCKS_PER_SEC	1000	/* Processor time is in msec */
#ifndef _CLOCK_T_
typedef long clock_t;		/* A processor time value */
#define _CLOCK_T_
#endif

#ifndef _TIME_T_DEFINED		/* Avoid clash with BSD <sys/types.h> */
#define _TIME_T_DEFINED
typedef long time_t;		/* A calendar date/time value */
#endif

/* TM broken-down calendar time structure */
struct tm {
	int tm_sec;
	int tm_min;
	int tm_hour;
	int tm_mday;
	int tm_mon;
	int tm_year;
	int tm_wday;
	int tm_yday;
	int tm_isdst;
	int tm_dummy[3];	/* Spares for extra features or expansion */
};

/* Function Declarations */

#if __STDC__
extern clock_t clock(void);		/* Get processor runtime */
extern double difftime(time_t, time_t);	/* Get diff of two time_t vals */
extern time_t mktime(struct tm *);	/* Build time_t from struct */
extern time_t time(time_t *);		/* Get calendar date/time */
extern char *asctime(const struct tm *); /* Get d/t string given struct tm */
extern char *ctime(const time_t *);	/* Get d/t string given time_t */
extern struct tm *gmtime(const time_t *); /* Break down time_t into struct tm */
extern struct tm *localtime(const time_t *); /* Same but local time, not GMT */
extern size_t strftime(char*, size_t,	/* to, maxlen, fmt, timevals */
		const char*, const struct tm *);
#ifndef _ANSI_SOURCE
extern void tzset (void);
#endif /* not ANSI */
#if !defined(_ANSI_SOURCE) && !defined(_POSIX_SOURCE)
char *timezone (int, int);
void tzsetwall (void);
#endif /* neither ANSI nor POSIX */
#else
extern clock_t clock();		/* Get processor runtime */
extern time_t time();		/* Get calendar date/time */
extern char *asctime(),		/* Make static d/t string given struct tm */
	*ctime();		/* Make static d/t string given time_t */
extern struct tm *gmtime(),	/* Break down time_t into static struct tm */
	*localtime();		/* Same but local time instead of GMT */
extern double difftime();	/* Get difference of two time_t vals */
#ifndef _ANSI_SOURCE
extern void tzset();
#endif /* not ANSI */
#if !defined(_ANSI_SOURCE) && !defined(_POSIX_SOURCE)
char *timezone ();
void tzsetwall ();
#endif /* neither ANSI nor POSIX */
#endif /* not __STDC__ */
#endif /* ifndef _TIME_INCLUDED */
 