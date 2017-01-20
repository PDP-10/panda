/* <C-ENV.H> - KCC C Environment definitions
**
**	(c) Copyright Ken Harrenstien 1989
**
*************************************************************
**	ALL C library routines include this file
**	for any system/configuration definitions.
**
**	For portability, user programs should ideally never need this,
**	but when dependencies are unavoidable they are encouraged to
**	include this file.
***************************************************************
*/

/*** BEG of site-specific definitions ***/
	/* Any site-specific defs should be inserted here, so as to avoid
	** messing with the default definition code on the following pages.
	*/
/*** END of site-specific definitions ***/

/* SYSTEM specification: (prefix with SYS_)
 *	Define only one of the following to be 1.
 */
#ifndef SYS_T20
#define SYS_T20 0	/* DEC TOPS-20 system */
#endif
#ifndef SYS_10X
#define SYS_10X 0	/* BBN TENEX system */
#endif
#ifndef SYS_T10
#define SYS_T10 0	/* DEC TOPS-10 system */
#endif
#ifndef SYS_CSI
#define SYS_CSI 0	/* CompuServe Inc. T10-based system */
#endif
#ifndef SYS_WTS
#define SYS_WTS 0	/* Stanford WAITS T10-based system */
#endif
#ifndef SYS_ITS
#define SYS_ITS 0	/* MIT ITS system */
#endif
#ifndef SYS_BSD		/* BSD Unix system */
#define SYS_BSD	0
#endif
#ifndef SYS_SUN		/* SUN Unix system */
#define SYS_SUN	0
#endif
#ifndef SYS_SYSV	/* System V Unix */
#define SYS_SYSV 0
#endif
#ifndef SYS_V7		/* Another Unix thing */
#define SYS_V7 0
#endif
#ifndef SYS_MSDOS	/* gross MSDOS!!  gross gross */
#define SYS_MSDOS 0
#endif

/* Assign default if none of the above were furnished */
#if (SYS_T20+SYS_10X+SYS_T10+SYS_CSI+SYS_WTS+SYS_ITS \
	+SYS_BSD+SYS_SUN+SYS_SYSV+SYS_V7 \
	+SYS_MSDOS)==0
#undef SYS_T20
#define SYS_T20 1	/* Default is T20 */
#endif

#define SYS_UNIX	(SYS_BSD+SYS_SUN+SYS_SYSV+SYS_V7)

/* PROCESSOR specification: (prefix with CPU_)
 *	Define only one of the following to be 1.
 */

#ifndef CPU_KA
#define CPU_KA 0	/* DEC KA-10 */
#endif
#ifndef CPU_KI
#define CPU_KI 0	/* DEC KI-10 */
#endif
#ifndef CPU_KS
#define CPU_KS 0	/* DEC KS-10 (2020) or KL-10 (single section) */
#endif
#ifndef CPU_KL0
#define CPU_KL0 0	/* DEC KL-10 (extended, section 0) */
#endif
#ifndef CPU_KLX
#define CPU_KLX 0	/* DEC KL-10 (extended, non-zero section) */
#endif
#ifndef CPU_PDP11
#define CPU_PDP11 0	/* DEC PDP-11 series */
#endif
#ifndef CPU_VAX
#define CPU_VAX 0	/* VAX-11 series */
#endif
#ifndef CPU_M68
#define CPU_M68 0	/* MC68000 series */
#endif


/* Assign default if none of above are specified */
#if (CPU_KA+CPU_KI+CPU_KS+CPU_KL0+CPU_KLX \
	+CPU_PDP11+CPU_VAX+CPU_M68)==0
#undef CPU_KL0
#define CPU_KL0 1	/* Default is section 0 of extended KL-10 */
#endif

/* CPU_KL is true if processor is some kind of DEC PDP-10 KL */
#define CPU_KL (CPU_KS|CPU_KL0|CPU_KLX)

/* CPU_PDP10 is true if processor is any kind of DEC PDP-10 */
#define CPU_PDP10 (CPU_KA+CPU_KI+CPU_KL)


/* COMPILER specification: (prefix with COMPILER_)
 *	Define only one of the following to be 1.
 */

#ifdef __COMPILER_KCC__
#define COMPILER_KCC 1	/* KCC - PDP-10 only, Stanford/SRI */
#else
#define COMPILER_KCC 0
#endif

/* Assign default if none of above are specified */
	/* Nothing here at moment -- anything else is unspecified. */

/* Data Type parameters: (prefix with CENV_)
**	These should eventually be superseded by the new ANSI
**	header files <limits.h> and <float.h>.
*/
#define CENV_MAXCHAR (0777)		/* Max char value */

/* Other parameters: (prefix with CENV_) */

/* PDP-10 Hardware defs (used with #asm) */
#ifndef CENV_DMOVX
#define CENV_DMOVX (CPU_KI+CPU_KL)	/* Has DMOVx instructions */
#endif
#ifndef CENV_ADJSP
#define CENV_ADJSP (CPU_KL)		/* Has ADJSP instruction */
#endif
#ifndef CENV_ADJBP
#define CENV_ADJBP (CPU_KL)		/* Has ADJBP instruction */
#endif
#ifndef CENV_DFL_S
#define CENV_DFL_S (CPU_KA)		/* Use Software double prec fmt */
#endif
#ifndef CENV_DFL_H
#define CENV_DFL_H (CPU_KI+CPU_KL)	/* Use Hardware double prec fmt */
#endif
#ifndef CENV_DFL_G
#define CENV_DFL_G 0			/* Use "G" extended double prec fmt */
#endif
#ifndef CENV_EXADR
#define CENV_EXADR (CPU_KLX)		/* Has extended addressing */
#endif
