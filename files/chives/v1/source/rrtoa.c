/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * rrtoa(buffer,name,rr)  -- write rr in text form to string.
 * rrhtoa(buffer,name,rr) -- write rr header in text form to string.
 */

#include "domsym.h"
#define punt return(NULL)
#define strend(p) while(*(p) != '\0') ++(p);

char *rrhtoa(buffer,qname,qclass,qtype)
    char *buffer, *qname;
    int qclass, qtype;
{
    char *class, *type, *p;
    if(qname == NULL
	    || (class = looktb(qc_table,qclass)) == NULL
	    || (type = looktb(qt_table,qtype)) == NULL
	    || (p = buffer) == NULL
	    || namtoa(p,qname) == NULL)
	punt;
    strend(p);
    if(sprintf(p," %s %s",class,type) == EOF)
	punt;
    return(buffer);
}

char *rrtoa(buffer,name,r)
    char *buffer, *name;
    struct rr *r;
{
    char *fmt, *p = buffer, *class, *type;
    union rdatom *a;

    if(p == NULL || r == NULL || (fmt = rrfmt(r->class,r->type)) == NULL
	    || (class = looktb(qc_table,r->class)) == NULL
	    || (type = looktb(qt_table,r->type)) == NULL
	    || namtoa(p,name) == NULL)
	punt;
    strend(p);
    if(sprintf(p," %d %s %s",r->ttl,class,type) == EOF)
	punt;
    strend(p);

    for(a = r->rdata; *fmt != '\0'; ++a, ++fmt) {
	*p = ' ';   *++p = '\0';
	switch(*fmt) {
	    case 'd':	if(namtoa(p,a->byte) == NULL)
			    punt;
			break;
	    case 's':	if(sprintf(p,"%.*s", *a->byte, a->byte+1) == EOF)
			    punt;
			break;
	    case '4':
	    case '2':	if(sprintf(p,"%d", a->word) == EOF)
			    punt;
			break;
	    case 'c':	if(sprintf(p,"%o", a->word) == EOF)
			    punt;
			break;
	    case 'i':	if(inatoa(p,a->word) == NULL)
			    punt;
			break;
    	    case 'w':	if(wkstoa(p,a->byte) == NULL)
			    punt;
			break;
	    default:	bugchk("rrdtoa","unknown rrfmt() token '%c'",*fmt);
			punt;
	}
	strend(p);
    }
    return(buffer);
}

char *wkstoa(buffer,vector)
    char *buffer, *vector;
{
    char *t, *p = buffer;
    int i;
    if((t = looktb(wp_table,*vector++)) == NULL) {
	bugchk("wkstoa","IP protocol %d not in wp_table",*--vector);
	punt;
    }
    if(sprintf(p,"%s",t) == EOF)
	punt;
    strend(p);
    for(i = 0; i < IN_WKS_TOTAL_LENGTH * 8; ++i)
	if(!((vector[i/8] << (i%8)) & 0200))
	    continue;
	else if((t = looktb(ws_table,i)) == NULL)
	    bugchk("wkstoa","WKS port %d not in ws_table",i);
	else if(sprintf(p," %s",t) == EOF)
	    punt;
	else
	    strend(p);
    return(buffer);
}
