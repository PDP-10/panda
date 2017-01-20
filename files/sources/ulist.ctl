!
! NAME: ULIST.CTL
! DATE: 5-APR-76
!
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
!
! FUNCTION:	THIS CONTROL FILE BUILDS ULIST FROM ITS BASIC
!		SOURCES.  THE SOURCE CODE REQUIRES THAT SYS:
!		MACREL EXIST FOR PROPER ASSEMBLY.
!		THE FILE PRODUCED ON <SUBSYS> BY THIS JOB IS:
!				ULIST.EXE
!
!		THIS JOB ALSO PRODUCES A .CRF LISTING OF THE 
!		SOURCE CODE.
!
! SUBMIT WITH THE SWITCH "/TAG:CREF" TO OBTAIN
!   A .CRF LISTING OF THE SOURCE FILE
!
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
@INFORMATION LOGICAL-NAMES ALL
!
! TAKE A CHECKSUMMED DIRECTORY OF ALL THE INPUT FILES
!
@VDIRECT SYS:MONSYM.UNV,SYS:MACSYM.UNV,SYS:MACRO.EXE,SYS:CREF.EXE,SYS:LINK.EXE,ULIST.MAC,
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
@COMPILE /CREF ULIST.MAC
!
@R CREF
*FOO:ULIST.LST=ULIST.CRF
!
@LOAD ULIST
!
@SAVE ULIST
@INFORMATION VERSION
!
@VDIRECT ULIST.EXE,
@CHECKSUM SEQ
@
!
@DELETE ULIST.REL
!
!
