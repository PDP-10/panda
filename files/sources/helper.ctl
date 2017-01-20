! Name: HELPER.CTL
! Date: 8 Jan 1982
!
!COPYRIGHT (C) 1981, 1982 BY DIGITAL EQUIPMENT CORPORATION, MAYNARD, MASS.
!
!
!THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY BE USED AND COPIED
!ONLY  IN  ACCORDANCE  WITH  THE  TERMS  OF  SUCH LICENSE AND WITH THE
!INCLUSION OF THE ABOVE COPYRIGHT NOTICE.  THIS SOFTWARE OR ANY  OTHER
!COPIES THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE AVAILABLE TO ANY
!OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF THE  SOFTWARE  IS  HEREBY
!TRANSFERRED.
!
!THE INFORMATION IN THIS SOFTWARE IS SUBJECT TO CHANGE WITHOUT  NOTICE
!AND  SHOULD  NOT  BE  CONSTRUED  AS A COMMITMENT BY DIGITAL EQUIPMENT
!CORPORATION.
!
!DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR RELIABILITY  OF  ITS
!SOFTWARE ON EQUIPMENT WHICH IS NOT SUPPLIED BY DIGITAL.
!
!
!
!This control  file  is provided  for  information purposes  only.   The
!purpose of the  file is to  document the procedures  used to build  the
!distributed software.  It is  unlikely that this  control file will  be
!able  to  be  submitted  without  modification  on  consumer   systems.
!Particular attention should be given to logical names, structure  names
!and other such parameters.  Submit  times may vary depending on  system
!configuration and load.  The availability of sufficient disk space  and
!core is mandatory.
!
! To produce a CREF listing of the source file, submit this
!   job with the switch "/TAG:CREF"
!
!
!
! Files required on SYS:
!
!  MACRO.EXE
!  PA1050.UNV
!  CREF.EXE
!  UUOSYM.UNV
!  MACTEN.UNV
!
! Files required on DSK:
!
!  HELPER.MAC
!  HELPER.CTL
!
! Files produced by this control file
!
!  HELPER.REL
!  HELPER.LOG
!
! Files produced if CREF option is used
!
!  HELPER.LST
!
!
@DEF OUT: NUL:
@GOTO SKPCRF
CREF:: @DEF OUT: DSK:
SKPCRF::
!
@TAK BATCH.CMD
!
@INFO LOG ALL
!
! Set up SYS: definition, show definitions for SYS: and DSK:
!
;@DEFINE SYS: PS:<SUBSYS>
!
!
! Show the input files
!
@VDIRECTORY HELPER.MAC,HELPER.CTL,
@CHECKSUM SEQ
@
!
! Show the libraries used to build HELPER
!
@VDIRECT SYS:MACRO.EXE,SYS:PA1050.EXE,SYS:CREF.EXE,SYS:UUOSYM.UNV,SYS:MACTEN.UNV,
@CHECKSUM SEQ
@
!
!
! Show the versions of the software used to build HELPER
!
@GET SYS:MACRO
@INFORMATION VERSION
@GET SYS:PA1050
@INFORMATION VERSION
@GET SYS:CREF
@INFORMATION VERSION
!
! Build HELPER
!
@COMPILE /COMPILE /CREF DSK:HELPER.MAC
!
!
! Generate a cross reference
!
@R CREF
*OUT:=HELPER.CRF
!
!
! Show checksums of product
!
@VDIRECT HELPER.REL,
@CHECKSUM SEQ
@
!
!
![END OF HELPER.CTL]
