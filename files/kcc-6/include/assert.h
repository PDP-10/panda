/* <ASSERT.H> - Diagnostic macro facility.
**
**	(c) Copyright Ken Harrenstien 1989
**
**	Implements the assert() macro as described by the
** ANSI C draft, plus an alternative for use when ANSI-style preprocessing
** isn't in effect.
**	Note stderr had better not be buffered!
*/

/* Because it's supposed to be possible to turn assertions on and off, we
** must permit re-inclusion of <assert.h> to do something different.
*/
#undef assert		/* Flush any previous definition */

#ifdef NDEBUG
#define assert(ignore) ((void)0)
#else

#ifndef __STDC__	/* Canonicalize this to avoid errs if pre-ANSI */
#define __STDC__ 0
#endif
#if __STDC__		/* ANSI C version */
extern void _assert(char*, char*, int);
#define assert(e) ((e) ? (void)0 : _assert(#e, __FILE__, __LINE__))
#else			/* Pre-ANSI version */
extern void _assert();
#define assert(e) ((e) ? (void)0 : _assert((char *)0, __FILE__, __LINE__))
#endif

#endif	/* ifndef NDEBUG */
