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
@MOUNT TAPE TAPE:/READ/REMARK:"BB-4148F-BM DBMS V6.1"
@RUN DUMPER
*TAPE TAPE:
*SKIP 1
*RESTORE PS:<SUBSYS>*.* DBMALL:
*RESTORE PS:<SOURCES>*.* DBMALL:
*SKIP 1
*RESTORE PS:<TOOLS>*.* DBMALL:
*REWIND
*EXIT
@DISMOUNT TAPE:
@MOUNT TAPE TAPE2:/READ/REMARK:"BB-PAM0A-BM DBMS KEYS"
@RUN DUMPER
*TAPE TAPE2:
*RESTORE PS:<*>DBMDOC.KEY DBMALL:DBMALL.KEY
*REWIND
*EXIT
@DISMOUNT TAPE2:
