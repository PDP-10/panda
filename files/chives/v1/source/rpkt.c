/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * rpkt():
 * Parse a packet.  Transport protocol independent.
 * Returns a list of names and rrs, in the order they appeared in
 * the packet.  All data in list comes from dynamic storage, so
 * be sure to kil_foo() it when you're done.
 */

#include "domsym.h"


static struct domain *rd_rr(_pkt,origin,isqsec)
    char **_pkt,*origin;
    int isqsec;
#define pkt (*_pkt)
{
    int i, rdcnt;
    char buf[STRSIZ], *fmt, *p;
    struct domain *d;
    struct rr *r;
    union rdatom *a;

    /* Get RR name, save it, skip over it in packet */
    if(namcpy(buf,pkt,origin) == NULL)
	return(NULL);
    d = mak_domain(1);
    d->name = bcons(buf,namlen(buf));
    pkt += namlen(pkt);

    /* Get the RR type and class */
    d->data.rrs = r = (struct rr *) mak(sizeof(struct rr));
    r->type  = bint2(pkt);   pkt += 2;
    r->class = bint2(pkt);   pkt += 2;

    /* If query section, that's the whole thing */
    if(isqsec)
	return(d);

    /* Get TTL, RDCNT, initialize pointers, rdatom list */
    r->ttl = bint4(pkt);	    pkt += 4;
    rdcnt  = bint2(pkt);	    pkt += 2;
    p = pkt;
    pkt += rdcnt;
    if((fmt = rrfmt(r->class,r->type)) == NULL) {
	kil_domain(d,0);
	return(NULL);
    } else
	r->rdata = mak_rdatom(strlen(fmt));

    for(a = r->rdata; p != NULL && *fmt != '\0'; ++fmt, ++a)
	switch(*fmt) {

	    case 'd':	if(namcpy(buf,p,origin) == NULL)
			    p = NULL;
			else {
			    a->byte = bcons(buf,namlen(buf));
			    p += namlen(p);
			}
			break;

	    case 's':	a->byte = bcons(p,(i = 1+*p));
			p += i;
			break;

	    case '4':
	    case 'i':	a->word = bint4(p);
			p += 4;
			break;

	    case '2':
	    case 'c':	a->word = bint2(p);
			p += 2;
			break;

	    case 'w':	/* this is really gross */
			/* this is also suspected of generating */
			/* bad code, at least under KCC-3 */
			i = pkt - p;
			bcopy(p, (a->byte = mak(IN_WKS_TOTAL_LENGTH)), i);
			p += i;
			break;

	    default:	p = NULL;
	}

    if(p == NULL) {
	kil_domain(d,0);
	r = NULL;
	d = NULL;
    }

    return(d);
}
#undef pkt


struct domain *rpkt(pkt,size)
    char *pkt;
    int size;
{
    struct domain *head = NULL, **tail = &head, *temp;
    char *p = DOM_DATA(pkt);
    enum {qdsect,ansect,nssect,arsect,maxsect} sect;
    int i, cnt[maxsect], losing = 0;
    static char *nam[maxsect] =
	{"Question","Answer","Authority","Additional"};

    cnt[qdsect] = DOM_HEADER(pkt)->qdcnt;
    cnt[ansect] = DOM_HEADER(pkt)->ancnt;
    cnt[nssect] = DOM_HEADER(pkt)->nscnt;
    cnt[arsect] = DOM_HEADER(pkt)->arcnt;

    for(sect = 0; !losing && sect < maxsect; ++sect)
	for(i = 0; !losing && i < cnt[sect]; ++i)
	    if((temp = rd_rr(&p, pkt, (sect == qdsect))) == NULL)
		continue;
/*		++losing; */
	    else {
		temp->link.dpoint = *tail;	*tail = temp;
		tail = &(temp->link.dpoint);
		if(DBGFLG(DBG_LOG|DBG_RPKT)) {
		    char rrtext[STRSIZ];
		    buginf("rpkt","RR %s#%d: %s",nam[sect],i,
			    ((sect == qdsect) ?
				rrhtoa(rrtext,temp->name,temp->data.rrs->class,
					    temp->data.rrs->type) :
				rrtoa(rrtext,temp->name,temp->data.rrs)));
		}
	    }

    if(losing) {
	kil_domain(head,0);
	head = NULL;
    }

    return(head);
}

/* Peek at query section of a datagram.  Does not cons. */
void qpeek(qdsection,qname,qclass,qtype)
    char *qdsection, **qname;
    int *qclass, *qtype;
{
    qdsection += namlen(*qname = qdsection);
    *qtype  = bint2(qdsection);
    *qclass = bint2(qdsection+2);
    return;
}
