/*
**	WRITEV - BSD-type iovec writer
**
**	Copyright (C) 1990 by Ian Macky, cisco Systems
*/

#include <sys/types.h>
#include <sys/usysio.h>
#include <sys/uio.h>				/* define iovec */
#include <errno.h>

int writev(fd, iov, iovcnt)
int fd;
const struct iovec *iov;
int iovcnt;
{
    int i, sent, total;

    for (total = i = 0; i < iovcnt; i++) {
	sent = write(fd, (char *) iov[i].iov_base, iov[i].iov_len);
	if (sent < 0) {		/* Error? */
	    if (total && ((errno == EWOULDBLOCK) || (errno == EINTR)))
		break;		/* Done if EWOULDBLOCK/EINTR and input read */
	    return -1;		/* Else return error */
	}
	total += sent;		/* Update amount written */
	/* Check for partial output */
	if (sent < iov[i].iov_len) break; /* Partial output, done */
    }
    return total;
}
