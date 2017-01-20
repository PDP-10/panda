/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* DSYMS syntax definitions */

#define COMMENT

#define CONST(name,value)	    enum { name = value };

#define	BSTRUCT(name)		    struct name {
#define	 DFIELD(name,length)	     unsigned name  : length;
#define	 DHALF( name       )	     unsigned name  : 18;
#define	 DFILL(	     length)	     unsigned	    : length;
#define	 DWORD( name	   )	     unsigned name;
#define	 DWORDS(name,length)	     unsigned name   [length];
#define ESTRUCT(name,tag)	    }; enum {tag = (sizeof(struct name)/sizeof(int))};

#define	BTUPLE(name)		    extern struct tblook_table name[];
#define  TUPLE(name,value,string)   enum { name = value };
#define ATUPLE(name,      string)
#define	ETUPLE

#define	BRDATA(class,type)	    enum {
#define	 RDATA(name,format)	     name,
#define	ARDATA(name,nickname)
#define	ERDATA(name)		     name};

/* The end */
