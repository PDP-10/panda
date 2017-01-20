/*	CCDATA.C - KCC data allocations for vars and tables
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.166, 29-Apr-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		All changes after v.76, 8-Aug-1985
*/

#include "ccsite.h"	/* Get our site-dependent stuff */

/* Define various externals here */
#define EXT		/* Define various externals.  Note that this */
#include "cc.h"		/* also includes ccparm.h for our size parameters! */
#include "cclex.h"	/* More externals */

/* Version numbers (not switches -- cannot change at runtime).
**    cverdist is incremented whenever cvercode or cverlib is, or when
**	a new major KCC distribution is made.
**    cverkcc ideally should be updated every time a new .EXE is made and
**	should match the file version number.  This may have to be patched in
**	after compilation.
*/
int cvercode = 2;		/* Current C code version (for $$CVER) */
int cverlib = 3;		/* Current C library version (for $$CVER) */
int cverdist = 6;		/* Major KCC distrib version (info only) */
int cverkcc = 620;		/* KCC.EXE file version (rev #) (info only) */

/*
** Switch-dependent variables - initial default values
*/

int clevel = SWI_CLEV;		/* Default C implementation level */
int clevkcc = 1;		/* Always default to ask for KCC extensions */

int tgcpu[TGCPU_N] = SWI_TGCPUS;/* Target CPU types (default to source) */
int tgsys = SWI_TGSYS;		/* Target System type (default to source) */
int tgasm = SWI_TGASM;		/* Target Assembler type (site-dep default) */
int tgcsize = TGSIZ_CHAR;		/* Target Char size in bits */
int tgcpw = TGSIZ_WORD/TGSIZ_CHAR;	/* Target # Chars Per Word */
int tgcmask = (1<<TGSIZ_CHAR)-1;	/* Target Char Mask */

int npredef = 0;		/* -Dmac=d # of -D macro predefinitions */
int npreundef = 0;		/* -Umac   # of -U macro pre-undefinitions */
int nincpaths = 0;		/* -Ipath  # of "" include-file directories */
int nincfiles = 0;		/* -I=     # of "" include files */
int nhfpaths = 0;		/* -Hpath  # of <> include-file dirs */
int nhfsypaths = 0;		/* -hpath  # of <sys/> include-file dirs */
int nhlibpaths = 0;		/* -Lpath  # of library search paths */

char *predefs[MAXPREDEF];	/* Pointers to -D macro predefs */
char *preundefs[MAXPREDEF];	/* Pointers to -U macro pre-undefs */
char *incpaths[MAXINCDIR];	/* Pointers to -I search paths ("") */
char *incfiles[MAXINCFIL];	/* Pointers to -I= files */
char *hfpaths[MAXINCDIR];	/* -H search paths (<>) */
char *hfsypaths[MAXINCDIR];	/* -h search paths (<sys/>) */
char *hlibpaths[MAXLIBDIR];	/* -L library search paths */
char *ihfpaths[] = { SWI_HFPATH };	/* Default -H search paths <> */
char *ihfsypaths[] = { SWI_HFSYPATH };	/* Default -h search paths <sys/> */
char *ihlibpaths[] = { SWI_LIBPATH };	/* Default -L library search paths */
int nihfpaths = sizeof(ihfpaths)/sizeof(ihfpaths[0]);	/* # of deflt paths */
int nihfsypaths = sizeof(ihfsypaths)/sizeof(ihfsypaths[0]);
int nihlibpaths = sizeof(ihlibpaths)/sizeof(ihlibpaths[0]);

char *asmhfile = SWI_ASMHFILE;	/* User-specified asm hdr file loc */
char *asmtfile = SWI_ASMTFILE;	/* Temp filename to use for #asm */
				/* (this should disappear someday!) */

/* Loader psect default specifications */
struct psect ldpsdata  = { -1, -1 }; /* Set to compute defaults */
struct psect ldpscode  = { -1, -1 };
struct psect ldpssyms  = { -1, -1 };
struct psect ldpsstack = { -1, -1 };

/* Table storage allocation and more definitions */

				/* Allocate storage for tables in cc.h */
NODE nodes[MAXNODE];		/* Allocate parse tree node table */
SYMBOL *htable[MAXHSH];		/* Symbol hash table */
TYPE *ttable[THASHSIZE];	/* hash table of types */
TYPE types[MAXTYPE];		/* table of types */

#define CHARTABLE		/* Make ctftab[] table */
#include "ccchar.h"

#define GEXT			/* Define stuff */
#include "ccgen.h"		/* and make codes[MAXCODE] table */

	/* Output string table of PDP-10 pseudo-ops, indexed by P_ vals */
char *popostr[] = {
#define opcode(iname,oname,f,a,b,c,d) oname,
#include "cccode.h"
#undef opcode
};
	/* Flag table for PDP-10 pseudo-ops, indexed by P_ vals */
int popflg[] = {
#define opcode(iname,oname,f,a,b,c,d) f,
#include "cccode.h"
#undef opcode
};
	/* Reg change table for PDP-10 pseudo-ops, indexed by P_ vals */
int popprc[] = {
#define opcode(iname,oname,f,prcf,b,c,d) prcf,
#include "cccode.h"
#undef opcode
};

/* Various tables for dealing with C data types */

/* Make tfltab[] table for parser/generator.
**	Note that this is where the TF_BYTE flag gets added in.
*/
int tfltab[] = {
#define typespec(ts,str,bsiz,fl) \
    fl | ((bsiz && bsiz < TGSIZ_WORD) ? TF_BYTE : 0),
	alltypemacro	/* Expand list of types from CCSYM.H */
#undef typespec
	0,0,0		/* Permit lookup of flags (0) for param types */
};

char *tsnames[] = {
#define typespec(ts,str,bsiz,fl) str,
	alltypemacro		/* Expand list of types from CCSYM.H */
#undef typespec
};

/* TYPSIZTAB - Type size tables.
**	This is somewhat machine-dependent and so may someday be moved
** to a CCTARG machine-specific file.  There is one entry for each basic type.
** Observe that (somewhat unfortunately) sizes here are expressed in
** terms of words, not bytes such as sizeof would return.
** The TYPBSIZTAB table is in terms of bits, not words or bytes.
**	These two tables should only be referenced by CCSYM.
*/
int typsiztab[TS_MAX] = {
#define typespec(ts,str,bsiz,fl) ((bsiz+TGSIZ_WORD-1) / TGSIZ_WORD),
	alltypemacro		/* Expand list of types from CCSYM.H */
#undef typespec
};
int typbsiztab[TS_MAX] = {
#define typespec(ts,str,bsiz,fl) bsiz,
	alltypemacro		/* Expand list of types from CCSYM.H */
#undef typespec
};

/* Table of pointers to oft-used basic types such as int, char, etc.
**	Initialized by CCSYM.  Some "variables" such as inttype are
** actually macros which point to entries in this table.  Not all types
** have their entries initialized.
*/
TYPE *typeptr[TS_MAX];

/*
** Tokens.
**
** This table is referenced by CCDECL, CCGEN, CCSTMT.
** It is indexed by the token/node-op value (T_,Q_,N_).
** See the included file for details on the values.
*/

/* Define a table of token/node types & precs */
TOKEN tok[] = {
#define tokdef(name,str,type,prec) type,prec,
#include "cctoks.h"
#undef tokdef
};

/* Backward compatibility hack, see whether using old preprocessor (which
** allowed parameters within string & char constants) or new one (which
** doesn't, but does have the # stringize operator).
*/
#define testcat(a) 'a'
#define OLDPP ('X' == testcat(X))	/* TRUE if using old PP */

/* Define a table of token/node op names. */
char *nopname[] = {
#if OLDPP
#define tokdef(n,s,t,p) "n",		/* Old PP with param in string lit */
#else
#define tokdef(n,s,t,p) #n,		/* New ANSI PP with stringize op! */
#endif
#include "cctoks.h"			/* Get the data */
#undef tokdef
};

/* Define a table of token strings. */
char *tokstr[] = {
#define tokdef(n,s,t,p) s,
#include "cctoks.h"
#undef tokdef
};
