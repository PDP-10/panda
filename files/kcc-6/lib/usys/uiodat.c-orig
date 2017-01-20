/* UIODAT - USYS I/O data definitions
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.18, 11-Aug-1988
**	(c) Copyright Ken Harrenstien & Ian Macky, SRI International 1987
**	Edits for ITS:  Copyright (C) 1988 Alan Bawden
**
** This module contains declarations for various data structures needed by
** the USYS routines, particularly the I/O functions, which must be global.
** They are still "internal" from the viewpoint of the user and must not
** be referenced by anything but USYS calls.
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported for */

#include <stddef.h>		/* for NULL */
#include <sys/usysio.h>
#include <sys/usytty.h>		/* Includes <sgtty.h> and <sys/ioctl.h> */

/*
 * UF (Unix File) storage.
 *		We maintain a single active UF for each operating-system
 *	channel/JFN.  A UF is separate from a FD so that we can have
 *	several FDs referencing the same UF, as happens inside the UNIX
 *	kernel.
 *
 *	FDs can be numbered from 0 to OPEN_MAX-1 inclusive, as on UNIX.
 *	A NULL UF pointer means that FD is unassigned.
 *
 *	The _uffd table determines whether a FD is open or not.
 *	The uf_nopen component determines whether a UF is open or not.
 *	If not open ( >0), all other components of that UF are invalid.
 */

	/* Per-FD storage.  Only one such table, for mapping FD into UF. */
struct _ufile *_uffd[OPEN_MAX];	/* Indexed by FD, gets pointer to UF! */

	/* Per-UF storage. */
struct _ufile _uftab[OPEN_UF_MAX];	/* Static table of max UFs */	

/* Controlling TTY variables */

/* On T20/10X there can be only one controlling terminal
** (i.e. source of terminal interrupts).  This is always _ttys[0].
** We only attempt full emulation for this terminal rather than for all
** TTY: devices, but up to _NTTYS-1 other random TTY devices are possible.
*/
#define ctl(a) (a&037)
struct _tty _ttys[_NTTYS];	/* Controlling TTY plus any others */

/* Default internal terminal structure, used to initialize _tty structs. */
struct _tty _deftty = {
	NULL, 0,		/* Zero UF ptr ensures more initialization */
#if SYS_T20+SYS_10X
	0, 0, 0, 0,				/* Various T20 words */
	{-1,-1,'\177',ctl('U'),EVENP|ODDP|CRMOD|ECHO},	/* sgtty */
	{-1, -1, ctl('Q'), ctl('S'), ctl('Z'), -1},	/* tchars */
	NTTYDISC, 0,					/* line disc, mode */
	{ctl('C'),ctl('C'),ctl('R'),ctl('O'),ctl('W'),ctl('V')}	/* ltchars */

#elif SYS_T10+SYS_CSI
	0,					/* T10: UDX # (.UXTRM+nnn) */
	{-1,-1,'\177',ctl('U'),EVENP|ODDP|CRMOD|ECHO},	/* sgtty */
	{-1, -1, ctl('Q'), ctl('S'), ctl('Z'), -1},	/* tchars */
	NTTYDISC, 0,					/* line disc, mode */
	{ctl('C'),ctl('C'),ctl('R'),ctl('O'),-1,-1}	/* ltchars */

#else	/* Defaults as per BSD UNIX */
	/* 0, 0, 0, 0,	 No T20/10X words */
	{B9600, B9600, '#', '@', CRMOD|ECHO},
	{'\177', ctl('\\'), ctl('Q'), ctl('S'), ctl('D'), -1},
	OTTYDISC, 0,
	{ctl('Z'),ctl('Y'),ctl('R'),ctl('O'),ctl('W'),ctl('V')}
#endif
};

/*	I/O buffer data and routines.
**		The I/O buffers are done as static data areas for
**	now because the syscalls cannot invoke malloc() as needed.
*/
static struct _iob *iobinuse[UIO_NBUFS];	/* For in-use tracking */
static struct _iob _iobs[UIO_NBUFS];		/* Gross! */

struct _iob *
_iobget()
{
    register int i;
    for (i = UIO_NBUFS; --i >= 0;)
	if (iobinuse[i] == NULL)
	    return iobinuse[i] = &_iobs[i];
    return NULL;		/* No more buffers */
}

void
_iobfre(b)
struct _iob *b;
{
    extern void _panic();	/* In URT */
    register int i = b - _iobs;

    if (iobinuse[i] != b)
	_panic("_iobfre() - bad arg");
    iobinuse[i] = NULL;
}

/* Miscellaneous */

#if SYS_T10+SYS_CSI+SYS_WTS
int _filopuse = 0;	/* Set non-zero to use FILOP. UUO */
#if SYS_CSI
int _trmopuse = SYS_CSI;	/* Non-zero to use TRMOP. TTY I/O */
#endif
#endif

#endif /* T20+10X+T10+CSI+WAITS+ITS */
