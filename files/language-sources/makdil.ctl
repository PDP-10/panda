! This command file makes the dil libraries (for autopatch) and then
! the DIL.REL file itself, assuming the existence of the .REL files
! in canonical places (defined by logical names for the different modes
! this file can be sugmitted in).  Results are placed in DSTDL:.
!
! Start at tag WORK to build from connected directory followed by alu
! libraries.  Start at tag master to build from ALU libraries.  Start
! at tag RENG to build from connected directory ONLY, using FIELDI:
! tools.

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
!     Add DAP routines to library (MAKDIL)
! )%
! Edit (%O'35', '22-Nov-82', 'David Dyer-Bennet')
! %(  Add release-engineering mode to build procedure.
!     Associated with DIX %O'24', DIT %O'703'
! )%
! Edit (%O'36', '24-Nov-82', 'David Dyer-Bennet', 'QAR 3')
! %(  Change order of modules in library to remove need to search
!     twice when loading a program using DAP routines and no DIX (the
!     symbol DILRET was not found).
! )%
! EDIT (%O'40', '6-DEC-82', 'David Dyer-Bennet')
! %(  Make our source directories include a frozen copy of the DAP code we
!     depend on.  Also make official places for xport, pa1050.  Teach the
!     build procedures to use these places!!
! )%
! Edit (%O'42', '16-Dec-82', 'David Dyer-Bennet')
! %(  Add autopatch stuff, including building autopatch rel libraries,
!     autopatch control files and definition files, putting some of these
!     on the tape.
! )%
! Edit (%O'44', '19-Jan-83', 'David Dyer-Bennet')
! %(  Change AUTOPATCH product definition!!!!  This changes all the libraries
!     used, the patch and build, the file shipped on the tape, etc.
! )%
! Edit (%O'47', '19-Jan-83', 'David Dyer-Bennet')
! %(  Fix two typos in MAKDIL.
!     Files: MAKDIL.CTL
! )%
! Edit (%O'54', '20-Jan-83', 'David Dyer-Bennet')
! %(  Correct error in library location in MAKDIL.
!     Files: MAKDIL.CTL
! )%
! Edit (%O'73', '19-May-83', 'David Dyer-Bennet')
!  %( Add DILSWI require file to headings of all modules.  
!     MAKDIL.CTL: add copyrights to XPN2V1, DAP2V1 libraries 
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
! Edit (%O'114', '20-Jun-84', 'Sandy Clemens')
!  %(  UPDATE MAKDIL.CTL, SOURCE-TAPE.CTL to use XP1A:, EX1A:, and DP1A:
!      rather than BLISSNET:, RMSEXT:, and RMSDAP:.
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
! Edit (%O'140', '24-Sep-85', 'Sandy Clemens')
!  %( Change references to LANG: to GREEN: in MAKDIL.CTL )%
!
! Edit (%O'143', '28-Oct-87', 'Andy Puchrik')
!  %( Change logicals to include V2-2 names )%
! **EDIT**
!
! Files needed on SRCDX:
! DIXGEN.REL	DIXSTR.REL	DIXFBN.REL	DIXFP.REL	DIXUTL.REL
! DIXGBL.REL	DIXDEB.REL	DIXHST.REL	DIXDN.REL	DIXPD.REL
!
! Files needed on SRCDL:
! POS20.REL	POSGEN.REL	DILINT.REL	DILHST.REL	[73] CPYRIT.REL
!
! Files needed on SRCDT:
! TTT.REL	DAPPER.REL	DITHST.REL
!
! Files needed on DP1A:
! DAP2V1.REL
!
! Files needed on XP1A:
! XPN2V1.REL
!
! Files needed on SYS:
! MAKLIB.EXE
!
! [%O'54'] Files produced in DSTDL:
! DIL.REL	DIL2V2.REL
!
! [%O'54'] Files produced in DSTDT:
! DIT2V2.REL
!
! [%O'54'] Files produced in DSTDX:
! DIX2V2.REL
!
WORK::
@DEFINE SRCDX: DSK:, DX22:, DX21:, DX2:
@DEFINE SRCDL: DSK:, DL22:, DL21:, DL2:
@DEFINE SRCDT: DSK:, DT22:, DT21:, DT2:
@DEFINE DSTDL: DSK:
@DEFINE DSTDT: DSK:
@DEFINE DSTDX: DSK:
!  ALU-FTS-DIU.CMD defines XP1A:, DP1A:, etc...
@TAKE GREEN:<DATA-INTERCHANGE.ALU>ALU-FTS-DIU.CMD
@GOTO COMBIN

MASTER::
@DEFINE SRCDX: DX22:, DX21:, DX2:
@DEFINE SRCDL: DL22:, DL21:, DL2:
@DEFINE SRCDT: DT22:, DT21:, DT2:
@DEFINE DSTDL: DL22:
@DEFINE DSTDT: DT22:
@DEFINE DSTDX: DX22:
!  ALU-DIL.CMD defines XP1A:, DP1A:, etc...
@TAKE GREEN:<DATA-INTERCHANGE.ALU>ALU-FTS-DIU.CMD
@GOTO COMBIN

! For release engineering or any other build from a single directory
! containing everything using vanilla tools.
RENG::
@TAKE DIL-DEF.CMD			! [%O'132']
@GOTO COMBIN
! Now assemble the autopatch libraries.
COMBIN::
! Show logicals finally chosen
@information logical
!
! Make DIL library (use autopatch names for the autopatch libraries)
@DELETE DSTDL:DIL2V2.REL
@APPEND SRCDL:POS20.REL, SRCDL:POSGEN.REL, SRCDL:DILINT.REL, SRCDL:DILHST.REL -
@ (TO) DSTDL:DIL2V2.REL
!
! Make DIT Library (use autopatch names for the autopatch libraries)
@DELETE DSTDT:DIT2V2.REL
@APPEND SRCDT:TTT.REL, SRCDT:DAPPER.REL, SRCDT:DITHST.REL -
@ (TO) DSTDT:DIT2V2.REL
!
! Make DIX Library (use autopatch names for the autopatch libraries)
@DELETE DSTDX:DIX2V2.REL
@APPEND SRCDX:DIXGEN.REL, SRCDX:DIXSTR.REL, SRCDX:DIXFBN.REL, -
@  SRCDX:DIXFP.REL, SRCDX:DIXDN.REL, SRCDX:DIXPD.REL, -
@  SRCDX:DIXUTL.REL, SRCDX:DIXGBL.REL, -
@  SRCDX:DIXDEB.REL, SRCDX:DIXHST.REL -
@ (TO) DSTDX:DIX2V2.REL
!
!
! Now, put together the proper DIL.REL.  This code can and should be stolen
! into the autopatch patch-and-build procedure, since it builds from the
! libraries.
@DELETE DSTDL:DIL.REL			! Start clean	
@MAKLIB
*DSTDL:DIL=DSTDL:DIL2V2/EXTRACT:DILHST
*DSTDL:DIL=DSTDL:DIL,DSTDL:DIL2V2/APPEND:(POSSTR,POSFB,POSFP,POSDN,POSPD,POSFXD,POSDXF,POSPXD,POSDXP,POSPXF,POSFXP,POSGEN)
*DSTDL:DIL=DSTDL:DIL,DSTDX:DIX2V2/APPEND:(DIXGEN,DIXSTR,DIXFBN,DIXFP,DIXDN,DIXPD)   ! [%O'54'] 
*DSTDL:DIL=DSTDL:DIL,DSTDT:DIT2V2/APPEND
*DSTDL:DIL=DSTDL:DIL,DSTDL:DIL2V2/APPEND:(DILINT,DILHST)
*DSTDL:DIL=DSTDL:DIL,DSTDX:DIX2V2/APPEND:(DIXUTL,DIXGBL,DIXDEB,DIXHST)
*DSTDL:DIL=DSTDL:DIL,DP1A:DAP2V1/APPEND,XP1A:XPN2V1/APPEND
*DSTDL:DIL=DSTDL:DIL/INDEX
*/EXIT
!
! Record exactly what we produced
@VDIRECTORY DSTDL:DIL.REL, DSTDL:DIL2V2.REL, DP1A:DAP2V1.REL, -
@  XP1A:XPN2V1.REL, DSTDT:DIT2V2.REL, DSTDX:DIX2V2.REL,        ! [%O'54'] !
@ CHECKSUM SEQUENTIAL
@
!
! Done, and it worked, so modify next stream's dependency
DONDON::
@MODIFY BATCH INTERF/DEPEND:-1
@GOTO ENDEND

%ERR::
@GOTO ERRRTN
%TERR::
ERRRTN::
!
ENDEND::
%FIN::
@;FOO
