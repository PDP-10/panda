/*	CCERR.H - KCC Error declarations
**
**	(c) Copyright Ken Harrenstien 1989
*/

#ifndef __STDC__
#define __STDC__ 0
#endif

#if __STDC__
#define FMTARG char *, ...	/* Prototype args if using ANSI */
#else
#define FMTARG			/* No prototype */
#endif

extern void
	jmsg(FMTARG),		/* Job message,	"?KCC - " */
	jerr(FMTARG),		/* Job err msg,	"?KCC - " */
	note(FMTARG),		/* "[Note] " */	
	advise(FMTARG),		/* "[Advisory] " */	
	warn(FMTARG),		/* "[Warning] " */	
	int_warn(FMTARG),	/* "[Warning] Internal error - " */ 
	error(FMTARG),		/* "" */	
	int_error(FMTARG),	/* "Internal error - " */
	efatal(FMTARG),		/* "[Fatal] " with context */
	fatal(FMTARG);		/* "[Fatal] " without context */
extern void errfopen();
extern int expect(), errflush();
