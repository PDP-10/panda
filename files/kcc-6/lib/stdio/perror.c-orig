/*
**	PERROR	- Print error message
**
**	(c) Copyright Ken Harrenstien 1989
**
**	Currently only handles value in errno.
**	Could be extended to handle OS errors.
*/

#include <stdio.h>
#include <string.h>	/* For strerror() */
#include <errno.h>	/* For errno */

#if __STDC__
#define CONST const
#else
#define CONST
#endif


void
perror(s)
CONST char *s;
{
    char *p;

    if (s && *s) fputs(s, stderr);
    fputs(": ", stderr);
    p = strerror(errno);
    if (p) fprintf(stderr, "%s\n", p);
    else fprintf(stderr, "No string for error # %d\n", errno);
}
