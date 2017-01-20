/*
 *	REWIND - rewind a stream back to the beginning
 *
 *	Copyright (C) 1986 by Ian Macky, SRI International
 */

#include <stdioi.h>

void rewind(f)
FILE *f;
{
    fseek(f, 0L, SEEK_SET);	/* Go to beginning */
    clearerr(f);		/* and clear error indicator */
}
