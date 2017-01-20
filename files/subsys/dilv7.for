C	DIL interface support file for FORTRAN-10/20 Version 7
C
C THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED
C OR COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE.
C
C COPYRIGHT  (C)  DIGITAL  EQUIPMENT  CORPORATION 1983, 1986.
C ALL RIGHTS RESERVED.
C
C	Facility: DIL
C	
C	Edit History:
C	
C	new_version (1, 0)
C	
C	EDIT (%O'16', '12-Oct-82', 'David Dyer-Bennet')
C	%(  Split DILF36.INT into DILV6.FOR and DILV7.FOR.
C	    Related to DIX edit %o'14'.
C	    FILES: DILV6.FOR (was DILF36.INT), DILV7.FOR (NEW). )%
C	
C Edit (%O'21', '20-Oct-82', 'David Dyer-Bennet')
C %(  Concoct a viable dil-wide VAX build procedure and clean up NET 
C     routine names.
C     Put correct net routine names in DILV7
C )%
C Edit (%O'24', '25-Oct-82', 'David Dyer-Bennet')
C %(  Fix line length problem in DILV6, DILV7.
C     Files: DILV6.FOR, DILV7.FOR
C )%
C Edit (%O'46', '19-Jan-83', 'David Dyer-Bennet')
C %(  Update copyright notice, mark end of edit histories.
C )%
C Edit (%O'73', '10-Mar-83', 'Charlotte L. Richardson')
C %( Declare version 1.  All modules.
C )%
C 
C new_version (2, 0)
C 
C Edit (%O'75', '12-Apr-84', 'Sandy Clemens')
C  %( Put all Version 2 DIL development files under edit control.  Some
C     of the files listed below have major code edits, or are new
C     modules.  Others have relatively minor changes, such as cleaning
C     up a comment.
C     FILES:  COMPDL.CTL, DIL.RNH, DIL2VAX.CTL, DILBLD.10-MIC,
C     DILHST.BLI, DILINT.BLI, DILOLB.VAX-COM, DILV6.FOR, DILV7.FOR,
C     INTERFILS.CTL, MAKDIL.CTL, MASTER-DIL.CMD, POS20.BLI, POSGEN.BLI,
C     DLCM10.10-CTL, DLMK10.10-CTL
C  )%
C
C Edit (%O'134', '8-Oct-84', 'Sandy Clemens')
C   %( Add new format of COPYRIGHT notice.  FILES:  ALL )%
C
C new_version (2, 1)
C
C Edit (%O'141', '1-Jun-86', 'Sandy Clemens')
C   %( Add DIL sources to DL21: directory. )%
C 
C ! **EDIT**
	INTEGER XDESCR, XCVST, XCVFB, XCVFP, XCVDN, XCVPD, XCGEN
	INTEGER XCFBDN, XCDNFB, XCPDDN, XCDNPD, XCPDFB, XCFBPD
        INTEGER NFGND, NFOPA, NFOPB, NFOP8, NFOPP, NFACC, NFRCV, NFSND
	INTEGER NFCLS
        INTEGER ROPEN, RREAD, RWRITE, RCLOSE, RDEL, RSUB, RPRINT
	INTEGER STSWRN, STSSUC, STSERR, STSINF, STSSEV, SYS36, SYSVAX
	INTEGER NORMAL
	PARAMETER (STSWRN = 0)
	PARAMETER (STSSUC = 1)
	PARAMETER (STSERR = 2)
	PARAMETER (STSINF = 3)
	PARAMETER (STSSEV = 4)
	PARAMETER (SYS36 = 1)
	PARAMETER (SYSVAX = 2)
	PARAMETER (normal = 1)
C	Success
