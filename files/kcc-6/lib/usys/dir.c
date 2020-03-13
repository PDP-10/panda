#include <c-env.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#if SYS_T20+SYS_10X
#include <jsys.h>
#include <ctype.h>
#include <stdarg.h>
#include <sys/stat.h>

#define _GJGEN	monsym(".GJGEN")
#define _GJSRC	monsym(".GJSRC")
#define _NULIO	monsym(".NULIO")
#define _GJNAM	monsym(".GJNAM")
#define _GJEXT	monsym(".GJEXT")
#define _GJJFN	monsym(".GJJFN")
#define GJ_DEV	monsym("GJ%DEV")
#define GJ_UNT	monsym("GJ%UNT")
#define GJ_DIR	monsym("GJ%DIR")
#define CD_DEL	monsym("CD%DEL")
#define CD_NSQ	monsym("CD%NSQ")
#define CD_LEN	monsym("CD%LEN")
#define CD_MOD	monsym("CD%MOD")
#define CD_DIR	monsym("CD%DIR")
#define CD_DPT	monsym("CD%DPT")
#define CD_PRV	monsym("CD%PRV")
#define CD_FPT	monsym("CD%FPT")
#define CD_RET	monsym("CD%RET")
#define CD_DGP	monsym("CD%DGP")
#define CD_CUG	monsym("CD%CUG")
#define CD_NED	monsym("CD%NED")
#define CD_FED	monsym("CD%FED")

#define CRDLEN	(monsym(".CDDFE")+1)
#define _CDLEN	monsym(".CDLEN")
#define _CDMOD	monsym(".CDMOD")
#define _CDDPT	monsym(".CDDPT")
#define _CDCUG	monsym(".CDCUG")
#define _CDDGP	monsym(".CDDGP")
#define _CDUGP	monsym(".CDUGP")

/* Allow up to 50 groups */
#define GRPLEN 51

#include <sys/usydat.h>
#include <sys/dir.h>
#include <sys/file.h>
#include <sys/param.h>
#include <sys/c-parse.h>
#include <sys/urtint.h>
#include <urtsud.h>
#include <stdarg.h>

int _crdir(char *dir, int pflags, va_list ap)
{
  char parent[MAXPATHLEN], *p;
  int acs[5], tmode, flags, mode, exists = _rcdir(dir);
  static int crdb[CRDLEN];	/* Must be in same section as PC */
  static int ugrpl[GRPLEN+1], dgrpl[GRPLEN+1];

  if (0) pflags++;		/* Keep compiler happy */

  flags = va_arg(ap, int);
  mode = va_arg(ap, int);

  acs[2] = CD_LEN | ((int)crdb & RH);
  memset(crdb, 0, CRDLEN * sizeof(int));
  crdb[_CDLEN] = CRDLEN;
  if (!exists && (flags & CD_DEL)) { /* CRDIR doesn't check */
    errno = ENOENT;		/* Nothing to delete */
    return -1;
  }
  if (!(flags & CD_DEL)) {	/* If not deleting */
    if (exists) {
      if (!(flags & CD_DPT)) {	/* If not changing mode */
	errno = EEXIST;		/* Directory must not exist */
	return -1;		/* Terminate parse expansions with */
				/* this special return value */
      }
    }
    else if (flags & CD_DPT) {	/* If changing mode */
      errno = ENOENT;		/* Directory must exist */
      return 0;
    }
    if (!(flags & CD_DPT)) {
      for (p = dir - 1 + strlen(dir);
	   (p != dir) && ((*p != '<') || (p[-1] == '\026')); p--)
	if ((*p == '.') && (p[-1] != '\026')) break;
      if (p != dir) {
	strncpy(parent, dir, p - dir);
	strcpy(parent+(p-dir), ">");
	if (acs[1] = _rcdir(parent)) {
	  crdb[_CDCUG] = (int)ugrpl & RH;	/* Get allowed user groups */
	  ugrpl[0] = GRPLEN;
	  crdb[_CDDGP] = (int)dgrpl & RH;	/* Get directory groups */
	  dgrpl[0] = GRPLEN;
	  acs[3] = 0;		/* No password */
	  if (jsys(GTDIR, acs)) {
	    /* !Excellent place to bump parents CD_SDQ to allow us! */
	    crdb[_CDUGP] = crdb[_CDCUG]; /* Copy user groups from allowed */
	    acs[2] |= CD_PRV | CD_FPT | CD_RET | CD_DGP | CD_CUG;
	    crdb[_CDLEN] |= CD_NED | CD_FED;
	  }
	}
      }
      acs[2] |= CD_MOD | CD_DPT; /* Enable modes, directory protection */
      crdb[_CDMOD] |= CD_DIR;	/* Force FILES-ONLY */
    }
    crdb[_CDLEN] |= CD_NSQ;	/* Don't steal from parent if enabled */
    tmode = mode & ~USYS_VAR_REF(umask); /* Apply umask */
    /* Translate modes */
    if (tmode & 0200) crdb[_CDDPT] |= 0370000; /* owner create/connect */
    if (tmode & 0100) crdb[_CDDPT] |= 0400000; /* owner file access */
    if (tmode & 0020) crdb[_CDDPT] |= 0003700; /* group create/connect */
    if (tmode & 0010) crdb[_CDDPT] |= 0004000; /* group file access */
    if (tmode & 0002) crdb[_CDDPT] |= 0000037; /* world create/connect */
    if (tmode & 0001) crdb[_CDDPT] |= 0000040; /* world file access */
  }
  acs[1] = (int)(dir - 1);
  acs[2] |= flags;
  if (!jsys(CRDIR, acs)) {
    switch (acs[0]) {
    case monsym("ACESX3"):
    case monsym("CRDIX1"):
    case monsym("CRDI12"):
    case monsym("CRDI18"):
    case monsym("CRDI19"):
    case monsym("CRDI20"):
	errno = EACCES; break;
    case monsym("CRDIX2"):
	errno = EEXIST; break;
    case monsym("CRDIX3"):
    case monsym("CRDIX4"):
    case monsym("CRDI10"):
	errno = ENOSPC; break;
    case monsym("CRDIX6"):
    case monsym("CRDIX7"):
	errno = ENOTEMPTY; break;
    case monsym("CRDIX9"):
	errno = EIO; break;
    case monsym("CRDI13"):
    case monsym("CRDI14"):
    case monsym("CRDI15"):
    case monsym("CRDI21"):
    case monsym("CRDI22"):
    case monsym("CRDI24"):
	errno = EDQUOT; break;
    case monsym("CRDI23"):
	errno = ENOENT; break;
    case monsym("CRDIX8"):
    case monsym("CRDI11"):
    case monsym("CRDI16"):
    case monsym("CRDI17"):
    default:
	errno = EINVAL; break;
    }
    return 0;
  }
  return 1;
}

int mkdir(path, mode)
const char *path;
mode_t mode;
{
  int ret;

  ret = _parse(path, _PARSE_IN_DIR, _crdir, 0, mode);

  if ((ret == 0) || (ret == -1))
    return -1;

  return 0;
}

int rmdir(path)
const char *path;
{
  int ret;

  ret = _parse(path, _PARSE_IN_DIR, _crdir, CD_DEL, 0);

  if ((ret == 0) || (ret == -1))
    return -1;

  return 0;
}

#define DOT 0
#define DOTDOT 1
#define FILES 2

/* opendir/readdir/closedir */

static int _gfls(int dirno)
{
  int acs[5];
  char path[MAXPATHLEN];

  if (!_dirst(dirno, path)) {
    errno = EIO;
    return -1;			/* Return error */
  }
  strcat(path, "*.*.*");
  acs[1] = GJ_SHT | GJ_IFG | GJ_OLD;
  acs[2] = (int)(path - 1);
  if (!jsys(GTJFN, acs)) return 0; /* Flag no files available */

  /* Don't allow directories which cross dev, unit, or dir boundaries */
  if (acs[1] & (GJ_DEV|GJ_UNT|GJ_DIR)) {
    _rljfn(acs[1] & RH);
    errno = EINVAL;
    return -1;			/* Return error */
  }

  return acs[1];
}

static void dirset(dir)
DIR *dir;
{
  dir->fd = -1;			/* No fd for directory yet */
  dir->state = (_urtsud.su_path_out_type == _URTSUD_PATH_OUT_UNIX)
    ? DOT : FILES;		/* For UNIX, include "." & ".." */
}

DIR *opendir(path)
const char *path;
 {
  DIR *dir;
  struct xstat buf;
  int jfn;

  if (xstat(path, &buf)) return NULL;

  if (!(buf.st.st_mode & S_IFDIR)) {
    errno = ENOENT;
    return NULL;
  }

  jfn = _gfls(buf.xst_dirno);	/* Create file scan JFN */

  if (jfn < 0) return NULL;	/* Capture error */

  dir = (DIR *)malloc(sizeof(DIR));
  if (dir == NULL) {
    errno = ENOMEM;
    goto err;
  }

  dir->dirno = buf.xst_dirno;	/* Store directory number */
  dir->jfn = jfn;		/* Store JFN for file scan */
  dirset(dir);
  return dir;

 err:
  _rljfn(jfn & RH);
  return NULL;
}

struct dirent *readdir(DIR *dir)
{
  int acs[5], chgext, fbctl, fbgen, unixdir;

  while (1) {
    switch (dir->state) {
    case DOT:
      dir->state = DOTDOT;
      strcpy(dir->ent.d_name, ".");
      dir->ent.d_ino = -1;
      break;

    case DOTDOT:
      dir->state = FILES;
      strcpy(dir->ent.d_name, "..");
      dir->ent.d_ino = -2;
      break;

    case FILES:
      if (!dir->jfn) return NULL;

      fbctl = _gtfdb(dir->jfn & RH, _FBCTL);
      fbgen = _gtfdb(dir->jfn & RH, _FBGEN);
      dir->ent.d_ino = _gtfdb(dir->jfn & RH, _FBADR);
      unixdir = ((fbctl & FB_DIR)
		 && (_urtsud.su_path_out_type == _URTSUD_PATH_OUT_UNIX));
				/* Is it directory and UNIX output? */
      acs[1] = (int) (dir->ent.d_name - 1);
      acs[2] = dir->jfn & RH;
      acs[3] = (001000000001 | (unixdir ? 0 : 000110000000));
				/* Name field and punctuate */
				/* No type + gen for UNIX dir */
      if (!jsys(JFNS, acs)) {
	errno = EINVAL;
	return NULL;
      }

      acs[1] = dir->jfn;
      if (!jsys(GNJFN, acs)) {
	jsys(RLJFN, acs);
	dir->jfn = 0;
	chgext=1;		/* Flag like changing ext */
      }
      else chgext = acs[1] & monsym("GN%EXT");
				/* Determine if ext changed */

      if ((fbctl & FB_DIR) && ((fbgen & monsym("FB%DRN")) == 1))
	continue;		/* Skip ROOT-DIRECTORY */

      /* Normalize file names */
      _fncon(dir->ent.d_name, dir->ent.d_name, 0, chgext && !unixdir);

      break;

    default:			/* If state is fouled */
      errno = EINVAL;
      return NULL;
    }
    break;
  }

  dir->ent.d_reclen = DIRSIZ(&dir->ent);
  dir->ent.d_namlen = strlen(dir->ent.d_name);
  return &dir->ent;
}

int readlink(char *path, char *buf, int bufsiz)
{
  if (0) (path++, buf++, bufsiz++);	/* Fake refs */
  errno = EINVAL;
  return -1;
}

void closedir(DIR *dir)
{
  int acs[5];

  if (dir->jfn) {
    acs[1] = dir->jfn;
    jsys(RLJFN, acs);
  }

  if (dir->fd >= 0) close(dir->fd);

  if (dir) free(dir);
}

void rewinddir(DIR *dir)
{
  if (dir->jfn) {
    _rljfn(dir->jfn & RH);
    dir->jfn = NULL;
  }

  dir->jfn = _gfls(dir->dirno);	/* Setup JFN for file scan */

  if (dir->jfn < 0) dir->jfn = 0; /* On error, just no files */

  dirset(dir);			/* Re-init other variables */
}

long telldir(DIR *dir)
{
  if (0) dir++;
  errno=EINVAL;
  return -1;
}

void seekdir(DIR *dir, long whence)
{
  if (whence == 0) rewinddir(dir);
}

int scandir(DIR *dir, struct dirent ***namelist,
#ifdef __STDC__
	    int (*select)(struct dirent *),
	    int (*compare)(const void *, const void *))
#else
	    int (*select)(), int (*compare)())
#endif
{
  if (0) (dir++, namelist++, select(NULL), compare(NULL, NULL));
  errno=EINVAL;
  return -1;
}

int dirfd(DIR *dir)
{
  char path[MAXPATHLEN];

  if (dir->fd < 0) {
    if (!_dirst(dir->dirno, path)) {
      errno = EIO;
      return -1;
    }
    dir->fd = open(path, O_RDONLY);
  }

  return dir->fd;
}

#else /* SYS_T20+SYS_10X */
#error mkdir/rmdir/opendir/readdir/closedir only available under T20 or 10X
#endif /* SYS_T20+SYS_10X */
    