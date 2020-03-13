/*
**	IOCTL
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.59, 11-Apr-1988
**	(c) Copyright Ian Macky, SRI International 1987
**	Revised 1987 by Ken Harrenstien
*/

#if 0
	NOTE on the various TIOCxxx functions:

In general, any attempts to GET terminal variables will query the monitor
whenever possible for the most up-to-date information, simultaneously
updating the internal _tty structure for the terminal.  However, when
trying to SET variables, the new values are checked with the internal
ones stored in the _tty struct, and monitor calls are only made when
a difference exists between the new values and the old internal ones.

This is an attempt to provide some efficiency without too great a risk
of confusion between the USYS state and the monitor state.  This is only
a problem if the TTY parameters have been changed out from under the
process, which cannot be predicted (or easily detected).  GETing all info
from the monitor ensures such info is always accurate; since almost all
users of the SET functions will first read the variables, things should
almost always be uptodate for SET purposes.

#endif

#include <c-env.h>

#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS	/* Systems supported for */

#include <stddef.h>	/* for NULL */
#include <sys/ioctl.h>
#include <sys/types.h>		/* For net/if.h */
#include <sys/socket.h>		/* For net/if.h */
#include <net/if.h>		/* For struct ifconf */
#include <sys/usydat.h>
#include <errno.h>
#if SYS_T20+SYS_10X
#include <jsys.h>
#include <unistd.h>

#elif SYS_T10+SYS_CSI+SYS_WTS
#include <muuo.h>
#include <macsym.h>

#endif

extern struct _tty *_uftty();

/*
 *	given an int linespeed, turn it into a sgtty-style char value.
 */
static int
uspeed(line_speed)
int line_speed;
{
    switch (line_speed) {
	case 0:		return B0;
	case 50:	return B50;
	case 75:	return B75;
	case 110:	return B110;
	case 150:	return B150;
	case 200:	return B200;
	case 300:	return B300;
	case 600:	return B600;
	case 1200:	return B1200;
	case 1800:	return B1800;
	case 2400:	return B2400;
	case 4800:	return B4800;
	case 9600:	return B9600;
	case 19200:	return B19200;
	case 0777777:	return EXTB;	/* "unknown" speed value */
    }
    return -1;		/* Failed to find match */
}

/*
 *	given an sgtty char value, turn it into a real T20 speed
 */

static int
tspeed(sgtty_code)
int sgtty_code;
{
    switch(sgtty_code) {
	case B0:	return 0;
	case B50:	return 50;
	case B75:	return 75;
	case B110:	return 110;
	case B150:	return 150;
	case B200:	return 200;
	case B300:	return 300;
	case B600:	return 600;
	case B1200:	return 1200;
	case B1800:	return 1800;
	case B2400:	return 2400;
	case B4800:	return 4800;
	case B9600:	return 9600;
	case B19200:	return 19200;
	case EXTB:	return 0777777;		/* Special case (PTY) */
    }
    return -1;		/* Not found, fail */
}

/*
 *	Implement TIOCGETP function
 */

static int
cgetp(tp, arg)
struct _tty *tp;
struct sgttyb *arg;
{
    int flags = 0;
#if SYS_T20+SYS_10X
#define SGTTYFLAGS (RAW|CRMOD|ECHO)	/* Flags we can handle */

    int ablock[5];
    int jfn;

    ablock[1] = jfn = tp->tt_uf->uf_ch;	/* JFN of stream */
    ablock[2] = _MORSP;				/* read TTY speeds */
    if (jsys(MTOPR, ablock) <= 0)		/* do it! */
	return -1;
    tp->sg.sg_ispeed = uspeed((unsigned)ablock[3] >> 18); /* input speed */
    tp->sg.sg_ospeed = uspeed(ablock[3] & RH);		/* output speed */

    if (jsys(RFMOD, ablock) <= 0)	/* read JFN mode word */
	return -1;
    flags = EVENP|ODDP;			/* initialize flag word */
    if ((ablock[2] & TT_DAM) == _TTBIN)	/* if in binary data mode */
	flags |= RAW;			/* set unix RAW bit */
    if (ablock[2] & TT_ECO)		/* if echoing */
	flags |= ECHO;			/* set unix ECHO bit */

#elif SYS_T10
#define SGTTYFLAGS (CRMOD)		/* Flags we can handle */
    int spd;
    if (!gtrmop(tp, uuosym(".TORSP"), &spd))	/* Get input baud rate */
	return -1;
    tp->sg.sg_ispeed = spd;			/* Same codes as UN*X! */
    if (!gtrmop(tp, uuosym(".TOTSP"), &spd))	/* Get output baud rate */
	return -1;
    tp->sg.sg_ospeed = spd;

#elif SYS_CSI
#define SGTTYFLAGS (CRMOD|ECHO)		/* Flags we can handle */
    int spd;
    if (!gtrmop(tp, csisym("$TOBAU"), &spd))	/* Get baud rate */
	return -1;
    switch (spd) {
	case csisym("$TO011"):	spd = B110;	break;
	case csisym("$TO030"):	spd = B300;	break;
	case csisym("$TO045"):	spd = B450;	break;
	case csisym("$TO120"):	spd = B1200;	break;
	case csisym("$TO180"):	spd = B1800;	break;
	case csisym("$TO240"):	spd = B2400;	break;
	case csisym("$TO480"):	spd = B4800;	break;
	case csisym("$TO960"):	spd = B9600;	break;
	default:		spd = EXTB;	break;	/* Unknown speed */
    }
    tp->sg.sg_ispeed = tp->sg.sg_ospeed = spd;	/* Set speed code */

    /* Now determine flags.  The only one we can check the system for is
    ** ECHO, sigh.
    */
    if (!gtrmop(tp, csisym("$TONEC"), &spd))
	return -1;
    if (!spd)		/* If not suppressing echo, */
	flags |= ECHO;	/* then say echoing. */

#else
    return -1;
#endif

    /* Common code to finish up */
    if (tp->tt_uf->uf_flgs&UIOF_CONVERTED)	/* If internal conversion on */
	flags |= CRMOD;			/* set unix CRMOD bit */
    tp->sg.sg_flags =			/* Update our internal structure */
	(tp->sg.sg_flags & ~SGTTYFLAGS) | flags;
    *arg = tp->sg;			/* Copy structure */
    return 0;				/* non -1 means success */
}

/*
 *	Implement TIOCSETP function
 */

static int
csetp(tp, arg, delay_flag)
struct _tty *tp;
int delay_flag;
struct sgttyb *arg;
{
#if SYS_T20+SYS_10X
    int ispeed, ospeed, acs[5], flags, jfn, ctc_enabled = 1;

    jfn = tp->tt_uf->uf_ch;
    if (delay_flag) {
	tp->tt_uf->uf_rleft = 0;	/* Flush anything buffered */
	tp->tt_uf->uf_wleft = 0;
	acs[1] = jfn;			/* JFN of stream, wait until output */
	if (jsys(DOBE|JSYS_OKINT, acs) < 0)	/* is quiescent... */
	    return -2;			/* If interrupted, say so */
	jsys(CFIBF, acs);		/* clear pending input too */
    }

    /* Update erase/kill characters.  This cannot actually be done. */
    if (tp->sg.sg_erase != arg->sg_erase
     || tp->sg.sg_kill != arg->sg_kill)
	return -1;			/* Fail if try to change chars */

    /* Update terminal speeds */
    acs[1] = jfn;				/* JFN of connection */
    acs[2] = _MOSPD;				/* set the TTY line speed */
    ispeed = tspeed(arg->sg_ispeed);		/* turn sgtty code into */
    ospeed = tspeed(arg->sg_ospeed);		/* real int linespeed. */
    if (ispeed < 0 || ospeed < 0)		/* tspeed() returns -1 on */
	return -1;				/* error */
    acs[3] = (ispeed << 18) + ospeed;		/* input,,output speeds */
    if (jsys(MTOPR, acs) > 0) {			/* set it! */
	tp->sg.sg_ispeed = arg->sg_ispeed;	/* Won, update internal vars */
	tp->sg.sg_ospeed = arg->sg_ospeed;
    }

    /* Update flags.  Only some have any effect. */
    flags = (arg->sg_flags & (RAW | CRMOD | ECHO | CBREAK)) | (EVENP|ODDP);

    if (flags & RAW) {		/* Want to get into raw mode? */
	if ((tp->sg.sg_flags & RAW)==0) {	/* Yes, already in raw mode? */
		acs[1] = jfn;
		jsys(RFMOD, acs);		/* No!  Must save stuff... */
		tp->tt_jfnmod = acs[2];		/* Save old JFN mode word */
		if (tp == _cntrl_tty) {		/* Controlling TTY? */
		    acs[1] = -5 & RH;		/* Entire-job */
		    jsys(RTIW, acs);
		    tp->tt_tiw = acs[2];	/* Save term int word */
		} else tp->tt_tiw = -1;
	}
	/* Now force into raw mode whether or not already in it. */
	if (tp == _cntrl_tty) {		/* Controlling TTY? */
	    acs[1] = _FHSLF;		/* Set up for RPCAP% */
	    jsys(RPCAP, acs);
	    if ((acs[3]&SC_CTC)==0) {	/* ctl-C cap not enabled? */
		acs[3] |= SC_CTC;	/* attempt to enable it */
		if (!jsys(EPCAP, acs)) ctc_enabled = 0;
	    }
	    acs[1] = _FHSLF;		/* Get TIW for our process */
	    jsys(RTIW, acs);
	    if (!ctc_enabled) acs[2] |= monsym(".TICCCC");
					/* If no cap, don't diable */
					/* this */
	    acs[1] = -5 & RH;		/* set TIW for entire job, so */
	    jsys(STIW, acs);		/* only our chars interrupt */
	}
	tp->tt_uf->uf_flgs &= ~UIOF_CONVERTED; /* Ensure no CRLF conv */

	/* Select binary mode, wakeup on all chars */
	acs[2] = (tp->tt_jfnmod & ~(TT_DAM|TT_ECO|TT_PGM)) | _TTBIN | TT_WAK;

    } else {			/* Don't want raw mode.  Already in it? */
	if (tp->sg.sg_flags & RAW) {	/* Yes, must restore old modes! */
	    if (tp == _cntrl_tty) {	/* Controlling TTY? */
		acs[1] = -5 & RH;
		acs[2] = tp->tt_tiw;
		jsys(STIW, acs);	/* Restore old TIW */
	    }
	    acs[2] = tp->tt_jfnmod;	/* Set up old JFN mode word */
	} else {	/* No change, must ensure we have uptodate mode wd */
	    acs[1] = jfn;
	    jsys(RFMOD, acs);		/* Get it into ac2 */
	}

	/* We don't want raw mode, and have mode word set up appropriately
	** in AC2.  Now force all the other flags.
	*/
	if (flags & CRMOD)
	    tp->tt_uf->uf_flgs |= UIOF_CONVERTED;	/* Use CRLF conv */
	else
	    tp->tt_uf->uf_flgs &= ~UIOF_CONVERTED;	/* No CRLF conv */
	if (flags & ECHO) acs[2] |= TT_ECO;	/* Turn on echoing */
	else acs[2] &= ~TT_ECO;			/* Turn off echoing */
    }

    /* Now set up final JFN mode word, already in AC2. */
    acs[1] = jfn;
    jsys(SFMOD, acs);			/* set JFN mode word now! */
    jsys(STPAR, acs);			/* Take care of other stuff */
    tp->sg.sg_flags = flags;		/* Install new flags internally */

    return 0;				/* Return not -1 for win */

#elif SYS_CSI
    int spd, flags;

    /* First, ensure output buffer is empty, wait if it isn't. */
    if (delay_flag) {
	tp->tt_uf->uf_rleft = 0;	/* Flush anything USYS-buffered */
	tp->tt_uf->uf_wleft = 0;
	while (gtrmop(tp, uuosym(".TOSOP"), &spd)) {	/* Until buff empty */
	    CSIUUO_AC("JSLEP$", 1);		/* sleep for 1 jiffy */
	}
	/* System output buffer empty, now flush input */
	gtrmop(tp, uuosym(".TOCIB"), &spd);	/* May not work */
    }

    /* Update erase/kill characters.  This cannot actually be done. */
    if (tp->sg.sg_erase != arg->sg_erase
     || tp->sg.sg_kill != arg->sg_kill)
	return -1;			/* Fail if try to change chars */

    /* Update terminal speeds */
    if ((spd = arg->sg_ispeed) < tp->sg.sg_ospeed)
	spd = arg->sg_ospeed;		/* Use whichever is higher */
    switch (spd) {
	case B110:	spd = csisym("$TO011");	break;
	case B300:	spd = csisym("$TO030");	break;
	case B450:	spd = csisym("$TO045");	break;
	case B1200:	spd = csisym("$TO120");	break;
	case B1800:	spd = csisym("$TO180");	break;
	case B2400:	spd = csisym("$TO240");	break;
	case B4800:	spd = csisym("$TO480");	break;
	case B9600:	spd = csisym("$TO960");	break;
	case EXTB:
	default:	spd = -1;	break;	/* Unknown speed */
    }
    if (strmop(tp, csisym("$TOBAU"), spd)) {
	tp->sg.sg_ispeed = spd;	/* Won, update internal vars */
	tp->sg.sg_ospeed = spd;
    }

    /* Update flags.  Only some have any effect. */
    flags = (arg->sg_flags & (RAW | CRMOD | ECHO | CBREAK)) | (EVENP|ODDP);

    if (flags & RAW)
	tp->tt_uf->uf_flgs &= ~UIOF_CONVERTED; /* Ensure no CRLF conv */
    else {
	if (flags & CRMOD)
	    tp->tt_uf->uf_flgs |= UIOF_CONVERTED;	/* Use CRLF conv */
	else
	    tp->tt_uf->uf_flgs &= ~UIOF_CONVERTED;	/* No CRLF conv */
    }
    /* Force new echo state */
    strmop(tp, csisym("$TONEC"), (flags&ECHO) ? 0 : 1);

    tp->sg.sg_flags = flags;		/* Install new flags internally */
    return 0;				/* Return not -1 for win */

#else
    return -1;
#endif
}

/*
 *	Implement TIOCFLUSH function
 */

static int
cflush(tp)
struct _tty *tp;
{
    tp->tt_uf->uf_rleft = 0;		/* Flush any USYS-buffered I/O */
    tp->tt_uf->uf_wleft = 0;

#if SYS_T20+SYS_10X
    {
    int acs[5];

    acs[1] = tp->tt_uf->uf_ch;		/* Get JFN */
    if (jsys(CFOBF, acs) <= 0		/* Flush system output */
     || jsys(CFIBF, acs) <= 0)		/* Flush system input */
	return -1;
    return 0;				/* Return winnage */
    }

#elif SYS_T10+SYS_CSI+SYS_WTS
    if (tp->tt_uf->uf_ch == UIO_CH_CTTRM) {
	MUUO("CLRBFO");
	MUUO("CLRBFI");
    }
    return 0;
#else
    return -1;
#endif
}

/*
 *	Implement TIOCSTI function
 */

static int
csti(tp, arg)
struct _tty *tp;
char *arg;
{
#if SYS_T20+SYS_10X
    int acs[5], i;

    acs[1] = tp->tt_uf->uf_ch;		/* JFN of stream */
    acs[2] = *arg;			/* get the char */
    i = jsys(STI, acs);			/* simulate terminal input */
    if (i > 0) return 0;		/* 0 means success */
    if (i < 0) return -2;		/* Interrupted */
    /* Drop thru for failure */
#endif
    return -1;
}

static csetcint(tp)
struct _tty *tp;
{
#if SYS_T20+SYS_10X
    /* If controlling TTY, and signals set up, call signal code */
    if ((tp == _cntrl_tty) && USYS_VAR_REF(atirtn))
        return (*USYS_VAR_REF(atirtn))(0);
				/* Set new interrupt chars (no SIGIO) */
#endif
    return 0;
}

/*	TIOCGETC, TIOCSETC	- Get and set "tchars" (special chars)
*/
static int
cgetc(tp, tcp)
struct _tty *tp;
struct tchars *tcp;
{
    *tcp = tp->tc;	/* Return current structure to user */
    return 0;
}

static int
csetc(tp, tcp)
struct _tty *tp;
struct tchars *tcp;
{
    /* Cannot change most of the values. */
    if (tp->tc.t_startc != tcp->t_startc
     || tp->tc.t_stopc != tcp->t_stopc) {
#if SYS_T20
	{
	int acs[5], startc, stopc;

	acs[1] = tp->tt_uf->uf_ch;	/* Get JFN */
	acs[2] = monsym(".MOPCS");	/* Set pause/unpause chars */
	startc = (tcp->t_startc == (char)-1) ? 0 : tcp->t_startc;
	stopc = (tcp->t_stopc == (char)-1) ? 0 : tcp->t_stopc;
	acs[3] = (stopc << 18) | startc;
	if (jsys(MTOPR, acs) <= 0) return -1;
	}
#else
	return -1;			/* Fail */
#endif
    }
    tp->tc = *tcp;			/* Set structure */
    return csetcint(tp);		/* Update all interrupt characters */
}

/*	TIOCSLTC, TIOCGLTC
*/
static int
cgltc(tp, ltp)
struct _tty *tp;
struct ltchars *ltp;
{
    *ltp = tp->lt;	/* Get structure */
    return 0;
}

static int
csltc(tp, ltp)
struct _tty *tp;
struct ltchars *ltp;
{
    if (tp->lt.t_rprntc != ltp->t_rprntc /* Cannot change these, sigh */
     || tp->lt.t_flushc != ltp->t_flushc
     || tp->lt.t_werasc != ltp->t_werasc
     || tp->lt.t_lnextc != ltp->t_lnextc)
	return -1;

    tp->lt = *ltp;	/* Set structure */
    return csetcint(tp);		/* Update all interrupt characters */
}

/*	TIOCLBIS, TIOCLBIC, TIOCLSET, TIOCLGET - Hack TTY local mode word
*/

static int
clset(tp, ip)
struct _tty *tp;
int *ip;
{
#if SYS_T20+SYS_10X
/* Define bits which cannot be changed */
#define CLNOCH (LCRTBS|LPRTERA|LCRTERA|LTILDE|LCRTKIL|LCTLECH|LNOHANG)
    int ofmod, nfmod, acs[5];

    /* First check for unchangeable bits */
    if ((*ip & CLNOCH) != (tp->tt_lmode & CLNOCH)) return -1;

    /* Both input and output must be passed or not */
    if ((*ip & (LLITOUT|LPASS8))
	&& ((*ip & (LLITOUT|LPASS8)) != (LLITOUT|LPASS8))) return -1;
	
    acs[1] = tp->tt_uf->uf_ch;		/* Get JFN */
    if (!jsys(RFMOD, acs)) return -1;
    ofmod = nfmod = acs[2];		/* Get mode word */

    if (*ip & (LLITOUT|LPASS8)) nfmod &= ~TT_DAM;
    else if (!(ofmod & TT_DAM)) nfmod |= _TTASC * (TT_DAM & ~(TT_DAM-1));

    if (*ip & LFLUSHO) nfmod |= monsym("TT%OSP");
    else nfmod &= ~monsym("TT%OSP");

    /* Store CLNOCH bits, TOSTOP, LMDMBUF, LETXACK, LDECCTQ, and LNOFLSH */
    tp->tt_lmode = *ip & (CLNOCH|LTOSTOP|LMDMBUF|LETXACK|LDECCTQ);

    /* LPENDIN are merely discarded */

    /* Update terminal mode word if needed */
    if (nfmod != ofmod) {
	acs[2] = nfmod;
	if (!jsys(SFMOD, acs)) return -1;
    }

    return 0;
#else
    return -1;
#endif
}

static int
clget(tp, ip)
struct _tty *tp;
int *ip;
{
#if SYS_T20+SYS_10X
    int acs[5];

    acs[1] = tp->tt_uf->uf_ch;		/* Get JFN */
    if (!jsys(RFMOD, acs)) return -1;

    *ip = tp->tt_lmode;
    if (acs[2] & monsym("TT%OSP")) *ip |= LFLUSHO;
    if (!(acs[2] & TT_DAM)) *ip |= (LLITOUT|LPASS8);

    return 0;
#else
    return -1;
#endif
}

static int
clbis(tp, ip)
struct _tty *tp;
int *ip;
{
    int oip;

    if (clget(tp, &oip)) return -1;
    oip |= *ip;
    return clset(tp, &oip);
}

static int
clbic(tp, ip)
struct _tty *tp;
int *ip;
{
    int oip;

    if (clget(tp, &oip)) return -1;
    oip &= ~(*ip);
    return clset(tp, &oip);
}

/*	TIOCGWINSZ, TIOCSWINSZ
*/
static int
cgwinsz(tp, wsp)
struct _tty *tp;
struct winsize *wsp;
{
#if SYS_T20
    int acs[5], err = 0;

    acs[1] = tp->tt_uf->uf_ch;		/* Get JFN */
    acs[2] = _MORLW;			/* Get page width in AC3 */
    if (jsys(MTOPR, acs) > 0)
	tp->ws.ws_col = acs[3];		/* Won, set width in chars */
    else ++err, tp->ws.ws_col = 0;	/* Unknown width */
    acs[2] = _MORLL;			/* Get page length (height) */
    if (jsys(MTOPR, acs) > 0)
	tp->ws.ws_row = acs[3];		/* Won, set height in chars */
    else ++err, tp->ws.ws_row = 0;	/* Unknown height */
    if (err)
	return -1;

    /* As for xpixel and ypixel, just return whatever we have locally. */
#endif
    *wsp = tp->ws;		/* Return structure */
    return 0;
}

static int
cswinsz(tp, wsp)
struct _tty *tp;
struct winsize *wsp;
{
#if SYS_T20
    int acs[5], err = 0;
    acs[1] = tp->tt_uf->uf_ch;		/* Get JFN */
    acs[2] = _MOSLW;			/* Set page width from AC3 */
    acs[3] = wsp->ws_col;
    if (jsys(MTOPR, acs) > 0)
	tp->ws.ws_col = wsp->ws_col;	/* Won, set width in chars */
    else ++err, tp->ws.ws_col = 0;	/* Unknown width */

    acs[2] = _MOSLL;			/* Set page length (height) */
    acs[3] = wsp->ws_row;
    if (jsys(MTOPR, acs) > 0)
	tp->ws.ws_row = wsp->ws_row;	/* Won, set height in chars */
    else ++err, tp->ws.ws_row = 0;	/* Unknown height */
    if (err)
	return -1;

    tp->ws.ws_xpixel = wsp->ws_xpixel;	/* Just set the pixel sizes */
    tp->ws.ws_ypixel = wsp->ws_ypixel;
#else
    tp->ws = *wsp;			/* Set structure */
#endif
    return 0;
}

/*	Implement TIOCSCTTY function
 */
static int
csctty(tp)
struct _tty *tp;
{
#if SYS_T20
  int acs[5];

  acs[1] = tp->tt_uf->uf_ch;
  if (jsys(DVCHR, acs)) {
    acs[1] = (monsym(".SCSET") << 18) | _FHSLF;
    acs[2] = (acs[3] & RH) | monsym(".TTDES");
    if (jsys(SCTTY, acs)) return 0;
  }
#endif
  return -1;			/* Failed or not implemented */
}

/* Auxiliaries */

#if SYS_T10+SYS_CSI
/* GTRMOP - Get TTY param with TRMOP.
*/
static int
gtrmop(tp, fn, val)
struct _tty *tp;
int fn, *val;
{
    struct _toblk to;
    to.to_fnc = fn;
    to.to_udx = tp->tt_udx;
    if (!MUUO_AC("TRMOP.", XWD(3, (int)&to)))
	return 0;
    *val = to.to_arg.wd[0];
    return 1;
}

/* STRMOP - Set TTY param with TRMOP.
*/
static int
strmop(tp, fn, val)
struct _tty *tp;
int fn, val;
{
    struct _toblk to;
    if (fn & 01000) fn += 01000;	/* If a READ param, turn into SET */
    to.to_fnc = fn;
    to.to_udx = tp->tt_udx;
    to.to_arg.wd[0] = val;
    return MUUO_AC("TRMOP.", XWD(3, (int)&to));
}
#endif

/*
 *	Implement FIONBIO function
 */

static int
fndelay(uf, arg)
struct _ufile *uf;
long *arg;
{

    uf->uf_flgs &= ~FNDELAY;
    if (arg) uf->uf_flgs |= FNDELAY;

    return 0;
}

/*
 *	Implement SIOCGIFCONF function
 */

static int ifconf(arg)
struct ifconf *arg;
{
#if SYS_T20
  return -1;			/* Not implemented yet */
#else
  return -1;
#endif
}

int
ioctl(fd, request, arg)
int fd, request;
char *arg;
{
    extern int _nread();
    struct _ufile *uf;
    int ret;
    struct _tty *tp;		/* For functions requiring a TTY struct */

retry:
    USYS_BEG();
    if (!(uf = _UFGET(fd)))
	USYS_RETERR(EBADF);			/* bad FD given */

    /* Set "tp" to point to a _tty structure, if the function is going to
    ** require a terminal.
    */
    switch (request) {
    case TIOCGETP:	case TIOCSETP:	case TIOCSETN:
    case TIOCHPCL:	case TIOCFLUSH:	case TIOCSCTTY:
    case TIOCGETC:	case TIOCSETC:
    case TIOCSTI:	case TIOCNOTTY:
    case TIOCSBRK:	case TIOCCBRK:
    case TIOCSDTR:	case TIOCCDTR:
    case TIOCGPGRP:	case TIOCSPGRP:
    case TIOCLBIS:	case TIOCLBIC:
    case TIOCLSET:	case TIOCLGET:
    case TIOCGLTC:	case TIOCSLTC:
    case TIOCGETD:	case TIOCSETD:
    case TIOCGWINSZ:	case TIOCSWINSZ:
	    if (!(tp = _uftty(uf)))
		USYS_RETERR(ENOTTY);
	    break;
    }

    /* See what we need to do */
    ret = 0;
    switch (request) {
	/* V6 support for stty() and gtty() */
	case TIOCGETP:		/* Get TTY info - gtty() */
	    ret = cgetp(tp, (struct sgttyb *)arg);
	    break;
	case TIOCSETP:		/* Set TTY info - stty().  Note wait */
	    ret = csetp(tp, (struct sgttyb *)arg, 1);
	    break;

	/* V7 functions */
	case TIOCSETN:		/* Set TTY info, no wait */
	    ret = csetp(tp, (struct sgttyb *)arg, 0);
	    break;
	case TIOCEXCL:		/* Set exclusive-use mode for file */
	case TIOCNXCL:		/* Turn off exclusive-use mode for file */
	case TIOCHPCL:		/* Hang up terminal on last close */
	    ret = 1;			/* None is implemented */
	    break;
	case TIOCFLUSH:		/* Flush buffered TTY I/O */
	    ret = cflush(tp);
	    break;
	case TIOCGETC:		/* Get special TTY characters */
	    ret = cgetc(tp, (struct tchars *)arg);
	    break;
	case TIOCSETC:		/* Set special TTY characters */
	    ret = csetc(tp, (struct tchars *)arg);
	    break;


	/* All remaining functions are BSD specific! */
	case TIOCSTI:			/* Simulate terminal input */
	    ret = csti(tp, arg);
	    break;

	case TIOCSBRK:		/* Set break bit for terminal */
	case TIOCCBRK:		/* Clear break bit for terminal */
	case TIOCSDTR:		/* Set DTR for terminal */
	case TIOCCDTR:		/* Clear DTR for terminal */
	    ret = -1;
	    break;

	case TIOCGPGRP:		/* Get process group for terminal */
	    *(int *)arg = getpid();	/* Just use our pid for now */
	    break;

	case TIOCSPGRP:		/* Set process group for terminal */
	    if (getpid() != *(int *)arg)
		ret = -1;	/* Set to current pid is only legal value */
	    break;

	case FIONREAD:		/* Return # unread chars on file/pipe/TTY */
	    ret = _nread(uf, (long *)arg);
	    break;

	case FIONBIO:		/* Set [non-]blocking I/O */
	    ret = fndelay(uf, (long *)arg);
	    break;

	/* Hack bits in local TTY mode word */
	case TIOCLBIS: ret = clbis(tp, (int *)arg); break; /* Set bit */
	case TIOCLBIC: ret = clbic(tp, (int *)arg); break; /* Clr bit */
	case TIOCLSET: ret = clset(tp, (int *)arg); break; /* Set wd */
	case TIOCLGET: ret = clget(tp, (int *)arg); break; /* Get wd */

	case TIOCGLTC:		/* Get BSD-special TTY characters */
	    ret = cgltc(tp, (struct ltchars *)arg);
	    break;
	case TIOCSLTC:		/* Set BSD-special TTY characters */
	    ret = csltc(tp, (struct ltchars *)arg);
	    break;

	case TIOCGWINSZ:	/* Get BSD4.3 TTY window size */
	    ret = cgwinsz(tp, (struct winsize *)arg);
	    break;
	case TIOCSWINSZ:	/* Set BSD4.3 TTY window size */
	    ret = cswinsz(tp, (struct winsize *)arg);
	    break;

	case TIOCGETD:		/* Get TTY line discipline */
	    *(int *)arg = tp->tt_ldisc;
	    break;
	case TIOCSETD:		/* Set TTY line discipline */
	    if (*(int *)arg != tp->tt_ldisc)	/* Cannot change */
		ret = -1;
	    break;

	case TIOCNOTTY:		/* void terminal association */
	    ret = -1;		/* Not implemented for now */
	    break;

	case TIOCSCTTY:		/* Become controlling terminal */
	    ret = csctty(tp);
	    break;

	case SIOCGIFCONF:	/* return interface configuration */
	    ret = ifconf((struct ifconf *)arg);
	    break;

	/* Unknown ioctl() function! */
	default:
	    USYS_RETERR(EINVAL);		/* invalid argument */
    }
    if (ret == -2) {		/* Was call interrupted? */
	if (USYS_END() < 0) {	/* Yes, see whether OK to restart call */
	    errno = EINTR;	/* No, must abort */
	    return -1;
	} else goto retry;
    }
    if (ret == -1)			/* Not everything sets errno yet */
	USYS_RETERR(EINVAL);
    USYS_RET(ret);
}

#endif /* T20+10X+T10+CSI+WTS */
  