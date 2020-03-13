!
! NAME: CHKPNT.CTL
! DATE: 24-AUG-77
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
! FUNCTION:	THIS CONTROL FILE BUILDS CHKPNT FROM ITS BASIC 
!		SOURCES.  THE FILES CREATED BY THIS JOB ARE:
!				CHKPNT.EXE
!				ACTSYM.UNV
!
! SUBMIT WITH THE SWITCH "/TAG:CREF" TO OBTAIN
!   A .CRF LISTING OF THE SOURCE FILE
!
@DEF FOO: NUL:
@GOTO A
!
CREF:: @DEF FOO: DSK:
!
!
A::
@TAKE BATCH.CMD
!
! TAKE A CHECKSUMMED DIRECTORY OF ALL THE INPUT FILES
!
@VDIRECT SYS:MACRO.EXE,SYS:LINK.EXE,SYS:CREF.EXE,CHKPNT.MAC,ACTSYM.MAC,
@CHECKSUM SEQ
@
@VDIRECT SYS:MONSYM.UNV,SYS:MACSYM.UNV,SYS:MACREL.REL,SYS:PA1050.EXE,
@CHECKSUM SEQ
@
@
@RUN SYS:MACRO
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
@GET SYS:CREF
@INFORMATION VERSION
!
@COMPILE /COMPILE/CREF ACTSYM.MAC
!
@COMPILE /COMPILE/CREF CHKPNT.MAC
!
;SM	@R CREF
;SM	*FOO:CHKPNT.LST=CHKPNT.CRF
;SM	*FOO:ACTSYM.LST=ACTSYM.CRF
!
@LOAD CHKPNT
!
@SAVE CHKPNT
@INFORMATION VERSION
!
@DIRECT CHKPNT.EXE,
@CHECKSUM SEQ
@
!
@DELETE CHKPNT.REL,ACTSYM.REL
 