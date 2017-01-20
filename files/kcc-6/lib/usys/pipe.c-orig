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
#include <sys/usysio.h>
#include <sys/usysig.h>
#include <sys/file.h>	/* For O_ flag definitions */

extern int _uiofd();	/* From open() */

#if SYS_T20
extern int _openuf();	/* From open() */
static int syspipe();
#endif


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
    in->uf_nopen = 1;		/* Pretend UF open so don't get again */
    _uffd[ifd] = in;		/* Pretend ditto for FD */

    /* Get an output FD and UF slot */
    if ((ofd = _uiofd()) < 0 || !(out = _ufcreate())) {
	in->uf_nopen = 0;	/* Failed, free up input UF slot */
	_uffd[ifd] = NULL;	/* Ditto FD slot, sigh */
	USYS_RET(-1);		/* No FD or UF slots (errno is set) */
    }

#if SYS_T20
    if (syspipe(&ijfn, &ojfn) == 0) {
	out->uf_ch = ojfn;	/* Set returned JFNs up in UF */
	in->uf_ch = ijfn;
	_openuf(in, O_RDONLY);	/* Then finish rest of UF setup */
	_openuf(out, O_WRONLY);
	_uffd[ofd] = out;	/* Say output FD is open (other already is) */
	fildes[0] = ifd;	/* Return input and output FD values */
	fildes[1] = ofd;
	USYS_RET(0);		/* Success! */
    }
#endif
    in->uf_nopen = 0;	/* Failed, free up input UF slot */
    _uffd[ifd] = NULL;	/* Ditto FD slot, sigh */
    USYS_RETERR(ENXIO);	/* Well, what else can we use... */
}

#if SYS_T20
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
#asm
	SEARCH MONSYM
	EXTERN $RETN		/* From CRT */

	MOVE	1,[GJ%SHT]	;Using short form
	HRROI	2,[ASCIZ/PIP:/]	;A pipe with default size buffers
	GTJFN%			;Create an instance of a pipe device
	 ERJMPA	$RETN
	MOVEM	1,@-2(17)	;Store it away
	MOVE	2,@-2(17)	;Get back the first JFN
	ADJSP	17,20		;Make some space
	HRROI	1,-17(17)	;And point to it
	MOVE	3,[1B2!1B8!JS%PAF] ;Output device and filename w/punc
	JFNS%			;Build a second string for GTJFN%
	MOVEI	3,"."		;Get dot to separate name and extension
	IDPB	3,1		;Tack on the dot
	MOVE	2,@-2-20(17)	;Get back that JFN
	MOVE	3,[1B8]		;Output filename again, no punc.
	JFNS%			;Create "PIP:#.#"
	SETZ	3,		;Get a null byte
	IDPB	3,1		;Tie off second GTJFN% string
	MOVE	1,[GJ%SHT]	;Using short form
	HRROI	2,-17(17)	;Point to string we just built
	GTJFN%			;Get a JFN on the other side of pipe
	 ERJMPA [ ADJSP	17,-20
		 JRST $RETN ]
	ADJSP	17,-20		;Give back temp space
	MOVEM	1,@-1(17)	;Use that as the read side
	MOVE	1,@-2(17)	;Get the JFN for the write side
	MOVE	2,[7B5!1B9!OF%WR]	;7-bits, .GSSMB, write access
	OPENF%			;Create write side
	 ERJMPA	$RETN
	MOVE	1,@-1(17)	;Get the JFN to use for the read side
	MOVE	2,[7B5!1B9!OF%RD]	;7-bits, .GSSMB, read access
	OPENF%			;Create read side
	 ERJMPA	$RETN
#endasm
	return 0;		/* Success return value is 0 */
}	/* End of _pipe() */
#endif /* T20 */

#endif /* T20+10X */
