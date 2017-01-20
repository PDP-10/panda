! This file will do either a master (i.e., from the ALU library
! directories, with results to the library directories) or a work (i.e.,
! with preference given to the work directory and results to the work
! directory) compile of the DIL user interface routines.
!
! Start at tag WORK for work build, at tag MASTER for master build.
! If full build is submitted at once using WORK-DIL.CMD or
! MASTER-DIL.CMD, this batch job does the necessary modifications to
! dependency counts to make things run in the right order.
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
! edit (9, '16-Sep-82', 'David Dyer-Bennet')
! %( (in progress) Compilation of DILHST was being missed somehow
!    (looks like BATCON glitch)
!    Files: DL1:COMPDL.CTL )%
!
! Edit (%O'26', '29-Oct-82', 'David Dyer-Bennet')
! %(  Accomodate DIT, DIX, and DIL build procedures.
!     Associated edits: DIT 6, DIX 20
!     Add DIT dependencies to DIX, DIL compiles, and to submit command files.
! )%
! Edit (%O'35', '22-Nov-82', 'David Dyer-Bennet')
! %(  Add release-engineering mode to build procedure.
!     Cancel COMPDT when COMPDL aborts.
!     Associated with DIX %O'24'
! )%
! Edit (%O'45', '19-Jan-83', 'David Dyer-Bennet')
! %(  Add Installation Certification procedure everywhere.
!     Teach COMPDL to run off the doc file when dil is compiled.
! )%
! Edit (%O'55', '20-Jan-83', 'David Dyer-Bennet')
! %(  Add the beware file to the library, build procedures, and etc.
! )%
! Edit (%O'61', '24-Jan-83', 'David Dyer-Bennet')
! %(  Add a help file for 10/20.  Remove the old release-tape build mode,
!     which probably doesn't work by now and in any case isn't needed.
!     Add DILBWR.RNO to list of files needed on SRC:, as should have been
!     done for %o'55', but wasn't for some reason.
! )%
! Edit (%O'64', '26-Jan-83', 'David Dyer-Bennet')
! %(  Penultimate DOC file cleanup -- add TOC (thus changes to build),
!     spellings, consistency of style, etc.
! )%
! Edit (%O'72', '23-Feb-83', 'David Dyer-Bennet')
! %(  Add TOPS-10 native build procedure.  Related to DIX edit 33.
!     COMPDL.CTL: Call DSR, not runoff
! )%
! Edit (%O'73', '19-May-83', 'David Dyer-Bennet')
!  %( Add DILSWI require file to headings of all modules.  
!     COMPDL.CTL: add compiling of CPYRIT (NEEDED ON 20 ONLY)
!  )%
! Edit (%O'74', '8-June-83', 'Charlotte L. Richardson')
!  %( Declare version 1 complete.  All modules.
!  )%
!
! new_version (1, 1)
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
! Edit (%O'101', '18-Apr-84', 'Sandy Clemens')
!  %( Change COMPDL.CTL DSK: definition so that it can find DIX
!     require files.  FILES: DILHST.BLI, COMPDL.CTL.
!  )%
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
! Edit (%O'133', '28-Sep-84', 'Sandy Clemens')
!  %( Update TOPS-10 build procedure to make the build easier for 
!     Release Engineering and customers.  Make the TOPS-10 and TOPS-20
!     build procedure skip creating the documents under tag RENG::
!     because .RNO files are not shipped to customers any more.
!     FILES: DLCM10.10-CTL, DLMK10.10-CTL, INTR10.10-CTL, COMPDL.CTL,
!     DILHST.BLI  )%
!
! new_version (2, 1)
!
! Edit (%O'142', '1-Jun-86', 'Sandy Clemens')
!   %( Remove references to NEW: and PS:<NEW>. )%
!
! Edit (%O'143', '28-Oct-87', 'Andy Puchrik')
!   %( Update logicals to V2-2 names. )%

! **EDIT**
!
! [%O'35'] Files needed on SRC:
! POSGEN.BLI	DILHST.BLI	POS20.BLI	DILINT.BLI
! [%O'45'] DIL.RND		[%O'61'] DIL.RNH
! [%O'61'] DILBWR.RNO           [%O'64'] DILDOC.INI
! [%O'73'] CPYRIT.MAC
!
! [%O'35'] Files needed on DSK:
! DIXREQ.REQ	DIXLIB.L36	VERSION.L36	FIELDS.L36	DIXDEB.REQ
! STAR36.L36
!
! [%O'35'] Files needed on SYS:
! BLISS.EXE     [%O'45'] [%O'55'] RUNOFF.EXE	[%O'64'] TOC.EXE
!
! [%O'35'] Files produced on build directory:
! POSGEN.REL	DILHST.REL	POS20.REL	DILINT.REL
! [%O'45'] DIL.DOC[%O'73'] CPYRIT.REL
!
WORK::
@DEFINE SRC: DSK:, DL22:, DL21:, DL2:, DX22:, DX21:, DX2:
@DEFINE DSK: DSK:, DL22:, DL21:, DL2:, DX22:, DX21:, DX2:
!
![%O'133'] [%O'61'] [%O'55'] [%O'45'] Make DOC, HLP, and BWR files
@RUNOFF
*SRC:DIL.RND/CONTENTS/OUT:DILDOC.BOD    ! [%O'64'] [%O'45'] 
*SRC:DILBWR.RNO/OUTPUT:DIL.BWR          ! [%O'55'] 
*SRC:DIL.RNH                            ! [%O'61'] 
*/EXIT                                  ! [%O'45'] 
@TOC                                    ! [%O'72'] [%O'64'] 
! [%O'64'] Next 7 lines are [%O'64'] ; TOC won't accept the comments
*DIL
*
*
*
*
*
*
@RUNOFF
*DILDOC.INI                             ! [%O'64'] 
*/EXIT                                  ! [%O'64'] 
@DEL DIL.DOC                            ! [%O'64'] 
@APPEND DILDOC.MEM,DILDOC.BOD (TO) DIL.DOC      ! [%O'64'] 
@DEL DILDOC.MEM,DILDOC.BOD              ! [%O'64'] 
@goto compem

MASTER::
@TAK BATCH.CMD
@DEFINE SRC: DL22:, DL21:, DL2:, DX22:, DX21:, DX2:
@define dsk: DL22:, DL21:, DL2:, DX22:, DX21:, DX2:
@connect DL21:
!
![%O'133'] [%O'61'] [%O'55'] [%O'45'] Make DOC, HLP, and BWR files
@RUNOFF
*SRC:DIL.RND/CONTENTS/OUT:DILDOC.BOD    ! [%O'64'] [%O'45'] 
*SRC:DILBWR.RNO/OUTPUT:DIL.BWR          ! [%O'55'] 
*SRC:DIL.RNH                            ! [%O'61'] 
*/EXIT                                  ! [%O'45'] 
@TOC                                    ! [%O'72'] [%O'64'] 
! [%O'64'] Next 7 lines are [%O'64'] ; TOC won't accept the comments
*DIL
*
*
*
*
*
*
@RUNOFF
*DILDOC.INI                             ! [%O'64'] 
*/EXIT                                  ! [%O'64'] 
@DEL DIL.DOC                            ! [%O'64'] 
@APPEND DILDOC.MEM,DILDOC.BOD (TO) DIL.DOC      ! [%O'64'] 
@DEL DILDOC.MEM,DILDOC.BOD              ! [%O'64'] 
@GOTO COMPEM

! [%O'35'] For release engineering or any other build from a single directory
! [%O'35'] containing everything using vanilla tools.
RENG::                                  ! [%O'35'] 
@TAKE DIL-DEF.CMD			! [%O'132']
@GOTO COMPEM                            ! [%O'35'] 

compem::
@ERROR ?
@bliss
! [9] For some reason, compiling of DILHST was being skipped; looks
! like a BATCON glitch, so I've tried swapping the entries around and 
! adding this comment in hopes it goes away.
*src:posgen.bli/list
*src:dilhst.bli/list
*src:pos20.bli/list
*src:dilint.bli/list
!
! [%O'133'] Move building DOC, HLP and BWR files to tags MASTER:: and WORK::
!
! [%O'73'] Compile generic copyright notice module
@MACRO                                  ! [%O'73'] 
! [%O'73'] Add next line
*CPYRIT,CPYRIT=CPYRIT
!
DONOK::
@MODIFY BATCH COMPDT /DEPEND:-1         ! [%O'26'] 
@GOTO ENDEND
!
!
%ERR::
@GOTO ERRRTN
%TERR::
ERRRTN::
!
ENDEND::
%FIN::
@
