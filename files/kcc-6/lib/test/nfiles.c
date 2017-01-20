#include <stdio.h>

#define MAX	1000

main()
{
    FILE *f[MAX];
    char line[80];
    int i, j;

    for (i = 0; i < MAX; i++) {
	sprintf(line, "test-%03d.out", i);
	if (!(f[i] = fopen(line, "w"))) {
	    printf("\nfailed after %d files\n", i);
	    break;
	} else putchar('.');
    puts("i suggest you type @DEL TEST-0*.* now...");
    }
}
