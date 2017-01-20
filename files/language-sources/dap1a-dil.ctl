! This CTL file builds the library and relocatable object files which
! make up the DAP machine for FTS and the DIL.  This control file is
! for Release Engineering and customers ONLY.
!
! Input files implicitly required:
!	BLI:XPORT.L36		XPORT definitions
!	BLI:MONSYM.L36		Monitor definitions
!	JSYSDEF.R36		JSYS definitions (should be in EX1A: or EX2:)
!	BLI:TENDEF.L36		Monitor library
!	CONDIT.L36		Condition handling (should be in EX1A: or EX2:)
!	BLISSNET.L36		Blissnet library (should be in XP1A: or XP2:)
!	TWENTY.L36		Library file (should be in XP1A: or XP2:)
!	RMSBLK.L36		RMS blocks (should be in EX1A: or EX2:)
!	RMSLIB.L36		RMS user interface (should be in EX1A: or EX2:)
!	RMSERR.REL		RMS error handler (should be in EX1A: or EX2:)
!
! Source files needed:
!	DAP-MACROS.REQ		Macros to do DAP
!	DAP-BLOCKS.REQ		DAP blocks
!	DAP-CODES.REQ		DAP messages
!	CPYRIT.MAC		Copyright notice
!	DAP.BLI			DAP message processing routines
!	DAPERR.BLI		DAP error handling
!	DAPSUB.BLI		Get and put DAP objects
!	DIRECT.BLI		Handle directories
!	DIRLST.BLI		Directory listing routine
!	DIR20.B36		Handle TOPS20 filespecs
!	STRING.B36		String-handling functions
!	SETAI.BLI		Handle access information
!	NXTFIL.BLI		Get next file
!	NXTF20.B36		Get next local file
!	DAPT20.B36		TOPS20 DAP routines
!	GETPUT.BLI		GET, PUT, and CONNECT
!	OPEN.BLI		Open a file
!	RDWRIT.B36		Block I/O
!	TRACE.BLI		Trace code
!	M11FIL.B36		MACY11 file service
!
! Output files produced:
!	DAP.L36			DAP macros library
!	CPYRIT.REL		Copyright notice
!	DAP.REL			DAP message processing routines
!	DAPERR.REL		DAP error handling
!	DAPSUB.REL		Get and put DAP objects
!	DAPT20.REL		TOPS20 DAP routines
!	DIR20.REL		Handle TOPS20 filespecs
!	DIRECT.REL		Handle directories
!	DIRLST.REL		Directory listing routine
!	GETPUT.REL		GET, PUT, and CONNECT
!	M11FIL.REL		MACY11 file service
!	NXTF20.REL		Get next local file
!	NXTFIL.REL		Get next file
!	OPEN.REL		Open a file
!	RDWRIT.REL		Block I/O
!	SETAI.REL		Handle access information
!	STRING.REL		String-handling functions
!	TRACE.REL		Trace code
!	DAP2V1.REL		Autopatch library for DAP routines
!
! Edit History:
!
! new_version (1, 0)
!
! Edit (%O'3', '24-Sep-84', 'Sandy Clemens')
!  %( Add DAP1A-DIL.CTL which is the DAP1A.CTL piece for Release
!     Engineering and customers.  FILES:  DAP1A-DIL.CTL (NEW),
!     DAPHST.BLI )%

COMBIN::
! Show logical names actually chosen.
@TAKE DIL-DEF.CMD
@INFORMATION LOGICAL
@NOERROR
! Do Bliss compilations
@BLISS
*COPYRI
*DAP-MACROS+DAP-BLOCKS+DAP-CODES/LIBRARY:DAP
*DAP
*DAPERR
*DAPSUB
*DIRECT
*DIRLST
*DIR20
*STRING
*SETAI
*NXTFIL
*NXTF20
*DAPT20
*GETPUT
*OPEN
*RDWRIT
*TRACE
*M11FIL
! Do MACRO routines
@MACRO
*CPYRIT,=CPYRIT
! Record checksums of what we produced
@VDIRECTORY DAP.L36,CPYRIT.REL*,DAP.REL*,DAPERR.REL*,DAPSUB.REL*,COPYRI.REL*,
@ CHECKSUM SEQUENTIAL
@
@VDIRECTORY DAPT20.REL*,DIR20.REL*,DIRECT.REL*,DIRLST.REL*,GETPUT.REL*,
@ CHECKSUM SEQUENTIAL
@
@VDIRECTORY M11FIL.REL*,NXTF20.REL*,NXTFIL.REL*,OPEN.REL*,RDWRIT.REL*,
@ CHECKSUM SEQUENTIAL
@
@VDIRECTORY SETAI.REL*,STRING.REL*,TRACE.REL*,
@ CHECKSUM SEQUENTIAL
@
! Delete old library
@DELETE DAP2V1.REL
! Construct new library
@COPY CPYRIT.REL DAP2V1.REL
@APPEND OPEN.REL,GETPUT.REL,M11FIL.REL,RDWRIT.REL DAP2V1.REL
@APPEND DAP.REL,DAPERR.REL,DAPSUB.REL,DAPT20.REL DAP2V1.REL
@APPEND DIRECT.REL,DIR20.REL,DIRLST.REL,NXTF20.REL DAP2V1.REL
@APPEND NXTFIL.REL,SETAI.REL,STRING.REL,TRACE.REL,COPYRI.REL,RMSERR.REL DAP2V1.REL
! Record what was produced
@VDIRECTORY DAP2V1.REL*,
@ CHECKSUM SEQUENTIAL
@
@
@MODIFY BATCH COMPDX/DEPEND:-1
@GOTO ENDEND
%ERR::
ENDEND::
%FIN::
@EXPUNGE
