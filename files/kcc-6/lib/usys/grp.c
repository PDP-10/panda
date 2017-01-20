#include <c-env.h>
#include <stddef.h>
#include <grp.h>

struct group *getgrent()
{
  return NULL;
}

struct group *getgrgid(gid)
int gid;
{
  return NULL;
}

struct group *getgrnam(gname)
const char *gname;
{
  return NULL;
}

void setgroupent(stayopen)
int stayopen;
{
  return;
}

void setgrent()
{
  return;
}

void endgrent()
{
  return;
}
