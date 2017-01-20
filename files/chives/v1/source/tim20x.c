/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Date/time routines.
 *
 * Times are in seconds, since those in the domain system are as
 * well.  Absolute times are as in RFC738 (seconds since 1-Jan-1900
 * 00:00:00 GMT).  This is trivial to compute on both twenex and ITS.
 * Furthermore, we can store dates in files simply as a single
 * decimal integer, which avoids the rather tedious process of doing
 * date I/O in C.  Since domain system times are limited to 32 bits of
 * precision, we don't have to worry about overflow.  This format will
 * be valid (on a 36 bit machine) for the next couple thousand years;
 * if we don't have a better way of doing this by then, god help us
 * all.
 *
 * Just by coincidence, Twenex GTAD% format happens to be based on
 * GMT.  Ie, the RH of a GTAD% word is zero at midnight, GMT.  How
 * convenient.
 *
 * Since all times are either relative to the current time or are
 * absolute, all we need is a way of finding out the current time in
 * absolute terms, for conversion.  Here it is.
 */

zulu()
{
#asm
	SEARCH	MONSYM

	gtad%				/* Get system time */
	jumple	1,zulu$e		/* Be sure it's set */
	sub	1,[035254,,000000]	/* 1 Jan 1900 00:00:00 GMT */
	muli	1,250600		/* Seconds per day */
	ashc	1,21			/* Adjust fixed binary point */
	popj	17,			/* That's it */

zulu$e:	setz	1,			/* System time wasn't set */
	popj	17,			/* Return error */

#endasm
}
