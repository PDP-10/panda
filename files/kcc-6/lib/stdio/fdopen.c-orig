/*
**	FDOPEN - open a stream given an existing file descriptor
**
**	(c) Copyright Ken Harrenstien 1989
**
*/

#include <stdio.h>

#if __STDC__
#define CONST const
#else
#define CONST
#endif


FILE *fdopen(fd, type)
int fd;
CONST char *type;
{
    FILE *f;
    int flags, uio_flags;

    flags = _sioflags(type, &uio_flags);	/* Parse type string */

#if 0	/* Commented out for now.
	** To verify that FD directions match stream type specification,
	** would need to create auxiliary USYS routine _fdstat() to return
	** the flags used at open() for an active FD (-1 if bad FD).
	** Must include "sys/file.h" for this to compile.
	*/
    if ((oflags = _fdstat(fd)) == -1) return NULL;
    switch (oflags & (O_RDWR | O_WRONLY | O_RDONLY)) {
	case (O_RDONLY):
	    if (!(flags & _SIOF_READ)) return NULL; break;
	case (O_WRONLY):
	    if (!(flags & _SIOF_WRITE)) return NULL; break;
	case (O_RDWR):
	    if (!(flags & _SIOF_UPDATE)) return NULL; break;
	default:
	    return NULL;	/* I/O direction mismatch between type & fd */
    }
#endif

    if (f = _makeFILE()) {
	_setFILE(f, fd, flags);		/* OK, set up the FILE block */
	if (f->siofdoff == -1) {	/* Did _setFILE's lseek() fail? */
	    _freeFILE(f);		/* Ugh, flush FILE block */
	    return NULL;		/* Bad FD (we think) */
	}
    }
    return f;		/* Return stream (or NULL if _makeFILE failed) */
}
