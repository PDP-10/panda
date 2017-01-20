/*
 *	FWRITE - binary write
 *
 *	Copyright (C) 1986 by Ian Macky, SRI International
 */

#include <stdioi.h>
#include <errno.h>

#if __STDC__
#define VCHAR void
#define CONST const
#else
#define VCHAR char
#define CONST
#endif

size_t fwrite(ptr, size_of_ptr, count, f)
CONST VCHAR *ptr;
size_t size_of_ptr, count;
FILE *f;
{
    register CONST char *cp = ptr;	/* Cannot manipulate (void *) */
    int number_of_bytes;

    if (!_writeable(f) || size_of_ptr < 1 || count < 1) {
	errno = EINVAL;
	return 0;
    }
    else {
	number_of_bytes = count * size_of_ptr;
	while (number_of_bytes-- && (putc(*cp++, f) != EOF));
	return (count - number_of_bytes);
    }
}
