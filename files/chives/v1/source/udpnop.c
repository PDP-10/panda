/*
 * Copyright (c) 1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * No-op versions of UDP routines for non-net machines.
 * General idea is that this should be like doing I/O with NUL:.
 */

#include "udp.h"

int udp_init()		{ return(1); }	/* Init always ok */
int udp_fini()		{ return(1); }	/* Cleanup always ok */
int udp_recv()		{ return(0); }	/* Never anything to read */
int udp_send()		{ return(1); }	/* Bitbucket always available */
int udp_rxmit()		{ return(1); }	/* to accept outgoing messages */
int udp_chksum()	{ return(0); }	/* Checksum always ok */
void udp_sort()		{ return;    }	/* Nothing to sort without IP */

/* Minimal buffer init, just enough to keep caller from barfing. */
void udp_binit(p)
    char *p;
{
    IP_HEADER(p)->ihl = IP_MINIHL;	/* Minimal length IP header */
    UDP_HEADER(p)->ln = UDP_HLEN;	/* Initial UDP header length */
}
