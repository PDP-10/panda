!COMMAND FILE FOR OBTAINING ALL FILES RELEVANT TO RDMAIL
INFORMATION LOGICAL-NAMES FROM*:
INFORMATION LOGICAL-NAMES TO*:

;Files required to build product
COPY FROM-SOURCE:RDMAIL.CMD TO-SOURCE:*.*.-1
COPY FROM-SOURCE:RDMAIL.CTL TO-SOURCE:*.*.-1
COPY FROM-SOURCE:RDMAIL.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:REL1.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:CMD.MAC TO-SOURCE:*.*.-1

;Documentation for product
COPY FROM-SOURCE:RDMAIL.HLP TO-SOURCE:*.*.-1
COPY FROM-SOURCE:RDMAIL.DOC TO-SOURCE:*.*.-1

;Final product
COPY FROM-SOURCE:RDMAIL.EXE TO-SOURCE:*.*.-1

