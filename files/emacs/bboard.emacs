!~Filename~:! ! Library for reading BBoard Files. !
BBOARD

!*
	B B O A R D   L I B R A R Y

	Author:		Leonard N. Zubkoff
	Revision:	10/24/83 00:27:45

	Copyright (C) 1982 - 1983, Leonard N. Zubkoff   All Rights Reserved


Library of additions to Babyl to make Twenex BBoard reading pleasant.  This
library uses and updates the list of BBoard reading requests in the file
Switch.ini on the user's home directory.  The standard BBoard program may be
used to add new BBoards to Switch.ini.  This file and the BBSITE library should
be included when Babyl is compiled with Ivory.  See the BBSITE library for
customization information.
!

!& Setup BBOARD Library:! !S Initializations for the BBOARD Library. !

   @:I*|
      QBBoard Babyl File"N @M(M.M # Babyl ^B) ' !* If BBoard active. !
      0[MM # Babyl Q		    !* Set to 0 temporarily. !
      F@M(M.M # Babyl Q) 	    !* Call Babyl Q from Babyl library. !
   | M.V MM # Babyl Q		    !* Install our own Babyl Q. !
   !* Our Babyl Q will do a ^B instead if user was reading a BBoard. !
   @:I*|
      FS Z"E			    !* If *Babyl* Empty... !
         0UBBoard Babyl File	    !* BBoard not Active. !
	 0UBBoard Last Written '  !* And no update pending. !
      QBBoard Babyl File"N	    !* If BBoard active. !
         :I*I command not usable within BBoard FS Err ' !* Give error. !
      0[MM # Babyl I		    !* Set to 0 temporarily. !
      F@M(M.M # Babyl I) 	    !* Call Babyl I from Babyl library. !
   | M.V MM # Babyl I		    !* Install our own Babyl I. !
   !* Our Babyl I will signal an error if user was reading a BBoard. !
   @:I*|
      QBBoard Babyl File"N	    !* If BBoard active. !
         1F<!Babyl-Command-Abort!   !* Simulate Babyl Abort Catcher. !
            0[MM # Babyl ^N	    !* Set to 0 temporarily. !
            FM(M.M # Babyl ^N)   !* Call Babyl ^N from Babyl library. !
         >[0 Q0"N		    !* If Error Occurred. !
            @FT
0.  0 FS Echo ActiveW	    !* Print thrown text, if any. !
            QBBoard Q on N at Last Notice"N
	       ZJ @M(M.M # Babyl ^B) ' !* Call # Babyl ^B and Return. !
	    :FI U0		    !* Q0: Next Character. !
	    Q0-"E FI '	    !* Ignore an additional ^N. !
	    Q0-N"E FI '	    !* Ignore an additional N. !
	    Q0-n"E FI '	    !* Ignore an additional n. !
	    Q0-"E ZJ '	    !* If ^B, move to end of message. !
	    Q0-Q"E ZJ '	    !* If Q, move to end of message. !
	    Q0-q"E ZJ ''	    !* If q, move to end of message. !
	  '			    !* Return. !
      0[MM # Babyl ^N		    !* Set to 0 temporarily. !
      F@M(M.M # Babyl ^N) 	    !* Call Babyl ^N from Babyl library. !
   | M.V MM # Babyl ^N		    !* Install our own Babyl ^N. !
   !* Our Babyl ^N will cause an N on the last message followed by
      a Q or ^B to act as though the last message had been read. !
   				    !* Return. !

!# Babyl ^B:! !C# Look for new BBoard Notices to read, or on to next BBoard.
With an argument of 1, does not delete old notices.  With an argument of 2,
queries about every BBoard whether or not it has new notices.  If BBoard Sans
Query is nonzero then BBoard are immediately read without querying. !

!* Looks in Switch.ini on the user's home directory and steps through the list
of BBoard names there querying the user about reading each BBoard with new
notices; normally, reading a BBoard will cause enough old notices to be deleted
until the file is shorter than BBoard Maximum Size characters, so that
Babylizing can proceed quickly.  The definition of the Babyl Q command is
redefined to come here if a BBoard is currently active so that the last read
date and time for the BBoard will be updated properly.  If the user is
currently at the end of the last message in the BBoard, then the last read date
and time will be updated from the last write date and time of the BBoard file.
Otherwise, the last read date and time will be set just prior to the current
notice, so that it will be re-read the next time the user enters the BBoard.
In the case where the user executes a N command from the last message and then
immediately executes a Q command, it will be as though the user had read the
entire final BBoard message.  When there are no more BBoards to read, the user
will be returned to the original Babyl file.  !

M(M.M& Declare Load-Time Defaults)
   BBoard Sans Query,
      * Do not query user if this is nonzero: 0
   BBoard Maximum Size,
      * Maximum Size of BBoard file before deleting old notices: 10000
   BBoard Data File,
      * Complete file name if not Switch.ini on Home Directory: 0
   BBoard Babyl File,
      0 or the name of the Babyl File when BBoard was invoked: 0
   Last BBoard Argument,
      Last true Argument to ^B: 0
   BBoard Last Written,
      Date and time BBoard Last Written: 0
   BBoard Last Read,
      Date and time BBoard Last Read: 0


   1F[Both Case		    !* Case insensitive searches. !
   M(M.M & Initialize BBoard)	    !* Initialize List of BBoards. !
   [0[1[2[3[4[5[6[7		    !* Save Q registers. !
   Q..OU6			    !* Save *Babyl* Buffer. !
   @:FN|M(M.M Select Buffer)*Babyl*| !* Be sure to return to *Babyl* buffer. !
   F[D File			    !* Save default filenames. !
   0 F[Mode Macro		    !* Inhibit Updating Mode Line. !
   M(M.M Select Buffer)*BBoards*  !* Select BBoard Date file buffer. !
   Q..OU7			    !* Save *BBoards* buffer. !
   FS Z"E			    !* If buffer empty. !
      0ULast BBoard Argument	    !* No Last BBoard Argument. !
      QBabyl Filenames UBBoard Babyl File !* Save name of Babyl file. !
      :I*C FS Echo Display	    !* Clear echo area. !
      0 FS Echo Active		    !* Display now. !
      FS H Sname FS D Sname	    !* Home directory. !
      ET Switch.ini		    !* List of BBoards file. !
      QBBoard Data FileF"N FS D File ' !* If alternate Data File, use it. !
      1:<ER @Y>"N		    !* Read in file. !
         :I*No BBoard Data File (Default: HomeDirectory:Switch.ini) found FS Err ''
   FF-1"E			    !* If one argument. !
      ULast BBoard Argument '   !* Then use it. !
   QBBoard Last WrittenU0	    !* Date and time BBoard Last Written. !
   Q0"N				    !* Nonzero if update request pending. !
      QMessage Number-QNumber of Babyl MessagesU4 !* Notice at End. !
      Q6U..O .(0U1 <%1WL .-Z;>)J Q7U..O !* Q1: Lines remaining in notice. !
      Q1-((FS Height)-(FS Echo Lines)-1)U5 !* Q5: number of lines not yet !
				    !* seen. If more than 0, keep notice. !
      Q4"E Q5:"G O Use Last Written Date '' !* If seen everything. !
      Q6U..O			    !* Back to *Babyl* buffer. !
      0 FS VBW 0 FS VZW	    !* Widen to entire buffer. !
      -:SRcvd-Date:W FKC	    !* Search back to Rcvd-Date header. !
      @F 	L		    !* Skip whitespace. !
      FS FD ConvertU0		    !* Setup new BBoard last read date. !
      Q5"G Q0-3U0 '		    !* Have not seen all of this notice. !
      Q7U..O			    !* Return to *BBoards* buffer. !
      ! Use Last Written Date!	    !* Use Last Written Date of file. !
      0 UBBoard Last Written	    !* Update no longer pending. !
      .,(:S 	W @F 	L :S 	
W @F 	L FKC.)K	    !* Delete old date and time. !
      0,Q0 FS FD Convert	    !* Insert new date and time. !
      L				    !* Prepare for next line of Switch.ini. !
      FS H Sname FS D Sname	    !* Home directory. !
      ET Switch.ini		    !* List of BBoards file. !
      QBBoard Data FileF"N FS D File ' !* If alternate Data File, use it. !
      @:EW HP EF		    !* Update new copy of file. !
      0 FS Modified '		    !* Buffer not modified. !
   QLast BBoard ArgumentU0	    !* Q0: Last BBoard Argument. !
   <.-Z;			    !* Loop until all lines examined. !
      0L 7 F~BBOARD "N O Next'   !* Line must start with BBOARD <sp>. !
      7C .,(:S 	W.-1)X1    !* Q1: Name of BBoard. !
      @F 	K		    !* Kill excess whitespace. !
      QBBoard Crl ListU3	    !* BBoard Names List. !
      0@FO31U2		    !* Lookup BBoard Name to find the File. !
      Q2"E .,(:S W.-1)X2	    !* If unknown, get File from Switch.ini. !
         @F 	K '		    !* Kill excess whitespace. !
      .U5 FS FD Convert U3 Q5J	    !* Q3: Date and time last read. !
      Q2 F[D File		    !* Save and set new default file names. !
      0U4			    !* Default last written date. !
      1:<1,ER			    !* Open BBoard file without setting date. !
         FS IF CDate U4 EC>	    !* Get date file last written. !
      F]D File			    !* Restore default file names. !
      Q4"E			    !* File non-existent, no new notices. !
         QBBoard Sans Query"E	    !* If not querying, don't print anything. !
	    @FT 1 		    !* Print BBoard name. !
            0 FS Echo Active '	    !* Display message. !
  	 O Next ''		    !* Go on to next BBoard. !
      F[B Bind Q4FS FD Convert 0J FS FD Convert U4 F]B Bind
				    !* Round off Last Write Date and Time. !
      QBBoard Sans Query"N Q0-2"N Q4-Q3:"G O Next' !* Don't Query. !
      "# @FT 1  0 FS Echo Active O Read BBoard ''' !* Read BBoard. !
      Q0-2"N Q4-Q3:"G		    !* If no new notices. !
         @FT 1 		    !* No new notices. !
         0 FS Echo Active	    !* Display message. !
  	 O Next ''		    !* Go on to next BBoard. !
      @:I*|FT Type Y, y, or Space to read this BBoard.
Type N, n, or Rubout to skip reading this BBoard.
Type Q or q to skip reading the remaining BBoards.| F[Help Macro
				    !* Setup help text. !
      <@FT 1? 		    !* Query user.  !
         FI:FC U5 @FT5	    !* Q5: uppercased response. !
	 Q5-Y"E 0;'		    !* Response: Y, yes. !
	 Q5-N"E 0;'		    !* Response: N, no. !
	 Q5- "E 0;'		    !* Response: sp, yes. !
	 Q5-"E 0;'		    !* Response: ^?, no. !
	 Q5-Q"E 0;'		    !* Response: Q, quit. !
	 @FG >			    !* Illegal response: Bell and re-query. !
      F]Help Macro		    !* Restore old help text. !
      Q5-N"E O Next '	    !* If user replied N, try next BBoard. !
      Q5-"E O Next '	    !* If user replied ^?, try next BBoard. !
      Q5-Q"E 0;'		    !* If user replied Q, quit. !
      ! Read BBoard!		    !* Now let's read the BBoard.  !
      Q3 UBBoard Last Read	    !* Date and time BBoard Last Read. !
      Q4 UBBoard Last Written	    !* Date and time BBoard Last Written. !
      FS X UnameU0		    !* User's name. !
      FS H SnameU1		    !* User's home directory. !
      M(M.M Select Buffer)*Babyl* !* Return to *Babyl* buffer. !
      F]Mode Macro		    !* Allow Updating Mode Line Again. !
      0[MM # Babyl I		    !* So that we can find real Babyl I. !
      0[MM # Babyl Q		    !* So that Babyl I can find real Babyl Q. !
      M.M & Flush Old BBoard Notices[Before Babylizing File Hook
      1[Babyl Keep TNX Received Date !* Cause Rcvd-Date: to be created. !
      1F<!BBoard ^B Abort! Q2,1@M(M.M # Babyl I)>"N !* If aborted. !
         @FT [Bad BBoard File: 2]  0 FS Echo Active 30: O Abort'
      !* Call to Babyl I command.  If it fails, skip this BBoard. !
      0 FS VBW 0 FS VZW 0J	    !* Widen to entire buffer. !
      <0U4 :S
;				    !* Search for start of message. !
         :SRcvd-Date:;		    !* Now find Rcvd-Date field. !
	 1U4 @F 	L	    !* Skip over whitespace. !
         FS FD ConvertU5	    !* Q5: Date and time of this message. !
         Q3-Q5:;>		    !* Exit if later date than last read. !
      QLast BBoard Argument-2"N   !* Exit if not really any new messages. !
         Q4"E @FT [No New Messages]  0 FS Echo Active O Abort ''
      M(M.M & Babyl Select Message) !* Select current notice. !
      :M(M.M & Calculate Message Number) !* Return to Calculate Number. !
      ! Abort!			    !* Here if BBoard file bad. !
      HK			    !* Empty *Babyl* buffer. !
      0 F[Mode Macro		    !* Inhibit Updating Mode Line. !
      M(M.M Select Buffer)*BBoards* !* Return to *BBoards* buffer. !
      QBBoard Last WrittenU0	    !* Q0: Date and Time Last Written. !
      O Use Last Written Date	    !* Now use that date and time. !
      ! Next! L>		    !* On to next BBoard. !
   HK				    !* Kill old dates now. !
   0 FS Modified		    !* Buffer not modified. !
   @FT Done.  0 FS Echo Active    !* Tell user we're done. !
   M(M.M Select Buffer)*Babyl*    !* Return to *Babyl* buffer. !
   F]Mode Macro		    !* Allow Updating Mode Line Again. !
   QBBoard Babyl FileU0	    !* Babyl file to return to. !
   0UBBoard Babyl File	    !* Indicate no longer such a file. !
   QBabyl Filenames-Q0"E  '	    !* If haven't switched, just return. !
   0[MM # Babyl I		    !* So that we can find real Babyl I. !
   Q0,@M(M.M # Babyl I) 	    !* Return to old file. !

!& Flush Old BBoard Notices:! !S Flushes from the buffer messages older than
the current value of BBoard Last Read until the buffer's size is no larger than
BBoard Maximum Size or all messages but one have been deleted.  The buffer
should be in Twenex mail file format. Does nothing if Last BBoard Argument is
nonzero.  Throw to BBoard ^B Abort if the mail file appears to be bad. !

   FS Z-25"L F;BBoard ^B Abort '  !* Throw if given a bad file. !
   QLast BBoard Argument"N  '   !* Do nothing if argument given. !
   [0[1[2[3[4			    !* Save Q Registers. !
   QBBoard Maximum SizeU0	    !* Shrink buffer to this size. !
   FS Z-Q0:"G  '		    !* Exit if small enough already. !
   QBBoard Last ReadU1	    !* Date and time BBoard last read. !
   0 FS VBW 0 FS VZW 0J	    !* Widen to entire buffer. !
   :<(Q0-(Z-.)); .U4		    !* Exit if shrunken enough. !
      FS FD ConvertU2		    !* Q1: Date and Time message received. !
      Q2"L F;BBoard ^B Abort '	    !* Throw if Date conversion fails. !
      Q1-Q2:;			    !* Exit if not yet seen. !
      :S,W \U3			    !* Q3: Length of Message. !
      L Q3C>"N F;BBoard ^B Abort ' !* Throw if an error occurred. !
   Z-.-25"L Q4J '		    !* Leave at least one message in file. !
   0L				    !* Back to beginning of line. !
   0,.K				    !* Kill to beginning of buffer. !
   				    !* Return. !

!# Babyl ^A:! !C# Add BBoard to Switch.ini.  With nonzero argument, Remove BBoard. 
If the name given is not a System BBoard, the user will be prompted for the
name of the Twenex Mail File to be read. !

   1F[Both Case		    !* Case insensitive searches. !
   M(M.M & Initialize BBoard)	    !* Initialize List of BBoards. !
   [0[1[2 0[3 0[4		    !* Save Q registers. !
   F[D File			    !* Save default filenames. !
   FF-1"E U0' "# 0U0'	    !* Q0: Argument. !
   QBBoard Crl List [Crl List   !* Complete over our list. !
   Q0"E 18,M(M.M & Read Command Name)Add BBoard: U1 '
				    !* Q1: BBoard Name to be removed. !
   "# 18,M(M.M & Read Command Name)Remove BBoard: U1 '
				    !* Q1: BBoard Name to be removed. !
   Q1"E '			    !* If over-rubout, return.  !
   QBBoard Crl ListU2		    !* Q2: List of System BBoards. !
   Q0"E @:FO21F"G U1		    !* If a System BBoard. !
         Q:2(Q1) U1 '		    !* Canonicalize name. !
      "# ET FOO.TXT		    !* Setup default filenames. !
         FS H Sname FS D S name   !* Setup home directory. !
	 5,0FBBoard File NameU4 '' !* Get file name from user. !
   @:FN|M(M.M Select Buffer)*Babyl*| !* Be sure to return to *Babyl* buffer. !
   0 F[Mode Macro		    !* Inhibit Updating Mode Line. !
   M(M.M Select Buffer)*BBoards*  !* Select BBoard Date file buffer. !
   FS Z"E			    !* If BBoard search not active. !
      1U3			    !* Q3: nonzero if read file in. !
      FS H Sname FS D Sname	    !* Home directory. !
      ET Switch.ini		    !* List of BBoards file. !
      QBBoard Data FileF"N FS D File ' !* If alternate Data File, use it. !
      1:<ER @Y> '		    !* Read in file. !
   .U2				    !* Save point. !
   Q0"E				    !* If adding a BBoard. !
      J .,(:L.):FBBBOARD 1 "E  !* And BBoard not on first line already. !
         ZJ			    !* Move to end of file. !
         -:S
BBOARD 1 "E		    !* Only add BBoard if not already there. !
            -:S
BBOARD 			    !* Search for last BBoard line. !
            2L			    !* Move to start of non-BBoard line. !
	    IBBOARD 1 	    !* Insert BBoard and BBoard name. !
            Q4"N		    !* If explicit file name. !
	       F[D File	    !* Save default filenames. !
	       Q4 FS D File	    !* Setup default file names. !
	       G(FS D File)	    !* Insert name into buffer. !
	       F]D File	    !* Restore default filenames. !
	       I  '		    !* And follow with a space. !
            0,FS Date FS FD Convert I
 '''				    !* Insert current date and time. !
   "#				    !* If removing a BBoard. !
      J .,(:L.):FBBBOARD 1 "L 0LK' !* Kill first line if necessary. !
      J <:S
BBOARD 1 ; 0LK> '		    !* Kill appropriate lines. !
   Q2J				    !* Restore point. !
   @:EW HP EF			    !* Update new copy of file. !
   Q3"N HK'			    !* Kill text if we added it. !
   0 FS Modified		    !* Buffer not modified. !
   M(M.M Select Buffer)*Babyl*    !* Return to *Babyl* buffer. !
   F]Mode Macro		    !* Allow updating of mode line again. !
   				    !* Return. !

!& Initialize BBoard:! !S Initialize List of BBoards. !

   QBBoard Crl List"N '	    !* Return if already initialized. !
   [0[1[2[3[4			    !* Save Q Registers. !
   F[B Bind			    !* Create a temporary buffer. !
   QBBoard Regular Naming ConventionU4 !* Q4: Regular naming convention. !
   Q4"N				    !* If there is a regular convention. !
      G4 J :S*"E :I* No * in BBoard Regular Naming Convention '
      0,.-1X2 .+1,ZX3 HK	    !* Q2: Prefix, Q3: Suffix. !
      1,111100000001.EZ4	    !* Directory of BBoard files. !
      J <.-Z; S2 .U0 S3 FKC   !* Find Prefix and Suffix. !
         Q0,.-1X1		    !* Q1: BBoard Name. !
         0L .U0 G1 I=		    !* Insert BBoard= part. !
	 .-Q0-1"G Q0+1,.-1FC '	    !* Clean up case. !
         L> '			    !* And iterate over all files. !
   GBBoard Names List		    !* Insert List of BBoards. !
   5 FS Q VectorU0		    !* Create a Q Vector for BBoard Names. !
   2U:0(0)			    !* Each entry is two words. !
   J <.-Z; .U1 :S="E :I*BBoard Specification must have = FS Err '
      Q1,.-1X2			    !* Q2: BBoard Name. !
      :X3			    !* Q3: BBoard File Specification. !
      @:FO02U4 Q4"L -Q4U4 Q0[..O Q4*5J 10,0I	!* Space for two elements. !
      Q2U:0(Q4) Q3U:0(Q4+1) ]..O ' L> !* Insert Name and File Spec. !
   Q0 UBBoard Crl List	    !* Put BBoard Vector in BBoard Crl List. !
   F]B Bind			    !* Return from the temporary buffer. !
   				    !* Return. !
    