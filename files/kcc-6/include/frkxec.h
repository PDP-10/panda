/* <FRKXEC.H> - definitions for USYS forkexec()
**
**	(c) Copyright Ken Harrenstien 1989
**
**	This is a new call invented for KCC, which combines fork() and
**	exec() for maximum efficiency over a variety of systems.
*/

#ifndef _FRKXEC_INCLUDED
#define _FRKXEC_INCLUDED

struct frkxec {
	int fx_flags;		/* Flag args to forkexec() */
	char *fx_name;		/* Program name */
	char **fx_argv;		/* Argument vector */
	char **fx_envp;		/* Environment vector */
	int fx_pid;		/* PID of created subfork (if win) */
	int fx_waitres;		/* wait() result if FX_WAIT was set */
	int fx_fdin;		/* FX_FDMAP: New stdin fd unless -1 */
	int fx_fdout;		/* FX_FDMAP: New stdout fd unless -1 */
	int fx_startoff;	/* FX_STARTOFF: Start offset */
	char *fx_tmpcor;	/* FX_T20_TMPCOR: 3-char tmpcor name */
	char *fx_blkadr;	/* FX_T20_PRARG etc */
	int fx_blklen;
};

#define FX_NOFORK	01	/* Do chain (exec), not subfork */
#define FX_PGMSRCH	02	/* Search for program name */
#define FX_FDMAP	04	/* Map standard I/O FDs from fdin, fdout */
#define FX_WAIT		010	/* Wait for subfork to finish */
#define FX_STARTOFF	020	/* Use start offset in fx_startoff */
#define FX_PASSENV	040	/* Pass environment to new fork */
#define FX_VERIFY	0100	/* Verify program only, don't run */

#define FX_T20_PRARG	01000	/* Set PRARG% block using blkadr & blklen */
#define FX_T20_TMPCOR	02000	/* Set CCL (with PRARG%/.TMP) using tmpcor */
#define FX_T20_RSCAN	04000	/* Set RSCAN using blkadr */
#define FX_T20_PGMJFN	020000	/* fx_name is actually a JFN */
#define FX_T20_PGMNAME	040000	/* Do direct GTJFN% on fx_name */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

extern int forkexec P_((struct frkxec *f));

#undef P_

#endif /* ifndef _FRKXEC_INCLUDED */
