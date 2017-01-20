/*	CCREG.H - Declarations for KCC register management
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.17, 5-Apr-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.8, 8-Aug-1985
**
** Original version by David Eppstein / Stanford University / 8 Mar 1985
*/

#define R_ZERO		000	/* AC0, never used for many reasons */
#define R_RETVAL	001	/* register for subroutine return */
#define R_RETDBL	002	/* second return for doublewords */
#define R_MINREG	003	/* lowest expr code-gen scratch register */
#define	R_MAXREG	015	/* highest expr scratch register */
#define R_SCRREG	016	/* scratch for CCOUT */
#define R_FAP		016	/* Also use as Fortran Arg Pointer reg */
#define	R_SP		017	/* push down Stack Pointer */

#define REGMASK 017		/* mask to get reg only from bp idx */
#define NREGS   020		/* number of physical registers */

#define VREG struct vreg	/* Virtual Register definition */
VREG {
    int Vrflags;		/* Flags for spilled, double, etc */
    int Vrloc;			/* Location: real reg # or stack offset */
    TYPE *Vrtype;		/* C type of object in register */
    int Vroldstk;		/* where to back stack to */
    VREG *Vrnext, *Vrprev;	/* double linked list pointers */
    VREG *Vrmate;		/* Pointer to other reg if part of double */
};

#define VRF_SPILLED	01	/* register is on stack */
#define VRF_REGPAIR	02	/* Reg is 1st of a doubleword */
#define VRF_REG2ND	04	/* Reg is 2nd of a doubleword */
#define VRF_LOCK	010	/* register locked in current phys reg */
#define VRF_SPECIAL	020	/* Special vreg (R_RETVAL or R_SP) */
#define VRF_HASVAL 0100		/* Reg has a needed val, don't clobber it
				** (OK to change reg # if change instr that
				** set it)
				*/
#define VR_RETVAL &vr_retval	/* Constant virtual regs */
#define VR_SP &vr_sp
extern VREG vr_retval, vr_sp;	/* Initialized in CCREG */
#if SYS_CSI			/* For FORTRAN linkage */
#define VR_ZERO &vr_zero
#define VR_FAP &vr_fap
extern VREG vr_zero, vr_fap;
#endif


/* Virtual Register routines, in CCREG */
extern void vrinit(),		/* Init regs for new routine */
	vrendchk();		/* Check regs at end of routine */
extern VREG *vrget(), *vrdget();	/* Allocate virtual register or pair */
extern VREG *vrretget(), *vrretdget();	/* Same but use return-value regs */
extern void vrfree();		/* Release vreg */
extern int vrreal();		/* Get real reg # for active virtual reg */
extern int vrtoreal();		/* Ensure reg is active, return real # */
extern int vrstoreal();		/* Same for 2 regs, return # of 1st */
extern void vrallspill();	/* Spill all active regs onto stack */
extern VREG *vrwiden();		/* Widen a vreg into a pair */
extern void vrlowiden();	/* Common case: widen vreg in low direction */
extern void vrnarrow();		/* Narrow a vreg pair into single vreg */
#define VR2(vr) ((vr)->Vrmate)	/* Get 2nd of a vreg pair */
extern void vrufcreg();		/* Undo MOVE of failed changereg w/o freeing */
extern int vrispair();		/* TRUE if vreg is 1st of a vreg pair */
extern int rfree();		/* TRUE if real register is assigned */
extern int rhasval();		/* TRUE if real register has a value */

/* Register bit macros.  Turns register # into a bit mask. */

#define regbit(r) (1<<(r))	/* Single-register bit */
#define dregbit(r) (3<<(r))	/* Double-register bits */

/* Register bit routines, in CCOPT */

extern int rbref(), rbset(), rbmod(), rbuse(), rbchg(), rbin();
extern int rrref(), rrset(), rrmod(), rruse(), rrchg(), rrin();
extern int rbincode(), rbinreg(), rbinaddr();
extern int rincode(), rinreg(), rinaddr();

/* Array of register bits indexed by register #, for faster use. */

extern int rbits[NREGS];	/* Array of regbit(n) */
extern int drbits[NREGS];	/* Array of dregbit(n) */
