! "COPY CONTROL FILE" FOR RELEASE ENGINEERING.
!
! EDIT HISTORY
!
! FACILITY: DIL
!
! Now copy all the "FROM" stuff to the "TO" areas!!
!
! First, copy all the DOC stuff.
!
COPY (FROM) FDOC:DIL.BWR (TO) TDOC:DIL.BWR
COPY (FROM) FDOC:DIL.DOC (TO) TDOC:DIL.DOC
COPY (FROM) FDOC:DIL.HLP (TO) TDOC:DIL.HLP
COPY (FROM) FSUB:DIL.HLP (TO) TSUB:DIL.HLP
COPY (FROM) FDOC:IDXINI.CBL (TO) TDOC:IDXINI.CBL
COPY (FROM) FDOC:JTSERV.CBL (TO) TDOC:JTSERV.CBL
COPY (FROM) FDOC:JTTERM.CBL (TO) TDOC:JTTERM.CBL
COPY (FROM) FDOC:JTTERM.VAX-COB (TO) TDOC:JTTERM.VAX-COB
COPY (FROM) FDOC:JTVRPT.CBL (TO) TDOC:JTVRPT.CBL
COPY (FROM) FDOC:PROCES.MAC (TO) TDOC:PROCES.MAC
!
! Second, copy all the SUB stuff.
!
COPY (FROM) FSUB:DIL.REL (TO) TSUB:DIL.REL
COPY (FROM) FSUB:DIL.LIB (TO) TSUB:DIL.LIB
COPY (FROM) FSUB:DILV7.FOR (TO) TSUB:DILV7.FOR
COPY (FROM) FSUB:DIXV7.FOR (TO) TSUB:DIXV7.FOR
COPY (FROM) FSUB:DITV7.FOR (TO) TSUB:DITV7.FOR
!
! Third, copy the SRC stuff.  Sources are not included for DIL, so
! there is nothing to copy.
!
COPY (FROM) FSRC:BLISSNET-DESCRIPTOR.REQ (TO) TSRC:BLISSNET-DESCRIPTOR.REQ
COPY (FROM) FSRC:BLISSNET.REQ (TO) TSRC:BLISSNET.REQ
COPY (FROM) FSRC:BLISSNET20.R36 (TO) TSRC:BLISSNET20.R36
COPY (FROM) FSRC:BUILD-DIL.CTL (TO) TSRC:BUILD-DIL.CTL
COPY (FROM) FSRC:COMPDL.CTL (TO) TSRC:COMPDL.CTL
COPY (FROM) FSRC:COMPDT.CTL (TO) TSRC:COMPDT.CTL
COPY (FROM) FSRC:COMPDX.CTL (TO) TSRC:COMPDX.CTL
COPY (FROM) FSRC:CONDIT.REQ (TO) TSRC:CONDIT.REQ
COPY (FROM) FSRC:COPYRI.BLI (TO) TSRC:COPYRI.BLI
COPY (FROM) FSRC:CPYRIT.MAC (TO) TSRC:CPYRIT.MAC
COPY (FROM) FSRC:DAP-BLOCKS.REQ (TO) TSRC:DAP-BLOCKS.REQ
COPY (FROM) FSRC:DAP-CODES.REQ (TO) TSRC:DAP-CODES.REQ
COPY (FROM) FSRC:DAP-MACROS.REQ (TO) TSRC:DAP-MACROS.REQ
COPY (FROM) FSRC:DAP.BLI (TO) TSRC:DAP.BLI
COPY (FROM) FSRC:DAP1A-DIL.CTL (TO) TSRC:DAP1A-DIL.CTL
COPY (FROM) FSRC:DAPERR.BLI (TO) TSRC:DAPERR.BLI
COPY (FROM) FSRC:DAPHST.BLI (TO) TSRC:DAPHST.BLI
COPY (FROM) FSRC:DAPPER.B36 (TO) TSRC:DAPPER.B36
COPY (FROM) FSRC:DAPSUB.BLI (TO) TSRC:DAPSUB.BLI
COPY (FROM) FSRC:DAPT20.B36 (TO) TSRC:DAPT20.B36
COPY (FROM) FSRC:DIL-DEF.CMD (TO) TSRC:DIL-DEF.CMD
COPY (FROM) FSRC:DILCPY.CTL (TO) TSRC:DILCPY.CTL
COPY (FROM) FSRC:DILHST.BLI (TO) TSRC:DILHST.BLI
COPY (FROM) FSRC:DILINT.BLI (TO) TSRC:DILINT.BLI
COPY (FROM) FSRC:DILSWI.REQ (TO) TSRC:DILSWI.REQ
COPY (FROM) FSRC:DIR20.B36 (TO) TSRC:DIR20.B36
COPY (FROM) FSRC:DIRECT.BLI (TO) TSRC:DIRECT.BLI
COPY (FROM) FSRC:DIRLST.BLI (TO) TSRC:DIRLST.BLI
COPY (FROM) FSRC:DITHST.BLI (TO) TSRC:DITHST.BLI
COPY (FROM) FSRC:DIXCST.BLI (TO) TSRC:DIXCST.BLI
COPY (FROM) FSRC:DIXDEB.BLI (TO) TSRC:DIXDEB.BLI
COPY (FROM) FSRC:DIXDEB.REQ (TO) TSRC:DIXDEB.REQ
COPY (FROM) FSRC:DIXDN.BLI (TO) TSRC:DIXDN.BLI
COPY (FROM) FSRC:DIXFBN.BLI (TO) TSRC:DIXFBN.BLI
COPY (FROM) FSRC:DIXFP.BLI (TO) TSRC:DIXFP.BLI
COPY (FROM) FSRC:DIXGBL.BLI (TO) TSRC:DIXGBL.BLI
COPY (FROM) FSRC:DIXGEN.BLI (TO) TSRC:DIXGEN.BLI
COPY (FROM) FSRC:DIXHST.BLI (TO) TSRC:DIXHST.BLI
COPY (FROM) FSRC:DIXLIB.BLI (TO) TSRC:DIXLIB.BLI
COPY (FROM) FSRC:DIXPD.BLI (TO) TSRC:DIXPD.BLI
COPY (FROM) FSRC:DIXREQ.REQ (TO) TSRC:DIXREQ.REQ
COPY (FROM) FSRC:DIXSTR.BLI (TO) TSRC:DIXSTR.BLI
COPY (FROM) FSRC:DIXSWI.REQ (TO) TSRC:DIXSWI.REQ
COPY (FROM) FSRC:DIXUTL.BLI (TO) TSRC:DIXUTL.BLI
COPY (FROM) FSRC:EXT1A-DIL.CTL (TO) TSRC:EXT1A-DIL.CTL
COPY (FROM) FSRC:EXTHST.BLI (TO) TSRC:EXTHST.BLI
COPY (FROM) FSRC:FIELDS.BLI (TO) TSRC:FIELDS.BLI
COPY (FROM) FSRC:FT10.MAC (TO) TSRC:FT10.MAC
COPY (FROM) FSRC:FT20.MAC (TO) TSRC:FT20.MAC
COPY (FROM) FSRC:GETPUT.BLI (TO) TSRC:GETPUT.BLI
COPY (FROM) FSRC:INTERFILS.BLI (TO) TSRC:INTERFILS.BLI
COPY (FROM) FSRC:INTERFILS.CTL (TO) TSRC:INTERFILS.CTL
COPY (FROM) FSRC:JSYSDEF.R36 (TO) TSRC:JSYSDEF.R36
COPY (FROM) FSRC:M11FIL.B36 (TO) TSRC:M11FIL.B36
COPY (FROM) FSRC:MAKDIL.CTL (TO) TSRC:MAKDIL.CTL
COPY (FROM) FSRC:NXTF20.B36 (TO) TSRC:NXTF20.B36
COPY (FROM) FSRC:NXTFIL.BLI (TO) TSRC:NXTFIL.BLI
COPY (FROM) FSRC:OPEN.BLI (TO) TSRC:OPEN.BLI
COPY (FROM) FSRC:POS20.BLI (TO) TSRC:POS20.BLI
COPY (FROM) FSRC:POSGEN.BLI (TO) TSRC:POSGEN.BLI
COPY (FROM) FSRC:RDWRIT.B36 (TO) TSRC:RDWRIT.B36
COPY (FROM) FSRC:RMS.R36 (TO) TSRC:RMS.R36
COPY (FROM) FSRC:RMSBLK.R36 (TO) TSRC:RMSBLK.R36
COPY (FROM) FSRC:RMSERR.B36 (TO) TSRC:RMSERR.B36
COPY (FROM) FSRC:RMSINT.R36 (TO) TSRC:RMSINT.R36
COPY (FROM) FSRC:RMSLIB.R36 (TO) TSRC:RMSLIB.R36
COPY (FROM) FSRC:RMSUSR.R36 (TO) TSRC:RMSUSR.R36
COPY (FROM) FSRC:SETAI.BLI (TO) TSRC:SETAI.BLI
COPY (FROM) FSRC:STAR36.BLI (TO) TSRC:STAR36.BLI
COPY (FROM) FSRC:STRING.B36 (TO) TSRC:STRING.B36
COPY (FROM) FSRC:TOPS20.R36 (TO) TSRC:TOPS20.R36
COPY (FROM) FSRC:TRACE.BLI (TO) TSRC:TRACE.BLI
COPY (FROM) FSRC:TTT.MAC (TO) TSRC:TTT.MAC
COPY (FROM) FSRC:UNDECLARE.REQ (TO) TSRC:UNDECLARE.REQ
COPY (FROM) FSRC:VERSION.REQ (TO) TSRC:VERSION.REQ
COPY (FROM) FSRC:XPN1A-DIL.CTL (TO) TSRC:XPN1A-DIL.CTL
COPY (FROM) FSRC:XPNCLO.B36 (TO) TSRC:XPNCLO.B36
COPY (FROM) FSRC:XPNDIS.B36 (TO) TSRC:XPNDIS.B36
COPY (FROM) FSRC:XPNERR.B36 (TO) TSRC:XPNERR.B36
COPY (FROM) FSRC:XPNEVE.B36 (TO) TSRC:XPNEVE.B36
COPY (FROM) FSRC:XPNFAI.B36 (TO) TSRC:XPNFAI.B36
COPY (FROM) FSRC:XPNGET.B36 (TO) TSRC:XPNGET.B36
COPY (FROM) FSRC:XPNHST.BLI (TO) TSRC:XPNHST.BLI
COPY (FROM) FSRC:XPNOPN.B36 (TO) TSRC:XPNOPN.B36
COPY (FROM) FSRC:XPNPMR.B36 (TO) TSRC:XPNPMR.B36
COPY (FROM) FSRC:XPNPSI.MAC (TO) TSRC:XPNPSI.MAC
COPY (FROM) FSRC:XPNPUT.B36 (TO) TSRC:XPNPUT.B36
COPY (FROM) FSRC:XPNUTL.B36 (TO) TSRC:XPNUTL.B36

! 
! Fourth, copy all the BLD stuff.
!
COPY (FROM) FSRC:DIL2V2.REL (TO) TSub:DIL2V2.REL
COPY (FROM) FSRC:DIT2V2.REL (TO) TSub:DIT2V2.REL
COPY (FROM) FSRC:DIX2V2.REL (TO) TSub:DIX2V2.REL
COPY (FROM) FSRC:DAP2V1.REL (TO) TSub:DAP2V1.REL
COPY (FROM) FSRC:XPN2V1.REL (TO) TSub:XPN2V1.REL
!
! Fifth, and last, copy all the ICS stuff.
!
COPY (FROM) FUTP:C36T2.CBL (TO) TUTP:C36T2.CBL
COPY (FROM) FUTP:CD36T1.CBL (TO) TUTP:CD36T1.CBL
COPY (FROM) FUTP:CT36T1.CBL (TO) TUTP:CT36T1.CBL
COPY (FROM) FUTP:F7T2.FOR (TO) TUTP:F7T2.FOR
COPY (FROM) FUTP:FD7T1.FOR (TO) TUTP:FD7T1.FOR
COPY (FROM) FUTP:FT7T1.FOR (TO) TUTP:FT7T1.FOR
COPY (FROM) FUTP:ICSCBL.CTL (TO) TUTP:ICSCBL.CTL
COPY (FROM) FUTP:ICSF7.CTL (TO) TUTP:ICSF7.CTL
!
!MORE SOURCE FILES NEED (+)
COPY FSRC:DIL.RND TSRC:
COPY FSRC:DIL.RNH TSRC:
COPY FSRC:DILBWR.RNO TSRC:
COPY FSRC:DILDOC.INI TSRC:
COPY FSRC:MASTER-DIL.CTL TSRC:
COPY FSRC:DILC36.INT TSRC:
COPY FSRC:DITC36.INT TSRC:
COPY FSRC:DILCPY.CMD TSRC:
! END OF TAPE FILES
