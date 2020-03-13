/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Twenex user interface code.  Mostly jackets for IPCF routines.
 * Some of this code is doesn't really belong here, should be
 * in a non 20x specific module.  Oh well, fix later....
 */

#include "domsym.h"
#include "usrdef.h"
#include <macsym.h>
#include <monsym.h>

/* ipc20x.c */
extern int ipc_init(char *,int);
extern int ipc_fini(int);
extern int ipc_send(int,int ,int *);
extern int ipc_recv(int,int *,int );
extern char *ipc_user(int,char *);

/* usr20x.c */
static pginit(int *,struct query_block *,int ,int ,int );
static hscopy(char *,int,int **);

/* tim20x.c */
extern int zulu(void);

static char pidnam[] = "[SYSTEM]RESOLVER";
static char piddbg[] = "RESOLVER-DEBUG";

/* Our PID. */
static int mypid = 0;

/* Default _SPRSV to magic excluded value, in case not in MONSYM. */
#define _SPNOP (-1)
#if monsymdefined(".SPRSV")
#define _SPRSV monsym(".SPRSV")
#else
#define _SPRSV _SPNOP
#endif

/* Not that I expect this to change.... */
#ifndef PAGE_SIZE
#define PAGE_SIZE 01000
#endif

/* Size of data portion of page. */
#define PDATA_SIZE  (PAGE_SIZE - U_PHSIZE)

/* Reserved page for recvs/errs */
static int _recv_page[PAGE_SIZE*2];
static int *recv_page = NULL;

/* Macro to do page rounding and indexing. */
#define	PAGE(pointer,index) ((int *) \
    ((((int)(int *)pointer)+index*PAGE_SIZE-1)&~(PAGE_SIZE-1)))

/*
 * Retransmit queue.  Since there is a single execution thread, pages
 * only need to be marked in this queue if the initial transmission
 * failed (presumably a halted fork or overflowed message quota or
 * some such).
 */

static struct rxmt_q {
    int	pid;				/* Recipient or zero */
    int	ttd;				/* Time To Die */
    int	npages;				/* How many pages we have */
    int	index;				/* Next page to send */
    int	*pages;				/* Page buffer */
    struct rxmt_q *next;		/* Next in chain */
} *rxmt_q = NULL;

/* How long a client has to pick up an answer (seconds). */
#define	ANSWER_TTL  (300)

/* Round the result of a sizeof() into words. */
#define wsizeof(mumble)	(((mumble)+sizeof(int)-1)/sizeof(int))

/* Quick test to see if a pointer just fell off a cliff... */
#define	fell_p(pointer)	((((int)(pointer)) & (PAGE_SIZE-1)) == 0)

/* usr_init() -- initialize user interface. */

usr_init()
{
    recv_page = PAGE(_recv_page,1);
    if(!DBGFLG(DBG_PID))
	mypid = ipc_init(pidnam,_SPRSV);
    else {
	buginf("usr_init","PID=\"%s\"",piddbg);
	mypid = ipc_init(piddbg,_SPNOP);
    }
    if(mypid == 0)
	bughlt("usr_init","couldn't initialize IPCF");
    return(1);
}

/* usr_fini() -- close down user interface. */

void usr_fini()
{
    ipc_fini(mypid);	    mypid = 0;
}

/* usr_recv() -- get an incoming request.
 *
 * Returns *query_block or NULL if didn't get anything.
 */

#define punt(msg) { bugchk("usr_recv",msg); return(NULL); }

/* Abbreviations to make code more readable */
#define PHEAD  (U_PAGE_HEADER(recv_page))
#define	DHEAD  (U_DATA_HEADER(recv_page))

struct query_block *usr_recv()
{
    int herpid;
    struct query_block *result;

    while((herpid = ipc_recv(mypid,recv_page,0)) != 0) {
	if(PHEAD->verusr != USRVER || PHEAD->verrfc	!= RFCVER
				   || PHEAD->state	!= US_QRY
				   || PHEAD->pag_count	!= 1
				   || PHEAD->pag_this	!= 1) {
	    PHEAD->verusr = USRVER;	/* Error, might be wrong version */
	    PHEAD->verrfc = RFCVER; 
	    PHEAD->state = US_ERR;	/* Send back to user, wimpering */
	    ipc_send(mypid,herpid,recv_page); /* Give up if IPCF error! */
	    continue;
	}				/* Ok, got a live one */
	result = (struct query_block *)mak(sizeof(struct query_block));
	if(DHEAD->qname != 0) {		/* Don't use nonexistant qname! */
	    char *qname = (char *) (recv_page + DHEAD->qname);
	    result->qname = bcons(qname,namlen(qname));
	}
	result->flags  = DHEAD->flags;
	result->class  = DHEAD->qclass;
	result->type   = DHEAD->qtype;
	result->quid   = herpid;
	result->stamp1 = PHEAD->stmp1;
	result->stamp2 = PHEAD->stmp2;
	result->state = new;
	result->qnow = zulu();
	if(DBGFLG(DBG_USR)) {
	    char tmpnam[STRSIZ];
	    if(result->qname != NULL)
		namtoa(tmpnam,result->qname);
	    else
		strcpy(tmpnam,"<NULL>");
	    buginf("usr_recv","qname=\"%s\", qclass=%d, qtype=%d, qflags=%o, qnow=%o",
		  tmpnam, result->class, result->type, result->flags, result->qnow);
	}
	return(result);
    }
    return(NULL);			/* Didn't get anything useful */
}

#undef punt
#undef PHEAD
#undef DHEAD


/* usr_send() -- send out a response. */

#define punt(msg) { bugchk("usr_send",msg); return(0); }

/* Hairy string address computation thing */
#define hsaddr(pointer) ((pointer)-PAGE(pages,1))

usr_send(query,answer)
    struct query_block *query;
    struct domain *answer;
{
    int nrrs = 0, nwords = 0, nbytes = 0, npages, i, err;
    int *pages, *wp, *bp;
    struct rr *r;
    struct rxmt_q *p;
    union rdatom *a;
    char *fmt;

    /* If CNAMEs were seen, light the nickname flag */
    if(query->ncname > 0)
	query->flags |= UF_AKA;

    /* Sanity check */
    if(answer != NULL && query->rcode != UE_OK) {
	bugchk("usr_send","query->rcode=%d && answer != NULL",query->rcode);
	query->rcode = UE_OK;
    }

    /* Figure out how much space we need */
    if(answer != NULL)
	for(r = answer->data.rrs; r != NULL; r = r->chain) {
	    fmt = rrfmt(r->class,r->type);
	    ++nrrs;
	    if(DBGFLG(DBG_USR))
		buginf("usr_send","nrrs=%d, class=%d, type=%d, fmt=%c%s%c",
		      nrrs, r->class, r->type, (fmt?'"':'<'), (fmt?fmt:"NULL"),
		      (fmt?'"':'>'));
	    for(a = r->rdata; *fmt != '\0';  ++fmt, ++a) {
		++nwords;
		if(DBGFLG(DBG_USR))
		    buginf("usr_send","*fmt='%c', nwords=%d",*fmt,nwords);
		switch(*fmt) {
		    case '4': case '2': case 'c': case 'i':
			continue;
		    case 'd':
			nbytes += wsizeof(namlen(a->byte));
			continue;
		    case 's':
			nbytes += wsizeof(((int)*(a->byte))+1);
			continue;
		    case 'w':
			nbytes += wsizeof(IN_WKS_TOTAL_LENGTH);
			continue;
		    default:
			punt("unknown format specifier");
		}
	    }
	}
    else if(DBGFLG(DBG_USR))
	buginf("usr_send","answer=<NULL>");

    if(DBGFLG(DBG_USR))
	buginf("usr_send","nbytes=%d, nwords=%d",nbytes,nwords);

    nbytes += wsizeof(namlen(query->qname));
    if(answer != NULL)
	nbytes += wsizeof(namlen(answer->name));
    nwords += nrrs * U_RHSIZE;
    npages = (U_DHSIZE + nwords + nbytes + PDATA_SIZE - 1) / PDATA_SIZE;

    if(DBGFLG(DBG_USR)) {
	buginf("usr_send","nrrs=%d, nbytes=%d, nwords=%d, npages=%d",
		nrrs,nbytes,nwords,npages);
	buginf("usr_send","query->flags=0%o, query->rcode=%d",
		query->flags, query->rcode);
    }

#if 0					/* Code not currently used */
    /* Abort now if not enough buffer pages to handle this message. */
    if(npages > pbuf_free) {
	bzero((char *)recv_page,PAGE_SIZE*sizeof(int));
	pginit(recv_page, query, 1, 1, 0);		/* Error message. */
	U_DATA_HEADER(recv_page)->rcode = UE_SYS;	/* Set error code */
	bp = recv_page + U_PHSIZE + U_DHSIZE;		/* Crock in qname */
	U_DATA_HEADER(recv_page)->qname = hsaddr(bp);
	hscopy(query->qname, namlen(query->qname), &bp);
	ipc_send(mypid, query->quid, recv_page);	/* Send, errors ok */
	punt("not enough buffer pages to handle answer, discarding");
    }							/* Bye bye */
#endif

    if(npages == 1)			/* Optimize most common case */
	bzero((char *)PAGE((pages = _recv_page),1),PAGE_SIZE*sizeof(int));
    else				/* General case that never happens */
	pages = (int *)mak((npages+1)*PAGE_SIZE*sizeof(int));
    for(i = 1; i <= npages; ++i)	/* Initialize, however obtained */
	pginit(PAGE(pages,i), query, npages, i, nrrs);

    /* Figure out where strings go, fill in data header. */
    wp = PAGE(pages,1) + U_PHSIZE + U_DHSIZE;
    bp = wp + nwords + ((nwords+U_DHSIZE)/PDATA_SIZE)*U_PHSIZE;

    if(DBGFLG(DBG_USR))
	buginf("usr_send","wp=%o, bp=%o", (int) wp, (int) bp);

    U_DATA_HEADER(PAGE(pages,1))->qname  = hsaddr(bp);
    hscopy(query->qname, namlen(query->qname), &bp);

    if(answer != NULL) {
	U_DATA_HEADER(PAGE(pages,1))->rname  = hsaddr(bp);
	hscopy(answer->name, namlen(answer->name), &bp);
    }

    if(DBGFLG(DBG_USR))
	buginf("usr_send","wp=%o, bp=%o", (int) wp, (int) bp);

    /* Dump everything else onto buffer pages. */
    if(answer != NULL)
	for(r = answer->data.rrs; r != NULL; r = r->chain) {
	    struct u_rr_header *rh = (struct u_rr_header *) wp;
	    fmt = rrfmt(r->class,r->type);
	    rh->length = strlen(fmt) + U_RHSIZE;
	    if(fell_p(++wp)) {
		wp += U_PHSIZE;
		rh = (struct u_rr_header *) (((int *) rh) + U_PHSIZE);
	    }
	    rh->class = r->class;   rh->type = r->type;
	    if(fell_p(++wp)) {
		wp += U_PHSIZE;
		rh = (struct u_rr_header *) (((int *) rh) + U_PHSIZE);
	    }
	    rh->ttl = r->ttl;
	    if(fell_p(++wp))
		wp += U_PHSIZE;
	    for(a = r->rdata; *fmt != '\0';  ++fmt, ++a) {
		switch(*fmt) {
		    case '4': case '2': case 'c': case 'i':
			*wp = a->word;
			break;
		    case 'd':
			*wp = hsaddr(bp);
			hscopy(a->byte, namlen(a->byte), &bp);
			break;
		    case 's':
			*wp = hsaddr(bp);
			hscopy(a->byte, ((int)*(a->byte))+1, &bp);
			break;
		    case 'w':
			*wp = hsaddr(bp);
			hscopy(a->byte, IN_WKS_TOTAL_LENGTH, &bp);
			break;
		    default:
			bugchk("usr_send","unknown rrfmt() code '%c'",*fmt);
		}
		if(fell_p(++wp))
		    wp += U_PHSIZE;
	    }
	}

    /* All done formatting pages.  Try to send them. */
    for(i = 1; i <= npages; ++i)
	if((err = ipc_send(mypid, query->quid, PAGE(pages,i))) != 0)
	    break;

    /* Process error, if any */
    switch(err) {
					/* Recoverable errors: */
	case monsym("IPCFX5"):		/*   Receiver PID disabled */
	case monsym("IPCFX6"):		/*   Send quota exceeded */
    	case monsym("IPCFX7"):		/*   Receiver quota exceeded */
	case monsym("IPCFX8"):		/*   IPCF free space exhausted */
	    if(npages == 1) {		/* De-optimize first (oh well) */
		int *temp = pages;
		pages = (int *)mak((1+1)*PAGE_SIZE*sizeof(int));
		bcopy( ((char *)PAGE(temp,1)),
		       ((char *)PAGE(pages,1)),
		       PAGE_SIZE*sizeof(int));
	    }
	    p = (struct rxmt_q *)mak(sizeof(struct rxmt_q));
	    p->ttd = zulu() + ANSWER_TTL;
	    p->pid = query->quid;	/* Queue up remainder of message */
	    p->npages = npages;		/* for eventual transmission. */
	    p->pages = pages;
	    p->index = i;
	    p->next = rxmt_q;
	    rxmt_q = p;
	    err = 0;			/* Pretend no error happened */
	    break;			/* Done with recoverable errors */

	default:			/* Unexpected IPCF error: */
	    bugchk("usr_send","unexpected IPCF error %06o",err);
					/* Fall through... */
					/* Non-recoverable errors: */
	case monsym("IPCFX4"):		/*   Receiver PID invalid */
	case monsym("IPCF27"):		/*   PID is not defined */
					/* Assume client went away. */
					/* Fall through... */
	case 0:				/* No error. */
	    if(npages != 1)		/* If not optimized */
		kil_(pages);		/* Reclaim space */
	    break;			/* Done with terminal cases */
    }

    return(err == 0);			/* Tell caller whether we won. */
}
#undef	punt

/* usr_rxmt() -- retry pages that users didn't accept the first time. */

void usr_rxmt()
{
    struct rxmt_q **q = &rxmt_q, *p;
    int err, now = zulu();

    while(*q != NULL) {
	int *pages = (*q)->pages, pid = (*q)->pid, npages = (*q)->npages;
	for( ; (*q)->index <= npages; ++((*q)->index))
	    if((err = ipc_send(mypid, pid, PAGE(pages,(*q)->index))) != 0)
		break;

	switch(err) {
	    default:			/* Unexpected IPCF error: */
		bugchk("usr_send","unexpected IPCF error %06o",err);
		(*q)->ttd = 0;		/* Make sure this times out */
					/* Recoverable errors: */
	    case monsym("IPCFX5"):	/*   Receiver PID disabled */
	    case monsym("IPCFX6"):	/*   Send quota exceeded */
    	    case monsym("IPCFX7"):	/*   Receiver quota exceeded */
	    case monsym("IPCFX8"):	/*   IPCF free space exhausted */
		if((*q)->ttd > now) {	/* If this message is still live */
		    q = &((*q)->next);	/* Next item in queue */
		    continue;
		}
					/* Non-recoverable errors: */
	    case monsym("IPCFX4"):	/*   Receiver PID invalid */
	    case monsym("IPCF27"):	/*   PID is not defined */
					/* Assume client went away. */
	    case 0:			/* No error. */
		kil_(pages);		/* Flush message data. */
		*q = (p = *q)->next;	/* Unlink message from queue, */
		kil_(p);		/* and flush it. */
		break;
	}
    }
}

static pginit(page, query, npages, npage, nrrs)
    int *page, npages, npage, nrrs;
    struct query_block *query;
{
    U_PAGE_HEADER(page)->verusr	    = USRVER;
    U_PAGE_HEADER(page)->verrfc	    = RFCVER;
    U_PAGE_HEADER(page)->state	    = US_RSP;
    U_PAGE_HEADER(page)->pag_count  = npages;
    U_PAGE_HEADER(page)->pag_this   = npage;
    U_PAGE_HEADER(page)->stmp1	    = query->stamp1;
    U_PAGE_HEADER(page)->stmp2	    = query->stamp2;

    if(npage == 1) {
	U_DATA_HEADER(page)->flags  = query->flags;
	U_DATA_HEADER(page)->qtype  = query->type;
	U_DATA_HEADER(page)->qclass = query->class;
	U_DATA_HEADER(page)->rcode  = query->rcode;
	U_DATA_HEADER(page)->count  = nrrs;
    }
    return;
}

/* Hairy String COPY. */
static hscopy(source, length, bp)
    char *source;
    int length;
    int **bp;
{
    int avail;

    while(length > (avail = ((PAGE_SIZE-(((int)*bp)&(PAGE_SIZE-1)))
			     *sizeof(int)))) {
	bcopy(source, (char *) *bp, avail);
	length -= avail;
	source += avail;
	*bp += avail/sizeof(int) + U_PHSIZE;
    }
    bcopy(source, (char *) *bp, length);
    *bp += wsizeof(length);
    return;
}

/* Check to see if a user is authorized for privileged functions */
int usr_whopr(q,whoprs)
    struct query_block *q;
    char **whoprs;
{
    char uname[STRSIZ];
    if(whoprs == NULL || ipc_user(q->quid,uname) == NULL)
	return(0);
    if(DBGFLG(DBG_USR)) {
	int i;
	buginf("usr_whopr","uname=\"%s\"",uname);
	for(i = 0; whoprs[i] != NULL; ++i)
	    buginf("usr_whopr","whoprs[%d]=\"%s\"",i,whoprs[i]);
    }
    while(*whoprs != NULL)
	if(strCMP(uname,*whoprs++) == 0)
	    return(1);
    return(0);
}
 