!* -*-TECO-*-	This library implements EMACS BLISS MODE.
                It is a version of ECC's PL1 mode, modified
                by T.Hess [HESS@DEC]!

!~FILENAME~:! !Package for editing BLISS code (BLISS Mode).!
BLISS

!BLISS Mode:! !C Set up for editing BLISS code.
$BLSIND ..D$ is set up for use by BLISS indent macros. (E.g. no special
    Lisp characters, and "words" are $, _, and alphanumerics.
Calls user-providable macro, INIT BLISS MODE, which can put BLISS
    macros into desired qregs.  If no macro exits, calls
    & Default Init BLISS Mode.  See the description of that subr
    for more details on what it does and how to construct your own.!

 m(m.m_&_Init_Buffer_Locals)	    !* Discard locals of old mode, and set: *!
				    !* .Q: Make Local Q-Reg. *!
				    !* .0: old value of $Switch Mode Process *!
				    !* Options$ *!

				    !* Standard stuff to set up:  *!

 1,:i*!m.LComment_Startw	    !* Comment start... *!
 1,:i*!_m.LComment_Beginw	    !* begin... *!
 1,:I*_)%M.LImbedded_Comment_Endw
 1,:I*%(_M.LImbedded_Comment_Beginw
 1,m.m&_Indent_Without_Tabsm.LMM_&_Indentw	    !* Dont use tabs. *!
 1,m.m&_XIndent_Without_Tabsm.LMM_&_XIndentw	    !* ... *!
 1,40m.lComment_Columnw	    !* Set comment column. *!

				    !* Now either personal or standard init: *!
				    !* They can use .0, .Q. *!
 1:<m(m.mInit_BLISS_Mode)	    !* Call users init. *!
    >"N				    !* User has no init,  *!
	m(m.m&_Default_Init_BLISS_Mode)'  !* ...so use default one. *!

  m.vBLSIND_..Dw		    !* Create a var for our dispatch table. *!
 ^:IBLSIND_..D\________________________________________________________________________________________________________________________________________A_____________________________A____A____A___AA___AA____A____'____(____)____A____A_________A____A____/___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____A____;____A____A____A____A____A___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____A____A____A____A___AA____A___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA___AA____A____|____A____A________\  !* And setup the dispatch table. *!

 q.0,1M(M.M&_Set_Mode_Line)BLISS !* Set, display mode. *!
 

!^R Indent BLISS Stmt:! !^R Indentation via previous statement type.
If there are non-label tokens to left, then just calls
    ^R BLISS Indent Relative.
If non-null arg, calls ^R Indent Nested.
Calls macros to indent statements after prev stmt's type, e.g.
    looks for macro named & BLISS Indent After Begin Stmt.
None found, it will call & BLISS Indent After Stmt.
If the previous statement was unfinished (i.e. we are not indenting
    a new statement really), then macros such as & BLISS Indent Unfin If Stmt
    are called.
The default unfinished-stmt macro is & BLISS Indent Unfin Stmt.
^R Print Last BLISS Indenter will print the name of the indentation
    macro called.!
!* The name of the indentation macro called is left in $Last BLISS Indenter$.
 * All indent macros are passes two args:
 *     ARG1 points to where to indent (previous indentation has been
 *	    deleted).
 *     ARG2 points to the prev stmt's token, so that the macro can see
 *	    its indentation or whatever it wants.
 * Indent macros should return two values, bounding the buffer area changed.
 *!
 [.2[.3[.4[.5
 :i*m.vLast_BLISS_Indenterw	    !* Start null.  Generally, subrs *!
				    !* will put their own names in here. *!
 .m(m.m&_BLISS_Tokens_to_Leftp)"N !* Toks left => ^R BLISS Indent Relative. *!
	 f^m(m.m^R_BLISS_Indent_Relative) '
 ff"G				    !* ARG => goto ^R Indent Nested. *!

	 :iLast_BLISS_Indenter(^R_Indent_Nested)	    !* We must put *!
				    !* name in since macro is EMACS *!
				    !* and doesnt like us... *!
	 f^m(m.m^R_Indent_Nested) '

 .[.1				    !* .1: where indent. *!

 1m(m.m&_BLISS_End_Prev_Stmt)u.2  !* .2: end of prev statement. *!
 q.2j
 m(m.m&_BLISS_Next_Token)u.5u.3
				    !* .3: before token after prev stmt. *!
				    !* .5: after token... *!
 q.5-."L q.2j m(m.m&_BLISS_Next_Token)u.5u.3 '
				    !* Don't pass . *!
 q.3-q.1"L			    !* Prev stmt unfinished. *!
            q.3,q.5x.4		    !* .4: string of token. *!
            1:< q.1,q.3m(m.m&_BLISS_Indent_Unfin_.4_Stmt)u.3u.1
                >"N		    !* No indent macro found. *!
                    q.1,q.3m(m.m&_BLISS_Indent_Unfin_Stmt)u.3u.1  !* Default. *!
                    ''
        "#			    !* Prev stmt finished. *!
            .-b"N		    !* There is a prev stmt. *!
                1m(m.m&_BLISS_End_Prev_Stmt)u.2   !* Go back another stmt. *!
                q.2j
                m(m.m&_BLISS_Next_Token)u.5u.3 
				    !* Get token, which is *!
				    !* the token for the statement just *!
				    !* before where we want to indent. *!
		q.5-."L q.2j m(m.m&_BLISS_Next_Token)u.5u.3 '
				    !* Don't pass . *!
                q.3,q.5x.4'	    !* String of token. *!
              "#		    !* No prev stmt in buffer. *!
                bu.3bu.5 :i.4'
            1:< q.1,q.3m(m.m&_BLISS_Indent_After_.4_Stmt)u.3u.1 !* Try ind. *!
                 >"N		    !* No macro for indenting that. *!
                    q.1,q.3m(m.m&_BLISS_Indent_After_Stmt)u.3u.1 !* Default. *!
                    ''
 fsrgetty"n q.1,q.3 '	    !* .1,.3 bound buffer area changed. *!
 fsechodis Afsechodis
 0t 

!^R Insert BLISS End:! !^R Insert end and show matching block.
Indents if no whitespace to left of cursor.
Displays buffer around matching block statement.
    ARG = number of seconds to display there.
Inserts a comment after the "end;" to show what was ended, e.g.
    "%( begin-name )%"  or  "%( if-begin )%".
    The MARK is left before this comment, point after so you can easily
    delete it with ^R Kill Region.!
 0,0a-_"N 0,0a-	"N	    !* If no whitespace to left... *!
   ^m(m.m^R_Indent_BLISS_Stmt)f'' !* ...then indent... *!
 .,(iEND;).f			    !* ...and insert end. *!
 .:				    !* Leave MARK after end;. *!
 .[.1 fnq.1j			    !* .1: Auto-restoring point. *!
 4r .[.6			    !* .: Start before END. *!
 [.2 [.4[.5 0[.3		    !* .3: BEGIN level counter. *!

 <  b-."E FG 1'		    !* Go back statements until find *!
				    !* a matching BEGIN *!

    1m(m.m&_BLISS_End_Prev_Stmt)j    !* Back 1 semicolon... *!
    m(m.m&_BLISS_Next_Token)u.5u.4   !* ... and fwd to prev stmt token. *!
    q.4u.2			    !* .2: Save beginning of this stmt. *!

    q.4,q.5f~IF"E		    !* IF: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'
    q.4,q.5f~ELSE"E		    !* ELSE: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'
    q.4,q.5f~INCR"E		    !* INCR: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'
    q.4,q.5f~DECR"E		    !* DECR: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'
    q.4,q.5f~DO"E		    !* DO: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'
    q.4,q.5f~WHILE"E		    !* WHILE: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'
    q.4,q.5f~UNTIL"E		    !* UNTIL: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'
    q.4,q.5f~GLOBAL"E		    !* GLOBAL: check next token *!
        q.5+1m(m.m&_BLISS_Next_Token)u.5u.4    !* Might be ROUTINE *!
	q.4u.2'			    !* Pretend "GLOBAL" doesn't exist *!
    q.4,q.5f~ROUTINE"E		    !* ROUTINE: check first stmt after = *!
        q.5m(m.m&_BLISS_Skip_Decl)"E 1;'
	m(m.m&_BLISS_Next_Token)u.5u.4'
    q.4,q.5f~MODULE"E		    !* MODULE: check first stmt after = *!
        q.5m(m.m&_BLISS_Skip_Decl)"E 1;'
	m(m.m&_BLISS_Next_Token)u.5u.4'
    q.4,q.5f~MACRO"E		    !* MACRO: check first stmt after = *!
        q.5m(m.m&_BLISS_Skip_Decl)"E 1;'
	m(m.m&_BLISS_Next_Token)u.5u.4'

    q.4,q.5f~BEGIN"E q.3-1u.3'	    !* Dec level counter on BEGIN,  *!
    q.4,q.5f~END"E q.4-q.6"N %.3w''   !* Inc on END (finds ARG2 first). *!
    q.3-1:;			    !* Found match when level = 0. *!
    >
				    !* .4,.5: Bound BEGIN *!
 q.4,q.5x.4'			    !* .4 :=  BEGIN *!

 q.2j				    !* First token of statement containing *!
				    !* matching BEGIN *!
 fwx.5				    !* Now figure something for comment: *!
 5 f~MACRO"E			    !* MACRO *!
     .[.6 q.1j i_% .u.1 ].6j	    !* Change END; to END; % *!
     Onamit'
 6 f~MODULE"E Onamit'	    !* MODULE *!
 .m(m.m&_BLISS_Get_Statement_Label)u.3	    !* .3: 0 or label. *!
 q.3"E 7 f~ROUTINE"E Onamit'	    !* Unlabelled ROUTINE *!
       "# 5 f~BEGIN"N		    !* Unlabelled, if not BEGIN,  *!
	     fwx.3		    !* .3: token starting stmt (IF/...). *!
	     :i.3.3-.4'	    !* .3: IF-BEGIN, ELSE-... *!
	  "# fwx.3'''		    !* .3: BEGIN. *!
 Ocomend

!namit!				    !*  get next token. *!
  fw +.m(m.m&_BLISS_Next_Token)x.3 !* .3: token after ROUTINE/MACRO/MODULE *!
  :i.3.5_.3		    !* .3: "declaration"+nexttoken. *!
!comend!
 q.1j i_%(_.3_)%		    !* Comment the end statement. MARK is *!
				    !* before the comment from earlier. *!
 q.1-fku.1			    !* .1: Point after ; *!
 q.2j				    !* Back to match and... *!
 0 ^v				    !* ...Display there. *!
 *30:w			    !* Wait ARG seconds or til input. *!
 1 				    !* Exit, restore point. *!

!& BLISS Get Statement Label:! !S Return label for statement at ARG.
ARG: Point within statement.
Returns string containing label, or
Returns 0 if no label found.!
 .[.0 fnq.0j			    !* .0: Auto-restoring point. *!
 1m(m.m&_BLISS_End_Prev_Stmt)j    !* Move to end last stmt. *!
 1,.m(m.m&_BLISS_Next_Token)[.2[.1   !* .1,.2: Bound next token. *!
 q.2j 0,1a-:"N 0 '		    !* Return 0, no label found. *!
 q.1,q.2x* 			    !* Return label string. *!

!Indent BLISS Region:! !C Indents each line from here to MARK.
On each line it:
    moves past labels, comments to first token,
    then calls ^R Delete Horizontal Space,
    then calls ^R Indent BLISS Stmt.
Leaves mark and point around changed region, and old text in kill stack.!
 :[.1 .u.2 [.3[.4[.5
 q.1,q.2f u.2u.1		    !* Order point and mark. *!
 q.1j				    !* To beginning of region. *!
 1[9 q.1,q.2x.5			    !* Save text, set kill direction. *!
 q.1,q.2m(m.m&_Kill_Text)	    !* Kill region to save it on kill stack. *!
 g.5				    !* Get back region now to edit it. *!
 q.1j z-q.2u.2			    !* Reset .2 so doesnt change as edit. *!

 <  0l
    m(m.m&_BLISS_Next_Token)u.4u.3   !* Find next token. May be on another line *!
    q.3j			    !* Go to its left edge: first tok on its *!
				    !* line. *!
    z-.-q.2:;			    !* See if done. *!
    ^m(m.m^R_Delete_Horizontal_Space)w
    ^m(m.m^R_Indent_BLISS_Stmt)w	    !* Indent that line. *!
    l
    >

 q.1				    !* Set MARK at beginning of region. *!
 z-q.2j				    !* Set point at end. *!
 q.1,. 			    !* Display and exit. *!

!^R BLISS Indent Relative:! !^R BLISS Indent Relative to last line's words.
Successive calls get successive indentation points;  each call
    aligns under ARGth next word in previous line.
Words are separated by spaces, tabs, underscores, commas, periods.
To facilitate moving into a line, and changing an indentation, if
    there is whitespace to the right and left (i.e. this is a new
    indent call here), then the cursor is moved one column left.!
 qLast_BLISS_Indenter[.1
 :iLast_BLISS_Indenter.1(^R_BLISS_Indent_Relative)
 [1 ^:I1| qLast_BLISS_Indenteru.1   !* 1: Macro for weird tabbing. *!
	  :iLast_BLISS_Indenter.1(^R_Tab_to_Tab_Stop)  !* ... *!
	  :M(M.M^R_Tab_to_Tab_Stop)|	    !* ... *!
 0,1af_	+1"G		    !* If char to right is whitespace,  *!
    0,0af_	+1"G		    !* ...as is char to left,  *!
	fs hpos-1(		    !* ...then note column left,  *!
		   -d)m(m.m&_Indent)w	    !* ...and move there. *!
	''			    !* ... *!
 .[P FSHPOS[0			    !* P: orig point. 0: hpos. *!
 ^-f_	L		    !* Move left past whitespace. *!
 .[Q FSHPOS[2			    !* Q: point left of white. 2: hpos. *!
 0L<    B-."E QPJ :m1'		    !* No line for relative indenting *!
				    !* so just tab stop. *!
        -L1A-15."N0;'>		    !* Back to non-blank line. *!
 Q0"G1:<0,Q0+1:FM>"ER'		    !* Cursor to orig hpos. *!
		  "#0L1:<0,Q2+1:FM>"ER'	    !* ... *!
				   "#QPJ:M1'''	    !* ... *!

 < F :FB_.,	_"E:L'"#R'	    !* Find end of word. *!
     ^F_.,_	R	    !* Right to start next word. *!
     >				    !* Go to start of ARGth next word. *!

 FSHPOS(QQ,QPK			    !* Back to orig point, remove white left. *!
         ):M(M.M&_Indent)	    !* And indent to column found. *!

!^R Global BLISS Comment:! !^R Call ^R for large comment.
While in global comment ^R:
Comment column is set to 10,
^R Indent for Comment is called initially,
MM Auto Fill Mode$ is entered with auto-indent,
$Comment Begin$ is set to "%(*" to mark global comments.
"%(** )%" (comment with just a *) expand into %( * * *... )%,
    aligned with any surrounding global comments (for boxes),
    or if no surrounding comments expand into $BLISS Star Line Width$ wide
    (default is 51).
When ^R returns, comment-ends within each global comment will be
    vertically aligned.!
 0fo..qGlob_of_Comments_Flag"N	    !* Already in Global Comment. *!
    f:^m(m.m^R_Indent_for_Comment)'	    !* So just do M-;. *!
 1m.vGlob_of_Comments_Flagw	    !* Signal now in glob mode. *!
 fn0m.vGlob_of_Comments_Flagw   !* When leave, signal not in mode. *!
 [.1[.2
 m.m^R_End_Comment[..\	    !* Redefine M-\ temporarily *!
 :i*Global_Comment[..j
 10[Comment_Column
 :i*%(*[Comment_Start	    !* So mark each global comment *!
				    !* for later comment-end aligning. *!
 :i*_)%[Comment_End		    !* For ^R Comment end *!
 :i*%(*[Comment_Begin	    !* For comment continuation *!

 1[Space_Indent_Flag
 fs qp ptr[Q			    !* Q: Pop to here to restore fill mode. *!
  [Auto_Fill_Mode		    !* Save whether auto-filling now. *!
  m(m.m_Auto_Fill_Mode)	    !* Into auto fill mode. *!
  :l gComment_Start		    !* Put in comment starter... *!
  1m(m.m^R_Indent_for_Comment)	    !* ... and then align it. *!
  .-z"L -l' :l			    !* Position at end of started comment. *!
   w				    !* Enter ^R mode for globals. *!
  0l				    !* Always be at line beginning. *!
				    !* so that HPOS works in virtl bufs. *!
  :fb%(*"L			    !* If we are in a global comment,  *!
     < l :fb%(*"E 1;' >'	    !* ...then go to line after comments. *!
  fs z-.f[ vzw		    !* Bounds around buffer before point. *!
  m(m.m&_Align_Global_BLISS_Comment_Ends)   !* Align those before point. *!
  zj f] vzw			    !* Restore bounds. *!
  .f[ vbw			    !* Bounds around buffer after point. *!
  m(m.m&_Align_Global_BLISS_Comment_Ends)   !* Align those after point. *!
  bj f] vbw			    !* Restore bounds. *!
  qQ fs qp unwindw		    !* Pop down and restore auto-fill. *!
 m(m.m&_Process_Options)	    !* Auto-fill may change. *!
 m(m.m&_Set_Mode_Line)		    !* ... *!
 

!& Align Global BLISS Comment Ends:! !S Ends within contiguous global comments.
Contiguous global comments are comments starting with "%(*", on
    successive lines.
Contiguous global comments have their comment-ends aligned vertically.
If a global comment consists soley of "*", i.e. it is "%(** )%",
    then it will expand out into a "%( * * * * ...* )%" comment, aligned
    with its contiguous global comments.  If no contiguous comments,
    expands out into %( * *...)%, $BLISS Star Line Width$ wide, default 51,
    and extending to left margin.
After alignment, "%(*" is replaced by "%( ".!
 [.1[.2[.3
 bj				    !* Go thru whole buffer. *!
 < :s%(*; fkc			    !* Find next contig global comment. *!
   0u.1				    !* .1: Max width of gc within cgc. *!
   0u.2				    !* .2: %(* )% found flag. *!
   0u.3				    !* .3: Count of gcs in this cgc. *!
   .( < :fb%(*;		    !* Next gc start in this cgc. *!
	%.3w			    !* .3: Inc gc count. *!
	.-1f_		    !* Replace with regular comment start. *!
	4 f=*_)%"E 1u.2'	    !* .2: Found a %(** )% in this cgc. *!
	:fb)%;			    !* Find next gc end in this cgc. *!
	fs hpos,q.1 f  u.1 w	    !* .1: Max width of gc. *!
	l >			    !* Next line, maybe end of cgc. *!
      fs z-.f[ vzw		    !* Set virtual buffer to end with cgc. *!
      )j			    !* Back to start of cgc. *!
   q.3-1"E			    !* If just one gc in cgc,  *!
      q.2"N			    !* ...and if was %(** )%,  *!
	-^f_	b k	    !* ...then kill indentation,  *!
	51fo..qBLISS_Star_Line_Widthu.1''    !* ...and set width of star line. *!
   q.1-2u.1			    !* .1: HPOS to put %( at. *!
   q.2"N			    !* If have a %( * * *...)% in * cgc,  *!
      (q.1-qComment_Column-3&1)+q.1u.1'   !* .1: round up if need to, to *!
				    !* make the * * )% come out evenly. *!
   < :s)%;			    !* Next gc end. *!
     -7 f=%(_*_)%"E		    !* If comment was just a *, expand  *!
	 2r			    !* ...into * * * * ... *!
	 q.1-(fs hpos)/2 <i*_>    !* ... *!
	 2c '			    !* ... (to match 2r next). *!
     2r q.1m(m.m&_Indent) f	    !* Indent the comment end, tell ^R. *!
     l >			    !* Next line, continue. *!
   zj f] vzw			    !* Restore boundaries. *!
   >				    !* Continue with next cgc. *!
 				    !* Done aligning. *!

!^R End Global BLISS Comment:! !^R Exit large comment ^R.
Calls ^R End Comment, then exits ^R, so that global comment ^R
    is ended, and comment column will be reset to its old (one-line
    comment form) value.
If given an ARG, will inhibit alignment of global comment-ends, by
    replace all global comment-starts ("%(*") by regular comment-starts
    ("%( ").!
 ^m(m.m^R_End_Comment) f
 ff"G			    !* Given an ARG. *!
    .( bj			    !* ...so replace all %(*,  *!
       < :s%(*; .-1f_>	    !* ...with %( . *!
       )j'			    !* ...and return to original point. *!
 fs ^R_Exit  		    !* Exit this global com mode ^R. *!

!^R Slurp BLISS to Char:! !^R Prev line back to CHAR moved to point, indented.
Non-comment text from previous line (back to CHAR typed) is moved
    onto the current line, after indentation, and then ^R Indent
    BLISS Stmt is called to re-align.  Now that the prev line is
    changed, things might look better.
Any comment on prev line is left there, and ^R Indent for Comment is
    called on it to align it after the text is removed from before it.!
 [.1[.2[.3[.4[.5[.6
 m.i fiu.5			    !* .5: Get char to slurp to. *!
 z-.u.1				    !* .1: Original point. *!
 0l ^f_	 r		    !* Line begin, past indentation. *!
 z-.u.6				    !* .6: Where to put slurped stuff. *!
 0:l z-.u.3			    !* .3: Prev lines end. *!
 .m(m.m&_Back_Over_BLISS_Line_Comment)j   !* Before any comment & white. *!
 .u.2				    !* .2: Point before any comment. *!
 < .,(0l).:fb.5; >	    !* Search back ARG chars on this line. *!
 .,q.2f( fx.4 ) f		    !* .4: Slurped chars. *!
 z-.-q.3"N			    !* If was a comment, reindent it. *!
    ^m(m.m^R_Indent_for_Comment) f'	    !* ... *!
 z-q.6j				    !* Back to where to put text. *!
 .,(g.4 i ). f		    !* Get the slurped text. *!
 0l				    !* Back before text. *!
 ^m(m.m^R_Indent_BLISS_Stmt) f   !* Now reindent slurped text line. *!
 z-q.1j w 1 			    !* Exit, with orig point restored. *!

!^R Print Last BLISS Indenter:! !^R Print macro name in echo area.!
 qLast_BLISS_Indenter[.0	    !* Put name in more usable qreg. *!
 fs echo displayw		    !* Clear the... *!
 Cfs echo displayw		    !* ... echo area. *!
 ^ft.0			    !* Print name. *!
 0fs echo activew
 				    !* Exit. *!

!& BLISS Indent After Stmt:! !S Default after-indent, same as prev stmt.
If no prev stmt (i.e. 1st stmt in buffer), then indentation is
given by the variable $1st Stmt Indentation$, default = 10.
ARG1 -> where to indent.
ARG2 -> token for previous statement.
Returns two vals surrounding insertion.
Leaves pointer after indentation.!
 qLast_BLISS_Indenter[.1
 :iLast_BLISS_Indenter.1(&_BLISS_Indent_After_Stmt)
 u.1				    !* Where to indent. *!
 [.2				    !* Pointer to prev stmt token. *!
 [.3				    !* Indentation amount. *!

 q.2-b"E			    !* This is 1st statement, no prev. *!
    4u.3			    !* Indentation amount, default. *!
    1:<q1st_Stmt_Indentationu.3>' !* See if user provides an amount. *!
  "#				    !* There is a previous stmt. *!
    q.2j fs hposu.3'		    !* See how much prev stmt indented. *!

 q.1j				    !* Go to where indent. *!
 q.3-(fshpos)-1"L ^m(m.m^R_BLISS_Indent_Relative) '   !* If past where indent *!
				    !* to then call indent relative. *!
 q.3m(m.m&_Indent) 		    !* Indent and return ptrs around. *!

!& BLISS Indent After Compound:! !S Handle indentation for stmt after IF etc.
Compound stmts are IF-, ELSE-, INCR-, WHILE-, ...
ARG1 -> where to indent.
ARG2 -> token for previous statement.
Returns two vals surrounding insertion.
Leaves pointer after indentation.
If (e.g.) IF ... BEGIN, then indent aligns with BEGIN, +
    $COMP BLOCK Indentation$, i.e. $...$ over from BLOCK.
    (Default $COMP BLOCK$ is 0.)
If non-BLOCK, aligns with IF.!
 qLast_BLISS_Indenter[.1
 :iLast_BLISS_Indenter.1(&_BLISS_Indent_After_Compound)
 u.1				    !* Where to indent. *!
 [.2				    !* Pointer to prev stmt token. *!
 1:<qCOMP_BLOCK_Indentationu.3>"N	    !* Get $...$ or make. *!
        0m.vCOMP_BLOCK_Indentationu.3'   !* Default is 0. *!

 q.2j fs hpos[.6		    !* .6 has (default) indentation. *!
				    !* e.g. indentation of non-BEGIN IF. *!

				    !* Check for IF-BEGIN, IF-UNTIL, etc. *!
				    !* and align with BEGIN or UNTIL:  *!

 q.2m(m.m&_BLISS_Last_Sub-Stmt_Token)[.5[.4  !* .4,.5 around final token. *!
 q.4,q.5f~BEGIN"E q.4j fs hpos+q.3u.6'    !* IF ... BEGIN. *!
 q.4,q.5f~DO"E q.4j fs hpos+q.3u.6'	    !* IF ... DO. *!
 q.4,q.5f~UNTIL"E q.4j fs hpos+q.3u.6'    !* IF ... UNTIL. *!
 q.4,q.5f~WHILE"E q.4j fs hpos+q.3u.6'    !* IF ... WHILE. *!
 q.4,q.5f~INCR"E q.4j fs hpos+q.3u.6'	    !* IF ... INCR. *!
 q.4,q.5f~DECR"E q.4j fs hpos+q.3u.6'	    !* IF ... DECR. *!

 q.1j				    !* Go to where indent. *!
 q.6-(fshpos)-1"L ^m(m.m^R_BLISS_Indent_Relative) '	    !* If past where indent *!
				    !* to then call indent relative. *!
 q.6m(m.m&_Indent) 		    !* Indent and return ptrs around. *!

!& BLISS Indent Unfin Begin Stmt:! !S Indent after BEGIN.
ARG1: where to indent.
ARG2: BEGIN token.!
 ,m(m.m&_BLISS_Indent_After_New_Block)  

!& BLISS Indent After New Block:! !S Next statement indented more, for BEGIN etc.
ARG1 -> where to indent.
ARG2 -> BEGIN token.
2 Vals returned, around indentation.
Pointer left after indentation.
Indentation aligns with whatever follows the BEGIN, etc.!
 qLast_BLISS_Indenter[.1
 :iLast_BLISS_Indenter.1(&_BLISS_Indent_After_New_Block)
 u.1 [.2
 q.2j				    !* Start of Begin token. *!
 fs hpos+4[.3			    !* Record this column. *!
 q.1j
 q.3-(fshpos)-1"L ^m(m.m^R_BLISS_Indent_Relative) '   !* If past where indent *!
				    !* to then call indent relative. *!
 q.3m(m.m&_Indent) 		    !* Indent and return ptrs around. *!

!& BLISS Indent After Routine Stmt:! !S Indent $1st Routine Stmt Indentation$ amount.
If no $...$ then default 0.
ARG1 -> where to indent.
ARG2 -> ROUTINE token.
Returns two vals around indentation.
Leaves pointer after indentation.!
 [.1 [.2 [.3
 qLast_BLISS_Indenter[.4
 :iLast_BLISS_Indenter.4(&_BLISS_Indent_After_Routine_Stmt)
 0fo..q1st_Routine_Stmt_Indentationu.3	    !* Indentation amount. *!
 q.1j				    !* Where to indent. *!
 q.3-(fshpos)-1"L .,. '	    !* If past where indent do nothing. *!
 q.3m(m.m&_Indent) 		    !* Indent and return ptrs around. *!

!& BLISS Indent After End Stmt:! !S Insert indentation by matching BEGIN/ROUTINE
ARG1 -> where to indent.
ARG2 -> END token.
Returns 2 vals around indentation.
Returns with pointer after indentation.!
 qLast_BLISS_Indenter[.1
 :iLast_BLISS_Indenter.1(&_BLISS_Indent_After_End_Stmt)
 u.1 [.2 [.4[.5
 0[.3				    !* BEGIN/ROUTINE level counter. *!
 q.2j				    !* Start from END token. *!

!Put in sometime search for matching label subr... *!

 <  b-.;			    !* Go back statements until find *!
				    !* a matching BEGIN *!

    1m(m.m&_BLISS_End_Prev_Stmt)j    !* Back 1 semicolon... *!
    m(m.m&_BLISS_Next_Token)u.5u.4   !* ... and fwd to prev stmt token. *!
    q.4u.2			    !* Save beginning of this stmt. *!

    q.4,q.5f~IF"E		    !* IF: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'
    q.4,q.5f~ELSE"E		    !* ELSE: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'
    q.4,q.5f~INCR"E		    !* INCR: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'
    q.4,q.5f~DECR"E		    !* DECR: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'
    q.4,q.5f~DO"E		    !* DO: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'
    q.4,q.5f~WHILE"E		    !* WHILE: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'
    q.4,q.5f~UNTIL"E		    !* UNTIL: check last sub-stmt. *!
        q.4m(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4'

    q.4,q.5f~BEGIN"E q.3-1u.3'	    !*   or BEGIN,  *!
    q.4,q.5f~END"E %.3w'	    !* Inc on END (finds ARG2 first). *!
    q.3-1:;			    !* Found match when level = 0. *!
    >

 q.2j				    !* First token of statement containing *!
				    !* matching BEGIN *!
 fs hpos[.3			    !* Save match's indentation. *!
 q.1j
 q.3-(fshpos)-1"L ^m(m.m^R_BLISS_Indent_Relative) '	    !* If past where indent *!
				    !* to then call indent relative. *!
 q.3m(m.m&_Indent) 		    !* Indent and return ptrs around. *!

!& BLISS Indent Unfin Stmt:! !S Indent new line of unfinished statement.
Default for indenting unfinished statements. Does:
Case1: If there is an open paren, aligns with next non-white.
Case2: If $Unfin Stmt Indentation$ is defined it will indent
       $Unfin Stmt Indentation$ more than the start of the stmt.
Case3: If prev line contains start of stmt, aligns with 1st word after
       beginning of stmt token (which may be part of token).
Case4: Calls ^R BLISS Indent Relative.
ARG1 -> where to indent.
ARG2 -> token starting unfinished statement.
Returns 2 vals around indentation.
Point left after indentation.!
 qLast_BLISS_Indenter[.1
 :iLast_BLISS_Indenter.1(&_BLISS_Indent_Unfin_Stmt)
 u.1				    !* Where to indent. *!
 [.2				    !* Pointer to prev stmt token. *!
 [.4				    !* Extra indentation amount. *!
 [.3[.5
 1:<    fo..qUnfin_Stmt_Indentationu.4	    !* Get $...$ if defined. *!
        q.2j fs hposu.3	    !* How much prev stmt indented. *!
        q.3+q.4u.5		    !* Set column to indent to by $...$. *!

        >"N			    !* Not defined. *!
            q.1j -l		    !* To line before current. *!
	    q.2-."g		    !* Line has stmt token. *!
                   5*.,5*.+1:g..d[.6    !* Save . dispatch. *!
		   5*.:f..d     !* Change it to be break char. *!
                   2:fwl fshposu.5 !* Align with next word. *!
		   5*.:f..d.6 '    !* Change back. *!
		 "#		    !* Line doesnt have stmt token. *!
		   0u.5''	    !* Force call to indent rel. *!

 q.1j				    !* Go to where indent. *!
 1:<    -:ful			    !* See if any open parens. *!
        ^f_	jw		    !* Yes, go past white-space. *!
        fs hposu.5		    !* Will indent to this column. *!
        >
 q.1j				    !* Where indent *!
 q.5-(fshpos)-1"L ^m(m.m^R_BLISS_Indent_Relative) '	    !* If past where indent *!
				    !* to then call indent relative. *!
 q.5m(m.m&_Indent) 		    !* Indent and return ptrs around. *!

!& BLISS Indent Unfin If Stmt:! !S Indent new line of unfinished IF statement.
Indents same amount as the IF if the THEN hasn't occured yet.
If THEN has occured, just calls & BLISS Indent Unfin Stmt.
ARG1 -> where to indent.
ARG2 -> token starting unfinished statement.
Returns 2 vals around indentation.
Point left after indentation.!
 qLast_BLISS_Indenter[.1
 :iLast_BLISS_Indenter.1(&_BLISS_Indent_Unfin_If_Stmt)
 u.1				    !* Where to indent. *!
 [.2				    !* Pointer to prev stmt token. *!
 fsqpptr[.0			    !* .0: Unwind to here to restore vbuf. *!
 fsz-q.1f[vzw			    !* VBuf ends at point so dont consider *!
				    !* any statements after this unfin one. *!
 q.2j
 .,zm(m.m&_BLISS_Token_Search)THEN"N	    !* Point after last THEN. *!
    .,1m(m.m&_BLISS_Token_Search)IF"E	    !* No following IF, so  *!
       q.0 fs qp unwindw	    !* Restore vbuf. *!
       q.1,q.2m(m.m&_BLISS_Indent_Unfin_Stmt) '    !* treat as random. *!
       2r'			    !* Before IF under which to indent. *!
 q.0 fs qp unwindw		    !* Restore vbuf. *!
 fs hpos[.3			    !* See how much IF was indented. *!
 q.1j				    !* Go to where indent. *!
 q.3-(fshpos)-1"L		    !* Past where indent to,  *!
    ^m(m.m^R_BLISS_Indent_Relative) '	    !* so call indent relative. *!
 q.3m(m.m&_Indent) 		    !* Indent and return ptrs around. *!

!& BLISS Indent Unfin Comp:! !S Indent new line of unfinished compound.
Indents same amount as the last sub-statement so far.
ARG1 -> where to indent.
ARG2 -> token starting unfinished statement.
Returns 2 vals around indentation.
Point left after indentation.!
 qLast_BLISS_Indenter[.1
 :iLast_BLISS_Indenter.1(&_BLISS_Indent_Unfin_Comp)
 u.1				    !* Where to indent. *!
 [.2				    !* Pointer to prev stmt token. *!
 [.4[.5
 q.2,q.1f[hboundw		    !* Virtual buf around this unfin stmt. *!
 bm(m.m&_BLISS_Last_Sub-Stmt_Token)u.5u.4    !* Find last sub-stmt token. *!
 q.4j				    !* Go there. *!
 f]hboundw			    !* Restore original buf boundaries. *!
 q.4,q.5f~IF"E Ocfound'	    !* IF compound *!
 q.4,q.5f~INCR"E Ocfound'	    !* INCR compound *!
 q.4,q.5f~DECR"E Ocfound'	    !* DECR compound *!
 q.4,q.5f~DO"E Ocfound'	    !* DO compound *!
 q.4,q.5f~UNTIL"E Ocfound'	    !* UNTIL compound *!
 q.4,q.5f~WHILE"E Ocfound'	    !* WHILE compound *!

 q.1,q.4m(m.m&_BLISS_Indent_Unfin_Stmt)  !* No compound - use default *!

!cfound!
 q.4j fs hpos[.3		    !* See how much compound was indented. *!
 q.1j				    !* Go to where indent. *!
 q.3-(fshpos)-1"L ^m(m.m^R_BLISS_Indent_Relative) '
				    !* If past where indent to *!
				    !* Then call indent relative. *!
 q.3m(m.m&_Indent) 		    !* Indent and return ptrs around. *!

!& BLISS Next Non-Begin Token:! !C Returns next token which isn't BEGIN.!
 [.1[.2
 m(m.m&_BLISS_Next_Token)u.2u.1
 !BEGLP!			    !* pass over Begins *!
 q.1,q.2F~BEGIN"E m(m.m&_BLISS_Next_Token)u.2u.1 q.2j oBEGLP '
 q.1,q.2 

!& BLISS Next Token:! !S Return ptrs around next token in buffer.
ARG gives place to start from in buffer.
    No ARG means here.
ARG,: Labels are skipped unless pre-comma argument given.
Comments are skipped.!
 .[.1				    !* Save point while search. *!
 [.2[.3				    !* .3,.2 will bound token. *!
 qBLSIND_..D[..D		    !* Use BLISS break-chars. *!
 ff"G j'			    !* Position at ARG1 if any. *!

 z-b"E q.1j z,z '		    !* Empty buffer, no token. *!

 <				    !* Loop over comments, maybe labels. *!
				    !* Search for end of token or beginning *!
				    !* of comment:  *!
    :s%(!"E		    !* Search for token end. *!
        zj 0a"B q.1j z,z '	    !* No tokens found. *!
	.u.2			    !* .2: End of buf is end of token. *!
	-fwl .u.3 1;'		    !* .3: Mark beginning of token. *!
    0a-!"E 1@l !<!>'		    !* Skip to next line for comment *!
    -1a-%"E :s)%"E zu.3zu.2 1;' ' !* Skip imbedded comment. *!
    "#   .-1u.2			    !* .2: Possible end of token. *!
	 (ff&2)1a-:"N	    !* If pre-comma (i.e. accept labels) *!
				    !* or if not a label,  *!
	    q.2j-fwl .u.3 1;'	    !* .3: then have token. *!
	 '			    !* Skip past a label. *!
    >

 q.1j				    !* Restore point. *!
 q.3,q.2 			    !* Return bounds of token. *!
				    !* z,z if none found. *!

!& BLISS Skip Decl:! !S Searches for = , but not within parens.
Comments are skiped.
ARG1 is point in buffer to start from.
Returns 0 if search unsuccessful: end of statement (;) or end of buffer
 reached first, non-0 if successful.!
 0[.1 .[.2 j 0[.3		    !* .3 is return val. Init notfound. *!

 <
   :s=%(;!()"E 1;'	    !* Found nothing. *!
   0a-;"E 1;'		    !* End of statement found first. *!
   0a-!"E 1@l '		    !* Skip to next line for comment *!
   -1a-%"E :s)%"E 1;''	    !* Skip imbedded comments *!
   0a-("E %.1'		    !* .1: Paren depth *!
   0a-)"E q.1-1u.1'		    !* .1: Decr depth counter on ) *!
   0a-="E q.1"E 1u.3 1;''	    !* Found =  *!
  >
 q.3"E  q.2j '			    !* If unsuccessful, dont move. *!
 q.3 				    !* Return 0 lost, 1 won. *!

!& BLISS Token Search:! !S Searches for a token in a statement.
Comments are skipped.
ARG1 is point in buffer to start from.
ARG2 is iteration: i.e. search for ARG2th token.
STRINGARG is token to search for.
Returns 0 if search unsuccessful: end of statement (;) or end of buffer
    reached first, non-0 if successful.
Returns with pointer after token if successful.!
 :i*[.1 .[.2 j 0[.3	    !* .3 is return val. Init notfound. *!
 qBLSIND_..D[..D		    !* Use dispatch table for BLISS. *!

 f<!DONE!
      <				    !* For skipping comments. *!
        :s.1%(;!"E f;DONE'  !* Found nothing. *!
        fk+fq.1+2"E r 1u.3 1;'	    !* .3: Found token. *!
        0a-;"E f;DONE'	    !* End of statement found first. *!
	0a-!"E 1@l !<!>'	    !* Skip to next line for comment *!
        -1a-%"E :s)%"E f;DONE'  !* Skip imbedded comments, but allow *!
		 r 1u.3'	    !* .3: paren to end token. *!
        >>

 q.3"E  q.2j '			    !* If unsuccessful, dont move. *!
 q.3 				    !* Return 0 lost, 1 won. *!

!& BLISS Tokens to Leftp:! !S Returns 0 if no tokens to left on line.
ARG is pointer into line where to look left from.
Labels or comments are not counted.!
 [.1 .[.2 [.3[.4
 q.1j 0l			    !* To beginning of line. *!
 m(m.m&_BLISS_Next_Token)u.4u.3   !* Find next token after that. *!
 q.2j				    !* Back to original point. *!
 q.3-q.1"L 1 '		    !* Token is to left. *!
	"# 0 '		    !* Token is not to left. *!

!& BLISS Last Sub-Stmt Token:! !S Finds last stmt in compound stmt (if, on).
If current statement is "IF a THEN IF b THEN c;" this subr will return
    ptrs surrounding c's statement token.
ARG1 points to statement token from where to start, i.e. the compound
    statement's token (IF).
    If ARG1 points to a non-compound statement token, pointers around
    that token are returned.!
 [.1 .[.2 [.3[.4
 q.1j				    !* Position at starting stmt token. *!

 f<!Found!			    !* Find last sub-stmt token. *!
  1f<!Next!			    !* Check if compound statement. *!
     .m(m.m&_BLISS_Next_Token)u.4u.3
     q.3j			    !* Position at next token. *!

     fwf~IF"E			    !* IF-compound statement. *!
        .,1m(m.m&_BLISS_Token_Search)THEN"E f;Found'	 !* No THEN clause. *!

				    !* & BLISS Token Search skips comments *!
				    !* Returns 0 if ; or z reached first. *!
        1;'			    !* Again check if compound *!

     fwf~DO"E			    !* DO-compound statement. *!
        .,1m(m.m&_BLISS_Token_Search)WHILEUNTIL"E f;Found'
	1;'			    !* Again check if compound *!
     fwf~INCR"E		    !* INCR-compound statement. *!
        .,1m(m.m&_BLISS_Token_Search)DO"E f;Found'
	1;'			    !* Again check if compound *!
     fwf~DECR"E		    !* DECR-compound statement. *!
        .,1m(m.m&_BLISS_Token_Search)DO"E f;Found'
	1;'			    !* Again check if compound *!
     fwf~WHILE"E		    !* WHILE-compound statement. *!
        .,1m(m.m&_BLISS_Token_Search)DO"E f;Found'
	1;'			    !* Again check if compound *!
     fwf~UNTIL"E		    !* UNTIL-compound statement. *!
        .,1m(m.m&_BLISS_Token_Search)DO"E f;Found'
	1;'			    !* Again check if compound *!

     fwf~ELSE"E		    !* ELSE-compound statement. *!
        .+4m(m.m&_BLISS_Next_Token)u.4u.3 q.3j    !* Position after ELSE ... *!
        1;'			    !*    and again check if compound. *!

     f;Found			    !* Non-compound statement found. *!
     >				    !* End next. *!
    >				    !* End found. *!

 q.3,q.4(q.2j) 		    !* Return ptrs around token. *!

!& BLISS End Prev Stmt:! !S Return ptr to end prev ARG'th statement.
Value returned points to the semicolon.
ARG = 1 means find first end-; looking back from here.!
 .[.1				    !* Save point while search. *!

 <				    !* Look back ARG statements. *!
      <				    !* Look back one statement. *!
         -:s;)%!"E bj 1; '	    !* No previous statement. *!
                  "# 1a-!"E !<!>' !* Skip past comment *!
		     1a-;"E 1;'   !* Find end of prev stmt. *!
                     -:s%('	    !* Skip past imbedded comments. *!
         >			    !* Point at end of prev stmt. *!
     >

 .(q.1j) 			    !* Return semicolon-ptr and restore *!
				    !* point. *!

!& Back Over BLISS Line Comment:! !S From point, move left on line past comment.
ARG is ptr into some line to check left from.
Returns ptr to before comment and white-space before it.
If no comment on line, no movement: ARG is returned.!
 .[.1 j
 .,(0l).:fb%(!"E  '	    !* No comment found on line. *!
 -^fq_	[.2j		    !* Move before any white space. *!
 .(q.1j) 			    !* Return that place, reset point. *!

!& Setup BLISS Library:! !S Put macros into $MM ...$ qregs for speed.!
 m.m&_BLISS_End_Prev_Stmtm.vMM_&_BLISS_End_Prev_Stmtw
 m.m&_BLISS_Next_Tokenm.vMM_&_BLISS_Next_Tokenw
 m.m&_BLISS_Indent_After_Stmtm.vMM_&_BLISS_Indent_After_Stmtw
 m.m&_BLISS_Indent_After_New_Blockm.vMM_&_BLISS_Indent_After_Begin_Stmtw
 m.m&_BLISS_Indent_After_Endm.vMM_&_BLISS_Indent_After_End_Stmtw
 m.m&_BLISS_Indent_Unfin_Stmtm.vMM_&_BLISS_Indent_Unfin_Stmtw
 m.m&_BLISS_Indent_Unfin_If_Stmtm.vMM_&_BLISS_Indent_Unfin_If_Stmtw
 m.m&_BLISS_Indent_Unfin_Compm.vMM_&_BLISS_Indent_Unfin_Else_Stmtw
 m.m&_BLISS_Indent_Unfin_Compm.vMM_&_BLISS_Indent_Unfin_Do_Stmtw
 m.m&_BLISS_Indent_Unfin_Compm.vMM_&_BLISS_Indent_Unfin_Incr_Stmtw
 m.m&_BLISS_Indent_Unfin_Compm.vMM_&_BLISS_Indent_Unfin_Decr_Stmtw
 m.m&_BLISS_Indent_Unfin_Compm.vMM_&_BLISS_Indent_Unfin_While_Stmtw
 m.m&_BLISS_Indent_Unfin_Compm.vMM_&_BLISS_Indent_Unfin_Until_Stmtw
 m.m&_BLISS_Last_Sub-Stmt_Tokenm.vMM_&_BLISS_Last_Sub-Stmt_Tokenw
 m.m&_BLISS_Indent_After_Compoundm.vMM_&_BLISS_Indent_After_If_Stmtw
 m.m&_BLISS_Indent_After_Compoundm.vMM_&_BLISS_Indent_After_Else_Stmtw
 m.m&_BLISS_Indent_After_Compoundm.vMM_&_BLISS_Indent_After_Do_Stmtw
 m.m&_BLISS_Indent_After_Compoundm.vMM_&_BLISS_Indent_After_Incr_Stmtw
 m.m&_BLISS_Indent_After_Compoundm.vMM_&_BLISS_Indent_After_Decr_Stmtw
 m.m&_BLISS_Indent_After_Compoundm.vMM_&_BLISS_Indent_After_While_Stmtw
 m.m&_BLISS_Indent_After_Compoundm.vMM_&_BLISS_Indent_After_Until_Stmtw

 m.m&_BLISS_Token_Searchm.vMM_&_BLISS_Token_Searchw
 m.m&_BLISS_Indent_After_Routine_Stmtm.vMM_&_BLISS_Indent_After_Routine_Stmtw
 

!& Default Init BLISS Mode:! !S Default setup for BLISS mode.
It sets up the following characters for this mode and buffer:
    RUBOUT	Tab-hacking rubout,
    C-RUBOUT    Normal rubout,
    TAB 	^R Indent BLISS Stmt,
    C-M-?	^R Print Last BLISS Indenter,
    M-; 	^R Indent for Comment,
    M-\ 	^R Insert BLISS End,
    C-M-;	^R Global BLISS Comment,
    C-M-\	^R End Global BLISS Comment,
    M-{ 	^R Slurp BLISS To Char.
Turns on Auto Fill if $BLISS Auto Fill Default$ is non-0.
Users who want to provide their own MM Init BLISS Mode$ can make ^R keys
    (q-registers) and variables local to this mode and buffer by using the
    following subroutine which is global to Init BLISS Mode:
    .Q: Make Local Q-register!

				    !* Set up local ^R keys: *!

 1,q(1,q. m.Qw)m.Q.	    !* Exchange rubout flavors. *!
 1,m.m^R_Indent_BLISS_Stmtm.QI  !* Use Bliss-indenting tab. *!
 1,m.m^R_Print_Last_BLISS_Indenterm.Q...? !* C-M-? For tracing. *!
 1,m.m^R_Indent_for_Commentm.Q..;
 1,m.m^R_Insert_BLISS_Endm.Q..\
 1,m.m^R_Global_BLISS_Commentm.Q...;
 1,m.m^R_End_Global_BLISS_Commentm.Q...\
 1,m.m^R_Slurp_BLISS_To_Charm.Q..{

 0fo..qBLISS_Auto_Fill_Default(   !* Default is to auto-fill,  *!
   )m(m.m_Auto_Fill_Mode)	    !* ...will cause unfin indenting. *!
 1,1m.LSpace_Indent_Flagw	    !* ... *!
 				    !* Done. *!

!* Following should be kept as long comments:
 * Local Modes:
 * Fill Column:76
 * Comment End: *!
!*
 * End:
 * *!
