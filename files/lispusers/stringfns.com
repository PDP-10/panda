(FILECREATED "13-NOV-82 17:21:07" ("compiled on " <LISPUSERS>STRINGFNS.;14) (2 . 2) recompiled exprs: 
nothing in WORK dated "11-NOV-82 10:34:58")
(FILECREATED "13-NOV-82 17:20:48" <LISPUSERS>STRINGFNS.;14 6570 changes to: (VARS STRINGFNSCOMS) 
previous date: " 8-SEP-81 23:33:48" <LISPUSERS>STRINGFNS.;13)
DUMMYSTRING BINARY
                -.            Z  ,<  @     ,~   Z   ,<     ,>  ,>  ^"  ,>  ,>  ,<  ,<  $  $Bx  ,^  /  .Bx  ,^  /  ,\   B  Z  ,~   
      \  ""
(VARIABLE-VALUE-CELL X . 27)
-1
262143
MAPPAGE
(BHC ENTER0)   8      
STRINGFROMFILE BINARY
    3    Ť    ą-.           ŤZ   B  ŹB  Ź,<  @  -  +   *Z  2B   +   Z   B  .,<  @  Ž   +       ,>  +,>         ,^  /  2b  +   Z  ,<  Z  ,<  Z  B  /F  ŻXB     ."  ,   XB  +   ,~   ,~   Z  ,   Z  -,   +   Z  B  0XB  ,    "  "   +   ^@  4$  D  <h  ŠZ@     "&      +    4F  Š   ,   XB  Z  ,<  ,<  °,<  "  .,   ,>  +,>     Ą.Bx  ,^  /  ,   F  1XB  ",~   Z  ),~     RU AP   (VARIABLE-VALUE-CELL FILE . 43)
(VARIABLE-VALUE-CELL STRING . 84)
INPUT
(VARIABLE-VALUE-CELL FILE . 0)
(1 VARIABLE-VALUE-CELL I . 76)
NCHARS
(VARIABLE-VALUE-CELL N . 22)
READC
RPLSTRING
CONCAT
1
SUBSTRING
(IUNBOX FILEN FCHAR PNAMT UPATM SKNSTP IFSET MKN BHC KT ENTERF) X   h   H   8   (       p    " @               
STRINGTOFILE BINARY
                -.           Z   B  B  ,<  @     +   Z  2B   +   Z   ,<  D  ,~   Z  B  ,   ,>  ,>  Z  -,   +   Z  B  XB  ,   ,^  /     "&      ,~   Z  ,~     R%
      (VARIABLE-VALUE-CELL FILE . 17)
(VARIABLE-VALUE-CELL STRING . 35)
OUTPUT
PRIN3
OPNJFN
MKSTRING
(BHC UPATM SKNSTP GUNBOX KT ENTERF)                          
UNBUFFER BINARY
       @    8    >-.           8Z   B  9B  9,<  @  8   +   śZ  2B   +   Z   B  š,<  @  :  +   Z  B  ;3B   +       ,>  ˇ,>         ,^  /  2"  +   Z  ,<     ."  ,   XB  ,<  Z  B  ťF  <XB  +   Z  Z  3B  +   Z  ,<  ,<  źF  =XB  ,~   ,~   Z  ,   ,>  ˇ,>   Z  -,   +    Z  B  ˝XB  ,    "  "   +   ,^   /  Z@  7J  +   6^@  5$  Ž+   °   
`d  +   ą $   +   Ž   1D  +   ,5h  Ž D@  +   6 $  d  +   °   4D  ŚD  /(  1D  +   )   !5h  ­4H  6/*    "(  XB  Z   ,<  ,<  źF  =XB  ł,~   Z  ľ,~     RU(D`E,S%     (VARIABLE-VALUE-CELL FILE . 102)
(VARIABLE-VALUE-CELL STRING . 109)
INPUT
NCHARS
(VARIABLE-VALUE-CELL N . 45)
(0 VARIABLE-VALUE-CELL I . 44)
READP
READC
RPLSTRING
1
SUBSTRING
CONCAT
(ASZ FCHAR FILEN PNAMT UPATM SKNSTP FX IFSET MKN BHC KNIL KT ENTERF)  ł    , `   H   (      p   8             $ x   8    h      
UCASESTRING BINARY
           
    -.           
Z   -,   +   Z   ,~   Z  ,   +     0"  °0b  =+   /"  b  =(  Z  ,~   H  (VARIABLE-VALUE-CELL STRING . 18)
(UPATM KNIL SKNSTP ENTERF)                  
(PRETTYCOMPRINT STRINGFNSCOMS)
(RPAQQ STRINGFNSCOMS ((FNS DUMMYSTRING STRINGFROMFILE STRINGTOFILE UNBUFFER UCASESTRING) (DECLARE: 
DONTCOPY EVAL@COMPILE DONTEVAL@LOAD (FILES (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) CJSYS))))
NIL
    