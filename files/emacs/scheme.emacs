!* -*-TECO-*- !

!~Filename~:! !Setup EMACS for editing Scheme code.!
SCHEME

!& Scheme Mode:! !Scheme Mode:! !C Set things up for editing Scheme code.
Similar to Lisp mode, but syntax is slightly different.
Loads the SCHEDIT library (similar to Ledit) and assigns keys.

Puts ^R Indent for LISP on Tab, puts tab-hacking rubout on Rubout.
Paragraphs are delimited only by blank lines.!

!* This is called & Scheme Mode because the Scheme Mode
function is an MM variable, and would shadow that name of this function.!

    M(M.M &_Init_Buffer_Locals)    !* Standard Major Mode init routine.!
    1m.vScheme_Library_Loaded
    :i*Scheme m.l Lisp_Indent_Language
    0m.v Scheme_Indentation_Hook
    m.m &_Standard_Lisp_Indentation_Hook uScheme_Indentation_Hook
    1m.v Scheme_Indent_DEFAnything
    2m.v Scheme_Special_Indent_Offset
    0m.v Scheme_Indent_Offset
    1m.v Scheme_LET_Indent
    1m.v Scheme_FLUID-LET_Indent
    1m.v Scheme_LAMBDA_Indent
    1m.v Scheme_NAMED-LAMBDA_Indent
    1m.v Scheme_MACRO_Indent
    2m.v Scheme_MAKE-PACKAGE_Indent
    1m.v Scheme_WITHIN-CONTINUATION_Indent
    1m.v Scheme_WITH-PRINTER-CHANNEL_Indent
    1m.v Scheme_PRINTING-TO-CHANNEL_Indent
    1m.v Scheme_LAMBDA-COMPONENTS_Indent
    1m.v Scheme_ASSIGNMENT-COMPONENTS_Indent
    1m.v Scheme_DEFINITION-COMPONENTS_Indent
    1m.v Scheme_OPEN-BLOCK-COMPONENTS_Indent
    1m.v Scheme_CLOSED-BLOCK-COMPONENTS_Indent
    1m.v Scheme_COMMENT-COMPONENTS_Indent
    1m.v Scheme_DECLARATION-COMPONENTS_Indent
    1m.v Scheme_COMBINATION-COMPONENTS_Indent
    1m.v Scheme_CONDITIONAL-COMPONENTS_Indent
    1m.v Scheme_DISJUNCTION-COMPONENTS_Indent
    1m.v Scheme_DELAY-COMPONENTS_Indent
    1m.v Scheme_ACCESS-COMPONENTS_Indent
    1m.v Scheme_IN-PACKAGE-COMPONENTS_Indent
    1m.v Scheme_PROCEDURE-COMPONENTS_Indent
    M.M ^R_Indent_for_Lisp  M.Q I
    1,1M.L Space_Indent_Flag
    1,Q(1,Q. M.QW )M.Q .  !* Exchange rubout flavors.!
    1,56 M.L Comment_Column
    1,(:I*;) M.L Comment_Start
    1,(:I*) M.L Paragraph_Delimiter
    QPermit_Unmatched_Paren"L
      1,0M.LPermit_Unmatched_Paren'
    M.Q ..D
    0FO..Q Scheme_..D F"N U..D'    !* Select the Lisp syntax table!	
      "# W :G..D U..D		    !* creating it if doesn't exist.!
	Q..D M.V Scheme_..D
	-1[1 32< %1*5+1:F..D A>
	9*5+1:F..D_
	!""""! 1M(M.M &_Alter_..D) |A "| '' `' ,' @' [A]A {A}A  
_ _'

    !* Load the Scheme-Emacs interface if it isn't aleady loaded.!
    1:<m.m&_SCHEDIT_Library_Loaded>"N
      :i*SCHEMEm.vSCHEDIT_Lisp_JName
      m(m.mLoad_Library)SCHEDIT'
    
  !* M-Z, C-M-Y and M-O are local to scheme mode. C-X Z is global.!
  m.m^R_SCHEDIT_Zap_Defun M.Q ..Z    !* Set up Zap Defun on M-Z!
  m.m^R_SCHEDIT_Load_Defun_into_Lisp M.Q ...Y   !* and do C-M-Y!
  m.m^R_SCHEDIT_Load_Buffer_into_Lisp M.Q ..O   !* and do M-O.!
  m.m^R_Find_Scheme_Definition M.Q ...S !* Very simple DEFUN finder.!
  0 FO ..Q Scheme_Mode_Hook"E	    !* Omit global key setups if hook!
    m.m^R_SCHEDIT_Resume_Lispu:.x(Z)' !* Set up C-X Z to resume lisp!

 et FOO.SCM
 1M(M.M&_Set_Mode_Line) Scheme 

!^R Find Scheme Definition:! !^R Find a DEFINE with the given name in this file
by searching from the beginning.  If given an argument, searches from the
next line (to skip this occurrence).!

    1,fFind_Scheme_definition_of:_[N
    .[P
    0f[Case			 !* Losers.!
    !* Really test for arg.  ^Y default differs from calling or a ^R char.!
    FF"E BJ'		 !* No arg, start from beginning.!
      "# L'
    !* Search for "(DEFINE (FOO" and a delimiter.!
    :s(define_(N"E QPJ :i*DNF	Definition_not_foundfs errw 0'
    -:s(define_(
    0
   