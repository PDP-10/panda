
!COMMAND FILE FOR OBTAINING ALL FILES RELEVANT TO BUILDING TOPS-20 GALAXY V6.0

INFORMATION LOGICAL-NAMES

;Files required to build product
;  Copy the GALAXY library files

COPY (FROM) FROM-SOURCE:GALCNF.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GLXCOM.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GLXFIL.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GLXINI.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GLXINT.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GLXIPC.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GLXKBD.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GLXLNK.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GLXMAC.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GLXMEM.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GLXOTS.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GLXSCN.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GLXTXT.MAC (TO) TO-GAL-SRC:*.*.-1

;  Copy the library control files

COPY (FROM) FROM-SOURCE:GLXLIB.CTL (TO) TO-GAL-SRC:*.*.-1
;COPY (FROM) FROM-SOURCE:GLXLIB.CCL (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary QUASAR files

COPY (FROM) FROM-SOURCE:QUASAR.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:QSRADM.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:QSRDSP.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:QSRFSS.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:QSRIPC.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:QSRMAC.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:QSRMDA.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:QSRMEM.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:QSRNET.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:QSRQUE.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:QSRSCH.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:QSRT20.MAC (TO) TO-GAL-SRC:*.*.-1

COPY (FROM) FROM-SOURCE:QUASAR.CTL (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary OPR/ORION files

COPY (FROM) FROM-SOURCE:OPR.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:ORNMAC.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:OPRCMD.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:OPRERR.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:OPRLOG.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:OPRNET.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:OPRPAR.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:OPRQSR.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:OPRSCM.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:OPRNEB.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:ORION.MAC (TO) TO-GAL-SRC:*.*.-1

COPY (FROM) FROM-SOURCE:OPERAT.CTL (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary NEBULA files

COPY  (FROM) FROM-SOURCE:NEBMAC.MAC (TO) TO-GAL-SRC:*.*.-1
COPY  (FROM) FROM-SOURCE:NEBULA.MAC (TO) TO-GAL-SRC:*.*.-1

COPY  (FROM) FROM-SOURCE:NEBULA.CTL (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary BATCON files

COPY (FROM) FROM-SOURCE:BATCON.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:BATLOG.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:BATMAC.MAC (TO) TO-GAL-SRC:*.*.-1

COPY (FROM) FROM-SOURCE:BATCON.CTL (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary CDRIVE files

COPY (FROM) FROM-SOURCE:CDRIVE.MAC (TO) TO-GAL-SRC:*.*.-1

COPY (FROM) FROM-SOURCE:CDRIVE.CTL (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary LPTSPL files

COPY (FROM) FROM-SOURCE:LPTSPL.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:LPTCLU.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:LPTDQS.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:LPTSUB.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:LPTUSR.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:LPTMAC.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:LISMAC.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:LISSPL.MAC (TO) TO-GAL-SRC:*.*.-1

COPY (FROM) FROM-SOURCE:LPTSPL.CTL (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary MOUNTR files

COPY (FROM) FROM-SOURCE:MOUNTR.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:MTRMAC.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:MTRCFS.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:MTRDDB.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:MTRUSR.MAC (TO) TO-GAL-SRC:*.*.-1

COPY (FROM) FROM-SOURCE:MOUNTR.CTL (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary PLEASE files

COPY (FROM) FROM-SOURCE:PLEASE.MAC (TO) TO-GAL-SRC:*.*.-1

COPY (FROM) FROM-SOURCE:PLEASE.CTL (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary QMANGR files

COPY (FROM) FROM-SOURCE:QMANGR.MAC (TO) TO-GAL-SRC:*.*.-1

COPY (FROM) FROM-SOURCE:QMANGR.CTL (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary SPRINT files

COPY (FROM) FROM-SOURCE:SPRINT.MAC (TO) TO-GAL-SRC:*.*.-1

COPY (FROM) FROM-SOURCE:SPRINT.CTL (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary SPROUT files

COPY (FROM) FROM-SOURCE:SPROUT.MAC (TO) TO-GAL-SRC:*.*.-1

COPY (FROM) FROM-SOURCE:SPROUT.CTL (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary IBMCOM files

COPY (FROM) FROM-SOURCE:D60UNV.MAC (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:D60JSY.MAC (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary GALGEN files

COPY (FROM) FROM-SOURCE:GALGEN.CTL (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GALGEN.MAC (TO) TO-GAL-SRC:*.*.-1

;  Copy necessary NURD files

COPY (FROM) FROM-SOURCE:NURD.MAC (TO) TO-GAL-SRC:*.*.-1

;  Finally get the master control and command files

COPY (FROM) FROM-SOURCE:GALAXY.CMD (TO) TO-GAL-SRC:*.*.-1
COPY (FROM) FROM-SOURCE:GALAXY.CTL (TO) TO-GAL-SRC:*.*.-1

;System Utilities and Universals
COPY FROM-SUBSYS:GLXLIB.REL  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:GLXMAC.UNV  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:OPRPAR.REL  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:ORNMAC.UNV  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:QSRMAC.UNV  TO-SUBSYS:*.*.-1
COPY FROM-SOURCE:NCPTAB.REL  TO-SUBSYS:*.*.-1
COPY FROM-SOURCE:LCPTAB.REL  TO-SUBSYS:*.*.-1
COPY FROM-SOURCE:LCPORN.REL  TO-SUBSYS:*.*.-1

;Final product
COPY FROM-SUBSYS:BATCON.EXE  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:CDRIVE.EXE  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:GALGEN.EXE  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:GLXLIB.EXE  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:LISSPL.EXE  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:LPTSPL.EXE  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:MOUNTR.EXE  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:NEBULA.EXE  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:OPR.HLP     TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:OPR.EXE     TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:ORION.EXE   TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:PLEASE.HLP  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:PLEASE.EXE  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:QMANGR.EXE  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:QUASAR.EXE  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:SPRINT.EXE  TO-SUBSYS:*.*.-1
COPY FROM-SUBSYS:SPROUT.EXE  TO-SUBSYS:*.*.-1

;Documentation for product
COPY FROM-DOC:GALAXY.DOC  TO-DOC:*.*.-1
;COPY FROM-DOC:GALAXY.BWR  TO-DOC:*.*.-1
;COPY FROM-DOC:GALAXY.BWR  TO-SYSTEM:*.*.-1

 