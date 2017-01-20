/*
 *	test ioctl's FIONREAD function
 */

#include "stdio.h"
#include "ioctl.h"

main()
{
    int i;
    long count;

    puts("countdown, start typing!");
    puts("count		# unread chars");
    puts("-----		--------------");
    for (i = 10; i >= 0; i--) {
	ioctl(fileno(stdin), FIONREAD, &count);
	printf("%4d               %5d\n", i, count);
	sleep(1);
    }
}
