/*  This provides the outermost framework of LOGO, calling the parser to
 *	begin with, and then thereafter whenever an interrupt or error occurs.
 *	Copyright (C) 1979, The Children's Museum, Boston, Mass.
 *	Written by Douglas B. Klunder.
 */

#include "logo.h"

char editfile[30];
extern char *getbpt;
extern int turtdes;
extern struct display *mydpy;
extern capini();

main(argc,argv)
int argc;
char *argv[];
{
	int i[2];
	char tbuff[BUFSIZ];

	capini();
	setbuf(stdout,tbuff);
	time(i);
	srand((i[1]*i[0])^i[1]);
	sprintf(editfile,"logo%u",(short)_hptim());
	if (argc>1)
		getbpt = argv[1];
	else
		printf("\nWelcome to Children's Museum/LSRHS LOGO (TOPS-20 version)\n*");
	fflush(stdout);
	while (enter()==1) {
		yyprompt(1);
	}
	cboff();
#ifdef FLOOR
	if (turtdes>0)
		printf("Please unplug the turtle and put it away.\n");
#endif
	if (turtdes<0) {
		printf(mydpy->finish);
		(*mydpy->outfn)();
	}
	unlink(editfile);
}
