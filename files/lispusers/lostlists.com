(FILECREATED "11-Apr-82 09:51:09" ("compiled on " <DONC>LOSTLISTS..17) (
2 . 2) tcompl'd in "INTERLISP-10 " dated "18-Mar-82 14:03:52")
(FILECREATED "11-Apr-82 09:50:52" <DONC>LOSTLISTS..17 5890 changes to: 
Sweep HowMany Mark MarkAtoms previous date: " 9-Apr-82 14:23:52" 
<DONC>LOSTLISTS..15)

HowMany BINARY
      <    3    :-.           3   2,   ,<     2,   ,<  @  4 @+   )Z   B  µ,   @   ^"    $   @   ,<   Z  Z$   ,   3B   +   Zp  +   §Z  ,<  Z  
D  6XB   @  ¶  +   %    ,>  ²,>   `    ,^  /  3b  +   +   $^"  ,>  ²,>     ,>  ²,>     "     ,^  /  (  ABx  ,^  /  0B   +   +   ¡   	."   $   @     ."  ,   XB  ¡+   Z` ,~      /"   $   @  %+   
/  Z  !,~   ,<  ,<  8^"  ,>  ²,>  Z   B  ¸,   $Bx  ,^  /  ,   ,<  ,<  9,<  ¹^"  ,   ,~     B    
@i       (VARIABLE-VALUE-CELL BitTable . 27)
(VARIABLE-VALUE-CELL ListPages . 87)
(VARIABLE-VALUE-CELL Sum . 80)
(VARIABLE-VALUE-CELL Index . 77)
(NIL VARIABLE-VALUE-CELL Word . 48)
ARRAYSIZE
ELT
31
NIL
(0 VARIABLE-VALUE-CELL I . 70)
of
LENGTH
cells
marked
(LIST IUNBOX BHC EQP ASZ KNIL FIXT GUNBOX MKN ENTER0)     X   p ¨ h  X   @   8   H     '          ¯ 8   0      

InitLostLists BINARY
        >    ³    <-.            ³,<  µ,<  µ$  6XB   @  ¶  (
+   Z"  XB      ,>  3,>         ,^  /  3b  +   +      $"  -,   +   +   Z  XB` Z` 3B   +   ,<  Z` ,   XB` ,\  QB  +   Z` ,   XB` XB`    ."  ,   XB  +   Z` ,~   XB   ,<  @  9  +   ¥Z` -,   +   +   ¤Z  XB   Z  ,<  ,<  Z  F  ;[` XB`     ."  ,   XB  "+   Z` ,~   ^"  ,>  3,>  Z  B  »,   $Bx  ,^  /  ,   ,<  ^"  ,>  3,>  Z  'B  »,   $Bx  ,^  /  ,   D  6XB   Z   XB   Z   ,~     QF` D@$      (VARIABLE-VALUE-CELL PageTable . 61)
(VARIABLE-VALUE-CELL ListPages . 89)
(VARIABLE-VALUE-CELL BitTable . 97)
(VARIABLE-VALUE-CELL BadPage . 99)
512
ARRAY
(512 VARIABLE-VALUE-CELL $$TEM3 . 15)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL i . 71)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL P . 60)
(1 VARIABLE-VALUE-CELL i . 0)
SETA
LENGTH
(IUNBOX MKN CONSNL KNIL SKNLST BHC ASZ ENTER0)   h )    ° 0 $ x   P     3        P     ª      `      

Mark BINARY
               -.          Z   ,<  Z   ,<  @   @ ,~   /  Z   ,  +   -,   ,~      (ûZ   .    4F  Z   .     (ıA(  .     A(   *  (
   A
 6@  ,~   .$     A(   *  (
   GJ ,>  Z  ,  ,^  [  +   XB   ,~      ,~   C @  H   (VARIABLE-VALUE-CELL L . 11)
(VARIABLE-VALUE-CELL BitTable . 3)
(VARIABLE-VALUE-CELL PageTable . 5)
(VARIABLE-VALUE-CELL BadPage . 47)
(VARIABLE-VALUE-CELL BitTab . 22)
(VARIABLE-VALUE-CELL PageTab . 18)
(SKLST ENTERF)         

MarkAtomsA0006 BINARY
       ¿    4    ½-.          4@  6  ,~   Z   ,<  ,<  7$  ·XB   [  B  8,>  ³,>  Z  B  ¸B  8.Bx  Z  ,<  Zp  Z 7@  7   Z  2B  9+   ,<p  ,<   Z   F  ¹B  :3B   +   Z   +   Z   /  3B   +   Z  B  º+   Z   B  8.Bx  ,^  /  ,   XB   Z  Z  ,   3B   +   Z   ,~   Z  2B   +   £Z  0B   +    +      ."  ,   XB   Z"   XB  Z   3B   +   Z  ,<  ,<  7Z  "F  ;3B   +   Z   2B   +   Z  %B  »3B   +   ,<  <"  »3B   +   Z  #B  »3B   +   ,<  ¼"  »3B   +   Z  ¦B  =+     3EP	@%%:]0     (VARIABLE-VALUE-CELL A . 84)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 30)
(VARIABLE-VALUE-CELL SaveSizes . 71)
(VARIABLE-VALUE-CELL Quiet . 81)
(NIL VARIABLE-VALUE-CELL Space . 100)
(NIL VARIABLE-VALUE-CELL OldSpace . 92)
Space
GETPROP
Mark
GETD
NOBIND
STKSCAN
RELSTK
EVAL
PUTPROP
PRIN1
" : "
" -> "
PRINT
(ASZ EQP MKN BHC KT KNIL KNOB ENTERF)   £     8   (      @   (     0 ` ,   ¨ P  P  p  8  x   P      

MarkAtoms BINARY
               -.           Z  B  Z   ,~       (VARIABLE-VALUE-CELL Quiet . 0)
MarkAtomsA0006
MAPATOMS
(KNIL ENTERF)         

MarkFreeCells BINARY
             -.               ,<  @     ,~   ,<  "  ,<   Z   Z$   ,   3B   +   	Zp  +      /"   $   @  	Z   ,   B  +   /  ,<  "  Z   ,~   0(@     RECLAIM
(VARIABLE-VALUE-CELL n . 21)
"Please do not interrupt for a little while"
PRIN1
Mark
"...OK"
(BHC CONSNL FIXT EQP ASZ KNIL ENTER0)  `   H   0    x    p   x           

ReInit BINARY
               -.           Z   3B   +      ,~   Z   B  ,<  @     ,~   ,<   Z   Z$   ,   3B   +   Zp  +   Z  ,<  Z  ,<  ,<  &     /"   $   @  +   /  Z   ,~   C     (VARIABLE-VALUE-CELL BadPage . 3)
(VARIABLE-VALUE-CELL BitTable . 22)
InitLostLists
ARRAYSIZE
(VARIABLE-VALUE-CELL Index . 31)
0
SETA
(BHC FIXT EQP ASZ KNIL ENTER0)               	         0      

Sweep BINARY
      °    *    /-.           *@  ª  ,~   Z   B  «,<  Zp  -,   +   +   (Zp  ,<  @  ,   +   ¦^"  ,>  ©,>      ."  $Bx  ,^  /  ,   ,<  @  ¬   ,~   @  -  ,~   Z"  XB      ,>  ©,>   `    ,^  /  3b  +   Z` ,~       /"   $   @  Z  ,   XB   B  ®1B   +   $Z  ,<  [  ,<  Z   -,   Z   ,\  2B  +   ¢[  +   #Z  ¡,   XB  ¢   ."  ,   XB  $+   [p  XBp  +   /  Z  £,~     F* H   @   (VARIABLE-VALUE-CELL ListPages . 6)
(NIL VARIABLE-VALUE-CELL Answer . 81)
(NIL VARIABLE-VALUE-CELL Cell . 59)
REVERSE
(VARIABLE-VALUE-CELL P . 21)
(VARIABLE-VALUE-CELL Loc . 51)
512
NIL
(NIL VARIABLE-VALUE-CELL I . 75)
Mark
(CONSS1 KNIL SKLST GUNBOX FIXT ASZ MKN BHC SKNLST ENTER0)   $                          & `     X    `      
(PRETTYCOMPRINT LOSTLISTSCOMS)
(RPAQQ LOSTLISTSCOMS ((FNS HowMany InitLostLists Mark MarkAtoms 
MarkFreeCells ReInit Sweep) (VARS SaveSizes)))
(RPAQQ SaveSizes T)
NIL
 