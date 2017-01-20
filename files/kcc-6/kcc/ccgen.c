/*	CCGEN.C - Generate code for parse-tree data declarations
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.221, 25-Apr-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.84, 8-Aug-1985
**
**	Original version (C) 1981  K. Chen
*/

#include "cc.h"
#include "ccgen.h"
#include "ccchar.h"
#include <string.h>

/* Local prototypes */
#ifdef __STDC__
#define P_(a) a
#else
#define P_(a) ()
#endif

static void genfunct P_((NODE *n));
static void inicode P_((void));
static void endcode P_((void));
static void gendata P_((NODE *n));
static void gliterals P_((void));
static void giz P_((NODE *n,TYPE *t,SYMBOL *s));
static void gizword P_((NODE *n,TYPE *t,SYMBOL *s));
static int gizconst P_((NODE *e));
static int gizptr P_((NODE *n));
static void giznull P_((TYPE *t));
static void gizexpr P_((NODE *n,TYPE *t));
static void gizlist P_((NODE *n,TYPE *t,SYMBOL *s));
static void gizbytes P_((NODE *izl,TYPE *t,SYMBOL *s,int siz));
static void bytbeg P_((void));
static void bytend P_((void));
static void wdalign P_((void));
static void outval P_((long v));
static void outbyte P_((long v,int siz));
static void outzbs P_((int zeros,int siz));
static void outzwds P_((int nwds));
static void outptwd P_((SYMBOL *id,int bsize,int off));

#undef P_

/* OUT data emission vars. */
static int bsiz;	/* 0 if in word mode, else byte size in bits */
static int bpos;	/* P of last byte deposited (TGSIZ_WORD at beg of wd)*/
static int locctr;	/* Location counter (only for tracking # wds output) */
static int gizpure;	/* True when initializing pure code */

/* GENCODE - Generate code/data from parse-tree node
*/
void
gencode(n)
NODE *n;
{
    if (n)				/* Ignore null stmts/defs */
	switch (n->Nop) {
	    case N_DATA:
		if (!nerrors) gendata(n); 	/* Generate data definition */
		break;
	    case N_FUNCTION:
		if (!nerrors) genfunct(n);	/* Generate function instrs */
		ridlsym((SYMBOL *)NULL);	/* Flush any local symbols */
		break;
	    default:
		int_error("gencode: bad node %N", n);
 	}
}

/* GENFUNCT - Generate machine instruction code for function
*/
static void
genfunct(n)
NODE *n;
{
    if (n->Nleft->Nright)		/* Any local-scope static data defs? */
	gendata(n->Nleft->Nright);	/* Yes, generate them first */
    codeseg();				/* Ensure in code segment */
    inicode();				/* Start making code */
    outmidef(n->Nleft->Nleft->Nid);	/* Output function label */
#if SYS_CSI
    if (curfn != n->Nleft->Nleft->Nid)
	int_error("Bad funct Nid \"%S\"", n->Nleft->Nleft->Nid);
    if (profbliss)			/* for BLISS profiler */
	outprolog(curfn);		/* added 09/15/89 by MVS */
#endif /* SYS_CSI */

#if 1
    outnl();	/* For temp compat with older KCC, flush later */
#endif
    if (maxauto) {			/* If any auto vars, */
	code8(P_ADJSP, VR_SP, maxauto);	/* make room for them on stack */
	stackoffset += maxauto;		/* and remember stack bumped */
    }
    genstmt(n->Nright);			/* Generate code for body */
    endcode();				/* Wrap up code */
}

/* INICODE - Common code generation inits
*/
static void
inicode()
{
    previous = NULL;
    litstrings = NULL;
    litnodes = NULL;
    looplabel = brklabel = NULL;
    stackoffset = maxcode = mincode = 0;
    vrinit();
}

/* ENDCODE - Common code generation wrap-ups
*/
static void
endcode()
{
    flushcode();	/* Flush out peephole buffer */
    gliterals();	/* Generate any accumulated literals */
    vrendchk();		/* Check to make sure no regs active */
}

/* GENDATA - Generate data definitions
**
** This routine is only called to process static-extent data definitions
** of global or local scope, as opposed to local-extent (automatic) defs
** which are generated by genadata() in CCGEN1.
** Note that the Ntype of the symbol's Q_IDENT node is never examined here;
** the symbol's Stype is used instead.  They are identical except for
** array and function names, when the Ntype is "pointer to <Stype>".
*/
static void
gendata(n)
NODE *n;
{
    NODE *var;
    SYMBOL *s;

    for (; n != NULL; n = n->Nright) {
	if (n->Nop != N_DATA) {
	    int_error("gendata: bad N_DATA %N", n);
	    break;
	}
	if (var = n->Nleft) {		/* For each item on N_DATA list */
	    if (var->Nop != N_IZ) {
		int_error("gendata: bad datum %N", n);
		break;
	    }
	    s = var->Nleft->Nid;		/* get symbol */
	    gizpure = tispure(s->Stype);
	    if (gizpure)			/* If obj can be pure, */
		codeseg();			/* put it in pure code seg */
	    else dataseg();			/* Else ensure in data seg */
	    outmidef(s);			/* make label for variable */
	    giz(var->Nright, s->Stype, s);	/* do the initialization */
	}
    }
    gliterals();		/* Put literals into code (pure) segment */
}

/* GLITERALS - Emit all accumulated literals
**	Forces use of code segment as literals are expected to be pure,
**	although this is not mandatory.
*/
static void
gliterals()
{
    if (litstrings || litnodes) {		
	codeseg();
	flushcode();			/* Make sure all code forced out */
    }
    /* Do node literals first since they may generate more string literals! */
    while (litnodes != NULL) {
	outlab(litnodes->Nendlab);	/* Emit internal label */
	giz(litnodes->Nleft, litnodes->Nleft->Ntype, litnodes->Nendlab);
	freelabel(litnodes->Nendlab);
	litnodes = litnodes->Nright;
    }
    while (litstrings != NULL) {	/* Output literal strings */
	outlab(litstrings->Nsclab);	/* Emit generated label */
	freelabel(litstrings->Nsclab);	/* and then can free it. */
	outtab();			/* spaced out from string. */
	outscon(litstrings->Nsconst,	/* Output string literal, */
		    litstrings->Nsclen,	/* this long */
		    elembsize(litstrings->Ntype));	/* of this bytesize. */
	outnl();				/* End with final newline */
	litstrings = litstrings->Nscnext;	/* chain through list */
    }
}

/* GIZ - Generate initialization value for an object
*/
static void
giz(n, t, s)
NODE *n;
TYPE *t;
SYMBOL *s;
{
    if (n == NULL) {
	giznull(t);	/* nothing there, just make block */
	return;
    }

    switch (t->Tspec) {
    case TS_ARRAY:
    case TS_STRUCT:
    case TS_UNION:
	gizlist(n, t, s);
	return;

    default:				/* initializing simple object */
	gizword(n, t, s);		/* make just one or two words */
	return;
    }
}

/* GIZWORD - emit initialization for a simple var (not array or structure)
**	This closely follows the nisconst() routine in CCDECL which
**	checked for legality while parsing.
*/
static void
gizword(n, t, s)
NODE *n;
TYPE *t;
SYMBOL *s;
{
    if (n->Nop == N_IZLIST) {		/* something in brackets? */
	if (n->Nright != NULL)		/* no more than one allowed */
	    int_error("gizword: izer mismatch for %S %N", s, n);
	gizword(n->Nleft, t, s);	/* Just use inner part */
    } else
	if (!gizconst(n))		/* Try new stuff.  If not constant, */
	    gizexpr(n, t);		/* sigh, make at runtime. */
}

/* GIZCONST - Returns true if expression is an allowable initializer constant,
**	with appropriate code generated.  Otherwise, caller must generate.
*/
/* Return value indicates something about the type of constant: */
#define CT_NOTCON 0	/* not a constant, caller must generate. */
#define CT_CON	1	/* definitely a constant (arith, or a cast pointer) */
#define CT_ADDR	2	/* address of some kind */
#define CT_FUNC	3	/* function address (cannot add or sub from this) */

static struct pointerval {
	SYMBOL *pv_id;		/* Identifier (if any) */
	long pv_off;		/* Offset from identifier (words or bytes) */
	int pv_bsize;		/* Byte size of pointer (0 = word) */
} pv;

static int
gizconst(e)
NODE *e;
{
    long res;

    switch(e->Nop) {

	case N_ICONST:
	    if (tisbyte(e->Ntype)) {	/* Special handling for byte vals */
		res = e->Niconst & ((1<<tbitsize(e->Ntype))-1);	/* Mask off */
		res <<= (TGSIZ_WORD % tbitsize(e->Ntype));	/* Shift */
		outval(res);
		return CT_CON;
	    }
	    /* Normal word value, drop through */
	case N_PCONST:
	    outval(e->Niconst);		/* Just emit integer constant */
	    return CT_CON;		/* Say simple constant generated */

	case N_FCONST:			/* Invoke rtn from CCOUT */
	    locctr += outflt(e->Ntype->Tspec, (int *)&e->Nfconst, 0);
	    return CT_CON;		/* Say simple constant generated */


	/* Only the most likely cast conversions are supported here,
	** the others aren't common enough to be worth the
	** extra trouble.
	*/
	case N_CAST:
	    switch (e->Ncast) {
	    case CAST_EN_EN:
	    case CAST_EN_IT:
	    case CAST_PT_IT:
	    case CAST_NONE:		/* Most trivial casts */
		return gizconst(e->Nleft);	/* just pass on. */
	    case CAST_PT_PT:		/* Most likely cast here */
		break;			/* Drop thru to handle */
	    default:
		return CT_NOTCON;	/* Not a constant */
	    }
	    /* Drop through to check for ptr */

	default:
	    if (e->Ntype->Tspec == TS_PTR) {	/* Is this a pointer? */
		pv.pv_id = NULL;		/* Initialize arg struct */
		pv.pv_off = pv.pv_bsize = 0;
		if (res = gizptr(e)) {		/* Fill in the struct */
		    switch (res) {
		    case CT_CON:		/* Constant */
			/* Constant, value stashed in pv_off */
			outval(pv.pv_off);	/* Just emit integer */
			break;
		    default:			/* CT_ADDR & CT_FUNC */
			/* Won, output pointer word. */
			outptwd(pv.pv_id, pv.pv_bsize, pv.pv_off);
			break;
		    }
		    return res;
		}
	    }
	    return CT_NOTCON;		/* Must generate instructions */
    }
    return CT_NOTCON;
}

/* GIZPTR - auxiliary for GIZCONST */
static int
gizptr(n)
NODE *n;
{
    int addoff, i, off;
    TYPE *t;

    switch (n->Nop) {
	case N_CAST:
	    switch (n->Ncast) {
		case CAST_PT_PT:	/* Only ptr-ptr supported */
		    switch (gizptr(n->Nleft)) {	/* Get values for operand */
		    case CT_CON:		/* Constant pointer */
			if (pv.pv_off == 0) return CT_CON;
						/* Zero casts to anything */
			i = elembsize(n->Ntype);
			if (i == 0) i = TGSIZ_CHAR; /* Size for void* */
			off = elembsize(n->Nleft->Ntype);
			if (off == 0) off = TGSIZ_CHAR;	/* Size for void* */
			if (i >= TGSIZ_WORD) i = 0;
			if (off >= TGSIZ_WORD) off = 0;
			if (i == off) return CT_CON; /* Homogeneous cast OK */
			return CT_NOTCON;	/* Can't if not same size */

		    case CT_FUNC:		/* Function addr */
			if (n->Ntype->Tspec == TS_PTR	/* and converting to */
			    && n->Ntype->Tsubt->Tspec == TS_FUNCT) /* same, */
			  return CT_FUNC;	/* No further conv needed! */
			/* Fall into CT_ADDR to convert function */
			/* pointer to arbitrary address pointer */
		    case CT_ADDR:
			/* First see whether a conversion is actually needed */
			i = elembsize(n->Ntype); /* Desired bytesize of ptr */
			t = n->Nleft->Ntype; 	/* Get pointer to left */
			if ((i == 0) && tisbytepointer(n->Ntype)) {
						/* Casting to (void *)? */
			    if (tischarpointer(t)) /* from (char*)?*/
				return CT_ADDR;	/* Yes, no change */
			    i = TGSIZ_CHAR;	/* Else cvt to this bsize */
			} else if (!elembsize(t) && tisbytepointer(t)) {
						/* fm (void*)? */
			    if (tischarpointer(n->Ntype)) /* to (char*)?*/
				return CT_ADDR;	/* Yes, no change */
			}
			if (i >= TGSIZ_WORD) i = 0;
			if (i == pv.pv_bsize)	/* If already OK, */
			    return CT_ADDR;	/* just return success */

			/* Different sizes.  Check to see if boundaries match.
			** This takes care of 9<->18 bit conversions
			** (as well as any others)
			*/
			if (i && pv.pv_bsize) {	/* Both are byte ptrs? */
			    if (pv.pv_bsize < i && (i%pv.pv_bsize == 0)) {
				pv.pv_off /= (i/pv.pv_bsize);
				pv.pv_bsize = i;
				return CT_ADDR;
			    }
			    if (i < pv.pv_bsize && (pv.pv_bsize%i == 0)) {
				pv.pv_off *= (pv.pv_bsize/i);
				pv.pv_bsize = i;
				return CT_ADDR;
			    }
			}

			/* Odd sizes.  First must always cvt to a */
			/* word pointer */
			if (pv.pv_bsize) {
			    pv.pv_off /= (TGSIZ_WORD/pv.pv_bsize);
			    pv.pv_bsize = 0;
			}
			/* Casting to byte ptr of some kind? */
			if (i && (i < TGSIZ_WORD)) {
			    pv.pv_off *= (TGSIZ_WORD/i);
			    pv.pv_bsize = i;
			}
			return CT_ADDR;
		    default:		/* All others fail */
			return CT_NOTCON;
		    }

		default:		/* Only ptr-to-ptr supported for now */
		    break;
	    }
	    return CT_NOTCON;


	case N_SCONST:
	    pv.pv_id = n->Nsclab = newlabel();	/* Get fwd lab for later use */
	    n->Nscnext = litstrings;	/* Link on string stack */
	    litstrings = n;		/* Now on stack */
	    pv.pv_bsize = elembsize(n->Ntype);	/* Set bsize */
	    return CT_ADDR;			/* Say address generated */

	case N_PCONST:
	    pv.pv_off = n->Niconst;		/* Stuff constant here */
	    return CT_CON;			/* Return constant seen */

	case Q_IDENT:
		/* Identifier.  See documentation for Q_IDENT in cctoks.h
		** for explanation of this method of testing.
		*/
	    pv.pv_id = n->Nid;			/* Remember it */
	    switch (n->Nid->Stype->Tspec) {
		case TS_FUNCT:			/* Function address */
		    return CT_FUNC;		/* Say function address */
		case TS_ARRAY:			/* Array address */
		    if (tisbytearray(n->Nid->Stype))	/* If byte array, */
			pv.pv_bsize = elembsize(n->Nid->Stype);	/* set size */
		    return CT_ADDR;		/* Say array address */
	    }
	    return CT_NOTCON;			/* Barf */

	case N_ADDR:
	    switch (n->Nleft->Nop) {
		case N_PTR:			/* &(*()) is no-op */
		    return gizptr(n->Nleft->Nleft);

#if 0
		/* Allow for conversion of arrays generated by subscripting */
		case Q_PLUS:
		    if (n->Nleft->Ntype->Tspec == TS_ARRAY)
			return gizptr(n->Nleft);	/* OK, continue */
		    return CT_NOTCON;			/* Not array, fail */
#endif

		/* Structure hair.
		** For MEMBER (->) the Nleft must be a constant address.
		**	Can just apply nisconst to this.
		** For DOT (.) the Nleft can be anything that evaluates into
		**	a static structure.  We assume this is only possible
		**	with either Q_IDENT, or N_PTR of a struct addr.
		*/
		case Q_DOT:
		    if (tisbitf(n->Nleft->Ntype))	/* No bitfield ptrs */
			return CT_NOTCON;
		    switch (n->Nleft->Nleft->Nop) {
			case Q_IDENT:
			    switch (n->Nleft->Nleft->Nid->Sclass) {
				case SC_XEXTREF: case SC_EXLINK:
				case SC_EXTDEF: case SC_EXTREF:
				case SC_INTDEF: case SC_INTREF:
				case SC_INLINK: case SC_ISTATIC:
				    pv.pv_id = n->Nleft->Nleft->Nid;
				    goto dostruct; /* Good address of object */
			    }
			    break;
			case N_PTR:
			    if (gizptr(n->Nleft->Nleft->Nleft) == CT_ADDR)
				goto dostruct;
			    break;
		    }
		    return CT_NOTCON;			/* Otherwise fail. */

		case Q_MEMBER:
		    if (tisbitf(n->Nleft->Ntype)	/* No bitfield ptrs */
		      || gizptr(n->Nleft->Nleft) != CT_ADDR)
			return CT_NOTCON;
		dostruct:
		    /* If struct addr is OK, then we're OK */
		    if (pv.pv_bsize)	/* Structaddr never a byteptr */
			return CT_NOTCON;
		    if ((off = n->Nleft->Nxoff) < 0) {	/* Byte object? */
			pv.pv_bsize = (-off & 077);	/* Get byte size */
			pv.pv_off += (-off >> 12);	/* Add wd offset */
			pv.pv_off *= TGSIZ_WORD/pv.pv_bsize;
			pv.pv_off += (((-off)>>6)&077) / pv.pv_bsize;
		    } else if (tisbytearray(n->Nleft->Ntype)) {
			pv.pv_bsize = elembsize(n->Nleft->Ntype);
			pv.pv_off += off;	/* # of words offset */
			pv.pv_off *= TGSIZ_WORD/pv.pv_bsize;

		    } else {
			pv.pv_off += off;	/* # of words offset */
		    }
		    return CT_ADDR;

		case Q_IDENT:	/* Addr OK if of external or static */
			/* Needn't test type since parser checks it while
			** parsing "&" to verify not function or array.
			*/
		    switch (n->Nleft->Nid->Sclass) {
			case SC_XEXTREF: case SC_EXLINK:
			case SC_EXTDEF: case SC_EXTREF:
			case SC_INTDEF: case SC_INTREF:
			case SC_INLINK: case SC_ISTATIC:
			    pv.pv_id = n->Nleft->Nid;	/* Remember ident */
			    if (tisbyte(n->Nleft->Ntype)) {
				/* Single bytes are right-justified */
				pv.pv_bsize = tbitsize(n->Nleft->Ntype);
				pv.pv_off = (TGSIZ_WORD/pv.pv_bsize) - 1;
			    }
			    return CT_ADDR;	/* Good address of object */
		    }
		    return CT_NOTCON;		/* Bad storage class */
	    }
	    return CT_NOTCON;			/* Bad use of & */

	/* Non-atomic expression checks, for plus and minus. */
	case Q_PLUS:
	    if (n->Nleft->Nop == N_ICONST		/* Integ constant */
		&& gizptr(n->Nright) == CT_ADDR) {	/* + address */
		    addoff = n->Nleft->Niconst;
		    t = n->Nright->Ntype;		/* Ptr has this type */
	     } else if (n->Nright->Nop == N_ICONST	/* Integ constant */
		&& gizptr(n->Nleft) == CT_ADDR) {	/* Address */
		    addoff = n->Nright->Niconst;
		    t = n->Nleft->Ntype;
	    } else return CT_NOTCON;

	    /* See comments for sizeptobj in CCSYM.  Only reason code is
	    ** duplicated here is to handle funny byte sizes right.  Puke!
	    */
	doadd:
#if 1
	    if (tisbytepointer(t)) {
		if (!pv.pv_bsize) pv.pv_bsize = elembsize(t);
		addoff *= sizearray(t->Tsubt);	/* Mult by # bytes in obj */
	    } else
		 addoff *= sizetype(t->Tsubt);	/* Mult by obj size in wds */
#else /* Old buggy code */
	    addoff *= sizetype(t->Tsubt);	/* Mult by obj size in wds */
	    if (tisbytepointer(t) && !tisbyte(t->Tsubt)) {
		if (!pv.pv_bsize) pv.pv_bsize = elembsize(t);
		addoff *= (TGSIZ_WORD / pv.pv_bsize);
	    }
#endif
	    pv.pv_off += addoff;
	    return CT_ADDR;

	case Q_MINUS:
	    if (n->Nright->Nop == N_ICONST	/* minus integ constant */
		&& gizptr(n->Nleft) == CT_ADDR) {	/* Address */
		addoff = - n->Nright->Niconst;
		t = n->Nleft->Ntype;
		goto doadd;
	    }
	    break;

	default:		/* Anything else just fails */
	    break;
    }
    return CT_NOTCON;
}

/* GIZNULL - Initialize an object to nothing.
*/
static void
giznull(t)
TYPE *t;
{
    int i;

    if ((i = sizetype(t)) <= 0)
	int_error("giznull: Bad BLOCK: %d", i);
    else outzwds(i);
}

/* GIZEXPR - Generate code to initialize a static object at runtime.
**	Normally this should never be needed, but the capability is
**	kept here in case the need for cross-compiling ever comes up.
** Note: This will not work for initializing code-segment objects
** that are part of a larger object.  To work right, the init code gen
** needs to be deferred until the top-level object is done.  Don't bother
** fixing this unless it turns out we someday need it.
*/
static void
gizexpr(n, t)
NODE *n;
TYPE *t;
{
    static SYMBOL s;			/* Static to avoid re-initialization */
    SYMBOL *lnk;
    extern NODE *ndef(), *ndefop();
    int oseg;

    if (gizpure) {
      error("Constant static object requires runtime initialization");
      giznull(t);			/* Go ahead and reserve space */
      return;
    }

    note("Generating runtime initialization of static object");

    s.Sclass = SC_ISTATIC;		/* Set up temp sym for loc to init */
    s.Stype = t;			/* Type for gaddress() & ndefident() */
    s.Ssym = newlabel();		/* Get an internal sym */
    outlab(s.Ssym);			/* and emit it directly */
    strcpy(s.Sname, s.Ssym->Sname);	/* In case of debugging, copy name */
    giznull(t);				/* Emit space for the stuff to init */

    oseg = codeseg();			/* Switch to code segment */
    gliterals();			/* Make sure any pending */
					/* literals are output */
    inicode();				/* Initialize for code generation */
    lnk = newlabel();			/* Get a label for linkage */
    outlab(lnk);			/* and emit it directly */
    outstr("\tBLOCK\t1\n");		/* Make space for linkage */

    /* Fake up an assignment expression setting this symbol */
    n = ndef(Q_ASGN, t, 0, ndefident(&s), n);	/* Use temp for Q_IDENT sym */
    genxrelease(n);			/* Generate code for assignment */

    code6(P_SKIP+POF_ISSKIP+POS_SKPE, VR_RETVAL, lnk); /* see if more inits */
    codemdx(P_JRST, 0, NULL, 1, R_RETVAL);	/* yes, chain to the next */
    code5(P_POPJ, VR_SP);			/* no, back to runtime init */
    endcode();				/* emit literals if any */

    outstr("\t.LINK\t1,");		/* start making link pseudo-op */
    outmiref(lnk);			/* linking through top of routine */
    outnl();				/* finish it off */
    prevseg(oseg);			/* back to previous segment */

    freelabel(s.Ssym);			/* no longer need labels */
    freelabel(lnk);			/* so give them back to freelist */
}

/* GIZLIST - initialize static (not auto) array/struct/union from list
*/
static void
gizlist(n, t, s)
NODE *n;		/* N_IZLIST to initialize from */
TYPE *t;
SYMBOL *s;
{
    SYMBOL *sm;
    int nelts, elwds;
    int wdsleft;
    int savloc;

    if ((wdsleft = sizetype(t)) <= 0) {		/* Paranoia */
	int_error("gizlist: bad size: %d %N", wdsleft, n);
	return;					/* Don't try to fill out */
    }
    if (n->Nop != N_IZLIST) {			/* More paranoia */
	int_error("gizlist: not N_IZLIST %N", n);
	gizword(n, t, s);			/* Emit object expr anyway */
	return;					/* Nothing left on list */
    }

    switch (t->Tspec) {
    case TS_ARRAY:
	if (tisbytearray(t)) {		/* Array of bytes? */
	    gizbytes(n, t, s, 0);	/* Yep, go handle top-lev bytearray */
	    bytend();			/* End byte mode */
	    return;			/* Nothing left */
	}
	nelts = t->Tsize;		/* Get # elements in array */
	t = t->Tsubt;			/* Use member type from now on */
	elwds = sizetype(t);		/* Find # wds per element */
	for (; n && --nelts >= 0; n = n->Nright, wdsleft -= elwds)
	    giz(n->Nleft, t, s);	/* Initialize the element */
	break;

    case TS_UNION:
	if (n->Nright) {	/* Union izer should have only 1 element! */
	    int_error("gizlist: > 1 union izer %N", n);
	    n->Nright = NULL;	/* Merciless clobberage to recover */
	}
	/* Then drop thru to handle exactly like struct! */
    case TS_STRUCT:
	sm = t->Tsmtag->Ssmnext;	/* Struct & union have tag */
	savloc = locctr;		/* Remember current loc ctr */
	bsiz = 0;			/* Not in byte mode to start */
	for (; n && sm; n = n->Nright, sm = sm->Ssmnext) {
	    int p, s, w, o, gap, woff;

	    /* First ensure ready to emit right word for this object */
	    if ((o = sm->Ssmoff) < 0) {	/* Byte or bitf object? */
		w = (-o) >> 12;		/* Decode word offset */
		p = ((-o)&07700) >> 6;	/* Byte pos within word, in bits */
		s = (-o) & 077;		/* Size of object, in bits */
	    } else {			/* Word object, leave byte mode */
	        bytend();
		w = o;
	    }
	    woff = locctr - savloc;	/* Find current offset */
	    if (w != woff) {
		bytend();		/* Align again in case byte mode */
		woff = locctr - savloc;	/* Current offset may have changed */
		if (woff > w)		/* Offset mustn't go backwards!!! */
		    int_error("gizlist: offset clash for %S", sm);
		else outzwds(w - woff);
	    }
	    /* Right word offset, now see if word or byte/bit object */
	    if (o >= 0) {		/* If word object, */
		giz(n->Nleft, sm->Stype, sm);	/* Simply initialize it */
		continue;
	    }

	    /* Handle bitfield (or byte) objects differently from word objs */
	    bytbeg();			/* Ensure in byte mode */
	    gap = bpos - (p + s);	/* Get space between */
	    if (gap) {
		if (gap < 0) int_error("gizlist: -gap for %S", sm);
		else outbyte(0L, gap);	/* Space out to right place */
	    }
	    if (tisbytearray(sm->Stype))
		gizbytes(n->Nleft, sm->Stype, sm, 0);
	    else {
		if (n->Nleft->Nop != N_ICONST) /* not const? */
		    int_error("gizlist: bitf izer not iconst %N", n);
		outbyte(n->Nleft->Niconst, s);
	    }
	}
	bytend();			/* Done, ensure out of byte mode */
	wdsleft -= (locctr - savloc);	/* Find # words left if any */
	break;

    default:
	int_error("gizlist: bad izer type: %d %N", t->Tspec, n);
	return;
    }

    /*
    ** Fill out remains of initializer.
    **
    ** We might have run off the end of our initializer before coming to
    ** the end of the array or structure we were initializing.  In that
    ** case, we are supposed to fill the rest with zeros; this is done
    ** by counting how much space we have and making a BLOCK that long.
    */
    if (n || wdsleft < 0) {
	int_error("gizlist: too many izers (wlft: %d) %N", wdsleft, n);
	return;
    }
    if (wdsleft)
	outzwds(wdsleft);
}

/* GIZBYTES - Initialize byte array
**	May already be in byte mode.
*/
static void
gizbytes(izl, t, s, siz)
NODE *izl;
TYPE *t;
SYMBOL *s;
int siz;			/* Byte size (0 is top level) */
{
    register NODE *n = izl;
    int nbs = sizearray(t);	/* # of bottom elements (bytes) in array */
    int i;
    char *cp;

    if (n->Nop != N_IZLIST) {
	int_error("gizbytes: izer not list %N", n);
	return;
    }
    if (!siz) {
	siz = elembsize(t);		/* Get size of elements */
	bytbeg();			/* Get into byte mode */
    }
    for (n = izl; n; n = n->Nright) {
	switch (n->Nleft->Nop) {
	    case N_ICONST:		/* Single byte */
		outbyte(n->Nleft->Niconst, siz);
		nbs--;			/* count off */
		break;
	    case N_SCONST:		/* String literal */
		if (izl != n || n->Nright) {	/* Must be only thing! */
		    int_error("gizbytes: str not sole node %N", n);
		}
		cp = n->Nleft->Nsconst;
		i = nbs > n->Nleft->Nsclen ? n->Nleft->Nsclen : nbs;
		nbs -= i;
		if (i > 0) do {
		    outbyte((long)((siz == 6) ? tosixbit(*cp) : *cp), siz);
		    ++cp;
		} while (--i > 0);
		break;
	    case N_IZLIST:		/* Subarray */
		gizbytes(n->Nleft, t->Tsubt,s, siz);	/* Do recursively */
		nbs -= sizearray(t->Tsubt);	/* Done with subarray bytes */
		break;
	    default:
		int_error("gizbytes: bad izer for %S %N", s, n);
	}
    }

    /*
    ** Initialization done, fill out rest of array.
    ** Our array might be a subarray of some other char array,
    ** so we must be prepared to leave a ragged end.
    */
    if (nbs > 0)		/* Not enough elements? */
	outzbs(nbs, siz);	/* Fill up this many zero bytes */
    else if (nbs < 0)
	int_error("gizbytes: too many izers, %S", s);

    return;
}

/* OUT Data emission stuff.  Tracks whether in byte or word mode,
**	plus count of # words emitted so far.
*/

/* BYTBEG - Initializes to output bytes of given size.
**	If already in byte mode, does nothing except change bytesize.
*/
static void
bytbeg()
{
    if (!bsiz) {
      bpos = TGSIZ_WORD;	/* Begin word */
      bsiz = -1;		/* Size unknown */
    }
}

/* BYTEND - Leaves byte mode, returns # words output
**	since byte mode was entered (0 if never entered)
*/
static void
bytend()
{
    if (bsiz) {
        wdalign();		/* Force output to word boundary */
        bsiz = 0;		/* Leave byte mode */
    }
}

/* WDALIGN - Aligns output to word boundary, doesn't change mode.
*/
static void
wdalign()
{
    if (bpos != TGSIZ_WORD) {
	outnl();		/* Force out current word */
	++locctr;		/* and account for it */
	bpos = TGSIZ_WORD;	/* Now at start of new word */
    }
}

/* OUTVAL - Output value in either byte or word mode.
*/
static void
outval(v)
long v;
{
    outtab();
    outnum(v);
    outnl();
    ++locctr;
}

/* OUTBYTE - like OUTVAL but byte size is specified.
**	Must already be in byte mode.
*/
static void
outbyte(v, siz)
long v;
{
    v &= ((unsigned long)1 << siz) - 1;	/* Ensure value masked off */
    if (bpos < siz)
	wdalign();		/* If not enough room, get new wd */
    if (bpos == TGSIZ_WORD)	/* If at start of word, */
	fprintf(out, "\tBYTE (%d) %lo", siz, v);	/* do specially */
    else if (siz == bsiz)		/* can skip size if no change */
	fprintf(out, ",%lo", v);
    else
	fprintf(out, " (%d) %lo", siz, v);	/* Else just output it */
    bsiz = siz;
    bpos -= siz;
}

/* OUTZBS - Output zero bytes to fill up space.
*/
static void
outzbs(zeros, siz)
int zeros, siz;
{
    int bpw;				/* # bytes per word */

    if (zeros <= 0) return;
    while (bpos != TGSIZ_WORD && bpos >= bsiz && --zeros >= 0)
	outbyte(0L, siz);		/* Add filler til at word boundary */
    if (zeros >= (bpw = (TGSIZ_WORD/bsiz))) {	/* Full words left? */
	wdalign();			/* Ensure properly aligned */
	outzwds(zeros/bpw);		/* Zap those words */
	zeros %= bpw;			/* Get remaining # bytes */
    }
    while (--zeros >= 0)		/* Finish off */
	outbyte(0L, siz);		/* Remaining 0 bytes */
}

/* OUTZWDS - Output zero words to fill up space.
*/
static void
outzwds(nwds)
int nwds;
{
    if (nwds > 0) {
	fprintf(out, "\tBLOCK %o\n", nwds);	/* This many zero wds */
	locctr += nwds;
    }
}

static void
outptwd(id, bsize, off)
SYMBOL *id;
int bsize, off;
{
    outtab();			/* Won, output it. */
    outptr(pv.pv_id, pv.pv_bsize, pv.pv_off);
    outnl();
    ++locctr;
}

