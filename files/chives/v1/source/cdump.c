/*
 * This comment was added by the C-M-* command (really C-z-*).
 */

/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

#include <stdio.h>
#include "domsym.h"

/*
 * External Definitions.
 */

/* rrtoa.c */
extern char *rrtoa(char *,char *,struct rr *);
/* names.c */
extern char *namtoa(char *,char *);


/* Dump the cache to the log file */

#define strend(p) while(*(p) != '\0') ++(p);

/*
 * Function to dump rr records -- a rip-off of rrtoa().
 */
char *crrtoa(buffer, name, r)
    char *buffer;
    char *name;
    struct rr *r;
{
    char *fmt, *p = buffer, *class, *type;
    union rdatom *a;

    if(p == NULL || r == NULL || (fmt = rrfmt(r->class,r->type)) == NULL
	    || (class = looktb(qc_table,r->class)) == NULL
	    || (type = looktb(qt_table,r->type)) == NULL)
	return(NULL);
    strcpy(p, name);
    strend(p);
    if(sprintf(p," %d %s %s",r->ttl,class,type) == EOF)
	return(NULL);
    strend(p);

    for(a = r->rdata; *fmt != '\0'; ++a, ++fmt) {
	*p = ' ';   *++p = '\0';
	switch(*fmt) {
	    case 'd':	if(namtoa(p,a->byte) == NULL)
			    return(NULL);
			break;
	    case 's':	if(sprintf(p,"%.*s", *a->byte, a->byte+1) == EOF)
			    return(NULL);
			break;
	    case '4':
	    case '2':	if(sprintf(p,"%d", a->word) == EOF)
			    return(NULL);
			break;
	    case 'c':	if(sprintf(p,"%o", a->word) == EOF)
			    return(NULL);
			break;
	    case 'i':	if(inatoa(p,a->word) == NULL)
			    return(NULL);
			break;
    	    case 'w':	if(wkstoa(p,a->byte) == NULL)
			    return(NULL);
			break;
	    default:	bugchk("rrdtoa","unknown rrfmt() token '%c'",*fmt);
			return(NULL);
	}
	strend(p);
    }
    return(buffer);
}

/*
 * Function to dump the contents of rr records; while tree walking the cache.
 */
void dump_rrs(stream, name, node)
    FILE *stream;			/* File to write to. */
    char *name;				/* Name of upper node. */
    struct btnode *node;		/* Pointer to this node. */
{
    char rrtext[STRSIZ], domain[STRSIZ];
    struct rr *rr;

    if (!(rr = node->data.data.rrs))	
	return;				/* No RR records present. */

    if (!namtoa(domain, node->data.name))
	return;				/* Something wrong with node name ?? */

    /*
     * Combine this node name <foo> with the tree name <bar.com>,
     * and then dump the rr records into *rrtext* and print them.
     * e.g.:	foo.bar.com.	IN  A	1.1.1.1
     */
    strcpy((domain + strlen(domain)), name);
    while (rr) {
	if (crrtoa(rrtext, domain, rr))
	    if (fprintf(stream, "%s\n", rrtext) == EOF)
		return;
	rr = rr->chain;
    }
    return;
}

/*
 * Function to print out the contains of the cache to the log file.
 */
void dump_cache(stream, domain, cache)
    FILE *stream;
    char *domain;			/* Equal to NULL on initial entry */
    struct btnode *cache;
{
    struct btnode *c, *left, *right;
    char tdomain[STRSIZ];

    if (!(c = cache)) {
	return;
    }
    strcpy(tdomain, domain);		/* Get local copy. */

    while (c) {
	dump_rrs(stream, tdomain, c);	/* Does the actual printing. */
	if (left = c->left)
	    dump_cache(stream, tdomain, left);

	if (right = c->right)
	    dump_cache(stream, tdomain, right);

	if (c->data.link.tpoint) {

	    /*
	     * Construct a zone name -- lower levels are present.
	     */
	    if (!namtoa(tdomain, c->data.name))
		return;
	    strcpy((tdomain + strlen(tdomain)), domain);
	}
	c = c->data.link.tpoint;
    }
}

/*{ */

/*   FILE *f; */

/*    if (!(f = fopen("domain:resolv.cache.-1", "w")) { */
/*    } */
/*    dump_cache(f, NULL, cache) */
/*    return; */

/*}*/

