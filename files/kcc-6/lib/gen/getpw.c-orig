/*
**	GETPW	- Get user name from user ID.
**
**	(c) Copyright Ken Harrenstien, SRI International 1989
**
**	Supports V7 getpw(), plus 4.3BSD getpwuid() and getpwnam().
**
**	Note: getpwent, setpwent, endpwent and setpwfile are unsupported.
**	Those are primarily system maintenance functions anyway.
**
*/

#include <c-env.h>
#if SYS_T20+SYS_10X		/* Systems supported for */

#include <pwd.h>
#include <stdio.h>		/* For filename sizes and aborting */
#include <string.h>
#include <stdlib.h>

#if SYS_T20+SYS_10X
#include <macsym.h>
#include <jsys.h>
#endif /* T20+10X */

#ifdef FILENAME_MAX
#define BUFLEN (FILENAME_MAX*2)
#elif defined(L_cuserid)
#define BUFLEN (L_cuserid+L_ctermid)
#else
#define BUFLEN (500)
#endif

int
getpw(uid, buf)
int uid;
char *buf;
{
#if SYS_T20+SYS_10X
    int acs[5];
    acs[1] = (int)(buf-1);
    acs[2] = uid;
    return (jsys(DIRST, acs) > 0) ? 0 : -1;
#else
    return -1;
#endif
}

static char pwdbuf[BUFLEN];	/* Static areas for returning results */
static struct passwd zpwd, pwd;

#if SYS_T20+SYS_10X
static void
pwdovfl()
{
    fprintf(stderr,"getpwuid() overflowed static string buffer\n");
    abort();
}
#endif /* T20+10X */

struct passwd *
getpwuid(uid)
int uid;
{
    register char *cp;
    register int i, left = BUFLEN;
    char buf[BUFLEN];		/* Buffer on stack in case overflow */
#if SYS_T20+SYS_10X
    int acs[5];
#endif

    pwd = zpwd;			/* Initialize structure */

#if SYS_T20+SYS_10X
    /* First get user name string */
    if (!getpw(uid, buf))
	return NULL;
    i = strlen(buf);		/* Find length of user name */
    if ((left -= i) <= 0)
	pwdovfl();		/* Would overflow, abort. */
    strcpy(pwdbuf, buf);	/* Copy into static buffer */
    pwd.pw_name = pwdbuf;

#if SYS_T20
    acs[1] = 0;			/* No flags */
    acs[2] = uid;		/* Want login directory # for this user # */
    if (jsys(RCDIR, acs) <= 0)
	return NULL;
    acs[1] = (int) (buf-1);
    acs[2] = acs[3];		/* Find string for this directory # */
    if (jsys(DIRST, acs) <= 0)	/* Get "structure:<directory>" */
	return NULL;
    cp = pwdbuf + i + 1;
    i = strlen(buf);		/* Find length of dir name */
    if ((left -= i) <= 0)
	pwdovfl();		/* Would overflow, abort. */
    strcpy(cp, buf);		/* Copy into static buffer */
    pwd.pw_dir = cp;

    pwd.pw_shell = "SYSTEM:EXEC.EXE";
#else /* 10X */
    if (left < 7)
	pwdovfl();		/* Would overflow, abort. */
    pwd.pw_dir = cp = pwdbuf + i + 1;
    strcat(strcat(strcpy(cp, "DSK:<"), pwd.pw_name), ">");

    pwd.pw_shell = "<SYSTEM>EXEC.SAV";
#endif
    return &pwd;
#else
    return NULL;
#endif
}

struct passwd *
getpwnam(name)
char *name;
{
#if SYS_T20
    int acs[5];
    acs[1] = 0;
    acs[2] = (int)(name-1);
    if (jsys(RCUSR, acs) > 0)
	return getpwuid(acs[3]);
#elif SYS_10X
    int acs[5];
    acs[1] = 0;
    acs[2] = name-1;
    if (jsys(STDIR, acs) >= 3)		/* Skips .+3 if won */
	return getpwuid(acs[1]&_RHALF);	/* Dir # is in RH of AC 1 */
#endif
    return NULL;
}

#endif /* T20+10X */
