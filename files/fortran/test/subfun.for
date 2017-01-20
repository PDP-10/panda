	PROGRAM SUBFUN

!COPYRIGHT (c) DIGITAL EQUIPMENT CORPORATION 1981, 1987
!ALL RIGHTS RESERVED.
!
!THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY BE USED AND COPIED
!ONLY  IN  ACCORDANCE  WITH  THE  TERMS  OF  SUCH LICENSE AND WITH THE
!INCLUSION OF THE ABOVE COPYRIGHT NOTICE.  THIS SOFTWARE OR ANY  OTHER
!COPIES THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE AVAILABLE TO ANY
!OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF THE  SOFTWARE  IS  HEREBY
!TRANSFERRED.
!
!THE INFORMATION IN THIS SOFTWARE IS SUBJECT TO CHANGE WITHOUT  NOTICE
!AND  SHOULD  NOT  BE  CONSTRUED  AS A COMMITMENT BY DIGITAL EQUIPMENT
!CORPORATION.
!
!DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR RELIABILITY  OF  ITS
!SOFTWARE ON EQUIPMENT WHICH IS NOT SUPPLIED BY DIGITAL.

!	Version 7	SUBFUN.FOR	March 81

!	Basic test of Subroutines/Functions.

!	Modified 11/6/81 by RVM.  Add IMPLICIT DOUBLE PRECISION stmt to SUB1.


	IMPLICIT DOUBLE PRECISION (D)
	FUNC2(IVAR)=(IVAR+10)/5 + 1

!	Call subroutine FUNC1.
!	The returned value should be 12.

	Q=0
100	CALL SUB1(Q)
	IF (Q.NE.12) TYPE 110,Q
110	FORMAT(' ?Error Call 100.  Q = 'F', should = 12.')

!	Call a function.  The returned value should be 2* the
!	passed value.

	Q=-1.1
200	Q=FUNC1(Q)
	IF (Q.LT.-2.2000005 .OR. Q.GT.-2.1000005) TYPE 210,Q
210	FORMAT(' ?Error Call 200. Q='F', should =-2.2')

!	Call a subroutine which is actually an ENTRY point in
!	another subroutine.

	DD=0; XX=0
300	CALL SUB2(0,DD,XX)
	IF (DD .NE. 3.5) TYPE 310,DD
	IF (XX .NE. 1) TYPE 320,XX
310	FORMAT(' ?Error Call 300.  DD='D', should = 3.5D0')
320	FORMAT(' ?Error Call 300.  XX='F', should = 1.')

!	Reference a statement function

	M=4
400	X=FUNC2(M+6)
	IF (X .NE. 5) TYPE 410,X
410	FORMAT(' ?Error line 400.  X='F', should = 5')

	STOP
	END


	SUBROUTINE SUB1(PASSED)

!	Simple subroutine.  Assigns a new value of 12 to the
!	"PASSED" variable.  Uses routine FUNC1 and has ENTRY
!	point SUB2.

	IMPLICIT DOUBLE PRECISION (D)

	FIVE=5
	PASSED=FUNC1(FIVE+1)
	RETURN

!	The entry point SUB2

	ENTRY SUB2(P1,D1,X3)

!	D1 and X3 are reassigned according to the value P1
!	passed by the calling routine.

	CALL SUB3(P1,X3)
	D1=X3+2.5
	RETURN
	END


	FUNCTION FUNC1(XNUM)

!	Simple function which returns 2* the passed number

	VAL=XNUM*2
	FUNC1=VAL
	RETURN
	END


	SUBROUTINE SUB3(X1,X2)

!	Simple subroutine which reassigns the second arguement
!	to the increment of the first + 1.

	X2=X1+1
	RETURN
	END
