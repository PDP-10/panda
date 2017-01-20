/*
 *	SYSCAL - ITS system call interface
 */
#include <c-env.h>

#if SYS_ITS	/* Only compile _scall and _scalz on ITS. */

/* _SCALL - Do ITS system call.
** Should never be called directly.  The SYSCALLn macros are the only things 
** that should invoke the _scall routine.
**	_scall(blocklen,lastwd,....,1stwd)
*/

int _scall()
{
#asm
	MOVEI 5,-1(17)		/* Point to 1st arg (block length) */
	SUB 5,(5)		/* Now point to 1st word of block */
	.CALL (5)		/* Do it!  Leaves error value in 1 */
	 CAIE 1,		/* Failure return, ensure non-zero error */
	  POPJ 17,		/* Success return will have zero in 1 */
	MOVEI 1,%EBDRG		/* Zero error code shouldnt happen, but if */
				/* so, claim "meaningless args". */
#endasm
}

/* _scalz - Do ITS system call, anticipating no errors.
 * Similar to _scall.  Invoked by the SYSCALLn_LOSE macros.
 * It seems better to use this in situations where the only possible
 * errors are in the logic of the program.  It should not be used if
 * there is the slightest possibility that someone could make use of an error
 * return.  Use your judgement.
 */
void _scalz()
{
#asm
	MOVEI 5,-1(17)		/* Point to 1st arg (block length) */
	SUB 5,(5)		/* Now point to 1st word of block */
	.CALL (5)		/* Do it!  Leaves error value in 1 */
	 .LOSE %LSSYS		/* Crap out to superior */
#endasm
}

/* ato6("str") - Return 1 word of SIXBIT, left justified.
**	Useful with system calls in general, but for system 
**	call names use SC_LOGOUT instead of ato6("logout").
*/
int ato6(str)
    char *str;
{
#asm
	MOVE 2,-1(17)		/* Get BP to asciz string */
	MOVE 3,[440600,,1]
	SETZ 1,
	LDB 4,2			/* Get ASCII char */
	JUMPE 4,ATO69
ATO65:	CAIL 4,140
	 SUBI 4,40		/* Make lowercase if necessary */
	SUBI 4,40		/* Make sixbit */
	IDPB 4,3		/* Deposit in 1 */
	TLNN 3,770000		/* Stop if word now full. */
	 POPJ 17,
	ILDB 4,2		/* Get next char */
	JUMPN 4,ATO65
ATO69:
#endasm
}

/* afrom6(num, &buf) - Convert SIXBIT to ascii string.
 *	This is here for completeness.
 */
void afrom6(six, str)
    int six;
    char *str;
{
#asm
	move 5,-2(17)		/* 5: the b.p. */
	skipn 4,-1(17)		/* 4: the sixbit */
	 jrst afrm69
	setz 3,
	lshc 3,6
	addi 3,40
	dpb 3,5
	jumpe 4,afrm69
afrm61:	setzi 3,
	lshc 3,6
	addi 3,40
	idpb 3,5
	jumpn 4,afrm61
afrm69:	idpb 4,5		/* final NUL */
#endasm
}
#endif /* ITS */
