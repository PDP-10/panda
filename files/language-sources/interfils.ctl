! Make COBOL-10/20 libraries of interface-support files for DIL
! This library will include the dil, dix, and dit elements
!
! For a WORK build, preferring connected directory and leaving results
! there, submit with tag WORK (or nothing, this is the default).
!
! For a MASTER build, looking only in the library directories and leaving
! the results in them, submit with tag MASTER.
!
! Facility: DIL
! 
! Edit History:
! 
! new_version (1, 0)
! 
! edit (8, '23-Aug-82', 'David Dyer-Bennet')
!  %( Change version and revision standards everywhere.
!     Files: All. )%
! 
! Edit (%O'35', '22-Nov-82', 'David Dyer-Bennet')
! %(  Add release-engineering mode to build procedure.
!     Associated with DIX %O'24', DIT %O'703'
! )%
! Edit (%O'73', '10-Mar-83', 'Charlotte L. Richardson')
! %( Declare version 1.  All modules.
! )%
! 
! new_version (2, 0)
! 
! Edit (%O'75', '12-Apr-84', 'Sandy Clemens')
!  %( Put all Version 2 DIL development files under edit control.  Some
!     of the files listed below have major code edits, or are new
!     modules.  Others have relatively minor changes, such as cleaning
!     up a comment.
!     FILES:  COMPDL.CTL, DIL.RNH, DIL2VAX.CTL, DILBLD.10-MIC,
!     DILHST.BLI, DILINT.BLI, DILOLB.VAX-COM, DILV6.FOR, DILV7.FOR,
!     INTERFILS.CTL, MAKDIL.CTL, MASTER-DIL.CMD, POS20.BLI, POSGEN.BLI,
!     DLCM10.10-CTL, DLMK10.10-CTL
!  )%
! 
! Edit (%O'116', '9-Jul-84', 'Sandy Clemens')
!  %(  Fix DLMK10.10-CTL so that it is easy for Release Engineering
!      to use for a build in a single directory.  Change LIBARY to
!      CPYLIB in INTERFILS.CTL.  Remove references to DILV6.FOR in
!      INTERFILS.CTL and INTR10.10-CTL.
!  )%
!
! Edit (%O'125', '24-Aug-84', 'Sandy Clemens')
!  %(  In build procedure send mail to "." rather than to a specific
!      person.  File:  INTERFILS.CTL. )%
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
! Edit (%O'143', '28-Oct-87', 'Andy Puchrik')
!  %( Update the logicals to V2-2 names )%
!
! **EDIT**
!
! [%O'35'] Files needed on WDL:
! DILC36.INT
!
! [%O'35'] Files needed on WDT:
! DITC36.INT
!
! [%O'35'] Files needed on WDX:
! DIXC36.INT
!
! [%O'116'] Files needed on SYS:
! CPYLIB.EXE
!
! [%O'35'] Files produced on DST:
! DIL.LIB
!
WORK::
@DEFINE DST: DSK:
@DEFINE WDL: DSK:, DL22:, DL21:, DL2:
@DEFINE WDX: DSK:, DX22:, DX21:, DX2:
@DEFINE WDT: DSK:, DT22:, DT21:, DT2:
@GOTO BUILD
!
MASTER::
@TAK BATCH.CMD
@DEFINE DST: DL22:
@DEFINE WDL: DL22:, DL21:, DL2:
@DEFINE WDX: DX22:, DX21:, DX2:
@DEFINE WDT: DSK:,DT22:, DT21:, DT2:
@GOTO BUILD

! For release engineering or any other build from a single directory
! containing everything using vanilla tools.
RENG::
@TAKE DIL-DEF.CMD			! [%O'132']
@GOTO BUILD

!
BUILD::
@CONNECT DST:
!
@DELETE DIL.LIB
!
@CPYLIB					! [%O'116']
*CREATE DIL
*INSERT DIL WDL:DILC36.INT
*INSERT DIT WDT:DITC36.INT
*INSERT DIX WDX:DIXC36.INT
*END
*LIST DIL DIL
*EXIT
@
!
! [%O'35'] Record exactly what we've made
@VDIRECTORY DIL.LIB,WDL:DILV7.FOR,        ! [%O'35'] [%O'116']
@CHECKSUM SEQUENTIAL                    ! [%O'35'] 
@                                       ! [%O'35'] 
!
DONDON::
@GOTO ENDEND
!
%ERR::
@GOTO ERRRTN
!
%TERR::
@GOTO ERRRTN
!
%CERR::
ERRRTN::
! [%O'125'] Send mail to "." rather than a specific person.
@MS
*SEND
*.
*
*INTERFILS batch stream
*The INTERFILS batch stream failed.
=^[
*SEND
*EXIT
!
ENDEND::
%FIN::
@
