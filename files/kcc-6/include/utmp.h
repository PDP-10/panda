/*	@(#)utmp.h 1.8 88/08/19 SMI; from UCB 4.2 83/05/22	*/

#ifndef _utmp_h
#define _utmp_h

/*
 * Structure of utmp and wtmp files.
 *
 */
#define UT_LINESIZE	8
#define UT_NAMESIZE	8
#define UT_HOSTSIZE	16

struct lastlog {
	time_t	ll_time;		/* last login time */
	char	ll_line[UT_LINESIZE];	/* tty name */
	char	ll_host[UT_HOSTSIZE];	/* host name, if remote */
};

struct utmp {
	char	ut_line[UT_LINESIZE];	/* tty name */
	char	ut_name[UT_NAMESIZE];	/* user id */
	char	ut_host[UT_HOSTSIZE];	/* host name, if remote */
	long	ut_time;		/* time on */
};

/*
 * This is a utmp entry that does not correspond to a genuine user
 */
#define nonuser(ut) ((ut).ut_host[0] == 0 && \
	strncmp((ut).ut_line, "tty", 3) == 0 && ((ut).ut_line[3] == 'p' \
					      || (ut).ut_line[3] == 'q' \
					      || (ut).ut_line[3] == 'r' \
					      || (ut).ut_line[3] == 's'))

#endif /*!_utmp_h*/
