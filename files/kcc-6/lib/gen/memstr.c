/*
**	MEMSTR - KCC Byte String library routines.
**
**	(C) Copyright 1986 by Ken Harrenstien, SRI International
**
**	Contains ANSI functions MEMSET, MEMCPY, MEMCMP, MEMCHR.
**	Also S5/BSD function MEMCCPY.
**	Also BSD routines BZERO, BCOPY, BCMP, FFS.
**
** BSD functions:
**	BZERO(cp1, cnt)		- Zero byte string
**	BCOPY(from, to, cnt)	- Copy byte string
**	BCMP(cp1, cp2, cnt)	- Compare byte strings
**	FFS(i)			- Find First Set bit
**	char *cp1, *cp2, *from, *to;
**	int cnt;
**
**	These routines are written in assembler to take advantage
** of special machine instructions such as BLT which greatly speed up
** execution.
*/

#include <c-env.h>
#include <string.h>	/* Get our declarations! */

#if __STDC__
#define VCHAR void
#define CONST const
#else
#define VCHAR char
#define CONST
#endif

#if CPU_PDP10
static void
tablestuff()		/* Dummy to include extra assembler stuff */
{
    if (0) tablestuff();	/* Prevent KCC warning of unused function */
#asm

A=1	/* KCC functions return value in this AC */
B=2
C=3
D=C+1
E=D+1
T=E+1
TT=7
P=17

%brkev==17	/* Use 15. chars as breakeven point.  This length or less */
		/* uses default byte-by-byte loop; more than this invokes */
		/* hairy optimization code. */

/* Assumption is that all code in PDP-10 C will never use any char ptrs */
/* for other than 7, 8, or 9 bytes.  We further assume that while */
/* running non-extended, only local-format BPs will be seen, and when */
/* running extended (in non-zero section), only global one-word BPs */
/* will be seen.  There are a few places where the code checks on this */
/* (when convenient) but recovery from abuse cannot always be relied */
/* on.  Note that the KL string instructions such as MOVSLJ are not */
/* generally used, first because they do not exist on KA/KI processors, */
/* and second because they are not much faster than a regular byte */
/* loop! */

/* Global-format P&S table
**	<Local LH>,,<#bytes/wd><00><offset>	; <Global P&S>
*/
$$gbpt:	0		/* 44 - really a local-fmt ptr! */

	/* 6-bit bytes: size 06	 */
	440600,,060000	/* 45 */
	360600,,060000	/* 46 */
	300600,,060005	/* 47 */
	220600,,060004	/* 50 */
	140600,,060003	/* 51 */
	060600,,060002	/* 52 */
	000600,,060001	/* 53 */
	/* 8-bit bytes (size 10) */
	441000,,040000	/* 54 */
	341000,,040000	/* 55 */
	241000,,040003	/* 56 */
	141000,,040002	/* 57 */
	041000,,040001	/* 60 */
	/* 7-bit bytes (size 07) */
	440700,,050000	/* 61 */
	350700,,050000	/* 62 */
	260700,,050004	/* 63 */
	170700,,050003	/* 64 */
	100700,,050002	/* 65 */
	010700,,050001	/* 66 */
	/* 9-bit bytes (size 11) */
	441100,,040000	/* 67 */
	331100,,040000	/* 70 */
	221100,,040003	/* 71 */
	111100,,040002	/* 72 */
	001100,,040001	/* 73 */
	/* 18-bit bytes (size 22) */
	442200,,020000	/* 74 */
	222200,,020000	/* 75 */
	002200,,020001	/* 76 */

	000000,,0	/* 77	; Illegal */
#endasm		/* End of table and declaration stuff */
}
#endif /* CPU_PDP10 */

/*	BSD functions BZERO, BCOPY, BCMP
*/
void
bzero(array, n)
VCHAR *array;	/* Address of byte array */
size_t n;		/* number of bytes in array to zero */
{
    (void) memset(array, 0, n);
}

void
bcopy(from, to, n)
const VCHAR *from;
VCHAR *to;
size_t n;
{
    (void) memcpy(to, from, n);	/* Standard routine has args in other order! */
}

int
bcmp(array1, array2, n)
const VCHAR *array1, *array2;
size_t n;
{
    return memcmp(array1, array2, n);	/* Can do tail recursion here! */
}

/*************************  MEMSET  *******************************/

VCHAR *
memset(s, c, n)
VCHAR *s;
register int c;
register size_t n;
{
#if !(CPU_PDP10)
    if (n > 0) {
	register char *to = s;
	*to = c;
	do *++to = c;
	while (--n);
    }
    return s;
#else	/* CPU_PDP10 */
#asm
	skipg d,-3(p)	/* Get # of bytes */
	 jrst bzeret	/* Count negative or zero */
	skipn c,-1(p)	/* Get char pointer (byte ptr) */
	 jrst bzeret	/* Ignore if pointer zero. */
	skipe a,-2(p)	/* Get the char value to use */
	 jrst bzero1	/* If not zero, for now use simple byte loop, ugh. */
	caile d,%brkev	/* More bytes than breakeven point? */
	 jrst bzerhk	/* Yes, try to do special stuff! */

	/* Not enough bytes to make fancy hacking worthwhile. */
bzero1:	dpb a,c		/* Set first byte. */
	sojle d,bzeret	/* Then decrement count and fall into loop. */
	idpb a,c
	sojg d,.-1
bzeret:	move 1,-1(p)	/* Sigh, must return original pointer!  Barf. */
	popj p,

	/* Try to do fancy stuff. */
bzerhk:	jumpge p,bzerox		/* Jump if extended (pdl ptr positive) */

	/* Non-extended fancy stuff for zeroing. */
	/* Assume local-format byte pointer. */
	/* First zero bytes until at beg of word... */
bzer30:	dpb a,c
	sojle d,bzeret
bzero4:	idpb a,c
	tlne c,720000	/* Stop when P=0 (6, 9, 18 bits) or 4 (8) or 1 (7) */
	 sojg d,bzero4
	sojl d,bzeret

	/* (c)+1 now points to words to clear.  Must find how many */
	/* words, plus remaining # bytes, to clear.  Requires determining */
	/* byte size, ugh.  Assumes one of 6,7,8,9,18. */
	tlnn c,001000		/* 8 or 9? */
	 jrst [	tlnn c,000400	/* 7? */
		 jrst [	tlnn c,002000	/* 6 or 18? */
			jrst [	idivi d,6	/* 6 */
				jrst bzero5]
			lsh d,-1	/* 18 */
			lsh e,-<44-1>	/* Set up remainder */
			jrst bzero5]
		idivi d,5		/* 7 */
		jrst bzero5]
	lshc d,-2	/* Divide by 4	; 8 or 9 */
	lsh e,-<44-2>	/* Get remainder right-justified. */
bzero5:	setzm 1(c)	/* Clear 1st word */
	movsi b,1(c)	/* <from>,, */
	hrri b,2(c)	/*	,,<to> */
	addi c,(d)	/* Get addr of last word (BP points to end) */
	blt b,(c)	/* Zero the words */
	jumple e,bzeret	/* Take care of any remaining bytes. */
	idpb a,c
	sojg e,.-1
	jrst bzeret

	/* Running in non-zero section, so assume BP is global one-wd format. */
	/* d/ # bytes */
	/* c/ bp */
	/* a/ 0 */
bzerox:	ldb b,[360600,,c]	/* Get the 6-bit P&S field */
	skipg e,$$gbpt-44(b)	/* Get table entry for it */
	 jrst [	ibp c		/* Odd - ensure points to 1st byte. */
		jumpl c,.+1	/* If not still global fmt, was a 44 local! */
		jrst bzer30]	/* Try to hack it as local-fmt ptr. */
	andi e,77		/* Get # bytes of roundup needed. */
	jumple e,bzerx4(e)	/* If 0, skip rounding. */
	subi d,(e)		/* Subtract # of bytes we will clear here */
	dpb a,c
	sojle e,bzerx3
	idpb a,c
	sojg e,.-1

bzerx3:	ibp c		/* -1 adjust BP then treat like 0 */
bzerx4:			/* 0 BP is word-aligned. */
	/* C/ BP pointing to 1st byte in word */
	/* D/ # bytes left to clear */
	ldb e,[140600,,$$gbpt-44(b)]	/* Get # bytes per word */
	idivi d,(e)		/* Get # words to zap, remaining # bytes in e. */
	jumple d,[skiple d,e
		  jrst bzero1	/* If more bytes to zero, use byte loop. */
		jrst bzeret]
	move b,e		/* Save remainder */
	move e,c		/* Get "source" BP */
	tlz e,770000		/* Clear the P&S field */
	xmovei t,1(e)		/* Get "dest" addr (1 greater) */
	setzm (e)		/* Zap 1st word */
	sosle d
xblt==<020000,,0>
	 extend d,[xblt]	/* Do extended BLT */
	skipg d,b		/* Now check for remaining bytes */
	 jrst bzeret		/* None, all done. */
	dpb t,[003600,,c]	/* Put final dest addr +1 back in BP */
	jrst bzero1		/* More bytes to zero, use byte loop. */
#endasm
#endif	/* CPU_PDP10 */ /* End of MEMSET */
}

/*********************  MEMCPY  *****************************/

VCHAR *
memcpy(s1, s2, n)
VCHAR *s1;			/* To here */
register CONST VCHAR *s2;	/* From here */
register size_t n;		/* number of bytes to copy */
{
#if !(CPU_PDP10)
	register char * to = s1;
	if(n > 0) do { *to++ = *s2++; } while(--n);
	return s1;
#else	/* CPU_PDP10 */
#asm
	/* General AC usage: */
	/* a,b/ scratch */
	/* c/ # bytes */
	/* d/ # remainder */
	/* e/ Source BP	(from) */
	/* t/ Dest BP	(to) */
	skipg c,-3(p)	/* Get 3rd arg, # of bytes */
	 jrst bcpret	/* Nothing to copy, just return */
	caig c,%brkev	/* Ensure worthwhile to do hairy stuff. */
	 jrst bcpy40	/* Naw, just do trivially. */
	skipge e,-2(p)	/* Get 2nd arg, source BP */
	 jrst bcpy50	/* Sign bit set, assume global ptr. */
	skipg t,-1(p)	/* Assume local fmt, get 1st arg, dest BP */
	 jrst bcpy42	/* Not same fmt, for now default to trivial case. */

	/* Both BPs are local format; make final check for sameness */
bcpy10:	move a,e
	xor a,t			/* XOR the two byte pointers */
	tlne a,-1		/* Check for same LH */
	 jrst [	tlnn a,007700	/* Nope - check for same size... */
		 tlnn a,770000	/* Size same, check for alignment */
		  jrst bcpy42	/* Must use byte loop; size different, or */
				/*  using indexing/indirection (ugh!) */
		jrst bcpy60]	/* Same size, different alignment, go do hair. */


	/* Local-format BPs have same size and alignment, so hack */
	/* BLT word-move optimization! */
	caml e,[331100,,0]	/* Must be 331100, 341000, 350700, or 360600. */
	 jrst bcpy33		/* Points to beg of word! */
				/* This test flunks 18-bit start (222200) but */
				/* we'll put up with that. */

	/* Doesnt point to beg of word, must get things aligned. */
	ldb a,e
	dpb a,t
	jrst bcpy32
bcpy31:	ildb a,e
	idpb a,t
bcpy32:	tlne e,720000	/* Stop when P=0 (6,9,18) or 04 (8) or 01 (7). */
	 sojg c,bcpy31
	sojle c,bcpy90
	ibp e		/* Then point to beg of next wd. */
	ibp t

	/* (E) and (T) now point to word locs for moving (from, to). */
	/* Find # words, plus remaining # bytes, to move.  Requires determining */
	/* byte size, ugh.  Assumes one of 6,7,8,9,18. */
bcpy33:	tlnn t,001000		/* 8 or 9? */
	 jrst [	tlnn t,000400	/* 7? */
		 jrst [	tlnn t,002000	/* 6 or 18? */
			jrst [	idivi c,6	/* 6 */
				jrst bcpy34]
			lsh c,-1	/* 18 */
			lsh d,-<44-1>	/* Set up remainder */
			jrst bcpy34]
		idivi c,5		/* 7 */
		jrst bcpy34]

	lshc c,-2	/* Divide by 4	; 8 or 9 */
	lsh d,-<44-2>	/* Get remainder right-justified. */

	/* c/ # wds */
	/* d/ # bytes remainder */
bcpy34:	jumple c,bcpy35
	movsi b,(e)	/* <from>,, */
	hrri b,(t)	/*	,,<to> */
	addi t,(c)	/* Get addr of last word + 1 (BP points to end) */
	blt b,-1(t)	/* Copy the words */
bcpy35:	caig d,0	/* Take care of any remaining bytes */
	 jrst bcpret	/* Done. */
	addi e,(c)	/* Sigh, must also point to last source word. */
	move c,d
	jrst bcpy42	/* Go copy the remainder by hand (start with LDB) */

	/* Trivial case.  Strings which dont have same alignment or size */
	/* all come here. */
	/* Note that the KL extended instruction MOVSLJ is */
	/* slightly faster than this byte loop, but tis painful to */
	/* conditionalize this.  MOVSLJ is done for global BPs however */
	/* since then we know the instruction will exist. */
bcpy40:	skipe e,-2(p)		/* Source BP */
	 skipn t,-1(p)		/* Dest BP */
	  jrst bcpret		/* Null pointer arg, just return. */
	jumpl t,bcpy45		/* If using global-format BPs, use MOVSLJ. */
bcpy42:	ldb a,e			/* Get byte */
	dpb a,t			/* Store it */
	sojle c,bcpy90
bcpy43:	ildb a,e
	idpb a,t
	sojg c,bcpy43
bcpy90:
bcpret:	move 1,-1(p)		/* Sigh, must return s1 as result, bletch */
	popj p,

	/* Trivial case using MOVSLJ. */
	/* First need to get BPs into canonical shape. */
bcpy45:	ldb a,e		/* Get byte */
	dpb a,t		/* Store it */
	sojle c,bcpy90
	move a,c	/* AC+0: source string length */
	move b,e	/* AC+1,2: source byte ptr */
	move d,c	/* AC+3: dest string length */
	move e,t	/* AC+4,5: dest byte ptr */
MOVSLJ==:<016000,,0>	/* Subinstr of EXTEND */
	EXTEND A,[MOVSLJ]	/* DO IT! */
	 trn
	jrst bcpret
#endasm

#asm
/*;;;;;;;;;;;;;;;;;;;;;;   MEMCPY (cont)   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; */

	/* Global-format BP hacking.  Already have source BP in e. */
bcpy50:	skipl t,-1(p)	/* Get dest BP (to) */
	 jrst bcpy42	/* Not same format, handle as trivial slow case. */

	/* c/ # bytes */
	/* e/ Source BP */
	/* t/ Dest BP */
	ldb b,[360600,,e]	/* Get P&S field for source */
	ldb d,[360600,,t]	/* Ditto for dest */
	caie b,(d)
	 jrst [	move a,$$gbpt-44(b)	/* Different size or alignment.  Check. */
		xor a,$$gbpt-44(d)
		tlne a,007700		/* See if have same byte size */
		 jrst bcpy45		/* No, must hack like trivial case. */
		jrst bcpy56]		/* Same size, do word-move hair. */

	/* P&S field is identical, so BPs are word-aligned and we can do */
	/* fast BLT! */
	skipg d,$$gbpt-44(b)	/* Get table entry for it */
	 jrst [	ibp e		/* Hmm, ensure points to 1st byte. */
		ibp t
		jumpl e,bcpy55	/* Ensure still global-fmt ptrs... */
		jrst bcpy10]	/* Ugh, must have been local-fmt with P=44! */
	andi d,77		/* Get # bytes of roundup needed. */
	jumple d,bcpy55		/* If 0, skip rounding. */
	subi c,(d)		/* Subtract # of bytes we will copy here */
	ldb a,e
	dpb a,t
	sojle d,bcpy54
bcpy53:	ildb a,e
	idpb a,t
	sojg d,bcpy53
bcpy54:	ibp e
	ibp t
	ldb b,[360600,,t]	/* Get P&S field again */

       	/* BPs are now word-aligned (point to 1st byte in word). */
bcpy55:	ldb d,[140600,,$$gbpt-44(b)]	/* Get # bytes per word */
	idivi c,(d)		/* Get # words (remainder in d) */
	exch c,d
	jumple d,[jumpg c,bcpy42
		jrst bcpret]	/* Return */

	/* Set up to transfer at least 1 word. */
	tlz e,770000		/* Must flush P&S field from BPs */
	tlz t,770000
	EXTEND D,[XBLT]		/* Do it! */
	jumple c,bcpy90		/* If no remaining bytes, done. */
	rot b,-6		/* Must put P&S field back (alignment is OK) */
	ior e,b
	ior t,b
	jrst bcpy42		/* Then finish off with byte-loop copy. */

	/* Handle word-move hair for global-format BPs which have same */
	/* byte size but different alignment. */
bcpy56:	cail d,70		/* Only hack 9-bit bytes for now. */
	 caile d,73
	  jrst bcpy45

	/* Must get dest ptr to beg of word */
bcpy57:	tlnn t,070000		/* Check for value 70 */
	 jrst bcpy58
	ldb a,e
	dpb a,t
	ibp e
	ibp t
	sojg c,bcpy57
	jrst bcpret	/* Return */

bcpy58:	ldb tt,[360600,,e]	/* Save current source-BP P&S */
	tlz e,770000	/* Flush P&S so can do indexing */
	tlz t,770000
	lshc c,-2	/* Divide by 2 */
	lsh d,-<44-2>	/* Get remainder in D */
	move a,(e)	/* Get 1st source word */
	aoja e,@<.+1-70>(tt)	/* Dispatch on P of 70-73 */
	setz bcpx90	/* P=70=33, beg of word (shouldnt happen) */
	setz bcpx91	/* P=71=22, 3 bytes needed from source wd */
	setz bcpx92	/* P=72=11, 2 bytes needed from source wd */
	setz bcpx93	/* P=73=00, 1 byte needed from source wd */

bcpy59:	skipg c,d
	 jrst bcpret		/* Return */
	ior t,[700000,,0]	/* Set dest P=70=33, beg of word */
	rot tt,-6
	ior e,tt		/* Set source P to original val */
	soja e,bcpy42

bcpx90:	jrst bcpret		/* Return */

	/* Source P=71=22, 3 valid bytes in A */
bcpx91:	move b,(e)
	lshc a,<11*1>
	movem a,(t)
	lshc a,<11*<4-1>>
	addi e,1		/* Sigh... for extended addrs */
	addi t,1
	sojg c,bcpx91
	jrst bcpy59

	/* Source P=11, 2 valid bytes in A */
bcpx92:	move b,(e)
	lshc a,<11*2>
	movem a,(t)
	lshc a,<11*<4-2>>
	addi e,1
	addi t,1
	sojg c,bcpx92
	jrst bcpy59

	/* Source P=00, 1 valid byte in A */
bcpx93:	move b,(e)
	lshc a,<11*3>
	movem a,(t)
	lshc a,<11*<4-3>>
	addi e,1
	addi t,1
	sojg c,bcpx93
	jrst bcpy59
#endasm

#asm
/*;;;;;;;;;;;;;;;;;;;;;;   MEMCPY (cont)   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; */

/* Special hair to handle case of byte strings which are same size */
/* but do not have same alignment (so BLT cannot be done).  We can still */
/* save a considerable amount of time by using word moves and shifts, which */
/* are 3 to 5 times faster than the alternatives (timed on a 2060): */
/*		Hairy stuff: .7-.8 usec/char */
/*		ILDB/IDPB:  3.5    usec/char */
/*		MOVSLJ:     2.1    usec/char */

	/* C/ count */
	/* E/ source BP (local fmt) */
	/* T/ Dest BP (local fmt) */
	/* First order of business is getting dest ptr word-aligned. */
bcpy60:	caml t,[331100,,0]
	 jrst bcpy63	/* Already word-aligned (unless 18-bit bp 222200) */
	ldb a,e
	dpb a,t
	jrst bcpy62
bcpy61:	ildb a,e
	idpb a,t
bcpy62:	tlne t,720000	/* Stop when P=00 or 04 or 01. */
	 sojg c,bcpy61
	sojle c,bcpy90
	ibp e
	ibp t

	/* Dest is now word-aligned.  Further steps depend on byte size. */
bcpy63:	tlnn t,000100		/* 7 or 9 bits?  (07 or 11) */
	 jrst bcpy42		/* Nope, just punt for now. */
	tlnn t,001000		/* 9-bit bytes? */
	 jrst bcpy70		/* Nope, 7-bit, go do them. */

	/* Copy unaligned 9-bit bytes! */
	lshc c,-2		/* Divide by 4 */
	lsh d,-<44-2>		/* Get 2 bits of remainder right-justified. */
	ldb b,[360200,,e]	/* Get low 2 bits of P from source BP */
	move a,(e)		/* Get 1st source word set up. */
	aoja e,@.+1(b)		/* Dispatch on value of 0,1,2,3. */
	/* Note sign bit (SETZ) must be set to prevent extended-format */
	/* indirection when in non-zero section.  Barf. */
	setz bcpy66	/* 0 = P=00, 1 byte needed from source wd */
	setz bcpy65	/* 1 = P=11, 2 bytes needed from source wd */
	setz bcpy64	/* 2 = P=22, 3 bytes needed from source wd */
	setz bcpy34	/* 3 = P=33, 4 bytes?  Is word-aligned, shouldnt happen */
			/*	but just in case, go hack BLT. */

	/* Source P=22, 3 valid bytes in A */
bcpy64:	move b,(e)
	lshc a,<11*1>
	movem a,(t)
	lshc a,<11*<4-1>>
	addi e,1		/* Sigh... for extended addr possibility. */
	addi t,1
	sojg c,bcpy64
	skipg c,d
	 jrst bcpret		/* Return */
	soja e,bcpy42

	/* Source P=11, 2 valid bytes in A */
bcpy65:	move b,(e)
	lshc a,<11*2>
	movem a,(t)
	lshc a,<11*<4-2>>
	addi e,1
	addi t,1
	sojg c,bcpy65
	skipg c,d
	 jrst bcpret		/* Return */
	soja e,bcpy42

	/* Source P=00, 1 valid byte in A */
bcpy66:	move b,(e)
	lshc a,<11*3>
	movem a,(t)
	lshc a,<11*<4-3>>
	addi e,1
	addi t,1
	sojg c,bcpy66
	skipg c,d
	 jrst bcpret		/* Return */
	soja e,bcpy42

/* Copy non-aligned 7-bit bytes. */
bcpy70:	idivi c,5		/* Divide by 5, get rem in D */
	ldb b,[360200,,e]	/* Get low 2 bits of P from source BP */
	move a,(e)		/* Get 1st source word set up. */
	lsh a,-1
	aoja e,@.+1(b)		/* Dispatch on value of 0,1,2,3. */
	/* See note for previous table re SETZs. */
	setz bcpy76	/* 0 = P=10, 2 bytes needed from source wd */
	setz bcpy78	/* 1 = P=01, 1 bytes needed from source wd */
	setz bcpy72	/* 2 = P=26, 4 bytes needed from source wd */
	setz bcpy74	/* 3 = P=17, 3 bytes needed from source wd */

	/* Source P=26 (4 valid bytes in A) */
bcpy72:	move b,(e)
	lshc a,<7*1>
	lsh a,1
	movem a,(t)
	lshc a,<7*<5-1>>
	addi e,1
	addi t,1
	sojg c,bcpy72
	skipg c,d
	 jrst bcpret		/* Return */
	soja e,bcpy42

	/* Source P=17 (3 valid bytes in A) */
bcpy74:	move b,(e)
	lshc a,<7*2>
	lsh a,1
	movem a,(t)
	lshc a,<7*<5-2>>
	addi e,1
	addi t,1
	sojg c,bcpy74
	skipg c,d
	 jrst bcpret		/* Return */
	soja e,bcpy42

	/* Source P=10 (2 valid bytes in A) */
bcpy76:	move b,(e)
	lshc a,<7*3>
	lsh a,1
	movem a,(t)
	lshc a,<7*<5-3>>
	addi e,1
	addi t,1
	sojg c,bcpy76
	skipg c,d
	 jrst bcpret		/* Return */
	soja e,bcpy42

	/* Source P=01 (1 valid byte in A) */
bcpy78:	move b,(e)
	lshc a,<7*4>
	lsh a,1
	movem a,(t)
	lshc a,<7*<5-4>>
	addi e,1
	addi t,1
	sojg c,bcpy78
	skipg c,d
	 jrst bcpret		/* Return */
	soja e,bcpy42

/* Copy non-aligned 8-bit bytes. */
bcpy80:	jrst bcpy42		/* Also punt for now. */

#endasm
#endif	/* CPU_PDP10 */
}	/* End of MEMCPY */

/************************  MEMCMP  ******************************
**
**	This implements the ANSI memcmp() function.
**	Compares two byte strings.
*/

int
memcmp(s1, s2, n)
register CONST VCHAR *s1, *s2;
register size_t n;
{
#if !(CPU_PDP10)
	register int res;
	if(n > 0)
		do { if (res = (*s1++ - *s2++))
				return(res);
		  } while(--n);
	return(0);

#else	/* CPU_PDP10 */
#asm
	skipg e,-3(p)	/* Get 3rd arg, # of bytes */
	 jrst [	setz a,
		popj p,]
	move d,-2(p)	/* Get s2 */
	move c,-1(p)	/* Get s1 */
	ldb a,c		/* Get byte1 */
	ldb b,d		/* Get byte2 */
	came a,b
	 jrst bcmp9
	sojle e,bcmp9
bcmp5:	ildb a,c
	ildb b,d
	camn a,b
	 sojg e,bcmp5
bcmp9:	sub a,b		/* Return difference byte1-byte2. */
	popj p,
#endasm
#endif	/* CPU_PDP10 */
}	/* End of MEMCMP */

/************************  MEMCHR  ******************************
**
**	This implements the ANSI memchr() function.
**	Searches for the first occurrence of a byte in the
**	object pointed to by S.
*/

VCHAR *
memchr(s, c, n)
register CONST VCHAR *s;
int c;
register size_t n;
{
#if !(CPU_PDP10)
    register unsigned char ch = c;
    if(n > 0) {
	do { if (*s++ == ch) return s-1; }
	while (--n);
    }
    return NULL;

#else	/* CPU_PDP10 */
#asm
	skipe a,-1(p)	/* Get 1st arg, byte pointer */
	 skipg c,-3(p)	/* Get 3rd arg, # bytes. */
	  jrst memch9	/* If bad ptr or count, fail. */
	move b,-2(p)	/* Get 2nd arg, byte to look for. */
	ldb d,a		/* Get 1st byte */
	caia		/* Skip into loop */
memch5:	 ildb d,a
	cain d,(b)
	 popj p,	/* If match, just return current pointer! */
	sojg c,memch5
memch9:	setz a,		/* Failed, return NULL */
			/* Drop thru to return. */
#endasm
#endif	/* CPU_PDP10 */
}	/* End of MEMCHR */

/************************  MEMCCPY  ******************************
**
**	This implements the S5/BSD (but not ANSI!) memccpy() function.
**	Acts like memcpy() but also stops if it copies a byte of a
** specified value.
**	Returns NULL if counted out, otherwise returns pointer to first
** destination location past the final copied byte.
*/

VCHAR *
memccpy(dest, src, c, n)
register VCHAR *dest;
register CONST VCHAR *src;
register int c;
register size_t n;
{
#if !(CPU_PDP10)
    if(n > 0) {
	do { if ((*dest++ = *src++) == c) return dest; }
	while (--n);
    }
    return NULL;

#else	/* CPU_PDP10 */
#asm
	skipe a,-1(p)	/* Get 1st arg, dest byte pointer */
	 skipg c,-4(p)	/* Get 4th arg, # bytes. */
	  jrst memcc8	/* If bad ptr or count, fail. */
	move d,-2(p)	/* Get 2nd arg, source byte pointer */
	move b,-3(p)	/* Get 3rd arg, byte to look for. */

	ldb e,d		/* Get 1st byte */
	dpb e,a		/* Store it */
	jrst memcc6	/* Now can enter real loop. */

memcc5:	ildb e,d	/* Get next byte */
	idpb e,a	/* Store it */
memcc6:	cain e,(b)	/* Compare to see if done */
	 jrst memcc9	/* Yep, stop */
	sojg c,memcc5	/* Continue loop, drop thru if counted out. */

memcc8:	tdza a,a	/* Counted out or bad args, return NULL */
memcc9:	 ibp a		/* Hit byte value, return ptr to next dest location. */
	popj p,
#endasm
#endif	/* CPU_PDP10 */
}	/* End of MEMCCPY */

/************************  MEMMOVE  ******************************
**
**	This implements the ANSI memmove() function.
**	Acts like memcpy() but does overlapping moves properly.
** This has not yet been optimized for the PDP-10.  See comments
** at end of routine.
*/
#define GAPLEN 1024	/* Size of gap-handling buffer */

static char *
memmve(dest, src, n)
char *dest;
register CONST char *src;
register size_t n;
{
    register char *to;
    register int gap;
    char buff[GAPLEN];

    if (n <= 0) return dest;		/* Sanity check */
    if (((gap = dest - src) <= 0)	/* If dest <= src, */
      || (gap >= n))			/* or if gap big enuf, */
	return memcpy(dest, src, n);	/* OK to use plain copy! */

    /* Bah, source has its bottom part overlapped by dest.
    ** Must copy backwards, or do something cleverer.
    */
    if (n <= GAPLEN) {		/* String small enough for simple hack? */
	memcpy(buff, src, n);	/* Yep, copy whole thing into temp buffer */
	return memcpy(dest, buff, n);	/* Then from buffer to dest */
    }

    /* Could see whether or not to try copying "gap" bytes at a time,
    ** from bottom of source to bottom of dest, until all done.
    ** This would be very slow for small gaps, though.
    */

    /* Give up, do feeble-minded byte-by-byte backwards copying.
    */
    to = dest+n;		/* Point at last dest loc */
    src += n;			/* Ditto for source */
    do { *--to = *--src; } while (--n);
    return dest;

}	/* End of MEMMOVE */

VCHAR *
memmove(dest, src, n)
VCHAR *dest;
register CONST VCHAR *src;
register size_t n;
{
    return memmve(dest, src, n);	/* Avoid idiotic ANSI type clashes */
}

#if CPU_PDP10
/*
	Some things that could be done to optimize memmove for the PDP-10
would be:
	Check dest/src pointers to see if word-aligned.  If so, can
use a sequence like this:
	Non-extended addressing		Extended-addressing (KLs)
	MOVE A,src+n			MOVN A,n
	MOVE B,n			MOVE B,src+n
	POP A,gap(A)			MOVE C,dest+n
	SOJG B,.-1			EXTEND A,[XBLT]

The main trouble is all the checking needed to figure out if the pointers
are OK, and then setting things up.
*/
#endif /* CPU_PDP10 */

/**************************** FFS *****************************
 *
 *	Find First bit Set in int arg.  Returns 0 if arg is 0,
 *	else bit# of RIGHTmost bit set.  Rightmost bit in word
 *	is #1, leftmost on PDP-10 is #36
 */

int
ffs(i)
register int i;
{
    register unsigned mask;
    register int b;

    if (i)
	for (b = 1, mask = 1; mask; mask <<= 1, b++)
	    if ((unsigned)i & mask)
		return b;
    return 0;
}
    