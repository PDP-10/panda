/*
 *	UNGETC - unget a character to stream
 *
 *	Copyright (c) 1986 by Ian Macky, SRI International
 */

#include <stdio.h>

int ungetc(c, f)
int c;
register FILE *f;
{
#if 1
    if (!_readable(f) || c == EOF)
#else /* Old */
    if ((f->siocheck != _SIOF_OPEN) || !(f->sioflgs & _SIOF_READ) || c == EOF)
#endif
	return EOF;			/* validate FILE block */
    if (f->sioflgs & _SIOF_PBC) {
	if (f->siocnt >= _SIO_NPBC)	/* room for another? */
	    return EOF;			/* no, so punt */
	f->siocnt++;			/* yes, bump count */
	f->sioflgs &= ~_SIOF_EOF;	/* Turn off EOF flag */
	return *f->siocp-- = c;		/* and store new char in buf */
    } else {
	f->sio2cp = f->siocp;		/* save old pointer */
	f->sio2cnt = f->siocnt;		/* save old count */
	f->siocp = f->siopbc + _SIO_NPBC - 2; /* point to before EOB */
	f->siocnt = 1;			/* start with 1 char */
	f->sioflgs |= _SIOF_PBC;	/* flag that we're in unget */
	f->sioflgs &= ~_SIOF_EOF;	/* Turn off EOF flag */
	return *(f->siocp + 1) = c;	/* store and return the char */
    }
}
