/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* Load whatever tables we might need.  Add as needed. */

#include "domsym.h"

struct tblook_table *ws_table = NULL, *wp_table = NULL;

gtable()
{
    FILE *f;
    int won = 1;

    won &= (wp_table = tbload(f = fopen(wp_name,"r"))) != NULL;
    if(f != NULL)
	fclose(f);

    won &= (ws_table = tbload(f = fopen(ws_name,"r"))) != NULL;
    if(f != NULL)
	fclose(f);

    return(won);
}
