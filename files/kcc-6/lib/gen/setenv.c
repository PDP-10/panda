/* 
** SETENV, PUTENV - Put value for environment name
**
**	Copyright (c) 1987 by Ken Harrenstien, SRI International
**
** Original idea of using logical names from:
**	Bill Palmer / Stanford University / November 1984
*/

#include <c-env.h>

#if SYS_T20

#include <stddef.h>		/* For NULL */
#include <stdlib.h>
#include <string.h>

extern char **environ;
extern char **`$ENVPT`;
extern int `$ENVSZ`;
extern char *_getenv(
#ifdef __STDC__
char *name
#endif
);

#define ENVQUANT 100

/* set environment variable */
static int _setenv(name, len, value, overwrite)
char *name, *value;
int len, overwrite;
{
  int ind, i;
  char *old = NULL, *valp = value, **tenv;

  /* Normalize arguments */
  if (len <= 0) len = strlen(name);
  if (name[len-1] == '=') len--;
  if (valp && (*valp == '=')) valp++;

  if (_getenv(name, len, &ind)) {
    if (!overwrite) return 0;
    old = environ[ind];
    environ[ind] = NULL;
  }
  if (valp == NULL) {
    do environ[ind] = environ[ind+1];
    while (environ[++ind]);
    return 0;
  }
  environ[ind] = (char *)malloc(len + strlen(valp) + 2);
  if (!environ[ind]) {
    environ[ind] = old;
    return -1;
  }
  if (environ != `$ENVPT`) {
    `$ENVPT` = environ;		/* Update pointer to known environment */
    `$ENVSZ` = 1;		/* Count NULL at end */
    for (tenv = `$ENVPT`; *tenv; tenv++) `$ENVSZ`++;
				/* Count entries in table */
  }
  if (ind >= (`$ENVSZ` - 1)) {
    tenv = malloc(`$ENVSZ` + ENVQUANT);
    if (!tenv) {
      environ[ind] = old;
      return -1;
    }
    `$ENVSZ` += ENVQUANT;
    for (i=0;i<=ind; i++)
      tenv[i] = environ[i];
    tenv[i] = NULL;
    environ = tenv;
  }
  strncpy(environ[ind], name, len);
  environ[ind][len] = '=';
  strcpy(&environ[ind][len+1], valp);
  if (!old) environ[ind+1] = NULL;
  return 0;
}

/* PUTENV - based on SYSV description.
**	Argument is a string in "name=value" form.  Adds this to 
** the environment of current process.  Not clear if we want to
** emulate the (vague) SYSV description which indicates that putenv
** may only store a pointer, and the actual string buffer remains under
** user control.
*/
int
putenv(namval)
const char *namval;
{
  char *value;
  int len;

  value = strchr(namval, '=');
  if (value == NULL) return -1;
  len = value - namval;
  value++;
  return _setenv(namval, len, value, 1);
}

int setenv(name, value, overwrite)
const char *name, *value;
int overwrite;
{
  return _setenv(name, 0, value, overwrite);
}

void unsetenv(name)
const char *name;
{
  (void)_setenv(name, 0, (char *)NULL, 1);
}

#endif /* !T20 */
