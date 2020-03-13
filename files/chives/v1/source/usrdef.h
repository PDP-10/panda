/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* USRDEF for C, with DSYMS stuff hidden and a few extra macros. */

/* The real USRDEF stuff is in USRDEF.D. */
#include "dsyms1.h"			/* Declare DSYMS macros */
#include "usrdef.d"			/* User interface symbols */
#include "dsyms2.h"			/* Undeclare DSYMS stuff */

/* A few macros useful for casting pointers. */
#define	U_PAGE_HEADER(p)    ((struct u_page_header *)(p))
#define	U_DATA_HEADER(p)    ((struct u_data_header *)((p)+U_PHSIZE))
#define	U_RR_HEADER(p)	    ((struct u_rr_header *)(p))
