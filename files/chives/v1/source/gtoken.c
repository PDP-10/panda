/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Token parser for RFC883 syntax.
 *
 * Code is reentrant, the only state is kept in the stream (via
 * ungetc()) and a boolean in the caller's space to indicate whether
 * line continuation is currently in effect.  This variable should
 * always be initialzed to zero by the caller at the time the stream
 * is opened (prior to any calls to gtoken()) and not touched after
 * that.  If EOF is encountered with line continuation turned on,
 * a bugchk will be issued mentioning this.
 *
 * Other than that, this code is straightforward, albeit messy.
 */

#include "domsym.h"

/* gtoken.c */
int gtoken(FILE *,char *,int *,int);
int geol(FILE *,int *);

int gtoken(stream,buffer,crockp,skipws)
    FILE *stream;			/* stream we reading from */
    char *buffer;			/* buffer to read into */
    int  *crockp;			/* state of line continuation */
    int   skipws;			/* should we skip whitespace */
{
    int count = 0, c;
    char *whole_buffer = buffer;	/* before it gets trashed */

    for(;;)				/* EOF handled below */
	switch(c = fgetc(stream)) {
					/* various kinds of break chars: */
	    case '\t':
		ungetc(' ',stream);	/* fake as a space */
		continue;		/* (this loop is too complicated) */

	    case EOF:
		if(*crockp) {		/* detect bogus state */
		    bugchk("gtoken","EOF inside continued line");
		    *crockp = 0;	/* don't flame about it twice */
		}
		if(count == 0)		/* if nothing scanned yet */
		    return(0);		/* just tell caller we're done */
					/* otherwise, treat as EOL */
					/* (fall through) */
	    case ';':			/* comments become EOL too */
		while(c != EOF && c != '\n')
		    c = fgetc(stream);	/* slurrrp */
					/* (fall through) */
	    case '\f':	case '\r':	/* funny characters, fake EOL */
					/* (fall through) */
	    case '\n':			/* honest EOL */
		if(*crockp)		/* some kind of EOL character */
		    c = ' ';		/* convert to cannonical EOL */
		else			/* or space, depends on continuation */
		    c = '\n';		/* state */
					/* (fall through) */
	    case ' ':			/* ok, we've got a break character */
		if(count != 0)		/* if there's already text */
		    ungetc(c,stream);	/* save break char for next pass */
		else if(skipws && c == ' ')
		    continue;		/* just ignore it if appropriate */
		else			/* otherwise pass it back to caller */
		    *buffer++ = c;
		*buffer = '\0';		/* tie off string */
		if(DBGFLG(DBG_GTOKEN))
		    buginf("gtoken","token: \"%s\"",whole_buffer);
		return(1);		/* tell caller we got something */

	    case '(':			/* line continuation on */
		*crockp = 1;
		continue;

	    case ')':			/* line continuation off */
		*crockp = 0;
		continue;

	    case '\\':			/* quoted character */
		*buffer++ = c;		/* pass quote through */
		c = fgetc(stream);	/* get quoted character */
		++count;		/* saw something */
		if(isdigit(c)) {	/* numeric coded char? */
		    ungetc(c,stream);	/* yep, let stdio do work */
		    fscanf(stream,"%3d",&c);
		    *buffer++ = c;	/* get one character */
		    continue;		/* onwards */
		}			/* otherwise, quoted char */
					/* fall through... */
	    default:			/* j random character */
		++count;		/* remember we saw it */
		*buffer++ = c;		/* tack it on and done */
		continue;
	}
}


/* find EOL, type warning(s) if not next token */

int geol(stream,crockp)
    FILE *stream;
    int  *crockp;
{
    int losers = 0;
    char buffer[STRSIZ];
    while(gtoken(stream,buffer,crockp,1) && *buffer != '\n')
	bugchk("geol","bogus token #%d when expecting EOL: %s",
		++losers, buffer);
    return(losers == 0);
}
