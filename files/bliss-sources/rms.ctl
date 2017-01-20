@GOTO WORK				; Comments not needed in log file
!
!   BRMS20.CTL		V(EDIT)==3.0(663) RMS version number
!
!	COPYRIGHT (C) DIGITAL EQUIPMENT CORPORATION 1984, 1986.
!	ALL RIGHTS RESERVED.
!
!	THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED  AND
!	COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE AND WITH
!	THE INCLUSION OF THE ABOVE COPYRIGHT NOTICE.   THIS  SOFTWARE  OR
!	ANY  OTHER  COPIES  THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE
!	AVAILABLE TO ANY OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF  THE
!	SOFTWARE IS HEREBY TRANSFERRED.
!
!	THE INFORMATION IN THIS SOFTWARE IS  SUBJECT  TO  CHANGE  WITHOUT
!	NOTICE  AND  SHOULD  NOT  BE CONSTRUED AS A COMMITMENT BY DIGITAL
!	EQUIPMENT CORPORATION.
!
!	DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR  RELIABILITY  OF
!	ITS SOFTWARE ON EQUIPMENT THAT IS NOT SUPPLIED BY DIGITAL.
!
!
!   BRMS20.CTL, the RMS-20 build CTL file, creates the RMS release files.
!   This build procedure includes RMSLOD.EXE, the RMS Fast Load Utility.
!   (RMSLOD operates with RMS v2 or v3, but requires TOPS-20 V6 or later
!   to run cleanly.)
!
!   This control file uses RMS-DEF.CMD to define logicals.
!
!   Submit with command:   @SUBMIT BRMS20/TIME:01:00:00
!
!   Table of contents:
!
!   Summary		    1
!   Required files	    2
!   Setup		    4
!   Build common modules    5
!   Build of RMS	    6
!	Macro & data	    6
!	Verb modules	    7
!	Other modules	    8
!	Make RMS library    9
!   Build of RMSDEB	    10
!   Build of RMSUTL	    11
!   Build of FFF	    12
!   Load each component	    13
!   Epilogue		    14


!   Required files
!
!   SYS:	MACRO.EXE           [Latest released versions]
!		BLISS.EXE
!		LINK.EXE
!		RUNOFF.EXE
!		PA1050.EXE
!		MONSYM.L36
!		MONSYM.UNV
!
!   DSK:	RMS-DEF.CMD
!		XPORT.REL
!
!	Common source modules
!	=====================
!	RMSMAC.MAC	Universal file for MACRO RMS modules
!	RMSMES.MAC	Terminal output (OS-dependent)
!	RMSM2.MAC	More terminal output
!	RMSCNV.B36	Data conversions
!	RMSFLO.MAC	Floating point data conversions
!	RMSLIB.R36	Library file needed by RMS (accessed via RMSREQ)
!	RMSLUS.R36	Old RMS interface (used to be RMSINT.R36; declares
!			library RMSSYM.LUS)
!
!	CMDPAR MODULES
!	==============
!	CMDPAR.MAC	Declarations to use CMDPAR
!	CPAFIL.MAC	Take file support
!	CPAKBD.MAC	Terminal hardware related stuff
!	CPASCN.MAC	COMND processing
!	CPASYM.MAC	Declarations used by CMDPAR
!	CPATOP.MAC	Top-level module
!
!	USER ENVIRONMENT
!	================
!	RMSINI.MAC	Gets RMS.EXE
!	RMSUSR.R36	Becomes RMSINT.L36 for user programs
!	RMSSYM.BPR	BLISS macros referenced by MTB
!	RMSSYM.MPR	MACRO macros referenced by MTB
!	RMSSYM.MTB	Common MACRO/BLISS definitions
!	RMSSYM.BUS	Symbols/macros for BLISS user
!	RMSSYM.BSY	Symbols/macros for RMS modules

!	RMS modules
!	=============
!
!	RMSDSP.MAC	RMS entry code, dispatch vector, and common exit code
!	RMSDLB		RMS Master Dynamic library block
!	DYNSYM		Universal file for dynamic libraries
!	RMSDYN		Universal file for dynamic library
!	RMSEVC		RMS entry vector definition
!	RMSGLB		Global variables
!	RMSOTS		OTS interface for memory management with COBOL 12B
!	RMSOSM		Miscellaneous OS-dependent code
!	RMSJCK		RMS Jacket routines for dynamic library call
!	RMSLDB		RMS Local Dynamic library block
!	RMSZER		RMS Section 0 Jacket routines for dynamic library call
!
!	RMSOSD.R36	File required by OS-dependent modules
!	RMSREQ		File required by all RMS modules
!
!	RMSASC.B36	Processor for ASCII files
!	RMSBKT		Bucket processor for indexed files
!	RMSBUF		Buffer manager
!	RMSCLS		$CLOSE processor
!	RMSCNC		$CONNECT/$DISCONNECT processor
!	RMSD20		Tops-20-specfic directory routines
!	RMSDEL		$DELETE processor
!	RMSDIR		$Parse, $Search and directory routines
!	RMSDIS		$DISPLAY processor
!	RMSDMP		Dump routines to support in-house debugging
!	RMSDPO		$Close disposition routines
!	RMSDSI		Data structure interface
!	RMSDUM		Dummy module for unimplemented functions
!	RMSERR		Error processor
!	RMSERS		$ERASE processor (OS-dependent)
!	RMSFIL		File prologue processor
!	RMSFLS		$FLUSH processor
!	RMSFNC		FUNCT. that calls GMEM
!	RMSFND		$FIND processor
!	RMSFNX		$FIND processor for indexed files
!	RMSFRE		$FREE processor
!	RMSFSM		Free storage manager
!	RMSGET		$GET processor
!	RMSIDX		Processor for index records
!	RMSIMA		Image mode access
!	RMSM11		MACY11 mode access
!	RMSIO		I/O routines
!	RMSIXM		More routines for index records
!	RMSMSC		Miscellaneous routines for indexed files
!	RMSMSG		$MESSAG/$NOMESSAGE processor
!	RMSNXF		Multiple filespec proccessing
!	RMSNX2		Multiple filespec proccessing (OS-dependent)
!	RMSOPN		$OPEN/$CREATE processor (OS-dependent)
!	RMSOSB		OS calls (OS-dependent)
!	RMSPUT		$PUT processor
!	RMSQUE		Locking routines (OS-dependent)
!	RMSRCO		Remote Connect/Disconnect
!	RMSREL		$RELEASE processor
!	RMSROP		Remote file open/close
!	RMSRRE		Remote record operations
!	RMSRSU		Setup routines
!	RMSSDR		Processor for secondary data records
!	RMSSPT		Bucket split routines
!	RMSTAB		Record data-type table and ASCII translation table
!	RMSTRN		$TRUNCATE processor
!	RMSTXT		Error message text
!	RMSUAR		User argument address massager
!	RMSUDR		Processor of user data records
!	RMSUDM		Move routines for user data records
!	RMSUIN		RMSUTL interface
!	RMSUPD		$UPDATE processor
!
!	FAL modules
!	===========
!
!	FALTOP.B36	Top-level FAL routines
!	FALDO.B36	Main loop of FAL
!	FALDAP.B36	Dap routines used by FAL only
!
!	DAP modules (used by RMS and FAL)
!	=================================
!
!	DAP.REQ		DAP Library File
!	CONDIT.REQ	Condition code definitions
!	DAP.B36		Dap message routines
!	DAPSAI.B36	Access info setup for connect
!	DAPSUB.B36	Dap field & message subroutines
!	DAPSTR.B36	Dap string handling subroutines
!	DAPERR.B36	Dap error routines
!	DAPT20.B36	Tops-20 specific DAP routines
!	DAPTRA.B36	Dap Trace routines
!	DAPTRT.B36	Dap Trace routines
!
!	XPNLIB (BLISSNET) modules
!	=========================
!	BLISSNET.REQ
!       BLISSNET-DESCRIPTOR.R36
!       BLISSNET20.R36
!       JSYSDEF.R36
!       PMRDUM.B36
!       XPNCLO.B36
!       XPNDIS.B36
!       XPNERR.B36
!       XPNEVE.B36
!       XPNFAI.B36
!       XPNGET.B36
!       XPNOPN.B36
!       XPNPSI.MAC
!       XPNPUT.B36
!       XPNUTL.B36
!
!	RMSDEB modules
!	==============
!	DEBACT.MAC	DEBCMD.MAC	DEBSYM.MAC	DEBTOP.MAC
!
!	RMSUTL modules
!	==============
!	UTLACT.MAC	UTLCMD.MAC	UTLENV.MAC	UTLEXT.R36
!	UTLTOP.MAC	UTLUSE.MAC	UTLSET.B36	UTLIO.B36
!	UTLMSC.B36	UTLVFY.B36
!
!	FFF modules
!	==============
!	FFFCLS.B36	FFFCNC.B36	FFFDLB.MAC	FFFDSC.B36
!	FFFDUM.B36	FFFDYN.MAC	FFFFND.B36	FFFGET.B36
!	FFFISA.B36	FFFJCK.MAC	FFFOPN.B36	FFFPDV.MAC
!	FFFREQ.R36	FFFWIN.B36	FGNLIB.R36	RMSFFF.R36
!
!       DYNLIB modules
!	==============
!
!	RTLZER.REL	RTLJCK.REL	DYNBOO.REL	ZERBOO.REL
!	RTL.EXE
!
!
!	Miscellaneous modules
!	=====================
!
!	RMSERM.B36	Error message printing routines (FAL, RMSDEB)
!	RMSERT.B36
!	RMSRES.B36	$Reset
!
!	UETP modules
!	============
!	RMS.VER		RMTBLS.B36	RMTCBB.CBL	RMTCBI.CBL	
!	RMTCBR.CBL	RMTCBS.CBL	RMTMAC.MAC
!
!	Other input files (see output section too)
!	=========================================
!	BRMS20.CTL	RMS3.RND	RMS3.RNO	RMS20.MAC
!	RMS20.CTL	RMS2S3.LNK	RMS2U3.LNK	RMS2X3.LNK

WORK::
!
!   Set up logical names
!
@DEFINE *
@
;@TYPE BATCH.CMD
;@TAKE BATCH.CMD
@
@TYPE RMS-DEF.CMD
@TAKE RMS-DEF.CMD
@I LOGICAL-NAMES ALL
@DELETE DSK:RMS-FILE-IS-MISSING.FLAG.0
COMDIR::
@TAKE RMS-DEF.CMD
@ERROR %
@VDIR DSK:RMS20.MAC, DSK:RMSMAC.MAC, DSK:RMSMES.MAC, DSK:RMSM2.MAC, DSK:RMSFLO.MAC, DSK:RMSCNV.B36, DSK:RMSLIB.R36,
@CHECKSUM SEQUENTIAL
@
@IF (NOERROR) @GOTO ENDDIR
!
!
!  ?????????  ???????    ???????      ?????    ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ??         ??     ??  ??     ??  ??     ??  ??     ??
!  ???????    ??    ??   ??    ??   ??     ??  ??    ?? 
!  ??         ???????    ???????    ??     ??  ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ?????????  ??     ??  ??     ??    ?????    ??     ??
!
!
@COPY NUL: DSK:RMS-FILE-IS-MISSING.FLAG.-1
ENDDIR::

CMDDIR::
@TAKE RMS-DEF.CMD
@ERROR %
@VDIR DSK:CMDPAR.MAC, DSK:CPAFIL.MAC, DSK:CPAKBD.MAC, DSK:CPASCN.MAC, -
DSK:CPASYM.MAC, DSK:CPATOP.MAC,
@CHECKSUM SEQUENTIAL
@
@IF (NOERROR) @GOTO ENDDIR
!
!
!  ?????????  ???????    ???????      ?????    ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ??         ??     ??  ??     ??  ??     ??  ??     ??
!  ???????    ??    ??   ??    ??   ??     ??  ??    ?? 
!  ??         ???????    ???????    ??     ??  ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ?????????  ??     ??  ??     ??    ?????    ??     ??
!
!
@COPY NUL: DSK:RMS-FILE-IS-MISSING.FLAG.-1
ENDDIR::

USRDIR::
@TAKE RMS-DEF.CMD
@ERROR %
@VDIR DSK:RMSINI.MAC, DSK:RMSLUS.R36, DSK:RMSSYM.BPR, DSK:RMSSYM.MPR, -
DSK:RMSSYM.MTB, DSK:RMSSYM.BUS, DSK:RMSSYM.BSY, RMSUSR.R36, RMSSYM.MSY, -
RMSSYM.MSX, RMSSYS.R36, BUILTIN.R36, TOPS20.R36,
@CHECKSUM SEQUENTIAL
@
@IF (NOERROR) @GOTO ENDDIR
!
!
!  ?????????  ???????    ???????      ?????    ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ??         ??     ??  ??     ??  ??     ??  ??     ??
!  ???????    ??    ??   ??    ??   ??     ??  ??    ?? 
!  ??         ???????    ???????    ??     ??  ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ?????????  ??     ??  ??     ??    ?????    ??     ??
!
!
@COPY NUL: DSK:RMS-FILE-IS-MISSING.FLAG.-1
ENDDIR::

MACDIR::
@TAKE RMS-DEF.CMD
@ERROR %
@VDIR DSK:RMSDSP.MAC, DSK:RMSZDS.MAC, DSK:RMSEVC.MAC, DSK:RMSGLB.MAC, -
@DSK:RMSDYN.MAC, DSK:RMSJCK.MAC, DSK:RMSZER.MAC, -
@DSK:RMSLDB.MAC, DSK:RMSDLB.MAC, DSK:RMSOTS.MAC, -
@DSK:RMSOSM.MAC, ! Assembled w/ FFF:  FFFDYN.MAC, FFFJCK.MAC,
@CHECKSUM SEQUENTIAL
@
@IF (NOERROR) @GOTO ENDDIR
!
!
!  ?????????  ???????    ???????      ?????    ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ??         ??     ??  ??     ??  ??     ??  ??     ??
!  ???????    ??    ??   ??    ??   ??     ??  ??    ?? 
!  ??         ???????    ???????    ??     ??  ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ?????????  ??     ??  ??     ??    ?????    ??     ??
!
!
@COPY NUL: DSK:RMS-FILE-IS-MISSING.FLAG.-1
ENDDIR::

R36DIR::
@TAKE RMS-DEF.CMD
@ERROR %
@VDIR DSK:RMSOSD.R36, DSK:RMSREQ.R36,
@CHECKSUM SEQUENTIAL
@
@IF (NOERROR) @GOTO ENDDIR
!
!
!  ?????????  ???????    ???????      ?????    ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ??         ??     ??  ??     ??  ??     ??  ??     ??
!  ???????    ??    ??   ??    ??   ??     ??  ??    ?? 
!  ??         ???????    ???????    ??     ??  ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ?????????  ??     ??  ??     ??    ?????    ??     ??
!
!
@COPY NUL: DSK:RMS-FILE-IS-MISSING.FLAG.-1
ENDDIR::

B36DIR::
@TAKE RMS-DEF.CMD
@ERROR %
@VDIR DSK:RMSASC.B36, DSK:RMSBKT.B36, DSK:RMSBUF.B36, DSK:RMSCLS.B36, -
DSK:RMSCNC.B36, DSK:RMSDEL.B36, DSK:RMSDIS.B36, DSK:RMSDMP.B36, -
RMSDPO.B36, DSK:RMSTAB.B36, DSK:RMSDSI.B36, DSK:RMSERR.B36, DSK:RMSERS.B36, -
DSK:RMSFIL.B36, DSK:RMSFLS.B36, DSK:RMSFNC.B36, DSK:RMSFND.B36,DSK:RMSFNX.B36,-
DSK:RMSFRE.B36, DSK:RMSFSM.B36, DSK:RMSGET.B36, DSK:RMSIDX.B36, RMSIMA.B36, -
DSK:RMSM11.B36, DSK:RMSIO.B36, DSK:RMSIXM.B36, DSK:RMSMSC.B36, DSK:RMSMSG.B36,-
DSK:RMSNXF.B36, DSK:RMSNX2.B36, -
DSK:RMSOPN.B36, DSK:RMSOSB.B36, DSK:RMSPUT.B36, DSK:RMSQUE.B36, RMSRDW.B36, -
DSK:RMSREL.B36, DSK:RMSRSU.B36, DSK:RMSSDR.B36, DSK:RMSSPT.B36, -
DSK:RMSTRN.B36, DSK:RMSTXT.B36, DSK:RMSUAR.B36, DSK:RMSUDR.B36, -
DSK:RMSUDM.B36, DSK:RMSUIN.B36, DSK:RMSUPD.B36,
@CHECKSUM SEQUENTIAL
@
@IF (NOERROR) @GOTO ENDDIR
!
!
!  ?????????  ???????    ???????      ?????    ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ??         ??     ??  ??     ??  ??     ??  ??     ??
!  ???????    ??    ??   ??    ??   ??     ??  ??    ?? 
!  ??         ???????    ???????    ??     ??  ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ?????????  ??     ??  ??     ??    ?????    ??     ??
!
!
@COPY NUL: DSK:RMS-FILE-IS-MISSING.FLAG.-1
ENDDIR::

FFFDIR::
@TAKE RMS-DEF.CMD
@ERROR %
@VDIR DSK:FFFCLS.B36,DSK:FFFCNC.B36,DSK:FFFDLB.MAC,-
DSK:FFFDSC.B36,DSK:FFFDUM.B36,DSK:FFFDYN.MAC,DSK:FFFFND.B36,-
DSK:FFFGET.B36,DSK:FFFISA.B36,DSK:FFFJCK.MAC,-
DSK:FFFOPN.B36,DSK:FFFPDV.MAC,DSK:FFFREQ.R36,-
DSK:FFFWIN.B36,DSK:RMSFFF.R36,DSK:FGNLIB.R36,
@CHECKSUM SEQUENTIAL
@
@IF (NOERROR) @GOTO ENDDIR
!
!
!  ?????????  ???????    ???????      ?????    ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ??         ??     ??  ??     ??  ??     ??  ??     ??
!  ???????    ??    ??   ??    ??   ??     ??  ??    ?? 
!  ??         ???????    ???????    ??     ??  ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ?????????  ??     ??  ??     ??    ?????    ??     ??
!
!
@COPY NUL: DSK:RMS-FILE-IS-MISSING.FLAG.-1
ENDDIR::

@GOTO ENDDIR				; No RMSDEB files in V2
DEBDIR::
@TAKE RMS-DEF.CMD
@ERROR %
@VDIR DSK:DEBACT.MAC, DSK:DEBCMD.MAC, DSK:DEBSYM.MAC, DSK:DEBTOP.MAC,
@CHECKSUM SEQUENTIAL
@
@IF (NOERROR) @GOTO ENDDIR
!
!
!  ?????????  ???????    ???????      ?????    ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ??         ??     ??  ??     ??  ??     ??  ??     ??
!  ???????    ??    ??   ??    ??   ??     ??  ??    ?? 
!  ??         ???????    ???????    ??     ??  ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ?????????  ??     ??  ??     ??    ?????    ??     ??
!
!
@COPY NUL: DSK:RMS-FILE-IS-MISSING.FLAG.-1
ENDDIR::

UTLDIR::
@TAKE RMS-DEF.CMD
@ERROR %
@VDIR DSK:UTLACT.MAC, DSK:UTLCMD.MAC, DSK:UTLENV.MAC, -
DSK:UTLTOP.MAC, DSK:UTLUSE.MAC, DSK:UTLIO.B36, DSK:UTLMSC.B36, DSK:UTLVFY.B36,-
DSK:UTLEXT.R36, DSK:UTLSET.B36,
@CHECKSUM SEQUENTIAL
@
@IF (NOERROR) @GOTO ENDDIR
!
!
!  ?????????  ???????    ???????      ?????    ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ??         ??     ??  ??     ??  ??     ??  ??     ??
!  ???????    ??    ??   ??    ??   ??     ??  ??    ?? 
!  ??         ???????    ???????    ??     ??  ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ?????????  ??     ??  ??     ??    ?????    ??     ??
!
!
@COPY NUL: DSK:RMS-FILE-IS-MISSING.FLAG.-1
ENDDIR::

LNKDIR::
@TAKE RMS-DEF.CMD
@ERROR %
@VDIR RMS2S3.LNK, RMS2U3.LNK, RMS2X3.LNK, XPORT.REL, -
@RMS2Z3.LNK, SYS:DYNSYM.UNV, RMSDMF.B36, -
@SYS:RTLZER.REL, SYS:RTLJCK.REL, SYS:DYNBOO.REL, SYS:ZERBOO.REL, SYS:RTL.EXE,
@CHECKSUM SEQUENTIAL
@
@IF (NOERROR) @GOTO ENDDIR
!
!
!  ?????????  ???????    ???????      ?????    ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ??         ??     ??  ??     ??  ??     ??  ??     ??
!  ???????    ??    ??   ??    ??   ??     ??  ??    ?? 
!  ??         ???????    ???????    ??     ??  ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ?????????  ??     ??  ??     ??    ?????    ??     ??
!
!
@COPY NUL: DSK:RMS-FILE-IS-MISSING.FLAG.-1
ENDDIR::

RNDDIR::
@TAKE RMS-DEF.CMD
@ERROR %
@VDIR DSK:RMS3.RND, DSK:RMS3.RNO,
@CHECKSUM SEQUENTIAL
@
@IF (NOERROR) @GOTO ENDDIR
!
!
!  ?????????  ???????    ???????      ?????    ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ??         ??     ??  ??     ??  ??     ??  ??     ??
!  ???????    ??    ??   ??    ??   ??     ??  ??    ?? 
!  ??         ???????    ???????    ??     ??  ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ?????????  ??     ??  ??     ??    ?????    ??     ??
!
!
@COPY NUL: DSK:RMS-FILE-IS-MISSING.FLAG.-1
ENDDIR::
DAPDIR::
@TAKE RMS-DEF.CMD
@ERROR %
@VDIR DAP.B36,CONDIT.REQ,DAP.REQ,DAPSUB.B36,DAPSAI.B36,DAPTRA.B36,DAPT20.B36, -
DAPSTR.B36,DAPTRT.B36, -
RMSROP.B36,RMSRCO.B36,RMSRRE.B36,RMSDIR.B36,RMSD20.B36,FALTOP.B36,FALDO.B36, -
FALDAP.B36,DAPERR.B36,RMSDUM.B36,RMSERM.B36,RMSRES.B36,RMSERT.B36,NETJOB.BLI,
@CHECKSUM SEQUENTIAL
@
@IF (NOERROR) @GOTO ENDDIR
!
!
!  ?????????  ???????    ???????      ?????    ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ??         ??     ??  ??     ??  ??     ??  ??     ??
!  ???????    ??    ??   ??    ??   ??     ??  ??    ?? 
!  ??         ???????    ???????    ??     ??  ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ?????????  ??     ??  ??     ??    ?????    ??     ??
!
!
@COPY NUL: DSK:RMS-FILE-IS-MISSING.FLAG.-1
ENDDIR::
XPNDIR::
@TAKE RMS-DEF.CMD
@ERROR %
@VDIR BLISSNET.REQ,BLISSNET-DESCRIPTOR.R36,BLISSNET20.R36, -
JSYSDEF.R36,PMRDUM.B36,XPNCLO.B36,XPNDIS.B36,XPNERR.B36,XPNEVE.B36, -
XPNFAI.B36,XPNGET.B36,XPNOPN.B36,XPNPSI.MAC,XPNPUT.B36,XPNUTL.B36,
@CHECKSUM SEQUENTIAL
@
@IF (NOERROR) @GOTO ENDDIR
!
!
!  ?????????  ???????    ???????      ?????    ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ??         ??     ??  ??     ??  ??     ??  ??     ??
!  ???????    ??    ??   ??    ??   ??     ??  ??    ?? 
!  ??         ???????    ???????    ??     ??  ???????  
!  ??         ??    ??   ??    ??    ??   ??   ??    ?? 
!  ?????????  ??     ??  ??     ??    ?????    ??     ??
!
!
@COPY NUL: DSK:RMS-FILE-IS-MISSING.FLAG.-1
ENDDIR::

CHKERR::
@ERROR %
@DELETE DSK:RMS-FILE-IS-MISSING.FLAG.0
@IF (ERROR) @GOTO ALLOK
@GOTO DONE
ALLOK::
@ERROR

!+
!   Check system program version numbers
!-
@GET SYS:BLISS.EXE
@INFO VERSION
@GET SYS:MACRO.EXE
@INFO VERSION
@GET SYS:LINK.EXE
@INFO VERSION
@GET SYS:PA1050.EXE
@INFO VERSION
@GET SYS:RUNOFF.EXE
@INFO VERSION

@VDIRECT SYS:MACRO.EXE,SYS:LINK.EXE,SYS:PA1050.EXE,SYS:RUNOFF.EXE,SYS:MONSYM.UNV,SYS:BLISS.EXE,SYS:MONSYM.L36,SYS:B362LB.REL,
@CHECKSUM SEQUENTIAL
@

!
!   Find out about system symbols for BLISS
!
@DEFINE SBLI: SYS:,BLI:
@VDIRECT SBLI:TENDEF.R36,SBLI:TENDEF.L36,SBLI:MONSYM.R36,SBLI:MONSYM.L36,
@CHECKSUM SEQUENTIAL
@
					; Undefine the symbol
@DEFINE SBLI:

@DEFINE BSYS: BLI:,SYS:
@VDIRECT BSYS:TENDEF.R36,BSYS:TENDEF.L36,BSYS:MONSYM.R36,BSYS:MONSYM.L36,
@CHECKSUM SEQUENTIAL
@
					; Undefine the symbol
@DEFINE BSYS:

@CHKPNT RMSCOM
RMSCOM::
@TAKE RMS-DEF.CMD

! Becomes RMSINT.UNV
@MACRO
*RMSSYM=RMS20,RMSSYM.MPR,RMSSYM.MSY,RMSSYM.MTB,RMSSYM.MSX 
*^C

! Build the Dynamic Library variant called RMSINJ.UNV
@MACRO
*RMSSYM=RMS20,RMSINJ,RMSSYM.MPR,RMSSYM.MSY,RMSSYM.MTB,RMSSYM.MSX 
*^C

@MACRO
*=RMSMAC
*^C
			; Part of user programs

@MACRO
*RMSINI=RMS20,RMSINI
*RM2MES=RMS20,RMSMES
*RM2M2=RMS20,RMSM2
*RM2FLO=RMSFLO
@MACRO
*=RMSDYN
@MACRO
*RMSDLB=RMSDLB
*RMSJCK=RMSJCK
*RMSZER=RMSZER

@BLISS
*RMSSYM.BPR+RMSSYM.BUS+RMSSYM.MTB /LIBRARY:RMSSYM.LUS
*SYS:MONSYM+BLI:TENDEF+RMSSYM.BPR+RMSSYM.BSY+RMSSYM.MTB+RMSUSR+RMSSYS+RMSEXT+BUILTIN/LIB:RMSITR/VA:8
*RMSLIB/LIBRARY
*CONDIT/LIBRARY
*DAP/LIBRARY
*BLISSNET+BLISSNET-DESCRIPTOR/LIB:BLISSNET
*BLISSNET20/LIB
*RMSUSR/LIBRARY:RMSINT.L36
*RMSCNV/OBJECT:RM2CNV
*TOPS20/LIB

@MACRO
*=CMDPAR
*=RMS20,CPASYM

@MACRO
*CPAFIL=CPAFIL
*CPAKBD=CPAKBD
*CPASCN=CPASCN
*CPATOP=CPATOP

@APPEND CPATOP.REL,CPAFIL.REL,CPAKBD.REL,CPASCN.REL RMS2P3.REL.-1

@CHKPNT RMSMAC
RMSMAC::
@TAKE RMS-DEF.CMD

@MACRO
*RMSDSP=RMSDSP
*RMSZDS=RMSZDS
*RMSLDB=RMSLDB
*RMSEVC=RMSEVC
*RMSGLB=RMS20,RMSGLB
*RMSOTS=RMSOTS
*RM2OSM=RMS20,RMSOSM
@

@BLISS
*RMSTAB
*RMSTXT
@

@CHKPNT VERBS
VERBS::
@TAKE RMS-DEF.CMD

@BLISS
*RMSCLS
*RMSCNC
*RMSDEL
*RMSDIR
*RMSDMF
*RMSDUM
*RMSDIS
*RMSDPO
*RMSERS/OBJ:RM2ERS/TOPS20
*RMSFLS
*RMSFNC
*RMSFND
*RMSFRE
*RMSGET
*RMSMSG
*RMSNXF
*RMSNX2
*RMSOPN/OBJ:RM2OPN/TOPS20
*RMSPUT
*RMSRDW
*RMSREL
*RMSTRN
*RMSUPD
*RMSUIN
*RMSUAR
@

@CHKPNT UPPER
UPPER::
@TAKE RMS-DEF.CMD

@BLISS
*RMSASC
*RMSD20
*RMSDSI
*RMSERR
*RMSFNX
*RMSIMA
*RMSM11
*RMSIO
*RMSQUE/OBJ:RM2QUE/TOPS20
*RMSRSU
@

@CHKPNT MIDDLE
MIDDLE::
@TAKE RMS-DEF.CMD

@BLISS
*RMSIDX
*RMSIXM
*RMSSDR
*RMSSPT
*RMSUDR
*RMSUDM
@

@CHKPNT LOWER
LOWER::
@TAKE RMS-DEF.CMD

@BLISS
*RMSBKT
*RMSBUF
*RMSDMP
*RMSFIL
*RMSFSM
*RMSMSC
*RMSOSB/OBJ:RM2OSB/TOPS20
*RMSROP
*RMSRCO

@CHKPNT DAP
@TAKE RMS-DEF.CMD
DAP::

@BLISS
*DAP
*DAPSUB
*DAPSAI
*DAPSTR
*DAPTRA
*DAPTRT
*DAPERR
*DAPT20
*RMSRRE
*RMSRRE/VARIANT:2/OBJECT:FALRRE

@CHKPNT FAL
FAL::
@TAKE RMS-DEF.CMD
@BLISS
*RMSERM
*RMSERT
*RMSRES
*FALTOP
*FALDO
*FALDAP

@CHKPNT XPNLIB
XPNLIB::
@TAKE RMS-DEF.CMD
@BLISS
*XPNCLO.B36
*XPNDIS.B36
*XPNERR.B36
*XPNEVE.B36
*XPNEVE.B36/VARIANT/OBJECT:XPIEVE
*XPNFAI.B36
*XPNGET.B36
*XPNOPN.B36
*XPNOPN.B36/VARIANT/OBJECT:XPIOPN
*PMRDUM.B36
*XPNPUT.B36
*XPNUTL.B36
*XPNUTL.B36/VARIANT/OBJECT:XPIUTL


@MACRO
*XPNPSI=XPNPSI

@CHKPNT RMSLIB
RMSLIB::
@TAKE RMS-DEF.CMD

@APPEND RMSDSP.REL,RMSCLS.REL,RMSCNC.REL,RMSDEL.REL,RMSDIS.REL, RMSDPO.REL, RM2ERS.REL,RMSFLS.REL,RMSFND.REL,RMSFRE.REL RMS.REL.-1
@APPEND RMSGET.REL,RMSMSG.REL,RMSNXF.REL,RMSNX2.REL,RM2OPN.REL,RMSPUT.REL,RMSREL.REL,	RMSTRN.REL,RMSUPD.REL,RMSUIN.REL RMS.REL.0
@APPEND RMSASC.REL,RMSIO.REL,RM2QUE.REL,RMSERR.REL,RMSDSI.REL,	RMSFNX.REL,RMSRSU.REL, RMSIMA.REL, RMSM11.REL RMS.REL.0
@APPEND RMSIDX.REL,RMSIXM.REL,RMSSDR.REL,RMSSPT.REL,RMSUDR.REL,	RMSUDM.REL RMS.REL.0
@APPEND RMSBKT.REL,RMSBUF.REL,RMSDMP.REL,RMSFIL.REL,RMSFSM.REL,	RMSMSC.REL,RM2OSB.REL RMS.REL.0
@APPEND RMSOTS.REL,RM2MES.REL,RM2M2.REL,RM2CNV.REL,RM2FLO.REL,RM2OSM.REL,RMSTAB.REL,RMSTXT.REL,RMSSYM.REL,RMSGLB.REL,RMSUAR.REL,RMSDUM.REL RMS.REL.0
@APPEND RMSDIR.REL,RMSD20.REL,RMSROP.REL,RMSRCO.REL,RMSRDW.REL,RMSFNC.REL RMS.REL.0
@COPY RMS.REL.0 RMS203.REL.-1

@APPEND DAP.REL,DAPSUB.REL,DAPT20.REL,DAPERR.REL,DAPSAI.REL,DAPSTR.REL,RMSRRE.REL DAP2V3.REL.-1
@APPEND XPNCLO.REL,XPNDIS.REL,XPNERR.REL,XPNEVE.REL,XPNFAI.REL,XPNGET.REL,XPNOPN.REL,PMRDUM.REL,XPNPUT.REL,XPNUTL.REL XPN2V3.REL.-1

@APPEND XPNCLO.REL,XPNDIS.REL,XPNERR.REL,XPIEVE.REL,XPNFAI.REL,XPNGET.REL,XPIOPN.REL,PMRDUM.REL,XPNPUT.REL,XPIUTL.REL,XPNPSI.REL XPN2F3.REL.-1

@CHKPNT RMSDEB
RMSDEB::
@TAKE RMS-DEF.CMD

@MACRO
*=DEBSYM
@MACRO
*DEBACT=DEBACT
*DEBCMD=DEBCMD
*DEBTOP=DEBTOP

@APPEND DEBTOP.REL,DEBCMD.REL,DEBACT.REL,RM2FLO.REL,RM2CNV.REL, -
@RM2MES.REL,RM2M2.REL,CPATOP.REL,CPAFIL.REL,CPASCN.REL,CPAKBD.REL, -
@DAPERR.REL,XPNERR.REL,RMSERM.REL,RMSERT.REL RMS2D3.REL.-1


@CHKPNT RMSUTL
RMSUTL::
@TAKE RMS-DEF.CMD

@MACRO
*=UTLSYM
@MACRO
*UTLACT=UTLACT
*UTLCMD=UTLCMD
*UTLENV=UTLENV
*UTLTOP=UTLTOP
*UTLUSE=UTLUSE
@BLISS
*UTLEXT/LIBRARY
*UTLIO
*UTLMSC
*UTLVFY
*UTLSET
@APPEND UTLACT.REL,UTLCMD.REL,UTLENV.REL,UTLIO.REL,UTLMSC.REL,UTLUSE.REL,UTLVFY.REL,UTLTOP.REL,UTLSET.REL RMS2U3.REL.-1
ENDUTL::
@CHKPNT FFF
FFF::
@TAKE RMS-DEF.CMD

@MACRO
*FFFDYN=FFFDYN
*FFFDLB=FFFDLB
*FFFJCK=RMS20,FFFJCK
*FFFPDV=FFFPDV
*^Z

@BLISS
*RMSFFF/LIB/VARIANT:1
*FGNLIB/LIB

@BLISS
*FFFWIN
*FFFCLS
*FFFCNC
*FFFDSC
*FFFDUM
*FFFFND
*FFFGET
*FFFOPN
*FFFISA
@

@APPEND FFFCLS.REL,FFFCNC.REL,FFFDLB.REL,FFFDSC.REL FFF201.REL.-1
@APPEND FFFDUM.REL,FFFDYN.REL,FFFFND.REL,FFFGET.REL FFF201.REL.0
@APPEND FFFISA.REL,FFFOPN.REL,FFFPDV.REL,FFFWIN.REL FFF201.REL.0
@

@GOTO ENDFFF
DLTREL::
@DELETE FFFCLS.REL,FFFCNC.REL,FFFDLB.REL,FFFDSC.REL 
@DELETE FFFDUM.REL,FFFDYN.REL,FFFFND.REL,FFFGET.REL 
@DELETE FFFISA.REL,FFFOPN.REL,FFFPDV.REL,FFFWIN.REL 
@
						; Check it out
@I VER
ENDDIR::
			; Check results
@VDIR FFF.EXE,FFF201.REL,
@CHECKSUM SEQUENTIAL
@


ENDFFF::
@CHKPNT LOADS
LOADS::
@TAKE RMS-DEF.CMD

!
! BUILD "STANDALONE RMS"
!
@LINK
*@RMS2S3.LNK
@GET RMS2S3
@SAV RMS-SINGLE-SECTION 600

!
! BUILD "XRMS.EXE"
! This is a dynamic library, so we will have to START it
! to do the once-only build of the PDV.  Then save it.
!
@LINK
*@RMS2X3.LNK
! Link makes the PDV now, no need to run RMS2X3

!
! BUILD "RMS.EXE" stub to call XRMS as dynamic library
!
@LINK
*@RMS2Z3.LNK
@GET RMS2Z3.EXE
@SAVE RMS.EXE 740

!
!   Build RMSUTL
!
@LINK
*@RMS2U3.LNK
@START				; Initialize the .EXE file with RMS
@SAVE				; Save RMSUTL (now contains RMS-SINGLE-SECTION)
@INFO VERSION			; Show what we have for consistency

!
!   Build the FFF library
!
@LINK						; LINK the files
*@FFF201.LNK
@RUN FFF201					; Build the PDV
@SAVE FFF					; Save the real .EXE
@INFO VERSION
!
!   Build RMSDEB.REL
!
@COPY RMS2D3.REL RMSDEB.REL
@LINK
*/DEFINE:FAB:#300000/DEFINE:RAB:#300040
*/DEFINE:FST:#300100/DEFINE:RST:#300140
*/DEFINE:CBD:#300200/DEFINE:ADB:#300240
*/DEFINE:FPT:#301000/DEFINE:KDB:#300300
*RMSDEB/SAVE,RMSDEB,XPORT/SEARCH/GO/START:RMSDEB

@CHKPNT FAL
FAL::
@TAKE RMS-DEF.CMD
@LINK
*@RMS2F3.LNK
!
@COPY FAL.EXE RMSFAL.EXE
@
! Build Netjob
@BLISS
*NETJOB
@LINK
*NETJOB/SAVE,NETJOB/G
@
@CHKPNT EPILOG
EPILOG::
@TAKE RMS-DEF.CMD

!
!   Setup the rest of the files necessary for release
!
@RUNOFF RMS3.RND ! /OUTPUT:RMS3.DOC	- Set up DOC file
@RUNOFF RMS3.RNO ! /OUTPUT:RMS3.BWR	- Set up BWR file
		; RUNOFF has a bug (3-Feb-84)
@RENAME RMS3.MEM RMS3.BWR
!
!   See what we got
!
			; EXE files
@VDIR DSK:*.EXE,
@CHECKSUM SEQUENTIAL
@
	; REL files
@VDIRECT DSK:RMS.REL,DSK:RMS2%3.REL,DSK:RMSINI.REL,FFF201.REL,
@CHECKSUM SEQUENTIAL
@
	; Documentation
@VDIRECT DSK:RMS3.DOC, DSK:RMS3.BWR,
@CHECKSUM SEQUENTIAL
@
 ; MACRO and BLISS interfaces
@VDIRECT DSK:RMSINT.UNV, DSK:RMSINT.L36,
@CHECKSUM SEQUENTIAL
@

@CHKPNT RMSLOD
RMSLOD::
@TAKE RMS-DEF.CMD
!
!   Check for sources...
!
!   Libraries for RMSLOD
!
@VDIR TOPS20.R36, RMSUSR.R36, RMSSYS.R36, STSDEF.R36, UTLLIB.R36,
@CHECKSUM SEQUENTIAL
@
!
!   FAO
!   
@VDIR FAO.B36, FAO.R36,
@CHECKSUM SEQUENTIAL
@
!
!   COMAND package
!   
@VDIR COMAND.B36, COMAND.R36,
@CHECKSUM SEQUENTIAL
@
!
!   BLISS sources
!   
@VDIR FFFUSR.R36,
@CHECKSUM SEQUENTIAL
@
@VDIR LODTOP.B36, LODCMD.B36, LODMEM.B36, LODLOD.B36, LODUNL.B36, LODREO.B36,
@CHECKSUM SEQUENTIAL
@
!
!   MACRO sources
!   
@VDIR LODMAP.MAC, LODSRT.MAC,
@CHECKSUM SEQUENTIAL
@
!
!   AUTOPATCH stuff
!   
@VDIR RMS2L1.LNK,
@CHECKSUM SEQUENTIAL
@

!
!   Compile the libraries
!
@BLISS TOPS20/LIBRARY
@BLISS RMSUSR/LIB:RMSINT
@BLISS RMSUSR+RMSSYS/LIB:RMSSYS
@BLISS STSDEF/LIBRARY
@BLISS UTLLIB/LIBRARY
!
!   Compile the FAO package
!
@BLISS FAO
@BLISS FAO/LIBRARY
!
!   Compile the COMAND package
!
@BLISS COMAND/LIBRARY/VARIANT
@BLISS COMAND
!
!   Compile RMSLOD BLISS modules
!
@BLISS FFFUSR.R36/LIB
@BLISS LODTOP				; Top-level module
@BLISS LODCMD				; Command script module
@BLISS LODMEM				; Memory manager
@BLISS LODLOD				; Fast load routines
@BLISS LODUNL				; UNLOAD/COPY routines
@BLISS LODREO				; Reorganize routines
!
!   Compile RMSLOD MACRO modules
!
@MACRO
*LODMAP=LODMAP				; Extended-address mapper
*LODSRT=LODSRT				; SORT interface
*^C
!
!   Append the .RELs together
!
@APPEND LODTOP.REL,LODCMD.REL,LODMEM.REL,LODLOD.REL,LODREO.REL RMS2L1.REL.-1
@APPEND LODUNL.REL,LODSRT.REL,LODMAP.REL,FAO.REL,COMAND.REL RMS2L1.REL.0
LINKEM::
!
!   Link the modules now
!
@LINK
*@RMS2L1.LNK
!
!   What about the results?
!
@VDIR RMSLOD.EXE,RMS2L1.REL,
@CHECKSUM SEQUENTIAL
@

DONE::					; End of BRMS20.CTL

