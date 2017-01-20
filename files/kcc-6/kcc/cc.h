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
#else
#define _URTSUD
#define _URTSUD_DEFAULT_PATH_OUT _URTSUD_PATH_OUT_NATIVE
#endif

#include <sys/types.h>
#include <urtsud.h>
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
    rlink,			/*      1 run link after assembling */
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
	nincfiles,		/* -I=file # of "" include files */
	nhfpaths,		/* -Hpath  # of <> include-file dirs */
	nhfsypaths,		/* -hpath  # of <sys/> include-file dirs */
	nhlibpaths,		/* -Lpath  # of library search paths */
	nihfpaths,		/* # of default -H and -h paths */
	nihfsypaths,
	nihlibpaths;		/* # of default -L paths */
extern char *predefs[];		/*	Pointers to -D args */
extern char *preundefs[];	/*	Pointers to -U args */
extern char *incpaths[];	/*	Pointers to -Ipath args */
extern char *incfiles[];	/*	Pointers to -I=file args */
extern char *hfpaths[];		/*	Pointers to -H args */
extern char *hfsypaths[];	/*	Pointers to -h args */
extern char *hlibpaths[];	/*	Pointers to -L args */
extern char *ihfpaths[];	/*	Pointers to default -H paths */
extern char *ihfsypaths[];	/*	Pointers to default -h paths */
extern char *ihlibpaths[];	/*	Pointers to default -L paths */

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
    debamb,			/* -d=amb	Pot. amb. sym  "   "	*/
				/* -v or -v=all	  All verboseness flags */
    vrbfun,			/* -v=fundef	Print function names */
    vrbsta,			/* -v=stats	Print stats at end */
    vrbld;			/* -v=load	Print linking loader cmds */
EXT int
    ldextf,			/* -i or -i=extend */
    ldddtf,			/* -i=ddt */
    ldronly,			/* -i=ronly */
    ldpsectf;			/* -i=psect */
extern struct psect {		/*	Structure for psect specifications */
    int ps_beg, ps_len;		/*	Psect start, max length */
}	ldpsdata,		/* -i=data:<beg>:<len>	Data segment */
	ldpscode,		/* -i=code:<beg>:<len>	Code segment */
	ldpssyms,		/* -i=syms:<beg>:<len>	Symbol segment */
	ldpsstack;		/* -i=stack:<beg>:<len>	Stack segment */

EXT int ptyp;			/* -p=  Specifies prototype output type */
#define PTYP_STATIC 1		/* -p=static  Output static prototypes */
#define PTYP_EXTERN 2		/* -p=extern  Output extern prototypes */
#define PTYP_BOTH 3		/* -p=both    Output static & extern protos */

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
	symfname,	/* Debugging output file (symtab):	module.SYM */
	ambfname,	/* Debugging output file (ambig. syms):	module.AMB */
	prtfname;	/* Prototype output file (ptyp):	module.PRT */
EXT FILE *in, *out, *fdeb, *fpho, *fsym, *fprt, *famb;
			/* STDIO file I/O pointers */
EXT char *outnam;	/* Pointer to output file name for errors */
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

extern SYMBOL *lsymhead;

/* External prototypes */

#ifdef __STDC__
#define P_(a) a
#else
#define P_(a) ()
#endif

/* System calls */
extern int unlink P_((const char *));
extern void *calloc P_((size_t nmemb,size_t size));
extern void *malloc P_((size_t size));
extern pid_t getpid P_((void));
extern int abspath P_((const char *path, char *result));
extern int access P_((const char *path, int mode));
extern int decomp P_((const char *path, char *dev, char *dir, char *name, char *type, char *gen, char *atr));
extern int open P_((const char *path, int flags, ...));
extern int close P_((int fd));
extern int read P_((int fd, char *buf, size_t size));

/* cc.c */
extern int tgmapch P_((int c));

/* ccasmb.c */
extern int asmb P_((char *m, char *f1, char*f2));
extern char *execargs P_((int *cntp, char ***vecp));
extern int addargs P_((int *argcp, char ***argvp, char *newargs));
extern int *maktflink P_((int argct,char **argvt,char *ofilename,char *nextprog));
extern void runlink P_((int linkf,int argc,char **argv,char *ofilename,char *nextprog));
extern char *fnlibpath P_((char *dst,char *src));
extern char *fnparse P_((char *source,char *direc,char *name,char *ext,char *suf));
extern int fnxislib P_((char *cp));
extern int fnxisrel P_((char *cp));
extern void fnmarkin P_((FILE *f,char *fname));
extern char *estrcpy P_((char *s1,char *s2));
extern char *fstrcpy P_((char *d,char *ps,char *fname));
extern int sixbit P_((char *str));
extern int symval P_((char *fnam,char *sym,int valf));

/* ccdecl.c */
extern void initpar P_((void));
extern void entdefs P_((void));
extern NODE *extdef P_((void));
extern NODE *tntdef P_((void));
extern SYMBOL *funchk P_((int def,int baseclass,SYMBOL *d,SYMBOL *s));
extern void _dbgspec P_((void));
extern NODE *ldecllist P_((void));
extern SYMBOL *defauto P_((char *id,TYPE *typ));
extern TYPE *typename P_((void));
extern void prtchk P_((TYPE *t,SYMBOL *s,int pn));

/* ccerr.c */
extern void note P_((char *fmt, ...));
extern void advise P_((char *fmt, ...));
extern void warn P_((char *fmt, ...));
extern void int_warn P_((char *fmt, ...));
extern void error P_((char *fmt, ...));
extern void int_error P_((char *fmt, ...));
extern void efatal P_((char *fmt, ...));
extern void jmsg P_((char *fmt, ...));
extern void jerr P_((char *fmt, ...));
extern void fatal P_((char *fmt, ...));
extern void errfopen P_((char *desc, char *fnam));
extern void errio P_((char *desc, char *fnam));
extern void errnomem P_((char *s));
extern int expect P_((int t));
extern int errflush P_((void));

/* cceval.c */
extern NODE *evalexpr P_((NODE *e));
extern NODE *evaldiscard P_((NODE *n));
extern int sideffp P_((NODE *n));
extern int istrue P_((NODE *test,NODE *bindings));

/* ccgswi.c */
extern void gswitch P_((NODE *n));

/* cclex.c */
extern void lexinit P_((void));
extern void tokpush P_((int t,SYMBOL *s));
extern int nextoken P_((void));

/* ccnode.c */
extern void nodeinit P_((void));
extern int nodeidx P_((NODE *n));
extern NODE *ndef P_((int op,TYPE *t,int f,NODE *l,NODE *r));
extern NODE *ndefop P_((int op));
extern NODE *ndeft P_((int op,TYPE *t));
extern NODE *ndeftf P_((int op,TYPE *t,int f));
extern NODE *ndeftl P_((int op,TYPE *t,NODE *l));
extern NODE *ndeftr P_((int op,TYPE *t,NODE *r));
extern NODE *ndefl P_((int op,NODE *l));
extern NODE *ndefr P_((int op,NODE *r));
extern NODE *ndeflr P_((int op,NODE *l,NODE *r));
extern NODE *ndeficonst P_((int val));
extern NODE *ndefident P_((SYMBOL *s));
extern void nodedump P_((NODE *n));

/* ccpp.c */
extern void ppinit P_((void));
extern void ppdefine P_((int unum,char **utab,int dnum,char **dtab));
extern void passthru P_((FILE *fp));
extern int nextpp P_((void));
extern void pushpp P_((void));

/* ccstmt.c */
extern NODE *funstmt P_((void));
extern long pconst P_((void));
extern NODE *asgnexpr P_((void));

/* ccsym.c */
extern void syminit P_((void));
extern SYMBOL *symfind P_((char *str,int creatf));
extern SYMBOL *symfidstr P_((char *str));
extern SYMBOL *symfnext P_((SYMBOL *osym,int flag));
extern SYMBOL *findgsym P_((SYMBOL *osym));
extern SYMBOL *symflabel P_((SYMBOL *sym));
extern SYMBOL *symftag P_((SYMBOL *sym));
extern SYMBOL *symfflag P_((SYMBOL *sym,int flag));
extern SYMBOL *symfmember P_((SYMBOL *sym,SYMBOL *tag));
extern SYMBOL *symfxext P_((SYMBOL *sym));
extern void freesym P_((SYMBOL *s));
extern SYMBOL *creatsym P_((char *id));
extern SYMBOL *symgcreat P_((char *id));
extern SYMBOL *uniqsym P_((SYMBOL *s));
extern SYMBOL *symqcreat P_((SYMBOL *s));
extern int isdupsym P_((SYMBOL *sym));
extern SYMBOL *shmacsym P_((SYMBOL *sym));
extern void copysym P_((SYMBOL *s,SYMBOL *t));
extern int hash P_((char *s));
extern int symhash P_((SYMBOL *s));
extern SYMBOL *beglsym P_((void));
extern void endlsym P_((SYMBOL *prevptr));
extern void ridlsym P_((SYMBOL *prevptr));
extern int mapextsym P_((SYMBOL *s));
extern void mapintsym P_((SYMBOL *s));
extern SYMBOL *newlabel P_((void));
extern void reflabel P_((SYMBOL *lab,int count));
extern void freelabel P_((SYMBOL *lab));
extern void cleanlabs P_((void));
extern void ambdump P_((SYMBOL *table));
extern void symdump P_((SYMBOL *table,char *name));
extern int shohash P_((void));
extern TYPE *findtype P_((int tsp,TYPE *subt));
extern TYPE *findsztype P_((int tsp,int siz,TYPE *subt));
extern TYPE *findutype P_((TYPE *t));
extern TYPE *findqtype P_((TYPE *t,int quals));
extern TYPE *findftype P_((TYPE *rtyp,TYPE *plist));
extern TYPE *findptype P_((int tsp,TYPE *plist,TYPE *t));
extern TYPE *findctype P_((int tsp,int flags,int siz,TYPE *subt));
extern int cmptype P_((TYPE *t1,TYPE *t2));
extern int cmpgetype P_((TYPE *t,TYPE *u));
extern int cmputype P_((TYPE *t,TYPE *u));
extern TYPE *tcomposite P_((TYPE *t1,TYPE *t2));
extern int sizetype P_((TYPE *t));
extern int sizeptobj P_((TYPE *t));
extern int sizearray P_((TYPE *t));
extern int elembsize P_((TYPE *t));
extern int tispure P_((TYPE *t));
extern int tischarpointer P_((TYPE *t));
extern int tisbytepointer P_((TYPE *t));
extern int tischararray P_((TYPE *t));
extern int tisbytearray P_((TYPE *t));
extern void typedump P_((void));

/* cctype.c */
extern NODE *convcast P_((TYPE *t,NODE *n));
extern NODE *convasgn P_((TYPE *lt,NODE *n));
extern NODE *convarrfn P_((NODE *n));
extern NODE *convunary P_((NODE *n));
extern NODE *convbinary P_((NODE *n));
extern NODE *convfunarg P_((NODE *n));
extern TYPE *convfparam P_((TYPE *t));
extern TYPE *convternaryt P_((NODE *n));
extern NODE *convvoidptr P_((NODE *n));
extern NODE *convnullcomb P_((NODE *n));

/* ccout.c */
extern void outinit P_((void));
extern void outdone P_((int mainf));
extern int makprefile P_((char *fname));
extern int codeseg P_((void));
extern int dataseg P_((void));
extern int prevseg P_((int seg));
extern void outptr P_((SYMBOL *sym,int bsize,int offset));
extern int adjboffset P_((int boff,int *awoff,int bpw));
extern int outflt P_((int typ,int *ptr,int flags));
extern void outmpdbl P_((int *ip,int which));
extern int binexp P_((unsigned int n));
extern void outscon P_((char *s,int l,int bsiz));
extern void outlab P_((SYMBOL *s));
extern void outid P_((char *s));
extern void outprolog P_((SYMBOL *s));
extern void outepilog P_((SYMBOL *s));
extern void outmidef P_((SYMBOL *s));
extern void outmiref P_((SYMBOL *s));
extern void outstr P_((char *s));
extern void outc P_((int c));
extern void outnl P_((void));
extern void outtab P_((void));
extern void outnum P_((int n));
extern void outpnum P_((unsigned n));
extern void outsix P_((unsigned wd));

/* ccgen.c */
extern void gencode P_((NODE *n));

/* ccgen1.c */
extern void genstmt P_((NODE *n));

#undef P_
