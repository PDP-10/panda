/*
 *	FREAD - binary read
 *
 *	Copyright (C) 1986 by Ian Macky, SRI International
 */

#include <stdioi.h>
#include <errno.h>

#if __STDC__
#define VCHAR void
#else
#define VCHAR char
#endif

size_t fread(ptr, size_of_ptr, count, f)
VCHAR *ptr;
size_t size_of_ptr, count;
FILE *f;
{
    register char *cp = ptr;		/* Cannot manipulate (void *) */
    int number_read, size, c;

    if (!_readable(f) || size_of_ptr++ < 1 || count < 1) {
	errno = EINVAL;
	return 0;
    }
    else {
	number_read = 0;
	while (count--) {
	    size = size_of_ptr;
	    while (--size && ((c = getc(f)) != EOF))
		*cp++ = c;
	    if (!size) number_read++;
	    else break;
	}
	return number_read;
    }
}
