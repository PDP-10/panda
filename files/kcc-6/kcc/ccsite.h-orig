/*	CCSITE.H - Site-dependent declarations for KCC
**
**	(c) Copyright Ken Harrenstien 1989
**		All changes after v.14, 18-Feb-1987
**	(c) Copyright Ken Harrenstien, SRI International 1985, 1986
*/

/* BEG of site-specific defines */
	/* Any site-dependent definitions which are different from
	** the standard defaults provided in this file should be
	** inserted here.
	*/
/* END of site-specific defines */

#include "c-env.h"		/* Get OS defs locally, not from <c-env.h> */

#if (SYS_T20|SYS_10X|SYS_T10|SYS_CSI|SYS_WTS|SYS_ITS)==0
#error KCC cannot run on this system!
#endif

/* Ensure all definitions are set to some default value if not already
** specifically defined.
*/

/* Separator char for prefix/suffix filename components in KCC switches */
#ifndef FILE_FIX_SEP_CHAR
#define FILE_FIX_SEP_CHAR '+'
#endif

/* Define KCC standard Header File location (prefix and suffix strings)
** This is used to search for all <> include files, as well
** as the Assembler Header file.
*/
#ifdef SWI_HFPATH		/* Define path for standard header dir */
#elif SYS_T20
#define SWI_HFPATH "C:"
#elif SYS_10X
#define SWI_HFPATH "<C>"
#elif SYS_ITS
#define SWI_HFPATH "KC;"
#elif SYS_WTS
#define SWI_HFPATH "+[INC,KCC]"
#elif SYS_T10
#define SWI_HFPATH "C:"
#elif SYS_CSI
#define SWI_HFPATH "C:", "ALL:[1,17]"
#else
#define SWI_HFPATH NULL
#endif

#ifdef SWI_HFSYPATH		/* Default path for <sys/ > files */
#elif SYS_10X
#define SWI_HFSYPATH "<CSYS>"
#elif SYS_WTS
#define SWI_HFSYPATH "+[INS,KCC]"
#elif SYS_T10
#define SWI_HFSYPATH "CSYS:"
#elif SYS_CSI
#define SWI_HFSYPATH "CSYS:", "ALL:[1,16]"
#else
#define SWI_HFSYPATH NULL
#endif

/* KCC Library file path definitions
**	Same principle as for the header file location.
*/
#ifdef SWI_LIBPATH		/* Define library file prefix */
#elif SYS_T20
#define SWI_LIBPATH "C:LIB+.REL"
#elif SYS_10X
#define SWI_LIBPATH "<C>LIB+.REL"
#elif SYS_ITS
#define SWI_LIBPATH "KC;LIB+ REL"
#elif SYS_WTS
#define SWI_LIBPATH "LIB+.REL[INC,KCC]"
#elif SYS_T10
#define SWI_LIBPATH "C:LIB+.REL"
#elif SYS_CSI
#define SWI_LIBPATH "SYS:LIB+.REL"  /* Moved library to SYS: -KAR */
#else
#error Library file location must be specified for system.
#endif


#ifdef SWI_TGASM		/* Specify default assembler */
#elif SYS_T10+SYS_CSI
#define SWI_TGASM TGASM_MACRO
#else
#define SWI_TGASM TGASM_FAIL
#endif

#ifndef SWI_CLEV		/* Specify default C implem level */
#define SWI_CLEV CLEV_STDC	/* Default: STDC!!!  Yay! */
#endif

#ifdef SWI_TGCPUS		/* Specify default target CPUs */
#elif SYS_10X+SYS_ITS+SYS_T10+SYS_WTS+SYS_CSI
	/* Most systems don't permit extended addressing. */
#define SWI_TGCPUS { CPU_KA, CPU_KI, CPU_KL, CPU_KL, CPU_KLX }
#else	/* Default is to set values from source c-env.h.  Basically, if
	** we are running on a specific CPU, we should compile for that CPU.
	** An exception is CPU_KL (any kind of KL) which causes compiling
	** code which can run on any kind of KL (KS, KL0, KLX).
	*/
#define SWI_TGCPUS { CPU_KA, CPU_KI, CPU_KL, CPU_KL, CPU_KL }
#endif

#ifdef SWI_TGSYS		/* Specify default target system */
#elif SYS_T20
#define SWI_TGSYS TGSYS_TOPS20
#elif SYS_T10+SYS_CSI
#define SWI_TGSYS TGSYS_TOPS10
#elif SYS_10X
#define SWI_TGSYS TGSYS_TENEX
#elif SYS_WTS
#define SWI_TGSYS TGSYS_WAITS
#elif SYS_ITS
#define SWI_TGSYS TGSYS_ITS
#else
#define SWI_TGSYS TGSYS_NULL
#endif

#ifndef SWI_ASMHFILE		/* ASM header file location, normally this */
#define SWI_ASMHFILE NULL	/* should be 0 to have KCC generate header. */
#endif

/* The following should eventually be flushed when library tmpfile() works. */
#ifndef SWI_ASMTFILE		/* Specify #asm temporary file name */
#if SYS_T20+SYS_10X
#define SWI_ASMTFILE "ASMTMP.TMP;T"
#else
#define SWI_ASMTFILE "ASMTMP.TMP"
#endif
#endif

/* Loader psect default specifications */
#ifndef PSDATA_BEG	/* Start of data area */
#define PSDATA_BEG 01000
#endif

#ifndef PSCODE_BEG	/* Start of code (text) area */
#define PSCODE_BEG 0400000
#endif

#ifndef PSCODE_END	/* Upper limit of code area (+1) */
#if SYS_T10+SYS_CSI+SYS_WTS
#define PSCODE_END 0700000	/* VMDDT starts at page 700 */
#elif SYS_T20+SYS_10X
#define	PSCODE_END 0765000	/* UDDT vars start at page 770-2 */
#elif SYS_ITS
#define	PSCODE_END 01000000	/* ITS has HACTRN, needs no crufty DDT */
#endif
#endif
