!~FILENAME~:! !Functions to help deal with long filenames.
Bugs/features to JPERSHING@BBNA.!

LONG-FILENAMES			    !* Requires the IVORY compressor.!

!& Setup LONG-FILENAMES Library:! !S Enable matching unless user hook exists.

We match on all filename reading unless LONG-FILENAMES Setup Hook
exists and is non-zero, in which case it is called instead.  Matching
is controlled by the non-zeroishness of the Matching Filename Mode
option variable.

Basically, matching works thuswise:  If you type the name of an
existing file, that is what you get.  Otherwise, what looks like the
"first component" of the filename you typed is taken as a string to
match against all filenames in the default directory.  (Or any
directory you specified in the filename.)  The filename CONTAINING
that string (anywhere within the filename) is the one used.  If
several names match, then you are put into a recursive ^R mode to
select the one you want, position the cursor and then leaving the ^R
mode (e.g. via ^Z^Z).

For more details, do MM Describe& Find Matching Filename.!

!*

This library was originally written by Gene Ciccarelli, then at BBN.  It is
currently maintained by John Pershing <JPERSHING at BBNA>, to whom bugs and
features should be forwarded.

7-Jul-80:  Rearranged defaultedness of Matching Filename Mode.

6-Jun-80 (126):  Moved the initialization of the VarMacro into the &Setup
    macro, just in case someone has M.Ved the variable prior to our being
    loaded.

25-Apr-80:  Added MM M1Generate from Gene Ciccarelli's TWENEXIA library.

22-Apr-80:  Since I appear to be the only user, the &Setup will now enable
    filename matching by default.  Also, created control-variable Matching
    Filename Mode and function MM Matching Filename Mode which toggles the
    mode like other such hacks.

8-Apr-80:  2-bit in arg means we are to read a name with possibly wildcard
    characters.  For the time being, this will inhibit matching; although, it
    seems that there should be something we can do (like insure that the
    selected *-matched set is non-empty).

4-Apr-80:  Changed & Matching Read Filename to assume an output (e.g. no
    matching invoked) file only if arg has the 1-bit set, since the TWENEX
    filename reader has started defining other bits in this arg.

27-Mar-80 (125):  Bound ^R Exit to Space when in the recursive -mode for
    selecting among multiple matches.

17-Mar-80:  Removed the & Set Mode Line function, as only very, very old
    EMACS's benefited from it (the current EMACS & Set Mode Line is
    essentially the same as our old one).  Also, & Read Matching Filename
    will now assume a new file if a write-only device is specified, instead of
    bitching.
!

 m(m.m& Declare Load-Time Defaults)
    Matching Filename Mode,
       * Non-zero enables filename matching: 1
    

 m.m& Read Filename m.vMM & Non-Matching Read Filenamew   !* Save for future!
							    !* ..reference.!

				    !* Install VarMacro for our option.!
 :@i*|!* Non-zero enables filename matching!
m(m.m& Set Matching Fn Mode)| u:..q(:fo..qMatching Filename Mode+2)

 qMatching Filename Modem(m.m& Set Matching Fn Mode)	!* Call VarMacro.!

 0fo..qLONG-FILENAMES Setup Hook f"N [0 m0w '  !* Call hook if there.!

 

!Matching Filename Mode:! !C Toggle or set matching mode.!

 m(m.m& Declare Load-Time Defaults)
    Matching Filename Mode,
       * Non-zero enables filename matching: 1
    

 ff&1"N uMatching Filename Mode '   !* If arg, smash setting of mode.!

 "# qMatching Filename Mode"E 1'"# 0'uMatching Filename Mode'   !* Else,!
								    !* toggle.!
 

!& Find Matching Filename:! !S Return filename matching STRARG.

If the variable strarg Filename Translation exists, its value is
    used as filename.
If STRARG is a legal filename, it is used exactly.
If the directory name part of the filename (if any) has a translation,
    i.e. there is dir Directory Translation, that is substituted,
    and we again try for a legal filename.
Failing, we look for a MATCHING filename from the filename (fn) part
    of STRARG trying the following techniques in order.  Each time,
    the partial directory chosen is filtered by & Flush For Find Match
    (q.v.).  The idea is that object files should be flushed, leaving
    only source files to be matched against:

    1. The partial directory from fn.*,  looking for just 1 match.
    2. On TWENEX we try fn*.* (i.e. completion of sorts), again for 1
       match.
    3. The whole directory is read in and flushed as above.  Next,
       MM Keep Linesfn is done on the whole directory.  This will
       allow teco search strings in the fn.

    If still leaves more than one filename, a recursive ^R is called
       to let user select which matching file is desired.  User can
       exit with Space or abort with ^G.

Prints running status of search for matching filename in the echo area.
VAL: Matching filename string, or 0 if abort.!

 :i*[0[1[2[3[4[5		    !* 0: STRARG, match string.!

 0fo..q0 Filename Translationu3  !* 3: 0 or xlation.!
 q3"n @ft(0 = 3) 0fsEchoActivew	!* Tell what happened.!
    q3'w			    !* Return the xlation for fn.!

 -1f[fnam syntax		    !* If only one compon, is 1st fn.!
 f[dfilew et0		    !* Set fn default.!
 fs dfileu0			    !* 0: Full STRARG filename.!
 fs dfn1:f6u2			    !* 2: Match-string1, from 1st fn comp.!
 fs dfn2:f6u3			    !* 3: Match-string2, from 2nd fn comp.!
 fq3"g				    !* If match-string had a 2nd fn comp,!
    :i22.3'		    !* 2: then match-string has 2 comps.!
				    !* E.g. match-string may be FOO.BAR.!
 fsDSName:f6u4			    !* 4: Directory name part.!

 e?"e fsDFile '		    !* Return immediately if exact filename.!


!*** No file of that name exactly.  Start the matching process. ***!

 q4u5				    !* 5: Copy of directory name.!
 0fo..q4 Directory Translationf"N f(fsDSNamew)u4	!* 4: Have a directory!
							!* ..translation.!
    @ft(5 = 4)		    !* Tell what happened.!
    e?"e @ft(exact fn) 0fsEchoActivew    !* Quit if now legal,!
       fsDFile ''		    !* returning the resultant filename.!

 f[BBind			    !* Grab temporary buffer for dir.!

 fsOSTeco"n			    !* On TNXs, try *-matching, since that is!
				    !* ..quicker than a full EZ.!
    @ft(*?)			    !* Tell what trying to do.!

    1:<1,ez2.*>u1		    !* First try fn.*!
    q1"L 0,7:g1u1		    !* Watch for write-only devices like LPT:!
       f~1OPN0164"E		    !* OPN0164 Output-only device specified.!
	  @ft(New File) 0fsEchoActivew    !* Voice our assumptions,!
	  fsDFile ''		    !* and use the name as typed.!
    "#				    !* Something matched...!
       0m(m.m& Flush For Find Match)u3	!* 3: 1 filename or number.!
       q3fp"g			    !* Yes just had one match.!
	  @ft(2.* = 3) 0fsEchoActivew !* Do tell.!
	  et3 fsDFile''	    !* Return now with that fn.!

    fsOSTeco-1"e		    !* 20X:  try fn*.* !
       hk 1:<1,ez2*.*>"e	    !* ...!
	  0m(m.m& Flush For Find Match)u3  !* 3: 1 filename or number.!
	  q3fp"g		    !* Yes just had one match.!
	     @ft(2*.* = 3) 0fsEchoActivew	!* Do tell.!
	     et3 fsDFile''''  !* Return now with that fn.!


!*** Try slower match on full directory. ***!

 @ft(Match in 4?)		    !* Tell what doing since takes time.!
 hk 1,ez bj			    !* Whole dir listing into temp buffer.!
 hx5				    !* 5: Save copy of full directory in!
				    !* case we find no matches.  Doing!
				    !* another EZ would be very very slow.!
 q2m(m.m& Flush For Find Match)u1  !* 1: Match or number of matches after!
				    !* flushing and keeping.!
 q1fp"g				    !* Got a filename string back.!
    @ft(1) 0fsEchoActivew	    !* Tell that we matched.!
    et1 fsDFile '		    !* And return the match.!

 q1"e @ft(No matches)		    !* Tell progress.!
    hk g5			    !* No matches, get whole dir.!
    m(m.m& Keep Only Greatest Versions)w'  !* Trim directory down to size.!
 "# @ft(Multiple matches)'	    !* Tell since  takes time to set up.!
 0fsEchoActivew		    !* Keep the progress report.!

				    !* Not just one match, so ask user.!
 :i*Position cursor at desired filename, then type <Space>. [..J   !* Modlin!
 0[..F				    !* Disable ability to hack buffers.!
 et2				    !* Reset filename default.!
 bj g(fsDFile) i  (New file)
				    !* Allow user to say he meant a new file!
 bj				    !* ... by putting a fake filename in.!
 0fsModifiedw 0fsXModifiedw	    !* Just to be neat & tidy.!
 1f[noquit			    !* ^G will abort us out of ^R.!
 m.mAbort Recursive Edit[.G	    !* ...!
 33.fs^RInit[ 		    !* <Space> exits.!
 				    !* User picks matching one, leaving point!
				    !* ..on line with desired filename.  Or!
				    !* ..else aborts via ^G.!
 m(m.m& Get Filename From Directory Line)u2	!* 2: Filename, with version!
						!* ..of .0, ie. greatest.!
 et2 fsDFile		    !* Return that.!

!Always Use Filename Matching:! !C Obsolete -- use MM Matching Filename Mode!

 m(m.m& Declare Load-Time Defaults)
    Matching Filename Mode,
       * Non-zero enables filename matching: 1
    

 ff&1"N "E 0uMatching Filename Mode ''
 1uMatching Filename Mode 

!TNX Directory Lister:! !C List files matching STRARG1 in <STRARG2>.

Null STRARG1 means all files.  Else is string for Keep Lines.
STRARG2 is directory, null means current buffer's default.
No NUMARG means use *-matching for speed.
NUMARG of 4 means quick: no dates, use *-matching.
Any other NUMARG will use general teco matching and be slower.
Teco-matching is "forced" if teco-search-control-chars are included
    in STRARG.  E.g. foobar will force a general teco match.
Giving a "*" in STRARG will do *-matching on exactly what you ask for.
    E.g. MM TNX Directory Listerfoo will match *foo*.*.-3 and
    *.*foo*.-3 but MM TNX Directory Listerfoo.*.0 will only match
    foo.*.0
Prettified to align columns.
Last full listing is kept in Last Directory Listing.!

 [1[2[3 f[DFile
 :i*( :i*u3		    !* 3: Strarg2, dir.!
	   )u2			    !* 2: Strarg1, match.!
 qBuffer Filenamesf"nfsDFile'w   !* Default dirname from buffer dir if!
				    !* any.!
 fq3"g !<!			    !* If any dirname given,!
        fq3-1:g3->"n		    !* If not <...> given, fix up.!
	    fq3-1:g3-;"e	    !* If ...; given,!
	      0,fq3-1:g3u3'	    !* 3: take the ; off.!
	    :i3<3>'	    !* 3: Make <...> form.!
	q3 fsDSNamew'		    !* Set dir default froma starg2.!

 f[BBind			    !* Temp buffer.!

 f2"l f2"l f2"l f2"l
				    !* If no teco-match characters, and!
  ff"'e(-4"'e)"n	    !* If no NUMARG or NUMARG=4, and!
   fq2"g			    !* if non-null STRARG, try *-matching.!
    *f2"l		    !* No * specifically given.!
      fsOSTeco-1"e		    !* Twenex.!
	1:< ez*2*.*.-3 >w	    !* Match in 1st.!
	1:< ez*.*2*.-3 >w	    !* And in 2nd.!
	z"g oStarMatched''	    !* ...!
      "# fsOSTeco-2"e		    !* Tenex.!
	  1:< ez2.* >w	    !* Match 1st.!
	  1:< ez*.2 >w	    !* And 2nd.!
	  z"g oStarMatched''''	    !* ...!
    "#				    !* User gave exact *-match.!
      1:< ez2 >w		    !* Match with that exactly.!

      !* Note that if user gives explicit *, we dont try teco-matching even if
       * the *-match didnt get anything.  For one thing, use was very
       * specific about what to list, so dont second guess.  For another,
       * we would have to remove the *s or else interpret them more
       * generally than in the tecoish matching, which Im not ready to do
       * yet...!

      !StarMatched!		    !* Time to tell user what we did.!
      @ft(*-matched) 0fsEchoActivew	    !* ...!
      oHaveDir''''''''		    !* Dont need to teco-match.!

 @ft(Working on full directory) 0fsEchoActivew    !* ...!
 ez				    !* ...!
 fq2"G bj m(m.mKeep Lines)2'    !* Trim dir if have STRARG.!

 !HaveDir!
 bj
 l bj			    !* Sort so duplicate lines are together.!
 < .-z; x1			    !* 1: Next non-duplicate line with CRLF.!
   <				    !* Point is within non-duplicate line.!
     :s
1; -k 0:l >		    !* Remove duplicates of it.!
   l >

 1,(-4"'n)m(m.m& Prettify TNX Directory In Buffer)	    !* And type.!
 fq2"e hx* m.vLast Directory Listingw'    !* Save if full listing, i.e.!
				    !* no STRARG.!
 -1f[^MPrint			    !* Let us print a CR without ^ing.!
 ftDone.			    !* Helpful to let user know we are done,!
				    !* since incremental typing.  Also,!
				    !* the ^M means that futher typeout!
				    !* will start at left column, but we!
				    !* dont have to waste a line.!
 

!Chronologically Order DIRED Buffer:! !C Reorder DIRED's list, reverse time.

Reorders DIRED directory listing in buffer (e.g. inside DIRED), so:
    newest files are at top, and
    files of same first and second components are together, and
    files of same first component are together.!

 [0[1[2[3[4
 0f[ReadOnly				!* Let change the buffer temporarily!
 0f[VB 0f[VZ				!* Whole buffer.!
 j 1a-9"e l @f
	 l 0l .fsVBw'			!* Skip past directory label and!
					!* blankish line if any.!

 :  :l -s;. 3:fwl fsFDConvert l	!* Sort by reverse time.!

 bj   !* Now we regroup files:  first bring all files with same fn1.fn2 up.!
      !* Then bring up the next file with same fn1 and repeat for its fn1.fn2.!
      !* We must be careful about lines beginning with DIRED delete-marks,!
      !* i.e. D Space.!

 <:fb.; r .,(0l 2c).f x1	    !* 1: Handle all files with this fn1.!
				    !* The 0l2c is to ignore first 2!
				    !* characters since they may differ, e.g.!
				    !* by DIRED marking.!
				    !* (Is always some character before 1st .)!
  f<!FN1.*!			    !* Iteration for each fn2 for this fn1.!
    0l s.  .,(:l -s.; c).x2 !* 2: fn2 and . or ;.!
    0l .u0			    !* 0: Point to bring files, before this.!
    :l .u4			    !* 4: Point to start searching from.!

    < :s
1.2; 0l fx3	    !* 3: Next file with same fn1.fn2.!
      q4-z( q0j g3		    !* Bring up file.!

	    )+zj .u4 >		    !* 4: Back to where search from.!

    :s
1."e l f;FN1.*'	    !* Done all files with this fn1.!
    0l fx3 q4j l g3 -l >	    !* 3: Still more with same fn1.!

  >				    !* Done all files.!

 bj 

!Flush Dired Lines:! !C Remove any filename's line which contains some pattern.

This command (unlike MM Flush Lines) takes an arbitrary number of
    string arguments.  If a filename line contains any of the string
    arguments, that line is removed from the Dired buffer.  End the
    string arguments with a null string argument, e.g.:
    MM Flush Dired Linesfoofah
It also differs from MM Flush Lines in that it temporarily makes the
    buffer modifiable (Dired normally has the buffer be read-only).!

 [1[2 :i1				!* 1: Start off flush pattern.!
 0f[ReadOnly				!* Allow modification.!
 < :i2 fq2@;			!* 2: Next pattern.!
   :i112 >			!* 1: Add into search pattern.!
 fq1"e '				!* No pattern to search for.!
 1,fq1:g1u1				!* 1: Strip off leading .!
 m(m.mFlush Lines)1		!* Flush.!
 

!Keep Dired Lines:! !C Keep only filename lines which contain some pattern.

This command (unlike MM Keep Lines) takes an arbitrary number of
    string arguments.  If a filename line contains any of the string
    arguments, that line is kept in the Dired buffer -- all other
    lines are removed.  End the string arguments with a null string
    argument, e.g.: MM Keep Dired Linesfoofah
It also differs from MM Keep Lines in that it temporarily makes the
    buffer modifiable (Dired normally has the buffer be read-only).!

 [1[2 :i1				!* 1: Start off flush pattern.!
 0f[ReadOnly				!* Allow modification.!
 < :i2 fq2@;			!* 2: Next pattern.!
   :i112 >			!* 1: Add into search pattern.!
 fq1"e '				!* No pattern to search for.!
 1,fq1:g1u1				!* 1: Strip off leading .!
 m(m.mKeep Lines)1		!* Keep.!
 

!M1Generate:! !C 1Gen but with matching filename, and default.

Only works for Twenex, since ITS has no version numbers on :EJ files.
Null STRARG means use buffer's file.  Sets the compiled file's version
from source.!

 :i*[0[1[2[3			    !* 0: Match string.!
 fq0"e qBuffer Filenamesf"ew 'u0'	    !* 0: Buffers file if null.!
 m(m.m& Find Matching Filename)0u0	    !* 0: Exact source filename.!
 q0"e '			    !* Abort.!
 q0f[DFile			    !* Parse source filename.!
 fsDFn1u1			    !* 1: fn1 of source.!
 er0ec fsIFVersion:\u2	    !* 2: Version (string) of source. !
 m(m.mGenerate Library)1.:EJ.20	!* Pass specific version!
						!* ..numbers to Generate.!

!& Set Matching Fn Mode:! !S FSVarMacro for Matching Filename Mode!

 m(m.m& Declare Load-Time Defaults)
    Matching Filename Mode,
       * Non-zero enables filename matching: 1
    

 "N				    !* Enable Matching.!
    m.m& Matching Read Filename m.vMM & Read Filenamew '  !* Intercept!
							    !* ..&Read calls.!
 "#				    !* Disable matching.!
    m.m& Non-Matching Read Filename m.vMM & Read Filenamew '	!* Restore old!
								!* ..function.!
 

!& Matching Read Filename:! !S Read filename allowing matching.

Return complete filename as a TECO string object, or 0 if aborted.
NUMARG with the 1- or 2-bit set means this is for writing, and we are
    not to attempt matching;  UNLESS the 4-bit is also present, in
    which case a pre-existing file is wanted.
STRARG: Prompt string. It should not contain a trailing colon or space.!
!*
If user types just RETURN, we use the default filename, exactly, no matching.
If first letter of filename read is exclamation-mark, then we use the rest of
    the filename without matching (i.e. disables matching, especially useful
    if specifying a new file).
"Matching" is prepended to STRARG if matching is to occur, so the user won't be
    surprised.!

 :i*[1[0 0[2		    !* 1: STRARG, the prompt string.!

 (&4"'N)+(&3"'E)"N -1u2	    !* 2: Non-Zero if Matching.!
    :i1Matching 1'		    !* Say it so user wont be surprized.!

 fsDFileu0			    !* 0: Default filename.!

 @:i*|				 !* HELP macro.!
      ft 
If "!" is the first character of the filename you type, no matching
will be performed (e.g. this is a new file).  If you just type RETURN,
we use the default filename exactly, with no matching.

Typing HELP again will provide details about the matching process.
     !''!			    !* First time is just brief information.!
      0u..h			    !* Dont leave it on the screen when done.!
      @:i*# :ftDetails on matching process -- 	    !* To top of screen.!
	    m(m.mDescribe)& Find Matching Filename  !* Information.!
	    :ft		    !* This seems to fix the stupid echoing!
				    !* bug after a flushed FT where no!
				    !* characters are echoes.!
	    0u..h		    !* Dont keep that stuff around.!
	    #fsHelpMacro	    !* Next HELP gives more detail.!
      |f[HelpMacro		    !* Done the HELP macro.!

 1,m(m.m& Read Line)(Default is 0)
1: u0			    !* 0: Read filename/match-string.!
 q0f"E 'w			    !* RubbedOut:  Abort, returning 0.!
 fq0"E fsDFile'		    !* Return:  just use default.!
 0:g0-!"e 1,fq0:g0'		    !* Excl:  disables matching.!
 q2"N m(m.m& Find Matching Filename)0'	!* No 1- or 2-bit in NUMARG,!
						!* ..so use matching to find!
						!* ..existing one.!
 q0				    !* Non-0 argument, writing, take name!
				    !* exactly as given.!

!& Flush For Find Match:! !S Internal to & Find Matching Filename.

Partial directory in buffer is filtered by Flush Lines of Flush Lines
    Before Match File, by default flushing 2nd components of COM,
    ^V:EJ, EXE, PROFILE, REL, SAV, or MODES.  The idea is that object
    files should be flushed, leaving only source files to be matched
    against.
NUMARG is 0 or string to give to Keep Lines to filter the directory
    further.
All filenames which aren't greatest versions are filtered out.
A match exists if only one filename is left.
Returns the single matching filename (string) or else the number of
    matches.!

 [1
 0fo..qFlush Lines Before Match Fileu1	    !* 1: Flush strarg.!
 q1"e				    !* Must create it from default.!
    fsOSTeco-1"e		    !* TWENEX.!
      :i1.COM..:EJ..EXE..PROFILE..SAV..REL..MODES..OBJ..BIN.
      '				    !* 1: Create default TWENEX flusher.!
    "#				    !* TENEX.!
      :i1.COM;.:EJ;.EXE;.PROFILE;.SAV;.REL;.MODES;.OBJ;.BIN;
      '				    !* 1: Create default TENEX flusher.!
    q1m.vFlush Lines Before Match Filew'   !* ...!

 bj m(m.m Flush Lines)1	    !* Filter out object files.!
 bj u1			    !* 1: NUMARG.!
 q1fp"g				    !* Given a Keep Lines string.!
    bj m(m.mKeep Lines)1'	    !* So filter by that.!
 m(m.m & Keep Only Greatest Versions)	    !* No confusion from sevl vers.!
 bj m(m.m& Count Lines)u1	    !* 1: Number of matches.!
 q1-1"e				    !* Just one match.!
    m(m.m& Get Filename From Directory Line) '   !* Return it.!
 q1 				    !* Else return number of matches.!

!& Keep Only Greatest Versions:! !S Flush lessers from directory listing.

Buffer contains a directory listing (EY format).
Leave only greatest-version lines.!

!* Works by going backwards through directory listing, comparing adjacent
 * filenames (sans version).  If same, the later one (in buffer, which is
 * also the later version -- unlike on ITS) is kept, the other killed.
 * EXCEPT... on TENEX -- where the later versions are first...
 *!

 m(m.m& Tenex Or Twenex Directory?)[0	    !* 0: 0 iff Twenex.!
 :i*[1				    !* 1: Prev filename, init null.!
 zj				    !* Go through dir in reverse.!
 q0"E				    !* Twenex dir.!
    < -:s.;			    !* Back to before version number.!
      0f f=1"e		    !* This file same as later one.!
	0lk'			    !* So kill it (is earlier version)!
      "# 0f x1 0l' >'		    !* 1: Different filename, keep it.!

 "#				    !* Tenex dir.!
    < -:s;;			    !* Back to before version number.!
      0f f=1"e		    !* This file same as earlier one.!
	lk -l'			    !* So kill earlier version.!
      "# 0f x1 0l' >'		    !* 1: Different filename, keep it.!

 bj 

!& Tenex Or Twenex Directory?:! !S 0 iff buffer has Twenex directory.

Tells which system the directory is from by version-number separator:
    Goes to last file, scans left from end of line for period or
    semi-colon.  If period found, is Twenex;  if semi, is Tenex.
If there is no file in the buffer, returns 0 anyway...!

 .[1 fn q1j			    !* 1: Auto-restoring point.!
 zj -:s.;"e 0'		    !* Found no period or semi, return Twenex.!
 1a-."e 0'			    !* Found period, is Twenex.!
 1				    !* Found semi, is Tenex.!

!& Get Filename From Directory Line:! !S Return filename.

Point when called is in a line of a directory listing (EY format).
No NUMARG means return filename with version of 0, i.e. indicating
    greatest.
NUMARG means return exact filename version.!

 :l				    !* Search backwards so no confusion!
				    !* from spurious .s or ;s in filename.!
 -s.; c			    !* Point after version separator.!
 ff"e i0  r'		    !* Given no argument, fake vers 0.!
 "# fwl'			    !* Given NUMARG, use version number.!
 .,(0l).f x* 		    !* Return the filename string.!

!& Prettify TNX Directory In Buffer:! !S NUMARGs control.

NUMARG1 is flag whether to type each line as go.
NUMARG2 is flag to not ignore dates.
    I.e. dates will be ignored unless NUMARG2 is non-0.
Max Filename Component Width defaults to 24.!

 [1[2[3[.1[.2[.0
 0s			    !* Set search string default out of loop.!
 bj <:s; 1a-."n		    !* Remove ^Vs except those which will!
	    1a-;"n -d''c>	    !* confuse our determination of!
				    !* component structure.!
 bj i< g(fsDSName:f6) i>  	    !* Insert dirname at top.!
 i

				    !* Fill up space...!
 bj:l m(m.m Insert Date)w	    !* ...with the date.!
 m.m& Prettify Indent[i	    !* I: Indenter.!
 m.m& Maybe Flush Output[a	    !* A: Flusher.!
 0u.1 0u.2			    !* .1,.2: Max compon width inits.!
 bj "n 2t' l			    !* Type header.!


				    !* Find max widths of components.!
 < l.-z;			    !* Next filename.!
   ma1;			    !* Maybe flush output.!
   <:s.+1"n 1;' c> r	    !* Over to 2nd component.!
   fshpos,q.1 f  u.1w		    !* .1: max width 1st component.!
   -(fshpos)+(:l -s.;
	       fshpos),q.2 f  u.2w	    !* .2: max width of 2nd compon.!
   >

 24fo..qMax Filename Component Widthu.0    !* .0: Max width.!
 q.1,q.0f u.1u.1		    !* .1: Dont let max go above max...!
 q.2,q.0f u.2u.2		    !* .2: ...!
 %.1w %.2w			    !* .1, .2: Max widths of compons + 1.!

 bj l				    !* Now prettify listing, typing as we!
				    !* go so not seem to take long, if!
				    !* weve been given a NUMARG1.!
 < l.-z; .u.0			    !* .0: Next filename line.!
   ma1;			    !* Maybe flush output.!
   <:fb.+1"n 1;' -dc>	    !* Delete ^Vs in 1st compon.!
   r q.1miw c			    !* Indent 2nd compon to align.!
   <:fb.;+1"n 1;' -dc>	    !* Delete ^Vs in 2nd compon.!
   . r q.1+q.2miw		    !* Indent 3rd compon to align.!
   s,				    !* Go to start of length.!
   q.1+q.2+8-(fshpos)+5,(	    !* Width til end of length field.!
      \(-fwk-d))\		    !* Remove and reinserted (aligned) #.!
   "n				    !* Hack dates if non-0 NUMARG2.!
      d q.1+q.2+8+8mi		    !* Indent create date to align.!
      2a--"e i '		    !* Align one-digit date.!
      s  r q.1+q.2+26mi	    !* Indent create time.!
      s, r'			    !* Ignore the ref date.!
   :k				    !* Kill what is left on line.!
   "n q.0,(l).t 0:l'		    !* Type out line.!
   >				    !* Done this filename.!

 

!& Prettify Indent:! !S To NUMARG, unless past already.

If past, does CRLF and then indent.!

 [0[2
 @f 	k		    !* Delete whitespace around point.!
 @-f 	k		    !* ...!
 0,0:fm				    !* Set fs^RHPos.!
 fs^RHPosu0			    !* 0: HPos now.!
 q0-+1"g i

	   0,0:fm		    !* Set fs^RHPos.!
	   fs^RHPosu0'		    !* 0: If past then CRLF.!
 .(/8-(q0/8)f"g ,9i
		 &7,32i'
   "#-q0,32i'
   ),.
    