/* <SETJMP.H> - KCC definitions for setjmp() and longjmp() facilities.
**
**	(c) Copyright Ken Harrenstien 1989
**
**	Implements 4.3BSD notions.
** Note that jmp_buf must be an array type so that references to a
** jmp_buf object will be either an array (definition) or a pointer to
** an array (declaration).  Sigh!  --KLH
**	We use a sigcontext structure for jmp_buf even though we don't
** need all of the elements.  The reason for this is to make sure we have
** enough room for any future features, and to allow possible future use
** of the 4.3BSD sigreturn() system call.
**	sc_acs[2] is used to hold a simple checksum of the important parts.
*/

#ifndef _SETJMP_INCLUDED
#define _SETJMP_INCLUDED

#include <signal.h>		/* Get sigcontext definition */

typedef struct sigcontext jmp_buf[1];	/* Define jmp_buf */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

extern int setjmp P_((jmp_buf));	/* Declare setjmp functions */
extern void longjmp P_((jmp_buf, int));

#ifndef _ANSI_SOURCE
/*
 * WARNING: sigsetjmp() isn't supported yet, this is a placeholder.
 */
typedef struct sigcontext sigjmp_buf[1];
#pragma private define sigsetjmp sstjmp
#pragma private define siglongjmp slnjmp
int     sigsetjmp P_((sigjmp_buf, int));
void    siglongjmp P_((sigjmp_buf, int));
#endif /* not ANSI */

#if !defined(_ANSI_SOURCE) && !defined(_POSIX_SOURCE)
extern int _setjmp P_((jmp_buf));
extern void _longjmp P_((jmp_buf, int));
/* Reduce name to 6-char external */
#pragma private define longjmperror _ljerr
extern void longjmperror P_((void));/* Routine called if longjmp finds problems */
#endif /* neither ANSI nor POSIX */

#undef P_

#endif /* ifndef _SETJMP_INCLUDED */
