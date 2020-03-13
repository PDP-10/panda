!COMMAND FILE FOR OBTAINING ALL FILES RELEVANT TO BUILDING VERIFY
INFORMATION LOGICAL-NAMES FROM*:
INFORMATION LOGICAL-NAMES TO*:

;Files required to build product
COPY FROM-SOURCE:VERIFY.CMD TO-SOURCE:*.*.-1
COPY FROM-SOURCE:VERIFY.CTL TO-SOURCE:*.*.-1
COPY FROM-SOURCE:VERIFY.MAC TO-SOURCE:*.*.-1

;Documentation for product
COPY FROM-DOC:VERIFY.DOC TO-DOC:*.*.-1

;Library files used for symbols

;Final product
COPY FROM-SUBSYS:VERIFY.EXE TO-SUBSYS:*.*.-1
    