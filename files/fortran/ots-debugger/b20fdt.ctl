!	JOB TO BUILD FORDDT (THE FORTRAN DEBUGGER) FOR THE DECSYSTEM-20
!	SUBMIT B20FDT.CTL/TIME:00:05:00/RESTART:YES



!COPYRIGHT (c) DIGITAL EQUIPMENT CORPORATION 1976, 1987
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

!	VERSION 11	B20FDT.CTL	February 1987


!This control file describes the procedures used to build the distributed
!software.   It  is  unlikely  that  this  control  file can be submitted
!without  modification  on  customer  systems.   Submit  times  may  vary
!depending  on  system  configuration  and  load.   The  availability  of
!sufficient disk space and core is mandatory.  This control file has  not
!been  extensively  tested on alternate configurations.  It has been used
!successfully  for  its  intended  purpose:   to  build  the  distributed
!software on our development systems.

! FUNCTION:	THIS CONTROL FILE BUILDS THE STANDARD FORTRAN DEBUGGER,
!		  FORDDT.  IT UTILIZES FIELD IMAGE SOFTWARE.

! INPUT:	THE FOLLOWING FILES ARE REQUIRED BY THIS JOB IN THE
!		  DISK AREAS INDICATED:

!	SYS:	MACRO	.EXE		USE MACRO 53B
!	SYS:	PA1050	.EXE

!	DSK:	[AREA UNDER WHICH B20FDT.CTL IS BEING RUN]
!		B20FDT	.CTL		THIS CONTROL FILE
!		B20FTN	.CMD		LOGICAL NAME DEFINITIONS
!		FORDDT	.MAC		INPUT FOR MACRO

! OUTPUT:	THE FOLLOWING FILES ARE GENERATED BY THIS CONTROL FILE
!		  AND WILL BE AVAILABLE ON THIS DISK AREA AT JOB
!		  TERMINATION:

!	DSK:	[AREA UNDER WHICH B20FDT.CTL IS BEING RUN]
!		B20FDT	.LOG		LOG FROM THIS JOB
!		FDDT	.MAC		DEFINES ASSEMBLY SWITCH
!		FORDDT	.REL		FORTRAN DEBUGGER FOR THE -20

START::
@CHKPNT START

! Generate FORDDT for the 20

@TYPE B20FTN.CMD
@TAKE B20FTN.CMD
@INFORMATION LOGICAL DSK:
@INFORMATION LOGICAL SYS:

! Show checksums ane versions for system software

@VDIRECTORY SYS:MACRO.EXE, SYS:PA1050.EXE,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

@GET SYS:MACRO
@INFORMATION VERSION

@GET SYS:PA1050
@INFORMATION VERSION

! Show checksums for input files

@VDIRECTORY B20FDT.CTL, B20FTN.CMD, FORDDT.MAC,
@CHECKSUM SEQUENTIAL
@SEPARATE
@

! Select features
@SET TRAP FILE
@COPY TTY: FDDT.MAC
@	TOPS20==-1	;TOPS-20
@^Z

! Build FORDDT

@RUN SYS:MACRO
*FORDDT=FDDT.MAC,FORDDT.MAC

! Show checksums of all output files
@SET NO TRAP FILE
@VDIRECTORY FDDT.MAC, FORDDT.REL,
@CHECKSUM SEQUENTIAL
@SEPARATE
@


%FIN::

!	[END OF B20FDT.CTL]
  