!~FILENAME~:! !DELIM macros for moving over []{}<>(), etc.  To make other
characters delimiters, run MAKE DELIMITER PAIRS and assign ^R MOVE OVER
DELIMITERS to control, meta, or control-meta slots for the delimiter
characters.  For example:
    MM Make Delimiter Pairs<>
    M.M^R Move Over Delimiters U.<
    M.M^R Move Over Delimiters U.> will make C-< and C-> move back and
forward (respectively) over <> Use UNMAKE DELIMITER PAIRS to undo this.

Also sets up FS ^R Paren to do the right thing.  !
DELIM

!& Setup DELIM Library:! !S Assign macros so control []{}()<> moves over
these!
   Q.] U...G		   !* redefine the super quit!
   FS B CONS M.V Delimiter_..D_Buffer
   M.M &_Matching_Paren M.V MM_&_Normal_Matching_Paren
   M.M &_Display_Matching_Delimiter F( M.V MM_&_Matching_ParenW) FS^R Paren
   M(M.M Make_Delimiter_Pairs) ()[]{} !* Defaults!
   M(:I* < F( - 33.@;
	 M.M ^R_MOVE_OVER_DELIMITERS ,)+200. FS ^R C MACRO W> )
              ) ()[]{}<>
   

!^R Move Over Delimiters:! !^R Move over balanced pairs of delimiters.  With
a pre-comma argument, just set .,<mark>.!
   [..D
   M(M.M &_Delim_Munge_..D)		   !* setup ..D!
   FS ^R Last&177.(
   )*5:+1 :G..D - ( "E	    !* backward moving delimiter?!
         f"e 1' f"l (fll):' *(-1) fl ('
        "#  f"e 1' f"l (-fll):' fl ('
   "E )L . '"#  )[1[0 q1-."N q1'"# q0' :'
?   .

!& Delim Munge ..D:! !S Munge ..D appropriately for delimiter operation.!
   FS ^R Last&177. [0	[1 [2 [3 !* make into regular ASCII!
   Q0*5+2[4 Q4 :G..D *5+2[1
   [..O Q..O[O QDelimiter_..D_BufferU..O G..D J
   <:S () ;
     .-(./5*5)-2"E		    !* Only consider syntax slot!
        Q1-."N			    !* Dont munge the matching delimiter!
           Q4-."N		    !* dont munge the char itself!
              .-1:\U2 - X3 .-1 FA	    !* smash the slot!
              FN 2 :F..D3 '''	    !* and restore it later!
     >
   HFX..D QO U..O

!Make Delimiter Pairs:! !C Define entries in the Delimiter ..D Table
for balanced pairs of delimiters.  The string argument should be
an even number of characters, paired.  Note that the delimiter
characters must have ^R Move Over Delimiters  assigned to one
of their ^R macro slots (control, meta, or control-meta - but
not TOP).!
   [1[2
   *5 :F..D_/
   <  u1 q1-"e 0;'  u2 q2-"e 0;'  !* loop until altmode!
     q1*5 :f..D_(2
     q2*5 :f..D_)1
    >
    

!UnMake Delimiter Pairs:! !C Resets the syntax of delimiter characters.!
   <  F( - @; )F( *5 :f..DAA_
     )+ 200. F( @ fs ^R Init, ) @ fs ^R CMACRO	    !* reset!
     > )
    

!& Display Matching Delimiter :! !S After a delimiter has been inserted, display
the matching one.!

    M(M.M &_Delim_Munge_..D)
    F :M(M.M &_Normal_Matching_Paren)

!* Local Modes: !
!* Mode:Teco !
!* Comment Column:43 !
!* End: !
