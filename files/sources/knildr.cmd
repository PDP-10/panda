;Command file to copy all needed files for building KNILDR.

;Source files
COPY FROM-SOURCE:KNILDR.CTL TO-SOURCE:
COPY FROM-SOURCE:KNILDR.MAC TO-SOURCE:
COPY FROM-SOURCE:KNILDR.CMD TO-SOURCE:
COPY FROM-SOURCE:RAM.ULD    TO-SOURCE:

;Final product
COPY FROM-SOURCE:KNILDR.EXE TO-SYSTEM:
COPY FROM-SOURCE:KNILDR.EXE TO-SUBSYS:
    