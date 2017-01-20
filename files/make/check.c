/*
 *	Check structures for make.
 */

#include "h.h"


/*
 *	Prints out the structures as defined in memory.  Good for check
 *	that you make file does what you want (and for debugging make).
 */
void
prt()
{
    register NAMEP np;
    register DEPENDP dp;
    register LINEP lp;
    register CMDP cp;
    register MACROP mp;


    for (mp = macrohead; mp; mp = mp->m_next)
	fprintf(stderr, "%s = %s\n", mp->m_name, mp->m_val);

    fputc('\n', stderr);

    for (np = namehead.n_next; np; np = np->n_next)
    {
	if (np->n_flag & N_DOUBLE)
	    fprintf(stderr, "%s::\n", np->n_name);
	else
	    fprintf(stderr, "%s:\n", np->n_name);
	if (np == firstname)
	    fprintf(stderr, "(MAIN NAME)\n");
	for (lp = np->n_line; lp; lp = lp->l_next)
	{
	    fputc(':', stderr);
	    for (dp = lp->l_dep; dp; dp = dp->d_next)
		fprintf(stderr, " %s", dp->d_name->n_name);
	    fputc('\n', stderr);

	    for (cp = lp->l_cmd; cp; cp = cp->c_next)
		fprintf(stderr, "-%c%s\n", TAB, cp->c_cmd);

	    fputc('\n', stderr);
	}
	fputc('\n', stderr);
    }
}


/*
 *	Recursive routine that does the actual checking.
 */
void
check(np)
NAMEP np;
{
    register DEPENDP dp;
    register LINEP lp;


    if (np->n_flag & N_MARK)
    {
	sprintf(str1, "Circular dependency from %s", np->n_name);
	fatal(str1);
    }


    np->n_flag |= N_MARK;

    for (lp = np->n_line; lp; lp = lp->l_next)
	for (dp = lp->l_dep; dp; dp = dp->d_next)
	    check(dp->d_name);

    np->n_flag &= ~N_MARK;
}


/*
 *	Look for circular dependancies.
 *	ie.
 *		a: b
 *		b: a
 *	is a circular dep
 */
void
circh()
{
    register NAMEP np;


    for (np = namehead.n_next; np; np = np->n_next)
	check(np);
}


/*
 *	Check the target .PRECIOUS, and mark its dependentd as precious
 */
void
precious()
{
    register DEPENDP dp;
    register LINEP lp;
    register NAMEP np;


    if (!((np = newname(".PRECIOUS"))->n_flag & N_TARG))
	return;

    for (lp = np->n_line; lp; lp = lp->l_next)
	for (dp = lp->l_dep; dp; dp = dp->d_next)
	    dp->d_name->n_flag |= N_PREC;
}
