/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/*
 * makqry(buf,qid,recurse,qname,qclass,qtype) -- cons up a query packet
 *
 * buf	    output buffer (8 bit!)
 * qid	    "unique" id number for query
 * recurse  boolean, are we requesting recursion?
 * qname    query name
 * qclass   query class
 * qtype    query type
 *
 * Returns number of bytes used in buffer.
 */

#include "domsym.h"

/* src:<kccdist.kcc-6.lib.gen>memstr.c */
/* extern void bcopy(); */

int makqry(buf,id,recurse,name,class,type)
    char *buf, *name;
    int id, recurse, class,type;
{
    int length;
    struct dom_header *h = DOM_HEADER(buf);

    h->id	= id;		/* Query id, theoreticly unique */
    h->resp	= 0;		/* This is not a response */
    h->op	= OP_QUERY;	/* This is a Normal query */
    h->aa	= 0;		/* If I was an authority would I be asking? */
    h->tc	= 0;		/* No, I'm not truncated */
    h->rd	= recurse;	/* Ask for recursion if caller desires it */
    h->ra	= 0;		/* I'm not offering recursion, thank you */
    h->rcode	= ER_OK;	/* No response code since not a response */
    h->qdcnt	= 1;		/* One question */
    h->ancnt	= 0;		/* No answers */
    h->nscnt	= 0;		/* Or references */
    h->arcnt	= 0;		/* Or additional comments */
				/*  */
    length = namlen(name);
    bcopy(name,DOM_DATA(buf),length);
    buf = DOM_DATA(buf) + length;

    /* Why couldn't the #@$%*& protocol be consistant about */
    /* which comes first, class or type?  Gag me with a ... */

    *  buf = (type>>8)&0xFF;	/*  DPB */
    *++buf = (type   )&0xFF;	/* IDPB */
    *++buf = (class>>8)&0xFF;	/* IDPB */
    *++buf = (class   )&0xFF;	/* IDPB */

    return(DOM_HLEN + length + 4);
}
