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

#ifdef MAXPATHLEN	/* Max size of a complete filename string */
#elif SYS_T20
#define MAXPATHLEN 512
#elif SYS_10X
#define MAXPATHLEN 256	/* 10X has no subdirs */
#else
#define MAXPATHLEN 100	/* other systems have 6-char components */
#endif

#endif /* ifndef _SYS_PARAM_INCLUDED */
