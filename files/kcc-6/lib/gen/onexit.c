/*
 *	ONEXIT - declare routines to be called upon exit()
 *
 *	Copyright (C) 1987 by Ian Macky, SRI International
 */

#include <stdlib.h>

int _n_exit_func = 0;				/* # of registered functions */
void (*_exit_func[MAX_EXIT_FUNCTIONS])();	/* pointers to those functs */

onexit_t onexit(func)
void (*func)();
{
    int i;

    if (_n_exit_func >= MAX_EXIT_FUNCTIONS)	/* do we have room for more? */
	return 0;				/* no, take failure return */
    for (i = 0; i < _n_exit_func; i++)		/* check to see if function */
	if (func == _exit_func[i])		/* is already registered.  */
	    return -1;				/* it is, so return success */
    _exit_func[_n_exit_func++] = func;		/* save this new one... */
    return -1;					/* and return success */
}
