/*
 *	FGETC - get the next character from stream
 *
 *	Copyright (c) 1986 by Ian Macky, SRI International
 */

#include <stdio.h>
#include <errno.h>
#include <sys/file.h>

extern int read();	/* Syscalls */
extern long lseek();

static int readch();

int
fgetc(f)
register FILE *f;
{
    if (!_readable(f))
	return EOF;
    if (--f->siocnt >= 0)	/* If any chars left in buffer, */
	return *++f->siocp;	/* just return a buffer char */

    /*
     *	if just finished reading pushed-back characters, pop back
     *	to the previous source.  if there was something left in the old
     *	stuff then win, else fall through and grab a new buffer
     */
    if (f->sioflgs & _SIOF_PBC) {
	f->sioflgs &= ~_SIOF_PBC;
	f->siocp = f->sio2cp;
	if ((f->siocnt = f->sio2cnt) > 0)
	    return fgetc(f);		/* Won, something left to read */
    }

    /* If at EOF or input source is a string, just stop here. */
    if (f->sioflgs & (_SIOF_EOF | _SIOF_STR)) {
	f->sioflgs |= _SIOF_EOF;	/* Set EOF flag in case string */
	return EOF;
    }

    /* If reading from stdin, make sure stdout is flushed */
    if (f == stdin)
	fflush(stdout);	    	    	    	    

    /* See whether doing buffering. */
    if (!(f->sioflgs & (_SIOF_BUF|_SIOF_AUTOBUF)))
	return readch(f);	/* No, read just one char */

    if (_filbuf(f) != 0)	/* fill the buffer and try again */
	return EOF;		/* unless failed to fill buffer! */
    return fgetc(f);
}

int _readable(f)
FILE *f;
{
    if (f->siocheck != _SIOF_OPEN)		/* check for valid and */
	return 0;				/* open FILE block. */
    if (f->sioflgs & _SIOF_READ)		/* vanilla readable? */
	return 1;				/* good show! */
    if (!(f->sioflgs & _SIOF_WRITE) && (f->sioflgs & _SIOF_UPDATE)) {
	f->sioflgs |= _SIOF_READ;		/* quiescent update mode? */
	_prime(f);				/* set to read mode, */
	return 1;				/* prime i/o, then win */
    }
    return 0;					/* all else. */
}

/* _FILBUF - Fill buffer.
**	This is only called by fgetc() and fseek().
*/
int
_filbuf(f)
register FILE *f;
{
    /* If no buffer has been allocated yet, and
     *	automatic buffer allocation is requested, then grab one.  if
     *	can't, or not automatic, then punt.
     */
    if (!(f->sioflgs & _SIOF_BUF))
	if (f->sioflgs & _SIOF_AUTOBUF) {
	    if (setvbuf(f, (char *)NULL, _IOFBF, 0) != 0) {
		f->sioerr = ENOMEM;	/* If fails, assume this is why */
		return -1;
	    }
	    f->sioflgs |= _SIOF_READ;	/* fflush clobbers this */
	} else return -1;		/* No buffer and no autobuf?? */

    /* Snarf a bufferful of data */
    if (f->sioflgs & _SIOF_CONVERTED)	/* Update our FD file position */
	f->siofdoff = lseek(f->siofd, (long)0, L_INCR);	/* Get current pos */
    else f->siofdoff += f->sioocnt;			/* Can compute it */

    if ((f->siocnt = read(f->siofd, f->siopbuf, f->siolbuf)) <= 0) {
	if (f->siocnt == -1)			/* if lost big (i/o err) */
	    f->sioerr = errno;			/* then save error code */
	else f->sioflgs |= _SIOF_EOF;		/* else just EOF */
	return -1;
    }

    f->siocp = f->siopbuf - 1;
    f->sioocnt = f->siocnt;
    return 0;			/* Won! */
}

/* READCH - read single char.
**	This is an auxiliary routine so that fgetc doesn't have to allocate
**	any local storage.
*/
static int
readch(f)
FILE *f;
{
    unsigned char ch;
    switch (read(f->siofd, &ch, 1)) {
	case 1:
	    f->siofdoff++;
	    return ch;
	case 0:
	    f->sioflgs |= _SIOF_EOF;
	    return EOF;
	default:
	    f->sioerr = errno;
	    return EOF;
    }
}
