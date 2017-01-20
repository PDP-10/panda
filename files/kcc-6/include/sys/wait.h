/*	@(#)wait.h 2.18 89/06/25 SMI; from UCB 4.1 83/02/10	*/

/*
 * This file holds definitions relevent to the wait system call.
 * Some of the options here are available only through the ``wait3''
 * entry point; the old entry point with one argument has more fixed
 * semantics, never returning status of unstopped children, hanging until
 * a process terminates if any are outstanding, and never returns
 * detailed information about process resource utilization (<vtimes.h>).
 */

#ifndef	__sys_wait_h
#define	__sys_wait_h

#include <c-env.h>
#include <sys/resource.h>
#include <sys/types.h>

#ifdef	_POSIX_SOURCE
#define _DEFINED__POSIX_SOURCE 1
#else
#define _DEFINED__POSIX_SOURCE 0
#define	__wait		wait
#define	w_termsig	__w_termsig
#define	w_coredump	__w_coredump
#define	w_retcode	__w_retcode
#define	w_stopval	__w_stopval
#define	w_stopsig	__w_stopsig
#define	WSTOPPED	_WSTOPPED
#endif /* !_POSIX_SOURCE */

#ifdef KERNEL
#define _DEFINED_KERNEL 1
#else
#define _DEFINED_KERNEL 0
#endif

#ifdef vax
#define _DEFINED_vax 1
#else
#define _DEFINED_vax 0
#endif

#ifdef i386
#define _DEFINED_i386 1
#else
#define _DEFINED_i386 0
#endif

#ifdef mc68000
#define _DEFINED_mc68000 1
#else
#define _DEFINED_mc68000 0
#endif

#ifdef sparc
#define _DEFINED_sparc 1
#else
#define _DEFINED_sparc 0
#endif

/*
 * Structure of the information in the first word returned by both
 * wait and wait3.  If w_stopval==WSTOPPED, then the second structure
 * describes the information returned, else the first.  See WUNTRACED below.
 */
union __wait	{
	int	w_status;		/* used in syscall */
	/*
	 * Terminated process status.
	 */
#if _DEFINED_vax || _DEFINED_i386 || _DEFINED_mc68000 || _DEFINED_sparc || SYS_T20
	struct {
#if	_DEFINED_vax || _DEFINED_i386
		unsigned short	w_Termsig:7;	/* termination signal */
		unsigned short	w_Coredump:1;	/* core dump indicator */
		unsigned short	w_Retcode:8;	/* exit code if w_termsig==0 */
#endif
#if	_DEFINED_mc68000 || _DEFINED_sparc
		unsigned short	w_Fill1:16;	/* high 16 bits unused */
		unsigned short	w_Retcode:8;	/* exit code if w_termsig==0 */
		unsigned short	w_Coredump:1;	/* core dump indicator */
		unsigned short	w_Termsig:7;	/* termination signal */
#endif
#if	SYS_T20
		unsigned int	w_Fill1:20;	/* high 20 bits unused */
		unsigned int	w_Retcode:8;	/* exit code if w_termsig==0 */
		unsigned int	w_Coredump:1;	/* core dump indicator */
		unsigned int	w_Termsig:7;	/* termination signal */
#endif
	} w_T;
#endif
	/*
	 * Stopped process status.  Returned
	 * only for traced children unless requested
	 * with the WUNTRACED option bit.
	 */
#if _DEFINED_vax || _DEFINED_i386 || _DEFINED_mc68000 || _DEFINED_sparc || SYS_T20
	struct {
#if	_DEFINED_vax || _DEFINED_i386
		unsigned short	w_Stopval:8;	/* == W_STOPPED if stopped */
		unsigned short	w_Stopsig:8;	/* signal that stopped us */
#endif
#if	_DEFINED_mc68000 || _DEFINED_sparc
		unsigned short	w_Fill2:16;	/* high 16 bits unused */
		unsigned short	w_Stopsig:8;	/* signal that stopped us */
		unsigned short	w_Stopval:8;	/* == W_STOPPED if stopped */
#endif
#if	SYS_T20
		unsigned int	w_Fill2:20;	/* high 20 bits unused */
		unsigned int	w_Stopsig:8;	/* signal that stopped us */
		unsigned int	w_Stopval:8;	/* == W_STOPPED if stopped */
#endif
	} w_S;
#endif
};
#define	__w_termsig	w_T.w_Termsig
#define	__w_coredump	w_T.w_Coredump
#define	__w_retcode	w_T.w_Retcode
#define	__w_stopval	w_S.w_Stopval
#define	__w_stopsig	w_S.w_Stopsig
#define	_WSTOPPED	0177	/* value of s.stopval if process is stopped */

/*
 * Option bits for the second argument of wait3.  WNOHANG causes the
 * wait to not hang if there are no stopped or terminated processes, rather
 * returning an error indication in this case (pid==0).  WUNTRACED
 * indicates that the caller should receive status about untraced children
 * which stop due to signals.  If children are stopped and a wait without
 * this option is done, it is as though they were still running... nothing
 * about them is returned.
 */
#define	WNOHANG		1	/* dont hang in wait */
#define	WUNTRACED	2	/* tell about stopped, untraced children */

#define	WIFSTOPPED(x)	(((union __wait*)&(x))->__w_stopval == _WSTOPPED)
#define	WIFSIGNALED(x)	(((union __wait*)&(x))->__w_stopval != _WSTOPPED && \
			((union __wait*)&(x))->__w_termsig != 0)
#define	WIFEXITED(x)	(((union __wait*)&(x))->__w_stopval != _WSTOPPED && \
			((union __wait*)&(x))->__w_termsig == 0)
#define	WEXITSTATUS(x)	(((union __wait*)&(x))->__w_retcode)
#define	WTERMSIG(x)	(((union __wait*)&(x))->__w_termsig)
#define	WSTOPSIG(x)	(((union __wait*)&(x))->__w_stopsig)

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* cusys:wait.c */
extern pid_t wait P_((int *status));
extern pid_t wait3 P_((int *status,int options,struct rusage *rusage));
extern pid_t waitpid P_((pid_t wpid,int *status,int options));
extern pid_t wait4 P_((pid_t wpid,int *status,int options,struct rusage *rusage));

#undef P_

#endif	/* !__sys_wait_h */
