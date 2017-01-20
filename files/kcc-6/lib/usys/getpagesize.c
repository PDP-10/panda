#include <c-env.h>
#if SYS_T20+SYS_10X

/* Return system page size in bytes. */
/* Not necessarily hardware page size. */
int
getpagesize()
{
  return 512 * sizeof(long);
}
#else
#error getpagsize() only supported on TOPS-20 and TENEX
#endif
