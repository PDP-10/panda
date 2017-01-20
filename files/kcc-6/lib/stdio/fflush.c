/*
**	FFLUSH - flush out any output waiting in buffer
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v., 27-Jul-1989
**	Copyright (c) 1986 by Ian Macky, SRI International
*/

#include <stdioi.h>
#include <errno.h>
#include <sys/file.h>
#include <sys/usysio.h>

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

static int flushall P_((void));

#undef P_

int fflush(f)
register FILE *f;
{
    int n;

    if (f == NULL) return flushall();

    if (f->siocheck != _SIOF_OPEN) {		/* validate FILE block */
	errno = EINVAL;
	return EOF;
    }
    switch (f->sioflgs & (_SIOF_READ | _SIOF_WRITE)) {
	case _SIOF_READ:
	    _prime(f);				/* prime for i/o */
	    if (f->sioflgs & _SIOF_UPDATE)	/* enter quiescent state */
		f->sioflgs &= ~_SIOF_READ;
	    f->sioflgs &= ~_SIOF_PBC;	    	/* undo any push-back */
	    return 0;
	case _SIOF_WRITE:
	    if (f->sioflgs & _SIOF_LINEBUF)
		n = (f->siolcnt <= 0) ? f->siolbuf : f->siolbuf - f->siolcnt;
	    else
		n = (f->siocnt <= 0) ? f->siolbuf : f->siolbuf - f->siocnt;

	    if (n > 0) {
		if (write(f->siofd, f->siopbuf, n) == -1) {
		    f->sioerr = errno;		/* error during write */
		    n = -1;			/* Relay error to caller */
		} else {
		    /* Update our FD file position */
		    if (f->sioflgs & _SIOF_CONVERTED)
			f->siofdoff = lseek(f->siofd, (long)0, L_INCR);
		    else f->siofdoff += n;
		}
	    }
	    if (f->sioflgs & _SIOF_UPDATE)	/* enter quiescent state */
		f->sioflgs &= ~_SIOF_WRITE;
	    _prime(f);
	    return (n == -1) ? EOF : 0;		/* 0 on win, EOF on lose */

	default:
	    return 0;				/* must be quiescent */
    }
}

_prime(f)
FILE *f;
{
    switch (f->sioflgs & (_SIOF_READ | _SIOF_WRITE)) {
	case 0:				/* neither read or write.  must be */
	    if (f->sioflgs & _SIOF_UPDATE)
		f->siocnt = 0;		/* quiescent mode; reset count... */
	    break;
	case _SIOF_READ:
	    if (f->siocnt < 0)		/* This is often -1 */
		f->siocnt = 0;

	    /* Update our FD file position */
	    if (f->sioflgs & _SIOF_CONVERTED)
		f->siofdoff = lseek(f->siofd, (long)0, L_INCR);
	    else f->siofdoff += (f->sioocnt - f->siocnt);

	    f->sioocnt = f->siocnt = 0;
	    break;
	case _SIOF_WRITE:
	    f->siocp = f->siopbuf - 1;
	    if (f->sioflgs & _SIOF_LINEBUF) {
		f->siolcnt = f->siolbuf;
		f->siocnt = 0;
	    } else
		f->siocnt = f->sioocnt = f->siolbuf;
    }
}

static int flushall()
{
    register FILE *f;

    for (f = &_sios[0]; f < &_sios[FOPEN_MAX]; f++)
	if (f->sioflgs & _SIOF_OPEN)		/* Check static FILEs */
	    fflush(f);
    for (f = _FILE_head; f; f = f->sionFILE)	/* Then dynamic FILEs */
	fflush(f);
}
