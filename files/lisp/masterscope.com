(FILECREATED "31-Dec-84 03:23:28" ("compiled on " <NEWLISP>MASTERSCOPE..168) (2 . 2) brecompiled changes: UNSAVEFNS in 
"INTERLISP-10  14-Sep-84 ..." dated "14-Sep-84 00:05:07")
(FILECREATED " 7-Dec-84 13:11:43" {ERIS}<LISPNEW>SOURCES>MASTERSCOPE.;1 118112 changes to: (FNS UNSAVEFNS) previous date: 
"15-Aug-84 00:55:26" {ERIS}<LISPCORE>SOURCES>MASTERSCOPE.;5)
ADDHASH BINARY
               -.           Z`  Z` ,   ,<   Zp  3B   +   
Z` Zp  ,   2B   +   ,<p  Z` ,   D  +   ,<`  Z` ,   ,<   ,<` &  Z   +    F (ITEM . 1)
(VAL . 1)
(ARRAY . 1)
NCONC
PUTHASH
(URET1 CONSNL FMEMB KNIL GETHSH ENTER3)            p   `   P    8      
SUBHASH BINARY
          
    -.           
Z`  Z` ,   ,<   Zp  3B   +   	,<` D  2B   +   	,<`  ,<   ,<` &  Z   +      (ITEM . 1)
(VAL . 1)
(ARRAY . 1)
DREMOVE
PUTHASH
(URET1 KNIL GETHSH ENTER3) (       p            
MAKEHASH BINARY
               -.           ,<`  Z  D  ,~       (N . 1)
MSREHASH
HASHARRAY
(ENTER1)      
MSREHASH BINARY
     
        	-.           ^"  ,>  ,>   ,<`  "  	,   $Bx  ,^   /   &"  ."  ,   ,~      @   (HA . 1)
HARRAYSIZE
(MKN BHC IUNBOX ENTER1)      h    P      
MSVBTABLES BINARY
       C      >-.          Z`  -,   +   [`  Z  XB` Z`  XB`  Z`  2B +   Z` 2B   +   	Z +  2B +   Z +  Z   +  2B +   !Z` 2B +   Z +  2B +   Z +  2B +   Z +  2B   +   Z +  2B +   Z  +  2B  +   Z  +  2B !+   Z  +  2B !+   Z "+  2B "+    Z "+  Z   +  2B #+   %Z` 2B   +   $Z #+  Z   +  2B #+   0Z` 2B $+   )Z $+  2B $+   +Z $+  2B   +   -Z %+  2B %+   /Z %+  Z   +  2B &+   4Z` 2B   +   3Z &+  Z   +  2B &+   GZ` 2B '+   8Z '+  2B (+   :Z (+  2B )+   <Z )+  2B   +   >Z *+  2B *+   @Z ++  2B ++   BZ ,+  2B ,+   DZ -+  2B -+   FZ .+  Z   +  2B )+   KZ` 2B   +   JZ .+  Z   +  2B /+   PZ` 2B   +   OZ /+  Z   +  2B /+   ZZ` 2B '+   SZ &+  2B 0+   UZ 0+  2B $+   WZ 1+  2B   +   YZ 1+  Z   +  2B 2+   _Z` 2B   +   ^Z 2+  Z   +  2B 2+   iZ` 2B '+   bZ 2+  2B 0+   dZ 3+  2B $+   fZ 2+  2B   +   hZ 3+  Z   +  2B 4+   tZ` 2B '+   mZ 2+  2B 0+   oZ 4+  2B $+   qZ 4+  2B   +   sZ 5+  Z   +  2B 5+   |Z` 2B 0+   wZ 6+  2B $+   yZ 5+  2B   +   {Z 6+  Z   +  2B 7+  Z` 2B '+   Z 7+  2B 0+  Z 8+  2B 8+  Z 9+  2B +  Z 9+  2B $+  Z :+  2B   +  
Z :+  2B  +  Z ;+  2B ;+  Z <+  2B ++  Z <+  2B !+  Z =+  2B !+  Z =+  2B -+  Z"   +  Z   +  -,   3B   7    ,   ,~   n{9]?\w}{g;ws]{]w;~w~u             (VERB . 1)
(MOD . 1)
BIND
((BIND REF SET SMASH TEST) . 0)
NOTUSE
CALL
DIRECTLY
((CALL EFFECT PREDICATE NLAMBDA) . 0)
EFFECT
INDIRECTLY
APPLY
((APPLY CALL EFFECT ERROR PREDICATE NLAMBDA) . 0)
NOTERROR
((APPLY CALL EFFECT PREDICATE NLAMBDA) . 0)
PREDICATE
TESTING
VALUE
((CALL NLAMBDA) . 0)
NLAMBDA
CREATE
DECLARE
LOCALLY
LOCALVARS
((LOCALVARS SPECVARS) . 0)
SPECVARS
FETCH
IS
FIELDS
(((FETCH) (REPLACE)) . 0)
FNS
((CALL NOBIND REF (CALL) (APPLY)) . 0)
KNOWN
((CALL NOBIND REF) . 0)
((CALL NOBIND REF (CALL) (BIND) (REFFREE) (REF) (SETFREE) (SET) (SMASHFREE) (SMASH) (RECORDS) (FETCH) (REPLACE) (PROP) (APPLY) (TEST
) (TESTFREE)) . 0)
PROPS
(((PROP)) . 0)
RECORDS
(((RECORD) (CREATE)) . 0)
VARS
(((BIND) (REFFREE) (REF) (SETFREE) (SET) (SMASHFREE) (SMASH) (TEST) (TESTFREE)) . 0)
TYPE
(((0)) . 0)
((CALL NOBIND REF) . 0)
PROG
REFERENCE
FREELY
((REFFREE TESTFREE SMASHFREE) . 0)
((REF TEST SMASH) . 0)
((REF REFFREE TEST TESTFREE SMASH SMASHFREE) . 0)
REPLACE
SET
SETFREE
((SET SETFREE) . 0)
SMASH
SMASHFREE
((SMASH SMASHFREE) . 0)
TEST
TESTFREE
((TEST TESTFREE) . 0)
USE
((FETCH REPLACE) . 0)
((REFFREE SETFREE SMASHFREE TESTFREE) . 0)
I.S.OPRS
CLISP
LOCALFREEVARS
((REF SET SMASH TEST) . 0)
((REF REFFREE SET SETFREE SMASH SMASHFREE TEST TESTFREE) . 0)
((TEST TESTFREE) . 0)
PROPNAMES
PROP
((CREATE RECORD) . 0)
((TEST TESTFREE) . 0)
((REF REFFREE SMASH SMASHFREE) . 0)
(CONSNL ASZ KNIL SKLST ENTER2)      `     | ( t   i x _ P Z  P 	` K 	 G P 4 ( 0 @ % 8 ! P              
MSCHECKBLOCKS BINARY
      ;   4   -.          4-.    X4   BZ   ,<   @ B  ( +   qZwZ8  2B   +   	Z   XB8  +   -,   +   ,<   ,< E$ E2B   +   ZwZ8  ,   ZwXB8  ,<   Zp  -,   +   +   3Zp  ,<   ,<p  " FZ  XBp  ,<   ,< F$ G,<   ,<` $ GXB` ,<p  " HXB` ,<   Zp  -,   +   +   Zp  B H[p  XBp  +   /   ,<` ,<` $ GXB` ,<p  ,< I$ GXB` 3B   +   &Z I,<   ,<` $ I,<p  ,< J$ GXB` 3B   +   +Z J,<   ,<` $ I,<p  ,< J$ GXB` 3B   +   1Z K,<   Z JZ` ,   D I/   [p  XBp  +   /     K,< L,< L$ L,<` ,<   ,<   ,<   ,<   Zw~-,   +   :+   UZ  XBp  ,<   Z   D M2B   +   S,<` ,<   ,<   Zw-,   +   A+   IZ  XBp  ,<w~[wD M3B   +   GZp  2B   +   FZ   XBw+   I[wXBw+   ?Zw/  3B   +   K+   SZp  XBwZw3B   +   Q,<   Zw,   XBw~,\  QB  +   SZw,   XBwXBw~[w~XBw~+   8Zw~/  XB` 3B   +   hZ` 3B   +   c,< M[` [  [  [  3B   +   a,<` [` [  [  [  D N,<   ,< N$ O+   bZ` D O+   eZ OZwZ8  ,   Z` ,   ,<   ,<` ,<` ,  q,<` Zp  -,   +   j+   oZp  ,<   ,<p  ,<` ,<` ,  q/   [p  XBp  +   h/   Z   ,~   +    Z   ,<   Z   ,<  Z   ,<  Z   ,<  Z   ,<  Z  ;,<  @ P@  +  tZ   ,<   Z   ,<  Zw~Z?,<   @ S `X+  sZ` -,   +   Z   XB` 3B   +  Z   XB  zZ  y3B   +  Z   ,<  D Z+  Z XB Zw[?,<   Zp  -,   +  
+  =Zp  ,<   Zp  -,   +  4[p  Z  2B Z+  [p  [  Z  B [+  [p  XB` Zp  ,<   [w-,   +  [w+  ZwZ 7@  7   Z  XB` -,   +  ,<` D O+  Z`     ,\   ,   Zp  2B J+  "Z` 2B   +  ;Z  XB +  ;2B I+  &Z` 2B   +  ;Z XB +  ;3B [+  ;3B J+  ;3B \+  ;3B \+  ;3B ]+  ;3B ]+  ;3B ^+  ;3B ^+  ;3B _+  ;2B _+  0+  ;Zp  ,<   ,< `,<   ,<   , +  ;,<   Z   D M3B   +  9,<p  ,< `,<   ,<   , +  ;Zp  Z 4,   XB :/   [p  XBp  +  /   Z` 3B   +  BZw,<?,<   , g+  GZ   3B   +  F,<   ,< a,<   ,<   , Z   XB  sZ ;,<   Zp  -,   +  J+  kZp  ,<   Zp  Zw~Z?,   2B   +  SZp  Z F,   2B   +  S,<p  ,< a,<   ,<   , Z` 3B   +  W,<p  Zw~,<?,<8  , u,<p  Z bZ   7   [  Z  Z  1H  +  \2D   +  Y[  Z  D bXB` ,<   ,<wZ cZ X7   [  Z  Z  1H  +  d2D   +  a[  Z  D b,<   ,<wZ cZ `7   [  Z  Z  1H  +  l2D   +  h[  Z  D b,<   ,<w~Z dZ g7   [  Z  Z  1H  +  s2D   +  p[  Z  D b,<   ,<w~Z dZ o7   [  Z  Z  1H  +  {2D   +  w[  Z  D bD ZD ZD ZD Z,<   Zp  -,   +  +  GZp  ,<   Zp  Z` ,   2B   +  6Zp  Z $,   2B   +  6,<p  , /2B   +  6,<p  Z eZ v7   [  Z  Z  1H  +  2D   +  [  [  D e2B   +  ),<p  Z fZ 
7   [  Z  Z  1H  +  2D   +  [  [  D e2B   +  ),<p  Z fZ 7   [  Z  Z  1H  +  2D   +  [  [  D e2B   +  ),<p  Z gZ 7   [  Z  Z  1H  +  &2D   +  #[  [  D e3B   +  +Zp  Z` ,   XB` +  6,<p  ,<w~, 
Q3B   +  1Z %3B   +  6,<w,<w, 
4+  6Zp  Z` ,   3B   +  6,<w,< g,<w,<   , ,<p  ,<w~Z [Z "7   [  Z  Z  1H  +  <2D   +  9[  Z  D b    ,\   ,   3B   +  E,<p  ,<w~, 
Q2B   +  E,<p  ,< h,<w~,<   , /   [p  XBp  +  /   ,<p  Z gZ 87   [  Z  Z  1H  +  M2D   +  J[  Z  D b,<   ,<wZ fZ I7   [  Z  Z  1H  +  U2D   +  Q[  Z  D b,<   ,<wZ fZ P7   [  Z  Z  1H  +  \2D   +  Y[  Z  D b,<   ,<w~Z eZ X7   [  Z  Z  1H  +  d2D   +  `[  Z  D bD ZD ZD Z,<   ,<` $ ZXB` /   [p  XBp  +  H/   ,<` ,<` , *,<` ,<   ,<   Zw-,   +  p+  wZ  XBp  Zp  Z   ,   2B   +  uZp  Z ,   2B   +  u,<p  Z .-,   Z       ,\   ,   2B   +  uZp  Z   ,   2B   +  uZp  Z  q,   2B   +  u,<p  ,< h$ i2B   +  u,<p  " i3B   +  +  u,<p  Z gZ _7   [  Z  Z  1H  +  
2D   +  [  [  D b,<   ,<wZ fZ 7   [  Z  Z  1H  +  2D   +  [  [  D b,<   ,<wZ fZ 7   [  Z  Z  1H  +  2D   +  [  [  D b,<   ,<w~Z eZ 7   [  Z  Z  1H  +  !2D   +  [  [  D bD ZD ZD Z,<   ,<   ,<   ,<   ,<   Zw~-,   +  (+  6Z  XBp  Zp  Z G,   2B   +  ,+  4Zp  XBwZw3B   +  2,<   Zw,   XBw~,\  QB  +  4Zw,   XBwXBw~[w~XBw~+  &Zw~/  XB` 2B   +  9+  u,<p  Z bZ 7   [  Z  Z  1H  +  >2D   +  ;[  [  D e2B   +  a,<p  Z dZ :7   [  Z  Z  1H  +  F2D   +  C[  [  D e2B   +  a,<p  Z dZ B7   [  Z  Z  1H  +  N2D   +  K[  [  D e2B   +  a,<p  Z cZ J7   [  Z  Z  1H  +  V2D   +  S[  [  D e2B   +  a,<p  Z cZ R7   [  Z  Z  1H  +  ^2D   +  [[  [  D e3B   +  d,<p  ,< j,<` ,< L, +  u,<p  Zp  -,   +  nZp  Z 7@  7   Z  2B j+  m,<p  ,<   Z   F kB k3B   +  nZ   +  nZ   /   2B   +  s,<p  ,< l,<` ,<   , +  u,<p  ,< l,<` ,<   , [wXBw+  nZw/  Zw,<?,<   ,<   Zw-,   +  |+  IZ  XBp  -,   +  ~+  GZp  3B J+  3B I+  3B [+  2B J+  G[p  ,<   ,<   ,<   Zw-,   +  +  FZ  XBp  Zp  Z` ,   2B   +  EZp  Z` ,   2B   +  E,<p  Z cZ Z7   [  Z  Z  1H  +  2D   +  [  [  D b,<   ,<wZ cZ 7   [  Z  Z  1H  +  2D   +  [  [  D b,<   ,<wZ dZ 7   [  Z  Z  1H  +  !2D   +  [  [  D b,<   ,<w~Z dZ 7   [  Z  Z  1H  +  )2D   +  %[  [  D b,<   ,<w~Z bZ $7   [  Z  Z  1H  +  02D   +  -[  [  D bD ZD ZD ZD Z,<   ,<   ,<   Zw-,   +  7+  ?Z  XBp  Zp  Z *,   3B   +  >Zp  2B   +  =Z   XBw+  ?[wXBw+  5Zw/  3B   +  B+  E,<p  ,< mZw},<   ,<   , [wXBw+  Zw/  [wXBw+  zZw/  Z   3B   +  O  m1B   +  M  n  n,< n" oZwZ?2B   +  fZw[?,<   ,<   ,<   ,<   ,<   Zw~-,   +  V+  bZ  XBp  XBwZw3B   +  ],<   Zw,   XBw~,\  QB  +  _Zw,   XBwXBw~Zp  -,   +  a+  b[w~XBw~+  TZw~/  ,<   ,< o$ GZ   ,   B pZ J3B   +  r,< p" oZ fB qXB i,<   Zp  -,   +  m+  pZp  ,<   , I[p  XBp  +  k/   ,< q" o,~   ,< r" o,~   Z   ,~   +    ,<   ,<   ,<   ,<w},< r$ iXBw3B   +  Zw3B   +  |Zw-,   +  Zw}Z   ,   2B   +  ,<w,< s$ s2B   +  ,<w},< t,<   ,<   , Zw}Z },   2B   +  fZw}Z N,   2B   +  fZ   XBp  ,<w}Z IZ ,7   [  Z  Z  1H  +  2D   +  [  [  D bXBw,<   ,<w}Z tZ 7   [  Z  Z  1H  +  2D   +  [  [  D b,<   ,<w|Z uZ 7   [  Z  Z  1H  +  2D   +  [  [  D b,<   ,<w|Z uZ 7   [  Z  Z  1H  +  &2D   +  #[  [  D b,<   ,<w{Z vZ "7   [  Z  Z  1H  +  .2D   +  *[  [  D bD ZD ZD ZD Z,<   Zp  -,   +  4+  _Zp  ,<   Zp  Zw|3B  +  :Zp  Z 9,   3B   +  :Z   XBwZp  Z 7,   2B   +  S,<w},<   ,<   Zw-,   +  @+  NZ  XBp  Zw{3B  +  L,<w{[wD M3B   +  LZp  3B   +  I,<w~[wD M3B   +  LZp  2B   +  KZ   XBw+  N[wXBw+  >Zw/  2B   +  ],<w|,< v,<w,<   , +  ]Zp  Zw~,   3B   +  ]Zw|Z  r,   2B   +  ]Zw|Z B,   2B   +  ],<w|,< w,<w,<   , /   [p  XBp  +  2/   Zp  2B   +  fZw}Z X,   2B   +  f,<w},< w,<   ,<   , Z   +    Z 2B   +  p,<p  Z ;D M3B   +  pZp  [wZ  3B  +  p,<p  ,< x,<   ,<   , Zp  Z g2B  +  v[ p2B   +  vZ a2B   +  vZ   XB r+  {Z u2B   +  {Z s3B   +  {Zp  ,   XB v,<p  Z zD M3B   +   ,<p  ,< x,<   ,<   , Z x,<   Z {2B   +  Zw,   XB D O,<   Zp  -,   +  +  Zp  ,<   ,<p  Z iD M2B   +  ,<p  ,< y,<   ,<   , /   [p  XBp  +  /   Z ,<   ,<   ,<   Zw-,   +  +  UZ  XBp  Zp  Z y,   2B   +  T,<p  Z tZ )7   [  Z  Z  1H  +  2D   +  [  [  D b,<   ,<wZ uZ 7   [  Z  Z  1H  +  $2D   +   [  [  D b,<   ,<wZ uZ 7   [  Z  Z  1H  +  +2D   +  ([  [  D b,<   ,<w~Z vZ '7   [  Z  Z  1H  +  32D   +  /[  [  D b,<   ,<w~Z IZ .7   [  Z  Z  1H  +  :2D   +  7[  [  D bD ZD ZD ZD Z,<   ,<   ,<   Zw-,   +  A+  IZ  XBp  Zp  Z ,   3B   +  HZp  2B   +  GZ   XBw+  I[wXBw+  ?Zw/  2B   +  L+  T,<p  ,< z$ i2B   +  Q,<p  ,< z,<   ,<   , Z C,<   Zw,   D GXB Q[wXBw+  Zw/  Z  3B   +  %,< {,<   ,<   ,<   Zw~-,   +  \Zw+  !Zw~,<   ,<p  Z tZ 67   [  Z  Z  1H  +  c2D   +  _[  [  D b,<   ,<wZ uZ ^7   [  Z  Z  1H  +  j2D   +  g[  [  D b,<   ,<wZ uZ f7   [  Z  Z  1H  +  r2D   +  n[  [  D b,<   ,<w~Z vZ m7   [  Z  Z  1H  +  y2D   +  v[  [  D b,<   ,<w~Z IZ u7   [  Z  Z  1H  +  2D   +  }[  [  D bD ZD ZD ZD Z,<   ,<   ,<   ,<   ,<   Zw~-,   +  	+  Z  XBp  Zp  Z S,   2B   +  +  Zp  XBwZw3B   +  ,<   Zw,   XBw~,\  QB  +  Zw,   XBwXBw~[w~XBw~+  Zw~/  XBp  -,   +   Zw3B   +  Zp  QD  +  Zp  XBw       [  2D   +  XBw[w~XBw~+  Z/  XB   3B   +  $Z   +    Z   +  &Z   +    Z V,<   ,< {,<   ,<   , +    ,<wZp  -,   +  -Z   +    Zp  ,<   @ >    +  HZ   3B   +  2B |Z /+  4,< |Z }D },<   @ @   +  GZ   XB 1Z   ,<  Z gZ |7   [  Z  Z  1H  +  =2D   +  9[  [  D b,<   Z 7,<   Z fZ 87   [  Z  Z  1H  +  E2D   +  A[  [  D b,<   Z ?,<   Z fZ @7   [  Z  Z  1H  +  M2D   +  I[  [  D b,<   Z G,<   Z eZ H7   [  Z  Z  1H  +  U2D   +  Q[  [  D bD ZD ZD Z,<   Z OZ {,   ,<   Z X,<   Z cZ P7   [  Z  Z  1H  +  `2D   +  ][  [  D b,<   Z Z,<   Z cZ \7   [  Z  Z  1H  +  h2D   +  e[  [  D b,<   Z b,<   Z dZ d7   [  Z  Z  1H  +  p2D   +  m[  [  D b,<   Z j,<   Z dZ l7   [  Z  Z  1H  +  x2D   +  u[  [  D b,<   Z r,<   Z bZ t7   [  Z  Z  1H  +   2D   +  }[  [  D bD ZD ZD ZD Z,<   @ ~ `
+  EZ   B |,<`  Zp  -,   +  	+  Zp  ,<   ,<p  ,<  Z F /   [p  XBp  +  /   ,<` Zp  -,   +  +  Zp  ,<   ,<p  ,< Z F /   [p  XBp  +  /   ,<`  Zp  -,   +  +  )Zp  ,<   @ ?   +  (Z   Z 
,   3B   +  &Z Zw}Z8 ,   3B   +  %Z z,<   Z ,<  ,<  /   , 
CZ   XB   Z ",<   , 	Q,~   [p  XBp  +  /   Z   2B   +  DZwZ?2B   +  /Z !2B   +  DZ w3B   +  D,<` ,<   ,<   Zw-,   +  4+  CZ  XBp  Zp  Z ,   2B   +  8+  AZp  Z ,   0B  +  ;+  A0B+  <+  AZ !,<   ,<w, 
Q3B   +  A,<p  Z <,<   , 
4[wXBw+  2Zw/  Z   ,~   ,<   Z 8XB 6,\   ,~   ,~   [p  XBp  +  *Zp  ,<   [w[  @ ,   /"  ,   ,<   ,<   ,<   ,<   ,<   ,<   Zw|0B   +  T[w|XBw|,< " o+  Y2B   +  X[w|XBw|,< " o+  Y,< " oZw}3B   +  u,<   ,<   ,<   Zw2B   +  ^+  e-,   +  aXBp  Z   XBw+  cZwXBp  [wXBw,<p  " p,< " +  \Zw/  ,< " o,<w|,<   ,<   Zw2B   +  k+  r-,   +  nXBp  Z   XBw+  pZwXBp  [wXBw,< " ,<p  " o+  iZw/  ,< " o  n[w|Z  B q,<   ,<   ,<   ZwXBp  Zp  -,   +  {+  	Zp  XBw}[  [  2B   +  	[p  ,<   ,<   ,<   Zw-,   +  	+  	Z  XBp  [p  [w{,   3B   +  	
,<p  Zw{Zw,   ,\  XB  Zw{Z   XD  +  	[wXBw+  	 Zw/  Zw}3B   +  	Zw}Zw|,   XBw|[p  XBp  +  yZw/  Zw~3B   +  	P,< L,< L$ LZw~Z  ,<   ,< , 
y  mXBw,< " o,<w|,<   ,<   Zw2B   +  	+  	%-,   +  	!XBp  Z   XBw+  	#ZwXBp  [wXBw,<p  " o,< " +  	Zw/    mXBw w,> 3,>    w/"      ,^   /   3"  +  	1 w,> 3,>    w}    ,^   /   3b  +  	3 w."  ,   XBw w,> 3,>    w.Bx  ,^   /   &"  /"  ,   XBp  ,< " oZw~[  ,<   ,< , 
y,< " o[w~,<   Zp  -,   +  	@+  	OZp  ,<   Zp  ,<   ,< , 
y,<w~,<   $ L,< " o,<w,<   $ L,< " o,<w~,<   $ L,< " o[p  ,<   ,< , 
y,< 	" o/   [p  XBp  +  	>/   Z   /  ,~   Z %3B   +  	`Zp  Z ,   3B   +  	`Z @,<   Z &Zw2B  +  	YZ 	+  	[,< 
,<w,< 
,   Z ,   ,<   Z 	V,<   ,<   , Z   XB 	QXB %,<p  Z tZ |7   [  Z  Z  1H  +  	f2D   +  	b[  [  D b,<   ,<wZ uZ 	a7   [  Z  Z  1H  +  	m2D   +  	j[  [  D b,<   ,<wZ uZ 	i7   [  Z  Z  1H  +  	u2D   +  	q[  [  D b,<   ,<w~Z vZ 	p7   [  Z  Z  1H  +  	|2D   +  	y[  [  D b,<   ,<w~Z IZ 	x7   [  Z  Z  1H  +  
2D   +  
 [  [  D bD ZD ZD ZD Z,<   ,< ZwZ &,   3B   +  
Z ",<   ,<w$ ZXBw,<wZp  -,   +  
+  
3Zp  ,<   Zp  Z E,   1B   +  
11B+  
10B  +  
+  
10B  +  
Z"  XBw+  
10B   +  
$Zp  Z 5,   3B   +  
Z 	U,<   ,<wZ 	],<  /   , 
C,<p  ,< Z 
F Zw0B  +  
1Z   XBw+  
13B   +  
&0B  +  
)Zw0B  +  
1Z   XBw+  
12B   +  
0,<p  ,< LZ 
 F ,<p  ,<w, 	Q,<   Z 
+F +  
1,< " /   [p  XBp  +  
/   Zp  +    ,<p  , /2B   +    ,<p  ,<wZ [Z 	7   [  Z  Z  1H  +  
<2D   +  
9[  Z  D b    ,\   ,   2B   +    ,<p  ,< ,<w~,<   , +    Z *2B   +  
G,<w,<w, 
Q3B   +  
HZ   +    Z   Z   XB 
CZwZ r,   XB 
J,<w,< Z 
,<  ,< ,   ,<   ,<w,<   , +    ,<w,<wZ IZ 
87   [  Z  Z  1H  +  
W2D   +  
T[  Z  D b    ,\   ,   3B   +  
\Z   +    ,<w,<wZ JZ 
S7   [  Z  Z  1H  +  
b2D   +  
_[  Z  D b    ,\   ,   3B   +  
gZ   +    Z -3B   +  
mZwZ 
g,   2B   +  
l7   Z   +    Z /3B   7   7   +    ZwZ 
m,   2B   +    ZwZ Y,   2B   +    ZwZ ~,   2B   +    ,<w,< h$ E+    Zw2B   +  
{Zp  +    -,   +  [w,<   Zw,<   ,<w, 
yXBw,\   XBw+  
y p  /"   ,   XBp  ,   1b   +  ,< " ,<w" p+  
Zp  0B   +  
,< " oZp  +    Zp  3B   +  Zw,   XBw,<wZ jD 2B   +  ,<wZ   ,   ,   Z ,   XB Z  [  ,<   ,<w~Zw~3B   +  (Zp  Zw7   [  Z  Z  1H  +  2D   +  2B   +  ",<wZw,   Zw,       ,\   XD  Z  Z  XBp  [w~,<   ,<w$ 2B   +  .,<p  Zw~,   D G+  .Zp  [w,   2B   +  .,<wZw[w,   ,\  QB  Z   +    Zp  Z 
u,   2B   +    ,<p  ,< h$ i+       (JhIHLK3$/BABI#\  `&0`ddI#@!$B$ ))H
|0UJ@RP(
(%
$JH
H
$B0@!UPH
$
<BJ% )(T8"MF@`B@R ) )H|I7b `@@ddt`)"H@R@R ))x`BI$H&!$"B()	$HDa)$@R R )x	RCD
$I'@0  B$"BMu
"H@$ )pDH@RzQE1D!IbD@ ''d<`hg@G04 r sx@B(@R R )}!-%$Ub@R"PD!B  DAg P 0@ `                             (FILES . 1)
(VARIABLE-VALUE-CELL SYSLOCALVARS . 321)
(VARIABLE-VALUE-CELL FILELST . 15)
(VARIABLE-VALUE-CELL DONTCOMPILEFNS . 237)
(VARIABLE-VALUE-CELL GLOBALVARS . 2911)
(VARIABLE-VALUE-CELL RETFNS . 1452)
(VARIABLE-VALUE-CELL BLKLIBRARY . 1567)
(VARIABLE-VALUE-CELL NOLINKFNS . 233)
(VARIABLE-VALUE-CELL LINKFNS . 235)
(VARIABLE-VALUE-CELL SPECVARS . 2784)
(VARIABLE-VALUE-CELL LOCALVARS . 2771)
(VARIABLE-VALUE-CELL SYSSPECVARS . 745)
(VARIABLE-VALUE-CELL MSDATABASELST . 2748)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 981)
(VARIABLE-VALUE-CELL ENTRIES . 2471)
(VARIABLE-VALUE-CELL BLKFNS . 2612)
(VARIABLE-VALUE-CELL BLKAPPLYFNS . 2578)
(VARIABLE-VALUE-CELL BLKAPPLYCALLERS . 2582)
(VARIABLE-VALUE-CELL MSCRATCHASH . 2188)
(VARIABLE-VALUE-CELL LOCALFREEVARS . 2789)
(VARIABLE-VALUE-CELL LF1 . 2495)
(VARIABLE-VALUE-CELL V . 2616)
(VARIABLE-VALUE-CELL U . 2714)
(VARIABLE-VALUE-CELL LF . 2496)
(VARIABLE-VALUE-CELL SEEN . 2653)
(VARIABLE-VALUE-CELL SFLG . 2707)
(VARIABLE-VALUE-CELL SHOULDBESPECVARS . 2711)
(VARIABLE-VALUE-CELL ERRORS . 2855)
(VARIABLE-VALUE-CELL LOCALVARS . 0)
(T VARIABLE-VALUE-CELL SPECVARS . 0)
NIL
NIL
NIL
NIL
FILEGROUP
GETP
MSNOTICEFILE
BLOCKS
FILECOMSLST
NCONC
FILEFNSLST
UPDATEFN
LOCALVARS
APPLY
SPECVARS
GLOBALVARS
ADDTOVAR
UPDATECHANGED
0
TAB
MEMB
((no block -) . 0)
LDIFF
((--) . 0)
APPEND
File
(VARIABLE-VALUE-CELL GLOBALVARS . 0)
(VARIABLE-VALUE-CELL RETFNS . 0)
(VARIABLE-VALUE-CELL BLKLIBRARY . 0)
(VARIABLE-VALUE-CELL NOLINKFNS . 0)
(VARIABLE-VALUE-CELL LINKFNS . 0)
(VARIABLE-VALUE-CELL DONTCOMPILEFNS . 0)
(VARIABLE-VALUE-CELL SPECVARS . 0)
(VARIABLE-VALUE-CELL LOCALVARS . 0)
(0 . 1)
(NIL VARIABLE-VALUE-CELL BLKAPPLYFNS . 0)
(NIL VARIABLE-VALUE-CELL ENTRIES . 0)
(NIL VARIABLE-VALUE-CELL LOCALFREEVARS . 0)
(NIL VARIABLE-VALUE-CELL BLKFNS . 0)
NIL
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL BLKAPPLYCALLERS . 0)
(NIL VARIABLE-VALUE-CELL ERRORS . 0)
(NIL VARIABLE-VALUE-CELL SHOULDBESPECVARS . 0)
UNION
*
EVAL
LOCALFREEVARS
BLKLIBRARY
SYSSPECVARS
BLKAPPLYFNS
ENTRIES
LINKFNS
NOLINKFNS
RETFNS
SYSLOCALVARS
"unrecognized item in block declaration"
"on block twice"
"BLKAPPLYFNS but not a real block"
"not on the file"
BIND
GETTABLE
TEST
SMASH
SET
REF
REFFREE
TESTTABLE
SETFREE
SMASHFREE
TESTFREE
"binds and never uses"
"should be SPECVAR (used in functional arg) in"
GLOBALVAR
GETPROP
CONSTANTEXPRESSIONP
"not declared, used freely by "
NOBIND
STKSCAN
RELSTK
"not declared, never bound, no top-level value, used freely by"
"not bound, not a GLOBALVAR, used freely by"
"not mentioned in block, but on"
POSITION
TERPRI
"<<<<< In "
PRIN1
((--) . 0)
PRIN2
": >>>>>"
DREVERSE
"----------------

"
", "
MACRO
IGNOREMACRO
MSFIND
"internal block function with MACRO property"
NLAMBDA
PREDICATE
EFFECT
CALL
"not an entry, called from outside the block by"
"not an entry or on RETFNS or BLKAPPLYFNS, called indirectly by"
"not an entry, not called from inside the block"
"must also be the FIRST function in the block"
"can't be both entry and block name"
"on ENTRIES or BLKAPPLYFNS but not in block"
((EQUAL GETPROP GETP NTH TAILP MEMBER) . 0)
BLKLIBRARYDEF
"on BLKLIBRARY but no BLKLIBRARYDEF property"
((BLKAPPLY BLKAPPLY*) . 0)
"BLKAPPLYFNS but no calls to BLKAPPLY in block"
CLRHASH
20
MSREHASH
HASHARRAY
(0 . 1)
(VARIABLE-VALUE-CELL LF . 0)
(0 . 1)
(NIL VARIABLE-VALUE-CELL LF1 . 0)
(NIL VARIABLE-VALUE-CELL SFLG . 0)
-1
PUTHASH
1
LINELENGTH
"
(note) "
"
(possible error) "
"
(probable error) "
SPACES
-
%.
4
" - "
" -"
".
"
" -"
"    %"%"    "
"-"
".
"
"but used freely by the entry"
"but the entry"
"can reach functions using it freely"
"on LOCALFREEVARS"
3
2
SHOULDNT
"might not need to be a specvar in"
"(used freely in)"
"is not a SPECVAR in"
" etc"
SASSOC
MEMBER
(CONSS1 LIST3 EQUAL MKN IUNBOX GETHSH URET2 URET6 URET3 CONS21 ASZ SKLA FMEMB SET KNOB SKLST URET1 KT CONS BHC CONSNL SKNLST KNIL 
BLKENT ENTER1)    
O@  P  08	80N   	P  "0:   /@
y.x
u.(
p-X
h+P
R)
D(
7 u(' tP  5xg   
5 uXu   	] Lh  1
($h
##
"p
"H

 <(M   f   15(
v.@
q-0
f+0
@#8

P7 {( hH \0Z ZxU WH9 Q Oh: AH
 58 /Pz .`s ( 3  h  M      h   /H OHx   x  6@2    -p
n-H
i,x
Q) 
I(0
)$X
$p	Ip	D
X0p) tXQ hxL W( HP= >Xr =`E &h/ `$  ( G   -41`
L	 %0; h e   &@
2#x	Q	Np	0@	'8	@gH*PXX" s W i0 a`` [`O Nd I(H Hx =x7 -@j )F h<  n 
h J @ 2 x  5 2( rS `@{ Kh[ 6@1 
0 P h  !x	?p	(lp3, q[ h `h@ V8l LV Fp ?`{ 5 p  I P
   @    
   15p+4`3H2 1H
z.p
t. 
o-P
k,h
b+H
[*x
H(x
E(
<&h
*#@
 @	|P	m`	`X	S	 X	@	h	
X	  ~xXji]H\(Q
P	xOP?x2 -8!h  p }` zPM xP= vp1 uP) th$ t8 s( qH pp p` or m(c k(Z kX jN i8F hP@ gx: f0+ d@ bp b aH
 `(  _x} _x ^`u ^8p ]xk ]g \`e \8a [PZ [ U Z(P Y0I XpE Wp> WP9 U`& Sp Qx
 Q P8 Op{ Ow Nhv NHh L`Y JPT J@S JK H< G06 FX0 E! C  AP
 @X ?(z > o =Pk <^ ;V :N 9F 8> 7/ 5@' 4h& 4X! 3 1( 0(  /X{ /v .@o -hd +HU )XC (< &@. %& $ # " !  H{ 8l H\ HS (P `G XC x9 6 83    \  W 	` K ` D x ? X 8   7 p .  $ H            
MSPATHSBLOCK BINARY
          :   m-.          :-.     ;hC       j   4  8  ,  ,~   -.    DZ   3B   +   
B HZ  +   ,< HZ ID I,<   @ <   +   LZ   XB  	  J,<   Zw~,<8  ,<   $ J,<   @ K @8+   IZ   3B   +   ,< O" P,<` Zp  -,   +   +   "Zp  ,<   ,<p  Z   3B   +   ,<wD P3B   +   Z"+   Z"   ,<   Z   F Q/   [p  XBp  +   /   ,< Q,< Q$ R@ R  +   H,<   Z   3B   +   4Zw|Z8 2B   +   ,Z  &Z  ,   ,<   , Z   Zw|XB8 Z  *,<   ,< QZ  *F QZ  .,<   ,<   ,<   ,  L[  0XB  3+   GZw|Z8 3B   +   FZ8 Z  /,   Zw|XB8 3B   +   =1B   +   =-,   +   CZ8 2B   +   CZw|Z8 ,<   Z   ,   ,<   Z  7F QZw|Z8 ,   XB  3Zw|[8 Zw|XB8 +   G  S+    +   &Zp  +    Z   ,~   ,<   Z  @XB  ,\   ,~   ,~   Z   ,<   ,<   ,<   ,<   Zw}2B   +   V  S    ."   ,   XB  QB S,< T" S[  L,<   , Z  RXBwZ  T3B   +   ZZ  W,<   ,< Q$ RZw~3B   +   ][  XXB  \,<w}, 2XBp  ,<w},<   , 4Zw}Z  J,   XBw1B   +   uZ   2B  +   f,< T" U+  3-,   +   h,   4" 3,< U" SZw-,   +   k+   s-,   +   sZw2B   +   s,<w, ,\  XB  Z  C,<   Zw|,   D VXB  oZw+   sB S,< V" S+  3Z  \,<  @ W  +  3Zw~,<?} ?    ^"/  ,   ,<   Z  `F QZ  2B   +  1Zw~,<?}Z YZ   7   [  Z  Z  1H  +  2D   +  [  Z  D Y,<   Zw~,<?}Z ZZ  7   [  Z  Z  1H  +  2D   +  	[  Z  D Y,<   Zw},<?}Z ZZ 7   [  Z  Z  1H  +  2D   +  [  Z  D Y,<   Zw},<?}Z [Z 7   [  Z  Z  1H  +  2D   +  [  Z  D Y,<   Zw|,<?}Z [Z 7   [  Z  Z  1H  +  $2D   +  ![  Z  D Y,<   Zw|,<?}Z \Z  7   [  Z  Z  1H  +  ,2D   +  )[  Z  D YD \D \D \D \D \+  cZw~,<?}Z YZ (7   [  Z  Z  1H  +  72D   +  3[  [  D Y,<   Zw~,<?}Z ZZ 27   [  Z  Z  1H  +  ?2D   +  ;[  [  D Y,<   Zw},<?}Z ZZ :7   [  Z  Z  1H  +  G2D   +  C[  [  D Y,<   Zw},<?}Z [Z B7   [  Z  Z  1H  +  O2D   +  K[  [  D Y,<   Zw|,<?}Z [Z J7   [  Z  Z  1H  +  W2D   +  S[  [  D Y,<   Zw|,<?}Z \Z R7   [  Z  Z  1H  +  _2D   +  [[  [  D YD \D \D \D \D \,<   ,<   ,<   ,<   ,<   Zw~-,   +  g+  uZ  XBp  ,<   ,<   , 42B   +  k+  sZp  XBwZw3B   +  q,<   Zw,   XBw~,\  QB  +  sZw,   XBwXBw~[w~XBw~+  eZw~/  XB` 2B   +  x,~   Zw~Z?~3B   +  #Z   3B   +  },<?}D P+  }Z   XB` 2B   +  ,<` Zp  -,   +  Z   +  Zp  ,<   ,<w/   ,<p  " ],   ,> :,>   Zw} 8  .Bx  ,^   /   ."  ,> :,>           ,^   /   3b  7   Z   /   3B   +  Zp  +  [p  XBp  +  /   3B   +  #Z  r,<   Zw~Z?},   D VXB ,< ]" SZ` 3B   +  Zw~,<?}, ,   ,<   Z  |F QZ  +  !Zw~,<?}, ,<   Z F QB S,< ^" S,~   Zw~Z8  Z  u,   XB $Zw~,<?},<?Z  F Q,<` Zp  -,   +  *+    ,<   Zp  ,<   ,<` [w2B   +  .7   Z   ,<   ,  LZ   XB` /   [p  XBp  +  (Z   +        ZwZ ',   2B   +  fZ  }2B   +  :,<w,<   ,< Q& ^Z   3B   +  A,<wD P3B   +  A,<wZ  c,<   Z 5F Q+  fZp  2B   +  LZ  3B   +  L,<wD P3B   +  L,<w,<   , 43B   +  K,<w,< _Z ?F Q+  fZ >+  fZ   2B   +  m,<wZ 72B   +  j,<w" _3B   +  j,<wZ [Z Z7   [  Z  Z  1H  +  W2D   +  S[  Z  D `2B   +  j,<wZ `Z R7   [  Z  Z  1H  +  _2D   +  [[  Z  D `2B   +  j,<wZ aZ Z7   [  Z  Z  1H  +  g2D   +  c[  Z  D `2B   +  jZ K+  kZ"   ,<   Z IF Q+  f,<wD P3B   +  q,<w,< QZ kF Q+  f,<wZ i,<   Z pF QZp  3B   +  yZ B3B   +  y,<wD P2B   +  fZ N2B   +  *,<wZ YZ b7   [  Z  Z  1H  +   2D   +  |[  Z  D Y,<   ,<wZ ZZ {7   [  Z  Z  1H  +  2D   +  [  Z  D Y,<   ,<w~Z ZZ 7   [  Z  Z  1H  +  2D   +  [  Z  D Y,<   ,<w~Z [Z 
7   [  Z  Z  1H  +  2D   +  [  Z  D Y,<   ,<w}Z [Z 7   [  Z  Z  1H  +  2D   +  [  Z  D Y,<   ,<w}Z \Z 7   [  Z  Z  1H  +  %2D   +  "[  Z  D YD \D \D \D \D \+  Y,<wZ YZ !7   [  Z  Z  1H  +  /2D   +  ,[  [  D Y,<   ,<wZ ZZ +7   [  Z  Z  1H  +  72D   +  3[  [  D Y,<   ,<w~Z ZZ 27   [  Z  Z  1H  +  >2D   +  ;[  [  D Y,<   ,<w~Z [Z :7   [  Z  Z  1H  +  F2D   +  B[  [  D Y,<   ,<w}Z [Z A7   [  Z  Z  1H  +  M2D   +  J[  [  D Y,<   ,<w}Z \Z I7   [  Z  Z  1H  +  U2D   +  Q[  [  D YD \D \D \D \D \,<   ,<   ,<   Zw-,   +  \+  dZ  XBp  ,<   ,<   , 42B   +  `+  c,<w~,< QZ sF Q+  e[wXBw+  ZZ r/  +  fZ dZ f3B  +  h7   Z   +        ,< a[wD b[  ,<   ,< b[wD b[  ,<   ,< c[w~D b[  ,<   ,< c[w~D b[  ,<   ,< d[w}D b[  ,<   ,< H" I,<   @ d@+  Z`  2B   +  ~Z   XB yZ LXB`  Z   XB |,<`  ,<   $ JXB` ,<   Zp  -,   +  +  Zp  ,<   ,<p  ,< QZ aF Q/   [p  XBp  +   /   ,<` Zp  -,   +  
+  Zp  ,<   ,<p  ,<` , /   [p  XBp  +  /   Z ,~   +    ,<   ,<w,<   , 43B   +  ZwZ ,   XBp  0B   +  ,<wZw3B   +  Z   +  Z"   ,<   Z F QZ {3B   +  M,<wZ YZ P7   [  Z  Z  1H  +  #2D   +  [  [  D Y,<   ,<w~Z ZZ 7   [  Z  Z  1H  +  *2D   +  '[  [  D Y,<   ,<w~Z ZZ &7   [  Z  Z  1H  +  22D   +  .[  [  D Y,<   ,<w}Z [Z -7   [  Z  Z  1H  +  92D   +  6[  [  D Y,<   ,<w}Z [Z 57   [  Z  Z  1H  +  A2D   +  =[  [  D Y,<   ,<w|Z \Z <7   [  Z  Z  1H  +  H2D   +  E[  [  D YD \D \D \D \D \+  |,<wZ YZ D7   [  Z  Z  1H  +  R2D   +  O[  Z  D Y,<   ,<w~Z ZZ N7   [  Z  Z  1H  +  Z2D   +  V[  Z  D Y,<   ,<w~Z ZZ U7   [  Z  Z  1H  +  a2D   +  ^[  Z  D Y,<   ,<w}Z [Z ]7   [  Z  Z  1H  +  i2D   +  e[  Z  D Y,<   ,<w}Z [Z d7   [  Z  Z  1H  +  p2D   +  m[  Z  D Y,<   ,<w|Z \Z l7   [  Z  Z  1H  +  x2D   +  t[  Z  D YD \D \D \D \D \,<   Zp  -,   +  ~+  Zp  ,<   ,<   , [p  XBp  +  |/   +  2B   +  Zw2B   +  ,<w,< hZ F QZ   +      S  
/"  
4b ,> :,>   ,< i" S>`x  5  /  Zp  -,   +  ,< i" SZp  2B   +  Z j+  ,< j" SZp  B S+    Zp  2B   +  Z   +    [p  ,<   , Zp  ,<   ,< Q$ R,< k" S+        0"  +  %^"  0,> :,>     .Bx  ,^   /   ,   A"  ?Z   ." Z  +  .^"  0,> :,>      &"     .Bx  ,^   /   ,   A"  ?Z #." Z  ,<     &&"  ,   D k,<     ,."   ,   XB /,\   ,~   Z   3B   +  6,<p  D P3B   +  6,< l" S,<p  " l  m,   ."   ,   +       ij!SF(EhD($@T@   9HD	uf|PH
"H$ )Dd
"H@$ )
D@00@@B	b
 H$)< " 2Pd)+$*@% )(
T5,*PH
$
$Ot$II$@'p0Zd)%SR C
B
(II$@$@S}I$@R@R ))|1&hst!<( P  W0                (MSPATHSBLOCK#0 . 1)
(VARIABLE-VALUE-CELL MSCRATCHASH . 149)
(VARIABLE-VALUE-CELL TABS . 586)
(VARIABLE-VALUE-CELL LINENUM . 172)
(VARIABLE-VALUE-CELL SEEN . 1293)
(VARIABLE-VALUE-CELL MSBLIP . 973)
(VARIABLE-VALUE-CELL NAMED . 557)
(VARIABLE-VALUE-CELL INVERTED . 1080)
(VARIABLE-VALUE-CELL MSDATABASELST . 1255)
(VARIABLE-VALUE-CELL SEPARATE . 500)
(VARIABLE-VALUE-CELL LL . 1298)
(VARIABLE-VALUE-CELL AVOIDING . 629)
(VARIABLE-VALUE-CELL NOTRACE . 747)
(VARIABLE-VALUE-CELL TO . 1019)
(VARIABLE-VALUE-CELL BELOWCNT . 1377)
(VARIABLE-VALUE-CELL FCHARAR . 1365)
(VARIABLE-VALUE-CELL MARKING . 1380)
MSPATHS
MSONPATH
MSPATHS2
*MSPATHS*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL TO . 0)
((UNBOXED-NUM . 3) VARIABLE-VALUE-CELL INVERTED . 0)
((UNBOXED-NUM . 4) VARIABLE-VALUE-CELL AVOIDING . 0)
((UNBOXED-NUM . 5) VARIABLE-VALUE-CELL SEPARATE . 0)
((UNBOXED-NUM . 6) VARIABLE-VALUE-CELL NOTRACE . 0)
((UNBOXED-NUM . 7) VARIABLE-VALUE-CELL MARKING . 0)
CLRHASH
20
MSREHASH
HASHARRAY
LINELENGTH
MSLISTSET
(VARIABLE-VALUE-CELL LL . 0)
(0 . 1)
(NIL VARIABLE-VALUE-CELL TABS . 0)
(0 VARIABLE-VALUE-CELL BELOWCNT . 0)
(0 VARIABLE-VALUE-CELL LINENUM . 0)
T
NIL
(NIL VARIABLE-VALUE-CELL NAMED . 0)
NIL
((inverted tree) . 0)
PRINT
MSMEMBSET
PUTHASH
0
TAB
(NIL VARIABLE-VALUE-CELL MSPRINTFLG . 0)
TERPRI
PRIN1
"."
5
SHOULDNT
" {"
NCONC
"}"
(VARIABLE-VALUE-CELL TABS . 0)
T
NIL
NIL
NLAMBDA
GETTABLE
PREDICATE
ERROR
EFFECT
CALL
APPLY
UNION
NCHARS
" {"
"}"
UPDATEFN
-1
GETD
TESTTABLE
NOBIND
REF
FROM
ASSOC
TO
AVOIDING
NOTRACE
TOPFLG
(0 . 1)
(VARIABLE-VALUE-CELL TO . 0)
(VARIABLE-VALUE-CELL AVOIDING . 0)
(VARIABLE-VALUE-CELL NOTRACE . 0)
(0 . 1)
(VARIABLE-VALUE-CELL SEEN . 0)
(NIL VARIABLE-VALUE-CELL INVERTED . 0)
NIL
1
-
"------------   "
""
"--- overflow - "
"|"
PACK*
">"
PRIN2
POSITION
(URET3 URET2 URET7 CONS IUNBOX GUNBOX SKNM MKN URET1 CONSNL SKLST GETHSH BHC ASZ SKNLST KT KNIL BINDB BLKENT ENTER1) 	   j   4   %   9  `       p   W 1 Uh* T0 | 
0   W( S B+ 	 G    "hs   r 8 @    @ <    &h b  ,   * T( P0 A` @hf &  !p ! h #    C0 -8 c 0  h   O`
 @ \ %  p j     P@ ?x| =G %p 0    5 V8 Rp Q Px Ni LZ J(H H9 F * D0 C B0 ?`{ =` ;p[ ;(U 9XF 7h7 5x% 3` 1p 0 z /w .Xo -g ,_ +W *O )XH (`D ((> '@: '7 &@1 %x. # !x    `{  w `k  f Xe H_ pO p? p, H H H ~ X ` @ X 
 O 	p N 	 @ X : h 2 X *   ' X  P      p    (      
MSPATHS BINARY
              -.     8      ,<    ,~       (FROM . 1)
(VARIABLE-VALUE-CELL TO . 0)
(VARIABLE-VALUE-CELL INVERTED . 0)
(VARIABLE-VALUE-CELL AVOIDING . 0)
(VARIABLE-VALUE-CELL SEPARATE . 0)
(VARIABLE-VALUE-CELL NOTRACE . 0)
(VARIABLE-VALUE-CELL MARKING . 0)
MSPATHS
(NIL)
(LINKED-FN-CALL . MSPATHSBLOCK)
(ENTERF)     
MSONPATH BINARY
               -.           ,<    ,~       (SETREP . 1)
MSONPATH
(NIL)
(LINKED-FN-CALL . MSPATHSBLOCK)
(ENTER1)     
MSPATHS2 BINARY
               -.           ,<    ,~       (FN . 1)
(FLG . 1)
MSPATHS2
(NIL)
(LINKED-FN-CALL . MSPATHSBLOCK)
(ENTER2)     
%. BINARY
              -.          ,<`  "  ,~       (MASTERSCOPECOMMAND . 1)
MASTERSCOPE
(ENTER1)     
MSMARKCHANGE1 BINARY
               -.          Z` 2B   +   Z   XB` ,<`  ,<   ,<   Zw2B   +   +   -,   +   
XBp  Z   XBw+   ZwXBp  [wXBw,<p  ,<` Z   F  +   Zw/  Z  ,<   ,<`  ,<` ,   B  ,~   Q d     (FNS . 1)
(FLG . 1)
(VARIABLE-VALUE-CELL MSCHANGEDARRAY . 27)
PUTHASH
MSMARKCHANGE1
UNDOSAVE
(LIST3 BHC SKNLST KT KNIL ENTER2)                  
  p   X        
MSFIND BINARY
            -.           Z`  Z` 3B  7   7   +   Z`  -,   +   
Z`  ,<   ,<` $  2B   +   [`  XB`  +   Z   ,~   $)  (IN . 1)
(X . 1)
MSFIND
(SKLST KNIL KT ENTER2)   `   8 	  H    @      
MSSTOREDATA BINARY
       Z    L    W-.           L-.     0 M    P-.     P,<  Q"  Q,<   ,<   Z   XB   ,<`  ,<   Z   F  RZ   ,<   ,<   ,<   Zw-,   +   +   Z  XBp  Zp  Z   ,   2B   +   [p  [  2B   +   +   Zp  ,<   ,<   ,  &XBw~,<`  ,<wF  R[wXBw+   Zw/  ,<`  ,<w$  S2B   +   #,<`  ,<   Z  SZ  	7   [  Z  Z  1H  +   "2D   +   [  Z  F  T,<`  ,<   Z  F  RZ   +    Zw-,   +   :Zw2B  T+   0[wZ  ,<   ,<   ,  &,<   [w[  Z  ,<   ,<   ,  &D  U+    2B  U+   8[wZ  ,<   ,<   ,  &,<   [w[  Z  ,<   ,<   ,  &D  V+    ,<  V"  W+    Zp  2B   +   AZwZ   7   [  Z  Z  1H  +   @2D   +   =2B   +   GZwZ   7   [  Z  Z  1H  +   F2D   +   C[  +   K[  Z  ,<   Z   XBw,\   XBw+   &+    pb
 )X 6     (FNNAME . 1)
(VARIABLE-VALUE-CELL FNDATA . 132)
(VARIABLE-VALUE-CELL MSDBEMPTY . 13)
(VARIABLE-VALUE-CELL MSCHANGEDARRAY . 73)
(VARIABLE-VALUE-CELL MSDATABASELST . 59)
(VARIABLE-VALUE-CELL NODUMPRELATIONS . 29)
(VARIABLE-VALUE-CELL TABLE.TO.NOTICED . 120)
(VARIABLE-VALUE-CELL FNDATA . 0)
*MSSTOREDATA*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL FNDATA . 0)
KNOWN
PARSERELATION
PUTHASH
STORETABLE
TESTRELATION
NOBIND
PUTTABLE
-
LDIFFERENCE
+
UNION
2
SHOULDNT
(SKLST URET2 BHC FMEMB SKNLST KT KNIL BINDB BLKENT ENTERF)   (    L ( 9  '                7 @ / @  (     J h A  ; h %    P  8   p                

MASTERSCOPEBLOCKA0006 BINARY
       #        "-.           [   ,<   Zp  -,   +   Z   +   Zp  ,<   ,<w/   ,<` ZwD  !/   3B   +   Zp  +   [p  XBp  +   /   2B   +   Z   0B   +   Z   ,<  ,<`  "   ,   ,~   ,<` Z   D  !,<   Zp  -,   +   Z   +   Zp  ,<   Z  ,<   ,<` ,<w "  ,   /   [p  XBp  +   /   ,~   PIP @ (DUMMY . 1)
(MAPX . 1)
(VARIABLE-VALUE-CELL MAPFN2 . 3)
(VARIABLE-VALUE-CELL MAPZ . 28)
(VARIABLE-VALUE-CELL MAPFN . 48)
(VARIABLE-VALUE-CELL MAPW . 38)
TESTTABLE
GETRELATION
(EVCC ASZ BHC KNIL SKNLST ENTER2)    (   x   `  X 	  x   p          @      

MASTERSCOPEBLOCKA0007 BINARY
     X    L    U-.         0 LZ`  3B   +   C,<` Z  PZ   7   [  Z  Z  1H  +   2D   +   [  Z  D  Q2B   +   C,<` Z  QZ  7   [  Z  Z  1H  +   2D   +   [  Z  D  Q2B   +   C,<` Z  RZ  7   [  Z  Z  1H  +   2D   +   [  Z  D  Q2B   +   C,<` Z  RZ  7   [  Z  Z  1H  +    2D   +   [  [  D  Q2B   +   C,<` Z  PZ  7   [  Z  Z  1H  +   (2D   +   %[  [  D  Q2B   +   C,<` Z  SZ  $7   [  Z  Z  1H  +   02D   +   -[  [  D  Q2B   +   C,<` Z  SZ  ,7   [  Z  Z  1H  +   82D   +   5[  [  D  Q2B   +   C,<` Z  TZ  47   [  Z  Z  1H  +   @2D   +   =[  [  D  Q3B   +   K,<` Z   ,<   Z   ,<  Z   ,<  ,<  TZ   L  U3B   +   LZ` Z   ,   XB  I,~   Z   ,~   @RP(
*J% )(T     (VAL . 1)
(KEY . 1)
(VARIABLE-VALUE-CELL MSDATABASELST . 120)
(VARIABLE-VALUE-CELL TYPE . 135)
(VARIABLE-VALUE-CELL SHOWSET . 137)
(VARIABLE-VALUE-CELL EDIT . 139)
(VARIABLE-VALUE-CELL EDITCOMS . 142)
(VARIABLE-VALUE-CELL DONE . 149)
CALL
TESTTABLE
NOBIND
REF
APPLY
EFFECT
PREDICATE
NLAMBDA
CHANGED
MSSHOWUSE
(CONS KNIL KT ENTER2)   	0   	H I 0 @ 0 8 0 0 0 ( 0   0  0  0            

MASTERSCOPEBLOCKA0008 BINARY
       3    &    2-.     (     &,<`  ,<` $  *3B   +   &Z   2B   +   	,<  *,<  *,<   &  +Z   B  +,<  ,"  ,,<` Z` 3B   +   ,<   ,<` $  -2B   +   Z` +   Z   ,   Z  ,   XB  Z` 2B  -+   Z` [  7   [  Z  Z  1H  +   2D   +   3B   +   Z   ,~   Z   +   Z   ,~   ,<  ."  .,<`    /,<   ,<  /&  0Z  [  3B   +   &,<  0"  ,,<`    /,<   ,<  /&  1,<  1"  ,,~   N\% `	Vx    (ITEM . 1)
(SS . 1)
(SE . 1)
(PRNT . 1)
(INCLISP . 1)
(VARIABLE-VALUE-CELL ANYFOUND . 63)
(VARIABLE-VALUE-CELL SHOWFN . 15)
MSMEMBSET
0
TAB
PRIN2
" :
"
PRIN1
MSFIND
SHOW
3
SPACES
OUTPUT
2
LVLPRINT
"   {under "
LVLPRIN2
"}
"
(CONS CONSS1 KT KNIL ENTER5)            x           `   X        

MASTERSCOPEBLOCK BINARY
         4   $-.          4-.    05~(P   C      E   c   x   9   K   q   F      E   ;   O   5   R   R   N         C      -   u   z   L   5   W[w[  ,<   ,<   ,<   Zw-,   +   >3B   +   ,<   ,<w,<w,<w},   B ][w}Z  Z  3B   +   4[w},<   [w}Z  Z  ,<   ,<   ,<   Zw2B   +   !+   )-,   +   $XBp  Z   XBw+   &ZwXBp  [wXBw,<w,< ^,<w, zD ^XBw+   Zw/  Z   ,   ,<   Z   ,   Z   ,   ,   Z _,   ,   Z _,   D `,<w},<w},<w},  +    Zw~2B `+   6Zw~+    2B a+   8Z   +    2B a+   ;,<w}, +    2B b+   =Z   +    ,< b" ]+    Zw2B c+   LZw~2B `+   BZw~+    2B a+   E,<w}, +    2B a+   GZ  7+    2B b+   K[w,<   ,<w~ "   ,   +    ,< c" ]+    2B d+   ^Zw~2B `+   R[w,<   ,< `,<w},  +    2B a+   T,<w}, +    2B a+   VZ  F+    2B b+   \[w,<   ,< b,<w},  2B   +   [7   Z   +    ,< d" ]+    2B _+  4Zw~2B `+   aZw~+    3B a+   c2B a+  [wZ  [  ,<   [w~Z  Z  ,<   [w~[  ,<   @ e `
 +  Z   ,<   ,< a,<   ,  XB` Z  U2B  +   z,<`  Zp  -,   +   q+   yZp  ,<   Z` 3B   +   u[p  +   uZp  ,<   Z UD g/   [p  XBp  +   o/   +  ,<`  Zp  -,   +   |+  Zp  ,<   ,<` Zp  -,   +   +  	Zp  ,<   ,<p  Z` 3B   +  Zw~+  [w~D h,<   Z   D hXB /   [p  XBp  +   ~/  [p  XBp  +   z/   Z ,~   +    2B b+  2[wZ  [  ,<   [w~[  ,<   [w~Z  Z  ,<   @ i `  +  2,<`  ,<   ,<   Zw-,   +  +  1Z  XBp  Zw~,<?~Z` 3B   +  [w+  ZwD h,<   ,<   ,<   Zw-,   +  !+  *Z  XBp  Z  j,<  ,< b,<   ,  3B   +  )Zp  2B   +  (Z   XBw+  *[wXBw+  Zw/  3B   +  /Zp  2B   +  .Z   XBw+  1[wXBw+  Zw+    +    ,< j" ]+    2B k+  dZw~2B `+  7Zw~+    3B a+  92B a+  I@ k   +  HZw[?Z  ,<   Zp  -,   +  ?+  GZp  ,<   ,<p  Z ,<   ,<   Zw}[?[  ,<   , {XB @/   [p  XBp  +  =/   Z D,~   +    2B b+  c[wZ  ,<   Zp  -,   +  NZ   +  bZp  ,<   ,<w/   ,<w},<w$ hXBp  3B   +  ]Z  m3B  +  ],<p  [w}[  ,\  1B  +  Z-,   +  Z*  ,   2B   7       2B   +  \7   Z   +  ^Z   /   3B   +  `Zp  +  b[p  XBp  +  K/   +    ,< l" ]+    2B l+  JZw~2B `+  lZw~3B   +    Z   ,<  [w~D hXB hZ   +    3B a+  n2B a+  E[w}Z  Z  2B   +  r[w}Z  [  [  XBp  Zw~3B   +  73B m+  7Zp  3B m+  7[wXBwZ   ,   3B   +  7Zw~2B m+  7,<wZ nZ   7   [  Z  Z  1H  +  2D   +  }[  Z  D n2B   +  7,<wZ oZ |7   [  Z  Z  1H  +  	2D   +  [  Z  D n2B   +  7,<wZ oZ 7   [  Z  Z  1H  +  2D   +  [  Z  D n2B   +  7,<w" p2B   +  7[w}Z  ,<   Zw~2B m+  Z p+  D q[w,<   ,<   ,<   ,<   Zw~-,   +  Zw+  ,Zw~,<   ,<p  ,<w{,<   , /   XBp  -,   +  +Zw3B   +  'Zp  QD  +  (Zp  XBw       [  2D   +  (XBw[w~XBw~+  /  XBw[w,<   ,<   $ q,< r,<   $ q[w,<   ,<   $ q,<   " r[w}[  ,<   ,<w$ `[  +    Zp  2B p+  D[w,<   ,< s$ s3B   +  D[wB p2B   +  D,< t,<   $ q[w,<   ,<   $ q,< t,<   $ q,<   " r[w+    2B b+  I,<w~[w~    ,\   ,   +    ,< u" ]+    2B u+  {Zw~2B `+  V[wZ  ,<   ,< `,<w},  ,<   [w~[  ,<   ,< `,<w},  2B   +  UZp  /   +    3B a+  X2B a+  q,<   ,<   Z S,<   [w}Z  ,<   ,<w|,<   ,  XBw,\  2B  +  `Z Y+  pZ _,<   [w}[  ,<   ,<w|,<   ,  XBw,\  2B  +  n[w~Z  [  [  Z  3B l+  m[w~Z  [  ,<   Z lZw,   D `Z `+  p,<w,<w$ h/  +    2B b+  y[wZ  ,<   ,< b,<w},  2B   +    [w[  ,<   ,< b,<w},  +    ,< v" ]+    2B v+  EZw~2B `+  [wZ  ,<   ,< `,<w},  ,<   [w~[  ,<   ,< `,<w},  2B   +  Zp  /   +    3B a+  2B a+  :,<   ,<   Z m,<   [w}Z  ,<   ,< a,<   ,  XBw,\  2B  +  (Z 	,<   [w}[  ,<   ,<w|,<   ,  XBw,\  2B  +  Z +  9,<p  ,<   Zw-,   +  Zp  Z   2B   +   "  +  [  QD   "  +  'Zw,<   [w|Z  ,<   ,< b,<w,  /   3B   +  %ZwZp  ,   XBp  [wXBw+  /  +  9,<w,<   Zw-,   +  /Zp  Z   2B   +  - "  +  /[  QD   "  +  8Zw,<   [w|[  ,<   ,< b,<w,  /   3B   +  7ZwZp  ,   XBp  [wXBw+  )/  /  +    2B b+  C[wZ  ,<   ,< b,<w},  3B   +  B[w[  ,<   ,< b,<w},  +    Z   +    ,< w" ]+    2B w+  [,<w,< v$ q[w[  [  ,<   [w~[  Z  ,<   [w~[  [  Z  Z  ,<   [w}[  [  Z  [  Z  ,<   [w}[  [  Z  [  [  ,   ,   ,<   [w}[  [  [  ,   ,   Z d,   D `+  2B x+  a[wB x-,   3B   7    ,   Z l,   XBw+  2B y+  Zw~2B `+  v[w[  Z  3B   +  j[w[  Z  ,<   ,< `,<   ,  +  kZ   ,<   [w~[  [  3B   +  r[w~[  [  ,<   ,< `,<   ,  +  rZ   ,<   Zw2B   +  uZp  /  +    [wZ  ,<   [w~[  Z  ,<   [w~[  [  3B   +   [w~[  [  ,<   ,< a,<   ,  +   Z   ,<   , 9Z l,   XBw+  2B y+  Zw~2B `+  	[w,<   ,<w},<   ,  +    ,<   [w~,<   ,<   ,<   , 5,<   Zp  -,   +  +  Zp  ,<   ,<p  " z,<   ,<w~$ hXBw/   [p  XBp  +  /   Zp  /   Z l,   XBw+  2B z+  [wZ  ,<   [w~[  ,<   ,<   ,<   [w~Z  3B v+  !3B u+  !2B w+  B[w~Z  ,<   Zw{,<   [wzZ  Z  ,<   [wzZ  [  Z  [wzZ  [  [  ,   ,   ,<   Zw},<   [w|[  Z  ,   Zw},   Z z,   ,   ,   ,<   Zwz,<   [wzZ  Z  ,<   [wyZ  [  Z  [wyZ  [  [  ,   ,   ,<   Zw|,<   [w|[  [  ,   Zw},   Z z,   ,   ,   ,   ,   XBw}+  2B n+  V[w~[  2B {+  wZw~2B {+  PZ |Zw,   ,<   Z   ,   Z   ,   ,   Z   ,   Z |,   ,<   Z }Z   ,   ,   +  TZ |Zw,   ,<   Z }Z   ,   ,   Z },   XBw}+  2B ~+  wZw2B ~+  Y,< " ]Zw~2B {+  g,<w,< a,<   ,  ,<   [w~[  2B   +  e[w{Z  Z  2B   +  e[w{Z  [  [  2B   +  eZ p,<   ,<   , +  u,<   [w~[  2B   +  p[w~Z  Z  2B   +  p[w~Z  [  [  2B   +  pZ p,<   ,<w~,< a,<   ,  2B   +  tZ   ,<   , Z l,   XBw}+  Zw|2B `+  },<w,< `[w~Z  [  Z  ,<   ,  XBp  [w~Z  ,<   [w~[  ,<   , zXBw[w{,<   Zw~2B {7   Z   Zw,   Zw~,   Z _,   XBw|D `,<w{,<w{,<w{,  2B   +  Zp  /  +  /  +  +    2B }+  Zw~2B `+  [w,<   ,<   , y+    ,<w" ,   Z   ,   Z k,   XBw+  ,<  " ]+    [w},<   ,<w~$ `+   Z 3B   +  4Zp  2B  +  &,<w" p2B   +  %,<w,< ,<   , c,<   ,< ,<   , R+    Z   +    3B +  (2B +  3,<w,< ,<   , c,<   ,<w~" 3B   +  0,<w~" ,<   ,< ,<   , c+  0Z   D h,<   ,< ,<   , R+    Z   +    Z   +    Z 3B   +  BZp  3B  +  B,<w,< ,<   , c,<   ,<w,< $ ,<   ,<w~,<   ,<   , j2B 7   Z   ,<   , R+    Z   +        Z 53B   +  WZp  3B   +  W,<w,< ,<   , c,<   ,<wZp  -,   +  K+  RZp  ,<   ,<p  ,< ,<   , c,<   ,<w~$ hXBw/   [p  XBp  +  I/   Zp  /   ,<   ,< Z   ,<   , R+    Z   +    Z C3B   +  `ZwZ   ,   3B   +  `,<w,< 	,<   , c,<   ,< 	,<   , R+    Z   +    @ 
   +  xZw,<?,< `Z?2B   +  h[?Z  [  Z  +  iZ   ,<   ,  2B   +  lZwZ8  ZwXB8  Z j,<  Zp  -,   +  p+  tZp  ,<   ,<   ,<   , L[p  XBp  +  n/   ZwZ8  3B   +  w, u, Z   ,~   +    ,<   ,<w,<   ,<   Zw-,   +  }+  	Z  XBp  Zp  Z 
,   2B   +  +  [p  ,<   ,< `Zw2B |7   Z   ,<   ,  3B   +  Z   XBw~[wXBw+  {Zw/  Zp  2B   +    Z |Zw7   [  Z  Z  1H  +  2D   +  2B   +  7   Z   +        @    +  DZwZ8  3B   +  ,<   Zp  -,   +  +  Zp  ,<   ,<   ,<   , L[p  XBp  +  /   +  , u,< " ,< " q  rZ X,<   @   +  AZ`  -,   +  &+  @Z  XB   Z &,<   Z   D b3B   +  *+  >Z   XB   ZwZ8  3B   +  /[ '[  2B   +  2[ -Z  ,<   Z QD g+  <Zw,<8  Zp  -,   +  5+  <Zp  ,<   ,<p  [ /Z  D h,<   ,<w, E/   [p  XBp  +  3/   Z +3B   +  >  [`  XB`  +  $Z` ,~     r,< " q  rZ   ,~   +        Zp  3B   +    Z <2B   +  JZ 7B XB F,< " ,<p  " ,< " ,<w" ,< " +    Zw3B   +  R,<   ,<w~$ qZp  2B   +  TZ XBp  Zw~2B   +  V+  _-,   +  XB +  _Zw~,<   ,<w~$ [w~XBw~2B   +  ]+  _,<p  ,<w~$ q+  XZw3B   +  b,<   ,<w~$ qZ   +        ,<   Zw2B +  fZw+  g,<w, [  ,<   Zp  -,   +  j+  vZp  ,<   ,<w}Zw~3B   +  q[w-,   +  p,<w},< $ [w+  rZwD h,<   ,<w~$ hXBw/   [p  XBp  +  h/   Zp  +        ,<p  ,<   , C+    ,<w,<w$ 2B   +  ~,< " ],<   ,<   Zw-,   +  Zp  Z   2B   +   "  +  [  QD   "  +    Zw,<   Zp  -,   +  Zp  Z !7   [  Z  Z  1H  +  2D   +  	[  [  ,   +  Zp  Z 7   [  Z  Z  1H  +  2D   +  [  /   Zp  ,   XBp  [wXBw+  ,<   [wZ  Z  2B   +  [wZ  [  [  ,<   ,<   ,<   Zw2B   +   +  7-,   +  #XBp  Z   XBw+  %ZwXBp  [wXBw,< ^Zw2B p+  +[w}Z  [  Z  3B   +  +Z m+  ,Zw,<   , z,<   Zp  -,   +  /+  6Zp  ,<   Zp  ,<   ,<w},<w|,<   , {XBw}/   [p  XBp  +  -/   +  Zw/  Zp  +        , :,~   -.    Z   B ,<   ,<`  , ,<   @  @  ,~   [   ,<   Zp  -,   +  C+  I,<   @    +  HZ   Z  ,<   Z D g,~   [p  XBp  +  A/   Z   ,~       Zw3B   +  TZw-,   3B   7    ,   ,<   Zw2B   +  R7   Z   ,<   , `+    , U+    -.      ,< ,<   $ qZ   ,<   ,<   $ q,<   " r,<   ,< ,<   ,<   @  ` +  pZ   Z XB ,< ,<   Z   F ,<   ,<   $ Zw~XB8  3B +  f2B +  i,<   ,<   $ ,<   ,< $ +  o3B +  k2B +  mZ B +  o,<   ,< ,<   Z SH Z   ,~   +  [    ,<   Zw2B   +  {Zw-,   +  ZwZ 7@  7   Z  2B o+  Z   ,<   ,<w~$ 2B   +  Zw-,   +  ."   Z  3B   +  Zw-,   +  [w2B   +  Zw3B   +  Zw-,   +  ,<w" 0B  +  Z   +    ZwZw,   XBp  Zp  3B +  3B +  3B  +  3B  +  2B !+  ,< ,<   ,<   & Z   -,   +  ,<   Z !Z ,   ,\  XB  ,<p  ,<   , `XB   Z   +    ,<   ,<   Z   3B   +  C,< ",<   $ q,<   " r  ",< p" #XBp  Z x3B   +  $,< #,< $,<   ,   +  $Z   ,<   Zw3B   +  )Z  3B   +  )Z $+  )Z   ,<   Zw3B   +  .,< x,< $,<   ,   +  .Z   F %XBw3B   +  DZ   -,   +  6^"  ,> 4,>     0$Bx  ,^   /   ,   +  7Z   ,<   ,< %,< &,<w~$ %XBw~Z &,   ,<   ,< '( '2B (+  D,<w,<   , KZ 3B   +  C,< (,<   $ q,<   " r+  DZ   +      )+  C     Z   ,<   ,<   ,<   Zw-,   +  J+  TZ  XBp  [p  Z  2B   +  R[p  [  Z  B )2B   +  P+  R[p  [  Z  B *[wXBw+  HZw/  Z   XB F,~       , X,~   -.    *,<   ,<   ,<   ,<   Z   ,<   Z +Z 7   [  Z  Z  1H  +  a2D   +  ][  Z  D hXBw3B   +  f3B   +  e+  nZ   +  nZ [B p3B   +  jZ fB ,+  nZ h,<   ,<   ,<   ,<   , [  Z  XBw,< ,,<   $ qZ   ,<   ,<   $ -Z j,<   ,<   $ Z   ,<   ,<   $ -,<w,<   ,< -,< .,<   , OZ r,<   Z nZ \7   [  Z  Z  1H  +  2D   +  {[  Z  D n2B   +  	Z y,<   Z oZ z7   [  Z  Z  1H  +  	2D   +  	[  Z  D n2B   +  	Z 	,<   Z oZ 	7   [  Z  Z  1H  +  	2D   +  	[  Z  D n2B   +  	,< .,<   $ q,<` " /2B   +  	Z` -,   Z   Z  B /3B   +  	!Z 	
Z` ,   XBp     +  	!,< /,<   $ 0,< 0" q,<p  " 1B q,< 1" q  rZ 	,<   Z 2Z 	7   [  Z  Z  1H  +  	(2D   +  	$[  Z  D h,<   Z 	",<   Z 2Z 	#7   [  Z  Z  1H  +  	02D   +  	,[  Z  D h,<   Z 	*,<   Z 3Z 	+7   [  Z  Z  1H  +  	82D   +  	4[  Z  D h,<   Z 	2,<   Z nZ 	37   [  Z  Z  1H  +  	@2D   +  	<[  Z  D h,<   Z 	:,<   Z cZ 	;7   [  Z  Z  1H  +  	H2D   +  	D[  Z  D hD hD hD hD h,<   ,< 3, Z 	B,<   Z 2Z 	C7   [  Z  Z  1H  +  	S2D   +  	O[  [  D h,<   Z 	M,<   Z 2Z 	N7   [  Z  Z  1H  +  	[2D   +  	W[  [  D h,<   Z 	U,<   Z 3Z 	V7   [  Z  Z  1H  +  	c2D   +  	_[  [  D h,<   Z 	],<   Z nZ 	^7   [  Z  Z  1H  +  	k2D   +  	g[  [  D h,<   Z 	e,<   Z cZ 	f7   [  Z  Z  1H  +  	s2D   +  	o[  [  D hD hD hD hD h,<   ,< 4, Z 	m,<   Z 4Z 	n7   [  Z  Z  1H  +  	~2D   +  	z[  Z  D h,<   Z 	x,<   Z 5Z 	y7   [  Z  Z  1H  +  
2D   +  
[  Z  D h,<   Z 
 ,<   Z 5Z 
7   [  Z  Z  1H  +  
2D   +  

[  Z  D h,<   Z 
,<   Z oZ 
	7   [  Z  Z  1H  +  
2D   +  
[  Z  D h,<   Z 
,<   Z 6Z 
7   [  Z  Z  1H  +  
2D   +  
[  Z  D hD hD hD hD h,<   ,<   ,<   ,<   ,<   Zw~-,   +  
&+  
8Z  XBp  Zp  Zw}1B  +  
,*  -,   +  
,*  ,   2B   7       3B   +  
.+  
6Zp  XBwZw3B   +  
4,<   Zw,   XBw~,\  QB  +  
6Zw,   XBwXBw~[w~XBw~+  
$Zw~/  ,<   ,< 6, Z 
,<   Z 7Z 
7   [  Z  Z  1H  +  
@2D   +  
=[  Z  D h,<   Z 
:,<   Z 7Z 
<7   [  Z  Z  1H  +  
H2D   +  
E[  Z  D h,<   Z 
B,<   Z 8Z 
D7   [  Z  Z  1H  +  
P2D   +  
M[  Z  D h,<   Z 
J,<   Z 8Z 
L7   [  Z  Z  1H  +  
X2D   +  
U[  Z  D hD hD hD h,<   Zp  -,   +  
^+  
jZp  ,<   Zp  Z   ,   2B   +  
d,<p  ,< 9$ 93B   +  
fZp  Zw},   XBw}+  
hZp  Zw~,   XBw~/   [p  XBp  +  
\/   ,<w,< :, ,<w~,< :, Z 
R,<   Z ;Z 
T7   [  Z  Z  1H  +  
t2D   +  
p[  Z  D h,<   Z 
n,<   Z ;Z 
o7   [  Z  Z  1H  +  
|2D   +  
x[  Z  D hD h,<   ,< <, Z   ,<   ,<   ,<   ,<   Zw~-,   +  +  Z  XBw[wZ  B xXBp  2B   +  +  
,<   Zw,<   , [w~XBw~+  Zw/    rZ   +    Zw3B   +    ,< <" ,<p  " q,< " ,<   ,<   Zw~2B   +  +  )-,   +  B +  )  =XBw  =XBp    =,   ,> 4,>   Zw~B >,   .Bx  ,^   /   ."  ,> 4,>    w    ,^   /   3b  +  $,<p  " 0Zw~B [w~XBw~2B   +  (+  ),< >" q+    rZ   /  +    Zp  2B   +  2Z   XB   Z   XB 
wZ   XB   Z   XB   Z   XB ?+    ,<   Zp  -,   +  5Z   +  8Zp  B ?[p  XBp  +  3/   +    ,<   Zw2B   +  ;Z &,<   ,<   ,<   Zw2B   +  ?+  -,   +  BXBp  Z   XBw+  DZwXBp  [wXBw,<p  ,< y$ ?,<   ,<   ,<   Zw-,   +  I+  Z  XBp  Zw|3B   +  Z,<p  Zp  -,   +  NZ   +  XZp  ,<   ,<w/   Zp  -,   +  T,<   ,<wz, O+  TZ   /   3B   +  WZp  +  X[p  XBp  +  L/   2B   +  Z+  Zw{3B @+  ^3B @+  ^2B   +  l[p  ,<   ,<   ,<   Zw-,   +  b+  jZ  XBp  -,   +  iZp  Zw{,   3B   +  g+  iZp  Zw{,   XBw{[wXBw+  `Zw/  +  ,<p  ,<   ,<   Zw-,   +  o+  Z  XBp  -,   +   Zp  Zwz1B  +  v*  -,   +  w*  ,   2B   7       2B   +  y+   [p  Z  2B A+  }[p  [  Z  B x+  ~[p  ,<   ,<w{$ hXBw{[wXBw+  mZw/  Zw{2B A+  Zp  3B   +  Zp  [p  ,   3B   +  Zp  Zw},   2B   +  Zp  Zw},   XBw}[wXBw+  GZw/  Zw}2B   +  ,<p  Zw|2B @+  Z p+  D ?,<   ,<w~$ hXBw~+  =Zw/  Zp  +    ,<   ,<   Zw}3B   +  -,   +  Z   +    B BXBwB B3B   +   Zw+    Zw~0B   +  "+  Zw~2B   +  EZw~3B }+  ,<w}" C2B   +  >,<w}Z CZ .7   [  Z  Z  1H  +  -2D   +  )[  [  D h,<   ,<   ,<   Zw-,   +  2+  =Z  XBp  B D2B   +  9,<p  [ /Z  D h[  XBp  B D3B   +  <Zp  2B   +  ;Z   XBw+  =[wXBw+  0Zw/  XBp  3B   +    ,<   , R,<w},<w,< D& E,<w},< E$ 9+    ,<   ,<   ,<   ,<   ,<   Z U,<   ,<   Zw-,   +  K+  aZ  XBw~[w~[  [  Z  [  ,<   ,<   ,<   Zw-,   +  R+  \Z  XBp  ,<wx[w[  D F[  Z  XBw}3B   +  ZZp  2B   +  YZ   XBw+  \[wXBw+  PZw/  2B   +  ^+  _Z   +  a[wXBw+  IZp  /  3B   +  z[w[  Z  XBw},<   ,< F$ )2B   +  j[wZ   XD  ,<w}" GB FXBw},<   ,<w$ GZw|3B   +  w,<w}Z   D H,<w}Z nD H,<w}Z pD H,<w}Z qD H,<   ,<w}Z sD H,   +  z,<w}Z uD H[  Z  +  zZ   ,<   ,<   ,<   Zw-,   +  ~+  Z  XBp  Zp  Z G7   [  Z  Z  1H  +  2D   +   2B   +  	,<wy,< p[wF I3B   +  	Zp  XBw}+  [wXBw+  |Zw/  +  /  +  LZ ;,<   ,<   ,<   Zw-,   +  +  (Z  XBp  Zp  Z z7   [  Z  Z  1H  +  2D   +  2B   +  &Zp  Z 7   [  Z  Z  1H  +  2D   +  3B   +  +  &,<wy,< p,<w" IXBw{F I3B   +  &Zp  XBw},<   , RZ   XBw}+  )[wXBw+  Zw/  +  */  +  L,<w{Z CZ (7   [  Z  Z  1H  +  02D   +  ,[  [  D h,<   ,<   ,<   Zw-,   +  5+  IZ  XBp  Zp  Z ,   2B   +  GZp  Z 7   [  Z  Z  1H  +  =2D   +  :2B   +  GZp  Z 7   [  Z  Z  1H  +  C2D   +  @3B   +  E+  G,<p  , RZ   XBw}+  J[wXBw+  3Zw/  +  K/  +  LZ   +  z,<w,< J$ s-,   Z   Z  [  XBw}Zw~3B   +  U,< J,<   $ K,<w},<   ,<   & KZw},<   ,<w~,< L$ 9XBwZ  ,\  3B  +  [+  q,<w},< F$ )XBw~2B   +  h,< L,< M,<   @  ` +  fZ   Z XB Zw~,<?}" GB FZw~XB?}Z   ,~   2B   +  h+  KZ ?2B   +  l,< M,<   ,   Z   ,   XB k,<wZw~Zw,   ,   Z h,   XB o+  G,<w{,<wzZw|2B   +  tZw~D N    ,\   7   [  Z  Z  1H  +  y2D   +  v[  Z  /  +    -.    N,<`  Z TD gZ   ,~       ZwZ 3B  +  ZwZ   1B  +  *  -,   +  *  ,   2B   7       2B   +  Zp  Z ~,   2B   +  Z "3B   +  ,<p  ,<   , O3B   +  Zp  Z 	,   XB +    Z   +    Z +2B   +  Z   +  Zp  -,   +  Z   +    Z   XB ,< P" QXB -Zp  2B   +  Z   XB 1Z   ,<   ,<   Zw-,   +  $Zp  Z   2B   +  " "  +  $[  QD   "  +  ?Zw,<   Zp  ,<   Zw,<   ,<w}$ F[  Z  2B   +  /Zw2B Q+  -Z   +  /[wZ  ,<   ZwD R,<   [w[  -,   +  :Zw,<   ,<w}$ F[  [  2B   +  ;[w[  ,<   Zw~,<   ,<   & R+  ;[w[  ,   ,   /   Zp  ,   XBp  [wXBw+  /  XB ,< RD FXB 5,< +Z @D FXB 0Z   +        Zp  Z G,   2B   +  _[ Z  Z  2B   +  N[ H[  2B   +  NZw3B   +  _+  ],<w,<   ,<   Zw-,   +  R+  [Z  XBp  Z J,<  ,< b,<   ,  3B   +  YZp  2B   +  XZ   XBw+  [[wXBw+  PZw/  3B   +  _Zp  Z F,   XB ]+    Z   +    Z ,<   @ S  +  4Z l,<   ,< T,< U,<   @  ` +  -Z   Z XB ,< U,<   " U,   ,   Z c,   XB k,< =  =,   ,   Z l,   XB n,< V,<   " V,   ,   Z o,   XB rZ   ,<  @ E   +  +,<   Zw~Z?3B V+  {3B A+  {2B W+  |Z   +    Zw~,<?" WXBp  Z   2B   +  ,<p  ,<   $ Zp  2B U+  	[p  Z  ,<   , 2[p  [  XBp  Zw~,<?,<   ,< X,< X( YZp  2B Y+  [p  2B   +  ,<   , +Z  +    ,<   , Zp  2B Z+  [p  ,<   ,<   ,< m, 5,<   Zp  -,   +  +  Zp  ,<   ,<p  ,<   ,<   , L/   [p  XBp  +  /   Z Z+    2B [+  /[p  XBp  ,<   ,<   ,<   , a,<p  ,<   ,< m, 5XBp  Z  2B  +  ',< [,<   $ q,<   " r  ),<p  Zp  -,   +  )+  -Zp  ,<   ,<   ,<   , L[p  XBp  +  '/   Z Z+    3B \+  12B \+  Zp  ,<   [w[  [  ,<   [wZ  ,<   [w~[  Z  ,<   @ ] 8+  Z` 2B   +  S,<` ,<   ,<   , a,<` ,<   ,<   , 5,<   Zp  -,   +  A+    Zp  ,<   ,<p  ,<   $ ,< b,<   $ q,< c,<   ,<   @  ` +  OZ   Z XB ,< cZwzZ8  Z   ,   D c,<   ,<   $ Z   ,~   2B   +  Q,< d,<   $ /   [p  XBp  +  ?[` [  XB` [  Z  XB` [` [  XB   Z` 2B {+  d,<` ,< d$ qZ   ,   Z   ,   ,<   ,<` ,<` Z WXB` ,\   XB ^,   Z z,   ,   Z   ,   XB` [` ,<   , XB   ,<` ,< `,<   ,  XB` Z m,<  Zp  -,   +  k+  {Zp  ,<   Zp  Z ,   3B   +  w,<p  Z e,<   Z `,<  Z   ,<  ,<   Z K,<  , NZp  Z   ,   XB u+  y,<p  ,<   ,<   , L/   [p  XBp  +  i/   Z` 3B   +  Z m,<  Z eD e, ,< v,<` ,<` & f,<   ,<   ,<   , 5,<   Zp  -,   +  +    Zp  ,<   Zp  Z v,   2B   +  ,<p  Z o,<   Z p,<  Z q,<  ,<   Z s,<  , N/   [p  XBp  +  Z Z+    2B f+  ,< v[w[  Z  ,<   [wZ  F fXBp  ,<   ,<   ,<   , aZw~Z8  2B   +  ,< g,< g$ 0,<p  , +    2B }+  z[p  ,<   ,<   ,<   ,<   Zw~XBwZw-,   +  %+  .ZwZ  2B |+  (Z   XBp  +  ,2B |+  ,Zp  2B   +  +7   Z   +  @[wXBw+  #Zp  3B   +  0Z   +  @,<w~Z   ,   Z   ,   ,<   Z ^Z m,   Z   ,   ,<   Z   ,   Z   ,   ,   Z   ,   ,   Z z,   ,   Z   ,   Z |,   [w},   ,\  QB  Z   /  ,<   @ g  +  yZw{[8  ,<   ,<   , yXB` Z h,<  Zp  -,   +  I+  MZp  ,<   ,<   ,<   , L[p  XBp  +  G/   Z` 3B   +  P, u, ,< UZw{[8  D F[  XB` 3B   +  U,<   , 2,< =Zw{[8  D F[  XB` 3B   +  \,< =B =,   ,   Z s,   XB [Z`  3B   +  a,< |Zw{[8  D F[  +  c,< |Zw{[8  D F[  ,<   Z`  3B   +  h,< |Zwz[8  D F[  +  k,< |Zwz[8  D F[  ,<   ,<`  ,< iZwy[8  D F[  ,<   ,< jZwy[8  D F[  ,<   ,< jZwx[8  D F[  ,<   ,< kZwx[8  D F[  N kXB   Z   ,~   +    2B Y+  [p  ,<   ,<   ,< m, 5,<   , +Z  +    2B l+  [p  ,<   ,<   ,<   , a,< g,< g$ 0[p  ,<   ,<   ,<   , 5,<   Zp  -,   +  
Z   +  Zp  ,<   ,<   , W[p  XBp  +  /   +    2B l+   [p  [  [  Z  ,<   ,<   ,<   , a[p  [  [  ,<   [w[  [  Z  ,<   ,<   ,<   , 53B   +  3B   +  -,   +  ,< l,<   ,   ,\  XB  ,<p  " x+    2B `+  *[p  ,<   ,<   ,<   , a[p  3B   +  ([p  ,<   ,< a,< m, 5+  )Z   B m+    ,< m" ]+    Zw~XB8 Z   ,~   3B   +  /Z   +  0Z XB` D nZ` 3B   +  3  ),~   Z` ,~   +        ,<wZw3B   +  8Z a+  9Z a,<   ,<w,  +        Z B3B   +  NZw3B p+  ?2B   +  A,<w,< g$ n+    3B o+  C2B   +  F,<w,<   ,<w, X+    2B o+  I,<w,<   ,<w, 5+    2B p+  M,<w,<   ,<w, +    Z   +    Z   +        ,<p  ,< b,<w~,  +        Zp  3B   +  U,<w" nZ   3B   +  u,<w,<   ,<   ,<   ,<   Zw~2B   +  [+  r-,   +  ^XBp  Z   XBw~+  `Zw~XBp  [w~XBw~,<p  ,< p$ s2B   +  e,<p  ,< q$ s2B   +  eZp  B B2B   +  rZp  Z   ,   3B   +  j+  rZp  XBwZw3B   +  p,<   Zw,   XBw~,\  QB  +  rZw,   XBwXBw~+  YZw~/  XBw3B   +    +  vZ   +    Z U2B q+  y,<w, -+    ,< r,<   $ q,< g,< g,<w~,<   ,<   ,<   , r,< s,<   $ q,<w,<   $ q,< s,<   $ q,<   " r,< t,<   $ q,<   " r,< W,<w~Z gD ^D t+    ,<p  ,<   ,<   , j2B   +  P,<p  " u3B   +  G,<p  Z 2Z ;7   [  Z  Z  1H  +  2D   +  [  [  D h,<   ,<wZ 2Z 7   [  Z  Z  1H  +  2D   +  [  [  D h,<   ,<wZ 3Z 7   [  Z  Z  1H  +  #2D   +  [  [  D h,<   ,<w~Z nZ 7   [  Z  Z  1H  +  *2D   +  '[  [  D hD hD hD h,<   ,<   Zw-,   +  5Zp  Z   2B   +  3 "  +  4[  QD   "  +  FZw,<   ,<w~,<wZ 2Z &7   [  Z  Z  1H  +  <2D   +  8[  Z  D h    ,\   ,   2B   +  @7   Z   /   3B   +  DZwZp  ,   XBp  [wXBw+  ./  +  N,<p  Z 2Z 77   [  Z  Z  1H  +  L2D   +  I[  [  D hXBp  3B   +  PB n+    Z   +        ,<   ,<   ,<   Zw~Z 97   [  Z  Z  1H  +  X2D   +  UXBp  3B   +  [Zp  +    Zw2B   +  ^,<w~" IXBw,<w~" u,<   ,<p  Z RZ H7   [  Z  Z  1H  +  e2D   +  a[  Z  D h/   [  XBp  3B   +  k,< v,<   ,< vH w+  lZw~B wXBwZw~Z 6,   2B   +  Zw2B   +  }Zw~,<   ,<   ,<   $ u,\  2B  +  }ZwZ 7@  7   Z  -,   +  y+  (,<w~,< xZ mF xXBp  3B   +  }XBw~+  SZw2B   +  ,<w~" DXBw2B   +  ,<w~,< y$ ,<w,<   $ uXBw~B IXBwZw,<   ,<w~,< J$ 9Z  [  ,\  2B  +  ZwZ 7@  7   Z  -,   +  Z 3,<   ,< (,< y,<w},   F '2B (+  Z   3B   +  Z   +  Z z,<   @ H   +  Zw~,<?" z,~   +    ),<w~,< R$ 9XBp  Z  [  2B {+  (,< {,<w~,< J$ sXBw~3B   +  %Zw~[  B w2B   +  %Zw~D |Zp  ,<   ,< |$ }Zw~Z T7   [  Z  Z  1H  +  -2D   +  )2B   +    Zw~Zw,   Z (,   XB /Z  +    ,<p  ,< U$ )3B   +  6,<p  " U+  ;,<p  " },< *,<w,   ,<   ,<   ,   Z \,   XB :Z   B =+    ,<   Z   B w2B   +  C,< ~,<   $ q,<   " rZ   +    XBp  B GB FXBp  ,< *,<   ,   ,<   ,<   ,   Z ;,   XB H,<p  ,<   ,< g,<w~" ~H Z   +      0  , O,~   -.    @    ,~   Z   ,<   Zw~,<8 Z8 2B \7   Z   ,<   ,<   , XB`  3B   +  `Z Q,<  ,<   Zw~,<8 Z ,<   Zw},<8 ,<8 ,   ,<   ,<   , 2+  g,< ,<   $ qZ X,<   ,<   $ q,< ,<   $ q,<   " rZ   ,~   Z   2B   +  i+  fZwZ8 2B \+  Z g,<  Zp  -,   +  n+  wZp  ,<   Zp  ,<   Z ,<   [w2B   +  sZw    ,\   XCp  QEp  ,\   /   [p  XBp  +  l/   Z Z k,   XB x,< cZ a,<  ,< 6,< ,< ,<   ,<   ,   ,<   ,< ,< ,< ,< ,< ZwzZ8 3B   +  Z 6ZwzZ8 ,   +  Z ,   ,<   ,<   ,   ,<   ,< Z y,<   ,< ,   ,   ,   ,<    "  ,   ,<   ,<   ,<   & Z   ,~   ,<p  ,<   ,<   , 5XB x,<   ,<   ,<   ,<   [w~[  XBp  Zp  2B v+  ![p  [  XBw~[p  Z  [  [  XBp  Z  2B _+  %[p  [  XBwZ  3B ~+  /+  %2B _+  %[p  [  XBwZ  3B ~+  /Zw~2B ~+  (Z +  *Z '3B   +  *7   Z   XBw~  U2B   +  -Zw~+    ,<w~" Z Z+    [w~,<   ,<w$ `[p  Z  ,<   [wZ  Z  2B   +  67   Z   D q[p  ,<   Z   ,   Z   ,   ,<   Z   ,   XBw~Z l,   ,   Z   ,   D `Z (,<   Zp  -,   +  B+  ZZp  ,<   ,<p  " ,< " qZw~Zp  XD  ,<w},<   ,<   , 5,<   ,<   Zw-,   +  PZp  Z   2B   +  N "  +  O[  QD   "  +  WZw,<   ,<p  ,<w|, O/   3B   +  VZwZp  ,   XBp  [wXBw+  I/  B /   [p  XBp  +  @/   Z Z+    @ 	  (
+  1Zw~,<?, 	Z   3B   +  mZ   3B   +  mZw~[?[  Z  XB` Z  3B +  mZ` Z   2B  +  j[` Z  3B +  mZw~Z?Z ,   2B   +  q@   +  qZw~,<?,<?,<?& ,~   Zw~Z8  2B   +  Z ~3B   +  {-,   +  ~    /"   ,   XB v,   0b   +  ~Z sXB w3B   +  ~Zw~,<?,<   $ XB` +  Z y2B !+  ,< !,<   $ qZw~,<?,< ,<   ,<?,<   ,<8  , XB` Z   ,<  Zp  -,   +  	+  Zp  ,<   ,<p  Zw},<?,<?,<`  "  ,   XB` /   [p  XBp  +  /   Z   ,<   Z Z` 7   [  Z  Z  1H  +  2D   +  [      ,\   ,   XB` Z ~2B   +  +  .2B !+  Z` 3B   +  .,< f,<   $ q+  .Z` 2B   +  (Z` 2B   +  &Zw~Z8  3B   +  (Z 	2B   +  (Zw~,<?,<   $ XB` Z` 3B   +  +,< ,<   $ qZ` 3B   +  .,< ,<   $ qZw~,<?,<` $ ?Z   ,~   +    ,<w~,<w~,<w~, \,<w~Z 2Z `7   [  Z  Z  1H  +  92D   +  6[  Z  D h,<   ,<w~Z 2Z 57   [  Z  Z  1H  +  A2D   +  =[  Z  D h,<   ,<w}Z 3Z <7   [  Z  Z  1H  +  H2D   +  E[  Z  D h,<   ,<w}Z nZ D7   [  Z  Z  1H  +  P2D   +  L[  Z  D h,<   ,<w|Z cZ K7   [  Z  Z  1H  +  W2D   +  T[  Z  D hD hD hD hD h,<   ,<   ,<   Zw-,   +  ^+  Z  XBp  ,<   Z nZ S7   [  Z  Z  1H  +  e2D   +  a[  Z  D n2B   +  ,<p  Z oZ `7   [  Z  Z  1H  +  m2D   +  i[  Z  D n2B   +  ,<p  Z oZ h7   [  Z  Z  1H  +  u2D   +  q[  Z  D n3B   +  x+  ,<   ,<w,< g,<   ,<   , XBp  3B   +  Zw~3B   +  ,<w,<w,<w|,<   , 2+  ,<w,<   Z }F /   [wXBw+  \Zw+    ,<   Z 3B   +  Zw-,   +  [w2B   +  Zw2B   +  Zw3B p+  3B m+  2B   +  Z   +  Z   +  Z   ,<   Zw~2B   +  Z z,<   ,<   ,<   Zw2B   +  +  Q-,   +  XBp  Z   XBw+  ZwXBp  [wXBwZw~3B   +  $,<p  Z D b2B   +  $,<p  ,< C,<   , c2B   +  &,<p  , RZ  XBp  ,<w},<   ,<   Zw2B   +  *+  P-,   +  -XBp  Z   XBw+  /ZwXBp  [wXBwZp  3B p+  23B m+  22B   +  3Z p+  3XBp  Zw|3B   +  LZw~Zw|,   2B   +  O,<w|,<   ,<   Zw2B   +  ;+  G-,   +  >XBp  Z   XBw+  @ZwXBp  [wXBw,<p  ,<w~,<w|" IF I3B   +  GZp  2B   +  FZ   XBw+  G+  9Zw/  3B   +  OZw~Zw|,   XBw|+  O,<w~,<w$ ?,<   ,<w|$ hXBw|+  (Zw/  +  Zw/  Z 3B   +  Zp  2B   +  ,<w,<   ,<   Zw2B   +  Y+  d-,   +  \XBp  Z   XBw+  ^ZwXBp  [wXBwZp  3B p+  a3B m+  a2B   +  d2B   +  cZ   XBw+  d+  WZw/  3B   +  Zw~3B   +  ,<   ,<   ,<   Zw2B   +  k+  
-,   +  nXBp  Z   XBw+  pZwXBp  [wXBwZw~3B   +  ,<   ,<   ,<   Zw2B   +  u+  -,   +  xXBp  Z   XBw+  zZwXBp  [wXBw,<p  ,< C,<w},<   , 2B   +  ~+  Zw~Zw},   3B   +  Zw}+  Zw~Zw},   XBw}+  sZw/  +  
,<p  ,< C,<   , c,<   ,<w~$ hXBw~+  iZw/  +  Zw3B   +  ,<   ,<   ,<   Zw2B   +  +  -,   +  XBp  Z   XBw+  ZwXBp  [wXBw,<p  ,< C,<   , c,<   ,<w~$ hXBw~+  Zw/  Zp  +        ,<   , Zp  2B +   Zp  +    ,<p  ,<   ,<   , >,<   ,<   Zw-,   +  *Zp  Z   2B   +  ( "  +  )[  QD   "  +  <Zw,<   Zp  -,   +  3Zp  Z p7   [  Z  Z  1H  +  12D   +  .[  [  +  8Zp  Z -7   [  Z  Z  1H  +  82D   +  4[  /   Zp  ,   XBp  [wXBw+  #/  Z ,   +    Zp  3B   +  TZp  2B w+  BZ +  K2B v+  H[p  Z  2B d+  G[p  XBp  Z +  KZ +  K2B u+  JZ h+  K,<p  ,< f$ ,<   ,<w~,<w~,<   , >,<   [wZ  ,<   [w~[  ,<   ,<   , >,<    "  ,   +    Zw-,   +  YZw,<   [w~,<   ,<   , >+    Zw-,   +  kZw3B +  _3B +  _3B +  _2B l+  b,<w[w,<   ,<   , >+    3B v+  e3B u+  e2B w+  h,<w,<   ,<w~, >+    ,<wZw,<   [w~,<   , >+    ,<wD 2B   +    ZwZ   ,       Z d7   [  Z  Z  1H  +  t2D   +  p[  ,<   ZwZ n,       Z 7   [  Z  Z  1H  +  {2D   +  x[  2B   +  ZwZ u,       Z 7   [  Z  Z  1H  +  2D   +   [  2B   +  ZwZ },       Z l7   [  Z  Z  1H  +  2D   +  [  2B   +  ,<w,< f$ Z  D 2B   +    ,<w,< f$ +           H3B +  2B +  +  ,< " ,<   , Z   XB ,<   ,<   ,<   ,<   ,<     HXBw2B   +  Zp  +  A2B Q+  &,<     HXBw~2B   +  #Zp  +  %@ H,<   ,<   , j+   /   +  @ZwZ 37   [  Z  Z  1H  +  +2D   +  (XBw~3B   +  :,<     HXBw~2B   +  0Zp  +  9,<   ,<   Z F   H-,   3B   7    ,   XBw~,<w~,<w}F ,<w~,<   Z 1F +  -/   +  @,< ,<   ,<   & K,<     H2B   +  ?Zp  +  @+  =/   +  /   Z   +        ,<wZw-,   +  L2B x+  GZ +  V3B   +  J3B   +  J2B +  J+  V,<   ,< $ +  VZw2B +  OZw+  V2B q+  Q[w+  VZw2B   +  T[w3B   +  UZw+  UZ   Z n,   ,<   ,<   , jB ,<   ,<   Zw-,   +  [+  cZw2B +  ^Zw+  c2B n+  b[w2B   +  cZ   ,   +  cZ qZw,   XBp  Zw3B   +  iZ `3B   +  i,< Y,<w~,<w~,   B Zp  +    ZwZ ,,   2B   +  nZwZ   ,   ,<   Zp  2B   +  qZ   XBp  ZwZp  ,   2B   +  Zw3B   +  Zw2B   +  Z   3B   +  |,<w~,< Zw3B   +  {7   Z   F Z '3B   +  ,<w~,< ,<   , c,<   ,< p,<   , ;,<w~Zw~-,   +  2B +  +  2B   +  Zw~Z m,   3B   +  
Z   +  Z   +  ,<   ,< $ +  ,<   Z kF Zp  +         Zw2B +  Zw+  ,<w, [  ,<   Zp  -,   +  Z   +  )Zp  ,<   ,<w/   Zw~3B   +  !,<w~,<w}Zw~3B   +  [w+  ZwD h    ,\   ,   +  %,<w}Zw~3B   +  $[w+  $ZwD n/   3B   +  'Zp  +  )[p  XBp  +  /   3B   +  +Z   +    Z   +        Zp  2B   +  0Z B %XBp  ,<   ,<   ,<   Zw-,   +  3+  mZ  XBp  2B   +  6+  k,<   ,< p$ s2B   +  ;,<p  ,< q$ s2B   +  ;Zp  B B2B   +  iZp  ."   Z  3B   +  B,<p  ,<   $ B,<p  " Z   2B +  H@   +  GZw~,<8  ,< p$ ,~   +  Z2B +  Z,<p  ,< pZ F ,<   ,<   ,<   Zw-,   +  N+  YZ  XBp  Zp  Z   ,   2B   +  X,<p  ,< R$ s[  3B   +  U+  X,< ZwZ P,   D t[wXBw+  LZw/  ,< ,<w,   ,<   ,<   ,<   & ,<p  ,<w,<   ,<   ,<   , 2B   +  h,< ,<   $ q,<w,<   ,<   & ,< q,<   ,<   & /   +  iD ,< W,<wZ .D D t[wXBw+  1Zw/  Zp  3B   +  tZ B2B +  t,< ,<   $ q,<   " r+    Z   +         ,<   , Z 8,<   Z [D eZ   ,~       Zw3B   +  ;,<p  Z nZ |7   [  Z  Z  1H  +  2D   +  }[  Z  D n2B   +  ;,<p  Z oZ |7   [  Z  Z  1H  +  	2D   +  [  Z  D n2B   +  ;,<p  Z oZ 7   [  Z  Z  1H  +  2D   +  [  Z  D n2B   +  ;,<p  Z cZ 7   [  Z  Z  1H  +  2D   +  [  [  D n2B   +  ;,<p  Z nZ 7   [  Z  Z  1H  +  !2D   +  [  [  D n2B   +  ;,<p  Z 3Z 7   [  Z  Z  1H  +  )2D   +  %[  [  D n2B   +  ;,<p  Z 2Z $7   [  Z  Z  1H  +  12D   +  -[  [  D n2B   +  ;,<p  Z 2Z ,7   [  Z  Z  1H  +  92D   +  5[  [  D n3B   +  I,<p  ,<   ,<   ,<   , XBw3B   +  B,<p  ,<   ,<   ,<   , 2+    ,<p  ,<   $ q,<  ,<   $ q,<   " rZp  ,   ,<   , ++    ,<p  ,<   Z vF +        ,<   Zw~3B   +  O-,   +  PZ   +    ,<   , Zw2B   +  mZw~Z J,   2B   +  m,<w~Z nZ 47   [  Z  Z  1H  +  Z2D   +  W[  Z  D n2B   +  O,<w~Z oZ V7   [  Z  Z  1H  +  b2D   +  _[  Z  D n2B   +  O,<w~Z oZ ^7   [  Z  Z  1H  +  j2D   +  g[  Z  D n3B   +  m+  O,<w~,<w,<   ,<   , XBp  2B   +  Zw2B +  u,<w~,<  ,<   & +  }3B   +  w2B +  },< !,<   $ q,<w~,<   $ ,< !,<   $ q,<   " r,<w~Z nZ f7   [  Z  Z  1H  +  2D   +  [  Z  D n2B   +  ,<w~Z oZ ~7   [  Z  Z  1H  +  
2D   +  [  Z  D n2B   +  ,<w~Z oZ 7   [  Z  Z  1H  +  2D   +  [  Z  D n3B   +  Zw~,   ,<   , ++  O,<w~,<   Z SF +  O,<w~,<   ,<   ,<   , 2+  OZp  Z ",   3B   +  %[p  Z  ,<   , ,<   [w[  ,<   , D h+    Zp  ,<   [wD "2B   +    ,< #,<   $ qZp  ,<   ,<   $ q,< ,<   $ [p  2B   +  /Z #,<   ,<   $ q,< $,<   $ q,<   " r  )+       | hh J3,ffY[V2#6< ")ED P0
I#l}@!A $A@HR6`GBl@RPT
*Cp
I(#ZXPTx
0J&
[

G@Q E(H
QE"X    tXB`!0@ Bf;b!	`p      7 	DwZB32S-
+12jU)UU ZL1($B( LQB!"0K|SAp`HO ]DL7fHC-H "pE @(@("@! PF S"R)ek!1$$P kcHN)Tyf @R-+(D&H
RJ )jBA]yH@R)
"2H@$ )
D2$ )DA @F )DOP@MH
" aIpo* (~ $00E$o 1AD$cF!'e )PeU$")l  !#$ Pb$I
H U)%@
@VU	P) T4I+ Q(AL `" B% CQ E!" (L*$D &U `P?%DeK0E0&c	/ $D lU l 	 ` O Fp!, fr$P ! ( a#d,G KeHI$I!Fl<"& 
X	=0Ld["bDBHjC FWk*P)H
H
<"B
$` H7AH%)2CN-%XvJL@[ 5  BA t5aBDaxc  |$(a`!
H*I%.H ` D y2""4@PH
H
$
T%$D	%u!Q*T"8BDID)	"TDAQD	0PJH)@XE@) P
sv_p?	H R)43~ KRf@RJ6UPW]:%#nL	D	I(t9P !(E%$@c5*	.MjN hef!u0(
T%@RPT
*J@%BD QP(
*K	5^M(TJaRB(iM0                                                                      (MASTERSCOPEBLOCK#0 . 1)
(VARIABLE-VALUE-CELL MSBLIP . 3909)
(VARIABLE-VALUE-CELL NEEDUPDATE . 4236)
(VARIABLE-VALUE-CELL FILELST . 6548)
(VARIABLE-VALUE-CELL MSDATABASELST . 6940)
(VARIABLE-VALUE-CELL MSRECORDTRANFLG . 1450)
(VARIABLE-VALUE-CELL COMPILE.TIME.CONSTANTS . 1460)
(VARIABLE-VALUE-CELL NODUMPRELATIONS . 1616)
(VARIABLE-VALUE-CELL DUMPEDFLG . 1682)
(VARIABLE-VALUE-CELL DUMPTABLE . 1680)
(VARIABLE-VALUE-CELL MASTERSCOPEDATE . 1967)
(VARIABLE-VALUE-CELL LISPXHISTORY . 1985)
(VARIABLE-VALUE-CELL CLISPCHARRAY . 2033)
(VARIABLE-VALUE-CELL LISPXHIST . 6347)
(VARIABLE-VALUE-CELL LISPXVALUE . 2095)
(VARIABLE-VALUE-CELL MSDBEMPTY . 6193)
(VARIABLE-VALUE-CELL DWIMWAIT . 4893)
(VARIABLE-VALUE-CELL MSOPENFILES . 3552)
(VARIABLE-VALUE-CELL BOLDFONT . 2272)
(VARIABLE-VALUE-CELL DEFAULTFONT . 2280)
(VARIABLE-VALUE-CELL GLOBALVARS . 2751)
(VARIABLE-VALUE-CELL DESCRIBELST . 2815)
(VARIABLE-VALUE-CELL MSCHANGEDARRAY . 6961)
(VARIABLE-VALUE-CELL MSFILETABLE . 3715)
(VARIABLE-VALUE-CELL MSARGTABLE . 3719)
(VARIABLE-VALUE-CELL FILERDTBL . 3311)
(VARIABLE-VALUE-CELL MSFILELST . 4961)
(VARIABLE-VALUE-CELL RESETVARSLST . 5010)
(VARIABLE-VALUE-CELL BADMARKS . 3588)
(VARIABLE-VALUE-CELL PREVVALUE . 3617)
(VARIABLE-VALUE-CELL OTHERSET . 3750)
(VARIABLE-VALUE-CELL MSDATABASEINIT . 3641)
(VARIABLE-VALUE-CELL USERTEMPLATES . 6427)
(VARIABLE-VALUE-CELL V . 3773)
(VARIABLE-VALUE-CELL EDITQUIETFLG . 3816)
(VARIABLE-VALUE-CELL MSPRINTFLG . 5426)
(VARIABLE-VALUE-CELL MSTHOSE . 5246)
(VARIABLE-VALUE-CELL CHECKUNSAVEFLG . 4589)
(VARIABLE-VALUE-CELL MSNEEDUNSAVE . 6612)
(VARIABLE-VALUE-CELL MSHASHFILENAME . 5797)
(VARIABLE-VALUE-CELL LOADDBFLG . 4905)
(VARIABLE-VALUE-CELL FILELINELENGTH . 4983)
(VARIABLE-VALUE-CELL MSHELPFILE . 4987)
(VARIABLE-VALUE-CELL DWIMIFYCOMPFLG . 5310)
(VARIABLE-VALUE-CELL CLISPIFYPRETTYFLG . 5313)
(VARIABLE-VALUE-CELL COMMENTFLG . 5325)
(VARIABLE-VALUE-CELL MSPRINTCNT . 5364)
(VARIABLE-VALUE-CELL ANALYZEUSERFNS . 5388)
(VARIABLE-VALUE-CELL MSERRORFN . 5409)
(VARIABLE-VALUE-CELL ANYFOUND . 5449)
(VARIABLE-VALUE-CELL MSWORDS . 6155)
(VARIABLE-VALUE-CELL MSTEMPLATES . 6414)
(VARIABLE-VALUE-CELL FILEPKGFLG . 6382)
(VARIABLE-VALUE-CELL RECOMPILEDEFAULT . 6623)
(VARIABLE-VALUE-CELL NOTCOMPILEDFILES . 6573)
CHANGERECORD
DUMPDATABASE
DUMPDATABASE1
GETRELATION
GETTEMPLATE
MAPRELATION
MASTERSCOPE
MASTERSCOPEXEC
MSCLOSEFILES
MSHASHLIST1
MSINTERPA
MSMARKCHANGED
MSMEMBSET
MSLISTSET
MSNEEDUNSAVE
MSNOTICEFILE
MSSHOWUSE
PARSERELATION
READATABASE
SETTEMPLATE
TESTRELATION
UNSAVEFNS
UPDATECHANGED
UPDATECHANGED1
UPDATEFN
MSLISTSET
MSDESCRIBE
SHOULDNT
IS
NCONC
ANY
INRELATION
RPLACD
CHECK
LIST
HARD
MEMB
8
APPLY
9
NOT
10
(0 . 1)
(0 . 1)
(VARIABLE-VALUE-CELL OTHERSET . 0)
(NIL VARIABLE-VALUE-CELL V . 0)
NIL
MAPTABLE
GETTABLE
UNION
(0 . 1)
(VARIABLE-VALUE-CELL OTHERSET . 0)
(0 . 1)
11
GETHASH
(NIL VARIABLE-VALUE-CELL V . 0)
12
QUOTE
FILES
KNOWN
CALL
TESTTABLE
NOBIND
REF
GETD
FNS
RPLACA
PRIN1
" => ON "
TERPRI
CLISPWORD
GETP
"Warning: "
"is a CLISP word and is not treated like a function!"
13
OR
14
AND
15
ANDNOT
IN
EVAL
BLOCKS
FIELDS
RECORDFIELDNAMES
THAT
SOMEHOW
ED
FROM
TO
TOPFLG
PATHS
CONTAIN
WHICH
16
MSONPATH
17
DEFINED
((CALL DIRECTLY) . 0)
((i.s.oprs as functions) . 0)
CHANGED
DELETED
((USE I.S.OPRS) . 0)
U-CASEP
L-CASE
((USE I.S.OPRS) . 0)
i.s.oprs
((CALL DIRECTLY) . 0)
DESCRIPTION
FILEPKGTYPE
MACRO
((USE RECORDS) . 0)
((USE FIELDS) . 0)
records
((USE FREELY) . 0)
"constants"
(NIL VARIABLE-VALUE-CELL NEEDUPDATE . 0)
((FROM TO AVOIDING NOTRACE MARKING SEPARATE) . 0)
(NIL VARIABLE-VALUE-CELL DUMPEDFLG . 0)
((READATABASE) . 0)
PRINT
%(
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL DUMPTABLE . 0)
%)
PRIN2
1
SPACES
% 
TABLES
"CAN'T BE INVERTED"
ERROR
MSVBTABLES
3
*MAPRELATION*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL MAPFN . 1911)
NARGS
(VARIABLE-VALUE-CELL MAPZ . 0)
(VARIABLE-VALUE-CELL MAPW . 1920)
(VARIABLE-VALUE-CELL MAPFN2 . 1930)
MASTERSCOPEBLOCKA0006
MASTERSCOPE1
"Masterscope "
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
"_. "
PROMPTCHAR
LISPXREAD
E
_
LISPX
OK
STOP
RETFROM
STRPOSL
ARGTYPE
BYE
ok
stop
%.
"No functions have been analyzed!"
UPDATEFILES
FILEPKGCHANGES
ON
'
((OR) . 0)
APPEND
((Y) . 0)
((ANALYZE THE FNS) . 0)
"want to ."
(((Y "es
") (N "o
")) . 0)
ASKUSER
Y
"Sorry, no functions were found to analyze!"
ERROR!
OPENP
CLOSEF
*MSDESCRIBE*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL FN . 2796)
ARGS
SMARTARGLIST
"("
CHANGEFONT
" "
")"
" (not analyzed)"
HARRAYP
45
TAB
" {line "
ABS
"}"
NLAMBDA
PREDICATE
EFFECT
"calls:    "
"called by:"
TEST
SMASH
SET
BIND
"binds:    "
TESTFREE
SMASHFREE
SETFREE
REFFREE
GLOBALVAR
GETPROP
"uses free:"
"globals:  "
REPLACE
FETCH
"fields:   "
2
LINELENGTH
POSITION
NCHARS
,
MSSTOREDATA
FILECOMSLST
BLKFNS
BLOCK
*
ENTRIES
VIRGINFN
EXPRP
EDITLOADFNS?
CONTAINS
FINDFILE
PROP
LOADFNS
EXPR
ASSOC
INPUT
INFILE
SETFILEPTR
RATOM
READ
INFILECOMS?
FILECOMS
FILEDATES
"reading from "
LISPXPRIN1
LISPXPRINT
FILEMAP
((DUMMY) . 0)
NOBREAK
((MSCLOSEFILES) . 0)
LOADEFS
*MSHASHLIST*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL PREVVALUE . 0)
((UNBOXED-NUM . 3) VARIABLE-VALUE-CELL OTHERSET . 0)
((UNBOXED-NUM . 4) VARIABLE-VALUE-CELL BADMARKS . 0)
20
HASHARRAY
USERTEMPLATES
MAKETABLE
FILE
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
OUTPUT
SETREADTABLE
;
-
MSPARSE
". "
"
"
MAPRINT
ERASE
REANALYZE
done
ANALYZE
"Sorry, can't figure out which functions you mean."
EDIT
SHOW
(VARIABLE-VALUE-CELL EDIT . 4120)
(VARIABLE-VALUE-CELL EDITCOMS . 4123)
(0 . 1)
(0 . 1)
(NIL VARIABLE-VALUE-CELL DONE . 4111)
(NIL VARIABLE-VALUE-CELL NEEDUPDATE . 0)
NIL
(NIL VARIABLE-VALUE-CELL TYPE . 4116)
NIL
(NIL VARIABLE-VALUE-CELL SHOWSET . 4118)
NIL
" :
"
((DUMMY) . 0)
EDITF
failed
S
MASTERSCOPEBLOCKA0007
MAPHASH
MSJOINSET
?
0
(0 . 1)
(NIL VARIABLE-VALUE-CELL NEEDUPDATE . 0)
NIL
NIL
AVOIDING
SEPARATE
NOTRACE
MARKING
MSPATHS
DESCRIBE
FOR
MSCHECKBLOCKS
18
RESETRESTORE
MSMARKCHANGE1
VARS
MACROS
I.S.OPRS
BROKEN
ADVISED
!
"The functions "
PRINTPARA
" use "
" which have changed."
"Call UNSAVEFNS() to load and/or UNSAVEDEF them."
/SETATOMVAL
NLAMBDAFNP
NAMEFIELD
VERSION
BODY
PACKFILENAME
INFILEP
70
FIXSPELL
"not found"
"should I LOADFROM"
NO
LOADFROM
Compiled
(((DECLARE: -- DONTCOPY --)) . 0)
LOADVARS
COMPILED
/RPLACD
OUTFILE
"Sorry, HELP file not available!"
GETEOFPTR
COPYBYTES
*MSSHOWUSE*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL SHOWFN . 5109)
NIL
(NIL VARIABLE-VALUE-CELL ANYFOUND . 0)
MASTERSCOPEBLOCKA0008
"Can't find a definition for "
"!"
==
*ANY*
((E (SETQ #1) T) . 0)
F
LPQ
IF
((NEQ (##) #1) . 0)
((ORR (P) NIL) . 0)
((S #1) . 0)
TTY:
N
" -- "
(NIL VARIABLE-VALUE-CELL VARS . 0)
NIL
NIL
NIL
NIL
CLISP:
DECLARATIONS:
((LAMBDA NLAMBDA) . 0)
(NIL VARIABLE-VALUE-CELL VARS . 0)
MSPRGDWIM
ARG
ALLCALLS
ERRORS
" (CALLS ppe)"
", "
PUTHASH
LDIFFERENCE
INTERSECTION
A
AS
AN
V
%[
((BAD DATABASE) . 0)
HELP
STORETABLE
((*** incompatible MASTERSCOPE data base) . 0)
((CALL .. EVAL) . 0)
"Invalid template"
COPY
UNDOSAVE
TEMPLATES
MARKASCHANGED
((CALL DIRECTLY) . 0)
"Invalid template"
SAVEDEF
CHANGES
(NIL VARIABLE-VALUE-CELL MSDATABASELST . 0)
EXPRS
WHEREIS
NOTCOMPILEDFILES
loading
"Can't find a definition for "
/PUTD
REMOVE
"WARNING:  you must set RECOMPILEDEFAULT to EXPRS in order to have these functions recompiled automatically"
" disappeared!"
"can't be analyzed "
"Sorry, the function "
" can't be analyzed!"
((OR AND ANDNOT) . 0)
MSVBNOTICED
"can't SHOW or EDIT where things "
""
"!"
(EQUAL URET7 ALIST4 SKNNM LIST2 SKNLA IUNBOX SMALLT GETHSH MKN SKI LIST3 ASZ KNOB CF BINDB URET4 SKLA URET5 URET2 URET1 ALIST2 
ALIST3 COLLCT CONS FMEMB SKLST URET3 EVCC KT URET6 CONSS1 CONSNL CONS21 BHC LIST4 SKNLST KNIL BLKENT ENTER1)  8  `h  AP  H  HH8p:7hk   OC@  O38  H  *Hpl p~po}h	   xh  N`2   ?p.@  D    .xw   Im b {p  : |V w8  *-@0CsP25h[C p`x   d: } ~Po   \F . l8  )@I(0RXal b ,2E zXT wO hp  6H(4XuH>tN88=* Q@* zp hAuxqh|hX73 o0E   [n(nm0w JH  AH J   w(V(H> rh7 4X   dp@K@`z9;60H?XvyHtn lkp^o]H=
h,`  Ph J@R IxH Gh9 Ex* -X  3pQ fxMHo'xiGa(W 
@xv<`
a%@  [8I Z   4{0VuH	/Ypu>
*x N q ^ $@X   n}@h|0ZzP2! zpuxNXJhB8 a@y \ a [W X8B V`5 V@& TX2   TQ` 	0  6026-58)/P|/(y.Po(hE(@B'X{8rxgXe8` ^XA8
 |XpXIH< %s }l8Fb`zUh+U PPOXuL `I 6EH*B(B ?hf<Pc<V90B8.8A!0 X 0  ~X{8-8hP, } QypNxPCw`&tXr(pnjkEg`xfZXUZ8GT`_K ;>x25P
-`	PlPC Pp |xg |0b |\ {(Y zxR o / b( `P^ YhH X> W(3 Ux* TH" RX NHS Ip (@C (? &@3 &/ P[ p( @ =   |HX@D S Qh	 >hE 8@C 7( /8z .hq *hK )E ' l e 8I  4 0   ^ P W 
P R 	P K x E 0 ? X ;  7 H  G`<0c|<g@o HA H@ GX: F1 Eh+ ; Y :hV   2hH 5G@9n89 2{Hsmpk&`
3 z  RPK I ` p -   Ww`?GX:h=@:68d|(]8 Pxv JXM IHK Gx0 Bx <[  0 h ,   n[ &B:h=wq@l`SjI`@Qp[KXJ8x>hg(pB@	`A | Ruhs\h=_8KY(*UQHbKX?C @0l;U:958#3x-8
i'U`J w7 vP nxu gP; ch
 ^PT Z8Q QX Bh B8v 7 9 6H( 40 .V %X# 0_ H `, @
   z   +   	;h    N0@[P%r vmHZgH+c^QKHm1h0@		$ Xkx)rPQcxVHOXQI(1=pa9XH8 42p+X
%	 x(/ t  m W fP% c| ]xK A`* 3 P>  x |  " H  5h(3x3@2P1P
0P.hq. m-(e,(]+(U*(Q* N)PJ(?'`='89&81%8)$8!#8"8!8	 8vPo aPRPLx=08X2.H*h#Pp ~H{w@qPg` X
`T
(H(>X8H/`-8"@0  P PP{~@m|pb{Ry`?w 1tp&t@"t r8qxqXp~o un@sn nm0jmhlhbl[kWjpUj@IhXDg`;g 9g 5f(,e(e $d8!cpc bhb0b a0`p~_H{_w^Po]Pg\P][HWZ HX9V-U &TH"TS(P@{N8mJ@MIHJI>G8:G7FX+EBXBHA>(h<p_;W:XM9 C7x>7 45`-4P"2H/p|.o-(i,P\+ X*@S*0Q)xL((A( <& 1%p*$0"@!H`vPlgPbXZYXhTpNx=x2x.%@#(8@
pe`Y
@O	8KXAP:7`3 0x,0" !8Pys}pc{P\z Gxh>wH<w(,u8!t sq@o@wl``kPXjhPj NiHJi 6e(!dcHcb@apa0a _s]0i\x`[`RYxLXHCWh=W3V00T0SXRxQxPPOH|M`iLxcK`YJxPJ II GHpFH`@G(9FH0F -Dx$CxC0CA(@Xx? w=`m<h`< ^; V:PN98G8pA7h=7P;7 5605p.50'2X2@1h0(0
|.@
d,
X*
H(
1%`
-%H
$$@
#$0
"`
 `	~0	k0	[0	H 	8 	(	`	 	
x	pyxv@r lf@a8[(Z
`P	PH	 D?x0p+ (h%(x    8s ~(o {P[ z0Q ypM y03 u(# t  sh s qP p  oPm lHc l\ j`S jH hhD g`- e8* c@ bp b a8 `H  _8{ _ x ^hr ^ k ]f \` [@Y [ F XPC X? Vp5 VH1 UH& T R( P@s N(o MHj Mg LPb Kx] I@J I CP A  @ ?@t >0q =`k = f ;pC 7p5 5H, 5# 30 3  1X
 1 .`d +PY +T '`< %(% $  #H "X " !  z Hp @h x^ X\ 8Z 0N (. H' `  x p 0 t P \ 0 . P + 8   x  0  8            

CHANGERECORD BINARY
              -.           ,<    ,~       (RNAME . 1)
(RFIELDS . 1)
(OLDFLG . 1)
CHANGERECORD
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER3)      

DUMPDATABASE BINARY
            -.           ,<    ,~       (FNLST . 1)
DUMPDATABASE
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER1)     

DUMPDATABASE1 BINARY
                -.           ,<    ,~       (VALUE . 1)
(FN . 1)
DUMPDATABASE1
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER2)    

GETRELATION BINARY
             -.           ,<    ,~       (ITEM . 1)
(RELATION . 1)
(INVERTED . 1)
GETRELATION
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER3)     

GETTEMPLATE BINARY
             -.           ,<    ,~       (FN . 1)
GETTEMPLATE
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER1)    

MAPRELATION BINARY
             -.           ,<    ,~       (RELATION . 1)
(MAPFN . 1)
MAPRELATION
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER2)     

MASTERSCOPE BINARY
             -.           ,<    ,~       (MASTERSCOPECOMMAND . 1)
(TOPFLG . 1)
MASTERSCOPE
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER2)    

MASTERSCOPEXEC BINARY
               -.           ,<    ,~       (X . 1)
(LINE . 1)
MASTERSCOPEXEC
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER2)     

MSCLOSEFILES BINARY
            -.            ,<    ,~       MSCLOSEFILES
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER0)      

MSHASHLIST1 BINARY
               -.           ,<    ,~       (VAL . 1)
(KEY . 1)
MSHASHLIST1
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER2)     

MSINTERPA BINARY
            -.           ,<    ,~       (VAL . 1)
(KEY . 1)
MSINTERPA
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER2)    

MSMARKCHANGED BINARY
                -.           ,<    ,~       (NAME . 1)
(TYPE . 1)
(REASON . 1)
MSMARKCHANGED
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER3)    

MSMEMBSET BINARY
               -.           ,<    ,~       (ITEM . 1)
(SET . 1)
MSMEMBSET
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER2)      

MSLISTSET BINARY
            -.           ,<    ,~       (SET . 1)
(TRYHARD . 1)
(TYPE . 1)
MSLISTSET
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER3)      

MSNEEDUNSAVE BINARY
              -.           ,<    ,~       (FNS . 1)
(MSG . 1)
(MARKCHANGEFLG . 1)
MSNEEDUNSAVE
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER3)     

MSNOTICEFILE BINARY
            -.           ,<    ,~       (FILE . 1)
MSNOTICEFILE
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER1)      

MSSHOWUSE BINARY
               -.     0      ,<    ,~       (VARIABLE-VALUE-CELL SHOWFN . 0)
(SHOWTYPE . 1)
(SHOWSET . 1)
(SHOWEDIT . 1)
(IFCANT . 1)
(EDITCOMS . 1)
MSSHOWUSE
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTERF)     

PARSERELATION BINARY
                -.           ,<    ,~       (RELATION . 1)
PARSERELATION
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER1)      

READATABASE BINARY
             -.            ,<    ,~       READATABASE
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER0)    

SETTEMPLATE BINARY
             -.           ,<    ,~       (FN . 1)
(TEMPLATE . 1)
SETTEMPLATE
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER2)      

TESTRELATION BINARY
              -.            ,<    ,~       (ITEM . 1)
(RELATION . 1)
(ITEM2 . 1)
(INVERTED . 1)
TESTRELATION
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER4)      

UNSAVEFNS BINARY
               -.           ,<    ,~       (FNS . 1)
UNSAVEFNS
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER1)     

UPDATECHANGED BINARY
                -.            ,<    ,~       UPDATECHANGED
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER0)     

UPDATECHANGED1 BINARY
            -.           ,<    ,~       (VAL . 1)
(KEY . 1)
UPDATECHANGED1
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER2)    

UPDATEFN BINARY
                -.           ,<    ,~       (FN . 1)
(EVENIFVALID . 1)
(IFCANT . 1)
UPDATEFN
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER3)    

MSLISTSET BINARY
               -.           ,<    ,~       (SET . 1)
(TRYHARD . 1)
(TYPE . 1)
MSLISTSET
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER3)      

MSDESCRIBE BINARY
                -.           ,<    ,~       (FN . 1)
(SN . 1)
MSDESCRIBE
(NIL)
(LINKED-FN-CALL . MASTERSCOPEBLOCK)
(ENTER2)     
STORETABLE BINARY
        ,    &    *-.           &Z   ,<   [   Z  D  ',<   @  (   ,~   Z  ,<   Z   ,<  [  Z  F  ([  [  3B   +   %Z  ,<   Zp  -,   +   +   Zp  ,<   @  )   +   Z   ,<   Z  ,<  [  	[  F  ),~   [p  XBp  +   /   Z   ,<   Zp  -,   +   +   $Zp  ,<   @  )   +   #Z  Z  ,   2B   +   "Z  ,<   Z  ,<  [  [  F  *,~   [p  XBp  +   /   Z   ,~   P!J e@    (VARIABLE-VALUE-CELL KEY . 64)
(VARIABLE-VALUE-CELL TABLST . 66)
(VARIABLE-VALUE-CELL VALUE . 58)
GETTABLE
(VARIABLE-VALUE-CELL OLDREL . 46)
PUTTABLE
(VARIABLE-VALUE-CELL Z . 62)
ADDTABLE
SUBTABLE
(FMEMB BHC SKNLST KNIL ENTERF)       % x        & p        
EQMEMBHASH BINARY
             -.           Z   ,<   Z   Z   ,   D  ,~       (VARIABLE-VALUE-CELL X . 5)
(VARIABLE-VALUE-CELL V . 3)
(VARIABLE-VALUE-CELL H . 6)
MEMB
(GETHSH ENTERF)    H      
(PRETTYCOMPRINT MASTERSCOPECOMS)
(RPAQQ MASTERSCOPECOMS ((COMS * MSDATABASECOMS) (COMS * MSAUXCOMS) (COMS * MSDBCOMS) (COMS * MSCHECKBLOCKSCOMS) (COMS * MSPATHSCOMS)
 (COMS (FNS MSFIND) (VARS MSBLIP) (COMS (* SCRATCHASH) (INITVARS (MSCRATCHASH)) (DECLARE: DONTCOPY (MACROS SCRATCHASH)))) (COMS (* 
marking changed) (FNS MSMARKCHANGED CHANGEMACRO CHANGEVAR CHANGEI.S. CHANGERECORD MSNEEDUNSAVE UNSAVEFNS) (ADDVARS (
COMPILE.TIME.CONSTANTS)) (VARS (RECORDCHANGEFN (QUOTE CHANGERECORD))) (INITVARS (CHECKUNSAVEFLG T) (MSNEEDUNSAVE))) (DECLARE: 
EVAL@COMPILE DONTCOPY (RECORDS * PARSERRECORDS) (MACROS GETWORDTYPE)) (COMS (* interactive routines) (VARS * (LIST (LIST (QUOTE 
MASTERSCOPEDATE) (SUBSTRING (DATE) 1 9)))) (ADDVARS (HISTORYCOMS %.)) (FNS %. MASTERSCOPE MASTERSCOPE1 MASTERSCOPEXEC) (* 
Interpreting commands) (FNS MSINTERPRETSET MSINTERPA MSGETBLOCKDEC LISTHARD MSMEMBSET MSLISTSET MSHASHLIST MSHASHLIST1 CHECKPATHS 
ONFILE) (FNS MSINTERPRET VERBNOTICELIST MSOUTPUT MSCHECKEMPTY CHECKFORCHANGED MSSOLVE) (DECLARE: DONTCOPY (RECORDS GETHASH 
INRELATION PATHOPTIONS))) (DECLARE: DONTCOPY (COMS * MSCOMPILETIME)) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (
ADDVARS (NLAMA %.) (NLAML) (LAMA)))))
(RPAQQ MSDATABASECOMS ((FNS UPDATEFN MSGETDEF MSNOTICEFILE MSSHOWUSE MSUPDATEFN1 MSUPDATE MSNLAMBDACHECK MSCOLLECTDATA) (FNS 
UPDATECHANGED UPDATECHANGED1) (VARS TABLE.TO.NOTICED) (FNS MSCLOSEFILES) (VARS (MSFILELST) (MSOPENFILES)) (VARS (MSPRINTFLG (QUOTE %.
)) (MSPRINTCNT 0)) (ADDVARS (MSHASHFILENAME) (ANALYZEUSERFNS))))
(RPAQQ TABLE.TO.NOTICED ((BIND (- (- (- (- (+ BIND ARG) REF) SMASH) SET) TEST)) (REFFREE (- (- (- REFFREE SETFREE) SMASHFREE) 
TESTFREE)) (REF (- (- (- REF SET) SMASH) TEST)) (PREDICATE (- PREDICATE CALL)) (EFFECT (- (- EFFECT CALL) PREDICATE)) (CALL (- CALL 
NLAMBDA)) (0 TYPE) (APPLY (+ APPLY STACK)) (ARGS ARG)))
(RPAQQ MSFILELST NIL)
(RPAQQ MSOPENFILES NIL)
(RPAQQ MSPRINTFLG %.)
(RPAQQ MSPRINTCNT 0)
(ADDTOVAR MSHASHFILENAME)
(ADDTOVAR ANALYZEUSERFNS)
(RPAQQ MSAUXCOMS ((* things which are not in the "main stream" of MASTERSCOPE) (COMS (* Describe command) (FNS MSDESCRIBE 
MSDESCRIBE1 FMAPRINT) (ADDVARS (DESCRIBELST)) (GLOBALVARS DESCRIBELST)) (COMS (* Print help file) (FNS MSPRINTHELPFILE) (VARS 
MSHELPFILE)) (COMS (* templates - export TEMPLATE GETTEMPLATE SETTEMPLATE) (FNS TEMPLATE GETTEMPLATE SETTEMPLATE) (FILEPKGCOMS 
TEMPLATES))))
(ADDTOVAR DESCRIBELST)
(RPAQQ MSHELPFILE <LISP>MASTERSCOPE.SYNTAX)
(PUTDEF (QUOTE TEMPLATES) (QUOTE FILEPKGCOMS) (QUOTE ((COM MACRO (X (P * (MAPCAR (QUOTE X) (FUNCTION (LAMBDA (FN) (LIST (QUOTE 
SETTEMPLATE) (KWOTE FN) (KWOTE (GETTEMPLATE FN)))))))) CONTENTS NILL) (TYPE DESCRIPTION "masterscope templates"))))
(RPAQQ MSDBCOMS ((* functions for manipulating the data base) (FNS MSMARKCHANGE1 MSINIT GETVERBTABLES MSSTOREDATA STORETABLE) (
ADDVARS (MSCHANGEDARRAY) (MSDATABASELST)) (INITVARS (MSDBEMPTY T)) (VARS MSDATABASEINIT NODUMPRELATIONS) (FNS PARSERELATION 
PARSERELATION1 GETRELATION MAPRELATION TESTRELATION) (COMS (* table lookup functions) (FNS ADDHASH SUBHASH MAKEHASH MSREHASH 
EQMEMBHASH) (P (MAPC (QUOTE ((GETHASH GETTABLE) (GETHASH TESTTABLE) (PUTHASH PUTTABLE) (ADDHASH ADDTABLE) (SUBHASH SUBTABLE) (
MAPHASH MAPTABLE) (MAKEHASH MAKETABLE) (EQMEMBHASH EQMEMBTABLE))) (FUNCTION (LAMBDA (X) (MOVD? (CAR X) (CADR X)))))) (DECLARE: 
EVAL@COMPILE DONTCOPY (FNS MSVBTABLES)) (DECLARE: DONTCOPY (MACROS GETRELQ TESTRELQ)) (BLOCKS (NIL ADDHASH SUBHASH MAKEHASH MSREHASH
 MSVBTABLES (LOCALVARS . T)))) (COMS (* erase function) (FNS MSERASE)) (COMS (* dump data base) (FNS DUMPDATABASE DUMPDATABASE1 
READATABASE) (VARS DATABASECOMS)) (ADDVARS (GAINSPACEFORMS (MSDATABASELST "erase current Masterscope database" (%. ERASE))))))
(ADDTOVAR MSCHANGEDARRAY)
(ADDTOVAR MSDATABASELST)
(RPAQ? MSDBEMPTY T)
(RPAQQ MSDATABASEINIT ((CALL 25 . 50) (BIND 10 . 10) (NLAMBDA 10 . 10) (NOBIND 10) (RECORD 20 . 10) (CREATE 2 . 2) (FETCH 10 . 10) (
REPLACE 10 . 10) (REFFREE 10 . 1) (REF 10 . 25) (SETFREE 1 . 1) (SET 20 . 30) (SMASHFREE 1 . 1) (SMASH 1 . 1) (PROP 1 . 1) (TEST 1 .
 1) (TESTFREE 1 . 1) (PREDICATE 10 . 10) (EFFECT 10 . 10) (CLISP 10 . 10) (SPECVARS 10 . 10) (LOCALVARS 10 . 10) (APPLY 10 . 10) (
ERROR 10 . 10) (LOCALFREEVARS 10 . 10) (CONTAINS 10 . 10) (FILE 10) (ARGS 10) (USERTEMPLATES NIL . T) (0 10 . 10)))
(RPAQQ NODUMPRELATIONS (CONTAINS FILE))
(MAPC (QUOTE ((GETHASH GETTABLE) (GETHASH TESTTABLE) (PUTHASH PUTTABLE) (ADDHASH ADDTABLE) (SUBHASH SUBTABLE) (MAPHASH MAPTABLE) (
MAKEHASH MAKETABLE) (EQMEMBHASH EQMEMBTABLE))) (FUNCTION (LAMBDA (X) (MOVD? (CAR X) (CADR X)))))
(RPAQQ DATABASECOMS ((E (DUMPDATABASE))))
(ADDTOVAR GAINSPACEFORMS (MSDATABASELST "erase current Masterscope database" (%. ERASE)))
(RPAQQ MSCHECKBLOCKSCOMS ((* blocks checker) (FNS MSCHECKBLOCKS MSCHECKBLOCK MSCHECKFNINBLOCK MSCHECKBLOCKBASIC MSCHECKBOUNDFREE 
GLOBALVARP PRINTERROR MSCHECKVARS1 UNECCSPEC NECCSPEC SPECVARP SHORTLST DOERROR) (BLOCKS (MSCHECKBLOCKS MSCHECKBLOCKS MSCHECKBLOCK 
MSCHECKFNINBLOCK MSCHECKBLOCKBASIC MSCHECKBOUNDFREE PRINTERROR MSCHECKVARS1 UNECCSPEC NECCSPEC SPECVARP SHORTLST DOERROR (
LOCALFREEVARS SEEN BLKFNS V ERRORS SFLG LF BLKAPPLYCALLERS U LF1 SHOULDBESPECVARS) (NOLINKFNS . T) (SPECVARS SPECVARS LOCALVARS 
RETFNS BLKAPPLYFNS BLKLIBRARY NOLINKFNS LINKFNS LOCALFREEVARS DONTCOMPILEFNS ENTRIES) (GLOBALVARS SYSLOCALVARS SYSSPECVARS FILELST 
MSCRATCHASH) GLOBALVARP))))
(RPAQQ MSPATHSCOMS ((* PATHS) (FNS MSPATHS MSPATHS1 MSPATHS2 MSONPATH MSPATHS4 DASHES DOTABS BELOWMARKER MSPATHSPRINTFN) (BLOCKS (
MSPATHSBLOCK (ENTRIES MSPATHS MSONPATH MSPATHS2) MSPATHS MSPATHS1 MSPATHS2 MSONPATH MSPATHS4 DASHES DOTABS BELOWMARKER 
MSPATHSPRINTFN (LOCALFREEVARS TABS NAMED LINENUM LL BELOWCNT MARKING SEEN INVERTED TO NOTRACE AVOIDING SEPARATE) (GLOBALVARS MSBLIP 
MSCRATCHASH) (NOLINKFNS . T)))))
(RPAQQ MSBLIP "sysout and inform Masinter@PARC")
(RPAQ? MSCRATCHASH)
(ADDTOVAR COMPILE.TIME.CONSTANTS)
(RPAQQ RECORDCHANGEFN CHANGERECORD)
(RPAQ? CHECKUNSAVEFLG T)
(RPAQ? MSNEEDUNSAVE)
(RPAQ MASTERSCOPEDATE " 7-Dec-84")
(ADDTOVAR HISTORYCOMS %.)
(PUTPROPS MASTERSCOPE COPYRIGHT ("Xerox Corporation" 1983 1984))
NIL
