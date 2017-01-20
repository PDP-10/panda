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
#include <urtsud.h>	/* URT StartUp Definition structure */
#include <stdio.h>
#include <errno.h>
#include <frkxec.h>	/* New KCC forkexec() call */
#include <sys/usysio.h>
#include <sys/usytty.h>	/* Internal TTY defs */
#include <sys/usysig.h>
#include <sys/file.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <ctype.h>
#include <string.h>	/* For str- and mem- defs */

#if SYS_T20+SYS_10X
#include <jsys.h>
extern int _gtjfn();

#elif SYS_ITS
#include <sysits.h>

#elif SYS_T10+SYS_CSI+SYS_WTS
#include <muuo.h>
#endif

/* Exported functions (defined here) */
void _runtm();			/* URT startup entry point */
void _panic();			/* URT internal error handler */

/* Imported functions (external) */
extern main();			/* From user program */
extern char *sbrk();		/* See the WALIGN_sbrk macro below */
extern void exit(), _exit();
extern dup2(), pipe(), forkexec(), fstat();
extern _openuf();

/* Internal functions */
static void setfil();
static int shell_parse(), exec_parse();
static void argfset(), arg_set();	/* use these to set args in argv */

/* Global URT data.  Only "errno" is intended to be user-visible. */
int errno = 0;		/* Error # from last failing UN*X syscall */
int _vfrkf = 0;		/* Non-zero if memory shared as result of vfork() */
int _nfork = 0;		/* Count of inferiors created by this process.
			** Only used to determine whether a fork or vfork
			** was ever done, i.e. if exit() should wait().
			*/

/* Define macro so that sbrk()'s idea of the break is always word-aligned
** upon entry to the user program.
*/
static char *wdsbrk();			/* Use routine now, not macro */
#define WS (sizeof(int))		/* Word size */
#define WALIGN_sbrk(n) wdsbrk(n)	/* Word-aligned sbrk() */

/* Macro to reduce some typing; used with abortmsg(). */
#define LASTERR strerror(_ERRNO_LASTSYSERR)

#define MAX_ARG 32	/* # words of argv space to increment each time */

static int argc;		/* argument count (finally given to main()) */
static char **argv;		/* pointer to argv vector (ditto) */
static int argv_size;		/* current max size of argv */

/************************************************************************
**			SYSTEM DEPENDENT ROUTINES
**
**	The following are the internal system-dependent functions
**	which must be provided separately for each system.
*/
static void init_uio();	/* Initialize I/O (fd 0,1,2) at startup */
static char *getjcl();	/* Read JCL given to program */
static void tty_set();	/* Init TTY at startup; register reset rtn for exit */
static int tty_fdp();	/* TRUE if fd is open for a TTY */
static void abortmsg();	/* Print concatenated strings and halt. */

/*
** _RUNTM()	UN*X Run Time C program startup!
*/

void
_runtm()
{
    int (*parser)();			/* parser function to call */
    char *p, *arg_vector[MAX_ARG];

    init_uio();				/* initialize uio layer */
    argc = 0;				/* no args on command line yet */
    argv = arg_vector;			/* start off using this array */
    argv_size = MAX_ARG;		/* size of argv array */
    if (_urtsud.su_parser_type != _URTSUD_NO_PARSE && (p = getjcl())) {
	switch (_urtsud.su_parser_type) {
	    default:
	    case _URTSUD_SHELL_PARSE: parser = shell_parse; break;
	    case _URTSUD_EXEC_PARSE: parser = exec_parse; break;
	}
	(*parser)(p);			/* invoke the parser */
    }
    tty_set();			/* Set up TTY stuff if any.  If so, it must */
				/* register a cleanup rtn with atexit()! */ 

    atexit(_cleanup);		/* Register STDIO cleanup rtn for exit() */
    errno = 0;			/* Ensure this is initially clear for user */
    exit(main(argc, argv));	/* Call user program, return value! */
}

void
_panic(msg)
char *msg;
{
    abortmsg("C internal runtime error: ", msg, (char *)NULL);
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

static char *indfparse();
static int argscan();
static int runpipe();
#if SYS_T20+SYS_10X
static char *mangle();
static int procamper();
#endif

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
#define PIPEIN	0	/* Indices into array used by pipe() call */
#define PIPEOUT	1

static int
runpipe(cp)
char *cp;
{
#if SYS_T20
    struct frkxec f;
    int pipes[2];		/* For pipe FDs */
    char *av[3];		/* Temporary argv array */
    char pgmnam[1000];		/* Very big program name */

    argscan(pgmnam, &cp, 0);	/* Get program name (always top level) */
    if (pipe(pipes) == -1)
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

    /* Special hack: forget about pipe's input UF so we don't close it
     * by accident; there is no mechanism for sharing FD-use count
     * between forks!  Sigh.  If there was, we could just
     * dispense with the following two statements.
     */
    _uffd[pipes[PIPEIN]]->uf_nopen = 0;	/* Can re-use this UF */
    _uffd[pipes[PIPEIN]] = NULL;	/* Quietly forget pipe-input FD */

    return pipes[PIPEOUT];		/* Return FD for output to pipe */
#endif /* T20 */
}

/* ARGFSET - Add a filename arg to the argv array, bumping argc.
**	Expands wildcards if needed and performs other checking.
*/
static int caseall();
#if SYS_T20+SYS_10X
static int wfopen(), wfnext();
static char *wfname();
#endif

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
	int wjfn;

	if ((wjfn = wfopen(arg)) == 0)	/* open wildcard spec */
	    abortmsg("No match for \"", arg, "\"", NULL);
	do
	    arg_set(wfname(wjfn));	/* Get new name and set it */
	while (wfnext(wjfn));
	return;
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
		if (!(*++wp = *++cp))	/* Quote next ch<ar (keep quote!) */
		    break;		/* don't allow quote of NUL */
		continue;		/* and keep going */


	    case '"':	/* Permit embedding of quoted strings */
	    case '\'':
		c = *cp;			/* Remember terminator char */
		--wp;				/* Back up to flush it */
		while (*++wp = *++cp) {
		    if (*cp == c) break;
		    if (*cp == '\\') {		/* Allow backslash quotes */
			if (!(*wp = *++cp))
			    break;		/* don't allow quote of NUL */
		    } else if (*cp == SYSFIL_QTCH)
			if (!(*++wp = *++cp))
			    break;		/* don't allow quote of NUL */
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
    if ((tmpf = open(name, flags, 0644)) < 0)
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

    /* Initialize FD 2 (error output) as that is always constant */
    ef = _ufcreate();			/* Get a free UF */
    ef->uf_ch = _CTTRM;			/* Use this JFN */
    ef->uf_flgs = UIOF_CONVERTED;	/* With this extra flag */
    _openuf(ef, O_RDWR);
    _uffd[UIO_FD_STDERR] = ef;		/* FD 2 now open for business! */

    /* See what our primary JFNs really are */
    a.acs[1] = _FHSLF;
    jsys(GPJFN, a.acs);
    if (a.res.pin == ef->uf_ch) {	/* If stdin same as stderr, */
	_uffd[UIO_FD_STDIN] = ef;	/* just point there. */
	ef->uf_nopen++;
    } else {
	iuf = _ufcreate();
	iuf->uf_ch = a.res.pin;		/* Must set up with this JFN */
	iuf->uf_flgs = UIOF_CONVERTED;	/* With this extra flag */
	_openuf(iuf, O_RDONLY);		/* Take care of rest of vars */
	_uffd[UIO_FD_STDIN] = iuf;	/* Then make FD 0 open for business */
    }

    if (a.res.pout == ef->uf_ch) {	/* If stdout same as stderr, */
	_uffd[UIO_FD_STDOUT] = ef;	/* just point there. */
	ef->uf_nopen++;
    } else {
	of = _ufcreate();
	of->uf_ch = a.res.pout;		/* Must set up with this JFN */
	of->uf_flgs = UIOF_CONVERTED;	/* With this extra flag */
	_openuf(of, O_WRONLY);		/* Take care of rest of vars */
	_uffd[UIO_FD_STDOUT] = of;	/* Then make FD 1 open for business */
    }
}

/* ---------------------------------------- */
/*	set terminal mode word		    */
/* ---------------------------------------- */

#define CCOC_MAGIC	0525252525252

static int ccoc[2];
static void tty_reset();

/* TTY_FDP(fd) - returns TRUE if given fd is associated with a TTY.
*/
static int
tty_fdp(fd)
int fd;
{
    return (_uffd[fd]->uf_type == UIO_DVTTY);
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

/* ABORTMSG(s1, s2, s3, s4, s5) - outputs string composed of given
**	concatenated strings, and exits.  A NULL argument terminates the
**	list of strings.
*/
static void
abortmsg(s, a,b,c,d,e)
char *s, *a,*b,*c,*d,*e;
{
    int ac[5];
    char tmpbuf[1000];

    tty_reset();
    strcpy(tmpbuf, s);
    if (a) { strcat(tmpbuf, a);
	if (b) { strcat(tmpbuf, b);
	    if (c) { strcat(tmpbuf, c);
		if (d) { strcat(tmpbuf, d);
		    if (e) { strcat(tmpbuf, e);
    } } } } }
    strcat(tmpbuf, "\r\n");	/* Terminate error string with CRLF */
    ac[1] = (int) (tmpbuf-1);
    jsys(ESOUT, ac);			/* Use ESOUT% to output it */
    _exit(1);				/* Then stop program with prejudice */
}

/* Wildcard filename routines */

/* WFOPEN - open wild card filename
**	Returns wild JFN for filespec, 0 if failure.
*/
static int
wfopen(name)
char *name;
{
    return _gtjfn(name, O_RDONLY | O_T20_WILD);
}

/* WFNAME - Return filename for wild JFN
**	Returns pointer to dynamically allocated filename string
*/
static char *
wfname(jfn)
int jfn;
{
    char *fp, fname[200];
    int ablock[5];

    ablock[1] = (int) (fname - 1);
    ablock[2] = jfn & 0777777;	/* jfn, no flags */
    ablock[3] = 0111110000001;	/* DEV+DIR+NAME+TYPE+VERS, punctuate */
    if (!jsys(JFNS, ablock))
	return NULL;		/* something bad happened */
    fp = WALIGN_sbrk(strlen(fname) + 1);
    strcpy(fp, fname);		/* copy the file name here */
    return fp;
}

/* WFNEXT - Make wild JFN point to next real file
**	Returns success or failure (not JFN)
*/
static int
wfnext(jfn)
int jfn;
{
    int ablock[5];

    ablock[1] = jfn;		/* save jfn and flags */
    return jsys(GNJFN, ablock);
}

/* GETJCL - Return command line
*/
static char *
getjcl()
{
    char *buf;

#if SYS_T20
    int n, acs[5];

    /* Ask to rescan command line, see if anything there. */
    acs[1] = _RSINI;
    if (jsys(RSCAN, acs) > 0) n = acs[1];	/* Find # chars avail */
    else n = 0;
    if (n <= 0)
	return NULL;			/* Nothing there */

    buf = WALIGN_sbrk((size_t)n + 1);	/* make room for chars and null */

    /* Have to gobble the RSCAN line directly since only way to access
    ** the rscan buffer is by using a JFN equivalent to the controlling TTY.
    ** If our .PRIIN has been redirected, a normal SIN or read() will not
    ** get the rscan stuff at all.
    ** TENEX is probably out of luck in this respect.
    */
    acs[1] = _CTTRM;
    acs[2] = (int) (buf-1);
    acs[3] = -n;
    jsys(SIN, acs);			/* Read the stuff */
    buf[n] = 0;				/* null-terminate */
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
#endif	/* SYS_T20+SYS_10X */

#if SYS_T10+SYS_CSI+SYS_WTS
/*
**  TOPS-10 and WAITS system-dependent routines
*/

static void
init_uio()	/* Initialize I/O (fd 0,1,2) at startup */
{
    struct _ufile *ef;

#if SYS_CSI
    CSIUUO_CH("TRUSZ$", 1);		/* Set "true size" job param */
#endif

    /* Initialize FD 2 (error output) as that is always constant */
    ef = _ufcreate();			/* Get a free UF */
    ef->uf_ch = UIO_CH_CTTRM;		/* Use this "channel #" */
    ef->uf_flgs = UIOF_CONVERTED;	/* With this extra flag */
    _openuf(ef, O_RDWR);
    _uffd[UIO_FD_STDERR] = ef;		/* FD 2 now open for business! */

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
    return (_uffd[fd]->uf_type == UIO_DVTTY);
}

static void
abortmsg(s,a,b,c,d,e)	/* Print concatenated strings and halt. */
char *s,*a,*b,*c,*d,*e;
{
    _KCCtype_char7 tmpbuf[1000];
    char *cp = (char *)(int)tmpbuf;

/*    tty_reset(); */
    *cp = '?';
    strcpy(cp+1, s);
    if (a) { strcat(cp, a);
	if (b) { strcat(cp, b);
	    if (c) { strcat(cp, c);
		if (d) { strcat(cp, d);
		    if (e) { strcat(cp, e);
    } } } } }
    strcat(cp, "\r\n");		/* Terminate error string with CRLF */

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

    /* If TTY is not available, these just quietly fail to open the */
    /* channel since we set %TBNVR.  Later an channel not open error */
    /* will tell you that this happened... */

    uf = _ufcreate();		/* UF for input */
    SYSCALL3("sopen", SC_IMC(_UAI), uf->uf_ch, &iname);
    uf->uf_bsize = 7;
    uf->uf_flgs = UIOF_CONVERTED;
    _openuf(uf, O_RDONLY);
    _uffd[UIO_FD_STDIN] = uf;

    uf = _ufcreate();		/* get another UF for output */
    SYSCALL3("sopen", SC_IMC(_UAO), uf->uf_ch, &oname);
    uf->uf_bsize = 7;
    uf->uf_flgs = UIOF_CONVERTED;
    _openuf(uf, (O_WRONLY | O_CREAT | O_TRUNC));
    _uffd[UIO_FD_STDOUT] = uf;

    dup2(UIO_FD_STDOUT, UIO_FD_STDERR);		/* stderr is just a dup */
}


static void tty_set() {}
/* TTY_FDP(fd) - returns TRUE if given fd is associated with a TTY.
*/
static int
tty_fdp(fd)
int fd;
{
    return (_uffd[fd]->uf_type == UIO_DVTTY);
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
