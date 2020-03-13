/* UIODAT - USYS I/O data definitions
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.18, 11-Aug-1988
**	(c) Copyright Ken Harrenstien & Ian Macky, SRI International 1987
**	Edits for ITS:  Copyright (C) 1988 Alan Bawden
**
** This module contains declarations for various data structures needed by
** the USYS routines, particularly the I/O functions, which must be global.
** They are still "internal" from the viewpoint of the user and must not
** be referenced by anything but USYS calls.
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS /* Systems supported for */

#include <jsys.h>
#include <stddef.h>		/* for NULL */
#include <string.h>		/* for memcpy() */
#include <sys/usydat.h>		/* Includes <sgtty.h> and <sys/ioctl.h> */
#include <sys/urtint.h>
#include <sys/c-debug.h>

/*
 * UF (Unix File) storage.
 *		We maintain a single active UF for each operating-system
 *	channel/JFN.  A UF is separate from a FD so that we can have
 *	several FDs referencing the same UF, as happens inside the UNIX
 *	kernel.
 *
 *	FDs can be numbered from 0 to OPEN_MAX-1 inclusive, as on UNIX.
 *	A NULL UF pointer means that FD is unassigned.
 *
 *	The uffd table determines whether a FD is open or not.
 *	The uf_nopen component determines whether a UF is open or not.
 *	If not open ( >0), all other components of that UF are invalid.
 */
int _fksyn = 0;			/* Address of [v]fork() sync addr */

/* Debug routines */
#ifdef _KCC_DEBUG

static void dmpfd(char *title, int fkhndl, char *tail)
{
  struct _ufile *uf;
  int fd, ufn;

  _dbgl("UIODAT&");
  _dbgs(title);
  _dbgo(fkhndl & 0377777);
  _dbgs(tail);
  _dbgs("\r\n");
  for (fd = 0; fd < OPEN_MAX; fd++)	/* For all FDs */
    if (uf = _UFGET(fd)) {		/* If its open, */
      _dbgl("    fd ");
      _dbgd(fd);
      _dbgs("/ uf ");
      _dbgd(uf-USYS_VAR_REF(uftab));
      _dbgs("\r\n");
    }

  for (ufn = 0; ufn < OPEN_UF_MAX; ufn++) /* For each UF */
    if (USYS_VAR_REF(uftab[ufn]).uf_nopen) {
      uf = &USYS_VAR_REF(uftab[ufn]);
      _dbgl("    uf ");
      _dbgd(ufn);
      _dbgs("/ nopen=");
      _dbgd(uf->uf_nopen);
      _dbgs(", jfn=");
      _dbgj(uf->uf_ch);
      _dbgs("\r\n");
    }
}

static void dbgfd()
{
  struct _frkuf *frkufp;
  int ufn;

  if (0) dbgfd();		/* Keep compiler happy */
  dmpfd("dbgfd(", 0, ")");
  _dbgl("  Pending children:\r\n");
  for (frkufp = &USYS_VAR_REF(frkuf)[0];
       frkufp < &USYS_VAR_REF(frkuf[USYS_MAXFRK]); frkufp++)
    if (frkufp->fkhndl != 0) {
      _dbgl("    frk ");
      _dbgo(frkufp->fkhndl & 0377777);
      _dbgs("/ uf");
      for (ufn = 0; ufn < OPEN_UF_MAX; ufn++) /* For each UF */
	/* If was used by child, */
	if (frkufp->ufmask[ufn/36] & (1 << (ufn % 36))) {
	  _dbgs(" ");
	  _dbgd(ufn);
	}
      if (frkufp->fkhndl & LH) _dbgs(", waiting for exec()");
      _dbgs("\r\n");
    }
}
#endif

/* On T20/10X there can be only one controlling terminal
** (i.e. source of terminal interrupts).  This is always _ttys[0].
** We only attempt full emulation for this terminal rather than for all
** TTY: devices, but up to _NTTYS-1 other random TTY devices are possible.
*/

/* _UFTTY - Auxiliary to derive internal tty structure, given a UF.
**	We assume the UF has already been checked for validity.
*/
struct _tty *
_uftty(uf)
struct _ufile *uf;
{
    if (uf->uf_type == UIO_DVTTY) {	/* If device type is TTY, */
	int i = uf->uf_dnum;		/* get minor device # (tty #) */
	if (i < 0 || _NTTYS <= i)
	    return NULL;		/* Bad, no TTY struct */
	if (USYS_VAR_REF(ttys[i].tt_uf) != uf) /* Check for consistency */
	    return NULL;
	return &USYS_VAR_REF(ttys[i]);	/* Won, return pointer to it! */
    }
    return NULL;
}

/*	I/O buffer data and routines.
**		The I/O buffers are done as static data areas for
**	now because the syscalls cannot invoke malloc() as needed.
*/

void
_lckuf(lockp)
int *lockp;
{
#asm
	SEARCH MONSYM		/* Uppercase to avoid monsym() clash */
	extern $HERIT		/* Heritage string pointer */

	move	4,-1(17)	/* Get address of lock */
lckuf1:	aosn	1,(4)		/* Attempt to claim it */
	 popj	17,		/* Got it, return */
	caile	1,^D1000	/* Exceeded maximum lock time (10-20 sec)? */
	 jrst	lckuf2		/* Yes, grab it anyway */
	movei	1,1		/* Shortest wait */
	disms%			/* Dismiss (approx 20 ms)*/
	jrst	lckuf1		/* Loop until claimed */

lckuf2:	movei	1,.CTTRM	/* Output to terminal */
	move	2,$HERIT	/* Fork ID */
	setz	3,
	sout%
	hrroi	2,[asciz /
: Interlock at /]
	sout%
	move	2,4
	movei	3,10
	nout%
	 jfcl
	hrroi	2,[asciz / timed out, claiming anyway.
/]
	setz	3,
	sout%
	setzm	(4)		/* Clean up interlock count */
	popj	17,		/* And return */
#endasm
}

struct _iob *
_iobget()
{
    register int i;
    struct _iob *iob = NULL;

    USYS_LOCK(USYS_VAR_REF(uflock)); /* Claim interlock */
    for (i = UIO_NBUFS; --i >= 0;)
	if (USYS_VAR_REF(iobuse[i]) == NULL) {
	  iob = USYS_VAR_REF(iobuse[i]) = &USYS_VAR_REF(iobs[i]);
	  break;
	  }
    USYS_UNLOCK(USYS_VAR_REF(uflock)); /* Release interlock */
    return iob;
}

void
_iobfre(b)
struct _iob *b;
{
    register int i = b - USYS_VAR_REF(iobs);

    if (USYS_VAR_REF(iobuse[i]) != b)
	_panic("_iobfre() - bad arg");
    USYS_VAR_REF(iobuse[i]) = NULL; /* No interlock needed */
}

/* Initialize I/O data for new fork() or vfork() process */
void
_iobinit()
{
  memset(&USYS_VAR_REF(frkuf)[0], 0, sizeof(struct _frkuf) * USYS_MAXFRK);
}

/* Called for fork() and vfork()
 * Increment share counts for IO channels in use.
 * Allocates a 'frkup' entry for cleanup for this fork.
 */

void
_iobfork(int fkhndl, int *frkfds)
{
  int fd, ufn;
  struct _ufile *uf;
  struct _frkuf *frkufp;

  /* Claim an entry for tracking sub-fork */
  for (frkufp = &USYS_VAR_REF(frkuf)[0];
       frkufp < &USYS_VAR_REF(frkuf[USYS_MAXFRK]); frkufp++)
    if (frkufp->fkhndl == 0) {
      frkufp->fkhndl = fkhndl | LH; /* Flag waiting for exec() */
      memset(frkufp->ufmask, 0, sizeof(frkufp->ufmask));
				/* Init UF use bits */
      break;
    }

  /* If doing both fork() and exec(), go straight to marking stdin/out/err */
  if (frkfds) {
    if (frkufp >= &USYS_VAR_REF(frkuf[USYS_MAXFRK])) return;
				/* If no structure, just pray */

    /* Increment each used UF only once even if more than 1 ref */
    for (fd = UIO_FD_STDIN; fd <= UIO_FD_STDERR; fd++)
      if (uf = _UFGET(frkfds[fd])) {	/* If in use */
	ufn = uf - USYS_VAR_REF(uftab);
	if (!(frkufp->ufmask[ufn/36] & (1 << (ufn % 36)))) {
	  frkufp->ufmask[ufn/36] |= (1 << (ufn % 36)); /* Mark for cleanup */
	  uf->uf_nopen++;	/* Increment share count */
	}
      }


    frkufp->fkhndl &= RH;	/* Clear waiting for exec() flag */
#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_UIO_FDSHR)
      dmpfd("_iobfork(fork ", frkufp->fkhndl, ", forkexec)");
#endif
    return;			/* And we're done */
  }

  /* Increment share counts for open UFs */
  for (fd = 0; fd < OPEN_MAX; fd++)	/* For all FDs */
    if (uf = _UFGET(fd)) {		/* If its open, */
      ufn = uf - USYS_VAR_REF(uftab);
      ++uf->uf_nopen;		/* Inc share count for each reference */
    }
#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_UIO_FDSHR)
    dmpfd("_iobfork(fork ", frkufp->fkhndl, ", !forkexec)");
#endif
}

/* Reclaim uftab for dead forks */
void
_iobclean()
{
  register struct _frkuf *frkufp;
  int acs[5], ufn;
  
  USYS_BEG();			/* Avoid races */
  USYS_VAR_REF(frktrm) = 0;	/* Fork termination processing done */
  for (frkufp = &USYS_VAR_REF(frkuf)[0];
       frkufp < &USYS_VAR_REF(frkuf)[USYS_MAXFRK]; frkufp++) {
    if (frkufp->fkhndl == 0) continue;
    acs[1] = frkufp->fkhndl & RH;
    acs[3] = 0;			/* Not cleared by RFSTS, only set to -1 */
    if (!jsys(RFSTS, acs)) acs[3] = -1;	/* Get fork status */
    if ((acs[3] == -1)					/* No fork */
	|| (((acs[1] >> 18) & 0377777) == _RFHLT)	/* Or halted */
	|| (((acs[1] >> 18) & 0377777) == _RFFPT)) {	/* Or forced term */
      if (frkufp->fkhndl < 0) {
	/* Fork should be doing exec() or exiting without exec() */
	int facs[020], ufnin, ufnout, ufnerr, pagmap;
	int shrpag = (((int)&USYS_VAR_REF(endsys[511])) >> 9);

	if ((acs[2] & RH) != _fksyn) goto frktrm;

	/* Get our mapping for the first shared page */
	acs[1] = (_FHSLF << 18) | shrpag;
	if (!jsys(RMAP, acs)) goto frktrm;
	pagmap = acs[1];

	/* Get child mapping for the first shared page */
	acs[1] = (frkufp->fkhndl << 18) | shrpag;
	if (!jsys(RMAP, acs)) goto frktrm;
	if ((acs[1] != pagmap) && (acs[1] != ((_FHSLF << 18) | shrpag)))
	  goto frktrm;		/* If maps differ, not copy of us */
	
	/* Read child ACs to get UF info */
	acs[1] = frkufp->fkhndl;
	acs[2] = (int)facs;
	if (!jsys(RFACS, acs)) goto frktrm; /* Quit if can't read ACs */

	/* Extract and verify UF indexes, should be in AC17 */
	ufnin = (facs[017] >> 24) & 07777; /* bits 0-11 are for stdin */
	if ((ufnin != 07777) &&
	    ((ufnin < 0) || (ufnin >= OPEN_UF_MAX))) goto frktrm;
	ufnout = (facs[017] >> 12) & 07777; /* bits 12-23 are for stdin */
	if ((ufnout != 07777) &&
	    ((ufnout < 0) || (ufnout >= OPEN_UF_MAX))) goto frktrm;
	ufnerr = facs[017] & 07777; /* bits 24-35 are for stdin */
	if ((ufnout != 07777) &&
	    ((ufnerr < 0) || (ufnerr >= OPEN_UF_MAX))) goto frktrm;

	/* Everything checks out, set UF flags for later cleanup */

	/* Mark UF for stdin */
	if (ufnin != 07777)
	  frkufp->ufmask[ufnin/36] |= (1 << (ufnin % 36));

	/* Ensure only 1 share count if used more than once */
	if (ufnout != 07777) {
	  if (frkufp->ufmask[ufnout/36] & (1 << (ufnout % 36)))
	    USYS_VAR_REF(uftab[ufnout]).uf_nopen--;
	  /* If stdout not used more than once, mark it */
	  else frkufp->ufmask[ufnout/36] |= (1 << (ufnout % 36));
	}

	/* Same for stderr */
	if (ufnerr != 07777) {
	  if (frkufp->ufmask[ufnerr/36] & (1 << (ufnerr % 36)))
	    USYS_VAR_REF(uftab[ufnerr]).uf_nopen--;
	  /* If stderr not used more than once, mark it */
	  else frkufp->ufmask[ufnerr/36] |= (1 << (ufnerr % 36));
	}

	frkufp->fkhndl &= RH;	/* Clear exec() flag */

	/* Continue the fork now */
	acs[1] = frkufp->fkhndl | monsym("SF%CON");
				/* Get fork handle and continue bit */
	jsys(SFORK, acs);	/* Do the continue */

#ifdef _KCC_DEBUG
	if (`$DEBUG` & _KCC_DEBUG_UIO_FDSHR)
	  dmpfd("_iobclean(fork ", frkufp->fkhndl, ") continued from exec()");
#endif      

	continue;		/* Process next entry */
      }

      /* Terminating fork, clean up UFs */
      for (ufn = 0; ufn < OPEN_UF_MAX; ufn++) /* For each UF */
	/* If was used by child, */
	if (frkufp->ufmask[ufn/36] & (1 << (ufn % 36))) {
	  /* Release child interest in UF */
	  _ufclose(0, &USYS_VAR_REF(uftab[ufn]));
      }

    frktrm:			/* Come here to forget this fork */
#ifdef _KCC_DEBUG
      if (`$DEBUG` & _KCC_DEBUG_UIO_FDSHR)
	dmpfd("_iobclean(fork ", frkufp->fkhndl, ") terminated");
#endif      
      frkufp->fkhndl = 0;	/* Clear fork handle in table */
    }
  }
  USYS_END();			/* Races over */
}

int _iobgufi()
{
  struct _ufile *uf;
  int ufnin = 07777, ufnout = 07777, ufnerr = 07777;

  if (uf = _UFGET(UIO_FD_STDIN))
    ufnin = uf - USYS_VAR_REF(uftab);
  if (uf = _UFGET(UIO_FD_STDOUT))
    ufnout = uf - USYS_VAR_REF(uftab);
  if (uf = _UFGET(UIO_FD_STDERR))
    ufnerr = uf - USYS_VAR_REF(uftab);

  return (ufnin << 24) | (ufnout << 12) | ufnerr;
}

/* Miscellaneous */

#if SYS_T10+SYS_CSI+SYS_WTS
int _filopuse = 0;	/* Set non-zero to use FILOP. UUO */
#if SYS_CSI
int _trmopuse = SYS_CSI;	/* Non-zero to use TRMOP. TTY I/O */
#endif
#endif

#endif /* T20+10X+T10+CSI+WAITS+ITS */
 