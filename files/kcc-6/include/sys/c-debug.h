/* Default to debugging on for now */
#ifndef _SYS_C_DEBUG_H_
#define _SYS_C_DEBUG_H_

#ifndef NODEBUG
#define _KCC_DEBUG
#endif

/* Debug flags */
extern int `$DEBUG`;

/* Heritage string */
extern char *`$HERIT`;

/* Debugging flags */

/* Parse.c */
#define _KCC_DEBUG_PARSE_RES (1<<0)	/* Print successful path */
#define _KCC_DEBUG_PARSE_INP (1<<1)	/* Print input path */
#define _KCC_DEBUG_PARSE_PAR (1<<2)	/* Print parse values */
#define _KCC_DEBUG_PARSE_TRY (1<<3)	/* Print intermediate paths tried */
#define _KCC_DEBUG_PARSE_EXP (1<<4)	/* Print logical name expansion */
#define _KCC_DEBUG_FORK_CREATE (1<<5)	/* Debug fork creation */
#define _KCC_DEBUG_UIO_FDSHR (1<<6)	/* Debug FD sharing */
#define _KCC_DEBUG_FORK_EXEC (1<<7)	/* Debug exec file determination */
#define _KCC_DEBUG_FORK_ENV (1<<8) 	/* Debug environment passing */
#define _KCC_DEBUG_INET (1<<9)		/* Debug internet routines */
#define _KCC_DEBUG_MALLOC (1<<10)	/* Debug malloc routines */

#define _KCC_DEBUG_CORE_DUMP (1<<35)	/* Debug, write core dump file */

/* Debug routines from debug.c */

#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* debug.c */
extern void _dbgs P_((const char *str));
extern void _dbgd P_((long num));
extern void _dbgo P_((unsigned long num));
extern void _dbgdn P_((unsigned long dirno));
extern void _dbgj P_((unsigned long jfn));
extern void _dbgl P_((const char *label));

#undef P_

#endif /* _SYS_C_DEBUG_H_ */
