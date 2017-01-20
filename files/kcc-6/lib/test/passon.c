/* Simple program to just feed stdin to stdout until EOF. */
/* Echo of args added to debug redirection problems. */
#include <stdio.h>
main(argc,argv)
int argc;
char **argv;
{
    register int c;

    if (argc) {
	printf("Args: %s", *argv);
	while (--argc > 0)
	    printf(" %s", *++argv);
	putchar('\n');
    }

    while((c = getchar()) != EOF)
	putchar(c);
}
