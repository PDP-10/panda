/* <URTSUD.H> - USYS StartUp Definitions (KCC)
**
**	(c) Copyright Ken Harrenstien 1989
**
**	Declares structure used by _runtm() to determine
** what style of command-line parsing to do, as well as any other
** options or _runtm control that become necessary.
**
**	This file should be included only once!!!
**
**	Define _URTSUD if you wish to include an actual initialization of
** the structure, using defaults for all values not explicitly defined as
** _URTSUD_DEFAULT_xxx.
*/

/*
 *	Define xxx_PARSE_COMMAND_LINE before including this file if you
 *	want other than the default command-line parsing, which is unix
 *	shell-style.  xxx is one of:
 */
/* NO to not parse the command line at all (leave the RSCAN buffer unread)
 */
#ifdef NO_PARSE_COMMAND_LINE
#define _URTSUD
#define _URTSUD_DEFAULT_PARSE _URTSUD_NO_PARSE
#endif

/* SHELL for unix-shell-style parsing (broken into words, magic chars for
 *	redirection, background, etc).
 */
#ifdef SHELL_PARSE_COMMAND_LINE
#define _URTSUD
#define _URTSUD_DEFAULT_PARSE _URTSUD_SHELL_PARSE
#endif

/* EXEC for T20 EXEC type parsing, where argv[0] will be the command name,
 *	and argv[1] will be the rest of the command line as a single string,
 *	blanks included.
 */
#ifdef EXEC_PARSE_COMMAND_LINE
#define _URTSUD
#define _URTSUD_DEFAULT_PARSE _URTSUD_EXEC_PARSE
#endif


struct _urtsud {
    int su_parser_type;		/* style of command-line parsing to do */
    int su_signal_type;		/* Type of signal handling to do */
    int su_path_in_type;	/* Path input syntax */
    int su_path_out_type;	/* Path output syntax */
    int su_chdir_type;		/* How to do chdir() */
    int reserved[10];		/* Extra words for future stuff */
};

/* Command-line parser types */
#define _URTSUD_NO_PARSE	0
#define _URTSUD_SHELL_PARSE	1
#define _URTSUD_EXEC_PARSE	2
#ifndef _URTSUD_DEFAULT_PARSE			/* Set default parsing type */
#define _URTSUD_DEFAULT_PARSE _URTSUD_SHELL_PARSE
#endif

/* Signal handling types */
#define _URTSUD_SYSV_SIGS	0
#define _URTSUD_BSD42_SIGS	1
#define _URTSUD_BSD43_SIGS	2
#ifndef _URTSUD_DEFAULT_SIGS		/* Set default signal handling type */
#define _URTSUD_DEFAULT_SIGS _URTSUD_BSD43_SIGS
#endif

/* Path input parse types */
#define _URTSUD_PATH_IN_BOTH	0
#define _URTSUD_PATH_IN_UNIX	1
#define _URTSUD_PATH_IN_NATIVE	2
#ifndef _URTSUD_DEFAULT_PATH_IN
#define _URTSUD_DEFAULT_PATH_IN _URTSUD_PATH_IN_BOTH
#endif

/* Path output parse types */
#define _URTSUD_PATH_OUT_UNIX	0
#define _URTSUD_PATH_OUT_NATIVE	1
#ifndef _URTSUD_DEFAULT_PATH_OUT
#define _URTSUD_DEFAULT_PATH_OUT _URTSUD_PATH_OUT_UNIX
#endif

/* How to handle chdir() */
#define _URTSUD_CHDIR_SOFT	0
#define _URTSUD_CHDIR_CONNECT	1
#ifndef _URTSUD_DEFAULT_CHDIR
#define _URTSUD_DEFAULT_CHDIR _URTSUD_CHDIR_SOFT
#endif

/* Finally, define structure if requested, or declare a reference. */
#ifdef _URTSUD
struct _urtsud _urtsud = {
	_URTSUD_DEFAULT_PARSE,
	_URTSUD_DEFAULT_SIGS,
	_URTSUD_DEFAULT_PATH_IN,
	_URTSUD_DEFAULT_PATH_OUT,
	_URTSUD_DEFAULT_CHDIR
};
#else
extern struct _urtsud _urtsud;
#endif
