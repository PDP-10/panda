/* Include file for turtle.c for Sun Microsystems workstation */

#include <gfx.h>
/* If we are on a Sun, Logo must be loaded -lgfx */

int sunturt(),sunfrom(),sunto(),suninit(),sunstate();
struct display sun ={0.0,0.0,0.0,-1000.0,1000.0,-1000.0,1000.0,1.0,0,
	"","","","",sunturt,sunfrom,sunto,nullfn,suninit,nullfn,
	nullfn,nullfn,nullfn,sunstate};

NUMBER sunoldx,sunoldy;

transline(type,fromx,fromy,tox,toy) {
	line(type,fromx+screen.w/2,screen.h/2-fromy,tox+screen.w/2,
			screen.h/2-toy);
}

sunturt(hide)
int hide;	/* nonzero to erase turtle */
{
	double newx,newy,oldx,oldy,angle;

	angle = (mydpy->turth-90.0)*3.141592654/180.0;
	oldx = mydpy->turtx + 15.0*sin(angle);
	oldy = mydpy->turty + 15.0*cos(angle);
	angle = mydpy->turth*3.141592654/180.0;
	newx = mydpy->turtx + 15.0*sin(angle);
	newy = mydpy->turty + 15.0*cos(angle);
	transline(GXinvert,(int)oldx,(int)(yscrunch*oldy),
		(int)newx,(int)(yscrunch*newy));
	oldx = newx;
	oldy = newy;
	angle = (mydpy->turth+90.0)*3.141592654/180.0;
	newx = mydpy->turtx + 15.0*sin(angle);
	newy = mydpy->turty + 15.0*cos(angle);
	transline(GXinvert,(int)oldx,(int)(yscrunch*oldy),
		(int)newx,(int)(yscrunch*newy));
	oldx = newx;
	oldy = newy;
	angle = (mydpy->turth-90.0)*3.141592654/180.0;
	newx = mydpy->turtx + 15.0*sin(angle);
	newy = mydpy->turty + 15.0*cos(angle);
	transline(GXinvert,(int)oldx,(int)(yscrunch*oldy),
		(int)newx,(int)(yscrunch*newy));
}

suninit() {
	initscreen();
	drasterop(GXset,0,0,SCREEN,1024,1024);
}

sunfrom(x,y)
NUMBER x,y;
{
	sunoldx = x;
	sunoldy = y;
}

sunto(x,y)
NUMBER x,y;
{
	static int sunpens[] = {GXclear,GXset,GXinvert};
	/* NOTE should be set,clear but it works this way, why??? */

	transline((sunpens[penerase],
		(int)sunoldx,(int)sunoldy,(int)x,(int)y);
}

sunstate(which) {
	if (which == 'c' || which == 'w')
		drasterop(GXset,0,0,SCREEN,1024,1024);
}
