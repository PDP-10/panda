/*
 *	Parse a makefile
 */

#include "h.h"

NAME namehead;
NAMEP firstname;

char str1[MAXSTRING];		/* global store */
static char str2[MAXSTRING];	/* str2 needed only here */


/*
 *	Intern a name.  Return a pointer to the name struct
 */
NAMEP
newname(name)
char *name;
{
    register NAMEP rp;
    register NAMEP rrp;


    for
	(
	 rp = namehead.n_next, rrp = &namehead;
	 rp;
	 rp = rp->n_next, rrp = rrp->n_next
	)
	if (strcmp(name, rp->n_name) == 0)
	    return rp;

    if ((rp = (NAMEP) malloc(sizeof(NAME))) == NULL_NAMEP)
	fatal("No memory for name");
    rrp->n_next = rp;
    rp->n_next = NULL_NAMEP;

    rp->n_name = newstring(NULL_CHARP, name);
    rp->n_line = NULL_LINEP;
    rp->n_time = NOTIME;
    rp->n_flag = (uchar) 0;

    return rp;
}


/*
 *	Add a dependant to the end of the supplied list of dependants.
 *	Return the new head pointer for that list.
 */
DEPENDP
newdep(np, dp)
NAMEP np;
DEPENDP dp;
{
    register DEPENDP rp;
    register DEPENDP rrp;


    if ((rp = (DEPENDP) malloc(sizeof(DEPEND))) == NULL_DEPENDP)
	fatal("No memory for dependant");
    rp->d_next = NULL_DEPENDP;
    rp->d_name = np;

    if (dp == NULL_DEPENDP)
	return rp;

    for (rrp = dp; rrp->d_next; rrp = rrp->d_next)
	;

    rrp->d_next = rp;

    return dp;
}


/*
 *	Add a command to the end of the supplied list of commands.
 *	Return the new head pointer for that list.
 */
CMDP
newcmd(str, cp)
char *str;
CMDP cp;
{
    register CMDP rp;
    register CMDP rrp;
    register char *rcp;


    if (rcp = rindex(str, '\n'))
	*rcp = '\0';		/* Loose newline  */

    while (isspace(*str))
	str++;

    if (*str == '\0')		/* If nothing left, the exit  */
	return ((CMDP) NULL);

    if ((rp = (CMDP) malloc(sizeof(CMD))) == NULL_CMDP)
	fatal("No memory for command");
    rp->c_next = NULL_CMDP;
    rp->c_cmd = newstring(NULL_CHARP, str);

    if (cp == NULL_CMDP)
	return rp;

    for (rrp = cp; rrp->c_next; rrp = rrp->c_next)
	;

    rrp->c_next = rp;

    return cp;
}


/*
 *	Add a new 'line' of stuff to a target.  This check to see
 *	if commands already exist for the target.  If flag is set,
 *	the line is a double colon target.
 *
 *	Kludges:
 *	i)  If the new name begins with a '.', and there are no dependents,
 *	    then the target must cease to be a target.  This is for .SUFFIXES.
 *	ii) If the new name begins with a '.', with no dependents and has
 *	    commands, then replace the current commands.  This is for
 *	    redefining commands for a default rule.
 *	Neither of these free the space used by dependents or commands,
 *	since they could be used by another target.
 */
void
newline(np, dp, cp, flag)
NAMEP np;
DEPENDP dp;
CMDP cp;
bool flag;
{
    bool hascmds = FALSE;	/* Target has commands  */
    register LINEP rp;
    register LINEP rrp;


    /* Handle the .SUFFIXES case */
    if (np->n_name[0] == '.' && !dp && !cp)
    {
	for (rp = np->n_line; rp; rp = rrp)
	{
	    rrp = rp->l_next;
	    free((char *) rp);
	}
	np->n_line = NULL_LINEP;
	np->n_flag &= ~N_TARG;
	return;
    }

    /* This loop must happen since rrp is used later. */
    for
	(
	 rp = np->n_line, rrp = NULL_LINEP;
	 rp;
	 rrp = rp, rp = rp->l_next
	)
	if (rp->l_cmd)
	    hascmds = TRUE;

    if (hascmds && cp && !(np->n_flag & N_DOUBLE))
	/* Handle the implicit rules redefinition case */
	if (np->n_name[0] == '.' && dp == NULL_DEPENDP)
	{
	    np->n_line->l_cmd = cp;
	    return;
	}
	else
	{
	    sprintf(str1, "Commands defined twice for target %s",
		    np->n_name);
	    error(str1);
	}
    if (np->n_flag & N_TARG)
	if (!(np->n_flag & N_DOUBLE) != !flag)	/* like xor */
	{
	    sprintf(str1, "Inconsistent rules for target %s", np->n_name);
	    error(str1);
	}

    if ((rp = (LINEP) malloc(sizeof(LINE))) == NULL_LINEP)
	fatal("No memory for line");
    rp->l_next = NULL_LINEP;
    rp->l_dep = dp;
    rp->l_cmd = cp;

    if (rrp)
	rrp->l_next = rp;
    else
	np->n_line = rp;

    np->n_flag |= N_TARG;
    if (flag)
	np->n_flag |= N_DOUBLE;
}


/*
 *	Parse input from the makefile, and construct a tree structure
 *	of it.
 */
void
input(fd)
FILE *fd;
{
    char *p;
    char *q;
    NAMEP np;
    DEPENDP dp;
    CMDP cp;
    bool dbl;


    if (getline(str1, fd))	/* Read the first line and */
	return;			/* quit if file is empty */

    for (;;)
    {
	if (*str1 == TAB)	/* Rules without targets  */
	    error("Rules not allowed here");

	p = str1;

	while (isspace(*p))	/* Find first target  */
	    p++;

	/* Collect macro name. */

	while (((q = index(p, '=')) != NULL_CHARP) &&
	       (p != q) && (q[-1] == '\\'))	/* Find value */
	    p = q + 1;		/* point past "\=" */

	if (q != NULL_CHARP)
	{
	    register char *a;

	    *q++ = '\0';	/* Separate name and val  */
	    while (isspace(*q))
		q++;
	    if (p = rindex(q, '\n'))
		*p = '\0';

	    p = str1;
	    squeeze(p);

	    /* Don't squeeze q (macro value)--it will get squeeze'd later
	       after macro substitution */

	    if ((a = gettok(&p)) == NULL_CHARP)
		error("No macro name");

	    (void) setmacro(a, q, TEMPORARY);

	    if (getline(str1, fd))
		return;
	    continue;
	}

	/* Collect dependent names. */

	expand(str1);
	p = str1;

	while (((q = index(p, ':')) != NULL_CHARP) &&
	       (p != q) && (q[-1] == '\\'))	/* Find dependents  */
	    p = q + 1;		/* point past "\:" */

	if (q == NULL_CHARP)
	    error("No targets provided");

	*q++ = '\0';		/* Separate targets and dependents  */

	if (*q == ':')		/* Double colon */
	{
	    dbl = TRUE;
	    q++;
	}
	else
	    dbl = FALSE;

	while (isspace(*q))	/* advance to first non-space in */
	    ++q;		/* dependent list */

	squeeze(q);

	cp = NULL_CMDP;
	dp = NULL_DEPENDP;

	if (*q == ';')		/* have TARGET:; RULE */
	    cp = newcmd(q + 1, cp);
	else			/* have TARGET: dependent list */
	    for ( /* NO-OP */ ; ((p = gettok(&q)) != NULL_CHARP);)
		/* get list of dep's */
	    {
		np = newname(p);/* Intern name  */
		dp = newdep(np, dp);	/* Add to dep list */
	    }

	/* Collect following rule lines. */

	if (getline(str2, fd) == FALSE)	/* Get commands  */
	{
	    while (*str2 == TAB)
	    {
		cp = newcmd(&str2[0], cp);
		if (getline(str2, fd))
		    break;
	    }
	}

	/* Collect target names. */

	squeeze(str1);

	str1[strlen(str1) + 1] = '\0';	/* Need two NULs for gettok() */
	q = str1;
	while ((p = gettok(&q)) != NULL_CHARP)	/* Get target list */
	{
	    np = newname(p);	/* Intern name  */
	    newline(np, dp, cp, dbl);
	    if (!firstname && p[0] != '.')
		firstname = np;
	}

	if (feof(fd))		/* EOF?  */
	    return;

	strcpy(str1, str2);
    }
}

void
squeeze(s)
register char *s;
/**
 ** Expand standard C escape sequences in-place in the argument
 ** string.  The valid escapes are:
 **
 ** 	\n	LF, newline
 ** 	\t	HT, horizontal tab
 ** 	\b	BS, backspace
 ** 	\r	CR, carriage return
 ** 	\f	FF, formfeed
 ** 	\\	\, backslash
 ** 	\'	', single quote
 ** 	\ddd	ddd, character corresponding to 1, 2, or 3 octal digit
 ** 		bit pattern.
 **
 ** Any other backslash-char pair is reduced to char.
 **/
{
    register int c;
    register int k;
    register char *result;
    char *original;

    original = s;

    if (debug)
    {				/* use fputs() instead of printf()--VAX VMS
				   printf() fails with */
	/* long strings, sigh... */
	fputs("SQUEEZE[", stderr);
	fputs(s, stderr);
	fputs("] ->\n", stderr);
    }
    for (result = s; *s; /* NO-OP */ )
    {
	if (*s != '\\')
	    *result++ = *s;
	else			/* have backslashed character */
	{
	    switch (*(++s))
	    {
	    case '\0':		/* end of string reached */
		break;

	    case '0':
	    case '1':
	    case '2':
	    case '3':
	    case '4':
	    case '5':
	    case '6':
	    case '7':
		c = (int) ((*s) - '0');
		for (k = 0; k < 2; ++k)
		{		/* collect octal digit string */
		    ++s;
		    if (('0' <= (*s)) && ((*s) <= '7'))
			c = 8 * c + (int) ((*s) - '0');
		    else	/* advanced past octal digit */
		    {
			--s;
			break;
		    }
		}
		*result++ = (char) c;
		break;

	    case 'n':
		*result++ = '\n';
		break;

	    case 't':
		*result++ = TAB;
		break;

	    case 'b':
		*result++ = '\b';
		break;

	    case 'r':
		*result++ = '\r';
		break;

	    case 'f':
		*result++ = '\f';
		break;

	    case '\\':
		*result++ = '\\';
		break;

	    case '\'':
		*result++ = '\'';
		break;

	    default:		/* \x becomes x for all other x's */
		*result++ = *s;
		break;
	    }
	}
	if (*s)
	    ++s;
    }
    *result = '\0';

    if (debug)
    {				/* use fputs() instead of printf()--VAX VMS
				   printf() fails with */
	/* long strings, sigh... */
	fputs("       [", stderr);	/* line up with "SQUEEZE[" */
	fputs(original, stderr);
	fputs("]\n", stderr);
    }
}
