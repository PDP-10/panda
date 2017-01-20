/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Memory management routines.
 *
 * This module provides constructors and destructors for common
 * struct types, routines are named mak_foo and kil_foo.
 *
 * This module also provides the routines mak(), remak(), and kil(),
 * which are used instead of malloc(), realloc(), and free().  mak()
 * and kil() run on top of a best-fit memory allocator which is a
 * little more paranoid than the KCC malloc() routines and which is
 * designed to improve performance via paging optimization.  
 * You can assume that the  memory returned by mak() (and the tail
 * portion of a remak() that increases the size of the block()) is
 * zeroed when allocated, a la calloc().  mak() and remak() will
 * bughlt() if they lose, so it is not necessary to check for NULL
 * results from these routines.
 */

#include "domsym.h"
#include <stdlib.h>

/* Macros to check (char *) addresses for "reasonability". */
#if CPU_PDP10
#define	LH(p)	(((unsigned)(p))>>18)
#endif
#if (CPU_KLX+CPU_KL0)
#define BADADR(p) (DBGFLG(DBG_MEMORY) && LH(p) != 0331100 && (((LH(p)&037)<3) || (LH(p)&~037) != 0700000))
#elif CPU_PDP10
#define BADADR(p) (DBGFLG(DBG_MEMORY) && LH(p) != 0331100)
#else
#error BADADR() macro not defined for this CPU type!
#endif

/* stuff for best-fit memory manager. */

/* size of blocks we get from malloc(). */
#ifndef	RAWMEM_BLOCKSIZE
#define	RAWMEM_BLOCKSIZE    040000
#endif

/* Magic numbers for block headers. */
#define	MAGIC_FREE  (0123456654321)
#define	MAGIC_USED  (0654321123456)

/* Rounding factor to insure alignment. */
#define FUDGE_FACTOR (sizeof(long))

/* Memory block header. */
struct memhdr {
    long magic;
    union {
	long size;
	struct memhdr *next;
    } data;
};
#define	MEMHDR	(sizeof(struct memhdr))

/* Freelist entry. */
struct freelist {
    long size;
    struct memhdr *bucket;
    struct freelist *next;
};
#define FREELIST (sizeof(struct freelist))

/* Raw memory block. */
struct rawmem {
    long magic;
    long size;
    struct rawmem *next;
};
#define	RAWMEM	(sizeof(struct rawmem))

static struct freelist *freelist = NULL;
static struct rawmem *rawmem = NULL;
static int memcnt = 0;

/* zt.c */
extern int gc_now(void);

/* memory.c */
static struct freelist *find_bucket(int);
static char *getmem(int,int);
static void givmem(char *);


/* Find a bucket on the freelist via move-to-front sequential search. */
static struct freelist *find_bucket(size)
    int size;
{
    struct freelist *l;
    if(freelist == NULL || freelist->size == size)
	return(freelist);
    for(l = freelist; l->next != NULL; l = l->next)
	if(l->next->size == size) {
	    struct freelist *it = l->next;
	    l->next = it->next;
	    it->next = freelist;
	    return(freelist = it);
	}
    return(NULL);
}

/* Get a block of memory.  Caller is responsible for bzero()'ing. */
static char *getmem(requested_size,panic)
    int requested_size;
    int panic;
{
    struct freelist *l;
    struct rawmem **r;
    struct memhdr *m = NULL;
    int size = requested_size;

    /*
     * Calculate how much memory we're really looking for.
     * We include our own overhead as part of the block size.
     */
    size += MEMHDR + FUDGE_FACTOR - 1;
    size -= size % FUDGE_FACTOR;

    /*
     * Look to see if we've got a block the right size on the
     * freelist.  We allocate blocks first-in-last-out to localize
     * paging.  If we're taking the last block from a freelist bucket,
     * we mark the bucket as unused.
     */
    if((l = find_bucket(size)) != NULL) {
	if((m = l->bucket) == NULL)
	    bughlt("getmem","empty bucket on freelist, l=%o",l);
	switch(m->magic) {
	    case MAGIC_FREE:
		break;
	    case MAGIC_USED:
		bughlt("getmem","block on freelist marked used, m=%o",m);
	    default:
		bughlt("getmem","bad block on freelist, m=%o, m->magic=%o",
			m,m->magic);
	}
	if((l->bucket = m->data.next) == NULL)
	    l->size = 0;
	m->magic = MAGIC_USED;
	m->data.size = size;
	++memcnt;
	return(((char *)m)+MEMHDR);
    }

    /*
     * No exact-fit available.  Do first-fit on any unallocated memory
     * we happen to have handy.  If we find a usable block, we
     * partition it if it's big enough to be worth bothering.
     */
    for(r = &rawmem; (*r) != NULL; r = &((*r)->next))
	if((*r)->magic != MAGIC_FREE)
	    bughlt("getmem","bad rawmem, r=%o, (*r)=%o, (*r)->magic=%o",
		    r,(*r),(*r)->magic);
	else if((*r)->size >= size) {
	    m = (struct memhdr *) (*r);
	    if((*r)->size >= size + RAWMEM) {
		struct rawmem *p = (*r);
		(*r) = (struct rawmem *) (((char *)p) + size);
		(*r)->magic = MAGIC_FREE;
		(*r)->size = p->size - size;
		(*r)->next = p->next;
	    } else {
		(*r) = (*r)->next;
	    }
	    m->magic = MAGIC_USED;
	    m->data.size = size;
	    ++memcnt;
	    return(((char *)m)+MEMHDR);
	}

    /*
     * Nothing suitable, get a big block from malloc() and slice off
     * some of that for the user unless the user's request exceeds our
     * idea of a big block.
     */
    m = (struct memhdr *)
	    malloc(size < RAWMEM_BLOCKSIZE - RAWMEM ? RAWMEM_BLOCKSIZE : size);
    if(m == NULL) {
	bugchk("getmem","malloc() barfed, size=0%o",size);
	if(panic)
	    bughlt("getmem","garbage collecting didn't help, giving up");
	if(DBGFLG(DBG_MEMORY|DBG_GC|DBG_LOG))
	    buginf("getmem","attempting emergency GC");
	gc_now();
	if(DBGFLG(DBG_MEMORY|DBG_GC|DBG_LOG))
	    buginf("getmem","emergency GC done, tail recursing");
	++memcnt;
	return(getmem(requested_size,1));
    }
    m->magic = MAGIC_USED;
    m->data.size = size;
    if(size < RAWMEM_BLOCKSIZE - RAWMEM) {
	struct rawmem *p = (struct rawmem *) (((char *)m) + size);
	p->magic = MAGIC_FREE;
	p->size = RAWMEM_BLOCKSIZE - size;
	p->next = rawmem;
	rawmem = p;
    }
    ++memcnt;
    return(((char *)m)+MEMHDR);
}

/* Put a block onto the freelist. */
static void givmem(p)
    char *p;
{
    struct memhdr *m = (struct memhdr *) (p - MEMHDR);
    struct freelist *l;
    long size = m->data.size;

    switch(m->magic) {
	case MAGIC_USED:
	    break;
	case MAGIC_FREE:
	    bugchk("givmem","block already marked free, p=%o, m->data.next=%o",
		    p,m->data.next);
	    return;
	default:
	    bughlt("givmem","tried to release bad block, p=%o, m->magic=%o",
		    p,m->magic);
    }
    m->magic = MAGIC_FREE;

    if((l = find_bucket(size)) == NULL && (l = find_bucket(0)) == NULL) {
	l = (struct freelist *)mak(sizeof(struct freelist));
	l->next = freelist;
	freelist = l;
	if(DBGFLG(DBG_MEMORY))
	    /* This will never be freed, so log a deallocation */
	    buginf("givmem","deallocating %012o [bucket, size = 0%o]",
		    (char *)l, size);
    }

    m->data.next = l->bucket;
    l->bucket = m;

    if(l->size == 0)
	l->size = size;

    --memcnt;
}


char *mak(size)
    int size;
{
    char *p;

    if(size <= 0)
	bughlt("mak","can't allocate a zero length block!");
    bzero((p = getmem(size,0)),size);
    if(BADADR(p))
	bughlt("mak","getmem() returned unlikely pointer %012o",p);
    else if(DBGFLG(DBG_MEMORY))
	buginf("mak","allocating %012o [size = 0%o]",p,size);
    return(p);
}

void kil(p)
    char *p;
{
    if(BADADR(p))
	bughlt("kil","tried to pass givmem() an unlikely pointer %012o",p);
    else if(DBGFLG(DBG_MEMORY))
	buginf("kil","deallocating %012o",p);
    givmem(p);
    return;
}

char *remak(p,size)
    char *p;
    int size;
{
    char *q;
    struct memhdr *m;
    if(p == NULL)
	return(mak(size));
    if(size <= 0)
	bughlt("remak","can't allocate a %d length block");
    else if(BADADR(p))
	bughlt("remak","tried to pass unlikely pointer to givmem() %012o",p);
    else if(DBGFLG(DBG_MEMORY))
	buginf("remak","deallocating %012o",p);
    m = (struct memhdr *) (p - MEMHDR);
    if(m->magic != MAGIC_USED)
	bughlt("remak","detected corrupt block %012o",p);
    q = getmem(size,0);
    if(m->data.size < size) {
	bcopy(p,q,m->data.size);
	bzero(q + m->data.size, size - m->data.size);
    } else
	bcopy(p,q,size);
    givmem(p);
    if(BADADR(q))
	bughlt("remak","getmem() returned unlikely pointer %012o",q);
    else if(DBGFLG(DBG_MEMORY))
	buginf("remak","allocating %012o",q);
    return(q);
}

/* bcons() -- a combination of mak() and bcopy(), but faster. */

char *bcons(bytes,size)
    char *bytes;
    int size;
{
    char *p = NULL;
    if(bytes == NULL)
	bugchk("bcons","null source pointer");
    else if(size <= 0)
	bugchk("bcons","bad byte count %d",size);
    else if((p = getmem(size,0)) == NULL)
	bughlt("bcons","getmem() ran out of memory");
    else if(BADADR(p))
	bughlt("bcons","getmem() returned unlikely pointer %012o",p);
    else
        bcopy(bytes,p,size);
    if(DBGFLG(DBG_MEMORY) && p != NULL)
	buginf("bcons","allocating %012o [size = 0%o]",p,size);
    return(p);
}

union rdatom *mak_rdatom(size)
    int size;
{
    return((union rdatom *)mak(size*sizeof(union rdatom)));
}

void kil_rdatom(atom,class,type)
    union rdatom *atom;
    int class,type;
{
    char *fmt;
    union rdatom *a;
    if(DBGFLG(DBG_MEMORY))
	buginf("kil_rdatom","atom=%o",atom);
    if(atom != NULL) {
	if((fmt = rrfmt(class,type)) != NULL)
	    for(a = atom; *fmt != '\0'; ++fmt, ++a)
		switch(*fmt) {
		    case 'd':	case 's':   case 'w':
			if(DBGFLG(DBG_MEMORY))
			    buginf("kil_rdatom","fmt='%c', a->byte=%o",
					*fmt,a->byte);
			if(a->byte != NULL)
			    kil(a->byte);
		    case '4':	case '2':   case 'i':	case 'c':
			continue;
		    default:
			bugchk("kil_rdatom","unknown format character '%c'",
				*fmt);
		}
	else
	    bugchk("kil_rdatom","rrfmt() returned error for %o, %d, %d",
		    atom,class,type);
	kil_(atom);
    }
}

struct rr *mak_rr()
{
    return((struct rr *)mak(sizeof(struct rr)));
}

void kil_rr(r)
    struct rr *r;
{
    struct rr *t;

    while(r != NULL) {
	if(DBGFLG(DBG_MEMORY))
	    buginf("kil_rr","r=%o",r);
	kil_rdatom(r->rdata,r->class,r->type);
	t = r;	r = r->chain;
	kil_(t);
    }
    return;
}

struct rr *rrcons(old_rr)
    struct rr *old_rr;
{
    char *fmt = rrfmt(old_rr->class,old_rr->type);
    struct rr *new_rr;
    int i;

    if(old_rr == NULL || fmt == NULL) {
	bugchk("rrcons","bad argument %o",old_rr);
	return(NULL);
    }
    *(new_rr = mak_rr()) = *old_rr;
    new_rr->rdata = mak_rdatom(strlen(fmt));
    new_rr->chain = NULL;		/* Paranoia */
    for(i = 0; fmt[i] != '\0'; ++i)
	switch(fmt[i]) {
	    case '4':	case '2':   case 'i':	case 'c':
		new_rr->rdata[i].word = old_rr->rdata[i].word;
		break;
	    case 'd':
		new_rr->rdata[i].byte = bcons(old_rr->rdata[i].byte,
					    namlen(old_rr->rdata[i].byte));
		break;
	    case 's':
		new_rr->rdata[i].byte = bcons(old_rr->rdata[i].byte,
					    1+(*(old_rr->rdata[i].byte)));
		break;
	    case 'w':
		new_rr->rdata[i].byte = bcons(old_rr->rdata[i].byte,
					    IN_WKS_TOTAL_LENGTH);
		break;
	    default:
		bugchk("rrcons","bad format char '%c'",fmt[i]);
		return(NULL);
	}
    return(new_rr);
}

struct domain *mak_domain(size)
    int size;
{
    return((struct domain *) mak(size*sizeof(struct domain)));
}

void kil_domain(d,array_p)
    struct domain *d;
    int array_p;
{
    struct domain *t;

    if(d == NULL)
	return;

    if((d->name == NULL) ^ (array_p != 0))
	bugchk("kil_domain","warning: d=%o, d->name=%o, array_p=%o",
		d,d->name,array_p);

    if(array_p) {
	int i = (t = d)->data.count;
	if(DBGFLG(DBG_MEMORY))
	    buginf("kil_domain","d=%o, array_p=1",d);
	while(--i >= 0) {
	    kil((++t)->name);
	    kil_rr(t->data.rrs);
	    kil_domain(t->link.dpoint,1);
	}
	kil_(d);
    }
    else
	while(d != NULL) {
	    if(DBGFLG(DBG_MEMORY))
		buginf("kil_domain","d=%o, array_p=0",d);
	    if(d->name != NULL)
		kil(d->name);
	    kil_rr(d->data.rrs);
	    d = (t = d)->link.dpoint;
	    kil_(t);
	}
    return;
}

struct btnode *mak_btnode()
{
    return((struct btnode *)mak(sizeof(struct btnode)));
}

void kil_btnode(tree,kil_payload)
    struct btnode *tree;
    void (*kil_payload)(struct rr *);
{
    if(tree == NULL)
	return;
    kil_btnode(tree->left,kil_payload);
    kil_btnode(tree->right,kil_payload);
    if(kil_payload == NULL && tree->data.data.rrs != NULL)
	bughlt("kil_btnode","NULL kil_payload() with non-NULL payload");
    if(kil_payload != NULL)
	(*kil_payload)(tree->data.data.rrs);
    if(tree->data.name != NULL)
	kil(tree->data.name);
    kil_btnode(tree->data.link.tpoint,kil_payload);
    kil_(tree);
}

struct zone *mak_zone()
{
    return((struct zone *)mak(sizeof(struct zone)));
}

void kil_zone(z)
    struct zone *z;
{
    struct zone *t;

    while(z != NULL) {
	if(z->srcfil != NULL)
	    kil(z->srcfil);
	if(z->base.name != NULL)
	    kil(z->base.name);
	kil_rr(z->base.data.rrs);
	kil_domain(z->base.link.dpoint,1);
	kil_domain(z->glue.link.dpoint,1);
	t = z;	z = z->next;
	kil_(t);
    }
    return;
}
