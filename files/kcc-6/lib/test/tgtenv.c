/* TGTENV - Test GETENV.
*/

#include <stdlib.h>
#include <stdio.h>

main(argc, argv)
int argc;
char **argv;
{
    char *cp;

    if (argc < 2) {
	printf("Usage: tgtenv <env-var> <env-var> ...\n");
	exit(1);
    }
    for (; --argc > 0; ) {
	printf("Environment var \"%s\" => ", *++argv);
	if (cp = getenv(*argv))
	    printf("\"%s\"\n", cp);
	else printf("Not found\n");
    }
}
