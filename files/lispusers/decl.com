(FILECREATED " 7-DEC-83 08:33:09" ("compiled on " <LISPUSERS>DECL.;20) (2 . 2) bcompl'd in WORK dated 
"26-SEP-83 00:54:17")
(FILECREATED "16-NOV-83 11:25:26" {PHYLUM}<LISP>LIBRARY>DECL.;3 116890 changes to: (VARS DECLCOMS) (
FNS \VARASRT FINDDECLTYPE) previous date: "11-NOV-83 08:01:13" {PHYLUM}<LISP>LIBRARY>DECL.;2)

LCCTYPE BINARY
       '    "    %-.           "-.       "    "Zp  b  "b  #,<   [w3B   +   
,<p  [w,<   ,  ,<   ,  +   
Zp  /   +    ,<w,<w  $3B   +   Zw+    ,<p  ,<w  $3B   +   Zp  +    ,<w,<   ,<   ,<   Zw~-,   +   +    Z  XBw,<   ,<w},  ,<   Zw3B   +   ,<   ,<w  $3B   +   Zp  XBw/   [w~XBw~+   Zp  /  +    b a	 @     (TL . 1)
(NIL)
(LINKED-FN-CALL . GETDECLTYPE)
(NIL)
(LINKED-FN-CALL . GETCTYPE)
(NIL)
(LINKED-FN-CALL . COVERSCTYPE)
(SKNLST URET2 URET1 BHC KNIL BLKENT ENTER1)      " 0         " x      0  H     h    (      

TYPEMSANAL BINARY
     A   '   <-.          '-.     ('   *Zp  2B *+   Z *,<   Z   Z   XCp  QEp  ,\   -,   +   
Z   ,   ,<   ,<   @ + @  +   Z   XB   Z   ,<  ,  uZ  Z  2B  +   Z   ,~   [  ,<   Z  ,<   [  ,<   Z  ,<   ,<    ,,\   d ,Z         [  2D   +   Zp  QD  Zp  +    +    3B -+   2B -+   L,< .Zp  ZwXD  [  ,<   Z .,<   Z   Z   XCp  QEp  ,\   -,   +   (Z   ,   ,<   ,<   @ + @  +   ;Z  XB  [  Z  ,<   ,  uZ  +Z  *2B  +   0Z   ,~   [  .,<   Z  0,<   [  -,<   Z  2,<   ,<    ,,\   d ,Z  1       [  2D   +   7Zp  QD  Zp  +        ,\   XD  [  ,<   Z  +Z   ,   2B   +   J@ /   +   J@ 0  +   HZ  >,<   ,<   ,<   ,<   ,<   Z   l 1,~   Z  CZ  >,   ,~   ,\  XB  Zp  /   +    2B 2+   t,< 2,<p  Z 3,<   Z   Z   XCp  QEp  ,\   -,   +   TZ   ,   ,<   ,<   @ + @  +   gZ  6XB  3[  HZ  ,<   ,  uZ  WZ  V2B  +   \Z   ,~   [  Z,<   Z  \,<   [  Y,<   Z  ^,<   ,<    ,,\   d ,Z  ]       [  2D   +   cZp  QD  Zp  +        ,\   XD  [  ,<   [  WZ  b 3,<   Zp  @   [ 2B   +   o,<p   4/   ,<   Z  jd 5,\  XB  Zp  /   +      6+    Zp  -,   +   ~[  _-,   +   |Z  v,<   Z   ,       ,\   QD  [  XB  xZp  XD  +    -,   +  &Zp  3B 7+  3B 8+  3B 8+  3B 9+  2B 9+  [p  ,<   Zp  -,   +  Z   +  Zp  ,<   ,  u[p  XBp  +  /   +    2B :+  Z   +    Zp  ,<   ,  u[p  Z  2B :+  [p  [  -,   Z   Z  XBp  +   u[p  Z  -,   Z   Z  2B ;+  Z   +    2B ;+  %[p  Z  [  ,<   Zp  -,   +  Z   +  $Zp  ,<   [p  Z  ,<   ,  u/   [p  XBp  +  /   +      6+      6+    p(" 
 A Z  BA P  /~
$a03 	         (KIND . 1)
(VARIABLE-VALUE-CELL EXPR . 225)
(VARIABLE-VALUE-CELL CLISPARRAY . 145)
(VARIABLE-VALUE-CELL FNNAME . 141)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 217)
(VARIABLE-VALUE-CELL !SCRATCHTAIL . 248)
COVERS
((NIL) . 0)
(VARIABLE-VALUE-CELL !SCRATCHLIST . 197)
(VARIABLE-VALUE-CELL !SCRATCHTAIL . 0)
(NIL)
(LINKED-FN-CALL . RPLACD)
type?
the
((NIL NIL NIL) . 0)
((NIL) . 0)
(NIL VARIABLE-VALUE-CELL FILEPKGFLG . 0)
(T VARIABLE-VALUE-CELL NOSPELLFLG . 0)
(T VARIABLE-VALUE-CELL DWIMESSGAG . 0)
(NIL VARIABLE-VALUE-CELL LISPXHIST . 0)
(NIL)
(LINKED-FN-CALL . DWIMIFY0?)
\*DECL
((NIL NIL) . 0)
((NIL) . 0)
(NIL)
(LINKED-FN-CALL . GETDECLTYPE)
(NIL)
(LINKED-FN-CALL . MAKETESTFN)
(NIL)
(LINKED-FN-CALL . APPLYFORM)
(NIL)
(LINKED-FN-CALL . SHOULDNT)
ALLOF
ONEOF
SHARED
SUBTYPE
TUPLE
MEMQ
OF
SATISFIES
WHOSE
(SKLST SKLA BHC GETHSH URET1 CONSNL SKNLST KNIL BLKENT ENTER1)   8     v   % 0 @ p 	H   	  @   ' h%   H ~ X t   M @  X   ( T  
    p x 
0 '    p x `   n X a H U 
@ Q 
 G h F  9 X 0  ( P $ 0         h    (      

MAKETESTFNBLOCK BINARY
        h   -.          h-.     h   iZp  @   Z  Z  ,<   Zw@  Z -,   +   
Zw@  Z 2B   +   Z i,<   @ j @  +  $,< kZw,<8   k3B   +   ZwZ8  @  ,<   ZwZ8  @  [  ,<   ,< l m    ,\   QD    ,~   ,<`   n2B o+   +[`  ,<   ,< o p,<   ,<p  Zp  -,   +   +   (,<   ,<p  Zw@  [ 2B   +   #Zwb q,<   Z   d r,\  XB  /   [p  XBp  +   /   Zp  /   ,<   ,< s, $+  2B s+   T,< tZ  $,   ,<   ,< t u,<   Zw~,<8   v3B   +   B[`  [  3B   +   :,< wZ  -,<   [`  ,<   ,<   ,   ,<   ,<   ,   +   S,< wZ  5,<   [`  Z  3B   +   A3B   +   A-,   +   A,< x,<   ,   ,   +   S[`  [  3B   +   K,< xZ  :,<   [`  3B   +   J3B   +   J-,   +   J,< x,<   ,   ,   +   S,< yZ  D,<   [`  Z  3B   +   R3B   +   R-,   +   R,< x,<   ,   ,   ,   +  2B y+   ^Z`  b u,<   [`  [  [  3B   +   Z[`  [  +   \[`  [  Z  b u,<   , t+  2B z+   p[`  ,<   ,< z p,<   ,<p  Zp  -,   +   d+   m,<   ,<p  Zw@   [ 2B   +   hZwb q,<   Z  Ld r,\  XB  /   [p  XBp  +   b/   Zp  /   ,<   ,< {, $+  2B {+  Z`  b u,<   Zp  @  e[ 2B   +   v,<p   q/   ,<   Z  id r,<   [`  Z  [  [  3B   +   Z s[`  Z  [  ,   +  [`  Z  [  Z  ,   ,<   ,< s, $+  3B |+  3B |+  2B }+  [`  Z  b u,<   Zp  @  s[ 2B   +  ,<p   q/   +  2B }+  [`  ,<   , +  2B ~+  Zw,<8  Z`  ,<   [`  Z  [  ,<   , (+    ~,<   ZwZ8  @ 	[ ,<   Zw~Z8  @ ,<   Zw3B   +   [w,   Z ,   b  +   Zw    ,\   QD    /   /   ,~   +    ,<w,<   ,<   Zw-,   +  (+  =Z  XBp  ,<w-,   Z   Z  Zw~2B  +  .[wb +  ;Zw,<   Zw}2B s7   Z   ,\  2B  +  3Z   +  ;Zw,<   Zw}2B {7   Z   ,\  2B  +  :Zw,   /   +  >Zw,   d XBw[wXBw+  &Zw/  ,<   ,<w, @+    ,< tZ  w,   ,<   Zw~-,   +  FZw2B s7   Z   +  J[w~3B   +  JZwZw~,   +  JZw~,   +    ,<w w/"   ,   ,<   , Z,<   Zp  2B +  RZ [p  ,   +    2B +  UZ [p  ,   +    2B +  XZ [p  ,   +    ,< ,<w,   +    Zp  0B   +  ]Zw+     p  0"  +  iZp  0B   +  aZ +  g0B  +  cZ +  g0B  +  eZ +  g0B  +  gZ +  g  ~,<   ,<w,   +     p  0"  +  p,< ,<w,   ,<    w/"  ,   XBw,\   XBw+  Z,< ,<w w."   ,   ,   +    Zw@ [ 2B   +  w,<w q,<   Z Ad r,<   ,<w,<  2B   +  },< 	 	,<   Z x,<   ,< 
Zw~@ t[ 2B   +  ,<w~ q,   ,   ,   ,<   ,< s, $+    Zp  3B   +  ',< Z },<  b ,   ,<   ,<w,<   ,<   ,<   ,<   ,< Zw}-,   +  +  #Z  XBwb u,<   Zp  @ [ 2B   +  ,<p   q/   ,<   Z ,<   ,<w, Kd rXBwZw~3B   +  ,<   Zw~,   XBw~,\  QB  +   Zw,   XBw~XBw~[w}XBw} p  ."   ,   XBp  +  Zw~/  ,   ,<   ,< s, $+    Z +    ,<w u,<   Zp  @ [ 2B   +  -,<p   q/   ,<   Z d r,<   ,<w,<   Zw-,   +  7Zp  Z   2B   +  5 "  +  6[  QD   "  +  eZw,<   ,<p  ,<  3B   +  <[p  Z  +  <[p  b u,<   Zp  @ *[ 2B   +  A,<p   q/   ,<   Zw}2B +  UZw,<   Zp  3B +  K3B +  K3B +  K3B +  K3B +  K2B +  M,<   Z .,<  ,   +  T-,   +  Q,   5" PZ   +  TZ   +  RZ   +  TZ K,<   ,<w, K/   +  aZw,<   ,<w|     ,\   ,   3B   +  _,< ,<w|Zw~,   ,<   ,< yZ R,<   ,   +  aZw,<   ,<  	d r/   Zp  ,   XBp  [wXBw+  0/  ,   ,<   ,< s, $+     !V(f CxbF `VB1A,EsH!z ?r9` X 1DD
H@G B;]p0 
&b
22H 
RA#*Ea	`#               (TB . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 636)
(VARIABLE-VALUE-CELL BINDINGNAME . 698)
VALUE
(0 . 1)
(VARIABLE-VALUE-CELL BINDINGNAME . 0)
MAKETESTFNBLOCK
(NIL)
(LINKED-FN-CALL . DECLRECURSING)
.TestFn
(NIL)
(LINKED-FN-CALL . PACK*)
(NIL)
(LINKED-FN-CALL . TETYPE)
ALLOF
DOWN
(NIL)
(LINKED-FN-CALL . COLLECTTYPES)
(NIL)
(LINKED-FN-CALL . MAKETESTFN)
(NIL)
(LINKED-FN-CALL . APPLYFORM)
AND
MEMQ
LAMBDA
((ONEOF LITATOM SMALLP) . 0)
(NIL)
(LINKED-FN-CALL . GETDECLTYPE)
(NIL)
(LINKED-FN-CALL . COVERSTB)
SELECTQ
EQ
QUOTE
MEMBER
EQUAL
OF
ONEOF
UP
OR
SATISFIES
SHARED
SUBTYPE
SYNONYM
TUPLE
WHOSE
(NIL)
(LINKED-FN-CALL . SHOULDNT)
LABEL
(NIL)
(LINKED-FN-CALL . DOLABEL)
(NIL)
(LINKED-FN-CALL . APPEND)
(NIL)
(LINKED-FN-CALL . NCONC)
CDR
CADR
CDDR
CADDR
CDDDR
CADDDR
CAR
CDDDDR
FNTH
EVERYFN
(NIL)
(LINKED-FN-CALL . GETTBPROP)
"OF construction used with non-aggregate type"
(NIL)
(LINKED-FN-CALL . DECLERROR)
FUNCTION
EQLENGTH
(NIL)
(LINKED-FN-CALL . LENGTH)
1
NULL
2
(NIL)
(LINKED-FN-CALL . EQLENGTH)
LISTP
CAAR
CDAR
(NIL)
(LINKED-FN-CALL . RECORDFIELDNAMES)
FETCH
" is not a valid fieldname"
(COLLCT FMEMB GUNBOX SKI CONSS1 ASZ URET3 MKN URET2 SKLST URET1 CONS21 ALIST2 CONS ALIST3 SKNNM LIST4 
LIST2 KT CONSNL BHC SKNLST KNIL SKLA BLKENT ENTER1) ,8   +   )x   )h   ,h%   f @b  \   h 0Y `S   # 8o `    ht  ] @A   *   ( $x%      \  H     U (J h    
  @t 8 T 
8 K     
 I x   +p :   M Pi ( S 	0 A    *F p1 
  H h 8    #HB 89 h   ,`b *XB %`% "`?  $ 8 x o ` l   ) p   &  @' 8    Z *(P ( : &@3 &, #( !X !H  x @v  F h3 + h& P @ u x Y 	p G @ =  4 ( "   
               

DECLTRAN BINARY
    @       4-.           -.     h   Z   XB   Zp  ,<   [w[  ,<   Z   ,<   @  `` +  0Zw[8  Z  XB` -,   +   #,<   ,<   Z` -,   +   +    Z  XBp  Z`  2B +   Zp  2B +   ,< [` Z` ,   Z ,   ,   ,   XB` +    ,<p  Z`  2B 7   Z   ,<   Z`  3B +   7   Z   ,<   , 1[` XB` +   Zw/  Z   b XB  !+   ,3B   +   +-,   +   +Z`  2B +   +,<` ,< ,   ,<   ,<   ,<   , 1Z   XB   Z` XB  "Z`  2B +   7Z` -,   Z   XB` Z  3B +   5Z` Z   2B  +   7[` Z  2B +   7Z` XB` [` XB` Z`  3B +   T,<   ,<   ,<   Z` -,   +   <+   IZ  XBw-,   +   >+   IZwZ  13B  +   HZw2B +   D,<` [wd XB` +   HZw2B +   I,<p  [wd XBp  [` XB` +   :Z`  2B +   NZ   Z` ,   Z ,   ,   XB` Zp  3B   +   SZ` ,   Z ,   ,   XB` Zw/  Z   ,<   Zp  -,   +   W+   _Zp  ,<   [p  XBp  3B   +   ]Zp  b 2B   +   \  b /   [p  XBp  +   U/   Z   3B   +   dZ Z  _,   Z` ,   XB` Z   3B   +   hZ Z  d,   Z` ,   XB` Z   3B   +   mZ` ,   Z ,   ,   XB` Z` 3B   +   pZ Z` ,   XB` Z  *3B   +   tb Z ,   ,   ,<   ,<`  Z ,   XB` Z   3B   +   |,<` b ,<   [` d ,\  QB  Z`  2B +  Z` ,   XB` Z` 3B   +  Z` ,   XB` Z  ?Z ,   Z` ,   XB` Z` 3B   +  Z` ,   XB` Z  +Z` ,   Z ,   XB` +  2B +  ,< Z ,<  ,< ,<` ,   ,   XB` Z` 3B   +  [` ,<   Z` [` [  ,   ,\  QB  +  Z` XB` @   +  Zw,<8 ,<8 ,<   ,<   ,<   Z   l ,~   Z  T2B   +   Z   3B   +  *Z` Z XD  Z b XB ",<` Z 3B   +  (Z #3B   +  (,   +  (Z %[` ,   ,\  QB  Z`  2B +  -Z` ,~   Zw,<8  ,<`   ZwZ8  ,~   +    Zp  2B   +  37   Z   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   Zwz-,   +  OZwzXBw~3B !+  <2B !+  CZ  h3B   +  @,< ",<   ,< ",<wy #Z   XBw{XBw{Z !XBw~[wzXBwZw{3B   +  O@ $   +  KZw,<?,<?z,<?,<   ,<   Z l ,~   Zw,<   [wXBw,\   XBw+  OXBw~Zw~3B   +  R-,   +  T,< %,<   ,< ",<wy #,<w,<   ,<   Zw-,   +  X+  3Z  XBp  Zwz3B   +  Zp  2B %+  fZw}Z  f,   3B   +  c,< &,<w|,<   ,< ",<ww
 #2B   +  1+  Zw}Z  a,   XB c2B   +  1+  2B &+  rZw}Z d,   3B   +  n,< ',<w|,<   ,< ",<ww
 #2B   +  1+  Zw}Z \,   XB o2B   +  1+  -,   Z   Z  2B '+  Zw}Z p,   3B   +  {,< (,<w|,<   ,< ",<ww
 #2B   +  1+  Zw}Z h,   XB |2B   +  1+  Zp  2B (+  Zw}Z   ,   3B   +  Z 2B   +  1+  Zw}Z ,   XB 2B   +  1+  3B )+  -,   Z   Z  2B )+  Z )XBwz2B   +  1Zp  -,   Z   Z  2B *+  Zw~3B   +  ,< *,<   ,< ",<ww #Zp  XBw~+  1Zp  -,   Z   Z  Z 3B  +  1,<p  ,<w| +XBw|3B   +  $Zw{3B   +  !,< ,,<w,<   ,< ",<ww
 #Zw|XBw{Zp  XBw{+  1Zp  -,   +  .Zp  ,<   ,< ,,< -,<   ,<w~
 -3B   +  .Z J3B   +  Y3B .+  Y,<   ,< / /+  Y,< 0,<w,<   ,< ",<ww
 #[wXBw+  VZw/  Zw|2B   +  6Z 1XBw}Zp  3B   +  @,<w},<   ,   XBw},<   ,<w~ +XBw|2B   +  @,< 1,<w|,<   ,< ",<wx
 #Zw~2B !+  DZw}XB <Z   /  ,~   Zw{3B   +  UZ ,<  Zp  -,   +  H+  TZp  ,<   Zw}Zp  3B  +  O,<   Zw-,   Z   Z  ,\  2B  +  R,< 2,<w},<   ,< ",<ww
 #/   [p  XBp  +  F/   Zw|3B   +  fZw|[  2B   +  Y,<w| 2XBw}3B +  fZw{3B   +  b,<w}Zw~3B   +  _,   +  `Z   XBwz,   XBw+  f,< 3,<w~,<w|,<w},   ,   Z  w,   XB eZw}3B 1+  s,<w~Zw{,   ,   Z (,   XB jZw3B   +  oZw{3B   +  w+  pZw{2B   +  wZw~Z  p,   XB q+  wZw{3B   +  wZw~,   Z k,   XB uZw{3B   +  ~Zw3B   +  |,<w~,<   ,   +  |Zw~Z E,   XB |Zw~Z  ,   XB ~+  B (cqC	
-&12Y$ `.@0	
#d(%! 	s(A ZACApJ`c+a5&PIJ;e!De0`@2DE2 H                  (FORM . 1)
(VARIABLE-VALUE-CELL CLISPCHANGE . 7)
(VARIABLE-VALUE-CELL VARS . 767)
(VARIABLE-VALUE-CELL COMMENTFLG . 561)
(VARIABLE-VALUE-CELL FAULTFN . 596)
(VARIABLE-VALUE-CELL NEWSATLIST . 328)
(VARIABLE-VALUE-CELL RETURNS . 644)
(VARIABLE-VALUE-CELL LOCALVARS . 490)
(VARIABLE-VALUE-CELL SPECVARS . 506)
(VARIABLE-VALUE-CELL GLOBALVARS . 525)
(VARIABLE-VALUE-CELL PROGDCLS . 763)
(VARIABLE-VALUE-CELL VARBINDFORMS . 716)
(VARIABLE-VALUE-CELL SAT . 749)
(VARIABLE-VALUE-CELL INITVARS . 740)
(0 . 1)
(0 . 1)
(VARIABLE-VALUE-CELL VARS . 0)
NIL
NIL
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL PROGDCLS . 0)
(NIL VARIABLE-VALUE-CELL SPECVARS . 0)
(NIL VARIABLE-VALUE-CELL SAT . 0)
(NIL VARIABLE-VALUE-CELL INITVARS . 0)
(NIL VARIABLE-VALUE-CELL VARBINDFORMS . 0)
(NIL VARIABLE-VALUE-CELL RETURNS . 0)
(NIL VARIABLE-VALUE-CELL LOCALVARS . 0)
DPROG
THEN
RETURN
DPROGN
(NIL)
(LINKED-FN-CALL . DREVERSE)
DLAMBDA
FIXP
CLISP:
DECLARATIONS:
DECLARE
(NIL)
(LINKED-FN-CALL . APPEND)
DECL
PROG
(NIL)
(LINKED-FN-CALL . FINDDECLTYPE)
(NIL)
(LINKED-FN-CALL . SHOULDNT)
(NIL)
(LINKED-FN-CALL . DECLDWIMTESTFN)
SPECVARS
LOCALVARS
the
\CHKINIT
(NIL)
(LINKED-FN-CALL . NCONC)
PROGN
((ASSERT: (CLISP DLAMBDA)) . 0)
LAMBDA
(NIL VARIABLE-VALUE-CELL NEWSATLIST . 0)
(NIL)
(LINKED-FN-CALL . DWIMIFY0?)
\*DECL
(NIL)
(LINKED-FN-CALL . REALCLISPTRAN)
RETURNS
VALUE
"Multiple RETURNS/VALUE declaration"
"   inside "
(NIL)
(LINKED-FN-CALL . DECLDWIMERROR)
(T VARIABLE-VALUE-CELL NOSPELLFLG . 0)
(T VARIABLE-VALUE-CELL DWIMESSGAG . 0)
"Illegal variable name"
SPECIAL
"Variable can't be both LOCAL and SPECIAL:  "
LOCAL
"Variable can't be both LOCAL and SPECIAL:  "
USEDIN
"Variable can't be both LOCAL and USEDIN:  "
GLOBAL
FREE
BOUNDIN
SATISFIES
"Multiple SATISFIES"
(NIL)
(LINKED-FN-CALL . GETDECLTYPE.NOERROR)
"more than one type declaration:  "
80
((SATISFIES BOUNDIN USEDIN) . 0)
(NIL)
(LINKED-FN-CALL . FIXSPELL)
TYPE-IN
FNS
(NIL)
(LINKED-FN-CALL . MARKASCHANGED)
"invalid declaration: "
ANY
"invalid declaration: "
"more than one binding for "
(NIL)
(LINKED-FN-CALL . MAKEBINDFN)
REALSETQ
(CONSS1 FMEMB SKNLA URET1 ALIST3 LIST2 SKLA BHC CONSNL ALIST2 CONS21 CONS SKNLST KNIL SKLST KT BLKENT 
ENTER1)   -(a    hi `          ,X   | ,P:   (    %   U *8D &H ` ` T    .`_    H m 
0 N x   p   0 w @ l 
( N h   0 ~ .pr -8j ,h Xp P* X
   @  k  g @ c 
 M X   ) W 
h > 8    z /t .n -P` +h\ +V )`E (8= ' 5 %8* #h # "  !0  H h{ ps n  f (^ (V `Q (J XA `8  7 p6 `5 P4 (' X  p @    x   n   e  \   P 	@ :   9 x +  $ `  X    M $X !x
 09 p    Q 'p0 %  "@y @` 8? 8 * X   @    (      

PPDECL BINARY
       k   -.          k-.     0k   n[p  -,   +   Z   3B   +   	Zp  Z   ,   3B   +   	Zp  +    Zp  2B n+   %^"  ,> j,>     o,   .Bx  ,^   /   ,   ,<   Z   3B   +   Z p+   Z pb q,< r q[wZ  ,<   ,<   , 4[w[  XBw-,   +   ZwZ   3B  +   ,<p  ,< r,<    s,<w,<w,<   ,<   Z   j tZ  3B   +   #Z u+   #Z ub q/   +  32B v+    o,   ."   ,   ,<   ,<    w."  ,   XBp  ,< v q[wZ  -,   +  ,< w q[wZ  ,<    w."  ,   ,<   ,<   ,<   ,<   ,<   Zw}-,   +   6+   ~Z  XBw-,   +   p,<w~,< r,<    s,< w,<    qZw,<   ,<    x[wXBw3B   +   f,< y y,<   ,<   Zw~-,   +   D+   YZ  XBp  ` o,<   ,<   ,<   Z  j tZp  -,   +   N[w~Z  -,   +   N[w~Z  ,<   ,< y z+   UZp  -,   +   S[w~Z  -,   +   TZ   +   UZ   +   U,<p  ,< { zZ   ,   2B   +   X+   Y[w~XBw~+   B[w~XBw~Zw/  ,<wZp  -,   +   ^+   eZp  ,<   ,< y y,<p    o,<   ,<   ,<   Z  Gj t/   [p  XBp  +   \/     o,   ,> j,>    w~    ,^   /   2"  +   m,<w~ s,< | q+   n,< | }Z   XBp  +   }2B ~+   v w|."  ,   ,<   ,< r,<    s,< ~,<    q+   }Zp  3B   +   z,<w~,< r s+   {,< y yZ   XBp  ,<w x[w}XBw}+   4Zw~/  ,< ~ }+  [wZ  b x[w[  ,<   Zp  -,   +  +  Zp  ,<   Zp  -,   +  ,<w~,<   ,<    s,<p  ,<    x+  -,   Z   Z  Z  3B  +  ,<w,< r,<    s,<p    o,<   ,<   ,<   Z  bj t/   [p  XBp  +  /   ,<  q/  +  32B +  ,<   q[p  ,<   ,<   , 4,<   }+  32B +  3^"  ,> j,>     o,   .Bx  ,^   /   ,   ,<   ,<  q[wZ  ,<   ,<   , 4[w[  XBw-,   +  /ZwZ 3B  +  /,<p  ,< r,<    s,<w,<w,<   ,<   Z j t,<  q/   Z   +    Zw-,   +  iZp  2B   +  8,<  q,<w  o,<   ,<   ,<   ,<   Zw~-,   +  =+  bZ  XBw-,   +  Z,<w~,< r,<    s,< ,<    qZw,<   ,<    x[w,<   Zp  -,   +  H+  OZp  ,<   ,< y y,<p    o,<   ,<   ,<   Z 1j t/   [p  XBp  +  F/     o,   ,> j,>    w~    ,^   /   2"  +  W,<w~ s,<  q+  X,<  }Z   XBp  +  `Zp  3B   +  ],<w~,< r s+  ^,< y yZ   XBp  ,<w x[w~XBw~+  ;Zw~3B   +  e,<  q,<w~ xZw/  Zp  2B   +    ,<  }+    b x+       $T|E O< c@ E4#C"VM*|p[bN a	AT7czBT	h+"PE /I>:          (FORM . 1)
(VARIABLE-VALUE-CELL PRETTYTRANFLG . 9)
(VARIABLE-VALUE-CELL CLISPARRAY . 13)
(VARIABLE-VALUE-CELL #RPARS . 65)
(VARIABLE-VALUE-CELL COMMENTFLG . 343)
(VARIABLE-VALUE-CELL FNSLST . 409)
(VARIABLE-VALUE-CELL CLISPCHARS . 171)
DLAMBDA
(NIL)
(LINKED-FN-CALL . POSITION)
"["
"("
(NIL)
(LINKED-FN-CALL . PRIN1)
"DLAMBDA "
0
(NIL)
(LINKED-FN-CALL . TAB)
(NIL)
(LINKED-FN-CALL . PRINTDEF)
"]"
")"
DPROG
"(DPROG "
"("
"("
(NIL)
(LINKED-FN-CALL . PRIN2)
1
(NIL)
(LINKED-FN-CALL . SPACES)
(NIL)
(LINKED-FN-CALL . NTHCHAR)
-1
")"
")"
(NIL)
(LINKED-FN-CALL . PRIN3)
THEN
")"
")"
DECL
"(DECL "
")"
DPROGN
"(DPROGN "
")"
"("
"("
")"
")"
" . "
")"
(URET2 SKLA FMEMB SKNLST KT MKN BHC IUNBOX URET1 GETHSH KNIL SKLST BLKENT ENTER1)   0j       
p   x= X ] 
  P 	8 C `   L @1  @ o ( G P   x   P s ( +     g HP h4 H     j h d @ % x   # x ' `   P 
       h 8_ 8M PC ; 07 H/   @
   |   v H c 
x T 
0 G ( B   > @ : H 4 8 )    p      ? `+ X I  .             

\VARASRT BINARY
     +    $    *-.           $-.      %    &,<p  Z   ,<   ,  +    ,<   ,<   ,<   Zw~-,   +   	+   #Z  XBw,<w~d  &XBp  2B   +   +   "[p  XBp  2B   +   Z   +    [p  3B   +   ,<w~[w~,<   ,  Zp  ,<   ,<w}  ',<   Zp  @   [ 2B   +   ,<p    (/   ,<   Zw}Z 7@  7   Z  ,<    "   ,   3B   +    +   Zp  ,<   ,<w}  )[w~XBw~+   Zw+    L!@	     (VARNAME . 1)
(VARIABLE-VALUE-CELL SATISFIESLIST . 7)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 45)
(NIL)
(LINKED-FN-CALL . ASSOC)
(NIL)
(LINKED-FN-CALL . GETDECLTYPE)
(NIL)
(LINKED-FN-CALL . MAKETESTFN)
(NIL)
(LINKED-FN-CALL . ASSERTFAULT)
(EVCC KNOB BHC URET5 SKNLST KNIL URET1 BLKENT ENTER1) p   P   (   P               H   p                

DECLOFBLK BINARY
   t   ?   j-.          ?-.     8@pC           ,<wZw2B D+   Z   +   2B E+   	Z   +   2B   +   Z   ,<  Zp  -,   +   Zp  Z 7@  7   Z  2B E+   ,<p  ,<   Z   f Fb G3B   +   Z   +   Z   /   3B   +   Z  
+   Z  +   ,< H,<   ,   B H,<   , @   [  +    Zp  -,   +   $2B   +   !Z   +    2B   +   #Z I+    ,<   , !+    -,   +  ,<   Zw-,   +  Zw,<   ,< C IXBp  -,   Z   Z  2B J+   4[p  -,   Z   Z  3B K+   4[p  Z  ,<   ,<w "   ,   2B   +  +   5Zp  2B   +  Zw3B K+   82B L+   N[wZ  ,<   , !,<   ,<   ,<w L,<   Zp  @  Z  2B   +   @,<p   M/   XBp  2B N+   K,< O,<wZw}2B L+   G,< O[w}[  Z  ,   +   J[w}[  Z  ,<   ,  ,   +   M[w~,   XBw~/  +   /  +  2B P+   g[w[  ,<   ,<   ,<   ,<   Zw~XBwZw-,   +   U+   _ZwZ  XBp  3B P+   ^2B Q+   Y+   ^Z   3B  +   ^Zw2B   +   ]Z   XBw+   _[wXBw+   SZp  2B Q+   e[w2B   +   eZw[  Z  XBw}/  +   Z R/  +  2B R+   k,<w SZ  XBw/   +   2B T+  [w,<   ,<   ,<   ,<   ,<   ,<   ,<   Zw}-,   +   r+  Z  XBwb SZ  ,<   ,  XBw2B R+   wZ R+  Zw2B   +   zZ   XBp  ,<w,<w} T3B   +   }+  ZwXBw~Zw~3B   +  ,<   Zw~,   XBw},\  QB  +  Zw~,   XBw~XBw}[w}XBw}+   pZp  2B   +  Z   Zw},   2B   +  ,<w}Z   ,   d UXBw}[w}3B   +  Z VZw},   +  Zw}/  +  2B W+  3[w[  ,<   ,<   ,<   ,<   ,<   ,<   Zw}XBwZw-,   +  +  .[w3B   +  Zw[  b SZ  +  Zw,<   ,  XBp  2B R+  "Z R+  2,<   ,<w} T3B   +  %+  -Zp  XBwZw~3B   +  +,<   Zw~,   XBw~,\  QB  +  -Zw,   XBw~XBw~[wXBw+  [w~3B   +  2Z VZw~,   +  2Zw~/  +  3B W+  63B X+  62B X+  :[w[  [  Z  XBw/   +   2B N+  >[w[  Z  XBw/   +   3B Y+  @2B Y+  M[wZ  -,   +  L[wZ  ,   A ?(Bu,   0B   +  GZ Z+  0B  +  IZ Z+  0B  +  KZ [+  Z R+  Z R+  2B [+  Q[w[  Z  XBw/   +   2B \+  T[wZ  XBw/   +   2B \+  d[wZ  3B   +  Z[wZ  Z  Z  -,   +  \[wZ  +  ^[wZ  Z  ,   ,<   @ A    +  dZw[?[  b SZ  ,<   ,  ,~   +  3B ]+  f2B ]+  h[wZ  +  3B ^+  j2B ^+  k[wZ  +  2B _+  o,< O[wZ  ,   +  Zw,<   ,<   ,<    _XBw,\  3B  +  vZp  3B `+  vXBw/   +   ZwZ   ,   2B   +  Zw,<   ,< a I3B   +  @ a   +  Zw,<?,<? cZwZ?Z w,   ,~   +  Z   XBp  3B   +  XBw/   +   ,<w d3B   +  
,< O,<w e,   +  Z R+  Zw-,   +  ZwZ  3B f+  2B f+  Zw[  [  b SZ  +  ZwZ  ,   XBp  3B   +  XBw/   +   Z R/   +    ,< O,<   ,   +    -.    g,<`  ,  b L,~       ,<p  Z  ,<   , +    Z ],<   ,<   ,<   ,<   ,<   ,<   Zw}-,   +  &+  9Z  XBw~,<w}d h[  XBp  2B   +  ++  7Zw3B   +  0Zp  ,<   ,<w~,   XBwZ   XBw+  5Zw3B   +  4Zp  Zw,   XBw+  5Zp  XBw[p  2B   +  7+  9[w}XBw}+  $Zw3B   +  <b iZ O,   +    Zw2B   +    Z R+        FujJ0`xD
9a
@$K7# KdFN %	I|qn`pqA"/OEH&QZrxP&!0@H                (DECLOFBLK#0 . 1)
(VARIABLE-VALUE-CELL CSATISFIESLIST . 574)
(VARIABLE-VALUE-CELL SATISFIESLIST . 17)
(VARIABLE-VALUE-CELL DECLVARSLST . 578)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 35)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 122)
(VARIABLE-VALUE-CELL COMMENTFLG . 179)
(VARIABLE-VALUE-CELL CLISPARRAY . 551)
DECLOF
TYPEBLOCKOF
COMPILER
INTERPRETER
NOBIND
(NIL)
(LINKED-FN-CALL . STKSCAN)
(NIL)
(LINKED-FN-CALL . RELSTK)
27
ERRORX
((MEMQ T) . 0)
(NIL)
(LINKED-FN-CALL . GETP)
FUNCTION
SATISFIES
SETQ
SETQQ
(NIL)
(LINKED-FN-CALL . GETDECLTYPE)
(NIL)
(LINKED-FN-CALL . MAKESETFN)
REALSETQ
ALLOF
MEMQ
PROG
ASSERT
DECLARE
RETURN
ANY
PROGN
(NIL)
(LINKED-FN-CALL . LAST)
COND
(NIL)
(LINKED-FN-CALL . MEMBER)
(NIL)
(LINKED-FN-CALL . NCONC)
ONEOF
SELECTQ
REPLACEFIELD
FREPLACEFIELD
/REPLACEFIELD
FETCHFIELD
FFETCHFIELD
FIXP
FLOATP
((MEMQ NIL T) . 0)
REPLACEFIELDVAL
PROG1
\*DECL
the
THE
create
CREATE
QUOTE
(NIL)
(LINKED-FN-CALL . EXPANDMACRO)
IGNOREMACRO
CLISPWORD
(NIL VARIABLE-VALUE-CELL FILEPKGFLG . 0)
(T VARIABLE-VALUE-CELL NOSPELLFLG . 0)
(T VARIABLE-VALUE-CELL DWIMESSGAG . 0)
(NIL)
(LINKED-FN-CALL . DWIMIFY0?)
(NIL)
(LINKED-FN-CALL . DECLCONSTANTP)
(NIL)
(LINKED-FN-CALL . EVAL)
LAMBDA
NLAMBDA
*TBOF*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL DECLVARSLST . 0)
(NIL)
(LINKED-FN-CALL . ASSOC)
(NIL)
(LINKED-FN-CALL . DREVERSE)
(URET7 CONS21 BINDB GETHSH ASZ MKN IUNBOX SKI FMEMB CONSNL SKNLST CONS ALIST3 ALIST2 EVCC SKLST URET1 
URET2 LIST2 BHC KT KNOB SKLA KNIL BLKENT ENTER1)   'x> 'P   'H   #@   "P     H `   X   @           H) H    $`  U   4 h2  L    K   
 p G    3    ( . 0 %   ! #8 P #    `   %p 0   #  `v HQ `: 8 0 g X N 	X A h    z  ]           ' p    > '(7 & 0 %H* $P$ $@# $0 !   8| W  ' H x h X @
  x |  p x o h n ( \ 
0 R 
  ? 8 5 8 . 8 &    p  @  (    (      

DECLOF BINARY
             -.           ,<    ,~       (FORM . 1)
(DECLCONTEXT . 1)
DECLOF
(NIL)
(LINKED-FN-CALL . DECLOFBLK)
(ENTER2)     

TYPEBLOCKOF BINARY
             -.           ,<    ,~       (FORM . 1)
TYPEBLOCKOF
(NIL)
(LINKED-FN-CALL . DECLOFBLK)
(ENTER1)    

DECLTYPE BINARY
                -.          Z`  ,<   [`  Z  ,<   [`  [  F  ,~      (X . 1)
USERDECLTYPE
(ENTER1)      

DECLTYPES BINARY
            -.          ,<`  ,<   Zw-,   +   	Zp  Z   2B   +    "  +   [  QD   "  +    Zw,<   Zp  ,<   [wZ  ,<   [w[  F  /   Zp  ,   XBp  [wXBw+   E      (DTS . 1)
USERDECLTYPE
(COLLCT BHC URET2 SKNLST KNIL ENTER1)          	          X        

DUMPDECLTYPES BINARY
     g    Y    d-.           YZ`  -,   +   Z   +   [`  -,   Z   @  Z3B   +   7   Z   ,<   Zp  3B   +   ,<   "  Z,<  [,<   $  [,<   "  Z,<   "  ZZw3B   +   Z  \+   Z  \,<   ,<   $  [,<`  Zp  -,   +   +   QZp  ,<   Zw~3B   +   ,<  ],<   ,<   &  ],<  ^,<   $  [Zp  -,   +   /Zp  ,<   ,<   $  ^,<  _,<   $  _Zp  ,<   ,<   $  ^,<  _,<   $  _[p  Z  ,<   ,<   $  ^,<  _,<   $  _Zp  ,<   [wZ  D  `,<   ,<   "  `,<   ,<   ,<   ,<   ,<   ,  a+   L,<   ,<   ,<  a&  b[  XBp  Zp  ,<   ,<   $  ^,<  _,<   $  _[p  [  @  `,<   ,<   ,<   Zw~XBp  [w~Z  ,<   ,<w~$  aZp  -,   +   >+   K,<w,<   ,<   &  ]Zp  ,<   ,<   $  ^,<  _,<   $  _[p  Z  ,<   ,<   "  `,<   ,<   ,<   ,<   ,<   ,  a[p  [  XBp  +   <Zw/  Zw~3B   +   O,<  b,<   $  [/   [p  XBp  +   /   ,<  c,<   $  [,<   "  ZZp  3B   +   X,<  c,<   $  [,<   "  Z/  ,~   EjO#4FFB f1E)T     (TL . 1)
OUTPUT
TERPRI
"(DECLARE: EVAL@COMPILE"
PRIN1
"(DECLTYPES"
"(DECLTYPE "
11
TAB
"("
PRIN2
1
SPACES
GETDECLTYPEPROP
POSITION
PRINTDEF
NOCOPY
GETDECLDEF
")"
")"
")"
(BHC KNIL SKLST KT SKNLST ENTER1)   R 
 M    X 
x V 
H S 	x N 	 I 	 F @ B  @  9 ` 4  / h . X ,   & @ "   8    0  h  H      `   P     H     @   `   0      

GETDECLDEF BINARY
      ,    %    +-.          %,<`  "  ',<   Z  (Z` 1B  +   *  -,   +   *  ,   2B   7       ,<   Zw3B   +   ,<`  Zw@   Z  Z  ,<   Zw3B   +   Zp  +   ,<p  "  (/   ,<   Zw~@  Z ,<   Zw~3B   +   Zp  +   ,<p  "  (/   ,   ,   Z  ),   +   $Z  )Z` 1B  +    *  -,   +    *  ,   2B   7       3B   +   #Z   +   $,<`  ,<  *$  */  ,~    @ T,H
@    (NAME . 1)
(FPTYPE . 1)
(OPTIONS . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 38)
FINDDECLTYPE
NOCOPY
COPY
DECLTYPE
NOERROR
"is not a DECLTYPE"
DECLERROR
(CONS21 CONSS1 BHC KT KNIL FMEMB SKLST ENTER3)   0         %      !    0 "    `  0 	            h      

COVERS BINARY
     
        	-.           ,<`  "  ,<   ,<` "  D  	3B   +   Z   ,~   Z   ,~   h   (HI . 1)
(LO . 1)
GETDECLTYPE
COVERSTB
(KT KNIL ENTER2)   h    x        

GETDECLTYPEPROP BINARY
                -.           ,<`  "  ,<   ,<` $  ,~   @   (TYPE . 1)
(PROP . 1)
GETDECLTYPE
GETTBPROP
(ENTER2)      

SETDECLTYPEPROP BINARY
                -.           Z`  -,   +   ,<  D  ,<`  "  2B   +   ,<  ,<`  $  ,<   ,<` ,<` ,   D  ,<`  ,<` ,   ,<   ,<  $  Z` ,~   VB      (NAME . 1)
(PROP . 1)
(VAL . 1)
"Can't set property of non-atomic type:"
DECLERROR
FINDDECLTYPE
"Can't set property of non-existent type:"
REPROPTB
DECLTYPES
MARKASCHANGED
(LIST2 KNIL SKNLA ENTER3)        `    0      

SUBTYPESA0003 BINARY
                -.          Z`  @   [  -,   +   Z   ,<   ,<`  "      ,\   ,   3B   +   Z`  @  [  Z   ,   XB  
,~   Z   ,~   D  (S . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 18)
(VARIABLE-VALUE-CELL CT . 8)
(VARIABLE-VALUE-CELL TYPES . 22)
GETCTYPE
(CONS KNIL FMEMB SKLA ENTER1)  8   P                

SUBTYPES BINARY
             -.          ,<`  "  ,<   @    ,~   ,<`  "  XB   3B  +   Z`  @   Z  Z  Z  2B  +   Z`  @  Z  Z  [  B  ,~   Z   ,<   Z  D  Z   2B   +   Z  ,   ,~   Z   ,~        (NAME . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 22)
(VARIABLE-VALUE-CELL DECLTYPESARRAY . 28)
GETDECLTYPE
(0 . 1)
(NIL VARIABLE-VALUE-CELL TYPES . 32)
(NIL VARIABLE-VALUE-CELL CT . 11)
GETCTYPE
NONE
ONEOF
APPEND
SUBTYPESA0003
MAPHASH
(CONSNL KNIL ENTER1)             

SUPERTYPESA0004 BINARY
              -.          Z`  @   [  -,   +   Z   2B  +   	Z`  @  [  B  2B   +   +   Z`  @  Z  [  Z  ,   3B   +   Z`  @  	[  Z   ,   XB  ,~   Z   ,~   XX      (TB . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 27)
(VARIABLE-VALUE-CELL CN . 22)
(VARIABLE-VALUE-CELL TYPES . 31)
NONE
SUBTYPES
(CONS FMEMB KNIL SKLA ENTER1)           P            

SUPERTYPES BINARY
            
    -.          
,<`  "  B  ,<   @    ,~   Z   2B  +   +   	Z   ,<  Z  D  Z   ,~   G  (NAME . 1)
(VARIABLE-VALUE-CELL DECLTYPESARRAY . 14)
GETDECLTYPE
GETCTYPE
(VARIABLE-VALUE-CELL CN . 10)
(NIL VARIABLE-VALUE-CELL TYPES . 18)
ANY
SUPERTYPESA0004
MAPHASH
(ENTER1)      

CHECKTYPEXP BINARY
               -.           ,<`  "  2B   +   ,<  ,<`  $  ,~   P   (TE . 1)
TETYPE
"Invalid type expression"
DECLERROR
(KNIL ENTER1)   8      

COLLECTTYPES BINARY
    H    B    F-.           B,<`  ,<   ,<   ,<   ,<   Zw~-,   +   +   #Z  XBwB  CXBw,<p  ,<   ,<   Zw-,   +   +   Z  XBp  Zw~Zp  3B  +   Z` 2B  D+   ,<  ,<w}$  D3B   +   +   2B  E+   ,<w~,<w$  D3B   +   +      E3B   +   Zp  2B   +   Z   XBw+   [wXBw+   	Zw/  3B   +   +   !ZwZp  ,   XBp  [w~XBw~+   Zp  XBwZ   XBp  ,<   Zw~2B   +   (Zp  +   A[w~,<   ,<w,<   ,<   Zw-,   +   ,+   ;Z  XBwZ` 2B  D+   2,<wZw|D  D3B   +   9+   82B  E+   6Zw|,<   ,<w$  D3B   +   9+   8   E3B   +   9Z   XBp  +   ;[wXBw+   *Zp  /  3B   +   ?,<w~,<w~$  FZw~XBw,\   XBw~+   %/   Zp  +    @`Yy:$F@1Kbi@ (TYPES . 1)
(MERGE . 1)
GETDECLTYPE
UP
COVERSTB
DOWN
SHOULDNT
RPLACD
(URET5 CONS BHC KT SKNLST KNIL ENTER2) 0        < h   0     , 0     =  8 ` 1 ( ' ` % p    ( 
    @   0      

COVERSCTYPE BINARY
             -.           Z`  Z` 2B  +   Z   ,~   Z` -,   +   2B  7   Z   ,~   [` 3B   +   ,<` ,<   ,<   Zw-,   +   +   Z  XBp  ,<`  D  3B   +   Zp  2B   +   Z   XBw+   [wXBw+   Zw+    Z` XB` +   )$   (H . 1)
(L . 1)
NONE
COVERSCTYPE
(URET3 KNIL SKNLST KT ENTER2)           0 	  x   H               

COVERSTB BINARY
             -.          Z`  Z` 3B  7   7   +   ,<`  "  ,<   ,<` "  D  2B   +   Z`  @   Z  Z  ,<   Z` @  	Z  Z  D  ,~   )P (H . 1)
(L . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 23)
GETCTYPE
COVERSCTYPE
COVERSTE
(KNIL KT ENTER2)              

COVERSTE BINARY
     ?    :    =-.           :,<`  "  ;2B  ;+   ),<` "  ;2B  ;+   [` ,<   ,<   ,<   Zw-,   +   	+   Z  XBw[`  ,<   ,<   ,<   Zw-,   +   +   Z  XBp  ,<   ,<w}$  <3B   +   Zp  2B   +   Z   XBw+   [wXBw+   Zw/  2B   +   Z   XBp  +   [wXBw+   Zp  +    [`  ,<   ,<   ,<   Zw-,   +    +   (Z  XBp  ,<   ,<` $  <3B   +   'Zp  2B   +   &Z   XBw+   ([wXBw+   Zw+    2B  <+   9,<` "  ;2B  <+   8[` ,<   ,<   ,<   Zw-,   +   0+   7Z  XBw,<   [`  D  =2B   +   5Z   XBp  +   7[wXBw+   .Zp  +    Z   ,~   Z   ,~   8B"$B&p)     (H . 1)
(L . 1)
TETYPE
ONEOF
COVERS
MEMQ
MEMBER
(URET3 BHC SKNLST KT KNIL ENTER2)    * P           ` 	    / h        9 P 4 h % @  h       H        

CREATEFNPROP BINARY
          	    -.           	,<`  ,<` $  
,<   Zp  3B   +   [p  Z  ,<   ,<` $  +   Z   /   ,~   `  (PL . 1)
(PN . 1)
FINDPROP
CREATEFNVAL
(BHC KNIL ENTER2)            

CREATEFNVAL BINARY
               -.          Z`  3B   +   Z   3B   +   Z`  -,   +   ,<   ,<   $  Z`  ,~   Z` 2B  +   Z  ,~   2B  +   Z  ,~   Z   ,~   $G8 (FVAL . 1)
(FNAME . 1)
(VARIABLE-VALUE-CELL DWIMFLG . 6)
DWIMIFY
BINDFN
PROGN
SETFN
REALSETQ
(KT SKLST KNIL ENTER2)    x    `   `   0      

DECLERROR BINARY
               -.          ,<  Zp  -,   +   Zp  Z 7@  7   Z  2B  +   
,<p  ,<   Z   F  B  3B   +   Z   +   Z   /   3B   +   Z   XB      ,~   ,<`  ,<` $  ,~   ""     (MSG1 . 1)
(MSG2 . 1)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 16)
(VARIABLE-VALUE-CELL DECLERROR . 28)
DECLERROR
NOBIND
STKSCAN
RELSTK
ERROR!
ERROR
(BHC KT KNIL KNOB SKLA ENTER2)   P   h      H 
     `    8      

DELETETB BINARY
                -.          Z`  @   [  ,<   Zp  3B  +   2B  +   ,<  D  ,<`  "  ,<`  "  ,<   ,<w$  Z`  @  ,<   ,<  ,<w$      ,\   QD     /   ,~   ?)
      (TB . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 22)
ANY
NONE
"(Futile) attempt to delete"
DECLERROR
UNSAVETYPE
UNCOMPLETE
NOTICETB
Deleted
PACK*
(BHC KNIL ENTER1)       
       

FINDDECLTYPE BINARY
              -.          Z`  -,   +   Z   ,   3B   +   Z`  Z   ,   ,~   Z   ,~   Z  ,   2B   +   ,<`  "  ,~   @ (TE . 1)
(VARIABLE-VALUE-CELL CLISPARRAY . 6)
(VARIABLE-VALUE-CELL DECLTYPESARRAY . 16)
RECDTYPE
(KNIL GETHSH SKLST ENTER1)  
       	  p            

FINDPROP BINARY
             -.           ,<   Z`  2B   +   +   Z` Z`  2B  +   	Z`  2B   +   Z   XBp  +   [`  [  XB`  +   Zp  +    DH@ (L . 1)
(P . 1)
(URET1 KT KNIL ENTER2) H       x   (      

FINDTYPEXPA0005 BINARY
              -.          Z`  @   [  -,   +   	Z   ,<   Z`  @  Z  Z  ,\  ,   3B   +   +   
Z   ,~   Z  ,<   Z`  @  [  ,\  ,   2B   +   Z`  @  Z  
QD  ,<`  Z  D  ,<  ,<`  $  ,~   @  h    (TB . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 31)
(VARIABLE-VALUE-CELL TYPE . 35)
NOTICETB
FINDTYPEXP
RETFROM
(KNIL EQUAL SKLST ENTER1)    ( 	         @      

FINDTYPEXP BINARY
              -.          Z   ,<   Z  D  Z   ,~       (VARIABLE-VALUE-CELL TYPE . 0)
(VARIABLE-VALUE-CELL DECLTYPESARRAY . 3)
FINDTYPEXPA0005
MAPHASH
(KNIL ENTERF)    H      

GETCTYPE BINARY
                -.          Z`  @   Z  [  2B   +   ,<  ,<`  $  3B   +   ,<  Z`  @  Z  Z  D  2B   +   Z`  @  Z  ,<   Z`  @  Z  Z  B  D  [  ,~   5B@     (TB . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 27)
GETCTYPE
DECLRECURSING
"Invalid recursive type definition"
DECLERROR
MAKECTYPE
RPLACD
(KNIL ENTER1)    p        

GETDECLTYPE BINARY
               -.           ,<`  "  2B   +   Z`  -,   +   	B  2B   +   ,<`  ,<`  ,<` &  2B   +   ,<`  ,<  $  ,~   @ (TE . 1)
(VARNAME . 1)
FINDDECLTYPE
FINDTYPEXP
MAKEDECLTYPE
"is not a DECLTYPE"
DECLERROR
(SKLST KNIL ENTER2)       	  h        

GETDECLTYPE.NOERROR BINARY
            -.          ,<   @     +   ,<  ,<   ,<   @   ` +   Z   Z  XB Zw,<8  ,<8 $  ,<   ,<p  "  Zp  @   [ 2B   +   ,<p  "  Zp  /   +    Z  2B   +   Z   3B   +   Z   ,~      ,~   ,~   JB!     (TE . 1)
(VAR . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 24)
(VARIABLE-VALUE-CELL DECLERROR . 36)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
GETDECLTYPE
GETCTYPE
MAKETESTFN
ERROR!
(CONSNL BHC CF KT KNIL ENTER2)                    8  `   (      

GETTBPROP BINARY
                -.          Z` 2B  +   Z`  @   [  2B   +   ,<`  "  ,~   2B  +   Z`  @  Z  2B   +   ,<`  "  ,~   2B  +   Z`  @  [ 2B   +   ,<`  "  ,~   Z`  @  Z ,<   ,<` $  ,<   Zp  3B   +   [p  Z  +   ,<`  ,<` $  /   ,~   
a,I   (TB . 1)
(P . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 35)
BINDFN
MAKEBINDFN
SETFN
MAKESETFN
TESTFN
MAKETESTFN
FINDPROP
INHERITPROP
(BHC KNIL ENTER2)      `  (        

INHERITPROP BINARY
       W    I    U-.          IZ`  @   Z  Z  ,<   Zp  -,   +   HB  K3B  K+   2B  L+   ![p  Z  ,<   ,<` $  L,<   ,<  M,<` $  L,<   ,<  MZwZw3B  +   [w~[  ,<   ,<   ,<   Zw-,   +   +   Z  XBwZw},<   ,<w,<` $  L,\  3B  +   Z   XBp  +   [wXBw+   Zp  /  3B   +   Zw+   ZwD  N/  +   F3B  N+   $3B  O+   $2B  O+   %Zp  +   F2B  P+   :[p  ,<   ,<   Zw-,   +   .Zp  Z   2B   +   , "  +   -[  QD   "  +   8Zw,<   Zp  (B{Z  A"  ."   0B  	+   3Z  P+   4,<p  "  Q/   Zp  ,   XBp  [wXBw+   '/  Z  L,   +   F2B  Q+   @Z` 2B  R+   >,<  M,<  R$  N+   F[p  Z  +   F3B  S+   B2B  S+   C[p  Z  +   F2B  T+   EZ  T+   FZ  M,<   ,<` $  L+   HZ   /   ,~   a*	?8" t
wssy     (TB . 1)
(PROP . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 4)
TETYPE
ALLOF
ONEOF
GETDECLTYPEPROP
ANY
INHERITPROP
RETFROM
OF
SATISFIES
WHOSE
MEMQ
LARGEP
TYPENAME
SHARED
BINDFN
PROGN
SUBTYPE
SYNONYM
TUPLE
LISTP
(CONS21 COLLCT ASZ TYPTAB BHC SKNLST KT KNIL SKLST ENTER2)       h   ( 2    1    I  5      ) 8   (   	 + ( ( `       X      

INITDECLTYPES BINARY
           Z   -.           Z,<  \Zp  -,   +   Zp  Z 7@  7   Z  2B  \+   
,<p  ,<   Z   F  ]B  ]3B   +   Z   +   Z   /   3B   +   Z   B  ^+   ,<  ^"  _Z$  @,   XB  ,<  _,<   $  `@  `  ,~   ,<  aZp  -,   +   +   1Zp  ,<   ,<   ,<  a"  bZwQD  ,<   Zw    ,       ,\   XD  ,<   ,<w$  bXBp  ,<   Zw@   ,<   Z  c    ,\   QD  Zw@  !,<   Z  c    ,\   XD  Zw@  $,<   ,<  d,<  dZw}2B  e7   Z   ,       ,\   QD ,\   /   /   [p  XBp  +   /   ,<  e,<  f,<  f&  g,<  g,<  h,<  h&  g,<  i,<  i,<  j&  g,<  j,<  k,<   &  g,<  k,<  l,<  l&  g,<  m,<  m,<  n&  g,<  n,<  o,<  o&  g,<  p,<  p,<   &  g,<  q,<  q,<  r&  g,<  r,<  s,<  s&  g,<  t,<  t,<   &  g,<  u,<  u,<  v&  g,<  v,<  w,<  w&  g,<  x,<  x,<  y&  g,<  y,<  z,<  z&  g,<   ,<  {,<  {&  g,<  |,<  |,<  }&  g,<  },<  ~,<   &  g,<  ~,<  ,<  &  g,<  ,<  ,< &  gZ   ,~   "x21@ }?}_{               (VARIABLE-VALUE-CELL BOUNDPDUMMY . 16)
(VARIABLE-VALUE-CELL DECLTYPESARRAY . 34)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 80)
DECLTYPESARRAY
NOBIND
STKSCAN
RELSTK
CLRHASH
128
HARRAY
DECLTYPES
FILEPKGCHANGES
(NIL VARIABLE-VALUE-CELL FILEPKGFLG . 0)
((ANY NONE) . 0)
TYPEBLOCK
NCREATE
NOTICETB
PROGN
REALSETQ
LAMBDA
((VALUE) . 0)
ANY
ARRAYP
((SUBTYPE ANY) . 0)
((TESTFN ARRAYP) . 0)
MAKEDECLTYPE
HARRAYP
((SUBTYPE ARRAYP) . 0)
((TESTFN HARRAYP) . 0)
LISTP
((SUBTYPE ANY) . 0)
((TESTFN LISTP EVERYFN EVERY) . 0)
HASHARRAY
((ONEOF HARRAYP (LISTP (WHOSE (CAR HARRAYP)))) . 0)
READTABLEP
((SUBTYPE ARRAYP) . 0)
((TESTFN READTABLEP) . 0)
ATOM
((SUBTYPE ANY) . 0)
((TESTFN ATOM) . 0)
LITATOM
((SUBTYPE ATOM) . 0)
((TESTFN LITATOM) . 0)
BOOL
((MEMQ NIL T) . 0)
NUMBERP
((SUBTYPE ATOM) . 0)
((TESTFN NUMBERP) . 0)
FIXP
((SUBTYPE NUMBERP) . 0)
((TESTFN FIXP) . 0)
CARDINAL
((FIXP (SATISFIES (IGEQ VALUE 0))) . 0)
SMALLP
((SUBTYPE FIXP) . 0)
((TESTFN SMALLP) . 0)
LARGEP
((SUBTYPE FIXP) . 0)
((TESTFN LARGEP) . 0)
FLOATP
((SUBTYPE NUMBERP) . 0)
((TESTFN FLOATP) . 0)
FUNCTION
((SUBTYPE ANY) . 0)
((TESTFN FNTYP) . 0)
((MEMQ NIL) . 0)
((TESTFN NULL) . 0)
LST
((ONEOF LISTP NIL) . 0)
((EVERYFN EVERY) . 0)
ALIST
((LST OF LISTP) . 0)
STACKP
((SUBTYPE ANY) . 0)
((TESTFN STACKP) . 0)
STRINGP
((SUBTYPE ANY) . 0)
((TESTFN STRINGP EVERYFN EVERYCHAR) . 0)
(ALIST3 SKNLST CONS ASZ BHC KT KNIL KNOB SKLA ENTER0)  P   h   P         2   / P   H     Z 
X P x A  ,   X  (                

MAKECTYPE BINARY
    i    Z    f-.           Z,<`  "  [2B  [+   [`  ,<   ,<  \$  \,<   [p  3B   +   ,<p  ,<p  Zp  -,   +   
+   ,<   ,<p  ZwB  ],\  XB  /   [p  XBp  +   /   Zp  /   +   Zp  B  ]/   ,~   2B  ]+   [`  ,<   ,<  ^$  \,<   [p  3B   +   [`  B  ^,   +   Zp  B  ]/   ,~   3B  _+   2B  _+   ![`  Z  B  `B  ],~   ,<`  "  [2B  `+   L[`  ,<   ,<   ,<   ,<   ,<  aZp  XBwZw~-,   +   )+   ;Z  XBw[w2B   +   1,<w,<wZ   ,       ,\   XD  Z      ,\   QD  [  ,<   Zw~(B{Z  A"  ."   0B  	+   6Z  a+   7,<w~"  b    ,\   XD  XBw[w~XBw~+   'ZwZp  3B  +   I[p  ,<   [w3B   +   H,<w[w~,<   Zw~Z   QD  Zw~,<   Zw~Zw}XD  ,\   [w~QD  ,\   ,\  QB  ,\   +   IZ   XBw~Zw~/  B  ^+   Y,<`  "  [3B  b+   P3B  c+   P2B  c+   QZ`  +   X2B  d+   S[`  Z  +   X2B  d+   X[`  3B   +   WZ  e+   XZ   +   X   eB  `B  ],   ,~   CLbTyN0@ P  !_n9o     (TE . 1)
TETYPE
ALLOF
DOWN
COLLECTTYPES
GETCTYPE
ONEOF
UP
LCCTYPE
SHARED
SYNONYM
GETDECLTYPE
MEMQ
((NIL) . 0)
LARGEP
TYPENAME
OF
SATISFIES
WHOSE
SUBTYPE
TUPLE
LISTP
SHOULDNT
(ASZ TYPTAB CONSNL BHC SKNLST KNIL ENTER1)  X 5    4    Z `     K H    h    
    X 
` J ( ? X + ` % P   x      

MAKEDECLTYPE BINARY
    -    %    ,-.          %,<` "  ',<   ,<   ,<  '"  (,<   Z`  XBw    ,\   QD  ,<   ,<` "  (    ,\   XD ,<   ,<w$  )XBp  ,<   Zw@   ,<   ,<` "  (,       ,\   XD  ,\   /  ,<   Z` -,   +   #Zp  @  ,<   ,<` ,<  )$  *    ,\   QD  Zp  @  ,<   ,<` ,<  *$  *    ,\   XD  Zp  @  ,<   ,<` ,<  +$  *    ,\   QD ,<` ,<  +$  *Zp  /   ,~   `C     (NAME . 1)
(DECL . 1)
(PROPS . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 60)
CHECKTYPEXP
TYPEBLOCK
NCREATE
COPY
NOTICETB
BINDFN
CREATEFNPROP
SETFN
TESTFN
EVERYFN
(SKLST BHC CONSNL KNIL ENTER3)  H   P           8      

MAKEBINDFN BINARY
      	        	-.          Z`  @   ,<   ,<`  ,<  $      ,\   QD     ,~   `   (TB . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 4)
BINDFN
INHERITPROP
(ENTER1)    

MAKESETFN BINARY
       	        	-.          Z`  @   ,<   ,<`  ,<  $      ,\   XD     ,~   `   (TB . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 4)
SETFN
INHERITPROP
(ENTER1)     

MAPTYPEUSERSA0006 BINARY
        
    -.          
Z   ,<   Z   @   Z  Z  D  3B   +   	Z   ,<   Z  ,<   "   ,   ,~   Z   ,~      (VARIABLE-VALUE-CELL TB . 14)
(VARIABLE-VALUE-CELL NAME . 3)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 6)
(VARIABLE-VALUE-CELL FN . 12)
USESTYPE
(EVCC KNIL ENTERF)      (        

MAPTYPEUSERS BINARY
              -.          Z   ,<   Z  D  ,~       (VARIABLE-VALUE-CELL NAME . 0)
(VARIABLE-VALUE-CELL FN . 0)
(VARIABLE-VALUE-CELL DECLTYPESARRAY . 3)
MAPTYPEUSERSA0006
MAPHASH
(ENTERF)    

NOTICETB BINARY
        
        
-.          Z` -,   +   ,<   ,<   Z   F  	,<` ,<`  Z   F  	,~      (TBLOCK . 1)
(TEXP . 1)
(VARIABLE-VALUE-CELL CLISPARRAY . 8)
(VARIABLE-VALUE-CELL DECLTYPESARRAY . 12)
PUTHASH
(SKLST ENTER2)  0      

PPDTYPEA0007 BINARY
            -.          Z   ,<   Z`  @   Z  [  ,\  2B  +   Z`  @  [  ,<   ,<   $  ,<  ,<   $  ,~   Z   ,~     (S . 1)
(VARIABLE-VALUE-CELL I . 3)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 13)
PRIN1
1
SPACES
(KNIL ENTER1)    ( 	       

PPDTYPE BINARY
      {    j    x-.          j^"  ,>  j,>      l,   .Bx  ,^   /   ,   ,<   ,<`  "  l2B  m+   	Z`  +   
,<`  "  m,<   ,<  n,<   $  nZp  @   [  ,<   ,<   $  n,<  o,<   $  nZp  @  Z  Z  2B   +   Z  o,<   ,<   $  n,<w,<   ,<   &  p,<  p,<   $  nZp  @  Z  [  3B   +   +,<p  "  q,<   Zp  -,   +    +   *Zp  ,<   @  q   +   )Zw~ ?."  ,   ,<   ,<  r,<   &  pZ   ,<   Z  rD  s,~   [p  XBp  +   /   +   -,<  s,<   $  nZp  @  [  3B   +   9,<w,<   ,<   &  p,<  t,<   $  nZp  @  -[  ,<   ,<   "  l,<   ,<   ,<   ,<   ,<   ,  tZp  @  3Z  3B   +   E,<w,<   ,<   &  p,<  u,<   $  nZp  @  9Z  ,<   ,<   "  l,<   ,<   ,<   ,<   ,<   ,  tZp  @  ?[ 3B   +   Q,<w,<   ,<   &  p,<  u,<   $  nZp  @  E[ ,<   ,<   "  l,<   ,<   ,<   ,<   ,<   ,  tZp  @  KZ 3B   +   h,<w,<   ,<   &  p,<  v,<   $  nZp  @  QZ ,<   Zp  -,   +   [+   g,<    w~."  ,   ,<   ,<  r,<   &  pZp  ,<   ,<   $  n,<  v,<   $  n[p  Z  ,<   ,<   $  w/   [p  [  XBp  +   Y/      wZp  /  ,~       u(FA#bh# h!# `QPB@     (TYPE . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 175)
(VARIABLE-VALUE-CELL DECLTYPESARRAY . 77)
POSITION
TYPENAME
TYPEBLOCK
GETDECLTYPE
"DECLTYPE: "
PRIN1
" = "
"No type expression"
TAB
"Suptypes: "
GETCTYPE
(VARIABLE-VALUE-CELL I . 0)
0
PPDTYPEA0007
MAPHASH
"... not completed..."
"Bindfn:   "
PRINTDEF
"Setfn:    "
"Testfn:   "
"Property: "
" = "
PRIN2
TERPRI
(KT SKNLST KNIL MKN BHC IUNBOX ENTER1)   O 8 7    Z x   P b  _ 
p U 
P S 
 P 
  N 	0 I 	 G P D @ B p = P ;  8   6 0 1  / P & H     `    H   X %  h     h ` +  `    H      

RECDTYPE BINARY
        O    =    L-.          =,<   ,<   ,<  ?,<`  Z  ?,   ,   ,<   @  @  +   ,<  A,<   ,<   @  A ` +   Z   Z  CXB Zw~,<8  ,<  C$  D+    ,~   3B   +   <,<`  "  DXBw,<   ,<  E"  EZ`  QD  ,<   ,<`  $  FXBp  ,<   Zw@   ,<   ,<  F,<w}"  G,   B  G,       ,\   XD  ,\   /   XBw,<   ,<  H,<  H,<  IZ   ,<  ,<  I,<  J,<`  ,   ,   ,<   ,<  J[w}[  Z  ,<   Zw|Z   ,   ,<   ,<w|,<   Z  &F  K,\   F  K,   F  LZwZ  ),   [  [  [  [  [  [  [  [  Z  [  ,<   Zp  -,   +   5+   ;,<   ,<w~Zw,<   [wZ  F  L/   [p  [  XBp  +   3/   Zw/  ,~   EJFB 0           (R . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 45)
(VARIABLE-VALUE-CELL COMMENTFLG . 63)
(VARIABLE-VALUE-CELL CLISPARRAY . 89)
type?
NILL
(NIL VARIABLE-VALUE-CELL CLISPCHANGE . 0)
(T VARIABLE-VALUE-CELL DWIMESSGAG . 0)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
DTYPE?TRAN
RECORDTRAN
RECLOOK
TYPEBLOCK
NCREATE
NOTICETB
SUBTYPE
RECDEFTYPE
COPY
TESTFN
LAMBDA
((VALUE) . 0)
ASSERT:
RECORD
VALUE
PUTHASH
SUBST
SETTBPROP
(SKNLST ALIST4 GETHSH LIST2 BHC ALIST2 CF ALIST3 CONSNL KNIL ENTER1)  4    ,    .     0   P <              #  X   0   P     x 	    (      

DECLCHANGERECORD BINARY
     '         &-.           ,<`  ,<` ,<` &  #Z` 3B   +   ,<   Z`  Z   ,   ,<   Zp  3B   +   Zp  @   [ 2B   +   ,<p  "  $XBw3B   +   Z   ,<   [w[  Z  XBwZ  ,\  2B  +   [wZ  2B  $+   [w[  Z  XBwZ  2B  %+   Z`  [wZ  2B  7   7   +   +   Z   +   ,<p  "  %/  ,~   Z   ,~   ) &(      (RNAME . 1)
(RFIELDS . 1)
(OLDFLG . 1)
(VARIABLE-VALUE-CELL DECLTYPESARRAY . 12)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 19)
(VARIABLE-VALUE-CELL COMMENTFLG . 28)
REALCHANGERECORD
MAKETESTFN
ASSERT:
RECORD
DELETETB
(BHC KT GETHSH KNIL ENTER3) x   @    x     8  8 	  `        

RECDEFTYPE BINARY
        >    2    <-.           2Z`  2B  2+   Z  3Z`  7   [  Z  Z  1H  +   2D   +   ,<   Zp  3B   +   [p  Z  B  3+   Z  4/   ,~   2B  4+   Z  5,~   2B  5+   Z  6,~   2B  6+   Z  7,~   2B  7+   [`  Z  -,   +   [`  Z  [  Z  ,~   Z  4,~   2B  8+   Z  8,~   2B  9+   Z  9,~   2B  :+   /[`  [  Z  ,<   Zp  -,   +   #Z  9+   .3B   +   -,<   Z  :Z`  7   [  Z  Z  1H  +   *2D   +   &[  Z  ,\  2B  +   -Zp  +   .Z  4/   ,~   2B  ;+   1Z  ;,~   Z  4,~   "9nl ]lP:      (RD . 1)
ACCESSFNS
CREATE
DECLOF
ANY
ARRAYRECORD
ARRAYP
ASSOCRECORD
ALIST
ATOMRECORD
LITATOM
DATATYPE
HASHLINK
HARRAYP
PROPRECORD
LST
RECORD
SUBRECORD
TYPERECORD
LISTP
(SKLST BHC KNIL ENTER1)   " h   p     * H 
        

REPROPTBA0008 BINARY
                -.          ,<`  Z   ,<   ,<   &  ,~   @   (X . 1)
(VARIABLE-VALUE-CELL NEWP . 4)
REPROPTB
(KT ENTER1)         

REPROPTB BINARY
     .    &    ,-.          &,<   Z` 2B   +   +   Z` 3B   +   
Z`  @   Z ,<   Z` D  (3B   +   +   [` Z  ,<   Z`  @  Z ,<   Z` D  (,\  ,   3B   +   +   ,<p  ,<`  Z` ,<   [` Z  B  ),<   ,<` (  )Z` ,<   [` Z  ,   D  *XBp  [` [  XB` +   Zp  /   ,<   @  *   ,~   Z   3B   +   %Zw,<8  "  +ZwZ8  @  [  ,<   Z  +D  ,Z  ,~   H FA!`    (TB . 1)
(PROPS . 1)
(INHERITING . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 69)
FINDPROP
LISTGET
COPY
SETTBPROP
NCONC
(VARIABLE-VALUE-CELL NEWP . 74)
UNSAVETYPE
REPROPTBA0008
MAPTYPEUSERS
(BHC ALIST2 EQUAL KNIL ENTER3) P                8        

SETTBPROP BINARY
    3    *    2-.           *Z` 2B  -+   Z`  @   ,<   ,<` ,<  -$  -    ,\   QD  +   2B  .+   ,<` ,<  .$  -+   2B  .+   Z`  @  ,<   ,<` ,<  .$  -    ,\   XD  +   2B  /+   Z`  @  [  3B  /+   2B  0+   ,<  0Z`  @  [  D  1+   Z`  @  ,<   ,<` ,<  /$  -    ,\   QD Z` 2B   +   *Z`  @  Z 3B   +   %Z`  @  Z ,<   ,<` ,<` &  1,~   Z`  @  !,<   ,<` ,<` ,       ,\   XD    ,~   ;pcF @    (TB . 1)
(P . 1)
(V . 1)
(BLKONLY . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 75)
BINDFN
CREATEFNVAL
EVERYFN
SETFN
TESTFN
ANY
NONE
"(Futile) attempt to change TESTFN of"
DECLERROR
LISTPUT
(LIST2 KNIL ENTER4)            

TBDEFPRINT BINARY
            	    -.          	Z  
,<   ,<  Z`  @   [  ,<   ,<  &  @      ,\   XCp  QEp  ,\   ,~      (TB . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 7)
((NIL) . 0)
"{DECLTYPE: "
"}"
CONCAT
PACK
(ENTER1)      

TETYPE BINARY
       !         -.           Z`  -,   +   Z  ,~   -,   Z   Z  3B  +   3B  +   3B  +   3B  +   3B  +   3B  +   2B  +   Z`  ,~   [`  -,   +   [`  Z  2B  +   Z  ,~   [`  Z  -,   Z   Z  3B  +   2B   +   [`  Z  Z  ,~   Z   ,~   Z   ,~   x'`   (TE . 1)
PRIMITIVE
ALLOF
MEMQ
ONEOF
SHARED
SUBTYPE
SYNONYM
TUPLE
OF
SATISFIES
WHOSE
(KNIL SKLST SKLA ENTER1) (  H      p            

UNCOMPLETE BINARY
        "        !-.          Z`  @   ,<   Z`  @  Z ,<   ,<  $      ,\   QD  Z`  @  ,<   Z`  @  Z ,<   ,<  $      ,\   XD  Z`  @  	,<   Z`  @  Z ,<   ,<  $      ,\   QD Z`  @  Z  [  3B   +   Z`  @  Z  ,<   ,<   $   Z`  @  [  ,<   Z   D  !,~    0  C  (TB . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 52)
BINDFN
CREATEFNPROP
SETFN
TESTFN
RPLACD
UNCOMPLETE
MAPTYPEUSERS
(KNIL ENTER1)    h      

UNSAVETYPEA0009 BINARY
      
        
-.          ,<` ,<`  Z   F  	3B   +   ,<` ,<   Z   F  	,~   "   (TRAN . 1)
(ORIG . 1)
(VARIABLE-VALUE-CELL TYPE . 5)
(VARIABLE-VALUE-CELL CLISPARRAY . 11)
FORMUSESTB
PUTHASH
(KNIL ENTER2)   `        

UNSAVETYPE BINARY
                -.          Z   ,<   Z  D  Z   3B   +   Z   @   [  ,<   ,<  ,<   &  ,<   ,<  ,<   &  ,~   Z   ,~   U  (VARIABLE-VALUE-CELL TYPE . 10)
(VARIABLE-VALUE-CELL CLISPARRAY . 3)
(VARIABLE-VALUE-CELL MSDATABASELST . 7)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 11)
UNSAVETYPEA0009
MAPHASH
((USE TYPE) . 0)
GETRELATION
"type declarations"
MSNEEDUNSAVE
(KT KNIL ENTERF)  
    @        

USERDECLTYPE BINARY
      /    $    --.          $Z`  -,   +   "Z   ,   ,<   Z` Z`  3B  +   Zp  3B   +   ,<` Zw@   Z  Z  ,\  ,   3B   +   ,<`  "  &,<   ,<` $  '3B   +   !,<`  ,<  '$  (+   !Z`  3B  (+   2B  )+   ,<  )D  *,<`  ,<  'Zw3B   +   Z  *+   Z  +F  (Zp  3B   +   B  +,<`  Z` -,   +   ,<  ,,<   ,   ,<   ,<` &  ,/   Z`  ,~   ,<  -D  *,~    
+?'f#     (NAME . 1)
(DECL . 1)
(PROPS . 1)
(VARIABLE-VALUE-CELL DECLTYPESARRAY . 6)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 18)
GETDECLTYPE
REPROPTB
DECLTYPES
MARKASCHANGED
ANY
NONE
"(Futile) attempt to redefine"
DECLERROR
CHANGED
DEFINED
DELETETB
SYNONYM
MAKEDECLTYPE
"Non-atomic DECLTYPE name"
(BHC LIST2 SKNLST EQUAL KNIL GETHSH SKLA ENTER3)   "                     H                

USESTYPE BINARY
     _    S    \-.           SZ`  Z` 3B  7   7   +   R,<` "  T3B  T+   
3B  U+   
3B  U+   
3B  V+   
2B  V+   [` ,<   ,<   ,<   Zw-,   +   +   Z  XBp  ,<`  D  W3B   +   Zp  2B   +   Z   XBw+   [wXBw+   Zw+    2B  W+   *[` ,<   ,<   ,<   Zw-,   +   +   )Z  XBp  ,<   Zw(B{Z  A"  ."   0B  	+   "Z  X+   #,<w"  X,\  2B  +   'Zp  2B   +   &Z   XBw+   )[wXBw+   Zw+    2B  Y+   0,<`  Z` D  W2B   +   R[` [  Z  XB` +   2B  Y+   2Z   ,~   2B  Z+   6Z` ,<   Z   XB` ,\   XB`  +   2B  Z+   @Z`  ,<   [` 3B   +   ;Z  [+   ;Z   ,\  3B  7   7   +   RZ  T[` ,   XB` +   2B  [+   R,<`  Z` D  W2B   +   R[` Z  ,<   ,<   ,<   Zw-,   +   H+   QZ  XBp  ,<`  [wZ  D  W3B   +   OZp  2B   +   NZ   XBw+   Q[wXBw+   FZw+       \,~   /E$L :I`pp1e A$I       (NAME . 1)
(TE . 1)
TETYPE
ALLOF
ONEOF
SHARED
SUBTYPE
SYNONYM
USESTYPE
MEMQ
LARGEP
TYPENAME
OF
PRIMITIVE
SATISFIES
TUPLE
LISTP
WHOSE
SHOULDNT
(CONS ASZ TYPTAB URET3 SKNLST KNIL KT ENTER2)   @    !    x   
( * x   	   `   	` L p F @ > @ : P 2 X & (  0  P   H   	p = p   @      

MAKETESTFN BINARY
              -.           ,<`  "  ,~       (TB . 1)
MAKETESTFNBLOCK
(ENTER1)    

EVERYCHAR BINARY
               -.           ,<`  "  ,<   ,<   ,<   Z"   XBw w,>  ,>    w    ,^   /   3b  +   
+   ,<` ,<`  ,<w~$  ,<    "   ,   2B   +   Z   XBp  +    w."   ,   XBw+   Zp  +       H@    (STRNG . 1)
(FN . 1)
NCHARS
NTHCHAR
(URET3 MKN EVCC BHC ASZ KT KNIL ENTER2)  @       `       P    H   x   @      

LARGEP BINARY
             -.           Z`  -,   +   "   +   7   Z   ,~   Z   ,~   @   (X . 1)
(KNIL KT SMALLT SKI ENTER1)     X    P    @    0      

DECLRECURSING BINARY
                -.           ,<`  ,<  $  ,<   ,<   ,<`  ,<  ,<w~,<w~(  2B   +   +   Z` ,<   ,<  ,<w~$  ,\  3B  +   +   ,<w"  Z   +    +   Zp  +    e      (NAME . 1)
(ARG . 1)
-1
STKPOS
-2
1
STKARG
RELSTK
(URET2 KT KNIL ENTER2)            H      

SMASHCAR BINARY
                -.           ,<`  Zp  -,   +   +   
,<   ,<p  ,<` Zw,<    "   ,   ,\  XB  /   [p  XBp  +   /   Z`  ,~   @  (L . 1)
(FN . 1)
(BHC EVCC SKNLST ENTER2)   8 	               

ASSERT BINARY
               -.          ,<`  Zp  -,   +   Z   +    Zp  ,<   Zp  -,   +   B  +   -,   +   ,<   ,<  $  2B   +   ,<p  ,<   $  +   ,<  ,<   ,   B  /   [p  XBp  +   k'     (ARGS . 1)
\VARASRT
INTERNAL
EVAL
ASSERTFAULT
27
ERRORX
(BHC LIST2 SKLST SKLA URET1 KNIL SKNLST ENTER1)    x       p    P   P   H    8      

ASSERTFAULT BINARY
             -.           ,<   "  Z` 3B   +   Z  +   Z  ,<   ,<   $  ,<  ,<   $  ,<  ,<  $  B  ,<   ,<   $  Z  ,<   ,<   ,<   Z` 3B   +   ,<   ,<`  ,   +   Z`  ,<    "  ,   ,~   y_     (DECL . 1)
(VARNAME . 1)
LISPXTERPRI
"DECLARATION"
"ASSERTION"
LISPXPRIN1
" NOT SATISFIED IN "
-1
ASSERTFAULT
REALSTKNTH
STKNAME
LISPXPRIN2
BREAK1
(EVCC LIST2 KNIL KT ENTER2)           `      @   p        

ASSERTMAC BINARY
    9    /    7-.          /   03B   +   Z  1,<   Z   ,<   ,<  1,<p  Z  2,<   Z  2Z`  XCp  QEp  ,\   ,\  XB  Zp  /       ,\   XCp  QEp  ,\   ,~   ,<`  ,<   ,<   ,<   ,<   Zw~-,   +   +   +Z  XBp  -,   +   ,<  3,<   ,<  3Zw~3B   +   3B   +   -,   +   ,<  4,<   ,   ,   ,   +   "-,   +    ,<   B  4D  5+   ",<  5,<   ,   B  6XBwZw3B   +   ',<   Zw,   XBw~,\  QB  +   )Zw,   XBwXBw~[w~XBw~+   [w~3B   +   .Z  6Zw~,   +    Zw~+    
@  c%0WH       (ARGS . 1)
(VARIABLE-VALUE-CELL COMMENTFLG . 8)
IGNOREDECL
((NIL) . 0)
((NIL) . 0)
((NIL) . 0)
ASSERT
OR
ASSERTFAULT
QUOTE
TYPEBLOCKOF
MAKETESTFORM
27
ERRORX
PROGN
(URET5 CONS CONSNL SKLA ALIST3 ALIST2 LIST2 SKNNM KT SKLST SKNLST BHC KNIL ENTER1)   0 p   h    &                " @          P   (   @   H $               

\*DECL BINARY
               -.         Z`  3B   +   Z`  Z  Z  -,   +   Z`  +   Z`  Z   ,   ,<   @     ,~   Z  ,<   Zw~[8  ,<   ,<  &  ,~   
	 (ARGS . 1)
(VARIABLE-VALUE-CELL SATISFIESLIST . 14)
\DECLPROGN
INTERNAL
APPLY
(CONS SKLST KNIL ENTER1)                 

*DECLMAC BINARY
     ?    7    =-.          7Z   ,<   Z`  ,<   [`  [  3B   +   [`  Z  8,   +   [`  Z  ,<   ,<   Zw2B   +   Z   +   ZwZ  -,   Z   XBp  3B   +   Zw+   Zw,<   Zp  -,   +   +   Zp  ,<   [p  [  2B  9+   Zp  Zw},   XBw}/   [p  XBp  +   /   ,<  9Zw3B   +   Zw~+   Zw~Z   ,   3B   +   $3B   +   $-,   +   $,<  :,<   ,   ,   XBw,<  :,<   Zw}Z  2B  +   )Z   +   0Z   ,<  ;Zw}3B   +   /3B   +   /-,   +   /,<  :,<   ,   ,   ,   ,<   Zw~3B   +   4,<  ;   <,   ,   D  <,   ,<   ,<w~,   +    
@P0`PVTVd     (ARGS . 1)
(VARIABLE-VALUE-CELL FREEVARS . 77)
(VARIABLE-VALUE-CELL CSATISFIESLIST . 61)
PROGN
FREE
CSATISFIESLIST
QUOTE
.CBIND.
FREEVARS
COMPILEIGNOREDECL
IGNOREDECL
NCONC
(URET4 LIST3 CONSS1 CONSNL ALIST2 LIST2 SKNNM BHC CONS SKNLST SKLST KT CONS21 KNIL ENTER1) x   p   X   H 0    4   %    / H   X "                      ,   ! @    x     +    P  h           

\CHKINIT BINARY
             -.         ,<`  ,<   ,<   ,<   Zw~-,   +   +   Z  XBw,<   Z   D  [  Z  XBp  ,<   ,<w$  ,<   Zp  @   [ 2B   +   ,<p  "  /   ,<   ZwZ 7@  7   Z  ,<    "   ,   3B   +   +   ,<p  ,<w$  [w~XBw~+   Zw+     A    (ARGS . 1)
(VARIABLE-VALUE-CELL SATISFIESLIST . 14)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 24)
ASSOC
GETDECLTYPE
MAKETESTFN
ASSERTFAULT
(URET4 EVCC KNOB BHC SKNLST KNIL ENTER1)                        `   8        

CHKINITMAC BINARY
        E    :    C-.          :   <3B   +   Z  =,<   Z   ,<   Z  =,<   Z  >Z`  XCp  QEp  ,\       ,\   XCp  QEp  ,\   ,~   ,<`  ,<   ,<   ,<   ,<   ,<   ,<   Zw}-,   +   +   6Z  XBw,<  >,<   Z   D  ?[  Z  XBw,<   ,<w~$  ?,<   Zp  @   [ 2B   +   ,<p  "  @/   ,<   ,<w~$  @,<   ,<  AZw~-,   +   !Z  AZw~,   +   &Zw~3B   +   &3B   +   &-,   +   &,<  B,<   ,   ,<   Zw}3B   +   ,3B   +   ,-,   +   ,,<  B,<   ,   ,   ,   XBw~Zw~3B   +   2,<   Zw~,   XBw},\  QB  +   4Zw~,   XBw~XBw}[w}XBw}+   [w}3B   +   9Z  BZw},   +    Zw}+    
  H(S0+ @@    (ARGS . 1)
(VARIABLE-VALUE-CELL COMMENTFLG . 8)
(VARIABLE-VALUE-CELL CSATISFIESLIST . 38)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 48)
IGNOREDECL
((NIL) . 0)
((NIL) . 0)
\CHKINIT
OR
ASSOC
GETDECLTYPE
MAKETESTFN
APPLYFORM
ASSERTFAULT
DECLMSGMAC
QUOTE
PROGN
(URET7 CONSNL ALIST3 LIST2 SKNNM KT CONS SKLST BHC SKNLST KNIL ENTER1)  0 :    4    X -    , p   ( %    ) @    !                7 p ( 0  x  h  X   0      

DECLCONSTANTP BINARY
        5    ,    3-.           ,Z`  2B   +   Z   ,~   3B   7   7   +   ,Z`  -,   +   ,-,   +   ,-,   +   +Z`  3B  -+   2B  -+   Z   ,~   Z`  ,<   ,<  .$  .3B   +   ,<`  ,<   $  /+   Z`  ,<   Zp  Z`  3B  +   3B  /+   XB`  /   +   Z`  3B  0+   3B  0+   3B  1+   3B  1+   2B  2+   Z   +   *Z`  ,<   ,<  2$  .3B   +   *[`  ,<   Zp  -,   +   $Z   +   *Zp  ,<   ,<w$  32B   +   (Z   +   *[p  XBp  +   "/   /   ,~   Z   ,~   UpiKS!E$   (X . 1)
QUOTE
CONSTANT
MACRO
GETP
EXPANDMACRO
IGNOREMACRO
SELECTQ
CLOSER
GO
PROG
COND
CTYPE
DECLCONSTANTP
(SKNLST BHC SKLST SKNSTP SKNNM KT KNIL ENTER1)   #    + 0     	            $    X   @   H ( x ! `   `        

DD BINARY
      	        -.          Z`  ,<   [`  Z  ,   ,   ,   ,<   ,<   $  ,~      (X . 1)
DLAMBDA
DEFINE
(KT CONSNL ALIST2 CONS21 ENTER1)    h    X    P    H      

DECLCLISPTRAN BINARY
       /      *-.         ,<   ,<   ,<   ,<   ,<  Z` -,   +  Z`  -,   Z   Z  ,<   ,<  $ !Z  2B !+  Z` 2B "+   Z   XBwZ` XBw~3B   +  +   [` -,   Z   [  -,   Z   Z  XBw~Z  2B "+  [w~-,   Z   Z  XBw~Z  2B #+  Z   3B   +   +,< #,<w~$ $[  ,<   ,<   ,<   Zw-,   +    +   )Z  XBp  -,   +   'Zp  Zw~,   2B   +   'Zp  2B   +   &Z   XBw+   )[wXBw+   Zw/  3B   +  ,<w~Zw~3B   +   .Z $+   .Z %,\  XB  [w~[  ,<   Zw~3B   +   4[w~Z  +   4Z   ,<   ,<   ,<   Zw~-,   +   8+   qZ  XBp  Zp  3B #+   ;+   p[p  ,<   ,<   ,<   ,<   ,<   Zw~-,   +   @+   lZ  XBw-,   +   DZwZw{,   3B   +   GZwZp  ,   XBp  +   kZwz3B   +   e,<w|,<   ,<   ZwXBp  Zp  -,   +   M+   aZw}Zp  2B  +   T,<p  Zw,<   Z   [w|,   ,   ,\  XB  +   dZp  -,   +   `Zw}Zp  Z  2B  +   `Zp  [  -,   +   ]Zp  ,<   Zw[  ,   ,\  QB  Zp  ,<   [w}D %+   d[p  XBp  +   KZw}Zwx,   XBwxZw/  +   kZw2B &+   iZwZw{,   XBw{+   kZwZwy,   XBwy[w~XBw~+   >,<w},<w" &,\  QB  Zw~/  [w~XBw~+   6Zw/  Zw~3B   +   y[w~,<   ,<w}" &Z ',   [w~[  ,   D '@ (  +  Zw~Z?3B   +  ,< (B &,<   Zw~,<8 ,   ZwXB8 ,<   ,<   ,<   ,<   ,<   Z   L )ZwZ8 Z   ,   [  [  [  [  Z  ,<   Zw~,<8 ,<   Z F ),\   ZwXB8 ,~   ,<?~,<?~,<   ,<   ,<   Z L ),~   Zw~Z 
,   XBw~,<   ,<w~,<   Z F ),\   3B   +  Zw~Zw~    D  +  Z   XB` /  ,<`  ,<` $ *,~   H00I HpB@1  @X H#G    B      (X . 1)
(TRAN . 1)
(VARIABLE-VALUE-CELL NEWSATLIST . 50)
(VARIABLE-VALUE-CELL FAULTFN . 288)
(VARIABLE-VALUE-CELL CLISPARRAY . 298)
((LOCALVARS SPECVARS ADDTOVAR DEFLIST PUTPROPS CONSTANTS SETQQ USEDFREE) . 0)
CLISPWORD
GETPROP
FORWORD
PROG
FUNCTION
LAMBDA
DECLARE
ASSOC
DPROG
DLAMBDA
NCONC
RETURNS
DREVERSE
DECL
RPLACD
(NIL VARIABLE-VALUE-CELL CLISPRETRANFLG . 0)
DPROGN
DWIMIFY0?
PUTHASH
REALCLISPTRAN
(GETHSH LIST3 CONS21 CONSNL CONSS1 CONS BHC FMEMB SKNLST KT SKLST KNIL ENTER2)   8        w    ]    S    y 0 h 8 R h   @ s  e (   @ $    Z 	H ? x     ' P   
X B    (   p     x  x 8 ( | @ Q 	( J 	 D h > X = h 6 P 2 P + ` $ h  (  0  p   @   0        

DECLMSGA0010 BINARY
          	    -.          	Z   ,<   Z`  @   [  ,\  ,   3B   +   ,<  
Z`  @  [  D  ,~     (TB . 1)
(VARIABLE-VALUE-CELL DECLMSG . 3)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 14)
DECLMSG
RETFROM
(KNIL EQUAL ENTER1)   `    X      

DECLMSG BINARY
            -.         Z   Z   ,   3B   +   Z  ,~   Z  ,<   Z  D  Z  ,<   Z   D  2B   +   Z  Z  ,   XB  
Z  ,~   C
  (VARIABLE-VALUE-CELL DECLMSG . 20)
(VARIABLE-VALUE-CELL DECLTYPESARRAY . 10)
(VARIABLE-VALUE-CELL DECLMESSAGES . 23)
DECLMSGA0010
MAPHASH
MEMBER
(CONS KNIL GETHSH ENTERF)       
  @    8      

DECLDWIMERROR BINARY
        !         -.         ,<   "  ,<  ,<   $  Z   ,<   ,<   $  ,<  ,<   $  .   .   ,<8  ,<   ,<   Z"   XBp   p  ,>  ,>    w    ,^   /   3b  +   Zw+    p  ."`  Z  2B   +   ,<   "  +    p  ."`  Z  ,<   ,<   $   p  ."   ,   XBp  +   /  ,<   "      ,~      F@,&  (ARGS . 1)
(VARIABLE-VALUE-CELL FAULTFN . 8)
LISPXTERPRI
"{in "
LISPXPRIN1
"} "
ERROR!
(MKN BHC ASZ KNIL CF CFARP KT ENTERN)        p   0   ( 
    	         x  0   `   (      

DECLDWIMTESTFN BINARY
               -.           Z`  @   [ 2B   +   ,<`  "  ,<   Zp  -,   +   Z   2B   +   Zp  Z   ,   2B   +   ,<p  ,<w,<   ,<   ,<   Z   L  Zp  Z  	,   2B   +   ,<p  ,<wZ  F  Zp  +    Q@B     (TB . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 4)
(VARIABLE-VALUE-CELL CLISPRETRANFLG . 14)
(VARIABLE-VALUE-CELL CLISPARRAY . 36)
(VARIABLE-VALUE-CELL FAULTFN . 27)
MAKETESTFN
DWIMIFY0?
PUTHASH
(URET1 GETHSH SKLST KNIL ENTER1)   H    
         `  P          

DECLSET BINARY
              -.           ,<`  "  ,<   ,<  Zp  Z`  XD  [  ,<   ,<  [p  Z` XD  Zp  /   ,\  XB  Zp  /   D  ,<   ,<`  "  ,\   ,~    $ (VAR . 1)
(VAL . 1)
VARSETFN
((NIL NIL) . 0)
((QUOTE Q) . 0)
APPLY
\VARASRT
(BHC ENTER2) 8 	       

DECLSETQ BINARY
             -.          Z  ,<   [`  ,<   ,<  &  ,<   Z`  B  ,<   ,<  Zp  Z`  XD  [  ,<   ,<  [p  Zw~XD  Zp  /   ,\  XB  Zp  /   ,<   ,<  &  ,<   Z`  B  ,\   /   ,~   e      (U . 1)
PROG1
INTERNAL
APPLY
VARSETFN
((NIL NIL) . 0)
((QUOTE Q) . 0)
\VARASRT
(BHC ENTER1)  0  P      

DECLSETQQ BINARY
       
        
-.           Z  	,<   ,<`  ,<  	[p  Z` XD  Zp  /   ,<    "  ,   ,~       (XSET . 1)
(YSET . 1)
DECLSETQ
((QUOTE Q) . 0)
(EVCC BHC ENTER2)        h      

DLAMARGLIST BINARY
             -.           [`  Z  -,   +   [`  Z  ,<   ,<   ,<   ,<   Zw~-,   +   	Zw+    Zw~,<   Zp  -,   Z   Z  3B  +   Zp  -,   +   Zp  +   ,   +   Z   /   XBp  -,   +   Zw3B   +   Zp  QD  +   Zp  XBw       [  2D   +   XBw[w~XBw~+   [`  Z  ,~     T$@D  (DEF . 1)
RETURNS
(BHC CONSNL URET4 SKNLST KNIL SKLST ENTER1)                      p   `   0  8        

DTYPE?TRAN BINARY
        )         (-.           Z   XB   Z   3B   +   ,<`  ,<  "$  #[`  Z  B  #,<   [`  [  ,<   ,<   Zw2B   +   ,<  $[`  Z  D  $,<w,<`  ,<   ,<   ,<   Z   L  %[w3B   +   Z  %Zw,   +   ZwXBw,<w"  &,<   ,<w$  &XBp  ,<`  3B   +   +   Zw-,   +   ,<  %,<   ,<   ,   +   Z  'D  '/  Z`  ,~   Y dHHf      (FORM . 1)
(VARIABLE-VALUE-CELL CLISPCHANGE . 4)
(VARIABLE-VALUE-CELL LCASEFLG . 5)
(VARIABLE-VALUE-CELL FAULTFN . 31)
type?
/RPLACA
GETDECLTYPE.NOERROR
"invalid type declaration: "
DECLDWIMERROR
DWIMIFY0?
PROGN
DECLDWIMTESTFN
APPLYFORM
((PROGN T) . 0)
REALCLISPTRAN
(BHC LIST3 SKLST CONS KNIL KT ENTER1)      `   8   @      x  0 
  @   X   (      

EDITNEWSATLIST BINARY
               -.           [   ,<   Zp  -,   +   Z   +    Zp  ,<   ,<w/   Zp  -,   +   Zp  XBp  -,   +   Zp  XBp  -,   +   Zp  Z   ,   2B   +   ,<p  ,<  $  Z  2B  7   Z   +   Z   /   3B   +   Z   +    [p  XBp  +   @-"   (VARIABLE-VALUE-CELL L . 3)
(VARIABLE-VALUE-CELL DECLATOMS . 26)
CLISPWORD
GETPROP
FORWORD
(KNIL FMEMB SKLA SKNLA SKLST BHC URET1 KT SKNLST ENTER0)   P  (             
          x   h       P    @      

FORMUSESTB BINARY
      "        !-.          Z`  -,   +   Z`  Z  ,   2B   +   Z   -,   +   Z  3B  7   7   +   Z`  -,   Z   Z  ,<   ,<  $  -,   Z   Z  2B  +   Z  B   Z  XB  -,   Z   Z  2B   +   [  -,   Z   Z  -,   Z   Z  2B  7   Z   ,~   Z   ,~   Z   ,~   I$4   (FORM . 1)
(TRANS . 1)
(TB . 1)
(VARIABLE-VALUE-CELL TRAN . 40)
((type? TYPE? the THE DLAMBDA DPROG DPROGN) . 0)
\*DECL
CLISPWORD
GETP
FORWORD
LAST
RETURN
(KT KNIL FMEMB SKLST ENTER3)   	     (  x  0  8 	  X    P   p  (  0   0      

IGNOREDECL BINARY
              -.           Z   3B   7   7   +   Z  -,   +   
,<  ,<  $  ,<   Z  D  3B   +   
Z   ,~   Z   ,~   O  (VARIABLE-VALUE-CELL COMPILEIGNOREDECL . 15)
FN
COMPILE1
EVALV
MEMB
(SKLST KNIL KT ENTER0)  X   8 	  @   (   0      

MAKETESTFORM BINARY
    1    )    0-.          )Z` @   [ 2B   +   ,<` "  +,<   ,<`  $  +,<   Zp  2B   +   Z  ,,<   Z   ,<   ,<  ,,<p  ,<  -Zp  Z  -XD  [  Z`  XD  Zp  /   ,\  XB  Zp  /       ,\   XCp  QEp  ,\   +   (,<  .,<   ,<  .Z` @  [  ,<   Zp  -,   +   Z  /Zp  ,   +   !Zp  3B   +   !3B   +   !-,   +   !,<  /,<   ,   /   ,<   Z`  3B   +   '3B   +   '-,   +   ',<  /,<   ,   ,   ,   /   ,~   RT  2+X    (VAR . 1)
(TYPE . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 46)
(VARIABLE-VALUE-CELL COMMENTFLG . 19)
MAKETESTFN
APPLYFORM
((NIL) . 0)
((NIL) . 0)
((NIL NIL) . 0)
ASSERT
OR
ASSERTFAULT
DECLMSGMAC
QUOTE
(ALIST3 LIST2 SKNNM CONS SKLST BHC KT KNIL ENTER2)   (    '    X             )       H     8   @      

SETQMAC BINARY
    N    >    K-.          >Z`  B  ?,<   ,<   Zw@   Z  2B   +   ,<w"  @Z`  ,   XBp     @2B   +   9Zw@  Z  Z  3B  A+   9Zw@  
Z  2B   +   ,<w"  @2B  A+   0[`  Z  B  B3B   +   0Zw@  [ 2B   +   ,<w"  B,<   @  C  +   /,<`  "  D2B   +   ,<`  "  E2B   +   .,<  E,<   ,<   @  F ` +   ,Z   Z  GXB Zw~,<8  Zw~[8  Z  B  H,<    "   ,   Zw~XB8 2B   +   +,<  HZ  IZw~Z8  ,   D  IZ   ,~   3B   +   .Z` ,~   Z   ,~   2B   +   9,<wZw@  Z  2B   +   4,<w"  @2B  A+   6Zw+   7[`  Z  B  ?D  J3B   +   :Zp  +    ,<  J,<wZ`  ,<   ,<w~$  K,   +    
(*U2P 8DM@       (ARGS . 1)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 99)
TYPEBLOCKOF
MAKESETFN
IGNOREDECL
ANY
REALSETQ
DECLCONSTANTP
MAKETESTFN
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL HELPFLAG . 0)
SUBRP
FREEVARS
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
EVAL
" Warning: Probable type fault in"
SETQ
COMPEM
COVERSTB
PROG1
MAKETESTFORM
(ALIST3 URET2 KT EVCC CF CONS KNIL ENTER1)  h   p ;    ,    '    !    +     3  / X ( x  X  h  x 
  `        

THETRAN BINARY
      @    3    >-.          3Z   XB   Z   3B   +   ,<`  ,<  5$  6[`  Z  B  6,<   Zp  2B   +   ,<  7[`  Z  D  7[`  [  ,<   ,<`  [`  [  ,<   ,<   ,<   Z   L  8,<p  "  8,<   ,<  9$  9,<   [`  [  [  3B   +   Z  :[`  [  ,   +   [`  [  Z  ,<   ,<`  Zw2B   +   Zw+   1,<  :,<  ;,<  ;,<  <,<   ,<  9,   ,<   ,<   ,<  <,<  9[`  Z  -,   +   'Z  =[`  Z  ,   +   -[`  Z  3B   +   -3B   +   --,   +   -,<  =,<   ,   ,   ,   ,   ,   ,<   ,<w~$  9,   D  >/  /   Z`  ,~   Y@`b>F1
`
      (FORM . 1)
(VARIABLE-VALUE-CELL CLISPCHANGE . 4)
(VARIABLE-VALUE-CELL LCASEFLG . 5)
(VARIABLE-VALUE-CELL FAULTFN . 31)
the
/RPLACA
GETDECLTYPE.NOERROR
"invalid type declaration: "
DECLDWIMERROR
DWIMIFY0?
DECLDWIMTESTFN
VALUE
APPLYFORM
PROGN
\CHKVAL
LAMBDA
((VALUE) . 0)
COND
VALUEERROR
DECLMSGMAC
QUOTE
REALCLISPTRAN
(BHC ALIST2 ALIST3 SKNNM SKLST LIST2 CONS KNIL KT ENTER1)   3 (    .    / p .    +    %    -    x     ) `  x 	  @   ( " H        

VALUEERROR BINARY
                -.           ,<  ,<   $  ,<   ,<   ,<  Zw2B   +   Z  ,<   ,<   ,<w~(  XBp  B  -,   +   +   ,<p  "  ,<   ,<   $  ,<p  "  +   +   Zw/  Z  ,<   ,<  ,<   ,<  ,<` ,   ,<   ,<   "  ,   ,~   &Rr"    (VARIABLE-VALUE-CELL VALUE . 0)
(DECL . 1)
"
VALUE ASSERTION NOT SATISFIED IN "
LISPXPRIN1
-1
VALUEERROR
REALSTKNTH
STKNAME
LISPXPRIN2
RELSTK
BREAK1
VALUE
((EVAL) . 0)
(EVCC LIST2 BHC SKNLA KNIL KT ENTERF)  h   H      (       H      X        

VARSETFN BINARY
             -.          Z   ,<   ,<   ,<   ,<   ,<   Zw~-,   +   +   Z  XBw,<`  D  XBp  2B   +   
+   [p  XBp  2B   +   Z  +   Zp  ,<   ,<`  $  ,<   Zp  @   Z  2B   +   ,<p  "  /   +    [w~XBw~+   Z  +    P`   (VARNAME . 1)
(VARIABLE-VALUE-CELL SATISFIESLIST . 3)
(VARIABLE-VALUE-CELL TYPEBLOCKDATATYPE . 33)
ASSOC
ANY
GETDECLTYPE
MAKESETFN
REALSETQ
(URET5 BHC SKNLST KNIL ENTER1)  x              H 
  P   @        

STARTDECLS BINARY
        \    I    Y-.          ( I,<  KZp  -,   +   +   Zp  ,<   ,<  L,<w$  L/   [p  XBp  +   /   ,<  MZp  -,   +   +   Zp  ,<   ,<  M,<w$  L/   [p  XBp  +   	/   ,<  NZp  -,   +   +   Zp  ,<   ,<p  ,<  N,<w$  OD  L3B   +   Zp  Z   ,   3B   +   ,<  N,<w$  OZ   ,   XB  /   [p  XBp  +   /   ,<  O,<  P$  P,<   Zp  3B   +   %,<  Q,<  PF  Q+   &,<  Q,<  P$  R/   ,<  R,<  S$  P,<   Zp  3B   +   ,,<  S,<  SF  Q+   .,<  S,<  S$  R/   ,<  TZp  -,   +   8Zp  Z 7@  7   Z  2B  T+   7,<p  ,<   Z   F  UB  U3B   +   8Z   +   9Z   /   3B   +   >Z   ,<   ,<  V,<  V&  W3B  V+   >   W,<  XZp  -,   +   A+   GZp  ,<   Zp  ,<   [w,<   Z   F  X/   [p  XBp  +   ?/   ,<   "  Y,~   Je
bh4c}c~HT'y@"@    (VARIABLE-VALUE-CELL SYSLINKEDFNS . 48)
(VARIABLE-VALUE-CELL LINKEDFNS . 57)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 106)
(VARIABLE-VALUE-CELL DWIMWAIT . 117)
(VARIABLE-VALUE-CELL MSTEMPLATES . 136)
((DECL WHOSE) . 0)
QUOTE
MOVD?
((\CHKVAL \DECLPROGN) . 0)
PROGN
((CHANGERECORD CLISPTRAN SETQ SET SETQQ) . 0)
REAL
PACK*
SETQ
BYTEMACRO
GETPROP
REALSETQ
PUTPROP
REMPROP
SET
MACRO
REALSET
DECLTYPESARRAY
NOBIND
STKSCAN
RELSTK
N
"Reinitialize DECLTYPE lattice?  "
ASKUSER
INITDECLTYPES
(((COVERS CALL (IF (EQ (CAR EXPR) (QUOTE QUOTE)) (NIL (@ (TYPEMSANAL COVERS) (QUOTE ((.. TYPE))))) 
EVAL) (IF (EQ (CAR EXPR) (QUOTE QUOTE)) (NIL (@ (TYPEMSANAL COVERS) (QUOTE ((.. TYPE))))) EVAL) . PPE)
 (SELCOVERSQ . MACRO) (SELTYPEQ . MACRO) (\*DECL NIL (IF NULL NIL (IF (LISTP (CAAR EXPR)) ((.. (@ (
TYPEMSANAL \*DECL) (QUOTE ((.. TYPE) TEST))))) (.. (@ (TYPEMSANAL \*DECL) (QUOTE ((.. TYPE) TEST))))))
 .. EFFECT RETURN) (\CHKINIT NIL) (\CHKVAL NIL EVAL) (THE @ (TYPEMSANAL the) (QUOTE (CLISP (.. TYPE) 
RETURN))) (TYPE? @ (TYPEMSANAL type?) (QUOTE (CLISP (.. TYPE) RETURN))) (the @ (TYPEMSANAL the) (QUOTE
 (CLISP (.. TYPE) RETURN))) (type? @ (TYPEMSANAL type?) (QUOTE (CLISP (.. TYPE) RETURN))) (VALUEERROR 
NIL)) . 0)
PUTHASH
DODECLS
(KT KNOB SKLA CONS FMEMB KNIL BHC SKNLST ENTER0)   H    0      P      ( 9 x 5 ( #       H ` : p '           @ (   8      

DODECLS BINARY
    _    V    \-.          VZ`  2B   +   7   Z   XB   ,<  W,<  XZ`  3B   +   .Zp  2B   +   .,<p  ,<w,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   -Zw,<   Zp  ,<   ZwB  X,<   [w[  ,<   ,<   ,<   ,<   Zw~-,   +   Zw+   (,<   Zp  ,<   Zw|,<   ZwD  Y,   /   XBp  -,   +   &Zw3B   +   "Zp  QD  +   #Zp  XBw       [  2D   +   $XBw[w~[  XBw~+   /  ,   ,   /   Zp  ,   XBp  [wXBw+   
/  D  YZ`  3B   +   1Zw+   1Zp  ,<   Zp  -,   +   4+   QZp  ,<   [p  Z  ,<   Zp  3B   +   ?Zw,<   Z`  3B   +   >Zw2B   +   >,<  ZZw~D  ZB  X+   ?ZwD  [/   [p  [  ,<   Zp  -,   +   C+   O,<   [p  Z  ,<   Zp  3B   +   JZw~,<   Zw,<   ,<w&  [+   LZw~,<   ZwD  \/   /   [p  [  XBp  +   A/  [p  XBp  +   2/   Z`  2B   +   U,<p  ,<   $  Y/  Z`  ,~   "D@B$ &t D$      (FLG . 1)
(VARIABLE-VALUE-CELL COMPILEIGNOREDECL . 8)
(((CHANGERECORD T) (CLISPTRAN T) (SET T) (SETQ T BYTEMACRO NIL MACRO (ARGS (SETQMAC ARGS))) (SETQQ T) 
(TYPE? NIL CLISPWORD (DTYPE?TRAN . type?)) (type? NIL CLISPWORD (DTYPE?TRAN . type?))) . 0)
((NIL) . 0)
GETD
GETPROP
RPLACA
DECL
PACK*
PUTD
PUTPROP
REMPROP
(COLLCT CONSS1 SKLST BHC ALIST2 SKNLST KT KNIL ENTER1) @   ( *        V 
( P 	` M  . 0 ) h   `   0 3      <  @   
P S p :   0 ` ! x  h  P 
    H        
(PRETTYCOMPRINT DECLCOMS)
(RPAQQ DECLCOMS ((* DECLTYPE machinery, declaration translator, and declaration enforcer) (LOCALVARS .
 T) (GLOBALVARS FILEPKGFLG CLISPCHANGE CLISPARRAY DWIMESSGAG NOSPELLFLG MSDATABASELST DECLTYPESARRAY 
COMMENTFLG CLISPCHARS DECLATOMS LCASEFLG DECLMESSAGES CLISPRETRANFLG) (E (RESETSAVE CLISPIFYPRETTYFLG 
NIL) (RESETSAVE PRETTYPRINTMACROS (APPEND (QUOTE ((DECL . QUOTE) (DPROGN . QUOTE) (DLAMBDA . QUOTE) (
DPROG . QUOTE))) PRETTYPRINTMACROS))) (COMS (* Interface to file package) (FNS DECLTYPE DECLTYPES 
DUMPDECLTYPES GETDECLDEF) (FILEPKGCOMS DECLTYPES IGNOREDECL) (PROP ARGNAMES DECLTYPE)) (* User 
functions) (FNS COVERS GETDECLTYPEPROP SETDECLTYPEPROP SUBTYPES SUPERTYPES) (MACROS SELCOVERSQ 
SELTYPEQ) (ALISTS (PRETTYEQUIVLST SELCOVERSQ SELTYPEQ) (DWIMEQUIVLST SELCOVERSQ SELTYPEQ)) (P (
SETSYNONYM (QUOTE (THE TYPE)) (QUOTE (AS A TYPE)))) (* Internal machinery) (DECLARE: DONTCOPY (RECORDS
 TYPEBLOCK TYPEDEF) (ALISTS (PRETTYPRINTYPEMACROS TYPEBLOCK))) (INITRECORDS TYPEBLOCK) (P (DEFPRINT (
QUOTE TYPEBLOCK) (QUOTE TBDEFPRINT))) (FNS CHECKTYPEXP COLLECTTYPES COVERSCTYPE COVERSTB COVERSTE 
CREATEFNPROP CREATEFNVAL DECLERROR DELETETB FINDDECLTYPE FINDPROP FINDTYPEXP GETCTYPE GETDECLTYPE 
GETDECLTYPE.NOERROR GETTBPROP INHERITPROP INITDECLTYPES LCCTYPE LCC2 MAKECTYPE MAKEDECLTYPE MAKEBINDFN
 MAKESETFN MAPTYPEUSERS NOTICETB PPDTYPE RECDTYPE DECLCHANGERECORD RECDEFTYPE REPROPTB SETTBPROP 
TBDEFPRINT TETYPE TYPEMSANAL TYPEMSANAL1 UNCOMPLETE UNSAVETYPE USERDECLTYPE USESTYPE) (BLOCKS (LCCTYPE
 LCCTYPE LCC2) (TYPEMSANAL TYPEMSANAL TYPEMSANAL1)) (* Test fn creation block) (FNS MAKETESTFN 
MAKETESTFNBLOCK COMBINE.TESTS FUNIFY MKNTHCAR MKNTHCDR OF.TESTFN TUPLE.TESTFN WHOSE.TESTFN) (BLOCKS (
MAKETESTFNBLOCK MAKETESTFNBLOCK COMBINE.TESTS FUNIFY MKNTHCAR MKNTHCDR OF.TESTFN TUPLE.TESTFN 
WHOSE.TESTFN)) (* Machinery to compile recursive testfns) (FILES (SYSLOAD FROM VALUEOF 
LISPUSERSDIRECTORIES) LABEL) (* Idioms. Expressed as macros for now) (DECLARE: DONTCOPY EVAL@COMPILE (
VARS DefaultBindFn DefaultSetFn) (ADDVARS (NLAMA MAKEDECLTYPEQ)) (MACROS ANYC DECLVARERROR DTYPENAME 
foreachTB GETCGETD KWOTEBOX LAMBIND LAMVAL MAKEDECLTYPEQ NONEC TESTFORM) (FNS TESTFORM) (ADDVARS (
DONTCOMPILEFNS TESTFORM)) (TEMPLATES foreachTB MAKEDECLTYPEQ)) (* Runtime utility functions) (FNS 
EVERYCHAR LARGEP DECLRECURSING SMASHCAR) (DECLARE: EVAL@COMPILE (MACROS LARGEP)) (DECLARE: DONTCOPY 
EVAL@COMPILE (MACROS SMASHCAR)) (* translator of dprogs and dlambdas) (FNS ASSERT ASSERTFAULT 
ASSERTMAC \*DECL *DECLMAC \CHKINIT CHKINITMAC DECLCONSTANTP DD DECLCLISPTRAN DECLMSG DECLDWIMERROR 
DECLDWIMTESTFN DECLSET DECLSETQ DECLSETQQ DECLTRAN DECLVAR DLAMARGLIST DTYPE?TRAN EDITNEWSATLIST 
FORMUSESTB IGNOREDECL MAKETESTFORM PPDECL PPVARLIST SETQMAC THETRAN VALUEERROR \VARASRT VARASRT1 
VARSETFN) (BLOCKS (DECLTRAN DECLTRAN DECLVAR) (PPDECL PPDECL PPVARLIST) (\VARASRT \VARASRT VARASRT1)) 
(* Declaration database fns) (FNS DECLOF DECLOF1 TBOF TYPEBLOCKOF VARDECL) (BLOCKS (DECLOFBLK DECLOF 
DECLOF1 TBOF TYPEBLOCKOF VARDECL (ENTRIES DECLOF TYPEBLOCKOF))) (* Enabling and disabling fns) (
DECLARE: EVAL@COMPILE DONTCOPY (RECORDS FNEQUIVS) (MACROS MOVEPROP PUTIFPROP)) (FNS STARTDECLS DODECLS
) (FILES (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) LAMBDATRAN) (DECLARE: EVAL@COMPILE (FILES (
SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) SIMPLIFY)) (DECLARE: EVAL@COMPILE DONTCOPY (FILES (SYSLOAD 
FROM VALUEOF LISPUSERSDIRECTORIES) NOBOX) (* Definition of WITH. From <SHEIL>WITH.) (MACROS WITH) (
TEMPLATES WITH) (P (REMPROP (QUOTE WITH) (QUOTE CLISPWORD)) (ADDTOVAR DWIMEQUIVLST (WITH . PROG)) (
ADDTOVAR PRETTYEQUIVLST (WITH . PROG)))) (P (OR (GETPROP (QUOTE LOADTIMECONSTANT) (QUOTE FILEDATES)) (
PROG ((X (FINDFILE (QUOTE LOADTIMECONSTANT.COM) T LISPUSERSDIRECTORIES))) (COND (X (LOAD X (QUOTE 
SYSLOAD))) ((NOT (GETPROP (QUOTE LOADTIMECONSTANT) (QUOTE MACRO))) (PUTPROP (QUOTE LOADTIMECONSTANT) (
QUOTE MACRO) (QUOTE ((FORM) (CONSTANT FORM))))))))) (ADDVARS (OPENFNS \DECLPROGN \CHKVAL \CHKINIT 
ASSERT \*DECL \VARASRT)) (PROP CLISPWORD DPROG DPROGN THE the) (PROP INFO DLAMBDA DPROG DPROGN) (VARS 
(SATISFIESLIST) (CSATISFIESLIST) (NEWSATLIST T)) (INITVARS (DECLMESSAGES) (COMPILEIGNOREDECL)) (
ADDVARS (DECLATOMS DLAMBDA DPROG DPROGN) (LAMBDASPLST DLAMBDA) (SYSLOCALVARS VALUE) (DESCRIBELST (
"types:    " (GETRELATION FN (QUOTE (USE TYPE))))) (BAKTRACELST (\DECLPROGN (DPROGN APPLY *PROG*LAM 
\*DECL *ENV*) (NIL APPLY *PROG*LAM \*DECL)) (PROG (DPROG \DECLPROGN APPLY *PROG*LAM \*DECL)))) (
DECLARE: EVAL@COMPILE DONTCOPY (RECORDS SLISTENTRY VARDECL)) (ALISTS (LAMBDATRANFNS DLAMBDA)) (
DECLARE: DONTEVAL@LOAD (E (* Declare is so PRETTYPRINTMACROS don't get set up during LOADFROM, when 
PPDECL is not being defined. Don't use ALIST for print macros cause entries are removed while DECL is 
being dumped)) (ADDVARS (PRETTYPRINTMACROS (DPROGN . PPDECL) (DECL . PPDECL) (DLAMBDA . PPDECL) (DPROG
 . PPDECL)))) (PROP INFO ASSERT) (MACROS ASSERT .CBIND. \CHKINIT \CHKVAL \*DECL DECL DECLMSGMAC 
REALSETQ) (MACROS REALSET) (P (AND (GETD (QUOTE STARTDECLS)) (STARTDECLS)) (PROG ((COM (CDR (ASSOC (
QUOTE DW) EDITMACROS)))) (AND COM (RPLACD COM (CONS (APPEND (QUOTE (RESETVAR NEWSATLIST (
EDITNEWSATLIST))) (CDR COM))))))) (* Builtin DECLOF properties) (PROP DECLOF APPEND CONS EQ LIST LISTP
 NCONC) (DECLARE: EVAL@COMPILE DONTCOPY (P (RESETSAVE DWIMIFYCOMPFLG NIL) (AND (GETD (QUOTE DODECLS)) 
(RESETSAVE (DODECLS) (QUOTE (DODECLS T)))))) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY 
COMPILERVARS (ADDVARS (NLAMA DECLSETQ DECLMSG DD \CHKINIT \*DECL ASSERT DECLTYPES DECLTYPE) (NLAML 
DECLSETQQ TYPEMSANAL) (LAMA DECLDWIMERROR)))))
(PUTDEF (QUOTE DECLTYPES) (QUOTE FILEPKGCOMS) (QUOTE ((COM MACRO (X (E (DUMPDECLTYPES (QUOTE X))))) (
TYPE DESCRIPTION "type declarations" GETDEF GETDECLDEF DELDEF (LAMBDA (NAME) (DELETETB (OR (
FINDDECLTYPE NAME) (DECLERROR "Can't delete non-existent type:" NAME))))))))
(PUTDEF (QUOTE IGNOREDECL) (QUOTE FILEPKGCOMS) (QUOTE ((COM MACRO (X (DECLARE: DOEVAL@COMPILE 
DONTEVAL@LOAD DONTCOPY (P (RESETSAVE COMPILEIGNOREDECL (QUOTE X)))))))))
(PUTPROPS DECLTYPE ARGNAMES (NIL (NAME TYPE PROP1 VAL1 ...) . X))
(PUTPROPS SELCOVERSQ MACRO (F (LIST (LIST (QUOTE LAMBDA) (QUOTE ($$TMP)) (CONS (QUOTE COND) (MAPLIST (
CDR F) (FUNCTION (LAMBDA (I) (COND ((CDR I) (CONS (LIST (QUOTE COVERS) (KWOTE (CAAR I)) (QUOTE $$TMP))
 (CDAR I))) (T (LIST T (CAR I))))))))) (LIST (QUOTE DECLOF) (CAR F)))))
(PUTPROPS SELTYPEQ MACRO (F (APPLYFORM (LIST (QUOTE LAMBDA) (QUOTE ($$TMP)) (CONS (QUOTE COND) (
MAPLIST (CDR F) (FUNCTION (LAMBDA (I) (COND ((CDR I) (CONS (LIST (QUOTE TYPE?) (CAAR I) (QUOTE $$TMP))
 (CDAR I))) (T (LIST T (CAR I))))))))) (CAR F))))
(ADDTOVAR PRETTYEQUIVLST (SELCOVERSQ . SELECTQ) (SELTYPEQ . SELECTQ))
(ADDTOVAR DWIMEQUIVLST (SELCOVERSQ . SELECTQ) (SELTYPEQ . SELECTQ))
(SETSYNONYM (QUOTE (THE TYPE)) (QUOTE (AS A TYPE)))
(/DECLAREDATATYPE (QUOTE TYPEBLOCK) (QUOTE (POINTER POINTER POINTER POINTER POINTER POINTER)))
(DEFPRINT (QUOTE TYPEBLOCK) (QUOTE TBDEFPRINT))
(FILESLOAD (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) LABEL)
(DECLARE: EVAL@COMPILE (PUTPROPS LARGEP 10MACRO ((X) (EQ (NTYP X) 18))))
(FILESLOAD (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) LAMBDATRAN)
(FILESLOAD (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) SIMPLIFY)
(OR (GETPROP (QUOTE LOADTIMECONSTANT) (QUOTE FILEDATES)) (PROG ((X (FINDFILE (QUOTE 
LOADTIMECONSTANT.COM) T LISPUSERSDIRECTORIES))) (COND (X (LOAD X (QUOTE SYSLOAD))) ((NOT (GETPROP (
QUOTE LOADTIMECONSTANT) (QUOTE MACRO))) (PUTPROP (QUOTE LOADTIMECONSTANT) (QUOTE MACRO) (QUOTE ((FORM)
 (CONSTANT FORM))))))))
(ADDTOVAR OPENFNS \DECLPROGN \CHKVAL \CHKINIT ASSERT \*DECL \VARASRT)
(PUTPROPS DPROG CLISPWORD (DECLTRAN . DPROG))
(PUTPROPS DPROGN CLISPWORD (DECLTRAN . DPROGN))
(PUTPROPS THE CLISPWORD (THETRAN . the))
(PUTPROPS the CLISPWORD (THETRAN . the))
(PUTPROPS DLAMBDA INFO BINDS)
(PUTPROPS DPROG INFO (BINDS LABELS))
(PUTPROPS DPROGN INFO EVAL)
(RPAQQ SATISFIESLIST NIL)
(RPAQQ CSATISFIESLIST NIL)
(RPAQQ NEWSATLIST T)
(RPAQ? DECLMESSAGES)
(RPAQ? COMPILEIGNOREDECL)
(ADDTOVAR DECLATOMS DLAMBDA DPROG DPROGN)
(ADDTOVAR LAMBDASPLST DLAMBDA)
(ADDTOVAR SYSLOCALVARS VALUE)
(ADDTOVAR DESCRIBELST ("types:    " (GETRELATION FN (QUOTE (USE TYPE)))))
(ADDTOVAR BAKTRACELST (\DECLPROGN (DPROGN APPLY *PROG*LAM \*DECL *ENV*) (NIL APPLY *PROG*LAM \*DECL)) 
(PROG (DPROG \DECLPROGN APPLY *PROG*LAM \*DECL)))
(ADDTOVAR LAMBDATRANFNS (DLAMBDA DECLTRAN EXPR DLAMARGLIST))
(ADDTOVAR PRETTYPRINTMACROS (DPROGN . PPDECL) (DECL . PPDECL) (DLAMBDA . PPDECL) (DPROG . PPDECL))
(PUTPROPS ASSERT INFO EVAL)
(PUTPROPS ASSERT MACRO (ARGS (ASSERTMAC ARGS)))
(PUTPROPS .CBIND. BYTEMACRO (APPLY (LAMBDA (PV BODY) (APPLY* (QUOTE PROG) PV (QUOTE (RETURN (COMP.EXP1
 BODY)))))))
(PUTPROPS .CBIND. 10MACRO (X (APPLY* (QUOTE PROG) (CAR X) (QUOTE (COMP (CADR X) VCF PCF PIF NCF))) (
SETQ PCF (SETQ NCF)) (QUOTE INSTRUCTIONS)))
(PUTPROPS .CBIND. MACRO (X (HELP "Compiler dependent macro must be supplied for .CBIND.")))
(PUTPROPS \CHKINIT MACRO (ARGS (CHKINITMAC ARGS)))
(PUTPROPS \CHKVAL MACRO (ARGS (COND ((IGNOREDECL) (COND ((EQ (CAAR ARGS) (QUOTE COND)) (CADADR (CAR 
ARGS))) (T (CADAR ARGS)))) (T (CAR ARGS)))))
(PUTPROPS \*DECL MACRO (ARGS (*DECLMAC ARGS)))
(PUTPROPS DECL MACRO (X (COMPEM "DECL in illegal location" (CONS (QUOTE DECL) X))))
(PUTPROPS DECLMSGMAC DMACRO ((X . Y) (CONSTANT (DECLMSG X . Y))))
(PUTPROPS DECLMSGMAC MACRO ((X . Y) (LOADTIMECONSTANT (DECLMSG X . Y))))
(PUTPROPS REALSETQ MACRO (X (CEXP (CADR X)) (VARCOMP (CAR X)) (STORIN (LIST (QUOTE STV) (CAR X) SP)) (
QUOTE INSTRUCTIONS)))
(PUTPROPS REALSET DMACRO T)
(AND (GETD (QUOTE STARTDECLS)) (STARTDECLS))
(PROG ((COM (CDR (ASSOC (QUOTE DW) EDITMACROS)))) (AND COM (RPLACD COM (CONS (APPEND (QUOTE (RESETVAR 
NEWSATLIST (EDITNEWSATLIST))) (CDR COM))))))
(PUTPROPS APPEND DECLOF LST)
(PUTPROPS CONS DECLOF LISTP)
(PUTPROPS EQ DECLOF (MEMQ T NIL))
(PUTPROPS LIST DECLOF (FUNCTION (LAMBDA (FORM) (AND (CDR FORM) (QUOTE LISTP)))))
(PUTPROPS LISTP DECLOF LST)
(PUTPROPS NCONC DECLOF LST)
(PUTPROPS DECL COPYRIGHT ("Xerox Corporation" 1983))
NIL
