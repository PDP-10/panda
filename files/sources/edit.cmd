!COMMAND FILE FOR OBTAINING ALL FILES RELEVANT TO BUILDING EDIT
INFORMATION LOGICAL-NAMES TO-*:
INFORMATION LOGICAL-NAMES FROM-*:

;Files required to build product
COPY FROM-SOURCE:EDIT.CMD TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EDIT.CTL TO-SOURCE:*.*.-1
COPY FROM-SOURCE:EDIT.MAC TO-SOURCE:*.*.-1

;Documentation for product
COPY FROM-HLP:EDIT.HLP TO-HLP:*.*.-1
COPY FROM-doc:EDIT.DOC TO-DOC:*.*.-1

;Final product
COPY FROM-SOURCE:EDIT.EXE TO-SUBSYS:*.*.-1
 