/*
 *	make [-f makefile] [-dimnpqrst] [target(s) ...]
 *
 *	-d debug output on stderr
 *	-f makefile name
 *	-i ignore exit status
 *	-m change memory requirements (EON only)
 *	-n pretend to make
 *	-p print all macros & targets
 *	-q question up-to-dateness of target.  Return exit status 1 if not
 *	-r do not use built-in rules
 *	-s make silently
 *	-t touch files instead of making them
 */

#include "h.h"

#ifdef EON
#include <sys/err.h>
#endif

#ifdef KCC_20
#include <errno.h>
#endif

#ifdef MSC
#include <errno.h>
#endif

#ifdef OS9
#include <errno.h>
#endif

#ifdef UNIX
#include <sys/errno.h>
#endif

#ifdef VMS
#include <errno.h>
#endif

#ifdef EON
#define MEMSPACE	(16384)
#endif


char *myname;
char *makefile;			/* The make file  */

#ifdef EON
unsigned memspace = MEMSPACE;
#endif

FILE *ifd;			/* Input file desciptor  */
int debug = 0;			/* debug printout on stderr */
bool domake = TRUE;		/* Go through the motions option  */
bool ignore = FALSE;		/* Ignore exit status option  */
bool silent = FALSE;		/* Silent option  */
bool print = FALSE;		/* Print debugging information  */
bool rules = TRUE;		/* Use inbuilt rules  */
bool dotouch = FALSE;		/* Touch files instead of making  */
bool quest = FALSE;		/* Question up-to-dateness of file  */


void
main(argc, argv)
int argc;
char **argv;
{
    register char *p;
    char *q;
    int estat = 0;		/* exit status code */
    register NAMEP np;
    DEPENDP mfhead;		/* makefile name list head pointer */
    DEPENDP mfdp;
    NAMEP mfnp;

    myname = (argc-- < 1) ? "make" : *argv++;

#ifdef VMS
    myname = "make";		/* otherwise get ugly dev:[dir]make.exe.## */
#endif

    mfhead = NULL_DEPENDP;	/* no makefile names yet */

    while ((argc > 0) && (**argv == '-'))
    {
	argc--;			/* One less to process  */
	p = *argv++;		/* Now processing this one  */

	while (*++p != '\0')
	{

#ifdef CASE_INSENSITIVE
	    *p = (isupper(*p) ? tolower(*p) : *p);
#endif

	    switch (*p)
	    {
	    case 'd':
		debug = isdigit(p[1]) ? atoi(&p[1]) : 1;
		while (isdigit(*++p))	/* skip over digits */
		    ;
		--p;		/* point to last digit or 'd' */
		break;

	    case 'f':		/* Alternate file name  */
		if (*++p == '\0')
		{
		    if (argc-- <= 0)
			usage();
		    p = *argv++;
		}
		mfnp = newname(p);
		mfhead = newdep(mfnp, mfhead);
		p = index(p, '\0') - 1;	/* point to just before NUL */
		break;

#ifdef EON
	    case 'm':		/* Change space requirements  */
		if (*++p == '\0')
		{
		    if (argc-- <= 0)
			usage();
		    p = *argv++;
		}
		memspace = atoi(p);
		goto end_of_args;
#endif
	    case 'n':		/* Pretend mode  */
		domake = FALSE;
		break;

	    case 'i':		/* Ignore fault mode  */
		ignore = TRUE;
		break;

	    case 's':		/* Silent about commands  */
		silent = TRUE;
		break;

	    case 'p':
		print = TRUE;
		break;

	    case 'r':
		rules = FALSE;
		break;

	    case 't':
		dotouch = TRUE;
		break;

	    case 'q':
		quest = TRUE;
		break;

	    default:		/* Wrong option  */
		usage();
	    }
	}
end_of_args:;
    }

#ifdef EON
    if (initalloc(memspace) == 0xffff)	/* Must get memory for alloc  */
	fatal("Cannot initalloc memory");
#endif
    (void) setmacro("$", "$", PERMANENT);

    /* Now install any command-line macro definitions, overriding any */
    /* values from the Makefile */
    while (argc && (p = index(*argv, '=')))
    {
	char c;

	c = *p;
	*p = '\0';
	(void) setmacro(*argv, p + 1, PERMANENT);
	*p = c;

	argv++;
	argc--;
    }

    if (rules)
    {
	makerules();			/* install built-in rules */
	makeinit();			/* process local rule modifications */
    }

    if (mfhead == NULL_DEPENDP)	/* supply list of defaults */
    {
	strcpy(str1, MAKEFILES);
	str1[strlen(str1) + 1] = '\0';	/* extra NUL for gettok() */
	for (q = str1; (p = gettok(&q)) != NULL_CHARP; /* NO-OP */ )
	{
	    mfnp = newname(p);
	    mfnp->n_flag |= N_DEFAULT;
	    mfhead = newdep(mfnp, mfhead);
	}
    }
    for (mfdp = mfhead; mfdp; mfdp = mfdp->d_next)
    {
	makefile = mfdp->d_name->n_name;
	if (debug)
	    fprintf(stderr, "MAKEFILE[%s]\n", makefile);
	if (strcmp(makefile, "-") == 0)	/* use stdin as makefile */
	    ifd = stdin;
	else
	{
	    ifd = fopen(makefile, "r");
	    if (ifd == NULL_FILEP)
	    {
		if (mfdp->d_name->n_flag & N_DEFAULT)
		    continue;	/* ignore open failures on default names */
		else
		{
		    sprintf(str1, "Can't open makefile [%s]", makefile);
		    fatal(str1);
		}

	    }
	}
	lineno = 0;		/* for error messages */
	input(ifd);		/* process the makefile */
	if (ifd != stdin)
	    fclose(ifd);	/* and close it */
    }
    lineno = 0;			/* Calls to error() now print no line number */

    if (print)
	prt();			/* Print out structures  */

    np = newname(".SILENT");
    if (np->n_flag & N_TARG)
	silent = TRUE;

    np = newname(".IGNORE");
    if (np->n_flag & N_TARG)
	ignore = TRUE;

    precious();

    if (!firstname)
	fatal("No targets defined");

    circh();			/* Check circles in target definitions  */

    if (!argc)
	estat = make(firstname, 0);
    else
	while (argc--)
	{
	    if (!print && !silent && strcmp(*argv, "love") == 0)
		printf("Not war!\n");
	    estat |= make(newname(*argv++), 0);
	}

    if (quest)
	EXIT(estat);
    else
	EXIT(0);
}

/***********************************************************************
The environment variable (DEC logical  name) MAKEINIT can be defined  to
be a list of filenames separated by NAMESEP (normally a semicolon) which
are in normal Makefile format, and are automatically processed after the
built-in rules are established, and before the user Makefile is read.

This makes it possible to tailor  default rules for particular sites  or
projects, avoiding the necessity of massive modifications of  individual
user makefiles.   For example,  a project  might wish  to have  compiler
debug options  set during  development,  then replaced  by  optimization
requests at the final release.  Similarly, a system administrator  could
change a default compiler on a system-wide basis.
***********************************************************************/
void
makeinit()
{
    register char *p;
    char *filename;
    FILE *fp;

    if ((p = getenv("MAKEINIT")) == NULL_CHARP)
	return;
    for (; *p; ++p)		/* process each file in MAKEINIT list in turn */
    {
	filename = p;
	p = index(filename, NAMESEP);
	if (p != NULL_CHARP)
	    *p = '\0';		/* change NAMESEP to string terminator */
	if ((fp = fopen(filename, "r")) == NULL_FILEP)
	{
	    sprintf(str1, "Cannot open makefile [%s]", filename);
	    fatal(str1);
	}
	if (!silent)
	    printf("[Defaults from %s]\n", filename);
	lineno = 0;
	input(fp);
	fclose(fp);
    }
    lineno = 0;			/* Any calls to error now print no line
				   number */
}


void
usage()
{
    fprintf(stderr,
#ifdef EON
    "Usage: %s [-f makefile] [-dimnpqrst] [macro=val ...] [target(s) ...]\n",
#else
    "Usage: %s [-f makefile] [-dinpqrst] [macro=val ...] [target(s) ...]\n",
#endif
	    myname);
    EXIT(1);
}


void
fatal(msg)
char *msg;
{
    static bool entered = FALSE;

    if (entered)		/* unexpected recursive entry */
	EXIT(1);
    entered = TRUE;

#ifdef KCC_20
    fprintf(stderr, "?");	/* error flag for batch use */
#endif

    fprintf(stderr, "%s: ", myname);
    fprintf(stderr, msg);
    fputc('\n', stderr);
    if (errno)
	perror("perror() says");
    if (debug)
    {
	NAMEP tnp;

	prt();
	for (tnp = namehead.n_next; tnp; tnp = tnp->n_next)
	    prtname(tnp, 0);
    }
    EXIT(1);
}


char *
newstring(p, value)
char *p;
char *value;
/*
** If 'p' is non-NULL, free the  storage it points to.  Then allocate  a
** block of storage large enough for 'value' bytes, copy the contents of
** 'value' into it, and return a pointer to the new block.  Execution is
** terminated if there is insufficient storage for the new string.
*/
{
    int k;

    if (p != NULL_CHARP)
	(void) free(p);

    k = strlen(value);
    if ((p = malloc(k + 1)) == NULL_CHARP)
	fatal("No memory for name");

    strcpy(p, value);
    return (p);
}




#ifdef CASE_INSENSITIVE
/***********************************************************************
 Compare strings (ignoring case), and return:
	s1>s2:	>0
	s1==s2:  0
	s1<s2:	<0
***********************************************************************/

/* toupper() is  supposed to work  for all letters,  but PCC-20 does  it
incorrectly if the  argument is not  already lowercase; this  definition
fixes that.  PC histogramming of MAKE compiled with KCC-20 revealed that
45% (!) of the  total execution time  is spent in  this function, and  a
further 15%  in  toupper().  With  KCC,  toupper() is  a  function,  and
islower() and  _toupper()  are in-line.   Putting  in a  conditional  is
therefore  extremely   worthwhile   here,  and   saved   24%.    Further
economization by rewriting the inner loop to avoid the UC() calls unless
necessary gave a further improvement of only 2%. */

int
strcm2(s1, s2)
register char *s1;
register char *s2;
{

#ifdef KCC_20
#define UC(c) (islower(c) ? _toupper(c) : c)
    while (*s1)
    {
	if (*s1 == *s2)
	    /* NO-OP */;
	else if (UC(*s1) == UC(*s2))
	    /* NO-OP */;
	else
	    break;
	s1++;
	s2++;
    }
#else
#define UC(c) (islower(c) ? toupper(c) : c)
    while ((*s1) && (UC(*s1) == UC(*s2)))
    {
	s1++;
	s2++;
    }
#endif

    return ((int) (UC(*s1) - UC(*s2)));
}

#endif
 