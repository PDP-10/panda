/*
 |	INET(3N) - inet_addr, inet_network
 |
 |	Copyright (C) 1990 by Ian Macky, cisco Systems
 */

#include <c-env.h>

#if SYS_T20				/* Supported systems */
#include <sys/types.h>
#include <limits.h>
#include <stdio.h>
#include <netinet/in.h>
#include <arpa/inet.h>

/*
 |	Take a character string representing the usual "a.b.c.d"
 |	internet address and return it as an in_addr
 */

#define O(byte, position)\
  (((unsigned)(byte) & 0377) << ((position) * CHAR_BIT))

unsigned long
inet_addr(cp)
const char *cp;
{
    int a, b, c, d;
    unsigned long addr;

    switch (sscanf(cp, "%d.%d.%d.%d", &a, &b, &c, &d)) {
	case 4: addr = O(a, 3) | O(b, 2) | O(c, 1) | O(d, 0); break;
	case 3: addr = O(a, 3) | O(b, 2) | (c & 0177777); break;
	case 2: addr = O(a, 3) | (b & 077777777); break;
	case 1: addr = (a & 037777777777); break;
	default:				/* didn't get anything */
	    addr = (unsigned long) -1;		/* -1 for failure */
    }
    return addr;
}

/*
 |	Apparently this is just supposed to be another name for the
 |	same thing...
 */

unsigned long
inet_network(cp)
const char *cp;
{
    return inet_addr(cp);			/* just pass off... */
}

/*
 |
 */

char *inet_ntoa (in)
struct in_addr in;
{
    static char b[18];
    register char *p;

    p = (char *)&in;
#define UC(b)   (((int)b)&0xff)
    (void)snprintf(b, sizeof(b),
	"%d.%d.%d.%d", UC(p[0]), UC(p[1]), UC(p[2]), UC(p[3]));
    return (b);
}

#endif /* SYS_T20 */
