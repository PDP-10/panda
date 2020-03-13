!
! NAME: USAH20.CTL
! DATE: 30-OCT-77
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
! FUNCTION:	THIS CONTROL BUILDS USAH20 FROM ITS BASIC
!		SOURCES. THE FILES CREATED BY THIS JOB ARE:
!				USAH20.EXE
!
!
!IF YOUR INSTALLATION HAS FORTRAN AND SORT, THE FOLLOWING SEQUENCE OF
!	COMMANDS WILL LOAD USAH20 WITH A CREF LISTING.
!@FORTRAN
!*USAH20,USAH20=USAH20/CROSSREF
!@LOAD USAH20
!@SAVE USAH20
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
@VDIRECT SYS:FORTRA.EXE,SYS:FORLIB.REL,SYS:FOROT6.EXE,SYS:LINK.EXE,USAH20.FOR,
@CHECKSUM SEQ
@
@VDIRECT SYS:PA1050.EXE,
@CHECKSUM SEQ
@
@
@RUN SYS:FORTRA
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
!
!
@FORTRA
*USAH20,USAH20=USAH20
!
!
@LINK
*USAH20/GO
@IF (ERROR)
!
@SAVE USAH20
@INFORMATION VERSION
!
!
@DIRECT USAH20.EXE,
@CHECKSUM SEQ
@
!
@DEL USAH20.REL
@DEL USAH20.LST
@DEL USAG20.CHG
@
!
