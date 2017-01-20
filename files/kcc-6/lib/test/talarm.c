#include <signal.h>
int state = 0;
int inthan();
main()
{
	signal(SIGALRM, inthan);
	alarm(1);
	state = 1;
	signal(SIGALRM, SIG_DFL);
	state = 2;
	alarm(0);
	state = 3;
	sleep(2);
	printf("Finished ok\n");
}
inthan() {}
