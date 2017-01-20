!* 4/84 BRADFORD@SIERRA: Made routines dealing with buffers call routines in
   library BUFFER to do their work (because I changed BUFFER).!
!* <EMACS>COMPLT.EMACS.6, 17-Aug-82 14:35:36, Edit by LSR
   Added completion on variable names to Make Local Variable
and Kill Local Variable.  Also fixed buffer name lister to 
allow for string file versions on ITS.!

!~FILENAME~:! !Provide completion for buffer and variable names.!
COMPLT

!& Setup COMPLT Library:! !S Install changes.
Installs the new Select Buffer on C-X B and the new
Kill Buffer on C-X K.  The old functions connected to
these keys are saved away in QOld C-X B and QOld C-X K.  
(If variable COMPLT Setup Hook is non-zero, this is macroed instead.)
!

!* Assumes that the user does not have MM-variables for any of the 
functions defined in the library.  (Correct assumption for the
standard EMACS.) !


  QEMACS_Version-162"L
    :I*COMPLT_requires_EMACS_version_162_or_above.:FG
    '

  0FO..Q COMPLT_Setup_Hook [0
  FQ0 "G :M0 '

  0 FO..Q Old_C-X_K "E Q:.x(K) m.v Old_C-X_K '
  m.m Kill_Buffer U:.x(K)	    !* Install new Kill Buffer!

  0 FO..Q Old_C-X_B "E Q:.x(B) m.v Old_C-X_B '
  m.m Select_Buffer U:.x(B)	    !* Install new Select Buffer!

  

!& Kill COMPLT Library:! !S Un-install changes.
Runs variable COMPLT Kill Hook if it exists.  Otherwise restores
functions bound to C-X B and C-X K.!

  0 FO..Q COMPLT_Kill_Hook [0
  FQ0 "G :M0 '

  0 FO..Q Old_C-X_K F"N U:.x(K)
  MM Kill_Variable Old_C-X_K'
  0 FO..Q Old_C-X_B F"N U:.x(B)
  MM Kill_Variable Old_C-X_B'
  

!& Read Buffer Name Prep:! !S Set up for reading buffer name with completion.
Initializes the CRL variables (leaving them pushed on the stack).!

  [CRL_List [CRL_Prefix	    !* push the variables!
  [CRL_Name_Type [CRL_Name_Lister
  FS QP PTR [P			    !* save QP PTR for popping!
				    !* of other temporaries!

				    !* build FO-style list of!
				    !* buffer names and buffer indices!
  5 FS Q VECTOR [L
  2 U :L(0)			    !* 2 entries per list elt!
  FQ.B/5 [0 0[1			    !* # entries in Q.B => Q0!
				    !* Start current buffer entry => Q1!
  [2[3
  < Q1-Q0;
    Q:.B(Q1+1!*bufnam!) U2	    !* buffer name => Q2!
    -(@:FO L 2) U3		    !* where in QL bufferbelongs!
    Q3 "G QL[..O 5*Q3J 10,0I ]..O   !* make 2 slots!
          Q2 U:L(Q3) Q1 U:L(Q3+1) ' !* initialize them!
    Q:.B(Q1) + Q1 U1 >		    !* advance to next buffer!

    QL UCRL_List
    :I* UCRL_Prefix
    :I*buffer UCRL_Name_Type
    m.m&_Buffer_CRL_Lister UCRL_Name_Lister
    QP FS QP UNWIND
    !* return without popping !

!& Buffer CRL Lister:! !S CRL Name Lister for & Read Buffer Name.
Adds visited filename and modified bit to list of buffer names.!

    f[ d file
    FF&2"n BJ			    !* insert a heading!

             I__Buffer_Name_________Visited_File_Name

 '
  "# [1 Q:.1(Q1)[0		    !* Q0 gets buffer name!
     Q:.1(Q1+1)U1		    !* Q1 BUFFER index!
     Q:.B(Q1+4!*bufbuf!)[X	    !* buffer looking at!
     QX[..O FS MODIFIED (]..O)"E I__ '
			       "# I*_ '    !* modified bit!

     G0 20-FQ0 :F"G w2 ',32I		    !* buffer name & some spaces!
     Q:.B(Q1+2!*bufvis!)u0 q0 "E
         QX[..O FS Z(]..O) \ I _characters'
     "# G0 ET0
        q:.B(Q1+9!*bufver!)[3
        fs d version :"G fs d version+1 "n
	I _( !)!
	fq3 "L q3\ ' "# g3 '
        !(! I) '''
     I
				    !* CRLF!
     '
   

!Select Buffer:! !C Select or create buffer with specified name.
Can accept the buffer name as a string arg, or the buffer number
as a numeric arg, or a string pointer as arg (when used as a subroutine).
If there is a buffer with that name, it is selected.
Otherwise, a buffer with that name is created and selected.
When a new buffer is selected the first time, if Buffer Creation Hook
is nonzero, it is run after the buffer is selected.
A precomma arg is the prompt string to use.

Uses & Read Command Name to read buffer name with completion.  Null
buffer name selects the default; method for entering a new buffer
name depends on setting of QCRL Non-match Method. !

    MMM_&_Check_Top_Levelbuffers
    [4 0[3
    FF&1"N U3'		    !* Numeric arg => use it as buffer or buffer # to select.!
    "# "E :F"G :i3''	    !* Precomma arg, or no postcomma arg, => read string arg.!
      Q3"E			    !* Else must read from tty.!
         "N u4'		    !* Precomma arg is prompt string to use.!
           "# :i4 Select_Buffer'
	 QPrevious_Bufferu3	    !* Get name of default new buffer to put in prompt.!
	 1,Q3M(M.M &_Find_Buffer)"L Q:.B(1)U3'

				    !* read buffer name!
				    !* with completion!
	 m(m.m&_Read_Buffer_Name_Prep)
	 62.,m(m.m&_Read_Command_Name)4_(3):_U3
	 Q..H"N F' 0U..H	    !* Don't wait for space: redisplay text immediately.!
	 FQ3"L 0'		    !* Give up if get a rubout instead.!
	 ''
    Q3[5			    !* Save name (or buffer #) in Q5.!
    FQ3"E QPrevious_BufferU3'	    !* Null string means previous buffer.!
    1,Q3 M(M.M&_Find_Buffer)[1	    !* Get index in buffer table of this name or number.!
    Q1u4			    !* Q4 remains negative, for a new buffer.!
    Q1"L			    !* No such buffer => make one now.!
      FQ3"L :I*No_such_buffer FS ERR'	    !* Refuse to create buffer if bfr number spec'd.!
      FQ5"E 0U1 0U4'		            !* If ^XB<cr> and prev bfr non ex, use 1st buffer instead.!
      "# Q3 M(M.M &_Create_Buffer)U1''   !* Else create the specified buffer.!
    Q1 :M(M.m &_Select_Buffer)

!Kill Buffer:! !C Kill the buffer with specified name.
Takes name as a string (suffix) argument, or reads it from terminal.
(Uses & Read Command Name for completion: 
  null name means the current buffer.)
Alternatively, the name (as string pointer) or the buffer
number may be given as a prefix argument.
If the buffer has changes in it, we offer to write it out.!

    FF&1"N [1 '		    !* Numeric arg => use it as buffer # to select.!
    "# 
				    !* Read name of buffer!
				    !* with completion!
    m(m.m&_Read_Buffer_Name_Prep)
    52.,f Kill_Buffer:_ [1'
    Q1 :M(M.M &_Kill_Buffer)

!Insert Buffer:! !C Insert contents of another buffer into existing text.
Specify buffer name as string argument.!

				    !* Read buffer name!
				    !* with completion!
    m(m.m&_Read_Buffer_Name_Prep)
    72.,f Insert_Buffer:_ [1
    Q1 :M(M.M &_Insert_Buffer)

!View Buffer:! !C View a buffer moving by screenfulls.
Buffer name is string argument; null arg means selected buffer.
Space moves to next screen, Backspace moves back a screen.
Return exits leaving point in current screen.
Anything else exits and restores point to where it was before;
and if it isn't Rubout, it is executed as a command.

Also useful on fast storage scopes like the Tektronix.
However, Backspace is only available on real displays.!

    m(m.m&_Read_Buffer_Name_Prep)
    72.,f View_Buffer:_ [1

    Q1 :M(M.M &_View_Buffer)

!& Read Variable Name Prep:! !S Set up for reading variable name with completion.
Sets up all the CRL variables (they are left pushed on stack).!
  :I*variable [CRL_Name_Type
  Q..q [CRL_List
  :I* [CRL_Prefix
  !* return without popping!
  
!Kill Variable:! !C Eliminates definition of specified variable.!

    m(m.m&_Read_Variable_Name_Prep)
				    !* read variable name with!
				    !* completion!
    12.,f Kill_Variable:_ [0
    :fo..q0 [0		    !* Find the variables idx in symbol table (..Q)!
    q0"l '			    !* Not defined =) do nothing.!
    q..q[..o  q0*5j 15d 0	    !* Else delete the 3 words describing it!

!View Variable:! !C Type out contents of variable.
Simply reads a variable name, and then calls View Q-Register.
Uses completion if the name is read from the terminal.!

   m(m.m&_Read_Variable_Name_Prep)
				    !* read variable name with!
				    !* completion!
   12.,f View_Variable:_ [0
   m(m.mView_Q-Register)0 

!Set Variable:! !C Set the value of a named variable.
The name of the variable is a string argument.
If you supply a numeric argument, that is the new value.
Otherwise, a second string is the new value.
Completion is available for the variable name, with Space and Altmode.
Abbreviations are not allowed unless you complete them;
any nonexistent name creates a new variable.!
    
    m(m.m&_Read_Variable_Name_Prep)
				    !* read variable name with!
				    !* completion--do not!
				    !* allow null name!
    32.,F Set_Variable:_(
      FF"E 1,F Value:_' "# '[1
      )[0
				    !* with completion, no need!
				    !* to permit abbreviation!
				    !* by the user!
    :F "L @ ' :FO..Q 0:"G
      0M.V0'			    !* Create variable if it doesn't exist.!
    Q1U0 0		    !* Set value in any case.!

!Make Local Variable:! !C Make a variable local to the current buffer.
Example:  M.LFoo Variable (since this function lives in .L).
The variable name must be given in full, not abbreviated.
Its local value starts off the same as its global value.
However, a numeric argument to this function sets the local value.
"1," as arg means assume that the local doesn't exist yet.
"2," means make a permanent local that won't go away when major mode changes.!

    m(m.m &_Get_Library_Pointer)EMACS[L
    m(m.m &_Read_Variable_Name_Prep)
				    !* read variable name with!
				    !* completion--do not!
				    !* allow null name!
    32.,f Make_Local_Variable:_[0
    fm(qLm.m Make_Local_Variable)0
    

!Kill Local Variable:! !C Kill one of the current buffer's local variables.
The global value is restored.!

    m(m.m &_Get_Library_Pointer)EMACS[L
    m(m.m &_Read_Variable_Name_Prep)
				    !* read variable name with!
				    !* completion!
    12.,f Kill_Local_Variable:_[0
    fm(qLm.m Kill_Local_Variable)0
    
