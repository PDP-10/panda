/* System data management */

#include <sys/usysig.h>
#include <sys/usysio.h>
#include <sys/usytty.h>
#include <signal.h>

#ifndef _SYS_USYDAT_INCLUDED
#define _SYS_USYDAT_INCLUDED

#define USYS_VAR_REF(var) _urt.var
#define USYS_VAR_TO_ASM(var,lvar) static int *lvar = (int *)&USYS_VAR_REF(var)
#define USYS_VAR_ASM_REF(lvar) @lvar
#define USYS_LOCK(lock) _lckuf(&(lock))
#define USYS_UNLOCK(lock) ((lock) = -1)
extern void _lckuf();
#define _MAXHERIT 50

/* Type of sv_handler (for convenience) */
#ifdef __STDC__
typedef void(*hndlr_t)(int sig);
#else
typedef void (*hndlr_t)();
#endif

/* Note: The _urt structure is used to collect all "system" data (data
   which resides in system space in UNIX, not process space) so that
   it can be managed appropriately. The structure members 'begsys',
   'endsys', and 'endshr' allow the data in between to be located on
   different pages than the surrounding data. This allows those pages
   to be mapped differently to a child process during vfork() and
   fork(), since each UNIX process has its own copy of this data. The
   other use of this structure is to allow "system" data to be
   initialized (zeroed) at program startup, thus making C programs
   restartable. The data in the structure which is located between
   'endsys' and 'endshr' is "shared" system data, in this case the
   shared part of the I/O data base. This allows the parent to
   determine which channels are still in use by the child process when
   it does an exec().  */

struct _urt {

  int begsys[511];		/* Start on new page */

  /* getpid.c */
  int pidslf;
  int pidpar;

  /* open.c */
#if SYS_T10+SYS_CSI+SYS_WTS
  int defppn;
#endif

  /* sigvec.c */
  int sigif;
  int sigusys;
  int intlev;			/* Int level in progress (not implemented) */
  unsigned int sigpendmask;	/* Pending signal mask */
  unsigned int sigblockmask;	/* Blocked signal mask */
  struct sigcontext *sigframe;	/* Current signal stack frame, for debugging */
  struct sigstack sigstk;	/* Alternate stack pointer */
  hndlr_t sighnd[_NSIGS+1];	/* Handler rtn for signal. */
  unsigned sigmsk[_NSIGS+1];	/* Block mask for signal. */
  unsigned sigflg[_NSIGS+1];	/* SF_ flags for signal. */
  int sigact[_NSIGS+1];	/* SA_xxx action to take for signal */
#if SYS_T20+SYS_10X
#define NPSI	36		/* Same as in sigvec.c */
  unsigned chnpendmask;	/* PSI channel pending int mask (SIGDAT) */
  unsigned sigcmask[_NSIGS+1];	/* Channel mask for signal (mapped) */
  int *intpca;			/* Addr of int PC (in SIGDAT) */
#ifdef __STDC__
  int (*atirtn)(int);		/* Dispatch for TTY char int setup */
#else
  int (*atirtn)();		/* Dispatch for TTY char int setup */
#endif
  int levpcs[3*2];		/* Return PCs for interrupt */
				/* (1 word if single section, 2 if extended) */
  int chntab[NPSI];		/* PSI interrupt vector dispatch */
  int chnact[NPSI];		/* CHA_xxx action to take for chan */
  unsigned char chnchr[NPSI];	/* Interrupt code (.TICxx + 1) for channel */
  int psisv[2];		/* Saved ACs 1-2 during interrupts */
  int psi17;			/* Saved AC 17 during interrupts */
  int psichn;			/* Saved channel during interrupts */
  int psihnd;			/* Saved handler address during ints */
  int psistk;			/* Old stack ptr, for debugging */
  int psisg[2];			/* For JSR from chnxct */
  int psier[2];			/* For JSR on error */
  int psyer[2];			/* For JSR on error */
  int psiesv[4];		/* Saved ACs 1-4 during errors */
  int frktrm;			/* Count of unprocessed fork terminations */
#endif

  /* urt.c */
  int nfork;			/* Number of fork/vfork forks */
#if SYS_T20
  int pippid;			/* PID of "|" piped fork */
  int ptynum;			/* Number of PTYs in system */
  int ptytty;			/* TTY unit of first PTY */
  int olddir;			/* Saved current directory */
  int curdir;			/* Current directory (if ACCES failed) */
#endif

  /* umask.c */
  int umask;			/* Current umask() value */

  /* uiodat.c */
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS
  struct _ufile *uffd[OPEN_MAX]; /* Indexed by FD, has pointer to UF! */
  struct _frkuf frkuf[USYS_MAXFRK]; /* Fork I/O cleanup storage */
#endif

  /* close.c */
#if SYS_T20+SYS_10X
  int clfork;			/* Fork used for deferred CLOSF */
#endif

  /* forkex.c */
  char heritage[_MAXHERIT+1];	/* Heritage string */

  int endsys[511];		/* End on new page */

  /* This is the "shared" system data */

  /* time.c */
  int ltzknown;

  /* uiodat.c */
#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS
  struct _ufile uftab[OPEN_UF_MAX];	/* Static table of max UFs */	
  struct _iob *iobuse[UIO_NBUFS];	/* For in-use tracking */
  struct _iob iobs[UIO_NBUFS];		/* Gross! */
  struct _tty ttys[_NTTYS];		/* Controlling TTY plus any others */
  int uflock;				/* UF shared data interlock */
#endif

  int endshr[511];		/* End on new page */

};
extern struct _urt _urt;

#endif /* ifndef _SYS_USYDAT_INCLUDED */
