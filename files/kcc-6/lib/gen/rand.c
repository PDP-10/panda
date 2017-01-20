/*
 *	RAND.C - rand and srand functions for the math library
 *
 *	(c) Copyright Ken Harrenstien 1989
 *		for all changes after v.24, 3-Mar-1987
 *	(c) Copyright Ian Macky, SRI International 1985
 *
 */

#include <c-env.h>
#include <stdlib.h>
#include <errno.h>

static unsigned long rand_x = 1,		/* initialize seed */
  *statep = &rand_x;				/* state block pointer */

#if RAND_MAX == 32767

/* "New" stuff:
**	The following code simply implements the example of rand() given
**	in the dpANS (7-Dec-88 draft), so as to provide a "portable"
**	pseudo-random sequence.  There are better algorithms.  --KLH
*/

unsigned long _rand(unsigned long *statep)
{
  if (0) statep++;
#if 0 /* Code to be implemented without overflow */
    *statep = *statep * 1103515245 + 12345;
    return (*statep/((RAND_MAX+1)*2)) % (RAND_MAX+1);
#endif
#asm
	move	2,-1(17)	/*	statep				*/
	move	3,(2)		/*	*statep				*/
	mul	3,[dec 1103515245] /*	* 1103515245			*/
	dadd	3,[dec 0, 12345] /*	+ 12345				*/
	movem	4,(2)		/*	*statep =			*/
	lshc	4,-20		/*	/ ((RAND_MAX+1)*2)		*/
	move	1,3
	tlz	1,400000	/* Return result in range 0 -> 2**35-1	*/
#endasm
}

#else

/* Old stuff:
 *	This code conforms with the definition of rand and srand
 *	in Harbison & Steele's "C: A Reference Manual", section
 *	11.3.20 (rand) and 11.3.24 (srand).
 *
 *	Computes a string of random bits by
 *
 *		X = MOD((X0 * A + C), M)
 *
 *	where X0 is the old value.  In the NIL implementation of this,
 *	only the low order 20 bits are used.  In this implementation,
 *	in deference to the PDP-10's word-size, the low-order 18 bits
 *	of one result are used, plus the low order 17 bits of another,
 *	shifted in the high position.  The sign bit is guaranteed zero,
 *	e.g. the result is always positive.
 */


#define RAND_C			13		/* magic constants */
#define RAND_A			1156
#define RAND_M			46690875

unsigned long _rand(unsigned long *statep)
{
  if (0) statep++;
#if 0
	int temp;

	temp = *statep = ((*statep * RAND_A) + RAND_C) % RAND_M;
	*statep = ((*statep * RAND_A) + RAND_C) % RAND_M;

	return ((*statep & 0377777) << 18) | (temp & 0777777);
#endif
#asm
	move	2,-1(17)	/*	statep				*/
	move	3,(2)		/*	*statep				*/
	mul	3,[dec RAND_A]	/*	* RAND_A			*/
	dadd	3,[dec 0, RAND_C] /*	+ RAND_C			*/
	div	3,[dec RAND_M]	/* 	% RAND_M			*/
	hrrz	1,4		/*	temp & 0777777			*/
	move	3,4		/*	*statep				*/
	mul	3,[dec RAND_A]	/*	* RAND_A			*/
	dadd	3,[dec 0, RAND_C] /*	+ RAND_C			*/
	div	3,[dec RAND_M]	/* 	% RAND_M			*/
	movem	4,(2)		/*	*statep =			*/
	hrl	1,4		/*	(*statep & 0377777) << 18	*/
	tlz	1,400000	/* Return result in range 0 -> 2**35-1	*/
#endasm
}
#endif

void srand(seed)
unsigned seed;
{
    *statep = (unsigned long)seed;
}

int rand()
{
  return (_rand(statep) % (RAND_MAX + 1));
}

/* For BSD compatibility */

srandom(seed)
int seed;
{
    srand(seed);
    return 0;
}

long random()
{
    return _rand(statep) & 017777777777; /* Return in range 0 -> 2**31-1 */
}

char *setstate(state)
char *state;
{
  unsigned long *ostatep = statep;

  statep = (unsigned long *)state;

  return (char *)ostatep;
}

char *initstate(seed, state, n)
unsigned seed;
char *state;
int n;
{
  if (n < 8) {
    errno = EINVAL;
    return NULL;
  }

  *(unsigned long *)state = (unsigned long)seed;

  return setstate(state);
}
