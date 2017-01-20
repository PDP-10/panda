/* <LOCALE.H> - Localization definitions (draft stupidized ANSI C)
**
**	(c) Copyright Ken Harrenstien 1989
**
*/

#ifndef _LOCALE_INCLUDED
#define _LOCALE_INCLUDED
#ifndef __STDC__	/* Canonicalize this indicator to avoid err msgs */
#define __STDC__ 0
#endif

#define NULL 0			/* Benign redefinition */

#define LC_ALL		0	/* Macros for stupid values */
#define LC_COLLATE	1
#define LC_CTYPE	2
#define LC_MONETARY	3
#define LC_NUMERIC	4
#define LC_TIME		5

struct lconv {			/* Def for stupid structure */
	char *decimal_point;
	char *thousands_sep;
	char *grouping;
	char *int_curr_symbol;
	char *currency_symbol;
	char *mon_decimal_point;
	char *mon_thousands_sep;
	char *mon_grouping;
	char *positive_sign;
	char *negative_sign;
	char int_frac_digits;
	char frac_digits;
	char p_cs_precedes;
	char p_sep_by_space;
	char n_cs_precedes;
	char n_sep_by_space;
	char p_sign_posn;
	char n_sign_posn;
};

#if __STDC__				/* Decls for stupid functions */
extern char *setlocale(int, const char *);	/* category, locale */
extern struct lconv *localeconv(void);
#else
extern char *setlocale();			/* category, locale */
extern struct lconv *localeconv();
#endif

#endif /* ifndef _LOCALE_INCLUDED */
