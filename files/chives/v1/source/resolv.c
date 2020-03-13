/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Main resolver code.
 */

/* Changes made by Robert W. Fletcher are controlled by the following
 * conditional for historical purposes.
 */
#define CODE_BEFORE_RWF_CHANGES 0

#include "domsym.h"
#include "usrdef.h"
#include "udp.h"

/* Database roots */
static struct btnode *zones = NULL, *cache = NULL, *ncache = NULL;
static struct query_block *queue = NULL;

/* Gunning and crashdump control flags */
static int gunned = 0;			/* Whether we have been gunned */
static int reboot = 0;			/* Whether we should reboot */
static int d_reboot = 1;		/* Reboot value (after init) */
static int dump = 1;			/* Whether we should crashdump */
static int d_dump = 1;			/* Dump value (after init) */

/* Search paths */
static char *nullsearch[2] = {"",NULL};	/* Root-only RSEARCH path */
static char **lsearch = NULL;		/* Local data search path */
static char **rsearch = NULL;		/* Resolving search path */

/* Users who can frob the resolver */
static char **whoprs = NULL;		/* Initalized from config file */

/* Default servers */
static int ndserve = 0;			/* How many default servers */
static struct ns_atom *dserve = NULL;	/* and the list itself */

/* Timeouts for resolving */
static int rxmt_period = 5;		/* seconds between packets */
static int max_tries = 3;		/* tries per server per query */
static int qry_tmo = 40;		/* max ttl for a query */
static int max_cname = 10;		/* max number of cnames to follow */
static int maxttl = 30*24*60*60;	/* max reasonable incoming TTL  */
static int ttl_punt = 0;		/* punt RRs with TTLs too big */

/* Parameters for zzz(). */
static int poll_busy = 3;		/* poll interval when busy */
static int poll_idle = 5;		/* poll interval when idle */

/* Checkpoint control. */
static int chkini = 0;			/* Make initial checkpoint dump */

/* Negative cache control */
static int neg_ok = 1;			/* Ok to use negative cache */

/* GC parameters. */
static int gc_interval = 12*60*60;	/* How often to GC (seconds) */

/* How often we should force bug/log file out to disk */
static int bugflush = 15;		/* Set to zero to inhibit entirely */

/* Sizes of UDP packet buffers (plus one word for twenex SNDIN%/RCVIN%). */
#define	BIG_UDP_PACKET	    (4*IP_MINPKT + sizeof(int))
#define LITTLE_UDP_PACKET   (  IP_MINPKT + sizeof(int))

/* Reserved foreign port number (looked up in ASSIGNED.PORTS at boot time). */
static int udp_fport;

/* tim20x.c */
extern int zulu(void);

/* gtable.c */
extern int gtable(void);

/* bug20x.c */
extern int chkpnt(char *);
extern int bootme(char *,int);

/* zzz20x.c */
extern void zzz(int,int );

/* gc.c */
extern int gc(struct btnode **,struct btnode **,struct btnode **);

/* skipws.c */
extern int skipws(FILE *);

/* load.c */
extern int zload(FILE *,struct zone *,struct btnode **,char *,int,int );
extern int cload(FILE *,struct btnode **);


/* insert.c */
extern int insert(struct btnode **,char *,struct rr *,int,int);

/* src:<kccdist.kcc-6.lib.usys>exit.c */
extern void exit(int);

/* lookup.c */
extern void kil_answer(struct domain *);
extern int lookup(char *,char *,int,int ,struct btnode *,struct btnode *,
			struct btnode*,int,int,int *,int,struct domain **,
			struct domain **,char **);

/* match.c */
extern int cmatch(int,int );
extern int tmatch(int,int );
extern int cknown(int);
extern int tknown(int);

/* usr20x.c */
extern int usr_whopr(struct query_block *,char **);

/* rpkt.c */
extern void qpeek(char8 *,char **,int *,int *); 

/* makqry.c */
extern int makqry(char8 *,int,int ,char *,int ,int );

/* resolv.c */
int main(void);
int gc_now(void);
int config(void);
void enqueue(struct query_block *);
void dequeue(struct query_block *);
int do_request(void);
struct domain *init_query(struct query_block *,struct domain *);
int do_retry(void);
int do_answer(void);

/* resolv.c */
static int best_address(struct rr *);
static int ns_bind(struct query_block *,struct rr *);
static int addqry(char *,int,int ,int ,int ,int );
static int ns_next(struct query_block *);
static long nxtseq(void);
static sndqry(struct query_block *);
static kil_query(struct query_block *);


/* Resolver initialization and main loop. */

main()
{
    int am_busy, was_busy, next_gc, next_bugflush;

    if(!bugini("RESOLV",fopen(rl_name,"w"),rb_name,&reboot,&dump))
	bughlt("resolv","couldn't initialize bugxxx() code");

    if(!gtable())
	bughlt("resolv","can't load string tables");

    if((udp_fport = tblook(ws_table,CONTACT)) == -1)
	bughlt("resolv","couldn't find udp port number");

    if(!config())
	bughlt("resolv","lost reading config file");

    if(chkini)
	switch(chkpnt(ic_name)) {
	    case CHKPNT_LOSE:
		bughlt("resolv","couldn't make initial checkpoint");
	    case CHKPNT_WIN:
		exit(0);
	    case CHKPNT_RESTART:
		if(!bugini("RESOLV",fopen(rl_name,"w"),rb_name,&reboot,&dump))
		    bughlt("resolv","couldn't initialize bugxxx() code");
		break;
	    default:
		bughlt("resolv","unknown status code returned by chkpnt()");
	}

    if(!usr_init())
	bughlt("resolv","couldn't initialize user interface");
    mkcrit(usr_fini,NULL);

    if(!udp_init(-1,0))
	bughlt("resolv","couldn't initialize UDP package");
    mkcrit((void (*)(void)) udp_fini,NULL);

    if(DBGFLG(DBG_LOG|DBG_RESOLV))
	buginf("resolv","initialization complete");

    reboot = d_reboot;
    dump = d_dump;
    next_gc = zulu() + gc_interval;
    am_busy = next_bugflush = 0;

    while(!gunned) {
	was_busy = am_busy; am_busy = 0;
	if(DBGFLG(~0) && bugflush != 0 && next_bugflush < zulu()) {
	    bugfls();			/* Force log out if desired */
	    next_bugflush = zulu() + bugflush;
	}
	while(do_answer())		/* Any incoming answers? */
	    ++am_busy;
	while(do_request())		/* Any new user requests? */
	    ++am_busy;
	am_busy += do_retry();		/* Anything needing more processing? */
	if(am_busy)			/* Keep going if currently active */
	    continue;
	if(!was_busy && gc_interval > 0 && zulu() > next_gc) {
	    if(DBGFLG(DBG_RESOLV|DBG_GC|DBG_LOG))
		buginf("resolv","garbage collecting");
	    gc_now();
	    if(DBGFLG(DBG_GC))
		buginf("resolv","finished garbage collecting");
	    next_gc = zulu() + gc_interval;
	}
	else				/* Otherwise, catch some sleep */
	    zzz((was_busy ? poll_busy : poll_idle), was_busy);
    }

    buginf("resolv","gunned, reboot=%d",reboot);
    bugfls();				/* force log */
    docrit(1);				/* clean up system stuff */
    if(reboot)				/* want reboot? */
	bootme(rb_name,0);		/* yes, do it, no delay */
    else
        exit(0);			/* no, exit gracefully */
}


/*
 * Garbage collect our data structure.
 * Available for panic calls from memory module.
 */

int gc_now()
{
    return(gc(&zones,&cache,&ncache));
}


/* Read configuration file. */

int config()
{
    extern char *nam_in(char *,char *,char *);
    char s[STRSIZ], t[STRSIZ], *p, origin[STRSIZ];
    FILE *cf, *zf;
    int option, lost = 0, i;
    struct zone *z;

    /* Do not optimize this out, it's for the memory alloc debugging code. */
    static char *nullstring = "";

    /* Initialize first entry in local search path to the root */
    lsearch = (char **) mak(sizeof(char *)*2);
    lsearch[0] = nullstring;	lsearch[1] = NULL;

    if((cf = fopen(cf_name,"r")) == NULL) {
	bugchk("config","couldn't open config file \"%s\"",cf_name);
	return(0);
    }
    while(!lost && skipws(cf))
	if(fscanf(cf,"%s",s) != 1 || (option = tblook(cf_table,s)) == -1) {
	    bugchk("config","bad keyword \"%s\"",s);
	    ++lost;
	} else switch(option) {
	    case CF_RSEARCH:
	    case CF_LSEARCH:
		if(!skipws(cf) || fscanf(cf,"%s",s) != 1) {
		    bugchk("config","LSEARCH/RSEARCH: no name found");
		    ++lost;
		} else if((p = nam_in(NULL,s,".")) == NULL) {
		    bugchk("config","LSEARCH/RSEARCH: bad name \"%s\"",s);
		    ++lost;
		} else {
		    char ***search = (option == CF_RSEARCH) ? &rsearch
							    : &lsearch;
		    i = 0;
		    if(*search != NULL)
			while((*search)[i] != NULL)
			    ++i;
		    *search = (char **)remak_(*search,(sizeof(char *)*(i+2)));
		    (*search)[i] = p;
		    (*search)[++i] = NULL;
		}
		continue;

	    case CF_WHOPR:
		if(!skipws(cf) || fscanf(cf,"%s",s) != 1) {
		    bugchk("config","WHOPR: no name found");
		    ++lost;
		} else {
		    i = 0;
		    if(whoprs != NULL)
			while(whoprs[i] != NULL)
			    ++i;
		    whoprs = (char **)remak_(whoprs,(sizeof(char *)*(i+2)));
		    whoprs[i] = bcons(s,strlen(s)+1);
		    whoprs[++i] = NULL;
		}
		continue;

	    case CF_DSERVE:
		if(!skipws(cf) || fscanf(cf,"%s%*[^\n]",s) != 1) {
		    bugchk("config","DSERVE: no name server address");
		    ++lost;
		} else if((i = atoina(s)) <= 0) {
		    bugchk("config","DSERVE: bad name server address %s",s);
		    ++lost;
		} else if((dserve == NULL) != (ndserve == 0)) {
		    bugchk("config","internal DSERVE/NDSERVE mismatch");
		    ++lost;
		} else {
		    dserve = (struct ns_atom *)remak_(dserve,(sizeof(struct ns_atom)*(ndserve+2)));
		    dserve[ndserve].addr = i;
		    dserve[ndserve].depends = -1;
		    bzero((char *)&dserve[++ndserve],sizeof(struct ns_atom));
		}
		continue;

	    case CF_ZLOAD:
		if(!skipws(cf) || fscanf(cf,"%s",origin) != 1) {
		    bugchk("config","ZLOAD: no domain name found");
		    ++lost;
		} else if(nam_in(t,origin,".") == NULL) {
		    bugchk("config","ZLOAD: bad domain name \"%s\"",origin);
		    ++lost;
		} else if(!skipws(cf) || fscanf(cf,"%[^\n]\n",s) != 1) {
		    bugchk("config","ZLOAD: no file name found");
		    ++lost;
		} else if((zf = fopen(s,"r")) == NULL) {
		    bugchk("config","ZLOAD: couldn't open file \"%s\"",s);
		    ++lost;
		} else {
		    i = zload(zf,(z = mak_zone()),&cache,origin,-1,0);
		    fclose(zf);
		    if(!i || !insert(&zones,t,(struct rr *)z,0,0)) {
			bugchk("config","ZLOAD: zload() or insert() failure for \"%s\" from \"%s\"",origin,s);
			kil_zone(z);
			++lost;
		    } else {
			z->srcfil = bcons(s,strlen(s)+1);
		    }
		}
		continue;

	    case CF_CLOAD:
		if(!skipws(cf) || fscanf(cf,"%[^\n]\n",s) != 1) {
		    bugchk("config","CLOAD: no file name found");
		    ++lost;
		} else if((zf = fopen(s,"r")) == NULL) {
		    bugchk("config","CLOAD: bad file name \"%s\"",s);
		    ++lost;
		} else if((i = cload(zf,&cache), fclose(zf), !i)) {
		    bugchk("config","CLOAD: cload() failure for \"%s\"",s);
		    ++lost;
		}
		continue;

	    case CF_RXMT:
		if(!skipws(cf) || fscanf(cf,"%d",&rxmt_period) != 1) {
		    bugchk("config","bad retransmission interval");
		    ++lost;
		}
		continue;

	    case CF_QRYTMO:
		if(!skipws(cf) || fscanf(cf,"%d",&qry_tmo) != 1) {
		    bugchk("config","bad query timeout interval");
		    ++lost;
		}
		continue;

	    case CF_MAXTTL:
		if(!skipws(cf) || fscanf(cf,"%d",&maxttl) != 1) {
		    bugchk("config","bad maximum TTL");
		    ++lost;
		}
		continue;

	    case CF_MAXTRY:
		if(!skipws(cf) || fscanf(cf,"%d",&max_tries) != 1) {
		    bugchk("config","bad maximum tries per server");
		    ++lost;
		}
		continue;

	    case CF_MAXCNAME:
		if(!skipws(cf) || fscanf(cf,"%d",&max_cname) != 1) {
		    bugchk("config","bad max cname count");
		    ++lost;
		}
		continue;

	    case CF_GCPERIOD:
		if(!skipws(cf) || fscanf(cf,"%d",&gc_interval) != 1) {
		    bugchk("config","bad gc interval");
		    ++lost;
		}
		continue;

	    default:
		continue;
	}

    if(!feof(cf)) {
	bugchk("config","didn't finish config file (%d)",ftell(cf));
	++lost;
    }
    fclose(cf);

    /* Check that search paths at least contain the root entry */
    if(lsearch == NULL)			/* might not be set at all */
	lsearch = nullsearch;
    else {				/* check for root entry */
	for(i = 0; lsearch[i] != NULL; ++i)
	    if(*lsearch[i] == '\0')	/* exit if we find the root */
		break;
	if(lsearch[i] == NULL) {	/* if we didn't find it, add it */
	    lsearch = (char **)remak_(lsearch,(sizeof(char *)*(i+2)));
	    lsearch[i] = "";		/* last entry is root */
	    lsearch[i+1] = NULL;	/* tie off list */
	}
    }
    if(rsearch == NULL)			/* might not be set at all */
	rsearch = nullsearch;
    else {				/* check for root entry */
	for(i = 0; rsearch[i] != NULL; ++i)
	    if(*rsearch[i] == '\0')	/* exit if we find the root */
		break;
	if(rsearch[i] == NULL) {	/* if we didn't find it, add it */
	    rsearch = (char **)remak_(rsearch,(sizeof(char *)*(i+2)));
	    rsearch[i] = nullstring;	/* last entry is root */
	    rsearch[i+1] = NULL;	/* tie off list */
	}
    }

    /* Log all the stuff that we will never release as deallocated. */
    if(DBGFLG(DBG_MEMORY)) {
	if(dserve != NULL)
	    buginf("config","deallocating %012o [dserve list]",
		    (char *) dserve);
	if(lsearch != nullsearch) {
	    buginf("config","deallocating %012o [lsearch list]",
		    (char *) lsearch);
	    for(i = 0; lsearch[i] != NULL; ++i)
		if(lsearch[i] != nullstring)
		    buginf("config","deallocating %012o [lsearch #%d]",
			    lsearch[i], i);
	}
	if(rsearch != nullsearch) {
	    buginf("config","deallocating %012o [rsearch list]",
		    (char *) rsearch);
	    for(i = 0; rsearch[i] != NULL; ++i)
		if(rsearch[i] != nullstring)
		    buginf("config","deallocating %012o [rsearch #%d]",
			    rsearch[i], i);
	}
	if(whoprs != NULL) {
	    buginf("config","deallocating %012o [whoprs list]",
		    (char *) whoprs);
	    for(i = 0; whoprs[i] != NULL; ++i)
		buginf("config","deallocating %012o [whoprs #%d]",
			whoprs[i], i);
	}
    }

    return(!lost);
}



/* Add query to queue.  NB: do_retry() assumes this adds at head of queue. */
void enqueue(query)
    struct query_block *query;
{
    query->next = queue;
    queue = query;
    return;
}

/* Unlink a query from the queue (doesn't kill it) */
void dequeue(query)
    struct query_block *query;
{
    struct query_block **q = &queue;
    while(*q != NULL && *q != query)
	q = &((*q)->next);
    if(*q != NULL)
	*q = ((*q)->next);
    return;
}

/* Select best address from a list of RRs. */
static int best_address(r)
    struct rr *r;
{
    int n = 0, addrs[100];
    for( ; r != NULL; r = r->chain)
	if(r->class != QC_IN || r->type != QT_A)
	    bugchk("best_address","bad RR: class=%s, type=%s",
		    looktb(qc_table,r->class), looktb(qt_table,r->type));
	else if(n < sizeof(addrs)/sizeof(int))
	    addrs[n++] = r->rdata[IN_A_ADDRESS].word;
	else
	    bugchk("best_address","too many A RRs, ignoring extras");
    if(DBGFLG(DBG_RESOLV)) {
	char s[STRSIZ];
	int i;
	for(i = 0; i < n; ++i)
	    buginf("best_address","before[%d]: %s",i,inatoa(s,addrs[i]));
    }
    udp_sort(n,addrs);
    if(DBGFLG(DBG_RESOLV)) {
	char s[STRSIZ];
	int i;
	for(i = 0; i < n; ++i)
	    buginf("best_address","after[%d]: %s",i,inatoa(s,addrs[i]));
    }
    return(addrs[0]);
}

/* How much sooner a recursive query should terminate. */
#define	TTD_BACKOFF 5

/* ns_bind() -- get address bindings for a list of nameservers.
 *
 * This routine attempts to bind addresses to nameserver names
 * (presumably returned as delegation pointers by lookup()).  There
 * are three cases:
 *
 *	The nameserver name is bogus.  We just ignore it.  Maybe we
 *	should log an error somewhere.
 *
 *	The nameserver name is ok, and we have addresses for it.  We
 *	pick the single "best" address from the available A RRs.  We
 *	might want to do something with all the addresses instead, but
 *	it seems needlessly complex, and won't gain us much
 *	(assumption is that most things that will keep a server from
 *	answering on one particular address will keep it from
 *	answering on any address.  At any rate, we don't keep track of
 *	the nameserver name in this case (avoid consing overhead).
 *	This could be changed trivially if needed.
 *
 *	The name is ok (well, we don't know it's bad, anyway) but we
 *	have no addresses for it.  We queue up another query looking
 *	for the missing A RRs, with the background mode bit set and a
 *	TTD before ours, to be sure we don't consume all our resources
 *	handling this.  The quid word in such a query will be zero.
 *
 * Returns number of addresses succesfully bound (case 2).
 */
static int ns_bind(query,ns_list)
    struct query_block *query;
    struct rr *ns_list;
{
    struct ns_atom *result;
    struct rr *r;
    int i;
    int mba = (query->flags & UF_MBA);
    int ttd = (query->qttd - TTD_BACKOFF);
    int now = zulu();
    int nbound = 0;


    if(query == NULL) {
	bugchk("ns_bind","NULL query argument");
	return(0);
    }

    if(query->ns_list != NULL) {
	if(DBGFLG(DBG_RESOLV))
	    buginf("ns_bind","existing query->ns_list %o",query->ns_list);
	for(i = 0; i < query->ns_count; ++i)
	    if(query->ns_list[i].name != NULL)
		kil(query->ns_list[i].name);
	kil_(query->ns_list);
	query->ns_list = NULL;
	query->ns_count = 0;
    }
#if CODE_BEFORE_RWF_CHANGES

     if (ns_list == NULL) {
#else
/*
 * Do not attempt to used nameservers learned -- only use default
 * nameservers. Ignore passed in ns_list.
 */
     if ((ns_list == NULL) || (ns_list != NULL)) {/* No delegation at all? */
#endif
	struct ns_atom *p;		/* Then use default servers and */
	if((p = dserve) == NULL)	/* start background root query. */
	    bughlt("ns_bind","NULL delegation and no default servers");
	result = query->ns_list
	       = (struct ns_atom *)
		    mak((i = ndserve)*sizeof(struct ns_atom));
	while(--i >= 0)
	    *result++ = *p++;
#if CODE_BEFORE_RWF_CHANGES
/*
 * Don't generate a request for name servers; use default servers.
 */
	addqry("",QC_IN,QT_ANY,now,ttd,UF_EMO|UF_RBK|UF_MBA);
#endif
	return(query->ns_count = ndserve); /* All default servers are bound. */
    }

    i = 0;
    for(r = ns_list; r != NULL; r = r->chain)
	++i;
    query->ns_list = result
		   = (struct ns_atom *)mak(i*sizeof(struct ns_atom));
    query->ns_count = i;

    for(r = ns_list; r != NULL;  r = r->chain, ++result)
	if(r->type == QT_NS) {
	    char *name = r->rdata[NS_NSDNAME].byte;
	    struct domain *addr_list = NULL;
	    int ncname = 0;
	    if(DBGFLG(DBG_RESOLV)) {
		char rrtext[STRSIZ];
		int nameok = namtoa(rrtext,name) != NULL;
		buginf("ns_bind","trying to bind \"%s\"",(nameok?rrtext:"??"));
	    }
	    if((i = lookup(name,NULL,QC_IN,QT_A,zones,cache,ncache,mba,
			query->qnow,&ncname,max_cname,&addr_list,
			NULL,NULL)) != UE_OK) {
		if(DBGFLG(DBG_LOG|DBG_RESOLV)) {
		    char rrtext[STRSIZ];
		    namtoa(rrtext,name);
		    buginf("ns_bind","bad server data, name=\"%s\", error=%d",rrtext,i);
		}
		continue;			/* Error for SERVER, bad data!! */
	    }
	    else if(addr_list != NULL) {	/* Got some addresses, pick one */
		result->addr = best_address(addr_list->data.rrs);
		kil_answer(addr_list);
		++nbound;
	    }
	    else if(ttd <= now)		/* No addresses and timed out */
		continue;
	    else if(namcmp(name,query->qname) == 0) { /* Avoid infinite loop */
		if(DBGFLG(DBG_RESOLV)) {
		    char rrtext[STRSIZ];
		    buginf("ns_bind","avoiding infinite recursion: %s",
			    rrhtoa(rrtext,query->qname,query->class,query->type));
		}
		result->name = bcons(name,namlen(name));
	    }
	    else {				/* Maybe start a recursive resolve */
		result->depends = addqry(name,QC_IN,QT_A,now,ttd,
				    (mba ? UF_EMO|UF_RBK|UF_MBA : UF_EMO|UF_RBK));
		result->name = bcons(name,namlen(name));
	    }
	}
    return(nbound);
}

/* Support routine for ns_bind(), to avoid duplication of code. */
static int addqry(qname,qclass,qtype,qnow,qttd,qflags)
    char *qname;
    int qclass,qtype,qnow,qttd,qflags;
{
    struct query_block *q;
    for(q = queue; q != NULL; q = q->next)
	if(q->class == qclass && q->type == qtype && namcmp(qname,q->qname) == 0)
	    break;
    if(q == NULL) {
	q = (struct query_block *)mak(sizeof(struct query_block));
	q->seq = nxtseq();
	q->qttd = qttd;
	q->qnow = qnow;
	q->class = qclass;
	q->type = qtype;
	q->qname = bcons(qname,namlen(qname));
	q->flags = qflags;
	q->state = new;
	enqueue(q);
    }
    return(q->seq);
}

/*
 * ns_next() -- find the next server address we should talk to.
 * Returns zero if we ran out of addresses.
 */

static int ns_next(q)
    struct query_block *q;
{
#define	ns_incr(foo) (((foo)+1) % q->ns_count)
    int i;
    if(q == NULL || q->ns_list == NULL || q->ns_count <= 0 || q->ns_idx < 0)
	return(0);
    if((i = q->ns_idx) >= q->ns_count)
	i = q->ns_idx = 0;
    do
	if(q->ns_list[i].addr != 0 && ++(q->ns_list[i].count) <= max_tries)
	    return(q->ns_idx = ns_incr(i), q->ns_list[i].addr);
    while((i = ns_incr(i)) !=  q->ns_idx);
    return(0);
#undef	ns_incr
}

/*
 * Generate next sequence number.  This is a 16 bit value,
 * appropriate for sticking in the id field of a network
 * query packet.
 */

#define NXTSEQ_MAX  0xFFFF

static long nxtseq()
{
    static long seed = 0;
    return(++seed > NXTSEQ_MAX ? (seed = 0) : seed);
}

/* Compare two numbers, modulo 2**16. */
#define	seq_lt(a,b) ((((long)(a))-((long)(b)))&(NXTSEQ_MAX^(NXTSEQ_MAX>>1)))

/* 
 * Process one user request.  Return boolean indicating
 * whether or not we did anything.
 */

#define	reply(r_code,r_lst) {	q->rcode = r_code;		    	\
				if(!(q->flags&UF_RBK))		    	\
				    usr_send(q,r_lst); 		    	\
				kil_query(q);			    	\
				if(r_lst != NULL) kil_answer(r_lst);	\
				return(1);			    	\
			    }

int do_request()
{
    struct query_block *q;
    struct domain *answer = NULL, *delegation = NULL;
    int rc;
    char **search;

    if((q = usr_recv()) == NULL)
	return(0);

    if(q->class == QC_CTL)		/* Control message? */
	switch(q->type) {		/* Yup, dispatch by type */
	    case UC_AYT:		/* Ping */
		reply(UE_ACK,NULL);	/* Well, that's easy enough... */
	    case UC_KIL:		/* Wants us to die off for good */
		if(!usr_whopr(q,whoprs))/* Is this person authorized? */
		    reply(UE_ADM,NULL);	/* No, sorry, can't comply */
		reboot = 0;		/* Yes, set it up */
		gunned = 1;		/* Our last glass of elderberry wine */
		reply(UE_ACK,NULL);	/* Ok, we'll do it when we can */
	    case UC_BUT:		/* Wants us to reload self */
		if(!usr_whopr(q,whoprs))/* Is this person authorized? */
		    reply(UE_ADM,NULL);	/* No, sorry, can't comply */
		reboot = 1;		/* Yes, set it up */
		gunned = 1;		/* Our last glass of elderberry wine */
		reply(UE_ACK,NULL);	/* Ok, we'll do it when we can */
	    case UC_ZON:		/* Zone reload */
		if(!usr_whopr(q,whoprs))/* Is this person authorized? */
		    reply(UE_ADM,NULL);	/* No, sorry, can't comply */
#if 0					/* Needs more thought */
		if(zreload(q,zones,cache))
		    reply(UE_ACK,NULL) /* ; */
		else
		    reply(UE_SYS,NULL) /* ; */
#endif
	    case UC_CHK:		/* Checkpoint request */
	    case UC_INF:		/* Information dump */
		reply(UE_NIY,NULL);	/* Too bad, we can't do that yet */
	    default:			/* Something we don't understand */
		reply(UE_ARG,NULL);	/* Say so */
	}

    /* Real query.  Better be known class and type. */
    if(!cknown(q->class) || !tknown(q->type))
	reply(UE_ARG,NULL);

    /*
     * Ok, it's for real.  Try looking in local database first, with
     * null origin.  If that fails, and if permitted, look in local
     * database with all possible local completions.  If this fails,
     * we have done all we can for local-data-only queries, so punt
     * them.  Otherwise, try to resolve using delegation from
     * zero-origin lookup, or using default servers if no delegation.
     * At this point the query goes into the queue, and this routine
     * is done with it.  Further action will be taken by do_retry().
     */

    if(DBGFLG(DBG_LOG|DBG_RESOLV)) {
	char rrtext[STRSIZ], *p;
	rrhtoa(rrtext,q->qname,q->class,q->type);
	if(!(q->flags&UF_EMO) && (p = strrchr(rrtext,'.')) != NULL)
	    *p = ' ';
	buginf("do_request","received: %s",rrtext);
    }

    q->qttd = q->qnow + qry_tmo;	/* Query has this long to live */

    /*
     * Try the name, using the LSEARCH path. The first entry in the path
     * should always be the null entry.
     */
    if((q->flags & UF_EMO) != 0)
	search = nullsearch;
    else
	search = lsearch;
    do {
	q->ncname = 0;			/* No CNAMEs seen yet */
	rc = lookup(q->qname,*search,q->class,q->type,zones,cache,ncache,
		     1,q->qnow,&(q->ncname),max_cname,&answer,
#if 0
		     &delegation,
#else					/* We don't support delegation */
		     NULL,		/* from LSEARCH path yet */
#endif
		     &(q->cqname));

	/*
	 * First case - matched the name and found the answer he wanted.
	 * Give success with the answer.
	 */
	if((rc == UE_OK) && (answer != NULL)) {
	    if(DBGFLG(DBG_RESOLV)) {
		char nambuf[STRSIZ];
		buginf("do_request","Answer case, search = \"%s\"",
			namtoa(nambuf,*search));
	    }
	    kil_answer(delegation);
	    reply(UE_OK,answer);
	}

	/*
	 * Second case - got an authoratative name error from the local zone.
	 * This is a hard failure if we're using the unmodified name, but is
	 * only a soft failure if we have a suffix of some sort.
	 */
	if(rc == UE_NAM) {
	    if(**search != '\0')
		continue;
	    if(DBGFLG(DBG_RESOLV)) {
		char nambuf[STRSIZ];
		buginf("do_request",
			"Name error case, search=\"%s\"",
			namtoa(nambuf,*search));
	    }
	    kil_answer(delegation);
	    reply(rc,NULL);
	}

	/*
	 * Third case - "No RR" authoritative error from the local zone.
	 * This is a hard failure, since it means we matched the name but it
	 * didn't have the RR's that he was interested in.
	 */
	if(rc == UE_NRR) {
	    if(DBGFLG(DBG_RESOLV)) {
		char nambuf[STRSIZ];
		buginf("do_request",
			"No data error case, search=\"%s\"", 
			namtoa(nambuf,*search));
	    }
	    kil_answer(delegation);
	    reply(rc,NULL);
	}

	/*
	 * Fourth case - got a CNAME in a local zone but its target wasn't
	 * local.  Go on and do an ordinary resolve but turn off search
	 * paths since we already have a fully specified target name.
	 * It's ok to just use the shortname + origin because we're going
	 * to search the local database again later anyway.
	 */
	if(rc == UE_OK && q->cqname != NULL) {
	    if(DBGFLG(DBG_RESOLV)) {
		char nambuf[STRSIZ];
		buginf("do_request","External CNAME \"%s\"",
			namtoa(nambuf,q->cqname));
	    }
	    q->flags |= UF_EMO;		/* CNAMEs always fully qualified */
	    kil_answer(delegation);
	    break;			/* Exit LSEARCH loop right now */
	}

	/*
	 * Fifth case - got an authoritative delegation. This means we tried a
	 * name in the local zone but it is delegated to a subzone. We'll start
	 * a real server query according to that delegation. Note that this
	 * means that all LSEARCH entries which expect to be in the local zone
	 * had better be placed before any that will delegate to a subzone.
	 *~~~ This code really isn't done. Before following a delegation, we
	 *~~~ need to check that we really found out some news, i.e. we didn't
	 *~~~ just delegate to ourself because a search name matched us (i.e.
	 *~~~ if we have CMU.EDU loaded with delegation of authority for
	 *~~~ CC.CMU.EDU, foo.CMU.EDU should not follow the delegation, since
	 *~~~ we know about it locally, but foo.CC.CMU.EDU should)
	 */
	if(delegation != NULL) {
	    if(DBGFLG(DBG_RESOLV)) {
		char nbuf1[STRSIZ],nbuf2[STRSIZ];
		buginf("do_request",
			"Delegation case, search=\"%s\", del=%o, name=\"%s\"",
			namtoa(nbuf1,*search), delegation, 
			namtoa(nbuf2,delegation->name));
	    }
#if 0					/* Don't support this yet */
	    q->flags |= UF_EMO;		/* Must be fully-qualified now */
	    q->qorigin = nullsearch;	/* So no search origin for this guy */
	    answer = init_query(q,delegation); /* Check cache/start query */
	    if(answer != NULL)		/* Found in cache - can still win */
		reply(UE_OK,answer);	/* So give it to him */
	    return(1);			/* Else, just return - query started */
#endif
	}

	/* Nth case - no match in local zone. Try the next suffix */

    } while(*++search != NULL);

    /*
     * We couldn't resolve it using our suffix list in the local database.
     * Must be either a partial name that's outside of our authority or a
     * full name. In either case, we'll initiate a query using the remote
     * search list after first checking the cache.
     */
    if(DBGFLG(DBG_RESOLV))
	buginf("do_request","Non-local name case.");
    q->qorigin = (q->flags & UF_EMO) ? nullsearch : rsearch;
    if((answer = init_query(q,NULL)) != NULL)
	reply(UE_OK,answer);

    return(1);				/* Tell caller that we were active */
}
#undef reply

/*
 * init_query - Initialize query parameters and enqueue the query for
 * transmission to a name server.
 */

struct domain *init_query(q,delegation)
    struct query_block *q;
    struct domain *delegation;
{
    struct domain *answer = NULL, **delptr;
    int i, len1, len2;

    q->rcode = UE_OK;			/* Clear possible old response code */

    if(q->qorigin == NULL) {		/* Impossible error */
	bugchk("init_query","%o->qorigin == NULL, using \".\"",q);
	q->qorigin = nullsearch;
    }

    if(q->qorigin != nullsearch && q->cqname != NULL) {
	char nambuf[STRSIZ], orgbuf[STRSIZ];
	bugchk("init_query","cqname=\"%s\", qorigin=\"%s\", using nullsearch",
	    namtoa(nambuf,q->cqname),namtoa(orgbuf,*q->qorigin));
	q->qorigin = nullsearch;
    }

    if(q->cqname == NULL)		/* Construct working name if missing */
	q->cqname = bcons(q->qname,namlen(q->qname));

    if(DBGFLG(DBG_RESOLV)) {
	char nambuf[STRSIZ], orgbuf[STRSIZ];
	buginf("init_query","q=%o, qname=\"%s\", qorigin=%o=\"%s\"",
	    q,namtoa(nambuf,q->cqname),q->qorigin,namtoa(orgbuf,*q->qorigin));
    }

    /*
     * First, see lookup this query (again) to find out if either it
     * is in the cache or if delegation information exists.
     */	
    delptr = (delegation == NULL) ? &delegation : NULL;

    for(;;) {
	int ncname = q->ncname;
	i = lookup(q->cqname,*q->qorigin,q->class,q->type,zones,cache,ncache,
		    q->flags&UF_MBA,q->qnow,&(q->ncname),max_cname,&answer,
		    delptr,NULL);
	if(answer != NULL) {		/* Cache match - give win. */
	    if(DBGFLG(DBG_RESOLV))
		buginf("init_query","answer case");
	    kil_answer(delegation);
	    return(answer);
	} else if(i == UE_OK && !(q->flags & UF_LDO)) {
	    /* Delegation or no info, just get out of the loop */
	    if(DBGFLG(DBG_RESOLV))
		buginf("init_query","delegation or no info");
	    break;
	} else {			/* Cache error, lose or restart */
	    /*
	     * This is a real dog, the whole process of adding and
	     * removing things from the queue really ought to be
	     * rewritten from the ground up.
	     */
	    if(i == UE_OK)		/* Got here because LDO? */
		i = UE_DNA;		/* Yeah, make it Data Not Available */
	    kil_answer(delegation);
	    if((q->rcode = i) == UE_NAM && (*++(q->qorigin) != NULL)) {
		if(DBGFLG(DBG_RESOLV))
		    buginf("init_query","name error, restarting");
		q->ncname = ncname;
		continue;
	    }
	    /*
	     * Here is where we should handle the case where both UF_LDO and
	     * UF_RBK are set.  It would require some more thought on the
	     * right way to restart the loop while passing back UE_DNA to
	     * the caller.  Ignore the issue for now, it's not vital.
	     */
	    if(DBGFLG(DBG_RESOLV))
		buginf("init_query","non-name error %d",i);
	    dequeue(q);			/* sigh */
	    q->seq = nxtseq();
	    q->state = done;		/* let caller handle the error */
	    enqueue(q);
	    return(NULL);
	}
    }

    /* Didn't find an answer.  Find name server and start this query going. */
    q->seq = nxtseq();			/* Assign a sequence number */
    if(delegation != NULL) {		/* If we got a delegation */
	kil(q->cqname);			/* Flush old working name and */
	q->cqname = delegation->name;	/* move the cannonicalized name */
	delegation->name = NULL;	/* into the query block. */
	if(DBGFLG(DBG_RESOLV)) {
	    char nambuf[STRSIZ];
	    buginf("init_query","delegation, cqname=\"%s\"",
		    namtoa(nambuf,q->cqname));
	}
    } else if(q->qorigin != nullsearch) { /* No delegation, yes search path */
	if(DBGFLG(DBG_RESOLV)) {
	    char nambuf[STRSIZ], orgbuf[STRSIZ];
	    buginf("init_query","no delegation, qname=\"%s\", qorigin=\"%s\"",
		namtoa(nambuf,q->qname),namtoa(orgbuf,*q->qorigin));
	}
	kil(q->cqname);			/* Construct target name from */
	len1 = namlen(q->qname) - 1;	/* query name plus search path */
	len2 = namlen(*q->qorigin);
	q->cqname = mak(len1+len2);
	bcopy(q->qname,q->cqname,len1);
	bcopy(*q->qorigin,q->cqname+len1,len2);
    }
    if(ns_bind(q,(delegation != NULL ? delegation->data.rrs : NULL)))
	sndqry(q);			/* Send off first query if we can */
    kil_answer(delegation);		/* Clean up */
    q->state = hang;			/* Query waiting for external event */
    enqueue(q);				/* Stick this guy in the queue */
    return(NULL);			/* And tell him we're working on it */
}


/* Limit number of scans through queue so that we are sure to terminate. */
#define	MAX_PASS    10

#define	reply(r_code,r_lst) {	q->rcode = r_code;		    	\
				if(!(q->flags&UF_RBK))		    	\
				    usr_send(q,r_lst); 		    	\
				q->state = done;		    	\
				if(r_lst != NULL) kil_answer(r_lst);	\
				continue;			    	\
			    }

do_retry()
{
    struct query_block *q;
    int busy = 0, oldseq, curseq, pass = 0;
    struct domain *answer, *delegation;
    int i, now = zulu();

    /*
     * We need to run through the queue several times, to be sure that
     * we get any new queries that might be added by a ns_bind() call or
     * some such.  On the first pass we do the entire queue, after that
     * we only look at queries that have been added since the previous
     * pass.  Ie, we attempt to examine each query exactly once.  This
     * is a little hairy but is better than two zillion recursive calls
     * of ns_bind().  I think.  NB: this code assumes that enqueue() adds
     * new queries to the head of the queue.
     */
    do {
	oldseq = curseq;    curseq = nxtseq();
	for(q = queue; q != NULL && (pass == 0 || seq_lt(oldseq,q->seq)); q = q->next)
	    switch(q->state) {

		/* new and retry_cname handled the same for now */
		case new:
		case retry_cname:
		    if(q->qname == NULL)
			bughlt("do_retry","NULL QName, q=%o",q);
		    else if(q->cqname == NULL)
			q->cqname = bcons(q->qname,namlen(q->qname));
		    if(DBGFLG(DBG_RESOLV)) {
			char rrtext[STRSIZ];
			buginf("do_retry","state=%s, q=%o, Seq=%X, RRHdr=%s",
				(q->state == new ? "new" : "retry_cname"),
				q, q->seq,
				rrhtoa(rrtext,q->cqname,q->class,q->type));
		    }
		    answer = delegation = NULL;
		    ++busy;
		    if((i = lookup(q->cqname,NULL,q->class,q->type,
				    zones,cache,ncache,q->flags&UF_MBA,
				    q->qnow,&(q->ncname),max_cname,&answer,
				    &delegation,NULL)) != UE_OK)
			reply(i,NULL);	/* Authoritative or CNAME error */
		    if(DBGFLG(DBG_RESOLV)) {
			char rrtext[STRSIZ];
			buginf("do_retry",
				"q=%o, Seq=%X, RRHdr=%s, answer=%o, delegation=%o",
				q, q->seq, rrhtoa(rrtext,q->cqname,q->class,q->type),
				answer,delegation);
		    }
		    if(answer != NULL) {
			kil_answer(delegation);
			reply(UE_OK,answer);
		    }
		    if(delegation != NULL && delegation->name != NULL) {
			if(q->cqname != NULL)
			    kil(q->cqname);
			q->cqname = delegation->name;
			delegation->name = NULL;
		    }
		    if(ns_bind(q,(delegation != NULL ? delegation->data.rrs : NULL)))
			sndqry(q);
		    kil_answer(delegation);
		    q->state = hang;
		    continue;

		case retry_ns:
		    if(DBGFLG(DBG_RESOLV)) {
			char rrtext[STRSIZ];
			buginf("do_retry","state=retry_ns, q=%o, Seq=%X, RRHdr=%s",
				q,q->seq,rrhtoa(rrtext,q->cqname,q->class,q->type));
		    }
		    for(i = 0; i < q->ns_count; ++i) {
			char *name = q->ns_list[i].name;
			int ncname = 0;
			if(DBGFLG(DBG_RESOLV))
			    buginf("do_retry","NS lookup1: answer=%o",answer);
			if(name != NULL
			  && lookup(name,NULL,QC_IN,QT_A,zones,cache,ncache,
				    q->flags&UF_MBA,q->qnow,&ncname,max_cname,
				    &answer,NULL,NULL
				) == UE_OK
			  && answer != NULL) {
			    if(DBGFLG(DBG_RESOLV))
				buginf("do_retry","NS lookup2: answer=%o",
				       answer);
			    q->ns_list[i].addr = best_address(answer->data.rrs);
			    kil_answer(answer);
			    kil(name);
			    q->ns_list[i].name = NULL;
			}
		    }
		    ++busy;
		    q->state = hang;
		    /* fall through... */

		case hang:
		    if(now > q->qttd) {
			++busy;
			reply(UE_TMO,NULL);
		    }
		    else if(now > q->ns_ttd) {
			++busy;
			sndqry(q);
		    }
		    continue;

		case done:		/* stray dead query, kill it */
		    if(!(q->flags&UF_RBK))
			usr_send(q,NULL);
		    kil_query(q);
		    continue;

		default:
		    bugchk("do_retry","unknown state %d for query %o",
			    q->state, q);
		    continue;
	    }
    } while(++pass < MAX_PASS);

    if(queue != NULL) {
	struct query_block **qq = &queue;
	while((q = *qq) != NULL)
	    switch(q->state) {
		case new:
		case hang:
		case retry_ns:
		case retry_cname:
		    qq = &(q->next);
		    continue;
		case done:
		    *qq = q->next;
		    kil_query(q);
		    continue;
		default:
		    bughlt("do_retry","unknown query state %d (q=%o, qq=%o)",q->state,q,qq);
	    }
    }

    usr_rxmt();				/* Try again on stalled replies */

    return(busy);
}
#undef reply


#define	punt(msg)   { if(DBGFLG(DBG_RESOLV))	    \
			buginf("do_answer",msg);    \
		      continue;			    \
		    }

/* process one incoming answer */
do_answer()
{
    char8 packet[BIG_UDP_PACKET], *qname;
    struct domain *rrlist;
    struct query_block *q;
    int busy = 0, qtype, qclass, seq, now, ercode, i;
    struct dom_header *h;
    struct domain *d, *answer = NULL;

    for(h = NULL; udp_recv((char *) packet,BIG_UDP_PACKET,0); h = NULL) {

	h = DOM_HEADER(UDP_DATA(packet));
	if(UDP_HEADER(packet)->ck != 0 && udp_chksum((char *) packet) != 0)
	    punt("bad UDP checksum");
	if(!h->resp || h->op != OP_QUERY || h->tc || h->qdcnt != 1)
	    punt("bad message header");

	++busy;
	seq = h->id;
	qpeek((DOM_DATA(UDP_DATA(packet))),
				((char **)&qname),&qclass,&qtype);
	for(q = queue; q != NULL; q = q->next)
	    if(seq == q->seq && qclass == q->class
			     && qtype == q->type
			     && !namcmp((void *) qname,q->cqname))
		break;
	if(DBGFLG(DBG_LOG|DBG_RESOLV)) {
	    char fhost[16],rrtext[STRSIZ];
	    buginf("do_answer",
		"q=%o, Seq=%X, FHost=%s, RRHdr=%s",
		q, q->seq, inatoa(fhost,IP_HEADER(packet)->sh),
		rrhtoa(rrtext,(void *) qname,qclass,qtype));
	}
	if(q == NULL)
	    punt("packet doesn't match any current query");

	/*
	 * As soon as we know which query caused this answer,
	 * remove this nameserver so we don't ask it again,
	 * regardless of whether we can even parse this packet.
	 */
	for(i = 0; i < q->ns_count; ++i)
	    if(q->ns_list[i].addr == IP_HEADER(packet)->sh) {
		if(DBGFLG(DBG_LOG|DBG_RESOLV)) {
		    char fhost[STRSIZ];
		    buginf("do_answer","removing NS #%d (%s)",
			    i, inatoa(fhost,IP_HEADER(packet)->sh));
		}
		if(q->ns_list[i].name != NULL) {
		    kil(q->ns_list[i].name);
		    q->ns_list[i].name = NULL;
		}
		q->ns_list[i--] = q->ns_list[--(q->ns_count)];
		if(q->ns_idx >= q->ns_count)
		    q->ns_idx = 0;
	    }

	/*
	 * Try to expand packet into separate RRs.
	 */
	if((rrlist = rpkt((void *) UDP_DATA(packet),
			  UDP_HEADER(packet)->ln)) == NULL)
	    punt("couldn't parse data sections of packet");

	/*
	 * Expanded ok, commit to handling this packet.
	 */
	break;
    }

    if(h == NULL)			/* Exit if no packet */
	return(busy);

    if(DBGFLG(DBG_RESOLV)) {
	struct domain *d;
	for(d = rrlist; d != NULL; d = d->link.dpoint)
	    if(d->data.rrs != NULL && d->data.rrs->chain != NULL)
		bughlt("do_answer","%o->data.rrs->chain != NULL",d);
    }

    /*
     * RRs expanded ok, so we'll use them to answer query.  We have to
     * be careful about what we put in the cache, in particular we
     * have to defend against unsollicted garbage information about
     * the root, and against idioticly long TTLs; sadly, these two
     * often happen together.
     */
    for(i = h->qdcnt; i > 0 && rrlist != NULL; --i) {
	rrlist = (d = rrlist)->link.dpoint;
	d->link.dpoint = NULL;		/* Unlink first! */
	kil_domain(d,0);		/* Flush Question section */
    }
    now = zulu();			/* Make TTLs absolute */
    for(d = rrlist; d != NULL; d = d->link.dpoint) {
	char rrtext[STRSIZ];		/* Wasted space if not debugging */
	if(DBGFLG(DBG_LOG|DBG_INSERT|DBG_RESOLV))
	    rrtoa(rrtext,d->name,d->data.rrs);
	if(d->data.rrs->ttl > maxttl) {
	    if(ttl_punt) {
		if(DBGFLG(DBG_LOG|DBG_INSERT|DBG_RESOLV))
		    buginf("do_answer","TTL too big, tossing: %s",rrtext);
		continue;
	    } else {
		if(DBGFLG(DBG_LOG|DBG_INSERT|DBG_RESOLV))
		    buginf("do_answer","TTL too big, reducing to %d: %s",
			    maxttl,rrtext);
		d->data.rrs->ttl = maxttl;
	    }
	}
	if(d->name[0] == 0 && q->cqname[0] != 0) {
	    if(DBGFLG(DBG_LOG|DBG_INSERT|DBG_RESOLV))
		buginf("do_answer","punting unsolicted ROOT RR: %s",
			rrtext);
	    continue;
	} else {
	    struct rr *r = rrcons(d->data.rrs);
	    if(DBGFLG(DBG_LOG|DBG_INSERT|DBG_RESOLV))
		buginf("do_answer","caching: %s",rrtext);
	    r->ttl += now;
	    insert(&cache,d->name,r,0,1);
	}
    }

    /* Now see what we got and if it helps the user any. */
    switch(h->rcode) {
	case ER_FMT:			/* Server thinks we talk funny */
	case ER_SRV:			/* Server barfed */
	case ER_NIY:			/* Server doesn't implement it */
	case ER_REF:			/* Server doesn't feel like it */
	default:			/* Server sends unknown error codes */
	    ercode = UE_NOP;		/* Are all things we just ignore */
	    break;			/* (should remove this ns, though) */
	case ER_NAM:			/* Name error */
	    ercode = (h->aa) ? UE_NAM : UE_NOP;
	    break;			/* Better be from authority */
	case ER_OK:			/* Name ok */
	    ercode = (h->aa && h->ancnt == 0) ?
			UE_NRR :	/* Authoritative and no RRs, lose */
		     (!h->aa && h->nscnt == 0 && q->flags&UF_MBA) ?
			UE_NOP :	/* Not authoritative enough for us */
			UE_OK;		/* Otherwise is ok. */
	    break;
    }

    if(DBGFLG(DBG_LOG|DBG_RESOLV))
	buginf("do_answer","h->rcode=%d=\"%s\", h->aa=%d, ercode=%d, cnts=(%d,%d,%d,%d)",
		h->rcode,looktb(er_table,h->rcode),h->aa,ercode,h->qdcnt,
		h->ancnt,h->nscnt,h->arcnt);

    if(ercode != UE_OK) {
	if(DBGFLG(DBG_RESOLV))
	    buginf("do_answer","tossing this packet");
    } else if((h->ancnt && h->aa)		/* check for answers */
	    || (!(q->flags&UF_MBA) && h->ancnt+h->nscnt+h->arcnt != 0)) {
	/*
	 * We have some answers and the user is willing to believe
	 * them.  In theory they will be CNAMEs and/or real
	 * answers.  If the kind of data we want doesn't include
	 * CNAMEs, we have to process them first to be sure we are
	 * looking under the right name.  In either case, we then
	 * look through the answer section for RRs that match what
	 * we wanted.
	 */
	struct rr *rlist = NULL;
	int ncname = 0;
	int n = (q->flags&UF_MBA) ? h->ancnt : h->ancnt+h->nscnt+h->arcnt;
	if(DBGFLG(DBG_RESOLV))
	    buginf("do_answer","answer case");
	if(!tmatch(q->type,QT_CNAME))
	    for(i = n, d = rrlist; i > 0 && d != NULL; --i, d = d->link.dpoint)
		if(d->data.rrs->type == QT_CNAME
			&& cmatch(d->data.rrs->class,q->class)
			&& !namcmp(d->name,q->cqname)) {
		    char *p = d->data.rrs->rdata[CNAME_CNAME].byte;
		    if(q->cqname != NULL)
			kil(q->cqname);
		    q->cqname = bcons(p,namlen(p));
		    ++ncname;
		}
	for(i = n, d = rrlist; i > 0 && d != NULL; --i, d = d->link.dpoint)
	    if(tmatch(q->type,d->data.rrs->type)
		    && cmatch(q->class,d->data.rrs->class)
		    && !namcmp(q->cqname,d->name)) {
		    struct rr *r = mak_rr();
		    *r = *(d->data.rrs);
		    r->chain = rlist;
		    rlist = r;
	    }
	if(rlist != NULL) {
	    answer = mak_domain(1);
	    answer->name = q->cqname;
	    q->cqname = NULL;
	    answer->data.rrs = rlist;
	    q->rcode = ercode;
	    q->state = done;
	} else if((q->ncname += ncname) > max_cname)
	    ercode = UE_TMC;
	else if(ncname != 0)
	    q->state = retry_cname;
    }					/* end of answer case */

#if 0
#error Not finished
    if(ercode == UE_OK && q->state == hang && h->nscnt != 0) {
	/*
	 * Check here for relevance of the delegation, set ercode =
	 * UE_NOP if apparently irrelevant.  Unfortunately, this is a
	 * pain to implement because lookup() hides too much
	 * information from us.  Needs rewrite.  Sigh.
	 */
    }
#endif

    if(ercode == UE_OK && q->state == hang && h->nscnt != 0) {
	/*
	 * Got a new delegation.  Check that these RRs at least look
	 * valid, cons up a chain of them, flush the old ns_list,
	 * attempt to bind the new nameservers to addresses, send off
	 * a query if that succeeds.  For address binding, we first try
	 * to use ns_bind() (authoritative data and RRs we thought were
	 * fit to cache), then we check to see if some unbound addresses
	 * can be filled in from the additional section (least trusted
	 * data).
	 */
	struct rr *rlist = NULL, **rrtemp, *r;
	int bound;
	if(DBGFLG(DBG_RESOLV))
	    buginf("do_answer","delegation case");
	d = rrlist;
	for(i = h->ancnt; i > 0 && d != NULL; --i, d = d->link.dpoint)
	    ;				/* Skip Answer section */
	for(i = h->nscnt; i > 0 && d != NULL; --i, d = d->link.dpoint)
	    if(d->data.rrs->type == QT_NS) {
		*(r = mak_rr()) = *(d->data.rrs);
                r->chain = NULL;

		/*
		 * Keep name servers in the proper order of preference.
		 */
		if (rlist == NULL)
		    rlist = r;
		else
		    *rrtemp = r;
                rrtemp = &r->chain;
	    }
	for(i = 0; i < q->ns_count; ++i)
	    if(q->ns_list[i].name != NULL)
		kil(q->ns_list[i].name);
	kil_(q->ns_list);
	q->ns_list = NULL;
	q->ns_ttd = q->ns_count = q->ns_idx = 0;
	bound = ns_bind(q,rlist);
	/* d still set from above, now points at additional section */
	for( ; d != NULL; d = d->link.dpoint)
	    if(d->data.rrs->class == QC_IN && d->data.rrs->type == QT_A)
		for(i = 0; i < q->ns_count; ++i)
		    if(q->ns_list[i].name != NULL && namcmp(d->name,q->ns_list[i].name) == 0) {
			q->ns_list[i].addr = d->data.rrs->rdata[IN_A_ADDRESS].word;
			kil(q->ns_list[i].name);
			q->ns_list[i].name = NULL;
			++bound;
		    }
	if(bound > 0)
	    sndqry(q);
	while(rlist != NULL) {
	    rlist = (r = rlist)->chain;
	    kil_(r);
	}
    }					/* end of delegation case */

    if(neg_ok && (ercode == UE_NAM || ercode == UE_NRR) && h->nscnt != 0
	      && q->cqname[0] != 0 && h->aa) {
	/*
	 * Got stuff to put in negative cache, maybe.
	 */
	struct domain *d = rrlist;
	for(i = h->ancnt; i > 0 && d != NULL; --i, d = d->link.dpoint)
	    ;				/* Skip Answer section */
	for(i = h->nscnt; i > 0 && d != NULL; --i, d = d->link.dpoint)
	    if(d->data.rrs->type == QT_SOA) {
		struct rr *r;
		int ttl = d->data.rrs->rdata[SOA_MINIMUM].word;
		if(ttl > maxttl) {
		    if(ttl_punt)
			continue;
		    else
			ttl = maxttl;
		}
		r = mak_rr();
		r->class = q->class;
		r->type = q->type;
		r->ttl = ttl + now;
		r->rdata = mak_rdatom(NCACHE_RDATA_LENGTH);
		r->rdata[NCACHE_ERRCODE].word = ercode;
		if(DBGFLG(DBG_RESOLV)) {
		    char rrtext[STRSIZ];
		    buginf("do_answer","adding to neg cache: %s %d, %d",
			    rrhtoa(rrtext,q->cqname,r->class,r->type),ttl,
			    ercode);
		}
		insert(&ncache,q->cqname,r,0,0);
	    }
    }					/* end of neg cache case */

    /*
     * If we got any errors that we know how to deal with,
     * terminate this query.
     */
    if(ercode > UE_MAX)
	ercode = UE_SYS;		/* bad error is itself an error */
    switch(ercode) {
	case UE_OK:			/* state ok? */
	case UE_NOP:			/* or ignored error? */
	    break;			/* yeah, do nothing */
	default:			/* any other error code */
	    q->rcode = ercode;		/* remember the error */
	    q->state = done;		/* and terminate the query */
    }

    /*
     * If this packet terminated a query, send reply to user,
     * and unblock any queries depending on this one.
     */
    if(q->state == done) {
	i = q->quid;
	dequeue(q);
	if(q->qorigin == NULL || *(q->qorigin) == NULL)
	    q->qorigin = nullsearch;
	if(ercode == UE_NAM && (*++(q->qorigin) != NULL)) {
	    /*
	     * Start the query with next origin, first checking cache
	     * for answer.
	     */
	    if(DBGFLG(DBG_RESOLV))
		buginf("do_answer","attempting to restart on next origin");
	    if(answer != NULL)
		kil_answer(answer);
	    if(q->cqname != NULL) {
		kil(q->cqname);
		q->cqname = NULL;
	    }
	    if((answer = init_query(q,NULL)) != NULL) {
		ercode = UE_OK;		/* Found it in cache, flag win */
		q->state = done;	/* and flag done with query */
	    }
	}
	if(q->state == done) {		/* Really finished? */
	    if(DBGFLG(DBG_RESOLV))	/* Yeah, clean up */
		buginf("do_answer","q=%o, state=done, ercode=%d",q,ercode);
	    if(!(q->flags&UF_RBK))
		usr_send(q,answer);
	    kil_query(q);
	}
	if(i == 0)			/* Check for dependents */
	    for(q = queue; q != NULL; q = q->next)
		if(q->state == hang)
		    for(i = q->ns_count; --i >= 0; )
			if(q->ns_list[i].depends == seq)
			    /*
			     * It may be a bug that we don't fill in
			     * the addresses directly from the
			     * incoming packet, since the RRs may not
			     * have made it into the cache.  Fix this
			     * if it is a severe problem.  For now
			     * just unblock the query.
			     */
			    q->state = retry_ns;
    }
    if(answer != NULL)
	kil_answer(answer);

    kil_domain(rrlist,0);

    return(busy);
}

/* send off the next possible network query for this query block */

static sndqry(q)
    struct query_block *q;
{
    int addr;
    char8 packet[LITTLE_UDP_PACKET];

    q->ns_ttd = zulu() + rxmt_period;	/* time for next query */
    if((addr = ns_next(q)) == 0)
	return;
    udp_binit((char *) packet);
    IP_HEADER(packet)->dh = addr;
    UDP_HEADER(packet)->dp = udp_fport;
#if CODE_BEFORE_RWF_CHANGES
    UDP_HEADER(packet)->ln += makqry(UDP_DATA(packet),q->seq,0,
				     q->cqname,q->class,q->type);
#else
    UDP_HEADER(packet)->ln += makqry(UDP_DATA(packet),q->seq,1,
				     q->cqname,q->class,q->type);
#endif
    if(DBGFLG(DBG_LOG|DBG_RESOLV)) {
	char fhost[16],rrtext[STRSIZ];
	buginf("sndqry",
	    "q=%o, Seq=%X, FHost=%s, RRHdr=%s",
	    q, q->seq, inatoa(fhost,addr),
	rrhtoa(rrtext,q->cqname,q->class,q->type));
    }

    if(!udp_send((char *) packet))
	bugchk("sndqry","trouble sending UDP packet");
    return;				/* should be better diagnostics */
}					/* do it later.... */

/* kill a query_block. */

static kil_query(q)
    struct query_block *q;
{
    if(q == NULL)
	return;
    else if(DBGFLG(DBG_RESOLV)) {
	char rrtext[STRSIZ];
	buginf("kil_query","q=%o, RRHdr=%s",
		q, rrhtoa(rrtext,q->cqname,q->class,q->type));
    }
    dequeue(q);				/* paranoia */
    if(q->qname != NULL)
	kil(q->qname);
    if(q->cqname != NULL)
	kil(q->cqname);
    if(q->ns_list != NULL) {
	int i = q->ns_count;
	while(--i >= 0)
	    if(q->ns_list[i].name != NULL)
		kil(q->ns_list[i].name);
	kil_(q->ns_list);
    }
    kil_(q);
    return;
}
  