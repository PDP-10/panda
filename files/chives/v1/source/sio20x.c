/*
 * Copyright (c) 1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * System-dependent I/O functions:
 *
 * fabort(stream) -- Abort (and close) stream.
 * fufpgs(stream,blockp) -- like fflush() only moreso.
 */

#include <stdio.h>
#include <fcntl.h>
#include <monsym.h>
#include <jsys.h>
#include <macsym.h>

#define fjfn(stream) (fcntl(fileno((stream)),F_GETSYSFD,0))

fabort(stream)
    FILE *stream;
{
    int ac[5];
    fflush(stream);			/* Release buffers first! */
    ac[1] = FLD(fjfn(stream),monsym("CO%JFN"))
	  | monsym("CZ%ABT") | monsym("CZ%NUD");
    return(jsys(CLOSF,ac));		/* Bye bye */
}

/*
 * Code to force a stream to be really, completely flushed.  We always
 * call fflush() first to dump any stdio buffers.  Second argument is
 * boolean indicating whether to block until output has completed; for
 * most devices this will cause a DOBE% jsys to be executed.  Disk
 * requires special hair to defeat the TOPS-20 mechanism which allows
 * output files to disappear completely if they are still open when a
 * fork is reset.  Normally that's a feature, I'm not complaining....
 */

/* Max number of pages a file can have on TOPS-20. */
#define MAX_PAGES 0777777

int fufpgs(stream,blockp)
    FILE *stream;			/* Stream to flush */
    int blockp;				/* Whether to block until finished */
{
    int ac[5], jfn;

    if(stream == NULL || fflush(stream) == EOF)
	return(0);			/* Flush stdio buffers first */

    ac[1] = jfn = fjfn(stream);		/* Extract JFN from unix eumlation */
    if(!jsys(DVCHR,ac))		/* Look up device type */
	return(0);
    ac[1] = jfn;			/* DVCHR% overwrites this */

    switch(FLDGET(ac[2],monsym("DV%TYP"))) { /* Dispatch on device type */

	case monsym(".DVDSK"):		/* Disk files */
	    ac[2] = XWD(1,monsym(".FBBYV")); /* Get FDB byte size */
	    ac[3] = 4;			/* in AC4 */
	    if(!jsys(GTFDB,ac))
		return(0);
	    if((ac[4]&monsym("FB%BSZ")) == 0) {	/* Byte size of zero?? */
		if(!jsys(RFBSZ,ac))	/* New file, get OPENF% size */
		    return(0);
		ac[1] |= FLD(monsym(".FBBYV"),monsym("CF%DSP"));
		if(!blockp)		/* Don't wait if not necessary */
		    ac[1] |= monsym("CF%NUD");
		ac[3] = FLD(ac[2],monsym("FB%BSZ"));
		ac[2] = monsym("FB%BSZ");
		if(!jsys(CHFDB,ac))	/* Set byte size in the FDB */
		    return(0);
	    }
	    ac[1] = XWD(ac[1],0);	/* JFN ,, page zero */
	    ac[2] = XWD(0,MAX_PAGES);	/* Last possible page, */
	    if(!blockp)			/* Don't block if not necessary */
		ac[2] = monsym("UF%NOW");
	    if(!jsys(UFPGS,ac))	/* Force all pages out to disk */
		return(0);
	    ac[1] >>= 18;		/* Get back JFN */
	    if(!jsys(SIZEF,ac))	/* Get byte count */
		return(0);
	    ac[1] |=  FLD(monsym(".FBSIZ"),monsym("CF%DSP"));
	    if(!blockp)			/* Don't block unless requested */
		ac[1] |= monsym("CF%NUD");
	    ac[3] = ac[2];		/* Byte count w.r.t. FB%BSZ size */
	    ac[2] = _FWORD;		/* Fullword value */
	    if(!jsys(CHFDB,ac))	/* Set byte count in FDB */
		return(0);
	    break;

	default:			/* Everything else, assume fflush() */
	    if(blockp && !jsys(DOBE,ac)) /* already did the work, just */
		return(0);		/* wait for system to acknowledge */
	    break;
    }
    return(1);				/* Success */
}
