/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 */

/* Simple routine to skip whitespace in config files. */

#include <stdio.h>

int skipws(stream)
    FILE *stream;
{
    int c;

    if(stream == NULL)			/* in case caller blindly handed */
	return(0);			/* us the result of a bad fopen() */

    for(;;)				/* look at next char in stream */
	switch(c = fgetc(stream)) {
	    case ';':			/* comment? */
		do			/* yup, skip to EOL */
		    c = fgetc(stream);
		while(c != '\n' && c != EOF);
	    case ' ':   case '\r': case '\f':
	    case '\n':	case '\t':	/* skip whitespace */
		continue;
	    case EOF:			/* end of file? */
		return(0);		/* tell user we lost */
	    default:
		ungetc(c,stream);	/* otherwise real input */
		return(1);		/* tell user we won */
	}
}
