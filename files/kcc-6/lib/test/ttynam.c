#include <stdio.h>

extern char *ttyname();
extern int isatty();

main()
{
    printf("isatty(0) => %d\n", isatty(0));
    printf("ttyname(0) => \"%s\"\n", ttyname(0));
}
