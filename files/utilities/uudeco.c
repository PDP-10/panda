#ifndef lint
static char sccsid[] = "@(#)uudecode.c	5.3 (Berkeley) 4/10/85";
#endif

/*
 * uudecode [input]
 *
 * create the specified file, decoding as you go.
 * used with uuencode.
 */
#include <stdio.h>
#ifndef TOPS20
#include <pwd.h>
#include <sys/types.h>
#include <sys/stat.h>
#endif

/* single character decode */
#define DEC(c)	(((c) - ' ') & 077)

/* blank string - 60 SPACEs */
static char blanks[] = "                                                            ";

main(argc, argv)
char **argv;
{
	FILE *in, *out;
#ifndef TOPS20
	int mode;
	char dest[128];
#else
	char cmd[400];
#endif
	char buf[80];

#ifndef TOPS20
	/* optional input arg */
	if (argc > 1) {
		if ((in = fopen(argv[1], "r")) == NULL) {
			perror(argv[1]);
			exit(1);
		}
		argv++; argc--;
	} else
		in = stdin;

	if (argc != 1) {
		printf("Usage: uudecode [infile]\n");
		exit(2);
	}
#else
	if (argc == 3) {
		if ((in = fopen(argv[1], "r")) == NULL) {
			perror(argv[1]);
			exit(1);
		}
		if ((out = fopen("UUDECODE.OUT", "w8")) == NULL) {
			perror("UUDECODE.OUT");
			exit(1);
		}
	} else {
		printf("Usage: uudecode infile outfile\n");
		exit(2);
	}
#endif

	/* search for header line */
	for (;;) {
		if (fgets(buf, sizeof buf, in) == NULL) {
			fprintf(stderr, "No begin line\n");
			exit(3);
		}
		if (strncmp(buf, "begin ", 6) == 0)
			break;
	}
#ifndef TOPS20}i
	sscanf(buf, "begin %o %s", &mode, dest);

	/* handle ~user/file format */
	if (dest[0] == '~') {
		char *sl;
		struct passwd *getpwnam();
		char *index();
		struct passwd *user;
		char dnbuf[100];

		sl = index(dest, '/');
		if (sl == NULL) {
			fprintf(stderr, "Illegal ~user\n");
			exit(3);
		}
		*sl++ = 0;
		user = getpwnam(dest+1);
		if (user == NULL) {
			fprintf(stderr, "No such user as %s\n", dest);
			exit(4);
		}
		strcpy(dnbuf, user->pw_dir);
		strcat(dnbuf, "/");
		strcat(dnbuf, sl);
		strcpy(dest, dnbuf);
	}

	/* create output file */
	out = fopen(dest, "w");
	if (out == NULL) {
		perror(dest);
		exit(4);
	}
	chmod(dest, mode);
#endif

	decode(in, out);

	if (fgets(buf, sizeof buf, in) == NULL || strcmp(buf, "end\n")) {
		fprintf(stderr, "No end line\n");
		exit(5);
	}
#ifdef TOPS20
	fclose (in);
	fclose (out);
	sprintf (cmd, "ASCIFY UUDECODE.OUT/DWIM %s", argv[2]);
	system (cmd);
	if (access (argv[2], 04) != (-1)) {
	    unlink ("UUDECODE.OUT");
	} else {
	    rename ("UUDECODE.OUT", argv[2]);
	}
#endif
	exit(0);
}

/*
 * copy from in to out, decoding as you go along.
 */
decode(in, out)
FILE *in;
FILE *out;
{
	char buf[80];
	char *bp;
	int n, k;

	for (;;) {
		/* for each input line */
		if (fgets(buf, sizeof buf, in) == NULL) {
			printf("Short file\n");
			exit(10);
		}
		n = DEC(buf[0]);
		if (n <= 0)
			break;

		k = ((n/3)*4)+1;	/* expected strlen(buf) */
		if ((strlen(buf)-1) < k) { /* -1 for trailing LF */
		    buf[strlen(buf)-1] = '\0'; /* stomp LF */
		    strncat(buf, blanks, (k-strlen(buf))); /* pad */
		}

		bp = &buf[1];
		while (n > 0) {
			outdec(bp, out, n);
			bp += 4;
			n -= 3;
		}
	}
}

/*
 * output a group of 3 bytes (4 input characters).
 * the input chars are pointed to by p, they are to
 * be output to file f.  n is used to tell us not to
 * output all of them at the end of the file.
 */
outdec(p, f, n)
char *p;
FILE *f;
{
	int c1, c2, c3;

	c1 = DEC(*p) << 2 | DEC(p[1]) >> 4;
	c2 = DEC(p[1]) << 4 | DEC(p[2]) >> 2;
	c3 = DEC(p[2]) << 6 | DEC(p[3]);
#ifndef TOPS20
	if (n >= 1)
		putc(c1, f);
	if (n >= 2)
		putc(c2, f);
	if (n >= 3)
		putc(c3, f);
#else
	if (n >= 1)
		fputc(c1, f);
	if (n >= 2)
		fputc(c2, f);
	if (n >= 3)
		fputc(c3, f);
#endif
}


/* fr: like read but stdio */
int
fr(fd, buf, cnt)
FILE *fd;
char *buf;
int cnt;
{
	int c, i;

	for (i=0; i<cnt; i++) {
#ifndef TOPS20
		c = getc(fd);
#else
		c = fgetc(fd);
#endif
		if (c == EOF)
			return(i);
		buf[i] = c;
	}
	return (cnt);
}

#ifndef TOPS20
/*
 * Return the ptr in sp at which the character c appears;
 * NULL if not found
 */

#define	NULL	0

char *
index(sp, c)
register char *sp, c;
{
	do {
		if (*sp == c)
			return(sp);
	} while (*sp++);
	return(NULL);
}
#endif
