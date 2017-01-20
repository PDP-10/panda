/* TFSEEK - Test FSEEK to some extent.
*/
#include <stdlib.h>	/* For rand() */
#include <errno.h>
#include <string.h>
#include <stdio.h>

int flagr, flagw, flaga, flagu, flagb;
int flag7, flag8, flag9, flagC;
long poseof;
int bsize, bmask;

main(argc,argv)
char *argv[];
{
    FILE *f;
    int i, c, len = BUFSIZ+1;
    char *argsws, *argfile = NULL, *cp;
    char *fname;

    if (--argc <= 0) {
	printf("Usage: tfseek [stdio-mode] {-len} {file}\n");
	return 0;
    }
    argsws = *++argv;
    if (--argc > 0) {
	if (**++argv == '-') {
	    len = atoi((*argv)+1);
	    if (--argc > 0)
		argfile = *++argv;
	} else argfile = *argv;
    }
    fname = argfile ? argfile : "tfseek.dat";


    /* Hack switches */
    for (cp = argsws; *cp; ++cp) {
	switch (*cp) {
	    case 'r': flagr++; break;
	    case 'w': flagw++; break;
	    case 'a': flaga++; break;
	    case '+': flagu++; break;
	    case 'b': flagb++; break;

	    case 'C': flagC++; break;
	    case '7': flag7++; break;
	    case '8': flag8++; break;
	    case '9': flag9++; break;
	}
    }

    printf("Using fopen(\"%s\", \"%s\")", fname, argsws);
    if (f = fopen(fname, argsws))
	printf(" OK\n");
    else {
	printf(" Failed! errno = %d \"%s\"\n", errno, strerror(errno));
	return 0;
    }
    if (flag8) bsize = 8;
    else if (flag9) bsize = 9;
    else bsize = 7;
    bmask = (1<<bsize)-1;

    /* If just writing, (or writing & no file given), initialize file */
    if (flagw && ((!flagr && !flagu) || (!argfile))) {
	srand(1);
	for (i = 0, c = rand(); i < len; ++i, ++c)
	    if (putc(c&bmask, f) == EOF) {
		printf("ERROR: putc failed at %d of %s\n", i, fname);
		return 1;
	    }
	printf("%d chars written into \"%s\", pos = %#lo\n",
			i, fname, poseof = ftell(f));
	rewind(f);
	printf("Rewound, pos = %#lo\n", ftell(f));
    }

    /* If reading, scan through */
    if (flagr && !flagw && !flagu && argfile) {
	for (i = 0; (c = getc(f)) != EOF; ++i);
	printf("%d chars read from \"%s\", pos = %#lo\n",
			i, fname, poseof = ftell(f));
	rewind(f);
	printf("Rewound, pos = %#lo\n", ftell(f));
	return 0;
    }

    /* If using generated binary file, hop around checking stuff */
    if (flagr && flagb && !argfile) {
	long pos;
	int cstart;
	int errors = 0;
	int tenth, tencnt;

	printf("Checking %d byte values in \"%s\"...\n", len, fname);
	srand(1);
	cstart = rand();	/* Get starting value */
	i = len;		/* # tests */
	tenth = i/10;
	tencnt = 0;
	for (i = len; --i >= 0; ) {
	    pos = rand() % len;
	    if (--tencnt <= 0) {
		printf("(Test %d: %#lo/", len-i, pos);
	    }
	    if (fseek(f, (long)pos, SEEK_SET)) {
		printf("ERROR: fseek(f, %#lo, SEEK_SET) failed\n", pos);
		if (++errors > 10)
		    return 1;
		continue;
	    }
	    if ((c = getc(f)) == EOF) {
		printf("ERROR: getc at %#lo got EOF\n", pos);
		if (++errors > 10)
		    return 1;
		continue;
	    }
	    if ((c &= bmask) != ((cstart + pos)&bmask)) {
		printf("ERROR: byte at %#lo is %o, shd be %o\n", pos,
				c, (cstart+pos)&bmask);
		if (++errors > 10)
		    return 1;
		continue;
	    }
	    if (tencnt <= 0) {		/* Finish off test report */
		printf("%o)...\n", c);
		tencnt = tenth;
	    }
	}
	if (errors == 0)
	    printf("\nDone, no errors!\n");
    }
    return 0;
#if 0
	if ((f = fopen ("SEEK.DAT", "wb"))==NULL)	/* Force binary */
		printf("fopen(wb) of SEEK.DAT failed.\n");

	printf("current pos (before writing anything) = %d\n", ftell(f));
	fputc (TESTPOS, f);
	printf("after writing a byte, pos = %d\n", ftell(f));
	for (c = 0; c < 256; c++)
		fputc (c, f);
	printf("after writing all 256+1, pos = %d\n", ftell(f));
	fclose (f);
	if ((f = fopen ("SEEK.DAT", "rb"))==NULL)
		printf("fopen(r) of SEEK.DAT failed\n");

	c = fgetc (f);			/* Get position to seek to */
	if (fseek (f, c, SEEK_CUR) == -1)
		printf("fseek to %d failed.\n", c);

/*	fseekx (f, c, 1); */
	printf ("value should be %d.  value is %d\n", TESTPOS, fgetc(f));
#endif
}

int fseekx (stream, offset, ptrname)
FILE   *stream;
long    offset;
int	ptrname;
{
    if (ptrname == 1) {
	while (offset--)
	    fgetc (stream);
	return 0;
    }
    else
	return fseek (stream, offset, ptrname);
}
