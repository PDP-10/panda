!* -*-teco-*-	This library implements EMACS PL1 MODE.  The source
		resides in MC:ECC;PL1LIB >, compiled version in
		EMACS;PL1 :EJ on all machines.  Note that the
		source assumes the use of EMACS;IVORY, not EMACS;PURIFY.!

!* Initially designed by Charles R. Davis and Eugene C. Ciccarelli, in the
 * fall of 1977 (I think), and implemented by the latter (ECC).!


!~FILENAME~:! !Package for editing PL1 code (PL1 MODE).!
PL1

!PL1 Mode:! !C Set up for editing PL1 code.
"/* " and " */" become comment delimiters.
$PL1IND ..D$ is set up for use by PL1 indent macros. (E.g. no special
    Lisp characters, and _ is not a break.)
Calls user-providable macro, INIT PL1 MODE, which can put pl1
    macros into desired qregs.  If no macro exits, calls
    & Default Init PL1 Mode.  See the description of that subr
    for more details on what it does and how to construct your own.!

 m(m.m & Init Buffer Locals)	    !* Discard locals of old mode, and set: *!
				    !* .Q: Make Local Q-Reg. *!
				    !* .0: old value of $Switch Mode Process *!
				    !* Options$ *!

				    !* Standard stuff to set up:  *!

 1,:i*/* m.LComment Startw	    !* Comment start... *!
 1,:i*/* m.LComment Beginw	    !* begin... *!
 1,:I* */M.LComment Endw	    !* And comment end. *!
 1,m.m& Indent Without Tabsm.LMM & Indentw	    !* Dont use tabs. *!
 1,m.m& XIndent Without Tabsm.LMM & XIndentw	    !* ... *!
 1,36m.LCOMMENT COLUMNw	    !* Set comment column. *!

				    !* Now either personal or standard init: *!
				    !* They can use .0, .Q. *!
 1:<m(m.mInit PL1 Mode)	    !* Call users init. *!
    >"N				    !* User has no init,  *!
	m(m.m& Default Init PL1 Mode)'	    !* ...so use default one. *!

 m.vPL1IND ..Dw		    !* Create a var for our dispatch table. *!
 ^:iPL1IND ..D|                                                                                                                                        A                             A   AA    A   AA   AA    A    A    (    )    A    A         A   AA    A   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA    A    A    A    A    A    A    A   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA    A    A    A    A   AA    A   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA   AA    A    A    A    A        |	    !* And set up the dispatch table. *!

 q.0,1M(M.M& Set Mode Line)PL1   !* Set, display mode. *!
 

!Cref PL1 Labels:! !C Crefs label references in a PL1 listing in the buffer.
The buffer should be a compilation listing.
If you just want a listing, not an object segment, try
    compiling with options -sb -ck.
If a statement on a line references more than one label then
    whichever label is highest alphabetically will be creffed.
If you want to cref a source, not a listing, use MM Cruf PL1 Entries.!

 [7[9 f[sstring			!* save!
 fsruntimeu7 .u9 fn q9j 		!* 7: Start time.!
					!* 9: Original point, auto-restored.!
 zj -s
NAMES DECLARED BY EXPLICIT CONTEXT.
fkc [1 .u1                             !* 1: start cref.!
 [2 :s

"N     .u2 '"# zu2 '                   !* 2: end cref.!
 [0 q..ou0 q1j                          !* 0: list buffer.!
 [..o					!* be sure to restore that!
					!* buffer.!
 fsbcreatew [3 q..ou3                  !* 3: table buffer.!
 [4                                     !* 4: dcl line#.!
 [5                                     !* 5: ref line#.!
 q0u..o					!* to list buffer.!

 <					!* Do next dcl.!
    .,q2:fb dcl ; \u4			!* 4: dcl!
    :sref;				!* Get its refs.!
    f<!NEXT REF!			!* Catch when done 1 ref.!
	c				!* past space??!
        1<  0,1a"c  \u5			!* ref#!
                    q4-q5"N		!* ignore dcl=ref case!
                      q3u..o 4,q5\	!* pad with 0s for sorting, search!
					!* now in table buffer.!
                      i	 4,q4\		!* ref-dcl to tbl!
		      i
                     q0u..o''		!* list buffer.!
            0,1a-15."e 1l 0,1a- "n 1f;NEXT REF'	!* end of ref!
                       s  2r'	!* still in ref!
           >>				!* done ref processing!
    >					!* done dcl processing!



 q3u..o   fwl  l 			!*  Now sort ref-dcl table, ordering by ref.!



 !* MUST REMOVE DUPLICATES!

 !*  Now search for each ref line and put cref in place of blanks.!

 q0u..o bj q3u..o bj			!* to top in both buffers.!

 <					!* next ref/dcl!
    q3u..o :s	; .-5,.-1x5		!* 5: ref!
    4 x4				!* 4: dcl!
    q0u..o :s
 5;				!* find ref line!
    0l f4				!* put in dcl!
    -l					!* back so can handle duplicates -- hier alph wins!
    >					!* done ref/dcl processing.!

 q3u..o					!* to table buffer???!
					!* misguided, probably --!
					!* should bbind up where set 3?!
 .,((fsruntime)-q7\).fx1		!* Tell user how long it took.!
 ^ftDone.  1 ms.  			!* ...!
 

!Cruf PL1 Entries:! !C Hacky creffer for subrs and functions.
Does not need a listing, only source.
Crefs PROC's, ENTRY's, and PROCEDURE's.  They must be of the form:
    <label> <whitespace> : <whitespace> <ENTRY> <BREAK CHAR>
I think this wins in most (all?) cases.
Not guaranteed to be correct when there are multiple routines of
    the same name, i.e. scoping is not handled.
Symbol table of entries creffed is inserted on new page at end.!
 [.1[.2[.3[.4 1f[both casew
 [..d :i..d..d		    !* Force a copy so can f^E. *!
 _*5:f..dA			    !* Make _ a letter. *!
 [.5 :i.5			    !* .5: Search-list of entries. *!
 [.6 5fs qvectoru.6		    !* .6: Entry/Dcl# symtab. *!
 2u:.6(0)			    !* 2 words per symtab entry. *!
 q..o[.8			    !* .8: Output (cruffed) buffer. *!
 fs b createw q..o[.7		    !* .7: Source buffer. *!
 g.8				    !* Init source buf with orig. *!
 
 0u.1				    !* Line counter. *!
 q.8u..o bj			    !* To top of output buf. *!
 < 9,%.1\  40.i			    !* Insert line number. *!
   l .-z; >			    !* Next line. *!

 q.7u..o bj			    !* To top of source buf. *!
 < 10,40.i			    !* Like output buf but spaces, so that *!
   l .-z; >			    !* both have same num chars. *!

				    !* Make pass over source, *!
				    !* defining entries. *!

 q.7u..o bj			    !* Top of source buf. *!

 < :sprocprocedureentry;   !* Find next subr. *!
   .u.1				    !* .1: past proc/entry. *!
   -fwl				    !* Back past proc/entry. *!
   ^-f
	 l			    !* Left past white space. *!
   0a-:"E			    !* Must be : else ignore. *!
        r ^-f
	 l			    !* Left past white to label. *!
	-fwx.2			    !* .2: label string. *!
	.u.3			    !* .3: end of label. *!
	0l 9c			    !* To where dcl line nums go. *!
	.( q.8u..o )j		    !* Same place in output buf. *!
	-4 x.4			    !* .4: dcl line number as string. *!
	q.7u..o			    !* Back to source buf. *!
	:fo.6.2u.3		    !* Get position in symtab for label. *!

	q.3"L q.6[..o		    !* Add label to symtab if not already. *!
	      -q.3*5j 10,0i 10r	    !* Make space at right place. *!
	      q.2,.fs wordw	    !* Put label in symtab. *!
	      -q.3+1*5j		    !* Position at val word. *!
	      q.4,.fs wordw	    !* Put dcl line num string in symtab. *!
	      ]..o		    !* Back to source code buffer. *!
	      '			    !* End of symtab addition. *!

	fq.5+fq.2+2-160"G	    !* When search-string gets too long... *!
	    q.8 m(m.m& PL1 Cruf Pass 2)    !* ... do a pass 2 to *!
				    !* cref entries in search-string. *!
	    :i.5		    !* Then reset search-string. *!
	    '			    !* Done a pass 2. *!
	:i.5.5.2	    !* Update search-list of entries. *!
	'			    !* End of find label. *!

   q.1j				    !* Past proc/entry. *!
   >				    !* End of find next subr. *!

 q.8 m(m.m& PL1 Cruf Pass 2)	    !* Do a final pass 2. *!

 q.8u..o			    !* Switch to output buffer. *!
 q.6 m(m.m& PL1 Cruf Insert Symtab)
 q.7 fs b killw		    !* Kill source buffer. *!
 bj 				    !* Return at top of output (orig) buf. *!

!^R Indent PL1 Stmt:! !^R Indentation via previous statement type.
If there are non-label tokens to left, then just calls
    ^R PL1 Indent Relative.
If non-null arg, calls ^R Indent Nested.
Calls macros to indent statements after prev stmt's type, e.g.
    looks for macro named & PL1 Indent After Do Stmt.
None found, it will call & PL1 Indent After Stmt.
If the previous statement was unfinished (i.e. we are not indenting
    a new statement really), then macros such as & PL1 Indent Unfin Do Stmt
    are called.
The default unfinished-stmt macro is & PL1 Indent Unfin Stmt.
^R Print Last PL1 Indenter will print the name of the indentation
    macro called.!
!* The name of the indentation macro called is left in $Last PL1 Indenter$.
 * All indent macros are passes two args:
 *     ARG1 points to where to indent (previous indentation has been
 *	    deleted).
 *     ARG2 points to the prev stmt's token, so that the macro can see
 *	    its indentation or whatever it wants.
 * Indent macros should return two values, bounding the buffer area changed.
 *!
 [.2[.3[.4[.5
 :i*m.vLast PL1 Indenterw	    !* Start null.  Generally, subrs *!
				    !* will put their own names in here. *!
 .m(m.m& PL1 Tokens to Leftp)"N    !* Toks left => ^R PL1 Indent Relative. *!
	 f^m(m.m^R PL1 Indent Relative) '
 ff"G			    !* ARG => goto ^R Indent Nested. *!
	 :iLast PL1 Indenter(^R Indent Nested)   !* We must put *!
				    !* name in since macro is EMACS *!
				    !* and doesnt like us... *!
	 f^m(m.m^R Indent Nested) '

 .[.1				    !* .1: where indent. *!

 1m(m.m& PL1 End Prev Stmt)u.2	    !* .2: end of prev statement. *!
 q.2j
 m(m.m& PL1 Next Token)u.5u.3	    !* .3: before token after prev stmt. *!
				    !* .5: after token... *!

 q.3-q.1"L			    !* Prev stmt unfinished. *!
            q.3,q.5x.4		    !* .4: string of token. *!
            1:< q.1,q.3m(m.m& PL1 Indent Unfin .4 Stmt)u.3u.1
                >"N		    !* No indent macro found. *!
                    q.1,q.3m(m.m& PL1 Indent Unfin Stmt)u.3u.1	 !* Default. *!
                    ''
        "#			    !* Prev stmt finished. *!
            .-b"N		    !* There is a prev stmt. *!
                1m(m.m& PL1 End Prev Stmt)u.2	    !* Go back another stmt. *!
                q.2j
                m(m.m& PL1 Next Token)u.5u.3	    !* Get token, which is the *!
				    !* token for the statement just before *!
				    !* where we want to indent. *!
                q.3,q.5x.4'	    !* String of token. *!
              "#		    !* No prev stmt in buffer. *!
                bu.3bu.5 :i.4'

            1:< q.1,q.3m(m.m& PL1 Indent After .4 Stmt)u.3u.1 !* Try ind. *!
                >"N		    !* No macro for indenting that. *!
                    q.1,q.3m(m.m& PL1 Indent After Stmt)u.3u.1 !* Default. *!
                    ''
 fsrgetty"n q.1,q.3 '	    !* .1,.3 bound buffer area changed. *!
 fsechodis Afsechodis
 0t 

!^R Insert PL1 End:! !^R Insert end and show matching block.
Indents if no whitespace to left of cursor.
Displays buffer around matching block statement.
    ARG = number of seconds to display there.
Inserts a comment after the "end;" to show what was ended, e.g.
    "/* do-while */"  or  "/* if-begin */".  Or has label if one was on the
    statement with the do/begin/etc.
    The MARK is left before this comment, point after so you can easily
    delete it with ^R Kill Region.!

 0,0a- "N 0,0a-	"N	    !* If no whitespace to left... *!
   ^m(m.m ^R Indent PL1 Stmt)f'' !* ...then indent... *!
 .,(iend;).f			    !* ...and insert end. *!
 .:				    !* Leave MARK after end;. *!
 .[.1 fnq.1j			    !* .1: Auto-restoring point. *!
 4r				    !* .: Start before END. *!
 [.2 [.4[.5 0[.3		    !* .3: DO/BEGIN/PROC level counter. *!

 <  b-."E FG 1'		    !* Go back statements until find *!
				    !* a matching DO or BEGIN or PROC. *!

    1m(m.m& PL1 End Prev Stmt)j    !* Back 1 semicolon... *!
    m(m.m& PL1 Next Token)u.5u.4   !* ... and fwd to prev stmt token. *!
    q.4u.2			    !* .2: Save beginning of this stmt. *!

    q.4,q.5f~IF"E		    !* IF: check last sub-stmt. *!
        q.4m(m.m& PL1 Last Sub-Stmt Token)u.5u.4'
    q.4,q.5f~ON"E		    !* ON: check last sub-stmt. *!
        q.4m(m.m& PL1 Last Sub-Stmt Token)u.5u.4'
    q.4,q.5f~ELSE"E		    !* ELSE: check last sub-stmt. *!
        q.4m(m.m& PL1 Last Sub-Stmt Token)u.5u.4'
    q.4,q.5f~DO"E q.3-1u.3'	    !* Dec level counter on DO,  *!
    q.4,q.5f~BEGIN"E q.3-1u.3'	    !*   or BEGIN,  *!
    q.4,q.5f~PROC"E q.3-1u.3'	    !*   or PROC,  *!
    q.4,q.5f~PROCEDURE"E q.3-1u.3' !*   or PROCEDURE.  *!
    q.4,q.5f~END"E %.3w'	    !* Inc on END (finds ARG2 first). *!
    q.3-1:;			    !* Found match when level = 0. *!
    >

				    !* .4,.5: Bound DO/BEGIN/PROC. *!
 q.4,q.5x.4			    !* .4: DO/BEGIN/PROC/PROCEDURE. *!

 q.2j				    !* First token of statement containing *!
				    !* matching DO, BEGIN, or PROC. *!
				    !* Now figure something for comment: *!
 .m(m.m& PL1 Get Statement Label)u.3	    !* .3: 0 or label. *!
 q.3"E 2 f~DO"E		    !* Unlabelled DO, get DO + next token. *!
	  fw +.m(m.m& PL1 Next Token)x.3  !* .3: token after DO. *!
	  :i.3.4 .3'	    !* .3: DO+nexttoken. *!
       "# 5 f~BEGIN"N		    !* Unlabelled, if not BEGIN,  *!
	     fwx.3		    !* .3: token starting stmt (IF/...). *!
	     :i.3.3-.4'    !* .3: IF-DO, IF-BEGIN, ELSE-... *!
	  "# fwx.3'''		    !* .3: BEGIN. *!
 q.1j i /* .3 */
				    !* Comment the end statement. MARK is *!
				    !* before the comment from earlier. *!
 q.1-fku.1			    !* .1: Point after ; *!
 q.2j				    !* Back to match and... *!
 0 ^v				    !* ...Display there. *!
 *30:w			    !* Wait ARG seconds or til input. *!
 1 				    !* Exit, restore point. *!

!& PL1 Get Statement Label:! !S Return label for statement at ARG.
ARG: Point within statement.
Returns string containing label, or
Returns 0 if no label found.!
 .[.0 fnq.0j			    !* .0: Auto-restoring point. *!
 1m(m.m& PL1 End Prev Stmt)j	    !* Move to end last stmt. *!
 1,.m(m.m& PL1 Next Token)[.2[.1   !* .1,.2: Bound next token. *!
 q.2j 0,1a-:"N 0 '		    !* Return 0, no label found. *!
 q.1,q.2x* 			    !* Return label string. *!

!Indent PL1 Region:! !C Indents each line from here to MARK.
On each line it:
    moves past labels, comments to first token,
    then calls ^R Delete Horizontal Space,
    then calls ^R Indent PL1 Stmt.
Leaves mark and point around changed region, and old text in kill stack.!
 :[.1 .u.2 [.3[.4[.5
 q.1,q.2f u.2u.1		    !* Order point and mark. *!
 q.1j				    !* To beginning of region. *!
 1[9 q.1,q.2x.5			    !* Save text, set kill direction. *!
 q.1,q.2m(m.m& Kill Text)	    !* Kill region to save it on kill stack. *!
 g.5				    !* Get back region now to edit it. *!
 q.1j z-q.2u.2			    !* Reset .2 so doesnt change as edit. *!

 <  0l
    m(m.m& PL1 Next Token)u.4u.3   !* Find next token. May be on another line *!
    q.3j			    !* Go to its left edge: first tok on its *!
				    !* line. *!
    z-.-q.2:;			    !* See if done. *!
    ^m(m.m^R Delete Horizontal Space)w
    ^m(m.m^R Indent PL1 Stmt)w	    !* Indent that line. *!
    l
    >

 q.1				    !* Set MARK at beginning of region. *!
 z-q.2j				    !* Set point at end. *!
 q.1,. 			    !* Display and exit. *!

!^R PL1 Indent Relative:! !^R PL1 Indent Relative to last line's words.
Successive calls get successive indentation points;  each call
    aligns under ARGth next word in previous line.
Words are separated by spaces, tabs, underscores, commas, periods.
To facilitate moving into a line, and changing an indentation, if
    there is whitespace to the right and left (i.e. this is a new
    indent call here), then the cursor is moved one column left.!
 qLast Pl1 Indenter[.1
 :iLast PL1 Indenter.1(^R PL1 Indent Relative)
 [1 ^:I1| qLast PL1 Indenteru.1   !* 1: Macro for weird tabbing. *!
	  :iLast PL1 Indenter.1(^R Tab to Tab Stop)  !* ... *!
	  :M(M.M^R Tab to Tab Stop)|	    !* ... *!
 0,1af 	+1"G		    !* If char to right is whitespace,  *!
    0,0af 	+1"G	    !* ...as is char to left,  *!
	fs hpos-1(		    !* ...then note column left,  *!
		   -d)m(m.m& Indent)w	    !* ...and move there. *!
	''			    !* ... *!
 .[P FSHPOS[0			    !* P: orig point. 0: hpos. *!
 ^-f 	L		    !* Move left past whitespace. *!
 .[Q FSHPOS[2			    !* Q: point left of white. 2: hpos. *!
 0L<    B-."E QPJ :m1'		    !* No line for relative indenting *!
				    !* so just tab stop. *!
        -L1A-15."N0;'>		    !* Back to non-blank line. *!
 Q0"G1:<0,Q0+1:FM>"ER'		    !* Cursor to orig hpos. *!
		  "#0L1:<0,Q2+1:FM>"ER'	    !* ... *!
				   "#QPJ:M1'''	    !* ... *!

 < F :FB_.,	 "E:L'"#R'	    !* Find end of word. *!
     ^F_., 	R	    !* Right to start next word. *!
     >				    !* Go to start of ARGth next word. *!

 FSHPOS(QQ,QPK			    !* Back to orig point, remove white left. *!
         ):M(M.M& Indent)	    !* And indent to column found. *!

!^R Global PL1 Comment:! !^R Call ^R for large comment.
While in global comment ^R:
Comment column is set to 10,
^R Indent for Comment is called initially,
MM Auto Fill Mode$ is entered with auto-indent,
$Comment Start$ is set to "/**" to mark global comments.
"/*** */" (comment with just a *) expand into /* * * *... */,
    aligned with any surrounding global comments (for boxes),
    or if no surrounding comments expand into $PL1 Star Line Width$ wide
    (default is 51).
When ^R returns, comment-ends within each global comment will be
    vertically aligned.!
 0fo..qGlob of Comments Flag"N	    !* Already in Global Comment. *!
    f:^m(m.m^R Indent for Comment)'	    !* So just do M-;. *!
 1m.vGlob of Comments Flagw	    !* Signal now in glob mode. *!
 fn0m.vGlob of Comments Flagw  !* When leave, signal not in mode. *!
 [.1[.2
 :i*Global Comment[..j
 10[Comment Column
 :i*/**[Comment Start	    !* So mark each global comment *!
				    !* for later comment-end aligning. *!
 1[Space Indent Flag
 fs qp ptr[Q			    !* Q: Pop to here to restore fill mode. *!
  [Auto Fill Mode		    !* Save whether auto-filling now. *!
  m(m.m Auto Fill Mode)	    !* Into auto fill mode. *!
  :l gComment Start		    !* Put in comment starter... *!
  1m(m.m^R Indent for Comment)	    !* ... and then align it. *!
  .-z"L -l' :l			    !* Position at end of started comment. *!
   w				    !* Enter ^R mode for globals. *!
  0l				    !* Always be at line beginning. *!
				    !* so that HPOS works in virtl bufs. *!
  :fb/**"L			    !* If we are in a global comment,  *!
     < l :fb/**"E 1;' >'	    !* ...then go to line after comments. *!
  fs z-.f[ vzw		    !* Bounds around buffer before point. *!
  m(m.m & Align Global PL1 Comment Ends)   !* Align those before point. *!
  zj f] vzw			    !* Restore bounds. *!
  .f[ vbw			    !* Bounds around buffer after point. *!
  m(m.m & Align Global PL1 Comment Ends)   !* Align those after point. *!
  bj f] vbw			    !* Restore bounds. *!
  qQ fs qp unwindw		    !* Pop down and restore auto-fill. *!
 m(m.m& Process Options)	    !* Auto-fill may change. *!
 m(m.m& Set Mode Line)		    !* ... *!
 

!& Align Global PL1 Comment Ends:! !S Ends within contiguous global comments.
Contiguous global comments are comments starting with "/**", on
    successive lines.
Contiguous global comments have their comment-ends aligned vertically.
If a global comment consists soley of "*", i.e. it is "/*** */",
    then it will expand out into a "/* * * * * ...* */" comment, aligned
    with its contiguous global comments.  If no contiguous comments,
    expands out into /* * *...*/, $PL1 Star Line Width$ wide, default 51,
    and extending to left margin.
After alignment, "/**" is replaced by "/* ".!
 [.1[.2[.3
 bj				    !* Go thru whole buffer. *!
 < :s/**; fkc			    !* Find next contig global comment. *!
   0u.1				    !* .1: Max width of gc within cgc. *!
   0u.2				    !* .2: /*** */ found flag. *!
   0u.3				    !* .3: Count of gcs in this cgc. *!
   .( < :fb/**;		    !* Next gc start in this cgc. *!
	%.3w			    !* .3: Inc gc count. *!
	.-1f 		    !* Replace with regular comment start. *!
	4 f=* */"E 1u.2'	    !* .2: Found a /*** */ in this cgc. *!
	:fb*/;			    !* Find next gc end in this cgc. *!
	fs hpos,q.1 f  u.1 w	    !* .1: Max width of gc. *!
	l >			    !* Next line, maybe end of cgc. *!
      fs z-.f[ vzw		    !* Set virtual buffer to end with cgc. *!
      )j			    !* Back to start of cgc. *!
   q.3-1"E			    !* If just one gc in cgc,  *!
      q.2"N			    !* ...and if was /*** */,  *!
	-^f 	 k	    !* ...then kill indentation,  *!
	51fo..qPL1 Star Line Widthu.1''    !* ...and set width of star line. *!
   q.1-2u.1			    !* .1: HPOS to put /* at. *!
   q.2"N			    !* If have a /* * * *...*/ in * cgc,  *!
      (q.1-qComment Column-3&1)+q.1u.1'   !* .1: round up if need to, to *!
				    !* make the * * */ come out evenly. *!
   < :s*/;			    !* Next gc end. *!
     -7 f=/* * */"E		    !* If comment was just a *, expand  *!
	 2r			    !* ...into * * * * ... *!
	 q.1-(fs hpos)/2 <i* >    !* ... *!
	 2c '			    !* ... (to match 2r next). *!
     2r q.1m(m.m& Indent) f	    !* Indent the comment end, tell ^R. *!
     l >			    !* Next line, continue. *!
   zj f] vzw			    !* Restore boundaries. *!
   >				    !* Continue with next cgc. *!
 				    !* Done aligning. *!

!^R End Global PL1 Comment:! !^R Exit large comment ^R.
Calls ^R End Comment, then exits ^R, so that global comment ^R
    is ended, and comment column will be reset to its old (one-line
    comment form) value.
If given an ARG, will inhibit alignment of global comment-ends, by
    replace all global comment-starts ("/**") by regular comment-starts
    ("/* ").!
 ^m(m.m^R End Comment) f
 ff"G			    !* Given an ARG. *!
    .( bj			    !* ...so replace all /**,  *!
       < :s/**; .-1f >	    !* ...with /* . *!
       )j'			    !* ...and return to original point. *!
 fs ^R Exit  		    !* Exit this global com mode ^R. *!

!^R Slurp PL1 to Char:! !^R Prev line back to CHAR moved to point, indented.
Non-comment text from previous line (back to CHAR typed) is moved
    onto the current line, after indentation, and then ^R Indent
    PL1 Stmt is called to re-align.  Now that the prev line is
    changed, things might look better.
Any comment on prev line is left there, and ^R Indent for Comment is
    called on it to align it after the text is removed from before it.!
 [.1[.2[.3[.4[.5[.6
 m.i fiu.5			    !* .5: Get char to slurp to. *!
 z-.u.1				    !* .1: Original point. *!
 0l ^f 	 r		    !* Line begin, past indentation. *!
 z-.u.6				    !* .6: Where to put slurped stuff. *!
 0:l z-.u.3			    !* .3: Prev lines end. *!
 .m(m.m& Back Over PL1 Line Comment)j	    !* Before any comment & white. *!
 .u.2				    !* .2: Point before any comment. *!
 < .,(0l).:fb.5; >	    !* Search back ARG chars on this line. *!
 .,q.2f( fx.4 ) f		    !* .4: Slurped chars. *!
 z-.-q.3"N			    !* If was a comment, reindent it. *!
    ^m(m.m^R Indent for Comment) f'	    !* ... *!
 z-q.6j				    !* Back to where to put text. *!
 .,(g.4 i ). f		    !* Get the slurped text. *!
 0l				    !* Back before text. *!
 ^m(m.m^R Indent PL1 Stmt) f	    !* Now reindent slurped text line. *!
 z-q.1j w 1 			    !* Exit, with orig point restored. *!

!^R Print Last PL1 Indenter:! !^R Print macro name in echo area.!
 qLast PL1 Indenter[.0	    !* Put name in more usable qreg. *!
 fs echo displayw		    !* Clear the... *!
 Cfs echo displayw		    !* ... echo area. *!
 ^ft.0			    !* Print name. *!
 0fs echo activew
 				    !* Exit. *!

!& PL1 Indent After Stmt:! !S Default after-indent, same as prev stmt.
If no prev stmt (i.e. 1st stmt in buffer), then indentation is
given by the variable $1st Stmt Indentation$, default = 10.
ARG1 -> where to indent.
ARG2 -> token for previous statement.
Returns two vals surrounding insertion.
Leaves pointer after indentation.!
 qLast Pl1 Indenter[.1
 :iLast PL1 Indenter.1(& PL1 Indent After Stmt)
 u.1				    !* Where to indent. *!
 [.2				    !* Pointer to prev stmt token. *!
 [.3				    !* Indentation amount. *!

 q.2-b"E			    !* This is 1st statement, no prev. *!
    10u.3			    !* Indentation amount, default. *!
    1:<q1st Stmt Indentationu.3>' !* See if user provides an amount. *!
  "#				    !* There is a previous stmt. *!
    q.2j fs hposu.3'		    !* See how much prev stmt indented. *!

 q.1j				    !* Go to where indent. *!
 q.3-(fshpos)-1"L ^m(m.m^R PL1 Indent Relative) '   !* If past where indent *!
				    !* to then call indent relative. *!
 q.3m(m.m& Indent) 		    !* Indent and return ptrs around. *!

!& PL1 Indent After If Stmt:!
!& PL1 Indent After On Stmt:!
!& PL1 Indent After Else Stmt:!
!& PL1 Indent After Compound:! !S Handle indentation for stmt after IF etc.
Compound stmts are IF-, ELSE-, and ON-statements.
ARG1 -> where to indent.
ARG2 -> token for previous statement.
Returns two vals surrounding insertion.
Leaves pointer after indentation.
If (e.g.) IF ... DO, then indent aligns with DO, +
    $COMP BLOCK Indentation$, i.e. $...$ over from BLOCK.
    (Default $COMP BLOCK$ is 0.)
If non-BLOCK, aligns with IF.!
 qLast Pl1 Indenter[.1
 :iLast PL1 Indenter.1(& PL1 Indent After Compound)
 u.1				    !* Where to indent. *!
 [.2				    !* Pointer to prev stmt token. *!
 1:<qCOMP BLOCK Indentationu.3>"N	    !* Get $...$ or make. *!
        0m.vCOMP BLOCK Indentationu.3'   !* Default is 0. *!

 q.2j fs hpos[.6		    !* .6 has (default) indentation. *!
				    !* e.g. indentation of non-DO IF. *!

				    !* Check for IF-DO, ON-DO, etc. and *!
				    !* align with DO or BEGIN:  *!

 q.2m(m.m& PL1 Last Sub-Stmt Token)[.5[.4  !* .4,.5 around final token. *!
 q.4,q.5f~DO"E q.4j fs hpos+q.3u.6'	    !* IF ... DO. .6 has indentation. *!
 q.4,q.5f~BEGIN"E q.4j fs hpos+q.3u.6'    !* IF ... BEGIN. *!

 q.1j				    !* Go to where indent. *!
 q.6-(fshpos)-1"L ^m(m.m^R PL1 Indent Relative) '   !* If past where indent *!
				    !* to then call indent relative. *!
 q.6m(m.m& Indent) 		    !* Indent and return ptrs around. *!

!& PL1 Indent After Begin Stmt:!
!& PL1 Indent After Do Stmt:!
!& PL1 Indent After New Block:! !S Next statement indented more, for DO etc.
ARG1 -> where to indent.
ARG2 -> DO token.
2 Vals returned, around indentation.
Pointer left after indentation.
Indentation aligns with whatever follows the DO, BEGIN, etc.!
 qLast Pl1 Indenter[.1
 :iLast PL1 Indenter.1(& PL1 Indent After New Block)
 u.1 [.2
 q.2j fwl			    !* Go past DO token. *!
 z-.<1af 	
         "L 1;'c>		    !* Past whitespace. *!
 fs hpos[.3			    !* Record this column. *!
 q.1j
 q.3-(fshpos)-1"L ^m(m.m^R PL1 Indent Relative) '   !* If past where indent *!
				    !* to then call indent relative. *!
 q.3m(m.m& Indent) 		    !* Indent and return ptrs around. *!

!& PL1 Indent After Procedure Stmt:!
!& PL1 Indent After Entry Stmt:!
!& PL1 Indent After Proc Stmt:! !S Indent $1st Proc Stmt Indentation$ amount.
If no $...$ then default 10.
ARG1 -> where to indent.
ARG2 -> PROC token.
Returns two vals around indentation.
Leaves pointer after indentation.!
 [.1 [.2 [.3
 qLast Pl1 Indenter[.4
 :iLast PL1 Indenter.4(& PL1 Indent After Proc Stmt)
 10fo..q1st Proc Stmt Indentationu.3	    !* Indentation amount. *!
 q.1j				    !* Where to indent. *!
 q.3-(fshpos)-1"L ^m(m.m^R PL1 Indent Relative) '   !* If past where indent *!
				    !* to then call indent relative. *!
 q.3m(m.m& Indent) 		    !* Indent and return ptrs around. *!

!& PL1 Indent After End Stmt:! !S Insert indentation by matching DO/BEGIN/PROC.
ARG1 -> where to indent.
ARG2 -> END token.
Returns 2 vals around indentation.
Returns with pointer after indentation.!
 qLast Pl1 Indenter[.1
 :iLast PL1 Indenter.1(& PL1 Indent After End Stmt)
 u.1 [.2 [.4[.5
 0[.3				    !* DO/BEGIN/PROC level counter. *!
 q.2j				    !* Start from END token. *!

!Put in sometime search for matching label subr... *!

 <  b-.;			    !* Go back statements until find *!
				    !* a matching DO or BEGIN or PROC. *!

    1m(m.m& PL1 End Prev Stmt)j    !* Back 1 semicolon... *!
    m(m.m& PL1 Next Token)u.5u.4   !* ... and fwd to prev stmt token. *!
    q.4u.2			    !* Save beginning of this stmt. *!

    q.4,q.5f~IF"E		    !* IF: check last sub-stmt. *!
        q.4m(m.m& PL1 Last Sub-Stmt Token)u.5u.4'
    q.4,q.5f~ON"E		    !* ON: check last sub-stmt. *!
        q.4m(m.m& PL1 Last Sub-Stmt Token)u.5u.4'
    q.4,q.5f~ELSE"E		    !* ELSE: check last sub-stmt. *!
        q.4m(m.m& PL1 Last Sub-Stmt Token)u.5u.4'
    q.4,q.5f~DO"E q.3-1u.3'	    !* Dec level counter on DO,  *!
    q.4,q.5f~BEGIN"E q.3-1u.3'	    !*   or BEGIN,  *!
    q.4,q.5f~PROC"E q.3-1u.3'	    !*   or PROC,  *!
    q.4,q.5f~PROCEDURE"E q.3-1u.3' !*   or PROCEDURE.  *!
    q.4,q.5f~END"E %.3w'	    !* Inc on END (finds ARG2 first). *!
    q.3-1:;			    !* Found match when level = 0. *!
    >

 q.2j				    !* First token of statement containing *!
				    !* matching DO, BEGIN, or PROC. *!
 fs hpos[.3			    !* Save match's indentation. *!
 q.1j
 q.3-(fshpos)-1"L ^m(m.m^R PL1 Indent Relative) '   !* If past where indent *!
				    !* to then call indent relative. *!
 q.3m(m.m& Indent) 		    !* Indent and return ptrs around. *!

!& PL1 Indent Unfin Stmt:! !S Indent new line of unfinished statement.
Default for indenting unfinished statements. Does:
Case1: If there is an open paren, aligns with next non-white.
Case2: If $Unfin Stmt Indentation$ is defined it will indent
       $Unfin Stmt Indentation$ more than the start of the stmt.
Case3: If prev line contains start of stmt, aligns with 1st word after
       beginning of stmt token (which may be part of token).
Case4: Calls ^R PL1 Indent Relative.
ARG1 -> where to indent.
ARG2 -> token starting unfinished statement.
Returns 2 vals around indentation.
Point left after indentation.!
 qLast Pl1 Indenter[.1
 :iLast PL1 Indenter.1(& PL1 Indent Unfin Stmt)
 u.1				    !* Where to indent. *!
 [.2				    !* Pointer to prev stmt token. *!
 [.4				    !* Extra indentation amount. *!
 [.3[.5
 1:<    fo..qUnfin Stmt Indentationu.4	    !* Get $...$ if defined. *!
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
        ^f 	jw	    !* Yes, go past white-space. *!
        fs hposu.5		    !* Will indent to this column. *!
        >
 q.1j				    !* Where indent *!
 q.5-(fshpos)-1"L ^m(m.m^R PL1 Indent Relative) '   !* If past where indent *!
				    !* to then call indent relative. *!
 q.5m(m.m& Indent) 		    !* Indent and return ptrs around. *!

!& PL1 Indent Unfin If Stmt:! !S Indent new line of unfinished IF statement.
Indents same amount as the IF if the THEN hasn't occured yet.
If THEN has occured, just calls & PL1 Indent Unfin Stmt.
ARG1 -> where to indent.
ARG2 -> token starting unfinished statement.
Returns 2 vals around indentation.
Point left after indentation.!
 qLast Pl1 Indenter[.1
 :iLast PL1 Indenter.1(& PL1 Indent Unfin If Stmt)
 u.1				    !* Where to indent. *!
 [.2				    !* Pointer to prev stmt token. *!
 fsqpptr[.0			    !* .0: Unwind to here to restore vbuf. *!
 fsz-q.1f[vzw			    !* VBuf ends at point so dont consider *!
				    !* any statements after this unfin one. *!
 q.2j
 .,zm(m.m& PL1 Token Search)THEN"N	    !* Point after last THEN. *!
    .,1m(m.m& PL1 Token Search)IF"E	    !* No following IF, so  *!
       q.0 fs qp unwindw	    !* Restore vbuf. *!
       q.1,q.2m(m.m& PL1 Indent Unfin Stmt) '    !* treat as random. *!
       2r'			    !* Before IF under which to indent. *!
 q.0 fs qp unwindw		    !* Restore vbuf. *!
 fs hpos[.3			    !* See how much IF was indented. *!
 q.1j				    !* Go to where indent. *!
 q.3-(fshpos)-1"L		    !* Past where indent to,  *!
    ^m(m.m^R PL1 Indent Relative) '	    !* so call indent relative. *!
 q.3m(m.m& Indent) 		    !* Indent and return ptrs around. *!

!& PL1 Indent Unfin On Stmt:!
!& PL1 Indent Unfin Else Stmt:!
!& PL1 Indent Unfin Comp:! !S Indent new line of unfinished compound.
Indents same amount as the last sub-statement so far.
ARG1 -> where to indent.
ARG2 -> token starting unfinished statement.
Returns 2 vals around indentation.
Point left after indentation.!
 qLast Pl1 Indenter[.1
 :iLast PL1 Indenter.1(& PL1 Indent Unfin Comp)
 u.1				    !* Where to indent. *!
 [.2				    !* Pointer to prev stmt token. *!
 [.4[.5
 q.2,q.1f[hboundw		    !* Virtual buf around this unfin stmt. *!
 bm(m.m& PL1 Last Sub-Stmt Token)u.5u.4    !* Find last sub-stmt token. *!
 q.4j				    !* Go there. *!
 f]hboundw			    !* Restore original buf boundaries. *!
 q.4,q.5f~IF"N			    !* Not IF: use default on sub-stmt. *!
                q.1,q.4m(m.m& PL1 Indent Unfin Stmt) '

 q.4j fs hpos[.3		    !* See how much IF was indented. *!
 q.1j				    !* Go to where indent. *!
 q.3-(fshpos)-1"L ^m(m.m^R PL1 Indent Relative) '   !* If past where indent *!
				    !* to then call indent relative. *!
 q.3m(m.m& Indent) 		    !* Indent and return ptrs around. *!

!& PL1 Next Token:! !S Return ptrs around next token in buffer.
ARG gives place to start from in buffer.
    No ARG means here.
ARG,: Labels are skipped unless pre-comma argument given.
Comments are skipped.!
 .[.1				    !* Save point while search. *!
 [.2[.3				    !* .3,.2 will bound token. *!
 qPL1IND ..D[..D		    !* Use PL1 break-chars. *!
 ff"G j'			    !* Position at ARG1 if any. *!

 z-b"E q.1j z,z '		    !* Empty buffer, no token. *!

 <				    !* Loop over comments, maybe labels. *!
				    !* Search for end of token or beginning *!
				    !* of comment:  *!
    :s/*"E		    !* Search for token end. *!
        zj 0a"B q.1j z,z '	    !* No tokens found. *!
	.u.2			    !* .2: End of buf is end of token. *!
	-fwl .u.3 1;'		    !* .3: Mark beginning of token. *!
    0a-*"E :s*/"E zu.3zu.2 1;' ' !* Skip a comment. *!
    "#   .-1u.2			    !* .2: Possible end of token. *!
	 r			    !* Back before the break char. *!
	 <  .-z;		    !* Stop at buffer end. *!
	    1af 	"L	    !* Right past white. *!
		 1a-("E 1:<fllr>"N 1;''"# 1;''c>  !* Skip parens for *!
				    !* case of label arrays. *!
	 (ff&2)1a-:"N	    !* If pre-comma (i.e. accept labels) *!
				    !* or if not a label,  *!
	    q.2j-fwl .u.3 1;'	    !* .3: then have token. *!
	 '			    !* Skip past a label. *!
    >

 q.1j				    !* Restore point. *!
 q.3,q.2 			    !* Return bounds of token. *!
				    !* z,z if none found. *!

!& PL1 Token Search:! !S Searches for a token in a statement.
Comments are skipped.
ARG1 is point in buffer to start from.
ARG2 is iteration: i.e. search for ARG2th token.
STRINGARG is token to search for.
Returns 0 if search unsuccessful: end of statement (;) or end of buffer
    reached first, non-0 if successful.
Returns with pointer after token if successful.!
 :i*[.1 .[.2 j 0[.3	    !* .3 is return val. Init notfound. *!
 qPL1IND ..D[..D		    !* Use dispatch table for PL1. *!

 f<!DONE!
      <				    !* For skipping comments. *!
        :s.1/*;"E f;DONE'	    !* Found nothing. *!
        fk+fq.1+2"E r 1u.3 1;'	    !* .3: Found token. *!
        0a-;"E f;DONE'	    !* End of statement found first. *!
        0a-*"E :s*/"E f;DONE'   !* Skip comments, but allow *!
		 r 1u.3'	    !* .3: slash to end token. *!
        >>

 q.3"E  q.2j '			    !* If unsuccessful, dont move. *!
 q.3 				    !* Return 0 lost, 1 won. *!

!& PL1 Tokens to Leftp:! !S Returns 0 if no tokens to left on line.
ARG is pointer into line where to look left from.
Labels or comments are not counted.!
 [.1 .[.2 [.3[.4
 q.1j 0l			    !* To beginning of line. *!
 m(m.m& PL1 Next Token)u.4u.3	    !* Find next token after that. *!
 q.2j				    !* Back to original point. *!
 q.3-q.1"L 1 '		    !* Token is to left. *!
	"# 0 '		    !* Token is not to left. *!

!& PL1 Last Sub-Stmt Token:! !S Finds last stmt in compound stmt (if, on).
If current statement is "IF a THEN IF b THEN c;" this subr will return
    ptrs surrounding c's statement token.
ARG1 points to statement token from where to start, i.e. the compound
    statement's token (IF or ON).
    If ARG1 points to a non-compound statement token, pointers around
    that token are returned.!
 [.1 .[.2 [.3[.4
 q.1j				    !* Position at starting stmt token. *!

 f<!Found!			    !* Find last sub-stmt token. *!
  1f<!Next!			    !* Check if compound statement. *!
     .m(m.m& PL1 Next Token)u.4u.3
     q.3j			    !* Position at next token. *!

     fwf~IF"E			    !* IF-compound statement. *!
        .,1m(m.m& PL1 Token Search)THEN"E f;Found'	    !* No THEN clause. *!

				    !* & PL1 Token Search skips comments and *!
				    !* returns 0 if ; or z reached first. *!
        1;'			    !* Again check if comp. *!

     fwf~ON"E			    !* ON-compound statement. *!
        .+2m(m.m& PL1 Next Token)jw	    !* Position after condition *!
	1;'			    !*    and again check if compound. *!

     fwf~ELSE"E		    !* ELSE-compound statement. *!
        .+4m(m.m& PL1 Next Token)u.4u.3 q.3j	    !* Position after ELSE ... *!
        1;'			    !*    and again check if compound. *!

     f;Found			    !* Non-compound statement found. *!
     >				    !* End next. *!
    >				    !* End found. *!

 q.3,q.4(q.2j) 		    !* Return ptrs around token. *!

!& PL1 End Prev Stmt:! !S Return ptr to end prev ARG'th statement.
Value returned points to the semicolon.
ARG = 1 means find first end-; looking back from here.!
 .[.1				    !* Save point while search. *!

 <				    !* Look back ARG statements. *!
      <				    !* Look back one statement. *!
         -:s;*/"E bj 1; '	    !* No previous statement. *!
                  "# 1a-;"E 1;'   !* Find end of prev stmt. *!
                     -:s/*'	    !* Skip past comments. *!
         >			    !* Point at end of prev stmt. *!
     >

 .(q.1j) 			    !* Return semicolon-ptr and restore *!
				    !* point. *!

!& Back Over PL1 Line Comment:! !S From point, move left on line past comment.
ARG is ptr into some line to check left from.
Returns ptr to before comment and white-space before it.
If no comment on line, no movement: ARG is returned.!
 .[.1 j
 .,(0l).:fb/*"E  '		    !* No comment found on line. *!
 -^f 	[.2j		    !* Move before any white space. *!
 .(q.1j) 			    !* Return that place, reset point. *!

!& PL1 Cruf Insert Symtab:! !S Used by MM Cruf PL1 Entries.!
 zj				    !* Now insert symbol table at end. *!
 14.i				    !* Start on new page. *!
 i
ENTRY SYMBOL TABLE:


 1u.1				    !* .1: Index into entry symtab. *!
 :< g:.6(%.1) i  		    !* Insert next dcl line number. *!
    g:.6(%.1-2)			    !* Insert entry name. *!
    i

   >w				    !* Stop when at end of symtab qv. *!

 

!& PL1 Cruf Pass 2:! !S Pass 2 for MM Cruf PL1 Entries.
.5 is ptr to search-string of entries. (E.g. ^Bfoo^B^O^Bbar^B^O...)
.6 is ptr to qvector holding entry/dcl# symtab.
ARG1 is ptr to output buffer.
Each occurrance of an entry reference that matches the search-string
    will get a cref line number put at the beginning of the line.
    (The buffer has been line-numbered and has space for the crefs.)!
				    !* .5: Ptr to search-string. *!
 fq.5"E '			    !*     Return if no search-string. *!
				    !* .6: Ptr to symtab. *!
 [..o				    !* ARG1: Select output buffer. *!
 .[.7
 [.2[.4
 0,fq.5-1 :g.5 u.5		    !* Trim last ^O off search-list. *!

 bj
 < :s.5;			    !* Search for next ref of any entry. *!
   r				    !* Before ending break char. *!
   -fwx.2			    !* .2: Reference string. *!
   fo.6.2u.4			    !* .4: Dcl line number string. *!
   0l				    !* To beginning to put cref. *!
   f.4			    !* Insert dcl line number. *!
   l				    !* And move on. *!
   >				    !* End of pass two. *!

 q.7j
 

!& Setup PL1 Library:! !S Put macros into MM-variables for speed.!
 @:i*| :i*[1			!* 1: Will be subroutine name.!
       m.m1m.vMM 1w 	!* Put subroutine into an!
					!* MM-variable.!
       |m(m.m& Setup/Kill Auxiliary)	!* Do all subroutines.!
 

!& Kill PL1 Library:! !S Get rid of our MM-variables that were for speed.!
 m.mKill Variable[K			!* K: Global, for aux mapper.!
 @:i*| mkMM w 			!* Kill each subroutines!
					!* MM-variable.!
       |m(m.m& Setup/Kill Auxiliary)	!* Kill each of the variables.!
 

!& Setup/Kill Auxiliary:! !S Map NUMARG function over subroutines.!
 [1					!* 1: Function to map.!
 m1& PL1 End Prev Stmt			!* Apply it to each subroutine!
 m1& PL1 Next Token			!* name.!
 m1& PL1 Indent After Stmt
 m1& PL1 Indent After Begin Stmt
 m1& PL1 Indent After Do Stmt
 m1& PL1 Indent After End Stmt
 m1& PL1 Indent Unfin Stmt
 m1& PL1 Indent Unfin If Stmt
 m1& PL1 Indent Unfin On Stmt
 m1& PL1 Indent Unfin Else Stmt
 m1& PL1 Last Sub-Stmt Token
 m1& PL1 Indent After If Stmt
 m1& PL1 Indent After On Stmt
 m1& PL1 Indent After Else Stmt
 m1& PL1 Token Search
 m1& PL1 Indent After Proc Stmt
 m1& PL1 Indent After Procedure Stmt
 m1& PL1 Indent After Entry Stmt
 

!& Default Init PL1 Mode:! !S Default setup for PL1 mode.
It sets up the following characters for this mode and buffer:
    RUBOUT	Tab-hacking rubout,
    C-RUBOUT Normal rubout,
    TAB	^R Indent PL1 Stmt,
    C-M-?	^R Print Last PL1 Indenter,
    M-;	^R Indent for Comment,
    M-\	^R End Comment,
    C-M-;	^R Global PL1 Comment,
    C-M-\	^R End Global PL1 Comment,
    M-{	^R Slurp PL1 To Char.
Turns on Auto Fill if $PL1 Auto Fill Default$ is non-0.
Users who want to provide their own MM Init PL1 Mode$ can make ^R keys
    (q-registers) and variables local to this mode and buffer by using the
    following subroutine which is global to Init PL1 Mode:
    .Q: Make Local Q-register!

				    !* Set up local ^R keys: *!

 1,q(1,q. m.Qw)m.Q.	    !* Exchange rubout flavors. *!
 1,m.m^R Indent PL1 Stmtm.QI    !* Use pl1-indenting tab. *!
 1,m.m^R Print Last PL1 Indenterm.Q...? !* C-M-? For tracing. *!
 1,m.m^R Indent for Commentm.Q..;
 1,m.m^R End Commentm.Q..\
 1,m.m^R Global PL1 Commentm.Q...;
 1,m.m^R End Global PL1 Commentm.Q...\
 1,m.m^R Slurp PL1 To Charm.Q..{

 0fo..qPL1 Auto Fill Default(	    !* Default is to auto-fill,  *!
   )m(m.m Auto Fill Mode)	    !* ...will cause unfin indenting. *!
 1,1m.LSpace Indent Flagw	    !* ... *!
 				    !* Done. *!

!* Local Modes:
 * Fill Column:76
 * End:
 * *!
