/* Print the first line of selected files.  Used by Logo pots command. */

#include <stdio.h>

main(argc,argv)
int argc;
char **argv;
{
	FILE *fp;
	char line[100];

	while (--argc > 0) {
		if ((fp = fopen(argv[1],"r")) != NULL) {
			fgets(line,100,fp);
			printf("%s",line);
			fclose(fp);
		}
	argv++;
	}
	exit(0);
}
