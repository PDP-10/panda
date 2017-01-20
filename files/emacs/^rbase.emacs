!* -*-TECO-*-!

!^R Backwards Kill Characters:! !^R Kills characters forward or back.
A nonzero precomma argument means hack tabs if going backwards.
A positive arg means go backwards.  This is the default FS RUBMAC.!

    -[9 [1 .[2
    .-Z[3			    !* If we do convert some tabs before point,!
				    !* Q3+Z will still point at the chars where point was.!
    "G
      < "N			    !* If moving backwards, maybe we should hack tabs.!
	    0,0A-9"E R		    !* If so, move back over N characters,!
              FS S HPOSU1 .U2	    !* turning tabs into spaces.!
	      8-(Q1-(Q1/8*8)),32I D''
	  -2 F=
"E R'				    !* In any case, treat CRLF as one char.!
	  R >'
    "L -< 2 F=
"E C' C>'			    !* Moving forward, just treat CRLF as one char.!
    .,Q3+ZF M(M.M &_Kill_Text)    !* Kill the text we have just delimited.!
    Q2-."L Q2,.'
    0 

!^R Set/Pop Mark:! !^R Sets or pops the mark.
With no ^U's, pushes . as the mark.
With one ^U, pops the mark into .
With two ^U's, pops the mark and throws it away.

If the variable Push Point Notification exists, it is printed in
the echo area in the no ^U case.!

      FF"E .:		    !* No arg sets mark.!
        0fo..qPush_Point_NotificationF"N[1 @ft_1
	 0fs echo active''
      -4"E .:W W 1:<>'	    !* To pop mark, actually push and then pop twice!
      -15"G .(1:<> W)J'	    !* 2 ^U's pops stack but doesn't go there.!
      0

!^R Down Real Line:! !^R Move down vertically to next real line.
Continuation lines are skipped.  If given after the
last LF in the buffer, makes a new one at the end.!

!* If Q.H contains a 1 in the left half, then its right half is a "permanent goal",!
!* and we should not clobber it.  Otherwise, it contains a temporary goal,!
!* which we should clobber if previous character wasn't vertical motion.!

    FS ^R PREV-1002"N		    !* If previous command wasnt up or down real line,!
       Q.H-777777."L		    !* and goal isn't permanent,!
          FS ^R HPOSU.H''	    !* Current hpos becomes goal. Else goal not changed.!
    1002 FS ^R LAST		    !* Identify this command as up or down real.!
    FF"E @:L		    !* special hack for no arg:  first go to end of line!
         .-Z"E I
          -2 '		    !* then if no next line, make one.!
         L'			    !* if there is one, go to it.!
      "# @L'			    !* Do have arg => move that many lines.!
    1:< 0,Q.H&777777. :FM >	    !* Find our goal, horizontally.!
    FS I&DLINE"N FS OSPEEDF"N-1200:"G 99F[%CENTER @0V'''
    0

!^R Up Real Line:! !^R Move up vertically to next real line.
Continuation lines are skipped.!

    FS ^R PREV-1002"N		    !* If previous command wasnt up or down real line,!
       Q.H-777777."L		    !* and goal isn't permanent,!
          FS ^R HPOSU.H''	    !* Current hpos becomes goal. Else goal not changed.!
    1002 FS ^R LAST		    !* Identify this command as up or down real.!
    @-L
    1:< 0,Q.H&777777. :FM >	    !* Find our goal, horizontally.!
    FS I&DLINE"N FS OSPEEDF"N-1200:"G 0F[%CENTER @0V'''
    0

!^R Set Goal Column:! !^R Set (or flush) a permanent goal for vertical motion.
With no argument, makes the current column the goal for vertical
motion commands.  They will always try to go to that column.
With argument, clears out any previously set goal.  Only
^R Up Real Line and ^R Down Real Line are affected.!

    -1"n 0u.h @ft		    !* Either clear the goal column,!
No_Goal_Column '
    "# fs ^r hpos+1000000. u.h	    !* Or set it and say what it now is.!
       q.h &7777.:\[0 @ft 
Goal_Column_=_0 '
    0fsecho act		    !* Don't clear the echo area afterward.!

!^R Down Indented Line:! !^R Move down a line, and past any indentation.
If no arg, and done on the last line, makes a new line to go to.!

    FF"E :L			    !* special hack for no arg:  first go to end of line!
         .-Z"E I
          -2 '		    !* THEN IF NO NEXT LINE, MAKE ONE.!
         L'			    !* IF THERE IS ONE, GO TO IT.!
      "# @L'			    !* DO HAVE ARG =) JUST GO THERE.!
    @F_	R		    !* Skip forward over spaces and tabs.!
    0'

!^R Up Indented Line:! !^R Move up a line, and past any indentation on it.!

    -@L
    @F_	R		    !* Skip forward over spaces and tabs.!
    0'

!^R Back to Indentation:! !^R Move to end of this line's indentation.!

    @0L				    !* Go to line beginning.!
    @F_	R		    !* Skip forward over spaces and tabs.!
    0'

!^R CRLF:! !^R Insert CRLF, or move onto blank line.
A blank line is one containing only spaces and tabs
(which are killed if we move onto it).  Single blank lines
(followed by nonblank lines) are not eaten up this way.
In auto-fill mode, we may break the line before the last word.
A pre-comma arg inhibits this.!

    FF&1"N <I
> -*2 '			    !* With arg, simply insert that many CRLFS!
    "E 0M_F'		    !* If Auto-fill, maybe break the line.!
    QComment_End[2		    !* If at end of line before a comment end, go past it!
    FQ2"G :@F F~2"E
      FQ2-1:G2*5+1:G..D-)"N	    !* unless the comment end string ends with a closeparen.!
        :@L'''
    .[0 3@L			    !* If the rest of this line, and the next two,!
    .[1 Q0J .,Q1 @F_	
R  .-Q1"E			    !* Are entirely composed of whitespace (aside from CRLFs)!
       Q0J :K			    !* Then move onto the following blank line!
       .-Z"N
         @L :K Q0,.''		    !* and kill any spaces on it.!
    Q0J I
				    !* Otherwise insert one.!
    @F_	R
    :@F  "E 0K' 0L		    !* and if line after point now is blank, empty it.!
    Q0,.

!^R Kill Region:! !^R Kill from point to mark.
Use ^R Un-Kill and ^R Un-Kill Pop to get it back.!

    .[0 W .-Q0[9		    !* Q0 gets point, point gets mark, Q9 neg if backward!
    Q:..K(0)[1 FQ1:"L		    !* If region matches the text in the kill ring,!
      -Q9 F~1"E		    !* just flush it, don't push it again.!
        -Q9D 0 ''
    .,Q0F  :M(M.M&_Kill_Text)	    !* Kill the stuff!

!^R Copy Region:! !^R Stick region into kill-ring without killing it.
Like killing and getting back, but doesn't mark buffer modified.!

    [1 [0
    FS ^R PREV-1001"E		    !* No string => if prev command also killed, append.!
      :-."L			    !* Actually, prepend, if deleting backwards.!
	:,.X1 Q:..K(0)U0
	:I:..K(0)10 1'
      :,.F  @X:..K(0) 1'	    !* Forwards => append.  That is easier.!
    Q..K[..O ZJ-5D		    !* Push slot onto ring!
    J 5,0I ]..O			    !* by flushing oldest, making space at front,!
    :,.F  X:..K(0)		    !* and storing into it.!
    1

!^R Append Next Kill:! !^R Make following kill commands append to last batch.
Thus, C-K C-K, cursor motion, this command, and C-K C-K,
generate one block of killed stuff, containing two lines.!
    1001 fs ^r lastw 0

!^R Delete Blank Lines:! !^R Kill all blank lines around this line's end.
If done on a non-blank line, kills all spaces and tabs
at the end of it, and all following blank lines
(Lines are blank if they contain only spaces and tabs).
If done on a blank line, deletes all preceding blank lines as well.!

    .[0  fn q0j @L		    !* Arrange to preserve point.  Move to after this line.!
    0A-
"n 0'		    !* Do nothing if at EOB and no CRLF before.!
    -@f
_	l			    !* Find start of blankness.  Kill blanks ending last nonblank line!
!*** Now, exempt one CRLF from deletion if we gave the command on a blank line.!
    @:f -q0"l @l'
    .-q0"l .u0'  .[1
    < .-Z; @f_	-(:@f ):@;	    !* Move over all following blank lines.!
      l>
    .-Q1"e 0 '		    !* No blank lines => nothing to delete.!
    q1-2,.f=			    !* One empty line (following a CRLF) => delete it.!

"e -2d 0 '
    q1,.k i			    !* Else replace all blank lines with just one.!
 -2 

!^R Kill Line:! !^R Kill to end of line, or kill an end of line.
At the end of a line (only blanks following) kill through the CRLF.
Otherwise, kill the rest of the line but not the CRLF.
With argument (positive or negative), kill specified number of lines.
An argument of zero means kill to beg of line, nothing if at beg.
Killed text is pushed onto the kill ring for retrieval.!

  "G .-Z"E FG 0' '
    "# .-B"E FG 0 ' '		    !* Complain at end of buffer!
  FF"N [9 
    "L 0@F  "N %9''		    !* Negative arg meaning not same as K command - compensate!
    Q9(				    !* Q9 is arg for K command.!
    Q9"E -1U9''			    !* Kill to beg of line is backward killing.!
  "# 1[9 .[0
     @F_	R		    !* Otherwise, skip whitespace!
     .[2 @:L Q2-."E L'		    !* If that brings us to end of line, kill thru end of line!
				    !* otherwise kill to end of line.!
     Q0,.('
  ):M(M.M &_Kill_Text)		    !* Wipe it out!

!^R Un-kill:! !^R Re-insert the last stuff killed.
Puts point after it and the mark before it.
An argument n says un-kill the n'th most recent
string of killed stuff (1 = most recent).  A null
argument (just C-U) means leave point before, mark after.!

    Q..O U:..U(0)  :I:..U(1)	    !* Arrange for undoing.!
    .U:..U(2) FSZ-.U:..U(3)	    !* Note that M-Y need not change these values, ever.!
    :I:..U(4)un-kill

    FS ^R ARGP[1
    Q1-1"G -1+'0 [0		    !* Arg in Q0, says how far down ring bfr to look!
    .:W G(Q:..K(Q0)F"EW :I*')    !* Insert the stuff, leaving mark before it.!
    Q1-1"E .( W ):'		    !* Check for case of just C-U as arg.!
    :,.

!^R Un-kill Pop:! !^R Correct after ^R Un-kill to use an earlier kill.
Requires that the region contain the most recent killed stuff,
as it does immediately after using ^R Un-kill.
It is deleted and replaced with the previous killed stuff,
which is rotated to the front of the ring buffer in ..K.
With 0 as argument, just deletes the region with no replacement,
but the region must still match the last killed stuff.!

    q:..k(0)[0			    !* Get most recent killed string!
    fq0"l :i0'			    !* Zero =) ring empty, pretend was null string!
    fs^r prev-1003"N		    !* Special case if last command was e.g. Fill Region!
      .,:f  f=0"n	    !* If point to mark doesnt match that!
	  fg 0'		    !* complain (not after a ^R un-kill)!
	      !* It matches, so go ahead; rotate ring buffer!
      q..k[..o
      <			    !* Rotate forwards if and as desired.!
	  q:..k(0)( j5d zj 5,0i),z-5fsword >
      -<			    !* Rotate backwards if and as desired.!
	  z-5fsword( zj-5d j5,0i),0fsword >
      ]..o '
    .[1 w.[2 q1,q2f k	    !* Pop mark and kill old region.!
    "e 0 '			    !* Arg is 0 => just leave it flushed.!
    G(Q:..K(0)F"EW :I*')	    !* Insert cruft.!
    FK (
      Q1-Q2"L .:  FK+.J'	    !* Put point and mark around the new stuff.!
      "# FK+.:'		    !* If point used to be before, leave it before.!
      )

!^R Split Line:! !^R Move rest of this line vertically down.
Inserts a CRLF, and then enough tabs/spaces so that
what had been the rest of the current line is indented as much as
it had been.  Point does not move, except to skip over indentation
that originally followed it. 
With argument, makes extra blank lines in between.!

    @F_	R		    !* Put point after indentation here.!
    FS SHPOS( <I
>
    0,)M(M.M &_XIndent)	    !* Indent tail, on its new line, to old column.!
    .,( :1-L .)		    !* Changes reach from there back to end of old line.!

!^R Goto Beginning:! !^R Go to beginning of buffer (leaving mark behind).
With arg from 0 to 10, goes that many tenths of the file
down from the beginning.  Just C-U as arg means go to end.!

    .: FF"E J0'		    !* No arg => go to beginning.!
    FS ^R ARGP&6"E ZJ 0'	    !* Just ^U means go to end.!
    *Z/10J 0L .-BFS WINDOW	    !* Else go to fractional position (in tenths).!

!^R Goto End:! !^R Go to end of buffer (leaving mark behind).
With arg from 0 to 10, goes up that many tenths of the file from the end.!
    .: ZJ FF"E 0'
    Z-(*Z/10)J L .-BFS WINDOW

!^R Mark Beginning:! !^R Set mark at beginning of buffer.!
    B: 0

!^R Mark End:! !^R Set mark at end of buffer.!
    Z: 0

!^R Mark Whole Buffer:! !^R Set point at beginning and mark at end of buffer.
Pushes the old point on the mark first, so two pops restore it.
With arg, puts point at end and mark at beginning.!
    Z[0 B[1			    !* Normally point at B and mark at Z,!
    FF"N BU0 ZU1'		    !* But an argument reverses that.!
    Q1-."E :-Q0"E 0''	    !* Point and mark already at desired place => do nothing.!
    .: Q0: Q1J 0		    !* Otherwise, put them there.!

!^R Previous Page:! !^R Move to previous page delimiter.
See the description of ^R Mark Page.!

    "l -:m(m.m^R_Next_Page)'
    f[ s string
    QPage_Delimiter[0		    !* Get the string to search for (default is ^L)!
    .[1 0@l :s0w .-q1:"l 0l'   !* If point is just after a delimiter, go to beg of line!
    f[vz			    !* so we don't find the same line again and again.!
    <
      b,.fsbound		    !* set Z to ., to make sure that our funny way!
      < -:s0;		    !* of searching backwards can't accidentally move fwd.!
	0@L :s0"n fkc fk:;'
	.-b@;>>
    :s0 f]vz		    !* Stop AFTER the delimiter.!
    0

!^R Next Page:! !^R Move to next page delimiter.
See the description of ^R Mark Page.!

    "l -:m(m.m^R_Previous_Page)'
    f[ s string [1
    QPage_Delimiter[0		    !* Get the string to search for (default is ^L)!
    0@f  "n :@l'		    !* If in middle of line, move to end!
    q1<				    !* If going forward, search for n page beginnings.!
      < :s0:;		    !* A delimiter starts a page, but only!
        -2 (fkr)f~
	@;			    !* if it's at the beginning of a line,!
	.+fk-b@;>>		    !* or the beginning of the buffer.!
    0

!^R Mark Page:! !^R Put point at top of page, mark at end.
A numeric arg specifies the page: 0 for current, 1 for next,
-1 for previous, larger numbers to move many pages.
Page Delimiter contains the string used to
separate pages (or several alternatives, separated by ^O).!

    QPage_Delimiter[0		    !* Get the string to search for (default is ^L)!
    [1 ff"e 0u1'		    !* Q1 gets numeric arg, or, if 0 no arg.!
    0@f  "n :@l'		    !* If in middle of line, move to end!
    q1"g q1<			    !* If going forward, search for n page beginnings.!
      < :s0:;		    !* A delimiter starts a page, but only!
        -2 (fkr)f~
	@;			    !* if it's at the beginning of a line,!
	.+fk-b@;>>'		    !* or the beginning of the buffer.!
    "#
      1-q1<			    !* Going backwards, it's similar.!
	< -:s0;		    !* Because page delims can overlap,!
	  0@l :s0"l	    !* Go to start of line; is there one there?!
	    fkc fk:;'
	  b-.;>>
      :s0'			    !* Either way, stop AFTER the delimiter.!
    .( < :s0:;		    !* Now put mark at end of page,!
         -2 (fkr)f~
	 @; .+fk-b@;>
       .:			    !* AFTER the delimiter.!
       )j			    !* Now region is around this page.!
    0

!^R Set Bounds Region~:! !^R Narrow Bounds to Region:! !^R Narrow buffer bounds to point and mark.!

    B[0 :,.F  FS BOUND
    1FS MODE CH
    FSWINDOWF"L W' +Q0-B FSWINDOW  !* KEEP WINDOW+B CONSTANT WHILE B CHANGES!
!*** If new B is on screen, cause full redisplay.!
    FSWINDOW"L 0FS WINDOWW '
!*** IF NEW B IS OFF SCREEN, NO REDISPLAY NEEDED THERE.!
!*** SO REPORT NEED FOR REDISPLAY BELOW NEW Z.!
    Z,FSZ 

!^R Set Bounds Page~:! !^R Narrow Bounds to Page:! !^R Narrow buffer bounds to display one page.
Numeric arg specifies which page:  0 means this one,
1 means the next one, -1 means the previous one.
No arg means next page, or current page if bounds are wide open.
Args larger than one move several pages.
Page Delimiter contains the string used to
separate pages (or several alternatives, separated by ^O).!

    b[0 fs vz[1 .[2
    0f[vb 0f[vz		    !* flush bounds so can find page after this one.!
				    !* If lose, old bounds come back.!
    ff"n ' "# q0+q1"e 0' "# 1'' m(m.m ^R_Mark_Page)
    ]0 ]0			    !* Flush bindings explicitly, or the would undo our work!
    m(m.m ^R_Narrow_Bounds_to_Region)
    fsvz"n zj:0l fsz-.fsvz'	    !* Don't leave page terminator inside bounds.!
    j q2:jw			    !* Don't change point if old point is inside new bounds.!
    q0"e z,z' 		    !* If old B was 0, cause redisplay just at end!
				    !* if new B is above top of screen.!

!^R Set Bounds Full:! !^R Widen Bounds:! !^R Widen virtual bounds to display whole buffer.!
    FSWINDOW+1"G FSWINDOW+B FSWINDOW' !* KEEP WINDOW+B CONSTANT IF WINDOW IS DEFINED!
    Z[1
    1FS MODE CH
    0,FSZ FS BOUNDW 
    .[0  FN Q0J
    FSWINDOW+1"G
       FSWINDOWJ
       .( 0L .FSWINDOWW	    !* Make sure window starts at real start of line!
         )-."N .,Z''		    !* If need to change it, say redisplay needed at top!
!*** NOW, SCREEN HAS CHANGED BEFORE OLD B (MUST BE OFF SCREEN)
 AND AFTER OLD Z (REPORT THAT)!
    Q1,Z

!^R Return to Superior:! !^R Go back to EMACS's superior job.
With argument, saves visited file first.
Otherwise, does auto save if auto save mode is on.
Runs Exit Hook (if any) going out,
and Return from Superior Hook coming back.!

    FM(M.M &_Exit_EMACS)	    !* Clear mode line, auto save, etc.!
    0FO..Q Exit_to_Superior_Hook[1
    Q1"N M1'
    100000.FS EXIT
    0FO..Q Return_from_Superior_Hook[1
    Q1"N M1' 

!^R Exchange Point and Mark:! !^R Exchange positions of point and mark.!
    .( W ): 0

!^R Prefix Control:! !^R Sets Control-bit of following character.
This command followed by an = is equivalent to a Control-=.
A precomma argument means return the modified character;
otherwise, we execute its definition.!

    !BIT-PREFIX-1!		    !* BIT-PREFIX identifies us to M.I.!
    [0 :I* C-M.I @:FI&400.+(FI)U0  !* Read in the character to be modified.!
    :I* C- 0 FS ECHO CHAR
    Q0+200.U0  "N Q0'	    !* If we have arg, return the metized character.!
    Q0FS^RLASTW Q0U..0 ]0 F@:M..0    !* Else run that character's definition.!

!^R Prefix Meta:! !^R Sets Meta-bit of following character. 
Turns a following A into a Meta-A.
If the Metizer character is Altmode, it turns ^A
into Control-Meta-A.  Otherwise, it turns ^A into plain Meta-A.
A precomma argument means return the modified character;
otherwise, we execute its definition.
The value of the arg should be the metizer character itself
so we can tell whether it was an altmode.!

    !BIT-PREFIX-2!		    !* BIT-PREFIX identifies us to M.I.!
    [0 :I* M-M.I FIU0		    !* Read in the character to be modified.!
    :I* M- 0 FS ECHO CHAR
    Q0-32"L Q0-27"N Q0+300.U0	    !* MAKE ^A ACT LIKE CONTROL-A!
      F"E W FS ^R LAST'-27"N Q0-200.U0''' !* but if the metizer isn't altmode, ^A acts like A.!
				    !* Note if we have arg, that should be the metizer char.!
    Q0+400.U0  "N Q0'	    !* If we have arg, return the metized character.!
    Q0FS^RLASTW Q0U..0 ]0 F@:M..0    !* Else run that character's definition.!

!^R Prefix Control-Meta:! !^R Sets Control- and Meta-bits of following character.
Turns a following A (or C-A) into a Control-Meta-A.
A precomma argument means return the modified character;
otherwise, we execute its definition.!

    !BIT-PREFIX-3!		    !* BIT-PREFIX identifies us to M.I.!
    [0 :I* C-M-M.I FIU0	    !* Read in the character to be modified.!
    Q0-32"L Q0-27"N Q0+100.U0''	    !* Make ^A act like A.!
    :I*C-M-0 FS ECHO CHAR
    Q0+600.U0  "N Q0'	    !* If we have arg, return the metized character.!
    Q0FS^RLASTW Q0U..0 ]0 F@:M..0    !* Else run that character's definition.!

!^R Universal Argument:! !^R Sets argument or multiplies it by four.
Followed by digits, uses them to specify the
argument for the command after the digits.
If not followed by digits, multiplies the argument by four.!

    [0 :i0 [1 0fs ^r last	    !* Set flag to say this is arg-setting command.!
    0[1				    !* Q1 nonzero if minus sign part of our arg.!
    < 4,m.i		   !* loop, reading as many argument characters as follow.!
      :fi--"e fq0-1;	   !* Allow a minus sign as first character only.!
          1u1 fs ^R argp # 4 fs ^R argp
	  fi
	  !<!>'
      :fi f 0123456789-:;
      fiu1 :i001 >	    !* Accumulate them as string in Q0.!
!* Get here on 1st non-arg char.!
    fs ^r argp 1 fs ^rargp	    !* Always set the 1 bit in this flag.!
    fq0  q1"e
	fs ^r expt +1 fs ^r expt ' !* If no digits or -, multiply by 4.!
    m0 fs ^r arg		    !* If got some digits, set arg value from them.!
    fq0 "N fs ^R argp  3 fs ^r argp'
    0

!^R Autoargument:! !^R Digit or "-" starts numeric argument.
Place this function on the digits or Minus (with or without meta bits)
to make them start arguments.  If the digit or Minus has control or meta,
it always starts an argument.  Otherwise, it starts an argument
only if the terminator has control or meta or is Altmode;
other terminators insert the digits instead.!

    [0 [1 [2			    !* Q0 accumulates string, Q1 holds one character.!
    Q..0U2			    !* Q2 holds original arg-starting character.!
    Q2&127:i0

    < 4,m.i		   !* loop, reading as many argument characters as follow.!
      :fi f 0123456789:;
      fiu1 :i001 >	    !* Accumulate them as string in Q0.!
    @:fiu1			    !* What we do with them depends on what ended them.!
    q2q1&600."e		    !* If the original digit had no ctl or meta,!
      q1-33."n			    !* and terminator didn't either, just insert.!
        Afs^r initu2		    !* Do this using current self-insertion method.!
	-1u1
	fq0< %1:g0u..0 @m2 >
	0''
    0fs ^r last	  !* Else supply them as argument to the terminator.!
    f~0 -"e			    !* If arg is just a minus,!
      5u0'			    !* Say "just a minus" for sake of C-M-V.!
    "#
      0 fs ^r arg		    !* Else put arg value away.!
      3u0'
    fs^r argpq0 fs ^r argp
    0

!^R Quoted Insert:! !^R Reads a character and inserts it.!
    0F[ ^R REPLACE 1F[NOQUIT	    !* Turn off replace mode.  Allow ^G to be quoted.!
    FSOSTECO"N -1F[HELPCHAR'	    !* On Twenex, make help char not be special.!
    0F[^R PAREN
    M.I FIU..0  M(A FS ^R INIT)

!^R Next Several Screens:! !^R move down one or several screenfuls.!
    "L  -:M(M.M^R_Previous_Several_Screens)'
    <@M(M.M ^R_Next_Screen)> 0

!^R Previous Several Screens:! !^R move up one or several screenfuls.!
    "L  -:M(M.M^R_Next_Several_Screens)'
    <@M(M.M ^R_Previous_Screen)> 0

!^R Next Screen:! !^R Move down to display next screenful of text.
With argument, moves window down <arg> lines (negative moves up).
Just minus as an argument moves up a full screen.!

    FS RGETTY"E 0'		    !* Meaningless on printing ttys - how big is the screen?!
    FS ^R ARGP-5"E		    !* Handle just Meta-minus as argument.!
      :@M(M.M ^R_Previous_Screen)'
    "L  -:M(M.M^R_Previous_Screen)'
    !* Since the effect of this function can't be predicted from the buffer alone,!
    !* we must tell the journal file what we did.!
    FS JRN OUT"N FN :M(M.M&_Journal_Point)'
    [0 [1 [2 .U2
    :F			    !* MAKE SURE THE WINDOW IS VALID.!
    FF"N			    !* With arg, move text up <arg> lines.!
      FS WINDOW+BJ FS TOP LINFS ^R VPOS
      ,0:FM			    !* Find the <arg>'th line!
      0@:F			    !* and make that move to the top line.!
      FS WINDOW+B,Q2F J 0'	    !* restore point, except stay on the screen.!
    .-Z"E FG 0'                   !* ERROR IF AT END OF BUFFER!
    FS LINES F"E W FS HEIGHT-(fsTopLine)-(FS ECHO LINES+1)' U0  !* Q0 GETS WINDOW SIZE.!
    FS WINDOW U1  Q1+BJ	    !* GO TO TOP OF WINDOW.!
    2 FO..Q Next_Screen_Context_Lines [4   !* GET SIZE OF WINDOW OVERLAP.!
    :< Q0-Q4,0:FM>		    !* MOVE DOWN TO GOOD PLACE FOR NEW WINDOW.!
    .-B[3
    .( Z-300-."L 1:< Q4,0:FM>
	   .-Z"E FG Q2J 0''	    !* NO MORE SCREENFULLS =) ABORT AND UNDO.!
    )J Q3FSWINDOW
    1:< FS % TOP*Q0/100F"G,0:FM'>  !* MOVE DOWN ENOUGH TO MAKE THAT WINDOW VALID.!
    Q2-."G Q2J'                     !* DON'T CHOOSE A NEW . BEFORE OLD .; USE OLD .!
    FSWINDOW-Q1"E 0' 

!^R Previous Screen:! !^R Move up to display previous screenful of text.
With arg, move window back <arg> lines.!

    FS RGETTY"E 0'		    !* Meaningless on printing ttys - how big is the screen?!
    -1"L -:M(M.M^R_Next_Screen)'
    !* Since the effect of this function can't be predicted from the buffer alone,!
    !* we must tell the journal file what we did.!
    FS JRN OUT"N FN :M(M.M&_Journal_Point)'
    :F			    !* Make sure we have a valid window.!
    FS LINES F"E W FS HEIGHT-(fsTopLine)-(FS ECHO LINES+1)' [0	    !* Q0 gets window height.!
    FF"N			    !* With arg, move text down <arg> lines.!
      1:< Q0+(FS TOP LIN)-(	    !* If this will shove point off bottom,!
            FS ^R VPOS)--1F"L,0@:FM 0L' >
				    !* move point to what will be the last line.!
      .( FS WINDOW+BJ FS TOP LIN FS ^R VPOS
         @:F		    !* Ask current top line to go to <arg>'th line.!
         )J			    !* restore point.!
      0'
    FS WINDOW[1		    !* Make sure there is a valid window.!
    Q1"E FG 0'
    Q1+BJ			    !* Go there.!
    2 FO..Q Next_Screen_Context_Lines [4   !* Get size of window overlap.!
    1:< -1,0@FM>		    !* Move up a line!
    -1-Q4 :F			    !* Choose a window putting that point 3 lines from bottom.!
    FS WINDOW+BJ		    !* Normally, put point on top line.!
    FS % TOP"E 0'		    !* If that is above top margin,!
    1:< FS % TOP*Q0/100,0:FM>	    !* Move down past the margin.!
    0

!^R Get Q-reg:! !^R Get contents of Q-reg (reads name from tty).
Usually leaves the pointer before, and the mark after, the text.
With argument, puts point after and mark before.
A precomma argument becomes the first character of the q-reg name.!

    "N  '			    !* If have arg before comma, it is 1st char of qreg
!   M(M.M &_READ_Q-REG_NAME) U..1
    Q..1 FP-1"E M.I FI[1 :I..1:..1(1) '	    !* HANDLE Q-VECTORS !
    .,.m(m.m&_Save_for_Undo)Get_Q-reg
    .( G..1 .: )J
    FF&1"G M( M.M ^R_EXCHANGE_POINT) '   !* If ^U prefix, jump to the end. !
    :,.F 

!^R Put Q-reg:! !^R Put point to mark into q-reg (reads name from tty).
With an argument, the text is also deleted.
A precomma argument becomes the first character of the q-reg name.!

    "N  '			    !* If have arg before comma, it is 1st char of qreg
!   M(M.M &_READ_Q-REG_NAME) U..1 
    Q..1 FP-1"E M.I FI[1 :I..1:..1(1) '	    !* HANDLE Q-VECTORS !
    :,.F X..1
    FF&1"G :,.F  K .,.'    !* ^U prefix causes it to be deleted. !
    0

!^R Append to Buffer:! !^R Append region to specified buffer.
The buffer's name is read from the tty;  it is created if nonexistent.
A numeric argument causes us to "prepend" instead.
We always insert the text at that buffer's pointer, but when
"prepending" we leave the pointer before the inserted text.!

    1,M(M.M &_Read_Line)Buffer:_[1
    FQ1-1"L 0'		    !* Do nothing if rubbed out of.!
    1,Q1M(M.M &_Find_Buffer)[2	    !* Else get index of specified buffer.!
    q2"l @ft (New_Buffer)

      0fsecho act
      q1m(M.M &_Create_Buffer)u2'  !* Create it if it doesn't exist.!
    :,.F (			    !* Get the range that is our region (for args for G later)!
    Q:.B(Q2+4!*bufbuf!)[..O	    !* Select the specified buffer, and!
    )G(-FS QP SLOT)		    !* insert the text from old current buffer.!
    FF"N FKC'		    !* if prepending, leave . before the text.!
    0

!^R Count Lines Region:! !^R Type number of lines from point to mark.!
    :,.f  m(m.m &_Count_lines)@= 0fsecho act

!^R Count Lines Page:! !^R Count lines on this page (or whole buffer).
Print total lines on page, then (before+after) indicating how
the page is split by point.
With argument, we do the same thing to the whole buffer.!

    .[0  fn q0j		    !* Preserve point.!
    ff"n b[1 z[2 @ft_Buffer:_'
    "# 0m(m.m ^R_Mark_Page)	    !* Put point at front and mark at end of page.!
       .[1 w .[2		    !* Put addr of front in Q1 and that of end in Q2.!
       0@l			    !* But back up end to before page separator.!
       q2-z"e			    !* If page-end is end of buffer,!
         QPage_Delimiter[3	    !* is there a real page-separator there?!
         :s3
	 .-q2"e 0@l'		    !* If so, back up over it.!
	 "# q2j''
       .u2
       @ft_Page_has_'
    m.m &_Count_Lines[3
    q0,q1f [4
    q1,q4m3[5 q4,q2m3[6		    !* Q5 has number before, Q6 has number after.!
    q5+q6[7			    !* Print total number of lines before and after.!
    q0j q0-q1"n 0@f  "n q7-1u7''  !* Hair is to count the current line only once.!
    q7@:=
    @ft_Lines_( q5@:= @ft+	    !* Then, in parens type <# lines before .>+<# after>!
    q6@:= @ft)_
    0fs echo act		    !* Prevent clearing of echo area.!

!^R New Window:! !^R Choose new window putting point at center, top or bottom.
With no argument, chooses a window to put point at the center
(FS %CENTER says where).  An argument gives the line to put
point on;  negative args count from the bottom.
C-U as argument redisplays the line containing point.!
    FF"E
	F+ '			    !* No arg => let TECO rechoose window, centering point.!
    FS RGETTY"E		    !* On printing terminals, <arg>^L has another meaning!
        M(FS ^R INIT) '    !* which we preserve.!
    FS ^R ARGP&6"E		    !* ^U as arg means redisplay line point is on.!
        -1,(FS ^R VPOS)FS TYO HASHW H'
    @:F			    !* Arg, on display, says where to put this line on screen.!
    0

!^R Move to Screen Edge:! !^R Jump to top or bottom of screen.
Like ^R New Window except that point is changed instead of the window.
With no argument, jumps to the center, according to FS %CENTER.
An argument specifies the number of lines from the top,
(negative args count from the bottom).!

    !* Since the effect of this function can't be predicted from the buffer alone,!
    !* we must tell the journal file what we did.!
    FS JRN OUT"N FN :M(M.M&_Journal_Point)'
    :F			    !* make sure a window is known.!
    FS LINESF"E FSHEIGHT-(FS TOPLIN)-1-(FS ECHOLINES)' [2    !* Q2 gets window height.!
    [3			    !* Positive arg is line number, from top.!
    "L Q2+ U3'		    !* Negative arg is line number, from bottom.!
    FF"E FS%CENTER*Q2/100 U3'  !* No arg means to center.!
    	    !* Normally, move that many lines from window.!
    FS ^R VPOS-(FS TOP LIN)-Q3F"G-Q3"L    !* May be faster to move up from point.!
	1:<Q3-(FS ^R VPOS),0@FM> 0''
    FS TOPLIN+Q3-(FS ^R VPOS)F"G U3'	    !* But may be faster to move down from point.!
    "#W FS WINDOW+BJ'
    1:<Q3,0:FM>	    !* Move to desired place.!
    0

!^R Reposition Window:! !^R Reposition screen window appropriately.
Tries to get all of current paragraph, defun, etc. on screen.
Never moves the pointer.!

!* only wins if FS %TOP and FS %BOTTOM are zero.!

  .[2  fn q2j			    !* Restore point when we exit.!
  fsLinesF"N [0 '		    !* Q0 gets screen size !
  "#w fsHeight-(fsEchoLines)-(fsTopLine)-1[0 '
  0L				    !* First find beginning of current frob!
  QMODE[6 F~6LISP"N		    !* If not in lisp mode, go by indentation!
    _,1AF_	"L	    !* If current line not indented !
       < B-.; -L 1AF_	;> !* back up to one that is!
       '
    "# < B-.; -L 1AF_	:;>''	    !* Or if it is, back up to one that is not!
  "# :L
     -S
     ( L			    !* In Lisp mode, go up to start of defun.!
     .[3 FLL @:L		    !* Move to end.!
     .-Q2:"L Q3J'		    !* If point is within this one, use its beginning.!
     "# Q2J''			    !* If point is between defuns, put point at top line.!
  QComment_Start[1
  Q1"N < B-.;			    !* Back up to last nonblank noncomment line.!
	 -L @F_	R
	 :@F  "N FQ1 F~1"N L 0;'' >'
  @F
_	R		    !* Move down over blank lines.!
  0@L .-Q2"G Q2J'		    !* Don't try moving point off top of screen.!
  .U1				    !* Q1 gets address of what should go at top of screen.!
  .F[VB Q2J			    !* Scan back to there from "real" point.!
  1:< -q0,0:@FM >"E FG 0'	    !* Would that still be on the screen?!
  F]VB				    !* Yes => .=Q1 and FS ^R VPOS is now right for it.!
  0:@F 			    !* So move text to put that on top line.!

!^R Kill Terminated Word:! !^R Kill a word and the following character.
If the word is followed by a CRLF, the CRLF is not killed.!
    [9			    !* Tell Kill Text which direction we are killing.!
    .,( .WFWL "G :@F  "N C'' !* Move over range to be killed.!
        .)F  :M(M.M &_Kill_Text)  !* Kill it.!

!^R Go to Previous Label:! !^R Put point after last label.!

    .[.0 qComment_Start[.1
    "l -:m(m.m^R_Go_to_Next_Label)'
    < < b-.; 0l 32,1af*_	
"g :0l !<!>'
	  fq.1 f~.1"n
	    @:f_	
  l
	    .-q.0:;'
	  :0l > >
    0

!^R Go to Next Label:! !^R Put point after next label.!
    .[.0 qComment_Start[.1
    "l -:m(m.m^R_Go_to_Previous_Label)'
    < < .-z; 0l 1af*_	
"g l !<!>'
	  fq.1 f~.1"n
	    @:f_	
l
	    q.0-.:;'
	  l > >
    0

!^R Go to Address Field:! !^R Put point before the address field.
If there is none, put point where it should go.!
    0L .[0
    FWL 1AF:=_"L 0L'	    !* Skip over any label, or FOO=.!
    :FWL @:F_	L	    !* Find 1st whitespace, ignoring indentation!
    .[1 @F_	L	    !* Move over that whitespace.!
    1A-;"E Q1J'		    !* But if it is comment indentation, stay before it.!
    0AF_	"L 32I -1 '	    !* If just <insn> with no space, make a space.!
    .U1 @:F_,;/	[L	    !* Find first punctuation after start of this field.!
    1A-,"N Q1J' "# C'		    !* If it's comma, move after it.  Else go back.!
    0

!^R Go to AC Field:! !^R Put point before the accumulator field.
If there is none, put point where it should go.!
    0L .[0
    FWL 1AF:=_"L 0L'	    !* Skip over any label, or FOO=.!
    :FWL @:F_	L	    !* Find 1st whitespace, ignoring indentation!
    .[1 @F_	L	    !* Move over that whitespace.!
    1A-;"E Q1J'		    !* But if it is comment indentation, stay before it.!
    0AF_	"L 32I -1 '
    0

!^R Point into Q-reg:! !^R Move the value of point into a Q-register.
This is used with ^R Q-Reg into Point
for jumping back to a position remembered in a Q-register.!

    M( M.M &_READ_Q-REG_NAME) U..0  .U..0 .

!^R Q-reg into Point:! !^R Jump to a position specified by q-register.
The old position is pushed on the ring buffer of the mark.!

    M( M.M &_READ_Q-REG_NAME) U..0  .:  Q..0 J .

!^R Replace String:! !^R Replace string with another.  Reads args with minibuffer.
Calls the Replace String command. !
    FF"N :\' "# :I*' [0
    M( M.M &_MINI_INIT ) 0_MM Replace_String   Replace 

!^R Query Replace:! !^R Query Replace using the minibuffer.
Calls the Query Replace command. !
    FF"N :\' "#:I*' [1
    M( M.M &_MINI_INIT ) 1_MM_Query_Replace    Query_Replace 

!^R View Q-reg:! !^R View the contents of a specified Q-register.!
    M( M.M &_READ_Q-REG_NAME) U..0
    M( M.M VIEW_Q-REG) ..0  

!^R Display Date and Time:! !^R Display the Date and Time in the echo area.!

    F[B BIND
    FS WIDTH /8-5, 11.I
    M( M.M Insert_Date)
    @FT				    !* Print it in the echo area!
..O 0FS ECHO ACT

!^R Info:! !^R Invoke INFO.!
    M(M.M Run_Library)DSK:EMACS;INFO&_INFO_Enter

!^R Buffer Not Modified:! !^R Pretend that this buffer hasn't been altered.!
    0fsxmod
    0fsmodif

!^R Find Tag:! !^R Jump to the definition of a tag.
This version loads the TAGS package and then calls it.!

    1,m.m&_Setup_TAGS_Library"E
      m(m.m Load_Library)TAGS'
    f:m(m.m ^R_Find_Tag)

!^R Start Kbd Macro:! !^R Begin defining a keyboard macro.
g(m.aKBDMAC~DOC~ ^R Start Kbd Macro)jk!

    1,m.m&_Setup_KBDMAC_Library"E
      m(m.m Load_Library)KBDMAC'
    f:m(m.m ^R_Start_Kbd_Macro)

!& Transpose Subr:! !S Subroutine used by transpose functions.
arg1 is a string which is "fw" for the appropriate chunk-type.  It will
always get an arg.  arg2 is the ^R-arg, see the documentation of ^R Transpose Characters.!

 [5 [2[3[4			    !* Q5 gets the chunk-isolator macro (like fw)!
 "G 15R -25L .[0 15R	    !* Q0 is start of chunk to left of point!
      < .u3 15R -15fx4 z-.u2  !* Iterate, exchanging chunks which point is between!
	 q3j -15fx3 g4 z-q2j g3 > !* Being careful not to err with text deleted!
      q0,.  '			    !* Return modified range, leaving point after it!
 "L -15L 15R .[0		    !* Q0 is end of chunk to left of point!
      -< z-.u3 -25L 15fx4 .u2 !* Iterate, exchanging chunks to left of point!
	   z-q3j -15fx3 g4 q2j g3 >
      q2,q0  '		    !* Leave point between two chunks, return modified range!
 .,(w). f  u2 j		    !* .,Q2 get dot and mark, sorted!
 15R -15L .u0		    !* Q0 gets start of left-hand chunk!
 q2j 15R -15fx4 z-.u2	    !* Pick up right-hand chunk!
 q0j 15fx3 g4 z-q2j .u2 g3	    !* Now they are swapped and Q0,. is modified region!
 q0 q0,.(q2j) 		    !* Leave dot and mark at the two chunks!

!^R Transpose Characters:! !^R Transpose the characters before and after the cursor.
For more details, see ^R Transpose Word, reading "character" for "word".
However: at the end of a line, with no argument, the preceding
two characters are transposed.!

 ff"e
   @:f  "e			    !* If no arg, and at end of line,!
     0@f  "n r''		    !* and not at beginning, back up one.!
   0a(-dc)i -2 '		    !* Do the simple case fast.!
 :i* , :m(m.m&_Transpose_Subr)  !* 1  = .,.+1 !

!^R Transpose Words:! !^R Transpose the words before and after the cursor.
With a positive argument it transposes the words before and
after the cursor, moves right, and repeats the specified number of
times, dragging the word to the left of the cursor right.  With a
negative argument, it transposes the two words to the left of
the cursor, moves between them, and repeats the specified number of
times, exactly undoing the positive argument form.  With a zero
argument, it transposes the words at point and mark.!

 :i*.w fw, :m(m.m&_Transpose_Subr)

!^R Transpose Sexps:! !^R Transpose the S-expressions before and after the cursor.
For more details, see ^R Transpose Words, reading "Sexp" for "Word".!

 :i*@fl, :m(m.m&_Transpose_Subr)

!^R Transpose Lines:! !^R Transpose the lines before and after the cursor.
For more details, see ^R Transpose Words, reading "Line" for "Word".!

    :i*[1 .[2
       q1"l -q1< r0@l>'
       q1"g q1@l 0@f  "n 13i 10i''
       q2,.( q2j)f (
    ),:m(m.m&_Transpose_Subr)
    !* The command we pass is like FW with lines as "words".!

!^R Upcase Digit:! !^R Convert last digit to shifted character.
Looks on current line back from point, and previous line.
The first time you use this command, it asks you to type
the row of digits from 1 to 9 and then 0, holding down Shift,
to determine how your keyboard is set up.!

    .[0 fn q0j
    0fo..qDigit_Shift_Table[1
    q1"e 1,fType_the_digits_1,_2,_..._9,_0,_holding_down_Shift:_u1
         fq1-10"n :i*Not_ten_digitsfserr'
	 q1m.v Digit_Shift_Table'
    .,.-(-@f  ):fb1234567890"e fg 0'
    1a-1f"l+10':g1u1 f1
    1 

!Abort Recursive Edit:! !C Abnormal exit from recursive editing command.
The recursive edit is exited and the command that invoked it is aborted.
For a normal exit, you should use ^R Exit, NOT this command.
The command can put a string in Abort Resumption Message
to tell the user how to resume the command after aborting it.!

    -fsback str-(m.m&_Toplevel_^R)"E
      :i* Already_at_top_level fs err'
    QAbort_Resumption_Message[0
    q0"e @ft Abort_this_recursive_edit
        1m(m.m &_Yes_or_No)"e 0''
    q0"n @ft
0'
    1f[noquit
    -1fsquit
    fs^r exit			    !* Exit the ^R.  This will pop fs noquit,!
				    !* causing a quit afterward.!

!^R Transpose Regions:! !^R Transpose regions defined by cursor and last 3 marks.
To transpose two non-overlapping regions, set the mark successively at three
of the four boundaries, put point at the fourth, and call this function.
On return, the cursor and saved marks retain their original order, but are
adjusted to delineate the interchanged regions.  Thus two consecutive
calls to this function will leave the buffer unchanged.!

    [8 [9 .[0 :[1 [2 [3	    !* Get point and last three marks!
    q0,q1f [5[4 q4,q2f [6u4	    !* Sort q0-q3 into ascending!
    q4,q3f [7u4 q5,q6f u6u5	    !*  numerical order into q4-q7!
    q5,q7f u7u5 q6,q7f u7u6
    q6,q7x8  q4,q5x9		    !* Save the two regions into q8 and q9!
    1F[NOQUIT
    q6,q7k  q4,q5k		    !* Once we can't lose, delete them!
    q4j g8 ((q7+q4)-q5)jg9	    !* Put them down in the appropriate places!

    q7+q4-q6u8
    q0-q5"e q8u0'		    !* Adjust whichever input argument pointed!
    q1-q5"e q8u1'		    !*  to the end of the first region!
    q2-q5"e q8u2'
    q3-q5"e q8u3'
    q7+q4-q5u8			    !* Similarly adjust whichever input!
    q0-q6"e q8u0'		    !*  argument pointed to the beginning of second region!
    q1-q6"e q8u1'
    q2-q6"e q8u2'
    q3-q6"e q8u3'
				    !* Finally, on exit, reset the potentially!
				    !*  modified three saved marks, and exit!
				    !*  to the potentially modified point,!
    q3: q2: q1: q0j	    !* redisplaying from the beginning of the!
    q4,q7			    !* first region to the end of the second!

!^R Correct Word Spelling:! !^R Check and correct spelling of previous word.
g(m.aAUX~DOC~ & Correct Word Spelling)jk!

    f:m(m.a AUX&_Correct_Word_Spelling)
  