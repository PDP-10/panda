/* <TIMEX.H> - Extended Time Function declarations
**
**	(c) Copyright Ken Harrenstien 1989
**	(c) Copyright Ken Harrenstien, SRI International 1980, 1987
**
**	These declarations more suitably belong in <time.h> but are
**	kept separate for portability.  Someday the standard time/date
**	library routines may provide the same functionality.
*/

#ifndef _TIMEX_INCLUDED		/* Include only once */
#define _TIMEX_INCLUDED

#include <time.h>		/* Ensure standard stuff included */

/* Timezone structure (for portability among different systems) */
struct tmz {
	long tmz_secwest;	/* Secs west of GMT (-12/+12 hrs) */
	int  tmz_minwest;	/* Same, in mins. (tmz_secwest/60) */
	int tmz_dsttype;	/* DST type if any */
	char *tmz_name;		/* Standard timezone name */
	char *tmz_dname;	/* DST timezone name (if any) */
};

/* Extended time/date structure for use by time manipulating subroutines. */
struct tmx {
	struct tm tm;		/* Standard time structure */
	struct tmz tmz;		/* Timezone structure */
	char *tmx_err;		/* Pointer to error message if non-NULL */
	int tmx_flags;		/* Flags for possible future uses */
};

#define TMX_NULL (-1)	/* Items not specified are given this value
			 * in order to distinguish null specs from zero
			 * specs.  This is only used by time_parse and
			 * time_make. */
#define TMX_WILD (-2)	/* Value meaning item specified as wild-card */
			/* (Not used now, but maybe someday...) */


/* Function declarations */
#if defined(__STDC__) || defined(__cplusplus)
# define P_(s) s
#else
# define P_(s) ()
#endif

/* cuser:timepa.c */
extern int time_parse P_((const char *astr,struct tmx *tp,char **endptr));

/* cuser:timemk.c */
extern time_t time_make P_((struct tmx *tp));

/* cuser:timezn.c */
extern int time_lzone P_((struct tmz *zp));
extern struct tmz *time_tzset P_((void));

#undef P_

#endif /* ifndef _TIMEX_INCLUDED */

