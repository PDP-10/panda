#include <c-env.h>

#if SYS_T20

#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/file.h>
#include <sys/usydat.h>
#include <sys/usysio.h>
#include <sys/c-debug.h>
#include <netinet/in.h>
#include <jsys.h>

int setsockopt (int fd, int level, int optname, const void *optval, int optlen)
{
    struct _ufile *uf;

    USYS_BEG();

#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_INET) {
	_dbgl("SETSOCKOPT&getsockname(fd=");
	_dbgd(fd);
	_dbgs(", level=");
	_dbgo(level);
	_dbgs(", optname=");
	_dbgo(optname);
	_dbgs(", optval=");
	_dbgo((unsigned long)optval);
	_dbgs(", optlen=");
	_dbgd(optlen);
	_dbgs(")\r\n");
    }
#endif

    USYS_LOCK(USYS_VAR_REF(uflock)); /* Claim interlock */

    if (!(uf = _UFGET(fd))) {	/* Find uf structure for FD */
      USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
      USYS_RETERR(EBADF);
    }

    switch (level) {
    case SOL_SOCKET:
	switch (optname) {
	case SO_REUSEADDR:
	  break;		/* Currently a no-op */
	case SO_KEEPALIVE:
	  break;		/* Currently a no-op */
	case SO_DEBUG:
	case SO_ACCEPTCONN:
	case SO_DONTROUTE:
	case SO_BROADCAST:
	case SO_USELOOPBACK:
	case SO_LINGER:
	case SO_OOBINLINE:
	case SO_SNDBUF:
	case SO_RCVBUF:
	case SO_SNDLOWAT:
	case SO_RCVLOWAT:
	case SO_SNDTIMEO:
	case SO_RCVTIMEO:
	case SO_ERROR:
	case SO_TYPE:
	default:
	  USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
	  USYS_RETERR(EINVAL);
	}
      break;
    default:
      USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
      USYS_RETERR(EINVAL);
    }

    USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
    USYS_RET(0);
}

#endif /* SYS_T20 */
