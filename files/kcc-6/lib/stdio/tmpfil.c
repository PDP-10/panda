/*
**	TMPFILE - create a temporary binary file
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.8, 13-Apr-1988
**	(c) Copyright Ian Macky, SRI International 1986
*/
/*	This code conforms with the description of the tmpfile()
 *	function in the ANSI X3J11 C language standard, section
 *	4.9.4.3
 *
 */

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported */

#include <stdioi.h>
#include <string.h>
#include <time.h>
#include <sys/file.h>		/* for access() */
#include <unistd.h>

#if SYS_T20
#define TMPFMT(pid, ver) "/tmp/tmpfil-%o.TMP-%d;T", pid, ver
#elif SYS_10X
#define TMPFMT(pid, ver) "TMPFIL-%o.%d;T", pid, ver
#else				/* nnnCmm.TMP */
#define TMPFMT(pid, ver) "%03.3dC%02.02d.TMP", pid, (ver)&0177
#endif

FILE *
tmpfile()
{
    FILE *f;
    char name[L_tmpnam];	/* Storage for filename */
    static int newver = 0;
    int pid = getpid();
    int i, opentries = 3;

    if (newver == 0)
	newver = (int)time(0) & 0777;	/* Get random non-neg start seed */

    for (i = 0; i < TMP_MAX; ++i) {	/* Avoid infinite loop */
	sprintf(name, TMPFMT(pid, ++newver));	/* Make a filename */
	if (access(name, F_OK) != 0) {	/* Check for existence */
	    if (f = fopen(name, "w+b"))
		return f;		/* Won! */
	    if (--opentries <= 0)	/* if tried opening too many times, */
		break;			/* give up. */
	}
    }
    return NULL;
}

#endif /* T20+10X+T10+CSI+WAITS+ITS */
