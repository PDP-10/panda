/*	CCGEN.H - Declarations for code generator
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.76, 5-Apr-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.32, 8-Aug-1985
**
** Original version cleaned up from CC.G / 10 Mar 85 / David Eppstein
*/

#include "ccreg.h"

#ifndef GEXT
#define GEXT extern
#endif

#ifndef NULL
#define NULL 0
#endif

GEXT int stackoffset;		/* adjustments made to stack */

GEXT SYMBOL
    *brklabel,			/* the break label */
    *looplabel;			/* label to go to on continue */

GEXT NODE *litstrings;	/* String constant list (CCGEN, CCGEN1, CCGEN2) */
GEXT NODE *litnodes;	/* Arbitrary N_DATA literals generated within funct */

/*
** Structures for the peephole buffer
**
** Emitted code is buffered for a while so that when further code is
** emitted a peephole optimizer can be run on the mess.  This
** optimizer is responsible for many improvements normally done at a
** higher level, such as common subexpression elimination and constant
** reassociation.
**
** The code is kept in a circular buffer of instructions.
<** When the buffer fills, the bottom edge is moved along and the code
** it passes emitted.
**
** Note that all registers in the buffer are actual numbers of machine
** registers, rather than the virtual registers defined in ccreg.
*/

#define PCODE struct pcode
PCODE {			/* pseudo op in peephole buffer */
    int Ptype;			/* Addressing mode and flags */
    int Pop;			/* Opcode */
    int Preg;			/* AC field of instruction */
    SYMBOL *Pptr;		/* ident for memory address */
    int p_off;			/* Usually offset to add to ident */
    int p_reg2;			/* index register or 2nd reg */
    union {
	float p_fval;		/* single-prec f.p. value */
	double p_dval;		/* double-prec f.p. value */
	int p_di[2];		/* Access to 2 wds of double value (cheat) */
	int p_int;		/* Integer for other stuff */
    } p_u;
};

GEXT PCODE codes[MAXCODE];	/* the circular buffer of pseudo-ops */
GEXT PCODE *previous;		/* pointer to last non-null op */

GEXT int maxcode, mincode;	/* top and bottom indices into codes */

/* Fields universal for all pseudo-code instructions:
**	Pop - Opcode field of instruction
**	Preg - AC field of instruction
**	Ptype - Operand (addressing) type
**
** The following lists the various other fields and what addressing modes
** use them.  BEWARE of changes which may affect code that tends to
** copy (or make assumptions) about the structure, such as chgpush()
** in CCCSE!!
*/


/* Pr2 - register used as address.  PTA_REGIS only.
*/
#define Pr2 p_reg2		/* re-use "index" reg for PTA_REGIS */

/* Pindex - Index register.
**	Only used for PTA_MINDEXED, PTA_BYTEPOINT.
*/
#define Pindex p_reg2

/* Poffset - Address offset to add to symbol.
**	Used by PTA_MINDEXED, PTA_BYTEPOINT, and
**	PTA_PCONST (where it may be in terms of bytes).
*/
#define Poffset p_off	 	/* offset to add to ident */

/* Pvalue - full word constant value
**	Used by PTA_RCONST only.
*/
#define Pvalue p_off		/* immediate value */

/* Pbsize - Byte size (for a pointer)
**	Used mainly by PTA_PCONST where it holds the byte size in bits,
**	and by PTA_BYTEPOINT where it holds the entire LH of a byte pointer,
**	including P and S fields, with all other fields zero.
**	Also used by PTA_MINDEXED for the special case of the P_SMOVE op.
*/
#define Pbsize p_u.p_int	/* Byte-size or P+S fields */

/* Pfloat - single-precision floating-point constant
**	Used only by PTA_FCONST.
*/
#define Pfloat p_u.p_fval	/* single-prec value */

/* Pdouble - double-precision floating-point constant
** Pdouble1 - 1st wd of double constant
** Pdouble2 - 2nd wd of double constant
**	Used only by PTA_DCONST, PTA_DCONST1, and PTA_DCONST2 respectively.
**	The latter two definitions are for "cheating" - access to
**	the two integer word values making up the bit pattern of the double.
*/
#define Pdouble p_u.p_dval
#define Pdouble1 p_u.p_di[0]
#define Pdouble2 p_u.p_di[1]

/*
** Structure of Ptype (addressing mode) field in pseudo code.
**
** This field (as with the Pop opcode field) is divided
** into several components.  The main one is ADRMODE, which determines
** the meanings of most of the other fields in the instruction.
** Others modify the instruction in certain ways, or are used to
** pass information to the peephole optimizer about what is safe to do.
*/

#define	PTF_ADRMODE	017	/* Mask for p->Pop addressing mode */
#define PTF_IMM		020	/* Flag to append "I" to op name */
#define PTF_IND		040	/* Flag to use indirect addressing */
#define PTF_SKIPPED	0100	/* Set if op before this can skip */

/* Values for PTF_ADRMODE field */
#define PTA_ONEREG	01	/* no address, just register */
#define PTA_REGIS	02	/* register to register */
#define PTA_MINDEXED	03	/* addr+offset(index) */
#define PTA_BYTEPOINT	04	/* [<bsiz>,,addr+offset(index)] */
#define PTA_PCONST	05	/* [pointer of <bsiz> to <addr+offset>] */
#define PTA_RCONST	06	/* simple integer in pvalue */
#define PTA_FCONST	07	/* [<single prec f.p. value>] */
#define PTA_DCONST	010	/* [<double prec f.p. value>] (2 words) */
#define PTA_DCONST1	011	/* [<word 1 of a DCONST>] */
#define PTA_DCONST2	012	/* [<word 2 of a DCONST>] */
/* Not used yet, maybe never */
#define PTA_GCONST		/* [<G-format f.p. value>] (2 words) */
#define PTA_GCONST1		/* [<word 1 of a GCONST>] */
#define PTA_GCONST2		/* [<word 2 of a GCONST>] */

/* Composite values */
#define	PTV_IMMED    (PTA_RCONST+PTF_IMM)   /* Immediate simple integer type */
#define PTV_IINDEXED (PTA_MINDEXED+PTF_IMM) /* Immediate addressing type */

/* Macros for easy hacking of skipped flag */
#define prevskips(p) ((p)->Ptype & PTF_SKIPPED)	    /* if preceding op skips */
#define setskip(p)   (void) ((p)->Ptype |= PTF_SKIPPED) /* say it does */
#define clrskip(p)   (void) ((p)->Ptype &=~ PTF_SKIPPED) /* say it doesn't */

#if 0	/* Addressing mode documentation */

	All PDP-10 instructions consist of an opcode, an AC, and an
effective address E which is made of an indirect bit, an index register,
and an 18-bit address value:
		OP A,@Y(X)
		OP = Instruction op-code
		A  = Accumulator (operand register)
		@ (or I) = Indirect bit
		X  = Index register
		Y  = 18-bit offset

	ALL pseudo-code instructions use Pop and Ptype.  The Ptype
field specifies how the remaining members of a pseudo-code structure
are used to furnish operands to the instruction.
	The AC field of the instruction is always given by Preg.
Some instructions may not use an AC in which case the value of this
field is 0.

PTA_ONEREG	OP Preg,	"One-register"
	No address is given; only the AC field is used.

PTA_REGIS	OP Preg,Pr2	"Register to register"
	The register specified by Pr2 is used as an address.
	Pbsize may be set depending on the instruction (eg P_SMOVE).

PTA_MINDEXED	OP Preg,Pptr+Poffset(Pindex)	"Memory indexed"
	This is a fully specified instruction which uses
both an address and an index register.
	The Pptr and Poffset fields are added together to form Y.
	Pptr is a SYMBOL pointer to an identifier, and may be null.
	Poffset is an integer constant, and may be 0.
	Pindex is a register number, 0 if no indexing is to be done.
	Pbsize may be set depending on the instruction (eg P_SMOVE).

PTA_BYTEPOINT	OP Preg,[Pindex,,Pptr+Poffset]	"Byte Pointer"
	This is similar to MINDEXED except for two things.  First, the
address constructed is used for the pointer's E, not the
instruction's; second, the Pbsize field is used to hold the P and S fields
of a byte-pointer left-half (the indirect and index parts are left zero).
	The Pptr, Poffset, and Pindex fields are as for MINDEXED.

PTA_PCONST	OP Preg,[<ptr of Pbsize bits to Pptr+Poffset>]
	This is similar to PTA_BYTEPOINT, but the literal is
specified differently because the exact LH value cannot be known
until load time.  Pptr is a (possibly null) identifier as usual,
but Poffset is in terms of BYTES, not WORDS.  The byte size is
given by Pbsize; if this value is 0 then this is a word pointer
(bytesize 36) and Poffset is in terms of words after all.
	Only Pbsize values of 0, 6, 7, 8, 9, and 18 are supported.

PTA_RCONST	OP Preg,Pvalue		"Constant"
	This mode is used when the memory operand is a an
integer constant of some kind.  Note that the final instruction
may turn out to be of any of these forms:
	OP  Preg,Pvalue		Constant value for Y (e.g. LSH 1,123)
	OPI Preg,Pvalue		Immediate addressing (e.g. MOVEI 1,123)
	OP Preg,[Pvalue]	Immediate but won't fit (e.g. MOVE 1,[1,,1])

PTA_FCONST	OP Preg,[Pfloat]	"Float constant"
	The Pfloat field contains the value for a single-precision
floating-point constant.  This is normally assembled as shown but
may sometimes turn into an immediate-mode instruction if the value
has no bits set in its right half.

PTA_DCONST	OP Preg,[Pdouble]	"Double constant"
PTA_DCONST1	OP Preg,[Pdouble1]	"1st word of DCONST"
PTA_DCONST2	OP Preg,[Pdouble2]	"2nd word of DCONST"
	Pdouble is used to hold a double-precision floating-point
value; Pdouble1 and Pdouble2 are used to access the two words
(as integer bit patterns) which constitute this value.  The full
value is always available as Pdouble.

#endif

/* Structure of Pop field in a pseudo code instruction
**	The major value of interest is POF_OPCODE, which always contains
** an enumerated value defined as P_xxx where "xxx" is the name of a PDP-10
** instruction without any "I" or "B" modifier added.  A complete listing
** of the valid P_ ops is in cccode.h.
*/

#define POF_OPCODE  000377	/* P_xxx opcode */
#define POF_ISSKIP  000400	/* op is a skip (to tell from JUMP) */
#define POF_OPSKIP  007000	/* bits saying which skip */
#define POF_BOTH    010000	/* send result to mem as well as reg */

/* meanings of values of OPSKIP field */
#define POF_OPSKIP_SHF 9	/* Hack for shopcod() in CCCODE:
				** # bits to right of OPSKIP field */
#define POS_SKPA	01000		/* always skip (0 is never skip) */
#define POS_SKPE	02000		/* skip if equal (to zero) */
#define POS_SKPN	03000		/* skip if not equal */
#define POS_SKPL	04000		/* skip if less than */
#define POS_SKPGE	05000		/* skip if greater than or equal */
#define POS_SKPG	06000		/* skip if greater than */
#define POS_SKPLE	07000		/* skip if less than or equal */

/* meanings of POF_OPSKIP bits (derived from value meanings or vice versa) */
#define POSF_INVSKIP 01000		/* bit to flip to invert skip parity */
#define POSF_SWPSKIP 02000		/* flip to swap comparison arguments */
#define POSF_EQSKIP  03000		/* add E to arithmetic skips */
#define POSF_CMPSKIP 04000		/* on if skip is a comparison */

#define revop(op) ((op) ^ POSF_INVSKIP)
#define isskip(op) ((op) & POF_ISSKIP)
#define swapop(op) ((op) & POSF_CMPSKIP ? ((op) ^ POSF_SWPSKIP) : (op))

/* Now define all of the valid P_xxx opcodes */

enum {		/* Define internal names as enums */
#define opcode(iname,oname,f,a,b,c,d) iname,
#include "cccode.h"
#undef opcode
};

/* Tables indexed by P_ opcode value, kept in CCDATA */
extern char *popostr[];		/* Output string */
extern int popflg[];		/* Various flags */
extern int popprc[];		/* PRC_ value for op */


/* Flags for pseudo-code ops */
#define PF_MEMCHG	01	/* Op changes memory at or through E */
#define PF_OPI		02	/* Op has an "Immediate" variant */
#define PF_OPB		04	/* Op has a "Both" variant */
#define PF_OPS		010	/* Op has a "Self" variant */
#define PF_OPM		020	/* Op has a "Memory" variant */
#define PF_EIMM		040	/* Op takes E as immediate operand */

#define PF_OPIMB (PF_OPI|PF_OPM|PF_OPB)	/* Common combo in table */

/* This used to be:
**	cccreg.h - definitions for changereg() and friends
**	David Eppstein / Stanford University / 8-Jul-85
*/
/*
** Data type for storing effect of op on reg.
**
** This describes the return value of rchange(), and says in what manner the
** op changes the register: whether it is unaffected, set solely by the op,
** changed by both the op and its previous contents, or whether all registers
** were changed unpredictably; and, if the register was changed, whether this
** was as a single reg or a register pair.
*/
enum rmod {
    PRC_ILL,		/* Illegal value, should not be encountered */
    PRC_RSAME,		/* op affects memory or it skips but changes nothing */
    PRC_RSET,		/* op changes reg based only on the other operand */
    PRC_RSET_DSAME,	/* op changes reg based on doubleword operand */
			/*	(not used by anything - flush?) */
    PRC_RCHG,		/* op changes reg based on it and other operand */
    PRC_RCHG_DSAME,	/* op changes reg based on it and double operand */
			/*	(not used by anything - flush?) */
    PRC_DSAME,		/* op uses reg pair but doesn't change it */
			/*	(only used for DMOVEM) */
    PRC_DSET,		/* op changes reg pair based only on other operand */
			/*	(only DMOVE, DMOVN) */
    PRC_DSET_RSAME,	/* op changes reg pair based on singleword operand */
			/*	(not used by anything - flush?) */
    PRC_DCHG,		/* op changes reg pair based also on it */
    PRC_DCHG_RSAME,	/* op changes pair based on it and single operand */
			/*	(only IDIV, UIDIV, MUL, SUBBP) */
    PRC_UNKNOWN		/* all registers changed in unknown fashion */
			/*	(PUSHJ) */
};

/*
** Calculate effect of op on reg.
**
** rchange (op)
**    returns a PRC_ value (see CCCODE.H) describing the given opcode.
**    It doesn't care about the skips or other flags in the opcode word,
**    but it strips them off so the caller does not need to do so.
*/
#define rchange(op) (popprc[(op)&POF_OPCODE])	/* Get PRC_ value for op */

typedef SYMBOL *label;

/* External prototypes */

/* cccode.c */
#ifdef __STDC__
#define P_(a) a
#else
#define P_(a) ()
#endif

extern PCODE *newcode P_((int type,int op,int reg));
extern PCODE *before P_((PCODE *p));
extern PCODE *after P_((PCODE *p));
extern int swappseudo P_((PCODE *a,PCODE *b));
extern void fixprev P_((void));
extern void dropinstr P_((PCODE *p));
extern void flushcode P_((void));
extern int codcreg P_((VREG *to,VREG *from));
extern void codek0 P_((int op,VREG *r1,VREG *r2));
extern void code0 P_((int op,VREG *r1,VREG *r2));
extern void code00 P_((int op,int r,int s));
extern void code1 P_((int op,VREG *vr,int s));
extern void codr1 P_((int op,int r,int s));
extern void codebp P_((int op,int r,int b,int i,SYMBOL *sym,int o));
extern void code3 P_((int op,VREG *vr,SYMBOL *s));
extern void code4 P_((int op,VREG *reg,VREG *idx));
extern void codek4 P_((int op,VREG *reg,VREG *idx));
extern void code4s P_((int op,VREG *reg,VREG *idx,int keep,int bsiz));
extern void code5 P_((int op,VREG *reg));
extern void code6 P_((int op,VREG *reg,SYMBOL *s));
extern void codemdx P_((int op,int rreg,SYMBOL *pptr,int poffset,int rindex));
extern void code8 P_((int op,VREG *reg,int val));
extern void code9 P_((int op,VREG *vr,double value,int twowds));
extern void code10 P_((int op,VREG *vr,SYMBOL *addr,int bsize,int offset));
extern void codr10 P_((int op,int r,SYMBOL *addr,int bsize,int offset));
extern void code12 P_((int op,VREG *vr,int offset));
extern void code13 P_((int op,VREG *vr,int offset));
extern void code15 P_((int op,SYMBOL *lab,int off,VREG *idx));
extern void code16 P_((int op,VREG *vr,SYMBOL *lab,VREG *vs));
extern void code17 P_((int value));
extern void codestr P_((char *s,int len));
extern void codlabel P_((SYMBOL *lab));
extern void codgolab P_((SYMBOL *lab));
extern int immedop P_((int op));
extern PCODE *chkmref P_((PCODE *begp,PCODE *endp,int *aoff));

/* ccgen2.c */
extern VREG *genexpr P_((NODE *n));
extern void genxrelease P_((NODE *n));
extern void relflush P_((VREG *reg));
extern void gboolean P_((NODE *n,SYMBOL *false,int reverse));
extern VREG *getmem P_((VREG *reg,TYPE *t,int byte,int keep));
extern VREG *stomem P_((VREG *reg,VREG *ra,int siz,int byteptr));

/* ccreg.c */
extern void vrinit P_((void));
extern void vrendchk P_((void));
extern VREG *vrget P_((void));
extern VREG *vrdget P_((void));
extern VREG *vrretget P_((void));
extern VREG *vrretdget P_((void));
extern void vrfree P_((VREG *vr));
extern void vrallspill P_((void));
extern VREG *vrwiden P_((VREG *reg,int low));
extern void vrlowiden P_((VREG *vr));
extern void vrnarrow P_((VREG *vr));
extern int vrreal P_((VREG *vr));
extern int vrtoreal P_((VREG *reg));
extern int vrstoreal P_((VREG *vr,VREG *vr2));
extern int vrispair P_((VREG *reg));
extern void vrufcreg P_((VREG *vr));
extern int rfree P_((int rr));
extern int rhasval P_((int rr));

/* cccreg.c */
extern int changereg P_((int to,int from,PCODE *p));
extern SYMBOL *cregupto P_((SYMBOL *lab));
extern int pushneg P_((int r,PCODE *p));
extern int pnegreg P_((int r,PCODE *p));
extern int ufcreg P_((int r));
extern int rbref P_((PCODE *p));
extern int rbset P_((PCODE *p));
extern int rbmod P_((PCODE *p));
extern int rbuse P_((PCODE *p));
extern int rbchg P_((PCODE *p));
extern int rbin P_((PCODE *p));
extern int rbincode P_((PCODE *p));
extern int rbinreg P_((PCODE *p));
extern int rbinaddr P_((PCODE *p));
extern int rrref P_((PCODE *p,int r));
extern int rrset P_((PCODE *p,int r));
extern int rrmod P_((PCODE *p,int r));
extern int rruse P_((PCODE *p,int r));
extern int rrchg P_((PCODE *p,int r));
extern int rrin P_((PCODE *p,int r));
extern int rincode P_((PCODE *p,int reg));
extern int rinaddr P_((PCODE *p,int reg));
extern int rinreg P_((PCODE *p,int reg));

/* cccse.c */
extern void foldmove P_((PCODE *p));
extern int folddiv P_((VREG *vr));
extern int foldcse P_((int r,PCODE *p));
extern void foldidx P_((PCODE *p));
extern int foldrcse P_((int r,PCODE *p));
extern int sameaddr P_((PCODE *p,PCODE *q,int stkoffset));
extern int alias P_((PCODE *p,PCODE *q,int soff));

/* ccjskp.c */
extern int deadjump P_((void));
extern int dropsout P_((PCODE *p));
extern void foldskip P_((PCODE *p,int safechange));
extern void foldjump P_((PCODE *prev,label lab));
extern void unskip P_((PCODE *p));
extern void optlab P_((label lab));
extern int unjump P_((label lab));
extern int foldtrna P_((PCODE *p));
extern void inskip P_((PCODE *p));

/* ccopt.c */
extern int localbyte P_((PCODE *p,PCODE *np));
extern void foldbp P_((PCODE *p));
extern void foldbyte P_((PCODE *p));
extern void foldadjbp P_((PCODE *p));
extern void optlsh P_((PCODE *p));
extern void foldplus P_((PCODE *p));
extern PCODE *findrset P_((PCODE *p,int reg));
extern int findconst P_((PCODE *p));
extern void foldboth P_((void));
extern int foldstack P_((int n));
extern int hackstack P_((SYMBOL *lab));
extern void killstack P_((void));
extern int unsetz P_((PCODE *p));

/* ccout.c */
extern void realcode P_((PCODE *p));
extern int oneinstr P_((PCODE *p));

#undef P_
