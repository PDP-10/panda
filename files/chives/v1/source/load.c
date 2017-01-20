/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Master file loading.
 */

#include "domsym.h"

/* gtoken.c */
extern int gtoken(FILE *,char *,int *,int);

/* tim20x.c */
extern int zulu(void);

/* gtoken.c */
extern int geol(FILE *,int *);

/* memory.c */
extern void kil_rdatom(union rdatom *,int,int );

/* insert.c */
extern int insert(struct btnode **,char *,struct rr *,int,int);

/* load.c */
int fload(FILE *,struct zone *,struct btnode **,char *,int,int );
int zload(FILE *,struct zone *,struct btnode **,char *,int,int);
int zcache(struct domain *,struct btnode **,char **,int,int);
int cload(FILE *,struct btnode **);
char *nam_in(char *,char *,char *);
int zreload(void);

/* load.c */
static void zfixup(struct domain *);
static union rdatom *rd_in(FILE *,int,int,char *,int *);
static int do_include(struct zone *,struct btnode **,char *,char *,int,int );

/*
 * fload(file, zone, tree, origin, class, just_soa) -- load a file.
 *
 * Origin is assumed to be in fully-specified format.
 * If just_soa is set, we ignore any RRs other than SOA (aka skim mode).
 */

#define	punt(msg) return(bugchk("fload",msg),0)

int fload(f,z,tree,origin,class,just_soa)
    FILE *f;
    struct zone *z;
    struct btnode **tree;
    char *origin;
    int class, just_soa;
{
    char s[STRSIZ], name[STRSIZ], _origin[STRSIZ];
    int i, ttl;
    struct rr *r;
    union rdatom *a;
    int type;
    int crockp = 0;			/* no line continuation yet */
    int seenws = 0;			/* seen no whitespace yet */
    int namdef = 0;			/* no default name yet */
    *name  = '\0';			/* paranoia */

    switch((z == NULL)+(tree == NULL)) {
	case 0:	punt("can't put data into both zone and tree");
	case 2: punt("can't put data into neither zone nor tree");
    }

    if(origin == NULL)			/* default the origin */
	origin = ".";			/* to something harmless */

    while(gtoken(f,s,&crockp,0))	/* get a leading token */
	switch(*s) {			/* dispatch on first char */

	    case ';':	case '\t':	/* paranoia */
		punt("gtoken() returned bad token");

	    case ' ':			/* whitespace */
		seenws = 1;		/* remember we saw it */
		continue;		/* next */

	    case '\n':			/* blank line */
		seenws = 0;		/* remember we saw it */
		continue;		/* next */

	    case '$':			/* meta foobar */
		switch(tblook(zl_table,s+1)) {

		    case ZL_DATE:
			if(z == NULL)
			    bugchk("fload","%s in cache file",s);
			else if(gtoken(f,s,&crockp,1) && sscanf(s," %d",&i) == 1)
			    z->gotten = i;
			else
			    bugchk("fload","bad load date \"%s\"",s);
			break;

		    case ZL_RETRY:
			if(z == NULL)
			    bugchk("fload","%s in cache file",s);
			else if(gtoken(f,s,&crockp,1) && sscanf(s," %d",&i) == 1)
			    z->retried = i;
			else
			    bugchk("fload","bad retry date \"%s\"",s);
			break;

		    case ZL_CACHE:
			if(!gtoken(f,s,&crockp,1) || (i = tblook(yn_table,s)) == -1)
			    bugchk("fload","bad boolean \"%s\"",s);
			else if(i != (z == NULL))
			    bugchk("fload","cache_p == %d, z == %o",i,z);
			break;

		    case ZL_HIDDEN:
			if(z == NULL)
			    bugchk("fload","%s in cache file",s);
			else if(gtoken(f,s,&crockp,1) && (i = tblook(yn_table,s)) != -1)
			    z->hidden = i;
			else
			    bugchk("fload","bad boolean \"%s\"",s);
			break;

		    case ZL_INCLUDE:
			if(fscanf(f," %[^\n]",s) != 1 || !do_include(z,tree,s,origin,class,just_soa))
			    punt("$INCLUDE lost");
			break;

		    case ZL_ORIGIN:
			if(fscanf(f," %[^\n]",_origin) != 1)
			    punt("$ORIGIN lost");
			origin = _origin;
			break;

		    case -1:		/* lookup failed */
		    default:		/* maybe obsolete switch? */
			bugchk("fload","option \"%s\" unknown, ignoring",s);
			break;
		}
		geol(f,&crockp);	/* make sure EOL is next */
		seenws = 0;		/* new line so no whitespace yet */
		continue;		/* and go get next token */

	    default:			/* must be an RR */

		/*
		 * Handle skim mode.  Assume we've seen SOA if default
		 * name exists (ie, SOA must be first RR) and assume
		 * we are done with the zone file, (ie, meta-frobs must
		 * come before SOA).
		 */
		if(just_soa && namdef)
		    return(1);

		/* NAME (optional) */
		if(!seenws) {		/* does line begin with a name? */
		    if(DBGFLG(DBG_LOAD))
			buginf("fload","name: %s (%s)",s,origin);
		    nam_in(name,s,origin);
		    gtoken(f,s,&crockp,1);
		    namdef = 1;
		}
		else if(!namdef)	/* no, default */
		    punt("No default NAME, can't parse");
		else if(DBGFLG(DBG_LOAD))
		    buginf("fload","defaulting name");

		/* TTL (optional) */
		if(sscanf(s," %d",&ttl) == 1)
		    gtoken(f,s,&crockp,1);
		else if(z != NULL)	/* no TTL, ok for zones */
		    ttl = 0;		/* will use MINIMUM later */
		else			/* but not ok in the cache */
		    punt("can't default TTLs in cache zone");
		if(z != NULL && (ttl & ~0xFFFFFFFF))
		    punt("TTL out of range");
		if(DBGFLG(DBG_LOAD))
		    buginf("fload","TTL: %d",ttl);

		/* CLASS (optional) */
		if((i = tblook(qc_table,s)) > 0 && i <= QC_MAX) {
		    if(class < 0)
			class = i;
		    else if(class != i)
			punt("can't change class in the middle of a zone");
		    if(DBGFLG(DBG_LOAD))
			buginf("fload","class: %d (%s)",i,s);
		    gtoken(f,s,&crockp,1);
		}
		else if(i == QC_ANY)
		    punt("can't use \"*\" in master file");
		else if(class == -1)
		    punt("no CLASS");	/* how true */
		else if(DBGFLG(DBG_LOAD))
		    buginf("fload","defaulting class");

		/* TYPE (mandatory) */
		if((i = tblook(qt_table,s)) > 0 && i <= QT_MAX)
		    type = i;
		else if(i == QT_ANY)
		    punt("can't use \"*\" in master file");
		else
		    punt("no TYPE");
		if(DBGFLG(DBG_LOAD))
		    buginf("fload","type: %d (%s)",i,s);

		/* RDATA */
		if((a = rd_in(f,class,type,origin,&crockp)) == NULL)
		    punt("couldn't parse RDATA");

		geol(f,&crockp);	/* make sure EOL is next */
		seenws = 0;		/* new line so no whitespace yet */

		/* Done parsing, cons up the RR */
		r = mak_rr();	    r->ttl = ttl;
		r->type  = type;    r->class = class;
		r->rdata = a;

		/*
		 * Put the RR in the appropriate place.  Non-zone RRs
		 * just go in the tree.  An SOA going into a zone must
		 * be the first RR in the zone, and the first RR in a
		 * zone must be the SOA.  Other RRs for the base name
		 * of the zone are also handled specially, all others
		 * are just inserted into the tree.  Glue RRs have to
		 * be handled specially, since they are neither
		 * authoritative nor necessarily in the same tree as
		 * the zone itself (properly, they should always be
		 * from children of the current zone, but in practice
		 * people screw this up a lot due to confusion).
		 */
		if(DBGFLG(DBG_LOAD)) {
		    char rrtext[STRSIZ];
		    buginf("fload","inserting %s",rrhtoa(rrtext,name,r->class,r->type));
		}
		if(z == NULL)
		    i = insert(tree,name,r,0,0);
		else if(z->base.data.rrs == NULL || r->type == QT_SOA) {
		    if(z->base.data.rrs != NULL)
			punt("SOA isn't first RR in zone");
		    if(r->type != QT_SOA)
			punt("first RR in zone isn't SOA");
		    z->base.name = bcons(name,namlen(name));
		    z->base.data.rrs = r;
		    i = 1;
		}
		else if(namcmp(name,z->base.name) == 0) {
		    struct rr **p = &(z->base.data.rrs);
		    while(*p != NULL)
			p = &((*p)->chain);
		    *p = r;
		    i = 1;
		}
		else if(namkin(z->base.name,name) >= 0)
		    i = insert(&(z->base.link.tpoint),name,r,namcnt(z->base.name),0);
		else {
		    if(DBGFLG(DBG_LOAD))
			buginf("fload","glue RR");
		    i = insert(&(z->glue.link.tpoint),name,r,0,0);
		}

		if(!i)
		    punt("couldn't insert RR");

		/*
		 * Now that we're sure there's an SOA RR for this zone
		 * (if it's in fact a zone), we can fix up the TTL of
		 * this RR if needed.  Might happen if this RR came
		 * from a local file and didn't have any TTLs in it.
		 * Doing this now will save cycles in the lookup code.
		 */
		if(z != NULL && r->ttl < z->base.data.rrs->rdata[SOA_MINIMUM].word)
		    r->ttl = z->base.data.rrs->rdata[SOA_MINIMUM].word;

    }					/* Go do next entry in file */

    return(1);				/* won if we get here */
}
#undef punt


/*
 * zload(file,zone,cache,origin,class,just_soa) -- load a zone from a file.
 */

#define	punt(msg) return(bugchk("zload",msg),0)

int zload(f,z,cache,origin,class,just_soa)
    FILE *f;
    struct zone *z;
    struct btnode **cache;
    char *origin;
    int class;
    int just_soa;
{
/* RWF    void zfixup(); */
    char *vector[MAX_DOMAIN_TAG_COUNT+1];

    if(!fload(f,z,NULL,origin,class,just_soa))
	punt("fload failed");
    zfixup(&(z->base));			/* mash AVL trees into binary tables */
    zfixup(&(z->glue));
    if(cache != NULL)			/* stuff glue RRs into the cache */
	zcache(&(z->glue),cache,vector+MAX_DOMAIN_TAG_COUNT+1,0,zulu());
    if(DBGFLG(DBG_LOAD))
	buginf("zload","zload finished");
    return(1);				/* won if we get here */
}

/* Recursive routine to mash children of one (struct domain) */
static void zfixup(parent)
    struct domain *parent;
{
    int nnodes;
    struct domain *d, *kids;
    struct btnode *tree;

    if(parent == NULL || (tree = parent->link.tpoint) == NULL)
	return;
    if((nnodes = avlcnt(tree)) == 0)	/* count nodes in AVL tree */
	bugchk("zfixup","no child nodes, parent=%o, parent->link.tpoint=%o",
	    parent,parent->link.tpoint);
    d = kids = mak_domain(nnodes+1);	/* allocate binary table */
    if(DBGFLG(DBG_LOAD))
	buginf("zfixup","parent=%o, tree=%o, nnodes=%d, kids=%o",
		(int)parent,(int)tree,nnodes,(int)kids);
    kids->data.count = nnodes;		/* remember length */
    avltab(tree,&d);			/* this trashes d */
    parent->link.dpoint = kids;		/* atomic insertion */
    avlkil(tree);			/* reclaim storage */
    while(--nnodes >= 0)		/* process children */
	zfixup(++kids);
    return;
}
#undef punt

/*
 * zcache() -- put glue RRs from zone into cache.
 */

int zcache(parent,cache,vector,ntags,now)
    struct domain *parent;
    struct btnode **cache;
    char **vector;
    int ntags;
    int now;
{
    struct domain *d;
    int i, n;

    if((d = parent->link.dpoint) == NULL || (n = d->data.count) == 0)
	return(1);
    --vector;	++ntags;
    if(DBGFLG(DBG_LOAD))
	buginf("zcache","#1, vector=%o, ntags=%d",vector,ntags);
    for(++d, i = 1; i <= n; ++d, ++i) {
	struct rr *r;
	char *name;
	*vector = d->name;
	name = namimp(vector,ntags);
	if(DBGFLG(DBG_LOAD)) {
	    char rrtext[STRSIZ];
	    buginf("zcache","name=\"%s\", d=%o, i=%d, n=%d",
		    namtoa(rrtext,name),d,i,n);
	}
	for(r = d->data.rrs; r != NULL; r = r->chain) {
	    struct rr *t = rrcons(r);
	    t->ttl += now;
	    insert(cache,name,t,0,1);
	}
	if(!zcache(d,cache,vector,ntags,now))
	    return(0);
	if(name != NULL)
	    kil(name);
    }
    if(DBGFLG(DBG_LOAD))
	buginf("zcache","#2, vector=%o, ntags=%d",vector,ntags);
    return(1);
}

/*
 * cload(file, cache)
 */

int cload(f,cache)
    FILE *f;
    struct btnode **cache;
{
    return(fload(f,NULL,cache,".",-1,0));
}

/*
 * Read RDATA portion from file.
 */

#define punt	{   if(result != NULL)			\
			kil_rdatom(result,class,type);	\
		    return(NULL);			\
		}

static union rdatom *rd_in(stream,class,type,origin,crockp)
    FILE *stream;
    int	  class;
    int	  type;
    char *origin;
    int  *crockp;
{
    char s[STRSIZ], *format;
    union rdatom *a, *result = NULL;
    int i;

    if((format = rrfmt(class,type)) == NULL)
	punt;

    result = mak_rdatom(strlen(format));

    for(a = result; *format != '\0'; ++a, ++format)
	switch(*format) {
	    case 'd':			/* domain name */
		    gtoken(stream,s,crockp,1);
		    if(*s == '\0' || *s == '\n')
			punt;
		    if(DBGFLG(DBG_LOAD))
			buginf("rd_in","rdata(d): %s",s);
		    if((a->byte = nam_in(NULL,s,origin)) == NULL)
			punt;
		    continue;

	    case 's':			/* string */
		    i = ftell(stream);	/* remember where it starts */
		    gtoken(stream,s,crockp,1);
		    if(*s == '\0' || *s == '\n')
			punt;
 		    if(*s == '"') {	/* quoted string? */
			char *p = s;	/* yup, different parsing */
			fseek(stream,i+1,0);	/* skip opening quote */
			while((i = fgetc(stream)) != '"')
			    switch(i) {		/* copy verbatim till close */
				case EOF:   punt;		    /* sic */
				case '\\':  *p++ = fgetc(stream);   continue;
				case '\n':  *p++ = '\r';	    /* sic */
				default:    *p++ = i;		    continue;
			    }
			*p = '\0';		/* tie off string */
		    }
		    if(DBGFLG(DBG_LOAD))
			buginf("rd_in","rdata(s): %s",s);
		    a->byte = mak((i = strlen(s))+1);
		    *(a->byte) = i;
		    strncpy(a->byte+1,s,i);
		    continue;

	    case '4':			/* four byte integer */
	    case '2':			/* two byte integer */
	    case 'c':			/* chaosnet numeric address */
		    gtoken(stream,s,crockp,1);
		    if(*s == '\0' || *s == '\n')
			punt;
		    if(sscanf(s, (*format == 'c' ? "%o" : "%d"), &a->word) != 1
			    || (a->word & (*format == '4' ? ~0xFFFFFFFF : ~0xFFFF)))
			punt;
		    if(DBGFLG(DBG_LOAD))
			buginf("rd_in","rdata(%c): %d (%s)",*format,a->word,s);
		    continue;

	    case 'i':			/* IP numeric address */
		    gtoken(stream,s,crockp,1);
		    if(*s == '\0' || *s == '\n')
			punt;
		    if((a->word = atoina(s)) & ~0xFFFFFFFF)
			punt;
		    if(DBGFLG(DBG_LOAD))
			buginf("rd_in","rdata(i): %d (%s)",a->word,s);
		    continue;

	    case 'w':			/* Ick, what a gross format */
		    /* IP Well Known Service stuff.  This is */
		    /* hopelessly bit oriented, no point in even */
		    /* trying to make it compatable with other */
		    /* protocols.  Format of binary string is one byte */
		    /* of IP protocol followed by bitvector of active */
		    /* ports.  We always use the maximum size */
		    /* bitvector because the code gets too gross for */
		    /* words if we use variable length vectors. */

		    gtoken(stream,s,crockp,1);
		    if((i = tblook(wp_table,s)) == -1)
			punt;
		    if(DBGFLG(DBG_LOAD))
			buginf("rd_in","rdata(w) %d (%s)",i,s);
		    *(a->byte = mak(IN_WKS_TOTAL_LENGTH)) = (char) i;
		    while(gtoken(stream,s,crockp,1), *s != '\n')
			if((i = tblook(ws_table,s)) != -1 && i <= IN_WKS_MAX_BITS)
			    a->byte[1 + i/8] |= 0200 >> (i % 8);
		    ungetc('\n',stream);    /* put the end-of-line back, else */
		    continue;		    /* the geol() in zload() will barf */

	    default:
		    bugchk("rd_in","unknown rrfmt() option '%c'",*format);
		    punt;
	}				/* end moby switch */
    return(result);
}
#undef  punt

/*
 * Handle an $INCLUDE line in a master file.
 *
 * Note that the format is ambigious for ITS, since a filespec may
 * have an arbitrary number of whitespace characters in it and since
 * the trailing origin token may be omitted from the $INCLUDE line.
 * So ITS filenames have to be delimited (a la ASCIZ).
 */

#define	punt(msg) return(bugchk("do_include","%s: \"%s\"",msg,s),0)

static int do_include(z,tree,s,origin,class,just_soa)
    struct zone *z;
    struct btnode **tree;
    char *s, *origin;
    int class, just_soa;
{
    FILE *f;
    char s1[STRSIZ], s2[STRSIZ];
    int i;

#if SYS_ITS
    /* Aiming for something like " |%[^|]| %s". */
    char fmt[15];
    sscanf(s,"%1s",s1);
    sprintf(fmt," %s%%[^%s]%s %%s", s1,s1,s1);
#else
    char *fmt = " %s %s";
#endif

    switch(sscanf(s, fmt, s1, s2)) {
	case 1:	    strcpy(s2,origin);
		    break;
	case 2:	    i = strlen(s2);
		    if(i == 1 && *s2 == '@')
			strcpy(s2,origin);
		    else if(s2[i-1] != '.')
			sprintf(s2+i,".%s",origin);
		    break;
	default:    punt("couldn't parse");
    }
    if((f = fopen(s1,"r")) == NULL)
	punt("couldn't open $INCLUDE file");
    i = fload(f,z,tree,s2,class,just_soa);
    fclose(f);
    if(!i)
	punt("couldn't load $INCLUDEd file");
    return(1);
}
#undef  punt


/*
 * Convert a text name into internal format.  Understands special crocks,
 * origins, etc.  If first argument is non-NULL, is place to put result,
 * else a byte string is created (maximum size) and realloc()'d down to
 * size.  This should be ok since there is no other memory twiddling going
 * on between these events, so it shouldn't fragement too much.
 */

#define	punt(msg) { bugchk("nam_in",msg);	    \
		    if(cons_p && binary != NULL)    \
			kil(binary);		    \
		    return(NULL);		    \
		  }

char *nam_in(binary,text,origin)
    char *binary,*text,*origin;
{
    char s[STRSIZ], *b = NULL;
    int i, n = 0, cons_p = 0;

    if(origin == NULL || text == NULL)
	punt("bad parameters");

    if(origin[strlen(origin)-1] != '.')
	punt("malformed origin");

    if((i = strlen(text)) == 0)
	punt("null name");

    if(strcmp(text,"@") == 0)
	text = origin;
    else if(text[i-1] != '.' || text[i-2] == '\\') {
	sprintf(s,"%s.%s", text, origin);
	text = s;
    }

    b = ((cons_p = binary == NULL) ? (binary = mak(MAX_DOMAIN_NAME_LENGTH))
				   : binary);

    do {
	if(++n >= MAX_DOMAIN_NAME_LENGTH)
	    punt("name too long");
	i = 0;
	while(*text != '\0' && *text != '.') {
	    if(text[0] == '\\' && text[1] == '.')
		++text;
	    if(DBGFLG(DBG_NAM_IN))
		buginf("nam_in","char: %c",*text);
	    b[++i] = *text++;
	}
	if(DBGFLG(DBG_NAM_IN))
	    buginf("nam_in","char: %c, count: %d",*text,i);
	*b = i;
	b += i+1;
    } while(*text++ != '\0');

    return(cons_p ? remak(binary,namlen(binary)) : binary);
}

int zreload()
{
    bugchk("zreload","NIY");
    return(0);
}
