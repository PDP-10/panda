/*
 *	FCLOSE - close a file
 *
 *	Copyright (c) 1986 by Ian Macky, SRI International
 */

#include <stdio.h>
#include <stdlib.h>
extern int close();	/* syscall */

int fclose(f)
register FILE *f;
{
    if (f->siocheck != _SIOF_OPEN)		/* validate block */
	return EOF;
    if (!(f->sioflgs & _SIOF_STR)) {
	if (f->sioflgs & _SIOF_BUF) {
	    fflush(f);
	    if (f->sioflgs & _SIOF_DYNAMBUF)
		free((char *) f->siopbuf);
	    f->siopbuf = NULL;
	}
	close(f->siofd);
    }
    _freeFILE(f);
    return 0;
}
