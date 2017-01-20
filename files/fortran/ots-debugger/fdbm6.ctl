;FDBM6.CTL		CTL EDIT 12	VERSION [6%363]		SEP-82

;     This software is furnished under a license and may only be used
;       or copied in accordance with the terms of such license.
;
;COPYRIGHT (c) DIGITAL EQUIPMENT CORPORATION 1974, 1987
;ALL RIGHTS RESERVED.
;
;THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY BE USED AND COPIED
;ONLY  IN  ACCORDANCE  WITH  THE  TERMS  OF  SUCH LICENSE AND WITH THE
;INCLUSION OF THE ABOVE COPYRIGHT NOTICE.  THIS SOFTWARE OR ANY  OTHER
;COPIES THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE AVAILABLE TO ANY
;OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF THE  SOFTWARE  IS  HEREBY
;TRANSFERRED.
;
;THE INFORMATION IN THIS SOFTWARE IS SUBJECT TO CHANGE WITHOUT  NOTICE
;AND  SHOULD  NOT  BE  CONSTRUED  AS A COMMITMENT BY DIGITAL EQUIPMENT
;CORPORATION.
;
;DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR RELIABILITY  OF  ITS
;SOFTWARE ON EQUIPMENT WHICH IS NOT SUPPLIED BY DIGITAL.

;	EXAMINE THE INSTALLATION GUIDE BEFORE SUBMITTING
;	THIS CTL FILE.
;
;REQUIRED FILES:	(LATEST RELEASED VERSIONS)
;
;SYS:		MAKLIB		LINK V6.0	FORTRA.EXE	FORO11.EXE
;		FORLIB.REL
;
;DSK:		FDBM6.CTL	FDBM6.FOR	DBCS2F.CMD	FDBM6.CCL
; 		DBSFG.REL	DBSANY.REL	DBS20.REL	SCHIO2.REL
;
;OUTPUT:
;
;	 DBMSF.EXE, DBMSF.MAP, AND DBMSF.REL
;
;OUTPUT LISTINGS:	FDBM6.LOG
;


@INFO LOGICAL

@GET SYS:LINK
@INFO VERSION
@GET SYS:MAKLIB
@INFO VERSION

@VDIRECT SYS:MAKLIB.EXE,SYS:LINK.EXE
@
@VDIRECT DBS20.REL,DBSANY.REL,DBSFG.REL,SCHIO2.REL
@

@ERROR
@TYPE FDBM6.CCL
@R MAKLIB
*@FDBM6.CCL
@IF (ERROR) @GOTO TRUBLE
@EXECUTE FDBM6.FOR
@IF (ERROR) @GOTO TRUBLE

@TYPE DBCS2F.CMD
@LINK
*@DBCS2F.CMD
@GET DBMSF.EXE
@IF (ERROR) @GOTO TRUBLE
@SAVE DSK:DBMSF.EXE 700 765
@IF (ERROR) @GOTO TRUBLE
@EXPUNGE


;	**********   TELL HOW WE DID   **********

@PLEASE -- DBMS-20 CREATION SUCCESSFUL!!!

@GOTO ENDOF

TRUBLE::
@PLEASE -- DBMS-20 CREATION NOT SUCCESSFUL???

ENDOF::
@EXPUNGE
@LOGO
;		[ END OF FDBM6.CTL ]
