/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* match.c */
extern int cmatch(int,int );

/*
 * rrfmt(class,type) -- return a format string describing this RR type.
 *
 * Currently defined format specifiers:
 *
 * s - string (one length byte followed by that many data bytes);
 * d - domain name (series of strings terminated by null string);
 * 4 - 32 bit (decimal) integer;
 * 2 - 16 bit (decimal) integer;
 * c - 16 bit (octal) integer (for chaos addresses);
 * i - dotted format (32 bit) internet address;
 * w - WKS bitvector.
 *
 * If type or class is illegal in some way the return value will be
 * NULL.  An empty string is a legal return value and means that there
 * is nothing to handle (eg, the NULL RR type).
 */

/*
 * If hairy macros turn your stomach, stop reading NOW.
 *
 * Ok, you asked for it.  rrfmt() itself is just a table lookup
 * routine.  All the hair comes from constructing the table from
 * the symbolic definitions in RFCDEF.D.  We also have to include
 * some code to check that our format strings are long enough.
 * This wouldn't be necessary if the C preprocessor wasn't so
 * simple minded.  As it is, keep a tight grip on your lunch....
 */

/* First get normal symbols */
#include "domsym.h"

/* NOP out DSYMS macros we don't need. */
#define COMMENT
#define CONST(foo,bar)
#define	BSTRUCT(foo)
#define	 DFIELD(foo,bar)
#define	 DHALF(foo)
#define	 DFILL(foo)
#define	 DWORD(foo)
#define	 DWORDS(foo,bar)
#define ESTRUCT(foo,bar)
#define	BTUPLE(foo)
#define	 TUPLE(foo,bar,baz)
#define	ATUPLE(foo,bar)
#define	ETUPLE

/* Construct descriptor table. */

#define	BRDATA(class,type)	{ class, type, {
#define	 RDATA(name,format)	  format,
#define	ARDATA(name,nickname)
#define	ERDATA(name)		  '\0' } },

static struct rdata_table {
    int	class,type;
    char format[MAX_RDATA_FIELDS+1];
} rdata_table[] = {
#include "rfcdef.d"
    { 0, 0, ""}				/* wasted space, oh well */
};
#define	RDATA_TABLE ((sizeof(rdata_table)/sizeof(struct rdata_table))-1)

/*
 * Make length checking code.  A decent optimizing compiler should not
 * have to generate any code here, it can all be done at compile time.
 */
#undef	BRDATA
#undef	 RDATA
#undef	ERDATA
#define	BRDATA(foo,bar)
#define	 RDATA(foo,bar)
#define	ERDATA(name)	    || ((name) > MAX_RDATA_FIELDS)

char *rrfmt(class,type)
    int class,type;
{
    int i;  struct rdata_table *p;

    if(0				/* RFCDEF.D generates || clauses */
#include "rfcdef.d"
      ) bughlt("rrfmt","rdata length field check failed");

    /* Class may be wildcarded in table, type may not. */
    for(i = RDATA_TABLE, p = rdata_table; --i >= 0; ++p)
	if(type == p->type && cmatch(p->class,class))
	    return(p->format);
    return(NULL);
}
