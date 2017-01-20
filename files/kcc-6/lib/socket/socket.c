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
 
int socket(af, type, protocol)
int af, type, protocol;
{   
    extern struct _ufile *_ufcreate();
    extern int _uiofd();
    struct _ufile *uf;
    int fd;

#if DEBUG
    printf("socket(af=%d, type=%d, protocol=%d)\n", af, type, protocol);
#endif
    if (af != AF_INET) {
	errno = EAFNOSUPPORT;
	return -1;
    }
    if (type != SOCK_STREAM) {
	errno = ESOCKTNOSUPPORT;
	return -1;
    }
    if (protocol != 0) {
	errno = EPROTONOSUPPORT;
	return -1;
    }
    if ((fd = _uiofd()) < 0 || !(uf = _ufcreate())) {
	errno = EMFILE;			/* not really correct, but WTF?  */
	return -1;
    }
    uf->uf_nopen = 1;		/* Pretend UF open so don't get again */
    USYS_VAR_REF(uffd[fd]) = uf; /* Pretend ditto for FD */
#if DEBUG
    printf("socket() --> %d\n", fd);
#endif
    return fd;					/* return slot# */
}

