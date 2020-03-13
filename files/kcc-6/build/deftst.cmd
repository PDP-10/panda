! TOPS-20 Command file to set up testing of TOPS-20 target system.
! There are three things that need to be redefined:
!	C:  To specify the search path for include files and library rels.
!	CSYS: To specify the search path for include sys/ files.
!	KCC: To identify the TOPS-20 C compiler binary to use.  
define C:	unix:<kccdist.kcc-6.t20>, unix:<kccdist.kcc-6.include>
define CSYS:	! Nothing for now, default of CINCS: is fine.
define KCC:	unix:<kccdist.kcc-6.t20>tcc.exe
   