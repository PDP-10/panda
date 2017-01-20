/* <ERRNO.H> - Error code definitions
**
**	(c) Copyright Ken Harrenstien 1989
**
** In addition to the dpANS error codes, we also define all of the
** BSD errors that we know about (from 4.2 and 4.3 UPM).
** Most of these are irrelevant or unimplemented on TOPS-20.
** Nevertheless, they are included here so that code which wants to
** use them can win.
*/

#ifndef _ERRNO_INCLUDED
#define _ERRNO_INCLUDED

#include <c-env.h>		/* For OS-dependent errno defs */

extern int errno;		/* Error variable */
#if 0
extern int sys_nerr;		/* BSD (but not ANSI), defined in STRERR.C */
extern char *sys_errlist[];
#endif

#define _ERRNO_UNX_FIRST 1	/* First defined Un*x error */
#define EPERM		1	/* Not owner */
#define ENOENT		2	/* No such file or directory */
#define ESRCH		3	/* No such process */
#define EINTR		4	/* Interrupted system call */
#define EIO		5	/* I/O error */
#define ENXIO		6	/* No such device or address */
#define E2BIG		7	/* Arg list too long */
#define ENOEXEC		8	/* Exec format error */
#define EBADF		9	/* Bad file number */
#define ECHILD		10	/* No children */
#define EAGAIN		11	/* No more processes */
#define ENOMEM		12	/* Not enough core */
#define EACCES		13	/* Permission denied */
#define EFAULT		14	/* Bad address */
#define ENOTBLK		15	/* Block device required */
#define EBUSY		16	/* Mount device busy */
#define EEXIST		17	/* File exists */
#define EXDEV		18	/* Cross-device link */
#define ENODEV		19	/* No such device */
#define ENOTDIR		20	/* Not a directory*/
#define EISDIR		21	/* Is a directory */
#define EINVAL		22	/* Invalid argument */
#define ENFILE		23	/* File table overflow */
#define EMFILE		24	/* Too many open files */
#define ENOTTY		25	/* Not a typewriter */
#define ETXTBSY		26	/* Text file busy */
#define EFBIG		27	/* File too large */
#define ENOSPC		28	/* No space left on device */
#define ESPIPE		29	/* Illegal seek */
#define EROFS		30	/* Read-only file system */
#define EMLINK		31	/* Too many links */
#define EPIPE		32	/* Broken pipe */
#define EDOM		33	/* ANSI: Math package: Domain (arg) error */
#define ERANGE		34	/* ANSI: Math package: Result too large */
#define EWOULDBLOCK	35	/* Operation would block */
#define EINPROGRESS	36	/* Operation now in progress */
#define EALREADY	37	/* Operation already in progress */
#define ENOTSOCK	38	/* Socket operation on non-socket */
#define EDESTADDRREQ	39	/* Destination address required */
#define EMSGSIZE	40	/* Message too long */
#define EPROTOTYPE	41	/* Protocol wrong type for socket */
#define ENOPROTOOPT	42	/* Bad protocol option */
#define EPROTONOSUPPORT	43	/* Protocol not supported */
#define ESOCKTNOSUPPORT	44	/* Socket type not supported */
#define EOPNOTSUPP	45	/* Operation not supported on socket */
#define EPFNOSUPPORT	46	/* Protocol family not supported */
#define EAFNOSUPPORT	47	/* Address family not supported by protocol family */
#define EADDRINUSE	48	/* Address already in use */
#define EADDRNOTAVAIL	49	/* Can't assign requested address */
#define ENETDOWN	50	/* Network is down */
#define ENETUNREACH	51	/* Network is unreachable */
#define ENETRESET	52	/* Network dropped connection on reset */
#define ECONNABORTED	53	/* Software caused connection abort */
#define ECONNRESET	54	/* Connection reset by peer */
#define ENOBUFS		55	/* No buffer space available */
#define EISCONN		56	/* Socket is already connected */
#define ENOTCONN	57	/* Socket is not connected */
#define ESHUTDOWN	58	/* Can't send after socket shutdown */
#define ETOOMANYREFS	59	/* Too many references, can't splice */
#define ETIMEDOUT	60	/* Connection timed out */
#define ECONNREFUSED	61	/* Connection refused */
#define ELOOP		62	/* Too many levels of symbolic links */
#define ENAMETOOLONG	63	/* File name too long */
#define EHOSTDOWN	64	/* Host is down */
#define EHOSTUNREACH	65	/* Host is unreachable */
#define ENOTEMPTY	66	/* Directory not empty */
#define EPROCLIM	67	/* Too many processes */
#define EUSERS		68	/* Too many users */
#define EDQUOT		69	/* Disc quota exceeded */

#define _ERRNO_UNX_LAST	EDQUOT	/* Last defined Un*x error */

/* OS-dependent definitions */

#if SYS_T20+SYS_10X
#define _ERRNO_SYS_FIRST 0600000	/* Non-Un*x system error #s */
#define _ERRNO_SYS_LAST  0677777

/* Un*x-like error numbers just for KCC Un*x-like errors. */
#define _ERRNO_T20_FIRST 1001	/* T20 error codes start at this value! */
#define ETRUNC		1001	/* Must truncate on write-only open */
#define ECLOSE    	1002	/* Can't close file */
#define _ERRNO_T20_LAST	ECLOSE	/* Last defined T20 error */

#endif /* T20+10X */

#ifndef _ERRNO_SYS_FIRST	/* Ensure these are always defined */
#define _ERRNO_SYS_FIRST 0
#define _ERRNO_SYS_LAST  0
#endif

#define _ERRNO_LASTSYSERR (-1)	/* Arg for strerror() to hack last sys err */

#endif /* ifndef _ERRNO_INCLUDED */
