!* -*-TECO-*-	This library implements EMACS CLU MODE.!
!* The source for this file is [XX]<emacs>clu.emacs or [AI]emacs1;clu >!

!~FILENAME~:! !Package for editing CLU code (CLU Mode).!
CLU

!CLU Mode:! !C Set up for editing CLU code.
This is sort of like LISP mode with S-expression replaced
   by "CLUexp" (fully nested CLU expression)
The following commands are set up:
    C-M-F	  ^R Forward CLUexp
    C-M-B	  ^R Backward CLUexp
    C-M-K	  ^R Kill CLUexp
    C-M-rubout	  ^R Backward Kill CLUexp
    C-M-@	  ^R Mark CLUexp
    M-H		  ^R Mark Lines Of CLUexp
    C-M-T	  ^R Transpose CLUexps
    C-M-D	  ^R Down CLUexp
    C-M-U, C-M-(  ^R Backward Up CLUexp
    C-M-)	  ^R Forward Up CLUexp
    C-M-A	  ^R Beginning of Module
    C-M-E	  ^R End of Module
    M-(, M-[, M-{ ^R Make CLU (), [], or {}
    C-;, M-;	  ^R Indent for CLUcomment
    C-M-;	  ^R Kill CLUcomment
    tab		  ^R Indent for CLU
    linefeed	  ^R Indent New CLU Line
    M-J		  ^R Indent New CLUcomment Line
    M-G		  ^R Indent CLU Region
    M-Q		  ^R Indent Lines Of CLUexp
    M-&		  ^R CLU Compile!


!* To do:
 check errsets,
 note that C-X ; calls indent comment relative or whatever, check same
 mobily speed up Count Line Nesting by using f^A ???
 finish Backward Up CLUexp: make it count MAX Q2 in Count Line Nesting
 Don't use Indent for Comment in M-N, M-P - they call tab and hang
   if %% comment exists ?????? What to do about this??
   (It doesn't use Indent for Comment, but it might be nice to see
      what the problem was)
 check the following:
  other useful stuff?: <arg>M-;    C-X tab      C-M-\   others?
  Indent Comment Relative as C-U C-X ; ??
!
 m(m.m &_Init_Buffer_Locals)

 1,(:i*%) m.LComment_Startw
 1,(0fo..qCLUcomment_Beginf"e w :i*%_ ') m.LComment_Beginw
 1,(:I*) m.LComment_Endw
 1,(32fo..qCLUcomment_Column) m.LComment_Columnw
 QPermit_Unmatched_Paren"l
   1,0m.LPermit_Unmatched_Paren'

!* The following variable definitions are made partly for speed, but some!
!*   are also made to override the standard definitions of functions so!
!*   that when, for example, ^R Down Comment Line calls!
!*   ^R Indent for Comment, it actually gets ^R Indent for CLUComment,!
!*   which is not fooled by percent in a string.!

 1,m.m^R_Indent_for_CLUcommentm.LMM_^R_Indent_for_Comment
 1,m.m^R_Indent_New_CLU_Linem.LMM_^R_Indent_New_Line
 1,m.m^R_Indent_New_CLUcomment_Linem.LMM_^R_Indent_New_Comment_Line
 1,m.m^R_Kill_CLUcommentm.LMM_^R_Kill_Comment

 1,m.m^R_Forward_CLUexp       m.Q...F   !* C-M-F !
 1,m.m^R_Backward_CLUexp      m.Q...B   !* C-M-B !
 1,m.m^R_Kill_CLUexp          m.Q...K   !* C-M-K !
 1,m.m^R_Backward_Kill_CLUexp m.Q...  !* C-M-rubout !
 1,m.m^R_Mark_CLUexp          m.Q...@   !* C-M-@ !
 1,m.m^R_Mark_Lines_Of_CLUexp m.Q..H    !* M-H !
 1,m.m^R_Transpose_CLUexps    m.Q...T   !* C-M-T !
 1,m.m^R_Down_CLUexp          m.Q...D   !* C-M-D !
 1,m.m^R_Backward_Up_CLUexp   m.Q...(   !* C-M-( !
 1,Q...( 		       m.Q...U   !* C-M-U same as C-M-( !
 1,m.m^R_Forward_Up_CLUexp    m.Q...)   !* C-M-) !
 1,m.m^R_Beginning_of_Module  m.Q...A   !* C-M-A !
 1,m.m^R_End_of_Module        m.Q...E   !* C-M-E !
 1,m.m^R_Make_CLU_()	       m.Q..(    !* M-( !
 1,m.m^R_Make_CLU_[]	       m.Q..[    !* M-[ !
 1,m.m^R_Make_CLU_{}	       m.Q..{    !* M-{ !
 1,m.m^R_Indent_CLU_Region    m.Q..G    !* M-G !
 1,m.m^R_Indent_New_Comment_Linem.Q..J  !* M-J !
 1,Q..J 		       m.Q..J    !* M-linefeed same as M-J !
 1,m.m^R_Indent_Lines_Of_CLUexpm.Q..Q   !* M-Q !
 1,m.m^R_Indent_for_Comment   m.Q..;    !* M-; !
 1,Q..; 		       m.Q.;	    !* C-; same as M-; !
 1,m.m^R_Kill_Comment         m.Q...;   !* C-M-; !
 1,m.m^R_CLU_Compile	       m.Q..&    !* M-& !
 1,m.m^R_Indent_for_CLU       m.QI	    !* tab !
 1,m.m^R_Indent_New_Line      m.QJ	    !* linefeed !

!* create the variable "CLU Indent Offset" if not already there,
     with comment for editing with M-X Edit Options !

 3m.cCLU_Indent_Offset*_Amount_by_which_nested_CLU_code_is_indented

 m.vCLU_..Dw		    !* Create a var for our dispatch table. !
 ^:iCLU_..Dq________________________________________________________________________________________________________________________________________A_____________________________A____|____A____A____;____A____|____(____)(___A____A_________A____A____A___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA_________A____A_________A____A____A___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____(____/____)[___A___AA____A___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____(____A____){___A________q	    !* And set up the dispatch table. !

 m.q ..D			!* Make ..D local !
 qCLU_..D u..D		!* Set it to the right thing !

 q.0,1M(M.M&_Set_Mode_Line)CLU !* Set, display mode. !
 

!^R Forward CLUexp:! !^R Move forward past one CLU expression (or several).!
0[2 [3
f"g:<.-z:"l fg ' m(m.m&_Count_Line_Nesting)f"g w fg 0;' "l !<! l @>' >
'
[4				    !* must go backward !
-:<.:"g fg ' m(m.m&_Count_Back)f"g w fg ' "n 999-q2u2
   <0l .:"g fg ' -l q2u4
      m(m.m&_Count_Line_Nesting)"g w fg ' q2+q4-q3-999; >
   999-q4u2 !<! @>' >


!^R Backward CLUexp:! !^R Move backward past one CLU expression (or several).!
-:m(m.m ^R_Forward_CLUexp)

!^R Kill CLUexp:! !^R Kill next CLU expression (or several).!
[9 .,(m(m.m ^R_Forward_CLUexp)). f  :m(m.m &_Kill_Text)

!^R Backward Kill CLUexp:! !^R Kill previous CLU expression (or several).!
-[9 .,(-m(m.m ^R_Forward_CLUexp)). f  :m(m.m &_Kill_Text)

!^R Mark CLUexp:! !^R Set mark one CLU expression (or several) from point.!
.(m(m.m ^R_Forward_CLUexp).:)j 0

!^R Mark Lines Of CLUexp:! !^R Set region around lines of one CLU expression (or several).
Backs up to the beginning of the current line, puts the region around
the full lines of the next (or previous) N CLU expressions.
Puts mark at front, point at end.!
0l .,(m(m.m ^R_Forward_CLUexp)). f  [1 j	    !* find region !
0l .:				    !* Fudge beginning downward !
q1j :r"l l'			    !* Move to end and fudge it upward !
				    !* Put mark at front and point at end.!


!^R Transpose CLUexps:! !^R Transpose the CLU expressions before and after the cursor.
For more details, see ^R Transpose Words, reading "CLUexp" for "Word".!

m.m ^R_Forward_CLUexp[K
 :i* (.[8) mKw q8,. (q8j ]8) f , :m(m.m&_Transpose_Subr)

!^R Down CLUexp:! !^R Move down one level of CLU structure (or several), forward.
With negative arg, goes up, forward.!

-:m(m.m ^R_Forward_Up_CLUexp)    !* set Q2 so it will count up to zero !

!^R Backward Up CLUexp:! !^R Move up one level of CLU structure (or several), backward.
With negative arg, goes down, backward.!
[2 [3 [4
"g 1:<.:"g fg ' m(m.m&_Count_Back)f"g w fg ' "n 999-q2u2
   <0l .:"g fg ' -l q2u4
      m(m.m&_Count_Line_Nesting)"g w fg ' q2+q4-q3-999; >
   999-q4u2 !<! @>' >
'
		!* going down, this is very tricky !
1:<.:"g fg ' m(m.m&_Count_Back)f"g w fg ' "n 999-q2u2
   <0l .:"g fg ' -l q2u4
      -1m(m.m&_Count_Line_Nesting)"g w fg ' q3+999-q2-q4; >
   999-q4u2 !<! @>' >


!^R Forward Up CLUexp:! !^R Move up one level of CLU structure (or several), forward.
With negative arg, goes down, forward.!
[2 [3				    !* set Q2 so it will count down to zero !
1:<.-z:"l fg 0;' m(m.m&_Count_Line_Nesting)f"g w fg 0; ' "l !<! l @>' >


!^R Beginning of Module:! !^R Move to beginning of this or previous module.
Leaves the mark behind, in case typed by accident.  The beginning
of a module is sym = proc or iter, at beginning of line.!

    .: f[s string
    <<-:Sprociter();  !* Search back for keyword.!
    -@f	_l		    !* Pass whitespace before.!
    0a-= "n !<! > ' r		    !* Demand "=", pass same.!
    -@f	_l		    !* Pass whitespace before.!
    !* Demand have just a word and whitespace on the line.!
    -fw f( l )   -(fw )  (-@f	_l 0@f  ) (fwl c) @;> 0l >
0

!^R End of Module:! !^R Move to end of this or next module.
Leaves the mark behind, in case typed by accident.  The end
of a module is just before the beginning of the next: see
^R Beginning of Module.!

!* Crock, make it do the right thing if run off end of file.!

    .: .[1 [2 [3 [5 1[6 f[s string	    !* Drop mark, save place.!

    !* This outermost iteration will usually happen twice - !
    !*   once with Q6 = 1, and then with Q6 = arg.!

    !* It starts by searching for a header Q6 times.!

    < q6<<:Sprociter(:);  !* Search forward for keyword.!
    -@f	_l		    !* Pass whitespace before.!
    0a-= "n fwl !<! > ' r	    !* Demand "=", pass same.!
    -@f	_l		    !* Pass whitespace before.!
    !* Demand have just a word and whitespace on the line.!
    -fw f( l )   -(fw )  (-@f	_l 0@f  ) (:l) @; >>

    !* We have now gone forward to the q6'th header,!
    !*   and are at the end of the line.!
    !* Save place, then go to just after the preceding "end"!
    !*   (or beg of buffer).!

    .u5 < 0l -.; -l 999u2 -1m(m.m&_Count_Line_Nesting) w q2-q3"l l 0; '>

    !* If first time: if didn't go forward, skip ahead to Q5,!
    !*   else exit if arg=1 (we are done in that case),!
    !* If second time: exit always (because Q1<0 and Q6=arg).!

    q1-."l -q6"e 0' '"# q5j '

    !* Set up for second time.!

    -9u1 u6 >

!^R Make CLU ():! !^R Insert () putting point between them.
With explicit positive argument, put the ) after the specified number
of already existing CLUexps.  Thus, with argument 1,
puts extra parens around the following CLUexp.!
    .[0
    ff"'e+1*f"g m(m.m ^R_Forward_CLUexp)' w i) .[1
    Q0J i( Q0,Q1+1

!^R Make CLU []:! !^R Insert [] putting point between them.
With explicit positive argument, put the ] after the specified number
of already existing CLUexps.  Thus, with argument 1,
puts extra brackets around the following CLUexp.!
    .[0
    ff"'e+1*f"g m(m.m ^R_Forward_CLUexp)' w i] .[1
    Q0J i[ Q0,Q1+1

!^R Make CLU {}:! !^R Insert {} putting point between them.
With explicit positive argument, put the } after the specified number
of already existing CLUexps.  Thus, with argument 1,
puts extra braces around the following CLUexp.!
    .[0
    ff"'e+1*f"g m(m.m ^R_Forward_CLUexp)' w i} .[1
    Q0J i{ Q0,Q1+1

!^R Indent for CLUcomment:! !^R Move to or create comment.
Finds start of existing comment, or creates one at end of line.
Indents the comment to Comment Column.
An existing double percent comment is aligned like a line of code.  
An existing triple percent comment is not moved.
With argument <n>, aligns the existing comments in the
next <n> lines, but does not create comments.
Comment Begin holds the string inserted to start a comment.
Comment Rounding holds the macro used when the code goes
past the comment column, to compute a new (larger) comment column
from the width of the code!

    f[ s string		    !* save the default search string !
    m.m &_Count_Line_Nesting[L
    999[2 [3

    ff"n			    !* With arg, repeat over that many lines,!
      m.m ^R_Indent_For_CLUcomment[.1
      < 0l mL			    !*   and indent only if there is already!
      0,1a-% "e m.1'		    !*   is a comment.!
          l>
      -f '			    !* Return range covering lines scanned.!

!* Here is the real operation.!

    :i*%_[B
    0fo..qComment_Beginf"n uB'
    qComment_Column[C
    m.m &_Xindent[I

    [R [1			    !* qR gets (if needed) macro !
				    !*   to round comment col up. !
				    !* Each time thru, QH gets hpos and !
				    !*   q1 gets actual comment col. !
    -1[.1

    0l mL			    !* Scan the line, will stop just before %.!
    0,1a-% "n :l gB fqBr'	    !* If no comment yet, make one.!

    "#				    !* For an existing comment,!
      1a-(0,2a)"e		    !* Is percent duplicated? !

	1a-(0,3a)"n		    !* Yes, exactly two? !
	10,-(@-f	_ )a-10"e
				    !* If double but not on line by itself,!
				    !*   don't move it.!
	    !* Double and on line by itself => align comment !
	z-.[8 mI (z-q8+2j)''    !*   as if it were code. !

	!* Whether two or more, go to after the starter.!
	@f%-1l .,zf=Bf"e fqB+1'  -1c 0 '

      fs shposu.1'		    !* Single, get old comment-indentation.!

!* Now have a single percent comment to align,!
!*   we are just before it, q.1 maybe has its column, to optimize!
!*   re-indentation.!

    .[.3 @-f	_l	    !* Back up over indentation before calculating hpos!
    qCu1 fs shpos[H		    !* since the hpos will affect where comment goes!
    qH-q1+1"g			    !* If code on line goes past comment column, round it up.!
      0fo..q Comment_RoundinguR    !* QR gets macro to round column upward!
      qR"e qH+1u1'
      "# qH-q1R+q1 u1''	    !* Q1 gets temporarily altered comment col for this line.!

!* Now Q1 has column where comment will actually go, it is > QH. !

    .[.2 q1-q.1"n .,q.3k	    !* If indentation must be changed, flush old!
      qH,q1mI'			    !* and insert the new.!
    "# q.3j'			    !* Else move fwd over existing indentation.!
    .,zf=Bf"e fqB+1'  -1c    !* Move fwd over comment starter.!
    q1-q.1"e 0'		    !* Return 0 if no change!
    q.2,.			    !* or range of change.!

!^R Kill CLUcomment:! !^R Kills the comment (if any) on the current line.
With argument, applies to specified number of lines, and moves past them.!

    ff"n			    !* With arg, apply to that many lines,!
				    !*   and move down.!
     < m(m.m ^R_Kill_Comment)f wl> 0'

    f[s string 0fs^R Prev	    !* Can't combine with previous Kill !
    .[1 999[2 [3 0l m(m.m &_Count_Line_Nesting)
    0,1a-% "n q1j 0'	    !* Find the comment beginning,!
				    !*   or exit if none!
    @-f	_l		    !* Move back over white space!
    .,(:l).:m(m.m &_Kill_Text)	    !* Now murder!

!^R Indent for CLU:! !^R Indent this line for CLU format.!
(10,-(@-f	_ )a-10)"n 9i -1  '
		!* if nonwhite stuff to left, just insert tab !

m.m &_Xindent[I
qCLU_Indent_Offset[Z
m.m &_Count_Line_Nesting[L
qComment_Column[C
0fo..q Comment_Rounding[R
-999[2 [3 qZ*999[8
0l .[4				    !* save place !

!* search back for nonblank line with text other than single or triple % !

<.:"g oN'		    !* if hit start of buffer, use zero !
-l @f	_l		    !* go to end of indentation !
(1A-13)*(.,zf=%%%  &1):@;>	    !* exit unless at CR or odd number !
				    !*   of percents (gasp) !

!* have found the line to take nesting from !

0l mL
0l @f	_l -q3*qZ+fs hposu8

!* Have the magic numbers in q2, q8.!

!N! q4j @f	_l 13,1a-13"e 0k 0,q2*qZ+q8mI 0f  '
!* If line is blank, create indentation and go to end.!
!* Otherwise, adjust and go to beginning.!
m(m.m&_Indent_CLUline) 0l :f 

!^R Indent New CLU Line:! !^R Create new line, indented for CLU format.
May change indentation of last line also!

!* This is used for ^R Indent New CLUcomment Line also,!
!*   when called with nonzero precomma arg.!

-@f_	k @f	_k !* Delete whitespace at end of old !
				    !*   line and beginning of what will be !
				    !*   new line.!
.[7 i
				    !* insert CRLF !

!* Now at beginning of new line.!
!* Must set indentation of new line, and perhaps old one as well.!
!* Q7 = lower limit of changed stuff.!

m.m &_Xindent[I
qCLU_Indent_Offset[Z
m.m &_Count_Line_Nesting[L
qComment_Column[C
0fo..q Comment_Rounding[R
z-.[0 -999[2 [3 qZ*999[8 13,1a-13[5 -1[6

!* Q0 gives beginning of new line (w.r.t. z).!
!* Q5 = 0 will mean to repair indentation of previous line.!
!* Q6 = 0, and later Q6 > 0, will signal special action for!
!*   Indent New CLUcomment Line.!

!* Will not consider changing indentation of previous line if new line !
!*   is not blank, since fresh text is not being typed in.!
!*   Hence Q5 is set nonzero if so.!

!* If Indent New CLUcomment Line, examination of previous line is special.!

"n
-l @f	_l		    !* Go to end of indentation.!
1a-%"e fs hposu8 @f%-1x3 oC '	    !* Comment only.!
1a-13"n 0u6 oD '		    !* real text on last line!
				    !*   (maybe comment too).!
1u5'				!* Previous line empty, must search farther.!

!* search back for nonblank line with text other than single or triple % !
!*   if not on immediately preceding line, will set Q5~=0 !

<0l .:"g oN '			    !* If hit start of buffer, use zero.!
-l @f	_l		    !* Go to end of indentation.!
(1A-13)*(.,zf=%%%  &1):@; 1u5>   !* Exit unless at CR or odd number !
				    !*   of percents (gasp).!

!* have found the line to take initial indentation from !
!*   if Q5 = 0 it needs to have its indentation fixed !
!* Q6 = 0 means this is Indent New CLUcomment Line and previous!
!*   line has code and needs to be checked for having comment also.!

!D! mL			    !* Measure the reference line.!
1a-%q6"e z-.u6 '
!* Now Q6 > 0 means this is Indent New CLUcomment Line and previous!
!*   line has code and comment, z-q6 will get back to it.!
0l @f	_l

!* if reference line was not just before, its indentation is already correct !

q5"n -q3*qZ+fs hposu8 '

!* otherwise, may need to fix reference line too !

"# q8+fs hposu8
   q3+999"n -999u2 m(m.m&_Indent_CLUline) 0l .u7 ''

!* Now fix this line !

q6"g oF '

!N! z-q0j 13,1a-13"e q2*qZ+q8mI q7,. '
!* If line is blank, create indentation and go to end.!
!* Otherwise, adjust and go to beginning.!
m(m.m&_Indent_CLUline) :l q7,.(0l)

!* Aligning a comment, previous line had real text and comment.!
!* See if it was a %% comment.!
!F! z-q6j @f%-1x3		    !* Save extra percents.!
fq3-1"e q2*qZ+q8u8 '		    !* %% comment, must align new comment!
				    !*   relative to code, not comment.!
     "# fs hposu8 '		    !* % or %%% - no problem.!
!C! z-q0j q8mI g3 gComment_Begin q7,.

!^R Indent New CLUcomment Line:! !^R Inserts CRLF, then starts new comment.
The indentation and the number of percents are copied from the
previous line's comment.  May change indentation of last line also.
If done when not in a comment, acts like ^R Indent New CLU Line.!
1,:m(m.m^R_Indent_New_CLU_Line)

!^R Indent CLU Region:! !^R Indent region in CLU format, relative to previous line.
All the lines in the region (first character between point and mark)
have their indentation set for CLU format, relative to previous line.
Leave mark before and point after, unless arg given,
in which case do the opposite.!

m.m &_Xindent[I
qCLU_Indent_Offset[Z
m.m &_Count_Line_Nesting[L
qComment_Column[C
0fo..q Comment_Rounding[R
-999[2 [3 qZ*999[8

.,( w .)f  [1 [0		    !* find region !
q1j :r"l l' z-.u1		    !* Move to end and fudge it !
q0j :r"l l' .u0			    !* Move to beginning and fudge it !
				    !* Bounds are in Q0, Q1 !

q0,z-q1m(m.m&_Save_for_Undo)Indent	    !* Set up for Undo.!

!* search back for nonblank line with text other than single or triple % !

<.:"g oN'			    !* if hit start of buffer, use zero !
-l @f	_l		    !* go to end of indentation !
(1A-13)*(.,zf=%%%  &1):@;>	    !* exit unless at CR or odd number !
				    !*   of percents (gasp) !

!* have found the line to take initial indentation from !

0l mL
0l @f	_r -q3*qZ+fs hposu8    !* Record its indentation !

!* now have the necessary data in Q2, Q8 !

!N! q0j <.+q1-z;
@f	_l		    !* go to end of indentation, take a peek !
0,1A-13"e 0k '			    !* if line is blank, kill any white junk, !
				    !*   and we are done !
"# m(m.m&_Indent_CLUline) ' l >    !* Otherwise, indent line properly.!

ff"e q0f(:),.  '	    !* Put mark at front and point at end.!
q0,(.:).(q0j) 		    !* If arg, do it the other way.!

!^R Indent Lines Of CLUexp:! !^R Indent full lines of one CLU expression (or several).
Backs up to the beginning of the current line and indents the full
lines of the next (or previous) N CLU expressions.  Puts mark at
front, point at end.  This is just ^R Mark Lines Of CLUexp followed by ^R Indent CLU Region.!

m(m.m ^R_Mark_Lines_Of_CLUexp)
m(m.m ^R_Indent_CLU_Region)

!^R CLU Compile:! !^R Call the CLU compiler.
Create a compiler if needed.  We first offer to write out each file,
unless there is a numeric arg other than 0.  Reads a command line to
pass to CLU: "&" in it is translated into the name of the visited file.
If just CR is typed, "compile &" is used, that is, it compiles the
visited file.  The command line may have several commands separated by
"#".  We always add the "stay" command.  The CLU compiler is kept from
one call to another.  Arg = 0 => just kill the compiler.!

ff"e m(m.m Save_All_Files)'
   !* Arg 0 is special, destroy the compiler.!
"# "e -qCLU_*Handle* f"l fz' w -1uCLU_*Handle* 0''

!* Set up helpful action if user types the help character.!

:i* :ftCLU_command_(or_several_commands_separated_by_#)
If_null,_will_compile_this_file.
  f[help mac

3,m(m.m &_Read_Line)CLU_command:_[3	    !* Find out what user wants.!
fq3"l 0u..h '			    !* Give up if get a rubout instead.!

fq3"e :i3compile_& '
qBuffer_Filenames[5
[4 [6 :i4			    !* q4 get stuff already processed.!
<&f3 f(:;) f(,0:  :g3u6 :i4465)+1,fq3 :g3u3 >
:i343_#_stay		    !* Q3 has the JCL line to use.!
:ft >>>___3___Running.....    !* Echo the command.!


qCLU_Compiler[4
qCLU_*Handle*f"l		    !* See if we have a compiler somewhere.!
fz 4_#_3uCLU_*Handle*'	    !* We do now.!
"#,0:  fz clu_#_3'		    !* when restarting, must provide !
				    !*   phony job name for it to flush.!

0u..h				    !* erase the "running" message!
fs msname :f6u3		    !* Get the connected directory!
m(m.m View_File) 3clu.junk.0    !*   so we always display the right file.!
0

!& Count Line Nesting:! !S Count nesting difference across line.!
!* Stays on same line, leaves Q2 altered by nesting difference.
Exits immediately, returning 0, if pass anything and have Q2=0.
Returns -1 if finish line without passing anything with Q2=0.
   In this case, we are at end of line or just before percent.
Returns +1 if error: an attempt was made to decrease Q2 from 0 to -1.
   In this case, we are just before the offending token, and Q2=0.

If no arg (that is, arg=0), sets Q3 to minimum value of Q2, as follows:
   If Q2 is very positive (say 1000), Q3 will be the minimum value of Q2
      on the line.  This is used during long backward searches to find out
      whether to call & Count Back for a backward scan.
   If Q2 is very negative (say -1000), Q3 will be just the minimum value
      Q2 took on the initial run of ending tokens.  That is, it stops
      recording the minimum whenever a neutral or beginning token is seen.
      This is used for computing the indentation for the line.
   All this is computed by letting Q5 be extremely positive until a beginning
   or neutral token is seen, and 0 thereafter.  Whenever Q2 is decremented,
   Q3 is set to min(Q3, max(Q2, -Q5).

If arg = -1 and Q2 is very negative, Q3 will be the maximum value
      that Q2 had on the line.  This is used by ^R Backward up CLUexp.

This clobbers Q2 and Q3. !

q2u3 9999[5	!* initialize q3, q5 will go to zero !
		!*   when see a beginning or neutral token !

!* search (on this line only) for percent, alpha, parens, or quotes !
<:f :fb%([{)]}"'+2f"g()-2c -1 ' !*
	  if nothing or percent, exit with -1.
	     (go to end if nothing, back up if percent)
! f"e w -fwl			!* if word, back up and see if keyword !
				!* search for alpha/break or keyword/break !
:sendifforwhilebegintagcaseexceptprociterclusterdothenelseifelseotherstagwhen         !* get -1 for random, -2 for end, etc.
!   +(10,fka:"b99')+2f"g	!* if garbage before keyword, fudge count !
				!*   so it will think it was not a keyword !
     r 0u5 q2"e 0,2a"b0;' 1a-$*(1a-.):@; ''
				    !* not keyword -- continue after !
				    !*   checking for dollarsign or period !

      "#f"e w r q2"e -fwl 1' q2-1u2 "e -q2,q5f *0 ,q3f : u3w ' q2@; '
				    !* ending type, error if q2 was 0 !
               "#+9"l r q2"e -fwl 1' "e 1-q2,q5f *0 ,q3f : u3w ' 0u5'
				    !* intermediate type !
	       "# 0u5 r %2w "n q2,q3f u3w ' q2@; ''' !* beginning type !
		!<! @> '	    !* done, search again
!   +4F"g w 0u5 %2w "n q2,q3f u3w ' q2@; ' !* left paren !
					    !*   count it and exit if q2=0 !
 "#+3F"g w q2"e r 1' q2-1u2 -q2,q5f *0 ,q3f : u3w q2@; '
		           !* right paren -- count it and exit if q2=0 !
   "#"e w <:fb"\+1; c !'!> 0u5 q2@;'
		    !* double quote -- find matching one !
      "# !"! :fb'\+1"l c !"! s' ' 0u5 q2@;
		    !* single quote -- find matching one !

'''>
0

!& Count Back:! !S Count nesting backward.!
!* Stays on same line, leaves Q2 altered by nesting difference.
Exits immediately, returning 0, if pass anything and have Q2=0.
Returns -1 if finish line without passing anything with Q2=0.
Returns +1 if error: an attempt was made to decrease Q2 from 0 to -1
   or we are in a comment or string.

This clobbers Q2. !

0[1
!* search backward on this line for parens, quotes, percent, or alpha !
<0f : :fb([{)]}"'%f"e w -1 '
   "#+4F"g w q2"e c 1' q2-1u2 q2@; '
		     !* left paren -- count it and exit if q2=0 !
   "#+3F"g w %2@; '  !* right paren -- count it !
   "#F"e w <0f : :fb"; 10,0a-\:@; !'!> q2@;'
		    !* double quote -- find matching one !
      "#+1F"e w !"! 0f : :fb'+1(10,0a-\)"e !"! -:s'w ' q2@;'
		    !* single quote -- find matching one !
	 "#+2"g 1 '		    !* percent -- lost !
	 "# fwl	!* if word, go forward and see if keyword !
			!* search for break/alpha or break/keyword !
-:sendifforwhilebegintagcaseexceptprociterclusterdothenelseifelseotherstagwhen-(13,fk+1a:"b99')+17f"l
		!* see if whole symbol is keyword !
		!* if not, fudge count !
c q2"e 0,-1a"b0;' 0a-$*(0a-.):@; ''
		!* not keyword -- continue after !
		!*   checking for dollarsign or period !

	       "#-16f"e w c %2@; '		    !* ending type !
"#+10"g c q2"e fwl 1' q2-1u2 q2@; '
				    !* beginning type !
"# c q2"e fwl 1' ''
				    !* intermediate type !
'''''''>
0

!& Indent CLUline:! !S Fix Line Indentation.!
!* Does all the right things to comments and such.
Must be at end of indentation.
Requires I = Xindent, L = Count Line Nesting, Z = Indent Offset,
C = Comment Column, R = Comment Rounding.
Does not report any change to ^R, caller must do this.
Leaves point at end of line or just before comment.
If line is empty, sets indentation anyway.
Uses Q2 and Q3, acts as though it called & Count Line Nesting once,
so Q2 changes by nesting of line.  Q8 is desired indentation relative
to what Q3 would come back as.  Do not assume that Q3 actually has this
value on return, since it cheats if no real code on the line.!

[5
0,1a-%"n mL			    !* if real text, measure it !
   fs shposu5 z-.[6		    !* remember position of following comment,!
				    !*   if any, and how to get there !
   0l @f	_k q3*qZ+q8f"gmI'  !* Set indentation.!
   z-q6j -@f	_k	    !* Back to comment (or end), !
				    !*   kill whitespace.!
   0,1a-%"n  ''		    !* If no comment, done.!
				!* If there is a comment, will fix it later.!

   "# 0,2a-%"n 0k '		    !* Line starts with a comment.!
				    !* If single, kill whitespace,!
				    !*   will fix it later.!
   "# 0,3a-%"n 0k q2*qZ+q8f"gmI'w  '  ''
				    !* If double, indent to Q2, done.!
				    !* If triple, do nothing.!

		!* Process final comment, whitespace before is gone.!
		!* If single, go to comment column.!
		!* If more, go to Q5.!

fs shpos[H 0,2a-%"e qH-q5"l qH,q5mI '  '   !* double or triple !

qCu5				    !* Q5 will be where comment actually goes.!
    qH-q5:"l			    !* If code on line goes past !
				    !*   comment column, round it up.!
      qR"e qH+1u5'
      "# qH-q5R+q5 u5''	    !* Q5 is now correct place.!
      qH,q5mI 		    !* and insert the new.!

!& Setup CLU Library:! !S Put functions into MM ... vars for speed.!

-1 m.v CLU_*Handle*		    !* Make this global.!
 :i* ps:<subsys>tcmp.exe.0  m.c CLU_Compiler*_Name_of_Compiler
 1,m.m&_Count_Line_Nesting m.v MM_&_Count_Line_Nesting
 1,m.m&_Count_Back m.v MM_&_Count_Back
 1,m.m&_Indent_CLUline m.v MM_&_Indent_CLUline
 1,m.m^R_Forward_CLUexp m.v MM_^R_Forward_CLUexp
 1,m.m^R_Backward_CLUexp m.v MM_^R_Backward_CLUexp

   