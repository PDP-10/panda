/*
**	RENAME - rename an existing file
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.127, 16-Dec-1987
**	Copyright (c) 1987 by Ian Macky, SRI International
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS	/* Systems supported for */

#include <stdio.h>
#include <errno.h>
#include <sys/file.h>
#include <sys/usysig.h>

#if SYS_T20+SYS_10X
#include <jsys.h>
extern int _gtjfn(), _rljfn();

#elif SYS_T10+SYS_CSI+SYS_WTS
#include <muuo.h>
#include <sys/usysio.h>
extern int _fparse(), _frename();
#endif

#if __STDC__
#define CONST const
#else
#define CONST
#endif

int
rename(old, new)
CONST char *old, *new;
{
#if SYS_T20+SYS_10X
    int ablock[5], ojfn, njfn, ret;

    USYS_BEG();
    if (!(ojfn = _gtjfn(old, O_RDONLY)))	/* get JFN on old file */
	USYS_RETERR(ENOENT);			/* failed! */
    if (!(njfn = _gtjfn(new, O_WRONLY))) {	/* get JFN on new file */
	_rljfn(ojfn);				/* failed; release jfn on */
	USYS_RETERR(ENOENT);			/* old file and err return */
    }
    ablock[1] = ojfn;
    ablock[2] = njfn;
    ret = jsys(RNAMF, ablock);		/* do the rename */
    _rljfn(njfn);			/* release the new jfn */
    if (!ret) {
	_rljfn(ojfn);
	USYS_RETERR(EXDEV);		/* Most likely reason */
    }
    USYS_RET(0);			/* take win return */

#elif SYS_T10+SYS_CSI+SYS_WTS
    int err;
    struct _filespec fs, fsnew;

    USYS_BEG();
    if ((err = _fparse(&fs, old))	/* Parse old filename string */
      || (err = _fparse(&fsnew, new)))	/* and new */
	USYS_RETERR(err);		/* Oops */
    if (err = _frename(&fs, &fsnew))	/* Do the rename! */
	USYS_RETERR(err);
    USYS_RET(0);			/* Success */

#else
    return -1;
#endif
}

#endif /* T20+10X+T10+CSI+WTS */
