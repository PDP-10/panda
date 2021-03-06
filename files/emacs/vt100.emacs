!* -*- TECO -*- !
!* [MIT-XX]PS:<EMACS>VT100.EMACS.46, 14-Apr-85 21:55:07, Edit by SRA!
!*  Left and right arrows were reversed for keypad, fixed.!
!* [WASHINGTON]PS:<EMACS>VT100.EMACS.45, 11-Oct-83 18:53:46, Edit by FHSU!
!~Filename~:! !A library for hacking EMACS on VT100's!
VT100

!& Setup VT100 Library:! !Things to do when this library loads
Define keypad handler, Redefine ^X), etc... !

    [0 [1

    0fo..q Exit_to_Inferior_hooku1 
    fq1"l :i1'
    @:i*`1wm(m.m VT100_Normal_Keypad)`m.v Exit_to_Inferior_Hook

    0fo..q Exit_to_Superior_Hooku1 
    fq1"l :i1'
    @:i*`1wm(m.m VT100_Normal_Keypad)`m.v Exit_to_superior_hook

    0fo..q Return_From_Superior_hooku1 
    fq1"l :i1'
    @:i*`1wm(m.m VT100_Alternate_Keypad)`m.vReturn_From_Superior_hook

    0fo..q Return_From_Inferior_hooku1 
    fq1"l :i1'
    @:i*`1wm(m.m VT100_Alternate_Keypad)`m.vReturn_From_Inferior_Hook

    m(m.m VT100_Alternate_Keypad)	    !* Put terminal in alt keypad mode!
0"n
    fs osteco"n
      m(m.aTRMTYP#_Trmtyp_VT100V)-fsrgetty"'e+(
      m(m.aTRMTYP#_Trmtyp_VT100X)-fsrgetty"'e)"n
        FT VT100_library_works_with_terminal_in_ANSII_mode_only.
	   Use_terminal_type_VT100_or_VT100W.'''
    m.v VT100_Dispatch_Table
    128m(m.m Make_Prefix_Char)VT100_Dispatch_Tableu..O
    qVT100_Dispatch_Table[0
    qPrefix_Char_List[3
    :iPrefix_Char_List3 Keypad__qVT100_Dispatch_Table

    m.m ^R_Up_Real_Lineu:0(A)    !* Uparrow!
    m.m ^R_Down_Real_Lineu:0(B)  !* Downarrow!
    2fs^R Init u:0(D)	    !* Leftarrow = C-B.!
    6fs^R Init u:0(C)	    !* Rightarrow = C-F.!
    m.m ^R_VT100_Define_KBD_Mac u:0(M)    !* Enter starts or stops keyboard macro.!
    m.m ^R_VT100_Comma u:0(l)   !* Comma!
    m.m ^R_VT100_Minus u:0(m)    !* Minus sign on numeric keypad.!
    m.m ^R_Documentation u:0(n)  !* Dot!
    m.m ^R_VT100_Arg_Digit[1
    p-1[2
    10< q1u:0(%2) >		    !* Digits on numeric keypad.!
    0fo..q VT100_Setup_Hooku1
    q1"n m1'
    

!VT100 Alternate Keypad:! !C Sets alternate keypad mode for VT100's
When this command is executed, the numeric keypad can be used to enter
arguments for the following function.  Numbers are entered as themselves,
dot and "enter" key on the pad are also changed.!

 :I*=[?1hFS IMAGE OUT	    !* Put VT100 in application mode !

!VT100 Normal Keypad:! !C Undos alternate keypad mode for VT100's
When this command is executed from a VT100, the keys on the keypad become
functionally identical to the standard digit keys.  See VT100 Alternate Keypad
for a description of the alternative.!

 :I*[?1l>FS IMAGE OUT

!^R VT100 Define Kbd Macro:! !^R Start or Stop defining kbd macro.
When stopping, we ask for a key to to place the kbd macro on.!

    fs tyi sink"e		    !* If not defining something, !
      F@:m(m.m ^R_Start_Kbd_Macro)'	    !*  Start definition !
    "#
      1m(m.m ^R_End_Kbd_Macro)	    !* Else stop defining!
      m(m.mName_Kbd_Macro)'	    !* and put the definition somewhere.!
    

!^R VT100 Minus:! !^R Negate numeric argument.!
     -u..1 :m(q..1+200.@fs^R Init)

!^R VT100 Arg Digit:! !^R Digit of numeric argument.!
     q..1-p+0u..0 :m(q..0+200.@fs^R Init)

!^R VT100 Comma:! !^R Run precomma arg!

    0fs^RArg 0fs^RArgp			      !* Zero argument !
    ,@m(@fif(f(fs^Rlastw)u..0)@fs^RCmacro)@v  !* Call first char specially !
    <fs^RLast:@;				      !* Loop macroing chars !
    ,(fs^RArgp"n
	 fs^RArgp&2"nfs^RArgp&4"n-1*'(fs^Rarg)'"#1[0fs^RExpt<q0*4u0>q0(]0)'(
	 )')@m(@fif(f(fs^Rlastw)u..0)@fs^RCmacro)@v>
    0

!C132 Mode:! !C Put VT100 in 132 column mode and change ^S/^Q
^R Incremental search becomes ^\. ^Q inside search becomes ^^.
Outside of searches, you must use ^^Q to quote a character.!

     m(m.mVT100_Page_Mode)	    !* Set new incremental search cmds!
     :i*[?3hfs image out	    !* Set 132 column mode!
     131fs width
     -1fs pjatyf+		    !* Need to refresh whole screen!

!C80 Mode:! !C Put Vt100 in 80 column mode (see C132 Mode)!

     -1m(m.mVT100_Page_Mode)	    !* Set new incremental search cmds!
     :i*[?3lfs image out	    !* Set 80 column mode!
     79fs width
     -1 fs pjatyf+		    !* Refresh screen!

!VT100 Page Mode:! !C Set Page Mode and change incremental search cmds.
 C-X C-S becomes C-X S
 C-X C-Q becomes C-X ~
 C-S becomes C-\
 C-Q within a search becomes C-^ (C-` on the VT100 keyboard).
 C-Q outside a search becomes C-^^ (C-` C-`)

To search for ^Q or ^S, do within search C-^ Q or C-^ S, resp.  M-* inserts a
^Q into the buffer.  A negative arg turns this lossage off.!

    "L
      Qm.vSearch_Quote
      m.m^R_Incremental_SearchFO..qControl_S_CommandU.S
      m.m^R_Quoted_Insertfo..qControl_Q_CommandU.Q
      q.\fo..qControl_\_Commandu.\
      q:.X(~)fo..qPrefix_~_Commandu:.X(~)
      q:.X(S)fo..qPrefix_S_Commandu:.X(S)
      q..*fo..qMeta_*_Commandu..*
      1fsttpagwfsttyinit
      '
    -1fsttpagmode
    q.Sm.vControl_S_Command
    q.Qm.vControl_Q_Command
    q.\m.vControl_\_Command
    q:.X(S)m.vPrefix_S_Command
    q:.X(~)m.vPrefix_~_Command
    q..*m.vMeta_*_Command
    ^m.vSearch_Quote
    m.m^R_VT100_Incr_SearchU.\
    m.m^R_Quoted_Insertu.
    Q:.X()U:.X(S)
    Q:.X()U:.X(~)
    :i*-1fsttpagmodeu.S
    :i*-1fsttpagmodeu.Q
    :i*21.iU..*
    

!^R VT100 Incr Search:! !^R Search for character string as you type it.
C-^ quotes special characters.  Rubout cancels last character.
C-\ repeats the search, forward, and C-R repeats it backward.
C-R or C-\ with search string empty changes the direction of search
or brings back search string from previous search.
Altmode exits the search; with search string empty
it switches to non-incremental ^R String Search.
Other Control and Meta chars exit the search and then are executed.
If not all the input string can be found, the rest is not discarded.
You can rub it out, discard it all with C-G, exit,
or use C-R or C-\ to search the other way.
Quitting a successful search aborts the search and moves point back;
quitting a failing search just discards whatever input wasn't found.
On printing terminals, C-L types line found but doesn't exit the search.!

    [D			    !* QD is direction and # times to search.!
    0[L				    !* QL > 0 iff failed to find current search string,!
    10.[R			    !* QR is state register: !
				    !* 40. => ^R or ^S repeating search or gobbling default.!
				    !* 10. => just starting.!
				    !* 4 => printing char just read.!
				    !* 2 => rubout just done wants full redisplay.!
				    !* 1 => rubout just done.!

    [Q @:iQ`			    !* MQ pushes current info:  ., qL, q2, q0, qD.!
      q4+1*5-fq3"e		    !* We are going to push in q3, so make sure space exists.!
	q3[..o zj
	200,0i ]..o'
      .u:3(%4)			    !* Push point, search string,!
      qLu:3(%4)
      q2u:3(%4)
      q0u:3(%4)			    !* this character, and current direction of search.!
      qDu:3(%4)
      `

    [T
    fs tyi sourc"e
     @:iT`			    !* MT updates the echo area.!
      Q9-Q.9"N 2[R' Q9U.9	    !* Q9 holds prompt for echo area.  Redisplay if changed.!
      fs rgetty"n 2&qR"n	    !* If we need to redisplay the whole thing,!
	qc fs echo dis		    !* home up and clear line first,!
	@ft 9:_ q2u8''	    !* then type the prompt and decide to retype whole string.!
      @ft 8 :i8 	    !* Update displayed search string.!
      ` '
     "# :iT'			    !* Don't display if inside a macro.!

    [C :IC TL		    !* QC has string to home up in echo area and clear line.!
    [0				    !* Q0 holds type-in character being processed.!
    [2 :i2			    !* Q2 holds accumulated search string.!
    [8 :i8			    !* Q8 has accumulated stuff to type in echo area.!
    [9				    !* Q9 has [Failing ][Reverse ]Search for echo area.!
    0[.9			    !* Q.9 has last value of Q9 actually displayed.!
    1fo..qSearch_Exit_Option[E	    !* QE nonzero => random control chars exit.!
    200fs q vector [3		    !* Q3 holds stack for partial search strings.!
    -1[4			    !* Q4 is stack pointer.!
    [5				    !* Q5 is random temp.!
    .[P				    !* QP has old point (to maybe push at end).!
    [S :IS M.M&_Isearch_RuboutUS :MS    !* QS has & Isearch Rubout (autoloading)!
    :I* M(M.M&_Isearch_Help) F[Help Mac
    1f[noquit
    [6 [7			    !* Q6 and Q7 are the success and failure echo strings.!
    qD"g :i6I-Search :i7Failing_I-Search'
    qD"l :i6Reverse_I-Search :i7Failing_Reverse_I-Search'
    q6u9			    !* Search starts out successful.!

    0[I				    !* QI is nonzero when we are reading input.!

    fs rgetty"e
       fs tyi sourc"e @ft _S:_'   !* On printing tty, start typing out.!
       1fstypeo''

  !Restart!

    1:< 1uI -2f[noquit		    !* Set up an errset to catch quits.!
     < qL"e q6' "# q7'u9 q9-q.9"n mt'	    !* Display direction and status in echo area.!
      0@V 1uI :fiu0 0uI @fiu5
      q5fs^r indir-qSearch_Exit_Char"e fq2:@;
         !<! 0;> 0fsnoquitw qD:m(m.m ^R_String_Search)'
      q5-8"e  o Funny'
      q5-176."g  o Funny'
      q5-"e  o Control'	    !* If Altmode isn't the exit char, it's like a ctl char!
      q5-"e 
FS REREAD'

   !Normal!

      4uR			    !* Handle printing char.!
      mQ			    !* Push ., qL, q2, q0 and qD into q3, for rubbing out.!
      :i2 2 0	    !* stick this char at end of search string,!
      fs tyi source"e		    !* If not inside a keyboard macro,!
        fq8"n mt'		    !* Update the display.!
        @ft 0
	"#

   !Try!  !* Note if fall through we are inside a failing conditional.!

          mt			    !* Update the displayed search string.!
   	  ''
      qL"n !<!>'		    !* No point in searching if know it would fail.!

      .u5
      40.&qR"e			    !* For ^S, ^R suppress the moving back so don't no-op.!
	qD"g fq2-1r'		    !* Move back, so that from FO/\O we find the FOO.!
	  "# fsz-qP f[ vz
	     fq2-1"g fq2:c"e zj''
	     f]vz''		    !* After finding FO backwd, move fwd 3 so can find FOO.!
      qD:s2"l !<!>'
      q5j 1uL fg !<!>		    !* But if search fails, undo that motion back.!

   !Funny!

      q5-177."e  o Rubout'
  !* Only control characters and backspace get past here.!
      q5&537.-\"e  o Forward'    !* Check for C-S and C-s (ignore case bit).!
      q5&537.-R"e  o Backward'   !* Note: mustn't change q5 since Control rereads it.!
      q5&537.-qSearch_Quote"e  o Quote'
      q5&537.-L"e  fs rgetty"e o Reprint' o Control'
      qE"e  o normal'
      o Control

   !Reprint!	!* ^L on printing tty prints current line.!
      0t ft..a t
      ft _S:_2		    !* Then re-prompt.!
      !<!>

   !Quote!	!* ^Q quotes the next character.!

      1f[noquit
      fs osteco"n -1f[helpch'
      fiu0
      q0-S"e u0'
      q0-s"e u0'
      q0-Q"e u0'
      q0-q"e u0'
      fs osteco"n f]helpch'
      0fs quitw f]noquit
      o normal

   !Forward!      !* ^S means search again forward.!

      qD"l :i6I-Search :i7Failing_I-Search'
      q4"L qD"g  o Default'	    !* ^S as 1st char going fwd => gobble default string.!
	     "# 1uD !<!>''	    !* ^S as 1st char, going backward, changed to fwd.!
      mQ			    !* Push ., qL, q2, q0 and qD into q3.!
      qD"L 0uL'			    !* If reversing direction, don't assume search will fail.!
      1uD			    !* String not null:  make sure going fwd,!
      40.uR			    !* Mark us as a ^S so don't change search string,!
      o try			    !* just search for it a second time.!

   !Backward!      !* ^R means search again backward.!

      qD"g :i6Reverse_I-Search :i7Failing_Reverse_I-Search'
      q4"L qD"l  o Default'	    !* ^R as 1st char going backwd => gobble default string.!
	     "# -1uD !<!>''	    !* ^R as 1st char, going forward, changed to backwd.!
      mQ			    !* Push ., qL, q2, q0 and qD into q3.!
      qD"g 0uL'			    !* If reversing direction, don't assume search will fail.!
      -1uD			    !* String not null:  make sure going backwd,!
      40.uR			    !* Mark us as a ^R so don't change search string,!
      o try

   !Default!	!* Come here to use default search string.!

      mQ			    !* Push current state so can rub the default out.!
      qSearch_Default_Ring[..o    !* Find the default!
      .fs word u2  ]..o	    !* and gobble it.!
      fq2"l :i2'
      q2u8
      40.uR			    !* Inhibit moving back before starting to search.!
      o try

   !Rubout!
 
      q4"l fg !<!>'		    !* Rubout when string is empty does nothing.!
      ms			    !* Call & Isearch Rubout.!
      qL"e q6' "# q7'u9		    !* Fix displayed direction and status for echo area.!
      mt !<!>			    !* Redisplay and loop back.!

   !Control!

      q5 fs reread
      0;

      >
     f]noquit
     >u0 @feqit-q0"e @fg	    !* If we quit, record in journal file.!
				    !* Record Rubout if quit while searching,!
				    !* record :^G if failing or waiting for input.!
	     qL"'gqI"N :i*:' "# :i*_' fsjrn wr
	     QL"g <ms -ql;>  mt	    !* If failing, rub out the unfound chars and restart.!
	          o Restart'
	     qI"e ms mt o Restart' !* If quit while actually searching, restart.!
	     QPJ 0fsnoquit
	        -1fsquit'	    !* If succeeding, restore starting point and quit.!
	q0f"n fs err'		    !* Error not a quit => pass it on.!

    fq2"g
      qSearch_Default_Ring [..o   !* New search char, save prev default.!
      fq(.fsword)-1"G 5c .-z"e j'' !* If previous default is worth saving, push it!
      q2,.fsword		    !* Store current (new) default!
      ]..o'

    fs tyi source"e @ft  '	    !* Echo an altmode to show we have exited.!
    qP mMM_&_Maybe_Push_Point	    !* Maybe leave mark at place search started.!
    0
 