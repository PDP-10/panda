/*
**	LSEEK - move read/write pointer
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.36, 20-Sep-1988
**	(c) Copyright Ian Macky, SRI International 1986
**	Edits for ITS:  Copyright (C) 1988 Alan Bawden
**
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_ITS+SYS_T10+SYS_WTS+SYS_CSI	/* Systems supported */

#include <sys/usysio.h>
#include <sys/usydat.h>
#include <sys/urtint.h>
#include <sys/file.h>	/* Defines L_ flag values */
#include <errno.h>
#if SYS_T20+SYS_10X
#include <jsys.h>
#elif SYS_ITS
#include <sysits.h>
#elif SYS_T10+SYS_WTS+SYS_CSI
#include <uuosym.h>
#endif

off_t
lseek(fd, offset, whence)
int fd, whence;
off_t offset;
{
    register struct _ufile *uf;
    long newpos;		/* Return value must be on stack
				** (cannot use uf->uf_pos because interrupt
				** during USYS_RET might change that loc)
				*/

#if SYS_T20+SYS_10X
    int acs[5], fdb[2];
#elif SYS_ITS
    int syspos, skipcount;
    char gubbish[35];		/* can't need to skip more than 35 bytes */
#elif SYS_T10+SYS_WTS+SYS_CSI

#endif


    USYS_BEG();

    if (!(uf = _UFGET(fd)))
	USYS_RETERR(EBADF);

    switch (whence) {
	case L_SET:
	    newpos = offset;
	    break;
	case L_INCR:
	    newpos = uf->uf_pos + offset;
	    break;
	case L_XTND:
#if SYS_T20+SYS_10X
	    acs[1] = uf->uf_ch;
	    acs[2] = XWD(2,monsym(".FBBYV"));	/* Get .FBBYV, .FBSIZ */
	    acs[3] = (int) fdb;
	    if (!jsys(GTFDB, acs))
		USYS_RETERR(EBADF);
	    newpos = _nfbsz(uf->uf_bsize,	/* Derive # bytes */
				FLDGET(fdb[0], monsym("FB%BSZ")),
				fdb[1]);
	    if (newpos < uf->uf_pos)	/* If our len info is better */
		newpos = uf->uf_pos;	/* update it! */
	    newpos += offset;
	    break;
#elif SYS_WTS+SYS_CSI+SYS_T10
	    newpos = uf->uf_flen + offset;	/* Lots of luck */
	    break;
#elif SYS_ITS
	    /* ITS wants perfection but can't find exact EOF yet, so fails */
#endif
	default:
	    USYS_RETERR(EINVAL);
    }
#if SYS_T20+SYS_10X
    acs[1] = uf->uf_ch;
    if (jsys(RFPTR, acs))
      uf->uf_pos = acs[2];		/* Use real position if available */
#endif
    if (newpos == uf->uf_pos)		/* If not going anywhere, */
	USYS_RET(newpos);		/* we win immediately! */
    if (newpos < 0)			/* Sanity check */
	USYS_RETERR(EINVAL);

#if SYS_T20+SYS_10X
    acs[1] = uf->uf_ch;			/* JFN */
    acs[2] = newpos;
    if (!jsys(SFPTR, acs))		/* Set the file pointer */
	USYS_RETERR(EBADF);
    uf->uf_eof = 0;			/* Clear EOF indicator */
    uf->uf_rleft = uf->uf_wleft = 0;	/* Force read/write to seek */
    uf->uf_pos = newpos;		/* Set & return the new position */
    USYS_RET(newpos);


#elif SYS_T10+SYS_WTS+SYS_CSI
    if ((uf->uf_flgs & (UIOF_READ|UIOF_WRITE)) == UIOF_WRITE)
	USYS_RETERR(EBADF);		/* Cannot do write-only seeks */

    uf->uf_eof = 0;			/* Clear EOF indicator */
    uf->uf_rleft = uf->uf_wleft = 0;	/* Force read/write to seek */
    uf->uf_pos = newpos;		/* Set & return the new position */
    USYS_RET(newpos);
    

#elif SYS_ITS
    if (uf->uf_flgs & UIOF_HANDPACK) {
	syspos = newpos / uf->uf_nbpw;
	skipcount = newpos % uf->uf_nbpw;
	if (uf->uf_flgs & UIOF_WRITE) {
	    /* For block mode output, can only set position from one */
	    /* word boundary to another. */
	    if ((uf->uf_zcnt != 0) || (skipcount != 0))
		USYS_RETERR(EBADF);
	}
    } else {
	syspos = newpos;
	skipcount = 0;
    }
    
    if (SYSCALL2("access", uf->uf_ch, &syspos))
	USYS_RETERR(EBADF);

    uf->uf_eof = 0;			/* Clear EOF indicator */
    uf->uf_rleft = uf->uf_wleft = 0;	/* Force read/write to seek */
    uf->uf_pos = newpos;		/* Set & return the new position */
    uf->uf_zcnt = 0;			/* Sigh */

    if (skipcount != 0)
	if (read(fd, gubbish, skipcount) != skipcount)
	    USYS_RETERR(EIO);	/* now at neither new nor old position */

    USYS_RET(newpos);
#else

    USYS_RETERR(EINVAL);
#endif
}

long
tell(fd)
int fd;
{
    return lseek(fd, 0L, L_INCR);
}

#endif /* T20+10X+ITS+T10+WAITS+CSI */
