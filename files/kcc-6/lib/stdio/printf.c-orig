/*
**	PRINTF - formatted output conversion.
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.27, 12-Apr-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985
**
*/
/* This version has been written to conform to the description of
 * printf in the CARM (Harbison & Steele) book.
 * !!! NOTE: Additional facilities are provided in the form of allowing
 * the user to "bind" new conversion operation chars to arbitrary functions.
 */

/* Known bugs & limitations:
 *	sprintf depends on internal knowledge of STDIO, and thus is currently
 *	specific to KCC.  STDIO should provide a string-open function.
 *
 *	MAXSIGDIG must be set to at least the largest possible number of digits
 *	that can be output for any integer type, in order to avoid buffer
 *	overflow.  Making this dynamic is possible but would be extremely
 *	inefficient.  Floating point output will print "*" for any fields
 *	that would otherwise exceed MAXSIGDIG.  This constant (or something
 *	that it can be derived from) should be provided by c-env.h.
 *	Eventually the existence of the ANSI-draft <float.h> will provide
 *	useful constants that can be used here.
 *
 *	Floating-point output can be incorrect in the last digit (or two)
 *	if the user requests too great a precision, because the roundoff method
 *	fails when the hardware precision is exceeded.
 *	It would be possible to determine the max precision at runtime and
 *	then limit things to that, by modifying both prnd() and pff().
 *	Again, <float.h> will solve these problems.
 */
#ifdef COMMENT
Todo:
	Could improve efficiency of floating-point output stuff.
		e.g. prexp() is slow for large exponents.
	Conversion types could share more code at cost of some efficiency.

Routine provided to bind, unbind %-chars with routines.
(Also allow replacement of entire formatting scanner?)

int (*prf_bind)();		/* Returns previous binding value */

To bind:	prf_bind('i',prt_id);
To unbind:	prf_bind('i',0);
To replace scanner: prf_bind(0,prt_scan);
To restore scanner: prf_bind(0,0);

Conversion routine:
	prt_id(wp);			/* Pointer to workspace */

#endif /*COMMENT*/

#include <c-env.h>
#include <stdio.h>
#include <ctype.h>
#include <stdarg.h>
#include <printf.h>		/* To get workspace & routine defs */
#include <math.h>		/* For modf() and floor() */
#include <float.h>
#include <limits.h>
#include <string.h>

#if __STDC__
#define CONST const
#else
#define CONST
#endif

#define LONGISINT (LONG_MAX == INT_MAX)
#define SHORTISINT (SHRT_MAX == INT_MAX)
#define LDBLISDOUBLE (DBL_MANT_DIG == LDBL_MANT_DIG \
		&& DBL_MAX_EXP == LDBL_MAX_EXP)

#ifndef MAXSIGDIG
#define MAXSIGDIG 100
#endif


/* Imported routines */
extern char *calloc(), *realloc();
extern double modf(), floor();

/* Local routines */
static void prfill();
static void prfc(), prfs();
static void prfo(), prfx(), prfd(), prfu();
static void prff(), prfe(), prfg();
static void prfp(), prfn();

static void pflt();
static char *pd(),  *pu(), *po(),   *px(),  *pxu();
#if !LONGISINT
static char *pld(), *plu(), *plo(), *plx(), *plxu();
#endif
static char *pfi(), *pff(), *pexp();
static double prnd(), frexp10();

/* PRINTF - formatted output to stdout stream
*/
#if __STDC__
int printf(const char *format, ...)
#else
int
printf(format /*, ...*/)
char *format;
#endif
{
    va_list ap;
    int ret;

    va_start(ap, format);	/* Set up pointer to args */
    ret = vfprintf(stdout, format, ap);
    va_end(ap);
    return ret;
}

/* FPRINTF - formatted output to general FILE* stream
*/
#if __STDC__
int fprintf(FILE *stream, const char *format, ...)
#else
int
fprintf(stream, format /*, ...*/)
FILE *stream;
char *format;
#endif
{
    va_list ap;
    int ret;

    va_start(ap, format);	/* Set up pointer to args */
    ret = vfprintf(stream, format, ap);
    va_end(ap);
    return ret;
}

/* SPRINTF - formatted output to string
*/
#if __STDC__
int sprintf(char *s, const char *format, ...)
#else
int
sprintf(s, format /*, ...*/)
char *s;
char *format;
#endif
{
    va_list ap;
    int ret;

    va_start(ap, format);		/* Set up pointer to args */
    ret = vsprintf(s, format, ap);	/* output to string */
    va_end(ap);
    return ret;
}

/* VPRINTF - like PRINTF but with explicit arg list
*/
int
vprintf(format, ap)
CONST char *format;
va_list ap;
{
    return vfprintf(stdout, format, ap);
}

/* VSPRINTF - like SPRINTF but with explicit arg list
*/
int
vsprintf(s, format, ap)
char *s;
CONST char *format;
va_list ap;
{
    FILE *f;
    int ret;

    f = sopen(s, "w", 32767);		/* open string for output */
    ret = vfprintf(f, format, ap);	/* write to the string... */
    putc('\0', f);			/* null-terminate result */
    fclose(f);				/* "close" the string */
    return ret;
}

typedef void (*faddr)();	/* FADDR - function addr type */

/* For holding char bindings */
struct pf_bent {
	int pfe_type;	/* 0 - last entry */
	faddr pfe_rtn;
};

static struct pf_bent *_pfearray;
static int _pfecnt;

faddr
prf_bind(ch, rtn)
register int ch;
faddr rtn;
{	register struct pf_bent *ep;
	faddr ret;

	/* First see if char already exists */
	if(ep = _pfearray)
	  for(; ep->pfe_type; ++ep)
		if(ch == ep->pfe_type)
		  {	ret = ep->pfe_rtn;	/* Save old rtn val */
			if(rtn) ep->pfe_rtn = rtn;
			else ep->pfe_type = 0, ep->pfe_rtn = 0;
			return(ret);
		  }

	/* Not already in table, so add new entry. */
	if (ep)
	    ep = (struct pf_bent *) realloc((char *) _pfearray,
					++_pfecnt * sizeof(struct pf_bent));
	else
	    ep = (struct pf_bent *) calloc((_pfecnt=2),sizeof(struct pf_bent));
	_pfearray = ep;
	ep += _pfecnt-2;	/* Point to next-to-last entry */
	ep->pfe_type = ch;
	ep->pfe_rtn = rtn;
	(++ep)->pfe_type = 0;	/* Ensure last entry has zero type */
	return(0);
}

int
vfprintf(stream, format, vargp)
FILE *stream;
register CONST char *format;
va_list vargp;
{
    register int c;
    register struct pf_bent *ep;
    struct pf_work pfw;

    if (!_writeable(stream) || ferror(stream))
	return EOF;
    pfw.pfw_argp = vargp;	/* Set up pointer to args */
    pfw.pfw_fp = stream;
    pfw.pfw_cnt = 0;

    for (c = *format; c; c = *++format) {
	if (c != '%') {			/* If not start of a conversion, */
	    putc(c,stream);		/* just output quickly. */
	    pfw.pfw_cnt++;
	    continue;
	}

	/* Start handling % stuff! */

	/* First check for all optional flag chars */
	pfw.pfw_flag = 0;	/* Clear all flags */
	for (;;) {
	    switch (c = *++format) {
		case '-': pfw.pfw_flag |= PFF_NEG; continue;
		case '+': pfw.pfw_flag |= PFF_POS; continue;
		case '0': pfw.pfw_flag |= PFF_ZER; continue;
		case ' ': pfw.pfw_flag |= PFF_SPA; continue;
		case '#': pfw.pfw_flag |= PFF_ALT; continue;
		default: break;
	    }
	    break;		/* Break from switch is break from loop */
	}

	/* Set up fill char to use */
	pfw.pfw_fill = (pfw.pfw_flag & PFF_ZER) ? '0' : ' ';

	/* Get (optional) field width.
	** Note that if the '-' flag is given, left justification is always
	** done.  A negative '*' value merely (re)sets the PFF_NEG flag and
	** uses the abs value as the field width.  This is later negated
	** for left justification.
	*/
	if (c == '*') {
	    if ((pfw.pfw_fwid = va_arg(pfw.pfw_argp, int)) < 0) {
		pfw.pfw_flag |= PFF_NEG;	/* If neg, as if flag seen */
		pfw.pfw_fwid = -pfw.pfw_fwid;	/* with positive arg */
	    }
	    c = *++format;
	} else {
	    pfw.pfw_fwid = 0;		/* Initialize width */
	    while (isdigit(c)) {
		pfw.pfw_fwid = pfw.pfw_fwid * 10 + (c - '0');
		c = *++format;
	    }
	}
	if (pfw.pfw_flag&PFF_NEG)		/* If left justifying,  use */
	    pfw.pfw_fwid = -pfw.pfw_fwid;	/* negative field width */

	/* Get (optional) precision */
	if (c == '.') {
	    if((c = *++format) == '*') {
		pfw.pfw_prec = va_arg(pfw.pfw_argp, int);
		c = *++format;
	    } else {			/* Prec given, initialize and parse */
		pfw.pfw_prec = 0;
		while (isdigit(c)) {
		    pfw.pfw_prec = pfw.pfw_prec * 10 + (c - '0');
		    c = *++format;
		}
	    }
	} else pfw.pfw_prec = -1;		/* No precision given */

#if 0
	/* 4.2BSD used to have its '#' alternate-form flag, if present,
	** come after the precision.  This was fixed in 4.3BSD and so the
	** following check is no longer used.
	*/
	if (c == '#') {
	    pfw.pfw_flag |= PFF_ALT;
	    c = *++format;
	}
#endif

	/* Now check for (optional) modifiers */
	switch (c) {
	    case 'h': pfw.pfw_flag |= PFF_SHORT; c = *++format; break;
	    case 'l': pfw.pfw_flag |= PFF_LONG;  c = *++format; break;
	    case 'L': pfw.pfw_flag |= PFF_FLONG; c = *++format; break;
	}

	/* That was the last place in this file that we need to set the
	** modifier flags regardless of whether they are meaningful (so that
	** any dynamic bindings can see them).  Now zap any flags which
	** are redundant (same type as default) so that the compiler can
	** avoid compiling needless code from here on.
	*/
#if LONGISINT
#undef PFF_LONG
#define PFF_LONG 0
#endif
#if SHORTISINT
#undef PFF_SHORT
#define PFF_SHORT 0
#endif
#if LDBLISDOUBLE
#undef PFF_FLONG
#define PFF_FLONG 0
#endif

	/* Now handle the (required) conversion operation.
	** First scan dynamic %-char array to see if there
	** is any match, since those take precedence.
	*/
	pfw.pfw_char = c;	/* Store conversion operation char */
	if (ep = _pfearray) {
	    for (; ep->pfe_type; ++ep)
		if (ep->pfe_type == c)
		    break;
	    if (ep->pfe_type) {
		(*(ep->pfe_rtn))(&pfw);	/* Found it, invoke! */
		continue;		/* Then resume main loop! */
	    }
	}

	/* No match in the array, check standard built-in chars */
	switch (c) {
	case '%': prfill(&pfw, (char *)0, "%", 1, 0); break;

	case 'c': prfc(&pfw); break;	/* Char and string output */
	case 's': prfs(&pfw); break;

	case 'o': prfo(&pfw); break;	/* Integer output */
	case 'X':
	case 'x': prfx(&pfw); break;
	case 'u': prfu(&pfw); break;
	case 'i':
	case 'd': prfd(&pfw); break;

	case 'f': prff(&pfw); break;	/* Floating output */
	case 'E':
	case 'e': prfe(&pfw); break;
	case 'G':
	case 'g': prfg(&pfw); break;

	case 'p': prfp(&pfw); break;	/* ANSI: Pointer output */
	case 'n': prfn(&pfw); break;	/* ANSI: Set count */

	/* Unknown conversion char, print error msg */
	default:
	    fputs("(printf: '", pfw.pfw_fp);
	    putc(c, pfw.pfw_fp);
	    fputs("'?)", pfw.pfw_fp);
	    pfw.pfw_cnt += 14;
	    break;
	}
    }	/* End of %-handling, loop back to main scanner */

    /* Return EOF if any error, else # chars output */
    return ferror(pfw.pfw_fp) ? EOF : pfw.pfw_cnt;
}

/* PRFILL - General-purpose routine to handle field padding.
 */
static void
prfill(wp, pref, cval, clen, precf)
register struct pf_work *wp;
char *pref;	/* Prefix string (may be null ptr) */
char *cval;	/* Converted value string (must exist) */
int clen;	/* Length of value string */
int precf;	/* Additional precision fill (always >= 0) */
{	register int i;
	register int plen;	/* Length of prefix string if one */
	int fwid, totlen;

	plen = pref ? strlen(pref) : 0;
	wp->pfw_cnt += (totlen = precf + plen + clen);	/* Find # chars */

	if((fwid = wp->pfw_fwid) <= 0)
	  {	/* Left justified or no field */
		if(plen) fputs(pref, wp->pfw_fp);
		if((i = precf) > 0) {
			do putc('0', wp->pfw_fp);
			while(--i);
		}
		fputs(cval, wp->pfw_fp);
		if(fwid >= 0) return;	/* If no field width, done! */

		i = (-fwid) - totlen;
		if(i > 0) {
			wp->pfw_cnt += i;
			do putc(' ', wp->pfw_fp);
			while(--i);
		}
	  }
	else	/* Right justification */
	  {	
		if ((i = fwid - totlen) > 0)
			wp->pfw_cnt += i;	/* This much left padding */

		/* Do either 0-padding or SP-padding */
		if(i > 0 && (wp->pfw_flag&PFF_ZER)==0) {
			do putc(' ', wp->pfw_fp);
			while(--i);
		}
		if(plen) fputs(pref, wp->pfw_fp);
		if(i > 0 && (wp->pfw_flag&PFF_ZER)!=0) {
			do putc('0', wp->pfw_fp);
			while(--i);
		}

		if((i = precf) > 0) {
			do putc('0', wp->pfw_fp);
			while(--i);
		}
		fputs(cval, wp->pfw_fp);
	  }
}

/* PRFN - 'n' Return output count
*/
static void
prfn(wp)
register struct pf_work *wp;
{
    if (!(wp->pfw_flag&(PFF_SHORT|PFF_LONG)))
	*(va_arg(wp->pfw_argp, int *)) = wp->pfw_cnt;
    else if (wp->pfw_flag & PFF_LONG)
	*(va_arg(wp->pfw_argp, long *)) = wp->pfw_cnt;
    else *(va_arg(wp->pfw_argp, short *)) = wp->pfw_cnt;
}

/* Character and String conversions */

/* PRFC - 'c' Character output
**	Only uses field width and the flags '-' and '0'.
** NOTE: ANSI does not define the behavior for the '0' flags, but H&S
** claims this causes '0' to be used as the fill character.  Rather than
** be picky, we permit this.
*/
static void
prfc(wp)
register struct pf_work *wp;
{	char tmpbuf[2];

	tmpbuf[0] = va_arg(wp->pfw_argp, int);
	tmpbuf[1] = '\0';
	prfill(wp, (char *)0, tmpbuf, 1, 0);
}

/* PRFS - 's' String output
**	Uses field width, precision, and flags '-', '0'.
**	Positive precision truncates length to that value.
** NOTE: situation with the '0' flag is same as for 'c'.
*/
static void
prfs(wp)
struct pf_work *wp;
{
	register char *cp;
	register int len, i;
	int trunc;

	cp = va_arg(wp->pfw_argp, char *);	/* Get pointer to string */
	if(cp == (char *)0)
		cp = "(null)";			/* Be kind to zero ptrs */
	len = strlen(cp);			/* Find length of string */

	/* Special fast check for usual case of %s */
	if(wp->pfw_fwid == 0 && wp->pfw_prec <= 0)
	  {	fputs(cp, wp->pfw_fp);		/* Left adj, no prec */
		wp->pfw_cnt += len;
		return;			
	  }

	/* Check length against precision to see if truncation needed */
	trunc = 0;
	if(wp->pfw_prec > 0 && wp->pfw_prec < len)
	  {	len = wp->pfw_prec;
		trunc++;	/* Sigh, remember to truncate string */
	  }

	/* See whether to prepad */
	if((i = wp->pfw_fwid - len) > 0)
	  {	wp->pfw_cnt += i;
		do putc(wp->pfw_fill, wp->pfw_fp);
		while(--i);
	  }

	/* Now output string */
	wp->pfw_cnt += len;
	if(!trunc) fputs(cp, wp->pfw_fp);
	else if((i = len) > 0)
	  {	do putc(*cp++, wp->pfw_fp);
		while(--i);
	  }

	/* Now postpad if necessary */
	if(wp->pfw_fwid < 0 && (i = -(wp->pfw_fwid) - len) > 0)
	  {	wp->pfw_cnt += i;
		do putc(' ', wp->pfw_fp);
		while(--i);
	  }
}

/* Pointer conversion */

/* PRFP - 'p' pointer representation output
**
*/
static void
prfp(wp)
register struct pf_work *wp;
{
    if (sizeof(int) == sizeof(void *)) {
#if !LONGISINT
	wp->pfw_flag &= ~PFF_LONG;
#endif
	prfo(wp);
    }
#if !LONGISINT
    else if (sizeof(long) == sizeof(void *)) {
	wp->pfw_flag |= PFF_LONG;
	prfo(wp);
    }
#endif
    else prfill(wp, (char *)NULL, "(can't)", 7, 0);
}

/* Integer conversions */

/* PRFD - 'd' and 'i' Signed Decimal number output
**	
*/
static void
prfd(wp)
register struct pf_work *wp;
{
	char *cp;
	char tmpbuf[MAXSIGDIG];
	int arg, i, len;
	char *pref;

	pref = NULL;
#if !LONGISINT
	if(wp->pfw_flag&PFF_LONG)
	  {	if((larg = va_arg(wp->pfw_argp, long)) < 0)
		  {	pref = "-";
			larg = -larg;
		  }
		if (larg == -larg) cp = plu(tmpbuf, larg); /* Handle max neg */
		else cp = pld(tmpbuf, larg);
	  }
	else
#endif
	  {
#if !SHORTISINT
		if (wp->pfw_flag & PFF_SHORT)
		    arg = va_arg(wp->pfw_argp, short);
		else
#endif
		    arg = va_arg(wp->pfw_argp, int);
		if (arg < 0)
		  {	pref = "-";
			arg = -arg;
		  }
		if (arg == -arg) cp = pu(tmpbuf, arg);	/* Handle max neg */
		else cp = pd(tmpbuf, arg);
	  }
	len = cp - tmpbuf;
	*++cp = '\0';		/* Tie off result */

	if(!pref)
	  {	if     (wp->pfw_flag&PFF_POS) pref = "+";
		else if(wp->pfw_flag&PFF_SPA) pref = " ";
	  }

	if ((i = wp->pfw_prec) >= 0) {	/* Precision given? */
	    wp->pfw_flag &= ~PFF_ZER;	/* Ignore '0' flag */
	    if (i == 0 && tmpbuf[1] == '0')	/* Special case */
		tmpbuf[1] = '\0';		/* can produce null string */
	    else i = wp->pfw_prec - len;
	}
	prfill(wp, pref, tmpbuf+1, len, i < 0 ? 0 : i);
}


/* PRFO - 'o' Octal number output
**	
**	# flag ensures that number starts with '0'.
**	+ and SP flags ignored.
*/
static void
prfo(wp)
register struct pf_work *wp;
{
	register int len, prec;
	register char *cp;
	char tmpbuf[MAXSIGDIG];		/* For bare-bones octal string */

	if (!(wp->pfw_flag&(PFF_SHORT|PFF_LONG)))
		cp = po(tmpbuf, va_arg(wp->pfw_argp, unsigned int));
#if !LONGISINT
	else if (wp->pfw_flag & PFF_LONG)
		cp = plo(tmpbuf, va_arg(wp->pfw_argp, unsigned long));
#endif
	else	cp = po(tmpbuf, (unsigned short)va_arg(wp->pfw_argp, unsigned int));

	len = cp - tmpbuf;
	*++cp = '\0';		/* Tie off result */

    /* If no precision was specified, 1 is used as default, but there's no
    ** need to set this explicitly since the code gives prfill the right stuff.
    */
	if ((prec = wp->pfw_prec) >= 0) {	/* User specified precision? */
	    wp->pfw_flag &= ~PFF_ZER;		/* Yes, ignore '0' flag */
	    if (prec == 0			/* Check for case of 0 prec */
	       && tmpbuf[1] == '0') {		/* and 0 arg, which */
		tmpbuf[1] = '\0';		/* produces null string! */
		len = 0;
	    } else if ((prec -= len) < 0)	/* Turn positive prec into */
		prec = 0;			/* # of leading 0s to use */
	} else prec = 0;

    /* Check for '#' flag hackery */
	if ((wp->pfw_flag & PFF_ALT)	/* Special hack for %o */
	  && prec < 1			/* If precision maybe not big enuf */
	  && tmpbuf[1] != '0')		/* and doesn't already start with 0 */
		++prec;			/* bump to force a leading 0! */

	prfill(wp,		/* Workspace ptr */
		(char *)0,	/* Prefix */
		tmpbuf+1,	/* Converted val */
		len,		/* Length of converted str */
		prec);		/* # of additional precision digits */
}

/* PRFX - 'x' and 'X' Hexadecimal number output
**	
*/
static void
prfx(wp)
register struct pf_work *wp;
{
	register int i, len;
	char *cp;
	char tmpbuf[MAXSIGDIG];

	if (!(wp->pfw_flag&(PFF_SHORT|PFF_LONG)))
	  {	if(wp->pfw_char == 'X')
			cp = pxu(tmpbuf, va_arg(wp->pfw_argp, unsigned int));
		else    cp = px (tmpbuf, va_arg(wp->pfw_argp, unsigned int));
	  }
#if !LONGISINT
	else if (wp->pfw_flag&PFF_LONG)
	  {	if(wp->pfw_char == 'X')
			cp = plxu(tmpbuf, va_arg(wp->pfw_argp, unsigned long));
		else    cp = plx (tmpbuf, va_arg(wp->pfw_argp, unsigned long));
	  }
#endif
	else
	  {	if(wp->pfw_char == 'X')
			cp = pxu(tmpbuf, (unsigned short)va_arg(wp->pfw_argp, unsigned int));
		else    cp = px (tmpbuf, (unsigned short)va_arg(wp->pfw_argp, unsigned int));
	  }
	len = cp - tmpbuf;
	*++cp = '\0';		/* Tie off result */

	if ((i = wp->pfw_prec) >= 0) {	/* Precision given? */
	    wp->pfw_flag &= ~PFF_ZER;	/* Ignore '0' flag */
	    if (i == 0 && tmpbuf[1] == '0')	/* Special case */
		tmpbuf[1] = '\0';		/* can produce null string */
	    else i = wp->pfw_prec - len;
	}

	prfill(wp,
		(((wp->pfw_flag&PFF_ALT) && tmpbuf[1] != '0') ?
			((wp->pfw_char == 'X') ? "0X" : "0x")
			: (char *) 0),
		tmpbuf+1,
		len,
		i < 0 ? 0 : i);
}

/* PRFU - 'u' Unsigned decimal number output
 *	
 */
static void
prfu(wp)
register struct pf_work *wp;
{
	register int i, len;
	char *cp;
	char tmpbuf[MAXSIGDIG];

#if !LONGISINT
	if(wp->pfw_flag&PFF_LONG)
		cp = plu(tmpbuf, va_arg(wp->pfw_argp, unsigned long));
	else
#endif
	     if (wp->pfw_flag&PFF_SHORT)
		cp = pu (tmpbuf, (short)va_arg(wp->pfw_argp, unsigned int));
	else    cp = pu (tmpbuf, va_arg(wp->pfw_argp, unsigned int));
	len = cp - tmpbuf;
	*++cp = '\0';		/* Tie off result */

	if ((i = wp->pfw_prec) >= 0) {	/* Precision given? */
	    wp->pfw_flag &= ~PFF_ZER;	/* Ignore '0' flag */
	    if (i == 0 && tmpbuf[1] == '0')	/* Special case */
		tmpbuf[1] = '\0';		/* can produce null string */
	    else i = wp->pfw_prec - len;
	}
	prfill(wp, (char *)0, tmpbuf+1, len, i < 0 ? 0 : i);
}

/* Actual number conversion subroutines.
**	All of these routines take two arguments:
**	"s" - pointer to last location deposited into.  New string will
**		be added just after that, WITHOUT a trailing null char.
**	"n" - value to convert.
** The return value will be a pointer to the last character deposited.
** The caller must null-terminate the string if desired.
*/

static
#if CPU_PDP10
	int		/* Use more efficient addressing on PDP10s */
#else
	char
#endif
    pntab[16] = {
	'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f' },
    pxtab[16] = {
	'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F' };


static char *
pd(s, n)		/* Decimal */
char *s;
int n;
{
    int d = n % 10;		/* Get low digit */
    if (n/10) s = pd(s, n/10);	/* Do high order digits */
    *++s = pntab[d];		/* Output low digit */
    return s;
}


#if !LONGISINT
static char *
pld(s, n)		/* Long Decimal */
char *s;
long n;
{
    int d = n % 10;		/* Get low digit */
    if (n/10) s = pld(s, n/10);	/* Do high order digits */
    *++s = pntab[d];		/* Output low digit */
    return s;
}
#endif

static char *
pu(s, n)		/* Unsigned Decimal */
char *s;
unsigned int n;
{
    int d = n % 10;		/* Get low digit */
    if (n/10) s = pd(s, (int)(n/10));	/* Now can do high digits signed for speed! */
    *++s = pntab[d];		/* Output low digit */
    return s;
}

#if !LONGISINT
static char *
plu(s, n)		/* Long Unsigned Decimal */
char *s;
unsigned long n;
{
    int d = n % 10;		/* Get low digit */
    if (n/10) s = pld(s, n/10);	/* Now can do high digits signed for speed! */
    *++s = pntab[d];		/* Output low digit */
    return s;
}
#endif

static char *
po(s, n)		/* Octal */
char *s;
unsigned int n;
{
    if (n &~ 07) s = po(s, n >> 3);	/* Do high order digits */
    *++s = pntab[n & 07];	/* Output low digit */
    return s;
}

#if !LONGISINT
static char *
plo(s, n)		/* Long Octal */
char *s;
unsigned long n;
{
    if (n &~ 07) s = plo(s, n >> 3);	/* do high order digits */
    *++s = pntab[n & 07];		/* bottom digit */
    return s;
}
#endif

static char *
px(s, n)		/* Hexadecimal */
char *s;
unsigned int n;
{
    if (n & ~(0xF)) s = px(s, n >> 4);	/* do high order digits */
    *++s = pntab[n & 0xF];		/* Do bottom digit */
    return s;
}

#if !LONGISINT
static char *
plx(s, n)		/* Long Hexadecimal */
char *s;
unsigned long n;
{
    if (n & ~(0xF)) s = plx(s, n >> 4);	/* do high order digits */
    *++s = pntab[n & 0xF];	/* Do bottom digit */
    return s;
}
#endif

static char *
pxu(s, n)		/* Hexadecimal Uppercase */
char *s;
unsigned int n;
{
    if (n & ~(0xF)) s = pxu(s, n >> 4);	/* do high order digits */
    *++s = pxtab[n & 0xF];		/* Do bottom digit */
    return s;
}

#if !LONGISINT
static char *
plxu(s, n)		/* Long Hexadecimal Uppercase */
char *s;
unsigned long n;
{
    if (n & ~(0xF)) s = plxu(s, n >> 4);	/* do high order digits */
    *++s = pxtab[n & 0xF];		/* Do bottom digit */
    return s;
}
#endif

/* Floating-point number conversions */

/* PRFF - 'f' format output
 */
static void
prff(wp)
struct pf_work *wp;
{	pflt(wp, 0);		/* Invoke general routine with right flag */
}

/* PRFE - 'e' format output
 */
static void
prfe(wp)
struct pf_work *wp;
{	pflt(wp, 1);		/* Invoke general routine with right flag */
}

/* PRFG - 'g' format output
 */
static void
prfg(wp)
struct pf_work *wp;
{	pflt(wp, -1);		/* Invoke general routine with right flag */
}

/* PFLT - auxiliary to do 'f', 'e', or 'g' format output
 *	eflg:	-1 for G format
 *		 0 for F format
 *		+1 for E format
 */
static void
pflt(wp, eflg)
struct pf_work *wp;
int eflg;
{	/* Allow MAXSIGDIG for each of integer, fraction, and exponent */
	/* plus decimal point (.) and exponent (E+) and terminator */
	char tmpbuf[MAXSIGDIG*3+4];
	register char *cp = tmpbuf;
	char *pref;
	int exp, gflg;
	double arg, frarg;
	static double dzero = 0.0;

	if (wp->pfw_prec < 0)
		wp->pfw_prec = 6; /* digits after point */

	arg = va_arg(wp->pfw_argp, double);
	if(arg < 0)
	  {	pref = "-";
		arg = -arg;
	  }
	else
	  {	if     (wp->pfw_flag&PFF_POS) pref = "+";
		else if(wp->pfw_flag&PFF_SPA) pref = " ";
		else pref = 0;
	  }
#if CPU_PDP10		/* Check for properly normalized argument */
	if (arg && !((*(int *)&arg) & (1<<(FLT_MANT_DIG-1)))) {
	    arg += dzero;	/* Normalize the arg */
	    *++cp = '#';	/* and report by starting string with flag */
	}
#endif

	if(eflg > 0)		/* If E fmt */
	  {	gflg = 0;	/* Not G fmt */

		/* Split number into fraction and exponent */
		if((frarg = frexp10(arg, &exp)) != 0.0)
		  {	/* Adj to have 1 digit ahead of pt, and round off. */
			exp--;
		  }
	  }
	else if(eflg < 0)	/* If G fmt */
	  {	gflg = 1;
		if(wp->pfw_prec > 0)		/* G format bumps prec */
			--(wp->pfw_prec);	/*  down for internal use */

		/* Split number into fraction and exponent */
		frarg = frexp10(arg, &exp);

		/* Now check exponent value to determine which format to use.
		 * Note value of 0.0 will always win even though exponent
		 * is incorrectly munged to -1, because F format will be
		 * selected instead of E.
		 */
		--exp;		/* Get actual exponent we'd use */
		eflg = (exp < -4 || wp->pfw_prec < exp); /* TRUE if E fmt */

		if(!eflg)
			wp->pfw_prec -= exp;	/* Adjust precision for F */
	  }
	else			/* F format */
	  {	gflg = 0;
	  }

	/* Round off to desired precision */
	arg = prnd((eflg ? frarg*10.0	/* E uses bumped fraction */
			 : arg),	/* F uses original arg */
			wp->pfw_prec);

	/* Now deposit string to represent the number.
	 * Both pfi and pff limit their output to MAXSIGDIG digits.
	 */
	cp = pfi(arg, cp);			/* Deposit integer */
	if(wp->pfw_prec != 0 || (wp->pfw_flag&PFF_ALT) || gflg)
		cp = pff(arg, cp, wp->pfw_prec);	/* Deposit fraction */

	/* Now, if PFF_ALT is NOT set for G fmt, must strip trailing zeros */
	if(gflg && (wp->pfw_flag&PFF_ALT)==0)
	  {	while(*cp == '0') --cp;
		if(*cp == '.') --cp;	/* Flush point too if run into it */
	  }

	if(eflg)
	  {	/* Now finish off with exponent */
		if(isupper(wp->pfw_char)) *++cp = 'E';
		else *++cp = 'e';
		cp = pexp(exp, cp);
	  }
	*++cp = '\0';			/* Finalize string */

	prfill(wp, pref, tmpbuf+1, cp - (tmpbuf+1), 0);
}

/* Floating-point auxiliary routines */

/* PRND - Round number to desired precision.
 *	prec - # of digits to right of decimal point.
 *	Method is to add 0.5 * 10^(-prec)
 *	e.g. if prec is 2, want round to .nn so we add .005 to number.
 */
static double
prnd(d, prec)
double d;
int prec;
{	double rndoff;

#ifdef COMMENT
/* This is not completely thought out; needs coordination with pff */
	static int maxprec = 0;
	static double minrnd;
	while(prec > maxprec)
	  {
		if(maxprec)		/* See if already initialized */
			return(d+minrnd);	/* Yes, fast return */

		/* No, find what our maximum precision is */
		rndoff = 0.5;
		do {	minrnd = rndoff;
			rndoff /= 10.0;
			++maxprec;
		  } while((1.0 + rndoff) > 1.0);
		--maxprec;
	  }
#endif /*COMMENT*/
    rndoff = 0.5;
    while (--prec >= 0)
	if ((rndoff /= 10.0) > 1.0)	/* If roundoff value underflows, */
	    return d;			/* then no rounding. */
    return (d+rndoff);
}

/* PFI - print integer part of a double.
 *	Cannot use a single modf call because the integer part may
 *	be larger than an int.  We also want to avoid depending on
 *	any guess about how many digits an int can hold, so we end
 *	up calling modf on each digit.
 *	If # digits is greater than limit, "*" will be output.
 */
static char *
pfi(d, s)
double d;
char *s;
{	double i;
	int exp;

	d = floor(d) + 0.5;	/* Ensure we'll round the integer correctly */
	d = frexp10(d, &exp);	/* Find # digits to left (exponent) */
	if(exp > MAXSIGDIG)
		*++s = '*';
	else if(exp > 0)
		while(--exp >= 0)
		  {	d = modf(d * 10.0, &i);
			*++s = pntab[(int)i];
		  }
	else *++s = '0';
	return s;
}

/* PFF - Print fractional part of a double.
 *	If precision is zero or negative, only a decimal point is printed.
 */
static char *
pff(d, cp, prec)
double d;
register char *cp;
int prec;
{	double junk;

	*++cp = '.';
	d = modf(d, &junk);		/* Get fractional part */

	if(prec > MAXSIGDIG)
		*++cp = '*';
	else while(prec-- > 0)
	  {	d = modf(d*10.0, &junk);
		*++cp = pntab[(int)junk];
	  }
	return cp;
}

/* PEXP - print exponent
 */
static char *
pexp(exp, cp)
int exp;
char *cp;
{	
	if(exp < 0)
	  {	exp = -exp;
		*++cp = '-';
	  }
	else *++cp = '+';
	if(exp >= 100) cp = pd(cp, exp);
	else	/* Must always print at least 2 digits of exponent */
	  {	*++cp = pntab[exp/10];
		*++cp = pntab[exp%10];
	  }
	return cp;
}

/* FREXP10 - like "frexp" but exponent is base 10 and returns
 *	1.0 > result >= .1
 *	Arg must be positive.
 */
static double
frexp10(d, ip)
double d;
int *ip;
{	register int i;

	i = 0;
	if (d >= 1.0)
	    for(; d >= 1.0; ++i)	/* Divide until within range */
		d /= 10.0;
	else for(; d && d < 0.1; --i)	/* Multiply until within range */
		d *= 10.0;
	*ip = i;
	return(d);
}
