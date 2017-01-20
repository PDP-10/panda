! UPD ID= 1, SNARK:<6.1.ARPA-UTILITIES>IPHOST.CTL.2,   6-Nov-84 21:57:21 by PAETZOLD
!TAKE BATCH.CMD
! UPD ID= 4, SNARK:<6.ARPA-UTILITIES>IPHOST.CTL.3,  21-Nov-83 10:05:04 by PAETZOLD
!Search KL60: in DSK: to find ANAUNV

!
! NAME: IPHOST.CTL
! DATE: 21 Nov-83
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
! FUNCTION:	THIS CONTROL FILE BUILD IPHOST FROM ITS BASIC
!		SOURCES.  THE FILE CREATED BY THIS JOB IS:
!				IPHOST.EXE
!
! SUBMIT WITH THE SWITCH "/TAG:CREF" TO OBTAIN
!   A .CRF LISTING OF THE SOURCE FILE
!
!REQUIRED FILES:	(LATEST RELEASED VERSIONS)
!SYS:	MACRO.EXE
!	LINK.EXE
!	CREF.EXE
!	MONSYM.UNV
!	MACSYM.UNV
!	MACREL.REL
!	PA1050.EXE
!FILES TO BE SHIPPED:
!	
@DEF FOO: NUL:
@GOTO A
!
CREF:: @DEF FOO: DSK:
!
!
A::
@TAKE BATCH
!
! TAKE A CHECKSUMMED DIRECTORY OF ALL THE INPUT FILES
!
@VDIRECT SYS:MACRO.EXE,SYS:LINK.EXE,SYS:CREF.EXE,IPHOST.MAC,
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
@NOERROR
@COMPILE /COMPILE /CREF IPHOST.MAC
!
@R CREF
*FOO:IPHOST.LST=IPHOST.CRF
!
@LOAD IPHOST
!
@SAVE IPHOST.EXE
@INFORMATION VERSION
!
@DIRECT IPHOST.EXE,
@CHECKSUM SEQ
@
!
@DELETE IPHOST.REL
