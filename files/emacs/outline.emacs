!* -*-TECO-*-
 This is MITCH's outline macros with slight changes by RICH further modified by DICK!

!~FILENAME~:! !Macros for building structured outlines.!
OUTLINE

!Outline Mode:! !C Sets up macros for Indent mode!
    M(M.M &_Init_Buffer_Locals)    
    M.M^R_Outline_Autoindent M.Q _
    M.M^R_Outline_Start_Level M.Q (
    M.M^R_Outline_Close_Level M.Q )
    M.M^R_Outline_Grind M.Q ..Q
    0M.L Auto_fill_mode
    0M.L Word_Abbrev_mode
    Q.0,1M(M.M &_Set_Mode_Line) Outline     

!^R Outline Start Level:! !C Starts new point!
[7				    !* 7 will hold min changed bound!
    M(M.M&_Outline_Continuation_Line)u7    !* first break line if you have to!
    M(M.M&_Indent_for_Outline)     !* then go to next line and indent!
    i( q7,.			    !* put in open delimeter and return changed bounds!

!^R Outline Autoindent:! !C Indent for Outline!
[7
    M(M.M&_Outline_Continuation_Line)u7    !* break line if you have to!
    i_ q7,.			    !* put in the blank!

!^R Outline Close Level:! !C End a point!
[7
    M(M.M&_Outline_Continuation_Line)u7    !* break line if you have to!
    i) q7,.f			    !* Insert ) and report to ^R.!
    1:< fs ^r paren"n m(fs ^r paren)' >   !* Maybe show matching paren.!
    0

!& Outline Continuation Line:! !S If line too long, breaks line.!
    [0 [1 [3 [4 .u1
    <.u0 (fshpos)-(qfill_column)u4
      (1-q4);			    !* if past fill column!
         q4r			    !* move back before it!
         -s_ d			    !* go back to first space and delete it!
         ., q0-1fx3		    !* save the tail of the line!
	 (q1-.)"g .u1'		    !* q1=(min q1 .)!
         M(M.M&_Indent_for_Outline)	    !* Indent line.!
         g3>			    !* Put tail back!
    q1

!& Indent for Outline:! !S Indent to proper place.!
    [0 [1 [2
      .u0			    !* Save where called!
      -:s()u1		    !* find nearest preceeding ( or )!
      q1"e 0u2'			    !* if there isn't one indentation is zero!
      1+q1"e (fshpos+4)u2'	    !* if it is ( indent 4 more than that!
      2+q1"e c -fll		    !* go back to matching open )!
           (fshpos)u2'		    !* use that indentation!
      q0j 1,@MM		    !* go back where you started and intsert a crlf!
      (q2/8)u1 q1,9i		    !* put in as many tabs as you can!
      (q2-(8*q1)),32i		    !* do the rest of the indentation with blanks!
    q0			    !* Q0 is earliest position altered!

!^R Outline Grind:! !C Grind section.
If the first non-blank character after point is ( then grind that section;
otherwise grind the section containing point, if there is one.!

    [0 [1
    <(-4-(:s_		    !* skip over any blank space!
                   ));>:s(    !* if the next char is ( skip over it!
        1:<-ful>		    !* go left up list if possible!
	0l .f[vb		    !* push & set boundaries!
	fsz-(fl) +.f[vz
	<:s
	    ;fkd 32i>		    !* eliminate all CRLF's replace them with blanks! 
	bj s( .u0		    !* go to the first ( in the vertual buffer!
	<:s	;-d 32i>	    !* change all tabs to blanks!
	q0j <:s__(_)_; -dr>    !* eliminate unneeded spaces!
	q0j <:s_(_); r -d>
	q0j <:s()_u1; r	    !* treat spaces and parens as if just typed!
		q1+1 "e M(M.M&_Outline_Continuation_Line) M(M.M&_Indent_for_Outline)'
		     "# M(M.M&_Outline_Continuation_Line)'w c>
	q0j <:s._?_!_; 32i>    !* put second space after .?!
    bj h			    !* exit at beginning of s-expr, redisplay everything!
