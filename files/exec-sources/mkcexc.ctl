! UPD ID= 4143, RIP:<7.EXEC>MKCEXC.CTL.7,  26-May-88 09:52:29 by GSCOTT
!Build an EXEC containing MIC, PCL, and Command Editing
!
! NAME: MKCEXC.CTL
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
! Function: This control file builds the EXEC containing MIC, PCL, and command
! editor using T20EX7.REL.
!! The files required are:
!	SYS:PA1050.EXE
!	SYS:MACRO.EXE
!	SYS:LINK.EXE
!	SYS:GLXMAC.UNV
!	SYS:MACREL.REL
!	SYS:MACSYM.UNV
!	SYS:MONSYM.UNV
!	SYS:ORNMAC.UNV
!	SYS:QSRMAC.UNV
!	EXEC:EXECDE.UNV
!	EXEC:EXECF3.MAC
!	EXEC:EXECCA.MAC
!	EXEC:EXECCE.MAC
!	EXEC:EXECPM.REL
!	EXEC:EXECPS.REL
!	EXEC:EXECPD.REL
!	EXEC:EXECPC.REL
!	EXEC:EXECPI.REL
!	EXEC:EXECPU.REL
!	EXEC:EXECPX.REL
!	EXEC:MICPRM.REL
!	EXEC:EXECMI.REL
!	EXEC:T20EX7.REL
! The file created is:
!	CMD-EXEC.EXE
!
! Set up and get a list of logical names.
!
@DEFINE EXEC: DSK:,SYS:
@TAKE BATCH.CMD
@INFO LOGICAL ALL
!
! Take a checksummed directory of all the input files
!
@VDIRECT SYS:MACRO.EXE,SYS:LINK.EXE,SYS:PA1050.EXE,
@CHECKSUM SEQ
@
@VDIRECT SYS:MONSYM.UNV,SYS:MACSYM.UNV,SYS:GLXMAC.UNV,SYS:ORNMAC.UNV,SYS:QSRMAC.UNV,SYS:MACREL.REL,
@CHECKSUM SEQ
@
@VDIRECT EXEC:EXECDE.UNV,EXEC:EXECF3.MAC,EXEC:EXECCA.MAC,EXEC:EXECCE.MAC,-
@EXEC:EXECPM,EXEC:EXECPS,EXEC:EXECPD,EXEC:EXECPC,EXEC:EXECPI,-
@EXEC:EXECPU,EXEC:EXECPX,EXEC:MICPRM,EXEC:EXECMI,EXEC:T20EX7.REL,
@CHECKSUM SEQ
@
!
! Build command editor sources
!
@COMP/COMP @EXEC:MKCEXC.CMD
!
! Build command editor EXEC
!
@R LINK
*@MKCEXC.CCL
@EXP
@RUN CEXEC
*Y
!
! Check on version and get checksum
!
@INFORMATION VERSION
@RENAME EXEC.EXE CMD-EXEC.EXE
@VDIRECT CMD-EXEC.EXE,
@CHECKSUM SEQ
@
! End of MKCEXC.CTL
