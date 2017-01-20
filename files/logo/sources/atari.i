/* Include file for turtle.c for Atari 800 as graphics terminal */

int ataturn(),apenc(),asetc(),astate();
NUMBER ncheck();

struct display bwatari ={0.0,0.0,0.0,-160.0,160.0,-96.0,96.0,0.875,0,
	"\033#G","\033c","\033.t","\033.c",
	nullfn,nullfn,nullfn,nullfn,nullfn,nullfn,ataturn,
	apenc,asetc,astate};
struct display colatari ={0.0,0.0,0.0,-80.0,80.0,-48.0,48.0,0.875,0,
	"\033#G","\033c","\033.t","\033.c",
	nullfn,nullfn,nullfn,nullfn,nullfn,nullfn,ataturn,
	apenc,asetc,astate};

ataturn() {
	printf("\033.%dh",(int)((mydpy->turth+11.0)/22.5));
}

apenc(ipen)
register int ipen;
{
	if ((ipen<0) || (ipen>6)) {
		puts("Bad pen color, must be 0 to 6.");
		errhand();
	}
	mydpy = (ipen ? &colatari : &bwatari);
	printf("\033.%dP",ipen);
	if (!(mydpy->cleared)) {
		printf("\033.c");	/* clear screen */
		mydpy->cleared++;
	}

	/* this is to fix bug in Atari program */
	printf("\033.%dh",(int)((mydpy->turth+11.0)/22.5));
}

asetc(ipen,colorlist)
register int ipen;
struct object *colorlist;
{
	register struct object *next;
	register int icolor,intens;
	static int normint[] = {1,5,5,1};
	NUMBER number;

	if ((ipen<0) || (ipen>3)) {
		puts("Pen number must be 0 to 3.");
		errhand();
	}

	if (listp(colorlist)) {
		number = ncheck(localize(colorlist->obcar));
		icolor = number;
		next = colorlist->obcdr;
		number = ncheck(localize(next->obcar));
		intens = number;
		mfree(colorlist);
	} else {
		number = ncheck(colorlist);
		icolor = number;
		intens = normint[ipen];
	}
	if ((icolor<0) || (icolor>15) || (intens<0) || (intens>7)) {
		puts("Invalid color numbers.");
		errhand();
	}
	printf("\033.%d;%dC",ipen,(icolor*16)+(intens*2));
}

astate(which) {
	switch(which) {
		case 'c':
			fflush(stdout);
			sleep(1);
		case '*':
			return;
		case 'w':
			fflush(stdout);
			sleep(1);
			ataturn();
			printf("\033.U\033.%d;%dG",
				(int)(yscrunch*mydpy->turty),(int)(mydpy->turtx));
			if (pendown)
				printf("\033.%c","DER"[penerase]);
			return;
		case 'G':
			printf("\033.%d;%dG",
				(int)(yscrunch*mydpy->turty),(int)(mydpy->turtx));
			return;
		case 'R':
			printf("Atari can't penreverse; setting pendown.\n");
			penerase = 0;
			which = 'D';
			/* falls into */
		default:
			printf("\033.%c",which);
	}
}
