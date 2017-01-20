/*
**	_CLEANUP - final cleanup for stdio upon exit
**
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v., 27-Jul-1989
**	Copyright (c) 1986 by Ian Macky, SRI International
*/

#include <stdio.h>

void _cleanup()
{
    register FILE *f;

    for (f = &_sios[0]; f < &_sios[FOPEN_MAX]; f++)
	if (f->sioflgs & _SIOF_OPEN)		/* Check static FILEs */
	    fclose(f);
    while (f = _FILE_head) {			/* Close dynamic FILEs */
	_FILE_head = f->sionFILE;		/* Get next FILE in chain */
	fclose(f);
    }	
}
