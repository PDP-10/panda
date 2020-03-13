!* -*-TECO-*- *!

!~FILENAME~:! !Commands to use Ambassador keypad!
AMBASSADOR

!& Setup Ambassador Library:! !S Sets up Ambassador keypad.
Makes the obvious assignments to the arrows, less obvious
ones to everything else.  ESC becomes a prefix character, with
dispatch in .Y; ESC [ becomes another prefix character,
with dispatch in .Z; ESC O becomes another prefix character with
dispatch in .D.  Q.P gets a modified Prefix driver to make
this all work.  If $Ambassador Setup Hook$ is defined, it is run
afterwards to make any additional assignments or changes; it can
access the function Set Ambassador Key (q.v.) by running MS, e.g.
<number>MS<function> .  This function also reprograms some keys.
Some default sequences are reprogrammed to help eliminate ambiguity.  Note
that this will wipe out any sequence which may have been on the key to
start with.  New sequences will be put on the PERIOD, 0, and ENTER
keys on the keypad; the SEND key (in simultaneous mode only); and the
shifted and unshifted MOVE UP and MOVE DOWN keys (though the controllified 
sequences used for 'zooming' are still standard).!

  @:i*|[>27;52h| FS Image Out     !* pause=>Meta key,set shifted keypad!
  1fs tty fci			    !* and tell emacs we have a meta key !
  @:i*/P`:~[[E`0~[[F`<~[[G`"~[[I`,~[[T|~[[V|~[[S|~[[U\/ FS Image Out
				    !* place the sequences on keys as follows !
				    !* PERIOD (keypad) <== <ESC> [ E!
				    !* 0 (keypad)      <== <ESC> [ F!
				    !* ENTER (keypad)  <== <ESC> [ G!
				    !* SEND (simul)    <== <ESC> [ I!
				    !* MOVE UP         <== <ESC> [ T!
				    !* shifted MOVE UP <== <ESC> [ V!
				    !* MOVE DOWN       <== <ESC> [ S!
				    !* shifted MOVE DN <== <ESC> [ U!

  128M(m.mMake_Prefix_Char).Y U   !* Make Escape a long prefix char!
				       !* in .Y (it will distinguish case)!
  128M(m.mMake_Prefix_Char).Z U:.Y([)   !* Second dispatch table for!
					    !* Escape [ in .Z!
  M(m.mMake_Prefix_Char).D U:.Y(O)      !* Third dispatch table for!
                                            !* Escape O in .D!
  m.m&_Ambass_Prefix_Character_Driver U.P  !* revised driver in .P!
  M(m.m&_Load_Bare)		  	    !* to get primitives!

  m.mSet_Ambassador_Key[S		    !* MS now runs assignment routine!

  1MS ^R_Info                   !* PF1  for XEDIT compatibility !
  3MS Push_to_Exec              !* PF3  for XEDIT compatibility !
 10MS ^R_Reverse_Skip           !* PF10 !
 22MS ^R_Reverse_Zap_to_Character  !* shift PF10 !
 11MS ^R_Repeat_Skip/Zap        !* PF11 !
 12MS ^R_Skip_to_Character      !* PF12 !
 24MS ^R_Zap_to_Character       !* shift PF12 !
 25MS ^R_Kill_Region	         !* ERASE !            
 26MS ^R_Other_Window           !* EDIT !
 27MS Auto_Fill_Mode            !* DELETE !
 28MS Overwrite_Mode            !* INSERT !
 31MS ^R_Top_of_Screen          !* 1 !
 32MS ^R_Down_Real_Line         !* 2 !
 33MS ^R_Bottom_of_Screen       !* 3 !
 34MS ^R_Backward_Character     !* 4 !
 35MS ^R_Next_Screen            !* 5 !
 36MS ^R_Forward_Character      !* 6 !
 37MS ^R_Beginning_of_Line      !* 7 !
 38MS ^R_Up_Real_Line           !* 8 !
 39MS ^R_End_of_Line		 !* 9 !
 40MS ^R_Goto_Beginning         !* period !
 41MS ^R_Previous_Screen        !* 0 !
 42MS ^R_Goto_End               !* ENTER !
 43MS ^R_Backward_Word          !* MOVE UP !
 45MS ^R_Backward_Kill_Word     !* shift MOVE UP !
 44MS ^R_Forward_Word           !* MOVE DOWN !
 46MS ^R_Kill_Word              !* shift MOVE DOWN !

				    !* set up state vector for skip/zap!
    35FS Q Vector[1		    !* get a 7-elt q-vector!
    :i*Skip_to:_ U:1(3)	    !* install prompts now so we don't!
    :i*Skip_back_to:_ U:1(4)	    !* cons up strings later!
    :i*Zap_to:_ U:1(5)
    :i*Zap_back_to:_ U:1(6)
    Q1 M.VSkip/Zap_State_Vector    !* And define the state variable!
    ]1

  0FO..QAmbassador_Setup_HookF"N [1 M1' !* run user hook if any!
  0

!& Ambass Prefix Character Driver:! !S M.P for Ambass: handles prefix chars.
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

!Set Ambassador Key:! !C Assigns a function to an Ambassador special key.
For best results, use ^R Instant Extended Command to invoke this.
String Argument is name of function to assign.
You will be prompted to type the key to put the function on.

Alternatively, if you are calling this from your init file, you can pass
the key as a numeric arg.  In this case, the keys are coded as follows:

1-12   ==> PF1 thru PF12
13-24  ==> shift-PF1 thru shift-PF12
25-30  ==> ERASE thru SEND (along top row)
31-39  ==> keypad 1 thru keypad 9
40-42  ==> keypad . thru keypad ENTER (bottom row of keypad)
43     ==> MOVE UP
44     ==> MOVE DOWN
45     ==> shift MOVE UP
46     ==> shift MOVE DOWN
47-49  ==> shift ERASE, shift DELETE (red), shift INSERT respectively

You may also pass the function DEFINITION as a pre-comma arg, instead of
passing the function NAME as a string arg.!

  FF-1"G [2 [1'		    !* pre-comma arg is function def!
    "# 9,fFunction:_ [1	    !* else get name of desired fn in 1!
       m.m1 [2'		    !* and its definition is in 2!
  FF&1"N			    !* getting key as a numeric arg!
    -25"L Q2 U:.D(-1+A)       !* 1-24 ==> ESC O A-X!
            Q2 U:.Y(-1+a) 0'  !* also on ESC a-x for faulty modems!
    -26"E Q2 U:.Y(6) 0'       !* 26 ==> ESC 6 (EDIT)!
    -31"E Q2 U:.Y(F) 0'       !* 31 ==> ESC F (keypad 1)!
    -33"E Q2 U:.Y(G) 0'       !* 33 ==> ESC G (keypad 3)!
    -39"E Q2 U:.Y(H) 0'       !* 39 ==> ESC H (keypad 9)!
    -25:G(:i*K_P@iI_B_DHCgA_EFGTSVUJML)[3  !* Select char for ESC [ .. !
    Q2 U:.Z(Q3)                     !* and put function on correct ESC [ char!
    0'
  Q2 M(m.m&_Macro_Name) U1	    !* get full name of fn in 1!
  @FT Put_1_on_special_key:_	    !* prompt for key!
  :i* M.I			    !* prepare (so Help works), but no prompt!
  FI-33."N :i*Not_a_special_key FS Err'   !* first part of key should be Esc!
  FI U1				    !* get next char in q1!
  Q1-O"E FI U1		    !* Esc O gets yet another char!
     Q2 U:.D(Q1:FC)	       !* Assign to the uppercase Esc O dispatch table!
     Q2 U:.Y(Q1 FC) 0'	    !* and the lowercase Esc table!
  Q1-["E FI U1                    !* ESC [ needs another char, too!
     Q2 U:.Z(Q1) 0'               !* put it in the ESC [ table as is!
  Q2 U:.Y(Q1) 0		    !* put function in the Esc dispatch!

!^R Top of Screen:! !^R Move cursor to top of screen.	    
With negative arg goes to bottom!

!* the next few functions are from TVLIB !
!* and are direct from Heath2.emacs !

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
   