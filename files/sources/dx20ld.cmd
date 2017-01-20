!COMMAND FILE FOR OBTAINING ALL FILES RELEVANT TO BUILDING DX20LD
INFORMATION LOGICAL-NAMES FROM*:
INFORMATION LOGICAL-NAMES TO*:

;Files required to build product
COPY FROM-SOURCE:DX20LD.CMD TO-SOURCE:*.*.-1
COPY FROM-SOURCE:DX20LD.CTL TO-SOURCE:*.*.-1
COPY FROM-SOURCE:DX20LD.MAC TO-SOURCE:*.*.-1

;Documentation for product
COPY FROM-DOC:DX20LD.DOC TO-DOC:*.*.-1

;Final product
COPY FROM-SUBSYS:DX20LD.EXE TO-SUBSYS:*.*.-1

