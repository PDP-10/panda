!* -*-TECO-*-!
!* <EMACS>CAPL.EMACS.2,  1-Jun-83 13:40:38, Edit by GERGELY!
!* <EMACS>CAPL.EMACS.10, 22-Apr-83 12:53:22, Edit by GERGELY!
!* <EMACS>CAPL.EMACS.5, 17-Nov-81 10:44:54, Edit by HEMPHILL!
!* <HOLMES>CAPL.EMACS.2,  7-Jul-80 03:05:13, Edit by HOLMES!
!* <XEMACS>CAPL..10,  8-Jun-80 13:48:00, Edit by GERGELY!
!* <EMACS>CAPL..5, 30-Apr-80 02:59:12, Edit by HOLMES!
!* <GERGELY.EMACS>CAPL..21, 25-Apr-80 10:22:35, Edit by GERGELY!

!~Filename~:! !CAPL Keypad Definitions!
CAPL

!& Setup CAPL Library:! !S Sets up the defaults for the CAPL keypad
upon the entrance of the library.!

    0FO..Q CAPL_Setup_Hook[0
    fq0"G :M0'

    M.V CAPL_Setup_Hook
    @:iCAPL_Setup_Hook/:i*CThe_CAPL_Library_has_already_been_loaded.
    fs echo display 0 fs echo active /

    0 M.V Capl_Keypad_Hook	    !* Have some option to change!

    0FO..Q^H_Mode F(M.V ^H_Mode
	)M.C ^H_Mode ! *
    Positive_implies_that_^H_is_invisible_and_counts_as_part_of_the_word
    Zero_implies_that_^H_is_visible_and_does_not_count_as_part_of_the_word.
    Negative_implies_backspace_does_a_cursor_left.!
    F"L 3fs^Rinit$uH		!* Less than 0 is normal backspace!
	8*5 :f..D_____
	95*5 :f..D_A___
	0 fs ^H PRINT'
    "# "G   65 fs ^R INIT$uH	!* + means invisible!
	    8*5 :f..DAA___
	    95*5 :f..DAA___
	    -1 fs ^H PRINT'
	"#  65 fs ^R INIT$uH	!* Zero means show backspace!
	    8*5 :f..D_____
	    95*5 :f..D_A___
	    0 fs ^H PRINT''
    fs ^H Print-(Q^H_Mode"'G)"N 
	WF'
	1fs MODE CH 		!* Terminates definition of ^H Mode!

    q^H_Mode:"L 65fs^RInituH'

    :I*FO..QTECO_Mode_Hook u0 @:I*\0w -1M.L^H_Mode\ M.VTECO_Mode_Hook

    1,M.M^R_Invoke_Inferior"E  M(M.MLoad_Library)Efork'

    0M.CTemporary_CAPL_storage Intermediate_storage_for_CAPL_mode

    1 FO..Q  CAPL_Default_Keypad_ModeM.V CAPL_Mode
    1M.CCAPL_Mode! *_-1_=_Execute_Pad,_0_=_No_Pad,_1_=_Alternate_keypad!
    "'N-(q$Temporary_CAPL_storage$"'N)"E'
    1FSMODECH$ 
    F"N "G :M(M.M CAPL_Alternate_Keypad$)'
	"# :M(M.M CAPL_Execute_Keypad)''
    "#W :M(M.M CAPL_Normal_Keypad$)'

    1 FO..Q CAPL_Default_Keypad_Mode M.V CAPL_Exit_mode
    QCAPL_Exit_Mode M.C CAPL_Exit_mode   !*
    !The_current_mode_of_the_terminal.__See_CAPL_Mode.

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
    @:i*`1w0m(m.m &_CAPL_Exit_Hook)`m.v Exit_to_Inferior_Hook

    0fo..q Exit_to_Superior_Hooku1 
    fq1"l :i1'
    @:i*`1w1m(m.m &_CAPL_Exit_Hook)`m.v Exit_to_Superior_hook

    0fo..q Return_From_Superior_hooku1 
    fq1"l :i1'
    @:i*`1w:m(m.m &_CAPL_Return_Hook)`m.vReturn_From_Superior_hook

    0fo..q Return_From_Inferior_hooku1 
    fq1"l :i1'
    @:i*`1w:m(m.m &_CAPL_Return_Hook)`m.vReturn_From_Inferior_Hook
    ]1

    27fs^Rcmac M.V CAPL_Original_Key

    M(M.M_&_SET_CAPL_MODE_LINE)

    M(M.M CAPL_Alternate_Keypad)

    1 FO..Q CAPL_Default_Keypad_ModeM.V CAPL_Default_Keypad_Mode

    QCAPL_Default_Keypad_ModeF"E	!* Allows user to start with normal!
	M(M.M CAPL_Normal_Keypad)'	!* keypad, ie. everything off!
    "# "L M(M.M CAPL_Execute_Keypad)''

    

!CAPL Alternate Keypad:! !C Sets alternate keypad mode for CAPLs
The keypad in the upper left is set to transmit mode and the altmode
key is used as its prefix driver.  To get the meta key use
^R Prefix Meta.!

!* Set up the keys!

    128 M(M.M MAKE_PREFIX_CHARACTER).o,27@fs^Rcmac

    @:i*|X|fsimageout		    !* Keypad on!

    0 FO..Q Saved_CAPL_Commands "E	!* Do only if no key definitions!
	1M(M.M &_CAPL_Original_Keypad)
	'
    0 FO..Q Capl_Keypad_hook[1	    !* Got a hook then do it!
    fq1"G WM1' W]1
    
    1:<QSaved_CAPL_Commands>"N
	:I*C Undefined_Keypad_in_effect fsechodisp 0fsechoactive
	'

    QSaved_CAPL_Commands U.O		!* Restore the commands!

    1M(M.M &_Set_CAPL_Mode_Line)

    .(f[ b bind			!* Temporary Buffer!
	gprefix_char_list		!* Update the Prefix list!
	j :S Esc__Q.O"E
	    IEsc__Q.O 13i10i'
	HFXPrefix_char_list		!* Put the new one in!
	f] b bind)J			!* !

    1uTemporary_CAPL_storage
    1UCAPL_MODE
    1fsmode change

    

!CAPL Normal Keypad:! !C Undos alternate keypad mode for CAPL's!

    Q.O USaved_CAPL_Commands		!* Save the commands!

    @:I*/x/FS IMAGE OUT		!* Turn off everything!

    .(f[ b bind			!* Temporary Buffer!
	gprefix_char_list		!* Update the Prefix list!
	j :s Esc__"N0lk'		!* Let it not recognize M-O!
	HFXPrefix_char_list		!* Put the new one in!
	f] b bind)J

    QCAPL_Original_Key,27@fs^Rcmac	!* Restore the original key!

    0uTemporary_CAPL_storage
    0UCAPL_MODE
    1fsmodechange
    

!CAPL Transmit Keypad:! !C Sets the keypad to transmit their escape seq.
If the key definitions need to be reset the user should use
CAPL Alternate Keypad.  This command is the opposite of
CAPL Execute Keypad!

    QCAPL_MODE"E
	:I*CYou_are_in_the_Normal_Keypad.__Use_M-X_CAPL_Alternate_keypad.(
	    )fsechodisp 0fsechoactive
	0'		!* Don't bother if already off!

    :FO..Q TEMPCAPLMODE"L 0'
    QTEMPCAPLMODE F(uTemporary_CAPL_storage) UCAPL_Mode
    M(M.M Kill_Variable)TEMPCAPLMODE
    @:I*/X/FS IMAGE OUT	    !* Turn on APPLICATION MODE!
    1 FS Mode Change
    


!CAPL Execute Keypad:! !C Turns alternate Keypad off.
The key definitions for the pad are still there upon returning with
CAPL Transmit Keypad!

    QCAPL_MODEF"E
	:I*CThe_Execute_Pad_is_already_on.fsechodisp 0fsechoactive W0
	'M.V TEMPCAPLMODE	!* Store the original mode type!
    -1 uTemporary_CAPL_storage
    -1 UCAPL_Mode
    @:i*|x|fsimageout
    1 fs mode change
    

!CAPL Info:! !C Prints out the key definitions in display mode.
A numeric argument implies that a one line description will be given
for each key.!

    Q$ FP-101"N			!* use Meta-O!
	:I*C The_keypad_is_currently_turned_off. fsechodisp
	0fsechoactive
	'

    M(M.M &_Load_BARE)			!* Load Bare for other things!
    [A FF "E :IA' "# :IA One'

    -1f[truncate
    FT The_currently_defined_CAPL_keypad_is:


    :I*Mult_Code,Q:.O(:) M(M.M &_CAPL_Briefly_Describe)A
    :I*Break,Q:.O() M(M.M &_CAPL_Briefly_Describe)A
    ft

    :I*Up-Arrow,Q:.O(;) M(M.M &_CAPL_Briefly_Describe)A
    :I*Left-Arrow,Q:.O(62) M(M.M &_CAPL_Briefly_Describe)A
    :I*Home,Q:.O(?) M(M.M &_CAPL_Briefly_Describe)A
    :I*Right-Arrow,Q:.O(=) M(M.M &_CAPL_Briefly_Describe)A
    :I*Down-Arrow,Q:.O(60) M(M.M &_CAPL_Briefly_Describe)A
    ft

    :I*Reset/Stat,Q:.O(+) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Shifted,Q:.O(,) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control,Q:.O(+) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control-shifted,Q:.O(,) M(M.M &_CAPL_Briefly_Describe)A
	ft

    :I*Print,Q:.O({) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Shifted,Q:.O(|) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control,Q:.O(}) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control-shifted,Q:.O(~) M(M.M &_CAPL_Briefly_Describe)A
    ft

    :I*Page,Q:.O(-) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Shifted,Q:.O(.) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control,Q:.O(-) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control-shifted,Q:.O(.) M(M.M &_CAPL_Briefly_Describe)A
    ft

    :I*Tape,Q:.O(`) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Shifted,Q:.O(`) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control,Q:.O(@) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control-shifted,Q:.O(^) M(M.M &_CAPL_Briefly_Describe)A
    ft

    :I*Scroll,Q:.O([) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Shifted,Q:.O(\) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control,Q:.O([) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control-shifted,Q:.O(\) M(M.M &_CAPL_Briefly_Describe)A
    ft

    :I*Tab_Set/Clr,Q:.O(]) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Shifted,Q:.O(95) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control,Q:.O(]) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control-shifted,Q:.O(95) M(M.M &_CAPL_Briefly_Describe)A
    ft

    :I*Tab,Q	 M(M.M &_CAPL_Briefly_Describe)A
    :I*__Shifted,Q:.O(39) M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control,Q	 M(M.M &_CAPL_Briefly_Describe)A
    :I*__Control-shifted,Q:.O(39) M(M.M &_CAPL_Briefly_Describe)A
    ft

    ft
Done.



!Get Keypad Definitions From File:! !C Reads a set of keypad definition from a file.
The file should look like standard teco putting function definitions on the
prefix character which is referenced by the Q-Vector .O
A numeric argument will load in the original keypad definitions first.!

    f[DFILE 0f[DVERSION w[Buffer_Filenames	!* Push all IO!
    E[ E\ FN E^ E]			!* Push input channel and prepare!
    fshsname[A				!* Get the login directory!
    ETACAPL.PAD.0			!* Set the default name!
    ]B ]A
    5,4F Keypad_File[F		!* Read in the file!
    FF"N 1 M(M.M &_CAPL_Original_Keypad)'	!* An argument was specified!
    f[BBIND				!* Push the buffer!
    1:<ER F>"E @Y M(HFX*(f]bbind))'	!* Read in the file and macro it!
    "# :I*C Could_not_read_the_file_F. fsechodisp 0fsechoactive 0'

    Q.O M.V Saved_CAPL_Commands	!* Save the new commands!
    FF"N '			!* If the argument was specified then!
					!* quit!
    :I*C Pad_definitions_saved.__Please_run_M-X_CAPL_Alternate_keypad$!*
    !fsechodisp			!* Output a message!
    0fsechoactive			!* Leave it on the screen!
    


!Fix PHOTO File:! !C Strips a PHOTO file if created on a CAPL.!

    [8 [9
    M(M.M ^R_Widen_Bounds)
	j<!<!:@s`>`; FKD -D>	!* Take care of deletes!
	j<:@s``; 0k>			!* Clear lines,!
	j<:s ; fkd>	!* Stray control characters!
	j<:s; fkd 4<13i 10i>>	!* CTRL-P are really half-page!
	j<:s
	    ; r 13i> '			!* Stray linefeeds!
    j

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
				    !* Previous screen with explicit!
				    !* arg!
    

!^R Toggle ^H Mode:! !^R Enter or leave mode really displaying ^H.
Without an argument, toggles ^H mode. With an argument of 0, leaves ^H
mode. With a non-zero argument, enters ^H mode (^H really prints and 
counts as part of a word).!

    Q^H_Mode "E 1' "# 0' [0	    !* Assume no agr. thus toggle !
    FF "N "'L-("'G) U0'    !* If an arg. then use it !
    q0 u^H_Mode
    0



!& CAPL Autoarg:! !S An Autoarg that works from prefix chars.!

    0 FS ^R LAST
    Q..1 +400. FS REREAD
    

!& CAPL Briefly Describe:! !S Briefly describes a command.
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
    Q1FP-101"E				!* AN IMPURE STRING =) MIGHT BE A!
					!* PREFIX CHAR!
        F~1!PREFIX!-9"E
            FT is_an_escape-prefix_for_more_commands.
 ''
    Q1M(M.M&_MACRO_NAME)[2		!* Get full name in q1!
    Q2"N Q2U1
	q9"N
	    fq0-8"L ft	'
	    fq0-16"L ft	'
	    FT	runs_
	    FT1:
	    M.M~DOC~_1 U1	    !* Get the documentation string in q1!
	    F[ B BIND
	    G1 J FWKD :@L .,ZK	    !* GET JUST ITS 1ST LINE, SANS CLASS NAME.!
	    FT
	    			 HT'
	"# 
	    fq0-8"L ft	'
	    fq0-16"L ft	'
	    FT	1'
	FT
 '				    !* AND PRINT IT.!

!*** IT IS NOT ONE OF THE THINGS WHOSE BRIEF DESCRIPTION IS DIFFERENT!
!*** FROM ITS FULL DESCRIPTION, SO GET THE FULL ONE.!
    fq0-8"L ft	'
    fq0-16"L ft	'
    FT	
    F :M(M.M ^R_DESCRIBE)



!& CAPL Original Keypad:! !S Creates the original keypad prefix table.  
It does this by executing the file EMACS:CAPL.PAD and then PS:<LOGIN>CAPL.PAD.
The format of these files is simply straight TECO code to set a definition on
a key in the prefix table .O.  It creates the variable Saved CAPL Commands.  A
numeric argument prevents the warning message from being sent if an error
occurs. !

    f[DFILE 0f[DVERSION w[Buffer_Filenames	!* Push all IO!
    E[ E\ FN E^ E]			!* Push input channel and prepare!
    fshsname[A				!* Get the login directory!
    :IBCAPL.PAD
    f[bbind
    1:<ER emacs:B @Y M(HFX*)>
    1:<ER AB>"E @Y M(HFX*)'
    Q.O M.V Saved_CAPL_Commands
    FF"N '
    :I*C CAPL_Pad_definitions_created_and_savedfsechodisp
    0fsechoactive

    M(M.M CAPL_Alternate_Keypad)

    1 FO..Q CAPL_Default_Keypad_ModeF"E	!* Allows user to start with normal!
	M(M.M CAPL_Normal_Keypad)'	!* keypad, ie. everything off!
    "# "L M(M.M CAPL_Execute_Keypad)''
    
    


!& CAPL Exit Hook:! !S Setup to exit gracefully to an inferior or superior!

    QCAPL_Mode F(UCAPL_Exit_Mode) "N
	M(M.M CAPL_Normal_Keypad)'
    0FO..Q System_Superior_Type"E
	"N				!* Only if to a superior!
	    0fo..q *Initialization*u1 
	    fq1"l :i1'
	    @:i*`1wm(m.m &_CAPL_Return_Hook)`m.v *Initialization*
	    ]1''
	


!& CAPL Return Hook:! !S Setup to return gracefully to the editor!

    M(M.M CAPL_Alternate_Keypad)	!* Turn things on!
    1 FO..Q CAPL_Exit_ModeF"E	!* Allows user to start with normal!
	M(M.M CAPL_Normal_Keypad)'	!* keypad, ie. everything off!
    



!& Set CAPL Mode Line:! !S Set the Mode line hook for the library!
    0 FO..Q Set_Mode_line_hook F"E
	W:I*m.v Set_Mode_Line_hook w :I*'[1
    f[ b bind
    g1 j
    :@S/CAPL_MODE/"E @I/
	I_ 0FO..QCAPL_MODEF"N "L I#' "# I+''"# WI-'
	    ICAPL/'
    :@S/^H_Mode/"E
	@I/0FO..Q^H_ModeF"G
	    I_^H+'"#"LI_^H-'"#I_^H ''/
	'
    HXSET_MODE_LINE_HOOK
    1fs mode change


!* 
/ Local Modes: \
/ MM Compile: 1:<M(M.MDate Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)CAPLCAPL
1:<M(M.MDelete File)CAPL.COMPRS>W \
/ End: \
!  