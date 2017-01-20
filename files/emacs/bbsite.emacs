!~Filename~:! ! Library of site-specific additions to the BBOARD Library. !
BBSITE

!*
	B B S I T E   L I B R A R Y

	Author:		Leonard N. Zubkoff
	Revision:	11/30/82 09:46:51


The variable BBoard Names List should contain a list of all the BBoards that
the BBoard Library is to know about as a list of lines of the form:
<BBoardName>=<BBoardFileSpecification>.  See the CMU-CS-C specification below
for a sample format for Tops-20 sites.  For Tenex sites, these strings should
have DSK: in place of PS:.  If the variable BBoard Regular Naming Convention is
nonzero, it should be a wild card file specification string (with exactly one
*) that will match a set of BBoard files.  BBoard will then automatically
install the names of BBoards of the form specified in that string without
specifying them explicitly in BBoard Names List.  For sites without a regular
file naming convention for BBoards similar to the above, one must explicitly
include every BBoard in BBoard Names List.
!

!& Setup BBSITE Library:! !S Initializations for the BBSITE Library.
Add any additional site-specific code to this function. !

M(M.M& Declare Load-Time Defaults)
   BBoard Crl List,
      If nonzero, it is the Q-Vector of BBoard Name, BBoard File pairs: 0
   BBoard Q on N at Last Notice,
      * If nonzero, N at Last Notice causes an automatic Q: 0
   BBoard Regular Naming Convention,
      0 or Single Wild Card File Specification to find BBoard files:
	|PS:<BBOARD>*.TXT|
   BBoard Names List,
      * List of BBoard Specifications <BBoardName>=<BBoardFileSpecification>:
|GENERAL=PS:<BBOARD>MAIL.TXT
SYSTEM=PS:<SYSTEM>MAIL.TXT
|


   				    !* Return. !
