(FILECREATED "20-SEP-83 20:38:59" ("compiled on " <LISPUSERS>NONDADDARITH.;17) (2 . 2) bcompl'd in 
WORK dated "19-JUN-83 15:13:55")
(FILECREATED "20-SEP-83 20:31:18" <LISPUSERS>NONDADDARITH.;17 36718 changes to: (FNS 
\DEPOSITBYTEEXPANDER) (VARS NONDADDARITHCOMS) previous date: "20-SEP-83 16:19:08" 
<LISPUSERS>NONDADDARITH.;13)

\MakeVector BINARY
      
        -.            ` ."  (Bÿ,   B  ,<  ,<p  ,<  ,<` &  	Zp  +    J   (N . 1)
ARRAY
1
SETA
(URET1 MKN ENTER1)        @      

\VectorREF BINARY
              -.           Z` ,   4"  	 ` ,>  ,>  ,<` ,<  $  ,      ,^  /  3"  +   ,<` ,<  $  ,~    ` A"  1B   +   ,<` ^"  ,>  ,>   ` (Bÿ.Bx  ,^  /  ,   D  ,~   ,<` ^"  ,>  ,>   ` (Bÿ.Bx  ,^  /  ,   D  ,~     L@D   (V . 1)
(I . 1)
1
ELT
"Index out of bounds"
ERROR
ELTD
(MKN BHC IUNBOX GUNBOX ENTER2)   (          p    0      

\VectorSET BINARY
      !         -.           Z` ,   4"  	 ` ,>  ,>  ,<` ,<  $  ,      ,^  /  3"  +   ,<` ,<  $  ,~    ` A"  1B   +   ,<` ^"  ,>  ,>   ` (Bÿ.Bx  ,^  /  ,   ,<  ,<` &  ,~   ,<` ^"  ,>  ,>   ` (Bÿ.Bx  ,^  /  ,   ,<  ,<` &  ,~     L@   (V . 1)
(I . 1)
(VAL . 1)
1
ELT
"Index out of bounds"
ERROR
SETA
SETD
(MKN BHC IUNBOX GUNBOX ENTER3)                         

\VectorLength BINARY
             -.           ,<` ,<  $  ,~       (V . 1)
1
ELT
(ENTER1)    

\MASK.1'S.EXPANDER BINARY
        M    F    Ê-.          FZ` ,<  [` Z  ,<  ,<   ,<w"  GZ  -,   Z   XBp  3B   +   AXBw,<wÿ"  GZ  -,   Z   XBp  3B   +   =XBwÿ,<   Zwþ-,   +    wþ1"   +    wþ0b  +   Zp  +   ,<wþ,<  Ç$  HXBwþ+   /  ,<   Zw-,   +    w1"   +    wþ,>  Å,>   w.Bx  ,^  /  0b  +   Zp  +   ",<w,<  È$  HXBw+   /  Z   ,>  Å,>   w(Bÿ.Bx  ,^  /  ."     ,>  Å,>   wA"  1B   +   «^"   +   ,^"  	"     ,^  /  (B  A"ÿ,<  Zp  ,>  Å,>   w(Bÿ.Bx  ,^  /  ."     ,>  Å,>   wA"  1B   +   ¸^"   +   9^"  	"     ,^  /  (B  A"ÿ/  +    Zw0B   +   A,<  I,<  É,<wþ,   +    ,<  I,<  I,<  J,<wý,   ,<  ,<wþ,   +      VB(
i B@ 8      (X . 1)
(VARIABLE-VALUE-CELL \MASKOUT.MARGIN . 69)
EVALUABLE.CONSTANTP
" is not a suitable value for the variable:  POSITION"
ERROR
" is not a suitable value for the variable:  SIZE"
\VectorREF
\RJ1M
\MASKOUT.MARGIN
(LIST3 ASZ URET3 BHC SKI KNIL ENTER1)  X D    h   ` Á X   P » @ ® p # `      x   p   x  P     P      

MASK.1'S BINARY
        6    ±    ´-.          ±,<   Z` -,   +    ` 1"   +    ` 0b  +   Zp  +   
,<` ,<  3$  ³XB` +   /  ,<   Z` -,   +    ` 1"   +    ` ,>  1,>   ` .Bx  ,^  /  0b  +   Zp  +   ,<` ,<  4$  ³XB` +   /  Z   ,>  1,>   ` (Bÿ.Bx  ,^  /  ."     ,>  1,>   ` A"  1B   +   ^"   +    ^"  	"     ,^  /  (B  A"ÿ,<  Zp  ,>  1,>   ` (Bÿ.Bx  ,^  /  ."     ,>  1,>   ` A"  1B   +   ¬^"   +   -^"  	"     ,^  /  (B  A"ÿ/  ,~     Z	 VH
 @P  (POSITION . 1)
(SIZE . 1)
(VARIABLE-VALUE-CELL \MASKOUT.MARGIN . 45)
" is not a suitable value for the variable:  POSITION"
ERROR
" is not a suitable value for the variable:  SIZE"
(BHC SKI KNIL ENTER2)  ¯   ¢ 0          8   8        

MASK.0'S BINARY
             -.           ^"ÿ,>  	,>  Z  ,<  ,<` ,<`  "  ,   ,   FBx  ,^  /  ,   ,~         (POSITION . 1)
(SIZE . 1)
MASK.1'S
(MKN BHC IUNBOX EVCC ENTER2)   	                   

BITTEST BINARY
              	-.            ` ,>  ,>   ` ABx  ,^  /  1B   +   7   Z   ,~        (N . 1)
(MASK . 1)
(KNIL KT BHC ENTER2)                  

BITSET BINARY
               -.            ` ,>  ,>   ` GBx  ,^  /  ,   ,~         (N . 1)
(MASK . 1)
(MKN BHC ENTER2)             

BITCLEAR BINARY
             -.            ` ,>  	,>  ^"ÿ,>  	,>   ` FBx  ,^  /  ABx  ,^  /  ,   ,~     @   (N . 1)
(MASK . 1)
(MKN BHC ENTER2)  	      p      

LOGNOT BINARY
             -.           ^"ÿ,>  ,>   ` FBx  ,^  /  ,   ,~         (N . 1)
(MKN BHC ENTER1)  `    X      

\SETUP.MASKARRAYS BINARY
   w   m   p-.          m^"  ,   ,<  ^"  ."  (Bÿ,   B n,<  Zp  ."  ,<  Zw,   ,\   B  Zp  /  /  XB   ,> k,>  ^"  	.Bx  ,^  /  ."  ,<  ^"   1B   +   Z  ,> k,>  ^"  	.Bx  ,^  /  ."     ,> k,>    ëABx  ,^  /  G" ÿ $   +   ¢Z  ,> k,>  ^"  	.Bx  ,^  /  ."     ,> k,>    lABx  ,^  /  G ì $   ,\   B  ^"  ,   ,<  ,\  ,<  ,<   ,< î p  ,> k,>   w   ,^  /  3b  +   ¬Zwÿ+   TZ  ,<  ,<wÿ^"  ,> k,>   w   ,^  /  (B  /"  ,   ,<  Zw,> k,>   wÿ(Bÿ.Bx  ,^  /  ."  ,<   wA"  1B   +   EZwþ,> k,>   w(Bÿ.Bx  ,^  /  ."     ,> k,>    ëABx  ZwÿA"ÿGBx  ,^  /   $   +   ÏZwþ,> k,>   w(Bÿ.Bx  ,^  /  ."     ,> k,>    lABx  ZwÿA"ÿ(B  	GBx  ,^  /   $   ,\   B  Zp  /   p  ."  ,   XBp  +   '/  ^"  ,   ,<  ^"  ."  (Bÿ,   B n,<  Zp  ."  ,<  Zw,   ,\   B  Zp  /  /  XB   ,> k,>  ^"   .Bx  ,^  /  ."  ,<  ^"   1B   +   nZ  ^,> k,>  ^"   .Bx  ,^  /  ."     ,> k,>    ëABx  Z  ¬A"ÿGBx  ,^  /   $   +   xZ  d,> k,>  ^"   .Bx  ,^  /  ."     ,> k,>    lABx  Z  êA"ÿ(B  	GBx  ,^  /   $   ,\   B  Z  ô,< o,<   ,< ï,<   ,<    w,> k,>   w~   ,^  /  3b  +  Zwþ+     w   ^"  /  ,   XBp   p  ."  ,   ,<   wÿ."  ."  (Bÿ,   B n,<  Zp  ."  ,<  Zw,   ,\   B  Zp  /  /  XBwÿ,<p  ,\  ,<  ,<   ,< î p  ,> k,>   w   ,^  /  3b  +  Zwÿ+  Ê,<w~,<wÿZ  y,> k,>   w(Bÿ.Bx  ,^  /  ."     ,> k,>   wA"  1B   +  ¡^"   +  "^"  	"     ,^  /  (B  A"ÿ,   ,> k,>   wü   ,^  /  (B  ,   ,<  Zw,> k,>   wÿ(Bÿ.Bx  ,^  /  ."  ,<   wA"  1B   +  »Zwþ,> k,>   w(Bÿ.Bx  ,^  /  ."     ,> k,>    ëABx  ZwÿA"ÿGBx  ,^  /   $   +  FZwþ,> k,>   w(Bÿ.Bx  ,^  /  ."     ,> k,>    lABx  ZwÿA"ÿ(B  	GBx  ,^  /   $   ,\   B  Zp  /   p  ."  ,   XBp  +  /  Z  n,> k,>   w(Bÿ.Bx  ,^  /  ."  ,<   wþA"  1B   +  ÜZ K,> k,>   wþ(Bÿ.Bx  ,^  /  ."     ,> k,>    ëABx  ZwA"ÿGBx  ,^  /   $   +  gZ R,> k,>   wþ(Bÿ.Bx  ,^  /  ."     ,> k,>    lABx  ZwA"ÿ(B  	GBx  ,^  /   $   ,\   B  Zwÿ w."  ,   XBw+   |  x    ÿ x    P(@P@ (@(   @(
 "    
D @ ( P  $ @(@      (VARIABLE-VALUE-CELL \RJ1M . 305)
(VARIABLE-VALUE-CELL \MASKOUT.MARGIN . 441)
ARRAY
0
36
1
(IUNBOX URET5 KNIL FIXT BHC GUNBOX MKN ENTER0)   `         ü @ { p   xÜ h»  n 
  E 0    g \ hÏ 8È `@ 0µ h) H ` p    r X h   Þ ` U 
  Ï 	 Ä p 8   +      p  0   P \    (J   h  V 
8 ³ P   0      

LOADBYTE BINARY
        <    µ    :-.          µ,<   Z` -,   +    ` 1"   +   Zp  +   ,<` ,<  ·$  8XB` +   /  ,<   Z` -,   +    ` 1"   +   Zp  +   ,<` ,<  ¸$  8XB` +   /  ,<   Z` -,   +   Zp  +   ,<  ,<  9$  8XB` +   /   ` ,>  5,>   ` "     ,^  /  (B  ,>  5,>  Z   ,<  ,<  ¹,<`  wÿ,>  5,>   p     ,^  /  3b  +   £Zp  +   $Zwÿ/  ,<  Zwÿ,>  5,>   p  (Bÿ.Bx  ,^  /  ."     ,>  5,>   p  A"  1B   +   .^"   +   ®^"  	"     ,^  /  (B  A"ÿ/  ,   ABx  ,^  /  ,   ,~     PJhVH$
       (N . 1)
(POS . 1)
(SIZE . 1)
(VARIABLE-VALUE-CELL \RJ1M . 56)
" is not a suitable value for the variable:  POS"
ERROR
" is not a suitable value for the variable:  SIZE"
" is not a suitable value for the variable:  N"
36
(MKN IUNBOX BHC SKI KNIL ENTER3)  P   0   H ²  © P " 0        0               

DEPOSITBYTE BINARY
       À    º    ¾-.            º,<   Z` -,   +    ` 1"   +    ` 0b  +   Zp  +   
,<` ,<  ¼$  =XB` +   /  ,<   Z` -,   +    ` 1"   +    ` ,>  :,>   ` .Bx  ,^  /  0b  +   Zp  +   ,<` ,<  ½$  =XB` +   /  ,<   Z` -,   +   Zp  +   ,<  ,<  >$  =XB` +   /   ` ,>  :,>  ^"ÿ,>  :,>  ^"ÿ,>  :,>   `    ^"  /  "     ,^  /  (B  ,>  :,>   `    ,^  /  (B  FBx  ,^  /  ABx   ` ,>  :,>  ^"ÿ,>  :,>   `    ^"  /  "     ,^  /  (B  ABx  ,^  /  ,>  :,>   `    ,^  /  (B  GBx  ,^  /  ,   ,~     Z	 VBZ$@ $      (N . 1)
(POS . 1)
(SIZE . 1)
(VAL . 1)
" is not a suitable value for the variable:  POS"
ERROR
" is not a suitable value for the variable:  SIZE"
" is not a suitable value for the variable:  N"
(MKN BHC SKI KNIL ENTER4)      · H ² 0 ) X  p  0      8   x   (      

\LDBEXPANDER BINARY
    p    c    ì-.           cZ` ,<  ,<   $  ã,<  [` Z  ,<  ,<   ,<   ,<   ,<   ,<wý"  dZ  XBwþ3B   +   -,   Z   Z  2B  ä+   ,<  e,<wý[wý[  Z  3B   +   3B   +   -,   +   ,<  å,<  ,   ,<  [w}Z  3B   +   3B   +   -,   +   ,<  å,<  ,   ,   +    ,<w~,<   $  ãXBwZwý-,   +   ÉZwý2B  f+   É[wýZ  Z  æ,   3B   +   É[wý[  Z  XBwþ-,   +   ÉZwþ2B  g+   ÉZwþ,<  [w~XBw~,\  Zwþ,<  [w~XBw~,\  XBwÿZwþ,<  [w~XBw~,\  XBp  ,<w"  dZ  -,   +   :,<w,<w$  ç3B   +   ?,<w,<wÿ$  ç3B   +   ?,<wÿ,<wÿ$  ç3B   +   ?,<w~,<wÿZwþZ   ,   ,   ,   Z  e,   +    Zw~Z  h,   Z  e,   Z   ,   Z  è,   Z  i,   Z  é,   ,<  ,<wZwZ   ,   ,   ,   +    Zwý-,   +   Ù,<w"  dZ  -,   +   P,<wý,<wþ$  ç3B   +   Ù,<w~Zw}Z   ,   Z  j,   ,<  ZwüZ   ,   Z  ê,   Z   ,   ,   ,   Z  e,   +    Zw~Z  k,   Z  e,   Z   ,   Z  ë,   Z  l,   Z  é,   ,<  Zw}Z   ,   ,   +     `+  JR@"E I!Q(        (X . 1)
LISPFORM.SIMPLIFY
EVALUABLE.CONSTANTP
BYTESPEC
LOADBYTE
QUOTE
CONS
((QUOTE BYTESPEC) . 0)
LIST
ARGS.COMMUTABLEP
((\Byteposition \Bytesize) . 0)
((DECLARE (LOCALVARS \Bytesize \Byteposition)) . 0)
((\Bytesize \Byteposition) . 0)
LAMBDA
BYTEPOSITION
BYTESIZE
(((BYTEPOSITION \PositionSize) (BYTESIZE \PositionSize)) . 0)
((DECLARE (LOCALVARS \PositionSize)) . 0)
((\PositionSize) . 0)
(SKLA CONS21 CONSS1 CONS SKNI EQUAL URET6 ALIST4 LIST2 SKNNM SKLST KNIL KT ENTER1)  K    à x Þ H Ù 
h Ó ` E @ B p   0 Ø   É 	 > X   ( Ý 8 × 
X Ò 	 C  =    Í (   (   8 Z 	  ¿ 8   0   (      (   `  8     ] 
p U 
  P 	  Â H : x 5 0    (   x   h   H          

\DPBEXPANDER BINARY
           -.          Z` ,<  [` Z  ,<  ,<   $ 	,<  [` [  Z  ,<  ,<   $ 	,<  ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,<   Zwú-,   +   &Zwú2B +   &[wúZ  Z 
,   3B   +   &[wú[  Z  XBp  -,   +   &Zp  2B +   &Zp  ,<  [wÿXBwÿ,\  Zp  ,<  [wÿXBwÿ,\  XBwûZp  ,<  [wÿXBwÿ,\  XBw|,<wû" 3B   +   ¤,<w|" +   %Z   XBwÿ+   9,<wú" Z  XBp  3B   +   9-,   Z   Z  2B +   9[p  Z  3B   +   13B   +   1-,   +   1,< ,<  ,   XBwû[p  [  Z  3B   +   ·3B   +   ·-,   +   ·,< ,<  ,   XBw|Z   XBwÿ,<wz,<   $ 	XBw~,<  ,<wú$ 2B   +   ¾Z   +   ÄZwÿ2B   +   D,<w~,<wz$ 2B   +   C7   Z   +   ÄZ   XBwý3B   +   GZ +   ÇZwzXBwþZwû3B   +   eZw|3B   +   eZwÿ2B   +   Ñ,<wû,<wû$ 3B   +   ×,<w{,<wz$ 3B   +   ×,<w{,<wû,<wúZw}Z   ,   ,   ,   ,   Z ,   +   ý,<w{Zw~Z   ,   Z ,   Z ,   ,   Z ,   Z   ,   Z ,   Z ,   Z ,   ,<  ,<w{Zw{Z   ,   ,   ,   +   ýZwú-,   +   ó,<w{D 3B   +   ó,<w{ZwzZ   ,   Z ,   ,<  ZwùZ   ,   Z ,   ,<  Zw}Z   ,   ,   ,   ,   Z ,   +   ýZ   XBwýZw{Z ,   Z ,   Z   ,   Z ,   Z ,   Z ,   ,<  ZwzZ   ,   ,   XBwZwý3B   +  ZwZ   ,   Z ,   Z ,   Z ,   ,<  ZwùZ   ,   ,   +  Zw/  ,~    H  JE0@"R)% Ð$* JBE
@(       (X . 1)
LISPFORM.SIMPLIFY
CONS
((QUOTE BYTESPEC) . 0)
LIST
EVALUABLE.CONSTANTP
BYTESPEC
QUOTE
ARGS.COMMUTABLEP
\NewByte
DEPOSITBYTE
\Bytesize
\Byteposition
((DECLARE (LOCALVARS \Bytesize \Byteposition)) . 0)
((\Bytesize \Byteposition) . 0)
LAMBDA
BYTEPOSITION
BYTESIZE
(((BYTEPOSITION \ByteSpec) (BYTESIZE \ByteSpec) \NewByte) . 0)
((DECLARE (LOCALVARS \ByteSpec)) . 0)
((\ByteSpec) . 0)
((DECLARE (LOCALVARS \NewByte)) . 0)
((\NewByte) . 0)
(BHC SKLA CONS21 CONSS1 CONS LIST2 SKNNM EQUAL SKLST KNIL KT ENTER1)      h   H ( û ( ù x ó p l  à x Ý @ [ 
x   p ~ ( r  e H Ü 
h V 
X   h X ø h q ` k @ Þ   U    8    ` ¯        * p      ÿ P x  í ( è 8 ^  Ô 
 O 	H K 	 F P D ( @ X 4 X ª  ¥ 0  h  X  H  8  ( 
    ô 8 ¾ ( 9 P ®         

\LOADBYTEEXPANDER BINARY
      \    Ó    Ù-.           Ó,<   [` [  Z  B  TZ  -,   Z   XBp  2B   +   [` Z  B  TZ  -,   Z   ,<  Zp  3B   +   Z` ,<  ZwÿZ   ,   ,   Z  Ô,   ,<  [` [  Z  Z   ,   Z$   ,   Z  U,   Z   ,   ,   Z  Õ,   +   Z  V/  +   R-,   +    p  1"   +    p  0"   +    [` [  Z  ,<  ,<  Ö$  WZp  0B   +   ¦,<  ×Z` ,<  [` Z  ,<  ,<  X,   +   RZ` ,<  [` Z  ,<   w0b  +   ±^"ÿ,>  S,>   w   ^"  /  "     ,^  /  (B  ,   +   9^"ÿ,>  S,>  ^"ÿ,>  S,>   w   ,^  /  (B  FBx  ,^  /  ,   ,<  ,<   ,<w"  TZ  -,   Z   XBp  3B   +   K-,   +   B p  1"   +   B p  0"   +   Ã,<w,<  Ø$  WZp  XBw,<wþ"  TZ  -,   Z   XBp  3B   +   K,<  ,<wþ,<w}&  Y+   Ñ,<  ÕZwþ0B   +   NZw~+   P,<  Ô,<wý,<  ,   ,<  ,<wþ,   /  /  ,~     AR!L@H )G   (X . 1)
EVALUABLE.CONSTANTP
LRSH
MASK.1'S
LOGAND
IGNOREMACRO
"Byte size out of range"
ERROR
PROGN
0
"Byte position out of range"
LOADBYTE
(LIST3 MKN LIST4 BHC ASZ CONS21 CONSS1 CONS SKI KNIL ENTER1) 
  Ð    ¹    h   
0 Ò  7      M        X     p      8     G p ¼ ( 
  X   	 Ç ` = (  0  @   p   (      

\DEPOSITBYTEEXPANDER BINARY
           -.          [` Z  B 
Z  -,   Z   ,<  [` [  Z  B 
Z  -,   Z   ,<  Zp  3B   +    p  0b   +   Zp  0B   +   ,< Z` ,<  [` Z  ,<  [` [  [  Z  ,   +  [` [  Z  ,<  ,< $ +  Zwÿ3B   +    wÿ0"   +   [` Z  ,<  ,< $ +  Zp  3B   +    Zwÿ3B   +    +   ¡Z +  Z` ,<  [` [  [  Z  ,<   w0b  +   ­^"ÿ,> 	,>   w   ^"  /  "     ,^  /  (B  ,   +   5^"ÿ,> 	,>  ^"ÿ,> 	,>   w   ,^  /  (B  FBx  ,^  /  ,   ,<  ,<   ,<   ,<w~" 
Z  -,   Z   XBwÿ,<wþ" 
Z  -,   Z   XBp  3B   +   B p  ,> 	,>   wABx  ,^  /  ,   XBp  Zwÿ3B   +   ÇZp  3B   +   Ç,<wÿ,<wü,<wüH +  Zwÿ3B   +   ß,< ,<w~,<w~,   ,<  Zwü1B   +   Ï,< ,<wÿ,<  ,   XBp   w,> 	,>  ^"ÿ,> 	,>   wþ,> 	,>   wü   ,^  /  (B  FBx  ,^  /  ABx  ,^  /  ,   XBw0B   +   ÜZp  +   Þ,< ,<  ,<w,   /  +  ,<w~ wþ,> 	,>   wü   ,^  /  (B  ,   Z   ,   ,   Z ,   ,<  Zwÿ3B   +   ï wÿ,> 	,>   wþABx  ,^  /  ,   XBwÿ0B   +   ïZp  +  3B   +   ôZwþZwÿ2B  +   ôZ [p  ,   +  Zwÿ3B   +   û wÿ,> 	,>   wü   ,^  /  (B  ,   XBw~+  ,<w~Zw~Z   ,   ,   Z ,   XBw~Zwü1B   +  ,< ,<wý,<  ,   XBw~,<p  ZwýZ   ,   ,   Z ,   /  /  /  ,~      r#Ip   P#0  	 (#@C   (X . 1)
EVALUABLE.CONSTANTP
PROG1
"Byte size out of range"
ERROR
"Byte position out of range"
IGNOREMACRO
\XDEPOSITBYTE
LOGAND
LLSH
LOGOR
BITCLEAR
BITSET
(CONS21 CONSS1 CONS LIST3 MKN BHC ALIST4 ASZ KNIL SKI ENTER1)   x ÿ x   h þ h   ` ~ H f    p Ï 	8   0 í P Ú   µ X      z P d x Z  Ö  5 0 ¬        h Û 	P     X v  i X I P Ã X ¼  7 h   h  ( 	  P   @ 9         

\GETBASE BINARY
             -.           Z` ,>  ,>   ` .Bx  ,^  /     ,   ,~         (BASE . 1)
(OFFST . 1)
(MKN BHC ENTER2)              

\PUTBASE BINARY
         	    -.           	Z` ,>  ,>   ` .Bx  ,^  /  ,<  Z` ,   ,\   B  Z` ,~         (BASE . 1)
(OFFST . 1)
(VAL . 1)
(GUNBOX BHC ENTER3)  p    X      

\GETBASEPTR BINARY
             -.           Z` ,>  ,>   ` (Bÿ.Bx  ,^  /     ,>  ,>   ` A"  1B   +   
^"   +   ^"  	"     ,^  /  (B  ,~     
  (BASE . 1)
(OFFST . 1)
(BHC ENTER2)    `      

\PUTBASEPTR BINARY
             -.           Z` ,>  ,>   ` (Bÿ.Bx  ,^  /  ,<  Z` ,>  ,>   ` (Bÿ.Bx  ,^  /     ,   ,<   ` A"  1B   +   Z"   +   Z"  	,<  ,<  Z` ,   H  ,   ,\   B  Z` ,~      I     (BASE . 1)
(OFFST . 1)
(VAL . 1)
18
DEPOSITBYTE
(GUNBOX ASZ MKN BHC ENTER3) (   x      8   (        

\GETBASEFIXP BINARY
              -.           Z` ,>  ,>   ` .Bx  ,^  /     ,   ,~         (BASE . 1)
(OFFST . 1)
(MKN BHC ENTER2)              

\PUTBASEFIXP BINARY
          	    -.           	Z` ,>  ,>   ` .Bx  ,^  /  ,<  Z` ,   ,\   B  Z` ,~         (BASE . 1)
(OFFST . 1)
(VAL . 1)
(GUNBOX BHC ENTER3)  p    X      

\GETBASEFLOATP BINARY
               -.           Z` ,>  ,>   ` .Bx  ,^  /     ,   ,~         (BASE . 1)
(OFFST . 1)
(MKFN BHC ENTER2)             

\PUTBASEFLOATP BINARY
        
    -.           
Z` ,>  ,>   ` .Bx  ,^  /  ,<  Z` ,      ,\   D     ,   ,~         (BASE . 1)
(OFFST . 1)
(VAL . 1)
(MKFN FUNBOX BHC ENTER3)     p    X      

\GETBASEDOUBLEBYTE BINARY
                -.           Z` ,>  ,>   ` (Bÿ.Bx  ,^  /     ,>  ,>   ` A"  1B   +   
^"  +   ^"  
"     ,^  /  (B  A"ÿ,   ,~     
  (BASE . 1)
(OFFST . 1)
(MKN BHC ENTER2)         `      

\PUTBASEDOUBLEBYTE BINARY
                -.           Z` ,>  ,>   ` (Bÿ.Bx  ,^  /  ,<  Z` ,>  ,>   ` (Bÿ.Bx  ,^  /     ,   ,<   ` A"  1B   +   Z"  +   Z"  
,<  ,<  ,<` (  ,   ,\   B  ,   ,~      J     (BASE . 1)
(OFFST . 1)
(VAL . 1)
16
DEPOSITBYTE
(GUNBOX ASZ MKN BHC ENTER3)     x      8   (        

\GETBASEBYTE BINARY
              -.           Z` ,>  ,>   ` (B.Bx  ,^  /     ,>  ,>  ^"  ,>  ,>   ` A"     ^"  /  (B  .Bx  ,^  /  "     ,^  /  (B  A"  ÿ,   ,~             (BASE . 1)
(OFFST . 1)
(MKN BHC ENTER2)        X        

\PUTBASEBYTE BINARY
              -.           Z` ,>  ,>   ` (B.Bx  ,^  /  ,<  Z` ,>  ,>   ` (B.Bx  ,^  /     ,   ,<  ^"  ,>  ,>   ` A"     ^"  /  (B  .Bx  ,^  /  ,   ,<  ,<  ,<` (  ,   ,\   B  ,   ,~       (    (BASE . 1)
(OFFST . 1)
(VAL . 1)
8
DEPOSITBYTE
(GUNBOX MKN BHC ENTER3) P   h  8       `      

\GETBASENIBBLE BINARY
               -.           Z` ,>  ,>   ` &"  .Bx  ,^  /     ,>  ,>   ` &"        ^"  /  (B  "     ,^  /  (B  A"  ,   ,~        (BASE . 1)
(OFFST . 1)
(MKN BHC ENTER2)         `      

\PUTBASENIBBLE BINARY
               -.           Z` ,>  ,>   ` &"  .Bx  ,^  /  ,<  Z` ,>  ,>   ` &"  .Bx  ,^  /     ,   ,<   ` &"        ^"  /  (B  ,   ,<  ,<  ,<` (  ,   ,\   B  ,   ,~            (BASE . 1)
(OFFST . 1)
(VAL . 1)
4
DEPOSITBYTE
(GUNBOX MKN BHC ENTER3) (   @  8   (        

\GETBASEBIT BINARY
               -.           Z` ,>  ,>   ` &"  .Bx  ,^  /     ,>  ,>     ,>  ,>   ` &"     "     ,^  /  (B  ABx  ,^  /  1B   +   Z"  ,~   Z"   ,~     @    `       (BASE . 1)
(OFFST . 1)
(ASZ BHC ENTER2)        h   `      

\PUTBASEBIT BINARY
     ¯    ¬    .-.           ¬Z` ,>  «,>   ` &"  .Bx  ,^  /     ,>  «,>     ,,>  «,>   ` &"     "     ,^  /  (B  ABx  ,^  /  1B   +   7   Z   ,<  Z` 0B   +   Zp  3B   +   §+   Zp  2B   +   §Z` ,>  «,>   ` &"  .Bx  ,^  /  ,<  Z` ,>  «,>   ` &"  .Bx  ,^  /     ,>  «,>     ,,>  «,>   ` &"     "     ,^  /  (B  FBx  ,^  /  ,\   B  Zp  3B   +   *Z"  +   ªZ"   /  ,~     @    `   @    (BASE . 1)
(OFFST . 1)
(VAL . 1)
(ASZ KNIL KT BHC ENTER3) 0 *       8         « p % h  h   `      
(PRETTYCOMPRINT NONDADDARITHCOMS)
(RPAQQ NONDADDARITHCOMS ((FILES MACROAUX) (LOCALVARS . T) (DECLARE: EVAL@COMPILE (P (MAPC (QUOTE ((
\PTRBLOCK.GCT T) (BITSPERNIBBLE 4) (BITSPERBYTE 8) (BITSPERDOUBLEBYTE 16) (BITSPERCELL (32 36)))) (
FUNCTION (LAMBDA (Y) (PROG ((X (CAR Y)) (VALUE (CADR Y))) (AND (LISTP VALUE) (SETQ VALUE (SELECTQ (
SYSTEMTYPE) (VAX (CAR VALUE)) (CADR VALUE)))) (COND ((NEQ VALUE (CAR (CONSTANTEXPRESSIONP X))) (SET X 
VALUE) (APPLY (FUNCTION CONSTANTS) (LIST (LIST X VALUE))))))))) (OR (CONSTANTEXPRESSIONP (QUOTE 
BITS.PER.FIXP)) (PROGN (SETQ BITS.PER.FIXP BITSPERCELL) (CONSTANTS BITS.PER.FIXP))) (OR (
CONSTANTEXPRESSIONP (QUOTE MAX.FIXP)) (PROGN (SETQ MAX.FIXP (LOGOR (LLSH 1 (SUB1 BITS.PER.FIXP)) (SUB1
 (LLSH 1 (SUB1 BITS.PER.FIXP))))) (CONSTANTS MAX.FIXP)))) (DECLARE: DONTCOPY (P (SETQ CLISPIFTRANFLG T
)) (MACROS NNLITATOM \MACRO.MX \CHECKTYPE \CHECK.BYTESPEC \INDEXABLE.FIXP) (RECORDS NONDADDARITHFLONUM
))) (COMS (* Vector functions, and basic new arithmetic functions) (FNS \MakeVector \VectorREF 
\VectorSET \VectorLength) (MACROS \MakeVector \VectorREF \VectorSET \VectorLength) (PROP GLOBALVAR 
\RJ1M \MASKOUT.MARGIN) (MACROS MASK.1'S MASK.0'S BITTEST BITSET BITCLEAR LOGNOT) (FNS 
\MASK.1'S.EXPANDER) (FNS MASK.1'S MASK.0'S BITTEST BITSET BITCLEAR LOGNOT) (FNS \SETUP.MASKARRAYS) (
RECORDS BYTESPEC) (FNS LOADBYTE DEPOSITBYTE) (MACROS LOADBYTE DEPOSITBYTE LDB DPB BYTE BYTESIZE 
BYTEPOSITION) (FNS \LDBEXPANDER \DPBEXPANDER \LOADBYTEEXPANDER \DEPOSITBYTEEXPANDER)) (DECLARE: 
EVAL@COMPILE DONTCOPY (* Grumble lossaged due to failure of (FNS ...) when merely EVAL@COMPILE) (FNS 
\SETUP.MASKARRAYS \MASK.1'S.EXPANDER \LOADBYTEEXPANDER \DEPOSITBYTEEXPANDER)) (DECLARE: EVAL@COMPILE 
DONTEVAL@LOAD DOCOPY (P (\SETUP.MASKARRAYS))) (COMS (* Primitive functions, especially needed for 
CommonLisp array package.) (DECLARE: DONTCOPY (MACROS \GETBASE \PUTBASE \GETBASEPTR \PUTBASEPTR 
\GETBASEFIXP \PUTBASEFIXP \GETBASEFLOATP \PUTBASEFLOATP \GETBASEDOUBLEBYTE \PUTBASEDOUBLEBYTE 
\GETBASEBYTE \PUTBASEBYTE \GETBASENIBBLE \PUTBASENIBBLE \GETBASEBIT \PUTBASEBIT)) (FNS \GETBASE 
\PUTBASE \GETBASEPTR \PUTBASEPTR \GETBASEFIXP \PUTBASEFIXP \GETBASEFLOATP \PUTBASEFLOATP 
\GETBASEDOUBLEBYTE \PUTBASEDOUBLEBYTE \GETBASEBYTE \PUTBASEBYTE \GETBASENIBBLE \PUTBASENIBBLE 
\GETBASEBIT \PUTBASEBIT))))
(FILESLOAD MACROAUX)
(MAPC (QUOTE ((\PTRBLOCK.GCT T) (BITSPERNIBBLE 4) (BITSPERBYTE 8) (BITSPERDOUBLEBYTE 16) (BITSPERCELL 
(32 36)))) (FUNCTION (LAMBDA (Y) (PROG ((X (CAR Y)) (VALUE (CADR Y))) (AND (LISTP VALUE) (SETQ VALUE (
SELECTQ (SYSTEMTYPE) (VAX (CAR VALUE)) (CADR VALUE)))) (COND ((NEQ VALUE (CAR (CONSTANTEXPRESSIONP X))
) (SET X VALUE) (APPLY (FUNCTION CONSTANTS) (LIST (LIST X VALUE)))))))))
(OR (CONSTANTEXPRESSIONP (QUOTE BITS.PER.FIXP)) (PROGN (SETQ BITS.PER.FIXP BITSPERCELL) (CONSTANTS 
BITS.PER.FIXP)))
(OR (CONSTANTEXPRESSIONP (QUOTE MAX.FIXP)) (PROGN (SETQ MAX.FIXP (LOGOR (LLSH 1 (SUB1 BITS.PER.FIXP)) 
(SUB1 (LLSH 1 (SUB1 BITS.PER.FIXP))))) (CONSTANTS MAX.FIXP)))
(DECLARE: DONTCOPY (SETQ CLISPIFTRANFLG T) (DECLARE: EVAL@COMPILE (PUTPROPS NNLITATOM MACRO (
OPENLAMBDA (X) (AND X (LITATOM X)))) (PUTPROPS \MACRO.MX MACRO (Z (PROG ((X (EXPANDMACRO (CAR Z) T))) 
(COND ((EQ X (CAR Z)) (ERROR "No macro property -- \MACRO.MX" X)) (T (RETURN X)))))) (PUTPROPS 
\CHECKTYPE MACRO (X (PROG ((VAR (CAR X)) (PRED (CADR X))) (if (AND (LISTP PRED) (MEMB (CAR PRED) (
QUOTE (QUOTE FUNCTION)))) then (SETQ PRED (LIST (CADR PRED) VAR))) (RETURN (SUBPAIR (QUOTE (MSG VAR 
PRED)) (LIST (CONCAT " is not a suitable value for the variable:  " VAR) VAR PRED) (QUOTE (until PRED do (SETQ VAR (ERROR 
VAR MSG))))))))) (PUTPROPS \CHECK.BYTESPEC MACRO (X (PROG ((POS (CAR X)) (SIZE (CADR X)) (LENGTHLIMIT 
(CADDR X))) (* Currently, this macro may only be call with "pos" and "size" arguments as litatoms, so 
that they may be "SETQ'd" in-line.) (if (NOT (NNLITATOM POS)) then (SETERRORN 14 POS) (ERRORX) elseif 
(NOT (NNLITATOM SIZE)) then (SETERRORN 14 SIZE) (ERRORX) elseif (AND LENGTHLIMIT (NOT (LITATOM 
LENGTHLIMIT))) then (SETERRORN 14 LENGTHLIMIT) (ERRORX)) (RETURN (BQUOTE (PROGN (\CHECKTYPE , POS (AND
 (\INDEXABLE.FIXP , POS) ,@ (AND LENGTHLIMIT (BQUOTE ((ILEQ , POS , LENGTHLIMIT)))))) (\CHECKTYPE , 
SIZE (AND (\INDEXABLE.FIXP , SIZE) ,@ (AND LENGTHLIMIT (BQUOTE ((ILEQ (IPLUS , POS , SIZE) , 
LENGTHLIMIT)))))))))))) (PUTPROPS \INDEXABLE.FIXP MACRO (OPENLAMBDA (X) (AND (FIXP X) (IGEQ X 0)))) (
PUTPROPS \INDEXABLE.FIXP DMACRO (OPENLAMBDA (X) (AND (SMALLP X) (IGEQ X 0))))) (DECLARE: EVAL@COMPILE 
(BLOCKRECORD NONDADDARITHFLONUM ((FLONUM FLOATP)))))
(PUTPROPS \MakeVector 10MACRO ((N) ((LAMBDA (LEN) (DECLARE (LOCALVARS LEN)) ((LAMBDA (A) (DECLARE (
LOCALVARS A)) (CLOSER (IPLUS (LOC A) 2) LEN) A) (ARRAY (LRSH (IPLUS N 3) 1)))) N)))
(PUTPROPS \VectorREF 10MACRO (OPENLAMBDA (V I) (VAG (LOADBYTE (OPENR (IPLUS (LOC V) 3 (LRSH I 1))) (
COND ((ODDP I) 0) (T 18)) 18))))
(PUTPROPS \VectorSET 10MACRO (OPENLAMBDA (BASE OFFST VAL) (* The reason for this kludgy duplication is
 so that the 10 compiler can open-code the arithmetic) (CLOSER (IPLUS (LOC BASE) 3 (LRSH OFFST 1)) (
COND ((ODDP OFFST) (DEPOSITBYTE (OPENR (IPLUS (LOC BASE) 3 (LRSH OFFST 1))) 0 18 (LOC VAL))) (T (
DEPOSITBYTE (OPENR (IPLUS (LOC BASE) 3 (LRSH OFFST 1))) 18 18 (LOC VAL))))) VAL))
(PUTPROPS \VectorLength 10MACRO ((V) (VAG (OPENR (IPLUS 2 (LOC V))))))
(PUTPROPS \RJ1M GLOBALVAR T)
(PUTPROPS \MASKOUT.MARGIN GLOBALVAR T)
(PUTPROPS MASK.1'S MACRO (X (\MASK.1'S.EXPANDER X)))
(PUTPROPS MASK.0'S MACRO (X (PROG ((POSITION (CAR X)) (SIZE (CADR X)) TEM) (* This used to have a lot 
more in it, but I decided that it really isn't an important function.) (RETURN (if (AND (SETQ TEM (
EVALUABLE.CONSTANT.FIXP POSITION)) (SETQ POSITION TEM) (SETQ TEM (EVALUABLE.CONSTANT.FIXP SIZE)) (SETQ
 SIZE TEM)) then (MASK.0'S POSITION SIZE) else (LIST (QUOTE LOGNOT) (LIST (QUOTE MASK.1'S) POSITION 
SIZE)))))))
(PUTPROPS BITTEST MACRO ((N MASK) (NEQ 0 (LOGAND N MASK))))
(PUTPROPS BITSET MACRO (= . LOGOR))
(PUTPROPS BITCLEAR MACRO ((X MASK) (LOGAND X (LOGXOR -1 MASK))))
(PUTPROPS LOGNOT MACRO ((N) (LOGXOR -1 N)))
(TYPERECORD BYTESPEC (BYTESPEC.SIZE BYTESPEC.POSITION))
(PUTPROPS LOADBYTE MACRO (X (\LOADBYTEEXPANDER X)))
(PUTPROPS DEPOSITBYTE MACRO (X (\DEPOSITBYTEEXPANDER X)))
(PUTPROPS LDB MACRO (X (\LDBEXPANDER X)))
(PUTPROPS DPB MACRO (X (\DPBEXPANDER X)))
(PUTPROPS BYTE MACRO (X (PROG ((SIZE (LISPFORM.SIMPLIFY (CAR X) T)) (POSITION (LISPFORM.SIMPLIFY (CADR
 X) T))) (RETURN (if (AND (FIXP POSITION) (FIXP SIZE)) then (KWOTE (create BYTESPEC BYTESPEC.SIZE _ 
SIZE BYTESPEC.POSITION _ POSITION)) else (BQUOTE (create BYTESPEC BYTESPEC.SIZE _ , SIZE 
BYTESPEC.POSITION _ , POSITION)))))))
(PUTPROPS BYTESIZE MACRO ((BYTESPEC) (fetch BYTESPEC.SIZE of BYTESPEC)))
(PUTPROPS BYTEPOSITION MACRO ((BYTESPEC) (fetch BYTESPEC.POSITION of BYTESPEC)))
(\SETUP.MASKARRAYS)
(PUTPROPS NONDADDARITH COPYRIGHT ("Xerox Corporation" 1983))
NIL
