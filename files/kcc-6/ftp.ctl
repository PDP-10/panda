!
!                            F T P . C T L
!
!	Transfer KCC files from NIC.ddn.MIL, repeating on failure.
!
@ena
!	Start in the right place
@cd SRC:<KCCDIST.KCC-6>
@ftp
!
!	Set things up right and open connection
*set no conf upd
*open nic.ddn.mil
!
!	Now, get the files
*cwd KCCDIST:
*UPDATE kccdist:<kcc-6>*.*.0		<kccdist.kcc-6>*.*.*
*UPDATE kccdist:<kcc-6.build>*.*.0		<kccdist.kcc-6.build>*.*.*
*UPDATE kccdist:<kcc-6.include>*.*.0	<kccdist.kcc-6.include>*.*.*
*UPDATE kccdist:<kcc-6.include.sys>*.*.0	<kccdist.kcc-6.include.sys>*.*.*
! *UPDATE kccdist:<kcc-6.fail>*.*.0		<kccdist.kcc-6.fail>*.*.*
*UPDATE kccdist:<kcc-6.kcc>*.*.0		<kccdist.kcc-6.kcc>*.*.*
*UPDATE kccdist:<kcc-6.lib>*.*.0		<kccdist.kcc-6.lib>*.*.*
*UPDATE kccdist:<kcc-6.lib.gen>*.*.0	<kccdist.kcc-6.lib.gen>*.*.*
*UPDATE kccdist:<kcc-6.lib.stdio>*.*.0	<kccdist.kcc-6.lib.stdio>*.*.*
*UPDATE kccdist:<kcc-6.lib.math>*.*.0	<kccdist.kcc-6.lib.math>*.*.*
*UPDATE kccdist:<kcc-6.lib.user>*.*.0	<kccdist.kcc-6.lib.user>*.*.*
*UPDATE kccdist:<kcc-6.lib.usys>*.*.0	<kccdist.kcc-6.lib.usys>*.*.*
*UPDATE kccdist:<kcc-6.lib.test>*.*.0	<kccdist.kcc-6.lib.test>*.*.*
*UPDATE kccdist:<kcc-6.t20>*.*.0		<kccdist.kcc-6.t20>*.*.*
!
!	Now, we are done...
*exit
!
!	Did it work?
@if (noerror) @goto done
!
!	Nope, resubmit
@submit ftp /aft:+15 /time:30
!
!	All Done
done::
%fin::
@cd
