(FILECREATED "13-NOV-82 17:21:07" ("compiled on " <LISPUSERS>STRINGFNS.;14) (2 . 2) recompiled exprs: 
nothing in WORK dated "11-NOV-82 10:34:58")
(FILECREATED "13-NOV-82 17:20:48" <LISPUSERS>STRINGFNS.;14 6570 changes to: (VARS STRINGFNSCOMS) 
previous date: " 8-SEP-81 23:33:48" <LISPUSERS>STRINGFNS.;13)
DUMMYSTRING BINARY
                -.            Z  ,<   @     ,~   Z   ,<      ,>  ,>   ^"  ,>  ,>   ,<  ,<  $  $Bx  ,^   /   .Bx  ,^   /   ,\   B  Z  ,~   
       \  ""
(VARIABLE-VALUE-CELL X . 27)
-1
262143
MAPPAGE
(BHC ENTER0)   8      
STRINGFROMFILE BINARY
    3    +    1-.           +Z   B  ,B  ,,<   @  -  +   *Z  2B   +   Z   B  .,<   @  .   +       ,>  +,>           ,^   /   2b  +   Z  ,<   Z  	,<  Z  B  /F  /XB     ."   ,   XB  +   	,~   ,~   Z  ,   Z  -,   +   Z  B  0XB  ,    "  "   +   ^@  4$  D  <h  )Z@     "&      +    4F  )   ,   XB  Z  ,<  ,<  0,<  "  .,   ,>  +,>      !.Bx  ,^   /   ,   F  1XB  ",~   Z  ),~      RU AP   (VARIABLE-VALUE-CELL FILE . 43)
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
(IUNBOX FILEN FCHAR PNAMT UPATM SKNSTP IFSET MKN BHC KT ENTERF) X   h   H   8   (       p    " @               
STRINGTOFILE BINARY
                -.           Z   B  B  ,<   @     +   Z  2B   +   Z   ,<  D  ,~   Z  B  ,   ,>  ,>   Z  -,   +   Z  B  XB  ,   ,^   /      "&      ,~   Z  ,~      R%
      (VARIABLE-VALUE-CELL FILE . 17)
(VARIABLE-VALUE-CELL STRING . 35)
OUTPUT
PRIN3
OPNJFN
MKSTRING
(BHC UPATM SKNSTP GUNBOX KT ENTERF)               
           
UNBUFFER BINARY
       @    8    >-.           8Z   B  9B  9,<   @  8   +   6Z  2B   +   Z   B  9,<   @  :  +   Z  B  ;3B   +       ,>  7,>           ,^   /   2"  +   Z  ,<      ."   ,   XB  ,<   Z  	B  ;F  <XB  +   	Z  Z  3B  +   Z  ,<  ,<  <F  =XB  ,~   ,~   Z  ,   ,>  7,>   Z  -,   +    Z  B  =XB  ,    "  "   +   ,^   /   Z@  7J  +   6^@  5$  .+   0   
`d  +   1 $   +   .   1D  +   ,5h  . D@  +   6 $  d  +   0   4D  &D  /(   1D  +   )   !5h  -4H  6/*    "(  XB  Z   ,<  ,<  <F  =XB  3,~   Z  5,~      RU(D`E,S%     (VARIABLE-VALUE-CELL FILE . 102)
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
(ASZ FCHAR FILEN PNAMT UPATM SKNSTP FX IFSET MKN BHC KNIL KT ENTERF)  3    , `   H   (      p   8             $ x   8    h      
UCASESTRING BINARY
           
    
-.           
Z   -,   +   Z   ,~   Z  ,   +     0"  00b  =+   /"  b  =(  Z  ,~   H  (VARIABLE-VALUE-CELL STRING . 18)
(UPATM KNIL SKNSTP ENTERF)                  
(PRETTYCOMPRINT STRINGFNSCOMS)
(RPAQQ STRINGFNSCOMS ((FNS DUMMYSTRING STRINGFROMFILE STRINGTOFILE UNBUFFER UCASESTRING) (DECLARE: 
DONTCOPY EVAL@COMPILE DONTEVAL@LOAD (FILES (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) CJSYS))))
NIL
