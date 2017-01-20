/*
 *	GETS - get a string from stdin
 *
 *	Copyright (c) 1986 by Ian Macky, SRI International
 */

#include <stdio.h>

char *gets(s)
register char *s;
{
    register int c;
    register char *original_s;

    if (!_readable(stdin)) return NULL;
    original_s = s;
    while ((c = getchar()) != EOF && c != '\n')
	*s++ = c;
    if (c == EOF && s == original_s) return NULL;
    *s = '\0';
    return original_s;
}

