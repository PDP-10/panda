/*
**	 SBRK	- low level memory allocation for KCC runtimes
**
**	(c) Copyright Ken Harrenstien 1989
**
** Note the strange calling conventions:
**    brk()  returns -1 on failure, 0 on success
**    sbrk() returns -1 on failure, the old break on success
** luckily -1 is not a valid PDP-10 byte pointer.
**
*/

#include <c-env.h>

#if SYS_T20+SYS_10X+SYS_WTS+SYS_T10+SYS_CSI+SYS_ITS

#include <sys/types.h>		/* For caddr_t, normally "char *" */
				/* also for size_t */
#include <errno.h>		/* For sbrk() to return ENOMEM */
#include <sys/usydat.h>

/* These two externals are initialized by the CRT runtime startup */
extern caddr_t _end;		/* Where allocated data can start */
extern caddr_t _ealloc;		/* First location allocated data cannot use */

/*
** caddr_t brk(addr)
** caddr_t addr;
**
** Sets the current idea of the break to the given byte pointer
** (which is not checked particularly closely, so don't feed it garbage).
** Since it may point to some byte location within a word, we simply
** round up to include the word that the word-address points to.
*/

static int `hipage` = -1;	/* Highest current page (or section) */

caddr_t
brk(addr)
caddr_t addr;
{
    if (0) `hipage` = -1;	/* Avoid KCC warning of unreffed var */
    USYS_BEG();			/* Start USYS code */
#asm
	EXTERN $$BP90		/* From CPU module */
	EXTERN .EALLO	/* Must declare since _ealloc only seen in asm here */

#if SYS_T20
	JUMPGE 17,.BRK0		/* Jump if using extended addressing */
#endif
	/* Zero-section addressing; arg is a local format 9-bit char pointer.
	** Note that the CAM tests work because the P+S field of the pointers
	** should always be $$BP90, which is positive for local-format BPs.
	*/
	MOVE 6,-1(17)		/* Get the char ptr arg */
	CAMGE 6,[$$BP90,,]	/* Ensure it's word-aligned */
	 ADDI 6,1		/* If not, bump up the word addr */
	TLCE 6,1100		/* Sanity check - Ensure byte size 9 */
	 TLNE 6,7777		/* Sanity check - ensure no I or (X) bits */
	  JRST RETN		/* Fail, bad pointer format */
	HRLI 6,$$BP90		/* Force pointer word-aligned. */
	CAML 6,.END		/* Error if less than lowest possible */
	 CAMLE 6,.EALLO		/* Or if greater than max possible */
	  JRST RETN		/* Fail, ignore request. */

	/*
	** TENEX and TOPS20 assume the first reference will create
	** whatever new pages are necessary, but ITS must explicitly
	** create the pages; unexpected references are assumed to be
	** errors.  TOPS10 and WAITS also require explicit allocation.
	*/

#if SYS_ITS

PG$BTS==12				/* log 2 of ITS page size */
PG$SIZ==2000				/* number of words in ITS page */
PG$MSK==<PG$SIZ-1>			/* mask for address within page */

#if 0 /* This is what we should do: */
	MOVEI 1,-1(6)			/* Subtract 1 from address */
#else /* Instead we do this: */
	MOVEI 1,3(6)		/* 4 words of slop to mask malloc bugs... */
#endif
	LSH 1,-PG$BTS			/* To get highest page # needed */
	SKIPG 2,HIPAGE			/* Get previously set break */
	 JRST [	HRRZ 2,.END		/* Initialize if necessary */
		SUBI 2,1
		LSH 2,-PG$BTS
		MOVEM 2,HIPAGE
		JRST .+1]
	CAMG 1,2			/* Need more pages? */
	 JRST RETZ			/* Nope, already have enough. */
	MOVE 3,1			/* Save new highest page # */
	SUB 1,2				/* Find # of pages we need to gobble */
	IMUL 1,[-1,,0]			/* Get (- # pages) in left half */
	HRRI 1,1(2)			/* And 1st new page in rt for AOBJN */
	.CALL [	SETZ
		SIXBIT /CORBLK/
		MOVEI %CBNDR+%CBNDW
		MOVEI %JSELF
		1
		SETZI %JSNEW]		/* Ask ITS for the memory */
	 JRST RETN			/* Shouldn't fail but lose nicely */
	MOVEM 3,HIPAGE			/* Won, set new high-page value */
#endif /* ITS */

#if SYS_T10+SYS_CSI+SYS_WTS
.JBREL==44			/* Highest core usage for oneseg or loseg */
.JBFF==121			/* 1st free loc for monitor I/O buffers */

#if 0 /* This is what we should do: */
	MOVEI 1,-1(6)		/* Get word address (last used) */
#else /* Instead we do this: */
	MOVEI 1,3(6)		/* 4 words of slop to mask malloc bugs... */
#endif
	CAMG 1,.JBREL		/* Compare with current highest avail */
	 JRST BRK10		/* Don't need new core, we're OK */
	CORE 1,			/* ask for more core */
	 JRST RETN		/* no space, tough */
BRK10:	HRRZM 6,.JBFF		/* Update 1st free (just in case) */
#endif /* T10+CSI+WAITS */

#if SYS_T20+SYS_10X			/* Assume using create-on-ref */
#endif
	JRST RETZ			/* Return 0 for success */

/*
** brk() for TOPS-20 extended addressing.
** This needs to be made more efficient someday.
*/

#if SYS_T20
	SEARCH MONSYM		/* Get syms for SMAP% */

.BRK0:	SKIPL 6,-1(17)		/* Get ptr to desired new break */
	 JRST RETN		/* Should always be negative (OWGBP) */
	CAMGE 6,[$$BP90,,]	/* Ensure it's word-aligned */
	 ADDI 6,1		/* Not aligned, so bump word address */
	TLZ 6,770000		/* Then force BP to word alignment. */
	TLO 6,$$BP90
	CAML 6,.END		/* Error if less than lowest possible */
	 CAMLE 6,.EALLO		/* Or if greater than max possible */
	  JRST RETN		/* Fail, ignore request. */

	HLRZ	5,6		;Get new break swapped
	TRZ	5,770000	;Isolate section number
	SKIPG	4,HIPAGE	;Get current next section
	 JRST [	HLRZ 4,.END	/* Must initialize */
		TRZ 4,770000	/* Flush out byte-ptr bits */
		MOVEM 4,HIPAGE
		JRST .+1]
	MOVE 6,5		/* Save new section num */
	CAMLE	5,4		;Is new less than or same as old?
	 JRST	.brk1		;No, check more
	CAMN	5,4		;Is new less than old
	 JRST	RETZ		;Still within same section
	SETO	1,		;Delete sections
	HRRZ	2,5		;Get new (lower) section
	ADDI	2,1		;Add one as starting section to return
	SUB	4,5		;Get number to return
	MOVE	3,4		;Put it where SMAP% can get it
	JRST	.brk01		;Join common code

.brk1:	SETZ	1,		;Create new sections
	HRRZ	2,4		;Get current section
	ADDI	2,1		;Point to next available
	SUB	5,4		;Get number of sections to make
	MOVE	3,5		;In AC3
.brk01:	HRLI	2,.FHSLF	;For me, of course
	SMAP%			;Make them or remove them
	 ERJMP	RETN		;Probably ran out
	MOVEM	6,HIPAGE	;Save new section limit
	JRST	RETZ		;Return success

#endif /* T20 */

RETZ:	TDZA 1,1
RETN:	 SETO 1,
	MOVEM 1,-1(17)		/* Store in variable that C knows about */
#endasm
    USYS_RET(addr);		/* Return value stored in "addr" */

}	/* End of brk() */

/*
** sbrk()
**
**	This code calls brk() every time.  For the PDP-10 implementation
** this is fine, since the brk() code above is clever about only grabbing
** more memory when it has to.  But for another system where brk() is a
** real system call, sbrk() will need to be changed to know about the
** system's page size.
*/

caddr_t
sbrk(nbytes)
size_t nbytes;
{
    static caddr_t curbrk = 0;		/* Current break */
    static size_t curleft;		/* # bytes left */
    caddr_t obrk;

    USYS_BEG();
    if (curbrk == 0) {			/* First time? */
	curbrk = _end;
	curleft = _ealloc - _end;
    }
    if (nbytes == 0)			/* Special check for simple case */
	USYS_RET(curbrk);

    if ((nbytes > curleft)		/* Asking for too many bytes? */
	|| brk(curbrk + nbytes)) {	/* Or brk() call failed? */
	errno = ENOMEM;			/* then return failure. */
	USYS_RET((caddr_t)-1);
    }
    curleft -= nbytes;			/* Won, adjust things. */
    obrk = curbrk;
    curbrk += nbytes;
    USYS_RET(obrk);			/* Return old break */
}

#endif /*T20+10X+WAITS+T10+CSI+ITS */
