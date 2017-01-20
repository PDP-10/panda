#include <c-env.h>

#if SYS_T20+SYS_10X
#include <errno.h>
#include <jsys.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <mntent.h>

#define MAXSTRNAM 6
#define FSNAMPRE "/dev/"
#define _SIOF_MNTENT	(((-'M' * 'N' * 'T' * 'E') << 16) + 'S' + 'I' + 'O')

static struct mntent mnt;
static char fsname[MAXSTRNAM+sizeof(FSNAMPRE)];
static FILE filep;

FILE *
setmntent(table, type)
char *table;
char *type;
{
  int which;

  if (!strcmp(table, MOUNTED)) which = 0; /* Mounted only */
  else if (!strcmp(table, MNTTAB)) which = 1; /* All */
  else {
    errno = EINVAL;
    return NULL;
  }

  filep.siocnt = 0;		/* Init device index */
  filep.sioocnt = which;
  filep.sioflgs = 1;
  filep.siocheck = _SIOF_MNTENT;	/* Make block valid */
  return &filep;
}

#define DSKDEV ((('D'-040)<<30)|(('S'-040)<<24)|(('K'-040)<<18))
struct mntent *
getmntent(f)
FILE *f;
{
  char devname[MAXSTRNAM+1], *p;
  int acs[5], devsix, devn, devchr;

  if ((f != &filep) || (f->siocheck != _SIOF_MNTENT)) {
				/* validate block */
    errno = EINVAL;
    return NULL;
  }

  if (f->sioflgs < 0) {
    errno = ENOENT;
    return NULL;
  }

  while (1) {
    devn = f->siocnt++;
    acs[1] = (devn << 18) + monsym(".DEVNA");
    if (!jsys(GETAB, acs)) {
      f->sioflgs = -1;
      if (acs[0] == monsym("GTABX2")) errno = ENOENT;
      else errno = EIO;
      return NULL;
    }
    if (acs[1] == DSKDEV) continue;
    devsix = acs[1];
    acs[1] = (devn << 18) + monsym(".DEVCH");
    if (!jsys(GETAB, acs)) continue;
    devchr = acs[1];
    if (FLDGET(devchr, monsym("DV%TYP")) != _DVDSK) continue;
    for (p=devname; devsix; devsix <<=6) {
      *p = ((devsix >> 30) & 077) + 040;
      if (isupper(*p)) *p = tolower(*p);
      p++;
    }
    *p++ = '\0';
    acs[1] = (int)(devname - 1);
    if (!jsys(STDEV, acs)) continue;
    acs[1] = acs[2];
    if (!jsys(DVCHR, acs)) continue;
    devchr = acs[2];
    if (f->sioocnt || (devchr & monsym("DV%AV"))) break;
  }

  mnt.mnt_fsname = fsname;
  strcpy(mnt.mnt_fsname, FSNAMPRE);
  mnt.mnt_dir = mnt.mnt_fsname + (sizeof(FSNAMPRE) - 2);
  strcpy(mnt.mnt_dir+1, devname);
  mnt.mnt_type = MNTTYPE_UFS;
  mnt.mnt_opts = (devchr & monsym("DV%MNT")) ? MNTOPT_RW : MNTOPT_NOAUTO;
  mnt.mnt_freq =  0;
  mnt.mnt_passno = 0;
  return &mnt;
}

int
endmntent(f)
FILE *f;
{
  if ((f != &filep) || (f->siocheck != _SIOF_MNTENT)) {
				/* validate block */
    errno = EINVAL;
    return 0;
  }

  if (f->sioflgs == 0) {
    errno = ENOENT;
    return 0;
  }

  f->sioflgs = 0;
  return -1;
}
#endif /* SYS_T20+SYS_10X */
