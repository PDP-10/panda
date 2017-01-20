/* <JSYS.H> - Define TOPS-20/TENEX JSYS symbols.
**
**	(c) Copyright Ken Harrenstien 1989
**
** This special file is needed to define the JSYS symbols (instead of simply
** using their values from MONSYM.UNV) because certain flag bits must be
** associated with them so that the C library's jsys() routine can know how
** to invoke them properly.
** 
** For definitions of all other monitor symbols, use <monsym.h>.
**
** For the time being, this file also defines a selection of miscellaneous
** symbols; they are used to support KCC and the C library, and will
** eventually be flushed in favor of monsym().  Try not to use them.
** Until they are flushed, programs can skip them completely by defining
** _JSYS_NOEXTRADEFS.  Sorry for the inconvenience.
*/

#ifndef _JSYS_INCLUDED
#define _JSYS_INCLUDED

#include <c-env.h>

#include <macsym.h>	/* Include handy macros & misc defs */
#include <monsym.h>	/* Get amazing monsym() macro */

#ifdef __STDC__
extern int jsys(int, int *);
#else
extern int jsys();
#endif

/* JSYS definitions, plus related bits, fields, etc.
 *	Each JSYS is defined by its JSYS# (in the RH) plus a class code,
 *	stored in the JSYS_CLASS field in the LH.
 *	JSYS_OKINT is a flag which can be added in a user call
 *	to jsys() which says the JSYS call is allowed to be interrupted
 *	by signals.
 *	For faster finding of the jsys you want,
 *	look for comments like *100*, *200*, etc.
 *
 *	The JSYS classes are:
 *
 *	class 0		jsys returns +1 always, generating an illegal
 *			instruction on error
 *	class 1		jsys returns +1 on error, +2 on win
 *	class 2		special class for ERSTR%
 *	class 3		special class for SIBE%, SOBE%, and SOBF%
 */

/* DO NOT CHANGE THESE 3 DEFINITIONS WITHOUT CHANGING THE JSYS() ROUTINE!
**	Note that the JSYS_xxx bits intentionally do not conflict with the
**	JSYS-instruction bits 104000,,0.  This avoids losing even more badly
**	than necessary if the programmer fails to use <jsys.h>.
*/
#define JSYS_CLASS	0070000000000
#define JSYS_OKINT	0400000000000
#define _DEFJS(name, class) (FLD(class, JSYS_CLASS) | (monsym(name)&0777777))

#define LOGIN	_DEFJS("LOGIN%", 1)
#define CRJOB	_DEFJS("CRJOB%", 1)
#define LGOUT	_DEFJS("LGOUT%", 1)
#define CACCT	_DEFJS("CACCT%", 1)
/* JSYS 5, EFACT%, not in monitor */
#define SMON	_DEFJS("SMON%", 0)
#define TMON	_DEFJS("TMON%", 0)
#define GETAB	_DEFJS("GETAB%", 1)
#define ERSTR	_DEFJS("ERSTR%", 2)
#define GETER	_DEFJS("GETER%", 0)
#define GJINF	_DEFJS("GJINF%", 0)
#define TIME	_DEFJS("TIME%", 0)
#define RUNTM	_DEFJS("RUNTM%", 0)
#define SYSGT	_DEFJS("SYSGT%", 0)
#define	GNJFN	_DEFJS("GNJFN%", 1)
#define GTJFN	_DEFJS("GTJFN%", 1)
#define OPENF	_DEFJS("OPENF%", 1)
#define CLOSF	_DEFJS("CLOSF%", 1)
#define RLJFN	_DEFJS("RLJFN%", 1)
#define GTSTS	_DEFJS("GTSTS%", 0)
#define STSTS	_DEFJS("STSTS%", 1)
#define DELF	_DEFJS("DELF%", 1)
#define SFPTR	_DEFJS("SFPTR%", 1)
#define	JFNS	_DEFJS("JFNS%", 0)
#define FFFFP	_DEFJS("FFFFP%", 0)
/* JSYS 32, RDDIR, obsolete
   JSYS 33, CPRTF, not in monitor */
#define CLZFF	_DEFJS("CLZFF%", 0)
#define RNAMF	_DEFJS("RNAMF%", 1)
#define SIZEF	_DEFJS("SIZEF%", 1)
#define GACTF	_DEFJS("GACTF%", 1)
/* JSYS 40, STDIR, obsolete */
#define DIRST	_DEFJS("DIRST%", 1)
#define BKJFN	_DEFJS("BKJFN%", 1)
#define RFPTR	_DEFJS("RFPTR%", 1)
/* JSYS 44, CNDIR, not in monitor */
#define RFBSZ	_DEFJS("RFBSZ%", 1)
#define SFBSZ	_DEFJS("SFBSZ%", 1)
#define SWJFN	_DEFJS("SWJFN%", 0)
#define BIN	_DEFJS("BIN%", 0)
#define BOUT	_DEFJS("BOUT%", 0)
#define SIN	_DEFJS("SIN%", 0)
#define SOUT	_DEFJS("SOUT%", 0)
#define RIN	_DEFJS("RIN%", 0)
#define ROUT	_DEFJS("ROUT%", 0)
#define PMAP	_DEFJS("PMAP%", 0)
#define RPACS	_DEFJS("RPACS%", 0)
#define SPACS	_DEFJS("SPACS%", 0)
#define RMAP	_DEFJS("RMAP%", 0)
#define SACTF	_DEFJS("SACTF%", 1)
#define GTFDB	_DEFJS("GTFDB%", 0)
#define CHFDB	_DEFJS("CHFDB%", 0)
#define DUMPI	_DEFJS("DUMPI%", 1)
#define DUMPO	_DEFJS("DUMPO%", 1)
#define DELDF	_DEFJS("DELDF%", 0)
#define ASND	_DEFJS("ASND%", 1)
#define RELD	_DEFJS("RELD%", 1)
/* JSYS 72, CSYNO, not in monitor */
#define PBIN	_DEFJS("PBIN%", 0)
#define PBOUT	_DEFJS("PBOUT%", 0)
/* JSYS 75, PSIN, not in monitor */
#define PSOUT	_DEFJS("PSOUT%", 0)
#define MTOPR	_DEFJS("MTOPR%", 0)

/*   *100*   */

#define CFIBF	_DEFJS("CFIBF%", 0)
#define CFOBF	_DEFJS("CFOBF%", 0)
#define SIBE	_DEFJS("SIBE%", 3)
#define SOBE	_DEFJS("SOBE%", 3)
#define DOBE	_DEFJS("DOBE%", 0)
/* JSYS 105, GTABS, obsolete
   JSYS 106, STABS, obsolete */
#define RFMOD	_DEFJS("RFMOD%", 0)
#define SFMOD	_DEFJS("SFMOD%", 0)
#define RFPOS	_DEFJS("RFPOS%", 0)
#define	RFCOC	_DEFJS("RFCOC%", 0)
#define	SFCOC	_DEFJS("SFCOC%", 0)
#define STI	_DEFJS("STI%", 0)
#define DTACH	_DEFJS("DTACH%", 0)
#define ATACH	_DEFJS("ATACH%", 1)
#define DVCHR	_DEFJS("DVCHR%", 0)
#define STDEV	_DEFJS("STDEV%", 1)
#define DEVST	_DEFJS("DEVST%", 1)
/* JSYS 122, MOUNT, obsolete
   JSYS 123, DSMNT, obsolete
   JSYS 124, INIDR, obsolete */
#define SIR	_DEFJS("SIR%", 0)
#define EIR	_DEFJS("EIR%", 0)
#define SKPIR	_DEFJS("SKPIR%", 1)
#define DIR	_DEFJS("DIR%", 0)
#define AIC	_DEFJS("AIC%", 0)
#define IIC	_DEFJS("IIC%", 0)
#define DIC	_DEFJS("DIC%", 0)
#define RCM	_DEFJS("RCM%", 0)
#define RWM	_DEFJS("RWM%", 0)
#define DEBRK	_DEFJS("DEBRK%", 0)
#define ATI	_DEFJS("ATI%", 0)
#define DTI	_DEFJS("DTI%", 0)
#define CIS	_DEFJS("CIS%", 0)
#define SIRCM	_DEFJS("SIRCM%", 0)
#define RIRCM	_DEFJS("RIRCM%", 0)
#define RIR	_DEFJS("RIR%", 0)
#define GDSTS	_DEFJS("GDSTS%", 0)
#define SDSTS	_DEFJS("SDSTS%", 0)
#define RESET	_DEFJS("RESET%", 0)
#define RPCAP	_DEFJS("RPCAP%", 0)
#define EPCAP	_DEFJS("EPCAP%", 0)
#define CFORK	_DEFJS("CFORK%", 1)
#define KFORK	_DEFJS("KFORK%", 0)
#define FFORK	_DEFJS("FFORK%", 0)
#define RFORK	_DEFJS("RFORK%", 0)
#define RFSTS	_DEFJS("RFSTS%", 0)
#define SFORK	_DEFJS("SFORK%", 0)
#define SFACS	_DEFJS("SFACS%", 0)
#define RFACS	_DEFJS("RFACS%", 0)
#define HFORK	_DEFJS("HFORK%", 0)
#define WFORK	_DEFJS("WFORK%", 0)
#define GFRKH	_DEFJS("GFRKH%", 1)
#define RFRKH	_DEFJS("RFRKH%", 1)
#define GFRKS	_DEFJS("GFRKS%", 1)
#define DISMS	_DEFJS("DISMS%", 0)
#define HALTF	_DEFJS("HALTF%", 0)
#define GTRPW	_DEFJS("GTRPW%", 0)
#define GTRPI	_DEFJS("GTRPI%", 0)
#define RTIW	_DEFJS("RTIW%", 0)
#define STIW	_DEFJS("STIW%", 0)
#define SOBF	_DEFJS("SOBF%", 3)
#define RSWET	_DEFJS("RSWET%", 0)
#define GETNM	_DEFJS("GETNM%", 0)

/*   *200*   */

#define GET	_DEFJS("GET%", 0)
#define SFRKV	_DEFJS("SFRKV%", 0)
#define SAVE	_DEFJS("SAVE%", 0)
#define SSAVE	_DEFJS("SSAVE%", 0)
#define SEVEC	_DEFJS("SEVEC%", 0)
#define GEVEC	_DEFJS("GEVEC%", 0)
#define GPJFN	_DEFJS("GPJFN%", 0)
#define SPJFN	_DEFJS("SPJFN%", 0)
#define SETNM	_DEFJS("SETNM%", 0)
#define FFUFP	_DEFJS("FFUFP%", 1)
#define DIBE	_DEFJS("DIBE%", 0)
/* JSYS 213, FDFRE, obsolete */
#define GDSKC	_DEFJS("GDSKC%", 0)
/* JSYS 215, LITES, not in monitor */
#define TLINK	_DEFJS("TLINK%", 1)
#define STPAR	_DEFJS("STPAR%", 0)
#define	ODTIM	_DEFJS("ODTIM%", 0)
#define IDTIM	_DEFJS("IDTIM%", 1)
#define ODCNV	_DEFJS("ODCNV%", 0)
#define IDCNV	_DEFJS("IDCNV%", 1)
#define NOUT	_DEFJS("NOUT%", 1)
#define NIN	_DEFJS("NIN%", 1)
#define STAD	_DEFJS("STAD%", 1)
#define GTAD	_DEFJS("GTAD%", 0)
#define ODTNC	_DEFJS("ODTNC%", 0)
#define IDTNC	_DEFJS("IDTNC%", 1)
#define FLIN	_DEFJS("FLIN%", 1)
#define FLOUT	_DEFJS("FLOUT%", 1)
#define DFIN	_DEFJS("DFIN%", 1)
#define DFOUT	_DEFJS("DFOUT%", 1)
/* no jsys' 236, 237 */
#define CRDIR	_DEFJS("CRDIR%", 0)
#define GTDIR	_DEFJS("GTDIR%", 0)
#define DSKOP	_DEFJS("DSKOP%", 0)
#define SPRIW	_DEFJS("SPRIW%", 0)
#define DSKAS	_DEFJS("DSKAS%", 1)
#define SJPRI	_DEFJS("SJPRI%", 0)
#define STO	_DEFJS("STO%", 0)
#define ARCF	_DEFJS("ARCF%", 0)
/* no jsys' 250-257
   JSYS 260, ASNDP, not in monitor
   JSYS 261, RELDP, not in monitor
   JSYS 262, ASNDC, not in monitor
   JSYS 263, RELDC, not in monitor
   JSYS 264, STRDP, not in monitor
   JSYS 265, STPDP, not in monitor
   JSYS 266, STSDP, not in monitor
   JSYS 267, RDSDP, not in monitor
   JSYS 270, WATDP, not in monitor
   no jsys 271
   JSYS 272, GTNCP, not in monitor */
#define GTHST	_DEFJS("GTHST%", 1)
#define ATNVT	_DEFJS("ATNVT%", 1)
/* JSYS 275, CVSKT, pup, not in monitor */
#define CVHST	_DEFJS("CVHST%", 1)
/* JSYS 277, FLHST, not in monitor */

/*   *300*   */

#define GCVEC	_DEFJS("GCVEC%", 0)
#define SCVEC	_DEFJS("SCVEC%", 0)
#define STTYP	_DEFJS("STTYP%", 0)
#define GTTYP	_DEFJS("GTTYP%", 0)
/* JSYS 304, BPT, obsolete */
#define GTDAL	_DEFJS("GTDAL%", 0)
#define WAIT	_DEFJS("WAIT%", 0)
#define HSYS	_DEFJS("HSYS%", 1)
#define USRIO	_DEFJS("USRIO%", 1)
#define PEEK	_DEFJS("PEEK%", 1)
#define MSFRK	_DEFJS("MSFRK%", 0)
#define ESOUT	_DEFJS("ESOUT%", 0)
#define SPLFK	_DEFJS("SPLFK%", 1)
/* JSYS 315, ADVIS, not in monitor
   JSYS 316, JOBTM, not in monitor */
#define DELNF	_DEFJS("DELNF%", 1)
/* JSYS 320, SWTCH, obsolete */
#define TFORK	_DEFJS("TFORK%", 0)
#define RTFRK	_DEFJS("RTFRK%", 0)
#define UTFRK	_DEFJS("UTFRK%", 0)
#define SCTTY	_DEFJS("SCTTY%", 0)
/* no jsys 325
   JSYS 326, OPRFN, obsolete
   no JSYS' 327-335
   JSYS 336, SETR, obsolete
   no JSYS' 337-377 */

/*   *400*   */

#define PUPI	_DEFJS("PUPI%", 0)	/* pup only.  class? */
#define PUPO	_DEFJS("PUPO%", 0)
#define PUPNM	_DEFJS("PUPNM%", 0)

/*   *500*   */

#define RSCAN	_DEFJS("RSCAN%", 1)
#define HPTIM	_DEFJS("HPTIM%", 1)
#define CRLNM	_DEFJS("CRLNM%", 1)
#define INLNM	_DEFJS("INLNM%", 1)
#define LNMST	_DEFJS("LNMST%", 1)
#define RDTXT	_DEFJS("RDTXT%", 1)
#define SETSN	_DEFJS("SETSN%", 1)
#define GETJI	_DEFJS("GETJI%", 1)
#define MSEND	_DEFJS("MSEND%", 1)
#define MRECV	_DEFJS("MRECV%", 1)
#define MUTIL	_DEFJS("MUTIL%", 1)
#define ENQ	_DEFJS("ENQ%", 1)
#define DEQ	_DEFJS("DEQ%", 1)
#define ENQC	_DEFJS("ENQC%", 1)
#define SNOOP	_DEFJS("SNOOP%", 1)
#define SPOOL	_DEFJS("SPOOL%", 1)
#define ALLOC	_DEFJS("ALLOC%", 1)
#define CHKAC	_DEFJS("CHKAC%", 1)
#define TIMER	_DEFJS("TIMER%", 1)
#define RDTTY	_DEFJS("RDTTY%", 1)
#define TEXTI	_DEFJS("TEXTI%", 1)
#define UFPGS	_DEFJS("UFPGS%", 1)
#define SFPOS	_DEFJS("SFPOS%", 0)
#define SYERR	_DEFJS("SYERR%", 0)
#define DIAG	_DEFJS("DIAG%", 1)
#define SINR	_DEFJS("SINR%", 0)
#define SOUTR	_DEFJS("SOUTR%", 0)
#define RFTAD	_DEFJS("RFTAD%", 0)
#define SFTAD	_DEFJS("SFTAD%", 0)
#define TBDEL	_DEFJS("TBDEL%", 0)
#define TBADD	_DEFJS("TBADD%", 0)
#define TBLUK	_DEFJS("TBLUK%", 0)
#define STCMP	_DEFJS("STCMP%", 0)
#define SETJB	_DEFJS("SETJB%", 0)
#define GDVEC	_DEFJS("GDVEC%", 0)
#define SDVEC	_DEFJS("SDVEC%", 0)
#define COMND	_DEFJS("COMND%", 0)
#define PRARG	_DEFJS("PRARG%", 0)
#define GACCT	_DEFJS("GACCT%", 0)
#define LPINI	_DEFJS("LPINI%", 0)
#define GFUST	_DEFJS("GFUST%", 0)
#define SFUST	_DEFJS("SFUST%", 0)
#define ACCES	_DEFJS("ACCES%", 0)
#define RCDIR	_DEFJS("RCDIR%", 0)
#define RCUSR	_DEFJS("RCUSR%", 0)
#define MSTR	_DEFJS("MSTR%", 0)
#define STPPN	_DEFJS("STPPN%", 0)
#define PPNST	_DEFJS("PPNST%", 0)
#define PMCTL	_DEFJS("PMCTL%", 0)
#define PLOCK	_DEFJS("PLOCK%", 0)
#define BOOT	_DEFJS("BOOT%", 0)
#define UTEST	_DEFJS("UTEST%", 0)
#define USAGE	_DEFJS("USAGE%", 0)
#define WILD	_DEFJS("WILD%", 0)
#define VACCT	_DEFJS("VACCT%", 0)
#define NODE	_DEFJS("NODE%", 0)
#define ADBRK	_DEFJS("ADBRK%", 0)
/* JSYS 571, SINM, undefined if no ATS support
   JSYS 572, SOUTM, ditto */
#define SWTRP	_DEFJS("SWTRP%", 0)
#define GETOK	_DEFJS("GETOK%", 0)
#define RCVOK	_DEFJS("RCVOK%", 0)
#define GIVOK	_DEFJS("GIVOK%", 0)
#define SKED	_DEFJS("SKED%", 0)

/*   *600*    */

#define MTU	_DEFJS("MTU%", 0)
#define XRIR	_DEFJS("XRIR%", 0)
#define XSIR	_DEFJS("XSIR%", 0)
#define PDVOP	_DEFJS("PDVOP%", 0)
#define NTMAN	_DEFJS("NTMAN%", 0)
#define XSFRK	_DEFJS("XSFRK%", 0)
#define XGVEC	_DEFJS("XGVEC%", 0)
#define XSVEC	_DEFJS("XSVEC%", 0)
#define RSMAP	_DEFJS("RSMAP%", 0)
#define XRMAP	_DEFJS("XRMAP%", 0)
#define XGTPW	_DEFJS("XGTPW%", 0)
#define XSSEV	_DEFJS("XSSEV%", 0)
#define XGSEV	_DEFJS("XGSEV%", 0)
#define QUEUE	_DEFJS("QUEUE%", 0)
/* JSYS 616, DYNLB DYNamic LiBrary.  Huh?
   JSYS 617, CTSOP, Canonical Terminal Support OPeration.  Huh?
   JSYS 620, DAP, 6.0 Data Access Protocol.  Huh?
   no JSYS 621 */
#define SCS	_DEFJS("SCS%", 0)
#define WSMGR	_DEFJS("WSMGR%", 0)
#define LLMOP	_DEFJS("LLMOP%", 0)
/* JSYS 625, APCON, not in monitor */
#define XPEEK	_DEFJS("XPEEK%", 0)
/* JSYS 627, CNFIG, huh? */
#define NI	_DEFJS("NI%", 0)
#define LATOP	_DEFJS("LATOP%", 0)
#define NTINF	_DEFJS("NTINF%", 0)
/* no JSYS 633
   JSYS 634, GTBLT, MIT multiple GETAB
   no JSYS' 635-677 */

/*   *700*   */

#define HANDS	_DEFJS("HANDS%", 0)	/* class? */
#define IDLE	_DEFJS("IDLE%", 0)	/* class? */
/* JSYS 702, GTWAA, LOTS thing
   JSYS 703, PKOPR, more stanford
*/
#define CRYPT	_DEFJS("CRYPT%", 0)
/* no JSYS' 705-716 */
#define MONRD	_DEFJS("MONRD%", 0)	/* class? */
#define DBGRD	_DEFJS("DBGRD%", 0)	/* more MONRD.  class? */
/* no JSYS' 721-737 */
#define SEND	_DEFJS("SEND%", 1)
#define RECV	_DEFJS("RECV%", 1)
#define OPEN	_DEFJS("OPEN%", 1)
#define CLOSE	_DEFJS("CLOSE%", 1)
#define SCSLV	_DEFJS("SCSLV%", 1)
#define STAT	_DEFJS("STAT%", 1)
#define CHANL	_DEFJS("CHANL%", 1)
#define ABORT	_DEFJS("ABORT%", 1)
#define SNDIM	_DEFJS("SNDIM%", 1)
#define RCVIM	_DEFJS("RCVIM%", 1)
#define ASNSQ	_DEFJS("ASNSQ%", 1)
#define RELSQ	_DEFJS("RELSQ%", 0)
#define SNDIN	_DEFJS("SNDIN%", 1)
#define RCVIN	_DEFJS("RCVIN%", 1)
#define ASNIQ	_DEFJS("ASNIQ%", 1)
#define RELIQ	_DEFJS("RELIQ%", 1)
#define IPOPR	_DEFJS("IPOPR%", 0)
#define TCOPR	_DEFJS("TCOPR%", 0)
/* no JSYS' 762-764 */
#define GTDOM	_DEFJS("GTDOM%", 1)
#define METER	_DEFJS("METER%", 0)
#define SMAP	_DEFJS("SMAP%", 0)
#define THIBR	_DEFJS("THIBR%", 1)
#define TWAKE	_DEFJS("TWAKE%", 1)
/* JSYS 772, MRPAC, huh?
   JSYS 773, SETPV, not in monitor */
#define MTALN	_DEFJS("MTALN%", 0)
#define TTMSG	_DEFJS("TTMSG%", 0)
/* no JSYS 776 */
#define MDDT	_DEFJS("MDDT%", 0)

/* General-purpose MONSYM definitions, mainly for C library.
** For now, always include this cruft unless the program explicitly
** requests exclusion, by defining _JSYS_NOEXTRADEFS.  Sigh.
*/

#ifndef _JSYS_NOEXTRADEFS

#ifndef RH
#define RH       0777777
#define LH 0777777000000
#endif

#define T20_BIT(n) (1<<(35-(n)))	/* Same as macsym.h's BIT(n) */

/* I/O designators */
#define _PRIIN monsym(".PRIIN")		/* primary input */
#define _PRIOU monsym(".PRIOU")		/* primary output */
#define _CTTRM monsym(".CTTRM")		/* controlling terminal */

/* Fork Handles */
#define _FHSLF monsym(".FHSLF")		/* "self" process handle */
#define _FHSUP monsym(".FHSUP")		/* Superior process handle */
#define _FHTOP monsym(".FHTOP")		/* Top process in structure */
#define _FHINF monsym(".FHINF")		/* All inferiors of current process */

/* JFN mode word stuff */

#define TT_TAB	monsym("TT%TAB")
#define TT_LEN	monsym("TT%LEN")	/* length */
#define TT_LEN_S	25	/* shift (obsolete, replace by FLDGET!) */
#define TT_WID	monsym("TT%WID")	/* width */
#define TT_WID_S	18	/* shift (obsolete, replace by FLDGET!) */
#define TT_WAK	monsym("TT%WAK")
#define	TT_ECO	monsym("TT%ECO")
#define	TT_DAM	monsym("TT%DAM")
#define _TTBIN	monsym(".TTBIN")
#define _TTASC	monsym(".TTASC")
#define _TTATO	monsym(".TTATO")
#define _TTATE	monsym(".TTATE")
#define	TT_PGM	monsym("TT%PGM")

/*
 *	FDB stuff
 */

#define	_FBCTL	monsym(".FBCTL")
#define   FB_NXF	monsym("FB%NXF")
#define	  FB_DIR	monsym("FB%DIR")
#define   FB_WNC	monsym("FB%WNC")
#define	_FBBYV	monsym(".FBBYV")
#define	  FBBSZ_S	-24	/* Obsolete, replace by FLDGET! */
#define	  FBBSZ_M	077	/* ditto */
#define	_FBADR	monsym(".FBADR")
#define	_FBPRT	monsym(".FBPRT")
#define	_FBCRE	monsym(".FBCRE")
#define	_FBUSE	monsym(".FBUSE")	/* 10X */
#define	_FBGEN	monsym(".FBGEN")
#define	_FBSIZ	monsym(".FBSIZ")
#define	_FBCRV	monsym(".FBCRV")
#define	_FBWRT	monsym(".FBWRT")
#define	_FBREF	monsym(".FBREF")
#define	_FBBBT	monsym(".FBBBT")
#define	_FBLEN	monsym(".FBLEN")

/* IPCF stuff */

#define _IPCFL	monsym(".IPCFL")
#define	    IP_CFB	monsym("IP%CFB")
#define	    IP_CFS	monsym("IP%CFS")
#define	    IP_CFR	monsym("IP%CFR")
#define	    IP_CFO	monsym("IP%CFO")
#define	    IP_TTL	monsym("IP%TTL")
#define	    IP_CPD	monsym("IP%CPD")
#define	    IP_JWP	monsym("IP%JWP")
#define	    IP_NOA	monsym("IP%NOA")
#define	    IP_CFP	monsym("IP%CFP")
#define	    IP_CFV	monsym("IP%CFV")
#define     IP_INT	monsym("IP%INT")
#define	    IP_CFZ	monsym("IP%CFZ")
#define	    IP_EPN	monsym("IP%EPN")
#define _IPCFS	monsym(".IPCFS")
#define _IPCFR	monsym(".IPCFR")
#define _IPCFP	monsym(".IPCFP")
#define   IP_CFE	monsym("IP%CFE")
#define	  IP_CFE_S	24	/* Obsolete, replace by FLDGET! */

#define _IPCI0	monsym(".IPCI0")
#define _IPCI1	monsym(".IPCI1")
#define _IPCI2	monsym(".IPCI2")

#define _IPCIW	monsym(".IPCIW")
#define _IPCIG	monsym(".IPCIG")
#define _IPCII	monsym(".IPCII")
#define _IPCIJ	monsym(".IPCIJ")
#define _IPCIK	monsym(".IPCIK")
#define _IPCIS	monsym(".IPCIS")

/* Error stuff */
#define IOX11	monsym("IOX11")	/* Quota exceeded */
#define IOX34	monsym("IOX34")	/* Disk full */

/*
 *	per-JSYS bits and syms, in (approx) alpha order of JSYS
 */

#define	AC_CON	monsym("AC%CON")	/*    ACCES    */

#define CR_MAP	monsym("CR%MAP")	/* CFORK */
#define CR_CAP	monsym("CR%CAP")
#define CR_ACS	monsym("CR%ACS")
#define CR_ST	monsym("CR%ST")

#define CF_NUD	monsym("CF%NUD")	/*    CHFDB   */
#define _CFNUD CF_NUD		/* Huh???  Flush this! */

#define	CK_JFN	monsym("CK%JFN")	/*    CHKAC    */
#define _CKARD	monsym(".CKARD")	/* Check read access */
#define _CKAWR	monsym(".CKAWR")	/* Check write access */
#define _CKAEX	monsym(".CKAEX")	/* Check execute access */
#define _CKADR	monsym(".CKADR")	/* Check dir read access */
#define _CKACF	monsym(".CKACF")	/* Check file create access */
#define _CKADL	monsym(".CKADL")	/* Check dir list access */
#define _CKAAC	monsym(".CKAAC")	/* Code of desired access to files */
#define _CKALD	monsym(".CKALD")	/* User number */
#define _CKACD	monsym(".CKACD")	/* Conn dir number */
#define _CKAEC	monsym(".CKAEC")	/* Enabled caps */
#define _CKAUD	monsym(".CKAUD")	/* JFN of file being accessed */
#define _CKAPR	monsym(".CKAPR")	/* File protection (not used) */

#define CO_NRJ	monsym("CO%NRJ")	/* CLOSF */

#define _CMKEY	monsym(".CMKEY")	/* COMND */
#define _CMNUM	monsym(".CMNUM")
#define _CMNOI	monsym(".CMNOI")
#define _CMSWI	monsym(".CMSWI")
#define _CMIFI	monsym(".CMIFI")
#define _CMOFI	monsym(".CMOFI")
#define _CMFIL	monsym(".CMFIL")
#define _CMFLD	monsym(".CMFLD")
#define _CMCFM	monsym(".CMCFM")
#define _CMDIR	monsym(".CMDIR")
#define _CMUSR	monsym(".CMUSR")
#define _CMCMA	monsym(".CMCMA")
#define _CMINI	monsym(".CMINI")
#define _CMFLT	monsym(".CMFLT")
#define _CMDEV	monsym(".CMDEV")
#define _CMTXT	monsym(".CMTXT")
#define _CMTAD	monsym(".CMTAD")
#define _CMQST	monsym(".CMQST")
#define _CMUQS	monsym(".CMUQS")
#define _CMTOK	monsym(".CMTOK")
#define _CMNUX	monsym(".CMNUX")
#define _CMACT	monsym(".CMACT")
#define _CMNOD	monsym(".CMNOD")
#define  CM_ESC	monsym("CM%ESC")
#define  CM_NOP	monsym("CM%NOP")
#define  CM_EOC	monsym("CM%EOC")
#define  CM_RPT	monsym("CM%RPT")
#define  CM_SWT	monsym("CM%SWT")
#define  CM_PFE	monsym("CM%PFE")
#define  CM_FW	monsym("CM%FW")
#define  CM_NSF	monsym("CM%NSF")
#define  CM_BRK	monsym("CM%BRK")
#define  CM_PO	monsym("CM%PO")
#define  CM_HPP	monsym("CM%HPP")
#define  CM_DPP	monsym("CM%DPP")
#define  CM_SDH	monsym("CM%SDH")
#define  CM_NOR	monsym("CM%NOR")
#define  CM_INV	monsym("CM%INV")

#define	DF_EXP	monsym("DF%EXP")	/*    DELF    */

					/*    DVCHR    */
#define	DV_TYP_S	18	/* Obsolete, replace by FLDGET! */
#define	DV_TYP_M	0777	/* ditto */
#define _DVDSK	monsym(".DVDSK")	/* disk */
#define _DVMTA	monsym(".DVMTA")	/* magtape */
#define _DVLPT	monsym(".DVLPT")	/* lineprinter */
#define _DVCDR	monsym(".DVCDR")	/* card reader (<laughter!>) */
#define _DVFE	monsym(".DVFE")		/* front-end psuedo-device */
#define _DVTTY	monsym(".DVTTY")	/* TTY */
#define _DVPTY	monsym(".DVPTY")	/* psuedo-TTY */
#define _DVNUL	monsym(".DVNUL")	/* null device */
#define _DVNET	monsym(".DVNET")	/* old ARPAnet device code */
#define _DVDCN	monsym(".DVDCN")	/* DECnet active component */
#define _DVSRV	monsym(".DVSRV")	/* DECnet passive component */
#define _DVTCP	monsym(".DVTCP")	/* TCP */
#if !monsymdefined(".DVTCP")
#undef _DVTCP
#define _DVTCP 025			/* Always needed, for write() */
#endif
#define _DVPIP	monsym(".DVPIP")	/* pipe device */

#define SC_CTC	monsym("SC%CTC")	/* EPCAP (and RPCAP) */

#define GF_GFH	monsym("GF%GFH")	/* GFRKS */
#define GF_GFS	monsym("GF%GFS")

#define _GFAUT	monsym(".GFAUT")	/*    GFUST    */

#define _GTHIX	monsym(".GTHIX")	/*    GTHST    */
#define _GTHNS	monsym(".GTHNS")
#define _GTHSN	monsym(".GTHSN")

#define	GJ_FOU	monsym("GJ%FOU")	/*    GTJFN    */
#define	GJ_NEW	monsym("GJ%NEW")
#define	GJ_OLD	monsym("GJ%OLD")
#define	GJ_IFG	monsym("GJ%IFG")
#define	GJ_XTN	monsym("GJ%XTN")
#define	GJ_SHT	monsym("GJ%SHT")

#define GS_EOF	monsym("GS%EOF")	/* GTSTS */
#define GS_ERR	monsym("GS%ERR")
#define GS_OPN	monsym("GS%OPN")
#define GS_RDF	monsym("GS%RDF")
#define GS_WRF	monsym("GS%WRF")
#define GS_NAM	monsym("GS%NAM")

#define _HPELP	monsym(".HPELP")	/*    HPTIM    */

#define	IC_TMZ	monsym("IC%TMZ")	/*    IDCNV    */
#define	IC_ADS	monsym("IC%ADS")
#define	IC_JUD	monsym("IC%JUD")

#define	IT_NDA	monsym("IT%NDA")	/*    IDTIM    */
#define	IT_NTI	monsym("IT%NTI")

#define JS_PAF	monsym("JS%PAF")	/*	JFNS	*/

#define _LNSJB	monsym(".LNSJB")	/*    LNMST    */
#define _LNSSY	monsym(".LNSSY")
					/*    MTOPR    */
#define _MOSPD	monsym(".MOSPD")	/* set TTY line speed */
#define _MORSP	monsym(".MORSP")	/* read TTY line speed */
#define _MORLW	monsym(".MORLW")	/* Read TTY line width */
#define _MOSLW	monsym(".MOSLW")	/* Set TTY line width */
#define _MORLL	monsym(".MORLL")	/* Read TTY page height */
#define _MOSLL	monsym(".MOSLL")	/* Set TTY page height */
					/*    MUTIL    */
#define _MUCRE	monsym(".MUCRE")	/* Create a PID */

#define	OT_DAY	monsym("OT%DAY")	/*    ODTIM    */
#define OT_FDY	monsym("OT%FDY")
#define OT_NMN	monsym("OT%NMN")
#define OT_FMN	monsym("OT%FMN")
#define	OT_4YR	monsym("OT%4YR")
#define	OT_DAM	monsym("OT%DAM")
#define	OT_SPA	monsym("OT%SPA")
#define OT_SLA	monsym("OT%SLA")
#define	OT_NTM	monsym("OT%NTM")
#define OT_NSC	monsym("OT%NSC")
#define OT_12H	monsym("OT%12H")
#define OT_NCO	monsym("OT%NCO")
#define OT_TMZ	monsym("OT%TMZ")
#define	OT_SCL	monsym("OT%SCL")
#define OT_822	monsym("OT%822")

#define	OF_RD	monsym("OF%RD")	/*    OPENF    */
#define	OF_WR	monsym("OF%WR")
#define	OF_APP	monsym("OF%APP")
#define	OF_THW	monsym("OF%THW")
#define	OF_PDT	monsym("OF%PDT")
#define	OF_PLN	monsym("OF%PLN")
#define OF_BSZ	monsym("OF%BSZ")
#define OF_MOD	monsym("OF%MOD")

#define	PM_CNT	monsym("PM%CNT")	/*    PMAP    */
#define	PM_RD	monsym("PM%RD")
#define	PM_WR	monsym("PM%WR")

#define _PRAST	monsym(".PRAST")	/*    PRARG    */
#define   PRA_CCL	0	/* re-do last CCL command function */
#define   PRA_KEEP	1	/* keep fork */
#define	  PRA_KILL	2	/* kill fork */
#define   PRA_BACK	3	/* continue fork in the background */

#define	RC_NOM	monsym("RC%NOM")	/*    RCUSR    */
#define	RC_EMO	monsym("RC%EMO")

#define _RFRUN	monsym(".RFRUN")	/* RFSTS */
#define _RFIO	monsym(".RFIO")
#define _RFHLT	monsym(".RFHLT")
#define _RFFPT	monsym(".RFFPT")
#define _RFWAT	monsym(".RFWAT")
#define _RFSLP	monsym(".RFSLP")
#define _RFTRP	monsym(".RFTRP")
#define _RFABK	monsym(".RFABK")

#define PA_PEX	monsym("PA%PEX")	/* RPACS */

#define _RSINI	monsym(".RSINI")	/*    RSCAN    */
#define _RSCNT	monsym(".RSCNT")

#define _SFAUT	monsym(".SFAUT")	/* SFUST */
#define _SFLWR	monsym(".SFLWR")	/* set last writer */

#define	ST_DIM	monsym("ST%DIM")	/*    STIW    */

#define RD_BRK	monsym("RD%BRK")	/* TEXTI */
#define RD_TOP	monsym("RD%TOP")
#define RD_PUN	monsym("RD%PUN")
#define RD_BEL	monsym("RD%BEL")
#define RD_CRF	monsym("RD%CRF")
#define RD_RND	monsym("RD%RND")
#define RD_JFN	monsym("RD%JFN")
#define RD_RIE	monsym("RD%RIE")
#define RD_BBG	monsym("RD%BBG")
#define RD_RAI	monsym("RD%RAI")
#define RD_SUI	monsym("RD%SUI")
#define RD_BTM	monsym("RD%BTM")
#define RD_BFE	monsym("RD%BFE")
#define RD_BLR	monsym("RD%BLR")

#define _TCPSH	monsym(".TCPSH")	/* TCOPR push data */

#define _TIMRT	monsym(".TIMRT")	/*    TIMER   */
#define _TIMEL	monsym(".TIMEL")
#define _TIMDT	monsym(".TIMDT")
#define _TIMDD	monsym(".TIMDD")
#define _TIMBF	monsym(".TIMBF")
#define _TIMAL	monsym(".TIMAL")

/*
 *	Standard DEC terminal type codes
 */
#define _TT33	monsym(".TT33")		/* MODEL 33 */
#define _TT35	monsym(".TT35")		/* MODEL 35 */
#define _TT37	monsym(".TT37")		/* MODEL 37 */
#define _TTEXE	monsym(".TTEXE")	/* EXECUPORT */
#define _TTDEF	monsym(".TTDEF")	/* DEFAULT */
#define _TTIDL	monsym(".TTIDL")	/* IDEAL */
#define _TTV05	monsym(".TTV05")	/* VT05 */
#define _TTV50	monsym(".TTV50")	/* VT50 */
#define _TTL30	monsym(".TTL30")	/* LA30 */
#define _TTG40	monsym(".TTG40")	/* GT40 */
#define _TTL36	monsym(".TTL36")	/* LA36 */
#define _TTV52	monsym(".TTV52")	/* VT52 */
#define _TT100	monsym(".TT100")	/* VT100 */
#define _TTL38	monsym(".TTL38")	/* LA38 */
#define _TT120	monsym(".TT120")	/* LA120 */
#define _TT125	monsym(".TT125")	/* VT125 */
#define _TTK10	monsym(".TTK10")	/* VK100 - GIGI */
#define _TT102	monsym(".TT102")	/* VT102 */
#define _TTH19	monsym(".TTH19")	/* H19 */ /* Conflicts with Stanford sym! */
#define _TT131	monsym(".TT131")	/* VT131 */
#define _TT200	monsym(".TT200")	/* VT200 */

/*
 *	Local definitions.  These are for Stanford and SRI-NIC
 */

#define _TTADM	monsym(".TTADM")	/* LSI ADM-3 */
#define _TTDAM	monsym(".TTDAM")	/* DATAMEDIA 2500 */
#define _TTHP	monsym(".TTHP")		/* HP2645 ETC. */
#define _TTHAZ	monsym(".TTHAZ")	/* VIRGIN HAZELTINE 1500 */
#define _TT43	monsym(".TT43")		/* TTY MODEL 43 */
#define _TTSRC	monsym(".TTSRC")	/* SOROC 120 */
#define _TTGIL	monsym(".TTGIL")	/* GILLOTINE */
#define _TTTEL	monsym(".TTTEL")	/* TELERAY 1061 */
#define _TTTEK	monsym(".TTTEK")	/* TEKTRONIX 4025 */
#define _TTANN	monsym(".TTANN")	/* ANN ARBOR */
#undef _TTH19		/* Flush DEC definition */
#define _TTH19	monsym(".TTH19")	/* HEATH H19 */
#define _TTCPT	monsym(".TTCPT")	/* CONCEPT 100 */
#define _TTIBM	monsym(".TTIBM")	/* IBM 3101-20 */
#define _TTTVI	monsym(".TTTVI")	/* TELEVIDEO-912 */
#define _TTTK3	monsym(".TTTK3")	/* TEKTRONIX 4023 */
#define _TTDM2	monsym(".TTDM2")	/* DATAMEDIA 1520 */
#define _TTAMB	monsym(".TTAMB")	/* AMBASSADOR */
#define _TTESP	monsym(".TTESP")	/* ESPRIT */
#define _TTFRD	monsym(".TTFRD")	/* FREEDOM-100 */
#define _TTFR2	monsym(".TTFR2")	/* FREEDOM-200 */
#define _TTANS	monsym(".TTANS")	/* ANSI STANDARD */
#define _TTAVT	monsym(".TTAVT")	/* CONCEPT AVT */

#endif /* #ifndef _JSYS_NOEXTRADEFS */

#endif /* #ifndef _JSYS_INCLUDED */
