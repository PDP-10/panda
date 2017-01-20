/*
**	TMPNAM - create a unique temporary file name
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.6, 13-Apr-1988
**	(c) Copyright Ian Macky, SRI International 1986
**
**	This code conforms with the description of the tmpnam()
**	function in the ANSI X3J11 C language standard, section
**	4.9.4.4
**
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported */

#include <stdioi.h>
#include <time.h>
#include <sys/file.h>		/* For access() */
#include <unistd.h>

#if SYS_T20
#define TMPFMT(pid, ver) "/tmp/tmpnam-%o.tmp.%d", pid, ver
#elif SYS_10X
#define TMPFMT(pid, ver) "TMPNAM-%o.TMP.%d", pid, ver
#else				/* nnnCmm.TMP */
#define TMPFMT(pid, ver) "%03.3dC%02.02d.TMP", pid, (ver)&0177
#endif

char *
tmpnam(s)
char *s;
{
    static char tmpbuf[L_tmpnam];	/* storage for filename */
    static int newver = 0;
    int i;
    int pid = getpid();

    if (!s) s = tmpbuf;		/* if they didn't supply a buf, use ours */
    if (newver == 0)
	newver = (int)time(0) & 0777;	/* Get random non-neg start seed */

    for (i = 0; i < TMP_MAX; ++i) {	/* Avoid infinite loop */
	sprintf(s, TMPFMT(pid, ++newver));	/* Make a filename */
	if (access(s, F_OK) != 0)	/* Check for existence */
	    return s;			/* Doesn't exist, win. */
    }
    return NULL;		/* Failed... */
}

#endif /* T20+10X+T10+CSI+WAITS+ITS */
