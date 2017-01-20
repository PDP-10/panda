/*
 *	PSIGNAL - document a signal
 *
 *	Copyright (C) 1987 by Ian Macky, SRI International
 */

#include <stdio.h>
#include <signal.h>

extern char *sys_siglist[];

void psignal(sig, prefix)
int sig;
char *prefix;
{
    if (prefix && *prefix)		/* if user gave us a prefix */
	fputs(prefix, stderr);		/* string, type it out. */
    fputs(": ", stderr);
    if (sig < 1 || sig > NSIG)		/* range-check sig */
	fprintf(stderr, "No signal # %d", sig);
    else fputs(sys_siglist[sig], stderr);
    putc('\n', stderr);
}
