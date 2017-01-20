;<AUTOPATCH.SOURCES>EXEC.CTL.4, 13-Dec-89 18:11:09, Edit by WEINER
! UPD ID= 4140, RIP:<7.EXEC>EXEC.CTL.5,  26-May-88 09:51:45 by GSCOTT
;Build a vanilla EXEC
!
! NAME: EXEC.CTL
! DATE: 25-May-88
!
! This control file is provided for information purposes only.  The purpose of
! the file is to document the procedures used to build the distributed
! software.  It is unlikely that this control file will be able to be submitted
! without modification on consumer systems.  Particular attention should be
! given to logical names.  Logical names are normally set from BATCH.CMD in the
! connected directory.  Submit times may vary depending on system configuration
! and load.  The availability of sufficient disk space is mandatory.
!
! Function: This control file builds the EXEC using T20EX7.REL.
! The files required are:
!	SYS:PA1050.EXE
!	SYS:MACRO.EXE
!	SYS:LINK.EXE
!	SYS:MAKLIB.EXE
!	SYS:GLXMAC.UNV
!	SYS:MACREL.REL
!	SYS:MACSYM.UNV
!	SYS:MONSYM.UNV
!	SYS:ORNMAC.UNV
!	SYS:QSRMAC.UNV
!	EXEC:EXECCA.MAC
!	EXEC:EXECDE.UNV
!	EXEC:EXECF0.MAC
!	T20EX7.REL
! The file created is:
!	EXEC.EXE
!
!
! Set up and get a listing of logical names
!
@DEFINE EXEC: DSK:,SYS:
@TAKE BATCH.CMD
@INFO LOGICAL ALL
!
! Take a checksummed directory of all the input files
!
@VDIRECT SYS:MACRO.EXE,SYS:LINK.EXE,SYS:MAKLIB.EXE,SYS:PA1050.EXE,
@CHECKSUM SEQ
@
@VDIRECT SYS:MONSYM.UNV,SYS:MACSYM.UNV,SYS:GLXMAC.UNV,SYS:ORNMAC.UNV,SYS:QSRMAC.UNV,SYS:MACREL.REL,
@CHECKSUM SEQ
@
@VDIRECT EXEC:EXECF0.MAC,EXEC:EXECCA.MAC,EXEC:EXECDE.UNV,EXEC:T20EX7.REL,
@CHECKSUM SEQ
@
@R SYS:MACRO
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
!
!
!	Build the EXEC
!

@COMPILE EXEC:EXECF0+EXEC:EXECCA EXECC0
!
! Make EXEC.EXE
!

@R LINK
*/SET:.HIGH.:160000
*/SYMSEG:HIGH
*TTY:/LOG/LOGL:5
*EXEC/SAVE
*T20EX7.REL
*EXECC0.REL
*SYS:MACREL.REL
*/G
@EXP
@RUN EXEC
*Y
!
! Check on created EXEC
!
@INFORMATION VERSION
@VDIRECT EXEC.EXE,
@CHECKSUM SEQ
@
! End of EXEC.CTL
