/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/*
 * rrdump(stream,name,rr) -- write out rr in text form to stream.
 */

#include "domsym.h"

#define punt	return(0)

int rrdump(f,name,r)
    FILE *f;
    char *name;
    struct rr *r;
{
    char *c = looktb(qc_table,r->class);
    char *t = looktb(qt_table,r->type);
    char *fmt = rrfmt(r->class,r->type);
    union rdatom *a;

    if(c == NULL || t == NULL || fmt == NULL)
	punt;

    if(!namout(f,name))
	punt;
    fprintf(f," %d %s %s",r->ttl,c,t);

    for(a = r->rdata; *fmt != '\0'; ++a, ++fmt)
	switch(*fmt) {
	    case 'd':	if(fputc(' ',f) == EOF || !namout(f,a->byte))
			    punt;
			continue;
	    case 's':	if(fprintf(f," %.*s", *a->byte, a->byte+1) == EOF)
			    punt;
			continue;
	    case '4':
	    case '2':	if(fprintf(f," %d", a->word) == EOF)
			    punt;
			continue;
	    case 'c':	if(fprintf(f," %o", a->word) == EOF)
			    punt;
			continue;
	    case 'i':	if(fputc(' ',f) == EOF || !inaout(f,a->word))
			    punt;
			continue;
    	    case 'w':	if(!wksout(f,a->byte))
			    punt;
			continue;
	    default:	punt;
	}

    if(fputc('\n',f) == EOF)
	punt;
    return(1);
}

static int wksout(f,vector)
    FILE *f;
    char *vector;
{					/* gross city */
    char *p;
    int i;

    if((p = looktb(wp_table,*vector++)) == NULL)
	punt;

    fprintf(f," %s",p);

    for(i = 0; i/8 < IN_WKS_TOTAL_LENGTH; i++)
	if( ((vector[i/8] << (i%8)) & 0200) && (p = looktb(ws_table,i)) != NULL)
	    fprintf(f," %s", p);

    return(1);
}


/* If you think you understand this routine you are probably wrong. */
/* Is -not- static, somebody else may have a use for it. */

int namout(f,name)
    FILE *f;
    char *name;
{
    int i;

    while((i = *name++) != 0) {
	while(--i >= 0)
	    if(*name == '.' && fputc('\\',f) == EOF || fputc(*name++,f) == EOF)
		punt;
	if(fputc('.',f) == EOF)
	    punt;
    }

    return(1);
}



int inaout(f,addr)
    FILE *f;
    int addr;
{
    char buf[STRSIZ];
    return(inatoa(buf,addr) && fputs(buf,f) != EOF);
}
