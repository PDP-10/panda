!			Build the MM mailsystem
!			 Mark Crispin 2-Feb-06
!
!  This control file builds the MM mailsystem.  It should be possible to
! submit this control file and run the resulting EXE files without
! modification on any site.  Sites with additional or modified terminal
! type may wish to install a custom version of BLANKT.MAC for their
! environment on the <MM.LOCAL> directory prior to submitting this
! control file.
!
!  Required directories:
!	<MM> for the sources
!	<MM.LOCAL> for locally-modified sources
!	<MM.BINARIES> for the resulting binaries
!
!  This control file explicitly does NOT install the MM mailsystem; all
! the resulting binaries are left on <MM.BINARIES>
!
! Clean up
@CONNECT <MM.BINARIES>
@DELETE *.*
@EXPUNGE
!
! Define local search path
@DEFINE DSK: DSK:,<MM.LOCAL>,<MM>
!
! Log the environment this job ran under
@VDIRECTORY <MM>,<MM.LOCAL>,
@CHECKSUM SEQUENTIALLY
@
@GET SYS:MACRO
@INFORMATION VERSION
@GET SYS:LINK
@INFORMATION VERSION
!
! Universals
!
! SNDDEF -- Definitions for the sendsystem
@COMPILE /NOBINARY SNDDEF
!
!**********************************************************************
!		Libraries
!**********************************************************************
! ARMAIL -- Replacement for DEC's ARMAIL module
! BLANKT -- site-dependent terminal blanking codes
! HSTNAM -- host name lookup and domain processing
! RELAY -- relay host name lookup and domain processing
! SNDMSG -- terminal sending routines
! WAKEUP -- MMAILR wakeup module for mail composers
@COMPILE ARMAIL,BLANKT,HSTNAM,RELAY,SNDMSG,WAKEUP
!
!**********************************************************************
!		Mailsystem
!**********************************************************************
! MM -- mail composition/retrieval subsystem
@COMPILE FSCOPY,MMHELP,MMUUO
@LOAD %"NOINITIAL" MM
@GET MM
@DEPOSIT $GTMOK -1		!DNS timeouts OK
@SAVE MM
!
! GRIPE -- tool for sending bug reports, etc.
@LOAD %"NOINITIAL" GRIPE
!
! MSTAT - tool for looking at queued messages
@LOAD %"NOINITIAL" MSTAT
!
! MAILST - system server for MSTAT requests
@LOAD %"NOINITIAL" MAILST
!
! MMAILR -- mail delivery process
@LOAD %"NOINITIAL" MMAILR
@GET MMAILR
@DEPOSIT $GTMOK -1		!DNS timeouts OK
@SAVE MMAILR
!
! MMAILBOX -- mailbox lookup tool
@LOAD %"NOINITIAL" MMLBX
@RESET		!work around LINK bug
@RENAME MMLBX.EXE MMAILBOX.EXE
@GET MMAILBOX
@DEPOSIT $GTMOK -1		!DNS timeouts OK
@SAVE MMAILBOX
!
! MAISER -- SMTP protocol server
@LOAD %"NOINITIAL" MAISER
@GET MAISER
! Anti-spam settings
@DEPOSIT $ASRES 0		! require client IP address to have PTR record
@DEPOSIT $ASRVH 0		! validate name in HELO
@DEPOSIT $ASRCP 0		! allow RCPT address validation
@DEPOSIT $ASVFY 1		! disable VRFY
@DEPOSIT $ASEXP 1		! disable EXPN
@DEPOSIT $ASGRP 5000.		! number of ms of delay before greeting
@DEPOSIT $ASHLO 1		! reject obvious bogons in HELO/EHLO
@DEPOSIT $ASCBI 1		! clear input buffer CRLF ending response
!
@SAVE MAISER
!
! SMTJFN -- Internet SMTP listener
@LOAD %"NOINITIAL" SMTJFN
!
! SMTDCN -- DECnet SMTP listener
@LOAD %"NOINITIAL" SMTDCN
!
! VMAIL - DECnet MAIL-11 (VAX/VMS) listener/server
@LOAD %"NOINITIAL" VMAIL
!
! CAFARD - TTY line mail transfer program
@COMPILE CAFPRO,CAFDTR
@LOAD %"NOINITIAL" CAFARD
!
! MAPSER - IMAP II mail access protocol server
@COMPILE MAPSER
@NOERROR	!Don't die on a model A CPU
@LOAD %"NOINITIAL" MAPSER
@ERROR		!No EXE file will be made if built on model A CPU
!
! IMAPSV - Internet IMAP II listener
@LOAD %"NOINITIAL" IMAPSV
!
!**********************************************************************
!		Sendsystem
!**********************************************************************
! SEND -- Send composition process
@LOAD %"NOINITIAL" SEND
!
! SNDSRV -- Send delivery process
@LOAD %"NOINITIAL" SNDSRV
!
! REPLY -- Reply to latest send
@LOAD %"NOINITIAL" REPLY
!
! WHAT -- Report previous sends
@LOAD %"NOINITIAL" WHAT
!
!**********************************************************************
!		Auxillary tools
!**********************************************************************
! HSTTST -- host name registry lookup tool
@LOAD %"NOINITIAL" HSTTST
!
! QDMAIL -- mail queue perusal tool
@LOAD %"NOINITIAL" QDMAIL
!
! SNDSTAT -- Get sending statistics from SNDSRV
@LOAD %"NOINITIAL" SNDSTA
!
@NOERROR	!In case KCC or EMACS not installed
!
! MMSTAT -- Statistics from log file
@CC MMSTAT.C
!
! MLIST - Mailing list support tool
@CC MLIST.C
!
! MMAIL -- Support routines for fancy MM/EMACS interface
! MM-MAIL -- Auxillary EMACS routines
@CONNECT <MM>
@EMACS
*GLASS
*XSet Terminal TypeGLASS
*XFind FileMMAIL.EMACS
*XCompile
*XFind FileMM-MAIL.EMACS
*XCompile
*
@RENAME *.%EJ <MM.BINARIES>
!
@ERROR
@CONNECT <MM.BINARIES>
@EXPUNGE
!
! [End of BUILD-MM.CTL]
