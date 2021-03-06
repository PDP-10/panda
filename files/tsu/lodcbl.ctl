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
@DEFINE BASE: TSU:<UPDATE>
@ENABLE
@TAKE TSU.CMD
@MOUNT TAPE TAPE:/READ/REMARK:"BB-Z759A-SM COBOL V13/SORT V5"
@RUN DUMPER
*TAPE TAPE:
*SKIP 1
*RESTORE -
PS:<SUBSYS>SORT.* SRTSYS:, -
PS:<SUBSYS>*.* CBLSYS:
*RESTORE -
PS:<COBOL-SOURCE>COBOL.KEY BASE:, -
PS:<COBOL-SOURCE>COBLIB.KEY BASE:, -
PS:<COBOL-SOURCE>*.* CBLSRC:
*RESTORE -
PS:<SORT-SOURCE>SORT.KEY BASE:, -
PS:<SORT-SOURCE>*.* SRTSRC:
*REWIND
*EXIT
@DISMOUNT TAPE:
@COPY BASE:COBLIB.KEY CBLSRC:
@COPY BASE:COBLIB.KEY CBLSRC:CBLSRC.KEY
@DELETE BASE:COBLIB.KEY
@COPY BASE:COBOL.KEY CBLSRC:
@COPY BASE:COBOL.KEY CBLSYS:CBLSYS.KEY
@DELETE BASE:COBOL.KEY
@COPY BASE:SORT.KEY SRTSRC:
@COPY BASE:SORT.KEY SRTSRC:SRTSRC.KEY
@COPY BASE:SORT.KEY SRTSYS:SRTSYS.KEY
@DELETE BASE:SORT.KEY
   