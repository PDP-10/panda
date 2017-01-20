#include <c-env.h>
#include <errno.h>
#include <jsys.h>
#include <sys/usydat.h>
#include <sys/vfs.h>

#if SYS_T20+SYS_10X
#include <sys/c-parse.h>

static int
_statfs(dev, buf)
int dev;
struct statfs *buf;
{
  int acs[5];

  acs[1] = dev;
  if (!jsys(GDSKC, acs)) return EIO;
  buf->f_type = MOUNT_UFS;
  buf->f_bsize = 512 * sizeof(int) / sizeof(char);
  buf->f_blocks = acs[1] + acs[2];
  buf->f_bfree = acs[2];
  buf->f_bavail = acs[2];
  buf->f_files = -1;
  buf->f_ffree = -1;
  buf->f_fsid.val[0] = dev;
  return 0;
}

int
fstatfs(fd, buf)
int fd;
struct statfs *buf;
{
  register struct _ufile *uf;
  int  i, acs[5];
  
  USYS_BEG();
  if (!(uf = _UFGET(fd)))
    USYS_RETERR(EBADF);
  acs[1] = uf->uf_ch;
  if (!jsys(DVCHR, acs))
    USYS_RETERR(EIO);
  i = _statfs(acs[1], buf);
  if (i) USYS_RETERR(i);
  USYS_RET(0);
}

static int
getdev(path, pflags, ap)
char *path;
int pflags;
va_list ap;
{
  int acs[5];

  acs[1] = (int)(path - 1);
  if (!jsys(STDEV, acs)) return 0;
  return acs[2];
}

int
statfs(path, buf)
char *path;
struct statfs *buf;
{
  int dev, i;
  
  USYS_BEG();
  dev = _parse(path, _PARSE_IN_DIR, getdev);
  if (!dev) USYS_RETERR(ENOENT);
  i = _statfs(dev, buf);
  if (i) USYS_RETERR(i);
  USYS_RET(0);
}

#endif /* SYS_T20+SYS_10X */
