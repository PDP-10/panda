!* -*-TECO-*-!
!* <GERGELY.EMACS>PRINT.EMACS.146,  5-Mar-81 12:10:43, Edit by GERGELY!
!~Filename~:! !Macros for Printing Files and Buffers!
PRINT

!& Setup PRINT Library:! !S Default setups!

    0FO..Q PRINT_Setup_Hook[0 fq0"G :M0' ]0	    !* In case someone!
				    !* wants to something different!

    :I*FO..Q Print_Old_Library[B  !* QB gets the old print library!
    :I*FO..Q Print_Library[A	    !* QA gets the current one!
    F~APRINT"N QA'"# QB' M.V Print_Old_Library    !* If already the!
				    !* same one then use the old one!
    :I*PRINT M.VPrint_Library	    !* Create the variable to be sure!
    M.CPrint_Library*_Filename_of_the_Library_containing_the_PRINT_macros.
    ]A ]B

				    !* All PRINT1 variables are used!
				    !* with Variable Macros!
    
    1 FO..Q Print1_Control M.VPrint1_Control
    :I* FO..Q Print1_Discard_Character M.VPrint1_Discard_Character
    :I* FO..Q Print1_PTAG_End M.VPrint1_PTAG_End
    :I* FO..Q Print1_PTAG_Start M.VPrint1_PTAG_Start
    :I* FO..Q Print1_Real_Control M.VPrint1_Real_Control
    :I* FO..Q Print1_Wraparound M.VPrint1_Wraparound
    200 FO..Q Print1_Embolden_Length M.VPrint1_Embolden_Length
    4 FO..Q Print1_Embolden_Overstrike M.VPrint1_Embolden_Overstrike

    1FO..QPrint_Control(
	)M.CPrint_Control! *_Controls_dispatching_of_Control_Chars._(-1=emb.,0,1=Cont.)
    -1_=_Emboldens,_0_=_No_effect,_1_=_Symbolized_by_tilda_character!
     UPrint1_Control
    M(M.M &_Print_Dispatch_Table)
    

    :I*LPT:<>FO..QPrint_Device(
	)M.CPrint_Device*_Default_Listing_Device

    :I*FO..QPrint_Discard_Character(
	)M.CPrint_Discard_Character! *_Delete_each_char._in_string_from_text!
     UPrint1_Discard_Character
    M(M.M &_Print_Dispatch_Table)
    

    200 FO..Q Print_Embolden_Length(
	)M.CPrint_Embolden_Length! *_Maximum_emboldened_line_length_to_store!
      F"EW 200'UPrint1_Embolden_Length

    4 FO..Q Print_Embolden_Overstrike(
	)M.CPrint_Embolden_Overstrike! *_Number_of_times_to_overprint_for_emboldening!
      F"EW 2'UPrint1_Embolden_Overstrike

    0FO..QPrint_Format(
	)M.CPrint_Format*_Printing_Format,_Nonzero_implies_miserly_format

    58FO..QPrint_Length(
	)M.CPrint_Length*_Default_Page_Length

    1FO..QPrint_Page_Index(
	)M.CPrint_Page_Index*_Nonzero_prints_page_index_at_end_of_file_(<0_Unsorted,_>0_Sorted)

    :I*FO..QPrint_PTAG_Start(
	)M.CPrint_PTAG_Start! *_String_indicating_start_of_text_for_the_index!
    [A FQA:"G :I*'"#QA'UPrint1_Ptag_Start

    :I*FO..QPrint_PTAG_End(
	)M.CPrint_PTAG_End! *_String_indicating_end_of_text_for_the_index!
    [A FQA:"G :I*'"#QA'UPrint1_Ptag_End

    :I*FO..QPrint_Real_Control(
	)M.CPrint_Real_Control! *_No_dispatch_on_each_character_in_the_string!
     UPrint1_Real_Control
    M(M.M &_Print_Dispatch_Table)
    

    126FO..Q Print_Signify_Control(
	)M.CPrint_Signify_Control*_Ascii_Value_of_character_to_preceed_a_control_character

    80FO..QPrint_Width(
	)M.CPrint_Width*_Default_page_width_before_wraparound

    :I*FO..QPrint_Wraparound(
	)M.CPrint_Wraparound! *_Line_Wraparound_indicator!
    [A FQA "L :IA'
    QAUPrint1_Wraparound
    
				    !* The following variables are!
				    !* used throughout the macros and!
				    !* are set by the macros.  They!
				    !* are not to be set by the user.!
    
    :I*M.VPrint_Destination_File
    :I*M.VPrint_Header
    :I*M.VPrint_Source_File
    3M.VPrint_Lines_in_Header
    0M.VPrint_M-Control
    0M.VPrint_J-Control
    0M.VPrint_Dispatch_Table
    M(M.M &_Print_Dispatch_Table)
    

!& Print Dispatch Table:! !S Creates the dispatch table for the print routines.
This subroutine cannot be used alone.!

    F[BBIND [A [2		    !* QA, Q2 are temporary!
    QPrint1_Control "E	    !* If this variable is zero it!
				    !* overides everything else!
	640,32I			    !* Q2 will hold the dispatch!
	'
    "# 32< IZU..2>		    !* Make an F^A dispatch to stop on!
	95*5,32I		    !* CTL characters!
	IZU..2
	10*5F_____		    !* CR, LF, TAB, FF and!
	12*5F_____		    !* ALTMODE do not!
	13*5F_____
	QPrint1_Control"L	    !* If we have the embolden type then!
	    27*5FZU..2'	    !* Change the function of escape back!
	"#
	    27*5F-D36I'	    !* Otherwise replace by a dollar sign!
	9*5F_____
	'
				    !* Remove the dispatch entry for!
				    !* any character in this string!
    QPrint1_Real_ControlU2
    -1UA FQ2 F"G <%A:G2 *5F_____ >' "#W :I2'
    10F2:"'L UPrint_J-Control	    !* Special Case!
    13F2:"'L UPrint_M-Control	    !* for CTRL-J and M!

				    !* Replace the dispatch entry for!
				    !* any character in this string to!
				    !* delete the character in dispatching!
    -1UA FQPrint1_Discard_CharacterF"G<
	    %A:GPrint1_Discard_Character*5F-D___ >'

    HFX* UPrint_Dispatch_Table    !* Store the dispatch!
    

!^R Print:! !^R Prompt the user for which PRINT macro to use.
The arguments are passed on to the macro that is called.  The
calling sequence is

	<length>,<width> MM ^R Print$<file>$<output device>

If the length of the string <file> is 0, then the current buffer
is used.   !

    :F"L			    !* If called from a key!
	:I*CPrint_the_current_bufferFSECHODISP
	1 M(M.M &_Yes_or_No)"N	    !* Reply with yes or no in the!
				    !* echo area!
	    F@:M(M.M Print_Buffer)'    !* If Yes, then the Buffer!
	"#  F@:M(M.M Print_File)'	    !* Else the File !
	'
    "# F:M(M.M Print_File)'	    !* Not from a key then standard call!
    

!Print Buffer:! !C Prints the current buffer on the output device.
The calling format is

    <length>,<width> MM Print Buffer$<Output Device> !

    FSQPPTR[0			    !* Q0 gets the pushdown level!
    0F[DVERSION		    !* Zero is the default version number!
    F[DFile E[ E\ FNE^ E]	    !* Push the input and output!
    FSHSname[A			    !* QA gets the login directory!
    QBuffer_Filenames[B	    !* QB gets the buffer name if it!
				    !* exists!
    [Buffer_Filenames		    !* Push the buffer filenames!
    FQB "G QBfsdfile' 
    "#				    !* If there is no filename then!
	f[bbind		    !* Get a temporary buffer!
	GBuffer_Name WH@FC WJ	    !* Get the buffer name!
	<.-z; -1,1AUB QB:;	    !* If at end then quit!
	    QB:"D		    !* If not a digit!
		QB-65"L W1D'
		"# QB-90"G W1D' "# W1:CW''
		' "# W1:CW' >	    !* Replace all non letters or numbers!
	HFXBW 	f]bbind	    !* Pop the temporary buffer!
	QBFSDFILE	    !* Set the default name!
	ETB
	'
    QPrint_Device[..6		    !* Q..6 gets the default!
				    !* printing device!
    ET..6			    !* Set the default filename!
    ETLST			    !* With the extension LST!
    5,1FOutput_toU..6	    !* Get the alternate output device!
    ET..6			    !* if any!
    ETLST			    !* default file with ext=LST !
    FSDFILEUPrint_Destination_File	    !* Use this name for!
				    !* output!
    ]..6			    !* Do not use double dot registers!
				    !* for long!
    [c [d [e [f [g [h [i	    !* Push the temporary registers!

    FQB "G			    !* If we have a buffer filename!
	1:< F[BBIND		    !* Get a temporary buffer!
	    etB		    !* set the defaults to QB!
	    1,ER EG EC		    !* Open the file and get stuff!
	    J4K :L .,zK HFX* fsdfile	    !* Get the real name!
	    f]BBIND>"N		    !* Out we go.  If we have an error!
	    QBFSDFILE'		    !* then set the name manually!
	FSDFN1UD		    !* QD gets just the filename!
	:I*A@D.TMPF(UPrint_Source_File)UC
				    !* The file is <home dir.><fsdfn1>.TMP!
	0FSDVERSION		    !* Zero the version number!
	FSDFILEUD		    !* QD gets the default filename!
	'			    !* and will be used as temporary!
    "#
	FQBuffer_Name"G	    !* If we only have the buffer with!
				    !* no filename!
	    QBuffer_Name:FCUD'    !* Use the buffer name to form a file!
	"# :IDUNKNOWN'		    !* Else UNKNOWN is used!
	:I*A@D-TEMP-PRINT.TMPF(UPrint_Source_File)UC
	:IDBuffer:_D,_No_Buffer_Filename	    !* QD is the header!
	'
    QDUPrint_Header		    !* Save the print header!
    B,Z M(M.M Write_Region)C  !* Write out the current buffer!
    -(WFSQPPTR-Q0) FSQPUNWIND	    !* Unwind the stack!
    FM(M.M &_Print_Subroutine)W  !* Call the printing subroutine!
    QPrint_Source_File[C	    !* Replace the source file into QC!
    M(M.M Delete_File)C	    !* Delete the temporary file!
    

!Print File:! !C Prints the current buffer on the output device.
The calling format is

    <length>,<width> MM Print File$<File>$<Output Device> !

    FSQPPTR[0			    !* Q0 gets the pushdown level!
    0F[DVERSION		    !* Push it to get out of the way!
    F[DFile E[ E\ FNE^ E]	    !* Push the input and output!
    FSHSname[A			    !* QA gets the login directory!
    QBuffer_FilenamesF"E
	:I*'FSDFILE		    !* QB gets the buffer filename!
    [Buffer_Filenames		    !* Push the buffer filenames!
    5,F Print_File[..4	    !* Q..4 will temporarily get the!
				    !* file to print!
    FQ..4:"G			    !* If no input file then want to!
				    !* print the buffer!
	-(WFSQPPTR-Q0) FSQPUNWIND !* Unwind the stack!
	:F"L @' F:M(M.M Print_Buffer)W'

    [c [d [e [f [g [h [i	    !* Push the temporary registers!

    1:< F[BBIND		    !* Get a temporary buffer!
	et..4		    !* set the defaults to QB!
	1,ER EG EC		    !* Have to open it to get the info!
	J4K :L .,zK HFX* fsdfile   !* Get the real name!
	f]BBIND>"N		    !* Out we go.  If we have an error!
	Q..4FSDFILE'		    !* then set the name manually!
    FSDFILEU..4
    Q..4 F(UPrint_Source_File)UPrint_Header
    QPrint_Device[..6		    !* Q..6 gets the default!
				    !* printing device!
    ET..4			    !* Set the default name to what we!
				    !* want to print!
    ET..6			    !* Set the default filename!
    ETLST			    !* With the extension LST!
    5,1FOutput_toU..6	    !* Get the alternate output device!
    ET..6			    !* if any!
    ETLST			    !* default file with ext=LST !
    FSDFILEUPrint_Destination_File	    !* Use this name for!
				    !* output!
    ]..6			    !* Do not use double dot registers!
				    !* for long!
    -(WFSQPPTR-Q0) FSQPUNWIND	    !* Unwind the stack!
    FM(M.M &_Print_Subroutine)W  !* Call the printing subroutine!
    
        

!& Print Subroutine:! !S Make LPT listing of a given file or of the buffer
replacing control-character by tilda-character.  The second string
argument is the alternate output device.

    The command can be in one of the following forms:

        <page size>,<page width> MM & Print Subroutine$
	                       via TECO in Minibuffer.
or
	<page width> MM & Print Subroutine$, Otherwise

	         with following defaults:
		 <page width> -- Q$Print Default Width$
		 <page size>  -- Q$Print Default Length$ - <lines of header>

    This subroutine assumes that the following variables are defined:

	Q$Print Header$		  -- Page Header to be used
	Q$Print Lines in Header$  -- Number of lines in Q$Print Header$
	Q$Print Source File$	  -- File to read from
	Q$Print Destination File$ -- File to send the output to
!

    FSRUNTIME[..5		    !* only ..5 to be used for runtime!
				    !* calculations.  No other!
				    !* ..register is used!
    F[DFile E[ E\ FNE^ E]	    !* Push the input and output!
    [Buffer_Filenames		    !* Push the buffer filenames!
    1F[^L Insert		    !* Make sure formfeeds are!
				    !* treated!
    !Free Registers:  D F G H I J K M N V 3 4 5 6 7 8 9!
    [A [B [C [E [L [O [P [Q [R [S [T [U [W [X [Y [Z [0 [1 [2 
				    !* Push registers!
    [..0 [..1 [..2 [..3		    !* Push these for the dispatch!
				    !* table!

				    !* Get the numeric arguments!
				    !* Q0 = length, Q1 = width!
    QPrint_LengthU0
    QPrint_WidthU1
				    !* If we were given any arguments!
    FF&3 F"N -1 F"G		    !* More than one!
	        F"N U0' W'	    !* Only if nonzero!
	    F"N U1' '	    !* Else it is the width!
    
    -2*(QPrint_Format"'N)+3F(+5UA)UPrint_Lines_in_Header
				    !* Fast prepare!
    Q0-QA "L			    !* Check to see if page!
				    !* length is big enough!
	QPrint_Length(-QA"L 58')U0 '	    !* And reset otherwise!

    QPrint_Format"N		    !* If the user wants miserly!
				    !* fashion then if the page size!
	Q0-57"G 60U0' '		    !* is 58 change it to the full page!

    Q1-15 "L			    !* Verify the validity of the page width!
	QPrint_Width(-15"L
		80')U1 '

    QPrint_Dispatch_TableU2	    !* Make dispatch table!
    QPrint_Signify_ControlUC	    !* QC gets the ascii value!
				    !* of the control!
				    !* character signifier!

    QPrint1_PTAG_StartUS	    !* QS gets tag start!
    QPrint1_PTAG_EndUE	    !* QE gets tag start!
    QPrint_WraparoundUW	    !* QW gets the wrap-around string!
    QPage_DelimiterUP		    !* QP gets the page delimiters!

    F[BBIND			    !* Get a temporary buffer to work!
				    !* with!
				    !* Check to see if QP has a CTRL/L!
    FQP"G GP'			    !* in it, and if not then put one in!
    J :S"E		    !* We also check to see that it is !
	J :S"E
	    12I z-1"N 15i' ' '	    !* properly defined!
    HFXP

				    !* Prepare to work with the file!

    QPrint_Source_FileUA
    1:<ERA>"N		    !* If any error for input then abort!
	:I*CError_in_Input_File_Specification.FSEchodisp
	:I*__Aborting_&_Print_Subroutine
	Input_Filename:__A
	fsechodisp0fsechoactive
	'

    QPrint_Destination_FileUA
    1:<:EWA>"N		    !* If any error for output then abort!
	:I*CError_in_Output_File_Specification.FSEchodisp
	:I*__Aborting_&_Print_Subroutine
	Output_Filename:__A
	fsechodisp0fsechoactive
	'

    13I 10I			    !* Make the page header!
    QPrint_Format"N		    !* If miserly format then the!
				    !* extras!
	2<Q1,45I 13I 10I>	    !* Two lines of dashes!
	-1L'"# 2R'		    !* Back over one of them!
    13I 10I 2R			    !* Make the space for the header!
    GPrint_Header 4,32I	    !* The header and four spaces!
    0,FSIFCDATEFSFDCONVERT	    !* followed with the date!
    Q1-FSHPOSITION-15F"G,32I'"#D'  !* Margin -15 for the page number!
    I_Page_ ZJ 13I 10I		    !* End with a blank line!
    HFXPrint_Header

    0UL 1UQ 0UR :IY		    !* QL is the current line count!
				    !* QQ is the current page!
				    !* QR is the current subpage!
				    !* QY gets the stuff for the index!

    0,1 M(M.M &_Insert_Header)W
    QPrint_Lines_in_Header-1 UL   !* Update the line count!
    HP	HK			    !* write out this portion of the file!

    QPrint_Page_Index UT	    !* QT nonzero means process tag!
				    !* when we can!
    
    QPrint_Control:"L		    !* If not embolden type!
	ONot-Embolden'
    QPrint1_Embolden_OverstrikeF"EW 2'UO  !* QO gets the!
				    !* number of times to overprint!

    QPrint1_Embolden_LengthF"EW 200'UX    !* QX gets vector length!
				    !* for emboldening!

    QX+2,32:IU			    !* QU gets the line of blanks and!
				    !* the emboldened characters!
    -1UZ
    < 1:A			    !* Keep going past end of a line.!
	M(M.M &_Test_Page)
	%L,Q0 M(M.M &_Test_Subpage)
	J :S	"L j M(M.M Untabify)'
	J <.,Z F2 .-z;
	    0AF(W-D)#100.F(I	    !* Delete control character and !
		):IB
	    .-1,QX F  *0:   F(,QZ F UZW
		):FUB	    !* replace with the!
	    >			    !* non-control one! 

	J <:S
;		    !* Search for any CR not LF!
	    1R -1D		    !* Backup!
	    QPrint_M-Control"N    !* put in the right thing!
		13' "# 77' F(I	    !* depending on the value of the!
		):IB		    !* variable !
	    .-1,QXF  *0:   F(,QZ F UZW  !* Put it in the minimum location!
		):FUB	    !* QZ gets the maximum position!
	    >
	ZJ 13,-1A-13"E OPASS'	    !* if the second last character is!
				    !* not a CR then!
	0,0a-10F"E		    !* We have a solitary linefeed!
	    QPrint_J-Control"N OPASS'    !* By pass if the variable so!
	    -1D			    !* indicates, else do!
	    .,QXF  *0:   F(,QZ F UZW    !* As above!
		):FU J W74I	    !* Replace in the string for emboldening!
	    QL-1UL		    !* Subtract one from the line count!
	    fslastpage"N !<!>'	    !* If this is not the last page!
				    !* then skip!
	    '-2"E		    !* We have a solitary FF!
	    -1D			    !* As for the LF!
	    .,QXF  *0:   F(,QZ F UZW
		):FU L W76I
	    QL-1UL
	    fslastpage"N !<!>''
	    
	!PASS!
	J 0L QZ:"L		    !* If we have an emboldening to make!
	    0,QZ+1:GU UUw -1UZ	    !* Get the substring to write!
	    QO<GU 13I>W		    !* Write it an CTRL/M QO times!
	    QX+2,32:IU'		    !* Fix up QU!
	M(M.M &_Wrap_and_Tag) ;    !* Returns fslastpage!
	>			    !* Go around again.!
    OIndex-Page		    !* !
    !Not-Embolden!
    QPrint_Control"G		    !* If we must dispatch then skip!
	OTilda-Control'
    < 1:A			    !* Keep going past end of a line.!
	M(M.M &_Test_Page)
	%L,Q0 M(M.M &_Test_Subpage)
	J HF2			    !* Dispatch on the stuff!
	J :S	"L j M(M.M Untabify)'

	M(M.M &_Wrap_and_Tag);	    !* Returns FS Lastpage!
	>			    !* Go around again.!
    OIndex-Page
    !Tilda-Control!
    < 1:A			    !* Keep going past end of a line.!
	M(M.M &_Test_Page)
	%L,Q0 M(M.M &_Test_Subpage)

 	J < .,ZF2 .-Z;	    !* Skip to next control character!
	    0AF(W-D QCI)#100.I>	    !* to convert it to tilda char.!

	J :S	"L j M(M.M Untabify)'

	QPrint_M-Control"E
	    J <:S
;	    !* Search for any CR not LF!
		1R -1D IC M    !* Replace with tilda-M!
		> '

	ZJ 13,-1A-13"E OPASS1'	    !* if the second last character is!
				    !* not a CR then!
	0,0a-10 F"E		    !* We have a solitary linefeed!
	    QPrint_J-Control"N OPASS1'
	    -1D IC J	    !* Replace LF with Identifier J!
	    QL-1 UL		    !* Subtract one from the line count!
	    fslastpage"N !<!>'	    !* Skip if not the last page!
	    '-2"E		    !* We have a solitary FF!
	    -1D IC L	    !* Replace with identifier L!
	    QL-1 UL		    !* Subtract one from the line count!
	    fslastpage"N !<!>'	    !* Skip if not the last page!
	    '
	!PASS1!
	M(M.M &_Wrap_and_Tag) ;    !* Returns FS Lastpage!
	>			    !* Go around again.!
    !Index-Page!
    FQY"G			    !* If we have an index at all!
	GY FKC			    !* Get the stuff!
	<.-z;			    !* For all of it!
	    :FB"L 1l'"# 1k'>   !* Get rid of blank lines!
	QQ:\UA -FK+1F"G UA' "# W 4UA'	    !* QA gets max page nu. length!
	QPrint_Page_Index"G	    !* If unsorted then omit!
	    0l \W 1:cW :L1l    !* Sort on the page numbers!
	    '
	J 13I 10I 12I		    !* Add a carriage return!
	%QW 0UR			    !* Increment the page count!
	QR,QQ M(M.M &_Insert_Header)W
	QPrint_Lines_In_Header-1UL	    !* Zero the line count!
	1l B,.P B,.K
	J <.-z;			    !* For each line!
	    %L,Q0 M(M.M &_Test_Subpage)
	    0L \UB 1C 0K	    !* Get the page number!
	    0UZ <:FB;	    !* Check to see how many line segments!
		0,1A-10"N %Z'	    !* Add them up!
		>
	    0L QZ"E M(M.M ^R_Delete_Horizontal_Space)'
				    !* Delete blanks if by itself!
	    0UZ <:FB; 1R	    !* Justify all line segments to !
		M(M.M ^R_Delete_Horizontal_Space)W  !* printing width!
		2,32I		    !* Add two spaces to end of line!
		0,2A-10"N	    !* Check if not a LF ending the line!
		   Q1-FSHPOSITION-QA-2 F"L D'W	    !* Delete some if!
				    !* too long!
		   FSHPOSITION,QZ F UZW ' !* QZ holds the maximum!
				    !* line segment length!
		"#
		   QZ-FSHPOSITIONF"G,32I'W !* Insert enough spaces to get the!
				    !* longest line !
		   Q1-FSHPOSITION-QA-2 F"G,46I' "# D''	    
				    !* Otherwise add dots to the line!
				    !* to pretty it up!
		1:C >W		    !* Skip over the CR and continue!
	    W:LW 32IW QA,QB\W 1l
	    B,.P B,.K>		    !* Add a space and the page number!
	HP HK			    !* Write out the stuff!
	    '
    EC :EF			    !* Close the IO files!
    F]BBIND			    !* Pop the buffer!

    fsofileUA			    !* Put in the mode line the output!
    (FS RUNTIME-Q..5+500)/1000:\ UB	    !* file and the amount of runtime!
    :i*COutput_to_A_completed_in_B_sec.Afsechodisp
    0FS ECHO ACTIVE
    
 

!& Test Page:! !S This subroutine test to see if we have a page definition.
    No arguments are used, but this subroutine cannot be used
    individually without the setups designed by the module
    & Print Subroutine.!

    J:FBP"E '		    !* Found a page delimiter!
    FKC				    !* Back up over it!
    ."N '			    !* If at the buffer beginning then!
				    !* A True page delimiter!
    %QW 0UR			    !* Increment page count!
    QPrint_Format"E		    !* If not miserly format!
	1A-12"N 12I'		    !* Check for a FF!
	"# 1C'			    !* If no formfeed here then insert!
	-1Ul'			    !* one!
    "# 1a-12"E 1D''		    !* If miserly then delete the FF!
				    !* if there is one!
    QPrint_Page_Index UT	    !* A possible check for tags!
    QR,QQ M(M.M &_Insert_Header)W  !* Put in the header!
    QPrint_Lines_In_Header+QL-1UL !* Increase the line count!
    1L B,.P B,.K		    !* Write out this region!
    

!& Test Subpage:! !S Test for subpage and inserts header.
Two arguments are required.  The precomma argument is the current line
number to be used and the post-comma argument is the page length.
This subroutine cannot be used alone and must be used only by 
MM & Print Subroutine.  QR is the Subpage Count, QQ is the page count
and QL is the current line count.!

    -(/*)"N '		    !* Fast exist if we have nothing!
   
    QPrint_Format"E 12I'	    !* If not miserly format!
				    !* then put in a FF!
    %R,QQ M(M.M &_Insert_Header)W  !* Put in the header!
    +QPrint_Lines_In_HeaderUL   !* Update the line count!
    1l B,.P B,.K		    !* Copy out the stuff!
    

!& Insert Header:! !S Inserts the header and page numbers into the buffer.
The numeric arguments are <subpage>,<page>.  This macro makes use of
the two variables Q$Print Header$ and Q$Print Lines in Header$, and
assumes that their contents are correct.!

    GPRINT_HEADER  FKC	    !* Insert the header!
    QPRINT_LINES_IN_HEADER-3 F"G @L'	    !* Put us in the right!
				    !* place!
    :L F"G \'			    !* Put in the page number!
    F"G F(W 58I)\'		    !* Put in the subpage number!
    2@L				    !* go to the end of the header!
    

!& Wrap and Tag:! !S Subroutine for checking for wraparound and finding tags.
    This subroutine can only be used with MM & Print Subroutine and
    should not be used alone.!
    [C [D
    :IB FQW F"G,32:IB'		    !* QA is temporary and QB is!
    !AGAIN!			    !* the wraparound in blanks!
    :IA J <:S :		    !* Search for any CR!
	Q1-FS H Position F"L C	    !* Back over if the line too long!
	    :IAAB	    !* QA gets the wrapover!
	    .,(:S :.)@FXA	    !* Append and kill into QA!
	    :IAA'	    !* Tack on the control M!
	1:C; FSSVALUE;>	    !* If last search failed then exit!
    ZJ 64,0A-32"'L C		    !* Backup if a control character!
    FQA "G			    !* We have a wraparound!
	0,0A-13"N 13I'		    !* Add a CR if none!
	10I			    !* Add a LF!
	%L,Q0 M(M.M &_Test_Subpage)W	    !* Test for page break!
	GW GA FKC FQBD		    !* Put in the wrap and fix line!
	Oagain			    !* Make we wrap all the lines!
				    !* needing it!
	'

    QT"E OSKIP'		    !* We may have a tag!
    J < 1UD .-z;		    !* We search for a line with!
				    !* something on it for the tag!
	0UD :FB :;		    !* Search the line for a character!
	1@L>			    !* Keep going!
    QD"N OSKIP'		    !* If ended with nothing skip over!
    0l 0UT			    !* Reset the tag variable!
    <:FBS & (w:FBE) "'N; %T>	    !* Check for the!
				    !* number of true tags!
    0l				    !* To the beginning of the line!
    QT F"G<			    !* For the number of tags defined!
	    QQ:\UB		    !* QB will get the tag, starting!
				    !* with the page number and a!
	    :IBB_		    !* blank space!
	    FBS		    !* Search ahead for the tag start!
	    .,(FBE FK F(UA	    !* QA = number of char to move!
		   )C.)@XB	    !* QB now has a tag!
	    :IYYB
	    			    !* Append it to the index register!
	    QAR			    !* Skip back over those characters!
	    > '
    "#				    !* If no tag the the whole line!
	QQ:\UB			    !* QB gets the page number and a!
	:IBB_		    !* blank!
	:@XB			    !* Append the line to QB!
	:IYYB
	'			    !* Append it to QY!
    0UT				    !* Zero the tag indicator!
    !SKIP!
    ZJ 0,0A-12"'EC		    !* Back over any Formfeed!
    B,.P B,.K			    !* Write out this portion!
    fs lastpage 		    !* Stop if at eof in original file.!


!& Kill PRINT Library:! !S Kill the variables used by the PRINT Library!


    M(M.M Kill_Variable)Print1_Control
    M(M.M Kill_Variable)Print1_Discard_Character
    M(M.M Kill_Variable)Print1_Embolden_Length
    M(M.M Kill_Variable)Print1_Embolden_Overstrike
    M(M.M Kill_Variable)Print1_PTAG_End
    M(M.M Kill_Variable)Print1_PTAG_Start
    M(M.M Kill_Variable)Print1_Real_Control
    M(M.M Kill_Variable)Print1_Wraparound
    M(M.M Kill_Variable)Print_Control
    M(M.M Kill_Variable)Print_Destination_File
    M(M.M Kill_Variable)Print_Device
    M(M.M Kill_Variable)Print_Discard_Character
    M(M.M Kill_Variable)Print_Dispatch_Table
    M(M.M Kill_Variable)Print_Embolden_Length
    M(M.M Kill_Variable)Print_Embolden_Overstrike
    M(M.M Kill_Variable)Print_Format
    M(M.M Kill_Variable)Print_Header
    M(M.M Kill_Variable)Print_J-Control
    M(M.M Kill_Variable)Print_Length
    M(M.M Kill_Variable)Print_Lines_in_Header
    M(M.M Kill_Variable)Print_M-Control
    M(M.M Kill_Variable)Print_Page_Index
    M(M.M Kill_Variable)Print_PTAG_End
    M(M.M Kill_Variable)Print_PTAG_Start
    M(M.M Kill_Variable)Print_Real_Control
    M(M.M Kill_Variable)Print_Signify_Control
    M(M.M Kill_Variable)Print_Source_File
    M(M.M Kill_Variable)Print_Width
    M(M.M Kill_Variable)Print_Wraparound

    QPrint_Old_LibraryF([A) UPrint_Library
    M(M.M Kill_Variable)Print_Old_Library
    1:<M(M.M &_Setup_A_Library)W>

    

!0:! !C ...!
    

!*
/ Local Modes: \
/ MM Compile: M(M.MTECO Mode)
1:<M(M.M^R Date Edit)>W
M(M.M^R Save File)W
M(m.mGenerate Library)em:PRINTem:PRINTW
M(M.m& Generate Massive Library)
1M(M.M^R Invoke Inferior)*ena
Delete em:print.comprs.*
Copy em:print.* e6:
Copy e6:print.:ej e:
disa
pop
 \
/ end: \
!
