/*
 * socket.c - socket(2)  create an endpoint for communication
 *
 * Bill Palmer / Cisco Systems / May 1988
 * Ian Macky / cisco Systems / September 1990
 */

#include <c-env.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/usydat.h>
#include <errno.h>
#include <sys/c-debug.h>
 
int socket(af, type, protocol)
int af, type, protocol;
{   
    extern struct _ufile *_ufcreate();
    extern int _uiofd();
    struct _ufile *uf;
    int fd;

    USYS_BEG();
#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_INET) {
	_dbgl("SOCKET&socket(af=");
	_dbgd(af);
	_dbgs(", type=");
	_dbgd(type);
	_dbgs(", protocol=");
	_dbgd(protocol);
	_dbgs(")\r\n");
    }
#endif

    if (af != AF_INET)
	USYS_RETERR(EAFNOSUPPORT);

    if (type != SOCK_STREAM)
	USYS_RETERR(ESOCKTNOSUPPORT);

    if (protocol != 0)
	USYS_RETERR(EPROTONOSUPPORT);

    if ((fd = _uiofd()) < 0 || !(uf = _ufcreate()))
	USYS_RETERR(ENFILE);

    uf->uf_nopen = 1;		/* Pretend UF open so don't get again */
    USYS_VAR_REF(uffd[fd]) = uf; /* Pretend ditto for FD */
#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_INET) {
	_dbgl("SOCKET&socket() ==> fd=");
	_dbgd(fd);
	_dbgs("\r\n");
    }
#endif
    USYS_RET(fd);		/* return slot# */
}

