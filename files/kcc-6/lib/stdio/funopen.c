/*
**	FUNOPEN - function open
**
**	(c) Copyright Richard P. Helliwell, XKL Systems Corporation 1994
**
*/

#include <stdioi.h>
#include <errno.h>

/* Function prototypes */
#if defined(__STDC__) || defined(__cplusplus)
#include <unistd.h>
# define P_(s) s
#else
# define P_(s) ()
#endif

FILE *funopen(cookie, readfn, writefn, seekfn, closefn)
void *cookie;
ssize_t (*readfn)P_((void *, void *, size_t));
ssize_t (*writefn)P_((void *, const void *, size_t));
fpos_t (*seekfn)P_((void *, fpos_t, int));
int (*closefn)P_((void *));
{
  /* Not implemented yet */
  errno = EINVAL;
  return (FILE *)-1;
}
