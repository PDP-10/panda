(FILECREATED " 7-Sep-80 23:32:29" ("compiled on " <EMACS>INTER..89) (2 . 2) 
recompiled exprs: nothing)
(FILECREATED " 7-Sep-80 23:32:18" <EMACS>INTER..89 41109 changes to: 
INTER.DIRECTORY previous date: " 6-Sep-80 22:10:20" <EMACS>INTER..88)
,, BINARY
             -.               (B  	,>  ,>      GBx  ,^  /  ,   ,~         (VARIABLE-VALUE-CELL X . 3)
(VARIABLE-VALUE-CELL Y . 7)
(MKN BHC ENTERF)   h    `      
BINARYMODE BINARY
                -.            ^"  (B  F  ,>  ,>              £+    +    +       ABx  ,^  /  ,   +   ^"   +   ,               $+    +    +    Z   ,~   ÿ            8&      (KNIL IUNBOX MKN BHC ENTER0)      H   (          
BYTEPOINTER BINARY
               -.           Z   ,<  ^"  ,>  ,>      &"        ^"  /  $Bx  ,^  /  ."  (B  ,>  ,>  ^"  (B  GBx  ,^  /  ,   ,<     &"  ,   D  D  ,~            (VARIABLE-VALUE-CELL BASE . 3)
(VARIABLE-VALUE-CELL OFFSET . 28)
,,
PLUS
(MKN BHC ENTERF)                
CF BINARY
              -.              Z   B  ,~       (VARIABLE-VALUE-CELL NAME . 4)
CHECK.EMACS
EMACS.GETDEF
(ENTERF)     
CFNS BINARY
              -.          Z   ,<  Zp  -,   +   +   Zp  ,<  @     +   ,<  Z   ,<  B  ,   ,   B  Z   B  Z  B  ,~   [p  XBp  +   /  ,<   "  ,~   eI(H     (VARIABLE-VALUE-CELL LST . 3)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 23)
(VARIABLE-VALUE-CELL L . 15)
DEFINEQ
GETDEF
DUMPX
TERPRI
DOWN
(KNIL BHC ALIST2 SKNLST ENTERF)      x   ( 
           
CHECK.EMACS BINARY
            -.           Z   2B   +      ,~       (VARIABLE-VALUE-CELL LASTEMACS . 3)
START.EMACS
(KNIL ENTER0)    0      
CP BINARY
      "        !-.             Z   2B   +   Z   XB  Z  ,<  ,<   $  Z  3B   +   -,   +   ,<  Z   D  Z  3B   +   3B   +   -,   +   ,<  ,<  ,   ,<  Z  D  ,<  Z  D  ,<  [  ,   B  ,<  Z  D  ,<   "  ,~   ,<   D   ,~   -CfV   (VARIABLE-VALUE-CELL X . 38)
(VARIABLE-VALUE-CELL LASTWORD . 9)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 42)
CHECK.EMACS
PRINT
"(SETPROPLIST "
PRIN3
QUOTE
PRIN4
1
SPACES
DUMPX
")

"
DOWN
"No editable property list:  "
ERROR
(ALIST2 LIST2 SKNNM SKLA KT KNIL ENTERF) H       `      P      @   8      
CREC BINARY
            -.          Z   2B   +   Z   XB  Z  ,<  ,<   $  Z  3B   +   ,<  ,<   ,<   ,<   ,<   *  3B   +   Z  ,<  ,<   ,<   ,<   ,<   *  B  ,<   "  ,~   ,<  Z  D  ,~   A 5@    (VARIABLE-VALUE-CELL X . 35)
(VARIABLE-VALUE-CELL LASTWORD . 8)
PRINT
RECLOOK
DUMPX
DOWN
"No editable type definition:  "
ERROR
(KT KNIL ENTERF)       p  `  8        0      
CV BINARY
      %        $-.             Z   2B   +   Z   XB  Z  ,<  ,<   $  Z  B  3B  +   ,<  Z   D  ,<  Z  	D  ,<   Z  D   Z  ,<  Z  D  !Z  B  ¡,<   Z  D   Z  B  B  ",<  ¢Z  D  Z  B  ¡Z  B  ¡,<   "  #Z  ,~   Z  ,<  ,<  $  £,~   {4-u(0  (VARIABLE-VALUE-CELL X . 49)
(VARIABLE-VALUE-CELL LASTWORD . 9)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 43)
CHECK.EMACS
PRINT
GETTOPVAL
NOBIND
%(
PRIN3
RPAQQ
1
SPACES
PRIN4
TERPRI
DUMPX
%)
DOWN
ERROR
(KT KNIL ENTERF)    h   x        
DISPLAY.IN.OTHER.WINDOW BINARY
               -.          ,<  Z   D  Z   ,<  Zp  -,   +   +   Zp  ,<  @     +   Z   ,<  Z  D  ,~   [p  XBp  +   /  ,<  ,<  ,<   ,<   (  ,~   Q     (VARIABLE-VALUE-CELL LIST . 6)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 19)
"M(M.M& Inter Display Text)"
PRIN3
(VARIABLE-VALUE-CELL X . 17)
DOWN1
((DOWN1 T) . 0)
RETEVAL
(KNIL BHC SKNLST ENTERF)   p   X    X      
DOWN BINARY
    $        #-.             ,<   "  ,<  @    ,~   ,<  Z   ,<  ,   ,   Z   ,   XB  XB` ,<  ,<  ,<   @   ` +   Z   Z   XB Z   B  !Zw~XB8 Z   ,~   2B   +   Z  ¡XB   [` XB  ,<  Z` Z  [  D  "Z  3B   +      ¢,~   Z` ,~   H* D&   (VARIABLE-VALUE-CELL NEGATE.ARG.FLG . 28)
(VARIABLE-VALUE-CELL RESETVARSLST . 39)
CHECK.EMACS
GCGAG
(VARIABLE-VALUE-CELL OLDVALUE . 11)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 45)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
DOWN1
ERROR
APPLY
ERROR!
(KT CF CONS CONSNL LIST2 KNIL ENTERF)          	                 0      
DOWN1 BINARY
                -.         0 @    ,~   Z   ,   ,   XB       ,<  Z   3B   +      "   $   +   Z  ,   ,\   B  Z  ,<  ,<  $  Z   B  Z   ,<  ,<   ,<   ,<  ,<   *  XB     Z   B  Z   ,<  ,<   ,<   &  ,~    DÂ(    (VARIABLE-VALUE-CELL NEGATE.ARG.FLG . 12)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 23)
(VARIABLE-VALUE-CELL EMACS.ARG.LOC . 10)
(VARIABLE-VALUE-CELL EMACS.ENTRY.HOOK . 27)
(VARIABLE-VALUE-CELL LASTEMACS . 36)
(VARIABLE-VALUE-CELL EMACS.EXIT.HOOK . 38)
(VARIABLE-VALUE-CELL EMACS.RETURN.CASES . 40)
(NIL VARIABLE-VALUE-CELL TEMP . 19)
0
SETFILEPTR
EVAL
START
SUBSYS2
SET.EMACS.VARS
APPLY
(KT GUNBOX FIXT KNIL MKN FGFPTR ENTERF)      0      h     x    P    H      
DUMP.LINES BINARY
        é    [    æ-.          [@  Ü   ,~   Z   -,   +      ÞZ  3B  +   Z   ,~   Z  ,   ,   XB   Z   ,<  ,<  _$  ß,<  Z  	,<  ,<  `&  àXB   Z  ,<  Z  ,<  D  aD  áZ  B  b2B   +   ^"   +   ,   ,>  Z,>  ,<  âZ   D  c2B   +   ^"   +   ,      ,^  /  ,>  Z,>  ,>  Z,>  Z  2B   +    ^"   +    ,      ,^  /  ,^  /     +    +    +    Z"   XB      /"   $   @   ,<   Z  ¥,<  Z  D  ã2B   +   ®Z  §,<  ,<  d$  ã3B   +   ¯Zp  +   ¸   «/"   $   @  ¯Z  1,<  Z  D  ä,<  ,<  e$  ã3B   +   8   ¨."  ,   XB  6+   ¨/  Z  ±,<  ,<  å$  f,   @  9^"  ,>  Z,>     »&"        ^"  /  $Bx  ,^  /  ."  (B  ,>  Z,>  ^"  (B  GBx  ,^  /  ,   ,<  Z  ²,<     ½&"  ,   D  fD  c2B   +   M^"   +   Í,      ,>  Z,>  ,>  Z,>  Z  &,<  Z  ÈD  a2B   +   T^"   +   Ô,      ,^  /  ,^  /     Ú   +    +    +    +          2 cU*BE  M 1  RBP     (VARIABLE-VALUE-CELL N . 83)
(VARIABLE-VALUE-CELL FANCY.DRIBBLE.FILE . 35)
(VARIABLE-VALUE-CELL EMACS.AC.BLK.START . 143)
(NIL VARIABLE-VALUE-CELL END . 31)
(NIL VARIABLE-VALUE-CELL NUMBER.CHARS . 160)
(NIL VARIABLE-VALUE-CELL NUMBER.CRS . 111)
(NIL VARIABLE-VALUE-CELL I . 162)
DRIBBLEFILE
81
TIMES
2560
MIN
DIFFERENCE
SETFILEPTR
OPNJFN
147904
,,
EQP
0
GET.BYTE
13
2
PLUS
(GUNBOX FIXT ASZ BHC IUNBOX MKN FGFPTR KNIL SKNLST ENTERF)  @    (    &    × 
h G ( ¹ 8 ¢ @   
P N   X   	( Ç       	    S 	@ 6 h «      x    H      
DUMP.LINES? BINARY
               -.           Z   0B   +   Z   ,~   B  ,~       (VARIABLE-VALUE-CELL NUMBER.OF.LINES . 3)
DUMP.LINES
(KNIL ASZ ENTER0)             
DUMPX BINARY
     ª    $    )-.          $   %Z   -,   +   ¡Z  2B  ¥+   ¡[  -,   +   ¡[  [  2B   +   ¡[  Z  -,   +   ¡[  Z  [  -,   +   ¡[  Z  [  [  2B   +   ¡,<  &Z   D  ¦,<  ¥Z  D  ¦,<  'Z  D  ¦,<  &Z  D  ¦[  Z  Z  ,<  Z  D  §,<  'Z  D  ¦[  Z  [  Z  ,<  ,<   $  (,<  ¨Z  D  ¦,<  ¨Z  D  ¦,~   Z  ,<  ,<   $  (,~   26AP!     (VARIABLE-VALUE-CELL X . 67)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 64)
CHECK.EMACS
DEFINEQ
%(
PRIN3
% 
PRIN4
DUMPX1
%)
(KNIL SKLST ENTERF)  8         (   8      
DUMPX1 BINARY
       I    7    G-.          7,<  :"  º,<  @  ;  ,~   ,<  ºZ   ,<  ,   ,   Z   ,   XB  XB` ,<  =,<  ½,<   @  > ` +   .Z   Z  ¿XB Z   B  @,<  @  À  +   ,,<  @Z  ,<  ,   ,   Z  ,   XB  XB` ,<  Â,<  ½,<   @  > ` +   #Z   Z  ¿XB ,<  CZ   D  Ã,<  @  D  +   !Z   ,<  Z   ,<  Z   F  EZ   ,~   Zw|XB8 Z   ,~   2B   +   %Z  ÅXB   [` XB  ,<  @Z` Z  [  D  FZ  ¤3B   +   +   Æ,~   Z` ,~   Zw~XB8 Z   ,~   2B   +   0Z  ÅXB  ¨[` XB  ¥,<  ºZ` Z  [  D  FZ  ¯3B   +   6   Æ,~   Z` ,~   TVU*AD& b     (VARIABLE-VALUE-CELL X . 58)
(VARIABLE-VALUE-CELL DEF . 62)
(VARIABLE-VALUE-CELL LEFT . 60)
(VARIABLE-VALUE-CELL RESETVARSLST . 97)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 27)
(VARIABLE-VALUE-CELL PRETTYPRINTMACROS . 52)
79
LINELENGTH
(VARIABLE-VALUE-CELL OLDVALUE . 34)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 103)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
OUTFILE
(VARIABLE-VALUE-CELL OLDVALUE . 0)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 0)
((DUMMY) . 0)
(((* . GETCOMMENT) (QUOTE . MAKE.QUOTE)) . 0)
APPEND
(VARIABLE-VALUE-CELL PRETTYPRINTMACROS . 0)
(NIL VARIABLE-VALUE-CELL FONTCHANGEFLG . 0)
PRINTDEF
ERROR
APPLY
ERROR!
(KT CF KNIL CONS CONSNL LIST2 ENTERF)   . 0        5 p * @ ! p         8       p      
E! BINARY
      ¿    2    ½-.         ( 2Z   ,<  Z   D  µZ   -,   +   ,<  ,<  6$  ¶3B   +   @  7  +   Z  XB`     ,>  ±,>   `    ,^  /  3b  +   Z` ,~   Z   B  ¸   
."  ,   XB  +   
+   0@  9  +   0Z   ,   ,   XB   ,<   Z  ,   ,   ,<  Z   D  ¹3B   +   %Z  ,<  ,<   $  :B  º,   A"  ¿,>  ±,>  Z   B  ;.Bx  ,^  /  ."  [  A"   0B   +   &Zp  +   §Z  B  »+   /  Z  &,   ,   ,<  Z  D  ¹3B   +   ¯Z  (,<  Z  D  <Z  B  ¸+   ,~   ,<  ¼"  =,~     h@D: 2 +"l      (VARIABLE-VALUE-CELL N . 18)
(VARIABLE-VALUE-CELL FN . 92)
(VARIABLE-VALUE-CELL EMACS.PT . 3)
(VARIABLE-VALUE-CELL EMACS.ZV . 5)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE . 88)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE.EOF . 84)
(VARIABLE-VALUE-CELL EMACS.READ.TABLE . 64)
MAP.BYTES
0
GREATERP
NIL
(1 VARIABLE-VALUE-CELL I . 36)
NIL
E.1
(NIL VARIABLE-VALUE-CELL OLDLOC . 90)
LESSP
PEEKC
CHCON1
GETREADTABLE
READC
SETFILEPTR
8
CHARACTER
(IUNBOX FGFPTR MKN BHC KNIL SKNM ENTERF)      ©      *   (    # `   @  8   x    P      
E. BINARY
              -.          Z   ,<  Z   D  Z   B  ,~       (VARIABLE-VALUE-CELL FN . 7)
(VARIABLE-VALUE-CELL EMACS.PT . 3)
(VARIABLE-VALUE-CELL EMACS.ZV . 5)
MAP.BYTES
E.1
(ENTERF)      
E.1 BINARY
       å    Ï    â-.           Ï@  R  ,~   @  Ò  +   Z   ,<  Z   D  S,~   XB   ,<  Ó,<   Z   F  TZ   2B  Ô+   ,<  ÔZ  ,<  ,   +   2B  U+   ,<  UZ  ,<  ,   +   Z  XB  ,<  Õ,<   $  V,<  @  Ö  +   «,<  VZ   ,<  ,   ,   Z   ,   XB  XB` ,<  Ø,<  Y,<   @  Ù ` +   ¢Z   Z  [XB Z  ,<  ,<   $  ÛZw}XB8 Z   ,~   2B   +   ¤Z  \XB   [` XB  ,<  VZ` Z  [  D  ÜZ  $3B   +   ª   ],~   Z` ,~   ,<  ÝZ  3B   +   13B   +   1-,   +   1,<  U,<  ,   ,<  ,<   ,   ,<  ,<   $  ^XB  ,,<  Þ,<   $  V,<  @  _  +   N,<  VZ  ,<  ,   ,   Z  %,   XB  ºXB` ,<  a,<  Y,<   @  Ù ` +   EZ   Z  [XB Z  4,<  ,<   $  ÛZw}XB8 Z   ,~   2B   +   GZ  \XB  ([` XB  »,<  VZ` Z  [  D  ÜZ  Æ3B   +   M   ],~   Z` ,~   ,<  á"  b,~   "%cbU@PÁL%0,UDc        (VARIABLE-VALUE-CELL FN . 19)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE . 9)
(VARIABLE-VALUE-CELL EMACS.READ.TABLE . 11)
(VARIABLE-VALUE-CELL LISPXHISTORY . 17)
(VARIABLE-VALUE-CELL RESETVARSLST . 143)
(NIL VARIABLE-VALUE-CELL TEMP . 130)
(T VARIABLE-VALUE-CELL NORMALCOMMENTSFLG . 0)
READ
_
PROMPTCHAR
DEFINEQ
QUOTE
((3 . 4) . 0)
PRINTLEVEL
(VARIABLE-VALUE-CELL OLDVALUE . 113)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 149)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
PRINT
ERROR
APPLY
ERROR!
LISPXEVAL
ENVEVAL
((3 . 4) . 0)
(VARIABLE-VALUE-CELL OLDVALUE . 0)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 0)
((DUMMY) . 0)
8
CHARACTER
(LIST3 SKNNM CF CONS CONSNL KNIL LIST2 KT ENTERF)  0   x        <    0     L ` ¾ ` ² X © 8  8   ( ±    X   P C @ ® (         
EDIT.DRIBBLE.FILE BINARY
      "        !-.           @    ,~      XB   2B   +   ,<  "  ,<   ,<   ,<   &  Z  ,<  ,<  ,<  ,<   ,<  *  Z  B  Z  ,<  ,<   ,<   &  Z  ,<  B  D  ,<  Z   D  Z   ,<  Z  D  ,<   Z  D  ,<   "   Z   ,~   &h'FP   (VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 42)
(VARIABLE-VALUE-CELL FANCY.DRIBBLE.FILE . 37)
(NIL VARIABLE-VALUE-CELL FILE . 30)
DRIBBLEFILE
"No dribble file!"
ERROR
DRIBBLE
BOTH
OLD
((THAWED) . 0)
OPENFILE
IOFILE
GETEOFPTR
SETFILEPTR
"M(M.MSelect Buffer)*LISP-DRIBBLE*
E[FNE]
2,ER"
PRIN3
"@Y
0FSDVERSION
ZJ
-1FSPJATY
"
DOWN
(KT KNIL ENTER0)   p  h          p        
EMACS BINARY
         
    -.          
   Z   3B   +   ,<   "  ,~   Z   ,<  ,<  $  ,<  Z  D  ,<   "  ,~   #T  (VARIABLE-VALUE-CELL OLDBUFFER . 4)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 15)
CHECK.EMACS
DOWN
0
SETFILEPTR
"

"
PRIN3
(KNIL ENTERF)      8      
EMACS.?= BINARY
     ²    §    1-.            §@  ©  ,~   Z   ,<  Z   D  *Z   ,<  Z   D  ªXB   2B  ++   Z  ,<  Z  D  ªXB  B  «3B   +   %Z  ,<  B  ,-,   +   Z  B  ,,   +   !@  ¬  +   !Z  B  ,XB   Z   ,   XB` Z  -,   +   +   ,<` Z  ,<  [  2B   +   Z   +   Z  ­,   ,   D  .[  XB  +   Z` XB` Z` ,~   ,<  Z  ®,   D  /Z  ¯,   ,   +   &Z  0,   B  °Z   ,~   1)+P$4    (VARIABLE-VALUE-CELL EMACS.PT . 6)
(VARIABLE-VALUE-CELL EMACS.ZV . 8)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE . 17)
(VARIABLE-VALUE-CELL EMACS.READ.TABLE . 19)
(NIL VARIABLE-VALUE-CELL NAME . 37)
MAP.BYTES
RATOM
%(
GETD
ARGLIST
NIL
(NIL VARIABLE-VALUE-CELL ARGLIST . 60)
","
LCONC
"]"
NCONC
"["
"Not a function."
DISPLAY.IN.OTHER.WINDOW
(CONS21 CONSS1 CONSNL SKNLST KNIL ENTER0)   H   P     ¦ 0  X      p   x  (  H      
EMACS.EOF.ERROR BINARY
                -.           ,<  Z   ,<  ,<   &  ,~   @   (VARIABLE-VALUE-CELL FILE . 4)
"EOF Error for "
ERROR
(KT ENTERF)    @      
EMACS.EVAL.CURRENT.SEXPR BINARY
    &        ¤-.          ( Z   ,<  Z   D  ,<  Z   D  @    +   ,<  ,<   @     +   Z   ,<  Z   D  !,~   3B   +   3B   +   -,   +   ,<  ¡,<  ,   ,   ,   ,<  ,<   $  "XB   3B   +   Z  +   Z  ¢,<  Z  D  ,~   ,<  #,<  £,<   ,<   (  $,~   [hJ`K        (VARIABLE-VALUE-CELL EMACS.PT . 3)
(VARIABLE-VALUE-CELL EMACS.ZV . 5)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 44)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE . 18)
(VARIABLE-VALUE-CELL EMACS.READ.TABLE . 20)
MAP.BYTES
"0FO..QWindow 2 Size%"E
M(M.M^R Two Windows)'
%"#M(M.M^R Other Window)'
M(M.MSelect Buffer)*LISP-PRINT*
HK
GA 0J 10K
QWindow 2 Size-3%"N 3-QWindow 2 SizeM(M.M^R Grow Window)'
M(M.M^R Other Window)
M(M.M& Multi-Window Refresh)

"
PRIN3
(T VARIABLE-VALUE-CELL PLVLFILEFLG . 0)
(NIL VARIABLE-VALUE-CELL FORM . 40)
NLSETQ
LISPXEVAL
(T VARIABLE-VALUE-CELL NORMALCOMMENTSFLG . 0)
READ
QUOTE
ENVEVAL
"Can't evaluate this form"
DOWN1
((DOWN1 T) . 0)
RETEVAL
(ALIST2 LIST2 SKNNM KT KNIL ENTER0)         h   (        H      
EMACS.FIND.SEXP BINARY
                -.            @    ,~   Z   ,<  Z   D  Z   ,<  Z   D  ,<  Z   D  Z  -,   +   ,<  ,<  Z   ,<  ,   ,   ,~   ,<  ,<   ,<   &  ,~        (VARIABLE-VALUE-CELL EMACS.PT . 6)
(VARIABLE-VALUE-CELL EMACS.ZV . 8)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE . 10)
(VARIABLE-VALUE-CELL EMACS.READ.TABLE . 12)
(0 VARIABLE-VALUE-CELL OCCNTR . 22)
(T VARIABLE-VALUE-CELL NORMALCOMMENTSFLG . 0)
(NIL VARIABLE-VALUE-CELL #2 . 17)
MAP.BYTES
READ
FIND.SEXP
F
"Pat not found."
ERROR
(KT KNIL CONSNL LIST3 SKLST ENTER0) x   p   X   P          
EMACS.GETDEF BINARY
         n   -.           n@  ð   ,~   Z   2B   +   Z   XB  ,<  ò,<   $  sZ  ,<  ,<   $  ó+   -,   +   B  tZ  B  ô-,   +   Z  ,<  ,<  u$  õ3B   +   ,<  vZ  ,<  B  ö,   ,   B  w,<   "  ÷,~   Z  B  xZ  XB   3B   +   dZ   3B   +   dZ  ,<  ,<  ø$  õXB   3B   +   #Z  ,<  [  Z  [  Z  [  [  D  yXB   2B   +   9,<  ù,<   $  sZ  ,<  ,<  z$  õZ  [  ,<  ,<   $  ó,<   Z  ¤,<  ,<  z$  õZ  [  B  úB  {,<  ,<   ,<  û(  |Z  ©,<  ,<  ø$  õXB  3B   +   dZ  ,<  [  ±Z  [  Z  [  [  D  yXB  ¡3B   +   d,<  ü"  },<  @  ý  +   â,<  }Z   ,<  ,   ,   Z   ,   XB  ¾XB` ,<  ÿ,<  ,<   @  ` +   ÙZ   Z XB Z  ¯,<  ,<  z$  õZ  [  XB  E,<  ,<   $  ó[  ·Z  ,<  Z   D ,< Z  ËD [  J[  ,<  [  NZ  D ,<  Z  MD ,< Z  ÑD Z  H,<  Z  SD ,< Z  UD Zw}XB8 Z   ,~   2B   +   ÛZ  tXB   [` XB  ¿,<  }Z` Z  [  D Z  [3B   +   á  ,~   Z` ,~   ,<   "  ÷,~   Z  3B  öXB   3B   +   ë,<  vZ  d,<  ,<  ,   ,   B  w,<   "  ÷,~   ,< Z  gD  tZ   ,~   %TìDL@LLf V jF4	QPbL          (VARIABLE-VALUE-CELL NAME . 216)
(VARIABLE-VALUE-CELL LASTWORD . 14)
(VARIABLE-VALUE-CELL EMACS.FASTREADFLG . 48)
(VARIABLE-VALUE-CELL RESETVARSLST . 184)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 173)
(NIL VARIABLE-VALUE-CELL DEF . 202)
(NIL VARIABLE-VALUE-CELL FILE . 168)
(NIL VARIABLE-VALUE-CELL SPOT . 159)
(NIL VARIABLE-VALUE-CELL MAP . 104)
=
PRIN1
PRINT
ERROR
GETD
EXPR
GETP
DEFINEQ
GETDEF
DUMPX
DOWN
WHEREIS
FILEMAP
ASSOC
"Getting FILEMAP for "
FILEDATES
UNPACKFILENAME
PACKFILENAME
(((DECLARE: -- (FILEMAP --) --)) . 0)
LOADFNS
10
RADIX
(VARIABLE-VALUE-CELL OLDVALUE . 121)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 190)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
PRIN3
,
DIFFERENCE
"M(M.M& Getdef)"

APPLY
ERROR!
"No Definition Found.  "
(CF CONS CONSNL LIST2 ALIST2 SKNLST SKNLA KT KNIL ENTERF)   Ä    @    ?    é h      0   P   (   8 Ù 	  /  ¤      n 0 æ  Ú ( 9 0 * 0    H   H      
EMACS.P BINARY
      ·    '    6-.          8 'Z   ,<  Z   D  ª,<  +Z   D  «@  ,  +   $Z   ,<  ,<   $  ¬,<  @  -  ,~   ,<  ¬Z   ,<  ,   ,   Z   ,   XB  XB` ,<  /,<  ¯,<   @  0 ` +   Z   Z  ±XB @  2  +   Z   ,<  Z   D  ²,~   ,<  Z  D  «Zw}XB8 Z   ,~   2B   +   Z  3XB   [` XB  ,<  ¬Z` Z  [  D  ³Z  3B   +   #   4,~   Z` ,~   ,<  ´,<  5,<   ,<   (  µ,~   Z@*Ld    (VARIABLE-VALUE-CELL EMACS.PT . 3)
(VARIABLE-VALUE-CELL EMACS.ZV . 5)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 48)
(VARIABLE-VALUE-CELL EMACS.P.PRINT.LEVEL . 13)
(VARIABLE-VALUE-CELL RESETVARSLST . 59)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE . 42)
(VARIABLE-VALUE-CELL EMACS.READ.TABLE . 44)
MAP.BYTES
"0FO..QWindow 2 Size%"E
M(M.M^R Two Windows)'
%"#M(M.M^R Other Window)'
M(M.MSelect Buffer)*LISP-PRINT*
HK GA 0J
10K
QWindow 2 Size-3%"N 3-QWindow 2 SizeM(M.M^R Grow Window)'
M(M.M^R Other Window)
M(M.M& Multi-Window Refresh)

"
PRIN3
(T VARIABLE-VALUE-CELL PLVLFILEFLG . 0)
PRINTLEVEL
(VARIABLE-VALUE-CELL OLDVALUE . 22)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 65)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(T VARIABLE-VALUE-CELL NORMALCOMMENTSFLG . 0)
READ
ERROR
APPLY
ERROR!
DOWN1
((DOWN1 T) . 0)
RETEVAL
(KT CF CONS CONSNL LIST2 KNIL ENTER0)  0   0   h   X   P   h &            
EMACS.PP BINARY
       ¾    ,    ¼-.         ( ,Z   ,<  Z   D  /@  ¯  (
,~   Z   ,   ,   XB   ,<  2,<   ,<   @  ² ` +   Z   Z  4XB Z  ,<  Z   D  ´+    XB   2B   +   ,<  5Z   D  µ,<  6,<  ¶,<   ,<   (  7Z  ,   ,   ,<  Z  D  ·XB   Z  XB  ,<  8Z  D  ¸Z  B  9Z  ,<  Z   D  ¹Z  ,<  ,<   Z  F  :Z  ,   ,   XB   Z  ,<  ,<  º$  ;Z  ,<  Z  !D  µ,<  »Z  $D  µZ  ¥,<  Z   D  ;,<  6,<  <,<   ,<   (  7Z   ,~   @JB"Q49        (VARIABLE-VALUE-CELL HPOS . 60)
(VARIABLE-VALUE-CELL EMACS.PT . 3)
(VARIABLE-VALUE-CELL EMACS.ZV . 5)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE . 39)
(VARIABLE-VALUE-CELL EMACS.READ.TABLE . 25)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 77)
MAP.BYTES
(T VARIABLE-VALUE-CELL NORMALCOMMENSFLG . 0)
(NIL VARIABLE-VALUE-CELL START . 43)
(NIL VARIABLE-VALUE-CELL FORM . 57)
(NIL VARIABLE-VALUE-CELL TO.DELETE . 70)
(NIL VARIABLE-VALUE-CELL MAP.END . 79)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
READ
"FTREAD failed."
PRIN3
DOWN1
((DOWN1 T) . 0)
RETEVAL
DIFFERENCE
100
SPACES
TERPRI
POSITION
DUMPX1
0
SETFILEPTR
",(104,(FQA):GA)M(M.M& Prettyprint Undoably Replace)"
((DOWN1 T) . 0)
(CONSNL CF KNIL MKN FGFPTR ENTERF)          , 0 ª h  0       ! X       P        
EMACS.REPLACE.SEXP BINARY
               -.            Z   ,<  Z   D  @    ,~   @    +   	Z   ,<  Z   D  ,~   XB   ,<  ,<  ,<  ,   ,   ,<  ,<  ,<  Z  	,<  ,   ,<  ,<  ,   ,   ,~   J     (VARIABLE-VALUE-CELL EMACS.PT . 3)
(VARIABLE-VALUE-CELL EMACS.ZV . 5)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE . 13)
(VARIABLE-VALUE-CELL EMACS.READ.TABLE . 15)
MAP.BYTES
(NIL VARIABLE-VALUE-CELL TEMP . 27)
(T VARIABLE-VALUE-CELL NORMALCOMMENTSFLG . 0)
READ
ORR
:
((BI 1 -1) . 0)
1
((BO 1) . 0)
(ALIST3 LIST3 CONSNL LIST2 ENTER0)               @      
EMACS.RETURN BINARY
      µ    *    4-.           *@  ª  ,~       (Bw,   XB      A"ÿ,   XB   Z  0B  +      «Z  ,<  ,<   $  ,+   ¨0B  +      «Z  	,<  ,<  ¬$  ,+   ¨0B  +      «Z  ,<  ,<  -$  ,+   ¨0B  +   Z  B  ­+   ¨0B  +      .+   ¨0B  +      ®+   ¨0B  +   ,<  /,<   ,<   &  ¯+   ¨0B  +   !,<  0,<   $  °   1+   ¨0B  +   #   ±+   ¨0B  +   ¥   «   2,~   0B  +   (   «   ²,~      «,<  3"  ³,~    lvu]lmîg8   (VARIABLE-VALUE-CELL EMACS.FSEXIT.ARG . 10)
(NIL VARIABLE-VALUE-CELL ARG1 . 14)
(NIL VARIABLE-VALUE-CELL ARG2 . 41)
DUMP.LINES?
E!
DEFINEQ
QUOTE
EMACS.PP
EMACS.P
EMACS.?=
"
ERROR return from EMACS."
ERROR
"
RESET return from EMACS."
PRIN1
RESET
EMACS.EVAL.CURRENT.SEXPR
EMACS.FIND.SEXP
EMACS.REPLACE.SEXP
127
CHARACTER
(KT KNIL ASZ MKN ENTER0)        0   h $    0  p        p        
EMACS:.RETURN BINARY
       ¬        +-.           @     ,~       (Bw,   XB   0B  +       +   0B  +   	   !+   0B  +      ¡+   0B  +   ,<  ",<   ,<   &  ¢+   0B  +   ,<  #,<   $  £   $+   0B  +      ¤+   0B  +      %   ¥,~   0B  +      %   &,~   ,<  ¦,<   $  ',<  §"  (,<  ¨,<  ),<   ,<   (  ©,<  *"  ª,~   ;YÛ;N_      (VARIABLE-VALUE-CELL EMACS.FSEXIT.ARG . 6)
(NIL VARIABLE-VALUE-CELL ARG1 . 9)
EMACS.PP
EMACS.P
EMACS.?=
"
ERROR return from EMACS."
ERROR
"
RESET return from EMACS."
PRIN1
RESET
EMACS.EVAL.CURRENT.SEXPR
DUMP.LINES?
EMACS.FIND.SEXP
EMACS.REPLACE.SEXP
"In appropriate exit from EMACS.  Use C-T C-E if you want
to quit back to EDITE:.  Returning to EMACS"
PRINT
3000
DISMISS
DOWN1
((DOWN1) . 0)
RETEVAL
127
CHARACTER
(KT KNIL ASZ MKN ENTER0)  (  `   `  X   x  0  @ 
              
ENABLE.CONTROL.C.CAPABILITY BINARY
                -.           Z   2B   +   ^"   +   ,   ,>  ,>  ,>  ,>  ,<  ,<  $  2B   +   
^"   +   ,      ,^  /  ,^  /        ´+    +    +    ,   ,~          Uj      (VARIABLE-VALUE-CELL OURPROCESS . 3)
131072
0
,,
(MKN BHC IUNBOX KNIL ENTER0)        H   0     	  0      
EMACS.EXE.FILE BINARY
            -.            Z  6@   Z  2B  +   Z  ,~   Z  ,~   h   TENEX
TOPS20
<SUBSYS>EMACS.SAV
SYS:EMACS.EXE
(KL20FLG ENTER0)  0      
FIND.SEXP BINARY
            -.          Z   2B   +   Z   ,~   Z   2B  +       ."  ,   XB  Z   ,~   ,<  Z  D  3B   +      ."  ,   XB  Z  -,   +   Z   ,~   Z  ,<  Z  	D  2B   +   [  ,<  Z  D  2B   +   Z   ,~   @AE    (VARIABLE-VALUE-CELL SEXP . 37)
(VARIABLE-VALUE-CELL PAT . 39)
(VARIABLE-VALUE-CELL OCCNTR . 25)
EQUAL
FIND.SEXP
(SKNLST KT MKN KNIL ENTERF) h      P      X  x   @        
FLUSH.EMACS BINARY
    ì    Z    é-.          P ZZ   -,   +   Z   ,~   Z   ,<  Z   D  _2B   +   ^"   +   ,         Y   Ù   +    +    +    Z  ,<      (û,   D  _2B   +   ^"   +   ,         Y   Ù   +    +    +    Z   ,<  ,<  ß$  `3B   +   ¡Z  ,<     (û."  ,   D  _2B   +   ^"   +   ,         Y   Ù   +    +    +    Z  àZ 7@  7   Z  Z  -,   +   )Z  àZ 7@  7   Z  Z  B  aZ   XB  Z  áZ 7@  7   Z  3B  b+   ±Z   -,   +   ±B  â3B   +   ±Z  ­B  cZ  ãZ 7@  7   Z  3B  b+   9Z   -,   +   9B  â3B   +   9Z  5B  cZ  dZ 7@  7   Z  3B  b+   ÁZ   -,   +   ÁB  â3B   +   Á,<   ,<   ,<   &  ä,<  e,<   ,<   @  å ` +   IZ   Z  gXB Z   ,<  ,<  ç$  hZ   ,~   ,<  è,<   ,<   @  å ` +   QZ   Z  gXB Z  ,   ,<  Z  D  hZ   ,~   ,<  i,<   ,<   @  å ` +   ØZ   Z  gXB Z   ,   ,<  ,<  ç$  h+    ,~        ÿ& *`4&kk42ÑP$T     (VARIABLE-VALUE-CELL LASTEMACS . 83)
(VARIABLE-VALUE-CELL OURPROCESS . 48)
(VARIABLE-VALUE-CELL EMACS.MAP.BLK.PAGE . 10)
(VARIABLE-VALUE-CELL OUR.BLOCK.START . 155)
(VARIABLE-VALUE-CELL EMACS.BLK.SIZE . 158)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE . 97)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 112)
(VARIABLE-VALUE-CELL FANCY.DRIBBLE.FILE . 121)
(VARIABLE-VALUE-CELL EMACS.MAP.BLK . 140)
(VARIABLE-VALUE-CELL EMACS.AC.BLK.START . 171)
,,
2
EQP
LASTEMACS
KFORK
EMACS.MAP.FILE
NOBIND
OPENP
CLOSEF
EMACS.TEMP.FILE
FANCY.DRIBBLE.FILE
DRIBBLE
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
1
RELBLK
((DUMMY) . 0)
((DUMMY) . 0)
(CONSNL GUNBOX KT CF SKLA SKI KNOB MKN IUNBOX KNIL SKNLST ENTER0)      
p O    Q 	   
P M X   ` ¶ p   X   8 4 H ( @   8        	    S 
( K 	( Ã 0 Á  À x 8  * H      @    0      
GET.BYTE BINARY
             -.           ^"  ¿,>  ,>      ,>  ,>      &"  .Bx  ,^  /     ,>  ,>     &"     /"  $"  /"     ,^  /  (B  ABx  ,^  /  ,   ,~     @   (VARIABLE-VALUE-CELL N . 17)
(VARIABLE-VALUE-CELL FIRSTLOC . 6)
(MKN BHC ENTERF)       X        
INTER.DIRECTORYNAME BINARY
          
    -.            
Z  
6@   Z  2B  
+   ,<  ,<   ,<   $  ,<  ,<  &  ,~   ,<   ,<   $  ,~   eD  TENEX
TOPS20
<
DIRECTORYNAME
>
PACK*
(KNIL KL20FLG ENTER0)   	  `            
MAKE.QUOTE BINARY
             -.           [   -,   +   [  Z  -,   +   [  [  2B   +   Z  ,<  [  Z  3B   +   3B   +   -,   +   ,<  ,<  ,   D  3B   +   ,<  [  Z  D  ,~   Z  [  ,   ,~   Y²     (VARIABLE-VALUE-CELL X . 36)
QUOTE
EQUAL
'
PACK*
(CONS LIST2 SKNNM KT KNIL SKLA SKLST ENTERF)   8   `   @   0   p 
  p    P    0      
MAP.BYTES BINARY
    Å    ½    Ã-.           ½@  À  ,~       ,>  =,>         ,^  /  /  ."  ,   XB      ,>  =,>         ,^  /  2b  +      
,>  =,>        ,^  /  /  ,   XB   +   Z"   XB  Z   ,<  Z  D  ÁZ  XB  Z  ,<  Z  D  Á   ,>  =,>         ,^  /  3"  +   ¦   ,>  =,>      .Bx  ,^  /  ,   ,<     ,>  =,>     .Bx  ,^  /  ,   D  B+   ¸   ¡,>  =,>        ,^  /  2b  +   ­Z  ,<  Z  ¦D  B+   ¸Z  +,<  Z  (D  B   ®,>  =,>     #.Bx  ,^  /  ,   ,<     ,,>  =,>     1.Bx  ,^  /  ,   D  B,<  ÂZ  D  CZ  9,<  Z  D  ÁZ   ,~     @ A@P(D   (VARIABLE-VALUE-CELL START . 91)
(VARIABLE-VALUE-CELL END . 104)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE.EOF . 44)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE . 116)
(VARIABLE-VALUE-CELL EMACS.GPT . 95)
(VARIABLE-VALUE-CELL EMACS.EXTRAC . 107)
(NIL VARIABLE-VALUE-CELL PTR . 118)
(NIL VARIABLE-VALUE-CELL NCHARS . 43)
SETFILEPTR
MAP.BYTES1
1
SPACES
(KNIL ASZ MKN BHC ENTERF)  P   8    4 ` ¡       8 8 ª X ! H  H        
MAP.BYTES1 BINARY
     &        ¤-.          Z   B  !,<  @  ¡  ,~   Z   B  !XB`     ,>  ,>   `    ,^  /  3b  +   Z` ,~   Z   ,<  Z  ,<  Z   ,<  ,<  Z  B  !D  #3B   +      &" 
    ,   +   Z"   ,<  Z  ,<  Z  B  !D  #3B   +      &" 
    ,   +   Z  £J  $   ."  ,   XB  +     	       (VARIABLE-VALUE-CELL START . 35)
(VARIABLE-VALUE-CELL END . 49)
(VARIABLE-VALUE-CELL LASTEMACS . 23)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE.JFN . 27)
PAGE.OF.BYTE
(VARIABLE-VALUE-CELL I . 59)
NIL
NIL
EQP
2560
MAP.PROCESS.TO.FILE
(ASZ MKN KNIL BHC ENTERF)       0                
MAP.PROCESS.TO.FILE BINARY
    Á    ¹    ¿-.     (     ¹Z   ,<  Z   D  ½2B   +   ^"   +   ,         8   ¸   +    +    +    Z   ,<  Z   D  ½2B   +   ^"   +   ,   ,>  9,>  Z  ,<  Z  D  ½2B   +   ^"   +   ,      ,^  /  ,>  9,>  ,>  9,>  ,<  >,<  ¾$  ½2B   +   ^"   +   ,      ,^  /  ,^  /     +    +    +    Z   2B   +   "^"   +   ¢,   ,>  9,>  Z   ,   ,<  Z   D  ?2B   +   (^"   +   ¨,      ,^  /  ,>  9,>  ,>  9,>      ,>  9,>     %   ,^  /  /  ,   +   2^"   +   ²,      ,^  /  ,^  /     +    +    +    Z   ,~        ÿ  )@*Â!.P *
BH      (VARIABLE-VALUE-CELL PROCESS . 19)
(VARIABLE-VALUE-CELL PAGE . 21)
(VARIABLE-VALUE-CELL JFN . 63)
(VARIABLE-VALUE-CELL START.BYTE . 91)
(VARIABLE-VALUE-CELL END.BYTE . 88)
(VARIABLE-VALUE-CELL OURPROCESS . 30)
(VARIABLE-VALUE-CELL EMACS.MAP.BLK.PAGE . 32)
(VARIABLE-VALUE-CELL EMACS.MAP.BLK . 71)
,,
33024
0
BYTEPOINTER
(MKN BHC IUNBOX KNIL ENTERF)  %    µ H 0 (  P     3  # 8  h     8 p !   H        
PAGE.OF.BYTE BINARY
                -.           @    ,~       &"  ,   XB      &"     ,   XB   0B   +   
   ."  +      (Bû,   ,~      (VARIABLE-VALUE-CELL BYTE . 10)
(NIL VARIABLE-VALUE-CELL QUO . 20)
(NIL VARIABLE-VALUE-CELL REM . 14)
(ASZ MKN ENTERF)         x        
PAGEMODE BINARY
       #         "-.            @     ,~               £+    +    +       ,   XB   Z   3B   +   Z  2B  !+      G"  ,   +      ,>  ,>  ^"  F  ABx  ,^  /  ,   +   ^"   +   ,               Ç+    +    +    ^"  ,>  ,>     ABx  ,^  /  ,   0B  +   Z  !,~   Z  ¡,~               ÿ`E&  (VARIABLE-VALUE-CELL FLG . 19)
(NIL VARIABLE-VALUE-CELL JFNMODE . 49)
Y
N
(ASZ IUNBOX BHC KNIL MKN ENTERF) @   @   0                    
PPTI BINARY
    ­         ,-.          ,<  "Z   D  ¢Z  B  #,<  @  £  +   ,<  #Z   ,<  ,   ,   Z   ,   XB  XB` ,<  ¥,<  &,<   @  ¦ ` +   Z   Z  (XB @  ¨  +   Z  ©,<  Z   ,   D  *Z   ,~   Zw~XB8 Z   ,~   2B   +   Z  ªXB   [` XB  ,<  #Z` Z  [  D  *Z  3B   +      +,~   Z` ,~   ,<   "  «,~   V jV Da      (VARIABLE-VALUE-CELL LST . 35)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 6)
(VARIABLE-VALUE-CELL RESETVARSLST . 49)
"FSBCONS[..O
GA
0J 6K
M(M.MTI Print)
]..O
M(M.M^R Exit to LISP)
"
PRIN3
OUTPUT
(VARIABLE-VALUE-CELL OLDVALUE . 13)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 55)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(NIL VARIABLE-VALUE-CELL PRETTYTABFLG . 0)
(T VARIABLE-VALUE-CELL NORMALCOMMENTSFLG . 0)
PRETTYPRINT
APPLY
ERROR
ERROR!
DOWN
(KT CF KNIL CONS CONSNL LIST2 ENTERF)             p  H       0 	           
PUTSTRING BINARY
      5    -    ³-.           -@  .   +   «Z   XB   Z"  XB   Z  ,<  Z   B  0,   ."  ,   D  °3B   +   Z` ,~   Z"   XB   @  1  +   &Z"  XB`     ,>  ¬,>   `    ,^  /  3b  +   Z` ,~      (B  ,   XB     ,>  ¬,>  Z  ,<  Z  B  0D  °3B   +   ^"   +   Z  ,<  Z  D  ²B  3,   GBx  ,^  /  ,   XB     ."  ,   XB  ¡   ."  ,   XB  £+      ,<     !(B  ,\   B     &."  ,   XB  )+   Z  ,~     

 j  @  (VARIABLE-VALUE-CELL STR . 56)
(VARIABLE-VALUE-CELL ADDR . 87)
NIL
(NIL VARIABLE-VALUE-CELL LOC . 85)
(NIL VARIABLE-VALUE-CELL WORD . 78)
(NIL VARIABLE-VALUE-CELL CHAR . 70)
NCHARS
GREATERP
NIL
(1 VARIABLE-VALUE-CELL J . 74)
NIL
NTHCHAR
CHCON1
(BHC KNIL MKN IUNBOX ASZ ENTERF)            0 ¥ 8 ¡ ` 	         h   P      
READ.AC BINARY
              -.          Z   2B   +   ^"   +   ,   ,>  ,>  Z   2B   +   ^"   +   ,      ,^  /        ¸+    +    +       ,>  ,>      GBx  ,^  /     ,   ,~          Q!      (VARIABLE-VALUE-CELL ACN . 28)
(VARIABLE-VALUE-CELL PROCESS . 3)
(VARIABLE-VALUE-CELL EMACS.AC.BLK.START . 25)
(MKN BHC IUNBOX KNIL ENTERF)       (          0      
REFRESH BINARY
              -.            ^"  ¿,>  ,>              £+    +    +       (BóABx  ,^  /  /"  ,   B  ,<  "  ,~               `` DUMP.LINES
127
CHARACTER
(MKN BHC ENTER0)  (         
SET.EMACS.VARS BINARY
            -.                 ,   XB          ,   XB          ,   XB          ,   XB          ,   XB          ,   XB          ,   XB          ,   XB   ,<  Z   D  XB   ,~           (VARIABLE-VALUE-CELL EMACS.BEG.LOC . 3)
(VARIABLE-VALUE-CELL EMACS.BEG . 6)
(VARIABLE-VALUE-CELL EMACS.BEGV.LOC . 7)
(VARIABLE-VALUE-CELL EMACS.BEGV . 10)
(VARIABLE-VALUE-CELL EMACS.GPT.LOC . 11)
(VARIABLE-VALUE-CELL EMACS.GPT . 14)
(VARIABLE-VALUE-CELL EMACS.PT.LOC . 15)
(VARIABLE-VALUE-CELL EMACS.PT . 18)
(VARIABLE-VALUE-CELL EMACS.ZV.LOC . 19)
(VARIABLE-VALUE-CELL EMACS.ZV . 22)
(VARIABLE-VALUE-CELL EMACS.Z.LOC . 23)
(VARIABLE-VALUE-CELL EMACS.Z . 26)
(VARIABLE-VALUE-CELL EMACS.EXTRAC.LOC . 27)
(VARIABLE-VALUE-CELL EMACS.EXTRAC . 30)
(VARIABLE-VALUE-CELL EMACS.MODIFF.LOC . 31)
(VARIABLE-VALUE-CELL EMACS.MODIFF . 34)
(VARIABLE-VALUE-CELL LASTEMACS . 36)
(VARIABLE-VALUE-CELL EMACS.FSEXIT.ARG . 38)
3
READ.AC
(MKN ENTER0)   X     X        
SETUP.FANCY.DRIBBLE BINARY
      .    £    ¬-.           £@  %  ,~   ^"  ¿,>  ",>     ¢   ¢   #   £+    +    +       (BóABx  ,^  /  ,   XB   0B   +   Z"  XB     ¥3B   +   Z   ,   XB   +   !   &,<  Z  ¦6@   Z  '2B  ¦+   Z  §+   Z  (D  ¨B  )B  ©XB  B  *Z  B  ªZ  ,<  ,<   ,<   &  +Z  ,<  Z   ,<  D  «,   &" %@,   D  ,XB   Z   ,~               \ 	#_zB@     (VARIABLE-VALUE-CELL FANCY.DRIBBLE.FILE . 51)
(VARIABLE-VALUE-CELL TERMINAL.SPEED . 58)
(VARIABLE-VALUE-CELL NUMBER.OF.LINES . 65)
(NIL VARIABLE-VALUE-CELL REAL.NUMBER . 56)
DRIBBLEFILE
INTER.DIRECTORYNAME
TENEX
TOPS20
LISP.DRIBBLE;-1;TP770000
LISP.DRIBBLE.-1;T;P770000
PACK*
OUTFILE
OUTPUT
CLOSEF
IOFILE
DRIBBLE
TIMES
IMIN
(IUNBOX KT KL20FLG CONSNL KNIL ASZ MKN BHC ENTER0)       8   8         p   X       8   0      
START.EMACS BINARY
      i   ¶   â-.         ¶@ @  ,~   Z   XB   Z   B ÁXB   ,< B,< ÂF C,< Ã,< Ã,<   " DD Ä,<  Z  F CZ   3B   +     E  Å,<  Z F6@   Z Æ2B F+   Z G+   Z ÇD HB ÈB IXB   ,<  Z   D É,< JZ  D ÊZ  B KZ  ,<  ,< Ë,< L,<   ,< Ì* M  µ  µ  µ   ¿+    +    +    ,   B ÍB NXB   ,< Î" O,< J" Ï,   XB   Z F6@   Z Æ2B F+   *,< PZ   ,<  ,< Ð& QB Ñ+   -,< RZ  ',<  ,< Ò& QB SZ  £,   ,<  ,< J$ Ó  T,<  ,<   ,<   ,<   ,<   * ÔXB  Z   3B Î+   µB O,< J" Ï,   XB   ,< BZ  3D UXB      9(Bû,   ,<  Z  ¹,<  ,< Õ$ V,   (Bû,   D Ö3B   +   BZ"  XB   +   CZ"  XB  AB Ï,   XB   @ W   +   ØZ` -,   +   H+   ×Z  XB   Z  È,<  Z   ,<     D,> 6,>  ^" ÿ,> 6,>     »ABx  ,^  /  GBx  ,^  /  ,   D V   ,\  ,   [` XB`    J."  ,   XB  U+   FZ` ,~   Z  8,<     N(Bû,   D Y2B   +   Ý^"   +   ^,   ,> 6,>  Z   ,<     K(Bû,   D Y2B   +   d^"   +   ä,      ,^  /  ,> 6,>  ,> 6,>  ,< Ù,< Z$ Y2B   +   ë^"   +   l,      ,^  /  ,^  /     +    +    +    Z  Â,<  ,< B$ Ö3B   +  Z  Ø,<     Ù(Bû."  ,   D Y2B   +   y^"   +   ù,   ,> 6,>  Z  _,<     `(Bû."  ,   D Y2B   +   ^"   +  ,      ,^  /  ,> 6,>  ,> 6,>  ,< Ú,< Z$ Y2B   +  ^"   +  ,      ,^  /  ,^  /     +    +    +    Z  ó2B   +  ^"   +  ,   ,> 6,>  ,< JZ  ô,<  ,< [$ VD Y2B   +  ^"   +  ,      ,^  /    µ   B+    +    +      Å,<  Z F6@   Z Æ2B F+  Z Û+  Z \D HB ÈB IXB   B KZ  B ÜZ"   XB   Z ¡B ]XB   ,< J" ÏXB   (Bû,   XB   ,< ÝZ D UXB     ^,<   " Þ,<   " ÞZ £,<  ,< _,< ß,< `,< à* aZ  ,<  ,< _,< ß,< `,< à* aZ   B áZ b,~          lNßqToA^^>8p§JE© H  *
u @U(+T '(!/}EBU`              (VARIABLE-VALUE-CELL #RPARS . 7)
(VARIABLE-VALUE-CELL FILERDTBL . 8)
(VARIABLE-VALUE-CELL EMACS.READ.TABLE . 20)
(VARIABLE-VALUE-CELL LASTEMACS . 337)
(VARIABLE-VALUE-CELL EMACS.TEMP.FILE . 352)
(VARIABLE-VALUE-CELL MAX.EMACS.INPUT . 41)
(VARIABLE-VALUE-CELL INTER.DIRECTORY . 85)
(VARIABLE-VALUE-CELL EMACS.AC.BLK.START . 110)
(VARIABLE-VALUE-CELL EMACS.BUFFER.BLOCK . 290)
(VARIABLE-VALUE-CELL EMACS.BLK.SIZE . 225)
(VARIABLE-VALUE-CELL OUR.BLOCK.START . 247)
(VARIABLE-VALUE-CELL OURPROCESS . 245)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE . 345)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE.EOF . 326)
(VARIABLE-VALUE-CELL EMACS.MAP.FILE.JFN . 329)
(VARIABLE-VALUE-CELL EMACS.MAP.BLK . 332)
(VARIABLE-VALUE-CELL EMACS.MAP.BLK.PAGE . 335)
(VARIABLE-VALUE-CELL TERMINAL.SPEED . 339)
(VARIABLE-VALUE-CELL EMACS.INIT.HOOK . 359)
(NIL VARIABLE-VALUE-CELL NAME . 103)
(NIL VARIABLE-VALUE-CELL RSCAN.BLK . 90)
(T VARIABLE-VALUE-CELL SUBSYSRESCANFLG . 0)
COPYREADTABLE
2
((MACRO FIRST (LAMBDA (FL RDTBL) (SETQ #2 (READ FL RDTBL)))) . 0)
SETSYNTAX
'
GETREADTABLE
GETSYNTAX
FLUSH.EMACS
INTER.DIRECTORYNAME
TENEX
TOPS20
EMACS.TEMP;-1;TP770000
EMACS.TEMP.-1;T;P770000
PACK*
OUTFILE
OUTPUT
SETFILEPTR
1
SPACES
CLOSEF
BOTH
OLD
((THAWED) . 0)
OPENFILE
SIXBIT
MKATOM
LISP
SETNM
GETBLK
"M(M.MLOAD LIB)<"
">INTERWFSOSPEEDFSEXIT"
CONCAT
BKSYSBUF
"EMACS M(M.MLoad Lib)<"
">INTERWFSOSPEEDFSEXIT"
WRITE.RSCAN
RELBLK
EMACS.EXE.FILE
SUBSYS2
READ.AC
9
PLUS
EQP
((EMACS.BEG.LOC EMACS.BEGV.LOC EMACS.PT.LOC EMACS.GPT.LOC EMACS.ZV.LOC 
EMACS.Z.LOC EMACS.EXTRAC.LOC EMACS.RESTART.LOC EMACS.ARG.LOC EMACS.MODIFF.LOC) .
 0)
NIL
(NIL VARIABLE-VALUE-CELL VAR . 146)
(0 VARIABLE-VALUE-CELL I . 173)
,,
53248
0
53248
7
EMACS.MAP;-1;TP770000
EMACS.MAP.-1;T;P770000
IOFILE
OPNJFN
3
SETUP.FANCY.DRIBBLE
TERPRI
CLOSEALL
NO
EOF
EMACS.EOF.ERROR
WHENCLOSE
EVAL
Continue
(SET BHC SKNLST ASZ IUNBOX GUNBOX MKN KL20FLG KT KNIL ENTER0) 
H       p n h R 
   x   8 C    h    ì P Þ h   h     ~ p b 8 W 
( Ä x » x $     H ¥ x   H«    H h    ó ( c H À 0 ²   ± 0   @      
STIW BINARY
            -.                       ½+    +    +       ,   ,<  Z   3B   +   Z  2B   +   ^"   +   ,               >+    +    +    ,\  ,~        ý % (VARIABLE-VALUE-CELL W . 16)
(IUNBOX KNIL MKN ENTERF)  8               
SUBSYS1 BINARY
        Ø    F    V-.     (     F@  I  ,~   Z   -,   +      JZ  XB   ,<   "  ÊXB   +   Z  XB  [  Z  XB  ,<  K"  Ë,<  @  L  ,~   ,<  ËZ   ,<  ,   ,   Z   ,   XB  XB` ,<  N,<  Î,<   @  O ` +   <Z   Z  ÐXB Z  
B  Ê,<  @  Q  +   :,<  ÊZ  ,<  ,   ,   Z  ,   XB  XB` ,<  S,<  Î,<   @  O ` +   1Z   Z  ÐXB Z   3B   +   ¤   ÓZ  ,<  Z   ,<  Z   ,<  Z   H  T,<  ^"  F  E,>  Å,>  ,<   "  Ê,   ABx  ,^  /  ,   ,   Zw{XB8 Z   ,~   2B   +   3Z  ÔXB   [` XB  ,<  ÊZ` Z  [  D  UZ  ²3B   +   9   Õ,~   Z` ,~   Zw}XB8 Z   ,~   2B   +   >Z  ÔXB  ¶[` XB  ³,<  ËZ` Z  [  D  UZ  ½3B   +   D   Õ,~   Z` ,~   ÿ  1 i jJ`¨@& DLD&      (VARIABLE-VALUE-CELL TWO . 18)
(VARIABLE-VALUE-CELL INCOMFILE . 75)
(VARIABLE-VALUE-CELL OUTCOMFILE . 77)
(VARIABLE-VALUE-CELL ENTRYPOINTFLG . 79)
(VARIABLE-VALUE-CELL BINARYMODE . 69)
(VARIABLE-VALUE-CELL RESETVARSLST . 125)
(NIL VARIABLE-VALUE-CELL FORK . 73)
(NIL VARIABLE-VALUE-CELL TIW . 45)
ENABLE.CONTROL.C.CAPABILITY
STIW
N
PAGEMODE
(VARIABLE-VALUE-CELL OLDVALUE . 52)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 131)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(VARIABLE-VALUE-CELL OLDVALUE . 0)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 0)
((DUMMY) . 0)
BINARYMODE
SUBSYS0
ERROR
APPLY
ERROR!
(KT ALIST2 MKN BHC IUNBOX CF CONS CONSNL LIST2 KNIL SKLA ENTERF)   <    x   p   h   P             H          0 =   2 @ $     p    H      
SUBSYS2 BINARY
      $        #-.     (      @  !  ,~   Z   ,<  Z   ,<  Z   ,<  Z   ,<  Z   J  ¡XB      ,>  ,>  Z  2B   +   ^"   +   ,            ®+    +    +       ABx  ,^  /  1B   +               <+    +    +    ,<  ""  ¢Z  
,<  ,<   ,<   ,<   ,<   *  ¡XB  +   Z  ,~                ,+ <
  (VARIABLE-VALUE-CELL THREE . 6)
(VARIABLE-VALUE-CELL INCOMFILE . 8)
(VARIABLE-VALUE-CELL OUTCOMFILE . 10)
(VARIABLE-VALUE-CELL ENTRYPOINTFLG . 12)
(VARIABLE-VALUE-CELL BINARYMODE . 14)
(NIL VARIABLE-VALUE-CELL FORKTHREE . 56)
SUBSYS1
1000
DISMISS
(KT BHC IUNBOX KNIL ENTERF)   0   (   X   (          
WRITE.RSCAN BINARY
            -.          Z   ,<  Z   D     (B  	,>  ,>     GBx  ,^  /  ,   +   ^"   +   
,            +    +    +    ,   ,~     A`       P@ (VARIABLE-VALUE-CELL STR . 3)
(VARIABLE-VALUE-CELL RSCAN.BLK . 11)
PUTSTRING
(IUNBOX MKN BHC ENTERF)   (   `            
(PRETTYCOMPRINT INTERCOMS)
(RPAQQ INTERCOMS ((* This is the LISP part of an interface between EMACS and 
INTERLISP. The EMACS part is contained in a :EJ file called INTER. The two main 
entries are START.EMACS and DOWN. Documentation for the interface exits.) (FNS *
 INTERFNS) (VARS * INTERVARS) (P (PUTD (QUOTE SUBSYS0) (VIRGINFN (QUOTE SUBSYS))
)) (USERMACROS * INTERUSERMACROS) (P (/NCONC AFTERSYSOUTFORMS (QUOTE ((
FLUSH.EMACS))))) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (
ADDVARS (NLAMA PPTI) (NLAML) (LAMA)))))
(RPAQQ INTERFNS (,, BINARYMODE BYTEPOINTER CF CFNS CHECK.EMACS CP CREC CV 
DISPLAY.IN.OTHER.WINDOW DOWN DOWN1 DUMP.LINES DUMP.LINES? DUMPX DUMPX1 E! E. E.1
 EDIT.DRIBBLE.FILE EMACS EMACS.?= EMACS.EOF.ERROR EMACS.EVAL.CURRENT.SEXPR 
EMACS.FIND.SEXP EMACS.GETDEF EMACS.P EMACS.PP EMACS.REPLACE.SEXP EMACS.RETURN 
EMACS:.RETURN ENABLE.CONTROL.C.CAPABILITY EMACS.EXE.FILE FIND.SEXP FLUSH.EMACS 
GET.BYTE INTER.DIRECTORYNAME MAKE.QUOTE MAP.BYTES MAP.BYTES1 MAP.PROCESS.TO.FILE
 PAGE.OF.BYTE PAGEMODE PPTI PUTSTRING READ.AC REFRESH SET.EMACS.VARS 
SETUP.FANCY.DRIBBLE START.EMACS STIW SUBSYS1 SUBSYS2 WRITE.RSCAN))
(RPAQQ INTERVARS (INTER.DIRECTORY EMACS.FASTREADFLG EMACS.P.PRINT.LEVEL 
OURPROCESS MAX.EMACS.INPUT (LASTEMACS NIL) (EMACS.RETURN.CASES (QUOTE 
EMACS.RETURN)) (EMACS.ENTRY.HOOK NIL) (EMACS.EXIT.HOOK NIL) (EMACS.INIT.HOOK NIL
)))
(RPAQQ INTER.DIRECTORY EMACS)
(RPAQQ EMACS.FASTREADFLG T)
(RPAQQ EMACS.P.PRINT.LEVEL (2 . 7))
(RPAQQ OURPROCESS 131072)
(RPAQQ MAX.EMACS.INPUT 896000)
(RPAQ LASTEMACS NIL)
(RPAQQ EMACS.RETURN.CASES EMACS.RETURN)
(RPAQ EMACS.ENTRY.HOOK NIL)
(RPAQ EMACS.EXIT.HOOK NIL)
(RPAQ EMACS.INIT.HOOK NIL)
(PUTD (QUOTE SUBSYS0) (VIRGINFN (QUOTE SUBSYS)))
(RPAQQ INTERUSERMACROS (EMACS:))
(ADDTOVAR EDITMACROS (EMACS: NIL (COMS (CONS (QUOTE COMSQ) (PROG ((
EMACS.RETURN.CASES (QUOTE EMACS:.RETURN))) (DUMPX (##)) (RETURN (CAR (NLSETQ (
DOWN)))))))))
(/NCONC AFTERSYSOUTFORMS (QUOTE ((FLUSH.EMACS))))
NIL
    