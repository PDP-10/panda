/*	CC.C - KCC Main program
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.187, 26-May-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.74, 8-Aug-1985
**
**	Original version (c) 1981 K. Chen
*/

#include "ccsite.h"
#include "cc.h"
#include "ccchar.h"
#include <string.h>
#include <stdlib.h>	/* For EXIT_ values and malloc decls */
#include <time.h>	/* For clock() to get runtime */

/* Imported functions */
extern SYMBOL *symfidstr();	/* CCSYM */
extern char *execargs();	/* CCASMB */
extern int asmb();		/* CCASMB */
extern void runlink();		/* CCASMB */
extern char *estrcpy();		/* CCASMB */
extern char *fstrcpy();		/* CCASMB */
extern int makprefile();	/* CCOUT */
extern NODE *extdef(), *tntdef();	/* CCDECL */
extern void syminit(), ppinit(), lexinit(), initpar(),
	outinit(), outdone(),
	ppdefine(), passthru(),
	symdump(), typedump(),
	gencode();
extern int unlink(), stat();	/* Syscalls */

/* Internal functions */
static void showcpu(), setcpu(), cindfiles();
static void coptimize(), cdebug(), ctargmach(), cportlev(), cwarnlev(),
	cverbose(), ciload();
static int cswitch(), cfile(), files(), mainsymp(), needcomp();
static int chkmacname();

static char mainname[FNAMESIZE] = {0};	/* Name of module containing "main" */
static char *savname = NULL;		/* Pointer to desired -o filename */
static int vrbarg = 0;			/* Patch 1 to show args on stderr */


main(argc, argv)
int argc;
char **argv;
{
    int ac;			/* temp copy of argc */
    char **av;			/* temp copy of argv */
    char *nextprog = NULL;	/* Set to program to chain through, if any */
    int toterrs = 0;		/* Total # errors for all files */
    int nfiles = 0;		/* # files to try compiling */
    int asmfiles = 0;		/* # files for which assembly was deferred */

    /* Initialize KCC command switch values.
    ** All are either initially 0, or given default values in CCDATA.
    */
    link = assemble = delete = 1;
    coptimize("all");			/* Turn on all optimizer flags */

    /* Get command line arguments */
    if (argc <= 1) {			/* No command line? */
	nextprog = execargs(&argc, &argv);	/* Try getting from RPG/CCL */
	if (argc > 1)
	    link = 0;			/* Got stuff, so act as if -c given */
	else {				/* Sigh, tell user where help lives */
	    fstrcpy(mainname, hfpaths[0], "CC.DOC");
	    jmsg("Bad usage, see %s for help.", mainname);
	    return EXIT_FAILURE;
	}
    }

    /* Have initial command line; now scan for any indirect files (@file) */
    cindfiles(&argc, &argv);

    /* Now have complete command line, report it if desired.
    ** This debugging switch needs to be patched in by hand, because at this
    ** point it cannot have been set yet from the command line!
    */
    if (vrbarg) {
	fprintf(stderr, "KCC args (%d):", argc);
	for (ac = 0; ac < argc; ++ac)
	    fprintf(stderr, " %s", argv[ac] ? argv[ac] : "<null>");
	fprintf(stderr,"\n");
    }

    /* Now process command line.  First scan for all switches */
    for (av = argv+1, ac = argc; --ac > 0; ++av)
	if (**av == '-') {
	    if (cswitch(*av, &ac, &av))	/* Process a switch */
		*av = NULL;		/* OK to zap it now */
	} else ++nfiles;		/* Assume a filename spec */

    /* Now finalize after all switches scanned */
    setcpu();				/* Set all CPU feature flags */
    if (nfiles == 0)			/* This sometimes happens */
	jerr("No filenames specified");
	
    /* If no errors, now scan for all filenames, and process them. */
    if ((toterrs += nerrors) == 0)
	for (av = argv+1, ac = argc; --ac > 0; ++av)
	    if (*av && **av != '-') {
		if (cfile(*av) == 0)	/* Compile a file */
		    asmfiles++;		/* Count deferred assemblies */
		nfiles++;
		toterrs += nerrors;
	    }

    /* Now see what to invoke next, if any.  Note runlink() never returns. */
    if (toterrs)			/* If any errors, */
	link = 0;			/* never invoke loader. */
    if (asmfiles || link || nextprog)
	runlink(link,			/* Whether to invoke loader or not */
		argc-1, argv+1,		/* Loader args (.REL files) */
		(savname ? savname	/* Loader arg: output file name */
			 : mainname),
		nextprog);		/* Chained program to invoke next */

    return (toterrs ? EXIT_FAILURE : EXIT_SUCCESS);
}

/* CINDFILES() - Scan an argv array for indirect file specs and
**	expand them into a new argv array.
*/
static void
cindfiles(aac, aav)
int *aac;
char ***aav;
{
    static int dynarr = 0;		/* Set if array was malloced */
    register int i, cnt;
    register char *cp;
    FILE *f;
    char *buf;
    int bufsiz;
#define NINDARGS 500
    int locac;
    char *locav[NINDARGS];

    int ac = *aac;
    char **newav, **avp, **av = *aav;

    /* Scan current array and process any indirect files. */
    for (i = 0; i < ac; ++i) if (av[i] && av[i][0] == '@') {
	if ((f = fopen(&av[i][1], "r")) == NULL) {
	    errfopen("indirect", av[i]);	/* Couldn't open, tell user */
	    av[i] = NULL;
	    continue;
	}
	/* Read all of file into a memory block */
	bufsiz = cnt = 0;
	buf = cp = NULL;
	while (!feof(f)) {
	    if (++cnt >= bufsiz) {	/* Ensure have room in buffer */
		char *nbuf;
		if ((nbuf = realloc(buf, bufsiz += 1000)) == NULL) {
		    jerr("Out of memory for indirect file \"%s\"", av[i]);
		    --cnt;
		    break;		/* Leave loop now */
		}
	        cp = (buf = nbuf) + (cnt-1);
	    }
	    *cp++ = getc(f);
	}
	fclose(f);
	if (cp == NULL) {	/* If got nothing, scan for next file */
	    av[i] = NULL;
	    continue;
	}
	cp[-1] = '\0';		/* Ensure buffer tied off with null */

	/* Now scan through the buffer to find arguments, dropping NULLs in
	** to split them up, and add pointers to our local array.
	** "cnt" has the # chars in the buffer, including a terminating null.
	*/
	locac = 0;
	cp = buf;
	for (; --cnt > 0; ++cp) {
	    if (!isgraph(*cp))
		continue;		/* Ignore whitespace/cntrls */
	    if (*cp == '-' && (cnt <= 0 || cp[1] == '\n'))
		continue;		/* Ignore T20 "line continuation" */
	    if (*cp == ';') {
		while (--cnt > 0 && *++cp != '\n');
		continue;		/* Ignore ;-commented lines */
	    }
	    if (*cp == '!') {
		while (--cnt > 0 && *++cp != '!' && *cp != '\n');
		continue;		/* Ignore !-commented phrases/lines */
	    }

	    /* Start scanning over an argument */
	    if (locac >= NINDARGS) {
		jerr("More than %d args in indirect file \"%s\"",
							NINDARGS, av[i]);
		break;
	    }
	    locav[locac++] = cp;		/* Remember ptr to arg */
	    while (--cnt >= 0 && isgraph(*++cp));
	    if (cnt >= 0)
		*cp = '\0';			/* Terminate arg with null */
	}

	/* Now combine new args with old args.  New table size is
	** # old args (minus current arg),
	** plus # new args (plus ending null pointer).
	*/
	if (!(newav = (char **)malloc((ac+locac)*sizeof(char *)))) {
	    jerr("Out of memory for args of indirect file \"%s\"", av[i]);
	    av[i] = NULL;
	    continue;
	}
	avp = newav;
	for (cnt = 0; cnt < i; ++cnt)		/* Copy already checked args */
	    *avp++ = av[cnt];
	for (cnt = 0; cnt < locac; ++cnt)	/* Copy new args */
	    *avp++ = locav[cnt];
	for (cnt = i+1; cnt < ac; ++cnt)	/* Copy old unchecked args */
	    *avp++ = av[cnt];
	*avp = NULL;		/* Last one always null */
	ac = (ac - 1) + locac;	/* Old args minus 1, plus new args */
	if (!dynarr) ++dynarr;	/* If old not dynamic, say new one is */
	else free((char *)av);	/* else must free up old dynamic array */
	av = newav;		/* Pointer to new array */
	--i;			/* Compensate for loop increment */
    }

    *aac = ac;		/* Return new values (normally the same) */
    *aav = av;
}

/* CSWITCH - Scan argv array for command line switches
**
** Returns 0 if should keep this switch spec around (used for -l).
** Otherwise, OK to zap switch spec, don't need to keep around.
*/
static int
cswitch(s, aac, aav)
char *s;
int  * aac;			/* Passed along just for stupid -o switch */
char * **aav;
{
    while (*++s) switch (*s) {

    case 'a':			/* -a<file>  Set #asm tmp file name */
	asmtfile = ++s;		/*	rest of arg is filename */
	return 1;

    case 'A':			/* -A<file>  Set asm hdr file name */
	asmhfile = ++s;		/*	rest of arg is filename */
	return 1;

    case 'c':			/* -c	Compile only */
	link = 0;		/* 	Don't run linking loader */
	break;

    case 'C':			/* -C	Pass on comments during -E */
	keepcmts = 1;		/*	pass comments through to stdout */
	break;

    case 'd':			/* -d	Debug (same as -d=all) */
	if (s[1] == '=') {	/* -d=<flags>	If extended syntax, */
	    ++s;
	    cdebug(++s);	/*	go hack rest of arg string. */
	    return 1;
	} else cdebug("all");	/*	Else just turn everything on */
	break;

    case 'D':			/* -D<ident>   Define a macro */
	if (!chkmacname(s))	/* -D<ident>=<def> */
	    return 1;
	if (npredef < MAXPREDEF)
	    predefs[npredef++] = ++s;	/* rest of arg is def string */
	else jerr("More than %d predefined macros", MAXPREDEF);
	return 1;			/* so don't use as switches */

    case 'E':			/* -E	Run through preproc. only */
	prepf = 1;
	delete = assemble = link = 0;
	break;

#if SYS_CSI	/* Temporary for compatibility, flush later */
    case 'g':			/* -g   Debugging:  link ddt.rel */
	ldddtf = 1;		/* added 09/15/89 by MVS */
	break;
#endif

    case 'H':			/* -H<path> Specify #include <> path */
	if (nhfpaths < MAXINCDIR-1)
	    hfpaths[nhfpaths++] = ++s;	/* Remember the search path */
	else jerr("More than %d -H paths", MAXINCDIR);
	return 1;

    case 'h':			/* -h<path> Specify <sys/ > path */
	if (nhfsypaths < MAXINCDIR-1)
	    hfsypaths[nhfsypaths++] = ++s;	/* Remember search path */
	else jerr("More than %d -h paths", MAXINCDIR);
	return 1;

    case 'i':			/* -i  Loader: extended addressing */
	if (s[1] == '=') {	/* -i=<flags>	If extended syntax, */
	    ++s;
	    ciload(++s);	/*	go hack rest of arg string. */
	    return(1);
	} else ciload("ext");	/*	Else just say "extended" */
	break;

    case 'I':			/* -I<path> Add an #include "" path */
	if (nincpaths < MAXINCDIR-1)
	    incpaths[nincpaths++] = ++s;    /* Remember the search path */
	else jerr("More than %d -I paths", MAXINCDIR);
	return 1;

    case 'l':			/* -lxxx Loader: Search library */
	return 0;		/* Just skip over this switch */

    case 'L':			/* -L<path> Specify library path */
				/* -L=<string> Specify LINK cmds */
	if (s[1] == '=')
	    return 0;		/* Just skip over -L= for now */
	libpath = ++s;		/* Set library path */
	return 1;

    /* This switch is semi-obsolete.  -x=macro is preferred. */
    case 'm':			/* -m	Use MACRO  */
	tgasm = TGASM_MACRO;	/*	 for target asm, not FAIL */
	break;

    /* This switch is obsolete.  -O= is preferred. */
    case 'n':			/* -n	No optimize */
	coptimize("");		/*	Turn off all optimizations */
	break;			/*	just as if -O= given. */

    case 'O':			/* -O	Optimize (same as -O=all) */
	if (s[1] == '=') {		/* -O=<flags>	If extended syntax, */
	    ++s;
	    coptimize(++s);		/*	go hack rest of arg string. */
	    return 1;
	} else coptimize("all");	/*	Else just turn everything on */
	break;

    case 'o':			/* -o=<filename> Loader: output file */
	if (s[1] == '=') s += 2;	/* -o <filename> Permit old syntax */
	else {
	    **aav = NULL;		/* Flush this arg */
	    ++(*aav);			/* Point to next one */
	    if (--(*aac) <= 0 || !(s = **aav))
		jerr("No filename arg for -o");
	}
	savname = s;
	return 1;			/*  Can flush arg from switch list */

    case 'P':			/* -P	Port level (same as -P=) */
	if (s[1] == '=') {		/* -P=<flags>	If extended syntax, */
	    ++s;
	    cportlev(++s);		/*	go hack rest of arg string. */
	    return(1);
	} else cportlev("");		/*	Else just use basic level */
	break;

#if SYS_CSI
    case 'p':			/* -p   Turn on Bliss Profiler (link locals)*/
	profbliss = 1;		/* added 09/15/89 by MVS */
	break;
#endif

    case 'q':			/* -q	Conditional compilation */
	condccf = 1;
	break;

    /* Obsolete switch. */
    case 's':			/* -s	Dump symtab (same as -d=sym) */
	cdebug("sym");
	break;

    case 'S':			/* -S   Do not delete asm source */
	delete = 0;
	link = assemble = 0;	/* don't link or assemble either */
	break;

    case 'U':			/* -U<ident>   Undefine macro */
	if (!chkmacname(s))	/*	Check out identifier syntax */
	    return 1;
	if (npreundef < MAXPREDEF)
	    preundefs[npreundef++] = ++s;
	else jerr("More than %d -U macro undefinitions", MAXPREDEF);
	return 1;

    case 'v':			/* -v  Verbosity level (same as -v=) */
	if (s[1] == '=') {		/* -v=<flags>	If extended syntax, */
	    ++s;
	    cverbose(++s);		/*	go hack rest of arg string. */
	    return(1);
	} else cverbose("all");		/*	Else just use basic level */
	break;

    case 'w':			/* -w   Suppress warning messages */
	if (s[1] == '=') {		/* -w=<flags>	If extended syntax, */
	    ++s;
	    cwarnlev(++s);		/*	go hack rest of arg string. */
	    return(1);
	}
#if SYS_CSI /* Temporary for compatibility, flush later */
	if (isdigit(s[1])) wrnlev = toint(*++s);
	else
#endif
	cwarnlev("all");		/*	Else just use basic level */
	break;

    case 'x':			/* -x=<flags> Cross-compilation sws */
	if (s[1] == '=') {		/*	If extended syntax, */
	    ++s;
	    ctargmach(++s);		/*	go hack rest of arg string. */
	    return 1;
	}
	jerr("Syntax for -x is \"-x=flag\"");
	return 1;

    default:
	jerr("Unknown switch: \"-%c\"", *s);
	return 1;
    }
    return 1;
}

/* Command switch auxiliary routines.
**
** The standard way for extending KCC switch capabilities is by using
** parcswi() to implement the following keyword-based syntax, as exemplified by
** the -O switch:
**		-O=<flag>+<flag>+<flag>...
**	The flags are handled in the order given; all are cleared
** at the start.  Using a '-' instead of '+' as the separator will cause
** the next flag to be turned OFF instead of ON.  Either the flag name
** "all" or just the switch "-O" will cause all flags to be turned on.
**	The handling of flag keywords is governed by a table of "flagent"
** structures.
*/
struct flagent {		/* Structure of an entry in flag table */
	char *name;		/* Flag name */
	int *fladdr;		/* Address of runtime flag value */
	int flval;		/* Value to set it to if user gives flag */
};

/* PARCSWI - Parse an extended-style command switch.
**	A NULL name entry marks end of table.
**	An entry with a NULL flag address is the special "all" indicator.
*/
static char *cmpname();
static void errfswi();

static void
parcswi(s, ftab, resetf)
char *s;
struct flagent *ftab;		/* Pointer to array of flagents */
int resetf;			/* True if want all flags cleared initially */
{
    int onoff, c, i;
    char *cp;

    /* First turn off all flags */
    if (resetf)
	for (i = 0; ftab[i].name; ++i)
	    if (ftab[i].fladdr) *(ftab[i].fladdr) = 0;

    while (c = *s) {
	onoff = 1;			/* First do separator */
	if (c == '-') {	onoff = 0; ++s; }
	else if (c == '+') ++s;

	/* Look up switch in table */
	for (i = 0; cp = ftab[i].name; i++) {
	    cp = cmpname(s, cp);
	    if (*cp == '\0' || *cp == '+' || *cp == '-')
		break;
	}
	if (cp) {		/* Found one? */
	    s = cp;
	    if (ftab[i].fladdr)			/* Single flag */
		*(ftab[i].fladdr) = (onoff ? ftab[i].flval : 0);
	    else for (i = 0; ftab[i].name; ++i)	/* Hack "all" */
		if (ftab[i].fladdr)
		    *(ftab[i].fladdr) = (onoff ? ftab[i].flval : 0);
	} else {		/* Nope, error.  Find end of flag name */
	    for (cp = s; *cp && *cp != '+' && *cp != '-'; ++cp);
	    c = *cp;			/* Remember last char */
	    *cp = '\0';			/* and temporarily zap it */
	    errfswi(s, ftab);		/* Give user error message */
	    s = cp;			/* Restore zapped char */
	    *s = c;			/* And carry on from that point */
	}
    }
}

static void
errfswi(s, ftab)
char *s;
struct flagent *ftab;		/* Pointer to array of flagents */
{
    char emsg[1000];		/* Lots of room for temp string */
    char *cp = emsg;

    for (; ftab->name; ++ftab)	/* Build string of flag names */
	*cp++ = ' ', cp = estrcpy(cp, ftab->name);
    jerr("Unknown flag \"%s\" (choices are:%s)", s, emsg);
}

/* CMPNAME - String comparison, returns pointer to first non-matching char
*/
static char *
cmpname(str, tst)
char *str,*tst;
{
    if (*str == *tst)
	while (*++str == *++tst)
	    if (*str == 0) break;
    return str;
}

/* CHKMACNAME - Verify syntax for -D and -U macro names.
*/
static int
chkmacname(s)
char *s;
{
    char *cp = s;
    int typ = *s;	/* 'D' or 'U' */

    if (!iscsymf(*++cp)) {
	jerr("Bad syntax for -%c macro name: \"%s\"", typ, cp);
	return 0;
    }
    while (iscsym(*++cp)) ;		/* Skip over ident name */
    if (*cp  && (typ == 'U' || (*cp != '='))) {
	jerr("Bad syntax for -%c macro name: \"%s\"", typ, s+1);
	return 0;
    }
    return 1;
}

/* COPTIMIZE - Set -O optimization switches
**	Flags are used to provide finer degrees of control over the
** optimization process instead of just turning everything on or
** off; this makes debugging easier.
*/
struct flagent copttab[] = {
	"all",	NULL,	   0,	/* First element is special */
	"parse", &optpar,  1,	/* Parse tree optimization */
	"gen",	&optgen,   1,	/* Code generator optimizations */
	"object", &optobj, 1,	/* Object code (peephole) optimizations */
	NULL,	NULL,	NULL
};

static void
coptimize(s)
char *s;
{
    parcswi(s, copttab, 1);	/* Reset switches and parse */
}

/* CDEBUG - Set -d debug switches.
**	This is exactly like COPTIMIZE only the switches here are for
** controlling what sorts of debug checks or output are produced.
**	The syntax is:
**		-d=<flag>+<flag>+<flag>...
**	The flags are handled in the order given; all are cleared
** at the start.  Using a '-' instead of '+' as the separator will cause
** the next flag to be turned OFF instead of ON.  Either the flag name
** "all" or just the switch "-d" will cause all flags to be turned on.
*/
struct flagent cdebtab[] = {
	"all",	NULL,     0,	/* First element is special */
	"parse", &debpar, 1,	/* Parse tree output */
	"gen",	&debgen,  1,	/* Code generator output */
	"pho",	&debpho,  1,	/* Peephole optimizer output */
	"sym",	&debsym,  1,	/* Symbol table output */
	NULL,	NULL,	NULL
};

static void
cdebug(s)
char *s;
{
    parcswi(s, cdebtab, 1);	/* Reset switches and parse */
}

/* CWARNLEV - Set -w warning message suppression switches.
**	Same syntax as for -O and -d.  -w alone is same as "all".
*/
static struct flagent cwlevtab[] = {
	"all",	&wrnlev, WLEV_ALL,	/* Suppress everything */
 	"note",	&wrnlev, WLEV_NOTE,	/* Suppress notes */
	"advise", &wrnlev, WLEV_ADVISE,	/* Suppress notes & advice */
	"warn",	&wrnlev, WLEV_WARN,	/* Suppress n & a & warnings */
	NULL,	NULL,	NULL
};

static void
cwarnlev(s)
char *s;
{
    parcswi(s, cwlevtab, 1);	/* Reset switches and parse */
}

/* CTARGMACH - Set -x cross-compilation switches.
**	Same syntax as for -O and -d.
**	There is no "all" and no flags are reset.  -x alone does nothing.
** Note that the value for the CPU type switches is not 1, so that
** we can distinguish between a default setting (1) and a switch setting (2).
*/
struct flagent ctgmtab[] = {
	"tops20", &tgsys, TGSYS_TOPS20,	/* 5 choices of system */
	"tops10", &tgsys, TGSYS_TOPS10,
 	"waits",  &tgsys, TGSYS_WAITS,
	"tenex",  &tgsys, TGSYS_TENEX,
	"its",    &tgsys, TGSYS_ITS,
	"ka",	&tgcpu[TGCPU_KA],  2,	/* 5 choices of CPU */
	"ki",	&tgcpu[TGCPU_KI],  2,
	"ks",	&tgcpu[TGCPU_KS],  2,
	"kl0",	&tgcpu[TGCPU_KL0], 2,
	"klx",	&tgcpu[TGCPU_KLX], 2,
	"fail",  &tgasm, TGASM_FAIL,	/* 3 choices of assembler */
	"macro", &tgasm, TGASM_MACRO,
	"midas", &tgasm, TGASM_MIDAS,
	"ch7",	&tgcsize, 7,		/* Size of chars, in bits */
	NULL,	NULL,	NULL
};

static void
ctargmach(s)
char *s;
{
    register int i;

    parcswi(s, ctgmtab, 0);		/* Don't reset switches; parse */
    tgcpw = TGSIZ_WORD/tgcsize;		/* Ensure right vars set if charsize */
    tgcmask = (1<<tgcsize)-1;		/* was specified. */

    for (i = TGCPU_N; --i >= 0;)	/* See if any CPU types given */
	if (tgcpu[i] == 2) {
	    for (i = TGCPU_N; --i >= 0;)	/* If so, flush defaults */
		if (tgcpu[i] == 1) tgcpu[i] = 0;
	    break;
	}
    setcpu();				/* Set other stuff based on this */
}

/* SETCPU - sets necessary flags and stuff based on CPU/SYS selection
**	Primarily sets "tgmachuse" structure.
*/
static void
setcpu()
{
    if (tgcpu[TGCPU_KLX] == 2)	/* If user said -x=kx, then ensure loading */
	ldextf++;		/* is done as for -i=extend ! */

    tgmachuse.dmovx = !(tgcpu[TGCPU_KA]);	/* All but KA */
    tgmachuse.fixflt = !(tgcpu[TGCPU_KA]);	/* All but KA */
    tgmachuse.adjsp = !(tgcpu[TGCPU_KA] || tgcpu[TGCPU_KI]);
    tgmachuse.adjbp = !(tgcpu[TGCPU_KA] || tgcpu[TGCPU_KI]);
    tgmachuse.dfl_s = (tgcpu[TGCPU_KA]);	/* KA */
    tgmachuse.dfl_h = ! tgmachuse.dfl_s;	/* Use hardware, if no soft */
    tgmachuse.dfl_g = 0;		/* Not implem yet (maybe never) */
    tgmachuse.exadr = tgcpu[TGCPU_KLX];
    tgmachuse.mapch =		/* Map char set if sys source != target and one
				** of the systems is WAITS */
#if SYS_WTS
		(tgsys != TGSYS_WAITS);
#else
		(tgsys == TGSYS_WAITS);
#endif
    /* Map double format if CPU source != target and one of the 
    ** machines is a KA-10.  +1 means map dfl_h to dfl_s; -1 means
    ** the opposite.
    */
    tgmachuse.mapdbl = 
#if CPU_KA
			(tgmachuse.dfl_s ? 0 : -1);
#else
			(tgmachuse.dfl_s ? 1 : 0);
#endif

}

/* CPORTLEV - Set -P portability level switches.
**	Same syntax as for -O and -d.
**	There is no "all".  -P alone resets everything.
*/
struct flagent cplevtab[] = {
	"kcc",	&clevkcc, 1,		/* Enable KCC extensions to C */
	"base",	&clevel, CLEV_BASE,	/* Allow only very portable code */
 	"carm",	&clevel, CLEV_CARM,	/* Allow full CARM implementation */
	"ansi",	&clevel, CLEV_ANSI,	/* Parse CARM+ANSI implementation */
	"stdc",	&clevel, CLEV_STDC,	/* Parse full ANSI implementation */
	NULL,	NULL,	NULL
};

static void
cportlev(s)
char *s;
{
    parcswi(s, cplevtab, 1);	/* Reset switches and parse */
}

/* CVERBOSE - Set -v verboseness switches.
**	Same syntax as for -O etc.
**	-v alone is same as "all".
*/
struct flagent cverbtab[] = {
	"all",	NULL,     0,	/* First element is special */
	"fundef", &vrbfun, 1,		/* Print function names as we go */
	"stats", &vrbsta,  1,		/* Print statistics at end */
	"args", &vrbarg,   1,		/* Print KCC command line args */
 	"load",	&vrbld,    1,		/* Print linking loader commands */
	NULL,	NULL,	NULL
};

static void
cverbose(s)
char *s;
{
    parcswi(s, cverbtab, 1);	/* Reset switches and parse */
}

/* CILOAD - Set -i loading control switches.
**	Same syntax as for -O etc.
**	-i alone is same as "ext".  There is no "all".
*/
struct flagent cildtab[] = {
	"extend", &ldextf,  1,		/* Load into non-zero section (1) */
	"psect", &ldpsectf, 1,		/* Use PSECTs for loading */
	"ddt", &ldddtf, 1,		/* Tell LINK to add DDT (sigh) */
	NULL,	NULL,	NULL
};

static void
ciload(s)
char *s;
{
    parcswi(s, cildtab, 1);	/* Reset switches and parse */
}

/* CFILE(filename) - Compile or otherwise process a file.
**   Return value indicates whether file was assembled:
**	-2 No assembly attempted (may or may not be error).
**	-1 Assembly failed.
**	 0 Assembly deferred, must call runasmlnk() later.
**	+1 Assembled into .REL file.
*/
static int
cfile(arg)
char *arg;
{
    int preflg;			/* Set if asm prefix file produced */
    int mainflg;		/* Set if module contains "main" */
    int asmdflg = -2;		/* Set to result of assembly attempt */
    clock_t startime;

    if (vrbsta)
	startime = clock();	/* Mark cpu time */
    nerrors = 0;
    if (!files(arg))		/* If couldn't open files or file is .REL, */
	return asmdflg;		/* just return. */

    if (!prepf) fprintf(stderr, "KCC:\t%s\n", inpfmodule);

    syminit();			/* Set up symbol tables */
    ppinit();			/* Initialize the input preprocessor */
    ppdefine(npreundef,preundefs, /*  then can do initial -U undefs */
	npredef, predefs);	/*   and initial -D definitions */
    lexinit();			/* Initialize the input lexer */
    initpar();			/* Initialize the input parser */

    if (prepf) {		/* If only preprocessor output (-E) */
	passthru(stdout);	/*   send it through specially */
	fclose(in);		/*   and then close input */
	if (debsym) {
	    symdump(minsym->Snext, "external"); 	/* symbol table dump */
	    typedump();
	    fclose(fsym);
	}
    }
    else {			/* Normal compilation processing */
	NODE *n;
	outinit();		/* Initialize for assembler code output */

#if 0				/* No longer supported */
	entdefs();		/* Special hack: process any "entry" defs. */
#endif
	while (!eof) {		/* Process each external definition */
	    savelits = 0;	/* Reset string literal pool */
	    nodeinit();		/* Reset parse-tree node table */
	    curfn = NULL;	/* Not in any function */

	    n = extdef();	/* Call parser, get one external definition */
	    if (debpar)
		nodedump(n);	/* Output dump of parse tree if debugging */
	    gencode(n);		/* Call code generator on parse tree */
	}
	fclose(in);		/* All done with input stream, close it. */
	curfn = NULL;		/* Not in any function */
	fline = 0;		/* Avoid showing context on errs after this */
	while (n = tntdef()) {	/* Output any remaining tentative defs */
	    if (debpar)
		nodedump(n);
	    gencode(n);
	    nodeinit();		/* Reset parse-tree node table after each */
	}
	if (mainflg = mainsymp())	/* See if "main" defined in module */
	    strcpy(mainname, inpfmodule);	/* Yes, save module name! */
	outdone(mainflg);	/* Output assembler postamble stuff */
	fclose(out);		/* and close assembler output file. */
	if (debsym) {
	    symdump(minsym->Snext, "external"); /* symbol table dump */
	    typedump();
	    fclose(fsym);
	}
	if (debpar) fclose(fdeb);	/* Close parse tree debug file */
	if (debpho) fclose(fpho);	/* Close peephole debug file */
	preflg = makprefile(prefname);	/* Make prefix file for asm if nec */

	if (!nerrors && assemble)
	    asmdflg = asmb(inpfmodule,	/* Assemble into this .REL file, */
		(preflg ? prefname : (char *)NULL),	/* from this */
		outfname);				/* and this. */

	if (delete && asmdflg != 0) {
	    unlink(outfname);		/* delete assembler file */
	    if (preflg) unlink(prefname);	/* both of them */
	}
    }

    if (nerrors)				/* Report errors */
	jmsg("%d error%s detected", nerrors, nerrors==1 ? "" : "s" );
    else if (vrbsta) showcpu(startime); /* or say how much cpu we used */

    return asmdflg;		/* Return assembly result */
}

/* Auxiliary - returns true if main() was defined in this module */
static int
mainsymp()
{
    SYMBOL *s;
    return ((s = symfidstr("main")) && s->Sclass == SC_EXTDEF);
}

/* FILES - parse a filename argument and set up I/O streams.
**
**	Note that "prefname" is set up here, but not opened.
** This is because we may not need to use it; the call to
** "makprefile()" will do so if necessary.
*/
static int
files(fname)
char *fname;
{
    extern char *fnparse();	/* All from CCASMB */
    extern int fnxisrel();
    extern int fnmarkin();
    int cextf;
    char *cp;
    char cname[FNAMESIZE];	/* Name of .C source file */
    char rname[FNAMESIZE];	/* Name of .REL binary file */
    char ext[FNAMESIZE];		/* Temp to hold parsed extension */

    /*
    ** Parse filename into its various pieces, mainly to get module name.
    ** As a special case, it will work to specify a device (logical) name
    ** with no filename, e.g. you can say
    **        @CC FOO:
    ** where FOO: => <DIR>NAME.C, and the module name will be FOO.
    */
    if (cp = fnparse(fname, inpfdir, inpfmodule, ext, inpfsuf)) {
	jerr("Bad filename arg (%s): \"%s\"", cp, fname);	/* Ugh */
	return 0;			/* and don't try to compile */
    }
    /* Check for .REL extension and avoid compiling if so */
    if (fnxisrel(ext))
	return 0;

    /* Check for .C extension.  "cextf" is set if we have it. */
    cextf = (ext[0] == '.'
		&& toupper(ext[1]) == 'C'
		&& !ext[2]);

    /* Now compose source filename with ".C" appended if necessary */
    if (cextf) strcpy(cname, fname);	/* Found .C, just copy filename */
    else {
	estrcpy(estrcpy(estrcpy(estrcpy(cname,	/* Rebuild filename */
		inpfdir), inpfmodule), ".c"), inpfsuf);
    }
#if SYS_T20+SYS_10X+SYS_ITS	/* Only TOPS-10 systems need to retain */
    inpfsuf[0] = '\0';		/* input suffix; all others must flush it. */ 
#endif

    /* If no ".C" was specified, and the -q conditional compile flag was
    ** set, we assume that we are to check the .C and .REL extensions of
    ** this file to determine whether compilation is necessary.
    */
    if (!cextf && condccf) {
	strcpy(rname, inpfmodule);		/* Make the .REL filename */
	strcat(rname, ".rel");
	if (!needcomp(cname, rname))
	    return 0;		/* Doesn't need to be compiled! */
    }

    /*
    ** Now that we've figured out what the name of the file is, we can try
    ** to open it.  First we try the filename as given, and if that doesn't
    ** work (most likely because no .C was specified) then we try the
    ** one we constructed by adding .C.
    */
    strcpy(inpfname, fname);		/* Try filename as given */
    in = fopen(inpfname, "r");
    if (in == NULL) {
	strcpy(inpfname, cname);	/* then constructed filename */
	in = fopen(inpfname, "r");
	if (in == NULL) {
	    errfopen("input", inpfname);
	    return 0;
	}
    }
    fnmarkin(in, inpfname);		/* Let CCASMB mark new input file */

    /* Compose symbol table dump output filename, if desired */
    if (debsym) {
	strcpy(symfname, inpfmodule);
	strcat(symfname, ".cym");
	if ((fsym = fopen(symfname, "w")) == NULL) {
	    errfopen("symbol table", symfname);
	    return 0;
	}
    }

    /* If we are only doing pre-processing, then no other filenames are
    ** needed, and we can return now.
    */
    if (prepf) return 1;

    /*
    ** The output file is merely ".FAI" etc concatenated to the stripped
    ** filename we calculated above, in the current directory.
    */
    cp = (tgasm==TGASM_FAIL  ? ".fai" :		/* Get right extension */
	(tgasm==TGASM_MACRO ? ".mac" :
	(tgasm==TGASM_MIDAS ? ".mid" : "")));

    strcat(strcpy(outfname, inpfmodule), cp);	/* Compose output filename */
    if ((out = fopen(outfname, "w")) == NULL) {
	errfopen("output", outfname);
	return 0;
    }

    /* Compose assembler predefinition filename for later */
    strcat(strcpy(prefname, inpfmodule), ".pre");

    /* Now open various other debugging output files */

    if (debpar) {		/* debugging output goes here */
	strcpy(debfname, inpfmodule);
	strcat(debfname, ".deb");
	if ((fdeb = fopen(debfname, "w")) == NULL) {
	    errfopen("parser debugging output", debfname);
	    return 0;
	}
    }

    if (debpho) {		/* Peephole debugging output goes here */
	strcpy(phofname, inpfmodule);
	strcat(phofname, ".pho");
	if ((fpho = fopen(phofname, "w")) == NULL) {
	    errfopen("peephole debugging output", phofname);
	    return 0;
	}
    }

    return 1;
}

/* NEEDCOMP - Auxiliary for above.
**	Takes source and binary filenames, returns TRUE if
**	source needs compiling (is newer than binary).
*/
#include <sys/types.h>
#include <sys/stat.h>
static int
needcomp(src, rel)
char *src, *rel;	/* source and binary filenames */
{
    struct stat sbuf, rbuf;
    if (stat(src, &sbuf) < 0)
	return 1;			/* No source?? Try compiling anyway */
    if (stat(rel, &rbuf) < 0)
	return 1;			/* No .REL, so must compile */
    return (sbuf.st_mtime > rbuf.st_mtime);	/* Compare last mod times */
}

/* ----------------------------------- */
/*      show how much cpu we used      */
/* ----------------------------------- */
static void
showcpu(otim)
clock_t otim;		/* previous val of clock() */
{
    float secs;

    secs = (float)(clock() - otim) / CLOCKS_PER_SEC;	/* Find # secs used */
    fprintf(stderr,"Processed %d lines in %.2f seconds (%d lines/min)\n",
		    tline, secs, (int)((tline*60)/secs));
}

/* Target Machine routines.  Eventually this page may become a separate file
** called CCTARG.
*/

/* TGMAPCH - Map input char to target machine char set
**	Called by CCLEX for char and string constants.
*/
int
tgmapch(c)
{
#if SYS_WTS	/* Running on WAITS */
    if (tgsys != TGSYS_WAITS) {	/* Convert from WAITS ASCII to USASCII */
	switch (c) {
	case '\b': return '\010';	/* BS is 0177 on WAITS */
	case '}': return '\175';
	case '~': return '\176';
	}
    }
#else	/* Running on anything but WAITS */
    if (tgsys == TGSYS_WAITS) {	/* Convert from USASCII to WAITS ASCII */
	switch (c) {
	case '\b': return '\177';	/* BS is 0177 on WAITS */
	case '}': return '\176';	/* } is ~ */
	case '~': return '\032';	/* ~ is ^Z (ctrl-Z) */
	}
    }
#endif
    return c;
}
