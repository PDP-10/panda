	PROGRAM IMAGE

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

!	Version 7	IMAGE.FOR

!	Basic IMAGE I/O test.

	DOUBLE PRECISION D,DD

!	Data to be written out.

	I=1234; X=456.789; D=123456789.0123

!	OPEN with MODE= and ACCESS= specified.

	OPEN(22,MODE='IMAGE',ACCESS='SEQOUT')
300	WRITE(22) I,X,D
	CLOSE(22)
	OPEN(22,MODE='IMAGE',ACCESS='SEQIN')
	READ(22) II,XX,DD
	IF (I.NE.II) TYPE 310,I,II
	IF (X.NE.XX) TYPE 320,X,XX
	IF (D.NE.DD) TYPE 330,D,DD

310	FORMAT(' ?Error line 300.  IMAGE I/O.',/
	1	'  I='I' II='I)
320	FORMAT(' ?Error line 300.  IMAGE I/O.',/
	1	'  X='F' XX='F)
330	FORMAT(' ?Error line 300.  IMAGE I/O.',/
	1	'  D='D' DD='D)
	CLOSE(22)

	STOP
	END