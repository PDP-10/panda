(FILECREATED "11-Jul-84 23:30:36" ("compiled on " <NEWLISP>BASIC..160) (2 . 2) brecompiled exprs: 
ALLOCSTRING in WORK dated "30-Dec-83 01:23:53")
(FILECREATED "11-Jul-84 23:29:37" <NEWLISP>BASIC..160 40346 changes to: (VARS BASICCOMS) (FNS 
ALLOCSTRING) previous date: "13-JUL-83 03:18:16" <NEWLISP>BASIC..159)
(MOVD? (QUOTE ARRAY) (QUOTE OLDARRAY))
(SETQ NOSWAPFNS (CONS (QUOTE SETA) NOSWAPFNS))
SYNTAXP BINARY
   8      3-.          -.         ZwZ ,   3B   +    wA"  ?,<   ,<w" ,> ,>   Zw3B  +   2B  +   ^"  +   3B !+   2B !+   ^"  +   2B "+   ^"  +   3B "+   2B #+   ^"  +   2B #+   ^"  +     $,   .Bx  ,^   /   Z  ,\  2B  7   Z   +    Zw2B $+   0,<p  " XBp   wA"  ?XBw,<   Z"  XBp   p  1b  +   $Z   +   /Zw,> ,>    p  .Bx  ,^   /      ,   ,<   Zw~,   ,\  2B  +   -Z   +   / p  ."   ,   XBp  +   "/   +    ,<p  " %,> ,>    wA"  ?.Bx  ,^   /   ."  [  XBwZw3B %+   92B &+   DZw,> ,>   Zw2B %+   =^"  @+   @2B &+   ?^"   +   @  $,   ABx  ,^   /   1B   +   C7   Z   +    3B &+   M3B '+   M3B '+   M3B (+   M3B (+   M3B )+   M3B )+   M3B *+   M2B *+   dZw,   ,<   Zw2B &+   QZ"  Q+   a2B '+   SZ"  R+   a2B '+   UZ"  Q+   a2B (+   WZ"  P+   a2B *+   YZ"  X+   a2B )+   [Z"  +   a2B (+   ]Z"  P+   a2B )+   _Z"  0+   a2B *+   aZ"   +   a  $,\  2B  7   Z   +    3B ++   g3B ++   g2B ,+   rZwA"  ,   ,<   Zw2B ++   kZ"  +   p2B ++   mZ"  +   p2B ,+   oZ"  +   p  $,\  2B  7   Z   +    3B ,+   }3B -+   }3B -+   }3B .+   }3B .+   }3B /+   }3B /+   }3B 0+   }3B 0+   }3B 1+   }2B 1+  ZwA"  Zw3B 1+  3B 1+  3B 0+  2B 0+  Zw,> ,>   Zw3B 1+  2B 1+  ^"  +  ^"  ABx  ,^   /   0B   7   Z   +    Zw,> ,>   Zw2B ,+  ^"  +  2B -+  ^"  @+  2B -+  ^"  +  3B /+  2B /+  ^"  +  ^"  ABx  ,^   /   1B   +  7   Z   +    ,< 2D 2+       H3o]w0 hP (# Mlpnw;;]A|]Atz &n}      (CHARCODE . 1)
(CLASS . 1)
(TABLE . 1)
((CHARDELETE DELETECHAR LINEDELETE DELETELINE RETYPE CNTRLV CTRLV EOL) . 0)
GETTERMTABLE
CHARDELETE
DELETECHAR
DELETELINE
LINEDELETE
RETYPE
CNTRLV
CTRLV
EOL
HELP
NONE
GETREADTABLE
BREAK
SEPR
LEFTPAREN
RIGHTPAREN
LEFTBRACKET
RIGHTBRACKET
BREAKCHAR
SEPRCHAR
ESCAPE
STRINGDELIM
OTHER
MACRO
SPLICE
INFIX
ALONE
ALWAYS
FIRST
IMMED
IMMEDIATE
ESC
ESCQUOTE
NONIMMED
NONIMMEDIATE
NOESC
NOESCQUOTE
"Illegal syntax class"
ERROR
(MKN ASZ URET3 KT BHC IUNBOX KNIL FMEMB BLKENT ENTER3)  i 	h / 0 )    o X k  _ P [  W 
P S 
 "    @ 0 d H 1 H   0 ( d 8 $ @   
   5  (         8 r 8 D P ! 8                
GETSYNTAX BINARY
     a   <   W-.          <-.      =   =,<   Zw   +    w1b   +    w1"  @+   ,<w" =0B   +   ,<w" =XBw+   ZwZ >,   3B   +   Z   XBp  +   ZwZ >,   3B   +   Z"   XBp  +   ,< ?,<w~,   B ?Zp  3B   +   l0B   +   TZw2B @+   >,<w, J."  XBw,<   ,<   ,<   ,<   Z"   XBw w1b  ?+   !Zw~+   =,<   Z"   XBp   p  1b  +   %Z   +   /Zw},> ;,>    p  .Bx  ,^   /      ,   Zw~2B  +   ,Z   +   / p  ."   ,   XBp  +   #/   2B   +   1+   :ZwXBwZp  3B   +   8,<   ZwZw,   Z   QD  XBw,\  QB  +   :Zw,   XBp  XBw~ w."   ,   XBw+   /  +    ,<w, J,> ;,>   Zw3B @+   B2B A+   C^"  +   N3B A+   E2B B+   F^"  +   N2B B+   H^"  +   N3B C+   J2B C+   K^"  +   N2B D+   M^"  +   N  D,   .Bx  ,^   /   Z  ,   XBp  1B t+   S,   +    Z   +    ,<w, EXBw,<   ,<   ,<   ,<   Z"   XBw w1b  ?+   [Zw~+   k,<w,<w|,<w|, O2B   +   _+   hZwXBwZp  3B   +   f,<   ZwZw,   Z   QD  XBw,\  QB  +   hZw,   XBp  XBw~ w."   ,   XBw+   Y/  +    ,<w" E3B   +  	Zw,   XBw,<   Zw."  XBwZ  ,\  2B  +   tZ A+    Zw,<   Zw."   Z  ,\  2B  +   yZ B+    Zw,<   Zw."  Z  ,\  2B  +   ~Z B+    Zw,<   Zw."  Z  ,\  2B  +  Z C+    Zw,<   Zw."  Z  ,\  2B  +  Z D+    Z @+    ,<w, E,> ;,>    w.Bx  ,^   /   ."  XBw[wXBp  ,   0B  P+  Z E+    0B  0+  Z F+    0B  X+  Z F+    0B  +  Z G+    0B  P+  Z G+    0B  Q+  Z H+    0B  Q+  Z H+    0B  R+   Z I+    0B   +  "Z I+    Zp  A"  ,   1B  +  &1B  +  &0B  +  CZp  A"  ,   0B  +  *Z J+  .0B  +  ,Z J+  .0B  +  .Z K+  .  D,<   ZwA" l,   0B  +  2Z K+  80B  +  4Z L+  80B  @+  6Z L+  8,< MZw,   D M,<   ZwA"  1B   +  <Z N+  <Z N,<   Zw~A"  1B   +  @Z O+  @Z O,<   Zw}^,  ,   +    ,< PZw,   D M+    Zp  2B P+  I,< Q,< Q$ R,   +    B R+    Zp  2B P+  N,< S,< Q$ R,   +    B S+    Zp  ,> ;,>    wA"  ?.Bx  ,^   /   ."  [  XBwZw3B T+  W2B T+  bZw,> ;,>   Zw2B T+  [^"  @+  ^2B T+  ]^"   +  ^  D,   ABx  ,^   /   1B   +  a7   Z   +    3B H+  k3B I+  k3B H+  k3B G+  k3B E+  k3B F+  k3B G+  k3B F+  k2B I+  Zw,   ,<   Zw2B H+  oZ"  Q+   2B I+  qZ"  R+   2B H+  sZ"  Q+   2B G+  uZ"  P+   2B F+  wZ"  X+   2B G+  yZ"  +   2B E+  {Z"  P+   2B F+  }Z"  0+   2B I+  Z"   +     D,\  2B  7   Z   +    3B J+  3B J+  2B K+  ZwA"  ,   ,<   Zw2B J+  
Z"  +  2B J+  Z"  +  2B K+  Z"  +    D,\  2B  7   Z   +    3B K+  3B L+  3B L+  3B U+  3B N+  3B U+  3B O+  3B V+  3B N+  3B V+  2B O+  :ZwA"  Zw3B V+  !3B O+  !3B V+  !2B N+  *Zw,> ;,>   Zw3B V+  %2B O+  &^"  +  '^"  ABx  ,^   /   0B   7   Z   +    Zw,> ;,>   Zw2B K+  .^"  +  62B L+  0^"  @+  62B L+  2^"  +  63B U+  42B O+  5^"  +  6^"  ABx  ,^   /   1B   +  97   Z   +    ,< WD M+       *TJLJh PT PL{w}l Q0@( ` 0L 3Lf3!nx^!px|OI Mlpnw;]]A|nAtz &w}            (CH . 1)
(TABLE . 1)
NCHARS
CHCON1
((RIGHTBRACKET LEFTBRACKET RIGHTPAREN LEFTPAREN MACRO SPLICE INFIX ESCAPE BREAK SEPR OTHER STRINGDELIM
 BREAKCHAR SEPRCHAR ALWAYS ALONE FIRST IMMED IMMEDIATE NONIMMED NONIMMEDIATE ESC ESCQUOTE NOESC 
NOESCQUOTE) . 0)
((DELETECHAR CHARDELETE CNTRLV CTRLV LINEDELETE DELETELINE RETYPE EOL NONE) . 0)
27
ERRORX
NONE
DELETECHAR
CHARDELETE
DELETELINE
LINEDELETE
RETYPE
CNTRLV
CTRLV
EOL
HELP
TERMTABLEP
BREAKCHAR
SEPRCHAR
STRINGDELIM
ESCAPE
RIGHTBRACKET
LEFTBRACKET
LEFTPAREN
RIGHTPAREN
OTHER
MACRO
SPLICE
INFIX
ALONE
FIRST
ALWAYS
"Illegal readtable entry"
ERROR
IMMEDIATE
NONIMMEDIATE
ESCQUOTE
NOESCQUOTE
"Illegal readtable entry"
ORIG
ORGRDT
COREVAL
GETPROP
GETREADTABLE
ORGTTX
GETTERMTABLE
BREAK
SEPR
IMMED
ESC
NONIMMED
NOESC
"Illegal syntax class"
(URET1 ALIST GUNBOX IUNBOX URET3 CONSNL CONS MKN BHC LIST2 KT FMEMB ASZ SMALLT KNIL BLKENT ENTER2)  P pK     0   hI x   p O   < '(+ " 0F 8"  H  H  	 @    u H U 
@ >    h 
8 :    d `    xm P8 ( @ ( Q H . (   ' ) T ` l 
 >   )       9 %(  (b X      `   !` !  X{ w Xs o X3 - 0) h% H! p 0 p 0  R 0         P   ' * " ( n H a h X   W 
p T h 3  , (  `  P  (   @    (      

ALLOCSTRING BINARY
             -.           ,   Z` "   +   B  ,   +   ,   ,>  ,>   ,<    `      ,\   +   
 x  ,   =$  	,^   /       ,   ,~      T	  (N . 1)
(INITCHAR . 1)
(OLD . 1)
CHCON1
(MKSP UNP1 BHC MKSTR1 IUNBOX SMALLT MKSTRS ENTER3)  P   H   @   (    `                
CAAR BINARY
              -.           Z`  Z  ,~       (X . 1)
(ENTER1)     
CADR BINARY
              -.           [`  Z  ,~       (X . 1)
(ENTER1)     
CDAR BINARY
              -.           Z`  [  ,~       (X . 1)
(ENTER1)     
CDDR BINARY
              -.           [`  [  ,~       (X . 1)
(ENTER1)     
CAAAR BINARY
             -.           Z`  Z  Z  ,~       (X . 1)
(ENTER1)     
CAADR BINARY
             -.           [`  Z  Z  ,~       (X . 1)
(ENTER1)     
CADAR BINARY
             -.           Z`  [  Z  ,~       (X . 1)
(ENTER1)     
CADDR BINARY
             -.           [`  [  Z  ,~       (X . 1)
(ENTER1)     
CDAAR BINARY
             -.           Z`  Z  [  ,~       (X . 1)
(ENTER1)     
CDADR BINARY
             -.           [`  Z  [  ,~       (X . 1)
(ENTER1)     
CDDAR BINARY
             -.           Z`  [  [  ,~       (X . 1)
(ENTER1)     
CDDDR BINARY
             -.           [`  [  [  ,~       (X . 1)
(ENTER1)     
CAAAAR BINARY
            -.           Z`  Z  Z  Z  ,~       (X . 1)
(ENTER1)     
CAAADR BINARY
            -.           [`  Z  Z  Z  ,~       (X . 1)
(ENTER1)     
CAADAR BINARY
            -.           Z`  [  Z  Z  ,~       (X . 1)
(ENTER1)     
CAADDR BINARY
            -.           [`  [  Z  Z  ,~       (X . 1)
(ENTER1)     
CADAAR BINARY
            -.           Z`  Z  [  Z  ,~       (X . 1)
(ENTER1)     
CADADR BINARY
            -.           [`  Z  [  Z  ,~       (X . 1)
(ENTER1)     
CADDAR BINARY
            -.           Z`  [  [  Z  ,~       (X . 1)
(ENTER1)     
CADDDR BINARY
            -.           [`  [  [  Z  ,~       (X . 1)
(ENTER1)     
CDAAAR BINARY
            -.           Z`  Z  Z  [  ,~       (X . 1)
(ENTER1)     
CDAADR BINARY
            -.           [`  Z  Z  [  ,~       (X . 1)
(ENTER1)     
CDADAR BINARY
            -.           Z`  [  Z  [  ,~       (X . 1)
(ENTER1)     
CDADDR BINARY
            -.           [`  [  Z  [  ,~       (X . 1)
(ENTER1)     
CDDAAR BINARY
            -.           Z`  Z  [  [  ,~       (X . 1)
(ENTER1)     
CDDADR BINARY
            -.           [`  Z  [  [  ,~       (X . 1)
(ENTER1)     
CDDDAR BINARY
            -.           Z`  [  [  [  ,~       (X . 1)
(ENTER1)     
CDDDDR BINARY
            -.           [`  [  [  [  ,~       (X . 1)
(ENTER1)     
ABS BINARY
       	        -.           ,<  ,<`  $  3B   +   ,<`  "  ,~   Z`  ,~   P   (X . 1)
0
GREATERP
MINUS
(KNIL ENTER1)         
ADD1 BINARY
              -.            `  ."   ,   ,~       (X . 1)
(MKN ENTER1)          
ARRAY BINARY
     Q    D    N-.            DZ` 3B   +   1B   +   ,<  F,<   ,   B  G,<   ,<   ,<   Z`  -,   +   ,<  F,<   ,   B  G+   -,   +   -,   +   ,   ,   +   XBwZ` 3B   +   0B   +   Z   +   .-,   +   +   .-,   +   (3B  G+   2B  H+   Z   +   .3B  H+   2B  I+   !Z` 3B   +   "   +   ,   ,   XB` +    Z  IXB` Z   +   .3B  J+   %3B  J+   %3B  K+   %2B  K+   &Zw+   .,<  F,<   ,   B  G+   .Z` 3B  L+   +2B  L+   ,Zw+   .,<  F,<` ,   B  GXBw,<w,<   ,<` &  MXBp  Z` 3B   +   CZw3B   +   C w,>  D,>    `      ,^   /   2B  +   C,<  M p  ,>  D,>    w~    ,^   /   3b  +   >+   B,<w,<w,<` &  N p  ."   ,   XBp  +   9/   Zp  +       dj"-{rF?lo2J@b      (N . 1)
(TYP . 1)
(INIT . 1)
(ORIG . 1)
27
ERRORX
POINTER
FLAG
FLOATP
FLOATING
0.0
FIXP
WORD
BYTE
INTEGER
BITS
BETWEEN
OLDARRAY
1
SETA
(URET3 BHC MKFN FUNBOX FLOATT SKNLST SKNM MKN IUNBOX SKNI SKNNM LIST2 ASZ KNIL ENTER4)   D    C P 8                        B p   h   X     	    .     `         4 ( ! @  0      p        
ARRAYSIZEA0004 BINARY
              -.           ^",>  ,>   Z`  .Bx  ,^   /   ,   ,~          (A . 1)
(MKN BHC ENTER1)  `    X      
ARRAYSIZE BINARY
            -.           Z`  (B{Z  A"  ."   0B   +   
^",>  ,>   ,<`  "  Z  .Bx  ,^   /   ,   ,~   0B  +   ,<`  Z  D  ,~   ,<  ,<`  ,   B  ,~      @-     (A . 1)
ARRAYBEG
ARRAYSIZEA0004
SWPPOS
28
ERRORX
(LIST2 MKN BHC ASZ TYPTAB ENTER1)   x   (       8   H    8      
ARRAYORIG BINARY
            -.           Z"   ,~       (X . 1)
(ASZ ENTER1)          
HARRAYSIZE BINARY
             -.          Z`  2B   +   Z   XB`  -,   +   Z`  XB`  B  3B   +   	Z`  .  ,   ,~   ,<  ,<`  ,   B  ,~   R  (HARRAY . 1)
(VARIABLE-VALUE-CELL SYSHASHARRAY . 6)
HARRAYP
28
ERRORX
(LIST2 MKN SKLST KNIL ENTER1)  8       P    x        
BOUNDP BINARY
            -.          Z`  -,   +   Z`  Z 7@  7   Z  2B  +   
,<`  ,<   Z   F  B  3B   +   Z   ,~   Z   ,~     (VAR . 1)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 15)
NOBIND
STKSCAN
RELSTK
(KT KNIL KNOB SKLA ENTER1)                        
DELETECONTROL BINARY
       W    G    T-.          G,<   ,<` "  IXB` Z`  3B  J+   2B  J+   Z` ."  XB`    ,   XBp  Z` ,<   Z`  2B  J+   ^"    $   +   2B  J+   ^"    $   +      K,   ,\   B  Zp  0B   +   Z  J+    Z  J+    Z` -,   +   XBp  +   -,   +   3B   +   ."  [  +   Z   XBp  +   ,<  KD  L,<` "  L,   1b  +   !,<  M,<` $  LZ`  3B  M+   $2B  N+   %^"  +   /2B  N+   '^"  +   /2B  O+   )^"  +   /2B  O+   +^"  +   /2B  P+   -^"  +   /,<  P,<   ,   B  Q,   ,>  G,>   Z` .Bx  ,^   /   ,>  G,>      Zp  3B   +   9,   @@  Q$A`4H  9  B  =h  7,<  Q"  R,    $x  Q$A`
  J  =h  ;/  XB` ,<   ,<  RZ"   A"  ?Z   ." Z  ,<   ,<` $  S,   /"   ,   F  S2B   +    Z  T+       < g4*IiW;]lP!A$     (TYPE . 1)
(MESSAGE . 1)
(TTBL . 1)
(VARIABLE-VALUE-CELL FCHARAR . 128)
GETTERMTABLE
ECHO
NOECHO
HELP
"ILLEGAL MESSAGE TYPE - DELETECONTROL"
ERROR
NCHARS
"ILLEGAL MESSAGE LENGTH - DELETECONTROL"
DELETELINE
LINEDELETE
1STCHDEL
NTHCHDEL
POSTCHDEL
EMPTYCHDEL
27
ERRORX
"12345"
CONCAT
1
STRPOS
SUBSTRING
""
(UPATM BHC LIST2 IUNBOX SKLA SKSTP URET1 ASZ GUNBOX FIXT MKN KNIL ENTER3)  ; h   ` 3    /    D               G h  H              P   P 	    F X          
DIFFERENCE BINARY
             -.           ,<`  ,<` "  D  ,~       (X . 1)
(Y . 1)
MINUS
PLUS
(ENTER2)     
DRIBBLE BINARY
              -.              ,<   Zp  3B   +   B  Z`  3B   +   B  2B   +   ,<`     ,>  ,>   Z` 3B   +   ^"   +   ^"   GBx  Z` 3B   +   ^"  +   ^"   GBx  ,^   /   ,   D  B  Zp  +          fXPP`    (FILE . 1)
(APPENDFLG . 1)
(THAWEDFLG . 1)
SETDRIBBLEFILE
CLOSEF
OPENP
OPENF
(URET1 MKN BHC KNIL ENTER3)                0   `        
ECHOCONTROL BINARY
    X    O    U-.           O,<   ,<` "  PXB` Z`  -,   +   B  Q0B   +   ,<`  "  Q+   Z   XBp  ,   0"  +    p  2b  M+    p  0"  -+    p  0b   +    p  .  M,   XBp  ,   0"  -+    p  1b   +    p  +   ,<  R,<`  ,   B  R,   A"  ,   XB`   `  &"  	   $  N."  ,   XBp  Z` 2B  S+   Z"   +   *2B  S+   !Z"  +   *2B  T+   #Z"  +   *3B  T+   %2B  U+   &Z"   +   *2B   +   (Z   +   *,<  R,<   ,   B  RXB` Z` ,>  N,>    `  &"  	.Bx  ,^   /   ."  XB`     ,>  N,>    p  "       ,^   /   (B  A"  ,   0B   +   7Z  S+   ;0B  +   9Z  S+   ;0B  +   ;Z  T+   ;Z  U,<   Z` 3B   +   LZ`  ,<      ,>  N,>   ^"  ,>  N,>    w    ,^   /   (B  F  MABx   ` ,>  N,>    w    ,^   /   (B  GBx  ,^   /   ,\   B  ,   ,\   +    p   a2(K7;jd@ nxD@H     (CHAR . 1)
(MODE . 1)
(TTBL . 1)
GETTERMTABLE
NCHARS
CHCON1
27
ERRORX
IGNORE
REAL
SIMULATE
UPARROW
INDICATE
(URET1 SETMOD BHC LIST2 MKN IUNBOX ASZ SKNNM KNIL ENTER3)   	X   	H   	0 I @ 4 p         5 H              8 ` & 0 ! p         =   '         
EVQ BINARY
               -.           Z`  ,~       (X . 1)
(ENTER1)     
FASSOC BINARY
            -.           ,<` Z` -,   +   2B   +   Z   +    ,<  ,<w$  +   Z` Z  Z`  2B  +   Z` +    [` XB` +   %B (KEY . 1)
(ALST . 1)
"bad argument - FASSOC"
ERROR
(URET1 KNIL SKNLST ENTER2)     `    X            
FGETD BINARY
         	    -.           	Z`  -,   +   B  
3B   +   ,<`  "  
[  ,~   ,<`  "  
,~   ,<  D  ,~   (X  (X . 1)
SUBRP
GETD
"bad argument - FGETD"
ERROR
(KNIL SKLA ENTER1)              
FLAST BINARY
         
    -.           
,<`  ,<   Z`  -,   +   2B   +   Zp  +    ,<  
,<w$  Z`  XBp  [`  XB`  +   RB  (X . 1)
"bad argument - FLAST"
ERROR
(URET2 SKNLST KNIL ENTER1)             0      
FLENGTH BINARY
              -.           ,<`  ,<  Z`  -,   +   2B   +   Zp  +    ,<  ,<w$  [`  XB`   p  ."    $   @p  +   R@@ (X . 1)
0
"bad argument - FLENGTH"
ERROR
(FIXT URET2 KNIL SKNLST ENTER1)   
                   
FMEMB BINARY
             -.           ,<` Z` -,   +   2B   +   Z   +    ,<  ,<w$  Z  +    Z`  Z` 2B  +   Z` +    [` XB` +   %B (X . 1)
(Y . 1)
"bad argument - FMEMB"
ERROR
Compiled,
(URET1 KNIL SKNLST ENTER2)           H    8      
FNTH BINARY
            -.            `     ^"   3b  +   Z   Z`  ,   ,~   ,<`  Z`  -,   +   2B   +   
Z   +    ,<  ,<w$  +    ` 0b   +   Z`  +    [`  XB`   ` /"   ,   XB` +   @)2      (X . 1)
(N . 1)
"bad argument - FNTH"
ERROR
(MKN URET1 SKNLST CONS KNIL ENTER2)      p 
            
         
FDIFFERENCE BINARY
    
        	-.           Z`  ,   ,>  ,>   ,<` "  	,   Bx  ,^   /   ,   ,~          (X . 1)
(Y . 1)
MINUS
(MKFN BHC FUNBOX ENTER2)   x    p    X        
FIX BINARY
               -.           Z`  -,   +    `  ,   ,~       (X . 1)
(MKN SKNI ENTER1)              
FIXP BINARY
              -.           Z`  -,   +   "   +   ,~   Z   ,~   @   (X . 1)
(KNIL FLOATT SKNM ENTER1)   X    @    0      
FMINUS BINARY
               -.           ,<`  "  "   +   ,   ,   ,~       (X . 1)
MINUS
(MKFN FUNBOX FLOATT ENTER1)    P    H    8      
FLOAT BINARY
                -.           Z`  "   +   ,   ,   ,~       (X . 1)
(MKFN FUNBOX FLOATT ENTER1)                  
FUNCTION BINARY
               -.           Z` 2B   +   Z`  ,~   -,   +   ,<   ,<  $  XB` ,<  ,<`  -,   +   	+   
B  ,   ,~   N  (FN . 1)
(ENV . 1)
INTERNAL
EVAL
FUNARG
FUNCT1
(ALIST3 SKSTK SKLA KNIL ENTER2)  0       P    0      
GETPROPLIST BINARY
               -.           Z`  -,   +   [`  ,~   ,<  ,<   ,   B  ,~   $   (ATM . 1)
14
ERRORX
(LIST2 SKLA ENTER1)             
IDIFFERENCE BINARY
            -.            `  ,>  ,>    ` "   .Bx  ,^   /   ,   ,~          (X . 1)
(Y . 1)
(MKN BHC ENTER2)   h    `      
ILESSP BINARY
       	        -.            ` ,>  ,>    `      ,^   /   3b  7   Z   ,~          (X . 1)
(Y . 1)
(KT KNIL BHC ENTER2)    p    h    X      
IMINUS BINARY
               -.           ,<`  "  -,   +   ,   ,   ,~       (X . 1)
MINUS
(MKN IUNBOX SKNI ENTER1)  P    H    8      
LESSP BINARY
                -.           ,<` ,<`  $  ,~       (X . 1)
(Y . 1)
GREATERP
(ENTER2)      
LRSH BINARY
      	        -.            `  ,>  ,>    ` "       ,^   /   (B  ,   ,~          (N . 1)
(M . 1)
(MKN BHC ENTER2)   p    `      
NEQ BINARY
             -.           Z`  Z` 3B  +   7   Z   ,~       (X . 1)
(Y . 1)
(KNIL KT ENTER2)   P    H      
NILL BINARY
            -.          Z   ,~       (ARGS . 1)
(KNIL ENTERN)  (      
NLISTP BINARY
               -.           Z`  -,   +   7   Z   ,~       (X . 1)
(KNIL KT SKNLST ENTER1)                 
RELSTKP BINARY
                -.           Z`  -,   +      0B   7   Z   ,~   Z   ,~       (X . 1)
(KT KNIL SKSTK ENTER1)         P    0      
RPLACA BINARY
               -.           Z`  -,   +   
2B   +   Z` 3B   +   ,<  ,<   ,   B  ,~   ,<  ,<   ,   B  ,~   Z` XD  ,~   LR  (X . 1)
(Y . 1)
7
ERRORX
4
(LIST2 KNIL SKNLST ENTER2)           @    0      
RPLACD BINARY
               -.           Z`  -,   +   
2B   +   Z` 3B   +   ,<  ,<   ,   B  ,~   ,<  ,<   ,   B  ,~   Z` QD  ,~   LR  (X . 1)
(Y . 1)
7
ERRORX
4
(LIST2 KNIL SKNLST ENTER2)           @    0      
RSH BINARY
     	        -.            `  ,>  ,>    ` "       ,^   /   (  ,   ,~          (N . 1)
(M . 1)
(MKN BHC ENTER2)   p    `      
SETA BINARY
    ^    V    [-.           V,<`  "  W3B   +   * ` ,>  T,>   Z`  ,<   ^",<   ,   .  T    ,^   /   3b  +    ` ,>  T,>   Z`  ,<   ^",<   ,   3B  U+   Z`  ,<   ^",<   ,   +   Z`  ,<   ^",<   ,   /"       ,^   /   2"  +   Z`  ,<    ` .  U,<   Z` ,   +   S ` 1b   +   (Z`  ,<   ^",<   ,   /"   ,>  T,>    `     ,^   /   3b  +   (Z`  ,<    ` .  U,<    ` ,   +   S,<  X,<` $  X+   SZ`  -,   +   .,<   B  Y,\  3B  +   1,<  Y,<`  ,   B  Z+   S ` ,>  T,>   Z`  ."   Z  .  T    ,^   /   3b  +   D ` ,>  T,>   [`  3B  U+   ;[`  +   ;Z`  /"       ,^   /   2"  +   DZ`  ,>  T,>    ` .Bx  ,^   /   ."   Z` XD  +   S ` 1b   +   QZ`  /"   ,>  T,>    `     ,^   /   3b  +   QZ`  ,>  T,>    ` .Bx  ,^   /   ."   ,<   Z` ,   ,\   B  +   S,<  Z,<` $  XZ` ,~            ! 0@"  D6)M)P @      (A . 1)
(N . 1)
(V . 1)
SWPARRAYP
"out of bounds SETA"
ERROR
ARRAYBEG
28
ERRORX
"out of bounds SETA"
(GUNBOX LIST2 SKAR FFNCLR FFNCLA FFNOPD BHC FFNOPA KNIL ENTER3)  
      @      @   (     N 	  B ` 6 @             8      
SETD BINARY
    ^    V    [-.           V,<`  "  W3B   +   * ` ,>  T,>   Z`  ,<   ^",<   ,   .  T    ,^   /   3b  +    ` ,>  T,>   Z`  ,<   ^",<   ,   3B  U+   Z`  ,<   ^",<   ,   +   Z`  ,<   ^",<   ,   /"       ,^   /   2"  +   Z`  ,<    ` .  U,<   Z` ,   +   S ` 1b   +   (Z`  ,<   ^",<   ,   /"   ,>  T,>    `     ,^   /   3b  +   (Z`  ,<    ` .  U,<    ` ,   +   S,<  X,<` $  X+   SZ`  -,   +   .,<   B  Y,\  3B  +   1,<  Y,<`  ,   B  Z+   S ` ,>  T,>   Z`  ."   Z  .  T    ,^   /   3b  +   D ` ,>  T,>   [`  3B  U+   ;[`  +   ;Z`  /"       ,^   /   2"  +   DZ`  ,>  T,>    ` .Bx  ,^   /   ."   Z` QD  +   S ` 1b   +   QZ`  /"   ,>  T,>    `     ,^   /   3b  +   QZ`  ,>  T,>    ` .Bx  ,^   /   ."   ,<   Z` ,   ,\   B  +   S,<  Z,<` $  XZ` ,~            ! 0@"  D6)M)P @      (A . 1)
(N . 1)
(V . 1)
SWPARRAYP
((QUOTE "out of bounds SETD") . 0)
ERROR
ARRAYBEG
28
ERRORX
"out of bounds SETD"
(GUNBOX LIST2 SKAR FFNCLR FFNCLD FFNOPD BHC FFNOPA KNIL ENTER3)   
      @      @   (     N 	  B ` 6 @             8      
SETSYNTAX BINARY
   !   ~   -.          ~Z`     +   ,   4"   `  1b  ?+   ,<  ,<`  ,   B  +   B 0B   +   ,<`  " XB`  +   ,<  ,<`  ,   B  Z` -,   +   ,<`  ,<` " XB` D ,<   Z` 3B +   3B +   2B +   |[` -,   +   ,<  ,<` ,   B  ,< ,< ,<   ,<   ,< ,<   ,<   [` XBwZw-,   +   O[w-,   +   !+   OZw2B +   'Zw~2B   +   PZw~3B   +   &+   PZ   XBw}+   M2B +   .Zw}3B   +   PZw~3B   +   ,+   PZ   XBw}Z   XBw~+   M2B +   5Zw}3B   +   PZw~3B   +   3+   PZ   XBw}Z   XBw~+   M3B +   72B +   ;Zw2B   +   9+   PZ   XBw+   M3B +   =2B +   @Zw2B   +   ?+   PZ   XBw+   M3B 	+   B2B 	+   FZw}2B   +   D+   PZ   XBw}+   M3B 
+   H2B 
+   KZw}2B   +   J+   PZ   XBw}+   M,<  ,<` ,   B  [wXBw+   Zp  /   +   Q/   +   y[p  2B   +   wZp  3B   +   wZ` ,> },>    `  .Bx  ,^   /   ."  ,<   Zw}3B   +   [^"  @+   \^"   ,> },>   Zw~3B   +   _^"  +   `^"   GBx  Zw~3B   +   c^"  +   c^"   GBx  Zw2B   +   f^"  +   g^"   GBx  Zw}3B   +   j^"  +   j^"   GBx  Z` 2B +   m^"  +   r2B +   o^"  +   r2B +   q^"  +   r  ,   GBx  ,^   /       ,\   QD  Zp  XD  +   {,<  ,<` ,   B  +   {,< ,<` $ /  +   ~,<  ,<` ,   B  ,\   ,~   ,< ~,<   Z` 2B +  ^"  @XBw^"  P+  2B +  ^"   XBw^"  0+  Z   XBp  3B   +  ,<`  ,<` " XB` D ,<    `  ,> },>   Z` .Bx  ,^   /   ."  XB`  [  ,> },>   ZwABx  ,^   /   0B   +  Z`  ZwQD  ,\   +    Z` 2B +  ^"  Q+  *2B +  ^"  P+  *2B +  ^"  Q+  *2B +  ^"  R+  *2B +  !^"  X+  *2B +  #^"  +  *2B +  %^"  P+  *2B +  '^"  0+  *2B +  )^"   +  *Z   XBp  3B   +  4,<`  ,<` " XB` D ,<    `  ,> },>   Z` .Bx  ,^   /   ."  ZwQD  ,\   +    Z` 2B +  J,<`  ,<` " XB` D XB` 3B +  I2B +  <^"  +  E2B +  >^"  +  E2B +  @^"  +  E2B +  B^"  +  E2B +  D^"  +  E  ,   ,> },>   Z` .Bx  ,^   /       ^" t B  Z` +    3B +  L2B +  M^"  +  X3B +  O2B +  P^"  +  X2B +  R^"  +  X3B +  T2B +  U^"  +  X2B +  W^"  +  XZ   XBp  3B   +  p,<` " XB` ,> },>   Zp  .Bx  ,^   /   XB` Z  ,   XBp  1B t+  a+  bZ   ,<    `  A"  ?,<   ,<` " ."  ,\  Q"}3D  +  h*b f7       2B   +  l,<`  ,< ,<` & Z` ,<   Z`  ,   ,\   B  ,\   +    Z` 3B   +  w3B   +  w2B +  t+  wB 2B   +  w,<` " 3B   +  z,<`  ,<` $ XB` /  +   ,<` ,<` $ XB` /  +          Lu2%?dldadasyOIJ T((((]l g,@  7;]]nDR /;]m }o] ( _*$         (CH . 1)
(CLASS . 1)
(TABLE . 1)
27
ERRORX
NCHARS
CHCON1
GETREADTABLE
GETSYNTAX
MACRO
SPLICE
INFIX
1
0
ALWAYS
FIRST
ALONE
IMMED
IMMEDIATE
NONIMMED
NONIMMEDIATE
ESC
ESCQUOTE
NOESC
NOESCQUOTE
HELP
"Conflicting readmacro options"
ERROR
BREAK
SEPR
LEFTBRACKET
RIGHTBRACKET
LEFTPAREN
RIGHTPAREN
STRINGDELIM
ESCAPE
BREAKCHAR
SEPRCHAR
OTHER
NONE
GETTERMTABLE
CHARDELETE
LINEDELETE
RETYPE
CNTRLV
EOL
DELETECHAR
DELETELINE
CTRLV
SETSYNTAX
ORIG
READTABLEP
TERMTABLEP
(MKN URET2 IUNBOX BHC KT KNIL SKNLST SKLST ASZ LIST2 GUNBOX SMALLT ENTER3)      K P   E 0   Xz hH ( x | H X 
 P   r  e 	 E h : P 1 ` * p   xu j b X 8*   i   ^ ( T 
0 K @ @  4 ( - 8 % @  H  0         p    	    ~  M    x   h            
SETPROPLIST BINARY
            -.           Z`  2B   +   Z` 3B   +   ,<  ,<   ,   B  ,~   -,   +   
Z` QD  [  ,~   ,<  ,<   ,   B  ,~   2! (ATM . 1)
(LST . 1)
6
ERRORX
14
(SKLA LIST2 KNIL ENTER2)         h    H        
SMALLP BINARY
        
    -.           
Z`  (B{Z  A"  ."   ,<   Z"   (B{Z  A"  ."   ,\  2B  +   	Z`  ,~   Z   ,~      (N . 1)
(KNIL ASZ TYPTAB ENTER1)   (    x   H    h        
STRPOS BINARY
    5    /    3-.     0      /Z`  -,   +   ."  [  XB`  +   -,   +   B  2XB`  Z` -,   +   -,   +   ."  [  XB` +   B  2XB` Z` 3B   +   ,<` "  3,   7    O   ,>  .,>   Z`  ,   ,>  .,>  ,>  .,>  Z` 3B   7  /,       Z` ,   ,>  .,>  ,>  .,>  7`  ..   4n  ,/(?4h  ,/.   &.  .N7    `=0  @   Z` 2B   O     
} ~1(0  +   ,<,  )    0B  3B|+   $5N  ,<h  ,`+   ! x  Z` 2D   .~/"',   +   -    /  ,~   ,~           1"(BE CP  (PAT . 1)
(STRING . 1)
(START . 1)
(SKIP . 1)
(ANCHOR . 1)
(TAIL . 1)
MKSTRING
CHCON1
(BHC MKN IUNBOX UPATM GUNBOX KNIL SKNSTP SKLA ENTER6)  .    ,         0       X +   `        	  0      
STRPOSL BINARY
      ;    5    9-.           5Z`  -,   +   ,<   ,<` Z   F  8XB`  +   Z` 3B   +   Z`  Z  L  F L  F L  F L  F Z   XB` Z  XB`  Z`  .  3,>  3,>   ,>  3,>  4@@x  Z` 3B   +   ,   /"    Bx  5"  ,<` "  8,   ,>  3,>    ` .Bx  ,^   /    Bx  Z` -,   +    Z`    (  4d"|&"  $  5.$A`Q  +   %-,   +   $Z` [ Q"A`   +   %B  9XB` +   ,^  /   4$  //  4h  /"  S  4D  ,.  &$  .  4F  ,`   =f  +   &$   x  ($  4$  0*h  ,Z   +   2Z  ."   ,   /  ,~             *<    @ ($PRHPh      (A . 1)
(STR . 1)
(START . 1)
(NEG . 1)
(VARIABLE-VALUE-CELL STRPOSLARRAY . 27)
MAKEBITTABLE
NCHARS
MKSTRING
(MKN SKLA SKSTP BHC IUNBOX GUNBOX KNIL SKNAR ENTER4)  (      @   0 ' (   x   H     X            
MAKEBITTABLE BINARY
        !         -.           Z` -,   +   B  ,   0b  +   ,<  ,<  $  XB` Z` 3B   7  "$   Z`  D  D  D  D A$  ,>  ,>  Z`  -,   +   Z`  -,   +   Z`  B  ,   +   ,   A"  ?    &$  Z` .(     ("  l"  j"x  "  ("   B   [`  XB`  +   /  Z` ,~           J     (L . 1)
(NEG . 1)
(A . 1)
ARRAYSIZE
4
ARRAY
CHCON1
(BHC SKNNM SKLST KNIL IUNBOX SKAR ENTER3)  0       h      0   H    0      
SUB1 BINARY
            -.            `  .  ,   ,~       (X . 1)
(MKN ENTER1)          
TYPEP BINARY
             -.           Z`  (B{Z  A"  ."   Z` 2B  7   Z   ,~       (DATUM . 1)
(N . 1)
(KT KNIL ASZ TYPTAB ENTER2)   h    `    H    8      
ZEROP BINARY
                -.           Z`  0B   7   Z   ,~       (X . 1)
(KT KNIL ASZ ENTER1)   @    8    0      
DOCOLLECT BINARY
        
    -.           
Z` -,   +   Z`  ,   XB`     QD  ,~   ,<   Z`  [` ,       ,\   QD  [  ,~       (ITEM . 1)
(LST . 1)
(CONS CONSNL SKNLST ENTER2)     H    0      
ENDCOLLECT BINARY
        	        -.           Z`  2B   +   Z` ,~   [`  ,<   Z`  Z` QD  ,\   ,~       (LST . 1)
(TAIL . 1)
(KNIL ENTER2)          
(PRETTYCOMPRINT BASICCOMS)
(RPAQQ BASICCOMS ((DECLARE: FIRST (P (MOVD? (QUOTE ARRAY) (QUOTE OLDARRAY)) (SETQ NOSWAPFNS (CONS (
QUOTE SETA) NOSWAPFNS)))) (FNS ALLOCSTRING CAAR CADR CDAR CDDR CAAAR CAADR CADAR CADDR CDAAR CDADR 
CDDAR CDDDR CAAAAR CAAADR CAADAR CAADDR CADAAR CADADR CADDAR CADDDR CDAAAR CDAADR CDADAR CDADDR CDDAAR
 CDDADR CDDDAR CDDDDR) (FNS ABS ADD1 ARRAY ARRAYSIZE ARRAYORIG HARRAYSIZE BOUNDP DELETECONTROL 
DIFFERENCE DRIBBLE ECHOCONTROL EVQ FASSOC FGETD FLAST FLENGTH FMEMB FNTH FDIFFERENCE FIX FIXP FMINUS 
FLOAT FUNCTION GETPROPLIST GETSYNTAX GETSYNREADTABLE GETSYNTERMTABLE GETSYNTAXP IDIFFERENCE ILESSP 
IMINUS LESSP LRSH NEQ NILL NLISTP RELSTKP RPLACA RPLACD RSH SETA SETD SETSYNTAX SETPROPLIST SMALLP 
STRPOS STRPOSL MAKEBITTABLE SUB1 SYNTAXP TYPEP ZEROP DOCOLLECT ENDCOLLECT) (P (COND ((EQ (GETTOPVAL (
QUOTE BINCOMPFLG)) (QUOTE NOBIND)) (MAPC (QUOTE ((DECLARE . QUOTE) (MAKEPDQ) (SETCV))) (FUNCTION (
LAMBDA (X) (PUTD (CAR X) (GETD (CDR X)))))) (COND ((EXPRP (GETD (QUOTE LAPRD))) (PUTDQ STRPOS (LAMBDA 
(X Y START SKIP ANCHOR TAIL) (COND ((LITATOM X) (SETQ X (CDR (VAG (IPLUS (LOC X) 2))))) ((NULL (
STRINGP X)) (SETQ X (MKSTRING X)))) (COND ((STRINGP Y)) ((LITATOM Y) (SETQ Y (CDR (VAG (IPLUS (LOC Y) 
2))))) (T (SETQ Y (MKSTRING Y)))) (COND (SKIP (SETQ SKIP (NTHCHAR SKIP 1)))) (COND (START (COND ((
MINUSP START) (SETQ START (IPLUS START (NCHARS Y) 1))))) (T (SETQ START 1))) (SETQ Y (SUBSTRING Y 
START)) (PROG ((N START) W X1 Y1) L2 (SETQ X1 (SUBSTRING X 1)) (SETQ Y1 (SUBSTRING Y 1)) LP (COND ((
SETQ W (GNC X1)) (COND ((EQ W (GNC Y1)) (GO LP)) ((EQ W SKIP) (GO LP)) (T (GO NX)))) (TAIL (RETURN (
IPLUS (NCHARS X) N))) (T (RETURN N))) NX (COND (ANCHOR (RETURN))) (COND ((GNC Y) (SETQ N (ADD1 N)) (GO
 L2)) (T (RETURN)))))) (PUTDQ STRPOSL (LAMBDA (L STR) (PROG (TEM) (SETQ STR (MKSTRING STR)) (SOME L (
FUNCTION (LAMBDA (X) (SETQ TEM (STRPOS X STR))))) (RETURN TEM)))) (PUTDQ MAKEBITTABLE (LAMBDA (X) X)))
) (RPAQQ NOLINKMESS T) (RPAQQ BINCOMPFLG T) (RPAQQ BINFIXFLG T) (SETQ STRPOSLARRAY (ARRAY 4 4)) (RPAQQ
 OCOREVALS NOBIND) (RPAQQ SCOREVALS NOBIND))) (RELSTK (SETQ BOUNDPDUMMY (STKNTH -1)))) (GLOBALVARS 
STRPOSLARRAY) (LOCALVARS . T) (BLOCKS (SYNTAXP SYNTAXP (NOLINKFNS . T)) (GETSYNTAX GETSYNTAX 
GETSYNREADTABLE GETSYNTERMTABLE GETSYNTAXP (NOLINKFNS . T))) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE 
DONTCOPY COMPILERVARS (ADDVARS (NLAMA) (NLAML FUNCTION) (LAMA NILL)))))
(COND ((EQ (GETTOPVAL (QUOTE BINCOMPFLG)) (QUOTE NOBIND)) (MAPC (QUOTE ((DECLARE . QUOTE) (MAKEPDQ) (
SETCV))) (FUNCTION (LAMBDA (X) (PUTD (CAR X) (GETD (CDR X)))))) (COND ((EXPRP (GETD (QUOTE LAPRD))) (
PUTDQ STRPOS (LAMBDA (X Y START SKIP ANCHOR TAIL) (COND ((LITATOM X) (SETQ X (CDR (VAG (IPLUS (LOC X) 
2))))) ((NULL (STRINGP X)) (SETQ X (MKSTRING X)))) (COND ((STRINGP Y)) ((LITATOM Y) (SETQ Y (CDR (VAG 
(IPLUS (LOC Y) 2))))) (T (SETQ Y (MKSTRING Y)))) (COND (SKIP (SETQ SKIP (NTHCHAR SKIP 1)))) (COND (
START (COND ((MINUSP START) (SETQ START (IPLUS START (NCHARS Y) 1))))) (T (SETQ START 1))) (SETQ Y (
SUBSTRING Y START)) (PROG ((N START) W X1 Y1) L2 (SETQ X1 (SUBSTRING X 1)) (SETQ Y1 (SUBSTRING Y 1)) 
LP (COND ((SETQ W (GNC X1)) (COND ((EQ W (GNC Y1)) (GO LP)) ((EQ W SKIP) (GO LP)) (T (GO NX)))) (TAIL 
(RETURN (IPLUS (NCHARS X) N))) (T (RETURN N))) NX (COND (ANCHOR (RETURN))) (COND ((GNC Y) (SETQ N (
ADD1 N)) (GO L2)) (T (RETURN)))))) (PUTDQ STRPOSL (LAMBDA (L STR) (PROG (TEM) (SETQ STR (MKSTRING STR)
) (SOME L (FUNCTION (LAMBDA (X) (SETQ TEM (STRPOS X STR))))) (RETURN TEM)))) (PUTDQ MAKEBITTABLE (
LAMBDA (X) X)))) (RPAQQ NOLINKMESS T) (RPAQQ BINCOMPFLG T) (RPAQQ BINFIXFLG T) (SETQ STRPOSLARRAY (
ARRAY 4 4)) (RPAQQ OCOREVALS NOBIND) (RPAQQ SCOREVALS NOBIND)))
(RELSTK (SETQ BOUNDPDUMMY (STKNTH -1)))
(PUTPROPS BASIC COPYRIGHT ("Xerox Corporation" 1983 1984))
NIL
