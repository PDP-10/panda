#include <c-env.h>
#include <unistd.h>
#include <errno.h>

int mkfifo(path, mode)
const char *path;
mode_t mode;
{
  errno = EINVAL;
  return -1;
}
