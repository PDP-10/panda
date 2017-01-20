	PROGRAM RANDOM

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

!	Version 7	RANDOM.FOR	March 81

!	Basic RANDOM I/O test.

	DOUBLE PRECISION D,DD

!---	Data to be written out.

	I=1234; X=456.789; D=123456789.0123

!---	Default OPEN statement (BINARY mode).

	OPEN(20,ACCESS='RANDOM',RECORD SIZE=50)
100	WRITE(20'2) I
	WRITE(20'1) X
	WRITE(20'3) D
	CLOSE(20)

	OPEN(20,ACCESS='RANDOM',RECORD SIZE=50)
	READ(20'3) DD			!Read back in
	READ(20'2) II
	READ(20'1) XX

	IF (I.NE.II) TYPE 110,I,II	!Check results
	IF (X.NE.XX) TYPE 120,X,XX
	IF (D.NE.DD) TYPE 130,D,DD

110	FORMAT(' ?Error line 100.  RANDOM I/O.',/
	1	'  I='I' II='I)
120	FORMAT(' ?Error line 100.  RANDOM I/O.',/
	1	'  X='F' XX='F)
130	FORMAT(' ?Error line 100.  RANDOM I/O.',/
	1	'  D='D' DD='D)
	CLOSE(20)

!---	RANDOM ASCII I/O

	OPEN(22,MODE='ASCII',ACCESS='RANDOM',RECORD SIZE=40)
200	WRITE(22'3,205) D
	WRITE(22'1,206) I
	WRITE(22'2,207) X
	CLOSE(22)

	OPEN(22,MODE='ASCII',ACCESS='RANDOM',RECORD SIZE=40)
	READ(22'2,207) XX		!Read back in
	READ(22'3,205) DD
	READ(22'1,206) II
205	FORMAT(D)
206	FORMAT(I)
207	FORMAT(F)

	IF (I.NE.II) TYPE 210,I,II	!Check results
	IF (X.NE.XX) TYPE 220,X,XX
	IF (D.NE.DD) TYPE 230,D,DD

210	FORMAT(' ?Error line 200.  RANDOM I/O.',/
	1	'  I='I' II='I)
220	FORMAT(' ?Error line 200.  RANDOM I/O.',/
	1	'  X='F' XX='F)
230	FORMAT(' ?Error line 200.  RANDOM I/O.',/
	1	'  D='D' DD='D)
	CLOSE(22)

!---	Image Random I/O.

	OPEN(23,MODE='IMAGE',ACCESS='RANDOM',RECORD SIZE=50)
300	WRITE(23'2) I
	WRITE(23'1) X
	WRITE(23'3) D
	CLOSE(23)

	OPEN(23,MODE='IMAGE',ACCESS='RANDOM',RECORD SIZE=50)
	READ(23'3) DD			!Read back in
	READ(23'2) II
	READ(23'1) XX

	IF (I.NE.II) TYPE 310,I,II	!Check results
	IF (X.NE.XX) TYPE 320,X,XX
	IF (D.NE.DD) TYPE 330,D,DD

310	FORMAT(' ?Error line 300.  Image RANDOM I/O.',/
	1	'  I='I' II='I)
320	FORMAT(' ?Error line 300.  Image RANDOM I/O.',/
	1	'  X='F' XX='F)
330	FORMAT(' ?Error line 300.  Image RANDOM I/O.',/
	1	'  D='D' DD='D)
	CLOSE(23)

	STOP
	END
