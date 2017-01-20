/*
**	DUP - duplicate file descriptor
**
**	(c) Copyright Ken Harrenstien 1989
**
*/

#include <c-env.h>
#include <sys/usysig.h>
#include <sys/usysio.h>
#include <errno.h>
extern int _uiofd();

int dup(), dup2();

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

    if (_uffd[to])
	close(to);		/* Close this FD */
    _uffd[to] = fromuf;		/* Set new mapping! */
    fromuf->uf_nopen++;		/* Incr cnt of FDs pointing to this UF */
    USYS_RET(to);
}
