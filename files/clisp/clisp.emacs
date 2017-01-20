!~Filename~:! !The Teco half of the Common Lisp Emacs system!
CLISP

!& Setup CLISP Library:! !S Set up CLISP variables, run CLISP Setup Hook and
execute any JCL given.!

   [0[1
   0 m.v CLISP_Return_to_Superior  !* <>0 to exit upwards !

   FS LispT"N			    !* If Started by Superior on TOPS-20, !
      :iEditor_Type CLISP	    !* Set Editor Type to CLISP. !

      f[D File			    !* Save Teco Default Filename. !
      qBuffer_Nameu0		    !* Save current Buffer's Name. !
      [Previous_Buffer
      m(m.m Select_Buffer) *CLISP* !* Select or Create *CLISP* Buffer. !
      m(m.m CLISP_Mode)	    !* Put *CLISP* Buffer in CLISP Mode. !
      m(m.m Select_Buffer) 0    !* Restore previous Buffer. !
      ]Previous_Buffer

      :i*fo..q CLisp_Mode_Hooku0   !* Get old value of hook into q0 !
      @:i*| m(m.m&_CLISP_Enter_CLisp_Mode) | u1 !* Build our insertion !
      @:i*|01| m.v CLisp_Mode_Hook !* Append to hook !

      m.m &_CLISP_FS_Superiorfs Superior !* Set up fs Superior !

      :i*fo..q Return_from_Superior_Hooku0 !* Get old hook if any !
      @:i*| m(m.m &_CLISP_Return_from_Superior) | u1
      @:i*|01| m.v Return_from_Superior_Hook
				    !* Upon return, execute JCL. !

      :i*fo..q Exit_to_Superior_Hooku0
      @:i*| m(m.m &_CLISP_Return_to_Superior) | u1
      @:i*|01| m.v Exit_to_Superior_Hook

      :i*fo..q Exit_Hooku0	     !* Get old hook if any !
      @:i*| m(m.m&_CLISP_Exit_Emacs) | u1 !* Get our appendix !
      @:i*|01| m.v Exit_Hook

      !* Change function to Return to Superior !
      m.m ^R_CLISP_Return_to_Superior m.v MM_^R_Return_to_Superior
      m.m ^R_Return_to_Superior u:.X() !* Set vanilla keybinding !


      0fo..q CLISP_Setup_Hooku1    !* See if Setup Hook defined. !
      fq1"g m1'			    !* If so, run it!

      M(M.M&_CLISP_Execute_JCL)'   !* then execute any JCL it passed. !

   				    !* Return. !

!& CLISP FS Superior:! !S Fs Superior for CLISP library.!

   :"l ,0i 100100.fs Exit'   !* Pos arg, get that big buffer !
   fs OSTeco"e fs %oplsp"n 1,m.m LISPT_Command"E !* ITS stuff !
       m(m.m Load_Library)DSK:EMACS;LISPT'''
   "l [1 0[2 f[ B Bindfj	    !* Neg arg, get JCL !
       j :s,"l .,(:l).x2'	    !* post-comma is TECO code !
       j :s,"l r :k'		    !* Flush it !
       hx1			    !* Get rest in q1 !
       f] B Bind
       fq1"g			    !* Got a file name? !
          f~1nil"n		    !* Which is non-NIL !
          0fo..q Tags_Find_File"e
	      1,M(M.M Visit_File)1'	!* Visit !
	    "# m(m.m Find_File)1'''  !* or Find it !
       fq2"g m2'		    !* Any code? Macro it !
       ]2]1'
   100100.fs Exit		    !* And exit !

!& CLISP Enter CLisp Mode:! !S This places a few things on keys in CLisp mode.
   M-Z	     ^R Evaluate Defun
   M-Space   Evaluate Region
   C-M-S     ^R CLISP Find Function
   M-.       Edit Definition
In order to do this, a private copy of .X is created.!

   m.m &_CLISP_Compile_Command m.l Compile_Command !* New Compile Command !
   m.m ^R_Evaluate_Defun m.q ..Z       !* M-Z !
   m.m Evaluate_Region m.q .._	   !* M-Space !
   m.m ^R_CLISP_Find_Function m.q ...S  !* C-M-S !
   m.m Edit_Definition m.q ...	   !* M-. !
   fq.x fs q vector[..o
     g.x q..o m.q.x                 !* Local copy of .x !
   ]..o


!CLisp Mode:! !Common Lisp Mode:! !C Set things up for editing Common Lisp.
Puts ^R Indent for LISP on Tab, puts tab-hacking rubout on Rubout.
Paragraphs are delimited only by blank lines.!

    M(M.M &_Init_Buffer_Locals)    !* See comment at top of file.!
    fqBuffer_Filenames:"g	    !* If we have no file, !
       f6 CLISP fs D FN2'	    !* set default filetype to CLISP !
    M.M ^R_Indent_for_Lisp  M.Q I
    1,1M.L Space_Indent_Flag
    1,Q(1,Q. M.QW )M.Q .  !* Exchange rubout flavors.!
    1,56 M.L Comment_Column
    1,(:I*;) M.L Comment_Start
    1,(:I*) M.L Paragraph_Delimiter
    1,3m.l Display_Matching_Paren
    QPermit_Unmatched_Paren"L
      1,0M.LPermit_Unmatched_Paren'
    1,1m.l Lisp_WHEN_Indent
    1,2m.l Lisp_IF_Indent
    1,1m.l Lisp_UNLESS_Indent
    1,1m.l Lisp_CATCH_Indent
    1,1m.l Lisp_THROW_Indent
    1,1m.l Lisp_CONDITION-BIND_Indent
    1,2m.l Lisp_DO*_Indent
    1,1m.l Lisp_FLET_Indent
    1,1m.l Lisp_LABELS_Indent
    1,1m.l Lisp_TYPECASE_Indent
    1,1m.l Lisp_WITH-KEYWORDS_Indent
    1,1m.l Lisp_WITH-OPEN-FILE_Indent
    1,1m.l Lisp_WITH-OPEN-STREAM_Indent
    1,1m.l Lisp_WITH-OUTPUT-TO-STRING_Indent
    1,1m.l Lisp_WITH-INPUT-FROM-STRING_Indent
    1,1m.l Lisp_MULTIPLE-VALUE-CALL_Indent
    1,2m.l Lisp_MULTIPLE-VALUE-BIND_Indent
    1,2m.l Lisp_MULTIPLE-VALUE-SETQ_Indent
    1,1m.l Lisp_DO-MOST-SYMBOLS_Indent
    1,1m.l Lisp_DO-ALL-SYMBOLS_Indent
    1,1m.l Lisp_DO-SYMBOLS_Indent
    M.Q ..D
    0FO..Q CLisp_..D F"N U..D'	    !* Select the CLisp syntax table!
      "# W :G..D U..D		    !* creating it if doesn't exist.!
	Q..D M.V CLisp_..D
	-1[1 32< %1*5+1:F..D A>
	9*5+1:F..D_
	!"""""! 1M(M.M &_Alter_..D) || "| \/ '' `' ,' @' #' [A]A {A}A  
_ _'
    1M(M.M&_Set_Mode_Line) CLISP 

!& CLISP Mode:! !S Sets Lisp mode for .CLISP files!

   :m(m.m CLisp_Mode)

!& CLISP Return from Superior:! !S Do necessary stuff!
   
   0m.v CLISP_Return_to_Superior   !* Not going to superior, we think !
   m(m.m &_CLISP_Handle_Retval)    !* On return, handle return value !
   qCLISP_Old_Buffer_Name[1	    !* Get old buffer name !
   m(m.m Select_Buffer)1 ]1	    !* go there !
   qPrevious_Bufferfo..q CLISP_Old_Previous_Buffer m.v Previous_Buffer
   m(m.m&_CLISP_Execute_JCL)	    !* and do whatever !


!& CLISP Return to Superior:! !S Do necessary stuff!

   f~Buffer_Name *CLISP*"n
     qBuffer_Namem.v CLISP_Old_Buffer_Name
     qPrevious_Buffer m.v CLISP_Old_Previous_Buffer
     m(m.m Select_Buffer) *CLISP*'
   z-b"e 1m.v CLISP_Return_to_Superior'    !* Null buffer, so throw up !

   :FR				    !* Clear Mode Line. !
   :I*Z FS Echo Display	    !* Put cursor at bottom of screen. !
   0 FS Echo Char		    !* Dont echo when continued. !


!^R CLISP Return to Superior:! !^R Go back to EMACS's superior job.
Run Exit to Superior Hook before Exit Hook, hope it works.
With argument, saves visited file first.
Otherwise, does auto save if auto save mode is on.
Runs Exit Hook (if any) going out,
and Return from Superior Hook coming back.!

    0FO..Q Exit_to_Superior_Hook[1
    Q1"N M1'
    FM(M.M &_Exit_EMACS)	    !* Clear mode line, auto save, etc.!
    100000.FS EXIT
    0FO..Q Return_from_Superior_Hook[1
    Q1"N M1' 

!& CLISP Exit Emacs:! !S Exit from %emacs-top-level if CLISP Return from
Superior is nonzero.!

   0fo..q CLISP_Return_to_Superior"e '   !* Are we going to throw up? !
   m..f				    !* Yes, better run secretary macro !
   f~Buffer_Name *CLISP*"n	    !* And maybe save old buffer name!
      qBuffer_Name m.v CLISP_Old_Buffer_Name
      qPrevious_Buffer m.v CLISP_Old_Previous_Buffer
      m(m.m Select_Buffer)*CLISP*'
   hk
   i(throw_(quote_user::exit-emacs)_t)



!& CLISP Execute JCL:! !S Run on TOPS-20 when Emacs continued by Lisp.
If there is JCL from CLISP, then execute it.  Otherwise do nothing.!
 1:@< 
   [0 [1			    !* Save Q Registers 0 & 1. !
   f[B Bind			    !* Save Buffer. !
   fj				    !* Get JCL into Buffer. !
   hx0				    !* Put JCL into Q Register 0. !
   f]B Bind			    !* Restore Buffer.  Do it before we execute
				       the JCL as the JCL may switch Buffers. !
   fs XJName u1		    !* Put Name from JCL into Q Register 1. !
   f~1CLISP "e m0 '		    !* Execute JCL only if for CLISP. !
   ]1 ]0 >			    !* Restore Q Registers 0 & 1. !
   				    !* Return. !

!^R CLISP Find Function:! !^R Find Function in Buffer.
This function will find a Lisp Function in the buffer, repeatedly searching
greater and greater portions of the File centering its search about an
approximate location of the Function.  This function will search for a string
of the form ^J, ^M, or ^L followed by "(DEFUN <Function Name> " or "(DEFMACRO
<Function Name> ".  If called from ^R Mode, the function will prompt for a
function name.  The format of the Teco call is:

<Approximate Location>M(M.M & CLISP Find Function)<Function Name>

If no <Approximate Location> is given or if the function is called with more
than one argument, then the entire file is searched starting from the
beginning. !

   .[0				    !* Save Point in Q Register 0. !
   FS VB[1			    !* Save Virtual B in Q Register 1. !
   FS VZ[2			    !* Save Virtual Z in Q Register 2. !
   0 FS VB			    !* Expand to search entire file. !
   0 FS VZ			    !* Expand to search entire file. !
   1,FFind_Function:_[3	    !* Put Function Name in Q Register 3. !
   FF-1"E			    !* Execute if exactly one argument... !
      F[4			    !* Save center of search in Q Register 4. !
      1000[5			    !* Radius in Characters to search. !
      <Q4-Q5:J;			    !* Start of this pass of search. !
         <.,Q4+Q5 :FB(defun_3_(defmacro_3_; !* Search for Function !
						       !* or Macro, !
	    13,FKA F_
"G 0l
	       m(m.m ^R_Reposition_Window)'> !* returning if found. !
         Q5*3U5>		    !* Search 3 times as far on next pass. !
      ]5 ]4 '			    !* Restore Registers. !
				    !* No Luck -- Search Entire File. !
   J				    !* Start at beginning of Buffer. !
   <:S(defun_3_(defmacro_3_;	!* Search for Function or Macro, !
      13,FKA F_
"G 0l
         m(m.m ^R_Reposition_Window)'> !* returning if found. !
				    !* Error if unable to find Function. !
   Q2 FS VZ			    !* Restore Virtual Z. !
   Q1 FS VB			    !* Restore Virtual B. !
   Q0 J				    !* Restore Point. !
   :I*FNF	Unable_to_find_function_3  FS Err
   				    !* Return and Print Error Message. !

!& CLISP Save Region:! !S Stores Region between Mark and Point to be returned to Lisp.
The Region is appended to the contents of the *CLISP* Buffer.  A pair of
arguments may be given instead of the Mark, if called from a Teco program. !

    F[VB F[VZ			    !* Save Virtual Bounds. !
    FF"E :,.' "# F' F  FS Boundaries   !* Bind them to the Region. !
    Q..O[3			    !* Save Region in Q Register 3. !
    Q:.B(:I* *CLISP* M(M.M &_Find_Buffer)+4) [..O
				    !* Select *CLISP* Buffer. !
    ZJ				    !* Make sure pointer at end of Buffer. !
    G3				    !* Insert Region into *CLISP* Buffer. !
    0				    !* Nothing changed in Buffer. !
    				    !* Restore Everything and Return. !

!^R CLISP Save DEFUN:! !^R Stores the Top Level List the Point is in to be returned to Lisp.
If the Point is between Lists, the following List is stored.!

   .(
    M(M.M ^R_CLISP_Mark_Defun)	    !* Mark List. !
    M(M.M &_CLISP_Save_Region)	    !* Save it. !
   )j
    				    !* Return. !

!^R CLISP Mark Defun:! !^R Put point and mark around this defun (or next).!
    .:			    !* Leave mark behind at starting point, for loss recovery!
    .[1
    :-S				    !* Find previous CRLF(.!
("L L'			    !* If find it, go to before the (.!
      "# 1-.+BA-("E J'	    !* If none, ( at beginning of buffer counts as one.!
         "# J O Bufbeg''	    !* If we are before the first ( on column 0, go down to 1st.!
    FL +.-Q1"L			    !* If we weren't within that defun, we were!
 !Bufbeg!
      :S			    !* between defuns, so find start of following one.!
("L 0L''
    .( @FLL L .: )J		    !* Mark line after the one containing the ) of the defun.!
    < B-.; -L  -(:F  );	    !* Move back past one blank line, but stop at buffer beg!
      @F	_R 1A-;"N L0;'   !* and don't move back over any non-comment line.!
      >
    0

!^R CLISP Zap to Lisp:! !^R Returns (things) to Lisp.
If called with no argument, zaps *CLISP* buffer and goes to Lisp.
If called with non-zero argument, just zap *CLISP* buffer to Lisp.
If called with zero argument, just goes to Lisp, discarding all zaps.!

    0[0
    ff"n u0 q0"n		    !* Not Zero argument !
       q:.b(:i* *CLISP* m(m.m &_Find_Buffer)+4) [..o
				    !* Select *CLISP* Buffer. !
       bj i(values_
				    !* Put it all in a progn !
       zj ff"e i(throw_(quote_user::exit-emacs)_nil) ' !* No argument !
       i)

       0m.v CLISP_Return_to_Superior  !* Dont return hard way !
       ''
    m(m.m ^R_Return_to_Superior)
    

!& CLISP Handle Retval:! !S Get return value from Lisp
into q$CLISP Lisp Value$!


   q:.b(:i* *CLISP* m(m.m &_Find_Buffer)+4) [..o
   bj
   .(1@fll),.k @f
k zj -@f
k
   hfx*m.v CLISP_Lisp_Value
   0fsXModified0fsModified


!Evaluate Buffer:! !C Evaluate buffer in Lisp!

   q..o[3
   q:.b(:i* *CLISP* m(m.m &_Find_Buffer)+4) [..o
   zj
   g3
   ]..o
   1m(m.m ^R_CLISP_Zap_to_Lisp)
   fqCLISP_Lisp_Value"g
      qCLISP_Lisp_Value[1
      :ft1
'
   

!Evaluate Region:! !C Evaluate region in Lisp.
If given an argument, only saves the region, for later zap.!

   m(m.m &_CLISP_Save_Region)
   ff"e			    !* Without argument, zap it !
      1m(m.m ^R_CLISP_Zap_to_Lisp)
      fqCLISP_Lisp_Value"g
         qCLISP_Lisp_Value[1
	 :ft1
'
      '
   

!Evaluate Region into Buffer:! !C Evaluate region, inserting result into buffer!
   m(m.m &_CLISP_Save_Region)
   1m(m.m ^R_CLISP_Zap_to_Lisp)
   fqCLISP_Lisp_Value"g
      gCLISP_Lisp_Value
      i
'
   

!Evaluate into Buffer:! !C Evaluate a Lisp expression into buffer at point.!

   1,fEvaluate_into_Buffer:_[1
   fq1"g
      q:.b(:i* *CLISP* m(m.m &_Find_Buffer)+4) [..o
      hk
      g1
      ]..o
      1m(m.m ^R_CLISP_Zap_to_Lisp)
      fqCLISP_Lisp_Value"g
         gCLISP_Lisp_Value'
      '
   

!Evaluate Expression:! !C Evaluate a Lisp expression.!

   1,fEvaluate_Expression:_[1
   fq1"g
      q:.b(:i* *CLISP* m(m.m &_Find_Buffer)+4) [..o
      hk
      g1
      ]..o
      1m(m.m ^R_CLISP_Zap_to_Lisp)
      fqCLISP_Lisp_Value"g
         qCLISP_Lisp_Value[1
	 :ft1
'
      '
   


!^R Evaluate Defun:! !^R Evaluates the Top Level list the point is in, in Lisp.
If the point is between lists, the following list is evaluated.
If called with an argument, only saves the defun for later zap.!

   m(m.m ^R_CLISP_Save_Defun)
   ff"e			    !* No argument, zap it !
      1m(m.m ^R_CLISP_Zap_to_Lisp)
      fqCLISP_Lisp_Value"g
         qCLISP_Lisp_Value[1
	 :ft1
'
      '
   

!Edit Definition:! !C Edit the definition of a function.
Tries to find the source file of a compiled function, or the definition
of an interpreted function.!

   [v
   1,fEdit_Definition:_[s
   q:.b(:i* *CLISP* m(m.m &_Find_Buffer)+4) [..o
   hk
   i(progn_(format_t_"~a"_(emacs::get-definition_(quote_s)))_(values))
!''!
   ]..o
   1m(m.m ^R_CLISP_Zap_to_Lisp)
   fqCLISP_Lisp_Value"g
     f[BBind gCLISP_Lisp_Value
	      z-3"g z-3,zf~nil"e zj -3d''
     hxv f]BBind
     f~vnil"e @ftNo_definition_for_s,_sorry.
	       0fs Echo Active'
            "# qs,qv m(m.m &_CLISP_Edit_Definition) ''
     "# @ftNo_definition_of_s,_sorry. 0fs Echo Active'
   

!& CLISP Edit Definition:! !S Found a definition, get file or buffer.
Precomma arg is function to edit, postcomma is definition (file or
Lisp code).!

   [s [v
   f[BBind
   gv bj 1a-42."e 1d
      zj 0a-42."e -1d		    !* Delete doublequotes around def !
      bj :s::"n b,.k'		    !* Kill host name if any !
      hxv''
   hk
   gs bj :s:::"n .-1"n b,.k	    !* Delete package name !
			  hxs''
   f]BBind
   f[Dfile
   e?v"e f]Dfile		    !* Is it a file? !
            m(m.m Find_File)v   !* Find it !
	    m(m.m ^R_CLISP_Find_Function)s'
	 "# f]Dfile
	    m(m.m Select_Buffer)*Definition_of_s* !* Else get it !
	    hk gv bj m(m.m CLISP_Mode)' !* in a buffer !


!& CLISP Compile Command:! !S Compile Command for CLISP.!

   q:.b(:i* *CLISP* m(m.m &_Find_Buffer)+4) [..o
   hk
   i(compile-file_"1"!''!
   fq4"g i  g4' i)

   ]..o
   1m(m.m ^R_CLISP_Zap_to_Lisp)
   fqCLISP_Lisp_Value"g
      qCLISP_Lisp_Value[1
      :ft1'
   

!Set Package:! !C Set current package to string arg.
Zaps an (in-package <foo>) expression to Lisp.!

   1,fSet_Package:_[1
   fq1"g
       m(m.m &_Set_Package)1
       @ftUpdate_attribute_line_as_well
       1m(m.m &_Yes_or_No)"n
         1,m(m.m Update_Attribute_Line)1''
   

!& Set Package:! !& The work routine of Set Package.!

   f[1
   q:.b(:i* *CLISP* m(m.m &_Find_Buffer)+4) [..o
   hk
   i(in-package_(quote_1))

   ]..o
   1m(m.m ^R_CLISP_Zap_to_Lisp)
   

!Update Attribute Line:! !C Update the -*-Mode:<foo>; Package:<bar> -*- line.
With precomma arg 1, reads package from string arg, otherwise from Lisp.!

    [1 0[2 .[P fn 1:<qPj>
    ff-2"e			    !* 1, as argument? !
       1,fPackage:_u2'	    !* Read package !
    j
    @F	_
R				    !* Move over blank lines !
    :fb-*-"l			    !* First nonblank line starts with -*- !
       .,(fb-*- fkc.)k i_'	    !* Kill stuff between -*-s !
       "# i 
i 2r	    !* Else make a -*- pair !
          qComment_Startu1
	  q1"e :i0;;;_'
	  0fo..qComment_Beginf"n u1'
	  f=1;"e :i*;;;_u1'	    !* Try to do it pretty !
	  g1 i-*- i_-*- fkc
	  .( qComment_End"n gComment_End)j''
    i_Mode: gMode		    !* Get mode !
    fs LispT"n			    !* Under Lisp? !
       f~ModeCLISP"e		    !* In CLISP mode? !
         i;_Package:		    !* Get package too !
	 .u1
	 q2"e m(m.m Evaluate_into_Buffer)(package-name_*package*)'
	   "# g2'
	 q1j :s""n fkd :s""n fkd'''' !* Remove quotes !
    

!Reparse Attribute Line:! !C Reparse the -*-<foo>-*- line for Mode & Package.
Sets Mode and Package from the -*-Mode:<Mode>; Package:<Package>-*- line.!

    [1 .[P fn 1:<qPj>
    j
    @F	_
R
    :FB -*-"L			    !* If 1st nonblank line contains "-*-", then!
      .U1 1:FB:-*-+2"E FKC Q1,.X1'!* it might be old style "-*-Lisp-*-", or!
          "# Q1J :FBMode:"L	    !* New style and contain "Mode: Lisp,"!
	     .,(FB;-*- FKC.)X1'' !* In either case, put mode name in Q1.!
      FQ1"G f~Mode1"n	    !* If we are not already in foo mode, !
           M(M.M 1_Mode) 1U5''   !* select mode foo.!
      fs LispT"n		    !* Under a Lisp? !
       f~ModeCLISP"e		    !* And in Clisp mode? !
         :fbPackage:"l		    !* Specified package? !
	    .,(fb;-*- fkc.)x1    !* Get package name !
	    fq1"g m(m.m &_Set_Package)1''''' !* And set it !
    
    

!& CLISP Process File Options:! !S Set mode and local vars from file.
Select the mode specified at the front of the loaded file,
and if it's last page specifies local variable values,
set them up.!
    [0 [1 [2 [3 [4 .[P  fn qPj
    0[5				    !* Q5 is nonzero if major mode has been set.!
    0[6				    !* No old or new string vars seen in lcl modes list.!
  1@:< J
    FS OS TECO"N		    !* If on 10X or 20X,!
      :FB EDIT_BY_"L		    !* and if it appears to have an edit history,!
        <L 1A-;"N 1;'>''	    !* move over comment lines!
      @F	_
R
    :FB -*-"L			    !* If 1st nonblank line contains "-*-", then!
      .U1 1:FB:-*-+2"E FKC Q1,.X1' !* it might be old style "-*-Lisp-*-", or!
          "# Q1J :FBMode:"L	    !* New style and contain "Mode: Lisp,"!
	     .,(FB;-*- FKC.)X1'' !* In either case, put mode name in Q1.!
      FQ1"G M(M.M 1_Mode) 1U5'   !* select mode foo.!
      fs LispT"n		    !* Under a Lisp? !
         f~ModeCLISP"e	    !* And in Clisp mode? !
	   :fbPackage:"l	    !* Specified package? !
	     [1
	     .,(fb;-*- fkc.)x1   !* Get package name !
	     fq1"g m(m.m &_Set_Package)1' !* And set it !
	     ]1''''
    FS OS TECO"N Q5"E 		    !* If on 20X and didnt set a major mode at all,!
      QBuffer_Filenames F[ DFILE !* use FN2!
      FS DFN2U1 FQ1"E :I1<Null>' 1,M.M&_1_ModeU0
      Q0"N M0W 1U5'		    !* Call & FOO Mode if it is defined!
      "# J @F_
L
         12 F~(FILECREATED"E	    !* Special hack to recognize interlisp files.!
           M(M.M Interlisp_Mode)W 1U5''''
    ZJ :Z,Z-10000FB		    !* Find the start of the last page,!
"E Z-10000"L J''		    !* or beg of file if file is short and no pages.!
    .-Z"N			    !* If we found one or the other,!
      :SLocal_Modes"L		    !* search for the start of them local vars.!
	Q5"E 1M(M.M &_Init_Buffer_Locals)  !* Flush all but permanent local variables.!
	     :IModeFundamental'
	.( FKC 0X0 )J		    !* Get the line prefix.!
	1A-:"E C'  :X1	    !* Get the line suffix.!

	128*5,32:i2		    !* Make a syntax table for parsing!
				    !* the string values.!
	*5:f2_/	    !* It thinks ^] is a Lisp escape.!
	"*5:f2_| !'!	    !* It thinks dquote is string delimiter.! 

	< L .-Z;		    !* Then look at each line for the local variable.!
	  FQ0 F~0"N !<!>'	    !* Ignore lines not starting with prefix.!
	  FQ0C 1A-15."E !<!>'	    !* Ignore blank lines, in case prefix is null.!
	  4 F~END:@;
	  .,( S: .-2,.+1F=::"E C'	    !* Scan over name of variable.  Win for ...:.!
	      ).-1X3		    !* Put name of variable or ^R character into Q3.!
	  .u6 @f	_l	    !* Skip over indentation to value.!
	  1a-34"e q2[..d	    !* Is it a quoted string value?!
	     .+1,(@fll).-1x4
	     ]..d
	     @:i4"4" !''!'
	  "# .( :\u4 )-."e q6-1j'   !* Read as number. If no digits, fake out test below.!
	     .,( :s1		    !* Did the digits, plus leading and trailing spaces,!
:w .)@f_	 "n	    !* account for everything on the line before the suffix?!
	        q6,.x4''	    !* If not, it is an old-fashioned string value.!
	  F~3 Mode"E
	    -[Initial_Local_Count !* But avoid flushing any locals we just made.!
	    M(M.M 4_Mode)
	    -1FS QP UNW
	    !<!>'
	  FQ3-2:G3-"E	    !* If the local name is a ^R character,!
	   M4 M(M.M Make_Local_Q)3 !<!>'	    !* Execute it to get the local value.!
	  Q4 M.L 3		    !* Make the var local.!
	  >
	-1U5''
    >(  !* Save the results of the errset.!
      !** Here, Q5 is positive if all we did is set the major mode,!
      !** in which case we already did & Set Mode Line.!
      Q5:"G M(M.M &_Set_Mode_Line)'
      )"E J '
    !"! @FT
    Error_processing_file's_mode_or_local_variables
     0FS ECHO ACT
    J 
