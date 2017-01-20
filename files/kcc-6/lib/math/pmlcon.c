/* PMLCON.C - Internal Portable Math Library constants
**
**	(c) Copyright Ken Harrenstien 1989
**
** Because the values defined in "pml.h" are impossible to express precisely
** as lexical constants, a data file is necessary.  Note that because
** union initialization cannot be done by pre-ANSI KCC, we have to use
** "type punning" across module boundaries -- "pml.h" has a different notion
** of what the pmlcon structure contains, and the two definitions must be
** carefully coordinated.
*/

#include <c-env.h>	/* Get site-dependent info */
#include <limits.h>

#if CPU_PDP10	/* Define initialization values.  All must be normalized! */

#if CENV_DFL_H	/* PDP-10 Hardware format doubles */
#define PDBL_RECIP_MIN (02<<27) + (1<<26), 1
		/* 1.0/X produces DBL_MAX-1
		** Value-1 produces DBL_MAX+1 (overflows, == DBL_MIN)
		*/
#define PDBL_RECIP_MAX	INT_MAX, INT_MAX		/* Same as DBL_MAX */
#define PDBL_TANH_MAXARG ((128+5)<<27) + (1<<26), 0	/* 16.0 */
#define PDBL_X6_UNDERFLOW 0153552023631, 0237635714441	/* ~ 3.37174E-7 */
#define PDBL_X16_UNDERFLOW  0170752225750, 0251110331414
						/* 3.7406378152288033102E-3 */
#define PDBL_LN_MAXPDF	0207540<<18, 0		/* 88.0  (w/ safety margin) */
#define PDBL_LN_MINPDF	0570232400000, 0		/* -89.375 ( " ) */

#elif CENV_DFL_S /* Software format doubles (KA-10) */
#define PDBL_RECIP_MIN	/* ?? */
#define PDBL_RECIP_MAX	/* ?? */
#define PDBL_TANH_MAXARG	/* ?? */
#define PDBL_X6_UNDERFLOW	/* ?? */
#define PDBL_X16_UNDERFLOW	/* ?? */
#define PDBL_LN_MAXPDF	/* ?? */
#define PDBL_LN_MINPDF	/* ?? */
#endif

struct pmlcon {
    int recip_min[2];
    int recip_max[2];
    int ln_maxpdf[2];
    int ln_minpdf[2];
    int tanh_maxarg[2];
    int x6_underflow[2];
    int x16_underflow[2];
} _pmlcon = {
	{ PDBL_RECIP_MIN },	/* DBL_MAX >= 1/X	*/
	{ PDBL_RECIP_MAX },	/* DBL_MIN <= 1/X	*/
	{ PDBL_LN_MAXPDF },	/* LN(DBL_MAX)		*/
	{ PDBL_LN_MINPDF },	/* LN(DBL_MIN)		*/
	{ PDBL_TANH_MAXARG },	/* |TANH(maxarg)| = 1.0		*/
	{ PDBL_X6_UNDERFLOW },	/* X**6 almost underflows	*/
	{ PDBL_X16_UNDERFLOW }	/* X**16 almost underflows	*/
};
#endif /* CPU_PDP10 */
