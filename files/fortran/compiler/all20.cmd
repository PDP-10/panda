;FTN:<AMARTIN>ALL20.CMD.2 27-Jul-84 16:51:31, Edit by AMARTIN
; Decrease hiseg origin to 334000 to leave room for PA1050

;COPYRIGHT (c) DIGITAL EQUIPMENT CORPORATION 1982, 1987
;ALL RIGHTS RESERVED.
;
;THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY BE USED AND COPIED
;ONLY  IN  ACCORDANCE  WITH  THE  TERMS  OF  SUCH LICENSE AND WITH THE
;INCLUSION OF THE ABOVE COPYRIGHT NOTICE.  THIS SOFTWARE OR ANY  OTHER
;COPIES THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE AVAILABLE TO ANY
;OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF THE  SOFTWARE  IS  HEREBY
;TRANSFERRED.
;
;THE INFORMATION IN THIS SOFTWARE IS SUBJECT TO CHANGE WITHOUT  NOTICE
;AND  SHOULD  NOT  BE  CONSTRUED  AS A COMMITMENT BY DIGITAL EQUIPMENT
;CORPORATION.
;
;DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR RELIABILITY  OF  ITS
;SOFTWARE ON EQUIPMENT WHICH IS NOT SUPPLIED BY DIGITAL.

/RUNAME:FORTRA FORTRA/SAVE/MAP /CONTENTS:(LOCAL,ZERO) /HASHSIZE:2500= -
/SET:.HIGH.:334000/LOCALS /SYMSEG:HIGH -
REVHST, EXOSUP, MAIN.REL, GLOBAL, -
ERR3, JOBD, SRCA, CNSTCM, ERROUT, UTIL, FLTGEN, DOXPN, FAZ1,  -
GNRCFN, EXPRES, STA0, STA1, STA2.REL, STA3, FORMAT, ACT0, ACT1, INOUT.REL,  -
CODETA, LEXSUP, LEXCLA, LEXICA, LISTNG.REL, DRIVER, UNEND, CMND20.REL,  -
P2S1, P2S2, MEMCMP, SKSTMN, INPT, IOPT, GOPTIM, -
GOPT2, GRAPH, CANNON, DEFPT, MOVA, COMSUB, GCMNSB, PNROPT, TSTR, PHA2, -
PH2S, PHA3, OPTAB, LISTOU, CGDO, CGSTMN, CGEXPR, OPGNTA, PEEPOP,  -
STREGA, CMPLEX, CMPBLO, ALCBLO, DOALC, REGAL2, REGUTL, DATAST,  -
P3R, RELBUF, DEBUG, VLTPPR,  -
OUTMOD, PH3G, ARRXPN, VER5/START:FORTRA/COUNTER/GO
    