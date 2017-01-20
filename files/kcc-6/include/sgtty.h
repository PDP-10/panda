/* <SGTTY.H> - definitions for stty(2), gtty(2), and ioctl(2)
**
**	(c) Copyright Ken Harrenstien 1989
**	(c) Copyright Ian Macky, SRI International 1987
*/

#ifndef _SGTTY_INCLUDED
#define _SGTTY_INCLUDED

#ifndef	_IOCTL_INCLUDED
#include <sys/ioctl.h>	/* sgtty.h and sys/ioctl.h include each other */
#endif /* ifndef _IOCTL_INCLUDED */

struct sgttyb {
    char sg_ispeed;		/* input speed */
    char sg_ospeed;		/* output speed */
    char sg_erase;		/* erase character */
    char sg_kill;		/* kill character */
    int sg_flags;		/* mode flags */
};

/* Line speeds.
**	These are indices into the USYS speed table array and cannot be
** changed indiscriminately.  We keep the UPM-documented values just in
** case there is some poorly-written code which depends on them; they
** are historically derived from the DEC DH-11 terminal multiplexer.
*/
#define B0	0	/* unknown or forced hangup */
#define B50	1
#define B75	2
#define B110	3
#define B134	4	/* 134.5 baud (IBM 2741s) */
#define B150	5
#define B200	6
#define B300	7
#define B600	8
#define B1200	9
#define	B1800	10
#define B2400	11
#define B4800	12
#define B9600	13
#define EXTA	14	/* Used to be DH-11 external speed A */
#define EXTB	15
#define B19200	16	/* New symbols should start here! */
#define B450	17	/* Sigh */

#endif /* ifndef _SGTTY_INCLUDED */

