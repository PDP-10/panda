/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* Definitions for UDP hackery */

/* IP version number for these formats */
#define IP_VERSION	4		/* This is IP version 4 */

/* IP header fields (IP version 4) */
struct ip_header {
    unsigned	ver		: 4;	/* Version of IP */
    unsigned	ihl		: 4;	/* IP header length */
    unsigned	tos		: 8;	/* Type of service stuff */
    unsigned	len		: 16;	/* Packet length */
    unsigned			: 4;
    unsigned	sid		: 16;	/* Segment ID */
    unsigned	frg		: 16;	/* Fragmentation stuff */
    unsigned			: 4;
    unsigned	ttl		: 8;	/* Time to live */
    unsigned	pro		: 8;	/* IP protocol number */
    unsigned	chk		: 16;	/* IP checksum */
    unsigned			: 4;
    unsigned	sh		: 32;	/* Source host */
    unsigned			: 4;
    unsigned	dh		: 32;	/* Destination host */
    unsigned			: 4;
};

#define IP_HLEN (sizeof(struct ip_header))

/* Minimum and maximum sizes of IP header */
#define IP_MINIHL   5			/* See IP spec */
#define IP_MAXIHL   15			/* See IP spec */

/* Minimum packet size that all hosts are assumed to accept (in "octets"). */
#define	IP_MINPKT   576

/* IP protocol number of UDP */
#define	UDP_PROTOCOL 17

/* UDP header fields */
struct udp_header {
    unsigned	sp		: 16;	/* Source port */
    unsigned	dp		: 16;	/* Destination port */
    unsigned			: 4;
    unsigned	ln		: 16;	/* UDP datagram length */
    unsigned	ck		: 16;	/* UDP checksum */
    unsigned			: 4;
};

#define UDP_HLEN (sizeof(struct udp_header))

/* Length of data area in 8 (well, 9) bit bytes */
#ifndef	UDP_DLEN
# define UDP_DLEN   512			/* See IP spec */
#endif

/*
 * Size of entire packet buffer in 32 (well, 36) bit words.
 * This consists of:
 *	One (36 bit) word for Twenex SNDIN%/RCVIN% count word;
 *	IP_MAXIHL (32 bit) words for IP header;
 *	UDP_HLEN (8 bit) bytes for UDP header;
 *	UDP_DLEN (8 bit) bytes for UDP data.
 */
#ifndef	UDP_BSIZE
# define UDP_BSIZE   (1+IP_MAXIHL+((UDP_HLEN+UDP_DLEN+3)/4))
#endif

/* Length of a UDP buffer object in 8/9 bit bytes */
#define UDP_BLEN    (UDP_BSIZE*4)

/* Macros for casting a (char *) buffer into the appropriate type */
#define IP_HEADER(p)  ((struct ip_header *) ((p)+4))
#define UDP_HEADER(p) ((struct udp_header *) ((p)+(IP_HEADER(p)->ihl+1)*4))
#define UDP_DATA(p)   (((p)+(IP_HEADER(p)->ihl+1)*4+UDP_HLEN))

/* Internet Queue Handle, reused for all UDP "connections" */
extern int udpiqh;

/* Out of range value for Internet Queue Handle */
#define UDP_BADIQH (-1)

/* Routines */
extern int udp_init(int,int), udp_fini(void), udp_chksum(char *);
extern int udp_recv(char *,int,int), udp_send(char *), udp_rxmit(char *);
extern void udp_binit(char *), udp_sort(int count,int *);
