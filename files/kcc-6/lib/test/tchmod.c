/*
 *	tchmod - test chmod()
 */

#include "stdio.h"
#include "errno.h"

main(argc, argv)
int argc;
char **argv;
{
    char *file;
    int result, mode;

    if (argc < 3) {
	printf("usage: %s file mode\n", argv[0]);
	exit(0);
    }
    file = argv[1];
    mode = atoi(argv[2]);
    result = chmod(file, mode);
    printf("chmod(\"%s\", 0%o) = %d\n", file, mode, result);
    if (!result) puts("succeeded");
    else perror("failed");
}
