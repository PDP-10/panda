! These are the logical names used for a Release Engineering or customer
! build of DIL only.  Refer to BUILD-DIL.CTL.
!
! Edit History:
!
! new_version (2, 0)
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
!
! **EDIT**
!
DEFINE SRC: DSK:
!
DEFINE SRCDX: DSK:
DEFINE SRCDL: DSK:
DEFINE SRCDT: DSK:
DEFINE DSTDL: DSK:
DEFINE DSTDX: DSK:
DEFINE DSTDT: DSK:
DEFINE XP1A: DSK:
DEFINE DP1A: DSK:
DEFINE EX1A: DSK:
!
DEFINE DST: DSK:
DEFINE WDL: DSK:
DEFINE WDX: DSK:
DEFINE WDT: DSK:
