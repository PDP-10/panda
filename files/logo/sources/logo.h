/* Portable Logo, release 3 */
/* Boston Children's Museum - Lincoln-Sudbury Regional High School*/
/* TOPS-20 port by Brian Harvey and Mark Crispin*/

/* Installation-dependent parameters */

#define EDT "emacs"	/* default editor for procedure editing */

/* Turn on the graphics devices you have. */
	/* L-S and Atari */
#define ATARI
	/* L-S */
#define GIGI
	/* COM */
#define ADM
	/* COM */
#define TEK
	/* Lucasfilm */
/* #define SUN */
	/* L-S */
/* #define FLOOR */
	/* turn on for no graphics at all */
/* #define NOTURTLE */

	/* turn on for inferior Eunice */
/* #define EUNICE */

	/* turn on for non-split-I/D PDP-11. */
/* #define SMALL */

#define EXTLOGO			/* Turn on for .logo instead of .lg */

#define NAMELEN 11		/* max length of procedure name, must fit
				   into xxxxxxx.lg filename format */
	/* Should be 11 for Unix unless EXTLOGO is on,
	   9 for Eunice or EXTLOGO. */

/* Initial values for which signal pauses and which aborts */
#define PAUSESIG SIGINT
#define OTHERSIG SIGQUIT

#ifdef SMALL
#define MAXALLOC 30
#define YYMAXDEPTH 150
#else

/* Memory allocation tuning.  Adjust these numbers if you run out of space. */
#define MAXALLOC 100
/* Increase MAXALLOC for "I can't remember everything you have told me." */
#define YYMAXDEPTH 2200
/* Increase YYMAXDEPTH if you see "Too many levels of recursion." */
/* Decrease something if you see "No more memory, sorry." */
#endif

#ifndef SMALL
#define DEBUG		/* enable debugging code */
#define PAUSE		/* enable pause feature */
#endif

/* ---------  End of installation-dependent parameters  --------- */

#ifdef EXTLOGO
#define EXTEN ".logo"
#define POTSCMD "PS:<LOGO.LIBRARY>LOGOHEAD *.logo"
#else
#define EXTEN ".lg"
#define POTSCMD "PS:<LOGO.LIBRARY>LOGOHEAD *.lg"
#endif

#ifdef SMALL
#define NUMBER float
#define FIXNUM int
#define EFMT "%e"
#define FIXFMT "%d"
#define IBUFSIZ 200
#define PSTKSIZ 64
#else
#define NUMBER double
#define FIXNUM long
#define EFMT "%E"
#define FIXFMT "%D"
#define IBUFSIZ 1000
#define PSTKSIZ 128
#endif

#ifdef DEBUG
#define YYDEBUG
#define JFREE jfree
#else
#define JFREE free
#endif

#define GLOBAL extern
#define READ 0
#define WRITE 1
#define FAST register
#define FOREVER for(;;)
#define FILDES int
#define BUFSIZE 512
#include <stdio.h>
#undef getchar

struct cons {
	struct object *car;
	struct object *cdr;
};

struct object {
#ifdef SMALL
	char obtype;
	char refcnt;
#else
	int obtype;
	int refcnt;
#endif
	union {
		struct cons ob_cons;
		char *ob_str;
		FIXNUM ob_int;
		NUMBER ob_dub;
	} obob;
};

#define obcons	obob.ob_cons
#define obstr	obob.ob_str
#define obint	obob.ob_int
#define obdub	obob.ob_dub
#define obcar	obob.ob_cons.car
#define obcdr	obob.ob_cons.cdr

#define CONS	0
#define STRING	1
#define	INT	2
#define	DUB	3

extern int memtrace;

#define listp(x)	(((x)==0) || (((x)->obtype)==CONS))
#define stringp(x)	((x) && (((x)->obtype)==STRING))
#define intp(x)		((x) && (((x)->obtype)==INT))
#define dubp(x)		((x) && (((x)->obtype)==DUB))

extern char *ckmalloc();
extern struct object *localize(),*globcopy(),*glbcons(),*loccons();
extern struct object *objstr(),*objcpstr(),*objint(),*objdub();
extern struct object *numconv(),*dubconv(),*true(),*false();
extern struct object *makelist(),*stringform(),*torf();
extern int errrec();

struct stkframe
{
	struct alist *loclist;
	char argtord;
	char iftest;
	int *stk;
	int ind;
	int *oldnewstk;
	struct alist *oldnloc;
	struct plist *prevpcell;
	int oldyyc;
	int oldyyl;
	char *oldbpt;
	struct stkframe *prevframe;
#ifdef SMALL
	char oldline;
	char oldpfg;
#else
	int oldline;
	int oldpfg;
#endif
};

struct plist
{
	struct plist *before;
	struct object *procname;
	int recdepth;
	struct object *ptitle;
	int *realbase;
	struct lincell *plines;
	struct plist *after;
};

struct lincell
{
	int linenum;
	int *base;
	int index;
	struct lincell *nextline;
};

struct alist
{
	struct object *name;
	struct object *val;
	struct alist *next;
};

struct lexstruct
{
	char *word;
	int lexret;
	struct object *(*lexval)();
	char *abbr;
};

struct runblock
{
	struct runblock *rprev;
	struct object *str;
	char *svbpt;
	int roldyyc;
	int roldyyl;
	int roldline;
	FIXNUM rcount;
	FIXNUM rupcount;
	int svpflag;
	int svletflag;
	char svch;
};

struct display {
	NUMBER turtx,turty,turth;	/* current values */
	NUMBER xlow,xhigh,ylow,yhigh;	/* limits for this dpy */
	NUMBER stdscrunch;		/* standard aspect ratio */
	int cleared;			/* nonzero after first use */
	char *init,*finish;		/* printed to enable, disable gfx */
	char *totext;			/* printed for temporary textscreen */
	char *clear;			/* printed for cs, and after init */
	int (*drawturt)();		/* one arg, 0 to show, 1 to erase */
	int (*drawfrom)(), (*drawto)();	/* 2 args, x and y, draw vector */
	int (*txtchk)();		/* make error if can't gfx in txtmode */
	int (*infn)(), (*outfn)();	/* no args, called to enable, disable */
	int (*turnturt)();		/* no args, tell Atari turtle heading */
	int (*penc)(), (*setc)();	/* color map routines */
	int (*state)();			/* one arg, state change flag */
};

extern int nullfn();
