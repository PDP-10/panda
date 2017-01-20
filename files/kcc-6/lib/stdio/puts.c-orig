/*
 *	PUTS - write a string to stdio
 *
 *	Copyright (c) 1986 by Ian Macky, SRI International
 */

#include <stdio.h>

#if __STDC__
#define CONST const
#else
#define CONST
#endif

int puts(s)
CONST char *s;
{
    if (!_writeable(stdout)) return EOF;
    else return (fputs(s, stdout) != EOF) ? putc('\n', stdout) : EOF;
}
