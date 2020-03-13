/*
**	CHMOD - change mode of file
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.10, 24-Aug-1987
**	(c) Copyright Ian Macky, SRI International 1987
*/

#include <c-env.h>

#if SYS_T20+SYS_10X	/* Systems supported for */

#include <sys/usydat.h>
#include <sys/file.h>
#include <sys/urtint.h>
#include <sys/types.h>
#include <errno.h>
#if SYS_T20+SYS_10X
#include <jsys.h>
#include <sys/c-parse.h>
#endif

int
chmod(path, mode)
const char *path;
int mode;
{
#if SYS_T20+SYS_10X
    int jfn, ret;

    USYS_BEG();
    if (jfn = _gtjfn(path, O_RDONLY|O_T20_NO_DIR)) {
				/* get a JFN on the path */
      ret = _jchmod(jfn, mode); /* do the real work */
      _rljfn(jfn);		/* done with JFN, so release */
    }
    else {
      ret = _parse(path, _PARSE_IN_DIR, _crdir, monsym("CD%DPT"), mode);
      if ((ret == 0) || (ret == -1))
	USYS_RETERR(ENOENT);	/* failed, return no-entry error */
      ret = 0;			/* success, return 0 */
    }    
    USYS_RET(ret);		/* return fchmod's result */
#else
    return -1;
#endif
}

int
fchmod(fd, mode)
int fd;
mode_t mode;
{
#if SYS_T20+SYS_10X
    struct _ufile *uf;

    USYS_BEG();
    if (!(uf = _UFGET(fd)))
	USYS_RETERR(EBADF);			/* bad FD given */
    USYS_RETVOLATILE(_jchmod(uf->uf_ch, mode));	/* do the real work */
#else
    return -1;
#endif
}

#endif /* T20+10X */
