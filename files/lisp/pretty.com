(FILECREATED "31-Dec-84 02:44:20" ("compiled on " <NEWLISP>PRETTY..170) (2 . 2) brecompiled changes: CHANGEFONT in 
"INTERLISP-10  14-Sep-84 ..." dated "14-Sep-84 00:05:07")
(FILECREATED "13-Sep-84 08:56:05" {ERIS}<LISPCORE>DIG>PRETTY.;2 97890 changes to: (VARS PRETTYCOMS) (MACROS CHANGFONT) (FNS 
CHANGEFONT) previous date: " 1-Sep-84 14:45:08" {ERIS}<LISPCORE>SOURCES>PRETTY.;11)

CHANGEFONT BINARY
              -.          Z   3B   +   Z   b  2B   +   7   Z   ,<   @     +   
Z   ,<   Z  d  ,~   ,~   Z   ,~   Q"  (VARIABLE-VALUE-CELL FONTCLASS . 16)
(VARIABLE-VALUE-CELL FILE . 18)
(VARIABLE-VALUE-CELL FONTCHANGEFLG . 3)
(NIL)
(LINKED-FN-CALL . DISPLAYP)
(VARIABLE-VALUE-CELL FILEFLG . 0)
(NIL)
(LINKED-FN-CALL . CHANGFONT)
(KT KNIL ENTERF)         h   0      
PRINTCOPYRIGHT BINARY
    X    D    V-.         ( D,<`  ,<  G$  H,<   Z   3B   +   8Zp  2B   +   8Z   ,<  ,<  H,<  I,<`  ,<  I&  J,<   Z   ,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +    Zw,<   Zp  ,<   ,<  J,<  KZw~,<   ,<  K[w}Z  F  J,<   ,<  L[w}Z  ,<   ,<  L,<   ^"  ,   /   Zp  ,   XBp  [wXBw+   /  ,<   Z   ,<   Z  
D  MXBw~3B   +   0,<  HZ  !,<  ,<  M$  J,<   ,<  K,<  N[w|Z  ,<   ,<  N&  J,<   ,<  O,<   ,<  L[wzZ  ^,  ,   +   0Z  OZ   ,   D  P,<   ,<   ,<   ,  PXBp  3B   +   8,<`  ,<  G,   XBwF  QZp  3B  Q+   C,<  R   R,<   ,<  S,<  S&  TD  T,<   ,<p  [wD  U2B   +   B,<wZw,   D  P/   ,<p  "  UZ   +    6CD A31T	Ko
      (FILENAME . 1)
(VARIABLE-VALUE-CELL COPYRIGHTFLG . 7)
(VARIABLE-VALUE-CELL DWIMWAIT . 13)
(VARIABLE-VALUE-CELL COPYRIGHTOWNERS . 69)
(VARIABLE-VALUE-CELL DEFAULTCOPYRIGHTOWNER . 75)
(VARIABLE-VALUE-CELL DEFAULTCOPYRIGHTKEYLST . 97)
COPYRIGHT
GETPROP
%

"Copyright owner for file "
": "
CONCAT
""
EXPLAINSTRING
" - "
RETURN
CONFIRMFLG
ASSOC
"
"
"<LF> - "
" [Default]"
NOECHOFLG
((%
 "No copyright notice now
" EXPLAINSTRING "<LF> - no copyright notice now [Default]" NOECHOFLG T RETURN NIL) . 0)
NCONC
ASKUSER
/PUTPROP
NONE
"19"
DATE
8
9
SUBSTRING
PACK*
MEMBER
PRINTCOPYRIGHT1
(URET1 CONSNL CONS ALIST COLLCT BHC LIST KT SKNLST KNIL ENTER1)   E    B x           p   0 ! `   X   @ 3 X         D   5 P  p   h        
PRINTCOPYRIGHT1A0005 BINARY
             -.           ,<  ,<`  $  ,~       (YEAR . 1)
((FIX . 10738466826) . 0)
PRINTNUM
(ENTER1)     
PRINTCOPYRIGHT1 BINARY
     $        #-.          [`  ,<   ,<   Zw2B   +   Z   XBp  Zw,<   [wXBw,\   ,<w,<   ,<  ,<  ,<  Z  L  Z`  B  Z   3B   +   ,<  "  Zp  3B   +   ,<  ,<   ,<   ,<   ,<   *  ,<   ZwD  !,<  !,<   ,<   ,<   ,<  "*  ,<  ""     #   #Z   +     if;`  (OWNER . 1)
(VARIABLE-VALUE-CELL COPYRIGHTSRESERVED . 25)
"(* Copyright (c) "
" by "
", "
PRINTCOPYRIGHT1A0005
MAPRINT
PRIN1
". All rights reserved."
(("" The following program was created in) . 0)
" "
((FIX . 10738728970) . 0)
PRINTNUM
((" " but has not been published within the meaning of the copyright law, is furnished under license, and may not be used, copied 
and/or disclosed except in accordance with the terms of said license.) . 0)
" "
")"
TERPRI
(URET2 KT KNIL ENTER1)  8    X      x  h  (            
SAVECOPYRIGHT BINARY
               -.          Z   3B  +   
,<   ,<`  ,<  $  XBp  3B   +   	,<  ,<`  ,<  ,<   ,   B  Z   +    Z   ,~   3$  (FILENAME . 1)
(VARIABLE-VALUE-CELL COPYRIGHTFLG . 3)
NEVER
COPYRIGHT
GETPROP
PUTPROPS
PRINT
(URET1 LIST4 KNIL ENTER1) 0      8 
  h        
PRETTYPRINTBLOCK BINARY
   }   5   s-.          5-.     6x@        ,  ,~   -.    @   ,   ,<   Z` -,   Z   ` Ab B2B   +   7   Z   ,<   @ C `0,~   ZwZ8  XB` -,   +   ZwZ8  Z 7@  7   Z  XB` Z` -,   +   ZwZ8  ,~   Z   3B   +   $   ,   XB` ,   ,> 5,>    `      ,^   /   /  1b u+   $Z` XB`  Z` ,<   ,<   ,<    H,< I,<    IZ` XB`   JZ` 3B   +   *,<   ,<` Z   ,   ,   ,   d K,<`  LXB` ZwZ8 3B   +   <,<`  M0B   +   2Z` Z   ,   XB  0+   <0B  +   6Z` Z   ,   XB  4+   <0B  +   9Z` Z   ,   XB  7+   <2B   +   <Z` Z   ,   XB  ;Z` 2B   +   RZwZ8 2B   +  Z` 3B   +  ,<   Zp  -,   +   KZp  Z 7@  7   Z  2B N+   J,<p  ,<   Z   f Ob P3B   +   KZ   +   LZ   /   3B   +  Z` Z 7@  7   Z  ,<   ,< Q Q+  b R2B   +   T+  Z   3B   +   V,<`  SZwZ8 3B   +   fZ   3B   +   fZ   2B T+   \+   f3B   +   ^2B U+   `,<`  R2B   +   f+   d-,   +   dZ` Z  Z,   2B   +   f,<` , P3B   +   f+  Z   3B   +   i2B U+   k,<`  R2B   +   ~+   u2B T+   m+   ~2B U+   sZwZ8 3B   +   u,<` Z   d V2B   +   ~+   u,<` d V2B   +   ~[` [  Z  XB` Z  ,<   Z   d W3B   +  [` Z  2B X+  ,< X,<`  V3B   +  @ Y  +  Zw~,<8  YZw~XB8 ,~   Z   3B   +  Z   3B   +  ,< Z IZ b [,<`  HZ   b [  J+  ,< Z I,<`  \,<` ,< Q,< ],<   Z   j Q,< ] IZ` 3B   +  [` Z  [  ,<   Z  (,   ,   d ^  J[` XB` +   Z  3B   +  Z  X3B   +  ,<` , P3B   +  +  ZwZ8 2B   +  +,<`  _XB` 3B   +  +,<` ,<   ,< ` `,<` ,< a b3B   +  '+   *Z` Z c,   ,<   ,<   ,<    \+  AZ   3B   +  AZ` 2B   +  A,<` ,< cZ   ,<  Zw}Z8 3B   +  3Z   +  4Z   ,<   ,<` 
 dXB` 3B   +  AZ` 3B  +  A,<` XB` d eZ` 3B   +  =[` Z  Z` XD  ZwZ8 3B   +   *Z   XB   +   *Z` Z f,   ,<   ,<    fZ   3B   +  H,< g,<` ,<   Z DZ  h hZ` 3B   +  NZ` ,<   ,< Q iXB` b ^,<` ,<`  ^[` XB` +   ,<   ,<   Z   2B   +  S+  Y,<w,<   ,<   , 3B   +  WZw+    Z Q2B   +  kZ   +    Z b jXBp  3B k+  ]2B   +  _Z   Z W,   XB ]+  X2B Z+  iZ Yb jXBp  2B k+  fZ ^2B   +  kZ   ,   XB c+  kZ `,<  ,< Z l+  YZ f,<  d l+  YZ ib jXBp  2B ]+  n+  Y3B Z+  q2B m+  p+  q  mZ k,   /"   ,   XBwZ qb jXBp  Z s,<  ,<w nZ ub lZp  Zw2B  +  ~,<  ,<wZ w,   ,   ,<   , +  V,<   ,<wZ {,   ,   ,   ,   Z e,   XB +  k,<   Zw2B   +  $Z ,<  Zp  -,   +  	Z   +  Zp  ,<   ,<w/   Zp  -,   +  Z   +  Zp  Zw}2B  +  Zp  XBw+  [p  [  -,   +  Z   +  Zw}[p  [  7   [  Z  Z  1H  +  2D   +  XBw/   3B   +  Zp  +  [p  XBp  +  /   3B   +  #[p  Z  XBw[p  [  XBw+  $Z   +    Z ,<   ,<w~ nZ $b jZw~,<   Z &b oXBw,\  3B  +  0Zw~Zp  ,   ,<   ,<    f,< pZ (,<   ,<    qZ .,<   Z ,<  ,<w~,<w~ rZw~+       $DBPP! ""52D;VBYkxK(i:_,d+
MZJ$@%	M(EPuHNk D"IAD                   (PRETTYPRINTBLOCK#0 . 1)
(VARIABLE-VALUE-CELL PRTTYFILE . 611)
(VARIABLE-VALUE-CELL NLAMLST . 99)
(VARIABLE-VALUE-CELL LAMALST . 106)
(VARIABLE-VALUE-CELL NLAMALST . 113)
(VARIABLE-VALUE-CELL LAM?LST . 120)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 144)
(VARIABLE-VALUE-CELL ADDSPELLFLG . 168)
(VARIABLE-VALUE-CELL SOURCEFILE . 609)
(VARIABLE-VALUE-CELL REPRINTFNS . 196)
(VARIABLE-VALUE-CELL CLISPIFYPRETTYFLG . 205)
(VARIABLE-VALUE-CELL CHANGES . 225)
(VARIABLE-VALUE-CELL COMMENTFLG . 240)
(VARIABLE-VALUE-CELL LAMBDAFONT . 270)
(VARIABLE-VALUE-CELL FONTCHANGEFLG . 265)
(VARIABLE-VALUE-CELL DEFAULTFONT . 274)
(VARIABLE-VALUE-CELL DWIMFLG . 343)
(VARIABLE-VALUE-CELL USERWORDS . 351)
(VARIABLE-VALUE-CELL PRTTYSPELLFLG . 384)
(VARIABLE-VALUE-CELL LISPXHISTORY . 398)
(VARIABLE-VALUE-CELL OLDFILEMAP . 523)
PRETTYPRINT
*PRETTYPRINT*
((UNBOXED-NUM . 3) VARIABLE-VALUE-CELL FNSLST . 286)
(NIL)
(LINKED-FN-CALL . OUTPUT)
(NIL)
(LINKED-FN-CALL . DISPLAYP)
(0 . 1)
(0 . 1)
(VARIABLE-VALUE-CELL FILEFLG . 305)
NIL
NIL
NIL
NIL
NIL
NIL
(NIL)
(LINKED-FN-CALL . PRIN2)
", "
(NIL)
(LINKED-FN-CALL . PRIN1)
(NIL)
(LINKED-FN-CALL . TERPRI)
(NIL)
(LINKED-FN-CALL . TCONC)
(NIL)
(LINKED-FN-CALL . VIRGINFN)
(NIL)
(LINKED-FN-CALL . ARGTYPE)
NOBIND
(NIL)
(LINKED-FN-CALL . STKSCAN)
(NIL)
(LINKED-FN-CALL . RELSTK)
2
(NIL)
(LINKED-FN-CALL . PRINTDEF)
(NIL)
(LINKED-FN-CALL . EXPRP)
(NIL)
(LINKED-FN-CALL . ADDSPELL)
ALL
EXPRS
CHANGES
(NIL)
(LINKED-FN-CALL . MEMB)
(NIL)
(LINKED-FN-CALL . SUPERPRINTEQ)
DECLARATIONS:
CLISPIFY
(NIL VARIABLE-VALUE-CELL FILEPKGFLG . 0)
(NIL)
(LINKED-FN-CALL . CLISPIFY)
%(
(NIL)
(LINKED-FN-CALL . CHANGEFONT)
(NIL)
(LINKED-FN-CALL . PRINT)
FNS
%)
(NIL)
(LINKED-FN-CALL . RPLACD)
(NIL)
(LINKED-FN-CALL . EDITLOADFNS?)
PROP
(NIL)
(LINKED-FN-CALL . LOADFNS)
EXPR
(NIL)
(LINKED-FN-CALL . GETPROP)
((not found) . 0)
70
(NIL)
(LINKED-FN-CALL . MISSPELLED?)
(NIL)
(LINKED-FN-CALL . /RPLACA)
((not printable) . 0)
(NIL)
(LINKED-FN-CALL . LISPXPRINT)
*ERROR*
(NIL)
(LINKED-FN-CALL . LISPXPUT)
(NIL)
(LINKED-FN-CALL . NLEFT)
(NIL)
(LINKED-FN-CALL . RATOM)
STOP
DEFINEQ
(NIL)
(LINKED-FN-CALL . SKREAD)
%[
(NIL)
(LINKED-FN-CALL . SCANFILEHELP)
(NIL)
(LINKED-FN-CALL . SETFILEPTR)
(NIL)
(LINKED-FN-CALL . READ)
"filemap does not agree with contents of"
(NIL)
(LINKED-FN-CALL . ERROR)
(NIL)
(LINKED-FN-CALL . COPYCHARS)
(URET4 CONSS1 CONSNL URET3 FMEMB SKLA CONS ASZ ALIST2 FGFPTR BHC IUNBOX SKNLST KNOB SKA KT KNIL SKLST MKN BINDB BLKENT ENTER1)   &X$        `    W    c    C   -  0_ 0) H 9 X 2    7 8 0    *     Hr ` )    #0 	P         !H X   
  F 8      &. XD 3 0*   ] 	8 $ ( " @   $@ #8 "@ !  Hd `] X `U HR Q  G X? 87 H2 h- p"   8 ( ` h z P r   k ` d   Z  U 
8 M 	H J 	 A   > ( . p  H      	    Ps h *                  
PRETTYPRINT BINARY
            -.           ,<    ,~       (FNS . 1)
(PRETTYDEFLG . 1)
(VARIABLE-VALUE-CELL FNSLST . 0)
PRETTYPRINT
(NIL)
(LINKED-FN-CALL . PRETTYPRINTBLOCK)
(ENTERF)     
PRETTYBLOCK BINARY
      w   >   J-.          >-.    (?HY       :   M   	A   %      '  0  ,  ,~   -.    ]Z   ,<   @ _  ,~   Z   ,<   ,< a,< a,<   @ b ` +   GZ   Z cXB ZwZ8 3B   +   ,< db d,   ,   Z  ,   XB  ZwZ8 3B   +   -,   +     eZwXB8 Z   ,<  Z   ,<  Z   ,<  @ @ ` +   EZwZ8 2B   +   "Z"   ` f,<   Z   ` db g2B   +   &7   Z   ,<   @ h ,~   Z   2B   +   ,Z  2B l7   7   +   -Z  *XB  ,  lZ   XB   Z  -3B   +   2Z   ,<  ,<   , :Z   2B   +   ;Z   3B   +   :Z   ,<  ,<   ,<   ,<   ,<   Z ml n+   DZ  5b o+   DZ   ,<  ,<    pZ  43B   +   BZ  :,<  ,<   ,<   , 1+   DZ  ?,<  ,<   ,  NZ   ,~   Zw~XB8 Z   ,~   3B   +   IZ   +   IZ qXB` d qZ` 3B   +   M  r,~   Z` ,~   -.    sZ   -,   +   kZ   3B   +   kZ  OZ  P,   3B   +   kZ   ,<   @ t  +   kZ  (2B   +   ZZ   3B   +   _Z  T2B   +   _Z   3B   +   _Z   XB  .Z   XB  ZZ  /3B   +   dZ   3B   +   d,<   ,<   , :XB` Z  R,<   Zw~,<8 ,  n,<   Z` 3B   +   j,<   ,<   , :,\   ,~   ,~   Z  d,<   ,<` ,  n,~   -.    uZ  kb v,<   ,<   ,<   Z   3B   +   zZ   2B   +   zZw2B w+   zZ  oZ  q2B  +   z[  v[  XB  xb vXBwZw2B w+  Z  yZ   7   [  Z  Z  1H  +  2D   +   }XBw3B   +  [w,<   Z  |,<    "   ,   XBw2B   +  Z +    Z Zw3B  +  
7   Z   ,<   ZwXB b vXBw~,\   3B   +  +   zZw3B w+  +   ;,> ;,>     eXBw,       ,^   /   2b  +  + w."   ,> ;,>       ,> ;,>   Z ,<   ,<    x,       ,^   /   /  ,   XBp  ,       ,^   /   3b  +  + p  . <,   XBp  ,   ,> ;,>         ,^   /   3b  +  *Z &+  *Zp  ,<   , 9Zw2B w+    ),> ;,>   Z -,   +  1^"  +  :Z  #2B   +  3^"   +  :Z   3B   +  8Z .Z  ,<   ,< y, 3B   +  9^"  +  :^"   .Bx  ,^   /   ,   ,<   @ G   +  Z 13B   +  IZ 33B   +  IZ 5,<   Z   ,<   , 3B   +  I@ y  +  HZ A,<   ,<   , 	A,~   ,~   Z   3B   +  SZwZ8 2B   +  SZ F,<  , "3B   +  S,< z zZ   ZwXB8 Z {Zw~XB?+  V,< | zZ   Zw~XB?Z  s3B   +  zZ   3B   +  iZ L-,   +  ]Z Y."   Z  2B   +  i+  fZ Z-,   +  iZ ]Z  ,<   ,< y, 2B   +  iZ _Z  ,<   ,< |, 2B   +  iZ bZ W,   Zw~XB8  2B   +  rZ  v3B   +  zZ fZ i2B  +  z[ kZ  Zw~XB8  3B   +  z[ m[  XB p3B   +  zZ V2B   +  vZw~Z8  XB q+  zZ kb oZw~,<8  Zw~,<8 ,  N,<   , 9Z u,<   Zw~,<8 ,<   , 1  e,   ,> ;,>         ,^   /   3"  +  @ }  +  ,<   , 9,~   Zw~Z?3B   +  b z,~   ZwZ8 2B   +  ,< } z,~   +  3B ~+  ZwZ   7   [  Z  Z  1H  +  2D   +  [  XBw3B   +  ,<   Z z,<   "   ,   +  Z b o+      ZwZp  3B  7   7   +    Zp  3B   +  &ZwZ   7   [  Z  Z  1H  +  #2D   +  [  Zp  2B  7   Z   +    Z   +        ZwZ 7   [  Z  Z  1H  +  ,2D   +  )[  ,<   ,<w, -2B   +    ,<w,<w, -+    -.    ~Z   ` e,<   Z ?,<   @  `8,~   Z 23B   +  :ZwZ8 2B  +  ;Z 6,~   -,   +  @,<  zZ :,<   ,<   ,  NZ   ,~   Z   XB` Z =XB` Z   3B   +  RZ >3B   +  RZ` 3B   +  R,<` ,< , 'XB` 3B   +  QZ` -,   +  QZ` ,<   Z`  ,<   ,< , 'Z  ,\  2B  +  QZ` +  QZ   XB` Z   XB` Z C3B   +  zZ  _3B   +  zZ` -,   +  zZ` -,   +  ZZ   +  wZ   3B   +  _Z` Z Z,   3B   +  _Z   +  wZ`  Z A2B  +  nZwZ8 2B   +  nZ` Z   ,   2B   +  j,<` Z   -,   Z       ,\   ,   3B   +  kZ ^+  wZ` ."   Z  3B   +  wZ   +  w,<` ,< , '3B   +  uZ` Z   ,   3B   +  tZ   +  wZ   +  vZ   +  wZ YXB` 3B   +  z,<   ,<   , :XB` Z`  ,<   ,< , 3B   +  Z` [`  Z  3B  7   7   +  [ _2B   +  7   Z   +  Z`  ,<   ,< , 2B   +  
Z`  ,<   ,< , 3B   +  Z   +  Z   XB 4,<` [ 2B   +  Zw~Z8 +  Z   ,<   ,  NXB` [ XB Z` 3B   +  ,<   ,<   , :Z ZwZ8 2B  +  +  :-,   +  +  6Z B3B   +  1Z S3B   +  1Z` 2B   +  +  1Z XB` -,   +  a,<   ,< , 'XB` 3B   +  *-,   +  &Z` ,<   Z`  ,<   ,< , 'Z  ,\  2B  +  *+  &,<`  ,<   Z"  ,\  2B  +  VZ ,<   Zw~,<8 , !XB` [ .2B  +  :Z` -,   +  1,< d 	3B   +  1,<` ,< 
 
,<   Z"  /,\  3B  +  1+  #Z` -,   +  F,< d 	3B   +  B,<` ,< 
 
,<   Z"  /,\  2B  +  FZ 1,<   ,<   ,<` ,<   , %2B   +  G,<   , 9+  K,<  [`  Z B2B  +  K  eXB -Z @XB` @   +  U  e,   ."  ,   XB KZ I,<  Zw~,<8 Zw},<8 , 1XB P,~   Z XB` +  Z T-,   Z   [  -,   Z   Z  2B +  aZ`  ,<   ,< , 2B   +  #Z`  ,<   ,< , 3B   +  a+  #Z` -,   +  {Z` -,   +  1,<   Zp  -,   +  nZp  Z 7@  7   Z  2B +  m,<p  ,<   Z   f b 3B   +  nZ   +  oZ   /   2B   +  1Z` Z   ,   2B   +  1,<` ,<  XB` Z q,   3B   +  1Z` 3B +  1,<   ,< , '2B   +  1+  6-,   +  }+  1Z` 3B +   Z` 2B +  Z   XB` ZwZ8 2B   +  1Z   ZwXB8 +  1Z` -,   +  *Z   3B   +  *[`  Z V2B  +  Z` ."   Z  2B   +  *,<` ,< , '2B   +  *+  ,<` Zp  -,   +  Zp  Z 7@  7   Z  2B +  ,<p  ,<   Z kf b 3B   +  Z   +  Z   /   2B   +  *Z` Z q,   2B   +  *,<` ,< 
 XB` Z u,   3B   +  *Z` 3B +  *Z` Z  |7   [  Z  Z  1H  +  (2D   +  %2B   +  *+  6,< ,<`  	3B   +  1,<` ,< 
 
,<   Z"  /,\  3B  +  1+  #[`  Z 2B  +  Z 3B   +  lZ` 3B   +  lZ` Z (7   [  Z  Z  1H  +  ;2D   +  7[  2B   +  =Z` 2B +  >+  #3B +  @2B +  CZ 1,<   Zw~,<8 , V+  ?3B +  E2B +  _,<  ,<   @   +  _,< Z   ,<   ,   ,   Z  ,   XB KXB` ,< ,< a,<   @ b ` +  VZ   Z cXB Z @,<   Zw~,<8 , VZw}XB8 Z   ,~   2B   +  XZ qXB   [` XB L,< Z` Z  [  d Z W3B   +  ^  r,~   Z` ,~   +  ?2B +  bZ   XB` +  l3B +  !2B +  d+  !2B +  g[ Q2B   +  l+  !3B y+  i2B |+  lZ   XB` ,<  +  6Z` -,   +  #Z e,<  ,<   Zw~Z8 -,   +  vZ` 3B   +  u,<  Z` ,<   ,<   , +  vZ   ,<   ,<   , %2B   +  y+  #,<`  ,<   Z"  ,\  2B  +  }+  !,<    eXB P+  6Z` Z K3B  +  Z` -,   +  #2B +  +  #Z mXB` Z` -,   +  ZwZ8 3B   +  #Z` ,<   Z B,<   , 3B   +  +  #Z` -,   +  Z` ,<   Z 
,<   , 3B   +  +  !Z` -,   +  #,<   ,< , '2B   +  !,<` ,< , '3B   +  #+  !Z` -,   +  +  !Z` 3B   +  +  #,<` ,<   ,<   ,<   , %3B   +  #Z   XB` ,<  +  6Z   XB` ,<   , 9+  6Z ~,<   ,<` @  @ +  Zw~Z8 Z 67   [  Z  Z  1H  +  .2D   +  +[  2B   +  1Zw~Z8 3B  +  73B !+  73B !+  73B "+  73B "+  72B #+  I ` ,> ;,>   Zw~Z8 3B  +  ;2B "+  <^"  +  =^"   .Bx  ,^   /   ,   ,<   , 9,   ."   ,   XB &Z ,<  Zw~,<8 [ B,<   ,< Zw},<8 , ,<   , 1XB D,~   3B #+  M3B $+  M3B $+  M2B %+  QZ AXB` [ H,<   ,<   Zw~,<8 , +  [3B %+  S2B &+  U[ N[  +  [[ S,<   Zw}Z8  ,<   ,<  &Z  ,<   Zw~,<8 , Zw~XB8 Z8 Z  3B  +  ^7   Z   ,<   ,\   2B   +  }[ U-,   Z   Z  -,   +  s[ a[  ,<   ,<   ,<   ZwXBp  Zp  -,   +  qZw|Z8 2B  +  k+  qZp  -,   +  pZp  2B   +  oZ   XBw+  q[p  XBp  +  gZw/  +  sZ   ,<   ,\   2B   +  }Z d,<   ,<   Zw},<8 ,<   , %2B   +  z7   Z   ,<   ,\   3B   +    ` ."  ,   ,<   , 9,   +  ,<    e,   ."   ,   XB MZ \Zw~XB8 Z u,<  ,< ,<8  'Z  Zw~XB8 Z ,<  Zw~,<8 Zw},<8 , 1XB 	,~   +  ,<   Zw~Zw3B  +  -,   +  Zw~+    Zw~-,   +  Zw~,<   ,< , -XBp  3B   +  Zw3B   +  Zp  Zw2B  +  +  Zw2B (+   [w~Z  2B +   +  [w~XBw~+  ,< ),<   Zw~Zw3B  +  %-,   +  &Zw~+    Zw~-,   +  )[w~XBw~+  "Zw~,<   Z   d )XBp  [w~XBw~Zp  2B   +  0Zw0B   +  "+  %Zp  2B +  4 w."   ,   XBw+  8Zp  2B +  8 w/"   ,   XBw[p  XBp  +  -    ,<   ZwZ   2B  +  =Z ;+    -,   +  RZ  W3B   +  HZwXBp  3B   +  <,<   Z <-,   Z   Z  ,\  2B  +  F+  <,<p  ,<w *+  S[wZ  XBp  3B   +  <,<   Z B-,   Z   [  Z  ,\  2B  +  P+  <,<p  ,<w +d ,+  S,< -d .Z K,<   Zw~XB S,\   +    -.    /  e,   . <,   ,<   @ 0  ,~   ,<    ."  ,   ,<   @ G   +  fZ ,<   [ `XB a2B   +  dZw~Z8 +  eZ   ,<   ,  N,~   Z a-,   +  h+  ,<   , 9Z f-,   +  k+  Z i-,   +  m+  y,< 2   \."  ,   ,<   @ G   +  xZ k,<   [ rXB s2B   +  vZw~Z8 +  wZ   ,<   ,  N,~   +  f  eXB` Z   XB` Z 3B   +  ,< 2Z sd 	3B   +  Z }XB` 3B   +  ,< 2 Z b o[ XB -,   +  +  Z -,   +  ,<   , 9+  yZ` 3B   +  ,<   ,< 
 
,<   Z"  /,\  2B  +  +  n,<   , 9,< 2 +  n^"  ,> ;,>    ` .Bx  ,^   /   ,> ;,>     e,       ,^   /   /  ,   XB` ,   0"   +  +  h,<`  +  nZ 3B   +  !,< 3 zZ ,<   ,<   ,  NZ   ,~   -.    3Z 3B y+  &2B |+  'Z   ,~   2B 4+  )Z   ,~   Z #,<   ,<   ,< ,<   Zw~XBp  [  XBw~-,   +  /+  +Zp  XBw~-,   +  3:wZw~XBw+  + w,> ;,>     I    ,^   /   3"  +  87   Z   +    Z 33B   +  GZ 3B   +  GZ -,   +  GZ <-,   +  GZ =Z  ,<   Z ,<   , 3B   +  GZ ?,<   ,<   ,  N[ CXB E,<p  , 9+  KZp  2B   +  IZ n,<   ,<   ,<   , MZp  +        Zw2B   +  PZ  ^Z >Z   f` e,<   ,<   ,<   Z T3B   +  VZ  0,<  ,<   , :+  WZ   XBp  Z  ]3B   +  rZ O3B   +  ^Z   3B   +  ^b *Z  [b z+  qZ R2B   +  aZ  X2B 5+  h,<   ,< ) e,< 5 z  O/"   ,   ,<   ,< ),<w}, Z \b z+  q  c,> ;,>    w    ,^   /   3b  +  q  h/"   ,   ,<   ,<w~,<w}, Z gb zZ NXB W  6  ."   ,   XB sZ   3B   +  z,<   ,<w~Z I,<  Z E,<   "  ,   Zw}3B   +  ~,<   ,< ),<w}, Zp  3B   +  ,<   ,<   , :/  ,\   b f+    ,<   ,<   Z Y3B   +  Z   3B   +  Zw2B   +   w~&"  ,   XBw,<    w}&"  ,   XBw,\  3B  +   p  ,> ;,>    w    ,^   /   /  ,   ,<   ,<    w1b   +  ,< 7 zXBp   w/"   ,   XBw+  Zp  /   w~&"     ,   b ,<   ,<w} e+  $ w~,> ;,>    w~    ,^   /   /  ,   b Z   +         , &,~   -.    7Z` 2B   +  *  m+  *,   ,> ;,>     e,       ,^   /   /  /"   ,   ,<   Z  =3B   +  : p  ,> ;,>       ."      ,^   /   3b  +  9,<`  ,<w,<` ,<   , =+    Z   +    ,<`  ,<w,<` , a+    ,< ),<   Zw}-,   +  AZw~2B  +  HZ 02B   +     w,> ;,>    w~    ,^   /   2"  7   Z   +    Zw}-,   +  XZp  3B   +  _ w,> ;,>    w~,> ;,>           ,^   /   2"  +  TZw},<   ,<    x,   +  T  3."   .Bx  ,^   /   ,   XBw+  _Zw},<   Zw~2B   +  [Zw},<   ,<   , a2B   +  ^Z   +    Z   XBp  [w}XBw}+  >,<   Zw~,<   Z @,<   , 3B   +  fZ   +    Zw~-,   +  tZw~,<    w~/"   ,   XBw~,<   ,<   , a3B   +    [w~2B   +  oZ   +    [w~,<    w~/"   ,   ,<   ,<w~,<   , =+     w,> ;,>   ^"  ,> ;,>    w,> ;,>     N    ,^   /   2"  +  Zw~,<   ,<    xXBp  ,   +  	Z   XBp  ,   ."  .Bx  ,^   /       ,^   /   2"  +  	Z   +    [w~2B   +  		Z   +    Zw~2B +  	 w. =,   XBw3B   +    +  	22B +  	 w. =,   XBw w1b  
7   7   +    +  	23B y+  	2B |+  	 w. =,   XBw w1b  7   7   +    +  	22B +  	' w. =,   XBw w,> ;,>   ^"  ,> ;,>     T.Bx  ,^   /       ,^   /   3b  7   7   +    +  	2 w,> ;,>    p  ."      ,^   /   /  ,   XBw,   ,> ;,>     ."       ,^   /   3b  7   7   +    [w~,<   ,<w~,<w~,<w},< , -XBw}Z  3B +  	9Zw}2B +  	? w},> ;,>    w~."       ,^   /   /  ,   +  	?Z   ,<   , =+        Z 3B   +  	DZ ^+  	FZ 	C2B l7   Z   ,<   @ @   +  
WZw~Z8  3B   +  	KZ )+  	KZ   ,<   Zw~Z8  3B   +  	OZ x+  	OZ   ,<   @ 8 @@,~   Z 	D3B   +  	UZ   3B   +  	UZ  +  	VZ   XB` Zw~[?Z  2B =+  	`Zw~[?[  Z  XB` -,   +  	`Zw~[?[  [  2B   +  	`,<`  >Z   3B   +  	eZ 	A2B   +  	eZ 	`b z,~   Zw~Z?XB` [?Z  ,<   Z b,<   , 2B   +  	~Zw~,<? ?,   ,> ;,>           ,^   /   2"  +  	~Z  -,   Z   Z  2B   +  	tZ 	pXB` Z` 2B   +  	xZ 	J2B   +  	x  fXB`  ` ,> ;,>    ` .Bx  ,^   /   &"  ,   XB` +  
Z   XB` Z 	s-,   Z   [  2B   +  
Z"  XB` [` 2B   +  
	Z 	v2B   +  
  f,   +  
,   . =,   XB` ,<   ,<   ,<   , M,<   ,<   ,<   , M ` . >,   XB` Z 
2B   +  
Z` XB 
[` Z  2B @+  
,<` [` [  ,<   Z  B,<   ,<    @d AZ 	Q3B   +  
Z T,<  ,<   , :+  
Z   XB` [ 	NXB 
  eXB` ,   ."  ,> ;,>    `     ,^   /   3b  +  
',<` ,<   ,<   , M+  
, ` ,> ;,>    `     ,^   /   /  ,   b Z` 3B   +  
MZ 	S3B   +  
M,<   ,<   , :,<`  f,<   @ B  +  
K,< DZ I,<   ,   ,   Z X,   XB 
6XB` ,< E,< a,<   @ b ` +  
BZ   Z cXB Zw~,<?Zw|,<8 ,<8 ,<8 , 
WZw|XB8 Z   ,~   2B   +  
DZ qXB [[` XB 
7,< DZ` Z  [  d Z 
C3B   +  
J  r,~   Z` ,~   ,<` ,<   , :+  
PZw~,<?,<` ,<` ,<` , 
WZ` 3B   +  
U,<   ,<   ,<   , M,<   ,<   ,<   , MZw~Z?,~   +    -.    E,<   ,<   ,< | zZ 
-,   +  
]Z 
Zb o+  
`Z 
\,<   ,<` ,<` ,<` , 
W  eXBp  [ 
]XB 
a2B   +  
d+  +-,   +  
g,< F zZ 
bb o+  +Zw3B G+  
y-,   +  
},<   ,< 
 
0B  +  
q p  ,> ;,>    `     ,^   /   3b  +  
}+  
y0B  +  
} p  ,> ;,>    `     ,^   /   3b  +  
}ZwZ   ,   2B   +  
}Z` XBp  ,<   ,<   ,<   , M+  Zw-,   +  Z 
f3B G+  3B H+  3B H+  2B I+  Z 
~b z+  
`Zp  Z` 2B  +  
Z` XBp  ,<   ,<   ,<   , M+  ,<   p  ."   ,   XBp  Z XBw-,   +   p  ,> ;,>    `     ,^   /   3b  +  Z` XBp  ,<   ,<   ,<   , M,<w,<` ,<` ,<` , 
W+  
` p  ,> ;,>   ,<w x,   .Bx  [ 3B   +  ^"   +   ^"   .Bx  ,^   /   ,   XBp  ,   ,> ;,>    `     ,^   /   3b  +  *Z` XBp  ,<   ,<   ,<   , M,<w o+  
`,< } zZ   +    Zw-,   +  :,<w IXBwZw-,   +  3[w-,   +  4Z   +  :ZwZp  2B  +  8[wZ  +  :[w[  XBw+  0+    Z   +       }~{s~IT8`
QIXH1 4a	$$HA
 #j$ Q%Q%#(
$".A$"(0w"@
  (BQ#D%IH(D

h*D4j	$beDuC0^X 6$AFQB[6`DHXAFQ@+U _C~X*DcOsydCCt'B!2[31 OQt J?`?0AI/ (PLYf
	&a0DD xIB$4gB%AT:2eC= "yPI(F!0#Mx+  R A 
 	PT ( (H )
P( @I	 #!hPD@@  	"
J
%   B2  B5!@2"4$U 5 1"LX765Te1`(ix($                                           (PRETTYBLOCK#0 . 1)
(VARIABLE-VALUE-CELL LISPXHIST . 18)
(VARIABLE-VALUE-CELL RESETVARSLST . 2697)
(VARIABLE-VALUE-CELL FONTCHANGEFLG . 2609)
(VARIABLE-VALUE-CELL COMMENTLINELENGTH . 2473)
(VARIABLE-VALUE-CELL FIRSTCOL . 2558)
(VARIABLE-VALUE-CELL CHANGEFLG0 . 2020)
(VARIABLE-VALUE-CELL DEFAULTFONT . 2612)
(VARIABLE-VALUE-CELL PRETTYFLG . 101)
(VARIABLE-VALUE-CELL CHANGESARRAY . 165)
(VARIABLE-VALUE-CELL CHANGEFLG . 2019)
(VARIABLE-VALUE-CELL FILEFLG . 2500)
(VARIABLE-VALUE-CELL DISPLAYTERMFLG . 1983)
(VARIABLE-VALUE-CELL CHANGECHAR . 2017)
(VARIABLE-VALUE-CELL CHANGEFONT . 193)
(VARIABLE-VALUE-CELL CLISPTRANFLG . 492)
(VARIABLE-VALUE-CELL PRETTYTRANFLG . 485)
(VARIABLE-VALUE-CELL PRETTYPRINTMACROS . 1096)
(VARIABLE-VALUE-CELL I . 2031)
(VARIABLE-VALUE-CELL LASTCOL . 2595)
(VARIABLE-VALUE-CELL DEF . 1906)
(VARIABLE-VALUE-CELL FORMFLG . 1909)
(VARIABLE-VALUE-CELL COMMENTFLG . 2512)
(VARIABLE-VALUE-CELL #RPARS . 1897)
(VARIABLE-VALUE-CELL CLISPARRAY . 461)
(VARIABLE-VALUE-CELL PRETTYPRINTYPEMACROS . 540)
(VARIABLE-VALUE-CELL PRETTYEQUIVLST . 1364)
(VARIABLE-VALUE-CELL CRCNT . 2025)
(VARIABLE-VALUE-CELL CLISPFLG . 1782)
(VARIABLE-VALUE-CELL CLISPFONT . 749)
(VARIABLE-VALUE-CELL FONTWORDS . 696)
(VARIABLE-VALUE-CELL USERFONT . 724)
(VARIABLE-VALUE-CELL FNSLST . 711)
(VARIABLE-VALUE-CELL FONTFNS . 716)
(VARIABLE-VALUE-CELL SYSTEMFONT . 731)
(VARIABLE-VALUE-CELL CLISPCHARS . 1088)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 1068)
(VARIABLE-VALUE-CELL FUNNYATOMLST . 1080)
(VARIABLE-VALUE-CELL CLISPIFYPACKFLG . 1037)
(VARIABLE-VALUE-CELL CHCONLST . 1621)
(VARIABLE-VALUE-CELL LASTFONT . 1706)
(VARIABLE-VALUE-CELL TAIL . 2874)
(VARIABLE-VALUE-CELL CHANGECHARTABSTR . 1973)
(VARIABLE-VALUE-CELL ENDLINEUSERFN . 2026)
(VARIABLE-VALUE-CELL PRETTYTABFLG . 2059)
(VARIABLE-VALUE-CELL AVERAGEVARLENGTH . 2370)
(VARIABLE-VALUE-CELL TAILFLG . 2178)
(VARIABLE-VALUE-CELL #CAREFULCOLUMNS . 2290)
(VARIABLE-VALUE-CELL AVERAGEFNLENGTH . 2396)
(VARIABLE-VALUE-CELL COMMENTFONT . 2651)
(VARIABLE-VALUE-CELL **COMMENT**FLG . 2503)
(VARIABLE-VALUE-CELL PRETTYLCOM . 2523)
(VARIABLE-VALUE-CELL EXPR . 2604)
(VARIABLE-VALUE-CELL ABBREVLST . 2799)
PRINTDEF
CHANGFONT
ENDLINE1
COMMENT1
FITP
SUPERPRINTEQ
SUPERPRINTGETPROP
*PRINTDEF*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL EXPR . 0)
((UNBOXED-NUM . 3) VARIABLE-VALUE-CELL DEF . 0)
((UNBOXED-NUM . 4) VARIABLE-VALUE-CELL TAILFLG . 0)
((UNBOXED-NUM . 5) VARIABLE-VALUE-CELL FNSLST . 0)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
OUTPUT
(NIL)
(LINKED-FN-CALL . OUTPUT)
(NIL)
(LINKED-FN-CALL . POSITION)
(NIL)
(LINKED-FN-CALL . LINELENGTH)
(NIL)
(LINKED-FN-CALL . DISPLAYP)
(VARIABLE-VALUE-CELL I . 0)
(VARIABLE-VALUE-CELL LASTCOL . 0)
(VARIABLE-VALUE-CELL FORMFLG . 0)
(VARIABLE-VALUE-CELL FILEFLG . 0)
(NIL VARIABLE-VALUE-CELL HELPCLOCK . 0)
(0 VARIABLE-VALUE-CELL CRCNT . 0)
(NIL VARIABLE-VALUE-CELL CHANGEFLG . 0)
ALL
(NIL)
(LINKED-FN-CALL . COMPUTEPRETTYPARMS)
PRIN2
(NIL)
(LINKED-FN-CALL . MAPRINT)
(NIL)
(LINKED-FN-CALL . PRIN2)
(NIL)
(LINKED-FN-CALL . TAB)
ERROR
(NIL)
(LINKED-FN-CALL . RESETRESTORE)
(NIL)
(LINKED-FN-CALL . ERROR!)
*SUPERPRINT*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL E . 1874)
(VARIABLE-VALUE-CELL CHANGEFLG . 0)
NIL
*SUPERPRINT0*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL E . 0)
(NIL)
(LINKED-FN-CALL . TYPENAME)
LISTP
(NIL)
(LINKED-FN-CALL . NCHARS)
LAMBDA
(NIL VARIABLE-VALUE-CELL TAIL . 0)
%[
(NIL)
(LINKED-FN-CALL . PRIN1)
%]
%(
NLAMBDA
(NIL VARIABLE-VALUE-CELL TAIL . 0)
%)
LITATOM
*SUBPRINT*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL TAIL . 0)
(0 . 1)
(0 . 1)
(0 . 1)
NIL
NIL
NIL
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL FORMFLG . 0)
" . "
CLISPWORD
CLISPTYPE
SELECTQ
COND
QUOTE
(NIL)
(LINKED-FN-CALL . CHCON1)
"_"
(NIL)
(LINKED-FN-CALL . STRPOS)
-1
(NIL)
(LINKED-FN-CALL . NTHCHARCODE)
"_"
1
(NIL)
(LINKED-FN-CALL . SPACES)
(NIL VARIABLE-VALUE-CELL I . 0)
>
_
CREATE
create
NOBIND
(NIL)
(LINKED-FN-CALL . STKSCAN)
(NIL)
(LINKED-FN-CALL . RELSTK)
(NIL)
(LINKED-FN-CALL . NTHCHAR)
<
UNARYOP
IFWORD
FORWORD
EXPR
"_"
PROG
RESETVARS
ASSEMBLE
ASSEM
8
(NIL)
(LINKED-FN-CALL . RADIX)
(VARIABLE-VALUE-CELL OLDVALUE . 2664)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 2703)
RADIX
((DUMMY) . 0)
(NIL)
(LINKED-FN-CALL . APPLY)
SETQ
RESETVAR
FUNCTION
(VARIABLE-VALUE-CELL I . 0)
(0 . 1)
THEN
ELSE
ELSEIF
then
else
elseif
AND
OR
and
or
!
!!
(NIL)
(LINKED-FN-CALL . GETP)
(NIL)
(LINKED-FN-CALL . NLEFT)
RECORDWORD
0
(NIL)
(LINKED-FN-CALL . DUNPACK)
(NIL)
(LINKED-FN-CALL . PRIN3)
(NIL)
(LINKED-FN-CALL . OUTPUTDSP)
(NIL)
(LINKED-FN-CALL . DSPFONT)
"undefined font"
(NIL)
(LINKED-FN-CALL . ERROR)
*PRINTPROG*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL TAIL . 0)
(VARIABLE-VALUE-CELL I . 0)
NIL
NIL
(T VARIABLE-VALUE-CELL FORMFLG . 0)
4
"_"
" . "
*RPARS*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL E . 0)
DEFINEQ
CHAT
%
(NIL)
(LINKED-FN-CALL . TERPRI)
%	
*FITP*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL TAILFLG . 0)
(VARIABLE-VALUE-CELL LASTCOL . 0)
(VARIABLE-VALUE-CELL TAIL . 0)
NIL
NIL
NIL
NIL
NIL
NIL
NIL
NIL
E
(NIL)
(LINKED-FN-CALL . EVAL)
(NIL)
(LINKED-FN-CALL . COUNT)
%%
(NIL)
(LINKED-FN-CALL . COMMENT3)
(NIL)
(LINKED-FN-CALL . /RPLACD)
(VARIABLE-VALUE-CELL OLDVALUE . 0)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 0)
LINELENGTH
((DUMMY) . 0)
*COMMENT2*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL TAIL . 0)
" . "
-
,
;
:
%.
(NIL)
(LINKED-FN-CALL . GETPROPLIST)
(SKNA URET6 URET5 URET1 URET4 LIST2 SKNLA KNOB FMEMB SKA URET2 SKLA SKNLST MKN BHC IUNBOX URET3 EVCC GETHSH SKLST KT ASZ SKNNM CONS 
CONSNL ALIST2 CF KNIL BINDB BLKENT ENTER1)  
~   _	C   %   =0: yP  	3p	@		PpXf w' b8  &`K   ( ?H   B@i   
y D >hr .0i ,P]    )0  7@;5`
X & 0 $x& #P  5p R@ <hd 6@! *xZ   3,P
\	 pPm m0h dX S0q MX< 3<    4(%@
!	}p	,`		(j
x0@P
 ~Po |X n^ k 8 f@ _pB WxP H$ x  4h"20
v.
+$@	| 	>	+P	#P	8W
F`.0( }H7 s ^0? C0p   < " h   #3P
 !
P	-
@-0 rpY `0  XO p%  H   8W g`   { "x   h 
@  6  	rHgx? wX1 uhM h@> ]Pi \@b Qh @hc ;X 4Pg +_ 
  51
|*P
S( 
&$`
!P
p	F(	&(	~xf
0HhK w' _0o [p$ Mxj LV C =h 08  .X& #@t H @ p ^ p = H &   
r-H
 qP0 O8/ 89 5P "   
j   &xL h  &hK X   P  '@Q   7845X*3h1
|/
c+ 
Y*X
T*8
R*
L)
C' 
0%p
-#X
# 
!X
!8

 `
  
x	v8	r(	c 	_h	T0	P`	L 	F0	@ 	& 	X	hthm@e _h]HZ	0G(:1%` X @ x| ~hb {x\ {(Y zxV z@S z(N y8I xPC w@: w, u" t qx
 q  op| o0w nPi lXc iXK hHB h ; eh# c ax} _8z _w ^Xt ]hg \hc \_ Z 0 Uh% T ! T  Sp S R  Qx Nxv NPr Lp] JpO GH; F`4 EH) E" C` C( Bh AH @0 ?0w >0p =xm =8a ;`Z ;G 8`E 8@> 6`$ 3h 38 2@ 1` 1  0@ 0} / x .ht .8q -Xj - e ,0^ +8V *HS * I (hE (8@ 'p8 %x, $p% $0 #H "(
  x Xz (p 0i `b PY xU pL (D ? 5 ( 8 ( H s   q   h 8 b  ] 8 Z  T 
  L 	 H P D  A p 9  8 x 5 @ 2  / @ * p %   0    
Xx# jx2 p O     (      
PRINTDEF BINARY
             -.     0      ,<    ,~       (VARIABLE-VALUE-CELL EXPR . 0)
(LEFT . 1)
(VARIABLE-VALUE-CELL DEF . 0)
(VARIABLE-VALUE-CELL TAILFLG . 0)
(VARIABLE-VALUE-CELL FNSLST . 0)
(FILE . 1)
PRINTDEF
(NIL)
(LINKED-FN-CALL . PRETTYBLOCK)
(ENTERF)      
CHANGFONT BINARY
            -.           ,<    ,~       (FONTCLASS . 1)
(FILE . 1)
CHANGFONT
(NIL)
(LINKED-FN-CALL . PRETTYBLOCK)
(ENTER2)     
ENDLINE1 BINARY
               -.           ,<    ,~       (N . 1)
(INBLOCKFLG . 1)
(NOTABSFLG . 1)
ENDLINE1
(NIL)
(LINKED-FN-CALL . PRETTYBLOCK)
(ENTER3)      
COMMENT1 BINARY
               -.           ,<    ,~       (L . 1)
(INBLOCKFLG . 1)
COMMENT1
(NIL)
(LINKED-FN-CALL . PRETTYBLOCK)
(ENTER2)     
FITP BINARY
            -.            ,<    ,~       (X . 1)
(VARIABLE-VALUE-CELL TAILFLG . 0)
(ENDTAIL . 1)
(LSTCOL . 1)
FITP
(NIL)
(LINKED-FN-CALL . PRETTYBLOCK)
(ENTERF)      
SUPERPRINTEQ BINARY
                -.           ,<    ,~       (X . 1)
(Y . 1)
SUPERPRINTEQ
(NIL)
(LINKED-FN-CALL . PRETTYBLOCK)
(ENTER2)     
SUPERPRINTGETPROP BINARY
              -.           ,<    ,~       (ATM . 1)
(PROP . 1)
SUPERPRINTGETPROP
(NIL)
(LINKED-FN-CALL . PRETTYBLOCK)
(ENTER2)     
COMMENT3 BINARY
             -.           @    ,~   Z   b  3B   +   	Z  b  XB   Z  ,<   [  Z  d  XB   Z   XB  Z  
,<   Z  
b  ,\  XB  [  XB   -,   +   XB  +   
3B   +   Z  ,<  b  ,\  QB  Z  	,~   T     (VARIABLE-VALUE-CELL X . 40)
(VARIABLE-VALUE-CELL FORM . 10)
(VARIABLE-VALUE-CELL FLG . 0)
(NIL VARIABLE-VALUE-CELL Y . 35)
(NIL VARIABLE-VALUE-CELL Z . 28)
(NIL VARIABLE-VALUE-CELL VARS . 18)
(NIL)
(LINKED-FN-CALL . FNTYP)
(NIL)
(LINKED-FN-CALL . COMMENT5)
(NIL)
(LINKED-FN-CALL . APPEND)
(NIL)
(LINKED-FN-CALL . COMMENT4)
(SKLST KNIL ENTERF)        P      
COMMENT4 BINARY
        f    -.         8 f@  j  ,~   Z   -,   +   Z  b  k3B   +   	Z  b  l,   1"  +   $Z  ,<   Z   d  mXB  	+   $2B  n+   Z   XB   Z  ,~   3B  o+   $3B  o+   $3B  p+   $-,   +   +   $b  pXB   ,<   Z"  /,\  2B  +   Z  ,<   ,<  q  rXB  +   $Z  ,<   Z"  ,\  2B  +    Z  ,<   Z  d  sXB  +   $,<  tZ  d  t2B   +   $Z   XB   +   /Z  "-,   +   -,<   ,<  u  v,<   Z"  ,\  2B  +   -Z  $Z   ,   2B   +   ,7   Z   +   .Z   XB  +   Z  #,<   ,<  u  v1B  +   51B  +   51B  +   50B  +   8Z  /,<   ,<  w,<  w  rXB  5+   /0B  )+   FZ  7,<   ,<  w  v,<   Z"  ,\  2B  +   KZ  9,<   ,<  w,<  x  rXB  >Z  ),<  ,<  x,<    t,<   ,<  y  yb  zXB  A+   K0B  +   KZ  @b  p,<   Z"  ,\  2B  +   K+   $Z  GZ   ,   2B   +   cZ  KZ   ,   2B   +   $Z  Nb  k2B   +   $Z  P,<   Zp  -,   +   ]Zp  Z 7@  7   Z  2B  {+   \,<p  ,<   Z   f  |b  }3B   +   ]Z   +   ]Z   /   2B   +   $Z  Rb  ~2B   +   $Z  _Z   ,   2B   +   $Z  E,<   Z  .d  sXB  c+   $*H\8 ET$M*u'
uCj(           (VARIABLE-VALUE-CELL X . 203)
(VARIABLE-VALUE-CELL FORM . 20)
(VARIABLE-VALUE-CELL FLG . 201)
(VARIABLE-VALUE-CELL ABBREVLST . 84)
(VARIABLE-VALUE-CELL LCASELST . 152)
(VARIABLE-VALUE-CELL UCASELST . 157)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 179)
(VARIABLE-VALUE-CELL VARS . 195)
(NIL VARIABLE-VALUE-CELL Y . 194)
(NIL VARIABLE-VALUE-CELL TEM . 52)
(NIL)
(LINKED-FN-CALL . GETD)
(NIL)
(LINKED-FN-CALL . LENGTH)
(NIL)
(LINKED-FN-CALL . COMMENT3)
-
^
%%
'S
(NIL)
(LINKED-FN-CALL . CHCON1)
2
(NIL)
(LINKED-FN-CALL . SUBATOM)
(NIL)
(LINKED-FN-CALL . L-CASE)
=
(NIL)
(LINKED-FN-CALL . STRPOS)
-1
(NIL)
(LINKED-FN-CALL . NTHCHARCODE)
1
-2
-3
"'S"
"'s"
(NIL)
(LINKED-FN-CALL . RPLSTRING)
(NIL)
(LINKED-FN-CALL . MKATOM)
NOBIND
(NIL)
(LINKED-FN-CALL . STKSCAN)
(NIL)
(LINKED-FN-CALL . RELSTK)
(NIL)
(LINKED-FN-CALL . GETPROPLIST)
(BHC KNOB FMEMB SKLA ASZ SKNLA KT IUNBOX KNIL SKLST ENTERF)   h   
x   0 P 	X +    U X   	  G P 9 P 4 0 2   `   0   P - `      8 a p ^ @ Z 
( P 	` . X , (            
COMMENT5 BINARY
       "        !-.           @    ,~   [   Z  XB   -,   +   ,   +   ,<   Z  b  Z  XB  Z  2B   +   [  Z  ,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   Zw,<   @      +   Z   -,   +   ,~   Z  ,~   Zp  ,   XBp  [wXBw+   /  +   Z   ,   ,~   
#
%  (VARIABLE-VALUE-CELL FORM . 14)
(NIL VARIABLE-VALUE-CELL TEM . 21)
(NIL)
(LINKED-FN-CALL . LAST)
PROG
(VARIABLE-VALUE-CELL X . 47)
(ALIST2 BHC COLLCT SKNLST KNIL CONSNL SKA ENTERF)                       P    h   p        
ENDFILE BINARY
                -.           ,<  Z   d  Z  b  ,~   @   (VARIABLE-VALUE-CELL FILE . 6)
STOP
(NIL)
(LINKED-FN-CALL . PRINT)
(NIL)
(LINKED-FN-CALL . CLOSEF)
(ENTERF)      
ISTTYP BINARY
               -.           Z   2B   +      2B   7   Z   ,~       (VARIABLE-VALUE-CELL FILE . 3)
(NIL)
(LINKED-FN-CALL . OUTPUT)
(KT KNIL ENTERF)    H    P        
MAKEDEFLIST BINARY
    >    1    <-.           1@  3  ,~   Z   ,<   Zp  -,   +   +   0Zp  ,<   @  3   +   .Z   -,   +   &b  4,<   Z  5+   Z  5,<   @  6 @ +   Z`  -,   +   Z   ,~   Z`  ,<   ,<`  /   @  1   +   Z  Z   2B  7   Z   ,~   3B   +   Z`  ,~   Z   ,<   ,<`   "   ,   XB`  +   XB   3B   +   &,<  7Z  ,<  Z  ,<  ,   ,<   [  Z  ,<   Z   ,<   ,<  7  8h  9,~   Z   2B   +   .,<  :Z  #,<  ,<  :,<  ;Z  ,<  ^"  ,   ,<   ,<     ;,~   [p  XBp  +   /   Z   ,~   S:H L 8f      (VARIABLE-VALUE-CELL X . 41)
(VARIABLE-VALUE-CELL PROP . 81)
(VARIABLE-VALUE-CELL FLG . 77)
(NIL VARIABLE-VALUE-CELL TEM . 68)
(VARIABLE-VALUE-CELL Z . 85)
(NIL)
(LINKED-FN-CALL . GETPROPLIST)
CDDR
CDR
(0 . 1)
(VARIABLE-VALUE-CELL MACROF2 . 51)
PUTPROPS
((MACRO EXPR) . 0)
(NIL)
(LINKED-FN-CALL . MEMB)
(NIL)
(LINKED-FN-CALL . PRETTYVAR1)
no
property
for
(NIL)
(LINKED-FN-CALL . PRINT)
(LIST LIST2 EVCC KT BHC KNIL SKLA SKNLST ENTERF)   -    "        . x        1                      
PP BINARY
        +        *-.         Z   ,<   @    ,~   Z   ,<   ,<  ,<   ,<   @    ` +   Z   Z  "XB ,<  ",<     #,   ,   Z  ,   XB  ,<  $,<     $,   ,   Z  ,   XB  Zw,<8    %b  &Zw~XB8 Z   ,~   3B   +   Z   +   Z  'XB` d  (Z` 3B   +      ),~   Z` ,~   *A 0-       (X . 1)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
(VARIABLE-VALUE-CELL RESETVARSLST . 34)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
OUTPUT
(NIL)
(LINKED-FN-CALL . OUTPUT)
SETREADTABLE
(NIL)
(LINKED-FN-CALL . SETREADTABLE)
(NIL)
(LINKED-FN-CALL . NLAMBDA.ARGS)
(NIL)
(LINKED-FN-CALL . PRETTYPRINT)
ERROR
(NIL)
(LINKED-FN-CALL . RESETRESTORE)
(NIL)
(LINKED-FN-CALL . ERROR!)
(CONS CONSNL ALIST2 KT CF KNIL ENTER1)       H          p     	     x   p      
PP* BINARY
     .        ,-.         Z   ,<   @     ,~   Z   ,<   ,<  !,<  ",<   @  " ` +   Z   Z  $XB ,<  $,<     %,   ,   Z  ,   XB  ,<  &,<     &,   ,   Z  ,   XB  @  '  +   Zw,<8    (b  ),~   Zw~XB8 Z   ,~   3B   +   Z   +   Z  *XB` d  *Z` 3B   +      +,~   Z` ,~   *A &i@      (X . 1)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
(VARIABLE-VALUE-CELL RESETVARSLST . 34)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
OUTPUT
(NIL)
(LINKED-FN-CALL . OUTPUT)
SETREADTABLE
(NIL)
(LINKED-FN-CALL . SETREADTABLE)
(NIL VARIABLE-VALUE-CELL **COMMENT**FLG . 0)
(NIL)
(LINKED-FN-CALL . NLAMBDA.ARGS)
(NIL)
(LINKED-FN-CALL . PRETTYPRINT)
ERROR
(NIL)
(LINKED-FN-CALL . RESETRESTORE)
(NIL)
(LINKED-FN-CALL . ERROR!)
(CONS CONSNL ALIST2 KT CF KNIL ENTER1)    X         @   x  0      H          
PPT BINARY
       .        ,-.         Z   ,<   @     ,~   Z   ,<   ,<  !,<  ",<   @  " ` +   Z   Z  $XB ,<  $,<     %,   ,   Z  ,   XB  ,<  &,<     &,   ,   Z  ,   XB  @  '  +   Zw,<8    (b  ),~   Zw~XB8 Z   ,~   3B   +   Z   +   Z  *XB` d  *Z` 3B   +      +,~   Z` ,~   *A &i@      (X . 1)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
(VARIABLE-VALUE-CELL RESETVARSLST . 34)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
OUTPUT
(NIL)
(LINKED-FN-CALL . OUTPUT)
SETREADTABLE
(NIL)
(LINKED-FN-CALL . SETREADTABLE)
(T VARIABLE-VALUE-CELL PRETTYTRANFLG . 0)
(NIL)
(LINKED-FN-CALL . NLAMBDA.ARGS)
(NIL)
(LINKED-FN-CALL . PRETTYPRINT)
ERROR
(NIL)
(LINKED-FN-CALL . RESETRESTORE)
(NIL)
(LINKED-FN-CALL . ERROR!)
(CONS CONSNL ALIST2 KT CF KNIL ENTER1)         H          p     	        p      
PRETTYCOM BINARY
   ]   t   M-.        t@   ,~   Z   2B   +   Z   ,~   Z   3B   +   Z   3B   +   Z   3B   +   ,< Z  ,<  ,   +   ,<  ,<  Z  
,<  ,   ,<   ,<   ,<   ,   b Z  -,   +   /Z  2B   +   ,Z  ,<  Zp  -,   +   Zp  Z 7@  7   Z  2B +   ,<p  ,<   Z   f b 3B   +   Z   +   Z   /   2B   +   ,Z   3B   +   ,Z  ,<  ,< Z   ,<  ,<   Z   ,<  Z l XB   3B   +   ,Z   XB   3B   +   ,Z  'XB  "Z  +,<   Z  d Z  ,,~   Z  -3B   +   1+   .Z   2B   +   JZ  .,<   ,<      ,\   7   [  Z  Z  1H  +   92D   +   6[  XB  +3B   +   JZ  :,<   Z  2,<   ,<   ,<    	,<   [  ;f 
,<   Zp  -,   +   C+   I,<   @    +   HZ   ,<   ,<   Z  Ef ,~   [p  XBp  +   A/   +   .Z  <2B +   Y@   +   YZ  J,<   ,<   ,<    	,<   ,<    Z  )3B   +   X[  MZ  2B +   X[  S[  Z  XB  ?-,   +   Xb ,~   +   .3B +   [2B +   dZ  U,<   ,<   ,<    	,<   Zp  -,   +   `+   cZp  b [p  XBp  +   ^/   +   .2B +  ,<  Z  [,<   ,<   ,<    	,<   @   +  	Z`  XB   Z  k-,   +   m+  Z  k-,   +   |Z  m,<   Z   d 2B   +   yZ  !3B   +  	Z  o,<   ,< Z  p,<   ,<   Z  sj 3B   +  	Z   XB  QZ  vb ,<  +     Z  y,<   ,<   Z  |f Z  ~3B +  3B +  2B +  [  XB 3B   +  Z b ,<  [ XB +   kZ` ,~   +   $  ""   ,   +  q,<  +   .3B +  3B +  2B +  Z  f,<   Z ,<   ,<   ,<    	,   XB  V,<  Z b ,<  +   .3B +  2B +  zZ 2B 7   Z   ,<   [ Z  ,<   [ ,<   ,<   ,<    	,<   @  ` +  yZ -,   +  .,<   Zp  -,   +  &+    Zp  ,<   @    +  ,Z   ,<   Z  F,<  Z  /f  ,~   [p  XBp  +  $3B !+  3Z ),<  ,<   Z +,<  Z h  ,~   ,< !Z   d "3B   +  PZ /,<   Zp  -,   +  8+    Zp  ,<   @ #   +  OZ   ,<   b #,<   @ $  +  LZ`  XB *Z ?-,   +  A+  KZ ?,<   Z   d 3B   +  E+  I,<` Z A,<   [ EZ  ,   d &XB` [ F[  XB I+  ?Z` ,~   ,   ,   Z !,   b ,~   [p  XBp  +  6Z 5,<   Zp  -,   +  S+    Zp  ,<   @ #   +  x,< ',<    Z ;,<   ,<    '  (,   ."   ,   XB "Z Wb #,<   @ )  +  vZ`  XB JZ _-,   +  bZ` ,~   Z `,<   Z Bd 3B   +  f+  tZ [,<   ,<   ,<    +Z b,<   ,<    (,<   ,<   ,<   ,<   ,<    ,< ,<    [ hZ  ,<   ,<    (,<   ,<   ,<   ,<   ,<    [ o[  XB t+  `,< , ,~   [p  XBp  +  Q+   .2B ,+  Z 1,<   ,<    	XB f,<   Zp  -,   +   +  Zp  b [p  XBp  +  ~/   +   .2B -+  Z {,<   ,<   ,<    	,<   Zp  -,   +  	+  Zp  ,<   @    +  Z u-,   +  Z Z   3B  +  ,< -Z ,<   [ ,<   ,<   ,<   
 .,~   ,< -,<   ,<    .,~   [p  XBp  +  /   +   .2B /+  ,Z ,<   ,<   ,<    	,<   Zp  -,   +  +  +Zp  ,<   @    +  ),< /Z -,   +  %,< 0,<   ,   B 0Z  ,<   [ ",<   ,<   ,<   
 .,~   [p  XBp  +  /   +   .2B 1+  ?Z ,<   ,<   ,<    	,<   Zp  -,   +  2+  >Zp  ,<   @    +  <,< 1Z &-,   +  8,< 0,<   ,   B 0Z  ,<   [ 5,<   ,<   ,<   
 .,~   [p  XBp  +  0/   +   .2B 2+  HZ -,<   ,<    	,<   Zp  -,   +  D+  GZp  b 2[p  XBp  +  B/   +   .2B 3+  YZ @,<   ,<    	XB },<   Z   d 4,<   @ {   +  XZ K,<   Zp  -,   +  R+    ,<   @    +  WZ 9,<   ,<   Z Tf ,~   [p  XBp  +  P+   .2B 5+  jZ I,<   ,<    	XB O,<   Z Ld 4,<   @ 5  +  iZ \,<   Zp  -,   +  c+    ,<   @    +  hZ U,<   ,<   Z ef ,~   [p  XBp  +  a+   .3B 6+  l2B 7+  uZ Z,<   ,<   ,<    	XB `,<   ,< 7,<     Z n,<   Z l2B 67   Z   d 8+   .2B 9+  Z r,<   ,<   ,<    	XB q,< 9 Z x,<   Zp  -,   +  }+  Zp  ,<   @    +  Z :Z f,   b ,~   [p  XBp  +  {/   ,< : +   .2B +  <[ vZ  2B +  ,< ;,<    ;Z   ,<   ,< < (+  ,< =,<    w1b   +    XBp   w/"   ,   XBw+  Zp  /  Z   3B   +  Z   3B   +  4+  Z 2B !+  4Z   3B   +  4b =Z   b >,<   @ ?  +  2,< AZ   ,<   ,   ,   Z   ,   XB  XB` ,< B,< B,<   @ C ` +  )Z   Z DXB Z b 'Zw}XB8 Z   ,~   2B   +  +Z EXB   [` XB !,< AZ` Z  [  d EZ +3B   +  1  F,~   Z` ,~   Z   b =+  5Z &b ',< G,<    w1b   +  ;  XBp   w/"   ,   XBw+  6Zp  /  +   .Z 4-,   +  jZ <,<   ,< H H3B   +  jZ >,<   ,<   ,<    	,<   Zp  -,   +  F+  iZp  ,<   @    +  h,< I,<    Z  3B   +  O3B   +  O-,   +  O,<  ,<   ,   ,<   ,<    ',< ,<    Z A3B   +  W3B   +  W-,   +  W,<  ,<   ,   ,<   ,<    ',< ,<    Z J,<   Z Rd J3B   +  `3B   +  `-,   +  `,<  ,<   ,   ,<   ,<    (,<   ,<   ,<   ,<   ,<    ,< K,<    ,<    ,~   [p  XBp  +  D/   +   .Z [,<   ,< Z   ,<   ,<   Z jj 3B   +  qZ   XB  y+   1,< KZ m,<   ,<    L+   !$1T$L	!h$LpFKpT2H(|/br#~@HEPEQ-APA!RpF)
"pFYH\2Rq
B(GD*	!B(O,Eyic	YU 5$"aX`IK%0iX4*aQ$c                          (VARIABLE-VALUE-CELL PRTTYCOM . 995)
(VARIABLE-VALUE-CELL PRTTYFLG . 353)
(VARIABLE-VALUE-CELL PRETTYCOMSTAIL . 75)
(VARIABLE-VALUE-CELL PRTTYFILE . 14)
(VARIABLE-VALUE-CELL LISPXPRINTFLG . 17)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 55)
(VARIABLE-VALUE-CELL DWIMFLG . 228)
(VARIABLE-VALUE-CELL USERWORDS . 72)
(VARIABLE-VALUE-CELL PRTTYSPELLFLG . 992)
(VARIABLE-VALUE-CELL ORIGFLG . 98)
(VARIABLE-VALUE-CELL DECLARETAGSLST . 234)
(VARIABLE-VALUE-CELL PRETTYPRINTMACROS . 359)
(VARIABLE-VALUE-CELL SYSPROPS . 455)
(VARIABLE-VALUE-CELL COMMENTFLG . 540)
(VARIABLE-VALUE-CELL PRETTYCOMSLST . 698)
(VARIABLE-VALUE-CELL FILEFLG . 807)
(VARIABLE-VALUE-CELL FONTCHANGEFLG . 814)
(VARIABLE-VALUE-CELL LAMBDAFONT . 817)
(VARIABLE-VALUE-CELL LAMBDAFONTLINELENGTH . 821)
(VARIABLE-VALUE-CELL RESETVARSLST . 856)
(VARIABLE-VALUE-CELL DEFAULTFONT . 869)
(VARIABLE-VALUE-CELL FILEPKGCOMSPLST . 984)
(NIL VARIABLE-VALUE-CELL PRTTYTEM . 756)
PRETTYCOMPRINT
PRINT
QUOTE
(NIL)
(LINKED-FN-CALL . PRINT)
NOBIND
(NIL)
(LINKED-FN-CALL . STKSCAN)
(NIL)
(LINKED-FN-CALL . RELSTK)
70
BOUNDP
(NIL)
(LINKED-FN-CALL . FIXSPELL)
(NIL)
(LINKED-FN-CALL . PRETTYVAR)
PRETTYDEFMACROS
(NIL)
(LINKED-FN-CALL . GETTOPVAL)
(NIL)
(LINKED-FN-CALL . PRETTYCOM1)
(NIL)
(LINKED-FN-CALL . SUBPAIR)
(VARIABLE-VALUE-CELL X . 948)
(NIL)
(LINKED-FN-CALL . PRETTYCOM)
FNS
(NIL VARIABLE-VALUE-CELL PRTTYSPELLFLG . 0)
(NIL)
(LINKED-FN-CALL . PRINTFNS)
*
VARS
ARRAY
DECLARE:
"(DECLARE: "
(NIL)
(LINKED-FN-CALL . PRIN1)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL LST . 270)
(NIL)
(LINKED-FN-CALL . MEMB)
1
(NIL)
(LINKED-FN-CALL . SPACES)
(NIL)
(LINKED-FN-CALL . TERPRI)
EVAL@LOADWHEN
EVAL@COMPILEWHEN
COPYWHEN
(NIL)
(LINKED-FN-CALL . PRINTDEF)
")
"
SPECVARS
LOCALVARS
GLOBALVARS
"(DECLARE: DOEVAL@COMPILE DONTCOPY

"
(NIL)
(LINKED-FN-CALL . PRINTDEF1)
")
"
PROP
IFPROP
(VARIABLE-VALUE-CELL PRTTYFLG . 0)
(VARIABLE-VALUE-CELL PRTTYTEM . 0)
(VARIABLE-VALUE-CELL PRTTYX . 417)
(NIL)
(LINKED-FN-CALL . MAKEDEFLIST)
ALL
PUTPROPS
(NIL)
(LINKED-FN-CALL . ASSOC)
(VARIABLE-VALUE-CELL ATM . 440)
(NIL)
(LINKED-FN-CALL . GETPROPLIST)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL X . 0)
(NIL)
(LINKED-FN-CALL . NCONC)
"  (PUTPROPS "
(NIL)
(LINKED-FN-CALL . PRIN2)
(NIL)
(LINKED-FN-CALL . POSITION)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL X . 0)
(NIL)
(LINKED-FN-CALL . TAB)
")
"
P
INITVARS
RPAQ?
(NIL)
(LINKED-FN-CALL . PRETTYVAR1)
ADDVARS
ADDTOVAR
4
ERRORX
APPENDVARS
APPENDTOVAR
E
(NIL)
(LINKED-FN-CALL . EVAL)
COMS
(NIL)
(LINKED-FN-CALL . APPEND)
ORIGINAL
(VARIABLE-VALUE-CELL PRETTYCOMSLST . 0)
(T VARIABLE-VALUE-CELL ORIGFLG . 0)
ADVISE
ADVICE
ARGNAMES
(NIL)
(LINKED-FN-CALL . ADVISEDUMP)
BLOCKS
"[DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY
"
BLOCK:
"]
"
%
(NIL)
(LINKED-FN-CALL . PRIN3)
0
3
(NIL)
(LINKED-FN-CALL . CHANGEFONT)
(NIL)
(LINKED-FN-CALL . LINELENGTH)
(VARIABLE-VALUE-CELL OLDVALUE . 828)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 862)
LINELENGTH
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
ERROR
(NIL)
(LINKED-FN-CALL . APPLY)
(NIL)
(LINKED-FN-CALL . ERROR!)
2
GETDEF
(NIL)
(LINKED-FN-CALL . GETPROP)
"(PUTDEF "
(NIL)
(LINKED-FN-CALL . GETDEF)
")"
"bad file package command"
(NIL)
(LINKED-FN-CALL . ERROR)
(SKNNM CF CONS MKN IUNBOX CONS21 CONSNL ALIST2 URET1 SKLST CONSS1 NLGO SKNLST BHC KNOB SKLA LIST4 LIST2 KT KNIL ENTERF) ;pU 9X   4`   4   : 2 \   [   N     P      ,8R @9 p   !X$   M H   8   8X| ,(Q (@6 &# #h	 xa 0A  & p m   B   j 7H 0HH 'p, # @ J       7` X p        a :xO 4 8 $X  H   >8p =`^ :HL 88C 5x / t .n -`\ )0B '@/ %p) #H "8  h}   H 0 y p h   ^ X Q 
  O p >   & p      o <xf <Pd <@c < ] ; X :8R :K 9 A 6h0 5($ 3  2P 10
 .@g *`; % "0t @s 0q pm Pl @j h XY xD X H ~  s   S p ;  2  +  "    `  H 
  p   H      
PRETTYCOM1 BINARY
        D    8    B-.          8@  :  ,~   [   XB   -,   Z   Z  2B  ;+   ![  3B   +   ![  Z  XB  -,   +   Z   3B   +   Z  	b  ;Z  
3B   +   Z  b  <+    Z  -,   +   b  =XB  3B  >+   +    Z   +    @  ?  +    ,<  ?,<   ,<   @  @ ` +   Z   Z  AXB Z  b  <XB  Z   ,~   3B   +   Z  ,~   Z   ,~   XB  Z   3B   +   7Z   ,<  ,<   Zw-,   +   *Zp  Z   2B   +   ( "  +   *[  QD   "  +    Zw,<   @  B   +   3Z   -,   +   /Z   ,~   Z  -Z   3B  +   27   Z   ,~   3B   +   6ZwZp  ,   XBp  [wXBw+   $Z  ",~   !Y;2R )    (VARIABLE-VALUE-CELL PRTYCOM . 6)
(VARIABLE-VALUE-CELL PRTYFLG . 26)
(VARIABLE-VALUE-CELL REMOVECOMMENTS . 66)
(VARIABLE-VALUE-CELL COMMENTFLG . 96)
(NIL VARIABLE-VALUE-CELL PRTYX . 111)
*
(NIL)
(LINKED-FN-CALL . PRETTYCOM)
(NIL)
(LINKED-FN-CALL . EVAL)
(NIL)
(LINKED-FN-CALL . GETTOPVAL)
NOBIND
(NIL VARIABLE-VALUE-CELL DWIMLOADFNSFLG . 0)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(VARIABLE-VALUE-CELL X . 95)
(COLLCT URET2 SKNLST CF KT SKLA KNIL SKLST ENTERF)  6    +    . X   (   ( / X      (   @ 3 x ' H "     h               
PRETTYCOMPRINT BINARY
      	        	-.          Z   3B   +   Z   ,<  ,<   ,<     ,~   Z   ,~      (VARIABLE-VALUE-CELL X . 6)
(VARIABLE-VALUE-CELL PRETTYHEADER . 3)
(NIL)
(LINKED-FN-CALL . LISPXPRINT)
(KT KNIL ENTERF)    X       0      
PRETTYDEF BINARY
   '   `   -.     0    0`Z   ,<   @ f  ,~   Z   ,<   ,< g,< h,<   @ h ` +  YZ   Z jXB ,< j  k,   Z  ,   XB    l,<   Z   3B   +   Z   ,   +   Z   ,<   @ m @x"+  WZ   -,   +   Z  XB  Z   XB   Z  3B   +   3B   +   -,   +   b uXB   Z   3B   +   Z   3B   +    Z  2B   +    Z  XB  Z   3B   +   K,< v,< w,<   @ h ` +   (Z   Z jXB Z   b wZ   ,~   2B   +   .Z   XB  &Z  ,<  ,<    x,< y,<    x+   K  zXB  *b {3B   +   J,< |Z  /,<   ,   ,<   ,<   ,   Z  ,   XB  4Z  2B |+   9Z   XB  6+   ?2B }+   ?Z   b },<   Z  ,<   ,< ~ b }d  XB  8Z  1,<  ,<   ud XB   3B   +   KZ  A2B   +   E+   KZ  C-,   +   IZ  ?,<   Z  EZ  d +   K  +   KZ   XB  F,< Z   b ,   ,   Z  5,   XB  NZ  *2B   +   WZ   XB  Z   XB     lXB  Ob 2B   +   V7   Z   XB   +   k,<   ,<  3B   +   `Z  Sb l  lXB  Zb 2B   +   ^7   Z   XB  VZ   XB  Q+   kZ  [b   lXB  `b 2B   +   d7   Z   XB  ^Z  b,<  Z  :d XB   Z   3B 	+   kZ  ;3B   +   kb 
Z  fb }XB  kZ  eb {2B   +   pZ   XB  RZ   3B   +  Z  e2B   +   tZ  p2B +  Z  i,<   ,<  ,<   @   +  Z`  -,   +   z+  Z  XB   ,<   ,<  2B   +   ~+  ,<` Z  {b d XB` [`  XB`  +   xZ` ,~   2B   +  Z  tb XB   Z  _2B   +  ,< Z  m,<  ,   ,<   ,<   ,   Z  O,   XB Z   -,   +  b -,   +  Z ,<   ,<    Z ,<   ,<    Z   -,   +  b -,   +  +  '@   +  Z ,<   ,<    ,~   Z -,   +  b +  XB   ,<   Zp  -,   +   +  ',<   @    +  %Z   ,<   ,<   Z "f ,~   [p  XBp  +  /     3B   +  )+  -Z   3B   +  -Z ,<  ,<    Z  h3B 	+  /Z b Z  o3B   +  M,<  xZ   ,<   Zp  -,   +  5+  @Zp  ,<   @    +  ?Z ,   ,   XB   Z 7,<  Z   d Z 9b Z 9,<   Z ;d ,~   [p  XBp  +  3/   ,< Z /,<   ,   b ,<  xZ <,<   Z A,<  Z  g3B   +  LZ FZ  ,<   Z H[  ,   ,   +  LZ   f Z   b lZ 2B   +  QZ D3B   +  Qb Z I3B   +  VZ .3B   +  V,<   ,< Z Qf Z O,~   XB   Z   ,~   3B   +  [Z   +  [Z XB   d Z [3B   +  _  ,~   Z W,~   +$$1)V 3Qpdd<P*5j3J	3)FL"F QBHZ8e Q
$dT&                  (VARIABLE-VALUE-CELL PRTTYFNS . 291)
(VARIABLE-VALUE-CELL PRTTYFILE . 429)
(VARIABLE-VALUE-CELL PRTTYCOMS . 342)
(VARIABLE-VALUE-CELL REPRINTFNS . 125)
(VARIABLE-VALUE-CELL SOURCEFILE . 150)
(VARIABLE-VALUE-CELL CHANGES . 217)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
(VARIABLE-VALUE-CELL RESETVARSLST . 280)
(VARIABLE-VALUE-CELL BUILDMAPFLG . 27)
(VARIABLE-VALUE-CELL FILERDTBL . 152)
(VARIABLE-VALUE-CELL COPYRIGHTFLG . 346)
(VARIABLE-VALUE-CELL FONTCHANGEFLG . 230)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
(NIL VARIABLE-VALUE-CELL RESETY . 446)
(NIL VARIABLE-VALUE-CELL RESETZ . 441)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
((AND RESETSTATE (RESETUNDO OLDVALUE)) . 0)
(NIL)
(LINKED-FN-CALL . RESETUNDO)
(NIL)
(LINKED-FN-CALL . OUTPUT)
(VARIABLE-VALUE-CELL PRTYX . 410)
(VARIABLE-VALUE-CELL NEWFILEMAP . 395)
(NIL VARIABLE-VALUE-CELL FILEFLG . 227)
(NIL VARIABLE-VALUE-CELL FNSLST . 267)
(NIL VARIABLE-VALUE-CELL PRTYOPENFLG . 412)
(NIL VARIABLE-VALUE-CELL PRTTYTEM . 379)
(NIL VARIABLE-VALUE-CELL PRETTYCOMSLST . 315)
(NIL VARIABLE-VALUE-CELL PRTTYSPELLFLG . 339)
(NIL VARIABLE-VALUE-CELL OLDFILEMAP . 143)
(NIL VARIABLE-VALUE-CELL MAPADR . 356)
(NIL VARIABLE-VALUE-CELL NLAMALST . 0)
(NIL VARIABLE-VALUE-CELL NLAMLST . 0)
(NIL VARIABLE-VALUE-CELL LAMALST . 0)
(NIL VARIABLE-VALUE-CELL LAM?LST . 0)
(NIL VARIABLE-VALUE-CELL FILEDATES . 427)
(NIL VARIABLE-VALUE-CELL ORIGFLG . 0)
(NIL VARIABLE-VALUE-CELL ROOTNAME . 422)
(NIL)
(LINKED-FN-CALL . ROOTFILENAME)
((DUMMY) . 0)
NOBREAK
(NIL)
(LINKED-FN-CALL . INFILE)
(NIL)
(LINKED-FN-CALL . PRIN1)
" not found, so it will be written anew.
"
(NIL)
(LINKED-FN-CALL . INPUT)
(NIL)
(LINKED-FN-CALL . RANDACCESSP)
CLOSEF
EXPRS
CHANGES
(NIL)
(LINKED-FN-CALL . FILEPKG.CHANGEDFNS)
FILECHANGES
(NIL)
(LINKED-FN-CALL . GETPROP)
(NIL)
(LINKED-FN-CALL . UNION)
(NIL)
(LINKED-FN-CALL . GETFILEMAP)
(NIL)
(LINKED-FN-CALL . SETFILEPTR)
HELP
SETREADTABLE
(NIL)
(LINKED-FN-CALL . SETREADTABLE)
(NIL)
(LINKED-FN-CALL . DISPLAYP)
OUTPUT
(NIL)
(LINKED-FN-CALL . OPENP)
(NIL)
(LINKED-FN-CALL . OUTFILE)
(NIL)
(LINKED-FN-CALL . PRINTDATE)
NEVER
(NIL)
(LINKED-FN-CALL . PRINTCOPYRIGHT)
ALL
FILEGROUP
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL FL . 254)
FILE
(NIL)
(LINKED-FN-CALL . FILEFNSLST)
(NIL)
(LINKED-FN-CALL . NCONC)
PRETTYDEF0
(NIL)
(LINKED-FN-CALL . GETTOPVAL)
(NIL)
(LINKED-FN-CALL . PRINTFNS)
(NIL)
(LINKED-FN-CALL . PRETTYCOM)
(DONTUPDATE VARIABLE-VALUE-CELL NORMALCOMMENTSFLG . 0)
(VARIABLE-VALUE-CELL L . 328)
(NIL)
(LINKED-FN-CALL . PRETTYDEF1)
(NIL)
(LINKED-FN-CALL . SAVECOPYRIGHT)
"(DECLARE: DONTCOPY
  "
(VARIABLE-VALUE-CELL ADR . 373)
(NIL)
(LINKED-FN-CALL . PRIN2)
FILEMAP
")
"
(NIL)
(LINKED-FN-CALL . PUTFILEMAP)
(NIL)
(LINKED-FN-CALL . ENDFILE)
FILEDATES
(NIL)
(LINKED-FN-CALL . /PUTPROP)
ERROR
(NIL)
(LINKED-FN-CALL . RESETRESTORE)
(NIL)
(LINKED-FN-CALL . ERROR!)
(MKN FGFPTR BHC SKNLST LIST2 SKLA KT SKLST CONSNL CONS ALIST2 CF KNIL ENTERF)         (   4   P     8   5 8   H    Y - (  e   ^ 
h R  . H ( H  h   x F H   @ N    H O `    K 	`     &    `[  T 0O PH + $ 0 H ~ 0 q   o 0 e @ _ X Z 
p U 
0 Q 	8 D 0 4  *  $    `    p        
PRETTYDEF0 BINARY
             -.           Z   ,<   ,<    XB  3B   +   b  	Z  b  
,~      (VARIABLE-VALUE-CELL PRTTYFILE . 11)
OUTPUT
(NIL)
(LINKED-FN-CALL . OPENP)
(NIL)
(LINKED-FN-CALL . CLOSEF)
(NIL)
(LINKED-FN-CALL . DELFILE)
(KNIL ENTERF)          
PRETTYDEF1 BINARY
     _    L    \-.          0 L@  O  ,~   Z   ,<   Zp  -,   +   Z   +   Zp  ,<   ,<w/   @  P   +   Z   2B  Q+   ,<  QZ  
XB   d  RXB   3B   +   [  XB  Z  Z  2B  S7   Z   ,~   Z   ,~   3B   +   Zp  +   [p  XBp  +   /   2B   +   ,Z   2B   +   Z   2B   +   Z   2B   +   Z   ,~   ,<  SZ  ,<   Z  ,<  Z  ,<  ,   ,<   ,<  T  TXB  Z  -,   +   JZ   -,   +   JZ  $,<  Z  $d  UZ  &,<   ,<     V+   JZ  ,<   ,<  SZ  ,<   Z   ,<  Z  ,[  Z  [  d  Wd  XZ  Y,   ,<   Z   ,<   Z  .,<  Z  /[  [  Z  [  d  Wd  XZ  Z,   ,<   Z  !,<   Z  5,<  Z  6[  [  [  Z  [  d  Wd  XZ  Z,   ,   XB   ,\  ,   2B   +   Z  =,<   Z  Bd  [Z  )-,   +   J,<   ,<     VZ  (b  VZ   ,~   

r!I$	d`@`"J         (VARIABLE-VALUE-CELL PRETTYCOMSLST . 79)
(VARIABLE-VALUE-CELL NLAMALST . 91)
(VARIABLE-VALUE-CELL NLAMLST . 104)
(VARIABLE-VALUE-CELL LAMALST . 118)
(VARIABLE-VALUE-CELL PRTTYCOMS . 142)
(VARIABLE-VALUE-CELL LAM?LST . 120)
(NIL VARIABLE-VALUE-CELL PRTTYCOM . 148)
(NIL VARIABLE-VALUE-CELL PRTTYTEM . 138)
(NIL VARIABLE-VALUE-CELL PRTTYNEW . 140)
(VARIABLE-VALUE-CELL X . 24)
DECLARE:
COMPILERVARS
(NIL)
(LINKED-FN-CALL . MEMB)
ADDVARS
((NLAMALST NLAMLST LAMALST) . 0)
((DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA . NLAMALST) (NLAML . NLAMLST) (LAMA . LAMALST))) . 0)
(NIL)
(LINKED-FN-CALL . SUBPAIR)
(NIL)
(LINKED-FN-CALL . /NCONC1)
(NIL)
(LINKED-FN-CALL . PRETTYCOM)
(NIL)
(LINKED-FN-CALL . INTERSECTION)
(NIL)
(LINKED-FN-CALL . UNION)
NLAMA
NLAML
LAMA
(NIL)
(LINKED-FN-CALL . /RPLACA)
(EQUAL ALIST4 CONS21 SKLST LIST3 KT BHC KNIL SKNLST ENTER0)   D    C    B 0 4    &    #    L 	  + 0    	    E h  @    @  p     H x        
PRETTYVAR BINARY
      A    3    ?-.          3@  4  ,~   Z   -,   +   b  5XB   2B  6+   ,<     7,<  8,<     8Z  ,<   ,<     9,<  :,<     8,<     7,<     7,<  ;Z  	,<   Z  f  ;+   2-,   +   1[  XB  Z  XB  Z  -,   Z   Z  -,   Z   XB   Z  2B  <+   [  -,   +   ,<  ;Z  ,<   [  Z  f  ;+   2Z  Z   2B  +   !+   2Z  3B   +   )-,   +   ,Z  !-,   +   (Z  #3B   +   (Z  %2B   +   ,[  &2B   +   ,,<  ;Z  ,<   Z  (f  ;+   2,<  =Z  *,<   Z  +,<  ,<   ,<   
  ;+   2,<  =d  >Z   ,~   6hjc@Le$L8      (VARIABLE-VALUE-CELL VAR . 90)
(VARIABLE-VALUE-CELL FLG . 0)
(VARIABLE-VALUE-CELL COMMENTFLG . 62)
(NIL VARIABLE-VALUE-CELL VAL . 92)
(NIL VARIABLE-VALUE-CELL TEM . 57)
(NIL)
(LINKED-FN-CALL . GETTOPVAL)
NOBIND
(NIL)
(LINKED-FN-CALL . TERPRI)
"****WARNING:  "
(NIL)
(LINKED-FN-CALL . PRIN1)
(NIL)
(LINKED-FN-CALL . PRIN2)
" is unbound"
RPAQQ
(NIL)
(LINKED-FN-CALL . PRETTYVAR1)
QUOTE
RPAQ
"Bad variable specification"
(NIL)
(LINKED-FN-CALL . ERROR)
(SKNNM KNIL SKLST KT SKLA ENTERF)   %    3   )   "       # 0  `     0 h  X  0 	  x    H      
PRETTYVAR1 BINARY
           _   -.     (      _   d,<   @  e  ,~      fZ   ,<   ,<  g  g3B   +   2Z   3B   +   
Z   +   
Z  	XB   b  h,<   ,<  i  g3B   +   2Z  2B  j+   Z  jXB  ,<  k,<     kZ  ,<   ,<     l,<  m,<     nZ   ,<   ,<     l,<  m,<     nZ  
b  h2B  o+   ,,<  o,<     kZ  b  p,<   ,<     k,<  m,<     n,<  q,<     kZ  b  q,<   ,<     k,<  r,<     kZ  "b  s,<   ,<     k,<  t,<     k,<     fZ  &b  t+   ^2B  u+   1,<  v,<     k,<     fZ  +b  v+   ^   w+   ^Z  ,<   Z   d  x3B   +   AZ  2B   +   8Z  
,   XB  7Z  2,<   Z  -,   +   =,<   Z  8d  y+   >Z  ;,   ,   ,<   ,<  zZ   f  {+   ^,<  |  kZ  8b  k,<  m  n   |XB  0Z   3B   +   HZ   3B   +   Hb  }Z  9-,   +   N,<   ,<   ,<   ,<   ,<   Z  ~l  +   Nb  lZ  E3B   +   RZ  F3B   +   RZ   b  },<  m  nZ  =,<   -,   +   Y,<   ,<   ,<   Z   h  3B   +   Z   |+   ZZ  D,<   Z  ?,<   Z  5h  {,<   k   fZ   ,~   &J-:=&jj5>WE wDH%b`             (VARIABLE-VALUE-CELL OP . 132)
(VARIABLE-VALUE-CELL VAR . 145)
(VARIABLE-VALUE-CELL E . 167)
(VARIABLE-VALUE-CELL DEF . 182)
(VARIABLE-VALUE-CELL TAILFLG . 184)
(VARIABLE-VALUE-CELL PRETTYPRINTMACROS . 103)
(VARIABLE-VALUE-CELL FONTCHANGEFLG . 157)
(VARIABLE-VALUE-CELL PRETTYCOMFONT . 160)
(VARIABLE-VALUE-CELL DEFAULTFONT . 163)
(NIL)
(LINKED-FN-CALL . LINELENGTH)
(VARIABLE-VALUE-CELL LASTCOL . 174)
(NIL VARIABLE-VALUE-CELL TEM . 180)
(NIL)
(LINKED-FN-CALL . TERPRI)
((RPAQQ RPAQ RPAQ?) . 0)
(NIL)
(LINKED-FN-CALL . MEMB)
(NIL)
(LINKED-FN-CALL . TYPENAME)
((ARRAYP BITMAP) . 0)
RPAQQ
RPAQ
"("
(NIL)
(LINKED-FN-CALL . PRIN1)
(NIL)
(LINKED-FN-CALL . PRIN2)
1
(NIL)
(LINKED-FN-CALL . SPACES)
ARRAYP
"(READARRAY "
(NIL)
(LINKED-FN-CALL . ARRAYSIZE)
"(QUOTE "
(NIL)
(LINKED-FN-CALL . ARRAYTYP)
") "
(NIL)
(LINKED-FN-CALL . ARRAYORIG)
"))"
(NIL)
(LINKED-FN-CALL . PRINTARRAY)
BITMAP
"(READBITMAP))"
(NIL)
(LINKED-FN-CALL . PRINTBITMAP)
(NIL)
(LINKED-FN-CALL . SHOULDNT)
(NIL)
(LINKED-FN-CALL . ASSOC)
(NIL)
(LINKED-FN-CALL . APPEND)
0
(NIL)
(LINKED-FN-CALL . PRINTDEF)
%(
(NIL)
(LINKED-FN-CALL . POSITION)
(NIL)
(LINKED-FN-CALL . CHANGEFONT)
PRIN2
(NIL)
(LINKED-FN-CALL . MAPRINT)
(NIL)
(LINKED-FN-CALL . FITP)
%)
(CONSS1 CONS SKLST CONSNL KNIL ENTERF)   p   h   
X J 0      x Y 
x W 
 P 	P L 	@ K 	  F p 5   / 0 *  & H "   H  x  @  ` 	  x      
PRINTDATE BINARY
    '        &-.             ,<   Z   b  ,<   @   @,~   Z   3B   +   Z   3B   +   ,<   ,<   Z   ,<  ,<   ,<      d  !XB  	f  "Z   Z  ,   ,<   Z  ,<   ,<  #   b  $XB   ,   XB   Z  ,<   Z  ,<  Z  ,<  Z  Z  ,<   Z  [  j  %Z  ,~   !:  @       (VARIABLE-VALUE-CELL FILE . 39)
(VARIABLE-VALUE-CELL CHANGES . 41)
(VARIABLE-VALUE-CELL FILEPKGFLG . 11)
(NIL)
(LINKED-FN-CALL . DATE)
(NIL)
(LINKED-FN-CALL . ROOTFILENAME)
(VARIABLE-VALUE-CELL DAT . 43)
(VARIABLE-VALUE-CELL ROOTNAME . 31)
(NIL VARIABLE-VALUE-CELL PREVPAIR . 48)
(NIL VARIABLE-VALUE-CELL FILEDATES . 51)
FILECHANGES
(NIL)
(LINKED-FN-CALL . GETPROP)
(NIL)
(LINKED-FN-CALL . FILEPKG.MERGECHANGES)
(NIL)
(LINKED-FN-CALL . /PUTPROP)
FILEDATES
(NIL)
(LINKED-FN-CALL . LAST)
(NIL)
(LINKED-FN-CALL . PRINTDATE1)
(CONSS1 CONS KNIL ENTERF) 8   x           
PRINTDATE1 BINARY
     h    I    e-.     0    8 IZ   ,<   @  P  ,~   Z   ,<   ,<  Q,<  R,<   @  R ` +   BZ   Z  TXB ,<  TZ   b  U,   ,   Z  ,   XB  Z   ,<  ,<     V,<  W,<     WZ   ,<   ,<     X,<  Y,<     ZZ   ,<   ,<     VZ  
,<   ,<     XZ  ,<   ,<     VZ   3B   +   #Z  3B   +   #3B   +   #Z  ,   ."   ,   Z   ,   XB   ,<  [  [Z   3B   +   >Z   3B   +   0,<     \,<     \,<  ],<   ,<     ^,<  _,<     WZ  $,<   ,<     _,<   ,<   ,<   ,<   ,<     `Z   3B   +   >,<     \,<     \,<  ],<   ,<     ^,<  a,<     WZ  0,<   ,<     XZ   3B   +   >,<  Y,<     ZZ  9,<   ,<     XZ   2B   +   @Z  bb  WXB   Z   ,~   3B   +   DZ   +   EZ  bXB   d  cZ  E3B   +   H   d,~   Z  A,~   *@4"(JfD	,QBi          (VARIABLE-VALUE-CELL FILE . 61)
(VARIABLE-VALUE-CELL CHANGES . 87)
(VARIABLE-VALUE-CELL DAT . 34)
(VARIABLE-VALUE-CELL PREVDATE . 111)
(VARIABLE-VALUE-CELL PREVERS . 121)
(VARIABLE-VALUE-CELL STR . 125)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
(VARIABLE-VALUE-CELL RESETVARSLST . 26)
(VARIABLE-VALUE-CELL DEFAULTFONT . 49)
(VARIABLE-VALUE-CELL LAMBDAFONT . 41)
(VARIABLE-VALUE-CELL BUILDMAPFLG . 53)
(VARIABLE-VALUE-CELL MAPADR . 67)
(VARIABLE-VALUE-CELL FILEPKGFLG . 70)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
(NIL VARIABLE-VALUE-CELL RESETY . 145)
(NIL VARIABLE-VALUE-CELL RESETZ . 140)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
OUTPUT
(NIL)
(LINKED-FN-CALL . OUTPUT)
(NIL)
(LINKED-FN-CALL . CHANGEFONT)
"(FILECREATED "
(NIL)
(LINKED-FN-CALL . PRIN1)
(NIL)
(LINKED-FN-CALL . PRIN2)
1
(NIL)
(LINKED-FN-CALL . SPACES)
"        "
(NIL)
(LINKED-FN-CALL . PRIN3)
(NIL)
(LINKED-FN-CALL . TERPRI)
6
(NIL)
(LINKED-FN-CALL . TAB)
"changes to:  "
(NIL)
(LINKED-FN-CALL . POSITION)
(NIL)
(LINKED-FN-CALL . PRINTDEF)
"previous date: "
")


"
ERROR
(NIL)
(LINKED-FN-CALL . RESETRESTORE)
(NIL)
(LINKED-FN-CALL . ERROR!)
(MKN FGFPTR KT CONS CONSNL ALIST2 CF KNIL ENTERF)   !         B x     " X   H   @      x D 8 @ h < 0 9 x 6 X 4 0 2  0 p - 8 *  ( p & H  @    H     p      
PRINTDEF1 BINARY
            -.           Z   b     ,~       (VARIABLE-VALUE-CELL EXPR . 3)
(NIL)
(LINKED-FN-CALL . PRINTDEF)
(NIL)
(LINKED-FN-CALL . TERPRI)
(ENTERF)    
PRINTFNS BINARY
     -         ,-.           Z   3B   +   @  #  +   Z   3B   +   Z   3B   +   ,<   Z   ,   ,   d  #XB   ,<   ,<     #Z  ,<   Z  
,   d  $,<  %  &,<  '  'Z  ,<   Z  3B   +   Z  2B   +   Z   +   Z   ,<   Z   f  (,<  )  &Z  3B   +   Z  [  ,<   Z  ,   ,   d  *   +Z   ,~   ,~   Z   ,~   $B|% 0      (VARIABLE-VALUE-CELL X . 33)
(VARIABLE-VALUE-CELL PRETTYDEFLG . 35)
(VARIABLE-VALUE-CELL NEWFILEMAP . 24)
(VARIABLE-VALUE-CELL PRTTYFILE . 55)
(VARIABLE-VALUE-CELL FNSLST . 45)
(NIL VARIABLE-VALUE-CELL FNADRLST . 52)
(NIL)
(LINKED-FN-CALL . TCONC)
(NIL)
(LINKED-FN-CALL . NCONC)
%(
(NIL)
(LINKED-FN-CALL . PRIN1)
DEFINEQ
(NIL)
(LINKED-FN-CALL . PRINT)
(NIL)
(LINKED-FN-CALL . PRETTYPRINT)
%)
(NIL)
(LINKED-FN-CALL . RPLACA)
(NIL)
(LINKED-FN-CALL . TERPRI)
(KT CONSNL MKN FGFPTR KNIL ENTERF)   X   h   X 
             H  @   x   0      
READARRAY BINARY
    ?    3    =-.           3Z   ,<   Z   ,<  ,<   Z   h  4,<   @  5  ,~      73B  8+   	+   Z"   XB   Z  2B   +   ^"   +   ,   /"   ,   XB      	,>  2,>          ,^   /   2b  +   Z   ,<      ,>  2,>      .Bx  ,^   /   ,   `  9f  :   ."   ,   XB  +      92B   +   +   1Z  -,   +   !   ."   ,   +   #2B  ;+   #Z"   +   #   ;XB     #,>  2,>          ,^   /   2b  +   1Z  ,<      $,>  2,>      .Bx  ,^   /   ,   `  9f  <   )."   ,   XB  .+   $   9Z  (,~      x("d; "      (VARIABLE-VALUE-CELL SIZE . 75)
(VARIABLE-VALUE-CELL TYPE . 62)
(VARIABLE-VALUE-CELL ORIG . 20)
(NIL)
(LINKED-FN-CALL . ARRAY)
(VARIABLE-VALUE-CELL A . 99)
(NIL VARIABLE-VALUE-CELL X . 0)
(NIL VARIABLE-VALUE-CELL M . 96)
(NIL VARIABLE-VALUE-CELL DELTA . 86)
(NIL)
(LINKED-FN-CALL . READC)
%(
(NIL)
(LINKED-FN-CALL . READ)
(NIL)
(LINKED-FN-CALL . SETA)
DOUBLEPOINTER
(NIL)
(LINKED-FN-CALL . SHOULDNT)
(NIL)
(LINKED-FN-CALL . SETD)
(SKNM BHC MKN IUNBOX ASZ KNIL ENTERF)   p   X (       0 ` ! 0  h   X   0 
     8        
WIDEPAPER BINARY
              -.           Z   ,<   Z   XB  3B   +   Z"  <XB   Z"  (XB   Z"  XB   +   Z"  $XB  Z"  XB  Z"  XB  ,\   ,~       (VARIABLE-VALUE-CELL FLG . 5)
(VARIABLE-VALUE-CELL WIDEPAPERFLG . 6)
(VARIABLE-VALUE-CELL FILELINELENGTH . 17)
(VARIABLE-VALUE-CELL FIRSTCOL . 19)
(VARIABLE-VALUE-CELL PRETTYLCOM . 21)
(ASZ KNIL ENTERF)     	  x   X    H      
(PRETTYCOMPRINT PRETTYCOMS)
(RPAQQ PRETTYCOMS ((FNS PRETTYDEF PRETTYDEF0 PRETTYDEF1 PRINTDATE PRINTDATE1 PRINTFNS PRETTYCOM PRETTYCOMPRINT PRETTYVAR PRETTYVAR1 
PRETTYCOM1 ENDFILE MAKEDEFLIST PP PP* PPT PRETTYPRINT PRETTYPRINT1 PRETTYPRINT2 PRINTDEF1 PRINTDEF SUPERPRINT SUPERPRINT0 
SUPERPRINTEQ SUPERPRINTGETPROP RPARS SUBPRINT SUBPRINT1 SUBPRINT2 CHANGEFONT CHANGFONT PRINTPROG ENDLINE ENDLINE1 TABTO READARRAY 
FITP FITP1 FITP2 WIDEPAPER ISTTYP) (COMS (DECLARE: DONTCOPY EVAL@COMPILEWHEN (EQ (COMPILEMODE) (QUOTE D)) (ADDVARS (DONTCOMPILEFNS 
CHANGEFONT)) (MACROS CHANGFONT)) (DECLARE: DONTCOPY EVAL@COMPILEWHEN (NEQ (COMPILEMODE) (QUOTE D)) (BLOCKS (NIL CHANGEFONT (LINKFNS 
. T)))) (DECLARE: DOCOPY (DECLARE: EVAL@LOADWHEN (EQ (SYSTEMTYPE) (QUOTE D)) (P (MOVD (QUOTE DSPFONT) (QUOTE CHANGEFONT)))))) (COMS 
(* COPYRIGHT) (FNS PRINTCOPYRIGHT PRINTCOPYRIGHT1 SAVECOPYRIGHT) (BLOCKS (NIL PRINTCOPYRIGHT PRINTCOPYRIGHT1 SAVECOPYRIGHT (
LOCALVARS . T) (NOLINKFNS PRINTCOPYRIGHT1))) (GLOBALVARS COPYRIGHTFLG COPYRIGHTOWNERS DEFAULTCOPYRIGHTKEYLST DEFAULTCOPYRIGHTOWNER 
COPYRIGHTSRESERVED) (INITVARS (COPYRIGHTFLG) (DEFAULTCOPYRIGHTOWNER) (COPYRIGHTPRETTYFLG T) (COPYRIGHTOWNERS) (
DEFAULTCOPYRIGHTKEYLST (QUOTE ((NONE "
" EXPLAINSTRING "NONE - No copyright ever on this file" CONFIRM T RETURN (QUOTE NONE)) (%[ "owner: " EXPLAINSTRING 
"[ - new copyright owner -- type one line of text" NOECHOFLG T KEYLST (( "
" RETURN (SUBSTRING (CADR ANSWER) 2 -2)))) (%] "No copyright notice now
" EXPLAINSTRING "] - no copyright notice now" NOECHOFLG T RETURN NIL)))) (COPYRIGHTSRESERVED T)) (GLOBALVARS COPYRIGHTOWNERS 
DEFAULTCOPYRIGHTKEYLST COPYRIGHTPRETTYFLG COMMENTFLG)) (FNS COMMENT1 COMMENT2 COMMENT3 COMMENT4 COMMENT5) (INITVARS (BRLST) (
COMMENTFLG (QUOTE *)) (**COMMENT**FLG (QUOTE "  **COMMENT**  ")) (PRETTYFLG T) (#RPARS 4) (CLISPIFYPRETTYFLG) (PRETTYTRANFLG) (
FONTCHANGEFLG) (CHANGECHARTABSTR) (PRETTYTABFLG T) (DECLARETAGSLST (QUOTE (COMPILERVARS COPY COPYWHEN DOCOPY DOEVAL@COMPILE 
DOEVAL@LOAD DONTCOPY DONTEVAL@COMPILE DONTEVAL@LOAD EVAL@COMPILE EVAL@COMPILEWHEN EVAL@LOAD EVAL@LOADWHEN FIRST NOTFIRST))) (
WIDEPAPERFLG) (AVERAGEVARLENGTH 4) (AVERAGEFNLENGTH 5) (#CAREFULCOLUMNS 0) (CHANGECHAR (QUOTE %|)) (LASTFONT) (ENDLINEUSERFN)) (
INITVARS (PRETTYDEFMACROS) (PRETTYPRINTMACROS) (PRETTYEQUIVLST) (PRETTYPRINTYPEMACROS) (FILEPKGCOMSPLST (QUOTE (DECLARE: SPECVARS 
LOCALVARS GLOBALVARS PROP IFPROP P VARS INITVARS ADDVARS APPENDVARS FNS ARRAY E COMS ORIGINAL ADVISE ADVICE BLOCKS *))) (SYSPROPS (
QUOTE (PROPTYPE ALISTTYPE DELDEF EDITDEF PUTDEF GETDEF WHENCHANGED NOTICEFN NEWCOMFN PRETTYTYPE DELFROMPRETTYCOM ADDTOPRETTYCOM 
ACCESSFN ACS ADVICE ADVISED ALIAS AMAC ARGNAMES BLKLIBRARYDEF BRKINFO BROADSCOPE BROKEN BROKEN-IN CLISPCLASS CLISPCLASSDEF CLISPFORM
 CLISPIFYISPROP CLISPINFIX CLISPISFORM CLISPISPROP CLISPNEG CLISPTYPE CLISPWORD CLMAPS CODE CONVERT COREVAL CROPS CTYPE EDIT-SAVE 
EXPR FILE FILECHANGES FILEDATES FILEDEF FILEGROUP FILEHISTORY FILEMAP FILETYPE GLOBALVAR HISTORY I.S.OPR I.S.TYPE INFO LASTVALUE 
LISPFN MACRO MAKE NAMESCHANGED NARGS OLDVALUE OPD READVICE SETFN SUBR UBOX UNARYOP VALUE \DEF CLISPBRACKET TRYHARDER)))) (DECLARE: 
DONTCOPY EVAL@COMPILE (FILES (IMPORT) FILEPKG)) (DECLARE: DONTEVAL@LOAD DOCOPY (P (WIDEPAPER) (SETLINELENGTH) (MOVD? (QUOTE ISTTYP) 
(QUOTE DISPLAYP)) (MOVD? (QUOTE NILL) (QUOTE COMPUTEPRETTYPARMS)))) (BLOCKS (PRETTYPRINTBLOCK PRETTYPRINT PRETTYPRINT1 PRETTYPRINT2 
(ENTRIES PRETTYPRINT) (SPECVARS FNSLST FILEFLG)) (PRETTYBLOCK PRINTDEF SUPERPRINT SUPERPRINT0 SUPERPRINTEQ SUPERPRINTGETPROP 
SUBPRINT SUBPRINT1 SUBPRINT2 CHANGFONT PRINTPROG RPARS ENDLINE ENDLINE1 TABTO FITP FITP1 FITP2 COMMENT1 COMMENT2 (ENTRIES PRINTDEF 
CHANGFONT ENDLINE1 COMMENT1 FITP SUPERPRINTEQ SUPERPRINTGETPROP) (LOCALFREEVARS I LASTCOL FORMFLG E TAIL TAILFLG EXPR CRCNT FILEFLG 
FNSLST CHANGEFLG DEF) (BLKLIBRARY GETPROP) (SPECVARS CHANGEFLG LASTCOL FILEFLG E TAIL EXPR TYPE)) (NIL COMMENT3 COMMENT4 COMMENT5 
ENDFILE ISTTYP MAKEDEFLIST PP PP* PPT PRETTYCOM PRETTYCOM1 PRETTYCOMPRINT PRETTYDEF PRETTYDEF0 PRETTYDEF1 PRETTYVAR PRETTYVAR1 
PRINTDATE PRINTDATE1 PRINTDEF1 PRINTFNS READARRAY WIDEPAPER (LINKFNS . T))) (GLOBALVARS UCASELST LCASELST DECLARETAGSLST 
LISPXPRINTFLG SYSPROPS FILEPKGCOMSPLST DWIMLOADFNSFLG LAMBDAFONTLINELENGTH PRETTYCOMFONT WIDEPAPERFLG PRETTYHEADER BUILDMAPFLG 
FILERDTBL NORMALCOMMENTSFLG FILELINELENGTH FONTFNS FONTWORDS USERFONT CLISPFONT SYSTEMFONT COMMENTFONT CHANGEFONT PRETTYTABFLG 
AVERAGEFNLENGTH AVERAGEVARLENGTH #CAREFULCOLUMNS CHANGECHAR LASTFONT CHANGEFLG0 DISPLAYTERMFLG PRETTYEQUIVLST COMMENTLINELENGTH 
CHANGEFLG0 ENDLINEUSERFN FONTPROFILE PRETTYFLG CHANGESARRAY PRETTYPRINTYPEMACROS PRETTYPRINTMACROS CLISPTRANFLG PRETTYTRANFLG 
CLISPARRAY #RPARS CLISPCHARS FUNNYATOMLST CHCONLST CLISPFLG PRETTYLCOM FIRSTCOL **COMMENT**FLG ABBREVLST CHANGECHARTABSTR FILEPKGFLG
 FONTCHANGEFLG DEFAULTFONT LAMBDAFONT CLISPIFYPRETTYFLG LISPXHISTORY DWIMFLG USERWORDS ADDSPELLFLG COMMENTFLG CLISPIFYPACKFLG) (
DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA PPT PP* PP) (NLAML PRETTYCOMPRINT) (LAMA)))))
(DECLARE: EVAL@LOADWHEN (EQ (SYSTEMTYPE) (QUOTE D)) (MOVD (QUOTE DSPFONT) (QUOTE CHANGEFONT)))
(RPAQ? COPYRIGHTFLG)
(RPAQ? DEFAULTCOPYRIGHTOWNER)
(RPAQ? COPYRIGHTPRETTYFLG T)
(RPAQ? COPYRIGHTOWNERS)
(RPAQ? DEFAULTCOPYRIGHTKEYLST (QUOTE ((NONE "
" EXPLAINSTRING "NONE - No copyright ever on this file" CONFIRM T RETURN (QUOTE NONE)) (%[ "owner: " EXPLAINSTRING 
"[ - new copyright owner -- type one line of text" NOECHOFLG T KEYLST (( "
" RETURN (SUBSTRING (CADR ANSWER) 2 -2)))) (%] "No copyright notice now
" EXPLAINSTRING "] - no copyright notice now" NOECHOFLG T RETURN NIL))))
(RPAQ? COPYRIGHTSRESERVED T)
(RPAQ? BRLST)
(RPAQ? COMMENTFLG (QUOTE *))
(RPAQ? **COMMENT**FLG (QUOTE "  **COMMENT**  "))
(RPAQ? PRETTYFLG T)
(RPAQ? #RPARS 4)
(RPAQ? CLISPIFYPRETTYFLG)
(RPAQ? PRETTYTRANFLG)
(RPAQ? FONTCHANGEFLG)
(RPAQ? CHANGECHARTABSTR)
(RPAQ? PRETTYTABFLG T)
(RPAQ? DECLARETAGSLST (QUOTE (COMPILERVARS COPY COPYWHEN DOCOPY DOEVAL@COMPILE DOEVAL@LOAD DONTCOPY DONTEVAL@COMPILE DONTEVAL@LOAD 
EVAL@COMPILE EVAL@COMPILEWHEN EVAL@LOAD EVAL@LOADWHEN FIRST NOTFIRST)))
(RPAQ? WIDEPAPERFLG)
(RPAQ? AVERAGEVARLENGTH 4)
(RPAQ? AVERAGEFNLENGTH 5)
(RPAQ? #CAREFULCOLUMNS 0)
(RPAQ? CHANGECHAR (QUOTE %|))
(RPAQ? LASTFONT)
(RPAQ? ENDLINEUSERFN)
(RPAQ? PRETTYDEFMACROS)
(RPAQ? PRETTYPRINTMACROS)
(RPAQ? PRETTYEQUIVLST)
(RPAQ? PRETTYPRINTYPEMACROS)
(RPAQ? FILEPKGCOMSPLST (QUOTE (DECLARE: SPECVARS LOCALVARS GLOBALVARS PROP IFPROP P VARS INITVARS ADDVARS APPENDVARS FNS ARRAY E 
COMS ORIGINAL ADVISE ADVICE BLOCKS *)))
(RPAQ? SYSPROPS (QUOTE (PROPTYPE ALISTTYPE DELDEF EDITDEF PUTDEF GETDEF WHENCHANGED NOTICEFN NEWCOMFN PRETTYTYPE DELFROMPRETTYCOM 
ADDTOPRETTYCOM ACCESSFN ACS ADVICE ADVISED ALIAS AMAC ARGNAMES BLKLIBRARYDEF BRKINFO BROADSCOPE BROKEN BROKEN-IN CLISPCLASS 
CLISPCLASSDEF CLISPFORM CLISPIFYISPROP CLISPINFIX CLISPISFORM CLISPISPROP CLISPNEG CLISPTYPE CLISPWORD CLMAPS CODE CONVERT COREVAL 
CROPS CTYPE EDIT-SAVE EXPR FILE FILECHANGES FILEDATES FILEDEF FILEGROUP FILEHISTORY FILEMAP FILETYPE GLOBALVAR HISTORY I.S.OPR 
I.S.TYPE INFO LASTVALUE LISPFN MACRO MAKE NAMESCHANGED NARGS OLDVALUE OPD READVICE SETFN SUBR UBOX UNARYOP VALUE \DEF CLISPBRACKET 
TRYHARDER)))
(WIDEPAPER)
(SETLINELENGTH)
(MOVD? (QUOTE ISTTYP) (QUOTE DISPLAYP))
(MOVD? (QUOTE NILL) (QUOTE COMPUTEPRETTYPARMS))
(PUTPROPS PRETTY COPYRIGHT ("Xerox Corporation" T 1984))
NIL
