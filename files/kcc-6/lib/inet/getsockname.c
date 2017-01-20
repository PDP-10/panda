#include <c-env.h>

#if SYS_T20

#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/file.h>
#include <sys/usydat.h>
#include <sys/usysio.h>
#include <netinet/in.h>
#include <strings.h>
#include <jsys.h>

int getsockname (int s, struct sockaddr *name, int *namelen)
{
  /* Should get name from socket structure, */
  /* but since we don't have one...  */
  return getpeername(s, name, namelen);
}


#define X(addr, position)\
  (unsigned)(((addr) >> ((position) * 8)) & 0377)

int	getpeername (int fd, struct sockaddr *name, int *namelen)
{
    struct _ufile *uf;
    struct sockaddr_in iname;
    int len = *namelen, acs[5];
    char *p = (char *)&iname.sin_addr.S_un.S_addr;

    USYS_BEG();

#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_INET) {
	_dbgl("GETSOCKNAME&getsockname(fd=");
	_dbgd(fd);
	_dbgs(", name=");
	_dbgo((int)name);
	_dbgs(", namelen=");
	_dbgd(*namelen);
	_dbgs(")\r\n");
    }
#endif

    USYS_LOCK(USYS_VAR_REF(uflock)); /* Claim interlock */

    if (!(uf = _UFGET(fd))) {	/* Find uf structure for fd */
      USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
      USYS_RETERR(EBADF);
    }

    if (len > sizeof(iname))	/* Did he provide more space than needed? */
      len = sizeof(iname);	/* Yes */

    if (uf->uf_type != _DVTCP) {/* Is this a network connection? */
      USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
      USYS_RETERR(ENOTSOCK);	/* No */
    }

    iname.sin_family = AF_INET;	/* Always internet family */

    acs[1] = uf->uf_ch;		/* Get JFN for connection */

    if (!jsys(GDSTS,acs)) {
      USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
      USYS_RETERR(EIO);		/* No */
    }

    USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */

    iname.sin_port = acs[4];

    p[0] = X(acs[3],3);
    p[1] = X(acs[3],2);
    p[2] = X(acs[3],1);
    p[3] = X(acs[3],0);

    memcpy((caddr_t)name, (caddr_t)&iname, len);

#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_INET) {
	_dbgl("GETSOCKNAME&getsockname(fd=");
	_dbgd(fd);
	_dbgs(") ==> sin_addr=");
	_dbgo(iname.sin_addr);
	_dbgs(", sin_port=");
	_dbgo(iname.sin_port);
	_dbgs("\r\n");
    }
#endif

    USYS_RET(0);
}

#endif /* SYS_T20 */
