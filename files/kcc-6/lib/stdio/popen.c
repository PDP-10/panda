/*
**	POPEN - open pipe to command
**
*/

#include <stdioi.h>
#include <stdlib.h>
#include <errno.h>
#include <frkxec.h>
#include <sys/file.h>
#include <sys/wait.h>
#include <sys/usysio.h>
#include <sys/usydat.h>
#include <unistd.h>

#if __STDC__
#define CONST const
#else
#define CONST
#endif

FILE *popen(command, type)
CONST char *command, *type;
{
  int fildes[2], flags, uio_flags, writing;
  FILE *file;
  struct frkxec frkxec;
  char *av[4];

  if (!(flags = _sioflags(type, &uio_flags))) {
    errno = EINVAL;
    return NULL;
  }
  writing = (flags & _SIOF_WRITE);
  if (!(file = _makeFILE())) return NULL; /* get a FILE block */

  if (pipe(fildes)) goto err2;

  av[0] = "sh";
  av[1] = "-c";
  av[2] = (char *)command;
  av[3] = NULL;

  frkxec.fx_flags = FX_PGMSRCH | FX_PASSENV | FX_FDMAP;
					/* Search, pass environ, map stdio */
  frkxec.fx_name = "sh";		/* Program to run */
  frkxec.fx_argv = &av[0];		/* Arguments */
  frkxec.fx_envp = NULL;		/* Default environment */
  frkxec.fx_fdin = writing ? fildes[0] : -1;
  frkxec.fx_fdout = writing ? -1 : fildes[1];
  if (forkexec(&frkxec) < 0) goto err1;

  file->siopid = frkxec.fx_pid;

  _setFILE(file, fildes[writing ? 1 : 0], flags);
				/* Set up FILE block */

  /* Now forget we had anything to do with the fd we gave to the child */
  close(fildes[writing ? 0 : 1]);

  return file;

 err1:

  /* Discard fd's on error */
  close(fildes[0]);
  close(fildes[1]);

 err2:

  /* Return FILE structure on error */
  _freeFILE(file);				/* lose, release FILE * */
  return NULL;					/* barf return */
}

int pclose(file)
FILE *file;
{
  int pid, wpid, status;

  if (!(pid = file->siopid)) {
    errno = EINVAL;
    return -1;
  }

  if (fclose(file)) return -1;

  do {
    wpid = wait(&status);
    if (wpid < 0) return -1;
  } while (wpid != pid);

  return WEXITSTATUS(status);
}
