(FILECREATED " 8-AUG-84 23:34:42" ("compiled on " <MASINTER>HASH.;1) (2 . 2) bcompl'd in "INTERLISP-10  15-Jul-84 ..." dated 
"15-Jul-84 19:32:15")
(FILECREATED " 8-Jun-84 17:17:26" {ERIS}<LISPCORE>LIBRARY>HASH.;3 23432 changes to: (VARS HASHCOMS) previous date: 
"26-Feb-84 09:34:10" {ERIS}<LISPCORE>LIBRARY>HASH.;1)

HASHFILEBLOCKA0004 BINARY
                -.          Z   3B   +   ,<`  "  +   Z`  ,<   Z  3B   +   ,<` "  +   	Z` ,   Z   ,   XB  	,~   a0  (KEY1 . 1)
(KEY2 . 1)
(VARIABLE-VALUE-CELL MKSTRING? . 11)
(VARIABLE-VALUE-CELL KEYLST . 21)
MKSTRING
(CONS CONSS1 KNIL ENTER2)      
      0      

HASHFILEBLOCKA0005 BINARY
        	        	-.          Z   3B   +   ,<`  "  +   Z`  Z   ,   XB  ,~   `   (KEY . 1)
(VARIABLE-VALUE-CELL MKSTRING? . 3)
(VARIABLE-VALUE-CELL KEYLST . 12)
MKSTRING
(CONS KNIL ENTER1)              

HASHFILEBLOCKA0006 BINARY
             -.          ,<`  Z   ,<   Z   ,<  Z   H  ,~      (KEY . 1)
(VARIABLE-VALUE-CELL HFILE . 4)
(VARIABLE-VALUE-CELL NEWHASHFILE . 6)
(VARIABLE-VALUE-CELL FN . 8)
COPYHASHITEM
(ENTER1)    

HASHFILEBLOCKA0007 BINARY
            
    -.          
Z   3B   +   ,<`  ,<  $  Z  2B  7   7   +   	,<`  "  ,~   ,<`  "  ,~   a$  (KEY . 1)
(VARIABLE-VALUE-CELL XWORD . 9)
1
NTHCHAR
PRODUCE
(KT KNIL ENTER1)         0      

HASHFILEBLOCKA0008 BINARY
                -.           ,<`  ,<  ,<   $  ,\   ,~       (X . 1)
"."
PRIN1
(KT ENTER1)         

HASHFILEBLOCK BINARY
    4   I   -.          I-.     XI~xO            +    8    K    m   a   G   S   _   u      K   3      F   S    Zw3B   +    ,<   ,<   Z   2B   +   Zw+   Z  XBp  Zp  b W3B   +   Zp  b X[p  ,<   ,< Y,<    Z[  XB  +   /  Z   XB   +        Zw2B   +   Z  ,<   ,<   , _XBw3B   +    ,<   ,< [ [b XZp  3B   +   ),<w,< [ [,<   ,<w,<   ,<   ,<   , +    ,<w,< [ [+        ,  ,,~   -.    \@ ]   ,~   Zp  Z8 3B   +   4,<8  Z ^,<   ,<   , 3+   6,<8  Z ^,<   ,<   , 3Z   ,~        ,  9,~   -.    _Z   ,<   ,<   , 2XB  :,<   ,<` ,<   ,<   ,<w~,< ` [,<   ,<   ,  m,<   @ a    +   IZ  <,<   Z a,<   ,<   , 3Z   ,<   ,<   ,  Z  F,~   /   ,~        Zp  3B   +   ^,<w~,<   ,<w},<w},<   ,<w,<wZp  2B   +   RZw+   T,<wZ   ,<  f b/  ,<   ,<   ,<w~,< c,<   , K/  ,<   ,<w},<w} "  ,   ,<   ,<w~,< c,<   , K+    ,<w~,<w~,<w~,<   ,<w,<wZp  2B   +   cZw+   e,<wZ  S,<  f b/  ,<   ,<   ,<w~,< c,<   , K/  ,<   ,<w~,< c,<   , K+      (  Zw2B   +   pZ   ,   +   p,   ,> H,>   Z   ,   Bx  ,^   /   ,   ,   ,<   , >,<   ,<   ,<   ,<w|,< d,< d,< e,< e
 fXBp  ,<   ^"   ,   d g,<p  ^"   ,   d g,<p  ^"  ,> H,>    w~(|ABx  ,^   /   ,   d g,<p  ^"  ,> H,>    w~ABx  ,^   /   ,   d g,<p   w~."   $"  ,   d h,<p  ,< i gZw~-,   +  +  ,< e iXBw,<   ,< j,<w~ Z,<w,< `,< i Z,<p   X,<w|,< d,< k,< e,< k
 fXBp  ,<w,< [f Z,<w,< e,<    Z,<w, +Zw/  ,~   ,<p  ,< [ [,<   ,<w h,<p  ,< l [,<   ,< l g,<p  ,< `,<w,< ` [,   /"   ,   f Z,<p  ,< [ [,<   ,< i h,<p  ,< l [,<   ^"  ,> H,>   ,<w,< ` [,   (|ABx  ,^   /   ,   d g,<p  ,< l [,<   ^"  ,> H,>   ,<w,< ` [,   ABx  ,^   /   ,   d g+     p  G"   ,   ,<   ,<   ,< j,<    w,> H,>    w~    ,^   /   2"  +  M w~,> H,>    w    ,^   /   &     0B   +  MZ   XBp  +  X w~,> H,>    w,> H,>    w$Bx  ,^   /       ,^   /   2"  +  U+  X w."  ,   XBw+  BZp  /  3B   +  ]Zw2B   +  \Z   XBp  +  _ w."  ,   XBw+  AZp  +        ,<w,<wZp  2B   +  dZw+  f,<wZ  d,<  f b/  ,<   ,<   ,<w~,< c,<   , K+    ,<w,<w,< j [,<   ,  ,<   ,<   ,<   ,<w~,< [ [,<   ,<w~ hZw~3B   +  x,<w~,< l [b m0B   +  w+  %0B  "+  }+  %,<w~,< l [b m,<   Z"   ,\  2B  +  }+  %,<w~,< [ [,<   ,<w},< l [b m,   (B  ,> H,>   ,<w},< l [b m,   (B  .Bx  ,<w},< l [b m,   .Bx  ,^   /   ,   d h,<w},<w},< [ [,<   Z   d n,\  ,   3B   +  Zw+    Zp  2B   +  ,<w}, 'XBp  ,<w,<   ,<w},< j [,<    w,> H,>    w(B.Bx  ,^   /   ,   ,<   ,<w o,   ."   (B  ,   /  XBw,<w~,< [ [,<   ,<w~ h+  r w"   ,   +    Z   ,<   ^"  ,> H,>   ,<w,<w p,   (B."   ,   d qb r,   ABx  ,^   /   ."   ,   d sZ  +    ,<   Zw2B   +  5Z  XBw,<   ,<w, _2B   +    Zw3B   +  CXBp  -,   +  ?Zw-,   +  C,<   ,< [ [XBp  -,   +  C,<   ,<w,<   ,<   ,<w}, 2B   +    Z   XBp  ,<w,< t$ t+        ,<p  Z  d u,<   ,<   [wXBp  3B   +  RZ 42B  +  NZ   XB K,<wZ Gd vXB N,<p  ,< Y,<    ZZ   +        ,<p  ,<   , 2,<   ,<p  ,< [ [,<   ,<w,< w [,<   ,<w,< w [,<   ,<w~,< ` [,   /   +        Zw-,   +  l3B   +  s-,   +  s,<   Z Od u2B   +  j,<w WXBw3B   +  i,<   Z cd u+  jZ   [  XBw3B   +  s,<   ,< Y [3B   +  sZp  3B   +  r,<w,< e [3B   +  sZw+    Z   +        ,<w,<   , 2,<   Zw2B x+  z,<p  ,< w [+  2B x+  ,<p  ,< [ [,<   ,< x y+  2B z+  ,<p  ,< [ [+  Z   /   +        , ,~   -.    zZ   ,<   ,<   , 2XB 3B   +  ,< i,<    |,<   ,< i,<    |,   ,<   @ }   +  ,< ~,< ~Z   f |XB   Z 2B  +  Z ,~   [ ,<   Z ,<   Z f Z ,<   Z   ,<  , Z ,<   Z ,<   ,<     ,~   ,~   -.    ,<`  Z ,<   ,<   , 3,~   ,<w~,<w~,<w~,<w~, ,<p  ,< `,<w,< ` [,   ."   ,   f Z,<p  ,< [ [,<   ,< i h,<p  ,< l [,<   ^"  ,> H,>   ,<w,< ` [,   (|ABx  ,^   /   ,   d g,<p  ,< l [,<   ^"  ,> H,>   ,<w,< ` [,   ABx  ,^   /   ,   d g,<p  ,< ` [,   ,> H,>   ,<p  ,< j [,   ,> H,>   Z   ,   Bx  ,^   /       ,^   /   3b  7   7   +    ,<p  ,<   ,<   , S+      (  ,<w~,<wZp  2B   +  OZw+  Q,<wZ e,<  f b/  ,<   ,<   ,<   ,<   ,<w},< ,<w|,<w,<   ,<   Zw-,   +  X+  eZ  XBp  Zp  Zw~1B  +  ^*  -,   +  _*  ,   2B   7       3B   +  cZp  2B   +  bZ   XBw+  e[wXBw+  VZw/  ,<   , 2XBw},<w~,<   Z cZw|1B  +  m*  -,   +  n*  ,   2B   7       ,<   , jXBw,   5" }Z cZw}1B  +  v*  -,   +  v*  ,   2B   7       3B   +  | w"   ,   ,<   ,<w~,<w{,<w{, "Z   +  Z cZw}1B  +  *  -,   +  *  ,   2B   7       3B   +  Z   XBp  ,<w},< [ [,<   Z d nXBwZ Zw}1B  +  *  -,   +  *  ,   2B   7       3B   +  ,<w,<w~,<w{,<w{, +  Z Zw}1B  +  *  -,   +  *  ,   2B   7       3B   +  ,<w,<w|,  Zp  3B   +  Zw+  Zw3B   +  Z   /  ,~   ,<wZ   d ,<   ,<w,<w,<   ,<   ,< [Zw~-,   +  '+  /Z  XBw p  ,> H,>    w$Bx  ,^   /   ,   ,<   ,<w} oXBp  [w~XBw~+  %Zp  /  ,   ."   (B  ,   +        ,<w,<   , 2XBw,<   ,<w 2B   +  9^"   +  9,   ,> H,>   Zw3B   +  =^"  +  =^"       ,^   /   3b  7   Z   ,<   ,<   ,<   ,<   ,<w~,< j [,   $"  ,   ,<   ,<   ,< ` p  ,> H,>    w    ,^   /   3b  +  LZw+  },<w|,< [ [,<   ,<w h,<w|,< l [b m,<   Z"  *,\  3B  +  T+  z,<w|,< l [b m,   (B  ,> H,>   ,<w|,< l [b m,   (B  .Bx  ,<w|,< l [b m,   .Bx  ,^   /   ,   XBw~,<w|,< [ [,<   ,<w~ h,<w|,< [ [,<   Z d nXBw~Zw|3B   +  s,<w~, ?XBw},<w{Zw},<   [w|,<   Zw{3B   +  q,<w{,< [ [,<   Z fd n,<    "  ,   +  z,<w{,<w}Zw|3B   +  y,<w{,< [ [,<   Z pd n,<    "  ,    p  ."  ,   XBp  +  G/  Z   /  +      (  Zw2B   +  Zw2B   +  ,<w~,<  3B   +  ,<w~,<w~,<w~,<w~,<   ,  m+    ,<   ,<   Zw}3B +  3B +  3B k+  3B   +  2B c+  Z +  3B +  3B 	+  3B d+  3B   +  3B c+  3B +  2B +  Z d+  Z   XBw},<w} W,<   Z hd u[  XBp  3B   +  $,<w},<w,< [ [,<   ,< x y,\  ,   3B   +  $Zp  +  D,<w} 	,<w},<w},< k,< e,< 

 fXBw}b m,   (B  ,> H,>   ,<w} m,   .Bx  ,^   /   ,   XBw~,<w} m,   (B  ,> H,>   ,<w} m,   .Bx  ,^   /   ,   XBwZw-,   +  8+  9,< e iXBp  ,<   ,< j,<w~ Z,<p  ,< `,<w} Z,<p  ,< [,<w| Z,<p  ,< eZw|2B d7   Z   f Z,<p  , ++  #/  +         ,<w~,<wZp  2B   +  IZw+  K,<wZ O,<  f b/  ,<   ,<w~,<w~Zw}3B   +  PZ +  PZ ,<   ,<   , KZw+        Zw2B   +  UZ M,<   ,<   , _2B   +  Y,<w,<   , 2XBw,<   Zw2B   +  ^,<w~,<p  ,< z, u/   b ,<   ,<w~,< x, u,<   ,<   ,<w,< ,<    ,<w XBwZ   3B   +  o,< ,<    ,< [,<    ,<w~,< [ [,<   ,<    ,< [,<    Z XBp  ,<w},<w~,<w,<   ,  8,<w},<   ,  ,<w,<w,<   ,<   ,<w{, Z e3B   +  },< [,<    ,<w~,< [ [,<   ,<    ,<    Zw}/  +    ,<p  ,< [ [,<   ,<w~ h,<p  ,< l [,<   ,<  g,<p  ,< l [,<   ^"  ,> H,>   ,<w,< [ [b ,   (xABx  ,^   /   ,   d g,<p  ,< l [,<   ^"  ,> H,>   ,<w,< [ [b ,   (|ABx  ,^   /   ,   d g,<p  ,< l [,<   ^"  ,> H,>   ,<w,< [ [b ,   ABx  ,^   /   ,   d g,<p  ,< [ [,<   ,< ~ h,<p  ,< [ [,<   ,<w~,<w ,< [,<w ,<w,<w ,<p   /   +    ,<p  ,< [ [,<   ,< Z Rf ,<p  ,< Y,<    Z,<p  ,< w,<  Z,<p  ,< l,<w,< [ [,<   ,<w~,< [ [,<   ,< x yd f Z,<p  ,< [ [Zp  ,   Z ,   XB <Zp  XB U+    Z   ,<   ,<w ,<   ,<w,< [ w/"   ,   f ,<   ,<w w."   ,   d ,   +       `
*) D0&&DD*$@ ( !"PB$  Ye:|jC-VlL PR 0	@(B%m\69	 0CI2 H%f3))0Z- Mv}a%h@!)X[2`,L&   @`H	"$d@ YJH9R	D
Q A +dpp222 K w_x
O$ I <UU"H$&*,l	k6I`,NI`[1RjuMv                            (HASHFILEBLOCK#0 . 1)
(VARIABLE-VALUE-CELL SYSHASHFILELST . 1658)
(VARIABLE-VALUE-CELL SYSHASHFILE . 1660)
(VARIABLE-VALUE-CELL HASHTEXTCHAR . 1428)
(VARIABLE-VALUE-CELL HASHFILEDEFAULTSIZE . 221)
(VARIABLE-VALUE-CELL HFGROWTHFACTOR . 227)
(VARIABLE-VALUE-CELL HASHFILERDTBL . 1264)
(VARIABLE-VALUE-CELL PROBELST . 590)
(VARIABLE-VALUE-CELL HASHLOADFACTOR . 901)
(VARIABLE-VALUE-CELL HASHSCRATCHLST . 1090)
(VARIABLE-VALUE-CELL REHASHGAG . 1517)
(VARIABLE-VALUE-CELL HASHBITTABLE . 1662)
CLEARHASHFILES
CLOSEHASHFILE
COLLECTKEYS
COPYHASHFILE
COPYHASHITEM
CREATEHASHFILE
GETHASHFILE
HASHBEFORECLOSE
HASHFILEDATA
HASHFILEP
HASHFILEPROP
HASHFILESPLST
LOOKUPHASHFILE
MAPHASHFILE
OPENHASHFILE
PUTHASHFILE
REHASHFILE
(NIL)
(LINKED-FN-CALL . OPENP)
(NIL)
(LINKED-FN-CALL . CLOSEF)
7
(NIL)
(LINKED-FN-CALL . SETA)
1
(NIL)
(LINKED-FN-CALL . ELT)
*COLLECTKEYS*
((UNBOXED-NUM . 3) VARIABLE-VALUE-CELL MKSTRING? . 0)
(NIL VARIABLE-VALUE-CELL KEYLST . 109)
HASHFILEBLOCKA0004
HASHFILEBLOCKA0005
*COPYHASHFILE*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL HFILE . 135)
((UNBOXED-NUM . 3) VARIABLE-VALUE-CELL FN . 0)
4
(VARIABLE-VALUE-CELL NEWHASHFILE . 145)
HASHFILEBLOCKA0006
(NIL)
(LINKED-FN-CALL . PACK*)
RETRIEVE
INSERT
BOTH
NEW
8
(((TYPE BINARY)) . 0)
(NIL)
(LINKED-FN-CALL . OPENFILE)
(NIL)
(LINKED-FN-CALL . BOUT)
(NIL)
(LINKED-FN-CALL . SETFILEPTR)
0
(NIL)
(LINKED-FN-CALL . ARRAY)
3
OLD
(((TYPE BINARY)) . 0)
2
68
(NIL)
(LINKED-FN-CALL . BIN)
(NIL)
(LINKED-FN-CALL . READ)
(NIL)
(LINKED-FN-CALL . IMOD)
(NIL)
(LINKED-FN-CALL . NCHARS)
(NIL)
(LINKED-FN-CALL . NTHCHAR)
(NIL)
(LINKED-FN-CALL . CHCON1)
(NIL)
(LINKED-FN-CALL . NTH)
"NOT A HASHFILE"
HELP
(NIL)
(LINKED-FN-CALL . ASSOC)
(NIL)
(LINKED-FN-CALL . DREMOVE)
5
6
VALUETYPE
ACCESS
(NIL)
(LINKED-FN-CALL . GETFILEINFO)
NAME
*HASHFILESPLST*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL HASHFILE . 815)
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL XWORD . 817)
(NIL)
(LINKED-FN-CALL . STKNTH)
(VARIABLE-VALUE-CELL COMVAR## . 822)
(NIL VARIABLE-VALUE-CELL ..MACROX. . 811)
-1
*PROG*LAM
(NIL)
(LINKED-FN-CALL . RESUME)
(NIL)
(LINKED-FN-CALL . RETTO)
*HASHFILESPLST1*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL XWORD . 0)
HASHFILEBLOCKA0007
((REPLACE DELETE INSERT) . 0)
REPLACE
DELETE
(NIL)
(LINKED-FN-CALL . DCHCON)
(NIL)
(LINKED-FN-CALL . NARGS)
((TEXT DOUBLE NUMBER STRING PRINT FULLPRINT) . 0)
(NIL)
(LINKED-FN-CALL . MEMB)
READ
INPUT
WRITE
OUTPUT
(NIL)
(LINKED-FN-CALL . CLOSEF?)
(((TYPE BINARY)) . 0)
((REPLACE INSERT) . 0)
(NIL)
(LINKED-FN-CALL . UNPACKFILENAME)
VERSION
(NIL)
(LINKED-FN-CALL . LISTPUT)
(NIL)
(LINKED-FN-CALL . PACKFILENAME)
"Rehashing"
(NIL)
(LINKED-FN-CALL . PRIN1)
(NIL)
(LINKED-FN-CALL . SPACES)
HASHFILEBLOCKA0008
(NIL)
(LINKED-FN-CALL . TERPRI)
85
(NIL)
(LINKED-FN-CALL . GETEOFPTR)
(NIL)
(LINKED-FN-CALL . PRIN2)
BEFORE
(NIL)
(LINKED-FN-CALL . WHENCLOSE)
EXPR
(NIL)
(LINKED-FN-CALL . GETSTREAM)
(NIL)
(LINKED-FN-CALL . STRPOSL)
(NIL)
(LINKED-FN-CALL . SUBATOM)
(CONS URET5 GUNBOX FMEMB SKLST SKNLST CONSS1 SKNAR ALIST4 SKLA SKNLA URET1 URET6 EQUAL ASZ URET3 IUNBOX SKAR MKN FLTFX FUNBOX URET4 
EVCC KT BINDB BHC URET2 KNIL BLKENT ENTER1) gX<   F Q   >   Bx @ v =X^    A@  >Hl ;P   DhX   H 1`   ,   +`   ,(?   ;   ? +p3   ' "0   T(   S @x h   _x *8G (@8 0a    bH V@1 UP* Kp[ JxE G 1 7(2 5 / %@ !   (< 8)   7 'H   G hH bp V`/ OHa H`3 EHz 7H4 51 %X' $ !@_ x@ `6 (  p } X   P   8@B 7p s  p   + Z8K 9 m h   O0s 8   f} _Hy ]hm ] h X0 H  C @P >pn <0_ 9 1P HB X 3    0` : X   e0 bh _p_ YHE VX. Op~ LK Gx1 E@  <hR 8pE 7@4 08^ &! #P xY HS (F X5  	 @ t   f  U 	(    I F8 .Pt p +  ! 8    x ^`u ^8r \pd \(\ [X ZpU Z O YB T0 S Q 	 Q  P( Ohv Mhi HpC H(B H< G 5 DP$ Cp C C  Ap @@ @(} ? w >ho =`b <` ;pW :hT :8S 9`J 9 H 4	 1  .ht .(p -hl -(g ,Pa *PS * N )8J (HC ( A '8 &H3 "@ 8o pj c 8Z PA   w h l  g ( ` X X 
h Q 	x L 	 F  ? h < h 1  ( x $   P  x     h            

CLEARHASHFILES BINARY
            -.           ,<    ,~       (CLOSE . 1)
(RELEASE . 1)
CLEARHASHFILES
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER2)      

CLOSEHASHFILE BINARY
                -.           ,<    ,~       (HASHFILE . 1)
(REOPEN . 1)
CLOSEHASHFILE
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER2)     

COLLECTKEYS BINARY
             -.           ,<    ,~       (HASHFILE . 1)
(DOUBLE . 1)
(MKSTRING? . 1)
COLLECTKEYS
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER3)     

COPYHASHFILE BINARY
            -.            ,<    ,~       (HFILE . 1)
(NEWNAME . 1)
(FN . 1)
(VTYPE . 1)
COPYHASHFILE
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER4)     

COPYHASHITEM BINARY
            -.            ,<    ,~       (KEY . 1)
(HASHFILE . 1)
(NEWHASHFILE . 1)
(USERFN . 1)
COPYHASHITEM
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER4)      

CREATEHASHFILE BINARY
               -.     (      ,<    ,~       (FILE . 1)
(VALUETYPE . 1)
(ITEMLENGTH . 1)
(#ENTRIES . 1)
(SMASH . 1)
CREATEHASHFILE
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER5)      

GETHASHFILE BINARY
               -.           ,<    ,~       (KEY . 1)
(HASHFILE . 1)
(KEY2 . 1)
GETHASHFILE
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER3)      

HASHBEFORECLOSE BINARY
                -.           ,<    ,~       (FILE . 1)
HASHBEFORECLOSE
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER1)      

HASHFILEDATA BINARY
            -.           ,<    ,~       (HASHFILE . 1)
HASHFILEDATA
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER1)     

HASHFILEP BINARY
               -.           ,<    ,~       (HASHFILE . 1)
(WRITE . 1)
HASHFILEP
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER2)     

HASHFILEPROP BINARY
            -.           ,<    ,~       (HASHFILE . 1)
(PROP . 1)
HASHFILEPROP
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER2)      

HASHFILESPLST BINARY
             -.           ,<    ,~       (HASHFILE . 1)
(XWORD . 1)
HASHFILESPLST
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER2)      

LOOKUPHASHFILE BINARY
               -.     (      ,<    ,~       (KEY . 1)
(VALUE . 1)
(HASHFILE . 1)
(CALLTYPE . 1)
(KEY2 . 1)
LOOKUPHASHFILE
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER5)      

MAPHASHFILE BINARY
             -.           ,<    ,~       (HASHFILE . 1)
(MAPFN . 1)
(DOUBLE . 1)
MAPHASHFILE
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER3)    

OPENHASHFILE BINARY
            -.     (      ,<    ,~       (FILE . 1)
(ACCESS . 1)
(ITEMLENGTH . 1)
(#ENTRIES . 1)
(SMASH . 1)
OPENHASHFILE
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER5)      

PUTHASHFILE BINARY
               -.            ,<    ,~       (KEY . 1)
(VALUE . 1)
(HASHFILE . 1)
(KEY2 . 1)
PUTHASHFILE
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER4)     

REHASHFILE BINARY
              -.           ,<    ,~       (HASHFILE . 1)
(NEWNAME . 1)
(VALUETYPE . 1)
REHASHFILE
(NIL)
(LINKED-FN-CALL . HASHFILEBLOCK)
(ENTER3)     

TESTHASH BINARY
                -.           ,<   "  ,<   @     ,~   ,<  ,<   $  ,<   "  ,<  "  ,<  ,<   $  ,<   "  ,<  "  ,<  ,<   $  ,<   "  ,<  "  ,<  ,<   $  ,<   "  ,<  "  Z   B  Z   ,~   uuuP    (VARIABLE-VALUE-CELL HASHFILE . 0)
GCGAG
(VARIABLE-VALUE-CELL OLDGC . 37)
"Inserting ..."
PRIN1
TERPRI
((for I to 1000 DO (PUTHASHFILE I (GENSYM) HASHFILE)) . 0)
TIME
"Replacing ..."
((for I to 1000 DO (PUTHASHFILE I (GENSYM) HASHFILE)) . 0)
"Retrieving ..."
((for I to 1000 DO (GETHASHFILE I HASHFILE)) . 0)
"Deleting ..."
((for I to 1000 DO (PUTHASHFILE I NIL HASHFILE)) . 0)
(KT KNIL ENTERF)     `  ( 	  p       (      
(PRETTYCOMPRINT HASHCOMS)
(RPAQQ HASHCOMS ((FNS * HASHFNS) (FNS DELETEHASHKEY FIND1STPRIME GETHASHKEY GETPROBE GTHASHFILE HASHFILESPLST1 INSERTHASHKEY 
MAKEHASHKEY REPLACEHASHKEY SETHASHSTATUS SPLITKEY) (FNS TESTHASH) (VARS HASHFILEDEFAULTSIZE HASHLOADFACTOR PROBELST (HASHSCRATCHLST 
(CONSTANT (for I to 30 collect NIL))) HFGROWTHFACTOR REHASHGAG (HASHTEXTCHAR (CHARACTER 1)) (SYSHASHFILE) (HASHFILERDTBL (
COPYREADTABLE (QUOTE ORIG)))) (VARS (HASHBITTABLE (MAKEBITTABLE (LIST HASHTEXTCHAR)))) (ADDVARS (SYSHASHFILELST) (AFTERSYSOUTFORMS (
CLEARHASHFILES))) (DECLARE: EVAL@COMPILE DONTCOPY (RECORDS HashFile) (MACROS ANYEQ CREATEKEY GETHASHFILE HASHFILENAME MODTIMES 
PRINTPTR PRINTSTBYTE READPTR READSTBYTE REHASHKEY) (GLOBALVARS * HASHGLOBALS) (SPECVARS REHASHGAG HASHFILERDTBL) (BLOCKS (
HASHFILEBLOCK (SPECVARS REHASHGAG HASHFILERDTBL) (ENTRIES CLEARHASHFILES CLOSEHASHFILE COLLECTKEYS COPYHASHFILE COPYHASHITEM 
CREATEHASHFILE GETHASHFILE HASHBEFORECLOSE HASHFILEDATA HASHFILEP HASHFILEPROP HASHFILESPLST LOOKUPHASHFILE MAPHASHFILE OPENHASHFILE
 PUTHASHFILE REHASHFILE) CLEARHASHFILES CLOSEHASHFILE COLLECTKEYS COPYHASHFILE COPYHASHITEM CREATEHASHFILE DELETEHASHKEY 
FIND1STPRIME GETHASHFILE GETHASHKEY GETPROBE GTHASHFILE HASHBEFORECLOSE HASHFILEDATA HASHFILEP HASHFILEPROP HASHFILESPLST 
HASHFILESPLST1 INSERTHASHKEY LOOKUPHASHFILE MAKEHASHKEY MAPHASHFILE OPENHASHFILE PUTHASHFILE REHASHFILE REPLACEHASHKEY SETHASHSTATUS
 SPLITKEY))) (P (SELECTQ (SYSTEMTYPE) ((TENEX TOPS20) (FILESLOAD (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) DFOR10)) NIL))))
(RPAQQ HASHFNS (CLEARHASHFILES CLOSEHASHFILE COLLECTKEYS COPYHASHFILE COPYHASHITEM CREATEHASHFILE GETHASHFILE HASHBEFORECLOSE 
HASHFILEDATA HASHFILEP HASHFILEPROP HASHFILESPLST LOOKUPHASHFILE MAPHASHFILE OPENHASHFILE PUTHASHFILE REHASHFILE))
(RPAQQ HASHFILEDEFAULTSIZE 512)
(RPAQQ HASHLOADFACTOR .875)
(RPAQQ PROBELST (1 3 5 7 11 11 13 17 17 19 23 23 29 29 29 31 37 37 37 41 41 43 47 47 53 53 53 59 59 59 61 67))
(RPAQ HASHSCRATCHLST (CONSTANT (for I to 30 collect NIL)))
(RPAQQ HFGROWTHFACTOR 3)
(RPAQQ REHASHGAG NIL)
(RPAQ HASHTEXTCHAR (CHARACTER 1))
(RPAQQ SYSHASHFILE NIL)
(RPAQ HASHFILERDTBL (COPYREADTABLE (QUOTE ORIG)))
(RPAQ HASHBITTABLE (MAKEBITTABLE (LIST HASHTEXTCHAR)))
(ADDTOVAR SYSHASHFILELST)
(ADDTOVAR AFTERSYSOUTFORMS (CLEARHASHFILES))
(SELECTQ (SYSTEMTYPE) ((TENEX TOPS20) (FILESLOAD (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) DFOR10)) NIL)
NIL
