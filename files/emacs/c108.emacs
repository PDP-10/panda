!* EMACS:<JQJOHNSON>C108.EMACS.24, 13-Aug-82 22:42:53, Edit by JQJOHNSON!
!* Fixed HELP macro by modifying & Prefix Describe to flush CR on ^\!
!* -*-TECO-*- *!

!~FILENAME~:! !Commands to use Concept function keys--revised JQJ!
C108

!& Setup C108 Library:! !S Sets up concept function keys.
  Function keys F1-14 and the "funny" keys transmit by default ^\
char CR, so ^\ becomes a prefix character, with dispatch in .Z
  The cursor keypad (except MC and RESET) transmit ESC char, so ESC
becomes a prefix character, with dispatch in .Y
  Q.P gets a modified Prefix driver to make this all work.
  If $CONCEPT Setup Hook$ is defined, it is run afterwards to make
any additional assignments or changes; it can access the function Set
Concept Key (q.v.) by running MS, e.g.  <number>MS<function>!

  128M(M.M Make_Prefix_Char).Z U.\	    !* Make ^\ a prefix char!
  128M(M.M Make_Prefix_Char).Y U	    !* Make Escape a long prefix char!
				    !* in .Y (it will distinguish case)!
  M.M &_Concept_Prefix_Character_Driver U.P	!* revised driver in .P!
  M(M.M &_Load_Bare)		    !* to get primitives!

  M.M Set_Concept_Key[S	    !* MS now runs assignment routine!

!* INSRT to CLEAR!
     15MS ^R_Prefix_Meta
     35MS ^R_Prefix_Control
     16MS ^R_Delete_Character
     36MS ^R_Kill_Line
     Q.R,17MS			    !* whatever is on ^R, normally rev-I-srch!
     37MS ^R_Previous_Page
     Q.S,18MS			    !* whatever is on ^R, normally I-search!
     38MS ^R_Next_Page
!* SEND to F3!
     19MS ^R_Mark_Paragraph
     39MS ^R_Fill_Paragraph
      1MS ^R_Copy_Region
     21MS ^R_Kill_Region
      2MS ^R_Un-kill
     22MS ^R_Un-Kill_Pop
      3MS ^R_Query_Replace
     23MS ^R_Correct_Word_Spelling
!* F4 to F7!
      4MS Find_File
     24MS Select_Buffer
      5MS ^R_Save_File
     25MS List_Buffers
      6MS ^R_Return_to_Superior
     26MS ^R_Exit
      7MS ^R_Instant_Extended_Command
  !* 27MS ^R_Zap_Defun_to_Lisp !		!* MACLISP only !
!* F8 to F11!
      8MS ^R_Reverse_Skip
     28MS ^R_Reverse_Zap_to_Character
      9MS ^R_Skip_to_Character
     29MS ^R_Zap_to_Character
     10MS ^R_Backward_Word
     30MS ^R_Backward_Kill_Word
     11MS ^R_Forward_Word
     31MS ^R_Kill_Word
!* F12 to F14 !
     12MS ^R_Prefix_Control-Meta
     13MS ^R_Prefix_Control
     14MS ^R_Prefix_Meta
     32MS ^R_Call_Last_Kbd_Macro
     33MS ^R_End_Kbd_Macro
     34MS ^R_Start_Kbd_Macro
!* cursor pad !
     41MS CONCEPT_Default_Key_Info !* STAT!
     42MS ^R_Forward_Paragraph	    !* PRINT!
     54MS ^R_Backward_Paragraph
     43MS ^R_Next_Screen	    !* PAGE!
     55MS ^R_Previous_Screen
     44MS ^R_Up_Real_Line	    !* uparrow!
     45MS ^R_End_of_Line	    !* TAPE!
     46MS ^R_Backward_Character    !* leftarrow!
     47MS ^R_Beginning_of_Line	    !* HOME!
     48MS ^R_Forward_Character	    !* rightarrow!
     49MS ^R_Scroll_Up		    !* SCROLL!
     61MS ^R_Scroll_Down
     50MS ^R_Down_Real_Line	    !* downarrow!
     51MS ^R_Goto_End		    !* TAB SET/CLR!
     63MS ^R_Goto_Beginning

     64MS ^R_Prefix_Meta	    !* Back Tab !
     65MS ^R_Set/Pop_Mark	    !* BREAK !

  0FO..Q Exit_to_Inferior_HookF"E
    :I*M.V Exit_to_Inferior_HookW:I*'"#'[1
      @:IExit_to_Inferior_Hook|1WM(M.M &_Concept_Disable_Keypad)|

  0FO..Q Exit_to_superior_hookF"E
    :I*M.V Exit_To_Superior_HookW:I*'"#'[2
      @:IExit_to_superior_hook|2WM(M.M &_Concept_Disable_Keypad)|

  0FO..Q Return_From_Inferior_HookF"E
    :I*M.V Return_From_Inferior_HookW:I*'"#'[3
      @:IReturn_From_Inferior_Hook|3W M(M.M &_Concept_Enable_Keypad)|

  0FO..Q Return_From_Superior_HookF"E
    M.VReturn_From_Superior_HookW:I*'"#'[4
      @:IReturn_From_Superior_Hook|4 WM(M.M &_Concept_Enable_Keypad)|


				    !* set up state vector for skip/zap!
    35FS Q Vector[1		    !* get a 7-elt q-vector!
    :i*Skip_to:_ U:1(3)	    !* install prompts now so we don't!
    :i*Skip_back_to:_ U:1(4)	    !* cons up strings later!
    :i*Zap_to:_ U:1(5)
    :i*Zap_back_to:_ U:1(6)
    Q1 M.VSkip/Zap_State_Vector    !* And define the state variable!
    ]1


  0FO..QCONCEPT_Setup_HookF"N [1 M1' !* run user hook if any!

  :M(M.M &_Concept_Enable_Keypad)

!& Concept Enable Keypad:! !S Set the cursor pad to transmit
This function should be called when starting or returning to EMACS
to reset the cursor pad and special function keys.!

  @:I*|4_0_4_1_4_2_4_3_4_4_4___4_!_4_"_4_#_4_$_| FS Image Out
				    !* make extra 5 functions keys transmit!
  @:i*|X_x_!!_x!"!| FS Image Out	    !* set most cursor keys to!
				    !* transmit, but MC and RESET to execute!
  0

!& Concept Disable Keypad:! !S Set the cursor pad to execute
This function should be called when exiting from EMACS to reset the
cursor pad and special function keys to their normal (local
execution) state.!

  @:i*|_^x| FS Image Out	    !* Reset all windows, and reset cursor pad!
  0


!& CONCEPT Prefix Character Driver:! !S M.P for Concept: handles prefix character.
Given a q-vector as argument, it reads a character
and returns the q-vector element it selects.
Difference between this and standard is that ? is not treated as help,
and an extra character (the cr) is eaten if ^\ was the prefix.
The character read is left in Q..1.!

  [0 w -1[1
  0F[ Help Mac			    !* Intercept HELP!
  -Q.X"E M.I'			    !* only do expensive waiting for ^X!
  FI U0				    !* Get the subcommand character!
  -Q.Z"E FIU1'		    !* Eat the CR if dispatch is .Z!
  FQ()-640"L Q0 :FC U0'	    !* uppercase the char if dispatch!
				    !* table is short!
  F] Help Mac

  Q0-4110."N


    Q0u..1
 			    !* If char is not Help, put into Q..1.!
    Q:()(Q0) F"E Q:()(Q0:FC) F"E W :I* FG'''

				    !* Index into qvector.  If slot is 0,!
				    !* first try uppercasing, else!
				    !* return command to ring bell.!
  Q1"L				    !* if not .Z dispatch, then!
    FS ^R LASTU0'		    !* HELP gives documentation for prefix.!
  Q0,(Q0 @FS ^R CMAC) M(M.M &_Prefix_Describe)

  :I*0_			    !* and return a no-op!

!& Prefix Describe:! !S Describes the subcommands of an escape-prefix command.
Modified for C108 library 8/13/82.!

!* Reads the prefix character from the terminal, or can be
given the definition as a numeric arg or the character
as a precomma arg.  If there is an arg, we do not print the
character's name.!

    M(M.M &_Load_BARE)
    [0 [1 [2 [3 [4
    FF"E 1,M.I @FIU0'	    !* Q0 gets character to describe.!
    Q0"G Q0 FS ^R INDIRECTU0
         Q0U1'		    !* Q1 gets definition.!
    Q1FP-101"N O NOT PREFIX'
    F=1!PREFIX!-9"N
  !NOT PREFIX!			    !* Assume that we don't get a non-prefix defn!
      Q0 M(M.M&_CHAR PRINT)	    !* if we are called with defn as an argument.!
      FT _is_not_an_escape-prefix_character.
 '
    M.M &_Maybe_Flush[A
    F[ S STRING		    !* NOW SEE WHICH QREG THIS PREFIX DISPATCHES THRU!
    F[ B BIND
    G1				    !* LOOK AT THE PREFIX-MACRO.!
    JSQ 0K SM.P 3R .,ZK	    !* EXTRACT THE QREG NAME IT DISPATCHES THROUGH.!
    hx4 q4u3			    !* Get the q-vector name in Q4, the!
				    !* q-vector in Q3.!
    F] B BIND
    FF"E FT Here_is_info_on_the_prefix_command_
	     Q0M(M.M&_CHAR PRINT) FT.
'
    FS LISTEN"E FT Type_a_subcommand_to_document_(or_"*"_for_all):
 !''!'
    M.I @:FIU1 FI U2
    Q0"G Q0M(M.M&_CHAR PRINT) FT_'
    Q2-*"N			    !* IF HE WANTS SPECIFIC SUBCOMMAND,!
       F~4.Z"E			    !* If dispatch is ^\, flush CR!
	 FI'			    !* (C108 only)!
       FQ3/5-Q2"G Q:3(Q2)' "# 0'"E  !* If char is not defined, upcase it.!
         Q2:FCU2'
       Q1M(M.M&_CHAR PRINT) FT_   !* Print prefix and subcommand,!
       Q2*5-FQ3+1"G FT is_not_defined.
 '
       Q:3(Q2)"E FT is_not_defined.
 '
       :i*:4(2),Q:3(Q2) :M(M.M ^R_DESCRIBE)'
				    !* THEN DESCRIBE THAT SUBCOMMAND.!
    FT has_these_subcommands:

    -1U1 FQ3/5<
	Q:3(%1)"N		    !* FOR EACH ELEMENT OF THE DISPATCH TABLE,!
	   MA FT___
	   Q1,Q:3(Q1) M(M.M&_^R_Briefly_Describe)'	!* IF DEFINED, DESCRIBE IT.!
	>
    

!Set Concept Key:! !C Assigns a function to a Concept special key.
For best results, use ^R Instant Extended Command to invoke this.
String Argument is name of function to assign.
You will be prompted to type the key to put the function on.

Alternatively, if you are calling this from your init file, you can pass
the key as a numeric arg.  In this case, the keys are coded as follows:
  1-14 unshifted function keys F1-14
 15-19 funny keys to left of F1, left to right (INSRT, ..., SEND)
 21-34 shifted function keys F1-14
 35-39 shifted funny keys (SHIFT/INSRT, ..., SHIFT/SEND)
 40-51 unshifted pad:  MC, STAT, ..., TABSET
 52-63 shifted pad: MC, RESET, ..., TABCLEAR
    64 BACKTAB
    65 BREAK

Note that MC most shifted cursor pad keys may not be set.

You may also pass the function DEFINITION as a pre-comma arg, instead of
passing the function NAME as a string arg.!

  FF-1"G [2 [1'		    !* pre-comma arg is function def!
    "# 9,fFunction:_ [1	    !* else get name of desired fn in 1!
       m.m1 [2'		    !* and its definition is in 2!
  FF&1"N			    !* getting key as a numeric arg!
    -15"L Q2 U:.Z(+4) 0'    !* 1-14 ==> ^\ 5 thru B!
    -20"L Q2 U:.Z(-15+0) 0' !* 15-19 ==> 0 thru 4!
    -40"L			    !"!
      -21:G(:I*%&'()*+,-./CDE_!"#$)[3 !'! !* 21-40 ==> shifted versions!
      Q2 U:.Z(Q3)		    !* put it in the ^\ dispatch!
      0'
    -66"L			    !"<!
      -40:G(:I*0+{-;`>?=[<]00|.00000\0_')[3    !>!
      -63"E 137. U3'		    !* special kludge for underscore!
      Q2 M(M.M&_Macro_Name) U1
      :\[4			    !* convert arg to numeral!
      Q3-0"E :I*Cant_set_that_key_(4_to_1) FS Err'
      Q2 U:.Y(Q3)		    !* put it in the ESC dispatch!
      0'
    :\[4			    !* convert arg to numeral!
    :I*Key_argument_(4)_out_of_range FS Err'
  Q2 M(m.m&_Macro_Name) U1	    !* get full name of fn in 1!
  @FT Put_1_on_special_key:_	    !* prompt for key!
  :i* M.I			    !* prepare (so Help works), but no prompt!
  FI[4
  Q4-"E			    !* is first part of key ^\?!
    FI U1			    !* get next char in q1!
    FI				    !* eat the cr!
    Q2 U:.Z(Q1) 0'		    !* put function in the ^\ dispatch!
  Q4-33."E			    !* is first part of key ESC?!
    FI U1
    Q2 U:.Y(Q1) 0'		    !* put function in the ESC dispatch!
  :i*Not_a_special_key FS Err   !* first part of key should be!

!^R Top of Screen:! !^R Move cursor to top of screen.
With negative arg goes to bottom!

!* the next few functions are from TVLIB !

  "L-1'"#0':M(m.m^R_Move_to_Screen_Edge)

!^R Bottom of Screen:! !^R Move cursor to bottom of screen.!

  -1:M(m.m^R_Move_to_Screen_Edge)

!^R Scroll Up:! !^R Scroll 1 line upwards!

FF"E 1'"#F' :M(M.M ^R_Next_Screen)


!^R Scroll Down:! !^R Scroll 1 line down!

FF"E 1'"#F' :M(M.M ^R_Previous_Screen)


!CONCEPT Default Key Info:! !C Prints the default key definitions!

:ftINSRT_-------------------------------------________________cursor_pad
._._._|_Ctrl-__|kill_lin|back_pag|fwd_page|_______----------------------------
CLEAR_|_Meta-__|del_ch__|bck_srch|search__|_______|_reser-_|reserved|back_pgf|
______-------------------------------------_______|__ved___|_HELP!__|fwd_pgf_|
SEND__-------------------------------------_______----------------------------
_._._.|fill_pgf|kill_rgn|unkl_prv|spell_wd|_______|bck_wind|___^____|=======_|
F3____|mark_pgf|copy_rgn|_unkill_|qry_repl|_______|fwd_wind|___up___|end_line|
______-------------------------------------_______----------------------------
F4____-------------------------------------_______|___<____|=======_|____>___|
._._._|slct_buf|list_buf|exit_sub|fn->lisp|_______|__left__|beg_line|__right_|
F7____|find_fil|save_fil|__EXIT__|ins_Xtnd|_______----------------------------
______-------------------------------------_______|scrol_up|___V____|beg_file|
F8____-------------------------------------_______|scrol_dn|__down__|end_file|
_._._.|back_zap|fwd_zap_|bck_k_wd|fwd_k_wd|_______----------------------------
F11___|bck_skip|fwd_skip|bck_word|fwd_word|
______-------------------------------------______F14______F13______F12
_______----------_________--------------______----------------------------
_BREAK_|set_mark|_____RUB_|bck_del_char|______|beg_macr|end_macr|call_mac|
_______----------_________--------------______|_Meta-__|__Ctrl-_|__C-M-__|
__*_*_TYPE_ANY_CHARACTER_TO_CONTINUE_*_*______----------------------------



!Set CONCEPT Terminal Width:! !C Set the terminal and display widths.
The only argument is the width of the display (80 or 132).  No
argument toggles.!

    [0			    !* Q0 gets the default terminal width!
    F"E
      FS Width-80"G80'"#132' U0'   !* If no argument, toggle!
    "#				    !* argument specified!
      Q0-79"G
        Q0-133"L		    !* Check if argument [80,132]!
	  80 U0'''		    !* no.  use 80!
    Q0-80"G
        :@I*|"| !'! FS Image Out'	    !* set 132 col!
    "# :@I*|!| FS Image Out'	    !* set 80 col!
    Q0-1FS Width		    !* Change the width for teco!
    

!^R Skip to Character:! !^R Skips to target character.
Skips forward to nth (or 1st) occurrence of next char typed.
Backward if arg is negative.  Edit bit on target ignored.
Repeat Skip with ^R Repeat Skip/Zap.
Pre-comma arg gives char to search for (instead of reading it).!

  0U:Skip/Zap_State_Vector(2)	    !* flag that this is skip!
  . F(F @M(m.m&_Skip_to_Char)) M(m.m&_Maybe_Push_Point)
  0

!& Skip to Char:! !S Implements Skip to Character.
This is a separate routine so that ^R Skip to Character can
do the Auto Push Point Option.  Optional pre-comma arg is the target char,
post-comma arg is repeat!

!* The var Skip/Zap State Vector is a 7-elt Q-vector that saves state of
skip/zap commands: <target char, repeat arg, zapflg, skip prompt, backskip
prompt, zap prompt, back zap prompt>.  The repeat arg is saved so you know the
direction of the skip/zap.  Zapflg is 1 if the command was Zap, 0 if Skip.
This all permits Repeat Skip/Zap to work.  The prompts are for M.I to use if
user is slow.!

  [0 [1			    !* Q0: target; Q1: arg!
  FF-1"G U0'		    !* Pre-comma arg = target!
    "#				    !* otherwise read a char!
    QSkip/Zap_State_Vector[S	    !* get state vector!
    Q:S(Q:S(2)"N Q1"L 6'"# 5''"# Q1"L 4'"# 3'') M.I
				    !* prepare for input with prompt!
				    !* based on skip, backskip or zap!
    FI :FC U0			    !* read char into Q0 and capitalize!
    Q0u:S(0) Q1u:S(1)'		    !* Set defaults for repeat search!

  Q1"G :C "E FG 0FS Err''	    !* Skip over current char, error if!
				    !* at end!
  Q1 :S0 F(W Q1"G R') "E	    !* Search and back up one!
    FG 0FS Err'		    !* not found -> error exit!
  1				    !* and exit!

!^R Reverse Skip:! !^R Search backward for target char.
I.e. like a backwards ^R Skip to Character.  Repeat with ^R Repeat Skip/Zap.!

  0-@:M(M.M^R_Skip_to_Character) !* Just do it backward!

!^R Zap to Character:! !^R Kills text up to target character.
Zap excludes target character.  Negative arg zaps backward.
Repeat Zap with ^R Repeat Skip/Zap.!

  .[1				    !* Push point!
  1u:Skip/Zap_State_Vector(2)	    !* flag that this is zap!
  F @M(m.m&_Skip_to_Char)	    !* Search, passing args!
  "LC'			    !* If backward zap, exclude char found!
  .: q1J			    !* Swap point and mark, so region is!
				    !* correctly oriented!
  :M(M.M^R_Kill_Region)	    !* Kill!

!^R Reverse Zap to Character:! !^R Zap backward to target char.
I.e. like a backwards ^R Zap to Character.  Repeat with ^R Repeat Skip/Zap.!

!* not on any key by default!

  0-@:M(M.M^R_Zap_to_Character) !* Just do it backward!

!^R Repeat Skip/Zap:! !^R Repeat the last Skip/Zap command
regardless of any intervening commands other than skip/zap!
  
  [0 [1 QSkip/Zap_State_Vector[2	!* Q2 is vector: <char, arg, zapflg>!
  q:2(2)"E m.m^R_Skip_to_Character'"# m.m^R_Zap_to_Character' u0
				    !* get skip or zap routine!
  q:2(1)"L 0-Q1 U1'		    !* If last arg was neg, reverse!
  Q1u:2(1)			    !* save sense!
  q:2(0),q1 :M0			    !* go execute the appropriate code!
 