@ENABLE
@COMPILE FTPDEF.MAC                                     ! Definitions
@COMPILE FTP.MAC			                  ! Main programs
@COMPILE FTPLUD.MAC,FTPPRO.MAC,FTPUTL.MAC,FTPDIR.MAC    ! Common routines
@COMPILE TCPFTP.MAC,TCPDAT.MAC,TCPXFR.MAC               ! TCP routines
@LOAD FTP.REL
@RUN FTP.EXE
