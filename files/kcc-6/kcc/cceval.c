/*	CCEVAL.C - Evaluate and optimize expression parse trees
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.24, 11-Jan-1988 including CCFOLD merge
**		All CCFOLD changes after v.116, 29-Apr-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.7, 8-Aug-1985
**		All CCFOLD changes after v.17, 8-Aug-1985
**
** Original CCEVAL by David Eppstein / Stanford University / 28-Jul-84
** Original CCFOLD (C) 1981  K. Chen
*/

#define NEW 3	/* temporary to allow shutting advanced optimiz off if buggy */

#include "cc.h"

/* Local prototypes */
#ifdef __STDC__
#define P_(a) a
#else
#define P_(a) ()
#endif

static NODE *eval P_((NODE *e));
static NODE *evalfun P_((NODE *e));
static int evalbool P_((NODE *e));
static NODE *evallog P_((NODE *e));
static NODE *evalbinop P_((NODE *e));
static NODE *evalunop P_((NODE *e));
static NODE *evalb1op P_((NODE *e));
static NODE *evalasop P_((NODE *e));
static NODE *evalincdec P_((NODE *e,int op));
static NODE *copyflag P_((NODE *new,NODE *old));
static NODE *setlog P_((NODE *e,int res));
static NODE *evalcast P_((NODE *e));
static long tolong P_((TYPE *t,long val));
#if 0
static NODE *setnode P_((NODE *new,NODE *old,int nop));
#endif
static int ecanon P_((NODE *n));
static NODE *eseqdisc P_((NODE *l, NODE *r));
static NODE *edisc P_((NODE *n));
static long value P_((NODE *test,NODE *bindings));
static NODE *lookup P_((SYMBOL *var,NODE *bindings));

#undef P_

/* Handy macro to see if an operand node is a hackable constant */
#define eisconst(e) \
	(e->Nop == N_ICONST || e->Nop == N_PCONST || e->Nop == N_FCONST)
#define eisiconst(e) (e->Nop == N_ICONST)

/* EVALEXPR(e) - Evaluates a parse-tree expression, folding constants and
**	reducing it as far as possible.  This includes discarding unused
**	values in sequential (comma) expressions.
*/
NODE *
evalexpr(e)
NODE *e;
{
    ecanon(e = eval(e));
    return e;
}

static NODE *
eval(e)
NODE *e;
{
    if (e) switch (tok[e->Nop].tktype) {

    case TKTY_RWOP:			/* Built-in Reserved-Word ops */
	break;				/* Only Q_ASM for now */

    case TKTY_PRIMARY:
	switch (e->Nop) {
	    case N_FNCALL:
		return evalfun(e);
	    case Q_DOT:
	    case Q_MEMBER:
		e->Nleft = eval(e->Nleft);
	}
	break;				/* Return e */

    case TKTY_SEQ:			/* Just one op, N_EXPRLIST (,) */
	e->Nright = eval(e->Nright);	/* Fold current expression */
	if (!(e->Nleft = evaldiscard(eval(e->Nleft)))) /* Fold previous */
	    return e->Nright;		/* May have flushed Nleft */
	break;				/* Return e */

    case TKTY_UNOP:
	e->Nleft = eval(e->Nleft);
	if (eisconst(e->Nleft))
	    return evalunop(e);		/* Do unary op on constant */
	break;

    /* Assignment ops have side effects, so can't eliminate them completely.
    ** However, it may be possible to optimize a non-simple assignment into
    ** a simple assignment, if the right operand is a specific constant
    ** (notably 0).
    ** Also, things like +=1 and -=1 should be turned into ++ and -- since the
    ** code generator has special optimizations for those.
    */
    case TKTY_ASOP:			/* Assignment ops */
	e->Nleft  = eval(e->Nleft);	/* Fold destination */
	e->Nright = eval(e->Nright);	/* Fold right operand, and */
	if (eisconst(e->Nright))	/* check further if it's a constant */
	    return evalasop(e);
	break;				/* return e */

    case TKTY_BINOP:			/* Ordinary binary ops */
	e->Nleft  = eval(e->Nleft);	/* First fold operands */
	e->Nright = eval(e->Nright);
	if (eisconst(e->Nleft)) {
	    if (eisconst(e->Nright))
		return evalbinop(e);	/* Do binary op on two constants */
	    /* Have one constant on left -- not on right.
	    ** ecanon() should have put the constant on right, but
	    ** constant evaluation here may have changed things.
	    */
	    return evalb1op(e);		/* Do binary op on one constant */
	} else if (eisconst(e->Nright))	/* Have one constant on right? */
	    return evalb1op(e);		/* Do binary op on one constant */
	break;			/* Neither operand is a constant. */


    case TKTY_BOOLOP:			/* Relational & logical binary ops */
	e->Nleft  = eval(e->Nleft);
	e->Nright = eval(e->Nright);
	if (e->Nop == Q_LAND || e->Nop == Q_LOR) {	/* Logical operator? */
	    if (eisconst(e->Nleft))
		return evallog(e);
	} else {
	    /* Relational or equality op.  Both operands must be constants
	    ** if we are to evaluate further.
	    ** Actually, there are a few special cases which could still
	    ** be optimized if one operand is a constant.  For example,
	    ** unsigned comparison with 0.
	    */
	    if (eisconst(e->Nleft) && eisconst(e->Nright))
		return evalbinop(e);
	}
	break;

    case TKTY_BOOLUN:			/* Just one op, Q_NOT (!) */
	e->Nleft = eval(e->Nleft);
	if (eisconst(e->Nleft))		/* Is operand a constant? */
	    return setlog(e, !evalbool(e->Nleft));	/* Yes, win */
	break;				/* Return e */

    case TKTY_TERNARY:			/* Just one op, Q_QUERY (?:) */
	e->Nleft = eval(e->Nleft);
	if (eisconst(e->Nleft))		/* Is operand a constant? */
	    return (evalbool(e->Nleft)	/* Yes, return proper branch */
			? eval(e->Nright->Nleft)
			: eval(e->Nright->Nright));

	/* Conditional isn't a constant, so fold both results */
	e->Nright->Nleft = eval(e->Nright->Nleft);
	e->Nright->Nright = eval(e->Nright->Nright);
	break;				/* Return e */

    default:
	int_warn("eval: bad expr op %N", e);
	break;				/* Return e anyway */
    }
    return e;		/* This returns NULL if e was null */
}

/* EVALFUN - Evaluate function call.
*/
static NODE *
evalfun(e)
NODE *e;
{
    NODE *list;
    e->Nleft = eval(e->Nleft);		/* First do function addr */
    for (list = e->Nright; list; list = list->Nleft) {
	if (list->Nop == N_EXPRLIST)
	    list->Nright = eval(list->Nright);
	else {
	    int_warn("evalfun: bad arglist %N", list);
	    break;
	}
    }
    return e;
}

/* EVALBOOL - find boolean truth value of node.
**    Only scalar constants are acceptable.  (float, int, pointer, enum)
**	+1 - TRUE
**	0  - FALSE
**	-1 - not a scalar constant
*/
static int
evalbool(e)
NODE *e;
{
    switch (e->Nop) {
	case N_PCONST:		/* Pointer constant same as int constant */
	case N_ICONST:	return (e->Niconst ? 1 : 0);
	case N_FCONST:	return (e->Nfconst ? 1 : 0);
    }
    return -1;
}

/* EVALLOG - Evaluate a logical binary expression, either && or ||.
*/
static NODE *
evallog(e)
NODE *e;
{
    NODE *etmp;
    int torf;

    if ((torf = evalbool(e->Nleft)) < 0)
	return e;			/* 1st operand not constant. */
    if (e->Nop == Q_LAND) {		/* For logical AND, */
	if (torf == 0)			/* if 1st operand false, */
	    return setlog(e, 0);	/* entire result is false. */
    } else {				/* For logical OR, */
	if (torf != 0)			/* if 1st operand true, */
	    return setlog(e, 1);	/* entire result is true. */
    }
    e->Nop = Q_NEQ;			/* Transform 1&&e or 0||e */
    e->Nleft->Ntype = inttype;		/* into (0 != e) */
    setlog(e->Nleft, 0);
    etmp = e->Nleft;			/* Swap to make (e != 0) */
    e->Nleft = e->Nright;
    e->Nright = etmp;
    e = convnullcomb(convbinary(e));
    e->Ntype = inttype;			/* Result of != is int */

    if (eisconst(e->Nleft))		/* If both sides now constant, */
	return evalbinop(e);		/* evaluate (e != 0) */
    return e;
}

/* EVALOP - evaluate operators of type TKTY_BINOP and TKTY_BOOLOP
**	with the exception of the logical operators (&& and ||).
**	All operands are known to be constants; "good" constants
**	are N_ICONST, N_PCONST, N_FCONST.
**
**	Relational/Equality ops:
**		== != < > <= >=
**	Arithmetic & Bitwise ops:
**		* / % + - << >> & ^ |
**
** Note that the comparison ops can have scalar arguments,
** as can the additive (+ -).
** Also, four ops (+ - << >>) can have operands which differ in type; this
** needs to be checked for.
*/
static NODE *
evalbinop(e)
NODE *e;
{
    long	l, l2;
    unsigned long ul, ul2;
    float	f, f2;
    double	d, d2;
    int log = -1;
    NODE *eleft = e->Nleft;

    switch (eleft->Ntype->Tspec) {
    case TS_INT:
    case TS_LONG:
	l = eleft->Niconst;
	l2 = e->Nright->Niconst;
	switch (e->Nop) {
	case Q_PLUS:	if (eleft->Ntype != e->Nright->Ntype)
			    return e;		/* Give up if int+ptr */
			l += l2;	break;
	case Q_MINUS:	l -= l2;	break;	/* l integ, so l2 is integ */
	case Q_MPLY:	l *= l2;	break;
	case Q_DIV:	l /= l2;	break;
	case Q_MOD:	l %= l2;	break;
	case Q_ANDT:	l &= l2;	break;
	case Q_OR:	l |= l2;	break;
	case Q_XORT:	l ^= l2;	break;
	case Q_LSHFT:	l <<= l2;	break;
	case Q_RSHFT:	l >>= l2;	break;

	case Q_EQUAL:	log = l == l2;	break;
	case Q_NEQ:	log = l != l2;	break;
	case Q_LESS:	log = l  < l2;	break;
	case Q_GREAT:	log = l  > l2;	break;
	case Q_LEQ:	log = l <= l2;	break;
	case Q_GEQ:	log = l >= l2;	break;
	default:
	    return e;
	}
	if (log >= 0) return setlog(e, log);
	eleft->Niconst = l;
	return copyflag(eleft, e);

    case TS_UINT:
    case TS_ULONG:
	ul = eleft->Niconst;
	ul2 = e->Nright->Niconst;
	switch (e->Nop) {
	case Q_PLUS:	if (eleft->Ntype != e->Nright->Ntype)
			    return e;		/* Give up if int+ptr */
			ul += ul2;	break;
	case Q_MINUS:	ul -= ul2;	break;	/* ul integ, so ul2 is integ */
	case Q_MPLY:	ul *= ul2;	break;
	case Q_DIV:	ul /= ul2;	break;
	case Q_MOD:	ul %= ul2;	break;
	case Q_ANDT:	ul &= ul2;	break;
	case Q_OR:	ul |= ul2;	break;
	case Q_XORT:	ul ^= ul2;	break;
		/* For shifts, don't apply convs to right operand! */
	case Q_LSHFT:	ul <<= e->Nright->Niconst;	break;
	case Q_RSHFT:	ul >>= e->Nright->Niconst;	break;

	case Q_EQUAL:	log = ul == ul2;	break;
	case Q_NEQ:	log = ul != ul2;	break;
	case Q_LESS:	log = ul  < ul2;	break;
	case Q_GREAT:	log = ul  > ul2;	break;
	case Q_LEQ:	log = ul <= ul2;	break;
	case Q_GEQ:	log = ul >= ul2;	break;
	default:
	    return e;
	}
	if (log >= 0) return setlog(e, log);
	eleft->Niconst = ul;
	return copyflag(eleft, e);

    case TS_FLOAT:
	f = eleft->Nfconst;
	f2 = e->Nright->Nfconst;
	switch (e->Nop) {
	case Q_PLUS:	f += f2;	break;
	case Q_MINUS:	f -= f2;	break;
	case Q_MPLY:	f *= f2;	break;
	case Q_DIV:	f /= f2;	break;

	case Q_EQUAL:	log = f == f2;	break;
	case Q_NEQ:	log = f != f2;	break;
	case Q_LESS:	log = f  < f2;	break;
	case Q_GREAT:	log = f  > f2;	break;
	case Q_LEQ:	log = f <= f2;	break;
	case Q_GEQ:	log = f >= f2;	break;
	default:
	    return e;
	}
	if (log >= 0) return setlog(e, log);
	eleft->Nfconst = f;
	return copyflag(eleft, e);

    case TS_DOUBLE:
    case TS_LNGDBL:
	d = eleft->Nfconst;
	d2 = e->Nright->Nfconst;
	switch (e->Nop) {
	case Q_PLUS:	d += d2;	break;
	case Q_MINUS:	d -= d2;	break;
	case Q_MPLY:	d *= d2;	break;
	case Q_DIV:	d /= d2;	break;

	case Q_EQUAL:	log = d == d2;	break;
	case Q_NEQ:	log = d != d2;	break;
	case Q_LESS:	log = d  < d2;	break;
	case Q_GREAT:	log = d  > d2;	break;
	case Q_LEQ:	log = d <= d2;	break;
	case Q_GEQ:	log = d >= d2;	break;
	default:
	    return e;
	}
	if (log >= 0) return setlog(e, log);
	eleft->Nfconst = d;
	return copyflag(eleft, e);

    case TS_PTR:
	/* Operations on constant pointers are tricky because the result
	** can depend on the runtime environment (whether running
	** with extended addressing or not, using OWGBPs or not).  However,
	** compile-time comparisons can be done in a way that
	** duplicates the machine-independent code generated for
	** runtime comparisons.
	*/
	ul = eleft->Niconst;
	ul2 = e->Nright->Niconst;
	l  = (ul  << 6) | (ul  >> (TGSIZ_WORD-6));	/* Set up L and L2 */
	l2 = (ul2 << 6) | (ul2 >> (TGSIZ_WORD-6));	/* for comparisons */
	if (l  & 040) l  ^= 077;
	if (l2 & 040) l2 ^= 077;
	switch (e->Nop) {
	case Q_PLUS:			/* Give up if pointer arith */
	case Q_MINUS:
	default:
	    return e;

	case Q_EQUAL:	log = l == l2;	break;
	case Q_NEQ:	log = l != l2;	break;
	case Q_LESS:	log = l  < l2;	break;
	case Q_GREAT:	log = l  > l2;	break;
	case Q_LEQ:	log = l <= l2;	break;
	case Q_GEQ:	log = l >= l2;	break;
	}
	return setlog(e, log);

    default:
	int_warn("evalbinop: bad type %N", e);
    }
    return e;
}

/* EVALUNOP - Evaluate operators of type TKTY_UNOP (unary operators),
**	where operand is a constant.
**	Unary ops:
**		(cast) ~ -
*/
static NODE *
evalunop(e)
NODE *e;
{
    switch (e->Nop) {
    case N_CAST:
	return evalcast(e);	/* Handles all types */

    case Q_COMPL:
	switch (e->Ntype->Tspec) {
	case TS_INT:
	case TS_LONG:
		e->Nleft->Niconst = ~ e->Nleft->Niconst;
		break;
	case TS_UINT:
	case TS_ULONG:
		e->Nleft->Niconst = ~ (unsigned long)e->Nleft->Niconst;
		break;
	default:
	    int_warn("evalunop: bad ~ %N", e);
	}
	return copyflag(e->Nleft, e);

    case N_NEG:
	switch (e->Ntype->Tspec) {
	case TS_INT:
	case TS_LONG:
		e->Nleft->Niconst = - e->Nleft->Niconst;
		break;
	case TS_UINT:
	case TS_ULONG:
		e->Nleft->Niconst = - (unsigned long)e->Nleft->Niconst;
		break;
	case TS_FLOAT:
		e->Nleft->Nfconst = - (float) e->Nleft->Nfconst;
		break;
	case TS_DOUBLE:
	case TS_LNGDBL:
		e->Nleft->Nfconst = - (double) e->Nleft->Nfconst;
		break;
	default:
	    int_warn("evalunop: bad - %N", e);
	    return e;
	}
	return copyflag(e->Nleft, e);

    case N_PTR:
	break;			/* Don't try to hack pointer constants! */
    default:
	int_warn("evalunop: bad op %N", e);
    }
    return e;
}

/* EVALB1OP - Handle binary ops where one operand isn't a constant.
**	The operator will be one of * / % + - << >> & | ^.
**	Ops which are commutative & associative (+ * & | ^) can still be folded
**	with constants farther along.
**	The bitwise ops (&^|) are always OK for unsigned ops, and OK
**	for signed if twos-complement representation is used. (True for KCC)
**	It is only OK for signed/float + and * if there is no overflow.
**		This is hard to be sure of, though.
** WARNING: non-constant operands with side effects, like "volatile",
** require special handling!
** This is why anything that reduces to a constant value calls eseqdisc()
** to turn the expression into a comma-expr if the non-constant part has
** side effects.
**
** Special cases:
**		e = any valid type (pointer, float, integral)
**		fi = float or integral
**		i = integral type (signed or unsigned)
**		ui = unsigned integral
**		si = signed integral
** Zero		   One		~Zero (-1)		Power-of-2
** fi*0 => (fi,0)  fi*1 => fi	fi*(-1) => -fi		ui*log2(n) => ui<<n
** 0/fi => (fi,0)  fi/1 => fi	fi/(-1) => -fi		ui/log2(n) => ui>>n
** 0%i  => (i,0)   i%1  =>(i,0)	si%(-1) => (si,0)	ui%log2(n) => ui&(n-1)
** fi/0	fi Warning
** i%0	(i,0) Warning
** e+0  => e
** e-0  => e
** 0-fi  => -fi
** 0<<i => (i,0)
** 0>>i => (i,0)
** i<<0 => i
** i>>0 => i
** i&0  => (i,0)		i&-1	=> i
** i|0  => i			i|-1	=> (i,-1)
** i^0  => i			i^-1	=> ~i
*/	
#define ekeepright(e) eseqdisc((e)->Nleft, (e)->Nright)
#define ekeepleft(e)  eseqdisc((e)->Nright, (e)->Nleft)

static NODE *
evalb1op(e)
NODE *e;
{
    NODE *eleft, *elast, *er, *elr;
    int assocf = 0;

    /* First see whether operator is commutative & associative,
    ** and if so we make sure the constant is on the right.  This both
    ** reduces complexity of the rest of the code and helps optimize the
    ** code generation as many PDP10 operators can take immediate
    ** constant values, which CCGEN2 tends to generate because it does the
    ** left-hand node first.
    */
    if (e->Nop == Q_PLUS || e->Nop == Q_MPLY
	  || e->Nop == Q_OR || e->Nop == Q_ANDT || e->Nop == Q_XORT) {
	assocf = 1;
	if (!eisconst(e->Nright)) {	/* Commute to get constant on right */
	    NODE *t;
	    t = e->Nleft;
	    e->Nleft = e->Nright;
	    e->Nright = t;
	}
    }

    /* At this point all we know is that the operator is a binary op and
    ** one of its operands is a constant.  If it is not an associative op, all
    ** we can do is check for special cases (see comments at start of page).
    */
#if NEW > 1
    if (tisinteg(e->Ntype)) {		/* Check integral types */
	long icon;			/* Get value of the constant */
	icon = (e->Nleft->Nop == N_ICONST
			? e->Nleft->Niconst : e->Nright->Niconst);
	if (icon >= -1 && icon <= 1)	/* Test for winning constant vals */
	switch (e->Nop) {
	case Q_MPLY:			/* Cuz commuted, const on right */
		if (icon == 0)
		    return ekeepright(e);	/* i*0 => (i,0) */
		if (icon == 1)
		    return e->Nleft;	/* i*1 => i */
		e->Nop = N_NEG;		/* i*(-1) => -i */
		return e;
		break;
	case Q_DIV:
		if (icon == 0) {
		    if (eisiconst(e->Nleft))
			return ekeepleft(e);	/* 0/i => (i,0)*/
		    advise("Division by zero ignored");
		    return e->Nleft;		/* i/0 => i */
		}
		if (eisiconst(e->Nright)) {
		    if (icon == 1)
			return e->Nleft;	/* i/1 => i */
		    if (tissigned(e->Ntype)) {
			e->Nop = N_NEG;		/* si/(-1) => -si */
			return e;
		    } else break;		/* Cannot do ui/(-1) */
		}
		break;
	case Q_MOD:
		if (icon == 0) {
		    if (eisiconst(e->Nright))
			advise("Division by zero");
		    return ekeepleft(e);	/* 0%i => (i,0)*/
		    				/* i%0 => (i,0) */
		}
		if (!eisiconst(e->Nright))	/* Ensure icon on right */
		    break;
		if (icon == 1 || tissigned(e->Ntype)) {
						/* i%1    => (i,0) */
		    e->Nright->Niconst = 0;	/* si%(-1) => (si,0) */
		    return ekeepright(e);
		}				/* Note ui%(-1) is variable! */
		break;
	case Q_PLUS:
		if (icon == 0)		/* Cuz commuted, const on rt */
		    return e->Nleft;	/* e+0 => e */
		break;
	case Q_MINUS:
		if (icon == 0 && e->Nleft->Nop==N_ICONST) {
		    e->Nop = N_NEG;	/* 0-e => -e */
		    e->Nleft = e->Nright;
		    return e;
		}
		break;
	case Q_LSHFT:			/* << same as >> here */
	case Q_RSHFT:			/* If either operand 0, */
		if (icon == 0)		/* always return left val! */
		    return ekeepleft(e);
		break;			/* Cuz 0<<i is (i,0), i<<0 is (0,i) */
	case Q_ANDT:
		if (icon == 0)		/* Cuz commuted, const on rt */
		    return ekeepright(e);	/* i&0 => (i,0) */
		if (icon == -1)
		    return e->Nleft;	/* i&(-1) => i */
		break;
	case Q_OR:
		if (icon == 0)		/* Cuz commuted, const on rt */
		    return e->Nleft;	/* i|0 => i */
		if (icon == -1)
		    return ekeepright(e);	/* i|(-1) => (i,-1)*/
		break;
	case Q_XORT:
		if (icon == 0)		/* Cuz commuted, const on rt */
		    return e->Nleft;	/* i^0 => i */
		if (icon == -1) {
		    e->Nop = Q_COMPL;	/* i^(-1) => ~i */
		    return e;
		}
		break;

	} else if (e->Nright->Nop == N_ICONST
		 && (icon&(icon-1))==0
		 && tisunsign(e->Ntype)) {
	    /* Last hope - if constant is right-hand and a power of 2,
	    ** (yes, that expression works as a test!) then
	    ** good optimizations are possible for unsigned *,/,%.
	    */
	    if (e->Nop == Q_MPLY) {	/* ui*log2(n) becomes ui<<n */
		e->Nop = Q_LSHFT;
		e->Nright->Niconst = binexp(icon);
		e->Nright->Ntype = inttype;	/* Be safe */
		return e;
	    } else if (e->Nop == Q_DIV) {	/* ui/log2(n) => ui>>n */
		e->Nop = Q_RSHFT;
		e->Nright->Niconst = binexp(icon);
		e->Nright->Ntype = inttype;
		return e;
	    } else if (e->Nop == Q_MOD) {	/* ui%log2(n) => ui&(n-1) */
		e->Nop = Q_ANDT;
		e->Nright->Niconst = icon-1;
		/* preserve prior type of constant */
		return e;
	    }
	}
    } else if (tisfloat(e->Ntype)) {	/* Check floating types */
	if (e->Ntype->Tspec != TS_LNGDBL)	/* Someday may be different */
	    switch (e->Nop) {
	    case Q_DIV:
		if (eisconst(e->Nleft) && e->Nleft->Nfconst == 0.0)
		    return ekeepleft(e);	/* 0/f => (f,0) */

		/* Drop thru to check for f/0, f/1 and f/(-1) */
	    case Q_MPLY:
		if (!eisconst(e->Nright))
		    break;
		if (e->Nright->Nfconst == 0.0) {
		    if (e->Nop == Q_DIV) {
			advise("Division by zero ignored");
			return e->Nleft;
		    }
		    return ekeepright(e);	/* f*0 => (f,0) */
		}
		if (e->Nright->Nfconst == 1.0)
		    return e->Nleft;		/* f*1 or f/1 => f */
		if (e->Nright->Nfconst == -1.0) {
		    e->Nop = N_NEG;		/* f*(-1) or f/(-1) => -f */
		    return e;
		}
		break;
	    case Q_PLUS:
		if (e->Nright->Nfconst == 0.0)
		    return e->Nleft;		/* f+0 => f */
		break;
	    case Q_MINUS:
		if (eisconst(e->Nleft) && e->Nleft->Nfconst == 0.0) {
		    e->Nop = N_NEG;
		    e->Nleft = e->Nright;
		    return e;			/* 0-f => -f */
		}
		break;
	    }
    } else {				/* Assume pointer, check + and - */
	if (eisiconst(e->Nright)	/* 0 will be on right if at all */
	  && e->Nright->Niconst == 0) {	/* (because 0+e already commuted) */
	    /* Won, e+0 or e-0 !!  But beware of funny array type conversion
	    ** sometimes applied to plus/minus pointer arithmetic; result type
	    ** may not be same as operand type.  Keep result type.
	    */
	    e->Nleft->Ntype = e->Ntype;	/* Propagate result type */
	    return e->Nleft;
	}
    }
#endif


    /* See if we can do anything associative.
    ** Move down the left-hand side of expression as long as the operator
    ** is identical to current one, and check for constant on right-hand side.
    ** If one is found, merge it in to existing constant and flush that
    ** operator instance.
    */
    if (!assocf) return e;		/* If op not assoc, that's all */
    elast = e;
    eleft = e->Nleft;
    for (; eleft->Nop == e->Nop; elast = eleft, eleft = eleft->Nleft)
	if (eisconst(eleft->Nright)) {
	    assocf = 0;			/* Zap back */
	    break;
	}
    if (assocf) return e;		/* No further ops */

    /* Win, eleft->Nright and e->Nright can be merged!
    ** do the op on them, replace e->Nright with the new result, and
    ** replace eleft's op with just eleft.  eleft's parent is elast.
    */
    er = e->Nright;
    elr = eleft->Nright;
    switch (e->Ntype->Tspec) {
    case TS_UINT:
    case TS_ULONG:
	switch (e->Nop) {
	case Q_PLUS:	er->Niconst += (unsigned long) elr->Niconst;	break;
	case Q_MPLY:	er->Niconst *= (unsigned long) elr->Niconst;	break;
	case Q_ANDT:	er->Niconst &= (unsigned long) elr->Niconst;	break;
	case Q_OR:	er->Niconst |= (unsigned long) elr->Niconst;	break;
	case Q_XORT:	er->Niconst ^= (unsigned long) elr->Niconst;	break;
	default:	return e;
	}
	break;
    case TS_INT:
    case TS_LONG:
	switch (e->Nop) {
	case Q_PLUS:	er->Niconst += (long) elr->Niconst;	break;
	case Q_MPLY:	er->Niconst *= (long) elr->Niconst;	break;
	case Q_ANDT:	er->Niconst &= (long) elr->Niconst;	break;
	case Q_OR:	er->Niconst |= (long) elr->Niconst;	break;
	case Q_XORT:	er->Niconst ^= (long) elr->Niconst;	break;
	default:	return e;
	}
	break;
    case TS_FLOAT:
	switch (e->Nop) {
	case Q_PLUS:	er->Nfconst += (float) elr->Nfconst;	break;
	case Q_MPLY:	er->Nfconst *= (float) elr->Nfconst;	break;
	default:	return e;
	}
	break;
    case TS_DOUBLE:
    case TS_LNGDBL:
	switch (e->Nop) {
	case Q_PLUS:	er->Nfconst += (double) elr->Nfconst;	break;
	case Q_MPLY:	er->Nfconst *= (double) elr->Nfconst;	break;
	default:	return e;
	}
	break;

    default:
	return e;		/* Can't do operation?? Barf and return. */
    }
    /* Now take out the eleft op */
    elast->Nleft = eleft->Nleft;
    return e;
}

/* EVALASOP - Handle assignment ops where right-hand operand is a constant.
**	The operator will be one of = *= /= %= += -= <<= >>= &= |= ^=.
**	Assignment ops always have side effects and so cannot be eliminated
**	completely -- normally.  But when the right-hand operand is a
**	constant (notably 0 or 1), some improvement is sometimes possible.
**
**	The special cases and cautions here are similar to those for
**	EVALB1OP above.  If the left-hand operand has type "volatile"
**	then improvement is never attempted because it might not result
**	in the behavior the user wanted.
**
** Special cases:
**		e = any valid type (pointer, float, integral)
**		fi = float or integral
**		i = integral type (signed or unsigned)
**		ui = unsigned integral
**		si = signed integral
Zero		One		~Zero (-1)	     Power-of-2
fi*=0 => fi=0	fi*=1	=> fi	fi*=(-1) => fi= -fi  ui*=log2(n) => ui<<=n
fi/=0	fi Warn	fi/=1	=> fi	fi/=(-1) => fi= -fi  ui/=log2(n) => ui>>=n
i%=0   i=0 Warn	i%=1	=> i=0	si%=(-1) => si=0     ui%=log2(n) => ui&=(n-1)
e+=0  => e	e+=1 => ++e	e+=-1 => --e
e-=0  => e	e-=1 => --e	e-=-1 => ++e
i<<=0 => i
i>>=0 => i
i&=0  => i=0			i&=-1	=> i
i|=0  => i			i|=-1	=> i= -1
i^=0  => i			i^=-1	=> i= ~i

*/

static NODE *
evalasop(e)
NODE *e;
{

#if NEW > 2
    if (tisvolatile(e->Nleft->Ntype))	/* If volatile dest expr, */
	return e;			/* leave whole thing alone, sigh. */

    if (tisinteg(e->Ntype)) {		/* Check integral types */
	long icon;			/* Get value of the constant */
	if (e->Nright->Nop != N_ICONST)
	    return e;			/* May be an error */
	icon = e->Nright->Niconst;
	if (icon >= -1 && icon <= 1)	/* Test for winning constant vals */
	switch (e->Nop) {
	case Q_ASMPLY:			/* Check integral *= */
		if (icon == 0)
		    e->Nop = Q_ASGN;	/* i*=0 => i=0 */
		else if (icon == 1)
		    return e->Nleft;	/* i*=1 => i */
		else e->Nop = N_NEG;	/* i*=(-1) => -i */
		break;

	case Q_ASDIV:			/* Check integral /= */
		if (icon == 0) {
		    advise("Division by zero ignored"); /* i/=0 => i */
		    return e->Nleft;
		} else if (icon == 1)
		    return e->Nleft;	/* i/=1 => i */
		else if (tissigned(e->Ntype))
		    e->Nop = N_NEG;	/* si/=(-1) => -si */
		break;			/*	(cannot do ui/(-1)) */

	case Q_ASMOD:			/* Check integral %= */
		if (!icon || icon == 1 || tissigned(e->Ntype)) {
		    if (icon == 0)		/* i%=0 => i=0 */
			advise("Division by zero");
		    e->Nright->Niconst = 0;	/* i%=1    => i=0   */
		    e->Nop = Q_ASGN;		/* si%=(-1) => si=0 */
		}				/* Note ui%(-1) is variable! */
		break;

	case Q_ASPLUS:			/* Check integral += */
		if (icon == 0)
		    return e->Nleft;	/* e+=0 => e */
		return evalincdec(e,
			(icon < 0)
			    ? N_PREDEC		/* e+=(-1) => --e */
			    : N_PREINC);	/* e-=1    => ++e */

	case Q_ASMINUS:			/* Check integral -= */
		if (icon == 0)
		    return e->Nleft;	/* e-=0 => e */
		return evalincdec(e,
			(icon < 0)
			    ? N_PREINC		/* e-=(-1) => ++e */
			    : N_PREDEC);	/* e-=1    => --e */

	case Q_ASLSH:			/* Check integral <<= and >>= */
	case Q_ASRSH:
		if (icon == 0)
		    return e->Nleft;	/* i<<=0 => i */
		break;
	case Q_ASAND:			/* Check integral &= */
		if (icon == 0)
		    e->Nop = Q_ASGN;	/* i&=0 => i=0 */
		else if (icon < 0)
		    return e->Nleft;	/* i&=(-1) => i */
		break;
	case Q_ASOR:			/* Check integral |= */
		if (icon == 0)
		    return e->Nleft;	/* i|=0 => i */
		if (icon < 0)
		    e->Nop = Q_ASGN;	/* i|=(-1) => i=(-1) */
		break;
	case Q_ASXOR:
		if (icon == 0)		/* Check integral ^= */
		    return e->Nleft;	/* i^=0 => i */
		if (icon < 0)
		    e->Nop = Q_COMPL;	/* i^=(-1) => ~i */
		break;

	} else if ((icon&(icon-1))==0
		   && tisunsign(e->Ntype)) {
	    /* Last hope - if constant is right-hand and a power of 2,
	    ** (yes, that expression works as a test!) then
	    ** good optimizations are possible for unsigned *,/,%.
	    ** Don't do it for * because multiply-to-memory is easy,
	    ** and we have no shift-to-memory instruction.
	    ** But for division it's probably worthwhile.
	    */
#if 0 /* See above comment */
	    if (e->Nop == Q_ASMPLY) {	/* ui*=log2(n) becomes ui<<=n */
		e->Nop = Q_ASLSH;
		e->Nright->Niconst = binexp(icon);
		e->Nright->Ntype = inttype;	/* Be safe */
		return e;
	    }
#endif
	    if (e->Nop == Q_ASDIV) {	/* ui/=log2(n) => ui>>=n */
		e->Nop = Q_ASRSH;
		e->Nright->Niconst = binexp(icon);
		e->Nright->Ntype = inttype;
		return e;
	    }
	    if (e->Nop == Q_ASMOD) {	/* ui%=log2(n) => ui&=(n-1) */
		e->Nop = Q_ASAND;
		e->Nright->Niconst = icon-1;
		/* preserve prior type of constant */
		return e;
	    }
	}
    } else if (tisfloat(e->Ntype)) {	/* Check floating types */
	if (e->Ntype->Tspec != TS_LNGDBL) {	/* Someday may be different */
	    double fcon;
	    if (e->Nright->Nop != N_FCONST)
		return e;			/* Just in case */
	    fcon = e->Nright->Nfconst;
	    if (fcon == 0.0 || fcon == 1.0 || fcon == -1.0) switch (e->Nop) {
	    case Q_ASMPLY:
		if (fcon == 0.0) {
		    e->Nop = Q_ASGN;		/* f*=0 => f=0 */
		    break;
		}
		/* Drop thru to check for f/0, f/1 and f/(-1) */
	    case Q_ASDIV:
		if (fcon == 0.0) {		/* f/=0 => f */
		    advise("Division by zero ignored");
		    return e->Nleft;
		} else if (fcon > 0.0)
		    return e->Nleft;		/* f*=1 or f/=1 => f */
		else e->Nop = N_NEG;		/* f*=(-1) or f/=(-1) => -f */
		break;
	    case Q_ASPLUS:
		if (fcon == 0.0)
		    return e->Nleft;		/* f+=0 => f */
		return evalincdec(e,
			(fcon > 0)
			    ? N_PREINC		/* f+=1    => ++f */
			    : N_PREDEC);	/* f+=(-1) => --f */
	    case Q_ASMINUS:
		if (fcon == 0.0)
		    return e->Nleft;		/* f-=0 => f */
		return evalincdec(e,
			(fcon > 0)
			    ? N_PREDEC		/* f-=1    => --f */
			    : N_PREINC);	/* f-=(-1) => ++f */
	    }
	}
    } else {	/* Not integral or float, must be pointer. */
	int icon;
	if (e->Nright->Nop == N_ICONST	/* Ensure integer const op */
	  && (icon = e->Nright->Niconst) >= -1
	  && icon <= 1
	  && (e->Nop == Q_ASPLUS || e->Nop == Q_ASMINUS)) {
	    if (icon == 0) {		/* ptr += 0  => ptr  */
		/* Beware of funny array type conversion
		** sometimes applied to plus/minus pointer arithmetic;
		** result type may not be same as operand type.
		** Keep result type!!
		*/
		e->Nleft->Ntype = e->Ntype;	/* Propagate result type */
		return e->Nleft;
	    }
	    return evalincdec(e,
	    	(e->Nop==Q_ASPLUS)
		? (icon > 0 ? N_PREINC : N_PREDEC)	/* p+=1 => ++p */
		: (icon > 0 ? N_PREDEC : N_PREINC));	/* p-=1 => --p */
	}
    }

#endif
    return e;
}

/* EVALINCDEC - Optimize assign op to inc/dec.  Auxiliary for EVALASOP above.
**	Used when about to change an assignment operator (type TKTY_ASOP)
** into an increment/decrement operator, to check for and flush any
** internal casts inserted by the parser.  Although the code generator
** for assignment knows how to deal with these internal casts, the inc/dec
** part doesn't.  The reason for removing them here instead of in CCGEN2's
** gincdec() is just so that if there is a problem, we can still recover
** by not doing the optimization.
** See the info in INTERN.DOC for more details about TKTY_ASOP nodes.
*/
static NODE *
evalincdec(e, op)
NODE *e;		/* Expression node being optimized */
int op;			/* Desired inc/dec op */
{
    if (e->Nleft->Nop == N_CAST) {
	/* Internal cast, must remove it.  Do check to make sure it's
	** really a valid cast (paranoia dept).  Type of operand being
	** cast must be exactly the same as the asop result type.
	*/
	if (e->Ntype != e->Nleft->Nleft->Ntype) {
	    int_warn("evalincdec: bad cast");
	    return e;			/* Don't do it */
	}
	e->Nleft = e->Nleft->Nleft;	/* Snip out the cast */
    }
    e->Nop = op;
    return e;
}

/*
** Copy flags and such across from old top node
** Used when op has been folded out but we still want to keep its info
** WARNING!  This may not work if Nflag is really being used as
** something else.  See the union definition for NODE in cc.h.
*/

static NODE *
copyflag (new, old)
NODE *new, *old;
{
    new->Ntype = old->Ntype;
    new->Nflag = old->Nflag;
    return new;
}

/* SETLOG - Sets and returns a logical operator result.
**	Node given as arg must be that of the operator (not an operand).
*/
static NODE *
setlog(e, res)
NODE *e;		/* Operator node */
int res;		/* Result (either 0 or 1) */
{
    if (e->Ntype != inttype) {
	int_error("setlog: bad type");
	e->Ntype = inttype;
    }
    e->Nop = N_ICONST;
    e->Niconst = res;
    return e;
}

/* EVALCAST - called to evaluate a constant cast expression
**	Arg is a N_CAST node; operand is one of N_ICONST, N_PCONST, N_FCONST.
** To minimize the number of conversion combinations, values are always stored
** in the constant node using the largest possible type.
** For integers this is "long":
**	If the type is unsigned, unused bits in Niconst will be 0.
**	If signed, then sign extension has been done in Niconst.
** For floating-point this is "double":
**	If the type is float, precision will have been truncated (2nd word 0).
**
*/

static NODE *
evalcast(e)
NODE *e;
{
    NODE *cn = e->Nleft;	/* Get pointer to constant node */
    TYPE *tfrom = cn->Ntype;	/* Converting from this typespec */
    TYPE *tto = e->Ntype;	/* to this one */

    switch (e->Ncast) {
	case CAST_ILL:		/* Illegal cast from error? */
	    return e;		/* Should already have complained */

	case CAST_NONE:		/* no actual conversion needed */
	    break;		/* Just copy flags and set new type */

	case CAST_VOID:		/* Any type to void type (discard constant) */
	    cn->Nop = N_VCONST;	/* Change node op to special value */
	    break;

	case CAST_IT_IT:	/* Integer type to integer type */
	    cn->Niconst = tolong(tto, cn->Niconst);
	    break;
	case CAST_FP_IT:	/* Floating-point type to integer type */
	    cn->Niconst = tolong(tto, (long) cn->Nfconst);
	    cn->Nop = N_ICONST;
	    break;
	case CAST_EN_IT:	/* Enumeration type to integer type */
	case CAST_PT_IT:	/* Pointer type to integer type */
	    cn->Niconst = tolong(tto, (long) cn->Niconst);
	    cn->Nop = N_ICONST;
	    break;

	case CAST_FP_FP:	/* Floating-point type to floating-pt type */
	    switch (castidx(tfrom->Tspec, tto->Tspec)) {
		case castidx(TS_DOUBLE,TS_FLOAT):
		case castidx(TS_LNGDBL,TS_FLOAT):
		    cn->Nfconst = (float) cn->Nfconst;
		    break;
		case castidx(TS_FLOAT,TS_DOUBLE):
		case castidx(TS_FLOAT,TS_LNGDBL):
		    cn->Nfconst = (double)(float) cn->Nfconst;
		    break;
		case castidx(TS_LNGDBL,TS_DOUBLE):
		case castidx(TS_DOUBLE,TS_LNGDBL):
		    break;
		default:
		    int_warn("evalcast: bad fp_fp");
		    break;
	    }
	    break;

	case CAST_IT_FP:	/* Integer type to floating-point type */
	    switch (tto->Tspec) {
		case TS_FLOAT:
		    if (tissigned(tfrom))
			cn->Nfconst = (float) cn->Niconst;
		    else
			cn->Nfconst = (float) (unsigned long) cn->Niconst;
		    break;
		case TS_DOUBLE:
		case TS_LNGDBL:
		    if (tissigned(tfrom))
			cn->Nfconst = (double) cn->Niconst;
		    else
			cn->Nfconst = (double) (unsigned long) cn->Niconst;
		    break;
	    }
	    cn->Nop = N_FCONST;
	    break;

	case CAST_EN_EN:	/* Enumeration type to enumeration type */
	case CAST_IT_EN:	/* Integer type to enumeration type */
	    break;

	/* The only pointer-pointer conversions we can guarantee are
	** those from byte ptrs to word ptrs.  Going the other way
	** depends on the type and the KCC runtime section and will
	** produce different results, so we have to do it at run time.
	*/
	case CAST_PT_PT:	/* Pointer type to pointer type */
	    if (tisbytepointer(tfrom) && !tisbytepointer(tto))
		    cn->Niconst = (long)(int *)(char *)(cn->Niconst);
	    else return e;
	    break;

	case CAST_IT_PT:	/* Integer type to pointer type */
	    cn->Nop = N_PCONST;
	    break;

	default:
	    int_warn("evalcast: bad cast: %d", e->Ncast);
	    return e;
    }
    return copyflag(cn, e);
}

/* TOLONG - Convert a long integer value to some intermediate type and
**	then back to a long value.
**	Note special handling for chars, which KCC allows to
**	have varied byte sizes.
*/
static long
tolong(t, val)
TYPE *t;
long val;
{
    switch(t->Tspec) {
	case TS_SHORT:	return (short) val;
	case TS_INT:	return (int) val;
	case TS_LONG:	return (long) val;
	case TS_USHORT:	return (unsigned short) val;
	case TS_UINT:	return (unsigned int) val;
	case TS_ULONG:	return (unsigned long) val;

	case TS_BITF:
	case TS_CHAR:  /* return (char) val;          */
	    if (val & (1 << (tbitsize(t)-1)))	/* If sign bit set */
		return val | (((long)-1) << tbitsize(t));
	    /* Else drop through to handle like unsigned */

	case TS_UBITF:
	case TS_UCHAR: /* return (unsigned char) val; */
	    return val & ((1<<tbitsize(t))-1);	/* Mask off */

	default:
	    int_error("tolong: bad type");
	    return 0;
    }
}

#if 0
static NODE *
setnode(new, old, nop)
NODE *new, *old;
int nop;
{
    new->Ntype = old->Ntype;
    new->Nflag = old->Nflag;
    new->Nop = nop;
    return new;
}
#endif

/* ---------------------------------------- */
/*      commute tree to canonical form      */
/* ---------------------------------------- */

#define HBAR	64			/* basic unit of complexity */

#define IDMASK	    (HBAR-1)		/* mask for quantum fluctuations */
#define	IDWEIGHT(s) (hash(s->Sname)&IDMASK) /* to permute for common subs */

#define	BWEIGHT	(4*HBAR)		/* weight for binary operator */
#define	IWEIGHT	0			/* weight for integer */
#define	SWEIGHT	(2*HBAR)		/* weight for string const */
#define	MWEIGHT	HBAR			/* weight for struct member */
#define CWEIGHT	(2*HBAR)		/* weight for coercion, unary */
#define	FWEIGHT	(32*HBAR)		/* weight for fun call - v expensive */
#define	QWEIGHT	(2*HBAR)		/* weight for ternary */

static int
ecanon(n)
NODE *n;
{
    NODE *t;
    int x, y;

    /*
    ** Return a weight for the tree, and commute subtrees.
    ** This function has two purposes:
    **   - To rearrange commutative expressions so that the more
    **     expensive operation is performed first, so that fewer
    **     registers need be allocated at once and so that moves
    **     from memory are more likely to be folded into the ops.
    **   - To permute equivalent expressions to the same canonical
    **     form, so that common subexpression elimination may be
    **     more likely to find them.
    */

    if (n) switch (n->Nop) {
    case N_ICONST:
	return IWEIGHT;
    case Q_IDENT:
	return IDWEIGHT(n->Nid)
		/* Hack so new array/funct conversion code
		** comes out looking the same as before --KLH
		*/
		+ (
		((n->Ntype != n->Nid->Stype) || n->Ntype->Tspec == TS_FUNCT)
			? CWEIGHT : 0);

    case N_SCONST:
	return SWEIGHT;
    case Q_DOT:
    case Q_MEMBER:
	return ecanon(n->Nleft) + MWEIGHT;
    case N_EXPRLIST:
	if (n->Nleft == NULL) return ecanon(n->Nright);
	return ecanon(n->Nleft) + ecanon(n->Nright);
    case N_CAST:
	return ecanon(n->Nleft) + CWEIGHT;
    case N_FNCALL:
	return (n->Nright == NULL) ? FWEIGHT : ecanon(n->Nright)+FWEIGHT;
    default:
	switch (tok[n->Nop].tktype) {
	case TKTY_BINOP:
	    x = ecanon(n->Nleft);
	    y = ecanon(n->Nright);
	    if (y > x && (n->Nop == Q_PLUS || n->Nop == Q_MPLY)) {
		t = n->Nleft;
		n->Nleft = n->Nright;
		n->Nright = t;
	    }
            return x + y + BWEIGHT;
	case TKTY_ASOP:
	case TKTY_BOOLOP:
	    return ecanon(n->Nleft) + ecanon(n->Nright) + BWEIGHT;
	case TKTY_UNOP:
	case TKTY_BOOLUN:
            return ecanon(n->Nleft)+CWEIGHT;
	case TKTY_TERNARY:
	    x = ecanon(n->Nright->Nleft);
	    y = ecanon(n->Nright->Nright);
	    if (y > x) x = y;
            return ecanon(n->Nleft) + x + QWEIGHT;
	default:
	    break;
	}
    }
    return 0;
}

#if 0	/* Comments about discarded values */

	There are three ways used internally within KCC to indicate
to the code generator that an expression's value is to be discarded:

(1) Explicit top-level cast operation, specified by user.
	Expressions starting with a N_CAST of CAST_VOID.
(2) Flag set in top-level node by evaldiscard().
	If the NF_DISCARD flag is set, the result of that expression
	is to be thrown away.
(3) Implied by statement context, as per [H&S2 7.13]:
	An expression statement.
	The first operand of a comma expression.
	The initialization and incrementation expressions in a "for" statement.

In practice more than one method is used; for example the parser
checks the statement context cases and ensures that NF_DISCARD is set
for those expressions.  The code generator does a similar
context-dependent setting as a backup.

#endif

/* EVALDISCARD - Used by CCSTMT parsing.
**	Sets flag for given expression to indicate value can be discarded,
** and propagates this flag downwards as far as possible,
** and attempts to reduce expression as much as possible, so as to
** avoid generating any code.
**
** Note: this function returns NULL if the expression was completely flushed.
**
**	A warning is printed only if two conditions hold:
** (1) the expression's type was not "void".  (If it was, then the programmer
**	has coded properly, perhaps with an explicit (void) cast.)
** (2) the top-level operator node is changed, OR the discard count has
**	been bumped.  If not then this top-level operator or its operands
**	had a side effect and thus was preserved.
**
** The sequential (,), conditional (?:), and binary logical (&&,||) operators
** are a little tricky; it is possible for these to have some of their
** sub-expressions discarded without affecting the top-level node.
** This is why the "discnt" variable exists, for an unambiguous indication
** that something was discarded.
**
** Yet another fuzzy situation exists for the cast operator, which can
** exist either due to an explicit user cast or an implicit type coercion.
** We have three choices when discarding a cast operator:
**	(1) always complain
**	(2) never complain
**	(3) complain if discarding an explicit cast; don't if discarding an
**		implicit cast.
** We implement (3) by using the NF_USERCAST flag to distinguish explicit
** from implicit casts, and only bumping the discard count for explicit
** casts.  Both are thrown away, however, which means that even an implicit
** cast will generate a warning if was the top-level node given to
** evaldiscard().  This should never happen, though, as there is no context
** in C for which a top-level implicit coercion is necessary.
*/
static int discnt;	/* Count of internal discards (see above comment) */

NODE *
evaldiscard(n)
NODE *n;
{
    NODE *dn;

    if (!n) return n;			/* Check for NULL */
    if (n->Ntype == voidtype)		/* If type is explicitly void, */
	return edisc(n);		/* never give warning message. */

    /* Must check for discards... */
    discnt = 0;			/* Reset internal flush count */
    dn = edisc(n);		/* Run it through, see what we get */
    if (dn != n || discnt)	/* If anything munged, then barf. */
	note("Discarding %s without side effects",
		    dn	? "operator"	/* If still stuff, assume just oper */
			: "expression");	/* else flushed whole expr */
    
    return dn;			/* Note this may or may not be NULL. */
}


/* ESEQDISC - Auxiliary for evalb1op and evalasop, to take care of
**	flushing the non-constant parts of an expression.
** The left and right args should be put into a "(l, r)" sequential
** expression, if the left arg has a side-effect that prevents it
** from being completely flushed.
**	edisc() is called directly to avoid provoking warning messages.
*/
static NODE *
eseqdisc(l, r)
NODE *l, *r;
{
    if (!(l = edisc(l)))	/* If can completely flush left arg, */
	return r;		/* just return right arg. */
    return ndef(N_EXPRLIST, r->Ntype, 0, l, r);
}

/* EDISC - Evaluate node, discarding anything that doesn't have
**	side effects.  This is very similar to sideffp() in CCEVAL!
**
** Note that exprs which can be lvalues must be checked for the "volatile"
** type qualifier, which counts as a side-effect.  See comments in sideffp().
*/
static NODE *
edisc(n)
NODE *n;
{
    NODE *ln, *rn;
    int savcnt;

    if (n == NULL) return n;
    n->Nflag |= NF_DISCARD;		/* Set flag for this node */

    switch(tok[n->Nop].tktype) {
	case TKTY_RWOP:		/* Reserved-word Op, similar to primary */
	    switch (n->Nop) {
		case Q_ASM:		/* asm() has side effects! */
		    return n;
	    }
	    return n;			/* Assume new ops have side effs too */

	case TKTY_PRIMARY:	/* Primary expression */
	    switch (n->Nop) {
		case N_FNCALL:			/* Funct call has side effs! */
		    return n;
		case Q_DOT:			/* May be lvalue, find out */
		    if (!(n->Nflag & NF_LVALUE))
			return edisc(n->Nleft);
		case Q_MEMBER:			/* Always an lvalue */
		    if (tisanyvolat(n->Ntype))
			return n;		/* Volatile, leave alone! */
		    ++discnt;
		    return edisc(n->Nleft);
		case Q_IDENT:
		    if (tisanyvolat(n->Ntype))
			return n;		/* Volatile, leave alone! */
		    break;
	    }
	    ++discnt;
	    return NULL;	/* All other primary exprs have no side-eff */

	case TKTY_UNOP:		/* Unary operator - check single operand */
	    switch (n->Nop) {
		case N_POSTINC: case N_PREINC:
		case N_POSTDEC: case N_PREDEC:
		    return n;		/* These four have side effects! */
		case N_CAST:		/* Cast is a bit special */
		    if ((n->Nflag & NF_USERCAST)==0)	/* If implicit cast, */
			return edisc(n->Nleft);		/* flush quietly, */
							/* without ++discnt! */
		    if (n->Ntype == voidtype) {	/* If explicit cast to void, */
			savcnt = discnt;	/* flush the rest quietly! */
			n = edisc(n->Nleft);
			discnt = savcnt;
			return n;
		    }
		    /* else drop thru to flush non-quietly! */
		    break;

		case N_PTR:			/* Always lvalue, so check */
		    if (tisvolatile(n->Ntype))	/* Check, note type will  */
			return n;		/* never be struct/union */
		    break;		/* so needn't use tisanyvolat */

		case N_ADDR:		/* Special checks to bypass qualifs */
		    switch (n->Nleft->Nop) {
			case Q_IDENT: ++discnt;	/* OK to just flush this */
				return NULL;
			case Q_DOT:
			case Q_MEMBER:
			case N_PTR:
			    ++discnt;
			    return edisc(n->Nleft->Nleft);
		    }
		    break;
	    }
	    /* Drop through to flush unary operator */

	case TKTY_BOOLUN:	/* Unary boolean operator (only '!') */
	    ++discnt;		/* Say something flushed */
	    return edisc(n->Nleft);

	case TKTY_BOOLOP:	/* Binary boolean or logical operator */
	    if (n->Nop == Q_LAND || n->Nop == Q_LOR) {
		/* Binary logical op, right-hand operand may or may not be
		** evaluated.  If it has no side effect we can flush it
		** and check the left-hand operand, but if it does then
		** we have to leave the left-hand operand alone.
		*/
		if (n->Nright = edisc(n->Nright))	/* Check 2nd val */
		    return n;			/* Can't flush it */
		++discnt;			/* Aha, note flushed and */
		return edisc(n->Nleft);		/* can now check 1st val */
	    }
	    /* Not a logical boolean operator, drop thru to treat
	    ** like binary operator
	    */
	case TKTY_BINOP:	/* Binary operator - check both operands */
	    ++discnt;			/* Will always flush something. */
	    ln = edisc(n->Nleft);
	    rn = edisc(n->Nright);
	    if (!rn) return ln;
	    if (!ln) return rn;
	    /* Still have both operands, set up to execute in sequence
	    ** by converting into a comma expression (ln,rn).
	    ** Do left first, then right, just for consistency.
	    ** Note flags already have NF_DISCARD set in them.
	    */
	    return ndef(N_EXPRLIST, rn->Ntype, rn->Nflag,
			ndef(N_EXPRLIST, ln->Ntype, ln->Nflag,
				(NODE *)NULL, ln),
			rn);

	case TKTY_ASOP:		/* Binary assignment operator */
	    break;		/* Always a side-effect operation */

	case TKTY_TERNARY:	/* Ternary operator (only '?') - check 3 ops */
	    /* First check each of the 2 possible values.
	    ** Note either may be replaced by NULL or have their types
	    ** changed so they no longer match the overall result type!
	    ** The gternary() code in CCGEN2 needs to be aware of this.
	    */
	    savcnt = discnt;			/* Remember count */
	    ln = edisc(n->Nright->Nleft);
	    rn = edisc(n->Nright->Nright);
	    if (!ln && !rn) {			/* If both values went away */
		++discnt;
		return edisc(n->Nleft);		/* Then hack condition only! */
	    }
	    /* In an attempt to avoid complaining about cases such
	    ** as (cond ? foo() : 0) which occur in macros, we check to
	    ** see whether a discard was due to the complete flushage of
	    ** a single primary value.  In this case one pointer will have been
	    ** changed to NULL (make sure it wasn't already NULL!) and the
	    ** count of discards will be only 1 greater.  If so, undo the
	    ** count so we don't complain if that was the only problem.
	    */
	    if ((!ln && n->Nright->Nleft)	/* Left changed, now NULL? */
	     || (!rn && n->Nright->Nright))	/* or right? */
		if (discnt == savcnt+1)		/* Yes, flushed just one?*/
		    --discnt;			/* If so, ignore that flush */

	    n->Nright->Nleft  = ln;
	    n->Nright->Nright = rn;
	    break;		/* Still have side effects */

	case TKTY_SEQ:		/* Sequential evaluation operator (only ',') */
	    if (!(n->Nright = edisc(n->Nright))) {	/* If zap top, */
		++discnt;
		return edisc(n->Nleft);			/* flush it. */
	    }

	    /* Keep but check the rest.  Actually it shouldn't be necessary
	    ** to check the rest, as the parser does this when it builds
	    ** the sequential expression.  But it doesn't hurt to do it again
	    ** (someday something else might build those expressions too).
	    */
	    n->Ntype = n->Nright->Ntype;	/* Update overall type */
	    n->Nleft = edisc(n->Nleft);		/* Do rest. */
	    break;

	default:
	    int_warn("edisc: non-expr %N", n);
	    break;
    }
    return n;
}

/* SIDEFFP - Returns TRUE if expression has side effects.
**	Has to trace entire expression tree, so needs to know about
** structure of parse trees.
**
**	Any read reference to a "volatile"-qualified object is also considered
** a side effect!  Read refs can only happen with lvalues, and lvalues are
** only produced by:
**	Q_IDENT (identifier)
**	N_PTR (*)
**	Q_DOT (.)
**	Q_MEMBER (->)
** Note that N_ADDR (&) is a special case because even though it takes an
** lvalue as its operand, the object is not actually referenced.  To avoid
** spuriously flagging these cases, we have to handle N_ADDR by checking
** its operand for the lvalue objects and bypassing the first level.
*/
int
sideffp(n)
NODE *n;
{
    extern char *nopname[];

    switch(tok[n->Nop].tktype) {
	case TKTY_RWOP:		/* Similar to primary expression */
	    switch (n->Nop) {
		case Q_ASM:	/* asm() code has side-eff */ 
		    return 1;
	    }
	    return 1;		/* Use safe default in case of new built-ins */

	case TKTY_PRIMARY:	/* Primary expression */
	    switch (n->Nop) {
		case N_FNCALL:	return 1;	/* Function call has side-eff*/
		case Q_DOT:			/* May be lvalue, find out */
		    if (!(n->Nflag & NF_LVALUE))
			return sideffp(n->Nleft);
		case Q_MEMBER:			/* Always an lvalue */
		    if (tisanyvolat(n->Ntype))
			return 1;
		    return sideffp(n->Nleft);	/* Check these out */
		case Q_IDENT:			/* Ident is always lvalue */
		    return tisanyvolat(n->Ntype);
	    }
	    return 0;			/* Other primaries have no side-eff */

	case TKTY_UNOP:		/* Unary operator - check single operand */
	    switch (n->Nop) {
		case N_POSTINC: case N_POSTDEC:
		case N_PREINC: case N_PREDEC:
		    return 1;
		case N_PTR:			/* Always lvalue, so check */
		    if (tisvolatile(n->Ntype))	/* Check, note type will  */
			return 1;		/* never be struct/union */
		    break;		/* so needn't use tisanyvolat */

		case N_ADDR:		/* Special checking!! */
		    switch (n->Nleft->Nop) {
			case Q_IDENT: return 0;
			case Q_DOT:
			case Q_MEMBER:
			case N_PTR:
			    return sideffp(n->Nleft->Nleft);
		    }
		    break;
	    }
	    return sideffp(n->Nleft);

	case TKTY_BOOLUN:	/* Unary boolean operator (only '!') */
	    return sideffp(n->Nleft);

	case TKTY_BINOP:	/* Binary operator - check both operands */
	case TKTY_BOOLOP:	/* Binary boolean operator - ditto */
	    return (sideffp(n->Nright) || sideffp(n->Nleft));

	case TKTY_ASOP:		/* Binary assignment operator */
	    return 1;		/* Always a side-effect operation */

	case TKTY_TERNARY:	/* Ternary operator (only '?') - check 3 ops */
	    if (sideffp(n->Nleft)) return 1;	/* Check condition */
	    n = n->Nright;	/* Then set up to check the 2 outcomes */
	    return ((n->Nright && sideffp(n->Nright))
		|| (n->Nleft && sideffp(n->Nleft)));
	
	case TKTY_SEQ:		/* Sequential evaluation operator (only ',') */
	    do if (sideffp(n->Nright)) return 1;
	    while (n = n->Nleft);
	    return 0;		/* Nothing had a side effect, so return zero */

	default:
	    int_warn("sideffp: bad op %N", n);
	    return 1;			/* Play it safe */
    }
}

/* ISTRUE - evalute boolean expression as far as we can.
**	Used only by gfor(), to see whether the loop test
**	can be omitted the first time through, and thus moved to the
**	end of the loop.
** The main difference from evalexpr() is that the expression is known
** to be of scalar type, and we also have an expression ("bindings") which
** constitutes the initial expression.  Q_IDENTs encountered during the
** evaluation are looked up in the binding expr to see if they can be resolved,
** and thus produce a constant the first time the loop test is checked.
*/
static int unset;		/* whether an unbound var was found */

int
istrue(test, bindings)
NODE *test, *bindings;
{
    unset = 0;
    return value(test, bindings) && !unset;
}

/* ---------------------------------------- */
/*      recursive expression evaluator      */
/* ---------------------------------------- */

static long
value(test, bindings)
NODE *test, *bindings;
{
    if (test == NULL) return 0;
    switch (test->Nop) {
    case N_ICONST:
	return test->Niconst;

    case Q_IDENT:
	test = lookup(test->Nid, bindings); /* find variable assignment */
	if (test == NULL) break;	/* none found, give up.  Otherwise, */
	return value(test, (NODE *)NULL); /* re-eval hoping no vars */

    case Q_LAND:
	return value(test->Nleft, bindings) && value(test->Nright, bindings);
    case Q_LOR:
	return value(test->Nleft, bindings) || value(test->Nright, bindings);
    case Q_NOT:
	return !value(test->Nleft, bindings);

    case Q_EQUAL:
	return value(test->Nleft, bindings) == value(test->Nright, bindings);
    case Q_LESS:
	return value(test->Nleft, bindings) < value(test->Nright, bindings);
    case Q_GREAT:
	return value(test->Nleft, bindings) > value(test->Nright, bindings);
    case Q_NEQ:
	return value(test->Nleft, bindings) != value(test->Nright, bindings);
    case Q_LEQ:
	return value(test->Nleft, bindings) <= value(test->Nright, bindings);
    case Q_GEQ:
	return value(test->Nleft, bindings) >= value(test->Nright, bindings);

    case Q_PLUS:
	return value(test->Nleft, bindings) + value(test->Nright, bindings);
    case Q_MINUS:
	return value(test->Nleft, bindings) - value(test->Nright, bindings);
    case Q_MPLY:
	return value(test->Nleft, bindings) * value(test->Nright, bindings);
    case Q_DIV:
	return value(test->Nleft, bindings) / value(test->Nright, bindings);
    case Q_MOD:
	return value(test->Nleft, bindings) % value(test->Nright, bindings);
    }

    /* here when unrecognized node or unbound var, remember bad expr */
    unset = 1;				/* tell caller we lost */
    return 0;				/* and pick arbitrary val to return */
}

/* ------------------------------------------------ */
/*      find an assignment to a given variable      */
/* ------------------------------------------------ */

static NODE *
lookup(var, bindings)
SYMBOL *var;
NODE *bindings;
{
    NODE *result;

    if (bindings == NULL) return NULL;
    switch (bindings->Nop) {
    case N_EXPRLIST:
	result = lookup(var, bindings->Nright);
	if (result != NULL) return result;
	else return lookup(var, bindings->Nleft);
    case Q_ASGN:
	if (bindings->Nleft->Nop == Q_IDENT && bindings->Nleft->Nid == var)
	    return bindings->Nright;
	else return NULL;
    default:
	return NULL;
    }
}
