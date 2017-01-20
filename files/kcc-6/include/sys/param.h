/* <SYS/PARAM.H> - Un*x system-dependent definitions.
**
**	(c) Copyright Ken Harrenstien 1989
**
**	This file on UN*X is a kernel parameter file.
**	It is used for KCC only because certain library functions direct
**	the user to include <sys/param.h> for some definitions.
*/

#ifndef _SYS_PARAM_INCLUDED
#define _SYS_PARAM_INCLUDED

#include <c-env.h>	/* Things may vary depending on system */

#define OPEN_MAX 64	/* Max FDs we can have open */

#ifdef MAXPATHLEN	/* Max size of a complete filename string */
#elif SYS_T20
#define MAXPATHLEN 512
#elif SYS_10X
#define MAXPATHLEN 256	/* 10X has no subdirs */
#else
#define MAXPATHLEN 100	/* other systems have 6-char components */
#endif

#ifndef PATH_MAX
#define PATH_MAX MAXPATHLEN
#endif

#define NAME_MAX 255	/* For compatibility with POSIX */

#define NGROUPS_MAX 16	/* same as on devon */
#define NGROUPS NGROUPS_MAX

#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

#endif /* ifndef _SYS_PARAM_INCLUDED */
