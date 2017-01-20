@TAKE CBLD:DEFBLD
@NOERROR
@!	Compile network routines
@KCC: -c -q -x=macro -Hc: -Hcinc: -hcsys: -hcincs: @cinet:inet.ccl
@!	Compile general utility routines
@KCC: -c -q -x=macro -Hc: -Hcinc: -hcsys: -hcincs: @cgen:gen.ccl
@!	Compile stdio routines
@KCC: -c -q -x=macro -Hc: -Hcinc: -hcsys: -hcincs: @cstdio:stdio.ccl
@!	Compile math routines
@KCC: -c -q -x=macro -Hc: -Hcinc: -hcsys: -hcincs: @cmath:math.ccl
@!	Compile un*x syscalls (1st half)
@KCC: -c -q -x=macro -Hc: -Hcinc: -hcsys: -hcincs: @cusys:usys1.ccl
@!	Compile un*x syscalls (2nd half)
@KCC: -c -q -x=macro -Hc: -Hcinc: -hcsys: -hcincs: @cusys:usys2.ccl
@!	Now build libraries.
@maklib
*libckx.lib=libckx.rel/index
*libc.lib=@clib:libc.ccl
*libc.lib=libc.lib/index
*libc.poi=libc.lib/points
*
