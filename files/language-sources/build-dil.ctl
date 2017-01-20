!   Submit the jobs to compile DIL.  This control file is for Release
!   Engineering and customers ONLY.

! The control files to use are expected to be in the connected directory.
! All date/source files used in the build are expected to be in the
! connected directory.
!
! Facility: DIL
! 
! Edit History:
! 
! new_version (1, 0)
! 
! Edit (%O'132', '24-Sep-84', 'Sandy Clemens')
!  %( Update the DIL build procedure for Release Engineering and
!     Customer builds.  Add BUILD-DIL.CTL (the equivalent to
!     MASTER-DIL.CMD) for customer and Rel. Eng. builds ONLY.  Add
!     DIL-DEF.CMD which defines logicals for Release Eng. and customer
!     builds.  Remove defining logical names in the build .CTL files,
!     TAKE DIL-DEF.CMD instead.  Remove cancelling the unfinished
!     batch jobs.  Update the IDENT edit number in AAA.BLI.
!     FILES:  AAA.BLI, BUILD-DIL.CTL (NEW), DILHST.BLI, COMPDL.CTL,
!     MAKDIL.CTL, INTERFILS.CTL, DIL-DEF.CMD (NEW).  )%
!
! new_version (2, 1)
!
! Edit (%O'141', '1-Jun-86', 'Sandy Clemens')
!   %( Add DIL sources to DL21: directory. )%

TAKE DIL-DEF.CMD
SUBMIT EXT1A-DIL.CTL/TAG:COMBIN
SUBMIT XPN1A-DIL.CTL/TAG:COMBIN /DEPEND:1 /TIME:00:10:00
SUBMIT DAP1A-DIL.CTL/TAG:COMBIN /DEPEND:1 /TIME:00:10:00
SUBMIT COMPDX /TAG:RENG /DEPEND:1 /TIME:00:15:00
SUBMIT COMPDL /TAG:RENG /DEPEND:1
SUBMIT COMPDT /TAG:RENG /DEPEND:1
SUBMIT MAKDIL /TAG:RENG /DEPEND:1
SUBMIT INTERFILS /TAG:RENG /DEPEND:1
