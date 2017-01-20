/* Provide backwards compatibility, the real defs live in <dirent.h> */
#ifndef _DIR_H_
#define _DIR_H_

#include <dirent.h>

#define direct dirent

/*
 * The DIRSIZ macro gives the minimum record length which will hold
 * the directory entry.  This requires the amount of space in struct
 direct
 * without the d_name field, plus enough space for the name with a
 terminating
 * null byte (dp->d_namlen+1), rounded up to a 4 byte boundary.
 */
#undef DIRSIZ
#define DIRSIZ(dp) \
    ((sizeof (struct direct) - (MAXNAMLEN+1)) + (((dp)->d_namlen+1 + 3) &~ 3))

#endif /* _DIR_H_ */
