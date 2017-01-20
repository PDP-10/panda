/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Critical cleanup facility.  Certain things must be done when a
 * system daemon fork crashes or reboots.  In particular, because of
 * braindamage in the TOPS-20 IP code, if we don't release our UDP
 * queue handle it will never be reset.  There may be other cleanup
 * tasks that are required by the calling program.  This is a
 * simplistic attempt at a facility to handle such problems.  It takes
 * two arguments: the first is a routine to call to clean up, the
 * second is the address of a flag variable that can be used to check
 * whether cleanup is required.  NULL as the second argument means
 * always do the cleanup.
 */

#include "domsym.h"

static struct crit_entry {
    void (*func)(void);
    int *flag;
    struct crit_entry *link;
} *crit_list = NULL;

/* Add an entry to the critical list. */
void mkcrit(func,flag)
    void (*func)(void);
    int *flag;
{
    struct crit_entry *p = (struct crit_entry *)mak(sizeof(struct crit_entry));
    p->flag = flag;
    p->func = func;
    p->link = crit_list;
    crit_list = p;
}

/* Process the critical list, possibly removing entries as we go. */
void docrit(remove)
    int remove;
{
    struct crit_entry *p = crit_list;
    while(p != NULL) {
	if(p->flag == NULL || *p->flag)
	    (*(p->func))();
	if(!remove)
	    p = p->link;
	else {
	    crit_list = p->link;
	    kil_(p);
	    p = crit_list;
	}
    }
}
