/*
**	STRUNG	- case independent string manipulation routines
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.9, 1-Jul-1988
**	(c) Copyright Ian Macky, SRI International 1986
**
**	these string functions behave the same as their case dependent
**	bretheren, return the same values, etc.  they have the same names,
**	except that the function-describing part is in caps, e.g. "strCMP"
**	as the replacement for "strcmp".
*/

#include <string.h>
#include <strung.h>
#include <ctype.h>

/* ------------------------------------------------*/
/* strCMP - compare two strings case insensitively */
/* ------------------------------------------------*/

int strCMP(s1, s2)
char *s1, *s2;
{
    register int c1, c2;

    for (;;) {
	if (isupper(c1 = *s1))
	  c1 = tolower(c1);
	if (isupper(c2 = *s2))
	  c2 = tolower(c2);
	if (c1 != c2)
	  return c1 - c2;
	if (c1 == '\0') return 0;
	s1++;
	s2++;
    }
}

/* --------------------------------------------*/
/* strnCMP - compare n chars of two strings    */
/* --------------------------------------------*/

int strnCMP(s1, s2, n)
char *s1, *s2;
{
    register int c1, c2;

    while (--n >= 0) {
	if (isupper(c1 = *s1))
	  c1 = tolower(c1);
	if (isupper(c2 = *s2))
	  c2 = tolower(c2);
	if (c1 != c2)
	  return c1 - c2;
	if (!c1) return 0;
	s1++;
	s2++;
    }
    return 0;
}

/* ------------------------------------------------ */
/* strCHR - find first occurrence of char in string */
/* ------------------------------------------------ */

char *strCHR(s, c)
char *s;
{
    int d;

    c = toupper(c);			/* uppercase search char */
    for (d = toupper(*s); d; d = toupper(*++s))
	if (c == d) return s;
    return 0;
}

/*
 *	strSTR - substring search.  search for first occurance of s2
 *	in s1.
 */

char *strSTR(s1, s2)
char *s1, *s2;
{
    int n, c;
    char *p;

    n = strlen(s2);
    if (!n) return s1;
    c = *s2;				/* first char of substring */
    for (p = strCHR(s1, c); p; p = strCHR(++s1, c))
	if (!strnCMP(p, s2, n)) return p;
    return 0;
}

/*
 *	memCMP() - compare sequential bytes
 */

int memCMP(s1, s2, len)
char *s1, *s2;
int len;
{
    register char c1, c2;

    while (--len >= 0) {
	if (isupper(c1 = *s1++))
	    c1 = tolower(c1);
	if (isupper(c2 = *s2++))
	    c2 = tolower(c2);
	if (c1 != c2)
	    return c1 - c2;
    }
    return 0;
}
