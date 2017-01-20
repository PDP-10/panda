/*	CCERR.C - Error Handling
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.57, 15-Apr-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.23, 8-Aug-1985
**
**	Original version (C) 1981  K. Chen
*/

#include "cc.h"
#include "cclex.h"	/* For access to error line buffer */
#include "ccchar.h"	/* For isprint() */
#include <stdarg.h>	/* For printf-type args */
#include <stdlib.h>	/* For exit() return vals */
#include <string.h>
#include <errno.h>

#ifndef __STDC__
#define __STDC__ 0
#endif

/* Local prototypes */
#ifdef __STDC__
#define P_(a) a
#else
#define P_(a) ()
#endif

static char *errmak P_((char *fmt,va_list ap));
static void context P_((char *etype,char *fmt,va_list ap));
static void ectran P_((char *to,char *from,int cnt));
static int evsprintf P_((char *cp,char *fmt,va_list *aap));
static char *tokname P_((int tok));
static int edefarg P_((char *cp,char **afmt,va_list *aap));
static int strapp P_((int *ip,char **cpp,char *s));
static int tsprintf P_((char *cp,TYPE *t));
static void recover P_((int n));

#undef P_

#if __STDC__
#define PRFUN(f) f(char *fmt, ...) { va_list ap; va_start(ap, fmt);
#else
#define PRFUN(f) f(fmt) char *fmt; { va_list ap; va_start(ap, fmt);
#endif

/* NOTE - print notification message
*/
void PRFUN(note)
    if (wrnlev < WLEV_NOTE)
	context("[Note] ", fmt, ap);
}

/* ADVISE - print advisory message
*/
void PRFUN(advise)
    if (wrnlev < WLEV_ADVISE)
	context("[Advisory] ", fmt, ap);
}

/* WARN - print warning message
*/
void PRFUN(warn)
    if (wrnlev < WLEV_WARN)
	context("[Warning] ", fmt, ap);
}

void PRFUN(int_warn)
    context("[Warning][Internal error] ", fmt, ap);
}

/* ERROR - print error message
** INT_ERROR - same, but prefixes with "Internal error - "
*/
void PRFUN(error)
    nerrors++;				/* Mark this as an error */
    context("[Error] ", fmt, ap);	/* Show context */
}
void PRFUN(int_error)
    nerrors++;					/* Mark this as an error */
    context("[Internal error] ", fmt, ap);	/* Show context */
}

/* EFATAL - print fatal error message, with context.
*/
void PRFUN(efatal)
    context("[FATAL] ", fmt, ap);		/* Show context */
    exit(EXIT_FAILURE);
}

/* JMSG - print job error message (no context).
** JERR - print job error message and bump error count for current module.
** FATAL - print fatal job error message and die.
*/
static char jerrhdr[] =		/* Header differs, sigh */
#if SYS_CSI
			"? KCC";
#else
			"?KCC";
#endif
void PRFUN(jmsg)
    fprintf(stderr, "%s - %s\n", jerrhdr, errmak(fmt, ap));
}
void PRFUN(jerr)
    ++nerrors;
    fprintf(stderr, "%s - %s\n", jerrhdr, errmak(fmt, ap));
}
void PRFUN(fatal)
    fprintf(stderr, "%s - Fatal error: %s\n", jerrhdr, errmak(fmt, ap));
    exit(EXIT_FAILURE);				/* stop program */
}

/* ERRFOPEN - Auxiliary for CC and CCOUT, invoked after failing fopen()s
*/
void
errfopen(desc, fnam)
char *desc, *fnam;
{
    jerr("Could not open %s file \"%s\": %s", desc, fnam, strerror(errno));
}

/* ERRIO - Auxiliary for CC and CCOUT, invoked after failing file I/O
*/
void
errio(desc, fnam)
char *desc, *fnam;
{
    jerr("Error %s file \"%s\": %s", desc, fnam, strerror(errno));
}

/* ERRNOMEM - Auxiliary invoked when a malloc fails.
*/
void
errnomem(s)
char *s;
{
    efatal("Out of memory %s", s);
}

/* ERRMAK - Return pointer to a static buffer containing error msg text.
**	This does not contain a newline.
*/
static char *
errmak(fmt, ap)
char *fmt;
va_list ap;
{
    static char emsgbuf[2000];	/* Want lots of room to be real safe */
    evsprintf(emsgbuf, fmt, &ap);
    va_end(ap);
    return emsgbuf;
}

/* CONTEXT - print context of error
**	If "fline" is set 0 (normally never, since it starts at 1)
**	the input buffer context will not be shown.
**	This feature is used when emitting warnings after a file has been
**	completely compiled.
*/

static void
context(etype, fmt, ap)
char *etype, *fmt;
va_list ap;
{
    char *estr;
    char *cp, *ep;
    char conbuf[ERRLSIZE*6];	/* Allow for lots of "big" chars */
    int cnt, colcnt;
    int here = line;		/* Line # on page */

    estr = errmak(fmt, ap);	/* Build error message */

    if (erptr != errlin && erptr[-1] == '\n')
	--here;			/* Find right line # on current page */
				/* (KLH: but probably not worth the trouble) */

#if 1	/* New version */
    fprintf(stderr, " \"%s\", line %d: %s%s\n",
			inpfname, fline, etype, estr);

    /* Someday may wish to make further context optional (runtime switch) */
    if (!fline || 0) return;	/* Omit buffer context if at EOF */

    cp = estrcpy(conbuf, "       (");	/* Indented by 6 */
    if (curfn != NULL) {		/* are we in some function? */
	cp = estrcpy(cp, curfn->Sname);	/* yes, give its name */
	if (fline > curfnloc) {
	    sprintf(cp, "+%d", fline - curfnloc);
	    cp += strlen(cp);
	}
	cp = estrcpy(cp, ", ");		/* separate from page/line info */
    }

    sprintf(cp, "p.%d l.%d): ", page, here);
    colcnt = strlen(conbuf);	/* # cols so far */
    fputs(conbuf, stderr);

    /* Show current input context */
#if 1
    /* Unroll circular buffer */
    if (!ercsiz) ercsiz = 79;	/* Set default if needed (# cols of context) */
    colcnt = ercsiz - colcnt;	/* Get # columns available for input context */
    cp = conbuf;
    ep = erptr;
    cnt = erpleft;
    while (*ep == 0 && --cnt > 0) ++ep;	/* Scan to find first non-null */
    if (cnt > 0) {
	ectran(conbuf, ep, cnt);	/* Translate cnt chars from ep to buf*/
	ectran(conbuf+strlen(conbuf),	/* then initial part */
		errlin, ERRLSIZE - erpleft);
    } else {
	ep = errlin;
	cnt = ERRLSIZE - erpleft;
	while (*ep == 0 && --cnt > 0) ++ep;
	ectran(conbuf, ep, cnt);
    }
    if ((cnt = strlen(cp = conbuf)) > colcnt)
	cp += cnt - colcnt;	/* If too long, show only last N chars */

    fputs(cp, stderr);		/* Output the context string! */
    fputc('\n', stderr);
    fputc('\n', stderr);	/* Extra newline between msgs for clarity */
#else
    if (erptr != errlin) *erptr = 0;	/* terminate line for printf */
    fprintf(stderr, "%s\n", errlin);	/* print where we were */
#endif

#else	/* Old version */
    fprintf(stderr, "\n%s at ", etype);	/* start error message */
    if (curfn != NULL) {		/* are we in some function? */
	fputs(curfn->Sname, stderr);	/* yes, give its name */
	if (fline > curfnloc) fprintf(stderr, "+%d", fline - curfnloc);
	fputs(", ", stderr);		/* separate from absolute loc */
    }
    if (page > 1) fprintf(stderr, "page %d ", page); /* page number */
    fprintf(stderr,"line %d of %s:\n", here, inpfname);
    if (erptr != errlin) *erptr = 0;	/* terminate line for printf */
    fputs(errlin, stderr);		/* print where we were */
#endif
}

/* ECTRAN - translate file input string to something nice for
**	error message output.  Always adds a NUL after "cnt" chars.
*/
static void
ectran(to, from, cnt)
char *to, *from;
int cnt;
{
    int c;
    char *exp;
    char expbuf[8];

    while (--cnt >= 0) {
	if (isprint(c = *from++)) {
	    *to++ = c;
	    continue;
	} else switch (c) {
	case (char)-1:	exp = "<EOF>"; break;
	case '\b':	exp = "<\\b>"; break;	/* Show unusual whitespace */
	case '\f':	exp = "<\\f>"; break;
	case '\v':	exp = "<\\v>"; break;
	case '\r':	exp = "<\\r>"; break;
#if 1
	case '\t':
	case '\n':	exp = " "; break;	/* Just use whitespace */
#else
	case '\t':	exp = "<\\t>"; break;
	case '\n':	exp = "<\\n>"; break;
#endif
	default: sprintf(exp = expbuf,"<\\%o>", c); break;
	}
	to = estrcpy(to, exp);
    }
    *to = '\0';		/* Ensure string ends with null. */
}

static int
evsprintf(cp, fmt, aap)
char *cp, *fmt;
va_list *aap;
{
    int i, max;
    char *str;
    NODE *n;
    SYMBOL *s;
    TYPE *t;
    int cnt = 0;
    va_list ap = *aap;
    
    for (*cp = *fmt; *cp; *++cp = *++fmt) {
	if (*cp != '%') { ++cnt; continue; }
	switch (*++fmt) {
	case '%': continue;
	case 'E':		/* Substitute new format string */
	    fmt = va_arg(ap, char *);
	    --fmt;
	    i = 0;
	    break;
	case 'N':		/* Node op printout */
	    n = va_arg(ap, NODE *);
	    i = sprintf(cp, "(node %d: %d=%s)", nodeidx(n), n->Nop,
						tokname(n->Nop));
	    break;
	case 'Q':		/* Token printout */
	    i = va_arg(ap, int);
	    i = sprintf(cp, "(token %d=%s)", i, tokname(i));
	    break;
	case 'S':		/* Symbol printout */
	    s = va_arg(ap, SYMBOL *);
	    str = s ? s->Sname : "<unnamed>";
	    i = '"';			/* Default quoting char */
	    max = IDENTSIZE-1;		/* Max ident length */
	    switch (str[0]) {
	    case SPC_IDQUOT:
		i = '`';	/* Different quote char, then drop thru */
	    case SPC_SMEM:
	    case SPC_TAG:
	    case SPC_LABEL:	/* Don't show prefix char */
		--max;
		++str;
	    }
	    i = sprintf(cp, "%c%.*s%c", i, max, str, i);
	    break;
	case 'T':		/* Type definition printout */
	    t = va_arg(ap, TYPE *); /* get pointer to type */
	    i = tsprintf(cp,t);	/* Add type description to string */
	    break;
	default:
	    i = edefarg(cp, &fmt, &ap);
	    break;
	}
	cnt += i;
	cp += i-1;
    }
    *aap = ap;		/* Update arglist pointer */
    return cnt;
}

static char *
tokname(tok)
{
    return (0 < tok && tok < NTOKDEFS) ? nopname[tok] : "??";
}

/* EDEFARG - auxiliary to handle default %-specifications.
**	Simple-mindedly copies anything that looks like a sprintf format
**	spec, and invokes sprintf on it with an appropriate argument
**	plucked from the arglist.
** Return value is # chars written, and
** FMT is updated to point at last char read.
*/
static int
edefarg(cp, afmt, aap)
char *cp;			/* Points to place to deposit */
char **afmt;			/* Points to 1st char after % */
va_list *aap;
{
    int c;
    char fmtbuf[50];
    char *fmt = *afmt;
    char *bp = fmtbuf;
    int typ = 0;

    *bp = '%';
    for (c = *fmt; ; c = *++fmt) {
	switch (*++bp = c) {
	case '*':		/* Can't handle this */
	default:		/* Or end-of-string or anything unknown */
	    *++cp = **afmt;
	    return 2;
	case '-': case '+': case '0':	/* Prefix flags */
	case ' ': case '#': case '.':
	case '1': case '2': case '3':	/* Width or precision specs */
	case '4': case '5': case '6':
	case '7': case '8': case '9':
	    continue;
	case 'h': case 'l': case 'L':	/* Type size flags */
	    typ = c;
	    continue;
	case 's':
	    typ = c;
	    break;
	case 'f': case 'e': case 'E': case 'g': case 'G':
	    if (!typ) typ = 'd';
	    break;
	case 'c':		/* Types that take (int) unless h or l seen */
	case 'i': case 'd': case 'o':  case 'u': case 'x': case 'X':
	    break;
	}
	/* Done, assume last char is conversion specifier */
	*++bp = 0;		/* Tie off format string */
	*afmt = fmt;		/* Won, update format ptr */
	switch (typ) {		/* Default type size is (int) */
	default:  return sprintf(cp, fmtbuf, va_arg(*aap, int));
	case 'l': return sprintf(cp, fmtbuf, va_arg(*aap, long));
	case 'h': return sprintf(cp, fmtbuf, va_arg(*aap, short));
	case 's': return sprintf(cp, fmtbuf, va_arg(*aap, char *));
	case 'd': return sprintf(cp, fmtbuf, va_arg(*aap, double));
	case 'L': return sprintf(cp, fmtbuf, va_arg(*aap, long double));
	}
    }
}

/* TSPRINTF - Output type description ala sprintf
** Calling sequence:
**	i = tsprintf(cp, t);
**	char *cp;	Target string buffer
**	TYPE *t;	Type pointer
**	int i;		Number of characters written
*/

static int strapp(ip, cpp, s)
int *ip;
char **cpp;
char *s;
{
  int n = strlen(s);

  strcpy(*cpp, s);
  *ip += n;
  *cpp += n;
}

static int tsprintf(cp, t)
char *cp;
TYPE *t;
{
  TYPE *tp;
  int i = 0, n, done;

  do {
    /* Check for "const" */
    if (tisconst(t))
      strapp(&i, &cp, "constant ");
    /* Check  for "volatile" */
    if (tisvolatile(t))
      strapp(&i, &cp, "volatile ");
    done = 1;			/* Assume done after this */
    /* Decode type spec */
    switch (t->Tspec) {
    case TS_FUNCT:
      strapp(&i, &cp, "function ");
      if (t->Tproto) {
	strapp(&i, &cp, "of (");
	for (tp = t->Tproto; tp; tp = tp->Tproto) {
	  if (tp != t->Tproto) strapp(&i, &cp, ", ");
	  n = tsprintf(cp, ParamSubt(tp));
	  cp += n;
	  i += n;
	}
	strapp(&i, &cp, ") ");
      }
      strapp(&i, &cp, "returning ");
      done = 0;			/* Follow Tsubt */
      break;
    case TS_PARAM:
      strapp(&i, &cp, "parameter ");
      done = 0;			/* Follow Tsubt */
      break;
    case TS_ARRAY:
      strapp(&i, &cp, "array ");
      if (t->Tsize) {
	n = sprintf(cp, "[%d] ", t->Tsize);
	cp += n;
	i += n;
      }
      strapp(&i, &cp, "of ");
      done = 0;			/* Follow Tsubt */
      break;
    case TS_PTR:
      strapp(&i, &cp, "pointer to ");
      done = 0;			/* Follow Tsubt */
      break;
    case TS_LNGDBL:
      strapp(&i, &cp, "long double");
      break;
    case TS_BITF:
    case TS_UBITF:
    case TS_INT:
    case TS_UINT:
      if (tisunsign(t)) strapp(&i, &cp, "unsigned ");
      strapp(&i, &cp, "integer");
      if (tisbitf(t)) {
	n = sprintf(cp, " field of %d bit%s",
		    t->Tsize, t->Tsize == 1 ? "s" : "");
	cp += n;
	i += n;
      }
      break;
    case TS_CHAR:
    case TS_UCHAR:
      if (tisunsign(t)) strapp(&i, &cp, "unsigned ");
      if (tbitsize(t) != tgcsize) {
	n = sprintf(cp, "%d bit ", tbitsize(t));
	cp += n;
	i += n;
      }
      strapp(&i, &cp, "character");
      break;
    case TS_SHORT:
    case TS_USHORT:
      if (tisunsign(t)) strapp(&i, &cp, "unsigned ");
      strapp(&i, &cp, "short integer");
      break;
    case TS_LONG:
    case TS_ULONG:
      if (tisunsign(t)) strapp(&i, &cp, "unsigned ");
      strapp(&i, &cp, "long integer");
      break;
    case TS_STRUCT:
    case TS_UNION:
    case TS_ENUM:
      strapp(&i, &cp, tsnames[t->Tspec]);
      *cp++ = ' ';
      i++;
      strapp(&i, &cp, t->Tsmtag->Sname);
      break;
    case TS_PARVOID:
      strapp(&i, &cp, "void");
      break;
    case TS_PARINF:
      strapp(&i, &cp, "...");
      break;
    default:
      if (t->Tspec < TS_MAX)
	strapp(&i, &cp, tsnames[t->Tspec]);
      else {
	n = sprintf(cp, "?Type=%d.?", t->Tspec);
	cp += n;
	i += n;
      }
      break;
    }
    /* Get subtype */
    t = t->Tsubt;
  } while (!done);

  return i;
}

/* ---------------------- */
/*	expect token      */
/* ---------------------- */
int
expect(t)
{
    char *s, str[32];

    if (t == token) {
	nextoken();
	return 1;
    }
    switch (t) {
    case T_LPAREN:	s = "left parenthesis"; 	break;
    case T_RPAREN:	s = "right parenthesis"; 	break;
    case T_LBRACK:	s = "left bracket"; 		break;
    case T_RBRACK:	s = "right bracket"; 		break;
    case T_SCOLON:	s = "semicolon";		break;
    case T_COMMA:	s = "comma";			break;
    case T_COLON:	s = "colon";			break;
    case Q_IDENT:	s = "identifier";		break;
    case T_RBRACE:	s = "close brace";		break;
    case Q_WHILE:	s = "\"while\" keyword";	break;
    default:		sprintf(s = str, "[token %d]", t);	break;
    }
    error("Expected token (%s) not found", s);
    recover(t);
    return 0;
}

/* ------------------------ */
/*	error recovery      */
/* ------------------------ */
/* KLH: this is pretty poor; someday work on it. */

static void
recover(n)
{
    if (n == T_SCOLON) {
	while (!eof && token != T_SCOLON && token != T_RBRACE) nextoken();
	if (token == T_SCOLON) nextoken();
	return;
    }
    tokpush(token, csymbol);
    token = n;
}

int
errflush()
{
    for(;;) switch (token) {
	case T_EOF: case T_SCOLON: case T_RBRACE:
	    return nextoken();
	default:
	    nextoken();
    }
}
