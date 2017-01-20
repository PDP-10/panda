/* <SYS/TYPES.H> - common typedefs for USYS calls.
**
**	(c) Copyright Ken Harrenstien 1989
**
**	Names are those used by V7 and BSD; the types, however, are
**	system dependent and the definitions here assume a PDP-10 system.
*/

#ifndef _SYS_TYPES_INCLUDED
#define _SYS_TYPES_INCLUDED

/* Decompose st_rdev field */
#define major(x)	((int)(((unsigned)(x)>>18)&0777777))
#define minor(x)	((int)((x)&0777777))
#define makedev(maj, min) ((dev_t)(((maj)<<18)|(min)))

/* Convenient type abbreviations, apparently some code uses these */
typedef	unsigned char	u_char;
typedef	unsigned short	u_short;
typedef	unsigned int	u_int;
typedef	unsigned long	u_long;
#if 0
typedef	unsigned short	ushort;		/* ???ugh??? sys III/V compat ??? */
#endif

typedef	char *	caddr_t;	/* Core address */
typedef	int	daddr_t;	/* Disk address */
typedef int	dev_t;		/* Device type (stat(2)) */
typedef int	ino_t;		/* Inode # (T20: disk addr in stat(2)) */
typedef	long int off_t;		/* Disk file size (offset?) */
typedef int	uid_t;		/* User ID */
typedef int	gid_t;		/* Group ID */
typedef int	pid_t;		/* Process ID */
typedef unsigned mode_t;	/* File mode */
typedef int nlink_t;		/* File link count */
typedef struct _uquad { u_long val[2]; } u_quad;
typedef struct _quad  {   long val[2]; }   quad;
typedef long *qaddr_t;

#ifndef _CLOCK_T_
typedef long clock_t;		/* A processor time value */
#define _CLOCK_T_
#endif

#ifndef _SIZE_T_DEFINED		/* Avoid clash with ANSI <stddef.h> */
#define _SIZE_T_DEFINED
typedef	int	size_t;		/* Type big enough to hold any "sizeof" val */
#endif
#ifndef _TIME_T_DEFINED		/* Avoid clash with ANSI <time.h> */
#define _TIME_T_DEFINED
typedef	long	time_t;		/* Time value (# seconds since 1/1/70) */
#endif

#ifndef _POSIX_SOURCE
#define NBBY    9               /* number of bits in a byte */

/*
 * Select uses bit masks of file descriptors in longs.  These macros
 * manipulate such bit fields (the filesystem macros use chars).
 * FD_SETSIZE may be defined by the user, but the default here should
 * be enough for most uses.
 */
#ifndef FD_SETSIZE
#define FD_SETSIZE      256
#endif

typedef long    fd_mask;
#define NFDBITS (sizeof(fd_mask) * NBBY)        /* bits per mask */

#ifndef howmany
#define howmany(x, y)   (((x)+((y)-1))/(y))
#endif

typedef struct fd_set {
        fd_mask fds_bits[howmany(FD_SETSIZE, NFDBITS)];
      } fd_set;

#define FD_SET(n, p)    ((p)->fds_bits[(n)/NFDBITS] |= (1 << ((n) % NFDBITS)))
#define FD_CLR(n, p)    ((p)->fds_bits[(n)/NFDBITS] &= ~(1 << ((n) % NFDBITS)))
#define FD_ISSET(n, p)  ((p)->fds_bits[(n)/NFDBITS] & (1 << ((n) % NFDBITS)))
#define FD_ZERO(p)      bzero((char *)(p), sizeof(*(p)))

#endif /* _POSIX_SOURCE */
#endif /* _TYPES_INCLUDED */
