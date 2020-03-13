! UPD ID= 33, RIP:<7.TOOLS-TAPE>SYSDPY.CTL.15,  19-Jan-90 14:15:59 by GSCOTT
;Edit 664 deleted the use of ANADPY in favor of using the monitor's ANAUNV.
! UPD ID= 21, RIP:<7.TOOLS-TAPE>SYSDPY.CTL.14,  26-Feb-88 13:40:27 by GSCOTT
!
! NAME: SYSDPY.CTL
! DATE: 4-MAR-79
!
!This control file is provided for  information purposes only.  The purpose  of
!the file is to document the procedures used to build the distributed software.
!It is unlikely that  this control file  will be able  to be submitted  without
!modification on consumer  systems.  Particular  attention should  be given  to
!logical names.  Submit times  may vary depending  on system configuration  and
!load.  The availability of sufficient disk space is mandatory.
!
! Function:	This control file builds SYSDPY from its sources.
!
!Required Files:	(latest released versions)
!SYS:	MACRO.EXE
!	LINK.EXE
!	CREF.EXE
!	ANAUNV.UNV
!	MONSYM.UNV
!	MACSYM.UNV
!	MACREL.REL
!	PA1050.EXE
!	JOBDAT.UNV
!	GLXMAC.UNV
!	QSRMAC.UNV
!	ORNMAC.UNV
!Files to be shipped:
!	DPY.MAC
!	DPYDEF.MAC
!	SYSDPY.CMD
!	SYSDPY.CTL
!	SYSDPY.DOC
!	SYSDPY.EXE
!	SYSDPY.HLP
!	SYSDPY.MAC
!	SYSDPY.MEM
!
! Submit with the switch "/TAG:CREF" to obtain listing of the source files
!
@SET DEFAULT COMPILE MAC /COMPILE
@GOTO BEGIN
!
CREF::@SET DEFAULT COMPILE MAC /CREF /COMPILE
!
BEGIN::
@TAKE BATCH.CMD
!
@INFORMATION LOGICAL-NAMES ALL
!
! Delete any old versions
!
@DELETE SYSDPY.EXE,SYSDPY.REL
@DELETE DPY.REL,DPYDEF.REL,DPYDEF.UNV
!
! Take a checksummed directory of all the input files
!
@VDIRECT SYS:MACRO.EXE,SYS:LINK.EXE,SYS:CREF.EXE,SYS:PA1050.EXE,
@CHECKSUM SEQ
@
@VDIRECT SYS:MONSYM.UNV,SYS:MACSYM.UNV,SYS:JOBDAT.UNV,ANAUNV.UNV,
@CHECKSUM SEQ
@
@VDIRECT SYS:GLXMAC.UNV,SYS:QSRMAC.UNV,SYS:ORNMAC.UNV,
@CHECKSUM SEQ
@
@R SYS:MACRO
@INFORMATION VERSION
@R SYS:LINK
@INFORMATION VERSION
@R SYS:CREF
@INFORMATION VERSION
!
! Compile sources
!
COMPIL::
@COMPILE DPYDEF.MAC
@COMPILE DPY.MAC
@COMPILE SYSDPY.MAC
!
! Generate CREF listings
!
CREF::
@DEFINE LPT: DSK:
@CREF
!
! Link and save SYSDPY
!
LINK::
@R LINK
*SYSDPY
*SYSDPY/SAVE/GO
!
! Get version and directory then we are done
!
@INFORMATION VERSION
@DIRECT SYSDPY.EXE,
@CHECKSUM SEQ
@
!
! End of SYSDPY.CTL
!
