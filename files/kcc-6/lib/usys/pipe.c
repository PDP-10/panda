/*
**	PIPE
**
**	(c) Copyright Ken Harrenstien 1989
**
*/

#include <c-env.h>

#if SYS_T20+SYS_10X		/* Systems supported for */

#include <stddef.h>
#include <errno.h>
#include <sys/usydat.h>
#include <sys/file.h>	/* For O_ flag definitions */

#if SYS_T20

#include <sys/param.h>
#include <jsys.h>

/* syspipe(read,write) - low-level support for pipe()
**	int *read,*write;
**
**	fildes[0] gets read end, fildes[1] gets write
**	returns 0 for success, -1 for failure
**
**	KLH: Note screw - we must use .GSSMB in the OPENF% otherwise
**	the current T20 pipe code won't allow the reader to get at
**	stuff in the pipe until the monitor buffer is full.  But using
**	.GSSMB essentially makes the pipe unbuffered, so there is a context
**	switch for each byte!  Barf -- the monitor pipe code needs to be
**	re-done properly.
*/

static int
syspipe(read, write)
int *read, *write;
{
    int acs[5];
    char file[MAXPATHLEN], *p;

    *write = *read = 0;
    acs[1] = GJ_SHT;
    acs[2] = (int)("PIP:" - 1);
    if (!jsys(GTJFN, acs)) goto errxit;
    *write = acs[1];				/* This is write side */
    acs[1] = (int)(file - 1);
    acs[2] = *write;
    acs[3] = 0101000000000 | JS_PAF;		/* Get dev:name */
    if (!jsys(JFNS, acs)) goto errxit;
    p = (char *)acs[1];				/* Get pointer to end */
    *++p = '.';					/* Tack on '.' */
    acs[1] = (int) p;
    acs[3] = 0001000000000;			/* Tack on 2nd copy of name */
    if (!jsys(JFNS, acs)) goto errxit;
    acs[1] = GJ_SHT;
    acs[2] = (int)(file - 1);			/* Get jfn on read side */
    if (!jsys(GTJFN, acs)) goto errxit;
    *read = acs[1];				/* This is read side */
    acs[2] = 0110000000000 | OF_RD;		/* Open for 9-bit read */
    if (!jsys(OPENF, acs)) goto errxit;
    acs[1] = *write;
    acs[2] = 0110000000000 | OF_WR;		/* Open for 9-bit write */
    if (!jsys(OPENF, acs)) goto errxit;
    return 0;
    
  errxit:
    if (acs[1] = *write) {
	jsys(CLOSF, acs);
	jsys(RLJFN, acs);
    }
    if (acs[1] = *read) {
	jsys(CLOSF, acs);
	jsys(RLJFN, acs);
    }
    *write = *read = 0;
    return -1;
}	/* End of _pipe() */
#endif /* T20 */

/* ------------------ */
/*      get pipe      */
/* ------------------ */
int
pipe(fildes)
int fildes[2];
{
    int ifd, ofd;
    struct _ufile *in, *out;
#if SYS_T20
    int ijfn, ojfn;
#endif
    USYS_BEG();

    /* Get an input FD and UF slot */
    if ((ifd = _uiofd()) < 0 || !(in = _ufcreate()))
	USYS_RET(-1);		/* No FD or UF slots (errno is set) */
    USYS_VAR_REF(uffd[ifd]) = in; /* Claim FD */

    /* Get an output FD and UF slot */
    if ((ofd = _uiofd()) < 0 || !(out = _ufcreate())) {
	in->uf_nopen = 0;	/* Failed, free up input UF slot */
	USYS_VAR_REF(uffd[ifd]) = NULL;	/* Ditto FD slot, sigh */
	USYS_RET(-1);		/* No FD or UF slots (errno is set) */
    }

#if SYS_T20
    if (syspipe(&ijfn, &ojfn) == 0) {
	out->uf_ch = ojfn;	/* Set returned JFNs up in UF */
	in->uf_ch = ijfn;
	_openuf(ifd, in, O_RDONLY);	/* Then finish rest of UF setup */
	_openuf(ofd, out, O_WRONLY);
	fildes[0] = ifd;	/* Return input and output FD values */
	fildes[1] = ofd;
	USYS_RET(0);		/* Success! */
    }
#endif
    in->uf_nopen = 0;	/* Failed, free up input UF slot */
    out->uf_nopen = 0;	/* and free up output UF slot */
    USYS_VAR_REF(uffd[ifd]) = NULL; /* also FD slot, sigh */
    USYS_RETERR(ENXIO);	/* Well, what else can we use... */
}

#endif /* T20+10X */
