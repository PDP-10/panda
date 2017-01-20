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
#include <sys/usydat.h>
#include <stdlib.h>
#include <errno.h>
#include <jsys.h>
#define TIMX6 monsym("TIMX6")

static void dummy(sig)
int sig;
{
  abort();
}

int
alarm(secs)
unsigned secs;
{
    extern int _chnalrm;	/* PSI channel to use for TIMER% interrupt */
    static int lastim = 0;
    static int delerr, seterr;	/* For debugging */
    int remsec = 0, curtim, acs[5];

    USYS_BEG();

    if (secs) {
      jsys(GTAD, acs);			/* Get current time */
      curtim = acs[1];
    }

    if (_chnalrm == 0) {		/* Ensure PSI system initialized */
      signal(SIGALRM, dummy);		/* These calls leave PSI chan set up */
      signal(SIGALRM, SIG_DFL);		/* (activated but no handler) */
    }
    
    if (lastim) {			/* Old alarm possibly pending? */
      acs[1] = (_FHSLF<<18) | _TIMDD;	/* Remove specific request */
      acs[2] = lastim;			/* for this time */
      if (jsys(TIMER, acs) <= 0) {
	delerr = acs[0];		/* Remember last error */
	if (delerr != TIMX6) remsec = lastim; /* Remember old time if */
					      /* not passed */
      }
      else remsec = lastim;		/* Remember old time on success */
      lastim = 0;			/* No alarm pending now */
    }
    
    if (secs) {
      acs[1] = (_FHSLF<<18) | _TIMDT;	/* Alarm at exact time */
      lastim = curtim + ((secs << 18) / (24*60*60));
      acs[2] = lastim;			/* New alarm time */
      acs[3] = _chnalrm;		/* Alarm PSI channel to use */
      /* Compute alarm time */
      if (!jsys(TIMER, acs)) {	/* Set alarm */
	seterr = acs[0];
	if (seterr == TIMX6)
	  raise(SIGALRM);		/* Raise signal if time passed */
	else USYS_RETERR(EINVAL);	/* Return error on failure */
      }
    }
    
    if (remsec) {
      jsys(GTAD, acs);
      remsec = (((remsec - acs[1]) * (24*60*60)) + 0400000) >> 18;
      /* Compute old delta from now, */
      /* using half-rounding */
      if (remsec <= 0) remsec = 1;	/* Make it positive */
    }

    USYS_RET(remsec);
}

#endif /* SYS_T20 */
