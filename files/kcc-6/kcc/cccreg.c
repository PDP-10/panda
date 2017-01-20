/*	CCREG.C - Peephole Optimizer functions for retroactively changing regs
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.63, 26-Apr-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.30, 8-Aug-1985
**
** Original version by David Eppstein / Stanford University / 2 July 1985
*/

#include "cc.h"
#include "ccgen.h"			/* get pseudo code defs */

/* Local prototypes */
#ifdef __STDC__
#define P_(a) a
#else
#define P_(a) ()
#endif

static SYMBOL *jumplab P_((PCODE *p));
static int crossfence P_((int to,int from,PCODE *p,PCODE *dguard,PCODE *dstart));
static int creg P_((int to,int from,PCODE *p,PCODE *dguard,PCODE *dstart));
static int cregok P_((PCODE *p,int r));
static int cregbefore P_((int to,int from,PCODE *p,PCODE *dguard,PCODE *dstart));
static int craddhack P_((int to,int from,PCODE *p));
static void rvsset P_((PCODE *p));
static int rbinmem P_((PCODE *p,int r));

#undef P_

/* Data defs - see macros in ccreg.h and "rb" utilities herein */
int rbits[NREGS] = {		/* Single-register bits */
	regbit(0), regbit(1), regbit(2), regbit(3),
	regbit(4), regbit(5), regbit(6), regbit(7),
	regbit(8), regbit(9), regbit(10), regbit(11),
	regbit(12), regbit(13), regbit(14), regbit(15)
};

int drbits[NREGS] = {		/* Double-register bits */
	dregbit(0), dregbit(1), dregbit(2), dregbit(3),
	dregbit(4), dregbit(5), dregbit(6), dregbit(7),
	dregbit(8), dregbit(9), dregbit(10), dregbit(11),
	dregbit(12), dregbit(13), dregbit(14),
	regbit(15)|regbit(0)	/* Note last reg pair wraps around! */
};

/*
** Change register retroactively.
**
** changereg (to, from, p)
**    tries to change the code at and before p in the peephole buffer
**    so that the value that was previously calculated into register from
**    has now been calculated into register to.  The contents of from
**    are not defined after this operation.
**
**    The return value is 1 if the operation was a success, and 0 otherwise.
*/

int
changereg(to, from, p)
int to;
int from;
PCODE *p;
{
    return creg(to, from, p, (PCODE *)NULL, previous);
}

/* CREGUPTO - routine used by gternary() in CCGEN2 for special
**	situation where trying to make "from" be the same as "to".
**	Beyond a certain point in the buffer, "to" already contains
**	the result value for a previous evaluation, and we can no
**	longer clobber it with something else.  This point is
**	identified by any jump-type instruction to the given label;
**	we cannot scan past this without special care.
**	We use uptolab as a "fence" indicator.
*/
static SYMBOL *uptolab = NULL;

SYMBOL *
cregupto(lab)
SYMBOL *lab;		/* Label identifying the jump we can't pass over */
{
    SYMBOL *tmp = uptolab;
    uptolab = lab;
    return tmp;
}

static SYMBOL *
jumplab(p)		/* Return label for jump instr, NULL if not jump */
PCODE *p;
{
    switch (p->Pop&POF_OPCODE) {
	case P_JRST:
	case P_JUMP:
	case P_AOJ:
	case P_SOJ:
	    return p->Pptr;		/* Return label jumped to */
    }
    return NULL;
}

/* CROSSFENCE - called when jumplab() finds we're trying to cross fence.
**	Checks to see whether this is OK or not.  Currently only permits
**	a simple case; anything else is not understood and will fail.
**	Allows:
**		...
**		SKIPA To,X
**		 TRNA		; or any skip not referencing To or From
**		  JRST $upto
**		...
*/
static int
crossfence(to, from, p, dguard, dstart)
int to, from;
PCODE *p, *dguard, *dstart;
{
    if (p->Pop == P_JRST && prevskips(p)	/* A JRST, skipped over by */
      && (p = before(p))
      && (p->Pop&POF_OPSKIP)==POS_SKPA		/* an unconditional skip */
      && prevskips(p)				/* that is itself skipped */
      && !(rbincode(p)&(rbits[to]|rbits[from]))	/* and doesn't ref our regs */
      && (p = before(p))
      && p->Pop == P_SKIP+POF_ISSKIP+POS_SKPA	/* and prev is SKIPA to, */
      && p->Preg == to)
	return cregbefore(to, from, p, dguard, dstart);
    else return 0;
}

/*
** Fold negation into other ops
**
** pushneg (r, p)
**    attempts to negate the value previously calculated into r by the
**    instructions up to p.  No new instructions are added.
**    If the register is marked by the register allocator as in use,
**    we will not touch it, but no checks are made about the use
**    of the register in the instructions following p.
** pnegreg(r, p) - Same, but doesn't check for register in use.  This
**	is necessary in order for code0 to hack MOVN R,S where R == S.
*/

pushneg(r, p)
PCODE *p;
{
    if (!rfree(r)) return 0;		/* only mung finished regs */
    else return pnegreg(r, p);
}
pnegreg(r, p)
PCODE *p;
{
    while (p != NULL) {
	switch (p->Pop & (POF_OPCODE | POF_BOTH)) {
	case P_MOVN:
	case P_MOVE:
	    if (p->Preg != r) break;
	    if (prevskips (p) && !pushneg (r, before (p))) return 0;
	    p->Pop ^= (P_MOVE ^ P_MOVN);	/* turn P_MOVE into P_MOVN, vice versa */
	    return 1;

	case P_FDVR:	case P_FMPR:	case P_IMUL:
	    if (p->Preg != r) break;
	    if (!prevskips (p) && p->Ptype == PTA_REGIS &&
		pushneg (p->Pr2, before (p))) return 1;
	    break;			/* neg of either op works */

	case P_IDIV: case P_UIDIV:
	    if (p->Preg + 1 == r) r--;	/* negate dividend for remainder */
	    break;

	case P_ADD:	case P_SUB:
	    if (p->Preg != r) break;
	    if (!pushneg (r, before (p))) return 0;
	    p->Pop ^= (P_ADD ^ P_SUB);	/* swap P_ADD <=> P_SUB */
	    return 1;			/* return success */

	case P_SETZ:
	    if (p->Preg != r || prevskips (p)) break;
	    return 1;

	case P_SETO:
	    if (p->Preg != r) break;
	    if ((p->Ptype & PTF_ADRMODE) != PTA_ONEREG) return 0;
	    if (prevskips (p) && !pushneg (r, before (p))) return 0;
	    p->Pop = P_MOVE;
	    p->Ptype ^= (PTA_ONEREG ^ PTV_IMMED);
	    p->Pvalue = 1;
	    return 1;

	case P_JUMP:
	    if (p->Preg != r) break;
	    if (!pushneg (r, before (p))) return 0;
	    p->Pop = swapop (p->Pop);
	    return 1;

	case P_AOJ:   case P_SOJ:
	    if (p->Preg != r) break;
	    if (!pushneg (r, before (p))) return 0;
	    p->Pop ^= P_AOJ ^ P_SOJ ^ POSF_SWPSKIP;
	    return 1;

	case P_JRST:  case P_POPJ:
	    break;

	case P_CAI:
	    if (p->Preg != r) break;
	    if ((p->Ptype & PTF_ADRMODE) != PTA_RCONST || !pushneg (r, before (p)))
		return 0;
	    p->Pvalue = - p->Pvalue;	/* now neg, so negate comparand */
	    p->Pop = swapop (p->Pop);	/* and comparison */
	    return 1;

	case P_TRN:   case P_TDN:	case P_CAM:   case P_SKIP:
	case P_FLTR:  case P_FADR:	case P_FSBR:
	    if (p->Preg != r) break;
	default:
	    return 0;
	}
	if (p->Pindex == r) return 0;	/* can't back over index use */
	p = before (p);			/* back another op */
    }
    return 0;
}

/* UFCREG - Undo failed changereg when we don't care which register it is.
**
** We take as argument a register that might have been the destination
** reg of a call to changereg(), and look back for the P_MOVE R,S that
** would have been emitted if the register couldn't be changed.
** If we find it, we drop it and return S; otherwise we return R.
** Note that R and S are PDP-10 registers, not virtual registers.
*/

int
ufcreg(r)
{
    if (previous && previous->Ptype == PTA_REGIS /* && !prevskips */
      && previous->Pop == P_MOVE
      && previous->Preg == r
      && optobj) {
	r = previous->Pr2;	/* Remember the new reg */
	dropinstr(previous);	/* Flush now-useless move, fix "previous" */
    }
    return r;			/* Return the register to use */
}

/*
** Worker routine for changereg.
**
** This has the same calling conventions as changereg(), with the addition
** of two more arguments: dguard and dstart.  These are used to change
** registers for doubleword operations.
**
** It is mutually recursive with cregbefore().
*/

static int
creg(to, from, p, dguard, dstart)
PCODE *p, *dguard, *dstart;
{
    if (to == from) return 1;		/* already right */
    if (p == NULL) return 0;		/* nothing to change */
#if 1
    if (uptolab && uptolab == jumplab(p))	/* Moving past boundary? */
	return crossfence(to, from, p, dguard,dstart);	/* Yeah, stop. */
#endif
    if (dropsout(p)) {			/* in an alternate universe? */
	if (from == R_RETVAL)		/* want this register saved, lose */
		return 0;
	return cregbefore (to, from, p, dguard, dstart);
    }

    switch (rchange (p->Pop)) {		/* else classify op by reg changes */
    case PRC_RSET:
	if (p->Preg == to) return 0;	/* conflict, lose */
	if (p->Preg != from) return cregbefore (to, from, p, dguard, dstart);
	if (!prevskips (p) || cregok (after (p), from)) { /* make sure ok */
	    if (dguard != NULL) return 0; /* right reg num, wrong reg val */
	    if (p->Pop == P_MOVE && (p->Ptype &~ PTF_SKIPPED) == PTA_REGIS &&
		to == p->Pr2) {		/* old failed changereg? */
		p->Pop = P_NOP;		/* yes, drop it */
		if (p->Ptype & PTF_SKIPPED) unskip (before (p)); /* and prv skip */
	    } else p->Preg = to;	/* otherwise just make change */
	    return 1;			/* and return winnitude */
	}				/* otherwise treat as PRC_RCHG */
    case PRC_RCHG:
	if (p->Ptype == PTA_REGIS && p->Preg == from && p->Pr2 == to &&
	    dguard == NULL) switch (p->Pop) {
	case P_ADD: case P_IMUL: case P_IOR: case P_AND: case P_XOR:
	case P_FADR: case P_FMPR:

	    /*
	    ** code0, when it sees
	    ** 	    OP1 R,x
	    ** 	    OP2 R,S
	    ** for some commutative op2, turns it into
	    ** 	    OP1 R,x
	    ** 	    OP2 S,R
	    ** 	    P_MOVE R,S
	    ** in the hope that OP2 can fold into OP1.  We come here
	    ** when that has not happened and we are trying not to
	    ** emit the P_MOVE - if that is the case we simply switch
	    ** the two registers in OP2.
	    */

	    p->Preg = to;
	    p->Pr2 = from;
	    return 1;
	}

    case PRC_RSAME:
    case PRC_RCHG_DSAME:
	if (p->Preg == to) return 0;	/* conflict, lose */
	if (p->Preg != from) return cregbefore (to, from, p, dguard, dstart);
	if (!cregbefore (to, from, p, dguard, dstart))
	    return dguard == NULL? craddhack (to, from, p) : 0;
	p->Preg = to;			/* changed up to here so change here */
	return 1;			/* and pass success back up */

    case PRC_DCHG_RSAME:		/* P_IDIV or similar instr */
#if 0
	This code loses for the case where an "IDIVI from,x" exists, and
to+1 (ie the new remainder-clobbered register) happens to be a register
that contains a value used farther on in the code buffer.  In this lossage
case, the register had been freed, but subexpression optimization had
found it still contained a useful value, and thus re-used that value.
Thus bug is demonstrated by the file BUGDIV.C.
Until this all gets figured out, simplest to avoid messing with IDIV
completely.  Sigh.  --KLH

	if (dguard == p) {		/* already been here once? */
	    if (p->Preg != from) to = to - 1; /* yes, change right reg */
	    if (!cregbefore (to, p->Preg, p, NULL, before (p))) return 0;
	    p->Preg = to;		/* done change before and here */
	    return 1;			/* so return success */
	}
	if (p->Preg == to || p->Preg == to - 1) return 0; /* blocked */
	if (dguard != NULL && (p->Preg == from || p->Preg == from - 1))
	    return 0;			/* can't deal with two at once */
	if (p->Preg == from) {		/* first half of double chg */
	    if (to >= R_MAXREG || !rfree (from + 1)) return 0; /* check safe */
	    return creg (to + 1, from + 1, dstart, p, NULL); /* recurse */
	}
	if (p->Preg == from - 1) {	/* same but with other reg */
	    if (to <= 1 || !rfree (from - 1)) return 0;	/* check safe */
	    return creg (to - 1, from - 1, dstart, p, NULL); /* recurse */
	}
	return cregbefore (to, from, p, dguard, dstart); /* normal, continue */
#endif

    case PRC_DSAME:			/* can't deal with doublewords */
    case PRC_DSET:			/* so if it uses any of our regs */
    case PRC_DSET_RSAME:		/* then we can't do anything. */
    case PRC_DCHG:			/* otherwise we can ignore the op. */
	if (p->Preg == to || p->Preg == to - 1 || /* blocked */
	    p->Preg == from || p->Preg == from - 1) return 0; /* or bad op */
	return cregbefore (to, from, p, dguard, dstart); /* normal, continue */

    default:
	int_error("creg: bad PRC_ val");
					/* Drop through */

    case PRC_UNKNOWN:			/* Unknown changes (PUSHJ) */
	return 0;			/* give it up */
    }
}

/*
** Make sure changereg is final for skipped over op
**
** Called by changereg() when we have some op that is PRC_RSET but
** which can be skipped over.  If the control flow leading to the
** following op is never going to escape to the end of the current
** peephole buffer contents, or if the following op also sets the
** same register (and thus will be changed by the instance of
** changereg() which called the one that is calling us) we are safe.
** KLH: We must also test to see whether the "following op" references
** the same register as a mem operand, because if so then its value
** depends on the instruction BEFORE the current one, and cregok() must
** fail in order to force creg() to keep looking back.
**
** Arguments are the op after the one that was skipped over, and
** the register to be changed from.
*/

static int
cregok (p, r)
PCODE *p;
{
    if (p == NULL) return 0;
    if (rchange (p->Pop) == PRC_RSET
	&& p->Preg == r
	&& !rinaddr(p, r)) return 1;
    return dropsout (p);
}

/*
** Change register retroactively before op.
**
** This is the other helper routine for changereg().  It takes the
** same args as creg(), but it merely makes sure the register change
** will not change the given instruction before calling changereg()
** on the instruction before that one.
**
** This is mutually recursive with creg().
*/

static int
cregbefore(to, from, p, dguard, dstart)
PCODE *p, *dguard, *dstart;
{
    if (to == from) return 1;		/* already right */
#if 1
    if (uptolab && uptolab == jumplab(p))	/* Moving past boundary? */
	return crossfence(to, from, p,dguard,dstart);	/* Yeah, stop. */
#endif
    if ((from == R_RETVAL) && dropsout(p))	/* return uses AC1 */
	return 0;

    switch (p->Ptype & PTF_ADRMODE) {
    case PTA_REGIS:				/* careful of dblwords */
	if (p->Pop == P_POP) {		/* only mem change used as PTA_REGIS */
	    if (p->Pr2 == to) return 0;	/* conflict, lose */
	    else if (p->Pr2 == from) {	/* set of reg to change from */
		if (dguard != NULL) return 0; /* wrong reg val */
		p->Pr2 = to;		/* make it what we want */
		return 1;		/* win */
	    }
	}
	switch (rchange (p->Pop)) {
	case PRC_RSAME:	    case PRC_RSET:	case PRC_RCHG:
	case PRC_DSET_RSAME:   case PRC_DCHG_RSAME:
	    break;			/* mem is single word, normal case */

	case PRC_RCHG_DSAME:	case PRC_DSAME:
	case PRC_DSET:	    case PRC_DCHG: /* can't deal with doublewords */
	    if (p->Pr2 != from && p->Pr2 != from - 1 &&
		p->Pr2 != to && p->Pr2 != to - 1) break; /* safe, go on */
	default:			/* else fall through to loserville */
	    return 0;
	}				/* break falls into standard reg chk */

	if (p->Pr2 == to) return 0;	/* conflict, lose */
	if (p->Pr2 == from) {		/* need to change index */
	    if (!creg(to, from, before(p), dguard, dstart)) return 0;
	    p->Pr2 = to;		/* Change it */
	    return 1;			/* and return success */
	}
	break;				/* otherwise check prev instr */

    case PTA_MINDEXED:
    case PTA_BYTEPOINT:
	if (p->Pindex == to) return 0;	/* conflict, lose */
	if (p->Pindex == from) {	/* need to change index */
	    if (!creg(to, from, before(p), dguard, dstart)) return 0;
	    p->Pindex = to;		/* Change it */
	    return 1;			/* and return success */
	}
	break;				/* otherwise check prev instr */

    case PTA_RCONST:			/* no cared-about regs used */
    case PTA_ONEREG:
    case PTA_PCONST:
    case PTA_FCONST:
    case PTA_DCONST:
    case PTA_DCONST1:
    case PTA_DCONST2:
	break;			/* Don't need addr, just back up */

    default:
	int_error("cregbefore: bad Ptype");
	return 0;
    }
    p = before (p);			/* back up */
    return creg (to, from, p, dguard, dstart);	/* tail-recurse */
}

/*
** Change register for P_ADDI R,1
** Called by changereg() for PRC_RCHG when recursive change fails.
**
** We know that p->Preg == from, but little else.
*/

static int
craddhack(to, from, p)
PCODE *p;
{
    if (p->Ptype != PTV_IMMED || p->Pvalue != 1) return 0; /* pretest failed */
    switch (p->Pop) {			/* is opI R,1; see if P_ADDI or P_SUBI */
    case P_ADD:
	p->Pop = P_AOS;			/* P_ADDI R,1 */
	break;				/* becomes P_AOS S,R */

    case P_SUB:
	p->Pop = P_SOS;			/* similarly for P_SUBI */
	break;

    default:				/* something else */
	return 0;			/* we can't handle it */
    }

    /* Here if was P_ADDI R,1 or P_SUBI R,1.  Finish the transformation. */
    p->Ptype = PTA_REGIS;			/* make a reg-reg P_AOS */
    p->Preg = to;			/* into new register */
    p->Pr2 = from;			/* from old register */
    return 1;				/* return success */
}

/* Register information routines.
**	An instruction may do only ONE of these things to a specific register:
**	Name	R/W	Test	Action
**	-	0/0	~(R|W)	Nothing -- not used in any way
**	REF:	1/0	R & ~W	Reg value is used, but remains same.
**	SET:	0/1	~R & W	Reg is set; any old value is ignored.
**	MOD:	1/1	R & W	Reg value is used and modified.
**
** The following combined cases can be checked for:
**	USE: (REF+MOD)	R	Reg value is used; MAY be changed.
**	CHG: (SET+MOD)	W	Reg value is changed; old value MAY be used.
**	IN:  (all)	R | W	Reg is used or changed by instr.
**	-    (REF+SET)	R ^ W	Reg is read, or set, but not both.
*/
static int rvread, rvwrit;	/* Static for speed */

/*
** RBREF, RBSET, RBMOD, RBUSE, RBCHG
** RREF, RSET, RMOD, RUSE, RCHG
*/
int rbref(p) PCODE *p; { rvsset(p); return rvread & ~rvwrit; }
int rbset(p) PCODE *p; { rvsset(p); return rvwrit & ~rvread; }
int rbmod(p) PCODE *p; { rvsset(p); return rvread & rvwrit; }
int rbuse(p) PCODE *p; { rvsset(p); return rvread; }
int rbchg(p) PCODE *p; { rvsset(p); return rvwrit; }
int rbin (p) PCODE *p; { rvsset(p); return rvread | rvwrit; }

static void
rvsset(p)
PCODE *p;
{
    static int r;		/* Avoid stack fiddling, for speed */
    rvread = rvwrit = 0;

    /* First see how op deals with the Preg */
    switch (rchange(p->Pop)) {
	/* Single register */
	case PRC_RSAME:	rvread = rbits[p->Preg];	break;	/* Refed */
	case PRC_RSET_DSAME:
	case PRC_RSET:	rvwrit = rbits[p->Preg];	break;	/* Set */
	case PRC_RCHG_DSAME:
	case PRC_RCHG:	rvread = rvwrit = rbits[p->Preg];break;	/* Modified */

	/* Double register */
	case PRC_DSAME:	rvread = drbits[p->Preg]; break;	/* Refed */
	case PRC_DSET_RSAME:
	case PRC_DSET:	rvwrit = drbits[p->Preg]; break;	/* Set */
	case PRC_DCHG_RSAME:
	case PRC_DCHG:	rvread = rvwrit = drbits[p->Preg];break; /* Modified */

	case PRC_UNKNOWN:
	    if (p->Pop == P_PUSHJ) {		/* If PUSHJ, can do a little */
		rvread = rbits[p->Preg];	/* Refs the stack register */
		rvwrit = ~rvread;		/* Sets all but stack reg */
	    } else				/* If completely unknown, */
		rvread = rvwrit = ~0;		/* must assume everything! */
	    break;

	default:
	    int_error("rbitset: bad rchange");
    }

    /* Now see if reg is used in address or as memory operand. */
    switch (p->Ptype & PTF_ADRMODE) {
    case PTA_REGIS:			/* register to register */
	r = p->Pr2;			/* R used as E */
	if (p->Pop == P_DPB) {		/* Check special case of DPB x,R */
	    rvread |= rbits[r];		/* which doesn't change R */
	    return;
	}
	break;				/* Drop out to check for mem change */

    case PTA_MINDEXED:			/* addr+offset(index) */
    case PTA_BYTEPOINT:			/* [bsize,,addr+offset(index)] */
	if (p->Pindex)			/* R used as index reg? */
	    rvread |= rbits[p->Pindex];
	else if (!p->Pptr		/* No index, is R in E? */
	  && p->Poffset >= 0		/* Check for R used as E */
	  && p->Poffset < NREGS) {	/* (see rbinaddr() for more comment) */
	    r = p->Poffset;
	    break;			/* Drop out to check for mem change */
	}
	return;

    default:
	int_error("rbitset: bad adrmode");
    case PTA_RCONST:		/* Simple integer in pvalue */
    case PTA_ONEREG:		/* no address, just register */
    case PTA_PCONST:		/* [<pointer of addr+offset+bsize>] */
    case PTA_FCONST:		/* [float] */
    case PTA_DCONST:		/* [double] */
    case PTA_DCONST1:
    case PTA_DCONST2:
	return;
    }

    /* If we come here, the instruction's memory operand was a register,
    ** identified by "r".
    ** Check further to see if this memory operand is changed or not.
    ** Currently we can't distinguish between setting and modifying.
    **
    ** Note that the only instr we use which can change two words in memory
    ** is DMOVEM (DMOVNM is not used).  We shouldn't ever see a DMOVEM r,E
    ** where E is a register address, but just in case, we check anyway.
    **
    ** One special case exists (DPB x,R) where the flag testing here is
    ** too general; this is caught by the PTA_REGIS check in previous switch.
    */
    switch (rchange(p->Pop)) {
	case PRC_RSET_DSAME:
	case PRC_RCHG_DSAME:
	case PRC_DSET:
	case PRC_DCHG:
	    rvread |= drbits[r];	/* Double-word mem read operand */
	    break;
	default:
	    rvread |= rbits[r];		/* Single-word mem read operand */
    }

    if ((popflg[p->Pop & POF_OPCODE] & PF_MEMCHG)	/* If op changes mem */
      || (p->Pop & POF_BOTH)) {				/* or BOTH flag set, */
	/* Register is munged as memory operand. */
	rvwrit |= ((p->Pop & POF_OPCODE) == P_DMOVEM) ? drbits[r] : rbits[r];
    }
}

/* Slightly faster versions of RBIN when not everything is needed
**
** RBINCODE(p)	Mask of registers used by this pcode instruction.
** RBINREG(p)	Mask of registers used as reg.
** RBINADDR(p)	Mask of registers used in addr.
*/
int
rbincode(p)
PCODE *p;
{	return rbinreg(p) | rbinaddr(p);
}

int
rbinreg(p)
PCODE *p;
{
    switch (rchange(p->Pop)) {
	case PRC_RSAME:	/* nice single word op? */
	case PRC_RSET:
	case PRC_RCHG:
	case PRC_RCHG_DSAME:
	    return rbits[p->Preg];

	case PRC_DSAME:	/* nasty double word op? */
	case PRC_DSET:
	case PRC_DCHG:
	case PRC_DSET_RSAME:
	case PRC_DCHG_RSAME:
	    return drbits[p->Preg];

	default:
	    int_error("rbinreg: bad rchange");
	    /* Drop thru */

	case PRC_UNKNOWN:		/* PUSHJ */
	    return -1;			/* Assume all regs affected! */
    }
}

/* RBINMEM - Internal rtn to get reg mask when R is used as E.
**	 See whether instruction uses double-word mem operand
*/
static int
rbinmem(p, r)
PCODE *p;
{
    switch (rchange(p->Pop)) {
	case PRC_RSAME:	/* nice single word op? */
	case PRC_RSET:
	case PRC_RCHG:
	case PRC_DSET_RSAME:
	case PRC_DCHG_RSAME:
	    return rbits[r];

	case PRC_RCHG_DSAME:
	case PRC_DSAME:
	case PRC_DSET:
	case PRC_DCHG:
	    return drbits[r];

	default:
	    int_error("rbinmem: bad rchange");
	    /* Drop thru */

	case PRC_UNKNOWN:		/* PUSHJ */
	    return -1;			/* Assume all regs affected! */
    }
}

int
rbinaddr(p)
register PCODE *p;
{
    switch (p->Ptype & PTF_ADRMODE) {
    case PTA_REGIS:			/* register to register */
	return rbinmem(p, p->Pr2);	/* R used as E */

    case PTA_MINDEXED:		/* addr+offset(index) */
    case PTA_BYTEPOINT:		/* [bsize,,addr+offset(index)] */
	if (p->Pindex)		/* R used as index reg? */
	    return rbits[p->Pindex];

	/* No index, check for R used as E.  This is illegal for PTA_MINDEXED
	** and should almost never be seen for PTA_BYTEPOINT.  The only
	** exception is when extracting a bitfield from a function-returned
	** structure -- see the code for Q_DOT in CCGEN2's gprimary().
	*/
	if (!p->Pptr		/* No index, is R in E? */
	  && p->Poffset >= 0	/* Check for R used as E (semi-illegal) */
	  && p->Poffset < NREGS)
	    return rbinmem(p, p->Poffset);
	/* Drop thru to return 0 */

    case PTA_RCONST:		/* Simple integer in pvalue */
    case PTA_ONEREG:		/* no address, just register */
    case PTA_PCONST:		/* [<pointer of addr+offset+bsize>] */
    case PTA_FCONST:		/* [float] */
    case PTA_DCONST:		/* [double] */
    case PTA_DCONST1:
    case PTA_DCONST2:
	return 0;

    default:
	int_error("rbinaddr: bad adrmode");
	return -1;
    }
}

/* RRxxx(p, r) routines - same as RBxxx(p) but take a
**	register number in "r" and return TRUE if that register matches
**	one in the mask that RBxxx(p) would return.
*/
int rrref(p,r) PCODE *p; { rvsset(p); return (rvread & ~rvwrit) & rbits[r]; }
int rrset(p,r) PCODE *p; { rvsset(p); return (rvwrit & ~rvread) & rbits[r]; }
int rrmod(p,r) PCODE *p; { rvsset(p); return (rvread & rvwrit) & rbits[r]; }
int rruse(p,r) PCODE *p; { rvsset(p); return (rvread) & rbits[r]; }
int rrchg(p,r) PCODE *p; { rvsset(p); return (rvwrit) & rbits[r]; }
int rrin (p,r) PCODE *p; { rvsset(p); return (rvread | rvwrit) & rbits[r]; }


/* RINCODE(p, reg) - returns TRUE if register "reg" is used in any way
**	by the specified pseudo-op.
*/
rincode(p, reg)
PCODE *p;
int reg;
{
    return rinreg(p, reg) || rinaddr(p, reg);
}

/* RINADDR(p, reg) - returns TRUE if register "reg" is used in
**	the address of the specified pseudo-op.
*/
rinaddr(p, reg)
PCODE *p;
int reg;
{
    return rbinaddr(p) & rbits[reg];
}

/* RINREG(p, reg) - returns non-zero value if register "reg" is used as
**		a register by the specified pseudo-op.
** This value is:
**	0 - known not to be used.
**	1 - known used, single-word op.
**	2 - known used, double-word op.
**	3 - known used, as 2nd register of double-reg op.
**	4 - Assumed used, but not sure how.
**
**	Note that the default if the code can't figure something out
** is to assume the register WAS used.  Anything that calls rinreg must
** double-check the instruction before assuming that it is a simple thing
** like OP R,x.
*/
int
rinreg(p, reg)
PCODE *p;
int reg;
{
	switch (rchange(p->Pop)) {
	    case PRC_RSAME:	/* nice single word op? */
	    case PRC_RSET:
	    case PRC_RCHG:
	    case PRC_RCHG_DSAME:
		if (p->Preg == reg)		/* The one we want? */
		    return 1;			/* Say single-word op */
		break;

	    case PRC_DSAME:	/* nasty double word op? */
	    case PRC_DSET:
	    case PRC_DCHG:
	    case PRC_DSET_RSAME:
	    case PRC_DCHG_RSAME:
		if (p->Preg == reg)
		    return 2;		/* DOP R,x */
		if (p->Preg+1 == reg)
		    return 3;		/* DOP R-1, x */
		break;

	    default:
		int_error("rinreg: bad rchange");
	    case PRC_UNKNOWN:		/* PUSHJ */
		return 4;		/* Assume it was used, somehow. */
	}
    return 0;		/* Not used at all */
}
