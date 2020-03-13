/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* Don't ask... */
#define BIND_LOSES_ON_QR_BIT_IN_AXFRS 1

/*
 * Zone transfer program.
 *
 * stdin is configuration file.  Each line is of the form
 *
 *	name  class  file  tport  host
 *
 * where:
 *	name	= domain name of zone
 *	class	= class of zone (CH, IN)
 *	tport	= transport protocol (chaos, tcp)
 *	host	= host address to connect to
 *	file	= where to dump it
 */

#include "domsym.h"

/* gtable.c */
extern int gtable(void);

/* skipws.c */
extern int skipws(FILE *);

/* makqry.c */
extern int makqry(char8 *,int,int ,char *,int ,int );

/* load.c */
extern int zload(FILE *,struct zone *,struct btnode **,char *,int,int);

/* net20x.c */
extern int devtyp(char *);
extern int net_open(int,char *,int);
extern int net_send(int,char8 *,int );
extern int net_recv(int,char8 *,int );
extern int net_close(int);
extern int net_abort(int);
extern int net_check(int);

/* tim20x.c */
extern int zulu(void);

/* sio20x.c */
extern int fabort(FILE *);

/* gtoken.c */
extern int gtoken(FILE *,char *,int *,int);

/* src:<kccdist.kcc-6.lib.usys>sleep.c */
extern void sleep(int);

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif


/* zt.c */
int main P_((int argc,char *argv[]));
static int gtaddr P_((char *string,int tport));
static int atonam P_((char *name,char *string));
static soa_version P_((struct dom_header *header,struct domain *rrlist));
static upd_gotten P_((char *filename,struct zone *z));
static upd_retried P_((char *filename,struct zone *z));
static dump_node P_((FILE *stream,struct dom_header *header,
			struct domain *rrlist));
static goldz P_((char *filename,struct zone *z));
static valid P_((struct dom_header *h));
static pmeta P_((FILE *f,int var,int val));
static umeta P_((FILE *f,int var,int oldval,int newval));
int gc_now P_((void));

#undef P_


/* Macro to abort current zone with error message, go to next zone */
#define	punt(msg,action)					    \
		    {						    \
			bugchk("zt","%s: %s",msg,line);		    \
			if(netjfn != -1)			    \
			    net_abort(netjfn);			    \
			netjfn = -1;				    \
			if(want_retry)				    \
			    upd_retried(file,&oldz);		    \
			action;					    \
		    }

/*
 * It seems that the remote server is permitted to close the net
 * connection after the initial SOA query, but doesn't have to.  So we
 * wait a short time to see what it's going to do before proceeding.
 *
 * How many seconds to hang out to see if server is going to close after SOA:
 */
#define SNOOZE_INTERVAL	1

/* In case filename munging gets more complex later */
#define zfile(x,y) (strcpy(x,y))

main(argc, argv)
    int argc;
    char *argv[];
{
    FILE *f;
    int class, tport, host, soas[2], netjfn, size, soa_seen, id = 0;
    int want_retry, now;
    char line[STRSIZ], name[STRSIZ], file[STRSIZ];
    struct domain *rrlist;
    char8 bigbuf[4000];
    struct zone oldz;

    if(!gtable())
	bughlt("zt","main(): can't load string tables!");

/*
 * zt
 * xkl.com. in tcp 192.94.202.(33,37} xkl.zone
 * 94.202.192.in-addr.arpa. in tcp 192.94.202.{33,37} xkl.net
 */
    while(skipws(stdin) && gets(line) != NULL) {
	netjfn = -1;
	want_retry = 0;
	bzero((char *)bigbuf,sizeof(bigbuf));
	soas[0] = soas[1] = 0;
	if(!atonam(name,strtok(line," \t")))
	    punt("bad NAME",continue);
	if((class = tblook(qc_table,strtok(NULL," \t"))) < 0)
	    punt("bad CLASS",continue);
	if((tport = tblook(xp_table,strtok(NULL," \t"))) < 0)
	    punt("bad TPORT",continue);
	if((host = gtaddr(strtok(NULL," \t"),tport)) == -1)
	    punt("bad HOST",continue);
	if(zfile(file,strtok(NULL," \t")) == NULL)
	    punt("bad FILE",continue);
	if(!goldz(file,&oldz))
	    punt("lost reading old zone file",continue);
#if 0
	if(oldz.cachep)
	    punt("you can't zone-transfer the CACHE!",continue);
#endif
	now = zulu();

	if(DBGFLG(DBG_ZT))
	    buginf("zt","now=%d, refresh=%d, retry=%d, gotten=%d, retried=%d, refresh+gotten=%d, retry+retried=%d",
		    now, oldz.base.data.rrs->rdata[SOA_REFRESH].word,
		    oldz.base.data.rrs->rdata[SOA_RETRY].word, oldz.gotten, oldz.retried,
		    oldz.base.data.rrs->rdata[SOA_REFRESH].word+oldz.gotten,
		    oldz.base.data.rrs->rdata[SOA_RETRY].word+oldz.retried);

	if(oldz.gotten + oldz.base.data.rrs->rdata[SOA_REFRESH].word > now) {
	    printf("REFRESH interval not yet expired (%d, %d)\n",
		    oldz.gotten + oldz.base.data.rrs->rdata[SOA_REFRESH].word, now);
	    continue;
	}

	if(oldz.retried + oldz.base.data.rrs->rdata[SOA_RETRY].word > now) {
	    printf("Last failed refresh too recent (%d, %d)\n",
		    oldz.retried + oldz.base.data.rrs->rdata[SOA_RETRY].word, now);
	    continue;
	}

	if(oldz.gotten)
	    soas[0] = oldz.base.data.rrs->rdata[SOA_SERIAL].word;

	/* from here on we want to retry later if we fail */
	want_retry = 1;

	if((netjfn = net_open(host,CONTACT,tport)) < 0)
	    punt("couldn't connect",continue);

	size = makqry(bigbuf,++id,0,name,class,QT_SOA);

	if(!net_send(netjfn,bigbuf,size))
	    punt("couldn't send SOA query",continue);

	if((size = net_recv(netjfn,bigbuf,sizeof(bigbuf))) == 0)
	    punt("couldn't read preliminary SOA",continue);

	if(!valid(DOM_HEADER(bigbuf)))
	    punt("bad response to SOA query",continue);

	if((rrlist = rpkt((char *) bigbuf,size)) == NULL)
	    punt("couldn't parse reply to SOA query",continue);
	
	/* check to see if server answered the question we asked? */

	printf("Received packet:\n");
	dump_node(stdout,DOM_HEADER(bigbuf),rrlist);
	printf("\n\n");

	soas[1] = soa_version(DOM_HEADER(bigbuf),rrlist);
	kil_domain(rrlist,0);
	if(soas[1] < 0)
	    punt("couldn't find SOA version number (SOA query)",continue);

	if(soas[1] <= soas[0]) {	/* need to update? */
	    printf("SOA version number >= current (%d, %d), no update needed.\n",
		    soas[0], soas[1]);
	    if(!net_close(netjfn))	/* done with net connection */
		net_abort(netjfn);	/* just flush if doesn't close clean */
	    upd_gotten(file,&oldz);	/* update the ttl of our copy */
	    continue;			/* and loop for next zone */
	}

	printf("Old SOA version = %d, New SOA version = %d, proceeding...\n",
		soas[0], soas[1]);

	sleep(SNOOZE_INTERVAL);
	if(!net_check(netjfn)) {	/* remote side punted? */
	    net_abort(netjfn);		/* yes, flush old connection */
	    netjfn = -1;
	    if((netjfn = net_open(host,CONTACT,tport)) < 0)
		punt("couldn't re-connect after remote side punted",continue);
	}

	size = makqry(bigbuf,++id,0,name,class,QT_AXFR);

	if(!net_send(netjfn,bigbuf,size))
	    punt("couldn't send AXFR query",continue);

	soa_seen = 0;			/* need to see two of these */

	if((f = fopen(file,"w")) == NULL)
	    punt("couldn't open new zone file",continue);

	fprintf(f,";;; Zone retrieved by %s\n;;;\n;;; Config: %s\n\n",
		    argv[0], line);	/* for human consumption */

	pmeta(f, ZL_DATE, zulu());	/* dump meta-variables */
	pmeta(f, ZL_RETRY, 0);
	fputc('\n',f);

	while(soa_seen < 2) {		/* we need to see two SOAs */

	    int losing;			/* what the hell, make it local */

	    if((size = net_recv(netjfn,bigbuf,sizeof(bigbuf))) == 0)
		punt("couldn't read node from AXFR stream",break);

#ifndef BIND_LOSES_ON_QR_BIT_IN_AXFRS
	    if(!valid(DOM_HEADER(bigbuf)))
		punt("bad response to AXFR query",break);
#endif

	    if((rrlist = rpkt((char *) bigbuf,size)) == NULL) {
	        fclose(f);
		punt("couldn't parse node in AXFR stream",break);
	    }

	    if((soas[soa_seen] = soa_version(DOM_HEADER(bigbuf),rrlist)) >= 0)
		++soa_seen;

	    if(soas[0] < 0)
		punt("never saw first SOA of zone",break);

	    losing = soa_seen < 2 && !dump_node(f,DOM_HEADER(bigbuf),rrlist);

	    kil_domain(rrlist,0);

	    if(losing)
		punt("couldn't dump AXFR node",break);
	}

	if(soa_seen < 2) {
	    fabort(f);			/* this -should- exist! */
	    continue;			/* already spake error message */
	}				/* so just loop for next */

	if(soas[0] != soas[1]) {
	    fabort(f);
	    bugchk("zt","SOA version changed during update! (%d,%d)",soas[0],soas[1]);
	    punt("I'm too lame to recover from that",continue);
	}

	fclose(f);			/* won, put it on disk */

	printf("Successfully retrieved zone version %d\n", *soas);
    }
}

#undef punt


static int gtaddr(string,tport)
    char *string, tport;
{
    int i;

    switch(tport) {
	case XP_CHAOS:
	    return(sscanf(string,"%o",&i) == 1 ? i : -1);
	case XP_TCP:
	    return(atoina(string));
	default:
	    return(-1);
    }
}

static int atonam(name,string)
    char *name,*string;
{
    char *count;

    if(name == NULL || string == NULL || *string == '\0'
      || string[strlen(string)-1] == '\\')
	return(0);

    for(*(count = name++) = 0; *string != '\0'; string++)
	switch(*string) {
	    case '.':	count = name++;
			*count = 0;
			continue;
	    case '\\':	++string;
	    default:	*name++ = *string;
			*count = (char)(1+(*count)); /* ++ causes bad code */
			continue;
	}
    return(1);
}

static soa_version(header,rrlist)
    struct dom_header *header;
    struct domain *rrlist;
{
    int i;
    struct rr *r = NULL;

    for(i = header->qdcnt; i > 0 && rrlist != NULL; i--)
	rrlist = rrlist->link.dpoint;

    for(i = header->ancnt + header->nscnt + header->arcnt;
	    i > 0 && rrlist != NULL;  --i, rrlist = rrlist->link.dpoint)
	if(rrlist->data.rrs->type == QT_SOA) {
	    if(r == NULL)
		r = rrlist->data.rrs;
	    else
		return(-1);		/* can't have more than one SOA */
	}
    if(r == NULL)
	return(-1);			/* no SOA found, lose */

    return(r->rdata[SOA_SERIAL].word);	/* extract the SERIAL field, done */
}

static upd_gotten(filename,z)
    char *filename;
    struct zone *z;
{
    FILE *f = fopen(filename,"r+");
    umeta(f, ZL_DATE, z->gotten, zulu());
    umeta(f, ZL_RETRY, z->retried, 0);
    fclose(f);
}

static upd_retried(filename,z)
    char *filename;
    struct zone *z;
{
    FILE *f = fopen(filename,"r+");
    umeta(f, ZL_RETRY, z->retried, zulu());
    fclose(f);
}

static dump_node(stream,header,rrlist)
    FILE *stream;
    struct dom_header *header;
    struct domain *rrlist;
{
    int i;
    char rrtext[STRSIZ];
    for(i = header->qdcnt; i > 0; i--)
	rrlist = rrlist->link.dpoint;
    for(i = header->ancnt+header->nscnt+header->arcnt; i > 0; i--) {
	if(rrtoa(rrtext,rrlist->name,rrlist->data.rrs) == NULL)
	    return(0);
	if(DBGFLG(DBG_ZT))
	    buginf("dump_node","dumping RR: %s",rrtext);
	if(fprintf(stream,"%s\n",rrtext) == EOF)
	    return(0);
	rrlist = rrlist->link.dpoint;
    }
    fflush(stream);
    return(1);
}

static goldz(filename,z)
    char *filename;
    struct zone *z;
{
    FILE *f;
    int result;

    bzero((char *)z, sizeof(struct zone));
    if((f = fopen(filename,"r")) == NULL) {
	buginf("goldz","couldn't open file \"%s\", creating new\n",filename);
	return(1);			/* allow non-existant file */
    }
    result = zload(f,z,NULL,".",-1,1);
    fclose(f);
    return(result);
}

/* see if a packet we got is "valid". returns boolean. */


#define	punt(msg) return(bugchk("valid",(msg)),0)

static valid(h)
    struct dom_header *h;
{
    if(!h->resp)
	punt("packet isn't a response");
    if(h->op != OP_QUERY)
	punt("packet opcode isn't QUERY");
    if(h->tc)
	punt("packet is truncated");
    if(h->rcode != ER_OK) {
        char *p;
	if((p = looktb(er_table,h->rcode)) != NULL)
	    bugchk("valid","nameserver returned error: \"%s\"",p);
	else
	    bugchk("valid","nameserver returned bogus error code: %d",h->rcode);
	return(0);
    }
    if(h->qdcnt > 1)
	punt("too many items in question section of packet");
    return(1);				/* I guess it's ok, then */
}
#undef punt

/* Field size for meta-whozis integers.  Leave enough to update in place. */
#define	PMETA_FIELD_SIZE    14

/* Dump a meta-whozis. */
static pmeta(f, var, val)
    FILE *f;
    int var, val;
{
    char *p = looktb(zl_table, var);

    if(p != NULL)
	fprintf(f,"$%s %-*d\n", p, PMETA_FIELD_SIZE, val);
}

/* Update a meta-whozis. */
static umeta(f, var, oldval, newval)
    FILE *f;
    int var, oldval, newval;
{
    int crockp = 0;			/* no line continuation yet */
    char s[STRSIZ];
    int here, i;

    if(f == NULL)
	return(0);

    fseek(f,0,0);			/* start at begining of file */
    while((i = gtoken(f,s,&crockp,1)))	/* get a leading token */
	if(*s == '$' && tblook(zl_table,s+1) == var)
	    break;
	else				/* skip "line" if not */
	    while(*s != '\n')		/* what we were looking for */
		gtoken(f,s,&crockp,1);
    if(!i)				/* return failure if EOF */
	return(0);			/* before finding right token */
    here = ftell(f);			/* remember where we are */
    if(fscanf(f," %d", &i) != 1 || i != oldval)
	return(0);			/* fail if old value doesn't match */
    return(fseek(f,here,0) == 0		/* reposition, dump newval, return */
	&& fprintf(f," %-*d", PMETA_FIELD_SIZE, newval) != EOF);
}


/* Nop for memory allocation panics, since there's nothing we can do. */

int gc_now()
{
}

   