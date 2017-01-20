!MX20.CTL
!	COPYRIGHT (c) DIGITAL EQUIPMENT CORPORATION 1985, 1989.
!	ALL RIGHTS RESERVED.
!
!	THIS SOFTWARE IS FURNISHED UNDER A  LICENSE AND MAY BE USED AND  COPIED
!	ONLY IN  ACCORDANCE  WITH  THE  TERMS OF  SUCH  LICENSE  AND  WITH  THE
!	INCLUSION OF THE ABOVE  COPYRIGHT NOTICE.  THIS  SOFTWARE OR ANY  OTHER
!	COPIES THEREOF MAY NOT BE PROVIDED  OR OTHERWISE MADE AVAILABLE TO  ANY
!	OTHER PERSON.  NO  TITLE TO  AND OWNERSHIP  OF THE  SOFTWARE IS  HEREBY
!	TRANSFERRED.
!
!	THE INFORMATION IN THIS  SOFTWARE IS SUBJECT  TO CHANGE WITHOUT  NOTICE
!	AND SHOULD  NOT  BE CONSTRUED  AS  A COMMITMENT  BY  DIGITAL  EQUIPMENT
!	CORPORATION.
!
!	DIGITAL ASSUMES NO  RESPONSIBILITY FOR  THE USE OR  RELIABILITY OF  ITS
!	SOFTWARE ON EQUIPMENT THAT IS NOT SUPPLIED BY DIGITAL.

!++
!   MX20.CTL
!
!       This file is used to build MX. It assumes all the sources will be
!	 in the connected directory.
!
!       The EXE and all the RELs will be created in the connected directory.
!	MX.REL will be created with the appropriate copyright protection.
!
!	The following tags are supported:
!	@submit MX20/TAG:FORCE  - Force a rebuild of all the sources,
!				  including the libraries
!	@submit MX20/TAG:FREEZE - Used for packaging, baselevel freezes, etc.
!                                 If MXFRZ: is defined, it copies pertinent
!                                 files to freeze area, does a FORCE build,
!                                 then deletes intermediate REL files that
!                                 are not required for packaging.  If MXFRZ
!                                 is not defined, then this is like a FORCE
!                                 build which deletes intermediate REL
!                                 files.  Not generally useful for
!                                 customers.
!	@submit MX20/TAG:LINK   - Relink, but do not recompile anything
!       @submit MX20/TAG:DEBUG  - Like "Submit MX20" but build standalone MX
!	@submit MX20		- This recompiles only those modules that
!				  have changed.  If a library must be
!				  recompiled, use /TAG:FORCE or /TAG:FREEZE 
!--
@DEL *.CCL
@GOTO BEGIN
DEBUG::
@COPY TTY: MXDEB.CCL
^Z
@GOTO BEGIN
FREEZE::
!
![smw 3/12/90] MXDREL references removed so .RELs hang around
! Creating file MXDREL.CCL causes a force build, but deletes the various
! .REL files (except MX.REL) and .L36 files.
!
! The results from using this Tag are the files needed for Autopatch
! packaging.  If MXFRZ: is defined, all required files are copied to MXFRZ:
! and the build is performed there instead of in the connected directory.
!
!@COPY TTY: MXDREL.CCL
!DELETE M20INT.REL,M20IPC.REL,MXNMEM.REL,MXNPAG.REL,MXNQUE.REL,MXNSKD.REL
!DELETE MXNT20.REL,MXNTBL.REL,MXNTXT.REL,MXNNET.REL,MXDATA.REL,MXHOST.REL
!DELETE MXLCL.REL,MXQMAN.REL,MXUFIL.REL,MXERR.REL,MXDCNT.REL,TBL.REL
!DELETE MXVER.REL,SMTLIS.REL,SMTSEN.REL,SENVAX.REL,LISVAX.REL,MXFORK.REL
!DELETE SUBDCN.REL,CPYRYT.REL,NETTAB.REL,*.L36
!^Z
!
!If MXFRZ: is not defined, go do a force build, deleting intermediate REL
!files. 
!
@TAKE SETSRC
@ERROR %
@INFO LOG MXFRZ:
@IF (ERROR) GOTO FOR1
@DEL MXFRZ:*.*
@UNDEL MXFRZ:MX1A*.*
@COPY *.CTL,*.MAC,*.B36,*.R36 MXFRZ:
!@RENAME MXDREL.CCL MXFRZ:MXDREL.CCL
@CONN MXFRZ:
@GOTO FOR1
FORCE::
!
! We force the recompilation of the libraries, and all of the other modules
! in MX.
!
@DEL *.CCL
FOR1::
@ERROR ?
@COPY TTY: MXMLIB.CCL
MONSYM.R36,MXJLNK.R36,MXNLIB.R36,MXLIB.R36,TBL.R36
^Z
@DEL *.REL
BEGIN::
@DEL MX.REL
!
! Don't complain if SETSRC.CMD doesn't exist.  We didn't supply one.
!
@TAKE SETSRC
@IF (ERROR) GOTO LIBS
LIBS::
@VDIR *.*,
@SMALLER 1
@
@
!
!Compile the libraries
!
@ERROR %
@DIR MXMLIB.CCL
@IF (ERROR) GOTO NML
@ERROR ?
@COMPILE /COMP/36-BLISS/LANG:"/LIB:" @MXMLIB.CCL
@DELETE MXMLIB.CCL
!
!Compile the nml-based modules
!
NML::
@ERROR ?
@INFO LOG DSK:
@COMPILE -
@ M20INT.B36,MXNMEM.B36,MXNPAG.B36,MXNQUE.B36,-
@ MXNTBL.B36,MXNTXT.B36,M20IPC.B36 
!
!Compile the mx logic modules
!
MX::
@COMPILE -
@ MXDATA.B36,MXHOST.B36,MXLCL.B36,MXQMAN.B36,MXUFIL.B36,-
@ TBL.B36,MXERR.B36,MXDCNT.B36,MXNSKD.B36,MXNNET.B36,MXFORK.B36
!
!Assemble the macro modules.
!
MACS::
@COMPILE -
@ CPYRYT.MAC,SENVAX.MAC,T20+LISVAX.MAC,SMTSEN.MAC,-
@ SMTLIS.MAC,MXNT20.MAC,MXVER.MAC,NETTAB.MAC,SUBDCN.MAC
!
!Create MX.REL
!
LINK::
@COPY CPYRYT.REL MX.REL
@APPEND -
@ M20INT.REL,M20IPC.REL,MXNMEM.REL,MXNPAG.REL,MXNQUE.REL,MXNSKD.REL,-
@ MXNTBL.REL,MXNTXT.REL,MXNNET.REL,MXDATA.REL,MXHOST.REL,MXFORK.REL,-
@ MXLCL.REL,MXQMAN.REL,MXUFIL.REL,MXERR.REL,MXDCNT.REL,TBL.REL -
@ MX.REL
!
!Link all modules
!
@LINK
*MX,
*MXNT20
*SMTLIS
*SMTSEN
*SENVAX
*LISVAX
*SUBDCN
*NETTAB
*MXVER
*/SAVE MX
*/MAP MX
*/go
!
! Delete the rels
!
DELETE::
@ERROR %
@DIR MXDEB.CCL
@IF (ERROR) GOTO DONE
@GET MX
@DDT
MXLCL^[:P.AAC/"/MXTEST/
NSMTP/ 0
NVM11/ 0

^Z
@SAVE MXDBUG 0 677
@DEL MXDEB.CCL
DONE::
@