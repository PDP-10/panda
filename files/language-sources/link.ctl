!
!
! NAME:	LINK.CTL
! DATE: 9-JUL-81
!
!
! This control file is provided for information purposes only.
! The  purpose  of the file is to document the procedures used
! to build the distributed software.  It  is  unlikely  to  be
! able  to  be executed without modification on other systems.
! In particular, attention should be given to  ersatz  devices
! and  structure names, PPNs and other such system parameters.
! Submit times may vary depending on configuration  and  load.
! The  availability  of  sufficient  disk  space  and  core is
! mandatory.  This  control  file  has  not  been  extensively
! tested  on  alternate  configurations.   It  has been  used
! successfully for the purpose for which it is  intended:   to
! build the distributed software.
!
!
! FUNCTION:	This  control file builds LINK version 5.1 from
! 		its source  files.  Submit  with  the  command
! 		@SUBMIT LINK/TIME:1:0:0
!
!
! Required files (latest releasd versions):
!
! SYS:	MACRO.EXE
!	LINK.EXE
!	PA1050.EXE
!
!	MACSYM.UNV
!	MONSYM.UNV
!	SCNMAC.UNV
!	MACTEN.UNV
!	UUOSYM.UNV
!
!	SCAN.REL
!	JOBDAT.REL
!	HELPER.REL
!
! DSK:	LNK%%%.MAC
!	PLT%%%.MAC
!	OVRPAR.MAC
!	OVRLAY.MAC
!
!	C2PLNK.CMD
!	C2POVL.CMD
!
!	L2PLNK.CCL
!
! Output files on DSK:
!
!	LINK.EXE
!	OVRLAY.REL
!
! Output listings:
!
!	LINK.MAP
!
!
!
! Make batch stream restartable from this point.
!
LINK::
@CHKPNT LINK
!
@TAKE BATCH.CMD
!
! Delete all older intermediate and listing files.
!
@DELETE LNK%%%.REL,PLT%%%.REL,OVRLAY.REL
@DELETE PLTPRM.UNV,FORMSC.UNV,LNK%%%.UNV,OVRPAR.UNV
@DELETE LINK.MAP
@EXPUNGE
!
! Show where things are coming from.
!
@INFORMATION LOGICAL ALL
!
!
! Record checksums of input sources, REL, and UNV files.
!
@VDIRECTORY SYS:MACRO.EXE,SYS:LINK.EXE,SYS:PA1050.EXE,
@CHECKSUM SEQUENTIAL
@
@VDIRECTORY SYS:MACSYM.UNV,SYS:MONSYM.UNV,
@CHECKSUM SEQUENTIAL
@
@VDIRECTORY SYS:SCNMAC.UNV,SYS:MACTEN.UNV,SYS:UUOSYM.UNV,
@CHECKSUM SEQUENTIAL
@
@VDIRECTORY SYS:JOBDAT.REL,SYS:SCAN.REL,SYS:HELPER.REL,
@CHECKSUM SEQUENTIAL
@
@VDIRECTORY LNK%%%.MAC,PLT%%%.MAC,OVR%%%.MAC,
@CHECKSUM SEQUENTIAL
@
@VDIRECTORY C2PLNK.CMD,C2POVL.CMD,L2PLNK.CCL,
@CHECKSUM SEQUENTIAL
@
!
!
! Show versions of MACRO and LINK.
!
@GET SYS:MACRO
@INFORMATION VERSION
!
@GET SYS:LINK
@INFORMATION VERSION
!
@GET SYS:PA1050
@INFORMATION VERSION
!
!
! Compile the source files.
!
@TYPE C2PLNK.CMD
@COMPILE /COMPILE @C2PLNK.CMD
!
@TYPE C2POVL.CMD
@COMPILE /COMPILE @C2POVL.CMD
!
! Load the REL files for LINK.
!
@LINK
*@L2PLNK.CCL
!
! Record the versions of LINK and OVRLAY.
!
@GET LINK
@INFORMATION VERSION
!
@START
*OVRLAY.REL/VALUE:%OVRLA
!
!
! Record checksums of the output files.
!
@VDIRECTORY LINK.EXE,OVRLAY.REL,
@CHECKSUM SEQUENTIAL
@
!
!
%TERR::
%CERR::
%ERR::
%FIN::
@LOGOUT
!
! [End of LINK.CTL]
