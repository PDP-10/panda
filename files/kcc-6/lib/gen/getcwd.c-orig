/*
 *	GETCWD - get current working directory
 *	GETWD - variation on same
 *
 *	Copyright (C) 1987 by Ian Macky, SRI International
 */

#include <c-env.h>
#if SYS_T20			/* Systems supported for */

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/param.h>		/* For MAXPATHLEN only */
#if SYS_T20
#include <jsys.h>
#endif

char *
getcwd(buf, size)
char *buf;
int size;
{
#if SYS_T20
    int ablock[5];
    char *malloc(), temp[MAXPATHLEN];		/* for raw dir spec */

    if (!buf && !(buf = malloc(size))) {	/* if no buffer given, */
	errno = ENOMEM;				/* allocate one, returning */
	return NULL;				/* null if we can't. */
    }
    jsys(GJINF, ablock);			/* Get connected dir in AC2 */
    ablock[1] = (int) (temp - 1);		/* point to 1 before top */
    if (jsys(DIRST, ablock) <= 0) {		/* write directory to temp */
	errno = ENOENT;				/* failed to!  this error */
	return NULL;				/* code will have to do. */
    }
    *buf = '\0';
    strncat(buf, temp, size);			/* copy what we can */
    return buf;					/* return ptr to buf we used */
#else
    return NULL;
#endif
}

char *
getwd(pathname)
char *pathname;
{
    char *cp;
    if ((cp = getcwd(pathname, MAXPATHLEN)) == NULL) {
	*pathname = '\0';		/* If error, deposit err string */
	strncat(pathname, strerror(errno), MAXPATHLEN);
    }
    return cp;
}
#endif /* T20 */
