/*
**	ALARM - Simulation of Unix alarm(2) system call.
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.5, 10-Sep-1987
**	(c) Copyright Ken Harrenstien, SRI International 1987
**
**	For T20 this uses the TIMER% JSYS.
** There is some inefficiency in that setting a new alarm after one has
** already gone off will attempt to flush the old alarm.  This is the
** safest thing to do, however; there is no guarantee that a SIGALRM
** signal actually came from a TIMER% interrupt!
**	But, being T20, things are worse than this.  We cannot use
** absolute times because, for one thing, the TIMER% JSYS
** fails immediately (without deleting anything) if .TIMDD finds that
** the specified time is already past.  But the clock queue may not have
** generated a PSI interrupt yet because it uses a different resolution
** (milliseconds) and a few thousand instructions can happen in each
** millisecond.  This means that a TIMER% PSI can go off long after
** the call has failed to flush the request from the queue!  Snarl!!!!!
**	So, when we flush the request we use .TIMBF with a time 1 day
** in advance of the actual time we set.  This zaps any other requests that
** the user may have made independently -- tough.
**	Finally, we must use .TIMEL instead of .TIMDT so as to be absolutely
** sure that the TIMER% call which sets the time won't be screwed up
** because of some system delay between our GTAD% and TIMER% calls.  Otherwise
** the GTAD% value we compute may already be past by the time TIMER% sees (and
** rejects) it.  Sigh.  We still remember our GTAD value so that alarm()
** return an approximately correct value for the # of seconds remaining.
*/

#include <c-env.h>

#if SYS_T20		/* Systems supported for */
#include <signal.h>
#include <sys/usysig.h>
#include <errno.h>
#if SYS_T20
#include <jsys.h>
#endif

int
alarm(secs)
unsigned secs;
{
#if SYS_T20
    extern int _chnalrm;	/* PSI channel to use for TIMER% interrupt */
    static int lastim = 0;
    static int delerr, seterr;	/* For debugging */
    int remsec, curtim, acs[5];
    extern void abort();

    USYS_BEG();
    if (_chnalrm == 0) {		/* Ensure PSI system initialized */
	signal(SIGALRM, abort);		/* These calls leave PSI chan set up */
	signal(SIGALRM, SIG_DFL);	/* (activated but no handler) */
    }

    if (lastim == 0) {			/* Is an alarm currently active? */
	remsec = 0;			/* No, just set return value zero */
	if (secs) jsys(GTAD, acs);	/* Get current time if will need it */
    } else {
	acs[1] = (_FHSLF<<18) | _TIMBF;	/* Remove previous alarm requests */
	acs[2] = lastim + (1<<18);	/* for up to 1 day in advance! */
	if (jsys(TIMER, acs) <= 0) {	/* Remove it, ignore failure */
	    delerr = acs[0];		/* (has probably already gone off) */
	}
	jsys(GTAD, acs);			/* Get current time */
	if ((remsec = lastim - acs[1]) > 0)	/* Determine time left */
	    remsec = (remsec * (24*60*60)) >> 18;	/* Convert to secs */
	else remsec = 0;		/* Negative means probably went off */
	lastim = 0;			/* Say no currently pending alarm. */
    }
    /* remsec has time (in sec) that remained until last alarm.  If user wants
    ** a new alarm, set it.  Current time is in acs[1]; we add the # of
    ** seconds (in T20 GTAD form) to that number to get the new alarm time.
    */
    if (secs) {
	curtim = acs[1];		/* Remember current time */
	acs[1] = (_FHSLF<<18) | _TIMEL;	/* Use elapsed time in msec */
	acs[2] = secs * 1000;
	acs[3] = _chnalrm;		/* Alarm PSI channel to use */
	if (jsys(TIMER, acs) <= 0) {
	    seterr = acs[0];
	    USYS_RETERR(EINVAL);	/* Not sure what else to do */
	}
	lastim = curtim + (secs << 18) / (24*60*60);	/* Remember abs time */
    }
    USYS_RET(remsec);
#endif
}

#endif /* T20 */
