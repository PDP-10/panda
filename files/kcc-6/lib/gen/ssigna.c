/*
 *	SSIGNAL - set a softsig handler
 *	GSIGNAL - raise software signal
 *
 *	Copyright (C) 1987 by Ian Macky, SRI International
 */

#include <c-env.h>
#include <errno.h>
#include <signal.h>

static int (*_uhandler[_SS_NSIGS])(
#ifdef __STDC__
				   int sig
#endif
				   );	/* handler or 0 if none for softsig */

int (*ssignal(softsig, func))(
#ifdef __STDC__
			      int sig
#endif
			      )
int softsig;
int (*func)(
#ifdef __STDC__
	    int sig
#endif
	    );
{
    int index, (*old_func)(
#ifdef __STDC__
			   int sig
#endif
			   );

    if ((index = softsig - _SS_FIRST) < 0 || index >= _SS_NSIGS) {
	errno = EINVAL;				/* softsig out of range */
	return (int (*)(
#ifdef __STDC__
			int sig
#endif
			)) SIG_ERR;
    }
    old_func = _uhandler[index];		/* save old handler */
    _uhandler[index] = func;			/* set the new one */
    return old_func;				/* return the old handler */
}

int gsignal(softsig)
int softsig;
{
    int index;

    if ((index = softsig - _SS_FIRST) < 0 || index >= _SS_NSIGS ||
	!_uhandler[index]) {
	errno = EINVAL;				/* softsig out of range */
	return (int) SIG_ERR;			/* or no handler */
    }
    return (*_uhandler[index])(softsig);	/* call the handler */
}					
