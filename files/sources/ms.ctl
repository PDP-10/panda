;SNARK:<MS.11.BUILD>MS.CTL.3, 18-Nov-87 15:22:39, Edit by RASPUZZI
;Set Trap file openings for COMP too.
!
!	Build MS Version 11
!
!	LEGAL TAGS TO START FROM ARE:
!		LNK	to just link .RELs
!		COMP	to force compiles on all modules
!
@Take Setsrc.cmd
@I Logical SYS:
@I Logical DSK:
@I Logical SYSTEM:
!
!	Check version of Macro
!
@Get Sys:Macro
@I Ver
!
!	Compile all macro modules
!
@SET TRAP FILE
@compile/macro MSUNV.MAC
@compile/macro MS.MAC
@compile/macro MSCNFG.MAC
@compile/macro MSDLVR.MAC
@compile/macro MSDSPL.MAC
@compile/macro MSFIL.MAC
@compile/macro MSMCMD.MAC
@compile/macro MSGUSR.MAC
@compile/macro MSHOST.MAC
@compile/macro MSLCL.MAC
@compile/macro MSNET.MAC
@compile/macro MSSEQ.MAC
@compile/macro MSTXT.MAC
@compile/macro MSUTL.MAC
@compile/macro MSVER.MAC
@compile/macro MSUUO.MAC
!
! 
!
@GOTO LNK
!
!	Here to "Freeze for Autopatch"
!
FREEZE::
@NOERROR
@DELETE *.CCL
! [smw 3/2/90]  remove reference to msdrel.ccl throughout
@TAKE SETSRC
!
!	If MSFRZ: is not defined, go do a forced build, but delete all the
!	RELs when we're finished.
!
@ERROR %
@INFO LOG MSFRZ:
@IF (ERROR) GOTO COMP
@DELETE MSFRZ:*.*
@UNDEL MSFRZ:MS11.*
@COPY MS.MAC,MSCNFG.MAC,MSDLVR.MAC,MSDSPL.MAC,MSFIL.MAC,-
@ MSMCMD.MAC,MSGUSR.MAC,MSHOST.MAC,MSLCL.MAC,MSNET.MAC,MSSEQ.MAC,-
@ MSTXT.MAC,MSUNV.MAC,MSUTL.MAC,MSUUO.MAC,MSVER.MAC MSFRZ:
@COPY MS.CTL,MS.CMD MSFRZ:
@CONN MSFRZ:
!
!
!
COMP::
!
!	Here to rebuild all modules
!
@Noerror
@Take Setsrc.cmd
@ERROR ?
!
!	Check version of Macro
!
@Get Sys:Macro
@I Ver
!
!	Compile all macro modules
!
@Set Trap File
@compile/macro/compile MSUNV.MAC
@compile/macro/compile MSDLVR.MAC
@compile/macro/compile MSDSPL.MAC
@compile/macro/compile MS.MAC
@compile/macro/compile MSFIL.MAC
@compile/macro/compile MSMCMD.MAC
@compile/macro/compile MSCNFG.MAC
@compile/macro/compile MSGUSR.MAC
@compile/macro/compile MSHOST.MAC
@compile/macro/compile MSLCL.MAC
@compile/macro/compile MSNET.MAC
@compile/macro/compile MSSEQ.MAC
@compile/macro/compile MSTXT.MAC
@compile/macro/compile MSUTL.MAC
@compile/macro/compile MSVER.MAC
@compile/macro/compile MSUUO.MAC
!
!
!
LNK::
!
!	Check Version of Link
!
@Get Sys:Link
@I ver
@Start
*tty:/log
*/syms:psect:.low./set:.high.:67000/set:datap:151000
*sys:glxlib/excl:glxini
*/logl:5
*mscnfg
*ms/save/g
