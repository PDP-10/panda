/*	CCLEX.C - New KCC Lexer - Token input
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.150, 8-Apr-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.43, 8-Aug-1985
**
**	Original version (C) 1981  K. Chen
*/

#include "cc.h"
#include "ccchar.h"
#include "cclex.h"	/* Get stuff shared with CCINP */


/* Globals used */
extern int savelits;	/* Set 0 by CC main parsing loop for each toplevel
			** declaration parse, to indicate that string literal
			** space is free and can be re-used again.
			*/
/* See also stuff in "cclex.h" */

/* Globals set:
 *	int token	Current token code.
 *   If token==T_ICONST, T_CCONST, T_FCONST, T_SCONST
 *	struct {} constant	contains type+value of constant (CCINP,CCSTMT)
 *   If token==Q_IDENT or a reserved-word token,
 *	SYMBOL *csymbol		contains pointer to SYMBOL for this identifier.
**				If it hasn't yet been defined, it will be a
**				global symbol with class SC_UNDEF.
 *					(CCDECL,CCERR,CCSTMT)
 *
 * Note: the "constant" structure is not correct after nextoken() returns
 * a token which was pushed back by tokpush().
 *
 * Note that most routines operate, or begin to operate, on the current
 * token in "token", rather than immediately reading the next token.  When
 * a token is completely processed and is not needed any more, nextoken()
 * must be called in order to get rid of it and set up a new token for
 * whatever will be next looking at the input.  Occasionally "token" is
 * set directly for proper "priming".
 */	

/* Token stack - entries added by tokpush(), removed by nextok() */
static int tokstack;
static struct {
	int      ttoken;
	SYMBOL	*tsym;
} tstack[MAXTSTACK];

/* Local prototypes */
#ifdef __STDC__
#define P_(a) a
#else
#define P_(a) ()
#endif

static int trident P_((void));
static int spcident P_((char *to,char *frm,int cnt));
static int zerotok P_((void));
static int dzerotok P_((void));
static int trintcon P_((void));
static int trfltcon P_((void));
static int trstrcon P_((void));
static int szerotok P_((void));
static int trchrcon P_((void));
static int cchar P_((char **acp));

#undef P_

/* String literal char pool */
static char *slcptr;		/* Pointer into slcpool */
static int slcleft;		/* Countdown of # free chars left */
static int slcocnt;		/* Saved slcleft for deriving string len */
static char slcpool[CPOOLSIZE];	/* String literal character pool */

/* Macros to handle deposit of chars into string literal char pool (slcpool) */
#define slcreset() (slcleft=CPOOLSIZE-1, slcptr=slcpool)
#define slcbeg() (slcocnt=slcleft, slcptr+1)
#define slcput(c) (--slcleft > 0 ? *++slcptr = (c) : (c))
#define slclen() (slcocnt - slcleft)
#define slcend() (--slcleft > 0 ? (*++slcptr = 0, slclen()) : -1)

/* LEXINIT() - Initialize the lexer
**	The symbol table must have already been set up (by initsym)
**	and the preprocessor initialized (by initinp)
**	otherwise the initial nextoken() will not work properly.
*/
void
lexinit()
{
    tokstack = 0;
    savelits = 0;		/* OK to reset string literal char pool */
    if (!prepf) nextoken();	/* Prime with 1st token */
}

/* TOKPUSH(tok, sym) - Push a token
**	Note that the "constant" structure is not pushed or changed.
** It is OK for the current token to be a constant, if the token pushed
** (arg to tokpush) is not a constant.  In fact, no constants can be
** pushed.  The code for unary() in CCSTMT is the only place where this
** sort of thing has to be taken into account.
*/
void
tokpush(t, s)
SYMBOL *s;
{
    if(++tokstack >= MAXTSTACK)		/* Token stack depth exceeded? */
	--tokstack, int_error("tokpush: tokstack overflow");
    else {
	tstack[tokstack].ttoken = token;
	tstack[tokstack].tsym = csymbol;
	token = t;
	csymbol = s;
    }
}

/* NEXTOKEN() - Get next C language token, by transforming one or more
**	PP-tokens from CCPP.
*/
int
nextoken()
{
    if (tokstack) {		/* Pop token from push-back stack */
	csymbol = tstack[tokstack].tsym;
	return token = tstack[tokstack--].ttoken;
    }
    csymbol = NULL;			/* Clear sym associated with token */
    for (;;) switch (token = nextpp()) {	/* Get next preproc token */

    case T_WSP:			/* Just skip whitespace */
    case T_EOL:
	continue;
    default:			/* Most tokens returned directly! */
	return token;

    /* Transform things that need transforming */
    case T_IDENT:	return trident();	/* Transform the identifier */
    case T_ICONST:	return trintcon();	/* Integer constant */
    case T_FCONST:	return trfltcon();	/* Floating pt constant */
    case T_CCONST:	return trchrcon();	/* Char constant */
    case T_SCONST:	return trstrcon();	/* String constant */

    /* Do debug checking to catch PP-only stuff.  This would be
    ** caught later on by higher levels, but most responsible to screen
    ** them here.
    */
    case T_MACRO:
    case T_MACARG:
    case T_MACINS:
    case T_MACSTR:
    case T_MACCAT:
	int_error("nextoken: PP-only token %Q", token);
	continue;		/* Try again */

    case T_SHARP:
    case T_SHARP2:
	error("# or ## can only appear in PP directives or macros");
	continue;		/* Try again with next token. */

    case T_UNKNWN:
	error("Unknown token: \"%s\"", curval.cp);
	continue;		/* Try again with next token. */
    }
}

/* TRIDENT() - Transform identifer token
**
** Sets "csymbol" to point to the resulting symbol, and then returns the token
** corresponding to the given identifier (i.e. reserved word or Q_IDENT).
*/

static int
trident()
{
    char ident[IDENTSIZE+4];	/* Identifier big enuf to trigger trunc */
    char *cp;
    
    if (!(cp = curval.cp)) {
	int_error("trident: no string");	/* No string for T_IDENT */
	return zerotok();
    }
    if (csymbol = cursym)
	switch (csymbol->Sclass) {
	case SC_RW:		/* Reserved word, use its token */
	    return token = csymbol->Stoken;
	case SC_MACRO:		/* Paranoia check on CCPP */
	    int_error("trident: Escaped macro %S", csymbol);
	default:		/* Normal symbol, just return identifier */
	    return token = Q_IDENT;
    }

    if (*cp == SPC_IDQUOT && clevkcc) {
	if (!spcident(ident, cp, sizeof(ident)-1))
	    return zerotok();
	cp = ident;
    } else int_error("trident: cursym 0 for \"%s\"", cp);

    /* If no symbol already exists for identifier, find or get one.
    ** This will only happen when creating a symbol for a quoted identifier
    ** (which cannot be a macro), or recovering from an internal error.
    ** If a symbol is made, it will have class SC_UNDEF.
    ** symfind() will complain if the identifier was truncated.
    */
    csymbol = symfind(cp, 1);	/* Find sym or make one */
    return token = Q_IDENT;
}

/* SPCIDENT(to, frm, cnt) - Get quoted identifier; special KCC extension.
**	First char of "frm" string is '`'.
*/
static int
spcident(to, frm, cnt)
char *to, *frm;
int cnt;
{
    register int c;
    register char *s = to;

    *s = SPC_IDQUOT;		/* Start sym with special char */
    for(;;) {
	switch (c = *++frm) {	/* Loop over input chars */
	    case '`':		/* Terminator? */
		if (!*++frm)	/* Yes, string must stop now! */
		    break;	/* Won! */
		/* Drop thru to flag as error */
	    case 0:
		int_error("spcident: Bad string for %s %Q", to, token);
		return 0;		/* Leave loop */

	    case '\\':
		c = cchar(&frm);	/* Get escaped char */
		--frm;			/* Back up so ++ gets next */
					/* and drop thru to default */
	    default:
		if (c == '.') c = '_';	/* Check symbol chars */
		if (!iscsym(c) && (c != '$') && (c != '%'))
		    warn("Bad PDP10 symbol char: '%c'", c);
		if (--cnt > 0)
		    *++s = c;		/* add to ident. */
		continue;		/* and continue loop */
	}
	break;				/* Leave loop */
    }

    *++s = '\0';			/* null terminate */
    if (!to[1]) {
	error("Quoted identifier is null");
	return 0;		/* Say no token */
    }
    return 1;
}

static int
zerotok()
{
    constant.ctype = inttype;
    constant.cvalue = 0;
    return token = T_ICONST;
}

static int
dzerotok()
{
    constant.ctype = dbltype;
    constant.Cdouble = 0.0;
    return token = T_FCONST;
}

/* TRINTCON() - Transform PP-number integer constant
*/
#define SIGN ((unsigned long)1<<(TGSIZ_LONG-1))
#define MAXPOSLONG ((long)((~(unsigned long)0)>>1))

static int
trintcon()
{
    register char *cp;
    register int c;
    register long v = 0;
    int ovfl = 0;

    if (!(cp = curval.cp)) {
	int_error("trintcon: no str");
	return zerotok();
    }

    if ((c = *cp) == '0') {		/* Octal/Hex prefix? */
	c = *++cp;
	if (c == 'x' || c == 'X') {	/* Hex (base 16) */
	    while (isxdigit(c = *++cp)) {
		if (v & (017 << (TGSIZ_LONG-4))) ovfl++;
		v = ((unsigned long)v << 4) + toint(c);
	    }
	} else {			/* Octal (base 8) */
	    while (isodigit(c)) {
		if (v & (07 << (TGSIZ_LONG-3))) ovfl++;
		v = ((unsigned long)v << 3) + c - '0';
		c = *++cp;
	    }
	    if (isdigit(c)) {		/* Helpful msg for common error */
		error("Octal constant cannot have '8' or '9'");
		return zerotok();
	    }
	}
	constant.ctype = (v&SIGN) ? uinttype : inttype;	/* Set right type */
    } else {				/* Decimal (base 10) */
	v = c - '0';
	while (isdigit(c = *++cp)) {
	    if (v < ((MAXPOSLONG-9)/10))
		v = v*10 + c - '0';	/* Can't overflow, do it fast */
	    else {			/* Slow unsigned multiply loop */
		unsigned long pv, uv = v;
		do {
		    pv = uv;			/* Remember prev value */
		    uv = uv*10 + c - '0';
		    if (uv/10 != pv) ++ovfl;	/* If cannot recover, ovflw */
		} while (isdigit(c = *++cp));
		v = uv;
		break;
	    }
	}
	constant.ctype = (v&SIGN) ? ulongtype:inttype;	/* Set right type */
    }

    /* Fix up result by checking suffixes and deciding type to use.
    ** Must use first of the types that can represent the value:
    ** Decimal:	int, long, ulong
    ** Oct/Hex:	int, uint, long, ulong
    **  U     :	uint, ulong
    **	L     : long, ulong
    **  UL    : ulong
    **
    ** Since for the PDP-10 int and long are the same size, this basically
    ** just amounts to deciding whether signed or unsigned is appropriate.
    **	If sign bit set, unsigned type can hold value.
    **	If overflow is set, no type can hold value, use largest.
    */
    if (ovfl) {
	error("Integer constant overflow");
	constant.ctype = ulongtype;		/* Set to biggest type */
    }
    if (c) {
	if ((c = toupper(c)) == 'L') {
	    if (!*++cp) constant.ctype = (ovfl||(v&SIGN)) ? ulongtype:longtype;
	    else if (toupper(*cp++) == 'U') constant.ctype = ulongtype;
	    else c = -1;		/* Bad */
	} else if (c == 'U') {
	    if (!*++cp) constant.ctype = (ovfl) ? ulongtype : uinttype;
	    else if (toupper(*cp++) == 'L') constant.ctype = ulongtype;
	    else c = -1;		/* Bad */
	} else c = -1;			/* Bad */

	if (c < 0 || *cp)		/* Bad if flag set or anything left */
	    error("Bad integer constant suffix");
    }

    constant.cvalue = v;		/* Now set value */
    return token = T_ICONST;
}

/* TRFLTCON() - Transform floating-point PP-number constant
*/
long maxdbl[2] = {MAXPOSLONG, MAXPOSLONG};
#define MAXPOSDOUBLE (*(double *)maxdbl)	/* Gross hack for now */

static int
trfltcon()
{
    register char *cp;
    register int c;
    int expsign, exponent;
    double divisor, value = 0;		/* accumulated value */
    int ovfl = 0;

    /* Internal checks to verify token is correct */
    if (!(cp = curval.cp) || (!isdigit(c = *cp) && c != '.')) {
	int_error("trfltcon: bad str");
	return dzerotok();
    }
	
    /* First do whole-number part.  We use floating arithmetic to avoid
    ** the real possibility of integer overflow.  Slower, but safer.
    */
    for (; isdigit(c); c = *++cp) {
	value = (value*10.0) + (c-'0');
	if (value && value < 1.0)	/* If exponent wrapped around, */
	    ovfl++;			/* we overflowed. */
    }

    /* Now do fractional part if one was specified */
    if (c == '.') {
	divisor = 1.0;		/* Place-value for post-. digits */
	while (isdigit(*++cp))
	    value += (*cp - '0') / (divisor *= 10.0);
	c = *cp;
    }
    
    /* Now exponent, if any */
    if (c == 'E' || c == 'e') {
	expsign = (c = *++cp);	/* Get possible exponent sign */
	if (c == '-' || c == '+')
	    c = *++cp;
	if (!isdigit(c)) {
	    error("Bad floating constant exponent");
	    return dzerotok();
	}
	exponent = c - '0';
	while (isdigit(c = *++cp)) {
	    exponent = exponent*10 + (c-'0');
	    if (exponent >= ((MAXPOSLONG-9)/10))
		ovfl++, value = (expsign=='-' ? 0.0 : 1.0);
	}

	/* EXTREMELY dumb method of scaling value by exponent */
	/* Fix this up later!! */
	if (!ovfl) {
	    double pv;
	    if (expsign == '-')
		while (--exponent >= 0) {
		    pv = value;			/* Remember val so can */
		    if ((value /= 10.0) > pv) {	/* check for underflow */
			ovfl++;
			value = 0;
			break;
		    }
		}
	    else
		while (--exponent >= 0) {
		    pv = value;
		    if ((value *= 10.0) < pv) {	/* Check for overflow */
			ovfl++;
			value = 1.0;
			break;
		    }
		}
	}
    }

    /* See whether we overflowed or not, and fix up. */
    if (ovfl) {
	if (value) value = MAXPOSDOUBLE;
	error("Floating constant %sflow", value ? "over" : "under");
    }

    /* Now check for suffix type specifier */
    if (c) {
	switch (toupper(c)) {
	    case 'F':
		constant.ctype = flttype;
		constant.Cfloat = value;
		c = *++cp;
		break;
	    case 'L':
		constant.ctype = lngdbltype;
		constant.Clngdbl = value;
		c = *++cp;
		break;
	}
	if (c) {
	    error("Bad floating constant suffix");
	    return dzerotok();
	}
    } else {
	constant.ctype = dbltype;	/* Set constant type to double */
	constant.Cdouble = value;	/* and set constant value */
    }
    return token = T_FCONST;
}

/* TRSTRCON() - Transform string constant
**	The only chars not allowed in a string constant are
**	newline, double-quote, and backslash.  They must be
**	entered as a character escape code.
**
**	If using ANSI parsing, two successive string constants are
**	merged into one!
*/

static int
trstrcon()
{
    char *cp;
    int wideflg, escval;

    if (savelits++ == 0) {	/* Can char pool be reset? */
	slcreset();		/* Yes, do so */
    }
    constant.ctype = strcontype;	/* Set constant type to string const */
    constant.csptr = slcbeg();		/* Set constant string ptr */

    /* Internal checks to verify token is correct */
    if (!(cp = curval.cp)) {
	int_error("trstrcon: no str");
	return szerotok();
    }
    if ((wideflg = *cp) == 'L') ++cp;	/* Get wchar_t indicator if any */
    if (*cp != '"') {
	int_error("trstrcon: no \"");
	return szerotok();
    }

    for(;;) {
	switch(*++cp) {
	default:
	    if (tgmachuse.mapch)
		slcput(tgmapch(*cp));	/* Map char if must, add to string */
	    else (void)slcput(*cp);
	    continue;

	case '\\':			/* Escape char */
	    slcput(escval = cchar(&cp));	/* Handle and map it */
	    --cp;			/* Need to ensure ++ gets next */
	    if (escval & ~tgcmask)	/* Did we truncate any bits? */
		warn("Escape-seq value too large for char");
	    continue;

	case '"':			/* End of string? */
	    if (*++cp)
		int_error("trstrcon: trailing junk");
	    if (clevel < CLEV_ANSI)	/* Check for string concatenation? */
		break;			/* Nope, just return what we got */

	    /* Hairy stuff... must look at next token! */
	    for (;;)  {		/* Dumb loop to flush wsp */
		switch (nextpp()) {
		case T_WSP: case T_EOL: continue;
		case T_SCONST:
		    if ((cp = curval.cp)	/* Paranoia token check */
			&& (*cp == wideflg)	/* Wideness must match */
			&& (*cp == '"'		/* Paranoia format check */
			 || (*cp == 'L' && *++cp == '"')))
			break;	/* Hurray, resume main loop! */
				/* Everything's been set up... */
		    /* Can't concatenate next literal, drop thru */
		default:
		    pushpp();		/* Push current token back */
		    cp = NULL;		/* Say we're done */
		    break;		/* Quit loop and return */
		}
		break;		/* Stop inner loop */
	    }
	    if (cp) continue;	/* Resume outer loop if concating */
	    break;		/* else just leave switch */

	case '\0':
	    int_error("trstrcon: no delim");
	    break;
	}
	break;			/* Break from main switch is break from loop */
    }

    /* OK, now finalize string literal in pool. */
    if ((constant.cslen = slcend()) < 0) {
	error("Too many string literal chars, internal overflow");
	return szerotok();
    }
    return token = T_SCONST;
}

static int
szerotok()
{
    constant.csptr = "";		/* Set constant string ptr */
    constant.cslen = 1;
    return token = T_SCONST;
}

/* TRCHRCON() - Transform character constant.
*/

static int
trchrcon()
{
    char *cp;
    int wideflg;
    unsigned long val;

    /* Internal checks to verify token is correct */
    if (!(cp = curval.cp)) {
	int_error("trchrcon: No str");
	return zerotok();
    }
    if ((wideflg = *cp) == 'L') ++cp;	/* Get wchar_t indicator if any */
    if (*cp != '\'' || !*++cp || *cp == '\'') {
	int_error("trchrcon: Bad fmt");
	return zerotok();
    }

    val = 0;
    for (;;) {
	if (val & (-1<<(TGSIZ_INT-TGSIZ_CHAR)))
	    error("Character constant overflow");
	val <<= TGSIZ_CHAR;
	val |= cchar(&cp) & ((1<<TGSIZ_CHAR)-1);	/* Put into word */
	if (*cp == '\'')		/* Most common case, just one char */
	    break;
	if (!*cp) {
	    int_error("trchrcon: Bad fmt");
	    return zerotok();
	}
    }

    constant.ctype = (wideflg == 'L')
			? chartype	/* Wide char const is special type */
			: inttype;	/* Normal char const is type int */

    constant.cvalue = val;
    return T_CCONST;
}

/* CCHAR(&cp) - parse a character from a string literal, char constant,
**	or quoted identifier.
**	Handles escape sequences, and converts values into target char set.
**	Input starts at 1st char of pointer, leaves pointer at first char
**	not translated into resulting value.
*/
static int
cchar(acp)
char **acp;
{
    register char *cp = *acp;
    register int c = *cp;

    if (c == '\\') switch (*++cp) {	/* If escape char, handle it */
	case 'a':	c = 07;	break;	/* ANSI alert - map into BEL */
	case 'b':	c = '\b'; break;
	case 'f':	c = '\f'; break;
	case 'n':	c = '\n'; break;
	case 'r':	c = '\r'; break;
	case 't':	c = '\t'; break;
	case 'v':	c = '\v'; break;
	case '\'':	c = '\''; break;
	case '"':	c = '\"'; break;
	case '\\':	c = '\\'; break;
	case '?':	c = '?';  break;	/* To avoid trigraphs */

	case 'x':	/* Hexadecimal escape sequence */
	    if (isxdigit(*++cp)) {
		int ovfl = 0;
		c = toint(*cp);
		while (isxdigit(*++cp)) {
		    if (c & (017 << (TGSIZ_INT-4))) ovfl++;
		    c = ((unsigned)c<<4) + toint(*cp);
		}
		if (ovfl) warn("Hex constant overflow");
	    } else error("Need hex digit after \\x");
	    *acp = cp;
	    return c;		/* Specific hex value */

	case '0': case '1': case '2': case '3':
	case '4': case '5': case '6': case '7':
	    c = *cp - '0';
	    if (isodigit(*++cp)) {
		c = ((unsigned)c<<3) + *cp - '0';
		if (isodigit(*++cp)) {
		    c = ((unsigned)c<<3) + *cp - '0';
		    ++cp;
		}
	    }
	    *acp = cp;
	    return c;		/* Specific octal value */
	
	case '`':
	    if (clevkcc) { c = '`'; break; }
	    /* Else not doing KCC extensions, drop through to complain. */
    default:
	    error("Unknown escape char (ignoring backslash): '\\%c'",*cp);
    }

    *acp = ++cp;
    return (tgmachuse.mapch ? tgmapch(c) : c);	/* Map char if must */
}
 