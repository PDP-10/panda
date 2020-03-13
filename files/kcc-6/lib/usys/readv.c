/*
**	READV - BSD-type iovec reader
**
**	Copyright (C) 1990 by Ian Macky, cisco Systems
*/

#include <sys/types.h>
#include <sys/uio.h>				/* define iovec */
#include <sys/usysio.h>
#include <errno.h>

int readv(fd, iov, iovcnt)
int fd;
const struct iovec *iov;
int iovcnt;
{
    int i, got, total;

    for (total = i = 0; i < iovcnt; i++) {
	got = read(fd, (char *) iov[i].iov_base, iov[i].iov_len);
	if (got < 0) {		/* Error? */
	    if (total && ((errno == EWOULDBLOCK) || (errno == EINTR)))
		break;		/* Done if EWOULDBLOCK/EINTR and input read */
	    return -1;		/* Else return error */
	}
	total += got;		/* Update amount written */
	/* Check for partial input */
	if (got < iov[i].iov_len) break; /* Partial input, done */
    }
    return total;
}
