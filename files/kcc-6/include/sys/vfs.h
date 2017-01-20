#ifndef	_VFS_VFS_H_
#define	_VFS_VFS_H_

/*
 * File system types
 */
#define MOUNT_UFS	0
#define MOUNT_NFS	1
#define MOUNT_PC	2
#define MOUNT_AFS	3
#define MOUNT_CFS	4
#define MOUNT_MAXTYPE	4

/*
 * File system identifier. Should be unique (at least per machine).
 */
typedef struct {
	long val[2];			/* file system id type */
} fsid_t;

/*
 * file system statistics
 */
struct statfs {
	long f_type;			/* type of info, zero for now */
	long f_bsize;			/* fundamental file system block size */
	long f_blocks;			/* total blocks in file system */
	long f_bfree;			/* free block in fs */
	long f_bavail;			/* free blocks avail to non-superuser */
	long f_files;			/* total file nodes in file system */
	long f_ffree;			/* free file nodes in fs */
	fsid_t f_fsid;			/* file system id */
	long f_spare[7];		/* spare for later */
};

/* Function prototypes */
#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* statfs.c */
extern int fstatfs P_((int fd,struct statfs *buf));
extern int statfs P_((char *path,struct statfs *buf));

#undef P_

#endif /* _VFS_VFS_H_ */
