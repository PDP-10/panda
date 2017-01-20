! THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED
! OR COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE.
!
! COPYRIGHT  (C)  DIGITAL  EQUIPMENT  CORPORATION 1983, 1986.
! ALL RIGHTS RESERVED.
!
! This file will do either a master (i.e., from the ALU library
! directories, with results to the library directories) or a work (i.e.,
! with preference given to the work directory and results to the work
! directory) compile of the DIT routines.
!
! Start at tag WORK for work build, at tag MASTER for master build.
! [%O'36'] Start at tag RENG for build from connected directory only,
! [%O'36'] using FIELDI: software.
! If full build is submitted at once using WORK-DIL.CMD or
! MASTER-DIL.CMD, this batch job does the necessary modifications to
! dependency counts to make things run in the right order.
!
! Facility: DIT
! 
! Edit History:
! 
! new_version (1, 0)
! 
! edit (%o'1', '15-Oct-82', 'Charlotte L. Richardson')
! %( Change version and revision standards everywhere.  )%
!
! Edit (%O'6', '29-Oct-82', 'David Dyer-Bennet')
! %(  Accomodate DIT, DIX, and DIL build procedures. 
!     Associated edits: DIX 20, DIL 26
!     Put in proper dependency for full DIL build
! )%
! Edit (%O'36', '22-Nov-82', 'David Dyer-Bennet')
! %(  Add release-engineering mode to build procedure.
!     Associated with DIX %O'24', DIL %O'35'.
!     Remove use of DX1:.
! )%
! Edit (%O'55', '20-Jan-83', 'David Dyer-Bennet')
! %(  Update copyright notices missed earlier.
!     Files: COMDIT.VAX-COM, COMPDT.CTL, DITHST.BLI, TO.CTL
! )%
!
! Edit (%O'61', '9-Mar-83', 'Charlotte L. Richardson')
! %( Declare version 1.  All modules. )%
!
! new_version (2, 0)
!
! Edit (%O'65', '11-Apr-84', 'Sandy Clemens')
! %( Add DIT V2 files to DT2:. )%
!
! Edit (%O'66', '18-Apr-84', 'Sandy Clemens')
! %( Fix COMPDT.CTL -- logical name type.  FILES: DITHST.BLI,
!    COMPDT.CTL )%
!
! Edit (%O'100', '24-Aug-84', 'Sandy Clemens')
! %( In build procedure send mail to "." rather than to a specific
!    person.  File: COMPDX.CTL )%
!
! Edit (%O'102', '24-Sep-84', 'Sandy Clemens')
!  %( Update the DIL build procedure for Release Engineering and
!     Customer builds.  Remove defining logical names in the build
!     .CTL files, TAKE DIL-DEF.CMD instead.  Remove cancelling the
!     unfinished batch jobs.  FILES: DITHST.BLI, COMPDT.CTL )%
!
! new_version (2, 1)
! 
! Edit (%O'112', '1-Jun-86', 'Sandy Clemens')
!   %( Add sources for version 2.1.  Update copyright notices. )%
!
! Edit (%O'143', '28-Oct-87', 'Andy Puchrik')
!   %( Updated logicals for V2-2 names )%
!
! End of revision history
! **EDIT**
!
! Files needed in this directory:
!	RMSUSR.R36	DITHST.BLI	DAPPER.B36	TTT.MAC
!	FT20.MAC
!
![%O'36']  Files needed in SRCDX:
!	FIELDS.L36	VERSION.L36	STAR36.L36
!
! System files needed:
!	MACRO.EXE	BLISS.EXE	CREF.EXE
!	(BLI:TUTIO debug only)
! 
WORK::
@DEFINE SRC: DSK:, DT22:, DT21:, DT2:
@DEFINE DSK: DSK:, DT22:, DT21:, DT2:
@DEFINE SRCDX: DSK:, DX22:, DX21:, DX2:
@GOTO COMPEM

MASTER::
@TAK BATCH.CMD
@DEFINE SRC: DT22:, DT21:, DT2:
@DEFINE SRCDX: DX22:, DX21:, DX2:
@CONNECT DT22:
@I LOG 
@GOTO COMPEM

! [%O'36'] For release engineering or any other build from a single directory
! [%O'36'] containing everything using vanilla tools.
RENG::                                  ! [%O'36'] 
@TAKE DIL-DEF.CMD			! [%O'102']
@GOTO COMPEM                            ! [%O'36'] 

compem::
@ERROR ?

@COPY SRCDX:FIELDS.L36 FIELDS.L36       ! [%O'36'] 
@COPY SRCDX:VERSION.L36 VERSION.L36     ! [%O'36'] 
@COPY SRCDX:STAR36.L36 STAR36.L36       ! [%O'36'] 

@BLISS
*SRC:DAPPER.B36/LIST
@I LOG SRC:
@BLISS
*SRC:DITHST.BLI/LIST

@MACRO
*TTT.REL,TTT.CRF/C=SRC:FT20.MAC,SRC:TTT.MAC	! [%O'65']
@CREF
*TTT.LST=TTT.CRF/O

@MODIFY BATCH MAKDIL /DEPEND:-1         ! [%O'6'] 

@GOTO ENDEND
!
!
%ERR::
@GOTO ERRRTN
%TERR::
ERRRTN::

! [%O'100'] Send mail to "." rather than a specific person.
@MS
*SEND
*.
*
*COMPDT BATCH JOB
*The COMPDT batch job terminated with errors.
=^[
*SEND
*
*EXIT
!
ENDEND::
%FIN::
@
