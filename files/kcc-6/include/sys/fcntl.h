/* <FCNTL.H> - definitions for fcntl(2)
**
**	(c) Copyright Ken Harrenstien 1989
**	(c) Copyright Ian Macky, SRI International 1987
**	Edits for ITS:  Copyright (C) 1988 Alan Bawden
**
**	Not all functions are implemented; others are invented for KCC.
**	These definitions emulate 4.3BSD, with some KCC additions.
*/

#ifndef _FCNTL_INCLUDED
#define _FCNTL_INCLUDED 1

#include <c-env.h>
#include <sys/types.h>

/*
 * Flock call.
 */
#define LOCK_SH         1       /* shared lock */
#define LOCK_EX         2       /* exclusive lock */
#define LOCK_NB         4       /* don't block when locking */
#define LOCK_UN         8       /* unlock */

/*
**	open(2) mode flags
*/
	/* BSD4.x flags (07077) */
#define O_RDONLY	(0)		/* Open for reading only */
#define O_WRONLY	(01)		/* Open for writing only */
#define O_RDWR		(02)		/* Open for reading and writing */
#define O_NDELAY	(04)		/* Don't block on open */
#define O_APPEND	(010)		/* Append on each write */
/*			(060)*/		/* 2 bits reserved */
#define O_CREAT		(01000)		/* Create file if it does not exist */
#define O_TRUNC		(02000)		/* Truncate size to 0 */
#define O_EXCL		(04000)		/* Error if create and file exists */
	/* KCC specific flags (0170700) */
#define O_BINARY	(0100)		/* Open in binary mode (sys-dep) */
#define O_CONVERTED	(0200)		/* Forced conversion requested */
#define O_UNCONVERTED	(0400)		/* Forced NO conversion requested */
#define O_BSIZE_MASK	(070000)	/* Mask: Force specified byte size */
#define  O_BSIZE_7	(010000)	/*   Bytesize value: 7-bit */
#define  O_BSIZE_8	(020000)	/*   Bytesize value: 8-bit */
#define  O_BSIZE_9	(030000)	/*   Bytesize value: 9-bit */
#define O_SYSFD		(0100000)	/* Open using "system FD" (T20: JFN) */

	/* OS specific flags (077,,0) */
	/* Distinct systems could overlay each other's flags. */
#define O_T20_WILD	(1<<18)		/* Allow wildcards on GTJFN% */
#define O_T20_WROLD	(1<<19)		/* For writes, do NOT use GJ%FOU */
#define O_T20_SYS_LOG	(1<<20)		/* Logical device is system-wide! */
#define O_T20_THAWED	(1<<21)		/* Open file for thawed access */

#define O_ITS_IMAGE	(1<<22)		/* Force image mode */
#define O_ITS_NO_IMAGE	(1<<23)		/* Force no image mode */

#define O_T20_DEF_MODE	(1<<24)		/* Use default protection on TOPS20 */
#define O_T20_NO_DIR	(1<<25)		/* Don't find directory file */

/* fcntl() commands */
#define	F_DUPFD		0	/* Duplicate FD */
#define	F_GETFD		1	/* Get the close-on-exec flag */
#define	F_SETFD		2	/* Set the close-on-exec flag */
#define	F_GETFL		3	/* Get descriptor status flags */
#define	F_SETFL		4	/* Set descriptor status flags */
#define	F_GETOWN 	5	/* Get process ID or group */
#define F_SETOWN 	6	/* Set process ID or group */

#if SYS_T20+SYS_10X+SYS_ITS+SYS_T10+SYS_CSI+SYS_WTS
#define F_GETSYSFD	7	/* Get actual system FD (T20: JFN) for FD */
#define F_GETBYTESIZE	8	/* Get byte-size file was opened in */

/* NOT IMPLEMENTED YET (may never be; see O_SYSFD in <sys/file.h>) */
#define F_SETSYSFD	9	/* Set/make a FD given system FD (T20: JFN) */
#endif

/* File descriptor status flags.
**	Keep BSD etc flags in the low 9 bits to avoid conflicts with internal
**	or KCC-specific flags.
*/
#define FAPPEND	01	/* Force each write to append at EOF */
#define FASYNC	02	/* Enable SIGIO signal when I/O possible (TTY only) */
#define FNDELAY	04	/* Non-blocking I/O (TTY only) */

/* KCC-specific flags.  Keep these out of the low 9 bits. */
#define FDF_CVTEOL	01000	/* Force CRLF<->LF conversion */
#define FDF_OLDFILE	02000	/* This is an old file */
#define FDF_READ	04000	/* Open for reading */
#define FDF_WRITE	010000	/* Open for writing */
#define FDF_HANDPACK	020000	/* ITS: Packing/unpacking bytes by hand */
#define FDF_CANHANG	040000	/* Device can block on input (ie not disk) */
#define	FDF_BLKDEV	0100000	/* Device uses block mode */
#define	FDF_BMODIF	0200000	/* Block Buffer modified */
#define	FDF_BREAD	0400000	/* Block Buffer read in */
#define	FDF_ISSYNC	01000000	/* T10: IO.SYN set */
#define	FDF_OCHAN	02000000	/* T10: chan open */
#define	FDF_OREAD	04000000	/* T10: chan open for read */

#include <sys/cdefs.h>

__BEGIN_DECLS

extern int fcntl __P((int fd,int cmd,int arg));
extern int creat __P((const char *path, mode_t mode));
extern int open __P((const char *path, int flags, ...));
#ifndef _POSIX_SOURCE
int     flock __P((int, int));
#endif /* !_POSIX_SOURCE */

__END_DECLS

#endif /* ifndef _FCNTL_INCLUDED */
