!
! NAME: SWSERR.CTL
! DATE: 14-SEP-81
!
!THIS CONTROL FILE IS PROVIDED FOR INFORMATION PURPOSES ONLY.  THE
!PURPOSE OF THE FILE IS TO DOCUMENT THE PROCEDURES USED TO BUILD
!THE DISTRIBUTED SOFTWARE.  IT IS UNLIKELY THAT THIS CONTROL FILE
!WILL BE ABLE TO BE SUBMITTED WITHOUT MODIFICATION ON CUSTOMER
!SYSTEMS.
!
! FUNCTION:	THIS CONTROL FILE BUILDS SWSERR FROM ITS BASIC 
!		SOURCES.  THE FILES CREATED BY THIS JOB ARE:
!				SWSERR.EXE
!
! SUBMIT WITH THE SWITCH "/TAG:CREF" TO OBTAIN
!   A CREF LISTING OF THE SOURCE FILE
!
@DEF FOO: NUL:
@GOTO A
!
CREF:: @DEF FOO: DSK:
!
A::
!
@INFORMATION LOGICAL-NAMES ALL
!
! TAKE A CHECKSUMMED DIRECTORY OF ALL THE INPUT FILES
!
@VDIRECT SYS:MACRO.EXE,SYS:LINK.EXE,SYS:CREF.EXE,SWSERR.MAC,ZSUBS.UNV,ZSUBS.REL,
@CHECKSUM SEQ
@
@VDIRECT SYS:MONSYM.UNV,SYS:MACSYM.UNV,SYS:MACREL.REL,SYS:PA1050.EXE,SERCOD.UNV,
@CHECKSUM SEQ
@
@GET SYS:MACRO
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
@GET SYS:CREF
@INFORMATION VERSION
!
@COMPILE /CREF/COMPILE SWSERR.MAC
!
@R CREF
*FOO:SWSERR.LST=SWSERR.CRF
!
@LOAD SWSERR
!
@SAVE SWSERR
@INFORMATION VERSION
!
@DIRECT SWSERR.EXE,
@CHECKSUM SEQ
@
!
@DELETE SWSERR.REL
