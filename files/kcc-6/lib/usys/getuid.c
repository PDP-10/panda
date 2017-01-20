/*
**	GETUID, GETEUID - get user identity
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.3, 5-Jul-1987
**	(c) Copyright Ian Macky, SRI International 1987
*/

#include <c-env.h>
#include <errno.h>

#if SYS_T20+SYS_10X		/* Systems supported for */

#if SYS_T20+SYS_10X
#include <jsys.h>
#endif

int getuid()
{
#if SYS_T20+SYS_10X
    int ablock[5];

    jsys(GJINF, ablock);	/* get job info */
    return ablock[1] & 077777777777; /* user# in AC1 without constant 5B2 */
#else
    return -1;
#endif
}

int geteuid()
{
    return getuid();
}

int getruid()
{
    return getuid();
}

int getgid()
{
    return 0;
}

int getegid()
{
    return getgid();
}

int getrgid()
{
    return getgid();
}

int setuid(uid)
int uid;
{
    if (uid == getuid()) return 0;
    errno = EPERM;
    return -1;
}

int setgid(gid)
int gid;
{
    if (gid == getgid()) return 0;
    errno = EPERM;
    return -1;
}

int seteuid(euid)
int euid;
{
    if (euid == geteuid()) return 0;
    errno = EPERM;
    return -1;
}

int setruid(ruid)
int ruid;
{
    if (ruid == getruid()) return 0;
    errno = EPERM;
    return -1;
}

int setreuid(ruid, euid)
int ruid, euid;
{
    if (setruid(ruid)) return -1;
    return seteuid(euid);
}

int setegid(egid)
int egid;
{
    if (egid == getegid()) return 0;
    errno = EPERM;
    return -1;
}

int setrgid(rgid)
int rgid;
{
    if (rgid == getrgid()) return 0;
    errno = EPERM;
    return -1;
}

int setregid(rgid, egid)
int rgid, egid;
{
    if (setrgid(rgid)) return -1;
    return setegid(egid);
}

#endif /* T20+10X */
