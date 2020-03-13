#include <signal.h>
main()
{
    void foo();

    signal(SIGTSTP, SIG_DFL);
    signal(SIGCONT, foo);
    printf("Suspending...\n");
    kill(getpid(), SIGTSTP);
    printf("Done.\n");
}

void
foo()
{
	printf("Continued!\n");
}
