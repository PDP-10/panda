/* Property list primitives */

#include "logo.h"

#ifndef SMALL

struct property {
	char *prname;
	struct object *prvalue;
	struct property *prnext;
};

struct proplist {
	char *plname;
	struct property *props;
	struct proplist *plnext;
} *allprops = NULL;

struct proplist *findplist(var)
char *var;
{
	register struct proplist *plp;

	for (plp=allprops; plp; plp=plp->plnext)
		if (!strcmp(var,plp->plname)) return(plp);
	return(0);
}

struct property *findprop(prp,name)
register struct property *prp;
char *name;
{
	for (; prp; prp=prp->prnext)
		if (!strcmp(name,prp->prname)) return(prp);
	return(0);
}

pprop(name,prop,object)
struct object *name,*prop,*object;
{
	char *nstr;
	register struct proplist *plp;
	register struct property *prp,*prp1;

	if (!stringp(name)) ungood("Pprop",name);
	if (!stringp(prop)) ungood("Pprop",prop);
	if ((plp=findplist(token(name->obstr)))==0) {
		plp=(struct proplist *)ckmalloc(sizeof(struct proplist));
		nstr = ckmalloc(1+strlen(name->obstr));
		strcpy(nstr,token(name->obstr));
		plp->plname = nstr;
		plp->props = 0;
		plp->plnext = allprops;
		allprops = plp;
	}
	prp = plp->props;
	if (prp1 = findprop(prp,prop->obstr)) {
		lfree(prp1->prvalue);
	} else {
		prp1 = (struct property *)ckmalloc(sizeof(struct property));
		nstr = ckmalloc(1+strlen(prop->obstr));
		strcpy(nstr,token(prop->obstr));
		prp1->prname = nstr;
		prp1->prnext = prp;
		plp->props = prp1;
	}
	prp1->prvalue = globcopy(object);
	mfree(name);
	mfree(prop);
	mfree(object);
}

remprop(name,prop)
struct object *name,*prop;
{
	register struct proplist *plp;
	register struct property *prp,*prp1;

	if (!stringp(name)) ungood("Remprop",name);
	if (!stringp(prop)) ungood("Remprop",prop);
	if ((plp=findplist(token(name->obstr)))==0) {
		pf1("%p has no properties\n",name);
		errhand();
	}
	prp = plp->props;
	for (prp1=0; prp; prp=prp->prnext) {
		if (!strcmp(prp->prname,token(prop->obstr))) {
			if (prp1)
				prp1->prnext = prp->prnext;
			else
				plp->props = prp->prnext;
			JFREE(prp->prname);
			lfree(prp->prvalue);
			JFREE(prp);
			break;
		}
		prp1 = prp;
	}
	if (prp == 0) {
		pf1("%p has no %p property.\n",name,prop);
		errhand();
	}
	mfree(name);
	mfree(prop);
}

struct object *gprop(name,prop)
struct object *name,*prop;
{
	register struct proplist *plp;
	register struct property *prp,*prp1;

	if (!stringp(name)) ungood("Gprop",name);
	if (!stringp(prop)) ungood("Gprop",prop);
	if ((plp=findplist(token(name->obstr)))==0) {
		mfree(name);
		mfree(prop);
		return(0);
	}
	prp = plp->props;
	if (prp1 = findprop(prp,token(prop->obstr))) {
		mfree(name);
		mfree(prop);
		return(localize(prp1->prvalue));
	} else {
		mfree(name);
		mfree(prop);
		return(0);
	}
}

pps() {
	register struct proplist *plp;
	register struct property *prp;
	register char *name;

	for (plp=allprops; plp; plp=plp->plnext) {
		name = plp->plname;
		for (prp=plp->props; prp; prp=prp->prnext) {
			pf1("%s's %s is %p\n",name,prp->prname,prp->prvalue);
		}
	}
}

struct object *plist(name)
struct object *name;
{
	register struct proplist *plp;
	register struct property *prp;
	register struct object *tail;
	struct object *head;

	if (!stringp(name)) ungood("Plist",name);
	if ((plp=findplist(token(name->obstr)))==0) {
		mfree(name);
		return(0);
	}
	if ((prp = plp->props)==0) {
		mfree(name);
		return(0);
	}
	head = tail = glbcons(0,0);
	for (; prp; prp=prp->prnext) {
		tail->obcar = globcopy(objcpstr(prp->prname));
		tail->obcdr = globcopy(glbcons(0,0));
		tail = tail->obcdr;
		tail->obcar = globcopy(prp->prvalue);
		if (prp->prnext) tail->obcdr = globcopy(glbcons(0,0));
		else tail->obcdr = 0;
		tail = tail->obcdr;
	}
	mfree(name);
	return(localize(head));
}

#endif
