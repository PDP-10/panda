!* -*-TECO-*- !

!^R Character Search:! !^R Search for a single character.
Special Characters:
   ^A	Call ^R String Search; use M-X Describe to see what that does.
   ^F	Position window so search object is near top
   ^Q	Quote following character
   ^R	Reverse search direction and read another char
   ^S	Search for default
        Also done if character the macro was called by is typed again,
	overides any other function of that character shown here.
   ^T	Search for Teco default
If ^S is not used, the character typed becomes the default
for future searches.  The previous default is saved on a "ring",
unless it was only one character.!

    [0 [1[2 0[3 [9
!RDCH! M.I @:FIU0		    !* Q0 gets 12-bit command char!
    FIU9			    !* Q9 gets actual ascii char!
    Q0-(FS^RLAST)"E 323.U0'	    !* If repeat char called by, treat as ^S.!
    Q0:FCU0			    !* Uppercase char!
    Q0-301."E			    !* ^A call other macro.!
	Q1:M(M.M^R_String_Search)'
    Q0-306."E 1u3 oRDCH '	    !* ^F set flag to bring to top!
    Q0-321."E M.I FIU9 '	    !* ^Q read another character, don't check for special.!
    Q0-322."E -Q1U1 ORDCH '	    !* ^R reverse direction and read another.!
    Q0-323."E F[S STRING	    !* ^S use default.!
	QSearch_Default_Ring[..O
	.FSWORDFSS STRING ]..O
	OSEARCH '
    Q0-324."N			    !* ^T use teco default.  Otherwise,!
      F[S STRING 0S9 '	    !* normal character, compile search for it.!
    QSearch_Default_Ring [..O	    !* New search char, save prev default.!
    FQ(.FSWORD)-1"G 5C .-Z"E J ''  !* If previous default is worth saving, push it!
    FSS STRING,.FSWORD ]..O	    !* Store current (new) default!
!SEARCH!
    .U0 Q1:S"E FG 1  '	    !* Do the search, ding if error !
    Q0M(M.M&_Maybe_Push_Point)	    !* Maybe remember where we came from.!
    q3"N :f			    !* ^F search, adjust window!
	 2fo..Q Next_Screen_Context_Lines :@f '
    1 

!^R Reverse Character Search:! !^R Search backwards for a single character.
g(m.m~DOC~ ^R Character Search)jk!

-:M(m.m ^R_Character_Search )

!^R String Search:! !^R Search for a character string.
Reads string in echo area.  Special characters:
   ^B	Start search from beginning of buffer.
   ^D	Yank in a default off of search default ring,
	popping it.  Flushes any previous type-in.
   ^E   Start from end of buffer.
   ^F	Position window so search object is near top
   ^L	Redisplay.
   ^Q	Quote next character.
   ^R	Reverse direction.
   ^S	Search then return to read in loop.
   ^T	Yank in the Teco default.
   ^U	Flush string so far.
   ^V   Find string only if surrounded by delimiters.
   ^W	Word search (ignore any white space between words)
   ^Y	^D with no pop and no flush.
   	Search then exit to ^R mode, whether succeed or fail
 Rubout	Delete last character of search string.

If you search for the null string, the default is used.
Otherwise, the new string becomes the default and the old
default is saved on a ring, unless it is only one character.!

    [0 [8 [9 0[3			!* Q3 ^S/$ flag, non-zero if search done!
    [1				!* Q1 search direction and count!
    0[5 .[6				!* Q5 0 normal, -1 BJ, 1 ZJ; Q6 starting place!
    0[.3 0[.4 0[.5			!* Q.3 0 normal, 1 ^F search, Q.4!
					!* word search, Q.5 ^V search!
    Q..O[4				!* Q4 main buffer!
    fsB Cons[2 @fn/Q2 fs B Kill/ [..O	!* Q2 buffer to read search string into !
					!* Can't use f[bbind because it bites the KCB.!
    0[7					!* Q7 number of ^PX's to adjust display.!
    F<!EXIT!				!* throw out of this to leave macro!
      F<!SEARCH!			!* throw out of this to do search!
	Q7"G fsrgetty"E 0u7 ''	        !* On printing console, don't try partial redisplay!
	Q7"E fsEcho Dis		!* Q7 = 0 =) complete redisplay needed.!
	 CfsEcho Dis			!* clear echo area!
	 Q5"L @ftBJ_ ' Q5"G @ftZJ_ '	!* starting place prompt!
	 Q.3"N @ftTop_Line_'		!* ^F-prompt!
	 Q1"L @ftReverse_'		!* directional prompt!
	 q.5"N @ftDelimited_' "#	!* delimited-search prompt!
	 q.4"N @ftWord_' '		!* word-search prompt (can't be both delim & word)!
	 @ftSearch:_			!* name of command prompt!
	 Q2U..O H@t -1U..0 '		!* list current search string, enb echo suppressor!
	"# Q7< fsEcho Dis		!* give sufficient number of ^PX's !
	       XfsEcho Dis > 0U7 '	!* 0U7 assumes complete redisplay will be needed!
	< Q4U..O fsListen"E 0@v'q2U..O	!* keep blinker up top!
	  @:fi:fcu0 fiu9		!* Q0 gets 12-bit upper-case char, q9 gets real char!
	  q0-33."E q9fsEchoOut
	      q3"n f;EXIT'		!*  if just after ^S, exit!
	      f;SEARCH '		!* Otherwise, go search!
	  q0-177."L q9i q9fsEchoOut	!* ordinary character, echo and handle quickly!
             0u3 q0-"e 
i' !<!>'	!* Follow a CR with an LF.  Exit iteration quickly.!
	  q0-302."E -1u5 0u3 1u1 0; '	!* ^B BJ before search!
	  q0-304."E HK 0U3		!* ^D yank in new default and pop!
            QSearch_Default_Ring[..O
	    .FSWORDu0 ."E ZJ ' 5R
	    ]..O g0 0; '		!* then redisplay!
	  q0-305."E 1u5 0u3 -1u1 0; '	!* ^E ZJ before search, implies reverse also!
	  q0-306."E 1-q.3u.3 0; '	!* ^F use 0FS % CENTER$ for window (complement switch)!
	  q0-314.@;		        !* ^L redisplay search string!
	  q0-321."E @ft FIU9 '	!* ^Q read another char, don't check for special!
	  q0-322."E -q1u1 0u3 0; '	!* ^R reverse search direction, redisplay!
	  q0-323."E @ft 1u3 2u7	!* ^S try a search, Q3 suppresses exit from macro!
		      f;SEARCH '	!* after search completes, 2U7 will erase the ^S !
	  q0-324."E HK 0U3		!* ^T yank in the teco default !
		    g(fsS String) 0; '	!* and redisplay!
	  q0-325."E HK 0;'		!* ^U flushes current string!
	  q0-326."E 1-q.5u.5 0; '	!* ^V complement delimited-search mode!
	  q0-327."E 1-q.4u.4 0; '	!* ^W complement word-search mode!
	  q0-331."E 0u3			!* ^Y insert default!
            QSearch_Default_Ring[..O
	    .FSWORDu0 ]..O g0 0; '	!* then redisplay!
	  q0-177."E 0u3			!* Rubout, delete a char, 0u3 to flag change!
	     Z"N fsrgetty"E 0afsEchoOutw -D !<!>'
	         0A-37."G 0a-177"N 1U7 '' !* Try not to use complete redisplay !
		 -D ' 0; '		!* and run back through redisplay routine!
	  0u3 q9i q9fsEchoOut '	!* non rubout non special insert it,!
	  > >				!* 0u3 flags change, already echoed courtesy of M.I!
      Z"N 0S..O '			!* Compile the new search string, if any!
      Z( QSearch_Default_Ringu..O	!* New search char, save prev default.!
	 )"N			        !* If using old default, don't repush!
	  FQ(.FSWORD)-1"G 5C .-Z"E J ''!* If previous default is worth saving, push it!
	  FSS STRING,.FSWORD '	!* Store current (new) default!
         "# .FSWORDFSS STRING '	!* Using old default, get it!
      Q4U..O .U8 FN Q8J		!* Remember where we were, go back if ^G out!
      Q5"L BJ ' Q5"G ZJ '		!* Get to starting place for search!
      q.5"n q1"l -q1<-:s2"e oSFL' 0a(fk-1c)"c @'> fk-1r'
	      "# q1<:s2"e oSFL' fk+1c -1a"c @'> fk+2r''
      "# Q.4"N Q1,Q2 M(M.M&_Word_Search)'	!* Do word search, or
!           "# Q1:S'			!* normal search
!     "E
	!SFL! -1FS QPUN FG		!* If error, go back, ding and exit!
	q3"N @ft_FAIL_ 0fs echo active '	!* Saying FAIL if in incremental mode!
	1  '' ]..N			!* Otherwise forget where we wanted to go back to!
     q.3"N :f				!* ^F search, adjust window!
	 2fo..Q Next_Screen_Context_Lines :@f '
     Q5"N 0u5 0u7 '			!* If search succeeds, forget BJ mode, redisplay it!
     -q3; Q1"L -'1u1 >			!* If altmode, Q3=0, exit; else re-enter, count now 1 !
   Q4U..O				!* Select main buffer.!
   Q6M(M.M&_Maybe_Push_Point)		!* Maybe remember where we came from.!
   q.3"N :f				!* ^F search, adjust window!
	 2fo..Q Next_Screen_Context_Lines :@f '
   0fs Echo Activew 1 		!* Leave the search on the screen!

!^R Reverse String Search:! !^R Search backwards for a character string.
g(m.m~DOC~ ^R String Search)jk!

-:M(m.m ^R_String_Search )

!& Word Search:! !S Subroutine for Word Search (still experimental)
You can search for a sequence of words, separated by any delimiters.
Case is ignored.  You specify any substring of the first word,
and prefixes of the rest of the words.  Supposed to feel like
the completing reader.

First numeric arg, search count and direction.
Second numeric arg, string to search for (which is in a buffer).
Returns non-zero if successful.!

 [0 [3 [5
 "L -'1[1			    !* Q1 has search direction!
   <			    !* Iterate specified number of times!
   < [..o j 1:< fwr >"N 0  '    !* Fail if not given any words (would get NIB error)!
	    -fwx0 ]..o		    !* Q0 has first word, pointer is after it!
     Q1:S0 F"E  '	    !* Find first word, if fails return 0!
     "G fkc ' .u5		    !* Point and Q5 at start of first word!
     :< fwr			    !* Put point at end of this word!
	[..o fwr -fwx3 ]..o	    !* Q3 gets next word, err out of loop if no more words!
        :fwr fq3  f~3"N 0; '  !* If next word doesn't match, return 0 from errset!
      >"N 0; ' >		    !* Exit inner iteration if all words matched!
   "L q5j ' >			    !* If backwards search, leave point on left!
 1 				    !* Success return!
