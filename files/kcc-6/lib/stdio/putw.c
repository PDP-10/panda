/*
**	PUTW	- write an int to a stream
**
**	(c) Copyright Ken Harrenstien 1989
**
*/

#include <stdioi.h>

int putw(val, f)
int val;
FILE *f;
{
    register int i = sizeof(int);
    register char *cp = ((char *)&val)-1;

    do {
	putc(*++cp, f);
    } while (--i > 0);

    return feof(f) ? EOF : val;
}
