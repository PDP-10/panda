/* ASSERT.C - Support for <assert.h> diagnostic macro facility.
**
**	(c) Copyright Ken Harrenstien 1989
**
**	Provides internal support for the assert() macro as described by the
** ANSI C draft, plus an alternative for use when ANSI-style preprocessing
** isn't in effect.
**	Note stderr had better not be buffered!
*/

#include <assert.h>	/* For checking declaration consistency */
#include <stdio.h>	/* For fprintf, stderr */
#include <stdlib.h>	/* For abort */

void
_assert(expr, file, line)
char *expr, *file;
int line;
{
    if (expr)
	fprintf(stderr,"Assertion failed: (%s), file %s, line %d\n",
			expr, file, line);
    else
	fprintf(stderr,"Assertion failed: file %s, line %d\n",
			file, line);
    abort();
}
