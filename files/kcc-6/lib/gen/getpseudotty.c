#include <c-env.h>
#if SYS_T20+SYS_10X
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <jsys.h>
#include <errno.h>
#include <sys/usysio.h>

static int ptynum = -1, ptytty = 0;

static _KCCtype_char6 ptypar[] = "PTYPAR"; /* Make SIXBIT /PTYPAR/ */
int
getpseudotty(ttydev, ptydev)
char **ttydev, **ptydev;
{
  char tmpbuf[MAXPATHLEN], *tmppty, *tmptty;
  int i, fd;

  if (ptynum < 0) {		/* Initialized yet? */
    int acs[5];

    acs[1] = ((int *)ptypar)[0];
    if (jsys(SYSGT, acs)) {
      ptynum = acs[1] >> 18;	/* Number of PTYs */
      ptytty = acs[1] & RH;	/* TTY unit for PTY0: */
    }
    else ptynum = 0;		/* Don't try again */
  }
  for (i = 0; i < ptynum; i++) {
    sprintf(tmpbuf, "/dev/pty%o", i);
    fd = open (tmpbuf, O_RDWR | O_NDELAY | O_UNCONVERTED, 0);
    if (fd >= 0) {
      tmppty = malloc(strlen(tmpbuf)+1);
      if (!tmppty) {
	close(fd);
	errno = ENOMEM;
	return -1;
      }
      strcpy(tmppty, tmpbuf);
      sprintf(tmpbuf, "/dev/tty%o", i + ptytty);
      tmptty = malloc(strlen(tmpbuf)+1);
      if (!tmptty) {
	free(tmppty);
	close(fd);
	errno = ENOMEM;
	return -1;
      }
      strcpy(tmptty, tmpbuf);
      *ptydev = tmppty;
      *ttydev = tmptty;
      return fd;
    }
  }
  errno = ENODEV;
  return -1;			/* Can't get one */
}
#else /* SYS_T20+SYS_10X */
#error getpseudotty only available under T20 or 10X
#endif /* SYS_T20+SYS_10X */
