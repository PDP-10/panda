!* -*-TECO-*- !

!~FILENAME~:! !Redefinition of search commands to shrink screen!
SMALLSEARCH

!& Setup SMALLSEARCH Library:! !S Setup TV commands!

  M.V Isearch_Percent	        !* tells how near top of screen to land search!
  M.V Isearch_Screen_Size	    !* tells whether to shrink during searches!
  m.m^R_Modified_ISearch u.S	    !* new searches!
  m.m^R_Modified_Reverse_ISearch u.R
  :FO..Q Default_Separator"L	    !* this is for [#] command!
    :i*-----(short_display)----- M.V Default_Separator'
  15 FS Q Vector M.V Shrunk_Screen_Parms  !* more state info for Search!

!^R Modified ISearch:! !^R Incremental Search with modified display.
See documentation of ^R Incremental Search for details.
Tries to position cursor Q$Isearch Percent$ of the
way down the page (default is 0, i.e. on top line).
If Q$Isearch Screen Size$ is positive, shrinks
window to that many lines during search.!

  QIsearch_Percent F[ %center    !* tell how far down screen to land!
  QIsearch_Screen_Size F"G [1	    !* if want to shrink!
    FS Lines"E			    !* and screen is currently fullsize!
      F[Lines  F[Refresh F[^R Display    !* save state!
      FN Q1,Q1+1 @F 		    !* setup to restore screen on exit!
      1,Q1 M(m.m^R_Set_Screen_Size)''	    !* and do the shrink!

  F@:M(m.m^R_Incremental_Search)

!^R Modified Reverse ISearch:! !^R Reverse incremental search,
i.e. a negative ^R Modified ISearch.!

  - @:M(m.m^R_Modified_ISearch)

!^R Set Screen Size:! !C Shrinks display to specified size.
Give as numeric argument the number of lines to display.
No arg, or arg of zero, restores display to full screen.
Precomma arg is from Isearch, says not to shrink until display changes!

  0[1 FF&1"N u1'		    !* arg defaults to 0!
  0FO..QWindow_2_Size"N	    !* in 2-window mode!
    @FTUse_^X_^_to_hack_screen_size_in_2-window_mode
   0FS Echo Active
    0'
  Q1"E				    !* zero arg -> full screen!
    FS Lines F"N [2		    !* Display is indeed shrunk!
      0FS Refreshw 0FS ^R Displayw 0FS Lines	    !* clear the world!
      q2,q2+1 @F'		    !* report that separator line needs!
				    !* refresh!
    0U:Shrunk_Screen_Parms(0)
    H'			    !* done!

  Q1"L FG 0FS Err'		    !* Barf on negative args!
  Q1 + (FS EchoLines) + 1 - (FS Height) "G
    @FTArgument_too_big
   FG 0FS Err'

  FS Lines F"N [2		    !* already shrunk...!
    Q1-Q2 "E 0'		    !* same amount, so do nothing!
    Q2,Q2+1 @F'		    !* dispose of other separator!

  FF&2"N			    !* given precomma arg!
    QShrunk_Screen_Parms[S	    !* only shrink screen if need to!
    Q1 u:S(0)			    !* size in :0!
    FS Window+B u:S(1)		    !* start and end of screen in :1 and :2!
    M(m.m&_End_Of_Screen_Address) u:S(2)'
   "# Q1FS Lines'		    !* else do it right away!
  m.m&_Draw_Separator F(FS ^R Display) FS Refresh
  H

!& Draw Separator:! !S Draws a line of dashes,
or whatever's in Q$Default Separator$, on the bottom line of the
shrunken window we're using.  For use as a FS Refresh macro.!

  FS Lines"E			    !* not shrunk yet!
    QShrunk_Screen[S
    Q:S(1)-.:"G			    !* and point after start!
      Q:S(2)-."G		    !* and before end of screen!
        0''			    !* then do nothing--don't shrink until we!
				    !* really have to!
    Q:S(0)FS Lines'		    !* set lines small!

  0FS ^R Display		    !* only good for display once!
  QDefault_Separator [1	    !* what to draw!
  FS Lines F[ TopLine		    !* what line to draw on!
  :FT1			    !* draw it!
  0u..H				    !* allow display after the :FT!
  0
