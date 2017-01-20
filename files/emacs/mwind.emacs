!* -*-TECO-*- library written by David Eppstein <Kronj at SU-Sierra>
	      for Rational Machines Inc.!

!~Filename~:! !More than two windows on a screen!
MWIND

!* Windows are stored in a q-vector with the following slots per window:
      1 |*winptr| -- Point, relative to virtual beginning
      2 |*winwin| -- fs Window
      3 |*winsiz| -- Number of lines in window
      4 |*wintop| -- Top line of window
      5 |*winbuf| -- Buffer name
      6 |*winbeg| -- Virtual beginning, or page number, or -1
      7 |*winend| -- Virtual end, or -1
   but for compatibility the following vars are also maintained:
      Window 1/2 Buffer
      Window 1/2 Pointer
      Window 1/2 Window
      Window 1/2 Size
   the current window number is kept in qCurrent_Window
   the number of slots per window is kept in the 0th slot of the vector.
   !

!& Setup MWIND Library:! !S Set environment for windowing.
If the variable MWIND Setup Hook exists, it is macroed.
Otherwise, several keys are set:
    c-X 1  gets  ^R Kill Windows
    c-X 2  gets  ^R Split Window
    c-X 3  gets  ^R Redistribute Windows
    c-X 4  gets  ^R Visit in New Window
    c-X ^  gets  ^R Grow Window
    c-X O  gets  ^R Goto Window
    c-m-V  gets  ^R Scroll Other Window
All of the old two-window commands are shadowed.!

 -1fo..q MWIND_Load_Count+1 f"g uMWIND_Load_Count
    :i* MWIND_library_already_loaded fg 0'
 "# m.v MWIND_Load_Count'

 8*5fs QVec[W			    !* make vector for window info!
 qWm.v Window_Vector		    !* save it!
 7u:W(0)			    !* set number of entries per window!
 qBuffer_Nameu:W(5!*winbuf!)	    !* get buffer name!
 fs Height-(fs Echo Lines)-1u:W(3!*winsiz!)
 0u:W(4!*wintop!)		    !* ...top line and size!
				    !* (dont save others now)!
 1m.v Current_Window		    !* make var for holding selected window!

 0m.v In_MWIND_Deselect	    !* Make flag var to avoid recursion!

 m.m Kill_Variable[K		    !* Get variable killer!
 mK MM_&_Check_Window_Sizes	    !* Always use this file's version of this!

 m.m &_Save_Old_Definition[S	    !* Kill MM-var defs of functions to shadow!
 mS ^R_Other_Window
 mS ^R_Two_Windows
 mS ^R_One_Window
 mS ^R_Grow_Window
 mS ^R_Scroll_Other_Window

 0fo..Q Window_2_Size"n	    !* old two-window mode?!
    fs Top_Line(		    !* save top line over one-window change!
       m(m(m.m &_Get_Library_Pointer)EMACS m.m ^R_One_Window)
       )"e 1,'m(m.m ^R_Two_Windows)'	    !* go to two windows!

 m.m &_Multiple_Window_Refresh fs Refresh

 fs TTY Macro[0		    !* Get old tty macro!
 f[BBind fq0"g g0'		    !* Put it in a scratch buffer!
 j:s &_Check_Window_Sizes"e	    !* If not already in it!
    ji ( m(m.m &_Check_Window_Sizes)
)				    !* Add window size checker!
    hfx* fs TTY Macro'		    !* And save the new tty macro!
 f]BBind			    !* Flush scratch buffer!

 0fo..q MWIND_Setup_Hookf"n u0 m0'	    !* Run setup hook if any!

 m.m ^R_Kill_Windowsu:.x(1)	    !* Else set keys normally!
 m.m ^R_Split_Windowu:.x(2)
 m.m ^R_Redistribute_Windowsu:.x(3)
 m.m ^R_Visit_in_New_Windowu:.x(4)
 m.m ^R_Grow_Windowu:.x(^)
 m.m ^R_Goto_Windowu:.x(O)
 m.m ^R_Scroll_Other_Windowu...V

 

!& Save Old Definition:! !S Find MM-var and rename.
Assumes Kill Variable is in qK.!

 [0[1
 :i1 			    !* get string arg!
 0fo..q MM_1u0		    !* find definition!
 mK MM_1			    !* kill it!
 q0 f"n m.v MWIND_Old_1 '	    !* but save it for later!
 

!& Kill MWIND Library:! !S Undo definitions and key settings!

 qMWIND_Load_Count-1 :f"l uMWIND_Load_Count 0'

 1,m(m.m ^R_Kill_Windows)	    !* Don't leave world inconsistent!

 m.m Kill_Variable[K		    !* Get variable killer!
 mK MWIND_Load_Count		    !* and say never before loaded!

 :i*m.v MM_&_Check_Window_Sizes   !* Make TTY Macro safe!
 0 fs Refresh			    !* Restore old refresh!

 m.m &_Restore_Old_Definition[R    !* Restore shadowed defs!
 mR ^R_Other_Window
 mR ^R_Two_Windows
 mR ^R_One_Window
 mR ^R_Grow_Window
 mR ^R_Scroll_Other_Window

 m.m &_Macro_Name[N		    !* Restore key settings!
 m(m.m &_Get_Library_Pointer) EMACS [E

 q:.x(1)mN[0 f~0 ^R_Kill_Windows"e qEm.m ^R_One_Windowu:.x(1)'

 q:.x(2)mNu0 f~0 ^R_Split_Window"e qEm.m ^R_Two_Windowsu:.x(2)'

 q:.x(3)mNu0 f~0 ^R_Redistribute_Windows"e
    qEm.m ^R_View_Two_Windowsu:.x(3)'

 q:.x(4)mNu0 f~0 ^R_Visit_in_New_Window"e
    qEm.m ^R_Visit_in_Other_Windowu:.x(4)'

 q:.x(^)mNu0 f~0 ^R_Grow_Window"e qEm.m ^R_Grow_Windowu:.x(^)'

 q:.x(O)mNu0 f~0 ^R_Goto_Window"e qEm.m ^R_Other_Windowu:.x(O)'

 q...VmNu0 f~0 ^R_Scroll_Other_Window"e
    qEm.m ^R_Scroll_Other_Windowu...V'

 

!& Restore Old Definition:! !S Restore saved macro.
Assumes Kill Variable is in qK.!

 [0[1
 :i1 			    !* get string arg!
 0fo..q MWIND_Old_1u0	    !* find definition!
 mK MWIND_Old_1		    !* kill it!
 q0 f"n m.v MM_1 '		    !* but restore it as a MM-var!
 

!^R Kill Windows:! !^R Kill all windows except current one.
A positive arg means kill current window, merging up (down for a neg arg).
A pre-comma arg means not to worry if there is only one window now.!

!* This does no scrolling (@f) for two reasons:
     1) It shouldnt do any redisplay when called from & MWIND TTY Macro, and
     2) It doesnt seem to work anyway.
   Instead it tries to reset fs Window to avoid repainting.!

 m(m.m &_Check_Top_Level) windows !* Make sure munging is OK!
 qWindow_Vector[W		    !* W: window vector!
 qCurrent_Window[C		    !* C: current window!
 ((fqW/5)-1)/q:W(0)[N		    !* N: total number of windows!
 "e qN-2"l			    !* If only one window now, complain!
    :i* O1B	Only_One_Window fs Err''
 ff*"e			    !* If killing down to one window!
    qW[..o			    !* Select window vector!
    5,(((qC-1)*q:W(0)+1)*5)k	    !* Kill entries before current window!
    (q:W(0)+1)*5,zk		    !* Kill entries after current window!
    ]..o			    !* Deselect vector!
    1uCurrent_Window		    !* Reset current window!
    :f			    !* Make sure old window is OK!
    .[0 fn q0j			    !* Save old point!
    fs Window+bj		    !* Go to original window top!
    1:<-q:W(4!*wintop!),0@fm>	    !* Try to make earlier window!
    .-bfs Window		    !* Save it as fs Window!
    0u:W(4!*wintop!) 0fs Top Line  !* Start at top of screen!
    fs Height-(fs Echo Lines)-1u:W(3!*winsiz!)
    0fs Lines			    !* Use whole screen!
    0m.v Window_2_Size		    !* Say no more windows!
    '				    !* And return!

 !* got here means killing only current window!
 qN-2"l '			    !* Quietly exit if nothing to kill here!
 [0				    !* 0: whether merging up or down!
 qC-qN"e 1u0'			    !* If bottom of screen, always merge up!
 qC-1"e -1u0'			    !* If top of screen, always merge down!

 q0"g (qC-1)*q:W(0)u0		    !* Merging up.  0: offset into window vec!
    q:W(q0-q:W(0)+3!*winsiz!)+q:W(q0+3!*winsiz!)+1u:W(q0-q:W(0)+3!*winsiz!)
    qW[..o			    !* Select window vector!
    q0*5+5j q:W(0)*5d		    !* Kill window's entry!
    ]..o			    !* Deselect window vector!
    qC-1f(uCurrent_Window	    !* Reset current window!
       ):m(m.m &_Select_Window)'   !* ..and go select it (no deselect first)!

 !* got here means merging down!
 (qC-1)*q:W(0)u0		    !* 0: offset into window vec!
 m.m &_Select_Window[S		    !* S: window selector!
 1,qC+1mS			    !* Go to next window!
 fs Window+bj			    !* Top of window!
 1:<-q:W(q0+3!*winsiz!)-1,0@fm>	    !* Find new window top!
 .-bu:W(q0+q:W(0)+2!*winwin!)	    !* And save it as window!
 q:W(q0+4!*wintop!)u:W(q0+q:W(0)+4!*wintop!) !* Set new window top, size!
 q:W(q0+3!*winsiz!)+1+q:W(q0+q:W(0)+3!*winsiz!)u:W(q0+q:W(0)+3!*winsiz!)
 qW[..o				    !* Select window vector!
 q0*5+5j q:W(0)*5d		    !* Kill windows entry!
 ]..o				    !* Deselect window vector!
 qC:mS				    !* And go reselect now-current window!

!^R Split Window:! !^R Divide current window into two.
The same buffer will always be used for both windows.  An argument
keeps the cursor in the top window.  A pre-comma argument is the
number of lines to leave in the top window.!

 m(m.m &_Check_Top_Level) windows !* Make sure munging is OK!

 qWindow_Vector[W		    !* W: window vector!
 qCurrent_Window-1*q:W(0)[0	    !* 0: base index into vector!

 q:W(q0+3!*winsiz!)f([1)-3"l	    !* Make sure there are enough lines!
    :i* WTS	Window_Too_Small_To_Split fs Err'

 m(m.m &_Deselect_Window)	    !* Make sure window vec is up to date!

 qW[..o (q0+q:W(0)+1)*5j	    !* Select vector as buffer!
 q:W(0)*5,0i ]..o		    !* Make new entry and deselect!

 0[3 q:W(0)<			    !* For all slots!
    q:W(q0+(%3))u:W(q0+q:W(0)+q3)>  !* Set new  value same as the old!

 u3 q1-q3-2"l q1/2u3' q3:"g q1/2u3'	    !* 3: size of top window!

 fs ^R VPos-q:W(q0+4!*wintop!)-q3[2	    !* 2: line relative to div line!
 q2:f"l -1,q3*(fs %Center)/100f u2	    !* If off screen, find center line!
    q2@:f'			    !* scroll to it or to bot of old window!

 q3u:W(q0+3!*winsiz!)		    !* Set size of old window!
 q1-q3-1u:W(q0+q:W(0)+3!*winsiz!)   !* And size, top line of new window!
 q:W(q0+4!*wintop!)+q3+1u:W(q0+q:W(0)+4!*wintop!)

 q:W(q0+4!*wintop!)+q3m(m.m &_Window_Separator)    !* Draw dividing line!

 m(m.m ^R_Goto_Window)			    !* Select the new window!
 ff&1"e :m(m.m &_Deselect_Window)'	    !* If no argument, done!
 -1f[DForce @v				    !* Else redisplay!
 qCurrent_Window-1:m(m.m ^R_Goto_Window) !* And go to previous window!

!^R Goto Window:! !^R Go to the next window on the screen.
A c-U as arg means to go to the previous window.
A numarg means go to that window, numbered from the top of the screen
(a negative arg counts from the bottom of the screen).!

 m(m.m &_Check_Top_Level) windows !* Make sure switching is OK!
 qWindow_Vector[W		    !* W: window vector!
 ((fqW/5)-1)/q:W(0)[0		    !* 0: max window available!
 q0-2"l				    !* If only one window, complain!
    :i* O1B	Only_One_Window fs Err'
 ff"e			    !* if no arguments!
    qCurrent_Window+1[1	    !* 1: next window!
    q1-q0"g 1u1''		    !* (being careful to make it on screen)!
 "# fs ^R ArgP&2"e		    !* else if just a ^U!
    qCurrent_Window-1[1	    !* 1: previous window!
    q1"e q0u1''			    !* (being careful to make it nonzero)!
 "# "g [1			    !* else positive numarg is abs number!
    -q0"g :i* WOR	Window_Out_Of_Range fs Err''
 "# "l q0+1+[1		    !* else neg numarg counts from bottom!
    q1:"g   :i* WOR	Window_Out_Of_Range fs Err''
 "# qCurrent_Window[1''''	    !* if somehow got through, keep old window!
 m(m.m &_Deselect_Window)	    !* make sure window vec is up to date!
 q1uCurrent_Window		    !* set current window!
 q1:m(m.m &_Select_Window)	    !* select that window!

!^R Grow Window:! !^R Make this window (or minibuffer) use more lines.
Argument is number of extra lines (can be negative).!

 qWindow_Vector[W		    !* W: window vector!
 qCurrent_Window[C		    !* C: our window!
 (qC-1)*q:W(0)[0		    !* 0: offset into window vec!

 q..f-q.f"n fs Lines"e @fg 0'    !* If not top lvl, try to grow minibuf!
    fs Lines-q:W(q0+3!*winsiz!)"e  !* If same size as current window complain!
       :i* Not_in_minibuffer_or_at_top_level @fg 0'
    fs Lines+ f(-q:W(q0+3!*winsiz!):"l   !* Get new size.  If larger than!
	  @fg 0'		    !* ..current window, complain!
       )fs Lines		    !* Add lines to used lines!
    0fo..q Mini_Outer_Refresh"n    !* If in normal minubuffer!
       :i*[Mini_Outer_Refresh'   !* ..set var to not do full redisplay!
    m(fs Refreshf"e :i*') w'    !* Refreshment time!

 ((fqW/5)-1)/q:W(0)[1		    !* 1: num windows!
 q1-2"l :i* O1B	Only_One_Window fs Err'

 f"l +q:W(q0+3!*winsiz!):f"g	    !* Negative arg.  Check number of lines.!
       :i* WTS	Window_Too_Small_To_Shrink fs Err'
    "# u:W(q0+3!*winsiz!)'	    !* Set window size!
    fs Refresh[..n		    !* Run refresh when all done!
    q1-qC"e			    !* If last window!
       q:W(q0-q:W(0)+3!*winsiz!)-u:W(q0-q:W(0)+3!*winsiz!)
       q:W(q0+4!*wintop!)-f(u:W(q0+4!*wintop!))fs Top Line
       0fs Lines		    !* Use rest of screen!
       .[2 fnq2j fs Window+bj	    !* Go to top of window!
       1:<-,0:fm>		    !* Find new top line!
       .-bfs Window		    !* Set new window to avoid redisplay!
       '
    q:W(q0+q:W(0)+3!*winsiz!)-u:W(q0+q:W(0)+3!*winsiz!)
    q:W(q0+q:W(0)+4!*wintop!)+u:W(q0+q:W(0)+4!*wintop!)
    m(m.m &_Deselect_Window)	    !* Make sure window vec is up-to-date!
    m.m &_Select_Window[S	    !* S: window selector!
    fn qCmS qC+1mS		    !* Select next window!
    fs Window+bj		    !* Go to top of window!
    1:<,0@fm>			    !* Find new top line!
    .-bu:W(q0+q:W(0)+2!*winwin!)    !* Save it as the new window!
    '

 !* If got to here, growing (not shrinking) current window.!
 0[2 0[3			    !* 2,3: lines to steal from top and bottom!
 qC-q1"l ,q:W(q0+q:W(0)+3!*winsiz!)-1f u2u2'
 qC-1"g -q2,q:W(q0-q:W(0)+3!*winsiz!)-1f u3u3'
 -q2-q3"n :i* CGW	Not_Enough_Lines_To_Grow_Window fs Err'

 fs Refresh[..n f[Window		    !* Run refresh when all done!
 fs ^R VPos-q:W(q0+4!*wintop!)-q3@:f	    !* Try to scroll window!

 q2f"g+q:W(q0+3!*winsiz!)u:W(q0+3!*winsiz!) !* Set new window size from bottom!
    q:W(q0+q:W(0)+4!*wintop!)+q2u:W(q0+q:W(0)+4!*wintop!)
    q:W(q0+q:W(0)+3!*winsiz!)-q2u:W(q0+q:W(0)+3!*winsiz!)
    m.m &_Select_Window[S	    !* S: window selector!
    fn qCmS qC+1mS		    !* Select next window!
    fs Window+bj		    !* Find old top of window!
    1:<q2,0:fm>			    !* Find new top of window!
    .-bu:W(q0+q:W(0)+2!*winwin!)'   !* Set new window top from it!
 q3f"g+q:W(q0+3!*winsiz!)u:W(q0+3!*winsiz!) !* Set new window size from top!
    q:W(q0+4!*wintop!)-q3f(u:W(q0+4!*wintop!))fs Top Line
    q:W(q0-q:W(0)+3!*winsiz!)-q3u:W(q0-q:W(0)+3!*winsiz!)'
 qC-q1f"nw q:W(q0+3!*winsiz!)'fs Lines	    !* Reset lines for refresh!


!^R Redistribute Windows:! !^R Make all windows the same size.
If the screen has changed and there are too many windows,
all windows except the current one are killed.!

 qWindow_Vector[W		    !* W: window vector!
 ((fqW/5)-1)/q:W(0)[1		    !* 1: num windows!
 fs Height-(fs Echo Lines)-1[2    !* 2: screen size!

 q1*2-q2:"l			    !* If not enough lines for all the windows!
    :m(m.m ^R_Kill_Windows)'	    !* Kill windows down to one!

 (q2-q1+1)/q1[4			    !* 4: Lines per window!
 (q4*q1)-(q2-q1+2)[3		    !* 3: Minus num of extra lines minus 1!
 0[0				    !* 0: window counter!
 fs Refresh[..n		    !* Refresh when all done!

 (qCurrent_Window-1)*q:W(0)[5	    !* 5: offset for current window!
 fs Top Line-q:W(q5+4!*wintop!)[6  !* 6: top line offset!
 fs Lines-q:W(q5+3!*winsiz!)[7	    !* 7: window size offset!

 q1< q0f"nw			    !* Loop over windows.  Set top line...!
       q:W(q0-q:W(0)+4!*wintop!)+q:W(q0-q:W(0)+3!*winsiz!)+1'u:W(q0+4!*wintop!)
     q4u:W(q0+3!*winsiz!)	    !* Set window size!
     %3"l %:W(q0+3!*winsiz!)'	    !* Soak up extra lines!
     q:W(0)+q0u0 >		    !* Go on to the next window!

 q:W(q5+4!*wintop!)+q6fs Top Line  !* Restore new top line!
 fs Lines"n			    !* If not using remaining screen!
    q:W(q5+3!*winsiz!)+q7fs Lines' !* Restore lines (could be more careful)!


!^R Visit in New Window:! !^R Find buffer, tag or file in new window.
Follow this command by B or c-B and a buffer name;
F or c-F and a file name; or T, c-T, or . and a tag name.
We find the buffer, tag or file in a new window.
An argument is passed on to Select Buffer, Find File, or Find Tag.!

 1fs Typeout			    !* Don't redisplay when reading char!
 m.i fi:fc[0			    !* Read a char!
 -1fs Typeout			    !* Make ? print out right!

 m.m ^R_Split_Window[S		    !* S: macro to split window!
				    !* (dont run unless have acceptable char)!
 q0f*B"g  mS f:m(m.m Select_Buffer)'
 q0f*F"g  mS f:m(m.m Find_File)'
 q0f*T."g mS f:m(m.m ^R_Find_Tag)'

 @fg 0			    !* Didn't match, just beep and return!

!^R Scroll Other Window:! !^R Scroll next window up several lines.
If at last window, scrolls first window of screen.
A pre-comma argument is taken as argument to ^R Goto Window.
Specify the number as a numeric argument, negative for down.
The default is a whole screenful up.  Just Meta-Minus as argument
means scroll a whole screenful down.!

 qCurrent_Window[1			    !* 1: old window number!
 @fn| q1m(m.m ^R_Goto_Window) |	    !* Return to it when done!
 ff&2"n 'm(m.m ^R_Goto_Window)	    !* Go to next window on screen!
 -1f[DForce				    !* Don't stop redisp for typeahead!
 fs ^R ArgP-5"e			    !* Handle just Meta-Minus as arg!
    @m(m.m ^R_Previous_Screen)'  	    !* By going one screen back!
 "# ff&1"n '@m(m.m ^R_Next_Screen)'  !* Else go forward screen or lines!
 0u..h @v				    !* Do the redisplay!


!^R Other Window:! !^R Switch to another window.
Goes to the top window, unless there already; in that case,
goes to the (perhaps invisible) second window.!

 qCurrent_Window-1"n		    !* If not at top window!
    1:m(m.m ^R_Goto_Window)'	    !* Go to it!
 qWindow_Vector[W		    !* W: window vector!
 ((fqW/5)-1)/q:W(0)-1"g		    !* If more than one window!
    2:m(m.m ^R_Goto_Window)'	    !* Go to the second one!

 m(m.m &_Check_Top_Level) windows !* Make sure switching is OK!
 0fo..q Window_2_Buffer"e	    !* If no old 2nd window, complain!
    :i* O1B	Only_One_Window fs Err'
 .(				    !* Save point!
    qBuffer_Name(		    !* ..and buffer name!
       fs Window(		    !* ..and window!
         qWindow_2_Buffer m(m.m Select_Buffer)
	 qWindow_2_Pointer:j	    !* Go to other buffer, point, window!
	 qWindow_2_Window fs Window
       )uWindow_2_Window	    !* Permanently save saved window!
     )uWindow_2_Buffer	    !* ..and buffer name!
 )uWindow_2_Pointer		    !* ..and point!


!^R Two Windows:! !^R Show two windows and select window two.
An argument > 1 means give window 2 the same buffer as in window 1.
A pre-comma argument means keep the cursor in window 1.!

 qWindow_Vector[W		    !* W: window vector!
 ((fqW/5)-1)/q:W(0)-1"g		    !* If already two windows, complain!
    :i* A2W	Already_Two_Windows fs Err'

 0fo..q Window_2_Buffer[0 q0"e	    !* If never had two windows!
    .m.v Window_2_Pointer	    !* Make new saved pointer!
    fs Windowm.v Window_2_Window  !* ..and saved window!
    0fo..q Tags_Find_File"e -1"e !* And want different window!
       0uWindow_2_Pointer	    !* Clear pointer!
       0uWindow_2_Window	    !* ..and window!
       :i0 W2'''		    !* Make new window W2!

 0fo..q Window_1_Size,m(m.m ^R_Split_Window)
				    !* Split window to old size!
 [Previous_Buffer		    !* Save old previous buffer!
 q0f"n m(m.m Select_Buffer)'	    !* Select appropriate buffer!
 qWindow_2_Pointer:j		    !* Jump to appropriate place!
 qWindow_2_Windowfs Window	    !* Set window!
 "e '			    !* If no pre-comma arg, done now!

 -1f[DForce			    !* Don't interrupt for typein!
 0u..H @v			    !* Refresh new window!
 1:m(m.m ^R_Goto_Window)	    !* And go to top window!

!^R One Window:! !^R Display only one window.
Normally displays what used to be in the top window.
With a numeric argument displays what was in the current
one, unless already in the top window, in which case
the second window is displayed.!

!* ^R Goto Window or ^R Kill Windows will complain if only one window!

 ff"e 1m(m.m ^R_Goto_Window)'  !* If no arg, go to top window first!
 "# qCurrent_Window-1"e	    !* Else if already in top window!
       2m(m.m ^R_Goto_Window)''    !* Go to second window!
 :m(m.m ^R_Kill_Windows)	    !* Kill windows down to one!

!Compare Windows:! !C Compare text in two windows.
Compares the text in the current window with that in the next window
down (the one ^R Goto Window would pick), starting at the cursor in each
window, leaving point in each window at the first discrepancy, if
any, or at the end of the buffer.  Quitting leaves point at place
comparison had reached.

The variable Collapse in Comparison should be a string
of "insignificant" chatacters.  Any sequence of those characters
matches any other such sequence.  If the variable is not
defined, the default is CR, LF, TAB, and SPACE.!

 qWindow_Vector[W		    !* W: window vector!
 ((fqW/5)-1)/q:W(0)-2"l		    !* If only one window!
    :i* O1B	Only_One_Window fs Err'

 m(m.m &_Deselect_Windowf([X))	    !* X: make sure window vec is up-to-date!
 m.m &_Select_Window[S		    !* S: window selector macro!
 qCurrent_Window[C		    !* C: current window number!
 q..o[D fnqCmS			    !* D: Our buffer.  Select on unwind!
 .[Q				    !* Q: Pos. in D; parameter to & Compare...!
 fsLines"e 1'"# qC+1'f(mS)[Current_Window	    !* Select other window!

 @ft_(Comparing...)
 0fs Echo Active		    !* Leave echo area display there!
 0fo..qCollapse_in_Comparison[A !* A: chars to ignore!
 qA"e :iA_
 '

 -1[B				    !* Make flag for compare results!
 1:< -1f[NoQuit		    !* Make c-G give us an error!
     qD,qAm(m.a AUX &_Compare_String_with_Buffer)uB	    !* B: flag!
     f]NoQuit >		    !* Allow c-G again!

 qB"g @ft_(Windows_are_different)' !* Say what we found!
 qB"e @ft_(No_differences_so_far)'
 qB"l @ft_(No_differences_encountered)'
 0fs Echo Active		    !* Leave echo area display there!


 0@V mX				    !* Redisplay, update window vec!
 qD[..o ]..o qCmS qQj 0u..n	    !* Back to previous window!

 0

!& Window Separator:! !S Display horiz line at numarg row.!
[9				    !* [fHsu] say no fsScrInv function!
 f[Top Line			    !* set screen top to appropriate line!
 1f[Lines			    !* set screen lines to something!

!* The following could be replaced by the simpler
     :ft fs Width/10<ft---------->
   but then all the lines would be redrawn when fs Refresh
   is called by ^R Grow Window.  Unfortunately they seem to
   all be redrawn anyway...this code is probably faster though.!

 fs Width-(-1fo..q MWIND_Old_Width)"n	    !* If width is not up-to-date!
    fs Widthm.v MWIND_Old_Width   !* Save width as old width!
    f[BBind			    !* Get a scratch buffer!
    fs Width-8,-i		    !* Insert approximately 72 dashes!
    hfx* m.v Window_Separator_Text !* Save as separator line!
    f]BBind'			    !* Back to main buffer!

 qWindow_Separator_Text[0	    !* Get separator line!
 0fo..qMWIND_Inverse_Separatoru9   !* [fHsu]!
 q9"n			            !* [fHsu] see whether to make it standout!
    1:<fsInvModfsScrInv>'w
 :ft 0			    !* Display it!
 q9"n 1:<0fsScrInv>'		    !* [fHsu] reset inverse mode for separator!
 0u..H 			    !* don't refresh over it!

!& Select Window:! !S Go to NUMARG window.
Pre-comma arg means TECO-select the buffer.
Assumes Window Vector is in qW.!

 -1*q:W(0)[0			    !* 0: base index into vector!
 ((fqW/5)-1)/q:W(0)[1		    !* 1: num windows!

 q:W(q0+4!*wintop!)fs Top Line
 -q1f"nw q:W(q0+3!*winsiz!)' fs Lines

 "e [Previous_Buffer	    !* EMACS Select - save prev buffer!
      q:W(q0+5!*winbuf!)m(m.m Select_Buffer)'
 "# 1,q:W(q0+5!*winbuf!)m(m.m &_Find_Buffer)[1
    q1+1"e 0,0fsBound '	    !* If no such buffer, make emptiness!
    q:.B(q1+4!*bufbuf!)u..o'	    !* Else select appropriate buffer!

 -fs Window			    !* Clear window to avoid NIB!
 m(m.m ^R_Widen_Bounds)	    !* Widen bounds carefully!
 q:W(q0+7!*winend!)"l		    !* Neg => page number or wide!
    -fs Window			    !* Clear window to avoid scrolling!
    q:W(q0+6!*winbeg!)f"g m(m.m ^R_Goto_Page)''
 "# 1:<q:W(q0+6!*winbeg!),q:W(q0+7!*winend!)fs Bound>'

 q:W(q0+1!*winptr!)+b:j"e zj'	    !* Jump to (close to) original location!
 q:W(q0+2!*winwin!)fs Window	    !* With original window!


!& Deselect Window:! !S Save current window in window vector.
Assumes Window vector is in qW.!

 qIn_MWIND_Deselect"n 0'	    !* If already deselecting, dont recurse!
 1[In_MWIND_Deselect		    !* Else set flag!

 qCurrent_Window-1*q:W(0)[0	    !* 0: base index into vector!
				    !* don't save fsTopLine, fsLines here!
 qBuffer_Nameu:W(q0+5!*winbuf!)   !* save buffer name!
 .-bu:W(q0+1!*winptr!)		    !* save point in buffer, relative to start!
 fs Windowu:W(q0+2!*winwin!)	    !* save window!

 0fo..q Current_Pagef"n u:W(q0+6!*winbeg!)
    -1u:W(q0+7!*winend!)'	    !* if page number, use that, -1!
 "# b+(fs VZ)"n		    !* else if wide save wide bounds!
    fs Boundu:W(q0+7!*winend!)u:W(q0+6!*winbeg!)'
 "# -1u:W(q0+6!*winbeg!)	    !* else no bounds, set both to -1!
    -1u:W(q0+7!*winend!)''

 qCurrent_Window-3"l		    !* If in one of top two windows!
    qCurrent_Window:\[1	    !* 1: string for that number!
    qBuffer_Namem.v Window_1_Buffer    !* save buffer name!
    . m.v Window_1_Pointer	    	    !* ..and point!
    fs Windowm.v Window_1_Window	    !* ..and window!
    q:W(q0+3!*winsiz!)m.v Window_1_Size  !* ..and size!
    '
 m(m.m &_Check_Window_Sizes)	    !* Make sure screen size hasn't changed!


!& Multiple Window Refresh:! !S FS Refresh for MWIND library.!

 fs QP Ptr[P			    !* P: old stack pointer!
 qWindow_Vector[W		    !* W: window vector!
 ((fqW/5)-1)/q:W(0)[0		    !* 0: number of windows!

 0u..h				    !* Dont hold redisplay!

 q0-1"g				    !* If more than one window!
    [..o f[Top Line f[Lines	    !* Save buffer, lines for minibuffer, etc.!
    0f[Refresh -1f[DForce	    !* Dont accidentally call recursively!
    m(m.m &_Deselect_Window)	    !* Make sure window is up to date!
    @fn| 1,qCurrent_Windowm(m.m &_Select_Window) |	    !* save old window!

    m.m &_Window_Separator[S	    !* S: line drawer!
    1[N				    !* N: window number!
    q0< qN-1"g			    !* If its not the top window!
	   q:W((qN-1)*q:W(0)+4!*wintop!)-1mS'  !* Draw separator line!
	qN-qCurrent_Window"n	    !* If its not the current window!
	   1,qNm(m.m &_Select_Window) @v'     !* Select it and refresh!
	%N>'			    !* Loop back to the next window!

 qP fs QP Unwind		    !* Restore old stack!

 !* Note that we fall off the end with all qregs popped by the fs QP Unwind.
    This is so that other things can be consed onto the end of fs Refresh.!

!& Check Window Sizes:! !S Make sure screen size hasn't changed.!

 qWindow_Vector[W		    !* W: window vector!
 ((fqW/5)-1)/q:W(0)[1		    !* 1: num windows!
 (q1-1)*q:W(0)[0		    !* 0: offset in w vec!
 q:W(q0+4!*wintop!)+q:W(q0+3!*winsiz!)-(fsHeight-(fs Echo Lines)-1)f"e
    '				    !* If no change, just return!
 "#[2'				    !* 2: Total difference!

 q:W(q0+3!*winsiz!)-q2f"g u:W(q0+3!*winsiz!) '
				    !* If still fits, change bot win size!
 :m(m.m ^R_Redistribute_Windows) !* Else go rearranging!
