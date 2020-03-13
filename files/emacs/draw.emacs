!* -*-TECO-*- *!

!~Filename~:! !DRAW file!
DRAW

!MARK:! !& Marks the beginning of a line.!
!* Replaces the characters following pointer with the argument,        !   
!*       leaving the pointer where it started.                         !   
!* Leaves the following in Q-registers 6-9:                            !   
!*      Q9 = argument                                                  !   
!*      Q8 = buffer contents replaced by argument                      !   
!*      Q7 = horiz. position of beginning of mark                      !   
!*      Q6 = loc. of beginning of marked line                          !   

  :I9                     !* Put argument in Q9.                  !
  .U8 0L .U6 Q8-.U7 Q8J        !* Set up Q6 and Q7, Q8 = ptr.          !
  :L .-Q8-FQ9"L                !* Add blanks if necessary to make sure !
         FQ9+Q8-.<I_>'        !*   there are |Q9| chars. on line to   !
    Q8J                        !*   right of ptr.                      !
  .,.+FQ9FX8 G9                !* Save buf. chars and insert mark.     !
  -FQ9C                        !* Restore pointer.                     !


!& Line Setup:! !& Setup for drawing line, etc.!
!* Leaves ptr at beginning of mark, and following Q-reg values:         !
!*    Q4 = offset = delta x position/|delta y position|                 !
!*    Q3 = | line no. of ptr - line no. of mark |                       !
!*    Q2 =  0 if line no. of pointer lt line no. of mark (line goes up) !
!*          1 otherwise  (line goes down)                               !

  .U1  0L .U5 Q1-.U1       !* Set up Q1 and Q5. Ptr at beg. of line.    !
  1U2 .-Q6"L 0U2'          !* Set up Q2.                                !
  0U3    <                 !* Loop to set up Q3.                        !
    .-Q6"E 1; '            !* Invariant: Final val of Q3 = current val  !
    Q2"E 1L'"# -1L'        !*    + |line no of ptr - line no of mark|.  !
    Q3+1U3 >               !*     ptr at beginning of line.             !
  1U4 Q3"N (Q1-Q7)/Q3U4 '  !* Setup Q4.                                 !
  Q7C                      !* Move ptr to beginning of mark.            !

!DRAW:! !& Draw line from mark to pointer.!
   [1 [2 [3 [4 [5
   M(M.M&_LINE_SETUP)     !* Call line setup subroutine.                 !
   M(M.M&_XDRAW)          !* Draw line.                                  !
   ]5 ]4 ]3 ]2 ]1


!& XDRAW:! !& Draws line using parameters of MARK and & LINE SETUP.!
           !* Leaves Q7 = horiz pos of first char in last strip of line.  !
           !*        Q5 = loc of beginning of that last line.             !
           !*        Q3 = 0                                               !
           !*        ptr at beg of first char in last strip of line.      !
  100<                     !* Invariant: Ptr at beginning of last horiz   !
                           !*    strip of chars. drawn.                   !
                           !*     Q7 = horiz. pos of ptr.                 !
                           !*     Q3 = number of strips left to draw.     !

     
    Q3"E 1; ' Q3-1U3       !*   Exit if Q3 zero, else decrement.          !
    Q2"E -1L'"# 1L'        !*   Go to next line.                          !
    Q7+Q4U7 .U5            !*   Update Q7.                                !
    :L .-Q5-Q7-FQ9U1       !*   Move Q7 + |Q9| chars right, adding blanks !
       Q1"L -Q1<I_>'"#    !*      to pad line if necessary.              !
            -Q1C '           
    .-FQ9,.K G9 -FQ9C      !*   Replace chars to left with Q9, move ptr   !
   >                       !*       to beginning of replaced chars.       !



!STRETCH:! !& Stretch along line from mark to pointer.!
   [1 [2 [3 [4 [5
   M(M.M&_LINE_SETUP)     !* Call line setup subroutine.                 !
   FQ9D G8 -FQ9C           !* Replace mark by original contents.          !
   M(M.M&_XSTRETCH)       !* Do stretching.                              !
   ]5 ]4 ]3 ]2 ]1


!& XSTRETCH:! !& Do stretching, using MARK and & LINE SETUP parameters. !
              !* Assumes buffer contents restored.                    !
  100<                     !* Invariant: Ptr at next horiz                !
                           !*    strip to be stretched                    !
                           !*     Q7 = horiz. pos of ptr.                 !
                           !*     Q3 = number of strips left to draw - 1  !
    Q3"L 1; ' Q3-1U3       !*   Exit if Q3 neg,  else decrement.          !
    0AU1 Q1-10"E 32U1'     !*   Insert |Q9| copies of char to left of ptr,!
      FQ9<Q1I>             !*      except insert sp if at beg of line.    !
    Q2"E -1L'"# 1L'        !*   Go to next line.                          !
    Q7+Q4U7 .U5            !*   Update Q7.                                !
    :L .-Q5-Q7U1           !*   Move Q7 chars right, adding blanks        !
       Q1"L -Q1<I_>'"#    !*      to pad line if necessary.              !
            -Q1C '           
   >                       
 
!SHRINK:! !& Shrink along line from mark to pointer.!
   [1 [2 [3 [4 [5
   M(M.M&_LINE_SETUP)     !* Call line setup subroutine.                 !
   M(M.M&_XSHRINK)        !* Do shrinking.                               !
   ]5 ]4 ]3 ]2 ]1


!ERASE:! !& Erase line from mark to pointer - only works going down.      !
   [1 [2 [3 [4 [5
   M(M.M&_LINE_SETUP)     !* Call line setup subroutine.                 !
   Q2"N                    !* If line going down, then:                   !
     .U1 [1 [3 [7
     M(M.M&_XSHRINK)      !* First shrink.                               !
     ]7 ]3 ]1 Q1J
     M(M.M&_XSTRETCH) '   !* Then stretch back.                          !
   ]5 ]4 ]3 ]2 ]1


!& XSHRINK:! !& Shrink along line using MARK and & LINE SETUP parameters. !
  100<                     !* Invariant: Ptr at next horiz                !
                           !*    strip to be deleted                      !
                           !*     Q7 = horiz. pos of ptr.                 !
                           !*     Q3 = number of strips left to kill - 1  !
    Q3"L 1; ' Q3-1U3       !*   Exit if Q3 neg,  else decrement.          !
    FQ9D                   !*   Delete |Q9| chars to right of ptr.        !
    Q2"E -1L'"# 1L'        !*   Go to next line.                          !
    Q7+Q4U7 .U5            !*   Update Q7.                                !
    :L .-Q5-Q7-FQ9U1       !*   Move Q7+|Q9| chars right, adding blanks   !
       Q1"L -Q1<I_>'"#    !*      to pad line if necessary.              !
            -Q1C '           
    -FQ9C                  !*   Move |Q9| chars left.                     !
   >


!FCOPY:! !& Puts figure specified by MARK and ptr. in indicated Q-Reg.  !

   [0 [1 [2 [3 [4 [5
   .U0                     !*   Save ptr in Q0.                         !
   M(M.M&_Line_Setup)     !*   Call & Line Setup to set up Q2-Q4.      !
   FQ9D G8 -FQ9C           !*   Replace Mark by original contents.      !
   Q0J 0L Q0-.-Q7U4        !*   Q4 := H-pos of ptr - H-pos of mark      !
   Q4"L 0U1 '"#            !*   Q1 := 0 if Q4 neg. (backwards)          !
        1U1 '              !*         1 if Q4 non-neg. (forwards)       !
   Q6J  .,.X0              !*   Ptr := beginning of marked line.        !
   <                       !*   Invariant:                              !
                           !*     Q3 = no. of lines left to gobble - 1. !
                           !*     Q0 = prev. lines of pict., with crs.  !
                           !*     ptr = beginning of next line to get.  !
  .U5 :L .-Q5-Q7-1U5       !*   Move  x  chars right, adding blanks     !
       Q1"N Q5-Q4U5'       !*      to pad line if necessary, where      !
       Q5"L -Q5<I_>'"#    !*      x = Q7+Q4 +1 if Q1 = 1               !
            -Q5C '         !*        = Q7+1     if Q1 = 0               !
  Q1"N .-Q4-1,.@X0 '"#     !*   Append line to Q0 - backwards if Q0 = 0 !
    1-Q4<-1C .,.+1@X0>'    !*       else forwards.                      !
  Q3"E 1;' Q3-1U3          !*   If Q3 = 0 then exit, else decrement Q3. !
  I I
 .-2,.@X0 -2D   !*   Append CR LF to Q0                      !
  Q2"E -1L'"# 1L'          !*   Go to beginning of next line.           !
  >                        !*                                           !
  :I0               !*   Move Q0 to Q-reg spec. by argument      !
  ]5 ]4 ]3 ]2 ]1 ]0        !*                                           !



!FIGURE:! !& Draws figure from indicated Q-reg.!
!* Alpha argument = Q-reg. name (not 0-9)      !
!*   mark = 1 corner, ptr = opposite ptr.      !
!*   if right - left then reverse columns.     !
!*   if botttom - top then reverse rows.       !

  [1 [2 [3 [4 [5 [6 [7 

  .U3 0L Q3-.U3 .U6 HFX5          !* Save buffer in Q5, beg of line in !
                                  !*   Q6, Horiz pos of buffer in Q3.  !
  G BJ                        !* Move figure from Q-Reg to Buffer. !
  < Z"E 1; '                      !* Repeat while buffer not empty:    !
    :L 0,.X4 0L 1K HFX7             !* First line of buffer to Q4 & del.!
                                    !*   Save rest of picture in Q7.    !
    G5 Q6J                          !* Restore buffer & ptr.            !
    Q3+FQ4U1                        !* Horiz pos + length of string to Q1.!
    .U2 :L                          !* Move Q1 chars. to right:         !
   .-Q2-Q1"L Q1+Q2-.<I_>'"#        !*   If puts past end of line,      !
            Q1+Q2J '                !*   Then add blanks, else go there.!
   -FQ4D G4                         !* Replace chars to left with Q4.   !  
   1L                               !* Go to next line.                 !
   .U6 HFX5 G7 BJ                   !* Save buffer and bring in rest of !
  >                                 !*   picture.                       !
  HK G5 Q6J -1L Q1C                 !* Restore buffer.                  !

    

!TRANSPOSE:! !& Puts transpose of fig in Q-reg arg1 into Q-reg arq2.    !

   [0 [1 [2 [3 [4 [5 [6 [7 [8 [9
   .U8 HFX9  [8                     !* Save buffer, ptr in Q8, Q9.      !
   G BJ                         !* Put figure in buffer.            !
   0U0                              !*                                  !
   <                                !* Invariant:                       !
     Z"E 1;'                        !*   prev. lines of figure on stack !
     :L 0,.X1 [1                    !*       (without crs)              !
     1L 0,.K Q0+1U0                 !*   rest of figure in buffer       !
    >                               !*   Q0 = no of lines on stack      !
    HX8                             !*                                  !
    <                               !* Invariant:                       !
      Q0"E 1;' Q0-1U0               !*    buffer empty                  !
                                    !*    Q0 = no of lines left on stack!
                                    !*    Q8 = rest of picture          !
                                    !*                                  !
      ]1 G1 BJ                      !*  Get next line and put in buffer.!
      < 1C .-Z"E 1;' I I
 >    !*  Rotate it.                      !
      BJ 1C                         !*  Move to top right +1 char.      !
                                    !*                                  !
                                    !* THE FOLLOWING DRAWS FIGURE FROM  !
                                    !*   Q8:                            !
    .U3 0L Q3-.U3 .U6 HFX5          !* Save buffer in Q5, beg of line in !
                                    !*   Q6, Horiz pos of buffer in Q3.  !
    G8 BJ                           !* Move figure from Q-Reg to Buffer. !
    < Z"E 1; '                      !* Repeat while buffer not empty:    !
    :L 0,.X4 0L 1K HFX7             !* First line of buffer to Q4 & del.!
                                    !*   Save rest of picture in Q7.    !
    G5 Q6J                          !* Restore buffer & ptr.            !
    Q3+FQ4U1                        !* Horiz pos + length of string to Q1.!
    .U2 :L                          !* Move Q1 chars. to right:         !
   .-Q2-Q1"L Q1+Q2-.<I_>'"#        !*   If puts past end of line,      !
            Q1+Q2J '                !*   Then add blanks, else go there.!
   -FQ4D G4                         !* Replace chars to left with Q4.   !  
   1L                               !* Go to next line.                 !
   .U6 HFX5 G7 BJ                   !* Save buffer and bring in rest of !
  >                                 !*   picture.                       !
  HK G5                             !* Restore buffer.                  !

  HFX8                              !* Put buffer in Q8 and kill.       !
 >                                  !*                                  !
 :I8                         !* Move picture from Q8 to final Q. !
 HK G9 ]8 Q8J                       !* Restore original buffer.         !
                                  !*                                  !


!& PSEUDOMARK:! !& Simulates a MARK and & LINE SETUP call for V commands. !
                !* Does not set up Q8 or Q9. !

  .U5 0L Q5-.U7 .U6               !*  Setup Q7 and Q6.              !
  0U4                             !*   Q4 = 0                       !
  FS^R ARGP&1"E 0U3'"#           !* If arg: then dec and put in Q3 !
               FS^R ARG-1U3'     !*         else put 0 in Q3       !
  FS^R ARGP&4"E 1U2'"# 0U2'      !* Set up Q2.                     !
  Q5J                             !* Restore pointer.               !

!VDRAW:! !& Draws a vertical line specified by arguments.  !

  [1 [2 [3 [4 [5 [6 [7 [8 [9
  :I9                        !*  Q9 = alpha argument.          !
  M(M.M&_PSEUDOMARK)  
  .U5 :L .-Q5-FQ9U1        !*   Move |Q9| chars right, adding blanks      !
       Q1"L -Q1<I_>'"#    !*      to pad line if necessary.              !
            -Q1C '           
  -FQ9D G9 -FQ9C           !*   Draw first strip of line.                 !
  M(M.M&_XDRAW)           !*   Draw rest of line.                        !
   


!DDRAW:! !& Draws a diagonal line.!

  [1 [2 [3 [4 [5 [6 [7 [8 [9
  :I9                        !*  Q9 = alpha argument.          !
  M(M.M&_PSEUDOMARK)  
  FQ9U4                    !*   Set Q4 (offset) to length of Q9 (arg.)    !
  .U5 :L .-Q5-FQ9U1        !*   Move |Q9| chars right, adding blanks      !
       Q1"L -Q1<I_>'"#    !*      to pad line if necessary.              !
            -Q1C '           
  -FQ9D G9 -FQ9C           !*   Draw first strip of line.                 !
  M(M.M&_XDRAW)           !*   Draw rest of line.                        !
   


!VSTRETCH:! !& Stretch as indicated by args.  !

  [1 [2 [3 [4 [5 [6 [7 [8 [9
  :I9                        !*  Q9 = alpha argument.          !
  M(M.M&_PSEUDOMARK)  
  M(M.M&_XSTRETCH)
  


!VSHRINK:! !& Shrink as indicated by args. !

 [1 [2 [3 [4 [5 [6 [7 [8 [9
  :I9                        !*  Q9 = alpha argument.          !
  M(M.M&_PSEUDOMARK)  
  M(M.M&_XSHRINK)
  


!VERASE:! !& Erase as indicated by args -- only if erasing down. !

 [1 [2 [3 [4 [5 [6 [7 [8 [9
  :I9                        !*  Q9 = alpha argument.          !
  M(M.M&_PSEUDOMARK)  
  Q2"N                            !* If line goes down, then:       !
    .U1 [1 [7 [3
    M(M.M&_XSHRINK)              !*  First shrink.                 !
    ]3 ]7 ]1 Q1J
    M(M.M&_XSTRETCH) '           !*  Then stretch.                 !
  


!& Setup DRAW Library:! !& Initialization.!

ftDRAW_loaded



