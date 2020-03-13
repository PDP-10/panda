;Command file to build SED
INFORMATION LOGICAL-NAMES FROM-*:
INFORMATION LOGICAL-NAMES TO-*:

;Files required to build product
;Source and terminal-dependent files:
COPY FROM-SOURCE:SED.CTL TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDV2.CMD TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED.CMD TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED1CM.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED1DS.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED1DT.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED1EX.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED1FI.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED1JO.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED1MV.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED1ST.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED1SU.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED1SW.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDA3A.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDVS2.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDSYM.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDTTY.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDX.MAC TO-SOURCE:*.*.-1

;Installation tool:
COPY FROM-SOURCE:SEDONL.EXE TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDONL.HLP TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDONL.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDONL.TXT TO-SOURCE:*.*.-1


;On-line documentation files:
COPY FROM-SOURCE:SED.DIR TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDONL.EXE TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDONL.HLP TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDONL.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDONL.TXT TO-SOURCE:*.*.-1

;Documentation generators:
COPY FROM-SOURCE:SEDRNO.EXE TO-SOURCE:*.*.-1


;Execute buffer files:
COPY FROM-SOURCE:SED.XCT TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDMAC.XCT TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDEMC.XCT TO-SOURCE:*.*.-1


;Documentation for product
COPY FROM-SOURCE:SED.DOC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED.HLP TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED.MAN TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED.MEM TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDRNO.MEM TO-SOURCE:*.*.-1

;Terminal keyboard layout files:
COPY FROM-SOURCE:SEDAD2.KYS TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDEMC.KYS TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDM2A.KYS TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDV10.KYS TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDV52.KYS TO-SOURCE:*.*.-1

;Documentation sources:
COPY FROM-SOURCE:SED.BWR TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED.DIR TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED.POS TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED.RND TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED.RNM TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED.RNO TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SED.SHF TO-SOURCE:*.*.-1
COPY FROM-SOURCE:SEDLET.TXT TO-SOURCE:*.*.-1


;Final product
COPY FROM-SOURCE:SED.EXE TO-SUBSYS:*.*.-1
    