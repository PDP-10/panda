!   Submit the jobs to compile a master DIL
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
! Edit (%O'26', '29-Oct-82', 'David Dyer-Bennet')
! %(  Accomodate DIT, DIX, and DIL build procedures.
!     Associated edits: DIT 6, DIX 20
!     Add DIT dependencies to DIX, DIL compiles, and to submit command files.
! )%
!
! Edit (%O'73', '10-Mar-83', 'Charlotte L. Richardson')
! %( Declare version 1.  All modules.
! )%
!
! Edit (%O'75', '12-Apr-84', 'Sandy Clemens')
! %(  Put all Version 2 DIL development files under edit control.
! )%
!
! Edit (%O'76', '18-Apr-84', 'Sandy Clemens')
!  %(  Put correct logical names into MASTER-DIL.CMD.
!      FILES: MASTER-DIL.CMD, DILHST.BLI
!  )%
!
! Edit (%O'77', '18-Apr-84', 'Sandy Clemens')
!  %(  Change /TAG: from WORK to MASTER in MASTER-DIL.CMD.
!      FILES: MASTER-DIL.CMD, DILHST.BLI
!  )%
!
! Edit (%O'143', '28-Oct-87', 'Andy Puchrik')
!  %( Update logicals to V2-2 names. )%
!
TAK PKGbld:[PACKAGING]PACKAGING-DEF.CMD
TAK DIL-def.CMD
SUBMIT utdil:COMPDX /TAG:MASTER /TIME:00:15:00/LOGN:PKGLOG:[LOGS.UTILITIES]COMPDX.LOG
SUBMIT utdiln:COMPDL /TAG:MASTER /DEPEND:1/LOGN:PKGLOG:[LOGS.UTILITIES]COMPDL.LOG
SUBMIT utdil:COMPDT /TAG:MASTER /DEPEND:1/LOGN:PKGLOG:[LOGS.UTILITIES]COMPDT.LOG ! [%O'26'] 
SUBMIT utdil:MAKDIL /TAG:MASTER /DEPEND:1/LOGN:PKGLOG:[LOGS.UTILITIES]MAKDIL.LOG
SUBMIT utdil:INTERFILS /TAG:MASTER /DEPEND:1/LOGN:PKGLOG:[LOGS.UTILITIES]INTERFILS.LOG
