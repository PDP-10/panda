#include "stdio.h"

int a[] = { -4, -1, 0, 2, 3, 4, 10, 15, 100 };


#define SIZE_OF_A	(sizeof(a) / sizeof(int))

main()
{
    extern char *bsearch();
    char *p, line[BUFSIZ];
    int i, n, compar();

    for (i = 0; i < SIZE_OF_A; i++)
	printf("a[%d] = %d\n", i, a[i]);
    for (;;) {
	fputs("n: ", stdout);
	if (!gets(line)) break;
	n = atoi(line);
	p = bsearch((char *) &n, (char *) a, SIZE_OF_A, sizeof(int), compar);
	if (!p) puts("not found");
	else printf("found @ index %d\n", ((int *) p) - a);
    }
}

int compar(s1, s2)
char *s1, *s2;
{
    int i1, i2;

    i1 = *((int *) s1);
    i2 = *((int *) s2);
    if (i1 == i2) return 0;
    else if (i1 < i2) return -1;
    else return 1;
}
