#include <sgtty.h>
#include <stdio.h>
struct sgttyb foo;
main()
{
	gtty(0, &foo);
	printf("Input speed = %d, output = %d\n",
		foo.sg_ispeed, foo.sg_ospeed);
}
