#include <c-env.h>
#include <unistd.h>
#include <errno.h>

int mknod(path, mode, dev)
const char *path;
mode_t mode;
dev_t dev;
{
  errno = EINVAL;
  return -1;
}
