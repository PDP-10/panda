/* <SYS/TIMEB.H> - definitions for ftime(2)
**
**	(c) Copyright Ken Harrenstien 1989
**
**	Structure filled out by ftime() V7 system call.
**	This is considered obsolete by BSD, which uses gettimeofday().
**	Note that <sys/types.h> must have been included.
*/

#ifndef _SYS_TIMEB_INCLUDED
#define _SYS_TIMEB_INCLUDED

struct timeb
{
	time_t time;		/* Time since epoch (1/1/70) in seconds */
	int millitm;		/* ms since above time (up to 1000) */
	int timezone;		/* local timezone in minutes west of GMT */
	int dstflag;		/* If set, DST applies locally */
};

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

extern int ftime P_((struct timeb *tp));

#undef P_

#endif /* ifndef _SYS_TIMEB_INCLUDED */
