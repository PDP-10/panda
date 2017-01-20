!* -*-TECO-*- Library written and maintained by David Eppstein <Kronj@Sierra>
**
** Based on my modifications to Eugene Ciccarelli's Ada library, with some code
** (especially the block comment facility on c-m-*) taken from Ethan Bradford's
** Pascal library.
**
** 23  30-Aug-85   Kronj   Missing close quote in & End of Pascal Code cond.
** 22   8-Apr-85   Kronj   Try a more local approach to unmatched paren indent.
** 21   4-Mar-85   Kronj   Better indentation after else.
** 20  12-Apr-84   Kronj   Add Web mode, make it almost like Pascal.
** 19  15-Mar-84   Kronj   Fix template macro so works again for proc/func.
**			   Was going in parens and never finding stmt start.
** 18   3-Mar-84   Kronj   Add Pascal Comment Foo variables for customization.
** 17   3-Mar-84   Kronj   Fix & Start of Statement to know about else.
**			   Make template work better on functions.
** 16  28-Feb-84   Kronj   Include c-L in whitespace characters.
** 15  27-Feb-84   Kronj   Make backward motion smarter about comments.
** 14  25-Feb-84   Kronj   Make templates and else clause respect undo.
** 13  19-Feb-84   Kronj   Add comments to parameter variables.
**			   Control continuation indentation - separately for
**			   code and variable declarations.
**			   Make End of Stmt smarter for c-m-,
** 12  18-Feb-84   Kronj   Make proc template not put arglist into comments
** 11  10-Jan-84   Kronj   Make : hack smarter about ): and :=
** 10   4-Jan-84   Kronj   Template-inserted comments are always left-aligned.
**			   Other comments start at column 40.
**  9  22-Dec-83   Kronj   Fix "Earl Ciccarelli" above.  Act as though var
**			   Pascal : Start exists.  Fix c-U c-m-. for program.
**  8   4-Dec-83   Kronj   Fix indentation after "if x then<lf>if y then begin"
**			   (This used to work - I broke it in edit 5).
**  7   2-Dec-83   FMF     Need to patch in with in other places
**  6   2-Dec-83   FMF     Add # Pascal with Template
**  5  28-Oct-83   Kronj   Off by one when counting columns in block comment
**			   Improve & Start of Stmt when comments exist
**			   Attempt to make & Start of Stmt smart about OF
**  4  16-Oct-83   Kronj   Fix "procedure foo (var bar: integer)"^Z.
**  3  15-Oct-83   Kronj   Fix indentation in ^R Pascal Else, make VAR, TYPE,
**			   and CONST into Firewall instead of Start.  Add
**			   Block property to distinguish BEGIN etc from VAR.
**			   Separate code for c-m-N and c-m-P.
**  2  14-Oct-83   Kronj   Add c-m-AENP, change return convention for templates
**  1  13-Oct-83   Kronj   Release
*!

!~FILENAME~:! !Functions for editing Pascal code!
PASCAL

!Pascal Mode:!
!& Pascal Mode:! !& PAS Mode:! !& PGO Mode:! !C Set up for editing Pascal code.
If a Pascal Mode Hook exists, it is macroed.  Otherwise the following are set:
  Tab    indents for the next Pascal statement.
  c-m-.  inserts a template for the statement pointed to.
  c-m-,  inserts an ELSE clause for the previous IF statement.
  c-m-+  makes a statement of the form Foo := Foo + 1, given Foo.
  c-m-*  makes a block comment
The Lisp defun and list commands use Pascal blocks and statements instead.!

 m(m.m& Declare Load-Time Defaults)
    Pascal Comment Column,* What column to start Pascal comments in: 40
    Pascal Comment Rounding,* How to round column for Pascal comments: |/4+1*4|
    Pascal Comment Start,* String that starts Pascal comments: |(*|
    Pascal Comment Begin,* What to insert at start of Pascal comments: |(* |
    Pascal Comment End,* What to insert at end of Pascal comments: | *)|


 m(m.m& Init Buffer Locals)	      !* Flush previous mode!
 :i*Pascalm(m.m& Init Pascal Mode)  !* This is really Pascal not Web!
 1m(m.m& Set Mode Line)Pascal     !* set mode line, run hook, etc.!

!Web Mode:! !& Web Mode:! !C Set up for editing Web code.
This is mostly like Pascal mode, except that it can tell when the
current context is TeX and behaves slightly differently then.
Also, the default setting of variables is quite different.!

 m(m.m& Declare Load-Time Defaults)
    Web Comment Column,* What column to start Web comments in: 0
    Web Comment Rounding,* How to round column for Web comments: |+1|
    Web Comment Start,* String that starts Web comments: |{|
    Web Comment Begin,* What to insert at start of Web comments: |{|
    Web Comment End,* What to insert at end of Web comments: |}|
    Web Insert Template Comments,* If non-zero add comments on ENDs: 0
    Web Begin on Separate Line,* If non-zero put CRLF before BEGIN: 1
    Web begin Indentation,* How far to indent BEGIN keyword: 0


 m(m.m& Init Buffer Locals)	      !* Flush previous mode!
 :i*Webm(m.m& Init Pascal Mode)     !* This is really Web not Pascal!
 qWeb Insert Template Commentsm.lPascal Insert Template Comments !* ...!
 qWeb Begin on Separate Linem.lPascal Begin on Separate Line	    !* ...!
 qWeb begin Indentationm.lPascal begin Indentation		    !* ...!
 1m(m.m& Set Mode Line)Web	      !* set mode line, run hook, etc.!

!& Init Pascal Mode:! !S Set up variables for Pascal and Web modes!

 [0				    !* Get name of mode to use!
 1,(q0 Comment Column)m.lComment Column	    !* Set Comment Column!
 1,(q0 Comment Rounding)m.lComment Rounding    !* ... Comment Rounding!
 1,(q0 Comment Start)m.lComment Start	    !* ... Comment Start!
 1,(q0 Comment Begin)m.lComment Begin	    !* ... Comment Begin!
 1,(q0 Comment End)m.lComment End		    !* ... Comment End!

 0fo..q0 Mode Hook"e		    !* If no hook given!
   m(m.m& Default Init 0 Mode)'  !* Give normal key settings!

 !* now create a ..D with Lisp syntax appropriate for Pascal!
 m.q..D			    !* local ..D!
 0fo..qPascal ..Df"nu..d'"#	    !* if already exists, use it!
    :g..Du..D			    !* otherwise copy previous one!
    -1u1 0<%1*5+1:f..d >	    !* [NUL,0) are breaks!
    10<%1*5+1:f..dA>		    !* [0,9] are constituents!
    A-9-1<%1*5+1:f..d >	    !* (9,A) are breaks!
    26<%1*5+1:f..dA>		    !* [A,Z] are constituents!
    a-Z-1<%1*5+1:f..d >	    !* (Z,a) are breaks!
    26<%1*5+1:f..dA>		    !* [a,z] are constituents!
    128-z-1<%1*5+1:f..d >	    !* (z,DEL] are breaks!
    _*5+1:f..dA		    !* underscore is a constituents!
    _*5:f..dA		    !* underscore is a non-delimiter!
    $*5:f..d 		    !* dollar is a delimiter!
    %*5:f..d 		    !* percent is a delimiter!
    .*5:f..d 		    !* period is a delimiter!
    (*5+1:f..d(		    !* parentheses are parentheses!
    )*5+1:f..d)		    !* ...!
    "*5+1:f..d|		    !* quote for Web strings and chars!
    '*5+1:f..d|		    !* quote for normal strings and chars!
    |*5+1:f..d|		    !* Web Pascal escape!
    [*5+1:f..d(		    !* brackets are parentheses!
    ]*5+1:f..d)		    !* ...!
    {*5+1:f..d(		    !* curly brackets are parentheses!
    }*5+1:f..d)		    !* (really comments but this works)!
    \*5+1:f..d/		    !* backslash is quote for Web!
    @*5+1:f..d/		    !* as is atsign (for octal numbers eg)!
    q..Dm.vPascal ..Dw'	    !* Save ..D for next time through!
 

!& Default Init Pascal Mode:! !S Set up key bindings for Pascal mode.
A Pascal Mode Hook should call this if it wants the default key bindings.!

 1,(m.m^R Pascal Template)m.q....	    !* c-m-.  template hack	     !
 1,(m.m^R Pascal Else)m.q...,	    !* c-m-,  ELSE hack		     !
 1,(m.m^R Pascal Increment)m.q...+	    !* c-m-+  Foo := Foo + 1 hack    !
 1,(m.m^R Pascal Block Comment)m.q...*  !* c-m-*  comment hack	     !
 1,(m.m^R Pascal Start of Block)m.q...A !* c-m-A  block start	     !
 1,(m.m^R Pascal End of Block)m.q...E   !* c-m-E  block end		     !
 1,(m.m^R Pascal Back Statement)m.q...P !* c-m-P  statement start	     !
 1,(m.m^R Pascal Forward Statement)m.q...N !* -N  statement end	     !
 1,(m.m^R Pascal Indent)m.qI	    !* Tab    indent pascal stmt     !
 1,q(1,q.m.qw)m.q.'	    !* Del    tab hacking rubout     !

!& Default Init Web Mode:! !S Set up key bindings for Web mode.
A Web Mode Hook should call this if it wants the default key bindings.!

 1,(m.m^R Pascal Template)m.q....	    !* c-m-.  template hack	     !
 1,(m.m^R Pascal Else)m.q...,	    !* c-m-,  ELSE hack		     !
 1,(m.m^R Pascal Increment)m.q...+	    !* c-m-+  Foo := Foo + 1 hack    !
 1,(m.m^R Web Block Comment)m.q...*     !* c-m-*  comment hack	     !
 1,(m.m^R Pascal Start of Block)m.q...A !* c-m-A  block start	     !
 1,(m.m^R Pascal End of Block)m.q...E   !* c-m-E  block end		     !
 1,(m.m^R Pascal Back Statement)m.q...P !* c-m-P  statement start	     !
 1,(m.m^R Pascal Forward Statement)m.q...N !* -N  statement end	     !
 1,(m.m^R Web Indent)m.qI	    	    !* Tab    indent pascal stmt     !
 1,(m.m^R Web Quote Hack)m.q" !'!	    !* Quote  maybe do quote hack    !
 1,q(1,q.m.qw)m.q.'	    !* Del    tab hacking rubout     !

!^R Web Block Comment:! !^R Make block text within Web file.
I don't know why you would want to use this function, but here it is.!

 .(i@t .[0i @>),.(q0j)	    !* Just make a TeX area!

!^R Web Indent:! !^R Indent text either as for Pascal or as for TeX.!

 m(m.m& In Pascal Part)"n f:m(m.m^R Pascal Indent)'	    !* Pascal!
 f:m(m.m^R Indent Relative)				    !* and TeX!

!^R Web Quote Hack:! !^R Funny doublequote if in TeX, else normal.!

 m(m.m& In Pascal Part)"e	      !* TeX?!
   1,m(m.m& Get Library Pointer)TeX"e	      !* If dont already have TeX!
      m(m.mLoad Library) TeX'	      !* then load it in now!
   :m(m.m^R TeX ")!'!'	      !* And run funny doublequote!
 "fs^RInsert!'!		      !* Pascal, just insert doublequote!
0

!& In Pascal Part:! !S Return non-zero if in Pascal part of a Web file!

 .[0 fnq0j			    !* Don't change point!
 !<! -:s@ @*@>=@p@t[1	    !* Find last context marker!
 q1+3"g 0'			    !* Not found or module start, TeX part!
 q1+5"n 1'			    !* Anything else but comment, Pascal!
 !<! :s@>"e 0'		    !* Comment and no end, still in TeX!
 .-q0"g 0'			    !* Ends after point, still in TeX!
 1				    !* Ends before point, in Pascal again!

!& End of Pascal Code:! !S Find last text on line, ignoring comments!

 !* Skip back over comments to find uncommented line!
 :l < -@f
	 l		    !* From end of line, step back over space!
       0,0a-}"e -s{'		    !* Search back for bracket comment!
       "# -2 f=*)"e -s(*'	    !* Or paren comment!
       "# 1''-1; >		    !* Until no more comments!

 !* Now find end of text from start of line!
 0l .[0				    !* Go to line start!
 :< @f 	l		    !* Loop - skip over spaces!
    :f  @;			    !* Exit if EOL!
    2 f=(*"e2cs*)'"#		    !* Skip over comments!
      0,1a-{"e s}'"#		    !* Skip over other flavor of comment!
	0,1a"cfwl'"#0,1a-("e@fll'"#c''    !* move over token, expr, or char!
	.u0''			    !* Save as last text found!
  >"nzj'			    !* End of file if error!
  q0j				    !* Go back to end of last text!

!& Start of Pascal Statement:! !S Find beginning of this statement.
Arguments are passed to & Pascal Find Key Start.
With no numarg, a positive pre-comma arg means stop even in the middle
of a line, and a negative one means don't stop till start of whole stmt.!

 m(m.m& Declare Load-Time Defaults)
    Pascal begin Firewall,: 1
    Pascal loop Firewall,: 1
    Pascal repeat Firewall,: 1
    Pascal var Firewall,: 1
    Pascal const Firewall,: 1
    Pascal type Firewall,: 1
    Pascal record Firewall,: 1
    Pascal then Start,: 1
    Pascal else Start,: 1
    Pascal do Start,: 1
    Pascal end Back,: |beginloopcaserecord|
    Pascal until Back,: |repeat|
    Pascal then Back,: |if|
    Pascal do Back,: |forwhilewith|
    Pascal else Back,: |then|


 m.m& Start of Pascal Statement[S  !* We may want to recurse!
 m.m& Pascal Find Key Start[F	    !* Macro to find previous stopping place!
 m.m& Pascal Back Space[B	    !* Macro to skip back over space!
 ,mF[1 [2 .[3 [4		    !* Remember point to stop!


 < 0,1a-{"n 2 f=(*"n .u3''	    !* If not comment, remember last text!
   .-q1"e'			    !* If found that point, stop now!
   mB"n "'l+1'"# 'u4	    !* Remember if we skipped over line start!

   "e ;,0a-;"e q3j'	    !* If no argument, check for semicolon!
        "# 0,0a-,"e q3j'	    !* And for comma!
	"# q4"g :,0a-:"e	    !* And for colon!
	   0,-1a-)"n 0,1a-="n   !* if not func decl or assign stmt!
	      q3j'''''''	    !* then treat as stmt start!
   "# .-q1:"g ,mFu1''	    !* Maybe update position to search for!
   -@fll .-q1"e '		    !* Back over word, see if target!
   0,1a"c fwx2 q4"g "e 0fo..qPascal 2 Start"n q3j''' !* Check if stmt!
	"e 0fo..qPascal 2 Firewall"n q3j''   !* Or firewall!
	f~2of"e q2,(:i*setarraycase)mS	    !* OF, match back!
	   4 f~case"e .u4	    !* If match for OF is CASE...!
	     q2,(:i*beginrecord)mS	    !* Go back for statement type!
	     "e q3j'		    !* Treat as firewall!
	     "# 6 f~record"'e+q4j'''	    !* Else stay, careful for doubles!
	"# 1< 0fo..qPascal 2 Backf"n u4  !* Find word to match back to!
              q2,q4mS		    !* Match back recursively!
	      "n -c'		    !* Being careful not to double the match!
	      q4u2 @'>''	    !* Now try to match that word too!
 >				    !* End of loop!

!& Pascal Back Space:! !S Back over whitespace and comments.
Returns nonzero if a line boundary is crossed.!

 [2 0[4				    !* Keep counter for lines crossed!
 < .u2 -@f 	l		    !* Back over horiz whitespace!
   0,0a-}"e -s{'		    !* Skip over this kind of comment!
   0,0a-)"e 0,-1a-*"e -2c -s(*'' !* And this kind of comment!
   -@f
f( "n1u4')l			    !* And over lines counting them!
   .-q2@; >			    !* Repeat until no more move!
 q4				    !* Return whether crossed a line!

!& Pascal Find Key Start:! !S Reverse search for numarg.
Used as a subroutine by & Start of Pascal Statement.  The string should
have ^Bs around each word in it.  A pre-comma argument is used to construct
an error message if the search fails.!

 "e b'			    !* If no argument, stop at start of buffer!
 .[0 fnq0j			    !* Don't change point on caller!
 [1 0s1			    !* Set up search string!
 < -:s; 0,0a"b 0,fk+1a"b .'' >   !* Find word surrounded by delimiters!
 u1 !"! :i*Couldn't find match to "1"fsErr !''!     !* Else complain!

!& End of Pascal Statement:! !S Find end of this statement.
Ends after semicolon or ELSE.!

 m(m.m& Declare Load-Time Defaults)
    Pascal begin Forward,: |end|
    Pascal loop Forward,: |end|
    Pascal case Forward,: |end|
    Pascal repeat Forward,: |until|
    Pascal do Clause Start,: 1
    Pascal then Clause Start,: 1


 m.m& End of Pascal Statement[E    !* We may want to recurse!
 m.m& Forward Pascal Token[T	    !* Macro to find next token in program!

 0[1[2[3			    !* Save some registers!

 < mT -@fwx2			    !* Get next token, keep as a string!
   .-z"e '			    !* If not recursive, exit if EOF!
   0,0a-;"e'		    !* or if semicolon!
   f~2else"e q1f"e '"#-1u1''	    !* or if unmatched ELSE!
   f~2if"e %1'			    !* Look for IF to match ELSE!
   0fo..qPascal 2 Clause Start"e !* Check for DO and THEN!
     0fo..qPascal 2 Back"n '   !* Check for END and UNTIL!
     0fo..qPascal 2 Forwardf"nu3 !* See if we want to match this!
      <mE -@fwx2 f~23@;> 1u0''   !* Do, loop until we find match!
   >

!& Forward Pascal Token:! !S Find next non-comment expr in program text!

 :< @f
 	l			    !* Skip over spaces!
    2 f=(*"e2cs*) !<!>'	    !* Skip over comments!
    0,1a-{@:;			    !* If not other comment, done with loop!
    s}				    !* Else search for other comment!
 >"n zj'			    !* If found nothing, exit!

 0,1a"c fwl'			    !* If a word, move over it!
 0,1a-("e @fll'		    !* If an expr, move over whole thing!
 c				    !* Else just move over character!

!& Uppercase Pascal Keyword:! !S Make reserved word uppercase if wanted.!

 m(m.m& Declare Load-Time Defaults)
    Pascal Reserved Word Case,* If non-0 BEGIN and END etc capitalized: 0


 qPascal Reserved Word Case"n -fw@fc' 

!^R Pascal Indent:! !^R Move to column for next Pascal statement.!

 m(m.m& Declare Load-Time Defaults)
    Pascal begin Indentation,* How far to indent BEGIN keyword: 4
    Pascal do Indentation,* How far to indent while stmt body: 4
    Pascal then Indentation,* How far to indent if stmt body: 4
    Pascal type Indentation,* How far to indent type definitions: 4
    Pascal of Indentation,* How far to indent case stmt body: 4
    Pascal else Indentation,* How far to indent else clause body: 4
    Pascal loop Indentation,* How far to indent loop stmt body: 4
    Pascal record Indentation,* How far to indent record body: 4
    Pascal repeat Indentation,* How far to indent repeat stmt body: 4
    Pascal procedure Block Indentation,* How far to indent procedure body: 4
    Pascal function Block Indentation,* How far to indent function body: 4
    Pascal program Block Indentation,* How far to indent main program: 0
    Pascal Code Continuation,* How far to indent continuation of code: 2
    Pascal var Decl,* How far to indent variable declarations: 4
    Pascal const Decl,* How far to indent constant declarations: 4
    Pascal label Decl,* How far to indent label declarations: 4


 .[1[2[3				!* 1: where we started!
 m.m& End of Pascal Code[E		!* E: macro to find end of code!
 -@f	 l 10,0a-10"n q1j f:m(m.m^R Indent Relative)'
					!* if not at beginning of line, do!
					!* indent relative instead!

 !* Look for unmatched parenthesis from previous line!
 !* If it's an open, align to it; if a close,!
 !* expand definition of previous line to include the corresponding open!
 < -@f 
	l		    !* Find previous nonblank line!
   fsz-.f[vz 0l .f[vb	    !* Bound to previous line!
   0u2 :<ful -1u2>		    !* See if we end some paren list!
   q2"e :l :<-ful 1u2>'		    !* Nope, see if we open one!
   f]vb f]vz			    !* Undo virtual bounds!
   q2; -fll >			    !* Loop for unmatched close parens!

 !* Find first nonblank line (not including comments).!
 !* If we found an unmatched paren we use that instead!
 q2"n 2 f=(*"e 3u2'"# 0,2a- "e 2u2'''   !* Adjust indent for open paren!
 "# q1j < b-.; -L .u3		    !* try prev line or exit if buffer top!
          mE 0f  @:; q3j >	    !* find first code!

    !* Now have found some code.  If it ends with a known keyword, use
       the extra indentation specified, otherwise 0, plus the indentation
       of the start of the statement. !
   ;,0a-;"e -:cw -1,m(m.m& Start of Pascal Statement) !* Found semicolon!
      @fwx3 0fo..qPascal 3 Block Indentationu2'  !* Use 1st wd of stmt!
   "# 0a-,"e -c 0u2'		    !* Not semi, maybe comma!
      "# -@fwx3 qPascal Code Continuationfo..qPascal 3 Indentationu2 !* !
         0fo..qPascal 3 Back"e -@fwl''   !* Move over unless need for match!
      m(m.m& Start of Pascal Statement)    !* Find place to align to!
      @fwx3 q2fo..qPascal 3 Declu2''	    !* One more chance to change tab!

 fsSHpos+q2u2				!* 2: total indentation!
 q1j fsSHposu1				!* 1: indentation where we started!
 q1-q2"l q2:m(m.m& Indent)'		!* before indent point, move there!
 f:m(m.m^R Indent Relative)		!* past indent point, indent relative!

!^R Pascal Increment:! !^R Set up statement of form Foo := Foo + 1.
If given an argument, doesn't add the " + 1;".!

 -@f 	k			    !* Kill off any blanks behind us!
 .[1 1,m(m.m& Start of Pascal Statement)   !* Go to start of statement!
 .,q1(q1j)x0 i := 0	    !* Insert doubled!
 ff"e i + 1;'		    !* Maybe insert increment part!
 q1,.				    !* Return changed bounds!

!^R Pascal Else:! !^R Insert ELSE clause after the last IF statement.
Any semicolon after the IF is automatically removed.!

 m.m& Start of Pascal Statement[S  !* Macro to find statement beginning!
 m.m& End of Pascal Statement[E    !* Macro to find statement end!
 [1[2 .[3

 :<  -@fll 1,mS			    !* Back to start of stmt!
    @fwx2 0fo..qPascal 2 Block Indentation"n   !* If PROGRAM etc!
	 q3j :i*No IF clause without ELSE found@fg'  !* Then cause error!
    f~2if"n !<!>'		    !* If not IF, try again!
    .u1 2c mE			    !* Save point, find end!
    -4 f~else@:; q1j		    !* Loop until it doesn't have an ELSE!
 >"n q3j fsErru1		    !* TECO error, see what it is!
     f~1NIB-3"g :i*No IF clause without ELSE found'"# q1'@fg'

 -c1m(m.m& Save for Undo)else insertion !* Let this change get undone!
 c 0,0a-;"e-d'		    !* Delete semicolon if any!
 .u2				    !* Save start point!
 a,-3a"b -3 f~end"e		    !* If ended with END!
    @f 	k  i		    !* Delete following spaces down to 1!
    :l -@f 	k  i		    !* Delete end of line spaces down to 1!
 0'"# 1''"# 1'"n		    !* Else no END!
    q1j 0@l @f 	l	    !* Find indentation of line with IF!
    fsSHPosu1 q2j i
0,q1m(m.m& XIndent)'		    !* And make new line indented the same!

 ielse  m(m.m& Uppercase Pascal Keyword)   !* Insert ELSE!
 ff"e q2,.'		    !* If no args, just return there!
 1,m(m.m^R Pascal Template)u1	    !* Else fill out BEGIN/END!
 q2,q1			    !* And return with new bounds!

!^R Pascal Block Comment:! !C Recursive edit for large block of comments.
Auto fill mode is turned on, ^R Indent for Comment is called initially,
Comment Start has a star added to it (so typically it becomes "(**").
"(*** *)" (comment with just a *) expand into (* * * *... *), aligned
with any surrounding block comments (for boxes), or if no surrounding
comments expand into Pascal Star Line Width wide.  When the recursive edit
returns, comment-ends within each block comment will be vertically aligned.
Point is left after the end of the last block comment found.!

 m(m.m& Declare Load-Time Defaults)
    Within Block Pascal Comment,: 0


 m.m^R Indent for Comment[C	    !* Get commenting macro!
 qWithin Block Pascal Comment"n f@:mC' !* If already making glob comment,!
				    !* ..just do a m-; to add this line!
 1[Within Block Pascal Comment   !* Else remember within glob comment!

 qComment Start[S qComment End[E	    !* Get comment vars!
 :i*Block Comment[..J		    !* Set mode line!
 fsSHPos[Comment Column	    !* Set comment col to current col!
 0[Comment Begin
 :i*S*[Comment Start	    !* Add star to comment start!
				    !* for later comment-end aligning.!
 1[Space Indent Flag		    !* Use fill prefix when filling!
 1[Auto Fill Mode		    !* Turn on autofill while in comment!
 @mC 				    !* Make comment and do recursive edit!
 0f  "n l'			    !* If inside a line, go to next line!

 !* Now have the comments all set up, fill them out...!

 [0[1[2[3 j			    !* Start at buffer top!
 < :sS*; fkc			    !* Find next contig block comment!
   fsSHPosu0			    !* Set column of CBC start!
   0u1 0u2 0u3			    !* Clear max width, * found, line count!
   .( -fkc <.-1f  -1 f	    !* Replace with regular comment start!
      fqE+1 f=*E"e 1u2'	    !* 2: Found a (*** *) in this CBC!
      :fbE;			    !* Find next BC end in this CBC!
      fsSHPos,q1f u1		    !* 1: Max column of BC!
      l :fbS*; %3>		    !* Next line comment start in this CBC!
      fsZ-.f[VZ		    !* Set virtual buffer to end with CBC!
      )j			    !* Back to start of CBC!

   q1-fqE+1u1			    !* 1: HPOS to put *) at!
   q3"e q2"n qFill Columnu1''	    !* Set width for single star row!
   q2"n (q1-q0-1-fqS&1)+q1u1'	    !* Make * * * line come out even!

   < :sE;			    !* Next BC end!
     fqEr			    !* Back over end of comment!
     -(fqS+2) f=S *"e	    !* If should become a star line, expand!
	 .,(q1-(fsSHPos)/2<i *>).f'	    !* ...and tell ^R about it!
     "# q1m(m.m& Indent)f'	    !* Normal line, indent and tell ^R!
     l >			    !* Next line, continue!
   zj f]VZ >			    !* Restore boundaries, go on to next CBC!
 0				    !* Done aligning!

!^R Pascal Start of Block:! !^R Move back to start of numarg level!

 m(m.m& Declare Load-Time Defaults)
    Pascal begin Block,: 1
    Pascal loop Block,: 1
    Pascal repeat Block,: 1
    Pascal of Block,: 1


 m.m& Start of Pascal Statement[S  !* Get forward movement macro!
 [0 .[1				    !* Save point, get another reg!

 :<.u0 1,mS			    !* Move over statement!
     q0-."e -@fll		    !* Nothing happened, back over token!
	    0,1a"c fwx0		    !* If word, look at it!
	           0fo..qPascal 0 Block"n !<!> 0'	!* If BEGIN, count!
		   0fo..qPascal 0 Firewall"e	    !* Else if non-stop then!
		      0fo..qPascal 0 Start"e fwl''''	    !* ...back across!
     @>				    !* If not BEGIN, dont count!
 q1j				    !* Got here, must have been an error!
 :i*Not within any blocksfsErr0 !* Complain and return!

!^R Pascal End of Block:! !^R Move forward to end of numarg level!

 m(m.m^R Pascal Start of Block)  !* Find block start!
 m(m.m& End of Pascal Statement)   !* Find end of that block!
 0

!^R Pascal Back Statement:! !^R Move back over statement!

 "l -:m(m.m^R Pascal Forward Statement)'	!* Maybe call opposite dir!
 m.m& Start of Pascal Statement[S [0	!* Get backward movement macro!
 < .u0 mS q0-."e			!* Move over statement.  If no move,!
	-@fll 0,1a"c fwx0		!* Back over token, if word!
	    0fo..qPascal 0 Back"n fwl' mS'	!* and END etc, move over!
	"# @'' >			!* Else token, reiterate!
 0

!^R Pascal Forward Statement:! !^R Move forward over statement!

 "l -:m(m.m^R Pascal Back Statement)'	!* Maybe call opposite dir!
 m.m& End of Pascal Statement[E [0 !* Get forward movement macro!
 <mE> 0				    !* Do movement!

!^R Pascal Template:! !^R Insert template for keyword just typed.
A numeric argument will make the inserted text slightly different,
for instance if you ran ^R Pascal Template from
	foo = record/\
the result would look like
	foo = record
	    /\
	end;    (* foo *)
but if you gave it an argument you would instead get
	foo = record
	    case /\ of
		
	end;    (* foo *)
All reserved words should expand to something reasonable - try
it to see what you get.  To insert an ELSE clause after an IF that
has been expanded, use ^R Pascal Else.

A pre-comma arg means don't save for Undo.!

!* Template routine is called with
     qX - m.m& XIndent
     qU - routine to capitalize reserved words if necessary
     qH - hpos to indent to
     qA - nonzero if there are words after the key
     qC - routine to insert comment from numarg
     qS - routine to insert conditional space
     q2 - word that was matched
      - point just before keyword
      - numarg or zero if none given
     .  - position when user typed ^Z.
   It should return only the last position changed
   (^R Pascal Template will supply the first position to ).
!

 .[1[2[3[4			    !* 1: where we started!
 m.m& XIndent[X		    !* Get indent macro for template!
 m.m& Uppercase Pascal Keyword[U   !* Get uppercase macro for template!
 m.m& Pascal Insert Comment[C	    !* Get comment macro for template!
 m.m& Pascal Conditional Space[S   !* Get space macro for template!
 m.m& Pascal Back Space[B	    !* Get macro to skip back over comments!
 m.m& Start of Pascal Statement[A  !* Get macro to go to statement start!

 mB -@:fwl -@fwf(l)x2		    !* 2: keyword!
 1,m.m# Pascal 2 Templateu3	    !* 3: function for keyword!
 q3"n 0[A			    !* Got it, remember immediately behind!
!Found!	.u4			    !* Here from retry further down - save pt!
      m(m.m& Start of Pascal Statement)    !* Find start of stmt for indent!
      fsSHPos[H q1j		    !* Get indentation and go back to point!
      -@f 	l		    !* Skip over spaces!
      "e 2m(m.m& Save for Undo)template expansion'	!* Make Undo work!
      0f  "e q1j'"# .,q1k'	    !* If not line start kill them!
      q4(.u4),(fff"nw')m3(q4,)'	    !* Go run template macro!

 !* Last word didn't match, maybe we want to look at start of statement!
 q1j mB -@:fll			    !* Back into statement again!
 < 1,mA .u3 mB 0,0a-:@:; -c > q3j !* Find start, ignore colons!
 .-q1"n				    !* If got a different place!
   @fwx2 1,m.m# Pascal 2 Templateu3	    !* Try looking it up again!
   q3"n 1[A oFound''		    !* Found, remember where and go run!

 !* Even that failed, give error!
 q1j :i*No template for 2fsErr 0

!& Pascal Conditional Space:! !S Insert space if dont already have some!

 -@f 	 "n '		    !* If have spaces, exit!
 0f  "n i'		    !* Else if not line start make a space!

!& Pascal while/then Clause:! !S Insert FOR, WHILE, or IF statement!

 [0 .[1 mS g0mU		    !* Add a DO or THEN at the end!
 qA"e fnq1j mS'		    !* Maybe leave cursor in top clause!
 :m(m.m# Pascal 0 Template)    !* Finish up after DO or THEN!

!& Pascal then/do Clause:! !S Subroutine for THEN and DO templates!

 m(m.m& Declare Load-Time Defaults)
    Pascal Begin on Separate Line,* If non-zero put CRLF before BEGIN: 0


 "n i
0,qH+mX .'			    !* If argument, make just one line!
 .[1 qPascal Begin on Separate Line"n	    !* If want to insert CRLF!
    -@f 	l 0f  "e q1j'"# .,q1k i
0,qH+mX''				!* Do it!
 mS .u1 ibeginmU			!* Make BEGIN with space if necessary!
 q1,:m(m.m# Pascal begin Template)	!* Finish by making END etc!

!& Pascal Insert Comment:! !S Insert numarg in comment, leave cursor after end.
A pre-comma arg means to capitalize a reserved word!

 m(m.m& Declare Load-Time Defaults)
    Pascal Insert Template Comments,* If non-zero add comments on ENDs: 1


 qPascal Insert Template Comments"e '   !* If don't want any just return!

 0[Comment Column		    !* Left align this comment!
 @m(m.m^R Indent for Comment)	    !* Start making the comment!
 g()s)			    !* Insert text, search for end!
 "n :mU' 			    !* Capitalize or just return!

!# Pascal begin Template:! !S Insert BEGIN/END pair!

 .( j -@f 	l		    !* Find blanks before BEGIN!
    0f  "e j fsSHPosuH'	    !* Maybe fix up alignment column!
    -@fll 0,1a"c fwx2'		    !* Find word before BEGIN!
    f~2else"n			    !* If not ELSE then look for stmt start!
      1,m(m.m& Start of Pascal Statement)  !* ...!
      0,1a"c fwx2'' )j		    !* Try to find a better word to use!

 i
0,qH+qPascal begin IndentationmX .[0 fnq0j i
0,qHmXiend;mU q2mC .

!# Pascal case Template:! !S Insert template for CASE statement!

 :i*of,:m(m.m& Pascal while/then Clause)

!# Pascal do Template:! !S Insert DO clause of WHILE or FOR!

 qPascal do Indentation,:m(m.m& Pascal then/do Clause)

!# Pascal else Template:! !S Insert ELSE clause for IF statement!

 qPascal else Indentation,:m(m.m& Pascal then/do Clause)

!# Pascal if Template:! !S Insert template for IF statement!

 :i*then,:m(m.m& Pascal while/then Clause)

!# Pascal loop Template:! !S Insert P20 LOOP/EXIT/END statement!

 i
0,qH+qPascal loop IndentationmX i
0,qHmXiexitmUi if mU .[0 fnq0j i
0,qH+qPascal loop IndentationmX i
0,qHmXiend;mU 1,(:i*loop)mC .

!# Pascal of Template:! !S Insert OF clause of CASE statement!

 m(m.m& Declare Load-Time Defaults)
    Pascal END aligned with CASE body,* If non-zero align CASE END with body: 0


 i
0,qH+qPascal of IndentationmX .[0 fnq0j i
qPascal END aligned with CASE bodyf"n    !* If aligning END, do it!
    qPascal of Indentation'+qH(0,)mX	    !* In either case indent for END!
 iend;mU 1,(:i*case)mC .	    !* Insert it and return!

!# Pascal procedure Template:! !# Pascal function Template:!
!# Pascal program Template:! !S Insert procedure, function, or program block!

 .[1 [0 qA"e 3,m(m.m& Read Line)2 name: u0	!* Read block name!
    fq0:"g 0' mSg0'		    !* And insert it!
 "# .(jfwl@f
 	l @fwx0)j'		    !* Already given, find in text!

  f0:f"l(0,):g0u0'	    !* Flush past first space!

 0,0a-;"n;i' i

0,qH+qPascal 2 Block IndentationmX	!* Maybe add semi, blank line!
 "n ivar
0,qH+qPascal 2 Block Indentation+qPascal var IndentationmX   !* ...!
      .[3 i

0,qH+qPascal 2 Block IndentationmX'    !* If arg add VAR, remember pt!
 ibeginmU q0mC i
0,qH+qPascal 2 Block Indentation+qPascal begin IndentationmX !* ...!
 "e .[3' i
0,qH+qPascal 2 Block IndentationmX	    !* Insert BEGIN and END lines!
 iendmU				    !* Finish END line!
 f~2program"e.'"#;'i q0mC .(q3j)	    !* Return to saved point!

!# Pascal record Template:! !S Insert RECORD type structure!

 .(1:<j -fwl fwx2>w)j			!* Find word before RECORD!
 i
0,qH+qPascal record IndentationmX	!* Make next blank line!
   "e .[1'"#icase mU .[1 i of
mU 0,qH+qPascal record Indentation+qPascal of IndentationmX'	!* ...!
   i
0,qHmX iend;mU q2mC .(q1j)	    !* Insert END and comment, return!

!# Pascal repeat Template:! !S Insert REPEAT/UNTIL statement!

 i
0,qH+qPascal repeat IndentationmX i
0,qHmX iuntil mU . 

!# Pascal then Template:! !S Insert THEN clause for IF statement!

 qPascal then Indentation,:m(m.m& Pascal then/do Clause)

!# Pascal with Template:!
!# Pascal while Template:!
!# Pascal for Template:! !S Insert template for WHILE or FOR statement!

 :i*do,:m(m.m& Pascal while/then Clause)
