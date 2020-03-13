/*
 *	Control of the implicit suffix rules
 */

#include "h.h"

/*
 * Built-in macro, rule, and suffix tables.  All built-in macro names are
 * entirely in UPPER-CASE.  For readability, please preserve alphabetical
 * order in each table.
 */

#ifdef EON
static MACRO defmacros[] =
{
	{NULL_MACROP,	"AS",		"zas",		'\0'},
	{NULL_MACROP,	"BDSCC",	"asm",		'\0'},
	{NULL_MACROP,	"CC",		"c",		'\0'},
	{NULL_MACROP,	"CFLAGS",	"-O",		'\0'},
	{NULL_MACROP,	"M80",		"asm -n",	'\0'},
};

static RULE defrules[] =
{
	{".as.obj",			"$(ZAS) $(AFLAGS) -o $@ $<"},
	{".c.o",			"$(BDSCC) $(BDSCFLAGS) -n $<"},
	{".c.obj",			"$(CC) $(CFLAGS) -c $<"},
	{".mac.o",			"$(M80) $(M80FLAGS) $<"},
};

static char * defsuffix = ".SUFFIXES: .as .obj .c .o .mac";
#endif


#ifdef KCC_20
static MACRO defmacros[] =
{
	{NULL_MACROP,	"AMSTEX",	"AMSTeX",	'\0'},
	{NULL_MACROP,	"AMSTEXFLAGS",	"\\batchmode",	'\0'},
	{NULL_MACROP,	"AS",		"compile",	'\0'},
	{NULL_MACROP,	"AFLAGS",	"",		'\0'},
	{NULL_MACROP,	"CC",		"kcc",		'\0'},
	{NULL_MACROP,	"CFLAGS",	"",		'\0'},
	{NULL_MACROP,	"FC",		"compile",	'\0'},
	{NULL_MACROP,	"FFLAGS",	"/debug:(argument,label)",	'\0'},
	{NULL_MACROP,	"LATEX",	"LaTeX",	'\0'},
	{NULL_MACROP,	"LATEXFLAGS",	"\\batchmode",	'\0'},
	{NULL_MACROP,	"MV",		"rename",	'\0'},
	{NULL_MACROP,	"PC",		"compile",	'\0'},
	{NULL_MACROP,	"PFLAGS",	"",		'\0'},
	{NULL_MACROP,	"RM",		"delete",	'\0'},
	{NULL_MACROP,	"SF3",		"sf3",		'\0'},
	{NULL_MACROP,	"SLITEX",	"SliTeX",	'\0'},
	{NULL_MACROP,	"SLITEXFLAGS",	"\\batchmode",	'\0'},
	{NULL_MACROP,	"TEX",		"TeX",		'\0'},
	{NULL_MACROP,	"TEXFLAGS",	"\\batchmode",	'\0'},
	{NULL_MACROP,	"YACC",		"yacc",		'\0'},
};

static RULE defrules[] =
{
	{".atx.dvi .amstex.dvi",	"$(AMSTEX) $(AMSTEXFLAGS) \\input $<"},
	{".c.rel",			"$(CC) $(CFLAGS) -c $<"},
	{".fai.rel .mac.rel .mid.rel",	"$(AS) $(AFLAGS) $<"},
	{".for.rel .f.rel",		"$(FC) /fortran/language:\"$(FFLAGS)\" $<"},
	{".ltx.dvi .latex.dvi",		"$(LATEX) $(LATEXFLAGS) \\input $<"},
	{".pas.rel .p.rel",		"$(PC) /pascal/language:\"$(PFLAGS)\" $<"},
	{".sf3.for",			"$(SF3) $(SF3FLAGS) $<"},
	{".stx.dvi .slitex.dvi",	"$(SLITEX) $(SLITEXFLAGS) \\input $<"},
	{".tex.dvi",			"$(TEX) $(TEXFLAGS) \\input $<"},
	{".y.c",			"$(YACC) $(YFLAGS) $<\n\
$(MV) ytab.c $@"},
	{".y.rel",			"$(YACC) $(YFLAGS) $<\n\
$(CC) $(CFLAGS) -c ytab.c\n\
$(RM) ytab.c\n\
$(MV) ytab.rel $@"},
};

static char * defsuffix = ".SUFFIXES: .exe .rel .dvi .c .y .l .mac .fai .mid .sf3 \
.for .f .pas .p .tex .latex .ltx .slitex .stx .amstex .atx .inc .h";
#endif

#ifdef MSC
static MACRO defmacros[] =
{
	{NULL_MACROP,	"AMSTEX",	"AMSTeX",	'\0'},
	{NULL_MACROP,	"AMSTEXFLAGS",	"\\batchmode",	'\0'},
	{NULL_MACROP,	"AS",		"masm",		'\0'},
	{NULL_MACROP,	"CC",		"msc",		'\0'},
	{NULL_MACROP,	"CFLAGS",	"",		'\0'},
	{NULL_MACROP,	"LATEX",	"LaTeX",	'\0'},
	{NULL_MACROP,	"LATEXFLAGS",	"\\batchmode",	'\0'},
	{NULL_MACROP,	"MV",		"rename",	'\0'},
	{NULL_MACROP,	"RM",		"delete",	'\0'},
	{NULL_MACROP,	"SLITEX",	"SliTeX",	'\0'},
	{NULL_MACROP,	"SLITEXFLAGS",	"\\batchmode",	'\0'},
	{NULL_MACROP,	"TEX",		"TeX",		'\0'},
	{NULL_MACROP,	"TEXFLAGS",	"\\batchmode",	'\0'},
	{NULL_MACROP,	"YACC",		"yacc",		'\0'},
};

static RULE defrules[] =
{
	{".asm.obj",			"$(AS) $(AFLAGS) $*;"},
	{".atx.dvi",			"$(AMSTEX) $(AMSTEXFLAGS) \\input $<"},
	{".c.obj",			"$(CC) $* $(CFLAGS);"},
	{".ltx.dvi",			"$(LATEX) $(LATEXFLAGS) \\input $<"},
	{".stx.dvi",			"$(SLITEX) $(SLITEXFLAGS) \\input $<"},
	{".tex.dvi",			"$(TEX) $(TEXFLAGS) \\input $<"},
	{".y.c",			"$(YACC) $(YFLAGS) $<\n\
mv ytab.c $@"},
	{".y.obj",			"$(YACC) $(YFLAGS) $<\n\
$(CC) $(CFLAGS) -c ytab.c\n\
rm ytab.c\n\
mv ytab.obj $@"},
};

static char * defsuffix = ".SUFFIXES: .obj .dvi .c .y .l .asm .for .f .sf3 \
.pas .p .tex .ltx .slitex .stx .atx .inc .h";
#endif

#ifdef OS9
static MACRO defmacros[] =
{
	{NULL_MACROP,	"CC",		"cc",		'\0'},
	{NULL_MACROP,	"CFLAGS",	"-z",		'\0'},
};

static RULE defrules[] =
{
	{".c.r.ca.r.a.r.o.r.mc.r.mca.r.ma.r.mo.r",	"$(CC) $(CFLAGS) -r $<"},
};

static char * defsuffix = ".SUFFIXES: .r .mc .mca .c .ca .ma .mo .o .a";
#endif

#ifdef UNIX
static MACRO defmacros[] =
{
	{NULL_MACROP,	"AS",		"as",		'\0'},
	{NULL_MACROP,	"CC",		"cc",		'\0'},
	{NULL_MACROP,	"CFLAGS",	"-O",		'\0'},
	{NULL_MACROP,	"YACC",		"yacc",		'\0'},
};

static RULE defrules[] =
{
	{".c.o",			"$(CC) $(CFLAGS) -c $<"},
	{".s.o",			"$(AS) $(AFLAGS) -o $@ $<"},
	{".y.c",			"$(YACC) $(YFLAGS) $<\n\
mv y.tab.c $@"},
	{".y.o",			"$(YACC) $(YFLAGS) $<\n\
$(CC) $(CFLAGS) -c y.tab.c\n\
rm y.tab.c\n\
mv y.tab.o $@"},
};
static char * defsuffix = ".SUFFIXES: .o .c .p .e .r .f .y .l .s";
#endif

#ifdef VMS
static MACRO defmacros[] =
{
	{NULL_MACROP,	"AMSTEX",	"AMSTeX",	'\0'},
	{NULL_MACROP,	"AMSTEXFLAGS",	"/batch",	'\0'},
	{NULL_MACROP,	"AS",		"macro",	'\0'},
	{NULL_MACROP,	"CC",		"cc",		'\0'},
	{NULL_MACROP,	"CFLAGS",	"/debug=(symbols,traceback)/nolist",	'\0'},
	{NULL_MACROP,	"FC",		"fortran",	'\0'},
	{NULL_MACROP,	"FFLAGS",	"/debug=(symbols,traceback)/nolist",	'\0'},
	{NULL_MACROP,	"LATEX",	"LaTeX",	'\0'},
	{NULL_MACROP,	"LATEXFLAGS",	"/batch",	'\0'},
	{NULL_MACROP,	"MV",		"rename",	'\0'},
	{NULL_MACROP,	"PC",		"pascal",	'\0'},
	{NULL_MACROP,	"PFLAGS",	"/debug=(symbols,traceback)/nolist",	'\0'},
	{NULL_MACROP,	"RM",		"delete",	'\0'},
	{NULL_MACROP,	"SF3",		"sf3",		'\0'},
	{NULL_MACROP,	"SLITEX",	"SliTeX",	'\0'},
	{NULL_MACROP,	"SLITEXFLAGS",	"/batch",	'\0'},
	{NULL_MACROP,	"TEX",		"TeX",		'\0'},
	{NULL_MACROP,	"TEXFLAGS",	"/batch",	'\0'},
	{NULL_MACROP,	"YACC",		"yacc",		'\0'},
};

static RULE defrules[] =
{
	{".atx.dvi .amstex.dvi",	"$(AMSTEX) $(AMSTEXFLAGS) $<"},
	{".c.obj",			"$(CC) $(CFLAGS) $<"},
	{".for.obj .f.obj .ftn.obj",	"$(FC) $(FFLAGS) $<"},
	{".ltx.dvi .latex.dvi",		"$(LATEX) $(LATEXFLAGS) $<"},
	{".mar.obj",			"$(AS) $(AFLAGS) $<"},
	{".pas.obj .p.obj",		"$(PC) $(PFLAGS) $<"},
	{".sf3.for",			"$(SF3) $(SF3FLAGS) $<"},
	{".stx.dvi .slitex.dvi",	"$(SLITEX) $(SLITEXFLAGS) $<"},
	{".tex.dvi",			"$(TEX) $(TEXFLAGS) $<"},
	{".y.c",			"$(YACC) $(YFLAGS) $<\n\
$(MV) ytab.c $@"},
	{".y.obj",			"$(YACC) $(YFLAGS) $<\n\
$(CC) $(CFLAGS) ytab.c\n\
$(RM) ytab.c\n\
$(MV) ytab.obj $@"},
};

static char * defsuffix = ".SUFFIXES: .exe .obj .dvi .c .y .l .mar .sf3 \
.for .f .ftn .pas .p .tex .latex .ltx .slitex .stx .amstex .atx .inc .h";
#endif

#define MAXMACROS (sizeof(defmacros)/sizeof(MACRO))

#define MAXRULES (sizeof(defrules)/sizeof(RULE))

/*
 *	Return a pointer to the suffix of a name
 */
char *
suffix(name)
char *name;
{
    return rindex(name, '.');
}


/*
 *	Dynamic dependency.  This routine applies the suffix rules
 *	to try and find a source and a set of rules for a missing
 *	target.  If found, np is made into a target with the implicit
 *	source name, and rules.  Returns TRUE if np was made into
 *	a target.
 */
bool
dyndep(np)
NAMEP np;
{
    register char *p;
    register char *q;
    register char *suff;	/* Old suffix  */
    register char *basename;	/* Name without suffix  */
    NAMEP op;			/* New dependent  */
    NAMEP sp;			/* Suffix  */
    LINEP lp;
    DEPENDP dp;
    char *newsfx;


    p = str1;
    q = np->n_name;

    if (debug)
	fprintf(stderr, "%cDEPENDENCY[%s]\n", TAB, q);

    if (!(suff = suffix(q)))
	return FALSE;		/* No suffix */

    while (q < suff)
	*p++ = *q++;

    *p = '\0';
    basename = setmacro("*", str1, TEMPORARY)->m_val;

    if (debug)
	fprintf(stderr, "%c%cBASENAME[%s]\n", TAB, TAB, basename);

    if (!((sp = newname(".SUFFIXES"))->n_flag & N_TARG))
	return FALSE;

    for (lp = sp->n_line; lp; lp = lp->l_next)
	for (dp = lp->l_dep; dp; dp = dp->d_next)
	{
	    newsfx = dp->d_name->n_name;
	    if (strlen(suff) + strlen(newsfx) + 1 >= MAXSTRING)
		fatal("Suffix rule too long");
	    p = str1;
	    q = newsfx;
	    while (*p++ = *q++)
		;
	    p--;
	    q = suff;
	    while (*p++ = *q++)
		;
	    sp = newname(str1);
	    if (sp->n_flag & N_TARG)
	    {
		p = str1;
		q = basename;
		if (strlen(basename) + strlen(newsfx) + 1 >= MAXSTRING)
		    fatal("Implicit name too long");
		while (*p++ = *q++)
		    ;
		p--;
		q = newsfx;
		while (*p++ = *q++)
		    ;
		op = newname(str1);
		if (!op->n_time)
		    modtime(op);
		if (op->n_time)
		{
		    dp = newdep(op, NULL_DEPENDP);
		    newline(np, dp, sp->n_line->l_cmd, FALSE);
		    (void) setmacro("<", op->n_name, TEMPORARY);
		    return TRUE;
		}
	    }
	}
    return FALSE;
}


/*
 *	Make the default rules
 */
void
makerules()
{
    CMDP cp;
    int k;
    NAMEP np;
    char *s;
    char *t;
    char *p;
    char *q;

    for (k = 0; k < MAXMACROS; ++k)	/* install built-in macros */
	(void) setmacro(defmacros[k].m_name, defmacros[k].m_val, TEMPORARY);

    for (k = 0; k < MAXRULES; ++k)	/* install built-in rules */
    {
	/* Make command line list */
	cp = NULL_CMDP;
	p = defrules[k].r_command;
	while (q = index(p, '\n'))
	{
	    *q = '\0';		/* make line a string */
	    cp = newcmd(p, cp);
	    *q = '\n';		/* restore string to line */
	    p = q + 1;
	}
	cp = newcmd(p, cp);

	/* Install each target name and attach command line list to it */
	strcpy(str1, defrules[k].r_target);
	str1[strlen(str1) + 1] = '\0';	/* extra NUL for gettok() */
	for (s = str1; (t = gettok(&s)) != NULL_CHARP; /* NO-OP */ )
	{
	    np = newname(t);
	    newline(np, NULL_DEPENDP, cp, FALSE);
	}
    }

    newsuffix(defsuffix);
}

/*
 * Convert a string of the form ".SUFFIXES: .sfx .sfx ... .sfx" to a
 * dependency list, easing coding above.  Suffixes are separated by any
 * amount of white space.
 */

void
newsuffix(s)
char *s;			/* ".SUFFIXES: ..." */
{
    register char *p;		/* temporary pointer into str1[] */
    char *q;			/* temporary pointer into str1[] */
    register NAMEP np;
    register DEPENDP dp;

    if (strncmp(s, ".SUFFIXES:", 10) != 0)
    {
	sprintf(str1, "Internal error: invalid .SUFFIXES string `%s'", s);
	fatal(str1);
    }


    strcpy(str1, s);		/* copy s[] into str1[]--gettok modifies it */
    str1[strlen(str1) + 1] = '\0';	/* extra NUL for gettok() */

    dp = NULL_DEPENDP;

    q = index(str1, ':');	/* point past ".SUFFIXES" */
    *q++ = '\0';		/* and clobber colon */

    for ( /* NO-OP */ ; (p = gettok(&q)) != NULL_CHARP; /* NO-OP */ )
    {				/* loop collecting tokens */
	np = newname(p);
	dp = newdep(np, dp);
    }
    np = newname(str1);		/* this is ".SUFFIXES" */
    newline(np, dp, NULL_CMDP, FALSE);
}
