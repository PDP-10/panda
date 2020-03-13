
!* -*-TECO-*- FOR AUTO MODE SETTING!

!* Note on major mode commands:
 Major modes affect things by setting up local variables and local q-registers.
 & Init Buffer Locals discards the locals set up by the previous mode
 (actually, all locals except those created at buffer creation times;
 see Select Buffer and QInitial Local Count).
 & Init Buffer Locals also leaves Q.Q bound to Make Local Q-reg.
 Giving a "1," argument to M.L or M.Q tells it to save time by
 assuming that the local doesn't already exist.  If that isn't so,
 it is created twice, so watch out.  The 1, argument saves a lot of time.
 & Set Mode Line with an argument of 1 sets the variable Mode,
 and runs <mode> Mode Hook.!

!LISP Mode:! !C Set things up for editing LISP code.
Puts ^R Indent for LISP on Tab, puts tab-hacking rubout on Rubout.
Paragraphs are delimited only by blank lines.!

    M(M.M &_Init_Buffer_Locals)    !* See comment at top of file.!
    M.M ^R_Indent_for_Lisp  M.Q I
    1,1M.L Space_Indent_Flag
    1,Q(1,Q. M.QW )M.Q .  !* Exchange rubout flavors.!
    1,56 M.L Comment_Column
    1,(:I*;) M.L Comment_Start
    1,(:I*) M.L Paragraph_Delimiter
    QPermit_Unmatched_Paren"L
      1,0M.LPermit_Unmatched_Paren'
    1,(:I*COMPLR)M.L Compiler_Filename
    M.Q ..D
    0FO..Q Lisp_..D F"N U..D'	    !* Select the Lisp syntax table!
      "# W :G..D U..D		    !* creating it if doesn't exist.!
	Q..D M.V Lisp_..D
	-1[1 32< %1*5+1:F..D A>
	9*5+1:F..D_
	!"""""! 1M(M.M &_Alter_..D) || "| // '' `' ,' @' #' [A]A {A}A  
_ _'
    1M(M.M&_Set_Mode_Line) LISP 

!PALX Mode:! !C Set things up for editing PALX code.
The same as MIDAS mode.!

    :I*PALX,:M(M.M MIDAS_Mode)

!MIDAS Mode:! !C Set things up for editing MIDAS code.
C-M-N and C-M-P go to next and previous label.
C-M-A and C-M-E go to AC and EA fields, respectively.
C-M-D deletes next word and its terminator (eg, "FOO:").
Paragraphs are delimited only by blank lines.!

    M(M.M &_Init_Buffer_Locals)    !* See comment at top of file.!
    [2 FQ2:"G :I2 MIDAS'
    1,1M.L Space_Indent_Flag
    1,32 M.L Comment_Column
    1,(:I*;) M.L Comment_Start
    1,(:I*) M.L Paragraph_Delimiter
    F~2 MIDAS"'E +(F~2 PALX"'E)"N !* For MIDAS or PALX, give /E switch to assembler.!
      1,(:I*/E) M.L Compiler_Switches'
!*** Save time by doing the M.M's only once, the first time MIDAS Mode is called.!
    0fo..q MIDAS_Vector[1
    q1"e 5*5fs qvectoru1 q1m.v MIDAS_Vector
         m.m ^R_Go_to_AC_Fieldu:1(0)
	 m.m ^R_Kill_Terminated_Wordu:1(1)
	 m.m ^R_Go_to_Address_Fieldu:1(2)
	 m.m ^R_Go_to_Next_Labelu:1(3)
	 m.m ^R_Go_to_Previous_Labelu:1(4)'
    1,Q:1(0)  M.Q ...A
    1,Q:1(1)  M.Q ...D
    1,Q:1(2)  M.Q ...E
    1,Q:1(3)  M.Q ...N
    1,Q:1(4)  M.Q ...P
    M.Q ..D
    0FO..Q MIDAS_..D F"N U..D'	    !* Select the Midas-mode syntax table!
      "# W :G..D U..D		    !* creating it if doesn't exist.!
	Q..D M.V MIDAS_..D
	1m(m.m &_Alter_..D) <( >)'
    1M(M.M&_Set_Mode_Line) 2 

!TECO Mode:! !C Set things up for editing TECO code.
g(m.aPURIFY~DOC~ TECO Mode)jk!

    M(M.M Load_Library)PURIFY
    :M(M.M TECO_Mode)

!TEX Mode:! !C Set up for editing TEX input files.
g(m.aTEX~DOC~ TEX Mode)jk!

    M(M.M Load_Library)TEX
    :M(M.M TEX_Mode)

!Scribe Mode:! !C Set up for editing Scribe source text.
g(m.aSCRIBE~DOC~ Scribe Mode)jk!

    m(m.m Load_Library)SCRIBE
    :m(m.m Scribe_Mode)

!Text Mode:! !C Set things up for editing English text.
Tab does ^R Tab to Tab Stop.  There are no comments.
Auto Fill does not indent new lines.!

    M(M.M &_Init_Buffer_Locals)    !* See comment at top of file.!
    M.Q ..D
    1,(:I*RR) M.L Compiler_Filename
    0FO..Q Text_..D F"N U..D'	    !* Select the Text-mode syntax table!
      "# W :G..D U..D		    !* creating it if doesn't exist.!
	Q..D M.V Text_..D
	5*. :F..D __	    !* . isn't part of a word (or a "sexp").!
    !"! 5*' :F..D AA	    !* ' is part of a word...!
        5*8 :F..D AA		    !* BS is part of a word...!
	5*_ :F..D AA	    !* Underlining is part of a word...!
	'
    1,(M.M ^R_Tab_to_Tab_Stop) M.Q I
    1,0M.L Display_Matching_Paren
    1M(M.M&_Set_Mode_Line) Text 

!Edit Tabular Text:! !C Temporarily set up for editing a table.
Makes Auto Fill indent the next line,
makes Tab be ^R Tab to Tab Stop.!

    1[Space_Indent_Flag
    M.M ^R_Tab_to_Tab_Stop[I
    :I*Tabular_Text [Submode
     0

!Edit Indented Text:! !C Temporarily set up for editing indented text.
Good when body of text is indented, but topics appear at the margin.
Tab is ^R Indent Relative;  auto fill indents lines.
Paragraphs start only with blank lines.  Rubouts hack tabs.!

    M.M ^R_Indent_Relative [I
    127FS^R INIT[.
    377.@FS^R INIT[
    1[Space_Indent_Flag
    [Fill_Prefix
    :I* [Paragraph_Delimiter
    :I*  [Page_Delimiter
    :I*Indented_Text [Submode
     0

!Fundamental Mode:! !C Return to EMACS's initial mode.!

    M(M.M &_Init_Buffer_Locals)    !* See comment at top of file.!
    1M(M.M&_Set_Mode_Line) Fundamental 

!Macsyma Mode:! !C Enter a mode for editing Macsyma code.
Modifies the delimiter dispatch, ..D, appropriate for Macsyma syntax,
puts special rubout on rubout, sets parameters for comment hackery,
and defines Tab to be ^R Indent Nested.!

    M(M.M &_Init_Buffer_Locals)    !* See comment at top of file.!
    M.M ^R_Indent_Nested M.Q I  !* SHOULD BE MACSYMA INDENT, BUT HARD!
    1,1M.L Space_Indent_Flag
    1,Q(1,Q. M.QW )M.Q .  !* Exchange rubout flavors.!
    40 M.L Comment_Column
    :I*/*_ M.L Comment_Begin
    :I*/* M.L Comment_Start	    !* MACSYMA USES /* ...*/ FOR COMMENTS!
    :I**/ M.L Comment_End
    M.Q ..D
    0FO..Q MACSYMA_..D F"N U..D'   !* Select the MACSYMA syntax table!
      "# W :G..D U..D		    !* creating it if doesn't exist.!
	Q..D M.V MACSYMA_..D
	1M(M.M &_Alter_..D) \/ "| $_ ;_ :_ =_ -_ +_ *_ /_ ^_ <_ >_ @_ !_ #_ &_ |_ ._ ,_ `_ ~_ __ !'!
        5*? :F..DAA'	    !* ? is alphabetic!
    1000000.[2 Q2-1&(aFS^R INIT)[1
      ]-)*Q2+Q1 M.Q ]
      ]1 ]2
    1M(M.M&_Set_Mode_Line) Macsyma 

!MUDDLE Mode:! !C Enter a mode for editing MUDDLE code.
g(m.aMUDDLE~DOC~ Muddle Mode)jk!

    M(M.M Load_Library)MUDDLE
    :M(M.M Muddle_Mode)

!PL1 Mode:! !C Set up to edit PL/1 code.
g(m.aPL1~DOC~ PL1 Mode)jk!

    M(M.M Load_Library)PL1
    :M(M.M PL1_Mode)

!Debug Mode:! !C Invoke TDEBUG for debugging TECO code.
Show two windows with buffer in window 1, and current function code
in window 2.  Meta-D gets minibuffer which is stepped through.
Arg is line number to split screen at.!

   !* This version simply autoloads the TDEBUG Library version of this function.!
   1,M.M &_File_TDEBUG_Loaded"E 
     M(M.M Load_Library) DSK:EMACS;TDEBUG'
   F:M(M.M Debug_Mode)

!Auto Fill Mode:! !C Break lines between words at the right margin.
A positive argument turns Auto Fill mode on;
zero or negative, turns it off.  With no argument, the mode is toggled.
When Auto Fill mode is on, lines are broken at spaces
to fit the right margin (position controlled by Fill Column).
You can set the Fill Column with the ^R Set Fill Column.!

    QAuto_Fill_Mode"'E[0	    !* No arg => toggle.!
    FF"N "'G U0'		    !* Arg => set from the arg.!
    Q0UAuto_Fill_Mode
    0

!Atom Word Mode:! !C Make word commands deal with LISP atoms.
A positive argument turns Atom Word mode on;
zero or negative, turns it off.  With no argument, the mode is toggled.
When Atom Word mode is on, word commands define a word to mean
a Lisp atom.  This affects which characters are delimiters.!

    QAtom_Word_Mode"'E[0	    !* No arg => toggle.!
    FF"N "'G U0'		    !* Arg => set from the arg.!
    Q0UAtom_Word_Mode
    0

!Overwrite Mode:! !C Make printing characters overwrite existing text.
A positive argument turns Overwrite Mode mode on; a zero or negative,
argument turns it off.  With no argument, the mode is toggled.
In overwrite mode, printing characters replace a character
instead of pushing the following characters over to the right.
Rubout replaces the preceding character with a space.
To insert use ^R Quoted Insert.!

    QOverwrite_Mode"'E[0	    !* No arg => toggle.!
    FF"N "'G U0'		    !* Arg => set from the arg.!
    Q0UOverwrite_Mode		    !* Note that we use value -1, not 1.!
    0

!Indent Tabs Mode:! !C Enables or disables use of tabs as indentation.
A positive argument turns use of tabs on;
zero or negative, turns it off.
With no argument, the mode is toggled.!

    QIndent_Tabs_Mode"'E[0	    !* No arg => toggle.!
    FF"N "'G U0'		    !* Arg => set from the arg.!
    Q0UIndent_Tabs_Mode
    Q0"E
      @FT Not_using_tabs'
    "# @FT Using_tabs'
    0FS ECHO ACT

!SAIL Character Mode:! !C Enables or disables display of SAIL graphics.
They are single-column graphics for characters 0 through 37.
A positive argument turns display of SAIL graphics on;
zero or negative, turns it off.
With no argument, the mode is toggled.!

    QSAIL_Character_Mode"'E[0	    !* No arg => toggle.!
    FF"N "'G U0'		    !* Arg => set from the arg.!
    Q0USAIL_Character_Mode
    0FS ECHO ACT

!Word Abbrev Mode:! !C Turns word abbreviation mode on or off.
g(m.aWORDAB~DOC~ Word Abbrev Mode)jk!

    m(m.mLoad_Library)WORDAB
    f:m(m.mWord_Abbrev_Mode)

!Read Word Abbrev File:! !C Load in file of word abbreviations.
g(m.aWORDAB~DOC~ Read Word Abbrev File)jk!

    m(m.mLoad_Library)WORDAB
    f:m(m.mRead_Word_Abbrev_File)

!Replace String:! !C Replace one string with another, globally.
M-X ReplaceFOOBAR replaces each FOO after point with a BAR.
A numeric argument means replace only FOOs which are
surrounded by delimiter characters.  Works by calling Query Replace
and pretending you typed a .!

    1,fReplace:_[..9		    !* Get FOO in q0 and BAR in q1!
		    !* Keep FOO in Q..9 over F^K to minimize funarg problem.!
      1,fReplace_..9_with:_,q..9(]..9)[0[1
    ! fsreread
    .[9  fn q9j
    fm(m.m Query_Replace)01

!& Case Replace:! !S Like TECO ^F1 FK  commands but preserve case.!

!* Deletes old text by doing FKD.  Inserts new text from Q1.
Makes new text unchanged, capitalized or all caps according
to the text replaced.  Returns two values good for ^R.!

    fk( .( fkc :fwl
           0,1au4 0,2au2 )j	    !* Save the 1st alphabetic char of FOO, and following char!
	)d g1			    !* Replace the FOO with BAR!
    q4-100.f"g-27"l		    !* And if 1st letter of FOO was uppercase,!
       q2-100.f"g-27"l		    !* then if the second was also, turn BAR to all caps.!
	  fk  @fc  O Allcaps''
       .( fkc :fwl 1  @fc )j	    !* Only 1st letter of Foo was cap =>!
     !Allcaps!			    !* uppercasify the 1st letter of BAR.!
       ''
    -fq1 			    !* Return bounds of region changed.!

!Query Replace:! !C Replace string, asking about each occurrence.
M-X Query replaceFOOBAR displays each occurrence of FOO;
  you then type a character to say what to do.
Space => replace it with BAR and show next FOO.
Rubout => don't replace, but show next FOO.
Comma => replace this FOO and show result, waiting for next command.
^ => return to site of previous FOO (actually, jump to mark).
^W => kill this FOO and enter recursive editing level.
^R => enter recursive editing level.  ^L => redisplay screen.
Exclamation mark => replace all remaining FOOs without asking.

Period => replace this FOO and exit.  Altmode => just exit.
Any other character exits and is read again.
To restart Query Replace after exit,
use ^R Re-execute Mini or run the minibuffer with an argument.

Numeric arg means only replace FOO when bounded on both sides
by delimiter characters (according to syntax table).

If Case Replace is nonzero, BAR will be capitalized or all caps 
if the FOO found was (but only if FOO is typed all lower case).

The TECO expression 1,MM Query ReplaceFOOCommands executes Commands
as TECO commands to perform the replacement.  The commands should return
a pair of values which delimit the range of the buffer changed.  "H" is
safe.  To include Altmodes in the commands, quote them with ^]'s.
The commands can use Q2 and Q4 without saving them.!

!* The value upon exit is -1 if it is done, or non-negative if
"any other" character was typed.!

    1,fReplace:_[..9
      fq..9"e :i*String_to_replace_is_emptyfs err'
      1,fReplace_..9_with:_[1	    !* Get FOO in q0 and BAR in q1!
    q..9(]..9)[0		    !* Keep FOO in Q..9 over F^K to minimize funarg problem.!
    10f[%center
    [..j :i..j Query_Replace.__ 0[..f
    [2 [4 [5
    q1[3 "e			    !* Q3 gets either replace with BAR or execute BAR.!
      :i3 1 fk 
      0u2 -1u4			    !* Q4 gets index of first upper case letter in FOO.!
      fq0< %4:g0"u 0;' q4:g0"a %2'> !* Q2 gets >= 0 if FOO has any letters at all.!
      Q2"G %4-fq0"e		    !* If FOO contains letters but they are all lower case,!
        0fo..qCase_Replace"n	    !* maybe we should try to preserve case.!
          m.m &_Case_Replaceu3''''
    "n :i33'		    !* Make sure user command string ends in altmode.!
    F0:"L		    !* If FOO contains a ^], replace it by two of them.!
      f[b bind g0
      j< :s; i>
      hx0 f]b bind'
!* Replace String calls us with an excl in FS REREAD.!
    fs reread-!"e fiw O Excl'
    < :s0"e -1'		    !* Find next FOO.  Return -1 if no more FOOs.!
      ff&1"N
        0,FKA"C !<!>'		    !* Postcomma arg means delimiter must precede!
	0,1A"C !<!>''		    !* and follow, or we don't replace it.!
      0@v			    !* Display it.!
      .+fku5			    !* Remember where it starts.!
      fs rgetty"e 0tt'		    !* Make sure can see it on printing tty.!
      0f[Helpmac @fi:fcu4 f]helpmac
      q4-!"e m3		    !* Exclamation mark => replace all remaining FOOs.!
	!Excl!			    !* Come straight here, for Replace String.!
	< :s0;
	  ff&1"N
	    0,FKA"C !<!>'	    !* Postcomma arg means delimiter must precede!
	    0,1A"C !<!>''	    !* and follow, or we don't replace it.!
          m3 > f -1'
      q4-,"e m3@V		    !* Comma => replace with BAR,!
        !Pause! 0@V @fi:fcu4	    !* Display and read another character.!
	q4-.@;		    !* which we interpret normally, except that we have!
	q4-!"e o Excl'
	q4fx_,"g 127u4''	    !* already replaced this FOO.!
      q4-."e m3f 0;'	    !* Period replaces like Space, then exits.!
      q4-f.L"e f+ fkc !<!>'	    !* ^L clears screen and redisplays, showing same FOO.!
      q4-^"e w O Pause'	    !* ^ => go back to previous occurrence and show.!
      q4-(33.fs ^r init)@; !* If char would exit ^R, exit query replace.!
      q4-@;			    !* Altmode also exits.!
      q4-f.W"e fkd 0  !<!>'  !* ^W kills the FOO and enters ^R.!
      q4-f.R"e 0 !<!>'	    !* ^R enters ^R; on return, move on.!
      q4-4110."e ?u4'		    !* Help is like "?".!
!* Commands below here set the mark.!
      q4-?"n q5:'		    !* except for "?", which is at the bottom for speed.!

      q4-32"e m3f !<!>'	    !* If char is space, replace with BAR.!
      q4-127"e !<!>'		    !* Rubout => don't replace, move to next FOO.!
      q4-?"e			    !* ? or Help requests help.!
	!<<<"!
	ft Space_=>_replace,_Rubout_=>_don't,_Comma_=>_replace_and_show,
	   Period_replaces_once_and_exits,_!_replaces_all_the_rest,
	   C-R_enters_editor_recursively,_C-W_does_so_after_killing_FOO,
	   ^_returns_to_previous_locus,_?_gets_help,_C-L_redisplays,
	   Altmode_exits,_anything_else_exits_and_is_reread.
	   
	fs rgetty"n ft Type_a_space_to_see_buffer_again.

		:fi-32"e fiw' 0u..h @v'
	fkc !<!>'		    !* Give him another chance to answer for this occurrence.!
      q4fs rereadw 0 >	    !* Random char => exit and re-read it.!
    -1fs rereadw 0

!Keep Lines:! !Delete Non-Matching Lines:! !C Delete all lines not containing specified string.
Give the TECO search string to search for as a string argument.!

    1,fPattern:_ f[ s string    !* Initialize search default!
    .( .[1			    !* Q1 pts at end of last line we are saving!
    < :s; 0l			    !* Find start of next line to save.!
      q1,.k                         !* Kill all before it after previous saved line!
      l .u1>                        !* Mark end of line to preserve it!
    q1,zk )j .,z		    !* Kill all after last saved line!

!Flush Lines:! !Delete Matching Lines:! !C Delete all lines containing specified string.
Give the TECO search string to search for as a string argument.!

    1,fPattern:_ f[ s string    !* Initialize search default!
    fq(fs s string)"e 0'
    .( < :s;			    !* Find next line containing string!
	 0kk>  )j .,z		    !* and kill it.!

!Occur:! !List Matching Lines:! !C Displays text lines after point which contain a given string arg.
An arg <n> means type <n> lines before and after each occurrence.!

    1,fPattern:_ f[s string	    !* Save string arg for searching for.!
    .[0  FN Q0J		    !* Restore point.!
    [1 FF"E 0U1'
    < :S; -Q1T Q1+1T		    !* Find next occurrence, and type several lines around it.!
      Q1"N FT--------
	   '			    !* If typing > 1 line per occurrence, put in separators.!
      L>			    !* Don't print a line twice.!
    FT Done

    0

!How Many:! !Count Occurrences:! !C Counts occurrences of a pattern, after point.
Takes pattern as string arg.!

    1,fPattern:_f[s string	    !* read string arg.!
    0[0 .[2
    fn  FT QUIT!__ q0:= ft_occurrences_as_of_location_ .:= FT
	 q2j 		    !* If user quits, say what was found.!
    <:s; %0>
    q0:= FT_occurrences.
    
    q2j ]..n 0		    !* Now that answer is out, no need for quit-protection.!

!Tabify:! !C Convert spaces after point to tabs.
g(m.aAUX~DOC~ Tabify)jk!

    f:m(m.a AUXTabify)

!Correct Spelling:! !C Correct spelling over the whole buffer.
g(m.aAUX~DOC~ & Correct Buffer Spelling)jk!

    f:m(m.a AUX&_Correct_Buffer_Spelling)

!Command to Spell:! !C Give command line (string arg) to SPELL job.
g(m.aAUX~DOC~ & Spell JCL)jk!

    f:m(m.a AUX&_Spell_JCL)

!Untabify:! !C Converts all tabs after point to spaces.
Numeric arg specifies tab stop spacing.!

    f"n f[tab width'
    fs tab wid[1
    .[0  fn q0j
    0s	
    < :s; -d q1-(fsshpos-(fsshpos/q1*q1)),32i>
    

!Load Library:! !C Load a library of functions.
Takes filename as string arg;  default FN2 is :EJ.
Tries both the specified (or home) directory and EMACS.
An argument means don't run the library's & Setup function.
Pre-comma argument means create variable <libname> Library Filename
for Dump Environment's use.
Returns a pointer to the file in core.!

    1,fLibrary:_[2
    [0 [.1 f[d file 
    ff&2"n e[ fne] 0[8'	    !* if pre-comma argument then push open!
				    !* input file!
    etDSK: fs hsname fs dsname   !* Set up defaults.!
    1f[fnam syn et _:EJ	    !* Read in library file name.!
    fs d fn1 :f6[.2		    !* Get FN1 as string.  Used for & Setup function name.!
    f[:ej page			    !* Must be last pushed.  If we like the file, discarded.!
    fs :ej pageu0
    1:< :ej2u.1
	ff&2"n er fsIFileu8 ec'
	>"L		    !* If only one name, it is FN1, and FN2 is :EJ!
      F~(0,3:G(FS ERROR))OPN"N FS ERROR FS ERR'
      1:< f[d file		    !* If not found, try EMACS;.!
	  :ej EMACS;u.1
	  ff&2"n er fsIFileu8 ec'
	  f]d file >"L		    !* Not found on EMACS; either => give up.!
	  F~(0,3:G(FS ERROR))OPN"N FS ERROR FS ERR'
	:ej''			    !* Make sure err msg mentions spec'd dir, not EMACS.!
    q.1fp-100"e			    !* File is good if it starts with a pure string,!
	q.1+fq.1+4-(q0*5120+400000000000.)"e  !* whose length is length of file.!
	    ]*w q.1[.6		    !* File good => run its setup!
				    !* function if any,!
				    !* [PJG] Fix pushdown problem with the!
				    !* existing parenthesis by storing into!
				    !* .6 and then restoring it later!

	    ff&3-1"n 1,q.1 m.m~Filename~u.2 fq.2"g
		     ff&2"n q8m.v.2_Library_Filename'
		     ff&1"e 1,q.1 m.m &_Setup_.2_Libraryu.1
				fq.1"g m.1''''

	    Q.6''		    !* [PJG] then return, not restoring FS!
				    !* :EJPAGE.!

    :i*LIB	FILE_NOT_IN_LIBRARY_FORMAT fs err

!Run Library:! !C Run a specific function from a specific library file.
M-X Run Library<Lib name><Function name> runs the function
named <Function name> out of the library <Library name>,
which is loaded temporarily (unless it is already in core).
If <Function name> is null, "<ENTRY>" is used.
TECO programs should use M.A instead of this function.!

    1,fLibrary:_(
      1,fFunction:_[.9	    !* Get library in q.8 and function in q.9.!
      )[.8
    f:m(m.a.8.9)

!Kill Libraries:! !C Delete some loaded libraries from core.
Offers to kill each library, one by one, most recently loaded first.
Keeps asking until the first time you say no.
Before killing a library, we call its & Kill <libname> Library
function (if any) with string-pointer to the library as argument.!

  :ft [0 [4 [5
  <
    fs:ejpage*5120+400000000000.u0 !* 1st file in q0!
    fq0-1:;
    1,q0m.m~filename~u4	    !* Get library's name.!
    q4"n f~4 EMACS@;'		    !* Kill EMACS library?  Unthinkable!
    q4+1"G ft Kill_Anonymous_Library'
    "# ft Kill_4_Library	    !* Print library name.!
       q0m.m~DOC~_~FILENAME~u5	    !* Get its global documentation,!
       ft _(5)'		    !* and print it too.!
    m(m.m&_Yes_or_No)@;
    q4"l 1,q0m.m&_Kill_4_Libraryu5'	    !* Run the library's kill function if there is one.!
    q5"n q0m5'			    !* Its arg is a pointer to the library in core.!
    fs :ejpage+(fq0+4/5120) fs :ejpage'   !* Yes => kill this one, ask about next.!
    >
  0u..h			    !* Allow redisplay right away.!

!List Library:! !C List contents of a library not necessarily loaded.
M-X List Library<filename> is the format.!

    F[:EJ PAGE	F[D FILE	    !* POPPING THIS WILL UN-LOAD THE FILE.!
    1,FLibrary:_[0 [1
    1,q0m(m.m&_Get_Library_Pointer)[2
    q2"n q2U1'			    !* Q1 gets ptr to that file, if already loaded.!
    "# 1M(M.M Load_Library)0U1' !* If not loaded, load it.  Don't run the setup function.!
    Q2,Q1M(M.M &_LIST_ONE_FILE) 	    !* And list the library's contents.!
				    !* If library is loaded, also list keys that call it.!

!Compare Windows:! !C Compare text in two windows.
g(m.aAUX~DOC~ & Compare Windows)jk!

  f@:m(m.aAUX&_Compare_Windows)

!DIRED:! !Edit Directory:! !C Edit a directory.
g(m.aDIRED~DOC~ & DIRED Enter)jk!

    F:M(M.A DIRED&_DIRED_Enter)

!Reap File:! !C Delete old versions of a file.
g(m.aDIRED~DOC~ Reap File)jk!

    F:M(M.A DIREDReap_File)

!Clean Directory:! !C Delete old versions in a directory.
g(m.aDIRED~DOC~ Clean Directory)jk!

    F:M(M.A DIREDClean_Directory)

!Compare Directories:! !C Compare directories on different ITS machines.
fsosteco"n iNot implemented on Twenex.'
   "# g(m.aDIRED~DOC~ Compare Directories)jk'!

    :M(M.A DIREDCompare_Directories)

!Kill Variable:! !C Eliminates definition of specified variable.!

    1,fVariable:_[0
    :fo..q0 [0		    !* Find the variables idx in symbol table (..Q)!
    q0"l '			    !* Not defined =) do nothing.!
    q..q[..o  q0*5j 15d 0	    !* Else delete the 3 words describing it!

!Edit Options:! !C Edit values of permanent options.
Displays a table of the variables which are options,
and their values, and lets you edit the values.
A variable is an option if its comment starts with "*" or "*".
When you exit the recursive edit with ^R Exit, the values are updated.
To abort, use Abort.!

    :m(m.a AUX Edit_Options)

!List Files:! !C Brief directory listing.
g(m.aDIRED~DOC~ List Files)jk!
 
    :M(M.A DIREDList_Files)

!List Directories:! !C List names of all disk directories.!

    :M(M.A DIREDList_Directories)

!RMAIL:! !Read Mail:! !C Read mail using your favorite mail-reader.
Passes a string argument to the mail-reader.
If the variable Mail Reader Library exists,
it is the name of the mail-reader library.
Otherwise, on Twenex, if Mail Reader Program exists,
run that program in a subfork; and an argument means
kill the subfork.  The default is RMAIL on ITS, MM on Twenex.

A precomma arg of 1 means just mail one message.
A precomma arg of 2 tells RMAIL to exit to DDT when done.!

    [2 -1"n :i2 <entry>'	    !* 2: name of entry point in the library.!
    "# :i2 &_Mail_Message'	    !* Precomma arg of 1 means just mail a message.!
    :f"l :i*'"# :i*'[1	    !* 1: string argument if any!
    0fo..qMail_Reader_Library[0    !* 0: If string, names mail reader.!
    -1"e 0fo..qMail_Sender_Libraryf"nu0''
    q0"e fsosteco"e :i0RMAIL''    !* On ITS, default to RMAIL here.!
    fq0:"l fm(m.a 02)1 '	    !* Call the library, passing on string arg.!
!* Get here only on Twenex!
    0FO..qMail_Reader_Programu0
    q0"e :i0MM'
    0fo..qMail_Fork[2		    !* 2: Old fork if any.!
    "e ff&1"n "n q2"n -q2fz	    !* Argument means kill fork, if it exists.!
      0uMail_Fork' 0'''	    !* Remember that we no longer have one.!
    0[3 "n f=0MM "e :i3SEND''   !* 3: Maybe string for sending!
    m(m.m&_Exit_EMACS)		    !* clear mode line, home up, autosave.!
    0fo..q Exit_to_Inferior_Hook[1
    q1"n m1'
    q3 f"n fs fork jcl'	    !* Give command line if needed.!
    q2"n
	q2fz
	oclean-up'		    !* if old fork, run it!
    fsOSTeco-1"e fzSYS:0.EXEu1' !* 20X, use winning SYS:.!
      "# fz<SUBSYS>0.SAVu1'	    !* 10X, use losing <SUBSYS>.!
    q1 m.v Mail_Fork		    !* and save fork handle!

    !clean-up!
    0fo..Q Return_From_Inferior_Hooku1
    q1"n m1'
    0				    !* nothing changed in buffer!

!Send Mail:! !C Mail a message, using your favorite mail-reading program.
If you abort the message, you can resume by giving this
command a nonzero argument.
Refer to the Read Mail command.!

    1,(f):m(m.mRead_Mail)

!Edit Syntax Table:! !C Delimiter syntax table editor.
g(m.aAUX~DOC~ Edit Syntax Table)jk!

    :m(m.a AUX Edit_Syntax_Table)

!View Variable:! !View Q-Register:! !C Type out contents of q-register or variable.
M-X View Var<variable name> is the format.!

  f[B Bind g(1,f Q-register:_)  !* Pick up argument !
  J 1AF(.:"L Z-.-1"N	    !* If it doesn't look like a q-reg name,!
      J27I ZJ27I''		    !* put altmodes around it, to treat it as a variable.!
  Q..O[1 [2 [3		    !* Now that we got the value, it's ok to push qregs.!
  J 1A-33."E			    !* If the q-reg is a named variable,!
    D ZJ-D :FO..Q..OU3	    !* find its position in the symbol table,!
    Q:..Q(Q3)U2  FT Q 2    !* and type the full name (arg maybe was abbrev.!
    Q:..Q(Q3+2)U2		    !* Get variable's comment, and type if not 0.!
    FQ2"G HKG2			    !* Have a non-null comment.!
      J 1A-!"E		    !* If comment starts with an excl,!
        D S! R.,ZK'		    !* extract just the stuff between the excls.!
      FT__ HT''
  "# :FT Q..O'		    !* not a named variable => type qreg name as given.!
  FT

  [A				    !* Internal Function !
  0U3				    !* Q3 amount of spacing already hacked this line !
  0U2				    !* Q2 desired indentation !
  @:IA|
    Q2-Q3<FT_>			    !* indent !
    Q1FP-1"E FTQ-vector
	Q1[..O -1[0 Q2+2[2
	Z/5< Q2<FT_> FT( %0:=	FT)	    !* type each element of Q-vector !
	     Q0-10"L FT_ '
	     Q2+2[3 q2+3[2 Q:1(Q0)[1
	     MA ]1 ]2 ]3 >
         '
    Q1FP+1"E FTDead_Buffer
  '
    Q1FP"L Q1=  '		    !* Number !
    Q2"N FQ1-2000."G FT Long_String
  ''
    FT1
 				    !* String !
|
  :MA				    !* Call it !

!View Buffer:! !C View a buffer moving by screenfulls.
Buffer name is string argument; null arg means selected buffer.
Space moves to next screen, Backspace moves back a screen.
Return exits leaving point in current screen.
Anything else exits and restores point to where it was before;
and if it isn't Rubout, it is executed as a command.

Also useful on fast storage scopes like the Tektronix.
However, Backspace is only available on real displays.!

    1,FBuffer:_[1
    Q1 :M(M.m &_View_Buffer)

!& View Buffer:! !S Implements M-X View Buffer!
    [1
    0[2
    fq1"e qBuffer_Nameu1'	    !* If arg is null, use current buffer.!
    "# Q1M(M.M &_Find_Buffer)U2    !* Else get index of specified buffer!
       Q:.B(Q2+4!*bufbuf!)[..O'		    !* and select it, for TECO.!
    [..J :I..J Viewing_Buffer_1__
    .[P  FN QPJ :I* [..A	    !* SAVE ., ..A!
    q2"e :F FS WINDOW+BJ'
    "# q:.b(q2+6!*bufwin!)+bj f[ window'
    1,M(M.MView_File)		    !* Actually display and process Space and Backspace.!
    FS REREAD"L '		    !* flushed by rubout or space past end.!
    :FI-"E
      FIW			    !* ^M => leave the cursor in the center of the screen.!
      FS RGETTY"E .UP .'
      FSWINDOW+BJ
      Q2"N .-BU:.B(Q2+6!*bufwin!)'
      FSLINESF"EW FS HEIGHT-(FS ECHO LINES+1)-(FS TOP LINE)'/2L .UP .'
     

!View File:! !C View a file sequentially on the screen.
Type Space to see the next screenful, or Backspace to back up.
Anything else exits.  Spacing past last screenful exits.
On non-displays, Backspace is not available.
Does not set the file's reference date.

Pre-comma argument means view the current buffer contents
and don't change the buffer or Q..J.!

    "E
      FN EC			    !* Close the file when we exit.!
      5,4F View_File[1 1,ER1
      FS D FILE[0
      :I*Viewing_0_ [..J FR	    !* Set the mode line.!
      F[B BIND F[WINDOW'
    FS RGETTY"E [H
      :< F+			    !* Force screen clear on non-displays!
         1:<0,0@FM>W		    !* Go to beginning of screen line!
	 FS HEIGHT-1, 34 F : 1UH !* Height of the screen!
	 .,( 1:<QH,0 FM >W .)T	    !* Do one screens worth!
	 .-Z@;			    !* If at the end, quit!
	 FT--More--		        !* Do --MORE-- processing!
	 :FI-40."N FT_FLUSHED 0;' FI>	    !* check for FLUSH!
      FS REREAD-127."E FIW'	    !* Discard Rubout if that flushed us.!
      F+ '			    !* Cause current line to be redisplayed.!

    0[1				    !* Q1 has addr in file of start of buffer.!
    .[2				    !* Q2 has addr in file of desired top of screen.!
    [3
    1F[^R MORE
    FSLINESF"E W FSHEIGHT-(FS TOP LINE)-(FS ECHOLINES+1)'[H    !* Usable screen height.!
    < "E
	Q2+6000-Z-Q1"G		    !* Have we enough text past that point?  If not, read it.!
	  ZJ Q1+ZFS IF ACCESS
	  Q2+6000-Z-Q1/5*5FY'
	Q2+6000-Z-Q1"G		    !* Didn't read as much as we wanted =>!
	 -@F K'		    !* flush padding from end of file.!
	Q1"G Q1-Q2+6000"G		    !* Not enough before start of screen => read more.!
	  Q1-Q2+6000/5*5U3
	  Q3-Q1"G Q1U3'		    !* Don't try reading back past start of file.!
	  J Q1-Q3FS IF ACCES
	  Q3FY Q1-Q3U1''
	Q1+Z-Q2-10000"G		    !* Too much past end => flush some.!
	  ZJ -(Q1+Z-Q2-8000)D'
	Q2-Q1-14000"G		    !* Too much before start of screen => flush some.!
	  J (Q2-Q1-8000)U3
	  Q3D Q3+Q1U1''
      Q2-Q1J .FS WINDOW
      .,Z@V
      :FIU3
      Q3-127"E FI'		    !* Discard a rubout.!
      Q3-32"N Q3-8"N 0;''	    !* Exit on anything but Space or Backspace.!
      FI			    !* Either one, discard as input.!
      Q3-32"E 1:< QH,0:FM >	    !* Space => move down.!
              .-Z;'		    !* Exit if reach EOF. !
      Q3-8"E 1:< -QH,0@FM >'	    !* BS => move up.!
      .+Q1U2
      >
    0U..H			    !* Redisplay right away.!
    

!Insert Date:! !C Insert the current time and date after point.
A date in FS IF CDATE format can be given as a numeric
argument, to use instead of the current date.
The mark is put after the inserted text.!

 [1[2 .f[vb fsz-.f[vz
 ff"n ' "# fs date'	    !* Use current date or argument if any.
!   fsfdconvertw .-3fam_	    !* get date, remove seconds!
 8r \u1 -2d			    !* find hour of day!
 q1-11"g q1-12u1 .+3fp'	    !* convert to 12 hour, change am to pm!
 .,(q1f"ew 12'\)zfx2 -d		    !* 0 -> 12, save time in qreg!
 j eg j5k i_ cfwf(fc)l i,_ 3k	    !* find day of week!
 \-1*10u1 -2dd 1a-0"e dr'	    !* change numeric month to name!
 2c f_c q1,q1+10g(:i*January___February__March_____April_____May_______June______July______August____September_October___November__December__)
 .,(-s_2c).f k i19		    !* remove excess spaces!
 j g2 z: j h		    !* combine time and date and return!

!Visit Tag Table:! !C Select a tag table file.
g(m.aTAGS~DOC~ & Visit Tag Table)jk!

    1,M.M&_Setup_TAGS_Library"E
      M(M.M Load_Library)TAGS'
    FF"N M.V Tags_Find_File'
    :M(M.M &_Visit_Tag_Table)

!Dissociated Press:! !C Print interesting random text based on text in buffer.
Arg is number of words of continuity at jumps,
or minus number of characters of continuity.!

    [2 "e 1u2'
    [1[3[4 -1F[^MPRINT
    :i3 -(*(/))   !* a,bm3 = a mod b!
    < fsFlushed"n 0;'
      q2"g .u4 1:<,20m3+4 fwr>"l j!<!>' q4,.t
           -q2fwx1
           ,zm3j :s1"E js ' r'
      "# .,(1:<,20m3+4 c>w).t
           q2 x1
           ,zm3j :s1"E js ''
      >
    

!Compile:! !C Recompile the file you are visiting.
We first offer to save any changed files, unless there is a numeric arg.
A string argument is used to specify compiler switches.

If nothing seems to be happening before your compile, just be patient.
If nothing seems to be happening after your compile, first type a Space,
then type POP (on TNX) or P (on ITS).

Refer to the source code for customization information.!

!* Customization:  (This should be set up for you by your mode.)

If Compile Command is nonzero, it is executed to do the compilation.
It can find the filename in Q1 and switches in Q4.
It MUST exit with a ^\, to pop what we leave on the stack.

Otherwise, we run the compiler.  Compiler Filename should specify
the compiler's name.  On ITS, it is the name of a TS file on your
dir or a system dir.  On Twenex, it is a filename, which defaults
to SYS: and to .EXE.  If it is 0, the major mode name is used.
If it is positive, the EXECUTE command is used on Twenex;
on ITS, the major mode name is used.

The string Compiler Switches is used in addition to any switches
you specify in an arg to Compile.
When the compiler returns, we execute After Compilation Hook if it is defined.!

    FF"E M(M.M Save_All_Files)'

    Qbuffer_filenames[1	    !* Current file name in 1,!
    FSOSTECO"N (fq1-1:G1-0)(fq1-2:G1-.) "E   !* except if ".0" exten.,!
      0,fq1-2:G1U1''		    !* strip it off!

    Q1F[D FILE

    0FO..Q Compiler_Switches[4
    FQ4"L :I4'

    0FO..Q Compile_Command[2
    Q2"N f:M2'

    QModeU2
    0FO..Q Compiler_Filename[3	    
    FS OSTECO"E Q3"G 0U3''	    !* On ITS: there is no EXEC command.  Use mode name.!
    Q3"E Q2U3''			    !* The mode name is always the default.!
    
    FS OSTECO"E
       :3__14 
'
    "# Q3"G  F+   0FZexecute__1_4  
'
         "# :F3"L <F3"L !>!   !* Add SYS: if no device or dir.!
	       :I3 SYS:3''
	    .F3"L :I3 3.EXE'	    !* Add .EXE if no extension.!
	    :FT -(FZ3    __1_4  
)FZ'
       0U..H -1FSPJATY 
       '
    0FO..Q After_Compilation_HookU2
    Q2"N M2 '
    

!View Mail:! !C Read your own or other user's mail file.
User name is string argument;  null means your own.
Uses View File.!

    1,fUser:_[0
    fs osteco"e
      fq0"e fs uname'"# f60' fs u mail !* Set default filename to!
      '					    !* specified user's mail file, or!
					    !* this user's if none specified!
    "# fq0"e fs hsname' "# q0'fs dsname
       etdsk:mail.txt'
    m(m.mView_File) 0

!Undo:! !C Undo last major change, kill, or undo.
Point is left before the undone change and the mark is left after.
Insertion cannot be undone, nor deletion (as opposed to killing).
If you change the buffer by insertion or deletion before you undo,
you will get slightly wrong results, but probably still useful.
A nonzero arg means don't query, just do it.!

!* The data for undoing is kept in a qvector in Q..U.
   The 0 slot is the TECO buffer in which the change happened.
   You can't undo the change in any other buffer.
   The 1 slot is the string of old text.
   The 2 slot is the old address of the start of that text.
   The 3 slot is the old address of the end of that text,
     remembered as the distance from the end of the buffer.
   The 4 slot is a string identifying the type of change
     which is recorded.  This is for querying the user.
   This database is updated by things like & Kill Text
     and & Save Region and Query.!

    q:..u(0)-q..o"n
      :i* Not_in_buffer_that_was_changed fs err'
    fsz-q:..u(2)-q:..u(3)"l
      :i* Things_have_changed_too_much_to_undo_that. fs err'
    q:..u(4)[0
    "e
      @ft Undo_the_last_0	    !* Ask the user whether he really wants to undo.!
      1m(m.m&_Yes_or_No)"e 0''
    q:..u(1)u0
    b-q:..u(2)"g 0fsvb'	    !* If the virtual bounds get in the way, flush them.!
    fsvz-q:..u(3)"g 0fsvz'
    q:..u(2)j
    .,fsz-q:..u(3)x:..u(1)	    !* Store the new text for any re-undo.!
    .,fsz-q:..u(3)k		    !* Flush the new text.!
    g0				    !* Get the old text back.!
    .:			    !* Set the mark after the reinserted text.!
    fkc
    :i:..u(4)Undo		    !* Next undo should offer to undo an undo.!
    fQ0 

!Set Variable:! !C Set the value of a named variable.
The name of the variable is a string argument.
If you supply a numeric argument, that is the new value.
Otherwise, a second string is the new value.
You may abbreviate the name of the variable
if you are sure it already exists.!

    1,F Variable:_(
      FF"E 1,F Value:_' "# '[1
      )[0
    :FO..Q 0:"G
      0M.V0'			    !* Create variable if it doesn't exist.!
    Q1U0 0		    !* Set value in any case.!

!Set Key:! !C Put a function on a key.
The function name is a string argument.
The key is always read from the terminal (not a string argument).
It may contain metizers and other prefix characters.!

    m(m.m &_Load_Bare)
    8,F Function_Name:_[0
    m.m0m(m.m&_Macro_Name)u0
    @ft Put_0_on_key:_
    m(m.m &_Read_Q-reg)[1	    !* Ask what character to put it in.!
    @ft__Go_ahead 1m(m.m&_Yes_or_No)"e 0'
    m.m0u1
    1fsmode ch		    !* Make WORDAB notice the change.!

!What Page:! !C Print the current page and line number in the file.!

    0F[VB .[0  FN Q0J  1[1
    QPage_Delimiter[2

!* Search, counting page delimiters, but only those at the start of a line.!
    J < .,Q0:FB2; FKC 0@F  "E %1'W -FKC>

    @FT__Page_ Q1@:=
    1U1
    < .,Q0:FB
; %1>
    @FT__Line_ Q1@:=
    0FS ECHO ACT

!What Cursor Position:! !^R Print various things about where cursor is.
Print the X position, the Y position,
the octal code for the following character,
point absolutely and as a percentage of the total file size,
and the virtual boundaries, if any.!

    :i*CFS ECHO DIS
    @ft X= fs shpos@:=
    @ft_Y= fs ^r vpos@:=
    .-z"n @ft_CH= 8[..e 1a@:= ]..e'
    @ft_.= .@:= @ft( .*100/fsz@:= @ft%_of_ fsz@:= @ft)
    fsvz+b"n
       @ft_H=< h@:= @ft>'
    @ft_ 0fsecho act

!View Directory:! !C Print file directory.
Takes directory name as string arg.
Uses and sets the TECO default filenames.!

    5,F Directory[0
    [..J :I..J Viewing_Directory_0__
    EY0
    

!Make Space:! !C Delete things to make space.
Offers to delete the kill ring, buffers, etc.
Even if you answer "no" to all offers,
some internal wasted space is reclaimed.!

    qMM_&_Yes_or_No[.Q	    !* M.Q to ask a question.!
    0[0 [1 [..O
    < q0*5-fq.b;		    !* process all the EMACS buffers.!
      q:.b(q0+4!*bufbuf!)u..o
      20.f?			    !* Close all large gaps.!
      q:.b(q0)+q0u0 >
    ]..O
    FT Flush_the_kill_ring
    m.q"l -1u0
      fq..k/5< 0u:..k(%0) >'
    FT Flush_the_Undo_memory
    m.q"l -1u0
      fq.u/5< 0u:.u(%0) >'
    0u0
    < q0*5-fq.b;		    !* process all the EMACS buffers.!
      q:.b(q0+1!*bufnam!)u1
      0:g1-*"e		    !* If buffer name starts with a star,!
        FT Kill_buffer_1	    !* offer to kill it.!
        m.q"l m(m.m Kill_Buffer)1 !<!>''
      q:.b(q0)+q0u0 >
    2f?				    !* GC strings.!
    

!What Available Space:! !C Print amount of free address space left.!

    F[B BIND			    !* Find top of buffer space!
    FS :EJ PAGE-(FS REAL AD+5119/5120)[0
    FS OSTECO"N Q0*2u0'
    Q0:@= @FT_pages_available.
    0FS ECHO ACT
    0
  