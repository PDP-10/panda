(FILECREATED "18-Aug-84 14:42:40" ("compiled on " <NEWLISP>MACHINEDEPENDENT..164) (2 . 2) brecompiled changes: nothing in 
"INTERLISP-10  16-Aug-84 ..." dated "16-Aug-84 01:11:38")
(FILECREATED "18-Aug-84 14:42:20" <NEWLISP>MACHINEDEPENDENT..164 60229 changes to: (VARS MACHINEDEPENDENTCOMS SORTCOMS FILENAMECOMS 
PRINTNUMCOMS WAITFORINPUTCOMS) (MACROS CCONS CLIST UNPACKFILE1 UNPACKFILE2 WAITN WAITFILE) previous date: "17-Aug-84 23:37:05" 
<NEWLISP>MACHINEDEPENDENT..163)
(MOVD? (QUOTE FLTFMT) (QUOTE OLDFLTFMT))
RESETRESTORE BINARY
       ,    %    +-.          %@  &  ,~   Z   3B   +   $,<   Z   D  '2B   +   $Z  XB   [  XB  Z  -,   +   [  	3B   +   [  
Z  +   Z  [  Z  XB   Z  Z  ,<   Z  [  D  (+   [  Z  -,   +   !Z   2B  (+   +   3B   +   2B  )+   Z  B  )[  Z  ,   3B   +   Z  [  [  ,   +      *[  Z  B  *+   Z  [  ![  ,   +   Z   ,~   % bw!0     (VARIABLE-VALUE-CELL RESETVARSLST0 . 10)
(VARIABLE-VALUE-CELL RESETSTATE . 42)
(VARIABLE-VALUE-CELL RESETVARSLST . 17)
(NIL VARIABLE-VALUE-CELL RESETZ . 68)
(NIL VARIABLE-VALUE-CELL OLDVALUE . 30)
TAILP
APPLY
RESET
ERROR
STKSCAN
SHOULDNT
RELSTK
(SET EQP SKSTK SKLST KNIL ENTERF) @             
    % H  @   H      
RESETSAVE BINARY
    %    !    $-.         !Z   3B   +   Z  -,   +   Z  ,<   Z  B  ",<   Z  Z 7@  7   Z  ,   ,   ,<   Z  ,<   [  Z  ,<   ,<  "$  #    ,\   ,   ,\   +   [  3B   +   [  Z  B  #,<   Z  B  #,   +   Z  Z  2B  #+   Z  [  [  Z  Z  +   Z  Z  ,<   Z  B  #,   ,   Z   ,   XB  ,~   " BI& (VARIABLE-VALUE-CELL RESETX . 58)
(VARIABLE-VALUE-CELL RESETVARSLST . 64)
STKSCAN
INTERNAL
EVAL
SETQ
(CONS CONSNL ALIST2 SET CONSS1 KNOB SKA KNIL ENTERF)     x   p          (       H   (        
RESETVAR BINARY
       #        "-.          @    ,~   Z   ,<   B  ,<   Z  Z 7@  7   Z  ,   ,   Z   ,   XB  XB   ,<  ,<  ,<   Z  ,<  ,   ,<   Z   ,<   ,   ,<   Z   ,<   ,   ,<   ,<   $  !XB   Z  
Z  Z  [  [  ,   [  XB  	Z  3B   +   Z  ,~      !Z   ,~     p `  (VARIABLE-VALUE-CELL RESETX . 24)
(VARIABLE-VALUE-CELL RESETY . 28)
(VARIABLE-VALUE-CELL RESETZ . 32)
(VARIABLE-VALUE-CELL RESETVARSLST . 46)
(NIL VARIABLE-VALUE-CELL MACROX . 45)
(NIL VARIABLE-VALUE-CELL MACROY . 50)
STKSCAN
PROGN
SETATOMVAL
QUOTE
INTERNAL
ERRORSET
ERROR!
(KNIL SET LIST3 LIST2 CONS CONSS1 KNOB ENTERF)   8              `                   
MERGE BINARY
         y    |-.           y-.       {    {,<   ,<   Zw~2B   +   Zw~+    Zw~2B   +   	Zw~+    Zw~-,   +   ,<  {,<   ,   B  {+   #Zw~-,   +   ,<  {,<   ,   B  {+   #Zw2B   +   Zw~Z  ,<   Zw~Z  ,<   ,  C2B   +   #+   !2B   +   Zw~,<   Zw~,<   ,  C2B   +   #+   !,<   Zw},<   Zw},<    "  ,   2B   +   #,<w~Zw}XBw~,\   XBw~Zw~XBwZw~[w~,   XBp  [w-,   +   ,ZwZp  QD  Zw~[w~QD  Zw~XD  +    Zw2B   +   2[wZ  ,<   Zw,<   ,  C2B   +   A+   >2B   +   9[wZ  Z  ,<   ZwZ  ,<   ,  C2B   +   A+   >,<   [wZ  ,<   Zw,<    "  ,   2B   +   A,<w,<w[w~XBw,\   ,\  QB  [wXBw+   &Zw   +   NZp  -,   +   GZ   +    Zw,   ,>  x,>   Zp  ,       ,^   /   2b  +   M7   Z   +    -,   +   _Zp     +   WZw,   ,>  x,>   Zp  ,       ,^   /   2b  +   V7   Z   +    -,   +   YZ   +     w,>  x,>    p      ,^   /   2b  +   ^7   Z   +    Zp  -,   +   bZ   +    Zw-,   +   d-,   +   tZp  -,   +   h-,   +   hZ   +    Zw  [ ,   ,>  y,>  ,>  Zp    [ ,    
 x  /  <,  s<(  r    3B  +   o2"  7   Z   +    Zp  -,   +   v-,   +   wZ   +    Z   +         !Lf@Z   @P  H@!@AD  (A . 1)
(B . 1)
(COMPAREFN . 1)
4
ERRORX
(SKNA UPATM SKNSTP SKSTP SKNLA SKNM SKNI SKI BHC FUNBOX URET2 SKNNM FLOATT CONS EVCC KT LIST2 SKNLST URET5 KNIL BLKENT ENTER3)  u    n (   `   h d    g 8         	p   x ] 
X L    T 
  J 	    x H h ( `   X 	h G    F    P H   h   X      x @ h p Y 
p M p 3 (        ( h 
    -      w 8 b x W 	` >  2 ` ! @  p   X   @    (      
SORT BINARY
         -.          -.     	   
-.    
Z`  -,   +   3B   +   ,< D ,~   Z   2B   +   
Z XB  ,<`  " Z   QD  ,<`  ,<   ,  ,~   ZwZp  3B  +   [wZp  2B  +   Zw+    ,<w,<w,<   [wXBwZw~3B  +   [wXBwZw~3B  +   [wXBw+   ,<w~[w,<   ,  XBp  [wXBw,<   ,<w~,  Zp  Zw2B  +   #Zw~+   QZ  
2B   +   /Zp  -,   +   (Zp  Z  +   (Zp  ,<   Zw~-,   +   ,Zw~Z  +   ,Zw~,<   ,  R3B   +   :+   82B +   4Zp  ,<   Zw~,<   ,  R3B   +   :+   8,<   Zw,<   Zw~,<    "  ,   3B   +   :[p  XBp  +    Zp  Zw2B  +   C,<   Zw~,<   Zw~ZwXD  ,\   ,\  XB  ZwXBwXBp  [  XBw+   O,<w[w~,<   ,<wZw},<   Zw}Zw~    D  Zw~Zw}QD  ,\   ,\  XB  ,\   ,\  QB  ZwXBp  [wXBwZw~3B  +   "+   #/  +    Zw   +   ]Zp  -,   +   VZ   +    Zw,   ,> ,>   Zp  ,       ,^   /   2b  +   \7   Z   +    -,   +   nZp     +   fZw,   ,> ,>   Zp  ,       ,^   /   2b  +   e7   Z   +    -,   +   hZ   +     w,> ,>    p      ,^   /   2b  +   m7   Z   +    Zp  -,   +   qZ   +    Zw-,   +   s-,   +  Zp  -,   +   w-,   +   wZ   +    Zw  [ ,   ,> ,>  ,>  Zp    [ ,    
 x  /  <, <(     3B  +   ~2"  7   Z   +    Zp  -,   +  -,   +  Z   +    Z   +         KF!@$ E$B%pXD    $I B BJ b@  (DATA . 1)
(VARIABLE-VALUE-CELL COMPAREFN . 71)
(VARIABLE-VALUE-CELL COMPAREFN . 0)
*SORT*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL COMPAREFN . 0)
"DATA NOT LIST:"
ERROR
ALPHORDER
LAST
(SKNA UPATM SKNSTP SKSTP SKNLA SKNM SKNI SKI FUNBOX SKNNM FLOATT BHC EVCC SKLST KT URET2 KNIL SKNLST BINDB BLKENT ENTERF)   H   P y    u    8   ` r    p    g    ^    c  Y 
x   
P   x S    ~ H d 0 R    8    * h   x p n  f H V P     8 w  o  g X V 
(     ( q h f P 8 8 . X  H 	  h    X    @    (      
ALPHORDER BINARY
    ;    8    9-.           8Z`     +   Z` -,   +   Z   ,~   Z`  ,   ,>  7,>   Z` ,       ,^   /   2b  +   7   Z   ,~   -,   +   Z`    +   Z`  ,   ,>  7,>   Z` ,       ,^   /   2b  +   7   Z   ,~   -,   +   Z   ,~    `  ,>  7,>    `     ,^   /   2b  +   7   Z   ,~   Z` -,   +    Z   ,~   Z`  -,   +   #-,   +   2Z` -,   +   &-,   +   &Z   ,~   Z`    [ ,   ,>  7,>  ,>  Z`   [ ,    
 x  /  <,  1<(  1    3B  +   -2"  7   Z   ,~   Z` -,   +   5-,   +   6Z   ,~   Z   ,~        ! B$
P
     (A . 1)
(B . 1)
(SKNA UPATM SKNSTP SKSTP SKNLA SKNM SKNI SKI KNIL BHC FUNBOX KT SKNNM FLOATT ENTER2)  4    ,    H   P #    %     x   p   X   ` 2   `     . @  (   (       7 ( & X  X   X    H   p        
UNPACKFILENAME BINARY
        
   -.          
Z`  -,   +   -,   +   ,< ,<   ,   B ,<   ,< ,<   ,<   ,<   ,<   Z`  2B   +   Z   +    ,<   ,<  ,<   Z"  =,\  2B  +   +Z"  >,<   ,<`  ,<  XBw}3B   +   +,< ,<  w|/"   ,   ,<   Z` 3B   +   "ZwZ` 1B  +   *  -,   +   *  ,   2B   7       3B   +   ',<`  ,<w,<w XBw~+   ',<`  ,<w,<w ,<   Zw~Zw},   ,   XBw~+   (/  +  	/   w}."   ,   XBw~Z"  ,<   ,<`  ,<w} XBw}3B   +   IZ 6@   Z 2B +   2Z +   3Z ,<   ,<w},<w|Z` 3B   +   @ZwZ` 1B  +   ;*  -,   +   ;*  ,   2B   7       3B   +   E,<`  ,<w,<w XBw~+   E,<`  ,<w,<w ,<   Zw~Zw},   ,   XBw~+   F/  +  	/   w}."   ,   XBw~,<`  ,<w} 1B  +   L0B  +  Z"  ,<   ,<`  ,<w} XBw}3B   +   j,<  w}."   ,   ,<    w|/"   ,   ,<   Z` 3B   +   `ZwZ` 1B  +   [*  -,   +   \*  ,   2B   7       3B   +   e,<`  ,<w,<w XBw~+   f,<`  ,<w,<w ,<   Zw~Zw},   ,   XBw~+   g/  +  	/   w}."   ,   XBw~+  Z"  ,<   ,<`  ,<w} XBw}3B   +  ,<  w}."   ,   ,<   Zw|XBw},<   Z` 3B   +   }ZwZ` 1B  +   x*  -,   +   y*  ,   2B   7       3B   +  ,<`  ,<w,<w XBw~+  ,<`  ,<w,<w ,<   Zw~Zw},   ,   XBw~+  /  +  	/  ,<`  Zw}XBw}d XBp  2B   +  	,<w +    Zp  0B  +  'Zw~2B   +  Z XBw~+  Z XBw,<   ,<w} w|/"   ,   ,<   Z` 3B   +  ZwZ` 1B  +  *  -,   +  *  ,   2B   7       3B   +  ",<`  ,<w,<w XBw~+  #,<`  ,<w,<w ,<   Zw~Zw},   ,   XBw~+  $/  +  	/   w}."   ,   XBw~+  1B  +  )0B  +  W,<w~,<w}Zw}2B   +  .Z XBw~Z XBw}+  >Zw~2B   +  1Z XBw~Z +  >2B +  4,<`  ,<w +  5Z   0B  (+  7Z +  >0B   +  ; w."   ,   XBwZ +  >1B  *+  =0B  )+  >Z +  >Z ,<   ,<w w/"   ,   ,<   Z` 3B   +  MZwZ` 1B  +  H*  -,   +  H*  ,   2B   7       3B   +  R,<`  ,<w,<w XBw}+  R,<`  ,<w,<w ,<   Zw~Zw|,   ,   XBw}+  S/  +  	/  /   w}."   ,   XBw~+  2B   +  ,<w~,<w}Zw}2B   +  ]Z XBw~Z XBw}+  mZw~2B   +  `Z XBw~Z +  m2B +  c,<`  ,<w +  dZ   0B  (+  fZ +  m0B   +  j w."   ,   XBwZ +  m1B  *+  l0B  )+  mZ +  mZ ,<   ,<w w/"   ,   ,<   Z` 3B   +  |ZwZ` 1B  +  w*  -,   +  w*  ,   2B   7       3B   +  ,<`  ,<w,<w XBw}+  ,<`  ,<w,<w ,<   Zw~Zw|,   ,   XBw}+  /  +  	/  /  ,<w +    ,<`   w}."   ,   XBw}d XBp  +  	Zw+    e$( o`	
! D
L D@EDl	
(S<NC/ "@E
S<g!/ " "
      (FILE . 1)
(ONEFIELDFLG . 1)
27
ERRORX
1
(NIL)
(LINKED-FN-CALL . NTHCHARCODE)
2
(NIL)
(LINKED-FN-CALL . LASTCHPOS)
HOST
(NIL)
(LINKED-FN-CALL . SUBATOM)
TENEX
TOPS20
STRUCTURE
DEVICE
DIRECTORY
(NIL)
(LINKED-FN-CALL . DREVERSE)
NAME
EXTENSION
;
PROTECTION
ACCOUNT
TEMPORARY
VERSION
(KL20FLG BHC CONSS1 CONS KT FMEMB SKLST MKN ASZ URET6 KNIL LIST2 SKNSTP SKNLA ENTER2)       @  (U HS P$ P   g x F  (     " ( e P '     "   e H &   x   \ @    w    [ 0    u h p Z      i hA  &   p  U 
0 I 0    l 0g P= @8 `)   0 M 	H K @  h   !(      y w  d hZ  J H 05 x+ (  H ( z  s ` ] P \ 
h P P < 8 6 p  h     8 
  	    p    `    @    0      
LASTCHPOS BINARY
            -.           ,<   ,<   Z` 2B   +   Z"   XB` ,<   ,<` ,<`   XBw2B   +   	Zp  +   Z`  Zw2B  +   Z` XBw ` ."   ,   XB` +   /   Zw+    A       (CH . 1)
(STR . 1)
(START . 1)
(NIL)
(LINKED-FN-CALL . NTHCHARCODE)
(URET2 BHC MKN ASZ KNIL ENTER3)         h    P      @   (      
FILENAMEFIELD BINARY
         	    -.           	,<`  Z` 3B  
+   2B  +   Z  +   3B  +   2B  +   Z  +   d  ,~   x  (FILE . 1)
(FIELDNAME . 1)
VERSION
GENERATION
((VERSION GENERATION) . 0)
DEVICE
STRUCTURE
((DEVICE STRUCTURE) . 0)
(NIL)
(LINKED-FN-CALL . UNPACKFILENAME)
(ENTER2)      
OPENFILE BINARY
     `    N    ]-.     (      NZ` 2B   +   ^"  +   ,   (B  ,>  M,>   Z` 2B  P+   ^"  +   2B  Q+   
^"  +   2B  Q+   ^"  +   2B  R+   ^"   +   ,<  R,<   ,   B  S,   GBx  ,^   /   ,   ,<   ,<  S,<` Zp  -,   +   +   1Zp  ,<   Zp  2B  T+   ^"  +   +2B  T+   ^"  +   +3B  U+   2B  U+   ^"  +   +-,   +   !Z   +   *Zp  2B  V+   %[p  Z  ,   (B  +   +3B  V+   '2B  W+   )[p  Z  XBw^"   +   +^"   +   +,   ,>  M,>    w~GBx  ,^   /   ,   XBw~/   [p  XBp  +   /   ,<`  ,<wZ` 2B   +   <Z` 2B  P+   6Z  W+   <2B  Q+   8Z  X+   <3B  Q+   :2B  R+   ;Z  X+   <Z   XB` 2B  W+   >Z  Y+   G2B  Y+   @Z  Z+   G2B  X+   BZ  Z+   G3B  X+   D2B  [+   EZ  [+   G,<  R,<   ,   B  Sf  \XB`  Zp  2B  S+   KZ   +   LZ   !$  GD@  Z`  +       I]ndc;u,>
@yy         (FILE . 1)
(ACCESS . 1)
(RECOG . 1)
(BYTESIZE . 1)
(MACHINE.DEPENDENT.PARAMETERS . 1)
INPUT
OUTPUT
BOTH
APPEND
27
ERRORX
CRLF
THAWED
WAIT
DON'T.CHANGE.READ.DATE
DON'T.CHANGE.DATE
MODE
EOL
END-OF-LINE-CONVENTION
OLD
NEW
OLD/NEW
8590196736
OLDEST
8590458878
-34359214081
NEWEST
262144
(NIL)
(LINKED-FN-CALL . OPENF)
(URET2 FCHAR KT SKNLST MKN BHC LIST2 IUNBOX KNIL ENTER5) 	`   	P   	@         / 8     0 h     G    8 $      K H 4         
PACKFILENAME BINARY
       H      ?-.        .   .   Z8  0B   +   Z`  -,   +   ,< Z`  d ,~   @   x,~    ` ,> ,>   [wA. .w 8      ,^   /   2b  +   K ` .wZ  XB` -,   +   [` XB` Z` XB` +     ` ."   ,   XB` ,   ,> ,>   [wA. .w 8      ,^   /   2b  +    ` .wZ  XB` +    Z   XB` Z` -,   +   $-,   +   $,< ,<   ,   B  Z` 3B  +   )2B !+   ;,< !,<`  "3B   +   ;Z` -,   +   ,b #+   ,b $,<   Zp  -,   +   /+   :,<   Zp  Z 7@  7   Z  2B   +   8Zp  ,<   [wZ  2B   +   6Z`     ,\   ,   /   [p  [  XBp  +   -/   +   HZ` Z   ,   3B   +   FZ` Z 7@  7   Z  2B   +   HZ` ,<   Z` 2B   +   DZ`     ,\   ,   +   H,< ,<` ,   B   ` ."   ,   XB` +   	Z  <,<   Zp  -,   +   N+   VZp  ,<   Zp  Z 7@  7   Z  Z` 2B  +   TZp  Z   ,   /   [p  XBp  +   L/   Z   3B   +   bb %XB  WZ &6@   Z &2B &+   bZ   2B   +   bZ  YZ ',   3B   +   bZ"XB  \Z   XB  ]Z   3B   +   rZ ',<   Z (,<   Z (,<   Z  b,<   Z ),<   Z ),<   Z       ,\   XCp  QEp  ,\       ,\   XCp  QEp  ,\       ,\   XCp  QEp  ,\   +   rZ   ,<   Z   2B   +   vZ   XB  s3B   +  b %3B *+   z3B *+   z2B ++  Z +,<   Z &6@   Z &2B &+   ~Z *+   Z +Z   XCp  QEp  ,\   +  Z ,,<   Z  u,<   Z ,,<   Z ,<   ,< - -3B !+  Z !+  	Z` ,<   Z       ,\   XCp  QEp  ,\       ,\   XCp  QEp  ,\   +  Z   ,<   Z   3B   +  ',<   ,<  -2B .+  Z /,<   Z Z   XCp  QEp  ,\   +  'Z /,<   Z .,<   Z 0,<   Z ,<   Z 0,<   Z 1,<   Z       ,\   XCp  QEp  ,\       ,\   XCp  QEp  ,\       ,\   XCp  QEp  ,\   +  'Z   ,<   Z   3B   +  -Z 1,<   Z (Z   XCp  QEp  ,\   +  .Z   ,<   Z   2B   +  1Z  `3B   +  BZ 2,<   Z .3B   +  7,<   ,<  -2B 2+  7Z` +  8Z 2,<   Z 3,<   Z 22B   +  ;Z` ,<   Z       ,\   XCp  QEp  ,\       ,\   XCp  QEp  ,\   +  BZ   ,<   Z 03B   +  Z-,   +  L,<   ,<  -3B 2+  I2B 3+  LZ C,<   ,< 4,< -,< 4 5XB IZ 6,<   Z &6@   Z &2B &+  QZ 2+  QZ 3,<   Z 6,<   Z L,<   Z       ,\   XCp  QEp  ,\       ,\   XCp  QEp  ,\   +  ZZ   ,<   Z   3B   +  nZ 7,<   Z [,<   ,<  -2B 3+  aZ` +  fZ ],<   ,<  -2B 7+  eZ 3+  fZ 8,<   Z 8,<   Z a,<   Z       ,\   XCp  QEp  ,\       ,\   XCp  QEp  ,\   +  oZ   ,<   Z   3B   +  Z 9,<   Z o,<   ,<  -2B 3+  vZ` +  zZ r,<   ,<  -2B 9+  zZ 3+  zZ :,<   Z :,<   Z v,<   Z       ,\   XCp  QEp  ,\       ,\   XCp  QEp  ,\   +  Z   ,<   Z  a3B   +  Z ;,<   Z 3,<   Z ;,<   Z 3B <+  2B <+  Z <+  Z   ,<   Z       ,\   XCp  QEp  ,\       ,\   XCp  QEp  ,\   +  Z   r =b >,~      M"  _)q@  ( !B @F9$Q  WaD? pE  `!=Q ~=/h 1t  !GS} Sx              (N . 1)
(VARIABLE-VALUE-CELL FILENAMEFIELDS . 150)
PACKFILENAME
(NIL)
(LINKED-FN-CALL . APPLY)
(NIL VARIABLE-VALUE-CELL HOST . 205)
(NIL VARIABLE-VALUE-CELL DEVICE . 265)
(NIL VARIABLE-VALUE-CELL STRUCTURE . 233)
(NIL VARIABLE-VALUE-CELL DIRECTORY . 311)
(NIL VARIABLE-VALUE-CELL NAME . 341)
(NIL VARIABLE-VALUE-CELL EXTENSION . 371)
(NIL VARIABLE-VALUE-CELL VERSION . 422)
(NIL VARIABLE-VALUE-CELL TEMPORARY . 529)
(NIL VARIABLE-VALUE-CELL PROTECTION . 463)
(NIL VARIABLE-VALUE-CELL ACCOUNT . 504)
1
NIL
NIL
NIL
""
27
ERRORX
BODY
DIRECTORY
:
(NIL)
(LINKED-FN-CALL . STRPOS)
(NIL)
(LINKED-FN-CALL . PACKFILENAME)
(NIL)
(LINKED-FN-CALL . UNPACKFILENAME)
(NIL)
(LINKED-FN-CALL . MKATOM)
TENEX
TOPS20
((S ;S) . 0)
((NIL) . 0)
{
((NIL) . 0)
((NIL) . 0)
}
NUL
NUL:
NIL:
((NIL) . 0)
((NIL) . 0)
((NIL) . 0)
-1
(NIL)
(LINKED-FN-CALL . NTHCHAR)
<
((NIL) . 0)
((NIL) . 0)
((NIL) . 0)
((NIL) . 0)
>
((NIL) . 0)
((NIL) . 0)
%.
((NIL) . 0)
;
2
""
(NIL)
(LINKED-FN-CALL . SUBSTRING)
((NIL) . 0)
((NIL) . 0)
((NIL) . 0)
P
";P"
((NIL) . 0)
((NIL) . 0)
A
";A"
((NIL) . 0)
((NIL) . 0)
((NIL) . 0)
S
;S
(NIL)
(LINKED-FN-CALL . NCONC)
(NIL)
(LINKED-FN-CALL . PACK)
(SKNI KT KL20FLG FMEMB SET KNOB SKNLST LIST2 SKNA SKNSTP KNIL IUNBOX MKN BHC SKLST ASZ CF CFARP ENTERN) E        p | 0   x =    U h 8    Q  2    M h   	 $    "    !    !`  @~ o \ 0U HC P; @1  . @)   p 
   v H s ( c   ]  T @ A ` 6 0 )     x   	(     W 
X ;   h   0   X                   
FULLNAME BINARY
       )        '-.           ,<   Z`  -,   +   ,<  ,<   ,   B   ,<`  ,<   Z` 2B   +   	Z"+   3B  !+   2B  !+   Z"   +   Z   ,<   Z` 3B   +   3B  "+   2B   +   Z  "+   2B  #+   Z  #+   3B  !+   2B  !+   Z"   +   ,<  $,<   ,   B   h  $2B   +   Z   +    XBp  b  %,<   ,<w  &,\   +    HoP3"       (X . 1)
(RECOG . 1)
14
ERRORX
OLDEST
OLD/NEW
NEWEST
OLD
32769
NEW
131073
27
(NIL)
(LINKED-FN-CALL . GTJFN)
(NIL)
(LINKED-FN-CALL . JFNS)
(NIL)
(LINKED-FN-CALL . RLJFN)
(URET1 ASZ LIST2 SKNLA KNIL ENTER2)    8   h                  P   (      
PRINTNUM BINARY
     \    Q    Z-.          QZ`  -,   Z   [  (B{Z  A"  ."   0B  	+   Z`  +   	,<`  ,<  S$  T,<   ,<   ,<   ,<   ,<   Zw~2B  T7   Z   XBw[w~XBp  Zw3B   +   Zp  "  M,>  M,>   Zp  "  N.Bx  Zp  "  N.Bx  Zp  "  O.Bx  ,^   /   ,   +   Zp  "  O,   XBw w,>  M,>   ,<` "  U,   .Bx  ,^   /   ,   XBw~Z` 2B   +   +Z   3B   +   + w,>  M,>   Z  "B  U,       ,^   /   /  ,   ,<   ,<` $  VZ  %+   HZp     ,>  M,>   Zw3B   +   1Z` ,   B   +   :Z`    +   9,   ,>  M,>   Z` ,   5"  6   P+   7   PBx  ,^   /   ,   +   :,   ,>  M,>   Z   ,    `        ,^  /   ,^  /   Z
w3J   5   C   M1FX5   F5   D   J1F5   F,<  V,<`  ,   B  W $   D   ,<  W"  X,<   ,<` $  X,<w~,<  Y,<` &  YZ` +    :            $  _p       X!" 	HHDQa  LdJ@   (FORMAT . 1)
(NUMBER . 1)
(FILE . 1)
(VARIABLE-VALUE-CELL NILNUMPRINTFLG . 85)
(VARIABLE-VALUE-CELL MACSCRATCHSTRING . 118)
((NIL . 10000) . 0)
NUMFORMATCODE
FLOAT
POSITION
NCHARS
SPACES
27
ERRORX
""
STRCONC1
PRIN1
0
TAB
(URET5 LIST2 UPATM FLTFX GUNBOX FLOATT FUNBOX IUNBOX MKN BHC KT ASZ TYPTAB KNIL SKLST ENTER3)  M    F    <    9    : X   (   8 0    ' h      0     @ p 9       `    h         A p #    X  8  (            
NUMFORMATCODE BINARY
            -.          Z`  -,   +   ^" ',   Z   ,   ,~   [`  (B{Z  A"  ."   0B  	+   
Z`  ,~   Z` -,   Z   [  (B{Z  A"  ."   1B  	+   ^" ',   Z   ,   XB` Z`  -,   Z   Z  2B +   W[`  XB`  -,   Z   Z  ,<   [`  XB`  -,   Z   Z  ,<   [`  XB`  -,   Z   Z  ,<   [`  XB`  -,   Z   Z  ,<   [`  XB`  -,   Z   Z  ,<   Zw2B   +   &Z"   XBw+   * w1b   +   * w."  ,   XBwZ` Z XD  [` ,<   Zw3B   +   /   +   /   ,>  ,>   Zw~2B   +   6Z"   XBw~ w}."   ,   XBw}^"   +   6   GBx  Zw~0B   +   9^"   +   :  GBx  Zw2B   +   =^"   +   =,   (B  	GBx   w},>  ,>    w~,>  ,>    w~.Bx  ,^   /   ."       ,^   /   /  (B  GBx   w~(B  GBx   w~GBx  ,^   /       ,\    D   w~,>  ,>    w.Bx  ,^   /   ,>  ,>    w~    ,^   /   3b  +   V,< Zw}Zw~,   D /  +   ~2B +   |[`  XB`  -,   Z   Z  ,<   [`  XB`  -,   Z   Z  ,<   [`  XB`  -,   Z   Z  ,<   [`  XB`  -,   Z   Z  ,<   Zw2B   +   fZ"  XBwZ` Z XD  [` ,<   Zw~,   5"  m w~"   ,   XBw~  +   n^"   ,>  ,>   Zw3B   +   q^"   +   r  GBx  Zw3B   +   u  +   u  GBx   w~(B  	GBx   w~GBx  ,^   /       ,\    D  /  +   ~,< ,<`  ,   B Z` ,~                  (   @                       $Aq EE@   18   "4,<      (FORMAT . 1)
(SMASHCODE . 1)
FLOAT
"Decimal field too wide"
ERROR
FIX
27
ERRORX
(LIST2 GUNBOX CONS BHC IUNBOX SKLST ASZ TYPTAB CONS21 KNIL MKN SKNLST ENTER2) `   (   
`   @ z 
p S 
  K ` D    >    c   ]   " x    0     f  3 `  h 	    X       X   @ p X c  ] ( <   . P #       8  @     l P *             
CPRINTNUM BINARY
              -.           Z` ,<   Zp  -,   Z   Z  2B  +   [p  Z  XBp  +   2B  +   
,<p  "  XBp  +   Z   -,   +   [p  -,   +   ,<`  Z`  2B  +   ,<w"  [  +   ,<w"  3B   +   3B   +   -,   +   ,<  ,<   ,   [` ,   ,   +    Z  +    u5U@@  (FN . 1)
(ARGS . 1)
QUOTE
CONSTANT
EVAL
FLTFMT
NUMFORMATCODE
IGNOREMACRO
(URET1 CONSS1 CONS LIST2 SKNNM KT KNIL SKLST ENTER2)   (                          8      @        
FLTFMT BINARY
            -.           Z`  -,   Z   Z  2B  	+   ,<`  ,<  	$  
[  +   Z`  B  
,~   m   (FORMATBITS . 1)
FLOAT
((NIL . 10000) . 0)
NUMFORMATCODE
OLDFLTFMT
(KNIL SKLST ENTER1)              
WAITFORINPUT BINARY
        ,    (    +-.          (,<   "  )2B   +   'Z`  -,   +   ,>  ',>   ,>   ,>    `   Bx       B     B "      !+   7`x  +    2bx   x     ;"   .Fx  (B~.."   2b  B+   
7   Z   /  ,~   B  )3B   +   Z`  ,~   ,>  ',>   ,>   ,>   ,<`  ,<  *$  *,    Bx  Z   BZ  	 B "      !+   & x     !+   %    ;(B~.."   2b  B+   7`  Z   /  ,~      ( !$     (FILE . 1)
(VARIABLE-VALUE-CELL DISMISSINIT . 56)
(VARIABLE-VALUE-CELL DISMISSMAX . 58)
READP
INPUT
OPNJFN
(IUNBOX BHC SKNM KNIL KT ENTER1) @   x          H     ' @        
RETEVAL BINARY
                -.           ,<` ,<`  ,<  
,<`  Z   f  
XB  ,<   ,<` ,<   
  ,~   !   (POS . 1)
(FORM . 1)
(FLG . 1)
(INTERNALFLG . 1)
(VARIABLE-VALUE-CELL **RETEVAL . 9)
-1
(NIL)
(LINKED-FN-CALL . STKNTH)
(NIL)
(LINKED-FN-CALL . ENVEVAL)
(KT ENTER4)   p      
RETAPPLY BINARY
             -.     (     ,<` ,<` ,<`  ,<  ,<`  Z   f  XB  ,<   ,<` ,<     ,~   @  (POS . 1)
(FN . 1)
(ARGS . 1)
(FLG . 1)
(INTERNALFLG . 1)
(VARIABLE-VALUE-CELL **RETEVAL . 10)
-1
(NIL)
(LINKED-FN-CALL . STKNTH)
(NIL)
(LINKED-FN-CALL . ENVAPPLY)
(KT ENTER5)          
STKEVAL BINARY
                -.            ,<` ,<`  ,<   ,<`   ,~   @   (POS . 1)
(FORM . 1)
(FLG . 1)
(INTERNALFLG . 1)
(NIL)
(LINKED-FN-CALL . ENVEVAL)
(KNIL ENTER4)          
STKAPPLY BINARY
       	        -.     (      ,<` ,<` ,<`  ,<   ,<` 
  ,~       (POS . 1)
(FN . 1)
(ARGS . 1)
(FLG . 1)
(INTERNALFLG . 1)
(NIL)
(LINKED-FN-CALL . ENVAPPLY)
(KNIL ENTER5)         
DUMMYFRAMEP BINARY
            -.           ,<`  ,<     2B   +   7   Z   ,~   @   (POS . 1)
(NIL)
(LINKED-FN-CALL . REALFRAMEP)
(KT KNIL ENTER1)  P    X   0      
REALFRAMEP BINARY
        S    A    Q-.          A,<   Z`  -,   +   b  C+   XBp  2B  D+   	,<  D,<`    E2B  F7   Z   +    3B  F+   2B  G+   Z   +    2B  G+   ,<`    H,   1"  7   7   +    ,<  I,<`    IZ  J,   2B   +   7   Z   +    2B  K+   ,<`    H,   1"  7   7   +    ,<  K,<`    I3B  L+   7   Z   +    -,   +   >Zp  Z   ,   3B   +   #Z` +    ,<p  ,<  L  M2B  N+   (,<p  ,<  D  M3B  N+   =,<`    H1B   +   +Z   +    ,<  L,<`    I,<   ,<  D,<`    E,\  3B  +   1Z   +    Zp  ."   Z  2B   +   4Z   +    ,<p    NXB`  [  2B   +    Z`  ,<   ,<w,<  O,   b  P,\  3B  +   <7   Z   +    Z   +    -,   +   @Z   +    Z   +    ncfAd4BwTU$       (POS . 1)
(INTERPFLG . 1)
(VARIABLE-VALUE-CELL OPENFNS . 64)
(NIL)
(LINKED-FN-CALL . STKNAME)
*PROG*LAM
-1
(NIL)
(LINKED-FN-CALL . STKNTHNAME)
EVALA
*ENV*
NOLINKDEF1
EVAL
(NIL)
(LINKED-FN-CALL . STKNARGS)
2
(NIL)
(LINKED-FN-CALL . STKARG)
((INTERNAL SELECTQ) . 0)
APPLY
3
INTERNAL
1
(NIL)
(LINKED-FN-CALL . NTHCHAR)
*
(NIL)
(LINKED-FN-CALL . ARGLIST)
#0
(NIL)
(LINKED-FN-CALL . PACK)
(SKNLST LIST2 ASZ SKLA FMEMB IUNBOX URET1 KT SKSTK KNIL ENTER2)   x   (       x         x     A p >   5  + 8  0         = H 1 0      	        @ h = x 3    (  H  H 	  (      
REALSTKNTH BINARY
                -.            ,<   ,<   Z`  ,   5"  Z"+   Z`  0B   +      +   Z"   XBp  ,<   ,<` ,<`   XBw,<w,<`   3B   +    `  ,>  ,>    p      ,^   /   /  ,   XB`  0B   +   Zw+    ,<p  ,<w,<w~  XBw3B   +   +   Z   +       SA
@&   (N . 1)
(POS . 1)
(INTERPFLG . 1)
(OLDPOS . 1)
HELP
(NIL)
(LINKED-FN-CALL . STKNTH)
(NIL)
(LINKED-FN-CALL . REALFRAMEP)
(URET2 MKN BHC ASZ GUNBOX KNIL ENTER4)   P   (      8   h              0        
SETNM BINARY
         	    
-.           	,<`  "  
2B   +   ^"   +   ,      	   	   D+    +    +    ,   ,~        ,   (NAME . 1)
SIXBIT
(MKN IUNBOX KNIL ENTER1)      X    8      
RANDACCESSP BINARY
               -.           Z`  -,   +   
Z`  2B   +      B  XB`  B  ,    $      
ad   7   Z`  ,~   Z   ,~   :   (FILE . 1)
INPUT
OPENP
OPNJFN
(GUNBOX KNIL SKLA ENTER1)   x   0 	  H    0      
SETLINELENGTH BINARY
     '    $    %-.          $Z`  3B   +   XB    `  (B  	,>  ",>      ",>  ",>      #   #   #   #+    +    +       ABx  ,^   /   GBx  ,^   /   ,   +   ^"   +   ,          #   #   G+    +    +    +   ^"  ?,>  ",>      #   #   #   #+    +    +       (BwABx  ,^   /   ,   XB  ,   0"  +   Z"  $XB  Z  ,<   ,<   $  %,~      x          p )8      (N . 1)
(VARIABLE-VALUE-CELL TTYLINELENGTH . 63)
LINELENGTH
(KT ASZ IUNBOX MKN BHC KNIL ENTER1)      x   `      p   H  P    0      
DISPLAYTERMP BINARY
              -.          Z`  2B   +               a+    +    +       ,   ,<   Zp  Z   7   [  Z  Z  1H  +   2D   +   	[  XBp  -,   +   B  XBp  Zp  +           ` 0     (DIRECTEDTYPE . 1)
(VARIABLE-VALUE-CELL SYSTEMTERMTYPES . 17)
EVAL
(URET1 SKLST MKN KNIL ENTER1)     p       P        
PRINTARRAY BINARY
     Y    K    W-.           K,<   ,<   ,<   ,<   ,<   ,<   Z`  -,   +   ,<   ,<  K$  LXBw}-,   +   ,<  L,<   $  M,<`  ,<   $  M,<  N,<   $  N,<  O,<   $  M,<w}"  OXBw~,<   ,<   $  M,<  P,<   $  M,<w}"  PXBw,<   ,<   $  M,<  Q,<   $  M,<w}"  QXBp  ,<   ,<   $  M,<  R,<   $  M,<  R,<   $  M,<   "  S+   (Z`  -,   +   &XBw}B  OXBw~,<w}"  PXBw,<w}"  QXBp  +   (Z  S,   B  T+    ,<  T"  MZ"   XBw~ w~,>  J,>    w~    ,^   /   2b  +   ;,<w},<w~$  UB  U w~,>  J,>    w    ,^   /   3b  +   8,<w},<w~$  V3B   +   8Z   XBw w~."   ,   XBw~+   *,<w"  U2B   +   =+   H w."   ,   XBw~ w~,>  J,>    w~    ,^   /   2b  +   H,<w},<w~$  VB  U w~."   ,   XBw~+   ?,<  V"  MZw}+       M(T5V)-1PAp    (V . 1)
PRINTARRAY
EVALV
"(SETQ "
PRIN1
PRIN2
1
SPACES
"(READARRAY "
ARRAYSIZE
" (QUOTE "
ARRAYTYP
") "
ARRAYORIG
")"
")"
TERPRI
((not array) . 0)
HELP
%(
ELT
PRINT
ELTD
%)
(MKN KT BHC ASZ URET6 CONS SKAR SKLA KNIL ENTER1)   H x :    8    C H .    *    K    x    	        = x  `  0  h     X  (   H   8   (      
ADDSTATS BINARY
     )    "    (-.         "Z   -,   +    ,<   ,<  $Z   ,<   ,<`  $  $D  %   %,<p  "  &XB   ,<p  "  &,<   Z  B  &,<    w,>  !,>    p      ,^   /   3b  +   Zp  +   Zw/  ,<   ,<   ,<  & p  ,>  !,>    w    ,^   /   3b  +   Zw+   Z  
,<   ,<w,<w},<w~$  'F  ' p  ."   ,   XBp  +   /  Z`  +    Z   ,~      G$H
      (STATLST . 1)
(VARIABLE-VALUE-CELL STATARRAY . 50)
(VARIABLE-VALUE-CELL SYSTATS . 8)
(VARIABLE-VALUE-CELL N . 16)
SYSTATS
APPEND
/SETATOMVAL
STATINIT
ARRAYSIZE
1
ELT
SETA
(URET1 MKN KNIL BHC SKAR ENTER1)    h          x  x    0      
STATINIT BINARY
             -.          ,<   Z`  2B   +   ,<  Z   B  ,<   ,<  $  D  Z"   XBp  Z  ,<  Zp  -,   +   +   Zp  ,<   Zp  -,   +   Zp  ,<   Z   ,>  ,>    w~."   ,   XBw~,   .Bx  ,^   /   D  /   [p  XBp  +   	/   Z   +       WB    (ARRAY . 1)
(VARIABLE-VALUE-CELL SYSTATS . 16)
(VARIABLE-VALUE-CELL STATARRAY . 29)
STATARRAY
LENGTH
FIXP
ARRAY
/SETATOMVAL
(URET1 BHC IUNBOX MKN SKLST SKNLST ASZ KNIL ENTER1)      x  H   0       X   (           (      
LISPXWATCH BINARY
                -.           Z`  -,   +   ,<      ,>  ,>   Z` 2B   +   ^"   +   ,   .Bx  ,^   /   ,\   B  ,~   Z   ,~      "@  (STAT . 1)
(N . 1)
(BHC IUNBOX KNIL SKAR ENTER2)        @            
LISPXSTATS BINARY
     g    X    d-.           X-.     8 X    \,<   Z   ,<   ,<   ,<   ,<   Zw~-,   +   Zw+   Zw~,<   Zp  -,   +   [p  3B   +   Zp  Z 7@  7   Z     ,   [p  ,   XBp  Z  1B   +   Zp  ,   +   Z   /   XBp  -,   +   Zw3B   +   Zp  QD  +   Zp  XBw       [  2D   +   XBw[w~XBw~+   /  ,<   ,<       ,>  W,>      ,>  W,>           ,^   /   /  .Bx  ,^   /   ,   ,<   ,<  \,  J,<   Z   ,<   ,<  \,  J,<   ,<       ,>  W,>   ,<  ]  ],   ,>  W,>           ,^   /   /  .Bx  ,^   /   ,   ,<   ,<  ^,  J,<   Z      ,   ,<   ,<  _,  J^,  ,   d  _XBp  Zw3B   +   ?Zp  +    ,<p  Zp  -,   +   B+   IZp  ,<   Zp  3B   +   F,<   ,<     `,<     a/   [p  XBp  +   @/   Z   +     w&" t,   XBw w&" ,   ,<   ,<  b w~&"    &"  ,   ,<   ,<  b w}&"     ,   ^,  ,   b  cZp  ,   +        PH $ "	 14 020J       (RETURNVALUESFLG . 1)
(VARIABLE-VALUE-CELL SYSTATS . 7)
(VARIABLE-VALUE-CELL CONSOLETIME . 66)
(VARIABLE-VALUE-CELL CONSOLETIME0 . 72)
(VARIABLE-VALUE-CELL EDITIME . 85)
(VARIABLE-VALUE-CELL CPUTIME . 91)
(VARIABLE-VALUE-CELL CPUTIME0 . 99)
(VARIABLE-VALUE-CELL FIXTIME . 112)
((CONSOLE TIME) . 0)
((OF IT IN THE EDITOR) . 0)
2
(NIL)
(LINKED-FN-CALL . CLOCK)
((CPU TIME) . 0)
((OF IT IN DWIM) . 0)
(NIL)
(LINKED-FN-CALL . NCONC)
(NIL)
(LINKED-FN-CALL . LISPXPRIN1)
(NIL)
(LINKED-FN-CALL . LISPXTERPRI)
:
(NIL)
(LINKED-FN-CALL . PACK)
(KT URET2 ALIST IUNBOX BHC CONSNL ASZ CONS MKN KNOB SKLST SKNLST KNIL BLKENT ENTER1)  J p F    X 	0 @    V H      	  H ` 4  &              W    
P R 	h L   6           0        D h .     H   `   @    (      
GCGAG BINARY
        D    5    B-.         @ 5Z   ,<   Z`  XB  2B   +   ,<  :"  :,<  ;"  :,<  ;"  :,<  <"  :,<  <"  :,<  ="  :+   43B   +      +   ,<  :Z   D  :,<  ;Z   D  :,<  ;Z   D  :,<  <Z   D  :,<  <Z  "   +   Z   D  :,<  =Z   D  :,<  =Z   D  :+   42B  >+   %,<  :,<  >$  :,<  ;,<  ?$  :,<  ;,<  ?$  :,<  <,<  @$  :,<  <,<  @$  :,<  =,<  A$  :,<  =,<  A$  :+   4-,   +   .,<  :"  :,<  ;Z  D  :,<  ;"  :,<  <"  :,<  <"  :,<  =[  (D  :+   4,<  :"  :,<  ;Z  ,D  :,<  ;"  :,<  <"  :,<  <"  :,<  ="  :,\   ,~   ?Vm2mw_wo|     (MESSAGE . 1)
(VARIABLE-VALUE-CELL GCGAG . 95)
(VARIABLE-VALUE-CELL GCMESS1 . 27)
(VARIABLE-VALUE-CELL GCMESS2 . 30)
(VARIABLE-VALUE-CELL GCMESS3 . 33)
(VARIABLE-VALUE-CELL GCMESS4 . 36)
(VARIABLE-VALUE-CELL GCMESS5 . 42)
(VARIABLE-VALUE-CELL GCMESS6 . 45)
(VARIABLE-VALUE-CELL GCMESS7 . 48)
1
GCMESS
2
3
4
5
7
6
OLD
"GC: 
"
"
"
", "
" FREE CELLS"
40
" PAGES LEFT"
"
"
(SKLST SMALLT KT KNIL ENTER1)   &     P   @    H      
U-CASEP BINARY
              -.           Z`  -,   +   
Z`  b  3B   +   	[`  2B   +   Z   ,~   [`  XB`  +   Z   ,~   Z`  -,   [ ,   4H    0$  00d  ==  7   Z   ,~   R@(X . 1)
(NIL)
(LINKED-FN-CALL . U-CASEP)
(UPATM SKSTP KT KNIL SKLST ENTER1)   H   8              P    0      
U-CASE BINARY
       ,    %    +-.          %Z`  -,   +   	Z`  b  &,<   [`  3B   +   [`  b  &+   Z   ,   ,~   ,<   ,<   ,<   ,<`  Z   d  'XBw,<   Zp  -,   +   +   ,<   ,<p  ZwXBw},   1b  0+    w}0"  =+    w}.  $,   XBw~+   Zw}A"  ?Z   ." Z  ,\  XB  /   [p  XBp  +   /   Zp  2B   +   Z`  +    Z`  -,   +   #Z  (,<   ,<w  )+    ,<w  *+    pE@`J d     (X . 1)
(VARIABLE-VALUE-CELL CHCONLST . 22)
(VARIABLE-VALUE-CELL FCHARAR . 47)
(NIL)
(LINKED-FN-CALL . U-CASE)
(NIL)
(LINKED-FN-CALL . DCHCON)
CONCAT
(NIL)
(LINKED-FN-CALL . APPLY)
(NIL)
(LINKED-FN-CALL . PACK)
(SKSTP URET3 BHC MKN IUNBOX SKNLST CONSS1 KNIL SKLST ENTER1)      P # x   P                 	     0 
     `    0      
L-CASE BINARY
               -.          Z`  -,   +   Z`  ,<   ,<`   ,<   [`  3B   +   	[`  ,<   ,<`   +   
Z   ,   ,~   ,<   Z   d  ,<   ,<` ,<`    ,~   @     (X . 1)
(FLG . 1)
(VARIABLE-VALUE-CELL CHCONLST . 23)
(NIL)
(LINKED-FN-CALL . L-CASE)
(NIL)
(LINKED-FN-CALL . DCHCON)
(NIL)
(LINKED-FN-CALL . L-CASE1)
(CONSS1 KNIL SKLST ENTER2)       
  p    0      
L-CASE1 BINARY
      -    '    +-.          ',<   ,<   ,<`  Zp  -,   +   +   ,<   ,<p  ZwXBw~,   1b   +    w~0"  -+   Z` 3B   +   Z   XB` Zw~+    w~."  ,   XBw~+   Z` 3B   +    w~1b  0+    w~0"  =+   Z   XB`  w~/"  ,   XBw~+   Zw~A"  ?Z   ." Z  ,\  XB  /   [p  XBp  +   /   Z` 3B   +   "Zp  2B   +   "Z` +    Z` -,   +   %,<  ),<`    )+    ,<`    *+    0"	$ "!$    (LST . 1)
(CAP . 1)
(X . 1)
(VARIABLE-VALUE-CELL FCHARAR . 50)
CONCAT
(NIL)
(LINKED-FN-CALL . APPLY)
(NIL)
(LINKED-FN-CALL . PACK)
(SKSTP URET2 BHC MKN IUNBOX SKNLST KNIL ENTER3)  #    ' ` "     H   x             ! x    8   (      
GREETFILENAME BINARY
             -.          ,<  Z   2B   +   	Z   2B   +   	Z  6@   Z  2B  +   Z  +   	Z  +   	,<   ,<  Z   ,<   ,<  Z   L  B  ,~   }      (VARIABLE-VALUE-CELL USER . 4)
(VARIABLE-VALUE-CELL GREETDIRECTORY . 7)
(VARIABLE-VALUE-CELL GREETFILE . 21)
(VARIABLE-VALUE-CELL GREETEXT . 24)
DIRECTORY
TENEX
TOPS20
INTERLISP:
<LISP>
NAME
EXTENSION
PACKFILENAME
INFILEP
(KL20FLG KNIL KT ENTERF)   h    P    8      
SUBATOM BINARY
      
        	-.           Z   ,<   Z   ,<  Z   ,<  ,<  (  B  	,~      (VARIABLE-VALUE-CELL X . 3)
(VARIABLE-VALUE-CELL N . 5)
(VARIABLE-VALUE-CELL M . 7)
""
SUBSTRING
MKATOM
(ENTERF)      
CHECKNIL BINARY
        y   -.           yZ   Z  2B   +   Z   [  2B   +   ,<   "  z2B   +   ,<   "  z2B   +   Z   Z 7@  7   Z  3B   +   A,<  {,<  {$  |,<   @  |  +   8,<  |Z   ,<   ,   ,   Z   ,   XB  XB` ,<  ~,<  ,<   @   ` +   /Z   Z XB ,< Zp  -,   +   Z   +   ,Zp  ,<   @    +   +Z   ,<   ,<    "   ,   3B   +   *Z  ,<   ,<   $ ,< ,<   $ Z  ",<   ,<    "   ,   ,<   ,<   ,<   & ,~   [p  XBp  +   /   Zw~XB8 Z   ,~   2B   +   1Z XB   [` XB  ,<  |Z` Z  [  D Z  03B   +   7  ,~   Z` ,~   Z   ,<   Z   Z   XCp  QEp  ,\   ,<   ,<   $ ,<   ,<   $ Z   Z   ,   ,< ,<   $ Z   Z  3B   +   DZ   +   IZ   Z 7@  7   Z  2B   +   IZ   ,~   Z   ,<  {,<  {$  |,<   @   +   t,<  |Z  ,<   ,   ,   Z  1,   XB  OXB` ,< 	,<  ,<   @   ` +   kZ   Z XB ,< 	Zp  -,   +   YZ   +   iZp  ,<   @    +   gZ  &,<   ,<    "   ,   3B   +   gZ  [,<   ,<   $ ,< 
,<   $ Z  _,<   ,<    "   ,   ,<   ,<   ,<   & ,~   [p  XBp  +   V/   Zw~XB8 Z   ,~   2B   +   mZ XB  4[` XB  P,<  |Z` Z  [  D Z  m3B   +   s  ,~   Z` ,~   Z   Z   ,   Z   Z   XD  ,< 
,<   $ ,~   
TVU%hD@"@X*JPP b       (VARIABLE-VALUE-CELL RESETVARSLST . 220)
GETPROPLIST
GETD
2
10
PRINTLEVEL
(VARIABLE-VALUE-CELL OLDVALUE . 155)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 226)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
((CAR CDR GETD GETPROPLIST GETATOMVAL) . 0)
(VARIABLE-VALUE-CELL Z . 197)
PRIN1
" of NIL was clobbered with "
PRINT
ERROR
APPLY
ERROR!
PUTD
SETPROPLIST
"- now restored.
"
(VARIABLE-VALUE-CELL OLDVALUE . 0)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 0)
((DUMMY) . 0)
((CAR GETATOMVAL) . 0)
" of T was clobbered with "
"- now restored.
"
(SET BHC KT EVCC SKNLST CF CONS CONSNL LIST2 KNOB KNIL ENTER0)   v      -    y x w ` u 8 g h d ( a p ] 	  H X D 8 B  / ( * ` $    e h )           U    
     P 8   	x     G @   ( l  S 	 @ x > ` = H :   9 ` 0   "   p  ( 	    h   H   (      
INTEGERLENGTH BINARY
             -.               #   (b      "  /  ."   ,~           (VARIABLE-VALUE-CELL N . 3)
(ASZ ENTERF)          
LISTFILES1 BINARY
         	    -.           	Z  	6@   Z  
2B  	+   Z  
+   Z  ,<   Z   ,<   ,<  &  B  	,~   xp  (VARIABLE-VALUE-CELL FILE . 12)
TENEX
TOPS20
"LIST"
"PRINT "
"


"
CONCAT
(KL20FLG ENTERF)          
(PRETTYCOMPRINT MACHINEDEPENDENTCOMS)
(RPAQQ MACHINEDEPENDENTCOMS ((COMS (* from HIST) (VARS DUMPSTATSCOMS) (ADDVARS (AFTERSYSOUTFORMS (SETQ CONSOLETIME0 (CLOCK 0)) (SETQ
 CPUTIME0 (CLOCK 2)) (SETQ GREETCLK (CLOCK 3)) (SETQ LASTEXEC NIL) (SETQ HOSTNAME (MKATOM (HOSTNAME))) (SETQ DISPLAYTERMFLG (
DISPLAYTERMP)) (SETLINELENGTH) (COND ((NEQ SYSTEMTYPE (SETQ SYSTEMTYPE (SYSTEMTYPE))) (SELECTQ SYSTEMTYPE (TOPS20 (SETQQ SYSOUT.EXT 
EXE) (SETQQ EDITCHARACTERS (J A L Y K))) (TENEX (SETQQ SYSOUT.EXT SAV) (SETQQ EDITCHARACTERS (J X Z Y N))) (SHOULDNT)) (
RESETTERMCHARS) (APPLY (QUOTE SETTERMCHARS) EDITCHARACTERS)))) (BEFORESYSOUTFORMS (SETQ CONSOLETIME (IPLUS CONSOLETIME (IDIFFERENCE 
(CLOCK 0) CONSOLETIME0))) (SETQ CPUTIME (IPLUS CPUTIME (IDIFFERENCE (CLOCK 2) CPUTIME0)))) (RESETFORMS (SETQ DISPLAYTERMFLG (
DISPLAYTERMP)) (SETLINELENGTH)) (LISPXMACROS (EXEC (PROGN (OR (NLSETQ (SETQ LASTEXEC (SUBSYS LASTEXEC))) (SETQ LASTEXEC (SUBSYS))) 
LASTEXEC)) (CONTIN (SUBSYS T))) (LISPXCOMS CONTIN) (BEFOREMAKESYSFORMS (HERALD (SETQ HERALDSTRING (CONCAT (OR NAME (COND ((EQ (
GETATOMVAL (QUOTE BYTELISPFLG)) T) "INTERLISP-MAXC") (T "INTERLISP-10"))) "  " (SUBSTRING (SETQ TEM (DATE)) 1 (IPLUS 2 (STRPOS (
QUOTE -) TEM 4))) " ...")))) (PREGREETFORMS (COND ((NEQ SYSTEMTYPE (SETQ SYSTEMTYPE (SYSTEMTYPE))) (SELECTQ SYSTEMTYPE (TOPS20 (
SETQQ SYSOUT.EXT EXE) (SETQQ EDITCHARACTERS (J A L Y K))) (TENEX (SETQQ SYSOUT.EXT SAV) (SETQQ EDITCHARACTERS (J X Z Y N))) (
SHOULDNT)) (RESETTERMCHARS) (RESETTERMCHARS ASKUSERTTBL))) (SETQ HOSTNAME (MKATOM (HOSTNAME))) (STATINIT))) (FNS GREETFILENAME) (
VARS (GREETDIRECTORY) (GREETFILE (QUOTE INIT)) (GREETEXT (QUOTE LISP))) (GLOBALVARS GREETDIRECTORY GREETFILE GREETEXT)) (COMS (FNS 
PRINTARRAY DISPLAYTERMP SETLINELENGTH SETNM RANDACCESSP U-CASEP U-CASE L-CASE L-CASE1 SUBATOM GCGAG) (VARS (SYSTEMTERMTYPES (QUOTE (
(15 . VT52) (16 . VT100)))) OPENFNS (GCGAG 40) GCMESS1 GCMESS2 GCMESS3 GCMESS4 GCMESS5 GCMESS6 GCMESS7) (P (GCGAG GCGAG))) (COMS (
FNS CHECKNIL)) (COMS (FNS RETEVAL RETAPPLY STKEVAL STKAPPLY DUMMYFRAMEP REALFRAMEP REALSTKNTH) (VARS (SPAGHETTIFLG T) (**RETEVAL))) 
(COMS (FNS LISPXSTATS LISPXSTATS1 LISPXWATCH STATINIT ADDSTATS) (PROP 10MACRO LISPXWATCH) (INITVARS (SYSTATS))) (COMS (* NOTE: 
definitions for RESETRESTORE, RESETVARS, RESETVAR, and RESETSAVE are in machinedependent because they are different for deep vs 
shallow bound systems) (FNS RESETRESTORE RESETSAVE RESETVAR) (BLOCKS (NIL RESETRESTORE RESETSAVE RESETVAR (GLOBALVARS RESETVARSLST))
)) (COMS * SORTCOMS) (VARS MAX.INTEGER MIN.INTEGER (MAX.FLOAT (MKATOM (QUOTE "1.70141182E38"))) (MIN.FLOAT (FMINUS MAX.FLOAT))) (FNS
 INTEGERLENGTH) (COMS * FILENAMECOMS) (COMS * PRINTNUMCOMS) (COMS * WAITFORINPUTCOMS) (FNS LISTFILES1) (BLOCKS (NIL RETEVAL RETAPPLY
 STKEVAL STKAPPLY (LINKFNS . T) (GLOBALVARS **RETEVAL) (LOCALVARS . T)) (NIL DUMMYFRAMEP REALFRAMEP REALSTKNTH (GLOBALVARS OPENFNS) 
(LOCALVARS . T) (LINKFNS . T)) (NIL SETNM RANDACCESSP SETLINELENGTH (GLOBALVARS TTYLINELENGTH) DISPLAYTERMP PRINTARRAY (LOCALVARS . 
T) (NOLINKFNS . T)) (NIL ADDSTATS STATINIT (GLOBALVARS SYSTATS STATARRAY) LISPXWATCH (LOCALVARS . T)) (LISPXSTATS LISPXSTATS 
LISPXSTATS1 (GLOBALVARS SYSTATS CONSOLETIME CONSOLETIME0 EDITIME CPUTIME CPUTIME0 FIXTIME)) (NIL GCGAG (LOCALVARS . T) (GLOBALVARS 
GCGAG GCMESS1 GCMESS2 GCMESS3 GCMESS4 GCMESS5 GCMESS6 GCMESS7)) (NIL U-CASEP U-CASE L-CASE L-CASE1 (LOCALVARS . T) (LINKFNS . T) (
GLOBALVARS CHCONLST))) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA RESETSAVE ADDSTATS) (NLAML 
RESETVAR) (LAMA PACKFILENAME)))))
(RPAQQ DUMPSTATSCOMS ((E (SETQ CONSOLETIME (IPLUS CONSOLETIME (IDIFFERENCE (CLOCK 0) CONSOLETIME0))) (SETQ CPUTIME (IPLUS CPUTIME (
IDIFFERENCE (CLOCK 2) CPUTIME0))) (SETQ CONSOLETIME0 (CLOCK 0)) (SETQ CPUTIME0 (CLOCK 2))) (VARS CPUTIME (CPUTIME0 (CLOCK 2)) 
CONSOLETIME (CONSOLETIME0 (CLOCK 0)) EDITIME SYSTATS RESPELLS) (ARRAY STATARRAY) (P (STATINIT T))))
(ADDTOVAR AFTERSYSOUTFORMS (SETQ CONSOLETIME0 (CLOCK 0)) (SETQ CPUTIME0 (CLOCK 2)) (SETQ GREETCLK (CLOCK 3)) (SETQ LASTEXEC NIL) (
SETQ HOSTNAME (MKATOM (HOSTNAME))) (SETQ DISPLAYTERMFLG (DISPLAYTERMP)) (SETLINELENGTH) (COND ((NEQ SYSTEMTYPE (SETQ SYSTEMTYPE (
SYSTEMTYPE))) (SELECTQ SYSTEMTYPE (TOPS20 (SETQQ SYSOUT.EXT EXE) (SETQQ EDITCHARACTERS (J A L Y K))) (TENEX (SETQQ SYSOUT.EXT SAV) (
SETQQ EDITCHARACTERS (J X Z Y N))) (SHOULDNT)) (RESETTERMCHARS) (APPLY (QUOTE SETTERMCHARS) EDITCHARACTERS))))
(ADDTOVAR BEFORESYSOUTFORMS (SETQ CONSOLETIME (IPLUS CONSOLETIME (IDIFFERENCE (CLOCK 0) CONSOLETIME0))) (SETQ CPUTIME (IPLUS CPUTIME
 (IDIFFERENCE (CLOCK 2) CPUTIME0))))
(ADDTOVAR RESETFORMS (SETQ DISPLAYTERMFLG (DISPLAYTERMP)) (SETLINELENGTH))
(ADDTOVAR LISPXMACROS (EXEC (PROGN (OR (NLSETQ (SETQ LASTEXEC (SUBSYS LASTEXEC))) (SETQ LASTEXEC (SUBSYS))) LASTEXEC)) (CONTIN (
SUBSYS T)))
(ADDTOVAR LISPXCOMS CONTIN)
(ADDTOVAR BEFOREMAKESYSFORMS (HERALD (SETQ HERALDSTRING (CONCAT (OR NAME (COND ((EQ (GETATOMVAL (QUOTE BYTELISPFLG)) T) 
"INTERLISP-MAXC") (T "INTERLISP-10"))) "  " (SUBSTRING (SETQ TEM (DATE)) 1 (IPLUS 2 (STRPOS (QUOTE -) TEM 4))) " ..."))))
(ADDTOVAR PREGREETFORMS (COND ((NEQ SYSTEMTYPE (SETQ SYSTEMTYPE (SYSTEMTYPE))) (SELECTQ SYSTEMTYPE (TOPS20 (SETQQ SYSOUT.EXT EXE) (
SETQQ EDITCHARACTERS (J A L Y K))) (TENEX (SETQQ SYSOUT.EXT SAV) (SETQQ EDITCHARACTERS (J X Z Y N))) (SHOULDNT)) (RESETTERMCHARS) (
RESETTERMCHARS ASKUSERTTBL))) (SETQ HOSTNAME (MKATOM (HOSTNAME))) (STATINIT))
(RPAQQ GREETDIRECTORY NIL)
(RPAQQ GREETFILE INIT)
(RPAQQ GREETEXT LISP)
(RPAQQ SYSTEMTERMTYPES ((15 . VT52) (16 . VT100)))
(RPAQQ OPENFNS (SETQ AND OR COND SELECTQ PROG PROGN PROG1 ARG SETARG ERSETQ NLSETQ RESETFORM RESETLST RESETVARS RPTQ SAVESETQ SETN 
UNDONLSETQ XNLSETQ APPLY*))
(RPAQQ GCGAG 40)
(RPAQQ GCMESS1 "
collecting ")
(RPAQQ GCMESS2 "
")
(RPAQQ GCMESS3 ", ")
(RPAQQ GCMESS4 " free cells")
(RPAQQ GCMESS5 40)
(RPAQQ GCMESS6 " pages left")
(RPAQQ GCMESS7 "
")
(GCGAG GCGAG)
(RPAQQ SPAGHETTIFLG T)
(RPAQQ **RETEVAL NIL)
(PUTPROPS LISPXWATCH 10MACRO ((X N) (ASSEMBLE NIL (CQ X) (E (COND ((QUOTE N) (CEXP2 (QUOTE (VAG (FIX N))))))) (STN (QUOTE ARRAYT)) (
E (STORIN (COND ((QUOTE N) (QUOTE (ADDM 2 , 0 (1)))) (T (QUOTE (AOS 0 (1))))))))))
(RPAQ? SYSTATS)
(RPAQQ SORTCOMS ((FNS SORT SORT1 ALPHORDER MERGE) (BLOCKS (MERGE MERGE ALPHORDER (NOLINKFNS . T)) (SORT SORT SORT1 ALPHORDER (
LOCALFREEVARS COMPAREFN) (NOLINKFNS . T)) (NIL ALPHORDER (LOCALVARS . T)))))
(RPAQQ MAX.INTEGER 34359738367)
(RPAQQ MIN.INTEGER -34359738368)
(RPAQ MAX.FLOAT (MKATOM (QUOTE "1.70141182E38")))
(RPAQ MIN.FLOAT (FMINUS MAX.FLOAT))
(RPAQQ FILENAMECOMS ((FNS FULLNAME OPENFILE PACKFILENAME UNPACKFILENAME FILENAMEFIELD LASTCHPOS) (DECLARE: EVAL@COMPILE DONTCOPY (
PROP MACRO CCONS CLIST) (PROP MACRO UNPACKFILE1 UNPACKFILE2)) (VARS FILENAMEFIELDS) (BLOCKS (NIL UNPACKFILENAME LASTCHPOS 
FILENAMEFIELD OPENFILE PACKFILENAME FULLNAME (LOCALVARS . T) (LINKFNS . T) (GLOBALVARS FILENAMEFIELDS)))))
(RPAQQ FILENAMEFIELDS (HOST DEVICE STRUCTURE DIRECTORY NAME EXTENSION VERSION TEMPORARY PROTECTION ACCOUNT))
(RPAQQ PRINTNUMCOMS ((FNS CPRINTNUM FLTFMT NUMFORMATCODE PRINTNUM) (PROP 10MACRO FLTFMT PRINTNUM) (VARS (NILNUMPRINTFLG)) (DECLARE: 
FIRST (P (MOVD? (QUOTE FLTFMT) (QUOTE OLDFLTFMT)))) (BLOCKS (NIL PRINTNUM NUMFORMATCODE (LOCALVARS . T) (GLOBALVARS MACSCRATCHSTRING
 NILNUMPRINTFLG)) (NIL CPRINTNUM FLTFMT (LOCALVARS . T)))))
(PUTPROPS FLTFMT 10MACRO (ARGS (CPRINTNUM (QUOTE FLTFMT) ARGS)))
(PUTPROPS PRINTNUM 10MACRO (ARGS (CPRINTNUM (QUOTE PRINTNUM) ARGS)))
(RPAQQ NILNUMPRINTFLG NIL)
(RPAQQ WAITFORINPUTCOMS ((FNS WAITFORINPUT WAITN WAITFILE) (DECLARE: EVAL@COMPILE DONTCOPY (P (LOAD? (QUOTE <LISPUSERS>CJSYS.COM) (
QUOTE SYSLOAD))) (ADDVARS (DONTCOMPILEFNS WAITN WAITFILE)) (PROP 10MACRO WAITN WAITFILE)) (BLOCKS (NIL WAITFORINPUT (LOCALVARS . T) 
(GLOBALVARS DISMISSINIT DISMISSMAX))) (VARS DISMISSINIT DISMISSMAX)))
(RPAQQ DISMISSINIT 500)
(RPAQQ DISMISSMAX 5000)
(PUTPROPS MACHINEDEPENDENT COPYRIGHT (NONE))
NIL
