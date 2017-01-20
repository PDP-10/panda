! TOPS-20 Command file to set up cross-compiling for a TOPS-20 target system.
! There are two things that need to be redefined:
!	C:  To specify the search path for include files and library rels.
!	CSYS: ditto for <sys/> includes.
!	KCC: To identify the C compiler binary to use.  This is normally a
!		version of XCC that calls SYS:CCX with the right switches.
define C:	udsk:<kccdist.kcc-6.t20>,udsk:<kccdist.kcc-6.include>,kcc-lib:
! Nothing for now, CINCS: is fine.
! define CSYS:
define KCC:	sys:ccx.exe
take
