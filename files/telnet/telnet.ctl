!
! Name: TELNET.CTL
! Date: 24-Mar-85
!
!  This control file is provided for information purposes only.  The
! purpose of the file is to document the procedures used to build
! the distributed software.
!
!  Submit times may vary depending on system configuration and load.
! The availability of sufficient disk space is mandatory.
!
!  To get a CREF listing of the source file, submit this job with the
! switch "/TAG:CREF"
!
@DEFINE FOO: NUL:
@GOTO A
CREF::
@DEFINE FOO: DSK:
!
A::
!
@INFORMATION LOGICAL-NAMES ALL
!
@VDIRECTORY,
@CHECKSUM SEQ
@
!
@GET SYS:MACRO
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
@GET SYS:CREF
@INFORMATION VERSION
!
@COMPILE /COMPILE /CREF HSTNAM.MAC
@LOAD %"NOINITIAL" /CREF TELNET.MAC
!
@GET TELNET.EXE
@INFORMATION VERSION
!
@DIRECTORY TELNET.EXE,
@CHECKSUM SEQ
@
!
@DELETE TELNET.REL
!
@R CREF
*FOO:HSTNAM.LST=HSTNAM.CRF
*FOO:TELNET.LST=TELNET.CRF
!
![End of TELNET.CTL]
