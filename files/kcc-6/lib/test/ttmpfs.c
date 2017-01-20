#include <stdio.h>

main()
{
    char *fstr, tmpbuf[L_tmpnam];
    int i;

    for (i = 0; i < 10; ++i) {
	printf("Result of tmpnam(0): \"%s\"\n", tmpnam(NULL));
    }
    for (i = 0; i < 10; ++i) {
	fstr = strcpy(tmpbuf, "name.XXXXXX");
	printf("Result of mktemp(%s): ", fstr);
	printf("\"%s\"\n", mktemp(fstr));
    }

    printf("Opening 10 tmpfiles...\n");
    for (i = 0; i < 10; ++i) {
	printf("Result of tmpfile(): %o\n", tmpfile());
    }
}

