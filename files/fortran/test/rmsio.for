	PROGRAM RMSIO

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

!	Basic RMS I/O test.

	DOUBLE PRECISION D,DD

!---	Data to be written out.

	I=1234; X=456.789; D=123456789.0123

!---	SEQUENTIAL ASCII I/O--SEQUENTIAL ORGANIZATION,FIXED RECORDTYPE

	OPEN(30,MODE='ASCII',ACCESS='SEQUENTIAL',RECORD SIZE=40,
	1	ORGANIZATION='SEQUENTIAL',RECORDTYPE='FIXED')
100	WRITE(30,105) D
	WRITE(30,106) I
	WRITE(30,107) X
	CLOSE(30)

	OPEN(30,MODE='ASCII',ACCESS='SEQUENTIAL',RECORD SIZE=40,
	1	ORGANIZATION='SEQUENTIAL',RECORDTYPE='FIXED')
	READ(30,105) DD
	READ(30,106) II
	READ(30,107) XX		!Read back in
105	FORMAT(D)
106	FORMAT(I)
107	FORMAT(F)

	IF (I.NE.II) TYPE 110,I,II	!Check results
	IF (X.NE.XX) TYPE 120,X,XX
	IF (D.NE.DD) TYPE 130,D,DD

110	FORMAT(' ?Error line 100.  SEQUENTIAL I/O.',/
	1	'  I='I' II='I)
120	FORMAT(' ?Error line 100.  SEQUENTIAL I/O.',/
	1	'  X='F' XX='F)
130	FORMAT(' ?Error line 100.  SEQUENTIAL I/O.',/
	1	'  D='D' DD='D)
	CLOSE(30)

!---	SEQUENTIAL ASCII I/O--SEQUENTIAL ORGANIZATION,VARIABLE RECORDTYPE

	OPEN(32,MODE='ASCII',ACCESS='SEQINOUT',
	1	ORGANIZATION='SEQUENTIAL',RECORDTYPE='VARIABLE')
200	WRITE(32,205) D
	WRITE(32,206) I
	WRITE(32,207) X
	CLOSE(32)

	OPEN(32,MODE='ASCII',ACCESS='SEQINOUT',
	1	ORGANIZATION='SEQUENTIAL',RECORDTYPE='VARIABLE')
	READ(32,205) DD
	READ(32,206) II
	READ(32,207) XX		!Read back in
205	FORMAT(D)
206	FORMAT(I)
207	FORMAT(F)

	IF (I.NE.II) TYPE 210,I,II	!Check results
	IF (X.NE.XX) TYPE 220,X,XX
	IF (D.NE.DD) TYPE 230,D,DD

210	FORMAT(' ?Error line 200.  SEQUENTIAL I/O.',/
	1	'  I='I' II='I)
220	FORMAT(' ?Error line 200.  SEQUENTIAL I/O.',/
	1	'  X='F' XX='F)
230	FORMAT(' ?Error line 200.  SEQUENTIAL I/O.',/
	1	'  D='D' DD='D)
	CLOSE(32)


!---	RANDOM ASCII I/O--RELATIVE ORGANIZATION,FIXED RECORDTYPE

	OPEN(33,MODE='ASCII',ACCESS='RANDOM',RECORD SIZE=40,
	1	ORGANIZATION='RELATIVE',RECORDTYPE='FIXED')
300	WRITE(33'3,305) D
	WRITE(33'1,306) I
	WRITE(33'2,307) X
	CLOSE(33)

	OPEN(33,MODE='ASCII',ACCESS='RANDOM',RECORD SIZE=40,
	1	ORGANIZATION='RELATIVE',RECORDTYPE='FIXED')
	READ(33'2,307) XX		!Read back in
	READ(33'3,305) DD
	READ(33'1,306) II
305	FORMAT(D)
306	FORMAT(I)
307	FORMAT(F)

	IF (I.NE.II) TYPE 310,I,II	!Check results
	IF (X.NE.XX) TYPE 320,X,XX
	IF (D.NE.DD) TYPE 330,D,DD

310	FORMAT(' ?Error line 300.  RANDOM I/O.',/
	1	'  I='I' II='I)
320	FORMAT(' ?Error line 300.  RANDOM I/O.',/
	1	'  X='F' XX='F)
330	FORMAT(' ?Error line 300.  RANDOM I/O.',/
	1	'  D='D' DD='D)
	CLOSE(33)

!---	RANDOM ASCII I/O--RELATIVE ORGANIZATION,VARIABLE RECORDTYPE

	OPEN(34,MODE='ASCII',ACCESS='RANDOM',RECORD SIZE=40,
	1	ORGANIZATION='RELATIVE',RECORDTYPE='VARIABLE')
400	WRITE(34'3,405) D
	WRITE(34'1,406) I
	WRITE(34'2,407) X
	CLOSE(34)

	OPEN(34,MODE='ASCII',ACCESS='RANDOM',RECORD SIZE=40,
	1	ORGANIZATION='RELATIVE',RECORDTYPE='VARIABLE')
	READ(34'2,407) XX		!Read back in
	READ(34'3,405) DD
	READ(34'1,406) II
405	FORMAT(D)
406	FORMAT(I)
407	FORMAT(F)

	IF (I.NE.II) TYPE 410,I,II	!Check results
	IF (X.NE.XX) TYPE 420,X,XX
	IF (D.NE.DD) TYPE 430,D,DD

410	FORMAT(' ?Error line 400.  RANDOM I/O.',/
	1	'  I='I' II='I)
420	FORMAT(' ?Error line 400.  RANDOM I/O.',/
	1	'  X='F' XX='F)
430	FORMAT(' ?Error line 400.  RANDOM I/O.',/
	1	'  D='D' DD='D)
	CLOSE(34)

!---	Image Sequential I/O. SEQUENTIAL ORGANIZATION, FIXED RECORDTYPE

	OPEN(35,MODE='IMAGE',ACCESS='SEQOUT',RECL=50,
	1	ORGANIZATION='SEQUENTIAL',RECORDTYPE='FIXED')
500	WRITE(35) I,X,D
	CLOSE(35)

	OPEN(35,MODE='IMAGE',ACCESS='SEQIN',RECL=50,
	1	ORGANIZATION='SEQUENTIAL',RECORDTYPE='FIXED')
	READ(35) II,XX,DD
	IF (I.NE.II) TYPE 510,I,II
	IF (X.NE.XX) TYPE 520,X,XX
	IF (D.NE.DD) TYPE 530,D,DD

510	FORMAT(' ?Error line 500.  IMAGE I/O.',/
	1	'  I='I' II='I)
520	FORMAT(' ?Error line 500.  IMAGE I/O.',/
	1	'  X='F' XX='F)
530	FORMAT(' ?Error line 500.  IMAGE I/O.',/
	1	'  D='D' DD='D)
	CLOSE(35)

!---	Image Sequential I/O. SEQUENTIAL ORGANIZATION, VARIABLE RECORDTYPE

	OPEN(36,MODE='IMAGE',ACCESS='SEQOUT',
	1	ORGANIZATION='SEQUENTIAL',RECORDTYPE='VARIABLE')
600	WRITE(36) I,X,D
	CLOSE(36)

	OPEN(36,MODE='IMAGE',ACCESS='SEQIN',
	1	ORGANIZATION='SEQUENTIAL',RECORDTYPE='VARIABLE')
	READ(36) II,XX,DD
	IF (I.NE.II) TYPE 610,I,II
	IF (X.NE.XX) TYPE 620,X,XX
	IF (D.NE.DD) TYPE 630,D,DD

610	FORMAT(' ?Error line 600.  IMAGE I/O.',/
	1	'  I='I' II='I)
620	FORMAT(' ?Error line 600.  IMAGE I/O.',/
	1	'  X='F' XX='F)
630	FORMAT(' ?Error line 600.  IMAGE I/O.',/
	1	'  D='D' DD='D)
	CLOSE(36)

!---	Image Random I/O. RELATIVE ORGANIZATION, FIXED RECORDTYPE

	OPEN(37,MODE='IMAGE',ACCESS='RANDOM',RECORD SIZE=50,
	1	ORGANIZATION='RELATIVE',RECORDTYPE='FIXED')
700	WRITE(37'2) I
	WRITE(37'1) X
	WRITE(37'3) D
	CLOSE(37)

	OPEN(37,MODE='IMAGE',ACCESS='RANDOM',RECORD SIZE=50,
	1	ORGANIZATION='RELATIVE',RECORDTYPE='FIXED')
	READ(37'3) DD			!Read back in
	READ(37'2) II
	READ(37'1) XX

	IF (I.NE.II) TYPE 710,I,II	!Check results
	IF (X.NE.XX) TYPE 720,X,XX
	IF (D.NE.DD) TYPE 730,D,DD

710	FORMAT(' ?Error line 700.  Image RANDOM I/O.',/
	1	'  I='I' II='I)
720	FORMAT(' ?Error line 700.  Image RANDOM I/O.',/
	1	'  X='F' XX='F)
730	FORMAT(' ?Error line 700.  Image RANDOM I/O.',/
	1	'  D='D' DD='D)
	CLOSE(37)

!---	Image Random I/O. RELATIVE ORGANIZATION, VARIABLE RECORDTYPE

	OPEN(38,MODE='IMAGE',ACCESS='RANDOM',RECORD SIZE=50,
	1	ORGANIZATION='RELATIVE',RECORDTYPE='VARIABLE')
800	WRITE(38'2) I
	WRITE(38'1) X
	WRITE(38'3) D
	CLOSE(38)

	OPEN(38,MODE='IMAGE',ACCESS='RANDOM',RECORD SIZE=50,
	1	ORGANIZATION='RELATIVE',RECORDTYPE='VARIABLE')
	READ(38'3) DD			!Read back in
	READ(38'2) II
	READ(38'1) XX

	IF (I.NE.II) TYPE 810,I,II	!Check results
	IF (X.NE.XX) TYPE 820,X,XX
	IF (D.NE.DD) TYPE 830,D,DD

810	FORMAT(' ?Error line 800.  Image RANDOM I/O.',/
	1	'  I='I' II='I)
820	FORMAT(' ?Error line 800.  Image RANDOM I/O.',/
	1	'  X='F' XX='F)
830	FORMAT(' ?Error line 800.  Image RANDOM I/O.',/
	1	'  D='D' DD='D)
	CLOSE(38)

	STOP
	END