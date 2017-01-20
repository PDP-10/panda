#include <stdio.h>
#include <math.h>

#define MAX_BLOCKS	10000

main(argc, argv)
int argc;
char *argv[];
{
    extern char *malloc(), *realloc();
    extern free(), show_free_list();

    char *blocks[MAX_BLOCKS], s, *bp;
    int lower, upper, iterations, address;
    int nblocks, seed;
    int i, which, probability, size;
    int debug;

    lower = upper = iterations = seed = debug = address = 0;

    if (argc < 2) {
	fprintf(stderr, "Usage: %s -i -l -u [-a] [-s] [-d]\ni = # of iterations		l = lower bound of block size\nu = upper bound of block size	a = brk() starting address\ns = random generator seed	d = debugging output\n", argv[0]);
	exit(0);
    }

    while (--argc > 0 && (*++argv)[0] == '-')
	switch (s = (*argv)[1]) {
	    case 'd':	debug = 1; break;
	    case 'i':	iterations = atoi((*argv)+2); break;
	    case 'l':	lower = atoi((*argv)+2); break;
	    case 'u':	upper = atoi((*argv)+2); break;
	    case 's':	seed = atoi((*argv)+2); break;
	    case 'a':	address = atoi((*argv)+2); break;
	    default:
	        fprintf(stderr, "tm: illegal option %c\n", s);
		exit(0);
	    }

    if (iterations < 1) {
	fprintf(stderr, "tm: unreasonable -i (iterations) value\n");
	exit(0);
    } else if (lower < 1) {
	fprintf(stderr, "tm: unreasonable -l (lower bound on size) value\n");
	exit(0);
    } else if (upper < 1) {
	fprintf(stderr, "tm: unreasonable -u (upper bound on size) value\n");
	exit(0);
    } else if (lower > upper) {
	fprintf(stderr, "tm: lower bound greater than upper bound\n");
	exit(0);
    }

    if (address) brk(address);	/* set the starting memory allocation point */

    printf("Iterations:\t%d\nSize bounds - Lower: %d, Upper: %d\n",
	   iterations, lower, upper);
    printf("Seed value = %d, Starting address ", seed);
    if (address) printf("= %o\n", address);
    else printf("is unforced.\n");

    nblocks = 0;
    probability = 8;
    srand(seed);
    if (debug) printf("Phase I:\n");
    for (i = 1; i < iterations; i++) {
	if (i == (iterations / 3)) {
	    probability = 5;
	    if (debug) printf("Phase II:\n");
	} else if (i == (2 * iterations / 3)) {
	    probability = 2;
	    if (debug) printf("Phase III:\n");
	}
	if ((rand() % 10) >= probability && nblocks > 0) {
	    which = rand() % nblocks;
	    if (debug) printf("free(%o)", (int *) blocks[which]);
	    free(blocks[which]);
	    blocks[which] = blocks[--nblocks];
	    if (debug) printf(", nblocks = %d.\n", nblocks);
	    blocks[nblocks] = 0;
	    if (debug) _free_list();
	} else {
	    if (nblocks >= MAX_BLOCKS) {
		fprintf(stderr, "tm: ran out of block-pointer space\n");
		exit(0);
	    }
	    size = (rand() % upper);
	    if (size < lower)
		size = lower;
	    bp = malloc(size);		/* get a block */
	    if (bp == NULL) {
		fprintf(stderr, "tm: malloc() failed to allocate a block\n");
		exit(0);
	    }
	    blocks[nblocks++] = bp;
	    if (debug) {
		printf("malloc(%d.) = %o, nblocks = %d.\n",
			size, (int *) bp, nblocks);
		_free_list();
	    }
	}
    }
    if (debug) printf("Phase IV, %d. blocks remain:\n", nblocks);
    while (nblocks--) {
	if (debug) printf("free(%o)\n", (int *) blocks[nblocks]);
	free(blocks[nblocks]);
	if (debug) _free_list();
    }
    printf("Done.\n");
    _free_list();
}
