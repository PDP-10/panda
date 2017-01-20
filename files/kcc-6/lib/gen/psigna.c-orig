/*
 *	PSIGNAL - document a signal
 *
 *	Copyright (C) 1987 by Ian Macky, SRI International
 */

#include <stdio.h>
#include <signal.h>

static char *sigdoc[] = {
    NULL,
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
    NULL,						/* SIG29 */
    "User-defined signal 1",				/* SIGUSR1 */
    "User-defined signal 2"				/* SIGUSR2 */
};

#define _N_SIGDOC	(int)(sizeof(sigdoc) / sizeof(char *))

void psignal(sig, prefix)
int sig;
char *prefix;
{
    if (prefix && *prefix)		/* if user gave us a prefix */
	fputs(prefix, stderr);		/* string, type it out. */
    fputs(": ", stderr);
    if (sig < 1 || sig > _N_SIGDOC)	/* range-check sig */
	fprintf(stderr, "No signal # %d", sig);
    else if (!sigdoc[sig])
	fprintf(stderr, "No documentation for signal # %d", sig);
    else fputs(sigdoc[sig], stderr);
    putc('\n', stderr);
}
