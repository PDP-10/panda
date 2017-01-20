#ifndef _PATH_H_
#define _PATH_H_

/* Function prototypes */
#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

#include <c-env.h>

/* cgen:path.c */
#if SYS_T20+SYS_10X
extern int abspath P_((const char *name,char *result));
extern int path P_((char *path,char *direc,char *file));
extern int decomp P_((const char *path,char *dev,char *dir,char *name,char *type,char *gen,char *atr));
extern int fabspath P_((int fd,char *result));
extern int fpath P_((int fd,char *direc,char *file));
extern int fdecomp P_((int fd,char *dev,char *dir,char *name,char *type,char *gen,char *atr));
#endif 

#undef P_

#endif /* _PATH_H_ */
