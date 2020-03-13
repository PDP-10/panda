!* -*-TECO-*-	This library implements EMACS PASCAL MODE.!

!~FILENAME~:! !Package for editing Pascal code (Pascal Mode).
See the info node EPASC (DIR/EMACS/PASCAL) for more details.!
PASCAL

!& Setup PASCAL Library:! !S Initialize data structures of the mode!

0FO..qPascal_Loaded"E		    !* If we haven't done this setup already,!

    !** Set up the dispatch key!
    0m.v Insert_Dispatch
    m(m.mMake_Prefix_Character)Insert_Dispatch(
     )M.V MM_^R_Pascal_Insert_Statement    !* Set up for prefix!

    QPrefix_Char_List[0	    !* Put docmentation on prefix!
    :I*0C-M-.__QInsert_Dispatch 
UPrefix_Char_List

    !** Read in the keyword table (syntax table)!
    m(m.m &_Read_Keywords)

    !** Compile indentation customization variables!
    m(m.m &_Setup_Variables)

    !** Initializations for ErrList mode!
    [1[2

    m.vPascal_Compile_Command	    !* Set up ErrList's compile command!
    @:iPascal_Compile_Command|
       FS D FN1[5 FS D FN2[6 QCompiler_Switches:F"Lw:i*'[4
       F+
       0FZ_do_emacs:pascal.mic_5,6,4
       
       0FO..qAfter_Compilation_Hook[7
       Q7"N M7'"# 0U..H -1FSPJATY'
       |

    M.V Error_Vector		 !* Know we have these variables.!
    M.V Num_Errors
    M.V Error_Index

    M.V Old_After_Compilation_Hook
    M.V Old_Compiler_Switches
    M.V Old_Compiler_Filename
    M.V Old_Compile_Command

    !** It is necessary to have these variables created, because if they
     are created within the change hook of a variable, strange things
     happen.!
    0FO..qAfter_Compilation_HookM.VAfter_Compilation_Hook
    0FO..qCompiler_SwitchesM.VCompiler_Switches
    0FO..qCompile_CommandM.VCompile_Command

   !* Set up to say "ErrList" in mode line.!

       !* Inserts " ErrList", and passes along any given string (old style!
       !* hooks accumulated a string of mode line things instead of!
       !* inserting). !

    @:i1|(
    0fo..qErrList_Mode"n		    !* In ErrList Mode,!
	 i_ErrList'		    !* so put that into mode line.!
       )|				    !* End of our SML hook.!

    0fo..qSet_Mode_Line_Hooku2	    !* 2: Old SML hook.!
    q2"e q1'"# :i*21'm.vSet_Mode_Line_Hookw
				       !* Install our SML hook if none!
				       !* previous, otherwise append to!
				       !* SML hook.!


    0FO..qErrList_ModeU1		 !* Make ErrList mode, guaranteeing !
    0M.VErrList_Mode		 !* that the proper setup will be done. !
    m.cErrList_Mode! *_(Pascal)_Save_compiler_errors_when_running_M-X_Compile!
      "N QErrList_Mode"E M(M.M&_In_ErrList_Mode) 1FS_Mode_Change''
	"# QErrList_Mode"N M(M.M&_Out_ErrList_Mode) 1FS_Mode_Change''
    Q1UErrList_Mode

    1M.V Pascal_Loaded		    !* Say we have done this stuff!
 '
 


!PASCAL Mode:! !C Set up for editing PASCAL code.  
Pascal mode is fully documented in the info node Pascal under Emacs.
"(* " and " *)" become comment delimiters.
Calls user-providable macro, PASCAL Mode Hook, which can put pascal
functions into desired keys.  If no hook exits, calls & Default Init PASCAL
Mode.  See the description of that subr for more details on what it does and
how to construct your own.  The suggestion is that your PASCAL Mode Hook call
& Default Init PASCAL Mode then change anything you want different.!

 m(m.m_&_Init_Buffer_Locals)	 !* Discard locals of old mode, and set: !
				 !* .Q: Make Local Q-Reg. !
 1,(:I*(*)M.L Comment_Startw	 !* Comment start... !
 1,(:I*(*_)M.L Comment_Beginw	 !* begin... !
 1,(:I*_*))M.L Comment_Endw	 !* And comment end. !

 1,(:I*)M.L Last_Pascal_Indenterw !* Initialize last indenter to null!
 1,0M.L Last_Pascal_Indent_Posw    !* And position as null!

 0@fo..q PASCAL_..D[d		    !* Set up character syntax table!

 QD"E
:iD________________________________________________________________________________________________________________________________________A_____________________________A___AA____A___AA___AA____A____|____(____)(___A____A_________A____A____A___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____A____A____A____A____A____A____A___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____(____A____)[___A___AA____A___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____(____A____){___A________
       qDM.V PASCAL_..D'

 qDm.q..D			 !* Set it up on a permanent basis !

 1,1M.LCompiler_Filename	 !* Say we compile with EXECUTE !

 0@fo..q PASCAL_Mode_Hook"e 	 !* no hook !
	m(m.m&_Default_Init_PASCAL_Mode)' !* ...so use default one. !


 1M(M.M&_Set_Mode_Line)PASCAL	 !* Set, display mode.  Run mode hook. !
 

!& Default Init PASCAL Mode:! !C Default setup for PASCAL mode.
It sets up the following characters for this mode and buffer:
    RUBOUT	Tab-hacking rubout
    C-RUBOUT	Normal rubout
    LINEFEED	Insert CR and do ^R Indent Pascal Stmt

See Pascal info node (file INFO:EPASC, node DIR/EMACS/PASCAL) for
description of other key settings.
Turns on Auto Fill if Pascal Auto Fill Default is non-0.!

 !* Set up local ^R keys: !

 1,0m.LCOMMENT_COLUMNw		 !* Set comment column !
 1,:i*+1m.lcomment_roundingw	 !* and rounding for end of line !
 1,q(1,q. m.Qw)m.Q.	 !* Exchange rubout flavors. !
 1,(m.mCompile)m.q...,
 1,(m.m^R_Indent_Pascal_Stmt)m.q...I    !* Indent line is on C-M-I !
 1,(m.m^R_Pascal_New_Line)m.q
	 !* LF still works, though !
 1,(m.mPrint_Last_Pascal_Indenter)m.q...? !* C-M-? For tracing. !
 1,(m.m^R_Slurp_Pascal_To_Char)m.q...{
 1,(m.m^R_Plus_One)m.q...+
 1,(m.m^R_Start_String)m.q...'
 1,(m.m^R_Next_Error)m.q...E
 1,(m.m^R_Insert_Comment)m.q...*
 1,(m.mForward_Level)m.q...N
 1,(m.mBack_Level)m.q...P
 1,(m.mMark_Procedure)m.q...H
 1,(m.mIndent_Pascal_Region) m.q...G
     Q...G m.q..G
     Q...G m.q...\
 1,(m.mSame_Capitalization)m.q...C
 1,(m.mGlobal_Pascal_Comment)m.q...$
 1,(m.mNo_Comment_Search)m.q...S
 1,(m.m^R_Pascal_Insert_Statement)m.q....

 !* Set up the insert commands!
 QInsert_Dispatch[R
 M.M^R_Pascal_ENDU:R(E)
 M.M^R_Pascal_WHILEU:R(W)
 M.M^R_Pascal_FORU:R(F)
 M.M^R_Pascal_WITHU:R()
 M.M^R_Pascal_IFU:R(I)
 M.M^R_Pascal_ELSEU:R()
 M.M^R_Pascal_PROCEDUREU:R(P)
 M.M^R_Pascal_FUNCTIONU:R()
 M.M^R_Pascal_PROGRAMU:R()
 M.M^R_Pascal_REPEATU:R(R)
 M.M^R_Pascal_BEGINU:R(B)
 M.M^R_Pascal_CASEU:R(C)
 M.M^R_Pascal_RECORDU:R()
 M.M^R_Pascal_BEGINU:R(B)

 -1@fo..qPascal_Auto_Fill_Default:F"L(	!* Turn on auto fill mode if this set!
   1,1M.L Auto_Fill_Mode)'W

 1,1m.LSpace_Indent_Flagw

 0@fo..qAutomatic_Capitalization"N !* Turn on capitalization if requested!
 	m(m.mCapitalize_Pascal_Keywords)'

 				 !* Done. !

!& Set Group Value:! !S Set a group of vars in Pascal Syntax Table.
First arg is val to set to.  Second arg is bit mask:  set words which
have one of those bits set in second value in Pascal Syntax Table.!

 0[1 QPascal_Syntax_Table[s
 QPascal_Keyword_Count <
    Q:s(Q1*3+3)&"N U:s(Q1*3+2)'
    %1W
    >

!& Set Major Variable:! !S Set up one of the controlling vars to set
dependant vars.  Var name is first string arg.  Match val is second.
Comment is third.!

 [v :iv [n :in

 -99@fo..qv[1	    !* Get current value!

 !* Make var to automatically set dependant values on change!
 m.cv! *_(Pascal)_!
    ,n m(m.m&_Set_Group_Value)

 Q1+99"N Q1Uv'    !* Make sure old value works.!
 


!& Set minor variable:! !S Set up a normal var of name "Indent After x"
to automatically set pascal keyword var x.  Number Arg is index in table.!

 [v Q:Pascal_Syntax_Table() Uv
 [n +1:\Un

 -99@fo..qIndent_After_v[1	    !* Get current value!

 !* Make var to automatically set dependant values on change!
 m.cIndent_After_v! *_(Pascal)_Indent_after_keyword_v!
    U:Pascal_Syntax_Table(n)

 Q1+99"N Q1UIndent_After_v'    !* Make sure old value works.!
 


!& Setup variables:! !S Set up indentation vars to interface to syntax table!

 QPascal_Syntax_Table[t

 m.m&_Set_Major_Variable[j

 !* Set up "class" vars to change all relevant keyword locations!
 MjIndent_After_Everything361.Default_indentation_after_all_keywords
 MjBegin-Block_Body_Indentation21.Indentation_after_loop_constructs
 MjIf-Block_Body_Indentation200.Indentation_after_IF-group_keywords
 MjDecl_Body_Indentation100.Indentation_after_declaration_keywords
 MjProcedure_Body_Indentation40.Indentation_for_Proc._&_Func._Bodies

 !* Set up for all keywords to be settable through "Indent After x"!
 0[1 m.m&_Set_Minor_Variable[n
 QPascal_Keyword_Count <
    Q:t(Q1*3+3)&361."N
        Q1*3+1 mn'
    %1>


!^R PASCAL New Line:! !^R Inserts CRLF, then indents the second line.
Any spaces before the inserted CRLF are deleted.
If there is a Fill Prefix it is used to indent, else calls 
^R Indent Pascal Stmt.!
    -@F_	K		 !* Leave no spacing at end of line.!
    .[w				 !* save point !
    @MM			 !* Run this user's CR definition.!
    0@fo..q Fill_Prefix[3	 !* If a prefix is defined, insert it.!
    fq3"g g3'
    "# F@M(M.M^R_Indent_Pascal_Stmt)[x[y' !* Else indent.!
    fs rgetty"e :0t'
    Qy,Qwf *0:  ,.		 !* min(Qw,Qy) is start of changed area !

!^R Find Unmatched Paren:! !^R Show unmatched paren if there is one.
Argument is number of seconds to stay at paren, if no argument stays there
permanently.!

 .[.0 fnQ.0 J			    !* On exit, go back.!

 1:<-M(M.M&_Back_Paren)>"N
      :i*NUP	No_Unmatched_ParenthesesFSErr '

 ff&1"N 0@V : '		    !* Sleep if argument !
 

!^R Insert Comment:! !^R Insert comment here (don't move to do so).
Can be undone with UNDO.!

 !* Get comment Begin in Qb!
 qComment_Start[b
 qb"e :ib;'			 !* Use ; as default comment starter.!
 0fo..qComment_Beginf"N ub'

 !* Get comment End in Qe !
 :i*fo..qComment_End[e

 .,.m(m.m&_Save_For_Undo)Insert_Comment

 .(Gb Ge),.(FKC)

!^R Indent PASCAL Stmt:! !^R Indentation for Pascal code.
If numeric arg, calls ^R Indent Nested,
  Else if not at left margin, calls ^R PASCAL Indent Relative.
  Else parses back to calculate proper indentaion, except setting the
    variable Indent Align Only to non-zero will make it always just
    align (call ^R Indent Nested).

Print Last Pascal Indenter will print the name of the indentation
    function called.!

 ff"'E*(0@fo..QIndent_Align_Only"'E)"E !* ARG => do ^R Indent Nested. !
	 :iLast_Pascal_Indenter^R_Indent_Nested
	 f@:m(m.m^R_Indent_Nested)'

 FSHPos"N @:m(m.m^R_Pascal_Indent_Relative)'

 @f_	K		    !* Delete current indentation!
 m(m.m&_Indent_Line)[x[y	    !* Indent line!
 fsrgetty"e
    fsechodis Afsechodis    !* force new line on non-displays !
    0t'

 Qy,Qx


!& Forward To Chars:! !S forward skipping comments & quoted strings
up to character in string arg.!

 QComment_Start[s QComment_End[e  FQs[l [1 :I1
 0:Ge-32"E 1,FQe:GeUe'		    !* Get rid of starting space in com. end!

 <!"!@:f ({'s 1L .-Z@;
       1A-{ "E C     :S} "E   :i*Unmatched_{FSERR'  !<!>'  !* Match "{"!

   !"! 1A-' "E C !"! :S' "E!"!:i*Unmatched_'FSERR'  !<!>'	!* Match "'"!

       1A-( "E .+2-Z:"G 2A-* "E				!* Match "*)"!
          2C           :S*) "E     :i*Unmatched_(*FSERR' !<!>'''

       Ql F=s"E					 !* Match comment end!
         QlC           :Se"E     :i*Unmatched_sFSERR'!<!>' 

       1Af1;		    !* Otherwise, done if char found.!
				    !* Check this after so we can find ()!
				    !* while skipping (* *)!

      1C			    !* If we got here, we found a bare ")"!
  >
 

!& Back to Chars:! !S back skipping comments & quoted strings,
TO any character are passed in the string argument (or beg. of file)!

 QComment_Start[s QComment_End[e FQe[l [1 :I1
 0:Ge-32"E 1,FQe:GeUe'		    !* Get rid of starting space in com. end!
 < !"!-@:f )}'e 1L .-B@;

       0A-} "E R -:S{ "E      :i*Unmatched_}FSERR'  !<!>'  !* Match "}"!
   !"! 0A-' "E R !"!-:S' "E!"!:i*Unmatched_'FSERR'  !<!>'	!* Match "'"!
       0A-) "E .-2-B:"L -1A-* "E				!* Match "*)"!
          2R       -:S(* "E     :i*Unmatched_*)FSERR' !<!>'''
       Ql F=e"E					 !* Match comment end!
         QlR       -:Ss"E     :i*Unmatched_eFSERR'!<!>' 

       0Af1;		    !* Otherwise, done if char found.!
				    !* Check this after so we can find ()!
				    !* while skipping (* *)!

      1R			    !* If we got here, we found a bare ")"!
  >
 

!& Back to Word:! !S Backward over comments to a letter.!
 Mb ABCDEFGHIJKLMNIOPRSTUVWXYZabcdefghijklmnioprstuvwxyz
 

!& Forward to Word:! !S Forwards over comments to a letter or string arg.!
 Mf ABCDEFGHIJKLMNIOPRSTUVWXYZabcdefghijklmnioprstuvwxyz
 

!& Back to Word Over Paren:! !S back to word + string arg, skipping parens
Assumes M-X Back To Word is in Q-Reg w and M-X & Back Paren is in Q-Reg p!

[1 :I1
< Mw)1
  .-B@; 0A-):@;
  0Mp				    !* Pass over paren group if there.!
  >
 

!& Back Pair:! !C Moves back over a class of matched objects (like THEN & ELSE)
in which the matching is subservient to the block matching.
Assumes it is already <arg> deep. (arg = -1 means starting behind an END).
If Qt is less than zero, we assume we are being called from & Indent Line!

 -1[l			    !* Start level at -1!
 Qt:"L				    !* Don't do this if from & Indent Line!
				    !* (for efficiency)!
     [.p
     [1 [9
     QPascal_Syntax_Table[t


     M.M&_Back_To_Chars[b
     M.M&_Back_To_Word[w
     M.MBack_Level[k

     .U.p fnQ.p J		    !* If ^G'ed, stay here.!
     '

 < mw .-B"E Ql"N  :i*Unmatched_syntax_pairFSERR ''

   -FW F(X1)L
   @:FOt1U9			    !* Get pointer to syntax table in Q9!
   Q9"G
     Q:t(Q9+2)&2."N		    !* If a block closer, Skip block!
       -1Mk'
     "#
     Q:t(Q9+2)&"N		    !* If a first, we're climbing out!
       Ql+1 Ul'
     "#  Q:t(Q9+2)&"N		    !* if a last, then we're going deeper!
       Ql-1 Ul ''
     ''
    QL@;>

 Qt:"L 0U..n'
 

!Back Level:! !C Moves back to beyond a BEGIN/END block.
Assumes it is already <arg> deep. (arg = -1 means starting behind an END).
!
!* Seperate implementation of Back Level from Forward Level for efficiency
    since it is called by the indenting routines!

 [.p ff&1"E0'"#'[l	    !* Arg defaults to 0!
 [1 [9
 QPascal_Syntax_Table[t

 
 M.m &_Back_To_Chars [b
 M.M&_Back_To_Word[w

 .U.p fnQ.p J			 !* If ^G'ed, stay here.!

 < mw .-B"E Ql"N  :i*Unmatched_block_statementFSERR ''

   -FW F(X1)L
   @:FOt1U9			    !* Get pointer to syntax table in Q9!
   Q9"G
     Q:t(Q9+2)&1."N		    !* If an opener, we're climbing out!
       Ql+1 Ul'
     "#  Q:t(Q9+2)&2."N		    !* if a closer, then we're going deeper!
       Ql-1 Ul ''
     '
    QL@;>

 0U..n
 :F"L 0'"#Q9'		    !* IF INTERNAL, RETURN KEYWORD FOUND.!


!& Keyword Search:! !S Search for a keyword matching second arg.
First arg is direction of search.
Returns -1 for failing search, index of keyword found for success!

 [.p [d [e
 [1 [9
 QPascal_Syntax_Table[t

 !* Parameterize direction of motion!
 "L
   M.m &_Back_To_Chars [b
   M.M&_Back_To_Word[w
   -1Ud
   BUe'
  "#
   M.m &_Forward_To_Chars [f
   M.M&_Forward_To_Word[w
   1Ud
   ZUe'

 .U.p fnQ.p J			 !* If ^G'ed, stay here.!

 < mw .-Qe"E -1'

   QdFW F(X1)L
   @:FOt1U9			    !* Get pointer to syntax table in Q9!
   Q9"G
       Q:t(Q9+2)&@:;		    !* Exit when keyword match found!
     '
 >

 0U..n
 Q9

!& Forward Paren:! !S Moves Forward over matching parens.  Assumes it is
already <arg> deep. (arg = -1 means starting after a "(").!

 [.p [t ff"E0'"#'[l
 M.M &_Forward_To_Chars[f

 .U.p fnQ.p J			 !* If ^G'ed, stay here.!

 <  Mf()
    .-B "E Ql;			 !* No parens found ok if at level zero!
      :I*Bad_Paren_Matching@FSERR
      '

   1A-("E			 !* if an opener,!
      Ql-1 Ul '			 !* then we're going deeper!
    "#Ql+1 Ul '			 !* else were climbing out. !
    C
    Ql@;>
 0U..n 

!& Back Paren:! !S Moves back over matching parens, not confused by comments. 
Assumes it is already <arg> deep. (arg = -1 means starting behind a ")").!

 [.p [t ff"E0'"#'[l
 M.m &_Back_To_Chars [b

 .U.p fnQ.p J			 !* If ^G'ed, stay here.!

 < Mb()
   .-B"E Ql;			 !* No paren found => exit if at level 0!
        :I*Bad_Paren_Matching@FSERR'	 !* Else, error.!

   0A-)"E			 !* if an ender,!
      Ql-1 Ul '			 !* then we're going deeper!
    "#Ql+1 Ul '			 !* else were climbing out. !
    R
    Ql@;>
 0U..n 


!Forward Level:! !C Moves Forward to beyond a BEGIN/END block.
Assumes it is already <arg> deep. (arg = -1 means starting after a BEGIN).
!


 [.p ff&1"E0'"#'[l	    !* Arg defaults to 0!
 [1 [9
 QPascal_Syntax_Table[t

 M.m &_Forward_To_Chars [f
 M.M&_Forward_To_Word[w

 .U.p fnQ.p J			 !* If ^G'ed, stay here.!

 < mw .-Z"E Ql"N  :i*Unmatched_block_statementFSERR ''

   FW F(X1)L
   @:FOt1U9			    !* Get pointer to syntax table in Q9!
   Q9"G
     Q:t(Q9+2)&1."N		    !* If an opener, we're going deeper!
       Ql-1 Ul'
     "#  Q:t(Q9+2)&2."N		    !* if an ender, then we're climbing out!
       Ql+1 Ul''
     '
    Ql@;>
 0U..n 

!& Join Line:! !S Macro to move back to statement start when parse is at
a THEN or DO.  Assumes all the state of & Indent Line and modifies it.!
 Q9"G
   Q:t(Q9+2)&1."N		    !* If it is begin, ignore it.!
     Mw
			    !* Get the previous keyword to work with.!
     0A-
"N
       -FW F(X1) L
       @:FOt1U9
   ' ' '
 Q9"G				    !* If we got a keyword, and!
   Q:t(Q9+2)&400."N		    !* it is an ender for a control stmt, and!
     -@f	_L 0A-
"N	    !* this is not first on the line!
       -1,220.M(M.M&_Keyword_Search)    !* Go back to starter of controler!
   ' ' '
   

!& Indent Line:! !S Assumes it's starting at the start of a line with no
existing indentation.!

 [1 [9 [2 [i -1[x .[a [c [s :i*[l	    !* Save local registers!
 z-.[3 fnZ-Q3J			    !* Set up to stay here if ^G'ed!
 QPascal_Syntax_Table[t
 M.M &_Back_to_Word_over_Paren[o   !* Put some oft-called functions!
 M.M &_Back_to_Word[w		    !* In Q-Regs for efficiency.!
 M.M Back_Level[k
 M.M &_Back_To_Chars[b
 M.M &_Forward_To_Chars[f
 M.M &_Back_Paren[p

 !************************************************************************!
 !*** Check for unmatched paren !
 -10f U1 F[ V B		 !* Narrow search to 10 lines and !
 1:<-1M(M.M&_Back_Paren)>"E	 !* see if any open parens. !
     :ilIndent_Unmatched_Open_Paren
     C @f_	L	    !* Skip spaces after paren!
     oDONE1
     '
 f] V Bw


 !************************************************************************!
 !*** Go back till we find the keyword with indent amount (or claim none) !
 0:L Mo;
 .-B"E'			    !* If at beg. of file, just don't indent!

  <
   0A-;"E -2Ux R '		    !* Sem found => mark it with indent of -2!

   "#				    !* Here we are at a word!
     -fw f(x1) L
     @:FOt1U9		    !* Get index of potential keywrd in reg 9!

     Q9"G			    !* If a keyword,!

	 Qx+1"'E (		    !* If no sem so far or !
	 Q:t(Q9+2)&141."'N) "N	    !* this is subprog, decl, or beg keyword !
	    Q:t(Q9+1)Ux		    !* then this is our keyword (unless it!
	    '			    !* has a negative indent value)!

	 Q:t(Q9+2)&1. "N	    !* If we found a block beginner,!
           0@fo..qMatch_Block_Word"N !* and Match Block Word !
	     :illMatching_Block_Word
	     oDONE1''   !* then indent is to this hpos.!

	 Q:t(Q9+2)&2."N		    !* If a block ender then!
	    FWL			    !* reparse it!
	    0;			    !* And exit to "begin-end" matching!
	    '

	 '			    !* Keyword found.!
     ''				    !* at word!

   Qx;				    !* Exit if we got a keyword.!

   Mo
;			    !* Back to next interesting stuff!

   .-B@; (0A - 
)@;		    !* Keep trying till at start of line!
   >

Qx"G :ilIndent_After_1	    !* Remember indenter to tell our user.!
   oDone0			    !* Go and indent right away.!
   '

 !************************************************************************!
 !*** Moving over blocks and re-indenting Ends !
 1@fo..qReindent_ENDs"'NUs	 !* Lie and say END found, if no re-indent!

 <.-B@;
  (0A - 
)@;			    !* Exit if we are at start of line!

  -fw f(x1) L
  @:FOt1U9		    !* Get index of potential ender in reg 9!
  Q9"G
   Q:t(Q9+2)&2."N		    !* If a block ender then!
      Qs"L			    !* if this is first end, we may re-indent!
	 0f : Us w		    !*    save start of line in reg s !
	 '

      -1Mk U9			    !* But mostly, line w/ ind. is way back.!

      Qs"N			    !* if first end that took us over a line.!
	(Qs-.)"G		    !*   if we went back past end of line,!
	  :ill_(Back_Over_Block) !* say so to user!

	  M(M.M &_Join_Line)	    !* Make sure we get to start of line from!

	  .-Z(0@fo..qMatch_Block_Word"E   !*  if not indenting from word!
	    0L @f	_L'	    !*   use this lines indentation  !
	    fsHPOS(		    !*     otherwise just the current pos.!
	    QsJ
	    )M(M.M&_Indent)	    !*      to indent END line,!
	    0L .Ua		    !*    & mark our changes as starting here!
	    :Ill_(Reindented_an_1)  !* Mention we did this!
	   )+ZJ 0Us'
	  "# -1Us'		    !* If BEGIN END on same line, don't count!

	'			    !* This was the first!

      '			    !* Beginner found!

  "# Q:t(Q9+2)"G FWL 0;''	    !* Else, if a keyword, reparse and quit!

 '				    !* Was found!

 Mo
				    !* Back to next interesting stuff!
 >


 !************************************************************************!
 !*** Check statement nesting.!
 !*** E.g. if "while x do / if c then / y;" seen, indent frm line w/ while!
    < .Us			 !* If stoped, indent will be frm this line!
      Mo;
      .-B@;

      0A-;@;			    !* Sem. breaks any nesting.!

      -FW F(X1) L
      @:FOt1U9		    !* Get index of potential ender in reg 9!
      Q9"'G;			    !* If not in keyword table, we're done!

      Q:t(Q9+2)&4."N
	 10.,4.M(M.M&_Back_Pair)   !* If ELSE, look back for THEN!
	 :ill_(Back_Over_THEN/ELSE)
	'
      "#
	 Q:t(Q9+2)&10."N Qx+2"N	    !* If controled by a THEN with no SEM, !
	       :ilIndent_For_ELSEl
	       oDONE0''	    !* indent for ELSE (same as THEN line).!

	 !* Otherwise, chain is only continued by DO or THEN on this line!
	 Q:t(Q9+2)&400.@;
	 '

      -1,220.M(M.M&_Keyword_Search):;	    !* if DO or THEN found, back!
				    !* to (IF, WHILE, WITH, etc.)!

    >
 QsJ				    !* Indent to prev. line!

 :ilIndent_After_Statementl	    !* No keyword found!


 !DONE0!
 M(M.M&_Join_Line)

 !************************************************************************!
 !*** Actually do the indenting.!

 0L @f_	L		    !* Get indent from this line.!

 !DONE1!			    !* We are at position to indent from.!

 Qx"L 0Ux'

 QlULast_Pascal_Indenter	    !* Last indenter to var where usr can see!
 .ULast_Pascal_Indent_Pos

 FSHPosUi
 m..n 0u..n			    !* Pop back to start pos!
 0,Qx+Qim(m.m&_XIndent)

 Qa,.

!^R Toggle Indentation:! !^R Turn off or on PASCAL Mode indentation.
With no arg arg, toggles value of Indent Align Only; otherwise puts arg
in Indent Align Only.!
ff"E
   0@fo..qIndent_Align_Only"'E m.lIndent_Align_Only'
  "#  M.LIndent_Align_OnlyW' 0


!Mark Procedure:! !C Set point and mark around current procedure.
 Doesn't work for nested procedure definitions.
 Comment lines immediately before the procedure and blank lines after
 it are considered part of the procedure.!


 .				    !* Mark here for recovery.!
 FN 				    !* If ^G'ed, stay here.!
 1,-M(M.mNo_Comment_Search)procedurefunction"E
     :I*Not_In_A_ProcedureFS Err'

  M(M.m &_Back_To_Chars);	    !* Go back to previous proc's sem!
  M(M.M &_Forward_To_Chars)	    !* Give back any comment and!
   @F_	 
L		    !* blank lines!
   -@F_	L

 .(
   1,M(M.m No_Comment_Search)begin
   -1M(M.MForward_Level) 	    !* Forward to END!

   !* Skip any comment on END (before and after the sem)!
   M(M.M &_Forward_To_Chars);. C M(M.M &_Forward_To_Chars)
   @F_	 
L		    !* And claim blank lines at end.!
   -@F_	L .		    !* Make mark at start of line.! 
   )J
0U..n 

!^R Insert Pascal End:! !^R Pascal End:! !^R Insert end and show matching block.
Indents under matching BEGIN, LOOP, CASE, RECORD, or REPEAT.
Displays buffer around matching block statement.
    ARG = number of seconds to display there.
Inserts a comment after the "END;" to show what was ended.
    If the "BEGIN" is commented, it copies down that comment,
    otherwise it tries to construct one from the code. e.g.
    "(* while not eoln *)"  or  "(* for i:= 1 to 7 *)".
    If you don't like the comment you can kill it with ^R Kill Comment.

If matching block is REPEAT, inserts UNTIL and puts point between UNTIL and ;.!

!* Needs work.  Should use symbol table.  Comments are usually too verbose.
   Should return to @V the bounds of the buffer which have been changed!   

 .[.1 fnq.1j			    !* .1: Auto-restoring point. !
 [.2
 [.4
 0[.3
 M.M &_Back_To_Chars[b

 -1M(M.MBack_Level) fwx.6	    !* Find matching token and remember it !
 .U.2				    !* Where word found, case display there !

 .(0@fo..qMatch_Block_Word"E	    !* if not indenting from word !
    0L @f	_L'		    !*     use this line's indentation  !
   fshpos[.7)J
  f~.6REPEAT[r
  f~.6RECORD[d
  f~.6LOOP[l

 !* Get the proper comment for the END. !
 s(*{ 0A-"N		    !* If this line is commented !
     @f_	L
     .(s}*) fkc-@f_	L),.X.3    !*    use it's comment !
 '"#				    !* otherwise, we will get it from code. !
  Qr*Qd*Ql"N			    !*    if didn't match REPEAT or RECORD !
    1<Q.2J
      f~.6BEGIN"E		    !* if we have a begin, get previous kwd !
          m(m.m&_Back_To_Word) -fwx.6'
      f~.6CASE"E:i.6OF'"#	    !* Then back over interesting stuff !
      f~.6THEN"E-sIF'"#
      f~.6DO"E-sWITHWHILEFOR'"#
      0;'''
    .(s.6 fkc -@f
	_L),.x.3>
    ''


 q.1J
 0L.U.4 @f_	L	    !* Remember start of line, move past ind !
 Q.1-."G			    !* If there is something on the line, !
    Q.1J			    !*  just go to old pos. !
    .,.m(m.m&_Save_For_Undo)Insert_Pascal_End   !* But undo insertion !
    '
 "#				    !* otherwise !
    Q.4,.m(m.m&_Save_For_Undo)Insert_Pascal_End
    0L q.7m(m.m&_Indent)	    !* Go back and indent !
    '

 Qr"E				    !* If repeat, !
   iUNTIL_;.-1u.1'		    !*   need UNTIL and pt. before sem.  !
 "#iEND;   .u.1'		    !*   otherwise point after sem. !

 0@fo..qAutomatic_Capitalization"E
    -fwfc'
 1@fo..qInsert_Comments"'N & q.3"N
   i_gComment_Beging.3gComment_End	    !* Insert comment !
   Qr"N .u.1''			    !* Unless repeat, point after comment !

 q.2j				    !* Back to match and... !
 0 @v				    !* ...Display there. !
 FF"E1'"#'*30:w		    !* Wait ARG seconds or til input. !
 				    !* Exit, restore point. !


!Indent Pascal Region:! !C Indents each line from here to MARK.
On each line it:
    moves past comments to first token,
    kills indentation,
    then calls ^R Indent Pascal Stmt.
Leaves mark and point around changed region. Can be fixed with M-X Undo.
At end, expands all abbreviations in the region if in capitalize mode.

This subroutine is NOT recommended for any large blocks (over 20 lines)
of code, because there are a few special cases which are indented wrong,
(mainly between declarations and BEGIN) and it is very inefficient.!

 QComment_Start[s QComment_End[e  FQs[l [1 :I1
 0:Ge-32"E 1,FQe:GeUe'		    !* Get rid of starting space in com. end!

 :,.f [.2[.1			    !* Order point and mark in .2 & .1 !
 Q.1,Q.2m(m.m&_Save_For_Undo)Pascal_Region_Indent
 q.1j  0L (z-q.2)u.2
 << @F
	_L	    !* Forward to real character. !
    (.-z-2);
    2 f~s"E :se"Ez-Q.2J''"#-;'>  !* Skiping over comments !
    .-(z-q.2);			    !* See if done. !
    0l @f	_K		    !* Kill indentation !
    m(m.m&_Indent_Line)w	    !* Indent that line. !
    l>

 (z-q.2)j
 i

		    !* insert blank line after end !
 2r m(m.m&_Indent_Line)w  !* do indent in case END on last line !
 0l-2d k			    !* clean up !
 q.1				    !* Set MARK at beginning of region. !
 z-q.2j				    !* Set point at end. !
 0@FO..QPascal_Abbreviations_In_Use"N
   m(m.mExpand_Abbrevs_In_Region)' !* Expand all abbreviations if in use !
 q.1,. 			    !* Display and exit. !

!Same Capitalization:! !C Standardizes capitalization of next word.
No argument => same as it is now;
Neg argument => all are lower case;
Zero argument => all are capitalized;
Pos argument => all are upper case.!
 [1,[2
 Fwl				    !* forward past word.!
 ff"N [a			    !* if there is an arg then: !
   Qa"L-fwfc'			    !* neg arg => replace with lower case.!
   Qa"E-m(m.m^R_Uppercase_Initial)'!* zero arg => replace with capitalized!
   Qa"G-fw@fc'			    !* pos => replace with upper case.!
  '
 -fwx1
 0[Case_Replace
 1MMReplace_String11


!^R Pascal Indent Relative:! !^R Pascal Indent Relative to last line's words.
Successive calls get successive indentation points;  each call
    aligns under ARGth next word in previous line.
Words are separated by spaces, tabs, semicolons, commas, periods.
To facilitate moving into a line, and changing an indentation, if
    there is whitespace to the right and left (i.e. this is a new
    indent call here), then the cursor is moved one column left.!
 qLast_Pascal_Indenter[.1
 :iLast_Pascal_Indenter.1(^R_Pascal_Indent_Relative)
 [1 @:I1| qLast_Pascal_Indenteru.1   !* 1: Macro for weird tabbing. !
	  :iLast_Pascal_Indenter.1(^R_Tab_to_Tab_Stop)  !* ... !
	  :M(M.M^R_Tab_to_Tab_Stop)|	    !* ... !
 0,1af_	+1"G		    !* If char to right is whitespace,  !
    0,0af_	+1"G		    !* ...as is char to left,  !
	fs hpos-1(		    !* ...then note column left,  !
		   -d)m(m.m&_Indent)w	    !* ...and move there. !
	''			    !* ... !
 .[P FSHPOS[0			    !* P: orig point. 0: hpos. !
 @-f_	L		    !* Move left past whitespace. !
 .[Q FSHPOS[2			    !* Q: point left of white. 2: hpos. !
 0L<    B-."E QPJ :m1'		    !* No line for relative indenting !
				    !* so just tab stop. !
        -L1A-15."N0;'>		    !* Back to non-blank line. !
 Q0"G1:<0,Q0+1:FM>"ER'		    !* Cursor to orig hpos. !
		  "#0L1:<0,Q2+1:FM>"ER'	    !* ... !
				   "#QPJ:M1'''	    !* ... !

 <  :@F.,;	_L	    !* Find end of word. !
       @F.,;	_L	    !* Right to start next word. !
      >			    !* Go to start of ARGth next word. !

 FSHPOS(QQ,QPK			    !* Back to orig point, remove white left. !
         ):M(M.M&_Indent)	    !* And indent to column found. !


!Global Pascal Comment:! !C Recursive edit for large block of comments.
Comment column is set to Global Comment Column, auto fill mode is turned on,
^R Indent for Comment is called initially, Comment Start is set to "(**" to
mark global comments (read "(*" as Q$Comment Begin$).  "(*** *)" (comment
with just a *) expand into (* * * *... *), aligned with any surrounding
global comments (for boxes), or if no surrounding comments expand into
Pascal Star Line Width wide.  When the recursive edit returns, comment-ends
within each global comment will be vertically aligned.!

    QComment_Start[s QComment_End[e
    0@fo..qGlob_of_Comments_Flag"N !* Already in Global Comment. !
       f:@m(m.m^R_Indent_for_Comment)' !* So just do M-;. !
    0m.vGlob_of_Comments_Flag
    1[Glob_of_Comments_Flagw	 !* Signal now in glob mode. !
    :i*Global_Comment[..j
    10fo..qGlobal_Comment_Column[Comment_Column
    0[Comment_Begin
    :i*s*[Comment_Start	 !* So mark each global comment !
				 !* for later comment-end aligning. !
    1[Space_Indent_Flag
     1[Auto_Fill_Mode		 !* Temp. turn on auto-filling now. !
     @m(m.m^R_Indent_for_Comment) !* ... and then align it. !
      w			 !* Enter ^R mode for globals. !
     0f  "N L'		 !* If inside a line, go to next line. !
     fs z-.f[ vzw		 !* Bounds around buffer before point. !
     m(m.m&_Align_Global_Pascal_Comment_Ends) !* Align those before point.
!
     zj f]vz
     .f[vb
     m(m.m&_Align_Global_Pascal_Comment_Ends)	 !* Align after point. !
    

!& Align Global Pascal Comment Ends:! !S Ends within contiguous global comments.
Contiguous global comments are comments starting with "(**", on
    successive lines.
Contiguous global comments have their comment-ends aligned vertically.
If a global comment consists soley of "*", i.e. it is "(*** *)",
    then it will expand out into a "(* * * * * ...* *)" comment, aligned
    with its contiguous global comments.  If no contiguous comments,
    expands out into (* * *...*), Pascal Star Line Width wide
    and extending to left margin.
After alignment, "(**" is replaced by "(* ".!
!* We expect the old Comment Start in Qs and Comment End in Qe !
 [.1[.2[.3
 bj				    !* Go thru whole buffer. !
 < :ss*; fkc			    !* Find next contig global comment. !
   0u.1				    !* .1: Max width of gc within cgc. !
   0u.2				    !* .2: (** *) found flag. !
   0u.3				    !* .3: Count of gcs in this cgc. !
   .( < :fbs*;		    !* Next gc start in this cgc. !
	%.3w			    !* .3: Inc gc count. !
	.-1f_		    !* Replace with regular comment start. !
	(1+FQe) f=*e"E 1u.2'    !* .2: Found a (*** *) in this cgc. !
	:fbe;			    !* Find next gc end in this cgc. !
	fs hpos,q.1 f  u.1 w	    !* .1: Max width of gc. !
	l >			    !* Next line, maybe end of cgc. !
      fs z-.f[ vzw		    !* Set virtual buffer to end with cgc. !
      )j			    !* Back to start of cgc. !
   q.3-1"E			    !* If just one gc in cgc,  !
      q.2"N			    !* ...and if was (*** *),  !
	-@f_	b k	    !* ...then kill indentation,  !
	51@fo..qPascal_Star_Line_Widthu.1'' !* ...and set width of star line. !
   Q.1-fQs U.1			    !* .1: HPOS to put (* at. !
   Q.2"N			    !* If have a (* * * *...*) in * cgc,  !
      (q.1-qComment_Column-1-FQs&1)+q.1u.1' !* .1: round up if need to, to !
				    !* make the * * *) come out evenly. !
   < :se;			    !* Next gc end. !
     -(FQs+FQe+2) f=s_*e"E  !* If comment was just a *, expand  !
	 FQe-1:F"G1'R			    !* ...into * * * * ... !
	 q.1-(fs hpos)/2 <i*_>    !* ... !
	 '			    !* ... (to match 2r next). !
     "#FQe-1:F"G1'Rr q.1m(m.m&_Indent) f' !* Indent the comment end, tell ^R. !
     l >			    !* Next line, continue. !
   zj f] vzw			    !* Restore boundaries. !
   >				    !* Continue with next cgc. !
 				    !* Done aligning. !

!^R Slurp Pascal to Char:! !^R Prev line back to CHAR moved to point, indented.
Non-comment text from previous line (back to CHAR typed) is moved
    onto the current line, after indentation, and then ^R Indent
    Pascal Stmt is called to re-align.  Now that the prev line is
    changed, things might look better.
Any comment on prev line is left there, and ^R Indent for Comment is
    called on it to align it after the text is removed from before it.!
 [.1[.2[.3[.4[.5[.6
 m.i fiu.5			    !* .5: Get char to slurp to. !
 z-.u.1				    !* .1: Original point. !
 0l @f_	 r		    !* Line begin, past indentation. !
 z-.u.6				    !* .6: Where to put slurped stuff. !
 0:l z-.u.3			    !* .3: Prev lines end. !
 .m(m.m&_Back_Over_Pascal_Line_Comment)j   !* Before any comment & white. !
 .u.2				    !* .2: Point before any comment. !
 < .,(0l).:fb.5; >	    !* Search back ARG chars on this line. !
 .,q.2f( fx.4 ) f		    !* .4: Slurped chars. !
 z-.-q.3"N			    !* If was a comment, reindent it. !
    @m(m.m^R_Indent_for_Comment) f'	    !* ... !
 z-q.6j				    !* Back to where to put text. !
 .,(g.4 i ). f		    !* Get the slurped text. !
 0l				    !* Back before text. !
 @m(m.m^R_Indent_Pascal_Stmt) f   !* Now reindent slurped text line. !
 z-q.1j w 1 			    !* Exit, with orig point restored. !

!Print Last Pascal Indenter:! !S Explain the last indentation a bit.
Prints what variable or idea was significant in the indentation and shows
the point where the indentation was measured from for ARG seconds!

 qLast_Pascal_Indenter[.0	    !* Put name in more usable qreg. !
 fs echo displayw		    !* Clear the... !
 Cfs echo displayw		    !* ... echo area. !
 @ft.0			    !* Print name. !
 0fs echo activew

 .[1 fn Q1J			    !* Set up to jump home on exit!
 QLast_Pascal_Indent_PosJ 0@V	    !* Go to last indent pos and display!
 FF&1"E 1 '"# '*30 :	    !* Wait a while or until user types.!

 

!Capitalize Pascal Keywords:! !C Turn on capitalization of keywords.
With 0 argument, turns off capitalization.
Uses the WORDAB library and a file of pre-defined abbreviations
   which are the keywords.
This command is currently not recommended because: 1) it expands common
words like "in" or "if" in comments, which is a hassle; and 2) it intertwines
all the capitalization abbreviations with your own abbreviations!

 [.1
 ff"E 1u.1'"# u.1'
 q.1"E 0@FO..QPascal_Abbreviations_In_Use"N
 	0m(m.mWord_Abbrev_Mode)    !* Turn off wordab library !
	0m.vPascal_Abbreviations_In_Use
	0m.lAutomatic_Capitalization''

 0@FO..QPascal_Abbreviations_In_Use"N '   !* already loaded !
 1m.vPascal_Abbreviations_In_Use   !* say in use !
 1m.lAutomatic_Capitalization
 0@fo..qWORDAB_Loaded"E		    !* prevent multiple loading !
        m(m.mLoad_Library)WORDAB  !* load it !
	1m.vWORDAB_Loaded'
 m(m.mWord_Abbrev_Mode)	    !* start it !
 m(m.mRead_Word_Abbrev_File)EMACS;PASCAL_DEFN	    !* get the abbrevs !
 				    !* Done !

!Pascal Expand Abbrevs in Region:! !S Expand WORDAB abbreviations in region,
but comments and strings are skipped. Assumes WORDAB already loaded.!

 .,: f  :  [a J .-Z[z	    !* Put pt, Qz at end of reg, Qa at strt!

 M.m &_Back_To_Chars [b
 M.m &_Back_To_Word [w		    !* Commands in regs for efficiency.!
 M.m^R_Abbrev_Expand_Only [e

 0A"C -FWL FWL'			    !* Move out of first word.!
 < Mw				    !* Get the next word!
   Qa-.;			    !* done if past start!
   -fw(Me): J			    !* else expand and move back over wd.!
 > 

 QaJ Qz+Z			    !* Restore region.!
 .,: 			    !* Return changes!


!^R Start String:! !^R Set up a string of length <arg>, and overwrite.
Supply length of desired string as numeric argument (default is 10).
The string is created, full of spaces.
You enter a recursive editing level in overwrite mode
with point at the beginning of the string.
Overwrite the contents, then use ^R Exit to turn
off overwrite mode and move past the string.!

 FF"E 10[0' "#		    !* Def arg of ten if no!
   :"G10[0' "#[0''		    !* or if zero or negative arg!
 i'' R Q0,_i			    !* Insert the string filled with spaces!
 Z-(.+1)[1 Q0R			    !* Mark the end and go back to the start!
 1[Overwrite_Mode		    !* Overwrite!
 [..J :I..JFill_in_string_(Ovwrt)_
 .-1,.+Q0+1			    !* Let user edit the string !
 Z-Q1J 0

!^R Plus One:! !^R Make Pascal assgt stmt to increment word before point.
Saves for undoing.!

 [a .(
 <-FWL -@F_	L .-B@;    !* Go back over words until out of full !
  (0A-. "'E) (0A-, "'E) + (0A - [ "'E) + (0A-] "'E) ;>  !* variable !

  @F_	L		    !* Back forwards over white space.!

 .[1)J

 Q1,.M(M.M &_Save_for_Undo)Plus_One

 M.VWord_Abbrev_Mode"N
    m(m.m^R_Abbrev_Expand_Only)'

 .( -@f_	L
 Q1,.Xa				    !* Put variable name in reg A !
 )J
 I:=_ Ga I_+_1; Q1,.	    !* Fill out the rest of the stmt!


!& Pascal DO-OF:! !S Sets up a structured pascal WITH, WHILE, FOR, or CASE
statement.  WITH, WHILE, FOR, or CASE is the first string argument; OF or
BEGIN is the second.!

 QPascal_Syntax_Table[t
 [c:ic			    !* string arg (WHILEFORWITHCASE)!
 [e :ie			    !* second string arg (OFBEGIN)!
 [d :id			    !* only use DO for DO stmts !
 FF*[b			    !* arg >0 => no BEGIN; <0 => surround !
 Qb"L-Qb+1'"#.,.'M(M.M &_Save_for_Undo)Insert_c_Statement
 .[p .[s			    !* save start of changes, cap area. !

 .(0L @F_	L Qp-."L QpJ' fsHPos[1 )J
 0@fo..qe_on_same_line*(Qb:"'G)"E !* Don't count DO if BEGIN right after.!
  4@FOt DOf"LW0' +'Q1[2
 Qb:"G4@FOt ef"LW0'+'(  !* Extra indent after BEGIN only if BEGIN!
 )Q2 U3

 fsHPos,Q1m(m.m&_XIndent) Ic_#d	    !* Insert start.!
 Qb:"G				    !* If there is to be a BEGIN!
   0@fo..qe_on_same_line"Ei
!*  if not begins on same line, ins <CR>!
   0,(Q2)m(m.m&_XIndent)'"#i_'    !* and indent!
   Ie'			    !*   and put in BEGIN!
 Qb"L .
      0@fo..qAutomatic_Capitalization"E
 	    Qs,.fc '
      -Qb+1:L
      Q3-Q1m(m.m^R_Indent_Rigidly)
      .(W)J			    !* Get rid of the mark we set!
      .Us'
   "# i

      0,Q3m(m.m&_XIndent)'    	    !* Indent block body line.!
 Qb:"G
   i

   0,(Q2)m(m.m&_XIndent)
   IEND; 1@fo..qInsert_Comments"Ni_gComment_BegingcgComment_End''
 0@fo..qAutomatic_Capitalization"E
 	Qs,.fc'
 .[r QpJ s# -D Qp,Qr-1	    !* back to mark, find and kill marker.!

!^R Pascal WHILE:! !^R Sets up a structured WHILE statement.
See PASCAL info node for customization information.
Positive argument means do not insert BEGIN and END;
negative arg means try to surround -<arg> lines within BEGIN/END.!

 Fm(m.m&_Pascal_DO-OF)WHILEBEGIN_DO 

!^R Pascal FOR:! !^R Sets up a structured FOR statement.
See PASCAL info node for customization information.
Positive argument means do not insert BEGIN and END;
negative arg means try to surround -<arg> lines within BEGIN/END.!

 Fm(m.m&_Pascal_DO-OF)FORBEGIN_DO 

!^R Pascal WITH:! !^R Sets up a structured WITH statement.
See PASCAL info node for customization information.
Positive argument means do not insert BEGIN and END;
negative arg means try to surround -<arg> lines within BEGIN/END.!

 Fm(m.m&_Pascal_DO-OF)WITHBEGIN_DO 

!^R Pascal CASE:! !^R Sets up a structured CASE statement.
See PASCAL info node for customization information.
Negative arg means try to surround -<arg> lines within BEGIN/END;
you don't want a positive arg.!

 1M.LOF_On_Same_Line
 Fm(m.m&_Pascal_DO-OF)CASEOF 

!^R Pascal IF:! !^R Sets up a structured IF statement.
See PASCAL info node for customization information.
Positive argument means do not insert BEGIN and END;
negative arg means try to surround -<arg> lines within BEGIN/END.!

 QPascal_Syntax_Table[t
 FF*[b
 .[p .[s
 .(0L @F_	L Qp-."L QpJ' fsHPos[1 )J
 Qb"L-Qb+1'"#.,.'M(M.M &_Save_for_Undo)Insert_IF_Statement
 1@fo..qTHEN_on_same_line"E4@FOt IFf"LW0'+'(
   )Q1[2
 0@fo..qBEGIN_on_same_line*(Qb:"'G)"E !* Don't count THEN if BEGIN right after.!
    4@FOt THENf"LW0'+'Q2[3
 Qb:"G4@FOt BEGINf"LW0'+'(  !* Extra indent after BEGIN only if BEGIN!
  )Q3 U4

 IIF_#				    !* Insert IF start.!
   1@fo..qTHEN_on_same_line"Ei
    !* if not THEN on same line, ins <CR>!
      0,Q2m(m.m&_XIndent)'"#i_' !* and indent.!
   ITHEN'			    !*   put in then (and <cr>)!
 Qb:"G				    !* If there is to be a BEGIN!
   0@fo..qBEGIN_on_same_line"Ei
   !*   if not BEGINs on same line, ins <CR>!
   0,Q3m(m.m&_XIndent)'"#i_'
   IBEGIN'			    !*   put in BEGIN!
 Qb"L .
      0@fo..qAutomatic_Capitalization"E
 	    Qs,.fc '
      -Qb+1:L
      Q4-Q1m(m.m^R_Indent_Rigidly)
      .(W)J			    !* Get rid of the mark we set!
      .Us'
   "# i

      0,Q4m(m.m&_XIndent)'    	    !* Indent block body line.!
 Qb:"G
   i

   0,Q3m(m.m&_XIndent)
   IEND; 1@fo..qInsert_Comments"Ni_gComment_BeginiIFgComment_End''
 0@fo..qAutomatic_Capitalization"E
 	Qs,.fc'
 .[r QpJ s# -D Qp,Qr-1	    !* back to mark, find and kill marker.!

!^R Pascal ELSE:! !^R Set up matching ELSE statement.
Positive argument means do not insert BEGIN/END; negative arg
means enclose -<arg> lines withing the BEGIN/END.
It will delete a ; if it finds one on the previous line.!


 QPascal_Syntax_Table[t
 FF*[b			    !* numeric argument <=> no BEGIN/END!

 .[s
 Qb"L .(-Qb+1L .[y)J'"#.[y'


!** Check for sem on previous line !

 M.m &_Back_To_Chars [b
 M(M.m&_Back_to_Word); ]b

 (0A-;)"E			    !* ";" found on previous line !
   .-1,QyM(M.M &_Save_for_Undo)Insert_ELSE_Statement
   -D (Qs-1)Us'
 "#.,QyM(M.M &_Save_for_Undo)Insert_ELSE_Statement'

!* Move point back where it started, but leave QS pointing at end of prev. line.!
 .(QsJ)Us
Qs[x

 0@FO..Q ELSE_On_Same_Line"N QSJ I_'

 .[p
 .(0L @F_	L Qp-."L QpJ' fsHPOS[1 )J
 0@fo..qBEGIN_on_same_line*(Qb:"'G)"E !* Don't count ELSE if BEGIN right after.!
 4@FOt ELSEf"LW0' +'Q1[2
 Qb:"G4@FOt BEGINf"LW0'+'(  !* Extra indent after BEGIN only if BEGIN!
 )Q2 U3

 IELSE  !* Insert ELSE.!
 Qb:"G				    !* If there is to be a BEGIN then !
   0@fo..qBEGIN_on_same_line"Ei
   !*   if not BEGINs on same line, ins <CR>!
   0,Q2m(m.m&_XIndent)'"#i_' !* and indent!
   IBEGIN'			    !*   and put in BEGIN.!
 Qb"L .
      0@fo..qAutomatic_Capitalization"E
 	    Qs,.fc '
      -Qb+1:L
      Q3-Q1m(m.m^R_Indent_Rigidly)
      .(W)J			    !* Get rid of the mark we set!
      .Us'
   "# i

      0,Q3m(m.m&_XIndent)'    	    !* Indent block body line.!
 i#
 Qb:"G
   i

   0,Q2m(m.m&_XIndent)
   IEND; 1@fo..qInsert_Comments"Ni_gComment_BeginiELSEgComment_End''
 0@fo..qAutomatic_Capitalization"E
 	Qs,.fc'

 .[r QxJ
 s# -D
 Qx,Qr-1	    !* back to mark, find and kill marker.!

!& Pascal Subroutine:! !S Sets up a PROCEDURE or FUNCTION block.!

 QPascal_Syntax_Table[t
 0@fo..qAutomatic_Capitalization[a
 [n [c [d [s [g
 FF[b			    !* any num means no VAR!

 :ic			    !* PROC. or FUN. in reg c !
 :is			    !* ";" or "." in reg s !

 .Up
 .,.M(M.M &_Save_for_Undo)insert_c_block

 .(0L @F_	L Qp-."L QpJ' FSHPos[1 )J !* get HPos at start of line !
 Q1 + (4@fo..qc_Body_Indentationf"LW0')[2
 Q2 + (4@FOt BEGINf"LW0')[3
 Q1 + (4@FOt cf"LW0')[4

 gc i_ Qa"E -fwfc'		    !* Insert and maybe capit. PROC. or FUN. !

 !* Allow user to type in subroutine name and arguments !
 :i*Type_c_Name_and_Arguments_(End_with_C-M-Z)[..J
 .Ug ZUd  ]..J

 Qgj @f_	 
L FWXn	    !* Skip blanks to name and grab it. !
 Qg+Z-QdJ
 0A-;"N I;'			    !* Insert a sem if the user didn't!

 i 
i 
			    !* Insert two CRLF's !

 Qb"E
   0,Q4m(m.m&_XIndent)
   IVAR_#
  
' Qa"E -fwfc'
 0,Q2m(m.m&_XIndent)
 IBEGIN  Qa"E -fwfc'
 1@fo..qInsert_Comments"Ni_gComment_BegingngComment_End' I

 0,Q3m(m.m&_XIndent)
 Qb:"E I#' I

 0,Q2m(m.m&_XIndent)
 IEND gs Qa"E -fwfc'
 1@fo..qInsert_Comments"Ni_gComment_BegingngComment_End'
 .[r QpJ s# -D Qp,Qr-1

!^R Pascal FUNCTION:! !^R Inserts a FUNCTION block.
See Pascal info node for customization information.
Sets up a VAR statement, unless it is given an argument.
Indents to this lines indentation.!
 F@m(m.m&_Pascal_Subroutine)FUNCTION;

!^R Pascal PROCEDURE:! !^R Inserts a PROCEDURE block.
See Pascal info node for customization information.
Sets up a VAR statement, unless it is given an argument.
Indents to this lines indentation.!
 F@m(m.m&_Pascal_Subroutine)PROCEDURE;


!^R Pascal PROGRAM:! !^R Inserts a PROGRAM block.
See Pascal info node for customization information.
Sets up a VAR statement, unless it is given an argument.
Indents to this lines indentation.!
 F@m(m.m&_Pascal_Subroutine)PROGRAM.


!^R Pascal REPEAT:! !^R Inserts a REPEAT statement.
See PASCAL info node for customization information.
If given a negative argument, surrounds -<arg> lines within the
REPEAT/UNTIL!
fm(m.m&_Pascal_REPEAT-RECORD)REPEATUNTIL 


!^R Pascal RECORD:! !^R Inserts a RECORD with the END.
See PASCAL info node for customization information.
If given a negative argument, surrounds -<arg> lines within the
RECORD/END!
fm(m.m&_Pascal_REPEAT-RECORD)RECORDEND 


!& Pascal REPEAT-RECORD:! !S Powerhorse for REPEAT & RECORD!
 QPascal_Syntax_Table[t
 FF*[b
 [c :ic			    !* REPEAT or RECORD !
 [d :id			    !* UNTIL or END !
 Qb"L-Qb+1'"#.,.'M(M.M &_Save_for_Undo)Insert_c_Statement
 .[p .[s

 .(0@fo..qMatch_Block_Word"E
  0L @F_	L Qp-."L QpJ''
  fsHPos[1)J
 Q1+(4@FOt cf"LW0')[2

 Ic   !* Insert start.!
 Qb"L .
      0@fo..qAutomatic_Capitalization"E
 	    Qs,.fc '
      -Qb+1:L
      Q2-Q1m(m.m^R_Indent_Rigidly)
      .(W)J			    !* Get rid of the mark we set!
      .Us'
   "# i

      0,Q2m(m.m&_XIndent)'    	    !* Indent block body line.!
 i

 0,Q1m(m.m&_XIndent)  Id#;
 0@fo..qAutomatic_Capitalization"E
 	Qs,.fc'
 .[r QpJ s# -D Qp,Qr-1


!^R Pascal BEGIN:! !^R Writes a BEGIN/END pair
If given a negative argument, encloses -<arg> lines between the
BEGIN/END.!

 QPascal_Syntax_Table[t
 FF*[b
 Qb"L-Qb+1'"#.,.'M(M.M &_Save_for_Undo)Insert_BEGIN/END
 .[p .[s

 .(0@fo..qMatch_Block_Word"E
  0L @F_	L Qp-."L QpJ''
  fsHPos[1)J

  Q1+(4@FOt BEGINf"LW0')[2

 IBEGIN   !* Insert start.!
 Qb"L .
      0@fo..qAutomatic_Capitalization"E
 	    Qs,.fc '
      -Qb+1:L
      Q2-Q1m(m.m^R_Indent_Rigidly)
      .(W)J			    !* Get rid of the mark we set!
      .Us'
   "# i

      0,Q2m(m.m&_XIndent)'    	    !* Indent block body line.!
 i#

 0,Q1m(m.m&_XIndent)  IEND;
 0@fo..qAutomatic_Capitalization"E
 	Qs,.fc'
 .[r QpJ s# -D Qp,Qr-1


!No Comment Search:! !C Searches for it's string argument, ignoring comments.
With a pre-comma argument, only finds delimited words.
Reverse searching works, except in languages which end comments with CRLF!


 FF-1[2 1,FSearch_String:_[1
 "'L*2+1[3			    !* Q3 is -1 for arg < 0; 1 for arg >= 0!
 0FO..qComment_Start[s		    !* Get comment start or ";"!
 FQs:"G :I*;Us'
 0FO..qComment_End[e		    !* If comment end not defined, find CRLF!
 FQe:"G :I* 
Ue'
 Q3"L Qe(QsUe)Us'		    !* If backward, interchange roles of s & e!

 .[.1 fnq.1j			    !* .1: Auto-restoring point. !

 <Q3:Ss1F"E		    !* Find starter or target!
   :F"L :i*SFL	Search_Failed?FS Err' 0
   '+1"N			    !* if it is target.!
        -Q2;			    !* exit if that is all we had to find.!
	(Q3+1/2A"'B)&(FK+1-(Q3+1/2)A"'B):;   !* Otherwise, exit if delimited!
       '
  Q3:Se"E :i*Unmatched_Open_CommentFS Err'
  >
 0U..n
 -1

!ErrList Mode:! !S Turns on and off ErrList mode.
With no argument, toggles ErrList Mode.  Otherwise sets ErrList Mode to arg.!

 ff"E QErrList_Mode"'E '"# ' UErrList_Mode
 

!& In ErrList Mode:! !S Turns on ErrList mode.!


 [1 [5
 0FO..qCompiler_FilenameUOld_Compiler_Filename

 0FO..q After_Compilation_HookU1	    !* Save old compilation hook!
 Q1UOld_After_Compilation_Hook
 Q1"E :i1'
 @:iAfter_Compilation_Hook|1M(M.M&_Compile_Compilation)
			    0U..H -1FSPJATY |

 0FO..QCompiler_SwitchesU1
 Q1UOld_Compiler_Switches
 Q1"E :i1'

!* :i*1/LISTUCompiler_Switches !

 0FO..QCompile_CommandU1
 Q1UOld_Compile_Command
 Q1"E :i1			    !* If no compile command and!
     0FO..qCompiler_Filename"G	    !* using EXECUTE command, no "/LIST",!
	 QPascal_Compile_CommandUCompile_Command !* so use special hack.!
	 !* :iCompiler_FilenameSYS:PAS.EXE!
     '   '
 

!& Out ErrList Mode:! !S Turns off ErrList Mode!

 QOld_After_Compilation_HookUAfter_Compilation_Hook
 QOld_Compiler_SwitchesUCompiler_Switches
 QOld_Compile_CommandUCompile_Command
 QOld_Compiler_FilenameUCompiler_Filename
 

!& Compile Compilation:! !S To be run as the After Compilation Hook!
 [0
 QBuffer_NameU0
 [Previous_Buffer
 m(m.mSelect_Buffer) *LST*

 Q1FS DFILE
 F6LST FS D FN2
 0 FS DVERS
 1:< -1m(m.mVisit_File)
     @ED
    >"N :i*No_Listing_File 
FG'
 m(m.m&_Save_Errors)

 Q0m(m.mSelect_Buffer)


!& Save Errors:! !S Gather all errors in an array.!
!* Currently this has a kludgey dependance on the format of the listing!
!* file.  It will have to be changed for every compiler.!

 [a [b [e 1[p [l [c [m 0[i
100Ua
!* ZJ -Sdetected 0L @f_	L \Ua	    |* # of errors in Qa|
!				    !* # of errors no longer revealed!

 (Qa*4)*5 FS Q VectorUb	    !* Now Qb is buffer long enough!

 J
 <
    0Ue
    <:s
      __*****;		    !* Find error or page marker, or give up !

      0A-"E sPage_ \Up'	    !* if a page marker, get the #, go on!
      "# -1Ue 0;'>

    Qe;				    !* No more errors - exit!

    -1L @f_	L \Ul	    !* Get line #!

    1L 8C

    .Um 0Uc
    <				    !* Loop over all errors for this line!

      @f*_	f( +QcUc)L	    !* Get position in line!
      1A-^:@;			    !* Quit if "^" pointer not found!

      Qp U:b(Qi*4)		    !* Save page in first word!
      Ql U:b(Qi*4 +1)		    !* Line # in 2nd!
      Qc U:b(Qi*4 +2)		    !* Character pos in 3rd!

      .(QmJ
      1L 14C 1X:b(Qi*4 +3)	    !* Get error message.!
      .Um)J

      %iW			    !* Increment error counter !

      1C %cW			    !* Move past "^"!
      >
    >
 Qb UError_Vector
 Qi UNum_Errors
 0  UError_Index



!^R Next Error:! !^R Hop to the next compilation error.!
 [i [m [0  QError_Vector[b

 QError_Index - QNum_Error"G 0UError_Index'   !* Cycle on the errors!

 %Error_IndexUi
 Qi - QNum_Error - 1"E  @FT(No_More_Errors) 
'
 "#

     J
     Q:b(Qi-1*4)-1 S		    !* Go to page,!
     Q:b(Qi-1*4+1)-1 L		    !* then line,!
     Q:b(Qi-1*4+2)   C		    !* then column.!
     Q:b(Qi-1*4+3) Um
     @FTm			    !* Type error message!
     '
 1fsechoactive


!& Read Keywords:! !S Read the keywords file into the syntax table.
Looks for file on EMACS: called PASCAL.SYN!

 
 QBuffer_NameU0
 [Previous_Buffer		    !* Make sure we don't mess up Prev. Buffer!
 m(m.mSelect_Buffer) *SYN*

 1:< m(m.mVisit_File)emacs:pascal.syn	    !* Get the syntax file!
   >"N :i*No_Pascal_Syntax_File 
FG'

 !* Create Symbol Table!
 H m(m.m &_Count_Lines) m.v Pascal_Keyword_Count  !* # of keywords.!
 QPascal_Keyword_Count*3+1*5 FS Q Vector[s !* Qs is buffer just big enuf!
 3 U:s(0)			    !* Initialize entry length.!
 Qs M.V Pascal_Syntax_Table	    !* Copy buffer ptr. to global var.!


 !* Get the entries!
 0 [x
 <@f_	 
L		    !* Skip all blanks and null lines.!
  .-Z;				    !* Exit if at end of file!

  FW X:s(%x) FWL		    !* Get the name as 1st table entry!

  @f_	L		    !* Skip blanks!
  :\ U:s(%x)			    !* Second entry!

  @f_	L		    !* Skip blanks!
  2f[IBase:\ U:s(%x)F]IBase	    !* Third entry in binary!
  1L
  >

 Q0m(m.mSelect_Buffer)		    !* Get back home and erase our tracks!
 m(m.mKill_Buffer) *SYN*


