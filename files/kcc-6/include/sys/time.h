/* <SYS/TIME.H> - definitions for BSD gettimeofday(2) and KCC "tadl" rtns.
**
**	(c) Copyright Ken Harrenstien 1989
**
**	Note that getitimer/setitimer are not supported, so their cruft
**	isn't defined here.
*/

#ifndef _SYS_TIME_INCLUDED
#define _SYS_TIME_INCLUDED 1

#include <c-env.h>

/* Structures returned by gettimeofday() system call. */
struct timeval {
	long	tv_sec;		/* seconds since 1/1/70 */
	long	tv_usec;	/* and microseconds */
};
struct timezone {
	int	tz_minuteswest;	/* minutes west of Greenwich (UTC) */
	int	tz_dsttime;	/* type of DST correction */
};

/* Additional definitions (mainly struct tm) for the benefit of
** programs which are using the BSD convention of including <sys/time.h>
** in order to get the struct tm declaration!
*/
#include <time.h>	/* Get ANSI defs, OK to include more than once */

/* KCC-specific additional definitions.
**	These are used by time() and gettimeofday() but may also be
**	used (carefully) by user programs.  Better names should be
**	picked for these, however.
*/
#define tadl_t		_tadl_t
#define tadl_get	_tadlg
#define tadl_to_utime	_tadlt
#define tadl_from_utime	_tadlf
#define tad64s_to_utime	_tad6t
#define tad64s_from_utime _tad6f

typedef long tadl_t;		/* Local TAD format */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* time.c */
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	
extern time_t time P_((time_t *tloc));
extern int gettimeofday P_((struct timeval *tp,struct timezone *tzp));
extern tadl_t tadl_get P_((void));
extern tadl_t tadl_from_utime P_((time_t utad));
extern time_t tadl_to_utime P_((tadl_t ltad));
#if SYS_T10+SYS_CSI+SYS_WTS
extern tadl_t tad64s_from_utime P_((time_t utad));
extern time_t tad64s_to_utime P_((tadl_t ltad));
#endif 
#endif 

#undef P_

/* Define DST correction types.  Not sure what BSD uses, but it's OK
** to make ours up since the only things that should use them are
** gettimeofday() and the C library's time manipulation facilities.
** See localtime(3).
** Also see <sys/sitdep.h> which defines _SITE_DSTTIME to one of these.
*/
#define _DST_OFF 0	/* Never use DST.  This must be 0. */
#define _DST_USA 1	/* Use USA DST algorithm.  Must be 1. */
#define _DST_ON  2	/* Use DST always. */

/*
 * Operations on timevals.
 *
 * NB: timercmp does not work for >= or <=.
 */
#define timerisset(tvp)         ((tvp)->tv_sec || (tvp)->tv_usec)
#define timercmp(tvp, uvp, cmp) \
        ((tvp)->tv_sec cmp (uvp)->tv_sec || \
         (tvp)->tv_sec == (uvp)->tv_sec && (tvp)->tv_usec cmp (uvp)->tv_usec)
#define timerclear(tvp)         (tvp)->tv_sec = (tvp)->tv_usec = 0

#endif /* #ifndef _SYS_TIME_INCLUDED */
