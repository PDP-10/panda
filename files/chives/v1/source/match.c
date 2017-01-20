/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* [XX.LCS.MIT.EDU]XX:<SRA.WORK2>MATCH.C.1,  6-Feb-87 00:30:13, Edit by SRA */

#include "domsym.h"

/* Class matching */
int cmatch(wild,tame)
    int wild,tame;
{
    return(wild == tame || wild == QC_ANY);
}

/* Type matching */
int tmatch(wild,tame)
    int wild,tame;
{
    if(wild == tame)			/* Anything matches itself */
	return(1);
    else switch(wild) {			/* Check for special hair */

	case QT_ANY:			/* Wild matches anything */
	    return(1);

	case QT_MAILA:			/* Mail Agent */
	    return(tame == QT_MX);	/* (MD & MF removed per RFC1035) */

	case QT_MAILB:			/* MailBox-related */
	    return(tame == QT_MB || tame == QT_MR || tame == QT_MG);

	default:			/* Anything else loses */
	    return(0);
    }
}

/* Class known */
int cknown(class)
    int class;
{
    return(class > 0 && (class <= QC_MAX || class == QC_ANY));
}

/* Type known */
int tknown(type)
    int type;
{
    return(type > 0 && (type <= QT_MAX || type == QT_ANY ||
			type == QT_MAILA || type == QT_MAILB));
}
