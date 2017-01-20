/*
**	LOCALE.C - Localization routines (new for ANSI C)
**
**	(c) Copyright Ken Harrenstien 1989
**
** This routine conforms to the draft proposed ANSI C standard as of
** 7-Dec-1988.
**
** No locales other than "C" and "" are implemented, and the two are
** equivalent.
*/

#include <limits.h>
#include <locale.h>
#include <string.h>

#if __STDC__
#define CONST const
#else
#define CONST
#endif

struct lconv _locale;

char *
setlocale(category, locale)
int category;
CONST char *locale;
{
    /* Determine locale */
    if (!locale || !*locale || strcmp(locale, "C")==0)
	locale = "C";
    else return NULL;

    /* Handle category */
    switch (category) {
	default: return NULL;
	case LC_ALL:	case LC_COLLATE:	case LC_CTYPE:
	case LC_MONETARY: case LC_NUMERIC:	case LC_TIME:
	    break;
    }
    return (char *)locale;
}

struct lconv *
localeconv()
{
    _locale.decimal_point	= ".";
    _locale.thousands_sep	= "";
    _locale.grouping		= "";
    _locale.int_curr_symbol	= "";
    _locale.currency_symbol	= "";
    _locale.mon_decimal_point	= "";
    _locale.mon_thousands_sep	= "";
    _locale.mon_grouping	= "";
    _locale.positive_sign	= "";
    _locale.negative_sign	= "";
    _locale.int_frac_digits	= CHAR_MAX;
    _locale.frac_digits		= CHAR_MAX;
    _locale.p_cs_precedes	= CHAR_MAX;
    _locale.p_sep_by_space	= CHAR_MAX;
    _locale.n_cs_precedes	= CHAR_MAX;
    _locale.n_sep_by_space	= CHAR_MAX;
    _locale.p_sign_posn		= CHAR_MAX;
    _locale.n_sign_posn		= CHAR_MAX;

    return &_locale;
}
