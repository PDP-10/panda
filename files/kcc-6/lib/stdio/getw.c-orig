/*
**	GETW	- get an int from a stream
**
**	(c) Copyright Ken Harrenstien 1989
**
**	Returns EOF on error or EOF.
** As per BSD, assumes no special alignment in stream.
** Note that partial words will be filled out with all-ones bytes, and this
** hack is what provides an EOF value if all bytes were EOF!
*/

#include <stdio.h>

int getw(f)
FILE *f;
{
    union {
	int word;
	char chs[sizeof(int)];
    } val;
    register int i = sizeof(int);
    register char *cp = val.chs-1;

    /* Slow method, used when not sure we have enough chars in buffer
    ** for a direct copy.
    */
    do {
	*++cp = getc(f);
    } while (--i > 0);

    return val.word;
}
