/* <FCNTL.H> - definitions for fcntl(2)
**
**	(c) Copyright Ken Harrenstien 1989
**	(c) Copyright Ian Macky, SRI International 1987
**	Edits for ITS:  Copyright (C) 1988 Alan Bawden
**
**	Not all functions are implemented; others are invented for KCC.
**	This file should really go in <sys/fcntl.h> but we have to
**	remain compatible with BSD inconsistencies.
*/

#ifndef _FCNTL_INCLUDED
#define _FCNTL_INCLUDED 1

#include <c-env.h>

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

#endif /* ifndef _FCNTL_INCLUDED */
