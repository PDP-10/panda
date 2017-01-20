!COMMAND FILE FOR GETTING ALL FILES NEEDED TO ASSEMBLE AND RUN USAH20
INFORMATION LOGICAL-NAMES

;Files required to build product
COPY FROM-SOURCE:USAH20.FOR TO-SOURCE:*.*.-1
COPY FROM-SOURCE:USAH20.CMD TO-SOURCE:*.*.-1
COPY FROM-SOURCE:USAH20.CTL TO-SOURCE:*.*.-1

;Documentation for product
COPY FROM-SOURCE:USAH20.HLP TO-SOURCE:*.*.-1
COPY FROM-SOURCE:USAH20.DOC TO-SOURCE:*.*.-1

;Library files used for symbols

;Final product
COPY FROM-SOURCE:USAH20.EXE TO-SUBSYS:*.*.-1
COPY FROM-SOURCE:USAG20.CHG TO-SOURCE:*.*.-1
