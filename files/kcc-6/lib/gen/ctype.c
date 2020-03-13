/* CTYPE.C - Character processing facility support
**
**	(c) Copyright Ken Harrenstien 1989
**	(c) Copyright Ken Harrenstien, SRI International 1985
**
**	This file, plus <ctype.h>, implements all of the character
** handling facilities in the draft proposed ANSI C standard.
**	It also supports extensions that conform to the facilities described
** in "C: A Reference Manual" (Harbison & Steele, 1984), section 11.1
** except for ispunct() which does NOT include space.  Neither BSD nor
** the ANSI C draft does, so we don't either, and assume H&S is wrong.
**
** Portability considerations: this table is for ASCII only.
*/

#include <limits.h>		/* For char size */
#include <ctype.h>

/* ANSI requires that real functions exist for all facilities, even if
** macros exist, in case user #undefs them or wants their address.
*/

#if __STDC__		/* Pre-ANSI compiler would barf on "(macro)" syntax */

int (isalnum)(c)	{ return isalnum(c); }
int (isalpha)(c)	{ return isalpha(c); }
int (isascii)(i)	{ return isascii(i); }
int (iscntrl)(c)	{ return iscntrl(c); }
int (iscsym) (c)	{ return iscsym(c); }
#if 0
int (iscsymf)(c)	{ return iscsymf(c); }
#endif
int (isdigit)(c)	{ return isdigit(c); }
int (isgraph)(c)	{ return isgraph(c); }
int (islower)(c)	{ return islower(c); }
int (isodigit)(c)	{ return isodigit(c); }
int (isprint)(c)	{ return isprint(c); }
int (ispunct)(c)	{ return ispunct(c); }
int (isspace)(c)	{ return isspace(c); }
int (isupper)(c)	{ return isupper(c); }
int (isxdigit)(c)	{ return isxdigit(c); }
int (toascii) (i)	{ return toascii(i); }
int (_tolower)(c)	{ return _tolower(c); }
int (_toupper)(c)	{ return _toupper(c); }

#endif

int (tolower)(c) { return (isupper(c) ? _tolower(c) : c); }
int (toupper)(c) { return (islower(c) ? _toupper(c) : c); }

int (toint)(c)
{
    return (isdigit(c) ? (c - '0')
	: (isalpha(c) ? (isupper(c) ? (c - ('A'-10)) : (c - ('a'-10)))
			: -1));
}

/* Conditionalize addition of Group 2 flags into 1st table */
#ifdef _CT_TABTYPE	/* If we'll use just one array */
#define _CT_2O _CT_O	/* Then make these flags be something */
#define _CT_2X _CT_X
#else			/* otherwise don't include them in 1st array */
#define _CT_2O 0
#define _CT_2X 0
#endif

#ifdef _CT_TABTYPE	/* Specify type for flag array */
_CT_TABTYPE		/* Use single array of this type */
#else
char			/* Else two arrays, this holds Group 1 flags */
#endif
	_ctyp1[1+(UCHAR_MAX+1)] =
{	0,		/* ( -1) EOF */
	_CT_CTL,	/* (  0)  ^@ */
	_CT_CTL,	/* (  1)  ^A */
	_CT_CTL,	/* (  2)  ^B */
	_CT_CTL,	/* (  3)  ^C */
	_CT_CTL,	/* (  4)  ^D */
	_CT_CTL,	/* (  5)  ^E */
	_CT_CTL,	/* (  6)  ^F */
	_CT_CTL,	/* (  7)  ^G */
	_CT_CTL,	/* ( 10)  ^H */
	_CT_CTL|_CT_WSP,	/* ( 11)  ^I Horizontal Tab */
	_CT_CTL|_CT_WSP,	/* ( 12)  ^J NewLine */
	_CT_CTL|_CT_WSP,	/* ( 13)  ^K Vertical Tab */
	_CT_CTL|_CT_WSP,	/* ( 14)  ^L Form Feed */
	_CT_CTL|_CT_WSP,	/* ( 15)  ^M Carriage Return */
	_CT_CTL,	/* ( 16)  ^N */
	_CT_CTL,	/* ( 17)  ^O */
	_CT_CTL,	/* ( 20)  ^P */
	_CT_CTL,	/* ( 21)  ^Q */
	_CT_CTL,	/* ( 22)  ^R */
	_CT_CTL,	/* ( 23)  ^S */
	_CT_CTL,	/* ( 24)  ^T */
	_CT_CTL,	/* ( 25)  ^U */
	_CT_CTL,	/* ( 26)  ^V */
	_CT_CTL,	/* ( 27)  ^W */
	_CT_CTL,	/* ( 30)  ^X */
	_CT_CTL,	/* ( 31)  ^Y */
	_CT_CTL,	/* ( 32)  ^Z */
	_CT_CTL,	/* ( 33)  ^[ */
	_CT_CTL,	/* ( 34)  ^\ */
	_CT_CTL,	/* ( 35)  ^] */
	_CT_CTL,	/* ( 36)  ^^ */
	_CT_CTL,	/* ( 37)  ^_ */
	_CT_SP|_CT_WSP,	/* ( 40)     Space */
	_CT_PUN,	/* ( 41)   ! */
	_CT_PUN,	/* ( 42)   " */
	_CT_PUN,	/* ( 43)   # */
	_CT_PUN,	/* ( 44)   $ */
	_CT_PUN,	/* ( 45)   % */
	_CT_PUN,	/* ( 46)   & */
	_CT_PUN,	/* ( 47)   ' */
	_CT_PUN,	/* ( 50)   ( */
	_CT_PUN,	/* ( 51)   ) */
	_CT_PUN,	/* ( 52)   * */
	_CT_PUN,	/* ( 53)   + */
	_CT_PUN,	/* ( 54)   , */
	_CT_PUN,	/* ( 55)   - */
	_CT_PUN,	/* ( 56)   . */
	_CT_PUN,	/* ( 57)   / */
	_CT_N|_CT_2X|_CT_2O,	/* ( 60)   0 */
	_CT_N|_CT_2X|_CT_2O,	/* ( 61)   1 */
	_CT_N|_CT_2X|_CT_2O,	/* ( 62)   2 */
	_CT_N|_CT_2X|_CT_2O,	/* ( 63)   3 */
	_CT_N|_CT_2X|_CT_2O,	/* ( 64)   4 */
	_CT_N|_CT_2X|_CT_2O,	/* ( 65)   5 */
	_CT_N|_CT_2X|_CT_2O,	/* ( 66)   6 */
	_CT_N|_CT_2X|_CT_2O,	/* ( 67)   7 */
	_CT_N|_CT_2X,		/* ( 70)   8 */
	_CT_N|_CT_2X,		/* ( 71)   9 */
	_CT_PUN,	/* ( 72)   : */
	_CT_PUN,	/* ( 73)   ; */
	_CT_PUN,	/* ( 74)   < */
	_CT_PUN,	/* ( 75)   = */
	_CT_PUN,	/* ( 76)   > */
	_CT_PUN,	/* ( 77)   ? */
	_CT_PUN,	/* (100)   @ */
	_CT_UA|_CT_2X,	/* (101)   A */
	_CT_UA|_CT_2X,	/* (102)   B */
	_CT_UA|_CT_2X,	/* (103)   C */
	_CT_UA|_CT_2X,	/* (104)   D */
	_CT_UA|_CT_2X,	/* (105)   E */
	_CT_UA|_CT_2X,	/* (106)   F */
	_CT_UA,		/* (107)   G */
	_CT_UA,		/* (110)   H */
	_CT_UA,		/* (111)   I */
	_CT_UA,		/* (112)   J */
	_CT_UA,		/* (113)   K */
	_CT_UA,		/* (114)   L */
	_CT_UA,		/* (115)   M */
	_CT_UA,		/* (116)   N */
	_CT_UA,		/* (117)   O */
	_CT_UA,		/* (120)   P */
	_CT_UA,		/* (121)   Q */
	_CT_UA,		/* (122)   R */
	_CT_UA,		/* (123)   S */
	_CT_UA,		/* (124)   T */
	_CT_UA,		/* (125)   U */
	_CT_UA,		/* (126)   V */
	_CT_UA,		/* (127)   W */
	_CT_UA,		/* (130)   X */
	_CT_UA,		/* (131)   Y */
	_CT_UA,		/* (132)   Z */
	_CT_PUN,	/* (133)   [ */
	_CT_PUN,	/* (134)   \ */
	_CT_PUN,	/* (135)   ] */
	_CT_PUN,	/* (136)   ^ */
	_CT_PUN|_CT_USC,	/* (137)   _ */
	_CT_PUN,	/* (140)   ` */
	_CT_LA|_CT_2X,	/* (141)   a */
	_CT_LA|_CT_2X,	/* (142)   b */
	_CT_LA|_CT_2X,	/* (143)   c */
	_CT_LA|_CT_2X,	/* (144)   d */
	_CT_LA|_CT_2X,	/* (145)   e */
	_CT_LA|_CT_2X,	/* (146)   f */
	_CT_LA,		/* (147)   g */
	_CT_LA,		/* (150)   h */
	_CT_LA,		/* (151)   i */
	_CT_LA,		/* (152)   j */
	_CT_LA,		/* (153)   k */
	_CT_LA,		/* (154)   l */
	_CT_LA,		/* (155)   m */
	_CT_LA,		/* (156)   n */
	_CT_LA,		/* (157)   o */
	_CT_LA,		/* (160)   p */
	_CT_LA,		/* (161)   q */
	_CT_LA,		/* (162)   r */
	_CT_LA,		/* (163)   s */
	_CT_LA,		/* (164)   t */
	_CT_LA,		/* (165)   u */
	_CT_LA,		/* (166)   v */
	_CT_LA,		/* (167)   w */
	_CT_LA,		/* (170)   x */
	_CT_LA,		/* (171)   y */
	_CT_LA,		/* (172)   z */
	_CT_PUN,	/* (173)   { */
	_CT_PUN,	/* (174)   | */
	_CT_PUN,	/* (175)   } */
	_CT_PUN,	/* (176)   ~ */
	_CT_CTL,	/* (177) DEL */
};

/* Group 2 flag table.  Only compiled if necessary.
**	Note that the only flags actually referenced from this table
** are _CT_O and _CT_X.
*/
#ifndef _CT_TABTYPE
char _ctyp2[1+(UCHAR_MAX+1)] =
{	0,	/* ( -1) EOF */
	0,	/* (  0)  ^@ */
	0,	/* (  1)  ^A */
	0,	/* (  2)  ^B */
	0,	/* (  3)  ^C */
	0,	/* (  4)  ^D */
	0,	/* (  5)  ^E */
	0,	/* (  6)  ^F */
	0,	/* (  7)  ^G */
	0,	/* ( 10)  ^H */
	0,	/* ( 11)  ^I Horizontal Tab */
	0,	/* ( 12)  ^J NewLine */
	0,	/* ( 13)  ^K Vertical Tab */
	0,	/* ( 14)  ^L Form Feed */
	0,	/* ( 15)  ^M Carriage Return */
	0,	/* ( 16)  ^N */
	0,	/* ( 17)  ^O */
	0,	/* ( 20)  ^P */
	0,	/* ( 21)  ^Q */
	0,	/* ( 22)  ^R */
	0,	/* ( 23)  ^S */
	0,	/* ( 24)  ^T */
	0,	/* ( 25)  ^U */
	0,	/* ( 26)  ^V */
	0,	/* ( 27)  ^W */
	0,	/* ( 30)  ^X */
	0,	/* ( 31)  ^Y */
	0,	/* ( 32)  ^Z */
	0,	/* ( 33)  ^[ */
	0,	/* ( 34)  ^\ */
	0,	/* ( 35)  ^] */
	0,	/* ( 36)  ^^ */
	0,	/* ( 37)  ^_ */
	0,	/* ( 40)     Space */
	0,	/* ( 41)   ! */
	0,	/* ( 42)   " */
	0,	/* ( 43)   # */
	0,	/* ( 44)   $ */
	0,	/* ( 45)   % */
	0,	/* ( 46)   & */
	0,	/* ( 47)   ' */
	0,	/* ( 50)   ( */
	0,	/* ( 51)   ) */
	0,	/* ( 52)   * */
	0,	/* ( 53)   + */
	0,	/* ( 54)   , */
	0,	/* ( 55)   - */
	0,	/* ( 56)   . */
	0,	/* ( 57)   / */
	_CT_X|_CT_O,	/* ( 60)   0 */
	_CT_X|_CT_O,	/* ( 61)   1 */
	_CT_X|_CT_O,	/* ( 62)   2 */
	_CT_X|_CT_O,	/* ( 63)   3 */
	_CT_X|_CT_O,	/* ( 64)   4 */
	_CT_X|_CT_O,	/* ( 65)   5 */
	_CT_X|_CT_O,	/* ( 66)   6 */
	_CT_X|_CT_O,	/* ( 67)   7 */
	_CT_X,		/* ( 70)   8 */
	_CT_X,		/* ( 71)   9 */
	0,	/* ( 72)   : */
	0,	/* ( 73)   ; */
	0,	/* ( 74)   < */
	0,	/* ( 75)   = */
	0,	/* ( 76)   > */
	0,	/* ( 77)   ? */
	0,	/* (100)   @ */
	_CT_X,	/* (101)   A */
	_CT_X,	/* (102)   B */
	_CT_X,	/* (103)   C */
	_CT_X,	/* (104)   D */
	_CT_X,	/* (105)   E */
	_CT_X,	/* (106)   F */
	0,	/* (107)   G */
	0,	/* (110)   H */
	0,	/* (111)   I */
	0,	/* (112)   J */
	0,	/* (113)   K */
	0,	/* (114)   L */
	0,	/* (115)   M */
	0,	/* (116)   N */
	0,	/* (117)   O */
	0,	/* (120)   P */
	0,	/* (121)   Q */
	0,	/* (122)   R */
	0,	/* (123)   S */
	0,	/* (124)   T */
	0,	/* (125)   U */
	0,	/* (126)   V */
	0,	/* (127)   W */
	0,	/* (130)   X */
	0,	/* (131)   Y */
	0,	/* (132)   Z */
	0,	/* (133)   [ */
	0,	/* (134)   \ */
	0,	/* (135)   ] */
	0,	/* (136)   ^ */
	0,	/* (137)   _ */
	0,	/* (140)   ` */
	_CT_X,	/* (141)   a */
	_CT_X,	/* (142)   b */
	_CT_X,	/* (143)   c */
	_CT_X,	/* (144)   d */
	_CT_X,	/* (145)   e */
	_CT_X,	/* (146)   f */
	0,	/* (147)   g */
	0,	/* (150)   h */
	0,	/* (151)   i */
	0,	/* (152)   j */
	0,	/* (153)   k */
	0,	/* (154)   l */
	0,	/* (155)   m */
	0,	/* (156)   n */
	0,	/* (157)   o */
	0,	/* (160)   p */
	0,	/* (161)   q */
	0,	/* (162)   r */
	0,	/* (163)   s */
	0,	/* (164)   t */
	0,	/* (165)   u */
	0,	/* (166)   v */
	0,	/* (167)   w */
	0,	/* (170)   x */
	0,	/* (171)   y */
	0,	/* (172)   z */
	0,	/* (173)   { */
	0,	/* (174)   | */
	0,	/* (175)   } */
	0,	/* (176)   ~ */
	0,	/* (177) DEL */
};
#endif		/* End of ifndef _CT_TABTYPE (Group 2 table) */
