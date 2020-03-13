	PROGRAM SUBSTR

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

C	Jan-82
C	CDM

C	Tests character data
C	Substring

	CHARACTER*2 CHAR1*7,CHAR2,CHAR3*10,CHAR4(3,3)*7
	CHARACTER CHAR5(5)*5,CHAR6

C-100-	Substring tests
C	In logical comparison

	CHAR1='Boscone'
	CHAR2='co'

	IF (CHAR1(4:5) .NE. CHAR2) TYPE 100, CHAR1(4:5),CHAR2
100	FORMAT(' ?Error 100. CHAR1(4:5)='A10', CHAR2='A2)

C-200-	In assignment

	CHAR3='ABCDEFGHIJ'
	CHAR3(5:8)=CHAR3(3:10)

	IF (CHAR3 .NE. 'ABCDCDEFIJ') TYPE 200,CHAR3
200	FORMAT(' ?Error 200. CHAR3(3:10)='A10', should = ',
	1 '''ABCDCDEFIJ''')

C-300-	Of array

	CHAR4(2,3)='NMOPQRSTUV'
	CHAR5(3)='WXYZABC'
C	'MOP' // 'XYZA'
	CHAR4(2,3)=CHAR4(2,3)(2:4) // CHAR5(3)(2:5)

	IF (CHAR4(2,3)(2:5) .NE. 'OPXY') TYPE 300,CHAR4(2,3)(2:5)
300	FORMAT(' ?Error 300. CHAR4(2,3)(2:5) ='A4', should = ',
	1 '''OPXY''')

C-400-	On left of assignment with array

	CHAR4(2,3)(2:4)='POW'

	IF (CHAR4(2,3) .NE. 'MPOWYZA') TYPE 400,CHAR4(2,3)
400	FORMAT(' ?Error 400. CHAR4(2,3)='A10', should = ''MPOWYZA''')

	STOP
	END
    