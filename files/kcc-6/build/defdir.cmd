! Initial logical name definitions to map standard names into the actual
! site-dependent locations of the source directories.
define cbld:	kccdsk:<kccdist.kcc-6.build>	! Build stuff
define ckcc:	kccdsk:<kccdist.kcc-6.kcc>	! KCC compiler source
define cinc:	kccdsk:<kccdist.kcc-6.include>	! Include files
define cincs:	kccdsk:<kccdist.kcc-6.include.sys>! <sys/> include subdirectory
define clib:	kccdsk:<kccdist.kcc-6.lib>	! Library admin stuff
define cinet:	kccdsk:<kccdist.kcc-6.lib.inet>	! Network routines
define cgen:	kccdsk:<kccdist.kcc-6.lib.gen>	! General utilities
define cmath:	kccdsk:<kccdist.kcc-6.lib.math>	! Math rtns
define cstdio:	kccdsk:<kccdist.kcc-6.lib.stdio>	! STDIO rtns
define cuser:	kccdsk:<kccdist.kcc-6.lib.user>	! User libraries (termcap etc)
define cusys:	kccdsk:<kccdist.kcc-6.lib.usys>	! USYS rtns
define ctest:	kccdsk:<kccdist.kcc-6.lib.test>	! Library Test programs
!
! Search paths for include files and binaries used in cross-compiling on T20.
						! TOPS-20
define ct20:	kccdsk:<kccdist.kcc-6.t20>, kccdsk:<kccdist.kcc-6.include>
define c10x:	nul:				! TENEX
define cits:	nul:				! ITS
						! TOPS-10
define ct10:	kccdsk:<kccdist.kcc-6.t10>, kccdsk:<kccdist.kcc-6.include>
						! WAITS
define cwts:	kccdsk:<kccdist.kcc-6.wts>, kccdsk:<kccdist.kcc-6.include>
define ccsi:	nul:				! CSI
take
