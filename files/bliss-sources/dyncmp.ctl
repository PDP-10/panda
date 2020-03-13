! DYNCMP.CTL
! Build the fakdyn software
!
!	COPYRIGHT (C) DIGITAL EQUIPMENT CORPORATION 1984, 1986.
!	ALL RIGHTS RESERVED.
!
!	THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED  AND
!	COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE AND WITH
!	THE INCLUSION OF THE ABOVE COPYRIGHT NOTICE.   THIS  SOFTWARE  OR
!	ANY  OTHER  COPIES  THEREOF MAY NOT BE PROVIDED OR OTHERWISE MADE
!	AVAILABLE TO ANY OTHER PERSON.  NO TITLE TO AND OWNERSHIP OF  THE
!	SOFTWARE IS HEREBY TRANSFERRED.
!
!	THE INFORMATION IN THIS SOFTWARE IS  SUBJECT  TO  CHANGE  WITHOUT
!	NOTICE  AND  SHOULD  NOT  BE CONSTRUED AS A COMMITMENT BY DIGITAL
!	EQUIPMENT CORPORATION.
!
!	DIGITAL ASSUMES NO RESPONSIBILITY FOR THE USE OR  RELIABILITY  OF
!	ITS SOFTWARE ON EQUIPMENT THAT IS NOT SUPPLIED BY DIGITAL.
!
! Submit connected to build directory
!    @SUBMIT DYNCMP/UNIQUE:NO/RESTART:YES/TIME:0:10:0
!
! Compile...
!
@NOERROR
@MACRO
!
! fakdyn software
*,DDBSYM/C=DDBSYM
*,DYNSYM/C=DYNSYM
*FAKDYN,FAKDYN/C=FAKDYN
*DYNBOO,DYNBOO/C=DYNBOO
*ZERBOO,ZERBOO/C=ZERBOO
=^Z
!
@CREF
*DDBSYM=DDBSYM
*DYNSYM=DYNSYM
*FAKDYN=FAKDYN
*DYNBOO=DYNBOO
*ZERBOO=ZERBOO
=^Z
!
! [End of DYNCMP.CTL]
      