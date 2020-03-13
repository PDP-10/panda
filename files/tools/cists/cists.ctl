!
! NAME: CISTS.CTL
! DATE: 4-APR-84
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
! FUNCTION:	THIS CONTROL FILE BUILDS CISTS FROM ITS SOURCE.
!
! SUBMIT WITH THE SWITCH "/TAG:CREF" TO OBTAIN
!   A .CRF LISTING OF THE SOURCE FILE.
!
!
!
!REQUIRED FILES:	(LATEST RELEASED VERSIONS)
!SYS:	MACRO.EXE
!	LINK.EXE
!	CREF.EXE
!	MONSYM.UNV
!	MACSYM.UNV
!	MACREL.REL
!	GLXMAC.UNV
!	JOBDAT.UNF
!FILES TO BE SHIPPED:
!	CISTS.CMD
!	CISTS.CTL
!	CISTS.EXE
!	CISTS.MAC
!
@DEFINE FOO: NUL:
@GOTO A
!
CREF::
@DEFINE FOO: DSK:
!
!
A::
@TAKE BATCH.CMD
!
@INFORMATION LOGICAL-NAMES ALL
!
!
! TAKE A CHECKSUMMED DIRECTORY OF ALL THE INPUT FILES
!
@VDIRECT SYS:MACRO.EXE,SYS:CREF.EXE,SYS:LINK.EXE,CISTS.MAC,
@CHECKSUM SEQ
@
@VDIRECT SYS:MONSYM.UNV,SYS:GLXMAC.UNV,SYS:MACSYM.UNV,SYS:MACREL.REL,
@CHECKSUM SEQ
@
@
@GET SYS:MACRO
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
@GET SYS:CREF
@INFORMATION VERSION
!
@COMPILE /COMPILE/CREF CISTS.MAC
!
@R CREF
*FOO:CISTS.LST=CISTS.CRF
!
@LINK
*CISTS.EXE/SAV=CISTS.REL/COUNT/GO
!
@GET CISTS
@INFORMATION VERSION
!
@VDIRECT CISTS.EXE,
@CHECKSUM SEQ
@
!
@DELETE CISTS.REL
!
![END CISTS.CTL]
 