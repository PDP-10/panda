/*
 *	test chown()
 */

#include "stdio.h"
#include "errno.h"

main(argc, argv)
int argc;
char **argv;
{
    int result, owner, group;
    char *file;

    if (argc < 4) {
	printf("usage: %s file owner group\n", argv[0]);
	exit(0);
    }
    file = argv[1];
    owner = atoi(argv[2]);
    group = atoi(argv[3]);
    result = chown(file, owner, group);
    printf("chown(\"%s\", 0%o, 0%o) = %d\n", file, owner, group, result);
    if (!result) puts("successful!");
    else perror("failed");
}
