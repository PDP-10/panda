!* -*-TECO-*-!
!* <GERGELY.EMACS>NVT52.EMACS.11, 10-Jan-81 17:16:22, Edit by GERGELY!
!* <GERGELY.EMACS>NVT52..48,  9-May-80 08:47:46, Edit by GERGELY!

!~Filename~:! !VT52 Keypad Definitions and other Macros!
NVT52

!& Setup NVT52 Library:! !S Sets up the defaults for the VT52
keypad upon the entrance of the library.  The fork hooks are
defined so that the keypad is left in numeric mode upon
exiting.  There are keys that also get redefined.!
    0FO..QVT52_Setup_Hook[0 fq0"G :M0'

    M.VVT52_SETUP_HOOK
    @:iVT52_SETUP_HOOK/:i*CVT52_Library_has_already_been_loaded
    fs echo display 0 fs echo active/

    qReal_search_macrom.vNon-VT52 Control-S
    M.M^R_VT52_control-sM.VReal_search_macro

    0M.CTemporary_Vt52_storage Intermediate_storage_for_VT52_mode

    1M.CVT52_Mode! *_Non-zero_activates_alternate_Keypad!
    1FSMODECH$ 
    "'N-(q$Temporary_Vt52_storage$"'N)"E'
    "N :M(M.M VT52_Alternate_Keypad$)'
    __"# :M(M.M VT52_Normal_Keypad$)'

    M(M.M_&_SET_VT52_MODE_LINE)
 
   0fo..q Exit_to_Inferior_Hookf"E
        :i*M.V Exit_to_Inferior_HookW:i*'"#'[1
@:iExit_to_Inferior_Hook|1WM(M.M VT52_NORMAL_KEYPAD)|

    0fo..q Exit_to_superior_hookf"E
        :i*M.V Exit_To_Superior_Hookw:i*'"#'[2
@:iExit_to_superior_hook|2WM(M.M VT52_NORMAL_KEYPAD)|

    0fo..q Return_From_Inferior_Hookf"E
        :i*M.V Return_From_Inferior_HookW:i*'"#'[3
@:iReturn_From_Inferior_Hook|3W M(M.M VT52_ALTERNATE_KEYPAD)|

    0fo..q Return_From_Superior_Hookf"E
	:i*M.VReturn_From_Superior_Hookw:i*'"#'[4
@:iReturn_From_Superior_Hook|4 WM(M.M VT52_ALTERNATE_KEYPAD)|

    :M(M.M VT52_ALTERNATE_KEYPAD)
    

!VT52 ALTERNATE KEYPAD:! !C Sets alternate keypad mode for VT52's
then this command is executed, the keypad on the left and the arrow
keys are now executable commands.
  The terminal is put in CURSOR KEYS MODE and KEYPAD APPLICATION MODE.
This mode switching is done by valretting to DDT so if this job
does not have a DDT superior this command will fail.!

    128M(M.M MAKE_PREFIX_CHARACTER).YU..? !* Define the prefix key!

    M.M ^R_UP_REAL_LINE U..A    !* Up-Arrow!
    M.M ^R_DOWN_REAL_LINE U..B  !* Down-Arrow!
    6 fs ^R INIT U..C	    !* Forward-Arrow!
    2 fs ^R init U..D	    !* Backward-Arrow!
    
    M.M ^R_NEXT_SCREENU:.Y(M)   !* ENTER KEY!
    M.M ^R_BACKWARD_SENTENCEU:.X(S)	    !* Replacements,   ^X ^S !
    M.M ^R_KILL_WORDu:.X(V)	    !* ^X V !
    M.M ^R_BACKWARD_WORDU:.X(T) !* ^X T !
    M.M ^R_UPPERCASE_INITIALU:.X(C)	    !* ^X C !
    M.M ^R_UP_COMMENT_LINEU:.X(Z)	    !* ^X Z !
    M.M ^R_FILL_PARAGRAPHU:.X(Q)	    !* ^X Q !
    M.M ^R_MOVE_TO_SCREEN_EDGEU....	    !* C-M-. !
    M.M ^R_KILL_LINEU..P	    !* PF1!
    M.M ^R_EXECUTE_MINIBUFFER U..Q	    !* PF2!
    M.M ^R_UN-KILL U..R	    !* PF3!
    M.M ^R_PREVIOUS_SCREENU:.Y(N)	    !* DOT-KEY!
    14 FS ^R INIT U:.Y(P)	    !* 0-KEY!
    M.M ^R_GOTO_BEGINNING U:.Y(Q)	    !* 1-KEY!
    M.M ^R_GOTO_END	U:.Y(R) !* 2-KEY!
    1 FS ^R INIT U:.Y(S)	    !* 3-KEY!
    16 FS ^R INIT U:.Y(T)	    !* 4-KEY!
    M.M ^R_Proper_Delete_CharacterU:.Y(U)	    !* 5-KEY!
    M.M ^R_Delete_Last_Searched_ItemU:.Y(V)	    !* 6-KEY!
    15 FS ^R INIT U:.Y(W)	    !* 7-KEY!
    1,M.M &_SETUP_PAGE_LIBRARY"E   !* 8-KEY!
	M.M ^R_NEXT_PAGE U:.Y(X)'
    "# qemacs_version-138 :"G  M.M ^R_GO_TO_PAGE U:.Y(X)'
	"# M.M^R_goto_page u:.Y(X)' '
    M.M ^R_QUOTED_INSERT U:.Y(Y)	    !* 9-KEY!
    @:I*/=/FS IMAGE OUT	    !* Turn on APPLICATION MODE!
    .(f[ b bind		    !* Temporary Buffer!
	gprefix_char_list	    !* Update the Prefix list!
	j :s Meta-?__"EJ i Meta-?__Q.Y
'				    !* Let it recognize M-?!
	HFXPrefix_char_list	    !* Put the new one in!
	f] b bind)J
    1uTemporary_Vt52_storage
    1UVT52_MODE
    


!VT52 NORMAL KEYPAD:! !C Undos alternate keypad mode for VT52's!
    !<!@:I*/>/FS IMAGE OUT	    !* Turn off everything!
    M.M ^R_DESCRIBEU..?	    !* Restore Meta-?!
    .(f[ b bind		    !* Temporary Buffer!
	gprefix_char_list	    !* Update the Prefix list!
	j :s Meta-?__"N0lk'	    !* Let it not recognize M-?!
	HFXPrefix_char_list	    !* Put the new one in!
	f] b bind)J
    0uTemporary_Vt52_storage
    0UVT52_MODE
    


!VT52 Info:! !C Prints out the key definitions in display mode!

ft-----------------------------------------
|_"BLUE"__|__"RED"__|_"GREY"__|___"^"___|
|__Save___|__TECO___|_Unsave__|__Up_in__|_______Redefinitions
|__text___|_Command_|__text___|_column__|_______-------------
|---------+---------+---------+---------|
|___"7"___|___"8"___|___"9"___|___"v"___|__^R_Backward_Sentence_________C-X_S
|__Open___|__Page___|__Quote__|_Down_in_|__^R_Kill_Word_________________C-X_V
|__line___|_________|__next___|_column__|__^R_Backward_Word_____________C-X_T
|---------+---------+---------+---------|__^R_Uppercase_Initial_________C-X_C
|___"4"___|___"5"___|___"6"___|___">"___|__^R_Up_Comment________________C-X_Z
|___Up____|_Delete__|_Delete__|_Cursor__|__^R_Fill_Paragraph____________C-X_Q
|__line___|Character|__last___|__right__|__^R_Move_to_Screen_Edge_______C-M_.
|---------+---------+---------+---------|
|___"1"___|___"2"___|___"3"___|___"<"___|
|___Top___|_Bottom__|__Start__|_Cursor__|
|_of_page_|_of_page_|_of_line_|__left___|
|---------+---------+---------+---------|
|________"0"________|___"."___|_"ENTER"_|
|_____Down_Line_____|Previous_|__Next___|
|___________________|__Screen_|__Screen_|
|-------------------+---------+---------|



!& Set VT52 Mode Line:! !S Set the Mode line hook for the library!
    qSet_Mode_line_hook[1
    f[ b bind
    fq1"L :i1'
    g1 j
    :@S/VT52_MODE/"E @I/
	0FO..QVT52_MODE"NI_VT52'/'
    HXSET_MODE_LINE_HOOK
    1fs mode change
    

!^R Proper Delete Character:! !^R Delete the character after the point.
Negative arguments delete backwards!
    F"G M(4FS ^R INIT)'	    !* A positive argument is forward!
    "#   FS ^R RUBOUT'	    !* A negative one is backward!
     			    !* A fast refresh!

!^R Delete Last Searched Item:! !^R Deletes last searched item in buffer.
Will only work if the pointer hasn't moved!
    [0 [..O			    !* Q0 holds the last search item!
				    !* and push the buffer!
    QSEARCH_DEFAULT_RINGU..O	    !* These store the search items!
    .FSWORDU0			    !* Get the last searched item!
    ]..O			    !* Pop up the buffer!
    -FQ0 F~0"E -FQ0 M(M.M&_KILL_TEXT) '	    !* If a forward search!
    "# FQ0 F~0"E FQ0 M(M.M&_KILL_TEXT) ''	    !* A Reverse Search!
    

!Fix PHOTO File:! !S Strips a PHOTO file if created on a VT52!
    [8 [9
    FSRGETTY-4"E		    !* Check if we are on a VT52!
	j<:@s`j`; -2c.u8-sc.-q8u9q9d-q9d2d> !* Take care of deletes!
	j<:@s`j`; 0k>	    !* Clear lines,!
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


!VT52 Number Keypad:! !C Turns off the keypad to allow using the numbers.
The key definitions for the pad are still there upon returning with
VT52 Transmit Keypad!
    !<!@:I*/>/FS IMAGE OUT	    !* Turn off everything!
    

!VT52 Transmit Keypad:! !C Sets the keypad to transmit their escape seq.
If the key definitions need to be reset the user should use
VT52 Alternate Keypad.  This command is the opposite of
VT52 Number Keypad!
    @:I*/=/FS IMAGE OUT	    !* Turn on APPLICATION MODE!
    
    