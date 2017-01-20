/*	CCGEN1.C - Generate code for parse-tree statement execution
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.198, 9-Mar-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.112, 8-Aug-1985
**
**	Original version (C) 1981  K. Chen
*/

#include "cc.h"
#include "ccgen.h"

/* Local prototypes */
#ifdef __STDC__
#define P_(a) a
#else
#define P_(a) ()
#endif

static NODE *laststmt P_((NODE *n));
static void genadata P_((NODE *n));
static void gif P_((NODE *n));
static int labchk P_((NODE *n));
static void gwhile P_((NODE *n));
static SYMBOL *gtoplab P_((void));
static void gdo P_((NODE *n));
static void gfor P_((NODE *n));
static void greturn P_((NODE *n));

#undef P_

/* ------------------------------------- */
/*      generate code for statement      */
/* ------------------------------------- */

void
genstmt(n)
NODE *n;
{
    if (n == NULL) return;
    switch (n->Nop) {

    case N_STATEMENT:
	{ NODE *beg, *next;
	if (n->Nleft && n->Nleft->Nop == N_DATA) { /* Check for auto inits */
	    genadata(n->Nleft);		/* Yep, do them */
	    n = n->Nright;		/* then move on to real statements */
	}
	for(beg = n; n != NULL; n = n->Nright) {
	    if(n->Nop != N_STATEMENT)
		int_error("genstmt: bad stmt %N", n);
	    if(n->Nleft == NULL) continue;

	    /* Check out following stmt for possible optimizations */
	    if(n->Nright && (next = n->Nright->Nleft) && optgen) {
		switch(next->Nop) {

		/* Hack to encourage tail recursion */
		case Q_RETURN:			/* If next will be RETURN */
		    if(next->Nright == NULL) {	/* and has no return val */
			NODE *v;		/* Then try to optimize */
			if((v = laststmt(n->Nleft)) && v->Nop == N_FNCALL)
			    v->Nflag |= NF_RETEXPR;
		    }
		    break;

		/* If next stmt is a GOTO, ensure that any jumps
		 * within current stmt to end of stmt will
		 * instead go directly to object of the GOTO.
		 * Avoids jumping to jumps...
		 * We do a similar hack for BREAK and CONTINUE,
		 * which are similar to GOTOs except that their
		 * destination is kept in variables global to the
		 * code generation routines.
		 */
		case Q_CASE:	/* Not sure about this one yet */
		case N_LABEL:

		case Q_GOTO:
		    n->Nleft->Nendlab = next->Nxfsym;
		    break;
		case Q_BREAK:
		    n->Nleft->Nendlab = brklabel;
		    break;
		case Q_CONTINUE:
		    n->Nleft->Nendlab = looplabel;
		    break;
	    }	/* end of Nop switch */
	    }	/* end of next-stmt check */

	    /* Optimize label usage */
	    if(n->Nright == NULL 	/* If this is last stmt in list */
		&& optgen)
		n->Nleft->Nendlab = beg->Nendlab;	/* Copy from 1st */

	    genstmt(n->Nleft);
	}
	break;
	} /* end of N_STATEMENT case block */

    case Q_CASE:
	codlabel(n->Nxfsym);		/* send forward label */
	n->Nleft->Nendlab = n->Nendlab;	/* propagate end label */
	genstmt (n->Nleft);		/* finish rest of body */
	break;

    case N_LABEL:
	codgolab(n->Nxfsym);		/* send goto label */
	n->Nleft->Nendlab = n->Nendlab;	/* propagate end label */
	genstmt(n->Nleft);		/* finish rest of body */
	break;

    case Q_BREAK:	code6(P_JRST, 0, brklabel);	break;
    case Q_GOTO:	code6(P_JRST, 0, n->Nxfsym);	break;
    case Q_CONTINUE:	code6(P_JRST, 0, looplabel);	break;
    case Q_DO:		gdo(n);		break;
    case Q_FOR:		gfor(n);	break;
    case Q_IF:		gif(n);		break;
    case Q_RETURN:	greturn(n);	break;
    case Q_SWITCH:	gswitch(n);	break;
    case Q_WHILE:	gwhile(n);	break;

    case N_EXPRLIST:		/* Same as expression stmt */
    default:			/* None of above, assume expression stmt */
	genxrelease(n);		/* Generate it and flush any result */
	break;
    }
}

/* Hack for statement optimization.  Find last statement in list. */
static NODE *
laststmt(n)
NODE *n;
{
	while(n && n->Nop == N_STATEMENT) {
		while(n->Nright) n = n->Nright;
		n = n->Nleft;
	}
	return(n);
}

/* GENADATA - Generate auto data initializations
**	Should be called only for N_DATA nodes.
**
** Includes "gizlist" - Generate a struct/union/array constant.
**	This can only happen for brace-enclosed initializers.
** Node will be a N_IZLIST, with Ntype set to desired type of the
** constant.
** For the time being, our approach is to chicken out by just inventing
** a new internal label and returning that.  This label and the N_IZLIST
** are put together to form a N_LITIZ list and chained onto "litnodes"
** for eventual output as a static data literal.
*/
static void
genadata(n)
NODE *n;
{
    if (n->Nop != N_DATA) {
	int_error("genadata: node not N_DATA %N", n);
	return;
    }
    for (; n && n->Nop == N_DATA; n = n->Nright) {
	if (n->Nleft != NULL && n->Nleft->Nright != NULL) {

	    /* Have an N_IZ node with initializer, process it. */
	    if (n->Nleft->Nright->Nop == N_IZLIST) {
		/* A struct/union/array initializer! */
		SYMBOL *s = n->Nleft->Nleft->Nid;	/* Find ident */
		NODE *l = n->Nleft->Nright;	/* Point to N_IZLIST */
		TYPE *t = l->Ntype;		/* Find type of constant */
		VREG *ra, *r;

		/* Put izer node onto literal list for later emission */
		litnodes = ndeflr(N_LITIZ, l, litnodes);
		litnodes->Nendlab = newlabel();	/* Make label for it */

		/* Get the literal and store into auto var.  Note that the
		** type used is that of literal, not the ident, and it is
		** ignored except to find the size in words of the object.
		** This takes care of union objects, which only need to
		** init the first member (which may be smaller than some
		** other members).
		*/
		r = vrget();
		ra = vrget();
		code3(P_MOVE, r, litnodes->Nendlab);	/* Get lit's addr */
		r = getmem(r, t, 0, 0);			/* Get izer contents */
		code13(P_MOVE, ra, (s->Svalue+1)-stackoffset);	/* AUTO addr */
		r = stomem(r, ra, sizetype(t), 0);	/* Set up the store */
		relflush(r);				/* Done, flush reg */
		continue;
	    }

	    /* Normal case, izer not a brace-enclosed list.  Handle
	    ** by turning the N_IZ into a Q_ASGN expression.  Note the
	    ** C type of the expression needs to be set (from the Q_IDENT).
	    */
	    n->Nleft->Nop = Q_ASGN;	/* Turn N_IZ into Q_ASGN */
	    n->Nleft->Ntype = n->Nleft->Nleft->Ntype;	/* Set up type */
	    genxrelease(n->Nleft);	/* Generate code, ignore value */
	}
    }
}

/* ---------------------- */
/*	if statement      */
/* ---------------------- */
static void
gif(n)
NODE *n;
{
    SYMBOL *true, *false;
    NODE *nthen, *nelse, *body, *l;

    body = n->Nright;
    nthen = body->Nleft;
    nelse = body->Nright;
    l = n->Nleft;

    /* optimize if to a jump */
    if (nelse == NULL) {
	if (nthen == NULL) {		/* no body of either kind?? */
	    genxrelease(l);		/* yes, just produce condition */
	    return;			/* and return */
	} else if (optgen) switch (nthen->Nop) {
	case Q_BREAK:
	    l->Nendlab = n->Nendlab;
	    gboolean(l, brklabel, 1);
	    return;
	case Q_GOTO:
	    l->Nendlab = n->Nendlab;
	    gboolean(l, nthen->Nxfsym, 1);
	    return;
	case Q_CONTINUE:
	    l->Nendlab = n->Nendlab;
	    gboolean(l, looplabel, 1);
	    return;
	}
    }

    /* Try to optimize when conditional expression is a constant.
    ** We have to be careful about flushing the then/else clauses because
    ** control could jump into them using either case or goto labels.
    ** Hence the labchk() to see whether the parse tree contains such labels...
    */
    if (l->Nop == N_ICONST && optgen) {		/* If cond is constant */
	if (l->Niconst && !labchk(nelse)) {	/* if (1) & "else" flushable */
	    if (nthen) {
		nthen->Nendlab = n->Nendlab;
		genstmt(nthen);
	    }
	    return;
	}
	if (!l->Niconst && !labchk(nthen)) {	/* if (0) & "then" flushable */
	    if (nelse) {
		nelse->Nendlab = n->Nendlab;
		genstmt(nelse);
	    }
	    return;
	}
    }

    /* do unoptimized if statement - first get exit label */
    true = ((n->Nendlab == NULL)? newlabel() : n->Nendlab);

    /* then emit code for test and clauses */
    if (nthen) {
	if (nelse == NULL) false = true;
	else switch (nelse->Nop) {
	case Q_GOTO:
	    false = nelse->Nxfsym;
	    nelse = NULL;
	    break;
	case Q_CONTINUE:
	    false = looplabel;
	    nelse = NULL;
	    break;
	case Q_BREAK:
	    false = brklabel;
	    nelse = NULL;
	    break;
	default:
	    false = newlabel();
	}
	switch(nthen->Nop) {		/* we could invert the boolean here, */
	case Q_GOTO:			/* but instead we merely set label */
	case N_LABEL:			/* at the end of the condition. */
	case Q_CASE:			/* fixes gotos in both clauses. */
	    l->Nendlab = nthen->Nxfsym;
	    break;
	case Q_CONTINUE:
	    l->Nendlab = looplabel;
	    break;
	case Q_BREAK:
	    l->Nendlab = brklabel;
	}
	gboolean(l, false, 0);
	nthen->Nendlab = true;
	genstmt(nthen);
	if (nelse) {
	    code6(P_JRST, 0, true);
	    codlabel(false);
	    nelse->Nendlab = true;
	    genstmt(nelse);
	}
    } else if (nelse) {
	gboolean(l, true, 1);
	nelse->Nendlab = true;
	genstmt(nelse);
    }

    /* then emit exit label */
    if (!n->Nendlab) codlabel(true);	/* emit exit label */
}

/* LABCHK - returns true if parse tree contains any labels.
*/
static int
labchk(n)
NODE *n;
{
    if (n == NULL) return 0;
    switch (n->Nop) {
	case Q_CASE:		/* These three are all labels */
	case N_LABEL:
	case Q_DEFAULT:
	    return 1;

	case N_STATEMENT:		/* Compound statement, scan it. */
	    if (n->Nleft && n->Nleft->Nop == N_DATA)	/* Skip auto inits */
		n = n->Nright;		/* move on to real statements */
	    for(; n != NULL; n = n->Nright) {
		if(n->Nop != N_STATEMENT)
		    int_error("labchk: bad stmt %N", n);
		if(n->Nleft && labchk(n->Nleft))
		    return 1;
	    }
	    return 0;

	case Q_IF:		/* Has two substatements */
	    return labchk(n->Nright->Nleft) || labchk(n->Nright->Nright);

	case Q_DO:		/* Standard substatements */
	case Q_FOR:
	case Q_SWITCH:
	case Q_WHILE:
	    return labchk(n->Nright);

	case Q_BREAK:		/* Not labels and no substatements */
	case Q_GOTO:
	case Q_CONTINUE:
	case Q_RETURN:
	case N_EXPRLIST:	/* Same as expression stmt */
	default:		/* None of above, assume expression stmt */
	    return 0;
    }
}

/* ------------------------- */
/*	while statement      */
/* ------------------------- */
static void
gwhile(n)
NODE *n;
{
    SYMBOL *saveb, *savel;

    /* ok, we do, so we need to make a label for the top */
    savel = looplabel;
    looplabel = gtoplab();		/* Get new label and emit */

    /* now, see if there is a body or just the test */
    if (n->Nright == NULL) {
	n->Nleft->Nendlab = n->Nendlab;	/* propagate exit point */
	gboolean(n->Nleft, looplabel, 1); /* no body, just test */
    } else {
	saveb = brklabel;		/* full body, need another label */
	brklabel = (n->Nendlab != NULL)? n->Nendlab : newlabel();
	n->Nright->Nendlab = looplabel;	/* exit from body is to loop top */
	gboolean(n->Nleft, brklabel, 0);	/* first the test, if any */
	genstmt(n->Nright);		/* then the actual body */
	code6(P_JRST, 0, looplabel);	/* body jumps back to test */
	if (n->Nendlab == NULL) codlabel(brklabel); /* emit end label */
	brklabel = saveb;		/* restore label for outer loop */
    }

    /* in either case we need to restore the outer loop top label */
    freelabel (looplabel);
    looplabel = savel;			/* fix the label */
}

/* GTOPLAB - auxiliary for loops which need to generate a label at top.
*/
static SYMBOL *
gtoplab()
{
    SYMBOL *lab;
    flushcode();		/* Ensure all previous code forced out */
    lab = newlabel();		/* Get new label */
    outlab(lab);		/* and emit it directly */
    return lab;
}

/* ---------------------- */
/*	do statement      */
/* ---------------------- */
static void
gdo(n)
NODE *n;
{
    SYMBOL *saveb, *savel, *toplabel;

    toplabel = gtoplab();		/* Get new label and emit */
    saveb = brklabel;
    brklabel = (n->Nendlab != NULL) ? n->Nendlab : newlabel();

    if (n->Nright) {
	savel = looplabel;
	n->Nright->Nendlab = looplabel = newlabel();
	genstmt(n->Nright);
	codlabel(looplabel);
	looplabel = savel;		/* restore outer loop label */
    }

    if ((n->Nleft->Nop) != N_ICONST) {
	n->Nleft->Nendlab = brklabel;
	gboolean(n->Nleft, toplabel, 1);
    } else if (n->Nleft->Niconst) code6(P_JRST, 0, toplabel);

    if (n->Nendlab == NULL) codlabel(brklabel);
    brklabel = saveb;			/* restore for outer breaks */
    freelabel (toplabel);		/* no more use for this one */
}

/* ----------------------- */
/*	for statement      */
/* ----------------------- */
static void
gfor(n)
NODE *n;
{
    NODE *cond, *body, *incr, *init;
    SYMBOL *saveb, *savel, *toplabel;
    int endtest;			/* safe to move test to end of loop */

    cond = n->Nleft;
    body = n->Nright;
    incr = cond->Nright->Nleft;
    cond = cond->Nleft;
    init = cond->Nleft;
    cond = cond->Nright;

    /* See if conditional test can be put at the end of the loop, which is
    ** usually more efficient.  endtest is true if so.  Note that it
    ** will not be true if no test exists.
    */
    endtest = optgen &&			/* Never, if not optimizing. */
	cond &&				/* And only if have a condition. */
	((body == NULL && incr == NULL)	/* OK if no body or increment */
	 || istrue(cond, init));	/* or if test exists & is TRUE */

    if (init) genxrelease(init);

    toplabel = gtoplab();	/* Generate top-of-loop label and emit */
    saveb = brklabel;
    brklabel = (n->Nendlab != NULL) ? n->Nendlab : newlabel();

    savel = looplabel;			/* remember prev outer label */
    looplabel = (body == NULL || (incr == NULL && !endtest)) ?
		toplabel : newlabel();

     /* Normally generate test at start of loop */
    if (cond && !endtest)		/* If have condition, and at beg, */
	gboolean(cond, brklabel, 0);	/* generate test at start of loop */

    /* Now generate body */
    if (body != NULL) {			/* If we have one, of course */
	body->Nendlab = looplabel;
	genstmt(body);
	if (looplabel != toplabel) codlabel(looplabel);
    }

    /* Now generate increment */
    if (incr != NULL) {
	if (!endtest) incr->Nendlab = toplabel;
	genxrelease(incr);
    }

    /* Finally generate loop back to condition test at top, unless actually
    ** doing the test here.
    */
    if (endtest) {			/* If test comes at end of loop */
	cond->Nendlab = brklabel;	/* set end label for it */
	gboolean(cond,toplabel,1);	/* and gen the conditional jump */
    }
    else code6(P_JRST, 0, toplabel);	/* Otherwise just loop */

    if (n->Nendlab == NULL)
	codlabel(brklabel);
    brklabel = saveb;			/* restore old break label */
    looplabel = savel;			/* restore outer loop continuation */
    freelabel(toplabel);		/* don't need top label any more */
}

/* -------------------------- */
/*	return statement      */
/* -------------------------- */
static void
greturn(n)
NODE *n;
{
    int siz;
    VREG *r, *r2;

    if (optobj && deadjump()) return;	/* If in dead code, do nothing */
    if (n = n->Nright) {		/* If returning a value, set it */
	if (n->Ntype->Tspec == TS_ARRAY) {	/* Just in case */
	    int_error("greturn: returning array");
	    return;
	}
	siz = sizetype(n->Ntype);	/* Remember size */
	n->Nflag |= NF_RETEXPR;		/* Tell genexpr this is return value */
	if ((r = genexpr(n)) == NULL) {	/* Make return expression */
	    if (!deadjump())		/* If no expr, must be in dead code */
		int_error("greturn: null vreg");
	    return;			/* Assume tail-recursed, so win! */
	}
	switch (siz) {
	case 1:				/* Return 1-word value */
	    code0(P_MOVE, VR_RETVAL, r);
	    break;
	case 2:				/* Return 2-word value */
	    code0(P_DMOVE, VR_RETVAL, r);
	    break;
	default:			/* Return N-word value */
	    r2 = vrget();
	    code13(P_MOVE, r2, -1 - stackoffset);	/* Get addr of arg 0 */
	    code4(P_MOVE, r2, r2);	/* Get ptr to place to return block */
	    code4s(P_SMOVE, r2, r, 0, siz);	/* Copy the block */
	    vrfree(r2);
	}
    }
    if (optobj) killstack();			/* Flush spurious MOVEMs */
    code8(P_ADJSP, VR_SP, - stackoffset);	/* flush local vars from stk */
#if SYS_CSI
    if (profbliss) {				/* for BLISS profiler */
	flushcode();
	outepilog(curfn);			/* added 09/15/89 by MVS */
    }
#endif
    code5(P_POPJ, VR_SP);			/* emit the return */
}
