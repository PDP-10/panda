/*
 *	Include header for make
 */

/* Include the most-needed system files */
#include <stdio.h>
#include <ctype.h>

#ifdef EON
typedef long time_t;
#endif

#ifdef KCC_20
#include <types.h>		/* need for time_t */
#endif

#ifdef MSC
#include <sys/types.h>		/* need for time_t */
#include <sys/utime.h>
#include <process.h>		/* for library type declarations */
#include <stdlib.h>		/* for library type declarations */
#include <string.h>		/* for library type declarations */
#include <time.h>		/* for library type declarations */
#define index strchr
#define rindex strrchr
#endif

#ifdef OS9
typedef long time_t;
#endif

#ifdef UNIX
#include <sys/types.h>		/* need for time_t */
#endif

#ifdef VMS
#include <types.h>		/* need for time_t */
#define index strchr
#define rindex strrchr
#endif

#ifdef VMS
#define EXIT vms_exit
#else
#define EXIT exit
#endif

#ifndef uchar
#ifdef OS9
typedef char uchar;
typedef int void;
#define fputc		putc
#else
typedef unsigned char uchar;
#endif
#endif

typedef uchar bool;

#define NOTIME		((time_t)0)
#define TRUE		((bool)1)
#define FALSE		((bool)0)
#define max(a,b)	((a)>(b)?(a):(b))

#ifdef EON
#define MAKEFILES	"Makefile"
#define MORE		"\\\n"	/* how to continue shell command lines */
#define NAMESEP		';'	/* for makeinit(); this may need changing */
#define TAB		'\t'
#endif

#ifdef KCC_20
#define MAKEFILES	"Makefile"
#define MORE		"\n"	/* how to continue shell command lines */
#define NAMESEP		';'	/* for makeinit(); this may need changing */
#define TAB		'\t'
#endif

#ifdef MSC
#define MAKEFILES	"Makefile"
#define MORE		"\\\n"	/* how to continue shell command lines */
#define NAMESEP		';'	/* for makeinit(); this may need changing */
#define TAB		'\t'
#endif

#ifdef OS9
#define MAKEFILES	"Makefile"
#define MORE		"\\\n"	/* how to continue shell command lines */
#define NAMESEP		';'	/* for makeinit(); this may need changing */
#define TAB		' '	/* OS9 seems not to have tab, why? */
#endif

#ifdef UNIX
#define MAKEFILES "makefile Makefile s.makefile s.Makefile SCCS/s.makefile \
SCCS/s.Makefile"
#define MORE		"\\\n"	/* how to continue shell command lines */
#define NAMESEP		';'	/* for makeinit(); this may need changing */
#define TAB		'\t'
#endif

#ifdef VMS
#define MAKEFILES	"Makefile"
#define MORE		"\n"	/* how to continue shell command lines */
#define NAMESEP		';'	/* for makeinit(); this may need changing */
#define TAB		'\t'
#endif

#ifdef MSC
#define MAXSTRING (4096)	/* Line size -- BIG for long dependency lists */
#else
#define MAXSTRING (20480)	/* Line size -- BIG for long dependency lists */
#endif

/* Make structure pointer types so we can use them in struct's */
typedef struct cmd *CMDP;
typedef struct depend *DEPENDP;
typedef struct line *LINEP;
typedef struct macro *MACROP;
typedef struct name *NAMEP;

/*
 *	A name.  This represents a file, either to be made, or existant
 */
typedef struct name
{
    NAMEP n_next;		/* Next in the list of names */
    char *n_name;		/* Called */
    LINEP n_line;		/* Dependencies */
    time_t n_time;		/* Modify time of this name */
    uchar n_flag;		/* Info about the name */
}   NAME;

#define N_MARK		0x01	/* For cycle check */
#define N_DONE		0x02	/* Name looked at */
#define N_TARG		0x04	/* Name is a target */
#define N_PREC		0x08	/* Target is precious */
#define N_DOUBLE	0x10	/* Double colon target */
#define N_DEFAULT	0x20	/* Default (in makefile name list) */

/*
 *	Definition of a target line.
 */

typedef struct line
{
    LINEP l_next;		/* Next line (for ::) */
    DEPENDP l_dep;		/* Dependents for this line */
    CMDP l_cmd;			/* Commands for this line */
}   LINE;

/*
 *	List of dependents for a line
 */
typedef struct depend
{
    DEPENDP d_next;		/* Next dependent */
    NAMEP d_name;		/* Name of dependent */
}   DEPEND;


/*
 *	Commands for a line
 */
typedef struct cmd
{
    CMDP c_next;		/* Next command line */
    char *c_cmd;		/* Command line */
}   CMD;


/*
 *	Macro storage
 */
typedef struct macro
{
    MACROP m_next;		/* Next variable */
    char *m_name;		/* Called ... */
    char *m_val;		/* Its value */
    uchar m_flag;		/* Infinite loop and permanent flags */
}   MACRO;

#define M_SEEN		0x01	/* macro name seen in search loop */
#define M_PERMANENT	0x02	/* macro is permanent (command line) */

#define PERMANENT	TRUE
#define TEMPORARY	FALSE


/*
 *	Default rules structure
 */

typedef struct rule
{
    char *r_target;		/* target name */
    char *r_command;		/* commands to build target */
}   RULE;

extern int debug;
extern bool domake;
extern bool dotouch;
extern NAMEP firstname;
extern bool ignore;
extern int lineno;
extern MACROP macrohead;
extern char *myname;
extern struct name namehead;
extern bool quest;
extern bool rules;
extern bool silent;
extern char str1[];

#ifndef VMS
extern int errno;
#endif

#ifdef ANSI			/* ANSI function and argument type
				   declarations */
void 
check(NAMEP);
void 
circh(void);
void 
docmd2(NAMEP, LINEP);
void 
docmds(NAMEP);
void 
doexp(char **, char *, int *, char *);
int 
dosh(char *, char *);
bool 
dyndep(NAMEP);
void 
error(char *);
void 
expand(char *);
void 
fatal(char *);
char *
getenv(char *);
bool 
getline(char *, FILE *);
char *
getmacro(char *);
MACROP 
getmp(char *);
char *
gettok(char **);
char *
index(char *, char);
void 
input(FILE *);
void 
main(int, char **);
int 
make(NAMEP, int);
void 
make1(NAMEP, LINEP, DEPENDP);
void 
makeinit(void);
void 
makerules(void);

#ifndef MSC
char *
malloc(int);
#endif

void 
modtime(NAMEP);
CMDP 
newcmd(char *, CMDP);
DEPENDP 
newdep(NAMEP, DEPENDP);
void 
newline(NAMEP, DEPENDP, CMDP, bool);
NAMEP 
newname(char *);
char *
newstring(char *, char *);
void 
newsuffix(char *);
void 
precious(void);
void 
prt(void);
void 
prtcmd(CMDP, int);
void 
prtdepend(DEPENDP, int);
void 
prtlevel(int);
void 
prtline(LINEP, int);
void 
prtname(NAMEP, int);
char *
rindex(char *, char);
MACROP 
setmacro(char *, char *, bool);
void 
squeeze(char *);
int 
strcm2(char *, char *);
char *
suffix(char *);
void 
touch(NAMEP);
void 
usage(void);

#else				/* old-style function declarations */

void check();
void circh();
void docmd2();
void docmds();
void doexp();
int dosh();
bool dyndep();
void error();
void expand();
void fatal();
char *getenv();
bool getline();
char *getmacro();
MACROP getmp();
char *gettok();
char *index();
void input();
void main();
int make();
void make1();
void makeinit();
void makerules();

#ifndef MSC
char *malloc();
#endif

void modtime();
CMDP newcmd();
DEPENDP newdep();
void newline();
NAMEP newname();
char *newstring();
void newsuffix();
void precious();
void prt();
void prtcmd();
void prtdepend();
void prtlevel();
void prtline();
void prtname();
char *rindex();
MACROP setmacro();
void squeeze();
int strcm2();
char *suffix();
void touch();
void usage();
#endif

/* Define some convenient shorthands for null typecasts */
#define NULL_CHARP	((char *)NULL)
#define NULL_CMDP	((CMDP)NULL)
#define NULL_DEPENDP	((DEPENDP)NULL)
#define NULL_FILEP	((FILE *)NULL)
#define NULL_LINEP	((LINEP)NULL)
#define NULL_MACROP	((MACROP)NULL)
#define NULL_NAMEP	((NAMEP)NULL)

#ifdef CASE_INSENSITIVE
#define strcmp strcm2		/* host is not case-sensitive */
#endif
