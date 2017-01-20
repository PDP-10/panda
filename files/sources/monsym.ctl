;RIP:<7.UTILITIES>MONSYM.CTL.2 23-Oct-87 15:00:08, Edit by GSCOTT
;Make a REL1.MAC if none exists, update comments.
!
! NAME: MONSYM.CTL
!
!This control file is provided for information purposes only.  The purpose of
!the file is to document the procedures used to build the distributed software.
!It is unlikely that this control file will be able to be submitted without
!modification on consumer systems.  Particular attention should be given to
!logical names.  Execution times may vary depending on system configuration and
!load.  The availability of sufficient disk space is mandatory.
!
!Function: This control file builds MONSYM.UNV, MONSYM.REL, ERRMES.BIN, and
!MONSYM.LST from MONSYM.MAC.
!
!Submit with the switch "/TAG:CREF" to obtain a listing of MONSYM
!
! Required source files:
!DSK:	MONSYM.MAC
!
! Required files (on SYS:):
!SYS:	MACSYM.UNV
!
! Required programs (on SYS:):
!SYS:	MACRO.EXE
!SYS:	PA1050.EXE
!SYS:	CREF.EXE
!
! Output files:
!	MONSYM.UNV
!	MONSYM.REL
!	ERRMES.BIN
!
! Output listing files:
!	MONSYM.LST
!
!
@SET NO DEFAULT COMPILE-SWITCHES MAC
@SET DEFAULT COMPILE-SWITCHES MAC /COMPILE
@DEF FOO: NUL:
@GOTO START
!
CREF::
@SET NO DEFAULT COMPILE-SWITCHES MAC
@SET DEFAULT COMPILE-SWITCHES MAC /CREF/COMPILE
@DEF FOO: DSK:
!
START::
!
@TAK BATCH.CMD
!
! Get a listing of the logical names
!
@INFORMATION LOGICAL-NAMES ALL
!
! Take a checksummed directory of all the input files
!
@VDIRECT SYS:MACRO.EXE,SYS:PA1050.EXE,SYS:CREF.EXE,MONSYM.MAC,
@CHECKSUM SEQ
@
@VDIRECT SYS:MACSYM.UNV,
@CHECKSUM SEQ
@
@
! 
! Get software versions
!
@RUN SYS:MACRO
@INFORMATION VERSION
@GET SYS:PA1050
@INFORMATION VERSION
@GET SYS:CREF
@INFORMATION VERSION
!
! Delete any old files
!
@DELETE MONSYM.UNV,MONSYM.REL,ERBLD.*
!
! Build MONSYM.UNV
!
@COMPILE /NOBIN MONSYM.MAC
!
! Build MONSYM.REL
!
@TYPE REL1.MAC
@IF(NOERROR) GOTO REL1
@COPY TTY: REL1.MAC
@	REL==1
@^Z
@
REL1::
@COMPILE /CREF REL1.MAC+MONSYM.MAC MONSYM
!
! Build ERRMES.BIN
!
@COPY TTY: ERBLD.MAC
@	.ERBLD==1
@^Z
@
@SET NO DEFAULT COMPILE-SWITCHES MAC
@EXECUTE /COMPILE ERBLD.MAC+REL1.MAC+MONSYM.MAC ERBLD
@DELETE ERBLD.*,
@EXPUNGE
@
!
! Create listing if needed
!
@R CREF
*FOO:MONSYM.LST=MONSYM.CRF
!
!
! Do checksum of output files
!
@DIRECT MONSYM.UNV,MONSYM.REL,ERRMES.BIN,
@CHECKSUM SEQ
@
!End of MONSYM.CTL
