/* Cafard.C   -*-C-*- */

#include <stdio.h>
#include <ctype.h>
#include <time.h>
#include "igdef.h"
#include "cafdef.h"

/*      Cafard - translated into C by John M. Relph
		from

	TITLE CAFARD Program to exchange mail via TTY line
	SUBTTL Written by Mark Crispin/MRC CMIRH 19 July 1984

; Copyright (C) 1984, 1985, 1986 Mark Crispin.  All rights reserved.

;  This is an interim program, supposedly to be replaced by the real,
; wonderful program, written in a high-level language, knowing the
; answer to Life, the Universe, and Everything...
;
;  I fear that by the time you read these comments, gentle reader, that
; it is years after I wrote this program, and it is running everywhere.
; Hence the name Cafard -- this program might easily become as ubiquitous
; as a cockroach!
;
;  If you don't believe this is where the name comes from, I have another
; story, but it'll cost you a beer to hear it...

*/

#define FILPGS 10		/* number of file pages to PMAP% at a time */
#define LINBSZ 40		/* line buffer size in words */
#define LINTBL 20		/* max number of lines to try */
#define NOTRYS 10		/* number of tries to open before giving up */
#define LOOPMX 10		/* maximum number of iterations of a loop */

FILE *jfn;
int trycount,loopptr,loopcnt,loseflag,line_cnt;
int speedtab[LINTBL];
char *linetab[LINTBL];
char *queline, *sndline;
char *hostname, *username;   /* our host and username */
 
extern int p_init();	        /* cafpro */
extern int p_bin();

extern int linecount;		/* cafio */
extern int linejfn;

extern int l_open();		/* cafio */
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

extern int gloopdone();		/* these are forward declarations */
extern int gbogus();
extern int glose();
extern int gbegin();
extern int gloop();
extern int glexit();
extern int geat();
extern int gwait();
extern int gcomnt();
extern int gstext();
extern int gmesag();
extern int gequal();		/* end of foward declarations */

int dialog_char;		/* global dialog character */
typedef int PFun();		/* PFun is a pointer to a function ret int */
static PFun *dialog_function[128] =
 {0,				/* ^@ ignored */
  gbogus,			/* ^A bogus character */
  gbogus,			/* ^B bogus character */
  gbogus,			/* ^C bogus character */
  gbogus,			/* ^D bogus character */
  gbogus,			/* ^E bogus character */
  gbogus,			/* ^F bogus character */
  gbogus,			/* ^G bogus character */
  gbogus,			/* ^H bogus character */
  0,				/* ^I whitespace ignored */
  0,				/* ^J whitespace ignored */
  gbogus,			/* ^K bogus character */
  0,				/* ^L whitespace ignored */
  0,				/* ^M whitespace ignored */
  gbogus,			/* ^N bogus character */
  gbogus,			/* ^O bogus character */
  gbogus,			/* ^P bogus character */
  gbogus,			/* ^Q bogus character */
  gbogus,			/* ^R bogus character */
  gbogus,			/* ^S bogus character */
  gbogus,			/* ^T bogus character */
  gbogus,			/* ^U bogus character */
  gbogus,			/* ^V bogus character */
  gbogus,			/* ^W bogus character */
  gbogus,			/* ^X bogus character */
  gbogus,			/* ^Y bogus character */
  gbogus,			/* ^Z bogus character */
  gbogus,			/* ^[ bogus character */
  gbogus,			/* ^\ bogus character */
  gbogus,			/* ^] bogus character */
  gbogus,			/* ^^ bogus character */
  gbogus,			/* ^_ bogus character */
  0,				/* SPACE whitespace ignored */
  gcomnt,			/* ! comment toggle */
  gstext,			/* " send text */
  gbogus,			/* # bogus character */
  gbogus,			/* $ bogus character */
  gbogus,			/* % bogus character */
  gbogus,			/* & bogus character */
  gbogus,			/* ' bogus character */
  gbogus,			/* ( bogus character */
  gbogus,			/* ) bogus character */
  gbogus,			/* * bogus character */
  0,				/* + success clause, ignored here */
  gbogus,			/* , bogus character */
  0,				/* - failure clause, ignored here */
  gbogus,			/* . bogus character */
  gbogus,			/* / bogus character */
  gbogus,			/* 0 bogus character */
  gbogus,			/* 1 bogus character */
  gbogus,			/* 2 bogus character */
  gbogus,			/* 3 bogus character */
  gbogus,			/* 4 bogus character */
  gbogus,			/* 5 bogus character */
  gbogus,			/* 6 bogus character */
  gbogus,			/* 7 bogus character */
  gbogus,			/* 8 bogus character */
  gbogus,			/* 9 bogus character */
  gbogus,			/* : bogus character */
  gbogus,			/* ; bogus character */
  gbegin,			/* < begin loop */
  gequal,			/* = test for desired string */
  gloopdone,			/* > end of loop */
  gbogus,			/* ? bogus character */
  gbogus,			/* @ bogus character */
  gbogus,			/* A bogus character */
  gbogus,			/* B bogus character */
  gbogus,			/* C bogus character */
  gbogus,			/* D bogus character */
  geat,				/* E eat input */
  gbogus,			/* F bogus character */
  gbogus,			/* G bogus character */
  gbogus,			/* H bogus character */
  gbogus,			/* I bogus character */
  gbogus,			/* J bogus character */
  gbogus,			/* K bogus character */
  glose,			/* L dialog lossage */
  gbogus,			/* M bogus character */
  gbogus,			/* N bogus character */
  gbogus,			/* O bogus character */
  gbogus,			/* P bogus character */
  gbogus,			/* Q bogus character */
  gbogus,			/* R bogus character */
  gbogus,			/* S bogus character */
  gbogus,			/* T bogus character */
  gbogus,			/* U bogus character */
  gbogus,			/* V bogus character */
  gwait,			/* W wait 250 ms */
  glexit,			/* X exit loop */
  gbogus,			/* Y bogus character */
  gbogus,			/* Z bogus character */
  gmesag,			/* [ output to terminal */
  gbogus,			/* \ bogus character */
  gbogus,			/* ] bogus character */
  gloop,			/* ^ go to top of loop */
  gbogus,			/* _ bogus character */
  gbogus,			/* ` bogus character */
  gbogus,			/* a bogus character */
  gbogus,			/* b bogus character */
  gbogus,			/* c bogus character */
  gbogus,			/* d bogus character */
  geat,				/* e eat input */
  gbogus,			/* f bogus character */
  gbogus,			/* g bogus character */
  gbogus,			/* h bogus character */
  gbogus,			/* i bogus character */
  gbogus,			/* j bogus character */
  gbogus,			/* k bogus character */
  glose,			/* l dialog lossage */
  gbogus,			/* m bogus character */
  gbogus,			/* n bogus character */
  gbogus,			/* o bogus character */
  gbogus,			/* p bogus character */
  gbogus,			/* q bogus character */
  gbogus,			/* r bogus character */
  gbogus,			/* s bogus character */
  gbogus,			/* t bogus character */
  gbogus,			/* u bogus character */
  gbogus,			/* v bogus character */
  gwait,			/* w wait 250 ms */
  glexit,			/* x exit loop */
  gbogus,			/* y bogus character */
  gbogus,			/* z bogus character */
  gbogus,			/* { bogus character */
  gbogus,			/* | bogus character */
  gbogus,			/* } bogus character */
  0,				/* ~ end of conditional, ignored */
  gbogus			/* RUBOUT bogus character */
 };

static void error_msg(string)
 char *string;
{printf("\n%% %s\n",string);
}

static int notify_mailer()	/* empty now, maybe something later */
{
} 

static void init()
{int i;
 FILE *jfn;
 char *p, *q;

 for (i = 0; i < LINTBL; ++i)   /* init some global strings */
  linetab[i] = (char *) calloc(10,sizeof(char));
 queline = (char *) calloc(S_MAX,sizeof(char));
 sndline = (char *) calloc(S_MAX,sizeof(char));
 linecount = 0;			/* nothing in line input buffer */
 hostname = (char *) calloc(7,sizeof(char)); /* hostnames are <= 6 chars */
 username = (char *) calloc(41,sizeof(char)); /* usernames <= 40 */
 if ((jfn = fopen("hostname.txt","r")) == NULL)
  error_msg("Cannot find hostnames");
 else
 {if (fgets(queline,S_MAX,jfn) == NULL)
   error_msg("Cannot read hostname");
  p = queline;
  q = hostname;		        /* get ready to copy our hostname */
  while (isalnum(*p) || *p == '-' || *p == '_')
    *q++ = *p++; /* copy hostname */
  *q = '\0';		        /* asciz it */
  if (fgets(queline,S_MAX,jfn) == NULL)
   error_msg("Cannot read username");
  p = queline;
  q = username;		        /* get ready to copy username */
  while (isalnum(*p) || *p == '_') *q++ = *p++; /* copy it */
  *q = '\0';			/* asciz this too */
#if debugsw
printf("User: %s, Host: %s\n",username,hostname);
#endif
  fclose(jfn);
 }
}

static void server()
{}
/*
SERVER:	MOVX A,GJ%SHT		; get JFN on our terminal
	HRROI B,[ASCIZ/TTY:/]
	GTJFN%
	 ERCAL FATAL
	MOVEM A,LINJFN		; save line JFN
	MOVX B,<<FLD 7,OF%BSZ>!OF%WR!OF%RD> ; open read/write
	OPENF%
	 ERCAL FATAL
	RFMOD%			; get current mode
	TRZ B,TT%DAM!TT%PGM	; binary mode
	SFMOD%
	 ERCAL FATAL
	STPAR%
	 ERCAL FATAL
	HRROI B,[ASCIZ/Cockroach
/]				; send expected greeting
	SETZ C,
	CALL $SOUT
	 RET
	CALL $PINIT		; initialize protocol
	CALL RECVER		; receive what the other end has for us
	IFSKP.
	  CALL $WAKE		; wake up the mailer
	  CALL SENDER		; send what we have over
	ANSKP.
	  HRROI B,[ASCIZ/hcaorkcoC
/]				; send expected greeting
	  SETZ C,
	  CALL $SOUT
	   RET
	ENDIF.
	RET
*/

static void drafac()	        /* don't think we'll be running this */
{
 init();
 for (;;)
  server();			/* forever */
}

/* Establish connection */

static void dialog_context()
{trycount = NOTRYS;
 line_cnt = 0;
 loopptr = 0;
 loseflag = 0;
}
 
static int get_connection()
{int i,count,dialog_pointer;
 char *j;

 dialog_context();
 if (!(jfn = fopen("open_dialog.txt","r+"))) /* open the file for read */
 {error_msg("Can't open dialog file");
  exit();
 };
 for (count = 0; count < LINTBL; ++count) /* read a tty string */
 {j = linetab[count];
  *j = '\0';		        /* zero in case no entry */
  while (isalnum(i = getc(jfn)) || (i == ':'))
   *j++ = i;
  *j = '\0';		        /* asciz it */
  if (i == '/')			/* indicates a speed */
  {if (!fscanf(jfn,"%d",&i))
   {error_msg("Bogus speed in dialog file");
    return(failure);
   };
   speedtab[count] = i;		/* save the speed */
   i = getc(jfn);
  };
  if (i != ',')		        /* if is comma, get another line */
   break;
 };
 if (i == ',')
 {error_msg("Line table too long in dialog file");
  return(failure);
 }
 else if (*(linetab[0]) == '\0')
  return(failure);	        /* need at least one entry */
 line_cnt = count;	        /* save number of lines in table */
 while (i == space || i == tab) /* skip blanks */
 {i = getc(jfn);
  if (i == '!')			/* and comments */
  {while ((i = getc(jfn)) != '!'); /* skip up to end */
   i = getc(jfn);
  }
 };
#if VMS
 if (i == lf)		        /* vax returns two lfs */
#else
 if (i == cr)		        /* maybe no cr on vax? */
#endif
  i = getc(jfn);
 if (i != lf)			/* must be eol */
 {error_msg("Extra crud in line table in dialog file");
  return(failure);
 };
 dialog_pointer = ftell(jfn);	/* save current position */
 do
 {
#if debugsw
printf("[try:%d]\n",trycount);
#endif
  for (count = 0; count <= line_cnt; ++count) /* start of line checking loop */
  {
#if debugsw
printf("[line:%d]\n",count);
#endif
   if (l_open(linetab[count]) == L_ERR)
   {printf("Line %s cannot be opened\n",linetab[count]);
    continue;			/* try next line */
   };
   l_clbuf();
   printf("Calling out on line %s\n",linetab[count]);
   l_dtrof();		        /* drop DTR */
   sleep(1);
   l_dtron();		        /* assert DTR */
   sleep(1);
   l_speed(speedtab[count]);	/* set speed */
   fseek(jfn,dialog_pointer,0);
   loopptr = -1;
   for (;;)			/* do dialog functions */
   {if ((dialog_char = getc(jfn)) != EOF)
     dialog_char &= 0177;	/* mask to 7 bit ascii charset */
    else
    {trycount = 0;	        /* hey, if we're at eof */
     break;		        /* that means we're connected! */
    };
    sprintf(queline,"%c",dialog_char); /* this is a hack, but the program */
#if 0			        /* doesn't work without it, very strange */
printf("!%d",dialog_char);
#endif
    if (dialog_function[dialog_char] &&
      (*dialog_function[dialog_char])())
    {if (! loseflag)		/* error return */
      trycount = 0;
     l_clbuf();
     l_dtrof();
     l_close(linejfn);	        /* ignore failure returns */
#if debugsw
printf("[lose]\n");
#endif
     break;
    }
   };
   if (trycount <= 0)		/* need to retry? */
    break;		        /* nope, break */
  };
  if (trycount)			/* retry? */
  {if (--trycount)		/* yes, count off one more */
   {
#if debugsw
printf("[sleeping...about to retry]\n");
#endif
    sleep(60);			/* wait a minute */
   }
   else
    error_msg("Exhausted connection retries");
  }
 }
 while (trycount > 0);
 fclose(jfn);
 if (linejfn == 0)	        /* have we a connection yet? */
  return(failure);	        /* nope, lose */
 p_init();			/* initialize protocol */
 return(success);	        /* hey, we got connected */
}

int gloopdone()			/* '>' end of loop */
{loopptr = -1;
 return(success);
}

int gbogus()			/* bogus command */
{printf("Bogus character in dialog file: %o\n",dialog_char);
 return(failure);
}

int glose()			/* 'L' dialog lossage */
{loseflag = -1;
 return(failure);
}

int gbegin()
{if (loopptr)
 {error_msg("nested loops not allowed\n");
  return(failure);
 };
 loopptr = (int) ftell(jfn);
 loopcnt = LOOPMX;
 return(success);
}

int gloop()			/* '^' resume iteration */
{if (! loopptr)
 {error_msg("'^' outside of loop\n");
  return(failure);
 };
 if (++loopcnt > 0)
 {error_msg("whoa, increment past count\n");
  return(success);		/* success means loop's done */
 };
 if (fseek(jfn,loopptr,0))	/* reset position */
 {error_msg("file won't reset - fatal\n");
  return(failure);
 };
 return(success);
}

int glexit()			/* 'X' exit loop */
{int ch,match;

 for (;;)			/* end of loop search */
 {ch = getc(jfn);
  if (ch == '>')		/* end of loop? */
   break;			/* yes, continue from that point */
  if ((ch = '"') || (ch = '!'))	/* quoted string or comment? */
  {while (match = getc(jfn) != ch); /* find end of string */
  }
  else if (ch = '[')		/* terminal string? */
  {while (ch = getc(jfn) != ']'); /* end of string yet? */
  }
 }
}

int geat()			/* 'E' eat excess input */
{int count;

 count = 6;
 for (;;)
 {if (l_sibe() == 0)		/* any characters available? */
  {l_block();			/* sleep 1 sec */
   if (--count)
    continue;			/* and try again */
   else
    break;
  }
  else if (l_bin() == L_ERR)	/* get char */
   return(failure);
 };
 return(success);
}

int gwait()			/* 'W' wait 250 ms */
{l_block();			/* for the nonce, one second instead */
 return(success);
}

int gcomnt()			/* '!' comment toggle */
{int ch;

 while ((ch = getc(jfn)) != '!');
 return(success);
}

int gstext()			/* '"' output text to line */
{int ch;

 ch = 0;
#if 0
 printf("%c",ch);		/* fucking hack, but won't work w/o it */
#endif
 while ((ch = getc(jfn)) != '"')
 {if (ch == lf)
  {if (l_bout(cr) == L_ERR) /* output cr instead of lf */
    return(failure);
  }
  else if (l_bout(ch) == L_ERR) /* output the real char in any case */
   return(failure);
 };
 return(success);
}

int gmesag()			/* '[' output message to our terminal */
{int ch;

 while ((ch = getc(jfn)) != ']') /* get char, end of message? */
  putchar(ch);
/*printf("%c",ch);*/	        /* nope, print char */
 return(success);
/*  putchar(ch); */
}

char GetChFromModem(timer)
     int *timer;
{
  int ch;

  while (*timer >= 0)
    {if (l_sibe() > 0)		/* any chars available? */
       { ch = l_bin();
#if debugsw
	 putchar(ch);
#endif
	 return(ch);
       }
    else		        /* no chars ready, wait a bit */
      {l_block();		/* supposed to be in 1/2 sec intervals */
       l_block();	        /* here it is, the second quarter sec */
     }
     --*timer;
   }
  return(-1);			/* Here if the timer has expired */
}				/* end function GetChFromModem */

int gequal()			/* '=' test for desired string */
{
  int ch, i, plen, pptr, testchar, testtimeout, testbegin, timeout, skipch;
  char pattern[80];

  timeout = 0;			/* clear running timeout val */
  while (isdigit((ch = getc(jfn)))) /* get expected quote */
    timeout = (timeout * 10) + (ch - '0');
  if (! timeout)		/* no timeout given? */
    timeout = 1;		/* allow at least 1 second */
  timeout *= 2;			/* make it in 1/2 sec intervals */
  testtimeout = timeout;	/* set it */
  if (ch != '"')		/* looking for that start quote */
    {error_msg("missing required quote\n");
     return(failure);
   };

/* Get Pattern to be matched */
  pptr = -1;
  while ((pattern[++pptr] = getc(jfn)) != '"');
  plen = pptr;
  pattern[pptr] = '\0';

  testchar = '-';		/* Assume no match */
  ch = GetChFromModem(&testtimeout);

  while ((ch > 0) && (testchar != '+'))
    {
      if (ch == pattern[0])
       {
         i = 0;
	 while ((++i < plen) && ((ch = GetChFromModem(&testtimeout)) > 0) &&
	       (ch == pattern[i]));
	 if (i >= plen)
	    testchar = '+';	/* Match */
       }
	 else
	   ch = GetChFromModem(&testtimeout);
    }

  for (;;)
    {ch = getc(jfn);		/* clause search */
     if ((ch == '~') || (ch == testchar)) /* end of conditional or clause */
       break;			/* yes, continue processing */

     if ((ch == '"') || (ch == '!')) /* string or comment? */  

       while ((skipch = getc(jfn)) != ch);	/* skip it */
     else if (ch == '[')		/* terminal string? */
       while ((skipch = getc(jfn)) != ']'); /* skip string */
   }
  return(success);
}

close_connection()		/* close dialog for the protocol */
{int ch;

#if debugsw
printf("[closing up]\n");
#endif
 dialog_context();		/* establish dialog context */
 if ((jfn = fopen("close_dialog.txt","r+")) == NULL) /* open the file */
 {error_msg("Can't open connection close dialog file\n");
  return(failure);
 };
 for (;;)
 {dialog_char = (getc(jfn) & 0177); /* mask to 7 bit ascii charset */
  if (feof(jfn) || (((int) dialog_function[dialog_char]) &&
      ((*dialog_function[dialog_char])())))
   break;
 };
 l_clbuf();
 l_dtrof();
 l_close();
 return(success);
}

parse_header(quejfn)
 FILE *quejfn;
{char *p, *host, *q, trash;
 char got_one = FALSE;

 do
 {if (fgets(queline,S_MAX,quejfn) == NULL) /* read the line */
   {
    error_msg("fgets failed");
    return(failure);
   };
  if (*queline != ff)		/* not correct mm format file? */
   {error_msg("incorrect queue file format");
    return(failure);
   };
 }
 while (queline[1] != '_');	/* until we get the From line */
 p = &queline[2];		/* get start of string */
 if (fgets(sndline,S_MAX,quejfn) == NULL)
  {
   error_msg("fgets failed");
   return(failure);
  };
 q = sndline;			/* point to start of send line */
 while (! isspace(*q)) q++;	/* find end of name */
 *q++ = '@';			/* show from host */
 while (! isspace(*p)) *q++ = *p++; /* copy hostname */
 strcpy(q,"\r\n");	        /* end with CRLF */
#if debugsw
printf("From: %s\n",sndline);
#endif
#if 1
 if (p_sout(sndline,strlen(sndline)) == P_ERR)
  return(failure);
#endif
 do
  if (fgets(queline,S_MAX,quejfn) == NULL)
  {error_msg("fgets failed");
   return(failure);
  }
 while (*queline != ff);       /* find To: section */
#if debugsw
printf("[host:%s]\n",queline);
#endif
 if (isspace(queline[1]))
  {
   error_msg("bad queue file format - need host");
   return(failure);
  }
 host = queline+1;		/* save start of host string */
 q = host;
 while (! isspace(*q)) q++;
 strcpy(q,"\r\n");		/* end with CRLF */
 while (fgets(sndline,S_MAX,quejfn) != NULL && *sndline != ff)
  {
   p = sndline;
   while (! isspace(*p)) p++;	/* find end of name */
#if 1
   *p++ = '%';			/* append funny char */
   strcpy(p,host);		/* and append fromhost */
#else
   strcpy(p,"\r\n");
#endif
#if debugsw
printf("address: %s\n",sndline);
#endif
    got_one = TRUE;
#if 1
    if (p_sout(sndline,strlen(sndline)) == P_ERR)
     return(failure);	        /* try to send the line */
  }
#endif
 sprintf(sndline,"%c\r\n",ff);	/* and formfeed to delimit */
 if (p_sout(sndline,3) == P_ERR) /* ff cr lf */
  return(failure);
/* if (rewind(quejfn))
  error_msg("Cannot reposition mail pointer"); */
 return(success);
}

int send_mail()			/* send mail to remote */
{FILE *quejfn;
 char error, *name, *q, *p, *s, *modline;
 int version;

#if debugsw
printf("[sending]\n");
#endif
 modline = (char *) calloc(S_MAX,sizeof(char));
 if (fparse("*.mes"))
  while (fnext(&name))
   {
#if debugsw
printf("[%s]\n",name);
#endif
    send_msg(name);
    free(name);
   }
 if (p_eof() == P_ERR)
  return(failure);
#if debugsw
printf("[send done]\n");
#endif
 return(success);
}

int send_msg(name)
  char *name;
 {
  FILE *quejfn;
  char error, *p;

  if ((quejfn = fopen(name,"r+")) == NULL) /* can we open it? */
    return(failure);			/* nope, return error */
  else			        /* yes, file is open */
   {
#if debugsw
printf("[%s]\n",name);
#endif
    error = FALSE;
    if (parse_header(quejfn))
      error = TRUE;
    else do
     {
      fgets(queline,S_MAX,quejfn); /* may have to fudge CRLFs here */
#if (debugsw >= 2)
printf("%s",queline);
#endif
      if (p = strchr(queline,'\n')) /* find end of string */
	strcpy(p,"\r\n");	/* and put in CRLF */
      if (p_sout(queline,strlen(queline)) == P_ERR) /* send the line */
       {

	error = TRUE;

	break;
       }
     }
    while (! (feof(quejfn) || error));
   }
  if (error)
   {
    fclose(quejfn);
    return(failure);
   }
#if 1
  if (p_eof() == P_ERR)
   {
    fclose(quejfn);
    return(failure);
   }
#endif
  fclose(quejfn);
#if debugsw
printf("deleting %s\n",name);
#endif
#if 1			        /* don't delete just yet */
  if (delete(name))
   printf("delete failed: %s\n",name);
#endif
 }

static char *weekdays[7] =
 {"Sun","Mon","Tue","Wed","Thu","Fri","Sat"};
static char *months[12] = 
 {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};

char RFC822_time(ptr)
 char *ptr;
{struct tm *cur_date;
 long int savetime;

 savetime = time(NULL);		/* get the time */
 cur_date = localtime(&savetime); /* get the localtime */
 sprintf(ptr,"%s %d %s %d %d:%02d:%02d-PST",weekdays[cur_date->tm_wday],
  cur_date->tm_mday,months[cur_date->tm_mon],cur_date->tm_year,
  cur_date->tm_hour,cur_date->tm_min,cur_date->tm_sec);
 return(success);	        /* coolo */
}

char get_unique(ptr)
  char *ptr;
 {
  struct tm *cur_date;
  long int savetime;

  savetime = time(NULL);	/* get the time */
  cur_date = localtime(&savetime); /* get the localtime */
#if VMS
  sprintf(ptr,"\0");		/* this is WEENIE */
#endif
  sprintf(ptr,"mailq:cafard_new_%d%d_%d%d%d",cur_date->tm_mon,cur_date->tm_mday,
   cur_date->tm_hour,cur_date->tm_min,cur_date->tm_sec);
  return(success);	        /* coolo */
 }

int receive_mail()		/* receive mail from remote */
{char *tmpbuf,*tmpptr,savedchar;
 FILE *mailjfn;
 int ch;
				/* get local hostname here */
#if debugsw
printf("[Listening for mail]\n");
#endif

 tmpbuf = (char *) calloc(100,sizeof(char));
 for (;;)
 {if ((ch = p_bin()) == P_ERR)
   return(failure);		/* the link died */
  if (ch == 0)			/* EOF? */
  {
#if debugsw
printf("Rec(out):EOF\n");
#endif
   break;			/* nothing more to do */
  };
  savedchar = ch;		/* save char */
  for (;;)
   {
    get_unique(tmpbuf);		/* get a unique mail queue file */
    tmpbuf = strcat(tmpbuf,".env"); /* this is the envelope file */
#if debugsw
printf("[env:%s]\n",tmpbuf);
#endif
   if ((mailjfn = fopen(tmpbuf,"w")) == NULL) /* open the file */
    {
     error_msg("Unable to open new envelope file");
     return(failure);
    };
   break;			/* dunno... */
  };
#if debugsw
printf("[opened mail file, ch=%c]\n",ch);
#endif
  if (ch == cr)			/* was there a sender argument? */
  {if (((ch = p_bin()) == P_ERR) || (ch == 0) || (ch != lf)) /* nope */
   {fclose(mailjfn);		/* Scheisse! */
#if debugsw
printf("[mail err/eof]\n");
#endif
    return(failure);		/* Goetterdaemmerung... */
   }
  }
  else
  {if (ch != lf)
    putc(lf,mailjfn);		/* 1st line of env file blank, reserved */
   putc(ch,mailjfn);		/* output first character, no blank line */
   do
   {if (((ch = p_bin()) == P_ERR) || (ch == 0)) /* read next char */
    {fclose(mailjfn);		/* Scheisse! */
#if debugsw
printf("[mail err/eof(3)]\n");
#endif
     return(failure);		/* Goetterdaemmerung... */
    };
    if (ch != cr)	        /* don't put CRs in file */
     putc(ch,mailjfn);	        /* output char */
   }
   while (ch != lf);
  };
#if debugsw
printf("Host:%s",hostname);
#endif
  do
  {if (((ch = p_bin()) == P_ERR) || (ch == 0)) /* get a byte */
   {fclose(mailjfn);		/* need to abort and delete file */
#if debugsw
printf("[mail err/eof(2)]\n");
#endif
    return(failure);
   };
#if (debugsw >= 2)
printf(">%c",ch);
#endif
   if (ch != cr)	        /* no CRs in vaxland */
    {
     if (ch != ff)
       putc(ch,mailjfn);		/* output byte to file */
    }
/*   else
     fprintf(mailjfn,"@%s",hostname); */
  }
  while (ch != ff);
#if debugsw
printf("[got ff]\n");
#endif
  fclose(mailjfn);		/* close the envelope file */
  tmpptr = strrchr(tmpbuf,'.') + 1;
  strcpy(tmpptr,"msg");
#if debugsw
printf("[msg:%s]\n",tmpbuf);
#endif
  if ((mailjfn = fopen(tmpbuf,"w")) == NULL)
   {
    error_msg("Unable to open new message text file");
    return(failure);
   }
  fprintf(mailjfn,"Received: from %s by %s with Cafard; ",username,hostname);
  if (RFC822_time(queline))
   error_msg("Can't get date/time");
  else
   fputs(queline,mailjfn);	/* output date/time */
#if 0
  fputs("\n",mailjfn);		/* and lf */
#endif
  for (;;)			/* loop to slurp message */
  {if ((ch = p_bin()) == P_ERR) /* get a byte */
   {fclose(mailjfn);		/* abort and ruin file */
    return(failure);
   }
   else if (ch == 0)	        /* 0 means EOF */
   {
#if debugsw
printf("Rec(in):EOF\n");
#endif
    break;			/* got eof, we're done with loop */
   }
   else if (ch != cr)	        /* no CRs for Vixen */
   {
#if (debugsw >= 2)
printf("*%c",ch);
#endif
    putc(ch,mailjfn);		/* output byte to file */
   }
  };
  fclose(mailjfn);		/* close off the file */
#if debugsw
printf("[got mail]");
#endif
 };				/* external loop */
 return(success);
}

static void main()		/* this is cafard() */
{init();

#if 0
 p_init();
 send_mail();
 return;
#endif

 for (;;)
 {if (get_connection())		/* try to get a connection */
  {printf("% Mail transmission lost\n");
   break;
  }
  else
  {
#if debugsw
printf("[Ok, Cafard be arunnin' on dem remote system]\n");
#endif
   if ((! send_mail()) &&	/* got one, send what we have */
       (! receive_mail()));	/* and receive what they have */
  };
#if debugsw
printf("[closing]\n");
#endif
  close_connection();
  break;
 }
}
