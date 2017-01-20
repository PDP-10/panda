/*	CC.H - Declarations for KCC data structures
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.199, 16-Apr-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.84, 8-Aug-1985
**
** Original version merged with cc.s / David Eppstein / 13 Mar 85
*/

/* Note: EXT must be used to declare anything which is not explicitly declared
 * in CCDATA.  All others are "extern".
 */

#ifndef EXT
#define EXT extern
#endif

#include <stdio.h>
#include "ccparm.h"	/* First come the various KCC parameters */
#include "ccsym.h"	/* SYMBOL and TYPE definitions */
#include "ccnode.h"	/* NODE definitions */
#include "ccerr.h"	/* Error reporting routine declarations */

typedef char filename[FNAMESIZE];

extern int cvercode, cverlib;	/* $$CVER version numbers (no switches) */
extern int cverdist, cverkcc;	/* Info-only version numbers (no switches) */

/* KCC switch flags.  These are set when KCC is first invoked and remain
**	constant over all files processed.
*/

/* Simple switches and flags */
EXT int
    assemble,			/*      1 Assemble after compile */
				/*	  (set/cleared by other switches) */
    delete,			/*      1 Delete assembler file when done */
				/* -S = 0 Don't (don't run anything either) */
    link,			/*      1 run link after assembling */
				/* -c = 0 Compile only, don't run link */
    condccf,			/* -q = 1 Compile files conditionally */
    prepf,			/* -E = 1 Run through preprocessor only */
    keepcmts;			/* -C = 1 For -E, leave comments in output */
#if SYS_CSI
EXT int profbliss;		/* -p = 1 Include BLISS profiling stuff */
#endif

/* String switches */
extern char *asmhfile;		/* -Afile = name of assembler preamble file */
extern char *asmtfile;		/* -afile = name of #asm temporary file */
extern int
	npredef,		/* -Dmac=d # of -D macro predefinitions */
	npreundef,		/* -Umac   # of -U macro pre-undefinitions */
	nincpaths,		/* -Ipath  # of "" include-file directories */
	nhfpaths,		/* -Hpath  # of <> include-file dirs */
	nhfsypaths,		/* -hpath  # of <sys/> include-file dirs */
	nihfpaths,		/* # of default -H and -h paths */
	nihfsypaths;
extern char *predefs[];		/*	Pointers to -D args */
extern char *preundefs[];	/*	Pointers to -U args */
extern char *incpaths[];	/*	Pointers to -I args */
extern char *hfpaths[];		/*	Pointers to -H args */
extern char *hfsypaths[];	/*	Pointers to -h args */
extern char *ihfpaths[];	/*	Pointers to default -H paths */
extern char *ihfsypaths[];	/*	Pointers to default -h paths */
extern char *libpath;		/* -Lpath  for -l library files */

/* General "extended syntax" switches */
EXT int
				/* -O or -O=all	All optimizer flags */
    optpar,			/* -O=parse	Parse tree optimizations */
    optgen,			/* -O=gen	Code generator " */
    optobj,			/* -O=object	Obj code (peephole) " */
				/* -n = 0 Don't optimize anything */
				/* -d or -d=all All debug flags */
    debpar,			/* -d=parse	Parse tree debug output */
    debgen,			/* -d=gen	Code generator "   "    */
    debpho,			/* -d=pho	Peephole optim "   "    */
    debsym,			/* -d=sym	Symbol table   "   "    */
				/* -v or -v=all	  All verboseness flags */
    vrbfun,			/* -v=fundef	Print function names */
    vrbsta,			/* -v=stats	Print stats at end */
    vrbld;			/* -v=load	Print linking loader cmds */
EXT int
    ldextf,			/* -i or -i=extend */
    ldddtf,			/* -i=ddt */
    ldpsectf;			/* -i=psect */
extern struct psect {		/*	Structure for psect specifications */
    int ps_beg, ps_len, ps_lim;	/*	Psect start, max length, max addr */
}	ldpsdata,		/* -i=data:<beg>:<len>	Data segment */
	ldpscode,		/* -i=code:<beg>:<len>	Code segment */
	ldpsstack;		/* -i=stack:<beg>:<len>	Stack segment */

EXT int wrnlev;			/* -w=	Specifies warning level, one of: */
#define WLEV_ALL 0		/* -w=all or -w	Show all warnings */
#define WLEV_NOTE 1
#define WLEV_ADVISE 2
#define WLEV_WARN 3

extern int clevkcc;		/* -P=KCC Asks for KCC extensions */
extern int clevel;		/* -P=    Specifies C implem level, one of: */
#define CLEV_BASE 0		/* Base (default) should always be 0 */
#define CLEV_CARM 1
#define CLEV_ANSI 2
#define CLEV_STDC 3

/* -x= Cross-compiling switch variables (target environment settings) */
extern int tgsys;		/* Target System type */
				/*      0 (default) same as source system */
				/*	n different, some TGSYS_ value */
extern int tgcpu[];		/* Target CPU type array, indexed by TGCPU_ */
				/*	0 means don't code for this CPU */
				/*	1 means make code work for this CPU */
				/*	2 means same as 1, user-specified */
extern int tgasm;		/* Target Assembler type */
				/*      default is site dependent */
				/* -m = Use MACRO assembler */
extern int tgcsize;		/* Target Char Size, in bits */
extern int tgcpw;		/* Target # Chars Per Word */
extern int tgcmask;		/* Target Char Mask */

EXT struct {			/* Target CPU/SYS use-feature flags */
	int dmovx;		/*	Has DMOVx instructions */
	int adjsp;		/*	Has ADJSP instruction */
	int adjbp;		/*	Has ADJBP instruction */
	int fixflt;		/*	Has FIX, FIXR, FLTR instrs */
	int dfl_s;		/*	Use Software double format */
	int dfl_h;		/*	Use Hardware double format */
	int dfl_g;		/*	Use "G" double format */
	int exadr;		/*	Has extended addressing */
	int mapch;		/*	Sys: Must map char set */
	int mapdbl;		/*	Mach: Must map double format */
} tgmachuse;

/* Constant variables and tables - not changed at any time */

extern TOKEN tok[];		/* Token/Node-Op attributes */
extern char *nopname[];		/* Token/Node-Op names */
extern char *tokstr[];		/* Token literal strings */

/* Pointers to basic data types supported */
#define deftype	inttype		/* Default type - set to (int) */
#define voidtype	typeptr[TS_VOID]	/* (void)	*/
#define flttype		typeptr[TS_FLOAT]	/* (float)	*/
#define dbltype		typeptr[TS_DOUBLE]	/* (double)	*/
#define lngdbltype	typeptr[TS_LNGDBL]	/* (long double)	*/
#define schartype	typeptr[TS_CHAR]	/* (signed char)	*/
#define shrttype	typeptr[TS_SHORT]	/* (short)	*/
#define inttype		typeptr[TS_INT]		/* (int)	*/
#define longtype	typeptr[TS_LONG]	/* (long)	*/
#define uinttype	typeptr[TS_UINT]	/* (unsigned int) */
#define ulongtype	typeptr[TS_ULONG]	/* (unsigned long) */
#define ushrttype	typeptr[TS_USHORT]	/* (unsigned short) */
#define uchartype	typeptr[TS_UCHAR]	/* (unsigned char) */
EXT TYPE *chartype;		/* (char) - set to schartype or uchartype */
EXT TYPE *strcontype;		/* (char *) - type for string constants */
EXT TYPE *voidptrtype;		/* (void *) - to help check for NULL */
EXT TYPE *siztype;		/* Type for "sizeof" operator */
EXT TYPE *ptrdifftype;		/* Type for ptrdiff_t (ptr - ptr) */

extern TYPE *typeptr[];		/* Type pointers */
extern int typsiztab[];		/* Type sizes in words */
extern int typbsiztab[];	/* Type sizes in bits */
extern char *tsnames[];		/* Type names */


/* Per-file variables.  These are reset for each file being processed. */
EXT filename
	inpfname,	/* Current input file arg (may have .C inserted) */
	inpfdir,	/* Directory part of inpfname (before module)	*/
	inpfmodule,	/* Filename part of inpfname (no dir or ext)	*/
	inpfsuf,	/* Suffix part of inpfname (after module & ext) */
	outfname,	/* Assembler main output file:	module.FAI/MAC/MID */
	prefname,	/* Assembler "entry" prefix file:	module.PRE */
	debfname,	/* Debugging output file (parse tree):	module.DEB */
	phofname,	/* Debugging output file (peephole):	module.PHO */
	symfname;	/* Debugging output file (symtab):	module.SYM */
EXT FILE *in, *out, *fdeb, *fpho, *fsym;	/* STDIO file I/O pointers */
EXT int maxtype;	/* maximum types used (CCSYM, CCDUMP) */

/* Variables used during input file processing */
EXT int page,		/* position in input file */
    line,		/* ditto - line # on current page */
    fline,		/* ditto - line # in current file */
    tline,		/* total # of lines (including includes) */
    eof,		/* end of file flag */
    token;		/* current input token from lexer */
EXT int nerrors;	/* # errors in current file being compiled */


/* Per-declaration variables.  These are reset for each top-level
** declaration or function.
*/
extern NODE nodes[];	/* Parse tree node table (CCSTMT, CCDATA) */
EXT int savelits;	/* 0 when OK to reset string literal pool */
EXT SYMBOL *curfn;	/* Name of current function */
EXT int curfnloc, curfnnew;	/* where in file it started (CCERR, CCDECL) */
EXT int maxauto;	/* Current fn: size of auto vars (CCGEN, CCDECL) */
EXT int stackrefs;	/* Current fn: Whether it addresses locals */
EXT int stkgoto;	/* Current fn: Whether it contains a non-local goto */

