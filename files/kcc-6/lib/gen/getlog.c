/*
 *	GETLOGIN - get login username
 *
 *	Copyright (C) 1987 by Ian Macky, SRI International
 */

#include <c-env.h>
#if SYS_T20			/* Systems supported for */

#include <stdio.h>
#if SYS_T20
#include <jsys.h>
#endif

static char _username[L_cuserid];

char *getlogin()
{
    int ablock[5];

    jsys(GJINF, ablock);		/* user# is in AC1 */
    if (!ablock[1]) return NULL;	/* not logged in... */
    ablock[2] = ablock[1];		/* put user# in AC2 */
    ablock[1] = (int) (_username - 1);	/* put the username here */
    jsys(DIRST, ablock);		/* blast it out */
    return _username;			/* return buf where we put it */
}

#endif /* T20 */
