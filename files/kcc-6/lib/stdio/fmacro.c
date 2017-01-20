/*
**	FMACRO.C - miscellaneous real functions for STDIO macros
**
**	(c) Copyright Ken Harrenstien 1989
**
** ANSI C requires that all library routines actually exist even if
** macros are normally defined for them.  This file collects some
** of the "trivial" facilities.
*/

#include <stdioi.h>

#if __STDC__	/* Pre-ANSI compiler would barf on "(macro)" syntax */

void (clearerr)(f) FILE *f;	{ clearerr(f);		}
int (feof)  (f) FILE *f;	{ return feof(f);	}
int (ferror)(f) FILE *f;	{ return ferror(f);	}
int (getc)  (f) FILE *f;	{ return getc(f);	}
int (putc)(c,f) FILE *f;	{ return putc(c,f);	}
int (getchar)()			{ return getchar();	}
int (putchar)(c)		{ return putchar(c);	}
int (fileno)(f) FILE *f;	{ return fileno(f);	}

#endif
