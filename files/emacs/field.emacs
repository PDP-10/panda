!* -*-TECO-*-!
!* <EMACS>FIELD.EMACS.17,  5-Jan-86 12:43:42, Edit by GERGELY!
 
!~Filename~:! !Functions for dealing with fields of information on a line.!
FIELD

!& Parse Fields:! !S Separate the line into fields.
Each field is assumed to be separated by GField Separator.  It will only
separate a maximum of QMaximum Fields:\ on a line or to the line
terminator.  Q$Fields$(0) will contain the number of fields, and the number is
also returned by this routine.  The line is left untouched and the pointer
remains in the same location.!

    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'
    .[P FN QPJ
    0[I QF <:I*U:Fields(%I)> 0U:Fields(0)
    0[I 0L .UB
    QF<:FBS "L 1R QB,.X:Fields(%I) 1C .UB w-1'
	"# QB,(:L.)X:Fields(%I) w0';>
    QI F(U:Fields(0))

!& Setup FIELD Library:! !S Set up the variables and others!

    :I*{ FO..Q Field_Separator M.C Field_Separator*_Character_to_separate_the_fields
    10 FO ..Q Maximum_Fields M.C Maximum_Fields*_Maximum_fields_on_line
    :I* FO..Q Field_Blank M.C Field_Blank*_Character_designating_a_space.
    -1 FO..Q Field_Case M.C Field_Case*_Nonzero,_implies_to_ignore_case_when_sorting
    0 M.V Field_Mode
    

!Columnify Fields:! !C Places the fields on line in fixed length columns.
Any numeric argument will ignore lines having only one field.
A pre-comma argument prevents the buffer being stored for UNDO.!

    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'

    FF&2 "E 0,fszM(m.M &_Save_For_Undo) Columnify_Fields'

    1, M(M.M Strip_Field_Blanks)

    .[P
    FF&1 [N				!* QN is the number of argument!
    [A [I
    QF+1*5 fsqvector[L
    QF+1*5 fsqvector[1
    0[C
    J <.-z;
	%Cw M(M.M &_Parse_Fields)
	0UI Q:Fields(0)- qn F"G + qn <
	    Q:fields(%I)UA
	    FQA-Q:L(QI) "G FQA U:L(QI) QC U:1(QI)'
	    >'
	Q:fields(0)UA
	QA-Q:L(0) "G QA U:L(0) QC U:1(0)'
	1L>

    Q:fields(0) "E W:I*CNo_Lines_to_process fsechodisp
	0 fsechoactive QPJ 0'

    0UI Q:L(0) <Q:L(%I) + 1 U:L(QI)>

    J <.-z;
	M(M.M &_Parse_Fields) W0L 1K
	0UI Q:Fields(0)- qn F"G
	    Q:L(0) <
	    Q:fields(%I)UA
		FQA"G GA
		   Q:L(QI)-FQA F"G,32I'#"D'
		   '
		"# Q:L(QI) F"G,32I''
		>
	    13i 10i'
	>

    0UI J w32I Q:L(0)-1 F"G<		!* Add in the column markers at the!
	    Q:L(%I)-1 f"G,32I' wi!>	!* top !
	13i 10i'

    FTField_0:__Maximum_Number_of_Fields_=_ Q:L(0):=
    FT_on_line_ Q:1(0) := FT

    [T
    0 UI Q:L(0) <
	FTField_ %I:= FT:__Maximum_Number_of_Chars._=_ Q:L(QI):=
	FT_on_line_ Q:1(QI):= FT

	QT + Q:L(Qi) UT
	>
    FT __**_Total_number_of_characters_per_line_=_ QT := FT_**

Note:__Field_Sizes_are_1_larger_to_allow_for_a_blank.
__________________Type_a_space_to_continue.

    J

!Create Surname Field:! !C Makes a name field of the format surname, firsts.
The numeric argument is the number of the field to field to fix.  It assumes
that the surname is the last word in the field.  Pre-comma argument says
not to save for UNDO.  GField Blank is used as a non destructive space.!

    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'
    FF&2 "E 0,fszM(m.M &_Save_For_Undo) Create_Surname_Field'
    F"G [I' "# 1[I' [T [N
    J <.-Z;
	M(M.M &_Parse_Fields)(w:K)UN
	QN"G
	    G(Q:Fields(QI))
	    @-f_	k
	    .,(0l.):FB_"L 1C :FXT'"# Onothing'
	    @-f_	k
	    0L GT I,_
	    !nothing!
	    0L :FX*U:Fields(QI)'
	0UJ QN <
	    QJ"G GS' G(Q:Fields(%J))
	    >
	1L>
    J

!Field Mode:! !C Set things up for editing Fields.
Tab does ^R Tab to Tab Stop.  There are no comments.
Auto Fill does not indent new lines. The variable Field Blank 
defines the symbol for a nondestructive blank.  These are used by the
commands Create Surname Field and Fix Name Field.!

    M(M.M &_Init_Buffer_Locals)    !* See comment at top of file.!
    M.Q ..D
    0FO..Q Field_..D F"N U..D'	    !* Select the Field-mode syntax table!
      "# W :G..D U..D		    !* creating it if doesn't exist.!
	5*. :F..D __	    !* . isn't part of a word (or a "sexp").!
    !"! 5*' :F..D AA	    !* ' is part of a word...!
        5*8 :F..D AA		    !* BS is part of a word...!
	5*_ :F..D AA	    !* Underlining is part of a word...!
	Q..D M.V Field_..D
	'
    1,M.L Field_Blank
    :I* FO..Q Field_Blank [B
    FQB "G B*5 :F..D AA'
    1,M.L Field_Separator
    1,M.L Field_Case
    1,M.L Maximum_Fields
    1,QMaximum_Fields F"G *5'"# 10*5' + 5 fs Q vector M.L Fields
    1,(M.M ^R_Tab_to_Tab_Stop) M.Q I
    1,0M.L Display_Matching_Paren
    1,1M.L Field_Mode
    1M(M.M&_Set_Mode_Line) Field 


!Find Field Sizes:! !C Returns the maximum size of each field in characters.
Note that each character takes up one position regardless of control
characters.  Any numeric argument will ignore lines having only one field.!

    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'

    . [P FNQPJ				!* Keep the location!
    FF&1 [N				!* QN is the number of argument!
    [A [I
    QF+1*5 fsqvector[L			!* QL contains the field sizes!
    QF+1*5 fsqvector[1
    0[C
    J <.-z;
	%Cw M(M.M &_Parse_Fields)
	0UI Q:Fields(0)- qn F"G + qn <
	    Q:fields(%I)UA
	    FQA-Q:L(QI) "G FQA U:L(QI) QC U:1(QI)'
	    >'
	Q:fields(0)UA
	QA-Q:L(0) "G QA U:L(0) QC U:1(0)'
	1L>
    Q:L(0) F"G

	0UI Q:L(0) <Q:L(%I) + 1 U:L(QI)>
	FTField_0:__Maximum_Number_of_Fields_=_ Q:L(0):=
	FT_on_line_ Q:1(0) := FT

	[T
	0 UI Q:L(0) <
	    FTField_ %I:= FT:__Maximum_Number_of_Chars._=_ Q:L(QI):=
	    FT_on_line_ Q:1(QI):= FT

	    QT + Q:L(Qi) UT
	>
	FT __**_Total_number_of_characters_per_line_=_ QT := FT_**

	Note:__Field_Sizes_are_1_larger_to_allow_for_a_blank.
	__________________Type_a_space_to_continue.

	'
    

!Fix Name Field:! !C Reverse the surname, firstname of the name field.
The numeric argument is the number of the field to field to fix.  The
default is the first field.  Do not save for UNDO if there is a pre-comma
argument.  GField Blank is used as a non destructive space.!
    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'
    FF&2"E 0,fszM(m.M &_Save_For_Undo) Fix_Name_Field'
    F"G [I' "# 1[I' [T [N
    J <.-Z;
	M(M.M &_Parse_Fields)(w:K)UN
	QN"G
	    G(Q:Fields(QI)) 0L
	    :FB,"L -1D
		@-f_	k
		@f_	k
		:FXT
		0L GT 32I
		0L :FX*U:Fields(QI)' "#0L :K'
	    0UJ QN <
		QJ"G GS' G(Q:Fields(%J))
		>'
	1L>
    J

!Format Field Buffer:! !C Separates all the field into separate lines
No argument implies to save the buffer for UNDO.!
    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    FF&2"E 0,fszM(m.M &_Save_For_Undo) Format_Field_Buffer'
    1, M(M.M Strip_Field_Blanks)
    :I* FO..Q Field_Separator [S FQS :"G 0'
    J M(M.M Keep_Lines)S
    M(M.M replace_string)



    M(M.M replace_String)S


    J

!Order Fields:! !C Orders fields according to the string argument indices.
The fields are placed in the buffer according to the field indices given as
string arguments.  Terminate the string arguments with a null arguments.
A non-zero numeric argument implies to sort according to the that field
position after the line has been ordered.  A pre-comma argument implies
that no saving for undo will be done.!

    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'
    FF&2"E 0,fszM(m.M &_Save_For_Undo) Order_Fields'
    QF+1*5 fsqvector [I
    0[J [T
    QF+1 <:I* UT FQT "'G;
	f[bbind GT J \U:I(%J) f]bbind
	Q:I(QJ)"'G;>
    QJ f(U:I(0))"E 0'
    0 UJ Q:I(0)<
	Q:I(%J)-QF "G :I*Index_out_of_bounds FG'>
    J <.-Z;
	M(M.M &_Parse_Fields)(1K)"G
	    0UJ Q:I(0)<
		QJ"G GS' G(Q:Fields(Q:I(%J)))
		>
	    13i 10i'
	>
    J FF&1"N W1,M(M.M Sort_Field)'
    J 

!Paginate Field Buffer:! !C Formats the field buffer into pages of blocks.
Each block is one line in the buffer.  The numeric argument is the page
length (default 56) to use.  The precomma argument says not to save for
undo.!
    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    FF&2"E 0,fszM(m.M &_Save_For_Undo) Paginate_Field_Buffer '
    FF"G -10 F"G+10 [L'"# 56[L''"# 56[L'
    1, M(M.M Format_Field_Buffer)
    J 13i 10i
    J <.-z; WQLL .-z; -S


	1L 12I>
    J 

!Reverse Sort Field:! !C Reverse sort on the given field.
The numeric argument is the field number to sort the buffer on.  The default
is the first field.  Do not save for UNDO if there is a pre-comma argument.!

    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'
    FF&2"E 0,fszM(m.M &_Save_For_Undo) Reverse_Sort_Field'
     F"G -1[A' "#0[A' 
    -1 FO ..Q Field_Case f[ ^P Case
    QA"E :0l:FBS$"E :L' 1l'
    "# :0lQA<:FBS$;>:FBS$"E :L' 1l'
    J

!Reverse Sort Numeric Field:! !C Reverse sort on the given numeric field.
The numeric argument is the field number to sort the buffer on.  The default
is the first field.  Do not save for UNDO if there is a pre-comma argument.!

    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'
    FF&2"E 0,fszM(m.M &_Save_For_Undo) Reverse_Sort_Numeric_Field'
     F"G -1[A' "#0[A' 0[B -377777777777.[C
    QA"E :0l.UB .-(:L.)"NQBJW\'"#QC(%CW)' 1l'
    "# :0lQA<:FBS$;>.UB .-(:L.)"NQBJW\'"#QC(%CW)' 1l'
    J

!Reverse Sort Date and Time Field:! !C Reverse sort on the given Date and Time field.
The numeric argument is the field number to sort the buffer on.  The default
is the first field.  Do not save for UNDO if there is a pre-comma argument.!

    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'
    FF&2"E 0,fszM(m.M &_Save_For_Undo) Reverse_Sort_Date_and_Time_Field'
     F"G -1[A' "#0[A' 0[B
    QA"E :0l.UB .-(:L.)"NQBJ fsfdconvert$F"Lw1C-1''"#-1' qbj1l'
    "# :0lQA<:FBS$;>.UB .-(:L.)"NQBJ fsfdconvert$F"Lw1C-1''"#-1' qbj1l'
    J

!Reverse Sort Surname Field:! !C Reverse sorts on a surname.
The numeric argument is the number of the name field.  It assumes
that the surname is the last word in the field.!

    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'
    0,fszM(m.M &_Save_For_Undo) Reverse_Sort_Surname_Field
    1, M(M.M Create_Surname_Field)
    1, M(M.M Reverse_Sort_Field)
    1, M(M.M Fix_Name_Field)
    J

!Sort Field:! !C Sort on the given field.
The numeric argument is the field number to sort the buffer on.  The default
is the first field.  Do not save for UNDO if there is a pre-comma argument.!

    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'
    FF&2"E 0,fszM(m.M &_Save_For_Undo) Sort_Field'
     F"G -1[A' "#0[A' 
    -1 FO ..Q Field_Case f[ ^P Case
    QA"E 0l:FBS$"E :L' 1l'
    "# 0lQA<:FBS$;>:FBS$"E :L' 1l'
    J

!Sort Numeric Field:! !C Sort on the given numeric field.
The numeric argument is the field number to sort the buffer on.  The default
is the first field.  Do not save for UNDO if there is a pre-comma argument.!

    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'
    FF&2"E 0,fszM(m.M &_Save_For_Undo) Sort_Numeric_Field'
     F"G -1[A' "#0[A' [B -377777777777.[C
    QA"E 0l.UB .-(:L.)"NQBJW\'"#QC(%CW)' 1l'
    "# 0lQA<:FBS$;>.UB .-(:L.)"NQBJW\'"#QC(%CW)' 1l'
    J

!Sort Date and Time Field:! !C Sort on the given Date and Time field.
The numeric argument is the field number to sort the buffer on.  The default
is the first field.  Do not save for UNDO if there is a pre-comma argument.!

    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'
    FF&2"E 0,fszM(m.M &_Save_For_Undo) Sort_Date_and_Time_Field'
     F"G -1[A' "#0[A' [B -377777777777.[C
    QA"E 0l.UB .-(:L.)"NQBJ fsfdconvert$F"Lw1C-1''"#-1' qbj1l'
    "# 0lQA<:FBS$;>.UB .-(:L.)"NQBJ fsfdconvert$F"Lw1C-1''"#-1' qbj1l'
    J

!Sort Surname Field:! !C Sorts on a surname.
The numeric argument is the number of the name field.  It assumes
that the surname is the last word in the field.!

    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    0 FO..Q Maximum_Fields F"G [F' "# W0'
    :I* FO..Q Field_Separator [S FQS :"G 0'
    0,fszM(m.M &_Save_For_Undo) Sort_Surname_Field
    1, M(M.M Create_Surname_Field)
    1, M(M.M Sort_Field)
    1, M(M.M Fix_Name_Field)
    J

!Strip Field Blanks:! !C Replaces the Field Blanks symbol by a space.
No precomma argument implies to save the buffer for UNDO.!
    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    FF&2"E 0,fszM(m.M &_Save_For_Undo) Strip_Field_Blanks'
    :I* FO..Q Field_Blank [B
    FQB"G J <:SB; w-1d 32i>'
    j

!^R Mark Field:! !^R Marks the given field.  The point will be at the end.
The numeric argument, if given will indicate what field to mark.  Otherwise
the currently pointed to one is marked.!

    0 FO..Q Field_Mode"E W:I*CField_Mode_is_turned_off. fsechodisp
	0 fsechoactive 0'
    .[P
    :I* FO..Q Field_Separator [S FQS :"G 0'
    1[A [B [E 0[F
    FF"N  F"G [A 1UF''
    QF"N 0l QA'"#W 1'<:FBS"L 1r .UE 1C -1'"# :L .UE 0';>
    0l.UB  QE,QB:FBS"L 1C .UB'
    
    :F"L QEJ QB
	'"#QEJQB,QE'		!* If called from a macro then just!
					!* return the bounds!

!* 
/ Local Modes: \
/ MM Compile: 1:<M(M.MDate Edit)>
M(M.M^R Save File)
M(M.MGenerate Library)FIELDFIELD
1:<M(M.MDelete File)FIELD.COMPRS>W \
/ End: \
!