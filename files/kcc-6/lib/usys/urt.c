/*
**	URT - USYS Run Time support and startup
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.120, 11-Aug-1988
**	(c) Copyright Ken Harrenstien & Ian Macky, SRI International 1987
**		for all changes made since name changed to URT.C.
**	Edits for ITS:  Copyright (C) 1988 Alan Bawden
**
**	This code is invoked by the CRT (C Run Time) startup and does
** various things (such as parsing any JCL) before invoking the user's
** "main" function.
**	The URT startup should, insofar as possible, limit itself to
** only USYS functions; that is, to simulating the UN*X startup.  This
** code should NOT use the higher-level library functions such as
** printf or malloc.
*/

#include <c-env.h>	/* Include environment/config defs */
#if !(SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS) /* Systems supported for */
#error USYS runtime not coded for this system!
#endif

#include <stdlib.h>	/* standard library definitions */
#include <unistd.h>
#include <urtsud.h>	/* URT StartUp Definition structure */
#include <stdioi.h>
#include <signal.h>
#include <errno.h>
#include <frkxec.h>	/* New KCC forkexec() call */
#include <sys/usydat.h>
#include <sys/usysio.h>
#include <sys/urtint.h>
#include <sys/c-debug.h>
#include <sys/file.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <ctype.h>
#include <string.h>	/* For str- and mem- defs */

#if SYS_T20+SYS_10X
#include <jsys.h>
#include <sys/param.h>

#elif SYS_ITS
#include <sysits.h>

#elif SYS_T10+SYS_CSI+SYS_WTS
#include <muuo.h>
#endif


/* Imported data (external) */
extern int `$STDIR`;
extern char **`$ENVPT`;
extern int `$ENVSZ`;
extern int `$UMASK`;
extern int `$STDER`;

/* Exported data */
int errno;			/* Last error code, visible to user */
char **environ = 0;		/* Pointer to UNIX environment, user vis. */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* Prototype user program entry point */
extern int main P_((int argc, char **argv, char **environ));

/* Internal routines */
static int exec_parse P_((char *p));
static int shell_parse P_((char *p));
#if SYS_T20
static int runpipe P_((char *cp));
#endif 
static void argfset P_((char *arg));
static void arg_set P_((char *p));
static char *wdsbrk P_((size_t n));
static int caseall P_((char *s,char *t));
static char *indfparse P_((char *p,int lev));
static int argscan P_((char *to,char **from,int lev));
static void setfil P_((char *name,int fd,int append));
#if SYS_T20+SYS_10X
static char *mangle P_((char *p));
#endif 
#if SYS_T20+SYS_10X			
static int ispipe P_((int jfn));
static void init_uio P_((void));
static int tty_fdp P_((int fd));
static void tty_set P_((void));
static void tty_reset P_((void));
static void dir_restore P_((void));
static void dir_save P_((int dirno));
static void abortmsg P_((char *s,...));
static int wfopen P_((char *name));
static char *wfnext P_((int jfn,int flags,char *arg,int len,int *nxtp));
static char *getjcl P_((void));
static int procamper P_((void));
#if SYS_T20
static int _mov7 P_((char *path));
#endif 
#endif	
#if SYS_T10+SYS_CSI+SYS_WTS
static void init_uio P_((void));
static char *getjcl P_((void));
static void tty_set P_((void));
static int tty_fdp P_((int fd));
static void abortmsg P_((char *s,...));
#endif 
#if SYS_ITS
static void init_uio P_((void));
static void tty_set P_((void));
static int tty_fdp P_((int fd));
#endif

/* The following instantiates the UNIX system data. That is, data
   which should not be shared by a vfork() process. It is broken into
   2 pieces which are preceeded, separated, and followed by pagesize-1
   buffers to allow changing the mapping for each piece separately.
   The first piece, from begsys to endsys should NOT be shared between
   forks, while the second piece SHOULD be shared.
   See usydat.h for details.
*/

struct _urt _urt;

/* Called in subfork to insure that pages from `begsys` to `endsys`
   are not shared with parent
*/

USYS_VAR_TO_ASM(begsys[511],`begsys`);
USYS_VAR_TO_ASM(endsys[-1],`endsys`);

void _vfcpy(fkhndl)
int fkhndl;
{
  if (0) (fkhndl++, `begsys`++, `endsys`++); /* Make compiler happy */
#asm
	SEARCH MONSYM		/* Uppercase to avoid monsym() clash */

	setz	1,		/* Prepare to make private section */
	move	2,begsys	/* Get address of first word */
	lsh	2,-9-9		/* Get section number */
	jumpe	2,vfcpy1	/* No SMAP needed for section 0 */
	hrl	2,-1(17)	/* Destination = inferior fork */
	movei	3,1		/* One section */
	smap%			/* Map it */
vfcpy1:	lsh	2,9		/* Get first page of section */
	move	1,2		/* Get copy for source */
	hrli	1,.fhslf	/* Source = current fork */
	hrl	2,-1(17)	/* Destination = inferior fork */
	move	3,[pm%cnt!pm%rd!pm%wr!pm%ex!1000]
				/* First share all pages of section */
	pmap%
	move	1,begsys	/* Get address of first word */
	lsh	1,-9		/* Make it page number */
	move	3,endsys	/* Get address in page after last word */
	lsh	3,-9		/* Make it page number */
	subi	3,-1(1)		/* Make page count */
	move	2,1		/* Get copy of page number */
	hrli	1,.fhslf	/* Source is current fork */
	hrl	2,-1(17)	/* Destination is inferior */
	hrli	3,(<pm%cnt!pm%rd!pm%ex!pm%cpy>) /* R+W+CPY */
	pmap%			/* Don't change these in parent */
#endasm
}

USYS_VAR_TO_ASM(endsys[511],`begshr`);
USYS_VAR_TO_ASM(endshr[-1],`endshr`);

void _vfshr(fkhndl)
int fkhndl;
{
  if (0) (fkhndl++, `begshr`++, `endshr`++); /* Make compiler happy */
#asm
	SEARCH MONSYM		/* Uppercase to avoid monsym() clash */

	move	1,begshr	/* Get start address */
	lsh	1,-9		/* Make it page */
	move	2,endshr	/* Get address in page after end */
	lsh	2,-9		/* Make it page */
	subi	2,-1(1)		/* Compute pages to map */
	hrli	2,(<pm%cnt!pm%rd!pm%ex!pm%wr>) /* Full access */
	push	17,2		/* Save this for reuse */
	hrli	1,.FHSLF	/* Current fork handle */
	push	17,1		/* Save this as well */
	rmap%			/* Read map */
	jumpge	1,vfshr2	/* Jump if already in file */
	move	1,begshr	/* Get first address */
	hrrz	2,-1(17)	/* Get page count */
vfshr1:	moves	(1)		/* Force page private */
	addi	1,1000		/* Advance addr to next page */
	sojg	2,vfshr1	/* Loop thru all pages */
	push	17,[point 7,[asciz /-KCC-SHARE.TMP;T/],6] /* File suffix */
	pushj	17,.tfile	/* Call temp file constructor */
	adjsp	17,-1		/* Unstack arg */
	move	2,1		/* Setup string for GTJFN */
	movsi	1,(gj%sht!gj%fou!gj%new) /* Mode of GTJFN */
	gtjfn%			/* Get termporary file */
	 halt			/* Cause error */
	move	2,[of%rd!of%wr]	/* Read/write */
	openf%			/* Open */
	 halt			/* Cause error */
	delf%			/* Mark for delete now */
	 halt			/* Cause error */
	hrlz	2,1		/* Put JFN in LH, 0 in RH of 2 */
	move	1,(17)		/* Get .FHSLF,,start page */
	move	3,-1(17)	/* Get page count */
	pmap%			/* Map private pages into fork */
	exch	1,2		/* Reverse source/dest */
	pmap%			/* And map the pages back to the fork */
vfshr2:	pop	17,2		/* Get .FHSLF,,start page */
	pop	17,3		/* Get access,,count */
	hrl	2,-1(17)	/* Change destination to inferior */
	pmap%			/* Share these pages with parent */
#endasm
}

/* Define macro so that sbrk()'s idea of the break is always word-aligned
** upon entry to the user program.
*/
#define WS (sizeof(int))		/* Word size */
#define WALIGN_sbrk(n) wdsbrk(n)	/* Word-aligned sbrk() */

/* Macro to reduce some typing; used with abortmsg(). */
#define LASTERR strerror(_ERRNO_LASTSYSERR)

#define MAX_ARG 32	/* # words of argv space to increment each time */

static int argc;		/* argument count (finally given to main()) */
static char **argv;		/* pointer to argv vector (ditto) */
static int argv_size;		/* current max size of argv */

/*
** _RUNTM()	UN*X Run Time C program startup!
*/

void
_runtm()
{
    extern char **`$SARGV`;
    extern int `$SARGC`;
    int (*parser)P_((char *));		/* parser function to call */
    char *p, *arg_vector[MAX_ARG];

    init_uio();				/* initialize uio layer */

    /* Initialize environment data from CRT.C */
    if (`$STDIR`) _chdir(`$STDIR`);	/* Set connected dir, if passed */
    USYS_VAR_REF(umask) = `$UMASK` & 0777; /* Set default umask */
    environ = `$ENVPT`;			/* Copy environment pointer */
    if (`$SARGV`) {
      argc = `$SARGC`;			/* get arguments already setup */
      argv = `$SARGV`;
    }
    /* Arguments not passed, scan them now */
    else {
      argc = 0;				/* no args on command line yet */
      argv = arg_vector;		/* start off using this array */
      argv_size = MAX_ARG;		/* size of argv array */
      if (_urtsud.su_parser_type != _URTSUD_NO_PARSE && (p = getjcl())) {
	switch (_urtsud.su_parser_type) {
	default:
	case _URTSUD_SHELL_PARSE: parser = shell_parse; break;
	case _URTSUD_EXEC_PARSE: parser = exec_parse; break;
	}
	(*parser)(p);			/* invoke the parser */
      }
    }
    if (argc <= 0) {
      argc = 1;
      argv = arg_vector;
      arg_vector[0] = "<noname>";
      arg_vector[1] = NULL;
    }
    tty_set();			/* Set up TTY stuff if any.  If so, it must */
				/* register a cleanup rtn with atexit()! */ 

    atexit(_cleanup);		/* Register STDIO cleanup rtn for exit() */
    exit(main(argc, argv, environ));
				/* Call user program, return value! */
}

void
_panic(msg)
char *msg;
{
    abortmsg("C internal runtime error: ", msg, (char *)NULL);
}

/* _NFBSZ - convert file length in one bytesize to length in another bytesize.
**	Note we multiply by new bytesize before dividing by old; this prevents
**	integer division from forcing alignment to a word boundary.
*/
long
_nfbsz(ourbsz, filbsz, fillen)
int ourbsz, filbsz;
long fillen;
{
    register int ourbpw = ourbsz ? (36/ourbsz) : 1;	/* # bytes per wd */
    register int filbpw = filbsz ? (36/filbsz) : 1;
    return (ourbpw * fillen + filbpw-1) / filbpw;
}

/* EXEC_PARSE
 *	Parser for EXEC-style command lines.  takes a string of the form
 *	"<command>[<space><text>]<CRLF>" and breaks it into one or two
 *	parts.  if argc=1, then there's just a command.  if argc=2, then
 *	there a command plus an arg.  argv[0] points to the start of the
 *	command, argv[1] points to the start of the arg (maybe).  both
 *	skip initial whitespace and null-terminate their parts in place
 *	in the string buffer.
 *
 *	also, that CRLF might just be a CR, or maybe just an LF.  be
 *	sure and handle all cases.
 */
static int
exec_parse(p)
char *p;
{
    int c;
    char *original_p;

    if (!p) p = "";			/* Substitute null str for NULL ptr */

    while ((c = *p) == ' ' || c == '\t')
	p++;				/* skip leading whitespace */
    original_p = p;			/* save this to see if it changes */
    while (c && c != ' ' && c != '\t' && c != '\r' && c != '\n')
	c = *++p;			/* skip text of command, if any */
    if (p == original_p) return;	/* oops, nothing really there. */
    *p = '\0';				/* tie off command. */
    arg_set(original_p);		/* save start of command */
    if (c != ' ' && c != '\t') return 1;/* if not a space, no arg. */
    while ((c = *++p) == ' ' || c == '\t')
	;				/* else, skip whitespace b4 arg. */
    if (c == '\r' || c == '\n')		/* if lots of blankspace but no */
	return;				/* real arg, then so be it. */
    arg_set(p);				/* else save start of arg */
    while ((c = *++p) && c != '\r' && c != '\n') ;
    if (c) *p = '\0';			/* skip to EOL, clobber CR or LF. */
    return;
}

/* SHELL_PARSE - unix-style shell parser.
*/

static int haswild = 0;	/* Set by argscan() if arg had unquoted wild chars */

#ifndef SYSFIL_QTCH
#if SYS_T20+SYS_10X
#define SYSFIL_QTCH (026)	/* CTRL-V - T20 quoting convention */
#elif SYS_ITS
#define SYSFIL_QTCH (021)	/* CTRL-Q - ITS quoting convention */
#else
#define SYSFIL_QTCH (-1)
#endif
#endif

static int
shell_parse(p)
char *p;
{
    register int c;
    char *cp, *ap;
    int pipeout = -1;
    int lev = 0;
    int append = 0;			/* No append for stdout redirect */
    char *in = NULL, *out = NULL;	/* No redirection */

    /*
     *	Read command line into a string.  We later drop some nulls into
     *	it to separate it into arguments, to save space.  We allocate
     *	space using sbrk() for the string; if there are no wildcard
     *	arguments this will be all we need to store arguments.
     */
    if (!p) p = "";			/* Substitute null str for NULL ptr */
    lev = 0;
    c = *(cp = p);			/* Initialize */
    while (c) {
	switch (c) {
	    default:
		if (!isgraph(c))	/* Ignore whitespace/cntrls */
		    break;
		ap = cp;		/* Have start of an arg, note it. */
		c = argscan(ap, &cp, lev);	/* Gobble the arg */
		argfset(ap);		/* Store the arg! */
		continue;		/* Loop, don't increment cp */

	    case '@':		/* Handle indirect file spec */
		cp = indfparse(cp, lev);
		c = *cp;
		continue;	/* Loop, don't increment cp */

	    case ';':		/* Ignore ;-commented lines */
		while (*++cp && *cp != '\n');
		if (!*cp) --cp;	/* Stop on next loop */
		break;

#if SYS_T20+SYS_10X
	    case '!':		/* Ignore !-commented phrases/lines */
		while (*++cp && *cp != '!' && *cp != '\n');
		if (!*cp) --cp;	/* Stop on next loop */
		break;

	    case '-':		/* Check for T20 "line continuation" */
		if (cp[1] == '\n' || cp[1] == '\r')
		    break;		/* Ignore it */
		ap = cp;		/* Have start of an arg, note it. */
		c = argscan(ap, &cp, lev);	/* Gobble the arg */
		argfset(ap);		/* Store the arg! */
		continue;		/* Loop, don't increment cp */
#endif /* T20+10X */

	/*
	 *	an ampersand means run in the background.  this is implemented
	 *	with the usual EXEC PRARG% hack, which if you don't have, you
	 *	should.  it always allows a fork to request being reset, or to
	 *	kept.
	 */
	case '&':
#if !SYS_T20
	    abortmsg("Background (&) not implemented on this system", NULL);
#else
	    if (procamper() == -1)	/* tell exec we need '&' action */
		abortmsg("Couldn't continue ourselves in background - ",
				LASTERR, NULL);
	    /* Now running in background... */
#endif /* T20 */
	    c = 0;		/* We shouldn't have anything after this */
	    continue;		/* Stop loop. */

	    case '|':		/* Handle pipe setup, <prog> | <prog2> */
#if !SYS_T20
		abortmsg("Pipes not supported on this system", NULL);
#else
		if (out != NULL || pipeout >= 0)
		    abortmsg("Multiple redirection of output", NULL);
		while (isspace(*++cp));	/* Move over '|' and flush wsp */
		pipeout = runpipe(cp);
#endif
		c = 0;			/* Remaining JCL went to child */
		continue;		/* Stop loop */

	    /* '<' means take the following file as primary input.
	     * Must not confuse "foo <dir>name" with a redirection request!
	     */
	    case '<':
#if SYS_T20+SYS_10X
		if (lev || mangle(cp)) {	/* Matched brackets? */
		    ap = cp;		/* Have start of an arg, note it. */
		    c = argscan(ap, &cp, lev);	/* Gobble the arg */
		    argfset(ap);		/* Store the arg! */
		    continue;		/* Loop, don't increment cp */
		}
#endif
		if (in != NULL)
		    abortmsg("Multiple redirection of input", NULL);
		while (isspace(c = *++cp));	/* Get next, flush wsp */
		in = cp;		/* Remember ptr to filename */
		c = argscan(in, &cp, lev);	/* Gobble past file name */
		continue;		/* Loop, don't increment cp */

	    case '>':			/* output redirection? */
		if (cp[1] == '>') {	/*   another one, for append? */
		    ++append;		/*   Yep, set flag */
		    ++cp;		/*   and skip over first bracket */
		}
		if (out != NULL || pipeout >= 0)
		    abortmsg("Multiple redirection of output", NULL);
		while (isspace(c = *++cp));	/* Get next, flush wsp */
		out = cp;		/* Remember ptr to filename */
		c = argscan(out, &cp, lev);	/* Gobble past file name */
		continue;		/* Loop, don't increment cp */
	}
	c = *++cp;	/* breaking from switch goes to next char */
    }

    if (pipeout >= 0) {			/* If we are piping output, */
	dup2(pipeout, UIO_FD_STDOUT);	/* redirect std output to pipe. */
	close(pipeout);			/* And flush this FD now */
    }

    if (in)				/* If desired, */
	setfil(in, UIO_FD_STDIN, 0);	/* redirect stdin to file */
    if (out)				/* and ditto for stdout */
	setfil(out, UIO_FD_STDOUT, append);
}

/* RUNPIPE - Set up pipe process
*/
#if SYS_T20
#define PIPEIN	0	/* Indices into array used by pipe() call */
#define PIPEOUT	1

static int
runpipe(cp)
char *cp;
{
    struct frkxec f;
    int pipes[2];		/* For pipe FDs */
    char *av[3];		/* Temporary argv array */
    char pgmnam[1000];		/* Very big program name */

    argscan(pgmnam, &cp, 0);	/* Get program name (always top level) */
    if (pipe(pipes) == -1)	/* Get buffered pipe */
	abortmsg("Couldn't make pipe - ", LASTERR, NULL);
    av[0] = pgmnam;		/* Arg 0 is prog name */
    av[1] = cp;			/* Rest is remaining JCL */
    av[2] = NULL;
    f.fx_flags = FX_PGMSRCH | FX_FDMAP;
    f.fx_name = pgmnam;		/* Program name to run */
    f.fx_argv = &av[0];
    f.fx_envp = NULL;
    f.fx_fdin = pipes[PIPEIN];		/* Map fork's input to this */
    f.fx_fdout = -1;		/* Leave output alone */
    if (forkexec(&f) < 0)
	abortmsg("Couldn't get next program in pipe - ", LASTERR, NULL);

    USYS_VAR_REF(pippid) = f.fx_pid; /* Save PID of piped fork */

    /* Special hack: forget about pipe's input UF so we don't close it
     * by accident; there is no mechanism for sharing FD-use count
     * between forks!  Sigh.  If there was, we could just
     * dispense with the following two statements.
     *
     * Note: with changes in "system" data sharing in vfork(), we can
     * do better management of FD-use, but since forkexec doesn't use
     * vfork(), we must still manage this manually.
     */

#ifdef _KCC_DEBUG
      if (`$DEBUG` & _KCC_DEBUG_UIO_FDSHR){
	struct _ufile *uf = USYS_VAR_REF(uffd[pipes[PIPEIN]]);

	_dbgl("URT&runpipe() discard pipe fd=");
	_dbgd(pipes[PIPEIN]);
	_dbgs(", uf=");
	_dbgd(uf-USYS_VAR_REF(uftab));
	_dbgs(", nopen=0, jfn=");
	_dbgj(uf->uf_ch);
	_dbgs("\r\n");
      }
#endif

    close(pipes[PIPEIN]);	/* Release our interest in FD */

    return pipes[PIPEOUT];	/* Return FD for output to pipe */
}
#endif /* T20 */

/* ARGFSET - Add a filename arg to the argv array, bumping argc.
**	Expands wildcards if needed and performs other checking.
*/

static void
argfset(arg)
char *arg;
{
#if SYS_ITS==0
    /* Watch out for EXEC/monitor stupidness!  Make sure we don't have a
    ** noise keyword at start of JCL.  Time to check this is when
    ** we're about to add a 2nd arg -- check the first, and if it's bad,
    ** replace it with this one.
    */
    if (argc == 1) {
	static char *fktab[] = {"RUN", "RU", "R",
				"START", "ST", "S",
				"EXECUTE", "EXE",
#if SYS_CSI
				"IRUN", "IRU",
#endif
				0 };
	register char **p = fktab;
	while (*p)
	    if (caseall(argv[0], *p++)) {
		--argc;			/* Barfo, flush the 1st arg */
		break;
	    }
    }
    /* Also flush ';' from end of 1st arg, so that things like "FOO; arg arg"
    ** and "RUN FOO; arg arg" will work.
    */
    if (argc == 0) {
	int i = strlen(arg)-1;
	if (i >= 0 && arg[i] == ';')
	    arg[i] = '\0';
    }
#endif /* not ITS */
#if SYS_T20+SYS_10X
    if (argc > 0 && haswild) {	/* Expand wildcard filename? */
	int wjfn, flags = 001100000001, len, nxt;
	char *prefix;

	if ((wjfn = wfopen(arg)) != 0) { /* open wildcard spec */
	    if (!(wjfn & monsym("GJ%UHV"))) flags |= 0000010000000;
	    /* test for wild device or directory specified */
	    if ((wjfn&(monsym("GJ%DEV")|monsym("GJ%UNT")|monsym("GJ%DIR")))) {
		flags |= 0110000000000;
		len = 1;
		prefix = "/";
	    }
	    else {
		len = 0;
		prefix = strrchr(arg, '/');
		if (prefix) len = prefix - arg + 1;
		prefix = strrchr(arg, '>');
		if (prefix && ((prefix - arg + 1) > len))
		    len = prefix - arg + 1;
		prefix = strrchr(arg, ']');
		if (prefix && ((prefix - arg + 1) > len))
		    len = prefix - arg + 1;
		prefix = strrchr(arg, ':');
		if (prefix && ((prefix - arg + 1) > len))
		    len = prefix - arg + 1;
		prefix = arg;
	    }
	    do {		/* Get new name and set it */
		arg_set(wfnext(wjfn, flags, prefix, len, &nxt));
	    } while (nxt);
	    return;
	}
#if 0				/* No error, just store arg */
	abortmsg("No match for \"", arg, "\"", NULL);
#endif
    }
#endif /* T20+10X */
    arg_set(arg);		/* Just set the arg */
}

/* ARG_SET - add an arg to the argv array, bumping argc.
**	If argv becomes full, it is expanded (with extra space so
**	we don't have to do it too often).  Note that an extra word is
**	kept on the end so that the array always ends with a NULL pointer.
*/

static char *lastsbrk = 0;	/* Last return value from sbrk */

static void
arg_set(p)
char *p;
{
    int new_size;			/* new size, if need to expand */
    char **newv;			/* New array pointer, if ditto */

    if (argc >= argv_size-1) {		/* need to expand? */
	new_size = argv_size + MAX_ARG;	/* increase by this much each time */

	if (lastsbrk == sbrk(0)) {	/* Can we just expand it? */
	    WALIGN_sbrk(MAX_ARG * sizeof(char *));	/* Yes, do so */
	}
	else {		/* No, must get new array, and copy old into it. */
	    newv = (char **)WALIGN_sbrk(new_size * sizeof(char *));
	    memcpy((char *)newv, (char *)argv, argv_size*sizeof(char *));
	    argv = newv;
	}
	argv_size = new_size;		/* new max # of args */
	lastsbrk = sbrk(0);		/* New value of last break */
    }
    argv[argc] = p;			/* set this arg. */
    argv[++argc] = NULL;		/* Ensure array always ends in 0 */
}

/* WDSBRK - word-aligned interface to sbrk() that checks for failure.
*/
static char *
wdsbrk(n)
size_t n;			/* # bytes to allocate */
{
    register char *ret;
    if ((ret = sbrk(((n+WS-1)/WS)*WS)) != (char *)-1)
	return ret;
    abortmsg("Out of memory during URT startup", NULL);
}

/* CASEALL - auxiliary for ARGFSET.  Does uppercase string compare.
*/
static int
caseall(s,t)
char *s,*t;
{
    while (toupper(*s) == *t++)
	if (!*s++) return 1;
    return 0;
}

/* INDFPARSE - Parse indirect file.
**	Arg is pointer to start of "@filespec", returns updated pointer.
**	The contents of the file are parsed in a fashion
**	similar to that of TOPS-20 COMND% indirect files.
**	If ever necessary, some things can be conditionalized (like
**	comment and quote chars, etc)
*/
static char *
indfparse(p, lev)
char *p;
int lev;
{
    register int c;
    register char *cp;
    int fd, res;
    struct stat statb;
    char *buf, *newp;

    /* Scan over filename */
    cp = p++;			/* Copy arg, skipping initial '@' */
    c = argscan(cp, &p, lev);	/* Do it */

    if (lev > 10) {		/* Prevent infinite recursion */
	abortmsg("Indirect files nested too deep (10 max) - \"",
			cp, "\"", NULL);
    }
    if (!*cp)
	abortmsg("No filename for @ indirect file", NULL);
    if ((fd = open(cp, O_RDONLY)) < 0)
	abortmsg("Cannot open @ indirect file \"", cp, "\" - ", LASTERR, NULL);
    if (fstat(fd, &statb) != 0)
	abortmsg("Cannot fstat @ indirect file \"", cp, "\" - ", LASTERR,NULL);
    if (statb.st_size <= 0) {		/* If empty, just ignore it. */
	close(fd);
	return p;
    }
    buf = WALIGN_sbrk((size_t)statb.st_size+1);		/* Get room for file */
    if ((res = read(fd, buf, (int)statb.st_size)) <= 0
      || res > statb.st_size)			/* Be flexible about result */
	abortmsg("Error reading indirect file \"", cp, "\" - ", LASTERR, NULL);
    close(fd);
    buf[res] = '\0';		/* Ensure ends with null */
    *p = c;			/* No need to preserve filename now */

    /* Now scan the acquired buffer, adding args as we encounter them. */
    ++lev;			/* Increment level */
    c = *(cp = buf);
    for (;;) {
	switch (c) {
	    case '\0':		/* NUL means all done, return */
		return p;

	    case '@':
		cp = indfparse(cp, lev);
		c = *cp;
		continue;	/* Loop, don't increment cp */

	    case ';':		/* Ignore ;-commented lines */
		while (*++cp && *cp != '\n');
		if (!*cp) return p;
		break;

	    case '!':		/* Ignore !-commented phrases/lines */
		while (*++cp && *cp != '!' && *cp != '\n');
		if (!*cp) return p;
		break;

	    case '-':		/* Check for T20 "line continuation" */
		if (cp[1] == '\n' || cp[1] == '\r')
		    break;		/* Ignore it */

	    default:
		if (!isgraph(c))	/* Ignore whitespace/cntrls */
		    break;

		/* Start scanning over an argument */
		arg_set(newp = cp);
		c = argscan(cp, &newp, lev);
		cp = newp;
		continue;	/* Loop, don't increment cp */
	}
	c = *++cp;	/* breaking from switch goes to next char */
    }
}

/* ARGSCAN - scan over an argument, copying it.
**	Assumes "from" points to first char of argument.
**	The copy is necessary in order to flush embedded quotes and
** backslashes.  Some chars may not be terminators depending on whether parsing
** at top level or not.
**	Updates the source pointer ("from") and returns as value the char
** which it supposedly points to -- this is the next char that should be
** examined by the higher level scanner.  The pointer itself should not
** be used to examine that char, because it can happen that the NUL char
** written to terminate the arg string was written on top of the "next char".
**	Also (hack!) sets the flag "haswild" if any unquoted wildcard
** characters were seen in the arg ('%', '*')
*/
static int
argscan(to, from, lev)
char *to, **from;		/* Note "from" is addr of char ptr */
int lev;			/* 0 == top level */
{
    register char *wp = to-1, *cp = (*from)-1;	/* Set up for ILDB/IDPB */
    register int c;

    haswild = 0;		/* No wildcard chars seen so far */
    for (;;) {

	/* Check for special terminators. */
	switch (*++wp = *++cp) {
	    default:
		if (isgraph(*cp))	/* Collect printing chars */
		    continue;
		break;			/* Stop if hit any non-printing char */

	    case '%':		/* File wildcard chars */
	    case '*':
		haswild++;		/* Report an unquoted wildcard seen */
		continue;

	    case '-':			/* Check for - at EOL */
		if (!lev) continue;	/* Not special at top level */
		if (cp[1] == '\r' || cp[1] == '\n') {
		    --wp;		/* Flush '-' from end of arg */
		}			/* Next pass of loop will terminate */
		continue;

	    case '\\':
		if (!(*wp = *++cp))	/* Quote next char (overwrite \) */
		    break;		/* don't allow quote of NUL */
		if (*wp == '\r' && cp[1] == '\n')
		    *wp = *++cp;	/* \ CR LF becomes just LF */
		continue;		/* and keep going */

	    /* The following filename quote chars differ from '\' in that
	    ** they are KEPT in the argument, for passing on to the
	    ** operating system calls.
	    */
	    case SYSFIL_QTCH:
		if (!(*++wp = *++cp))	/* Quote next char (keep quote!) */
		    break;		/* don't allow quote of NUL */
		continue;		/* and keep going */


	    case '"':	/* Permit embedding of quoted strings */
	    case '\'':
		c = *cp;			/* Remember terminator char */
		--wp;				/* Back up to flush it */
		while (*++wp = *++cp) {
		    if (*cp == c) break;
/* To be consistent with shell quoting on UNIX, we do not recognize
** any special quoting inside single and/or double quotes.
*/
#if 0
		    if (*cp == '\\') {		/* Allow backslash quotes */
			if (!(*wp = *++cp))
			    break;		/* don't allow quote of NUL */
		    } else if (*cp == SYSFIL_QTCH)
			if (!(*++wp = *++cp))
			    break;		/* don't allow quote of NUL */
#endif
		}
		if (!*cp) break;
		--wp;	/* Found terminator, back up so term char not stored */
		continue;

	    case '&':
	    case '|':
	    case '>':
		if (lev) continue;	/* Special only at top level */
		break;
	    case '<':
		if (lev) continue;	/* Special only at top level */
#if SYS_T20+SYS_10X
		if (to = mangle(cp)) {	/* Matching angle brackets? */
		    while (to != cp) {		/* Yes, move over them */
			*++wp = *++cp;
			if (*cp == '%' || *cp == '*')
			    haswild++;		/* Check for wildcards */
		    }
		    continue;
		}
#endif
		break;
	    }
	break;		/* Breaking out of switch breaks out of loop */
    }
    *from = cp;		/* Update "from" pointer */
    c = *cp;		/* Save next char that should be processed */
    *wp = '\0';		/* Tie off copied arg (may clobber *cp) */
    return c;		/* Return saved next-char */
}

/* SETFIL - redirect a standard in/out/err file descriptor.
**	Note that the STDIO streams must also be changed; a fd and a stream
**	are not the same thing.  For now we punt on trying to 
**	change the buffering or stdio flags.
*/
static void
setfil(name, fd, append)
char *name;
int fd, append;
{
    FILE *fp;
    int tmpf, flags;

    if (!name) return;			/* nothing to do. */
    switch (fd) {
	case UIO_FD_STDIN:
	    fp = stdin;
	    flags = O_RDONLY;
	    break;
	case UIO_FD_STDOUT:
	    fp = stdout;
	    flags = (O_WRONLY | O_CREAT | (append ? O_APPEND : O_TRUNC));
	    break;
	case UIO_FD_STDERR:
	    fp = stderr;
	    flags = (O_WRONLY | O_CREAT | (append ? O_APPEND : O_TRUNC));
	    break;
	default:
	    abortmsg("Bad redirection file fd", NULL);
    }
    if ((tmpf = open(name, flags|O_T20_DEF_MODE, 0644)) < 0)
	abortmsg("Couldn't open redirection file \"", name, "\" - ",
			LASTERR, NULL);

    dup2(tmpf, fd);			/* Make temp FD be a STDxx FD */
    close(tmpf);			/* Then flush the temp fd */
    if (flags & O_APPEND)		/* If appending, */
	fseek(fp, 0L, SEEK_END);	/* ensure STDIO knows about it */
    if (fp == stderr)
	setbuf(stderr, (char *)NULL);	/* No buffering for stderr */
    else if (fp == stdout && !tty_fdp(fd))	/* If stdout to non-TTY, */
	setvbuf(fp, (char *)NULL, _IOFBF, 0);	/* then use full buffering */
}

#if SYS_T20+SYS_10X
/* MANGLE - Match Angle brackets, try to determine if '<' starts a
**	filename with a directory spec or not.
**	Returns NULL if no matching '>', else pointer to it.
*/
static char *
mangle(p)
char *p;
{
    for (;;)			/* until we find a special char */
	switch (*++p) {			/* check char (ignoring first open) */
	case ' ': case '\t': case '\n': case '\r':
	case ';': case '<':  case ':':  case '\0':
	    return NULL;		/* no close or second open, redirect */
	case '>':
	    return p;			/* found an angle, matched */
	}
}
#endif /* T20+10X */

#if SYS_T20+SYS_10X			/* TOPS-20 and TENEX: */
/*
 *	TOPS-20/TENEX specific portions of higher-level runtimes
 */

/*
 *	Determine if JFN is a pipe device (PIP: or TCP:)
 */
static int
ispipe(int jfn)
{
    int acs[5];

    acs[1] = jfn;
    if (!jsys(DVCHR, acs)) return 0;	/* Not pipe on failure */
    return ((FLDGET(acs[2], monsym("DV%TYP")) == _DVPIP)
	    || (FLDGET(acs[2], monsym("DV%TYP")) == _DVTCP));
}

/* INIT_UIO - initialize UIO data structures.
**	For now we always set FD 2 (std err) to .CTTRM, and
** and check .PRIIN and .PRIOU to set up FDs 0 and 1.
**	Later we may inherit a data page from previous process.
*/
static void
init_uio()
{
    struct _ufile *iuf, *of, *ef;
    union {
	int acs[5];
	struct { int junk[2];
		unsigned pin : 18;	/* LH of AC 2 */
		unsigned pout : 18;	/* RH of AC 2 */
	} res;
    } a;
    int acs[5];

    USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Initialize shared I/O interlock */

    /* Get PTY paramters */
    acs[1] = ('P'-040)<<30 | ('T'-040)<<24 | ('Y'-040)<<18
	     | ('P'-040)<<12 | ('A'-040)<<6 | ('R'-040);
				/* sixbit PTYPAR */
    if (jsys(SYSGT, acs)) {
	USYS_VAR_REF(ptytty) = acs[1] & RH;
	USYS_VAR_REF(ptynum) = acs[1] >> 18;
    }

    /* Initialize FD 2 (error output) as that is always constant */
    ef = _ufcreate();			/* Get a free UF */
    ef->uf_ch = _CTTRM;			/* By default, use this JFN */
    ef->uf_flgs = UIOF_CONVERTED;	/* With this extra flag */

    if ((`$STDER` == monsym(".NULIO"))	/* stderr is NUL:? */
	|| ((acs[1] = `$STDER`)		/* No, got JFN? */
	    && jsys(GTSTS, acs)		/* And status */
	    && (acs[2] & GS_OPN))) {	/* And open? */
      ef->uf_ch = `$STDER`;		/* Yes, use that for stderr */
      if (ispipe(ef->uf_ch)) ef->uf_flgs = 0; /* Clear conversion if pipe */
    }

    _openuf(UIO_FD_STDERR, ef, O_RDWR);	/* FD 2 now open for business! */

    /* See what our primary JFNs really are */
    a.acs[1] = _FHSLF;
    jsys(GPJFN, a.acs);
    if (a.res.pin == ef->uf_ch) {	/* If stdin same as stderr, */
	USYS_VAR_REF(uffd[UIO_FD_STDIN]) = ef; /* just point there. */
	ef->uf_nopen++;			/* Simulates dup2() */
#ifdef _KCC_DEBUG
	if (`$DEBUG` & _KCC_DEBUG_UIO_FDSHR){
	  _dbgl("URT&init_io() dup STDIN(0) from STDERR(2), uf=");
	  _dbgd(ef-USYS_VAR_REF(uftab));
	  _dbgs(") nopen=0, jfn=");
	  _dbgj(ef->uf_ch);
	  _dbgs("\r\n");
	}
#endif
    } else {
	iuf = _ufcreate();
	iuf->uf_ch = a.res.pin;		/* Must set up with this JFN */
	iuf->uf_flgs = ispipe(a.res.pin) ? 0 : UIOF_CONVERTED;
					/* With this extra flag if not pipe */
	_openuf(UIO_FD_STDIN, iuf, O_RDONLY); /* Take care of rest of vars */
					/* and make FD 0 open for business */
    }

    if (a.res.pout == ef->uf_ch) {	/* If stdout same as stderr, */
	USYS_VAR_REF(uffd[UIO_FD_STDOUT]) = ef;	/* just point there. */
	ef->uf_nopen++;			/* Simulates dup2() */
#ifdef _KCC_DEBUG
	if (`$DEBUG` & _KCC_DEBUG_UIO_FDSHR){
	  _dbgl("URT&init_io() dup STDOUT(1) from STDERR(3), uf=");
	  _dbgd(ef-USYS_VAR_REF(uftab));
	  _dbgs(") nopen=0, jfn=");
	  _dbgj(ef->uf_ch);
	  _dbgs("\r\n");
	}
#endif
    } else {
	of = _ufcreate();
	of->uf_ch = a.res.pout;		/* Must set up with this JFN */
	of->uf_flgs = UIOF_CONVERTED;	/* With this extra flag */
	of->uf_flgs = ispipe(a.res.pout) ? 0 : UIOF_CONVERTED;
					/* With this extra flag if not pipe */
	_openuf(UIO_FD_STDOUT, of, O_WRONLY); /* Take care of rest of vars */
					/* and make FD 1 open for business */
    }
}

/* ---------------------------------------- */
/*	set terminal mode word		    */
/* ---------------------------------------- */

#define CCOC_MAGIC	0525252525252

static int ccoc[2];

/* TTY_FDP(fd) - returns TRUE if given fd is associated with a TTY.
*/
static int
tty_fdp(fd)
int fd;
{
    return (USYS_VAR_REF(uffd[fd])->uf_type == UIO_DVTTY);
}


static void
tty_set()
{
    int ablock[5];

    ablock[1] = _CTTRM;
    if (!jsys(RFCOC, ablock)) return;
    ccoc[0] = ablock[2];
    ccoc[1] = ablock[3];		/* save ccoc words */
    if (ccoc[0] != CCOC_MAGIC
     || ccoc[1] != CCOC_MAGIC) {
	ablock[2] = ablock[3] = CCOC_MAGIC;
	if (!jsys(SFCOC, ablock)) return;
    }
    atexit(tty_reset);			/* Won, register reset rtn for exit */
}

static void		/* Called to reset TTY upon normal exit() */
tty_reset()
{
    int ablock[5];

    ablock[1] = _CTTRM;
    ablock[2] = ccoc[0];
    ablock[3] = ccoc[1];
    jsys(SFCOC, ablock);
}

int
_acces(dirno)
int dirno;
{
  int acs[5], accblk[3];

  acs[1] = AC_CON | 3;		/* Connect request, 3 args */
  acs[2] = (int)accblk;		/* ACCES arg block */
  accblk[0] = dirno;		/* New current directory */
  accblk[1] = 0;		/* No password */
  accblk[2] = -1;		/* Current job */
  return jsys(ACCES, acs);	/* Do connect */
}

static void
dir_restore()
{
  int acs[5];

  if (!USYS_VAR_REF(olddir)) return; /* Return if no old directory */

  if (!_acces(USYS_VAR_REF(olddir))) {
    acs[1] = (int) ("Failed to restore current directory on exit\r\n" - 1);
    jsys(ESOUT, acs);			/* Use ESOUT% to output it */
  }
}

static void
dir_save(int dirno)
{
  if (dirno && !USYS_VAR_REF(olddir)) { /* If new, and no old */
    USYS_VAR_REF(olddir) = dirno; /* Save as old directory */
    atexit(dir_restore);	/* Register cleanup routine */
  }
}

/* ABORTMSG(s1, s2, s3, s4, s5) - outputs string composed of given
**	concatenated strings, and exits.  A NULL argument terminates the
**	list of strings.
*/
static void
#ifdef __STDC__
abortmsg(char *s, ...)
#else
abortmsg(s, a,b,c,d,e)
char *s, *a,*b,*c,*d,*e;
#endif
{
#ifdef __STDC__
    va_list ap;
    char *a;
#endif
    int ac[5];
    char tmpbuf[1000];

    tty_reset();
    strcpy(tmpbuf, s);
#ifdef __STDC__
    va_start(ap, s);
    while (a = va_arg(ap, char*))
      strcat(tmpbuf, a);
    va_end(ap);
#else
    if (a) { strcat(tmpbuf, a);
	if (b) { strcat(tmpbuf, b);
	    if (c) { strcat(tmpbuf, c);
		if (d) { strcat(tmpbuf, d);
		    if (e) { strcat(tmpbuf, e);
    } } } } }
#endif
    strcat(tmpbuf, "\r\n");	/* Terminate error string with CRLF */
    ac[1] = (int) (tmpbuf-1);
    jsys(ESOUT, ac);			/* Use ESOUT% to output it */
    _exit(1);				/* Then stop program with prejudice */
}

/* Filename routines */

#define ROOTDR "<ROOT-DIRECTORY>"
#define ROOTDRL (sizeof(ROOTDR) - 1)

/* _fncon - convert native file specification to proper form.
**	Checks runtime variable settings to determine output type for files.
**	dst	Destination buffer (must be larger than src by at least 1)
**	src	Source string to convert
**	abs	If true, prefix output with '/'
*/
char *_fncon(dst, src, abs, defgen)
char *dst;
const char *src;
int abs, defgen;
{
  const char *pi;
  char *po, ci, co, *poname;
  int indir = 0, dollars = 0, remgen = defgen;

  if (_urtsud.su_path_out_type == _URTSUD_PATH_OUT_UNIX) {
    pi = src;
    poname = po = dst;
    ci = *pi++;
    if (abs) *po++ = '/';		/* Make absolute if needed */
    while (co = ci) {			/* Loop until end */
      if (co == '\026')	{		/* TOPS20 quote character? */
	if (*pi) {			/* Any following char? */
	  ci = *pi++;			/* Yes, get it */
	  *po++ = co;			/* And store quote */
	  co = ci;			/* Copy quoted char */
	}
      }
      else switch (co) {		/* Dispatch on source char */
      case ':':				/* Device separator becomes slash */
	co = '/';
	dollars = 0;
	poname = po + 1;		/* First character of name */
	if (!strncasecmp(pi, ROOTDR, ROOTDRL)) pi += ROOTDRL;
					/* Flush <ROOT-DIRECTORY> */
	break;
	
      case '$':				/* Dollar always becomes dot */
	co = '.';
	if (po != poname) dollars++;	/* Count conversion after first */
	break;
	
      case '<':				/* Discard open dir, but remember */
	indir = 1;			/* to convert dot to slash */
	co = '\0';			/* Don't store */
	break;
	
      case '>':				/* Convert close dir to slash */
	indir = 0;			/* and forget in dir */
	dollars = 0;
	poname = po + 1;
	co = '/';
	break;
	
      case '.':				/* Dot */
	if (indir) {			/* If in dir, */
	  co = '/';			/* Convert to slash */
	  break;
	}				/* Else fall into normal copy */
      default:
	if (isascii(co) && isupper(co)) co = tolower(co);
					/* Convert upper to lower */
	break;
      }
      ci = *pi++;			/* Get next char before clobbering */
      if (co) *po++ = co;		/* Store output character */
    }
    *po = '\0';
    if (defgen && dollars && (po = strrchr(dst, '.'))) {
					/* If default gen, dollars changed */
					/* and backup to dot for gen */
      remgen = 0;			/* Assume removal not allowed */
      for (dollars = -1; po[dollars] != '.'; dollars--)
					/* Scan type */
	if (!isdigit(*po)) {		/* Backup until non-digit */
	  remgen = 1;			/* Can't confuse type with gen */
	  break;
	}
      if (!remgen) po++;		/* If can't remove gen, include it */
      *po = '\0';
      remgen = 0;			/* Avoid removal below */
    }
    if ((po != dst) && (po[-1] == '/'))
      po[-1] = '\0';			/* Never end with slash unless root */
  }
  else if (src != dst) strcpy(dst, src);

  if (remgen) {				/* If removal allowed */
    po = strrchr(dst, '.');		/* Backup to dot before gen*/
    if (po) {				/* If found, */
      if ((po != dst) && (po[-1] == '.')) /* And null type */
	po--;				/* Backup to dot for type */
      *po = '\0';			/* Discard gen (any maybe type) */
    }
  }

  return dst;
}

/* WFOPEN - open wild card filename
**	Returns wild JFN for filespec with flags, 0 if failure.
*/
static int
wfopen(name)
char *name;
{
    return _gtjfn(name, O_RDONLY | O_T20_WILD);
}

/* WFNEXT - Return next filename for wild JFN
**	Returns pointer to dynamically allocated filename string
*/
static char *
wfnext(jfn, flags, arg, len, nxtp)
int jfn, flags, len, *nxtp;
char *arg;
{
    char fname[MAXPATHLEN];
    char *fp, *po;
    int acs[5];

    acs[1] = (int) (fname - 1);
    acs[2] = jfn & 0777777;	/* jfn, no flags */
    acs[3] = flags;		/* use requested fields */
    if (!jsys(JFNS, acs))
	return NULL;		/* something bad happened */

    acs[1] = jfn;		/* Get JFN and flags */
    *nxtp = jsys(GNJFN, acs);	/* Step to next, return result */

    po = fp = WALIGN_sbrk(strlen(fname) + len + 1);
    strncpy(po, arg, len);	/* Copy fixed header */
    po += len;
    strcpy(po, fname);		/* Tack on JFNS string */

    return fp;
}

/* GETJCL - Return command line
*/
static char *
getjcl()
{
    char *buf;

#if SYS_T20
    extern char *`$RSCPT`;

    return `$RSCPT`;
#endif /* SYS_T20 */
#if SYS_10X
    char *cp;
    int c, n;
    char tmpbuf[1000];

    for (cp = tmpbuf; read(UIO_FD_STDIN, cp, 1) == 1; ++cp)
	if ((c  = *cp) == '\037' || c == '\r' || c == '\n') {
	    *cp++ = '\n';
	    break;
	}
    *cp = 0;
    n = strlen(tmpbuf);
    buf = WALIGN_sbrk(n + 1);
    strcpy(buf, tmpbuf);
#endif /* SYS_10X */
    return buf;
}

/* PROCAMPER -
 *	Tell EXEC via termination PRARG that we want to be continued in
 *	the background (e.g. we were invoked by foo &) requires slight
 *	EXEC modification
 */

static int
procamper()
{
    int arg_block[5], temp_arg;

    arg_block[1] = (_PRAST << 18) + _FHSLF;
    temp_arg = PRA_BACK << 18;
    arg_block[2] = (int) &temp_arg;
    arg_block[3] = 1;
    if (!jsys(PRARG, arg_block)) return -1;	/* some lossage */
    jsys(HALTF, arg_block);		/* stop and let exec continue us */
    return 0;				/* return to caller in background */
}

#if SYS_T20

static _KCCtype_char7 `path7`[MAXPATHLEN];

static int
_mov7(char *path)
{
  if (0) (`path7`[0]++, path++);
#asm
	movni  	1,1		/* Backup pointer */
	adjbp	1,-1(17)		/* to original path for source */
	move	2,[point 7,path7]/* Destination pointer */
file7a:	ildb	3,1		/* Get a character */
	idpb	3,2		/* Move to new string */
	jumpn	3,file7a	/* Loop until null */
	move	1,[point 7,path7] /* Return pointer to new string */
#endasm
}

_file7(char *path)
{
  if ((((int)path >> 30) & 077) <= 066) return (int)(path - 1);
  return (int)(_mov7(path));
}

_tfile(char *suffix)
{
  if (0) suffix++;		/* Keep compiler happy */
#asm
	extern	$TMPDR		/* /tmp dir number */

	move	1,[point 7,path7] /* Get pointer to name buffer */
	move	2,$TMPDR	/* Get /tmp dir number */
	dirst%			/* Convert to string */
	 erjmp [move 1,[point 7,path7] /* No dev:<dir> if failure */
		jrst .+1]
	push	17,1		/* Save output pointer */
	movei	1,.hpelp	/* Get high precision elapsed time */
	hptim%			/* Read time */
	 erjmp	tfile1		/* Jump on error */
	caia			/* Have value, skip time% */
tfile1:	 time%			/* Just us MS clock */
	move	2,1		/* Set up for NOUT */
	pop	17,1		/* Get back output pointer */
	move	3,[no%mag!^D10]	/* Base ten, unsigned */
	nout%			/* Convert to ASCII */
	 jfcl			/* Try to ignore error (shouldn't happen) */
	movni	2,1		/* Back 1 character */
	adjbp	2,-1(17)	/* Pointer to suffix */
tfile3:	ildb	3,2		/* Get a character */
	idpb	3,1		/* Move to string */
	jumpn	3,tfile3	/* Loop until null */
	move	1,[point 7,path7] /* Return pointer to result */
#endasm
}

int
_rljfn(jfn)
int jfn;
{
    int acs[5];

    acs[1] = jfn;
    return jsys(RLJFN, acs);
}

int
_gtfdb(jfn, word)
int jfn, word;
{
    int acs[5];

    acs[1] = jfn;
    acs[2] = XWD(1,word);
    acs[3] = 3;				/* put the value in AC3 */
    return (jsys(GTFDB, acs)) ? acs[3] : 0;
}

int _jfndir(int jfn, int dir)
{
  int dirno, acs[5], dirnum;

  acs[1] = monsym("RC%EMO");
  acs[2] = jfn;
  if (!jsys(RCDIR, acs) || (acs[1] & monsym("RC%NOM")))
    return 0;
  dirno = acs[3];

  if (dir) {
    if (!(dirnum = (_gtfdb(jfn, _FBGEN) & RH)))
      return 0;
    dirno &= LH;
    dirno |= dirnum;
  }

  return dirno;
}

char *_dirst(int dirno, char *buf)
{
  int acs[5];
  char *p;

  acs[1] = (int)(buf - 1);
  acs[2] = dirno;
  if (!jsys(DIRST, acs)) return NULL;
  p = (char *)acs[1];
  *++p = '\0';
  return buf;
}

int _prdir(dir, flags, ap)
char *dir;
int flags;
va_list ap;
{
  return _rcdir(dir);
}

int _rcdir(char *dir)
{
  int acs[5];

  acs[1] = monsym("RC%EMO");
  acs[2] = _file7(dir);
  if (!jsys(RCDIR, acs) || (acs[1] & monsym("RC%NOM")))
      return 0;

  return acs[3];			/* Use directory # */
}

int
_chkac(facc, dacc, jfn)
int facc, dacc, jfn;
{
    int acs[5], unum, cdir;
    static int cblock[6];		/* Must be in PC section */

    jsys(GJINF, acs);			/* get job information */
    unum = acs[1];			/* user number */
    cdir = acs[2];			/* and connected directory */

    acs[1] =  _FHSLF;			/* reading our own process caps */
    jsys(RPCAP, acs);			/* do it */

    acs[1] = 6 + (jfn & LH ? 0 : CK_JFN); /* AC1: length, flags */
    acs[2] = (int) cblock;		/* AC2: argument block */

    /* Store into static block as late as possible to avoid collisions */
    cblock[_CKAAC] = (jfn & LH ? dacc : facc); /* get desired access code */
    cblock[_CKALD] = unum;		/* User number */
    cblock[_CKACD] = cdir;		/* Connected dir */
    cblock[_CKAEC] = acs[3];		/* enabled capabilities */
    cblock[_CKAUD] = jfn;		/* and jfn or dir # */
    cblock[_CKAPR] = 0;			/* Shouldn't matter */
    if ((!jsys(CHKAC, acs) > 0)		/* check file access */
	&& (acs[0] == monsym("CKAX4"))	/* If not on disk, */
	&& !(jfn & LH)) {		/* And JFN specified */
	acs[1] = jfn;			/* Then check device characteristics */
	if (jsys(DVCHR, acs) && (acs[2] & monsym("DV%AV")))
	    switch (facc) {		/* If available, */
	    case _CKARD:		/* and trying to read */
		return (acs[2] & monsym("DV%IN")); /* must do input */
	    case _CKAWR:		/* or trying to write */
		return (acs[2] & monsym("DV%OUT")); /* must do output */
	    }
	return 0;			/* no access */
    }
    if (acs[1] == -1) return 1;		/* success, return truth */
    if (!(jfn & LH)) _rljfn(jfn);	/* failure, release jfn */
    return 0;				/* and return falsehood */
}

int _getdir()
{
  int acs[5];

  if (USYS_VAR_REF(curdir)) return USYS_VAR_REF(curdir);
  if (!jsys(GJINF, acs)) return 0;
  return acs[2];
}

int _chdir(dirno)
int dirno;
{
  int oldcwd;

  if (!dirno) return 0;
  oldcwd = _getdir();
  if (dirno == oldcwd) return 1; /* Success if no change */
  if (!_chkac(0, _CKADR, dirno)) /* Check for lowest access */
    return 0;			/* No access */
  if (_acces(dirno)) {		/* Try to connect */
    dir_save(oldcwd);		/* If won, save previous value if needed */
  }
  else if (_urtsud.su_chdir_type == _URTSUD_CHDIR_CONNECT)
    return 0;			/* Return failure if must connect */
  USYS_VAR_REF(curdir) = dirno; /* Always use this in _parse() */
  return 1;			/* Success */
}

void _wfork(pid)
int pid;
{
#asm
	move 1,-1(17)		/* Get pid */
	lsh 1,-9		/* Extract fork index */
	tro 1,400000		/* Make it fork handle */
	wfork%			/* Wait for it */
	 erjmp .+1		/* Ignore errors */
#endasm
}

int _jchmod(jfn, mode)
int jfn, mode;
{
#if SYS_T20+SYS_10X
    int acs[5], protection, tmode = mode & ~USYS_VAR_REF(umask);

    protection = 0;				/* start at 0 protection */
    if (tmode & 0400) protection |= 0420000;	/* owner read/dir */
    if (tmode & 0200) protection |= 0250000;	/* owner write/delete/append */
    if (tmode & 0100) protection |= 0100000;	/* owner execute */
    if (tmode & 0040) protection |= 0004200;	/* group read/dir */
    if (tmode & 0020) protection |= 0002500;	/* group write/delete/append */
    if (tmode & 0010) protection |= 0001000;	/* group execute */
    if (tmode & 0004) protection |= 0000042;	/* world read/dir */
    if (tmode & 0002) protection |= 0000025;	/* world write/delete/append */
    if (tmode & 0001) protection |= 0000010;	/* world execute */
    acs[1] = (_FBPRT << 18) | jfn;		/* FDB offset,,JFN */
    acs[2] = 0777777;			/* mask for bits to change */
    acs[3] = protection;			/* new file protection */
    if (!jsys(CHFDB, acs)) {
	errno = EACCES;				/* failed to do it! */
	return -1;				/* return -1 on error, */
    } else return 0;				/* 0 on winnage. */
#else
    return -1;					/* -1 means lose */
#endif
}

#endif /*SYS_T20*/
#endif	/* SYS_T20+SYS_10X */

#if SYS_T10+SYS_CSI+SYS_WTS
/*
**  TOPS-10 and WAITS system-dependent routines
*/

static void
init_uio()	/* Initialize I/O (fd 0,1,2) at startup */
{
    struct _ufile *ef;

    USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Initialize shared I/O interlock */

#if SYS_CSI
    CSIUUO_CH("TRUSZ$", 1);		/* Set "true size" job param */
#endif

    /* Initialize FD 2 (error output) as that is always constant */
    ef = _ufcreate();			/* Get a free UF */
    ef->uf_ch = UIO_CH_CTTRM;		/* Use this "channel #" */
    ef->uf_flgs = UIOF_CONVERTED;	/* With this extra flag */
    _openuf(UIO_FD_STDERR, ef, O_RDWR); /* FD 2 now open for business! */

    /* No redirection by superior, so just duplicate this FD to the others */
    if (dup2(UIO_FD_STDERR, UIO_FD_STDIN) < 0
      || dup2(UIO_FD_STDERR, UIO_FD_STDOUT) < 0)
	abortmsg("Internal error in URT startup");
}

static char *
getjcl()	/* Read JCL given to program */
{
    char *argbuf, *p;
    int n, ch;
#if SYS_T10+SYS_CSI
    if (MUUO_TTY("RESCAN", 1) > 0)
	return NULL;			/* No command line, so don't try */

    /* Not sure how many chars we'll read, so be prepared for anything. */
    /* For time being, cheat and use large buffer. */
#define RESCAN_BUFSIZ 200
    n = RESCAN_BUFSIZ;
    argbuf = WALIGN_sbrk((size_t)n + 1); /* Make room for chars and null */
    p = argbuf-1;			/* point to start of buffer */
    while (--n >= 0) {
	if (MUUO_TTY("INCHRS", &ch) <= 0) /* Get char, don't hang if none */
	    break;			/* Call didn't skip, no more chars */
	*++p = ch;			/* Deposit in buffer */
	if (ch == '\n')
	    break;
    }

#elif SYS_WTS
    MUUO_TTY("RESCAN", &n);		/* Rescan command line */
    argbuf = WALIGN_sbrk(n + 1);	/* Make room for chars and null */
    p = argbuf-1;			/* point to start of buffer */
    while (--n >= 0) {
	ch = 0;				/* Set in case nothing read */
	MUUO_TTY("INCHRS", &ch);	/* Get char, don't hang if none */
	*++p = ch;			/* Deposit in buffer */
    }
#endif /* SYS_WTS */

    *++p = '\0';			/* Terminate with a null */
    return argbuf;
}

static void
tty_set()	/* Init TTY at startup; register reset rtn for exit */
{
}

static int
tty_fdp(fd)	/* TRUE if fd is open for a TTY */
int fd;
{
    return (USYS_VAR_REF(uffd[fd])->uf_type == UIO_DVTTY);
}

static void
abortmsg(s,a,b,c,d,e)	/* Print concatenated strings and halt. */
char *s,*a,*b,*c,*d,*e;
{
    _KCCtype_char7 tmpbuf[1000];
    union {
	_KCCtype_char7 *p7;
	char *p;
    }cp;
    *cp.p7 = tmpbuf;

/*    tty_reset(); */
    *cp.p = '?';
    strcpy(cp.p+1, s);
    if (a) { strcat(cp.p, a);
	if (b) { strcat(cp.p, b);
	    if (c) { strcat(cp.p, c);
		if (d) { strcat(cp.p, d);
		    if (e) { strcat(cp.p, e);
    } } } } }
    strcat(cp.p, "\r\n");		/* Terminate error string with CRLF */

    MUUO_TTY("OUTSTR", tmpbuf);		/* Use OUTSTR to output it */
    _exit(1);				/* Then stop program with prejudice */
}
#endif /* T10+CSI+WAITS */

#if SYS_ITS
/*
 *	Runtime stuff for ITS
 */

static void init_uio()
{
    char *iname = " TTY:_CPROG INPUT";
    char *oname = " TTY:_CPROG OUTPUT";
    struct _ufile *uf;

    USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Initialize shared I/O interlock */

    /* If TTY is not available, these just quietly fail to open the */
    /* channel since we set %TBNVR.  Later an channel not open error */
    /* will tell you that this happened... */

    uf = _ufcreate();		/* UF for input */
    SYSCALL3("sopen", SC_IMC(_UAI), uf->uf_ch, &iname);
    uf->uf_bsize = 7;
    uf->uf_flgs = UIOF_CONVERTED;
    _openuf(UIO_FD_STDIN, uf, O_RDONLY);

    uf = _ufcreate();		/* get another UF for output */
    SYSCALL3("sopen", SC_IMC(_UAO), uf->uf_ch, &oname);
    uf->uf_bsize = 7;
    uf->uf_flgs = UIOF_CONVERTED;
    _openuf(UIO_FD_STDOUT, uf, (O_WRONLY | O_CREAT | O_TRUNC));

    dup2(UIO_FD_STDOUT, UIO_FD_STDERR);		/* stderr is just a dup */
}


static void tty_set() {}
/* TTY_FDP(fd) - returns TRUE if given fd is associated with a TTY.
*/
static int
tty_fdp(fd)
int fd;
{
    return (USYS_VAR_REF(uffd[fd])->uf_type == UIO_DVTTY);
}

/* GETJCL() - Return a char pointer to (simulated) JCL string */

static int jclsiz = 100;	/* Start with buffer of this many wds */

static char *getjcl()
{
#asm

extern $retz

	push 17,[8]		; 2 words for xjname + ^M + null
	pushj 17,sbrk
	adjsp 17,-1
	CAMN 1,[-1]		; If not enough memory,
	 JRST $RETZ		; just return a null pointer!
	push 17,1		; Else, remember the start of it
	hrli 1,440700
	push 17,1		; And a 7-bit byte pointer
	.suset [.rxjname,,2]
.rjcl0:	setzi 1,
	lshc 1,6
	addi 1,40
	idpb 1,(17)
	jumpn 2,.rjcl0
	.suset [.roption,,1]
	tlnn 1,%opcmd		; If superior has no command
	 jrst .rjclx		; then that's all.
	movei 1,40
	idpb 1,(17)

	MOVE 1,jclsiz		; Start off with this many words!

.RJCL1:	LSH 1,2			; Multiply by 4 to get # bytes
	PUSH 17,1		; Get this many bytes
	PUSHJ 17,sbrk		; From low-level sbrk() call.
	ADJSP 17,-1		; Remove stack arg.
	CAMN 1,[-1]		; If not enough memory,
	 JRST [	adjsp 17,-2	; just return a null pointer!
		JRST $RETZ]
	HRRZ 2,-1(17)		; Get word address of block start
	HRLZI 3,2(2)		; Put it in LH of 3
	HRRI 3,3(2)		; and addr+1 in RH
	ADD 2,jclsiz		; Now in 2 get 1st addr past end
	SETZM -1(3)		; Clear 1st word
	BLT 3,(2)		; Zap all remaining words but one
	SETOM 1(2)		; Set up non-zero fence at last word.

	HRRZ 3,-1(17)		; Now get start of block again.
	ADD 3,[..RJCL,,2]	; Read JCL from superior
	.BREAK 12,3		; Try to read command string.
	SKIPE (2)		; See if clobbered last zero word.
	 JRST [	MOVEI 1,100	; Add this many more words
		ADDB 1,jclsiz
		JRST .RJCL1]	; and go try again!

	hrli 3,440700		; Now we copy it down
.rjcl2:	ildb 1,3		; and standardize terminator
	caie 1,15		; ^M
	 cain 1,3		; ^C
	  jrst .rjclx
	caie 1,37		; ^_
	 cain 1,0		; ^@
	  jrst .rjclx
	idpb 1,(17)
	jrst .rjcl2

.rjclx:	movei 1,15		; CR at the end for parsers
	idpb 1,(17)
	setzi 1,		; Then a null for C
	idpb 1,(17)
	move 1,-1(17)		; Make 7-bit b.p.
	hrli 1,350700
	adjsp 17,-2

#endasm
}

/* ABORTMSG() - Print message and halt */

static void abortmsg(msg)		/* more strings until NULL */
    char *msg;
{
#asm

	.iopush 1,
	.open 1,[sixbit /  !TTY/
		setz
		setz]
	 .lose
	movei 10,-1(17)
abrtm0:	setoi 3,
	adjbp 3,(10)
	move 4,3
	setzi 5,
abrtm1:	ildb 6,4
	skipe 6
	 aoja 5,abrtm1
	.call [	setz
		sixbit /SIOT/
		movei 1
		move 3
		setz 5 ]
	 .lose
	skipe -1(10)
	 soja 10,abrtm0
	.iopop 1,

#endasm

    _exit(1);
}

#endif /* ITS */
