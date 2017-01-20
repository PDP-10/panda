!* -*-TECO-*- Library written by David Eppstein <Kronj@Sierra>, 3-Jul-85!

!~Filename~:! !Macros for editing wide screen pictures!
EPICT

!Edit Picture:! !C Edit a wide screen picture.
Puts you in a recursive editing session, with only 72 columns of the display
visible.  Tab will change the start of the visible columns.

If there is text remaining on either side of the lines then that
side will be bordered by "\\".  The user is responsible for making sure that
these line up (visually, don't worry about tabs) when exiting or changing
the viewed column.  Overwrite mode is set.!

 q..O m.v Picture_Real_Buffer	    !* Save our editing buffer!
 0[..F f[BBind			    !* No funny changes. Get a temporary one!
 0 m.v Picture_Display_Column	    !* Starting at column 0!
 [..J m(m.m &_Set_Picture_Display) !* Fill it with the real buffer contents!
 m.m ^R_Change_Picture_Display_Column[I  !* Tab changes dpy col!
 m.m ^R_Edit_Picture_Kill_Line[.K	    !* c-K kills lines!
 m.m ^R_Edit_Picture_New_Line[M	    !* CR  inserts line before pt!
 m.m ^R_Edit_Picture_Open_Line[.O	    !* c-O inserts after pt!
 1[Overwrite_Mode		    !* Text overwrites!
 				    !* Perform recursive edit!
 m(m.m &_Update_Picture_Buffer)    !* Put pictures back!
 				    !* Odd changes to screen display!

!^R Change Picture Display Column:! !^R Redisplay on a new column.
Argument is increment to add to column; if no argument is given,
display column is reset to zero.!

 ff"e 0'"# qPicture_Display_Column+'[0 !* Get new display column!
 q0"l 0u0'			    !* Make sure non-negative!
 m(m.m &_Update_Picture_Buffer)    !* Get changes from old display!
 q0uPicture_Display_Column	    !* Set new display column!
 m(m.m &_Set_Picture_Display)	    !* Display from it!
 				    !* Odd changes to screen display!

!^R Edit Picture Kill Line:! !^R Perform c-K within picture!

 m(m.m &_Update_Picture_Buffer)    !* Get changes from old display!
 qPicture_Real_Buffer[..O	    !* Back to real buffer!
 f@m(m.m ^R_Kill_Line)	    !* Perform c-K!
 ]..O				    !* Back to display buffer!
 m(m.m &_Set_Picture_Display)	    !* Put everything back!
 .[0 .,(:l . (q0j))		    !* Dpy changed to end of line!

!^R Edit Picture New Line:! !^R Insert CRLF before point!

 m(m.m &_Update_Picture_Buffer)    !* Get changes from old display!
 .[0 qPicture_Real_Buffer[..O	    !* Back to real buffer!
 "l -'"# '< i 
 >	    !* Insert the CRLFs!
 ]..O				    !* Back to display buffer!
 m(m.m &_Set_Picture_Display)	    !* Put everything back!
 .(:l .u1)j			    !* Get end of this display line!
 "l q0j'			    !* Neg arg returns at start of text!
 q0,q1			    !* Return changed display buf bounds!

!^R Edit Picture Open Line:! !^R Insert CRLF after point!

 -:m(m.m ^R_Edit_Picture_New_Line)	    !* Neg arg to before point fn!

!& Set Picture Display:! !S Fill display buf with partial lines from real buf!

 [0[1[2[3[4[5			    !* Get some scratch space!
 fs ^R VPosu5			    !* Store cursor position!
 hk q..Ou2			    !* Clear out buffer and save!
 qPicture_Display_Columnu3	    !* Get virtual line start!
 qPicture_Real_Buffer[..O	    !* Back to real buffer!
 fs SHPos-q3u0			    !* Remember pos in line!
 q0-72"g 72u0' q0"l 0u0'	    !* Trim at virtual line end!
 0u1 0l < b-.; -l %1 >		    !* Count lines!
 m(m.m Untabify)		    !* Flush tabs into spaces!

 !* For each line in real buffer, make a line in the virtual buffer!
 < .-z; :x4 q2[..O		    !* Pick up line, switch to display buf!
   fq4-q3"g q3,(fq4):g4u4'"# :i4'  !* Trim beginning!
   fq4-72"g 0,72:g4u4 :i44\\'    !* Trim end!
   q3"n i\\'			    !* Show trimmed line start!
   g4 72-(fq4)f"g,_i'w	    !* Fill out line body!
   i  
' ]..O l >		    !* Finish line, pop buffer, kill line end!

 q2[..O				    !* Back to display buffer!
 0fsModifiedw 0fsXModifiedw	    !* Not different from real buffer!
 j q1l q3"n 2+'q0c		    !* Go to main buffer position!
 :g3u3				    !* Stringify column number!
 :i..J (Editing_picture,_column_3,_return_with_c-m-Z)    !* Set mode line!
 f q5:f			    !* Fix up window!
 

!& Update Picture Buffer:! !S Propagate display buf changes back to real buf!

 [0[1[2[3[4[5 q..Ou3		    !* Get some scratch space!
 qPicture_Display_Columnu0	    !* Get where we're starting!
 fsSHPosu1 q0"n q1-2u1' q1+q0u1    !* Get real display column!
 0u2 0l < b-.; -l %2 >		    !* Count lines!
 fs Modifiedu5			    !* Remember if changed!
 j m(m.mUntabify)		    !* Make sure no tabs!
 qPicture_Real_Buffer[..O j	    !* Push to real buffer!

 q5"n < .-z;			    !* Exit when get to end of buffer!
   q3[..O q0"n 2c' :x4 0,72:g4u4 l ]..O	    !* Pick up next line from dpy buf!
   :l fq4+q0-(fs SHPos)f"g,_i'w  !* Fill out end of line with spaces!
   0l q0c f4		    !* Replace with new text!
   :l -@f	_k l >'	    !* Flush trailing space and move on!

 j q2l q1c			    !* Get to position in real buffer!
 ]..O j q2l q1c			    !* And in display buffer!
 
