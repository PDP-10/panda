/*
**	ATEXIT.C - "atexit()" - register function for exit invocation
**
**	(c) Copyright Ken Harrenstien 1989
*/

#include <stdlib.h>

#define MAX_EXIT_FUNCTS 32		/* ANSI mandates at least this many */
int _n_exit_func = 0;			/* # of registered functions */
void (*_exit_func[MAX_EXIT_FUNCTS])();	/* Array of pointers to those functs */

int
atexit(func)
#if __STDC__
void (*func)(void);
#else
void (*func)();
#endif
{
    if (!func					/* Check arg */ 
      || _n_exit_func >= MAX_EXIT_FUNCTS)	/* and room left in array */
	return -1;				/* Ugh, fail */
    _exit_func[_n_exit_func++] = func;		/* Register function! */
    return 0;					/* Return success */
}
