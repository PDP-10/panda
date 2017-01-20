/*
**	MBCHAR.C - Multibyte character and string functions (per ANSI)
**
**	(c) Copyright Ken Harrenstien 1989
**
** These routines conform to the draft proposed ANSI C standard as of
** 7-Dec-1988.
**
** Since we have no need to support multi-byte characters or strings at all, we
** just treat them exactly the same as regular C strings.
*/

#include <stdlib.h>

#if __STDC__
#define CONST const
#else
#define CONST
#endif

/* Multibyte Character functions */

int
mblen(s, n)
CONST char *s;
size_t n;
{
    if (!s || !n)
	return 0;	/* No state-dependent encodings, or empty char */
    return *s ? 1 : 0;
}

int
mbtowc(pwc, s, n)
wchar_t *pwc;
CONST char *s;
size_t n;
{
    if (!s || !n)
	return 0;	/* No state-dependent encodings, or empty char */
    if (pwc) *pwc = *s;
    return *s ? 1 : 0;
}

#if __STDC__	/* Must use proto to avoid default arg promo for wchar */
int wctomb(char *s, wchar_t wchar)
#else
int
wctomb(s, wchar)
char *s;
wchar_t wchar;
#endif
{
    if (!s)
	return 0;	/* No state-dependent encodings */
    *s = wchar;
    return 1;
}


/* Multibyte String functions */

size_t
mbstowcs(pwcs, s, n)
wchar_t *pwcs;
CONST char *s;
size_t n;
{
    register int i;
    if (!pwcs || !s)
	return -1;		/* Error */
    for (i = n; i > 0 && (*pwcs++ = *s++); --i);
    return n - i;
}

size_t
wcstombs(s, pwcs, n)
char *s;
CONST wchar_t *pwcs;
size_t n;
{
    register int i;
    if (!pwcs || !s)
	return -1;		/* Error */
    for (i = n; i > 0 && (*s++ = *pwcs++); --i);
    return n - i;
}
