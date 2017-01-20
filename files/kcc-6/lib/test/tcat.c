/* Simple CAT-style test program for I/O
** Any arg causes TCAT to prefix each line with argv[0] and PID.
*/

#include <stdio.h>

main(argc, argv)
int argc;
char **argv;
{
	int c;
	int pid = getpid();
	char *name = NULL;
	int showpid = 0, bol = 1;

	if (argc > 1) name = argv[0], ++showpid;

	while ((c = getchar()) != EOF) {
		if (c == 0)
			fprintf(stderr,"%o: Null byte seen on input!\n", pid);
		if (showpid) {
			if (bol) printf("%s-%o: ", name, pid), bol = 0;
			if (c == '\n') bol = 1;
		}
		putchar(c);
	}
	if (ferror(stdin)) {
		perror("Input error on stdin!  errno = ");
	}
}
