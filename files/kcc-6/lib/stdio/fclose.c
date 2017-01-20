/*
 *	FCLOSE - close a file
 *
 *	Copyright (c) 1986 by Ian Macky, SRI International
 */

#include <sys/usysio.h>
#include <stdioi.h>
#include <errno.h>
#include <stdlib.h>

int fclose(f)
register FILE *f;
{
    int n = 0;

    if (f->siocheck != _SIOF_OPEN)		/* validate block */
	return EOF;
    if (!(f->sioflgs & _SIOF_STR)) {
	if (f->sioflgs & _SIOF_BUF) {
	    if (fflush(f) == EOF) n = -1; /* Remember error */
	    if (f->sioflgs & _SIOF_DYNAMBUF)
		free((char *) f->siopbuf);
	    f->siopbuf = NULL;
	}
	if (close(f->siofd) == -1) {
	    n = -1;		/* Remember error */
	    f->sioerr = errno;
	  }
    }
    _freeFILE(f);
    return (n == -1) ? EOF : 0;
}
