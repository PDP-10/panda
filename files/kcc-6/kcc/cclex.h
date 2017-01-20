/*	CCLEX.H - Declarations for KCC input parsing (CCLEX and CCPP)
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.21, 24-Mar-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
**		Created from cc.h and other places, 15 Dec 85
*/

#ifndef EXT		/* Actual definition happens in CCDATA */
#define EXT extern
#endif

/* Globals shared between CCPP and CCERR for error reporting */
EXT char errlin[ERRLSIZE];	/* error context - circular buffer */
EXT char *erptr;		/* pointer into it */
EXT int erpleft;		/* # chars left until wraparound */
EXT int ercsiz;			/* # chars to show in error msg */

/* Globals shared between CCPP and CCLEX */
#define PPTOK struct pptok 
struct pptok {
	unsigned short pt_typ;	/* Token type, T_xxx */
	unsigned short pt_is;	/* IS_xxx Identifier Status, if T_IDENT */
	PPTOK *pt_nxt;		/* Index of next token */
	union pptokval {	/* Value of token */
	    int i;
	    char *cp;
	    SYMBOL *sym;
	} pt_val;
};
enum {	/* Identifier Status code values - only valid for T_IDENT tokens */
	IS_UNK=0,	/* Unknown (may be macro or C sym) - must be 0 */
	IS_MNOT,	/* Known not to be macro */
	IS_MHID,	/* Is a macro, but hidden (never expand this) */
	IS_MEXP		/* Is macro, and OK to expand */
};
EXT int curpp;			/* Current cooked token type from nextpp() */
EXT union pptokval curval;	/* Current cooked token value */
EXT PPTOK *curptr;		/* Ptr to current cooked pptoken, if any */
EXT SYMBOL *cursym;		/* Ptr to symbol, if token is T_IDENT */


/* Constant value if current token == T_LCONST.
 *	Set by CCLEX as part of token parsing, and
 *	copied by CCSTMT into parse tree node values.
 *	Nothing else uses this.
 */
EXT struct {
    TYPE *ctype;		/* constant type */
    union {
	int cint;		/* integer value */
	float cflt;		/* float value */
	double cdbl;		/* double value */
/*	long double cldbl;	*/
	struct {		/* string constant */
	    char *csp;		/*   char pointer */
	    int csint;		/*   string length */
	} cstr;
    } cvar;
} constant;			/* place to hold current constant */

/* The value of ctype is set to only one of the following, with
 * the associated definitions used.  The cvar/cstr unions are never to be
 * used directly.
 */
/* ctype == deftype	(INT) integer constant */
#define cvalue cvar.cint		/* integer value */

/* ctype == strtype	(CHAR *) string constant */
#define csptr cvar.cstr.csp		/* Pointer for string const */
#define cslen cvar.cstr.csint		/* String length (includes null) */

/* ctype == dbltype	(DOUBLE) double (float) constant */
/*	or flttype */
/*	or lngdbltype */
#define Cfloat cvar.cflt	/* floating-point value */
#define Cdouble cvar.cdbl
#define Clngdbl cvar.cdbl	/* Not used yet for anything different. */
