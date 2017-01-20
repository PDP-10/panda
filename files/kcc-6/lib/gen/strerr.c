/*
**	STRERR	- Implementation of strerror().
**
**	(c) Copyright Ken Harrenstien, SRI International 1987
**
**	Contains OS-dependent code so it can handle non-Unix OS errors.
*/

#include <c-env.h>
#include <stddef.h>	/* For NULL */
#include <errno.h>
#include <stdio.h>	/* For sprintf */

/* Array of error messages indexed by UN*X error number. */

char *sys_errlist[] = {
	"No error",					/* errno = 0 */
	"Not owner",					/* EPERM */
	"No such file or directory",			/* ENOENT */
	"No such process",				/* ESRCH */
	"Interrupted system call",			/* EINTR */
	"I/O error",					/* EIO */
	"No such device or address",			/* ENXIO */
	"Arg list too long",				/* E2BIG */
	"Exec format error",				/* ENOEXEC */
	"Bad file number",				/* EBADF */
	"No children",					/* ECHILD */
	"No more processes",				/* EAGAIN */
	"Not enough core",				/* ENOMEM */
	"Permission denied",				/* EACCES */
	"Bad address",					/* EFAULT */
	"Block device required",			/* ENOTBLK */
	"Mount device busy",				/* EBUSY */
	"File exists",					/* EEXIST */
	"Cross-device link",				/* EXDEV */
	"No such device",				/* ENODEV */
	"Not a director",				/* ENOTDIR */
	"Is a directory",				/* EISDIR */
	"Invalid argument",				/* EINVAL */
	"File table overflow",				/* ENFILE */
	"Too many open files",				/* EMFILE */
	"Not a typewriter",				/* ENOTTY */
	"Text file busy",				/* ETXTBSY */
	"File too large",				/* EFBIG */
	"No space left on device",			/* ENOSPC */
	"Illegal seek",					/* ESPIPE */
	"Read-only file system",			/* EROFS */
	"Too many links",				/* EMLINK */
	"Broken pipe",					/* EPIPE */
	"Argument too large",				/* EDOM */
	"Result too large",				/* ERANGE */
	"Operation would block",			/* EWOULDBLOCK */
	"Operation now in progress",			/* EINPROGRESS */
	"Operation already in progress",		/* EALREADY */
	"Socket operation on non-socket",		/* ENOTSOCK */
	"Destination address required",			/* EDESTADDRREQ */
	"Message too long",				/* EMSGSIZE */
	"Protocol wrong type for socket",		/* EPROTOTYPE */
	"Protocol not available",			/* ENOPROTOOPT */
	"Protocol not supported",			/* EPROTONOSUPPORT */
	"Socket type not supported",			/* ESOCKTNOSUPPORT */
	"Operation not supported on socket",		/* EOPNOTSUPP */
	"Protocol family not supported",		/* EPFNOSUPPORT */
	"Address family not supported by protocol family",/* EAFNOSUPPORT */
	"Address already in use",			/* EADDRINUSE */
	"Can't assign requested address",		/* EADDRNOTAVAIL */
	"Network is down",				/* ENETDOWN */
	"Network is unreachable",			/* ENETUNREACH */
	"Network dropped connection on reset",		/* ENETRESET */
	"Software caused connection abort",		/* ECONNABORTED */
	"Connection reset by peer",			/* ECONNRESET */
	"No buffer space available",			/* ENOBUFS */
	"Socket is already connected",			/* EISCONN */
	"Socket is not connected",			/* ENOTCONN */
	"Can't send after socket shutdown",		/* ESHUTDOWN */
	"Too many references: can't splice",		/* ETOOMANYREFS */
	"Connection timed out",				/* ETIMEDOUT */
	"Connection refused",				/* ECONNREFUSED */
	"Too many levels of symbolic links",		/* ELOOP */
	"File name too long",				/* ENAMETOOLONG */
	"Host is down",					/* EHOSTDOWN */
	"No route to host",				/* EHOSTUNREACH */
	"Directory not empty",				/* ENOTEMPTY */
	"Too many processes",				/* EPROCLIM */
	"Too many users",				/* EUSERS */
	"Disc quota exceeded"				/* EDQUOT */
};

/* SYS_NERR holds # of entries in SYS_ERRLIST. */
int sys_nerr = (sizeof sys_errlist)/(sizeof sys_errlist[0]);

#if SYS_T20+SYS_10X
static char *t20_errlist[] = {
	"Must truncate on write-only open",		/* ETRUNC */
	"Can't close file"  	    	    	    	/* ECLOSE */
};
static int t20_nerr = (sizeof t20_errlist)/(sizeof t20_errlist[0]) - 1;
#endif /* T20+10X */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* strerr.c */
static char *baderr P_((int num));
static char *strserr P_((int num));

#undef P_

char *
strerror(errnum)
int errnum;
{
    /* First check for any Un*x type errors.
    ** Note funny indexing because sys_errlist has to include a zero entry
    ** so user programs can index into it for any number < sys_nerr.
    */
    if ((_ERRNO_UNX_FIRST <= errnum)
	&& (errnum <= _ERRNO_UNX_LAST)
	&& (errnum < sys_nerr))
      return sys_errlist[errnum];
#if SYS_T20+SYS_10X
    if (_ERRNO_T20_FIRST <= errnum && errnum <= _ERRNO_T20_LAST
      && (errnum - _ERRNO_T20_FIRST) <= t20_nerr)
	return t20_errlist[errnum - _ERRNO_T20_FIRST];
    if (errnum == _ERRNO_LASTSYSERR)	/* On T20/10X this means to use */
	return strserr(errnum);		/* "last system error" */
#endif
    /* Now check for OS type errors */
    if (_ERRNO_SYS_FIRST <= errnum && errnum <= _ERRNO_SYS_LAST)
	return strserr(errnum);

    if (errnum == _ERRNO_LASTSYSERR && errnum != errno)
	return strerror(errno);

    /* If nothing matches, return a composed message. */
    return baderr(errnum);
}

/* baderr - Auxiliary to compose a "Unknown error #" message */
#define BADERR "Unknown error ("
static char *
baderr(num)
{
    static char badmsg[sizeof(BADERR)+12+1+1] = {BADERR};
				/* BADERR + 12 digits + ')' + null */
    char *p = &badmsg[sizeof(BADERR)-2]; /* Where to put digits */
    int n = 12;			/* Max digits */

    /* Do by hand to avoid loading sprintf() and its dependents */
    while (n && !((num >> (n * 3)) & 7)) n--;
    do *++p = '0' + ((num >> (n * 3)) & 7);
    while (n--);
    *++p = ')';
    *++p = '\0';

    return badmsg;
}

/* STRSERR - Auxiliary to return a system error message */
#if SYS_T20+SYS_10X
#include <jsys.h>
#endif

static char *
strserr(num)
{
#if SYS_T20+SYS_10X
#define SYSMSGLEN 80
    static char sysmsg[SYSMSGLEN];
    int acs[5];
    acs[1] = (int)(sysmsg-1);
    acs[2] = (_FHSLF<<18) + (num & RH);
    acs[3] = (-SYSMSGLEN)<<18;
    if (jsys(ERSTR, acs) > 0)
	return sysmsg;		/* Won, return ptr to resulting msg */
#endif
    return baderr(num);		/* Failed, just say unknown error. */
}
