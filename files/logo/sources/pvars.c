/*	This file contains stuff about user procedure calls and
* variable assignment and lookup.
*
*	Copyright (C) 1979, The Children's Museum, Boston, Mass.
*	Written by Douglas B. Klunder
*/

#include "logo.h"
extern struct plist *pcell;
extern int *stkbase;
extern int stkbi;
extern int *newstk;
extern int newsti;
extern int argno;
extern int yylval;
extern int yychar;
extern short yyerrflag;
static struct alist *globvars;
extern struct stkframe *fbr;
extern struct plist *proclist;
extern struct alist *locptr;
extern struct alist *newloc;

struct alist *loclk1();
struct alist *look1();
struct object *look();

go(linenum)	/* LOGO go */
register struct object *linenum;
{
	register struct lincell *lptr;
	register numline;

	if (pcell==NULL) {	/* not in procedure */
		printf("Go can only be used within a procedure.\n");
		errhand();
	}
	linenum = numconv(linenum,"Go");
	if (!intp(linenum)) ungood("Go",linenum);
	numline = linenum->obint;
	mfree(linenum);
/*	Search for saved line no. */
	for (lptr=pcell->plines;lptr;lptr=lptr->nextline) {
		if (lptr->linenum==numline)
		{	/* line found, so adjust pseudo-code
			* pointers to continue execution at
			* right place
			*/
			stkbase=lptr->base;
			stkbi=lptr->index;
			return;
		}
	}
	/* no match */
	printf("There is no line %d.\n",numline);
	errhand();
}

char *lowcase(name)
register char *name;
{
	static char result[100];
	register char c,*str;

	str = result;
	while (c = *name++) {
		if (c >= 'A' && c <= 'Z') c += 040;
		*str++ = c;
	}
	*str = '\0';
	return(result);
}

struct object *lnamep(name)	/* namep */
register struct object *name;
{	/* check for both local and global definitions */
	register char *nstr;

	if (!stringp(name)) ungood("Namep",name);
	nstr = lowcase(name->obstr);
	if (loclk1(nstr) || look1(nstr)) {
		mfree(name);
		return(true());
	}
	mfree(name);
	return(false());
}

loccreate(varname,lptr)		/* create new local variable cell, with name
				* but without value */
register struct object *varname;
register struct alist **lptr;
{
	register struct alist *temp1,*temp2;
	char ch,*str;

	if (pcell==NULL) {	/* not in procedure */
		printf("Local can only be used within a procedure.\n");
		errhand();
	}
	if (!stringp(varname)) ungood("Local",varname);
	str = lowcase(varname->obstr);
	if ((ch = str[0]) == '\0') {
		printf("Variable name can't be empty.\n");
		errhand();
	}
	if (ch<'a' || ch>'z') {
		printf("Variable name %s must start with a letter.\n",
				varname->obstr);
		errhand();
	}
	if (*lptr==NULL) {	/* first cell */
		*lptr=(temp1=(struct alist *)ckzmalloc(sizeof(*temp1)));
	} else {
		for (temp1= *lptr;temp1;temp1=temp1->next) {
			if (!strcmp(temp1->name->obstr,str))
			{	/* name already present */
				nputs(varname->obstr);
				printf(" is already defined as a local variable.\n");
				errhand();
			}
			temp2=temp1;
		}
		/* create new cell at end of string */
		temp2->next=(struct alist *)ckzmalloc(sizeof(*temp2));
		temp1=temp2->next;
	}
	temp1->next=NULL;
	temp1->name=globcopy(objcpstr(str));
	temp1->val=(struct object *)-1;
	lfree(varname);
}

struct object *cmlocal(arg)
struct object *arg;
{
	loccreate(globcopy(arg),&locptr);
	mfree(arg);
	return ((struct object *)(-1));
}

struct alist *loclk2(str,lap)	/* look for local definition of variable
				* return cell pointer if found */
		/* BH 5/19/81 was loclk1 but now subprocedure */
register char *str;
register struct alist *lap;
{
	while (lap) {
		if (!strcmp(str,lap->name->obstr)) return(lap);
		lap=lap->next;
	}
	return(NULL);
}

struct alist *loclk1(str)	/* look for local definition of variable
				 * WITH DYNAMIC SCOPE!! BH 5/19/81 */
register char *str;
{
	register struct stkframe *skp;
	register struct alist *lap;

	if (lap = loclk2(str,locptr)) return(lap);
		/* found in innermost active procedure */
	for (skp = fbr; skp; skp = skp->prevframe) {
		/* else try other active procedures */
		if (skp->loclist)
			if ((lap = loclk2(str,skp->loclist)) != NULL)
				return(lap);
	}
	return(NULL);
}

struct object *alllk(str)	/* return value of variable */
register struct object *str;
{	/* look both locally and globally */
	register struct alist *ap;
	register char *strnm;

	if (!stringp(str)) ungood("Thing",str);
	strnm = lowcase(str->obstr);
	if ((ap=loclk1(strnm))==NULL) return(look(str));
	if (ap->val==(struct object *)-1) {
		nputs(strnm);
		puts(" has no value.");
		errhand();
	}
	mfree(str);
	return(localize(ap->val));
}

newfr()		/* create new stack frame to accommodate procedure */
{
	register int *temp;

	temp=(int *)ckmalloc(PSTKSIZ*sizeof(int));
	*temp=(int)newstk;
	*(newstk+PSTKSIZ-1)=(int)temp;
	newstk=temp;
	newsti=1;
}

struct plist *proclook(name)	/* check if procedure already in memory */
register char *name;
{
	register struct plist *here;

	for (here=proclist;here;here=here->after)
		if (!strcmp(name,here->procname->obstr)) return(here);
	return(NULL);
}

argassign(argval)	/* assign value to next unfilled input */
register struct object *argval;
{
	register struct alist *temp1;

	for (temp1=newloc;temp1->val!=(struct object *)-1;temp1=temp1->next) {
		if (!stringp(temp1->name)) {
			printf("Argassign bug trap, newloc messed up.\n");
			return;
		}
	}
	temp1->val=globcopy(argval);
	mfree(argval);
	if (--argno==0) {	/* all inputs filled, so save unparsed token */
		fbr->oldyyl=yylval;
		fbr->oldyyc=yychar;
		if (yyerrflag) return;
		yychar= -1;
	}
}

assign(name,val)	/* make */
register struct object *name,*val;
{
	register struct alist *ap;
	register char *namestr;
	char *tmp,ch;

	if (!stringp(name)) ungood("Make",name);
	namestr = lowcase(name->obstr);
	for(tmp=namestr;*tmp;tmp++){
		if((*tmp<'a' || *tmp>'z') && (*tmp <'0' || *tmp>'9')
				&& (*tmp != '.') && (*tmp != '_')) {
			pf1("Cannot assign value to %l\n",name);
			errhand();
		}
	}
	if ((ap=loclk1(namestr))) {	/* local definition */
		if (ap->val != (struct object *)-1) lfree(ap->val);
		mfree(name);
		ap->val=globcopy(val);
		mfree(val);
		return;
	}
	else if ((ap=look1(namestr))==0)
	{	/* new variable, so allocate cell */
		if ((ch = namestr[0]) == '\0') {
			printf("Variable name can't be empty.\n");
			errhand();
		}
		if (ch<'a' || ch>'z') {
			printf("Variable name %s must start with a letter.\n",
					namestr);
			errhand();
		}
		ap=(struct alist *)ckmalloc(sizeof(*ap));
		ap->name = globcopy(objcpstr(namestr));
		ap->next=globvars;
		globvars=ap;
		mfree(name);
	} else {	/* old global definition */
		lfree(ap->val);
		mfree(name);
	}
	ap->val=globcopy(val);
	mfree(val);
}

struct object *look(str)	/* return value of globally defined variable */
register struct object *str;
{
	register struct alist *ap;
	register char *strtxt;

	if (!stringp(str)) ungood("Thing",str);
	strtxt = lowcase(str->obstr);
	ap=look1(strtxt);
	if (ap==NULL) {
		nputs(strtxt);
		printf(" has no value.\n");
		errhand();
	}
	mfree(str);
	return(localize(ap->val));
}

struct alist *look1(str)	/* return pointer to right variable cell */
register char *str;
{
	register struct alist *ap;

	for(ap=globvars; ap != 0; ap=ap->next)
		if (!strcmp(str,ap->name->obstr)) return(ap);
	return(0);
}
