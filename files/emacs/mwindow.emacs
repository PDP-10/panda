!*--*-TECO-*--*!
!~Filename~:! !Window system!
WINDOW

!& Setup WINDOW Library:! !S Setup window system!

0FO..Q Max_Windows"E
 10m.v Max_Windows
 5*12 fs q vectorm.v Window_Data  !* 12 windows (5 words per element)!
 qWindow_Data[0 :i*Main[1 1[2 
  qMax_Windows+1< 5*10fs q vector[3
    q2-1"n q1u:3(0) q1u:3(6)' q3u:0(q2) %2 ]3>
    ]2]1]0			    !* init all but first!

 1m.v Number_of_Windows	    !* only one to start with!
 1m.v Current_Window		    !* what else can it be!
 1m.v Previous_Window		    !* well...!

 '				    !* this ends the startup test!

 :i*----------[1 0FO..Q Window_Separatorf"n u1 '
 q1,m(m.m ^R_Set_Window_Separator) ]1

  !* Make Control-W a Prefix Character. Runs under EMACS 160!

    m(m.m Make_Prefix_Character).yu.W    !* put it in q reg .y !
    qPrefix_Char_List[1
    :iPrefix_Char_List1Control-W__q.y

     ]1

  !* End Prefix character definition !
	
 m.m ^R_Kill_Region		u:.y()  !* ^W-^W is wipe region!
 m.m ^R_Delete_Window		u:.y(D)
 m.m ^R_Only_One_Window	u:.y(1)
 m.m ^R_Split_Window		u:.y(2)
 m.m ^R_Split_Window_Stay	u:.y(3)
 m.m ^R_Another_Window		u:.y(O)
 m.m ^R_Change_Other_Window	u:.y(^)
 m.m ^R_Average_Windows	u:.y(A)
 m.m ^R_Scroll_Other_Window	u:.y(V)
 m.m ^R_Set_Window_Separator   u:.y(-)
 m.m ^R_Grow_Window_Top        u:.y(T)
 m.m ^R_Grow_window_Bottom     u:.y(B)
 w


!^R Split Window Stay:! !^R Split the current window but stay in the old one!
   1,m(m.m ^R_Split_Window) w


!^R Split Window:! !^R Split the current window and go to the new one!
   
  qNumber_of_Windows-qmax_Windows"E
   :I*AMW		Already_the_Maximum_of_windowsFS ERR'
  fs rgetty"E
   :I*TTY		You_are_on_a_printing_terminal FS ERR'
  fs lines"N
   fs lines-3"l
    :I*WTS		Window_too_small_to_split FS ERR''

  qWindow_Data[0
  qCurrent_Window[1
  qNumber_of_Windows[2 q2-1"E 1u1'	    !* for safety!
  fs top line[3
  fs lines[4
				    !* think about where to put noquit!
  q4"e fs height-(fs echo lines)-1 u4'

  q:0(q1)[5			    !* the current window!
  qBuffer_Name	u:5(0)
  q:.b(q:5(0)m(m.m &_Find_Buffer)+4) u:5(1)
  q3		   	u:5(2)
  q4/2			u:5(3)
  fs window		u:5(4)
  .			u:5(5)
  qPrevious_Buffer	u:5(6)

  q5u:0(q1)			    !* put it in its slot!

  q:0(q2+1)u5			    !* get the last killed window!
  q2[5 q2-q1<q:0(q5)u:0(q5+1) q5-1u5> ]5    !* bump up for room!

  q:5(0)m(m.m Select_Buffer)	    !* get its buffer name and go to it!
  qBuffer_Name	u:5(0)
  q:.b(q:5(0)m(m.m &_Find_Buffer)+4) u:5(1)
  q3+(q4/2)+1	   	u:5(2)
  (q4-1)/2		u:5(3)
  fs window		u:5(4)
  .			u:5(5)
  q5u:0(q1+1)

  q2-1"E fs refreshm.v Single_Window_Refresh
   m.m &_Many_Window_Refresh fs refresh'

  q0	uWindow_Data
  q1u3	q1+1u4 "n q3(q4u3)u4 '	    !* who are we really!
  q3	uPrevious_Window
  q4	uCurrent_Window
  q2+1	uNumber_of_Windows



  m(m.m &_Goto_Current_Window)
  m(m.m &_Show_Separators)
  0,q1m(m.m &_Redisplay_Window)
  0,q1+1m(m.m &_Redisplay_Window)
  w


!^R Only One Window:! !^R Delete all but the current window!
  MMM_&_Check_Top_Levelwindows

  fs ^r argp # "n 1,m(m.m ^R_Another_Window) '
  1uNumber_of_Windows
  1uCurrent_Window
  0 fs top line
  0 fs lines
  qSingle_Window_Refresh fs refresh
  w


!^R Another Window:! !^R Go to the OTHER window!
  MMM_&_Check_Top_Levelwindows

   qCurrent_Window[0 [2
   qPrevious_Window[1 [3 q1u2 q0u3
   fs ^r argp#"n
     -q0"e w'
     "l q0+"g q0+u2''
     "g qNumber_of_Windows-+1"g u2'''
   m(m.m &_Exit_Current_Window)
   q2uCurrent_Window
   q3uPrevious_Window
   m(m.m &_Goto_Current_Window)
   "e m(m.m &_Show_Separators)'
   


!^R Delete Window:! !^R Delete the current window. Also takes an argument!
   MMM_&_Check_Top_Levelwindows

   qNumber_of_Windows-2"l w'
   qWindow_Data[0
   qCurrent_Window[1		    !* q1 is the one to delete!
   qPrevious_Window[2 q2[4	    !* q2 is the next current!
   qNumber_of_Windows[3	    !* q3 the updated number of windows!
   fs ^r argp #  "n
    "l q1+"g q1u2 q1+u1' "#w''
    "g q3-+1"g q1u2 u1' "#w'''
    q3-2"e 1,q2m(m.m ^R_Only_One_Window) w'
   q1-q2"e q4u2' q2-q1"g q2-1u2' q4-q1"g q4-1u4'
   q:0(q1)[7			    !* the old window!
   q:7(2)[5			    !* the top line!
   q:7(3)+1[6			    !* the number of lines being freed!

   q1-1"e q5u:(q:0(2))(2) '	    !* if the top window, easy!
    "# q5+((q6+1)/2)u:(q:0(q1+1))(2) '	    !* else partion the deletion!
   q1u5 (q3-q1)<q:0(q5+1)u:0(q5) %5>	    !* movee things down!
   0u:7(1) q7u:0(q3)		    !* zero the buffer pointer and put it back!
   q3-1uNumber_of_Windows
   q2uCurrent_Window
   fs height-(fs echo lines)u:(q:0(q3))(2)
   1u5 q3-1<q:(q:0(q5+1))(2)-q:(q:0(q5))(2)-1u:(q:0(q5))(3) %5>
   q0uWindow_Data
   1,q4m(m.m ^R_Change_Other_Window)
   q1-1"n 0,q1-1m(m.m &_Redisplay_Window)'
   q3-q1"g 0,q1m(m.m &_Redisplay_Window)'
   m(m.m &_Goto_Current_Window)
   w


!^R Change Other Window:! !^R Pick a different previous window!
   qNumber_of_Windows-1"e  w'
   MMM_&_Check_Top_Levelwindows
   
   qNumber_of_Windows[1
   qCurrent_Window[2
   qPrevious_Window[3
   fs ^r argp#"e %3w'
     "#"l q3+"g q3+-q2"n q3+u3'''
       "g q1-+1"g -q2"n u3''''
   q3-q2"e %3w' q1-q3"l 1u3' q3-q2"e %3'
   q3uPrevious_Window
   m(m.m &_Show_Separators)
   


!^R Average Windows:! !^R Average the windows already on the screen!

   qNumber_of_Windows-2"l w'
   MMM_&_Check_Top_Levelwindows

   qWindow_Data[0
   qNumber_of_Windows[1
   fs height-(fs echo lines)[2
   0[5 q1+1<q2*q5/q1u:(q:0(q5+1))(2) %5>
   1u5 q1<q:(q:0(q5+1))(2)-q:(q:0(q5))(2)-1u:(q:0(q5))(3) %5>
   q0uWindow_Data
   m(m.m &_Goto_Current_Window)
   :m(fs refresh)
   w


!^R Scroll Other Window:! !^R Scroll the other window by the indicated amount!
   qNumber_of_Windows-2"l w'
   MMM_&_Check_Top_Levelwindows

   .[2 fn q2:j [2		    !* pointer unwind protect!
   q:Window_Data(qPrevious_Window)[0
   q:0(2) f[ top line
   q:0(3) f[ lines
   q:0(1) [..O
   q:0(4) f[ window
   q:0(4) :j
   -1 f[ d force
   fs ^r argp-5"e @m(m.m ^R_Next_Screen)'
   "# f@m(m.m ^R_Next_Screen)'
   0@v
   .u:0(5) fs windowu:0(4)
   q0u:Window_Data(qPrevious_Window)
   w


!& Goto Current Window:! !S Make the Current Window really current!
  q:(qWindow_Data)(qCurrent_Window)[0
  q:0(2)fs top line
  q:0(3)fs lines
  q:0(0)m(m.m Select_Buffer)
  q:0(5):j
  q:0(4)fs window
  q:0(6)uPrevious_Buffer
  w


!& Exit Current Window:! !S Deselect the current window!
  q:(qWindow_Data)(qCurrent_Window)[0
   qBuffer_Name	u:0(0)
   q:.b(q:0(0)m(m.m &_Find_Buffer)+4)  u:0(1)
   fs top line		u:0(2)
   fs lines		u:0(3)
   fs window		u:0(4)
   .			u:0(5)
   qPrevious_Buffer	u:0(6)
  q0u:(qWindow_Data)(qCurrent_Window)
  w

 
!& Many Window Refresh:! !S Redisplay the many windows on the screen!
  m(m.m &_Show_Separators)
  qSingle_Window_Refresh f"n [1 m(q1(]1))'
  0f[ refresh 1[1
  qNumber_of_Windows< 0,q1m(m.m &_Redisplay_Window) %1>
  w


!& Redisplay Window:! !S Redisplay the window indicated by the second arg!

  -qCurrent_Window # "n
   .[1 fn q1j [1
   q:(qWindow_Data)()[1
   q:1(3) f[ lines
   q:1(2) f[ top line
   q:1(4) f[ window
   q:1(1) [..O
   q:1(4) :j
   -1f[ d force 0u..h @v
   ' w


!& Show Separators:! !S Show the separators between the windows!
   .[1 fn q1j [1
   qWindow_Data[0 qPrevious_Window[1 2[2
   fs %tosaif[ Sail
   0f[ refresh
   1f[ lines
   0f[ window
   0f[ top line
   f[b bind gWindow_Separator_String 0j
   qNumber_of_Windows-1<
    q:(q:0(q2))(2)-1 fs top line 
    0j 2di-- 0j q2-q1"e div' w q1-q2+1"e di^'  d q2-1\
    -1 f[ d force 0u..h @v
     f] d force
   %2> f] b bind
   w


!^R Set Window Separator:! !^R uses string argument or reads a line!
   [0 q0"e 1,m(m.m &_Read_Line)Window_Separator_Substring:_u0 '
   fq0"e w'
   q0m.v Window_Separator
   q0[1 (fs width-2)/fq0-1<:i110>
   q1m.v Window_Separator_String
   qNumber_of_Windows-1"g m(m.m &_Show_Separators)'
   w



!^R Grow Window Top:! !^R move the upper boundary of the current window!
   qNumber_of_Windows-2"l w'
   qCurrent_Window-1"e w'
   MMM_&_Check_Top_Levelwindows

   m(m.m &_Exit_Current_Window)
   qWindow_Data[0
   qCurrent_Window[1
   qNumber_of_Windows[2
   q1[3				    !* q3 holds the first window to be deleted!
				    !*  and deletion proceeds up to, but not!
				    !*  including q1!
   0[9				    !* truth flag saying whether or not to!
				    !*  redisplay the previous window!
   1[4 fs ^r argp #  "n u4'	    !* q4 has the real number of lines to move it!
   fs top line[5		    !* the eventual top line for this window!
   q4"l
    fs lines+q4-1"l w-(fs lines)+1u4' 1u9 '
   q4"g
    q5-q4-2"l w q5u4 ' '
   q5-q4u5			    !* the new top line for this window!
   q1-1<q5-q:(q:0(q3-1))(2)-1"g 0; '
        q5-q:(q:0(q3-1))(2)-1"e q5-1u5 '
	q3-1u3>
   q5u:(q:0(q1))(2)
   q1-q3"n
    q3u4 q1-q3<q:0(q4)[9 %4>
    q3u4 q1u5 q2-q1+1<q:0(q5)u:0(q4) %4 %5> 
    q2-(q1-q3)+1u4 q1-q3<0u:9(1) q9u:0(q4) ]9 %4>
    q2-(q1-q3)u2 q2uNumber_of_Windows
    q3u1 q1uCurrent_Window'
   fs height-(fs echo lines)u:(q:0(q2+1))(2)
   1u4 q2<q:(q:0(q4+1))(2)-q:(q:0(q4))(2)-1 u :(q:0(q4))(3) %4>

   m(m.m &_Goto_Current_Window)    !* make sure we are where we think!
   m(m.m &_Show_Separators)	    !* it has moved!
   q9"n 0,q1-1m(m.m &_Redisplay_Window)'   !* and he is different!
   w


!^R Grow Window Bottom:! !^R Move the bottom of the current window around!
    qNumber_of_Windows-2"l w'
    qCurrent_Window-qNumber_of_Windows"e w'
    MMM_&_Check_Top_Levelwindows

    qWindow_Data[0
    qCurrent_Window[1
    1[4 fs ^r argp #  "n u4'	    !* q4 has the actual argument!
    q4"l
     fs lines-q4-1"l w-(fs lines)+1u4'
     q:(q:0(q1))(3)+q4[2 q2fs linesw q2u:(q:0(q1))(3) ]2
     q:(q:0(q1+1))(2)+q4 u :(q:0(q1+1))(2)
     q:(q:0(q1+1))(3)-q4 u :(q:0(q1+1))(3)
     m(m.m &_Show_Separators)
     0,q1+1m(m.m &_Redisplay_Window)
     w'
    q4"g
     w'

    
    