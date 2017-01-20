/*
**	CRYPT	- Implements crypt()
**
**	(c) Copyright Ken Harrenstien, SRI International 1988
**
*/

#include <c-env.h>
#if SYS_T20+SYS_10X		/* Systems supported for */

#include <jsys.h>
#include <sys/param.h>		/* For NAME_MAX */

static char res[NAME_MAX];

/* Note: On TOPS-20, the 'setting' is ignored and the system default */
/* encryption verions is used. The key is encrypted and returned as */
/* the function value. */

char *
crypt(const char *key, const char *setting)
{
  int acs[5];

  if (0) setting++;		/* Reference unused arg */
  acs[1] = -1;			/* System default encryption version */
  acs[2] = (int) (key - 1);	/* Input string */
  acs[3] = (int) (res - 1);	/* Output string */
  if (!jsys(CRYPT,acs)) return 0; /* Return null on failure */
  return res;
}

#endif /* T20+10X */
