#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
struct stat fbuf;
time_t timep[2];

main(argc, argv)
int argc;
char **argv;
{
	FILE *infile;

	if ((infile = fopen(argv[1], "r")) == NULL) {
		perror (argv[1]);
		exit(0);
	}
	fstat(fileno(infile), &fbuf);
	fclose(infile);
	timep[0] = fbuf.st_atime;
	timep[1] = fbuf.st_mtime;
	utime(argv[1], timep);
}
