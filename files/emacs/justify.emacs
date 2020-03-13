!* -*-TECO-*- *!					

!~Filename~:! !Library of routines to do automatic justification.!
JUSTIFY


!& Setup JUSTIFY Library:! !S Sets up for automatic justification.!

   0FO..Q JUSTIFY_Setup_Hook[1	        !* Does loader have setup hook? *!
   Q1"N M1'				!*    yes, execute it *!
     "#					!*    no, so do the default *!

     0FO..Q Auto_Justify_Mode F"E 	!* Setup the justify flag variable. *!
       0M.VAuto_Justify_Mode 		!* Initially it is turned off. *!

       !** Setup the description of the mode variables. **!

       @:I1|!*_1_=>_Auto_Justify_(Justify_paragraph_to_point)!
            1FS MODE CHANGE		!* Signal a mode change. *!
            32FS ^R INITU_		!* Put space back like it was. *!
            "E '			!* Do nothing else, if out of mode. *!
              "# 0UAuto_Fill_Mode	!* Take us out of Auto Fill Mode. *!
                 M.M^R_Auto-Justify_SpaceU_'| !* Redefine space. *!
       M.CAuto_Justify_Mode1    !* Set up the description. *!

       @:I1|!*_1_=>_Auto_Fill_(Break_long_lines_at_margin)!
            1FS MODE CHANGE		!* Signal a mode change. *!
            32FS ^R INITU_		!* Put space back like it was. *!
            "E '			!* Do nothing else, if out of mode. *!
              "# 0UAuto_Justify_Mode !* Take us out of Auto Justify Mode.*!
                 M.M^R_Auto-Fill_SpaceU_'| !* Redefine space. *!
       M.CAuto_Fill_Mode1 	!* Set up the description. *!

      !** Append code to the Set Mode Line Hook which will make the **!
      !** appropriate display when in Auto Justify Mode. **!

      QSet_Mode_Line_Hook[2
      @:ISet_Mode_Line_Hook|2+0[1
        FQ1"L :I1'			!* If nothing before, null it out. *!
        QAuto_Justify_Mode"N [2 :I2_Justify' !* Add the string Justify *!
                            "# [2 :I2' !*    if in that mode. *!
        :I* 12' (]1)| !* Return the string pointer. *!

      1FS MODE CHANGE 			!* Indicate mode has changed. *!
      0				!* End of the setup stuff. *!


!& File JUSTIFY Loaded:! !? If this is defined, JUSTIFY is loaded.!
    Note macro bodies are not allowed to be empty.


!Auto Justify Mode:! !C Break lines between words at right margin and justify.
A positive argument turns Auto Justify mode on; zero or negative,
turns it off.  With no argument, the mode is toggled.  When  Auto
Justify mode  is  on,  lines  are  broken  at  the  right  margin
(position controlled by Q$Fill Column$) at spaces, by doing a LF.
Then the paragraph is justified to  that point.  You can set  the
Fill Column with the ^R Set Fill Column.!

    [0					!* Place the argument in Q0. *!
    FF"N "N 1U0' "# 0U0''		!* Arg => set from the arg. *!
      "# 0FO..Q Auto_Justify_Mode"E 1U0' "# 0U0'' !* No arg => toggle. *!
    Q0M.L Auto_Justify_Mode		!* Set the Auto Justify variable. *!
    Q0"N 0M.L Auto_Fill_Mode 		!* These are mutually exclusive. *!
         M.M ^R_Auto-Justify_SpaceU_' !* Setup the definition of space. *!
    1FS MODE CHANGE			!* Update and display the update. *!
    0


!Auto Fill Mode:! !C Break lines between words at the right margin.
A positive  argument  turns  Auto  Fill  mode  on;  zero  or
negative, turns  it  off.  With  no  argument, the  mode  is
toggled.  When Auto Fill mode is on, lines are broken at the
right margin  (position  controlled by  QFill  Column)  at
spaces, by doing a LF.  You can set the Fill Column with the
^R Set Fill Column.!

    !** This is a modified version of Auto Fill Mode. **!

    [0					!* Place the argument in Q0. *!
    FF"N "N 1U0' "# 0U0''		!* Arg => set from the arg.!
      "# 0FO..Q Auto_Fill_Mode"E 1U0' "# 0U0''	!* No arg => toggle.!
    Q0M.L Auto_Fill_Mode		!* Set the Auto Fill variable. *!
    Q0"N 0M.L Auto_Justify_Mode ' 	!* These are mutually exclusive. *!
         M.M ^R_Auto-Fill_SpaceU_' 	!* Setup the definition of space. *!
    1FS MODE CHANGE			!* Update and display the update. *!
    0


!^R Auto-Justify Space:! !^R Insert space, but if at margin, justify paragraph to that point.
QFill Column controls where the margin is considered to be.
QSpace Indent Flag, if 0, inhibits indenting new lines.
With arg of 0, inserts no space, but may break line.
With arg > 1, inserts several spaces and does not break line.!

    !** This is a modified version of ^R Auto-Fill Space. **!

    M(32FS ^R INIT) 		!* First, insert spaces the ordinary way. *!
    -1"G 0'			!* Then, if argument 0 or 1, and we're *!
				!*   past the margin *!
    0FO..QFill_ColumnF"N F[ ADLINE '	!* Set the line size. *!
    FS ADLINE[1		!* Q1 gets margin column. *!
    FS HPOS-Q1-:"G 0'	!* (not counting spaces just inserted in *!
				!*   that test), then *!
    Z-.[0  FN Z-Q0J		!* (after arranging that we can move *!
				!*   point temporarily) *!
    < .-1,(0L .):FB_"E 0'	!* find the space before this one.  *!
				!*   Return if none. *!
      Q1-FS HPOS;>		!* If that space also too far right, *!
				!*   go to previous. *!
    @F_L			!* Kill all spaces there, *!
    @-F_K			!*   in case they are multiple. *!
    :FX1			!* Copy away stuff after it, *!
				!*   so we are at EOL. *!
				!* So we can gobble following blank line *!
				!*   if any. *!
    .-Z(			!* If we do that, Q0 must be changed *!
				!*   the same amount *!

    !*** Go to new line and indent, maybe, or start a comment if nec. *!
	 @M(M.M^R_Indent_New_Comment_Line)F
         )+Z-.+Q0U0		!* that Z-. now changes. *!

    :0@L .[3 .[4		!* Mark this as start of updated region. *!
    @L				

    0FO..QComment_Start[2	!* Are there comments? *!
    Q2"N			!* If there are comments, *!
      :FB2"N			!*    and if we are in a comment, *!
        :@L QComment_EndU2	!*    flush the comment terminator *!
				!*    that was just inserted *!
        Q2"N -FQ2F~2"E	!*    and adjust the final *!
          -FQ2D Q0-FQ2U0''	!*    position of point. *!
        :@L G1'			!* Get back what followed the space *!
				!*    on the line. *!

      "# F~MODELISP"E	!* If in LISP mode, *!
         @M(M.M ^R_Indent_According_to_Mode) !* Indent *!
         :@L G1 '		!*    and then get what followed the space. *!

      "#			!*** This could cause problems with code. ***!
      .U4 @M(M.M ^R_Backward_Paragraph) !* Find start of the paragraph. *!
      @F_	
J !* Go to first nonblank character. *!
      .-Q4"G Q4J' .U3		!* Save this point. *!
      :@L G1			!* Get back what followed the space *!	
				!*    on the line. *!
      Q3,.FA '''		!*    and then justify it. *!

      "#			!* Otherwise, justify the paragraph. *!
      .U4 @M(M.M ^R_Backward_Paragraph) !* Find start of the paragraph. *!
      @F_	
J !* Go to first nonblank character. *!
      .-Q4"G Q4J' .U3		!* Save this point. *!
      :@L G1 			!* Get back what followed the space *!	
				!*    on the line. *!
      Q3,.FA '			!*    and then justify it. *!

    FS RGETTY"E :0T'		!* Echo reasonably on printing tty. *!
    Q3,.			!* Return range since where that space was. *!


!^R Auto-Fill Space:! !^R Insert space, but CRLF at margin.
QFill Column controls where the margin is considered to be.
QSpace Indent Flag, if 0, inhibits indenting new lines.
With arg of 0, inserts no space, but may break line.
With arg > 1, inserts several spaces and does not break line.!

    M(32FS ^R INIT) 		!* First, insert spaces the ordinary way. *!
    -1"G 0'			!* Then, if argument 0 or 1, and we're *!
				!*   past the margin *!
    0FO..QFill_ColumnF"N F[ ADLINE '	!* Set the line size. *!
    FS ADLINE[1		!* Q1 gets margin column. *!
    FS HPOS-Q1-:"G 0'	!* (not counting spaces just inserted in *!
				!*   that test), then *!
    Z-.[0  FN Z-Q0J		!* (after arranging that we can move *!
				!*   point temporarily) *!
    < .-1,(0L .):FB_"E 0'	!* find the space before this one.  *!
				!*   Return if none. *!
      Q1-FS HPOS;>		!* If that space also too far right, *!
				!*   go to previous. *!
    @F_L			!* Kill all spaces there, *!
    @-F_K			!*   in case they are multiple. *!
    :FX1			!* Copy away stuff after it, *!
				!*   so we are at EOL. *!
				!* So we can gobble following blank line *!
				!*   if any. *!
    .-Z(			!* If we do that, Q0 must be changed *!
				!*   the same amount *!

    !*** Go to new line and indent, maybe, or start a comment if nec. *!
	 @M(M.M^R_Indent_New_Comment_Line)F 
         )+Z-.+Q0U0		!* that Z-. now changes. *!

    :0@L .,(			!* Mark this as start of updated region. *!
    @L				

    !* In a comment, continue the comment on the next line. *!
    QComment_Start[2	
    Q2"N :FB2"N		!* If we are in a comment, *!	
        :@L QComment_EndU2	!*    flush the comment terminator *!
				!*    that was just inserted *!
        Q2"N -FQ2F~2"E	!*    and adjust the final *!
          -FQ2D Q0-FQ2U0''''	!*    position of point. *!
    :@L G1			!* Get back what followed the space *!

    FS RGETTY"E :0T'		!* Echo reasonably on printing tty. *!
    ).			!* Return range since where that space was. *!


!^R Fill Region:! !^R Fill text from mark to point.
QFill  Column  specifies  the  desired  text  width.    An
explicit positive  argument (or  Auto Justify  Mode)  causes
adjusting instead of  filling.  A  negative argument  causes
"un-filling": removal of excess spaces.!

    !** This is a modified version of ^R Fill Region. **!

    [1					!* Justify the region? *!
    QAuto_Justify_Mode"E :I1justify'	!* If in justify mode, justify. *!
    "# FF"E :I1fill' 		!*    If no arg *!
       "# "L :I1fill'		!*    or negative arg, fill, *!
          "# :I1justify'''		!*    else justify. *!
    Q1M(M.M &_Save_Region_and_Query)F"E '

    F[VB F[VZ
    0FO..Q Fill_Prefix[1		!* Get the Fill Prefix if any. *!
    Q1"E FQComment_End-1"L		!* If editing code, *!
					!*    use comment start *!
					!*    as fill prefix *!
     QComment_Start F"N U1'''		!* So paragraphs of comments can be *!
                                        !*    edited. *!
					!* But this won't work if comments *!
					!*    need terminators. *!
    QFill_Extra_Space_List[2
    0FO..QFill_ColumnF"N F[ ADLINE '	!* Set the line size. *!
    .,(W.)FFSBound			!* Push bounds and set the to *!
					!*    region. *!
    FQ1"G J<.-Z; FQ1F=1"E FQ1D' L>' !* Delete the prefix from the *!
					!*    front of each line. *!
    FN B: ZJ				!* When we exit, leave mark at *!
					!*    front and point at end. *!
    J< .-Z; :L 0,0AF2+1"G I_' L>	!* Put an extra space after each *!
					!*    sentence-end at eol. *!
    FF"N				!* Adjust? *!

     J  :S_				!* Start at the beginning of the *!
					!*    text for justification. *!
        <:S__; 0,-2AF2+1"E -D'	!* If find 2 spaces, delete 2nd if *!
					!*    not after period, etc, *!
        @F_K>'			!*    and in any case delete any *!
					!*    more spaces. *!

     QAuto_Justify_Mode-1"E HFA'	!* If in Auto Justify Mode, justify.*!
       "# FF"E @HFA'		!*    If no arg *!
          "# "L @HFA'			!*    or negative arg, fill, *!
             "# HFA'''			!*    else justify. *!
    FQ1"G J <.-Z; G1 L>'		!* Put the prefix (if any) back in *!
					!*    on each line. *!
    ZJ H


!^R Fill Paragraph:! !^R Fill (or adjust) this (or next) paragraph.
Point stays the same (but text may move past it due to filling).
A positive numeric argument says adjust rather than fill.!

    !*** This is a modified version of ^R Fill Paragraph. ***!

    .[0				    !* Save point. *!
    @M(M.M ^R_Mark_Paragraph)	    !* Put region around this or *!
    W				    !*    next paragraph. *!

    @F_	
J .: !* If adjusting, make *!
				    !*    sure of the para. beginning. *!

    :-Z[1			    !* Save address of end, relative to Z. *!
    F@M(M.M ^R_Fill_Region)(	    !* Fill it, save range returned *!
				    !*    to pass on. *!
      Q1+Z-Q0"L Q1+ZU0'		    !* Without moving past end of paragraph,*!
      Q0:J"L			    !* restore old point if possible. *!
        0,1A-10"E C'		    !* If between CR and LF, move out. *!
	Q1+Z-Q0"E 0@F"E :@0L''' 
      )
-------
