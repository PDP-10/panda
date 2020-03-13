!* -*-TECO-*- *!

!~FILENAME~:! !Commands to use Heath keypad!
HEATH2

!& Setup HEATH2 Library:! !S Sets up heath keypad.
Makes the obvious assignments to the arrows, less obvious
ones to everything else.  ESC becomes a prefix character,
with dispatch in .Y; ESC ? becomes another prefix character,
with dispatch in .Z.  Q.P gets a modified Prefix driver to
make this all work.  If $HEATH2 Setup Hook$ is defined, it is run
afterwards to make any additional assignments or changes; it can
access the function Set Heath Key (q.v.) by running MS, e.g.
<number>MS<function>!

  @:i*|=u| FS Image Out	    !* set alt keypad mode, unshifted!
  128M(m.mMake_Prefix_Char).Y U   !* Make Escape a long prefix char!
				       !* in .Y (it will distinguish case)!
  M(m.mMake_Prefix_Char).Z U:.Y(?)	    !* Second dispatch table for!
					    !* Escape ? in .Z!
  M(m.mMake_Prefix_Char).Z U:.Y(O)	    !* Second dispatch table for!
					    !* Escape O (ansi prefix) in .Z!
  m.m&_Heath_Prefix_Character_Driver U.P   !* revised driver in .P!
  M(m.m&_Load_Bare)		    !* to get primitives!

  m.mSet_Heath_Key[S		    !* MS now runs assignment routine!

  2MS ^R_Down_Real_Line         !* 2 !
 12MS ^R_Forward_Paragraph      !* Shift-2 !
  4MS ^R_Backward_Character     !* 4 !
 14MS ^R_Backward_Word          !* Shift-4 !
  6MS ^R_Forward_Character      !* 6 !
 16MS ^R_Forward_Word           !* Shift-6 !
  8MS ^R_Up_Real_Line           !* 8 !
 18MS ^R_Backward_Paragraph     !* Shift-8 !
  0MS ^R_Goto_Beginning         !* 0 !
 10MS ^R_Extended_Command       !* . !
 20MS ^R_Goto_End               !* enter !
  1MS ^R_Backward_Delete_Character !* 1 !
 11MS ^R_Backward_Kill_Word     !* Shift-1 !
  3MS ^R_Delete_Character       !* 3 !
 13MS ^R_Kill_Word              !* Shift-3 !
  5MS ^R_Next_Screen            !* 5 !
 15MS ^R_Previous_Screen        !* Shift-5 !
  7MS ^R_Reverse_Skip           !* 7 !
 17MS ^R_Reverse_Zap_to_Character  !* Shift-7 !
  9MS ^R_Skip_to_Character      !* 9 !
 19MS ^R_Zap_to_Character       !* Shift-9 !
 21MS ^R_Prefix_Meta		 !* put this here for tv compatibility!
 22MS ^R_Set/Pop_Mark		 !* set/pop mark on f2!
 23MS ^R_Narrow_Bounds_to_Region !* f3 !
 24MS ^R_Widen_Bounds           !* f4 !
 25MS ^R_Indent_Rigidly         !* f5 !
 26MS ^R_Kill_Region	         !* Kill region on (ERASE)!
 27MS ^R_Other_Window           !* Blue !
 28MS ^R_Query_Replace          !* Red !
 29MS ^R_Fill_Paragraph         !* White !
 30MS ^R_Copy_Region            !* Copy region on (shift ERASE)!

				    !* set up state vector for skip/zap!
    35FS Q Vector[1		    !* get a 7-elt q-vector!
    :i*Skip_to:_ U:1(3)	    !* install prompts now so we don't!
    :i*Skip_back_to:_ U:1(4)	    !* cons up strings later!
    :i*Zap_to:_ U:1(5)
    :i*Zap_back_to:_ U:1(6)
    Q1 M.VSkip/Zap_State_Vector    !* And define the state variable!
    ]1

  0FO..QHEATH2_Setup_HookF"N [1 M1' !* run user hook if any!
  0

!& Heath Prefix Character Driver:! !S M.P for Heath: handles prefix character.
Given a q-vector as argument, it reads a character
and returns the q-vector element it selects.
Difference between this and standard is that ? is not treated as help.
The character read is left in Q..1.!

  [0 0F[ Help Mac		    !* Intercept HELP!
  -Q.X"E M.I'			    !* only do expensive waiting for ^X!
  FI U0				    !* Get the subcommand character!
  FQ()-640"L Q0 :FC U0'	    !* uppercase the char if dispatch!
				    !* table is short!
  F] Help Mac
  Q0-4110."N
    Q0U..1			    !* If char is not Help, put into Q..1.!
    Q:()(Q0) F"E Q:()(Q0:FC) F"E W :I* FG'''
				    !* Index into qvector.  If slot is 0,!
				    !* first try uppercasing, else!
				    !* return command to ring bell.!
  FS ^R LASTU0			    !* HELP gives documentation for prefix.!
  Q0,(Q0 @FS ^R CMAC) M(M.M &_Prefix_Describe)
  :I*0_			    !* and return a no-op!

!Set Heath Key:! !C Assigns a function to a Heath special key.
For best results, use ^R Instant Extended Command to invoke this.
String Argument is name of function to assign.
You will be prompted to type the key to put the function on.

Alternatively, if you are calling this from your init file, you can pass
the key as a numeric arg.  In this case, the keys are coded as follows:

  0-9  unshifted keypad digits
 10    period
 11-19 shifted keypad digits (can't shift zero)
 20    ENTER (can't shift this, either)
 21-29 the 9 keys across the top (f1-f5, ERASE, blue,red,gray)
 30    Shift-ERASE.

You may also pass the function DEFINITION as a pre-comma arg, instead of
passing the function NAME as a string arg.!

  FF-1"G [2 [1'		    !* pre-comma arg is function def!
    "# 9,fFunction:_ [1	    !* else get name of desired fn in 1!
       m.m1 [2'		    !* and its definition is in 2!
  FF&1"N			    !* getting key as a numeric arg!
    -10"L Q2 U:.Z(+P)	    !* 0-9 ==> Esc ? P thru Y!
            Q2 U:.Y(+p) 0'    !* also on Esc p thru y for faulty modems!
    -10"E Q2 U:.Z(N)	    !* 10 ==> Esc ? N (period)!
            Q2 U:.Y(n) 0'
    -20"E Q2 U:.Z(M)	    !* 20 ==> Esc ? M (ENTER)!
            Q2 U:.Y(m) 0'
    -11:G(:i*LBMDHC@AN_STUVWJPQRE)[3	    !* Select char for Esc .. from arg!
    Q2 U:.Y(Q3)			    !* Put function on appropriate Esc char!
    0'
  Q2 M(m.m&_Macro_Name) U1	    !* get full name of fn in 1!
  @FT Put_1_on_special_key:_	    !* prompt for key!
  :i* M.I			    !* prepare (so Help works), but no prompt!
  FI-33."N :i*Not_a_special_key FS Err'   !* first part of key should be Esc!
  FI U1				    !* get next char in q1!
  Q1-?"E FI U1		    !* Esc ? gets yet another char!
     Q2 U:.Z(Q1:FC)	       !* Assign to the uppercase Esc ? dispatch table!
     Q2 U:.Y(Q1) 0'		    !* and the lowercase Esc table!
  Q2 U:.Y(Q1) 0		    !* put function in the Esc dispatch!

!^R Top of Screen:! !^R Move cursor to top of screen.
With negative arg goes to bottom!

!* the next few functions are from TVLIB !

  "L-1'"#0':M(m.m^R_Move_to_Screen_Edge)

!^R Bottom of Screen:! !^R Move cursor to bottom of screen.!

  -1:M(m.m^R_Move_to_Screen_Edge)

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
