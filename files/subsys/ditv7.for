C	DIT interface support file for FORTRAN-10/20 Version 7
C
C THIS SOFTWARE IS FURNISHED UNDER A LICENSE AND MAY  BE  USED
C OR COPIED ONLY IN ACCORDANCE WITH THE TERMS OF SUCH LICENSE.
C
C COPYRIGHT  (C)  DIGITAL  EQUIPMENT  CORPORATION 1983, 1986.
C ALL RIGHTS RESERVED.
C
C	Facility: DIT
C	
C	Edit History:
C	
C	new_version (1, 0)
C	
C	EDIT (%O'1', '18-Oct-82', 'Charlotte L. Richardson')
C	%( Change version and revision standards everywhere.  )%
C
C	EDIT (%O'2', '13-Oct-82', 'Charlotte L. Richardson')
C	%( Split DITF36.INT into DITV6.FOR and DITV7.FOR.  )%
C
C	EDIT (%O'50', '6-Jan-83', 'Charlotte L. Richardson')
C	%( Update copyright notices.  DITV7.FOR )%
C
C	EDIT (%O'61', '9-Mar-83', 'Charlotte L. Richardson')
C	%( Declare version 1.  All modules. )%
C
C	new_version (2, 0)
C
C	EDIT (%O'73', '18-May-84', 'Sandy Clemens')
C	%( Add the following files to the V2 area.
C	    FILES: DITC36.INT, DITV7.FOR )%
C
C	new_version (2, 1)
C	Edit (%O'112', '1-Jun-86', 'Sandy Clemens')
C	  %( Add sources for version 2.1.  Update copyright notices. )%
C
C	End of revision history
	
	INTEGER syserr
	PARAMETER (syserr = 61210636)
C	Internal or system error
	INTEGER toomny
	PARAMETER (toomny = 61210644)
C	Attempt to open too many files or links
	INTEGER invarg
	PARAMETER (invarg = 61210652)
C	Invalid argument
	INTEGER netfal
	PARAMETER (netfal = 61210660)
C	Network operation failed
	INTEGER chksum
	PARAMETER (chksum = 61210668)
C	Network checksum error
	INTEGER unstyp
	PARAMETER (unstyp = 61210674)
C	Unsupported file type
	INTEGER filiu
	PARAMETER (filiu = 61210684)
C	File activity precludes operation
	INTEGER nofile
	PARAMETER (nofile = 61210692)
C	File not found
	INTEGER diteof
	PARAMETER (diteof = 61210696)
C	End of file
	INTEGER ovrrun
	PARAMETER (ovrrun = 61210704)
C	Data overrun
	INTEGER nomore
	PARAMETER (nomore = 61210715)
C	No more files
	INTEGER conevt
	PARAMETER (conevt = 61211435)
C	Connect event
	INTEGER arjevt
	PARAMETER (arjevt = 61211443)
C	Abort/reject event
	INTEGER intevt
	PARAMETER (intevt = 61211451)
C	Interrupt data event
	INTEGER datevt
	PARAMETER (datevt = 61211459)
C	Data event
	INTEGER dscevt
	PARAMETER (dscevt = 61211467)
C	Disconnect event
	INTEGER abrtrj
	PARAMETER (abrtrj = 61211836)
C	Abort/reject
	INTEGER intrcv
	PARAMETER (intrcv = 61211840)
C	Interrupt
	INTEGER notenf
	PARAMETER (notenf = 61211850)
C	Not enough data available
	INTEGER nodata
	PARAMETER (nodata = 61211858)
C	No data available
	INTEGER notavl
	PARAMETER (notavl = 61211866)
C	Information not available
	INTEGER infour
	PARAMETER (infour = 61211876)
C	Information out of range
	INTEGER tundef
	PARAMETER (tundef = 0)
C	Undefined data type
	INTEGER tascii
	PARAMETER (tascii = 1)
C	ASCII data type
	INTEGER timage
	PARAMETER (timage = 2)
C	Image data type
	INTEGER mread
	PARAMETER (mread = 1)
C	Open mode to read
	INTEGER mwrite
	PARAMETER (mwrite = 2)
C	Open mode to write
	INTEGER mappnd
	PARAMETER (mappnd = 3)
C	Open mode to append
	INTEGER fundef
	PARAMETER (fundef = 0)
C	Record format undefined
	INTEGER ffixed
	PARAMETER (ffixed = 1)
C	Record format fixed
	INTEGER fvar
	PARAMETER (fvar = 2)
C	Record format variable
	INTEGER fvfc
	PARAMETER (fvfc = 3)
C	Record format VFC
	INTEGER fstm
	PARAMETER (fstm = 4)
C	Record format ASCII stream
	INTEGER aunspc
	PARAMETER (aunspc = 0)
C	Record attributes unspecified
	INTEGER aenvlp
	PARAMETER (aenvlp = 1)
C	Record attributes implied <LF><CR> envelope
	INTEGER aprint
	PARAMETER (aprint = 2)
C	Record attributes VMS printer carriage control
	INTEGER aftn
	PARAMETER (aftn = 3)
C	Record attributes Fortran carriage control
	INTEGER amcy11
	PARAMETER (amcy11 = 4)
C	Record attributes MACY11
	INTEGER onthng
	PARAMETER (onthng = 0)
C	Close option: do nothing
	INTEGER osbmit
	PARAMETER (osbmit = 1)
C	Close option: submit for batch processing
	INTEGER oprint
	PARAMETER (oprint = 2)
C	Close option: submit for remote printing
	INTEGER odlete
	PARAMETER (odlete = 4)
C	Close option: delete
	INTEGER osbdel
	PARAMETER (osbdel = 5)
C	Close option: submit and delete
	INTEGER oprtdl
	PARAMETER (oprtdl = 6)
C	Close option: print and delete
	INTEGER waitly
	PARAMETER (waitly = 1)
C	Wait for link
	INTEGER waitln
	PARAMETER (waitln = 0)
C	Do not wait for link
	INTEGER lascii
	PARAMETER (lascii = 0)
C	ASCII link type (for NFACC)
	INTEGER lbin
	PARAMETER (lbin = 1)
C	Binary link type (for NFACC)
	INTEGER l8bit
	PARAMETER (l8bit = 2)
C	8-bit link type (for NFACC)
	INTEGER msgmsg
	PARAMETER (msgmsg = 1)
C	Message mode transfer
	INTEGER msgstm
	PARAMETER (msgstm = 0)
C	Stream mode transfer
	INTEGER inode
	PARAMETER (inode = 1)
C	Remote node name
	INTEGER iobj
	PARAMETER (iobj = 2)
C	Remote object type
	INTEGER idescf
	PARAMETER (idescf = 3)
C	Remote object descriptor format
	INTEGER idesc
	PARAMETER (idesc = 4)
C	Remote object descriptor
	INTEGER iuser
	PARAMETER (iuser = 5)
C	Remote process userid
	INTEGER ipass
	PARAMETER (ipass = 6)
C	Remote process password
	INTEGER iacct
	PARAMETER (iacct = 7)
C	Remote process account
	INTEGER iopt
	PARAMETER (iopt = 8)
C	Remote process optional data
	INTEGER iseg
	PARAMETER (iseg = 9)
C	Maximum segment size for the link
	INTEGER iabtcd
	PARAMETER (iabtcd = 10)
C	Abort code
	INTEGER fireup
	PARAMETER (fireup = 0)
C	Fire up VAX passive task
	INTEGER nfreup
	PARAMETER (nfreup = 1)
C	Do not fire up VAX passive task
