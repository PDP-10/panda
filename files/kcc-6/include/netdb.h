/* <NETDB.H> - definitions for BSD network library routines
**
**	(c) Copyright Ken Harrenstien 1989
**
**	The BSD network routines are only partially supported.
*/

#ifndef _NETDB_INCLUDED
#define _NETDB_INCLUDED

#pragma private define gethostent	gthent	/* linker disambiguation */
#pragma private define gethostbyname	gthnam
#pragma private define gethostbyaddr	gthadr

#pragma private define gethostid	gthsid
#pragma private define gethostname	gthstn

#pragma private define sethostent	sthste

struct hostent {
    char *h_name;		/* official name of host */
    char **h_aliases;		/* alias list */
    int h_addrtype;		/* address type */
    int h_length;		/* length of address */
    char *h_addr;		/* address */
};

#define AF_INET		2	/* internet address type */
#define INET_ADDR_SIZE	4	/* size (in chars) of one */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* cgen:gethst.c */
extern struct hostent *gethostbyname P_((char *name));
extern struct hostent *gethostbyaddr P_((char *addr,int len,int type));
extern struct hostent *gethostent P_((void));
extern void sethostent P_((int stayopen));
extern void endhostent P_((void));
extern long gethostid P_((void));
extern int gethostname P_((char *name,int namelen));

#undef P_

#endif /* ifndef _NETDB_INCLUDED */
