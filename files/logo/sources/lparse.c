#include "logo.h"
extern int multnum,endflag,rendflag,topf,traceflag;
extern char ibuf[];
extern char *ibufptr, *getbpt, charib;
extern int letflag,pflag;
#ifdef PAUSE
extern int pauselev;
#endif
extern FILE *pbuf;
extern struct lexstruct keywords[];
extern struct alist *locptr;
extern struct runblock *thisrun;
extern t20save();
extern t20restore();

struct object *makeword(c)
int c;
{
	register struct object* obj;
	register char *s;
	char str[100];

	s=str;
	do {
		if (c == '\\') c = getchar()|0200;
		else if (c == '%') c = ' '|0200;
		*s++ = c;
	} while((c=getchar())>0 && !index(" \t\n[]",c));
	if (c<=0) {
		printf("Unmatched [ in procedure.\n");
		errhand();
	}
	charib = c;
	*s = '\0';
	obj = objcpstr(str);
	if (nump(obj)) {
		obj = numconv(localize(obj),"!makeword");
		mfree(globcopy(obj));	/* unlocalize */
		return(obj);
	}
	return(globcopy(obj));
}

struct object *makel1()
{
	register struct object *head,*tail;
	register c,cnt;

	while ((c=getchar())==' ' || c=='\t' || c=='\n') ;
	if(c==']') {
		charib = c;
		return ((struct object *)0);
	}
	if (c<=0) {
		printf("Unmatched [ in procedure.\n");
		errhand();
	}
	head = (struct object*)ckmalloc(sizeof(struct object));
	tail = head;
	cnt = 0;
	head->obtype = CONS;
	head->refcnt = 0;
	head->obcdr = 0;
loop:
	if (c=='[') {
		tail->obcar = globcopy(makel1());
		getchar();	/* gobble the peeked close bracket */
	} else {
		tail->obcar = makeword(c);
		/* This used to use charib instead of passing the char as
		 * an argument, but that loses if the first char of a word
		 * is backslash, in which case something is already in
		 * charib from getchr1. */
	}
	while ((c=getchar())==' ' || c=='\t' || c=='\n') ;
	if (c==']') {
		charib = c;
		return (head);
	}
	if (c<=0) {
		printf("Unmatched [ in procedure.\n");
		errhand();
	}

	tail->obcdr = (struct object*)ckmalloc(sizeof(struct object));
	tail = tail->obcdr;
	tail->obtype = CONS;
	tail->refcnt = 1;
	tail->obcdr = 0;

	goto loop;
}

struct object *makelist()
{
	return(localize(makel1()));
}

#ifdef DEBUG
getchr1()
#else
getchar()
#endif
{
	FAST c;

	if (charib) {
		c=charib;
		charib=0;
		return(c);
	}
	else if (pflag==1) {
		while ((c=getc(pbuf))=='\r')
			;
		if (c=='\\' && letflag!=1) {	/* continuation line feature */
			c=getc(pbuf);
			if (c=='\n') c=getc(pbuf);
			else {
				charib = c;
				c = '\\';
			}
		}
		if (!letflag && c>='A' && c<='Z') c+= 32;
		return(c);
	}
	else if (getbpt) {	/* BH 5/19/81 moved down below pflag test */
		c = *getbpt++;
		if (c) return (c);
		if (!thisrun) {
			getbpt = 0;
			return('\n');
		}	/* startup file feature */
		--getbpt;
		if (--(thisrun->rcount) <= 0) {
			if (!rendflag) rendflag = 1;	/* BH 3/17/83 */
			return(0);
		} else {
			rerun();
			return('\n');
		}
	}
	else if (ibufptr==NULL) {
	rebuff:
		if ((c=read(0,ibuf,IBUFSIZ))==IBUFSIZ)
			if (ibuf[IBUFSIZ-1]!='\n') {
				while (read(0,ibuf,IBUFSIZ)==IBUFSIZ)
					if (ibuf[IBUFSIZ-1]=='\n') break;
				puts("Your line is too long.");
				errhand();
			}
		if (c<0) {
			/* Error return from read.  Probably signal. */
			return ('\n');
		}
		if (c==0) {
			/* Not clear what's right for EOF.  I'd just ignore it
			   only what if stdin is a file, we'll loop forever.
			   Compromise: if we're paused, don't lose the valuable
			   context with a keystroke, otherwise, exit. */
#ifdef PAUSE
			if (pauselev) return('\n');
#endif
			leave(3);
		}
		ibufptr=ibuf;
	}
	c= *ibufptr++;
	if (c=='\\' && letflag!=1) {	/* continuation line feature */
		c = *ibufptr++;
		if (c=='\n') {
			ibufptr=NULL;
			goto rebuff;	/* sorry, Jay */
		} else {
			charib = c;
			c = '\\';
		}
	}
	if (!letflag && c>='A' && c<='Z') c+=32;
	if (c=='\n') ibufptr=NULL;
	return(c);
}

#ifdef DEBUG
getchar()
{	/* BH 3/23/80 debugging echo output */
	register c;

	c = getchr1();
	if (memtrace) putchar(c);
	return(c);
}
#endif

struct object *multiop(op,args)
register op;
register struct object *args;
{
	extern struct object *list();

	if (keywords[op].lexval==list) return (localize(args));
	else if (multnum<2) {
		nputs(keywords[op].word);
		puts(" needs at least two inputs.");
		errhand();
	} else if (multnum==2)
		return ((*keywords[op].lexval)(localize(args->obcar),
			  localize(args->obcdr->obcar)));
	else {
		multnum--;
		return ((*keywords[op].lexval)(localize(args->obcar),
			  multiop(op,args->obcdr)));
	}
}

struct object *pots()
{
	register f;

	if (f=fork()) while (wait(0)!=f) ;
	else {
		t20save();
		system(POTSCMD);
		t20restore();
		exit(0);
	}
	return((struct object *)-1);
}

lbreak() {
#ifdef PAUSE
	if (!pflag && thisrun && thisrun->str==(struct object *)(-1))
		unpause();
#endif
	if (!pflag && thisrun) {
		rendflag = 1;	/* BH 3/17/83 */
		if (thisrun->rprev && !(thisrun->svpflag)) rendflag++;
	}
}

lstop() {
	endflag = 1;
#ifdef PAUSE
	if (!pflag && thisrun && thisrun->str==(struct object *)(-1))
		unpause();
#endif
	if (!pflag && thisrun) rendflag = 3;	/* BH 3/17/83 */
}

ltopl() {
	topf=1;
	errwhere();
	errzap();
	leave(1);
}

lbyecom() {
	leave(3);
}

ltrace() {
	traceflag = 1;
}

luntrace() {
	traceflag = 0;
}
