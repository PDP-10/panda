/* <CTYPE.H> - Character processing facility definitions
**
**	(c) Copyright Ken Harrenstien 1989
**	(c) Copyright Ken Harrenstien, SRI International 1985
**
**	These definitions, plus ctype.c, conform to the descriptions
** in the draft proposed ANSI C standard.
**	There are also some extensions that conform to the description
** in "C: A Reference Manual" (Harbison & Steele, 1984 section 11.1)
** also (v2 1987 section 14).  Note that CARM's description of ispunct()
** is wrong (it shouldn't include the space char; neither BSD nor ANSI do,
** and we don't either).
**	These extensions are:
**		isascii, iscsym, iscsymf, isodigit
**		toascii, toint, _tolower, _toupper
**
** Portability considerations:
**	Most of these facilities work for any run-time character set.
**	The following facilities do depend on the run-time character set,
**	but will work for both ASCII and EBCDIC:
**					isodigit, toint, _toupper, _tolower
**	Meaningful only with ASCII:	isascii, toascii
**
** Compatibility with 4.2BSD:
**	4.2BSD does not have:	iscsym, iscsymf, isgraph, isodigit, toint
**	And these act differently:	iscntrl, tolower, toupper
*/

#ifndef _CTYPE_INCLUDED
#define _CTYPE_INCLUDED

/* Table Type option:
**	On machines (such as the PDP-10) which use word addressing,
**	declaring the table as an array of integers is much more efficient.
**	To use a character array, just don't define this macro.
*/
#define _CT_TABTYPE int		/* Use integer array */

/* Define internal character type flags.  No more than 16 altogether are
** allowed, for portability.  Note that flags must come in two functional
** groups to allow separation into 2 char arrays; the second group
** is used for flags which are self-contained (not used in combination).
*/
/* Group 1 flags.  These are interdependent except where noted. */
#define _CT_SP	01	/* Space */
#define _CT_PUN	02	/* Punctuation (non-space, non-alphanumeric) */
#define _CT_N	04	/* Numeric (decimal digit) 0-9 */
#define _CT_UA	010	/* Uppercase alpha */
#define _CT_LA	020	/* Lowercase alpha */
#define _CT_USC	040	/* Underscore */
#define _CT_WSP 0100	/* (Could be in group 2) Whitespace */
#define _CT_CTL 0200	/* (Could be in group 2) Control char */

/* Group 2 flags.  These may be in a separate lookup table. */
#ifdef _CT_TABTYPE
#define _CT_O	0400		/* (Group 2) Octal digit 0-7 */
#define _CT_X	01000		/* (Group 2) Hex digit 0-9, A-F */
#define _ctyp2 _ctyp1		/* Use single table */
extern _CT_TABTYPE _ctyp1[];	/* Single flag array */
#else
#define _CT_O	01		/* (Group 2) Octal digit 0-7 */
#define _CT_X	02		/* (Group 2) Hex digit 0-9, A-F */
extern char _ctyp1[], _ctyp2[];	/* Two flag arrays */
#endif

/* Facility macros, in alphabetical order */

#define isalnum(c)	((_ctyp1+1)[c]&(_CT_UA|_CT_LA|_CT_N))
#define isalpha(c)	((_ctyp1+1)[c]&(_CT_UA|_CT_LA))
#define isascii(i)	(!((unsigned)(i)&(~0177)))
#define iscntrl(c)	((_ctyp1+1)[c]&(_CT_CTL))
#define iscsym(c)	((_ctyp1+1)[c]&(_CT_UA|_CT_LA|_CT_USC|_CT_N))
#define iscsymf(c)	((_ctyp1+1)[c]&(_CT_UA|_CT_LA|_CT_USC))
#define isdigit(c)	((_ctyp1+1)[c]&(_CT_N))
#define isgraph(c)	((_ctyp1+1)[c]&(_CT_PUN|_CT_N|_CT_UA|_CT_LA))
#define islower(c)	((_ctyp1+1)[c]&(_CT_LA))
#define isodigit(c)	((_ctyp2+1)[c]&(_CT_O))		/* Group 2 */
#define isprint(c)	((_ctyp1+1)[c]&(_CT_PUN|_CT_N|_CT_UA|_CT_LA|_CT_SP))
#define ispunct(c)	((_ctyp1+1)[c]&(_CT_PUN))
#define isspace(c)	((_ctyp1+1)[c]&(_CT_WSP))
#define isupper(c)	((_ctyp1+1)[c]&(_CT_UA))
#define isxdigit(c)	((_ctyp2+1)[c]&(_CT_X))		/* Group 2 */
#define toascii(i)	((i)&0177)
#if 0 /* Functions, to avoid double eval of arg */
#define toint	toint
#define tolower	tolower
#define toupper	toupper
#endif
#define _tolower(c)	((c)+('a'-'A'))
#define _toupper(c)	((c)-('a'-'A'))

#ifndef __STDC__	/* Canonicalize to avoid err msgs */
#define __STDC__ 0
#endif
#if __STDC__		/* ANSI only */

/* Function declarations, in case user #undefs anything (sigh) */
extern int
	(isalnum)(int), (isalpha)(int), (isascii)(int), (iscntrl)(int),
	(iscsym)(int),
#if 0
	(iscsymf)(int),		/* Cannot be undefed, external name conflict */
#endif
	(isdigit)(int), (isgraph)(int),
	(islower)(int), (isodigit)(int),(isprint)(int), (ispunct)(int),
	(isspace)(int), (isupper)(int), (isxdigit)(int),
	(toascii)(int), (toint)(int),   (tolower)(int), (toupper)(int),
	(_tolower)(int), (_toupper)(int);
#else /* not __STDC__ */

extern int toint(), tolower(), toupper();

#endif	/* not __STDC__ */

#endif /* ifndef _CTYPE_INCLUDED */
