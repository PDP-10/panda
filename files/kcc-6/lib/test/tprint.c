/* Test program for printf
 *
 * Usage: prftst <flags>
 *	<flags> - none = all tables output
 *		- 1 = 11-1
 *		- 2 = 11-2
 *		- p = precision
 *		- f = Floating pt
 */
#include <stdio.h>

main(argc,argv)
int argc;
char *argv[];
{	register int i;
	register char *cp;

	if(argc < 2)
		cp = "12pf";	/* All tests */
	else cp = argv[1];

	for(; *cp; ++cp)
	  switch(*cp)
	  {	case '1':
			printf("Now testing CARM table 11-1...\n");
			dotab1();
			break;
		case '2':
			printf("\n\nNow testing CARM table 11-2...\n");
			dotab2();
			break;

		case 'p':
			printf("\n\nNow testing precision...\n");
			dotab0();
			break;

		case 'f':
			printf("\n\nNow testing various floating point output...\n");
			dofp();
			break;
		case 't':
			printf("\nTemp tests:\n");
			dotmp();
			break;
		default:
			printf("\nUnknown test: %c\n", *cp);
			break;

	  }
/*	prf_bind('s', __pfs);
	for(i = 1; i < argc; ++i)
		printf("%s ", argv[i]);
*/
}

dotmp()
{
	printf("32.0 = %4.2f\n", 32.0);
	printf("32.00etc = %4.20f\n", 32.0);
}

char *makfmt(), *makflg();

char *tab1[] = { "5d", "5o", "5x", "7.2f", "10.2e", "10.4g", 0 };
char *tab2[] = { "5s", "5c", "5%", "7.2f", "10.2e", "10.4g", 0 };

#define NFLGS 32	/* # flag combos, starting from 0 */
#define FLGZ 01
#define FLGLB 02
#define FLGSP 04
#define FLGPOS 010
#define FLGNEG 020

dotab1()
{	register int i;
	register char *cp;

	printf("Value     45    45    45  12.678     12.678     12.678\n");
	printf("Operation 5d    5o    5x    7.2f      10.2e      10.4g\n");
	printf("Format \"%s\"\n", makfmt("%","",tab1,"|"));
	printf("Flags\n");

	for(i = 0; i < NFLGS; ++i)
	  {	cp = makflg(i);
		printf(makfmt(cp, "", tab1, "|"), cp,
			45, 45, 45, 12.678, 12.678, 12.678);
		printf("\n");

	  }
}

dotab2()
{	register int i;
	register char *cp;

	printf("Value  \"zap\"   '*'  none -3.4567    -3.4567    -3.4567\n");
	printf("Operation 5s    5c    5%%    7.2f      10.2e      10.4g\n");
	printf("Format \"%s\"\n", makfmt("%","",tab2, "|"));
	printf("Flags\n");

	for(i = 0; i < NFLGS; ++i)
	  {	cp = makflg(i);
		printf(makfmt(cp, "", tab2, "|"), cp,
			"zap", '*', /*none,*/ -3.4567, -3.4567, -3.4567);
		printf("\n");

	  }
}

static char flgstr[10];
char *
makflg(i)
int i;
{	register char *cp;

	cp = flgstr;
	*cp++ = '%';		/* Always start with this */
	if(i & FLGNEG) *cp++ = '-';
	if(i & FLGPOS) *cp++ = '+';
	if(i & FLGSP ) *cp++ = ' ';
	if(i & FLGLB ) *cp++ = '#';
	if(i & FLGZ  ) *cp++ = '0';
	*cp++ = '\0';
	return(flgstr);
}

/* MAKFMT - make a format string.
 *	flags - string of flags to use preceding each operation
 *	optab - array of char ptrs to operations we want (0 terminates)
 */
static char fmtstr[1000];	/* Big temp buffer */
char *
makfmt(flags, fld, optab, sep)
char *flags, *fld, **optab, *sep;
{	register char *cp;
	char *strcat();

	cp = fmtstr;
	strcpy(fmtstr, "%6s|");		/* Will always want flag string */
	while(*optab)
		strcat(strcat(strcat(strcat(fmtstr, flags),fld),*optab++),sep);
	return(fmtstr);
}

/* Check out behavior of conversion operations when given a zero */
/* Checks all numerical convs at precision of unspec, 0, 1, 2 */
/* d, o, u, x, X, f, e, E, g, G */

char *ftab0[] = { "4", "4.", "4.0", "4.1", "4.2", 0};
char *ctab0[] = { "d", "o", "u", "x", "X", "f", "e", "E", "g", "G", 0 };
dotab0()
{	register int i;
	register char *cp;
	register char **ftp;

	printf("Value      0    0    0    0    0    0    0    0    0    0\n");
	printf("Operation  d    o    u    x    X    f    e    E    g    G\n");
	printf("Format \"%s\"\n", makfmt("%","4",ctab0,"|"));
	printf("Flags\n");

	for(ftp = ftab0; *ftp; ++ftp)
	  {	printf("Field/Precision: %s\n", *ftp);
		for(i = 0; i < NFLGS; ++i)
		  {	cp = makflg(i);
			printf(makfmt(cp, *ftp, ctab0, "|"), cp,
				0,0,0,0,0, 0.0, 0.0, 0.0, 0.0, 0.0);
			printf("\n");

		  }
	  }
}

/* Check out various f.p. numbers */

dofp()
{
	powloop(2.0, 72);
	powloop(10.0, 50);
	powloop(3.0, 50);
}

powloop(base, lim)
double base;
int lim;
{
	double sum1, sum2, sum3, sum11, sum12;
	int i;

	sum1 = sum2 = 1.0;
	printf("Powers of %.f:\n", base);
	for(i = 0; i < lim; ++i)
	  {	
		sum3 = sum1 + sum2;
		if(sum1 != sum3)
			printf("%3d:|%24.20g|%24.20g|%24.20g|\n",
				i, sum1, sum2, sum3);
		else	printf("%3d:|%30.20g|%30.20g|\n",
				i, sum1, sum2);

		sum1 *= base;
		sum2 /= base;
	  }
}
