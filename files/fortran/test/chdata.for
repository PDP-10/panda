	PROGRAM CHDATA

C COPYRIGHT (c) DIGITAL EQUIPMENT CORPORATION 1983, 1987
C ALL RIGHTS RESERVED.
C 
C THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY BE USED AND COPIED
C ONLY  IN  ACCORDANCE  WITH  THE  TERMS  OF  SUCH LICENSE AND WITH THE
C INCLUSION OF THE ABOVE COPYRIGHT NOTICE.  THIS SOFTWARE OR ANY  OTHER
C COPIES THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE AVAILABLE TO ANY
C OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF THE  SOFTWARE  IS  HEREBY
C TRANSFERRED.
C 
C THE INFORMATION IN THIS SOFTWARE IS SUBJECT TO CHANGE WITHOUT  NOTICE
C AND  SHOULD  NOT  BE  CONSTRUED  AS A COMMITMENT BY DIGITAL EQUIPMENT
C CORPORATION.
C 
C DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR RELIABILITY  OF  ITS
C SOFTWARE ON EQUIPMENT WHICH IS NOT SUPPLIED BY DIGITAL.

C	Feb-82
C	CDM

C	Tests character data in DATA statement.

	CHARACTER CHAR1*2, CHAR2*6
	CHARACTER CHAR3(5)*1
	DIMENSION CHAR5(3),NUM2(0:3)
	CHARACTER CHAR4*5,CHAR5*5

	DATA CHAR1,CHAR2,NUM1/ 3*'ABCD'/
	DATA (CHAR3(I), I=1,5)/'B','O','S','C','O'/
	DATA CHAR4(3:5),(CHAR5(I)(I:5),NUM2(I),I=1,3)/'ABC',
	1 'ZZZZZ',1,'YYYY',2,'XXX',3/, (CHAR5(I)(1:I-1), I=2,3)
	2 /'A','BB'/
	DATA CHAR4(1:2)/'VV'/

C-100-	Repeat count, too long string, too short, and char const to
C	hollerith conversion test.

	IF (CHAR1.NE.'AB') TYPE 100, CHAR1
	IF (CHAR2.NE.'ABCD  ') TYPE 110, CHAR2
	IF (NUM1.NE.5HABCD ) TYPE 120,NUM1
100	FORMAT(' ?Error 100. CHAR1='A2', should = ''AB''')
110	FORMAT(' ?Error 110. CHAR2='A6', should = ''ABCD  ''')
120	FORMAT(' ?Error 120. NUM1='A5', should = ''ABCD ''')

C-200-	Imbedded Do loop test.

	IF (CHAR3(1) .NE. 'B') TYPE 200,1,CHAR3(1),'B'
	IF (CHAR3(2) .NE. 'O') TYPE 200,2,CHAR3(2),'O'
	IF (CHAR3(3) .NE. 'S') TYPE 200,3,CHAR3(3),'S'
	IF (CHAR3(4) .NE. 'C') TYPE 200,4,CHAR3(4),'C'
	IF (CHAR3(5) .NE. 'O') TYPE 200,5,CHAR3(5),'O'

200	FORMAT(' ?Error 200. CHAR3('I1')='A1', should = '''A1'''')

C-300-	Mix char & numeric, Implied DO, substring

300	IF (CHAR4 .NE. 'VVABC') TYPE 310, CHAR4
	IF (CHAR5(1) .NE. 'ZZZZZ') TYPE 320, 1,CHAR5(1),'ZZZZZ'
	IF (CHAR5(2) .NE. 'AYYYY') TYPE 320, 2,CHAR5(2),'AYYYY'
	IF (CHAR5(3) .NE. 'BBXXX') TYPE 320, 3,CHAR5(3),'BBXXX'
	IF (NUM2(1) .NE. 1) TYPE 330, 1,NUM2(1),1
	IF (NUM2(2) .NE. 2) TYPE 330, 2,NUM2(2),2
	IF (NUM2(3) .NE. 3) TYPE 330, 3,NUM2(3),3
310	FORMAT(' ?Error 310. CHAR4='A', should = ''VVABC''')
320	FORMAT(' ?Error 320. CHAR5('I1')='A5', should = '''A5'''')
330	FORMAT(' ?Error 330. NUM2('I1')='I2', should = 'I2)

	STOP 'Character data in DATA statement'
	END
    