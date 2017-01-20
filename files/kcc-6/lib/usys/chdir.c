/*
**	CHDIR - change current working directory
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.3, 5-Jul-1987
**	(c) Copyright Ian Macky, SRI International 1987
*/

#include <c-env.h>

#if SYS_T20+SYS_10X	/* Systems supported for */

#include <sys/usydat.h>
#include <sys/urtint.h>
#include <sys/param.h>
#include <sys/file.h>
#include <sys/stat.h>
#include <errno.h>
#include <jsys.h>

extern int xstat();

int chdir(path)
char *path;
{
  struct xstat buf;
  int dirno;

  USYS_BEG();

  if (xstat(path, &buf)) USYS_RET(-1);

  dirno = buf.xst_dirno;

  if (!_chdir(dirno)) USYS_RETERR(EACCES);

  USYS_RET(0);
}

int fchdir(fd)
int fd;
{
  struct _ufile *uf;
  int dirno;
  
  USYS_BEG();
  
  if (!(uf = _UFGET(fd)))
    USYS_RETERR(EBADF);
  
  dirno = _jfndir(uf->uf_ch, _gtfdb(uf->uf_ch, _FBCTL) & FB_DIR);
  
  if (!dirno) USYS_RETERR(EINVAL);
  
  if (!_chdir(dirno)) USYS_RETERR(EACCES);
  
  USYS_RET(0);
}

#endif /* T20+10X */
