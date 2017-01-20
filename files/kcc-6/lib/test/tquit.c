/* Program to test SIGQUIT and SIGINT interrupts */

#include <signal.h>
#include <stdio.h>
#include <sys/ioctl.h>

int quitcnt = 0;
void quithan(), inthan();
main()
{
	struct tchars tc;
	if (ioctl(0, TIOCGETC, &tc) < 0)
		printf("ioctl failed: tiocgetc\n");
	tc.t_intrc = 'N'&037;
	tc.t_quitc = 'X'&037;
	if (ioctl(0, TIOCSETC, &tc) < 0)
		printf("ioctl failed: tiocsetc\n");
	signal(SIGINT, inthan);
	signal(SIGQUIT, quithan);
	printf("OK, type something now... 3 quits end loop\n");
	while(quitcnt < 3)
	  {	char line[100];
		if (fgets(line, 100, stdin) == NULL)
		  {	printf("fgets returned null, stopping.\n");
			break;
		  }
		printf("Read: \"%s\", quitcnt = %d\n", line, quitcnt);
	  }
	printf("All done!\n");
}

void inthan()
{
	writez("<INT>");
}
void quithan()
{
	writez("<QUIT>");
	quitcnt++;
}
writez(str)
char *str;
{
	write(1, str, strlen(str));
}
