!
! NAME: DCNSPY.CTL
! DATE: 05-JUN-85
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
! FUNCTION:	THIS CONTROL FILE BUILDS DCNSPY FROM ITS
!		BASIC SOURCES.  THE FILE CREATED ON DSK:
!		IS:
!				DCNSPY.EXE
!		THIS JOB ALSO PRODUCES A .CRF LISTING OF THE
!		SOURCE CODE.
!
! SUBMIT WITH THE SWITCH "/TAG:CREF" TO OBTAIN
!   A .CRF LISTING OF THE SOURCE FILE
!
!
!
@DEF CRF: NUL:
@GOTO A
!
CREF:: @DEF CRF: DSK:
!
!
A::
@TAKE BATCH.CMD
@DEFINE CMD: DSK:,MON:		!Default for command file search
@INFORMATION JOB		!Show what directory we are connected to
@TAKE CMD:SETSRC.CMD		!Define MON:,UNV:,SYS:,R:
@DEFINE REL: SYS:		!Make REL: point to job-wide SYS:
@ERROR %
!
@INFORMATION LOGICAL-NAMES ALL
!
!
! TAKE A CHECKSUMMED DIRECTORY OF ALL THE INPUT FILES
!
@VDIRECT SYS:MACRO.EXE,SYS:CREF.EXE,SYS:LINK.EXE,DCNSPY.MAC,SYS:GLXMAC.UNV,
@CHECKSUM SEQ
@
@VDIRECT SYS:MONSYM.UNV,SYS:MACSYM.UNV,SYS:MACREL.REL,SYS:PA1050.EXE,SYS:QSRMAC.UNV,
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
@NOERROR
@COMPILE /COMPILE/CREF DCNSPY.MAC
!
@ERROR
@R CREF
*CRF:DCNSPY.LST=DCNSPY.CRF
!
@LOAD DCNSPY
!
@SAVE DCNSPY
@INFORMATION VERSION
!
@DIRECT DCNSPY.EXE,
@CHECKSUM SEQ
@
!
@DELETE DCNSPY.REL
!
!
