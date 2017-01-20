/*
**	SIGDAT - Signal Data module.
**
**	(c) Copyright Ken Harrenstien 1989
**
**	The reason this module exists is to define certain globals which
** must always exist whether or not the program actually invokes signal()
** or sigvec(); all USYS routines refer to these globals and hence they
** must always be present.  By separating them from the sigvec() code we
** can avoid loading the bulk of the signal stuff if it is never used.
*/

#include <c-env.h>
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS	/* Systems supported for */

#include <signal.h>
#include <sys/usydat.h>		/* System data */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

#if SYS_T20+SYS_10X
static void `sigabt` P_((unsigned int smask));
static int _iic P_((unsigned int cmask));
#endif 

#undef P_

char *sys_siglist[] = {
    "Signal 0",
    "Hangup",						/* SIGHUP */
    "Interrupt",					/* SIGINT */
    "Quit",						/* SIGQUIT */
    "Illegal Instruction",				/* SIGILL */
    "Trace Trap",					/* SIGTRAP */
    "IOT instruction",					/* SIGIOT */
    "EMT instruction",					/* SIGEMT */
    "Floating Point Exception",				/* SIGFPE */
    "Kill",						/* SIGKILL */
    "Bus Error",					/* SIGBUS */
    "Segmentation Violation",				/* SIGSEGV */
    "Bad argument to system call",			/* SIGSYS */
    "Write on a pipe with no one to read it",		/* SIGPIPE */
    "Alarm Clock",					/* SIGALRM */
    "Software termination signal",			/* SIGTERM */
    "Urgent condition present on socket",		/* SUGURT */
    "Stop process",					/* SIGSTOP */
    "Stop",						/* SIGTSTP */
    "Continue after stop",				/* SIGCONT */
    "Child status changed",				/* SIGCHLD */
    "Background read attempted from control TTY",	/* SIGTTIN */
    "Background write attempted from control TTY",	/* SIGTTOU */
    "I/O is possible on a FD",				/* SIGIO */
    "CPU time limit exceeded",				/* SIGXCPU */
    "File size limit exceeded",				/* SIGXFSZ */
    "Virtual time alarm",				/* SIGVTALRM */
    "Profiling time alarm",				/* SIGPROF */
    "Window size change",				/* SIGWINCH */
    "Signal 29",					/* SIG29 */
    "User-defined signal 1",				/* SIGUSR1 */
    "User-defined signal 2"				/* SIGUSR2 */
};

#if SYS_T20+SYS_10X
/* Additional globals for T20/10X */

/* _SIGTRIGPEND - Internal rtn called to process any pending signals.
**	Should ONLY be called when sigusys is zero.  Thus, interrupts
** can be serviced during this call, and no further additions to sigpendmask
** or chnpendmask will happen.  We determine whether any signals can now
** be taken, and if so derive a mask of the PSI channel bits for those signals,
** and for those which are actually pending we trigger them all at once.
**	This routine returns one of three values:
**	0  - nothing happened.
**	-1 - interrupt was triggered.
**	+1 - interrupt was triggered, but handler permits restarting syscall.
** The latter return value can only happen if the PSI handling code in SIGVEC
** bumps the PC accordingly.  This is the reason for the _sigtx label, so
** the "pclsr" routine can check for this case.
*/

static int _iic();
static void `sigabt`();
unsigned int _cnvmask();
void __dir(), __eir();

int
_sigtrigpend()
{	
  extern void _iobclean();
  int smask, cmask;

  if (USYS_VAR_REF(frktrm))
    _iobclean();		/* Perform any pending fork cleanup */
  __dir();			/* Prevent race with PSI system */
  smask = USYS_VAR_REF(sigpendmask) & ~USYS_VAR_REF(sigblockmask);
  if (!smask) {			/* Any nonblocked signals pending? */
    __eir();			/* No, re-enable PSI system */
    return 0;
  }
  cmask = _cnvmask(smask) & USYS_VAR_REF(chnpendmask);
				/* Get corr. channels not blocked */
  if (!cmask) `sigabt`(smask);	/* Die horribly if none */
  return _iic(cmask);		/* Generate interrupt, re-enable PSI */
}

static void `sigabt`(smask)
unsigned int smask;
{
  if (0) (smask++);
#asm
	SEARCH MONSYM

	movei 1,.cttrm
	hrroi 2,[asciz "
?Fatal error in _sigtrigpend(), no pending channels for signals: "]
	setz 3,
	sout%
	move 2,-1(17)		/* Get mask to print */
	move 3,[no%mag!no%lfl!no%zro!<14,,8>]	/* 12 octal digits */
	nout%			/* Yes */
	 jfcl
	hrroi 2,[asciz /
/]
	setz 3,
	sout%
	haltf%
	jrst sigabt		/* Loop on continue */
#endasm
}

static int _iic(cmask)
unsigned int cmask;
{
#asm
	intern .sigtx		/* So sigvec can find this symbol */

	movei 1,.fhslf		/* Trigger ourselves */
	move 2,-1(17)		/* Get channel mask */
	eir%			/* Re-enable PSI system to take trap */
				/* There is a small chance for a race here */
	iic%			/* Trigger the interrupts! */
.sigtx:
	skipa 1,[-1]		/* Normal return says interrupt happened */
	 movei 1,1		/* Special return if sigvec diddles PC */
	popj 17,		/* All done... */
#endasm
}

void __dir()	/* Disable ints */
{
    asm("	movei 1,.fhslf\n	dir%\n");
}

void __eir()	/* Enable ints */
{
    asm("	movei 1,.fhslf\n	eir%\n");
}

/* _CNVMASK - Converts signal mask to channel mask. */
unsigned int _cnvmask(mask)
unsigned int mask;
{
  int i;
  register unsigned int omask = 0, imask = mask;

  for (i=1;i<_NSIGS;i++,imask>>=1)
    if (imask & 1)
      omask |= USYS_VAR_REF(sigcmask[i]);

  return omask;
}
#endif /* T20+10X */

/* Dummy _SIGTRIGPEND for systems that don't have interrupts */

#if SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS
extern void _panic();

int _sigtrigpend()
{
    /* We don't do interrupts yet, so this should never happen */
    _panic("_sigtrigpend: can't happen");
}
#endif /* T10+CSI+WAITS+ITS */

#endif /* T20+10X+T10+CSI+WAITS+ITS */
