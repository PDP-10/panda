(FILECREATED "30-Dec-83 01:34:00" ("compiled on " <NEWLISP>CODEFORMAT..147) (2 . 2) bcompl'd in WORK 
dated "30-Dec-83 01:23:53")
(FILECREATED "22-FEB-82 16:17:05" <NEWLISP>CODEFORMAT.;1 35739 changes to: CHANGENAME1 RELINK2 CALLS2 
previous date: "21-FEB-80 10:56:11" <LISP>CODEFORMAT.;17)
(MAPC (QUOTE (LAPRD BINRD FNTYP ARGLIST1 LINKBLOCK)) (FUNCTION (LAMBDA (FN) (OR (FMEMB FN NOSWAPFNS) (
SETQ NOSWAPFNS (CONS FN NOSWAPFNS))))))

LAPRD BINARY
                -.          ,<   ,<      2B  +   ,<   Z   D  XBw2B  +   	,<`  ,<   F  +    ,<   ,<  $  XBp  3B   +   Zp  ,<   ,<`  ,<   ,<w~ "  ,   +    ,<  ,<`  $  Z   +    K     (FN . 1)
(VARIABLE-VALUE-CELL FILERDTBL . 9)
PEEKC
% 
READ
BINARY
BINRD
CODEREADER
GETP
"Bad compiled function"
ERROR
(EVCC URET2 KNIL ENTER1)       0     (  @   P   (      

DOLINK BINARY
     `    U    ]-.     (     U,<   ,<   ,<   Z"   XBp  Z` 3B   +   Z` ."   Z  2B   +   ,<  X,<  Y,<  Y,<`  ,<` ,<` ,   ,   XBw "   XBw+   Z` ."   Z  XBwZ` ."   [  ({A" ,   XBw,<   ^"  X,   ,\  2B  +    "   +   Z` ."   [  A" p,   XBp   "   ,>  U,>    w.Bx  ,^   /      XBwZ` ,   XB` Z` ."   Z  2B   +   ,Z` 3B   +   ,Z   2B   +   ,,<  Z,<   $  Z,<` ,<   $  Z,<  [,<   $  Z,<` ,<   $  [Z` ,<   Z`  ,<   Z` ,<   ,   ,\  2B  +   7Zw,<   Z`  ,<   Z` /"   ,<   ,   ,\  2B  +   7+   TZ` 3B   +   FZ`  ,<   Z` ,<   Z` (B  	,>  U,>   Zw~.Bx  ,^   /   ,   Z`  ,<   Z` /"   ,<    w(B  	,>  U,>   Zw~.Bx  ,^   /   ,   +   T,<`  Z` ,   ,<   ,<` &  \,<`  Z` ,   ,<   ,<w~&  \,<`  Z` /"   ,   ,<   ,<w~&  \,<`  Z` /"   ,   ,<   Zw,   F  \Z   +       <  ( M  d         (BLKFN . 1)
(REL . 1)
(NM . 1)
(FN . 1)
(NOUNDOFLG . 1)
(VARIABLE-VALUE-CELL NOLINKMESS . 73)
LAMBDA
NOLINKARGS
NOLINKDEF1
******
LISPXPRIN1
" not defined when link tried from "
LISPXPRINT
/FNCLOSERD
/FNCLOSERA
(URET3 FFNCLR FFNOPA FFNOPD KT GUNBOX BHC POPTAB CCALC MKN EXCALQ ALIST3 LIST4 ASZ KNIL ENTER5)   U    F x   X       @ *  '    T    ` ? h   8   x   
( O 	8 H (  8   X   H   @    @   
P 8 ` $ 0   X   0        

BINRD BINARY
             -.         Z` 2B   +     B ,   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<` " Zw|     +    Zw|      ,   XBw|Zw|      ,   XBw}Zw|      ,   XBw},<w|,<w|$ XBw~."  XBw~Zw},   4b  ,> ,>   Zw|Zw~Q$I ,^  /   "      w|,> ,>   ,<w}" ,   .Bx  ,^   /   4b  *,> ,>   Zw|,<   Zw~,> ,>    w}.Bx  ,^   /       ,\   Q$I ,^  /   "     ,<w~^"  ,> ,>    w}.Bx  ,^   /   ,\  QB  ,<w~Zw~,   D Zw|     +    Zw~,> ,>    w}.Bx  ,^   /   ,<   Zw~,> ,>    w}.Bx  ,^   /   ,<   ,<   Zw,> ,>   Zw    ,^   /   3b  +   m,<` Z   D XBp  -,   +   iZp  2B +   M,<w,< [w,<   ,<`  ,<   * Z`  Z   ,   2B   +   kZ`  Z  I,   XB  K+   kZp  2B +   Q,<w},<w~,<w& +   k[p  -,   +   b[p  Z  2B +   b[p  [  3B   +   b,<w},<w~[wF ZwZwQD  ,<wZw-,   +   `ZwZ  2B +   `Zw[  ,   +   aZw,\  XB  +   kZwZp  XD  ,<w[w0B   +   g^"   +   g[w,\  QB  +   kZw,<   Zw,\   B  Zw."   XBw+   </  ,<` Z  AD XBwZw|     +    Zw2B   +   t+  Zw,<   ,< $ XBw2B   +   y,< Zw~D  wA"XBwZw~,> ,>   Zw|      .Bx  ,^   /   XBp  Zw~2B  +  [wXBw+   r,<      ,> ,>   Zw.Bx  ,^   /   ,\  XB  +   zZw|     +    ,<`  ,<w~$ Z   /  ,~                  	@@  $@  DhBL"b f4$B      (FN . 1)
(FILE . 1)
(VARIABLE-VALUE-CELL FILERDTBL . 221)
(VARIABLE-VALUE-CELL LINKEDFNS . 153)
INPUT
OPNJFN
READC
ARRAY
MINUS
RELOC
READ
LINKED-FN-CALL
0
DOLINK
VARIABLE-VALUE-CELL
DOVARLINK
UNBOXED-NUM
COREVAL
GETP
"No COREVAL"
ERROR
DEFC
(ASZ CONS FMEMB KT SKLST IUNBOX BHC MKN GUNBOX KNIL ENTER2)  f    M    J    H    \ 
0 C         p  h @ 8 7 p * x ! @          `       x s 
p K H 	       p   `        

DOVARLINK BINARY
            -.           [` [  ,   ,<   Z` ,<   [` Z  B  XB` ,\   B  Zp  2B  +   
Z   +    Z`  ,>  ,>   Zp  .Bx  ,^   /   XB` Z  XBp  Z` Z` XD  +           @     (ENTRY . 1)
(SLOC . 1)
(LIT . 1)
AT2VC
(BHC URET1 KNIL GUNBOX ENTER3)   `   (        8      

BINRD BINARY
     $       -.         Z` 2B   +     b ,   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<`  Zw|     +    Zw|      ,   XBw|Zw|      ,   XBw}Zw|      ,   XBw},<w|,<w| XBw~."  XBw~Zw},   4b  ,> ,>   Zw|Zw~Q$I ,^  /   "      w|,> ,>   ,<w} ,   .Bx  ,^   /   4b  *,> ,>   Zw|,<   Zw~,> ,>    w}.Bx  ,^   /       ,\   Q$I ,^  /   "     ,<w~^"  ,> ,>    w}.Bx  ,^   /   ,\  QB  ,<w~Zw~,   d Zw|     +    Zw~,> ,>    w}.Bx  ,^   /   ,<   Zw~,> ,>    w}.Bx  ,^   /   ,<   ,<   Zw,> ,>   Zw    ,^   /   3b  +   m,<` Z   d XBp  -,   +   iZp  2B +   M,<w,< [w,<   ,<`  ,<   
 Z`  Z   ,   2B   +   kZ`  Z  I,   XB  K+   kZp  2B +   Q,<w},<w~,<w +   k[p  -,   +   b[p  Z  2B +   b[p  [  3B   +   b,<w},<w~[wf ZwZwQD  ,<wZw-,   +   `ZwZ  2B +   `Zw[  ,   +   aZw,\  XB  +   kZwZp  XD  ,<w[w0B   +   g^"   +   g[w,\  QB  +   kZw,<   Zw,\   B  Zw."   XBw+   </  ,<` Z  Ad XBwZw|     +    Zw2B   +   t+  Zw,<   ,<  XBw2B   +   y,< Zw~d  wA"XBwZw~,> ,>   Zw|      .Bx  ,^   /   XBp  Zw~2B  +  [wXBw+   r,<      ,> ,>   Zw.Bx  ,^   /   ,\  XB  +   zZw|     +    ,<`  ,<w~ Z   /  ,~                  	@@  $@  DhBL"b f4$B      (FN . 1)
(FILE . 1)
(VARIABLE-VALUE-CELL FILERDTBL . 221)
(VARIABLE-VALUE-CELL LINKEDFNS . 153)
(NIL)
(LINKED-FN-CALL . INPUT)
(NIL)
(LINKED-FN-CALL . OPNJFN)
(NIL)
(LINKED-FN-CALL . READC)
(NIL)
(LINKED-FN-CALL . ARRAY)
(NIL)
(LINKED-FN-CALL . MINUS)
(NIL)
(LINKED-FN-CALL . RELOC)
(NIL)
(LINKED-FN-CALL . READ)
LINKED-FN-CALL
0
(NIL)
(LINKED-FN-CALL . DOLINK)
VARIABLE-VALUE-CELL
(NIL)
(LINKED-FN-CALL . DOVARLINK)
UNBOXED-NUM
COREVAL
(NIL)
(LINKED-FN-CALL . GETP)
"No COREVAL"
(NIL)
(LINKED-FN-CALL . ERROR)
(NIL)
(LINKED-FN-CALL . DEFC)
(ASZ CONS FMEMB KT SKLST IUNBOX BHC MKN GUNBOX KNIL ENTER2)  `   	P   	(   	   H S 8       P x n   ; x /   '      1 8  h      P   H w 8 W 	0 <  	    x   h   0      

CGETD BINARY
              -.           Z`  -,   +   b  ,~   ,~       (X . 1)
(NIL)
(LINKED-FN-CALL . GETD)
(SKLA ENTER1)   0      

FNTYP BINARY
      E    8    C-.           8,<`    93B   +   Z`  -,   +   b  :+   Z`  ,   (~,   0B   +   
Z  ;,~   0B   +   Z  ;,~   0B  +   Z  <,~   0B  +   Z  <,~   Z   ,~   Z`  -,   +   ."   Z  XB`  Z`  (B{Z  A"  ."   1B   +   0B  +   $Z`  ,<   ^"   ,<   ,   ,   0B   +   Z  =,~   0B   +   Z  =,~   0B  +   !Z  >,~   0B  +   #Z  >,~   Z   ,~   0B  +   7Z`  2B  ?+   (Z  ?,~   2B  ?+   /[`  Z  3B   +   .[`  Z  -,   +   .Z  @,~   Z  @,~   2B  A+   6[`  Z  3B   +   5[`  Z  -,   +   5Z  A,~   Z  B,~   ,<`    B,~   Z   ,~   f0@
Lf11     (FN . 1)
(NIL)
(LINKED-FN-CALL . SUBRP)
(NIL)
(LINKED-FN-CALL . ARGTYPE)
SUBR
FSUBR
SUBR*
FSUBR*
CEXPR
CFEXPR
CEXPR*
CFEXPR*
FUNARG
LAMBDA
EXPR*
EXPR
NLAMBDA
FEXPR*
FEXPR
(NIL)
(LINKED-FN-CALL . FNTYP1)
(SKNLST FFNOPA TYPTAB ASZ MKN IUNBOX SKLA KNIL ENTER1)  @ -            % (   h    p  P     @           P    2 0 $         

ARGLIST BINARY
      n    Z    k-.          Z,<   ,<`    [3B   +   ,<`    \1B   +   0B   +   ,<`    ]0B   +   
Z  ^+    0B  +   Z  ^+    0B  +   Z  _+    0B  +   Z  _+    0B  +   Z  `+    0B  +   Z  `+    Z   +    Z  a+    Z`  -,   +   ."   Z  2B   +   ,<`  ,<  a  b+   XBp  -,   +   )Zp  3B  c+   2B  c+   ![p  Z  +    2B  d+   $[p  Z  XB`  /   +   Zp  ,<   Z   d  d3B   +   Q[p  Z  +    b  e3B   +   Q,<   ,<   ,<   Zw~,<   ^"   ,<   ,   ,   XBwZw~,<   ^"  ,<   ,   ,>  Y,>   ,<w~  f3B   +   6^"  +   6Zw~    ,^   /   /  ,   XBwZw0B   +   FZw~,<   ^"   ,<   ,   ,   1B  +   @0B  +   AZp  +   P1B   +   C0B   +   DZp  +   P,<  g,<`    h+   PZw~,<    w,>  Y,>    w~/"   ,   XBw~,   .Bx  ,^   /   ,<   ,   b  iZp  ,   XBp  +   9/  +    ,<`  ,<     jXBp  3B   +   WZ`  3B  +   WXB`  /   +   ,<  k,<`    hZ   +       U,f31\^E
  J 
UX !4     (FN . 1)
(VARIABLE-VALUE-CELL LAMBDASPLST . 75)
(NIL)
(LINKED-FN-CALL . SUBRP)
(NIL)
(LINKED-FN-CALL . ARGTYPE)
(NIL)
(LINKED-FN-CALL . NARGS)
((U) . 0)
((U V) . 0)
((U V W) . 0)
((U V W FN) . 0)
((U V W FN Y) . 0)
((U V W FN Y Z) . 0)
U
EXPR
(NIL)
(LINKED-FN-CALL . GETP)
LAMBDA
NLAMBDA
FUNARG
(NIL)
(LINKED-FN-CALL . MEMB)
(NIL)
(LINKED-FN-CALL . CCODEP)
(NIL)
(LINKED-FN-CALL . SWPARRAYP)
"Args not available:"
(NIL)
(LINKED-FN-CALL . ERROR)
(NIL)
(LINKED-FN-CALL . VCTOAT)
(NIL)
(LINKED-FN-CALL . FNCHECK)
"Args not available:"
(KT CONS IUNBOX FFNOPA MKN FFNOPD BHC SKLST SKLA URET1 ASZ KNIL ENTER1)   
(   	x   	8   	` > (   	( >  /    /    W 
 M  $            Z 
 )   X  (  h  (   0 B   ? 0    P     `    T P , @ + ( '    @        

NARGS BINARY
        /    )    --.           ),<`    *3B   +   	Z`  -,   +   ."   [  (}+   Z`  ,   A"  ,   ,~   ,<`  Zp  -,   +   b  ++   /   XB`  (B{Z  A"  ."   0B   +   Z`  ."   [  ,   ,~   0B  +   Z`  ,<   ^"   ,<   ,   ,   ,~   0B  +   (Z`  3B  ,+   2B  ,+   $[`  Z  XB`  2B   +   Z"   ,~   -,   +    Z"   ,~   Z`  g  [  2B   9  !   ,   ,~   2B  -+   '[`  Z  XB`  +   Z   ,~   Z   ,~    8x"1    (FN . 1)
(NIL)
(LINKED-FN-CALL . SUBRP)
(NIL)
(LINKED-FN-CALL . GETD)
LAMBDA
NLAMBDA
FUNARG
(SKNLST FFNOPD ASZ TYPTAB BHC MKN IUNBOX SKLA KNIL ENTER1)   x   p                    $ x        8     )  # X        

BINSKIP BINARY
     *      %-.     (    Z` 2B   +     b ,   ,<   Z` 3B   +   
Z` 2B   +     b ,   +   
Z   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<`  Zw|     +    Zw|      ,   XBw}Zw|      ,   XBw~Zw|      ,   XBw~Z` 3B   +   <,<`  ,<` Z   f ,< ,<`  ,<` ,<` Z  f Zw}     +    Zw},<   Zw},       ,\      Zw},<   Zw},       ,\      Zw},<   Zw~,       ,\       w~,> ,>    w},> ,>    w~    ,^   /   /  .Bx  ,^   /   4b  :,> ,>   Zw},<   Zw|          ,\      >`x  5   4/  Zw}     +    +   IZw|,<   Zw|   S$   ,> ,>    w}.Bx   w},> ,>    w~    ,^   /   /  .Bx  ,^   /       ,\      +    Zw|     +    Z` 3B   +   e w~,> ,>    w~    ,^   /   /  4b  W,> ,>   ,<` Z  d  ,<   ,<` Z  Rf >`x  5   R/  ,<` ,<   Z  Tf  XBw3B   +   ],<   ,<` Z  Xf +   ^,< !,<`  "Zwg  [  2B   9  _   ,   XBwZw}     +    +   v w~,> ,>    w~    ,^   /   /  4b  m,> ,>   ,<`  #>`x  5   j/  Z"   XBwZw|      1B  +   q+   n,<` ,<   Z  [f  3B   +   v w."   ,   XBw+   qZw|     +     "   XBp  Zw0B   +   {+  Z` 3B   +  Zw},<   Zw,<   Zw{      ,\   B      ,\      Zp     1b   +  +   {Zw|      1b   +  +   {[wXBw w/"   ,   XBw+   yZw|     +    Z` 3B   +  Zw}     +    ,<`  $Z   /  ,~                  	B: (  #"@  	  ("BG!P@1! 2 C!D         (FN . 1)
(FLG . 1)
(FILE1 . 1)
(FILE2 . 1)
(TAG . 1)
(VARIABLE-VALUE-CELL FILERDTBL . 228)
(NIL)
(LINKED-FN-CALL . INPUT)
(NIL)
(LINKED-FN-CALL . OPNJFN)
(NIL)
(LINKED-FN-CALL . OUTPUT)
(NIL)
(LINKED-FN-CALL . READC)
(NIL)
(LINKED-FN-CALL . PRIN2)
1
(NIL)
(LINKED-FN-CALL . SPACES)
(NIL)
(LINKED-FN-CALL . PRINT)
(NIL)
(LINKED-FN-CALL . READ)
%(%)
(NIL)
(LINKED-FN-CALL . PRIN1)
(NIL)
(LINKED-FN-CALL . SKREAD)
(NIL)
(LINKED-FN-CALL . TERPRI)
(UUARG3 ASZ BHC MKN GUNBOX KNIL ENTER5)  y    { `   @ m  W 
 G X : 8 1    ` b   8   0 ' @ 
  P   8 P t ( a ( X 	H  h  X  H  0   h        

BINFIX BINARY
      ,      '-.         Z` 2B   +     b ,   ,<   Z` 2B   +     b ,   ,<   ,< ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<`  ,<` Z   f ,< ,<`  ,< ,<` Z  f Zw|     +    Zw|,<   ,<` Z  d  XBw|,       ,\      Zw|,<   ,<` Z  d  XBw},       ,\      Zw|,<   ,<` Z  d  XBw},       ,\      ,<` Z  d !Zw|,<   Zw{ &     J"$      +           ,\      Zw{      ,   XBw~0B  +   .+   *0B  +   @,<` Z  #d !XBw~Zw~Zw7   [  Z  Z  1H  +   62D   +   3XBp  3B   +   ;,<   Zw|[w,   ,\  QB  +   >,<w~,<w|,   Zw,   XBw,<`  "+   C1B  +   C0B  +   B+   C  # w|."   ,   XBw| w},> ,>    w|    ,^   /   3b  +   J+   $ w~,> ,>    w|    ,^   /   3b  +   T,<` Z  0d  Zw,   XBw w|."   ,   XBw|+   J w},> ,>    w|    ,^   /   3b  +   _Zw|,<   ,<` Z  Od  ,       ,\       w|."   ,   XBw|+   TZw|     +    ,<w #,<   Zp  -,   +   e+   jZp  ,<   ,<p  ,<` Z  Zf /   [p  XBp  +   c/   Zw3B   +   z,<   ,<   Zw-,   +   sZp  Z   2B   +   q "  +   s[  QD   "  +   wZwZ  Zp  ,   XBp  [wXBw+   m/  ,<   ,<` Z  gf +   |,< $,<`  %Zw|     +    ,<wZp  -,   +   +  Zp  ,<   [p  ,<   Zp  -,   +  +  Zp  ,<   Zwz,<    w."      ,\      /   [p  XBp  +  /   Zw{     /   [p  XBp  +   ~/   Zw|     +    ,<`  &Z   /  ,~                  	     CH l   @@ $H\  
A(@!j BD         (FN . 1)
(FILE1 . 1)
(FILE2 . 1)
(VARIABLE-VALUE-CELL FILERDTBL . 242)
(NIL)
(LINKED-FN-CALL . INPUT)
(NIL)
(LINKED-FN-CALL . OPNJFN)
(NIL)
(LINKED-FN-CALL . OUTPUT)
0
(NIL)
(LINKED-FN-CALL . PRIN2)
1
(NIL)
(LINKED-FN-CALL . SPACES)
BINARY
(NIL)
(LINKED-FN-CALL . PRINT)
(NIL)
(LINKED-FN-CALL . READ)
(NIL)
(LINKED-FN-CALL . RATOM)
(NIL)
(LINKED-FN-CALL . READC)
HELP
(NIL)
(LINKED-FN-CALL . DREVERSE)
%(%)
(NIL)
(LINKED-FN-CALL . PRIN1)
(NIL)
(LINKED-FN-CALL . TERPRI)
(COLLCT SKNLST BHC LIST2 CONS ASZ MKN GUNBOX KNIL ENTER3) `   @  h d      @
  k  X 	` I    =    Q h :    B  / `   p S P -    \        P   8 p   m @ 8 h  H  8  ( 
  h        

DEFC BINARY
    '        &-.          ,<  ,<`  ,<` $  3B   +   	,<`   XB` Z`  Z   ,   3B   +   	,<`   Z   3B   +   2B   +   ,<`    3B   +   ,<`  ,<      Z  	2B   +   Z`  Z  !,   ,<   ,<   ,<     ",<`    #,<`  ,<`   $+   ,<`  ,<w,<`   %Z` +    (U@       (NM . 1)
(DF . 1)
(VARIABLE-VALUE-CELL LINKEDFNS . 13)
(VARIABLE-VALUE-CELL DFNFLG . 31)
CODE
MKSWAPP
(NIL)
(LINKED-FN-CALL . MKSWAP)
(NIL)
(LINKED-FN-CALL . RELINK)
(NIL)
(LINKED-FN-CALL . GETD)
(NIL)
(LINKED-FN-CALL . VIRGINFN)
((redefined) . 0)
(NIL)
(LINKED-FN-CALL . PRINT)
(NIL)
(LINKED-FN-CALL . SAVEDEF)
(NIL)
(LINKED-FN-CALL . PUTD)
(NIL)
(LINKED-FN-CALL . PUTPROP)
(URET1 CONS KT FMEMB KNIL ENTER2)            @  @         0   H      

CHANGENAME1 BINARY
     m    Z    j-.            Z-.       \    \,<w~  \3B   +   ,<  ],<   ,<   @  ] `  +   Z   Z  _XB Zw,<?,<?,<?~  _+    +    ,<w~  `3B   +    ,<w~  a,<   ,<w~  b,<   ,<   ,<   ,<    w~,>  Y,>    w~    ,^   /   2B  +   Zw+   DZw|,<    w},<   ,   XBwZw|,<    w},<   ,   XBp  3B  Y+   &Zw|2B  +   B,<w| w},   ,<   ,<w|,<w|  cZ   XBw+   BZw|Zw2B  +   -,<w| w},   ,<   ,<w|  dZ   XBw+   BZw-,   +   <,<   ,<  e  f,<   Z"   ,\  2B  +   B,<w,<  g  f,<   Z"  ,\  2B  +   B,<w  g,<   ,<w|,<w|,<w|,  3B   +   BZ   XBw+   B-,   +   >+   B,<   ,<w|,<w|,  E3B   +   BZ   XBw w~."    $   @w~+   /  +    ,<   Zw-,   +   HZp  +    ZwZw2B  +   M,<w,<w~  hZ   XBp  +   R,<w~,<w~Zw~,<   ,  E3B   +   RZ   XBp  Zw3B   +   W[w2B  +   W,<w,<w~  iZ   +    [wXBw+   F        Y(	 $ I0XPRb@AH($B     (DEF . 1)
(X . 1)
(Y . 1)
(FN . 1)
(NIL)
(LINKED-FN-CALL . EXPRP)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(NIL)
(LINKED-FN-CALL . ESUBST)
(NIL)
(LINKED-FN-CALL . CCODEP)
(NIL)
(LINKED-FN-CALL . FIRSTLIT)
(NIL)
(LINKED-FN-CALL . LASTLIT+1)
(NIL)
(LINKED-FN-CALL . DOLINK)
(NIL)
(LINKED-FN-CALL . /FNCLOSERA)
-5
(NIL)
(LINKED-FN-CALL . NTHCHARCODE)
-4
(NIL)
(LINKED-FN-CALL . GETD)
(NIL)
(LINKED-FN-CALL . /RPLACA)
(NIL)
(LINKED-FN-CALL . /RPLACD)
(FIXT SKNLST ASZ SKLA KT MKN FFNOPD FFNOPA BHC URET4 CONSNL CF KNIL BLKENT ENTER4)   @   x =    5    h   
x R 	P B @ , `   ( #            E x     I `  X   P      
8 Q h A 0  8  p   h            

LINKBLOCK BINARY
      h   ~-.          h-.     (hhk        F       ,  ,~   -.    l,<   Z   2B n+   Z   ,<  Zp  -,   +   +   Zp  ,<   ,  8[p  XBp  +   
/   Z   ,<   Zp  -,   +   +   Zp  ,<   ,  8[p  XBp  +   /   +   7b n3B   +   Z  ,<   ,  8+   7Z  XBp  -,   +    Zp  Z 7@  7   Z  XBp  -,   +   6,<   Zp  -,   +   "+   5Zp  ,<   Zp  -,   +   &,<   ,  8+   3Zp  2B   +   1[p  ,<   Zp  -,   +   ++   0Zp  ,<   Zp  -,   +   .,<   ,  8/   [p  XBp  +   )/   +   3Zp  ,<   ,  8/   [p  XBp  +    /   +   7Z o+    Z  +    -.    pZ  7-,   +   B,<   ,< q q2B   +   @Z  9,<   ,< r q2B   +   @Z  =."   Z  +   B,<   ,<p   s3B   +    ,<p  ,  F+        ,<   ,<   ,<   ,<w~ t3B   +   MZw~,<   ^"  ,<   ,   /"  +   SZw~,<   ^"  ,<   ,   ,> g,>   Zw~    ,^   /   /  XBwZw~,<   ^",<   ,   . gXBwZwZw2B  +   ZZ   +    Zw~,<   Zw~,<   ,   XBp  ,<    "   ,\  3B  +   lZp  ,<    "   ,\  3B  +   lZp  ,> g,>    "       ,^   /   3"  +   wZp  ,> g,>    "       ,^   /   2b  +   wZw~,<   Zw~,<   ,   XBp  -,   +  ,<w~Zw~,   ,<   ,<wZ   2B   +   uZ  @+   uZ   ,<   ,<   , +  Zp  -,   +  ,<   ,< u u,<   Z"   ,\  2B  +  ,<p  ,< v u,<   Z"  ,\  2B  +  ,<p  ,  8+  -,   +  Zp  XBp  -,   +  ,<   ,< u u,<   Z"   ,\  2B  +  ,<p  ,< v u,<   Z"  ,\  2B  +  ,<p  ,  8Zw."   XBw+   W  (  , ,~   -.   
 w,<   ,<   ,<   Z"   XBp  Z  t3B   +  Z` ."   Z  2B   +  ,< x,< x,< y,<`  ,<` ,<` ,   ,   XBw "   XBw+  0Z` ."   Z  XBwZ` ."   [  ({A" ,   XBw,<   ^"  X,   ,\  2B  +  ) "   +  0Z` ."   [  A" p,   XBp   "   ,> g,>    w.Bx  ,^   /      XBwZ` ,   XB` Z` ."   Z  2B   +  >Z 3B   +  >Z   2B   +  >,< y,<    z,<` ,<    z,< {,<    zZ 4,<   ,<    {Z` ,<   Z`  ,<   Z` ,<   ,   ,\  2B  +  IZw,<   Z`  ,<   Z` /"   ,<   ,   ,\  2B  +  I+  fZ` 3B   +  XZ`  ,<   Z` ,<   Z` (B  	,> g,>   Zw~.Bx  ,^   /   ,   Z`  ,<   Z` /"   ,<    w(B  	,> g,>   Zw~.Bx  ,^   /   ,   +  f,<`  Z` ,   ,<   ,<`  |,<`  Z` ,   ,<   ,<w~ },<`  Z` /"   ,   ,<   ,<w~ },<`  Z` /"   ,   ,<   Zw,   f |Z   +       i2 I4b,C
"B-( ! 
@ @(eBBhX,R@  @ IS"      A           (LINKBLOCK#0 . 1)
(VARIABLE-VALUE-CELL SYSLINKEDFNS . 18)
(VARIABLE-VALUE-CELL LINKEDFNS . 31)
(VARIABLE-VALUE-CELL UNLINKFLG . 229)
(VARIABLE-VALUE-CELL FN . 376)
(VARIABLE-VALUE-CELL NOLINKMESS . 364)
RELINK
RELINK2
DOLINK
*RELINK*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL FN . 0)
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL UNLINKFLG . 0)
WORLD
(NIL)
(LINKED-FN-CALL . ARGTYPE)
?
*RELINK1*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL FN . 0)
BROKEN
(NIL)
(LINKED-FN-CALL . GETP)
ADVISED
(NIL)
(LINKED-FN-CALL . CCODEP)
(NIL)
(LINKED-FN-CALL . SWPARRAYP)
-5
(NIL)
(LINKED-FN-CALL . NTHCHARCODE)
-4
*DOLINK*
((UNBOXED-NUM . 4) VARIABLE-VALUE-CELL FN . 0)
LAMBDA
NOLINKARGS
NOLINKDEF1
******
(NIL)
(LINKED-FN-CALL . LISPXPRIN1)
" not defined when link tried from "
(NIL)
(LINKED-FN-CALL . LISPXPRINT)
(NIL)
(LINKED-FN-CALL . /FNCLOSERD)
(NIL)
(LINKED-FN-CALL . /FNCLOSERA)
(URET3 FFNCLR GUNBOX POPTAB ALIST3 LIST4 ASZ MKN EXCALQ HCCALQ SBCALQ CCALC URET4 KT FFNOPD FFNOPA 
SKLA URET1 SKLST KNOB BHC SKNLST KNIL BINDB BLKENT ENTER1) x   Q   f     P   `   X   X   @   Ha XZ @' P r        X        _    [   > @:  w (     o 
p   x ] 
 M     p (   h E  7        h    Q   k p S ` 4  / h     - ( %         g (7 `4  P @ v @ J 	 H x D   =        0 9  p    (      

RELINK BINARY
             -.           ,<    ,~       (VARIABLE-VALUE-CELL FN . 0)
(VARIABLE-VALUE-CELL UNLINKFLG . 0)
RELINK
(NIL)
(LINKED-FN-CALL . LINKBLOCK)
(ENTERF)    

RELINK2 BINARY
            -.           ,<    ,~       (DEF . 1)
RELINK2
(NIL)
(LINKED-FN-CALL . LINKBLOCK)
(ENTER1)    

DOLINK BINARY
             -.     (      ,<    ,~       (BLKFN . 1)
(REL . 1)
(NM . 1)
(VARIABLE-VALUE-CELL FN . 0)
(NOUNDOFLG . 1)
DOLINK
(NIL)
(LINKED-FN-CALL . LINKBLOCK)
(ENTERF)     

CALLSCCODE BINARY
     n   P   d-.          P-.     (Q   S-.    S@ T   ,~   ZwZ8  -,   +   	b VZwXB8  b W2B   +   Zw,<8  ,< X YZw,<8  ,<   /   ,  Z   ,<   Z   ,<  Z   ,<  Z   ,<  ,   ,~   ,<p   Z,<   ,<w [,<   ,<w \,<   ,<w~ ],<   ,<w~ ^,<   ,< _,<   ,<   ,<   ,<   Z  ,<   ,<wz,<w{,<w{,<   , 7d _XB  Z  ,<  ,<wz w{,> O,>    w|.Bx  ,^   /   ,   ,<   ,<w|,<   , 7d `XB  " w~."    $   @w~,   ,> O,>    w|    ,^   /   2B  +   7 w|,> O,>    w}.Bx   w}.Bx  ,^   /   ,   XBw~+  Zw{,<    w},<   ,   ({,   XBw~,<   ^"  ,   ,\  3B  +   BZw~,<   ^"  ,   ,\  2B  +   ZZ   2B   +   +Zw{,<   Zw{3B   +   L^",> O,>   Zwz,<    w},<   ,   .Bx  ,^   /   +   RZwz,<    w},<   ,   ,> O,>   Zwz    ,^   /   /  ,<   ,   XBw-,   +   +ZwZ  ,   2B   +   +Z  U,<   Zw~,   d _XB  W+   +Zw~,<   ^"  X,   ,\  2B  +   |Z  B2B   +   +Zw{,<    w},<   ,   ,<    "   ,\  2B  +   +Zw{,<   Zw{3B   +   m^",> O,>   Zwz,<    w}/"   ,<   ,   .Bx  ,^   /   +   tZwz,<    w}/"   ,<   ,   ,> O,>   Zwz    ,^   /   /  ,<   ,   XBw-,   +   +ZwZ  Y,   2B   +   +Z  w,<   Zw~,   d _XB  y+   +Zw~,<   ^"  
,   ,\  3B  +  Zw~,<   ^"  
,   ,\  3B  +  Zw~,<   ^"  ,   ,\  2B  +   Z  ^2B   +   +Zw{,<   Zw{3B   +  ^",> O,>   Zwz,<    w},<   ,   .Bx  ,^   /   +  Zwz,<    w},<   ,   ,> O,>   Zwz    ,^   /   /  ."   ,<   ,   XBw-,   +   +ZwZ  ,   2B   +   +Z ,<   Zw~,   d _XB +   +Zw~,<   ^"  ,   ,\  2B  +  J,<w{Zw{3B   +  ,^",> O,>   Zwz,<    w},<   ,   .Bx  ,^   /   ,   +  2Zwz,<    w},<   ,   ,> O,>   Zwz    ,^   /   /  ,   XBw~,<   Zwz,<    w|."   ,<   ,   ({,   XBw~,<   ,<   , 7,<   ,<wz w~,> O,>    w~.Bx  ,^   /   ,   ,<   Zwy,<    w|."   ,<   ,   A" ,   ,<   ,<   , 7d _XBp  Z  ",<  d _XB E w~."    $   @w~+   +Zw~,<   ^"  ,   ,\  2B  +  gZ G,<   ,<wzZwz3B   +  V^",> O,>   Zwz,<    w|,<   ,   .Bx  ,^   /   +  \Zwz,<    w|,<   ,   ,> O,>   Zwz    ,^   /   /  ."   ,   ,<   Zwy,<    w|."   ,<   ,   /"   ,   ,<   ,<   , 7d _XB M w~."    $   @w~+   +Zw~,<   ^"  Z,   ,\  2B  +   +Zw{,<    w},<   ,   XBw,<    "   ,\  3B  +  sZw,<    "   ,\  2B  +   +Z d,<   ,<wzZwz3B   +  ~^",> O,>   Zwz,<    w|."    $   @w|,   ,<   ,   .Bx  ,^   /   +  Zwz,<    w|."    $   @w|,   ,<   ,   ,> O,>   Zwz    ,^   /   /  ."   ,   ,<   Zwy,<    w|,<   ,   (B}A"  ,   ,<   ,<   , 7d _XB s+   + w~,> O,>    w|    ,^   /   2B  +  Z   /  ,~   Zw{,<    w},<   ,   XBw-,   +  Zw,<   , '+  $Z 2B   +  $Zw-,   +  $ZwZ  {,   2B   +  $ZwZ ,   2B   +  $,<w, '3B   +  $ w~."    $   @w~+  ,<p  ,< a b,<   Z"   ,\  2B  +  3,<p  ,< c b,<   Z"  ,\  2B  +  3,<p   VXBp  3B   +  3b W3B   +    +  4Z   +    ,<p  ,<   /   ,  Z   +    ,<   ,<   Zw~0B   +  ;Zw+    Zw3B   +  CZw},<    w},> O,>    w~.Bx  ,^   /   . O,<   ,   +  IZw},<    w},> O,>    w~.Bx  ,^   /   . O,<   ,   b cXBp  -,   +  LZw,   XBw w~/"   ,   XBw~+  8   `e $J  @ 
 A !@H 	  @(   @  @A   0 @   P!0X) ! I @      (DEF . 1)
(VARIABLE-VALUE-CELL VARSFLG . 565)
(VARIABLE-VALUE-CELL BOUND . 577)
(VARIABLE-VALUE-CELL FREEVARS . 85)
(VARIABLE-VALUE-CELL VARSFLG . 0)
(VARIABLE-VALUE-CELL CALLED . 572)
(VARIABLE-VALUE-CELL LNCALLED . 318)
*CALLSCCODE*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL VARSFLG . 0)
(NIL VARIABLE-VALUE-CELL CALLED . 0)
(NIL VARIABLE-VALUE-CELL LNCALLED . 0)
(NIL VARIABLE-VALUE-CELL BOUND . 0)
(NIL VARIABLE-VALUE-CELL FREEVARS . 0)
(NIL)
(LINKED-FN-CALL . GETD)
(NIL)
(LINKED-FN-CALL . CCODEP)
"not compiled code"
(NIL)
(LINKED-FN-CALL . ERROR)
(NIL)
(LINKED-FN-CALL . SWPARRAYP)
(NIL)
(LINKED-FN-CALL . FIRSTLIT)
(NIL)
(LINKED-FN-CALL . LASTLIT+1)
(NIL)
(LINKED-FN-CALL . NARGS)
(NIL)
(LINKED-FN-CALL . NFRVARS)
0
(NIL)
(LINKED-FN-CALL . NCONC)
(NIL)
(LINKED-FN-CALL . UNION)
-5
(NIL)
(LINKED-FN-CALL . NTHCHARCODE)
-4
(NIL)
(LINKED-FN-CALL . VCTOAT)
(CONS URET6 URET1 ASZ SKLST BINDLA KT EFNCAL CONSNL FMEMB FFNOPA FFNOPD IUNBOX FIXT MKN LIST4 BHC KNIL
 SKLA BINDB BLKENT ENTERF)  )H   '8   ' 5 &8   ' . %    #       &x6 !Pc H   8   p {    $  @ x 
h   )  0| Xa U p* @ X q @ b 
8 O 	(   (0
 (7  :    8 .   &  z hI P   )h  xi (^ HC p8 0, ( (  P A X ; p (       H (6 "H  `~ HV h2 8  t X R 	@ 6  ( p   'H9 '4 &01 $H" $  "@v 9 X 0  g x W ` C   ! h  X  h 
   K #X h T  x   p            

FIRSTLIT BINARY
             -.           ,<`  "  3B   +   Z`  ,<   ^"  ,<   ,   .  ,   ,~   Z`  ,<   ^"  ,<   ,   ,>  ,>   Z`      ,^   /   /  ,   ,~        (HANDLE . 1)
SWPARRAYP
(BHC MKN FFNOPA KNIL ENTER1)   X   h     
  h    8      

FNTYP1 BINARY
             -.            Z   ,~       (KNIL ENTER0)    (      

LASTLIT+1 BINARY
               -.           Z`  ,<   ^",<   ,   .  ,   ,~       (HANDLE . 1)
(MKN FFNOPD ENTER1)    X    H      

NFRVARS BINARY
            -.           ,<   Z`  ,<   ^"  ,<   ,   0B   +   Z`  ,<   ^"  ,<   ,   XBp  ,<    "   ,\  3B  +   Zp  ,<    "   ,\  2B  +   Z`  ,<   ^"  ,<   ,   ,   +    Z`  ,<   ^"  ,<   ,   ,   +     A      (ADR . 1)
(URET1 MKN SBLKNT BLKENT FFNOPA FFNOPD KNIL ENTER1)       P         
                     

NOLINKDEF1 BINARY
        (         '-.           Z   ,<   @  "  ,~   Z   0B   +   +   
,<  #,<  $$  $Z` ,   XB` >  +   ZwZ8 3B   +   -,   +      %ZwZ8 ."   Z  3B   +   Zw,<8  ,<8 ,<8 ,<   ,<   *  %Zw,<8 ,<` $  &,~   Zw,<8 ,<` $  &,<   Zw~Z8 ."   Z  3B   +   Zw~,<8  ,<8 ,<8 ,<   ,<   *  %,\   ,~   BB      (FN . 1)
(REL . 1)
(NAME . 1)
(VARIABLE-VALUE-CELL NOLINKARGS . 3)
(VARIABLE-VALUE-CELL I . 18)
NIL
NOLINKARGS
I
ARG
HELP
DOLINK
APPLY
FAULTAPPLY
(KT SKNLA KNIL CONS ASZ ENTER3) x  @               	           

COREVAL BINARY
              -.           ,<`  ,<  $  ,   ,~       (X . 1)
COREVAL
GETP
(GUNBOX ENTER1)   @      

OPD BINARY
        
        	-.           ^" ,>  ,>   ,<`  ,<  $  	,   (B{ABx  ,^   /   ,~      `   (X . 1)
OPD
GETP
(BHC IUNBOX ENTER1)   x    X      

PRFNOPENADR BINARY
             -.           Z   3B   +   	^",>  ,>   Z   ,<       ,<   ,   .Bx  ,^   /   ,   ,~   Z  ,<      ,<   ,   ,>  ,>   Z  	    ,^   /   /  ,   ,~      @       (VARIABLE-VALUE-CELL HANDLE . 26)
(VARIABLE-VALUE-CELL N . 21)
(VARIABLE-VALUE-CELL SWAPPEDFLG . 3)
(MKN BHC FFNOPA KNIL ENTERF)       x 	      x    0      
(PRETTYCOMPRINT CODEFORMATCOMS)
(RPAQQ CODEFORMATCOMS ((DECLARE: FIRST (P (MAPC (QUOTE (LAPRD BINRD FNTYP ARGLIST1 LINKBLOCK)) (
FUNCTION (LAMBDA (FN) (OR (FMEMB FN NOSWAPFNS) (SETQ NOSWAPFNS (CONS FN NOSWAPFNS)))))))) (FNS * 
CODEFORMATFNS) (BLOCKS * CODEFORMATBLOCKS) (DECLARE: DOEVAL@COMPILE (PROP MACRO COREVAL OPD) DONTCOPY 
(PROP MACRO OBIN OBOUT OSFBSZ OSIN ONIN ORFPTR OSFPTR CGETD PRFNOPENADR)) (DECLARE: DONTEVAL@LOAD 
DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA) (NLAML OPD COREVAL NOLINKDEF1) (LAMA)))))
(RPAQQ CODEFORMATFNS (LAPRD BINRD BINSKIP BINFIX DOVARLINK DOLINK ARGLIST CGETD CHANGENAME1 
CHANGENAME2 DEFC FIRSTLIT FNTYP FNTYP1 LASTLIT+1 NARGS NFRVARS RELINK RELINK1 RELINK2 NOLINKDEF1 
CALLSCCODE CALLS1 CALLS2 MAKELIST PRFNOPENADR COREVAL OPD))
(RPAQQ CODEFORMATBLOCKS ((NIL LAPRD DOLINK BINRD DOVARLINK (LOCALVARS . T) (GLOBALVARS LINKEDFNS 
FILERDTBL NOLINKMESS)) (NIL BINRD CGETD FNTYP ARGLIST NARGS BINSKIP BINFIX DEFC (LINKFNS . T) (
NOLINKFNS MKSWAPP) (LOCALVARS . T) (GLOBALVARS DFNFLG LINKEDFNS FILERDTBL LAMBDASPLST)) (CHANGENAME1 
CHANGENAME1 CHANGENAME2) (LINKBLOCK RELINK RELINK1 RELINK2 DOLINK (ENTRIES RELINK RELINK2 DOLINK) (
GLOBALVARS SYSLINKEDFNS NOLINKMESS LINKEDFNS) (SPECVARS UNLINKFLG FN)) (CALLSCCODE CALLSCCODE CALLS1 
CALLS2 MAKELIST (LOCALFREEVARS BOUND FREEVARS CALLED LNCALLED VARSFLG)) (NIL FIRSTLIT FNTYP1 LASTLIT+1
 NFRVARS NOLINKDEF1 COREVAL OPD (LOCALVARS . T))))
(PUTPROPS COREVAL MACRO ((X) (ASSEMBLE NIL (MOVEI 1 , X))))
(PUTPROPS OPD MACRO (X (LIST (QUOTE VAG) (LLSH (GETP (CAR X) (QUOTE OPD)) -9))))
NIL
