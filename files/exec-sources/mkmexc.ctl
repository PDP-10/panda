! UPD ID= 4141, RIP:<7.EXEC>MKMEXC.CTL.7,  26-May-88 09:51:56 by GSCOTT
!Build an EXEC containing MIC only.
!
! NAME: MKMEXC.CTL
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
! Function: This control file builds the EXEC with MIC.
! The files required are:
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
!	EXEC:EXECF1.MAC
!	EXEC:EXECCA.MAC
!	EXEC:MICPRM.MAC
!	EXEC:EXECMI.MAC
!	EXEC:T20EX7.REL
! The files created are:
!	MIC-EXEC.EXE
!
!
! Set up and check logical names
!
@DEFINE EXEC: DSK:,SYS:
@TAKE BATCH.CMD
@INFO LOGICAL ALL
!
! Take a checksummed directory of all the input files
!
@VDIRECT SYS:MACRO.EXE,SYS:LINK.EXE,SYS:CREF.EXE,SYS:PA1050.EXE,
@CHECKSUM SEQ
@
@VDIRECT SYS:MONSYM.UNV,SYS:MACSYM.UNV,SYS:GLXMAC.UNV,SYS:ORNMAC.UNV,SYS:QSRMAC.UNV,SYS:MACREL.REL,
@CHECKSUM SEQ
@
@
@VDIRECT EXEC:EXECDE.UNV,EXEC:EXECMI.MAC,EXEC:MICPRM.MAC,EXEC:T20EX7.REL,
@CHECKSUM SEQ
@
@R SYS:MACRO
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
@GET SYS:CREF
@INFORMATION VERSION
!
! Build MIC sources
!
@COMP/COMP @EXEC:MKMEXC.CMD
!
! Build MIC-EXEC
!
@R LINK
*@MKMEXC.CCL
@EXP
@RUN MEXEC
*Y
!
! Check version and get checksum
!
@INFORMATION VERSION
@RENAME EXEC.EXE MIC-EXEC.EXE
@VDIRECT MIC-EXEC.EXE,
@CHECKSUM SEQ
@
!End of MKMEXC.CTL
