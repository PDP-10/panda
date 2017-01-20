/* <STRING.H> and <STRINGS.H> - string routine declarations
**
**	(c) Copyright Ken Harrenstien 1989
**
** NOTE: the two files string.h and strings.h are identical copies.
** Draft Proposed ANSI C (and CARM) require <string.h>, but BSD uses
** <strings.h>.  To avoid problems with filename lengths longer than 6 chars,
** neither includes the other; they are simply identical, so it is OK if
** something asks for <strings.h> and gets <string.h> instead.
**
** Eventually, when BSD supports ANSI C, we can flush <strings.h>.
**
**	All of these functions are documented in
**	CARM II (H&S v2), chap 15 and 16.
*/

#ifndef _STRING_INCLUDED
#define _STRING_INCLUDED

#ifndef NULL
#define NULL 0
#endif

/* CARM functions, most also exist for ANSI and BSD */
extern	char *strcat();
extern	char *strchr();
extern	char *index();		/* V7/BSD name for strchr */
extern	int strcmp();
extern	char *strcpy();
extern	int strcspn();
extern	int strlen();
extern	char *strncat();
extern	int strncmp();
extern	char *strncpy();
extern	char *strpbrk();
extern	int strpos();		/* CARM only! */
extern	char *strrchr();
extern	char *rindex();		/* V7/BSD name for strrchr */
extern	char *strrpbrk();	/* CARM only! */
extern	int strrpos();		/* CARM only! */
extern	int strspn();
extern	char *strtok();		/* not in V7 */
extern	char *strstr();		/* New ANSI/CARM */
extern	char *strerror();	/* New ANSI/CARM */

/* These functions used to be declared in <memory.h> but ANSI has
** moved them here, so <memory.h> now just includes this file.
*/
extern	char *memchr();
extern	int memcmp();
extern	char *memcpy();
extern	char *memset();
extern	char *memmove();	/* New ANSI/CARM */
extern	char *memccpy();	/* S5/BSD/CARM, not in ANSI */

#endif /* ifndef _STRING_INCLUDED */
