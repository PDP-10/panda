/*	Miscellaneous operations in LOGO.
 *	Copyright (C) 1979, The Children's Museum, Boston, Mass.
 *	Written by Douglas B. Klunder.
 */

#include "logo.h"

struct object *true()
{
	return(localize(objcpstr("true")));
}

struct object *false()
{
	return(localize(objcpstr("false")));
}

obstrcmp(obj,str)
register struct object *obj;
char *str;
{
	if (!stringp(obj)) return(1);
	return(strcmp(obj->obstr,str));
}

int truth(x)	/* used by if handler in logo.y */
register struct object *x;
{
	if (obstrcmp(x,"true") && obstrcmp(x,"false")) ungood("If",x);
	if (!obstrcmp(x,"true")) {
		mfree(x);
		return(1);
	} else {
		mfree(x);
		return(0);
	}
}

char *mkstring(obj)
register struct object *obj;
{
	/* subroutine for several operations which treat numbers as words,
	 * turn number into character string.
	 * Note: obj must be known to be nonempty; result is ptr to static.
	 */

	register char *cp;
	static char str[30];

	switch(obj->obtype) {
		case STRING:
			cp = obj->obstr;
			break;
		case INT:
			sprintf(str,FIXFMT,obj->obint);
			cp = str;
			break;
		case DUB:
			sprintf(str,"%g",obj->obdub);
			if (!index(str,'.')) strcat(str,".0");
			cp = str;
			break;
		default:	/* case CONS */
			return(0);	/* not a string, handle uplevel */
	}
	return(cp);
}

struct object *and(x,y)		/* both */
register struct object *x,*y;
{
	if (obstrcmp(x,"true") && obstrcmp(x,"false")) ungood("Both",x);
	if (obstrcmp(y,"true") && obstrcmp(y,"false")) ungood("Both",y);
	if (!obstrcmp(x,"true")) {
		mfree(x);
		return(y);
	} else {
		mfree(y);
		return(x);
	}
}

struct object *or(x,y)		/* either */
register struct object *x,*y;
{
	if (obstrcmp(x,"true") && obstrcmp(x,"false")) ungood("Either",x);
	if (obstrcmp(y,"true") && obstrcmp(y,"false")) ungood("Either",y);
	if (!obstrcmp(x,"true")) {
		mfree(y);
		return(x);
	} else {
		mfree(x);
		return(y);
	}
}

emptyp(x)	/* non-LOGO emptyp, returning 1 if empty, 0 if not. */
register struct object *x;
{
	if (x==0) return(1);
	switch (x->obtype) {
		case STRING:
			if (*(x->obstr)=='\0')	/* check for character */
				return(1);
		default:
			return(0);
	}
}

struct object *lemp(x)		/* LOGO emptyp */
register struct object *x;
{
	if (emptyp(x)) {
		mfree(x);
		return(true());
	} else {
		mfree(x);
		return(false());
	}
}

struct object *comp(x)		/* not */
register struct object *x;
{
	if (!obstrcmp(x,"true")) {
		mfree(x);
		return(false());
	} else if (!obstrcmp(x,"false")) {
		mfree(x);
		return(true());
	} else ungood("Not",x);
}

struct object *lsentp(x)	/* LOGO sentencep */
register struct object *x;
{
	register struct object *y;

	if (x==0) return(true());
	if (listp(x)) {
		/* BH 4/30/81 true only for a flat sentence,
		   not a list of lists */
		for (y = x; y; y = y->obcdr)
			if (listp(y->obcar)) {
				mfree(x);
				return(false());
			}
		mfree(x);
		return(true());
	} else {
		mfree(x);
		return(false());
	}
}

struct object *lwordp(x)	/* LOGO wordp */
register struct object *x;
{
	if (!listp(x)) {
		mfree(x);
		return(true());
	} else {
		mfree(x);
		return(false());
	}
}

struct object *first(x)		/* first */
register struct object *x;
{
	register struct object *temp;
	register char *cp;
	char str[2];

	if (emptyp(x)) ungood("First",x);
	if (cp = mkstring(x)) {
		str[0] = *cp;
		str[1] = '\0';
		mfree(x);
		return(localize(objcpstr(str)));
	} else {
		temp = x->obcar;
		localize(temp);
		mfree(x);
		return(temp);
	}
}

struct object *butfir(x)		/* butfirst */
register struct object *x;
{
	register struct object *temp;
	register char *cp;

	if (emptyp(x)) ungood("Butfirst",x);
	if (cp = mkstring(x)) {
		cp++;	/* skip first char */
		mfree(x);
		return(localize(objcpstr(cp)));
	} else {
		temp = x->obcdr;
		localize(temp);
		mfree(x);
		return(temp);
	}
}

struct object *last(x)		/* last */
register struct object *x;
{
	register struct object *temp;
	register char *cp;

	if (emptyp(x)) ungood("Last",x);
	if (cp = mkstring(x)) {
		mfree(x);
		return(localize(objcpstr(&cp[strlen(cp)-1])));
	} else {
		for(temp=x; temp->obcdr; temp=temp->obcdr) ;
		temp = temp->obcar;
		localize(temp);
		mfree(x);
		return(temp);
	}
}

struct object *butlas(x)		/* butlast */
register struct object *x;
{
	register struct object *temp,*temp2,*ans;
	register char *cp;
	int i;	/* losing twenex pcc */

	if (emptyp(x)) ungood("Butlast",x);
	if (cp = mkstring(x)) {
		mfree(x);
		temp = objstr(ckmalloc(strlen(cp)));
		strncpy(temp->obstr,cp,strlen(cp)-1);
		i = strlen(cp)-1;
		(temp->obstr)[i] = '\0';
		return(localize(temp));
	} else {
		if ((x->obcdr)==0) {
			mfree(x);
			return(0);
		}
		temp2 = ans = glbcons(0,0);
		for(temp=x; temp->obcdr->obcdr; temp=temp->obcdr) {
			temp2->obcar = globcopy(temp->obcar);
			temp2->obcdr = globcopy(glbcons(0,0));
			temp2 = temp2->obcdr;
		}
		temp2->obcar = globcopy(temp->obcar);
		localize(ans);
		mfree(x);
		return(ans);
	}
}

struct object *fput(x,y)
register struct object *x,*y;
{
	register struct object *z;

	if(!listp(y)) {
		printf("Second input of fput must be a list.\n");
		errhand();
	}
	z = loccons(x,y);
	mfree(x);
	mfree(y);
	return(z);
}

struct object *lput(x,y)
struct object *x,*y;
{
	register struct object *a,*b,*ans;

	if (!listp(y)) {
		printf("Second input of lput must be a list.\n");
		errhand();
	}
	if (y == 0) {	/* 2nd input is empty list */
		b = loccons(x,0);
		mfree(x);
		return(b);
	}
	ans = a = loccons(0,0);
	for (b=y; b; b=b->obcdr) {
		a->obcar = globcopy(b->obcar);
		a->obcdr = globcopy(glbcons(0,0));
		a = a->obcdr;
	}
	a->obcar = globcopy(x);
	mfree(x);
	mfree(y);
	return(ans);
}

struct object *list(x,y)
struct object *x,*y;
{
	register struct object *a,*b;

	b = glbcons(y,0);
	a = loccons(x,b);
	mfree(x);
	mfree(y);
	return(a);
}

struct object *length(x)		/* count */
register struct object *x;
{
	register struct object *temp;
	register char *cp;
	register int i;

	if (x==0) return(localize(objint((FIXNUM)0)));
	if (cp = mkstring(x)) {
		i = strlen(cp);
		mfree(x);
		return(localize(objint((FIXNUM)i)));
	} else {
		i = 0;
		for (temp=x; temp; temp = temp->obcdr)
			i++;
		mfree(x);
		return(localize(objint((FIXNUM)i)));
	}
}

logois(x,y)		/* non-Logo is, despite the name */
register struct object *x,*y;
{
	if (listp(x)) {
		if (listp(y)) {
			if (x==0) return(y==0);
			if (y==0) return(0);
			return(logois(x->obcar,y->obcar) &&
				logois(x->obcdr,y->obcdr) );
		}
		return(0);
	}
	if (listp(y)) return(0);
	if (x->obtype != y->obtype) return(0);
	switch (x->obtype) {
		case INT:
			return(x->obint == y->obint);
		case DUB:
			return(x->obdub == y->obdub);
		default:	/* case STRING */
			return(!strcmp(x->obstr,y->obstr));
	}
}

struct object *lis(x,y)
register struct object *x,*y;
{
	register z;

	z = logois(x,y);
	mfree(x);
	mfree(y);
	return(z ? true() : false());
}

leq(x,y)	/* non-Logo numeric equal */
register struct object *x,*y;
{
	NUMBER dx,dy;
	FIXNUM ix,iy;
	int xint,yint;

	if (listp(x) || listp(y)) return(logois(x,y));
	if (stringp(x) && !nump(x)) return(logois(x,y));
	if (stringp(y) && !nump(y)) return(logois(x,y));
	xint = yint = 0;
	if (stringp(x)) {
		if (isint(x)) {
			xint++;
			sscanf(x->obstr,FIXFMT,&ix);
		} else {
			sscanf(x->obstr,EFMT,&dx);
		}
	} else {
		if (intp(x)) {
			xint++;
			ix = x->obint;
		} else {
			dx = x->obdub;
		}
	}
	if (stringp(y)) {
		if (isint(y)) {
			yint++;
			sscanf(y->obstr,FIXFMT,&iy);
		} else {
			sscanf(y->obstr,EFMT,&dy);
		}
	} else {
		if (intp(y)) {
			yint++;
			iy = y->obint;
		} else {
			dy = y->obdub;
		}
	}
	if (xint != yint) {
		if (xint) dx = ix;
		else dy = iy;
		xint = 0;
	}
	if (xint)
		return (ix == iy);
	else
		return (dx == dy);
}

struct object *equal(x,y)	/* Logo equalp */
register struct object *x,*y;
{
	register z;

	z = leq(x,y);
	mfree(x);
	mfree(y);
	return(z ? true() : false());
}

struct object *worcat(x,y)	/* word */
register struct object *x,*y;
{
	char *val,*xp,*yp;
	char xstr[30],ystr[30];

	if (listp(x)) ungood("Word",x);
	if (listp(y)) ungood("Word",y);
	switch(x->obtype) {
		case INT:
			sprintf(xstr,FIXFMT,x->obint);
			xp = xstr;
			break;
		case DUB:
			sprintf(xstr,"%g",x->obdub);
			if (!index(xstr,'.')) strcat(xstr,".0");
			xp = xstr;
			break;
		default:	/* case STRING */
			xp = x->obstr;
	}
	switch(y->obtype) {
		case INT:
			sprintf(ystr,FIXFMT,y->obint);
			yp = ystr;
			break;
		case DUB:
			sprintf(ystr,"%g",y->obdub);
			if (!index(ystr,'.')) strcat(ystr,".0");
			yp = ystr;
			break;
		default:	/* case STRING */
			yp = y->obstr;
	}
	val=ckmalloc(strlen(xp)+strlen(yp)+1);
	cpystr(val,xp,yp,NULL);
	mfree(x);
	mfree(y);
	return(localize(objstr(val)));
}

struct object *sencat(x,y)	/* sentence */
struct object *x,*y;
{
	register struct object *a,*b,*c;

	if (x==0) {
		if (listp(y)) return(y);
		a = loccons(y,0);
		mfree(y);
		return(a);
	}
	if (listp(x)) {
		c = a = glbcons(0,0);
		for (b=x; b->obcdr; b = b->obcdr) {
			a->obcar = globcopy(b->obcar);
			a->obcdr = globcopy(glbcons(0,0));
			a = a->obcdr;
		}
		a->obcar = globcopy(b->obcar);
	}
	else c = a = glbcons(x,0);

	if (listp(y)) b = y;
	else b = glbcons(y,0);

	a->obcdr = globcopy(b);
	mfree(x);
	mfree(y);
	return(localize(c));
}

struct object *memberp(thing,group)
struct object *thing,*group;
{
	register char *cp;
	register struct object *rest;
	int i;

	if (group==0) {
		mfree(thing);
		return(false());
	}
	if (cp = mkstring(group)) {
		if (thing==0) {
			mfree(group);
			return(false());
		}
		switch (thing->obtype) {
			case INT:
				if((thing->obint >= 0)&&(thing->obint < 10)) {
					i = memb('0'+thing->obint,cp);
					break;
				}
			case CONS:
			case DUB:
				i = 0;
				break;
			default:	/* STRING */
				if (strlen(thing->obstr) == 1) {
					i = memb(*(thing->obstr),cp);
				} else i = 0;
		}
	} else {
		i = 0;
		for (rest=group; rest; rest=rest->obcdr) {
			if (leq(rest->obcar,thing)) {
				i++;
				break;
			}
		}
	}
	mfree(thing);
	mfree(group);
	return(torf(i));
}

struct object *item(num,group)
struct object *num,*group;
{
	int inum,ernum;
	register char *cp;
	register struct object *rest;
	char str[2];

	num = numconv(num,"Item");
	if (intp(num)) inum = num->obint;
	else inum = num->obdub;
	if (inum <= 0) ungood("Item",num);
	if (group == 0) ungood("Item",group);
	if (cp = mkstring(group)) {
		if (inum > strlen(cp)) {
			pf1("%p has fewer than %d items.\n",group,inum);
			errhand();
		}
		str[0] = cp[inum-1];
		str[1] = '\0';
		mfree(num);
		mfree(group);
		return(localize(objcpstr(str)));
	} else {
		ernum = inum;
		for (rest = group; --inum; rest = rest->obcdr) {
			if (rest==0) break;
		}
		if (rest==0) {
			pf1("%p has fewer than %d items.\n",
					group,ernum);
			errhand();
		}
		mfree(num);
		rest = localize(rest->obcar);
		mfree(group);
		return(rest);
	}
}
