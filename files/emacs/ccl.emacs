
!* EMACS "CCL" package -*-TECO-*-  Takes several source files and
compresses and purifies them together.  Each file can have a
COMPRS file - if it does, and the COMPRS file is more recent than the
source, the COMPRS file is used instead of re-compressing the source.!

!* Also contains other macros connected with editing TECO code.!

!TECO Mode:! !C Set up commands for editing TECO code.
Makes Rubout the Tab-hacking Rubout.  Tab does ^R Indent Nested.
Loads the PURIFY library.  M-' and M-" move forward and back over conditionals.!

    M(M.M &_Init_Buffer_Locals)    !* See comment at top of file.!
    1,1M.L Space_Indent_Flag
    1,36 M.L Comment_Column
    1,(:I*!*_) M.L Comment_Start
    1,(:I*!) M.L Comment_End
    1,(:I*) M.L Paragraph_Delimiter
    1,(M.M ^R_Indent_Nested)  M.Q I
    1,Q(1,Q. M.QW )M.Q.  !* Exchange rubout flavors.!
    1,0M.L Display_Matching_Paren
    1,M.M &_FILE_PURIFY_LOADED"E
	F[D FILE M(M.M Load_Library)PURIFY'
    m.m ^R_Backward_TECO_Conditional M.Q .."
    m.m ^R_Forward_TECO_Conditional M.Q ..'
    1,(@:I*+
	 ET_:EJ		    !* This kludgery needed cause generate library smashes!
				    !* q regs before doing 's.!
	 FS D SNAME:F6U2	    !* If source is on EMACS1; then library is on EMACS;.!
	 F~2 EMACS1"E ETEMACS;'
	 FS D FILEU2
	 @:I*| M(M.M Generate_Library)21| [2 M2 
	 +) M.L Compile_Command

    M.Q ..D
    0FO..Q TECO_..D F"N U..D'	    !* Select the TECO-mode syntax table!
      "# W :G..D U..D		    !* creating it if doesn't exist.!
	Q..D M.V TECO_..D
	1m(m.m &_Alter_..D) [A ]A "( ') <( >) ;A'
    1M(M.M&_Set_Mode_Line) TECO 

!Generate Library:! !C Make one :EJ file from several source files.
Takes desired name for :EJ file as first string argument,
followed by the names of the input files.  A null string argument
(altmode-altmode) ends the argument list.
The input files are all compressed (if they haven't been)
and the COMPRS files are then purified together.
Filename defaulting is sticky;
input FN2's default to >, output FN2's to :EJ.
The defaults are restored after the macro is finished.!
    f[ b bind f[ d file
    1f[ fnam syntax		    !* fnam syn needs to be 1 for :EJ default!
    etFOO_:EJ et	    !* Q..2 keeps 1st string arg (destination file name)!
    fs d file[..2		    !* with defaults merged in.!

    [..1 :I..1    !* Q..1 accumulates, for each file, commands to read in the COMPRS.!
    [0

    <  ]0 w :i*[0w -fq0;	    !* Read next fiename; stop after null argument!
       fs osteco"n et_EMACS'    !* Off ITS, default the extension.!
       0fs d vers
       er0			    !* Barf if it does not exist!
       fs dfileu0		    !* Q0 gets full name.!
       f~(fs d fn2:f6)COMPRS"n    !* Unless the specified file is a COMPRS file,!
         m(m.m &_Compress_File) 0' !* generate its COMPRS file, that exists.!
       :i..1 ..1 et0
         er_COMPRS		    !* Remember to append COMPRS file to buffer!
	 fs if cdate-q4f"g +q4u4'	    !* and accumulate date of most recent one.!
	 zf[vb
         @a ZJ 14.i 15.I 12.I
	 j :f :fb*docond*"L	    !* If there is docond stuff at front,!
             s{end:} l	    !* extract it and add to Q3.!
	     b,.@fx3'
	 f]vb
       >

    -1fs fnam sy
    fq..1"e :i* Generate_Library:_no_source_files fs err'
    0[4				    !* Q4 gets date of most recent COMPRS file.!
    [3 :i3			    !* Q3 accumulates DOCOND commands from files.!
    Q..2[2			    !* Q2 now has output filename.!

    et2			    !* Restore defaults so read same files read last time.!
    m..1			    !* Read in all the COMPRS files!

    0[5				    !* If there's an old pure file more recent than!
    1:< er2 fs if cdateu5 ec>   !* all COMPRS files, no need to purify.!
    Q5"n q5-q4"g 0''

    FT_->_2			    !* Otherwise, we must purify, so tell user.!


    fq3"g j g3 [..o		    !* If there is DOCOND stuff, move this TECO buffer!
          qBuffer_Name[9	    !* to an EMACS buffer named *DOCOND*!
	  fn M(M.M Select_Buffer)9 
	  [..o m(m.m Select_Buffer)*DOCOND* ]..o
	  m(m.aDOCONDDOCOND)	    !* Do DOCOND processing there.!
	  -3fs qp unwind'	    !* Then return to selected EMACS buffer.!

    J :S!~FILENAME~:!	    !* Find first ~FILENAME~ even if no CRLF!
    < :S
!~FILENAME~:!;		    !* Flush all but the first ~Filename~ definition.!
	-s c
	.,(:s .)k
	>

    J :S!~DOC~_~FILENAME~:!	   !* Find first ~FILENAME~ documentation!
    < :S
!~DOC~_~FILENAME~:!;		   !* Flush all but the first ~Filename~ definition.!
	-s c
	.,(:s .)k
	>

    0[9 j <:s!~DIRECTORY~:!;	    !* Merge together the ~DIRECTORY~s!
	   L
	   .,(:s:.) @fx9	    !* Putting all their contents into Q9!
           -2k>			    !* Delete the FF before each directory!
	fs bcons[8 		    !* Also extract all macros with names starting with ~!
	j <:s:!;		    !* and put them into a buffer in Q8.!
	   0l 2 f=!~"n s !<!>'
	   .,(s L .)fx1
	   q8[..o zj g1 ]..o>
	zj g8  q8 fs bkill ]8	    !* Get them back at end of buffer,!
        i!~DIRECTORY~: I!
 G9 i
 ]9				    !* Followed by the combined directories.!
				    !* NOTE WE ALREADY MADE A FF-CRLF THERE.!
				    !* We make an extra CRLF (in addition to the one ending!
				    !* the directory) so that the final string will have one.!

    m( m.m&_Purify_Buffer)	    !* Make a :EJ file of them.!

    et2			    !* Restore defaults so write proper file.!
    ei@hpef			    !* Write to specified place.  Don't clear low bits.!
    0u..h			    !* Allow redisplay of buffer, to show we are done.!

!BARE Library Generate:! !C Generate the BARE library.  Source file is string arg.!

    f[b bind er  @y	    !* Read it in.!
    m(m.m &_Compress_Buffer)	    !* Compress it.!
    m(m.m &_Purify_BARE_File)	    !* purify the library.!
    etemacs;_:ej ei@hpef    !* Write it out.  Don't clear low bits.!

!Dump Environment:! !C Dump the current environment.
Takes filenames as suffix string argument.
The dumped environment is given a ..L which will load
the libraries which are loaded now, and then perform other
start-up actions as directed.

The filenames to use to load the libraies currently loaded are
found in variables named <name> Library Filename, where <name>
is the name of the library.  If that variable is to include a
constant version numbr, it should be set up when the library is loaded.
Libraries which are loaded at dump time but do not possess such
variables will not be loaded by the environment which is dumped.

The additional start-up actions come from the value of the variable
named "Startup", which is killed before dumping.

Note that q-registers .1, .2, and .3 are clobbered by this macro.
They will be zero'd on startup by the dumped ..L.

The file EMACS;EMACS TECO is an example of an init file that
sets up things for use with this macro.!

    [1[2[3			    !* save regs and filenames!
    :i3			    !* Accumulate future ..L in Q3.!
    fs :ej page*5120+400000000000.u1	    !* Q1: pointer to last loaded file!
    <  q1fp:;			    !* stop when reach end of pure space!
       q1m.m~Filename~u2	    !* get name of library!
       0fo..q2_Library_Filenameu2	    !* get the filename of the library!
       q2"e fq3"n :i*Libraries_to_be_loaded_not_consecutivefserr''
       "# @:i3|:ej2w 3|'   !* put a :EJ of that file at the front!
       q1+fq1+4u1		    !* of ..L!
       >
    qEditor_Nameu1 m.m&_Startup_1u.3
    1:< m(m.mKill_Variable)MM_&_Startup_1 >w
    q..lu.1 q..pu.2		    !* save ..L and ..P in .1 and .2!
    @:i..l|3 q.1u..l 0u.1 q.2u..p 0u.2 :m(q.3(0u.3))|
				    !* append startup hackery to ..L!
    -3 fs qp unwind		    !* clear PDL!
    0 fs ^R last
    0 u..p			    !* no error handler yet!
    et			    !* set filename to dump to from string arg!
    -f?				    !* garbage collect before dumping!
    ei @ej			    !* dump!

!& File PURIFY Loaded:! !? If this is defined, PURIFY is loaded.!
    Note macro bodies aren't allowed to be empty.

!@ TECO:! !C Make XGP listing of macros file.
Example: 73 MM@ TECOUSRCOM >20FG (notice that
73 is the page height with the font 20FG).
20FG and 73 are actually the defaults, so that
MM@ TECOUSRCOM is equivalent.!
    F[ B BINDW F[ D FILEW -1F[ FNAM SYNTAX [0 [1 [2 [3 [4 [5 [6 [7 [..0 [..1 [..2 
    E\ E[ FN E] E^		    !* PUSH INPUT AND OUTPUT AND ARRANGE TO POP!
    32< IZU..2 >		    !* MAKE AN F^A DISPATCH TO STOP ON CTL CHARS.!
    95*5,32I
    IZU..2			    !* RUBOUT COUNTS AS CTL CHAR.!
    15.*5F_____		    !* CR, LF, TAB AND ALTMODE DO NOT.!
    12.*5F_____
    11.*5F_____
    33.*5F_____
    HFX2
    ER EGJ4L S: I@R :X6      !* Q6 GETS FILE NAME FOR OUTPUT FILE.!
     @Y				    !* READ IN THE FILE OF MACROS.!
    ZJ I
				    !* LOOP BELOW FAILS TO CONVERT CTL CHAR AT END OF BFR!
    :I1 FQ1"E :I1 20FG'	    !* SET Q1 TO FONT, OR DEFAULT TO 20FG.!
    FF"N ' "# 73' -3U0	    !* Q0 GETS PAGE SIZE, MINUS 3 FOR ;LIST HEADERS.!
    J < .-Z; .,ZF2		    !* SKIP TO NEXT CTL CHAR NEEDING CONVERSION.!
        .-3,.+2F=
	   		    !* EXCEPT FOR ^L'S THAT SEPARATE MACROS,!
	   "N 0A(-D I)#100.I'>  !* CONVERT CONTROL-MUMBLE TO UPARROW AND MUMBLE.!
    J 0S
 <:S; R-DIM>     !* CONVERT STRAY CARRIAGE RETURNS.!
    J 0S
 <:S; -DIJ>    !* CONVERT STRAY LINE FEEDS.!
    0U2 0U4                         !* Q2 PAGE NUMBER, Q4 MAXIMUM NAME LENGTH.!
    FSB CONSU3                     !* Q3 BUFFER IN WHICH TO BUILD TABLE OF CONTENTS.!
    J < .-Z; %2			    !* NOW COMBINE PAGES, BUT DONT MAKE THEM OVERFLOW.!
        .,( Q0L .) FS BOUND	    !* LOOK AT NEXT <PAGESIZE> LINES.!
				    !* WE WANT TO CONVERT ALL BUT LAST FF IN THEM TO ^ L.!
        FSVZ"N			    !* IF ALL BUFFER FITS IN ONE PAGE, CONVERT ALL ^LS!
          :-S"E B,FSZFSBOUND   !* NO FF IN THAT RANGE =) WE HAVE OVERFLOWING PAGE,!
                 :S"L R ' '	    !* SO EXPAND PAGE TO FULL SIZE AND IN EITHER CASE!
          B,.FSBOUND'		    !* EXCLUDE THE LAST FF FROM VIRT BOUNDS!
        J <.(:S:!"N		    !* FIND NAME OF THIS PAGE (COLON-EXCL) !
	      .-2(-2S!C.,)X5       !* INTO Q5 !
	      [..O Q3U..O	    !* SELECT TABLE OF CONTENTS BUFFER.!
	      FQ5-Q4"G FQ5U4 '      !* REMEMBER THE LENGTH OF THE LONGEST NAME.!
	      Q2\ 40.I G5 15.I 12.I !* PUT PAGE NUMBER SPACE NAME CRLF.!
	      ]..O '
	    )J :S; -DI IL >  !* AND CONVERT THE OTHER ^LS, IF ANY.!
        ZJ 0,FSZ FSBOUNDW	    !* RE-EXPAND BOUNDS.!
	0,1A-14."E C' >		    !* FORM NEXT LISTING PAGE.!

    Q4+2U4 [..O Q3U..O 0U5	    !* Q4 WIDTH OF NAME FIELD IN TABLE OF CONTENTS.!
    J<.-Z; .U7 %5    		    !* LOOP OVER EACH LINE, Q5 COUNTS LINES.!
      \U2 C0K:L			    !* EXTRACT PAGE NUMBER.!
      Q4-.+Q7,56.I Q2\ L>           !* AFTER NAME PUT DOTS AND PAGE NUMBER.!
    J   :L  L 		    !* SORT !
    Q4-36"L ZJ			    !* IF FITS IN 2 COLUMNS ON 80-WIDE PAGE...!
      Q4+6U4 Q0-1U0		    !* Q4 GETS WIDTH OF COLUMN 1.!
      Q0*2*((Q5+Q0*2-1)/(Q0*2))-Q5<15.I12.I> !* MAKE EXACT MULTIPLE OF PAGE SIZE.!
      J<.-Z;			    !* LOOP OVER PAGES.!
	Q0< .U7 Q0L :X5 Q7J :L	    !* LOOP OVER COL 1 LINES, Q5 GETS COL 2 LINE.!
	    Q4-.+Q7,40.I G5 L>      !* PUT COL 2 LINE TO RIGHT OF COL 1 LINE.!
	Q0K 14.I15.I12.I> -D '      !* DELETE ALL THE COLUMN 2 LINES.!
    ]..O ZJ 14.I15.I12.I G3	    !* INSERT CONTENTS AT END OF FILE.!
    Q3 FS B KILL
    ZJ -:S."N L.,ZK'		    !* DELETE TRAILING BLANK LINES.!
    FS MSNAME FS D SNAME EWDSK:  !* OPEN OUTPUT FILE ON WORKING DIR.!
    HP EF6 HK		    !* WRITE OUT TO IT.!
    ER EG J4K :L .,ZK		    !* GET ITS REAL FILENAMES.!
    :FT Listing_is_file_..O
Be_sure_to_delete_it_when_printing_is_finished.
Here_are_some_commands;_kill_the_ones_you_do_not_want_executed.
 fsTop Line+3f[Top Line	    !* Put mini buffer below typeout.!
    HX5	ZJ-FWK HFX4		    !* Q5 has the complete file name, Q4 without FN2!
    I:XGP_;LIST_5 _ 1
     :@_4 LREC/G
     :@_5/F[1]/1J/^/L[RANDOM]/#,4 LREC/@_'
 BJ 0U..H
    3M(M.M&_Minibuffer)Menu	    !* Let user edit this!
    fsTop Line+5fsTop Line	    !* Below the mini buffer + 1 line for done!
    :FT			    !* Leave the cursor there (for @ error messages) !
    @..O
:VP_
    fsTop Line-1fsTop Line	    !* Below mini buffer, above error messages !
    :FTDone. 

!Tecdoc:! !C Look up information on Teco commands.
String arg is command, e.g. MM TecdocF^B or MM TecdocFS HPOS.
Represent a control character with a "^" not followed by a space.
Spaces elsewhere are ignored.
The format of INFO;TECORD is understood.  Type "?" for help.!

    [0 [1 [2 [3 [4 [5 [6 0[..F
    F[B BIND Q..OU4 I	    !* Get arguments and stuff !
    F[B BIND Q..OU3 [..O	    !* [..O prevents KCB !
    :I*Teco_Doc[..J		    !* Display med school diploma!
    0F[^R STAR
    F[D File ET DSK: INFO; TECORD_INFO
    0FS D VERSW ER @Y F]D File

!* Digest arg in buffer in Q4.!
!ARG!
    :FT Q4U..O
    J <:S^_; -DR>		    !* remove spaces except after circumflex (not uparrow)!
    J :S_"N B,.-1K '		    !* remove leading spaces !
    J <.-Z; 1A-32"L 1A-33."N 1A( D I^)+100.I 2R'' C>    !* Turn ctl-chars to ^ and 100+ char.!
    Z"E OGET ARG'		    !* no argument =) use mini buffer to get one!
    H@FC
    J :< 1A F_:@"G C!<!>'	    !* Skip over : and @ modifiers.!
	 1A-^"E 2AF:_+1"N CDI@!<!> '' 0; >    !* Turn ^ modifier into @.!
    .( 1:< 1A-F"E C 1A-S"E
		  .-Z"N C 40.I 1A-^"E 2C 40.I '''' !* FSHPOS =) FS H, FS^RHPOS =) FS ^R H!
		 "# 1A-E"E C '' 1A-^"E C ' >    !* Skip over Fs, Es, ^s!
       :CW 0A-<"E 9I'		    !* If command is "<", look for "< Tab".!
       B,.X2			    !* Q4 has whole string, Q2 has first character or two!
       ),.X5			    !* Q5 has Q2 less modifying colons and circumflexes!
    0A-9"E -D'
    J<:S_;-D>			    !* If we put spaces in, take them out again!
    Q3U..O BJ S)		    !* Get to beginning of command descriptions!

!* Given an arg in Q4,, digested into Q2 and Q5, search for it from point.!
!SEARCH AGAIN!
    :S
5"E FG FTNot_found. OASK '	    !* Find section on this command group !
    1A-:"E :L '"# 0:L '	    !* skip section tag; get to beginning of section!
    .U6				    !* Q6 has start of section in case can't find subsection.!
    < :S			    !* Find subsection for spec'd set of modifiers.!
2
<>2
<>,<>2"E Q6J 0;'		    !* Specific modifiers not present, show all!
      FQ2R :I0			    !* Found possibility, check it out!
      :<			    !* Scan buffer putting entire command name in Q0.!
	1A-40.F"L :; '"E 0,0A-^"N C !<!> ''	    !* Skip spaces, stop on CR or TAB.!
	1 @X0 C >		    !* And accumulate command name in Q0!
      0,FQ4:G0U0		    !* Truncate to length of spec'd arg so abbreviations win!
      F~04"E :0L 0;'	    !* Matches => display starting from CRLF before this line.!
      >				    !* Loop back if full command fails to match arg.!

!* Display starting at point, which should be before the CRLF before the start of the section!
!MORE!
    .(				    !* Find how long this command description is!
     < LS
		 FKC .,.+4F=
	
	:@;>		    !* It ends before 1st nonblank line not starting with tab.!
     ),.T			    !* Type it out!

!* Say "More? " and lt user exit see next section, or give new command.!
!ASK!
    0fsFlushedw FT
		 More_(
    .u0 s
         r			    !* Find the next non-blank line!
    .,( s	 r ).t 0:l	    !* Show user what is coming up next!
    FT)?_
    @:FIU0 33.FS^R INIT-Q0"E FIW 0U..H '	    !* Char that would exit ^R exits.!
    FIU0
    Q0FXQNxqn+1"G -FS REREADW 0U..H '	    !* CR, Rubout, X Q and N exit.!
    Q0-40."E OMORE '		    !* Space => print more!
    Q0-12."E FT
	      OSEARCH AGAIN '	    !* Linefeed => search again for same arg.!
    Q0-33."E			    !* Altmode => read new arg and search for it.!
!GET ARG!
       FR 1F[TYPEOUT		    !* So M.I won't do a @V.!
       1,M(M.M &_Read_Line)Teco_Command:_U0
       F]TYPEOUT
       FQ0"G Q4U..O HKG0  O ARG'   !* User gave us an arg => search for it.!
       O ASK'			    !* If user rubs out of & Read Line, ask again.!
    FT				    !* Here if answer to question not recognized.!
Responses_at_this_point_are:
X,_Q,_N_exit
Rubout__exit
Space___type_more
Line____search_again_for_same_arg
Altmode_read_another_arg_and_search
 OASK

!^R TQuote:! !^R Quote with ^] all altmodes and ^]'s in the region.!

    f[vb f[vz
    :,. f  fs bound		    !* put virtual bounds around region to hack.!
    j< :s;
       r i c>
    fs bound			    !* return (for ^R) entire region scanned.!

!List TECO FS Flags:! !C List names of all TECO FS flags.!
    f[B Bind
    :FE BJ  :LL		    !* Get and sort the Flag Names !
    J<
      fswidth/9<		    !* Put this many columns !
	  .-z; :LK I___ >
      .,(-s_c).f k I
    .-z; >
    HT :FV 

!^R Forward TECO Conditional:! !^R Move past the ' matching the following ".!
    0[1 .[3
    .( :S
: FSZ-.F[VZ )J	    !* Don't look past end of this macro.!
    < :S"'!*;
      0A-" "E %1' !'!		    !* Count "'s and ''s.!
!"!   0A-' "E Q1-1U1 Q1-1"L 0''
      0A-* "E S!' >		    !* Ignore insides of comments.!
    Q3J FG 0

!^R Backward TECO Conditional:! !^R Move back past the " matching the preceding '.!
    0[1 [2 .[3
    .( -:S
: .F[VB )J	    !* Don't look past start of this macro.!
    < -:S"'!
;
      1A-" "E Q1-1U1 Q1-1"L 0'' !'!	    !* Count ''s and "'s.!
!"!   1A-' "E %1'
      1A-! "E .U2 -S!	    !* On finding <excl><cr>, look for the matching excl!
      		2A-*"N Q2J''	    !* And if it has a start after it, skip the whole thing!
      >
    Q3J FG 

!^R Save EMACS Patch:! !^R Add this function to EMACS;PATnnn >.
EMACS;PATnnn > is loaded in by & Load Essential Environment,
in the process of generating a new runnable EMACS or stand-alone
subsystem (INFO, etc).  The format of PATnnn is just like that
of a source file.!

    [0[1[2[3
    < -:s
; 2 F=
"E fkc 0;'> .u0		    !* Find start of this macro.!
    :s

: L .u1			    !* Find end of this macro.!
    q..ou2 f[d file f[b bind
    qEMACS_Version:\u3
    1:< er EMACS;PAT3_> @y zj i
>				    !* Get old patch file.!
    q0,q1g2			    !* Add this macro to end.!
    -2 f=
"n i
'				    !* Make sure it ends with a CRLF.!
    eihpef			    !* Write patch file.!
    

!* 
** Local Modes:
** Compile Command: M(M.M Generate Library)EMACS;[PRFY] >EMACS1;PURIFYEMACS1;CCL
** End:
*!
