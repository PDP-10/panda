#ifndef _DIRENT_H_
#define _DIRENT_H_

#include <c-env.h>

#ifdef SYS_T20

/* Undefine the JSYS which masks our DIR structure */
#undef DIR
#include <sys/types.h>
#include <sys/param.h>
#include <errno.h>

/* limit fudge up from max fields of 39:<39>39.39.6;T which is 169 */
#define MAXNAMLEN 255		/* POSIX compliant */

struct dirent {
	u_long	d_ino;
	u_short d_reclen;
	u_short d_namlen;
	char	d_name[MAXNAMLEN+1];
};

typedef struct _dirdesc {
	int jfn;
	int fd;
	int state;
	int dirno;
        struct dirent ent;
} DIR;

/* Linker disambiguation */
#pragma private define rewinddir rwndir

#ifdef __STDC__
extern	DIR *opendir(const char *);
extern	struct dirent *readdir(DIR *);
extern	void closedir(DIR *);
extern	void rewinddir(DIR *);
extern	long telldir(DIR *);
extern	void seekdir(DIR *, long);
extern	int scandir(DIR *, struct dirent ***, int (*)(struct dirent*), int (*)(const void *, const void *));
extern	int dirfd(DIR *dir);
#else /* __STDC__ */
extern	DIR *opendir();
extern	struct dirent *readdir();
extern	void closedir();
extern	void rewinddir();
extern	long telldir();
extern	void seekdir();
extern	int scandir();
extern	int dirfd();
#endif /* __STDC__ */
#endif /* SYS_T20 */
#endif /* ifndef _DIRENT_H_ */
