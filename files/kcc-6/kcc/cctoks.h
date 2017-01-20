/*	CCTOKS.H - Token and Node-Op bindings for KCC
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.75, 17-Apr-1988
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
*/

/* This file contains one "tokdef" macro call for every token and node op
 * used by KCC.  The program which #includes this file is responsible for
 * defining "tokdef" in an appropriate way (see CCDATA.C and CCNODE.H).
 * The first entry should NOT correspond to any valid token or node op,
 * so that zero indices and values can be trapped as errors.
 * If no "tokdef" macro is defined, it is assumed that the file is being
 * included merely to get the various symbol definitions.
 */

/* The following naming conventions exist:
 *	T_	Token code.  Used only as a token, never as a node op.
 *	Q_	Token and Node-op.  Used as both.
 *	N_	Node-op code.  Used only as a node op, never as a token.
 */
/*
**	A note on tokens: all tokens returned from the lexer (T_ and Q_ codes)
** are distinct, except for -, &, and *.  Q_MINUS, Q_ANDT, and Q_MPLY are
** returned for these.  The parser must determine whether these are actually
** N_NEG, N_ADDR, or N_PTR.
*/

#undef TOKDEF_DEFINED	/* Assume includer hasn't defined tokdef */
#ifndef tokdef
#define tokdef(name,str,type,prec) name,
#else
#define TOKDEF_DEFINED	/* Ah, user is doing special stuff! */
#endif


#ifndef TOKDEF_DEFINED

/* Define structure of entries in the "tok" table, indexed by token
 * number.  Table is built in CCDATA.
 */
#define TOKEN struct token
TOKEN {			/* Entry indexed by token number (T_,Q_,N_) */
	short tktype;	/*  token type (set to a TKTY_ value) */
        short tkprec;	/*  operator precedence, if meaningful */
};			/*  or various token-specific stuff */

/* Token type codes (TOKEN.tktype)
** There are only two things set with these values:
**	(1) The tok[] array in CCDATA, with one entry for every possible token.
**	(2) The "Skey" component of a SC_RW (reserved word) symbol table entry.
** The TKTY_NULL value is never referenced directly; its exact value
**	doesn't matter as long as it isn't one of the other types.
** The .tkprec value is only used in two places:
**	[1] by binary() in CCSTMT, if the type is one of TKTY_BINOP
**		or TKTY_BOOLOP.  Precedence is a number from 0 (ignored) to
**		16 (highest precedence) as per H&S table 7-1.
**	[2] by initsym() in CCSYM, if the type is a reserved word, i.e. one of
**		TKTY_RWTYPE, TKTY_RWSC, TKTY_RWCOMP.  It contains RWF_ flags.
** .tkprec is ignored for all other token types.
*/

enum toktype {
	TKTY_NULL,	/* None of the following */
	TKTY_PRIMARY,	/* Primary expression */
	TKTY_UNOP,	/* Unary operator */
	TKTY_BOOLUN,	/* Unary boolean operator (only '!') */
	TKTY_BINOP,	/* Binary operator */
	TKTY_BOOLOP,	/* Binary boolean operator */
	TKTY_ASOP,	/* Binary assignment operator */
	TKTY_TERNARY,	/* Ternary (conditional) operator (only '?') */
	TKTY_SEQ,	/* Sequential evaluation operator (only ',') */
	TKTY_RWTYPE,	/* Reserved-Word: Type-specifier */
	TKTY_RWSC,	/* Reserved-Word: Storage Class */
	TKTY_RWCOMP,	/* Reserved-Word: Compound statement */
	TKTY_RWOP	/* Reserved-Word: Built-in operator (e.g. "calls") */
};

/* Reserved-word token flags */
#define RWF_PREC	077	/* Operator precedence, if applicable */
#define RWF_ANSI	0100	/* Keyword is ANSI addition */
#define RWF_KCC		0200	/* Keyword is KCC extension */

enum tokcodes {
#endif

/* Simple tokens.  Most correspond to single characters. */
tokdef(T_NULL,	0,	TKTY_NULL, 0)	/* 0 is an invalid token/node-op */
tokdef(T_EOF,	0,	TKTY_NULL, 0)	/* EOF reached */
tokdef(T_WSP,	" ",	TKTY_NULL, 0)	/* Whitespace */
tokdef(T_EOL,	"\n",	TKTY_NULL, 0)	/* EOL */
tokdef(T_IDENT,	0,	TKTY_NULL, 0)	/* Non-macro identifier */
tokdef(T_MACRO,	0,	TKTY_NULL, 0)	/* Macro identifier */
tokdef(T_MACARG,0,	TKTY_NULL, 0)	/* Expand arg (in macro body) */
tokdef(T_MACSTR,0,	TKTY_NULL, 0)	/* Stringize arg (in macro body) */
tokdef(T_MACINS,0,	TKTY_NULL, 0)	/* Insert arg (in macro body) */
tokdef(T_MACCAT,0,	TKTY_NULL, 0)	/* Concatenate op (in macro body) */
tokdef(T_MACEOF,0,	TKTY_NULL, 0)	/* Macro EOF reached */
tokdef(T_ICONST,0,	TKTY_NULL, 0)	/* PP-number integer const */
tokdef(T_FCONST,0,	TKTY_NULL, 0)	/* PP-number floating const */
tokdef(T_CCONST,0,	TKTY_NULL, 0)	/* Character constant */
tokdef(T_SCONST,0,	TKTY_NULL, 0)	/* String literal constant */
tokdef(T_UNKNWN,0,	TKTY_NULL, 0)	/* Unknown token string */
tokdef(T_ELPSIS,"...",	TKTY_NULL, 0)	/* "..." */
tokdef(T_SHARP,	"#",	TKTY_NULL, 0)	/* #  Stringize op */
tokdef(T_SHARP2,"##",	TKTY_NULL, 0)	/* ## Concatenate op */

tokdef(T_LPAREN,"(",	TKTY_NULL, 0)	/* ( */
tokdef(T_RPAREN,")",	TKTY_NULL, 0)	/* ) */
tokdef(T_SCOLON,";",	TKTY_NULL, 0)	/* ; */
tokdef(T_LBRACK,"[",	TKTY_NULL, 0)	/* [ */
tokdef(T_RBRACK,"]",	TKTY_NULL, 0)	/* ] */
tokdef(T_LBRACE,"{",	TKTY_NULL, 0)	/* { */
tokdef(T_RBRACE,"}",	TKTY_NULL, 0)	/* } */
tokdef(T_COLON,	":",	TKTY_NULL, 0)	/* : */
tokdef(T_COMMA,	",",	TKTY_NULL, 0)	/* , */
tokdef(T_LCONST,0,	TKTY_NULL, 0)	/* Literal constant (any) */
tokdef(T_INC,	"++",	TKTY_NULL, 0)	/* ++ */
tokdef(T_DEC,	"--",	TKTY_NULL, 0)	/* -- */

/* Tokens/Node-Ops organized by operator type
** 	This listing follows [H&S table 7-1, sec 7.2.2]
*/
/* Primary expressions */
tokdef(Q_IDENT,	0,TKTY_PRIMARY,	16)	/* identifier */
tokdef(N_UNDEF,	0,TKTY_PRIMARY,	16)	/* Undef ident (error placeholder) */
tokdef(N_ICONST,0,TKTY_PRIMARY,	16)	/* Integral type constant */
tokdef(N_FCONST,0,TKTY_PRIMARY,	16)	/* Floating-point type constant */
tokdef(N_SCONST,0,TKTY_PRIMARY,	16)	/* String literal constant */
tokdef(N_PCONST,0,TKTY_PRIMARY,	16)	/* Pointer-type constant */
tokdef(N_VCONST,0,TKTY_PRIMARY,	16)	/* Void-type "constant" expr */
tokdef(N_ECONST,0,TKTY_PRIMARY,	16)	/* Enum-type constant */
tokdef(N_ACONST,0,TKTY_PRIMARY,	16)	/* Special - address constant??? */
/* no special op for subscript */	/* [k]	subscripting */
tokdef(N_FNCALL,0,TKTY_PRIMARY,	16)	/* f()	function call */
tokdef(Q_DOT,	".",	TKTY_PRIMARY,	16)	/* .	direct selection */
tokdef(Q_MEMBER,"->",	TKTY_PRIMARY,	16)	/* ->	indirect selection */

/* Unary operators */
tokdef(N_POSTINC, 0,	TKTY_UNOP,	15)	/* ()++	Postfix increment */
tokdef(N_POSTDEC, 0,	TKTY_UNOP,	15)	/* ()--	Postfix decrement */
tokdef(N_PREINC, 0,	TKTY_UNOP,	14)	/* ++()	Prefix increment */
tokdef(N_PREDEC, 0,	TKTY_UNOP,	14)	/* --()	Prefix decrement */
tokdef(T_SIZEOF,"sizeof",TKTY_RWOP,	14)	/* sizeof	Size */
tokdef(N_CAST,	0,	TKTY_UNOP,	14)	/* (type)	Cast */
tokdef(Q_COMPL,	"~",	TKTY_UNOP,	14)	/* ~	Bitwise not */
tokdef(Q_NOT,	"!",	TKTY_BOOLUN,	14)	/* !	Logical not */
tokdef(N_NEG,	0,	TKTY_UNOP,	14)	/* -()	Arithmetic negation */
tokdef(N_ADDR,	0,	TKTY_UNOP,	14)	/* &()	Address of */
tokdef(N_PTR,	0,	TKTY_UNOP,	14)	/* *()	Indirection */

/* Binary operators (and one ternary) */
tokdef(Q_MPLY,	"*",	TKTY_BINOP,	13)	/* *	(L) Multiply */
tokdef(Q_DIV,	"/",	TKTY_BINOP,	13)	/* /	(L) Divide */
tokdef(Q_MOD,	"%",	TKTY_BINOP,	13)	/* %	(L) Remainder */
tokdef(Q_PLUS,	"+",	TKTY_BINOP,	12)	/* +	(L) Add */
tokdef(Q_MINUS,	"-",	TKTY_BINOP,	12)	/* -	(L) Subtract */
tokdef(Q_LSHFT,	"<<",	TKTY_BINOP,	11)	/* <<	(L) Left shift */
tokdef(Q_RSHFT,	">>",	TKTY_BINOP,	11)	/* >>	(L) Right shift */
tokdef(Q_LESS,	"<",	TKTY_BOOLOP,	10)	/* <	(L) Less than */
tokdef(Q_GREAT,	">",	TKTY_BOOLOP,	10)	/* >	(L) Greater than */
tokdef(Q_LEQ,	"<=",	TKTY_BOOLOP,	10)	/* <=	(L) Less or equal */
tokdef(Q_GEQ,	">=",	TKTY_BOOLOP,	10)	/* >=	(L) Greater or equal */
tokdef(Q_EQUAL,	"==",	TKTY_BOOLOP,	9)	/* ==	(L) Equal */
tokdef(Q_NEQ,	"!=",	TKTY_BOOLOP,	9)	/* !=	(L) Unequal */
tokdef(Q_ANDT,	"&",	TKTY_BINOP,	8)	/* &	(L) Bitwise AND */
tokdef(Q_XORT,	"^",	TKTY_BINOP,	7)	/* ^	(L) Bitwise XOR */
tokdef(Q_OR,	"|",	TKTY_BINOP,	6)	/* |	(L) Bitwise OR */
tokdef(Q_LAND,	"&&",	TKTY_BOOLOP,	5)	/* &&	(L) Logical AND */
tokdef(Q_LOR,	"||",	TKTY_BOOLOP,	4)	/* ||	(L) Logical OR */
tokdef(Q_QUERY,	"?",	TKTY_TERNARY,	3)	/* ?	(R) Conditional */
tokdef(Q_ASGN,	"=",	TKTY_ASOP,	2)	/* =	(R) Assignment */
tokdef(Q_ASPLUS,"+=",	TKTY_ASOP,	2)	/* +=	(R)	*/
tokdef(Q_ASMINUS,"-=",	TKTY_ASOP,	2)	/* -=	(R)	*/
tokdef(Q_ASMPLY,"*=",	TKTY_ASOP,	2)	/* *=	(R)	*/
tokdef(Q_ASDIV,	"/=",	TKTY_ASOP,	2)	/* /=	(R)	*/
tokdef(Q_ASMOD,	"%=",	TKTY_ASOP,	2)	/* %=	(R)	*/
tokdef(Q_ASRSH,	">>=",	TKTY_ASOP,	2)	/* >>=	(R)	*/
tokdef(Q_ASLSH,	"<<=",	TKTY_ASOP,	2)	/* <<=	(R)	*/
tokdef(Q_ASAND,	"&=",	TKTY_ASOP,	2)	/* &=	(R)	*/
tokdef(Q_ASXOR,	"^=",	TKTY_ASOP,	2)	/* ^=	(R)	*/
tokdef(Q_ASOR,	"|=",	TKTY_ASOP,	2)	/* |=	(R)	*/
tokdef(N_EXPRLIST,0,	TKTY_SEQ,	1)	/* ,	(L) sequential eval */

/* Reserved-Word: Type-specifier */
/* See the tnames table in CCDATA for other type-spec reserved words */
tokdef(T_VOID,	"void",		TKTY_RWTYPE, 0)
tokdef(T_STRUCT,"struct",	TKTY_RWTYPE, 0)
tokdef(T_UNION,	"union",	TKTY_RWTYPE, 0)
tokdef(T_ENUM,	"enum",		TKTY_RWTYPE, 0)
tokdef(T_FLOAT,	"float",	TKTY_RWTYPE, 0)
tokdef(T_DOUBLE,"double",	TKTY_RWTYPE, 0)
tokdef(T_CHAR,	"char",		TKTY_RWTYPE, 0)
tokdef(T_SHORT,	"short",	TKTY_RWTYPE, 0)
tokdef(T_INT,	"int",		TKTY_RWTYPE, 0)
tokdef(T_LONG,	"long",		TKTY_RWTYPE, 0)
tokdef(T_UNSIGNED,"unsigned",	TKTY_RWTYPE, 0)
tokdef(T_SIGNED,"signed",	TKTY_RWTYPE, RWF_ANSI)	/* (ANSI addition) */
tokdef(T_CONST,	"const",	TKTY_RWTYPE, RWF_ANSI)	/* (ANSI addition) */
tokdef(T_VOLATILE,"volatile",	TKTY_RWTYPE, RWF_ANSI)	/* (ANSI addition) */
tokdef(T_CHAR6,	"_KCCtype_char6",TKTY_RWTYPE, RWF_KCC)	/* (KCC extension) */
tokdef(T_CHAR7,	"_KCCtype_char7",TKTY_RWTYPE, RWF_KCC)	/* (KCC extension) */
tokdef(T_CHAR8,	"_KCCtype_char8",TKTY_RWTYPE, RWF_KCC)	/* (KCC extension) */
tokdef(T_CHAR9,	"_KCCtype_char9",TKTY_RWTYPE, RWF_KCC)	/* (KCC extension) */
tokdef(T_CHAR18,"_KCCtype_char18",TKTY_RWTYPE, RWF_KCC)	/* (KCC extension) */
#if SYS_CSI
tokdef(T_FORTRAN, "fortran",   	TKTY_RWTYPE, RWF_KCC)   /* (KCC extension) */
tokdef(T_BLISS,   "bliss",	TKTY_RWTYPE, RWF_KCC)   /* (KCC extension) */
#endif

/* Reserved-Word: Storage Class */
tokdef(T_AUTO,	"auto",		TKTY_RWSC, 0)
tokdef(T_EXTERN,"extern",	TKTY_RWSC, 0)
tokdef(T_REGISTER,"register",	TKTY_RWSC, 0)
tokdef(T_TYPEDEF,"typedef",	TKTY_RWSC, 0)
tokdef(T_STATIC,"static",	TKTY_RWSC, 0)

/* Reserved-Word: Compound statement */
tokdef(Q_GOTO,	"goto",		TKTY_RWCOMP, 0)
tokdef(Q_RETURN,"return",	TKTY_RWCOMP, 0)
tokdef(Q_BREAK,	"break",	TKTY_RWCOMP, 0)
tokdef(Q_CONTINUE,"continue",	TKTY_RWCOMP, 0)
tokdef(Q_IF,	"if",		TKTY_RWCOMP, 0)
tokdef(T_ELSE,	"else",		TKTY_RWCOMP, 0)
tokdef(Q_FOR,	"for",		TKTY_RWCOMP, 0)
tokdef(Q_DO,	"do",		TKTY_RWCOMP, 0)
tokdef(Q_WHILE,	"while",	TKTY_RWCOMP, 0)
tokdef(Q_SWITCH,"switch",	TKTY_RWCOMP, 0)
tokdef(Q_CASE,	"case",		TKTY_RWCOMP, 0)
tokdef(Q_DEFAULT,"default",	TKTY_RWCOMP, 0)

/* Reserved-Word: Built-in operators */
tokdef(Q_ASM,	"asm",		TKTY_RWOP, RWF_KCC+16)	/* asm() */
tokdef(T_OFFSET,"_KCC_offsetof",TKTY_RWOP,RWF_ANSI+RWF_KCC+16) /* offsetof() */
tokdef(T_SYMVAL,"_KCCx",	TKTY_RWOP, RWF_KCC+16)	/* Placeholder */
tokdef(T_SYMFND,"_KCCy",	TKTY_RWOP, RWF_KCC+16)	/* Placeholder */


/* Miscellaneous node ops */
tokdef(N_FUNCTION,0,	TKTY_NULL, 0)	/* Function definition */
tokdef(N_STATEMENT,0,	TKTY_NULL, 0)	/* Statement list */
tokdef(N_LABEL,	0,	TKTY_NULL, 0)	/* Labelled statement */
tokdef(N_DATA,	0,	TKTY_NULL, 0)	/* Data decl list, contains N_IZs */
tokdef(N_IZ,	0,	TKTY_NULL, 0)	/* Identifier decl (w/optional init) */
tokdef(N_IZLIST,0,	TKTY_NULL, 0)	/* Initializer list (under N_IZ) */
tokdef(N_LITIZ,0,	TKTY_NULL, 0)	/* Literal izer list */
tokdef(N_NODE,	0,	TKTY_NULL, 0)	/* Random substructure node op */
tokdef(N_ERROR,	0,	TKTY_NULL, 0)	/* Error placeholder (stmt or expr) */

#ifndef TOKDEF_DEFINED		/* If doing enum defs, wrap up. */
	NTOKDEFS		/* # of tokens defined */
};
#undef tokdef
#endif
