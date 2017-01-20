! THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED
! OR COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE.
!
! COPYRIGHT  (C)  DIGITAL  EQUIPMENT  CORPORATION 1983, 1986.
! ALL RIGHTS RESERVED.

! This file will do either a master (i.e., from the ALU library
! directories, with results to the library directories) or a work (i.e.,
! with preference given to the work directory and results to the work
! directory) compile of the DIX routines (not including user interface
! routines stored under DL:).
!
! Start at tag WORK for work build, at tag MASTER for master build.
! If full build is submitted at once using WORK-DIL.CMD or
! MASTER-DIL.CMD, this batch job does the necessary modifications to
! dependency counts to make things run in the right order.
!
! [%O'24'] Start at tag RENG for a build from the connected directory
! only, using FIELD: for SYS:.  This is intended particularly for
! Release Engineering.
!
! Facility: DIX
! 
! Edit History:
! 
! new_version (1, 0)
! 
! edit (7, '23-Aug-82', 'David Dyer-Bennet')
!  %( Change version and revision standards everywhere.
!     Files: All. )%
!
! edit (9, '16-Sep-82', 'David Dyer-Bennet')
! %(  VERSION wasn't getting library-precompiled in the build procedure.
!     Files:  COMPDX.CTL )%
!
! Edit (%O'24', '22-Nov-82', 'David Dyer-Bennet')
! %(  Add release-engineering mode to build procedure.
!     Fix order of FIELDS, STAR36, VERSION in COMPDX.
!     Cancel COMPDT when we abort.
! )%
!
! Edit (%O'34', '10-Mar-83', 'Charlotte L. Richardson')
! %( Declare version 1.  All modules. )%
!
! new_version (2, 0)
! 
! Edit (%O'36', '11-Apr-84', 'Sandy Clemens')
! %( Put all Version 2 DIX development files under edit control.  Some of
!    the files listed below have major code edits, or are new modules.  Others
!    have relatively minor changes, such as cleaning up a comment.
!    FILES: COMDIX.VAX-COM, COMPDX.CTL, DIXCST.BLI, DIXDEB.BLI,
!    DIXDN.BLI (NEW), DIXFBN.BLI, DIXFP.BLI, DIXGBL.BLI, DIXGEN.BLI,
!    DIXHST.BLI, DIXINT.PR1, DIXINT.PR2, DIXLIB.BLI, DIXPD.BLI (NEW),
!    DIXREQ.REQ, DIXSTR.BLI, DIXUTL.BLI, DXCM10.10-CTL, MAKDIXMSG.BLI,
!    STAR36.BLI, VERSION.REQ.
! )%
!
! Edit (%O'40', '12-Apr-84', 'Sandy Clemens')
! %(  Fix COMPDX.CTL to use the V2 ALU directories.  FILE: COMPDX.CTL
! )%
! 
! Edit (%O'43', '9-Jul-84', 'Sandy Clemens')
! %(  Change FIELD: logical name to FIELDI: for RENG: tag.
!     Files:  COMPDX.CTL, DIXHST.BLI
! )%
!
! Edit (%O'44', '24-Aug-84', 'Sandy Clemens')
! %(  In build procedure send mail to "." rather than to a specific
!     person.  File:  COMPDX.CTL. )%
!
! Edit (%O'46', '24-Sep-84', 'Sandy Clemens')
!  %( Update the DIL build procedure for Release Engineering and
!     Customer builds.  Remove defining logical names in the build
!     .CTL files, TAKE DIL-DEF.CMD instead.  Remove cancelling the
!     unfinished batch jobs.  FILES: DIXHST.BLI, COMPDX.CTL )%
!
! new_version (2, 1)
! 
! Edit (%O'53', '3-Jul-86', 'Sandy Clemens')
!   %( Add remaining sources to V2.1 area.  Update copyright notices. )%
!
! Edit (%O'143', '28-Oct-87', 'Andy Puchrik')
!   %( Updated logicals for V2-2 names. )%
!
! **EDIT**
! 
! [%O'24'] Files needed on SRC:
! DIXDEB.REQ	DIXREQ.REQ
! FIELDS.BLI	STAR36.BLI	VERSION.REQ	DIXLIB.BLI
! DIXHST.BLI	DIXUTL.BLI	DIXGEN.BLI	DIXCST.BLI
! DIXSTR.BLI	DIXFBN.BLI	DIXFP.BLI	DIXDEB.BLI
! DIXGBL.BLI	INTERFILS.BLI	DIXDN.BLI	DIXPD.BLI
!
! [%O'24'] Files needed on SYS:
! BLISS.EXE	LINK.EXE
!
! [%O'24'] Files needed on BLI:
! XPORT.REL
!
! [%O'24'] Files produced on build directory:
! FIELDS.L36	STAR36.L36	VERSION.L36	DIXLIB.L36	DIXHST.REL
! DIXUTL.REL	DIXGEN.REL	DIXCST.L36	DIXSTR.REL	DIXFBN.REL
! DIXFP.REL	DIXDEB.REL	DIXGBL.REL	INTERFILS.REL	INTERFILS.EXE
! DIXV6.FOR	DIXV7.FOR	DIXC36.INT	DIXDN.REL	DIXPD.REL
!
WORK::
@DEFINE SRC: DSK:, DX22:, DX21:, DX2:
@define dsk: dsk:, DX22:, DX21:, DX2:
@goto compem

MASTER::
@TAK BATCH.CMD
@DEFINE SRC: DX22:, DX21:, DX2:
@connect DX22:
@GOTO COMPEM

! [%O'24'] For release engineering or any other build from a single directory
! [%O'24'] containing everything using vanilla tools.
RENG::                                  ! [%O'24'] 
@TAKE DIL-DEF.CMD			! [%O'46']
@GOTO COMPEM                            ! [%O'24'] 

compem::
@ERROR ?
@BLISS
*SRC:FIELDS/LIB/LIST                    ! [%O'24'] Move ahead of VERSION
*SRC:STAR36/LIB/LIST                    ! [%O'24'] Move ahead of VERSION
! [9] ADD COMPILATION OF VERSION.REQ
*SRC:VERSION/LIB/LIST
! [9] END OF INSERTION
!
! The library file must be compiled before any of the other modules
! are compiled, since they call it.
*SRC:dixlib/lib/list
!
*SRC:DIXHST/LIST
*SRC:dixutl/list
*SRC:dixgen/list
!
! The character set tables must be compiled before compiling the
! string conversion module.
*SRC:dixcst/lib/list
*SRC:dixstr/list
!
*SRC:dixfbn/list
*SRC:dixfp/list
*SRC:dixdn/list
*SRC:dixpd/list
!
*SRC:DIXDEB/LIST
*src:DIXGBL/LIST
!
! Produce update interface support elements
*SRC:INTERFILS/LIST
*/EXIT
!
@COPY INTERFILS.REL INTERF.REL
!
@LINK
*TTY:/LOG/LOGLEVEL:0
*INTERF/MAP/CONTENTS:ALL
*INTERF
! Need DIXDEB because DIXREQ.REQ (used in INTERFILS) defines debugging routines
! as external.  Need DIXUTL because DIXDEB uses ARGADR.  None of this is ever
! referenced, so I could kludge by using /DEFINE, or simply ignore the errors,
! but this way is slightly more robust since a change in INTERFILS that causes
! debugging stuff to actually be referenced will work now.
! All of the above need DIXHST.
*SRC:DIXDEB,SRC:DIXUTL,SRC:DIXHST
! INTERFILS uses XPORT string handling and IO.
*BLI:XPORT/SEARCH
! Force loading of $OTSCH from B362LB to resolve SS$UNW (never referenced)
*/require:unwnd.
*/GO
!
@SAVE INTERFILS
@START
!
! [%O'24'] Record exactly what we produced
@VDIRECTORY DIXV6.FOR, DIXV7.FOR,       ! [%O'24'] 
@CHECKSUM SEQUENTIAL                    ! [%O'24'] 
@                                       ! [%O'24'] 
!
DONOK::
@MODIFY BATCH COMPDL /DEPEND:-1
@GOTO ENDEND
!
!
%ERR::
@GOTO ERRRTN
%TERR::
ERRRTN::
! [%O'44'] Send mail to "." rather than a specific person.
@MS
*SEND
*.
*
*COMPDX BATCH JOB
*The COMPDX batch job terminated with errors.
=^[
*SEND
*
*EXIT
!
ENDEND::
%FIN::
@
