!* -*-TECO-*- !

!~Filename~:! !Functions for editing BCPL code.!
BCPL

!& Setup BCPL Library:! !S Set up the BCPL ..D table.!

  m.vBCPL_..D			    !* Define ..D for BCPL Mode.!
  [..O FSBCREATE G..D
  [0 0U0<Q0*5+1JFA%0-200.;> ]0 !* Make all Alphabetic!
  (*5+1JF(
  [*5+1JF(
  <*5+1JF_ !* angle brackets are like space!
  {*5+1JF(
  )*5+1JF)
  ]*5+1JF)
  >*5+1JF_
  }*5+1JF)
  $*5+1JF/ !* dollar sign quotes!
  "*5+1JF|
  11.*5+1JF_ !* Tab!
  12.*5+1JF_ !* LF!
  14.*5+1JF_ !* FF!
  15.*5+1JF_ !* CR!
  40.*5+1JF_ !* Space!
  =*5+1JF_ !* = breaks!
  '*5+1JF| !* ' is a string delimiter!
  .*5+1JF_
  ,*5+1JF_
  41.*5+1JF'
  %*5+1JF'
  ;*5+1JF'
  :*5+1JF_
  HXBCPL_..D



!^R BCPL Syntax Checker:! !^R Check the syntax of a buffer of BCPL code.
Normally checks the entire buffer.  Given an argument, checks
from . to Z.  Checks that braces are balanced, checks named
braces; does not check things like arg list syntax.!

1:<
   :I*Cfs echo disp
   @FTSyntax_checking
   FF"E J'			!* Beginning of buffer if no arg!
   [0[1[2[3[4[5[6[7
  :I7[null]			!* default bracket name !
  1:< -1F[NOQUITW		!* make sure ctrl-G enabled!
     !TOP! .U3 0U2 [3 [2
     !AGAIN! :S{(["//'])}U1 .U0
     Q1"E ]2 ]3 Q2"E OWIN' OUNM' !*No more braces, so win if stack empty!
     0,-1A-$"E OAGAIN' !* $ quotes chars; if no quote, then decide if open!
     0,-1A-^"E 0,-2A-$"E OAGAIN' ' !* handle $^[ and such!
     Q1+5U1
     Q1"E L OAGAIN'    !* Flush comments--// is sixth thing searched for!
     Q1-1"G [0 [1 OAGAIN' !* Open bracket!
      Q1+1"L ]2 ]3 Q2"E OXTRA'
                Q1+Q2"N OMISM'
                0,0AU4
                Q4-]"N Q4-}"N OAGAIN' ' !* Special hacking for braces!
                .U4 Q3J q7U5 q7U6
                :S"E ORCHK' Q3-.+1"E ORCHK'  !* go to rchk if unnamed brace!
                Q3,.-1X5  !* name of this bracket!
         !RCHK! Q4J
                :S"E ZJ'
                     "# R'
                Q4-."E Q5-q7"E Q4J OAGAIN'
                            ONUNM'
                Q4,.X6     !name of close!
                F=56"N ONUNM' Q4J OAGAIN '
     .U3 Q1-1"E m(m.m&_find_dq)"E OUNM' OAGAIN '
         Q1+1"E m(m.m&_find_sq)"E OUNM' OAGAIN '
   !MISM! 7FSIMAGE 0,Q3-.A:I2 0,Q0-.A:I1 :I*Cfs echo disp
            @ft2_Mismatched_by_1 
	    q0j
	    m(m.m^r_set/pop_mark)
            Q3-1J  0;
   !UNM!  7FSIMAGE 0,Q3-.A:I2
          :I*Cfs echo disp
          @ft2_Unmatched_
          q0j
	  m(m.m^r_set/pop_mark)
	  Q3-1J 0;
   !NUNM! 7FSIMAGE
     Q5"E Q7U5' Q6"E Q7U6' 0,Q3-.A:I2
     :I*Cfsecho disp
     @ftNamed_braces_5_and_6_unmatched_
     q4j
     m(m.m^r_set/pop_mark)
     Q3-1J 0;
   !XTRA!  7FSIMAGE 0,0A:I2
     :I*Cfsecho disp
     @ft2_Extraneous 
     R .u0
     Q3-1j
     m(m.m^r_set/pop_mark)
     q0j 0;
   !WIN! :I*Cfsecho disp
       @ftSyntax_Correct_>U0
  Q0F"L-^FEQIT"E <FIF;>''
>
0fsecho act
1


!& find dq:! !S Search for double quote to end bcpl string!
  [0 :i0"
  M(m.m&_FIND_END)


!& find sq:! !S Search for single quote to end bcpl string!
  [0 :i0'
  M(m.m&_FIND_END)


!& find end:! !S Find end of bcpl string.!
[1 !loop! :s0"E 0' !* flush if no string terminator!
       .u1
       r
       -s*  !*will always succeed!
       q1-.&1"E q1j -1'  !win if even # of stars!
       q1j oloop


!BCPL Mode:! !C Setup things for editting BCPL code.
Like LISP mode, but uses BCPL syntax.  Also makes the following
command character assignments:
    C-M-D   ^R Down List
    C-M-K   ^R Kill Sexp
    C-M-S   ^R BCPL Syntax Checker!

    M(M.M LISP_Mode)
    M.M Make_Local_Q-register[.Q
    M.Q ...D
    M.Q ...K
    M.Q ...S
    M.M ^R_Down_ListU...D	    !* Please leave for CCA and friends!
    M.M ^R_Kill_SexpU...K	    !* Ditto!
    M.M ^R_BCPL_Syntax_CheckerU...S

    M.Q ..D
    qBCPL_..DU..D		    !* Set up ..D properly!

    :IComment_Start//
    (@:I*\//_\)M.L Comment_Begin   !* Start comments with double slashes!
    40 M.L Comment_Column
    1M(M.M &_Set_Mode_Line)BCPL
    
 