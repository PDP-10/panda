!* -*-TECO-*-!
!* <EMACS>ABSTR.EMACS.97, 23-Sep-82 14:22:14, Edit by GERGELY!

!~Filename~:! !Generate documentation files for EMACS.!
ABSTR

!Abstract Library:! !C Make an abstract of some of the functions in a library.
Takes three string arguments:  a name prefix, a documentation prefix,
and a library file spec.  The name prefix and documentation prefixes
are used to filter the functions in the file:  only if its name starts
with the name prefix and its documentation with the doc prefix will
a function be listed.  The filespec may also be the library name of a
currently loaded library, as printed by List Loaded Files.!

    :i*[8
    :i*[9			    !* Q9 gets doc prefix, Q8 gets name prefix.!
    :i*:FC[n			    !* QN gets filename.!
    [0 [1 [7 f[:ej page [f
    1:< m(m.m&_Get_Library_Pointer) n uf>"L	    !* If file already loaded, get pointer to it.!
      1m(m.mLoad_Library)n uf'  !* Else temporarily (because of f[ above) load the file.!

    .f[vb z-.f[vz
    f=8_"e :i8'		    !* Allow space to mean null string,!
    f=9_"e :i9'		    !* for name and doc prefixes.!
    g(1,qfm.m~Filename~)	    !* get this files name!
    hf=0"e hk'"# 32i'
    i_(Filename:_ n )	    !* Some files may not have a ~filename~!	
    j <:s
; -2d>				    !* Flush any CRLFs from the filename.!
    j i
    
    f~9S"E i Subroutines'"# f~9^R"e i ^R_' i Commands'
    i_in_library_  zj i:


    .fsvb			    !* Now don't be distracted by the filename, etc.!
    g(qf m.m~DIRECTORY~) j	    !* Get the list of macro names!
    < .-z;			    !* Find the next macro name.!
      fq8 f~8"n 1@k !<!>'	    !* Ignore macros whose names dont start with name prefix!
      :x0 qfm.m~DOC~_0u0	    !* Get its documentation!
      f~09u1 q1"l -q1u1'	    !* Does it start with the prefix?!
      q1-fq9"g 0u1'
      q1"n 1@k !<!>'		    !* No => throw away this macro and continue.!
      1@l .u1 g0		    !* Else after the macro name insert the documentation,!
      0@f  "n i		    !* Put in a CRLF at end if there is none.!
'
      fsz-.f[vz
      q1j i___ s_ rd		    !* Put the macro class in column 3, while text starts at 8!
      < 9i l .-z;>		    !* inserting a tab before each line of it!
      q1j < :s; -d>		    !* Delete all the ^\'s from the doc strings.!
      zj f]vz
      i
      
      >
    i

    

!& Abstract Macro:! !S Abstract a single macro.
Inserts the full name of the specified macro,
and all of its documentation, and then a blank line.
Give the macro name string pointer as a numeric argument.!
    M(M.M&_MACRO_NAME)[0	    !* Get full name of macro in q0!
    g0 .i 15.i 12.i		    !* Put it, and CRLF, in buffer.!
    .[1 g(m.m~DOC~_0)	    !* Insert its documentation on the buffer.!
    0@f  "n i			    !* Put in a CRLF at end if there is none.!
'
    fsz-.f[vz
      q1j s_ q1,.k		    !* Flush the macro class.!
      < 9i l .-z;>		    !* Insert a tab before each line of doc.!
      q1j < :s; -d>		    !* Delete all the ^\'s from the doc strings.!
      zj f]vz
    

!& Abstract Prefix:! !S Describes the subcommands of an escape-prefix command.
Doesn't begin with any indentation - put that in yourself.!
    [0 [1 U0 U1 [2 [3
    M.M&_ABSTRACT_CHAR[C	    !* MC DESCRIBES A CHAR.!
    M.M&_ABSTRACT_MACRO[D	    !* MD DESCRIBES A MACRO.!
    Q1FP-101"N O NOT PREFIX'	    !* ERR OUT IF NOT GIVEN A VALID PREFIX CHAR DEFINITION.!
    F~1!PREFIX!-9"N
  !NOT PREFIX!
    @FE ARG FS ERR'
    F[ S STRING		    !* NOW SEE WHICH QREG THIS PREFIX DISPATCHES THRU!
    F[ B BIND
    G1				    !* LOOK AT THE PREFIX-MACRO.!
    JSQ 0K SM.P 3R .,ZK	    !* EXTRACT THE QREG NAME IT DISPATCHES THROUGH.!
    Q..OU3			    !* GET THE Q-VECTOR FROM THAT Q-REG, IN Q3.!
    F] B BIND
    I is_an_escape_prefix_command_with_these_subcommands:
    
    
    -1U1 FQ3/5<
	Q:3(%1)"N		    !* FOR EACH ELEMENT OF THE DISPATCH TABLE,!
	    I__ 2,Q0MC I_ Q1MC    !* PRINT, EG, "^X ^A"!
	    I_runs_the_function_
	    Q:3(Q1)MD
	    (Q1-127)*(Q1-27)*(Q1-8)*(Q1-9)*(Q1-10)*(Q1-12)* !*
	    ! (Q1-13)*(Q1-32)"E
		I__ 2,Q0MC I_ 2,Q1MC    !* PRINT, EG, "^X ^A"!
		I_runs_the_function_
		Q:3(Q1)MD
		''		    !* AND THEN DESCRIBE THE DEFINITION.!
	>
    

!& Abstract Char:! !S Insert pretty description of 9-bit character.
Thus, 9 M(M.M &_Abstract_Char) will insert "Tab".
A "1," as argument means don't use ^ for ASCII control characters;
they go in as themselves (and thus XGP as SAIL characters).
A "2," means don't use "Return", etc. - use "^M".!
    &200."N
	-2"E I^'
	"# I Control-''    !* Handle the "control" bit!
    &400."N I Meta-'		    !* And Meta!
    [0 &177.U0		    !* Get just the ASCII part!
    -2"N
	Q0-127"E I Rubout '	    !* Handle special cases that look bad!
	Q0-27"E  I Altmode '	    !* if we just type the character!
	Q0-8"E   I Backspace '
	Q0-9"E   I Tab '
	Q0-10"E  I Linefeed '
	Q0-12"E  I Formfeed '
	Q0-13"E  I Return ''
    Q0-32"E  I Space '
    -1"N
	Q0-32"L I^ Q0+100.U0'
	Q0-127"E I^ ?U0 ''	    !* ASCII Control characters maybe!
				    !* represent with ^.!
    Q0I 			    !* Other characters, just print!

!& Abstract ^R Command:! !S Describes a ^R command.
The command char and definition are fed as numeric args.
Assumes you have just inserted the command's name.!

    [0 [1 U0 U1		    !* Q0 gets char, Q1 gets definition.!
    1,Q0M(M.M &_Abstract_CHAR)	    !* Give the name of the char.!
    FS HPOS-7"G I
		 '
    9I				    !* Separate char and definition with a tab.!
    Q1FP-101"E                      !* AN IMPURE STRING =) MIGHT BE A PREFIX CHAR!
        F~1!PREFIX!-9"E
	    Q0,Q1:M(M.M &_Abstract_Prefix) ''
    Q1FP"G			    !* Any other string should be a named macro.!
        I runs_the_function_
        Q1:M(M.M&_Abstract_Macro)' !* Describe that string.!
    Q1FP+4"N                        !* Not string or number => you lose.!
	:I*DEF	Unrecognizable_Definition FS ERR'
    Q1M(M.M &_Macro_Name)[2	    !* See if char is known in the BARE library.!
    Q2"N I runs_the_built-in_function_
	Q1:M(M.M&_Abstract_Macro)'
    300.U0                          !* ELSE TRY TO FIND SOME BUILT-IN COMMAND!
    40.< Q0@FS ^R INIT#Q1@; %0>    !* WHOSE DEFINITION WAS COPIED!
    Q0-340."N                       !* WE FOUND ONE!
        !"! I is_bare_TECO's_
        Q0 M(M.M &_Abstract_Char)
        I
 '
    :I*DEF	Unrecognizable_Definition. FS ERR

!Abstract Redefinitions:! !C List all ^R commands redefined.!
    m(m.m&_Load_BARE)
    F~MODEFundamental"N
	:I*MOD	Not_in_Fundamental_mode FS ERR'
    QEditor_Name[0
    I
    Command_characters_defined_in_the_0_editor_(as_of_
							 FSDATEFS FD CONV -S_ :K
				    						   I):
    ___Commands_not_listed_here_are_self-inserting,
    ___illegal,_or_trivial_aliases_of_other_commands
    ___(as,_Control-x_for_Control-X,_or_Control-I_for_Tab).


    0[0 341.@FS ^R INIT[1	    !* Q1 holds an alias definition.!
    200.@FS ^R INIT[2		    !* Q2 holds an undefined definition.!
    300.< Q0@FS ^R INIT#Q0"N !* DONT MENTION CHARS NOT REDEFINED!
           Q0#Q1&777777."N    !* DONT MENTION ALIASES!
	    Q0#Q2"N
             Q0,Q0 M(M.M&_Abstract_^R_Command)
	     I
	     '''
	  %0>			    !* HANDLE FIRST 3/8 OF CHAR SET.!

				    !* HANDLE CTL-@ THRU CTL-_.!
    40.<  Q2#Q0"N
           Q0#Q1&777777."N     !* DONT MENTION ALIASES!
	    Q0,Q0 M(M.M&_Abstract_^R_Command)
	    I
	    ''
	  %0>

!* FOR THE OTHER CHARS, DESCRIBE ALL THAT HAVE BEEN REDEFINED AND AREN'T ALIASES.!

    440.< Q0@FS ^R INIT#Q0"N !* DONT MENTION CHARS NOT REDEFINED!
           Q0#Q1&777777."N     !* DONT MENTION ALIASES!
	    Q2#Q0"N
             Q0,Q0 M(M.M&_Abstract_^R_Command)
	     I
	     '''
	  %0>			    !* DESCRIBE EACH CHAR. THAT HAS CHANGED.!
    -2F=
"N I
				    !* Make blank line at end unless already one.!
    

!Wall Chart:! !C Make a wall chart describing defined command characters.
A wall chart is a list of command characters, in alphabetical
order, with the names of the macros they run.  It is put in the buffer.
To cause prefix characters to be included in the wall chart, mention
each prefix character in a string argument, as a ^R-command q-reg name
such as .^RX for ^X.  A null string argument ends the list.!

    [1 [2 [3  HK
    M(M.M &_Load_BARE)
    200.@FS ^R INIT[E		    !* QE HAS AN ILLEGAL ^R COMMAND.!
    A FS ^R INIT[I		    !* QI HAS A SELF-INSERTING ^R COMMAND.!
    341.@FS ^R INIT[A		    !* QA HAS AN ALIAS DEFINITION FOR LOWER CASE.!
    [S @:IS|			    !* QS has macro to space out to column 10!
      0F  -3F"L+2"E 32I' I___..___'	    !* At column 1 or 2 => use line of dots.!
      "#W 32I 10-FS HPOSF"G,32I''|	    !* Else use just spaces.!

    @:I1|
      I


      128<  QE#Q0"N	    !* DON'T MENTION ILLEGAL COMMANDS.!
	QI#Q0"N		    !* DON'T MENTION SELF-INSERTING ONES EITHER.!
	Q0#QA"N		    !* DONT MENTION ALIASES FOR LOWER CASE CHARS.!
	  Q0FS^R INDIRU3
	  Q3 M2
	  ''' %0>		    !* DESCRIBE EACH OF THEM THAT ISN'T ILLEGAL.!
      |

    @:I2|			    !* Describe one definition, in ^Y.  Char in Q0.!
      1,Q0&177. MC		    !* Put in the character's name.!
      MS			    !* Indent to line up descriptions.!
      MNU7 Q7"N G7'		    !* If macro has a name, insert it.!
      "# F~()!PREFIX!-9"E
          I is_a_prefix_character.__See_below.'
	 "# I is_an_anonymous_command.''
      I

      |

    M.M&_ABSTRACT_CHAR[C
    M.M&_MACRO_NAME[N

    [6 [7


    0[0

    GEditor_Name		    !* Insert a header to say what this chart is.!
    I_Command_Chart_(as_of_
			      FS DATE FS FDCONV
						 I):
    

    I
    Non-Control_Non-Meta_Characters:
    M1				    !* Each call to M1 handles 128 more characters.!

    I Control_Characters:
    M1

    I Meta_Characters:
    M1

    I Control-Meta_Characters:
    M1

    !* Now, change the 30 entries for ctl-0 thru ctl-9, etc.!
    !* Into 3:  one for CTL 0-9, one for meta, one for C-M.!

    J < :S
	0;			    !* Find some kind of zero.!
	:X6 0U7			    !* Get the definition (sans the "0")!
	9< LC :F=6"N %7'>	    !* Verify that 1 thru 9 are just like it.!
	Q7"E -9L C F_thru_9	    !* Turn the zero's entry into a 0 thru 9 entry!
	     L9K'>		    !* and flush the old entries for 1 thru 9.!

    J 2S R
    B,.M(M.M&_Count_Lines)-60"L    !* If 1st two pages fit in one,!
	JS -D 15.I 12.I'	    !* combine them (with a blank line).!

    !* Now to hack prefix characters.!

    ZJ [P

    < :I6			    !* Try reading the name of one.!
      -FQ6;			    !* Give up when read a null argument.!
      F6UP			    !* QP GETS NUMERIC ODE FOR PREFIX CHARACTER.!
      Q6U7			    !* Q7 GETS DEFINITION.!
      Q7FP-101"N O NOT PREFIX'	    !* ERR OUT IF NOT GIVEN A VALID PREFIX CHAR DEFINITION.!
      F~7!PREFIX!-9"N
  !NOT PREFIX!
        @FE ARG FS ERR'
      F[ B BIND
      G7			    !* LOOK AT THE PREFIX-MACRO.!
      JSQ 0K SM.P 3R .,ZK	    !* EXTRACT THE QREG NAME IT DISPATCHES THROUGH.!
      Q..OU6			    !* GET THE Q-VECTOR FROM THAT Q-REG, IN Q6.!
      F] B BIND
      I

      QP MC			    !* INSERT THE CHARACTER NAME.!
      I _is_an_escape_prefix_command_with_these_subcommands:


	-1U0 FQ6/5<
	    Q:6(%0)"N		    !* FOR EACH ELEMENT OF THE DISPATCH TABLE,!
		2,QPMC I_ Q0MC MS	    !* PRINT, EG, ^X ^A AND SPACE TO!
					    !* TAB STOP.!
		G(Q:6(Q0)MN)		    !* THEN GIVE THE NAME OF THE MACRO!
					    !* IT RUNS.!
		I
		
		(Q0-31)"E	    !* Check for control-? just before the!
				    !* space !
		   Q:6(127)"N	    !* Control-? is normally a rubout!
		      2,QPMC I_ 2,127MC MS !* PRINT, EG, ^X ^A AND SPACE TO!
					    !* TAB STOP.!
		      G(Q:6(127)MN) !* THEN GIVE THE NAME OF THE MACRO!
					    !* IT RUNS.!
		      I
		      ''
				    !* Check for pretty print characters!
		(q0-27)*(q0-8)*(q0-9)*(q0-10)*(Q0-12)*(q0-13)"E
		   2,QPMC I_ 2,Q0MC MS	    !* PRINT, EG, ^X ^A AND SPACE TO!
					    !* TAB STOP.!
		   G(Q:6(Q0)MN)		    !* THEN GIVE THE NAME OF THE MACRO!
					    !* IT RUNS.!
		   I
		   ''
	    "# (Q0-31)"E	    !* Check for rubout no matter what!
		   Q:6(127)"N
		      2,QPMC I_ 2,127MC MS !* PRINT, EG, ^X ^A AND SPACE TO!
					    !* TAB STOP.!
		      G(Q:6(127)MN) !* THEN GIVE THE NAME OF THE MACRO!
					    !* IT RUNS.!
		      I
		      '''
		   
	    >
	>
    

!Full Chart:! !C Like wall chart but include trivial commands.
Lists the numeric code, character, and definition for all 512 characters.
Also lists a table for each prefix char with all active definitions.!

    hk -1[0[1-1[2[3[4
    200. @fs ^R INIT [E
    m(m.m&_Load_BARE)
    m.m^R_Tab_to_Tab_Stop[T
    m.m&_Abstract_Char[A
    m.m&_Macro_Name[M
    50 fs Q VECTOR [P 8[..E
    [Tab_Stop_Definitions 
    @:I*|__________________________________.__
         ________._._._._._._._._._._._._._._.!*
!        | uTab_Stop_Definitions 
    512< 3,%0 \ I__		    !* Insert Char number !
       Q0 fs ^R INDIR u3	    !* Get alias character !
       Q0 MA 1MT		    !* Insert char name and tab !
       Q3-Q0 u4 Q4"N IAlias_for_ 3,Q3\ I_=_'   !* Note if alias !
       Q3 u3 Q3 # QE "N	    !* Continue only if legal !
          Q3 MM u1 q1 "N	    !* If it has a name !
	     fs S HPOS+fQ1-78 :"G g1'	    !* If room for it !
	        "# 0,74-fs S HPOS g1 I_...''	    !* else truncate !
	   "# fQ3 "G		    !* If a string !
	        f~3!PREFIX!-9 "E   !* Maybe a prefix char !
		   I{Prefix_Character}	    !* It was !
		   Q4 "E	    !* and not aliased !
		   Q0 fs ^R INDIR u:P(%2)''!* so note for later !
		 "# I{***String***}' '	    !* Otherwise nothing special !
	      "# I0 ''' "# I0 '   !* Else nothing !
       I
        >			    !* Next line and loop !
    -1u1 %2 <			    !* Start with prefix chars !
       I
       Prefix_Character:_ q:P(%1) u3 q3 MA I
        f[ B BIND g3	    !* Get definition !
       J sQ 0K SM.P 3r .,zK	    !* Delete all but dispatch vector !
       q..O u3 f] B BIND	    !* put that in Q3 !
       -1u0 fQ3/5 <		    !* itterate over table !
          q:3(%0) "N		    !* list only defined ones !
	     3,q0\ I__ w q0 MA 1MT !* insert char name and tab !
	     g(q:3(q0) MM) I
              ' > >		    !* and definition !
    

!Wide Wall Chart:! !C Turn regular wall chart into single-page wide one.
Call with a regular wall chart (as made by M-X Wall Chart)
in the buffer.  This function produces a wide wall chart
with three columns, one for control char, one for meta chars,
and one for control-meta chars, so the whole chart is one page.
Each prefix character gets one page with two columns.!

[A [B [C [D [0 [1 [2			!* Push the temporary registers!
0,fszM(m.M &_Save_For_Undo) Wide_Wall_Chart
JM(M.M Delete_Matching_Lines)^R_Disabled_Command
ZJ 12I				    !* Make last character of buffer a FF!
J<.-z; :FB_"L 1R 0XA
	    FQA-2"L
		A-32"'L+(A-127"'E)"N
		   0K I  ^ A#64I'''
	1l>
J<:S
BACKSPACE
TAB
LINEFEED
FORMFEED
RETURN
ALTMODE
SPACE; W0l 0I>
J<:S
RUBOUT;FK+2C 126I>		    !* But want rubout at the end of the list!
J<:Sis_a_prefix_character.; W:K>
JS
NON-CONTROL0L :K .UA
SCONTROL_CHARW 0l 0,1A-12"N12I'    !* Get rid of Non-Control, Non-Meta!
				    !* characters, as they are defined!
				    !* elsewhere!
QAJ				    !* Standardize the width of the columns!
27+10M(M.M &_FILL_TO_MINIMUM_COLUMN_WIDTH_ON_PAGE)U0  !* the four sections!
27+10M(M.M &_FILL_TO_MINIMUM_COLUMN_WIDTH_ON_PAGE)U1
27+10M(M.M &_FILL_TO_MINIMUM_COLUMN_WIDTH_ON_PAGE)U2
27+10M(M.M &_FILL_TO_MINIMUM_COLUMN_WIDTH_ON_PAGE)
    
QA,.FSBOUNDARIES		    !* Fix the virtual boundaries not to!
				    !* include the title or any subcommands!
J ICharacter_			    !* Prepare the column titles!
:L -10D .Uc
3<:S;
    .(:FXD QCJ GD -10D .UC)+FQDJ>
JL
M(M.M &_ORGANIZE_COLUMNS_ON_PAGE)  !* Get all the key definitions in place!
Q0M(M.M &_ORGANIZE_COLUMNS_ON_PAGE)    
q0+Q1-10M(M.M &_ORGANIZE_COLUMNS_ON_PAGE)
q0+Q1+q2-20M(M.M &_ORGANIZE_COLUMNS_ON_PAGE)
JL .,ZFSBOUNDARIES		    !* Don't use the columns title in the sort!
0L:LL			    !* Sort whole lines!

0,ZFSBOUNDARIES		    !* Open the top end of the virtual bounds!
-1L .,ZFSBOUNDARIES		    !* Close it to contain the column title!
				    !* and the key definitions!
L 13I10I			    !* Insert a blank line!
0UB <.-Z;			    !* Find the current longest width!
    :L .-(0L.)-QB F"G+QBUB' WL>
J %B				    !* Store in QB and add one for a space!
<.-Z;QB+.-(:L.)F"G,32I' WL>	    !* Fill out each line to a width of QB!
J<.-Z;.-(:L.)+11"L		    !* Copy the key on each line to the end!
    0L 11 XA :L GA FK+2C	    !* to make for easy referencing of the !
    -1A:"DS_ -C:K'"#:L-D' ' L>	    !* chart!

0,FSZFSBOUNDARIES		    !* Re-open the bounds to full!
J<:S ;FKD 0A-10"N 32I'>	    !* Delete the nulls preserving the space!
J<:S~RUBOUT;FK+1C -D 0A-10"N 32I'> !* Same for ~rubout  !
J SCHARACTER:L			    !* Find Column Title Line!
-S_ C :K			    !* Delete the trailing blanks, if any!
.-(0L.)U0			    !* Q0 gets the line width when done!
0,.FSBOUNDARIES		    !* Set bounds to the true titles!
J<.-Z;				    !* Center the titles!
    (-.+(:L.))U1
    Q1F"GU2'
    Q0-Q1F"G/2(0L),32I'L>
-L Q0-Q2/2,32I			    !* And underline the last one!
Q2,45I 13I10I 13I10I		    !* and two blank lines!
0,FSZFSBOUNDARIES		    !* Fully open the bounds!
M(M.M &_MAKE_FULL_PREFIX_CHART)    !* Procede to make the prefix chart!
ZJ 0A-12"E -D'			    !* If last character is a FF, Kill it!
J				    !* Leave the user at the top of the buffer!


!& Fill to Minimum Column Width on Page:! !S Fill lines to longest line width
First Finds the width of the longest line on the page and then fills the rest
to that width plus one for a space.  The maximum fill width may be given as
the numeric argument.  It sets the virtual boundary to the current pointer and
the next formfeed.  The fill width is returned.  Upon completion, the new
virtual boundary is the page mark to the end of the file.!

FF"G '"# 0'[D W[B		 !* QD gets the max width, QB the current!
				 !* width!
.,(:S"N0L' "#ZJ' .)FSBOUNDARIES !* Set Boundaries to current page!
J 0UB <.-Z;			 !* Do every line!
    :L.-(0L.)-QB F"G +QBUB'	 !* If width of line > QB, then QB=width!
    1L >			 !* Next line!
%B				 !* Add one to QB for the space!
QD-QB :"G QDUB'
J<.-Z;				 !* Fill out each line to column QB!
    QB+.-(:L.)F"G,32I'		 !* Add enough spaces!
    "# -4D wi..._'		 !* or truncate as necessary!
    1L>				 !* Next line!
ZJ				 !* Go the end of the current virt. bounds!
.,FSZFSBOUNDARIES		 !* Set new boundary to .,End of File!
.-Z+1"L C'			 !* Not to include the FF if not at ZJ!
    QB

!& Organize Columns on Page:! !S Get other definitions for those keys on page.
	Takes the first 10 characters per line to be the key
and then uses  it in a  search string to  get all other  key
definitions in the current buffer.!

[A [B [C [D [E [0 [1 [2 [3		    !* Push the temporary registers!
20fsqvectoruE
0f[^PCASE 0f[bothcase
0 u:E(0)
q0 u:E(1)
q0+q1-10 u:E(2)
q0+q1+q2-20 u:E(3)
[A [B [C [D [F			    !* Push the necessary Q-registers!
FF"E 10UA'			    !* Recall Arguments, Default is 10!
      "# UA'			    !* QA is the length of the previous fill!
QA-10UA				    !* Subtract 10 for the key!
.-Z"N				    !* If not at the end of the buffer, !
  <.-Z;				    !* then continue, for all the buffer!
    1A-12 @;			    !* or the first FF encountered!
    1A-32 "N			    !* If first character not a space!
        1A-13 "N		    !* nor a carriage return, then!
	    10 FXB GB		    !* Store 10 char. key in QB and replace it!
	    QA,32I		    !* Insert QA spaces after the key!
	    :L .UC		    !* QC gets the upcoming insert location!
	    <:S
B;				    !* Search for another deft. of the key!
	      FKD		    !* Kill the key before the definition!
	      .(0uf <-:s
;
	        %F>)J
	      :FXD		    !* QD gets the definition!
	      QCJ
	      Q:E(QF)-FSHPOSF"G,32I
			.(0L 1A"N 0uf'"# 1UF')J
			qff"G,32i''

	      GD .UC>		    !* Back to QCJ, insert Deft. and update QC!
	    L'			    !* Next line!
        "# WK ' '		    !* If first char. is a CR, kill line!
    "# WK ' >			    !* If first char. is a space, kill line!
  .-Z"L 1A-12 "E		    !* If not at end, kill FF, if any!
	WK ' ' '


!& Make Full Prefix Chart:! !S Make a full chart for each prefix character!

[A [B [C [D [E [0 [1 [2		    !* Push the temporary registers!
<:S_SUBCOMMANDS:;		    !* Search for prefix subcommands!
    -L 1A-12"EWD'		    !* If previous line start with FF, Kill it!
    1L 12I .U.0			    !* Put a pagemark at the beginning of line!
    .,(:S .-z"N 0L'.)FSBOUNDARIES	    !* Use only this prefix page!
    J 2L IControl_Characters: 13I10I	    !* Prepare the control!
				    !*  char. part!
    0l:S_____ "L
	0L 12I IRegular_Characters: 13I10I '  !* Prepare the bare char. part!
    J 3L			    !* Set up bounds for only the ctl part!
    .,(:S.-z"N 0L'.)FSBOUNDARIES	    !* Use only this prefix page!
	J<.-Z;
	    :S_; 0K		    !* Strip off the prefix!
	    1A-94 "E DC 32I'	    !* and any hats before the next character!
	    :FB__"L 1r'
	    10 - fshpositionF"G,32I'	    !* Pad the key out to 10 places!
	1L>
    [3 :I3Control_Characters: fq3+15,32i ]3 13i 10i	!* make sure the field!
							!* is wide enough for!
							!* the header!
    ZJ .,FSZFSBOUNDARIES	    !* Set up bounds now for REGULAR part!
    L .,(:S .-z"N 0L'.)FSBOUNDARIES
    J<.-Z;
	:S_; 0K		    !* Strip off the prefix!
	10+.-(S__R.)F"G,32I'	    !* Pad the key out to 10 places!
	1L>
    [3 :I3Regular_Characters: fq3+25,32i ]3 13i 10i
				    !* make3 sure the field is large enough!
				    !* for the header!

    0,Z FSBOUNDARIES		    !* re-expand bounds!
    -S Control_Characters	    !* Back to the control title!
    .,Z FSBOUNDARIES
    J<:S
BACKSPACE
TAB
LINEFEED
FORMFEED
RETURN
ALTMODE
SPACE;FK+2C 0I R FXE .(ZJ 0A-12"ER' GE)J>
    J<:S
RUBOUT;FK+2C 126I R FXE .(ZJ 0A-12"ER' GE)J> !* But want rubout at the end of the list!
    J .UA			    !* Standardize the width of the columns!
    50+10M(M.M &_FILL_TO_MINIMUM_COLUMN_WIDTH_ON_PAGE)U0	!* in the two sections!
    50+10M(M.M &_FILL_TO_MINIMUM_COLUMN_WIDTH_ON_PAGE)
    QA,.FSBOUNDARIES		    !* Fix the virtual boundaries not to!
				    !* include the title or any subcommands!
    J ICharacter_		    !* Prepare the column titles!
    :L -10D .Uc
    2<:S;
	.(:FXD QCJ GD -10D .UC)+FQD-10J>
    JL
    M(M.M &_ORGANIZE_COLUMNS_ON_PAGE) !* Get all the key definitions in place!
    Q0M(M.M &_ORGANIZE_COLUMNS_ON_PAGE)    
    JL .,ZFSBOUNDARIES		    !* Don't use the columns title in the sort!
    0L:LL			    !* Sort whole lines!

    0,ZFSBOUNDARIES		    !* Open the top end of the virtual bounds!
    -1L .,ZFSBOUNDARIES	    !* Close it to contain the column title!
				    !* and the key definitions!
    L 13I10I			    !* Insert a blank line!
    0UB <.-Z;			    !* Find the current longest width!
	:L .-(0L.)-QB F"G+QBUB' WL>
    J %B			    !* Store in QB and add one for a space!
    <.-Z;QB+.-(:L.)F"G,32I' WL>	    !* Fill out each line to a width of QB!
    J<.-Z;.-(:L.)+11"L		    !* Copy the key on each line to the end!
	0L 11 XA :L GA FK+2C	    !* to make for easy referencing of the !
	-1A:"DS_ -C:K'"#:L-D' ' L> !* chart!
    0,Z FSBOUNDARIES
    -SSUBCOMMANDS: 0L		    !* expands bounds to full prefix page!
    .,Z FSBOUNDARIES
    J<:S ;FKD 0A-10"N 32I'>	    !* Delete the nulls preserving the space!
    J<:S~RUBOUT;FK+1C -D 0A-10"N 32I'>	    !* Same for ~rubout  !
    J SCHARACTER:L		    !* Find Column Title Line!
    -S_ C :K			    !* Delete the trailing blanks, if any!
    .-(0L.)U0			    !* Q0 gets the line width when done!
    Q.0,.FSBOUNDARIES		    !* Set bounds to the true titles!
    J<.-Z;			    !* Center the titles!
	(-.+(:L.))U1
	Q1F"GU2'
	Q0-Q1F"G/2(0L),32I'L>
    -L Q0-Q2/2,32I		    !* And underline the last one!
    Q2,45I 13I10I 13I10I	    !* and two blank lines!
    ZJ Q.0,FSZFSBOUNDARIES>	    !* Fully open the bounds!
0,FSZFSBOUNDARIES  

!Alphabetical Abstract:! !C Alphabetical Abstract within command type.
Put in the buffer an alphabetized abstract of a library (string arg).
The abstract is separated by function class (i.e Command,
^R Command, Subroutine; and if none of these, it's considered Random).
Within each class, the functions are sorted alphabetically.
If ABSTR Fill Documentation is nonzero, the documentation of each
function is filled to the current fill column.!

  [D				    !* Buffer  - Directory of Library!
  [C[R[S[X			    !* Buffers - Documentation for!
				    !*   Commands, ^R Commands, Subroutines,!
				    !*   and any macro which is "None of!
				    !*   the above"!
  [F				    !* Library Pointer!
  :I*[G			    !* Library's global documentation!
  [L				    !* String - Library File Name!
  [N				    !* String - Library Name (in case it's!
				    !*   different than the File Name!
  [P				    !* Save/restore point at various places!
  [0				    !* String - Macro Name!
  [1				    !* String - Macro Documentation (i.e!
				    !*   Contents are that of!
				    !*   ~DOC~_<macro name>)!
  [2				    !* Result of F~ comparison!
  m.m^R_Fill_Region[3		    !* 3: grab this for later use!
  9:i*[Fill_Prefix		    !* get a tab as fill prefix !

  zj 0,0A-12"N 12I'		    !* Put ourselves at the end of the buffer!
				    !* and put a formfeed in if none exists.!

  Q..O[O			    !* Make empty buffer, and save it!
  F[:EJ PAGE			    !* Save state of :ej files!

  1,FLibrary:_UL		    !* Read Library File Name!

  1M(M.MLoad_Library)LUF

  1,QFM.M~Filename~UN		    !* Save library name for!
  FQN :"G			    !* "Commands in file <lib-name>:"!
    :I*((Anonymous))UN '	    !* No name, use Anonymous!
  "#
    QFM.M~DOC~_~FILENAME~UG '

  FS B CONSUD			    !* A buffer for the names of all functions.!

  FS B CONSUC			    !* Buffer for Commands!
  FS B CONSUR			    !* Buffer for ^R Commands!
  FS B CONSUS			    !* Buffer for Subroutines!
  FS B CONSUX			    !* Buffer for Random Macros!

  FN QDFSBKILL QCFSBKILL	    !* Kill buffers when we exit!
     QRFSBKILL QSFSBKILL
     QXFSBKILL 
  [..O				    !* Make sure none of them is selected!
				    !* when the FN does its thing.!

  QDU..O
  G(QFM.M~DIRECTORY~)		    !* Get all function names.!
  1F[ ^P CASE			    !* Ignore case when sorting!
  0L:LL			    !* Sort it, and then!
  J				    !*   go to the beginning!

 <
  QDU..O			    !* Select Directory Buffer!
  .-Z;				    !* If end of buffer - we're done!
  :X0				    !* Macro Name into q-reg 0!
  QFM.M~DOC~_0U1		    !* Now the documentation into q-reg 1!
  L				    !* Next line in Directory Buffer!

  F~1C_  -2"G		    !* Does doc string start with "C "!
    QCU..O ZJ'			    !*   Select Command Buffer, go to end!

  F~1^R_  -3"G		    !* Does doc string start with "^R "!
    QRU..O ZJ'			    !*   Select ^R Command Buffer, go to end!

  F~1S_  -2"G		    !* Does doc string start with "S "!
    QSU..O ZJ'			    !*   Select Subroutine Buffer, go to end!

  QD-Q..O"E			    !* It is not a Command, ^R Command,!
				    !*   nor a Subroutine; so we put it!
				    !*   in the Random Buffer!
    QXU..O ZJ'			    !* Select Random Buffer, go to end!

  G0 I				    !* Put Macro Name and <crlf> in buffer!
   .UP				    !* Save point for indenting later!
  G1				    !* Put Documentation in buffer!
  QPJ				    !* Go back to beginning of Documentation!
  Q..O-QX"N I___ S_'		    !* If function has a doc class,!
				    !* indent that specially.!
  .:				    !* mark this for filling region!
  <9I L .-Z;>			    !* Indent Macro Class by 3, and the!
				    !*   rest of the lines by 8 (tab)!
  0@f  "n i			    !* If doc doesn't end in CRLF, make one.!
'
  I
  				    !* Now, a blank line to separate it!
				    !*   from next Macro's Documentation!
  0FO..Q ABSTR_Fill_Documentation"N
    M3'				    !* fill the documentation, user fill col!
 >				    !* Go back for next Macro!

  QOU..O			    !* Select Main Buffer, and put!
				    !*   everything we found in it!

  FQG "G			    !* Put in header for the!
    ILibrary_File_Name:___	    !*   Library Name!
    .UP				    !* Save point!
    IL			    !* Tell which Library it is!
     QP,.@FC I			    !* Uppercase the Library Name!
    G				    !* Put in the Library's!
     I				    !*   global documentation!
     '				    !*   and a blank line!

  FQC"N				    !* Command(s) found?!
    ICommands_in_file_N:	    !*   Put in header!
     I				    !*   Put in blank line!
     GC			    !*   Get abstracts of commands.!
    I
    '				    !*   Put in a blank line!

  FQR"N				    !* ^R Command(s) found?!
    I^R_Commands_in_file_N:	    !*   Put in header!
     I				    !*   Put in blank line!
     GR			    !*   Get abstracts of ^R Commands!
    I
    '				    !*   Put in a blank line!

  FQS"N				    !* Subroutine(s) found?!
    ISubroutines_in_file_N:	    !*   Put in header!
     I				    !*   Put in blank line!
     GS			    !*   Get abstracts of subroutine.!
    I
    '				    !*   Put in a blank line!

  FQX"N				    !* Random Macro(s) found?!
    IRandom_Macros_in_file_N:	    !*   Put in header!
     I				    !*   Put in blank line!
     GX			    !*   Get abstracts of random functions.!
    I
    '				    !*   Put in a blank line!




!Make Many Abstracts:! !C Abstracts many libraries.
Works by calling Alphabetical Abstract.  All you have to do is
have a buffer full of library file names (one per line).!

  [F				    !* String - Library File Name!
  J				    !* Get to beginning!
  Q..O[D			    !* Save this buffer, and create!
  FS B CONS[W			    !*   a work buffer, because!
				    !*   Alphabetical Abstract mungs!
				    !*   the buffer it is given.!
  F[ D FILE			    !* Push!
  F[ I FILE			    !*  lots!
  F[ O FILE			    !*   of!
  [Buffer_Filenames		    !*    various!
  E[ FN E]			    !*     things!
 <
  QDU..O			    !* Get the buffer of file-names!
  .-Z;				    !* Am I at end yet?!
  :XF				    !* Get a Library File Name!
  L				    !* Get to next line!
  1F[ FNAM SYNTAX		    !* Lone filename is FN1!
  ET_:EJ			    !* Default FN2 to :EJ!
  FS HSNAMEFS D SNAME		    !* Get the home directory!
  1:<ERF			    !* Open the file to get FS I FILE!
     FS I FILEFS D FILE	    !*   and put it in FS D FILE!
     EC> "N			    !* Close the file!
    EC				    !* This isn't needed!
    1:<EREMACS:F		    !* Try the EMACS directory if the!
       FS I FILEFS D FILE	    !*   Library was not found!
       EC> "N			    !*   on the home directory!
      EC			    !* This isn't needed either!
        FT Library_____F_not_found_(maybe)	    !* Mumble <crlf>!

      ]*			    !* Pop FS FNAM SYNTAX!
      !<!> ''			    !* Go back instead of falling!
				    !*   into a bottomless pit!
  ]*				    !* Pop FS FNAM SYNTAX!
  FS I FILEUF			    !* Now, I have the full filename!
  FT Abstracting_F		    !* Tell 'em that I'm doing it!

  QWU..O			    !* Give work buffer to!
				    !*   Alphabetical Abstract so he can!
  M(M.MAlphabetical_Abstract)F  !*   mung it to his hearts content!
  FS I FILEFS D FILE		    !* Now that I know the full filename,!
				    !*   build the output filename from!
  FS MSNAMEFS D SNAME		    !*   it changing to the working!
				    !*   directory and...!
  :I*ABSTRACTFS D FN2		    !*   changing FN2 to "ABSTRACT"!
  FS D FILEUF			    !*   then, put it in q-reg F!
  M(M.MWrite_File)F		    !* Now, write out the file!
 >
  FT				    !* <crlf>!
    Abstracting_is_done.	    !*   Mumble!
				    !*     <crlf>!



!Make Source Index:! !C Makes an index of functions to source files.
Start with a buffer full of source file names (one per line).
The index is sorted by function name, and each entry says which
source file the function's code is in.  It is left in the buffer
at the end.!

  J				    !* Let's start at the beginning!
  0[A 0[B 0[C			    !* Various counts!
  [1
  Q..O[I			    !* Save the current buffer, as it!
				    !*   should be chock full of file-names!
				    !* We copy them into QD and use this buffer!
				    !* to build the index in.!
  [F				    !* String - File Name!
  F[B BIND Q..O[D		    !* Create buffer to hold filenames!
  GI J				    !* Copy them in.!
  F[B BIND Q..O[W		    !* create work buffer which holds a source file.!
  QI[..O			    !* Go back to original buffer and clear it.!
  HK
  [L				    !* Length of longest Macro Name!
  [M				    !* String - Macro Name!
  FS OSTECO"N
    1f[fnamsyntax		    !* needed for defaulting fn2 on twenex!
    ET EMACS'		    !* Twenex: have default FN2.!
  
 <
  QDU..O			    !* Get the Directory Buffer!
  .-Z;				    !* Am I done yet!
  :XF				    !* There's a file name; snap it up!
  %A				    !* Count of files!
  L				    !* Go down a line for next time around!
  QWU..O			    !* Let's get the Work Buffer and do!
				    !*   something besides loaf all day!
  1:<ERF>F"N U1		    !* Try to open the file, and never!
    FT 1			    !*   mind screwing around with errors;!
     !<!> '			    !*   if I can't find it on the first!
				    !*   try, then forget it!
  FT Gobbling_down_F__-__	    !* File was found; so tell 'em!
				    !*   that I'm gobbling it down!
  @Y				    !* Gobble down the file!
  0UC				    !* Reset count of Macroes per File!
   <
    :S:!; -2D		    !* Find <colon><excl> and delete them!
    %B %C			    !* Count Macroes!
    -@:F!FXM		    !* Go back to <excl> and FX 'em into qM!
    FQM,QLF UL			    !* Remember length of longest name!
    QIU..O			    !* Get to the Index Buffer!
    GM 9I			    !* Put in the name and a <tab>!
    IF			    !* And now, the File Name!
     QWU..O			    !* Back to the Work Buffer!
   >				    !* Do it all over again!
  QC:\UC			    !* Convert count to string!
  FT C_functions		    !* Tell 'em how many macores!
    				    !*   I found!
  HK				    !* Flush the junk in the Work Buffer!
 >				    !* Go back and do next file!
  QIU..O			    !* Get to the Index Buffer!
  QB:\UB QA:\UA			    !* Convert counts to strings!
  FT				    !* Mumble!
    B_functions_were_found_in_A_files.    !* Mumble!
    				    !* Mumble!
  FT				    !* Mumble!
    Sorting_Macro_Names		    !* Mumble!
    				    !* Mumble!
  1F[ ^P CASE			    !* Ignore the case when I sort it!
  2 @F=\^R\"E2C'<(1A"'A)(1a"'D):;C><1A-9@;C>L	    !* Sort it!
  J				    !* Back to the beginning!
  QL+3UL			    !* Set up offset!
  FT				    !* Yak!
    Making_the_listing_pretty	    !*   Yak!
    				    !*     Yak!

 <				    !* Align the File Names!
  :S	;		    !* Replace <tab> with <space>!
  -D				    !*   and then fill with "."!
  FS H POSITION-37 "G		    !*       (This Macro Name is big,!
    I				    !*       do a <crlf> then!
    _____ '			    !*       5 spaces, and then!
  "#				    !*       align the File Name,!
    32I '			    !*       reasonable length just aligns)!
  40-FS H POSITION,56.I	    !*   to column 40 and then!
  32I				    !*   another <space>!
 >				    !* Go do the next one!


!Abstract Directory:! !C Performs an Abstract File on all :ej files in
the directory.  The first string  argument specifies the command  type
that should  be  used.   The  second  string  argument  specifies  the
directory sorry, no recognition).  A  numeric argument implies use  MM
Alphabetical Abstract  and  then  the first  string  argument  is  not
used.!
    3,fCommand_Type:_[b
    FQB :"G :IB'
    QB:FCUB			    !* Uppercase it.!
    3,fDirectory:_[a
    [X[Y [Z
    FF"E @:IX`M(M.M Abstract_Library)B`'
    "# @:IX`M(M.M Alphabetical_Abstract)`'
    [c [d [Bwf[bbind
    1:<1,111110000001.eza*.:ej.0>"N
	:i*CError_in_Directory
	fsechodisp0fsechoact'
    0uc J<.-z; %Cw 1@l>
    J <.-z;
	I1:< GX
	:XB :L
	27i
	0l @I|:I*AB_fsechodisp0fsechoact
	|
	:L
	iw12i
	13i10i
	@I|>"E:i*Donefsechodisp0fsechoact'|
	1@l>

    fsosteco-1"E
	j qC/30 F"G<90l @i|0FZTer_No_Page
		CLOSE
		Ter_PaGE_24
		pop
		W|>'
	z-."N zj @i|0FZTer_No_Page
	    CLOSE
	    Ter_PaGE_24
	    pop
	    W|
	    ''

    jWI0UY 13I 10I
    zj 13i 10i 12i 28i
    hfxa f]bbind
    :ma
    

!Abstract Variables:! !C Insert names, values and comments of all variables.
If a string argument is given, it is used as a search mask!
    1,FVariable_Name:_[N		!* QN gets the variable name to look!
					!* for !
    M(M.M &_Load_Bare)			!* Load the BARE library if necessary!
    .-B"N 13i10i12i'			!* Start a new page in the buffer!
    0[0 [1 [2 [6
    Q:..Q(0)*5[3
    I
    Defined_variables_are:


    72,45i 13i 10i			!* Put in the separator.!
    FQ..Q-5/Q3<				!* REPEAT OVER ALL VARIABLES IN!
					!* SYMTAB!
        Q:..Q(%0) U1			!* GET NEXT VARS NAME!
        FQ1"L :I1<Garbage_Name>'
	FQN"G f[bbind g1 J:SN f]bbind
	    fssvalue"E Q0+2U0 Odone''
	G1 25-fshpos-2 F"G+2,32I'	!* INSERT IN BUFFER, THEN PAD TO!
	"#w I__|__'			!* COLUMN 25.! 
	Q:..Q(%0) U1			!* NOW GET VALUE OF VARIABLE.!
	Q1FPU6
	Q6-101"E ogotone'
	Q6+4"E 
	    Q1M(M.M&_MACRO_NAME)U6
	    Q6"N
		:I1Function:_1
		onotitle'
	    ogotone'
	Q6+3"E Q1:\U1 :I1<Pure_String_Number>_=_1 Ogotone'
	Q6+2"E Q1:\U1 :I1<Impure_String_Number>_=_1 Ogotone'
	Q6-1"E
	    Q1 M(M.M &_Abstract_Q-vector)U1
	    Ogotone'			!* IF IT IS FUNNY, SAY SO!
	Q6+1"E :I1<Dead_Buffer> Ogotone'
	Q6"E :I1<Buffer> Ogotone'
	Q6-100"E			!* IF VALUE IS PURE STRING, USE THE!
					!* STRING'S NAME.!
	    I Function:_
	    Q1M(M.M&_MACRO_NAME)U1
	    Onotitle'
	!gotone!
	fq1-40"G I
	    
	    Contents:
	    '
	"# 	IContents:_'
	!notitle!
	.U2				!* Get the contents!
	Q1FP"L  Q1\'			!* IF NUMBER, INSERT VALUE.!
	    "#  G1'			!* IF STRING, INSERT CONTENTS.!
	Z-.F[VZ
	<-2 F=			!* GET RID OF TRAILING CRLFS,!
	    :@; -2D>
	Q2J < 2 F=			!* GET RID OF INITIAL BLANK LINES,!
	    :@; 2D>
	ZJ
	F]VZ
	I
	
	Q:..Q(%0) U1			!* GET THIS VARIABLES COMMENT!
	FQ1"G				!* Only if there is something there!
	    .,(g1 .)fsbound		!* Close the bounds around the comment!
	    J -1,1a-42"E 13i 10i IComment_for_the_OPTION:
		13i 10i 1d :S"L 1r 0k''	!* Delete the * and any!
					!* delimiters!
	    "# -1,1a-33"E 1d		!* If not an option , check for a!
					!* variable macro !
		   -1,1a-42"E 13i 10i IComment_for_the_OPTION:	!* Is it!
					!* also an option !
		      13i 10i 1d :S"L 1r 0k''	!* Delete the * and!
							!* any delimiters!
		   "# 13i 10i IComment:	!* Otherwise it is only a!
						!* comment between the!
						!* exclamation points!
		      13i 10i'
		   .-(:s!"L -d'.):"L -1k' 13i 10i	!* Search for the!
					!* other exclamation point!
		   13i 10i IVariable_Macro:	!* After the comment comes the!
						!* variable macro!
		   -1,1a-13"N 13i 10i''	!* Check if there already is a CRLF!
		"# 13i 10i IComment:	!* If neither an option or a var macro!
		   13i 10i''		!* it must be just a comment.!
	    zj 13i 10i			!* Insert a CRLF at end of this!
					!* definition.!
	    0fsvbw 0fsvz'
	72,45i 13i 10i			!* Put in the separator.!
	!done!>
    13i10i
    


!Abstract Q-Registers:! !C Abstracts all Q-Registers!
    M(M.M &_Load_Bare)			!* Load the BARE library if necessary!
    .-B"N 13i10i12i'			!* Start a new page in the buffer!
    0[a 0[b 0[c 0[d [1 [2
    0ua :ibQ
    3< qa"N :ibB.'
       48uc
       36< :idBC
           iQ-Register_D fqbr -d :l
	    25-fshpos-2 F"G+2,32I'	!* INSERT IN BUFFER, THEN PAD TO!
	    "#w I__|__'		    !* COLUMN 25.! 
	   Du1
	Q1FPU6
	Q6-101"E ogotone'
	Q6+4"E 
	    Q1M(M.M&_MACRO_NAME)U6
	    Q6"N
		:I1Function:_1
		   onotitle'
	    ogotone'
	Q6+3"E Q1:\U1 :I1<Pure_String_Number>_=_1 Ogotone'
	Q6+2"E Q1:\U1 :I1<Impure_String_Number>_=_1 Ogotone'
        Q6-1"E
	    Q1 M(M.M &_Abstract_Q-vector)U1
	    Ogotone'			!* IF IT IS FUNNY, SAY SO!
        Q6+1"E :I1<Dead_Buffer> Ogotone'
	Q6"E :I1<Buffer> Ogotone'
	Q6-100"E			!* IF VALUE IS PURE STRING, USE THE!
					!* STRING'S NAME.!
	    I Function:_
	    Q1M(M.M&_MACRO_NAME)U1
	    Onotitle'
	!gotone!
	fq1-40"G I
	    
	    Contents:
	    '
	"# 	IContents:_'
	!notitle!
	    Q1FP"L  Q1\'		    !* IF NUMBER, INSERT VALUE.!
	    "#  G1'		    !* IF STRING, INSERT CONTENTS.!
	    I
	    
	    72,45i 13i 10i
	    %c:"D qc"A !<!>' 65uc'>
	%a>
    

!& Abstract Q-Vector:! !C Gets the contents of a Q-Vector
The argument is the variable or q-register to look at.  It returns the
contents upon completion.!

    M(M.M &_Load_Bare)
    [1 0[2 0[3  		!* Push the function!
    [4[I :I*[F [5 :I*[V 0[6
    <:IFF_>
    :IVFQ-vector_with_the_following_non-zero_entries:
	
    Q1[..O -1[0 Q2+2[2
    Z/5<
	Q:1(%0)F(U5)FPU6
	Q6-101"E ogotone'
	Q6+4"E 
	    Q5M(M.M&_MACRO_NAME)U6
	    Q6"N
		:I5Function:_6'
	    ogotone'
	Q6+3"E Q5:\U5 :I5<Pure_String_Number>_=_5 Ogotone'
	Q6+2"E Q5:\U5 :I5<Impure_String_Number>_=_5 Ogotone'
	Q6-1"E +7,Q5 M(M.M &_Abstract_Q-Vector)U5
	    ogotone'
	Q6+1"E :I5<Dead_Buffer>
	    ogotone'
	Q6"E  :I5<Buffer>
	    ogotone'
	Q6-100"E		    !* IF VALUE IS PURE STRING, USE!
				    !* THE STRING'S NAME.! 
	    Q5M(M.M&_MACRO_NAME)U5
	    FQ5 :"L:I5Function:_5''
	!gotone!
	Q5"N
	    q0:\u4
	    :IVVF
	    q0-100"L :IVV_'
	    q0-10"L :IVV_'
	    :IVV(4)__
	    Q5FP-101"N  Q5:\u4
		:IVV4
		'		    !* IF NUMBER, INSERT VALUE.!
	    "#  :IVV5
		'		    !* IF STRING, INSERT CONTENTS.!
	    '
	>
    QV


!*
/ Local Modes: \
/ MM Compile: 1:<M(M.MDate Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)ABSTRABSTR
1:<M(M.MDelete File)ABSTR.COMPRS>W \
/ End: \
!
    