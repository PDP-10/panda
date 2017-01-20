/* Cafio.c			-*-C-*- */
/* <RELPH.S49>CAFIO.C.19,  1-Apr-86 14:01:07, Edit by RELPH */
/*
   The routines which handle I/O to the line we're doing protocol on.
   Written for Vax/VMS file handling.

   Implmented in C by John M. Relph

   Routines:
	l_open	open the line specified
	l_sibe	return true if input buffer empty
	l_bin	read a byte from line
	l_bout	write a byte to the line
	l_sout	write a string to the line
	l_block	block for a short duration
	l_clbuf	clear input and output buffers for line
	l_dtron	set DTR on for the line
	l_dtrof	set DTR off for the line
	l_speed	set the speed for the line
	l_close	close the line
*/

#include <stdio.h>
#include <ttdef.h>
#include <iodef.h>
#include <descrip.h>
#include "igdef.h"	        /* IG program defs */
#include "cafdef.h"		/* cafard defs */

struct tt_mode {		/* mode words for ttys */
    char class, type;
    short width;
    int basic : 24;
    char length;
    long extended;
};

struct iosb_struct {		/* vax status block */
    short status, size, terminator, termsize;
};

struct set_block {
    char foo,bar;		/* these two aren't used */
    char modemon;		/* modem characteristics set */
    char modemoff;		/* clear */
    long other;
};

#define nok(a) (((ret = (a)) & 7) != 1)

#define LINBSZ 40*5		/* line buffer size in words */
#define LINTBL 20		/* max number of lines to try */

#define L_EFN 0			/* efn for l_ calls */
int linejfn,			/* file access block */
    ret;			/* return value from syscalls */

struct tt_mode orig_mode,new_mode; /* save settings */
static struct iosb_struct iosb;	/* status block */

char linebuffer[LINBSZ];	/* line buffer */
int linepointer,		/* which character in line buffer */
    linecount;			/* count of bytes remaining in buffer */

int speeds[] = {
	110, 150, 300, 600, 1200, 1800, 2400, 4800, 9600, 19200, 0 } ;

static int speedcodes[] = {
	TT$C_BAUD_110,  TT$C_BAUD_150,  TT$C_BAUD_300,  TT$C_BAUD_600,
	TT$C_BAUD_1200, TT$C_BAUD_1800, TT$C_BAUD_2400, TT$C_BAUD_4800,
	TT$C_BAUD_9600, TT$C_BAUD_19200 } ;

assign_chan(which)		/* system service call to assign the chan */
 char *which;
{int chan;
 struct dsc$descriptor_s str;	/* string descriptor for syscall */

 str.dsc$w_length = strlen(which); /* length */
 str.dsc$a_pointer = which;	/* string */
 str.dsc$b_class = DSC$K_CLASS_S;
 str.dsc$b_dtype = DSC$K_DTYPE_T;
#if debugsw
 ret = SYS$ASSIGN(&str,&chan,0,0); /* assign it */
 if (nok(ret))
#else
 if (nok(SYS$ASSIGN(&str,&chan,0,0))) /* assign it */
#endif
  return(L_ERR);		/* oops */
 else
  return(chan & 0xFFFF);	/* return only low order 16 bits */
}

int l_open(which)		/* open the line specified */
 char *which;
{

 if (linejfn)
  return(success);		/* already open, return ok */
 linepointer = 0;		/* reset counts */
 linecount = 0;
 if ((linejfn = assign_chan(which)) == L_ERR) /* assign the channel */
  return(L_ERR);		/* return any error */
#if debugsw
ret = SYS$QIOW(L_EFN,linejfn,IO$_SENSEMODE,0,0,0,
   &orig_mode,sizeof orig_mode,0,0,0,0);
if (nok(ret))
#else
 if (nok(SYS$QIOW(L_EFN,linejfn,IO$_SENSEMODE,0,0,0,
   &orig_mode,sizeof orig_mode,0,0,0,0)))
#endif
 {ret = SYS$DASSGN(linejfn);    /* doesn't matter if it doesn't work */
  return(L_ERR);
 };
 new_mode = orig_mode;		/* copy tty settings */

#ifdef TT2$M_PASTHRU
 new_mode.extended |= TT2$M_PASTHRU;
#else
 new_mode.basic |= TT$M_PASSALL;
#endif
#ifdef TT2$M_ALTYPEAHD
 new_mode.extended |= TT2$M_ALTYPEAHD;
#endif
 new_mode.basic |= TT$M_NOECHO;/* | TT$M_EIGHTBIT; */
 new_mode.basic &= ~TT$M_WRAP & ~TT$M_HOSTSYNC & ~TT$M_TTSYNC;
 if (nok(SYS$QIOW(L_EFN,linejfn,IO$_SETMODE,0,0,0,
   &new_mode,sizeof new_mode,0,0,0,0))) /* don't set speed */
  return(L_ERR);
 l_clbuf();			/* flush any characters in the buffers */
 return(success);		/* coolo */
}

int l_sibe()			/* return true if input buffer empty */
{struct
 {short cnt;			/* count of chars */
  char ch;
  char foo;			/* foo and bar are reserved */
  long bar;
 } buf_s;			/* structure to get info */

 if (linecount)
  return(linecount);
 else
#if debugsw
ret = SYS$QIOW(L_EFN,linejfn,IO$_SENSEMODE|IO$M_TYPEAHDCNT,0,0,0,
   &buf_s,sizeof buf_s,0,0,0,0);
if (nok(ret))
#else
if (nok(SYS$QIOW(L_EFN,linejfn,IO$_SENSEMODE|IO$M_TYPEAHDCNT,0,0,0,
   &buf_s,sizeof buf_s,0,0,0,0)))
#endif
  return(0);			/* if it didn't work, return 0 */
 else
  return(buf_s.cnt);		/* return number of bytes awaiting */
}

int l_bin()			/* read a byte from line */
{int count;
 long ttmask[2];
 int ch;
 char *inbuf = linebuffer;
 
 if (--linecount < 0)		/* anything in line input buffer? */
 {linecount = 0;	        /* reset for sibe */
  if ((count = l_sibe()) == L_ERR)
   return(L_ERR);	        /* percolate error */
  else if (count == 0)		/* buffer empty? */
   count = 1;			/* yes, just get one */
  if (count > LINBSZ)		/* bounds check */
   count = LINBSZ;		/* maybe we should recompile */
  linecount = count;		/* note number of bytes */
  linepointer = 0;		/* reinit pointer */
  ttmask[0] = 0;
  ttmask[1] = 0;
#if debugsw
ret = SYS$QIOW(L_EFN,linejfn,IO$_READVBLK,&iosb,0,0,
    inbuf,linecount,0,ttmask,0,0);
if (nok(ret) || nok(iosb.status)) /* read string */
#else
  if (nok(SYS$QIOW(L_EFN,linejfn,IO$_READVBLK,&iosb,0,0,
    linebuffer,linecount,0,ttmask,0,0)) || nok(iosb.status)) /* read string */
#endif
   return(L_ERR);
  linebuffer[linecount] = '\0';
  --linecount;			/* count this byte as having been et */
 };
 return(linebuffer[linepointer++]); /* read a single byte */
}

int l_bout(ch)			/* write a byte to the line */
 char ch;
{
#if debugsw
ret = SYS$QIOW(L_EFN,linejfn,IO$_WRITEVBLK,0,0,0,&ch,1,0,0,0,0);
if (nok(ret))
#else
 if (nok(SYS$QIOW(L_EFN,linejfn,IO$_WRITEVBLK,0,0,0,&ch,1,0,0,0,0)))
#endif
  return(L_ERR);
 else
  return(success);
}

int l_sout(s,len)		/* write a string to the line */
 char s[];
 int len;
{int i;

 for (i = 0; i < len; ++i)      /* this is a test */
  if (l_bout(s[i]) == L_ERR)
   return(L_ERR);
 return(success);
#if debugsw
ret = SYS$QIOW(L_EFN,linejfn,IO$_WRITEVBLK,0,0,0,s,len,0,0,0,0);
if (nok(ret))
#else
 if (nok(SYS$QIOW(L_EFN,linejfn,IO$_WRITEVBLK,0,0,0,s,len,0,0,0,0)))
#endif
  return(L_ERR);		/* do the SOUT */
 else
  return(success);
}

int l_block()			/* block for a short duration */
{struct time_struct
 {long int hi,lo;
 } t;

 t.hi = -2500000;		/* sleep for 250ms duration */
 t.lo = -1;
 if (nok(SYS$SCHDWK(0,0,&t,0)))
  return(L_ERR);
 SYS$HIBER();
 return(success);
}

int l_clbuf()			/* clear input and output buffers for line */
{long foo;

 if (nok(SYS$QIOW(L_EFN,linejfn,IO$_READVBLK|IO$M_TIMED|IO$M_PURGE,
   0,0,0,&foo,0,0,0,0,0)))	/* purge waiting input */
  return(L_ERR);
 else
  return(success);
}

int l_dtron()			/* set DTR on for the line */
{struct set_block chars = {0,0,0,0,0}; /* clear it all */

 if (orig_mode.basic & TT$M_MODEM)
  return(success);
 chars.modemon = TT$M_DS_DTR;
 if (nok(SYS$QIOW(L_EFN,linejfn,IO$_SETMODE|IO$M_SET_MODEM|IO$M_MAINT,0,0,0,
   &chars,0,0,0,0,0)))
  return(L_ERR);
 return(success);
}

int l_dtrof()			/* set DTR off for the line */
{struct set_block chars = {0,0,0,0,0}; /* clear it all */

 if (orig_mode.basic & TT$M_MODEM)
  return(success);
 chars.modemoff = TT$M_DS_DTR;
 if (nok(SYS$QIOW(L_EFN,linejfn,IO$_SETMODE|IO$M_SET_MODEM|IO$M_MAINT,0,0,0,
   &chars,0,0,0,0,0)))
  return(L_ERR);
 return(success);
}

int l_speed(speed)		/* set the speed for the line */
 int speed;
{int s;
 struct tt_mode ttchr;

 if (speed < 0)			/* Unknown speed fails */
  return(success);
 for (s = 0; speeds[s] != 0 && speeds[s] != speed; s++) ;
 if (speeds[s] == 0)
  return(failure);
 ret = SYS$QIOW(L_EFN,linejfn,IO$_SENSEMODE,0,0,0,
   &ttchr,sizeof ttchr,0,0,0,0);
#if debugsw
printf("ret = %X\n",ret);
#endif
 ret = SYS$QIOW(L_EFN,linejfn,IO$_SETMODE,0,0,0,
   &ttchr,sizeof ttchr,speedcodes[s],0,0,0);
#if debugsw
printf("ret = %X\n",ret);
#endif
 if (nok(ret))		        /* set the speed */
 {printf("Speed set failed\n");
  return(failure);
 }
 else
  return(success);
}

int l_close()			/* close the line */
{sleep(1);			/* wait a while */
 ret = SYS$QIOW(L_EFN,linejfn,IO$_SETMODE,0,0,0,
   &orig_mode,sizeof(orig_mode),0,0,0,0); /* ignore any error here */
 if (nok(SYS$DASSGN(linejfn)))
  return(L_ERR);
 linejfn = 0;
 return(success);
}
