/*
**	EXIT	- Terminate process: exit(), _exit()
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.2, 24-Aug-1987
**	(c) Copyright Ken Harrenstien, SRI International 1987
*/

#include <c-env.h>
#include <stdlib.h>		/* For atexit() stuff */
#include <unistd.h>
#include <sys/usydat.h>

extern void __exit(
#ifdef __STDC__
int sts
#endif
);		/* From CRT module, lowest-level exit */
#if SYS_T20
#include <jsys.h>
#include <sys/urtint.h>
#endif

/* EXIT - Top-level exit.
**	This is not actually a USYS call; it is more of a general
** library function.  Nevertheless it is closely associated with _exit() which
** IS a USYS call, and is documented in the UPM as exit(2), and therefore
** is coded here.
*/
void
exit(n)
int n;
{
    int i;
    void _exit();

    for (i = _n_exit_func; i > 0;)	/* If there are exit func registered */
	(*_exit_func[--i])();		/* call them reverse order, no args */
    _exit(n);				/* Then do URT simulation exit */
}

/* _EXIT - syscall simulation exit
**	This is the "middle-level" exit (in between exit() and __exit()).
** It cleans up all USYS stuff, including open FDs and child processes.
*/
void
_exit(n)
int n;
{
    int i;

    USYS_BEG();				/* No interrupts from here on. */
    for (i = 0; i < OPEN_MAX; i++)	/* For all FDs */
	if (USYS_VAR_REF(uffd[i]))	/* close FD if it's open */
	    close(i);
#if SYS_T20
    if (USYS_VAR_REF(pippid))
      _wfork(USYS_VAR_REF(pippid));	/* Wait for piped fork to exit */
#endif

    if (USYS_VAR_REF(nfork))		/* If we created any forks, */
      sleep(1);				/* wait a bit to let them exit */

#if SYS_T20
    {
      int acs[5];

      acs[1] = _FHSLF;
      if (jsys(GPJFN, acs) && ((acs[2] & RH) != _CTTRM)) {
	acs[1] = monsym("CZ%ABT") | _FHSLF;
	jsys(CLZFF, acs);		/* Flush all but primary JFNs */
	acs[1] = _FHSLF;
	acs[2] = (_CTTRM << 18) | _CTTRM; /* Change primary JFNs to terminal */
	if (jsys(SPJFN, acs)) {
	  acs[1] = _FHSLF;
	  jsys(CLZFF, acs);		/* Normal close on remaining JFNs */
	}
      }
    }
#endif

    __exit(n);				/* go do lowest level exit */
}
