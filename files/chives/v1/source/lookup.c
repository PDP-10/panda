/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* look up a name in the database */

#include "domsym.h"
#include "usrdef.h"

/* match.c */
extern int cmatch(int,int );
extern int tmatch(int,int );

/* tim20x.c */
extern int zulu(void);

/* lookup.c */
static int clook(struct btnode *,struct btnode *,char **,int,int,int ,
		int ,int,struct rr **,struct rr **,int *,struct rr **,int *);

static char star_tag[] = { 1, '*' };

/* Binary search a table of (struct domain)s */

static struct domain *bsearch(array,key)
    struct domain array[];
    char *key;
{
    int lo = 0, mid, hi = array->data.count+1, cmp;
    if(array == NULL)
	return(NULL);
#if 0					/* generates lots of output, */
    if(DBGFLG(DBG_LOOKUP))		/* not needed for anything but */
	for(mid = 1; mid < hi; ++mid)	/* major lossage */
	    buginf("bsearch","key=\"%.*s\", {%o}[%d].name=\"%.*s\"",
		    *key,key+1,array,mid,*(array[mid].name),(array[mid].name)+1);
#endif
/* This loop should be cleaned up once it's debugged. */
    for(;;) {
	mid = (lo+hi)/2;
	if(DBGFLG(DBG_LOOKUP))
	    buginf("bsearch","array=%o, key=\"%.*s\", count=%d, lo=%d, hi=%d, array[%d].name=\"%.*s\"",
		    (int)array,*key,key+1,array->data.count,lo,hi,mid,*(array[mid].name),(array[mid].name)+1);
	if(mid == lo)
	    break;
	if((cmp = tagcmp(key,array[mid].name)) == 0)
	    return(&array[mid]);
	else if(cmp < 0)
	    hi = mid;
	else
	    lo = mid;
    }
    return(NULL);
}

/* analyze an RR chain, return pointers to interesting rrs */

static void analyze(node,qclass,qtype,qtime,data_p,ns_p,cname_p)
    struct domain *node;
    int qclass,qtype,qtime;
    struct rr **data_p, **ns_p, **cname_p;
{
    struct rr *r;
    *data_p = *ns_p = *cname_p = NULL;
    if(node == NULL)
	return;
    if(DBGFLG(DBG_LOOKUP))
	buginf("analyze","node->name=\"%.*s\", qclass=%s, qtype=%s, qtime=%d",
		*(node->name), (*(node->name) ? (node->name)+1 : ""),
		looktb(qc_table,qclass),looktb(qt_table,qtype),qtime);
    for(r = node->data.rrs;  r != NULL;  r = r->chain) {
	if(DBGFLG(DBG_LOOKUP))
	    buginf("analyze","r=%o, r->ttl=%d, r->class=%s, r->type=%s",
		  r,r->ttl,looktb(qc_table,r->class),looktb(qt_table,r->type));
	if(qtime > r->ttl || !cmatch(qclass,r->class))
	    continue;
	if(*data_p == NULL && tmatch(qtype,r->type))
	    *data_p = r;
	if(*ns_p == NULL && r->type == QT_NS)
	    *ns_p = r;
	if(*cname_p == NULL && r->type == QT_CNAME)
	    *cname_p = r;
    }
    if(DBGFLG(DBG_LOOKUP))
	buginf("analyze","*data_p=%o, *ns_p=%o, *cname_p=%o",
		*data_p,*ns_p,*cname_p);
    return;
}


/*
 * Make an answer (or delegation) result chain.
 * Returns consed RRs, but the rdatoms are pointers into
 * the database.  Be careful....
 */

void mak_answer(result,list,qclass,qtype,qtime)
    struct rr **result, *list;
    int qclass,qtype,qtime;
{

    for( ; list != NULL; list = list->chain)
	if(qtime < list->ttl && cmatch(qclass,list->class)
			     && tmatch(qtype,list->type)) {
	    struct rr *r = mak_rr();
	    *r = *list;
	    r->chain = *result;
	    *result = r;
	}
    return;
}

/*
 * Cleanup functions so that caller needn't worry about which
 * parts of the data are consed and which are pointers.
 */

static void kil_ranswer(r)
    struct rr *r;
{
    while(r != NULL) {
	struct rr *t = r;
	r = r->chain;
	kil_(t);
    }
}

void kil_answer(d)
    struct domain *d;
{
    while(d != NULL) {
	struct domain *t = d;
	d = d->link.dpoint;
	if(t->name != NULL)
	    kil(t->name);
	kil_ranswer(t->data.rrs);
	kil_(t);
    }
}


/*
 * zlook() -- look in a particular authoritative zone.  Hairy, due to
 * strange database semantics.  See RFC973 pp 2->3, "* semantics" &
 * "CNAME usage".
 *
 * Returns error code (see USRDEF.D) indicating degree of lossage.
 */

static int zlook(z,vector,idx,qclass,qtype,qtime,want_del,
	    result,del_ptr,del_idx,cname_ptr,cname_idx)
    struct zone *z;			/* zone we're looking at */
    char **vector;			/* tag vector */
    int idx;				/* index at zone base */
    int qclass,qtype,qtime;		/* class,type, time of query */
    int want_del;			/* whether we want delegation */
    struct rr **result;			/* result chain */
    struct rr **del_ptr;		/* delegation */
    int *del_idx;
    struct rr **cname_ptr;		/* rename */
    int *cname_idx;
{
    struct domain *d, *node = &(z->base), *prev = NULL;
    struct rr *data_p, *ns_p, *cname_p;
    int glue = 0;			/* not into glue RRs yet */

    /*
     * Turn query time into delta from zone obtain time.
     * If obtain time is zero, this zone is local and has infinite timeouts.
     */
#ifdef RWF
    qtime = (z->gotten == 0) ? 0 : qtime - z->gotten;
#else
    qtime = 0;				/* Needs more thought */
#endif

    /* Parse down till matched all tags or out of tree */
    while(--idx >= 0 && (d = bsearch(node->link.dpoint,vector[idx])) != NULL) {
	struct rr *r;
	if(prev != NULL)		/* NS at base node is not delegation */
	    for(r = d->data.rrs; r != NULL && !glue; r = r->chain)
		if(r->type == QT_NS)	/* Detect delegations */
		    glue = 1;
	prev = node;
	node = d;
    }
    if(DBGFLG(DBG_LOOKUP))
	buginf("zlook","idx=%d, node=%o, &(z->base)=%o, glue=%d",
		idx, (int)node, (int)(&(z->base)), glue);
    analyze(node,qclass,qtype,qtime,&data_p,&ns_p,&cname_p);
    if(idx >= 0) {
	data_p = NULL;
	cname_p = NULL;
    }
    if(DBGFLG(DBG_LOOKUP))
	buginf("zlook","analyze #1: data_p=%o, ns_p=%o, cname_p=%o",
		data_p,ns_p,cname_p);

    /*
     * Hairy "*" node twiddling.
     * If got right name but no RRs, check for "*" with right RRs at same
     * level as this node ("single known label in query name").
     * If not right name, try for "*" child ("unknown labels").
     * In either case, replace current node if "*" node is better.
     * Note that any NS RRs at original node invalidate "*" stuff.
     */
    if(data_p == NULL && ns_p == NULL && cname_p == NULL
      && (d = (idx >= 0) ? node : prev) != NULL
      && (d = bsearch(d->link.dpoint,star_tag)) != NULL) {
	struct rr *junk;		/* NB: Don't allow a delegation! */
	analyze(d,qclass,qtype,qtime,&data_p,&junk,&cname_p);
	if(DBGFLG(DBG_LOOKUP))
	    buginf("zlook","analyze #2: data_p=%o, cname_p=%o",
		    data_p,cname_p);
	if(data_p != NULL)
	    idx = -1;			/* Flag that we won */
    }

    /* If above nonsense found what user wanted, return it. */
    if(data_p != NULL) {
	mak_answer(result,data_p,qclass,qtype,qtime);
	return(UE_OK);			/* Name ok */
    }

    /* Maybe found CNAME?  Doesn't count for class "*", too hairy. */
    if(cname_p != NULL && qclass != QC_ANY) {
	*cname_ptr = cname_p;
	*cname_idx = (idx < 0) ? 0 : idx;
	return(UE_OK);			/* Name ok */
    }

    /* Maybe found delegation? */
    if(want_del && ns_p != NULL) {
	mak_answer(del_ptr,ns_p,qclass,QT_NS,qtime);
	*del_idx = idx;
	return(UE_OK);			/* Name ok */
    }

    /* No RRs to return.  Error unless class = "*" or into the glue RRs. */
    return(qclass == QC_ANY || glue ? UE_OK : idx < 0 ? UE_NRR : UE_NAM);
}


/*
 * clook() -- look in the cache.  Much simpler than zone search (yay).
 *
 * We can now get hard errors via the negative cache, so we return
 * a code like zlook().
 */

static int clook(cache,ncache,vector,idx,qclass,qtype,qtime,want_del,
	    result,del_ptr,del_idx,cname_ptr,cname_idx)
    struct btnode *cache;		/* cache tree */
    struct btnode *ncache;		/* negative cache tree */
    char **vector;			/* tag vector */
    int idx;				/* tag index */
    int qclass,qtype,qtime;		/* class,type, time of query */
    int want_del;			/* do we want delegation? */
    struct rr **result;			/* result chain */
    struct rr **del_ptr;		/* delegation */
    int *del_idx;
    struct rr **cname_ptr;		/* rename */
    int *cname_idx;
{

    struct rr *data_p, *ns_p, *cname_p;
    struct rr *last_del_ptr = NULL, *last_cname_ptr = NULL;
    int last_del_idx, last_cname_idx, saved_idx = idx;

    /* Parse down till matched all tags or out of tree */
    while(--idx >= 0 && cache != NULL) {
	struct btnode *t = avlook(cache,vector[idx]);
	if(t == NULL)
	    break;
	cache = t->data.link.tpoint;
	analyze(&(t->data),qclass,qtype,qtime,&data_p,&ns_p,&cname_p);
	if(cname_p != NULL) {
	    last_cname_ptr = cname_p;
	    last_cname_idx = idx;
	}
	if(ns_p != NULL) {
	    last_del_ptr = ns_p;
	    last_del_idx = idx;
	}
    }

    if(idx < 0 && data_p != NULL) {
	mak_answer(result,data_p,qclass,qtype,qtime);
	if(DBGFLG(DBG_LOOKUP))
	    buginf("clook","taking ANSWER, vector[%d]=\"%.*s\"",
		    idx,*(vector[idx]),(vector[idx])+1);
	return(UE_OK);
    }
    if(last_cname_ptr != NULL) {
	/*
	 * Gee, I wish I I could remember why this case is handled
	 * differently from the other two....
	 */
	*cname_idx = last_cname_idx;
	*cname_ptr = last_cname_ptr;
	if(DBGFLG(DBG_LOOKUP))
	    buginf("clook","taking CNAME, vector[%d]=\"%.*s\"",
		idx,*(vector[idx]),(vector[idx])+1);
	return(UE_OK);
    }
    if(ncache != NULL) {		/* negative cache to examine */
	struct rr *r = NULL;
	int idx = saved_idx;
	if(DBGFLG(DBG_LOOKUP))
	    buginf("clook","checking negative cache");
	while(--idx >= 0 && ncache != NULL) {
	    struct btnode *t = avlook(ncache,vector[idx]);
	    if(t == NULL)
		break;
	    ncache = t->data.link.tpoint;
	    r = t->data.data.rrs;
	}
	if(idx < 0)			/* Exact match for name */
	    for( ; r != NULL; r = r->chain) /* Look for relevant "RR" */
		if(qtime <= r->ttl && qclass == r->class)
		    switch(r->rdata[NCACHE_ERRCODE].word) {
			case UE_NRR:	/* NB: arg order on next line */
			    if(!tmatch(r->type,qtype)) /* intentional */
				break;
			case UE_NAM:
			    if(DBGFLG(DBG_LOOKUP))
				buginf("clook","taking neg cache");
			    return(r->rdata[NCACHE_ERRCODE].word);
		    }
    }
    if(want_del && last_del_ptr != NULL) {
	mak_answer(del_ptr,last_del_ptr,qclass,QT_NS,qtime);
	*del_idx = last_del_idx;
	if(DBGFLG(DBG_LOOKUP))
	    buginf("clook","taking DELEGATION, vector[%d]=\"%.*s\"",
		idx,*(vector[idx]),(vector[idx])+1);
	return(UE_OK);
    }
    if(DBGFLG(DBG_LOOKUP))
	buginf("clook","struck out, vector[%d]=\"%.*s\"",
		idx,*(vector[idx]),(vector[idx])+1);
    return(UE_OK);
}


/*
 * Look for a record in the database.
 * Returns USRDEF error code.
 */

int lookup(qname,origin,qclass,qtype,zones,cache,ncache,mba,now,
	    ncname,cname_max,answer,delegation,cqname)
    char *qname;			/* Name we're looking for */
    char *origin;			/* Suffix (from search rule) */
    int qclass,qtype;			/* Class and type ... */
    struct btnode *zones, *cache, *ncache; /* Pointers at roots of database */
    int mba;				/* Must Be Authoritative */
    int now;				/* "Current" time */
    int *ncname;			/* How many cnames already seen */
    int cname_max;			/* Limit for ncname */
    struct domain **answer;		/* Answer we find */
    struct domain **delegation;		/* Best delegation we find */
    char **cqname;			/* Canonicalized qname */
{
    int i, ntags;			/* Usual stuff */
    char *vector[MAX_DOMAIN_TAG_COUNT+1];
    struct btnode *t;
    struct zone	  *z;
					/* This stuff in query block? */
    struct zone *zone_ptr;		/* A zone worth looking at */
    int		 zone_idx;		/* Index into vector, zones lookup */
    struct rr	*zdel_ptr;		/* Last delegation seen, ditto */
    int		 zdel_idx;		/* Index when zdel_ptr set */
    struct rr	*cdel_ptr;		/* Last delegation seen, cache */
    int		 cdel_idx;		/* Index when cdel_ptr set */
    struct rr	*cname_ptr;		/* CNAME RR found during lookup */
    int		 cname_idx;		/* Level at which CNAME was found */

    struct rr	*result = NULL;		/* Where we put our results */

    if(answer == NULL)			/* Paranoia */
	return(UE_SYS);
    (*answer) = NULL;			/* No results yet */
    if(delegation != NULL)
	(*delegation) = NULL;

    /* Initially we're looking for the original query name plus origin */
    ntags = namexp(qname,vector);
    if(origin != NULL)
	ntags += namexp(origin,vector+ntags-1) - 1;

    do {				/* CNAME loop */
	struct btnode *zonep = zones;	/* Local copy */
	zone_ptr = NULL;  zdel_ptr = cdel_ptr = NULL;  cname_ptr = NULL;
	cdel_idx = zdel_idx = ntags;
	if(DBGFLG(DBG_LOOKUP)) {
	    char nambuf[STRSIZ];	/* implode name vector to string */
	    vnamtoa(nambuf,vector,ntags);
	    buginf("lookup","qclass=%d, qtype=%d, qname=\"%s\", ntags=%d",
		    qclass,qtype,nambuf,ntags);
	}
	/* Find "best" zone(s) from authoritative tree */
	/* Loop structure a little hairy, oh well. */
	for(i = ntags; --i >= 0 && zonep != NULL; zonep = t->data.link.tpoint){
		if((t = avlook(zonep,vector[i])) == NULL)
		    break;
		for(z = t->data.data.zoa; z != NULL; z = z->next)
		    if(cmatch(qclass,z->base.data.rrs->class)) {
			zone_ptr = z;
			zone_idx = i;
			break;
		    }
	    }

	/* Look in zone(s) we found */
	for(z = zone_ptr; z != NULL; z = z->next)
	    if(cmatch(qclass,z->base.data.rrs->class)
	      && (i = zlook(z,vector,zone_idx,qclass,qtype,now,
			    (delegation != NULL),&result,
			    &zdel_ptr,&zdel_idx,&cname_ptr,&cname_idx)
		  ) != UE_OK)		/* Pass any errors up */
		return(i);		/* (no consed stuff in this case) */

	/* If we didn't find data or a CNAME and if permitted, look in cache */
	if(!mba && result == NULL && cname_ptr == NULL
	  && (i = clook(cache,ncache,vector,ntags,qclass,qtype,now,
		(delegation != NULL),&result,&cdel_ptr,
		&cdel_idx,&cname_ptr,&cname_idx)
	      ) != UE_OK) {		/* cache can return neg cache err */
	    if(DBGFLG(DBG_LOOKUP))
		buginf("lookup","negative cache err=%d",i);
	    kil_ranswer(zdel_ptr);	/* got err, punt any delegation */
	    return(i);			/* and return the error */
	}

	if(DBGFLG(DBG_LOOKUP))
	    buginf("lookup","result=%o, zdel_p=%o, cdel_p=%o, cname_p=%o",
			result,zdel_ptr,cdel_ptr,cname_ptr);
	if(result != NULL) {
	    kil_ranswer(zdel_ptr);	/* Get rid of any delegation stuff */
	    kil_ranswer(cdel_ptr);
	    *answer = mak_domain(1);
	    (*answer)->name = namimp(vector,ntags);
	    (*answer)->data.rrs = result;
	    if(DBGFLG(DBG_LOOKUP))
		buginf("lookup","taking answer, *answer=%o",*answer);
	} else if(cname_ptr != NULL) {
	    if(DBGFLG(DBG_LOOKUP)) {
		char rrtext[STRSIZ];
		buginf("lookup","cname \"%s\" found, new ntags=%d",
			namtoa(rrtext,cname_ptr->rdata[CNAME_CNAME].byte),ntags);
	    }
	    ntags = cname_idx
		  + namexp(cname_ptr->rdata[CNAME_CNAME].byte,vector+cname_idx);
	    continue;			/* play it again, sam */
	} else if(delegation == NULL && (cqname == NULL || *ncname == 0)) {
	    if(DBGFLG(DBG_LOOKUP))	/* wanted just an answer? */
		buginf("lookup","no answer and didn't want delegation or cqname");
	    kil_ranswer(zdel_ptr);	/* yeah, clean up */
	    kil_ranswer(cdel_ptr);
	} else if(delegation != NULL && (zdel_ptr != NULL||cdel_ptr != NULL)) {
	    int taking_zdel =  zdel_idx <= cdel_idx;
	    *delegation = mak_domain(1);
	    (*delegation)->name = namimp(vector,ntags);
	    if(DBGFLG(DBG_LOOKUP)) {
		char rrtext[STRSIZ];
		buginf("lookup","taking %s delegation, name=\"%s\", *delegation=%o",
			(taking_zdel ? "authoritative" : "cache"),
			namtoa(rrtext,(*delegation)->name), (*delegation));
	    }
	    if(taking_zdel) {
		(*delegation)->data.rrs = zdel_ptr;
		kil_ranswer(cdel_ptr);
	    } else {
		(*delegation)->data.rrs = cdel_ptr;
		kil_ranswer(zdel_ptr);
	    }
	} else if(cqname != NULL && *ncname > 0) {
	    if(*cqname != NULL)
		kil(*cqname);
	    *cqname = namimp(vector,ntags);
	    if(DBGFLG(DBG_LOOKUP)) {
		char rrtext[STRSIZ];
		buginf("lookup","taking cqname=\"%s\"",namtoa(rrtext,*cqname));
	    }
	    kil_ranswer(cdel_ptr);
	    kil_ranswer(zdel_ptr);
	}
	return(UE_OK);			/* name ok in all these cases */

    } while(++*ncname <= cname_max);	/* Get here if found CNAME */

    return(UE_TMC);			/* Too many CNAMEs */
}
