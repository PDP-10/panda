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
#include <ctype.h>
#include <errno.h>
#include <sys/param.h>		/* For MAXPATHLEN only */
#include <sys/urtint.h>
#if SYS_T20
#include <jsys.h>
#include <urtsud.h>
#endif

char *
getcwd(buf, size)
char *buf;
int size;
{
#if SYS_T20
    int ablock[5];
    char temp[MAXPATHLEN];			/* for raw dir spec */
	
    if (!buf) {					/* if no buffer given, */
	errno = EINVAL;				/* set invalid code, */
	return NULL;				/* and return null */
    }
    ablock[1] = (int) (temp - 1);		/* point to 1 before top */
    ablock[2] = _getdir();			/* get current dir */
    if (jsys(DIRST, ablock) <= 0) {		/* write directory to temp */
	errno = EACCES;				/* failed to!  this error */
	return NULL;				/* code will have to do. */
    }
    _fncon(buf, temp, 1, 0);			/* Copy/conv directory name */
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
    if ((cp = getcwd(pathname, MAXPATHLEN)) == NULL)
	/* If error, deposit err string */
	strncpy(pathname, strerror(errno), MAXPATHLEN);
    return cp;
}
#endif /* T20 */
