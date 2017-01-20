#include <c-env.h>
#include <sys/usydat.h>

int getdtablesize()
{
  return OPEN_MAX;
}
