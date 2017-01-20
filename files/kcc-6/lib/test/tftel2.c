#include <stdio.h>

main()
{
	FILE *f;
	int c;
	long fsize1, fsize2, fsize3, ftell ();

	f = fopen ("SEEK.DAT", "w8");
	fputc ('\020', f);
	for (c = 1; c < 256; c++)
		fputc (c, f);
	printf ("at end of write ftell = %ld\n", ftell (f));
	fseek (f, 128L, 0);
	printf ("reposition to 128.  ftell = %ld\n", ftell (f));
	fseek (f, 0L, 0);
	printf ("reposition to 0.  ftell = %ld\n", ftell (f));
	fclose (f);
	f = fopen ("SEEK.DAT", "r");
	fseek (f, 0L, 2);
	fsize1 = f->siofdoff;
	fsize2 = ftell (f);
	fseek (f, 0L, 0);
	fsize3 = f->siofdoff;
	c = fgetc (f);
	printf("rewound, first byte = %d\nseeking to . + that\n", c);
	fseek (f, c, 1);
	printf ("value should be 17.  value is %d\n", fgetc (f));
	printf ("size should be 256.\n");
	printf ("f->siofdoff after fseek (f, 0L, 2) is %ld\n", fsize1);
	printf ("ftell (f) returns %ld\n", fsize2);
	printf ("f->siofdoff after fseek (f, 0L, 0) is %ld\n", fsize3);
}
