/* TOPS-20 version of Unix-style system() [13-Mar-87]
************************************************************************
** Updates:
** [04-Apr-87] Add  handling  of  CTL-A (abort),  CTL-B  (break),  CTL-P
** (proceed),  and  CTL-X  (single   step)  (just  like  enhanced   MIC)
** transparently to caller!
**
** [06-Apr-87] Add CTL-Y (re-execute) to recover from garbled typeahead
************************************************************************
**
** Returns 0 on success, 127 (yes, 127) on failure.
**
** This version creates an EXEC in  an inferior fork on the first  call,
** preserving the fork in a  halted status across calls for  efficiency.
** It uses  the STI%  JSYS to  feed the  command line  to the  EXEC  for
** processing, thereby allowing any valid  EXEC command or user  program
** to be executed.   However, if  the command  itself requires  terminal
** input  (e.g.   invoking   a  text   editor),  this	will  not   work
** satisfactorily, because  we  stuff  additional  input to POP back to
** this routine.
**
** All of  this trouble  would be  unnecessary if  the EXEC  would  read
** commands from a file opened on its .PRIIN, and then halt (as if a POP
** were typed) when it hit end-of-file on input;  the current EXEC  goes
** into an infinite loop issuing "?Unexpected EOF" messages.
**
*/

#define INTERRUPT 1		/* 0 to disable interrupt trapping */

#include <stdio.h>
#include <jsys.h>
#include <monsym.h>

static void stichr();			/* private simulate terminal input routines */
static int syssti();
static int waitti();

#if INTERRUPT
#define CH_ABORT	'A'		/* interrupt control characters */
#define CH_BREAK	'B'		/* (these are reduced to CTL-x by */
#define CH_PROCEED	'P'		/* initis()) */
#define CH_REEXECUTE	'Y'
#define CH_STEP		'X'

static int flgabt;			/* set on CH_ABORT */
static int flgbrk;			/* set on CH_BREAK */
static int flgpro;			/* set on CH_PROCEED */
static int flgree;			/* set on CH_REEXECUTE */

static void chkabt();			/* check for abort condition */
static void chkbrk();			/* check for break condition */
static void initis();			/* initialize interrupt system */
static void intabt();			/* trap for CH_ABORT */
static void intbrk();			/* trap for CH_BREAK */
static void intpro();			/* trap for CH_PROCEED */
static void intree();			/* trap for CH_REEXECUTE */
static void intstp();			/* trap for CH_STEP */
static void waitpr();			/* wait for CH_PROCEED */
#endif

#define SUCCESS (0)
#define FAILURE (127)			/* standard Unix system() error return */

#define JSYS(jsysname) if (jsys(jsysname,acs) != JSok) \
    {\
	ac1 = _PRIOU;\
	ac2 = MAKEWORD(_FHSLF,-1);\
	ac3 = 0;\
	(void)jsys(ERSTR,acs);\
	return (FAILURE);\
    }

#if INTERRUPT
static void
chkabt()			/* check for interrupt flags set */
{
    if (flgabt)
    {
	(void)fflush(stderr);
	fprintf(stderr,"\n[Aborted by CTL-%c]\n",CH_ABORT);
	exit(1);
    }
}


static void
chkbrk()			/* check for interrupt flags set */
{
    if (flgbrk)
    {
	waitti();		/* wait for quiet fork (avoids mixed output) */
	(void)fflush(stderr);
	fprintf(stderr,
	    "\n\007[Break <CTL-%c>; Step <CTL-%c>; Proceed <CTL-%c>; \
Abort <CTL-%c>; Redo <CTL-%c>]\n",
	    CH_BREAK,CH_STEP,CH_PROCEED,CH_ABORT,CH_REEXECUTE);
	waitpr();
	fprintf(stderr,"[Proceeding]\n");
    }
}

static void
intabt()				/* THIS IS NOT CALLABLE FROM C! */
{
    asm("AOS ,FLGABT\n\
	AOS ,FLGPRO\n\
	SETZM FLGBRK\n\
	SETZM FLGREE\n\
	PUSH 17,1\n\
	MOVE 1,[POINT 7,[ASCIZ '\n[Ctl-A -- aborting]\n']]\n\
	PSOUT\n\
	POP  17,1\n\
	DEBRK\n");
}

static void
intbrk()				/* THIS IS NOT CALLABLE FROM C! */
{
    asm("AOS ,FLGBRK\n\
	PUSH 17,1\n\
	MOVE 1,[POINT 7,[ASCIZ '\n[Ctl-B -- breaking]\n']]\n\
	PSOUT\n\
	POP  17,1\n\
	DEBRK\n");	/* cannot change registers! */
}

static void
intpro()				/* THIS IS NOT CALLABLE FROM C! */
{
    asm("AOS ,FLGPRO\n\
	SETZM FLGBRK\n\
	PUSH 17,1\n\
	MOVE 1,[POINT 7,[ASCIZ '\n[Ctl-P -- proceeding]\n']]\n\
	PSOUT\n\
	POP  17,1\n\
	DEBRK\n");
}

static void
intree()				/* THIS IS NOT CALLABLE FROM C! */
{
    asm("AOS ,FLGREE\n\
	PUSH 17,1\n\
	MOVE 1,[POINT 7,[ASCIZ '\n[Ctl-Y -- redoing]\n']]\n\
	PSOUT\n\
	POP  17,1\n\
	DEBRK\n");	/* cannot change registers! */
}

static void
intstp()				/* THIS IS NOT CALLABLE FROM C! */
{
    asm("AOS ,FLGPRO\n\
	AOS ,FLGBRK\n\
	PUSH 17,1\n\
	MOVE 1,[POINT 7,[ASCIZ '\n[Ctl-X -- single-stepping]\n']]\n\
	PSOUT\n\
	POP  17,1\n\
	DEBRK\n");	/* cannot change registers! */
}

/*
** initis(c,intrtn) initializes the  interrupt system  to call  intrtn()
** when control character c is typed.   Up to 13 different traps can  be
** set.  intrtn() must preserve all registers and return to the  Monitor
** with the DEBRK% JSYS instead of a normal return; this implies that is
** must use KCC's  asm() directive for  its body, because  KCC does  not
** preserve registers.  The simple versions  above do nothing but set  a
** global flag and return.
*/

#define CHNAVAIL 0770000037777		/* mask of user-assignable channels */
#define PLEVEL 2			/* priority level (lowest) */

static void
initis(c,intrtn)			/* initialize interrupt system */
int c;					/* control character to interrupt on */
void (*intrtn)();			/* routine to call when c is input */
{
    static int argblk[3] = {3, 0, 0};	/* XSIR argument block */
    static int chntab[36];		/* channel table--index by chnnum */
    static int levtab[3];		/* level table--index by level-1 */
    static int savepc[2];		/* saved program counter */
    int chnmsk;				/* channel mask */
    int chnnum;				/* channel number */
    int *p;				/* points to levtab[] and chntab[] */

    ac1 = _FHSLF;
    (void)jsys(RCM,acs);	/* return current channel mask in ac1 */

    /* Find first available channel */
    for (chnnum = 0; chnnum < 36; ++chnnum)
    {
	chnmsk = T20_BIT(chnnum);
	if (chnmsk & CHNAVAIL & ~ac1)	/* then we have found unused channel */
	{
	    chnmsk = ac1 | chnmsk;	/* add new channel to mask */
	    break;
	}
    }

    if (chnnum >= 36)			/* then no more available channels */
	return;

    /* Use any existing channel and level tables */
    ac1 = _FHSLF;
    ac2 = (int)&argblk[0];
    (void)jsys(XRIR,acs);
    if (argblk[1] == 0)			/* no existing tables, so provide ours */
    {
	argblk[1] = (int)&levtab[0];	/* address of interrupt level table */
	argblk[2] = (int)&chntab[0];	/* address of channel table */
    }

    p = (int*)argblk[1];
    *(p + PLEVEL - 1) = (int)&savepc[0];
    p = (int*)argblk[2];
    *(p + chnnum) = FLD(PLEVEL,SI_LEV) | FLD((int)intrtn,SI_ADR);

    ac1 = _FHSLF;
    ac2 = (int)&argblk[0];
    (void)jsys(XSIR,acs);	/* set addresses of channel and level tables */

    ac1 = _FHSLF;
    (void)jsys(EIR,acs);	/* enable software interrupt system */

    ac1 = _FHSLF;
    ac2 = chnmsk;
    (void)jsys(AIC,acs);	/* activate interrupt channel */

    ac1 = MAKEWORD(c & 037,chnnum);
    (void)jsys(ATI,acs);	/* assign terminal code to interrupt channel */
}
#endif


static int handle = 0;		/* fork handle remembered across calls */

int
system(command)
char* command;
{

    /* On first call, create an EXEC fork which immediately is suspended
    by a POP command.  Subsequent calls then just continue the fork for
    fast response.  */

    if (handle == 0)
    {

#if INTERRUPT
	/* Initialize the software interrupt system */
	initis(CH_ABORT,intabt);
	initis(CH_BREAK,intbrk);
	initis(CH_PROCEED,intpro);
	initis(CH_STEP,intstp);
	initis(CH_REEXECUTE,intree);
#endif

	ac1 = CR_CAP;			/* make fork with our capabilities */
	JSYS(CFORK);
	handle = ac1;

	ac1 = GJ_OLD | GJ_SHT;		/* get jfn for EXEC */
	ac2 = POINT("SYSTEM:EXEC.EXE");
	JSYS(GTJFN);

	ac1 = MAKEWORD(handle,ac1);	/* get EXEC into fork */
	JSYS(GET);

	ac1 = handle;			/* start the fork */
	ac2 = 0;			/* at offset 0 in entry vector */
	JSYS(SFRKV);
    }
    else	/* EXEC is waiting to be continued at each entry */
    {
	ac1 = GETRIGHT(handle);		/* check the fork status */
	JSYS(RFSTS);

	ac1 = GETLEFT(ac1 & RF_STS);	/* select status bits */
	if (ac1 != _RFHLT)		/* wait for halt if necessary */
	{
	ac1 = handle;
	JSYS(WFORK);			/* wait for the halt */
	}

	ac1 = GETRIGHT(handle);		/* continue the fork */
	ac1 |= SF_CON;
	JSYS(SFORK);
	ac1 = handle;
	JSYS(RFORK);
    }

#if INTERRUPT
    chkabt();
    if (flgbrk > 1)			/* two breaks needed to pause at entry */
	chkbrk();
#endif

    if (syssti(command))		/* process user's command */
	return (FAILURE);

    waitti();				/* wait for them to finish */

    if (syssti("\rPOP\r"))		/* halt the EXEC */
	return (FAILURE);

    ac1 = handle;
    JSYS(WFORK);			/* wait for the halt */

#if INTERRUPT
    while (flgree)
    {
	flgree = 0;
	system(command);
    }
#endif

    return (SUCCESS);			/* all done! */
}

static void
stichr(c)
int c;
{
    for (;;)
    {
	ac1 = _PRIIN;
	ac2 = c;
	if (jsys(STI,acs) != JSok)
	{				/* failure means buffer full, so */
	    ac1 = 100;			/* sleep for 100 msec and try again */
	    (void)jsys(DISMS,acs);
	    continue;
	}
	break;
    }

#if INTERRUPT
    if (c == '\r')		/* check for breaks only at end-of-line */
    {
	chkabt();
	chkbrk();
    }
#endif

}

/* Copy s[] into terminal input buffer for an inferior fork.  LF is */
/* changed to CR, and a final CR is automatically supplied.  Returns */
/* SUCCESS or FAILURE.  On SUCCESS, the fork is left awaiting terminal */
/* input.   The algorithm is borrowed from MIC as implemented in */
/* EXECMI.MAC */

static int
syssti(s)
register char* s;
{
    int c = '\r';			/* initialize in case s == "" */

    while (*s)
    {
	c = (*s == '\n') ? '\r' : *s;
	stichr(c);
	++s;
    }

    /* Supply final CR if one was not provided */
    if (c != '\r')
	stichr('\r');

    return (SUCCESS);
}

static int
waitti()		/* wait until job waiting for terminal input*/
{			/* Returns SUCCESS or FAILURE */
    int delay = 0;			/* delay time in msec */

    /* This code is borrowed from EXECMI's WAIT function.  It sleeps for */
    /* increasing intervals, but no longer than 1 sec at a time. */

    for (;;)
    {
	ac1 = _PRIIN;
	ac2 = _MOPIH;
	JSYS(MTOPR);			/* find out if job needs input */
	if (ac2 == _MOWFI)
	    break;

	ac1 = handle;			/* not in TI state; did fork halt? */
	JSYS(RFSTS);
	ac1 = GETLEFT(ac1 & RF_STS);	/* select status bits */
	if (ac1 == _RFHLT)		/* if fork halted, no need to */
	    break;			/* wait anymore */

	delay = (delay < 1000) ? delay + 100 : delay;
	ac1 = delay;			/* sleep awhile and try again */
	JSYS(DISMS);
    }
    return (SUCCESS);
}

#if INTERRUPT
static void
waitpr()				/* wait for proceed */
{
    while (!flgpro)
	sleep(1);
    flgpro = 0;
}
#endif

