/*
 *	Macro control for make
 */

#include "h.h"

MACROP macrohead;

MACROP
getmp(name)
char *name;
{
    register MACROP rp;
    register MACROP rp_prev;

    for (rp = macrohead; rp; (rp_prev = rp, rp = rp->m_next))
	if (strcmp(name, rp->m_name) == 0)
	{
	    /* In the interests of efficiency, we move each found entry
	       to the beginning of the list, on the justifiable
	       assumption that the macro reference is likely to recur. */
	    if (rp != macrohead)
	    {
		rp_prev->m_next = rp->m_next;
		rp->m_next = macrohead;
		macrohead = rp;
	    }
	    return rp;
	}
    return NULL_MACROP;
}


char *
getmacro(name)
char *name;
{
    MACROP mp;

    if (mp = getmp(name))
	return mp->m_val;
    else
	return "";
}


MACROP
setmacro(name, val, permanent)
char *name;
char *val;
bool permanent;
{
    register MACROP rp;


    /* Replace macro definition if a non-permanent one exists */
    for (rp = macrohead; rp; rp = rp->m_next)
	if (strcmp(name, rp->m_name) == 0)
	    break;

    if (rp)
    {
	if ((rp->m_flag & M_PERMANENT) && !permanent)
	    return rp;		/* cannot replace permanent macro except */
	    			/* by another permanent one */

	if (strcmp(val, rp->m_val) == 0)/* with libraries, it is common */
	    return rp;			/* to have same value as before */

	free((char *) (rp->m_val));	/* Replacing: free value space from
					   old */
    }
    else			/* If not defined, allocate space for new */
    {
	if ((rp = (MACROP) malloc(sizeof(MACRO))) == NULL_MACROP)
	    fatal("No memory for macro");

	rp->m_next = macrohead;
	macrohead = rp;
	rp->m_flag = (uchar) (permanent ? M_PERMANENT : 0);
	rp->m_name = newstring(NULL_CHARP, name);
    }

    rp->m_val = newstring(NULL_CHARP, val);

    return rp;
}


/*
 *	Do the dirty work for expand
 */
void
doexp(to, from, len, buf)
char **to;
char *from;
int *len;
char *buf;
{
    register char *rp;
    register char *p;
    register char *q;
    register MACROP mp;


    rp = from;
    p = *to;
    while (*rp)
    {
	if ((*rp == '\\') && (*(rp + 1) == 'n'))
	{			/* translate \n literal pair to single
				   newline */
	    *p++ = '\n';
	    rp += 2;
	    (*len)--;
	    (*len)--;
	}
	else
	if (*rp != '$')
	{
	    *p++ = *rp++;
	    (*len)--;
	}
	else
	{
	    q = buf;
	    if (*++rp == '{')
		while (*++rp && *rp != '}')
		    *q++ = *rp;
	    else
	    if (*rp == '(')
		while (*++rp && *rp != ')')
		    *q++ = *rp;
	    else
	    if (!*rp)
	    {
		*p++ = '$';
		break;
	    }
	    else
		*q++ = *rp;
	    *q = '\0';
	    if (*rp)
		rp++;
	    if (!(mp = getmp(buf)))
		mp = setmacro(buf, "", TEMPORARY);
	    if (mp->m_flag & M_SEEN)
	    {
		sprintf(str1, "Infinitely recursive macro %s",
			mp->m_name);
		fatal(str1);
	    }
	    mp->m_flag |= M_SEEN;
	    *to = p;
	    doexp(to, mp->m_val, len, buf);
	    p = *to;
	    mp->m_flag &= ~M_SEEN;
	}
	if (*len <= 0)
	    error("Expanded line too line");
    }
    *p = '\0';
    *to = p;
}


/*
 *	Expand any macros in str.
 */
void
expand(str)
char *str;
{
    static char a[MAXSTRING];
    static char b[MAXSTRING];
    char *p = str;
    int len = MAXSTRING - 1;

    strcpy(a, str);
    doexp(&p, a, &len, b);
}
