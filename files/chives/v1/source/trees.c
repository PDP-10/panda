/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Routines for AVL trees.  Not all operations supported, in particular
 * deletion in AVL trees is expensive and hairy (adding is bad enough).
 * Given that we probably want our garbage collector to do storage
 * compaction as well, AVL deletion is probably unnecessary, what we really
 * want is a copying garbage collector with discrete areas.  This problem
 * is left for a future release.
 */

#include "domsym.h"

/* tag twiddling primitive */
#define taglen(a)	(1+*(a))


/* Add a node to an AVL tree */
int avladd(tree,key,stuff,where)
    struct btnode **tree;		/* tree to search */
    char *key;				/* tag */
    struct rr *stuff;			/* well, usually */
    struct btnode **where;		/* where we finally put stuff */
{
    int delta;
#define p0 (*tree)
    struct btnode *p1,*p2;

    if(DBGFLG(DBG_TREES))
	buginf("avladd","p0=%o, key=\"%.*s\"[%o], stuff=%o",
		(int)p0,*key,key+1,(int)key,(int)stuff);

    /*
     * If no node, is trivial.  Height will be one.  stuff doesn't
     * have to be a (struct rr *) in this case, so no casting needed.
     * This is the only case where we see a (struct zone *) as stuff.
     */
    if(p0 == NULL) {
	*where = p0 = mak_btnode();
	if(DBGFLG(DBG_TREES))
	    buginf("avladd","new node [%o]",p0);
	p0->data.name = bcons(key,taglen(key));
	p0->data.data.rrs = stuff;
	return(1);			/* Tree grew by one */
    }

    /*
     * Wasn't empty.  If exact match, name already exists.
     * This only happens for (struct rr *) as stuff.  Note that
     * insert new RRs at the head of the list, so for zones the
     * base node will need to be fixed up to put the SOA first.
     */
    if((delta = tagcmp(key,p0->data.name)) == 0) {
	if(DBGFLG(DBG_TREES))
	    buginf("avladd","match [\"%.*s\"[%o],\"%.*s\"[%o]]",
			*key,key+1,(int)key,*(p0->data.name),
			(p0->data.name)+1,(int)(p0->data.name));
	if(stuff != NULL) {
	    stuff->chain = p0->data.data.rrs;
	    p0->data.data.rrs = stuff;
	}
	*where = *tree;			/* where we put stuff */
	return(0);			/* no change in height */
    }

    /*
     * Not exact match.  Decend tree then fix up.  Fasten seat belts.
     */
    if(DBGFLG(DBG_TREES))
	buginf("avladd","tagcmp(\"%.*s\"[%o],\"%.*s\"[%o]) = %d",
		*key,key+1,(int)key,
		*(p0->data.name),(p0->data.name)+1,(int)(p0->data.name),
		delta);
    delta = (delta < 0) ? -avladd(&(p0->left),  key, stuff, where)
			:  avladd(&(p0->right), key, stuff, where);
    if(DBGFLG(DBG_TREES))
	buginf("avladd","delta=%d, [%o]->height=%d",delta,(int)p0,p0->height);
    if(delta == 0)
	return(0);			/* if delta is zero, we're done */
    else
	switch(p0->height + delta) {	/* but it probably isn't */

	    /* Cases not needing rotation */

	    case 0:			/* Tree is now balanced */
		if(DBGFLG(DBG_TREES))
		    buginf("avladd","case 0: balanced");
		return(p0->height = 0);	/* New balance, no height change */

	    case 1:			/* Tree is now out of balance */
	    case -1:			/* but within permissible range */
		if(DBGFLG(DBG_TREES))
		    buginf("avladd","case %d: almost balanced",delta);
		p0->height = delta;	/* New balance factor */
		return(1);		/* Tree grew by one node */

	    /* Cases needing rotation */

	    case -2:			/* Left too tall, rotate right */
		if(DBGFLG(DBG_TREES))
		    buginf("avladd","case -2: %s right rotation",
			    ((p0->left->height < 0) ? "single" : "double"));
		if((p1 = p0->left)->height < 0) {
		    p0->left = p1->right;   p1->right = p0;
		    p0->height = 0;	/* Single right rotation */
		    p0 = p1;
		} else {
		    p2 = p1->right;	/* Double right rotation */
		    p1->right = p2->left;   p2->left = p1;
		    p0->left = p2->right;   p2->right = p0;
		    p0->height = (p2->height < 0) ?  1 : 0;
		    p1->height = (p2->height > 0) ? -1 : 0;
		    p0 = p2;
		}
		return(p0->height = 0);

	    case 2:			/* Right too tall, rotate left */
		if(DBGFLG(DBG_TREES))
		    buginf("avladd","case +2: %s left rotation",
			    ((p0->right->height < 0) ? "single" : "double"));
		if((p1 = p0->right)->height > 0) {
		    p0->right = p1->left;   p1->left = p0;
		    p0->height = 0;	/* Single left rotation */
		    p0 = p1;
		} else {
		    p2 = p1->left;	/* Double left rotation */
		    p1->left = p2->right;   p2->right = p1;
		    p0->right = p2->left;   p2->left = p0;
		    p0->height = (p2->height > 0) ? -1 : 0;
		    p1->height = (p2->height < 0) ?  1 : 0;
		    p0 = p2;
		}
		return(p0->height = 0);


	    /* Lossage */
	    default:
		bugchk("avladd","bad balance (height=%d,delta=%d)",
			p0->height, delta);
		return(0);		/* mostly harmless */
	}				/* never get here */
}

/* I don't want to think about this now.  It only matters for gc anyway. */
int avldel()
{
    bughlt("avldel","NIY!");
}

/* Quick scan to count nodes.  Ick. */
int avlcnt(tree)
    struct btnode *tree;
{
    return(tree == NULL ? 0 : 1 + avlcnt(tree->left) + avlcnt(tree->right));
}

/* Convert a tree into a flat binary table (thrash, thrash) */
void avltab(tree,tabptr)
    struct btnode *tree;
    struct domain **tabptr;
{
    if(tree == NULL)
	return;
    avltab(tree->left,tabptr);
    *++*tabptr = tree->data;
    if(DBGFLG(DBG_TREES))
	buginf("avltab","tree=%o, [%o]=\"%.*s\"", (int)tree,
		(int)(*tabptr),*(tree->data.name),(tree->data.name)+1);
    avltab(tree->right,tabptr);
}

/* Kill a tree, just the nodes (for use with avltab() */
void avlkil(tree)
    struct btnode *tree;
{
    if(tree == NULL)
	return;
    avlkil(tree->left);
    avlkil(tree->right);
    kil_(tree);
}

/* Find a node in a tree */
struct btnode *avlook(tree,key)
    struct btnode *tree;
    char *key;
{
    int cmp;
    if(DBGFLG(DBG_TREES))
	buginf("avlook","tree=%o, key=\"%.*s\"",(int)tree,*key,key+1);
    while(tree != NULL && (cmp = tagcmp(key,tree->data.name)) != 0) {
	if(DBGFLG(DBG_TREES))
	    buginf("avlook",
		   "tree=%o, key=\"%.*s\", cmp=%d, tree->data.name=\"%.*s\"",
		   (int)tree,*key,key+1,cmp,*(tree->data.name),
		   (*(tree->data.name) == 0 ? "" : (tree->data.name)+1));
	tree = (cmp < 0) ? tree->left : tree->right;
    }
    if(DBGFLG(DBG_TREES))
	buginf("avlook","key=\"%.*s\", [%o]->data.name=\"%.*s\"",
		*key,key+1, (int)tree, *(tree->data.name),
		(*(tree->data.name) == 0 ? "" : (tree->data.name)+1));
    return(tree);
}
