! This CTL file builds the library and relocatable object files which
! make up the Transportable BLISS Interface to DECNET-20. This control
! file is for Release Engineering and customers ONLY.
!
! Input files implicitly required:
!	BLI:XPORT.L36		XPORT definitions
!	BLI:MONSYM.L36		Monitor definitions
!	UNV:MONSYM.UNV		 ditto
!	UNV:MACSYM.UNV		PDP-10 macros
!	JSYSDEF.R36		JSYS definitions (should be in EX1A: or EX2:)
!
! Source files needed:
!	BLISSNET.REQ		Source for Blissnet library
!	BLISSNET-DESCRIPTOR.REQ	Source for Blissnet structure library
!	BLISSNET20.R36		Internal definitions for Blissnet-20
!	XPNCLO.B36		Close a network link
!	XPNDIS.B36		Disconnect a logical link
!	CPYRIT.MAC		Copyright notice
!	XPNERR.B36		Return error message for a given error code
!	XPNEVE.B36		Return event information for logical links
!	XPNFAI.B36		Default fialure routine for Blissnet-20
!	XPNGET.B36		Get data from a DECnet link
!	XPNPUT.B36		Put data to a network link
!	XPNUTL.B36		Utility routines for Blissnet-20
!	XPNPSI.MAC		Interface to software interrupt system
!	XPNOPN.B36		Open a network link
!	XPNPMR.B36		Do poor man's routing
!
! Output files produced:
!	BLISSNET.L36		Transportable macro and field definitions
!				also Defines $XPN_DESCRIPTOR, a temporary hack
!				which can disappear when XPORT string
!				descriptors get a CHARACTER_SIZE option.
!	XPNCLO.REL		Close a network link
!	XPNDIS.REL		Disconnect a logical link
!	XPNERR.REL		Return error message for a given error code
!	XPNEVE.REL		Return event information for logical links
!	XPNFAI.REL		Default failure rotuine for Blissnet-20
!	XPNGET.REL		Get data from a DECnet link
!	XPNOPN.REL		Open a network link
!	XPNPUT.REL		Put data to a network link
!	XPNUTL.REL		Utility routines for Blissnet-20
!	XPNPMR.REL		Do poor man's routing
!	CPYRIT.REL		Copyright notice
!	XPNPSI.REL		Interface to software interrupt system
!	BLISSNET20.L36		TOPS-20-specific macros and fields
!	XPN2V1.REL		Blissnet .REL library.
!
! Edit History:
!
! new_version (1, 0)
!
! Edit (%O'4', '24-Sep-84', 'Sandy Clemens')
!  %( Add XPN1A-DIL.CTL which is the XPN1A.CTL piece for Release
!     Engineering and customers.  FILES:  XPN1A-DIL.CTL (NEW),
!     XPNHST.BLI )%
!
! **EDIT**

COMBIN::
! Show logical names actually chosen.
@TAKE DIL-DEF.CMD
@INFORMATION LOGICAL
@NOERROR
! Do Bliss compilations
@BLISS
*blissnet+blissnet-descriptor/library:blissnet
*blissnet20/library:blissnet20
*xpnclo/OPTLEVEL:3
*xpndis/OPTLEVEL:3
*xpnerr/OPTLEVEL:3
*xpneve/OPTLEVEL:3
*xpnfai/OPTLEVEL:3
*xpnget/OPTLEVEL:3
*xpnopn/OPTLEVEL:3
*xpnput/OPTLEVEL:3
*xpnutl/OPTLEVEL:3
*xpnpmr/OPTLEVEL:3
! Do Macro compilations
@MACRO
*CPYRIT,=CPYRIT
*XPNPSI,=XPNPSI
! Record checksums of REL files
@VDIRECTORY BLISSNET.L36,BLISSNET20.L36,XPNCLO.REL*,XPNDIS.REL*,XPNERR.REL*,
@ CHECKSUM SEQUENTIAL
@
@VDIRECTORY XPNEVE.REL*,XPNFAI.REL*,XPNGET.REL*,XPNOPN.REL*,XPNPUT.REL*,
@ CHECKSUM SEQUENTIAL
@
@VDIRECTORY XPNUTL.REL*,XPNPMR.REL*,CPYRIT.REL*,XPNPSI.REL*,
@ CHECKSUM SEQUENTIAL
@
! Delete old library
@DELETE XPN2V1.REL
! Construct new library
@APPEND CPYRIT.REL,XPNOPN.REL,XPNPMR.REL,XPNCLO.REL,XPNDIS.REL XPN2V1.REL
@APPEND XPNERR.REL,XPNEVE.REL,XPNFAI.REL,XPNGET.REL,XPNPUT.REL XPN2V1.REL
@APPEND XPNUTL.REL,XPNPSI.REL XPN2V1.REL
! Record exactly what was produced
@VDIRECTORY XPN2V1.REL*,
@ CHECKSUM SEQUENTIAL
@
@
@MODIFY BATCH DAP1A/DEPEND:-1
@GOTO ENDEND
%ERR::
ENDEND::
%FIN::
@EXPUNGE
