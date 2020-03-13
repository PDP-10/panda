/* <SYS/IOCTL.H> - definitions for ioctl(2)
**
**	(c) Copyright Ken Harrenstien 1989
**
**	As described by 4.3BSD UPM, plus old V6/V7 stuff.
*/

#ifndef	_SYS_IOCTL_INCLUDED
#define	_SYS_IOCTL_INCLUDED

#ifndef _SGTTY_INCLUDED
#include <sgtty.h>	/* sgtty.h and sys/ioctl.h include each other */
#endif /* ifndef _SGTTY_INCLUDED */

/* Argument structures for some ioctl functions */
struct tchars {
    char t_intrc;		/* interrupt */
    char t_quitc;		/* quit */
    char t_startc;		/* start output */
    char t_stopc;		/* stop output */
    char t_eofc;		/* end-of-file */
    char t_brkc;		/* input delimiter (like nl) */
};

struct ltchars {
    char t_suspc;		/* stop process signal */
    char t_dsuspc;		/* delayed stop process signal */
    char t_rprntc;		/* reprint line */
    char t_flushc;		/* flush output (toggles) */
    char t_werasc;		/* word erase */
    char t_lnextc;		/* literal next character */
};

struct winsize {		/* Window size - BSD4.3 addition */
    unsigned ws_row;		/* Height in chars (# lines) */
    unsigned ws_col;		/* Width  in chars (# columns) */
    unsigned ws_xpixel;		/* Width  in pixels */
    unsigned ws_ypixel;		/* Height in pixels */
};

/* The following copied from /usr/include/sys/ttydefaults.h */
 
/*
 * Defaults on "first" open.
 */
#define	TTYDEF_IFLAG	(BRKINT | ISTRIP | ICRNL | IMAXBEL | IXON | IXANY)
#define TTYDEF_OFLAG	(OPOST | ONLCR | OXTABS)
#define TTYDEF_LFLAG	(ECHO | ICANON | ISIG | IEXTEN | ECHOE|ECHOKE|ECHOCTL)
#define TTYDEF_CFLAG	(CREAD | CS7 | PARENB | HUPCL)
#define TTYDEF_SPEED	(B9600)

/*
 * Control Character Defaults
 */
#define CTRL(x)	(x&037)
#define	CEOF		CTRL('d')
#define	CEOL		((unsigned)'\377')	/* XXX avoid _POSIX_VDISABLE */
#define	CERASE		0177
#define	CINTR		CTRL('c')
#define	CSTATUS		((unsigned)'\377')	/* XXX avoid _POSIX_VDISABLE */
#define	CKILL		CTRL('u')
#define	CMIN		1
#define	CQUIT		034		/* FS, ^\ */
#define	CSUSP		CTRL('z')
#define	CTIME		0
#define	CDSUSP		CTRL('y')
#define	CSTART		CTRL('q')
#define	CSTOP		CTRL('s')
#define	CLNEXT		CTRL('v')
#define	CDISCARD 	CTRL('o')
#define	CWERASE 	CTRL('w')
#define	CREPRINT 	CTRL('r')
#define	CEOT		CEOF
/* compat */
#define	CBRK		CEOL
#define CRPRNT		CREPRINT
#define	CFLUSH		CDISCARD

/*
 *	ioctl() function definitions
 */
/* Functions to support V6 gtty/stty calls */
#define	TIOCGETP	0	/* Get parameters -- V6/V7 gtty() */
#define	TIOCSETP	1	/* Set parameters -- V6/V7 stty() */

/* Functions to support V7 ioctl() */
#define	TIOCSETN	2	/* V7:   as above, but no flushtty */
#define	TIOCEXCL	3	/* V7: set exclusive use of tty */
#define	TIOCNXCL	4	/* V7: reset excl. use of tty */
#define	TIOCHPCL	5	/* V7: hang up on last close */
#define	TIOCFLUSH	6	/* V7: flush buffers */

/* All other functions are for BSD (4.3) */
#define	TIOCSTI		7	/* simulate terminal input */
#define	TIOCSBRK	8	/* set   break bit */
#define	TIOCCBRK	9	/* clear break bit */
#define	TIOCSDTR	10	/* set   data terminal ready */
#define	TIOCCDTR	11	/* clear data terminal ready */
#define	TIOCGPGRP	12	/* get pgrp of tty */
#define	TIOCSPGRP	13	/* set pgrp of tty */
#define	TIOCGETC	14	/* get special characters */
#define	TIOCSETC	15	/* set special characters */
#define TIOCLBIS	16	/* set   bits in local mode word */
#define TIOCLBIC	17	/* clear bits in local mode word */
#define TIOCLGET	18	/* get local mode mask */
#define TIOCLSET	19	/* set local mode mask */
#define	TIOCSLTC	20	/* set local special chars */
#define	TIOCGLTC	21	/* get local special chars */

#define	FIONREAD	22	/* get # bytes to read */

#define TIOCGETD	23	/* Get line discipline */
#define TIOCSETD	24	/* Set line discipline */

#define TIOCGWINSZ	25	/* Get window size info */
#define TIOCSWINSZ	26	/* Set window size info (maybe gen SIGWINCH) */

#define FIONBIO		27	/* set/clear non-blocking I/O */

#define TIOCNOTTY	28	/* detach terminal */
#define SIOCGIFCONF	29	/* return interface configuration of system */

#define TIOCSCTTY	30	/* set become controlling terminal */

/*
 *	Old sg_flags word flags for stty/gtty
 */

#define ALLDELAY	0177400		/* Delay algorithm selection */
#define BSDELAY		0100000		/* Select backspace delays */
#define BS0		 0
#define BS1		0100000
#define VTDELAY		 040000		/* for,-feed/v-tab delay */
#define FF0		  0
#define FF1		 040000
#define CRDELAY		 030000		/* carriage-return delay */
#define CR0		  0
#define CR1		 010000
#define CR2		 020000
#define CR3		 030000
#define TBDELAY		  06000		/* tab delays */
#define TAB0		   0
#define TAB1		  01000
#define TAB2		  04000
#define XTABS		  06000
#define NLDELAY		  01400		/* new-line delays */
#define NL0		    0
#define NL1		   0400
#define NL2		  01000
#define NL3		  01400
#define EVENP		   0200		/* even parity allowed on input */
#define ODDP		   0100		/* odd parity allowed on input */
#define ANYP		   0300		/* any parity allowed on input */
#define RAW		    040		/* wake on all chars, 8-bit input */
#define CRMOD		    020		/* map CR->LF; echo LF or CR as CRLF */
#define ECHO		    010		/* echo (full duplex) */
#define LCASE		     04		/* map upper case to lower case */
#define CBREAK		     02		/* return each char as soon as typed */
#define TANDEM		     01		/* automatic flow control */

/* Bits for BSD local mode word */
#define LCRTBS	01	/* Backspace on erase rather than echoing erase */
#define LPRTERA	02	/* Printing terminal erase mode */
#define LCRTERA 04	/* Erase char echoes as BS-SP-BS */
#define LTILDE	010	/* Convert ~ to ` on output (for Hazeltines) */
#define LMDMBUF	020	/* Stop/start output when carrier drops */
#define LLITOUT	040	/* Suppress output translations */
#define LTOSTOP	0100	/* Send SIGTTOU for background output */
#define LFLUSHO	0200	/* Output is being flushed */
#define LNOHANG	0400	/* Don't send hangup when carrier drops */
#define LETXACK	01000	/* Diablo style buffer hacking (??) */
#define LCRTKIL	02000	/* Use BS-SP-BS to erase entire line on line kill */
#define LPASS8	04000	/* Pass all 8 bits through on input, in any mode */
#define LCTLECH	010000	/* Echo input control chars as ^X (DEL as ^?) */
#define LPENDIN	020000	/* Retype pending input at next read or input char */
#define LDECCTQ	040000	/* Only ^Q restarts after ^S, like DEC systems */
#define LNOFLSH	0100000	/* No output flush on signal */

/* Line discipline values */
#define OTTYDISC 0	/* Old V7-style discipline (must be zero) */
#define NTTYDISC 1	/* New BSD-style discipline */
#define NETLDISC 2	/* high-speed "net" discipline (not supported) */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

extern int ioctl P_((int fd,int request,char *arg));

#undef P_

#endif /* ifndef _SYS_IOCTL_INCLUDED */

/*
 * #define TTYDEFCHARS to include an array of default control characters.
 */
#ifdef TTYDEFCHARS
cc_t	ttydefchars[NCCS] = {
	CEOF,	CEOL,	CEOL,	CERASE, CWERASE, CKILL, CREPRINT, 
	_POSIX_VDISABLE, CINTR,	CQUIT,	CSUSP,	CDSUSP,	CSTART,	CSTOP,	CLNEXT,
	CDISCARD, CMIN,	CTIME,  CSTATUS, _POSIX_VDISABLE
};
#undef TTYDEFCHARS
#endif /* TTYDEFCHARS */
