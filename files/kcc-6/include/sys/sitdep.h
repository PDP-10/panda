/* <SYS/SITDEP.H> - KCC Site-dependent system parameters.
**
**	(c) Copyright Ken Harrenstien 1987, 1989
**
**	This is an invention for the KCC implementation and is not intended
**	to simulate any Un*x file.
**	All of the entries herein are specifically intended to be modified
**	individually for each site.
**
*/

/* Define local time zone and DST when not available from system.
**	_SITE_TIMEZONE is in minutes westward of UTC (GMT); if a site is
**		eastward of Greenwich, the value should be negative.
**	_SITE_DSTTIME is the type of Daylight Savings Time correction to
**		apply; the possible choices are defined in <sys/time.h>.
** See the library's USYS/TIME.C module for the variables these are stored
** in.  They can be patched there if necessary.
*/
#ifndef _SITE_TIMEZONE
#define _SITE_TIMEZONE (8*60)	/* PST */
#endif

#ifndef _SITE_DSTTIME
#define _SITE_DSTTIME _DST_USA
#endif
