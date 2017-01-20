/*
 *	test ioctl TIOCSTI function
 */

#include "stdio.h"
#include "sys/ioctl.h"

char c1[] = "*";

main()
{
    puts("testing the TIOCSTI ioctl on stdin.  a '*' then a newline then\na ^C will be STI'd.   Here goes...");
    ioctl(fileno(stdin), TIOCSTI, c1);
    *c1 = '\n';
    ioctl(fileno(stdin), TIOCSTI, c1);
    *c1 = 3;
    ioctl(fileno(stdin), TIOCSTI, c1);
    printf("getchar() = '\\%03o'\n", getchar());
    printf("getchar() = '\\%03o'\n", getchar());
    printf("getchar() = '\\%03o'\n", getchar());
}
