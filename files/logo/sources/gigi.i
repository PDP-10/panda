/* Include file for turtle.c for GIGI */

int gigiturt(),gigifrom(),gigito(),gtcheck(),gpenc(),gstate();
struct display gigi ={0.0,0.0,0.0,-384.0,383.0,-240.0,239.0,0.8,0,
	"\033PpS(E)P[384,240]\033\\\033PrSM0\033\\\033[20;1H",
	"\033PrSM2\033\\\033PpS(E)\033\\",
	"\033PrSM2\033\\\033PpS(E)\033\\",
	"\033PpS(E)\033\\",
	gigiturt,gigifrom,gigito,gtcheck,nullfn,nullfn,nullfn,
	gpenc,nullfn,gstate};

char *gigipens[] = {"W(R)","W(E)","W(C)"};

gtcheck() {
	if (textmode) {
		printf("Not in text mode!\n");
		errhand();
	}
}

gmovepos(x,y)
int x,y;
{
	char s[5];

	x += 384;
	y = 240 - y;
	printf("P[%d,%d]",x,y);
}

gplotpos(x,y)
int x,y;
{
	char s[5];

	x += 384;
	y = 240 - y;
	printf("V[%d,%d]",x,y);
}

gigifrom(oldx,oldy)
double oldx,oldy;
{
	printf("\033Pp");
	gmovepos((int)oldx,(int)oldy);
}

gigito(newx,newy)
double newx,newy;
{
	printf(gigipens[penerase]);
	gplotpos((int)newx,(int)newy);
	printf("\033\\");
}

gigiturt()
{
	double newx,newy,angle;

	printf("\033PpW(C)");
	angle = (mydpy->turth-90.0)*3.141592654/180.0;
	newx = mydpy->turtx + 15.0*sin(angle);
	newy = mydpy->turty + 15.0*cos(angle);
	gmovepos((int)newx,(int)(yscrunch*newy));
	angle = mydpy->turth*3.141592654/180.0;
	newx = mydpy->turtx + 15.0*sin(angle);
	newy = mydpy->turty + 15.0*cos(angle);
	gplotpos((int)newx,(int)(yscrunch*newy));
	angle = (mydpy->turth+90.0)*3.141592654/180.0;
	newx = mydpy->turtx + 15.0*sin(angle);
	newy = mydpy->turty + 15.0*cos(angle);
	gplotpos((int)newx,(int)(yscrunch*newy));
	angle = (mydpy->turth-90.0)*3.141592654/180.0;
	newx = mydpy->turtx + 15.0*sin(angle);
	newy = mydpy->turty + 15.0*cos(angle);
	gplotpos((int)newx,(int)(yscrunch*newy));
	printf(gigipens[penerase]);
	printf("\033\\");
}

gpenc(ipen)
register int ipen;
{
	if ((ipen<0) || (ipen>7)) {
		puts("Bad pen color, must be 0 to 7.");
		errhand();
	}
	printf("\033PpW(I%d)\033\\",ipen);
}

gstate(which) {
	switch (which) {
		case 't':
			printf("\033PrSM2\033\\\033PpS(E)\033\\");
			break;
		case 's':
		case 'f':
			printf("\033PrSM0\033\\\033PpS(E)\033\\");
			if (textmode && shown) gigiturt();
			break;
		case '*':
			printf("\033[K");
	}
}
