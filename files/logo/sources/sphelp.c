/*
 * splithelp.c -- turn nroff output of logoman into help files.
 *
 * For this to work, there must be no em dashes in the logoman source
 * except on lines which name primitives.  Also, the file which is
 * nroffed isn't the actual logoman, but a version which has been edited
 * by the makehelp shell script (which also runs this program) to change
 * what's where.  The algorithm is that a primitive description starts
 * with a line with a dash (represented here as a tilde) and continues
 * until a line with a nonspace, nonempty first character.
 */

#include <stdio.h>

int memb(ch,str)
register char ch;
register char *str;
{
	register char ch1;

	while (ch1 = *str++)
		if (ch == ch1)
			return(1);
	return(0);
}

main(argc,argv)
char **argv;
{
	FILE *ip, *op;
	int writing = 0;	/* nonzero when writing a file */
	int empty = 0;		/* nonzero after an empty line */
	register char *cp;
	char line[100];
	char primitive[30];

	if ((ip = fopen(argv[1],"r")) == NULL) {
		printf("Splithelp: Can't read input.\n");
		exit(1);
	}

	while (fgets(line,100,ip)) {
		if (memb('~',line)) {	/* start new file */
			empty = 0;
			if (writing)
				fclose(op);
			sscanf(line,"%s",primitive);
			if (strlen(primitive) > 9) {
				for (cp = line; *cp && *cp!=':'; cp++) ;
				sscanf(cp+2,"%s",primitive);
			}
			if ((op = fopen(primitive,"w")) == NULL) {
				printf("Splithelp: Can't write output.\n");
				exit(1);
			}
			for (cp = line; *cp != '~'; cp++) ;
			*cp++ = '-';
			*cp = '-';
			fprintf(op,"%s",line);
			writing++;
		} else if (line[0] == '\n') {
			empty++;
		} else if (writing && line[0]==' ') {
			if (empty) fprintf(op,"\n");
			empty = 0;
			fprintf(op,"%s",line);
		} else if (writing) {
			fclose(op);
			writing = 0;
		}
	}
	if (writing) fclose(op);
}
