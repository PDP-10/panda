/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* String tables for things defined in TUPLE macros. */

#include <stdio.h>
#include "domsym.h"

/* DSYMS syntax definitions that we don't care about. */

#define COMMENT
#define CONST(foo,bar)
#define	BSTRUCT(foo)
#define	 DFIELD(foo,bar)
#define	 DHALF(foo)
#define	 DFILL(foo)
#define	 DWORD(foo)
#define	 DWORDS(foo,bar)
#define ESTRUCT(foo,bar)
#define	BRDATA(foo,bar)
#define	 RDATA(foo,bar)
#define	ARDATA(foo,bar)
#define	ERDATA(foo)

/* Tuple stuff.  Define a table, fill in each entry. */
#define	BTUPLE(tuple_name)		struct tblook_table tuple_name[] = {
#define	 TUPLE(symbol,value,string)	 { symbol, string },
#define	ATUPLE(symbol,      string)	 { symbol, string },
#define	ETUPLE				 { -1, NULL }};


/* Include the DSYMS syntax files with the tuple entries. */

#include "rfcdef.d"			/* Tokens defined by RFC883 */
#include "intern.d"			/* Tokens used internally */


/* Table of boolean keywords, doesn't need token assignment stuff. */
struct tblook_table yn_table[] = {
    { 1,	"1"		 },
    { 1,	"TRUE"		 },
    { 1,	"T"		 },
    { 1,	"YES"		 },
    { 1,	"YEA"		 },
    { 1,	"YUP" 		 },
    { 1,	"YUPPERS"	 },
    { 0,	"0"		 },
    { 0,	"FALSE"		 },
    { 0,	"NIL"		 },
    { 0,	"NO"		 },
    { 0,	"NOPE"		 },
    { 0,	"NAY"		 },
    { -1,	NULL		 }
};

/* That's all, folks. */
