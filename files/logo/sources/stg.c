#include "logo.h"

extern struct object *allocstk[];

char *ckmalloc(size)
int size;
{
	register char *block;
	extern char *malloc();

	block = malloc(size);
	if (block==0) {
		printf("No more memory, sorry.\n");
		errhand();
	}
#ifdef DEBUG
	if (memtrace) {
		printf("Malloc size=%d loc=0%o\n",size,block);
	}
#endif
	return(block);
}

char *ckzmalloc(size)
int size;
{
	register char *block;
	register int *ip;

	block = ckmalloc(size);
	for (ip = (int *)block; (char *)ip < block+size; )
		*ip++ = 0;
	return(block);
}

mfree(ptr)	/* free allocated space, allowing another chunk to be */
register struct object *ptr;
{
	register struct object **i;

#ifdef DEBUG
	if(ptr==(struct object *)-1) {
		puts("mfree of -1");
		return;
	}	/* BH 3/5/80 bug trap */
#endif
	if (ptr==0) return; /* BH 3/5/80 this is ok */
	for (i = allocstk; i < &allocstk[MAXALLOC]; i++)
		if (*i == ptr) break;
#ifdef DEBUG
	if (*i != ptr) {
		pf1("Trying to mfree nonlocal at 0%o val=%p\n",ptr,ptr);
		return;
	}
	if (memtrace)
		pf1("\nMfree entry=%d loc=0%o val=%p\n",i,ptr,ptr);
#endif
	*i = 0;
	lfree(ptr);
}

lfree(ptr)
register struct object *ptr;
{
#ifdef DEBUG
	if(ptr== (struct object *)-1){
		puts("lfree of -1");
		return;
	}
#endif
	if(ptr==0) return;
	if (--(ptr->refcnt) > 0) return;
#ifdef DEBUG
	if ((ptr->refcnt) < 0) {
		printf("Trying to lfree negative refcnt, loc=0%o\n",
				ptr);
		return;
	}
	if (memtrace) {
		(ptr->refcnt)++;
		pf1("\nLfree loc=0%o val=%p\n",ptr,ptr);
		(ptr->refcnt)--;
	}
#endif
	if (listp(ptr)) {
		lfree(ptr->obcar);
		lfree(ptr->obcdr);
	}
	if (stringp(ptr)) {
#ifdef DEBUG
		if (memtrace)
			printf("Lfree frees string %s at 0%o\n",
					ptr->obstr,ptr->obstr);
#endif
		free(ptr->obstr);
	}
	free(ptr);
}

#ifdef SMALL
/* In small Logo, refcnts are chars.  Make an actual copy for things with
 * lots of references, which should be rare. */
struct object *realcopy(old)
register struct object *old;
{
	register struct object *new;

	new = (struct object *)ckmalloc(sizeof(struct object));
	new->obtype = old->obtype;
	new->refcnt = 0;
	switch (new->obtype) {
		case CONS:
			new->obcar = globcopy(old->obcar);
			new->obcdr = globcopy(old->obcdr);
			break;
		case INT:
			new->obint = old->obint;
			break;
		case DUB:
			new->obdub = old->obdub;
			break;
		default:	/* STRING */
			new->obstr = ckmalloc(1+strlen(old->obstr));
			strcpy(new->obstr,old->obstr);
	}
	return(new);
}
#endif

struct object *localize(new)
register struct object *new;
{
	register struct object **i;

	if (new==0) return(0);
	for (i = allocstk; i < &allocstk[MAXALLOC]; i++)
		if (*i == 0) break;
	if (*i != 0) {
		puts("I can't remember everything you have told me.");
		puts("Please enter less complex instructions.");
		errhand();
	}
#ifdef SMALL
	if (new->refcnt == 127) new = realcopy(new);
#endif SMALL
	*i = new;
	new->refcnt++;
	return(new);
}

struct object *globcopy(obj)
register struct object *obj;
{
	if (obj==0) return(0);
#ifdef SMALL
	if (obj->refcnt == 127) obj = realcopy(obj);
#endif SMALL
	obj->refcnt++;
	return(obj);
}

struct object *glbcons(first,rest)
register struct object *first,*rest;
{
	register struct object *new;

	new = (struct object *)ckmalloc(sizeof(struct object));
	new->obtype = CONS;
	new->refcnt = 0;
	new->obcar = globcopy(first);
	new->obcdr = globcopy(rest);
	return(new);
}

struct object *loccons(first,rest)
struct object *first,*rest;
{
	return(localize(glbcons(first,rest)));
}

struct object *objstr(string)
register char *string;
{
	register struct object *new;

	new = (struct object *)ckmalloc(sizeof(struct object));
	new->obtype = STRING;
	new->refcnt = 0;
	new->obstr = string;
	return(new);
}

struct object *objcpstr(string)
register char *string;
{
	register struct object *new;
	register char *newstr;

	newstr = ckmalloc(strlen(string)+1);
	strcpy(newstr,string);
	new = (struct object *)ckmalloc(sizeof(struct object));
	new->obtype = STRING;
	new->refcnt = 0;
	new->obstr = newstr;
	return(new);
}

struct object *objint(num)
FIXNUM num;
{
	register struct object *new;

	new = (struct object *)ckmalloc(sizeof(struct object));
	new->obtype = INT;
	new->refcnt = 0;
	new->obint = num;
	return(new);
}

struct object *objdub(num)
NUMBER num;
{
	register struct object *new;

	new = (struct object *)ckmalloc(sizeof(struct object));
	new->obtype = DUB;
	new->refcnt = 0;
	new->obdub = num;
	return(new);
}

struct object *bigsave(string)
register char *string;
/* used by stringform to get an extra null at the end, kludge */
/* Note -- returned object is localized! */
{
	register char *newstr;
	register struct object *newobj;

	newstr = ckmalloc(2+strlen(string));
	strcpy(newstr,string);
	newobj = (struct object *)ckmalloc(sizeof(struct object));
	newobj->obtype = STRING;
	newobj->refcnt = 0;
	newobj->obstr = newstr;
	return(localize(newobj));
}
