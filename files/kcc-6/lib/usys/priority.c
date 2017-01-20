/*
**	PRIORITY - USYS simulation of getpriority()/setpriority().
**
*/

#include <c-env.h>

#include <sys/resource.h>
#include <errno.h>

int
getpriority(which, who)
int which, who;
{
  return 0;			/* Just return average priority for now */
}

int
setpriority(which, who, prio)
int which, who, prio;
{
  switch (which) {
  case PRIO_PROCESS:
  case PRIO_PGRP:
  case PRIO_USER:
    if (who) {
      errno = EPERM;
      return -1;
    }
    if (prio < 0) {
      errno = EACCES;
      return -1;
    }
    return 0;			/* Just say we did it */
  }
  errno = EINVAL;
  return -1;
}
