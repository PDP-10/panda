!* -*-TECO-*-!
!* <EMACS>TVLIB.EMACS.18, 23-Mar-81 13:37:12, Edit by GERGELY!
!* <HOLMES>TVLIB.EMACS.2, 24-Sep-80 00:59:53, Edit by HOLMES!
!* <GERGELY>TVLIB.EMACS.12, 22-Sep-80 20:08:54, Edit by GERGELY!

!* Macros to make EMACS look more like TVEDIT
This library redefines characters to behave more as in TVEDIT.!

!~FILENAME~:! !Redefinition of command set to look TVlike!
TVLIB

!& Setup TVLIB Library:! !S Setup TV commands!
    M(M.M&_Set_TVLIB_Mode_Line)    !* Set the mode line!
    1:<M(M.M &_SETUP_ADD-TO-TVLIB_LIBRARY)>W  !* Changes for a Rutgers comp!
  16.fs ^R init u..M		    !* Next line on [Ret]!
  m.m^R_Down_Real_Line u..J	    !* Down line on [Lf]!
  m.m^R_Up_Real_Line u..^	    !* up real line on [^]!
  2fs ^R init F(u..<) u..    !* Back char on [<] and [del]!
  6fs  init F(u..>) u.._	    !* forward char on [>] and [space]!
  m.m^R_TV_Forward_Word u..)	    !* forward word on [)]!
  m.m^R_Backward_Word u..(	    !* backward word on [(]!
  m.m^R_Prefix_Control-Meta u.. !* Make [$] do C-M-chars!
  FS ^R Init F(u...() F(u...<) u...L
				    !* Start of line on [$(], [$<], [^L]!
				    !* end of line on [$)], [$>], [tab]!
  FS ^R Init F(u...)) F(u...>) u..I
  m.m^R_Bottom_of_Screen u...\   !* [$\] goes to bottom of screen!
				    !* Wanted C-M-lf, but can't type that!
  m.m^R_Top_of_Screen u...^	    !* [$^] goes to top of screen!
  m.m^R_Nth_Page F(u..P) u..G  !* Next page on [P], [G]!
  m.m^R_Next_Window u..W	    !* Generalized window on [W]!
  m.m^R_Next_Screen u.L	    !* Simple fwd window on ^L!
  m.m^R_Half_Window_Up u.\	    !* Scroll up halfscreen on ^\!
  m.m^R_Half_Window_Down u.]	    !* and half down on ^] (both are on!
				    !* left keypad)!
  m.m^R_Scroll_Other_Window u...W	    !* Scroll other on [^W]!
  m.m^R_Append_Next_Kill u...Y   !* Moving append kill to [^Y]!
  m.m^R_New_Window u...N	    !* Refresh whole screen (sort of) on [^N]!
  m.m^R_Refresh_Line u..N	    !* Refresh line on [N]!
  m.m^R_Down_Comment_Line u.N    !* Down comment moved to ^N (from [N])!
  m.m^R_Goto_Beginning u..{	    !* goto beg on [{]!
  m.m^R_Goto_End u..}	    !* goto end on [}]!
  m.m^R_Forward_Sentence u.E	    !* Forward sentence on ^E!
  m.m^R_Backward_Sentence u.A    !* and back on ^A!
  m.m^R_Mark_Beginning u:.X({)   !* mark beg on ^X {!
  m.m^R_Mark_End u:.X(})	    !* mark end on ^X }!
  Q..& u..I			    !* Undefine [I] in case!
				    !* typed accidentally (out of habit)!
  m.m^R_Display_Load_Average u.T !* L.A. on ^T (types in echo area)!
  m.m^R_Skip_to_Character u..S   !* Put modified char search on [S]!
  m.m^R_Reverse_Skip u..B	    !* Reverse search on [B]!
  m.m^R_Zap_to_Character u..Z    !* and zap on [Z]!
  m.m^R_Repeat_Skip/Zap u..A	    !* Repeat it on [A]!
    15FS Q VectorM.VLast_Skip/Zap !* Define state var for skip/zap!
				    !* and init it to 3-elt vector!
  m.m^R_Center_Line u...S	    !* move Center line to [^S]!
  m.m^R_Right_Adjust_Line u...R  !* Right flush on [^R]!
  m.m^R_Fill_Region u...Q	    !* Fill region on [^Q]!
  m.m^R_Indent_Rigidly u.._  !* Mass indent on [_] (needs special!
				    !* quote to keep the "_")!
  M.M^R_Copy_Line u.K	    !* [PJG] Just copy the line!
  4fs ^R init u..K		    !* delete char on [K]!
  m.m^R_Kill_Real_Line u...K	    !* [PJG] Kill whole line [^K] ([$K])!
  m.m^R_Backward_Kill_Word F(u.D) u.W  !* Kill last word on ^D, ^W!
  m.m^R_Kill_Sentence u...D	    !* Kill sentence on [^D]!
  m.m^R_Backward_Kill_Sentence u...A	    !* Back kill sentence on [$A]!
  m.m^R_Mark_Paragraph u..M	    !* Mark graph on [M]!
  m.m^R_Mark_Sentence u...M	    !* Mark sentence on [$M]!
  Q.@ u...@	,400.fs^Rcmacro    !* NUL = [NUL]!
  m.m^R_Copy_Region u...	    !* Copy no kill on [.] (formerly [W])!
  m.m^R_Kill_Region u..,	    !* Kill region on [,] (was ^W)!
  m.m^R_Home u..H		    !* Home (previous buf) on [H]!
  m.m^R_Other_Window u..O	    !* Other window on [O]!
  m.m^R_Return_to_Superior F(u:.X()) u...F
				    !* Advise exit routine (^X^Z, [^F])!
  QEmacs_Version-145"G
    m.mWhat_Cursor_Position u..='	    !* [PJG] where am I on [=]!
  "# M.M^R_Where_Am_Iu..='
  m.m^R_Indicate_Page/Line u...= !* page/line count on [$=]!
  m.m^R_Insert_Controlified u.Q  !* quote and controlify on ^Q!
  m.mOverwrite_Mode F(u:.X(I)) u:.X(9)
				    !* Toggle ovwrt mode on ^X I or ^X^I!
  m.m^R_New_Read_File u:.X()   !* fix ^X^R!
  m.m^R_New_Find_File u:.X()   !* fix ^X^F to do ^X^R with negative arg!
  Q..& u..~			    !* Undefine edit-~,!
  m.m^R_Buffer_Not_Modified u:.X(~)	    !* make it harder to type.!
  m.m^R_Transpose_Characters u...T
  1UAuto_Save_Visited_File	    !* make auto save always save on!
				    !* visited filename!

  m.m^R_View_Q-reg u:.X(R)	    !* View q-reg on ^X R!
  m.m^R_Put_Q-reg u:.X(D)	    !* Deposit Q-reg on ^X D!
  m.m^R_Execute_Minibuffer u:.X() !* ^X $ gets minibuffer!
  m(m.mText_Mode)		    !* text mode is the default!
  72uFill_Column		    !* set the fill column!
!*  25fs % center!		    !* Makes searches land nearer the top!
  1fs echo errors		    !* Error msgs appear in echo area!
  1uFind_File_Inhibit_Write	    !* [PJG] Make ^X^F like ^X^E!
  1UAuto_Save_Max		    !* Don't keep around extra autosaves!
  @:I*| 0FO..QSame_Version_Default"N M(M.MSame_Version)'
        | m.vVisit_File_Hook	    !* restores default dir to username!
				    !* and sets version if desired!
  :I*TextM.VDefault_Major_Mode    !* [PJG] put new buffers in text mode!
				    !* Change ugly MM and C-M-X prompt!
  :I*Extend_command:_ m.vRead_Command_Prompt
  :I*Instant_extend_command:_ m.vInstant_Command_Prompt
  :IAuto_Push_Point_Notification(^)	    !* Prettier than null!
  FS OSTECO-1"E		    !* if on TWENEX...!
    1:<m(m.m&_Setup_MAICHK_Library)>'	    !* init mail checker!
  0

!^R Half Window Down:! !^R Scroll screen down by half window!

  fs LINES[0			    !* number of lines on screen!
  Q0"G Q0/2' "# 10' :M(M.M^R_Next_Screen)
				    !* Next screen with explicit arg!

!^R Half Window Up:! !^R Scroll screen up by half window!

  fs LINES[0			    !* number of lines on screen!
  Q0"G Q0/2' "# 10' :M(M.M^R_Previous_Screen)
				    !* Previous screen with explicit arg!

!^R Up 4:! !^R Move cursor up 4 lines
or 4 times its argument.!

  -*4:M..M			    !* Do 4 backward [ret]s!

!^R Down 4:! !^R Move cursor down 4 lines
or 4 times its argument.!

  *4:M..M			    !* 4 [ret]s!

!^R Top of Screen:! !^R Move cursor to top of screen
or to bottom with negative arg!

  "L-1'"#0':M(M.M^R_Move_to_Screen_Edge)

!^R Bottom of Screen:! !^R Move Cursor to bottom of screen!

  -1:M(M.M^R_Move_to_Screen_Edge)

!^R Skip to Character:! !^R Skips to target character
Skips forward to nth (or 1st) occurrence of next char typed.
Backward if arg is negative.  Edit bit on target ignored.
Repeat Skip with ^R Repeat Skip/Zap.
Pre-comma arg gives char to search for (instead of reading it).!

!* The var Last Skip/Zap is a 3-elt Q-vector which saves state of
skip/zap commands: <target char, repeat arg, zapflg>.  The repeat arg is
saved so you know the direction of the skip/zap.  Zapflg is true if the
command was Zap (rather than Skip).  This all permits Repeat Skip/Zap to
work.!

  [0 [1			    !* Q0: target; Q1: arg!
  FF-1"G U0'		    !* Pre-comma arg = target!
    "# M.I FI :FC U0		    !* Otherwise, read next char into q0!
				    !* capitalized!
    QLast_Skip/Zap[4		    !* get state vector!
    Q0u:4(0) Q1u:4(1) 0u:4(2)'	    !* Set defaults for repeat search!

  Q1"G :C "E FG 0FS ERR''	    !* Skip over current char, error if!
				    !* at end!
  Q1 :S0 F(W Q1"G R') "E	    !* Search and back up one!
    FG 0FS ERR'		    !* not found -> error exit!
  1				    !* and exit!

!^R Reverse Skip:! !^R Search backward for target char.
I.e. like a backwards ^R Skip to Character.  Repeat with ^R Repeat Skip/Zap.!

  0-:M(M.M^R_Skip_to_Character)  !* Just do it backward!

!^R Zap to Character:! !^R Kills text up to target character.
Zap excludes target character.  Negative arg zaps backward.
Repeat Zap with ^R Repeat Skip/Zap.!

  M(M.M ^R_SET/POP_MARK)	    !* Push point!
  F @M(M.M^R_Skip_to_Character)  !* Swap point and mark, so region is!
				    !* correctly oriented!
  1U:(QLAST_SKIP/ZAP)(2)	    !* Make sure we ZAP on Repeat!
  :M(M.M^R_Kill_Region)	    !* Kill!

!^R Repeat Skip/Zap:! !^R Repeat the last Skip/Zap command
regardless of any intervening commands other than skip/zap!
  
  [0 [1 QLast_Skip/Zap[2	    !* Q2 is vector: <char, arg, zapflg>!
  q:2(2)"E m.m^R_Skip_to_Character'"# m.m^R_Zap_to_Character' u0
				    !* get skip or zap routine!
  q:2(1)"L 0-Q1 U1'		    !* If last arg was neg, reverse!
  Q1u:2(1)			    !* save sense!
  q:2(0),q1 :M0			    !* go execute the appropriate code!

!^R Next Window:! !^R Scrolls to next screenful.
With an argument, scrolls by that many lines.  Negative arg
scrolls backward; arg of "-"  scrolls full screen backward.!

  FF"E			    !* If no args, just do argless next screen!
    @:M(M.M^R_Next_Screen)'
  FS ^R ARGP & 6 - 4 "E @:M(M.M^R_Previous_Screen)'
				    !* Back full screen on -W!
   F"L   :M(M.M ^R_PREVIOUS_SCREEN)'
      "# :M(M.M ^R_NEXT_SCREEN)'


!^R Home:! !^R Returns to previous buffer.
If given explicit arg, goes to that buffer.!

  F&1"E'"# QPrevious_Buffer':M(M.MSelect_Buffer) 
				    !* Call select buffer with explicit arg!

!^R Nth Page:! !^R Goes to next or nth page.
With positive argument, goes to that page; with no arg goes forward
one page; with negative arg goes backward that many pages.!

  [0				    !* save arg!
  FF"G "G			    !* If there's an arg, and positive!
    BJ -1U0''			    !* then go to beginning and do n-1 pages!
  Q0:M(M.M^R_Next_Page)	    !* do it!

!^R Indicate Page/line:! !^R Types out page and line number of cursor!

    0[1 .[2 fnq2j		    !* To restore point on exit!
    1l.[3			    !* q3 = address of start of next line!
    0[4 0[5 0[7			    !* q4,5 = address of current, next page!
    0j <%1 			    !* increment page counter!
	:s
; .u5			    !* Search for page delim, throw ifn found!
	.-1-Q2;			    !* if past point then we're there!
	.u4>			    !* Record address of ^L and iterate!
    :i*C fs Echo dis	    !* Clear echo area!
    @ft_Page_ q1@:=		    !* Give page number!
    @ft,_Line_			    !* ", Line " ...!
    m.m&_Count_Lines[6		    !* get line counting routine!
    q4,q3 m6 f(u7) @:=		    !* Count lines this far and print result!
    @ft_of_
    q5-q4:"G zu5'"# q5-1 u5'	    !* Set q5 to end of page!
    q3-q5"G -1'"# q3,q5 m6' +q7 @:= !* if q3 is past q5, we must be off!
				    !* the page; otherwise, count rest!
				    !* of lines, add up and print!
    @ft.

    0fs echo active		    !* indicate we typed something!
    1

!View Page Directory:! !C Prints a directory of the file.
Prints out the first non-blank line on each page, preceded by its
page number.  If given an arg, starts at that page number.!

!* adapted from the PAGE library!

    .[1 0[4 [5 fnq1j		    !* set up to restore point on exit!
    0[2  F"G -1 U2'	    !* q2 = starting page number - 1!
    0[3				    !* Flag set true if we print!
    0j
    FTPage___Heading

    <%4 <.-z"'N;		    !* quit if at end!
         1A-13"'E;		    !* Skip over any initial CRLF's!
	    2c>
	.-z"'N;			    !* quitting test again!
	Q4-Q2"G			    !* If past starting page...!
	  3,Q4 :\ u5 FT5___    !* Print the page number!
	  1F T  1U3'
	:S
;
	M(M.M &_Maybe_Flush_Output) 1;>    !* quit if typeahead!
    Q3"E FT _(no_pages)
'				    !* Tell user if there was nothing!
    1

!Same Version:! !C Tells EMACS to overwrite file when it saves it.
I.e. this file will be saved as the SAME version as the
current version on exit.  Autosaves will go to AUTOSAVE files.
Does nothing if visited file already has an explicit extension.
With zero argument, undoes it, i.e. EMACS will write new versions.!

0[0 1[1 1[2
FF-1"E u2'		    !* put arg in 2!
QBuffer_Filenames F[D FILE	    !* Get current filename!
Q2:"G 2u1			    !* 0 or neg arg -> make version 0!
  '"# FS D VERSION"N 0'	    !* If already has version#, do!
				    !* nothing!
   1:<EREC>"N			    !* Look at latest version!
       1U0			    !* Can't find file; perhaps it is new!
       Z"G @FTNew_file?_--_Assuming_version_1
        0FS ECHO ACTIVE'	    !* If not empty buffer, state assumption!
     '"# FS IF VERSION U0''	    !* extract version number!
Q0 FS D VERSION		    !* set version of "default" file!
FS D FILE UBuffer_Filenames	    !* set the emacs variable!
1FS MODE CHANGE		    !* Mode line changed!
QAuto_Save_Mode-Q1"E		    !* If autosaving in the "wrong" mode!
  @M(M.MAuto_Save_Mode)'	    !* Adjust for current filenames!
0

!EXEC:! !C Invokes a lower exec out of EMACS.!

  0FZ				    !* [PJG] Goes down to the EXEC fork!
  

!Go:! !C Saves current buffer and drops into lower exec!

  1M(M.M^R_Save_File)		    !* Save buffer!
  0FZ				    !* [PJG] Goes down to the EXEC fork!
  

!MSG:!!MM:! !C Invokes MM in lower fork.
Kills fork upon returning.!

  :m(m.mRead_Mail)

!^R Refresh Line:! !^R Refreshes the current line
With a positive argument, refreshes n lines.
With an argument of zero, refreshes mode line.!

  "E 1 FS MODE CHANGE 0'	    !* zero arg refreshes modeline!
  (fs ^R VPOS)[1		    !* current vpos!
  :< -1,Q1 fs TYO HASH	    !* magic!
       %1 >			    !* increment counter and loop!
  H

!^R Display Load Average:! !^R Displays the TENEX 1 minute load average!

    :i*C fs Echo dis	    !* Clear echo area!
    FS Load Av [0		    !* get load avg!
    200301000000.,(FS Date) :FS FD Convert [1	    !* pretty time of day!
    @FT1__Load_Avg_=0

    0FS Echo Active
    0

!^R Insert Controlified:! !^R Inserts characters, controlifying
e.g. If you type ^R Insert Controlified A, it inserts ^A; DELETE is ^?.
Type ^R Insert Controlified ' to enter a number octally.!

  M.I FI & 177. [0		    !* read the character, AND out!
				    !* control bits!
  (q0-')*(q0-7) "E		    !* read octal number!
     1,M(m.m&_Read_Line)Octal:_ u0	    !* get number string in q0!
     q0"E 0' fq0"E 0'	    !* exit if none!
     f[bbind 8f[ibase g0 0j \ u0  !* convert q0 to number!
     f]ibase f]bbind'
   "# q0 & ? -? "E 177.u0'	    !* If a ? or DEL, do DEL (177)!
   "# q0 & 37. u0''		    !* otherwise controlify!
  .,(<q0 i>). 

!^R New Read File:! !^R Reads file readonly, with autosave off!

  -1,1:M(m.m ^R_Visit_File)

!Interlisp Mode:! !C Set things up for editing Interlisp code.
Puts ^R Indent for LISP on Tab, puts tab-hacking rubout on Rubout.
Comments are handled, sort of.  Forward and Backward Sexp are on
[$>] and [$<].  Paragraphs are delimited only by blank lines.!

!* This is from the emacs library, modified to do interlisp, sort of!

  M(M.M &_Init_Buffer_Locals)
  M.M ^R_Indent_for_Lisp  M.Q I
  1,1M.L Space_Indent_Flag
  Q(Q. M.Q )M.Q . !* Exchange rubout flavors.  I don't! 
				    !* really understand this!
  m.m ^R_Backward_Sexp M.Q ...<
  m.m ^R_Forward_Sexp M.Q ...>
  1,75 M.L Fill_Column
  1,48 M.L Comment_Column
  1,(:I*(*_) M.L Comment_Begin
  1,0 M.L Comment_Start	    !* Hack to make multiline comments right!
  1,(:i*)) M.L Comment_End
  1,(:I*) M.L Paragraph_Delimiter
  :i*_______________________________________________________________________________________________________________________________________A____________________________AA____|___AA___AA___A/___AA____'____(____)___AA____A________AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____A___AA____A____A____A___AA____A___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____(___AA____)____A____A____A___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____A____A____A____A________M.Q ..D
  1M(M.M&_Set_Mode_Line) LISP 

!^R New Find File:! !^R Edits file in its own buffer.
With negative arg, edits file readonly!

  "L -1[Find_File_Inhibit_Write !* With negative arg, set inhibit!
    -1'"# 0':M(m.m^R_Find_File)    !* And call Find File with non-zero!
				    !* arg to inhibit autosave!

!Read Teco File:! !C Reads and executes a teco file
eg. your emacs.init;  prompts for the filename.!

  M(m.m&_Read_Filename)Teco_File[1	    !* get filename!
  [..O FS BCREATE		    !* get a buffer for this!
  ER1 @Y M(HFX*)		    !* read in file, execute commands!
  fsBKill			    !* now kill the buffer we used!
0

!& Charprint:! !S Print pretty description of 9-bit character.
Char is the arg.  Example:  arg of 415. prints "Edit-Return".
An arg of "2," means say "^M" instead of "CR", etc, and
^B instead of an alpha on TV's.!

!* modification of EMACS's basic routine so it prints "Edit" instead of
"Meta", "Esc" for "Altmode", etc.!

  -4110."E FT Help '
  &177.[0			    !* Get just the ASCII part!
  &200."N			    !* Handle the Control bit!
     (&400.)  (Q0&100.#100.)"N FTCtrl-'
       "# Q0-177."E FTCtrl-'	    !* Use ^ unless Edit bit on!
         "# FT^'''		    !* or is un-Control-able char!
  &400."N FTEdit-'		    !* Do Meta!

  Q0-177."E FTDel '		    !* Handle special cases that look bad!
  Q0-33."E FTEsc '		    !* if we just type the character!
  -2"N
    Q0"E     FTNul '
    Q0-9"E   FTTab '
    Q0-10"E  FTLf '
    Q0-13"E  FTReturn '
    Q0-32"E  FTSpace ''
  -2"E Q0-32"L
    FT^  Q0+100.U0''
  FT0			    !* Other characters, just print!
 

!^R Copy Line:! !^R Copies line into the kill ring without buffer modification.
A specified numeric argument works the same as for ^R Kill Line.!

.:				    !* [PJG] Push location on the ring!
				    !* buffer!
@L				    !* [PJG] Move that many lines away!
:M(M.M ^R_Copy_Region)		    !* [PJG] Copy region!


!^R Kill Real Line:! !^R Kill lines including the CRLF!
:@M(M.M ^R_KILL_LINE )

!^R TV Forward Word:! !^R Move forward to the beginning of the next word!
    !* [RDH] Written by Peter J. Gergely, DREA, 3 September 1980!

    :"G ,0  :@M(M.M ^R_Backward_Word)'	    !* If <arg> .LE. 0!
    65,1A"'B+:< .W FWL>"N fg'   !* Move ahead <arg> words!
    :S"l -1:C'"# zj'	    !* Search for first non-delimiter!
    0				    !* [RDH] Say no changes made.!


!& Set TVLIB Mode Line:! !S Set the Mode line hook for the library!
    qSet_Mode_line_hook[1
    f[ b bind
    fq1"L :i1'
    g1 j
    :@S/I_TV/"E @I/I_TV/'
    HXSET_MODE_LINE_HOOK
    1fs mode change
    



!0:! !C NOTHING!
 

!*
/ Local Modes: \
/ MM Compile: 1:<M(M.M^R Date Edit)>
M(M.M^R Save File)
:I*Generate for RUTGERS? fsechodisp 0fsechoactive
1M(M.M& Yes or No)"N
M(M.MGenerate Library)TVLIBTVLIBRUTGERSMAICHK
M(M.MGenerate Library)XTVLIBXTVLIBTVLIBRUTGERSMAICHK'
"#
M(M.MGenerate Library)TVLIBTVLIBMAICHK
M(M.MGenerate Library)XTVLIBXTVLIBTVLIBMAICHK
'
1:<M(M.MDelete File)XTVLIB.COMPRS>W
1:<M(M.MDelete File)TVLIB.COMPRS>W
1:<M(M.MDelete File)RUTGERS.COMPRS>W
1:<M(M.MDelete File)MAICHK.COMPRS>W \
/ End: \
!
  