
/*
**	FCNTL - file control
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.13, 5-Sep-1987
**	(c) Copyright Ian Macky, SRI International 1987
*/

#include <c-env.h>
#include <sys/usydat.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>

int
fcntl(fd, cmd, arg)
int fd, cmd, arg;
{
    struct _ufile *uf;
    int ret, oldflgs, newfd;

    USYS_BEG();
    if (!(uf = _UFGET(fd)))
	USYS_RETERR(EBADF);			/* bad FD given */

    switch (cmd) {
	case F_GETFD:			/* Get close-on-exec flag */
	    ret = (fd > UIO_FD_STDERR) ? 1 : 0;
					/* Everything above stderr */
					/* gets closed on exec( */
	    break;

	case F_GETFL:			/* Get flags for FD */
	    ret = uf->uf_flgs;
	    break;

	case F_GETSYSFD:		/* Get actual system "fd" */
	    ret = uf->uf_ch;
	    break;

	case F_GETBYTESIZE:		/* Get bytesize used for fd */
	    ret = uf->uf_bsize;
	    break;

	case F_SETFD:
	    ret = ((arg & 1) == ((fd > UIO_FD_STDERR) ? 1 : 0)) ? 0 : -1;
	    break;

	case F_SETFL:
	    oldflgs = uf->uf_flgs;
	    uf->uf_flgs &= ~(FNDELAY|FASYNC);
	    uf->uf_flgs |= (arg & (FNDELAY|FASYNC));
	    /* Just ignore FAPPEND for now */
	    if (((uf->uf_flgs & FASYNC) != (oldflgs & FASYNC))
		&&USYS_VAR_REF(atirtn)
		&& (_uftty(uf) == _cntrl_tty))
	      (*USYS_VAR_REF(atirtn))(uf->uf_flgs & FASYNC ? 1 : -1);
				/* Update SIGIO */
	    ret = 0;
	    break;

	case F_DUPFD:
	    for (newfd = arg; newfd < OPEN_MAX; newfd++)
	      if (!USYS_VAR_REF(uffd[newfd])) {
		ret = dup2(fd, newfd);
		break;
	      }
	    if (newfd >= OPEN_MAX)
	      USYS_RETERR(EMFILE);
	    break;

	default:
	    USYS_RETERR(EINVAL);
    }
    USYS_RET(ret);
}
