/* TSTSYS - tests the system() call.
*/
#include <stdio.h>
main(argc,argv)
int argc; char **argv;
{
	int ret;
	if (argc < 2)
		printf("Usage: tstsys <argstring>\n");
	else if (ret = system(argv[1]))
		printf("Failed, returned %d\n", ret);
}
