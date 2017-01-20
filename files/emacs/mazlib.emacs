!* -*-TECO-*-!
!~Filename~:! !Maze-exploration game!
MAZLIB

!Maze Run:! !C Explore a maze looking for treasure.
String arg is name of maze definition file.
Special symbols used: "*" - your current location.
                      "@" - location of previously found treasure.
                      "=" - horizontal door.
                      "[" - vertical door.
		Some doors are one-way, and some are invisible.

The commands ^R Up real Line, ^R Down Real Line, ^R Forward Character and ^R Backward Character
will move you Up, Down, Right, Left in the maze.
^R Goto Beginning, ^R Goto End, ^R Next Screen, ^R Previous Screen and ^R New Window
are available for moving arround in the map.

"?" tells you how you are doing in the form:
"You Have a Score of <found>/<total> in <moves> Moves, for a xx% rating."

^R Exit will exit with your map in the buffer
in a form which can be saved for continuing (which is done by
loading the map and giving Maze Run a numeric argument.!

    :I*EMACS;MAZE_MAZE f[ D FILE
    0FS D VERS
    5,FRun_maze_fileFS D FILE
    5 f[ % TOP			    !* Keep walls on screen !
    5 f[ % BOTTOM
    50 f[ % CENTER		    !* !
    :I*TC fs ECHO DISPLAY	    !* Clear echo area !
    [0 [1 [2 [3 [4 [5 [6 [7 [8 [9 [Z	    !* Save some Q-regs !
    [U [D [I -1[M [G 0[S :I*|-[[==[C	    !* !
    ff "E
      fs z"n @FT Clobber_this_buffer_with_maze_map
        1m(m.m&_Yes_or_No)"e 0''
      hk '
    "# bj S .-1(\ uM c \ uS),z K '  !* if arg, set parms !
    Q..O [B			    !* QB keeps initial buffer !
    fs BCREATE			    !* Select a new buffer for maze !
    Q..O [A			    !* and keep it in QA !
    :I*0 [			    !* Kill <RUBOUT> !
    m.m^R_Maze_Info [?	    !* Put info stuff on ? !
    m.m&_Replace_Macro u9	    !* Save some time !
    fs^r init,(m.m^R_Maze_Exit)m9    !* Make sure we can exit !
    m.m^R_Autoargument,(m.m^R_Maze_Autoargument) m9
    m.m^R_Next_Screen,(m.m^R_Maze_Next_Screen) m9
    m.m^R_Previous_Screen,(m.m^R_Maze_Previous_Screen) m9
    m.m^R_Goto_End,(m.m^R_Maze_Goto_End) m9
    m.m^R_Goto_Beginning,(m.m^R_Maze_Goto_Beginning) m9
    m.m^R_Prefix_Meta,(m.m^R_Maze_Prefix_Meta) m9
    m.m^R_Prefix_Control,(m.m^R_Maze_Prefix_Control) m9
    m.m^R_Prefix_Control-Meta,(m.m^R_Maze_Prefix_Control-Meta) m9
    fs ^R INIT,(m.m^R_Maze_Left) m9
    fs ^R INIT,(m.m^R_Maze_Right) m9
    m.m^R_Up_Real_Line,(m.m^R_Maze_Up) m9
    m.m^R_Down_Real_Line,(m.m^R_Maze_Down) m9
    m.m^R_New_Window,(m.m^R_Maze_New_Window) m9
				    !* Switch some character macros !
    1,m.m&_Setup_CAPL_Library "N   !* If CAPL Library is loaded!
	@:I*`W` [ '	    !* make sure <esc> prefix works.!
    -1 f[ ^R REPLACE
    er @Y bj \ f"E 1' uG c \ [N    !* Visit the Maze file !
    :S "L .,zFXZ '"# :I*W0uZ ' bj    !* Strip off special macro !
    @:II\[0 q0 f:.<>^v :f"L :GC u0 '
        1A-q0 "N 0@V m0 '"# c ' ]0 \	    !* Macro to insert char !
    @:IU\w fs S HPOS [T	    !* QU has up line !
       -1l 1:< 0,QT :FM >  \
    @:ID\w fs S HPOS [T	    !* QD has down line !
       1l 1:< 0,QT :FM >  \
    ff "N QB u..O '		    !* if arg, start at old spot !
    j s* r .u0			    !* Get start position in Q0 !
    ff "E			    !* if no arg, prepare buffer !
       QB u..O			    !* Back to other buffer !
       er @Y			    !* Same File !
       :S "L .,zK '	    !* Get rid of special macro !
       j < .-z;			    !* Replace each line's contents with same # of spaces.!
           :f  f(d),32i
	   l >'
    1 f[ READ ONLY		    !* no buffer munging !
    :I*0 f[ ^R NORMAL
    1 f[ ^R SUPPRESS
    QA u..O			    !* Select maze buffer !
    Q0 u1 Q0 j m(m.m&_Maze_Draw)   !* Draw the start position !
    				    !* and enter ^R !
    QBU..O
    QA fs BKILL 		    !* Kill buffer and exit !


!^R Maze Right:! !^R Move to the right !
W
    QA u..O Q0 j		    !* Select maze buffer !
    2A f_:>[ "L FG QB u..O 0'  !* If wall bing and quit !
    .u1 2C :m(m.m&_Maze_Draw)	    !* move and exit to draw maze !


!^R Maze Left:! !^R Move to the left !
W
    QA u..O Q0 j		    !* Select maze buffer !
    0A f_:<[ "L FG QB u..O 0'  !* If wall bing and quit !
    .U1 2R :m(m.m&_Maze_Draw)	    !* Move and exit to draw maze !
    

!^R Maze Up:! !^R Move Up !
W
    QA u..O Q0 j mU		    !* Select maze buffer !
    1A f_.^="L FG QB u..O Q0 j 0 ' !* If wall, bing and quit!
    mU Q0 u1 :m(m.m&_Maze_Draw)    !* Move and exit to draw maze !


!^R Maze Down:! !^R Move Down !
W
    QA u..O Q0 j mD		    !* Select maze buffer !
    1A f_.v="L FG QB u..O Q0 j 0 ' !* If wall, bing and quit!
    mD Q0 u1 :m(m.m&_Maze_Draw)    !* Move and exit to draw maze !


!& Maze Draw:! !S Draw the part of the maze that is now visible !

!Start! .u0 mU 0Au2 1Au3 2Au4	    !* Collect surrounding chars !
    Q0 j 0Au5 2Au6 mD 0Au7	    !* !
    1Au8 2Au9 Q0 j 1A[T		    !* !
    Q1 j 1A-64[X 0 fs ^R NORMAL    !* !
    QB u..O 0 fs READ ONLY	    !* Select drawing buffer !
    Q1 j QX "N 32mI ' "# 64mI '	    !* Clear old spot !
    Q0 j 1A-64 "E 1uT ' 42mI mU w2R	    !* Draw surrounding chars !
    Q2mI wQ3mI wQ4mI Q0 j R wQ5mI wC wQ6mI  !* !
    mD w3R wQ7mI wQ8mI wQ9mI Q0 j	    !* !
    QT-64 "G QAu..O <:s; :sT;   !*If a teleport, find table entry!
      1A-42 "N 0; '		    !* No multilevel stuff yet !
      c q0 u1 w\u0 q0 j O start >  !* Go there !
      QBu..O '			    !* Failed, back to map !
    QM+1 uM			    !* Count Moves !
    QT-64 "E			    !* If a treasure, !
       QS+1 uS QG-QS :"G	    !* If a win !
          -1m(m.m^R_Maze_Info)	    !* Say so !
          0 fs ECHO ACTIVE	    !* and !
          fs ^R EXIT '		    !* leave ^R !
       m(m.m^R_Maze_Info) '	    !* Tell him the score !
    QT-64 f"L +16 :f"L ,Q0mZ "N O start ''' !* Maybe run special macro !
    1 fs READ ONLY :I*0 fs ^R NORMAL	    !* Protect the buffer !
    0				    !* ^R has already been told of changes !




!^R Maze Exit:! !^R Exit the Maze ^R level !
W
    0 fs READ ONLY
    .( zj 1I QM-1\ 1I QS\ )J
    fs ^R EXIT


!^R Maze Prefix Meta:! !^R !
W
    :m(m.m^R_Prefix_Meta)


!^R Maze Prefix Control:! !^R !
W
    :m(m.m^R_Prefix_Control)


!^R Maze Prefix Control-Meta:! !^R !
W
    :m(m.m^R_Prefix_Control-Meta)


!^R Maze Info:! !^R Says how your doing in the maze.!
W
    "L :I*CTD fs ECHO DISPLAY '
    QM :\ u7 QS :\ u8 QG :\ u9
    QG-QS "G @FTYou_Have_a_Score_of_8/9 '
        "# @FTYou_Win '
    @FT_in_7_Moves
    QN "N QM "N
            QN*QS/QG u7
	    QM-Q7 "G
	        2*QM-Q7*Q7*100/QM/QM :\ u8 '
		"# :I8100 '
	    @FT,_for_a_8%_Rating ' '
    @FT.
    
    0 fs ECHO ACTIVE


!^R Maze Next Screen:! !^R Move down to display next screenful of text.
With argument, moves window down <arg> lines.!
W f:@m(m.m^R_Next_Screen)


!^R Maze Previous Screen:! !^R Move up to display previous screenful of text.
With arg, move window back <arg> lines.!
W f:@m(m.m^R_Previous_Screen)


!^R Maze Goto End:! !^R !
W f:@m(m.m^R_Goto_End)


!^R Maze Goto Beginning:! !^R !
W f:@m(m.m^R_Goto_Beginning)


!^R Maze Autoargument:! !^R !
W f:@m(m.m^R_Autoargument)


!^R Maze Add Teleport:! !^R Add a new teleport destination to table.!

    1,0fChar:_ [0 .[1 q1 :\[2
    j :S "L r W b,. fs BOUNDA '
    j :S (zj) "E 1I '
    I0*2
     0,fs Z fs BOUNDA W q1 j 



!^R Maze New Window:! !^R !
W f:@m(m.m^R_New_Window)



!& Replace Macro:! !S Replaces macro definitions on ^R characters.
Takes two arguments. The first is the macro to be replaced and
the second is the replacement. It pushes the old definitions so
that they are restored when the caller returns.!

    -1u..9			    !* Q..9 - Character counter !
    < %..9, :F U..9 Q..9:;	    !* Find next char whose def. matches !
         [..9 >		    !* and push on the new definition !

    !* Now we handle any definitions that are on prefix characters.!

    q..ou..5
    fs b create gPrefix_Char_List j
    < .-z; s__ c :x..6 l	    !* Get next prefix table qreg name.!
      :I..7..6(Q..9)		    !* Q..7 has refer to subcmd in Q..9!
      -1u..9
      < %..9,F..6 U..9	    !* Find next char whose def matches !
	Q..9:;			    !* If no more, exit loop.!
	Q:..7 [..8		    !* Push old def on Q..8.!
	Q..9 :\ U..3		    !* Make number into string.!
	[..N :I..N Q..8 U:..6(..3)	    !* and organize its return.!
	 U:..7 >		    !* Now change the definition !
	>			    !* Loop through Prefix Chars !
    q..o( q..5u..o )fs bkill
    0_				    !* NO ^\ !
