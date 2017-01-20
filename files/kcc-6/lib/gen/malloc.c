/*
 *	MALLOC - memory allocation for C programs (first fit)
 *
**	(c) Copyright Ken Harrenstien 1989
**		for all changes after v.195, 1-Sep-1988
 *	Copyright (C) 1986 by Ian Macky, SRI International
 *	Magic checkwords addition/misc fixes by Nelson Beebe
 */

#include <c-env.h>
#include <sys/c-debug.h>
#include <stddef.h>	/* for size_t */
#include <stdio.h>
#include <stdlib.h>

#include <sys/types.h>		/* For caddr_t */

#if __STDC__
#define VCHAR void
#else
#define VCHAR char
#endif

#ifndef MALLOC_CHECK
#define MALLOC_CHECK	1		/* runtime check for block validity? */
#endif

/* Block in use, pointed to by a (char *) pointer:
 *
 *			+-----------------------------------------------+
 *		flag	|		      IN_USE			|
 *			+-----------------------------------------------+
 *		size	|	     Total size of block (in words)	|
 *			+-----------------------------------------------+
 *		above	| (header_ptr) to block above in memory if free |
 *			+-----------------------------------------------+
 * (char *) ptr --->	|			 .			|
 *			.			 .			.
 *			.		     Data words			.
 *			.			 .			.
 *			|			 .			|
 *			+-----------------------------------------------+
 *			|		 MAGIC_CHECKWORD		|
 *			+-----------------------------------------------+
 *
 *	When a block is freed, if the next sequential block in memory is
 *	IN_USE, it's "above" pointer is set to point up to that free block.
 *	The contents of the following word are always checked against
 *	MAGIC_CHECKWORD to trap block overwrites.
 *
 * Block on freelist:
 *
 *			+-----------------------------------------------+
 *		flag	|			FREE			|
 *			+-----------------------------------------------+
 *		size	|		 Total size of block		|
 *			+-----------------------------------------------+
 *		next	|     (header_ptr) to next block on freelist    |
 *			+-----------------------------------------------+
 *		previous|   (header_ptr) to previous block on freelist  |
 *			+-----------------------------------------------+
 *			|			 .			|
 *			.			 .			.
 *			.		   Data words - 1		.
 *			.			 .			.
 *			|			 .			|
 *			+-----------------------------------------------+
 *			|	      MAGIC_CHECKWORD (unused)		|
 *			+-----------------------------------------------+
 *
 *	The variable free_head points to the head of the linked-list of free
 *	blocks.  When the freelist is empty, free_head contains NULL.
 *
 *	top_block is the address of the very first block in memory, or NULL
 *	if none have been allocated yet.
**
** NOTE: on CSI none of this may apply, as we use their MEM.MAC module.
** If the variable "_csimemuse" is set, then allocation is turned over
** to a set of CSI routines that do their own thing.
*/


#if 0
typedef double	largest_t;		/* this type requires max storage */
#else
/*
 * No need on word-addressable architecture to round up to double-word
 * boundry.  Also, word-alignment will force MAGIC_CHECKWORD into word
 * following last word requested by user, so we are more likely to trap
 * errors at free() time.
 */
typedef int	largest_t;		/* this type requires max storage */
#endif

/*
 *	make sure the block header is a multiple of CHUNKSIZE bytes long,
 *	so the data area remains on a boundry suitable for any type
 */

#define WORDSIZE	(sizeof(int))
#define CHUNKSIZE	(sizeof(largest_t))
#define CHUNKWORDS	(CHUNKSIZE/WORDSIZE)
#define ROUND_D(n, m)	((((n) - 1) / (m)) + 1)
#define ROUND_N(n, m)	(ROUND_D((n), (m)) * (m))
#define WORDS(n)	(ROUND_N((n), CHUNKSIZE)/WORDSIZE)

typedef struct header {
  int flag;				/* FREE or IN_USE, for verification */
  int size;				/* size in bytes of data area */
  union {
    struct header *next;		/* pointer to next block on f.l. */
    struct header *above;		/* pointer to above block in memory */
  } u;
} header_block, *header_ptr;

/*
 * Overhead accounts for the block headers, but NOT for the MAGIC_CHECKWORD
 * block trailer.
 */
#define OVERHEAD WORDS(sizeof(header_block))

/*
 * Retrieve flag from block
 */
#define FLAG(block) ((block)->flag)

/*
 * Retrieve size in words from block
 */
#define SIZE(block) ((block)->size)

/*
 * Retrive size in bytes from block
 */
#define CSIZE(block) ((block)->size * WORDSIZE)

/*
 * Retrieve next pointer from FREE block
 */
#define NEXT(block) ((block)->u.next)

/*
 * Retrieve previous pointer from FREE block
 */
#define PREVIOUS(block) *(header_ptr *)((block) + 1)

/*
 * Retrieve above pointer from IN_USE block
 */
#define ABOVE(block) ((block)->u.above)

/*
 * Find the block below a given block (larger address)
 */
#define BELOW(block) (((block) == last_block) ? NULL \
		      : (header_ptr)((int *)(block) + SIZE(block)))

/*
 *	these bit-patterns are pretty unlikely to stumble on by accident
 */

#define FREE		(-'!' - 'F' - 'r' - 'e' - 'e' - '!')
#define IN_USE		(-'I' - 'n' - ' ' - 'u' - 's' - 'e')

/*
 * Overtail accounts for space taken by tail data
 */
#define OVERTAIL WORDS(sizeof(int))

/*
 * We want MAGIC_CHECKWORD to have some bits on in all 4 9-bit bytes,
 * and also to not look like normal character data, so each byte has
 * the high-order bit on.
 */
#define MAGIC_CHECKWORD	0476567675765
#define MAGIC_WORD(block) *(int *)(((int*)(block)) + \
	(SIZE(block) - OVERTAIL))

static header_ptr top_block = NULL;	/* pointer to very 1st block in mem */
static header_ptr free_head = NULL;	/* Freelist pointer */
static header_ptr last_block = NULL;	/* pointer to first byte of brk */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

extern caddr_t sbrk P_((size_t nbytes));

static void use_block P_((header_ptr block, int flag));
static void split P_((header_ptr block,int newsize));
static void icopy P_((int *from,int *to,int count));
static void izero P_((int *to,int count));

#undef P_

#if SYS_CSI
#define SS_NORMAL 0		/* Value of R$%NOR */
#define RTS_GET_MEM(nwds,baddr)	  `R$GMEM`(baddr,nwds)
#define RTS_GET_MEM_Z(nwds,baddr) `R$GMZ`(baddr,nwds)
#define RTS_FREE_MEM(base)	  `R$FMEM`(base)
#define RTS_TRIM_MEM(nwds,base)	  `R$TMEM`(base,nwds)

extern int _csimemuse = 0;	/* Set non-zero to use CSI-specific stuff */
extern int RTS_GET_MEM(int nwds, int **baseaddr);	/* Get mem block */
extern int RTS_GET_MEM_Z(int nwds, int **baseaddr);	/* Get clred mem blk */
extern int RTS_FREE_MEM(int *base);			/* Free mem block */
extern int RTS_TRIM_MEM(int nwds, int *base);		/* Truncate mem blk */

#endif

#ifndef _KCC_DEBUG
#define MRETURN(adr,size) return(adr)
#else
#define MRETURN(adr,size)\
 return ((`$DEBUG` & _KCC_DEBUG_MALLOC) ? mreturn(adr,size) : adr)
static char *mreturn(char *adr, unsigned long size)
{
  _dbgl("MALLOC&malloc(");
  _dbgo(size);
  _dbgs(") => ");
  if (size) _dbgo((unsigned long)adr);
  else _dbgs("Failed");
  _dbgs(")\r\n");
  return adr;
}
#endif

/*
 *	malloc - allocate a block of memory big enough to accomodate
 *	"size" bytes.  a char pointer is returned to the data area,
 *	which is NOT initialized.  the requested size is rounded up
 *	to a multiple of CHUNKSIZE bytes, to keep blocks on boundry
 *	of largest data-type.
 *
 *	mlalloc is the same as malloc, except its arg is a long instead
 *	of just an int - one just calls the other.  who's on first
 *	depends on whether longs are equivalent to ints or not.
 *
 *	valloc is an obsolete version of malloc which would page align
 *	the allocated storage. Just have it call malloc.
 */

char *
mlalloc(size)
unsigned long size;
{
    return malloc((size_t) size);
}

VCHAR *
valloc(size)
size_t size;
{
    return malloc(size);
}

VCHAR *
malloc(size)
size_t size;
{
    header_ptr block;
    caddr_t area;
    int wbrk, need = size;		/* Get into convenient type */

    if (need < 0)			/* range check argument */
	MRETURN(NULL, size);
    if (need == 0) need = 1;		/* change 0 to 1 */

#if SYS_CSI
    if (_csimemuse) {
	int *addr;
	if (RTS_GET_MEM(ROUND_D(need, WORDSIZE), &addr) == SS_NORMAL)
	    MRETURN((char *)addr, size); /* Won, return ptr */
	MRETURN(NULL, size));	/* Failed */
    }
#endif

    need = WORDS(need) + OVERHEAD + OVERTAIL;
					/* total size w/overhead */
/*
 *	look through the freelist for a fit
 */
    for (block = free_head; block != NULL; block = NEXT(block)) {
#if MALLOC_CHECK
	if (FLAG(block) != FREE) {
	    _dbgl("MALLOC&malloc(");
	    _dbgo(size);
	    _dbgs(") Error: block is not free (flag ");
	    if (FLAG(block) == IN_USE) _dbgs("== IN_USE");
	    else _dbgs("clobbered");
	    _dbgs(") on freelist at ");
	    _dbgo((unsigned long)block);
	    _dbgs("\r\n");
	    abort();
	}
#endif
	if (SIZE(block) >= need) {	/* is this block big enough for us? */
	    use_block(block, IN_USE);	/* Place block IN_USE */
	    MAGIC_WORD(block) = MAGIC_CHECKWORD;
	    split(block, need);		/* return what we don't need */
	    MRETURN(((char *)(block + 1)), size); /* return ptr to data area */
	}
    }
/*
 *	didn't find a block big enough so allocate new space.
 */
    if (!top_block) {			/* Initialize if not done yet */
	area = sbrk(0);			/* get current brk */
	wbrk = (int)(int *)(area + (WORDSIZE - 1));
					/* Force over word boundary */
	if (CHUNKWORDS - 1) {
	  wbrk = wbrk + (CHUNKWORDS - 1); /* Force over CHUNK boundary */
	  wbrk = ~(CHUNKWORDS - 1);	/* Truncate to CHUNK boundary */
	}
	if ((int)sbrk(((caddr_t)(int *)wbrk) - area) == -1)
					/* move break to CHUNK boundary */
	    MRETURN(NULL, size);	/* or return on failure */
	top_block = (header_ptr)sbrk(0); /* And save the starting break */
    }
    else if (FLAG(last_block) == FREE) { /* If last block free, expand */
	if (sbrk((need - SIZE(last_block)) * WORDSIZE) == -1)
					/* Move brk to make block big enough */
	    MRETURN(NULL, size);	/* or return on failure */
	SIZE(last_block) = need;	/* And set new size */
	use_block(last_block, IN_USE);	/* Place block IN_USE */
	MAGIC_WORD(last_block) = MAGIC_CHECKWORD;
	MRETURN(((char *)(last_block + 1)), size); /* Return ptr to data area */
    }

    area = sbrk(need * WORDSIZE);	/* allocate space */
    if ((int)area == -1)		/* get what we requested? */
	MRETURN(NULL, size);	/* nope, no more room at the inn */
    block = (header_ptr) area;		/* make pointer to used block */
    FLAG(block) = IN_USE;		/* and mark that it's being used */
    SIZE(block) = need;			/* set total size of block */
    MAGIC_WORD(block) = MAGIC_CHECKWORD;
    ABOVE(block) = (FLAG(last_block) == FREE) ? last_block : NULL;
					/* Set above */
    last_block = (header_ptr)area;	/* we are new last block */
    MRETURN((char *)(last_block + 1), size); /* return pointer to data area */
}

/*
 *	use_block - remove block from free list and put it IN_USE.
 */
static void use_block(block, flag)
header_ptr block;
int flag;
{
    header_ptr below;

    /* Delink from free list */
    if (!PREVIOUS(block)) free_head = NEXT(block);
    else NEXT(PREVIOUS(block)) = NEXT(block);
    if (NEXT(block))
      PREVIOUS(NEXT(block)) = PREVIOUS(block);
    FLAG(block) = flag;			/* Set new flag */
    ABOVE(block) = NULL;		/* Can't be free block above */
    if ((below = BELOW(block)) && FLAG(below) == IN_USE)
      ABOVE(below) = NULL;		/* Update above of below */
}

/*

 *	split - split a block into a chunk of given size and a remainder,
 *	which is freed.  a remainder block is not made unless it is of at
 *	least CHUNKSIZE data bytes, to keep from having too many small,
 *	not very useful, fragmented blocks.
 */

static void split(block, need)
header_ptr block;
int need;
{
    header_ptr residue;

    if (need > 0
	&& ((SIZE(block) - need) >= CHUNKWORDS + OVERHEAD + OVERTAIL)) {
        residue = (header_ptr) ((int *) block + need);
#if MALLOC_CHECK
	FLAG(residue) = IN_USE;
#endif
	SIZE(residue) = SIZE(block) - need;
	ABOVE(residue) = NULL;	/* prevent coalescing */
	SIZE(block) = need;
	MAGIC_WORD(block) = MAGIC_CHECKWORD;
	if (block == last_block)	/* Splitting last block in memory? */
	  last_block = residue;		/* Yes, update */
	free(residue + 1);		/* Make it free */
    }
}

/*
 *	calloc - allocate a block of memory big enough to accomodate
 *	elt_count elements each of size elt_size.  a pointer to the
 *	first region is returned, and the region itself is cleared
 *	to zeroes.  since m(l)alloc always returns a pointer to a
 *	region starting on a boundry which can accomodate ANY type,
 *	no more boundry twiddling need be done by this routine.
 */

char *
clalloc(elt_count, elt_size)
unsigned long elt_count, elt_size;
{
    return calloc((size_t) elt_count, (size_t) elt_size);
}

VCHAR *
calloc(elt_count, elt_size)
size_t elt_count, elt_size;
{
    int size = elt_count * elt_size;
    char *cp;

    if (size < 0)			/* range check argument */
	return NULL;
    if (size == 0) size = 1;		/* change 0 to 1 */
#if SYS_CSI
    if (_csimemuse) {
	int *addr;
	if (RTS_GET_MEM_Z(ROUND_D(size, WORDSIZE), &addr) == SS_NORMAL)
	    return (char *)addr;	/* Won, return char ptr */
	return NULL;			/* Failed */
    }
#endif
    cp = malloc((size_t)size);
    if (cp)
	izero((int *) cp, ROUND_D(size, WORDSIZE));
    return cp;
}

/*
 *	free - free a previously allocated block.
 */

void free(vp)
VCHAR *vp;
{
    header_ptr current = (header_ptr)vp; /* Normalize pointer */
    header_ptr below;

#ifdef _KCC_DEBUG
    if (`$DEBUG` & _KCC_DEBUG_MALLOC)
      {
	_dbgl("MALLOC&free(");
	_dbgo((unsigned long)vp);
	_dbgs(")\r\n");
      }
#endif

    if (current == NULL)		/* Allow no-op if given null arg */
	 return;			/* as per ANSI description. */

#if SYS_CSI
    if (_csimemuse) {
	(void) RTS_FREE_MEM((int *)current);
	return;
    }
#endif

    current -= 1;			/* make ptr to header */
#if MALLOC_CHECK
    if (FLAG(current) != IN_USE) {
	_dbgl("MALLOC&free(");
	_dbgo((unsigned long)vp);
	_dbgs(") Error: block not in use (flag ");
	if (FLAG(current) == FREE) _dbgs("== FREE");
	else _dbgs("clobbered");
	_dbgs(") at ");
	_dbgo((unsigned long)current);
	_dbgs("\r\n");
	abort();
    }
    if (MAGIC_WORD(current) != MAGIC_CHECKWORD) {
	_dbgl("MALLOC&free(");
	_dbgo((unsigned long)vp);
	_dbgs(") Error: block overwritten past end (MAGIC_WORD clobbered) at ");
	_dbgo((unsigned long)current);
	_dbgs("\r\n");
	abort();
    }
#endif

    /* Get pointer to block below if free */
    if ((below = BELOW(current)) && (FLAG(below) != FREE))
      below = NULL;

/*
 *	check to see if next and/or previous ("physical") blocks in memory
 *	are free also, so we can do merge.
 */
    if (ABOVE(current)) {		/* merge with block above */
	/* Just expand above to include current */
	SIZE(ABOVE(current)) += SIZE(current);
	if (below) {			/* and below? */
	    use_block(below, 0);	/* Remove below from free list */
	    SIZE(ABOVE(current)) += SIZE(below); /* And add to above */
	    if (below == last_block)
	      last_block = ABOVE(current); /* Update last block */
	}
	if (current == last_block)
	  last_block = ABOVE(current);	/* Update last block */
	current = ABOVE(current);	/* new current block */
    } else {
	FLAG(current) = FREE;		/* Flag this block as FREE */
	if (below) {			/* merge with below only? */
	    /* Yes, link current in in place of below */
	    
	    if (!(PREVIOUS(current) = PREVIOUS(below)))
		free_head = current;
	    else NEXT(PREVIOUS(below)) = current;
	    if (NEXT(current) = NEXT(below))
		PREVIOUS(NEXT(below)) = current;
	    SIZE(current) += SIZE(below);
	    FLAG(below) = 0;		/* Don't allow another free(below) */
	    if (below == last_block) last_block = current;
	} else {			/* no merge possible  */
	    /* Link current onto front of free list */
	    PREVIOUS(current) = NULL;
	    if (NEXT(current) = free_head)
		PREVIOUS(free_head) = current;
	    free_head = current;
	}
    }
    /* If not last block, update above of block below */
    if ((below = BELOW(current)) && (FLAG(below) == IN_USE))
      ABOVE(below) = current;
}

void cfree(cp)			/* cfree() and free() are interchangable */
VCHAR *cp;
{
    free(cp);
}

/*
 *	change the size of an existing block.  reducing the size pares
 *	a chunk of storage off the end and frees it; increasing the
 *	size gets you a new block with the old data copied over.
 *	Note behavior follows ANSI description when given a NULL pointer
 *	or a zero size:
 *		If ptr == NULL, acts like malloc.
 *		Else if size == 0, acts like free and returns NULL.
 */

char *
relalloc(ptr, size)
char *ptr;
unsigned long size;
{
    return realloc(ptr, (size_t) size);
}

VCHAR *
realloc(ptr, size)
VCHAR *ptr;
size_t size;
{
    char *data;
    header_ptr old, new = NULL, above, below;
    int need = size, increase;

    if (ptr == NULL)		/* Per ANSI description, if ptr NULL */
	return malloc(size);	/* then just act like malloc() */
    if (need <= 0) {		/* Also per ANSI description, if size 0 */
	free(ptr);		/* then free up the old block */
	return NULL;		/* and return NULL */
    }
#if SYS_CSI
    if (_csimemuse) {
	int osize, nsize = ROUND_N(need, WORDSIZE);
	int *newb, *base = (int *)ptr;

	osize = *(base-1);		/* Get preceding word */
	if (osize >= 0) {		/* Check to be sure it's in use */
	    _dbgl("MALLOC&realloc(");
	    _dbgo(ptr);
	    _dbgs(", ");
	    _dbgo(size);
	    _dbgs(") Error: osize < 0 at ");
	    _dbgo(base);
	    _dbgs("\r\n");
	    abort();
	}
	osize = ((unsigned)osize >> 18) & 0377777;
	if (nsize > osize) {
	    if (RTS_GET_MEM(nsize, &newb) != SS_NORMAL)
		return NULL;		/* Failed to get bigger block */
	    icopy(base, newb, osize);	/* Copy old words */
	    RTS_FREE_MEM(base);		/* Free the old block */
	    return (char *)newb;	/* Return ptr to new block */
	}
	if (nsize < osize)
	    RTS_TRIM_MEM(nsize, base);
	return ptr;			/* Trimmed or same size, same ptr */
    }
#endif

    old = (header_ptr)ptr - 1;			/* Get pointer to overhead */
#if MALLOC_CHECK
    if (FLAG(old) != IN_USE) {
	_dbgl("MALLOC&realloc(");
	_dbgo((unsigned long)ptr);
	_dbgs(", ");
	_dbgo(size);
	_dbgs(") Error: old block not in use (flag ");
	if (FLAG(old) == FREE) _dbgs("== FREE");
	else _dbgs("clobbered");
	_dbgs(") at ");
	_dbgo((unsigned long)old);
	_dbgs("\r\n");
	abort();
    }
#endif
    need = WORDS(need) + OVERHEAD + OVERTAIL;
    if (SIZE(old) >= need) {		/* does it fit? */
	if (SIZE(old) > need)		/* Yes, exactly? */
	    split(old, need);		/* No, free tail */
	return ptr;
    }

    /* bigger, so reallocate and copy */

    /* Get below if FREE */
    if ((below = BELOW(old)) && (FLAG(below) != FREE)) below = NULL;

    /* Get above (NULL if not FREE) */
    above = ABOVE(old);

    /* Get increase needed */
    increase = need - SIZE(old);

    if ((old == last_block)		/* Last block? */
	&& ((int)sbrk(increase * WORDSIZE) != -1)) {
					/* And can expand? */
	SIZE(old) = need;		/* Yes, set new size */
	new = old;			/* And set old as new */
    }
    else if (below) {			/* Followed by free block? */
	if ((SIZE(below) >= increase)
	    || ((below == last_block)
		&& ((int)sbrk((increase - SIZE(below)) * WORDSIZE) != -1))) {
	    /* Block below can handle increase */
	    if (SIZE(below) < increase)
		SIZE(below) = increase;	/* Account for sbrk() */
	    use_block(below, 0);	/* Take below off free list */
	    SIZE(old) += SIZE(below);	/* Include in old */
	    new = old;			/* Old is new */
	}
	else if (above && ((SIZE(above) + SIZE(below)) >= increase)) {
	    /* Blocks above and below can handle increase */
	    use_block(above, IN_USE);	/* Take above off free list */
	    SIZE(above) += SIZE(old);	/* Add old block size to above */
	    if (SIZE(above) < need) {	/* Was above big enough? */
		use_block(below, 0);	/* No, grab below also */
		SIZE(above) += SIZE(below); /* Add size of below */
	    }
	    new = above;		/* Above is new */
	}
	if (new && (below == last_block)) last_block = new;
					/* Update last block if changing */
    }
    else if (above && (SIZE(above) >= increase)) {
	/* Block above can handle increase */
	use_block(above, IN_USE);	/* Take above off free list */
	SIZE(above) += SIZE(old);	/* Add old block size to above */
	new = above;			/* And set above as new */
    }
    if (new) {
	MAGIC_WORD(new) = MAGIC_CHECKWORD; /* Set checkword */
	if (new != old) {		/* Did we change bottom? */
	    icopy((int *) ptr, (int *)(new + 1), SIZE(old) - OVERHEAD);
					/* Yes, move data down */
	    if (last_block == old) last_block = new;
					/* Update last block */
	}
	if (SIZE(new) > need) split(new, need); /* Return unused portion */
	return (char *)(new + 1);	/* And return pointer to data */
    }
    data = malloc(size);		/* allocate a bigger block */
    if (data) {
	icopy((int *) ptr, (int *) data, SIZE(old) - OVERHEAD);
	free(ptr);			/* now free the old block */
    }
    return data;			/* return updated char pointer */
}

/*
 *	primitives to zero and copy sequential ints
 *	These both assume they will never see a count <= 0, since
 *	malloc never deals with zero-length blocks.
 */

static void icopy(from, to, count)
int *from, *to, count;
{
#if !(CPU_PDP10)
    while (count-- > 0)
	*to++ = *from++;
#else
#asm
	JUMPG 17,xicopy
	MOVE 1,-2(17)		;to		NON-EXTENDED
	HRL 1,-1(17)		;from,,to
	MOVE 2,-3(17)		;count
	ADDI 2,(1)		;to+count
	BLT 1,-1(2)		;do it.
	POPJ 17,

xicopy:	MOVE 1,-3(17)		;count		EXTENDED
	MOVE 2,-1(17)		;from
	MOVE 3,-2(17)		;to
	EXTEND 1,[XBLT]		;do it.
	POPJ 17,
#endasm
#endif
}

static void izero(to, count)
int *to, count;
{
#if !(CPU_PDP10)
    while (count-- > 0)
	*to++ = 0;
#else
#asm
	JUMPG 17,xizero
	AOS 1,-1(17)		;to+1		NON-EXTENDED
	HRLI 1,-1(1)		;to,,to+1
	SETZM -1(1)		;zero 1st wd
	SOSG 2,-2(17)		;count-1
	 POPJ 17,		;only 1 word
	ADDI 2,(1)		;<count-1>+<to+1> = <to+count>
	BLT 1,-1(2)		;do it
	POPJ 17,

xizero:	MOVE 2,-1(17)		;to		EXTENDED
	SETZM (2)		;zero (to)
	MOVE 3,2		;to
	ADDI 3,1		;to+1
	SOSLE 1,-2(17)		;count-1
	 EXTEND 1,[XBLT]	;do it if something left.
#endasm
#endif
}

/*
 *	debugging stuff.  for manual debugging's sake.
 */

extern caddr_t _end;		/* Where allocated data can start */
extern caddr_t _ealloc;		/* First location allocated data cannot use */

void _free_list()
{
    header_ptr p;

    if (!free_head)
	_dbgs("    ---- freelist is empty ----\r\n");
    else {
	_dbgs("    ---- free-list ----\r\n");
	p = free_head;
	while (p) {
	    _dbgs("\t");
	    _dbgo((unsigned long)p);
	    _dbgs(": ");
	    _dbgo(SIZE(p));
	    if (p > last_block) _dbgs(" ****** past last_block");
	    _dbgs("\r\n");
	    p = NEXT(p);
	    if (p && ((p < top_block) || (p > last_block))) {
	      _dbgs("    *** Bad NEXT pointer = ");
	      _dbgo((unsigned long)p);
	      _dbgs("\r\n");
	      break;
	    }
	}
    }
}

void _memory_map()
{
    header_ptr p;
    int *z, *ebk = (int *)last_block;
    unsigned long sbk;

    z = (int *) top_block;
    _dbgs("    Top block  = ");
    _dbgo((unsigned long)z);
    _dbgs("\r\n    Free head  = ");
    _dbgo((unsigned long)free_head);
    _dbgs("\r\n    Last block = ");
    _dbgo((unsigned long)last_block);
    if ((last_block >= (header_ptr)_ealloc)
	|| (last_block < (header_ptr)_end)) {
      _dbgs(" ****** out of bounds");
      ebk = (int *)_ealloc;
    }
    _dbgs("\r\n    sbrk(0)    = ");
    _dbgo(sbk = (unsigned long)(int *)sbrk(0));
    _dbgs("\r\n");
    if (*z)
	_dbgs("    --- Memory map of malloc area ---\r\n");
    while (*z) {			/* if zero, assume EOM */
        _dbgs("\t");
	_dbgo((unsigned long)z);
	_dbgs(": ");
	p = (header_ptr)z;
	if ((p < top_block) || (p > last_block)) {
	  _dbgs("    *** Bad NEXT pointer = ");
	  _dbgo((unsigned long)p);
	  _dbgs("\r\n");
	  break;
	}
	switch (FLAG(p)) {
	    case IN_USE:
		_dbgs("IN_USE\tsize = ");
		_dbgo(SIZE(p));
		_dbgs("\tabove = ");
		_dbgo((unsigned long)ABOVE(p));
		_dbgs("\r\n");
		break;
	    case FREE:
		_dbgs("FREE\tsize = ");
		_dbgo(SIZE(p));
		_dbgs("\tprev  = ");
		_dbgo((unsigned long)PREVIOUS(p));
		_dbgs("\tnext  = ");
		_dbgo((unsigned long)NEXT(p));
		_dbgs("\r\n");
		break;
	    default:
		_dbgs("****** Bad header value, not FREE or IN_USE: ");
		_dbgo(FLAG(p));
		_dbgs("\r\n");
		return;
		break;
	}
	if (z >= ebk) break;
	z += SIZE(p);
    }
    sbk -= (unsigned long)(z + SIZE(p));
    if (sbk == 0) return;
    _dbgs("    ****** Number of words lost = ");
    _dbgo(sbk);
    _dbgs(" ******\r\n");
}

void _ermem(blk,msg)
header_ptr blk;
char *msg;
{
  _dbgl("MALLOC&_ermem Memory consistency check failure for block ");
  _dbgo((unsigned long)blk);
  _dbgs(":\r\n\t");
  _dbgs(msg);
  _dbgs("\r\n");
  abort();
}

/* Perform memory consistency checks */
/* These may be patched in as needed */
void _ckmem()
{
  header_ptr n, p = NULL;
  header_ptr sbk = (header_ptr)sbrk(0);
  
  if (!top_block) return;
  if (last_block) {
    if ((last_block < top_block) || (last_block >= sbk))
      _ermem(last_block, "'last_block' out of range");
    if ((FLAG(last_block) != FREE) && (FLAG(last_block) != IN_USE))
      _ermem(last_block, "Invalid 'last_block' pointer, not FREE or IN_USE");
    if (((unsigned long)last_block + SIZE(last_block)) != sbk)
      _ermem(last_block, "Invalid 'last_block' pointer, next block address is not break");
  }
  for (n = free_head; n; p = n, n = NEXT(n)) {
    if ((n < top_block) || (n > last_block)) _ermem(n, "Block out of range");
    if (PREVIOUS(n) != p) _ermem(n, "Invalid previous free block pointer");
    if (FLAG(n) != FREE) _ermem(n, "Block on free list is not FREE");
    if (BELOW(n) && ((BELOW(n) < top_block) || (BELOW(n)> last_block)))
      _ermem(n, "Bad BELOW pointer in block, out of range");
    if (BELOW(n) && (FLAG(BELOW(n)) != IN_USE))
      _ermem(n, "Block following FREE block is not IN_USE");
  }
  n = top_block;
  p = NULL;
  while (n) {
    if ((n < top_block) || (n > last_block)) _ermem(n, "Block out of range");
    switch (FLAG(n)) {
    case FREE:
      if (BELOW(n) && ((BELOW(n) < top_block) || (BELOW(n)> last_block)))
	_ermem(n, "Bad BELOW pointer in block, out of range");
      if (BELOW(n) && (FLAG(BELOW(n)) != IN_USE))
	_ermem(n, "Block following FREE block is not IN_USE");
      p = n;
      break;
    case IN_USE:
      if (ABOVE(n) && ((ABOVE(n) < top_block) || (ABOVE(n)> last_block)))
	_ermem(n, "Bad ABOVE pointer in block, out of range");
      if (ABOVE(n) && !p)
	_ermem(n, "Bad ABOVE pointer in block, preceeding block was not FREE");

      if (ABOVE(n) && (ABOVE(n) != p))
	_ermem(n, "Bad ABOVE pointer in block, does not point to preceeding block");
      p = NULL;
      break;
    default:
      _ermem(n, "Invalid FLAG value in block");
      break;
    }
    if (n == last_block) break;
    n = (header_ptr)(((int)n) + SIZE(n));
  }
}
