/*
**	PERROR.C
**		Currently only handles value in errno.
**		Could be extended to handle OS errors.
*/

#include <stdio.h>
#include <errno.h>

static char *sys_errlist[] = {
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

static char *t20_errlist[] = {
	"No TOPS-20 error",				/* not used */
	"Must truncate on write-only open",		/* ETRUNC */
	"Can't close file"  	    	    	    	/* ECLOSE */
};

#include <c-env.h>

char *strerror(errnum)
int errnum;
{
#if SYS_T20+SYS_10X
    if (errnum > T20_ERR && errnum <= LAST_T20_ERROR)
	return t20_errlist[errnum - T20_ERR];
#endif
    if (errnum > 0 && errnum <= LAST_ERROR)
	return sys_errlist[errnum];
    else return NULL;
}

void perror(s)
char *s;
{
    char *p;

    if (s && *s) fputs(s, stderr);
    fputs(": ", stderr);
    p = strerror(errno);
    if (p) fprintf(stderr, "%s\n", p);
    else fprintf(stderr, "No string for error # %d\n", errno);
}

#ifdef COMMENT	/* Old stuff for T20/10X */

perror:
	movei	1,.cttrm	;to controlling tty (stderr)
	%chrbp	2,-1(17)	; Get BP to start of arg string (1st arg)
	setz	3,		; Send up to null
	sout%			;send off arg string
	 erjmp	errerr
	hrroi	2,[asciz/: /]	;colon
	setz	3,		;to null
	sout%			;that too
	 erjmp	errerr
	hrloi	2,.fhslf	;last error on self
	setz	3,		;no limit
	erstr%			;make error string
	 jrst	errerr
	 jrst	errerr
	hrroi	2,[asciz/
/]				;crlf
	setz	3,		;to null
	sout%			;send off
	 erjmp	errerr
	popj	17,		;done

errerr:	hrroi	1,[asciz/Error within an error/]
	esout%
	popj	17,

#endif
