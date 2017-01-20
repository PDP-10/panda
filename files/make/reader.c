/*
 *	Read in makefile
 */


#include "h.h"


int lineno;


/*
 *	Syntax error handler.  Print message, with line number, and exits.
 */
void
error(msg)
char *msg;
{
    static bool entered = FALSE;

    if (entered)		/* unexpected recursive entry */
	EXIT(1);
    entered = TRUE;

    fprintf(stderr, "%s: ", myname);
    fprintf(stderr, msg);
    if (lineno)
	fprintf(stderr, " near line %d", lineno);
    fputc('\n', stderr);
    if (debug)
    {
	NAMEP tnp;

	prt();
	for (tnp = namehead.n_next; tnp; tnp = tnp->n_next)
	    prtname(tnp, 0);
    }
    EXIT(1);
}


/*
 *	Read a line into the supplied string of length MAXSTRING.  Remove
 *	comments, ignore blank lines. Deal with	quoted (\) #, and
 *	quoted newlines.  If EOF return TRUE.
 */
bool
getline(str, fd)
char *str;
FILE *fd;
{
    register char *p;
    char *q;
    int pos = 0;
    bool trim;

    trim = FALSE;
    for (;;)
    {
	if (fgets(str + pos, MAXSTRING - pos, fd) == NULL_CHARP)
	    return TRUE;	/* EOF  */

	lineno++;

	if ((p = index(str + pos, '\n')) == NULL_CHARP)
	{
	    p = index(str + pos, '\0');
	    if ((int)(p - (str + pos)) < (MAXSTRING - pos))
	    {
	        fprintf(stderr, "%s: ", myname);
		fprintf(stderr,
		    "Warning: Line %d is missing a final newline character\n",
		    lineno);
		fprintf(stderr,"An implicit newline has been assumed\n");
		*p++ = '\n';
		*p = '\0';
	    }
	    else
	        error("Line too long");
	}


	if (trim)
	{			/* strip leading space from continued line */
	    p = str + pos;
	    while (*p && isspace(*p))
		++p;
	    if (str + pos != p)
		strcpy(str + pos, p);
	    p = index(str + pos, '\n');
	}

	trim = (bool) (p[-1] == '\\');
	if (trim)
	{			/* <backslash><newline><whitespace> become
				   single space */
	    p[-1] = ' ';
	    pos = p - str;
	    continue;
	}

	p = str;
	while (((q = index(p, '#')) != NULL_CHARP) &&
	       (p != q) && (q[-1] == '\\'))
	{
	    char *a;

	    a = q - 1;		/* Del \ chr; move rest back  */
	    p = q;
	    while (*a++ = *q++)
		;
	}
	if (q != NULL_CHARP)
	{
	    q[0] = '\n';
	    q[1] = '\0';
	}

	p = str;
	while (isspace(*p))	/* Checking for blank  */
	    p++;

	if (*p != '\0')
	    return FALSE;
	pos = 0;
    }
}


/*
 *	Get a word from the current line, surounded by white space.
 *	return a pointer to it. String returned has no white spaces
 *	in it.
 */
char *
gettok(ptr)
char **ptr;
{
    register char *p;


    while (isspace(**ptr))	/* Skip spaces  */
	(*ptr)++;

    if (**ptr == '\0')		/* Nothing after spaces  */
	return NULL;

    p = *ptr;			/* word starts here  */

    while ((**ptr != '\0') && (!isspace(**ptr)))
	(*ptr)++;		/* Find end of word  */

    *(*ptr)++ = '\0';		/* Terminate it  */

    return (p);
}
