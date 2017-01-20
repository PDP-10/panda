/* <TRMCAP.H> - declarations for TERMCAP routines.
**
**	(c) Copyright Ken Harrenstien 1989
**
**	This is not a standard header file, but was developed for
** the KCC PDP-10 C implementation in order to encourage the use of
** header files for all library routines.
*/

#ifndef _TRMCAP_INCLUDED
#define _TRMCAP_INCLUDED

/* Location of TERMCAP data file; system dependent. */
#ifndef _TERMCAPFILE
#include <c-env.h>		/* Get SYS_ definitions */
#if SYS_T20+SYS_T10+SYS_CSI
#define _TERMCAPFILE "C:TRMCAP.DAT"	/* TOPS-20 location */
#else
#define _TERMCAPFILE "/etc/termcap"	/* Standard location */
#endif
#endif

/* Global variables (boo hiss!) */
extern char PC,		/* Pad character */
	*BC,		/* Move-back command string */
	*UP;		/* Move-up command string */
extern short ospeed;	/* Output speed as per gtty() */

#ifdef __STDC__
extern int tgetent(char *bp, char *name);		/* Get term entry */
extern int tgetnum(char *id);				/* Get numeric cap */
extern int tgetflag(char *id);				/* Get boolean cap */
extern char *tgetstr(char *id, char **area);		/* Get string cap */
extern char *tgoto(char *cm,		 /* Make cursor movement string */
	int destcol, int destline);
extern void tputs(char *cp, int affcnt, int (*outc)());	/* Output cmd string */

#else
extern int tgetent(), tgetnum(), tgetflag();
extern char *tgetstr(), *tgoto();
extern void tputs();
#endif

#endif /* ifndef _TRMCAP_INCLUDED */
