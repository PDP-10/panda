/*
**	FSEEK - set position in file
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.25, 27-Oct-1987
**	(c) Copyright Ian Macky, SRI International 1986
*/

#include <stdio.h>
#include <sys/file.h>

extern long lseek();	/* Syscall */

#if __STDC__
#define CONST const
#else
#define CONST
#endif


int fsetpos(f, pos)
FILE *f;
CONST fpos_t *pos;
{
    return fseek(f, (long)*pos, SEEK_SET);
}

int fseek(f, offset, whence)
FILE *f;
long offset;
int whence;
{
#ifdef _SIOP_BITS
    int boff = 0;		/* Buffer offset */
#endif

    /* Convert flags from STDIO SEEK_ to system L_ */
#if ((SEEK_SET!=L_SET) || (SEEK_CUR!=L_INCR) || (SEEK_END!=L_XTND))
    int lskcmd;		/* lseek() command */
    switch (whence) {
	case SEEK_SET:	lskcmd = L_SET;	break;
	case SEEK_CUR:	lskcmd = L_INCR; break;
	case SEEK_END:	lskcmd = L_XTND; break;
	default:	return -1;	/* Bad whence value */
    }
#else
#define lskcmd whence		/* If same, don't use lskcmd */
#endif
    if ((f->siocheck != _SIOF_OPEN) || (f->sioflgs & _SIOF_STR))
	return -1;			/* validate FILE block */

#ifdef NEWSTREXP
#error this isn't completed yet, needs work.

    if (f->sioflgs & _SIOF_STR) switch (whence) {
	case L_XTND:
	    new_offset = f->siolbuf + offset;
	    if (offset > 0) {
		by = f->siosinc * ((offset / f->siosinc) + 1);
		if (!_expand(f, by)) return -1;
	    }
	    offset = new_offset;	/* fall into L_SET now */
	case L_SET:
	    if (offset < 0 || offset >= f->siolbuf) return -1;
	    f->siocp = f->siopbuf + offset - 1;
	    f->siocnt = f->siolbuf - offset;
	    f->siofdoff = offset; break;
	    f->sioflgs &= ~(_SIOF_PBC | _SIOF_EOF);	/* Clear EOF, ungetc */
	    return 0;			/* success */
	default:
	    return -1;
    }
#endif /* NEWSTREXP */

    fflush(f);				/* first flush any buffered data */
    if (f->sioflgs & _SIOF_CONVERTED) {
	switch (whence) {
	    case SEEK_CUR:
		if (offset) return -1;	/* Cannot do offset */
		f->sioflgs &= ~(_SIOF_PBC | _SIOF_EOF);	/* Clear EOF, ungetc */
		return 0;		/* No-op */
	    case SEEK_END:
		if (offset) return -1;	/* Cannot do offset */
		break;			/* OK, seek to EOF */
	    case SEEK_SET:
		if (offset == 0)	/* If seeking to beg of file */
		    break;		/* also do normally. */

	    /* Tricky stuff here!  Seeking to a value returned by ftell(). */

#ifdef _SIOP_BITS
	    /* If write or updating, fall thru.  */
	    /* If reading, slurp up right bufferful.  Crude for now. */
		boff = offset & _SIOP_MASK(f);
		offset >>= _SIOP_BITS(f);	/* I/O ptr only */
		if (!(f->sioflgs & _SIOF_READ) && boff != 0) {
		    /* Error, non-zero buffer offset given for writing */
		    return -1;
		}
#endif
	}
    } else {			/* I/O isn't being converted */
	if (whence == L_INCR) {	/* Turn increment into absolute set */
	    offset += ftell(f);
	    whence = L_SET;
	}
    }

    /* Attempt seek to given OS file offset */
    if ((offset = lseek(f->siofd, offset, lskcmd)) == -1)
	return -1;			/* Failure */
    f->siofdoff = offset;

    /* Must clear EOF indicator and flush pushback chars */
    f->sioflgs &= ~(_SIOF_PBC | _SIOF_EOF);	/* Clear EOF, flush ungetc */
    if (f->sioflgs & _SIOF_UPDATE)	/* enter quiescent state */
	f->sioflgs &= ~(_SIOF_READ | _SIOF_WRITE);

#ifdef _SIOP_BITS		/* May need to position within buffer */
    if (boff) {			/* Can only be set if _SIOF_READ set */
	if (_filbuf(f) != 0)	/* Read in that bufferful of data */
	    return -1;
	f->siocp += boff;	/* Then position current loc within buffer */
	f->siocnt -= boff;
    }
#endif
    return 0;
}
