;<1SOURCES>FILCOM.CTL.2, 18-JAN-76 14:53:16, EDIT BY LEWINE
!
! NAME: FILCOM.CTL
! DATE: 12-OCT-75
!
!THIS CONTROL FILE IS PROVIDED FOR INFORMATION PURPOSES ONLY.  THE
!PURPOSE OF THE FILE IS TO DOCUMENT THE PROCEDURES USED TO BUILD
!THE DISTRIBUTED SOFTWARE.  IT IS UNLIKELY THAT THIS CONTROL FILE
!WILL BE ABLE TO BE SUBMITTED WITHOUT MODIFICATION ON CONSUMER
!SYSTEMS.  PARTICULAR ATTENTION SHOULD BE GIVEN TO ERSATZ DEVICES
!AND STRUCTURE NAMES, PPN'S, AND OTHER SUCH PARAMETERS.  SUBMIT
!TIMES MAY VARY DEPENDING ON SYSTEM CONFIGURATION AND LOAD.  THE
!AVAILABILITY OF SUFFICIENT DISK SPACE AND CORE IS MANDATORY.
!
! FUNCTION:	THIS CONTROL FILE BUILDS FILCOM FROM ITS BASIC 
!		SOURCES.  THE FILES CREATED BY THIS JOB ARE:
!				FILCOM.EXE
!
! SUBMIT WITH THE SWITCH "/TAG:CREF" TO OBTAIN
!   A .CRF LISTING OF THE SOURCE FILE
!
! Required source files:
!DSK:	FILCOM.MAC
!
! Required files (on SYS:):
!SYS:	MACTEN.UNV
!SYS:	HELPER.REL
!SYS:	UUOSYM.UNV
!
! Required programs (on SYS:):
!SYS:	MACRO.EXE
!SYS:	LINK.EXE
!SYS:	PA1050.EXE
!SYS:	CREF.EXE
!
! Output files:
!	FILCOM.EXE
!
! Output listing files:
!	FILCOM.LST
!
@DEF FOO: NUL:
@GOTO A
!
CREF:: @DEF FOO: DSK:
!
!
A::
!
@TAK BATCH.CMD
!
@INFO LOG ALL
!
! TAKE A CHECKSUMMED DIRECTORY OF ALL THE INPUT FILES
!
@VDIRECT SYS:MACRO.EXE,SYS:LINK.EXE,SYS:PA1050.EXE,SYS:CREF.EXE,FILCOM.MAC,
@CHECKSUM SEQ
@
@VDIRECT SYS:MACTEN.UNV,SYS:UUOSYM.UNV,SYS:HELPER.REL,
@CHECKSUM SEQ
@
@
@RUN SYS:MACRO
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
@GET SYS:PA1050
@INFORMATION VERSION
@GET SYS:CREF
@INFORMATION VERSION
!
@COMPILE /CREF FILCOM.MAC
!
@R CREF
*FOO:FILCOM.LST=FILCOM.CRF
!
@LOAD FILCOM,SYS:HELPER.REL
!
@SAVE FILCOM
@INFORMATION VERSION
!
@DIRECT FILCOM.EXE,
@CHECKSUM SEQ
@
!
@DELETE FILCOM.REL