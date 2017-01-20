#include <c-env.h>
#include <errno.h>
#include <jsys.h>
#include <sys/usydat.h>

int
fsync(fd)
register int fd;
{
    register struct _ufile *uf;
    int  acs[5];

    USYS_BEG();
    if (!(uf = _UFGET(fd)))
	USYS_RETERR(EBADF);
    acs[1] = (uf->uf_ch << 18); 	/* jfn,,page 0 */
    acs[2] = 0777777;			/* all pages */
    if (!jsys(UFPGS, acs))
	USYS_RETERR(EIO);
    USYS_RET(0);
}
