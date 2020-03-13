/* CCCHAR.H - Character processing facility definitions
 *
 *	(c) Copyright Ken Harrenstien 1989
 *		All changes after v.11, 31-Aug-1986
 *	(c) Copyright Ken Harrenstien, SRI International 1985
 *
 * This is very similar to <ctype.h> but has been duplicated in order to
 * provide more insulation and speed for KCC, as well as allowing for
 * system dependent modifications.  If CHARTABLE is defined,
 * the flag table is included (this is for CCDATA).
 *
 *	These definitions, plus ccdata.c, conform to the description
 * in "C: A Reference Manual" (Harbison & Steele, 1984), section 11.1
 * with the caveat that several facilities evaluate their argument expression
 * more than once.  Therefore, side-effects in arguments should not be used.
 *
 * Portability considerations: the following facilities depend
 * on the runtime character set, but will work for both ASCII and EBCDIC:
 *	isodigit, toint, _toupper, _tolower
 * These are only meaningful when using ASCII:
 *	isascii, toascii, tosixbit
 */

/* Define internal character type flags.  Note value in ctftab is an int,
 * so we can use lots of flags and do fast references.
 */
#define CTF_CTL 01	/* Control char (not printing) */
#define CTF_WSP	02	/* Whitespace (all kinds) */
#define CTF_SP	04	/* Space */
#define CTF_PUN	010	/* Punctuation (non-space, non-alphanumeric) */
#define CTF_N	020	/* Numeric 0-9 */
#define CTF_UA	040	/* Uppercase alpha */
#define CTF_LA	0100	/* Lowercase alpha */
#define CTF_X	0200	/* Hex digit */
#define CTF_NO	0400	/* Octal digit */
#define CTF_US	01000	/* Underscore (for C identifier checking) */
#define CTF_EOL 02000	/* C line break (old: \n, \r, \f, \v) (new: \n) */
#define CTF_BS	04000	/* Backspace (old: C whitespace char) */
#define CTF_HSP 010000	/* C "horizontal" whitespace (all but \n) */
#define CTF_TAB 020000	/* TAB */
#define CTF_VWL 040000	/* Vowel */

/* Facility macros, in alphabetical order */
#define isalnum(c)	((ctftab+1)[c]&(CTF_UA|CTF_LA|CTF_N))
#define isalpha(c)	((ctftab+1)[c]&(CTF_UA|CTF_LA))
#define isascii(i)	(0 <= (i) && (i) < 0200)
#define iscntrl(c)	((ctftab+1)[c]&(CTF_CTL))
#define iscsym(c)	((ctftab+1)[c]&(CTF_UA|CTF_LA|CTF_N|CTF_US))
#define iscsymf(c)	((ctftab+1)[c]&(CTF_UA|CTF_LA|CTF_US))
#define isdigit(c)	((ctftab+1)[c]&(CTF_N))
#define isgraph(c)	((ctftab+1)[c]&(CTF_PUN|CTF_N|CTF_UA|CTF_LA))
#define islower(c)	((ctftab+1)[c]&(CTF_LA))
#define isodigit(c)	((ctftab+1)[c]&(CTF_NO))
#define isprint(c)	((ctftab+1)[c]&(CTF_PUN|CTF_N|CTF_UA|CTF_LA|CTF_SP))
#define ispunct(c)	((ctftab+1)[c]&(CTF_PUN|CTF_SP))
#define isspace(c)	((ctftab+1)[c]&(CTF_WSP))
#define isupper(c)	((ctftab+1)[c]&(CTF_UA))
#define isxdigit(c)	((ctftab+1)[c]&(CTF_N|CTF_X))
#define toascii(i)	((c)&0177)
#define toint(c)	chr2in(c)
#define tolower(c)	chr2lo(c)
#define toupper(c)	chr2up(c)
#define _tolower(c)	((c)+('a'-'A'))
#define _toupper(c)	((c)+('A'-'a'))

/* These functions are peculiar to KCC.
 *	iscwsp - true if char is a C language whitespace char
 *	ischwsp - true if char is a C language whitespace char, but not \n
 *	iscppwsp - true if char is a C preprocessor directive whitespace char
 *	isceol - true if char is a C language line-break char
 *	setcsym - Set flag to allow char as a C language identifier char
 *	clrcsym - Clear flag to disallow char as a C language identifier char
 *		The latter two are special hacks only for use by CCDECL when
 *		trying to parse "entry" statements.
 *	tosixbit - Convert an ASCII char to its SIXBIT equivalent (if any)
 */
#define iscwsp(c)	((ctftab+1)[c]&(CTF_WSP))
#define ischwsp(c)	((ctftab+1)[c]&(CTF_HSP))
#define iscppwsp(c)	((ctftab+1)[c]&(CTF_SP|CTF_TAB))
#define isceol(c)	((ctftab+1)[c]&(CTF_EOL))
#define isvowel(c)	((ctftab+1)[c]&(CTF_VWL))
#define setcsym(c)	((ctftab+1)[c] |= (CTF_US))	/* Special hack */
#define clrcsym(c)	((ctftab+1)[c] &= ~(CTF_US))	/* Special hack */
#define tosixbit(c) ((((c) & 0100) ? (c)|040 : (c)&~040)&077) /* Cvt to SIXBIT */

#ifdef __STDC__
#define P_(a) a
#else
#define P_(a) ()
#endif

extern int chr2in P_((int c));
extern int chr2lo P_((int c));
extern int chr2up P_((int c));

#undef P_

#ifndef CHARTABLE
extern int ctftab[];
#else

int ctftab[] = {
	0,		/* ( -1) EOF */
	CTF_CTL,	/* (  0)  ^@ */
	CTF_CTL,	/* (  1)  ^A */
	CTF_CTL,	/* (  2)  ^B */
	CTF_CTL,	/* (  3)  ^C */
	CTF_CTL,	/* (  4)  ^D */
	CTF_CTL,	/* (  5)  ^E */
	CTF_CTL,	/* (  6)  ^F */
	CTF_CTL,	/* (  7)  ^G */
	CTF_CTL|CTF_BS,			/* ( 10)  ^H BackSpace */
	CTF_CTL|CTF_WSP|CTF_HSP|CTF_TAB,/* ( 11)  ^I Horizontal Tab */
	CTF_CTL|CTF_WSP|CTF_EOL,	/* ( 12)  ^J NewLine */
	CTF_CTL|CTF_WSP|CTF_HSP,	/* ( 13)  ^K Vertical Tab */
	CTF_CTL|CTF_WSP|CTF_HSP,	/* ( 14)  ^L Form Feed */
	CTF_CTL|CTF_WSP|CTF_HSP,	/* ( 15)  ^M Carriage Return */
	CTF_CTL,	/* ( 16)  ^N */
	CTF_CTL,	/* ( 17)  ^O */
	CTF_CTL,	/* ( 20)  ^P */
	CTF_CTL,	/* ( 21)  ^Q */
	CTF_CTL,	/* ( 22)  ^R */
	CTF_CTL,	/* ( 23)  ^S */
	CTF_CTL,	/* ( 24)  ^T */
	CTF_CTL,	/* ( 25)  ^U */
	CTF_CTL,	/* ( 26)  ^V */
	CTF_CTL,	/* ( 27)  ^W */
	CTF_CTL,	/* ( 30)  ^X */
	CTF_CTL,	/* ( 31)  ^Y */
	CTF_CTL,	/* ( 32)  ^Z */
	CTF_CTL,	/* ( 33)  ^[ */
	CTF_CTL,	/* ( 34)  ^\ */
	CTF_CTL,	/* ( 35)  ^] */
	CTF_CTL,	/* ( 36)  ^^ */
	CTF_CTL,	/* ( 37)  ^_ */
	CTF_SP|CTF_WSP|CTF_HSP,		/* ( 40)     Space */
	CTF_PUN,	/* ( 41)   ! */
	CTF_PUN,	/* ( 42)   " */
	CTF_PUN,	/* ( 43)   # */
	CTF_PUN,	/* ( 44)   $ */
	CTF_PUN,	/* ( 45)   % */
	CTF_PUN,	/* ( 46)   & */
	CTF_PUN,	/* ( 47)   ' */
	CTF_PUN,	/* ( 50)   ( */
	CTF_PUN,	/* ( 51)   ) */
	CTF_PUN,	/* ( 52)   * */
	CTF_PUN,	/* ( 53)   + */
	CTF_PUN,	/* ( 54)   , */
	CTF_PUN,	/* ( 55)   - */
	CTF_PUN,	/* ( 56)   . */
	CTF_PUN,	/* ( 57)   / */
	CTF_N|CTF_X|CTF_NO,	/* ( 60)   0 */
	CTF_N|CTF_X|CTF_NO,	/* ( 61)   1 */
	CTF_N|CTF_X|CTF_NO,	/* ( 62)   2 */
	CTF_N|CTF_X|CTF_NO,	/* ( 63)   3 */
	CTF_N|CTF_X|CTF_NO,	/* ( 64)   4 */
	CTF_N|CTF_X|CTF_NO,	/* ( 65)   5 */
	CTF_N|CTF_X|CTF_NO,	/* ( 66)   6 */
	CTF_N|CTF_X|CTF_NO,	/* ( 67)   7 */
	CTF_N|CTF_X,		/* ( 70)   8 */
	CTF_N|CTF_X,		/* ( 71)   9 */
	CTF_PUN,	/* ( 72)   : */
	CTF_PUN,	/* ( 73)   ; */
	CTF_PUN,	/* ( 74)   < */
	CTF_PUN,	/* ( 75)   = */
	CTF_PUN,	/* ( 76)   > */
	CTF_PUN,	/* ( 77)   ? */
	CTF_PUN,	/* (100)   @ */
	CTF_UA|CTF_X|CTF_VWL,	/* (101)   A */
	CTF_UA|CTF_X,		/* (102)   B */
	CTF_UA|CTF_X,		/* (103)   C */
	CTF_UA|CTF_X,		/* (104)   D */
	CTF_UA|CTF_X|CTF_VWL,	/* (105)   E */
	CTF_UA|CTF_X,		/* (106)   F */
	CTF_UA,			/* (107)   G */
	CTF_UA,			/* (110)   H */
	CTF_UA|CTF_VWL,		/* (111)   I */
	CTF_UA,		/* (112)   J */
	CTF_UA,		/* (113)   K */
	CTF_UA,		/* (114)   L */
	CTF_UA,		/* (115)   M */
	CTF_UA,		/* (116)   N */
	CTF_UA|CTF_VWL,		/* (117)   O */
	CTF_UA,		/* (120)   P */
	CTF_UA,		/* (121)   Q */
	CTF_UA,		/* (122)   R */
	CTF_UA,		/* (123)   S */
	CTF_UA,		/* (124)   T */
	CTF_UA|CTF_VWL,		/* (125)   U */
	CTF_UA,		/* (126)   V */
	CTF_UA,		/* (127)   W */
	CTF_UA,		/* (130)   X */
	CTF_UA,		/* (131)   Y */
	CTF_UA,		/* (132)   Z */
	CTF_PUN,	/* (133)   [ */
	CTF_PUN,	/* (134)   \ */
	CTF_PUN,	/* (135)   ] */
	CTF_PUN,	/* (136)   ^ */
	CTF_PUN|CTF_US,	/* (137)   _ */
	CTF_PUN,	/* (140)   ` */
	CTF_LA|CTF_X|CTF_VWL,	/* (141)   a */
	CTF_LA|CTF_X,	/* (142)   b */
	CTF_LA|CTF_X,	/* (143)   c */
	CTF_LA|CTF_X,	/* (144)   d */
	CTF_LA|CTF_X|CTF_VWL,	/* (145)   e */
	CTF_LA|CTF_X,	/* (146)   f */
	CTF_LA,		/* (147)   g */
	CTF_LA,		/* (150)   h */
	CTF_LA|CTF_VWL,		/* (151)   i */
	CTF_LA,		/* (152)   j */
	CTF_LA,		/* (153)   k */
	CTF_LA,		/* (154)   l */
	CTF_LA,		/* (155)   m */
	CTF_LA,		/* (156)   n */
	CTF_LA|CTF_VWL,		/* (157)   o */
	CTF_LA,		/* (160)   p */
	CTF_LA,		/* (161)   q */
	CTF_LA,		/* (162)   r */
	CTF_LA,		/* (163)   s */
	CTF_LA,		/* (164)   t */
	CTF_LA|CTF_VWL,		/* (165)   u */
	CTF_LA,		/* (166)   v */
	CTF_LA,		/* (167)   w */
	CTF_LA,		/* (170)   x */
	CTF_LA,		/* (171)   y */
	CTF_LA,		/* (172)   z */
	CTF_PUN,	/* (173)   { */
	CTF_PUN,	/* (174)   | */
	CTF_PUN,	/* (175)   } */
	CTF_PUN,	/* (176)   ~ */
	CTF_CTL,	/* (177) DEL */
};

/* CHR2IN - Implements TOINT(c) facility. */
int
chr2in(c)
char c;
{
    if (isdigit(c)) return c - '0';
    if (isxdigit(c))
	return (isupper(c) ? (c - ('A'-10)) : (c - ('a'-10)));
    return -1;
}

/* CHR2LO - Implements TOLOWER(c) facility */
int
chr2lo(c)
char c;
{	return (isupper(c) ? _tolower(c) : c);
}

/* CHR2UP - Implements TOUPPER(c) facility */
int
chr2up(c)
char c;
{	return (islower(c) ? _toupper(c) : c);
}

#endif /* CHARTABLE */
    