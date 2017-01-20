/* TSTAT - test stat()
*/
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>

main(argc, argv)
int argc;
char *argv[];
{
    struct stat foo;
    int i;

    if (argc < 2) {
	printf("usage is: tstat file1 file2 ...\n");
	exit(0);
    }

    for (i = 1; i < argc; ++i)
    if (stat(argv[i], &foo) < 0) {
	printf("Couldn't stat \"%s\"\n", argv[i]);
    } else {
	printf("file: %s\n", argv[i]);
	printf("device (st_dev): %o\n", foo.st_dev);
	printf("disk address (st_ino): %o\n", foo.st_ino);
	printf("mode/protection (st_mode): %o\n", foo.st_mode);
	printf("number of links (st_nlink): %o\n", foo.st_nlink);
	printf("user id of owner (st_uid): %o\n", foo.st_uid);
	printf("group id of owner (st_gid): %o\n", foo.st_gid);
	printf("whatever this is (st_rdev): %o\n", foo.st_rdev);
	printf("size of file (st_size): %o\n", foo.st_size);
	printf("last access file (st_atime): %o = %s", foo.st_atime,
		ctime(&foo.st_atime));
	printf("last modify time (st_mtime): %o = %s", foo.st_mtime,
		ctime(&foo.st_mtime));
	printf("last status change time (st_ctime): %o = %s", foo.st_ctime,
		ctime(&foo.st_ctime));
    }
}
