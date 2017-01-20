!* -*-TECO-*-!
!* <GERGELY.EMACS>NVT100.EMACS.15,  8-Feb-81 10:14:50, Edit by GERGELY!
!* <GERGELY.EMACS>VT100..59,  6-May-80 08:39:13, Edit by GERGELY!

!~Filename~:! !VT100 Keypad Definitions!
TEKVT100

!& Setup TEKVT100 Library:! !S Sets up the defaults for the VT100
keypad upon the entrance of the library.  The fork hooks are
defined so that the keypad is left in numeric mode upon
exiting.!
  0FO..QVT100_Setup_Hook[0 fq0"G :M0'
  M.VVT100_SETUP_HOOK
  @:iVT100_SETUP_HOOK/:i*CVT100_Library_has_already_been_loaded
fs echo display 0 fs echo active/
 
0M.CTemporary_Vt100_storage Intermediate_storage_for_VT100_mode

1M.CVT100_Mode! *_Non-zero_activates_alternate_Keypad!
"'N-(q$Temporary_Vt100_storage$"'N)"E'
1FSMODECH$ 
"N :M(M.M VT100_Alternate_Keypad$)'
__"# :M(M.M VT100_Normal_Keypad$)'

M(M.M_&_SET_VT100_MODE_LINE)

   0fo..q Exit_to_Inferior_Hookf"E
        :i*M.V Exit_to_Inferior_HookW:i*'"#'[1
@:iExit_to_Inferior_Hook|1WM(M.M VT100_NORMAL_KEYPAD)|

    0fo..q Exit_to_superior_hookf"E
        :i*M.V Exit_To_Superior_Hookw:i*'"#'[2
@:iExit_to_superior_hook|2WM(M.M VT100_NORMAL_KEYPAD)|

    0fo..q Return_From_Inferior_Hookf"E
        :i*M.V Return_From_Inferior_HookW:i*'"#'[3
@:iReturn_From_Inferior_Hook|3W M(M.M VT100_ALTERNATE_KEYPAD)|

    0fo..q Return_From_Superior_Hookf"E
	:i*M.VReturn_From_Superior_Hookw:i*'"#'[4
@:iReturn_From_Superior_Hook|4 WM(M.M VT100_ALTERNATE_KEYPAD)|

  :M(M.M VT100_ALTERNATE_KEYPAD)'

!VT100 ALTERNATE KEYPAD:! !C Sets alternate keypad mode for VT100's
When this command is executed, the keypad on the left and the arrow
keys are now executable commands.!

128 M(M.M MAKE_PREFIX_CHARACTER).OU..O	!* Define the prefix key!

M.M ^R_Up_Real_Line U:.O(A)			!* Up-Arrow!
M.M ^R_Down_Real_Line U:.O(B)		!* Down-Arrow!
6 fs ^R Init U:.O(C)			!* Forward-Arrow!
2 fs ^R init U:.O(D)			!* Backward-Arrow!

M.M ^R_Exit U:.O(M)				!* Enter key!
M.M Find_File U:.O(P)			!* PF1!
M.M ^R_Save_File U:.O(Q)			!* PF2!
M.M ^R_Copy_Region U:.O(R)			!* PF3!
M.M ^R_Un-Kill U:.O(S)			!* PF4!

M.M ^R_Next_Screen U:.O(l)			!* Comma-key!
M.M ^R_Previous_Screen U:.O(m)		!* Minus-key!
M.M ^R_Prefix_Control-Meta U:.O(n)		!* Dot-key!
M.M ^R_Prefix_Meta U:.O(p)			!* 0-key!
M.M ^R_Backward_Word U:.O(q)		!* 1-key!
M.M ^R_Forward_Paragraph U:.O(r)		!* 2-key!
M.M ^R_Forward_Word U:.O(s)			!* 3-key!
M.M ^R_Backward_Kill_Word U:.O(t)		!* 4-key!
M.M ^R_Delete_Character U:.O(u)		!* 5-key!
M.M ^R_Kill_Word U:.O(v)			!* 6-key!
01 fs ^R init U:.O(w)			!* 7-key!
M.M ^R_Backward_Paragraph U:.O(x)'		!* 8-KEY!
05 fs ^R init U:.O(y)			!* 9-key!

@:I*/[?1h/FS IMAGE OUT			!* Turn on CURSOR KEY!
@:I*/=/FS IMAGE OUT				!* Turn on APPLICATION MODE!
1M(M.M &_Set_VT100_Mode_line)
.(f[ b bind			    !* Temporary Buffer!
gprefix_char_list		    !* Update the Prefix list!
j :s Meta-O__"EJ i Meta-O__Q.O
'				    !* Let it recognize M-O!
HFXPrefix_char_list		    !* Put the new one in!
f] b bind)J
1uTemporary_Vt100_storage
1UVT100_MODE


!VT100 NORMAL KEYPAD:! !C Undos alternate keypad mode for VT100's!
@:I*/[?1l > /FS IMAGE OUT    !* Turn off everything!
M.M ^R_SPLIT_LINEU..O			!* Restore Meta-O!
M.M &_PREFIX_CHARACTER_DRIVERU.P		!* Restore Prefix-Driver!
.(f[ b bind			    !* Temporary Buffer!
gprefix_char_list		    !* Update the Prefix list!
j :s Meta-O__"N0lk'		    !* Let it not recognize M-O!
HFXPrefix_char_list		    !* Put the new one in!
f] b bind)J
0uTemporary_Vt100_storage
0UVT100_MODE


!& Set VT100 Mode Line:! !S Set the Mode line hook for the library!
qSet_Mode_line_hook[1
f[ b bind
fq1"L :i1'
g1 j
:@S/VT100_MODE/"E @I/
0FO..QVT100_MODE"N
FSRGETTY-47"E I_VT132'"#I_VT100''/'
HXSET_MODE_LINE_HOOK
1fs mode change


!Set Terminal Width:! !C Set the terminal and display widths.
The only argument is the width of the display (a number between 80 and
132 inclusive).  The default is 80.!

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
    0FO..QWindow_2_Size"N	    !* Some fancy stuff if in two!
				    !* window mode!
	M.M &_Multi-Window_RefreshF[refresh'
    1fsmodechange		    !* get the mode line as well!
    0f[lines
    

!VT100 Info:! !C Prints out the key definitions in display mode!

ft-----------------------------------------
|__"PF1"__|__"PF2"__|__"PF3"__|__"PF4"__|
|__Find___|__Save___|__Copy___|_Unkill__|___DEL_Delete_char_back
|__file___|__file___|_region__|__text___|___BREAK_Set_mark
|---------+---------+---------+---------|___ESC_Prefix-Meta
|___"7"___|___"8"___|___"9"___|___"-"___|
|Beginning|Backwards|_End_of__|Previous_|___Arrow_keys_are_defined_to_move
|_of_line_|paragraph|__line___|_screen__|___cursor_one_position_in_direction
|---------+---------+---------+---------|___indicated.
|___"4"___|___"5"___|___"6"___|___","___|
|Back_kill|_Delete__|Frwd_kill|__Next___|
|__word___|Character|__word___|_screen__|
|---------+---------+---------+---------|
|___"1"___|___"2"___|___"3"___|_"ENTER"_|
|Backwards|_Forward_|_Forward_|_________|
|__word___|paragraph|__word___|_________|
|---------+---------+---------|__Exit___|                                     
|________"0"________|___"."___|__EMACS__|                                     
|_______Meta-_______|__Ctrl-__|_________|                                     
|___________________|__Meta-__|_________|                                     
|-------------------+---------+---------|                                     
                                                                             

!VT100 Number Keypad:! !C Turns off the keypad to allow using the numbers.
The key definitions for the pad are still there upon returning with
VT100 Transmit Keypad!
    !<!@:I*/>/FS IMAGE OUT	    !* Turn off everything!
    

!VT100 Transmit Keypad:! !C Sets the keypad to transmit their escape seq.
If the key definitions need to be reset the user should use
VT100 Alternate Keypad.  This command is the opposite of
VT100 Number Keypad!
    @:I*/=/FS IMAGE OUT	    !* Turn on APPLICATION MODE!
    

!^R Toggle Terminal Width:! !^R Toggles window between 80 and 132 columns!
    FSWIDTH+1[a
    QA-80"G 80' "#132' :M(M.M Set_Terminal_Width)
