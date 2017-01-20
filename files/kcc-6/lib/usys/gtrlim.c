#include <c-env.h>
#include <jsys.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/resource.h>
#include <sys/usydat.h>

extern caddr_t _eallo;
extern caddr_t _end;

int setrlimit(int resource, struct rlimit *rlp)
{
  if (0) return resource * rlp->rlim_cur; /* Make compiler happy */
  errno = EPERM;
  return -1;
}

int getrlimit(int resource, struct rlimit *rlp)
{
  int acs[5];

  switch (resource) {
  case RLIMIT_CPU:			/* cpu time in milliseconds */
    acs[1] = -1;
    acs[2] = (-1 << 18) | 3;
    acs[3] = monsym(".JIRTL");
    if (!jsys(GETJI, acs)) {
       errno = EINVAL;
       return -1;
    }
    if (!acs[3]) acs[3] = RLIM_INFINITY;
    rlp->rlim_cur = rlp->rlim_max = acs[3];
    break;
  case RLIMIT_FSIZE:			/* maximum file size */
    rlp->rlim_cur = rlp->rlim_max = 0777777777;
    break;
  case RLIMIT_DATA:			/* data size */
    rlp->rlim_cur = rlp->rlim_max = _eallo - _end;
    break;
  case RLIMIT_STACK:			/* stack size */
  case RLIMIT_CORE:			/* core file size */
  case RLIMIT_RSS:			/* resident set size */
    rlp->rlim_cur = rlp->rlim_max = RLIM_INFINITY;
    break;
  case RLIMIT_NOFILE:			/* maximum descriptor index + 1 */
    rlp->rlim_cur = rlp->rlim_max = OPEN_UF_MAX;
    break;
  }
  return 0;
}
