/* <PRINTF.H> - definitions for user access to printf internals
**
**	(c) Copyright Ken Harrenstien 1989
**
**	This is an invention for KCC and does not exist elsewhere, although
**	it is portable to other implementations.
*/

#ifndef _PRINTF_INCLUDED
#define _PRINTF_INCLUDED

#pragma private define prf_bind _prfbind	/* Hide routine if not wanted */

struct pf_work {		/* Workspace for printf(): */
	FILE *pfw_fp;		/* Output stream */
	va_list pfw_argp;	/* Pointer to arg list */
	int pfw_char;		/* Conversion char */
	int pfw_fwid;		/* Field width (0 = none, < 0 = left adj) */
	int pfw_prec;		/* Precision ( < 0 = none) */
	int pfw_fill;		/* Fill character to use */
	int pfw_flag;		/* Flags (see PFF_ defs) */
	int pfw_cnt;		/* Count of # chars output */
};

#define PFF_NEG	01	/* '-' - Left-justify in field (else right-justify) */
#define PFF_POS 02	/* '+' - Always produce a sign, either '+' or '-' */
#define PFF_ZER 04	/* '0' - Use '0' for pad char, else space */
#define PFF_SPA 010	/* ' ' - Always produce either '-' or a space */
#define PFF_ALT 020	/* '#' - Alternate-form conversion */
#define PFF_LONG 040	/* 'l' - Long int modifier seen */
#define PFF_FLONG 0100	/* 'L' - Long double modifier seen */
#define PFF_SHORT 0200	/* 'h' - Short int modifier seen */

#endif /* ifndef _PRINTF_INCLUDED */
