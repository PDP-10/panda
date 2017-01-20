#include <stdio.h>
main(argc,argv)
char *argv[];
{	register int i;
	register char *cp;

	for(i = 0; i < argc; ++i)
		printf(" \"%s\"", argv[i]);

}
