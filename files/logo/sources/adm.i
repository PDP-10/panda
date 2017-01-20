/* Include file for turtle.c for ADM with Retrographics board */

int admturt(),admfrom(),admto(),admstate();
struct display adm ={0.0,0.0,0.0,-512.0,511.0,-390.0,389.0,1.0,0,
	"","\032\035\033\014\030","","\032\035\033\014\030",
	admturt,admfrom,admto,nullfn,nullfn,nullfn,
	nullfn,nullfn,nullfn,admstate};

admturt(hide)
int hide;	/* nonzero to erase turtle */
{
	double newx,newy,angle;

	printf("\035");
	angle = (mydpy->turth-90.0)*3.141592654/180.0;
	newx = mydpy->turtx + 15.0*sin(angle);
	newy = mydpy->turty + 15.0*cos(angle);
	printf(hide ? "\033\177" : "\033a");
	plotpos((int)newx,(int)(yscrunch*newy));
	angle = mydpy->turth*3.141592654/180.0;
	newx = mydpy->turtx + 15.0*sin(angle);
	newy = mydpy->turty + 15.0*cos(angle);
	plotpos((int)newx,(int)(yscrunch*newy));
	angle = (mydpy->turth+90.0)*3.141592654/180.0;
	newx = mydpy->turtx + 15.0*sin(angle);
	newy = mydpy->turty + 15.0*cos(angle);
	plotpos((int)newx,(int)(yscrunch*newy));
	angle = (mydpy->turth-90.0)*3.141592654/180.0;
	newx = mydpy->turtx + 15.0*sin(angle);
	newy = mydpy->turty + 15.0*cos(angle);
	plotpos((int)newx,(int)(yscrunch*newy));
	printf("\037\030");
}

admfrom(x,y)
double x,y;
{
	printf("\035");
	printf(penerase ? "\033\177" : "\033a");
	plotpos((int)x,(int)y);
}

admto(x,y)
double x,y;
{
	plotpos((int)x,(int)y);
	printf("\037\030");
}

admstate(which) {
	if (which=='R') {
		printf("ADM can't penreverse, setting pendown.\n");
		penerase = 0;
	}
}
