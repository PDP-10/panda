#include <stdio.h>

main(argc, argv)
int argc;
char **argv;
{
    int i = 0;

    while (i < argc)
	printf("%2d: %s\n", i, argv[i++]);
}
