!* -*- Teco -*- *!

!~Filename~:! !Emacs Library for DM3025 intelligent terminals!
DM3025

!& Setup DM3025 Library:! !& Set up the world for editting with DM3025 keys
Make <Uparrow>    do ^R Up Real Line
Make <Downarrow>  do ^R Down Real Line
Make <Leftarrow>  do ^R Backward Character (default)
Make <Rightarrow> do ^R Forward Character
Make EEOL         do ^R Kill Line
Make EEOS	  do ^R Kill Rest of Buffer
Make HOME	  do ^R Home Cursor
Make PF1	  do ^R Goto Beginning
Make PF2	  do ^R Goto End
Make PF3	  do ^R Next Screen
Make PF4	  do ^R Previous Screen
Make PF9	  do ^R Save File
Make PF10	  do ^R Return to Superior  !

0fo..Q DM3025_Library_Loaded"e	    !* If first time library was loaded !
 q..p M.V Pre-DM3025_Meta-p 	    !*   Save old Meta-p		!
 q..q M.V Pre-DM3025_Meta-q 	    !*   Save old Meta-q		!
 q..r M.V Pre-DM3025_Meta-r 	    !*   Save old Meta-r		!
 q..s M.V Pre-DM3025_Meta-s 	    !*   Save old Meta-s		!
 q..t M.V Pre-DM3025_Meta-t 	    !*   Save old Meta-t		!
 q..u M.V Pre-DM3025_Meta-u 	    !*   Save old Meta-u		!
 q..v M.V Pre-DM3025_Meta-v 	    !*   Save old Meta-v		!
 q..w M.V Pre-DM3025_Meta-w 	    !*   Save old Meta-w		!
 q..x M.V Pre-DM3025_Meta-x 	    !*   Save old Meta-x		!
 q..y M.V Pre-DM3025_Meta-y 	    !*   Save old Meta-y		!
 q..A M.V Pre-DM3025_Meta-A 	    !*   Save old Meta-A		!
 q..C M.V Pre-DM3025_Meta-C 	    !*   Save old Meta-C		!
 q..H M.V Pre-DM3025_Meta-H 	    !*   Save old Meta-H		!
 q..J M.V Pre-DM3025_Meta-J 	    !*   Save old Meta-J		!
 q..K M.V Pre-DM3025_Meta-K 	    !*   Save old Meta-K		!
 qJ   M.V Pre-DM3025_Tab    '    !*   Save old Linefeed		!
				    !*					!
1 m.v DM3025_Library_Loaded	    !* Mark this library as loaded	!
				    !*					!
m.m ^R_Up_Real_Line        u..A  !* Up arrow	goes up vertically	!
m.m ^R_Forward_Character   u..C  !* Right arrow goes char forward	!
m.m ^R_Down_Real_Line      uJ    !* Down arrow goes down vertically	!
m.m ^R_Kill_Line           u..K  !* EEOL kills end of line		!
m.m ^R_Home_Cursor	    u..H  !* HOME puts cursor in screen corner!
m.m ^R_Kill_Rest_of_Buffer u..J  !* EEOS kills rest of buffer	!
m.m ^R_Program_Function_1  u..p  !* PF1 goes to the beginning	!
m.m ^R_Program_Function_2  u..q  !* PF2 goes to the end of the file	!
m.m ^R_Program_Function_3  u..r  !* PF3 goes to the next screen	!
m.m ^R_Program_Function_4  u..s  !* PF4 goes to the previous screen	!
m.m ^R_Program_Function_9  u..x  !* PF9 saves the file		!
m.m ^R_Program_Function_10 u..y  !* PF10 returns to superior		!
				    !*					!
0				    !* Return				!

!^R Forward Character:! !Go forward a character!

:c"e zj'0			    !* Go forward arg chars or end of buffer !

!^R Kill Rest of Buffer:! !^R Kill from point to end of buffer !

.,z m(m.m &_Save_for_Undo) DM3025_<EEOS>  !* Allow MM Undo to recover!
.,z f( k ) 			    !* Return region changed		!

!^R Home Cursor:! !^R Put Cursor in top left corner of screen (or buffer)
With no arg, jump top corner of screen
With an arg, jump to top of buffer!

ff"e fswindow'j 0	    !* Move cursor and return		!

!& Kill DM3025 Library:! !& Undo the effects of loading DM3025 library  !

0fo..Q DM3025_Library_Loaded"n
  q Pre-DM3025_Meta-p    u..p   !* Restore Meta-p			!
  q Pre-DM3025_Meta-q    u..q   !* Restore Meta-q			!
  q Pre-DM3025_Meta-r    u..r   !* Restore Meta-r			!
  q Pre-DM3025_Meta-s    u..s   !* Restore Meta-s			!
  q Pre-DM3025_Meta-t    u..t   !* Restore Meta-t			!
  q Pre-DM3025_Meta-u    u..u   !* Restore Meta-u			!
  q Pre-DM3025_Meta-v    u..v   !* Restore Meta-v			!
  q Pre-DM3025_Meta-w    u..w   !* Restore Meta-w			!
  q Pre-DM3025_Meta-x    u..x   !* Restore Meta-x			!
  q Pre-DM3025_Meta-y    u..y   !* Restore Meta-y			!
  q Pre-DM3025_Meta-A    u..A   !* Restore Meta-A			!
  q Pre-DM3025_Meta-C    u..C   !* Restore Meta-C			!
  q Pre-DM3025_Meta-H    u..H   !* Restore Meta-H			!
  q Pre-DM3025_Meta-J	  u..J   !* Restore Meta-J			!
  q Pre-DM3025_Meta-K    u..K   !* Restore Meta-K			!
  q Pre-DM3025_Tab	  uJ	    !* Restore Linefeed			!
  0 uDM3025_Library_Loaded'	    !* Mark this library as unloaded	!
0				    !* Return				!

!^R Program Function 1:! !& Goto beginning of file and ignore CR !

fslisten"e oNormal'		    !* If no typeahead, normal M-P	!
:fi-"e			    !* If the pending char is Return	!
 fiw				    !*  Read and ignore char		!
 f:@m(m.m ^R_Goto_Beginning)'    !*  Jump to ^R Goto Beginning	!
!Normal!			    !* Come here if normal M-P		!
f:@m..P			    !* Re-route through M-Cap-P		!

!^R Program Function 2:! !& Goto end of file and ignore CR !

fslisten"e oNormal'		    !* If no typeahead, normal M-Q	!
:fi-"e			    !* If the pending char is Return	!
 fiw				    !*  Read and ignore char		!
 f:@m(m.m ^R_Goto_End)' 	    !*  Jump to ^R Goto End		!
!Normal!			    !* Come here if normal M-Q		!
f:@m..Q			    !* Re-route through M-Cap-Q		!

!^R Program Function 3:! !& Goto next screen and ignore CR !

fslisten"e oNormal'		    !* If no typeahead, normal M-R	!
:fi-"e			    !* If the pending char is Return	!
 fiw				    !*  Read and ignore char		!
 f:@m(m.m ^R_Next_Screen)'	    !*  Jump to ^R Next Screen		!
!Normal!			    !* Come here if normal M-R		!
f:@m..R			    !* Re-route through M-Cap-R		!

!^R Program Function 4:! !& Goto previous screen and ignore CR !

fslisten"e oNormal'		    !* If no typeahead, normal M-S	!
:fi-"e			    !* If the pending char is Return	!
 fiw				    !*  Read and ignore char		!
 f:@m(m.m ^R_Previous_Screen)'   !*  Jump to ^R Previous Screen	!
!Normal!			    !* Come here if normal M-S		!
f:@m..S			    !* Re-route through M-Cap-S		!

!^R Program Function 9:! !& Save file and ignore CR !

fslisten"e oNormal'		    !* If no typeahead, normal M-X	!
:fi-"e			    !* If the pending char is Return	!
 fiw				    !*  Read and ignore char		!
 f:@m(m.m ^R_Save_File)'	    !*  Jump to ^R Save File		!
!Normal!			    !* Come here if normal M-X		!
f:@m..X			    !* Re-route through M-Cap-X		!

!^R Program Function 10:! !& Return to superior and ignore CR !

fslisten"e oNormal'		    !* If no typeahead, normal M-Y	!
:fi-"e			    !* If the pending char is Return	!
 fiw				    !*  Read and ignore char		!
 f:@m(m.m ^R_Return_to_Superior)'!*  Jump to ^R Return to Superior	!
!Normal!			    !* Come here if normal M-Y		!
f:@m..Y			    !* Re-route through M-Cap-Y		!
