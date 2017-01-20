/*
 *	test chdir()
 */

#include "stdio.h"
#include "errno.h"

main(argc, argv)
int argc;
char **argv;
{
    char *dir;
    int result;

    if (argc < 2) {
	printf("usage: %s directory\n", argv[0]);
	exit(0);
    }
    dir = argv[1];
    result = chdir(dir);
    printf("chdir(\"%s\") = %d\n", dir, result);
    if (!result)
	printf("succeeded, you should be connected to %s now.\n", dir);
    else
	perror("failed");
}
