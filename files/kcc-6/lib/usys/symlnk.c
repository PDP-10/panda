#include <c-env.h>
#include <errno.h>

int
symlink(file1, file2)
char *file1, *file2;
{
  if (0) return *file1 + *file2; /* avoid compiler complaint */
  errno = EINVAL;
  return -1;
}
