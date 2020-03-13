/*
 *	BSEARCH - binary search
 *
 *	Copyright (C) 1987 by Ian Macky, SRI International
 */

#include <stdio.h>

#if __STDC__
#define VCHAR void
#define CONST const
#else
#define VCHAR char
#define CONST
#endif

VCHAR *bsearch(key, base, count, size, compar)
CONST VCHAR *key;
CONST VCHAR *base;
size_t count;
size_t size;
int (*compar)(CONST VCHAR *key,char *current);
{
    int result, first, last, middle;
    char *current;

    if (size < 1 || count < 1) return NULL;	/* minor arg checking */
    first = 0;					/* initial range is whole */
    last = --count;				/* array, first & last */
    for (;;) {
	middle = first + ((last - first) / 2);	/* compute center of range */
	current = (char *)base + (middle*size);	/* turn into ptr to member */
	result = (*compar)(key, current);	/* do the user comparison */
	if (!result) return current;		/* got a match! */
	if (first >= last) return NULL;		/* narrowed to nothing */
	if (result < 0) last = --middle;	/* key is before midpoint */
	else first = ++middle;			/* else key after midpoint */
    }
}
