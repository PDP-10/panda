/*	CCOUT.C - Output pseudo-code to assembler file
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.259, 11-Aug-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.77, 8-Aug-1985
**
**	Original version (C) 1981  K. Chen
*/

#include "ccsite.h"
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

static void outpreamble P_((void));
static void outpostamble P_((int mainf));
static int outdecl P_((void));
static void outasmh P_((void));
static char *ahmacs P_((void));
static char *ahmacdef P_((char *cp,char **macro));
static void outinstr P_((PCODE *p));
static int directop P_((int op));
static void simufltr P_((PCODE *p));
static void simdfix P_((PCODE *p,int issigned));
static void simdsngl P_((PCODE *p));
static void simsubbp P_((PCODE *p));
static void simptrcnv P_((PCODE *p));
static void simsmove P_((PCODE *p));
static void simuidiv P_((PCODE *p));
static void outop P_((int opr));
static void outreg P_((int n));
static void outaddress P_((PCODE *p));
static void outpti P_((int bsize,int offset));
static int obplh P_((int boff,int *awoff,int bsize));
static int fltpow2 P_((double d));
static int bigfloat P_((PCODE *p));
static void outrj6 P_((unsigned ms));

#undef P_

static whichseg;	/* 1 = code, -1 = data, 0 = unknown */

/* Tables to handle references to built-in C RunTime symbols without
** going through the overhead of using the symbol table.
** Currently this is only used to determine which CRT symbols need to
** be declared EXTERN in the assembly-language output file.
** Note that $$CVER is always defined and declared in every KCC module,
** as are the appropriate $$CPxx symbols.
*/
#define crtsyms \
	crtsym(CRT_,"")			/* avoid zero index */\
	crtsym(CRT_CRT, "$$$CRT")	/* CRT module "entry point" */\
	crtsym(CRT_CPU, "$$$CPU")	/* CPU module "entry point" */\
	crtsym(CRT_CVER,  "$$CVER")	/* KCC code & library version # */\
	crtsym(CRT_CPUKA, "$$CPKA")	/* KCC/CPU type KA-10 */\
	crtsym(CRT_CPUKI, "$$CPKI")	/* KCC/CPU type KI-10 */\
	crtsym(CRT_CPUKS, "$$CPKS")	/* KCC/CPU type KS-10 and KL-10A */\
	crtsym(CRT_CPUKL0,"$$CPKL")	/* KCC/CPU type KL-10B, section 0 */\
	crtsym(CRT_CPUKLX,"$$CPKX")	/* KCC/CPU type KL-10B, non-0 sect */\
	crtsym(CRT_SECT, "$$SECT")	/* CPU Section # being loaded into */\
	crtsym(CRT_BPH0, "$$BPH0")	/* CPU Byte ptr LHs for 18-bit bytes*/\
	crtsym(CRT_BPH1, "$$BPH1")	/* CPU */\
	crtsym(CRT_BP90, "$$BP90")	/* CPU Byte ptr LHs for 9-bit bytes */\
	crtsym(CRT_BP91, "$$BP91")	/* CPU */\
	crtsym(CRT_BP92, "$$BP92")	/* CPU */\
	crtsym(CRT_BP93, "$$BP93")	/* CPU */\
	crtsym(CRT_BP80, "$$BP80")	/* CPU Byte ptr LHs for 8-bit bytes */\
	crtsym(CRT_BP81, "$$BP81")	/* CPU */\
	crtsym(CRT_BP82, "$$BP82")	/* CPU */\
	crtsym(CRT_BP83, "$$BP83")	/* CPU */\
	crtsym(CRT_BP70, "$$BP70")	/* CPU Byte ptr LHs for 7-bit bytes */\
	crtsym(CRT_BP71, "$$BP71")	/* CPU */\
	crtsym(CRT_BP72, "$$BP72")	/* CPU */\
	crtsym(CRT_BP73, "$$BP73")	/* CPU */\
	crtsym(CRT_BP74, "$$BP74")	/* CPU */\
	crtsym(CRT_BP60, "$$BP60")	/* CPU Byte ptr LHs for 6-bit bytes */\
	crtsym(CRT_BP61, "$$BP61")	/* CPU */\
	crtsym(CRT_BP62, "$$BP62")	/* CPU */\
	crtsym(CRT_BP63, "$$BP63")	/* CPU */\
	crtsym(CRT_BP64, "$$BP64")	/* CPU */\
	crtsym(CRT_BP65, "$$BP65")	/* CPU */\
	crtsym(CRT_BPPS, "$$BPPS")	/* CPU Mask for BP P+S field */\
	crtsym(CRT_BPSZ, "$$BPSZ")	/* CPU BP LH to get BP size field */\
	crtsym(CRT_BSHF, "$$BSHF")	/* CPU # bits to shift in P_SUBBP */\
	crtsym(CRT_BMP6, "$$BMP6")	/* CPU val for 6bit MULI in P_SUBBP */\
	crtsym(CRT_BMP7, "$$BMP7")	/* CPU  "   "  7-bit " */\
	crtsym(CRT_BMP8, "$$BMP8")	/* CPU  "   "  8-bit " */\
	crtsym(CRT_BMP9, "$$BMP9")	/* CPU  "   "  9-bit " */\
	crtsym(CRT_BMPH, "$$BMPH")	/* CPU  "   "  18-bit " */\
	crtsym(CRT_PH90, "$$PH90")	/* CPU Instr #0 for 18->9 cnv */\
	crtsym(CRT_PH91, "$$PH91")	/* CPU Instr #1 for 18->9 cnv */\
	crtsym(CRT_P9H0, "$$P9H0")	/* CPU Instr #0 for 9->18 cnv */\
	crtsym(CRT_P9H1, "$$P9H1")	/* CPU Instr #1 for 9->18 cnv */\
	crtsym(CRT_P9H2, "$$P9H2")	/* CPU Instr #2 for 9->18 cnv */\
	crtsym(CRT_START,"$START")	/* CRT start location */\
	crtsym(CRT_RET,  "$RET")	/* CRT Convenient return label */\
	crtsym(CRT_RETZ, "$RETZ")	/* CRT    ditto, returns 0 */\
	crtsym(CRT_RETF, "$RETF")	/* CRT    ditto, returns 0 */\
	crtsym(CRT_RETP, "$RETP")	/* CRT    ditto, returns 1 */\
	crtsym(CRT_RETT, "$RETT")	/* CRT    ditto, returns 1 */\
	crtsym(CRT_RETN, "$RETN")	/* CRT    ditto, returns -1 */\
	crtsym(CRT_ZERO, "$ZERO")	/* CRT Double 0.0 constant */\
	crtsym(CRT_ADJBP, "$ADJBP")	/* CRT ADJBP simulation rtn (unused)*/\
	crtsym(CRT_BPMUL, "$BPMUL")	/* CRT BP mul table (for P_SUBBP) */\
	crtsym(CRT_BPADT, "$BPADT")	/* CRT BP table of $BPADn (for ") */\
	crtsym(CRT_BPAD6, "$BPAD6")	/* CRT BP 6-bit add table (for ") */\
	crtsym(CRT_BPAD7, "$BPAD7")	/* CRT BP 7-bit add table (for ") */\
	crtsym(CRT_BPAD8, "$BPAD8")	/* CRT BP 8-bit add table (for ") */\
	crtsym(CRT_BPAD9, "$BPAD9")	/* CRT BP 9-bit add table (for ") */\
	crtsym(CRT_BPADH, "$BPADH")	/* CRT BP 18-bit add table (for ") */\
	crtsym(CRT_BPCNT, "$BPCNT")	/* CRT Byte ptr auxiliary */\
	crtsym(CRT_SUBBP, "$SUBBP")	/* CRT Byte ptr subtraction aux */\
	crtsym(CRT_DFIX,  "$DFIX")	/* CRT Aux for (int)(double) cast */\
	crtsym(CRT_DFIXS, "$DFIXS")	/* CRT Aux for (int)(double) cast */\
	crtsym(CRT_DFLTS, "$DFLTS")	/* CRT Aux for (double)(int) cast */\
	crtsym(CRT_SPUSH, "$NSPUSH")	/* CRT Aux to put struct on stack */\
	crtsym(CRT_SPOP,  "$NSPOP")	/* CRT Aux to get struct from stack */

#define crtsym(idx, sym) idx,
enum { crtsyms CRT_N };		/* Define the CRT_ indices plus count */
#undef crtsym

static int crtref[CRT_N];		/* Table of CRT sym reference counts */
#define crtsym(idx, sym) sym,
static char *crtsnam[CRT_N] = { crtsyms };	/* Table of CRT symbol names */
#undef crtsym

/*
** OUTINIT - Initialize assembled code output
**	Called once for each file compiled.
*/
void
outinit()
{
    register int i;

    for(i = CRT_N; --i >= 0;)	/* Reset reference counts */
	crtref[i] = 0;

    /* These two runtime symbols are ALWAYS implicitly referenced;
    ** they refer to the CRT and CPU runtime modules.
    ** See outpostamble() for a special reset check, though.
    */
    ++crtref[CRT_CRT];
    ++crtref[CRT_CPU];

    outpreamble();		/* Output assembler preamble */
    whichseg = 1;		/* Now starting in code section */
}

/* OUTDONE - Finalize assembled code output.
*/
void
outdone(mainf)
{
    outpostamble(mainf);
}

/*
**      assembler preamble and postamble
*/

static void
outpreamble()
{
    if (tgasm == TGASM_MIDAS)		/* This MIDAS pseudo */
	outstr(".SYMTAB 8111.,8003.\n");	/* must come before TITLE. */
    outstr("\tTITLE\t");		/* Make TITLE pseudo-op */
    outstr(inpfmodule);			/* with name of input file as title */
    outnl();

    /* Now output the Assembler Header, either by generating it
    ** ourself or copying it from a user-specified file.
    */
    outasmh();
}

static void
outpostamble(mainf)
int mainf;			/* TRUE if main() was defined in file */
{
    register int i, c;
    register SYMBOL *s;

    outnl();
    codeseg();				/* make sure in code segment */

    /* Specify machine types usable with this module */
    for (c = TGCPU_N; --c >= 0;)
	if (tgcpu[c] == 0) {	/* Impossible CPUs have their symbol set 0 */
	    switch(c) {
		case TGCPU_KA:	i = CRT_CPUKA;	break;
		case TGCPU_KI:	i = CRT_CPUKI;	break;
		case TGCPU_KS:	i = CRT_CPUKS;	break;
		case TGCPU_KL0:	i = CRT_CPUKL0;	break;
		case TGCPU_KLX:	i = CRT_CPUKLX;	break;
		default: int_error("outpostamble: bad CPU");
			i = CRT_CPUKL0;
	    }
	    outstr(crtsnam[i]);
	    outstr("==0\n\t");
	    outstr(tgasm == TGASM_MIDAS ? ".GLOBAL " : "INTERN ");
	    outstr(crtsnam[i]);
	    outnl();
	}

    if (tgasm == TGASM_MIDAS) {		/* output literals and finish */
	dataseg();
	outstr("\tVARIABLES\n");	/* Put any accumulated vars here */
	codeseg();			/* Then back to code seg */
	outstr("\n\tCONSTANTS\n");	/* for accumulated literals */
    } else outstr("\n\tLIT\n");

    /* "main" module needs entry vector set.  This crock is necessary
    ** because FAIL requires that the arg to END be defined in the current
    ** module!
    */
    if (mainf) {
	outstr("$$STRT: JRST $START\n");
	outstr("\tJRST $START+1\n");
	outstr("\t0\n");			/* 3rd wd for T20 ver info */
	++crtref[CRT_START];
    }

    /* Output EXTERN declarations for any C runtime symbols we used */

    /* Normally the CPU and CRT modules are always reffed, but just
    ** to make life easier for us KCC implementors, we check here
    ** for compiling those modules themselves, and avoid sending out
    ** an EXTERN if so!
    */
    if ((s = symfidstr("`$$$CRT")) && s->Sclass==SC_EXTDEF)
	crtref[CRT_CRT] = 0;		/* Is defined, pretend not reffed */
    if ((s = symfidstr("`$$$CPU")) && s->Sclass==SC_EXTDEF)
	crtref[CRT_CPU] = 0;		/* Is defined, pretend not reffed */

    /* Emit symbol requests for all referenced C runtime support stuff */
    for (i = CRT_N; --i >= 0; )
	if (crtref[i]) {
	    outstr(tgasm == TGASM_MIDAS ? "\t.GLOBAL " : "\tEXTERN\t");
	    outstr(crtsnam[i]);
	    outnl();
	}
#if 0
    if (bytsym.Svalue) outstr("\tEXTERN\t$BYTE\n");
#endif

    outdecl();			/* Output user-defined INTERN and EXTERNs */

    /* Finally, output entry vector if any */
    if (mainf)
	outstr("\tEND <3,,$$STRT>\n");	/* 3 wds in entry vector */
    else
	outstr("\tEND\n");
}

/* OUTDECL - Output assembler external & internal declarations at end
**	of compiling a module (translation unit).
*/
static int
outdecl()
{
    SYMBOL *s = symbol;		/* Start of global sym list */
    int num = 0;

    while (s = s->Snext) {
	switch (s->Sclass) {
	default: continue;

	case SC_EXTDEF:		/* External linkage sym defined */
	    num++;
	    outstr(tgasm == TGASM_MIDAS ? "\t.GLOBAL\t " : "\tINTERN\t");
	    break;

	case SC_EXTREF:		/* External linkage sym referenced */
	case SC_XEXTREF:
	    /* Symbol not defined.  Ask for it if needed */
	    if (s->Srefs == 0) {	/* If never used, don't ask. */
		if (!delete)		/* If keeping asm file, */
		    outc(';');		/* output it as a comment. */
		else continue;		/* Otherwise just ignore */
	    }
	    outstr(tgasm == TGASM_MIDAS ? "\t.GLOBAL\t" : "\tEXTERN\t");
	    break;
	}
	outmiref(s);
	outnl();
    }
    return num;
}

/* MAKPREFILE - determines whether a prefix assembler file is needed
**	and creates it if so.  Returns non-zero if one was created.
**	Always generates one for MIDAS since an .INSRT was already put
**	in the output MID file!
*/
int
makprefile(fname)
char *fname;
{
    SYMBOL *sym;
    FILE *savout, *fpre;
    char *savnam;
    int nexfs = 0;

    /* Scan symbol table to see if there are any names
    ** we should export as library entry points.
    */
    if (tgasm == TGASM_MIDAS) nexfs++;	/* Fake out */
    else {
	for (sym = symbol; sym = sym->Snext;)
	    if (sym->Sclass == SC_EXTDEF)	/* An external definition? */
		break;				/* Yup */
	if (sym == NULL) return 0;	/* If none, just return */
    }

    if ((fpre = fopen(prefname, "w")) == NULL)
	return errfopen("prefix output", prefname), 0;

    savout = out;
    savnam = outnam;
    out = fpre;		/* Set this so can use outstr and outmiref */
    outnam = prefname;

    /* OK, now output entry statements for each exportable symbol */
    for(; sym; sym = sym->Snext)
	if (sym->Sclass == SC_EXTDEF) {	/* For each external def */
	    outstr(tgasm == TGASM_MIDAS ? ".GLOBAL " : "ENTRY ");
	    outmiref(sym);
	    outnl();
	    ++nexfs;
	}
    out = savout;	/* Restore old pointer if any */
    outnam = savnam;

    if (fclose(fpre) == EOF) errio("writing assembler", prefname);
    return(nexfs);
}

/*
** KCC Assembler Header output
**
** This section contains the code required to generate the assembler header
** text that KCC puts at the beginning of all its assembler
** output files, just after any ENTRY or TITLE statements, and before
** any generated code.
**
** The header for both FAIL and MACRO is identical.
** However, MIDAS requires a somewhat different syntax.
*/

/* OUTASMH -  Output assembler header file.
**
** Copy Assembler Header File from its default or user-specified location.
** This should end up in the code segment, and supply macros
** %%CODE and %%DATA for switching between the two.
*/
static char *asmhdr = NULL;
static void
outasmh()
{
    FILE *hdrf;
    register int c;

    /* If user explicitly specified an assembler header file, use it. */
    if (asmhfile) {
	if ((hdrf = fopen(asmhfile, "r")) == NULL) /* open file */
	    errfopen("preamble", asmhfile);	/* no luck, give up */
	else {
	    while ((c = getc(hdrf)) != EOF) outc(c); /* copy file */
	    if (ferror(hdrf) || !feof(hdrf))
		jerr("I/O error while reading preamble \"%s\"", asmhfile);
	    fclose(hdrf);
	    return;
	}
    }
    /* No file specified, or couldn't open.  Use self-generated header. */
    outstr(asmhdr ? asmhdr : ahmacs());		/* Make or use existing */
}

/* Macro definition tables */

static char * macdmv[] = {	"DMOVE",
	"MOVE A,M",
	"MOVE A+1,1+M",
	NULL
};
static char * macdmm[] = {	"DMOVEM",
	"MOVEM A,M",
	"MOVEM A+1,1+M",
	NULL
};

static char * macjsp[] = {	"ADJSP",
	"ADD A,[<M,,M>+<M&<-1,,0>>]",
	NULL
};

/*
** Byte pointer operations.
**
** ADJBP AC,MEM
**    takes a byte count in AC and a byte pointer of any shape in MEM,
**    and leaves a byte pointer shifted over by the count in the AC.
**
** %%CHBP AC,MEM
**    backs up the byte pointer in MEM by one and leaves it in AC.
**    This was sometimes used in old runtimes to produce an ILDB pointer
**    from an IBP pointer.  The result may not quite be the same as
**    corresponding AC -- it may be a (POINT n,X) pointer i.e. have
**    a P field of 44 -- so only do this once and don't index through
**    the result or compare it to another non-%%CHBP pointer.
*/

static char * macdb1[] = { 	"%%CHBP",	/* For machines with ADJBP */
	"SETO A,",
	"ADJBP A,M",
	NULL
};
static char * macjbp[] = {	"ADJBP",
	"EXTERN	$ADJBP",	/* Declare extern routine to simulate it */
	"MOVE	16,M",		/* Do this before EXCH.  Get byte pointer */
	"EXCH	15,A",		/* Put count into expected reg, save AC15 */
	"PUSHJ	17,$ADJBP",	/* Call $ADJBP to simulate byte ptr add */
	"EXCH	15,A",		/* restore AC15 and get adjusted bp in reg */
	NULL
};

static char * macdb2[] = {	"%%CHBP",
	"MOVE	A,M",		/* Get byte pointer */
	"ADD	A,[110000,,0]",	/* Adjust assuming 9-bit bytes */
	"TLNN	A,007000",	/* Was it 7-bit byte pointer? */
	" SUB	A,[020000,,0]",	/* Yes, fix up for that case */
	NULL,
};


/* General-purpose FLTR instruction for KA-10.
** This correctly handles integers larger than 27 significant bits.
** When the code generator knows that the integer will be small enough, it
** can produce a simple FSC R,233 instead.  The simulation for UFLTR
** (unsigned FLTR) may also use a slightly better sequence since in that
** case the number will assuredly be positive.
*/
static char * macfltr[] = {	"FLTR",
	"MOVE A,M",
	"MOVE 16,A+1",		/* Must save A+1 */
	"ASHC A,-10",		/* Shift valid bits out of exponent field */
	"FSC A,233+10",		/* Now can float the high bits of integer */
	"ASH A+1,-32",		/* Right-justify low 8 bits of integer */
	"FSC A,233",		/* Float them too */
	"FADR A,A+1",		/* Add together to produce result! */
	"MOVE A+1,16",		/* Restore A+1 */
	NULL
};

/*
** KA-10 Double-Precision Floating Point (software format) Macros
**
** Copied from:
**    DEC Assembly Language Handbook, 1st edition, 1972
**    PDP-10 System Reference Manual  DEC-10-HGAC-D
**	3rd printing August 1969
**	Page 2-67, "Programming Examples".
**
** NOTE!  These macros require 3 registers, not just 2!
** We can save things in AC16 and be sure that A+2 is free
** (KCC reserves AC16 as a temporary for just such purposes).
** We never use doublewords beyond 14/15 so A+2 always exists.
**
** Some of these sequences are less than efficient, but they
** have to be sufficiently general to cover all possible abuses
** (e.g. unexpected registers used as indices in addresses).
*/

	/* %%DSAV A,M - Set up A+2/free, M into -2(17)/-1(17): */
static char * macdsv[] = {	"%%DSAV",
	"MOVE	16,1+M",	/* Get low word (push here would mess up M) */
	"PUSH	17,M",		/* Now safe to push high word */
	"PUSH	17,16",		/* Followed by low word (careful if A+2==16) */
	"PUSH	17,A+2",	/* Followed by AC to be freed */
	NULL
};
	/* %%DRST A, - Restore at end of double op after %%DSAV: */
static char * macdrs[] = {	"%%DRST",
	"POP	17,A+2",	/* Get saved register back */
	"ADJSP	17,-2",		/* Forget about pushed copy of doubleword */
	NULL
};
	/* DMOVN A,M - Get double from memory and negate: */
static char * macdnv[] = {	"DMOVN",
	"MOVE	A,M",		/* Get high part of double */
	"MOVE A+1,1+M",		/* Then low part */
	"DFN	A,A+1",		/* Do double register negate */
	NULL
};
	/* DMOVNM A,M - Save negated doubleword into memory: */
static char * macdnm[] = {	"DMOVNM",
	"DFN	A,A+1",		/* Negate register doubleword */
	"MOVEM	A,M",		/* Store high part of negated word into mem */
	"MOVEM	A+1,1+M",	/* And low part */
	"DFN	A,A+1",		/* Negate reg again to leave the way it was */
	NULL
};
	/* DFAD A,M - Add two doubles: */
static char * macdfad[] = {	"DFAD",
	"%%DSAV	A,M",		/* Set up for doubleword op */
	"UFA	A+1,-1(17)",	/* Sum of low parts to A+2 */
	"FADL	A,-2(17)",	/* Sum of high parts to A,A+1 */
	"UFA	A+1,A+2",	/* Add low part of high sum to A+2 */
	"FADL	A,A+2",		/* Add low sum to high sum */
	"%%DRST A,0",		/* Fix up after doubleword op */
	NULL
};
	/* DFSB A,M - Subtract double in mem from one in acs: */
static char * macdfsb[] = {	"DFSB",
	"DFN	A,A+1",		/* Negate double length operand */
	"DFAD	A,M",		/* Perform normal add */
	"DFN	A,A+1",		/* -(M - AC) = AC - M */
	NULL
};
	/* DFMP A,M - Multiply two doubles: */
static char * macdfmp[] = {	"DFMP",
	"%%DSAV	A,M",		/* Set up for doubleword op */
	"MOVEM	A,A+2",		/* Copy high AC operand in A+2 */
	"FMPR	A+2,-1(17)",	/* High reg times low mem to A+2 */
	"FMPR	A+1,-2(17)",	/* Low reg times high mem to A+1 */
	"UFA	A+1,A+2",	/* Add cross products into A+2 */
	"FMPL	A,-2(17)",	/* High product to A,A+1 */
	"UFA	A+1,A+2",	/* Add low part to cross sum in A+2 */
	"FADL	A,A+2",		/* Add low sum to high part of product */
	"%%DRST A,0",		/* Fix up after doubleword op */
	NULL
};
	/* DFDV A,M - Divide double in acs by one in mem: */
static char * macdfdv[] = {	"DFDV",
	"%%DSAV	A,M",		/* Set up for complicated double op */
	"FDVL	A,-2(17)",	/* Get high part of quotient */
	"MOVN	A+2,A",		/* Copy negative of quotient in A+2 */
	"FMPR	A+2,-1(17)",	/* Multiply by low part of divisor */
	"UFA	A+1,A+2",	/* Add remainder */
	"FDVR	A+2,-2(17)",	/* Divide sum by high part of divisor */
	"FADL	A,A+2",		/* Add result to original quotient */
	"%%DRST A,0",		/* Fix up after doubleword op */
	NULL
};

/* Segmentation macros.  See codeseg() and dataseg() for more comments. */

static char segfai[] = "\
	TWOSEG	400000	\n\
	RELOC	0	\n\
	RELOC	400000	\n\
	DEFINE %%CODE <RELOC>\n\
	DEFINE %%DATA <RELOC>\n";

/* For MIDAS the code/data macros use .M" to ensure that the definitions they
** make are valid even if used within a .BEGIN symbol block.
*/
static char segmid[] = "\
	.DECTWO 400000	\n\
	$$RLO==.	\n\
	.=.+400000	\n\
	$$RHI==.	\n\
DEFINE %%CODE		\n\
.M\"$$RLO==. ? .=.M\"$$RHI	\n\
TERMIN			\n\
DEFINE %%DATA		\n\
.M\"$$RHI==. ? .=.M\"$$RLO	\n\
TERMIN\n";


static char *
ahmacs()
{
    register char *cp;
    char *beg;
    int size;

    /* To construct the possibly large header string, we steal space
    ** by re-using the pcode buffer temporarily.  Check when done to ensure
    ** it wasn't overflowed!
    */
    beg = cp = (char *)codes;

#if SYS_CSI
    if (profbliss)			/* profiling switch for CSI */
	cp = estrcpy(cp, "\t.REQUIRE BLI:PROFIL.REL\n");
#endif			/* inserted for BLISS profiler, 9/29/89 MVS */

    /* Make request for standard C library (unless using MIDAS).
    ** Eventually flush this request and rely on KCC linker invocation.
    */
    if (tgasm != TGASM_MIDAS)
    {
	cp = fnlibpath(estrcpy(cp, "\t.REQUEST "), "c");
	if (!strcmp(&cp[- strlen(SWI_LIBTYPE)], SWI_LIBTYPE))
	  cp -= (strlen(SWI_LIBTYPE) + 1);
	cp = estrcpy(cp, "\n");
    }
    else
	/* If MIDAS, take the opportunity to .INSRT the prefix file here. */
	cp = estrcpy(estrcpy(estrcpy(cp, ".INSRT "), prefname), "\n");

    /* Specify version of compiler and library used with this module */
    sprintf(cp,"\t$$CVER==<%o,,%o>\n\t%s $$CVER\n",
		cvercode, cverlib,
		(tgasm == TGASM_MIDAS) ? ".GLOBAL" : "INTERN");		
    cp += strlen(cp);			/* Sigh, update ptr */

    /* Add machine-dependent macro definitions */
    if (!tgmachuse.dmovx) {
	cp = ahmacdef(cp, macdmv);		/* DMOVE */
	cp = ahmacdef(cp, macdmm);		/* DMOVEM */
    }
    if (!tgmachuse.adjsp)
	cp = ahmacdef(cp, macjsp);		/* ADJSP */
    if (tgmachuse.adjbp) {
	/* FAIL and MACRO need to have ADJBP defined! */
	if (tgasm == TGASM_FAIL || tgasm == TGASM_MACRO)
	    cp = estrcpy(cp, "\tOPDEF ADJBP [IBP]\n");
	cp = ahmacdef(cp, macdb1);		/* %%CHBP */
    } else {
	cp = ahmacdef(cp, macjbp);		/* ADJBP */
	cp = ahmacdef(cp, macdb2);		/* %%CHBP */
    }
    if (!tgmachuse.fixflt)
	cp = ahmacdef(cp, macfltr);		/* FLTR */

#if SYS_CSI				    /* PROF. for profiling */
    if (profbliss)			    /* added 09/15/89 by MVS */
	cp = estrcpy(cp, "\tOPDEF PROF. [37B8]\n");
#endif

    if (tgmachuse.dfl_s) {	/* KA-10 Software double-precision instrs */
	cp = ahmacdef(cp, macdsv);		/* %%DSAV */
	cp = ahmacdef(cp, macdrs);		/* %%DRST */
	cp = ahmacdef(cp, macdnv);		/* DMOVN */
	cp = ahmacdef(cp, macdnm);		/* DMOVNM */
	cp = ahmacdef(cp, macdfad);		/* DFAD */
	cp = ahmacdef(cp, macdfsb);		/* DFSB */
	cp = ahmacdef(cp, macdfmp);		/* DFMP */
	cp = ahmacdef(cp, macdfdv);		/* DFDV */
    }

    /* Miscellaneous op-code definitions.
    ** ERJMP and ERJMPA are for TOPS-20 and TENEX systems only, for
    **	the benefit of library (or user) #asm code.
    ** ERJMPA should be used instead of ERJMP when the JSYS normally skips.
    **
    ** XMOVEI and IFIW are used with extended addressing code.
    ** XBLT likewise; this is actually an EXTEND sub-operation.
    */
    if (tgasm == TGASM_FAIL || tgasm == TGASM_MACRO) {
	if (tgsys == TGSYS_TOPS20 || tgsys == TGSYS_TENEX) {
	    cp = estrcpy(cp, "IFNDEF ERJMP,< OPDEF ERJMP [JUMP 16,] >\n");
	    if (tgsys == TGSYS_TOPS20)
		cp = estrcpy(cp,  "OPDEF ERJMPA [ERJMP]\n");
	    else cp = estrcpy(cp, "OPDEF ERJMPA [JUMPA 16,]\n");
	}
	cp = estrcpy(cp, "OPDEF	XMOVEI	[SETMI]\n\tDEFINE IFIW <SETZ >\n");
    } else if (tgasm == TGASM_MIDAS) {
	cp = estrcpy(cp, (tgsys == TGSYS_TOPS20
		? "ERJMPA==<ERJMP>\n"		/* T20 */
		: "ERJMPA==<JUMPA 16,>\n"));	/* otherwise */
	cp = estrcpy(cp, "IFIW==<SETZ>\n");	
    }
    if (tgasm == TGASM_FAIL)
	cp = estrcpy(cp, "OPDEF XBLT [020000,,0]\n");
    else if (tgasm == TGASM_MIDAS)
	cp = estrcpy(cp, "XBLT==<020000,,0>\n");

    
    /* Code and data segmentation setup and %%DATA/%%CODE macro definition */
    if (tgasm == TGASM_FAIL || tgasm == TGASM_MACRO)
	cp = estrcpy(cp, segfai);
    else if (tgasm == TGASM_MIDAS) cp = estrcpy(cp, segmid);

/*
** Finally, we try to purge symbols which may conflict with user-defined syms.
** However, there is a bug in FAIL which causes SEARCH MONSYM to barf
** ("FAIL BUG IN SEARCH") if the SEARCH comes after the IF's are purged!
** But if we put the SEARCH here, before the PURGE, we are including it in ALL
** KCC output, which is not a good idea; there is more overhead, and
** otherwise undefined symbols might be unexpectedly satisfied from MONSYM!
** For the time being, since FAIL will output a .REL file anyway even after
** barfing about the SEARCH, we will continue doing this, and include a
** note in the doc to ignore those barfs, and hope someone fixes FAIL someday.
**
** Note that MACRO will not complain, and consequently MACRO is preferred
** when compiling modules with #asm code (such as the C library!)
*/
    if (tgasm == TGASM_FAIL || tgasm == TGASM_MACRO)
	cp = estrcpy(cp, "\
PURGE IFE,IFN,IFG,IFGE,IFL,IFLE,IFDEF,IFNDEF,IFIDN,IFDIF\n");
    else if (tgasm == TGASM_MIDAS)
	cp = estrcpy(cp, "\
IF1 [EQUALS $IFE,IFE?EQUALS $IFN,IFN?EQUALS $IFG,IFG?EQUALS $IFL,IFL\n\
  EQUALS $IFGE,IFGE?EQUALS $IFLE,IFLE?EQUALS $IFSE,IFSE?EQUALS $IFSN,IFSN\n\
  EQUALS $IFDEF,IFDEF?EQUALS $IFNDEF,IFNDEF?EQUALS $IRP,IRP\n\
  EXPUNGE IFE,IFN,IFG,IFGE,IFL,IFLE,IFSE,IFSN,IFDEF,IFNDEF,IRP\n\
]\n");

    size = strlen(beg)+1;		/* Find size of entire header */
    if (size > sizeof(codes))		/* Paranoia check */
	fatal("Assembler header table overflow");
    if (asmhdr = malloc(size)) {	/* Now try to relocate it */
	strcpy(asmhdr, beg);		/* Won, copy header to save it! */
	return asmhdr;
    }
    return beg;			/* No luck, just re-generate each time */
}

static char *
ahmacdef(cp, macro)
char *cp;
char **macro;
{
    switch (tgasm) {
	case TGASM_FAIL:
	case TGASM_MACRO:
	    cp = estrcpy(estrcpy(estrcpy(cp,"DEFINE "),macro[0]),"(A,M)\n<");
	    while (*++macro)
		cp = estrcpy(estrcpy(estrcpy(cp, "\t"), *macro), "\n");
	    cp = estrcpy(cp, ">\n");
	    break;
	case TGASM_MIDAS:
	    cp = estrcpy(estrcpy(estrcpy(cp,"DEFINE "),macro[0])," A,M\n");
	    while (*++macro)
		cp = estrcpy(estrcpy(estrcpy(cp, "\t"), *macro), "\n");
	    cp = estrcpy(cp, "TERMIN\n");
	    break;
    }
    return cp;
}

/*
** Data segmentation.
**
** KCC emits code in two sections: code and data.  The header sets things up
** so that code and data are in the high and low segments, which typically
** correspond to the high and low halves of their section but which can be
** rearranged by the appropriate LINK directives.
**
** Code and data are separated in the assembly output by the %%CODE and %%DATA
** macros.  %%CODE will never be called from any context other than the data
** segment, and vice versa.  KCC expects the header to initially be in code.
**
** During code generation, codeseg() and dataseg() are used to switch
** between the two segments.
*/

/* CODESEG - Start using code (pure) segment
*/
int
codeseg()
{
    int oseg;
    if ((oseg = whichseg) < 0) {	/* if in data */
	outstr("\n\t%%CODE\n");		/* put in code instead */
	whichseg = 1;			/* and remember in code */
    }
    return oseg;
}

/* DATASEG - Start using data (impure) segment
*/
int
dataseg()
{
    int oseg;
    if ((oseg = whichseg) > 0) {	/* if in code */
	outstr("\n\t%%DATA\n");		/* put in data instead */
	whichseg = -1;			/* and remember in data */
    }
    return oseg;
}

/* PREVSEG - restore to previous segment
*/
int
prevseg(seg)
{
    return (seg < 0) ? dataseg() : codeseg();
}

/* REALCODE(p) - Generate real code for given pseudo-instruction.
**	This is the primary assembler output function.
*/
void
realcode(p)
PCODE *p;
{
    int i, typ;

    typ = (p->Ptype &~ PTF_SKIPPED);	/* Get sanitized addressing type */

    switch (p->Pop & POF_OPCODE) {

    case P_NOP:			/* Ignore deleted pseudo-code */
	return;

    /* Handle the various simulated ops, which do not correspond
    ** directly to a real PDP-10 instruction.
    */
    case P_PTRCNV: simptrcnv(p);return;	/* "Pointer Conversion"  */
    case P_SMOVE: simsmove(p); return;	/* "Structure Move" */
    case P_UFLTR: simufltr(p); return;	/* "Unsigned Float & Round" */
    case P_UIDIV: simuidiv(p); return;	/* "Unsigned Integer Divide" */
    case P_SUBBP: simsubbp(p); return;	/* "Subtract Byte Pointer" */
    case P_DFIX:  simdfix(p,1); return; /* "Signed Double Fix" */
    case P_UDFIX:  simdfix(p,0); return; /* "Unsigned Double Fix" */
    case P_DSNGL: simdsngl(p); return;	/* "Double to Single" */

    /* End of simulated ops; switch continued on next page! */

    /* Switch continued from previous page!  Start of "real" ops. */

    /*
    ** If we are doing a test or comparison with a number, and the number
    ** is larger than 18 bits, we have to use a literal.
    ** We also have to perform a similar transformation if we want
    ** to compare the register with an immediate address.
    ** This entails changing the opcode from TRN to TDN, CAI to CAM, etc.
    ** Note this is NOT an optimization -- it is needed to avoid generating
    ** impossible instructions.
    */
    case P_TRN:
	if (foldtrna(p)) return;
    case P_TRC:
    case P_TRZ:
    case P_TRO:
    case P_CAI:
	if (typ != PTA_RCONST || (p->Pvalue &~ 0777777) == 0) break;
	if ((p->Pvalue & 0777777) == 0) {
	    switch (p->Pop & POF_OPCODE) {
		case P_TRN: i = P_TRN ^ P_TLN;	break;
		case P_TRO: i = P_TRO ^ P_TLO;	break;
		case P_TRZ: i = P_TRZ ^ P_TLZ;	break;
		case P_TRC: i = P_TRC ^ P_TLC;	break;
		default: i = 0; break;
	    }
	    if (i) {
		p->Pop ^= i;			/* Flip from RH to LH */
		p->Pvalue = ((unsigned) p->Pvalue) >> 18;
		break;
	    }
	}
	if (!(p->Pvalue &~ 0777777)) break; /* still too big? */
	p->Pop = directop(p->Pop);	/* Turn into memory version */
	typ |= PTF_IMM;		/* Make PTV_IMMED so outinstr hacks bigness */
	break;

    /* Optimization for non-test bitwise operations (IOR, AND, XOR).
    ** We try turning these into tests to avoid referencing memory
    ** for a literal constant.
    */
    case P_IOR:
	if (!optobj || typ != PTV_IMMED || (p->Pvalue &~ 0777777) == 0)
	    break;			/* Can't or don't optimize */
	if ((p->Pvalue & 0777777) == 0) { /* x,,0 */
	    p->Pop = P_TLO;
	    typ = PTA_RCONST;
	    p->Pvalue = ((unsigned) p->Pvalue) >> 18;
	} else if (((unsigned) p->Pvalue >> 18) == 0777777) { /* 777777,,x */
	    p->Pop = P_ORCM;
	    p->Pvalue = (~p->Pvalue) & 0777777;
	}
	break;

    case P_XOR:
	if (!optobj || typ != PTV_IMMED || (p->Pvalue &~ 0777777) == 0)
	    break;			/* Can't or don't optimize */
	if ((p->Pvalue & 0777777) == 0) { /* x,,0 */
	    p->Pop = P_TLC;
	    typ = PTA_RCONST;
	    p->Pvalue = ((unsigned) p->Pvalue) >> 18;
	} else if (((unsigned) p->Pvalue >> 18) == 0777777) { /* 777777,,x */
	    p->Pop = P_EQV;
	    p->Pvalue = (~p->Pvalue) & 0777777;
	}
	break;

    case P_AND:
	if (!optobj || typ != PTV_IMMED || (p->Pvalue &~ 0777777) == 0) 
	    break;			/* Can't or don't optimize */
	if ((p->Pvalue & 0777777) == 0777777) { /* x,,777777 */
	    p->Pop = P_TLZ;
	    typ = PTA_RCONST;
	    p->Pvalue = (unsigned)(~p->Pvalue) >> 18;
	} else if (((unsigned)p->Pvalue >> 18) == 0777777) { /* 777777,,x */
	    p->Pop = P_TRZ;
	    typ = PTA_RCONST;
	    p->Pvalue = (~p->Pvalue) & 0777777;
	}
	break;

    /*
    ** Signed integer multiplication by a power of two is better done as an ASH
    ** (arithmetic shift - not the same as LSH).  Don't try this
    ** for division, as the result is incorrect for negative numbers!
    ** Note that unsigned multiplication will use P_MUL, not P_IMUL.
    ** Note the subtle test for power-of-two-ness which relies on
    ** twos-complement arithmetic.
    **
    ** Similarly, floating multiply by two becomes FSC (floating scale).
    ** Division is OK, unlike the integer case.
    ** This can only work for single-precision floats (not doubles).
    ** Otherwise we fall through to the other floating code.
    */
    case P_IMUL:
	if (optobj && typ == PTV_IMMED && (p->Pvalue & (p->Pvalue - 1)) == 0) {
	    p->Pvalue = binexp(p->Pvalue);	/* get # of bits to shift */
	    p->Pop = P_ASH;			/* and opcode */
	    typ = PTA_RCONST;			/* and code type */
	}
	break;

    case P_FMPR:		/* If doing single-precision mult or div */
    case P_FDVR:
	if (optobj
	  && typ == PTA_FCONST		/* If operand is a float constant */
	  && (i = fltpow2(p->Pfloat))) {	/* and is a power of 2 */
		p->Pvalue = (p->Pop == P_FDVR) ? -i : i;
		p->Pop = P_FSC;
		typ = PTA_RCONST;
		break;
	}

    /*
    ** Optimize moves of constants to use immediate form if possible.
    ** A check for "float" constants, which can be
    ** MOVSI'd into the LH if their RH is zero, is made in outinstr().
    ** "double" constants
    ** normally do not come here as they use DMOVx, but it is possible
    ** as part of a code sequence that zeros the second AC separately.
    */
    case P_MOVN:
	if (!optobj || typ != PTV_IMMED || (p->Pvalue &~ 0777777) == 0) break;
	p->Pop = P_MOVE;		/* re-invert P_MOVN */
	p->Pvalue = - p->Pvalue;	/* for fixup into P_MOVSI */
    case P_MOVE:
	if (!optobj || typ != PTV_IMMED) break;
	if (p->Pvalue && (p->Pvalue & 0777777) == 0) {
	    p->Pop = P_MOVS;		/* MOVEI of left half quantity */
	    p->Pvalue = ((unsigned) p->Pvalue) >> 18;	/* becomes MOVSI */
	}
	break;
    }
    /* End of moby switch on instruction opcode! */

    typ |= p->Ptype & PTF_SKIPPED;
    p->Ptype = typ;	/* Put back type in case it was changed. */
    outinstr(p);	/* Output the instruction! */
}

/* OUTINSTR(p) - Output instruction.
**
** We give a skipped-over op an extra space of indentation, to make it look
** more like human code (big deal) and to make debugging KCC easier.
*/
static void
outinstr(p)
PCODE *p;
{
    int big, i, opr;

    outtab();				/* Start instruction output w/ tab */
    if (p->Ptype & PTF_SKIPPED)		/* Indent skipped-over instr */
	outc(' ');

    switch (p->Ptype & PTF_ADRMODE) {

    case PTA_ONEREG:
	outop(p->Pop);
	outreg(p->Preg);
	break;

    case PTA_REGIS:
	outop(p->Pop);
	outreg(p->Preg);
	outnum(p->Pr2);
	break;

    /* PTA_MINDEXED operands require special hackery when the operand is
    ** being used in an immediate fashion, i.e. the address value itself
    ** is needed.  This can happen either if the operand is marked
    ** immediate (PTF_IMM set) or if the opcode is one that treats E as
    ** an immediate operand (only CAIx and TRx are checked).  This special
    ** handling typically involves using an XMOVEI to get the real address
    ** if the target machine uses extended addressing.
    */
    case PTA_MINDEXED:
	if (!(p->Ptype & PTF_IMM)) {
	    /* Not using immediate address, only need to check for
	    ** instrs that are always immediate.
	    */
	    if (i = directop(p->Pop)) {	/* Converting CAI, etc to CAM etc? */
		p->Pop = i;		/* Ugh, convert to direct form */
		/* Fall past to do XMOVEI */
	    } else {
		/* Normal operand, easy! */
		outop(p->Pop);		/* Normal op, just output it */
		outreg(p->Preg);	/* use given reg */
		outaddress(p);		/* and address */
		break;			/* Done! */
	    }
	}

	/* Instruction is using an immediate address.
	** The only instruction to correctly implement this addressing
	** mode in extended sections is XMOVEI.  Others must be simulated
	** by an XMOVEI into a scratch register followed by reg-to-reg
	** operation.
	*/
	if (p->Pop == P_MOVE || p->Pop == P_XMOVEI) {
	    outop(P_XMOVEI);	/* Substitute XMOVEI for MOVEI */
	    outreg(p->Preg);	/* Use given reg */
	    outaddress(p);	/* and address */
	    break;
	}
	/* Instruction needs an XMOVEI preceding it.  Barf if we
	** generated a skip over this instr in the mistaken belief it
	** only occupied 1 word, which means that oneinstr() was either
	** wrong or wasn't called.  In particular, this should never happen
	** for the second of a cascaded skip.
	*/
	if (p->Ptype & PTF_SKIPPED)
	    int_error("outinstr: XMOVEI skipped");
	outop(P_XMOVEI);
	outreg(R_SCRREG);	/* simulate by XMOVEI into scratch */
	outaddress(p);		/* of desired address */
	outnl();
	outtab();
	outop(p->Pop);		/* followed by real instruction */
	outreg(p->Preg);	/* into desired reg */
	outnum(R_SCRREG);	/* from scratch reg */
	break;

    /* PTA_PCONST requires some special checks for immediate pointer
    ** operands, which are distinguished by the lack of a word address
    ** symbol (Pptr is NULL).
    ** These should only be seen for TDZ, TDO, and IOR.
    ** TDZ uses them to mask out the P+S fields of a ptr (converting to wd ptr)
    ** IOR uses them to generate a byte ptr from a word ptr.
    ** TDOx is sometimes seen due to conversion from an IOR.
    ** Not clear if anything else can ever have a null word address.
    */
    case PTA_PCONST:
	i = 0;
	if (p->Pptr == NULL) switch (p->Pop & POF_OPCODE) {
	    case P_TDZ: i = P_TDZ ^ P_TLZ; break;	/* Change TDZ to TLZ */
	    case P_TDO: i = P_TDO ^ P_TLO; break;	/* Change TDO to TLO */
	    case P_IOR:	i = P_IOR ^ P_TLO; break;	/* Change IOR to TLO */
	}
	if (i) {			/* If can use immediate form, */
	    outop(p->Pop ^ i);		/* change opcode and output it! */
	    outreg(p->Preg);
	    outpti(p->Pbsize, p->Poffset);	/* Output immediate P+S sym */
	} else {
	    outop(p->Pop);		/* Normal full-word pointer constant */
	    outreg(p->Preg);
	    outc('[');
	    outptr(p->Pptr, p->Pbsize, p->Poffset);
	    outc(']');
	}
	break;

    case PTA_BYTEPOINT:
	outop(p->Pop);
	outreg(p->Preg);
	outc('[');
	outnum(p->Pbsize);	/* Output P+S field */
	outstr(",,");
	outaddress(p);		/* Now add right half addr+offset(index) */
	outc(']');
	break;

    case PTA_RCONST:
	outop(opr = p->Pop);
	big = 1;		/* Assume full-word operand */
	if ((popflg[opr&POF_OPCODE]&PF_EIMM)	/* If op takes E as immed op */
	  || !(p->Ptype & PTF_IMM))		/* or optype not marked "imm"*/
	    big = 0;				/* then just output OP R,val */
	else {
	    /* Op is not an E-immediate type, but is marked as "immediate".
	    ** So either we generate an opI form,
	    ** or make the operand into a memory literal as in OP R,[val].
	    */
	    if ((popflg[opr&POF_OPCODE] & PF_OPI)	/* If op can be opI,*/
	      && (p->Pvalue &~ 0777777) == 0) {	/* and operand has zero LH, */
		outc('I');			/* make immediate op! */
		big = 0;			/* and say small operand */
	    }
	}
	outreg(p->Preg);		/* Output reg and comma */
	if (big) {
	    outc('[');
	    outnum(p->Pvalue);
	    outc(']');
	}
	else outnum(p->Pvalue);
	break;


    case PTA_FCONST:
	switch(p->Pop & POF_OPCODE) {
	    case P_FADR: case P_FSBR:	/* Single-precision operations */
	    case P_FMPR: case P_FDVR:	/* can be optimized sometimes */
	    case P_MOVS:
		big = bigfloat(p);	/* Set flag 0 if small */
		break;
	    case P_MOVE:		/* Check for quick setup of float */
		if (!(big = bigfloat(p)))
		    p->Pop = P_MOVS;	/* MOVE R,[flt] into MOVSI R,(flt) */
		break;
	    default:			/* Always big otherwise */
		big = 1;
		break;
	}
	outop(p->Pop);
	if (!big) outc('I');
	outreg(p->Preg);
	outc(big ? '[' : '(');
	outnum(*(int *)(&p->Pfloat));	/* Pass float as int val */
	outc(big ? ']' : ')');

	/* Add a readable comment so humans can understand what the floating
	 * constant is.  However, because this is slow, only do it when
	 * we know the assembler output is going to stay around.
	 */
	if(!delete)			/* If keeping asm file around, */
	    fprintf(out,"\t; %.20g",p->Pfloat);	/* add comment for humans */
	break;		

    case PTA_DCONST1:		/* Double-word floating constant */
    case PTA_DCONST2:
	i = ((p->Ptype)&PTF_ADRMODE) == PTA_DCONST1 ? 1 : 2;
	outop(p->Pop);
	outreg(p->Preg);
	outc('[');
	if (tgmachuse.mapdbl)		/* If target mach fmt is different */
	    outmpdbl((int *)&p->Pdouble, i); /* Output part of mapped double */
	else
	    outnum(i == 1 ? p->Pdouble1 : p->Pdouble2);
	outc(']');

	if(!delete)			/* If keeping asm file around, */
	    fprintf(out,"\t; %.20g", p->Pdouble); /* add comment for humans */
	break;

    case PTA_DCONST:		/* Double-word floating constant */
	outop(p->Pop);
	outreg(p->Preg);
	if (p->Pdouble == 0) {		/* Hack: if a double zero, */
	    outstr(crtsnam[CRT_ZERO]);	/* Use universal constant location. */
	    crtref[CRT_ZERO]++;
	} else if (tgmachuse.mapdbl) {	/* If target mach fmt is different */
	    outc('[');
	    outmpdbl((int *)&p->Pdouble, 3); /* Output mapped double */
	    outc(']');
	} else {
	    outc('[');
	    outnum(p->Pdouble1);
	    outnl(); outtab(); outtab();
	    outnum(p->Pdouble2);
	    outc(']');
	}
	if(!delete)			/* If keeping asm file around, */
	    fprintf(out,"\t; %.20g",p->Pdouble); /* add comment for humans */
	break;

    default:
	int_error("outinstr: bad adrmode %d", (p->Ptype & PTF_ADRMODE));
    }
    outnl();			/* Done with instruction, finish off! */
}

/* ONEINSTR(p) - See if an instruction is safe to skip over.
**
** Takes an instruction as argument and returns true if that
** instruction will expand to one machine code word.
** This routine is in CCOUT because it must accurately reflect what
** CCOUT will actually do for a given pseudo-instruction.
*/
int
oneinstr(p)
PCODE *p;
{
    switch (p->Pop & POF_OPCODE) {

    /* Simulated ops always expand out. */
    case P_PTRCNV:
    case P_SMOVE:
    case P_UIDIV:
    case P_UFLTR:
    case P_SUBBP:
    case P_DFIX:
    case P_UDFIX:
    case P_DSNGL:
	return 0;

    /* These instructions may or may not expand out, depending on the
    ** target machine.  If unsupported, they are actually macros defined
    ** by the assembler header.
    ** None of them have an "immediate" form, so PTV_IINDEXED can never happen.
    */
    case P_DMOVE: case P_DMOVN:	case P_DMOVEM:
	return tgmachuse.dmovx;		/* TRUE if machine has DMOVx */
    case P_ADJBP:
	return tgmachuse.adjbp;		/* TRUE if machine has ADJBP */
    case P_DFAD: case P_DFSB: case P_DFMP: case P_DFDV:
	return tgmachuse.dfl_h;		/* TRUE if machine has hardware dbls */
    case P_FLTR:
	return tgmachuse.fixflt;	/* TRUE if machine has hardware FLTR */

    case P_TRN: case P_TRO: case P_TRC: case P_TRZ:	/* RH tests */
    case P_TLN: case P_TLO: case P_TLC: case P_TLZ:	/* LH tests */
    case P_CAI:
    case P_LSH: case P_ASH:
	return (p->Ptype != PTA_MINDEXED);	/* PTV_IINDEXED for implicit immed op */

    /* All other (standard) instructions.
    ** If target machine may use extended addressing, any
    ** reference to immediate object addrs (immediate MINDEXED) will
    ** be turned into a XMOVEI plus a register op.
    */
    default:					/* OPI R,addr  expands to */
	return (p->Ptype != PTV_IINDEXED);	/* XMOVEI 16,addr ? OP r,16 */

    /* Special case of above, which always wins */
    case P_MOVE:
    case P_XMOVEI:
	return 1;			/* OK even for PTV_IINDEXED */

    }
}

static int
directop(op)
{
    switch (op & POF_OPCODE) {
    case P_CAI: return op ^ (P_CAI ^ P_CAM);
    case P_TRN: return op ^ (P_TRN ^ P_TDN);
    case P_TRO: return op ^ (P_TRO ^ P_TDO);
    case P_TRC: return op ^ (P_TRC ^ P_TDC);
    case P_TRZ: return op ^ (P_TRZ ^ P_TDZ);
    default: return 0;
    }
}

/* SIMUFLTR - Output expansion of P_UFLTR unsigned float "instruction".
**	UFLTR R,M
**		R = register to leave single-precision float in.
**		M = any memory reference to single-word integer operand
**
** Note that for machines without the FLTR instruction, we don't even
** bother to get things right since the usual substitute (FSC R,233) won't
** work.  Need a fancy KA-10 float routine.
**
** Expands into:
**	if R == M	if R != M
**	SKIPGE 16,M	SKIPGE R,M	; Fetch or copy the float
**	 LSH R,-1	 LSH R,-1	; If sign bit set, shift down
**	FLTR R,R	FLTR R,R	; Float the positive integer!
**	CAIGE 16,	SKIPGE M	; If number was shifted,
**	 FSC R,1	 FSC R,1	; adjust exponent accordingly.
*/
static void
simufltr(p)
PCODE *p;
{
    int r = p->Preg;
    int mr = ((p->Ptype&PTF_ADRMODE) == PTA_REGIS) ? p->Pr2 : 0;
    
    p->Pop = P_SKIP+POF_ISSKIP+POS_SKPGE;
    if (r == mr) p->Preg = R_SCRREG;	/* 16 */
    outinstr(p);			/* SKIPGE R,M or SKIPGE 16,R */
    fprintf(out,"\t LSH %o,-1\n", r);		/* LSH R,-1 */

    if (tgmachuse.fixflt)			/* If have hardware FLTR */
	fprintf(out,"\tFLTR %o,%o\n", r, r);	/* FLTR R,R */
    else
	fprintf(out,"\tFSC %o,233\n", r);	/* FSC R,233 (sigh) */

    if (r == mr)
	fprintf(out,"\tCAIGE %o,\n", R_SCRREG);	/* CAIGE 16, */
    else {					/* or */
	if (mr)
	    fprintf(out,"\tCAIGE %o,\n", R_SCRREG);	/* CAIGE R, */
	else {
	    outstr("\tSKIPGE ");			/* SKIPGE M */
	    outaddress(p);
	    outnl();
	}
    }
    fprintf(out,"\t FSC %o,1\n", r);		/* FSC R,1 */
}

/* SIMDFIX - Output expansion of P_DFIX/P_UDFIX double-to-integer
** conversion "instr"
**	P_DFIX reg,M or P_UDFIX reg,M
**		reg = register pair, integer will be left in 1st reg.
**		M = any memory ref to double-word float operand.
**
** Note that reg+1 is clobbered!
** Expands into:
**	DMOVE	R,M
**	HLRE	16,R		;This mattered when shifts were bit-at-a-time
**	ASH	16,-11		;Get just exponent (9 bits)
**	JUMPGE	16,.+3		;Positive?
**	  DMOVN	R,R		;No, negate, orig sign still in 1B0[A]
**				; For KA-10 format this is DFN R,R+1.
**	  TRC	16,777777	;Watch for diff between twos and ones comp
**	TLZ	R,777000	;Bash exponent and sign ... now positive
**				; For KA-10 format, LSH R+1,10 goes here.
**	ASHC	R,-233(16)	;Make an integer (may overflow)
**				;For unsigned, use:
**				;  ASHC R,-234(16)
**				;  LSH R+1,1
**				;  LSHC R,1
**	CAIGE	16,		;Original negative?  Check its sign.
**	 MOVN	R,R		;Yup, negate result.
*/
static void
simdfix(p,issigned)
PCODE *p;
int issigned;
{
    int r = p->Preg;

    /* Check for DFIX R,R and skip the DMOVE if that's what we have */
    if ((p->Ptype&PTF_ADRMODE) != PTA_REGIS || r != p->Pr2) {
	p->Pop = P_DMOVE;		/* Make DMOVE R,M to get double */
	outinstr(p);
    }
    fprintf(out, "\tHLRE 16,%o\n\tASH 16,-11\n\tJUMPGE 16,.+3\n", r);

    if (tgmachuse.dfl_s)		/* Use right kind of double negation */
	fprintf(out, "\tDFN %o,%o\n", r, r+1);
    else fprintf(out, "\tDMOVN %o,%o\n", r, r);
    outstr("\tTRC 16,-1\n");

    fprintf(out, "\tTLZ %o,777000\n", r);
    if (tgmachuse.dfl_s)		/* Account for exponent in 2nd wd */
	fprintf(out, "\tLSH %o,10\n", r+1);
    if (issigned)		/* For signed, ASHC catches overflow */
      fprintf(out, "\tASHC %o,-233(16)\n", r);
    else {			/* For unsigned, ASHC catches overflow */
      fprintf(out, "\tASHC %o,-234(16)\n", r);
      fprintf(out, "\tLSH %o,1\n", r+1);/* Move LSB to left of R+1 */
      fprintf(out, "\tLSHC %o,1\n", r);	/* This finishes shift */
    }
    outstr("\tCAIGE 16,\n");		/* Check sign bit of original # */
    fprintf(out, "\t MOVNS %o\n", r);	/* Negate result */
}

/* SIMDSNGL - Output expansion of P_DSNGL double-to-float conversion "instr"
**	P_DSNGL reg,M
**		reg = register pair, float will be left in 1st reg.
**		M = any memory ref to double-word float operand.
**
** Note that reg+1 is clobbered!
** Expands into:
**	DMOVE R,M		; Get double value
**	SKIPGE 16,R		; Check sign, save indicator
**	 DMOVN R,R		; Negative, make positive temporarily.
**	TLNE R+1,200000		; If low word >= .5
**	 TRON R,1		; then must round high wd, try fast hack
**	  JRST .+4		; Won!
**	   MOVE R+1,R		; Ugh, have to do it hard way.  Copy high wd
**	   AND R+1,[777000000001]	; Zap all but exp and low-order bit
**	   FADR R,R+1		; Add low bit to effect rounding
**	CAIGE 16,		; Now if original was negative,
**	 MOVN R,R		; make it negative again.
*/
static void
simdsngl(p)
PCODE *p;
{
    int r = p->Preg;
    /* Check for DSNGL R,R and skip the DMOVE if that's what we have */
    if ((p->Ptype&PTF_ADRMODE) != PTA_REGIS || r != p->Pr2) {
	p->Pop = P_DMOVE;		/* Make DMOVE R,M to get double */
	outinstr(p);
    }
    fprintf(out, "\tSKIPGE 16,%o\n", r);

    if (tgmachuse.dfl_s) {		/* Use right kind of double negation */
	fprintf(out, "\t DFN %o,%o\n", r, r+1);
	fprintf(out, "\tTLNE %o,400\n", r+1);
    } else {
	fprintf(out, "\t DMOVN %o,%o\n", r, r);
	fprintf(out, "\tTLNE %o,200000\n", r+1);
    }
    fprintf(out, "\t TRON %o,1\n\t  JRST .+4\n", r);
    fprintf(out, "\tMOVE %o,%o\n\tAND %o,[777000,,1]\n\tFADR %o,%o\n",
		r+1, r,
		r+1,
		r, r+1);

    outstr("\tCAIGE 16,\n");		/* Check sign bit of original # */
    fprintf(out, "\t MOVNS %o\n", r);	/* Negate result */
}

/* SIMSUBBP - Output expansion of P_SUBBP byte-pointer subtraction "instr".
**	P_SUBBP reg,M		[plus Pbsize set to bytesize if known]
**		reg = register pair, 1st reg contains minuend BP
**		M = any memory ref to subtrahend BP
**		Pbsize = bytesize of pointers (> 0 if known)
**			This is currently only used if M operand is P_CONST.
**	Leaves resulting # in 2nd reg!
**
**	This makes use of 2 special symbols from CPU.C and
** some tables in CRT.C, and expands into:
**	Known size		Unknown size
**				LDB 16,[$$BPSZ,,R]	; get PS from R
**	SUB R,M			SUB R,M
**	MULI R,$$BMPn		MUL R,$BPMUL(16)
**	ASH R+1,$$BSHF		ASH R+1,$$BSHF
**				ADD R,$BPADT(16)
**	ADD R+1,$BPADn(A)	ADD R+1,(A)
*/
static void
simsubbp(p)
PCODE *p;
{
    int siz, typ, tbidx;

    if ((typ = (p->Ptype&PTF_ADRMODE)) == PTA_PCONST)
	    siz = p->Pbsize;		/* Aha, size is known! */
    else siz = 0;

    switch (siz) {
	case 6:	tbidx = 0; break;
	case 7:	tbidx = 1; break;
	case 8: tbidx = 2; break;
	case 9: tbidx = 3; break;
	case 18: tbidx = 4; break;
	default:
	    int_error("simsubbp: bad Pbsize: %d", siz);
	    siz = 0;
	case 0:
	    fprintf(out, "\tLDB 16,[%s,,%o]\n", crtsnam[CRT_BPSZ], p->Preg);
	    crtref[CRT_BPSZ]++;
    }

    /* Simple check to verify addressing mode is OK */
    switch (typ) {
	case PTA_PCONST:
	case PTA_REGIS:
	case PTA_MINDEXED:
	    break;
	default:
	    int_error("simsubbp: bad adrmode: %d", typ);
    }
    p->Pop = P_SUB;			/* Make SUB R,M */
    outinstr(p);

    if (siz) {
	fprintf(out, "\tMULI %o,%s\n", p->Preg, crtsnam[CRT_BMP6+tbidx]);
	crtref[CRT_BMP6+tbidx]++;
    } else {
	fprintf(out, "\tMUL %o,%s(16)\n", p->Preg, crtsnam[CRT_BPMUL]);
	crtref[CRT_BPMUL]++;
    }
    fprintf(out, "\tASH %o,-%s\n", p->Preg+1, crtsnam[CRT_BSHF]);
    crtref[CRT_BSHF]++;
    if (!siz) {
	fprintf(out, "\tADD %o,%s(16)\n", p->Preg, crtsnam[CRT_BPADT]);
	crtref[CRT_BPADT]++;
	fprintf(out, "\tADD %o,(%o)\n", p->Preg+1, p->Preg);
    } else {
	fprintf(out, "\tADD %o,%s(%o)\n",
		p->Preg+1, crtsnam[CRT_BPAD6+tbidx], p->Preg);
	crtref[CRT_BPAD6+tbidx]++;
    }
}

/*
** NOTE:
** Byte pointer comparison used to be simulated too but now is done
** with explicit instructions by CCGEN2.
*/
/* NOTE:
** Some PDP-10 architecture machines have no ADJBP instruction.
** We used to expand a sequence for P_ADJBP similar to that for
** P_SUBBP, but now we always just output P_ADJBP
** as ADJBP R,X and it is up to the C-HDR preamble file to redefine
** ADJBP as a macro (in a form similar to the above) if the machine
** does not support ADJBP.  This allows machine-language library routines
** to use ADJBP in their code.
*/

/* SIMPTRCNV - Output expansion of P_PTRCNV pointer conversion "instruction".
**	P_PTRCNV reg,offset	[plus Pbsize set to desired bytesize]
**		reg = register containing pointer to convert
**		offset = bytesize of old pointer
**		Pbsize = desired bytesize of new pointer
**
**	Currently this only supports 9<->18 bit conversions, and the
** code generator shouldn't give us anything else.
** The interaction between the special instruction symbols defined in the
** library $$$CPU module and the code here has been carefully arranged.
** In particular the instructions must take up the same amount of space
** whether being loaded for zero-section or multi-section operation, and
** they must NOT change the value of a NULL (zero) pointer.
**
** The conversions to and from word pointers are done by the code
** generator (with TDZ/TLZ or SKIPE+IOR/TLO) because it may be possible
** for the peephole optimizer to do something with those instructions.
*/
static void
simptrcnv(p)
PCODE *p;
{
    int *ip;
    static int cvH_9[] = {CRT_PH90, CRT_PH91, 0};
    static int cv9_H[] = {CRT_P9H0, CRT_P9H1, CRT_P9H2, 0};

    /* Switch depending on original size plus desired size */
    switch (TGSIZ_WORD* p->Poffset + p->Pbsize) {
	case TGSIZ_WORD* 9 + 18:	/* 9-bit to 18-bit */
	    if (!tgmachuse.exadr) {	/* Coding for local-section only? */
		fprintf(out, "\tTLZE %o,117700\n", p->Preg);
		fprintf(out, "\t TLO %o,002200\n", p->Preg);
		return;
	    }
	    fprintf(out,"\tJUMPE %o,.+4\n", p->Preg);	/* Skip if ptr NULL */
	    ip = cv9_H;
	    break;

	case TGSIZ_WORD* 18 + 9:	/* 18-bit to 9-bit */
	    if (!tgmachuse.exadr) {	/* Coding for local-section only? */
		fprintf(out, "\tTLZE %o,007700\n", p->Preg);
		fprintf(out, "\t TLO %o,111100\n", p->Preg);
		return;
	    }
	    ip = cvH_9;
	    break;
	default:
	    int_error("simptrcnv: bad bsize: %d", p->Pbsize);
	    return;
    }

    /* Wrap up with special instructions the value of which depends
    ** on whether the code is being loaded for a zero-section or
    ** multi-section program.  The specified register is added into
    ** the symbols in such a way that it fits into the AC field.
    */
    for (; *ip; ++ip) {
	fprintf(out,"\t%s+<%o>\n", crtsnam[*ip], p->Preg<<23);
	++crtref[*ip];
    }
}

/* SIMSMOVE - Output expansion of P_SMOVE structure copy "instruction".
**	P_SMOVE reg,addr+offset(idx)  [plus Pbsize set to # words]
**		reg = register containing destination word address
**		addr+offset(idx) = source address
**		Pbsize = # words to copy
*/
static void
simsmove(p)
PCODE *p;
{
    int size;

    if ((p->Ptype&PTF_ADRMODE) != PTA_MINDEXED) {
	int_error("simsmove: bad adrmode: %o", p->Ptype);
	return;
    }
    switch (size = p->Pbsize) {
    case 1: case 2: case 3:
	fprintf(out,"\tXMOVEI 16,-1(%o)\n", p->Preg);	/* Get dest <addr-1> */
	while (--size >= 0) {
	    outstr("\tPUSH 16,");
	    outaddress(p);
	    outnl();
	    ++(p->Poffset);
	}
	return;

    default:
	if (size <= 0) {
	    int_error("simsmove: bad size %d", size);
	    return;
	}

	/* Code to do local-section BLT */
	if (tgmachuse.exadr)	/* If mach has ext addressing */
	    outstr("\tJUMPGE 17,.+5\n");	/* Must check at runtime. */
	fprintf(out,"\tMOVEI 16,(%o)\n\tHRLI 16,",p->Preg);
	outaddress(p);		/* for HRLI 16,<source-addr> */
	fprintf(out,"\n\tBLT 16,%o(%o)\n", size-1, p->Preg);
		
	/* Code to do global-section XBLT */
	if (!tgmachuse.exadr)	/* If mach doesn't have ext addressing */
	    return;		/* then that's all! */

	/* There is so much setup overhead that we check the size and
	** use PUSHes if there are less than 10 words, which seems to
	** be the breakeven point (paper calculation).
	*/
	if (size < 10) {
	    fprintf(out,"\tJRST .+%o\n", size+2);
	    fprintf(out,"\tXMOVEI 16,-1(%o)\n", p->Preg); /* dest <addr-1> */
	    while (--size >= 0) {
		outstr("\tPUSH 16,");
		outaddress(p);
		outnl();
		++(p->Poffset);
	    }
	    return;
	}
	/* Too big for cleverness, just spit out the XBLT code */
	fprintf(out,"\tJRST .+11\n\tPUSH 17,14\n\tPUSH 17,15\n");
	if (p->Pindex == R_SP)	/* Must adjust stack reference? */
	    p->Poffset -= 2;	/* Yeah, account for our 2 PUSHes */
	if (size <= 0777777)
	    fprintf(out,"\tMOVEI 14,%o\n", size);
	else fprintf(out,"\tMOVE 14,[%o]\n", size);
	outstr("\tXMOVEI 15,"); outaddress(p);
	fprintf(out,"\n\tMOVE 16,%o\n\tEXTEND 14,[XBLT]\n", p->Preg);
	outstr("\tPOP 17,15\n\tPOP 17,14\n");
    }
}

/* SIMUIDIV - Output expansion of P_UIDIV unsigned division "instruction".
**	P_UIDIV reg,<addr>
**		reg = register containing dividend (two-word register)
**		addr = divisor
** This sequence was derived from one suggested by Peter Samson
** at Systems Concepts.
*/
static void
simuidiv(p)
PCODE *p;
{
    register int rq = p->Preg;		/* RQ - Quotient register */
    register int rr = rq+1;		/* RR - Remainder register, RQ+1 */
    register int divisor;

    /* First, try to use optimized sequences if the divisor is a constant. */
    if ((p->Ptype&PTF_ADRMODE) == PTA_RCONST) {
	divisor = p->Pvalue;
	if (divisor == 1 || divisor == 0) {	/* Div by 1 (or 0??) */
	    fprintf(out,"\tSETZ %o,\n", rr);	/* just clears rem */
	    return;
	}
	if ((divisor & (divisor-1)) == 0) {	/* If divisor is power of 2 */
	    fprintf(out,"\tLSHC %o,-%o\n", rq, binexp(divisor));
	    fprintf(out,"\tLSH %o,-%o\n",rr, (TGSIZ_WORD - binexp(divisor)));
	    return;
	}
	if (divisor > 0) {		/* High bit not set? */
	    fprintf(out, "\tSKIPL %o,%o\n", rr, rq);
	    fprintf(out, "\t TDZA %o,%o\n", rq, rq);
	    fprintf(out, "\t  MOVEI %o,1\n", rq);
	    if (!(p->Pvalue & ~0777777))	/* Constant fits in RH? */
		fprintf(out, "\tDIVI %o,%o\n", rq, divisor);
	    else fprintf(out, "\tDIV %o,[%o]\n", rq, divisor);
	    return;
	}
	/* Constant divisor has high bit set, ugh!
	** This case is pretty unlikely so don't bother optimizing it.
	** Just drop through to general-purpose division algorithm.
	*/
	p->Ptype |= PTF_IMM;		/* Ensure outinstr checks bigness */
    }

    /* Sigh, cannot avoid doing full-fledged hairy unsigned division.
    ** Output entire algorithm -- see following comments for more explanation.
    ** Note that divisor is fetched into reg 16 immediately to avoid any
    ** addressing conflicts with regs RQ or RQ+1.  We temporarily set
    ** Preg to this scratch reg so that we can take advantage of outinstr()
    ** and have it use the right register.
    */
    p->Pop = P_SKIP+POF_ISSKIP+POS_SKPGE;	/* Modify instr to fake out */
    p->Preg = R_SCRREG;				/*       call to outinstr() */
    outinstr(p);				/* SKIPGE 16,MEM Get divisor */
    outstr(     "\t JRST .+10\n");		/*  JRST $1 if divisor neg */
    fprintf(out,"\tJUMPGE %o,.+17\n", rq);	/* JUMPGE RQ,$3 Both +? Win! */


    /* Divisor is positive, but dividend isn't.
    ** Must check for special case of 1, which leaves high-order (sign) bit
    ** still set!  (All other values zero it).  Might as well include 0 here.
    */
    fprintf(out,"\tCAIG %o,1\n", R_SCRREG);	/* CAIG 16,1 Check divisor */
    outstr(     "\t JRST .+14\n");		/*  JRST $2 if 0 or 1 */

    /* Dividend is neg (has high bit set), divisor doesn't.
    ** We know that divisor is at least 2 so the quotient will always
    ** lose at least 1 high bit and thus we can win by doing a DIV without
    ** any fixup.  The DIV is needed rather than IDIV because we have to
    ** divide a 2-word value; the high bit becomes the low bit of the
    ** high-order word.
    */
    fprintf(out,"\tMOVE %o,%o\n", rr, rq);	/* MOVE RR,RQ Set up */
    fprintf(out,"\tMOVEI %o,1\n", rq);		/* MOVEI RQ,1 Get 1 ? dvdend */
    fprintf(out,"\tDIV %o,%o\n", rq, R_SCRREG);	/* DIV RQ,16    Do the div! */
    outstr(     "\tJRST .+12\n");		/* JRST $4	Done! */

/* Label $1: Divisor is negative (high bit is set) */
    /* Because divisor's high bit is set, there's no way the dividend
    ** can be more than twice the magnitude of the divisor.  So the
    ** quotient must be either 0 or 1, with the remainder being respectively
    ** either the dividend or the dividend less 1 times the divisor.
    */
    fprintf(out,"\tMOVE %o,%o\n", rr, rq);	/* MOVE RR,RQ	Make dblwd */
    fprintf(out,"\tMOVEI %o,0\n", rq);		/* MOVEI RQ,0 with high wd 0 */
    fprintf(out,"\tJUMPGE %o,.+7\n", rr);	/* JUMPGE RR,$4 Maybe done */
    fprintf(out,"\tCAMGE %o,%o\n",rr,R_SCRREG);	/* CAMGE RR,16 */
    fprintf(out,"\t JRST .+5\n");		/*  JRST $4 */
    fprintf(out,"\tSUB %o,%o\n", rr, R_SCRREG); /* SUB RR,16 */
    fprintf(out,"\tAOJA %o,.+3\n", rq);		/* AOJA RQ,$4 */

/* Label $2: Divisor is 0 or 1, dividend is neg */
    fprintf(out,"\tTDZA %o,%o\n", rr, rr);	/* TDZA RR,RR  Clear rem */
						/*	and skip next instr */
/* Label $3: Divisor and dividend both positive */
    fprintf(out,"\t IDIV %o,%o\n",rq,R_SCRREG);	/* IDIV RQ,16 */
/* Label $4: Done! */

}

/* OUTOP - Emit opcode and condition-test fields
**
*/
static void
outop(opr)
{
    if (opr == 0) int_error("outop: null op");
    outstr(popostr[opr & POF_OPCODE]);	/* Output assembler opcode mnemonic */

    switch (opr & POF_OPSKIP) {
    case POS_SKPA: outc('A'); break;
    case POS_SKPE: outc('E'); break;
    case POS_SKPN: outc('N'); break;
    case POS_SKPL: outc('L'); break;
    case POS_SKPG: outc('G'); break;
    case POS_SKPLE: outstr("LE"); break;
    case POS_SKPGE: outstr("GE"); break;
    }

    if (opr & POF_BOTH) switch (opr) {
    case P_MOVN+POF_BOTH:
    case P_MOVM+POF_BOTH: outc('S'); break;
    default: outc('B'); break;
    }
}

/* OUTREG - Output register field
*/
static void
outreg(n)
{
    outc(' ');			/* Separate from opcode with space */
    if (n > 0) {
	outnum(n);
	outc(',');
    }
}

/* OUTADDRESS - Output address (E) field
*/
static void
outaddress(p)
PCODE *p;
{
    if (p->Ptype & PTF_IND) outc('@');	/* if indirect, say so with atsign */

    if (p->Pptr != NULL) {		/* now right half: */
	outmiref(p->Pptr);		/* symbol */
	if (p->Poffset) {		/* with offset */
	    /* Do trick here of multiplying by 1.  This is only needed for
	    ** FAIL to force it into making Polish, to avoid wrong-seg
	    ** relocation bug (see FAIL manual doc for the TWOSEG pseudo).
	    ** MACRO and MIDAS aren't bothered by it.
	    */
	    if (tgasm == TGASM_FAIL)
		outstr("*1");		/* Hack hack */
	    if (p->Poffset > 0) outc ('+');
	    outnum(p->Poffset);
	}
    } else outnum(p->Poffset);		/* no sym, just give offset */

    if (p->Pindex) {			/* now output index register */
	if (p->Pindex == R_SP		/* Simple check - if stack index */
	  && p->Poffset > 0		/* ensure it points to valid stuff */
	  && (p->Ptype&PTF_IMM)==0)	/* or if not, that we only want addr */
					/* Else making bad stack reference! */
	    int_error("outaddress: + stk offset");
	outc('(');
	outnum(p->Pindex);
	outc(')');
    }
}

/* OUTPTI - output immediate pointer operand.
**	This is used for TLZ and TLO.
**	We already know that the instruction's operand is a PTA_PCONST
** with no symbol, so the RH is zero and only the LH is needed.
** Note $$SECT should not be used as we are masking BP position bits rather
** than address bits.  Error if byte offset is so large that a word offset
** becomes necessary.
*/
static void
outpti(bsize, offset)
int bsize;		/* Bytesize of pointer (0 for word ptr is illegal) */
int offset;		/* # bytes offset from start of word */
{
    int i, woff = 0;

    if ((i = obplh(offset, &woff, bsize)) == 0
      || woff) {
	int_error("outpti: bad args");
	i = CRT_BPPS;
    }
    outstr(crtsnam[i]);		/* Output byte pointer bits */
    ++crtref[i];
}

/* OUTPTR - output pointer value, for word or byte pointer.
**	sym - address identifier (if non-NULL)
**	offset - offset in bytes from given address
**	bsize - size of bytes in bits.
**		0 = word pointer, no P+S in left half.
** If the address identifier is NULL, no $$SECT is output for the LH.
** This could be used to create absolute pointers.
*/
void
outptr(sym, bsize, offset)
SYMBOL *sym;		/* Identifier to point at */
int bsize;		/* Bytesize of pointer (0 = word) */
int offset;		/* # units offset from identifier */
{
    register int i = 0;

    if (bsize && (i = obplh(offset, &offset, bsize))) {
	outstr(crtsnam[i]);		/* Output byte pointer bits */
	++crtref[i];
    }

    /* Now do rest of pointer (the word address) */
    if (sym) {
	if (i) outstr("+");		/* Combine with P+S if any */
	outstr(crtsnam[CRT_SECT]);	/* Make global word address */
	++crtref[CRT_SECT];
    }
    outstr(",,");
    if (sym) {
	outmiref(sym);		/* Either internal static, or normal extern */
    } else outstr("0");
    if (offset) {		/* If non-zero word offset, */
	outstr("*1");		/* See outaddress() for crock explanation */
	if (offset > 0) outc('+');	/* Add or subtract it */
	outnum(offset);		/* note outnum prefixes '-' if negative */
    }	
}

/* OBPLH - Find BP left-half value
**	If bsize = -1, use P+S mask.  This is meaningless for most all
** ops except P_TDZ or P_TLZ, however.
*/
static int
obplh(boff, awoff, bsize)
int boff;	/* Byte offset */
int *awoff;	/* Addr of place to return word-offset to */
int bsize;	/* Byte size (0 if word) */
{
    switch (bsize) {
	default:
	    int_error("obplh: bad bsize: %d", bsize);
	case -1:		/* Return P+S mask */
	    return CRT_BPPS;
	case 0:			/* Word pointer */
	    return 0;
	case 6:
	    return CRT_BP60 + adjboffset(boff, awoff, 6);
	case 7:
	    return CRT_BP70 + adjboffset(boff, awoff, 5);
	case 8:
	    return CRT_BP80 + adjboffset(boff, awoff, 4);
	case 9:
	    return CRT_BP90 + adjboffset(boff, awoff, 4);
	case 18:
	    return CRT_BPH0 + adjboffset(boff, awoff, 2);
    }
}


/* ADJBOFFSET - Adjust byte offset.  Auxiliary for obplh() and foldadjbp().
*/
int
adjboffset(boff, awoff, bpw)
int boff;			/* Byte offset to adjust */
int *awoff;			/* Place to deposit word offset */
int bpw;			/* # bytes per word */
{
    if (boff < 0) {
	/* Negative increment, need to go back far enough
	** that boff can become a positive offset within a word.
	*/
	*awoff = -((-boff) / bpw);	/* Find -# words */
	if (boff = (-boff) % bpw) {	/* If any bytes, */
	    (*awoff)--;			/* must bump back 1 more word */
	    return bpw - boff;		/* and return positive offset. */
	} else return 0;
    } else {		/* Positive increment, simple. */
	*awoff = boff / bpw;		/* Find # words */
	return boff %= bpw;		/* and remaining # bytes */
    }
}

/* Floating-point auxiliary functions */

/* OUTFLT - Output floating-point constant value.
**	Handles float, double, long double.
**	If no flags given, assumes outputting all of value as a static data
**	constant (used by CCGEN), else a code literal constant.
**	Returns the number of words emitted.
*/
#define OF_CONST 0100	/* Code literal constant */
#define OF_WD1 01	/* Emit word 1 only */
#define OF_WD2 02	/* Emit word 2 only */

int
outflt(typ, ptr, flags)
int typ;			/* Tspec of value */
int *ptr;			/* Generic pointer to object */
int flags;
{
    if (!flags) flags = OF_WD1|OF_WD2;
    if (flags & OF_CONST)
	outc('[');		/* Set up as literal constant ] */
    else outtab();
    if (typ == TS_FLOAT) {
	outpnum(*ptr);
	typ = 1;
    } else if (tgmachuse.mapdbl) {	/* If target mach fmt is different */
	outmpdbl(ptr, 3);		/* output mapped double */
	typ = 2;
    } else {
	outpnum(ptr[0]);
	outnl();
	outtab();
	if (flags & OF_CONST)
	    outtab();
	outpnum(ptr[1]);
	typ = 2;
    }
    if (flags & OF_CONST)
	outc(']');

    /* Add a readable comment so humans can understand what the floating
    ** constant is.  However, because this is slow, only do it when
    ** we know the assembler output is going to stay around.
    */
    if (!delete)		/* If keeping asm file around, add comment */
	fprintf(out, "\t; %.20g", *(double *)ptr);
    if (!(flags & OF_CONST))
	outnl();
    return typ;		/* Return # wds emitted */
}


/* OUTMPDBL - Output mapped double-format constant
**	This is also used by CCGEN for data.
*/
void
outmpdbl(ip, which)
int *ip;
int which;		/* 1 = 1st wd, 2 = 2nd wd, 3 = both wds */
{
    int second;		/* 2nd word is the different one */
    int exp;		/* Gotta derive new exponent */

    if (second = ip[1])	/* Only if low order word is non-zero */
	switch (tgmachuse.mapdbl) {
    case 1:	/* Internal format is hardware, output in software format */
	exp = (*ip < 0 ? -*ip : *ip) & ~((1<<27)-1);	/* Mask off pos exp */
	second = (((unsigned)second) >> 8) | (exp - (27<<27));
	break;
    case -1:	/* Internal format is software, output in hardware format */
	second = (second << 8) & ~(1<<35);	/* Just flush 2nd exp! */
	break;
    default:
	int_error("outmpdbl: bad map");
    }
    if (which&01) outpnum(*ip);		/* 1st wd always output as is */
    if (which==03) outstr("\n\t\t");
    if (which&02) outpnum(second);	/* 2nd word has been mapped */
}

/* BINEXP - count zero bits to right of rightmost 1 in word.
**	Used for converting a power-of-2 value into a shift count.
**	Also called by CCEVAL for constant folding.
*/
int
binexp(n)
unsigned int n;
{
    int e;

    e = -1;				/* init count of bits to shift */
    do {
	n >>= 1;			/* logical shift over one */
	e++;				/* and count a zero */
    } while (n != 0);			/* until that was the last bit */
    return e;				/* return number of bits */
}

/* FLTPOW2(d) - See if arg is positive and a power of 2
 *	Returns zero if not, else non-zero integer exponent.
 * Very machine-dependent, only works for standard single-precision
 * PDP-10 floating point format, and assumes a normalized number.
 *	If the number is a power of 2, only bit 9 will be set in
 * the mantissa (the rest will be 0) and the exponent field (bits 1-8)
 * can tell us what we want to know - it is in excess 128 code, so
 * that an exponent X for the fractional mantissa is represented by X+128.  
 * Subtracting 129 then gives us the power of 2 for the integer.
 *	Minor screw: 1.0 (2 to the 0th) returns 0 which is the same as
 * an error return.  However, the two cases of using 0.0 or 1.0 as operand
 * should have been caught earlier in optimization.
 */
static int
fltpow2(d)
double d;
{
    if (d > 0.0 && ((*(int *)(&d)) & 03777777777) == 0)
	return ((unsigned)(*(int *)(&d)) >> 27) - 129;
    return 0;
}

/* BIGFLOAT - See whether 1st word of a floating-point number is too big
**	to fit into a halfword (i.e. RH has some non-zero bits).  
**	Note this only checks floats, not doubles!
*/
static int
bigfloat(p)
PCODE *p;
{
    return(((*(int *)(&p->Pfloat))
		 & 0777777) != 0); 	/* If 1st wd RH has bits, big. */
}

/* OUTSCON - Output string constant.
**	Used to always produce an ASCIZ string, but now uses
** whatever bytesize is specified.
** The major hack to be noted here is that 6-bit characters are
** converted to PDP-10 SIXBIT!
*/
void
outscon(s, l, bsiz)
char *s;		/* Char string */
int l;			/* Length (may include nulls!) */
int bsiz;		/* Byte size to use. */
{
    int i, sepchar = ',';
    char *opstr = "BYTE\t(%d) ";

    if (tgasm == TGASM_MIDAS)
	sepchar = '?', opstr = ".BYTE %d ? ";

    --s;			/* Set up for preincrement */
    while (l > 0) {			/* For each word */
	fprintf(out, opstr, bsiz);	/* Start bytes of given size */
	for (i = (TGSIZ_WORD/bsiz);;) {
	    if (bsiz == 6) outnum(*++s ? (toupper(*s)-040) : 0);
	    else outnum(*++s);		/* output char value */
	    if (--l <= 0) break;
	    if (--i <= 0) break;
	    outc(sepchar);
	}
	outstr("\n\t");
    }
    if (tgasm == TGASM_MIDAS) outstr(" ? .BYTE");
    outnl();
}

/* OUTLAB - Output label
**	Note: the ==. syntax is used for local labels (without linkage)
** because that is
** acceptable to all of FAIL, MACRO, and MIDAS.  The "proper" half-killed label
** syntax for MACRO is "foo:!", but it is "foo::" for the others.
** We cleverly avoid the issue with ==.
*/
void
outlab(s)
SYMBOL *s;
{
    outid(s->Sname);		/* Output the actual label name */
    if (s->Sname[0] == '$')	/* Local label? */
	outstr("==.\n");	/* Yes, define it as half-killed.  See note. */
    else outstr(":\n");		/* No, normal label. */
}

/* OUTID - Output identifier to assembler file
**	Does minor mapping.
*/
void
outid(s)
char *s;
{
    register int n, ch;

    n = 6;				/* Max # chars to output */
    if ((ch = *s) == SPC_IDQUOT)	/* Handle quoted identifier syms */
	ch = *++s;
    while (ch) {
	if (ch == '_') ch = '.';
	if (putc(ch, out) == EOF) errio("writing assembler", outfname);
	if (--n <= 0) break;
	ch = *++s;
    }
}

#if SYS_CSI
/* OUTPROLOG - Output Profiler call from Function Prolog
**	       added 09/15/89 by MVS
*/

void
outprolog(s)
SYMBOL *s;
{
    if (fputs("\tPROF.\t0,", out) == EOF) errio("writing assembler", outfname);
    outmiref(s);
}

/* OUTEPILOG - Output Profiler call from Function Epilog
**	       added 09/15/89 by MVS
*/

void
outepilog(s)
SYMBOL *s;
{
    if (fputs("\tPROF.\t1,", out) == EOF) errio("writing assembler", outfname);
    outmiref(s);
    if (putc('\n', out) == EOF) errio("writing assembler", outfname);
}
#endif

/* OUTMIDEF - Output Mapped Identifier Definition
*/
void
outmidef(s)
SYMBOL *s;
{
    outmiref(s);
    if (putc(':', out) == EOF) errio("writing assembler", outfname);
}

/* OUTMIREF - Output Mapped Identifier Reference
*/
void
outmiref(s)
SYMBOL *s;
{
    switch (s->Sclass) {
    case SC_ISTATIC:	outid(s->Ssym->Sname); break;
    case SC_LABEL: case SC_ULABEL: case SC_ILABEL:
			outid(s->Sname); break;
    default:	
	if (s->Smaplab) outsix(s->Smaplab);	/* Output SIXBIT */
	else int_error("outmiref: no map for \"%s\"", s->Sname);
    }
}

/* Low-level assembler file output functions */

/* OUTSTR - Output string
*/
void
outstr(s)
char *s;
{
    if (*s) {
	do if (putc(*s, out) == EOF) errio("writing assembler", outfname);
	while (*++s);
    }
}

/* OUTC - Output character
** OUTNL - Output NewLine
** OUTTAB - Output Tab
*/
void outc(c) {	if (putc(c, out) == EOF) errio("writing assembler", outfname); }
void outnl() {	if (putc('\n', out) == EOF) errio("writing assembler", outfname); }
void outtab(){	if (putc('\t', out) == EOF) errio("writing assembler", outfname); }

/* OUTNUM - Output value as a signed octal number (with minus sign if negative)
*/
void
outnum(n)
{
    if (n < 0) {
	n = -n;
	if (putc('-', out) == EOF) errio("writing assembler", outfname);
    }
    if (n &~ 07) outpnum((unsigned) n >> 3);
    if (putc((n & 07) + '0', out) == EOF) errio("writing assembler", outfname);
}

/* OUTPNUM - Output value as a positive unsigned octal number
*/
void
outpnum(n)
unsigned n;
{
    if (n &~ 07) outpnum(n >> 3);
    if (putc((n & 07) + '0', out) == EOF) errio("writing assembler", outfname);
}

/* OUTSIX - Output SIXBIT word, ignoring trailing blanks
*/
void
outsix(wd)
unsigned wd;
{
    while (!(wd & 077)) wd >>= 6;	/* Right-justify the sixbit */
    outrj6(wd);
}

static void
outrj6(ms)
unsigned ms;
{
    int ch6;
    ch6 = (ms&077) + ' ';
    if (ms >>= 6) outrj6(ms);
    if (putc(ch6, out) == EOF) errio("writing assembler", outfname);
}
