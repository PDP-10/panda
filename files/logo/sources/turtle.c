#include "logo.h"

#ifndef NOTURTLE

#include <math.h>

#define fabs(a) ((a) < 0. ? (-(a)) : (a))

extern char *getenv();
int turtdes; /* file descriptor for open turtle */
int color;	/* pen color */
int pendown = 0; /* nonzero with pen down */
int penerase = 0; /* 0=pd, 1=pe, 2=px, pendown must be nonzero */
int shown = 1;	/* nonzero if turtle is visible */
int textmode = 0;	/* not turtle off */
NUMBER yscrunch;	/* scale factor for y */
struct display *mydpy;

#ifdef ATARI
#include "atari.i"
#endif

#ifdef GIGI
#include "gigi.i"
#endif

#ifdef ADM
#include "admtek.i"
#include "adm.i"
#endif

#ifdef TEK
#ifndef ADM
#include "admtek.i"
#endif
#include "tek.i"
#endif

#ifdef SUN
#include "sun.i"
#endif

NUMBER ncheck(arg)
struct object *arg;
{
	NUMBER val;

	arg = numconv(arg,"Turtle command");
	arg = dubconv(arg);
	val = arg->obdub;
	mfree(arg);
	return(val);
}

dpyinit() {
	char *ttytype;

	ttytype = getenv("TERM");
#ifdef GIGI
	if ((!strcmp(ttytype,"gigi")) || (!strcmp(ttytype,"GIGI")))
		mydpy = &gigi;
	else
#endif
#ifdef ATARI
	if ((!strcmp(ttytype,"atari")) || (!strcmp(ttytype,"ATARI")))
		mydpy = &bwatari;
	else
#endif
#ifdef ADM
	if ((!strncmp(ttytype,"adm",3)) || (!strncmp(ttytype,"ADM",3)))
		mydpy = &adm;
	else
#endif
#ifdef TEK
	if ((!strncmp(ttytype,"tek",3)) || (!strncmp(ttytype,"TEK",3)))
		mydpy = &tek;
	else
#endif
#ifdef SUN
	/* Sun is always a sun */
	if (1 || (!strcmp(ttytype,"sun")) !! (!strcmp(ttytype,"SUN")))
		mydpy = &sun;
	else
#endif
	{
		printf("I don't recognize your terminal type!\n");
		errhand();
	}
	pendown = 1; penerase = 0; shown = 1;
	textmode = 0;
	mydpy->turtx = mydpy->turty = mydpy->turth = 0.0;
	printf(mydpy->init);
	if (!(mydpy->cleared)) {
		printf(mydpy->clear);
		(*mydpy->state)('c');
		mydpy->cleared++;
		yscrunch = mydpy->stdscrunch;
	}
	turtdes = -1;
	(*mydpy->infn)();
	(*mydpy->drawturt)(0);
}

struct object *getturtle(arg)
register struct object *arg;
{
	int lsflag[2];	/* BH 1/4/81 */
	register char *temp,*argc;
	char c[100];
	char astr[20];

	if (stringp(arg)) argc = arg->obstr;
	else argc = "";
	if (!strcmp(argc,"off")) {
#ifdef FLOOR
		if (turtdes>0) {
			close (turtdes);
			printf("Please unplug the turtle and put it away!\n");
		}
#endif /* FLOOR */
		if (turtdes<0) {
			printf(mydpy->finish);
			(*mydpy->outfn)();
		}
		turtdes = 0;
		mfree(arg);
		return((struct object *)(-1));
	}
	if (!strcmp(argc,"dpy")||!strcmp(argc,"display")) {

#ifdef FLOOR
		if (turtdes>0) {
			close (turtdes);
			printf("Please unplug the turtle and put it away!\n");
		}
#endif /* FLOOR */

		dpyinit();
		mfree(arg);
		return ((struct object *)(-1));
	}
#ifdef FLOOR
	if (intp(arg)) {
		sprintf(astr,FIXFMT,arg->obint);
		argc = astr;
	}
	temp = c;
	cpystr(temp,"/dev/turtle",argc,NULL);
	if (turtdes>0) close(turtdes);
	if((turtdes = open(c,2)) < 0) {
		turtdes = 0;
		pf1("Turtle %l not available.\n",arg);
	} else printf("Please put the turtle away when you're done!\n");
	mfree(arg);
	return ((struct object *)(-1));
#else
	ungood("Turtle",arg);
#endif /* FLOOR */
}

dpysxy(newx,newy)
NUMBER newx,newy;
{
	if ((newx < mydpy->xlow) || (newx > mydpy->xhigh) ||
		(newy < mydpy->ylow) || (newy > mydpy->yhigh)) {
			puts("Out of bounds!");
			errhand();
	}
	if (shown) (*mydpy->drawturt)(1);
	if (fabs(newx) < 0.01) newx = 0.0;
	if (fabs(newy) < 0.01) newy = 0.0;
	if (pendown)
		(*mydpy->drawfrom)(mydpy->turtx,yscrunch*mydpy->turty);
	mydpy->turtx = newx;
	mydpy->turty = newy;
	if (pendown)
		(*mydpy->drawto)(newx,yscrunch*newy);
	(*mydpy->state)('G');
	if (shown) (*mydpy->drawturt)(0);
}

dpyforw(dist)
NUMBER dist;
{
	NUMBER newx,newy,deltax,deltay;

	tcheck();
	(*mydpy->txtchk)();
	deltax = dist * sin((mydpy->turth)*3.141592654/180.0);
	if (fabs(deltax) < 1.0e-5) deltax = 0.0;
	deltay = dist * cos((mydpy->turth)*3.141592654/180.0);
	if (fabs(deltay) < 1.0e-5) deltay = 0.0;
	newx = mydpy->turtx + deltax;
	newy = mydpy->turty + deltay;
	dpysxy(newx,newy);
}

struct object *forward(arg)
register struct object *arg;
{
	NUMBER dist;

	dist = ncheck(arg);
#ifdef FLOOR
	if (turtdes > 0) {
		if (dist < 0.0)
			moveturtle('b',-6*(int)dist);
		else
			moveturtle('f',6*(int)dist);
		return ((struct object *)(-1));
	}
#endif /* FLOOR */
	dpyforw(dist);
	return ((struct object *)(-1));
}

struct object *back(arg)
register struct object *arg;
{
	NUMBER dist;

	dist = ncheck(arg);
#ifdef FLOOR
	if (turtdes > 0) {
		if (dist < 0.0)
			moveturtle('f',-6*(int)dist);
		else
			moveturtle('b',6*(int)dist);
		return ((struct object *)(-1));
	}
#endif /* FLOOR */
	dpyforw(-dist);
	return ((struct object *)(-1));
}

dpysh(angle)
NUMBER angle;
{
	tcheck();
	(*mydpy->txtchk)();
	if (shown) (*mydpy->drawturt)(1);
	mydpy->turth = angle;
	while (mydpy->turth+11.0 < 0.0) mydpy->turth += 360.0;
	while (mydpy->turth+11.0 >= 360.0) mydpy->turth -= 360.0;
	if (shown) (*mydpy->drawturt)(0);
	(*mydpy->turnturt)();
}

dpyturn(angle)
NUMBER angle;
{
	dpysh(mydpy->turth + angle);
}

struct object *left(arg)
register struct object *arg;
{
	NUMBER dist;

	dist = ncheck(arg);
#ifdef FLOOR
	if (turtdes > 0) {
		if (dist < 0.0)
			moveturtle('r',(-2*(int)dist)/5);
		else
			moveturtle('l',(2*(int)dist)/5);
		return ((struct object *)(-1));
	}
#endif /* FLOOR */
	dpyturn(-dist);
	return ((struct object *)(-1));
}

struct object *right(arg)
register struct object *arg;
{
	NUMBER dist;

	dist = ncheck(arg);
#ifdef FLOOR
	if (turtdes > 0) {
		if (dist < 0.0)
			moveturtle('l',(-2*(int)dist)/5);
		else
			moveturtle('r',(2*(int)dist)/5);
		return ((struct object *)(-1));
	}
#endif /* FLOOR */
	dpyturn(dist);
	return ((struct object *)(-1));
}

#ifdef FLOOR
fcheck() {
	if (turtdes <= 0) {
		puts("You don't have a floor turtle!");
		errhand();
	}
}

struct object *hitoot(arg)
register struct object *arg;
{
	NUMBER dist;

	fcheck();
	dist = ncheck(arg);
	moveturtle('H',(15*(int)dist)/2);
	return ((struct object *)(-1));
}

struct object *lotoot(arg)
register struct object *arg;
{
	NUMBER dist;

	fcheck();
	dist = ncheck(arg);
	moveturtle('L',(15*(int)dist)/2);
	return ((struct object *)(-1));
}

moveturtle(where,arg)
register int arg;
{
	char buff[2];

	buff[0] = where;
	while (arg >= 0400) {
		buff[1] = 0377;
		write(turtdes,buff,2);
		arg -= 0377;
	}
	buff[1] = arg;
	write(turtdes,buff,2);
}

lampon() {
	int i;

	fcheck();
	i = 'B';
	write(turtdes,&i,2);
}

lampoff() {
	int i;

	fcheck();
	i = 'B'+0400;
	write(turtdes,&i,2);
}

struct object *touchsense(which)
{
	char x;

	fcheck();
	read (turtdes,&x,1);
	if ( (0200>>which) & x) return (true());
	else return (false());
}

struct object *ftouch() {
	return(touchsense(0));
}

struct object *btouch() {
	return(touchsense(1));
}

struct object *ltouch() {
	return(touchsense(2));
}

struct object *rtouch() {
	return(touchsense(3));
}
#endif

int tcheck() {
	if (turtdes > 0) {
		puts("You don't have a display turtle!");
		errhand();
	}
	if (turtdes == 0) dpyinit();	/* free turtle "display */
}

NUMBER posangle(angle)
NUMBER angle;
{
	if (angle < 0.0) return(angle+360.0);
	return(angle);
}

struct object *pencolor(pen)
struct object *pen;
{
	NUMBER dpen;

	tcheck();
	(*mydpy->txtchk)();
	dpen = ncheck(pen);
	(*mydpy->penc)((int)dpen);
	color = dpen;
	return ((struct object *)(-1));
}

int setcolor(pen,colorlist)
struct object *pen,*colorlist;
{
	NUMBER number;
	register int ipen;

	tcheck();
	(*mydpy->txtchk)();
	number = ncheck(pen);
	ipen = number;
	(*mydpy->setc)(ipen,colorlist);
}

int setxy(strx,stry)
struct object *strx,*stry;
{
	NUMBER x,y;

	tcheck();
	(*mydpy->txtchk)();
	x = ncheck(strx);
	y = ncheck(stry);
	dpysxy(x,y);
}

struct object *setheading(arg)
struct object *arg;
{
	NUMBER heading;

	tcheck();
	(*mydpy->txtchk)();
	heading = ncheck(arg);
	dpysh(heading);
	return ((struct object *)(-1));
}

struct object *xcor()
{
	tcheck();
	return(localize(objdub(mydpy->turtx)));
}

struct object *ycor()
{
	tcheck();
	return(localize(objdub(mydpy->turty)));
}

struct object *heading()
{
	tcheck();
	return(localize(objdub(posangle(mydpy->turth))));
}

struct object *getpen()
{
	tcheck();
	return(localize(objint(color)));
}

struct object *setscrunch(new)
struct object *new;
{
	tcheck();
	yscrunch = ncheck(new);
	return ((struct object *)(-1));
}

struct object *scrunch() {
	tcheck();
	return(localize(objdub(yscrunch)));
}

penup() {
#ifdef FLOOR
	int i;

	if (turtdes>0) {
		i = 'P'+0400;
		write(turtdes,&i,2);
		return;
	}
#endif FLOOR
	tcheck();
	pendown = 0;
	(*mydpy->state)('U');
}

cmpendown() {
#ifdef FLOOR
	int i;

	if (turtdes>0) {
		i = 'P';
		write(turtdes,&i,2);
		return;
	}
#endif FLOOR
	tcheck();
	pendown = 1;
	penerase = 0;
	(*mydpy->state)('D');
}

cmpenerase() {
	tcheck();
	pendown = penerase = 1;
	(*mydpy->state)('E');
}

penreverse() {
	tcheck();
	pendown = 1;
	penerase = 2;
	(*mydpy->state)('R');
}

clearscreen() {
	tcheck();
	(*mydpy->txtchk)();
	printf(mydpy->clear);
	mydpy->turtx = mydpy->turty = mydpy->turth = 0.0;
	(*mydpy->state)('c');
	if (shown) (*mydpy->drawturt)(0);
}

wipeclean() {
	tcheck();
	(*mydpy->txtchk)();
	printf(mydpy->clear);
	(*mydpy->state)('w');
	if (shown) (*mydpy->drawturt)(0);
}

fullscreen() {
	tcheck();
	(*mydpy->state)('f');
	textmode = 0;
}

splitscreen() {
	tcheck();
	(*mydpy->state)('s');
	textmode = 0;
}

textscreen() {
	tcheck();
	(*mydpy->state)('t');
	textmode++;
}

showturtle() {
	tcheck();
	(*mydpy->txtchk)();
	if (!shown) (*mydpy->drawturt)(0);
	shown = 1;
	(*mydpy->state)('S');
}

hideturtle() {
	tcheck();
	(*mydpy->txtchk)();
	if (shown) (*mydpy->drawturt)(1);
	shown = 0;
	(*mydpy->state)('H');
}

struct object *penmode() {
	static char *pens[] = {"pendown","penerase","penreverse"};

	tcheck();
	if (pendown) return(localize(objcpstr(pens[penerase])));
	return(localize(objcpstr("penup")));
}

struct object *shownp() {
	tcheck();
	return(torf(shown));
}

struct object *towardsxy(x,y)
struct object *x,*y;
{
	NUMBER dx,dy;

	tcheck();
	dx = ncheck(x);
	dy = ncheck(y);
	return(localize(objdub(posangle((double)180.0*
		atan2(dx-(mydpy->turtx),dy-(mydpy->turty))/3.141592654))));
}

#endif
 