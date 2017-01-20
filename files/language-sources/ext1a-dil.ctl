! This CTL file builds the library and relocatable object file which
! make up the RMS extensions used by FTS and the DIL.  This control
! file is for Release Engineering and customers ONLY.
!
! Input files implicitly required:
!	BLI:XPORT.L36		XPORT definitions
!	BLI:MONSYM.L36		Monitor definitions
!	BLI:TENDEF.R36		Require file for system things
!
! Source files needed:
!	RMSUSR.R36		Require file for using RMS
!	V3-RMSUSR.R36		Require file for using RMS V3
!	RMS.R36			Require file for RMS
!	RMSBLK.R36		Require file for RMS blocks
!	RMSLIB.R36		Require file for RMS
!	TOPS20.R36		Require file
!	UNDECLARE.REQ		Require file to avoid warning messages
!	CONDIT.REQ		Require file for condition handling
!	RMSERR.B36		RMS error handler source
!
! Other files that live in this directory:
!	JSYSDEF.R36		Require file for JSYS usage
!	RMSINT.R36		Require file for using RMS internal routines
!
! Output files created:
!	RMSUSR.L36		Library file for using RMS
!	RMSINT.L36		Library file for using RMS V3
!	RMS.L36			Library file for RMS
!	RMSBLK.L36		Library file for RMS blocks
!	RMSLIB.L36		Library file for RMS
!	TWENTY.L36		Library file
!	CONDIT.L36		Library file for condition handling
!	RMSERR.REL		RMS error handler .REL file
!
! Edit History:
!
! new_version (1, 0)
!
! Edit (%O'3', '24-Sep-84', 'Sandy Clemens')
!  %( Add EXT1A-DIL.CTL which is the EXT1A.CTL piece for Release
!     Engineering and customers.  FILES:  EXT1A-DIL.CTL (NEW),
!     EXTHST.BLI )%
!
! **EDIT**

COMBIN::
! Show logical names actually chosen.
@TAKE DIL-DEF.CMD
@INFORMATION LOGICAL
@NOERROR
! Do Bliss compilations
@BLISS
*RMSUSR/LIB
*V3-RMSUSR/LIB:RMSINT
*BLI:XPORT+DSK:RMSUSR+DSK:RMS/LIB:RMS
*RMSBLK/LIB
*RMSLIB/LIB
*TOPS20+BLI:MONSYM+DSK:UNDECLARE+BLI:TENDEF/LIB:TWENTY
*CONDIT/LIB
*RMSERR
! Record exactly what was produced
@VDIRECTORY RMSUSR.L36,RMS.L36,RMSBLK.L36,RMSLIB.L36,TWENTY.L36,CONDIT.L36,RMSERR.REL,
@ CHECKSUM SEQUENTIAL
@
@
@MODIFY BATCH XPN1A/DEPEND:-1
@GOTO ENDEND
%ERR::
ENDEND::
%FIN::
@EXPUNGE
