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
 * Since all times are either relative to the current time or are
 * absolute, all we need is a way of finding out the current time in
 * absolute terms, for conversion.  Here it is.
 *
 * This code is snitched from AI:SYSENG;DATIME 66.
 */

/*
 * As far as I know, ITS doesn't really know about timezones.
 * If somebody teaches it about them, this code should be fixed.
 * For the moment, the correct timezone must be defined at compile
 * time.
 *  EST is time zone -0500
 *  PST is time zone -0800
 *  In Stockholm use +0100
 *  Etcetera.
 */

#ifndef MY_TMZ
#define MY_TMZ (5)
#endif

static int my_tmz = MY_TMZ*60*60;	/* TMZ correction factor */

zulu()
{
#asm

/*
 * I don't know which assembler this will be fed to.
 * Assume MIDAS for now.
 */

	.RLPDTM 2,			/* Get .RYEAR and .PDTIME values */
	TLNN	3,40000			/* Time not set? */
	 JRST	ZULU$E			/* Barf */
	TLNE	3,400000		/* Past Feb 28 in non leap year? */
	 SUBI	2,24.*60.*60.		/* Yeah, correct for it */
	TLNE	3,100000		/* Daylight savings time? */
	 SUBI	2,60.*60.		/* Yep, correct to standard */
	MOVEI	3,-1900.(3)		/* Get years relative to 1900 */
	MOVEI	1,-1(3)			/* Calculate number of leap years */
	LSH	1,-2			/* (not including this year) */
	IMULI	3,365.			/* Number of days since 1900 */
	ADD	1,3			/* Plus leap years (works till 2100) */
	IMULI	1,24.*60.*60.		/* Convert to seconds */
	ADD	1,2			/* Plus seconds this year */
	SUB	1,MY.TMZ		/* Correct for our time zone */
	POPJ	17,			/* Is seconds since 1900, GMT */

ZULU$E::SETZ	1,			/* Time not set, error */
	POPJ	17,			/* Return zero to indicate this */

#endasm
}
