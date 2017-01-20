!* -*-TECO-*- *!

!~FILENAME~:! !Commands to use Heath keypad!
HEATH3

!& Setup HEATH3 Library:! !S Sets up heath keypad.
Switches terminal to alternate keypad mode, shifted.  Sets up M-? as a prefix
character because ESC ? <char> is sent by some keys.

This is what the keys actually send:
Key:         f1 f2 f3 f4 f5 er bl re wh en  .  0  1  2  3  4  5  6  7  8  9
Un-shifted:  S T U V W E P Q R?M?n?p L B M D H C @ A N
Shifted:     S T U V W J P Q R?M?n?p?q?r?s?t?u?v?w?x?y

In unshifted mode, interchange above rows.

In normal (not alternate or shifted) mode the keys would send the following:
nrml:        S T U V W J P Q R   .  0  1  2  3  4  5  6  7  8  9
shft:        S T U V W E P Q R   .  0 L B M D H C @ A N
!
 @:i*|=u| FS Image Out	    !* set alt keypad mode, unshifted!

 128 M(m.mMake_Prefix_Char).Z U..? !* Dispatch table for Escape ? in .Z!
 128 M(m.mMake_Prefix_Char).Z U..O !* Dispatch table for Escape O in .Z!


!Heath3 Keys:! !C Sets up a default set of key bindings for the Heath keypad.
Keys are set up as follows.  Keys not listed do not send any special codes. 

F1      F2      F3      F4      F5      ERASE   S-ERASE BLUE    RED     WHITE  
------- ------- ------- ------- ------- ------- ------- ------- ------- -------
C-U     C-@     C-X C-X C-X W   C-X C-I M-DEL   M-W     C-X O   M-%     M-Q    


-------------------------------------------------------------------------------
|IC:^R Reverse Zap to Char|UP:^R Backward Paragraph |DC:^R Zap to Character   |
| 7:^R Reverse Character S| 8:^R Up Real Line       |DC:^R Character Search   |
-------------------------------------------------------------------------------
|LE:^R Backward Word      |HO:^R Previous Screen    |RI:^R Forward Word       |
| 4:^R Backward Character | 5:^R Next Screen        | 6:^R Forward Character  |
-------------------------------------------------------------------------------
|IL:^R Backward Kill Word |DO:^R Forward Paragraph  |DL:^R Kill Word          |
| 1:^R Backward Delete Cha| 2:^R Down Real Line     | 3:^R Delete Character   |
-------------------------------------------------------------------------------
|--:--------------------- |--:--------------------- |--:--------------------- |
| 0:^R Goto Beginning     | .:^R Extended Command   |EN:^R Goto End           |
-------------------------------------------------------------------------------
Beware: This function sets some Meta-capital keys for commonly used functions.
It preserves the definitions on the lower case keys, but 1) it should not be
called twice and 2) you must remember to use the lower case when you set one
of the keys after calling this function.  I recommend calling this function
after you've done all your other key defninitions.  If you keep in mind those
caveats and you don't use caps lock much, this library should not affect
your editing.!

 !* Set up a function in reg 0 which allows the Meta-capital keys to be set
    without affecting the definition of the Meta-lowercase keys!
 M(M.m Load_Library) STANLIB
 [0
 @:I0|[1 :i1 1+32[2  Q..1( U..1) U..2|

 M(m.m&_Load_Bare)		    !* Get primitives.!

 Q.U M0S			    !* Set F1 to C-U wo affecting M-s!
 Q.@ M0T			    !* Set F2 to C-@ wo affecting M-t!
 Q:.X()M0U			    !* Set F3 to C-X C-X wo affecting M-u!
 Q:.X(W) M0V			    !* Set F4 to C-X W wo affecting M-v!
 Q:.X(9) M0W			    !* Set F5 to C-X TAB wo affecting M-w!
 Q.. M0J			    !* Set ERASE to M-DEL wo affecting M-j!
 Q..W M0E			    !* Set S-ERASE M-W wo affecting M-e!
 Q:.X(O) M0P			    !* Set BLUE to C-X O wo affecting M-p!
 Q..Q M0R			    !* Set GRAY to M-Q wo affecting M-r!
 Q..% M0Q			    !* Set RED to M-% wo affecting M-q!

 M.m^R_Backward_Kill_Word M0L	    !* Set S-1 wo affecting M-l!
 M.m^R_Forward_Paragraph M0B	    !* Set S-2 wo affecting M-b!
 M.m^R_Kill_Word M0M		    !* Set S-3 wo affecting M-m!
 M.m^R_Backward_Word M0D	    !* Set S-4 wo affecting M-d!
 M.m^R_Previous_Screen M0H	    !* Set S-5 wo affecting M-h!
 M.m^R_Forward_Word M0C	    !* Set S-6 wo affecting M-c!
 M.m^R_Reverse_Zap_to_Character U..@	    !* Set S-7 (can't save M-@)!
 M.m^R_Backward_Paragraph M0A	    !* Set S-8 wo affecting M-a!
 M.m^R_Zap_to_Character M0N	    !* Set S-9 wo affecting M-n!

 M.m^R_Goto_Beginning U:.Z(p)    !* Set 0 !
 M.m^R_Backward_Delete_Character U:.Z(q) !* Set 1 !
 M.m^R_Down_Real_Line U:.Z(r)    !* Set 2 !
 M.m^R_Delete_Character U:.Z(s)  !* Set 3 !
 M.m^R_Backward_Character U:.Z(t)	    !* Set 4 !
 M.m^R_Next_Screen U:.Z(u)	    !* Set 5 !
 M.m^R_Forward_Character U:.Z(v) !* Set 6 !
 M.m^R_Reverse_Character_Search U:.Z(w)  !* Set 7 !
 M.m^R_Up_Real_Line U:.Z(x)	    !* Set 8 !
 M.m^R_Character_Search U:.Z(y)  !* Set 9 !
 M.m^R_Extended_Command U:.Z(n)  !* Set . !
 M.m^R_Goto_End U:.Z(M)	    !* Set enter !

