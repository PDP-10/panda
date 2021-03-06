	PROGRAM EXTCK1

C COPYRIGHT (c) DIGITAL EQUIPMENT CORPORATION 1986, 1987
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

C Program writes a .mac file to determine if we're running with
C extended addressing or not.  This is done via a macro function
C returning true (have it) or false (don't have it).

	OPEN(20, FILE='F20EXT.MAC')

	IF (EXTCK2()) THEN
		WRITE(20,*) '	FTEXT==-1	' //
	1		';Machine has extended addressing'
	ELSE
		WRITE(20,*) '	FTEXT==0	' //
	1		';Machine does not have exteneded addressing'
	ENDIF

	CLOSE(20)

	END
    