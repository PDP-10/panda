! UPD ID= 4142, RIP:<7.EXEC>MKPEXC.CTL.8,  26-May-88 09:52:06 by GSCOTT
!Build an EXEC containing MIC and PCL
!
! NAME: MKPEXC.CTL
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
! Function: This control file builds the PCL and MIC EXEC.
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
!	EXEC:EXECF2.MAC
!	EXEC:EXECCA.MAC
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
! The files created are:
!	PCL-EXEC.EXE
!
! Set up and check logical names
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
@VDIRECT EXEC:EXECDE.UNV,EXEC:EXECF2.MAC,EXEC:EXECCA.MAC,-
@EXEC:EXECPM,EXEC:EXECPS,EXEC:EXECPD,EXEC:EXECPC,EXEC:EXECPI,-
@EXEC:EXECPU,EXEC:EXECPX,EXEC:MICPRM,EXEC:EXECMI,EXEC:T20EX7.REL,
@CHECKSUM SEQ
@
@R SYS:MACRO
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
!
! Build PCL source modules
!
@COMP/COMP @EXEC:MKPEXC.CMD
!
! Build PCL EXEC
@R LINK
*@MKPEXC.CCL
@EXP
@RUN PEXEC
*Y
!
! Check on version of EXEC
!
@INFORMATION VERSION
@RENAME EXEC.EXE PCL-EXEC.EXE
@VDIRECT PCL-EXEC.EXE,
@CHECKSUM SEQ
@
! End MKPEXC.CTL
