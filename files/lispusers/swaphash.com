(FILECREATED "23-SEP-81 22:54:00" ("compiled on " 
<LISPUSERS>SWAPHASH.;55) (2 . 2) bcompl'd in WORK dated NOBIND)
(FILECREATED "15-JUN-79 22:58:23" <LISPUSERS>SWAPHASH.;55 12910 previous
 date: "15-JUN-79 22:55:34" <LISPUSERS>SWAPHASH.;54)
(ADDTOVAR NOSWAPFNS SADDHASH1 SGETHASH1 SEQMEMBHASH1 SPUTHASH1 SSUBHASH1
 STESTHASH1 SHARRAY1)

HASHFULLA0006 BINARY
                -.          Z   ,<  Z   ,<  Z   F  ,~       (VARIABLE-VALUE-CELL V . 5)
(VARIABLE-VALUE-CELL K . 3)
(VARIABLE-VALUE-CELL NEWH . 7)
SPUTHASH
(ENTERF)      

HASHFULL BINARY
        »    0    ¹-.           0@  ²  ,~   ^"  ,>  ¯,>  Z   B  3,   $Bx  ,^  /  ,   B  ³XB   B  43B   +   ¨Z   2B  ´+   #@  5  +   ¢Z  B  ¶,      Z  7 D  XB   ,   ,>  ¯,>  +    Z  ,<  ,<x  ,   YB   XB   Z  Z   3B  7   7   +   Z  Z  3B  7   7   +   Z  ,<  Z  ,<  Z  F  ´Z  >  >"x  +   ,^  /  ,~   +   %Z  ,<  Z  ·D  8Z  #,<  Z     ,\   B  +   )   ¸Z  ,<  ,<  Z  ,<  Z   ,<  Z  %,<  ,   F  9Z   ,~     H:È "`0       (VARIABLE-VALUE-CELL FN . 82)
(VARIABLE-VALUE-CELL H . 89)
(VARIABLE-VALUE-CELL SWAPHASHNULL . 51)
(VARIABLE-VALUE-CELL X . 85)
(VARIABLE-VALUE-CELL V . 87)
(NIL VARIABLE-VALUE-CELL NEWH . 76)
SHASHSIZE
SHARRAY
SWPARRAYP
SADDHASH
(NIL VARIABLE-VALUE-CELL X . 0)
(NIL VARIABLE-VALUE-CELL Y . 58)
(NIL VARIABLE-VALUE-CELL INDEX . 62)
ARRAYSIZE
1000000
HASHFULLA0006
SMAPHASH
SHOULDNT
RETAPPLY
(LIST3 KT FFNOPR GUNBOX KNIL MKN BHC IUNBOX ENTERF)   ®        X       x           ¢     x        

NEXTPRIME BINARY
            -.               0b  +   Z"  ,~   ,<   ,<  Zp  -,   +   Z   +   Zp  ,<  ,<wÿ/  @     +      ,>  ,>         ,^  /  &     0B   7   Z   ,~   3B   +   Zp  +   [p  XBp  +   /  2B   +   Zp  +      ."  ,   XB  +   /  Z  ,~     BP R(   (VARIABLE-VALUE-CELL N . 53)
((2 3 5 7 11 13) . 0)
(VARIABLE-VALUE-CELL D . 25)
(MKN KT BHC SKNLST KNIL ASZ ENTERF)         0  p 
         (   x            

SADDHASH BINARY
             -.           Z   ,<  Z  D  ,~       (VARIABLE-VALUE-CELL X . 0)
(VARIABLE-VALUE-CELL V . 0)
(VARIABLE-VALUE-CELL H . 3)
SADDHASH1
SWPPOS
(ENTERF)     

SADDHASH1 BINARY
       ¼    6    º-.            6,<   ,<   Z   4Z  1[ A" ÿj"  #  $  ´&"  ,>  5,> ­ h  &"'.$  Q$   ,>  µ,>  ,>  ,>  [x  Z  2B  +   Zx  XBwÿZ   2B  +   /  Z   +    Z   2B  +   Z  XCx  /  +   Zp  3B   +   ZwÿXB  Z   XCx  Z   XBp  +   ¥ZwÿZ  2B  7   7   +   ¥Z  XCx  Z   XBp  +   ¥[x  Z  2B  7   7   +   ¥Z  QCx  Z  XCx  /  +   4Z  1 ~.bx  Z0d  +   * h  /" Bx   ÿ2D  +   ,<  8"  ¸4Z  1+                               Z  9Z  ,<  ,<  ¹$  :/  +   (
    B"  B |4     (VARIABLE-VALUE-CELL X . 69)
(VARIABLE-VALUE-CELL V . 71)
(VARIABLE-VALUE-CELL SWAPHASHNULL . 64)
(VARIABLE-VALUE-CELL SWAPHASHNLISTPTAIL . 53)
SADDHASH
HASHFULL
((SADDHASH X V H) . 0)
((SADDHASH X V H) . 0)
RETEVAL
(KT URET2 BHC BR KNIL ENTER0)  (  P       H ¥ P     
    " H  h   0        

SGETHASH BINARY
             -.           Z   ,<  Z  D  ,~       (VARIABLE-VALUE-CELL X . 0)
(VARIABLE-VALUE-CELL H . 3)
SGETHASH1
SWPPOS
(ENTERF)    

SGETHASH1 BINARY
       F    A    D-.           A,<   ,<   ,<   Z   4Z  »[ A" ÿj"  #  $  ¿&"  ,>  @,> 8 h  &"'.$  Q$   ,>  À,>  ,>  ,>  [x  Z  2B  +   Zx  XBwÿZ   3B  7   7   +   §Zp  Z   2B  +   ZwÿXBp  +   §ZwÿZ  2B  +   Z  XBp  +   §ZwÿZw,   XBw+   §[x  Z  2B  7   7   +   §/  Zw,<  ZwÿZ  3B  +   "+   ¢Z      ,\  2B   +   ¥ "  +   '[  QD   "  +    4Z  » ~.bx  Z0d  +   , h  /" Bx   ÿ2D  +   /  Zw,<  ZwÿZ   3B  +   ±+   2Z      ,\  2B   +   5 "  +   ¶[  QD   "  +    4Z  »+                               Z  ÂZ  ,<  ,<  C$  Ã/  Z   +    (
    BaPB
`  (VARIABLE-VALUE-CELL X . 25)
(VARIABLE-VALUE-CELL SWAPHASHNULL . 55)
(VARIABLE-VALUE-CELL SWAPHASHNLISTPTAIL . 95)
((SGETHASH X H) . 0)
((SGETHASH X H) . 0)
RETEVAL
(URET3 BHC COLLCT KT BR KNIL ENTER0)  @ x (    ? h             (   x 4 ( ¤ 0     0        

SHARRAY BINARY
              -.           Z   B  	XB  B  ,<  @  
   ,~   Z   ,<  Z  D  Z  ,~   !@  (VARIABLE-VALUE-CELL N . 5)
NEXTPRIME
SWPARRAY
(VARIABLE-VALUE-CELL H . 15)
SHARRAY1
SWPPOS
(ENTERF)      

SHARRAY1 BINARY
             -.          Z   ,<  Z   ,      ,\  .$   D   &   F Z   Q  .$  ."   F  ."  1"  +   ,~      (VARIABLE-VALUE-CELL ARR . 3)
(VARIABLE-VALUE-CELL N . 5)
(VARIABLE-VALUE-CELL SWAPHASHNULL . 13)
(GUNBOX ENTERF)          

SHASHSIZE BINARY
            -.          @    ,~   @    +   Z   B  ,      Z   D  XB   ,   ,>  ,>  +   Z  ,<  ,<x  ,   YB   XB   Z  Z   3B  7   7   +   Z  Z  3B  7   7   +       ."   $   @  Z  >  >"x  +   
,^  /  ,~   Z  ,~     )
     (VARIABLE-VALUE-CELL H . 20)
(VARIABLE-VALUE-CELL SWAPHASHNULL . 33)
(0 VARIABLE-VALUE-CELL SZ . 49)
(NIL VARIABLE-VALUE-CELL X . 26)
(NIL VARIABLE-VALUE-CELL Y . 32)
(NIL VARIABLE-VALUE-CELL INDEX . 42)
ARRAYSIZE
1000000
(BHC FIXT KNIL KT FFNOPR GUNBOX IUNBOX ENTERF)                (         	           

SMAPHASH BINARY
     *    #    ¨-.          #@  ¤  ,~   Z   B  &,      Z  ¦ D  XB   ,   ,>  ¢,>  +   Z  ,<  ,<x  ,   YB   XB   Z  Z   3B  7   7   +   Z  Z  3B  7   7   +      ,>  ¢,>  Z  ,<  Z  'D  §      ,^  /  2B  +   Z   ,<  Z  ,<  Z  D  (,<  Z  ,<   "  ,   +   Z   Z  >  >"x  +   ,^  /  Z   ,~     HP AF@     (VARIABLE-VALUE-CELL H . 52)
(VARIABLE-VALUE-CELL FN . 48)
(VARIABLE-VALUE-CELL SWAPHASHNULL . 30)
(NIL VARIABLE-VALUE-CELL X . 55)
(NIL VARIABLE-VALUE-CELL Y . 29)
(NIL VARIABLE-VALUE-CELL INDEX . 61)
ARRAYSIZE
1000000
STESTHASH1
SWPPOS
SGETHASH
(EVCC BHC KNIL KT FFNOPR GUNBOX IUNBOX ENTERF)  `         ¢ p  h                       

SEQMEMBHASH BINARY
               -.           Z   ,<  Z  D  ,~       (VARIABLE-VALUE-CELL X . 0)
(VARIABLE-VALUE-CELL V . 0)
(VARIABLE-VALUE-CELL H . 3)
SEQMEMBHASH1
SWPPOS
(ENTERF)     

SEQMEMBHASH1 BINARY
      5    0    ³-.            0,<   ,<   Z   4Z  +[ A" ÿj"  #  $  ®&"  ,>  /,> § h  &"'.$  Q$   ,>  ¯,>  ,>  ,>  [x  Z  2B  +   Zx  XBwÿZ   2B  +   /  Z   +    Z   2B  +   Zp  3B   +   /  Z   +    Z   +   Z   2B  +   Z   +   Z   Z   XBp  +   [x  Z  2B  7   7   +   /  +   4Z  + ~.bx  Z0d  +   $ h  /" Bx   ÿ2D  +   /  +   4Z  ++                               Z  2Z  ,<  ,<  ²$  3/  +   (
    B$D M  (VARIABLE-VALUE-CELL X . 24)
(VARIABLE-VALUE-CELL V . 29)
(VARIABLE-VALUE-CELL SWAPHASHNLISTPTAIL . 35)
(VARIABLE-VALUE-CELL SWAPHASHNULL . 56)
((SEQMEMBHASH X V H) . 0)
((SEQMEMBHASH X V H) . 0)
RETEVAL
(URET2 KT BHC BR KNIL ENTER0) h      0     h ¦ x         `  p  H   (      

SPUTHASH BINARY
                -.           Z   ,<  @  	   +   Z   ,<  Z  D  
,~   Z  ,~   L   (VARIABLE-VALUE-CELL X . 0)
(VARIABLE-VALUE-CELL V . 13)
(VARIABLE-VALUE-CELL H . 8)
(VARIABLE-VALUE-CELL V1 . 0)
SPUTHASH1
SWPPOS
(ENTERF)    

SPUTHASH1 BINARY
       Ä    =    Â-.            =Z   4Z  8[ A" ÿj"  #  $  »&"  ,>  <,> ´ h  &"'.$  Q$   ,>  ¼,>  ,>  ,>  [x  Z  2B  +   Z   -,   +   Z  ,<  [  XB  ,\  +   3B   +   Z  ?,<  Z  Z   XCp  QEp  ,\  XB  Z   +   Z   XCx  +   ©[x  Z  2B  7   7   +   ©Z  3B   +   (Z  QCx  Z  -,   +   ¢Z  ,<  [  XB   ,\  +   'Z  ¿,<  Z  !Z   XCp  QEp  ,\  XB  £Z  XCx  +   ©/  Z   ,~   4Z  8 ~.bx  Z0d  +   . h  /" Bx   ÿ2D  +   Z  &3B   +   ²,<  @"  À+   ³/  +   ¨4Z  8+                               Z  AZ  ,<  ,<  Á$  B/  +   ¨(
    	@B D'\h   (VARIABLE-VALUE-CELL X . 58)
(VARIABLE-VALUE-CELL V1 . 95)
(VARIABLE-VALUE-CELL SWAPHASHNLISTPTAIL . 77)
(VARIABLE-VALUE-CELL SWAPHASHNULL . 50)
((NIL) . 0)
((NIL) . 0)
SPUTHASH
HASHFULL
((SPUTHASH X V H) . 0)
((SPUTHASH X V H) . 0)
RETEVAL
(BHC KT KNIL SKLST BR ENTER0)   » 8 )        1  % P  H      `         

SSUBHASH BINARY
                -.           Z   ,<  Z  D  ,~       (VARIABLE-VALUE-CELL X . 0)
(VARIABLE-VALUE-CELL V . 0)
(VARIABLE-VALUE-CELL H . 3)
SSUBHASH1
SWPPOS
(ENTERF)     

SSUBHASH1 BINARY
       ª    &    )-.           &Z   4Z  ![ A" ÿj"  #  $  ¤&"  ,>  %,>  h  &"'.$  Q$   ,>  ¥,>  ,>  ,>  [x  Z  2B  +   Zx  Z   2B  7   7   +   Z   XCx  +   [x  Z  2B  7   7   +   /  Z   ,~   4Z  ! ~.bx  Z0d  +    h  /" Bx   ÿ2D  +   /  +   4Z  !+                               Z  §Z  ,<  ,<  ($  ¨/  +   (
    B`@    (VARIABLE-VALUE-CELL X . 22)
(VARIABLE-VALUE-CELL V . 26)
(VARIABLE-VALUE-CELL SWAPHASHNULL . 35)
((SSUBHASH X V H) . 0)
((SSUBHASH X V H) . 0)
RETEVAL
(BHC KT KNIL BR ENTER0)   ¤ H      x   X  p         

STESTHASH BINARY
       	        -.           Z   ,<  Z  D  3B   +   Z   ,~   Z   ,~       (VARIABLE-VALUE-CELL X . 0)
(VARIABLE-VALUE-CELL H . 3)
STESTHASH1
SWPPOS
(KT KNIL ENTERF)   X    h        

STESTHASH1 BINARY
        2    -    °-.           -,<   Z   4Z  ([ A" ÿj"  #  $  «&"  ,>  ,,> ¤ h  &"'.$  Q$   ,>  ¬,>  ,>  ,>  [x  Z  2B  +   Zx  XBp  Z   3B  7   7   +   Zp  Z   3B  7   7   +   Zx  /"     Z  ® D  XBp  /  Zp  +    [x  Z  2B  7   7   +   /  Z   +    4Z  ( ~.bx  Z0d  +   ! h  /" Bx   ÿ2D  +   /  +   4Z  (+                               Z  /Z  ,<  ,<  ¯$  0/  +   (
     B@&@  (VARIABLE-VALUE-CELL X . 23)
(VARIABLE-VALUE-CELL SWAPHASHNULL . 49)
(VARIABLE-VALUE-CELL SWAPHASHNLISTPTAIL . 34)
1000000
((STESTHASH X H) . 0)
((STESTHASH X H) . 0)
RETEVAL
(URET1 BHC KT BR KNIL ENTER0)       8 £ @      0          (          
(PRETTYCOMPRINT SWAPHASHCOMS)
(RPAQQ SWAPHASHCOMS ((DECLARE: FIRST (ADDVARS (NOSWAPFNS SADDHASH1 
SGETHASH1 SEQMEMBHASH1 SPUTHASH1 SSUBHASH1 STESTHASH1 SHARRAY1))) (E (
RESETSAVE CLISPIFYPRETTYFLG NIL)) (DECLARE: EVAL@COMPILE DONTCOPY (PROP 
MACRO .LOOKUP. LH RH HIND SETLH SETRH SMAPHASH1) (FILES (SYSLOAD) NOBOX)
) (* These define swapped hasharrays and are masterscope-independent) (
FNS HASHFULL NEXTPRIME SADDHASH SADDHASH1 SGETHASH SGETHASH1 SHARRAY 
SHARRAY1 SHASHSIZE SMAPHASH SEQMEMBHASH SEQMEMBHASH1 SPUTHASH SPUTHASH1 
SSUBHASH SSUBHASH1 STESTHASH STESTHASH1) (GLOBALVARS SWAPHASHNLISTPTAIL 
SWAPHASHNULL) (VARS SWAPHASHNLISTPTAIL SWAPHASHNULL)))
(* These define swapped hasharrays and are masterscope-independent)
(RPAQQ SWAPHASHNLISTPTAIL " . ")
(RPAQQ SWAPHASHNULL "SHNIL")
NIL
    