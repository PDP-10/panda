/* <SYS/STAT.H> - definitions for stat(2), fstat(2)
**
**	(c) Copyright Ken Harrenstien 1989
**
**	As described by 4.3BSD UPM.  Note that not all of the stat
**	structure is meaningful for a particular system.
**	Some extended components were added for the KCC-only
**	xstat and xfstat calls.
*/

#ifndef _SYS_STAT_INCLUDED
#define _SYS_STAT_INCLUDED

#include <sys/types.h>

struct	stat
{
    dev_t st_dev;	/* Device inode is on */
			/*   T20: device designator */
			/*   T10: .RBDEV - SIXBIT device name */
    ino_t st_ino;	/* Inode number */
			/*   T20: .FBADR - Disk addr of file index blk*/
			/*   T10: .RBPOS - not sure if this is right */
    mode_t st_mode;	/* File type and protection */
			/*   T20: protection translated to Un*x format */
			/*   T10: protection translated to Un*x format */
    nlink_t st_nlink;	/* # of "links" to file */
			/*   T20: 1 always */
			/*   T10: 1 always */
    uid_t st_uid;	/* User ID of owner */
			/*   T20: User #, 10X: directory # */
			/*   T10: .RBAUT - PPN of creator */
    gid_t st_gid;	/* Group ID of owner */
			/*   T20: 0 always */
			/*   T10: (LH of st_uid) */
    dev_t st_rdev;	/* Device type (if inode is device) */
			/*   T20: Device info (DVCHR% val, includes .DVxxx) */
			/*   T10: Device type (DEVTYP val, includes TY.xxx) */
    off_t st_size;	/* Size of file, in bytes */
			/*   T20: .FBSIZ - (note bytesize can vary!) */
			/*   T10: .RBSIZ (# wds) converted to # bytes */
    time_t st_atime;	/* Last Access time, in Un*x format */
			/*   T20: .FBREF - last ref */
			/*   T10: max(.RBEXT,st_ctime) access date (midnite) */
    time_t st_mtime;	/* Last Modify time, in Un*x format */ 
			/*   T20: .FBWRT - last write open */
			/*   T10: .RBPRV creation date/time (mins) */
    time_t st_ctime;	/* Last status change time, in Un*x format */
			/*   T20: .FBCRE - last write close */
			/*   T10: max(.RBTIM, st_mtime) */
    long st_blksize;	/* Best file system I/O blocksize (in bytes) */
			/*   T20: # bytes in a page (derived from FB%BSZ) */
			/*   T10: 0200 wds, converted to # bytes */
    long st_blocks;	/* Actual # blocks allocated for file */
			/*   T20: # pages in file (FB%PGC of .FBBYV) */
			/*   T10: .RBEST - # blocks in file */
    long st_spares[4];	/* Spare wds for possible future additions */
};

/* Flags in st_mode.
**	Only S_IFMT and the permission flags are implemented.
*/
#define	S_ISUID	0004000		/* set user id on execution */
#define	S_ISGID	0002000		/* set group id on execution */
#ifndef _POSIX_SOURCE
#define	S_ISTXT	0001000			/* sticky bit */
#endif

#define	S_IRWXU	0000700			/* RWX mask for owner */
#define	S_IRUSR	0000400			/* R for owner */
#define	S_IWUSR	0000200			/* W for owner */
#define	S_IXUSR	0000100			/* X for owner */

#ifndef _POSIX_SOURCE
#define	S_IREAD		S_IRUSR
#define	S_IWRITE	S_IWUSR
#define	S_IEXEC		S_IXUSR
#endif

#define	S_IRWXG	0000070			/* RWX mask for group */
#define	S_IRGRP	0000040			/* R for group */
#define	S_IWGRP	0000020			/* W for group */
#define	S_IXGRP	0000010			/* X for group */

#define	S_IRWXO	0000007			/* RWX mask for other */
#define	S_IROTH	0000004			/* R for other */
#define	S_IWOTH	0000002			/* W for other */
#define	S_IXOTH	0000001			/* X for other */

#ifndef _POSIX_SOURCE
#define	S_IFMT	0170000		/* type of file */
#define    S_IFIFO	0010000	/* named pipe (fifo) */
#define    S_IFCHR	0020000	/* device: character special */
#define    S_IFDIR	0040000	/* directory */
#define    S_IFBLK	0060000	/* device: block special */
#define    S_IFREG	0100000	/* regular file */
#define    S_IFLNK	0120000	/* symbolic link */
#define    S_IFSOCK	0140000	/* socket */

#define	S_ISVTX	0001000		/* save swapped text even after use */

#define S_BLKSIZE (512*sizeof(int)) /* block size used in the stat struct */

					/* 0666 */
#define	DEFFILEMODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH)
#endif

#define	S_ISDIR(m)	((m & 0170000) == 0040000)	/* directory */
#define	S_ISCHR(m)	((m & 0170000) == 0020000)	/* char special */
#define	S_ISBLK(m)	((m & 0170000) == 0060000)	/* block special */
#define	S_ISREG(m)	((m & 0170000) == 0100000)	/* regular file */
#define	S_ISFIFO(m)	((m & 0170000) == 0010000)	/* fifo */
#ifndef _POSIX_SOURCE
#define	S_ISLNK(m)	((m & 0170000) == 0120000)	/* symbolic link */
#define	S_ISSOCK(m)	((m & 0170000) == 0140000)	/* socket */
#endif

/* KCC-dependent stuff */

/* Support for "extended stat" -  xstat() and xfstat().
** These are pretty much TOPS-20 specific at the moment.
*/
struct xstat {
    struct stat st;			/* include original structure */
    union {				/* device-dependent portion */
	struct {
	    int state;			/* connection state */
	    int fhost;			/* foreign host# */
	    int fport;			/* foreign port# */
	} tcp;
	struct {
	    int version;		/* version# of file */
	    int pagcnt;			/* count of # pages in file */
	    int bytsiz;			/* byte size of file */
	    int dirno;			/* directory number */
	} disk;
    } dev_dep;
};

#define xst_fhost	dev_dep.tcp.fhost
#define xst_fport	dev_dep.tcp.fport
#define xst_state	dev_dep.tcp.state
#define xst_version	dev_dep.disk.version
#define xst_pagcnt	dev_dep.disk.pagcnt
#define xst_bytsiz	dev_dep.disk.bytsiz
#define xst_dirno	dev_dep.disk.dirno

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

extern int stat P_((const char *name,struct stat *buf));
extern int lstat P_((const char *name,struct stat *buf));
extern int xstat P_((const char *name,struct xstat *buf));
extern int fstat P_((int fd,struct stat *buf));
extern int xfstat P_((int fd,struct xstat *buf));
extern int chmod P_((const char *path,int mode));
extern int fchmod P_((int fd,mode_t mode));
extern int umask P_((int numask));
extern int mkdir P_((const char *, mode_t));
extern int mkfifo P_((const char *, mode_t));
#undef P_

#endif /* ifndef _SYS_STAT_INCLUDED */
