/*
**	MUUO	- TOPS-10  Monitor call (UUO) support
**
**	(c) Copyright Ken Harrenstien 1989
**
*/

#include <muuo.h>
#include <stdlib.h>	/* abort */

#define RH 0777777

#if MU__DEFAC != 2
#error Default AC used by code doesn't match def in muuo.h!
#endif

/* MUUOXn - executes a monitor call (actually a PDP-10 instruction) of
**	a particular type.  The return value is 1 if the instruction skipped,
**	0 otherwise.
** MUUOX1(ins, ac)	move 2,ac ? ins 2,  ?    -
** MUUOX2(ins, ra)	   -	  ? ins 2,  ? movem 2,@ra 
** MUUOX3(ins, ac, ra)	move 2,ac ? ins 2,  ? movem 2,@ra
*/
int
muuox1(instr, ac)
int instr, ac;
{
    asm("MOVE 2,-2(17)\n");	/* Get arg val into default ac */
    asm("XCT -1(17)\n");	/* Execute the monitor UUO */
    asm("TDZA 1,1\n");
    asm(" MOVEI 1,1\n");
}

int
muuox2(instr, ra)
int instr, *ra;
{
    asm("XCT -1(17)\n");	/* Execute the monitor UUO */
    asm("TDZA 1,1\n");
    asm(" MOVEI 1,1\n");
    asm("SKIPE 3,-2(17)\n");	/* See if addr given for returning value */
    asm(" MOVEM 2,(3)\n");	/* Store return value in given addr, if any */
}

int
muuox3(instr, ac, ra)
int instr, ac, *ra;
{
    asm("MOVE 2,-2(17)\n");	/* Get arg val into default ac */
    asm("XCT -1(17)\n");	/* Execute the monitor UUO */
    asm("TDZA 1,1\n");
    asm(" MOVEI 1,1\n");
    asm("SKIPE 3,-3(17)\n");	/* See if addr given for returning value */
    asm(" MOVEM 2,(3)\n");	/* Store return value in given addr, if any */
}

/* _XCTSKIP(instr) - Interprets its arg as a PDP-10 instruction and
**	XCTs it.  Returns 0 or 1 depending on whether it skipped or not.
*/
int
_xctskip(instr)
int instr;
{
    asm("XCT -1(17)\n");
    asm("TDZA 1,1\n");
    asm(" MOVEI 1,1\n");
}

/* MUUO(op, ac, e) - General-purpose MUUO invocation.
**	Decodes the op value to determine how to interpret the next two args.
**				AC			E
**	I/O type UUOs:	val used as channel #	val used as RH of MUUO
**	TTCALL type:	ignored, must be 0	val used as RH of MUUO
**	CALLI type:	val used as AC arg 	addr to receive AC result
**	Other: illegal (CALL, INIT) or ignored (UJEN)
**
**	There are a few old CALLIs which interpret their AC field as a
** channel #.  These are checked for and handled properly.
*/
#define OP_CALL   (040 << 30)	/* These UUO opcodes are purged from UUOSYM */
#define OP_CALLI  (047 << 30)
#define OP_TTCALL (051 << 30)
#define OP_MTAPE  (072 << 30)

int
muuo(op, ac, e)
int op, ac, *e;
{
    /* Examine opcode to determine type */
    switch(op & MU__OP) {
    case uuosym("OPEN"):		/* Handle I/O type UUOs */
    case uuosym("RENAME"):
    case uuosym("IN"):
    case uuosym("OUT"):
    case uuosym("SETSTS"):
    case uuosym("STATO"):
    case uuosym("GETSTS"):
    case uuosym("STATZ"):
    case uuosym("INBUF"):
    case uuosym("OUTBUF"):
    case uuosym("INPUT"):
    case uuosym("OUTPUT"):
    case uuosym("CLOSE"):
    case uuosym("RELEAS"):
    case OP_MTAPE:
    case uuosym("UGETF"):
    case uuosym("USETI"):
    case uuosym("USETO"):
    case uuosym("LOOKUP"):
    case uuosym("ENTER"):
	if (ac < 0 || ac > 017		/* Check channel number val */
	  || ((int)e & ~MU__E))		/* Check address value */
	    abort();
	return _xctskip((op&MU__OP) | ((int)ac<<23) | (int)e);

    case OP_CALLI:			/* Standard call form */
	switch (op & RH) {
	case uuosym("WAIT")&RH:
	case uuosym("UTPCLR")&RH:
	case uuosym("SEEK")&RH:
	    if (ac < 0 || ac > 017)	/* Check channel number val */
		abort();
	    return _xctskip((op&(MU__OP|RH)) | (ac<<23));
	}
	return (e			/* Wants return value of AC? */
	    ? muuox3((op&~MU__AC) | (MU__DEFAC<<23), ac, e)	/* yes */
	    : muuox1((op&~MU__AC) | (MU__DEFAC<<23), ac)   );	/* no */

    case OP_TTCALL:			/* Extended operator */
	if (ac != 0 || ((int)e & ~MU__E))	/* Check AC & address value */
	    abort();
	return _xctskip((op & (MU__OP|MU__AC)) | (int)e);

    case uuosym("UJEN"):		/* Just do it, no arg, val, or addr */
	_xctskip(uuosym("UJEN"));
	break;

    case OP_CALL:			/* Obsolete */
    case uuosym("INIT"):		/* Cannot support in-line */
    default:
	abort();			/* Unknown opcode */
    }
}
