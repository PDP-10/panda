/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Garbage collector.  Not particularly clever, not ephemeral.
 * I suppose lookup() could be haired up to do ephemeral if
 * it becomes an issue, which I doubt.
 */

#include "domsym.h"

/* insert.c */
extern int insert(struct btnode **,char *,struct rr *,int,int);

/* tim20x.c */
extern int zulu(void);

/* gc.c */
int gc(struct btnode **,struct btnode **,struct btnode **);

/* gc.c */
static int gctree(struct btnode *,struct btnode **,
	int (*func )(struct btnode *,struct btnode **,char **,int,int),
			char **,int ,int );
static int gcnode(struct btnode *,struct btnode **,
	int (*func )(struct btnode *,struct btnode **,char **,int,int),
			char **,int,int );
static int gc_zones(struct btnode *,struct btnode **,char **,int,int );
static int gc_cache(struct btnode *,struct btnode **,char **,int,int );
static int gc_ncache(struct btnode *,struct btnode **,char **,int,int );

#define punt(arg)   return(bugchk arg, 0)

int gc(zones,cache,ncache)
    struct btnode **zones, **cache, **ncache;
{
    struct btnode *old, *new;
    int gc_zones(), gc_cache(), gc_ncache();
    char *vector[MAX_DOMAIN_TAG_COUNT+1];
    int now = zulu();

    old = *zones;   new = NULL;
    if(!gctree(old,&new,gc_zones,vector+MAX_DOMAIN_TAG_COUNT+1,0,now))
	bughlt("gc","gc of zones failed");
    *zones = new;   kil_btnode(old,NULL);

    old = *cache;   new = NULL;
    if(!gctree(old,&new,gc_cache,vector+MAX_DOMAIN_TAG_COUNT+1,0,now))
	bughlt("gc","gc of cache failed");
    *cache = new;   kil_btnode(old,NULL);

    old = *ncache;  new = NULL;
    if(!gctree(old,&new,gc_ncache,vector+MAX_DOMAIN_TAG_COUNT+1,0,now))
	bughlt("gc","gc of ncache failed");
    *ncache = new;   kil_btnode(old,NULL);

    return(1);
}

static int gctree(old_tree,new_tree,func,vector,ntags,now)
    struct btnode *old_tree, **new_tree;
    int (*func )(struct btnode *,struct btnode **,char **,int,int);
    char **vector;
    int ntags, now;
{
    if(old_tree == NULL)
	return(1);
    if(new_tree == NULL || func == NULL || vector == NULL)
	punt(("gctree","new_tree=%o, func=%o, vector=%o",
		new_tree, func, vector));
    if(DBGFLG(DBG_GC)) {
	char *name = namimp(vector,ntags), rrtext[STRSIZ];
	if(namtoa(rrtext,name) == NULL)
	    rrtext[0] = '\0';
	buginf("gctree","old_tree=%o, *new_tree=%o, ntags=%d, name=\"%s\"",
		old_tree,*new_tree,ntags,rrtext);
	if(name != NULL)
	    kil(name);	
    }
    if(!gcnode(old_tree,new_tree,func,--vector,++ntags,now))
	punt(("gctree","gcnode() failed"));
    return(1);
}

static int gcnode(old_node,new_tree,func,vector,ntags,now)
    struct btnode *old_node, **new_tree;
    int (*func )(struct btnode *,struct btnode **,char **,int,int);
    char **vector;
    int ntags, now;
{
    if(old_node == NULL)
	return(1);
    if(new_tree == NULL || vector == NULL || func == NULL)
	punt(("gcnode","new_tree=%o, vector=%o, func=%o",
		new_tree, vector, func));
    if((*vector = old_node->data.name) == NULL)
	punt(("gcnode","null name"));
    if(DBGFLG(DBG_GC)) {
	char *name = namimp(vector,ntags), rrtext[STRSIZ];
	buginf("gcnode","old_node=%o, old_node->tpoint=%o, old_node->left=%o, old_node->right=%o",old_node, old_node->data.link.tpoint, old_node->left, old_node->right);
	buginf("gcnode","new_tree=%o, *new_tree=%o, ntags=%d, name=\"%s\"",
		new_tree, *new_tree, ntags, namtoa(rrtext,name));
	if(name != NULL)
	    kil(name);	
    }
    if(!(*func)(old_node,new_tree,vector,ntags,now))
	punt(("gcnode","func failed"));
    if(!gctree(old_node->data.link.tpoint,new_tree,func,vector,ntags,now))
	punt(("gcnode","nested gctree() failed"));
    if(!gcnode(old_node->left,new_tree,func,vector,ntags,now))
	punt(("gcnode","nested gcnode(left) failed"));
    if(!gcnode(old_node->right,new_tree,func,vector,ntags,now))
	punt(("gcnode","nested gcnode(right) failed"));
    return(1);
}

/* Macro to snip an entry out of a list and append it to another list. */

#define FIFO_append(list_tail,node_var,link_tag) {  \
    node_var = (*list_tail = node_var)->link_tag;   \
    *(list_tail = &((*list_tail)->link_tag)) = NULL;\
}


static int gc_zones(node,tree,vector,ntags,now)
    struct btnode *node, **tree;
    char **vector;
    int ntags, now;
{
    struct zone *z;
    struct zone *keep_head = NULL, **keep_tail = &keep_head;
    struct zone *kill_head = NULL, **kill_tail = &kill_head;
    if(node == NULL)
	return(1);
    if(tree == NULL || vector == NULL)
	punt(("gc_zones","tree=%o, vector=%o",tree,vector));
    z = node->data.data.zoa;
    while(z != NULL) {
	if(DBGFLG(DBG_GC))
	    buginf("gc_zones",
		"z=%o, gotten=%d, soa_expire=%d, gotten+soa_expire=%d, now=%d",
		z, z->gotten, z->base.data.rrs->rdata[SOA_EXPIRE].word,
		z->gotten + z->base.data.rrs->rdata[SOA_EXPIRE].word, now);
	if( z->gotten == 0		/* zero means never GC */
	 || z->gotten + z->base.data.rrs->rdata[SOA_EXPIRE].word > now) {
	    if(DBGFLG(DBG_GC))
    		buginf("gc_zones","keeping z=%o",z);
	    FIFO_append(keep_tail,z,next) /* ; */
	} else {
	    if(DBGFLG(DBG_GC))
		buginf("gc_zones","killing z=%o",z);
	    FIFO_append(kill_tail,z,next) /* ; */
	}
    }
    if(keep_head != NULL) {
	char *name = namimp(vector,ntags);
	if(!insert(tree,name,(struct rr *)keep_head,0,0))
	    punt(("gc_zones","failed to re-insert zone"));
	kil(name);
    }
    kil_zone(kill_head);
    node->data.data.zoa = NULL;
    return(1);
}

static int gc_cache(node,tree,vector,ntags,now)
    struct btnode *node, **tree;
    char **vector;
    int ntags, now;
{
    struct rr *r;
    struct rr *keep_head = NULL, **keep_tail = &keep_head;
    struct rr *kill_head = NULL, **kill_tail = &kill_head;
    if(node == NULL)
	return(1);
    if(tree == NULL || vector == NULL)
	punt(("gc_cache","tree=%o, vector=%o",tree,vector));
    r = node->data.data.rrs;
    while(r != NULL)
	if(r->ttl > now) {
	    if(DBGFLG(DBG_GC))
    		buginf("gc_cache","keeping r=%o",r);
	    FIFO_append(keep_tail,r,chain) /* ; */
	} else {
	    if(DBGFLG(DBG_GC))
		buginf("gc_cache","killing r=%o",r);
	    FIFO_append(kill_tail,r,chain) /* ; */
	}
    if(keep_head != NULL) {
	char *name = namimp(vector,ntags);
	if(!insert(tree,name,keep_head,0,1))
	    punt(("gc_cache","failed to re-insert RRs"));
	kil(name);
    }
    kil_rr(kill_head);
    node->data.data.rrs = NULL;
    return(1);
}

static int gc_ncache(node,tree,vector,ntags,now)
    struct btnode *node, **tree;
    char **vector;
    int ntags, now;
{
    struct rr *r, *t;
    struct rr *keep_head = NULL, **keep_tail = &keep_head;
    struct rr *kill_head = NULL, **kill_tail = &kill_head;
    if(node == NULL)
	return(1);
    if(tree == NULL || vector == NULL)
	punt(("gc_ncache","tree=%o, vector=%o",tree,vector));
    r = node->data.data.rrs;
    while(r != NULL)
	if(r->ttl > now) {
	    if(DBGFLG(DBG_GC))
    		buginf("gc_ncache","keeping r=%o",r);
	    FIFO_append(keep_tail,r,chain) /* ; */
	} else {
	    if(DBGFLG(DBG_GC))
		buginf("gc_ncache","killing r=%o",r);
	    FIFO_append(kill_tail,r,chain) /* ; */
	}
    if(keep_head != NULL) {
	char *name = namimp(vector,ntags);
	if(!insert(tree,name,keep_head,0,0))
	    punt(("gc_ncache","failed to re-insert RRs"));
	kil(name);
    }
    r = kill_head;			/* not exactly RRs, kill by hand */
    while(r != NULL) {
	r = (t = r)->chain;
	kil_(t->rdata);
	kil_(t);
    }
    node->data.data.rrs = NULL;
    return(1);
}
