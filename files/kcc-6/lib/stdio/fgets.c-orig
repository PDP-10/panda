/*
 *	FGETS - get a string from stream
 *
 *	Copyright (c) 1986 by Ian Macky, SRI International
 */

#include <stdio.h>

char *fgets(s, n, f)
char *s;
int n;
FILE *f;
{
    int c;
    char *org_s;

    if (!_readable(f) || n <= 1)
	return NULL;				/* validation/sanity checks */
    org_s = s;					/* save original string ptr */

/*
 *	suck until the requested count (n) reaches one (to leave space
 *	for the terminating null), a newline is seen, or there are no
 *	more characters
 */

    while (n-- > 1 && (c = getc(f)) != EOF)
	if ((*s++ = c) == '\n') break;

/*
 *	if nothing was read at all then just return a NULL pointer
 *	immediately, don't null-terminate the string.
 */

    if (s == org_s) return NULL;
    else {
	*s = '\0';
	return org_s;
    }
}
