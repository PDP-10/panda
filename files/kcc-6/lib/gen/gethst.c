/*
 *	GETHOSTENT - gethostent, gethostbyaddr, gethostbyname,
 *		     sethostent, endhostent, gethostid, gethostname
 *
 *	Copyright (c) 1986 by Ian Macky, SRI International
 */

#include <c-env.h>
#if SYS_T20			/* Systems supported for */

#include <string.h>
#include <stdio.h>
#include <netdb.h>
#include <jsys.h>

#define MAX_HOSTNAME	80		/* good enough for a hostname? */

char gh_hostname[MAX_HOSTNAME];
char gh_address[INET_ADDR_SIZE];

struct hostent gh_hentry = {
    gh_hostname,			/* h_name = official hostname */
    NULL,				/* h_aliases */
    AF_INET,				/* h_addrtype = only type defined */
    INET_ADDR_SIZE,			/* h_length = length of address */
    gh_address				/* h_address = ptr to address */
};

/* Routine to try GTDOM followed by GTHST, since GTDOM is more
 * accurate, but GTHST is a good fallback. Preserves AC2, since it
 * can potentially be clobbered by a failing GTDOM
 */
static int gtdom(acs)
int acs[5];
{
  int savac2 = acs[2];

  if (!jsys(GTDOM, acs)) {
    acs[2] = savac2;
    if (!jsys(GTHST, acs)) return 0;
  }
  return 1;
}

struct hostent *
gethostbyname(name)		/* Actually _gthnam() */
char *name;
{
#if SYS_T20+SYS_10X
    int ablock[5];
    unsigned host;
    char *cp;

    ablock[1] = _GTHSN;
    ablock[2] = (int) (name - 1);
    if (!gtdom(ablock)) return NULL;
    cp = gh_address;				/* where to store the addr */
    host = ablock[3];				/* right-justified host# */
    *cp = (host >> 3*8) & 0377;
    *++cp = (host >> 2*8) & 0377;		/* store the four octets */
    *++cp = (host >> 8) & 0377;			/* as sequential chars */
    *++cp = host & 0377;
    ablock[1] = _GTHNS;				/* want official name now */
    ablock[2] = (int) (gh_hostname - 1);	/* where to put it */
    ablock[3] = host;				/* host# */
    if (!gtdom(ablock))			/* if can't get the official */
	strcpy(gh_hostname, name);		/* one then use theirs... */
    return &gh_hentry;				/* what they gave us */
#else
    return NULL;
#endif
}

struct hostent *
gethostbyaddr(addr, len, type)		/* actually _gthadr() */
char *addr;
int len, type;
{
#if SYS_T20+SYS_10X
    int ablock[5];
    unsigned host;
    char *cp;

    if (type != AF_INET || len != INET_ADDR_SIZE) return NULL;
    cp = addr;
    host = (*cp << 3*8) | (*++cp << 2*8) | (*++cp << 8) | *++cp;
    ablock[1] = _GTHNS;
    ablock[2] = (int) (gh_hostname - 1);
    ablock[3] = host;
    if (!gtdom(ablock)) return NULL;
    memcpy(gh_address, addr, len);	/* copy the address */
    return &gh_hentry;
#else
    return NULL;
#endif
}

struct hostent *
gethostent()			/* actually _gthent() */
{
    return NULL;
}

void
sethostent(stayopen)
int stayopen;
{
}

void
endhostent()
{
}

/*
 *	return 32-bit unique host identifier (which is usually (as in this
 *	case) the internet address), or 0 on failure.
 */

long gethostid()
{
    int ablock[5];

    ablock[1] = monsym(".GTHSZ");
    return (long)((gtdom(ablock)) ? ablock[4] : 0);
}

/*
 *	store the local hostname in the given users buffer
 */

#define GETHOSTNAME_MAX_HOSTNAME	512

int gethostname(name, namelen)
char *name;
int namelen;
{
    char buf[GETHOSTNAME_MAX_HOSTNAME];
    int ablock[5];

    ablock[1] = monsym(".GTHSZ");
    if (!gtdom(ablock))
	return -1;
    ablock[1] = monsym(".GTHNS");	/* return name given number */
    ablock[2] = (int) (buf - 1);	/* where to put it */
    ablock[3] = ablock[4];		/* AC3 gets host# from 1st call */
    if (!gtdom(ablock))
	return -1;
    strncpy(name, buf, namelen);	/* copy to user buffer */
    return 0;				/* 0 means success */
}

#endif /* SYS_T20 */
