@GOTO MASTER
! TOPS-20 DIU Control File
!
! This CTL file builds the library and relocatable object files which make up
! DIU.  This batch job should be started at one of the following tags:
!
!      MASTER::	for a master build (defines DSK: to be the DIU, RMS, and DIL 
!		directories).  Used for development builds.
!      WORK::	to build in the connected directory (DSK: searches the 
!		connected directory first and then searches the DIU, RMS and 
!		DIL directories).  Used for private builds.
!      RENG::	to build from the connected directory only (without searching 
!		any other libraries) and with field-image tools.  Used by
!		Release Engineering.
!
! Include a /TIME:1:30:00 for the time limit.
!
! Input files implicitly required in BLI:
!
!	BLI:TENDEF.L36		MONWORD and POINTR macros
!	BLI:XPORT.L36		XPORT library
!	BLI:XPORT.REL		XPORT runtime code
!
! Input files implicitly required in SYS:
!
!	SYS:B362LB.REL		Bliss runtime library
!
! Input files implicitly required:
!
!	DIL.REL			DIL library
!
! Source files needed:
!
!	ACTSYM.R36		Accounting file symbols
!	BLISSNET.REQ		Blissnet library
!	BLISSNET20.R36		Blissnet library
!	DAP.REQ			DAP library
!	DAPERR.B36		DAP error codes
!	DIU.R36			DIU-20 definitions
!	DIU.RNH			DIU HLP source
!	DIU1.RND		DIU DOC source
!	DIU1.RNO		DIU BWR source
!	DIU20.B36		Initialize DIU
!	DIUACT.B36		Resource accounting for DIU
!	DIUACT.BLI		Parser semantic actions
!	DIUACTION.REQ		Semantic action data structures
!	DIUASK.B36		Prompt for text string
!	DIUAU1.BLI		Semantic action utilities
!	DIUAU2.BLI		Record tree massaging routines
!	DIUC20.B36		Command parser (TOPS-20 version)
!	DIUCLE.BLI		Clean up default transforms
!	DIUCMD.B36		Command library
!	DIUCOMMAND.R36		Library for DIU command interface
!	DIUCRX.REQ		CRX data structureS
!	DIUCSR.B36		Conversion statistics report
!	DIUDDL.REQ		PAT grammar file
!	DIUDEB.BLI		Debugging parser
!	DIUDEB.REQ		Debugging parser definitions
!	DIUDEF.B36		Put defaults in request block
!	DIUDIR.B36		Perform directory
!	DIUDIS.BLI		Display record descriptions
!	DIUDIX.R36		DIX definitions necessary to talk to DIL
!	DIUDMP.BLI		Dump transform data structures
!	DIUDO.B36		Process requests
!	DIUERR.B36		DIU error handling
!	DIUETR.BLI		Execute transform & do data transformation
!	DIUGTR.BLI		Generate default transforms
!	DIUHLP.B36		Structured HELP command
!	DIUIP2.B36		IPCF-20 primitives
!	DIUIP2.R36		IPCF-20 definitions
!	DIUJB2.B36		Job controller
!	DIULAN.BLI		Language-specific code
!	DIULEX.BLI		Lexical analyzer
!	DIULG2.B36		Log file routines
!	DIULRT.BLI		Local error recovery tuning tables
!	DIULTR.BLI		Load transform
!	DIUMAP.BLI		Datatype mapping
!	DIUMAT.BLI		Match up transforms
!	DIUMLB.BLI		Datatype mapping library
!	DIUMMP.BLI		Portal to "move matching" routines
!	DIUMOD.B36		Modify queued requests
!	DIUNOT.B36		User notification of request disposal
!	DIUPAR.BLI		PAT parser
!	DIUPATBLSEXT.REQ	Common macros
!	DIUPATDAT.BLI		Definition of parse tables
!	DIUPATDATA.REQ		Parser tables specification
!	DIUPATDEB.REQ		Parser debugger specification
!	DIUPATERROR.REQ		Global error recovery specification
!	DIUPATLANGSP.REQ	Language-specific definitions
!	DIUPATLRTUNE.REQ	Local error recovery tuning
!	DIUPATPARSER.REQ	External specification for PAT parser
!	DIUPATPORTAL.REQ	Require file for using parser portal routines
!	DIUPATPROLOG.REQ	General module prologue
!	DIUPATREQPRO.REQ	Require file prologue
!	DIUPATSWITCH.REQ	General module switches
!	DIUPATTOKEN.REQ		Token manipulation require file
!	DIUPC2.B36		IPCF routines
!	DIUPDB.BLI		Parser debugger
!	DIUPER.BLI		Error recovery routines
!	DIUPOR.BLI		Portals to PAT parser
!	DIUPS2.B36		Sender IPCF routines
!	DIUQUE.B36		Queue manager
!	DIUQUT.B36		Utility routines for request blocks
!	DIUSCH.B36		Scheduler
!	DIUSEM.BLI		Semantic action tables
!	DIUSHD.B36		Does SHOW DEFAULTS
!	DIUSHO.B36		Does SHOW REQUEST
!	DIUSPL.B36		Spooler routines
!	DIUSTR.B36		String-handling routines
!	DIUT20.B36		TOPS-20 interface routines
!	DIUTLB.BLI		Transform data structures
!	DIUTPA.B36		Compatible TPARSE
!	DIUTPAMAC.REQ		TPARSE library
!	DIUTUT.BLI		Transform utilities
!	DIUVER.MAC		Version number / Edit history
!	DIUWLD.B36		Wildcarding
!	DIXB36.R36		Bliss-36 DIL require file
!	FAO.B36			FAO handler
!	FAO.R36			Library for using FAO
!	FAOPUT.BLI		FAOPUT library
!	JSYSDEF.R36		JSYS definitions
!	MONSYM.R36		TOPS-20 monitor symbols
!	PATTOK.BLI		Token manipulation
!	RMSERM.B36		Creates RMS error messages
!	RMSERT.B36		RMS failure routines
!	RMSUSR.R36		RMS interface, source for RMSINT.L36
!	TOPS20.R36		TOPS-20 jsys defs for FAO
!	XPNERR.B36		BLISSnet errors
!	XPNPSI.MAC		PSI routines
!
! Output files produced:
!
!	ACTSYM.L36		Accounting file symbols
!	BLISSNET.L36		Blissnet library
!	BLISSNET20.L36		Blissnet library
!	DAP.L36			DAP library
!	DAPERR.REL		DAP error codes
!	DIU.EXE			Executable DIU
!	DIU.HLP			DIU Help file
!	DIU.L36			DIU-20 definitions
!	DIU1.BWR		DIU Beware file
!	DIU1.DOC		DIU Release documentation
!	DIU20.REL		Initialize DIU
!	DIUACN.REL		Parser semantic actions
!	DIUACT.REL		Resource accounting for DIU
!	DIUACTION.L36		Semantic action data structures
!	DIUASK.REL		Prompt for text string
!	DIUAU1.REL		Semantic action utilities
!	DIUAU2.REL		Record tree massaging routines
!	DIUC20.REL		Command parser (TOPS-20 version)
!	DIUCLE.REL		Clean up default transforms
!	DIUCMD.REL		Command library
!	DIUCOMMAND.L36		Library for DIU command interface
!	DIUCRX.L36		CRX data structures
!	DIUCSR.REL		Conversion statistics report
!	DIUDAT.REL		Definition of parse tables
!	DIUDEB.L36		Debugging parser definitions
!	DIUDEB.REL		Debugging parser
!	DIUDEF.REL		Put defaults in request block
!	DIUDIR.REL		Perform directory
!	DIUDIS.REL		Display record descriptions
!	DIUDIX.L36		DIX definitions necessary to talk to DIL
!	DIUDMP.REL		Dump transform data structures
!	DIUDO.REL		Process requests
!	DIUERR.REL		DIU error handling
!	DIUETR.REL		Execute transform & do data transformation
!	DIUGTR.REL		Generate default transform
!	DIUHLP.REL		Structured HELP command
!	DIUIP2.L36		IPCF-20 definitions
!	DIUIP2.REL		IPCF-20 primitives
!	DIUJB2.REL		Job controller
!	DIULEX.REL		Lexical analyzer
!	DIULG2.REL		Log file routines
!	DIULRT.REL		Local error recovery tables
!	DIULTR.REL		Load transforms
!	DIUMAP.REL		Datatype mapping
!	DIUMAT.REL		Match up transforms
!	DIUMLB.L36		Datatype mapping library
!	DIUMMP.REL		Portal to "move matching" routines
!	DIUMOD.REL		Modify queued requests
!	DIUNOT.REL		User notification of request disposal
!	DIUPAR.REL		PAT parser
!	DIUPATBLSEXT.L36	Common macros
!	DIUPATDATA.L36		Parser tables specification
!	DIUPATDEB.L36		Parser debugger specification
!	DIUPATDEB.REL		Parser debugger
!	DIUPATERR.REL		Error recovery routines
!	DIUPATERROR.L36		Global error recovery specification
!	DIUPATLAN.REL		Language-specific code
!	DIUPATLANGSP.L36	Language-specific definitions
!	DIUPATLRTUNE.L36	Local error recovery tuning
!	DIUPATPARSER.L36	External specification for parser
!	DIUPATTOKEN.L36		Token manipulation
!	DIUPC2.REL		IPCF routines
!	DIUPOR.REL		Portals to PAT parser
!	DIUPS2.REL		Sender IPCF routines
!	DIUQUE.B36		Queue manager
!	DIUQUT.REL		Utility routines for request blocks
!	DIUSCH.REL		Scheduler
!	DIUSEM.REL		Semantic action tables
!	DIUSHD.REL		Does SHOW DEFAULTS
!	DIUSHO.REL		Does SHOW REQUEST
!	DIUSPL.REL		Spooler routines
!	DIUSTR.REL		String-handling functions
!	DIUT20.REL		TOPS-20 interface routines
!	DIUTLB.L36		Transform data structures
!	DIUTOK.REL		Token manipulation
!	DIUTPA.REL		Compatible TPARSE
!	DIUTPAMAC.L36		TPARSE library
!	DIUTUT.REL		Transform utilities
!	DIUVER.REL		Version number / Edit history
!	DIUWLD.REL		Wildcarding
!	FAO.L36			Library for using FAO
!	FAO.REL			FAO routines
!	FAOPUT.L36		FAOPUT library
!	MONSYM.L36		TOPS-20 monitor symbols
!	RMSERM.REL		Creates RMS error messages
!	RMSERT.REL		RMS failure routines
!	RMSINT.L36		RMS interface
!	TOPS20.L36		TOPS-20 jsys defs for FAO
!	XPNERR.REL		BLISSnet errors
!	XPNPSI.REL		PSI routines
!
!
MASTER::
!
! Here for master DIU build using DIL and RMS directories
!
@DEFINE *
@
@
@DEFINE DSK: DSK:,DI1:,RMS:,DX21:,DL21:,DX2:,DL2:
@DEFINE BLI: DSK:,BLI:
@DEFINE RMS: GREEN:<RMS.3-BUILD>
@DEFINE DI1: GREEN:<DATA-INTERCHANGE.DIU.V1>
@DEFINE DL21: GREEN:<DATA-INTERCHANGE.DIL.V2-1>
@DEFINE DX21: GREEN:<DATA-INTERCHANGE.DIX.V2-1>
@DEFINE DX2: GREEN:<DATA-INTERCHANGE.DIX.V2>
@DEFINE DL2: GREEN:<DATA-INTERCHANGE.DIL.V2>
!
! Get latest RMS V3 rather that whatever is on SYS:
!
@DEFINE SYS: RMS:,SYS:
@GOTO COMBIN
!
WORK::
@DEFINE DSK:
@DEFINE DSK: DSK:,DI1:,RMS:,DX21:,DL21:,DX2:,DL2:
@DEFINE BLI: DSK:,BLI:
@DEFINE RMS: GREEN:<RMS.3-BUILD>
@DEFINE DI1: GREEN:<DATA-INTERCHANGE.DIU.V1>
@DEFINE DL21: GREEN:<DATA-INTERCHANGE.DIL.V2-1>
@DEFINE DX21: GREEN:<DATA-INTERCHANGE.DIX.V2-1>
@DEFINE DX2: GREEN:<DATA-INTERCHANGE.DIX.V2>
@DEFINE DL2: GREEN:<DATA-INTERCHANGE.DIL.V2>
!
! Get latest RMS V3 rather that whatever is on SYS:
!
@DEFINE SYS: RMS:,SYS:
@GOTO COMBIN
!
! Here for release engineering build
!
RENG::
@DEFINE SYS: FIELDI:
@DEFINE DSK:
@DEFINE BLI: DSK:,BLI:
@DEFINE DI1: DSK:
@DEFINE RMS: DSK:
@DEFINE DL21: GREEN:<DATA-INTERCHANGE.DIL.V2-1>
@DEFINE DX21: GREEN:<DATA-INTERCHANGE.DIX.V2-1>
@DEFINE DX2: GREEN:<DATA-INTERCHANGE.DIX.V2>
@DEFINE DL2: GREEN:<DATA-INTERCHANGE.DIL.V2>
@GOTO COMBIN
!
! Now build DIU
!
COMBIN::
@ERROR %
!
@I LOG RMS:
@I LOG DI1:
@I LOG DL21:
@I LOG DX21:
@I LOG DX2:
@I LOG DL2:
!
! Create documentation
!
@RUNOFF DIU.RNH
@RUNOFF DIU1.RND
@RUNOFF DIU1.RNO
@RENAME DIU1.MEM DIU1.BWR
!
! Compile things...
!
REQ::
@BLISS MONSYM.R36/LIB
@BLISS TOPS20.R36/LIB
@BLISS BLISSNET.REQ/LIB
@BLISS BLISSNET20.R36/LIB
@BLISS CONDIT.REQ/LIB
@BLISS DAP.REQ/LIB
@BLISS RMSUSR.R36/LIB:RMSINT
@BLISS XPNERR.B36
@MACRO
*XPNPSI=XPNPSI
@EXPUNGE
!
! Do Bliss compilations of library files:
!
@BLISS
*ACTSYM.R36/LIB
*DIU.R36/LIB
*DIUCOMMAND.R36/LIB
*FAO.R36/LIB
*DIUIP2.R36/LIB
*DIUDIX.R36/LIB
@EXPUNGE
!
! Require files that are libraried by other require files
!
@BLISS/LIB DIUPATBLSEXT
@BLISS/LIB DIUPATDATA		! Changes if grammar name changes!
@BLISS/LIB DIUPATLANGSP		! Language specific!
@EXPUNGE DSK:
!
! Require files that are not libraried by other require files
!
@BLISS/LIB DIUACTION
@BLISS/LIB DIUCRX
@BLISS/LIB DIUDEB
@BLISS/LIB DIUPATERROR
@BLISS/LIB DIUPATLRTUNE		! Language specific!
@BLISS/LIB DIUPATPARSER
@BLISS/LIB DIUPATTOKEN
@BLISS/LIB DIUPATDEB
@BLISS/LIB DIUTPAMAC
@EXPUNGE DSK:
!
!  Librarys for transform stuff
!
@BLISS
*DIUMLB/LIB
*DIUTLB/LIB
*FAOPUT/LIB
@EXPUNGE DSK:
!
! PAT BLISS files
!
REL::
@BLISS
*DIUACN.BLI
*DIUAU1.BLI	! Semantic action utilities
*DIUAU2.BLI
*DIUDAT.BLI	! Changes if grammar name change
*DIULAN.BLI	! Language specific!
*DIULRT.BLI	! Language specific!
*DIUPAR.BLI
*DIUPDB.BLI
*DIUPER.BLI
*DIUSEM.BLI	! Chnge if gram. name does, logically in PATDAT
*DIUTOK.BLI
@EXPUNGE DSK:
!
! Misc. files
!
@BLISS
*DIUDEB.BLI		! General debugging
*DIUDIS.BLI		! Display in-memory data structures
*DIULEX.BLI		! Language specific sample lexical analyzer
*DIUPOR.BLI		! portal into parser
*DIUTPA.B36		! Compatible TPARSE (BLISS36 only)
*FAO.B36		! FAO routine (BLISS36 only)
@EXPUNGE DSK:
!
! DIU modules
!
@BLISS
*DIUCLE.BLI
*DIUDMP.BLI
*DIUETR.BLI
*DIUGTR.BLI
*DIULTR.BLI
*DIUMAP.BLI
*DIUMAT.BLI
*DIUMMP.BLI
*DIUTUT.BLI
@EXPUNGE
@bliss DAPERR.B36
@bliss DIU20.B36
@bliss DIUACT.B36
@bliss DIUASK.B36
@bliss DIUC20.B36
@bliss DIUCMD.B36
@bliss DIUCSR.B36
@bliss DIUDEF.B36
@bliss DIUDIR.B36
@bliss DIUDO.B36
@bliss DIUERR.B36
@bliss DIUHLP.B36
@bliss DIUIP2.B36
@bliss DIUJB2.B36
@bliss DIULG2.B36
@bliss DIUMOD.B36
@bliss DIUNOT.B36
@bliss DIUPC2.B36
@bliss DIUPS2.B36
@bliss DIUQUE.B36
@bliss DIUQUT.B36
@bliss DIUSCH.B36
@bliss DIUSHD.B36
@bliss DIUSHO.B36
@bliss DIUSPL.B36
@bliss DIUSTR.B36
@bliss DIUT20.B36
@bliss DIUWLD.B36
@bliss RMSERM.B36
@bliss RMSERT.B36
@MACRO
*DIUVER=DIUVER
@EXPUNGE
!
! Link it up:
!
@LINK
*/SET:.HIGH.:300000,-
*DIUVER,DIU20 ,DIUACN,DIUACT,DIUASK,DIUAU1,DIUAU2,DIUC20,DIUCLE,DIUCMD,DIUCSR,-
*DIUDAT,DIUDEB,DIUDEF,DIUDIR,DIUDIS,DIUDMP,DIUDO ,DIUERR,DIUETR,DIUGTR,DIUHLP,-
*DIUIP2,DIUJB2,DIULAN,DIULEX,DIULG2,DIULRT,DIULTR,DIUMAP,DIUMAT,DIUMMP,DIUMOD,-
*DIUNOT,DIUPAR,DIUPC2,DIUPER,DIUPOR,DIUPS2,DIUQUE,DIUQUT,DIUSCH,DIUSEM,DIUSHD,-
*DIUSHO,DIUSPL,DIUSTR,DIUT20,DIUTOK,DIUTUT,DIUWLD,-
*DAPERR,RMSERM,RMSERT,XPNERR,XPNPSI,FAO,-
*DL21:DIL/SEARCH,BLI:XPORT/SEARCH,SYS:B362LB/SEARCH,-
*/PVDAT:NAME:DIU%/G
@D 124 .MAIN.+1
@SAVE DIU
@EXPUNGE
!
! Record exactly what was produced:
!
@
@VDIRECTORY DIU.EXE,
@ CHECKSUM SEQUENTIAL
@
@
%ERR:: ! Here if it blows up, send mail to submitter
@MS send .
*DIU1.CTL Error detected
*Error was detected while running DIU1.CTL.  Check DIU1.LOG for the error.
^Z
%FIN::
