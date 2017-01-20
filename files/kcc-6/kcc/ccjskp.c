/*	CCJSKP.C - Peephole Optimizer - skips and jumps
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.101, 29-Jul-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.67, 8-Aug-1985
**
** Original version by David Eppstein / Stanford University / 12 Jun 85
*/

#include "cc.h"
#include "ccgen.h"

/* Local prototypes */
#ifdef __STDC__
#define P_(a) a
#else
#define P_(a) ()
#endif

static void dropjump P_((PCODE *p));
static int invskip P_((PCODE *p));
static void jumptoskip P_((PCODE *p));
static void crossjump P_((PCODE *pcur,label lab));
static int newskip P_((PCODE *p));

#undef P_

/* DEADJUMP(p) - See if currently emitted code will be dead.
**
** There are three cases (yes the third one actually happens):
**  (1) The last op was an unskipped P_JRST, i.e. an unconditional jump
**  (2) The last op was an unskipped P_POPJ, i.e. an unconditional return
**  (3) The last op was an P_IFIW, i.e. we're in a switch jump table
*/

int
deadjump()
{
    if (previous) switch (previous->Pop) {
	case P_JRST:		/* jump, return, or jump table? */
	case P_POPJ:
	case P_IFIW:
	    return !prevskips(previous); /* yes, verify not skipped over */
    }
    return 0;				/* can't see or not jump, fail */
}

/* DROPSOUT(p) - See if operation can possibly affect following instructions
**
** It can't if it's a JRST, it's a POPJ, or its POF_OPSKIP field is POS_SKPA
** and it skips to an operation that can't affect the stream.
*/

int
dropsout(p)
PCODE *p;
{
    if (p == NULL) return 0;
    if (p->Pop == P_JRST || p->Pop == P_POPJ) return 1;
    if ((p->Pop & POF_OPSKIP) != POS_SKPA) return 0;
    if ((p = after(p)) == NULL || (p = after(p)) == NULL) return 0;
    return dropsout(p);
}

/* DROPJUMP(p) - Remove a jump instruction
**
** Actually this removes any instruction, but it is necessary to use if
** the instruction might be a jump so the label's refcount can be maintained.
*/

static void
dropjump(p)
PCODE *p;
{
    if ((p->Ptype & PTF_ADRMODE) == PTA_MINDEXED)
	reflabel(p->Pptr, -1);
    dropinstr(p);	/* drop the instruction & fix up previous */
}

/* INVSKIP(p) - Invert an embedded skip
**
** Takes a skip instruction in the peephole buffer and makes the code there
** skip on the opposite condition.  No new code is emmited (unlike makeskip()).
** Checks to make sure skip can't be itself skipped over.
*/

static int
invskip(p)
PCODE *p;
{
    int r;
    PCODE *q, *b;

    if (p == NULL) return 0;		/* nothing to invert */

    if (!isskip(p->Pop)) return 0;

    if (p->Pop == P_CAI+POF_ISSKIP+POS_SKPLE
      && p->Ptype == PTA_RCONST+PTF_SKIPPED
      && (q = before(p)) != NULL
      && q->Ptype == PTA_RCONST
      && q->Preg == p->Preg
      && q->Pop == P_CAI+POF_ISSKIP+POS_SKPL
      && q->Pvalue == p->Pvalue - 1) {		/* Invert the sequence: */
	q->Pop = P_CAI+POF_ISSKIP+POS_SKPE;	/*    CAIL R,n / CAILE R,n+1 */
	p->Pop = P_CAI+POF_ISSKIP+POS_SKPN;	/* to CAIE R,n / CAIN R,n+1 */
	return 1;
    }

    r = revop(p->Pop);
    if (!(r & POF_OPSKIP)) {		/* was POS_SKPA, now no skip at all */
	r &=~ POF_ISSKIP;		/* so don't think of it as a skip */
	if (r == P_TRN) {		/* was TRNA, don't need to check */
	    dropinstr(p);		/* if skipped, just drop it entirely */
	    return 1;			/* that's all for now. */
	}
	if ((q = before (p)) != NULL && (q->Pop & POF_OPSKIP) == POS_SKPA) {
	    if (!invskip(before(q))) return 0; /* two unflippable POS_SKPAs */
	    swappseudo(p, q);		/* flipped before, now them */
	    return 1;			/* win win */
	}
    }

    if (!prevskips (p)) {
	p->Pop = r;			/* single skip, invert it */
	return 1;			/* return success */
    }

    /* look for three-word flip from double comparison */
    if ((p->Ptype & PTF_ADRMODE) != PTA_REGIS || !(p->Pop & POSF_CMPSKIP) ||
	(p->Pop & POF_OPCODE) != P_CAM || (q = before (p)) == NULL ||
	(b = before (q)) == NULL || b->Pop != (p->Pop ^ POSF_EQSKIP) ||
	(b->Ptype & PTF_ADRMODE) != PTA_REGIS || b->Preg != p->Preg ||
	b->Pr2 != p->Pr2) return 0;

    /* have a doubleword compare, invert the whole thing */
    q->Pop = revop(q->Pop);
    p->Pop = revop(b->Pop);
    b->Pop = r;
    return 1;
}

/* FOLDSKIP(p) - Turn P_CAIx R,0 into something better
**
** The safechange argument is zero if it might be part of a switch
** (in which case we can't safely change the value in the reg).
*/

void
foldskip(p, safechange)
PCODE *p;
{
    PCODE *q;

    if (p == NULL) return;

    /*
    ** fold:  P_MOVE S,x
    ** 	      P_ADD S,y
    ** 	      P_CAMN R,S
    **
    ** into:  P_SUB R,x
    ** 	      P_SUB R,y
    ** 	      P_CAIN R,0
    **
    ** (only for P_CAMN and P_CAME, to avoid wrap problems).
    */

    if ((p->Pop == P_CAM+POF_ISSKIP+POS_SKPE
      || p->Pop == P_CAM+POF_ISSKIP+POS_SKPN) &&
	p->Ptype == PTA_REGIS)
    for (q = before (p); q != NULL; q = before (q)) {
	if (prevskips (q) || q->Preg != p->Pr2) break;
	switch (q->Pop) {
	case P_ADD: case P_SUB:
	    q->Preg = p->Preg;		/* swap adds across to other reg */
	    q->Pop ^= (P_ADD ^ P_SUB);	/* making them subtracts instead */
	    continue;

	case P_MOVE: case P_MOVN:
	    q->Preg = p->Preg;		/* same for P_MOVE and P_MOVN */
	    q->Pop = (q->Pop == P_MOVE? P_SUB : P_ADD); /* turned into P_SUB and P_ADD */
	    p->Pop ^= (P_CAM ^ P_CAI);	/* make immediate comparison */
	    p->Ptype = PTA_RCONST;		/* against number */
	    p->Pvalue = 0;		/* number is zero */
	}
	break;				/* escape loop if not explicit cont */
    }

    if ((p->Pop & POF_OPCODE) != P_CAI) return; /* must be P_CAIx */
    q = before(p);			/* look before it */

    if (q != NULL && q->Ptype == PTA_REGIS /* !prevskips */
     && q->Preg == p->Preg && q->Pop == P_MOVE && safechange) {

	/*
	** fold:  P_MOVE  R,S
	**        P_CAIx  R,c
	**
	** into:  P_CAIx  S,c
	*/

	p->Preg = q->Pr2;		/* flatten tested register */
	q->Pop = P_NOP;			/* flush useless move */
	q = before(q);			/* try for more optimizations */
    }

    if (q->Preg == p->Preg && q->Ptype == PTV_IMMED && safechange)
	switch(q->Pop) {
	    case P_SUB:
		if (!unsetz (q)) break;
	    case P_ADD:

		/*
		** fold:  P_ADDI  R,n
		**        P_CAIx  R,m
		**
		** into:  P_CAIx  R,m-n
		*/

		p->Pvalue -= q->Pvalue;
		q->Pop = P_NOP;			/* flush folded addition */
		q = before(q);			/* look for more before it */
	}

    /*
    ** fold:  P_CAIGE R,1
    ** into:  P_CAIG  R,0
    */

    if ((p->Ptype & PTF_ADRMODE) != PTA_RCONST) return;	/* rest of opts need numbers */

    switch (p->Pop & POF_OPSKIP) {
    case POS_SKPG:    case POS_SKPLE:		/* skip that can be adjusted up? */
	if (p->Pvalue == -1 || p->Pvalue == -2) { /* worthwhile to do it? */
	    p->Pvalue++;		/* yes, increment value */
	    p->Pop ^= POSF_EQSKIP;		/* and adjust skip to match */
	}
	break;

    case POS_SKPL:    case POS_SKPGE:		/* skip that can be adjusted down? */
	if (p->Pvalue == 1 || p->Pvalue == 2) {	/* worthwhile to do it? */
	    p->Pvalue--;		/* yes, decrement value */
	    p->Pop ^= POSF_EQSKIP;		/* and adjust skip to match */
	}
	break;
    }

    /*
    ** Fold remaining comparisons against one into P_AOSx which will
    ** later become P_AOJx.  We make P_AOS R,R rather than P_AOS R so we
    ** don't confuse the rest of code generation too badly.
    ** 
    ** All optimizations after this one can safely assume that the
    ** value being compared against is zero.
    */

    switch (p->Pvalue) {
    case 1:
	if (!safechange) return;	/* not for switch you don't */
	p->Pop ^= (P_CAI ^ P_SOS);		/* make P_SOSx */
	p->Ptype ^= (PTA_RCONST ^ PTA_REGIS);	/* from and to register */
	p->Pr2 = p->Preg;		/* same register */
	return;				/* that's all */

    case -1:
	if (!safechange) return;	/* not for switch you don't */
	p->Pop ^= (P_CAI ^ P_AOS);		/* make P_AOSx */
	p->Ptype ^= (PTA_RCONST ^ PTA_REGIS);	/* from and to register */
	p->Pr2 = p->Preg;		/* same register */
	return;				/* that's all */

    case 0: break;			/* zero is ok to continue with */
    default: return;			/* anything else we can't handle */
    }

    /*
    ** The remaining optimizations fold a test against zero with
    ** the previous instruction.
    */

    if (q->Preg != p->Preg) {
	if ((q->Pop == P_IDIV || q->Pop == P_UIDIV)
		&& q->Preg + 1 == p->Preg
		&& safechange
		&& q->Ptype == PTV_IMMED /* !prvsk */
		&& ((q->Pvalue-1)&q->Pvalue) == 0) {

	    /*
	    ** fold:  P_IDIVI R-1,2^n
	    **        P_CAIx  R,0
	    **
	    ** into:  P_TRNx  R,2^n-1
	    */

	    switch (p->Pop & POF_OPSKIP) {
	    case POS_SKPE:
	    case POS_SKPN:
		p->Pop ^= (P_CAI ^ P_TRN);
		p->Preg = q->Preg;
		p->Ptype = PTA_RCONST;
		p->Pvalue = q->Pvalue - 1;
		q->Pop = P_NOP;
		q = before(q);		/* now look at before the P_IDIVI */
		if (q->Ptype == PTA_REGIS /* !prevskips */ && q->Pop == P_MOVE &&
		    q->Preg == p->Preg) {
		    p->Preg = q->Pr2;
		    q->Pop = P_NOP;	/* flatten failed changereg() */
		}
	    }
	}
	return;
    }

    if (prevskips (q)) return;
    switch (q->Pop) {
    case P_AND:
	if (!safechange) return;
	switch (p->Pop & POF_OPSKIP) {
	case POS_SKPE:
	case POS_SKPN:

	    /*
	    ** fold:  P_AND  R,mask
	    **	      P_CAIE R,0
	    **
	    ** into:  P_TDNE R,mask
	    */

	    if (q->Ptype == PTV_IMMED) {
		q->Ptype = PTA_RCONST;
		q->Pop = p->Pop ^ (P_CAI ^ P_TRN);
	    } else q->Pop = p->Pop ^ (P_CAI ^ P_TDN);
	    break;

	default: return;
	}
	break;

    case P_MOVE:
	/*
	** fold:  P_MOVE  R,addr
	**        P_CAIx  R,0
	**
	** into:  P_SKIPx R,addr
	*/
	q->Pop = p->Pop ^ (P_CAI ^ P_SKIP);
	break;

    case P_ADD:
	if (q->Ptype != PTV_IMMED || !safechange) return;
	if (p->Pop != P_CAI+POF_ISSKIP+POS_SKPE && p->Pop != P_CAI+POF_ISSKIP+POS_SKPN) return;
	/* Now that we know we'll do the optimization, safe to clobber instr */
	q->Pvalue = - q->Pvalue;

    case P_SUB:
	if (!safechange) return;

	/*
	** fold:  P_SUB R,addr
	**  	  P_CAIN R,0
	**
	** into:  P_CAMN R,addr
	**
	** (only for P_CAMN or P_CAME, not other comparisons)
	*/

	if (p->Pop != P_CAI+POF_ISSKIP+POS_SKPE && p->Pop != P_CAI+POF_ISSKIP+POS_SKPN) return;
	q->Pop = p->Pop;		/* make comparison */
	if (q->Ptype & PTF_IMM) q->Ptype &=~ PTF_IMM; /* immediate uses P_CAI form */
	else q->Pop ^= (P_CAM ^ P_CAI);	/* memory uses P_CAM form */
	break;

    case P_AOS:	case P_SOS:

	/*
	** fold:  P_AOS   R,addr
	**        P_CAIx  R,0
	**
	** into:  P_AOSx  R,addr
	*/

	q->Pop |= (p->Pop &~ POF_OPCODE);
	break;

    default: return;
    }

    /*
    ** All the defaults in the previous switch should be return statements,
    ** so if we made it through we must have made a fold.  We should therefore
    ** flush the P_CAIx so we don't have two skips in a row.
    */

    dropinstr(p);		/* flush it, making sure previous valid */
}

/* JUMPTOSKIP(p) - Turn a jump into an immediate compare against zero.
** 
** Assumes there is one instruction between the jump and its
** label; if only zero the resulting skip should be reversed.
** Doesn't update PTF_SKIPPED in following opcodes.
*/

static void
jumptoskip (p)
PCODE *p;
{
    if ((p->Ptype &~ PTF_SKIPPED) == PTA_MINDEXED) switch (p->Pop & POF_OPCODE) {
    case P_JRST:
	if (invskip(before(p))) {	/* can flip previous skips */
	    dropjump (p);		/* so having done it just drop jump */
	    return;
	}
	reflabel (p->Pptr, -1);		/* fix up reference counts */
	p->Pop = P_TRN+POF_ISSKIP+POS_SKPA;	/* now turn it into a P_TRNA */
	p->Ptype ^= (PTA_MINDEXED ^ PTA_ONEREG); /* no address */
	p->Preg = 0;			/* no register either */
	return;

    case P_JUMP:
	reflabel (p->Pptr, -1);		/* fix up reference counts */
	p->Pop ^= (P_CAI ^ P_JUMP ^ POF_ISSKIP); /* make P_CAIx */
	p->Ptype ^= (PTA_MINDEXED ^ PTA_RCONST); /* immediate compare */
	p->Pvalue = 0;			/* against zero */
	return;

    case P_AOJ:
	reflabel (p->Pptr, -1);		/* fix up reference counts */
	p->Pop ^= (P_AOS ^ P_AOJ ^ POF_ISSKIP);	/* make P_AOSx */
	p->Ptype ^= (PTA_MINDEXED ^ PTA_REGIS);	/* reg to reg */
	p->Pr2 = p->Preg;		/* both same reg */
	return;

    case P_SOJ:
	reflabel (p->Pptr, -1);		/* fix up reference counts */
	p->Pop ^= (P_SOS ^ P_SOJ ^ POF_ISSKIP);	/* make P_SOSx */
	p->Ptype ^= (PTA_MINDEXED ^ PTA_REGIS);	/* reg to reg */
	p->Pr2 = p->Preg;		/* both same reg */
	return;
    }
}

/* CROSSJUMP(p, label) - Pull JUMPx across skips
**
** Sometimes it can improve code to move a P_JUMPx, P_AOJx, or P_SOJx from one
** side of a set of cascaded skips to the other.  We have to be careful
** though in rearranging this sort of thing that we don't get illegal
** memory references or indirection loops.
**	KLH: One problem with this code is that the two code sequences
** are not equivalent.  That is, the registers may end up with different
** values, since the skips may have modified the regs.  The initial sequence
** would not do this modification, whereas the new sequence does.
*/

static void
crossjump(pcur, lab)
PCODE *pcur;
label lab;
{
    PCODE *q, *p;
    int op;

    /*
    ** fold:  JUMPx  R,lab		; JUMPx, AOJx, or SOJx
    **	      (any number of skips)	; for JUMP, cannot change R or any mem
    **					;         also cannot use R in address
    **					; for A/SOJ, ditto + can't use R as reg
    **	pcur-> JRST   L2
    **	      lab: (or JRST lab)
    **
    ** into:  (the same skips)
    **	      JUMPy  R,L2
    **	      lab: (or JRST lab)
    */
    if (pcur->Pop != P_JRST) return;	/* must be a jump here */

    for (q = before(pcur); ; q = before(q)) {
	if (q == NULL) return;
	if (!isskip(q->Pop))		/* Non-skip instr halts loop */
	    break;
	if ((popflg[q->Pop&POF_OPCODE]&PF_MEMCHG)	/* Any mem chg instr */
	  || (q->Ptype & PTF_IND))			/* or indirect ref */
		return;					/* halts the search. */
    }
    switch (op = (q->Pop & POF_OPCODE)) {
	case P_AOJ:
	case P_SOJ:
	case P_JUMP:
	    if (q->Pptr != lab || prevskips(q))
		return;			/* Wrong label or op is skipped */

	    /* Re-scan the skips to ensure they do not use R unsafely.
	    ** For JUMP, just ensure the skip does not modify R, and does not
	    **	use it in an address.
	    ** For AOJ/SOJ, must ensure R is not referenced at all.
	    */
	    for (p = before(pcur); p != q; p = before(p)) {
		if (rinaddr(p, q->Preg) ||	/* R cannot be in addr */
		  ((op == P_JUMP)
		  ? rrchg(p, q->Preg)		/* Cannot modify R */
		  : rinreg(p, q->Preg)))	/* Cannot reference R */
		    return;
	    }
	    /* Won, OK to move and invert the jump. */
	    pcur->Preg = q->Preg;		/* else copy reg to jump on */
	    pcur->Pop = revop(q->Pop);		/* invert jump cond */
	    dropjump(q);			/* drop original JUMPx */
    }
}

/* FOLDJUMP(label) - Common optimizations for labels and jumps
**
** Called either when about to emit a jump to the given label, or when about
** to emit the label itself.  There are some things we can do in optlab()
** that we can't do here, because (for instance) we don't want to turn a
** jump two before another to the same place into a TRNA to the jump.
*/

void
foldjump(prev, lab)
PCODE *prev;		/* Instr preceding either label or the JRST to label */
label lab;
{
    PCODE *q, *b;

    if (!prev || !oneinstr(prev) ||
	(q = before(prev)) == NULL || (b = before(q)) == NULL) return;

    if (q->Pop == P_JRST
      && q->Pptr == lab
      && !(q->Ptype & PTF_IND)
      && invskip(b)) {
	/*
	** Fold:  skip		Into:	reverse-skip
	**         JRST lab		--
	**        op			 op
	**        lab: (or JRST lab)	lab: (or JRST lab)
	*/

	dropjump(q);			/* already flipped skip, drop jump */
	setskip(prev);			/* op is now skipped over */
	if (prev->Pop == P_MOVN
	  && b->Preg == prev->Preg
	  && !prevskips(b)
	  && (b->Pop == P_SKIP+POF_ISSKIP+POS_SKPG || b->Pop == P_SKIP+POF_ISSKIP+POS_SKPGE)
	  && (sameaddr(b, prev, 0)
	    || (prev->Ptype == PTF_SKIPPED+PTA_REGIS
	      && prev->Preg == prev->Pr2))) {

	    /*
	    ** fold:  SKIPGE R,x	into: MOVM R,x
	    ** 	       MOVN R,R			--
	    */
	    b->Pop = P_MOVM;		/* make MOVM */
	    dropinstr(prev);		/* drop MOVN and fix prev */
	    prev = b;			/* to point to new previous op */
	}
    } else if (isskip(q->Pop) && oneinstr(q)
		&& b->Pop == P_JRST && b->Pptr == lab
		&& invskip(before(b))) {
	/*
	** fold:  skip1
	**         JRST lab
	**        skip2		(must be skippable)
	**         op
	**    lab:  (or JRST lab)
	**
	** into:  reverse skip1
	**         reverse skip2
	**          JRST lab
	**        op
	**    lab:  (or JRST lab)
	*/

	q->Pop = revop(q->Pop);		/* reverse the second skip */
	setskip(q);			/* skip now will be skipped over */
	swappseudo(b, q);		/* switch the skip and the jump */
	clrskip(prev);			/* op no longer skipped over */
    }

    crossjump(prev, lab);		/* pull JUMPx across skips */
}

/* NEWSKIP(p) - Turn non-skip op into a skip
**
** I.e. P_MOVE becomes P_SKIPA.  Works even if op is skipped over
** (caller must check for that case).  Again, afters are not set PTF_SKIPPED.
*/

static int
newskip (p)
PCODE *p;
{
    PCODE *q;

    if (p != NULL) switch (p->Pop) {
    case P_SUB:
	if ((p->Ptype &~ PTF_SKIPPED) != PTV_IMMED || p->Pvalue != 1) break;
	p->Ptype ^= (PTV_IMMED ^ PTA_REGIS);
	p->Pr2 = p->Preg;
    case P_SOS:
	p->Pop = P_SOS+POF_ISSKIP+POS_SKPA;
	return 1;

    case P_ADD:
	if ((p->Ptype &~ PTF_SKIPPED) != PTV_IMMED || p->Pvalue != 1) break;
	p->Ptype ^= (PTV_IMMED ^ PTA_REGIS);
	p->Pr2 = p->Preg;
    case P_AOS:
	p->Pop = P_AOS+POF_ISSKIP+POS_SKPA;
	return 1;

    case P_IOR:
	if (p->Ptype & PTF_IMM) {
	    p->Pop = P_TRO+POF_ISSKIP+POS_SKPA;
	    p->Ptype &=~ PTF_IMM;
	} else p->Pop = P_TDO+POF_ISSKIP+POS_SKPA;
	return 1;

    case P_XOR:
	if (p->Ptype & PTF_IMM) {
	    p->Pop = P_TRC+POF_ISSKIP+POS_SKPA;
	    p->Ptype &=~ PTF_IMM;
	} else p->Pop = P_TDC+POF_ISSKIP+POS_SKPA;
	return 1;

    case P_SETZ:
	if ((p->Ptype &~ PTF_SKIPPED) != PTA_ONEREG) break;
	p->Pop = P_TDZ+POF_ISSKIP+POS_SKPA;
	p->Ptype ^= (PTA_ONEREG ^ PTA_REGIS);
	p->Pr2 = p->Preg;
	return 1;

    case P_SETO:   case P_MOVN:   case P_MOVE:
	if (!unsetz (p) || p->Ptype == PTV_IINDEXED) break; /* no XP_SKIPAI */
	p->Pop = P_SKIP+POF_ISSKIP+POS_SKPA;
	if ((p->Ptype &~ PTF_SKIPPED) == PTA_REGIS && (q = before (p)) != NULL &&
	    q->Preg == p->Pr2 && !prevskips (q)) switch (q->Pop & POF_OPCODE) {
	case P_SKIP: case P_AOS: case P_SOS:

	    /*
	    ** fold:  P_SKIPx S,x
	    ** 	      P_SKIPA R,S
	    **
	    ** into:  P_SKIPx R,x
	    */

	    q->Pop = revop (q->Pop);	/* invert skip */
	    q->Preg = p->Preg;		/* set reg */
	    dropinstr(p);		/* drop extra skip, fix up previous */
	}
	    
	return 1;
    }
    return 0;
}

/* UNSKIP(p) - Turn skip back into non-skip
** Undoes the actions of newskip(), and turns off conditional skips.
**
** Safe to be called on non-skip ops like P_JRST and P_POPJ.
*/

void
unskip (p)
PCODE *p;
{
    if (!isskip (p->Pop)) return;	/* be safe for P_JUMPx */
    switch (p->Pop &= POF_OPCODE) {
    case P_SOS:
	if ((p->Ptype &~ PTF_SKIPPED) != PTA_REGIS || p->Pr2 != p->Preg) return;
	p->Pop = P_SUB;			/* P_SOSA R,R */
	p->Ptype ^= (PTA_REGIS ^ PTV_IMMED);	/* becomes P_SUBI R,1 */
	p->Pvalue = 1;
	return;

    case P_AOS:
	if ((p->Ptype &~ PTF_SKIPPED) != PTA_REGIS || p->Pr2 != p->Preg) return;
	p->Pop = P_ADD;			/* P_AOSA R,R */
	p->Ptype ^= (PTA_REGIS ^ PTV_IMMED);	/* becomes P_ADDI R,1 */
	p->Pvalue = 1;
	return;

    case P_TRO:
	p->Ptype |= PTF_IMM;
    case P_TDO:
	p->Pop = P_IOR;
	return;

    case P_TRC:
	p->Ptype |= PTF_IMM;
    case P_TDC:
	p->Pop = P_XOR;
	return;

    case P_TDZ:
	if ((p->Ptype &~ PTF_SKIPPED) != PTA_REGIS || p->Pr2 != p->Preg) return;
	p->Pop = P_SETZ;			/* P_TDZA R,R */
	p->Ptype ^= (PTA_REGIS ^ PTA_ONEREG);	/* becomes P_SETZ R, */
	return;

    case P_SKIP:
	p->Pop = P_MOVE;
	if ((p->Ptype &~ PTF_SKIPPED) != PTV_IMMED || p->Pvalue != -1) return;
	p->Pop = P_SETO;
	p->Ptype ^= (PTV_IMMED ^ PTA_ONEREG);
	return;

    case P_TRN: case P_TDN: case P_TLN: case P_CAI: case P_CAM: /* no-ops */
	dropinstr(p);		/* flush it all the way, fix up previous */
	unskip(before(p));	/* make sure no spurious skippage */
    }
    /* default is safe, just op with no skip part */
}

/* OPTLAB(label) - Optimize code in front of label
**
** If we know the label is coming after the next instruction, we can
** make several changes, mostly turning jumps into skips, that improve
** code and may make it possible to avoid emitting the label.
*/

void
optlab(lab)
label lab;
{
    PCODE *p, *q, *b, *bb;

    /* Fold useless jumps and preceeding skips into nothing */
    if ((previous->Pop == P_JRST || (previous->Pop & POF_OPCODE) == P_JUMP) &&
	previous->Pptr == lab && !(previous->Ptype & PTF_IND)) {

	dropjump(previous);		/* drop the jump or skip */
	unskip(previous);		/* disable the skip before it */
    }

    p = before(previous);
    if ((p != NULL) && oneinstr(previous)
	&& (p->Pop == P_CAI+POF_ISSKIP+POS_SKPE) && (p->Ptype == PTA_RCONST)
	&& ((q = before(p)) != NULL) && (q->Pop == P_JRST) && (q->Pptr == lab)
	&& ((b = before(q)) != NULL) && !prevskips (b))
    switch(b->Pop) {
	/*
	** fold:  CAIN R,x
	**         JRST lab
	**        CAIE R,x+1
	**         instr
	**     lab:
	**
	** into:  CAIL R,x
	**         CAILE R,x+1
	**          instr
	**     lab:
	*/

    case P_AOS+POF_ISSKIP+POS_SKPN:
	if (p->Pvalue == 1) {
	    b->Pop = P_AOS+POF_ISSKIP+POS_SKPL;
	    dropjump(q);
	    p->Pop = P_CAI+POF_ISSKIP+POS_SKPLE;
	    setskip(p);
	}
	break;

    case P_SKIP+POF_ISSKIP+POS_SKPN:
	if (p->Pvalue == 1) {
	    b->Pop = P_SKIP+POF_ISSKIP+POS_SKPL;
	    dropjump(q);
	    p->Pop = P_CAI+POF_ISSKIP+POS_SKPLE;
	    setskip(p);
	}
	break;

    case P_SOS+POF_ISSKIP+POS_SKPN:
	if (p->Pvalue == 1) {
	    b->Pop = P_SOS+POF_ISSKIP+POS_SKPL;
	    dropjump(q);
	    p->Pop = P_CAI+POF_ISSKIP+POS_SKPLE;
	    setskip(p);
	}
	break;

    case P_CAI+POF_ISSKIP+POS_SKPN:
	if (b->Ptype != PTA_RCONST) break;
	if (b->Pvalue + 1 == p->Pvalue) {
	    b->Pop = P_CAI+POF_ISSKIP+POS_SKPL;
	    dropjump(q);
	    p->Pop = P_CAI+POF_ISSKIP+POS_SKPLE;
	    setskip(p);
	} else if (b->Pvalue == p->Pvalue + 1) {
	    b->Pop = P_CAI+POF_ISSKIP+POS_SKPL;
	    b->Pvalue--;		/* note foldskip unsafe here! */
	    dropjump(q);		/* might be in a recursive casejump */
	    setskip(p);
	    p->Pop = P_CAI+POF_ISSKIP+POS_SKPLE;
	    p->Pvalue++;
	}
    }					/* end switch(b->Pop) */

    foldjump(previous, lab);		/* common optimizations with JRST */
    if (!oneinstr (previous) || (p = before (previous)) == NULL) return;

    /* fold  P_JUMPx R,lab / instr / lab::  into  P_CAIx R,0 / instr */
    if (p->Pptr == lab) {
	jumptoskip(p);			/* make into skip */
	if (isskip(p->Pop)) setskip(previous); /* set instr skipped */
	crossjump(previous, lab);	/* now retry pulling JUMPx across */
	p = before(previous);		/* fix up again */
    }

    /*
    ** Remaining optimizations work for jumps over two instructions.
    ** If we don't have that, give up.
    */

    if ((q = before (p)) == NULL || (q->Ptype & PTF_ADRMODE) != PTA_MINDEXED ||
	q->Pptr != lab) return;		/* make sure some jump to lab */
					/* Actually, makes sure not indexed */
					/* and address is our label. Assumes */
					/* it must be a jump of some sort. */
    /*
    ** fold:  P_JUMPx R,$n
    **	      P_MOVE S,R
    **	      op
    **	    $n::
    **
    ** into:  P_SKIPx S,R
    **	       op
    */

    if (p->Pop == P_MOVE && p->Ptype == PTA_REGIS && q->Preg == p->Pr2 &&
	!prevskips (q)) switch (q->Pop & POF_OPCODE) {
    case P_JUMP:
	p->Pop = q->Pop ^ (P_JUMP ^ P_SKIP ^ POF_ISSKIP);
	dropjump (q);
	setskip(previous);
	optlab(lab);			/* try again */
	return;				/* tail recursively */

    case P_AOJ:
	p->Pop = q->Pop ^ (P_AOJ ^ P_AOS ^ POF_ISSKIP);
	dropjump (q);
	setskip(previous);
	optlab(lab);			/* try again */
	return;				/* tail recursively */

    case P_SOJ:
	p->Pop = q->Pop ^ (P_SOJ ^ P_SOS ^ POF_ISSKIP);
	dropjump (q);
	setskip(previous);
	optlab(lab);			/* try again */
	return;				/* tail recursively */
    }

    /* A couple of these deal with skipping over P_MOVEMs */
    /* First we must have the sequence:			  */
    /* 		MOVE REG,				  */
    /* 		MOVEM REG,				  */
    if (previous->Pop == P_MOVEM && p->Pop == P_MOVE && p->Preg == previous->Preg)
    {
	if (p->Ptype == PTV_IMMED && p->Pvalue == 1 && q->Pop == P_SOJ+POS_SKPN &&
	    !prevskips (q) && changereg (p->Preg, q->Preg, before (q))) {

	    /*
	    ** fold:  P_SOJN R,$x
	    **	      P_MOVEI S,1
	    **	      P_MOVEM S,y
	    **	    $x::
	    **
	    ** into:  P_CAIN R,1
	    **	      P_MOVEM R,y
	    */

	    dropjump (q);		/* flush P_SOJN */
	    p->Pop = P_CAI+POF_ISSKIP+POS_SKPN;	/* make skip comparison */
	    p->Ptype = PTA_RCONST;		/* immediate built in to P_CAI */
	    p->Pvalue = 1;		/* against one */
	    setskip(previous);		/* movem is now skipped over */
	    optlab(lab);		/* try again */
	    return;			/* tail recursively */
	}

	/*
	** fold:  P_MOVEM R,x
	**	  P_JUMPy S,lab
	**	  P_MOVE T,w
	**	  P_MOVEM T,x
	**
	** into:  P_CAIy S,0
	**	  P_MOVE R,y
	**	  P_MOVEM R,x
	*/

	for (b = before(q); b != NULL; b = before (b)) {
	    if (b->Pop == P_MOVEM) {
		if (prevskips(b)) b = NULL; /* If skipped, abort */
		break;
	    }
	    else switch (b->Pop & POF_OPCODE) {
	    /* Catch all PC changing instructions */
	    case P_JUMP:  case P_JRST:
	    case P_SOJ:   case P_AOJ:
	    case P_POPJ:  case P_PUSHJ:
		b = NULL;		/* And abort */
		break;
	    }
	}
	for (bb = after(b); b != NULL && bb != NULL && bb != p; bb = after(bb))
	    switch (bb->Pop & POF_OPCODE) {
		case P_MOVE: case P_ADD: case P_AOJ: case P_SOJ: case P_SKIP:
		case P_SETZ: case P_SETO: case P_IOR: case P_LDB:
		    if (bb->Preg == b->Preg)
			b = NULL;	 /* unsafe rchange, flush */
		case P_TLN: case P_TDN: case P_TRN:
		case P_CAI: case P_CAM: case P_JUMP:
		case P_JRST:
		    continue;		/* safe or not, try again or break */
		default: b = NULL;	/* not one we know */
	    }
	if (b != NULL && sameaddr(b, previous, 0)) {
	    jumptoskip (q);		/* turn jump into skip */
	    p->Preg = previous->Preg = b->Preg;	/* set registers */
	    setskip(p);		/* P_MOVE is now skipped over */
	    b->Pop = P_NOP;		/* drop first P_MOVEM */
	    if (q->Pop == P_TRN+POF_ISSKIP+POS_SKPA && invskip (before (q)))
		q->Pop = P_NOP;		/* fold P_TRNA into previous */
	    else foldskip(q, 0);	/* else safely fold ex-P_JUMP */
	    return;
	}
    }					/* end if P_MOVE and P_MOVEM */

    /*
    ** fold:  (skips)
    **	      P_JRST lab
    **	      P_MOVE R,y
    **	      instr
    **
    ** into:  (inverse skips)
    **	      P_SKIPA R,y
    **	      P_TRNA
    **	      instr
    */

    if (q->Pop != P_JRST || !newskip (p)) return;
    if (!invskip (before (q))) {
	unskip (p);			/* can't flip, undo changes */
	return;				/* and give up */
    }
    reflabel (lab, -1);			/* drop jump */
    setskip(p);				/* p skipped */
    q->Pop = P_TRN+POF_ISSKIP+POS_SKPA;		/* make P_TRNA */
    q->Ptype = PTA_ONEREG;			/* no mem ref */
    setskip(q);				/* q skipped */
    swappseudo (p, q);			/* swap P_TRNA and new P_SKIPA */
    setskip(previous);			/* previous skipped */

    if (!invskip (q)) return;		/* rest depends on flipping P_SKIPA */
    p->Pop = P_NOP;			/* if can flip, no P_TRNA */

    /*
    ** fold:  P_SKIPA R,x
    **        P_TDOA R,$BYTE
    **        P_IOR R,$BYTE
    **
    ** into:  P_MOVE R,x
    **	      P_IOR R,$BYTE
    */

    if (previous->Pop != P_IOR || (q = before (previous)) == NULL ||
	q->Pop != P_TDO+POF_ISSKIP+POS_SKPA || !sameaddr(q, previous, 0)) return;
    unskip(before(q));			/* turn prev skip off */
    q->Pop = P_NOP;			/* drop P_TDOA */
    clrskip(previous);			/* P_IOR not skipped over anymore */
}

/* UNJUMP(label) - Get rid of jump so can replace it with jumped-to label
**
** Only called once by CCGEN2's glogical().
**
** Called when we know there will only be one more instruction between
** here and the label, but we can't rely on later optimization because
** we want to emit another label here.
**
** Returns 1 or 0 depending on whether made successful skip.
** In neither case changes PTF_SKIPPED attribute of succeeding instrs.
*/

int
unjump(lab)
label lab;
{
    if (previous == NULL || previous->Pptr != lab) return 0;
    switch (previous->Pop & POF_OPCODE) {
    case P_JRST:
	dropjump(previous);		/* drop it all the way out */
	return 1;

    case P_JUMP:  case P_AOJ:  case P_SOJ:
	jumptoskip(previous);		/* make into P_CAIx */
	previous->Pop = revop(previous->Pop); /* with opposite parity */
	return 1;			/* let optlab() take care of rest */

    default:
	return 0;
    }
}

/* FOLDTRNA(p) - Attempt to get rid of a P_TRNA.
**
** Folds it into instructions ahead of it in the buffer.
** This is called late, by realcode(), to avoid confusion
** in earlier parts of the peepholer.
*/

int
foldtrna(p)
PCODE *p;
{
    PCODE *q, *a;

    if (p == NULL
      || p->Pop != P_TRN+POF_ISSKIP+POS_SKPA
      || (q = after(p)) == NULL
      || (q->Pop != P_JRST
	&& q->Pop != P_POPJ
        && (q->Pop & POF_OPSKIP) != POS_SKPA)
      || (a = after(q)) == NULL
      || !newskip(a))
		return 0;		/* no good */

    /*
    ** fold:  TRNA
    ** 	       JRST  $x
    ** 	      MOVE  R,y
    **
    ** into:  SKIPA R,y
    ** 	       JRST  $x
    */

    unskip(q);				/* turn SKIPA over op into MOVE */
    setskip(a);				/* op that skipped TRNA now skips it */
    swappseudo(q, a);			/* switch the jump and new skip */
    p->Pop = P_NOP;			/* TRNA disappears */
    return 1;				/* tell realcode() we won */
}

/* INSKIP(p) - Fold test type instruction into previous P_SKIPA+P_MOVE
*/
void
inskip (p)
PCODE *p;
{
    PCODE *q, *b;
    int skop, compl;

    if (p->Ptype != PTA_REGIS) return;	/* must be unskipped register op */

    switch (p->Pop) {			/* see what we want to fold back up */
    case P_AND: skop = P_TDZ; compl = 1; break; /* SKIPA+MOVE+AND => TDZA+AND */
    case P_IOR: skop = P_TDO; compl = 0; break; /* SKIPA+MOVE+IOR => TDOA+IOR */
    case P_XOR: skop = P_TDC; compl = 0; break; /* SKIPA+MOVE+XOR => TDCA+XOR */
    default: break;			/* can't handle anything else */
    }

    /* look for P_SKIPA and P_MOVE (with right registers) before op */
    /* we save the unsetz for last because it has side effects */
    if ((q = before (p)) == NULL || (q->Preg != p->Pr2 && q->Preg != p->Preg)
	|| (b = before (q)) == NULL || b->Pop != P_SKIP+POF_ISSKIP+POS_SKPA ||
(compl && b->Ptype != PTV_IMMED+PTF_SKIPPED) || b->Preg != q->Preg ||
	!unsetz (q)) return;

    /* found them, perform the fold */
    b->Pop = skop + POF_ISSKIP + POS_SKPA;	/* make always skipping op for P_SKIPA */
    if (b->Ptype & PTF_IMM) {		/* if immediate quantity */
	b->Ptype &=~ PTF_IMM;		/* make PTA_RCONST rather than PTV_IMMED */
	b->Pop = immedop (b->Pop);	/* and use built-in-immed op */
    }
    if (compl) b->Pvalue = ~ b->Pvalue;	/* complement mask if P_TDZA for P_AND */
    q->Pop = p->Pop;			/* and non-skip for P_MOVE (no compl) */

    /* see if result is already in right reg; if not, put it there */
    if (q->Preg == p->Pr2 || changereg (p->Preg, p->Pr2, before (b))) {
	b->Preg = q->Preg = p->Preg;	/* ok or fixed, change regs */
	dropinstr(p);			/* drop now useless op */
    } else {
	b->Preg = q->Preg = p->Pr2;	/* pre-op val in wrong reg, fix ops */
	p->Pop = P_MOVE;		/* add P_MOVE to put in right place */
    }
}
