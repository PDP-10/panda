/*	Numeric operations in LOGO.
 *	In arithmetic operations, the input, which is a character, is
 *	converted to numeric, the operations are done, and the result is
 *	converted back to character.
 *	In all cases, the inputs are freed, and a new output is created.
 *
 *	Copyright (C) 1979, The Children's Museum, Boston, Mass.
 *	Written by Douglas B. Klunder.
 */

#include <math.h>
#include "logo.h"

nump(x)		/* non-LOGO numberp, just for strings */
register struct object *x;
{	/* a number is a series of at least one digit, with an optional
	* starting + or -. */
	register char ch,*cp;

	cp = x->obstr;
	if (*cp=='\0') return(0);
	if (*cp!='-' && *cp!='+' && (*cp<'0' || *cp>'9') && *cp!='.') return(0);
	if ((*cp=='-' || *cp=='+' || *cp=='.') && *(cp+1)=='\0') return(0);
	if(*cp=='.' && index(cp+1,'.')) return(0);
	cp++;
	while ((ch = *cp)!='\0') {
		if ((ch<'0'||ch>'9')&&(ch!='e')&&(ch!='E')&&(ch!='.'))
			return(0);
		if ((ch == 'e') || (ch == 'E')) {
			if (index(cp+1,'e') || index(cp+1,'E')
			  || index(cp+1,'.')) return(0);
			if (((ch = *(cp+1))=='+') || (ch=='-')) cp++;
		}
		else if (ch == '.') {
			if (index(cp+1,'e') || index(cp+1,'E')
			  || index(cp+1,'.')) return(0);
		}
		cp++;
	}
	return(1);
}

/* Check a STRING object to see if it's an integer string */
isint(x)
register struct object *x;
{
	register char ch,*cp;

	cp = x->obstr;
	while (ch = *cp++)
		if ((ch == '.') || (ch == 'e') || (ch == 'E'))
			return(0);
	return(1);
}

/* convert object (which might be a word of digits) to a number */
struct object *numconv(thing,op)
register struct object *thing;
char *op;
{
	register struct object *newthing;
	FIXNUM ithing;
	NUMBER dthing;

	if (thing == 0) ungood(op,thing);
	switch (thing->obtype) {
		case CONS:
			ungood(op,thing);
		case INT:
		case DUB:
			return(thing);
		default:
			if (!nump(thing)) ungood(op,thing);
			if (isint(thing)) {
				sscanf(thing->obstr,FIXFMT,&ithing);
				newthing = localize(objint(ithing));
			} else {
				sscanf(thing->obstr,EFMT,&dthing);
				newthing = localize(objdub(dthing));
			}
	}
	mfree(thing);
	return(newthing);
}

/* convert integer to double */
struct object *dubconv(num)
register struct object *num;
{
	NUMBER d;

	if (dubp(num)) return(num);
	d = num->obint;
	mfree(num);
	return(localize(objdub(d)));
}

struct object *opp(x)	/* Unary - */
register struct object *x;
{
	register struct object *ans;

	x = numconv(x,"Minus");
	if (intp(x)) {
		ans = objint(-(x->obint));
	} else {
		ans = objdub(-(x->obdub));
	}
	mfree(x);
	return(localize(ans));
}

struct object *add(x,y)	/* sum */
register struct object *x,*y;
{
	FIXNUM iz;
	NUMBER dz;
	register struct object *z;

	x = numconv(x,"Sum");
	y = numconv(y,"Sum");
	if (!intp(x) || !intp(y)) {
		x = dubconv(x);
		y = dubconv(y);
	}
	if (intp(x)) {
		iz = (x->obint)+(y->obint);
		z = objint(iz);
	} else {
		dz = (x->obdub)+(y->obdub);
		z = objdub(dz);
	}
	mfree(x);
	mfree(y);
	return(localize(z));
}

struct object *sub(x,y)	/* difference */
register struct object *x,*y;
{
	FIXNUM iz;
	NUMBER dz;
	register struct object *z;

	x = numconv(x,"Difference");
	y = numconv(y,"Difference");
	if (!intp(x) || !intp(y)) {
		x = dubconv(x);
		y = dubconv(y);
	}
	if (intp(x)) {
		iz = (x->obint)-(y->obint);
		z = objint(iz);
	} else {
		dz = (x->obdub)-(y->obdub);
		z = objdub(dz);
	}
	mfree(x);
	mfree(y);
	return(localize(z));
}

struct object *mult(x,y)	/* product */
register struct object *x,*y;
{
	FIXNUM iz;
	NUMBER dz;
	register struct object *z;

	x = numconv(x,"Product");
	y = numconv(y,"Product");
	if (!intp(x) || !intp(y)) {
		x = dubconv(x);
		y = dubconv(y);
	}
	if (intp(x)) {
		iz = (x->obint)*(y->obint);
		z = objint(iz);
	} else {
		dz = (x->obdub)*(y->obdub);
		z = objdub(dz);
	}
	mfree(x);
	mfree(y);
	return(localize(z));
}

divzero(name)
char *name;
{
	pf1("%s can't divide by zero.\n",name);
	errhand();
}

struct object *div(x,y)	/* quotient */
register struct object *x,*y;
{
	NUMBER dz;

	x = numconv(x,"Quotient");
	y = numconv(y,"Quotient");
	x = dubconv(x);
	y = dubconv(y);
	if (y->obdub == 0.0) divzero("Quotient");
	dz = (x->obdub)/(y->obdub);
	mfree(x);
	mfree(y);
	if (dz == (NUMBER)(FIXNUM)dz) {
		return(localize(objint((FIXNUM)dz)));
	} else {
		return(localize(objdub(dz)));
	}
}

struct object *rem(x,y)	/* remainder */
register struct object *x,*y;
{
	FIXNUM iz;
	register struct object *z;

	x = numconv(x,"Remainder");
	y = numconv(y,"Remainder");
	if (!intp(x)) ungood("Remainder",x);
	if (!intp(y)) ungood("Remainder",y);
	if (y->obint == 0) divzero("Remainder");
	iz = (x->obint)%(y->obint);
	z = objint(iz);
	mfree(x);
	mfree(y);
	return(localize(z));
}

struct object *torf(pred)
int pred;
{
	if (pred) return(true());
	return(false());
}

struct object *greatp(x,y)	/* greaterp */
register struct object *x,*y;
{
	int iz;

	x = numconv(x,"Greaterp");
	y = numconv(y,"Greaterp");
	if (!intp(x) || !intp(y)) {
		x = dubconv(x);
		y = dubconv(y);
	}
	if (intp(x)) {
		iz = ((x->obint)>(y->obint));
	} else {
		iz = ((x->obdub)>(y->obdub));
	}
	mfree(x);
	mfree(y);
	return torf(iz);
}

struct object *lessp(x,y)	/* lessp */
register struct object *x,*y;
{
	int iz;

	x = numconv(x,"Lessp");
	y = numconv(y,"Lessp");
	if (!intp(x) || !intp(y)) {
		x = dubconv(x);
		y = dubconv(y);
	}
	if (intp(x)) {
		iz = ((x->obint)<(y->obint));
	} else {
		iz = ((x->obdub)<(y->obdub));
	}
	mfree(x);
	mfree(y);
	return torf(iz);
}

struct object *lmax(x,y)	/* maximum */
register struct object *x,*y;
{
	x = numconv(x,"Maximum");
	y = numconv(y,"Maximum");
	if (!intp(x) || !intp(y)) {
		x = dubconv(x);
		y = dubconv(y);
	}
	if (intp(x)) {
		if ((x->obint) > (y->obint)) {
			mfree(y);
			return(x);
		} else {
			mfree(x);
			return(y);
		}
	} else {
		if ((x->obdub) > (y->obdub)) {
			mfree(y);
			return(x);
		} else {
			mfree(x);
			return(y);
		}
	}
}

struct object *lmin(x,y)	/* minimum */
register struct object *x,*y;
{
	x = numconv(x,"Minimum");
	y = numconv(y,"Minimum");
	if (!intp(x) || !intp(y)) {
		x = dubconv(x);
		y = dubconv(y);
	}
	if (intp(x)) {
		if ((x->obint) < (y->obint)) {
			mfree(y);
			return(x);
		} else {
			mfree(x);
			return(y);
		}
	} else {
		if ((x->obdub) < (y->obdub)) {
			mfree(y);
			return(x);
		} else {
			mfree(x);
			return(y);
		}
	}
}

struct object *lnump(x)		/* LOGO numberp */
register struct object *x;
{
	if (x == 0) return(false());
	switch (x->obtype) {
		case CONS:
			mfree(x);
			return(false());
		case INT:
		case DUB:
			mfree(x);
			return(true());
		default:	/* case STRING */
			if (nump(x)) {
				mfree(x);
				return(true());
			} else {
				mfree(x);
				return(false());
			}
	}
}

struct object *lrandd()		/* random */
{
	register struct object *val;
	register temp;

	temp=(rand()/100)%10;
	val = objint((FIXNUM)temp);
	return(localize(val));
}

struct object *rnd(arg)
register struct object *arg;
{
	register temp;

	arg = numconv(arg,"Rnd");
	if(!isint(arg)) ungood("Rnd",arg);
	if ((arg->obint) <= 0) ungood("Rnd",arg);
	temp=rand() % (int)(arg->obint);
	mfree(arg);
	return(localize(objint((FIXNUM)temp)));
}

struct object *sq(arg)
register struct object *arg;
{
	NUMBER temp;

	arg = numconv(arg,"Sqrt");
	arg = dubconv(arg);
	temp = sqrt(arg->obdub);
	mfree(arg);
	return(localize(objdub(temp)));
}

struct object *lsin(arg)
register struct object *arg;
{
	NUMBER temp;

	arg = numconv(arg,"Sin");
	arg = dubconv(arg);
	temp = sin((3.1415926/180.0)*(arg->obdub));
	mfree(arg);
	return(localize(objdub(temp)));
}

struct object *lcos(arg)
register struct object *arg;
{
	NUMBER temp;

	arg = numconv(arg,"Cos");
	arg = dubconv(arg);
	temp = cos((3.1415926/180.0)*(arg->obdub));
	mfree(arg);
	return(localize(objdub(temp)));
}

struct object *lpow(x,y)
register struct object *x,*y;
{
	FIXNUM iz;
	NUMBER dz;
	register struct object *z;

	x = numconv(x,"Pow");
	y = numconv(y,"Pow");
	x = dubconv(x);
	y = dubconv(y);
	dz = pow((x->obdub),(y->obdub));
	iz = dz;	/* convert to integer for integerness test */
	if (dz == (NUMBER)iz)
		z = objint(iz);
	else 
		z = objdub(dz);
	mfree(x);
	mfree(y);
	return(localize(z));
}

struct object *latan(arg)
register struct object *arg;
{
	NUMBER temp;

	arg = numconv(arg,"Atan");
	arg = dubconv(arg);
	temp = (180.0/3.1415926)*atan(arg->obdub);
	mfree(arg);
	return(localize(objdub(temp)));
}

struct object *zerop(x)		/* zerop */
register struct object *x;
{
	register int iz;

	x = numconv(x,"Zerop");
	if (intp(x))
		iz = ((x->obint)==0);
	else
		iz = ((x->obdub)==0.0);
	mfree(x);
	return(torf(iz));
}

struct object *intpart(arg)
register struct object *arg;
{
	register FIXNUM result;

	arg = numconv(arg,"Int");
	if (intp(arg)) return(arg);
	result = arg->obdub;
	mfree(arg);
	return(localize(objint(result)));
}

struct object *round(arg)
register struct object *arg;
{
	register FIXNUM result;

	arg = numconv(arg,"Round");
	if (intp(arg)) return(arg);
	if (arg->obdub >= 0.0)
		result = arg->obdub + 0.5;
	else
		result = arg->obdub - 0.5;
	mfree(arg);
	return(localize(objint(result)));
}

struct object *toascii(arg)
register struct object *arg;
{
	register char *cp;
	char str[50];

	if (arg==0) ungood("Ascii",arg);
	switch(arg->obtype) {
		case CONS:
			ungood("Ascii",arg);
		case STRING:
			cp = arg->obstr;
			break;
		case INT:
			sprintf(str,FIXFMT,arg->obint);
			cp = str;
			break;
		case DUB:
			sprintf(str,"%g",arg->obdub);
			cp = str;
			break;
	}
	if (strlen(cp) != 1) ungood("Ascii",arg);
	mfree(arg);
	return(localize(objint((FIXNUM)((*cp)&0377))));
}

struct object *tochar(arg)
register struct object *arg;
{
	register int ichar;
	char str[2];

	arg = numconv(arg,"Char");
	if (intp(arg)) ichar = arg->obint;
	else ichar = arg->obdub;
	if ((ichar < 0) || (ichar > 255)) ungood("Char",arg);
	mfree(arg);
	str[0] = ichar;
	str[1] = '\0';
	return(localize(objcpstr(str)));
}
    