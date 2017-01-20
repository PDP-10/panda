/*
**	UNLINK - remove link to (delete) file
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.27, 5-Jul-1987
**
** Original version by David Eppstein / Stanford University / 9-Aug-84
** TENEX/ITS additions by Ken Harrenstien, SRI  1-Jun-85
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported for */

#include <sys/file.h>
#include <sys/usysig.h>
#include <errno.h>

#if SYS_T20+SYS_10X
#include <jsys.h>
extern int _gtjfn();

#elif SYS_T10+SYS_CSI+SYS_WTS
#include <muuo.h>
#include <sys/usysio.h>
extern int _fparse(), _frename();

#elif SYS_ITS
#include <syscal.h>
#endif

int
unlink(file)
char *file;
{
#if SYS_T20+SYS_10X
    int jfn, ablock[5];

    USYS_BEG();
    jfn = _gtjfn(file, O_RDONLY);	/* get a handle on the file */
    if (jfn == 0)
	USYS_RETERR(ENOENT);		/* no such file, fail */
    ablock[1] = jfn
#if SYS_T20
	+ DF_EXP
#endif
	;
    if (jsys(DELF, ablock) <= 0)	/* return 0 on success, -1 failure */
	USYS_RETERR(EACCES);		/* Later should do better than this! */

    USYS_RET(0);
#elif SYS_ITS

    USYS_BEG();
    if (SYSCALL1("delete", file-1))
	USYS_RETERR(ENOENT);
    USYS_RET(0);

#elif SYS_T10+SYS_CSI+SYS_WTS
    int err;
    struct _filespec fs, fsdel;

    USYS_BEG();

    if (err = _fparse(&fs, file))	/* Parse the filename string */
	USYS_RETERR(err);		/* Oops */
    fsdel = fs;				/* Won, set up rename-to filespec */
    fsdel.fs_nam = 0;			/* Forcing a delete */
    if (err = _frename(&fs, &fsdel))	/* Do the "rename"! */
	USYS_RETERR(err);
    USYS_RET(0);			/* Success */
#else
    return -1;
#endif
}

#endif /* T20+10X+T10+CSI+WTS+ITS */
