/* TFREVR - Exercise STDIO routines by reversing a file in place.
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
    char *memfile;
    int memsize, memused;
    int flen;
    long beg, end;
    int endc, errors;

    if (--argc <= 0) {
	printf("Usage: tfrevr stdio-mode file\n");
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

    if (!flagr || !flagu) {
	printf("Must specify at least \"r+b\" as mode\n");
	return 1;
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

    /* First initialize by gobbling entire file into memory. */
    for (memsize = memused = 0, memfile = NULL;
		(c = getc(f)) != EOF; ++memused ) {
	if (memused >= memsize) {
	    memfile = realloc(memfile, memsize += BUFSIZ);
	    if (!memfile) {
		printf("Out of memory to hold file! (%d bytes)\n", memused);
		return 1;
	    }
	}
	memfile[memused] = c;
    }
    flen = memused;
    printf("Gobbled file, %d bytes read\n", flen);

    /* OK, now set about munching file!  We check each byte read vs the
    ** copy in memory.
    */
    errors = 0;
    for (beg = 0, end = flen-1; beg < end; ++beg, --end) {
	if (fseek(f, beg, SEEK_SET)) {
	    printf("ERROR: fseek(f, %#lo, SEEK_SET) failed\n", beg);
	    if (++errors > 10) return 1;
	}
	if ((c = getc(f)) == EOF) {
	    printf("ERROR: getc at %#lo got EOF\n", beg);
	    if (++errors > 10) return 1;
	}
	if (c != memfile[beg]) {
	    printf("ERROR: At %#lo, file %o != mem %o\n",
			beg, c, memfile[beg]);
	    if (++errors > 10) return 1;
	}
	if (fseek(f, end, SEEK_SET)) {
	    printf("ERROR: fseek(f, %#lo, SEEK_SET) failed\n", beg);
	    if (++errors > 10) return 1;
	}
	if ((endc = getc(f)) == EOF) {
	    printf("ERROR: getc at %#lo got EOF\n", end);
	    if (++errors > 10) return 1;
	}
	if (endc != memfile[end]) {
	    printf("ERROR: At %#lo, file %o != mem %o\n",
			end, endc, memfile[end]);
	    if (++errors > 10) return 1;
	}
	if (fseek(f, end, SEEK_SET)) {
	    printf("ERROR: fseek(f, %#lo, SEEK_SET) failed\n", end);
	    if (++errors > 10) return 1;
	}
	if (putc(c,f) == EOF) {
	    printf("ERROR: putc at %#lo got EOF\n", end);
	    if (++errors > 10) return 1;
	}
	memfile[end] = c;
	if (fseek(f, beg, SEEK_SET)) {
	    printf("ERROR: fseek(f, %#lo, SEEK_SET) failed\n", beg);
	    if (++errors > 10) return 1;
	}
	if (putc(endc, f) == EOF) {
	    printf("ERROR: putc at %#lo got EOF\n", beg);
	    if (++errors > 10) return 1;
	}
	memfile[beg] = endc;
    }

    /* Whew, now make one last pass, comparing entire file to memory. */
    printf("Reversed \"%s\" !!  Now rechecking...\n", fname);
    rewind(f);
    for (beg = 0; beg < flen; ++beg) {
	if (memfile[beg] != (c = getc(f))) {
	    printf("ERROR: File char %o doesn't match mem %o at %#lo\n",
			c, memfile[beg], beg);
	    if (++errors > 10) return 1;
	}
    }
    if (fclose(f)) {
	printf("ERROR: fclose failed\n");
    }
    printf("Done!\n");

    return 0;
}
