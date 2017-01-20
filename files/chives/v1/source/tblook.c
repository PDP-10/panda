/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* Table lookups, case insensitive.  Doesn't depend on domain code. */

#include <stdio.h>			/* Standard I/O */
#include <string.h>			/* String routines */
#include <strung.h>			/* Case insensitive string routines */
#include <stdlib.h>
#include "tblook.h"			/* Defnitions for this module */

/* skipws.c */
extern int skipws(FILE *);

#ifndef	STRSIZ
#define	STRSIZ	512
#endif

int tblook(table,string)
    struct tblook_table *table;
    char *string;
{
    if(table == NULL)			/* in case table didn't  */
	return(-1);			/* initialize properly */
    while(table->code != -1 && strCMP(table->name,string))
	table++;			/* plain sequential search */
    return(table->code);
}

char *looktb(table,value)
    struct tblook_table *table;
    int value;
{
    if(table == NULL)			/* in case table didn't  */
	return(NULL);			/* initialize properly */
    while(table->code != value && table->code != -1)
	table++;			/* plain sequential search */
    return(table->name);
}

/* Load a table from a file */

#define malloc_table(size) \
    ((struct tblook_table *)malloc((size)*sizeof(struct tblook_table)))

struct tblook_table *tbload(stream)
    FILE *stream;
{
    int i, lost = 0, count = 0;
    char s[STRSIZ];
    struct tblook_table *result;
    struct list {
	struct tblook_table data;
	struct list *next;
    } *head = NULL, **tail = &head, *p;

    if(stream == NULL)			/* in case caller blindly handed */
	return(NULL);			/* us the result of a bad fopen() */

    /* First, parse file, save info as linked list */
    while(skipws(stream) && !lost)
	if(   fscanf(stream," %d %s",&i,s) != 2
	   || (p = *tail = (struct list *) malloc(sizeof(struct list))) == NULL
	   || (p->data.name = malloc(strlen(s)+1)) == NULL
	  )				/* if couldn't parse or memory error */
	    ++lost;			/* just punt */
	else {				/* otherwise, link in new item */
	    strcpy(p->data.name,s);
	    p->data.code = i;
	    tail = &(p->next);
	    ++count;
	}

    /* Now move data into an array (tblook() needs this, faster in any case) */
    if(!lost && (result = malloc_table(count+1)) == NULL)
	++lost;
    else {
	for(i = 0, p = head; p != NULL && i < count; ++i, p = p->next) {
	    result[i] = p->data;	/* KCC supports structure assigns */
	    p->data.name = NULL;	/* name ownership passes to array */
	}
	result[count].name = NULL;	/* tie off array with magic values */
	result[count].code = -1;
	if(p != NULL || i++ != count) {
	    fprintf(stderr,"%% tbload(): p=%o, i=%d, count=%d\n",p,i,count);
	    ++lost;
	}
    }

    /* GC. Names might be here if we lost while reading file. */
    while((p = head) != NULL) {
	head = head->next;
	if(p->data.name != NULL)
	    free(p->data.name);
	free((void *)p);
    }

    return(lost ? NULL : result);	/* that's it */
}
