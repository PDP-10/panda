(FILECREATED "22-OCT-83 04:17:34" ("compiled on " <LISPUSERS>CMLARRAY.;63) (2 . 2) recompiled exprs: 
\BubbleWORDSET \BubbleWORDSET in WORK dated "26-SEP-83 00:54:17")
(FILECREATED "22-OCT-83 04:17:04" <LISPUSERS>CMLARRAY.;63 56937 changes to: (VARS CMLARRAYCOMS) 
previous date: "29-SEP-83 00:20:20" <LISPUSERS>CMLARRAY.;62)

\BubbleWORDSET BINARY
    ,    #    *-.           #Z   ,<   ,<   $  %,<   [  Z  ,<   ,<   $  %,<   [  [  Z  ,<   ,<   $  %,<   @  % ` ,~   Z   3B   +   Z   ,<  ,<  'F  'XB  Z   ,<   Z   D  (3B   +   Z  ,<   Z  D  (3B   +   Z   ,<   Z  ,<  Z  ,<  Z  ,<  ,   ,~   ,<  (,<  ),<  )Z  ,<   Z  ,<  Z  ,<  ,<  *,   ,   ,<   Z  ,<   ,   ,~   B0"@      (VARIABLE-VALUE-CELL X . 14)
(VARIABLE-VALUE-CELL FUNNAME . 57)
(VARIABLE-VALUE-CELL SHIFTFORM . 24)
LISPFORM.SIMPLIFY
(VARIABLE-VALUE-CELL VAL . 67)
(VARIABLE-VALUE-CELL BASE . 59)
(VARIABLE-VALUE-CELL OFFST . 61)
DATUM
SUBST
ARGS.COMMUTABLEP
LAMBDA
((\Val) . 0)
((DECLARE (SPECVARS \Val)) . 0)
\Val
(LIST2 ALIST4 LIST4 KNIL KT ENTERF) 8            0     
  h        
\BubbleWORDSET BINARY
      ,    #    *-.           #Z   ,<   ,<   $  %,<   [  Z  ,<   ,<   $  %,<   [  [  Z  ,<   ,<   $  %,<   @  % ` ,~   Z   3B   +   Z   ,<  ,<  'F  'XB  Z   ,<   Z   D  (3B   +   Z  ,<   Z  D  (3B   +   Z   ,<   Z  ,<  Z  ,<  Z  ,<  ,   ,~   ,<  (,<  ),<  )Z  ,<   Z  ,<  Z  ,<  ,<  *,   ,   ,<   Z  ,<   ,   ,~   B0"@      (VARIABLE-VALUE-CELL X . 14)
(VARIABLE-VALUE-CELL FUNNAME . 57)
(VARIABLE-VALUE-CELL SHIFTFORM . 24)
LISPFORM.SIMPLIFY
(VARIABLE-VALUE-CELL VAL . 67)
(VARIABLE-VALUE-CELL BASE . 59)
(VARIABLE-VALUE-CELL OFFST . 61)
DATUM
SUBST
ARGS.COMMUTABLEP
LAMBDA
((\Val) . 0)
((DECLARE (SPECVARS \Val)) . 0)
\Val
(LIST2 ALIST4 LIST4 KNIL KT ENTERF) 8            0     
  h        

\NONDADDARITH.TRAMPOLINE BINARY
    H    7    F-.          7,<  8"  8B  9,<   @  9   ,~   Z   Z  :,   2B   +   Z  3B   +   -,   +   B  :,       ^"  2"  +   Z  ,<   ,<  ;,<  ;&  <Z  <,   3B   +   Z  ,<   ,<  =,<  =&  <3B  >+   ,<  >"  ?Z  ,<   ,<   $  ?,<  @"  @Z  B  A2B   +   Z  >,<   Z  D  AZ  ,<   ,<  B$  B+   6Z  ,<   Z   ,<  @  C   
+   5Z"   XB      #,>  7,>    `      ,^   /   3b  +   )+   4   $.wZ  XB` Z` 3B   +   0,<   Z` ,   XB` ,\  QB  +   2Z` ,   XB` XB`    )."   ,   XB  2+   $Z` ,~   D  EZ   ,~      DKy?G,N
 0     (VARIABLE-VALUE-CELL NARGS . 65)
-1
STKNTH
STKNAME
(VARIABLE-VALUE-CELL FNAME . 63)
((LOADBYTE DEPOSITBYTE) . 0)
NCHARS
2
4
SUBATOM
((GET PUT) . 0)
5
8
BASE
\NONDADDARITH.TRAMPOLINE
SHOULDNT
PUTD
(((SYSLOAD COMPILED FROM LISPUSERS) NONDADDARITH) . 0)
FILESLOAD
DEFINEDP
MOVD
"Apparently not defined in NONDADDARITH file?"
ERROR
(0 . 1)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL I . 103)
APPLY
(MKN CONSNL BHC ASZ IUNBOX SKLA KNIL FMEMB ENTERF)  4    1 h       @   8       p , 0   	  x           
MAKEARRAY BINARY
        L   u-.         LZ   0B   +   Z   +      A"   0B   +   ,< M" M+   Z`  2B   +   
Z   +   Z`  -,   +   Z`  ,   ,<   @ N !(,~   Z   3B   +   +,<   Zp  -,   +   +   &Zp  ,<   @ X   +   $Z   -,   +      1"   +      1"   +      3" I+   ,< XZ  D MZ  XB       ,> J,>      $Bx  ,^   /   ,   XB      ."   ,   XB  ",~   [p  XBp  +   /      !,> J,>          ,^   /   &  ,   XB   @ Y  +   p   ,> J,>          ,^   /   3b  +   2Z`  ,~      -."   .wZ  XB      2.wZ  2B Z+   9Z  4XB   +   n2B [+   <Z   XB   Z  7XB   +   n2B [+   @Z   XB   Z  ;XB  ;+   n2B \+   IZ  >B \3B ]+   FZ  A,<   ,< ]" ^D M+   FZ  CXB   Z  F" J,   XB   +   n2B ^+   MZ  FXB  GZ   XB  H+   n2B _+   YZ  J-,   +   PZ"  +   S   N0"   7   7   +   SZ"  XB   3B   +   W,<   Z  P,<  ,   B _Z  UXB   +   n2B `+   gZ  W-,   +   \Z"  +   a"   +   ^Z   +   a   Z0"   7   7   +   aZ"  XB  S3B   +   e,<   Z  ^,<  ,   B _Z  cXB   +   n3B `+   i2B [+   k   5.wZ  B a+   n,< a   i.w~Z  D M   l."  ,   XB  n+   -Z  83B   +   u3B   +   u3B b+   u2B b+   z3B b+   wZ"   +   wZ   XB   Z"  XB   Z"  +  33B c+   }3B c+   }2B d+   Z"  XB  xZ"  +  33B d+  2B e+  Z"  XB  }Z"  +  33B e+  2B f+  ,<   ,< f$ M+  32B g+  
Z"  XB Z"  +  33B g+  2B h+  Z"  XB Z"  +  32B h+  Z"  XB Z"  +  32B i+  Z"   XB Z"  +  3-,   Z   Z  2B i+  2[  p[  2B   +  2[ Z  XB   -,   +  2      ^"   2"  +  2Z 0B  +   Z iXB +   p0B  +  #Z hXB +   p0B  +  %Z gXB "+   p2B j+  (Z gXB $+   p  /"   ,   B jXB   *1"  @+  -,< k" k^"  @,> J,>     *GBx  ,^   /   ,   XB '+  3,< lZ 1D MXB 2Z  f1B   +  E   (,> J,>     4/"   .Bx  ,^   /   ,> J,>     7    ,^   /   &  ,> J,>     :$Bx  ,^   /   ,   XB 5   +,> J,>     @$Bx  ,^   /   ,   XB  &Z  >3B   +  MZ  :3B   +  J,< l,< m$ MZ  3B   +  M,<   Z  ?D mZ  K3B   +  uZ G2B   +  QZ E3B   +  X,< lZ N3B   +  TZ n+  WZ P3B   +  WZ n+  W  kD M+  uZ  L2B   +  Z+  uZ M[ ,   ."   ,> J,>      X    ,^   /   /  ,> J,>     E    ,^   /   2"  +  f,< oZ ZD M+  uZ 31B  +  h0B  +  iZ   +  jZ   XB  a,<   Z X1B  +  m0B  +  nZ   +  oZ   ,\  3B  +  uZ j3B   +  sZ o+  sZ p,<   Z dD MZ  #0B   +  Z R3B   +  y,< l,< [$ MZ T3B   +  Z f1B  +   1B  +   1B  +   1B  +   0B  +  Z L-,   +  
+  0B  +  Z  "   +  
+    {0b  @+  
Z -,   +  
,< p,<   ,   B _Z +  Z 1B  +  0B  +  Z   +  0B  +  Z q+  Z"   XB   +  Z t3B   +  ,< \" a+  Z aB qXB ,< ]" r,<     u    ,\   d KZ QD  ,<         ,\   d JZ   XD  ,<     1"  +  "Z JB r+  #Z"       ,\   QD  Z !XD  ,<     /"   ,       ,\   QD ,<     >    ,\   d K,<   Z (3B   +  /,< i,<   ,   +  0Z       ,\   XD ,<     ,> J,>   ^"?ABx  ,^   /   ,   B s3B   +  8^"+  9^"       ,\   d LXB pZ v3B   +  >Z 
,   XB <+  FZ y3B   +  H  /"   4b F,> J,>   Z s,<   Z =D tXB C>`x  5  B/  Z :,<   Z DD tZ F,~            
 (@  GJ"J$] 	 * 3CC\xPD!'c%~A~>>8FB5-t#P 'I3OL"<IrU&LLR.'V,  # *	H              (VARIABLE-VALUE-CELL NARGS . 93)
"Odd # of keywords"
ERROR
(VARIABLE-VALUE-CELL DIML . 585)
(T VARIABLE-VALUE-CELL A.E.TYPE . 612)
(0 VARIABLE-VALUE-CELL #ROWS . 386)
(0 VARIABLE-VALUE-CELL #ELTS/ROW . 389)
(1 VARIABLE-VALUE-CELL #ELTS . 588)
(0 VARIABLE-VALUE-CELL RANK . 640)
(0 VARIABLE-VALUE-CELL ANCHOROFFSET . 572)
(0 VARIABLE-VALUE-CELL DAROFFSET . 443)
(0 VARIABLE-VALUE-CELL THISROWBASE . 0)
(0 VARIABLE-VALUE-CELL ALIGNMENT . 595)
(NIL VARIABLE-VALUE-CELL MOD# . 600)
(NIL VARIABLE-VALUE-CELL DAR . 549)
(NIL VARIABLE-VALUE-CELL DARTYPE . 470)
(NIL VARIABLE-VALUE-CELL IV . 655)
(NIL VARIABLE-VALUE-CELL IEP . 630)
(NIL VARIABLE-VALUE-CELL ICP . 637)
(NIL VARIABLE-VALUE-CELL POINTERP . 239)
(NIL VARIABLE-VALUE-CELL BITSPERELEMENT . 349)
(NIL VARIABLE-VALUE-CELL ANCHOR . 565)
(NIL VARIABLE-VALUE-CELL TEM . 657)
(VARIABLE-VALUE-CELL I . 223)
"Invalid dimension"
NIL
(2 VARIABLE-VALUE-CELL I . 0)
(NIL VARIABLE-VALUE-CELL VAL . 203)
ELEMENTTYPE
INITIALELEMENT
INITIALCONTENTS
DISPLACEDTO
TYPENAME
CMLARRAY
Not% of% type% TYPE
CONCAT
DISPLACEDTOBASE
DISPLACEDINDEXOFFSET
ERRORX
ALIGNMENT
FILLPOINTER
HELP
"Bad keyword"
POINTER
XPOINTER
FIXP
FIXNUM
CELL
FLOATP
FLONUM
WORD
SMALLPOSP
"Only in Interlisp-D"
DOUBLEBYTE
BYTE
CHARACTER
NIBBLE
BIT
MOD
65536
INTEGERLENGTH
"\AT.MOD.BIT"
SHOULDNT
"Bad type specifier"
Inconsistent% options
((INITIALELEMENT INITIALCONTENTS) . 0)
\CML.ICP.CHECK
((DISPLACEDTO INITIALELEMENT) . 0)
((DISPLACEDTO INITIALCONTENTS) . 0)
"Attempt to displace to a cramped array"
"Displaceing pointer array to non-pointer one."
"Displaceing non-pointer array to pointer one."
32
0.0
ARRAY
NCREATE
\MARGINTO
POWEROFTWOP
APPEND
APPLY
FILLARRAY
(FLOATT IUNBOX SKLST SMALLT LIST2 SKNI KT MKN BHC SKI CONSNL SKNLST KNIL ASZ ENTERF)   P   H   P   X   %x
 X W       [ 	x   hi 0 a h S h ;   6 % E 1   p 	 + @ "   G &`c  E =  1  * p !    h   '`      8   ( < &x0 %X !p{  r xj  V 8Q  N 8H p X x   c  U 
( L   
     # "  !`  8  x~ X| hm Hh x5 @! p 0   P
     ` z  w   \ 
@ P  0      
\CML.ICP.CHECK BINARY
            -.           Z   ,<   Z   B  ,\  3B  +   ,<  "  ,~   Z  ,<   [  XB  ,\   Z  2B   +   Z   ,~   Z  ,<  Zp  -,   +   Z   +    Zp  ,<   @     +   Z  	,<   Z   D  ,~   [p  XBp  +       (VARIABLE-VALUE-CELL DIML . 35)
(VARIABLE-VALUE-CELL L . 23)
LENGTH
INITIALCONTENTS
ERROR
(VARIABLE-VALUE-CELL LL . 37)
\CML.ICP.CHECK
(URET1 SKNLST KT KNIL ENTERF)                (      
\MARGINTO BINARY
    ~    s    {-.          sZ   ,<   [  2B   +      t,<   [  [  2B   +   7   Z   ,<   @  u `+   qZ   ,<      
."  (B,   B  w,<   Zp  ."  ,<   Zw,   ,\   B  Zp  /   /   XB   Z   3B   +   C   /"   ,   ,<   @  w  +   B    ,>  q,>    `      ,^   /   3b  +   Z` ,~   Z  ,>  q,>      (B.Bx  ,^   /   ."  ,<      A"   1B   +   /Z  ,>  q,>      #(B.Bx  ,^   /   ."     ,>  q,>      rABx  Z   A"GBx  ,^   /    $   +   :Z  %,>  q,>      &(B.Bx  ,^   /   ."     ,>  q,>      rABx  Z  ,A"(B  	GBx  ,^   /    $   ,\   B  Z  6   ;,>  q,>       .Bx  ,^   /   ,   XB  ;   1."   ,   XB  @+   +   p   /"   ,   ,<   @  y  +   p   A,>  q,>    `      ,^   /   3b  +   LZ` ,~   Z  /,<   Z  F,<  Z   B  z,<   Zw,>  q,>    w(B.Bx  ,^   /   ."  ,<    wA"   1B   +   aZw~,>  q,>    w(B.Bx  ,^   /   ."     ,>  q,>      rABx  ZwA"GBx  ,^   /    $   +   kZw~,>  q,>    w(B.Bx  ,^   /   ."     ,>  q,>      rABx  ZwA"(B  	GBx  ,^   /    $   ,\   B  Zp  /     M."   ,   XB  m+   FZ  L,~   ,~      x    a
 
@D (@(   P
 
  @   (VARIABLE-VALUE-CELL DIML . 10)
(VARIABLE-VALUE-CELL THISROWBASE . 127)
(VARIABLE-VALUE-CELL #ELTS/ROW . 122)
SHOULDNT
(VARIABLE-VALUE-CELL #HYPER.ROWS . 134)
(VARIABLE-VALUE-CELL NEXTDIML . 156)
(VARIABLE-VALUE-CELL LASTDIMENSIONP . 39)
(NIL VARIABLE-VALUE-CELL MARGINARRAY . 224)
ARRAY
(0 . 1)
NIL
(0 VARIABLE-VALUE-CELL I . 222)
(0 . 1)
NIL
(0 VARIABLE-VALUE-CELL I . 0)
\MARGINTO
(FIXT BHC GUNBOX MKN KT KNIL ENTERF)   l  : x   ` k X ` 0 T 	( ?   4 p ) (  8         o P B    X       P   p        
AREF BINARY
     *      %-.            0"   +   ,< " Z`  ,<   ,<p  " 3B +   	,<p  ,< " D +   
Zp  /   ,<   @    
,~   [   XB   Z  " ,   XB   Z  ,<      ."   ,   ,\  3B  +   Z  ,<   ,< $ +   Z  0B   +   Z  ,~   Z  Z  ,<   Z  [  ,<   @  @ +   QZ`  -,   +   +   EZ  XB       .wZ  XB   -,   +   %,<   ,< $ +   A   !1"   +   +   %,> ,>          ,^   /   3"  +   -Z  &,<   ,< $ +   AZ   Z  3B  +   =Z   ,> ,>      +(B.Bx  ,^   /   ."     ,> ,>      1A"   1B   +   8^"   +   9^"  	"       ,^   /   (B  A"XB  /+   A   5,> ,>      <.Bx  ,^   /   ,   XB  =[`  XB`     -."   ,   XB  B+      A,> ,>   Z  [ ,       ,^   /   3b  +   K   +   P   E,> ,>   Z  F,   .Bx  ,^   /   ,   ,~   Z` ,~   XB  KZ  M" ,   XB      S    ^"  @3"  +   Z  T0B  +   eZ  ,> ,>      Q(B.Bx  ,^   /   ."     ,> ,>      YA"   1B   +   a^"   +   a^"  	"       ,^   /   (B  A",~   0B  +   hZ  X,<  Z  ^D  ,~   1B  +   j0B  +   mZ  f,<  Z  gD !,~   0B  +   pZ  j,<  Z  kD !,~   0B  +   tZ  n,<  Z  oD ",~   0B  +   wZ  q,<  Z  rD ",~   0B  +   {Z  u,<  Z  vD #,~   0B  +   ~Z  x,<  Z  yD #,~      ,~   Z  |,<      },> ,>      V,> ,>   ^"?ABx  ,^   /   ,   XB ,   $Bx  ,^   /   ,   ,<   Z F $XB  Z  R" 3B +  Z 
,~   Z ,<   Z @   Z [  Z  D $,~   
            G< @HLe(  (  @J HHHHH! 	`         (VARIABLE-VALUE-CELL NARGS . 92)
(VARIABLE-VALUE-CELL CMLARRAYDATATYPE . 287)
Too% few% args
ERROR
TYPENAME
CMLARRAY
Not% of% type% TYPE
CONCAT
(VARIABLE-VALUE-CELL ARRAY . 286)
(NIL VARIABLE-VALUE-CELL ANCHOR . 255)
(NIL VARIABLE-VALUE-CELL RANK . 44)
(NIL VARIABLE-VALUE-CELL I . 284)
(NIL VARIABLE-VALUE-CELL J . 275)
Array% Rank% Mismatch
(0 . 1)
(VARIABLE-VALUE-CELL MARGINS . 125)
NIL
(NIL VARIABLE-VALUE-CELL ILIMIT . 80)
(NIL VARIABLE-VALUE-CELL I . 0)
(2 VARIABLE-VALUE-CELL K . 136)
Array% index% not% FIXP
Array% index% out% of% bounds
SHOULDNT
\GETBASEBYTE
\GETBASEDOUBLEBYTE
\GETBASEBIT
\GETBASENIBBLE
\GETBASEPTR
\GETBASEFIXP
\GETBASEFLOATP
\GETBASEBITS
IMOD
(IUNBOX SKNI SKNLST ASZ MKN BHC ENTERF) x N 	   0   h   @ x P q ` j  f      	 h T 
 D   x    @ \ 
  J  ; @ * 0      
ASET BINARY
   x   _   q-.        _    0"  +   ,< `" aZ`  ,<   Z` ,<   ,<p  " a3B b+   
,<p  ,< b" cD a+   Zp  /   ,<   @ c @ ,~   Z  ,<   ^"  ,> [,>   Z   " \,   XB   ,   .Bx  ,^   /   ,   ,\  3B  +   Z  ,<   ,< f$ a+   )Z  " \,   1B  +   1B  +   1B  +   0B  +    Z   -,   +   %+   "0B  +   %Z  "   +   %,< g,<   ,   B g+   )Z  0B   +   )Z  @   Z  !QD  Z  ',~   [  &XB   Z  )Z  ,<   Z  *[  ,<   @ h @ +   cZ`  -,   +   1+   WZ  XB       .wZ  XB   -,   +   7,<   ,< k$ a+   S   31"   +   =   7,> [,>      1    ,^   /   3"  +   ?Z  8,<   ,< k$ a+   SZ  2Z  3B  +   OZ   ,> [,>      =(B.Bx  ,^   /   ."     ,> [,>      CA"   1B   +   J^"   +   K^"  	"       ,^   /   (B  A"XB  A+   S   G,> [,>      N.Bx  ,^   /   ,   XB  O[`  XB`     ?."   ,   XB  T+   /   S,> [,>   Z  ,[ ,       ,^   /   3b  +   ]  l+   b   W,> [,>   Z  X,   .Bx  ,^   /   ,   ,~   Z` ,~   XB  ]Z  _" \,   XB   ,       ^"  @3"  +  7Z  e0B  +  Z  *,> [,>      c(B.Bx  ,^   /   ."  ,<      kA"   1B   +   {Z  j,> [,>      o(B.Bx  ,^   /   ."     ,> [,>     ]ABx  Z  (A"GBx  ,^   /    $   +  Z  q,> [,>      r(B.Bx  ,^   /   ."     ,> [,>     ]ABx  Z  xA"(B  	GBx  ,^   /    $   ,\   B  Z +   (0B  +    A"  ,   XB 	Z  {,<  Z  },<  F l+   (1B  +  0B  +    
A",   XB Z ,<  Z ,<  F m+   (0B  +    A"   ,   XB Z ,<  Z ,<  F m+   (0B  +  !  A"  ,   XB Z ,<  Z ,<  F n+   (0B  +  %Z ,<  Z ,<  Z F n+   (0B  +  .^"   ,> [,>     $.Bx  ,^   /   ,   XB (Z ",<  Z #,<  F o+   (0B  +  6^"   ,> [,>     *.Bx  ,^   /   ,   XB 0Z +,<  Z ,,<  F o+   (  l+   (Z 3,<     4,> [,>      h,> [,>   ^"?ABx  ,^   /   ,   XB :,   $Bx  ,^   /   ,   ,<   Z >,<   Z  d" ^3B ^+  V  3(B   ,> [,>   Z   ,> [,>     A(B.Bx  ,^   /   ."     ,> [,>     HA"   1B   +  O^"   +  P^"  	"       ,^   /   (B  A",   ABx  ,^   /   ,   +  ZZ D,<   Z B@  'Z [  Z  D pXB VH p+   (   
   x          Ao NJS&d Le(  (  @J  @@ 4P( 5 	            (VARIABLE-VALUE-CELL NARGS . 128)
(VARIABLE-VALUE-CELL CMLARRAYDATATYPE . 431)
(VARIABLE-VALUE-CELL \RJ1M . 397)
Too% few% args
ERROR
TYPENAME
CMLARRAY
Not% of% type% TYPE
CONCAT
(VARIABLE-VALUE-CELL VAL . 436)
(VARIABLE-VALUE-CELL ARRAY . 430)
(NIL VARIABLE-VALUE-CELL ANCHOR . 367)
(NIL VARIABLE-VALUE-CELL RANK . 74)
(NIL VARIABLE-VALUE-CELL I . 369)
(NIL VARIABLE-VALUE-CELL J . 409)
Array% Rank% Mismatch
32
ERRORX
(0 . 1)
(VARIABLE-VALUE-CELL MARGINS . 161)
NIL
(NIL VARIABLE-VALUE-CELL ILIMIT . 116)
(NIL VARIABLE-VALUE-CELL I . 0)
(3 VARIABLE-VALUE-CELL K . 172)
Array% index% not% FIXP
Array% index% out% of% bounds
SHOULDNT
\PUTBASEBYTE
\PUTBASEDOUBLEBYTE
\PUTBASEBIT
\PUTBASENIBBLE
\PUTBASEPTR
\PUTBASEFIXP
\PUTBASEFLOATP
IMOD
\PUTBASEBITS
(FIXT SKNLST LIST2 FLOATT SKNI ASZ IUNBOX MKN BHC ENTERF) h {    0    $    "    5 x   p&   ` p	   &   P  0   @? p ` (    V > 8+ `   ` b 
h S (      XR 0A `3 (   { X n   \ 
0 M ` < H        
\AREF.1 BINARY
        x    i    u-.          iZ   B  k3B  k+   Z  ,<   ,<  l"  lD  m+   Z  XB  Z  "  g1B   +   Z  ,<   ,<  m$  m+   Z   -,   +   ,<   ,<  n$  m+      1"   +      ,>  g,>   Z  	Z  Z  ,       ,^   /   3"  +   Z  ,<   ,<  n$  m   ,>  g,>   Z  [ ,       ,^   /   3b  +      o   ,>  g,>   Z  ,   .Bx  ,^   /   ,   XB  Z   "  h,   ,<   [  $,<   @  o @ ,~           ^"  @3"  +   TZ  (0B  +   9Z   ,>  g,>      #(B.Bx  ,^   /   ."     ,>  g,>      .A"   1B   +   5^"   +   6^"  	"       ,^   /   (B  A",~   0B  +   =Z  ,,<  Z  2D  p,~   1B  +   ?0B  +   AZ  :,<  Z  ;D  q,~   0B  +   EZ  ?,<  Z  @D  q,~   0B  +   HZ  B,<  Z  CD  r,~   0B  +   LZ  F,<  Z  GD  r,~   0B  +   OZ  I,<  Z  JD  s,~   0B  +   SZ  M,<  Z  ND  s,~      o,~   Z  P,<      Q,>  g,>      +,>  g,>   ^"?ABx  ,^   /   ,   XB  V,   $Bx  ,^   /   ,   ,<   Z  ZF  tXB  UZ  &"  h3B  i+   bZ  _,~   Z  a,<   Z  _@   Z [  Z  D  t,~   
            rr   ! "(HH! @      (VARIABLE-VALUE-CELL ARRAY . 199)
(VARIABLE-VALUE-CELL I . 197)
(VARIABLE-VALUE-CELL CMLARRAYDATATYPE . 200)
TYPENAME
CMLARRAY
Not% of% type% TYPE
CONCAT
ERROR
Array% Rank% Mismatch
Array% index% not% FIXP
Array% index% out% of% bounds
SHOULDNT
(VARIABLE-VALUE-CELL J . 188)
(VARIABLE-VALUE-CELL ANCHOR . 168)
\GETBASEBYTE
\GETBASEDOUBLEBYTE
\GETBASEBIT
\GETBASENIBBLE
\GETBASEPTR
\GETBASEFIXP
\GETBASEFLOATP
\GETBASEBITS
IMOD
(ASZ MKN BHC IUNBOX SKNI ENTERF)   
 M 	 F ( ? ` : H   ` [ ` $    ] ( 8  # `     \    P   X      
\ASET.1 BINARY
     4   "   /-.         "Z   B %3B %+   Z  ,<   ,< &" &D '+   Z  XB  Z  " 1B   +   Z  ,<   ,< '$ '+   Z   -,   +   ,<   ,< ($ '+      1"   +      ,> ,>   Z  	Z  Z  ,       ,^   /   3"  +   Z  ,<   ,< ($ '   ,> ,>   Z  [ ,       ,^   /   3b  +     )   ,> ,>   Z  ,   .Bx  ,^   /   ,   XB  [   ,<   Z  $"  ,   ,<   @ ) @ +          ^"  @3"  +   zZ  (0B  +   JZ   ,> ,>      #(B.Bx  ,^   /   ."  ,<      .A"   1B   +   >Z  ,,> ,>      1(B.Bx  ,^   /   ."     ,> ,>      ABx  Z   A"GBx  ,^   /    $   +   HZ  3,> ,>      5(B.Bx  ,^   /   ."     ,> ,>     !ABx  Z  :A"(B  	GBx  ,^   /    $   ,\   B  Z  E,~   0B  +   P   IA"  ,   XB  KZ  >,<  Z  ?,<  F *,~   1B  +   R0B  +   W   MA",   XB  RZ  M,<  Z  N,<  F +,~   0B  +   ]   TA"   ,   XB  XZ  T,<  Z  U,<  F +,~   0B  +   c   ZA"  ,   XB  ^Z  Z,<  Z  [,<  F ,,~   0B  +   hZ  `,<  Z  a,<  Z  `F ,,~   0B  +   p^"   ,> ,>      f.Bx  ,^   /   ,   XB  jZ  d,<  Z  e,<  F -,~   0B  +   y^"   ,> ,>      m.Bx  ,^   /   ,   XB  sZ  m,<  Z  n,<  F -,~     ),~   Z  v,<      w,> ,>      +,> ,>   ^"?ABx  ,^   /   ,   XB  |,   $Bx  ,^   /   ,   ,<   Z  ,<   Z  %" !3B "+     u(B   ,> ,>   Z   ,> ,>     (B.Bx  ,^   /   ."     ,> ,>     
A"   1B   +  ^"   +  ^"  	"       ,^   /   (B  A",   ABx  ,^   /   ,   +  Z ,<   Z @   Z [  Z  D .XB H .,~   Z ,~   
      x          rr   	! @(@ % $ 	( J 
	  9( 
      (VARIABLE-VALUE-CELL VAL . 316)
(VARIABLE-VALUE-CELL ARRAY . 307)
(VARIABLE-VALUE-CELL I . 246)
(VARIABLE-VALUE-CELL \RJ1M . 274)
(VARIABLE-VALUE-CELL CMLARRAYDATATYPE . 308)
TYPENAME
CMLARRAY
Not% of% type% TYPE
CONCAT
ERROR
Array% Rank% Mismatch
Array% index% not% FIXP
Array% index% out% of% bounds
SHOULDNT
(VARIABLE-VALUE-CELL ANCHOR . 244)
(VARIABLE-VALUE-CELL J . 286)
\PUTBASEBYTE
\PUTBASEDOUBLEBYTE
\PUTBASEBIT
\PUTBASENIBBLE
\PUTBASEPTR
\PUTBASEFIXP
\PUTBASEFLOATP
IMOD
\PUTBASEBITS
(FIXT ASZ MKN BHC IUNBOX SKNI ENTERF)   I `    i H ^  R 
 K H     v X ` ( T 	X ' @     X  u P H ( =   1 8  h   h    P   X      
\AREF.2 BINARY
        
   -.         
Z   B 3B +   Z  ,<   ,< " D +   Z  XB  Z  " 1B  +   Z  ,<   ,< $ Z  	Z  ,<   Z  [  ,<   @  @ +   DZ   -,   +   ,<   ,< $ +   (   1"   +      ,> ,>   Z`  ,   ,> ,>   [`  XB`  ,^   /       ,^   /   3"  +   Z  ,<   ,< $ +   (    1"   +   &   ,> ,>   Z`  ,       ,^   /   3"  +   (Z  !,<   ,< $ Z   ,> ,>      (B.Bx  ,^   /   ."     ,> ,>      )A"   1B   +   1^"   +   1^"  	"       ,^   /   (B  A",   ,> ,>      &.Bx  ,^   /   ,   XB  (   8,> ,>   Z  [ ,       ,^   /   3b  +   ?     9,> ,>   Z  :,   .Bx  ,^   /   ,   ,~   XB  .Z  @" ,   ,<   [  D,<   @  @ ,~      6    ^"  @3"  +   tZ  I0B  +   ZZ   ,> ,>      D(B.Bx  ,^   /   ."     ,> ,>      NA"   1B   +   V^"   +   V^"  	"       ,^   /   (B  A",~   0B  +   ]Z  M,<  Z  SD ,~   1B  +   _0B  +   bZ  [,<  Z  \D ,~   0B  +   eZ  _,<  Z  `D ,~   0B  +   iZ  c,<  Z  dD ,~   0B  +   lZ  f,<  Z  gD ,~   0B  +   pZ  j,<  Z  kD ,~   0B  +   sZ  m,<  Z  nD ,~     ,~   Z  q,<      r,> ,>      K,> ,>   ^"?ABx  ,^   /   ,   XB  w,   $Bx  ,^   /   ,   ,<   Z  {F XB  uZ  F" 	3B 	+  Z  ,~   Z ,<   Z  @   Z [  Z  D ,~   
            `)rD N(	P @  "(HHH! @       (VARIABLE-VALUE-CELL ARRAY . 264)
(VARIABLE-VALUE-CELL I . 262)
(VARIABLE-VALUE-CELL J . 253)
(VARIABLE-VALUE-CELL CMLARRAYDATATYPE . 265)
TYPENAME
CMLARRAY
Not% of% type% TYPE
CONCAT
ERROR
Array% Rank% Mismatch
(0 . 1)
(VARIABLE-VALUE-CELL \LinearIndex . 126)
Array% index% not% FIXP
Array% index% out% of% bounds
SHOULDNT
(VARIABLE-VALUE-CELL J . 0)
(VARIABLE-VALUE-CELL ANCHOR . 233)
\GETBASEBYTE
\GETBASEDOUBLEBYTE
\GETBASEBIT
\GETBASENIBBLE
\GETBASEPTR
\GETBASEFIXP
\GETBASEFLOATP
\GETBASEBITS
IMOD
(ASZ MKN BHC IUNBOX SKNI ENTERF)    m   f 0 _ h [ 	P   h { h D    ` {  Q 8 >  4 H % H     |   < X $           
\ASET.2 BINARY
     V   B   P-.          BZ   B E3B F+   Z  ,<   ,< F" GD G+   Z  XB  Z  " ?1B  +   Z  ,<   ,< H$ GZ  	Z  ,<   Z  [  ,<   @ H @ +   DZ   -,   +   ,<   ,< I$ G+   (   1"   +      ,> ?,>   Z`  ,   ,> ?,>   [`  XB`  ,^   /       ,^   /   3"  +   Z  ,<   ,< J$ G+   (    1"   +   &   ,> ?,>   Z`  ,       ,^   /   3"  +   (Z  !,<   ,< J$ GZ   ,> ?,>      (B.Bx  ,^   /   ."     ,> ?,>      )A"   1B   +   1^"   +   1^"  	"       ,^   /   (B  A",   ,> ?,>      &.Bx  ,^   /   ,   XB  (   8,> ?,>   Z  [ ,       ,^   /   3b  +   ?  J   9,> ?,>   Z  :,   .Bx  ,^   /   ,   ,~   XB  .[  @,<   Z  D" @,   ,<   @ K @ ,~      6    ^"  @3"  +  Z  I0B  +   kZ   ,> ?,>      D(B.Bx  ,^   /   ."  ,<      NA"   1B   +   ^Z  M,> ?,>      R(B.Bx  ,^   /   ."     ,> ?,>     @ABx  Z   A"GBx  ,^   /    $   +   iZ  T,> ?,>      U(B.Bx  ,^   /   ."     ,> ?,>     AABx  Z  [A"(B  	GBx  ,^   /    $   ,\   B  Z  e+  >0B  +   q   jA"  ,   XB  lZ  ^,<  Z  `,<  F L+  >1B  +   s0B  +   x   mA",   XB  sZ  n,<  Z  o,<  F L+  >0B  +   ~   tA"   ,   XB  yZ  u,<  Z  v,<  F M+  >0B  +     zA"  ,   XB  Z  {,<  Z  |,<  F M+  >0B  +  Z ,<  Z ,<  Z  F N+  >0B  +  ^"   ,> ?,>     .Bx  ,^   /   ,   XB Z ,<  Z ,<  F N+  >0B  +  ^"   ,> ?,>     .Bx  ,^   /   ,   XB Z ,<  Z ,<  F O+  >  J+  >Z ,<     ,> ?,>      K,> ?,>   ^"?ABx  ,^   /   ,   XB ,   $Bx  ,^   /   ,   ,<   Z !,<   Z  E" A3B B+  9  (B   ,> ?,>   Z   ,> ?,>     $(B.Bx  ,^   /   ."     ,> ?,>     +A"   1B   +  2^"   +  3^"  	"       ,^   /   (B  A",   ABx  ,^   /   ,   +  =Z ',<   Z %@   Z [  Z  D OXB 9H PZ   ,~   
      x          `)rD N(	P @  @(@ 5 4 ( j 	  9 
       (VARIABLE-VALUE-CELL VAL . 378)
(VARIABLE-VALUE-CELL ARRAY . 372)
(VARIABLE-VALUE-CELL I . 311)
(VARIABLE-VALUE-CELL J . 351)
(VARIABLE-VALUE-CELL \RJ1M . 339)
(VARIABLE-VALUE-CELL CMLARRAYDATATYPE . 373)
TYPENAME
CMLARRAY
Not% of% type% TYPE
CONCAT
ERROR
Array% Rank% Mismatch
(0 . 1)
(VARIABLE-VALUE-CELL \LinearIndex . 126)
Array% index% not% FIXP
Array% index% out% of% bounds
SHOULDNT
(VARIABLE-VALUE-CELL ANCHOR . 309)
(VARIABLE-VALUE-CELL J . 0)
\PUTBASEBYTE
\PUTBASEDOUBLEBYTE
\PUTBASEBIT
\PUTBASENIBBLE
\PUTBASEPTR
\PUTBASEFIXP
\PUTBASEFLOATP
IMOD
\PUTBASEBITS
(KNIL FIXT ASZ MKN BHC IUNBOX SKNI ENTERF)  ?    i h    	 P   s   l 	P   $  ` 0 u ` G @ 9   8 X. @! `  c ` X 
 C ` 8 @ , X  0   p"   < X $           
ARRAYRANK BINARY
            -.          Z   @   "  ,   ,~   
     (VARIABLE-VALUE-CELL CMLARRAY . 3)
(VARIABLE-VALUE-CELL CMLARRAYDATATYPE . 4)
(MKN ENTERF)    @      
ARRAYDIMENSIONS BINARY
                -.          Z   B  3B  +   Z  ,<   ,<  "  D  +   Z  XB  Z   3B   +   -,   +   ,   XB  Z  @   Z  ,<   @     +   Z  
3B   +   ,<  D  3B   +   Z   ,~   Z  B  ,~   ,~   
N    (VARIABLE-VALUE-CELL CMLARRAY . 22)
(VARIABLE-VALUE-CELL OPTIONS . 29)
(VARIABLE-VALUE-CELL CMLARRAYDATATYPE . 23)
TYPENAME
CMLARRAY
Not% of% type% TYPE
CONCAT
ERROR
(VARIABLE-VALUE-CELL L . 38)
NOCOPY
MEMB
COPY
(CONSNL SKNLST KNIL ENTERF)      
       	       
ARRAYDIMENSION BINARY
              -.          Z   @   Z  ,<   Z   -,   +      1"   +      ,>  ,>   Z  @  "      ,^   /   2"  +      +   ,<  Z  ,<   ,   B  ,   ."   ,   D  Z  ,~      
 D     (VARIABLE-VALUE-CELL CMLARRAY . 16)
(VARIABLE-VALUE-CELL AXIS# . 27)
(VARIABLE-VALUE-CELL CMLARRAYDATATYPE . 17)
27
ERRORX
NTH
(MKN IUNBOX LIST2 BHC SKI ENTERF)                         
ARRAYELEMENTTYPE BINARY
    +    "    *-.           "Z   B  #3B  #+   Z  ,<   ,<  $"  $D  %+   Z  XB  Z  "  ",   ,<   @  %   +   !        ^"  @3"  +    Z  0B  +   Z   ,~   0B  +   Z  &,~   1B  +   0B  +   Z  &,~   0B  +   Z  ',~   0B  +   Z  ',~   0B  +   Z  (,~   0B  +   Z  (,~   0B  +   Z  ),~      ),~   Z  Z ,~   ,~     B#,f3      (VARIABLE-VALUE-CELL CMLARRAY . 64)
TYPENAME
CMLARRAY
Not% of% type% TYPE
CONCAT
ERROR
(VARIABLE-VALUE-CELL J . 27)
((MOD 256) . 0)
((MOD 65536) . 0)
((MOD 2) . 0)
((MOD 16) . 0)
FIXNUM
FLONUM
XPOINTER
SHOULDNT
(KT ASZ MKN ENTERF)     `     `  0  p         
ARRAYINBOUNDSP BINARY
    -    '    ,-.         'Z   0B   +      (Z`  ,<   @  (   ,~   Z  ,<   Z   @   "  &."   ,   ,\  3B  +   ,<  )"  )Z  Z  ,<   @  *  +   #Z`  -,   +   +   "Z  XB       .wZ  ,       ^"   2b  +      ,>  &,>      .wZ  ,       ,^   /   2b  +   Z  2B   +   Z   XB` +   "[`  XB`     ."   ,   XB   +   Z` ,~   2B   +   %7   Z   ,~   
    q& P$@    (VARIABLE-VALUE-CELL NARGS . 12)
(VARIABLE-VALUE-CELL CMLARRAYDATATYPE . 15)
HELP
(VARIABLE-VALUE-CELL CMLARRAY . 24)
"Rank Mismatch"
ERROR
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL I . 56)
(2 VARIABLE-VALUE-CELL K . 67)
(KT KNIL BHC IUNBOX SKNLST MKN ASZ ENTERF)  X     & H          H        
           
ARRAYTOTALSIZE BINARY
      9    1    7-.           1Z   B  23B  3+   Z  ,<   ,<  3"  4D  4+   Z  XB  Z   2B   +   Z  "  00B   +   Z  	[ ,   ."   ,   +   Z  5,<   Z  Z  D  5,<   @  6   +   /Z  3B   +   .Z  "  0,   ,<   @  6   +   *    1"  @+      ,>  1,>   ^"?ABx  ,^   /   ,   ,~   Z  0B  +    Z"  ,~   0B  +   "Z"  ,~   1B  +   $0B  +   %Z"  ,~   0B  +   'Z"   ,~   0B  +   )Z"  ,~   Z"  ,~   ,   ,>  1,>       $Bx  ,^   /   ,   ,~   Z  +,~   ,~   (@      
AEJ) "A        (VARIABLE-VALUE-CELL CMLARRAY . 40)
(VARIABLE-VALUE-CELL IN.BITS? . 37)
TYPENAME
CMLARRAY
Not% of% type% TYPE
CONCAT
ERROR
ITIMES
APPLY
(VARIABLE-VALUE-CELL N . 93)
(VARIABLE-VALUE-CELL TYPE . 59)
(ASZ BHC MKN IUNBOX KNIL ENTERF)   )   ' ` % @ #   !       . P   h  `     + P   @ 	       
ARRAYROWMAJORINDEX BINARY
       ^    R    [-.          R    0"   +   ,<  R"  SZ`  ,<   ,<p  "  S3B  T+   	,<p  ,<  T"  UD  S+   
Zp  /   ,<   @  U  +   PZ  ,<   Z   "  Q,   XB   ,   ."   ,   ,\  3B  +   Z  ,<   ,<  V$  S,~   Z  0B   +   [  ,~   Z  Z  ,<   Z  [  ,<   @  W @ ,~   Z`  -,   +   +   DZ  XB       .wZ  XB   -,   +   $,<   ,<  Z$  S+   @    1"   +   *   $,>  Q,>          ,^   /   3"  +   ,Z  %,<   ,<  Z$  S+   @Z  Z  3B  +   <Z   ,>  Q,>      *(B.Bx  ,^   /   ."     ,>  Q,>      0A"   1B   +   7^"   +   8^"  	"       ,^   /   (B  A"XB  .+   @   4,>  Q,>      ;.Bx  ,^   /   ,   XB  <[`  XB`     ,."   ,   XB  A+      @,>  Q,>   Z  [ ,       ,^   /   3b  +   J   [+   O   D,>  Q,>   Z  E,   .Bx  ,^   /   ,   ,~   Z` ,~   ,~   
    G<(@L 0q P           (VARIABLE-VALUE-CELL NARGS . 90)
Too% few% args
ERROR
TYPENAME
CMLARRAY
Not% of% type% TYPE
CONCAT
(VARIABLE-VALUE-CELL ARRAY . 152)
(NIL VARIABLE-VALUE-CELL RANK . 42)
Array% Rank% Mismatch
(0 . 1)
(VARIABLE-VALUE-CELL MARGINS . 123)
NIL
(NIL VARIABLE-VALUE-CELL ILIMIT . 78)
(NIL VARIABLE-VALUE-CELL I . 149)
(2 VARIABLE-VALUE-CELL K . 134)
Array% index% not% FIXP
Array% index% out% of% bounds
SHOULDNT
(SKNI SKNLST ASZ IUNBOX MKN BHC ENTERF)      X   h   	X G    	x C   x   	p I   : 0 ) 0      
\FastAREFexpander BINARY
              -.           ,<  ,<  Z  Z   ,   ,   ,<   Z  -,   +   ,<  "  +   [  -,   +   ,<  ,<  ,<  Z  ,   +   Z  ,<   Z   ,<  ,<   &  ,   ,   ,~   gH     (VARIABLE-VALUE-CELL X . 25)
(VARIABLE-VALUE-CELL FFUN . 27)
COND
AREFSissyFLG
AREF
Too% few% args
ERROR
fetch
((CMLARRAY CMLANCHOR) . 0)
of
\NoSissyAREFexpander
(ALIST3 CONSNL KT ALIST4 SKNLST ALIST2 CONS ENTERF)        x   H                   
\NoSissyAREFexpander BINARY
     @    2    >-.           2Z   ,<   ,<  4$  4,<   ,<  5$  5[  Z  2B   +      6,<   Z   ,<   ,<   $  6,<   [  ,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   Zw,<   @  7   +   Z   ,<   ,<   $  6,~   Zp  ,   XBp  [wXBw+   /  ,<   @  7 `,~   Z   ,<   ,\   ,<   Z   3B   +   !Z  9+   "Z  :,<   Z   B  :,   XB   Z   -,   +   ,Z  ",<  D  ;3B   +   ,Z  $,<   ,<  ;Z  $F  <XB  *+   1,<  <,<  =,<  =Z  +,<   ,   ,<   Z  (,<   ,   XB  -Z  1,~   1BJ y	%<       (VARIABLE-VALUE-CELL X . 21)
(VARIABLE-VALUE-CELL FFUN . 3)
(VARIABLE-VALUE-CELL CHECKFLG . 62)
2
SUBATOM
(((PAREF \VectorREF) (8AREF \WORDREF.8) (16AREF \WORDREF.16) (4AREF \WORDREF.4) (1AREF \WORDREF.1) (
NAREF \WORDREF.FIXP) (LAREF \WORDREF.FLOATP) (XAREF \WORDREF.PTR)) . 0)
ASSOC
SHOULDNT
LISPFORM.SIMPLIFY
(VARIABLE-VALUE-CELL Y . 42)
(VARIABLE-VALUE-CELL ACCESSOR . 58)
(VARIABLE-VALUE-CELL ARRAYFORM . 95)
(VARIABLE-VALUE-CELL INDICES . 76)
(NIL VARIABLE-VALUE-CELL ACCESSFORM . 99)
((ffetch (CMLARRAY CMLANCHOR) of (DATATYPE.TEST \Array (QUOTE CMLARRAY))) . 0)
((fetch (CMLARRAY CMLANCHOR) of \Array) . 0)
\AREFSET.INDEXFORM
ARGS.COMMUTABLEP.LIST
\Array
SUBST
LAMBDA
((\Array) . 0)
((DECLARE (LOCALVARS \Array)) . 0)
(LIST2 LIST4 ALIST3 BHC COLLCT SKNLST KT KNIL ENTERF)      x   H   8      `             x  H        
\FastASETexpander BINARY
                -.           Z   -,   +   [  -,   +   ,<  "  ,<  ,<  Z  Z  ,   ,   ,<   [  [  -,   +   Z   ,<   ,<  $  3B   +   3B   +   -,   +   ,<  ,<   ,   Z  	,   Z  ,   +   Z  ,<   Z  ,<  ,<   &  ,   ,   ,~   ? M,(   (VARIABLE-VALUE-CELL X . 40)
(VARIABLE-VALUE-CELL FFUN . 42)
Too% few% args
ERROR
COND
AREFSissyFLG
ASET
2
SUBATOM
QUOTE
\0DIM.ASET
\NoSissyASETexpander
(ALIST3 CONSNL CONS21 LIST2 SKNNM KT KNIL ALIST2 CONS SKNLST SKLST ENTERF)         @           p         	        0            
\NoSissyASETexpander BINARY
        n   -.           nZ   ,<   ,<  p$  p,<   Z   ,<   ,<   $  q,<   [  Z  ,<   ,<   $  q,<   [  [  ,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   Zw,<   @  q   +   Z   ,<   ,<   $  q,~   Zp  ,   XBp  [wXBw+   /  ,<   @  r (,~   Z   ,<   ,<  v$  w[  Z  2B   +   !   wXB   Z  x,   XB   Z   3B   +   /,<  x,<  y,<  y,<  z,<  zZ  3B   +   ,3B   +   ,-,   +   ,,<  {,<   ,   ,   ,   ,<   Z  ",<   ,   XB  -Z   XB   Z  #3B   +   :[   2B   +   ;Z  2B  {2B   +   :Z  3-,   +   ;Z   ,<   Z  5D  |XB  03B   +   ;Z   XB   Z  7-,   +   @Z  8,<  D  |3B   +   C+   AB  {3B   +   CZ   XB   +   EZ  92B   +   EZ   XB  ;Z  E3B   +   KZ  =,<  ,<   $  },<   ,<  }Z  /F  ~+   Q,<  ~,<  ,<  Z  J,<  ,   ,<   Z  G,<   ,<   $  },   XB  MZ  B3B   +   WZ  ;,<  ,<  zZ  QF  ~XB  U+   \,<  ~,<  ,<  Z  V,<  ,   ,<   Z  S,<   ,   XB  XZ   B  {2B   +   dZ  \,<   Z  ZD  |3B   +   hZ  O,<   Z  ^D  |3B   +   hZ  b,<   ,< Z  \F  ~XB  f+   m,<  ~,< ,< Z  g,<   ,   ,<   Z  d,<   ,   XB  iZ  m,~   ( $h~+ "!$B+p%<"Ep          (VARIABLE-VALUE-CELL X . 19)
(VARIABLE-VALUE-CELL FFUN . 78)
(VARIABLE-VALUE-CELL CHECKFLG . 97)
2
SUBATOM
LISPFORM.SIMPLIFY
(VARIABLE-VALUE-CELL Y . 41)
(VARIABLE-VALUE-CELL FUN . 57)
(VARIABLE-VALUE-CELL NEWVALFORM . 215)
(VARIABLE-VALUE-CELL ARRAYFORM . 191)
(VARIABLE-VALUE-CELL INDICES . 195)
(NIL VARIABLE-VALUE-CELL SETTORNAME . 66)
(NIL VARIABLE-VALUE-CELL SETTINGFORM . 219)
(NIL VARIABLE-VALUE-CELL SIMPLEINDEXP . 139)
(NIL VARIABLE-VALUE-CELL SIMPLEARRAYP . 164)
(NIL VARIABLE-VALUE-CELL TEM . 134)
(((PASET \WORDSET.Vector) (8ASET \WORDSET.8) (16ASET \WORDSET.16) (1ASET \WORDSET.1) (4ASET \WORDSET.4
) (NASET \WORDSET.FIXP) (LASET \WORDSET.FLOATP) (XASET \WORDSET.PTR)) . 0)
ASSOC
SHOULDNT
((\NewVal (ffetch (CMLARRAY CMLANCHOR) of \Array) (IPLUS (ffetch (CMLARRAY CMLANCHOROFFSET) of \Array)
 \Index)) . 0)
PROGN
AND
((OR (ILESSP \Index 0) (IGREATERP \Index (ffetch (CMLARRAY CMLIMAX) of (DATATYPE.TEST \Array (QUOTE 
CMLARRAY))))) . 0)
ERROR
\Array
QUOTE
CONSTANTEXPRESSIONP
ARGS.COMMUTABLEP
ARGS.COMMUTABLEP.LIST
\AREFSET.INDEXFORM
\Index
SUBST
LAMBDA
((\Index) . 0)
((DECLARE (LOCALVARS \Index)) . 0)
((\Array) . 0)
((DECLARE (LOCALVARS \Array)) . 0)
\NewVal
((\NewVal) . 0)
((DECLARE (LOCALVARS \NewVal)) . 0)
(ALIST2 LIST4 LIST3 ALIST3 LIST2 SKNNM CONS BHC COLLCT SKNLST KNIL KT ENTERF)   
    8 Z 	p   x   X -    m H ,    *    #            = p     d  ^ 
8 G H A x : X 3   ( H   p  @   
 I X B 8 0           
\AREFSET.INDEXFORM BINARY
               -.           [   -,   +   Z  XB  +   Z  ,<   @    +   Z`  -,   +   	+   Z  XB   ,<  Z   ,<  ,<   ,   XB  
[`  XB`  +   Z  [  ,   XB  Z` ,~   Z   3B   +   Z  ,~   ,<  ,<  Z  ,<  ,   ,~   % `&    (VARIABLE-VALUE-CELL INDICES . 42)
(VARIABLE-VALUE-CELL NOANCHOROFFSETFLG . 35)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL I . 19)
((ffetch (CMLARRAY CMLMARGINS) of \Array) VARIABLE-VALUE-CELL MARGINACCFORM . 30)
\VectorREF
IPLUS
((ffetch (CMLARRAY CMLANCHOROFFSET) of \Array) . 0)
(KNIL CONS LIST3 SKNLST ENTERF)            P           
\CMLARRAY.LOCFTRAN BINARY
       {    g    x-.           g@  h  +   gZ   -,   +   Z  XB   ,<   Zp  3B   +   	-,   7   Z   +   
Z   /   3B   +   Z  ,<   ,<  i$  iXB   -,   +   Z  2B  j+   [  [  2B   +   [  Z  XB  -,   +   Z  Z  j,   3B   +   f+   Z   ,~   [  Z  ,<   ,<   $  k,<   [  [  ,<   ,<   Zw-,   +   $Zp  Z   2B   +   " "  +   $[  QD   "  +   ,Zw,<   @  k   +   )Z   ,<   ,<   $  k,~   Zp  ,   XBp  [wXBw+   /  ,<   [  [  Z  [  Z  ,<   ,<  l,<  l&  m,<   @  m `(,~   Z   B  qXB   Z   2B  r+   8Z   XB   +   J3B  j+   ;3B  r+   ;2B  s+   @Z"  XB  5,<  sZ  5,<  ,<  t,   XB  =+   J0B   +   BZ  ?+   J1B  +   E1B  +   E0B  +   J,<  sZ  A,<  B  t,   /"   ,   ,   XB  E+   J   uZ   -,   +   UZ  4,<  D  u3B   +   UZ  J,<   ,<  vZ   F  vXB  PZ  N,<  ,<  vZ  IF  vXB  S+   XZ  v,   XB   Z  Q,   XB   Z  73B   +   _,<  wZ  V,<  Z  W,<  Z  Q,<  Z  T,<  ^"  ,   ,~   ,<  wZ  Z,<  Z  [,<  Z  \,<  Z  ],<  Z  <,<  ^"  ,   ,~   ,~   ,~    D&,BLJ"gyU2J(V         (VARIABLE-VALUE-CELL X . 56)
(NIL VARIABLE-VALUE-CELL NAME . 23)
(NIL VARIABLE-VALUE-CELL MACP . 91)
MACRO
GETP
X
((\FastAREFexpander \FastASETexpander) . 0)
LISPFORM.SIMPLIFY
(VARIABLE-VALUE-CELL Z . 78)
2
-5
SUBATOM
(VARIABLE-VALUE-CELL ARRAYFORM . 173)
(VARIABLE-VALUE-CELL INDICES . 152)
(VARIABLE-VALUE-CELL NBITS . 200)
((fetch (\CMLARRAY CMLANCHOR) of \Array) VARIABLE-VALUE-CELL BASEFORM . 196)
(NIL VARIABLE-VALUE-CELL OFFSETFORM . 198)
(NIL VARIABLE-VALUE-CELL POINTERBYTEP . 176)
(NIL VARIABLE-VALUE-CELL LVARS . 192)
(NIL VARIABLE-VALUE-CELL LVALS . 194)
\AREFSET.INDEXFORM
P
N
L
LLSH
5
INTEGERLENGTH
SHOULDNT
ARGS.COMMUTABLEP.LIST
\Array
SUBST
\POINTERBYTE
\BITSBYTE
(LIST CONSNL ALIST3 MKN IUNBOX LIST3 ASZ COLLCT SKNLST FMEMB BHC KT SKLA KNIL SKLST ENTERF)  h _    X 
h   	   	   	    x   P D 0 A H   0   	@         - 0     ) 8 	        Y 	h !     (  ( 	  x   P   H      
LISTARRAY BINARY
   .      )-.         Z   B 3B +   Z  ,<   ,< " D +   Z  XB  Z  " ,   ,<   [  ,<   Z  	,<   Z  
[ ,<   @   ,~   Z   2B   +   Z"   XB  +   ,<   Z  -,   +      1"   +   Zp  +   Z  ,<   ,<  $ XB  +   /   Z   2B   +   Z   XB  +   $,<   Z  -,   +   !   1"   +   !Zp  +   $Z  ,<   ,< !$ XB  !+   /      ,> ,>      /"       ,^   /   /  ,   XB       1"  @+   0   *,> ,>   ^"?ABx  ,^   /   ,   XB   +   7Z  +1B  +   51B  +   51B  +   50B  +   6Z   +   6Z   XB      )1"   +   =   7,> ,>      $."       ,^   /   3b  +   >,< !"    &,> ,>       .Bx  ,^   /   ,   XB  >   #,> ,>      @.Bx  ,^   /   ,   XB  C,<   Z  B,<  @ " @
,~       ,> ,>    `      ,^   /   3b  +   O+  Z  63B   +   kZ  00B  +   _Z   ,> ,>      J(B.Bx  ,^   /   ."     ,> ,>      TA"   1B   +   [^"   +   \^"  	"       ,^   /   (B  A"+  0B  +   cZ  R,<  Z  XD $+  0B  +   fZ  `,<  Z  aD %+  0B  +   jZ  d,<  Z  eD %+    &+  Z  /3B   +   {Z  g,<     h,> ,>      k$Bx  ,^   /   ,   ,<   Z  oF &XB   Z  " 3B +   vZ  s+  Z  u,<   Z  s@   Z [  Z  D '+  Z  Q0B  +   Z  l,<  Z  mD '+  1B  +  0B  +  Z  |,<  Z  }D (+  0B  +  Z ,<  Z D (+  0B  +  
Z ,<  Z D )+    &XB` Z` 3B   +  ,<   Z` ,   XB` ,\  QB  +  Z` ,   XB` XB`   	."   ,   XB +   JZ` ,~              	M		& P	* t I P
D dj @        (VARIABLE-VALUE-CELL CMLARRAY . 239)
(VARIABLE-VALUE-CELL STARTI . 144)
(VARIABLE-VALUE-CELL ENDI . 142)
(VARIABLE-VALUE-CELL CMLARRAYDATATYPE . 240)
TYPENAME
CMLARRAY
Not% of% type% TYPE
CONCAT
ERROR
(VARIABLE-VALUE-CELL A.E.TYPE . 246)
(VARIABLE-VALUE-CELL ANCHOR . 272)
(VARIABLE-VALUE-CELL OFFST . 137)
(VARIABLE-VALUE-CELL IMAX . 116)
(NIL VARIABLE-VALUE-CELL #ELTS . 113)
(NIL VARIABLE-VALUE-CELL CELLP . 159)
(NIL VARIABLE-VALUE-CELL MODP . 228)
(NIL VARIABLE-VALUE-CELL TEM . 237)
"
 is not a suitable value for the variable:  STARTI"
"
 is not a suitable value for the variable:  ENDI"
"OUT OF RANGE"
(0 . 1)
(VARIABLE-VALUE-CELL I . 296)
NIL
NIL
NIL
\GETBASEPTR
\GETBASEFIXP
\GETBASEFLOATP
SHOULDNT
\GETBASEBITS
IMOD
\GETBASEBYTE
\GETBASEDOUBLEBYTE
\GETBASENIBBLE
\GETBASEBIT
(CONSNL KT BHC SKI ASZ KNIL MKN ENTERF)        6    q h W 	h G ( = x ) P      8       H g @ ` 
( 5 @ 3       H Q p  0      H r x C   *       
FILLARRAY BINARY
   \   D   V-.          DZ   B G3B G+   Z  ,<   ,< H" HD I+   Z  XB  Z   -,   +   
,   XB  Z  " A,   ,<   [  
,<   Z  ,<   Z  [ ,<   Z  	,<   @ I  ,~   Z   2B   +   Z"   XB  +   ,<   Z  -,   +      1"   +   Zp  +   Z  ,<   ,< N$ IXB  +   /   Z   2B   +    Z   XB  +   (,<   Z  -,   +   $    1"   +   $Zp  +   'Z  ",<   ,< N$ IXB  $+    /      ,> A,>      /"       ,^   /   /  ,   XB       1"  @+   4   -,> A,>   ^"?ABx  ,^   /   ,   XB   +   ;Z  " A,   1B  +   91B  +   91B  +   90B  +   :Z   +   ;Z   XB      -1"   +   B   ;,> A,>      (."       ,^   /   3b  +   C,< O" I   ),> A,>       .Bx  ,^   /   ,   XB  C   &,> A,>      D.Bx  ,^   /   ,   XB  G,<   Z  G,<  @ O @+  @    ,> A,>    `      ,^   /   3b  +   TZ` ,~   Z  ;3B   +  Z  /0B  +   uZ   ,> A,>      O(B.Bx  ,^   /   ."  ,<      YA"   1B   +   iZ  W,> A,>      \(B.Bx  ,^   /   ."     ,> A,>     BABx  Z   A"GBx  ,^   /    $   +   sZ  ^,> A,>      `(B.Bx  ,^   /   ."     ,> A,>     BABx  Z  eA"(B  	GBx  ,^   /    $   ,\   B  Z  p+  80B  +   zZ  i,<  Z  j,<  Z  tF Q+  80B  +   ~Z  v,<  Z  w,<  Z  xF Q+  80B  +  Z  {,<  Z  |,<  Z  }F R+  8  R+  8Z  33B   +  $Z  ,<     ,> A,>     $Bx  ,^   /   ,   ,<   Z ,<   Z  4" C3B C+    (B   ,> A,>   Z   ,> A,>     (B.Bx  ,^   /   ."     ,> A,>     A"   1B   +  ^"   +  ^"  	"       ,^   /   (B  A",   ABx  ,^   /   ,   +  #Z ,<   Z @   Z [  Z  D SH S+  8Z  V0B  +  )Z ,<  Z ,<  Z F T+  81B  +  +0B  +  /Z &,<  Z ',<  Z (F T+  80B  +  3Z +,<  Z ,,<  Z -F U+  80B  +  8Z 0,<  Z 1,<  Z 2F U+  8  RZ  ,<   [ 8XB 9,\   Z :3B   +  =Z ;XB 6  5."   ,   XB =+   OZ  ,~        x          @M		M P
U!  @ ! (@(  P<D 9 ( ATA`      (VARIABLE-VALUE-CELL CMLARRAY . 384)
(VARIABLE-VALUE-CELL LIST . 377)
(VARIABLE-VALUE-CELL STARTI . 153)
(VARIABLE-VALUE-CELL ENDI . 151)
(VARIABLE-VALUE-CELL \RJ1M . 288)
(VARIABLE-VALUE-CELL CMLARRAYDATATYPE . 322)
TYPENAME
CMLARRAY
Not% of% type% TYPE
CONCAT
ERROR
(VARIABLE-VALUE-CELL A.E.TYPE . 329)
(VARIABLE-VALUE-CELL ANCHOR . 361)
(VARIABLE-VALUE-CELL OFFST . 146)
(VARIABLE-VALUE-CELL IMAX . 125)
(VARIABLE-VALUE-CELL ITEM . 378)
(NIL VARIABLE-VALUE-CELL CELLP . 169)
(NIL VARIABLE-VALUE-CELL MODP . 300)
(NIL VARIABLE-VALUE-CELL #ELTS . 122)
(NIL VARIABLE-VALUE-CELL TEM . 0)
"
 is not a suitable value for the variable:  STARTI"
"
 is not a suitable value for the variable:  ENDI"
"OUT OF RANGE"
(0 . 1)
(VARIABLE-VALUE-CELL I . 382)
NIL
\PUTBASEPTR
\PUTBASEFIXP
\PUTBASEFLOATP
SHOULDNT
IMOD
\PUTBASEBITS
\PUTBASEBYTE
\PUTBASEDOUBLEBYTE
\PUTBASENIBBLE
\PUTBASEBIT
(IUNBOX FIXT KT BHC SKI ASZ KNIL MKN CONSNL SKNLST ENTERF)   X   @ i    :    @ ( s X h 0 \ 
0 K p A 0 ,      " p   H0 8* `  0 v 
x 9  7 h    < X V 8 ! h  8   x 0 L x 6 8 - @             
\PRINTCMLARRAY BINARY
    $        #-.           Z   ,<   @     ,~   Z   3B   +   	-,   +   	Z  Z 7@  7   Z  XB  B  3B  +   ,<  Z  ,<   ,   B  ,<  Z   D   Z  	Z  ,<   Z  B   ,<   Z  "  ,   ,   ,<   Z  D  !Z  B  !,<   Z  D  !,<  "Z  D   Z  B  "Z   ,~   (@ 
c!!&P  (VARIABLE-VALUE-CELL VARORVAL . 23)
(VARIABLE-VALUE-CELL FILE . 51)
(VARIABLE-VALUE-CELL A . 43)
TYPENAME
CMLARRAY
27
ERRORX
"("
PRIN1
ARRAYELEMENTTYPE
PRINT
LISTARRAY
")"
TERPRI
(ALIST3 MKN LIST2 KNOB SKLA KNIL ENTERF)   H   @   X       h   8        
\READCMLARRAY BINARY
               -.           Z   B  ,<   @    ,~   Z   -,   Z   Z  XB   B  0B  +   Z  3B   +   Z  -,   +   Z  ,<   ,<  $  Z  
,<   ,<  [  Z  ,<   ,<  [  [  Z  J  XB  ,<   [  Z  D  Z  ,~    R&"!    (VARIABLE-VALUE-CELL FILE . 3)
READ
(VARIABLE-VALUE-CELL L . 40)
(NIL VARIABLE-VALUE-CELL TEM . 43)
LENGTH
"Wrong object read in"
ERROR
ELEMENTTYPE
ALIGNMENT
MAKEARRAY
FILLARRAY
(SKNLST ASZ KNIL SKLST ENTERF)  8                   
(PRETTYCOMPRINT CMLARRAYCOMS)
(RPAQQ CMLARRAYCOMS ((* CommonLisp array facilities.) (DECLARE: EVAL@COMPILE DONTCOPY (MACROS 
\MACRO.MX \CHECKTYPE \INDEXABLE.FIXP)) (EXPORT (RECORDS CMLARRAY) (DECLARE: EVAL@COMPILE DONTCOPY (
CONSTANTS * CMLARRAYTYPES) (CONSTANTS \AT.MOD.BIT))) (COMS (MACROS \0DIM.ASET) (* Following macros 
likely differ in the various implementations but at least depend on the \GETBASE... and \PUTBASE... 
series) (MACROS DATATYPE.TEST \WORDREF.PTR \WORDSET.PTR \WORDREF.FIXP \WORDSET.FIXP \WORDREF.FLOATP 
\WORDSET.FLOATP \WORDREF.16 \WORDSET.16 \WORDREF.8 \WORDSET.8 \WORDREF.4 \WORDSET.4 \WORDREF.1 
\WORDSET.1) (FNS \BubbleWORDSET) (DECLARE: EVAL@COMPILE DONTCOPY (FNS \BubbleWORDSET))) (DECLARE: 
COPYWHEN (NEQ COMPILEMODE (QUOTE D)) (* Patch ups for non-D worlds) (FILES MACROAUX) (* Rather than 
forcibly load in NONDADDARITH we cause it to be loaded only when compiling this file, or at 
"last moment" when absolutely needed.) (FNS \NONDADDARITH.TRAMPOLINE) (DECLARE: EVAL@LOADWHEN (NEQ (
SYSTEMTYPE) (QUOTE D)) (DECLARE: EVAL@COMPILEWHEN (NEQ COMPILEMODE (QUOTE D)) DONTCOPY (P (OR (
CONSTANTEXPRESSIONP (QUOTE PTRBLOCK.GCT)) (PROGN (SETQ PTRBLOCK.GCT 1) (CONSTANTS PTRBLOCK.GCT)))) (
FILES NONDADDARITH)) (P (MAPC (QUOTE (LOADBYTE DEPOSITEBYTE \GETBASEBIT \GETBASENIBBLE \GETBASEBYTE 
\GETBASEDOUBLEBYTE \GETBASEFIXP \GETBASEFLOATP \GETBASEPTR \PUTBASEBIT \PUTBASENIBBLE \PUTBASEBYTE 
\PUTBASEDOUBLEBYTE \PUTBASEFIXP \PUTBASEFLOATP \PUTBASEPTR)) (FUNCTION (LAMBDA (X) (MOVD? (FUNCTION 
\NONDADDARITH.TRAMPOLINE) X))))))) (FNS MAKEARRAY \CML.ICP.CHECK \MARGINTO) (FNS AREF ASET) (MACROS 
AREF ASET) (DECLARE: EVAL@COMPILE DONTCOPY (MACROS \AREFSET.LINEARIZE \AREFSET.LINEARIZE1 
\AREFSET.LINEARIZE2)) (FNS \AREF.1 \ASET.1 \AREF.2 \ASET.2) (MACROS ARRAYRANK ARRAYDIMENSIONS 
ARRAYDIMENSION) (FNS ARRAYRANK ARRAYDIMENSIONS ARRAYDIMENSION ARRAYELEMENTTYPE ARRAYINBOUNDSP 
ARRAYTOTALSIZE ARRAYROWMAJORINDEX) (PROP ARGNAMES MAKEARRAY AREF ASET ARRAYINBOUNDSP) (COMS (* The 
"fast" versions of AREF and ASET -- following P causes them all to be set up as macros) (DECLARE: 
EVAL@COMPILE (P ((LAMBDA (C) (MAPC (QUOTE (P X 1 4 8 16 N L)) (FUNCTION (LAMBDA (A) (MAPC (QUOTE (AREF
 ASET)) (FUNCTION (LAMBDA (B) (SETQ C (MKATOM (CONCAT "\" A B))) (PUTPROP (MKATOM (CONCAT A B)) (QUOTE
 MACRO) (LIST (QUOTE X) (LIST (MKATOM (CONCAT "\Fast" B "expander")) (QUOTE X) (LIST (QUOTE QUOTE) C))
)) (PUTPROP C (QUOTE MACRO) (LIST (QUOTE X) (LIST (MKATOM (CONCAT "\NoSissy" B "expander")) (QUOTE X) 
(LIST (QUOTE QUOTE) C)))))))))))))) (FNS \FastAREFexpander \NoSissyAREFexpander \FastASETexpander 
\NoSissyASETexpander \AREFSET.INDEXFORM \CMLARRAY.LOCFTRAN) (INITVARS (AREFSissyFLG NIL)) (PROP 
GLOBALVAR AREFSissyFLG)) (FNS LISTARRAY FILLARRAY \PRINTCMLARRAY \READCMLARRAY) (FILEPKGCOMS CMLARRAYS
) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA) (NLAML) (LAMA 
ARRAYROWMAJORINDEX ARRAYINBOUNDSP ASET AREF MAKEARRAY \NONDADDARITH.TRAMPOLINE)))))
(DATATYPE CMLARRAY ((CMLRANK BITS 7) (CMLANCHOR POINTER) (CMLTYPE BITS 8) (CMLANCHOROFFSET POINTER) (
CMLMARGINS POINTER) (CMLDIML POINTER) (CMLIMAX POINTER) (CMLALIGN BITS 16) (CMLMOD POINTER) (
CMLMOD#P2P FLAG)) (ACCESSFNS (CMLMOD# (CADR (fetch CMLMOD of DATUM)))))
(/DECLAREDATATYPE (QUOTE CMLARRAY) (QUOTE ((BITS 7) POINTER (BITS 8) POINTER POINTER POINTER POINTER (
BITS 16) POINTER FLAG)))
(PUTPROPS \0DIM.ASET MACRO (OPENLAMBDA (FUNNAME \NewVal \Array) (OR (ZEROP (ARRAYRANK \Array)) (ERROR 
\Array FUNNAME)) (freplace (CMLARRAY CMLANCHOR) of \Array with \NewVal)))
(PUTPROPS DATATYPE.TEST MACRO (OPENLAMBDA (X TYPE) (COND ((NOT (TYPENAMEP X TYPE)) (ERROR X (CONCAT (
QUOTE Not% of% type% TYPE)))) (T X))))
(PUTPROPS DATATYPE.TEST DMACRO (= . \DTEST))
(PUTPROPS \WORDREF.PTR DMACRO ((ADDRESS I) (\GETBASEPTR ADDRESS (PROG1 (LLSH I 1) (* (UNFOLD I 
WORDSPERCELL))))))
(PUTPROPS \WORDREF.PTR MACRO (= . \GETBASEPTR))
(PUTPROPS \WORDSET.PTR DMACRO (X (* (UNFOLD DATUM WORDSPERCELL)) (\BubbleWORDSET X (QUOTE \PUTBASEPTR)
 (QUOTE (LLSH DATUM 1)))))
(PUTPROPS \WORDSET.PTR MACRO (X (\BubbleWORDSET X (QUOTE \PUTBASEPTR))))
(PUTPROPS \WORDREF.FIXP DMACRO ((ADDRESS I) (\GETBASEFIXP ADDRESS (PROG1 (LLSH I 1) (* (UNFOLD I 
WORDSPERCELL))))))
(PUTPROPS \WORDREF.FIXP MACRO (= . \GETBASEFIXP))
(PUTPROPS \WORDSET.FIXP DMACRO (X (* (UNFOLD DATUM WORDSPERCELL)) (\BubbleWORDSET X (QUOTE 
\PUTBASEFIXP) (QUOTE (LLSH DATUM 1)))))
(PUTPROPS \WORDSET.FIXP MACRO (X (\BubbleWORDSET X (QUOTE \PUTBASEFIXP))))
(PUTPROPS \WORDREF.FLOATP DMACRO ((ADDRESS I) (\GETBASEFLOATP ADDRESS (PROG1 (LLSH I 1) (* (UNFOLD I 
WORDSPERCELL))))))
(PUTPROPS \WORDREF.FLOATP MACRO (= . \GETBASEFLOATP))
(PUTPROPS \WORDSET.FLOATP DMACRO (X (* (UNFOLD DATUM WORDSPERCELL)) (\BubbleWORDSET X (QUOTE 
\PUTBASEFLOATP) (QUOTE (LLSH DATUM 1)))))
(PUTPROPS \WORDSET.FLOATP MACRO (X (\BubbleWORDSET X (QUOTE \PUTBASEFLOATP))))
(PUTPROPS \WORDREF.16 DMACRO (= . \GETBASE))
(PUTPROPS \WORDREF.16 MACRO (= . \GETBASEDOUBLEBYTE))
(PUTPROPS \WORDSET.16 DMACRO (X (\BubbleWORDSET X (QUOTE \PUTBASE))))
(PUTPROPS \WORDSET.16 MACRO (X (\BubbleWORDSET X (QUOTE \PUTBASEDOUBLEBYTE))))
(PUTPROPS \WORDREF.8 DMACRO ((ADDRESS I) (\GETBASEBYTE ADDRESS I)))
(PUTPROPS \WORDREF.8 MACRO (= . \GETBASEBYTE))
(PUTPROPS \WORDSET.8 DMACRO (X (\BubbleWORDSET X (QUOTE \PUTBASEBYTE))))
(PUTPROPS \WORDSET.8 MACRO (X (\BubbleWORDSET X (QUOTE \PUTBASEBYTE))))
(PUTPROPS \WORDREF.4 DMACRO ((BASE OFFST) (\GETBASENIBBLE BASE OFFST)))
(PUTPROPS \WORDREF.4 MACRO (= . \GETBASENIBBLE))
(PUTPROPS \WORDSET.4 DMACRO (X (\BubbleWORDSET X (QUOTE \PUTBASENIBBLE))))
(PUTPROPS \WORDSET.4 MACRO (X (\BubbleWORDSET X (QUOTE \PUTBASENIBBLE))))
(PUTPROPS \WORDREF.1 DMACRO ((ADDRESS I) (\GETBASEBIT ADDRESS I)))
(PUTPROPS \WORDREF.1 MACRO (= . \GETBASEBIT))
(PUTPROPS \WORDSET.1 DMACRO (X (\BubbleWORDSET X (QUOTE \PUTBASEBIT))))
(PUTPROPS \WORDSET.1 MACRO (X (\BubbleWORDSET X (QUOTE \PUTBASEBIT))))
(FILESLOAD MACROAUX)
(DEFINEQ (\NONDADDARITH.TRAMPOLINE (LAMBDA NARGS (* JonL "11-SEP-83 15:09") (PROG ((FNAME (STKNAME (
STKNTH -1)))) (OR (FMEMB FNAME (QUOTE (LOADBYTE DEPOSITBYTE))) (AND FNAME (LITATOM FNAME) (ILESSP 8 (
NCHARS FNAME)) (FMEMB (SUBATOM FNAME 2 4) (QUOTE (GET PUT))) (EQ (SUBATOM FNAME 5 8) (QUOTE BASE))) (
SHOULDNT (QUOTE \NONDADDARITH.TRAMPOLINE))) (PUTD FNAME NIL) (FILESLOAD (SYSLOAD COMPILED FROM 
LISPUSERS) NONDADDARITH) (if (NOT (DEFINEDP FNAME)) then (MOVD (FUNCTION \NONDADDARITH.TRAMPOLINE) 
FNAME) (ERROR FNAME "Apparently not defined in NONDADDARITH file?") else (APPLY FNAME (for I to NARGS 
collect (ARG NARGS I))))))))
(DECLARE: EVAL@LOADWHEN (NEQ (SYSTEMTYPE) (QUOTE D)) (DECLARE: EVAL@COMPILEWHEN (NEQ COMPILEMODE (
QUOTE D)) DONTCOPY (OR (CONSTANTEXPRESSIONP (QUOTE PTRBLOCK.GCT)) (PROGN (SETQ PTRBLOCK.GCT 1) (
CONSTANTS PTRBLOCK.GCT))) (FILESLOAD NONDADDARITH)) (MAPC (QUOTE (LOADBYTE DEPOSITEBYTE \GETBASEBIT 
\GETBASENIBBLE \GETBASEBYTE \GETBASEDOUBLEBYTE \GETBASEFIXP \GETBASEFLOATP \GETBASEPTR \PUTBASEBIT 
\PUTBASENIBBLE \PUTBASEBYTE \PUTBASEDOUBLEBYTE \PUTBASEFIXP \PUTBASEFLOATP \PUTBASEPTR)) (FUNCTION (
LAMBDA (X) (MOVD? (FUNCTION \NONDADDARITH.TRAMPOLINE) X)))))
(PUTPROPS AREF MACRO (X (SELECTC (LENGTH X) (2 (CONS (QUOTE \AREF.1) X)) (3 (CONS (QUOTE \AREF.2) X)) 
(QUOTE IGNOREMACRO))))
(PUTPROPS ASET MACRO (X (SELECTC (LENGTH X) (3 (CONS (QUOTE \ASET.1) X)) (4 (CONS (QUOTE \ASET.2) X)) 
(QUOTE IGNOREMACRO))))
(PUTPROPS ARRAYRANK MACRO ((CMLARRAY) (fetch CMLRANK of CMLARRAY)))
(PUTPROPS ARRAYDIMENSIONS MACRO (X (if (AND X (NULL (CDR X))) then (LIST (QUOTE fetch) (QUOTE CMLDIML)
 (CAR X)) else (QUOTE IGNOREMACRO))))
(PUTPROPS ARRAYDIMENSION MACRO ((CMLARRAY AXIS#) (CAR (NTH (fetch CMLDIML of CMLARRAY) (ADD1 AXIS#))))
)
(PUTPROPS MAKEARRAY ARGNAMES (INDICESLST (KEYWORDNAMES: ELEMENTTYPE INITIALELEMENT INITIALCONTENTS 
DISPLACEDTO DISPLACEDINDEXOFFSET)))
(PUTPROPS AREF ARGNAMES (CMLARRY ...indices...))
(PUTPROPS ASET ARGNAMES (NEWVALUE CMLARRY ...indices...))
(PUTPROPS ARRAYINBOUNDSP ARGNAMES (CMLARRY ...indices...))
((LAMBDA (C) (MAPC (QUOTE (P X 1 4 8 16 N L)) (FUNCTION (LAMBDA (A) (MAPC (QUOTE (AREF ASET)) (
FUNCTION (LAMBDA (B) (SETQ C (MKATOM (CONCAT "\" A B))) (PUTPROP (MKATOM (CONCAT A B)) (QUOTE MACRO) (
LIST (QUOTE X) (LIST (MKATOM (CONCAT "\Fast" B "expander")) (QUOTE X) (LIST (QUOTE QUOTE) C)))) (
PUTPROP C (QUOTE MACRO) (LIST (QUOTE X) (LIST (MKATOM (CONCAT "\NoSissy" B "expander")) (QUOTE X) (
LIST (QUOTE QUOTE) C))))))))))))
(RPAQ? AREFSissyFLG NIL)
(PUTPROPS AREFSissyFLG GLOBALVAR T)
(PUTDEF (QUOTE CMLARRAYS) (QUOTE FILEPKGCOMS) (QUOTE ((COM MACRO (X (E (MAPC (QUOTE X) (FUNCTION (
LAMBDA (VAR) (PRIN1 "(RPAQ ") (PRIN2 VAR) (PRIN1 "(\READCMLARRAY))") (TERPRI) (\PRINTCMLARRAY VAR)))))
)))))
(PUTPROPS CMLARRAY COPYRIGHT ("Xerox Corporation" 1982 1983))
NIL
