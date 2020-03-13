! PANDA monitor generator
@ENABLE
@DEFINE MON: DSK:
@DEFINE R: DSK:
@COMPILE MON:SYSFLG.MAC+MON:PROLOG.MAC R:PROLOG
@COMPILE MON:GLOBS.MAC R:GLOBS		;Global symbols
@COMPILE MON:NIPAR.MAC R:NIPAR		;Universal for NISRV users
@COMPILE MON:ANAUNV.MAC R:ANAUNV	;Universal for ARPANET TCP/IP
@COMPILE MON:DOMSYM.MAC R:DOMSYM	;Universal for GTDOM
@COMPILE MON:PHYPAR.MAC R:PHYPAR	;Universal for PHYSIO and like modules
@COMPILE MON:SCAPAR.MAC R:SCAPAR	;Universal for SCA
@COMPILE MON:MSCPAR.MAC R:MSCPAR	;Universal for MSCP drivers and servers
@COMPILE MON:ENQPAR.MAC R:ENQPAR	;[7.1072] Universal for ENQ
@COMPILE MON:CLUPAR.MAC R:CLUPAR	;[7.1076] CLUDGR parameters
@COMPILE MON:CFSPAR.MAC R:CFSPAR	;[7.1190] CFS parameters
@COMPILE MON:D36PAR.MAC R:D36PAR	;DECnet symbols
@COMPILE MON:SCPAR.MAC R:SCPAR		;Session control symbols
@COMPILE MON:CTERMD.MAC R:CTERMD	;CTERM symbols
@COMPILE MON:TTYDEF.MAC R:TTYDEF	;Teletype service symbols
@COMPILE MON:SERCOD.MAC R:SERCOD	;Codes and fields for SYSERR facility
@COMPILE MON:SCHED.MAC R:SCHED		;Scheduler
@COMPILE MON:PAGEM.MAC R:PAGEM		;Page management/working set management
@COMPILE MON:PAGUTL.MAC R:PAGUTL	;Page management subroutines/utilities
@COMPILE MON:TAPE.MAC R:TAPE		;Label handler and record processor
@COMPILE MON:CDPSRV.MAC R:CDPSRV	;Card punch service
@COMPILE MON:CDRSRV.MAC+MON:CDKLDV.MAC R:CDRSRV	;Card reader service
@COMPILE MON:COMND.MAC R:COMND		;Command scanner JSYS
@COMPILE MON:CRYPT.MAC R:CRYPT		;Encryption routines
@COMPILE MON:DATIME.MAC R:DATIME	;Time and date routines
@COMPILE MON:DEVICE.MAC R:DEVICE	;Device table (DEVTAB) routines
@COMPILE MON:DIRECT.MAC R:DIRECT	;Disk directory management
@COMPILE MON:DISC.MAC R:DISC		;Disk file management
@COMPILE MON:ENQ.MAC R:ENQ		;ENQ and DEQ JSYS
@COMPILE MON:FESRV.MAC R:FESRV		;Device code for FE devices
@COMPILE MON:FILINI.MAC R:FILINI	;File system initialization
@COMPILE MON:FILMSC.MAC R:FILMSC	;DTBs, PTY support
@COMPILE MON:FILNFT.MAC R:FILNFT	;DECNET DAP support
@COMPILE MON:FORK.MAC R:FORK		;Fork controlling JSYS and functions
@COMPILE MON:FREE.MAC R:FREE		;Storage routines
@COMPILE MON:FUTILI.MAC R:FUTILI	;Miscellaneous routines for file system
@COMPILE MON:GETSAV.MAC R:GETSAV	;Get and save routines
@COMPILE MON:GTJFN.MAC R:GTJFN		;GTJFN and GNJFN JSYS
@COMPILE MON:IO.MAC R:IO		;Sequential IO routines and JSYSes
@COMPILE MON:IPCF.MAC R:IPCF		;Interprocess communications facility
@COMPILE MON:JSYSA.MAC R:JSYSA		;Non-file system JSYSes
@COMPILE MON:JSYSF.MAC R:JSYSF		;File system JSYSes
@COMPILE MON:JSYSM.MAC R:JSYSM		;[7.1200] JSYSes and support for MEXEC
@COMPILE MON:LDINIT.MAC R:LDINIT	;JSYS dispatch table, monitor version
@COMPILE MON:LINEPR.MAC+MON:LPFEDV.MAC R:LINEPR	;Line printer device routine
@COMPILE MON:LOGNAM.MAC R:LOGNAM	;Logical name JSYSes and support
@COMPILE MON:LOOKUP.MAC R:LOOKUP	;File name lookup utilities (for GTJFN)
@COMPILE MON:MFLIN.MAC R:MFLIN		;Floating point input routines
@COMPILE MON:MFLOUT.MAC R:MFLOUT	;Floating point outputl routines
@COMPILE MON:PLT.MAC R:PLT		;Plotter service
@COMPILE MON:POSTLD.MAC R:POSTLD	;Post-loading one-shot init
@COMPILE MON:PTP.MAC R:PTP		;Paper tape punch service
@COMPILE MON:PTR.MAC R:PTR		;Paper tape reader service
@COMPILE MON:SWPALC.MAC R:SWPALC	;Swapping space allocation
@COMPILE MON:SYSERR.MAC R:SYSERR	;SPEAR routines
@COMPILE MON:TIMER.MAC R:TIMER		;TIMER JSYS & schedular clock routines
@COMPILE MON:SCAMPI.MAC R:SCAMPI	;Systems communications architecture
@COMPILE MON:CFSSRV.MAC R:CFSSRV	;Common File System
@COMPILE MON:CFSUSR.MAC R:CFSUSR	;[7.1190] CFS user related stuff
@COMPILE MON:PHYKLP.MAC R:PHYKLP	;Device dependent code for KLIPA port
@COMPILE MON:SCSJSY.MAC R:SCSJSY	;The SCS% JSYS
@COMPILE MON:PHYMSC.MAC R:PHYMSC	;MSCP driver
@COMPILE MON:PHYMVR.MAC R:PHYMVR	;MSCP Server
@COMPILE MON:APRSRV.MAC R:APRSRV	;Processor-dependent paging
@COMPILE MON:DIAG.MAC R:DIAG		;The DIAG JSYS
@COMPILE MON:DSKALC.MAC R:DSKALC	;Device independent disk code
@COMPILE MON:PHYH2.MAC R:PHYH2		;Channel dependent code for RH20
@COMPILE MON:PHYM2.MAC R:PHYM2		;Device dependent code for TM02/TU45
@COMPILE MON:PHYM78.MAC R:PHYM78	;Device dependent code for TM78/TU78
@COMPILE MON:PHYP2.MAC R:PHYP2		;Device dependent code for DX20B/RP20
@COMPILE MON:PHYP4.MAC R:PHYP4		;Device dependent code for RP04 DISKS
@COMPILE MON:PHYX2.MAC R:PHYX2		;Device dependent code for DX20A/TU70S
@COMPILE MON:PHYSIO.MAC R:PHYSIO	;Device independent physical IO
@COMPILE MON:MAGTAP.MAC R:MAGTAP	;MTA routines
@COMPILE MON:MEXEC.MAC R:MEXEC		;Swappable monitor routines
@COMPILE MON:MSTR.MAC R:MSTR		;Mountable structure monitor call
@COMPILE MON:DTESRV.MAC R:DTESRV	;DTE support. RSX20F interface
@COMPILE MON:IPIPIP.MAC R:IPIPIP	;Arpanet internet protocols
@COMPILE MON:IPCIDV.MAC R:IPCIDV	;Internet CI Driver
@COMPILE MON:IPNIDV.MAC R:IPNIDV	;Internet Ethernet Driver
@COMPILE MON:IPFREE.MAC R:IPFREE	;Internet free storage routines
@COMPILE MON:TCPTCP.MAC R:TCPTCP	;Arpanet transmission control
@COMPILE MON:TCPCRC.MAC R:TCPCRC	;Cyclic redundancy check routines
@COMPILE MON:TCPBBN.MAC R:TCPBBN	;BBN TCP JSYS service routines
@COMPILE MON:TCPJFN.MAC R:TCPJFN	;DEC JSYS interface for BBN TCP
@COMPILE MON:MNETDV.MAC R:MNETDV	;Multinet software for ARPANET TCP/IP
@COMPILE MON:IMPANX.MAC R:IMPANX	;IMP driver for AN20
@COMPILE MON:IMPDV.MAC R:IMPDV		;Arpanet IMP Communication Protocols
@COMPILE MON:GTDOM.MAC R:GTDOM		;Domain name system
@COMPILE MON:TTYSRV.MAC R:TTYSRV	;Teletype service routines
@COMPILE MON:NRTSRV.MAC R:NRTSRV	;NRT service routines
@COMPILE MON:RSXSRV.MAC R:RSXSRV	;Teletype service routines
@COMPILE MON:TVTSRV.MAC R:TVTSRV	;Internet terminal service
@COMPILE MON:CIDLL.MAC R:CIDLL		;CI data link layer
@COMPILE MON:CTHSRV.MAC R:CTHSRV	;CTERM terminal support
@COMPILE MON:D36COM.MAC R:D36COM	;Common routines for DECnet
@COMPILE MON:DNADLL.MAC R:DNADLL	;Common data link layer interface
@COMPILE MON:JNTMAN.MAC R:JNTMAN	;TOPS20 specific network management 
@COMPILE MON:LLINKS.MAC R:LLINKS	;DECnet NSP (ECL) layer
@COMPILE MON:LLMOP.MAC R:LLMOP		;DECnet low level MOP support
@COMPILE MON:TOPS.MAC+MON:NISRV.MAC+MON:PHYKNI.MAC R:NISRV ;KLNI device driver
@COMPILE MON:NIUSR.MAC R:NIUSR		;NI% JSYS
@COMPILE MON:NTMAN.MAC R:NTMAN		;Network management
@COMPILE MON:ROUTER.MAC R:ROUTER	;DECnet router layer
@COMPILE MON:SCJSYS.MAC R:SCJSYS	;DECnet JSYSes
@COMPILE MON:SCLINK.MAC R:SCLINK	;DECnet session control layer
@COMPILE MON:LATSRV.MAC R:LATSRV	;LAT host server
@COMPILE MON:CLUDGR.MAC R:CLUDGR	;[7.1076] CLUDGR SYSAP
@COMPILE MON:CLUFRK.MAC R:CLUFRK	;[7.1076] CLUDGR's fork
@COMPILE MON:ENQSRV.MAC R:ENQSRV	;[7.1072] Cluster-wide ENQ/DEQ protocol
@COMPILE MON:DOB.MAC R:DOB		;[7.1081] DOB JSYS and code
@COMPILE MON:PIPE.MAC R:PIPE		;Data pipes
@COMPILE MON:KLHSRV.MAC R:KLHSRV	;KN10 routines
					;Monitor name string and version
@COMPILE MON:NAMMON.MAC+MON:VEDIT.MAC+MON:VERSIO.MAC R:VERSIO
					;Storage
@COMPILE MON:PARMON.MAC+MON:PARNEW.MAC+MON:PARAMS.MAC+MON:STG.MAC R:STG
@COMPILE MON:F2KDDT.MAC+MON:DDT.MAC KDDT
@COMPILE MON:F2MDDT.MAC+MON:DDT.MAC MDDT
@COMPILE MON:F2XDDT.MAC+MON:DDT.MAC XDDT
@LINK
*/NOINITIAL, /SET:.LOW.:700000 /SET:DDTSYM:701000 /SYMSEG:PSECT:DDTSYM -
*/UPTO:737777 /PATCHSIZE:#2000 /HASHSIZE:10000 XDDT/SAVE = XDDT/NOLOCALS, -
*/LOCALS SYS:MONSYM, SYS:MACREL, SYS:JOBDAT, /PVBLOCK:PSECT:DDTCOD -
*/PVDATA:NAME:DDT% /PVDATA:START:DDTXPT /PVDATA:VERSION:%%DDT, /GO
@GET XDDT.EXE
@START
@SAVE XDDT.EXE 700 777
@R LINK
*@LNKNEW.CCL
*TTY:/LOG/LOGL:5
*MON/SAVE,/HASHSIZE:12007, -
*/FRECOR:0, -
*/LOCALS, -
*R:MONSYM.REL/NOLOCALS, -
*R:LDINIT, -
*R:VERSIO,R:STG, -
*R:KDDT, -
*R:MDDT, -
*R:TTYSRV.REL/S,R:NRTSRV.REL/S,R:RSXSRV.REL/S,R:CIDLL.REL/S, - 
*R:CTHSRV.REL/S,R:D36COM.REL/S,R:DNADLL.REL/S,R:JNTMAN.REL/S, -
*R:LLINKS.REL/S,R:LLMOP.REL/S,R:NISRV.REL/S,R:NIUSR.REL/S,R:NTMAN.REL/S, -
*R:ROUTER.REL/S,R:SCJSYS.REL/S,R:SCLINK.REL/S,R:LATSRV.REL/S, -
*R:SCAMPI.REL/S,R:SCSJSY.REL/S,R:PHYKLP.REL/S,R:PHYMSC.REL/S, -
*R:CFSSRV.REL/S,R:CFSUSR.REL/S,R:APRSRV.REL/S,R:SCHED.REL/S,R:PAGEM.REL/S, -
*R:PAGUTL.REL/S,R:PHYMVR.REL/S,R:FORK.REL/S,R:MEXEC.REL/S, -
*R:GETSAV.REL/S,R:SYSERR.REL/S,R:COMND.REL/S,R:DEVICE.REL/S, -
*R:DIRECT.REL/S,R:ENQ.REL/S,R:FREE.REL/S,R:FUTILI.REL/S,R:GTJFN.REL/S, -
*R:IO.REL/S,R:IPCF.REL/S,R:JSYSA.REL/S,R:JSYSF.REL/S,R:JSYSM.REL/S, -
*R:LOGNAM.REL/S,R:LOOKUP.REL/S,R:MSTR.REL/S,R:SWPALC.REL/S,R:DISC.REL/S, -
*R:FILINI.REL/S,R:FILMSC.REL/S,R:MFLIN.REL/S,R:MFLOUT.REL/S,R:DATIME.REL/S, -
*R:PHYSIO.REL/S,R:DIAG.REL/S,R:DSKALC.REL/S,R:PHYH2.REL/S,R:PHYP4.REL/S, -
*R:PHYP2.REL/S,R:PHYM78/S,R:FESRV.REL/S,R:MAGTAP.REL/S, -
*R:TAPE.REL/S,R:TIMER.REL/S,R:PHYM2.REL/S,R:PHYX2.REL/S,R:DTESRV.REL/S, -
*R:LINEPR.REL/S,R:CDPSRV.REL/S,R:PLT.REL/S,R:PTP.REL/S,R:PTR.REL/S, -
*R:CDRSRV.REL/S,R:NTMAN.REL/S,R:FILNFT.REL/S, -
*R:CLUDGR.REL/S,R:CLUFRK.REL/S,R:ENQSRV.REL/S,R:DOB.REL/S, -
*R:IMPANX/S,R:IMPDV/S,R:NISRV/S,R:NIUSR/S,R:IPNIDV/S,R:IPCIDV/S, -
*R:MNETDV/S,R:GTDOM/S,R:IPFREE/S,R:IPIPIP/S,R:TCPCRC/S,R:TCPTCP/S,R:TCPBBN/S,
*R:TCPJFN/S,R:TVTSRV/S, -
*R:PIPE/S,R:KLHSRV/S, -
*R:CRYPT.REL/S,R:POSTLD.REL/S, -
*/NOLOCALS, -
*/SYSLIB, -
*/COUNTER, -
*/GO
@EXPUNGE
@GET MON
@START 142
*06M
=BUGHLT<HLTADR12B
=BUGCHK<CHKADR11B
G
@DELETE MON.EXE
!
! This step is necessary because POSTLD writes a slightly bogus EXE
!file.  BOOT will think that section 1 page +1 (a non-ex page) is a
!page of zeros which should overwrite what was there before.  Typically,
!this stomps a page of the symbol table.  Everything after that page is
!lost, causing all sorts of grief to applications software which sniff
!at monitor symbols.  While we're at it, we'll display some configuration
!parameters which can be edited here instead of in source code.
@GET MONITR
@START 140
*10R
!system debugging level
*DBUGSW[ 1
!EDDT retention
*EDDTF[ 1
!ms before logout after carrier off detach
*COFTIM[
!Not logged-in logout hangup policy
*HNGU0F[
!Logged-in logout hangup policy
*HNGU1F[
!Detach hangup policy
*HNGU2F[
!Interval after password failure to reset count
*PFINVL[
!How many password failures before logging
*PFLOGC[
!How many failures before all attempts fail
*PFAILC[
!How many failures before user is kicked off
*PFLGOC[
!Standard disk quota
*STNDMX[
!Standard subdirectory quota
*STNDSD[
!Default maximum packet size
*MAXPKT[
*8R
!Standard file retention count
*STNDBS[
!Standard directory protection
*STNDDP[
!Standard file protection
*STNDFP[
*
@SAVE
   