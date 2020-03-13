!	JOB TO create listings of THE FORTRAN COMPILER ON THE DECSYSTEM-20
!	SUBMIT L20FTN.CTL/TIME:02:00:00/RESTART:YES



!COPYRIGHT (c) DIGITAL EQUIPMENT CORPORATION 1976, 1987
!ALL RIGHTS RESERVED.
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

!	VERSION 11	L20FTN.CTL	February 1987

!This control file describes the procedures used to build the distributed
!software.   It  is  unlikely  that  this  control  file can be submitted
!without  modification  on  customer  systems.   Submit  times  may  vary
!depending  on  system  configuration  and  load.   The  availability  of
!sufficient disk space and core is mandatory.  This control file has  not
!been  extensively  tested on alternate configurations.  It has been used
!successfully  for  its  intended  purpose:   to  build  the  distributed
!software on our development systems.

! FUNCTION:	THIS CONTROL FILE BUILDS THE STANDARD FORTRAN COMPILER
!		   FROM SOURCES.  IT
!		  UTILIZES FIELD IMAGE SOFTWARE.

! INPUT:	THE FOLLOWING FILES ARE REQUIRED BY THIS JOB IN THE
!		  DISK AREAS INDICATED:

!	SYS:	BLIS10	.EXE	; VERSION 7E(227)
!	SYS:	BLIS10	.ERR
!	SYS:	HELPER	.REL	; VERSION 7.4
!	SYS:	LINK	.EXE	; VERSION 6.0
!	SYS:	MACRO	.EXE	; VERSION 53.2
!	SYS:	MACTEN	.UNV
!	SYS:	MONSYM	.UNV
!	SYS:	PA1050	.EXE
!	SYS:	SCAN	.REL	; VERSION 7.4(623)
!	SYS:	SCNMAC	.UNV
!	SYS:	UUOSYM	.UNV

!	DSK:	[AREA UNDER WHICH L20FTN.CTL IS BEING RUN]
!		L20FTN	.CTL		PRODUCES COMPILER LISTINGS
!		B20FTN	.CMD		DEFINES LOGICAL NAMES
!
!		SOURCES FOR BUILDING SYNTAX TABLES ARE MARKED WITH A #
!
!		 ACT0.BLI,    ACT1.BLI,    ALCBLO.BLI,  ARRXPN.BLI,  ASHELP.BLI
!		#BLIO.BLI,   #BUILD.BLI,   CANNON.BLI,  CGDO.BLI,    CGEXPR.BLI
!		 CGSTMN.BLI,  CMPBLO.BLI,  CMPLEX.BLI,  CNSTCM.MAC,  CODETA.BLI
!		 CMND20.MAC,  COMSUB.BLI,  DATAST.BLI,  DEBUG.BLI,  #DEFLT.BLI
!		 DEFPT.BLI,   DOALC.BLI,   DOXPN.BLI,   DRIVER.BLI,  ERR3.MAC
!		#ERROR0.BLI,  ERROUT.BLI, #ERRTB3.MAC,  EXOSUP.MAC,  EXPRES.BLI
!		#F72BNF.SYN,  FAZ1.BLI,    FIRST.BLI,   FLTGEN.MAC, #FMTLEX.BLI
!		 FORMAT.BLI, #FRMBNF.SYN,  GCMNSB.BLI,  GFOPDF.MAC,  GLOBAL.BLI
!		 GNRCFN.BLI,  GOPT2.BLI,   GOPTIM.BLI,  GRAPH.BLI,   INOUT.BLI
!		 INPT.BLI,    IOFLG.BLI,   IOPT.BLI,    JOBD.MAC,   #LEFT72.BLI
!		#LEFTFM.BLI,  LEXAID.BLI,  LEXCLA.BLI,  LEXICA.BLI, #LEXNAM.BLI
!		 LEXSUP.BLI   LISTNG.BLI,  LISTOU.BLI,  MAIN.BLI,    MEMCMP.BLI
!		 MOVA.BLI    #NUMIO1.BLI,  OPGNTA.MAC,  OPTAB.BLI,   OPTMAC.BLI
!		 OUTMOD.BLI  #OUTZ.BLI,    P2S1.BLI,    P2S2.BLI,    P3R.BLI
!		 PEEPOP.BLI   PH2S.BLI,    PH3G.BLI,    PHA2.BLI,    PHA3.BLI
!		 PNROPT.BLI  #QTAB1.MAC,   REGAL2.BLI,  REGUTL.BLI,  RELBUF.BLI
!		 REQREL.BLI   REVHST.MAC, #SCAN0.BLI,  #SCNR.BLI,    SKSTMN.BLI
!		 SRCA.BLI     STA0.BLI,    STA1.BLI,    STA2.BLI,    STA3.BLI
!		 STREGA.BLI   TABLES.BLI, #TBL.BLI,    #TRACE1.BLI,  TSTR.BLI
!		 UNEND.BLI    UTIL.BLI,    VER5.BLI,    VLTPPR.BLI

! OUTPUT:	THE FOLLOWING FILES ARE GENERATED BY THIS CONTROL FILE
!		  AND WILL BE AVAILABLE ON THIS DISK AREA AT JOB
!		  TERMINATION:

!	DSK:	[AREA UNDER WHICH L20FTN.CTL IS BEING RUN]
!		L20FTN	.LOG		LOG FILE FOR THIS RUN

!		OUTPUTS FROM SYNTAX TABLE BUILDING ARE MARKED WITH A # OR *
!		 * INDICATES A REQUIRED FORTRAN COMPILER SOURCE COMPONENT
!
!		 ACT0.LST,    ACT1.LST,    ALCBLO.LST,  ARRXPN.LST, #BLIO.LST
!		#BUILD.LST,   CANNON.LST,  CGDO.LST,    CGEXPR.LST
!		 CGSTMN.LST,  CMPBLO.LST,  CMPLEX.LST,  CNSTCM.LST,  CODETA.LST
!		 CMND20.LST,  COMSUB.LST,  DATAST.LST,  DBUGIT.REQ,  DEBUG.LST
!		#DEFLT.LST,   DEFPT.LST,   DOALC.LST,   DOXPN.LST,   DRIVER.LST
!		 ERR3.LST,   #ERROR0.LST,  ERROUT.LST, #ERRTB3.LST,  EXOSUP.LST
!		 EXPRES.LST,  FAZ1.LST,    FLTGEN.LST,  FORMAT.LST
!		 FT1SEG.REQ,  FTTENX.MAC,  FTTENX.REQ,
!		 GCMNSB.LST,  GLOBAL.LST,  GNRCFN.LST,  GOPT2.LST
!		 GOPTIM.LST,  GRAPH.LST,   INOUT.LST,   INPT.LST,    IOPT.LST
!		 JOBD.LST,   #LEFT72.LST, #LEFTFM.LST,	LEXCLA.LST
!		 LEXICA.LST,  LEXSUP.LST,  LISTNG.LST,  LISTOU.LST, *LOOK72.BLI
!		*LOOKFM.BLI,  MEMCMP.LST, *META72.BLI, #METAFM.BLI,  MOVA.LST
!		#NUMIO1.LST,  MAIN.LST,    OPGNTA.LST,  OPTAB.LST,   OUTMOD.LST
!		#OUTZ.LST,    P2S1.LST,    P2S2.LST,    P3R.LST,     PEEPOP.LST
!		 PH2S.LST,    PH3G.LST,    PHA2.LST,    PHA3.LST,    PNROPT.LST
!		#QTAB1.LST,   REGAL2.LST,  REGUTL.LST,  RELBUF.LST,  REVHST.LST
!		#SCAN0.LST,  #SCNR.LST,    SKSTMN.LST,  SRCA.LST,    STA0.LST
!		 STA1.LST,    STA2.LST,    STA3.LST,    STREGA.LST, #TBL.LST
!		#TRACE1.LST,  TSTR.LST,    UNEND.LST,   UTIL.LST,    VER5.LST
!		 VLTPPR.LST




START::
@CHKPNT START
@NOERROR

!	SHOW CHECKSUMS AND VERSION NUMBERS

@TYPE B20FTN.CMD
@TAKE B20FTN.CMD
@INFORMATION LOGICAL DSK:
@INFORMATION LOGICAL SYS:

!	SYSTEM SOFTWARE

@VDIRECTORY SYS:BLIS10.EXE, SYS:BLIS10.ERR, SYS:HELPER.REL, SYS:LINK.EXE,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY SYS:MACRO.EXE, SYS:MACTEN.UNV, SYS:MONSYM.UNV, SYS:PA1050.EXE,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY SYS:SCAN.REL, SYS:SCNMAC.UNV, SYS:UUOSYM.UNV,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@GET SYS:BLIS10
@INFORMATION VERSION

@GET SYS:LINK
@INFORMATION VERSION

@GET SYS:MACRO
@INFORMATION VERSION

@GET SYS:PA1050
@INFORMATION VERSION

!	CHECK VERSION OF HELPER

@RUN SYS:LINK
*SYS:HELPER
*/VAL:%HELPR

!	CHECK VERSION OF SCAN

@RUN SYS:LINK
*SYS:SCAN
*/VAL:%%SCAN

!	INPUT FILES

@VDIRECTORY ACT0.BLI, ACT1.BLI, ALCBLO.BLI, ALL20.CMD, ARRXPN.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY ASHELP.BLI, B20FTN.CMD, L20FTN.CTL, BLD.CMD, BLIO.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY BUILD.BLI, CANNON.BLI, CGDO.BLI, CGEXPR.BLI, CGSTMN.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY CMPBLO.BLI, CMPLEX.BLI, CNSTCM.MAC, CODETA.BLI, CMND20.MAC,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY COMSUB.BLI, DATAST.BLI, DEBUG.BLI, DEFLT.BLI, DEFPT.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY DOALC.BLI, DOXPN.BLI, DRIVER.BLI, ERR3.MAC, ERROR0.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY ERROUT.BLI, ERRTB3.MAC, EXOSUP.MAC ,EXPRES.BLI, F72BNF.SYN,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY FAZ1.BLI, FIRST.BLI, FLTGEN.MAC, FMTLEX.BLI, FORMAT.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY FRMBNF.SYN, GCMNSB.BLI, GFOPDF.MAC, GLOBAL.BLI, GNRCFN.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY GOPT2.BLI, GOPTIM.BLI, GRAPH.BLI, INOUT.BLI, INPT.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY IOFLG.BLI, IOPT.BLI, JOBD.MAC, LEFT72.BLI, LEFT72.CMD,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY LEFTFM.BLI, LEFTFM.CMD, LEXAID.BLI, LEXCLA.BLI, LEXICA.BLI, LEXNAM.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY LEXSUP.BLI, LISTNG.BLI, LISTOU.BLI, MAIN.BLI, MEMCMP.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY MOVA.BLI, NUMIO1.BLI, OPGNTA.MAC, OPTAB.BLI, OPTMAC.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY OUTMOD.BLI, OUTZ.BLI, P2S1.BLI, P2S2.BLI, P3R.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY PEEPOP.BLI, PH2S.BLI, PH3G.BLI, PHA2.BLI, PHA3.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY PNROPT.BLI, QTAB1.MAC, REGAL2.BLI, REGUTL.BLI, RELBUF.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY REQREL.BLI, REVHST.MAC, SCAN0.BLI, SCNR.BLI, SKSTMN.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY SRCA.BLI, STA0.BLI, STA1.BLI, STA2.BLI, STA3.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY STREGA.BLI, TABLES.BLI, TBL.BLI, TRACE1.BLI, TSTR.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@VDIRECTORY UNEND.BLI, UTIL.BLI, VER5.BLI, VLTPPR.BLI,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

!	MISCELLANEOUS FILES

@VDIRECTORY SYS:BLIS10.HLP, L20FTN.CTL,
@CHECKSUM SEQUENTIAL
@SEPARATE
@




BUILC::
@CHKPNT BUILC

!	FIRST BUILD THE SYNTAX TABLE BUILDERS AND SYNTAX TABLES

@TAKE B20FTN.CMD
@INFORMATION LOGICAL DSK:
@INFORMATION LOGICAL SYS:

!	COMPILE AND LOAD THE TABLE BUILDING PROGRAM.

@RUN SYS:BLIS10
*,BUILD=BUILD.BLI/c/m/s

!	COMPILE ALL I/O UTILITIES.

@RUN SYS:MACRO
*,ERRTB3/c=ERRTB3.MAC
*,QTAB1/c=QTAB1.MAC

@RUN SYS:CREF
*ERRTB3.LST=ERRTB3.CRF
*QTAB1.LST=QTAB1.CRF

@RUN SYS:BLIS10
*,BLIO=BLIO.BLI/c/m/s
*,DEFLT=DEFLT.BLI/c/m/s
*,ERROR0=ERROR0.BLI/c/m/s
*,NUMIO1=NUMIO1.BLI/c/m/s
*,OUTZ=OUTZ.BLI/c/m/s
*,SCAN0=SCAN0.BLI/c/m/s
*,SCNR=SCNR.BLI/c/m/s
*,TBL=TBL.BLI/c/m/s
*,TRACE1=TRACE1.BLI/c/m/s


BLDCK::
@CHKPNT BLDCK

!	DO THE COMPILATIONS FOR THE LOOK AHEAD TABLE BUILDERS.

@RUN SYS:BLIS10
*,LEFT72=LEFT72.BLI/c/m/s

!	THE UNDECLARED IDENTIFIER ERROR "ACTIONNAME" FROM LEFTFM CAN BE IGNORED
!	BLIS10 WILL GENERATE A WARNING

@RUN SYS:BLIS10
*,LEFTFM=LEFTFM.BLI/c/m/s

!	IT IS RECOMMENDED THAT IF AN INSTALLATION IS NOT MODIFYING THE SYNTAX
!	  TABLES THAT THE BUILDING PROCESS BE STARTED HERE AT P0BEG.




P0BEG::
@CHKPNT P0BEG

!	**********	PHASE 0		**********

@TAKE B20FTN.CMD
@INFORMATION LOGICAL DSK:
@INFORMATION LOGICAL SYS:

!	MAKE THE COMPILATION AND ASSEMBLY SWITCH DEFINITION FILES
!	  TO GENERATE THE COMPILER FOR TOPS-20, SINGLE SEGMENT

@COPY TTY: (TO) DBUGIT.REQ
@BIND DBUGIT=0;			!  DEBUGGING CODE NOT IN PHASE 1
@^Z

@COPY TTY: (TO) FT1SEG.REQ
@GLOBAL BIND FT1SEG=1;		! SINGLE SEGMENT
@^Z

@COPY TTY: (TO) FTTENX.REQ
@GLOBAL BIND FTTENEX=1;		! TOPS-20
@^Z

@COPY TTY: (TO) FTTENX.MAC
@UNIVERSAL FTTENX
@	.DIRECTIVE .NOBIN
@	FTTENX==1		; TOPS-20
@	END
@^Z

!	START THE COMPILES
!	USE FIELD IMAGE MONSYM, MACTEN, SCNMAC, SCAN, AND HELPER

@RUN SYS:MACRO
*,FTTENX.CRF=FTTENX.MAC
*,GFOPDF.CRF=GFOPDF.MAC

@RUN SYS:CREF
*FTTENX.LST=FTTENX.CRF
*GFOPDF.LST=GFOPDF.CRF

@RUN SYS:MACRO
*,CMND20/c=CMND20.MAC
*,ERR3/c=ERR3.MAC
*,EXOSUP/c=EXOSUP.MAC
*,JOBD/c=JOBD.MAC
*,REVHST/c=REVHST.MAC

@RUN SYS:CREF
*CMND20.LST=CMND20.CRF
*ERR3.LST=ERR3.CRF
*EXOSUP.LST=EXOSUP.CRF
*JOBD.LST=JOBD.CRF
*REVHST.LST=REVHST.CRF

! GLOBAL.BLI can no longer be Cref'd by BLIS10

@RUN SYS:BLIS10
*,GLOBAL=GLOBAL.BLI/m/s

@RUN SYS:BLIS10
*,INOUT=INOUT.BLI/c/m/s
*,MAIN=MAIN.BLI/c/m/s
*,UNEND=UNEND.BLI/c/m/s

P1BEG::
@CHKPNT P1BEG

!	**********	PHASE 1		**********

@TAKE B20FTN.CMD
@INFORMATION LOGICAL DSK:
@INFORMATION LOGICAL SYS:

@RUN SYS:MACRO
*,CNSTCM/c=CNSTCM.MAC
*,FLTGEN/c=FLTGEN.MAC

@RUN SYS:CREF
*CNSTCM.LST=CNSTCM.CRF
*FLTGEN.LST=FLTGEN.CRF

@RUN SYS:BLIS10
*,ARRXPN=ARRXPN.BLI/c/m/s
*,DOXPN=DOXPN.BLI/c/m/s
*,ERROUT=ERROUT.BLI/c/m/s

! EXPRES.BLI can no longer be Cref'd by BLIS10

@RUN SYS:BLIS10
*,EXPRES=EXPRES.BLI/m/s

@RUN SYS:BLIS10
*,FAZ1=FAZ1.BLI/c/m/s
*,GNRCFN=GNRCFN.BLI/c/m/s
*,SRCA=SRCA.BLI/c/m/s
*,VLTPPR=VLTPPR.BLI/c/m/s


FORMC::
@CHKPNT FORMC

@TAKE B20FTN.CMD
@INFORMATION LOGICAL DSK:
@INFORMATION LOGICAL SYS:

! ACT0.BLI can no longer be Cref'd by BLIS10

@RUN SYS:BLIS10
*,ACT0=ACT0.BLI/m/s

! ACT1.BLI can no longer be Cref'd by BLIS10

@RUN SYS:BLIS10
*,ACT1=ACT1.BLI/m/s

@RUN SYS:BLIS10
*,CODETA=CODETA.BLI/c/m/s
*,DRIVER=DRIVER.BLI/c/m/s
*,FORMAT=FORMAT.BLI/c/m/s

! LEXICA.BLI can no longer be Cref'd by BLIS10

@RUN SYS:BLIS10
*,LEXCLA=LEXCLA.BLI/m/s
*,LEXICA=LEXICA.BLI/m/s

@RUN SYS:BLIS10
*,LEXSUP=LEXSUP.BLI/c/m/s
*,LISTNG=LISTNG.BLI/c/m/s

! STA0.BLI can no longer be Cref'd by BLIS10

@RUN SYS:BLIS10
*,STA0=STA0.BLI/m/s

! STA1.BLI can no longer be Cref'd by BLIS10

@RUN SYS:BLIS10
*,STA1=STA1.BLI/m/s

! STA2.BLI can no longer be Cref'd by BLIS10

@RUN SYS:BLIS10
*,STA2=STA2.BLI/m/s

! STA3.BLI can no longer be Cref'd by BLIS10

@RUN SYS:BLIS10
*,STA3=STA3.BLI/m/s




P2SBE::
@CHKPNT P2SBE

!	**********	PHASE 2S	**********

@TAKE B20FTN.CMD
@INFORMATION LOGICAL DSK:
@INFORMATION LOGICAL SYS:

@RUN SYS:BLIS10
*,GOPT2=GOPT2.BLI/c/m/s
*,INPT=INPT.BLI/c/m/s
*,MEMCMP=MEMCMP.BLI/c/m/s

@RUN SYS:BLIS10
*,P2S1.cs=P2S1.BLI/c/s

@RUN SYS:BLIS10
*,P2S1.ms=P2S1.BLI/m/s

@RUN SYS:BLIS10
*,SKSTMN=SKSTMN.BLI/c/m/s


P2S2C::
@CHKPNT P2S2C

@TAKE B20FTN.CMD
@INFORMATION LOGICAL DSK:
@INFORMATION LOGICAL SYS:

@RUN SYS:BLIS10
*,CANNON.cs=CANNON.BLI/c/s

@RUN SYS:BLIS10
*,CANNON.ms=CANNON.BLI/m/s

@RUN SYS:BLIS10
*,COMSUB.cs=COMSUB.BLI/c/s

@RUN SYS:BLIS10
*,COMSUB.ms=COMSUB.BLI/m/s

@RUN SYS:BLIS10
*,GOPTIM=GOPTIM.BLI/c/m/s
*,P2S2=P2S2.BLI/c/m/s
*,PH2S=PH2S.BLI/c/m/s
*,UTIL=UTIL.BLI/c/m/s




P2BEG::
@CHKPNT P2BEG

!	**********	PHASE 2		**********

@TAKE B20FTN.CMD
@INFORMATION LOGICAL DSK:
@INFORMATION LOGICAL SYS:

@RUN SYS:BLIS10
*,DEFPT.cs=DEFPT.BLI/c/s

@RUN SYS:BLIS10
*,DEFPT.ms=DEFPT.BLI/m/s

@RUN SYS:BLIS10
*,GCMNSB.cs=GCMNSB.BLI/c/s

@RUN SYS:BLIS10
*,GCMNSB.ms=GCMNSB.BLI/m/s

@RUN SYS:BLIS10
*,GRAPH.cs=GRAPH.BLI/c/s

@RUN SYS:BLIS10
*,GRAPH.ms=GRAPH.BLI/m/s

@RUN SYS:BLIS10
*,IOPT.cs=IOPT.BLI/c/s

@RUN SYS:BLIS10
*,IOPT.ms=IOPT.BLI/m/s

@RUN SYS:BLIS10
*,MOVA=MOVA.BLI/c/m/s
*,PHA2=PHA2.BLI/c/m/s

@RUN SYS:BLIS10
*,PNROPT.cs=PNROPT.BLI/c/s

@RUN SYS:BLIS10
*,PNROPT.ms=PNROPT.BLI/m/s

@RUN SYS:BLIS10
*,TSTR.cs=TSTR.BLI/c/s

@RUN SYS:BLIS10
*,TSTR.ms=TSTR.BLI/m/s

@RUN SYS:BLIS10
*,VER5=VER5.BLI/c/m/s




P3GBE::
@CHKPNT P3GBE

!	**********	PHASE 3G	**********

@TAKE B20FTN.CMD
@INFORMATION LOGICAL DSK:
@INFORMATION LOGICAL SYS:

@RUN SYS:BLIS10
*,ALCBLO=ALCBLO.BLI/c/m/s
*,CMPBLO=CMPBLO.BLI/c/m/s

@RUN SYS:BLIS10
*,CMPLEX.cs=CMPLEX.BLI/c/s

@RUN SYS:BLIS10
*,CMPLEX.ms=CMPLEX.BLI/m/s

@RUN SYS:BLIS10
*,DATAST=DATAST.BLI/c/m/s

@RUN SYS:BLIS10
*,DOALC.cs=DOALC.BLI/c/s

@RUN SYS:BLIS10
*,DOALC.ms=DOALC.BLI/m/s

@RUN SYS:BLIS10
*,OUTMOD.cs=OUTMOD.BLI/c/s

@RUN SYS:BLIS10
*,OUTMOD.ms=OUTMOD.BLI/m/s

@RUN SYS:BLIS10
*,PH3G.cs=PH3G.BLI/c/s

@RUN SYS:BLIS10
*,PH3G.ms=PH3G.BLI/m/s

@RUN SYS:BLIS10
*,REGAL2.cs=REGAL2.BLI/c/s

@RUN SYS:BLIS10
*,REGAL2.ms=REGAL2.BLI/m/s

@RUN SYS:BLIS10
*,REGUTL=REGUTL.BLI/c/m/s
*,RELBUF=RELBUF.BLI/c/m/s

@RUN SYS:BLIS10
*,STREGA.cs=STREGA.BLI/c/s

@RUN SYS:BLIS10
*,STREGA.ms=STREGA.BLI/m/s




P3RBE::
@CHKPNT P3RBE

!	**********	PHASE 3R	**********

@TAKE B20FTN.CMD
@INFORMATION LOGICAL DSK:
@INFORMATION LOGICAL SYS:

@RUN SYS:BLIS10
*,P3R=P3R.BLI/c/m/s




P3BEG::
@CHKPNT P3BEG

!	**********	PHASE 3		**********

@TAKE B20FTN.CMD
@INFORMATION LOGICAL DSK:
@INFORMATION LOGICAL SYS:

@RUN SYS:MACRO
*,OPGNTA/c=OPGNTA.MAC

@RUN SYS:CREF
*OPGNTA.LST=OPGNTA.CRF

@RUN SYS:BLIS10
*,CGDO=CGDO.BLI/c/m/s
*,CGEXPR=CGEXPR.BLI/c/m/s

@RUN SYS:BLIS10
*,CGSTMN.cs=CGSTMN.BLI/c/s

@RUN SYS:BLIS10
*,CGSTMN.ms=CGSTMN.BLI/m/s

@RUN SYS:BLIS10
*,DEBUG=DEBUG.BLI/c/m/s

@RUN SYS:BLIS10
*,LISTOU.cs=LISTOU.BLI/c/s

@RUN SYS:BLIS10
*,LISTOU.ms=LISTOU.BLI/m/s

@RUN SYS:BLIS10
*,OPTAB=OPTAB.BLI/c/m/s

@RUN SYS:BLIS10
*,PEEPOP.cs=PEEPOP.BLI/c/s

@RUN SYS:BLIS10
*,PEEPOP.ms=PEEPOP.BLI/m/s

@RUN SYS:BLIS10
*,PHA3=PHA3.BLI/c/m/s


!	**********	ALL BUILDING PHASES COMPLETE	**********

%FIN::
     
!	[END OF L20FTN.CTL]
