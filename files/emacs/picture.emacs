!* -*-TECO-*- *!

!~Filename~:! !Commands for editing pictures made out of characters.!
PICTURE

!Edit Picture:! !C Enter a mode for editing a picture in the buffer.
The picture should be between point and mark, to begin with.
Edit Picture inserts spaces to pad out to the margin, then enters
a special mode in which these characters are redefined:
Rubout turns characters into spaces rather than deleting them.
Ordinary characters replace instead of inserting.
Return moves to the beginning of the next line.
Linefeed is like M-M followed by C-N.
C-O makes one or more new lines full of spaces after point.
When you exit the recursive ^R, the excess spaces are removed.!

    0fo..qWord_Abbrev_Mode"n	    !* Word abbrevs lose in pictures, if!
				    !* they're on!
	0[Word_Abbrev_Mode'	    !* bind them off temporarily!
    0[Auto_Fill_Mode		    !* Auto Fill loses in pictures too!
    m(m.m Pad_Picture)[1[2 fsz-q1u1
    fn fsz-q1,q2 m(m.m Strip_Picture)  [1
    f[^R Normal		    !* Want it restored when exit, in!
				    !* case user changes it with!
				    !* cursor movement-control commands.!
    -1f[^r replace
    1fsModeChw			    !* so FS ^R REPLACE binding shows!
    m.m ^R_Picture_Rubout[
    m.m ^R_Picture_Return[M
    m.m ^R_Picture_Indent_Under[I
    m.m ^R_Picture_Make_New_Line[.O
    m.m ^R_Picture_End_of_Line[.E
    :i*Picture[Submode
    0fo..qEdit_Picture_Hookf"nu1 m1'w
    
    

!^R Picture Make New Line:! !^R Make a new line of spaces before the current one.!

    < 0l fswidth-1,32i i
>
    -l f 

!^R Picture Return:! !^R Move to beginning of next line.!

    @L .

!^R Picture Indent Under:! !^R Indent under start of text on previous line.!

    -l @f_l
    fs shpos( l )c .

!^R Picture Rubout:! !^R Turn the previous character into a space.!

    <
      :r"e fg'
      "# 1af
"l f_' >
     

!^R Picture End of Line:! !^R Go to End of Line.!
    :l -@f_r .

!Strip Picture:! !C Remove trailing spaces from picture.
Removes trailing spaces from all lines between point and mark.
Alternatively, a range may be specified with two numeric arguments.!

    F[VB F[VZ
    FF"N FF  FS BOUND'
    "# .,(W).F  FS BOUND'	    !* Set bounds to region, for the moment.!
    J
    < :L .-Z;			    !* At the end of each line,!
      -@F_K			    !* delete all spaces.!
      L >
    J Z:
    H

!Pad Picture:! !C Pad lines with trailing spaces to screen width.
Adds enough trailing spaces to each line between point and mark.!

    F[VB F[VZ
    .,(w).F  FS BOUND	    !* Set bounds to region, for the moment.!
    J
    < :L .-Z;			    !* At the end of each line,!
      FS WIDTH-1-(FS SHPOS),32I   !* Add enough spaces to reach right margin.!
      L >
    J Z:
    H

!Right Picture Movement:! !C Set so cursor moves left (as usual) after inserting/replacing.!
 :i*C(right)fsEchoDisplay 0fsEchoActivew
 0fs^RNormalw 1

!Left Picture Movement:! !C Set so cursor moves left after inserting/replacing.!
 :i*C(left)fsEchoDisplay 0fsEchoActivew
 m.m&_Left_Normalfs^RNormalw 1

!Up Picture Movement:! !C Set so cursor moves up after inserting/replacing.!
 :i*C(up)fsEchoDisplay 0fsEchoActivew
 m.m&_Up_Normalfs^RNormalw 1

!Down Picture Movement:! !C Set so cursor moves down after inserting/replacing.!
 :i*C(down)fsEchoDisplay 0fsEchoActivew
 m.m&_Down_Normalfs^RNormalw 1

!& Left Normal:! !S replace and move left!
 0f[^RNormal			    !* Off temporarily so non-recursive!
 .(@m(64fs^RInit)w)j
 fs^RReplace"n 0f  "g r'' 1

!& Up Normal:! !S replace and move up!
 0f[^RNormal			    !* Off temporarily so non-recursive!
 fs^RHPos(
    .(@m(64fs^RInit)w)j
    )fs^RHPosw
 -l
 1:< 0,(fs^RHPos)fm >w 1

!& Down Normal:! !S replace and move down!
 0f[^RNormal			    !* Off temporarily so non-recursive!
 fs^RHPos(
    .(@m(64fs^RInit)w)j
    )fs^RHPosw
 l
 1:< 0,(fs^RHPos)fm >w 1
