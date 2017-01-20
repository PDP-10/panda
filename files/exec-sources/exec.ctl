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
! Function: This control file builds the EXEC from its basic sources.
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
!	EXEC:EDEXEC.MAC
!	EXEC:EXEC0.MAC
!	EXEC:EXEC1.MAC
!	EXEC:EXEC2.MAC
!	EXEC:EXEC3.MAC
!	EXEC:EXEC4.MAC
!	EXEC:EXECCA.MAC
!	EXEC:EXECCS.MAC
!	EXEC:EXECDE.MAC
!	EXEC:EXECED.MAC
!	EXEC:EXECF0.MAC
!	EXEC:EXECGL.MAC
!	EXEC:EXECIN.MAC
!	EXEC:EXECMT.MAC
!	EXEC:EXECP.MAC
!	EXEC:EXECPR.MAC
!	EXEC:EXECQU.MAC
!	EXEC:EXECSE.MAC
!	EXEC:EXECSU.MAC
!	EXEC:EXECVR.MAC
! The files created are:
!	EXEC.EXE
!	EXECDE.UNV
!	T20EX7.REL
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
@VDIRECT EXEC:EXEC*.MAC,
@CHECKSUM SEQ
@
@R SYS:MACRO
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
!
! Compile EXEC sources
!
@COMP/COMP @EXEC:MKEXEC
!
! Make EXEC.EXE
!
@R LINK
*@LOEXEC
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
!
! Combine all the .REL files into T20EX7.REL
!
@MAKLIB
*T20EX7=EXEC:EXECGL,EXEC:EXECPR/APPEND,-
*EXEC:EXECVR/APPEND,-
*EXEC:EXEC0/APPEND,-
*EXEC:EXEC1/APPEND,-
*EXEC:EXECSE/APPEND,-
*EXEC:EXECMT/APPEND,-
*EXEC:EXECP/APPEND,-
*EXEC:EXECIN/APPEND,-
*EXEC:EXEC2/APPEND,-
*EXEC:EXEC3/APPEND,-
*EXEC:EXEC4/APPEND,-
*EXEC:EXECED/APPEND,-
*EXEC:EXECCS/APPEND,-
*EXEC:EXECQU/APPEND,-
*EXEC:EXECSU/APPEND
*/EXIT
@
! End of EXEC.CTL
