/* <SIGNAL.H> - Signal value definitions.
**
**	(c) Copyright Ken Harrenstien 1989
**
**	These definitions are extremely unportable; however,
**	all of the 4.3BSD signal structures are defined and implemented
**	(at least on TOPS-20).
*/

#ifndef _SIGNAL_INCLUDED	/* Include only once */
#define _SIGNAL_INCLUDED

#include <c-env.h>
#include <sys/types.h>		/* For caddr_t */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

#ifndef _POSIX_SOURCE
typedef void (*sig_t) P_((int));
#endif

typedef void (*__sighandler_t) P_((int));
typedef unsigned int sigset_t;

#define	SIG_DFL	((__sighandler_t)0) /* Arg to "signal" to resume default action */
#define	SIG_IGN	((__sighandler_t)1) /* Arg to "signal" to ignore this sig */
#define	SIG_ERR	((__sighandler_t)(-1)) /* Return val from "signal" if error */

#define sigemptyset(set)        ( *(set) = 0 )
#define sigfillset(set)         ( *(set) = ~(sigset_t)0, 0 )
#define sigaddset(set, signo)   ( *(set) |= 1 << ((signo) - 1), 0)
#define sigdelset(set, signo)   ( *(set) &= ~(1 << ((signo) - 1)), 0)
#define sigismember(set, signo) ( (*(set) & (1 << ((signo) - 1))) != 0)

/*
 * Signal vector "template" used in sigaction call.
 */
struct  sigaction {
  __sighandler_t sa_handler;	/* signal handler */
  sigset_t	 sa_mask;	/* signal mask to apply */
  int		 sa_flags;	/* see signal options below */
  union {			/* Extra word for OS-dependent stuff */
    struct {			/* T20/10X stuff:	*/
      unsigned psichn : 6;	/* PSI channel # (1-35) */
      unsigned psilev : 2;	/* PSI level # (1-3)	*/
      signed   tic : 7;		/* .TICxx code plus 1 (1-36) */
    } t20;
  } sv_os;			/* OS-dependent stuff */
};
#ifndef _POSIX_SOURCE
#define SA_ONSTACK      0x0001  /* take signal on signal stack */
#define SA_RESTART      0x0002  /* do not restart system on signal return */
#endif
#define SA_NOCLDSTOP    0x0004  /* do not generate SIGCHLD on child stop */

/*
 * Flags for sigprocmask:
 */
#define SIG_BLOCK       1       /* block specified signal set */
#define SIG_UNBLOCK     2       /* unblock specified signal set */
#define SIG_SETMASK     3       /* set specified signal set */

/* cusys:signal.c */
extern __sighandler_t signal P_((int sig,__sighandler_t func));

/* cusys:sigvec.c */
extern int raise P_((int sig));
#ifndef _ANSI_SOURCE
extern int kill P_((pid_t pid,int sig));
/* The next 4 are not yet implemented */
extern int sigaction P_((int, const struct sigaction *, struct sigaction *));
extern int sigpending P_((sigset_t *));
extern int sigprocmask P_((int, const sigset_t *, sigset_t *));
extern int sigsuspend P_((const sigset_t *));
#endif  /* !_ANSI_SOURCE */
#if !defined(_ANSI_SOURCE) && !defined(_POSIX_SOURCE)
extern int sigvec P_((int sig,struct sigvec *vec,struct sigvec *ovec));
extern int sigblock P_((int mask));
extern int sigsetmask P_((int mask));
extern int sigpause P_((int mask));
extern int sigstack P_((struct sigstack *ss,struct sigstack *oss));
extern int sigreturn P_((struct sigcontext *scp));
extern int killpg P_((pid_t pgrp,int sig));
#endif /* !_ANSI_SOURCE && !_POSIX_SOURCE */

#define SIGABRT SIGIOT	/* New signal for ANSI; re-use SIGIOT as per H&S */

/* Signals here are marked with a 3-character code indicating the actions
** taken when the signal happens, for each of 3 possible settings for
** the signal handling routine:
**	    
**	  /----- D: SIG_DFL (default action)
**	 | /---- I: SIG_IGN (ignore signal)
**	 || /--- H: User-defined handler routine
**	<DIH>
**	 |||
**	 \\\--> Each letter is one of:
**			-: Ignore signal.
**			T: Terminate process.
**			D: Terminate process, dump core image.
**			S: Stop process (suspend - can continue later).
**			H: Call user handler.
*/

/*	Signal	#	  <DIH>  Description */
#define	SIGHUP	1	/* T-H Hangup (eg dialup carrier lost) */
#define	SIGINT	2	/* T-H Interrupt (user TTY interrupt, default DEL) */
#define	SIGQUIT	3	/* D-H Quit      (user TTY interrupt, default ^\) */
#define	SIGILL	4	/* D-H Illegal Instruction (not reset when caught) */
#define	SIGTRAP	5	/* D-H Trace Trap (not reset when caught) */
#define	SIGIOT	6	/* D-H IOT instruction */
#define	SIGEMT	7	/* D-H EMT instruction */
#define	SIGFPE	8	/* D-H Floating Point Exception */
#define	SIGKILL	9	/* TTT Kill (cannot be caught, blocked, or ignored) */
#define	SIGBUS	10	/* D-H Bus Error */
#define	SIGSEGV	11	/* D-H Segmentation Violation */
#define	SIGSYS	12	/* D-H Bad argument to system call */
#define	SIGPIPE	13	/* T-H Write on a pipe with no one to read it */
#define	SIGALRM	14	/* T-H Alarm Clock */
#define	SIGTERM	15	/* T-H Software termination signal (from "kill" pgm) */

/* BSD additions */
#define SIGURG 16	/* --H Urgent condition present on socket */
#define SIGSTOP 17	/* SSS Stop process(cannot be caught/blocked/ignored)*/
#define SIGTSTP 18	/* S-H Stop      (user TTY interrupt, default ^Z) */
#define SIGCONT 19	/* --H Continue after stop (cannot be blocked) */
#define SIGCHLD 20	/* --H Child status changed */
#define SIGTTIN 21	/* S-H Background read attempted from control TTY */
#define SIGTTOU 22	/* S-H Background write attempted from control TTY */
#define SIGIO 23	/* --H I/O is possible on a FD (see fcntl) */
#define SIGXCPU 24	/* T-H CPU time limit exceeded (see setrlimit) */
#define SIGXFSZ 25	/* T-H File size limit exceeded (see setrlimit) */
#define SIGVTALRM 26	/* T-H Virtual time alarm (see setitimer)*/
#define SIGPROF 27	/* T-H Profiling time alarm (see setitimer) */
#define SIGWINCH 28	/* --H Window size change */
#define SIG29	29	/*     (not used -- placeholder definition) */
#define SIGUSR1	30	/* T-H User-defined signal 1 */
#define SIGUSR2	31	/* T-H User-defined signal 2 */
#define NSIG 32		/* For UNIX compatibility */

/* TOPS-20/TENEX additions */
#define SIGT20EOF 32	/* --H .ICEOF PSI interrupt */
#define SIGT20NXP 33	/* --H .ICNXP PSI interrupt */
#define SIGT20DAE 34	/* --H .ICDAE PSI interrupt */

#define _NSIGS 36	/* KCC implementation allows up to 36 signals! */

/* Definitions for 4.3BSD signal mechanism */

/* SIGMASK(sig) - Macro to furnish mask bit for specified signal */
#define sigmask(sig) (1<<((sig)-1))	/* BSD signal bit from sig # */

#ifndef _POSIX_SOURCE
struct sigvec {
	void (*sv_handler)P_((int));
	int sv_mask;
	int sv_flags;
	union {			/* Extra word for OS-dependent stuff */
	    struct {			/* T20/10X stuff:	*/
		unsigned psichn : 6;	/* PSI channel # (1-35) */
		unsigned psilev : 2;	/* PSI level # (1-3)	*/
		signed   tic : 7;	/* .TICxx code plus 1 (1-36) */
	    } t20;
	} sv_os;		/* OS-dependent stuff */
#define sv_onstack sv_flags	/* For 4.2BSD compatibility */
};

/* Flags for sv_flags.  The first must be 1 for compatibility with 4.2BSD. */
#define SV_ONSTACK SA_ONSTACK	/* Use signal stack for handling this signal */
#define SV_INTERRUPT SA_RESTART	/* (New in 4.3) OK to interrupt syscall */
				/* (Opposite to SA_ usage) */
#define SV_HNDLR_RESET 04000	/* KCC: Reset signal to SIG_DFL when caught */
#define SV_XOS	   010000	/* KCC: "os" extension valid */
#define SV_XINTLEV 020000	/* KCC: handler should run at OS int level */
#define SV_XASMHAN 040000	/* KCC: handler is assumed to be a special
				**   assembler routine and is invoked directly
				**   in an OS-dependent way. */

struct sigstack {
	int *ss_sp;		/* Stack pointer (note not caddr_t!) */
	int ss_onstack;		/* Whether on this stack now */
};

#define BADSIG          SIG_ERR
#endif /* !_POSIX_SOURCE */

/* The following are used by _POSIX_SOURCE stuff, otherwise they would */
/* not be defined for _POSIX_SOURCE. */

/* System-dependent saved context for restoring state prior to signal.
** If this is changed, the asm code in SIGVEC needs to be changed too!
*/
struct sigcontext {
	int sc_pc;		/* Interrupt PC (must be 1st thing!) */
	int sc_pcflgs;		/* Interrupt PC flags */
	int sc_osinf;		/* OS signal info */
				/* T20/10X: <previous PSI level>,,<chan #> */
	int sc_sig;		/* Signal # that caused interrupt */
	struct sigcontext *sc_prev;	/* Previous sig frame */
	int sc_stkflg;		/* Previous signal stack state */
	int sc_mask;		/* Previous signal block mask */
	int sc_acs[16];		/* Saved PDP-10 registers */
};

/*
 *	Stuff for SYS V softsigs as per H&S V2, sec 21.6
 */


/* cgen:ssigna.c */
extern int (*ssignal P_((int softsig, int (*func)P_((int softsig))))) P_((int softsig));
extern int gsignal P_((int softsig));

#define _SS_FIRST	1	/* softsigs in the range 1 - */
#define _SS_LAST	15	/* through 15 */
#define _SS_NSIGS	(_SS_LAST - _SS_FIRST + 1)

#undef P_

#endif /* ifndef _SIGNAL_INCLUDED */
