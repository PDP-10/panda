/*
**	FTELL - tell position within file
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.24, 1-Apr-1989
**	(c) Copyright Ian Macky, SRI International 1986
**	Revised 1987, 1988 by Ken Harrenstien for new I/O ptr scheme
*/

/*	For reading:
 *
 * _SIOP_BITS method:
 *	For an unconverted file (_SIOF_CONVERTED off), the I/O ptr is
 *		the real physical position.
 *	For a converted file (_SIOF_CONVERTED on), the I/O ptr is:
 *		<real phys pos of beg of buff><offset in buff>
 *		where the <offset> is kept in the low _SIOP_BITS bits.
 *
 * Alternative method:
 *	I/O ptr is the real physical position, whether converted or not.
 *	Simply re-reads the file from last known physical position, up to
 *	the current point, finds phys position there, then restores pointer.
 *	Advantages: same pointer format, whether converted or unconverted.
 *	Disadvantages: slower (must re-read and do seeks).
 */

#include <stdioi.h>
#include <sys/file.h>

int fgetpos(f, pos)
FILE *f;
fpos_t *pos;
{
    long ptr = ftell(f);
    if (ptr == -1)
	return -1;
    *pos = ptr;
    return 0;
}

long ftell(f)
FILE *f;
{
    long pos;
    int cur_cnt;				/* current count */

    if (f->siocheck != _SIOF_OPEN)		/* validate FILE block */
	return -1;
    switch (f->sioflgs & (_SIOF_READ | _SIOF_WRITE)) {
	case _SIOF_READ:
/*
 *	if ungetc's have been done then siocnt now has the # of ungetc'd
 *	characters, and sio2cnt has the old siocnt from before the first
 *	ungetc.  ANSI says pushed-back chars should be included for binary
 *	streams, though the pointer value is unspecified if you ungetc
 *	at position 0.  For text streams the behavior is unspecified; we
 *	try to do the same thing as for binary (because that's simplest) but
 *	the results will probably not be useful.
 */
	    cur_cnt = (f->sioflgs & _SIOF_PBC)
			? f->sio2cnt + f->siocnt	/* Include pushback */
			: f->siocnt;
	    if (f->sioflgs & _SIOF_CONVERTED)
#ifdef _SIOP_BITS
		pos = (f->siofdoff << _SIOP_BITS(f)) + (f->sioocnt - cur_cnt);
#else
		{   static long fdpos();
		    pos = fdpos(f, f->sioocnt - cur_cnt);
		}
#endif
	    else pos = f->siofdoff + (f->sioocnt - cur_cnt);
	    return pos;

	case _SIOF_WRITE:
	    cur_cnt = (f->sioflgs & _SIOF_LINEBUF) ? f->siolcnt : f->siocnt;
	    if (f->sioflgs & _SIOF_CONVERTED) {
		fflush(f);			/* Ensure output forced out */
#ifdef _SIOP_BITS
		pos = (f->siofdoff << _SIOP_BITS(f));	/* so need no offset */
#else
	        pos = f->siofdoff;
#endif
	    }
	    else pos = f->siofdoff + (f->siolbuf - cur_cnt);
	    return pos;

	case 0:
	    if (f->sioflgs & _SIOF_UPDATE) {
		if (f->sioflgs & _SIOF_CONVERTED)
		    return -1;		/* Cannot handle this case yet */
		return f->siofdoff;
	    }
	    /* Not updating, return failure */

	default:
	    return -1;
    }
}

#ifndef _SIOP_BITS
/* FDPOS - finds real physical position corresponding to a given
**	phys position plus some offset # of STDIO-buffered chars.
*/
static long
fdpos(f, boff)
FILE *f;
int boff;			/* Offset within current buffer */
{
    long savoff, retoff;

    if (boff <= 0
      || boff > f->siolbuf
      || !f->siopbuf)
	return f->siofdoff + boff;	/* No offset or buffer */

    if ((savoff = lseek(f->siofd, (long)0, L_INCR)) == -1)
	return -1;
    if (lseek(f->siofd, f->siofdoff, L_SET) == -1)
	return -1;
    if (boff == read(f->siofd, f->siopbuf, boff))	/* Read that many */
	retoff = lseek(f->siofd, (long)0, L_INCR);	/* Find phys pos! */
    else retoff = -1;
    if (lseek(f->siofd, savoff, L_SET) == -1)		/* Restore prev pos */
	return -1;
    return retoff;
}
#endif
