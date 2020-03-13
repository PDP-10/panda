/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* Conditional compilation switches to work around various things. */

/*  Has ASNIQ% jsys been fixed not to require SC%NWZ for vanilla usage? */
#ifndef SC_NWZ__BRAINDAMAGE_FIXED
#define SC_NWZ__BRAINDAMAGE_FIXED   0
#endif

/*  Has IPIPIP.MAC been fixed to handle extended addressing properly? */
#ifndef	IPIPIP_EXTENDED_FIXED
#define	IPIPIP_EXTENDED_FIXED	    0
#endif

/*  Support UDPNOP cell that can be patched to make all UDP calls nops? */
#ifndef SUPPORT_UDPNOP
#define SUPPORT_UDPNOP		    1
#endif

/* Do we want packet logging code? */
#ifndef UDP_PACKET_LOGGING
#define UDP_PACKET_LOGGING 0
#endif

/* For completeness... */
#ifndef WORD_SIZE
#define WORD_SIZE   (sizeof(int))
#endif

/* NB, no dependencies except system files and UDP protocol info. */
#include <stdio.h>
#include <monsym.h>
#include <jsys.h>
#include <macsym.h>
#include <string.h>
#include "udp.h"

/* udp20x.c */
static int udp_jsys(int,int *,int ,int );
static udp_logpkt(char *,char *);


/* Flags for debugging and logging.  */

#ifdef DEBUG
int udpdbg = 0;
#define DBGFLG udpdbg
#else
#define DBGFLG (0)
#endif

#if UDP_PACKET_LOGGING
int udplog = 0;
#define LOGFLG udplog
#else
#define LOGFLG (0)
#endif

#if SUPPORT_UDPNOP
static int udpnop = 0;
#define UDPNOP (udpnop)
#else
#define UDPNOP (0)
#endif

/*
 * External routines buginf(), bugchk(), and bughlt() are used in both
 * bug reporting and packet logging.  They must be supplied somehow in
 * the program that uses this module.  Sorry, but this seems better
 * than arbitrarily deciding what bug messages should look like and
 * where they should go.
 */
extern void buginf(char *module, char *format, ...);
extern void bugchk(char *module, char *format, ...);
extern void bughlt(char *module, char *format, ...);

/* Internet Queue Handle, reused for all UDP "connections" */
int udpiqh = UDP_BADIQH;

/* Host and port specified by use in udp_init(), if any */
static int myhost = 0, myport = 0;

/* Argument block layout for ASNIQ% */
struct asniq_arg  {
    unsigned xx1 : 24;			    /* unused, zero */
    unsigned prv : 8;	    unsigned : 4;   /* protocol value */
    unsigned fhv : 32;	    unsigned : 4;   /* fhost value */
    unsigned lhv : 32;	    unsigned : 4;   /* lhost value */
    unsigned lpv : 16;			    /* lport value */
    unsigned fpv : 16;	    unsigned : 4;   /* fport value */
    unsigned xx2 : 24;			    /* unused, zero */
    unsigned prm : 8;	    unsigned : 4;   /* protocol mask */
    unsigned fhm : 32;	    unsigned : 4;   /* fhost mask */
    unsigned lhm : 32;	    unsigned : 4;   /* lhost mask */
    unsigned lpm : 16;			    /* lport mask */
    unsigned fpm : 16;	    unsigned : 4;   /* fhost mask */
};					    /* whew! */

/* Local host/foreign host address stuff.
 *
 * On a multi-homed host, we have to be clever about which of our
 * local addresses we use if we want to do things "right".  GTDOM% has
 * a function to select an appropriate local address for a given
 * foreign address.  If available, we use that function, otherwise we
 * return whatever GTHST%/GTDOM% does (the value of the monitor's
 * PRFADR variable, which is set from SYSTEM:INTERNET.ADDRESSES and
 * hope for the best.
 *
 * For any machine running UDP/IP, we have to be clever about which
 * address we use for a multi-homed foreign host (SRI-NIC.ARPA being
 * perhaps the canonical example).  Most user UDP/IP code can ignore
 * this because GTHST% and GTDOM% sort addresses, but the current
 * resolver design makes it impossible for the resolver itself to do
 * this.  So we provide a hook for the resolver to call to sort
 * addresses; we in turn use a special GTDOM% function that, while
 * available to other programs, will probably never be called by
 * anybody else.  This function does not invoke the resolver in any
 * way; it is part of GTDOM% simply because all the hooks were already
 * there and because GTDOM% already has several random functions that
 * are really just the resolver code running in executive mode.
 */


/* Home address and port */
static int udp_myaddr(foreign)
    int foreign;
{
    static int stash = 0;
    int ac[5];

    if(myhost != 0)			/* If user specified an address, */
	return(myhost);			/* use it with no monkey business */

#if monsymdefined(".GTDLA")
    if((ac[2] = foreign) != 0 && (ac[1] = monsym(".GTDLA"), jsys(GTDOM,ac)))
	return(ac[2]);			/* Got a good address, return it */
#endif

    if(stash != 0)			/* Well, maybe we've been here */
	return(stash);			/* before and can save the overhead? */

    if((ac[1] = monsym(".GTHSZ"), jsys(GTDOM,ac)))
	return(stash = ac[4]);		/* Save and return default address */

    bugchk("udp_myaddr","unable to obtain local host address");
    return(0);				/* Punt */
}

/* Sort list of foreign addresses. No-op if not available or GTDOM% loses. */
void udp_sort(count,list)
    int count,list[];
{
#if monsymdefined(".GTDSA")
    int ac[5], i;
    ac[1] = monsym(".GTDSA");		/* try doing the sort */
    ac[2] = (int) list;
    ac[3] = count;
    if(jsys(GTDOM,ac))			/* if we did it, flush out */
	for(i = ac[3]; i < count; ++i)	/* any addresses that were */
	    list[i] = 0;		/* deemed unreachable */
#endif
}

/*
 * Initialize UDP stuff for this process.  Called only once.
 * Arguments are local host and port to use, in case the caller cares
 * (might if nameserver instead of resolver).
 *
 * lhost:   if 0,  use whatever GTDOM% claims is our address.
 *	    if -1, set up for any local address.
 *	    else,  value is local address to use.
 *
 * lport:   if 0,  cons up a local port somehow.
 *	    else,  value is local port to use.
 *
 */

int udp_init(lhost,lport)
    int lhost,lport;
{
    int ac[5];				/* jsys hacking */

    struct asniq_arg argblk;		/* argument block for ASNIQ% */

    int tries = (lport == 0 ? 10 : 1);	/* max tries for lport */

    if(UDPNOP) {			/* has user made us a NOP? */
	if(DBGFLG)			/* yeah, maybe log this silliness */
	    buginf("udp_init","UDPNOP enabled, returning \"success\"");
	return(1);			/* return "success" */
    }
    ac[1] = -1;
    jsys(RELIQ,ac);	/* Release queue -- if assigned */

#if !SC_NWZ__BRAINDAMAGE_FIXED
    ac[1] = monsym(".FHSLF");		/* if we need ARPANET-WIZARD */
    jsys(RPCAP,ac);			/* try to turn it on */
    if(ac[2]&monsym("SC%NWZ")) {
	ac[3] |= monsym("SC%NWZ");
	jsys(EPCAP,ac);
    } else
	bugchk("udp_init","Can't enable SC%%NWZ, UDP will probably fail");
#endif

    if(lhost > 0)			/* Caller specified our address? */
	myhost = lhost;			/* Yup, save for posterity */
					/* now get an IQH */
    if(DBGFLG)
	buginf("udp_init","lhost=%o, lport=%X, tries=%d",lhost,lport,tries);

    bzero((char *) &argblk, sizeof(argblk));
    argblk.prv = UDP_PROTOCOL;		/* protocol is UDP */
    argblk.prm = -1;			/* protocol must match exactly */
    argblk.fhv = 0;			/* we'll talk to any host */
    argblk.fhm = 0;			/* so this matches anything */
    argblk.fpv = 0;			/* same for foreign port */
    argblk.fpm = 0;
    argblk.lhv = (lhost < 0 ? 0 : udp_myaddr(0)); /* local host number */
    argblk.lhm = (lhost < 0 ? 0 : -1);		 /* wild host if requested */
    argblk.lpm = -1;			/* local port must match exactly */
    argblk.xx1 = argblk.xx2 = 0;	/* reserved fields, zero */

    if(lport != 0)			/* given a local port? */
	myport = lport;			/* yeah, remember it */
    else {				/* nope, cons one from job number */
	jsys(GJINF,ac);	/* (unless job zero!) */
	myport = (ac[3] ? ac[3]&0xFF : 0xFF) << 8;
    }

    do {				/* try to get an IQH */
	if(lport == 0) {		/* consing local port? */
	    jsys(TIME,ac);	/* yep, randomize low 8 bits */
	    myport ^= ac[1]&0xFF;	/* of the port number */
	}
	argblk.lpv = myport;		/* local port to try */
	if(DBGFLG) {
	    buginf("udp_init","tries=%d   pr=[%d,%X]",tries,argblk.prv,argblk.prm);
	    buginf("udp_init","fh=[%o,%X]  fp=[%X,%X]",argblk.fhv,argblk.fhm,argblk.fpv,argblk.fpm);
	    buginf("udp_init","lh=[%o,%X]  lp=[%X,%X]",argblk.lhv,argblk.lhm,argblk.lpv,argblk.lpm);
	}
	udpiqh = udp_jsys(ASNIQ,(int *)&argblk,0,
			    sizeof(argblk)/sizeof(int));
    } while(udpiqh == UDP_BADIQH && --tries > 0 && !UDPNOP);

    return(udpiqh != UDP_BADIQH || UDPNOP); /* won or ran out of patience */
}

/*
 * Gross kludge to work around IPIPIP.MAC's total lack of understanding
 * of extended addressing.
 */

/* Define a big static buffer. */
#if !IPIPIP_EXTENDED_FIXED
#define	STATIC_BUFFER_SIZE  (5*512)
#endif

static int udp_jsys(opcode,argblk,argnum,size)
    int opcode, *argblk, argnum, size;
{
    int ac[5], err, *_argblk = argblk;

#if !IPIPIP_EXTENDED_FIXED

    static int stat[STATIC_BUFFER_SIZE];
    size *= sizeof(int);

    /*
     * If we're running in extended addressing, copy the arg block
     * into section zero AND section one.  ASNIQ% won't settle for
     * either one, has to be both.  Honest.  Would I make up something
     * like this?
     */
    if((((int)argblk)&_LHALF) != 0) {
	_argblk = (int *)(((int)stat) & _RHALF);
	switch(opcode) {
	    case ASNIQ:	/* ASNIQ% jsys */
	    case SNDIN:	/* SNDIN% jsys */
		if(size > STATIC_BUFFER_SIZE*sizeof(int))
		    bughlt("udp_jsys","argblk too small (%d,%d)",
			    STATIC_BUFFER_SIZE, size/sizeof(int));
		bcopy((char *)argblk, (char *)_argblk, size);
		bcopy((char *)argblk, (char *)stat,    size);
		break;
	    case RCVIN:	/* RCVIN% jsys */
		bzero((char *)_argblk, size);
		bzero((char *)stat,    size);
		*(int *)stat = *(int *)_argblk = *(int *)argblk;
		break;
	    default:
		bughlt("udp_jsys","unknown opcode (%o)",opcode);
	}
    }
#endif

    if(DBGFLG)
	buginf("udp_jsys","opcode=%o, argblk=%o, argnum=%o, size=%o",
		opcode,argblk,argnum,size);

    switch(opcode) {
	case ASNIQ:		/* ASNIQ% jsys */
	    ac[1] = (int) _argblk;	/* argument block */
	    ac[2] = ac[3] = 0;		/* reserved acs, sez BBN */
	    if(jsys(opcode,ac))
		return(ac[1]);
#if SUPPORT_UDPNOP
	    if(ac[0] == monsym("ILINS2"))
		udpnop = 1;		/* detect non-IP monitor */
#endif
	    return(UDP_BADIQH);
	case SNDIN:		/* SNDIN% jsys */
	    ac[1] = argnum;		/* IQH, maybe flags too */
	    ac[2] = (int) _argblk;	/* message buffer */
	    ac[3] = 0;			/* reserved to BBN */
	    return(jsys(opcode,ac));
	case RCVIN:		/* RCVIN% jsys */
	    ac[1] = argnum;		/* IQH, maybe flags too */
	    ac[2] = (int) _argblk;	/* message buffer */
	    ac[3] = 0;			/* reserved to BBN */
	    err = jsys(opcode,ac);
	    if(DBGFLG) {
		char jsmsg[200];    int ac[5];
		ac[1] = (int)(jsmsg-1);
		ac[2] = XWD(monsym(".FHSLF"),-1);
		ac[3] = sizeof(jsmsg)-1;
		jsys(ERSTR,ac);
		buginf("udp_jsys","RCVIN%%: _argblk=%o, stat=%o, err=\"%s\"",
			_argblk,stat,jsmsg);
	    }
	    break;			/* have to copy back result */
	default:
	    bughlt("udp_jsys","unknown opcode %012o",opcode);
    }

#if !IPIPIP_EXTENDED_FIXED
    if((((int)argblk)&_LHALF) != 0)	/* Now copy back results */
	switch(opcode) {
	    case RCVIN:	/* RCVIN% jsys */
		if(size > STATIC_BUFFER_SIZE*sizeof(int))
		    bughlt("udp_jsys","argblk too small (%d,%d)",STATIC_BUFFER_SIZE, size/sizeof(int));
		if (stat[4] & _LHALF) /* Test foreign host word to see */
				      /* if data returned in sect 0 or 1 */
		  bcopy((char *)stat, (char *)argblk, size);
		else		/* No, must be here */
		  bcopy((char *)_argblk, (char *)argblk, size);
		*argblk = *stat; /* Count always comes back here */
	    case ASNIQ:	/* ASNIQ% jsys */
	    case SNDIN:	/* SNDIN% jsys */
		break;
	    default:
		bughlt("udp_jsys","unknown opcode (%o)",opcode);
	}
#endif

    return(err);
}

int udp_fini()
{
    int ac[5];

    if(UDPNOP) {
	if(DBGFLG)
	    buginf("udp_fini","UDPNOP enabled, returning \"success\"");
	return(1);
    }

    ac[1] = udpiqh;
    ac[2] = ac[3] = 0;
    return(jsys(RELIQ,ac));
}

/*
 * UDP checksum code.
 *
 * This function calcluates the ones-complement sum of the packet.
 * For testing incoming packets the result of this routine should
 * be zero.  For outgoing packets the value placed in the udp.checksum
 * packet field should be the ones-complement of the result of this
 * function.
 *
 * We assume that the data is already in the format needed by the IP
 * queue jsys calls.  Ie, we are looking at left justified 8 bit
 * bytes, not 9 bit bytes or right justified 8 bit bytes or....
 *
 * We use the IP packet length and IHL rather than the UDP length,
 * because these have been protected by the IP header checksum.
 * Or so goes the theory.
 *
 * Note that we can assume certain things about word boundries
 * due to the fact that the IP header is always an integral
 * number of words (per IP RFC).
 *
 * We can speed up the calculation some by noticing that, in
 * calculating a ones-complement sum, we're really doing modular
 * arithmetic (modulo 2**16-1, since 0 == ~0 in ones complement).
 * We can add 32-bit word values into 36-bit words, and only have to
 * fold things in when we carry all the way to the sign bit.  When we
 * do so, we can just subtract some huge number that, being a multiple
 * of 2**16-1, is zero for purposed of the ones-complment sum.  The
 * particular value we use is the largest one that is safe on a 36-bit
 * twos complement machine; the huge number has to be less than
 * 2**35-1 or we'd risk the result going negative and losing the
 * ones-complement properties we want to preserve.
 *
 * This hack courtesy of Alan Bawden.
 */
#define ZERO_MOD_0xFFFF (0xFFFF*524296)
#if (ZERO_MOD_0xFFFF % 0xFFFF) != 0
#error ZERO_MOD_0xFFFF constant isn't!
#endif

/* Macro to get left-justified 32-bit word from 36-bit word. */
#define L32INT(word) ((int)(((unsigned)(word))>>4))

int udp_chksum(pkt)
    char *pkt;
{
    int n, sum, *u;
    struct ip_header *ip_h;
    struct udp_header *udp_h;

    if(UDPNOP) {			/* Get out now if no UDP */
	if(DBGFLG)
	    buginf("udp_chksum","UDPNOP enabled, returning 0");
	return(0);
    }

    /* Initialize pointers, compute data length */
    ip_h = IP_HEADER(pkt);
    u = (int *) (udp_h = UDP_HEADER(pkt));
    n = ip_h->len - (ip_h->ihl * 4);

    if(DBGFLG)
	buginf("udp_chksum",
		"pkt=%o, udp.len = %d, ip.len - ip.ihl*4 = %d - %d*4 = %d",
		(int)pkt, udp_h->ln, ip_h->len,ip_h->ihl,n);
    if(DBGFLG && n != udp_h->ln)
	bugchk("udp_chksum","udp.len <> ip.len - ip.ihl*4 !!");

    /*
     * Initial sum is pseudo-header:
     *  IP source and destination addresses
     *  IP protocol number
     *  UDP data length (which gets added again part of UDP header!)
     * plus whatever bytes are in the last word of the packet buffer.
     */
    sum = ip_h->sh + ip_h->dh + ip_h->pro + udp_h->ln
	+ (L32INT(u[n/4]) & (~0 << (8 * (4 - (n % 4)))));

    /* Sum everything else, folding when necessary. */
    n /= 4;
    while(--n >= 0)
	if((sum += L32INT(*u++)) < 0)	/* Carried into the sign bit? */
	    sum -= ZERO_MOD_0xFFFF;	/* Yeah, fix that */

    /* Final folding via more modular arithmetic. */
    return(sum % 0xFFFF);
}


void udp_binit(p)
    char *p;
{
    IP_HEADER(p)->ver = IP_VERSION;	/* Which version of IP this is */
    IP_HEADER(p)->ihl = IP_MINIHL;	/* Minimal length IP header */
    IP_HEADER(p)->tos = 0;		/* Default service type */
    IP_HEADER(p)->frg = 0;		/* Ditto fragmentation stuff */
    IP_HEADER(p)->ttl = 0xFF;		/* Max possible lifespan */
    IP_HEADER(p)->pro = UDP_PROTOCOL;	/* Protocol is UDP */
    IP_HEADER(p)->sh  = 0;		/* No source host yet */
    IP_HEADER(p)->dh  = 0;		/* Or destination host */
    UDP_HEADER(p)->sp = 0;		/* No source port yet */
    UDP_HEADER(p)->dp = 0;		/* Or destination port */
    UDP_HEADER(p)->ck = 0;		/* Zero initial checksum */
    UDP_HEADER(p)->ln = UDP_HLEN;	/* Start with UDP header length */
    return;
}


int udp_send(p)
    char *p;
{
    if(UDPNOP) {			/* has user made us a NOP? */
	if(DBGFLG)			/* yeah, maybe log this silliness */
	    buginf("udp_send","UDPNOP enabled, returning \"success\"");
	return(1);			/* return "success" */
    }

    if(!IP_HEADER(p)->sh)		/* get local addr if not specified */
	IP_HEADER(p)->sh = udp_myaddr(IP_HEADER(p)->dh);
    if(!UDP_HEADER(p)->sp)		/* our port number specified? */
	UDP_HEADER(p)->sp = myport;	/* no, use default */
    IP_HEADER(p)->len = IP_HEADER(p)->ihl*WORD_SIZE + UDP_HEADER(p)->ln;
    *(int *)p = (IP_HEADER(p)->len+WORD_SIZE-1)/WORD_SIZE + 1;
    UDP_HEADER(p)->ck = 0;		/* prepare to compute checksum */
    UDP_HEADER(p)->ck = udp_chksum(p) ^ 0xFFFF;	/* compute the checksum */
    return(udp_rxmit(p));		/* Retransmit code does right thing */
}

int udp_rxmit(p)
    char *p;
{
    if(UDPNOP) {
	if(DBGFLG)
	    buginf("udp_rxmit","UDPNOP enabled, returning \"success\"");
	return(1);
    }
    if(DBGFLG)
	buginf("udp_rxmt","udpiqh=%o, p=%o[%o]",udpiqh,(int)p,*(int *)p);
    if(LOGFLG)
	udp_logpkt("send",p);
    return(udp_jsys(SNDIN,(int *)p,udpiqh,*(int *)p));
}


int udp_recv(p, bsize, waitp)
    char *p;				/* buffer */
    int bsize;				/* size (in 8 bit bytes) */
    int waitp;				/* should we block? */
{
    int err;
    if(UDPNOP) {
	if(DBGFLG)
	    buginf("udp_recv","UDPNOP enabled, returning \"empty queue\"");
	return(0);
    }
    if(DBGFLG)
	buginf("udp_recv","p=%o, bsize=%o, waitp=%o",p,bsize,waitp);
    *(int *)p = (bsize+WORD_SIZE-1)/WORD_SIZE;
    waitp = (waitp ? udpiqh : udpiqh|monsym("RIQ%NW"));
    err = udp_jsys(RCVIN,(int *)p,waitp,*(int *)p);
    if(LOGFLG && err != 0)
	udp_logpkt("recv",p);
    return(err);
}

static udp_logpkt(caller,pkt)
    char *caller, *pkt;
{
    if(DBGFLG)
	buginf("udp_logpkt",
	    "ip.ver=%d, ip.ilh=%d, ip.tos=%d, ip.len=%d, ip.sid=%d, ip.fragment=%X, ip.ttl=%X, ip.pro=%d",
		    IP_HEADER(pkt)->ver, IP_HEADER(pkt)->ihl, IP_HEADER(pkt)->tos, IP_HEADER(pkt)->len,
		    IP_HEADER(pkt)->sid, IP_HEADER(pkt)->frg, IP_HEADER(pkt)->ttl, IP_HEADER(pkt)->pro);
    buginf("udp_logpkt","%s: ip.sh=%o, ip.dh=%o, udp.sp=%d, udp.dp=%d, udp.chk=%X, udp.len=%d", caller, 
		     IP_HEADER(pkt)->sh,  IP_HEADER(pkt)->dh,
		    UDP_HEADER(pkt)->sp, UDP_HEADER(pkt)->dp,
		    UDP_HEADER(pkt)->ck, UDP_HEADER(pkt)->ln);
}
    