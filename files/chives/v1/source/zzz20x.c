/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Function to sleep until there's something for resolver to do.
 *  time = sleep time in seconds
 *  busy = boolean: was resolver doing something recently?
 *
 * Will wake up on any of the following conditions:
 *  Time expires;
 *  Something is present for our Internet Queue Handle;
 *  A PID belonging to this fork has (an) outstanding message(s).
 *
 * Vince Fuller has correctly pointed out that the the PID to hang on
 * should be an argument to the GTDOM% call, rather than always being
 * the .SPRSV index into the system PID table.  The use of an explicit
 * hold time as an argument to GTDOM% is a holdover from the ISI
 * GTDOM%; it is not clear whether it is helpful.  So the hold time
 * argument should probably be replaced with a PID.  At the same time,
 * the MIT GTDOM% .GTDWT function should implement the subfunction
 * code that MIT defined (once upon a time) in the ISI .GTDWT
 * function.  This will help to distinguish between the various
 * incompatable versions of .GTDWT.
 */

#include "domsym.h"
#include <jsys.h>
#include <monsym.h>
#include "udp.h"

/* Hold times for idle and busy states. */
#define	HOLD_IDLE   500
#define	HOLD_BUSY   2000

void zzz(time,busy)
    int time,busy;
{
    int ac[5];
    time *= 1000;			/* Convert to milliseconds */
    if(DBGFLG(DBG_ZZZ|DBG_PID)) {
	ac[1] = time;			/* Just sleep for test version */
	jsys(DISMS,ac);
    } else {
	ac[1] = monsym(".GTDWT");	/* Resolver wait function */
	ac[2] = (busy?HOLD_BUSY:HOLD_IDLE); /* Hold time, picked at random */
	ac[3] = time;			/* How long to wait */
	ac[4] = udpiqh;			/* Exported from UDP20X.C */
	jsys(GTDOM,ac);		/* Sleep until needed */
    }
}
