/*
**	CLOSE - lowest-level URT closefile
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.60, 11-Aug-1988
**	Copyright (C) 1986 by Ian Macky, SRI International
**	Edits for ITS: Copyright (C) 1988 Alan Bawden
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported for */

#include <errno.h>
#include <stddef.h>		/* for NULL */
#include <sys/usysio.h>
#include <sys/usysig.h>
#include <sys/usytty.h>

#if SYS_T20+SYS_10X
#include <jsys.h>

#elif SYS_T10+SYS_CSI+SYS_WTS
#include <muuo.h>
int _blkfin();			/* From write() */
int _opnrel();			/* From open() */

#elif SYS_ITS
#include <sysits.h>
#endif

int close(fd)
int fd;
{
    register struct _ufile *uf;
    int res;

    USYS_BEG();
    if (!(uf = _UFGET(fd)))
	USYS_RETERR(EBADF);

    /* FD is valid, always zap its mapping slot */
    _uffd[fd] = 0;			/* Zap it! */
    if (-- uf->uf_nopen > 0)		/* If still have FDs open for file, */
	USYS_RET(0);			/* just return successfully */

    /* No FDs left with this UF active, so must really close the UF now.
    ** From this point on, return value must be "res" unless outright error.
    */
    res = 0;
    uf->uf_nopen = 0;			/* Ensure UF no longer in use */
    if (uf->uf_type == UIO_DVTTY)	/* If was a TTY device, */
	_ttys[uf->uf_dnum].tt_uf = 0;	/* Flush the tty struct */
#if SYS_T10+SYS_CSI+SYS_WTS
    if (uf->uf_flgs & UIOF_BLKDEV)	/* If I/O to block device, */
	if (_blkfin(uf))		/* finalize current buffer! */
	    res = -1;			/* Ugh, fail later on. */
#endif
    if (uf->uf_buf) {			/* If had a block or conversion buf, */
	_iobfre(uf->uf_buf);		/* free up the buffer! */
	uf->uf_buf = NULL;
    }

#if SYS_T20+SYS_10X
    switch (uf->uf_ch) {		/* Check out JFN */
	case _PRIIN:
	case _PRIOU:
	case _CTTRM:
	    break;			/* it's a no-op to close these. */
	default:
	    {
		int acs[5];
		acs[1] = uf->uf_ch;	/* Put JFN in AC 1 */
		if (!jsys(CLOSF, acs))
		    USYS_RETERR(ECLOSE);
	    }
    }

#elif SYS_T10+SYS_CSI+SYS_WTS
    if (uf->uf_ch == UIO_CH_CTTRM)	/* Can't close controlling term */
	USYS_RET(res);
    else {
	int err;
	if (err = _opnrel(uf))		/* Release I/O ch using open() code */
	    USYS_RETERR(err);
    }

#elif SYS_ITS
    if (uf->uf_flgs & UIOF_WRITE) {
	if ((uf->uf_flgs & UIOF_HANDPACK) && (uf->uf_zcnt > 0)) {
	    int padcount = uf->uf_nbpw - uf->uf_zcnt;
	    /* You never pad > 35 bytes */
	    _outblock(uf, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\
\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0", &padcount);
	    if (padcount != 0) USYS_RETERR(EIO);	/* Barf! */
	}
	SYSCALL1("finish", uf->uf_ch);	/* Ignore failure */
    }
    SYSCALL1_LOSE("close", uf->uf_ch);	/* Cannot fail */
#endif

    USYS_RET(res);			/* Return 0 for success, -1 if fail */
}

#endif /* T20+10X+T10+CSI+WAITS+ITS */
