#include <stdio.h>

main()
{
	FILE *f;
	int c;
	long size, ftell ();

	f = fopen ("SEEK.DAT", "w8");
	fputc ('\020', f);
	for (c = 1; c < 256; c++)
		fputc (c, f);
	fclose (f);
	f = fopen ("SEEK.DAT", "r");
	fseek (f, 0L, 2);
	size = ftell (f);
	fseek (f, 0L, 0);
	printf("after rewinding, ftell() = %d\n", ftell(f));
	fflush(f);
	printf("after fflush()ing, ftell() = %d\n", ftell(f));
	c = fgetc (f);
	printf("after reading a char, ftell() = %d\n", ftell(f));
	fflush(f);
	printf("after fflush()ing, ftell() = %d\n", ftell(f));
	fseek (f, c, 1);
	printf ("value should be 17.  value is %d\n", fgetc (f));
	printf ("size should be 256.  size is %ld\n", size);
}
