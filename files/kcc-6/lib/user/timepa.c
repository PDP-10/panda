/*
** TIME_PARSE		parse date/time string into a TMX structure
**
** 	Copyright (c) 1980, 1987 by Ken Harrenstien, SRI International.
**
**	This code is quasi-public; it may be used freely in like software.
**	It is not to be sold, nor used in licensed software without
**	permission of the author.
**	For everyone's benefit, please report bugs and improvements!
**	(Internet: <KLH@SRI-NIC.ARPA>)
**
** Usage:
**	#include <timex.h>
**	int time_parse(const char *str, struct tmx *tp, char **endptr);
**
**	Time values are stored in specified TMX structure (unspecified values
**	are all set to TMX_NULL).  The tmx_err member will be set to NULL
**	or will point to a constant error message string.
**	If endptr is not NULL, it will be used to return an updated string ptr.
**
** Return value:
**	< 0	Clash error or ambiguous keyword.
**		Err msg, *endptr points to start of bad token.
**
**	>= 0	OK up to a point.  Value is # of valid tokens read.
**		Note that 0 means nothing was set.  There are several
**		possibilities:
**	OK up to EOF	= no err msg, *endptr points to terminating null char.
**	OK up to break char = err msg, *endptr points to (non-alpha) char.
**	OK up to unknown keyword = err msg, *endptr points to start of token;
**			note that isalpha(**endptr) will be true!
*/

#include <stdio.h>
#include <ctype.h>
#include <timex.h>

/* Internal functions */
static char *ptfixup();
static int ptstash();
static int pttoken(), ptpeektok(),
	ptitoken(), ptmatchstr(), ptscntok(), ptbrkc();

#define MAXTOKEN 20	/* Max # chars in a token */
struct token {
	char *tcp;	/* pointer to string */
	int tcnt;	/* # chars in token */
	char tbrk;	/* "break" char */
	char tbrkl;	/* last break char */
	char tflg;	/* 0 = alpha, 1 = numeric */
	long tlong;	/* value if numeric */
	int tnum;	/* value cast to (int), for efficiency */
	struct tmwent *ttmw;	/* ptr to a tmwent, if alpha */
	char tbuf[MAXTOKEN+1];	/* Lowercase copy of alpha token */
};

struct tmwent {		/* Time-Word Entry */
	char *went;	/* word string */
	int wval;	/* word value */
	int wtype;	/* word type (and flags) */
};
	/* Word types */
#define TW_MASK 07	/* Mask for type */
#define TW_NOISE 0	/* Noise word, ignore */
#define TW_MON 1
#define TW_WDAY 2
#define TW_ZON 3
#define TW_AMPM 4
#define TW_1200 5	/* Word is NOON or MIDNIGHT (sigh) */

	/* Flags */
#define TWF_TIM 020	/* Word is a time value (absence implies date) */
#define TWF_DST  040	/* Word is a DST-type timezone */


static struct tmwent tmwords [] = {
	{"january",      0, TW_MON},
	{"february",     1, TW_MON},
	{"march",        2, TW_MON},
	{"april",        3, TW_MON},
	{"may",          4, TW_MON},
	{"june",         5, TW_MON},
	{"july",         6, TW_MON},
	{"august",       7, TW_MON},
	{"september",    8, TW_MON},
	{"october",      9, TW_MON},
	{"november",     10, TW_MON},
	{"december",     11, TW_MON},

	{"sunday",       0, TW_WDAY},
	{"monday",       1, TW_WDAY},
	{"tuesday",      2, TW_WDAY},
	{"wednesday",    3, TW_WDAY},
	{"thursday",     4, TW_WDAY},
	{"friday",       5, TW_WDAY},
	{"saturday",     6, TW_WDAY},

	{"ut",	0*60, TWF_TIM|TW_ZON},   /* Universal Time */
	{"gmt",	0*60, TWF_TIM|TW_ZON},   /* Greenwich Mean Time */
	{"gst",	0*60, TWF_TIM|TW_ZON},
	{"gdt",	0*60, TWF_TIM+TWF_DST|TW_ZON},     /* ?? */

	{"ast",	4*60, TWF_TIM|TW_ZON},   /* Atlantic */
	{"est",	5*60, TWF_TIM|TW_ZON},   /* Eastern */
	{"cst",	6*60, TWF_TIM|TW_ZON},   /* Central */
	{"mst",	7*60, TWF_TIM|TW_ZON},   /* Mountain */
	{"pst",	8*60, TWF_TIM|TW_ZON},   /* Pacific */
	{"yst",	9*60, TWF_TIM|TW_ZON},   /* Yukon */
	{"hst",	10*60, TWF_TIM|TW_ZON},  /* Hawaii */
	{"bst",	11*60, TWF_TIM|TW_ZON},  /* Bering */

	{"adt",	4*60, TWF_TIM+TWF_DST|TW_ZON},     /* Atlantic */
	{"edt",	5*60, TWF_TIM+TWF_DST|TW_ZON},     /* Eastern */
	{"cdt",	6*60, TWF_TIM+TWF_DST|TW_ZON},     /* Central */
	{"mdt",	7*60, TWF_TIM+TWF_DST|TW_ZON},     /* Mountain */
	{"pdt",	8*60, TWF_TIM+TWF_DST|TW_ZON},     /* Pacific */
	{"ydt",	9*60, TWF_TIM+TWF_DST|TW_ZON},     /* Yukon */
	{"hdt",	10*60, TWF_TIM+TWF_DST|TW_ZON},    /* Hawaii */
	{"bdt",	11*60, TWF_TIM+TWF_DST|TW_ZON},    /* Bering */

	{"standard",	1, TWF_TIM|TW_ZON},      /* Local Standard */
	{"std",		1, TWF_TIM|TW_ZON},      /*    "      "    */
	{"daylight",	1, TWF_TIM+TWF_DST|TW_ZON}, /* "  Daylight */

	{"am",		1, TWF_TIM|TW_AMPM},	/* Special frobs */
	{"pm",		2, TWF_TIM|TW_AMPM},
	{"noon",	12,TWF_TIM|TW_1200},
	{"midnight",	0, TWF_TIM|TW_1200},
	{"at",		0, TW_NOISE},		/* Noise word */

#if 0 /* Military timezone designations; single letters */
	{"z",	0*60, TWF_TIM|TW_ZON},	/* Z = UT */
	{"a",	1*60, TWF_TIM|TW_ZON},	/* A = UT-0100 */
	{"b",	2*60, TWF_TIM|TW_ZON},	/*   etc   */
	{"c",	3*60, TWF_TIM|TW_ZON},
	{"d",	4*60, TWF_TIM|TW_ZON},
	{"e",	5*60, TWF_TIM|TW_ZON},
	{"f",	6*60, TWF_TIM|TW_ZON},
	{"g",	7*60, TWF_TIM|TW_ZON},
	{"h",	8*60, TWF_TIM|TW_ZON},
	{"i",	9*60, TWF_TIM|TW_ZON},	/* note: 'J' not used */
	{"k",	10*60, TWF_TIM|TW_ZON},
	{"l",	11*60, TWF_TIM|TW_ZON},
	{"m",	12*60, TWF_TIM|TW_ZON},
	{"n",	-1*60, TWF_TIM|TW_ZON},
	{"o",	-2*60, TWF_TIM|TW_ZON},
	{"p",	-3*60, TWF_TIM|TW_ZON},
	{"q",	-4*60, TWF_TIM|TW_ZON},
	{"r",	-5*60, TWF_TIM|TW_ZON},
	{"s",	-6*60, TWF_TIM|TW_ZON},
	{"t",	-7*60, TWF_TIM|TW_ZON},
	{"u",	-8*60, TWF_TIM|TW_ZON},
	{"v",	-9*60, TWF_TIM|TW_ZON},
	{"w",	-10*60, TWF_TIM|TW_ZON},
	{"x",	-11*60, TWF_TIM|TW_ZON},
	{"y",	-12*60, TWF_TIM|TW_ZON},
#endif
	{0, 0, 0},             /* Zero entry to terminate searches */
};

static struct tmz inittmz = { TMX_NULL, TMX_NULL, TMX_NULL };
#define TERR(str) { err = str; goto edone; }

int
time_parse(astr, tp, endptr)
const char *astr;
register struct tmx *tp;
char **endptr;
{
    register struct tmwent *twp;
    register int i;
    struct token tok, xtok;
    char *cp;
    int ch, ord;
    int ntoks = 0;
    char *err = 0;
    int midnoon = TMX_NULL, ampm = TMX_NULL;

    /* Initialize the TM structure.  Can't do it cleverly because
    ** we don't know what the implementation's TM struct looks like.  Barf.
    */
    tp->tm.tm_sec  = TMX_NULL;
    tp->tm.tm_min  = TMX_NULL;
    tp->tm.tm_hour = TMX_NULL;
    tp->tm.tm_mday = TMX_NULL;
    tp->tm.tm_mon  = TMX_NULL;
    tp->tm.tm_year = TMX_NULL;
    tp->tm.tm_wday = TMX_NULL;
    tp->tm.tm_yday = TMX_NULL;
    tp->tm.tm_isdst = TMX_NULL;
    tp->tmz = inittmz;		/* Can do TMZ part semi-cleverly anyway */

    if (astr == 0) {		/* Check for initialize-only invocation */
	tp->tmx_err = 0;
	if (endptr) *endptr = 0;
	return 0;
    }
    tok.tcp = astr;		/* Initialize token input */
    tok.tcnt = tok.tbrkl = 0;

    /* MAIN TOKEN PROCESSING LOOP */
    while (pttoken(&tok)) {	/* Get next token */
	ntoks++;
	if (tok.tflg == 0) {		/* Alpha? */
	    /* Handle general alpha token */
	    twp = tok.ttmw;		/* Get ptr to entry */
	    i = twp->wval;		/* And value */
	    switch (twp->wtype&TW_MASK) {
		case TW_NOISE:		/* If noise word, */
		    break;		/* just ignore it. */
		case TW_MON:
		    if (ptstash(&tp->tm.tm_mon, i))
			TERR("mon clash")
		    break;
		case TW_WDAY:
		    if (ptstash(&tp->tm.tm_wday, i))
			TERR("wday clash")
		    break;
		case TW_ZON:
		    if (ptstash(&tp->tmz.tmz_minwest, i))
			TERR("zone clash")
		    if (ptstash(&tp->tm.tm_isdst, (twp->wtype&TWF_DST)?1:0))
			TERR("DST clash")
#if 0		    /* Special check for "GMT+hh:mm" */
		    if (i == 0 &&
			(tok.tbrk == '+' || tok.tbrk == '-')) {
			
		    }
#endif
		    break;
		case TW_AMPM:
		    if (ptstash(&ampm, i))
			TERR("am/pm clash")
		    break;
		case TW_1200:
		    if (ptstash(&midnoon, i))
			TERR("noon/midnight clash")
		    break;
		default:
			TERR("bad keyword")
	    }
	    continue;		/* Process next token */
	}

	/* Token is number.  LOTS of hairy heuristics. */
	if (tok.tcnt > 6)	/* 7 or more digits in string? (barf!) */
	    TERR("number too big")
	if (tok.tcnt == 6) {	/* 6 digits = HHMMSS.  Needs special crock */
				/* since 6 are too big for 16-bit integer! */
	    if (ptstash(&tp->tm.tm_hour, (int)(tok.tlong/10000)))
		TERR("hour clash")
	    tok.tnum = tok.tlong % 10000;
	    goto coltm4;
	}

	i = tok.tnum;	/* Value now known to be valid; get it. */
	if (tok.tcnt == 5		/*  5 digits = HMMSS */
	 || tok.tcnt == 3) {		/*  3 digits = HMM   */
	    if (tok.tcnt != 3) {
		if (ptstash(&tp->tm.tm_sec, i%100))
		    TERR("sec clash")
		i /= 100;
	    }
hhmm4:	    if (ptstash(&tp->tm.tm_min, i%100))
		TERR("min clash")
	    i /= 100;
hh2:	    if (ptstash(&tp->tm.tm_hour, i))
		TERR("hour clash")
	    continue;			/* Continue normal loop */
	}

	if (tok.tcnt == 4) {	/* 4 digits = YEAR or HHMM */
	    if (tp->tm.tm_year != TMX_NULL) goto hhmm4;	/* Already got yr? */
	    if (tp->tm.tm_hour != TMX_NULL) goto year4;	/* Already got hr? */
	    if ((i%100) > 59) goto year4;		/* MM >= 60? */
	    if (tok.tbrk == ':')			/* HHMM:SS ? */
		if (ptstash(&tp->tm.tm_hour, i/100)
		 || ptstash(&tp->tm.tm_min,  i%100))
		    TERR("hr/min clash")
		else goto coltm2;		/* Go handle SS */
	    if ( tok.tbrk != ','
	      && tok.tbrk != '/'
	      && ptpeektok(&tok, &xtok)		/* Peek into xtok */
	      && xtok.tflg == 0			/* alpha */
	      && (xtok.ttmw->wtype&TWF_TIM))	/* HHMM-ZON */
		goto hhmm4;
	    if ( tok.tbrkl == '-'	/* DD-Mon-YYYY */
	      || tok.tbrkl == ','	/* Mon DD, YYYY */
	      || tok.tbrkl == '/'	/* MM/DD/YYYY */
	      || tok.tbrkl == '.'	/* DD.MM.YYYY */
	      || tok.tbrk == '-'	/* YYYY-MM-DD */
		) goto year4;
	    goto hhmm4;			/* Give up, assume HHMM. */
	}

	/* From this point on, assume tcnt == 1 or 2 */
	/* 2 digits = YY, MM, DD, or HH (MM and SS caught at coltime) */
	if (tok.tbrk == ':')		/* HH:MM[:SS] */
	    goto coltime;		/*  must be part of time. */
	if (i > 31) goto yy2;		/* If >= 32, only YY poss. */

	/* Check for numerical-format date.  Very messy. */
	for (cp = "/-."; ch = *cp++;) {
	    ord = (ch == '.' ? 0 : 1);	/* n/m = D/M or M/D */
	    if (tok.tbrk == ch) {		/* "NN-" */
		if (tok.tbrkl != ch) {
		    if (ptpeektok(&tok, &xtok)
		      && xtok.tflg == 0
		      && xtok.ttmw->wtype == TW_MON)
			goto dd2;
		    if(ord) goto mm2; else goto dd2;	/* "NN-" */
		}					/* "-NN-" */
		if ( tp->tm.tm_mday == TMX_NULL
		  && tp->tm.tm_year != TMX_NULL)	/* If "YY-NN-" */
		    goto mm2;		/* then always MM */
		if (ord) goto dd2;
		goto mm2;
	    }
	    if (tok.tbrkl == ch			/* "-NN" */
	      && (ord ? tp->tm.tm_mon : tp->tm.tm_mday) != TMX_NULL) {
		if ((ord ? tp->tm.tm_mday
			 : tp->tm.tm_mon) == TMX_NULL)	/* MM/DD */
		    if (ord) goto dd2; else goto mm2;
		goto yy2;				/* "-YY" */
	    }
	} /* End of messy for() loop */


	/* At this point only YY, DD, and HH are left.
	 * YY is very unlikely since value is <= 32 and there was
	 * no numerical format date.  Make one last try at YY
	 * before dropping through to DD vs HH code.
	 */
	if (tok.tcnt == 2		/* If 2 digits */
	  && tp->tm.tm_hour != TMX_NULL		/* and already have hour */
	  && tp->tm.tm_mday != TMX_NULL		/* and day, but  */
	  && tp->tm.tm_year == TMX_NULL)	/* no year, then assume */
	    goto yy2;				/* that's what we have. */

	/* Now reduced to choice between HH and DD */
	if (tp->tm.tm_hour != TMX_NULL) goto dd2; /* Have hour? Assume day. */
	if (tp->tm.tm_mday != TMX_NULL) goto hh2; /* Have day? Assume hour. */
	if (i > 24) goto dd2;			/* Impossible HH means DD */

	if (ptpeektok(&tok, &xtok)		/* If next token exists */
	 && xtok.tflg == 0			/* and is an alpha */
	 && xtok.ttmw->wtype&TWF_TIM)	/* time-spec, assume hour! */
	    goto hh2;			/* e.g. "3 PM", "11-EDT"  */
	/* Otherwise assume day and drop thru */

dd2:	if (ptstash(&tp->tm.tm_mday, i))	/* Store day (1 based) */
	    TERR("day clash")
	continue;				/* Continue normal loop */

mm2:	if (ptstash(&tp->tm.tm_mon, i-1))	/* Store month (0-based) */
	    TERR("month clash")
	continue;				/* Continue normal loop */

yy2:	i += 1900;
year4:	if (ptstash(&tp->tm.tm_year, i))	/* Store year (full number) */
	    TERR("year clash")
	continue;				/* Continue normal loop */

	/* Hack HH:MM[[:]SS] */
coltime:
	if (ptstash(&tp->tm.tm_hour, i))
	    TERR("hour clash")
	if (!pttoken(&tok))		/* Get next token */
	    break;			/* EOF? Done, break out of loop! */
	ntoks++;
	if (!tok.tflg)
	    TERR("bad syntax - hh:?")	/* HH:<alpha> ?? */
	if (tok.tcnt == 4) {		/* MMSS */
coltm4:	    if (ptstash(&tp->tm.tm_min, tok.tnum/100)
	     || ptstash(&tp->tm.tm_sec, tok.tnum%100))
		TERR("min/sec clash")
	    continue;			/* Continue normal loop */
	}
	if (tok.tcnt != 2 
	  || ptstash(&tp->tm.tm_min, tok.tnum))
	    TERR("min clash or bad")
	if (tok.tbrk != ':')		/* Seconds follow? */
	    continue;			/* Nope, back to normal loop */
coltm2:
	if (!pttoken(&tok))		/* Get next token */
	    break;			/* EOF, break out of loop! */
	ntoks++;
	if (!tok.tflg || tok.tcnt != 2)	/* Verify SS */
	    TERR("secs expected")
	if (ptstash(&tp->tm.tm_sec, tok.tnum))
	    TERR("sec clash")
	/* Back to start of loop */
    }
    /* End of gigantic token-processing while() loop */

    if (midnoon != TMX_NULL || ampm != TMX_NULL)
	err = ptfixup(tp, midnoon, ampm);	/* Do final fixups */

edone:					/* TERR macro jumps here */

    i = err ? -1 : ntoks;	/* Determine return value */
    if (i >= 0) {		/* If no errs, check last token attempt */
	if (tok.tcnt) {	/* Was a token read? */
	    if (tok.tnum)	/* Yes, was a match found? */
		TERR("ambiguous keyword")	/* Yes, ambiguity is error! */
	    else err = "unknown keyword";	/* No, just unknown, semi-OK */
	} else if (tok.tbrk)		/* No token read, was break EOF? */
		err = "non-null break char";	/* No, semi-OK */
    }

    tp->tmx_err = err;		/* Set error string (NULL if none) */
    if (endptr)
	*endptr = tok.tcp;
    return i;
}

/* Auxiliary routines, all static */

/* PTSTASH - Store date/time value, checking for possible clash.
 *	Returns 0 if successful (for easier coding).
 *	Fails if entry already set to a different value.
 */
static int
ptstash(ip, val)
register int *ip;
{
    if(*ip != TMX_NULL)		/* If entry is already set, */
	return *ip != val;	/* fail if new value isn't same. */
    *ip = val;			/* Not set, so new val always OK. */
    return 0;
}

/* PT12HACK - This subroutine is invoked for NOON or MIDNIGHT when wrapping up
 *	just prior to returning from time_parse.
 *	Returns NULL if everything's OK, else an error string pointer.
 */
static char *
ptfixup(tp, midnoon, ampm)
register struct tmx *tp;
int midnoon, ampm;
{
    register int i, h;

    if (midnoon != TMX_NULL) {
	if (((i=tp->tm.tm_min) && i != TMX_NULL)	/* Ensure mins, secs */
	 || ((i=tp->tm.tm_sec) && i != TMX_NULL))	/* are 0 or unspec'd */
	    return "mm:ss must be 00:00";

	i = midnoon;			/* Get 0 or 12 (midnite or noon) */
	if ((h = tp->tm.tm_hour) == TMX_NULL	/* If hour unspec'd, win */
	 || h == 12)			/* or if 12:00 (matches either) */
	    tp->tm.tm_hour = i;		/* Then set time */
	else if (!(i == 0			/* Nope, but if midnight and */
	    && (h == 0 || h == 24)))	/* time matches, can pass. */
		return "midnight hr clash";
	/* midnoon spec won.  Cannot co-exist with AM/PM... */
	if (ampm != TMX_NULL)
	    return "am/pm clash";
    } else if (ampm != TMX_NULL) {

	/* Adjust hour properly for AM/PM spec */
	switch (ampm) {
	    default: return "bad am/pm val";
	    case TMX_NULL:		/* Ignore these values */
	    case 0:
		break;
	    case 1:			/* AM */
	    case 2:			/* PM */
		if ((i = tp->tm.tm_hour) == TMX_NULL)
		    i = 0;
		if (i > 12) return "am/pm out of range";
		if (i == 12) i = 0;	/* Modulo 12 */
		if (ampm == 2)		/* If PM, then */
		    i += 12;		/*   get 24-hour time */
		tp->tm.tm_hour = i;
		break;
	}
    }
    return 0;		/* Won, no problems */
}

/* PTTOKEN - Given pointer to a token struct, reads the next token into the
 *	struct and identifies it to some degree.
 *	Returns 0 if failure or no more tokens, in which case:
 *		token.tcnt != 0 if bad keyword.  token.tnum has # matches
 *			(either 0 for none, or 2 for ambiguous partial match)
 *		token.tcnt == 0 if EOF.  token.tbrk will be 0 for normal EOF,
 *			else will hold the illegal break char.
 */
/* PTPEEKTOK - Same but takes input from 1st token struct and leaves
**	peeked-at token in 2nd struct.
*/
static int
pttoken(tkp)
register struct token *tkp;
{	return ptitoken(tkp->tcp + tkp->tcnt, tkp);
}
static int
ptpeektok(otkp, ntkp)
struct token *otkp, *ntkp;
{	return ptitoken(otkp->tcp + otkp->tcnt, ntkp);
}
static int
ptitoken(str, tkp)
char *str;
register struct token *tkp;
{
    
    /* Read token from string */
    if (ptscntok(str, tkp) == 0) {
#ifdef DEBUG
	printf("EOF\n");
#endif
	return 0;		/* No token found, tcnt and tnum both 0. */
    }

    /* Got a token, now try to identify it as number or keyword */

#ifdef DEBUG
    {	char *cp = tkp->tcp;
	i = cp[tkp->tcnt];
	cp[tkp->tcnt] = 0;
	printf("Token: \"%s\" ", cp);
	cp[tkp->tcnt] = i;
    }
#endif

    if (tkp->tflg == 0) {	/* Check num or alpha */
				/* Alpha, look up in keyword table */
	if ((tkp->tnum = ptmatchstr(tkp->tbuf, &tkp->ttmw)) != 1) {
#ifdef DEBUG
	    printf("Not found!\n");
#endif
	    return 0;
	}
    }

#ifdef DEBUG
    if (tkp->tflg)
	printf("Val: %d.\n",tkp->tnum);
    else printf("Found: \"%s\", val: %d., type %o\n",
	tkp->ttmw->went, tkp->ttmw->wval, tkp->ttmw->wtype);
#endif

    return 1;
}

static int
ptmatchstr(str, atmw)
char *str;
struct tmwent **atmw;	/* Holds last match found */
{
    register char *cp, *mp;
    register int c;
    struct tmwent *tmw = &tmwords[0];

    *atmw = 0;			/* Initialize to null */
    for ( ; mp = tmw->went; tmw++) {
	cp = str;
	while ((c = *cp++) == *mp++)	/* Compare loop */
	    if (c == 0) {
		*atmw = tmw;		/* Exact match */
		return 1;
	    }
	if (c == 0)			/* Partial match? */
	    if (*atmw) return 2;	/* Ambiguous */
	    else *atmw = tmw;		/* 1st ambig */
    }
    return (*atmw ? 1 : 0);	/* Win if any non-ambiguous partial match */
}

/* PTSCNTOK - Read token from input string into token structure.
 *	Skips over all initial whitespace and break chars.
 *	Returns the # of chars in the token; this will be 0 if
 *	hit a EOF-type delimiter or end of string before any token read.
 */
static int
ptscntok(cp, tkp)
register char *cp;
register struct token *tkp;
{
    register int c;

    tkp->tbrkl = tkp->tbrk;		/* Set "last break" */
    tkp->tcnt = 0;			/* Clear # chars in token */
    tkp->tcp = cp;			/* Set pointer to start of token */

    /* First flush all whitespace and legal breaks */
    while (c = *cp++) {
	if (!isspace(c))
	    if (ptbrkc(c))
		tkp->tbrkl = c;		/* Set new last-break-char */
	    else break;			/* Not space or break, stop loop */
	tkp->tcp = cp;			/* Update new start of token */
    }

    /* c has first non-space, non-break char. */
    if (isdigit(c)) {		/* Numerical token? */
	register long i = 0;	/* Initialize accumulated value */
	do { tkp->tcnt++;
	    i = i*10 + (c-'0');
	} while (isdigit(c = *cp++));
	tkp->tnum = tkp->tlong = i;	/* Set token value */
	tkp->tflg = 1;			/* say numeric */

    } else if (isalpha(c)) {	/* Alpha word token? */
	register char *bp = &tkp->tbuf[0];	/* Initialize ptr into buff */
	do {
	    if (++tkp->tcnt <= MAXTOKEN) *bp++ = tolower(c);
	} while (isalpha(c = *cp++));
	*bp = '\0';
	tkp->tflg = 0;		/* say alpha */
    } else {
	/* Char is illegal (most likely the terminating null).
	** Nothing special needs to be done.
	*/
    }
    if (tkp->tcnt)
	while (isspace(c)) c = *cp++;	/* If token read, flush wsp */

    tkp->tbrk = c;			/* Use 1st non-wsp as break char */
    return tkp->tcnt;			/* Then return # token chars seen! */
}

/* PTBRKC(ch) - returns true if char is a valid date/time break char.
*/
static int
ptbrkc(ch)
{
    switch (ch) {
	case '(': case ')':
	case '-': case ',':
	case '/': case ':':
	case '.':
		return 1;
	default:
		return 0;
    }
}
