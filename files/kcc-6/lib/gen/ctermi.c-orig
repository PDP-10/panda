/*
 *	CTERMID - return filespec to terminal
 *	CUSERID - return username of owner of process
 *
 *	Copyright (C) 1987 by Ian Macky, SRI International
 */

#include <c-env.h>
#if SYS_T20+SYS_10X		/* Systems supported for */

#include <stdio.h>
#include <string.h>

#if SYS_T20+SYS_10X
#include <jsys.h>
#endif

char *
ctermid(s)
char *s;
{
    static char _termid[L_ctermid];	/* for terminal filespec */
#if SYS_T20+SYS_10X
    if (!s) s = _termid;		/* if no given buf, use ours */
    strcpy(s, "TTY:");			/* this gets you the tty! */
    return s;				/* return pointer to buf */
#else
    return NULL;
#endif
}

char *
cuserid(s)
char *s;
{
    static char _userid[L_cuserid];	/* for username */
#if SYS_T20+SYS_10X
    extern int getuid();		/* syscall */
    int ablock[5];

    if (!s) s = _userid;		/* use our buffer if non supplied */
    ablock[1] = (int) (s - 1);		/* point to 1 before start of buf */
    ablock[2] = getuid();		/* from stat(), returns your user# */
    jsys(DIRST, ablock);		/* write the username to buffer */
    return s;				/* return pointer to buffer we used */
#else
    return NULL;
#endif
}
#endif /* T20+10X */
