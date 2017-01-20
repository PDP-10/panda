;<AUTOPATCH.SOURCES>BOOT.CTL.2, 21-Mar-90 16:15:24, Edit by WEINER
;Remove DEFINE SYS:, let BATCH.CMD handle it.
! UPD ID= 8645, RIP:<7.MONITOR>BOOT.CTL.11,  16-Feb-88 15:26:56 by GSCOTT
;TCO 7.1229 - Remove NOERROR, clean up
! UPD ID= 1755, SNARK:<6.1.MONITOR>BOOT.CTL.10,  14-Apr-85 16:30:16 by LEACHE
;Remove upper bound on CSAVE for RP2MBT
;<6.MONITOR>BOOT.CTL.9, 20-Jun-84 17:07:30, EDIT BY LEACHE
;Check boot version number
;<6.MONITOR>BOOT.CTL.8, 15-Mar-84 13:50:38, Edit by PURRETTA
! UPD ID= 2418, SNARK:<6.MONITOR>BOOT.CTL.7,   4-May-83 10:05:13 by HAUDEL
;Delete the commands for making SMBOOT.EXE and SMMTBT.EXE
;KLIPA and KLINI Microcode had been deleted before this edit.
! UPD ID= 2007, SNARK:<6.MONITOR>BOOT.CTL.5,  16-Mar-83 05:47:24 by WACHS
;Add KLIPA, KLNI Microcode
;<6.MONITOR>BOOT.CTL.4, 17-Nov-82 21:06:44, Edit by PAETZOLD
;Take BATCH.CMD
! UPD ID= 1354, SNARK:<6.MONITOR>BOOT.CTL.3,  19-Oct-82 11:10:49 by HAUDEL
;Change KLPRE.MAC to SYSFLG.MAC
! UPD ID= 1966, SNARK:<5.MONITOR>BOOT.CTL.2,   8-May-81 10:40:10 by LEACHE
;Add some labels
! UPD ID= 1493, SNARK:<5.MONITOR>BOOT.CTL.3,  26-Jan-81 12:10:16 by LEACHE
;Allow for selective inclusion of RP20 microcode
;<4.MONITOR>BOOT.CTL.12,  6-Jul-79 10:04:25, EDIT BY ENGEL
;MOVE BOOT TO 40000
;<4.MONITOR>BOOT.CTL.11, 22-Jun-79 14:38:19, EDIT BY ENGEL
;MOVE BOOT FROM 3000 TO 20000
;<4.MONITOR>BOOT.CTL.10, 15-Jan-79 10:33:00, EDIT BY GILBERT
;TCO 4.2155: Delete KBBOOT and KBMTBT.
;<3A.MONITOR>BOOT.CTL.11, 26-Jul-78 10:50:39, Edit by ENGEL
;<3A.MONITOR>BOOT.CTL.10, 23-Jun-78 15:29:14, Edit by ENGEL
;<3A.MONITOR>BOOT.CTL.9, 23-Jun-78 15:23:48, Edit by ENGEL
;<3A.MONITOR>BOOT.CTL.8, 22-Jun-78 09:59:05, Edit by FORTMILLER
;<3A-NEW>BOOT.CTL.7, 25-May-78 13:33:15, Edit by FORTMILLER
;<3.SM10-RELEASE-3>BOOT.CTL.6,  9-Apr-78 16:19:44, Edit by MCLEAN
;<3.SM10-RELEASE-3>BOOT.CTL.5,  9-Apr-78 16:18:46, Edit by MCLEAN
;<3.SM10-RELEASE-3>BOOT.CTL.4,  9-Apr-78 16:16:33, Edit by MCLEAN


! NAME: BOOT.CTL
! DATE: 11-OCT-77
!
! This control file is provided for information purposes only.  The purpose  of
! the file  is  to  document  the procedures  used  to  build  the  distributed
! software.  It is unlikely that this control file will be able to be submitted
! without modification on customer systems.  Submit times may vary depending on
! system configuration and load.  The availability of sufficient disk space  is
! mandatory.
! FUNCTION:	THIS CONTROL FILE BUILDS BOOT FROM ITS BASIC
!		SOURCES.  THE FILES CREATED BY THIS JOB ARE:
!
!			  BOOT.EXE	;KL DISK BOOT
!			      .EXB
!			MTBOOT.EXE	;KL MAG TAPE BOOT
!			      .EXB
!		        RP2DBT.EXE	;KL DISK BOOT WITH RP20 MCODE
!			      .EXB
!		        RP2MBT.EXE	;KL MAG TAPE BOOT WITH RP20 MCODE
!			      .EXB
!
!	Note that the following renames must be performed before the
!	RP20 BOOT can be moved to the front end:
!
!	RENAME RP2DBT.EXB (to) BOOT.EXB
!	RENAME RP2MBT.EXB (to) MTBOOT.EXB
!
!	The following are the parameter files used for each BOOT:
!
!			  BOOT.EXE	;KL DISK BOOT
!					;FILES:
!					  SYSFLG.MAC
!			MTBOOT.EXE	;KL MAG TAPE BOOT
!					;FILES:
!					  SYSFLG.MAC+PMT.MAC
!		        RP2DBT.EXE	;KL DISK BOOT WITH RP20 MCODE
!					;FILES:
!					  SYSFLG.MAC+RP2.MAC
!		        RP2MBT.EXE	;KL MAG TAPE BOOT WITH RP20 MCODE
!					;FILES:
!					  SYSFLG.MAC+PMT.MAC+RP2.MAC
!
!
! Submit with the switch "/TAG:CREF" to obtain a CREF listing of the source
!
@DEF LPT: NUL:
@GOTO A
!
CREF:: @DEF LPT: DSK:
!
A::
!
@ENABLE
@NOERROR
@TAKE BATCH
@ERROR
!
! Take a checksummed directory
!
@VDIR SYS:MACRO.EXE,SYS:LINK.EXE,SYS:RSXFMT.EXE,SYS:CREF.EXE,-
@DSK:PMT.MAC,DSK:RP2.MAC,DSK:BOOT.MAC,DSK:DXMCA.RMC,DSK:DXMCE.RMC,-
@DSK:BOOT.EX%,DSK:MTBOOT.EX%,DSK:RP2DBT.EX%,DSK:RP2MBT.EX%,
@CHECK SEQ
@
!
! See what version of MACRO, LINK, RSXFMT and where they came from
!
@R MACRO
@I VER
@I FILE
@
@R LINK
@I VER
@I FILE
@
@R RSXFMT
@I VER
@I FILE
@
!
! Identify the location of our source files
! 
@SET TRAP FILE-OPENING


!
! First build standard KL BOOT
!
BOOT::
@COMPILE /CREF /COMP R:SYSFLG.MAC+R:BOOT.MAC BOOT
@LINK
*/NOSYM
*/SET:.LOW.:40000
*BOOT,DXMCA.RMC/G
@CSAVE BOOT 40000
@R RSXFMT
*CONVERT BOOT.EXE BOOT.EXB
@CREF
!
! Make standard KL MTBOOT next.
!
MTBOOT::
@COMPILE /COMP R:SYSFLG.MAC+R:PMT.MAC+R:BOOT MTBOOT
@LINK
*/NOSYM
*/SET:.LOW.:40000
*MTBOOT,DXMCA.RMC/G
@CSA MTBOOT 40000
@R RSXFMT
*CONVERT MTBOOT.EXE MTBOOT.EXB
!
! Now build KL BOOT with RP20 microcode
!
RP2DBT::
@COMPILE /COMP R:SYSFLG.MAC+R:RP2.MAC+R:BOOT.MAC RP2DBT
@LINK
*/NOSYM
*/SET:.LOW.:40000
*RP2DBT,DXMCA.RMC,DXMCE.RMC/G
@CSAVE RP2DBT 40000
@R RSXFMT
*CONVERT RP2DBT.EXE RP2DBT.EXB
!
! Make MTBOOT with RP20 Microcode
!
RP2MBT::
@COMPILE /COMP R:SYSFLG.MAC+R:PMT.MAC+R:RP2.MAC+R:BOOT RP2MBT
@LINK
*/NOSYM
*/SET:.LOW.:40000
*RP2MBT,DXMCA.RMC,DXMCE.RMC/G
@CSA RP2MBT 40000 
@R RSXFMT
*CONVERT RP2MBT.EXE RP2MBT.EXB


FIN::
!
! Take checksummed directory of files
!
@VDIRECT BOOT.EXB,MTBOOT.EXB,RP2DBT.EXB,RP2MBT.EXB,
@CHECK SEQ
@
!
! Identify the BOOT version #
!
@GET BOOT.EXE
@SET ENTRY-VECTOR 40000 3
@I VER
@

! End of BOOT.CTL
