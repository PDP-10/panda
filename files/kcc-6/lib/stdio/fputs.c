/*
 *	FPUTS - put a string to a stream
 *
 *	Copyright (c) 1986 by Ian Macky, SRI International
 */

#include <stdioi.h>
#include <string.h>
#include <errno.h>
#include <sys/usysio.h>

#if __STDC__
#define CONST const
#else
#define CONST
#endif


int fputs(s, f)
register CONST char *s;
register FILE *f;
{
    register int c, i;

    if (!_writeable(f))
	return EOF;
    if (f->sioflgs & _SIOF_BUF) {
	while ((c = *s++) && (c = putc(c, f)) != EOF) ;
	return c;
    } else {
	if ((i = strlen(s)) > 0) {
	    if (write(f->siofd, s, i) == -1) {
		f->sioerr = errno;
		return EOF;
	    }
	    f->siofdoff += i;
	    return 0;
	}
    }
}
