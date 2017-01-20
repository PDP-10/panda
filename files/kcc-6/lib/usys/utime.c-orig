/*
**	UTIME - set file times
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.6, 11-Sep-1987
**	(c) Copyright Ian Macky, SRI International 1987
*/

#include <c-env.h>
#if SYS_T20+SYS_10X	/* Systems supported for */

#include <errno.h>
#include <sys/usysig.h>
#include <sys/time.h>
#include <sys/usysio.h>
#include <sys/file.h>
#if SYS_T20+SYS_10X
#include <jsys.h>
extern _gtjfn(), _rljfn();
#endif

int utime(file, timep)
char *file;
time_t timep[2];
{
#if SYS_T20+SYS_10X
    int jfn, ablock[5];

    USYS_BEG();
    if ((jfn = _gtjfn(file, O_RDONLY)) == 0)
	USYS_RETERR(ENOENT);

    ablock[1] = (_FBREF << 18) | jfn		/* read-time offset,,JFN */
		| _CFNUD;			/* plus no-update bit */
    ablock[2] = -1;				/* mask of bits to change */
    ablock[3] = tadl_from_utime(timep[0]);	/* new read time */
    if (!(jsys(CHFDB, ablock))) {
	_rljfn(jfn);
	USYS_RETERR(EACCES);			/* failed to set it */
    }

    ablock[1] = (_FBWRT << 18) | jfn;		/* write-time offset,,JFN */
    ablock[3] = tadl_from_utime(timep[1]);	/* new write time */
    if (!(jsys(CHFDB, ablock))) {
	_rljfn(jfn);
	USYS_RETERR(EACCES);			/* failed to set it */
    }
    _rljfn(jfn);
    USYS_RET(0);				/* else we won, so ret 0 */
#else
    return -1;
#endif
}
#endif /* T20+10X */
