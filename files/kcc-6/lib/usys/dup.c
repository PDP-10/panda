/*
**	DUP - duplicate file descriptor
**
**	(c) Copyright Ken Harrenstien 1989
**
*/

#include <c-env.h>
#include <sys/usydat.h>
#include <sys/c-debug.h>
#include <errno.h>

int
dup2(from, to)
int from, to;
{
    struct _ufile *fromuf;

    USYS_BEG();

    /* Check out argument fds */
    if ( to < 0 || OPEN_MAX <= to
	|| !(fromuf = _UFGET(from)))
	USYS_RETERR(EBADF);	/* Bad file descriptor */

    if (USYS_VAR_REF(uffd[to]))
	close(to);		/* Close this FD */
    USYS_VAR_REF(uffd[to]) = fromuf; /* Set new mapping! */
    fromuf->uf_nopen++;		/* Incr cnt of FDs pointing to this UF */

#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_UIO_FDSHR) {
	_dbgl("DUP&dup2(from ");
	_dbgd(from);
	_dbgs(", to ");
	_dbgd(to);
	_dbgs(") uf ");
	_dbgd(fromuf-USYS_VAR_REF(uftab));
	_dbgs("/ nopen=");
	_dbgd(fromuf->uf_nopen);
	_dbgs(", jfn=");
	_dbgj(fromuf->uf_ch);
	_dbgs("\r\n");
    }
#endif

    USYS_RET(to);
}

int
dup(fd)
int fd;
{
    int	newfd, ret;

    USYS_BEG();
    if ((newfd = _uiofd()) == -1)	/* _uiofd sets errno if fails */
	USYS_RET(-1);
    ret = dup2(fd, newfd);
    USYS_RET(ret);
}
