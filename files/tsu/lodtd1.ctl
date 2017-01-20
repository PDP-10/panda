;
;		       COPYRIGHT (c) 1990 BY
;	    Digital Equipment Corporation, Maynard, MA.
;
;   This software is furnished under a license and may be  used
;   and  copied  only  in  accordance  with  the  terms of such
;   license and with  the  inclusion  of  the  above  copyright
;   notice.   This software or any other copies thereof may not
;   be provided  or  otherwise	made  available  to  any  other
;   person.   No  title  to  and  ownership  of the software is
;   hereby transferred.
;
;   The information in	this  software	is  subject  to  change
;   without  notice and should not be construed as a commitment
;   by Digital Equipment Corporation.
;
;   Digital  assumes  no  responsibility   for	 the   use   or
;   reliability  of  its  software  on	equipment  which is not
;   supplied by Digital.
;
@ENABLE
@TAKE TSU.CMD
@MOUNT TAPE TAPE:/READ/REMARK:"BB-H138F-BM TOPS 20 V7.0 DISTRIBUTION 1/2"
@RUN DUMPER
*TAPE TAPE:
*RESTORE PS:<7-SOURCES>*.* T20SRC:
*REWIND
*EXIT
@DISMOUNT TAPE:
;REMOVE MX V1 DISTRIBUTION
@DELETE T20SRC:CPYRYT.MAC
@DELETE T20SRC:SENVAX.MAC
@DELETE T20SRC:LISVAX.MAC
@DELETE T20SRC:SMTSEN.MAC
@DELETE T20SRC:SMTLIS.MAC
@DELETE T20SRC:NETTAB.MAC
@DELETE T20SRC:M20TYP.REQ
@DELETE T20SRC:TBL.REQ
@DELETE T20SRC:BLT.R36
@DELETE T20SRC:M20INT.BLI
@DELETE T20SRC:M20INT.REL
@DELETE T20SRC:TBL.BLI
@DELETE T20SRC:TBL.REL
@DELETE T20SRC:NEWT20.B36
@DELETE T20SRC:M20IPC.B36
@DELETE T20SRC:M20IPC.REL
@DELETE T20SRC:NETT20.B36
@DELETE T20SRC:MX*.*
@
