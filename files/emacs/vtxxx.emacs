!* -*-TECO-*-!
!* <GERGELY>VTXXX.EMACS.59, 29-May-83 01:54:23, Edit by GERGELY!
!* <GERGELY.EMACS>VTXXX..59,  6-May-80 08:39:13, Edit by GERGELY!

!~Filename~:! !VTXXX Keypad Definitions!
VTXXX

!& Setup VTXXX Library:! !S Sets up the defaults for the VTXXX
keypad upon the entrance of the library.  The fork hooks are
defined so that the keypad is left in numeric mode upon
exiting.!

    0[0 [A [B
    FSRGETTY-4  "E :IBVT52 -1UA 1U0'
    FSRGETTY-18 "E :IBVT100 0UA 1U0'
    FSRGETTY-52 "E :IBVT132 1UA 1U0'
    Q0"E
	:I*WFG M.V MM_ VTXXX_Alternate_Keypad
	:I*WFG M.V MM_ VTXXX_Normal_Keypad
	:I*WFG M.V MM_ VTXXX_Transmit_Keypad
	:I*WFG M.V MM_ VTXXX_Number_Keypad
	:I*WFG M.V MM_ VTXXX_Info
	
	'

    QA M.C VTXXX_Terminal_Type-1_=_VT52,_0_=_VT100,_1_=_VT132.
    QB M.C VTXXX_Terminal_NameThe_name_of_the_DEC_VT_Class_terminal.
    
    M.M VTXXX_Alternate_Keypad M.V MM_B_Alternate_Keypad
    M.M VTXXX_Normal_Keypad M.V MM_B_Normal_Keypad
    M.M VTXXX_Transmit_Keypad M.V MM_B_Transmit_Keypad
    M.M VTXXX_Number_Keypad M.V MM_B_Number_Keypad
    M.M VTXXX_Info M.V MM_B_Info
    M.M &_VTXXX_Original_Keypad M.V MM_&_B_Original_Keypad

    0FO..QVTXXX_Setup_Hook[0 fq0"G :M0'

    M.V VTXXX_Setup_Hook
    @:IVTXXX_Setup_Hook/:i*CVTXXX_Library_has_already_been_loaded
    fs echo display 0 fs echo active/

    :i*M.VPage_Setup_Hook		!* In case they try to reload this!
					!* one as well!
 
    15FS Q VectorM.VLast_Skip/Zap	!* Define state var for !
					!* skip/zap and init it !
					!* to 3-elt vector!

    QA"L				!* Only for the vt52!
	0FO..QReal_search_macro F"E
	    W Q.S' m.vNon-VT52 Control-S
	M.M^R_VT52_control-sM.VReal_search_macro
	7*5 FS Q VectorM.V VT52_Redefinitions
	7*5 FS Q VectorM.V Saved_VT52_Redefinitions
	Q..A U:VT52_Redefinitions(0)	!* Save the original keys!
	Q..B U:VT52_Redefinitions(1)	!* that are to be redefined!
	Q..C U:VT52_Redefinitions(2)
	Q..D U:VT52_Redefinitions(3)
	Q..P U:VT52_Redefinitions(4)
	Q..Q U:VT52_Redefinitions(5)
	Q..R U:VT52_Redefinitions(6)
'

    0M.CTemporary_VTXXX_storage Intermediate_storage_for_VTXXX_mode

    1 FO..Q  B_Default_Keypad_ModeM.V VTXXX_Mode
    1M.CVTXXX_Mode! *_Non-zero_activates_Alternate_Keypad
    -1_=_Number_Pad,_0_=_No_Pad,_1_=_Alternate_keypad!
    "'N-(q$Temporary_VTXXX_storage$"'N)"E'
    1FSMODECH$ 
    F"N "G :M(M.M VTXXX_Alternate_Keypad$)'
	"# :M(M.M VTXXX_Number_Keypad)''
    "#W :M(M.M VTXXX_Normal_Keypad$)'

    1 FO..Q B_Default_Keypad_Mode M.V VTXXX_Exit_mode
    QVTXXX_Exit_Mode M.C VTXXX_Exit_mode   !*
    !The_current_mode_of_the_terminal.__See_VTXXX_Mode.

    0M.VSystem_Superior_Type
    0M.CSystem_Superior_Type_Nonzero_implies_an_invoke_inferior_type

    F[bbind				!* Get a temporary buffer!
    FSJNAMEf6 J			!* Get the jobname that!
					!* called EMACS!
    1+(:SMACS)USystem_Superior_type	!* See if it is an!
					!* EMACS variant!
    F]bbind				!* Pop the temporary buffer!

    0fo..q Exit_to_Inferior_hook[1 
    fq1"l :i1'
    @:i*`1w0m(m.m &_VTXXX_Exit_Hook)`m.v Exit_to_Inferior_Hook

    0fo..q Exit_to_Superior_Hooku1 
    fq1"l :i1'
    @:i*`1w1m(m.m &_VTXXX_Exit_Hook)`m.v Exit_to_Superior_hook

    0fo..q Return_From_Superior_hooku1 
    fq1"l :i1'
    @:i*`1w:m(m.m &_VTXXX_Return_Hook)`m.vReturn_From_Superior_hook

    0fo..q Return_From_Inferior_hooku1 
    fq1"l :i1'
    @:i*`1w:m(m.m &_VTXXX_Return_Hook)`m.vReturn_From_Inferior_Hook
    ]1

    QVTXXX_Terminal_Type"L Q..?'"# Q..O' M.V VTXXX_Original_Key
    M(M.M_&_SET_VTXXX_MODE_LINE)

    M(M.M VTXXX_Alternate_Keypad)

    1 FO..Q B_Default_Keypad_ModeM.V B_Default_Keypad_Mode

    QB_Default_Keypad_ModeF"E	!* Allows user to start with normal!
	M(M.M VTXXX_Normal_Keypad)'	!* keypad, ie. everything off!
    "# "L M(M.M VTXXX_Number_Keypad)''
    

!& Kill VTXXX Library:! !S Kill Library specifics!

    0 FO..W VTXXX_Kill_Hook[0 FQ0"G :M0' ]0

    M(M.M VTXXX_Normal_Keypad)

    M.M Kill_Variable [.K

    1:<M.K MM_ VTXXX_Alternate_Keypad>W
    1:<M.K MM_ VTXXX_Normal_Keypad>W
    1:<M.K MM_ VTXXX_Transmit_Keypad>W
    1:<M.K MM_ VTXXX_Number_Keypad>W
    1:<M.K MM_ VTXXX_Info>W

    QVTXXX_Terminal_Name[B
    1:<M.K MM_B_Alternate_Keypad>W
    1:<M.K MM_B_Normal_Keypad>W
    1:<M.K MM_B_Transmit_Keypad>W
    1:<M.K MM_B_Number_Keypad>W
    1:<M.K MM_B_Info>W
    1:<M.K MM_&_B_Original_Keypad>W
    1:<M.K VTXXX_Terminal_Type>W
    
    1:<M.K VT52_Redefinitions>W
    1:<M.K Saved_VT52_Redefinitions>W
    1:<M.K Temporary_VTXXX_Storage>W
    1:<M.K VTXXX_mode>W
    1:<M.K VTXXX_Exit_Mode>W
    1:<M.K Saved_VTXXX_Commands>W
    1:<M.K VTXXX_Original_Key>W
    1:<M.K tempvtxxxmode>W
    


!VTXXX Alternate Keypad:! !C Sets alternate keypad mode for VTXXX's
When this command is executed, the keypad on the left and the arrow
keys are now executable commands.
    The terminal is put in CURSOR KEYS MODE and KEYPAD APPLICATION MODE.!

!* Make a prefix key!

    QVTXXX_Terminal_Type"L		!* A VT52!
	128 M(M.M MAKE_PREFIX_CHARACTER).OU..?'
    "#					!* Others!
	128 M(M.M MAKE_PREFIX_CHARACTER).OU..O'

!* Set up the keys!

    0 FO..Q Saved_VTXXX_Commands "E	!* Do only if no key definitions!
	1M(M.M &_VTXXX_Original_Keypad)
	'

    1:<QSaved_VTXXX_Commands>"N
	:I*C Undefined_Keypad_in_effect fsechodisp 0fsechoactive
	'

    QSaved_VTXXX_Commands U.O		!* Restore the commands!

    QVTXXX_Terminal_Type"L		!* The VT52!
	@:I*/=/FS IMAGE OUT		!* Turn on APPLICATION MODE!
	Q:Saved_VT52_Redefinitions(0) U..A	!* Restore the original!
	Q:Saved_VT52_Redefinitions(1) U..B	!* keys that were redefined!
	Q:Saved_VT52_Redefinitions(2) U..C	!* for the VT52!
	Q:Saved_VT52_Redefinitions(3) U..D
	Q:Saved_VT52_Redefinitions(4) U..P
	Q:Saved_VT52_Redefinitions(5) U..Q
	Q:Saved_VT52_Redefinitions(6) U..R
	'
    "#					!* Others!
	@:I*/[?1h/FS IMAGE OUT	!* Turn on CURSOR KEY!
	@:I*/=/FS IMAGE OUT		!* Turn on APPLICATION MODE!
	'
    
    1M(M.M &_Set_VTXXX_Mode_line)

    .(f[ b bind			!* Temporary Buffer!
	gprefix_char_list		!* Update the Prefix list!
	j 
	QVTXXX_Terminal_Type"L	!* a VT52!
	    :s Meta-?__"EJ i Meta-?__Q.O
		'			!* Let it recognize M-?!
	    '
	"#				!* Others!
	    :s Meta-O__"EJ i Meta-O__Q.O
		'			!* Let it recognize M-O!
	    '
	HFXPrefix_char_list		!* Put the new one in!
	f] b bind)J			!* !

    1uTemporary_VTXXX_storage
    1UVTXXX_MODE
    1fsmodechange


!VTXXX Normal Keypad:! !C Undos alternate keypad mode for VTXXX's!

    Q.O USaved_VTXXX_Commands		!* Save the commands!

    QVTXXX_Terminal_Type"L		!* Only for a VT52!
	!<!@:I*/>/FS IMAGE OUT	!* Turn off everything!
	M.M ^R_DESCRIBEU..?		!* Restore Meta-?!
	.(f[ b bind			!* Temporary Buffer!
	    gprefix_char_list		!* Update the Prefix list!
	    j :s Meta-?__"N0lk'	!* Let it not recognize M-?!
	    HFXPrefix_char_list	!* Put the new one in!
	    f] b bind)J
	QVTXXX_Original_KeyU..?	!* Restore the original key!
	Q:VT52_Redefinitions(0) U..A	!* Restore the original!
	Q:VT52_Redefinitions(1) U..B	!* keys that were redefined!
	Q:VT52_Redefinitions(2) U..C	!* for the VT52!
	Q:VT52_Redefinitions(3) U..D
	Q:VT52_Redefinitions(4) U..P
	Q:VT52_Redefinitions(5) U..Q
	Q:VT52_Redefinitions(6) U..R
	'
    "#
	!<! @:I*/[?1l > /FS IMAGE OUT	!* Turn off everything!
	.(f[ b bind			!* Temporary Buffer!
	    gprefix_char_list		!* Update the Prefix list!
	    j :s Meta-O__"N0lk'	!* Let it not recognize M-O!
	    HFXPrefix_char_list	!* Put the new one in!
	    f] b bind)J
	QVTXXX_Original_KeyU..O	!* Restore the original key!
	'
    0uTemporary_VTXXX_storage
    0UVTXXX_MODE
    1fsmodechange
    

!VTXXX Number Keypad:! !C Turns off the keypad to allow using the numbers.
The key definitions for the pad are still there upon returning with
VTXXX Transmit Keypad!

    QVTXXX_MODEF"E
	:I*CThe_Number_Pad_is_already_on.fsechodisp 0fsechoactive W0
	'M.V TEMPVTXXXMODE	!* Store the original mode type!
    -1 uTemporary_VTXXX_storage
    -1 UVTXXX_Mode
    1 fs mode change
    !<!@:I*/>/FS IMAGE OUT		!* Turn off everything!
    

!VTXXX Transmit Keypad:! !C Sets the keypad to transmit their escape seq.
If the key definitions need to be reset the user should use
VTXXX Alternate Keypad.  This command is the opposite of
VTXXX Number Keypad!

    :FO..Q TEMPVTXXXMODE"L 0'
    QVTXXX_MODE"E
	QVTXXX_Terminal_Name[B
	:I*CYou_are_in_the_Normal_Keypad.__Use_M-X_B_Alternate_keypad.(
	    )fsechodisp 0fsechoactive
	0'		!* Don't bother if already off!

    QTEMPVTXXXMODE F(uTemporary_VTXXX_storage) UVTXXX_Mode
    M(M.M Kill_Variable)TEMPVTXXXMODE
    1 FS Mode Change
    @:I*/=/FS IMAGE OUT	    !* Turn on APPLICATION MODE!
    

!VTXXX Info:! !C Prints out the key definitions in display mode.
A numeric argument implies that a one line description will be given
for each key.!

    QVTXXX_Terminal_Type"L		!* VT52 has Meta-?, Others !
	Q..?' "# Q..O' FP-101"N	!* use Meta-O!
	    :I*C The_keypad_is_currently_turned_off. fsechodisp
	    0fsechoactive
	    '

M(M.M &_Load_BARE)			!* Load Bare for other things!
[A FF "E :IA' "# :IA One'
QVTXXX_Terminal_Name[B

FT The_currently_defined_B_keypad_is:


    QVTXXX_Terminal_Type"L		!* Only for the vt52!
	:I*Up-Arrow,Q..A M(M.M &_VTXXX_Briefly_Describe)A
	:I*Down-Arrow,Q..B M(M.M &_VTXXX_Briefly_Describe)A
	:I*Forward-Arrow,Q..C M(M.M &_VTXXX_Briefly_Describe)A
	:I*Backward-Arrow,Q..D M(M.M &_VTXXX_Briefly_Describe)A
	ft

	:I*BLUE,Q..P M(M.M &_VTXXX_Briefly_Describe)A
	:I*RED,Q..Q M(M.M &_VTXXX_Briefly_Describe)A
	:I*GREY,Q..R M(M.M &_VTXXX_Briefly_Describe)A
	ft

	:I*7,Q:.O(w) M(M.M &_VTXXX_Briefly_Describe)A
	:I*8,Q:.O(x) M(M.M &_VTXXX_Briefly_Describe)A
	:I*9,Q:.O(y) M(M.M &_VTXXX_Briefly_Describe)A
	ft

	:I*4,Q:.O(t) M(M.M &_VTXXX_Briefly_Describe)A
	:I*5,Q:.O(u) M(M.M &_VTXXX_Briefly_Describe)A
	:I*6,Q:.O(v) M(M.M &_VTXXX_Briefly_Describe)A
	ft

	:I*1,Q:.O(q) M(M.M &_VTXXX_Briefly_Describe)A
	:I*2,Q:.O(r) M(M.M &_VTXXX_Briefly_Describe)A
	:I*3,Q:.O(s) M(M.M &_VTXXX_Briefly_Describe)A
	ft

	:I*0,Q:.O(p) M(M.M &_VTXXX_Briefly_Describe)A
	:I*DOT,Q:.O(n) M(M.M &_VTXXX_Briefly_Describe)A
	:I*ENTER,Q:.O(M) M(M.M &_VTXXX_Briefly_Describe)A
	ft
Key_Redefinitions


	:I*C-X_S ,Q:.X(S) M(M.M &_VTXXX_Briefly_Describe)A
	:I*C-X_V ,Q:.X(V) M(M.M &_VTXXX_Briefly_Describe)A
	:I*C-X_T ,Q:.X(T) M(M.M &_VTXXX_Briefly_Describe)A
	:I*C-X_C ,Q:.X(C) M(M.M &_VTXXX_Briefly_Describe)A
	:I*C-X_Z ,Q:.X(Z) M(M.M &_VTXXX_Briefly_Describe)A
	:I*C-M-S ,Q...S M(M.M &_VTXXX_Briefly_Describe)A
	:I*C-M-. ,Q.... M(M.M &_VTXXX_Briefly_Describe)A
	'
    "#					!* Others!
	:I*Up-Arrow,Q:.O(A) M(M.M &_VTXXX_Briefly_Describe)A
	:I*Down-Arrow,Q:.O(B) M(M.M &_VTXXX_Briefly_Describe)A
	:I*Forward-Arrow,Q:.O(C) M(M.M &_VTXXX_Briefly_Describe)A
	:I*Backward-Arrow,Q:.O(D) M(M.M &_VTXXX_Briefly_Describe)A
	ft

	:I*PF1,Q:.O(P) M(M.M &_VTXXX_Briefly_Describe)A
	:I*PF2,Q:.O(Q) M(M.M &_VTXXX_Briefly_Describe)A
	:I*PF3,Q:.O(R) M(M.M &_VTXXX_Briefly_Describe)A
	:I*PF4,Q:.O(S) M(M.M &_VTXXX_Briefly_Describe)A
	ft

	:I*7,Q:.O(w) M(M.M &_VTXXX_Briefly_Describe)A
	:I*8,Q:.O(x) M(M.M &_VTXXX_Briefly_Describe)A
	:I*9,Q:.O(y) M(M.M &_VTXXX_Briefly_Describe)A
	:I*Minus,Q:.O(m) M(M.M &_VTXXX_Briefly_Describe)A
	ft

	:I*4,Q:.O(t) M(M.M &_VTXXX_Briefly_Describe)A
	:I*5,Q:.O(u) M(M.M &_VTXXX_Briefly_Describe)A
	:I*6,Q:.O(v) M(M.M &_VTXXX_Briefly_Describe)A
	:I*Comma,Q:.O(l) M(M.M &_VTXXX_Briefly_Describe)A
	ft

	:I*1,Q:.O(q) M(M.M &_VTXXX_Briefly_Describe)A
	:I*2,Q:.O(r) M(M.M &_VTXXX_Briefly_Describe)A
	:I*3,Q:.O(s) M(M.M &_VTXXX_Briefly_Describe)A
	ft

	:I*0,Q:.O(p) M(M.M &_VTXXX_Briefly_Describe)A
	:I*Dot,Q:.O(n) M(M.M &_VTXXX_Briefly_Describe)A
	:I*Enter,Q:.O(M) M(M.M &_VTXXX_Briefly_Describe)A
	'
    ft
Done.



!& VTXXX Original Keypad:! !S Creates the original keypad prefix table.
It does this by executing the file EMACS:VT???.PAD and then
PS:<LOGIN>VT???.PAD.  ??? is either 52, 100, or 132 depending on the value of
FSRGETTY upon calling this routine.  The format of these files is simply
straight TECO code to set a definition on a key in the prefix table .O.
It creates the variable Saved VTXXX Commands.  A numeric argument prevents the
warning message from being sent if an error occurs. !

    f[DFILE 0f[DVERSION w[Buffer_Filenames	!* Push all IO!
    E[ E\ FN E^ E]			!* Push input channel and prepare!
    fshsname[A				!* Get the login directory!
    QVTXXX_Terminal_Name[B		!* B:  Gets the key name!
    :IBB.PAD
    f[bbind
    1:<ER emacs:B @Y M(HFX*)>
    1:<ER AB>"E @Y M(HFX*)'
    Q.O M.V Saved_VTXXX_Commands
    QVTXXX_Terminal_Type"L
	Q..A U:Saved_VT52_Redefinitions(0)	!* Save the original keys!
	Q..B U:Saved_VT52_Redefinitions(1)	!* that are to be redefined!
	Q..C U:Saved_VT52_Redefinitions(2)
	Q..D U:Saved_VT52_Redefinitions(3)
	Q..P U:Saved_VT52_Redefinitions(4)
	Q..Q U:Saved_VT52_Redefinitions(5)
	Q..R U:Saved_VT52_Redefinitions(6)
	'
    FF"N '
    0 FO..Q VTXXX_Terminal_NameF"E '"#[A'
    :I*C A_Pad_definitions_created_and_saved!*
!fsechodisp
    0fsechoactive

    M(M.M VTXXX_Alternate_Keypad)

    1 FO..Q B_Default_Keypad_ModeF"E	!* Allows user to start with normal!
	M(M.M VTXXX_Normal_Keypad)'	!* keypad, ie. everything off!
    "# "L M(M.M VTXXX_Number_Keypad)''


!Get Keypad Definitions From File:! !C Reads a set of keypad definition from a file.
The file should look like standard teco putting function definitions on the
prefix character which is referenced by the Q-Vector .O
A numeric argument will load in the original keypad definitions first.!

    f[DFILE 0f[DVERSION w[Buffer_Filenames	!* Push all IO!
    E[ E\ FN E^ E]			!* Push input channel and prepare!
    fshsname[A				!* Get the login directory!
    QVTXXX_Terminal_Name[B		!* B:  Gets the key name!
    ETAB.PAD.0			!* Set the default name!
    ]B ]A
    5,4F Keypad_File[F		!* Read in the file!
    FF"N 1 M(M.M &_VTXXX_Original_Keypad)'	!* An argument was specified!
    f[BBIND				!* Push the buffer!
    1:<ER F>"E @Y M(HFX*(f]bbind))'	!* Read in the file and macro it!
    "# :I*C Could_not_read_the_file_F. fsechodisp 0fsechoactive 0'

    Q.O M.V Saved_VTXXX_Commands	!* Save the new commands!
    FF"N '			!* If the argument was specified then!
					!* quit!
    0 FO..Q VTXXX_Terminal_NameF"E '"#[A'	!* Get the terminal name again!
    :I*C Pad_definitions_saved.__Please_run_M-X_A_Alternate_keypad$!*
    !fsechodisp			!* Output a message!
    0fsechoactive			!* Leave it on the screen!
    

!& VTXXX Prefix Character Driver:! !S VTXXX M.P: handles a prefix character.
This is for really old EMACS versions (pre 146).
Given a q-vector as argument, it reads a character
and returns the q-vector element it selects.
The character read is left in Q..1.!

    [0 Q..0[1 0F[HELPM
    Q1M.I FIU0			    !* READ THE SUBCOMMAND CHARACTER.!
    Q1-335"N Q0:FCU0'		    !* IF NOT THE SPECIAL PREFIX M-O THEN!
				    !* UPPERCASE THE LETTER READ IN!
    F]HELPM  Q0-4110."E ?U0'
    Q0-?"E
       FS ^R LASTU0		    !* IF IT IS "?', USER WANTS DOCUMENTATION ON THIS PREFIX.!
       Q0,(Q0 @FS ^R CMAC) M(M.M ^R_PREFIX_DESCRIBE)
       :I*0_'
    Q0U..1			    !* PUT CHAR INTO Q..1.!
    Q:()(Q0) F"E W :I* FG'	    !* Index into qvector.  If slot is 0, return command to ring bell.!

!& Set VTXXX Mode Line:! !S Set the Mode line hook for the library!
    0 FO..Q Set_Mode_line_hook F"E
	W:I*m.v Set_Mode_Line_hook w :I*'[1
    f[ b bind
    fq1"L :i1'
    g1 j
    :@S/VTXXX_MODE/"E @I/
	I_ 0FO..QVTXXX_MODEF"N "L I#' "# I+''"# WI-'
	    GVTXXX_Terminal_Name/'
    HXSET_MODE_LINE_HOOK
    1fs mode change


!& VTXXX Briefly Describe:! !S Briefly describes a command.
The command character and command definition should be
given as prefix numeric args.  Any string argument turns on the longer
description for the function name.  We don't handle indirect
definitions; the caller should do that.  (This is so we
win when dealing with subcommands of prefix characters).!
    [0 [1 U0 U1 :I*[9
    FQ9 "'G U9				!* 9:  Nonzero, implies the!
					!* additional description!
    0F[SAIL
    FT0
    F]SAIL
    FT_
    Q1FP-101"E                      !* AN IMPURE STRING =) MIGHT BE A PREFIX CHAR!
        F~1!PREFIX!-9"E
            FT is_an_escape-prefix_for_more_commands.
 ''
    Q1M(M.M&_MACRO_NAME)[2	    !* Get full name in q1!
    Q2"N Q2U1
	q9"N
	    fq0-8"L ft	'
	    FT	runs_
	    FT1:
	    M.M~DOC~_1 U1	    !* Get the documentation string in q1!
	    F[ B BIND
	    G1 J FWKD :@L .,ZK	    !* GET JUST ITS 1ST LINE, SANS CLASS NAME.!
	    FT
	    		 HT'
	"# fq0-8"L ft	'
		FT	1'
	FT
 '				    !* AND PRINT IT.!

!*** IT IS NOT ONE OF THE THINGS WHOSE BRIEF DESCRIPTION IS DIFFERENT!
!*** FROM ITS FULL DSECRIPTION, SO GET THE FULL ONE.!
    fq0-8"L ft	'
    fq0-16"L ft	'
    FT	
    F :M(M.M ^R_DESCRIBE)

!^R Proper Delete Character:! !^R Delete the character after the point.
Negative arguments delete backwards!
F"G M(4FS ^R INIT)'
"#   FS ^R RUBOUT'
 

!^R Delete Last Searched Item:! !^R Deletes last searched item in buffer.
Will only work if the pointer hasn't moved!
[0 [..O					!* Q0 holds the last search item!
					!* and push the buffer!
QSEARCH_DEFAULT_RINGU..O		!* These store the search items!
.FSWORDU0				!* Get the last searched item!
]..O					!* Pop up the buffer!
  -FQ0 F~0"E -FQ0 @:M(M.M&_KILL_TEXT) '	!* If a forward search!
  "# FQ0 F~0"E FQ0 @:M(M.M&_KILL_TEXT) ''	!* A Reverse Search!
0

!^R Kill Real Line:! !^R Kill lines including the CRLF!
:@M(M.M ^R_KILL_LINE )


!^R Copy Line:! !^R Copies line into the kill ring without buffer modification.
A specified numeric argument works the same as for ^R Kill Line.!

    1001 fs ^R Last		    !* Signal this a deleting command!
.(@L.:)J				    !* [PJG] Push location on the ring!
				    !* buffer!
M(M.M ^R_Copy_Region)		    !* [PJG] Copy region!
:J W0

!^R Forward Real Word:! !^R Move forward to the beginning of the next word!
    !* [RDH] Written by Peter J. Gergely, DREA, 3 September 1980!

    :"G ,0  :@M(M.M ^R_Backward_Word)'	    !* If <arg> .LE. 0!
    65,1A"'B+:< .W FWL>"N fg'   !* Move ahead <arg> words!
    :S"l -1:C'"# zj'	    !* Search for first non-delimiter!
    0				    !* [RDH] Say no changes made.!
    

!^R Repeat Skip/Zap:! !^R Repeat the last Skip/Zap command
regardless of any intervening commands other than skip/zap!
  
  [0 [1 QLast_Skip/Zap[2	    !* Q2 is vector: <char, arg, zapflg>!
  q:2(2)F"E Wm.m^R_Skip_to_CharacterU0'
    "# "G m.m^R_Zap_to_CharacterU0'
       "# m.m^R_Copy_to_CharacterU0''
				    !* get skip, zap, or copy routine!
  q:2(1)"L 0-Q1 U1'		    !* If last arg was neg, reverse!
  Q1u:2(1)			    !* save sense!
  q:2(0),q1 :M0			    !* go execute the appropriate code!


!^R Reverse Skip to Character:! !^R Search backward for target char.
I.e. like a backwards ^R Skip to Character.  Repeat with ^R Repeat Skip/Zap.!

  0-:M(M.M^R_Skip_to_Character)  !* Just do it backward!

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

!^R Zap to Character:! !^R Kills text up to target character.
Zap excludes target character.  Negative arg zaps backward.
Repeat zap with ^R Repeat Skip/Zap.!

    .					!* Push the point!
    F @M(M.M^R_Skip_to_Character)	!* Swap point and mark, so region is!
					!* correctly oriented!
    .(W):				!* Interchange point and mark!
    1U:(QLAST_SKIP/ZAP)(2)		!* Make sure we ZAP on Repeat!
    M(M.M^R_Kill_Region)		!* Kill!
    

!^R Copy to Character:! !^R Copies text up to target character.
The copy excludes the target character.  Negative arg copiess backward.
Repeat copy with ^R Repeat Skip/Zap.!

    .					!* Push the point!
    F @M(M.M^R_Skip_to_Character)	!* Swap point and mark, so region is!
					!* correctly oriented!
    -1U:(QLAST_SKIP/ZAP)(2)		!* Make sure we Copy on Repeat!
    M(M.M^R_Copy_Region)		!* Copy!
    


!^R Home:! !^R Returns to previous buffer.
If given explicit arg, goes to that buffer.!

  FF"N'"# QPrevious_Buffer':M(M.MSelect_Buffer) 
				    !* Call select buffer with explicit arg!



!^R Half Window Down:! !^R Scroll screen down by half window!

  fs LINES[0			    !* number of lines on screen!
  Q0"G Q0/2' "# 10' :M(M.M^R_Next_Screen)
				    !* Next screen with explicit arg!

!^R Half Window Up:! !^R Scroll screen up by half window!

  fs LINES[0			    !* number of lines on screen!
  Q0"G Q0/2' "# 10' :M(M.M^R_Previous_Screen)
				    !* Previous screen with explicit arg!


!^R Toggle Terminal Width:! !^R Toggles window between 80 and 132 columns!
    FSWIDTH+1[a
    QA-80"G 80' "#132' :M(M.M Set_Terminal_Width)


!Set Terminal Width:! !C Set the terminal and display widths.
The only argument is the width of the display (a number between 80 and
132 inclusive).  The default is 80.!

    QVTXXX_Terminal_Type "L
	:I*CCannot_set_132_columns_on_a_VT52.
	fsechodisp 0fsechoactive
	'
    80[a			    !* QA gets the default terminal!
				    !* width!
    [B			    !* QB is the argument temporarily!
    QB-79"G
	QB-133"L		    !* Check if argument [80,132]!
	    QBUA''
    QA-80"G
	:@I*`<[?3h[0q[1q[2q`fsimageout'!>!
    "#w:@I*`<[?3l[0q[1q`FSimageout'!>!
    4				    !* sleep for 4 30ths of a second!
				    !* which is the delay time for!
				    !* 9600 baud!
    QA-1fswidth		    !* Change the width for teco!
    -1fs pjatyf+		    !* Need to refresh whole screen!


!Fix PHOTO File:! !S Strips a PHOTO file if created on a GVTXXX Terminal Name.!

    [8 [9
    M(M.M ^R_Widen_Bounds)
    QVTXXX_Terminal_Type"L		!* Only the VT52!
	j<:@s`j`; -2c.u8-sc.-q8u9q9d-q9d2d> !* Take care of deletes!
	j<:@s`j`; 0k>	    !* Clear lines,!
	j<:s ; fkd> !* Stray control characters!
	j<:s; fkd 4<13i 10i>>    !* CTRL-P are really half-page!
	j<:s
	    ; r 13i> '		    !* Stray linefeeds!
    "#					!* Others!
	j<:@s`[D[J`; FKD -D>	    !* Take care of deletes!
	j<:@s`[J`; 0k>	    !* Clear lines,!
	j<:s ; fkd> !* Stray control characters!
	j<:s; fkd 4<13i 10i>>    !* CTRL-P are really half-page!
	j<:s
	    ; r 13i> '		    !* Stray linefeeds!
    j

!^R VT52 Control-S:! !^R Act like old ^S, but ignore ^S^Qs.
	^S^Q is ignore.  ^S^Vx becomes old^Sx.  Any other characters
following are as if to old^S.  ^Sx becomes old^Sx if x is not ^Q or
^V.!

 !* Old^S is in $Non-VT52 Control-S$. *!

    m.i :fi[1			    !* 1: Next char after ^S!
    200.+Su..0		    !* ..0: ^S, since .I smashes.  I.e.!
				    !* simulate ^R calling the ^S!
    q1-"e fiw 1'		    !* Gobble the ^Q!
    q1-"e fiw'		    !* Gobble the ^V!
    f @mNon-VT52 Control-S    !* Pass character or none to old C-S!

!& VTXXX Exit Hook:! !S Setup to exit gracefully to an inferior or superior!

    QVTXXX_Mode F(UVTXXX_Exit_Mode) "N
	M(M.M VTXXX_Normal_Keypad)'
    0FO..Q System_Superior_Type"E
	"N				!* Only if to a superior!
	    0fo..q *Initialization*u1 
	    fq1"l :i1'
	    @:i*`1wm(m.m &_VTXXX_Return_Hook)`m.v *Initialization*
	    ]1''
	

!& VTXXX Return Hook:! !S Setup to return gracefully to the editor!

    M(M.M VTXXX_Alternate_Keypad)	!* Turn things on!
    1 FO..Q VTXXX_Exit_ModeF"E	!* Allows user to start with normal!
	M(M.M VTXXX_Normal_Keypad)'	!* keypad, ie. everything off!
    "# "L M(M.M VTXXX_Number_Keypad)''
    


!*
/ Local Modes: \
/ Entry Pointer:0  \
/ MM Compile: 1:<M(M.MDate Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)VTXXXVTXXX
1:<M(M.MDelete File)VTXXX.COMPRS>W \
/ End: \
!
   