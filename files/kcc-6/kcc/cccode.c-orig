/*	CCCODE.C - Emit pseudo-code into peephole buffer
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.315, 26-Apr-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.146, 8-Aug-1985
**
**	Original version (c) 1981 K. Chen
*/

#include "cc.h"
#include "ccgen.h"
#include <string.h>		/* For memcpy, memcmp */

/* Imported functions */
extern char *calloc();
extern PCODE *findrset();			/* CCOPT */
extern int findconst();				/* CCOPT */
extern void optlsh();				/* CCOPT */
extern int rincode(), rinaddr(), rrchg();	/* CCOPT */
extern void outc(), realcode(), outlab();	/* CCOUT */
extern void cleanlabs(), freelabel();		/* CCSYM */
extern int changereg(), ufcreg();
extern int pnegreg(), pushneg(), sameaddr(), alias(), localbyte();
extern void inskip();
extern void foldskip(), foldmove(), foldboth(),
	foldbp(), foldbyte(), foldadjbp(), foldplus(),
	foldjump();
extern int foldidx(), foldstack(), hackstack();
extern void reflabel(), optlab();

/* Exported functions */
PCODE *before(), *after(), *newcode();
void fixprev(), flushcode(), dropinstr();
int codcreg();
void codek0(), codek4(), code4s(),
	code0(), code00(),
	code1(), codr1(), codebp(), code4(), code5(),
	code6(), codemdx(), code8(), code9(), code10(), codr10(),
	code11(), code12(), code13(), code14(), code15(),
	code16(), code17(),
	codestr(), codlabel(), codgolab();
int immedop();
PCODE *chkmref();

/* Internal functions */
static void codrmdx();
static void codr8();
static void flsprev();

/* PEEPHOLER DEBUGGING ROUTINES */

/*	SHOALL and SHOCURCOD are intended to be called directly by
**	IDDT during debugging, e.g. as in PUSHJ 17,SHOALL$X
*/
static void shoall(), shocurcod(), shopcod(), shoop(),
		shohdr(), shocum(), shocmp();

static void
shoall()
{
    int i;
    for (i = mincode; i < maxcode; i++)
	shopcod(stderr, &codes[i&(MAXCODE-1)], i&(MAXCODE-1));
}

static void
shocurcod() {	shopcod(stderr, previous, codes-previous); }


/* SHOHDR - Called at start of each CODEnn function.
**	Ensures consistent trace of all calls from CCGEN2 to CCCODE.
*/
static void
shohdr(loc, op, r)
char *loc;
int op, r;
{
    fprintf(fpho, "%s: %o=", loc, op);
    shoop(fpho, op);
    if (r) fprintf(fpho, " %o,", r);
    else fputc(' ', fpho);
}

/* SHOPCOD - Show one pseudo-code entry
**	Used as auxiliary for other debug printing routines, never called
**	directly by IDDT.
*/
static void
shopcod(f,p,idx)
FILE *f;
PCODE *p;
{
    unsigned int i;

    fprintf(f,"codes[%d] %6o/ %4o %5o %2o %6o %6o %2o %o+%o\n\t",
		idx, p, p->Ptype, p->Pop, p->Preg, p->Pptr,
		p->Poffset, p->Pindex, p->Pdouble1, p->Pdouble2);

    /* Output value of Pop field */
    shoop(f, p->Pop);

    /* Output value of Ptype field */
    fputs(" <", f);
    if (p->Ptype&PTF_IMM) fputs("Imm,", f);
    if (p->Ptype&PTF_SKIPPED) fputs("Skipped,", f);
    if (p->Ptype&PTF_IND) fputs("Indirect", f);
    fputs("> ", f);

    /* Now interpret the rest of the instruction according to mode */
    switch (i = (p->Ptype&PTF_ADRMODE)) {
	case PTA_ONEREG:		/* no address, just register */
	    fprintf(f, "ONEREG R=%o,", p->Preg);
	    break;
	case PTA_REGIS:			/* register to register */
	    fprintf(f, "REGIS R=%o, R=%o", p->Preg, p->Pr2);
	    break;
	case PTA_MINDEXED:		/* addr+offset(index) */
	    fprintf(f, "MINDEXED R=%o, Addr=%s+%o(%o) siz %o", p->Preg,
		(p->Pptr ? p->Pptr->Sname : ""),
		p->Poffset, p->Pindex, p->Pbsize);
	    break;
	case PTA_BYTEPOINT:		/* [bsize,,addr+offset(index)] */
	    fprintf(f, "BYTEPOINT R=%o, BP=[%o,,%s+%o(%o)]", p->Preg,
		p->Pbsize,
		(p->Pptr ? p->Pptr->Sname : ""),
		p->Poffset,
		p->Pindex);
	    break;
	case PTA_PCONST:		/* [<pointer of addr+offset+bsize>] */
	    if (p->Pbsize)
		fprintf(f, "PCONST R=%o, bptr%d=[%s+%o]", p->Preg,
			p->Pbsize,
			(p->Pptr ? p->Pptr->Sname : ""),
			p->Poffset);
	    else 
		fprintf(f, "PCONST R=%o, Wptr=[%s+%o]", p->Preg,
			(p->Pptr ? p->Pptr->Sname : ""),
			p->Poffset);
	    break;
	case PTA_RCONST:		/* Simple integer in pvalue */
	    fprintf(f, "RCONST R=%o, Constant=%o", p->Preg, p->Pvalue);
	    break;
	case PTA_FCONST:		/* [single-prec float] */
	    fprintf(f, "FCONST R=%o, Fltcon=%g", p->Preg, p->Pfloat);
	    break;
	case PTA_DCONST:		/* [double-prec float] */
	    fprintf(f, "DCONST R=%o, Dblcon=%g", p->Preg, p->Pdouble);
	    break;
	case PTA_DCONST1:		/* [1st wd of double float] */
	    fprintf(f, "DCONST1 R=%o, 1st wd of dblcon=%g", p->Preg, p->Pdouble);
	    break;
	case PTA_DCONST2:		/* [2nd wd of double float] */
	    fprintf(f, "DCONST2 R=%o, 2nd wd of dblcon=%g", p->Preg, p->Pdouble);
	    break;
	default:
	    fprintf(f, "Illegal ADRMODE value = %o", i);
    }
    fputc('\n', f);
}

/* SHOOP - Auxiliary for above two routines, just outputs string for opcode.
*/
static void
shoop(f, op)
FILE *f;
unsigned op;
{
    /* Test conditions, indexed by POF_OPSKIP field */
    static char *shoskt[] = { "", "A", "E", "N", "L", "GE", "G", "LE" };

    fputs(popostr[op&POF_OPCODE], f);
    if (op&(~POF_OPCODE)) {
	if (op&POF_ISSKIP) fputs("+skp", f);
	if (op&POF_OPSKIP) {
	    fputc('+', f);
	    fputs(shoskt[(op&POF_OPSKIP)>>POF_OPSKIP_SHF], f);
	}
	if (op&POF_BOTH) fputs("+B", f);
    }
}

/* More debug stuff.  Pcode buffer compare, to show what's changed. */

static int cmpcnt = 0;		/* Count of times compare done */
static PCODE *oldcodes = NULL;
static int omaxcode = 0, omincode = 0;

static void
shocum()
{
    fprintf(fpho, "----------- Update %3d -----------------\n", cmpcnt++);
    shocmp(fpho);
    fprintf(fpho, "----------------------------------------\n");
}

/* SHOCMP - Output a buffer comparison */
static void
shocmp(f)
FILE *f;
{
    PCODE *p, *q;
    int i, lim;

    if (oldcodes == NULL)	/* Ensure old buffer copy exists */
	if (!(oldcodes = (PCODE *)calloc(sizeof(codes), 1))) {
	    error("No memory for pcode buffer");
	    return;
	}

    /* First check for new code prior to last stuff */
    if (mincode < omincode) {
	fprintf(f,"    NEW---- stuff prior to start of last check:\n");
	for (i = mincode; i < omincode; ++i) {
	    fprintf(f, "    NEW ");
	    shopcod(f, &codes[i&(MAXCODE-1)], i&(MAXCODE-1));
	}
    }
    /* Then check for old code prior to current new start */
    else if (omincode < mincode) {
	fprintf(f,"    OLD---- stuff flushed from start of current code:\n");
	for (i = omincode; i < mincode; ++i) {
	    fprintf(f, "    OLD ");
	    shopcod(f, &oldcodes[i&(MAXCODE-1)], i&(MAXCODE-1));
	}
    }

    /* Now compare stuff that's in both buffers */
    lim = (maxcode < omaxcode) ? maxcode : omaxcode;	/* Find smallest */
    for (i = mincode; i < lim; ++i) {
	p = &codes[i&(MAXCODE-1)];
	q = &oldcodes[i&(MAXCODE-1)];
	if (memcmp((char *)p, (char *)q, sizeof(PCODE)) == 0)
	    continue;			/* Compared OK, keep going */
	fprintf(f, "    ----Changed\n    OLD ");
	shopcod(f, q, i&(MAXCODE-1));
	fprintf(f, "    ----to\n    NEW ");
	shopcod(f, p, i&(MAXCODE-1));
	fprintf(f, "    -----------\n");
    }

    /* Now check for new code added after last stuff */
    if (maxcode > omaxcode) {
	fprintf(f,"    ADD---- New stuff:\n");
	for (i = omaxcode; i < maxcode; ++i) {
	    fprintf(f, "    ADD ");
	    shopcod(f, &codes[i&(MAXCODE-1)], i&(MAXCODE-1));
	}
    }
    /* Then check for old code still existing at end */
    else if (maxcode < omaxcode) {
	fprintf(f,"    OLD---- stuff flushed from end:\n");
	for (i = maxcode; i < omaxcode; ++i) {
	    fprintf(f, "    OLD ");
	    shopcod(f, &oldcodes[i&(MAXCODE-1)], i&(MAXCODE-1));
	}
    }

    /* Now update our copy in preparation for next check */
    memcpy((char *)oldcodes, (char *)codes, sizeof(codes));
    omincode = mincode;
    omaxcode = maxcode;
}

/* BASIC PSEUDO-CODE AUXILIARIES */

/* NEWCODE - Get a new pseudo-code record.
**	Sets "previous" to the returned pointer, for global access.
*/
static int prvskip = 0;	/* Used by newcode/flushcode to remember if skipping */

#define OVERINC	20		/* Number of ops to force out on overflow */

PCODE *
newcode(type, op, reg)
{
    PCODE *p;
    int i;
    int skipped;

    /* fixprev(); */		/* Don't need if all other code is careful */
    if (previous)
	skipped = isskip(previous->Pop)		/* If prev was skip, */
			? PTF_SKIPPED : 0;	/* say new instr is skipped! */
    else skipped = prvskip;			/* No prev, ask flushcode */

    p = &codes[maxcode++ & (MAXCODE - 1)];	/* Get ptr to new instr */
    if (maxcode >= mincode + MAXCODE - 1)	/* Overflow?  If so, */
	for (i = 0; i < OVERINC; i++)		/* force some instrs out */
	    realcode(&codes[(mincode++)&(MAXCODE-1)]);

    p->Ptype = type | skipped;
    p->Pop = op;
    p->Preg = reg;
    return previous = p;		/* Set "previous" to new instr */
}

/* BEFORE(p) - Return live instruction preceding this one.
** AFTER(p)  - Return live instruction succeeding this one.
*/
PCODE *
before(p)
PCODE *p;
{
    PCODE *b;

    if (p == NULL) return NULL;		/* make sure we have a real pseudo */
    b = &codes[mincode&(MAXCODE-1)];
    while (1) {
	if (p == b) return NULL;	/* start of buffer, can't back up */
	--p;				/* back before here */
	if (p < &codes[0]) p = &codes[MAXCODE-1]; /* wrap in circular buffer */
	if (p->Pop != P_NOP) return p;	/* got a real op, return with it */
    }
}

PCODE *
after(p)
PCODE *p;
{
    PCODE *b = &codes[maxcode&(MAXCODE-1)];

    if (p == NULL) return NULL;		/* make sure we have a real pseudo */
    while (1) {
	if (++p > &codes[MAXCODE-1]) p = &codes[0]; /* wrap */
	if (p == b) return NULL;	/* end of buffer, no more code */
	if (p->Pop != P_NOP) return p;	/* got a real op, return with it */
    }
}

/* SWAPPSEUDO(a,b) - swap two pseudo code locations
*/

swappseudo(a,b)
PCODE *a, *b;
{
    PCODE temp;

    temp = *b;		/* Copy the structure to temp place */
    *b = *a;
    *a = temp;
}

/* FIXPREV() - Make sure "previous" points to something.
**
** This should be called after a pseudo-code which might be the last
** in the buffer is P_NOPed out.  It sets previous to the new last
** instruction in the peephole buffer.
**
** Someday this might also change maxcode to save buffer space.
*/
void
fixprev()
{
    if (previous && previous->Pop == P_NOP) {
	previous = before(previous);
	--maxcode;	/* We know at least one flushed, but */
			/* not sure how far back.  1 is better than nothing. */
    }
}

/* DROPINSTR(p) - Flush pseudo-code instruction (make it a NOP)
** FLSPREV() - Flush instruction that "previous" points to.
*/
void
dropinstr(p)
PCODE *p;
{
    if (p) {
	p->Pop = P_NOP;
	fixprev();	/* Fix up in case "previous" is now (or was) a NOP */
    }
}
static void
flsprev()
{	dropinstr(previous);
}

/* FLUSHCODE() - Flush peephole buffer (emit everything)
*/
void
flushcode()
{
    if (mincode < maxcode) {
	prvskip = (previous && isskip(previous->Pop))	/* If prev was skip, */
			? PTF_SKIPPED : 0;	/* remember fact for newcode */

	do realcode(&codes[(mincode++)&(MAXCODE-1)]);
	while (mincode < maxcode);
	if (debpho) {
	    fprintf(fpho,"FLUSHCODE:\n");
	    shocum();		/* Show stuff forced out. */
	}
    }
    previous = NULL;
}

/* CODCREG - Change register.
**	This is a CODxxx routine both for consistency and so that
** PHO debugging information can be output if desired.
** Returns 1 if all relevant instances of the "from" register in the
** peephole buffer were successfully changed to the "to" register.
** Otherwise returns 0 and nothing was changed.
*/
int
codcreg(to, from)
VREG *to, *from;
{
    int ret;

    (void) vrstoreal(from, to);
    ret = changereg(vrreal(to), vrreal(from), previous);
    if (ret && debpho) {
	fprintf(fpho, "CODCREG: to %o from %o\n", vrreal(to), vrreal(from));
	shocum();
    }
    return ret;
}

/* CODE0 - Generates instruction with register-only operands.
**	OP r1,r2
**
** CODE0 releases register r2 for future reassignment (although later
** peephole optimizations might notice that it hasn't been changed yet
** and re-use whatever value it contained).
**
** CODEK0 does NOT release register r2.  The assignment operators need to
** keep around two registers sometimes.
*/
static void codrrx();
static int rrpre1(), rrpre2();
static void rrpre3(), rrpopt(), rrpop2();
static PCODE *chkref();

void
codek0(op, r1, r2)	/* KEEP the second register!! */
VREG *r1, *r2;
{
    VREG *r3 = vrget();		/* Get another temp reg */
    int s = vrstoreal(r3, r2);		/* Ensure it and both regs real */
    int r = vrstoreal(r1, r2);

    vrfree(r3);
    code00(P_SETM, s, vrreal(r2));	/* Use this to avoid losing r2 */
    code00(op, r, s);
}
void
code0(op, r1, r2)
VREG *r1, *r2;
{
    int s = vrstoreal(r2, r1);		/* Make regs real ones */
    if (r1 != r2) vrfree(r2);		/* flush operand for later */
    code00(op, vrreal(r1), s);
}

void
code00(op, r, s)
int r, s;
{
    PCODE *p, *prev;

    if (debpho) {
	shohdr("CODE0", op, r);
	fprintf(fpho, "%o\n", s);
    }

    /* Simple pre-optimization. */
    s = ufcreg(s);			/* Flush failed changereg for 2nd AC */
    if ((op & POF_OPCODE) == P_CAM)	/* and other if comparison */
	r = ufcreg(r);

    /* Now just add the instruction. */
    prev = previous;			/* Remember previous, if any */
    p = newcode(PTA_REGIS, op, r);
    p->Pr2 = s;

    /* Everything else is optimization hacks */

    /* Try to avoid storing a MOVE-type op by going back through
    ** the buffer and changing code so that the operand register (s)
    ** is already the destination (r).
    ** Neither pushneg nor pnegreg creates or kills any instructions,
    ** so pointers remain safe.
    */
    if (optobj) switch (op) {
	case P_SETM:			/* Special code to avoid optimizer! */
	    break;			/* Otherwise S will get re-used. */

	case P_MOVM:			/* If case hash, also do nothing */
	    break;

	case P_MOVN:			/* fold out P_MOVN */
	    if (r == s && pnegreg(s, prev)) {	/* Try to use other instrs */
		flsprev();		/* Win, don't need MOVN at all! */
		break;
	    }
	    if (!pushneg(s, prev)) {	/* Try to negate value */
		codrrx(prev, p);	/* Didn't work, try other opts */
		break;
	    }
	    p->Pop = P_MOVE;		/* Value negated! Change op to MOVE */
					/* and drop thru to handle MOVE */
	case P_MOVE:
	    if (changereg(r, s, prev))
		flsprev();		/* Won, can flush instr we added */
	    else codrrx(prev, p);	/* Nope, just apply other opts. */
	    break;

	case P_DMOVE:
	    if (r == s)			/* Changereg doesn't like doubles, */
		flsprev();		/* so this is the best we can do. */
	    else codrrx(prev, p);	/* Nope, try other optimizations. */
	    break;

	default:			/* None of above, just try */
	    codrrx(prev, p);		/* normal post-optimizations */
	    break;
    }

    /* Done, show updated buffer on debugging output if required */
    if (debpho) shocum();
}

/* CODE1 - Generates instruction with an immediate integer constant operand
**	OP+I r,val
** This becomes type PTA_RCONST+PTF_IMM. 
*/

void
code1(op, vr, s)
VREG *vr;
{
    codr1(op, vrtoreal(vr), s);
}

void
codr1(op, r, s)
{
    PCODE *p;

    if (debpho) {
	shohdr("CODE1", op, r);
	fprintf(fpho,"<imm> %o\n", s);
    }
    p = newcode(PTA_RCONST+PTF_IMM, op, r);
    p->Poffset = s;

    if (optobj) {
	foldplus(p);		/* now do post-optimizations */
	foldmove(previous);	/* "previous" instead of "p", maybe changed */
    }
    if (debpho) shocum();
}

/* CODEBP - Generate instr with PTA_BYTEPOINT local byte pointer operand.
**	OP r,[bbbbii,,sym+o]
**
** Used in optimization of string ops, and in generating struct bit fields.
** NOTE!!! The reg and index arguments are REAL register #s, not pointers
** to virtual regs.
*/

void
codebp(op, r, b, i, sym, o)
int r, i;		/* Note real, not vreg */
SYMBOL *sym;
{
    PCODE *p;

    if (debpho) {
	shohdr("CODEBP", op, r);
	fprintf(fpho,"[%o,,%s+%o(%o)]\n",
			b, (sym ? sym->Sname : ""), o, i);
    }
    p = newcode(PTA_BYTEPOINT, op, r);		/* Add the instruction */
    p->Pindex = i;
    p->Pptr = sym;
    p->Poffset = o;
    p->Pbsize = b;		/* Store P+S field here */

    /* Apply local-format byte-pointer optimizations */
    if (optobj) {
	foldbp(p);	/* Try to optimize operand (doesn't change opcode) */
	foldbyte(p);	/* Attempt byte op optimizations */
    }
    if (debpho) shocum();
}

/* CODE3 - Generates address for symbol.
**	OPI R,sym
**
** Only used with P_MOVE, so this becomes XMOVEI R,SYM.
*/

void
code3(op, vr, s)
SYMBOL *s;
VREG *vr;
{
    codrmdx(PTA_MINDEXED+PTF_IMM, op, vrtoreal(vr), s, 0, 0);
}

/* CODE4 - Generates instruction using indexed register operand.
**	OP r,(idx)
**
** This is used after a gaddress() to get the contents of a variable,
** and also for assignment ops (like Q_ASGN = P_MOVEM).  The index is released.
**
** CODEK4 is the same but doesn't release the index register.
**
** CODE4S takes an extra argument which it stuffs into the Pbsize field
** of the stored op.  This is used as a special hack for P_SMOVE only,
** and the size is associated with the op rather than the operand.
*/

static void code40(), foldxref();

void
code4(op, reg, idx)
VREG *reg, *idx;
{
    int r, s;
    
    r = reg ? vrstoreal(reg, idx) : 0;	/* Allow IBP/JRST 0, */
    s = ufcreg(vrtoreal(idx));
    if (reg != idx) vrfree(idx);	/* will no longer need register */
    code40(op, r, s, 0);
}
void
codek4(op, reg, idx)
VREG *reg, *idx;
{
    VREG *r3;
    int r, s;
    r = ufcreg(vrtoreal(idx));
    s = vrstoreal(r3 = vrget(), idx);
    code00(P_SETM, s, r);	/* Use this to avoid losing r2 */
    r = vrstoreal(reg, r3);
    s = vrreal(r3);
    vrfree(r3);
    code40(op, r, s, 0);
}

void
code4s(op, reg, idx, keep, bsiz)
VREG *reg, *idx;
{
    VREG *r3;
    int r, s;
    if (keep) {
	r = ufcreg(vrtoreal(idx));
	s = vrstoreal(r3 = vrget(), idx);
	code00(P_SETM, s, r);	/* Use this to avoid losing r2 */
	r = vrstoreal(reg, r3);
	vrfree(r3);
    } else {
	r = vrstoreal(reg, idx);
	s = ufcreg(vrreal(idx));
	if (reg != idx) vrfree(idx);	/* will no longer need register */
    }
    code40(op, r, s, bsiz);
}

static void
code40(op, r, s, bsiz)
int r, s;
{
    PCODE *p;

    if (debpho) {
	shohdr("CODE4", op, r);
	fprintf(fpho,"(%o) siz %o\n", s, bsiz);
    }

    /* First just add the instruction */
    p = newcode(PTA_MINDEXED, op, r);
    p->Pptr = NULL;
    p->Poffset = 0;
    p->Pindex = s;
    p->Pbsize = bsiz;

    if (optobj)			/* Apply post-optimization */
	foldxref(p);

    if (debpho) shocum();
}

/* CODE5 - Generate op using only a single register operand.
**	OP reg,
**
** Currently only used for SETZ, POPJ, TRNA.
*/

void
code5(op, reg)
VREG *reg;
{
    PCODE *p, *q;
    int r;
    r = reg ? vrtoreal(reg) : 0;	/* Allow for TRNA 0, in gboolop() */

    if (debpho) {
	shohdr("CODE5", op, r);
	fputc('\n', fpho);
    }

    p = newcode(PTA_ONEREG, op, r);		/* Add the instruction */

    if (optobj)
	switch (op) {
	    case P_SETZ:
	    case P_SETO:
		if ((q = before(p))		/* Check previous instr */
		  && q->Pop == op
		  && q->Ptype == PTA_ONEREG /* && !prevskips */) {
		    /*
		    ** fold:  SETZ  S, / SETZ R,	(or SETO)
		    ** into:  SETZB S,R			(or SETOB)
		    */
		    p->Ptype = PTA_REGIS;
		    p->Pop |= POF_BOTH;
		    p->Pr2 = r;
		    dropinstr(p);		/* Flush instr we just added */
		    break;
		}
		if (op == P_SETZ) foldmove(p);
	}

    if (debpho) shocum();
}

/* CODE6 - Generate op with a symbolic address operand.
**	OP reg,sym
** This is mostly used for jumps and switch jump tables.
*/

static void optjrst();
void
code6(op, reg, s)
SYMBOL *s;
VREG *reg;
{
    PCODE *p;
    int r = reg ? vrtoreal(reg) : 0;	/* Handle JRST 0,lab */

    if (debpho) {
	shohdr("CODE6", op, r);
	if (s) fputs(s->Sname, fpho);
	fputc('\n', fpho);
    }

    /* Pre-optimization, sigh */
    if (optobj
      && (op & POF_OPCODE) == P_JUMP
      && previous && !isskip(previous->Pop)) {

	/* Emit: JUMPx R,lab	as:	CAIx  R,0
	**				 JRST  lab
	**
	** So skip optimization can work best.  If it doesn't get folded,
	** then optjrst() will turn it back into JUMPx.
	*/
	r = ufcreg(r);		/* optimization loses w/o this? */
	p = newcode(PTA_RCONST,
		op ^ (P_CAI ^ P_JUMP ^ POF_ISSKIP ^ POSF_INVSKIP),
		r);
	p->Pvalue = 0;
	foldskip(p, 1);
	op = P_JRST;		/* make it a jump */
	r = 0;			/* JRST doesn't take a register */
    }

    /* All set up, drop values into the node */
    p = newcode(PTA_MINDEXED, op, r);
    p->Pptr = s;
    p->Pindex = 0;
    p->Poffset = 0;
    reflabel(s, 1);		/* Increment label reference count */

    /* Now do post-optimization */
    if (op == P_JRST && optobj) {
	foldjump(before(p), s);
	optjrst(previous);		/* p may have become nop */
    }

    if (debpho) shocum();
}

/* CODEMDX - Generates general-purpose PTA_MINDEXED op.
**	OP rreg,pptr+poffset(rindex)
**
** NOTE!!! Because this is only used to duplicate addressing of an
** already-generated op, the register args are REAL register numbers,
** not virtual reg pointers!
*/

void
codemdx(op, rreg, pptr, poffset, rindex)
int rreg, rindex;		/* Not vregs! */
SYMBOL *pptr;
{
    PCODE *p;
    int nreg;

    if (debpho) {
	shohdr("CODEMDX", op, rreg);
	fprintf(fpho,"%s+%o(%o)\n", (pptr ? pptr->Sname : ""), poffset, rindex);
    }

    /* Maybe can do more complicated optimizing code generation */
    if (pptr == NULL && poffset == 0) {
	code40(op, rreg, ufcreg(rindex), 0);
	if (debpho) shocum();
	return;
    }
    nreg = ufcreg(rreg);		/* undo failed changereg */

    /* too general for optimization, just add the code */
    p = newcode(PTA_MINDEXED, op, nreg);
    p->Pptr = pptr;
    p->Poffset = poffset;
    p->Pindex = rindex;

    if (nreg != rreg)		/* Put result back in right register */
	code00(P_MOVE, rreg, nreg);
    if (debpho) shocum();
}

/* CODE8 - Generates instruction with integer constant operand
**	OP r,const
**
** Like code1(), but op doesn't become immediate, making type PTA_RCONST.
** E.g. code8(P_ADJSP, VR_SP, n) where n is some stack offset.
**
** KLH: Note slipshod assumption that because CCGSWI calls code8 heavily
** for P_CAIx, foldskip() shouldn't try to change value of R, in case
** it is needed by later switch tests.
*/

void
code8(op, reg, val)
VREG *reg;
{
     codr8(op, vrtoreal(reg), val);
}

static void
codr8(op, r, val)
{
    PCODE *p;

    if (debpho) {
	shohdr("CODE8", op, r);
	fprintf(fpho,"%o\n", val);
    }

    /* Pre-optimization when about to add ADJSP */
    if (optobj && op == P_ADJSP) {
	val = foldstack(val);
	if (val == 0) {			/* If completely folded, can return */
	    if (debpho) shocum();
	    return;
	}
    }

    p = newcode(PTA_RCONST, op, r);
    p->Pvalue = val;

    /* Post-optimization for ADJSP, CAIx, CAMx */
    if (optobj) {
	if (op == P_ADJSP) {
	    if ((p = before(p))
	       && p->Ptype == PTV_IINDEXED) {	/* && !prevskips */
		if (p->Pindex == R_SP)
		    p->Poffset -= val;		/* Adjust stk addr for swap */
		swappseudo(p, previous);	/* Encourage tail recursion */
	    }
	} else				/* See if can fold CAM or CAI */
	    foldskip(p, 0);		/* Could be from switch, be careful */
    }
    if (debpho) shocum();
}

/* CODE9 - Generates instruction with floating-point constant operand
**	OP r,[float]
**
** Grave misunderstandings will result if the "twowds" flag
** does not match the op specified!
**	Either that flag or the opcode are valid ways of determining 
** whether we are dealing with a 1 or 2 word constant.
*/

void
code9(op, vr, value, twowds)
double value;
int twowds;		/* TRUE if 2 wds (double), else 1-wd float */
VREG *vr;
{
    PCODE *p;
    int r = vrtoreal(vr);

    if (debpho) {
	shohdr("CODE9", op, r);
	fprintf(fpho,"[%.20g]\n", value);
    }

    /* Optimize a P_MOVE or P_DMOVE of 0.0 since floating point zero is
     * same as integer zero.
     */
    if (value == 0.0 && optobj)
	switch (op) {
	    case P_DMOVE:	/* Make DMOVE R,[0 ? 0] be SETZB R,R+1 */
		/* Can't use code0 as that would release r+1 */
		p = newcode(PTA_REGIS, P_SETZ+POF_BOTH, r);
		p->Pr2 = r+1;
		if (debpho) shocum();
		return;
	    case P_MOVE:
		code5(P_SETZ, vr);
		if (debpho) shocum();
		return;
	}

    p = newcode((twowds ? PTA_DCONST : PTA_FCONST), op, r);
    if (twowds) p->Pdouble = value;
    else p->Pfloat = (float) value;

    if (optobj) foldmove(p);	/* see if already have this one */
    if (debpho) shocum();
}

/* CODE10 - Generate op with pointer constant operand (ie a pointer literal)
**	OP r,[pointer]
**
** The pointer is made from an:
**		address (pointer to a symbol)
**		offset (in bytes from address)
**		bytesize (0,6,7,8,9,18)
** Using this information, CCOUT constructs a byte or word pointer using
** symbolic references which are resolved at load time into whatever
** the proper values are, whether local or OWGBP format (non-extended or
** extended).
**	A bytesize of -1 is special and indicates that a MASK is desired
** for the P+S field of a byte-pointer.  This should never be used with
** an address or offset.
**	When used with the P_PTRCNV op (which converts a pointer in
** the register), the offset indicates the byte size of the current pointer,
** and the bsize indicates the desired byte size to convert it to.
** The address must be NULL.
*/

void
code10(op, vr, addr, bsize, offset)
SYMBOL *addr;
VREG *vr;
{
    codr10(op, vrtoreal(vr), addr, bsize, offset);
}

void
codr10(op, r, addr, bsize, offset)
SYMBOL *addr;
{
    PCODE *p;
    int nreg;

    if (debpho) {
	shohdr("CODE10", op, r);
	fprintf(fpho,"[%s+%o (size %d)]\n",
		(addr ? addr->Sname : ""), offset, bsize);
    }
    nreg = ufcreg(r);	/* undo failed changereg */
			/* this goes with the code0 call below */

    p = newcode(PTA_PCONST, op, nreg);
    p->Pptr = addr;
    p->Poffset = offset;
    p->Pbsize = bsize;

    if (nreg != r) code00(P_MOVE, r, nreg);

    if (optobj && op == P_MOVE)
	foldmove(previous);	/* see if already have this one */
    if (debpho) shocum();
}

/* CODRMDX - Auxiliary for following routines, just to share
**	common code that creates a PTA_MINDEXED op and returns without
**	doing any optimization.
**	Note that the registers "reg" and "index" are real regs, not virtual.
*/
static void
codrmdx(type, op, reg, ptr, offset, index)
SYMBOL *ptr;
{
    PCODE *p;

    if (debpho) {
	shohdr("CODRMDX", op, reg);
	if (type&PTF_IMM) fputs("+I ", fpho);
	if (type&PTF_IND) fputc('@', fpho);
	if (ptr) fputs(ptr->Sname, fpho);
	if (ptr && offset) fputc('+', fpho);
	if (offset) fprintf(fpho, "%o", offset);
	if (index) fprintf(fpho, "(%o)", index);
	fputc('\n', fpho);
    }
    p = newcode(type, op, reg);
    p->Pptr = ptr;
    p->Poffset = offset;
    p->Pindex = index;
    if (debpho) shocum();
}

/* CODE12 - Generates register despill instruction.
**	OP reg,offset(17)
**
** This is used only by CCREG to despill registers with MOVE or DMOVE.
*/
void
code12(op, vr, offset)
VREG *vr;
{
    codrmdx(PTA_MINDEXED, op, vrtoreal(vr), (SYMBOL *)NULL, offset, R_SP);
}

/* CODE13 - Generates XMOVEI of stack location.
**	opI reg,offset(17)
**
** Used by several things, but op is always MOVE, so this always
** becomes an XMOVEI of a stack location.
*/
void
code13(op, vr, offset)
VREG *vr;
{
    codrmdx(PTA_MINDEXED+PTF_IMM, op, vrtoreal(vr),
					(SYMBOL *)NULL, offset, R_SP);
}

/* CODE15 - Generates op with indirect indexed local label
**	OP @lab+offset(idx)
**
** Only used by CCGSWI with op JRST for switch jump tables.
*/
void
code15(op, lab, off, idx)
SYMBOL *lab;
VREG *idx;
{
    codrmdx(PTA_MINDEXED+PTF_IND, op, 0, lab, off, vrtoreal(idx));
}

/* CODE16 - Generates op with indexed local label.
**	OP reg,$lab(idx)
**
** Only used by CCGSWI with op CAM for checking switch hash tables.
*/
void
code16(op, vr, lab, vs)
SYMBOL *lab;
VREG *vr, *vs;
{
    int r = vrstoreal(vr, vs);		/* Ensure both R and S in real regs */
    codrmdx(PTA_MINDEXED, op, r, lab, 0, vrreal(vs));
}

/* CODE17 - Generates a literal value.
**
** Only used by CCGSWI for generating switch hash tables.
*/

void
code17(value)
{
    PCODE *p;
    if (debpho) {
	fprintf(fpho,"CODE17: literal %o\n", value);
    }
    p = newcode(PTA_RCONST, P_CVALUE, 0);
    p->Pvalue = value;
    if (debpho) shocum();
}

/* CODESTR - Generate "code" consisting of a direct user-specified
**	assembly language string.  This implements the asm() construction.
*/
void
codestr(s, len)
char *s;
int len;
{
    flushcode();		/* Ensure pcode buffer flushed */
    while (--len >= 0) outc(*s++);
}

/* CODLABEL, CODGOLAB - Generate "code" consisting of the given label symbol.
**	codlab does more optimization and may not actually emit the label.
**	codgolab always emits its label; it is used for goto labels.
*/
/* CODLABEL - Emit a (forward) label.
**
** Optimizations are performed and if the label still has references
** to it, it is emitted.  Then realfreelabel() is called on it, and
** if we emitted it and thus cleared the peephole buffer we also free
** the list of labels queued by freelabel().
*/
void
codlabel(lab)
SYMBOL *lab;
{
    int after = 0;

    if (debpho) {
	fprintf(fpho, "CODLAB: %s\n", lab->Sname);
    }

    if (optobj) {
	after = hackstack(lab);		/* pull ADJSP across POPJ */
	optlab(lab);			/* call peephole optimizer */
    }
    if (lab->Svalue > 0) {		/* See if still must emit */
	if (debpho) shocum();		/* Yes, report changes prior to */
	flushcode();			/* clearing out previous code. */
	outlab(lab);			/* Now emit label. */
	cleanlabs();			/* Now OK to clean up queued labels */
    }
    if (after)
	code8(P_ADJSP, VR_SP, after);	/* fix up stack */
    freelabel(lab);
    if (debpho) shocum();
}

/* CODGOLAB - Emit a GOTO type label.
** These are not as well behaved as loop and if labels so we can't do as much.
*/
void
codgolab(lab)
SYMBOL *lab;
{
    if (debpho) {
	fprintf(fpho, "CODGOLAB: %s\n", lab->Sname);
    }
    if (optobj) optlab(lab);	/* Optimize */
    flushcode();		/* Clear out previous code */
    outlab(lab);		/* and unconditionally emit label */
    if (debpho) shocum();
}

/* This code should be flushed eventually,
** and TXO, TXZ, TXC forms substituted for this silly nonsense.
*/

/* ------------------------------------------------------ */
/*	return immediate version of boolean operator      */
/* ------------------------------------------------------ */

immedop(op)
{
    switch (op & POF_OPCODE) {
    case P_CAM: return op ^ (P_CAM ^ P_CAI);
    case P_TDN: return op ^ (P_TDN ^ P_TRN);
    case P_TDO: return op ^ (P_TDO ^ P_TRO);
    case P_TDC: return op ^ (P_TDC ^ P_TRC);
    case P_TDZ: return op ^ (P_TDZ ^ P_TRZ);
    default: return 0;
    }
}

/* PEEPHOLER PSEUDO-OP OPTIMIZATION ROUTINES */

/* CODRRX - Optimization auxiliary for CODE0.
**	Basically intended to help make sense of the gigantic switch
**	statement that previously existed.
**
**	prev - instruction farther back in peephole buffer, which we are
**		looking at.
**	np - instruction we are trying to optimize (normally what was
**		just added; an OP R,S instr).
*/
static void
codrrx(prev, np)
PCODE *prev, *np;
{
    PCODE *q;

    /* If have an unskipped previous instruction to look at,
    ** try to fold our newly added instr into it.
    */
    if (prev && !prevskips(prev)) {
	if (prev->Preg != np->Pr2
	  && rrpre1(np))		/* Prev instr R != new S */
	    return;			/* If won, just return. */

	if ((q = findrset(prev, np->Pr2))
	  && rrpre2(q, np))		/* Prev instr R == new S */
	    return;			/* If won, just return */
    }
    rrpop2(np);				/* Try standard optimizations */
}

/* RRPRE1 - Auxiliary for CODE0.
**	Does some commutative register-register optimization.
** The constraints for coming here are that:
**	A previous instr exists, which is not skipped,
**		such that its R (register field) is NOT the same as the S
**		of the new instruction we are adding.
**	P points to the newly added instruction, which is always a
** 		register-register op.
**
** Returns TRUE if an optimization change was made.
*/
static int
rrpre1(p)
PCODE *p;
{
    PCODE *q;
    int r, s;

    /* See if opcode of new instruction is one we can do something with.
    ** If the operation is commutative or can otherwise have the
    ** ordering of its operands reversed, then see if this can result
    ** in an improvement.
    */
    switch (p->Pop & POF_OPCODE) {
	case P_ADD:  case P_IMUL:		/* Commutative integer ops */
	case P_FADR: case P_FMPR:		/* Commutative floating ops */
	case P_IOR:  case P_AND:  case P_XOR:	/* Bitwise ops */
	case P_CAM:				/* Invertible test */
	    break;			/* Win, can check further! */
	default:
	    return 0;			/* Something else, so fail */
    }

    /* A recognized op, check further. */
    if (p->Pr2 == R_SP	 		/* Never mess with stack reg! */
      || !(q = findrset(before(p), p->Preg)))	/* Find instr setting R */
	return 0;

    switch (q->Pop) {			/* Does that instr */
	case P_SETZ:  case P_SETO:	/* set R in a simple way? */
	case P_MOVE:  case P_MOVN:
	    break;
	default:			/* No, just give up. */
	    return 0;
    }
    if (q->Ptype == PTV_IINDEXED)	/* Also ignore if imm addr op */
	return 0;

    /* OK, try swapping the operands and see if that helps. */
    r = p->Preg;
    s = p->Pr2;
    p->Preg = s;			/* Reverse order of AC,E in op */
    p->Pr2 = r;
    if ((p->Pop&POF_OPCODE) == P_CAM) {
	p->Pop = swapop(p->Pop);	/* Invert the skip test */
	if (rrpre2(q, p))		/* See if this helped optimize */
	    return 1;
	p->Pop = swapop(p->Pop);	/* Nope, restore original test */
    } else if (rrpre2(q, p)) {		/* Re-check optimization now */
	code00(P_MOVE, r, s);		/* Won! Put back in right reg */
	return 1;
    }
    p->Preg = r;	/* Failed, restore original ordering. */
    p->Pr2 = s;
    return 0;		/* Return failure so rrpre2 called */
}

/* RRPRE2 - (another) Auxiliary for CODE0.
**	Checks previous instruction for optimization with the one we're
** currently adding.  The constraints for coming here are that:
**	P points to a previous instr, which is not skipped,
**		such that its R (register field) is the SAME as the S
**		of the new instruction we are adding.
**	NP points to the newly added instruction, which is an OP R,S.
**		(register-register op)
**		Note that S is NOT referenced by anything between P and NP,
**		which makes various things safe.
*/
static int
rrpre2(p, np)
PCODE *p, *np;		/* An existing instruction being examined */
{
    int op = np->Pop;	/* OP R,S of new instruction we just added */
    int r = np->Preg;
    int s = np->Pr2;
    PCODE *q;

    /* Check opcode of PREVIOUS instr.
    ** Breaking out of the switch statement simply leaves new instr alone
    ** and returns failure.
    */
    switch (p->Pop & (POF_OPCODE | POF_BOTH)) {
    case P_IMUL:
    {   PCODE *b, *bb;

	if (p != before(np)) break;	/* For now */

	if (op != P_SUB || (q = before (p)) == NULL || q->Pop != P_IDIV ||
	    q->Preg != p->Preg || !sameaddr (p, q, 0) ||
	    (b = before (q)) == NULL || b->Pop != P_MOVE ||
	    b->Preg != p->Preg) break;
	if (b->Ptype == PTA_REGIS && b->Pr2 == r) bb = NULL;
	else if ((bb = before (b)) == NULL || bb->Preg != r ||
		 bb->Pop != P_MOVE || prevskips (bb) ||
		 !sameaddr (b, bb, 0)) break;

	/*
	** fold:  MOVE R,x
	**  	  MOVE S,x
	**  	  IDIV S,y
	**  	  IMUL S,y
	**  	  SUB R,S
	**
	** into:  MOVE S,x
	**  	  IDIV S,y
	**  	  MOVE R,S+1
	**
	** for ignorant Pascal programmers.
	*/

	if (bb != NULL) bb->Pop = P_NOP; /* drop first move */
	p->Pop = P_NOP;			/* drop P_IMUL */
	dropinstr(np);			/* Drop new instr, fix up previous */
	code00(P_MOVE, r, s+1);		/* put result in right reg */
	return 1;
    }

    case P_DMOVN:			/* similar to P_MOVN below */
	switch (op) {
	case P_DMOVE:			/* move over for optimization */
	    p->Pop = P_DMOVE;    op = P_DMOVN;	break;
	case P_DMOVN:			/* cancel double DMOVN */
	    p->Pop = P_DMOVE;    op = P_DMOVE;	break;
	case P_DFAD:			/* R + -X is same as R - X */
	    p->Pop = P_DMOVE;    op = P_DFSB;	break;
	case P_DFSB:			/* R - -X is same as R + X */
	    p->Pop = P_DMOVE;    op = P_DFAD;	break;
	default:
	    return 0;		/* Give up, failed to add instr */
	}
	np->Pop = op;
	/* Then drop through to following case */

    case P_DMOVE:
	switch (op) {
	case P_DFAD:	case P_DFSB:	case P_DFDV:	case P_DFMP:
	case P_DMOVE:	case P_DMOVN:
		/* Optimize	DMOVE S,x /.../ Dop R,S
		** into		Dop R,x
		*/
	    rrpre3(p, np, op);
	    return 1;

	/* Try to fold DMOVE R,M / PUSH x,R / PUSH x,R+1
	** into PUSH x,M / PUSH x,M+1
	** We come here when the current instr is DMOVE and we are adding
	** a PUSH.
	*/
	case P_PUSH:
	    if (p != before(np)) break;	/* For now */

	    /* Check out addressing mode, and forget it unless
	    ** it's a plain vanilla REGIS, MINDEXED, or DCONST.
	    ** Indirection, immediateness, or skippedness all cause failure.
	    */
	    switch (p->Ptype) {
	    case PTA_REGIS:
	    case PTA_MINDEXED:
	    case PTA_DCONST:
		break;
	    default:
		return 0;		/* Give up, no optimization done */
	    }

	    /* First turn DMOVE R,M / PUSH P,R
	    ** into MOVE R+1,M+1 / PUSH P,M
	    */
	    p->Pop = P_MOVE;		/* Change the DMOVE R,M */
	    p->Preg++;			/* into MOVE R+1,M */
	    switch (p->Ptype) {		/* Now fix up memory operand */
	    case PTA_REGIS:
		p->Pr2++;			/* MOVE R+1,R2+1 */
						/* PUSH P,R2 */
		break;
	    case PTA_MINDEXED:
		dropinstr(np);			/* Flush new instr */
		codemdx(P_PUSH, r, p->Pptr,		/* MOVE R+1,M+1 */
			p->Poffset++, p->Pindex);	/* PUSH P,M */
		np = previous;
		break;
	    case PTA_DCONST:
		p->Ptype = PTA_DCONST2;		/* MOVE R+1,1+[const] */
		np->Ptype = PTA_DCONST1;	/* PUSH R,[const] */
		np->Pdouble = p->Pdouble;
		break;
	    }

	    /* Now try to rearrange the MOVE / PUSH into PUSH / MOVE
	    ** if we still know where things are (not always true).
	    ** np should point to the PUSH.
	    */
	    if (np->Pop != P_PUSH) return 1;	/* If not, forget it */
	    if ((p = before(np))		/* See if prev instr is */
	      && (p->Pop == P_MOVE)) {		/* still MOVE */
		/* Yep, swap 'em */
		if ((p->Ptype&PTF_ADRMODE)==PTA_MINDEXED
		  && p->Pindex == R_SP)
			p->Poffset--;
		swappseudo(p, np);		/* into PUSH / MOVE */
	    }
	    return 1;
	}
	break;

    case P_IOR:				/* Prev instr was IOR of possible BP */
    case P_ADJBP:			/* or ADJBP of known BP */
	if (op == P_LDB || op == P_DPB) {	/* If one-time use of BP, */
	    if (localbyte(p, np))	/* try to make it local-fmt */
		return 1;		/* Won, folded. */
	}
	break;

    case P_SETZ:
	switch (op) {
	case P_MOVE:		/* fold:  SETZ S,	*/
	case P_FMPR:		/*	    ...		*/
	case P_IMUL:		/*        MOVE/etc R,S  */
	case P_MOVN:		/* into:  SETZ R,   */
	case P_FLTR:
	    np->Pop = P_SETZ;	/* Replace this op with a SETZ R, */
	    np->Ptype = PTA_ONEREG;
	    dropinstr(p);		/* Flush the old SETZ */
	    return 1;

	case P_ADD:		/* fold:  SETZ S,	*/
	case P_FADR:		/*	   ...		*/
	case P_SUB:		/*        ADD  R,S	*/
	case P_FSBR:		/* into:  null		*/
	    dropinstr(np);		/* Flush the new op */
	    dropinstr(p);		/* and flush the SETZ */
	    return 1;
	}

    case P_SETO:			/* fall in from P_SETZ above */
	/* Change SETZ/SETO S, to MOVNI S,0/1 */
	p->Pvalue = (p->Pop == P_SETO ? 1 : 0);
	p->Pop = P_MOVN;
	p->Ptype = PTV_IMMED;		/* then drop through */

    case P_MOVN:
	/* invert MOVN(*) to MOVE(*) for following optimization */

	switch(op & POF_OPCODE) {
	case P_MOVE:
	    p->Pop = P_MOVE;	/* move P_MOVN over for optimization */
	    np->Pop = P_MOVN;
	    break;
	case P_MOVN:
	    p->Pop = P_MOVE;	/* cancel double P_MOVN */
	    np->Pop = P_MOVE;
	    if (changereg (r, s, p)) {
		dropinstr(np);	/* Flush pointless MOVE */
		return 1;
	    }
	    break;
	case P_ADD:		/* R + -X is same as R - X */
	    p->Pop = P_MOVE;
	    np->Pop = P_SUB;
	    break;
	case P_SUB:		/* R - -X is same as R + X */
	    p->Pop = P_MOVE;
	    np->Pop = P_ADD;
	    break;
	case P_FADR:		/* R + -X is same as R - X */
	    p->Pop = P_MOVE;
	    np->Pop = P_FSBR;
	    break;
	case P_FSBR:		/* R - -X is same as R + X */
	    p->Pop = P_MOVE;
	    np->Pop = P_FADR;
	    break;

	case P_CAM:  case P_IMUL:  case P_FMPR:  case P_FDVR:
	    if (p->Ptype != PTV_IMMED
	      && (q = before(p)) != NULL
	      && q->Preg == r
	      && !prevskips (q))
		switch (q->Pop) {
		    case P_MOVE:	/* a <= -b is same as -a >= b */
			q->Pop = P_MOVN;
			p->Pop = P_MOVE;
			np->Pop = swapop(np->Pop);
			codrrx(p, np);		/* Continue looking back */
			return 1;

		    case P_MOVN:	/* -a <= -b is same as a >= b */
			q->Pop = P_MOVE;
			p->Pop = P_MOVE;
			np->Pop = swapop(np->Pop);
			codrrx(p, np);		/* Continue looking back */
			return 1;
	    }
	default:
	    if (p->Ptype == PTV_IMMED) {
		p->Pop = P_MOVE;	/* unknown const case, make P_MOVE */
		p->Pvalue = - p->Pvalue; /* with negated value */
	    } else {
		return 0;		/* Give up, no optimization done */
	    }
	}	/* Drop through to following case */

    case P_MOVE:
	rrpre3(p, np, np->Pop);		/* Always takes care of everything */
	return 1;

    case P_HRRZ:
    case P_HLRZ:
	/* Turn HLRZ/HRRZ S,X
	**	...
	**	HRRE R,S
	** into:
	**	HLRE/HRRE R,X
	*/
	if (op == P_HRRE) {
	    rrpre3(p, np, (p->Pop == P_HRRZ ? P_HRRE : P_HLRE));
	    return 1;
	}
	break;

    case P_ADD:
    case P_SUB:
	/*
	** fold:  ADD/SUB S,x
	**		...
	**        ADD/SUB R,S
	**
	** into:  ADD/SUB R,x
	**		...
	**        ADD/SUB R,S
	**
	** and keep looking back for further optimization.
	*/

	/* Ensure that new instr is ADD or SUB before wasting more time */
	if (op != P_ADD && op != P_SUB)
	    break;

	/* Make sure the old ADD/SUB doesn't use its own reg as index */
	if (rinaddr(p, p->Preg))
	    break;

	/* See whether new instr's reg is otherwise referenced.
	** It is OK to skip over references of the form ADD/SUB R,M as
	** the result doesn't depend on the order of the instrs, and this
	** allows us to convert things like (a - (b+c+d)) into (a-b-c-d).
	*/
	for (q = before(np); q = chkref(p, q, r); q = before(q)) {
	    /* Found a reference, see if it's OK to pass by. */
	    if ((q->Pop == P_ADD || q->Pop == P_SUB)	/* ADD or SUB? */
	      && r == q->Preg && !rinaddr(q, r))	/* R ref reg-only? */
		continue;				/* Win, skip over */
	    return 0;			/* Failed, no optimization. */
	}

	if (op == P_SUB)		/* If new instr is SUB, */
	    p->Pop ^= (P_ADD ^ P_SUB);	/* invert sense of old instr */

	p->Preg = r;		/* Make ADD/SUB S,x be ADD/SUB R,x */
	codrrx(before(p), np);	/* Continue optimization if can */
	return 1;


    case P_SETZ+POF_BOTH:
    case P_SETO+POF_BOTH:
	if (p->Ptype == PTA_REGIS
	  && (op == P_DMOVE || op == P_DMOVN)
	  && p->Preg == s && p->Pr2 == s + 1) {

	    /*
	    ** fold:  SETZB/SETOB S,S+1
	    **		...
	    **        DMOVE R,S
	    **
	    ** into:  SETZB R,R+1
	    */
	    np->Pop = p->Pop;		/* Copy the SETZB/SETOB */
	    np->Pr2 = np->Preg + 1;
	    dropinstr(p);			/* Flush the SETZB/SETOB */
	    return 1;
	}
	break;

    }		/* end switch (p->Pop&(POF_OPCODE|POF_BOTH)) */

    return 0;		/* No optimization done, let caller handle it. */
}

/* RRPRE3 - (yet another) Auxiliary for RRPRE2 (auxiliary for CODE00).
**	Handles case where previous instruction was a "data fetch"
** into register and new instruction operates on that register.
**	 Turn:	p->   MOVE/MOVEI/DMOVE/HRRZ/HLRZ S,x
**		      ...
**		np->  OPN R,S
**	 into:
**		      OP    R,x
**
** If there are instructions in between (i.e. "..." contains something) then
** we need to be careful that:
**	(1) S is NOT otherwise referenced between the MOVE and the OP.
**		This rule has already been satisfied by findrset().
**	(2) OP is not a skip, and R is NOT referenced in "..."
**		If so, then OK to change the MOVE to OP R,X.
**	Otherwise, (3) X doesn't use anything that "..." changes.
**		If so, we can flush the MOVE and add the OP R,X.
**	Otherwise give up.
**
** Note that the OP of a munged instruction may differ from the OPN
** originally pointed to by "np".  This is so the halfword code can
** provide the correct op.  For most calls, the "op" arg will just be
** "np->Pop".
*/
static void
rrpre3(p, np, op)
PCODE *p, *np;
int op;			/* Actual OP to use if a change is made */
{
    PCODE *q;
    int stkoff;

    /* don't make an XPUSHI - foldstack works better without it */
    if (p->Ptype == PTV_IINDEXED && op == P_PUSH) {
	rrpop2(np);		/* Just do simple post-ops */
	return;
    }

    /* Ensure the two instructions are handling the same registers.
    ** If one is a doubleword op and the other isn't then they might not.
    ** e.g. the sequence MOVE S,x / SETZ S+1, / DFAD R,S
    */
    if (rbinreg(p) != rbinaddr(np)) {	/* Verify p's S == np's S */
	rrpop2(np);			/* Oops, just do simple post-ops */
	return;
    }

    /* If there's nothing in between, then no need to worry about rules.
    ** Otherwise, check for rule (2).
    */
    q = before(np);
    if ( p == q			/* Always OK if no "..." in between */
      || (!isskip(np->Pop)		/* Otherwise must not be skip */
	 && !chkref(p, q, np->Preg))) {	/* and "..." must not reference R. */
	p->Pop = op;			/* Win!!  Change MOVE S,X */
	p->Preg = np->Preg;		/* to OP R,X */
	dropinstr(np);			/* Flush new instr */
	rrpopt(p);			/* Do more checks on result! */
	return;
    }

    /* Checking for R usage didn't work out.
    ** Now apply painful check of X by going forwards from
    ** the MOVE, checking each instr to make sure it cannot reference
    ** X or use a register that X does.
    */
    if (chkmref(p, np, &stkoff) == NULL) {
	/* WON!  Zap the MOVE and turn new op into OP R,X */
	int r = np->Preg;	/* Save R */
	*np = *p;		/* Copy MOVE into added instr */
	p->Pop = P_NOP;		/* Then zap the MOVE */
	np->Pop = op;		/* Change MOVE S,X */
	np->Preg = r;		/* to OP R,X */
	if (stkoff)		/* If stack indexed through and it changed, */
	    np->Poffset -= stkoff;	/* adjust offset of instruction. */
	rrpopt(np);		/* Do post-optimization checks now! */
	return;
    }
    rrpop2(np);			/* Failed, apply standard post-opts. */
}

/* CHKREF(p, q, reg) - Checks series of instrs to see if any reference
**	the specified register.
**	Searches backwards from q (INCLUSIVE) to p (EXCLUSIVE).
**	Returns non-NULL pointer to most recent reference found.
**	Returns NULL if no reference seen.
*/
static PCODE *
chkref(begp, q, r)
PCODE *begp, *q;
int r;
{
    for (; q && begp != q; q = before(q)) {
	if (rincode(q, r))
	    return q;		/* Quit loop if find a reference */
    }
    return NULL;
}

/* CHKMREF - Check an instr sequence for anything affecting a mem ref.
**	BEGP points to start (INCLUSIVE), the instr here defines X.
**	ENDP points to end (EXCLUSIVE)
** Returns pointer to offending instr if any ref found.
**
**	Applies painful check of X (for OP R,X) by going forwards from
** the begp (inclusive), checking each instr to make sure it cannot reference
** X or use a register that X does, since we want to move the X reference
** from the instr at begp to the instr at endp.
**	This involves three distinct checks:
**	(1) If the original instr at begp modifies memory, then this
**		is considered a conflicting reference and we fail, since
**		the instr at endp probably depends on the new value.
**	(2) If X uses a register, that register must not be changed
**		by an intervening instruction!
**	(3) If an intervening instruction references the same place
**		as X (or even threatens to do so), then it must not change
**		memory.
** Must track stack offset both in order to properly check for sameaddr(),
** and to correct the X if it uses the stack (and something in "..."
** changed stack ptr).
**
** 	If X depends on stack pointer value, the returned
** offset will be nonzero and X needs it added to its Poffset if it is
** to be used in the instruction at ENDP.
**	If at any point the stack offset changes in a way that means X
** would become non-existent (not on the stack, i.e. a positive stack
** offset) then the routine fails immediately.
*/
PCODE *
chkmref(begp, endp, aoff)
PCODE *begp, *endp;
int *aoff;
{
    PCODE *q;
    int ioff;
    int stkoff = 0;
    int xreg = -1;		/* Default assumes X uses no reg */

    *aoff = 0;
    if ((begp->Pop&POF_BOTH) || (popflg[begp->Pop&POF_OPCODE]&PF_MEMCHG))
	return begp;		/* Start instr changes mem! Fail. */

    switch (begp->Ptype&PTF_ADRMODE) {
	case PTA_BYTEPOINT:
	case PTA_MINDEXED:
	    if (begp->Pindex)		/* If nonzero index reg, remember it */
		xreg = begp->Pindex;
	    if (xreg != R_SP)		/* Unless stack ptr, forget offset */
		aoff = NULL;
	    break;
	case PTA_REGIS:
	    xreg = begp->Pr2;		/* Then drop thru to ignore offset */
	default:
	    aoff = NULL;
	    break;
    }

    for (q = after(begp); q; q = after(q)) {
	if (q == endp) {
	    if (aoff) *aoff = stkoff;
	    return NULL;		/* Won, return 0 (no reference) */
	}
	/* Not yet done with loop, check out this instr */
	if (sameaddr(begp, q, stkoff) || alias(begp, q, stkoff)) {
	    if ((q->Pop&POF_BOTH) || (popflg[q->Pop&POF_OPCODE]&PF_MEMCHG))
		break;	/* P and Q may refer to same place, and the instr */
	}		/* changes memory, so must fail. */

	/* Account for stack changes.
	**  A PUSH, POP, or ADJSP of the stack can be understood and the
	** rrchg test skipped if we are using the stack ptr as index reg
	** (otherwise rrchg would flunk the instr).
	*/
	ioff = 0;
	switch(q->Pop&POF_OPCODE) {
	    case P_PUSH:
		if (q->Preg == R_SP) ioff = 1;
		break;
	    case P_POP:
		if (q->Preg == R_SP) ioff = -1;
		break;
	    case P_ADJSP:
		if (q->Preg == R_SP) ioff = q->Pvalue;
		break;
	}
	stkoff += ioff;
	if (ioff && aoff) {	/* Stack change, and using ptr as index reg */
	    if ((begp->Poffset - stkoff) > 0)
		break;		/* Cell no longer protected by stack ptr */
	    continue;		/* OK, can skip rrchg test */
	} else if (xreg >= 0 && rrchg(q, xreg))
	    break;		/* Modifies register that X needs */
    }
    if (aoff) *aoff = stkoff;
    return q;
}

/* RRPOPT - Post-optimization after adding reg-reg instruction.
**	We've just turned the sequence
**		MOVE S,x   into:  OP R,x
**		OP R,S
** and want to do further optimization on the new op/address combination
** resulting from that fold.
**	P points to the OP R,x instruction.
*/
static void
rrpopt(p)
PCODE *p;
{
    PCODE *q;
    int op;

    /* P_CAML for an immediate type needs to become P_CAIL... */
    if ((op = immedop(p->Pop)) && (p->Ptype & PTF_IMM)) {
	p->Pop = op;		/* Change op to immediate type, and make */
	p->Ptype &= ~ PTF_IMM;	/* operand PTA_RCONST instead of PTV_IMMED */
	foldskip(p, 1);		/* Fix up P_CAI */
	return;
    }

    q = before(p);	/* look back before munged move.  May be NULL! */

    /* Big post-optimization switch: see what the added op was.
    ** Breaking out just returns, since instr has already been added.
    */
    switch (p->Pop & POF_OPCODE) {
	case P_PUSH:
	    code8(P_ADJSP, VR_SP, 0);	/* try adjustment */
	    break;			/* return */

	case P_SKIP:
	    if (p->Pop == P_SKIP+POF_ISSKIP+POS_SKPE
	      && p->Ptype == PTV_IINDEXED)
		/* Fold:	P_SKIPEI R,addr
		** Into:	XMOVEI R,addr
		**	assuming that the SKIP is part of a (char *) cast
		** conversion of an immediate address value.
		*/
		p->Pop = P_MOVE;
	    break;			/* return */

	case P_FLTR:
	    if (p->Ptype != PTV_IMMED)
		break;			/* Return, not immediate operand */
	    p->Pop = P_MOVE;		/* fold: FLTRI R,x */
	    p->Ptype = PTA_FCONST;	/* into: MOVSI R,(xE0) */
	    /* This only works if target machine is same as source machine! */
	    p->Pfloat = (float) p->Pvalue;
	    break;			/* return */

	case P_IMUL:
	    if (p->Ptype != PTV_IMMED) return;
	    if (p->Pvalue == 1) {
		dropinstr(p);	/* drop IMULI R,1 */
		break;		/* then return */
	    }

	    if (q && q->Ptype == PTV_IMMED /* !prevskips */
	      && q->Preg == p->Preg) switch(q->Pop) {
		    case P_SUB: case P_ADD:
			/*
			** fold:  ADDI/SUBI   R,n
			**        IMULI  R,m
			**
			** into:  IMULI  R,m
			**        ADDI/SUBI   R,m*n
			*/
			q->Pvalue *= p->Pvalue;	/* premultiply constant */
			swappseudo (p, q);	/* put add after multiply */
			p = q;		/* look at multiply for below */
			q = before(p);	/* and before in case another mult */
			if (q == NULL	 /* Check whether safe to drop in */
			  || q->Pop != P_IMUL
			  || q->Ptype != PTV_IMMED
			  || q->Preg != p->Preg)
				break;		/* No, return now. */
			/* Drop through to next case */

		    case P_IMUL:
			/*
			** fold:  IMULI  R,n
			**        IMULI  R,m
			**
			** into:  IMULI  R,n*m
			*/
			q->Pvalue *= p->Pvalue;	/* multiply both together */
			dropinstr(p);		/* Flush later one */
			break;			/* Then return */

		    case P_MOVN: case P_MOVE:
			/*
			** fold:  MOVEI/MOVNI  R,n
			**        IMULI  R,m
			**
			** into:  MOVEI/MOVNI  R,m*n
			*/
			q->Pvalue *= p->Pvalue;	/* mult const by factor */
			dropinstr(p);		/* flush folded multiply */
			break;			/* then return */
	    }
	    break;

	case P_LDB:
	case P_DPB:
	    foldbyte(p);	/* Attempt some simple opts */
	    break;		/* Done, return */

	case P_ADJBP:
	    foldadjbp(p);	/* fix up ADJBP instruction */
	    break;		/* return */

	case P_SUB:
	    if (p->Ptype == PTV_IMMED
	      && q != NULL
	      && q->Preg == p->Preg
	      && (q->Ptype == PTV_IMMED || q->Ptype == PTV_IINDEXED))
		switch (q->Pop) {	/* check safe then switch */
		case P_MOVE:
		case P_ADD:
		    q->Poffset -= p->Poffset;
		    dropinstr(p);		/* fold:  ADDI/MOVEI R,n */
		    foldplus(q);	/*  	  SUBI R,m */
		    return;		/* into:  ADDI R,n-m */

		case P_SUB:
		    q->Poffset += p->Poffset;
		    dropinstr(p);		/* fold:  SUBI R,n */
		    			/*  	  SUBI R,m */
		    return;		/* into:  SUBI R,n+m */
	    }
	    /* fall through to foldplus() */

	case P_ADD:
	    foldplus(p);		/* do general optimization on add */
	    if (p != previous)		/* Take care of possible ADDI+ADDI */
		foldplus(previous);	/* that sometimes results */
	    break;			/* return */

	case P_CAM:
	    if (q != NULL
	      && q->Ptype == PTA_REGIS /* !prevskips */
	      && q->Pop == P_MOVE
	      && q->Preg == p->Preg) {

		/*
		** fold:  P_MOVE  R,S
		**        P_CAMx  R,x
		**
		** into:  P_CAMx  S,x
		*/
		p->Preg = q->Pr2;	/* flatten tested register */
		q->Pop = P_NOP;		/* flush useless move */
	    }
	    break;			/* Return */

    default:
	rrpop2(p);		/* Apply usual opts */
	return;
    }	/* End of huge switch on newly-added op code */
}

/* RRPOP2 - Auxiliary for CODE0, does some optimizations on OP R,S.
*/
static void
rrpop2(p)
PCODE *p;
{
    switch (p->Pop & POF_OPCODE) {
    case P_PUSH:
	code8(P_ADJSP, VR_SP, 0);	/* Hack stack */
	break;

    case P_AND:
    case P_IOR:
    case P_XOR:
	if (!findconst(p))
	    inskip(p);		/* turn SKIPA/MOVE/IOR into TLOA/IOR */
	break;

    case P_CAM:
	findconst(p);		/* See if can turn CAM into CAI */
	foldskip(p, 1);
	break;

    case P_ADJBP:
	foldadjbp(p);		/* fix up ADJBP instruction */
	break;

    case P_ADD:
	findconst(p);		/* See if can make operand immediate */
	foldplus(p);		/* maybe addition can be fixed now */
	break;

    case P_MOVE:	case P_LDB:
    case P_MOVN:	case P_SETCM:	case P_SETO:	case P_SETZ:
    case P_HRRZ:	case P_HLRZ:	case P_HRRE:	case P_HLRE:
    case P_FIX:		case P_FLTR:
	/* If op is one that CCCSE recognizes as simply setting register, */
	foldmove(p);		/* try to find common sub-expression! */
	break;
    }
}

/* FOLDXREF(p) - Attempt to optimize newly-added instr of form OP R,(S).
**	p points to just-added instruction.
*/
static void
foldxref(p)
PCODE *p;
{
    PCODE *q, *b, *oldprev;

    /* First attempt optimizations by looking for an instruction that sets
    ** the index register S.  If found, this will be a single-word op
    ** that is not skipped over and thus is safe to NOP out.
    */
    oldprev = before(p);	/* Find old previous */

    /* If have a single-word op setting S, check simple cases. */
    if (q = findrset(oldprev, p->Pindex)) switch (q->Ptype) {

	case PTV_IMMED:			/* Immediate RCONST */
	    switch (q->Pop) {

		/* fold:  MOVEI/MOVNI  S,const
		**		...
		**        OP     R,(S)
		** into:
		**	  OP     R,const (or -const)
		*/
	    case P_MOVN:
		q->Pvalue = - q->Pvalue;
	    case P_MOVE:
		if (q == oldprev) {	/* Can we re-use last instr? */
		    q->Pop = p->Pop;	/* Yes!  Change its op and r */
		    q->Ptype = PTA_RCONST;	/* Take immediateness out */
		    q->Preg = p->Preg;
		    q->Pbsize = p->Pbsize;
		    p = q;		/* Say this is now current instr */
		    flsprev();		/* Then flush instr that was added */
		} else {		/* No, zap MOVEI */
		    p->Ptype = PTA_RCONST;	/* Change our addr mode */
		    p->Pvalue = q->Pvalue;	/* to imm constant */
		    q->Pop = P_NOP;		/* Now can flush the MOVEI */
		}
		/* Special check here for LSH (possible bitfield hacking) */
		if (p->Pop == P_LSH)
		    optlsh(p);		/* Attempt to optimize LSH */
		return;

		/* fold:  ADDI/SUBI   S,offset
		**		...
		**        OP     R,(S)
		** into:
		**	  OP     R,offset(S)
		*/
	    case P_SUB:
		q->Pvalue = - q->Pvalue;
	    case P_ADD:
		p->Poffset = q->Pvalue;		/* Set offset to added val */
		q->Pop = P_NOP;			/* Then drop the ADDI/SUBI */
		q = before(q);		/* Back up to previous good instr */
					/* for the foldidx coming up. */

		/* If instruction setting the S reg was a MOVE S,I
		** then flush it, as we can use I directly.
		*/
		if ((b = findrset(q, p->Pindex))
		  && b->Ptype == PTA_REGIS
		  && b->Pop == P_MOVE
		  && b->Preg == p->Pindex) {
		    p->Pindex = b->Pr2;	/* Change our index reg to I */
		    b->Pop = P_NOP;	/* and drop needless move */
		    q = NULL;		/* Start foldidx from oldprev */
		}
		break;	/* Now break out to do foldidx and foldboth */
	    }
	    break;
	
	case PTV_IINDEXED:		/* If op S,<Immediate MINDEXED> */
	    switch (q->Pop) {

	    case P_MOVE:
		/*
		** fold:  P_XMOVEI S,addr	(Immediate MINDEXED)
		**		...
		**        OP     R,(S)
		**
		** into:  OP     R,addr
		**
		** Note the code here is somewhat akin to that in rrpre3().
		** Perhaps someday it can be merged.
		*/
		if (q == oldprev) {	/* Anything between XMOVEI and op? */
		    /* Nope, safe to just re-use the XMOVEI instr by
		    ** clobbering it with the op just added.
		    */
		    q->Pop = p->Pop;	/* Fix it up */
		    q->Ptype = PTA_MINDEXED;
		    q->Preg = p->Preg;
		    q->Pbsize = p->Pbsize;
		    dropinstr(p);	/* And flush original instr */
		} else {
		    /* Hmm, there are instrs between XMOVEI and op, need
		    ** to check them out carefully.  See comments in chkmref().
		    ** If we win, zap XMOVEI and modify current new instr.
		    */
		    int stkoff;
		    if (chkmref(q, p, &stkoff) == NULL) {
			p->Pptr = q->Pptr;	/* Update our new address */
			p->Pindex = q->Pindex;
			p->Poffset = q->Poffset - stkoff;
			q->Pop = P_NOP;		/* Zap the XMOVEI */
		    }
		}
		foldboth();		/* Further check last instr */
		return;

	    case P_ADD:			/* ADDI S,addr */
		/*
		** fold:  ADDI   S,addr(I)
		**        OP     R,(S)
		**
		** into:  MOVEI  S,addr(S)
		**  	  ADD    S,I
		**        OP     R,(S)
		**
		** and optimize further...
		**
		** NOTE: only do this if ADDI is the first preceding instr
		** (oldprev), because otherwise register I also needs to
		** be checked for intermediate usage, and the "optimize
		** further" routines aren't smart enough yet to go back
		** far enough.
		*/
		if (q == oldprev	/* Ignore if ADD not last thing. */
		  && (!q->Pindex || q->Pindex != p->Preg)) {
		    int op = p->Pop;	/* Remember values of orig instr */
		    int r = p->Preg;
		    int s = p->Pindex;
		    int bsiz = p->Pbsize;
		    int o = q->Pindex;

		    q->Pop = P_MOVE;		/* Change Q to XMOVEI */
		    q->Pindex = s;		/* of (S) */
		    foldidx(q);			/* Try to optimize index reg */
		    s = q->Pindex;		/* Remember it */
		    dropinstr(p);		/* Flush the OP we added */
		    if (o)
			code00(P_ADD, q->Preg, o);	/* followed by P_ADD */
		    code40(op, r, s, bsiz);	/* then try code4 again */
		    return;
		}
		break;
	    }
	    break;

    } /* End of q->Ptype switch */

    /* No simple optimizations found... */

    foldidx(p);		/* Try folding index reg calculation. */
    foldboth();		/* Check remaining optimizations */
}

/* OPTJRST - Specialized optimization for JRST 0,sym
**	This is only used by code6 at moment.
*/
static void
optjrst(p)
PCODE *p;
{
    PCODE *prev, *b, *q;

    if (!p || p->Pop != P_JRST || p->Pindex || p->Poffset
      || !(prev = before(p))
      || prevskips(prev))
	return;

    switch (prev->Pop & POF_OPCODE) {
    case P_JRST:	/* See if possibly dead code precedes the JRST */
    case P_POPJ:
    case P_IFIW:
	if ((prev->Pop & ~POF_OPCODE)==0) {	/* Verify just a simple op */
	    reflabel(p->Pptr, -1);		/* Same as dropjump() */
	    dropinstr(p);			/* Dead code, drop the JRST! */
	}
	break;

    case P_CAI:
        if (prev->Ptype != PTA_RCONST || prev->Pvalue != 0) break;

	/* fold:  CAIx  R,0	into:	--
	**	   JRST  addr		JUMPx R,addr
	*/

	/* Change JRST to JUMP, turn off isskip flag, and invert test */
	p->Pop = (prev->Pop ^ (P_CAI ^ P_JUMP ^ POF_ISSKIP ^ POSF_INVSKIP));
	p->Preg = prev->Preg;
	clrskip(p);
	dropinstr(prev);		/* Flush the CAI */
	break;

    case P_AOS:
    case P_SOS:
	if (prev->Ptype != PTA_REGIS		/* Ensure operand is reg */
	  || (prev->Preg			/* Must be either AOS R */
	    && prev->Preg != prev->Pr2))	/* or AOS R,R */
	    break;

	/* fold:  AOSx  R,R	into:	--
	**	   JRST  addr		AOJx R,addr
	*/
	if (((p->Pop = prev->Pop)&POF_OPCODE) == P_AOS)
	    p->Pop ^= (P_AOS ^ P_AOJ ^ POF_ISSKIP ^ POSF_INVSKIP);
	else p->Pop ^= (P_SOS ^ P_SOJ ^ POF_ISSKIP ^ POSF_INVSKIP);
	p->Preg = prev->Pr2;
	clrskip(p);
	dropinstr(prev);
	break;

    case P_CAM:

	/*
	** fold:  ADDI R,1
	**  	  CAMN R,x
	**  	   JRST $y
	**
	** into:  SUB R,x
	**  	  AOJE R,$y
	*/

	if (prev->Pop & POSF_CMPSKIP) break;	/* only CAMN and CAME */
	for (b = before(prev);
	     b && b->Pop == P_MOVE && b->Preg != prev->Preg;
	     b = before(b)) ;			/* skip over struct finding */

	if (b == NULL || b->Preg != prev->Preg	/* look for OPI R,1 */
	  || b->Ptype != PTV_IMMED
	  || b->Pvalue != 1 || prevskips(b))
	    break;
	if (b->Pop == P_ADD)
	    p->Pop = prev->Pop ^ (P_CAM ^ P_AOJ ^ POF_ISSKIP ^ POSF_INVSKIP);
	else if (b->Pop != P_SUB)
	    break;			/* must be ADDI or SUBI */
	else				/* now SOJ */
	    p->Pop = prev->Pop ^ (P_CAM ^ P_SOJ ^ POF_ISSKIP ^ POSF_INVSKIP);
	p->Preg = b->Preg;		/* use this register */
	b->Pop = P_NOP;			/* drop ADDI or SUBI */
	prev->Pop = P_SUB;		/* make SUB */
	clrskip(p);			/* following instr no longer skipped */

	if ((b = before(b)) == NULL || b->Pop != P_JRST
	  || (q = before(b)) == NULL
	  || (q->Pop & (POF_OPCODE + POSF_CMPSKIP)) != P_CAM
	  || q->Preg != p->Preg
	  || !sameaddr(q, prev, 0) || prevskips(q))
	    break;

	/*
	** fold:  CAMN R,x
	**  	   JRST $y
	**  	  SUB R,x
	**  	  AOJE R,$z
	**
	** into:  SUB R,x
	**  	  JUMPE R,$y
	**  	  AOJE R,$z
	*/

	b->Preg = p->Preg;		/* make JUMPE */
	b->Pop = q->Pop ^ (P_CAM ^ P_JUMP ^ POF_ISSKIP ^ POSF_INVSKIP);
	clrskip(b);			/* not skipped */
	q->Pop = P_SUB;			/* make sub */
	dropinstr(prev);		/* drop duplicated SUB, fix up */
    }
}
