!*-*-TECO-*-*!
!* <EMACS>PAGE.EMACS.42,  8-Feb-82 10:09:55, Edit by GERGELY!

!~Filename~:! !Commands for handling pages intelligently.!
PAGE

!& Setup PAGE Library:! !S Put macros on appropriate characters.!

    0M.C PAGE_Flush_CRLF*_Nonzero_=>_initial_blank_line_expected_and_ignored_on_each_page.
    0FO..Q PAGE_Setup_Hook[0
    fq0"G M0'
    "#
      M.M^R_Goto_Page	   U:.X()  	    !* Go to page on C-X C-P   !
      M.M^R_Insert_Pagemark u:.X(P)	    !* Insert Pagemark on ^X P!
      M.M^R_Goto_Next_Page  u:.X(])	    !* Goto Next Page on C-X ]!
      M.M^R_Goto_Previous_Page  u:.X([)  !* Goto Prev Page on C-X [!
      M.M^R_Join_Next_Page  u:.X(J)	    !* Join Pages on ^X J     !
      M.M^R_Widen_Bounds    u:.X(W)	    !* Widen Bounds on ^X W   !
      '
    M.M^R_Incremental_Search [0
    M.M^R_String_Search [1
    M.M^R_Character_Search  [3
    M.M^R_PAGE_Search[2	    !* get our new whitened brightened search.!
    [4

    (q.S-q0)*(q.S-Q1)"E	    !* if Search is on C-S    !
	q.S U4
	q2 u.S'		    !* Then PAGE Search on C-S !
    "# (q..S-q0)*(q..S-q1)"E    !* else if Search is on M-S!
	  q..S U4
	  Q2 u..S'		    !* then PAGE Search on M-S !
       "# Q.S-q3"e		    !* Else, if we see char search,!
            q1u4'		    !* redefine string search, since he probably uses that.!
	  "# FTCannot_find_Search!!!__Ask_a_wizard_for_help.'''

    Q4F"N M.V Real_Search_Macro'
    Q4-q0"e Q2 M.V MM_^R_Incremental_Search'  !* Let further redefiners of search win.!
    Q4-q1"e Q2 M.V MM_^R_String_Search'

    0M.C Current_Page!! 1fsmode ch 
    qSet_Mode_Line_Hook[1
    :i*1 M(M.M&_Set_PAGE_Mode_Line) uSet_Mode_Line_Hook
    0fo..q TECO_ mode_ hook F"E
	M.VTECO_ mode_ hook
	:i*'u1
    :i*1
	1M.LPAGE_ Flush_ Crlf
     uTECO_ mode_ hook

    0

!& Set PAGE Mode Line:! !S Add Page <n> onto the mode line, maybe.
Insert "Page" and the page number.!

    qCurrent_Page"e '
    q:.B(qBuffer_Index+4)[..O	    !* grab the buffer being described!
    fsVZ+b"E			    !* If bounds are wide,!
      0f[varmac
      0uCurrent_Page		    !* tell PAGE that they are.!
      '
    ]..O			    !* back to the mode-line buffer!

    i_Page_ qCurrent_Page\
    .-z( j:fb_Narrow"l fkd' )+zj   !* Flush "Narrow" as redundant.!
    

!^R Insert Pagemark:! !^R Insert a page mark, leaving new second page current.
Inserts a CRLF before the page mark if necessary.!

    0@f  "n 13i 10i'		    !* Make sure we are at start of line.!
    .-B"E 13i 10i'
    gPage_Delimiter .[1	    !* Insert a pagemark.  If several types, use the first.!
    0f :fb"l r .,q1k'	    !* Delete the others.  Leave point after the page mark.!
    qPAGE_Flush_CRLF"n 13i 10i'   !* Maybe insert a blank line after it.!
    fsvz+b"e 0uCurrent_Page'	    !* if bounds are secretly wide already, be aware of it.!
    qCurrent_Page"N
      %Current_Page
      0:M(M.M^R_Goto_Next_Page)'

!^R Goto Next Page:! !^R Make the next page current.
Set the virtual buffer boundaries to the next page.  If given
a negative argument, goes to previous page.!

    [0 .[1 [2
    fsvz+b"e 0uCurrent_Page'	    !* if bounds are secretly wide already, be aware of it.!
    0,fsZfsBoundw -1fsWindoww    !* widen bounds!
    qCurrent_Page"e		    !* if no virtual bounds then!
	0m.lCurrent_Page	    !* make sure local var exists.!
	ff"e 0u0'		    !* if no args then narrow to current page!
	j 1u2 qPage_Delimiter[3
	< .,q1+3:fb3;	    !* compute current page number in Q2.!
	  0@f  +fk"n !<!>'
	  .-z"E %2;'		    !* [PJG] so that last page is correct!
	  qPAGE_Flush_Crlf"n
	    :@f  "n !<!>''
	  %2 >
	q1j
	q2uCurrent_Page'
    qCurrent_Page+q0u2
    q2:"G			    !* if page num is not positive then!
	:1M(M.M^R_Goto_Page)'	    !* go to page 0.!
    q0 M(M.M^R_Mark_Page)
    z-."E
	.u1			    !* [PJG] store the point in 1!
	j 1u2 qPage_Delimiteru3   !* [PJG] get the delimiters!
	< .,z:fb3;		    !* [PJG] compute current page!
				    !* number in Q2.!
	  0@f  +fk"n .-z;!<!>'    !* [PJG] stop if at the end of the file!
	  .-z"E %2;'		    !* [PJG] Last page gets the right!
				    !* number!
	  qPAGE_Flush_Crlf"n	    !* [PJG] Check for the type of page!
	    :@f  "n !<!>''
	  %2 >
	q1j			    !* [PJG] Move back to the point!
	0M(M.M^R_Mark_Page)'	    !* [PJG] Mark the page!
    q2uCurrent_Page		    !* [PJG] Update page number!
    ."'N & qPAGE_flush_Crlf"N2:c' !* [PJG] if not at beginning then skip crlf!
    .(w):w			    !* exchange point and mark!
    z-."N :@0L'			    !* if not end then back over crlf and ^L!
    :,.f fsBoundw		    !* set bounds to this region!
    q1:j"e j'			    !* go back to where we were if we can!
    

!^R Goto Page:! !^R Go to a specific page, arg is page number.
If no arg then go to next page.  Negative arg means move back n pages.
If entire buffer is visible, no arg means select current page.!

    F"L [0'			    !* Negative arg => n pages back.!
       "#W FF"N		    !* if explicit argument!
	    -1[0
	    0,fsZfsBoundw -1fsWindoww
	    1m.l Current_Page
	    0j'			    !* Jump to the beginning!
	  "# fsvz+b"e 0[0'
	     "# 1[0'''
    Q0 M(M.M^R_Goto_Next_Page)	    !* get to the right page!
    0

!^R PAGE Search:! !^R Search that crosses virtual buffer boundaries.
Uses ^R Incremental Search or ^R String Search, whichever you had on C-S
or M-S when you loaded the PAGE library.  See the documentation of
whichever search you use for details.  You can change the search used by
doing, for instance, M.M^R String Search$ u$Real Search Macro$.!

    QReal_ Search_ Macro, @:M(M.M&_ Macro_ on_ Whole_ Buffer)

!& Macro on whole buffer:! !S Macros its precomma arg on the whole buffer.
The post-comma argument and @ flag are passed on to the macro.
If Current Page is non-zero, then the bounds are widened, the argument
is macroed, and the bounds are narrowed again to the current page.  Thus,
the way to do, say, a search is:
    M.M^R Incremental Search$, @M(M.M& Macro on Whole Buffer$)!

    fsvz+b"e 0uCurrent_Page'	    !* if bounds are secretly wide already, be aware of it.!
    F F & 2 "E @FEWNA FS Err' !* if no pre-comma arg, then explode!
    qCurrent_Page"E
	0M.L Current_Page
        F F & 8 "N @:M()' "# :M()''
    0,fsZfsBoundw -1fsWindoww
    F F & 8 "N @M()' "# M()'
    0uCurrent_Page
    @M(M.M^R_Goto_Next_Page)
    0

!& Page Directory:! !S Returns a string pointer to the page directory!

    qPage_Delimiter[7
    0f[vb 0f[vz .[1 fn q1j
    q..o [A			    !* remember our buffer!
    F[B BIND [..O Q..O[B	    !* and make a scratch buffer.!
    QAU..O 0J			    !* Scan through the real buffer.!
    0[4 [5 [6			    !* Q4 holds page number counter.!
    < .U5
      @f
_	L 0@L .-Q5"L Q5J'	    !* Advance to first nonblank line.!
      3,%4 :\ u5		    !* Increment page number, get as string in Q5.!
      S7
      fk"e 1@F X6' "# fkc :I6
'				    !* Get 1st nonblank line in Q6; just CRLF if blank page.!
				    !* But if blank, don't skip the formfeed.!
      qB u..o
      I5__6		    !* Put page number and first line in scratch buffer.!
      qA u..O
      < :S7;		    !* Find next page.!
        0@F  +FK"N !<!>'	    !* But delimiter only counts if after a CRLF.!
        QPAGE_ Flush_ Crlf "N
          :@F  "N !<!>''	    !* And maybe only counts if before a CRLF.!
	1; > .-Z;
      >
    :GB			    !* Return string copied from scratch buffer.!

!View Page Directory:! !C Prints a directory of the file.
Prints out the first non-blank line on each page, preceded by its
page number.!
    -1f[truncate
    M(M.M&_ Page_ Directory) [0
    FTPage____First_Non-blank_Line
0
    ]0 0


!Insert Page Directory:! !C Inserts a directory of the page at the beginning
Prints out the first non-blank line on each page, preceded by its
page number.  If given an argument, puts Comment Start at the start
of each line and Comment End at the end!

    M(M.M&_ Page_ Directory) [0
    BJ
    I0

    FF"N
        .[1 BJ
	QComment_ Start [2
	QComment_ End [3
	<G2  :L G3 2c .-q1;>
	]3 ]2 ]1'
    ]0 b,.

!^R Widen Bounds:! !^R Widen the virtual buffer bounds to include the whole file.
Calls ^R Set Bounds Full and clears the page number from the mode line.!

    0uCurrent_Page
    :M(M.M^R_Set_Bounds_Full)	    !* widen the bounds!

!^R Goto Previous Page:! !^R Make the previous page current.
Set the virtual buffer boundaries to the previous page.  If given
a negative argument, goes to the next page.!

    FF "E -1'"#-' :M(M.M^R_Goto_Next_Page)   !* go do it!

!^R Join Next Page:! !^R Combine two pages together.
Combines this page with next.  If given negative arg,
combines previous page with this one.!

    "L
       B"E @FENIB FS Err'
       BJ 0,fsZfsBoundw -1fsWindoww
       QCurrent_Page-1uCurrent_Page
       0@F  "E -L' 0L'
    "# FSVZ"E @FENIB FS Err'
       zj m(m.m^R_Set_Bounds_Full)f l'
    QPage_Delimiter[1
    -2D .,(S1).K
    QPAGE_Flush_CRLF"N K'
    .,.FS BOUND		    !* Hack to avoid making Goto Next Page clear Current Page.!
    0M(M.M^R_Goto_Next_Page)
    0


!*
/ Local Modes: \
/ MM Compile: 1:<M(M.MDate Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)PAGEPAGE
1:<M(M.MDelete File)PAGE.COMPRS>W \
/ End: \
!
 