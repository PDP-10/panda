 /* cafpro.c	-*-C-*- */
/* <RELPH.S49>CAFPRO.C.19, 26-Mar-86 17:54:17, Edit by RELPH */
/*

	Cafpro translated to C by John M. Relph

	TITLE CAFPRO Cafard Phase I Protocol Routines (OS independent)
	SUBTTL Written by Mark Crispin/MRC

; Copyright (C) 1985 Mark Crispin.  All rights reserved.

	SEARCH MACSYM		; system definitions
	SALL			; suppress macro expansions
	.DIRECTIVE FLBLST	; sane listings for ASCIZ, etc.
	EXTERN $SIBE,$BIN,$SOUT,$BLOCK

; Cafard Phase I protocol:

;  All packets start with DLE.  The second byte indicates what sort of
; packet it is.  The packet sequence is a 4-bit value, the packet data
; size is an 8-bit value, and the packet checksum is a 16-bit value.
; All values are expressed as their text hex representation.
;
;  Text packets are indicated with STX, followed by the packet sequence
; byte, two bytes of packet data size, the packet data, four bytes of
; packet checksum, and a CR.  Inside the packet data, control characters,
; delete, and the quote character must be quoted.  This is accomplished
; by sending the quote character followed by the character's ASCII
; representation expressed in hex.  Note that CR and LF must be quoted.
;
;  Acknowledgement packets are indicated with ACK, followed by the packet
; sequence byte for the packet being acknowledged and the same byte XOR'd
; with the AXR value.


   Routines:
	p_init	initialize protocol
	p_bin	get byte from remote using protocol
	p_sout	send string to protocol
	p_eof	send end of file indication
	p_bout	send byte to protocol

*/

#include "igdef.h"
#include "cafdef.h"
#include <ctype.h>

/* Protocol definitions */
#define PROBSZ 50		/* max number of text character in packet */
#define MAXINW 3*4*60		/* max time to wait for input (in minutes) */
#define MAXJNK 1000		/* max number of junk characters before DLE */
#define MAXRTY 100		/* max number of retries/packet */

/* Packet header protocol */
#define DLE 020			/* ^P - data link escape */
#define STX 002			/* ^B - start of text */
#define ACK 037			/* ^_ -  acknowledgement */

/* Protocol occuring inside packet data */
#define QOT '\\'		/* quote character */
#define EOF 0377		/* end of file */

/* Magic numbers */
#define XSM 013215		/* checksum magic number */
#define AXR 0161		/* ACK check byte XOR value */

char hextab[16] =
 {'0', '1', '2', '3', '4', '5', '6', '7',
  '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'
 };

int pkout,			/* number of packets output */
    retry;			/* number of retransmissions */

char
 prieof,			/* input EOF seen */
 priseq;			/* input sequence */
 priptr,			/* input pointer */
 prictr,			/* input counter */
 pribfr[PROBSZ+1],		/* input buffer */
 proseq,			/* output sequence */
 proptr,			/* output pointer */
 proctr,			/* output counter */
 procnt,			/* output character counter */
 probfr[PROBSZ+11];		/* output buffer */
unsigned long
 prixsm,			/* input checksum */
 proxsm;			/* output checksum */

/* perform checksums for input and output bytes */
#define inpxsm(ch) prixsm = (prixsm * XSM + ch) & 0xFFFF /* 16 bits */
#define outxsm(ch) proxsm = (proxsm * XSM + ch) & 0xFFFF /* ditto */

static int
 s_delay,a_state,		/* send state and ack state coroutine ptrs */
 c_ack;				/* global coroutine variables */

extern int l_open();	        /* procs in cafio.c */
extern int l_sibe();
extern int l_bin();
extern int l_bout();
extern int l_sout();
extern int l_block();
extern int l_clbuf();
extern int l_dtron();
extern int l_dtrof();
extern int l_speed();
extern int l_close();

int p_init()			/* Protocol initialization */
{priptr = 0;			/* start of string */
 proptr = 5;		        /* first five chars for packet header */
 proctr = procnt = PROBSZ;	/* initialize counters */
 prictr = prieof = priseq = proxsm = prixsm = 0; /* virgins */
 proseq = -1;		        /* ah, so next is packet zero */
#if debugsw
printf("p_init()\n");
#endif
 return(success);
}
int lastchr;

int p_bin()			/* get byte from remote using protocol */
{int i,ch,count;
 char ackstring[7];

 if (--prictr >= 0)		/* any bytes left? */
  return(pribfr[priptr++]);	/* yes, get byte */
 if (prieof)
 {prieof = FALSE;
#if debugsw
printf("pbin(EOF)\n");
#endif
  return(0);
 };
 lastchr = -1;			/* no "last character" sent */
 for (;;)
 {prictr = 0;
  if (lastchr != DLE)		/* saw DLE? */
  {for (i = 1; i <= MAXJNK; ++i) /* maximum junk bytes allowed */
   {if ((ch = bintimeout()) == P_ERR) /* no, get DLE we want */
     return(P_ERR);		/* return bad character */
    if (ch == DLE)		/* saw expected DLE? */
     break;			/* yes, cut this out */
   };				/* keep trying until we get that DLE */
   if (ch != DLE)		/* got it? */
    return(P_ERR);		/* nope, too many junk characters */
  };
#if debugsw
printf("DLE ");
#endif
  if ((ch = bintimeout()) == P_ERR) /* get packet type */
   return(P_ERR);		/* error */
#if debugsw
if (iscntrl(ch))
 printf("#^%c",ch - 'A' + 1);
else
 printf("#%c",ch);
#endif
  if (ch != STX)		/* data packet? */
   continue;			/* no others known yet */
  if ((ch = bintimeout()) == P_ERR) /* get packet sequence byte */
   return(P_ERR);
#if debugsw
if (iscntrl(ch))
 printf("#^%c",ch - 'A' + 1);
else
 printf("#%c",ch);
#endif
  if ((ch = unhex(ch)) == P_ERR) /* unhexify */
   continue;			/* not valid hex */
  if ((ch = bintimeout()) == P_ERR) /* get packet type */
   return(P_ERR);		/* error */
#if debugsw
if (iscntrl(ch))
 printf("#^%c",ch - 'A' + 1);
else
 printf("#%c",ch);
#endif
  if ((ch = unhex(ch)) == P_ERR)
   continue;
  i = ch;			/* copy it */
  if ((ch = bintimeout()) == P_ERR) /* get packet type */
   return(P_ERR);		/* error */
#if debugsw
if (iscntrl(ch))
 printf("#^%c",ch - 'A' + 1);
else
 printf("#%c",ch);
#endif
  if ((ch = unhex(ch)) == P_ERR)
   continue;
  count = prictr = (i << 4) + ch; /* get number of data bytes following */
  prieof = FALSE;		/* no EOF status yet */
  priptr = prixsm = 0;	        /* start checksum */
#if debugsw
printf("\nAbout to receive %d bytes\n",prictr);
#endif
  for (;;)
  {if ((ch = bintimeout()) == P_ERR) /* get packet type */
    return(P_ERR);		/* error */
   if (ch == QOT)		/* quoting byte? */
   {if ((ch = bintimeout()) == P_ERR) /* get quoted nybble */
     return(P_ERR);
    if ((ch = unhex(ch)) == P_ERR)
     break;			/* hex error, back to main loop */
    i = ch;			/* save it */
    if ((ch = bintimeout()) == P_ERR) /* get packet type */
     return(P_ERR);		/* error */
    if ((ch = unhex(ch)) == P_ERR)
     break;			/* hex error, back to main loop */
    ch = (i << 4) + ch;		/* merge two bytes */
   };
#if debugsw
if (iscntrl(ch))
 printf("#^%c",ch - 'A' + 1);
else
 printf("#%c",ch);
#endif
   inpxsm(ch);			/* checksum it */
   if (ch == EOF)		/* was this an EOF? */
   {prieof = TRUE;		/* note EOF status */
    if (--count == 0)		/* this had better be the last byte */
     --prictr;		        /* it wasn't don't do this */
    break;
   }
   else
   {pribfr[priptr++] = ch;	/* store char in buffer */
    if (--count == 0)	        /* check chars remaining */
     break;			/* none left, done looping */
   }
  };
  if (count)			/* if aborted data in */
   continue;			/* resynch on DLE */
#if debugsw
printf("\nChecking packet trailer\n");
#endif
  ch = hextab[priseq];		/* get data size byte */
  inpxsm(ch);			/* checksum it */
  if ((ch = bintimeout()) == P_ERR) /* first byte of checksum */
   return(P_ERR);
  if ((ch = unhex(ch)) == P_ERR)
   continue;
  i = ch;			/* save it */
  if ((ch = bintimeout()) == P_ERR) /* get 2nd byte of checksum */
   return(P_ERR);
  if ((ch = unhex(ch)) == P_ERR)
   break;
  i = (i << 4) + ch;		/* add in 2nd byte */
  if ((ch = bintimeout()) == P_ERR) /* get 3rd byte of checksum */
   return(P_ERR);
  if ((ch = unhex(ch)) == P_ERR)
   break;
  i = (i << 4) + ch;		/* add in 3rd byte */
  if ((ch = bintimeout()) == P_ERR) /* get 4th byte of checksum */
   return(P_ERR);
  if ((ch = unhex(ch)) == P_ERR)
   break;
  i = (i << 4) + ch;		/* add in 4th byte */
#if debugsw
printf("checksum received is %X, calculated is %X\n",i,prixsm);
#endif
  if (i != prixsm)		/* checksums match? */
   continue;			/* so solly... */
  if ((ch = bintimeout()) == P_ERR) /* finally, get expected CR */
   return(P_ERR);
  if (ch != cr)
   continue;			/* lose again */
  priptr = 0;			/* reset buffer pointer */
  priseq = ++priseq & 0xF;	/* bump seq count for ack, 1 hex byte */
  break;		        /* and we've got a line */
 };
 ackstring[0] = DLE;
 ackstring[1] = ACK;
 ackstring[4] = cr;
 ackstring[5] = lf;
 ackstring[6] = 0;		/* null string to end */
 ch = hextab[(priseq - 1) & 0xF]; /* ack prev packet */
#if debugsw
printf("ACK(%c,%c)\n",ch,ch ^ AXR);
#endif
 ackstring[2] = ch;		/* store in packet */
 ackstring[3] = ch ^ AXR;	/* hash with magic number, put in string */
#if debugsw
printf("ACKing rcpt\n");
#endif
 for (i = 0; i < 6; ++i)
  if (l_bout(ackstring[i]) == L_ERR) /* send acknowledgement */
   return(P_ERR);
#if debugsw
printf("[packet received]\n");
#endif
 return(p_bin());		/* do p_bin again */
}

int bintimeout()		/* get a byte with eventual timeout */
{int i,ch;
 
 ch = -1;
 for (i = 1; i <= MAXINW; i++)
 {if (l_sibe() == 0)
   l_block();
  else
  {ch = l_bin();
   break;
  }
 };
 if (ch == L_ERR)
  return(P_ERR);
 lastchr = ch;
 return(ch);
}

int unhex(ch)			/* convert hex text to numeric */
{if (isdigit(ch))		/* numeric hex? */
  return(ch - '0');		/* convert to numeric */
 else if ((ch >= 'A') && (ch <= 'F')) /* alphabetic hex */
  return(10 + ch - 'A');
 else
  return(P_ERR);		/* loser */
}

int p_sout(s,len)		/* send string to protocol */
 char s[];			/* len is length of string */
{int i,ch;

 for (i = 0; i < len; ++i)
 {if (p_bout(s[i]) == P_ERR)
   return(P_ERR);
 };
 return(0);
}

int p_eof()			/* send end of file indication */
{if (p_bout(EOF) == P_ERR)
  return(P_ERR);
 return(0);
}

int p_bout(ch)			/* send byte to protocol */
{int pktsize,pktfreespace,i,j;

#if debugsw
if (ch == EOF)
 printf("!EOF");
else if (iscntrl(ch))
 printf("!^%c",ch + 'A' - 1);
else
 printf("!%c",ch);
#endif
 if ((ch & 0200) || iscntrl(ch) || (ch == QOT))	/* special character? */
 {probfr[proptr++] = QOT;	/* yes, special or out of band */
  probfr[proptr++] = hextab[(ch & 0xF0) >> 4]; /* high order byte to hex */
  probfr[proptr++] = hextab[ch & 0xF]; /* low order byte to hex */
  procnt -= 3;			/* account for the bytes */
 }
 else				/* not special, do normal stuff */
 {probfr[proptr++] = ch;	/* store byte */
  procnt--;			/* account for it */
 };
 outxsm(ch);			/* checksum this byte */
 proctr--;			/* count another data byte */
 if ((!(ch & 0200)) && (procnt >= 3)) /* in band and reasonable space left? */
  return(0);			/* yes, return now */
 pktfreespace = proctr;		/* save data free space */
 pktsize = (PROBSZ + 10) - procnt; /* <free space> - <max pkt size> */
#if debugsw
printf("proptr = %d, max = %d, size = %d\n",proptr,PROBSZ,pktsize);
#endif
 proctr = procnt = PROBSZ;	/* reset counters */
 pktfreespace = PROBSZ - pktfreespace; /* compute data area size */
				/* now get ready to make packet header */
 probfr[0] = DLE;		/* initialize packet header */
 probfr[1] = STX;		/* ... */
 proseq = ++proseq & 0xF;	/* get next sequence */
 probfr[2] = ch = hextab[proseq]; /* make sequence hex */
 outxsm(ch);
 probfr[3] = hextab[(pktfreespace & 0xF0) >> 4]; /* packet size high byte */
 probfr[4] = hextab[pktfreespace & 0xF]; /* packet size low byte */
				/* make packet trailer */
 probfr[proptr++] = hextab[(proxsm >> 12) & 0xF]; /* first byte of checksum */
 probfr[proptr++] = hextab[(proxsm >> 8) & 0xF]; /* second byte */
 probfr[proptr++] = hextab[(proxsm >> 4) & 0xF]; /* third byte */
 probfr[proptr++] = hextab[proxsm & 0xF]; /* fourth byte */
 probfr[proptr++] = cr;		/* expected cr */
#if debugsw
printf("P%d(",pktsize);
for (i = 0; i < pktsize ; ++i)
{if (probfr[i] < ' ')
  printf("^%c",probfr[i] + 'A' - 1);
 else
  printf("%c",probfr[i]);
};
printf(")\n");
#endif
 proptr = 5;			/* reset pointer */
 proxsm = 0;			/* reset checksum */
				/* ok, now send the packet out */
 if (send_packet(pktsize) == P_ERR) /* hairy coroutines */
  return(P_ERR);
#if debugsw
printf("[packet sent]\n");
#endif
 return(0);			/* return ok */
}

int send_packet(size)		/* send the packet out */
 int size;
{int tries,ack_ret,i;

 a_state = 0;			/* acktest coroutine offset start */
 s_delay = 0;			/* send coroutine offset start */
 ++pkout;			/* count packets output */
 tries = 0;

#if debugsw
printf("sending packet of apparent length %d\n",size);
#endif
 for (;;)			/* begin retransmit loop */
 {
#if debugsw
printf("[delay:%d]",s_delay);
#endif
  if (s_delay == 0)		/* start with no delays */
  {for (i = 0; i < size; ++i)
    if (l_bout(probfr[i]) == L_ERR)
     return(P_ERR);	        /* was l_sout */
#if debugsw
printf("sent...");
#endif
   c_ack = hextab[proseq & 0xF]; /* set up ACK value we want */
   if ((ack_ret = acktst()) == P_ERR) /* got an ACK yet? */
    return(P_ERR);		/* propagate error */
   else if (ack_ret == success) /* got ACK? */
    return(success);		/* hey it was ACKed */
   else
   {++s_delay;			/* nope, set current state */
    continue;			/* and try for next ack */
   }
  }
  else
  {l_block();			/* dally a while */
#if debugsw
printf("retry...");
#endif
   if ((ack_ret = acktst()) == P_ERR) /* ACK yet? */
    return(P_ERR);		/* propagate error */
   else if (ack_ret == success) /* got ACK? */
    return(success);	        /* whoa... */
   else
   {if (++s_delay == 5)		/* how many checks? */
    {if (++tries > MAXRTY)	/* how many retransmits? */
      return(P_ERR);		/* too many times */
     ++retry;			/* count retransmissions */
     s_delay = 0;		/* start over */
    }
   }
  }
 }
}

/* acktst returns 0 if received ack */
int acktst()			/* coroutine to see if ack has come in yet */
{char ch;

 for (;;)
 {
#if debugsw
printf("[ACK:%d,%c,%c]",a_state,c_ack,c_ack ^ AXR);
#endif
  switch (a_state)
  {case 0 :
    if (l_sibe() == 0)		/* any bytes in input stream? */
     return(failure);		/* nope, try again */
    if ((ch = l_bin()) == L_ERR) /* get a byte? */
     return(P_ERR);		/* nope, error, return it */
#if debugsw
if (iscntrl(ch))
 printf("!^%c",ch - 'A' + 1);
else
 printf("!%c",ch);
#else
    else
#endif
    if (ch == DLE)		/* DLE byte? */
     ++a_state;			/* yes, go on to next state */
    continue;			/* no DLE, go back to start */
   case 1 :
    if (l_sibe() == 0)		/* any more bytes? */
     return(failure);		/* no, try again */
    else
     ++a_state;			/* yes, go on to next state */
    continue;
   case 2 :
    if ((ch = l_bin()) == L_ERR) /* get the byte */
     return(P_ERR);		/* oh well */
#if debugsw
if (iscntrl(ch))
 printf("!^%c",ch - 'A' + 1);
else
 printf("!%c",ch);
#else
    else
#endif
    if (ch == ACK)		/* ACK byte? */
     ++a_state;			/* yes, go on */
    else
     a_state = 0;		/* no, try again */
    continue;			/* back into loop */
   case 3 :
    if (l_sibe() == 0)		/* any more bytes? */
     return(failure);		/* nope, try again */
    else
     ++a_state;			/* yes, back into loop */
    continue;
   case 4 :
    if ((ch = l_bin()) == L_ERR) /* get the byte */
     return(P_ERR);		/* propagate error */
#if debugsw
if (iscntrl(ch))
 printf("!^%c",ch - 'A' + 1);
else
 printf("!%c",ch);
#else
    else
#endif
    if (ch == c_ack)		/* get the ACK we wanted? */
     ++a_state;			/* yes, continue on */
    else
     a_state = 0;		/* no, back again */
    continue;
   case 5 :
    if (l_sibe() == 0)		/* any more bytes? */
     return(failure);		/* nope, try again */
    else
     ++a_state;			/* yes, got byte, continue */
    continue;
   case 6 :
    if ((ch = l_bin()) == L_ERR) /* get the byte */
     return(P_ERR);		/* send error on */
#if debugsw
if (iscntrl(ch))
 printf("!^%c",ch - 'A' + 1);
else
 printf("!%c",ch);
#else
    else
#endif
    if ((ch ^ AXR) == c_ack)	/* hash and compare, got the ACK we wanted? */
    {
#if debugsw
printf("$ACK\n");
#endif
     return(success);		/* yeah! return success! */
    }
    else
     a_state = 0;		/* nope... back to go, do not collect $200 */
  }
 }
}
