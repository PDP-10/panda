/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Symbols and definitions for domain system server forks.
 */

/* Be sure STDIO is loaded. */
#ifndef FILE
#include <stdio.h>
#endif

/* Library code. */
#include <ctype.h>			/* Break masks and tests */
#include <string.h>			/* Case-sensitive string stuff */
#include <strung.h>			/* Case-insensitive string stuff */

/* Size of J. Random String. */
#define STRSIZ 04000

/*
 * Handy macros for bit testing.
 * The first argument is only evaluated once, the second should
 * be a constant or some such.
 */
#define	ALL_ON(value,mask)  (((value) & (mask)) == (mask))
#define	ONE_ON(value,mask)  (((value) & (mask)) != 0)
#define ALL_OFF(value,mask) (((value) & (mask)) == 0)
#define	ONE_OFF(value,mask) (((value) & (mask)) != (mask))

/* 
 * Code to test for debug flags.  Enabled iff DEBUG is defined.  If
 * DEBUG isn't defined, DBGFLG() will is defined so that all debugging
 * conditionals will always fail.  A smart compiler like KCC won't
 * even generate code in this case.
 */
#ifdef DEBUG
extern int dbgflg;
#define DBGFLG(mask) (ONE_ON(dbgflg,mask))
#else
#define DBGFLG(mask) (0)
#endif

/*
 * Debug flags.
 * Try to keep these in the low 32 bits for portability, and keep
 * flags that are most generally useful in lowest bits.
 */
#define DBG_LOG		0000000000001	/* "Log" level debugging */
#define DBG_FORCE	0000000000002	/* Force messages to disk */
#define DBG_PID		0000000000004	/* Use debugging PID */
#define DBG_LOOKUP	0000000000010	/* Trace LOOKUP module */
#define DBG_MEMORY	0000000000020	/* Trace MEMORY module */
#define DBG_RESOLV	0000000000040	/* Trace RESOLV module */
#define DBG_RPKT	0000000000100	/* Trace RPKT   module */
#define DBG_TREES	0000000000200	/* Trace TREES  module */
#define DBG_ZT		0000000000400	/* Trace ZT     module */
#define DBG_USR		0000000001000	/* Trace USR    module */
#define DBG_LOAD	0000000002000	/* Trace LOAD   module */
#define DBG_ZZZ		0000000004000	/* Trace ZZZ    module */
#define DBG_RRTOA	0000000010000	/* Trace RRTOA  module */
#define DBG_INSERT	0000000020000	/* Trace INSERT module */
#define DBG_NAM_IN	0000000040000	/* Trace NAM_IN routine */
#define DBG_CHKPNT	0000000100000	/* Trace CHKPNT routine */
#define DBG_GTOKEN	0000000200000	/* Trace GTOKEN module */
#define DBG_GC		0000000400000	/* Trace GC     module */

/* Table lookup routines. */
#include "tblook.h"

/* Byte <-> int conversions. */
#define bint4(x) (((x)[0]<<24)|((x)[1]<<16)|((x)[2]<< 8)|((x)[3]))
#define bint2(x) (((x)[0]<< 8)|((x)[1]))

/*
 * Contact name for domain service, either directly in case of
 * chaosnet or indirectly (via ws_table[]) for IP based protocols.
 */
#define	CONTACT	"DOMAIN"

/* RR RDATA format lookup routine, returns a format string. */
extern char *rrfmt(int,int);

/* Conversion and I/O routines (NAMES.C, RRTOA.C, INADDR.C) */
extern int namcmp(char *,char *), namlen(char *), namcnt(char *);
extern int namexp(char *,char **), namkin(char *,char *), tagcmp(char *,char *);
extern char *namcpy(char *,char *,char *), *namcat(char *,char *,char *);
extern char *namimp(char **,int), *namtoa(char *,char *);
extern char *vnamtoa(char *,char **,int), *inatoa(char *,int);
extern char *wkstoa(char *,char *), *rrtoa(char *,char *,struct rr *);
extern char *rrhtoa(char *,char *,int,int);
extern int atoina(char *);

/* AVL tree routines */
int avladd(struct btnode **,char *,struct rr *,struct btnode **);
int avldel(void);
int avlcnt(struct btnode *);
void avltab(struct btnode *,struct domain **), avlkil(struct btnode *);
struct btnode *avlook(struct btnode *,char *);

/* RR and associated structures, internal (in-memory) format */

union rdatom {				/* Types of data in RR */
    int word;				/* Really just the two basic */
    char *byte;				/* types, as far as we're */
};					/* concerned. */

struct rr {				/* Resource record (RR) */
    int type, class;			/* RR type, class */
    int ttl;				/* RR Time-To-Live */
    union rdatom *rdata;		/* RR specific data */
    struct rr *chain;			/* Next RR for this domain */
};

struct domain {				/* Domain (node in name tree) */
    char *name;				/* The name, internal format */
    union {
	struct rr *rrs;			/* List of RRs at this node */
	struct zone *zoa;		/* Zone (in search "zone" index) */
	int count;			/* Count of children */
    } data;
    union {
	struct domain *dpoint;		/* chain or (child) binary table */
	struct btnode *tpoint;		/* (child) tree */
    } link;
};

struct btnode {				/* Node in binary tree */
    struct domain data;			/* This includes the key */
    int height;				/* AVL height of this node */
    struct btnode *left,*right;		/* Usual binary tree stuff */
};

struct zone {				/* Zone of authority (subtree) */
    struct domain base;			/* Base of this zone (including SOA) */
    struct domain glue;			/* Glue RRs (not authoritative) */
    int gotten;				/* When we got this zone */
    int retried;			/* When we last retried getting it */
    int hidden;				/* Is this zone our-eyes-only? */
    char *srcfil;			/* File from which we loaded zone */
    struct zone *next;			/* Multiple classes, maybe? */
};


/* Memory management declarations  See memory.c. */

extern char		*mak(int);
extern void		 kil(char *);
extern char		*remak(char *,int);

#define	mak_(arg)	((int *)mak(arg))
#define	kil_(arg)	kil((char *)(arg))
#define	remak_(a1,a2)	((int *)remak(((char *)(a1)),(a2)))

extern union rdatom *mak_rdatom(int);
extern struct rr *mak_rr(void);
extern void kil_rr(struct rr *);
extern struct domain *mak_domain(int);
extern void kil_domain(struct domain *,int);
extern struct btnode *mak_btnode(void);
extern void kil_btnode(struct btnode *,void (*kil_payload )(struct rr *));
extern struct zone *mak_zone(void);
extern void kil_zone(struct zone *);

/* Cross between mak() and bcopy(). */
extern char		*bcons(char *,int);

/* Temporary kludge (ha ha). */
extern struct rr *rrcons(struct rr *);

/* C specific things determined by RFC883 (packet formats, etc). */

/*
 * Domain packet header.  Bitfields correspond to EIGHT-BIT chars.
 */

struct dom_header {			/* domain header */
    unsigned	id	: 16;		/* query id */
    unsigned	resp	: 1;		/* is response? */
    unsigned	op	: 4;		/* kind of query */
    unsigned	aa	: 1;		/* responding NS is authority */
    unsigned	tc	: 1;		/* message was truncated */
    unsigned	rd	: 1;		/* recursion desired */
    unsigned	ra	: 1;		/* recursion available */
    unsigned		: 3;		/* fill to 16 */
    unsigned	rcode	: 4;		/* response code */
    unsigned		: 0;		/* fill to word boundry on PDP-10 */
    unsigned	qdcnt	: 16;		/* question section count */
    unsigned	ancnt	: 16;		/* answer section count */
    unsigned		: 0;		/* fill to word boundry on PDP-10 */
    unsigned	nscnt	: 16;		/* authority section count */
    unsigned	arcnt	: 16;		/* additional RR count */
    unsigned		: 0;		/* fill to word boundry on PDP-10 */
};

/* length (bytes) of packet header */
#define	DOM_HLEN	(sizeof(struct dom_header))

/* Macros for casting a (char *) into the appropriate type */
#define DOM_HEADER(p)	((struct dom_header *) (p))
#define DOM_DATA(p)	((p)+DOM_HLEN)

/* "Reserved" bits in compressed domain name */
#define DOM_MSK	    0300

/* Value of "reserved" bits indicating compression pointer */
#define	DOM_PTR	    0300

/* Maximum length of a domain name or label (RFC883, p31). */
/* These are defined in RFCDEF.D, names here are just for readability. */
#define MAX_DOMAIN_NAME_LENGTH	MAXDNM
#define	MAX_DOMAIN_LABEL_LENGTH	MAXLAB

/* Maximum number of tags in a domain name. */
#define MAX_DOMAIN_TAG_COUNT	(MAX_DOMAIN_NAME_LENGTH/2)

/* Layout of RDATA portion of a negative-cache "RR" */
enum { NCACHE_ERRCODE, NCACHE_RDATA_LENGTH };

/*
 * Tables of strings for I/O.  Most of these defined by DSYMS files.
 * Here we just declare the special case tables for WKS and booleans.
 */

extern struct tblook_table yn_table[], *wp_table, *ws_table;


/*
 * User interface interface definitions.  There's also some stuff
 * here that has nothing to do with the user interface, but is
 * part of the query state block that the user interface code
 * initializes, so it may as well go here.
 */

enum query_state {new, hang, retry_ns, retry_cname, done};

struct query_block {
    int seq;				/* Sequence number of this query */
    int quid;				/* Pid, .uind, whatever */
    int qnow;				/* Time when query started */
    int qttd;				/* Time to die */
    char *qname;			/* Query name */
    char *cqname;			/* Cannonicalized qname */
    int class;				/* Query class */
    int type;				/* Query type */
    int flags;				/* User flags */
    int stamp1;				/* "Unique ID" stamp words */
    int stamp2;				/* (or internal crossreference) */
    char **qorigin;			/* Pointer to current origin */
    enum query_state state;		/* State of this query */
    int ncname;				/* Number of CNAMEs seen */
    int ns_count;			/* How many nameservers we have */
    struct ns_atom *ns_list;		/* Nameservers we are asking */
    int ns_ttd;				/* Time when we should next  */
    int ns_idx;				/* Which nameserver we last asked */
    int rcode;				/* Response (error) code */
    struct query_block *next;		/* Next in queue */
};

struct ns_atom {
    char *name;				/* Name if we couldn't get addresses */
    int addr;				/* Best address if we could */
    int count;				/* How many times we asked this one */
    int depends;			/* Seq num of a query we depend on */
};


/* User interface routines */

int usr_init(void), usr_send(struct query_block *,struct domain *);
struct query_block *usr_recv(void);
void usr_rxmt(void), usr_fini(void);

/* Packet parsing routine. */
extern struct domain *rpkt(char *,int);

/* Filenames (FILES.C). */
extern char *wp_name, *ws_name, *cf_name, *ic_name, *rl_name, *rb_name;


/* bug20x.c */
extern int bugini(char *,FILE *,char *,int *,int *);
extern void buginf(char *,char *,...);
extern void bugfls(void);
extern void bugchk(char *,char *,...);
extern void bughlt(char *,char *,...);

/* Checkpoint stuff. */
#define	CHKPNT_LOSE	0
#define	CHKPNT_WIN	1
#define	CHKPNT_RESTART	2

/* Critical routine support. */
void mkcrit(void (*func )(void),int *flag);
void docrit(int remove);

/* DSYMS format stuff. */
#include "dsyms1.h"			/* Definitions of DSYMS format */
#include "rfcdef.d"			/* RFC883 dependent stuff */
#include "intern.d"			/* Internal tokens */
#include "dsyms2.h"			/* Clean up DSYMS stuff */

/*
 * Hardware dependent stuff.
 * For anybody who is reading this who has never worked on a PDP-10,
 * just take it on faith that we have lots of different kinds of bytes
 * here in the past....
 */
#include <c-env.h>
#if (CPU_PDP10+COMPILER_KCC) == 2
typedef _KCCtype_char8 char8;
typedef _KCCtype_char7 char7;
#else
typedef char char8;
typedef char char7;
#endif
