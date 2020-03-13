!
! NAME: USAG20.CTL
! DATE: 30-SEP-77
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
! FUNCTION:	THIS CONTROL BUILDS USAG20 FROM ITS BASIC
!		SOURCES.  THE SOURCE FOR USAG20 REQUIRES THAT
!		THE FILE USAG20.LIB EXIST AS WELL.  THE FILES
!		CREATED BY THIS JOB ARE:
!				USAG20.EXE
!
!
!IF YOUR INSTALLATION HAS COBOL, THE FOLLOWING SEQUENCE OF COMMANDS WILL
!	LOAD USAG20 WITH A CREF LISTING.
!@COBOL
!*=USAG20/L,USAG20/C
!@LOAD USAG20
!@SAVE USAG20
!
!
!
!
@TAK BATCH.CMD
!
@INFORMATION LOGICAL-NAMES ALL
!
! TAKE A CHECKSUMMED DIRECTORY OF ALL THE INPUT FILES
!
@VDIRECT SYS:COBOL.EXE,SYS:LIBO11.EXE,SYS:SELOTS.EXE,SYS:LINK.EXE,USAG20.CBL,CBL68.EXE,
@CHECKSUM SEQ
@
@VDIRECT SYS:PA1050.EXE,SYS:MAKLIB.EXE,
@CHECKSUM SEQ
@
@
@RUN SYS:COBOL
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
!
@MAKLIB
*USESRT=SYS:LIBOL/EXTRACT:SORT
*USESRT=USESRT/NOLOCAL
!
!THERE WILL BE 29 WARNINGS WHEN THE PROGRAM USAG20 IS COMPILED.
@CBL68
*=USAG20/L,USAG20/R
!
@LINK
*USAG20,USESRT,SYS:LIBOL/SEARCH/SYMSEG:H/GO
!
@SAVE USAG20
@INFORMATION VERSION
!
!
@DIRECT USAG20.EXE,
@CHECKSUM SEQ
@
!
@DEL USAG20.REL,USESRT.REL
@DEL *.LST
!
!


   