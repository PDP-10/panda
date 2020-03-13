/*
**	FORKEXEC - Forking and program execution
**
**	(c) Copyright Ken Harrenstien 1989
**
**	forkexec() - KCC-specific function
**	execl(), execle(), execv(), execve(), execlp(), execvp()
**	fork(), vfork()
*/

#include <c-env.h>

#if SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS	/* Systems supported for */

#include <errno.h>
#include <frkxec.h>
#include <string.h>
#include <sys/usydat.h>
#include <sys/file.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/urtint.h>
#include <sys/c-debug.h>
#include <stdlib.h>
#include <urtsud.h>
#include <ctype.h>

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

extern pid_t getpid P_((void));

static char **revstack P_((char **av));
static int doexec P_((int flags,char *prog,char **argv,char **envp));
static void putoct P_((int jfn,int val));
static void putnl P_((int jfn));
static void putstr P_((int jfn,char *str,int len));
static void putusr P_((int jfn,char *str));
static void isync P_((void));
static void `ifork` P_((int fkhndl, int *frkfds));
static int `forkst` P_((void));
static int `vforke` P_((void));
static void `vforkx` P_((void));
static int _fork P_((void));
#if SYS_T20+SYS_10X
static int sysfkx P_((struct frkxec *f));
#endif 
#if SYS_T20+SYS_10X
static int execable P_((int jfn,int *errp));
static int findpgm P_((char *prog,int srchflg,int *errp,char *shell,char *sarg,int sargl));
static char *cvtargv P_((struct frkxec *f,char *shell,char *sarg,char *buf,int len));
#endif 
#if SYS_T20+SYS_10X
static void setpio P_((int frk,int infd,int outfd));
static void _setpio P_((int frk,int in,int out));
#endif 
#if SYS_T20+SYS_10X
static void _exec P_((int jfn,int offset,int envjfn));
#endif 
#if SYS_T10+SYS_CSI+SYS_WTS
static int sysfkx P_((struct frkxec *f));
#endif 

#undef P_

#if SYS_T20
#include <sys/param.h>
extern char **environ;
extern int `$TMPDR`;
#endif

#if SYS_T20+SYS_10X
#include <jsys.h>

#elif SYS_T10+SYS_CSI+SYS_WTS
#include <muuo.h>
#include <macsym.h>
#endif

#ifndef NULL
#define NULL	0
#endif

static int `vforkf` = 0;/* Non-zero if mem shared by vfork() */
static int `forkf` = 0;	/* Non-zero if sys data shared by fork() */

#ifdef _KCC_DEBUG
static int forknum = 0;
#endif

/* exec[lv][ ep]
**	l - takes argv as variable number of args in call
**	v - takes argv as pointer to array of args
**	  - environment pointer taken from current environment
**	e - environment pointer furnished as last arg in call
**	p - program name lookup uses shell search rules
**
** Matrix:	  -	  p	  e
**	    l	execl	execlp	execle
**	    v	execv	execvp	execve
**
** execl (prog, arg0, arg1, ..., 0);
** execlp(prog, arg0, arg1, ..., 0);		- program lookup
** execle(prog, arg0, arg1, ..., 0, envp);
** execv (prog, argv);
** execvp(prog, argv);				- program lookup
** execve(prog, argv, envp);			- Fundamental form of exec call
*/

int
execl(prog, arg0)	/* (prog, arg0, arg1, ..., 0) */
char *prog, *arg0;
{
    return doexec(0, prog, revstack(&arg0), NULL);
}

int
execlp(prog, arg0)	/* (prog, arg0, arg1, ..., 0)  - lookup program */
char *prog, *arg0;
{
    return doexec(FX_PGMSRCH, prog, revstack(&arg0), NULL);
}

int
execle(prog, arg0)		/* (prog, arg0, arg1, ..., 0, envp) */
char *prog, *arg0;
{
    return doexec(FX_PGMSRCH, prog, revstack(&arg0), NULL);
}

int
execv(prog, argv)		/* (prog, argv) */
char *prog, **argv;
{
    return doexec(0, prog, argv, NULL);
}

int
execvp(prog, argv)		/* (prog, argv) - look up program */
char *prog, **argv;
{
    return doexec(FX_PGMSRCH, prog, argv, NULL);
}

int
execve(prog, argv, envp)	/* (prog, argv, envp) */
char *prog, *argv[], *envp[];
{
    return doexec(0, prog, argv, envp);
}

/* REVSTACK - auxiliary for execl*() routines.
**	Reverses an array of pointers on the stack.
** On the PDP-10 an arg list like arg1, arg2, ... 0 is stored on
** the stack such that 0 is at the lowest address, arg1 at highest.
** We need to reverse this ordering so we can treat it like a normal
** argv array (with a null pointer as the last element).
*/
static char **
revstack(av)
char **av;
{
    register char **t, **b, *tmp;	/* Top and bottom pointers */
    register int i;

    for (t = b = av; *t; --t);	/* Back up to top of array (a null ptr) */
    av = t;			/* Remember where top is */
    i = (1 + b - t) / 2;	/* Find # of elements to swap in array */
    for (; i > 0; --i) {
	tmp = *t;		/* Swap elements, and bump ptrs closer. */
	*t++ = *b;
	*b-- = tmp;
    }
    return av;			/* Return ptr to top of reversed array */
}

/* DOEXEC - auxiliary for the exec*() routines.
*/

static int
doexec(flags, prog, argv, envp)
int flags;
char *prog, **argv, **envp;
{
    struct frkxec f;

    f.fx_flags = FX_NOFORK | FX_PASSENV | (flags & FX_PGMSRCH);
    f.fx_name = prog;
    f.fx_argv = argv;
    f.fx_envp = envp;
    return forkexec(&f);
}

/* Common subroutines for fork() and vfork() */

static void
putoct(jfn, val)
int jfn;
int val;
{
  int acs[5];

#ifdef _KCC_DEBUG
  if ((`$DEBUG` & _KCC_DEBUG_FORK_ENV) && !(jfn & LH)) _dbgo(val);
#endif
  acs[1] = jfn;
  acs[2] = val;
  acs[3] = monsym("NO%MAG")|010;
  jsys(NOUT, acs);
}

static void
putnl(jfn)
int jfn;
{
  int acs[5];

#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_FORK_ENV) _dbgs("\r\n");
#endif
  acs[1] = jfn;
  acs[2] = (int)'\n';
  jsys(BOUT, acs);
}

static void
putstr(jfn, str, len)
int jfn;
char *str;
int len;
{
  int acs[5];

#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_FORK_ENV) _dbgs(str);
#endif
  acs[1] = jfn;
  acs[2] = (int)(str - 1);
  acs[3] = len ? -len : strlen(str);
  jsys(SOUT, acs);
}

static void
putusr(jfn, str)
int jfn;
char *str;
{
  int i;

  while (*str) {
    i = strcspn(str, "\r\n\026");
    if (i) putstr(jfn, str, i);
    str += i;
    if (*str) {
      putstr(jfn, "\026", 1);
      putstr(jfn, str++, 1);
    }
  }
}

/* Initialize exec() syncronization address */
static void isync()
{
#asm
	extern	.fksyn

	movei	1,frksyn
	movem	1,.fksyn
#endasm
}

/* Initialize system for new fork 
 *	RH(fkhndl)	Relative fork handle of new fork
 *	LH(fkhndl)	-1: fork()/exec(), 0: [v]fork() only
 */
static void `ifork`(int fkhndl, int *frkfds)
{
  extern void _siginit(
#ifdef __STDC__
		       void
#endif
		       );
#ifdef _KCC_DEBUG
  forknum = fkhndl & 0377777;	/* Pass relative fork number to child */
  if (`$DEBUG` & _KCC_DEBUG_FORK_CREATE) {
    _dbgl("FORKEX&ifork(fork ");
    _dbgo(forknum);
    _dbgs(", frkfds ");
    if (frkfds) {
      _dbgs("{stdin=");
      _dbgo(frkfds[UIO_FD_STDIN]);
      _dbgs(", stdout=");
      _dbgo(frkfds[UIO_FD_STDOUT]);
      _dbgs(", stderr=");
      _dbgo(frkfds[UIO_FD_STDERR]);
      _dbgs("}");
    }
    else _dbgs("0");
    _dbgs(")\r\n");
  }
#endif

  isync();			/* Setup sync address */
  _iobfork(fkhndl, frkfds);	/* Share FDs with child */
  if (!USYS_VAR_REF(sigif))
    _siginit();			/* Initialize USYS signal stuff */
}

/* Start of child fork */
static int `forkst`()
{
#ifdef _KCC_DEBUG
  int l;

  l = strlen(`$HERIT`);
  if (l > (_MAXHERIT-7)) strcpy(&`$HERIT`[_MAXHERIT-7], "...");
  else {
    `$HERIT`[l] = '.';
    putoct((int)(&`$HERIT`[l]), forknum);
  }
  if (`$DEBUG` & _KCC_DEBUG_FORK_CREATE)
    _dbgl("FORKEX&forkst() Started\r\n");
#endif

  if (0) `forkst`();			/* Make compiler happy */

  /* Set signal system unused */
  USYS_VAR_REF(sigif) = 0;	/* Force child to initialize */
  USYS_VAR_REF(sigusys) = 0;	/* No interrupt in progress right now */
  USYS_VAR_REF(sigpendmask) = 0; /* Discard any pending signals (tough) */
  USYS_VAR_REF(atirtn) = 0;	/* No TTY int setup yet */

  _iobinit();			/* Initialize I/O data */

  USYS_VAR_REF(pidpar) = USYS_VAR_REF(pidslf); /* Old self is now parent */
  USYS_VAR_REF(pippid)
    = USYS_VAR_REF(clfork)
      = USYS_VAR_REF(nfork)
	= USYS_VAR_REF(pidslf) = 0;	/* No forks, reset self */
  return 0;				/* Return 0 in child */
}

/*
** vfork()
**
** This keeps the same map as the superior, but makes the superior
** wait for an exec() call before continuing.  Thus if all that is
** done is a store of the return value, that will get done again
** and nothing will be the worse.
**
** This cannot however be implemented merely by leaving the maps
** of the two the same, because then we wouldn't know which pid
** would be stored last.  UNIX claims to borrow the thread of control
** of the superior up to the exec(), but we fake it by making the
** superior wait until a HALTF% in exec(), triggered by vforkf != 0.
*/

static int `vforke`()
{
  if (0) `vforke`();		/* Make compiler happy */
  errno = EAGAIN;
  return -1;
}

static void `vforkx`()
{
  if (0) `vforkx`();		/* Make compiler happy */
  (void)USYS_END();		/* Interrupts OK again */
}

USYS_VAR_TO_ASM(sigusys,`sigusys`);
USYS_VAR_TO_ASM(nfork,`nforks`);

int
vfork()
{
	if (0) (`vforkf`++, `sigusys`++, `nforks`++);
#if SYS_T20+SYS_10X
#asm
	SEARCH MONSYM			/* Uppercase to avoid monsym() clash */
	extern	.vfcpy, .iobclean

	skipe	vforkf			/* Already in a vfork()? */
	 jrst	vforke			/* Yes, error */
	move	1,[cr%map!cr%cap!cr%acs] /* Set fork going */
	setz	2,			/* Copying registers from ours */
	cfork%				/* Make a fork */
	 erjmpa	vforke			/* Failed, return -1 & errno=EAGAIN */
	aos	USYS_VAR_ASM_REF(sigusys) /* Don't allow interrupts */
	setom	vforkf			/* Now in critical section */
	aos	USYS_VAR_ASM_REF(nforks) /* Count a fork created */
	push	17,[0]			/* No frkfds pointer */
	push	17,1			/* Stack handle as arg */
	pushj	17,ifork		/* Initialize system for new fork */
	pushj	17,.vfcpy		/* Copy "system" pages to new fork */
	pop	17,1			/* Restore fork handle */
	adjsp	17,-1			/* Unstack 0 */
	pop	17,16			/* Save return address in 16 */
	xmovei	2,forkst		/* Set subfork to start here */
	tlne	2,-1			/* If addr is in non-zero section, */
	 jrst	vfrk1a			/* must start using extended call */
	sfork%
	jrst	vfrk1b

vfrk1a:	move	3,2
	setz	2,
	xsfrk%				/* Start it at extended address. */
vfrk1b:	wfork%				/* Wait for it to synch in exec() */
	 erjmp .+1			/* In case of error */
	push	17,16			/* Save return address on stack */
	push	17,1			/* Save fork handle */
	pushj	17,.iobclean		/* Process halted fork */
	gjinf%				/* Get job # */
	hrrz	14,(17)			/* Get relative fork ID, clear LH */
	lsh	14,11			/* Shift fork handle up by 9 bits */
	andi	14,777000		/* Zap all but low 9 bits of handle */
	dpb	3,[001100,,14]		/* Store in low 9 bits of PID */
	exch	14,(17)			/* Save PID, get fork handle */
	setzm	vforkf			/* Clear vfork() flag */
	pushj	17,vforkx		/* Allow ints */
	pop	17,1			/* Get return value */
	popj	17,			/* And return */
#endasm
#else 	/* not T20+10X */
    errno = EAGAIN;		/* Say "no more processes" (sigh) */
    return -1;
#endif
}

/*
** fork()
** This does safe map copy before starting inferior
*/

int
fork()
{
    int ret;

    USYS_BEG();			/* Disable interrupts */
    ret = _fork();		/* Try to fork and see what we get */
    if (ret == -1)
	USYS_RETERR(EAGAIN);	/* Assume no more processes */
    USYS_VAR_REF(nfork)++;	/* Won, bump count of inferiors created! */
    if (ret != 0)
	USYS_RET(ret);		/* We're parent, just return fork handle */

    /* Here, we're the child process. */
    return 0;			/* Not in interrupt in child */
}

static int
_fork()
{
  if (0) `forkf`++;		/* Keep compiler happy */
#if SYS_T20+SYS_10X
#asm
	extern $mapsc
	extern .vfshr
#if SYS_T20
	nsects==40
#else
	nsects==1
#endif
	move	1,[cr%cap!cr%acs]	/* Same caps and regs as us */
	setz	2,			/* Copying registers from ours */
	cfork%				/* Make a fork */
	 erjmpa .+2			/* Lose lose, return -1 */
	  jrst fork1
	seto 1,
	popj 17,

fork1:	push	17,[0]			/* No frkfds pointer */
	push	17,1			/* Save fork handle */
	pushj	17,ifork		/* Initialize system for new fork */
	movei	7,.fhslf		/* Mapping from self */

	/*
	** Set inferior map looking like ours.  Can't just do fork-to-fork
	** PMAP% or CR%MAP CFORK% because then any changes
	** in impure data in the mother fork would be reflected in
	** the daughter (but not vice versa if PM%CPY set)
	*/

	movei	5,nsects		/* Counting off all sections */
	move	6,(17)			/* Get fork handle */
	setzb	10,11			/* Start with sect zero in each fork */
	push	17,forkf		/* Save our forkf */
	setom	forkf			/* And set for child */
fork2:	pushj	17,$mapsc		/* Map section across */
	addi	10,1			/* Increment source section */
	addi	11,1			/* Increment destination section */
	sojg	5,fork2			/* Until we are done */
	pop	17,forkf		/* Restore our forkf now that */
					/* child has its own copy */
	pushj	17,.vfshr		/* Share certain system data */
					/* fork handle still on stack*/
	pop	17,6			/* Restore fork handle */
	adjsp	17,-1			/* Unstack 0 */
	/* Map all set, now we can safely start the subfork and return. */
	move	1,6			/* Pages all mapped, get handle */
	xmovei	2,forkst		/* Set subfork to start here */
	tlne	2,-1			/* If addr is in non-zero section, */
	 jrst	fork8			/* must start using extended call */
	sfork%
	jrst fork9

fork8:	move	3,2
	setz	2,
	xsfrk%			/* Start it at extended address. */
fork9:				/* Return PID.  Fork handle in AC1 */
	gjinf%			/* Get job # in AC3 */
	dpb 6,[111100,,3]	/* Put low 9 bits of handle inside PID */
	hrrz 1,3		/* Clear LH and return the PID */
	popj	17,
#endasm
#else 	/* not T20+10X */
    return -1;			/* Not supported, always fail */
#endif
}	/* End of fork() */

/* FORKEXEC - combine fork() with exec() for highest efficiency
**
*/

int
forkexec(f)
struct frkxec *f;
{
    int res;

    USYS_BEG();
    if (f == NULL)
	USYS_RETERR(EINVAL);
    if (res = sysfkx(f))	/* Invoke sys-dep stuff */
	USYS_RETERR(res);
    USYS_RET(0);
}

#if SYS_T20+SYS_10X

#define RSCANLEN 1000
static int
sysfkx(f)
register struct frkxec *f;
{
    char rscanbuf[RSCANLEN];
    char shell[MAXPATHLEN] = {'\0'};
    char sarg[RSCANLEN] = {'\0'};
    char *rscanp;
    int acs[5], startpc, stoff;
    int frk = 0, jfn = 0, envjfn = -1, fd, err;
    int flags = f->fx_flags;
    
    f->fx_waitres = 0;

#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_FORK_CREATE) {
      _dbgl("FORKEX&sysfkx(");
      if (flags & FX_T20_PGMJFN) {
	_dbgs("jfn ");
	_dbgd((int)f->fx_name);
      }
      else {
	_dbgs("name \"");
	_dbgs(f->fx_name);
	_dbgs("\"");
      }
      if (flags & FX_FDMAP) {
	struct _ufile *uf;

	_dbgs(", stdin = fd");
	_dbgd(f->fx_fdin);
	if ((f->fx_fdin < OPEN_MAX)
	    && (f->fx_fdin >= 0)
	    && (uf = USYS_VAR_REF(uffd[f->fx_fdin]))) {
	  _dbgs("=");
	  _dbgj(uf->uf_ch);
	}
	_dbgs(", stdout = fd");
	_dbgd(f->fx_fdout);
	if ((f->fx_fdout < OPEN_MAX)
	    && (f->fx_fdout >= 0)
	    && (uf = USYS_VAR_REF(uffd[f->fx_fdout]))) {
	  _dbgs("=");
	  _dbgj(uf->uf_ch);
	}
      }
      _dbgs(")\r\n");
    }
#endif

    /* Check out new standard i/o FDs, if any were given */
    if ((flags & FX_FDMAP) && (
       (f->fx_fdin  >= 0
	&& (f->fx_fdin  >= OPEN_MAX || !USYS_VAR_REF(uffd[f->fx_fdin])))
    || (f->fx_fdout >= 0
	&& (f->fx_fdout >= OPEN_MAX || !USYS_VAR_REF(uffd[f->fx_fdout])))
	))
	return EBADF;

    stoff = (flags & FX_STARTOFF) ? f->fx_startoff : 0;

    if (flags & FX_T20_PGMJFN)		/* Use JFN directly? */
	jfn = (int)f->fx_name;
    else if (flags & FX_T20_PGMNAME) {	/* Use GTJFN% on name? */
	acs[1] = GJ_OLD|GJ_SHT;
	acs[2] = (int)(f->fx_name - 1);
	if (jsys(GTJFN, acs) <= 0)
	    return ENOENT;
	jfn = acs[1] & 0777777;
    }
    else {
      jfn = findpgm(f->fx_name, (flags & FX_PGMSRCH),
		    &err, shell, sarg, RSCANLEN);
      if (jfn <= 0) return err;		/* Couldn't find program */
    }

#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_FORK_CREATE) {
      _dbgl("FORKEX&sysfkx() jfn=");
      _dbgj(jfn);
      _dbgs("\r\n");
    }
#endif

    if (flags & FX_VERIFY) {	/* Verify only? */
	errno = 0;		/* Flag no error */
	goto fail;		/* And clean up jfn */
    }

#if SYS_T20		/* Get RSCAN buffer into shape */
    if (flags & FX_T20_RSCAN)
	rscanp = f->fx_blkadr;
    else if (*shell || f->fx_argv)
	rscanp = cvtargv(f, shell, sarg, rscanbuf, RSCANLEN);
    else rscanp = NULL;

    if (flags & FX_T20_PRARG) {
	if (f->fx_blkadr == NULL) {
	    errno = EINVAL;
	    goto fail;		/* Go clean up jfn */
	  }
    }
#endif

    /* From this point on, must be careful to free up "jfn" if we fail. */
    if (flags & FX_NOFORK) {	/* Simple exec()? */
	frk = _FHSLF;			/* Fork is ourself */
	f->fx_pid = getpid();
    } else {
        int frkfds[3];

	/* Do a fork(), then apply exec() to that fork. */
	acs[1] = CR_CAP;
	if (jsys(CFORK, acs) <= 0) {
	    errno = EAGAIN;		/* If fail, claim no more procs */
	    goto fail;
	}
	frk = acs[1];			/* Remember fork handle */
	jsys(GJINF, acs);
	f->fx_pid = ((frk & 0777)<<9) | (acs[3] & 0777);
	USYS_VAR_REF(nfork)++;		/* Bump count of forks created! */
	acs[1] = (frk << 18) | jfn;
	if (jsys(GET, acs) <= 0) {
	    if (acs[0] = monsym("OPNX5")) /* If "execute access required" */
	      errno = EACCES;		/* Give access error */
	    else errno = ENOEXEC;	/* Else not executable file? */
	    goto fail;
	}
	jfn = 0;			/* GET won, forget JFN */
	acs[1] = frk;
#if SYS_T20
	if (jsys(XGVEC, acs) > 0)	/* Get extended entry vector */
	    startpc = acs[3];
	else
#endif
	if (jsys(GEVEC, acs) > 0)	/* Get entry vector */
	    startpc = (acs[2] & 0777777);
	else {
	    errno = ENOEXEC;		/* No entry vector, not executable */
	    goto fail;
	}
	frkfds[UIO_FD_STDIN] =
	  (flags&FX_FDMAP) && (f->fx_fdin >= 0) ? f->fx_fdin : UIO_FD_STDIN;
	frkfds[UIO_FD_STDOUT] =
	  (flags&FX_FDMAP) && (f->fx_fdout >= 0) ? f->fx_fdout : UIO_FD_STDOUT;
	frkfds[UIO_FD_STDERR] = UIO_FD_STDERR;
	`ifork`(frk, frkfds);		/* Count I/O chans in use */
    }

    /* This code applies whether chaining or not. */
    if (rscanp) {			/* Set RSCAN buffer if need to */
#ifdef _KCC_DEBUG
        if (`$DEBUG` & _KCC_DEBUG_FORK_CREATE) {
	  _dbgl("FORKEX&sysfkx() cmd=\"");
	  _dbgs(rscanp);
	  _dbgs("\"\r\n");
	}
#endif
	acs[1] = (int)(rscanp-1);
	if (jsys(RSCAN, acs) <= 0) {
	    errno = E2BIG;
	    goto fail;
	}
    }

    if (flags & FX_T20_PRARG) {		/* Set PRARG% arg block */
	acs[1] = (_PRAST<<18) | frk;
	acs[2] = (int)(int *)f->fx_blkadr;
	acs[3] = f->fx_blklen;
	if (jsys(PRARG, acs) <= 0) {
	    errno = E2BIG;
	    goto fail;
	}
    }
#if SYS_T20
    /*	Now we construct a file containing the environment for the 
	subprocess. We will pass the filename in a PRARG block.
	The subprocess is expected to delete the file after reading
	the contents. All this only if FX_T20_PRARG was not already
	specified above. */
    if (flags & FX_PASSENV) {
      int acs[5], jsyerr, envnamptr, envf;
      char **ep, *p, tmpdir[MAXPATHLEN];
      struct _ufile *ufe;

      envnamptr = _tfile("-KCC-ENVIRONMENT.TMP;T");
      acs[1] = GJ_SHT | GJ_FOU;
      acs[2] = envnamptr;
      if (jsys(GTJFN, acs)) {
	envjfn = acs[1];
	acs[2] = OF_WR | (7 << 30);
        if (!jsys(OPENF, acs)) {
	  jsyerr = acs[0];
	  acs[1] = envjfn;
	  jsys(RLJFN, acs);
	  goto envfail;
	}
#ifdef _KCC_DEBUG
        if (`$DEBUG` & _KCC_DEBUG_FORK_ENV) {
	  _dbgl("FORKEX&sysfkx() envjfn=");
	  _dbgj(envjfn);
	  _dbgs(":\r\n");
	}
#endif
	putstr(envjfn, "*UMASK=0", 0);
	putoct(envjfn, USYS_VAR_REF(umask));
	putnl(envjfn);
#ifdef _KCC_DEBUG
	putstr(envjfn, "*HERIT=", 0);
	putstr(envjfn, `$HERIT`, 0);
	if (!(flags & FX_NOFORK)) { /* If forkexec() */
	  putstr(envjfn, ".", 0);
	  putoct(envjfn, frk & 0377777);
	}
	putnl(envjfn);
#endif
	if (USYS_VAR_REF(curdir)) {
	  putstr(envjfn, "*CWD=0", 0);
	  putoct(envjfn, USYS_VAR_REF(curdir));
	  putnl(envjfn);
	}
	if (`$TMPDR`) {
	  putstr(envjfn, "*TMP=", 0);
	  _dirst(`$TMPDR`, tmpdir);
	  putstr(envjfn, tmpdir, 0);
	  putnl(envjfn);
	}
	if (`$DEBUG`) {
	  putstr(envjfn, "*DEBUG=", 0);
	  putoct(envjfn, `$DEBUG`);
	  putnl(envjfn);
	}
	if ((ufe = USYS_VAR_REF(uffd[UIO_FD_STDERR]))
	    && (ufe->uf_ch != _CTTRM)) {
	  putstr(envjfn, "*STDERR=", 0);
	  putoct(envjfn,
		 (ufe->uf_type == _DVNUL) ? monsym(".NULIO") : ufe->uf_ch);
	  putnl(envjfn);
	}
 	ep = f->fx_envp ? f->fx_envp : environ;
        while (p = *ep++) {
	  putusr(envjfn, p);
	  putnl(envjfn);
	}
	putstr(envjfn, "*ARGV=", 0);
	envf = 0;			/* No args yet */
	ep = f->fx_argv;		/* Get args pointer */
	if (*shell) {			/* Are we SHELLing a script? */
	  envf++;			/* Arg output */
	  putusr(envjfn, shell, 0);	/* Put shell name in argv */
	  putnl(envjfn);
	  if (*sarg) {			/* Yes, any arg to SHELL? */
	    putusr(envjfn, sarg, 0);	/* Yes, place in argv */
	    putnl(envjfn);
	  }
	  putusr(envjfn, f->fx_name, 0); /* Put script name as next arg */
	  putnl(envjfn);
	  if (ep && *ep) ep++;		/* And skip first argv entry */
	}
	if (ep) {
	  while (p = *ep++) {
	    envf++;
	    putusr(envjfn, p, 0);	/* Put original args in argv */
	    putnl(envjfn);
	  }
	}
	if (!envf) putnl(envjfn);	 /* Terminate ARGV= if no args */
#ifdef _KCC_DEBUG
        if (`$DEBUG` & _KCC_DEBUG_FORK_ENV) {
	  _dbgl("FORKEX&sysfkx() envjfn end\r\n");
	}
#endif
      }
      else {
	jsyerr = acs[0];
  envfail:
	acs[1] = _CTTRM;
	acs[3] = 0;
	acs[2] = (int)("\r\n\
Failed to set environment for new process\r\n\
File: " - 1);
        jsys(SOUT, acs);
	acs[2] = envnamptr;
	jsys(SOUT, acs);
	acs[2] = (int)("\r\nJSYS error: " - 1);
	jsys(SOUT, acs);
	acs[2] = (_FHSLF << 18) | (jsyerr & RH);
	jsys(ERSTR, acs);
	acs[2] = (int)("\r\n" - 1);
	jsys(SOUT, acs);
     }
    }
#endif

    /* Now must do hack to ensure that stdin and stdout are preserved
    ** over the map, and work even if new program is not a C program.
    ** This is done by setting the primary JFNs .PRIIN and .PRIOU to
    ** whatever stdin and stdout should be for the new fork/program.
    ** This is normally whatever they are for the current program.
    */
    setpio(frk, (flags&FX_FDMAP) ? f->fx_fdin  : UIO_FD_STDIN,
		(flags&FX_FDMAP) ? f->fx_fdout : UIO_FD_STDOUT);

    /* Now if chaining, ready to load program! */

    if (flags & FX_NOFORK) {		/* Simple exec()? */

      /* Simulate CLOSE-ON-EXEC for all but standard FDs, since the */
      /* standard ones are the only ones we can pass to new image. */
      for (fd = 0; fd < OPEN_MAX; fd++)
	if (USYS_VAR_REF(uffd[fd])) {
	  if ((fd == ((flags&FX_FDMAP) ? f->fx_fdin  : UIO_FD_STDIN))
	      || (fd == ((flags&FX_FDMAP) ? f->fx_fdout  : UIO_FD_STDOUT))
	      || (fd == UIO_FD_STDERR)) continue;
	  close(fd);
	}

      _exec(jfn, stoff, envjfn);	/* Now replace ourselves */
    }

    /* Starting inferior process! */

#if SYS_T20
    /* Are we passing environment? */
    if ((flags & FX_PASSENV) && (envjfn > 0)) {
      int pacs[020];
#     define MAGIC_ENVIRO ((('E'-040)<<30)|(('N'-040)<<24)|(('V'-040)<<18)|(('I'-040)<<12)|(('R'-040)<<6)|('O'-040))
#     define MAGIC_KCC ((('K'-040)<<12)|(('C'-040)<<6)|('C'-040))

      /* Setup environment JFN handshake values */
      pacs[015] = MAGIC_ENVIRO;
      pacs[016] = (envjfn << 18) + MAGIC_KCC;
      acs[1] = frk;
      acs[2] = (int)&pacs;
      jsys(SFACS, acs);			/* Attempt to pass environment JFN */
    }
    acs[1] = frk;
    acs[2] = 0;
    acs[3] = startpc + stoff;
    if (jsys(XSFRK, acs) > 0)		/* Extended start */
	startpc = acs[3];
    else				/* If it fails, try sec 0 version */
#endif
    {
	acs[1] = frk;
	acs[2] = startpc + stoff;
	if (jsys(SFORK, acs) <= 0) {
	    errno = EFAULT;			/* What else to use? */
	    goto fail;
	}
    }
    if (flags & FX_WAIT) {		/* Wait until fork done? */
	(void)USYS_END();		/* Allow interrupts while waiting */
	if (waitpid(f->fx_pid,&f->fx_waitres,0) < 0)
					/* Wait for fork and save status */
	  return errno;			/* Return error code on failure */
	USYS_BEG();			/* Must say in syscall again  */
	USYS_VAR_REF(nfork)--;
	return 0;			/* Say we won */
    }

    return 0;			/* Won! */

fail:		/* Failure, clean up any debris */
    if (frk && (frk != _FHSLF)) {
	acs[1] = frk;
	if (jsys(KFORK, acs) > 0)
	    USYS_VAR_REF(nfork)--;
    }
    if (jfn) {
	acs[1] = jfn;
	jsys(RLJFN, acs);
    }
    return errno;		/* Fail */
}
#endif /* SYS_T20+SYS_10X */

#if SYS_T20+SYS_10X

#define IMAGE 1
#define SCRIPT 2

static int execable(jfn, errp)
int jfn;
int *errp;
{
  int cnt, adr, bsz, acs[5], type;

#ifdef _KCC_DEBUG
  if (`$DEBUG` & _KCC_DEBUG_FORK_EXEC) {
    _dbgl("FORKEX&execable(");
    _dbgj(jfn);
    _dbgs(")\r\n");
  }
#endif
  
  if (!_chkac(_CKAEX, 0, jfn)) {	/* Check for execute access */
#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_FORK_EXEC) {
      _dbgl("FORKEX&execable() No execute access\r\n");
    }
#endif
    *errp = EACCES;			/* Not executable */
    return 0;				/* Can't be either */
  }

  /* Check file to see if it is executable or script */

  *errp = ENOEXEC;			/* Default error */

  if (_gtfdb(jfn, _FBCTL) & FB_DIR) {
#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_FORK_EXEC) {
      _dbgl("FORKEX&execable() Cannot execute directory\r\n");
    }
#endif
    return 0;				/* Can't be either */
  }

  bsz = FLDGET(_gtfdb(jfn, monsym(".FBBYV")), monsym("FB%BSZ"));
					/* Get byte size */
  switch (bsz) {
  case 0:				/* Special case */
    type = IMAGE;			/* Could be executable */
    break;
  case 36:				/* Full words */
    bsz = 7;				/* Use 7 bit bytes later */
  case 9:				/* C binary or text */
    type = IMAGE|SCRIPT;		/* Could be executable or script */
    break;
  case 7:				/* C text */
  case 8:				/* C text */
    type = SCRIPT;			/* Could be script */
    break;
  }

#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_FORK_EXEC) {
      _dbgl("FORKEX&execable() Byte size = ");
      _dbgd(bsz);
      _dbgs(", type = ");
      switch(type) {
      case SCRIPT|IMAGE: _dbgs("SCRIPT|IMAGE"); break;
      case SCRIPT: _dbgs("SCRIPT"); break;
      case IMAGE: _dbgs("IMAGE"); break;
      default: _dbgs("none, cannot execute"); break;
      }
      _dbgs("\r\n");
    }
#endif

  if (!type) return 0;			/* Any chance? */

  acs[1] = jfn;
  acs[2] = ((type & IMAGE ? 36 : bsz) << 30) | OF_RD;
					/* Open in appropriate mode */
  if (!jsys(OPENF, acs)) {		/* Open for read */
#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_FORK_EXEC) {
      _dbgl("FORKEX&execable() OPENF failed, cannot be SCRIPT\r\n");
    }
#endif
    type &= ~SCRIPT;			/* Can't be script */
    return type;			/* Failed, may still be IMAGE */
  }

  if (type & IMAGE) {
    if (!jsys(BIN, acs)) {		/* Read first word */
#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_FORK_EXEC) {
      _dbgl("FORKEX&execable() BIN failed, cannot execute\r\n");
    }
#endif
      return 0;				/* Can't be either */
    }
    cnt = acs[2] >> 18;			/* LH is potential count */
    adr = acs[2] & RH;			/* RH is address */

    if ((cnt < 0)			/* CSAVE format? */
	? ((adr - cnt) > 01000000)	/* Yes, check adr + #words < sec */
	: ((cnt != 01776) && (cnt != 01000))) {/* No, check EXE/SAV */
#ifdef _KCC_DEBUG
      if (`$DEBUG` & _KCC_DEBUG_FORK_EXEC) {
	_dbgl("FORKEX&execable() Bad EXE/SAV file, cannot be IMAGE\r\n");
      }
#endif
      type &= ~IMAGE;			/* Can't be image anymore */
    }

    if (type & SCRIPT) {		/* Need to check script? */
      acs[2] = bsz;			/* Yes, change byte size */
      if (!jsys(SFBSZ, acs)) {
#ifdef _KCC_DEBUG
	if (`$DEBUG` & _KCC_DEBUG_FORK_EXEC) {
	  _dbgl("FORKEX&execable() SFBSZ failed, cannot be SCRIPT\r\n");
	}
#endif
	type &= ~SCRIPT;		/* Can't be script if error */
      }
    }
  }

  if (type & SCRIPT) {			/* If could be script, */
    acs[2] = 0;				/* Byte position */
    if (!jsys(SFPTR, acs)		/* Reset to beginning of file */
	|| !jsys(BIN, acs)		/* Read a character */
	|| (acs[2] != '#')		/* And check for pound */
	|| !jsys(BIN, acs)		/* Read another */
	|| (acs[2] != '!')) {		/* And check for bang */
#ifdef _KCC_DEBUG
      if (`$DEBUG` & _KCC_DEBUG_FORK_EXEC) {
	_dbgl("FORKEX&execable() No \"#!\", cannot be SCRIPT\r\n");
      }
#endif
      type &= ~SCRIPT;			/* Failed, can't be script */
    }
  }

#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_FORK_EXEC) {
      _dbgl("FORKEX&execable() -> Type = ");
      switch(type) {
      case SCRIPT|IMAGE: _dbgs("SCRIPT|IMAGE"); break;
      case SCRIPT: _dbgs("SCRIPT"); break;
      case IMAGE: _dbgs("IMAGE"); break;
      default: _dbgs("none, cannot execute"); break;
      }
      _dbgs("\r\n");
    }
#endif

  return type;
}


/* Auxiliaries for forkexec() */

static int
findpgm(prog, srchflg, errp, shell, sarg, sargl)
char *prog;		/* Program name */
int srchflg;		/* True if want to search for program */
int *errp;		/* Error code return */
char *shell;		/* MAXPATHLEN buffer for shell name */
char *sarg;		/* Where to put script argument */
int sargl;		/* Max length of script argument */
{
  char buf[MAXPATHLEN], *path = getenv("PATH"), *p;
  int jfn = 0, i, acs[5], type;
  
  /* Ensure not too big and try prefix */
  if (srchflg && path) {
    char *brkset, *p;
    int l = strlen(prog);
    
    /* Check for explicit path which disables use of PATH */
    switch (_urtsud.su_path_in_type) {
    case _URTSUD_PATH_IN_UNIX:
      brkset = "\026/";			/* UNIX */
      break;
    case _URTSUD_PATH_IN_NATIVE:
      brkset = "\026:[<";		/* TOPS20 */
      break;
    default:
      brkset = "\026/:[<";		/* both */
      break;
    }
    
    p = prog;
    while (*p) {			/* Loop until end */
      p += strcspn(p, brkset);		/* Skip to next break */
      if (!*p) break;			/* Quit at end */
      if (*p != '\026') break;		/* If not quote, quit */
      if (!*++p) break;			/* Advance to quoted */
      /* char and quit if null */
      p++;				/* Skip quoted char also */
    }
    
    if (!*p) {				/* If no path characters, */
      while (*path) {			/* Try each path comp */
	i = strcspn(path, ":");		/* Find end of path comp */
	if (i && ((l + i) < MAXPATHLEN)) { /* Non-null path and room? */
	  strncpy(buf, path, i);	/* Yes, start with path */
	  p = buf + i;			/* Where to add next char */
	  switch (p[-1]) {		/* Check terminator */
	  case ']':
	  case '>':			/* TOPS20 separators */
	    if (_urtsud.su_path_in_type == _URTSUD_PATH_IN_UNIX)
					/* If UNIX syntax only, */
	    default:
	      *p++ = '/';		/* Add speparator */
	  case '/':
	    break;			/* Else have separator */
	  }
	  strcpy(p, prog);		/* Add program name */
	  if ((jfn = _gtjfn(buf, O_RDONLY)) > 0)
	    break;			/* try result */
	}
	path += i;			/* Skip over path comp */
	if (*path) path++;		/* If not end, skip sep */
      }
    }
  }

  if (jfn <= 0)
    jfn = _gtjfn(prog, O_RDONLY);	/* try just prog */
  

  if (jfn <= 0) {
#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_FORK_EXEC) {
      _dbgl("FORKEX&findpgm(\"");
      _dbgs(prog);
      _dbgs("\") not found\r\n");
    }
#endif
    *errp = ENOENT;
    return 0;				/* All failed, give up */
  }

  type = execable(jfn, errp);		/* See if execable */

  if (type & SCRIPT) {			/* Could it be a script? */

    /* Here we assume that execable() left input positioned after "#!" */

    acs[1] = jfn;
    while (jsys(BIN, acs) && isascii(acs[2]) && isspace(acs[2]));
					  /* Skip whitespace */
    /* Get path up to next whitespace */
    i = 0;
    while (1) {
      if (acs[2] && isascii(acs[2]) && !isspace(acs[2]))
	shell[i++] = acs[2];
      else {
	shell[i++] = '\0';
	break;
      }
      if (!jsys(BIN, acs) || (i >= MAXPATHLEN)) {
#ifdef _KCC_DEBUG
	if (`$DEBUG` & _KCC_DEBUG_FORK_EXEC) {
	  _dbgl("FORKEX&findpgm(\"");
	  _dbgs(prog);
	  _dbgs("\") bad format\r\n");
	}
#endif
	goto noexec;			/* If error or no room, not exec */
      }
    }

    /* If space or tab, argument follows path */
    if ((acs[2] == '\t') || (acs[2] == ' ')) {
      i = 0;
      while (jsys(BIN, acs) && isascii(acs[2]) && isspace(acs[2]));
					  /* Skip whitespace */
      while (1) {
	if ((i < sargl) && acs[2] && isascii(acs[2])
	    && (acs[2] != '\n') && (acs[2] != '\r'))
	  sarg[i++] = acs[2];
	else {
	  sarg[i++] = '\0';
	  break;
	}
	if (!jsys(BIN, acs)) acs[2] = '\0'; /* Fake end on error */
      }
    }

    jsys(CLOSF, acs);			/* Discard script JFN */

    jfn = _gtjfn(shell, O_RDONLY);	/* Get shell for script */

#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_FORK_EXEC) {
      _dbgl("FORKEX&findpgm() Shell = \"");
      _dbgs(shell);
      _dbgs("\", arg = \"");
      _dbgs(sarg);
      _dbgs("\"");
      if (jfn <= 0) _dbgs(", not found");
      _dbgs("\r\n");
    }
#endif

    if (jfn <= 0) {
      *errp = ENOENT;
      return 0;				/* All failed, give up */
    }

    if (p = strrchr(shell, '/')) strcpy(shell, p + 1);
					/* Discard initial path on shell */
    type = execable(jfn, errp);		/* See if execable */
#ifdef _KCC_DEBUG
    if (!(type & IMAGE) && (`$DEBUG` & _KCC_DEBUG_FORK_EXEC)) {
	_dbgl("FORKEX&findpgm() Shell \"");
	_dbgs(shell);
	_dbgs("\" cannot be IMAGE\r\n");
      }
#endif
    /* Fall into IMAGE check */
  }

  if (type & IMAGE) {
    acs[1] = jfn | CO_NRJ;		/* JFN + don't release */
    jsys(CLOSF, acs);			/* Return JFN to unopened state */
    return jfn;
  }  

 noexec:
  acs[1] = jfn;
  jsys(CLOSF, acs);
  jsys(RLJFN, acs);
  return 0;
}

static char *
cvtargv(f, shell, sarg, buf, len)
register struct frkxec *f;
char *shell, *sarg, *buf;
int len;
{
  register char *t, *ap, **av;
  
  av = f->fx_argv;
  if ((*shell == '\0') && (av == NULL || *av == NULL))
    return NULL;		/* No args */
  t = buf-1;

  if (*shell) {
    ap = (shell - 1);		/* shell name is first arg */
    while ((--len > 0) && (*++t = *++ap));
    *t = ' ';
    if (*sarg) {
      ap = (sarg - 1);		/* Add any shell args */
      while ((--len > 0) && (*++t = *++ap));
      *t = ' ';
    }
    ap = (f->fx_name - 1);	/* And script name */
    while ((--len > 0) && (*++t = *++ap));
    *t = ' ';
    if (av) av++;		/* Discard first argv entry */
  }

  while (ap = *av++) {
    ap--;
    while ((--len > 0) && (*++t = *++ap));
    *t = ' ';			/* Space between each arg */
  }
  if (t == (buf - 1)) t++;	/* In case nothing stored */
  if ((t != buf) && (t[-1] != '\n')) {
    *t = '\n';			/* Last arg ends with linefeed, not space */
    if (len > 0) ++t;
  }
  *t = '\0';			/* and a null */
  return buf;
}
#endif /* SYS_T20+SYS_10X */

#if SYS_T20+SYS_10X

static void
setpio(frk, infd, outfd)
int frk, infd, outfd;
{
    int injfn, outjfn;

    injfn = outjfn = -1;

    /* Get JFNs and guard against close below */
    if ((infd >= 0) && USYS_VAR_REF(uffd[infd]))
      injfn = USYS_VAR_REF(uffd[infd]->uf_ch);
    if ((outfd >= 0) && USYS_VAR_REF(uffd[outfd]))
      outjfn = USYS_VAR_REF(uffd[outfd]->uf_ch);

    _setpio(frk, injfn, outjfn);
}

static void
_setpio(frk, in, out)
int frk, in, out;
{
#asm
	move 1,-1(17)		; Get fork handle to use
	gpjfn%			; Get current settings for primary i/o
	move 5,2		; Save them elsewhere
	hrre 4,-2(17)		; Check input arg
	jumpl 4,skipin		; If no setting, skip input stuff.
	caie 4,.priin
	 hrl 2,4		; If non-standard, set LH to new value!
skipin:	hrre 4,-3(17)		; Check output arg
	jumpl 4,skipo		; If no setting, skip output stuff.
	caie 4,.priou
	 hrr 2,4		; If non-standard, set RH to new value!
skipo:
	camn 2,5		; OK, is new setting any different from old?
	 popj 17,
	move 1,-1(17)		; One is different, must map!
	spjfn%			; Do it
#endasm
}
#endif /* T20+10X */

#if SYS_T20+SYS_10X

/*
** Low level support for exec()
**
** _exec(jfn, offset, envjfn)
**	Chains to the program in the file that the jfn identifies.
**	Starting at normal start+offset, passing envjfn in LH AC16.
**	Never returns if successful.
**
**	If we were in vfork() we HALTF% to give the superior a chance to synch.
*/
static void
_exec(jfn, offset, envjfn)
int jfn, offset, envjfn;
{
#asm
#if SYS_T20
	extern	.iobgufi

	movei 1,.fhslf
	setz 2,
	scvec%			/* Reset compat package vector! */
#endif
	/* NOTE!! We cannot use SFRKV% to start ourselves if the start offset
	** is anything but 0, because SFRKV% does funny things if the entry
	** vector is JRST FOO (as it is for program like LINK).  In that case
	** it starts the program at .JBREN rather than .JBSA+offset, and things
	** blow up.  Hence the extra code to get the entry vector explicitly,
	** and we have to use XGVEC% in case the program is extended to begin
	** with!  Space is sure getting tight in the ACs...
	*/
#if SYS_T20
	movei 1,.fhslf
	xgvec%			/* Must find out whether this will work */
	erjmp exec4		/* If failed, jump to handle old system */
	xmovei 0,.		/* Get PC section number in LH AC 0 */
	tlne 0,777777		/* Non-zero? */
	 jrst exec3		/* Yes */
	seto 1,			/* Unmap */
	move 2,[.fhslf,,1]	/* From self starting from section 1 */
	movei 3,37		/* All nonzero sections */
	smap%			/* AC7  unmap all nonzero sections */
	 erjmp .+1
	/* Set up ACs for multi-section system running in section 0 */
	move	0,[acsex0,,1]	/* Get BLT pointer to set regs */
	jrst exec5

exec3:	/* First unmap section 0 pages */
	seto 1,			/* unmap pages */
	movsi 2,.fhslf		/* from self starting page 0 */
	move 3,[pm%cnt!pm%epn!1000] /* to bottom of the section */
	pmap			/* Bye, bye */
	/* Set up ACs for multi-section system running in non-zero section */
	move	0,[acsex1,,1]	/* Get BLT pointer to set regs */
	jrst exec5
#endif
	/* Set up ACs for single-section system */
exec4:	move	0,[acsone,,1]	/* Get BLT pointer to set regs */
exec5:	pushj	17,.iobgufi	/* Get std UF indexes */
	push	17,1		/* Save result */
	blt 	0,16		/* Copy all of ACs 1-16 across */
	hrr	acoff,-3(17)	/* Set start offset in RH of proper AC */
	move	0,-2(17)	/* Save JFN for GET in AC0 */
	hrli	0,.fhslf	/* <handle>,,<jfn> */
	hrl	jfnoff,-4(17)	/* Environment jfn to LH AC16 */
	move	17,(17)		/* Restore UF indexes to 17 */
	/* Now no longer need memory for anything, all is in the ACs. */
	skipn	forkf		/* If started by fork(), */
	 skipe	vforkf		/* or vfork() */
	  haltf%		/* Stop and let superior catch up */
frksyn:	/* This PC is checked to ensure HALTF% is right one! */

	jrst	@[4]			/* Jump to section 0 regs */

#if SYS_T20
	/* ACs for multi-section TOPS-20 */
acsex0:				/* where to copy regs from */
	-1			/* AC1  unmapping */
	.fhslf,,0		/* AC2  from self starting page 0 */
	pm%cnt!pm%epn!1000	/* AC3  to bottom of the section */
	pmap%			/* AC4  unmap section zero */
	erjmp	6		/* AC5  match SMAP code */
	move	1,0		/* AC6  get back GET% argument */
	get%			/* AC7  map new program into ourself */
	movei	1,.fhslf	/* AC10 this process again */
	xgvec%			/* AC11 get extended entry vector */
	setz	2,		/* AC12 clear flags */
acoff==13
	addi	3,.-.		/* AC13 add start offset */
	xjrstf  2		/* AC14 start there! */
	'ENVIRO'		/* AC15 */
jfnoff==16
	.-.,,'KCC'		/* AC16 */

acsex1:				/* where to copy regs from */
	-1			/* AC1  unmapping */
	.fhslf,,1		/* AC2  from self starting page 0 */
	37			/* AC3  to bottom of the section */
	smap%			/* AC4  unmap all nonzero sections */
	erjmp	6		/* AC5  win with pre-rel-5 TOPS-20 */
	move	1,0		/* AC6  get back GET% argument */
	get%			/* AC7  map new program into ourself */
	movei	1,.fhslf	/* AC10 this process again */
	xgvec%			/* AC11 get extended entry vector */
	setz 2,			/* AC12 clear flags */
/* Must match acoff above */
	addi	3,0		/* AC15 add start offset */
	xjrstf  2		/* AC16 start there! */
	'ENVIRO'		/* AC15 */
/* Must match jfnoff above */
	.-.,,'KCC'		/* AC16 */
#endif /* T20 */

	/* ACs for single-section system (TOPS-20 or TENEX) */
acsone:
	-1			/* AC1  unmapping */
	.fhslf,,0		/* AC2  from self starting page 0 */
#if SYS_T20
	pm%cnt!pm%epn!1000	/* AC3  to bottom of the section */
	pmap%			/* AC4  unmap section zero */
	jfcl			/* AC5 */
	jfcl			/* AC6 */
#else
	1000			/* AC3  TENEX has no PM%CNT */
	pmap%			/* AC4  unmap a page */
	aoj	2,		/* AC5  point to next */
	sojg	3,4		/* AC6  loop until all unmapped */
#endif
	move	1,0		/* AC7 get back GET% argument */
	get%			/* AC10 map new program into ourself */
	movei	1,.fhslf	/* AC11 this process again */
	gevec%			/* AC12 Get entry vector, and */
/* Must match acoff above */
	jrst (2)		/* AC13 start there, plus offset */
	block 1			/* AC14 */
	'ENVIRO'		/* AC15 */
/* Must match jfnoff above */
	.-.,,'KCC'		/* AC16 */

#endasm
}
#endif /* T20+10X */

#if SYS_T10+SYS_CSI+SYS_WTS

static int
sysfkx(f)
struct frkxec *f;
{
    struct _filespec fs;
    struct runblk {
	int rn_dev;
	int rn_nam;
	int rn_ext;
	int rn_x;	/* Unused, shd be 0 */
	int rn_ppn;
	int rn_mem;
	} rn;
    int res, off;
    int flags = f->fx_flags;

    /* First ensure realistic expectations */
    if (!(flags&FX_NOFORK))
	return EAGAIN;		/* Cannot create process */
    flags &= ~FX_WAIT;		/* No point waiting if chaining */
    if (flags & ~(FX_NOFORK|FX_PGMSRCH|FX_STARTOFF))	/* Only hack these */
	return EINVAL;		/* Unimplemented flags given */

    /* Try to determine what program to run */
    if (res = _fparse(&fs, f->fx_name))
	return res;		/* Parse failed, return error */
    
    rn.rn_dev = fs.fs_dev;	/* Set up block for RUN UUO */
    rn.rn_nam = fs.fs_nam;
    rn.rn_ext = fs.fs_ext;
    rn.rn_ppn = (fs.fs_nfds > 1)	/* Set directory (PPN or path) */
		    ? (int)&fs.fs_path : fs.fs_path.p_path.ppn;
    rn.rn_x = rn.rn_mem = 0;

    /* If no device or PPN and wants search, use SYS:, else just DSK: */
    if (!rn.rn_dev)
	rn.rn_dev = (!rn.rn_ppn && (flags&FX_PGMSRCH))
			? _SIXWRD("SYS") : _SIXWRD("DSK");
#if SYS_WTS
    if (!rn.rn_ext)
	rn.rn_ext = _SIXWRD("DMP");
#endif

    off = (flags & FX_STARTOFF)		/* Set start addr offset */
		? f->fx_startoff : 0;

    if (MUUO_ACVAL("RUN", XWD(off, (int)&rn), &res) <= 0) {
	/* Perhaps could try to interpret error code in res, but... */
	return ENOENT;
    }
    _panic("RUN returned?!");		/* Should never get here!!! */
    return ESRCH;			/* Random return to pacify compiler */
}
#endif /* T10+CSI+WAITS */

#endif /* T20+10X+T10+CSI+WAITS */
 