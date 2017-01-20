/* <STDIO.H> - Standard I/O internal definitions
**
**	(c) Copyright Richard P. Helliwell, XKL Systems Corporation 1994
**
*/

#ifndef _STDIOI_H_
#define _STDIOI_H_

#include <stdio.h>

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* CLEANU.C */
extern void _cleanup P_((void));

/* FFLUSH.C */
extern int _prime P_((FILE *f));

/* FGETC.C */
extern int _readable P_((FILE *f));
extern int _filbuf P_((FILE *f));

/* FOPEN.C */
extern FILE *_makeFILE P_((void));
extern void _freeFILE P_((FILE *f));

/* FPUTC.C */
extern int _writeable P_((FILE *f));
#ifdef NEWSTREXP
extern int _expand P_((FILE *f,int by));
#endif 

/* FREOPE.C */
extern int _sioflags P_((const char *type,int *ufaddr));
extern void _setFILE P_((FILE *f,int fd,int flags));

#undef P_

/* 'FILE *' list head */
extern FILE *_FILE_head;

#endif /* _STDIOI_H_ */
