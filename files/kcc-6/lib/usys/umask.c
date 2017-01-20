#include <c-env.h>
#include <sys/usydat.h>

int umask(int numask)
{
  int oumask;

  oumask = USYS_VAR_REF(umask);
  USYS_VAR_REF(umask) = numask & 0777;
  return oumask;
}
