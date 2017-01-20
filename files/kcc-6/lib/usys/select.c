/*
**	SELECT - Simulation of Unix select(2) system call.
**
**	(c) Copyright Richard P. Helliwell 1993
**
*/

#include <c-env.h>

#if SYS_T20		/* Systems supported for */
#include <sys/types.h>
#include <sys/usydat.h>
#include <sys/time.h>
#include <string.h>
#include <limits.h>
#include <signal.h>
#include <errno.h>
#include <jsys.h>

extern int _nread(), _nwrite();

#define TIMX6 monsym("TIMX6")

static long select_pause = 100;	/* Loop wait time, for debug */

/* Only rfds are checked.  */
int
select (nfds, rfds, wfds, efds, timeout)
     int nfds;
     fd_set *rfds, *wfds, *efds;
     struct timeval *timeout;
{
  int ravail = 0, fd, acs[5], status, which;
  int copysize = ((nfds + NFDBITS - 1) / NFDBITS) * sizeof(fd_mask);
  long avail;
  struct _ufile *uf;
  fd_set ibits[3], obits[3];
  unsigned long int timeoutval, now, delta;

  /* We can't handle more than the size of 'fd_set' */
  if (nfds > FD_SETSIZE) {
    errno = EINVAL;
    return -1;
  }

  USYS_BEG();

  if (timeout) {
    jsys(TIME, acs);
    timeoutval = (unsigned long)acs[1]
      + (timeout->tv_sec * 1000) + (timeout->tv_usec / 1000);
				/* Compute end time */
  }
  else timeoutval = ULONG_MAX;

  bzero((char *)ibits, sizeof(ibits));
  bzero((char *)obits, sizeof(obits));
  /* Only fetch the bytes he promised exist */
  if (rfds) bcopy(rfds, &ibits[0], copysize);
  if (wfds) bcopy(wfds, &ibits[1], copysize);
  if (efds) bcopy(efds, &ibits[2], copysize);

  /* Once an interval, till the timeout expires, check all the flagged
   * descriptors for input/output/error as appropriate.  If operation
   * possible set the corresponding bit in the return copy of ?fds.
   */ 
  do {
    for (which = 0; which < 3; which ++)
      for (fd = 0; fd < nfds; fd++) {
	uf = _UFGET(fd);
	switch (which) {
	case 0:			/* Check for input */
	  if (uf && FD_ISSET(fd, &ibits[0])) {
	    status = _nread(uf, &avail);
	    if (status == -2)	/* Interrupted? */
	      USYS_RETERR(EINTR);
	    if ((!status && (avail > 0)) || status) {
	      FD_SET(fd, &obits[0]);
	      ravail++;
	    }
	  }
	  break;

	case 1:			/* Check for output */
	  if (FD_ISSET(fd, &ibits[1])) {
	    status = _nwrite(uf, &avail);
	    if (status == -2)	/* Interrupted? */
	      USYS_RETERR(EINTR);
	    if ((!status && (avail != 0)) || status) {
	      FD_SET(fd, &obits[1]);
	      ravail++;
	    }
	  }
	  break;

	case 2:
	  if (!uf && FD_ISSET(fd, &ibits[2])) {
	    FD_SET(fd, &obits[2]);
	    ravail++;
	  }
	  break;
	}
      }

    if (ravail > 0) break;
    jsys(TIME,acs);
    now = acs[1];
    if (now > timeoutval) break; /* Quite early? */
    delta = timeoutval - now;	/* Compute time remaining */
    if (delta > select_pause) delta = select_pause;
				/* Do min of select_pause and time remaining */
    acs[1] = delta;
    jsys(DISMS|JSYS_OKINT, acs); /* Dismiss for a while */
    status = USYS_END();	/* Become interruptable */
    if (status < 0) {		/* If interrupted */
      errno = EINTR;		/* Flag that */
      return -1;		/* and return error */
    }
    USYS_BEG();
    jsys(TIME,acs);
    now = acs[1];
  } while (timeoutval > now);

  status = USYS_END();
  if (status < 0) {
    errno = EINTR;
    return -1;
  }

  /* Only return the bytes he promised exist */
  if (rfds) bcopy(&obits[0], rfds, copysize);
  if (wfds) bcopy(&obits[1], wfds, copysize);
  if (efds) bcopy(&obits[2], efds, copysize);

  return ravail;
}

#endif /* SYS_T20 */
