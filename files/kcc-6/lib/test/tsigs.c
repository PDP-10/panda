#include <stdio.h>
#include <signal.h>
#include <setjmp.h>

jmp_buf env, loop;
int ntimes = -1;
int nloops = 0;
int sstk[200];

int wakeup();
char inbuf[1000];
int nchars;

main()
{
	int i;
	setbuf(stdout, NULL);

	printf("Testing simple setjmp:\n");
	i = setjmp(env);
	if (i == 0) {
		printf("\tsetjmp returned 0, env set up as:\n");
		showsc((struct sigcontext *)env, stdout);
		printf("\tNow doing longjmp.\n");
		longjmp(env,-1);
	} else
		printf("\tsetjmp returned %d, done with test.\n", i);

	if (setjmp(loop)) {
		struct sigstack ss;
		printf("Now doing things with a signal stack!\n");
		ss.ss_sp = &sstk[0];
		ss.ss_onstack = 0;
		sigstack(&ss, (struct sigstack *)0);
	}

	printf("Testing POV: ");
	signal(SIGSEGV, wakeup);
	asm("	movei 1,100\n	pop 1,2\n");

	printf("Testing alarm: ");
	signal(SIGALRM, wakeup);
	alarm(4);
	printf("Going...");
	pause();
	printf(" Returned from pause\n");

	printf("Testing interrupted SIN%%: ");
	signal(SIGALRM, wakeup);
	printf("you have 5 seconds to type stuff.\n");
	printf("  After the interrupt, type more stuff then ^Z.\n");
	alarm(5);
#asm
	movei 1,100	/* .priin */
	move 2,[441100,,inbuf]
	movei 3,1000	/* 512. chars max */
	movei 4,32	/* ^Z */
	jsys 52		/* SIN% */
	subi 3,1000
	movnm 3,nchars
#endasm
	printf(" Done with SIN%%.  Input received: %d chars\n\t\"", nchars);
	if (nchars > 0)
		fwrite(inbuf, 1, nchars, stdout);
	printf("\"\n");

	printf("Testing usermode illeg instr: ");
	signal(SIGILL, wakeup);
	asm("\t 0\n");

	ntimes = 3;		/* # times to call longjmp */
	i = setjmp(env);
	printf("Setjmp returned %d\n", i);
	if (i < 0) {
		if (nloops++ == 0) longjmp(loop, 1);	/* Restart with sigstk */

		printf("All done...\n");
		exit(0);
	}
	printf("Testing JSYSmode illeg instr: ");
	asm("\tsetz 1,\n\tjsys 60\n");	/* Get illeg instr on JSYS */
}


/* Routine called to handle signal.
** Note that we use STDERR instead of STDOUT in order to avoid
** messing things up if we interrupt out of STDIO routines.
*/
#define PC_USR (1<<(35-5))	/* Bit 5 of PC flags word */
int
wakeup(sig, chn, scp)
int sig, chn;
struct sigcontext *scp;
{
	fprintf(stderr, "Signal seen!\n  Sig %d, chn %d, sigcon = %o\n", sig, chn, scp);
	showsc(scp, stderr);
	if (ntimes >= 0) {
		longjmp(env, --ntimes);
	}
}

showsc(scp, fp)
struct sigcontext *scp;
FILE *fp;
{
	int i;

	fprintf(fp, "\tSignal context:\n\
\tsc_pc:     %o\n\
\tsc_pcflgs: %o %s\n", scp->sc_pc, scp->sc_pcflgs,
		scp->sc_pcflgs&PC_USR ? "(User)" : "(JSYS)" );
	fprintf(fp, "\
\tsc_osinf:  %o (channel #)\n\
\tsc_sig:    %o\n", scp->sc_osinf, scp->sc_sig);

	fprintf(fp, "\
\tsc_prev:   %o\n\
\tsc_stkflg: %o\n\
\tsc_mask:   %o\n", scp->sc_prev, scp->sc_stkflg, scp->sc_mask);
	for(i=0;i < 010; ++i)
		fprintf(fp, "\tac%o: %12o   ac%o: %12o\n", i, scp->sc_acs[i],
			i+010, scp->sc_acs[i+010]);

}