/*
 * Driver for Terrapin turtles interfaced via DR11-K.
 * Based on DR-11C driver Copyright (c) 1978, the Children's Museum.
 * This version by Brian Harvey, Lincoln-Sudbury Regional High School.
 */

#include "../h/param.h"
#include "../h/dir.h"
#include "../h/user.h"

/* The hardware registers */
struct dr {
	int drcsr;
	char dribuf[2];
	char drobuf[2];
};

#define NTURTDR 1 /* Number of DR11Ks for turtles (2 turtles per DR) */

struct dr *dr_addr[2] = { (struct dr *)0167770, (struct dr *)0167760};

struct turt {
	struct proc *procp;
	int time;
	char turnoff;
} turtle[2*NTURTDR];

struct turtcmd {
	char cmd,bits;
}  trans[] ={
	'f', 05,	/* forward */
	'b',012,	/* back */
	'l',011,	/* left */
	'r', 06,	/* right */
	'P', 0200,	/* pen down */
	'H', 060,	/* high horn */
	'L', 040,	/* low horn */
	'B', 0100,	/* headlights (bright) */
};

#define NCMDS (sizeof(trans) / sizeof(struct turtcmd))

turtopen(dev,flag) {
	dev = minor(dev);
	if (dev >= 2*NTURTDR) {
		u.u_error = ENXIO;
		return;
	}
	if (turtle[dev].procp) {
		u.u_error = EBUSY;
		return;
	}
	turtle[dev].procp = u.u_procp;
}

turtclose(dev) {
	dev = minor(dev);
	turtle[dev].procp = 0;
	turtle[dev].time = 0;
	dr_addr[dev>>1]->drobuf[dev&01] = -1;
}

turttimo(dev) {
	spl5();
	dr_addr[dev>>1]->drobuf[dev&01] |= turtle[dev].turnoff;
	turtle[dev].time = 0;
	wakeup(&turtle[dev]);
	spl0();
}

turtwrite(dev) {
	register c,i;

	dev = minor(dev);
	c = cpass();
	if (c < 0) return;
	for (i=0; i<NCMDS; i++) {
		if (c == trans[i].cmd) goto good;
	}
	cpass();
	u.u_error = EIO;
	return;
good:
	spl5();
	if((turtle[dev].time = 2*cpass()) < 0) {	/* BH 8/25/80 2* */
		turtle[dev].time = 0;
		spl0();
		u.u_error = EIO;
		return;
	}
	dr_addr[dev>>1]->drobuf[dev&01] &= ~trans[i].bits;
	if (turtle[dev].time) {
		turtle[dev].turnoff = trans[i].bits;
		timeout(turttimo,dev,turtle[dev].time);
		while(turtle[dev].time)
			sleep(&turtle[dev],9);
	}
	spl0();
}

turtread(dev) {
	register c;

	dev = minor(dev);
	c = dr_addr[dev>>1]->dribuf[dev&01];
	passc(c);
}
