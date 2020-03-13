/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Bug handling, checkpointing, dumps.
 */

#include "domsym.h"
#include <macsym.h>
#include <monsym.h>
#include <jsys.h>
#include <stdarg.h>

/*
 * Forwards
 */
static int psiini(void);
int bugdmp(void);
int bootme(char *,int delay);

/*
 * External(s)
 */

/* sio20x.c */
extern int fufpgs(FILE *,int);

/* How many pages for SSAVE% to dump. */
#ifndef NPAGES
#define NPAGES 040000
#endif

/* Where error output should go. */
#ifndef	STDBUG
#define	STDBUG	stdout
#endif
static FILE *stdbug = STDBUG;

/* Debugging flags. */
#ifndef DBGFLG_INITIAL
#define DBGFLG_INITIAL 0
#endif
int dbgflg = DBGFLG_INITIAL;

/* Minutes to delay rebooting */
#ifndef REBOOT_DELAY
#define	REBOOT_DELAY	5
#endif
static int reboot_delay = REBOOT_DELAY;

static char bugxjn[40] = "??????";

/* These can't be static since they are referenced in assembly code */
char7 bugfnm[60] = "???";
char7 dmpnam[40*4];
int bugrtm, bugctm, bugjer, bugfkx;
int bugac_[020],  bugvec[2];
int chkacs[020], chkvec[2];
int bugpc[6], bugrcm, bugrwm, bugrlm, bugaos = -1, bugchn;
int *levtab[] = { bugpc, bugpc+2, bugpc+4};
char *boot_file = NULL;
int *boot_p = NULL;
int *dump_p = NULL;

/* Argument for all SSAVE% calls */
int ss_arg = FLD(-NPAGES,monsym("SS%NNP"))
		      | monsym("SS%EPN") | monsym("SS%UCA") | monsym("SS%RD")
		      | monsym("SS%WR")  | monsym("SS%CPY") | monsym("SS%EXE");

/* Assembler cruft. SEARCH StudlyCapitalized to avoid preprocessor lossage. */
static void _dummy()
{
#asm
	Search	MonSym			/* Load monitor symbols */
	$level==1			/* PSI level for bugint() */

chntab:	$rpcnt==0			/* Construct channel table */
repeat 44,<
	<<$level*10000000000>+<$$SECT,,<<chnvec+$rpcnt>&777777>>>
	$rpcnt==$rpcnt+1
>
chnvec:					/* and dispatch vector */
repeat 44,<
	jsr chnjsr
>

	%%DATA
chnjsr:	0				/* Calling PC goes here */
	jrst	bugint			/* Dispatch to common code */

	%%CODE
					/* The following should be in */
					/* C-HDR but doesn't seem to be */
$retz:					/* Zero return */
$retf:	tdza	1,1			/* False return */
$rett:	 movei	1,1			/* True return */
$ret:					/* Just return */
;	popj	17,

/* Only called in assembly code, so don't need this to be a C function */

bugint:	aose	bugaos			/* Are we looping? */
	 jrst	r.i.p.			/* Yes, give up and die */
	movem	1,bugrcm		/* Get info on PSI status for dump */
	movei	1,.fhslf		/* Get active channel mask */
	rcm%
	 erjmp [setz 1,			/* Fake zero mask on lossage */
		jrst .+1]		/* (never happens) */
	exch	1,bugrcm		/* Save active mask */
	movem	1,bugrwm		/* Get channels waiting */
	movem	2,bugrlm		/* and level mask */
	rwm%
	 erjmp [setzb 1,2		/* Fake zero masks on lossage */
		jrst .+1]		/* Never happens */
	exch	1,bugrwm		/* Save waiting mask */
	exch	2,bugrlm		/* Save level mask */
	movem	1,bugchn		/* Get channel that interrupted */
	xmovei	1,chnvec+1		/* Channel dispatch vector */
	movns	1			/* (compensate for PC incrementing) */
	add	1,chnjsr		/* Determine vector offset */
	exch	1,bugchn		/* That's our channel number */
	push	17,bugpc+<$level*2>-1	/* Try to fake a PUSHJ */
	 erjmp	.+1			/* but don't lose recursively */
	pushj	17,bugdmp		/* Make dump now while we still */
	 erjmp	.+1			/* have all our ACs intact */
	jrst	.abort			/* Enter fake abort() handler */

/* Turn off PSI and halt as illegally as possible [like KCC abort()]. */

r.i.p.:	movei	1,.fhslf		/* Get most recent error */
	geter%				/* (XCT 0 will overwrite it) */
	 erjmp	.+2
	  skipa	5,2			/* Got error code, save it */
	   move	5,1			/* Lost, save that error */
	movei	1,.fhslf		/* This fork */
	dir%				/* Disable interrupts */
	 erjmp	.+1			/* Say WHAT? */
	hrroi	1,[asciz/Rust In Pieces
/]
	esout%				/* This is not a proceedable error */
	 erjmp	.+1			/* Gee, we are really in trouble */
	seto 1,				/* All queues owned by this job */
	reliq%				/* Release possible IP input queue */
	 erjmp .+1
	0				/* Execute very illegal instruction  */
	jrst	r.i.p.			/* Loop forever */
#endasm
}

int bugini(xjname,stream,rebootf,rebootp,dumpp)
    char *xjname;
    FILE *stream;
    char *rebootf;
    int *rebootp;
    int *dumpp;
{
    char7 *s = bugfnm;
    char *t;
    if (0) _dummy();		/* cretin compiler */
    if(stream != NULL)
	stdbug = stream;
    strncpy(bugxjn,xjname,39);		/* don't allow overflow */
				/* sprintf() doesn't like char7 any more */
    for(t = "DOMAIN:"; *t; *s++ = *t++);
    for(t = bugxjn; *t; *s++ = *t++);
    for(t = ".CRASH.-1"; *t; *s++ = *t++);
    if(!psiini())
	return(bugchk("bugini","couldn't initialize PSI code"),0);
    boot_file = rebootf;
    boot_p = rebootp;
    dump_p = dumpp;
    return(1);
}

/* Channels that we think are worth trapping. */
int panics = BIT(monsym(".ICPOV"))   /* Pushdown overflow */
	  | BIT(monsym(".ICDAE"))   /* File data error */
	  | BIT(monsym(".ICQTA"))   /* Quota or disk full */
	  | BIT(monsym(".ICILI"))   /* Illegal instruction */
	  | BIT(monsym(".ICIRD"))   /* Illegal memory read */
	  | BIT(monsym(".ICIWR"))   /* Illegal memory write */
	  | BIT(monsym(".ICIEX"))   /* Illegal memory execute */
	  | BIT(monsym(".ICMSE"));  /* System resources exhausted */

/* Initialize PSI stuff. */
static int psiini()
{
#asm
	movei	1,.fhslf		/* We can't coexist with other PSI */
	skpir%				/* code, so check if it's already on */
	 skipa				/* No, we're ok */
	  jrst	$retf			/* Yes, lose */
	movei	2,3			/* Argblock is in AC5 */
	movei	3,3			/* Three words of argument */
	xmovei	4,levtab		/* LEVel TABle */
	xmovei	5,chntab		/* CHaNnel TABle */
	xsir%				/* Set table addresses */
	 erjmp	$retf			/* Lose */
	move	2,panics		/* Panic channel bits */
	aic%				/* Turn on panic channels */
	 erjmp	$retf			/* Lost */
	eir%				/* Enable interrupts */
	 erjmp	$retf			/* Lost */
	movei	1,1			/* Won, give good return */
;	popj	17,
#endasm
}

static void bugtyo(kind,module,format,vargp)
    char *kind,*module,*format;
    va_list vargp;
{
    char time[20];
    int ac[5];
    ac[1] = (int)(time-1);
    ac[2] = -1;
    ac[3] = monsym("OT%SCL");
    jsys(ODTIM,ac);
    if(stdbug == stdout || stdbug == stderr)
	fprintf(stdbug,"%c %s [%s] %s: %s() -- ",
		*kind,time,bugxjn,kind+1,module);
    else
	fprintf(stdbug,"%s %s: %s() -- ",time,kind+1,module);
    vfprintf(stdbug,format,vargp);
    fputc('\n',stdbug);
}

void buginf(char *module, char *format, ...)
{
    va_list vargp;

    va_start(vargp,format);
    bugtyo("*BUGINF",module,format,vargp);
    va_end(vargp);
    if(DBGFLG(DBG_FORCE))
	fufpgs(stdbug,0);
}

void bugfls()
{
    static int old_ftell = 0;
    if(ftell(stdbug) > old_ftell) {
	fufpgs(stdbug,0);
	old_ftell = ftell(stdbug);
    }
}

void bugchk(char *module, char *format, ...)
{
    va_list vargp;

    va_start(vargp,format);
    bugtyo("%BUGCHK",module,format,vargp);
    va_end(vargp);
    fufpgs(stdbug,0);
}

void bughlt(char *module, char *format, ...)
{
    extern void _cleanup(void);
    int doboot;
    va_list vargp;

    bugdmp();
    va_start(vargp,format);
    bugtyo("?BUGHLT",module,format,vargp);
    va_end(vargp);
    if(stdbug != stderr) {
	FILE *save_stdbug = stdbug;	/* Stash this pointer */
	stdbug = stderr;		/* Point at error output (tty) */
	va_start(vargp,format);		/* Redo this in gory detail for */
	bugtyo("?BUGHLT",module,format,vargp);
	va_end(vargp);
	stdbug = save_stdbug;		/* Restore error output */
    }
    doboot = (boot_p != NULL && *boot_p && boot_file != NULL);
    if(dmpnam[0] != '\0')		/* Log dump file name */
	buginf("bughlt","dumped to %s",dmpnam);
    docrit(0);				/* Unlock things, carefully */
    if(doboot)
	buginf("bughlt","rebooting in %d minute%s",
		reboot_delay,(reboot_delay == 1 ? "" : "s"));
    fufpgs(stdbug,1);			/* Force out final log stuff */
    _cleanup();				/* Ask STDIO to clean itself up */
    if(doboot)				/* Want reboot? */
	bootme(rb_name,reboot_delay*60*1000); /* Yes, do it */
    else				/* No, */
#asm
	jrst r.i.p.			/* Commit honorable suicide */
#endasm
}

bootme(filename,delay)
    char *filename;
    int delay;
{
#asm
	skiple	1,-2(17)		/* Delay a while */
	 disms%				/* to prevent tight looping */
	movsi	1,(gj%sht+gj%old)
;	%chrbp	2,-1(17)
	seto	2,
	adjbp	2,-1(17)
	gtjfn%				/* Try to find bootstrap file */
	 erjmp	$ret			/* Lost, give up */
	hrli	1,.fhslf		/* Make GET% handle */
	move	16,[ac$cod,,5]		/* Copy code into ACs */
	blt	16,ac$max
	jrst	5			/* And away we go */

/* Pure code to go into ACs to reboot */
ac$cod:	get%				/* AC5:  Load bootstrap image */
	movei	1,.fhslf		/* AC6:  Get entry vector */
	xgvec%				/* AC7:  */
	setz	2,			/* AC10: Clear PC flags */
	xjrstf	2			/* AC11: And off we go */
	0				/* AC12: Never get here */
ac$max==.-ac$cod+5
#endasm
}

/* Catch errors from KCC runtimes; this replaces the normal abort() routine. */
void abort()
{
    bughlt("abort","called from KCC internals");
}

/* Explainations of all hardwired PSI channels, panic or not. */
static char *chnmsg[36] = {	    NULL, NULL, NULL, NULL, NULL, NULL,
    "arithmetic overflow",		/* .ICAOV */
    "floating overflow",		/* .ICFOV */	NULL,
    "PDL overflow",			/* .ICPDL */
    "untrapped EOF",			/* .ICEOF */
    "file data error",			/* .ICDAE */
    "disk quota exceeded",		/* .ICQTA */	NULL, NULL,
    "illegal instruction",		/* .ICILI */
    "illegal memory read",		/* .ICIRD */
    "illegal memory write",		/* .ICIWR */
    "illegal memory execute",		/* .ICIEX */
    "inferior process termination",	/* .ICIFT */
    "system resources exhausted",	/* .ICMSE */	NULL,
    "non-existant page"			/* .ICNXP */
};

/* Catch errors that made it to panic interrupts. */
void _abort()
{
    if(bugchn >= 0 && bugchn <= 35 && chnmsg[bugchn] != NULL)
	bughlt("abort",chnmsg[bugchn]);
    else
	bughlt("abort","interrupt on unknown channel %d",bugchn);
}

/* Make a crash dump. */
int bugdmp()
{
#asm
	bugacs=<$$sect,,bugac.>		/* Kludge for FILDDT */

	skipe	dump.p			/* See if defined... */
	 skipn	@dump.p			/* Yes, check flag */
	  popj	17,			/* Undefined or off, give up */
	setzm	@dump.p			/* Please, not again! */
	dmovem	0,bugac.+0		/* Save ACs */
	move	1,[2,,bugac.+2]
	blt	1,bugac.+17
	movei	1,.fhslf		/* Last error */
	geter%
	 ercal	r.i.p.
	movem	2,bugjer
	runtm%				/* Runtime */
	 ercal	r.i.p.
	movem	1,bugrtm
	movem	3,bugctm
	move	1,[sixbit 'FORKX']	/* Fork index if available */
	sysgt%
	 ercal	r.i.p.
	skipn	2
	 seto	1,
	movem	1,bugfkx
	movsi	1,(gj%sht+gj%fou)	/* Get handle on dump file */
	hrroi	2,bugfnm
	gtjfn%
	 ercal	r.i.p.
	move	5,1
	hrroi	1,dmpnam		/* Remember its name */
	move	2,5
	move	3,[js%spc]
	jfns%
	 erjmp	.+1
	move	1,5			/* Do the dump */
	hrli	1,.fhslf
	move	2,ss.arg
	setz	3,
	ssave%
	 ercal	r.i.p.
;	popj	17,			/* Done */
#endasm
}

/* Make checkpoint files with specified filename. */

int chkpnt(filename)
    char *filename;
{
#asm
	$$tnsz==<<50+50+50+50+6>/5>+1	/* Size of truename buffer on stack */
					/* (max dev+dir+fn1+fn2+gen) */
	dmovem 16,chkacs+16		/* Save all ACs */
	movei 16,chkacs
	blt 16,chkacs+15
	movei 1,.fhslf			/* Get current entry vector */
	xgvec%
	 ercal chkerr			/* Should never happen */
	dmovem 2,chkvec			/* Stash it */
	movei 2,1			/* Set up a one word vector that */
	xmovei 3,ck$but			/* will restart us at the right place */
	xsvec%
	 ercal chkerr			/* Should never happen */
	movsi 1,(gj%sht+gj%fou)		/* Get handle on dump file */
;	%chrbp 2,-1(17)			/* Where caller put filename */
	seto 2,
	adjbp 2,-1(17)
	gtjfn%
	 ercal chkerr			/* Should never happen */
	move 5,1			/* Save JFN */
	adjsp 17,$$tnsz			/* Make room on stack for truename */
	move 1,[440717,,<-<$$tnsz-1>>]	/* Address of truename buffer */
	move 2,5			/* Write truename into this buffer */
	move 3,[js%spc]			/* Complete filename */
	jfns%
	 ercal chkerr			/* Shouldn't happen */
	move 1,5			/* Get back the dump file JFN */
	hrli 1,.fhslf			/* Make the dump */
	move 2,ss.arg
	setz 3,				/* Starting at page 0 */
	ssave%				/* Save the image */
	 erjmp ck$luz			/* This might conceivably fail */
	hrrei 1,CHKPNT_WIN		/* Signal we won */
	jrst ck$win			/* Skip over error case code */

ck$luz:	move 5,1			/* Get back the JFN */
	rljfn%				/* Try to release it */
	 erjmp .+1			/* Ignore errors */
	hrrei 1,CHKPNT_LOSE		/* Signal lossage */
					/* Fall through... */
ck$win:	push 17,1			/* Second argument is error status */
	xmovei 2,-$$tnsz(17)		/* Point at truename */
	push 17,2			/* First argument is truename */
	pushj 17,chklog			/* Do any necessary output */
	move 5,-1(17)			/* Get back error status (untouched) */
	adjsp 17,-<$$tnsz+2>		/* Fix stack */
	movei 1,.fhslf			/* Put back normal KCC entry vector */
	dmove 2,chkvec
	xsvec%
	 ercal chkerr			/* Shouldn't happen */
	move 1,5			/* Set return value to status */
	popj 17,			/* And done */

/* Come here when rebooting from saved image */
ck$but:	movei 1,.fhslf			/* Restore entry vector to original */
	dmove 2,chkvec			/* value when this dump was made */
	xsvec%
	 erjmp .+1			/* Oh well, hope for the best */
	movsi 17,chkacs			/* Restore all ACs */
	blt 17,17
	hrrei 1,CHKPNT_RESTART		/* Indicate that we're restarting */
;	popj 17,			/* Done */
#endasm
}

/* tiny routines to make chkpnt() simpler. */
void chklog(truename,status)
    int *truename, status;		/* chkpnt() wants status back intact */
{
#define	TRUENAME ((_KCCtype_char7 *)truename)
    switch(status) {
	case CHKPNT_LOSE:
	    bugchk("chkpnt","unable to make dump \"%s\"", TRUENAME);
	    break;
	case CHKPNT_WIN:
	    if(DBGFLG(DBG_CHKPNT))
		buginf("chkpnt","dumped to \"%s\"", TRUENAME);
	    break;
	case CHKPNT_RESTART:
	    bugchk("chkpnt","how the bleep did I get here????");
	    break;
	default:
	    bughlt("chkpnt","unknown status code %d",status);
    }
#undef TRUENAME
}

void chkerr()
{
    bughlt("chkerr","unexpected JSYS error");
}
    