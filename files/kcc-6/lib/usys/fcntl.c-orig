/*
**	FCNTL - file control
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.13, 5-Sep-1987
**	(c) Copyright Ian Macky, SRI International 1987
*/

#include <c-env.h>
#include <sys/usysio.h>
#include <sys/usysig.h>
#include <errno.h>
#include <fcntl.h>

int
fcntl(fd, cmd, arg)
int fd, cmd, arg;
{
    struct _ufile *uf;
    int ret;

    USYS_BEG();
    if (!(uf = _UFGET(fd)))
	USYS_RETERR(EBADF);			/* bad FD given */

    switch (cmd) {
	case F_GETFL:			/* Get flags for FD */
	    ret = uf->uf_flgs;
	    break;

	case F_GETSYSFD:		/* Get actual system "fd" */
	    ret = uf->uf_ch;
	    break;

	case F_GETBYTESIZE:		/* Get bytesize used for fd */
	    ret = uf->uf_bsize;
	    break;

	default:
	    USYS_RETERR(EINVAL);
    }
    USYS_RET(ret);
}
