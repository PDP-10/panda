/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* Conversion routines, Internet Address <-> string */

#include <stdio.h>

char *inatoa(string,addr)
    char *string;
    int addr;
{
    int a[4], i;
    for(i = 4; --i >= 0; addr >>= 8)
	a[i] = addr&0xFF;
    if(sprintf(string,"%d.%d.%d.%d", a[0], a[1], a[2], a[3]) == EOF)
	return(NULL);
    else
	return(string);
}


int atoina(string)
    char *string;
{
    int a,b,c,d;
    if(sscanf(string,"%d.%d.%d.%d", &a, &b, &c, &d) != 4)
	return(-1);			/* No Martians */
    return(((((((a&0xFF)<<8)|(b&0xFF))<<8)|(c&0xFF))<<8)|(d&0xFF));
}
