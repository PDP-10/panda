!COMMAND FILE FOR OBTAINING ALL FILES RELEVANT TO MAILER
INFORMATION LOGICAL-NAMES FROM*:
INFORMATION LOGICAL-NAMES TO*:

;Files required to build product
COPY FROM-SOURCE:MAILER.CMD TO-SOURCE:*.*.-1
COPY FROM-SOURCE:MAILER.CTL TO-SOURCE:*.*.-1
COPY FROM-SOURCE:MAILER.MAC TO-SOURCE:*.*.-1
COPY FROM-SOURCE:MAILER-ARMAIL.MAC TO-SOURCE:*.*.-1

;Documentation for product
COPY FROM-DOC:MAILER.DOC TO-DOC:*.*.-1

;Final product
COPY FROM-SUBSYS:MAILER.EXE TO-SUBSYS:*.*.-1
