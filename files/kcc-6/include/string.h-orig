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
** The mem*() functions used to be declared in <memory.h> but ANSI has
** moved them here, so <memory.h> now just includes <string.h>.
**
**	All of these functions are documented in
**	CARM II (H&S v2), chap 15 and 16.
*/

#ifndef _STRING_INCLUDED
#define _STRING_INCLUDED
#ifndef __STDC__	/* Canonicalize this indicator to avoid err msgs */
#define __STDC__ 0
#endif

#ifndef _SIZE_T_DEFINED		/* Avoid conflict with other headers */
#define _SIZE_T_DEFINED
typedef unsigned size_t;	/* Type of sizeof() (must be unsigned, ugh) */
#endif

#define NULL 0			/* Benign redef */

#if __STDC__
/* Copying */
void *memcpy(void*, const void*, size_t);	/* to, from, n */
void *memmove(void*, const void*, size_t);	/* to, from, n */
char *strcpy(char*, const char*);		/* to, from */
char *strncpy(char*, const char*, size_t);	/* to, from, n */

/* Concatenation */
char *strcat(char*, const char*);		/* to, from */
char *strncat(char*, const char*, size_t);	/* to, from, n */

/* Comparison */
int memcmp(const void*, const void*, size_t);	/* s1, s2, n */
int strcmp(const char*, const char*);		/* s1, s2 */
int strcoll(const char*, const char*);		/* s1, s2 */
int strncmp(const char*, const char*, size_t);	/* s1, s2, n */
size_t strxfrm(char*, const char*, size_t);	/* to, from, n */

/* Searching */
void *memchr(const void*, int, size_t);		/* s, ch, n */
char *strchr(const char*, int);			/* s, ch */
size_t strcspn(const char*, const char*);	/* s, set */
char *strpbrk(const char*, const char*);	/* s, set */
char *strrchr(const char*, int);		/* s, ch */
size_t strspn(const char*, const char*);	/* s, set */
char *strstr(const char*, const char*);		/* s, substr */
char *strtok(char *, const char*);		/* s, brkset */

/* Miscellaneous */
void *memset(void*, int, size_t);		/* to, val, n */
char *strerror(int);				/* errno */
size_t strlen(const char*);			/* s */

/* CARM/BSD extensions */
char *index(const char*, int);		/* V7/BSD name for strchr */
char *rindex(const char*, int);		/* V7/BSD name for strrchr */
int strpos(const char*, int);		/* CARM only! */
int strrpos(const char*, int);		/* CARM only! */
char *strrpbrk(const char*, const char*);	/* CARM only! */
void *memccpy(void*, const void*, int, size_t);	/* S5/BSD/CARM, not in ANSI */

#else	/* Old-style decls */

extern size_t strlen(), strspn(), strcspn();
extern	char *strcat(), *strchr(), *index(), *strcpy(), *strncat(), *strncpy(),
	*strpbrk(), *strrchr(), *rindex(), *strrpbrk(), *strtok(), *strstr(),
	*strerror();
extern int
	strcmp(), strncmp(), strpos(), strrpos();
extern	int memcmp();
extern	char *memchr(), *memcpy(), *memset(), *memmove(), *memccpy();

#endif	/* not __STDC__ */

#endif /* ifndef _STRING_INCLUDED */
