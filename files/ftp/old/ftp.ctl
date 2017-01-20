!
! Name: FTP.CTL
! Date: 2-Jun-84
!
!This  control  file  is  provided  for  information purposes only. The
!purpose of the file is to document the procedures used  to  build  the
!distributed  software.  It  is unlikely that this control file will be
!able  to  be  submitted  without  modification  on  consumer  systems.
!Particular attention should be given to ersatz devices  and  structure
!names,  ppn's,  and  other  such  parameters.  Submit  times  may vary
!depending on system configuration and load.

!Function: This control file  builds  the  FTP  system  frm  its  basic
!sources.  The  files created by this job are: FTP.EXE, FTPSRT.EXE, and
!FTSCTT.EXE.
!
!submit  with  the  switch  "/TAG:CREF" to obtain a .CRF listing of the
!source files.
!
@DEF FOO: NUL:
@GOTO A
!
CREF:: @DEF FOO: DSK:
!
A::
@I LOG SYS:
@TAK BATCH.CMD
!
! TAKE A CHECKSUMMED DIRECTORY OF ALL THE INPUT FILES
!
@VDIRECT SYS:MACRO.EXE,SYS:LINK.EXE,SYS:CREF.EXE,
@CHECKSUM SEQ
@
@VDIRECT TCPFTP.MAC,FTP1.MAC,FTP2U.MAC,FTP2S.MAC,TCPSIM.MAC,FTP4.MAC,
@CHECKSUM SEQ
@
@VDIRECT SYS:MONSYM.UNV,SYS:MACSYM.UNV,SYS:MACREL.REL,SYS:PA1050.EXE,
@CHECKSUM SEQ
@
@
@RUN SYS:MACRO
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
@GET SYS:CREF
@INFORMATION VERSION
!
@NOERROR                                         
@LOAD/COMPILE/CREF TCPFTP.MAC+FTP1.MAC+FTP2U.MAC+TCPSIM.MAC+FTP4.MAC FTP
@SAVE FTP
@LOAD/COMPILE/CREF FTPSRT.MAC+FTP1.MAC+FTP2S.MAC+TCPSIM.MAC+FTP4.MAC FTPSRT
@SAVE FTPSRT
@LOAD/COMPILE/CREF FTSCTT.MAC FTSCTT
@SAVE FTSCTT
!
@R CREF
*FOO:FTP.LST=FTP.CRF
*FOO:FTPSRT.LST=FTPSRT.CRF
*FOO:FTSCTT.LST=FTSCTT.CRF
!
@INFORMATION VERSION
!
@VDIRECT FTP.EXE,FTPSRT.EXE,FTSCTT.EXE,
@CHECKSUM SEQ
@
!
@DELETE FTP.REL,FTPSRT.REL,FTSCTT.REL
