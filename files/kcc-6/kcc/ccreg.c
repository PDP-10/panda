/*	CCREG.C - Register management
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.45, 6-Apr-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.26, 8-Aug-1985
**
** Original version by David Eppstein / Stanford University / 8 Mar 1985
*/

#include "cc.h"
#include "ccgen.h"

/* Local prototypes */
#ifdef __STDC__
#define P_(a) a
#else
#define P_(a) ()
#endif

static void vr1free P_((VREG *vr));
static void vrspill P_((VREG *vr));
static void vr1spill P_((VREG *vr));
static int rrfind P_((void));
static void updrfree P_((void));
static int rrdfind P_((void));
static VREG *vrsetrr P_((VREG *vr,int rr));
static VREG *vr1setrr P_((VREG *vr,int rr));
static void vrunlink P_((VREG *vr));
static void vr1unlink P_((VREG *reg));
static VREG *vrlink P_((VREG *reg,VREG *list));
static VREG *vr1link P_((VREG *reg,VREG *list));
static VREG *vralloc P_((void));
static VREG *vrdalloc P_((void));

#undef P_

#define empty(vr) ((vr)->Vrnext == (vr))	/* TRUE if list is empty */

#define REGLIST(x) static VREG x = {0, 0, (TYPE *)NULL, 0, &x, &x}
REGLIST(freelist);			/* virtual regs not now in use */
REGLIST(reglist);			/* regs associated with real regs */
REGLIST(spillist);			/* regs spilled onto the stack */

static VREG *regis[NREGS];		/* who is using which registers */
static int regfree[NREGS];		/* what regs are used in code */

/* Special vregs which the macros VR_RETVAL and VR_SP point to.  These
** exist only so routines can force the use of certain physical regs in
** special places, by providing the appropriate phys reg value.  These
** vregs are never strung on a list or used in any other way.
*/
VREG vr_retval	= { VRF_SPECIAL|VRF_LOCK, R_RETVAL };
VREG vr_sp	= { VRF_SPECIAL|VRF_LOCK, R_SP };

#if SYS_CSI	/* For FORTRAN linkage */
VREG vr_fap	= { VRF_SPECIAL|VRF_LOCK, R_FAP  };
VREG vr_zero	= { VRF_SPECIAL|VRF_LOCK, R_ZERO };
#endif

/*
** VRINIT - Initialize for start of new code
**	Called at the start of each function or code initializer by inicode()
** VRENDCHK - Perform wrap-up checks at end of code.
**	Called at end of each function or initializer by gend().
*/

void
vrinit()
{
    int i;

    vrendchk();
    for (i = 0; i < NREGS; i++) regis[i] = NULL;
}

void
vrendchk()
{
    if (!empty(&reglist) || !empty(&spillist)) {
	int_warn("vrendchk: leftover regs");
	/* Try to release all regs */
	while (!empty(&reglist)) {
	    if ((int) reglist.Vrnext < NREGS) {
		int_error("vrendchk: bad reglist");
		break;
	    }
	    vrfree(reglist.Vrnext);
	}
	while (!empty(&spillist)) {
	    if ((int) spillist.Vrnext < NREGS) {
		int_error("vrendchk: bad spillist");
		break;
	    }
	    vrfree(spillist.Vrnext);
	}
    }
}

/* VRGET -  Assign a new virtual register with corresponding real register.
*/
VREG *
vrget()
{
    return vr1link(vr1setrr(vralloc(), rrfind()), &reglist);
}

/* VRDGET - Same as VRGET but assigns a double-word register.
*/
VREG *
vrdget()
{
    return vrlink(vrsetrr(vrdalloc(), rrdfind()), &reglist);
}

/* VRRETGET - Get a register for holding a return value
*/
VREG *
vrretget()
{
    if (regis[R_RETVAL] != NULL)	/* Ensure return reg is free */
	vrspill(regis[R_RETVAL]);
    return vr1link(vr1setrr(vralloc(), R_RETVAL), &reglist);
}

/* VRRETDGET - Get a double register for holding return value
*/
VREG *
vrretdget()
{
    if (regis[R_RETVAL] != NULL) vrspill(regis[R_RETVAL]);
    if (regis[R_RETDBL] != NULL) vrspill(regis[R_RETDBL]);
    return vrlink(vrsetrr(vrdalloc(), R_RETVAL), &reglist);
}

/* VRFREE - Forget about a no-longer-in-use register
**
*/
void
vrfree(vr)
VREG *vr;
{
    if ((int)vr < NREGS) {		/* Catch obsolete usage */
	int_error("vrfree: bad vr %o", vr);
	return;
    }	

    if (vr->Vrflags & VRF_REGPAIR)	/* If 1st of a pair, */
	vr1free(vr->Vrmate);		/* free 2nd first */
    vr1free(vr);
}

static void
vr1free(vr)
VREG *vr;
{
    if (vr->Vrflags & VRF_SPECIAL) return;
    if (vr->Vrflags & VRF_SPILLED)
	int_warn("vr1free: spilled reg");
    else regis[vr->Vrloc] = NULL;	/* Say real reg now free */
    vr1unlink(vr);			/* Unlink reg(s), move to freelist */
    vr1link(vr, &freelist);
    /* No need to clear flags as vralloc() will do this. */
}

/* VRALLSPILL - Spill all registers
**	This is needed to save values over subr calls and conditional exprs.
*/
void
vrallspill()
{
    while (!empty(&reglist))
	vrspill(reglist.Vrnext);
}

/* VRSPILL - Spill a virtual register.
**	Either we needed to reallocate it or we are calling a function.
**	In either case the register moves onto the stack.
*/
static void
vrspill(vr)
VREG *vr;
{
    vr1spill(vr);		/* Must ALWAYS push 1st reg first!!!! */
    if (vr->Vrflags & VRF_REGPAIR)
	vr1spill(vr->Vrmate);	/* then 2nd if a pair */
}

static void
vr1spill(vr)
VREG *vr;
{
    if (vr->Vrflags & VRF_SPILLED)
	int_warn("vr1spill: reg already spilled");
    vr1unlink(vr);			/* remove from assigned list */
    spillist.Vrnext->Vroldstk = stackoffset;	/* remember where we are */
    code00(P_PUSH, R_SP, vr->Vrloc);	/* push on stack, don't release */
    regis[vr->Vrloc] = NULL;		/* no longer here */
    vr->Vrloc = ++stackoffset;		/* Stack bigger now, note new loc */
    vr->Vrflags |= VRF_SPILLED;
    vr1link(vr, &spillist);		/* it's now spilled */
}

/* VRWIDEN - Make single register into a register pair and returns that.
**	If "low" argument non-zero, register becomes the low word.
**	Contents of additional word are indeterminate.
*/
VREG *
vrwiden(reg, low)
VREG *reg;			/* Old existing register */
{
    VREG *nreg;			/* New added register */
    VREG *vr1, *vr2;		/* 1st and 2nd regs of pair */
    int rr;

    if (reg->Vrflags & (VRF_REGPAIR|VRF_REG2ND)) {
	int_warn("vrwiden: reg already wide");
	return reg;
    }

    /* Turn a single vreg into a vreg pair */
    reg->Vrmate = nreg = vralloc();	/* Get another vreg to make a pair */
    nreg->Vrmate = reg;			/* Link them together */
    vr1link(nreg, reg);			/* Add new to same list after old */
    if (low) {
	vr1 = nreg, vr2 = reg;
	vr1->Vrloc = reg->Vrloc-1;
    } else {
	vr1 = reg, vr2 = nreg;
	vr2->Vrloc = reg->Vrloc+1;
    }
    vr1->Vrflags |= VRF_REGPAIR;
    vr2->Vrflags |= VRF_REG2ND;

    if (reg->Vrflags & VRF_SPILLED) {
	/* On stack, don't need to find reg */
	nreg->Vrflags |= VRF_SPILLED;	/* Pretend new reg also spilled */
	nreg->Vroldstk = reg->Vroldstk;	/* Preserve this just in case */
	return vr1;			/* (note reg not really on stk!) */
    }

    /* Existing reg is in a real reg, see if neighbor is free */
    if (regis[nreg->Vrloc] == NULL	/* New reg available? */
      && vr1->Vrloc >= R_RETVAL		/* And pair is within range of */
      && vr2->Vrloc <= R_MAXREG) {	/* useable registers? */
	    regis[nreg->Vrloc] = nreg;	/* Win!  Take the new reg */
	    return vr1;			/* and return */
    }

    /* Can't use neighboring real reg, find another pair of real regs.
    ** We lock old reg while hunting to avoid unpleasant surprises.
    */
    if (reg->Vrflags & VRF_LOCK)
	rr = rrdfind();
    else {
	reg->Vrflags |= VRF_LOCK;
	rr = rrdfind();
	reg->Vrflags &= ~VRF_LOCK;
    }
    code00(P_MOVE, (low ? rr+1 : rr), reg->Vrloc);	/* Copy old reg */
    regis[reg->Vrloc] = NULL;		/* Free old real reg, and */
    return vrsetrr(vr1, rr);		/* set up new ones instead */
}


/* VRLOWIDEN - Widen a single virtual reg in low direction.
**	No return value is needed since the vreg pointer doesn't change.
*/
void
vrlowiden(vr)
VREG *vr;
{
    (void) vrwiden(vr, 0);	/* Widen, existing word becomes 1st */
}

/* VRNARROW - Extract one word of a doubleword register
**	The pointer furnished as arg must point to the 1st or 2nd reg of
**	the pair, and that one is retained while the other is flushed.
*/
void
vrnarrow(vr)
VREG *vr;
{
    if (vr->Vrflags & (VRF_REGPAIR|VRF_REG2ND)) {
	/* Flush flags and ensure that vr1free doesn't complain if
	** the vreg happens to be spilled at moment.
	*/
	vr->Vrflags &= ~(VRF_REGPAIR|VRF_REG2ND|VRF_SPILLED);
	vr1free(vr->Vrmate);		/* Flush other reg */
    } else
	int_warn("vrnarrow: already narrow");
}

/* VRREAL - return real (physical) register # for an active virtual reg.
**	If reg is not active (is on stack) then generates internal error,
**	but tries to recover by getting it anyway.
*/
int
vrreal(vr)
VREG *vr;
{
    if (!(vr->Vrflags & VRF_SPILLED))
	return vr->Vrloc;
    int_error("vrreal: using spilled reg");
    return vrtoreal(vr);
}

/* VRTOREAL - Return a physical register number for some virtual register
** Pulls it back off the stack if necessary
*/
int
vrtoreal(reg)
VREG *reg;
{
    if ((int)reg < NREGS) {	/* Catch any obsolete uses */
	int_error("vrtoreal: bad vr %o", reg);
	return (int)reg;
    }	

    /* Check for spilled register now somewhere on stack */
    if (reg->Vrflags & VRF_SPILLED) {
	int stkloc;

	/* Put it back into a register */
	reg->Vrflags &= ~ VRF_SPILLED;
	vrunlink(reg);			/* Unlink from spill list */
	stkloc = reg->Vrloc;		/* Note location on stack */
	if (reg->Vrflags & VRF_REGPAIR) {
	    reg->Vrmate->Vrflags &= ~VRF_SPILLED;
	    vrsetrr(reg, rrdfind());
	    code12(P_DMOVE, reg, stkloc - stackoffset);
	} else {
	    vr1setrr(reg, rrfind());
	    code12(P_MOVE, reg, stkloc - stackoffset);
	}

	/* drop stack to top remaining spilled reg */
	if (reg->Vrnext == spillist.Vrnext) {
	    code8(P_ADJSP, VR_SP, spillist.Vrnext->Vroldstk - stackoffset);
	    stackoffset = spillist.Vrnext->Vroldstk;
	}
	vrlink(reg, &reglist);
    }

    /* In a reg now no matter what, so just return it */
    return reg->Vrloc;
}

/* VRSTOREAL - Same as vrtoreal but for two registers at once.
**	This ensures that we don't mistakenly spill one of the regs that
**	a two-reg instruction needs.
*/
int
vrstoreal(vr, vr2)
VREG *vr, *vr2;
{
    if ((int)vr < NREGS) {	/* Catch any obsolete uses */
	int_warn("vrstoreal: bad vr %o", vr);
	return (int)vr;
    }	

    if (vr->Vrflags & VRF_LOCK) {	/* If 1st reg already locked, */
	(void) vrtoreal(vr2);		/* use fast method that avoids */
	return vr->Vrloc;		/* unlocking the 1st reg when done. */
    }
    if (vr->Vrflags & VRF_SPILLED)	/* Nope, so ensure 1st reg active */
	(void) vrtoreal(vr);
    vr->Vrflags |= VRF_LOCK;		/* Lock it to that phys reg, */
    (void) vrtoreal(vr2);		/* while we ensure 2nd active too! */
    vr->Vrflags &= ~VRF_LOCK;		/* OK, can unlock 1st now */
    return vr->Vrloc;
}

/* VRISPAIR - Return true if virtual register is a doubleword pair
*/
int
vrispair(reg)
VREG *reg;
{	return (reg->Vrflags & VRF_REGPAIR) != 0;
}

/* VRUFCREG - Vreg version of ufcreg().
**	If changereg() fails to change a reg (S) to the desired # (R), it
** emits a MOVE R,S.  Often the code generator later realizes the exact
** # didn't matter and so the MOVE to R can be flushed; this routine does
** exactly that for a virtual reg by updating it to reflect the new
** real reg it's associated with (S)  once the MOVE is flushed.
**
** Currently only used by switch case jump generation to avoid
** lossage that would ensue from CCCODE's calls to ufcreg.
*/

void
vrufcreg(vr)
VREG *vr;
{
    regis[vrtoreal(vr)] = NULL;			/* Swap in, deassign it */
    regis[vr->Vrloc = ufcreg(vr->Vrloc)] = vr;	/* Maybe flush MOVE; reassign*/
}

/* RFREE - True if real register is NOT assigned to a virtual reg.
**	A function is necessary because the outside world can't see regis[]
*/
int
rfree(rr)
{
    return regis[rr] == NULL;
}

/* RHASVAL - True if real reg is still assigned and VRF_HASVAL is set
**	indicating it contains a needed value.
**
** This isn't actually used by anything yet.
*/
int
rhasval(rr)
{
    return (regis[rr] ? regis[rr]->Vrflags&VRF_HASVAL : 0);
}

/* From this point, all routines are internal auxiliaries */

/* RRFIND - Find or create an unused real register.
**	If none exist, we spill what is likely to be the
**	earliest allocated register (since our register allocation
**	will tend to act like a stack this is a win).
*/
static int
rrfind()
{
    VREG *vr;
    int r;

    updrfree();			/* update regfree[] to pbuf contents */
    for (r = R_MINREG; r <= R_MAXREG; r++)	/* try for unused free reg */
	if (regfree[r]) return r;
    for (r = R_MINREG; r <= R_MAXREG; r++)	/* none, try for a free one */
	if (regis[r] == NULL) return r;

    /* All registers in use, have to decide which one to spill to stack.
    ** The heuristic for this is to use the "oldest" thing on the register
    ** list (this is the least recently created -- not necessary the least
    ** recently used -- register)
    ** This is where VRF_LOCK has its effect of preventing regs from being
    ** spilled.
    ** Also, for time being, don't spill 2nd reg of a pair.
    */
    for (vr = reglist.Vrprev; vr != &reglist; vr = vr->Vrprev)
	if (!(vr->Vrflags & (VRF_LOCK | VRF_REG2ND))) {
	    r = vr->Vrloc;		/* Remember phys reg # */
	    vrspill(vr);		/* Spill this reg to stack! */
	    return r;
	}
    int_error("rrfind: no regs");
}

/* UPDRFIND - auxiliary for rrfind() and rrdfind().
**	Sees which registers are in use in the peephole buffer.
** We try to avoid assigning these so that common subexpression
** elimination will have the greatest opportunity to work.
**
** Since this is merely a heuristic and since it is called intensively,
** we care more about speed than accuracy.
** In particular, we don't even bother looking at the opcode or
** addressing mode of each instruction.
*/
static void
updrfree()
{
    int r;
    PCODE *p;

    for (r = R_MINREG; r <= R_MAXREG; r++)
	regfree[r] = (regis[r] == NULL);
    for (p = previous; p != NULL && p->Pop != P_PUSHJ; p = before(p))
	regfree[p->Preg] = 0;
}

/* RRDFIND - Find (or create) a real double-register pair, returning the
**	# of the first real reg of the pair.
**	We have to be careful not to return the very last register.
*/
static int
rrdfind()
{
    VREG *vr, *vrok[NREGS];
    int i, nvrs, r;

    updrfree();				/* update regfree[] to pbuf contents */
    for (r = R_MINREG; r < R_MAXREG; r++)	/* try for unused free reg */
	if (regfree[r] && regfree[r+1]) return r;
    for (r = R_MINREG; r < R_MAXREG; r++)	/* none, try for a free one */
	if (regis[r] == NULL && regis[r+1] == NULL) return r;

    /* None free, scan the reglist in the same way as for rrfind.  But
    ** since we need a pair, we must look for the first virtual reg or
    ** combination thereof that forms a pair.
    ** Note that for time being, we avoid spilling just the 2nd reg of a pair.
    */
    nvrs = 0;
    for (vr = reglist.Vrprev; vr != &reglist; vr = vr->Vrprev) {
	if (vr->Vrflags & (VRF_LOCK | VRF_REG2ND))	/* If locked, */
	    continue;				/* don't consider it */
	if (vr->Vrflags & VRF_REGPAIR) {
	    r = vr->Vrloc;		/* Remember phys reg # */
	    vrspill(vr);		/* Spill this reg to stack! */
	    return r;
	}
	/* Not a pair, see if forms pair with anything already seen. */
	for (i = 0; i < nvrs; ++i)
	    if ((r = vrok[i]->Vrloc) == vr->Vrloc+1
	      || r == vr->Vrloc-1) {	/* If combo wins, */
		if (r > vr->Vrloc)	/* get low phys reg # */
		    r = vr->Vrloc;
		vrspill(vr);		/* Spill both to stack */
		vrspill(vrok[i]);
		return r;
	    }
	/* Nope, add to array and keep looking.  Should never have more
	** than NREGS active registers, so array bounds ought to be safe.
	*/
	vrok[nvrs++] = vr;
    }
    int_error("rrdfind: no regs");
}

/* VRSETRR -  Set a virtual register's location(s) to be some real reg(s).
**	If the vreg is a pair, both are set.
*/
static VREG *
vrsetrr(vr, rr)
VREG *vr;
{
    if (vr->Vrflags & VRF_REGPAIR)
	vr1setrr(vr->Vrmate, rr+1);
    return vr1setrr(vr, rr);
}

/* VR1SETRR -  Set a virtual register's location to be some real reg
*/
static VREG *
vr1setrr(vr, rr)
VREG *vr;
{
    return regis[vr->Vrloc = rr] = vr;
}

/* VRUNLINK - Unlink a virtual reg from whatever list it's on.
**	If the vreg is a pair, both are unlinked.
*/
static void
vrunlink(vr)
VREG *vr;
{
    if (vr->Vrflags & VRF_REGPAIR)
	vr1unlink(vr->Vrmate);
    vr1unlink(vr);
}

/* VR1UNLINK - Remove a register from whatever list it's on.
**	This is the first half of changing from one list to another
*/
static void
vr1unlink(reg)
VREG *reg;
{
    if (reg->Vrnext == reg) {
	int_warn("vr1unlink: list head");
	return;
    }
    reg->Vrnext->Vrprev = reg->Vrprev;
    reg->Vrprev->Vrnext = reg->Vrnext;
}


/* VRLINK - Link a register that may be the 1st of a pair; if so, link
**	the 2nd reg as well.
*/
static VREG *
vrlink(reg, list)
VREG *reg, *list;
{
    if (reg->Vrflags & VRF_REGPAIR)
	vr1link(reg->Vrmate, list);	/* Is pair, link 2nd first */
    return vr1link(reg, list);
}

/* VR1LINK -  Add a register to a list
**	Used when a new vreg is created and when moving between lists
*/
static VREG *
vr1link(reg, list)
VREG *reg, *list;
{
    reg->Vrnext = list->Vrnext;
    list->Vrnext->Vrprev = reg;
    reg->Vrprev = list;
    return list->Vrnext = reg;
}

/* VRALLOC - Allocate a new virtual register structure
** VRDALLOC - Same, but returns 1st of a double register pair, linked together.
*/
static VREG *
vralloc()
{
    VREG *rp;

    if (empty(&freelist)) {
	rp = (VREG *)malloc(sizeof (VREG));
	if (rp == NULL) efatal("Out of memory for virtual registers");
    } else {
	rp = freelist.Vrnext;
	vr1unlink(rp);
    }
    rp->Vrflags = 0;
    return rp;
}

static VREG *
vrdalloc()
{
    VREG *vr1 = vralloc();
    VREG *vr2 = vralloc();
    vr1->Vrflags |= VRF_REGPAIR;
    vr2->Vrflags |= VRF_REG2ND;
    vr1->Vrmate = vr2;
    vr2->Vrmate = vr1;
    return vr1;
}
