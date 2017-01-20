/* <SYS/USYTTY.H> - definitions for KCC USYS TTY support
**
**	(c) Copyright Ken Harrenstien 1989
**	(c) Copyright Ken Harrenstien, SRI International 1987
**
*/

#ifndef _SYS_USYTTY_INCLUDED
#define _SYS_USYTTY_INCLUDED

#include <c-env.h>
#include <sgtty.h>		/* Must have this junk (includes sys/ioctl.h)*/

#ifndef _NTTYS			/* # of terminals we can handle */
#define _NTTYS 3		/* Controlling terminal plus 2 random devs */
#endif

struct _tty {
	struct _ufile *tt_uf;	/* USYS: Unix File that TTY is open on */
	int tt_flags;		/* USYS: flags for various internal uses */
#if SYS_T20+SYS_10X
	int tt_ccoc[2];		/* T20: saved CCOC words */
	int tt_jfnmod;		/* T20: saved JFN mode word */
	int tt_tiw;		/* T20: saved terminal interrupt word */
#endif
#if SYS_T10+SYS_CSI
	int tt_udx;		/* T10: UDX for this terminal */
#endif
	struct sgttyb sg;	/* V6: i/o speeds, erase/kill chars, flags */
	struct tchars tc;	/* V7: special chars */
	int tt_ldisc;		/* BSD: Current line discipline */
	int tt_lmode;		/* BSD: Local mode word */
	struct ltchars lt;	/* BSD: more special chars */	
	struct winsize ws;	/* BSD4.3: window size */
};
extern struct _tty
	_deftty,	/* Default data when initializing struct */
	_ttys[];	/* Data for open terminals */
#define _cntrl_tty (&_ttys[0])	/* First struct is that of controlling term */

#endif /* ifndef _SYS_USYTTY_INCLUDED */
