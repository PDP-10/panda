/*
**	SYSTEM	- Issue a "shell" command
**
**	(c) Copyright Ken Harrenstien, SRI International 1986
**
**	This is only a partial implementation.  It assumes the first word
**	of the string argument is a program name, and invokes that
**	program with the string as its sole argument.
*/

#include <c-env.h>
#if SYS_T20+SYS_10X		/* Systems supported for */

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#if CPU_PDP10
#include <frkxec.h>
extern int forkexec();		/* Syscall */
#else
#include <unistd.h>
#endif

#if __STDC__
#define CONST const
#else
#define CONST
#endif

int
system(s)
CONST char *s;
{
#if 1
# if CPU_PDP10
    char *av[4];
    int res;
    struct frkxec f;

    av[0] = "sh";			/* Always use this shell */
    av[1] = "-c";			/* Say passing a command */
    av[2] = s;				/* This is the command */
    av[3] = NULL;			/* This is the end */

    f.fx_flags = FX_PGMSRCH | FX_WAIT | FX_PASSENV;
    f.fx_name = av[0];			/* First arg is program */
    f.fx_envp = NULL;			/* Default environ */
    if (!s) {				/* Just requesting verification? */
      f.fx_argv = NULL;			/* No args */
      f.fx_flags |= FX_VERIFY;		/* Verify program only */
      return forkexec(&f);		/* Return status */
    }

    f.fx_argv = av;			/* Arg list */
    if (forkexec(&f) < 0)		/* Invoke the program */
      res = 127;			/* Failed to invoke shell */
    else res = f.fx_waitres;		/* Return status */
# else /* CPU_PDP10 */
    char *av[4];
    int res, pid;

    if (!s)				/* Just requesting verification? */
	return access("/bin/sh", X_OK);	/* Yes, return access status */
    av[0] = "/bin/sh";			/* Always use this shell */
    av[1] = "-c";			/* Say passing a command */
    av[2] = s;				/* This is the command */
    av[3] = NULL;			/* This is the end */

    if ((pid = vfork()) == 0) {		/* Fork, sharing memory for speed */
      execv(av[0], av, NULL);		/* Invoke the program */
      _exit(127);			/* Just exit child if invoke failed */
    }
    while (wait(&res) != pid);		/* Wait until child done */
# endif /* CPU_PDP10 */
    return res;
#else /* !1 */
    char *prog;
    int proglen, res;

    proglen = strpos(s, ' ');	/* See if 1st arg ends in space */
    if (proglen < 0) prog = (char *)s;	/* No, whole string is prog name */
    else {			/* Aha, create separate string for prog name */
	if ((prog = malloc(proglen+1)) == NULL) {
	    fprintf(stderr,"\nsystem(): cannot malloc space for prog name\n");
	    return(127);
	}
	strncpy(prog, s, proglen);	/* Extract program name */
	prog[proglen] = '\0';		/* Tie off */
    }

# if CPU_PDP10
    {
	struct frkxec f;
	char *av[2];
	av[0] = (char *)s;		/* Set up fake argv array */
	av[1] = 0;
	f.fx_flags = FX_PGMSRCH | FX_WAIT;
	f.fx_name = prog;
	f.fx_argv = av;
	f.fx_envp = NULL;
	if (forkexec(&f) < 0)
	    res = 127;
	else res = f.fx_waitres;
    }

# else	/* Vanilla system */
    {
	int pid;
	if ((pid = vfork()) == 0) {	/* Fork, sharing memory for speed */
	    execlp(prog, s, NULL);	/* Invoke the program */
	    _exit(127);			/* Just exit child if invoke failed */
	}
	while (wait(&res) != pid);	/* Wait until child done */
    }
# endif

    if (proglen >= 0)		/* If allocated some mem, */
	free(prog);		/* free it up */
    return res;			/* Return result */
#endif /* !1 */
}

#endif /* T20+10X */
