/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* Insertion routines */

#include "domsym.h"

/* insert.c */
int insert(struct btnode **,char *,struct rr *,int,int);

/* insert.c */
static int bcomp(int,char *,int ,char *);
static cmerge(struct rr *);



static int bcomp(i1,s1,i2,s2)
    int i1,i2;
    char *s1,*s2;
{
    if((i2 -= i1) != 0)
	return(i2);
    while(--i1 >= 0)
	if((i2 = *s2++ - *s1++) != 0)
	    return(i2);
    return(0);
}

/* insert(tree,name,rr,offset,mergep) -- insert an RR into a domain tree. */

#define punt(msg) return(bugchk("insert",msg),0)

int insert(tree,name,r,offset,mergep)
    struct btnode **tree;
    char *name;
    struct rr *r;
    int offset;
    int mergep;
{
    int i;
    char *vector[MAX_DOMAIN_TAG_COUNT+1];
    struct btnode *where = NULL;

    if(DBGFLG(DBG_INSERT))
	buginf("insert","tree=%o[%o], name=\"%.*s\"[%o], r=%o, offset=%d",
		(int)tree,(int)(*tree),*name,name+1,(int)name,(int)r,offset);

    if((i = namexp(name,vector) - offset) < 1)
	punt("too few tags (may be misplaced glue RR)");
    while(--i >= 0) {
#if 0					/* IMR lossage, fix if matters */
	if(DBGFLG(DBG_INSERT))
	    buginf("insert","tree=%o, *tree=%o, key[%d]=\"%.*s\", where=%o",
		    (int)tree,(int)(*tree),i,*(vector[i]),(vector[i])+1,(int)where);
#endif
	avladd(tree, vector[i], (i == 0 ? r : NULL), &where);
	tree = &(where->data.link.tpoint);
    }
    if(mergep)				/* Compress out RRs that differ only by */
	cmerge(where->data.data.rrs);	/* TTL value (cache tree, presumably) */
    if(DBGFLG(DBG_INSERT))
	buginf("insert","where=%o, tree=%o",(int)where,(int)tree);
    return(1);
}
#undef punt

/* cmerge(list) -- eliminate RRs that differ only by TTL */

static cmerge(list)
    struct rr *list;
{
    struct rr **p,*r;
    char *fmt;
    int same, i;

    for(; list != NULL; list = list->chain) {
	fmt = rrfmt(list->class,list->type);
	p = &(list->chain);
	while((r = *p) != NULL) {
	    same = (r->class == list->class && r->type  == list->type);
	    for(i = 0; same && fmt[i] != '\0'; ++i)
		switch(fmt[i]) {
		    case 'd':
			same &= namcmp(r->rdata[i].byte,list->rdata[i].byte) == 0;
			continue;
		    case 's':
			same &= bcomp(*(r->rdata[i].byte),    (r->rdata[i].byte)+1,
				      *(list->rdata[i].byte), (list->rdata[i].byte)+1) == 0;
			continue;
		    case '4':   case '2':	case 'i':   case 'c':
			same &= r->rdata[i].word == list->rdata[i].word;
			continue;
		    case 'w':
			same &= bcomp(IN_WKS_TOTAL_LENGTH, r->rdata[i].byte,
				      IN_WKS_TOTAL_LENGTH, list->rdata[i].byte,0) == 0;
			continue;
		    default:
			bugchk("cmerge","unknown rrfmt() code '%c'",fmt[i]);
			same = 0;
		}
	    if(!same)
		p = &(r->chain);
	    else {
		*p = r->chain;
		if(r->ttl > list->ttl)
		    list->ttl = r->ttl;
		r->chain = NULL;
		kil_rr(r);
	    }
	}
    }
}

