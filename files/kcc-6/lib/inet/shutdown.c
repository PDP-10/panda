#include <errno.h>
#include <sys/usydat.h>
#include <sys/usysio.h>

int shutdown(fd, how)
int fd, how;
{
    struct _ufile *uf;

    USYS_BEG();

    USYS_LOCK(USYS_VAR_REF(uflock)); /* Claim interlock */

    if (!(uf = _UFGET(fd))) {
      USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
      USYS_RETERR(EBADF);
    }

    switch (how) {
    case 0:
      uf->uf_flgs &= ~UIOF_READ; /* Clear read */
      break;
    case 1:
      uf->uf_flgs &= ~UIOF_WRITE; /* Clear write */
      break;
    case 2:
      uf->uf_flgs &= ~(UIOF_READ | UIOF_WRITE); /* Clear read and write */
      break;
    default:
      USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
      USYS_RETERR(EINVAL);	/* Return invalid argument error */
    }

    USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
    USYS_RET(0);		/* and return successfully */
}
