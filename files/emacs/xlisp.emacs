!* -*- Teco -*-		Library created and maintained by KMP@MC !

!* Bugs, feature requests, etc...					!
!*									!
!* [Source: KMP (07/16/80)]						!
!* This needs to be sure it has a good ..D or else floating point	!
!* numbers and other screws will happen -- eg, PRINC+T function in	!
!* RAB;OUTMIS will get mistaken for a PRINC if not careful. -kmp	!
!*									!
!* [Source: CWH]							!
!*  (cond (condition then-clause) (t else-clause))			!
!*    <=> (IF condition then-clause else-clause)			!
!*									!
!* [Source: KMP]							!
!*  (and exp1 exp2) <=> (IF exp1 exp2)					!
!*  (or exp1 exp2)  <=> (IF (NOT exp1) exp2) ; Maybe IFN, too?		!
!*  Old-DO          <=> New-DO						!
!*  (PROG (...) ...) => (LET (..) ...) ; if no RETURN or GOs		!
!*	; Maybe find leading SETQs and move into the BVL. Super-tricky	!
!*	; due to the evaluation environment differences.		!
!*  (TERPRI), (TYO ...), (PRIN1 ...), (PRINC ...), ... ; Sequences only	!
!*     <=> (FORMAT ...)							!
!*									!
!* [Source: RWK (07/16/80)						!
!*  Do these allow one to do M-X Undo?					!
!*									!
!* [Source: CWH (07/16/80)]						!
!*  You may also want to include WHEN and UNLESS.  I have been using	!
!*  these recently after RWK convinced me they were winners.  You may	!
!*  also want to write one completely hairy macro which figures out	!
!*  which of the above transformations you want applied.  As long as it	!
!*  can be undone with M-X Undo, such a frob wouldn't be too dangerous.	!
!*									!
!* [Source: CWH (07/21/80)] Re: LAMBDA->LET				!
!* I would prefer it if ((LAMBDA (X) Z) NIL) became			!
!* (LET ((X NIL)) Z) instead of (LET (X) Z).  Perhaps a switch?		!
!* Also, modernizing ((LAMBDA (X Y) Z) 0 0) inserts a spurious		!
!* space after the first 0.						!

!~Filename~:! !Macros for transforming Lisp Code!
XLISP

!& Query Loop:! !& Loop doing things and asking for confirmation!

:i*Query/[..J[C[0[P

<m();w			    !* Execute Entry Condition		!
 :i* C Change?_  fsechodispw @v !* Prompt for input			!
 @:fi uC			    !* Peek for command			!
 qC-4110."e ?uC '"# :fiuC '	    !* Get ascii in qC			!
 @ft C_... 		    !* Tell the user we saw input	!
 qC-^"e fi			    !* If cmd = ^			!
  .:ww1:<> oPause'	    !*   Go to previous			!
 qC f _ , . :"l fi		    !* If cmd = Space or Comma,		!
  .u0 m() q0j			    !*   Run change macro		!
  qC-,"e			    !*   If comma, show result		!
    !Pause!			    !*     Come here to pause		!
    :i* C Ok?_ fsechodisp w @v  !*     Wait while (s)he approves	!
    :fi uC			    !*     Peek for command		!
    qC-4110."e ?uC '"# :fiuC '    !*     Get ascii in qC		!
    @ft C_... 		    !*     Tell the user we saw input	!
    qC-_ "e fi		    !*     If space,			!
       oLoop'			    !*        then go on		!
    qC f QqXx :"l fi		    !*     If Q or X,			!
	'			    !*        then Exit			!
    qC-^"e fi			    !*     If ^,			!
       .:ww1:<> oPause'	    !*     Go to previous		!
    qC-"e fi		    !*     If Control-R,		!
        oPause'		    !*        then edit and re-pause	!
    qC-"e fi		    !*     If Control-L,		!
        @m(m.m^R_New_Window)	    !*        Redisplay			!
        oPause '		    !*        and then pause		!
    qC-?"e  fi		    !*     If ? or Help,		!
       ft Space__=_Continue____C-L_=_Redisplay____C-R____=_Edit
	  Q_or_X_=_Exit________Anything_else_aborts_and_is
	  ______________________reread_as_a_command.
	  --Pause-- oPause'	    !*        Show help info		!
    '				    !*     No Such Option. Exit.	!
  qC-."e '			    !*   Return if dot			!
  oLoop'			    !*   Continue looking if not comma	!
qC-"e fi			    !* If cmd = Control-R,		!
  oLoop '			    !*   Edit and Loop			!
qC-"e fi			    !* If cmd = Rubout			!
 :-."n .' fkr oSkipLoop '	    !*   Skip this entry and find next	!
qC-"e fi		    !* If cmd = Control-L,		!
 @m(m.m^R_New_Window)w oLoop'	    !*   Redisplay and loop		!  
qC f ?  :"l fi		    !* If cmd = ? or Help		!
!"! ft Space__=_Replace_entry_and_move_on__________C-L_=_Redisplay
       Comma__=_Replace_entry_and_await_approval___C-R_=_Edit
       Rubout_=_Don't_replace_this_entry
       Period_=_Replace_and_exit___________________Anything_else_exits
       Q_or_X_=_Exit________________________________and_is_reread_as_a_command.
       --Pause-- oLoop '	    !*    Show help info		!
qC f XxQq "l fi		    !* If cmd = Q or X,			!
   '				    !*    Just exit, eating char	!
'				    !* Exit if unknown command		!
!Loop! :-."n.' !SkipLoop!>	    !* Continue looping			!
:i*CEnd_of_..Jfsechodisplay
0fsechoactive



!Modernize FUNCTION References:! !S Change (FUNCTION form)  =>  #'form	!

@:i*| :s(FUNCTION( fkc )|,(    !* Search for (FUNCTION		!
@:i*| .[0 fll 1f[noquitw -d	    !* Go kill ending paren		!
      q0j 9d @f_
	k  !* Kill (FUNCTION & whitespace	!
      .u0 !"! i#' 2r		    !* Insert #'			!
      m(m.m &_XLISP_Indent_SEXP)   !* Re-Indent S-Expression		!
       			    !* Go to top of S-Expression	!
    |) !"<! m(m.m &_Query_Loop)Modernize:_(FUNCTION_exp)_=>_#'exp
				    !* Loop asking about this stuff	!



!Modernize Old CATCH/THROW References:! !S CATCH/THROW => *CATCH/*THROW !

@:i*| :s(CATCH(THROW(	    !* Search for (CATCH or (THROW	!
      fkc )|,(		    !*  and hop back over it		!
@:i*| .[0[1 1f[noquitw c @fll	    !* Insert missing star		!
      <:@fll 1a-;:@; l> @fll	    !* Pas first arg			!
      :@fll 1a-;"e !"! :i*CH;	Can't_hack_comment fserr '
      @m(m.m ^R_Transpose_Sexps)   !* Interchange			!
      -2@fll !"! i' q0+1j i*	    !* Back up and quote arg1		!
       			    !* Go to top of S-Expression	!
    |) !"<! m(m.m &_Query_Loop)Modernize:_(CATCH/THROW_form_tag)_=>_(*CATCH/*THROW_'tag_form)
				    !* Loop asking about this stuff	!



!Modernize QUOTE References:! !S Change (QUOTE form)  =>  'form	!

@:i*| :s(QUOTE( fkc )|,(	    !* Search for (QUOTE		!
@:i*| .[0 fll 1f[noquitw -d	    !* Go kill ending paren		!
      q0j 6d @f_
	k  !* Kill (QUOTE & whitespace		!
      .u0 !"! i' 2r		    !* Insert #'			!
      m(m.m &_XLISP_Indent_SEXP)   !* Re-Indent S-Expression		!
       			    !* Go to top of S-Expression	!
    |) !"<! m(m.m &_Query_Loop)Modernize:_(QUOTE_exp)_=>_'exp
				    !* Loop asking about this stuff	!



!Modernize LAMBDA References:! !S Change '(LAMBDA ...)	=> #'(LAMBDA ...) !

@:i*| !"! :s#'(LAMBDA( fkcc )|,( !* Search for '(LAMBDA		!
@:i*| i# r m(m.m&_XLISP_Indent_SEXP)
    |) !"<"! m(m.m &_Query_Loop)Modernize:_'(LAMBDA_...)_=>_#'(LAMBDA_...)
				    !* Loop asking about this stuff	!


!Modernize MAP References:! !S Change (MAPxxx '... ...) => (MAPxxx #'... ...)!

@:i*| [0<:s(MAP"e 0'		    !* Look for MAP, fail if none	!
         .-4u0			    !* Remember place we started from	!
         1a:"b @fll '		    !* Go to end of printname if not MAP!
         @f_	
l	    !* Move to beginning of next object	!
         !"! 1a-'"e q0j -1 '> 
    |,(				    !* If just singlequote, win		!

@:i*| c @fll !"! s' r i# r m(m.m&_XLISP_Indent_SEXP)
  |) !"<"! m(m.m &_Query_Loop)Modernize:_(MAPx_'fun_...)_=>_(MAPx_#'fun_...)


!Modernize Strings:! !S Search for things in |...| => "..."!

@:i*~ :s/|"e 0' r -1 ~,(	    !* Look for |			!
@:i*~ 1f[noquit		    !* Defer interrupts			!
      f[vbwf[vz		    !* Bind buffer bounds		!
      !"! 0,0a-'"e -d '	    !* Maybe delete singlequote		!
      .,( s/| -d . )fsbound	    !* Narrow bounds			!
      j d <.-z; 1a-/"e c'	    !* Loop, skip slashed things	!
	   "# 1af"|!'!:"l i/ '' !* Slashify " or |			!
           c >			    !* Move forward			!
      j i"!'! zj i"!'! j	    !* Insert Doublequotes		!
      			    !* Return				!
    ~) !<! m(m.m &_Query_Loop)Modernize:_|...|_=>_"..." !''!

!Lowercase Lisp Buffer:! !S Lowercase a buffer of lisp text
respecting things that should not get lowercased.!

[S				    !* State Register			!
j 0uS				    !* Initial state 0			!
< .-z;				    !* Stop at end of virtual buffer	!
  qS"e 1af"|!'!:"l 1auS ' '	    !* Complement state on | or "	!
    "# 1a-qS"e 0uS ' '		    !*  Unless in a | or " already...	!
  qS"e 1 fc '			    !* Force case if appropriate	!
  1a-/"e c '			    !* Slash says skip next char	!
        "# 1a-;"e :s"ezj'''    !* Handle comments			!
  :c				    !* Go forward			!
>				    !* Loop				!
j z				    !* Set region around text changed	!
h				    !* Return				!


!Uppercase Lisp Buffer:! !S Uppercase a buffer of lisp text
respecting things that should not get uppercased.!

[S				    !* State Register			!
j 0uS				    !* Initial state 0			!
< .-z;				    !* Stop at end of virtual buffer	!
  qS"e 1af"|!'!:"l 1auS ' '	    !* Complement state on | or "	!
    "# 1a-qS"e 0uS ' '		    !*  Unless in a | or " already...	!
  qS"e 1 @fc '		    !* Force case if appropriate	!
  1a-/"e c '			    !* Slash says skip next char	!
        "# 1a-;"e :s"ezj'''    !* Handle comments			!
  :c				    !* Go forward			!
>				    !* Loop				!
j z				    !* Set region around text changed	!
h				    !* Return				!


!Lowercase Lisp Region:! !S Lowercase a region of Lisp text!

f[vbf[vz			    !* Bind buffer bounds	!
.,(w.)f fsbound		    !* Narrow bounds		!
m(m.m Lowercase_Lisp_Buffer)	    !* Call aux macro		!


!Uppercase Lisp Region:! !S Uppercase a region of Lisp text!

f[vbf[vz			    !* Bind buffer bounds	!
.,(w.)f fsbound		    !* Narrow bounds		!
m(m.m Uppercase_Lisp_Buffer)	    !* Call aux macro		!


!Change LAMBDA Combination to LET:! !& The name says it, man...!

[0[1[2				    !* Bind temp qregs		!
[L[A				    !* Buf for Lambda and Args	!
f[noquit			    !* Bind fsnoquit		!
g( flx*( f[bbind ) ) q..OuL	    !* Get it in temp buffer	!
j fll -d j d fll		    !* Strip outer parens	!
g( zfx*( f[bbind ) ) q..OuA	    !* Get args in qA buffer	!
j qLu..O			    !* Go back to Lambda	!
j c 1a-l"e @flk ilet '	    !* make lambda -> let      	!
          "# @flk iLET '	    !* or   LAMBDA -> LET	!
s( r flfsbound		    !* Narrow to just formals	!
j c .,(z-1)fsbound		    !* Don't count parens either!
< < @f_
	k	    !* Kill white space		!
    0,1a-;"e l' "# 0; ' >	    !* Skip comments		!
  .-z;				    !* Stop if no more formals	! 
  qAu..O			    !* Go to args buffer	!
  < @f_
	k	    !* Jump leading whitespace	!
    0,1a-;"e l' "# 0; ' >	    !* Skip comments		!
  3 f~NIL"e 0,4a"b 3di() 2r ''   !* Convert NIL to ()	!
  2 f~()"e			    !* If we have a (),		!
    2d -@f_	k	    !*  Kill it and whitespace	!
    @f_	k		    !*   both forward and back	!
    0,1a-;"e l'		    !*  Maybe take comments	!
    g( b,.fx*( qLu..O @fll ) ) i_' !*  Get any comments in LET	!
  "#				    !* Else,			!
    1:<@fll>"n
      :i*TFA	Too_Few_Actual_Args fserr '
    @f_	l		    !*  Go across arg and space	!
    0,1a-;"e l '		    !*  Take comment if any	!
    g( b,.fx*( qLu..O i( @fll i_))!*  Insert ( & jump formal	!
    i)_'			    !*  close arg field		!
   >				    !* Loop			!
zj				    !* Jump to end of arglist	!
qAu..O @f_
	k	    !* Kill whitespace forward	!
0,1a-;"e g( hfx*( qLu..O i_ ) ) '!* Get trailing comments	!
        "# .-z"e qLu..O ' 
	      "# :i*TMA	Too_Many_Actual_Args fserr ''
zj -@f_	k		    !* Delete trailing space	!
0,(fsz)fsboundw		    !* Widen buffer bounds	!
1 fsnoquit			    !* Turn off interrupts	!
qAu..O f]bbind			    !* Kill arg buffer		!
g( hfx*( f]bbindw flk ) )	    !* Get it back		!
-@fll @m(m.m &_XLISP_Indent_SEXP)  !* Indent this S-Expression	!
				    !* Return			!


!Modernize LAMBDA Combinations:! !S Change ((LAMBDA ...)...) => (LET (...)...)!

@:i*| :s((LAMBDA(fkc)|  ,( 
m.m Change_LAMBDA_Combination_to_LET (
) ) m(m.m &_Query_Loop)LAMBDA_Combinations:_((LAMBDA_...)_...)_to_(LET_(...)_...)


!Modernize NIL Occurrences:! !S Change NIL to ()!

@:i*| :sNIL( fkcc ) |,(
@:i*| 3d i() |) m(m.m &_Query_Loop)NIL:_NIL_=>_()


!& XLISP Indent Sexp:! !& Like ^R Indent SEXP but tries not to err out!

[0				    !* Push q0			   !
.( 1:<@fll>w .u0 )j		    !* Find end of SEXP		   !
.( 1:<:fll>w .-q0"g )j 0' 	    !* See if next list is farther !
   0,1a-("n )j 0'		    !* Don't fill if no close paren!
 )j				    !* Resume state and proceed	   !
]0				    !* Pop q0			   !
f:m(m.m ^R_Indent_Sexp)	    !* Jump to ^R Indent SEXP	   !


!Change / to \:! !S Update buffer for the new Lisp backslash syntax!

j @f
l			    !* Jump over blank lines		!
1:fb-*-"e			    !* If there's no file prop list	!
  i;;;_-*-_Mode:_Lisp;_-*- 
    !*  Make a default one		!
  js-*-'			    !* Search for start of -*-		!
1:fbEscape:"e			    !* If no escape marked		!
  i_Escape:_Slash;'		    !*  Make a default setting		!
"# :fwl				    !*  Go to head of field		!
   .,(s;-:fwl.)f~slash"n	    !*  Compare escape char with slash	!
     :i*CBuffer_not_using_slash_escape_charfsechodisplay
     0fsechoactive l 0,.( j )''  !*  Maybe return early		!
				    !*					!
[S				    !* State Register			!
j 0uS				    !* Initial state 0			!
< .-z;				    !* Stop at end of virtual buffer	!
  qS"e 1af"|!'!:"l 1auS ' '	    !* Complement state on | or "	!
    "# 1a-qS"e 0uS ' '		    !*  Unless in a | or " already...	!
  qS"e				    !* Only outside of |s or "'s	!
    1a-;"e :s"ezj'  oLoop''   !*  Ignore commented stuff		!
  1a-\"e i\           oLoop'    !*  Make \ quote itself		!
  1a-#"e 			    !* Skip #				!
    2a-/"e 2c'		    !*  #/ is as before			!
    2a-\"e 2c'	 oLoop'    !*  #\ is as before			!
  1a-/"e 0,2a-/"e d'	    !* // goes to /			!
	           "# f\'	    !* / goes to \ otherwise		!
	   c	         oLoop'    !*  Update display and loop		!
  !Loop!			    !* Come here to continue looping	!
  :c				    !* Go forward			!
>				    !* Loop				!
j s-*- sEscape: :fwl		    !* Kill old escape info		!
  iBack			    !* Say we are using Backslash now	!
:i*CConversion_of_/_to_\_complete.Afsechodisplay 0fsechoactive
j z				    !* Set region around text changed	!
h				    !* Return				!


!Interchange slash and backslash:! !S Swap slash and backslash !

j
@:i*| :< :s57"e zj 0;' 0,-2a:"d 0,-2a:"a 0,1a:"d 2r 0;''' > .-z | ,(
@:i*| 2d i#// | (
) ) m(m.m &_Query_Loop)Change_/_to_\:__Maybe_change_octal_57_to_#//

j
@:i*| :< :s47"e zj 0;' 0,-2a:"d 0,-2a:"a 0,1a:"d 2r 0;''' > .-z | ,(
@:i*| 2d 0,1a-."e d' i#// | (
) ) m(m.m &_Query_Loop)Change_/_to_\:__Maybe_change_decimal_47_to_#//

j
@:i*| :< :s#o57"e zj 0;' 0,1a:"d 0;' > .-z | ,(
@:i*| 2d i#// | (
) ) m(m.m &_Query_Loop)Change_/_to_\:__Maybe_change_#o57_to_#//

j
@:i*| :s slash  | ,(
@:i*| 5r -4 f~BACK"e -4d '
		    "# 1a-s"e iback'
			     "# 2a-L"e iBACK'
				      "# iBack fs''' 5c | (
) ) !""""! m(m.m &_Query_Loop)Change_/_to_\:__Maybe_interchange_``slash''_and_``backslash

j z
h
