#include <c-env.h>
#include <errno.h>
#include <jsys.h>
#include <limits.h>
#include <sys/usydat.h>
#include <sys/usysio.h>
#include <sys/urtint.h>
#include <sys/file.h>

#if SYS_T20+SYS_10X

static int
_truncate(jfn, size, bsize)
int jfn;
off_t size;
int bsize;
{
  int acs[5], byv, newpos;

  acs[1] = jfn;
  acs[2] = XWD(1,monsym(".FBBYV"));	/* Get .FBBYV */
  acs[3] = (int) &byv;
  if (!jsys(GTFDB, acs)) return EBADF;

  newpos = _nfbsz(bsize,	/* Derive # bytes */
		  FLDGET(byv, monsym("FB%BSZ")),
		  size);
  acs[1] = (_FBSIZ << 18) | jfn;
  acs[2] = 0777777777777;
  acs[3] = newpos;
  if (!jsys(CHFDB, acs)) return EIO;
  return 0;
}

int
ftruncate(fd, size)
int fd;
off_t size;
{
    register struct _ufile *uf;
    int  i, acs[5];

    USYS_BEG();
    if (!(uf = _UFGET(fd)))
	USYS_RETERR(EBADF);
    acs[1] = uf->uf_ch;
    if (jsys(RFPTR, acs))
      uf->uf_pos = acs[2];	/* Get correct position */
    i = _truncate(uf->uf_ch, size, uf->uf_bsize);
    if (i) USYS_RETERR(i);
    acs[1] = CO_NRJ | uf->uf_ch;
    if (jsys(CLOSF, acs)) {
      acs[1] = uf->uf_ch;
      /* Read+write is the only reasonable choice here */
      acs[2] = (uf->uf_bsize << 30) | OF_RD | OF_WR;
      if (!jsys(OPENF, acs))
	USYS_RETERR(EIO);
      /* File position reset by OPENF */
      uf->uf_pos = 0;
    }
    lseek(fd, size, L_SET);	/* Re-position to end */
    USYS_RET(0);
}

int
truncate(name, size)
char *name;
off_t size;
{
    int jfn, i;

    USYS_BEG();

    if ((jfn = _gtjfn(name, O_RDONLY)) == 0)
      USYS_RETERR(ENOENT);
    i = _truncate(jfn, size, CHAR_BIT);
    _rljfn(jfn);
    if (i) USYS_RETERR(i);
    USYS_RET(0);
}

#endif /* SYS_T20+SYS_10X */
