(FILECREATED "12-Sep-84 23:34:45" ("compiled on " <NEWLISP>MACHINEINDEPENDENT..167) (2 . 2) bcompl'd in "INTERLISP-10  24-Aug-84 ..."
dated "24-Aug-84 01:43:38")
(FILECREATED " 6-Sep-84 13:38:57" {ERIS}<LISPCORE>SOURCES>MACHINEINDEPENDENT.;10 78285 changes to: (FNS UPDATEFILEMAP) previous 
date: " 2-Sep-84 16:18:10" {ERIS}<LISPCORE>SOURCES>MACHINEINDEPENDENT.;9)

EQUALN BINARY
        -    ©    «-.           ©-.       +    +ZwZwÿ3B  7   7   +    Zw-,   +   -,   +   Zwÿ-,   +   ZwZwÿ,   +    Z   +    -,   +   ZwZwÿ,   +    -,   +   Z   +    ZwZwÿ,   +    Zwÿ-,   +   Z   +    Zp  3B   +    p  0"  +   Z  ++    Zw,<  Zw,<  Zw3B   +     w/"  ,   XBw+   !Z   ,<  ,  2B  ++   $Z  ++    2B   +   ¨[w,<  [wXBw,\  XBw+   Z   +     R`O     (X . 1)
(Y . 1)
(DEPTH . 1)
?
(MKN SKNSTK STREQUAL SKSTP EQP SKNM SKNLST URET3 KNIL KT BLKENT ENTER3)            `   @     
    X     * H  p  (  X   h    ¡ `  h  P     %  X    (      

SUBPAIR BINARY
    ®    *    --.            *-.       ,    ,Zwÿ-,   +   [wÿ3B   +   ,<wþ,<wþ[wþ,<  ,<wþ,  +   
Z   ,<  ,<w~,<w~Zw~,<  ,<w~,  ,<  Zp  Zwþ2B  +   Zwÿ[wþ2B  +   Zw3B   +   Zp  Zwÿ,   +   Zwþ/  +    Zwþ2B   +   Zwÿ+   ©-,   +   !ZwÿZwþ2B  +    Zp  3B   +   ,<w  ,+   ©Zw+   ©+   ©ZwÿZwþ2B  +   'Zp  3B   +   &Zwb  ,+   ©Zw+   ©[wþXBwþ[wXBw+   +    $QbZ   (OLD . 1)
(NEW . 1)
(EXPR . 1)
(FLG . 1)
(NIL)
(LINKED-FN-CALL . COPY)
(SKNLST URET4 BHC CONS KNIL SKLST BLKENT ENTER4) (   (             ¤ `  8   `    H    (      

PROMPTCHAR BINARY
      Ã    µ    Á-.          µ@  ¸  ,~   ZwZ8 3B   +   Z   3B   +   b  :XB  3B   +   Z   ,~      ;3B   +   +   Z   3B   +    Z   3B   +    [  Z  ,   ."  ,   XB` ,   ,>  5,>  [  [  [  Z  2B   +   Z"  2XB` ,      ,^  /  3b  +    ` ,>  5,>   `    ,^  /  /  ,   +   Z` XB   Z   3B   +   ®,<  Zp  -,   +   $+   .Zp  ,<  ,<  <,<   ,<   @  ¼ ` +   ,Z   Z  >XB Zwý,<8    ¾Z   ,~   /  [p  XBp  +   "/  Z  3B   +   ±,<  ,<     ¿Z   3B   +   ,<  ,<     À+     d@@@(Q&     (VARIABLE-VALUE-CELL ID . 99)
(FLG . 1)
(VARIABLE-VALUE-CELL HISTORY . 38)
(VARIABLE-VALUE-CELL READBUF . 14)
(VARIABLE-VALUE-CELL PROMPT#FLG . 26)
(VARIABLE-VALUE-CELL PROMPTCHARFORMS . 64)
NIL
NIL
(NIL VARIABLE-VALUE-CELL PROMPTSTR . 93)
(NIL)
(LINKED-FN-CALL . LISPXREADBUF)
(NIL)
(LINKED-FN-CALL . LISPXREADP)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(NIL)
(LINKED-FN-CALL . EVAL)
(NIL)
(LINKED-FN-CALL . PRIN2)
(NIL)
(LINKED-FN-CALL . PRIN1)
(CF KT SKNLST BHC ASZ MKN IUNBOX KNIL ENTERF)  )    ´  , h   8   p - `                   0 0 p ¡ `  P     h        

NAMEFIELD BINARY
            -.           Z` 2B  +   ,<` ,<    ,~   Z` 2B  +   ,<` ,<    ,~   ,<  Z` 3B   +   ,<` ,<    +   Z   ,<  ,<  ,<` ,<    ,<  ,<  Z` 3B   +   ,<` ,<    +   Z   l  ,~   fi9´:    (FILE . 1)
(SUFFIXFLG . 1)
(DIRFLG . 1)
ONLY
DIRECTORY
(NIL)
(LINKED-FN-CALL . FILENAMEFIELD)
EXTENSION
NAME
(NIL)
(LINKED-FN-CALL . PACKFILENAME)
(KNIL ENTER3)       (      

CLOSEF? BINARY
    
        -.           Z` 3B   +   b  3B   +   ,<`   ,~   Z   ,~   (   (FL . 1)
(NIL)
(LINKED-FN-CALL . OPENP)
(NIL)
(LINKED-FN-CALL . CLOSEF)
(KNIL ENTER1)  p   0      

CLBUFS BINARY
     ¢        ¡-.          ,<   ,<   Z` 3B   +   +   Z` 3B   +   	,<     3B   +   	      ,<   ,<     Z` XB   Z   XB   ,<     XBwÿ,<      XBp         ZwÿZ  !,   3B   +   Z   XBwÿZp  2B   +   Zwÿ3B   +    ZwÿZp  ,   +    e9-!    (NOCLEARFLG . 1)
(NOTYPEFLG . 1)
(BUF . 1)
(VARIABLE-VALUE-CELL READBUF . 22)
(VARIABLE-VALUE-CELL CTRLUFLG . 24)
(NIL)
(LINKED-FN-CALL . READP)
PRINTBELLS
(NIL)
(LINKED-FN-CALL . DOBE)
(NIL)
(LINKED-FN-CALL . CLEARBUF)
(NIL)
(LINKED-FN-CALL . LINBUF)
(NIL)
(LINKED-FN-CALL . SYSBUF)
"
"
(CONS URET2 STREQUAL KT KNIL ENTER3)       x   (   p  ( 
  p   p  @  H   `   0        

BKBUFS BINARY
       "        !-.           ,<   ,<   Z` -,   +   Z   +    Z` XBwÿ[` XBp  ,<     3B   +         ,<   ,<     ,<p    ,<     b     +   Zp  3B   +   b  Zwÿ3B   +   Z` 3B   +   ,<  ,<     ,<wÿ,<     ,<wÿ   +   @.+fI   (BUFS . 1)
(ID . 1)
(NIL)
(LINKED-FN-CALL . READP)
PRINTBELLS
(NIL)
(LINKED-FN-CALL . DOBE)
(NIL)
(LINKED-FN-CALL . CLEARBUF)
(NIL)
(LINKED-FN-CALL . BKSYSBUF)
(NIL)
(LINKED-FN-CALL . SYSBUF)
(NIL)
(LINKED-FN-CALL . PRIN1)
(NIL)
(LINKED-FN-CALL . BKLINBUF)
(KT URET2 SKNLST KNIL ENTER2)   p  X  0              (     0        

LVLPRINTBLOCK BINARY
           -.          -.     (h
              (  ,  ,~   -.   
 ,<` Z   ,<  ,<` ,<` ,<` ,  Z  b Z` ,~     (  ,  ,~   -.   
 @   ,~   Zw,<8 ,<8 ,<8 ,<8 ,  ZwZ8 ,~     (  ,  ,~   -.   
 @   ,~   Zw,<8 ,<8 ,<8 ,<8 ,  ZwZ8 ,~   Zwþ-,   +   7Zp  3B   +   °Zwþ,<  ,<wÿ [  ,\  2B  +   °,<wþ,<wÿ 2B   +   °,< Z  d Z   3B   +   -,<wþZ  §,<  ,<    +   ®,<wþZ  ªd ,< Z  ­d +    Z  ¨3B   +   5,<wþZ  /,<  ,<    +    ,<wþZ  ²d +    Zp  3B   +   »,<wþd 3B   +   »Z +   <Z ,<  Z  µd ,<wþ,<wþ,<wþ,  Á,< Z  ¼d +    ZwZ   2B  +   E[w[  XBw,<p  +   Ó[wþXBwþ2B   +   IZ   +    -,   +   R,< Z  @d Z  °3B   +   P,<wþZ  Ê,<  ,<    +   H,<wþZ  Íd +   H,< Z  Ðd Zwÿ0B   +   W,< Z  Òd +   HZwþ-,   +   àZ  Ë3B   +   ^Zwþ,<  Z  Õ,<  ,<   ,<    +  Zwþ,<  Z  [d +  Zw1B   +   åZp  3B   +   ç p  /"  0B   +   ç,< Z  _d +  Z  f2B   +   pZwþZ  ,<  Z   d 3B   +   pZ   3B   +   p,<  Z  çd +  ,< Z  îd Zwþ,<  Zwþ3B   +   { wþ,> ,>  Zwþ,   5"  x^"  +   ø^"ÿ.Bx  ,^  /  ,   +   ûZ   ,<  Zw3B   +   ÿ w/"  ,   +   Z   ,<  ,  Á,< Z  ðd Zwÿ3B   +   F wÿ/"  ,   XBwÿ+   F  i"0LDK$QE<FBg&äF$6!Ih(P!$       (LVLPRINTBLOCK#0 . 1)
(VARIABLE-VALUE-CELL FILE . 259)
(VARIABLE-VALUE-CELL PRIN2FLG . 177)
(VARIABLE-VALUE-CELL CLISPTRANFLG . 132)
(VARIABLE-VALUE-CELL COMMENTFLG . 213)
(VARIABLE-VALUE-CELL **COMMENT**FLG . 217)
LVLPRINT
LVLPRIN1
LVLPRIN2
*LVLPRINT*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL FILE . 0)
(NIL)
(LINKED-FN-CALL . TERPRI)
*LVLPRIN1*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL FILE . 0)
(NIL VARIABLE-VALUE-CELL PRIN2FLG . 0)
*LVLPRIN2*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL FILE . 0)
(T VARIABLE-VALUE-CELL PRIN2FLG . 0)
(NIL)
(LINKED-FN-CALL . LAST)
(NIL)
(LINKED-FN-CALL . MEMB)
"...  . "
(NIL)
(LINKED-FN-CALL . PRIN1)
(NIL)
(LINKED-FN-CALL . PRIN2)
%)
(NIL)
(LINKED-FN-CALL . TAILP)
"... "
%(
" . "
1
(NIL)
(LINKED-FN-CALL . SPACES)
--
&
(NIL)
(LINKED-FN-CALL . SUPERPRINTEQ)
(MKN BHC GUNBOX ASZ URET4 KT KNIL SKNLST BINDB BLKENT ENTER1)   x {    ú    w    b 
P   	 B x µ     Ý P Ï H ¬     ý @ t ` ì 8 Z 	P I 	  º  2   '     J p   x   p    (      

LVLPRINT BINARY
                -.     (      ,<    ,~       (X . 1)
(VARIABLE-VALUE-CELL FILE . 0)
(CARLVL . 1)
(CDRLVL . 1)
(TAIL . 1)
LVLPRINT
(NIL)
(LINKED-FN-CALL . LVLPRINTBLOCK)
(ENTERF)    

LVLPRIN1 BINARY
                -.     (      ,<    ,~       (X . 1)
(VARIABLE-VALUE-CELL FILE . 0)
(CARLVL . 1)
(CDRLVL . 1)
(TAIL . 1)
LVLPRIN1
(NIL)
(LINKED-FN-CALL . LVLPRINTBLOCK)
(ENTERF)    

LVLPRIN2 BINARY
                -.     (      ,<    ,~       (X . 1)
(VARIABLE-VALUE-CELL FILE . 0)
(CARLVL . 1)
(CDRLVL . 1)
(TAIL . 1)
LVLPRIN2
(NIL)
(LINKED-FN-CALL . LVLPRINTBLOCK)
(ENTERF)    

SUBBLOCK BINARY
        Å    =    Ã-.           =-.      ½p ¾            ,  ,~   -.     ¿Z` -,   +   ,<  ,  ,~   ,<  ,  .Z` ,~   Zp  Z   7  [  Z  Z  1H  +   2D   +   ,<  Zp  3B   +   Z   3B   +   [p  b  A+    [p  +    Zwÿ+        ,  ,~   -.     B,<` ,  ,~   Zp  -,   +   ¬[p  3B   +    [p  ,<  ,  +   !Z   ,<  Zwÿ,<  ,  ,<  Zp  Zw2B  +   )Zwÿ[w2B  +   )Z  3B   +   +Zp  Zwÿ,   +   «Zw/  +    ,<  ,  +    Zp  -,   +   ±Zp  ,<  ,  .+   ´,<p  Zwÿ,<  ,  ,\  XB  [p  -,   +   »[p  3B   +    ,<p  [wÿ,<  ,     ,\  QD  +    [p  XBp  +   .R) J(IB&   (SUBBLOCK#0 . 1)
(VARIABLE-VALUE-CELL ALST . 24)
(VARIABLE-VALUE-CELL FLG . 79)
SUBLIS
DSUBLIS
*DSUBLIS*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL ALST . 0)
((UNBOXED-NUM . 3) VARIABLE-VALUE-CELL FLG . 0)
(NIL)
(LINKED-FN-CALL . COPY)
*SUBLIS*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL ALST . 0)
((UNBOXED-NUM . 3) VARIABLE-VALUE-CELL FLG . 0)
(URET1 BHC CONS SKLST URET2 KNIL SKNLST BINDB BLKENT ENTER1)   <   ® P   H   0   x      p     ·  ¡ h  (     6                  

SUBLIS BINARY
               -.           ,<    ,~       (VARIABLE-VALUE-CELL ALST . 0)
(EXPR . 1)
(VARIABLE-VALUE-CELL FLG . 0)
SUBLIS
(NIL)
(LINKED-FN-CALL . SUBBLOCK)
(ENTERF)     

DSUBLIS BINARY
              -.           ,<    ,~       (VARIABLE-VALUE-CELL ALST . 0)
(EXPR . 1)
(VARIABLE-VALUE-CELL FLG . 0)
DSUBLIS
(NIL)
(LINKED-FN-CALL . SUBBLOCK)
(ENTERF)      

COMPARELISTSBLOCK BINARY
   ê   Å   à-.          Å-.     0FpI        °    ,<   " J,<  @ Ê  +   ¯,< JZ   ,<  ,   ,   Z   ,   XB  
XB` ,< Ì,< M,<   @ Í ` +   ¦Z   Z OXB @ Ï  +   ¤Zwÿ,<?ÿ,<8  ,<   ,  °2B   +   Zwÿ,<?ÿ,<8  ,  Þ+   #Z   3B   +   ",<  Zp  -,   +   +   !Zp  ,<  ,<p  " P,< Ð" Q/  [p  XBp  +   /  +   #,< Ñ" R  ÒZ   ,~   ZwXB8 Z   ,~   2B   +   ¨Z SXB   [` XB  ,< JZ` Z  [  D ÓZ  (3B   +   ®  T,~   Z` ,~   +        ,  ±,~   -.    ÔZ   0Bÿ+   6,<` ,<` , îXB  ²,<` ,<` ,  8,~   ZwÿZp  3B  +   [-,   +   VZp  -,   +   SZwÿZ   2B  +   ÀZp  Z  =3B  +   [Zwÿ-,   +   ÇZwÿZp  ,   2B   +   Ò,<wÿ,<wÿ, 3B   +   Ý+   ÒZp  -,   +   L,<wÿ,<  , 3B   +   Ý+   ÒZwÿ,<  Zwÿ,<  ,  82B   +   P+   Ý[wÿXBwÿ[p  XBp  +   À+   [,<wÿ,<  , 3B   +   Ý+   [ZwÿZp  ,   2B   +   [,<wÿ,<wÿ, 3B   +   ÝZ  µ2B   +    Z   +    Z   +    ,< Ð,< Ð$ Õ,<  @ V  +  ,< ÕZ  ,<  ,   ,   Z  ),   XB  äXB` ,< X,< M,<   @ Í ` +  Z   Z OXB ,<   ,<   ZwýZ?ÿZ8  ,   3B   +   pZ   +   ZwýZ?ÿ-,   +   óZ8  -,   +   ö,<?ÿ" ØZwý,<8  " Ø+   ÿ,< Y" RZwý,<?ÿ,<8  , ,< Ù" R  Ò,< Y" RZwý,<8  ,<?ÿ, ,< Ù" R  ÒZ   /  Zw~XB8 Z   ,~   2B   +  Z SXB  ,[` XB  å,< ÕZ` Z  [  D ÓZ 3B   +    T,~   Z` ,~   +    ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,< Z,<   Zw{XBwþZwûXBwZwý3B   +  ZwþXBw|ZwXBwü+  ZwþXBw|ZwXBwü,<w|,<  , îXBp  ,<  ,<wû,<wû,<  ,  °XBwÿ,\  2B  +  &Zw}2B   +  %Zw|-,   +  %Zwÿ0B   +  %,<w|" P+  T:wÿ+  U,<wÿ,<wü,<   , xZ"   XBwÿZw|-,   +  ·Zwü-,   +  ·Zw|Z  ?2B  +  ²Z   B RZwüZ ¬3B  +  ·[wþXBwþ+  ZwüZ ¯2B  +  ·Z .B ÚB Q[wXBw+  Zp  2B   +  LZwý2B   +  L[wþ-,   +  Â[wþZ  ,<  ,<w|,< [,  °3B   +  Â,<w|" P[wþXBwþ+  [w-,   +  L[wZ  ,<  ,<wû,< [,  °3B   +  LZw,<  ,<   $ ÚB Q[wXBw+  Zw|-,   +  OZwü-,   +  Ð,<w|" P+  T,< Y" R,<w|,<w|, ,< Ù" RZ   XBw}Zwý2B   +  X[wþ2B   +  Ú,<wÿ,<wü,<   , x+  m[wþ-,   +  Ü7   Z   XBwý[w3B   +  á[wþXBwþ[wXBw+  ,<wÿ,<wü,<   , xZwý3B   +  ç,< Û" R[wþB P+  m,< Ð" Q[wþZ  B P[wþ[  3B   +  m,< \" RZ   /  ,~   ,<wÿ,< Ü$ ],   ,> E,>  ,<p  ,< Ü$ ],   .Bx  ,^  /     ^"   /  &"  ,   +    Zw1B   +  
Zwÿ3B   +  ü,< Ð" Q+  ýZ   XBwÿZw0B  +  ,< Ý" R+  
  ^,   ."  ,> E,>    Þ,      ,^  /  3"  +    Ò,< _" R,<w" P,< _" RZp  3B   +  Zwÿ3B   +  ,< Ð" Q+    Z   +    Z   ,<  Zp  -,   +  Z   +  Zp  ,<  ,<wÿ/  ,<p  ,<w~,<w~ "  ,   /  3B   +  Zp  +  [p  XBp  +  /  2B   +    Z  [3B   +  D-,   +  &,<p  ,<w  /"  ,   D ]D ]XB  ,   1b   7   Z   +    Zwÿ-,   +  3Zp  -,   +  *Z   +  4,<  Zp  -,   +  -Z   +  1Zp  -,   +  ¯Z   +  1[p  XBp  +  ª/  3B   +    +  4Z   +    ZwÿZ  7  [  Z  Z  1H  +  92D   +  µ,<  Zp  3B   +  >Zwÿ[p  [  Z  ,   +  CZ ´,<  ,<wþ,< ß,<w~,   XBw,   D `XB >/  +    Z   +      J`ªF/D&IRK%BaK 0TDScøp"0 B¤D$Y!THhdKgA'¼ CrAw P R JR           (COMPARELISTSBLOCK#0 . 1)
(VARIABLE-VALUE-CELL RESETVARSLST . 266)
(VARIABLE-VALUE-CELL COMMENTFLG . 358)
(VARIABLE-VALUE-CELL LOOSEMATCH . 582)
(VARIABLE-VALUE-CELL **COMMENT**FLG . 361)
(VARIABLE-VALUE-CELL COMPARETRANSFORMS . 543)
(VARIABLE-VALUE-CELL DIFFERENCES . 645)
COMPARELISTS
COMPARELST
OUTPUT
(VARIABLE-VALUE-CELL OLDVALUE . 197)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 272)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(NIL VARIABLE-VALUE-CELL DIFFERENCES . 0)
PRIN2
1
SPACES
SAME
PRIN1
TERPRI
ERROR
APPLY
ERROR!
*COMPARELST*
((UNBOXED-NUM . 3) VARIABLE-VALUE-CELL LOOSEMATCH . 0)
PRINTLEVEL
(VARIABLE-VALUE-CELL OLDVALUE . 0)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 0)
((DUMMY) . 0)
PRINT
%(
%)
0
NCHARS
-1
" . "
" --"
30
COUNTDOWN
&
POSITION
LINELENGTH
-
->
NCONC
(LIST3 SKNM EVCC URET3 MKN IUNBOX SKLA EQUAL SKLST ASZ BINDB URET2 BHC SKNLST CF KNIL CONS CONSNL LIST2 KT BLKENT ENTER1) Á          !p   $(x   ¤  H @q   "   > h X @   %hÍ @< @ª   ¼ 0   pù £ @   (   (XÄ &H3 $h  p ^ P °   D &  #  `õ h       , %§ " \ p ó 	 B 8   (    E '09 &@² %x¥ #h # !x !8{ `l Pã pÝ  X hH  º   @   p ` P 8 p p ì  Þ H [  Õ 	x Ë p Ä X § H  X     f 8   (( e (   H 
   - % & X] PJ    l X ¦ H            

COMPARELISTS BINARY
              -.           ,<    ,~       (X . 1)
(Y . 1)
COMPARELISTS
(NIL)
(LINKED-FN-CALL . COMPARELISTSBLOCK)
(ENTER2)    

COMPARELST BINARY
              -.           ,<    ,~       (X . 1)
(Y . 1)
(VARIABLE-VALUE-CELL LOOSEMATCH . 0)
COMPARELST
(NIL)
(LINKED-FN-CALL . COMPARELISTSBLOCK)
(ENTERF)      

COUNTDOWN BINARY
            -.           -.           Zwÿ-,   +    p  0b   +   Zp  +    [wÿ,<  Zw,<   w/"  ,   ,<  ,  XBwÿ,\  XBwÿ+   $ " (X . 1)
(N . 1)
(MKN URET2 SKLST BLKENT ENTER2)  0    x    H    (      

LOAD? BINARY
          	    -.           	,<` "  ,<  ,<  $  3B   +   Z   ,~   Z   ,<` ,<` ,<` &  ,~   P  (FILE . 1)
(LDFLG . 1)
(PRINTFLG . 1)
NAMEFIELD
FILEDATES
GETP
LOAD
(KT KNIL ENTER3)         P      

FILESLOAD BINARY
               -.          ,<` "  ,~       (FILES . 1)
DOFILESLOAD
(ENTER1)     

DOFILESLOAD BINARY
    6      1-.         (,<` Z   ,<  ,<   ,<   ,<   ,<   ,<   ,<   ,<   ,< ,< Zp  -,   +   Zp  Z 7@  7   Z  2B +   ,<p  ,<   Z   F B 3B   +   Z   +   Z   /  3B   +      3B   +   ,<  ,<   ,< !,<   ,< ¡,<   ,< "   P ¢Z   ,   XBwýZ   XBw~Zwû2B   +   +  -,   +    XBw}Z   XBwû+   ¢ZwûXBw}[wûXBwû,<wüZwü-,   +   FZwÿ2B +   ª,<wü" #,<  ,< £$ $3B   +   ªZ   +   Å,< ",<w|,< ¡,<wz( ¢,<  ,<   ,<w|& ¤2B   +   >ZwûZ  2B  +   ¶Zw~2B   +   ¶,<wü,<   ,<w|& ¤2B   +   >Zwþ3B   +   ¸+   ©,<wüZwü3B   +   <,< %D ¥+   ¼Z &D ¦XBwü+   ªXBwüZwÿ2B '+   Â,<wü,<   $ 'Zwü+   E,<  ,<w|,<wü "  ,   ,   +  ,<   Zw|-,   +   IZp  +  Zw|2B §+   NZ (XBwZ   XBw}Z   XBw{+  2B ¨+   ÑZ ¨XBwZ   XBw{+  2B )+   zZw|,<  [wûXBwû,\  Zw|XBwþ3B ©+   Ü2B *+   à[w|Z  2B ª+   àZw|,<  [wûXBwû,\  Zw|,<  [wûXBwû,\  Zw|B ++   w,<wþ" «1B  ½+   ö0B  +   d+   ö,<wþ,< ,$ ¬XBwþ,<  Zp  -,   +   pZp  Z 7@  7   Z  2B +   o,<p  ,<   Z  F B 3B   +   pZ   +   ðZ   /  3B   +   öZwþZ 7@  7   Z  XBwþ3B   +   ö+   wZw|-,   3B   7    ,   XBwü+  2B -+   ýZ   XBwýZ  °XBw{+  2B ­+   Z XBw+  3B ¡+  2B .+  Z   XBwý[w|-,   Z   XBw|Zw|XBw{+  3B ®+  2B /+  
Z   XBw{+  2B ¯+  Z 'XBwZ   XBw{+  2B 0+  Z   XBw~+  Zw|Z   ,   3B   +  Zw|XBw}Zw|,<  [wûXBwû,\  +   Æ/  Z   D °XBwü+   Zwü/  ,~   Hj6W h@Zk(QL?&(.G ù VaDáo@(       (FILES . 1)
(VARIABLE-VALUE-CELL COMPILE.EXT . 248)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 217)
(VARIABLE-VALUE-CELL DIRECTORIES . 50)
(VARIABLE-VALUE-CELL LDFLG . 53)
(VARIABLE-VALUE-CELL LOADOPTIONS . 289)
LOAD?
LDFLG
NOBIND
STKSCAN
RELSTK
INPUT
VERSION
NAME
EXTENSION
BODY
PACKFILENAME
NAMEFIELD
FILEDATES
GETP
FINDFILE
((not found on) . 0)
APPEND
"not found"
ERROR
CHECKIMPORTS
LOADCOMP
LOADCOMP?
LOADFROM
FROM
VALUEOF
VALUE
OF
EVAL
CHCON1
DIRECTORIES
PACK*
COMPILED
LOAD
EXT
SOURCE
SYMBOLIC
IMPORT
NOERROR
NCONC
(FMEMB SKLST ASZ CONSNL EVCC SKNLST CONS BHC KT KNOB SKLA KNIL ENTER1)       H x    ã (    F    Å    H h   (   (      0 |   Á P ® H     ô (     h H 	    (   v   q p m 
 Í 	H G ( 8 h ³   ª    P  p  0      p   `   P   @      

DMPHASHA0004 BINARY
            -.          ,<  Z` 3B   +   3B   +   -,   +   ,<  ,<  ,   ,<  Z` 3B   +   3B   +   -,   +   ,<  ,<  ,   ,<  Z   ,<  ,   B  ,~   ,
`      (VAL . 1)
(ITEM . 1)
(VARIABLE-VALUE-CELL ARRAYNAME . 26)
PUTHASH
QUOTE
PRINT
(LIST4 LIST2 SKNNM KT KNIL ENTER2)   p   P       X         	  8      

DMPHASH BINARY
    >    2    <-.          2,<` Zp  -,   +   Z   +    Zp  ,<  @  ²   +   °,<  3,<   ,<   @  ³ ` +   0Z   Z  5XB Z   ,<  ,<  µ$  6,<  ,<   ,<  ¶Z  ,<  Zwþ-,   +   ¡ZwþXBw,<  7,<  ·B  8,<  ,<wý,<  ¸$  93B   +   3B   +   -,   +   ,<  ¹,<  ,   ,   ,<  [wý3B   +    3B   +    -,   +    ,<  ¹,<  ,   ,   +   ©,<  :B  8,<  ,<w~,<  ¸$  93B   +   )3B   +   )-,   +   ),<  ¹,<  ,   ,   ,   B  ºZp  2B   +   ¬Zwÿ,<  Z  ;D  »Z   /  Z   ,~   ,~   [p  XBp  +   JF!9U@VUB&      (L . 1)
(VARIABLE-VALUE-CELL ARRAYNAME . 30)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
DMPHASH
EVALV
RPAQ
CONS
HARRAY
HARRAYSIZE
OVERFLOW
HARRAYPROP
QUOTE
HASHARRAY
PRINT
DMPHASHA0004
MAPHASH
(BHC ALIST3 LIST2 SKNNM SKLST CF KT URET1 KNIL SKNLST ENTER1)   x   ( *      ©      § p             0 h            / @ ¥ P  p 	  H    8      

HARRAYPROP.DUMMY BINARY
     -    ¥    «-.         ¥.   .    8  1b   +   Z` 2B   +   Z   ,<  .   .    8  1b  +   
Z` +   Z   ,<  ,<wÿ"  ¦2B   +   Zwÿ-,   Z   Z  B  ¦2B   +   ,<  ',<w,   B  §Zp  3B  (+   2B  ¨+   ,<wÿ"  )+    2B  ©+   #Zwÿ-,   +   [wÿ+   Z  *,<  .   .    8  1b  +   "Zw-,   +   !,<  Z` D  ª+   ",<  +D  *,\  +    ,<  ',<  ,   B  §+    H
^Y0$y     (NARGS . 1)
(VARIABLE-VALUE-CELL SYSHASHARRAY . 11)
HARRAYP
27
ERRORX
SIZE
NUMKEYS
HARRAYSIZE
OVERFLOW
ERROR
RPLACD
"Can't set overflow of NLISTP hasharray"
(URET2 LIST2 SKLST KNIL CF CFARP ENTERN)  ` £ p   P            p  0              x        

HASHARRAY.DUMMY BINARY
                	-.           Z` 2B  +   ,<` "  ,~   ,<` "  Z` ,   ,~   H   (MINKEYS . 1)
(OVERFLOW . 1)
ERROR
HARRAY
(CONS ENTER2)   p      

HASHARRAYP.DUMMY BINARY
         	    
-.           	,<` "  2B   +   Z` -,   Z   Z  B  3B   +   Z` ,~   Z   ,~      (X . 1)
HARRAYP
(SKLST KNIL ENTER1)      	  p   8      

HASHOVERFLOW BINARY
    6    ¯    ´-.           ¯,<` ,<  0$  °,<  Z` -,   +   [` +   ,<  ,<  1$  °,<  ,<   Zwÿ2B  ±+   ,<  2,<` ,   B  ²+   
,<` 2B   +    wþ,>  /,>   wþ."  (Bÿ.Bx  ,^  /  ,   +   §   +   Zwþ,   ,>  /,>  Zw,   Bx  ,^  /  ,   +   §-,   +    wþ,>  /,>   w.Bx  ,^  /  ,   +   §,<  ,<`  "  ,   -,   +   § wþ,>  /,>   wþ."  (Bÿ.Bx  ,^  /  ,   ,<  ,<wþ$  3D  ³XBp  Z` -,   +   -Zp  XD  +   .,<p  D  4Z` +      G @* J  (HARRAY . 1)
NUMKEYS
HARRAYPROP
OVERFLOW
ERROR
26
ERRORX
HASHARRAY
REHASH
\COPYHARRAYP
(URET3 SKNNM EVCC SKNM MKFN FUNBOX FLOATT MKN BHC LIST2 KNIL SKLST ENTER1)   ¯    ¢    "             `   H      8   x               8        

CONCATLIST BINARY
                 -.           ,<` ,<   ,<  Zw-,   +   +   Z  XBwÿ,<p  B  D  XBp  [wXBw+   Zp  /  B  ,<  ,<` ,<   ,<   ,<  Zwþ-,   +   +   Z  XBwÿ,<w~,<wÿF  [wþXBwþ p  ,>  ,>  ,<wÿ"  ,   .Bx  ,^  /  ,   XBp  +   Zw/  Zp  +      1DB°	   (L . 1)
0
NCHARS
PLUS
ALLOCSTRING
1
RPLSTRING
(URET1 MKN IUNBOX BHC SKNLST KNIL ENTER1)  8      h   (  0   p      P        

CHANGENAME BINARY
                -.          ,<` "  ,<  ,<` ,<` ,<` (  3B   +   Z   3B   +   ,<` "  3B   +   ,<` ,<  $  Z` ,~   U@ (FN . 1)
(FROM . 1)
(TO . 1)
(VARIABLE-VALUE-CELL FILEPKGFLG . 12)
GETD
CHANGENAME1
EXPRP
FNS
MARKASCHANGED
(KNIL ENTER3)    `      

CHNGNM BINARY
     à    O    Ý-.           O,<   ,<   ,<   ,<   ,<   ,<` ,<   ,<   &  ÐXB` ,<` ,<   ,<   &  Ð2B   +   
Z` XB` ,<` ,<  Q$  Ñ2B   +   ,<` ,<  R$  Ñ2B   +   Z` B  ÒXBwþ,<` ,<  S,<` ,   B  ÓXBw~Z` 3B   +   $,<w~"  T2B   +   ,<w~"  Ô,<` ,<` ,<  U$  ÑD  ÕXBp  3B   +   ,<` ,<  UF  V+    ,<` ,<  U$  Ö,<w~,<  W$  ÖZ` XBwÿZw~XBw+   /Zw~XBwÿZ` XBw,<` ,<` ,<  U$  ÑD  ×3B   +   /,<w~"  Ò3B   +   /,<w~,<  W$  Ñ3B   +   /Zw~+    Zwþ2B   +   2Z  X,   +    @  Ø  +   ·Zwþ,<?þ,<?,<?ÿZwý,<8 (  Y,~   2B   +   <,<w,<  ÙZ` ,   D  Z,   +    Z` 2B   +   N,<` "  ÒXBwþ2B   +   Å,<  Ú   [,   XBwþZ` Z  Û,   ,<  ,<   ,<   &  \,<w~,<` ,<   ,<w},<` (  ÜD  Ô,<` ,<  U,<` &  ],<w~,<  WZ` Z` ,   F  VZwÿ+    5Ô*9;°jZP%SDjD        (FN . 1)
(OLD . 1)
(FLG . 1)
FNCHECK
ADVISED
GETP
BROKEN
GETD
-IN-
PACK
STKPOS
/PUTD
NAMESCHANGED
/DREMOVE
/PUT
/REMPROP
ALIAS
MEMB
((not defined) . 0)
(T VARIABLE-VALUE-CELL NOLINKMESS . 0)
CHANGENAME1
((not found in) . 0)
APPEND
NLAMBDA
GENSYM
((was undefined) . 0)
PRINT
SAVED
/ADDPROP
(ALIST2 CONSS1 CONSNL CONS URET5 LIST3 KT KNIL ENTER3)  B    <    ;    N @ 2    Ï H ² x   8   X E    `   x @ X ¸  . 8 © H  X  P   X   @   0        

DEFINE BINARY
       æ    Ò    ã-.           Ò,<` ,<   Zwÿ-,   +   	Zp  Z   2B   +    "  +   [  QD   "  +    Zwÿ,<  @  Õ  +   OZwþZ8  -,   +   ,<  WD  ×ZwþZ8  XB   Zwþ[8  [  2B   +   Zwþ[8  Z  +   Z  XZwþ[8  ,   XB` ZwZ8 3B   +   ,<` "  ØZ   3B   +   2B   +   ÄZ  B  Y2B   +   7   Z   XB` 2B   +   .Z  ,<  ,<   $  Ù,<` Z  !B  Y,\  ,   3B   +   §Z  £,~   Z  2B   +   ¿Z  ¦Z  Z,   ,<  ,<   ,<   &  ÚZ  )B  [+   ¿Z  ¬,<  ,<  Û$  \3B   +   7Z  .Z  Ü,   ,<  ,<   ,<  ],<  Ý,<   ,<   ,<   .  ^+   ¿Z  1,<  Z   D  Þ3B   +   ¿Z  7Z  _,   ,<  ,<   ,<  ß,<  Ý,<   ,<   ,<   .  ^Z   3B   +   BZ  :B  `Z  A,<  ,<` $  à+   ÊZ  ¿3B   +   HZ  B,<  ,<  a$  `Z  F,<  ,<  á,<` &  bZ   3B   +   ¦Z  H,<  ,<  â,<` &  c+   ¦/  Zp  ,   XBp  [wÿXBwÿ+   E#@F%("D5bQDQÉK       (X . 1)
(TYPE-IN . 1)
(VARIABLE-VALUE-CELL DFNFLG . 79)
(VARIABLE-VALUE-CELL LISPXCOMS . 112)
(VARIABLE-VALUE-CELL ADDSPELLFLG . 137)
(VARIABLE-VALUE-CELL FILEPKGFLG . 149)
(NIL VARIABLE-VALUE-CELL CX . 152)
NIL
NIL
"incorrect defining form"
ERROR
LAMBDA
FIXEDITDATE
GETD
VIRGINFN
((redefined) . 0)
LISPXPRINT
SAVEDEF
CLISPWORD
GETPROP
((defined, therefore disabled in CLISP.) . 0)
"****Note: "
%

MAPRINT
MEMB
((is also the name of a history command. When typed in, its interpretation as a history command will take precedence.) . 0)
"****Note: "
ADDSPELL
/PUTD
0
EXPR
/PUTPROP
FNS
MARKASCHANGED
(COLLCT BHC EQUAL KT CONS URET2 SKNLST KNIL ENTER2)   
   
    `   x = h 4 H , 0  H   @ 3 0           @   	@ F  ? h : ` µ  ) h !    8  (   X        

EQMEMB BINARY
               -.           Z` Z` 3B  7   7   +   
Z` -,   +   Z` Z` ,   3B   +   Z   ,~   Z   ,~   $  (X . 1)
(Y . 1)
(FMEMB SKLST KNIL KT ENTER2)                   @      

FILEDATE BINARY
        B    6    @-.          6Z` 3B   +   µ,<  ·,<  8,<   @  ¸ ` +   5Z   Z  :XB ,<   ,<   ,<   Zwý,<8 ,<  º$  ;XBw3B   +   ZwýXB8 +   Zwý,<8 "  »B  ºZwýXB8 B  <2B   +   +   -,<  ¼Zw},<8 ,<   Zw|Z8 ,   ."  
,   H  =2B   +    Zw3B   +   -Zwÿ2B   +   -Zw,   ,   XBwÿ,<w,<  ½$  >+   ZwýZ8 3B   +   £,<8 Z   D  ¾Zwý,<8 Z  ¢D  ¾XBp  -,   +   (Z   +   ¬Zp  2B  ?7   7   +   ¬[p  -,   Z   Z  XBp  Zw2B   +   °Zwý,<8 "  ¿+   ³Zwÿ3B   +   ³Zwý,<8 D  >Zp  /  +    Z  ,~   UIp	R     (FILE . 1)
(CFLG . 1)
(VARIABLE-VALUE-CELL FILERDTBL . 73)
((DUMMY) . 0)
NOBREAK
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
INPUT
OPENP
INFILE
RANDACCESSP
"(FILECREATED"
FILEPOS
0
SETFILEPTR
READ
FILECREATED
CLOSEF
(CONSNL BHC SKLST KT SKNLST MKN FGFPTR CF KNIL ENTER2)  X   P   @   (   p   `      p    p     ® H *   " @    (   	    0      

FILEMAP BINARY
            -.            ,<  ,<` Z   F  ,~   @   (FILEMAP . 1)
(VARIABLE-VALUE-CELL FILECREATEDLST . 6)
INPUT
PUTFILEMAP
(ENTER1)     

FNCHECK BINARY
    ü    f    y-.     (      f,<   ,<   ,<   Z` -,   +   +   ÛB  ê2B   +   ×,<` ,<  k$  ë3B   +   Z` 2B   +   ×+   ÛZ   2B   +   +   Û,<  l,<   ,<   @  ì ` +   Z   Z  nXB Zw,<8 ,<  îZ   ,<  ,<8 ,<8 Z  êL  o2B   +   Zw,<8 ,<  îZ   ,<  ,<8 ,<8 *  oZwþXB?+    Z  3B   +   !ZwZ` 3B  +   !XB` +   Z  ï6@   Z  p2B  ð+   Û,<` "  q,<  ,<   ,<   Zw-,   +   (+   ÏZ  XBp  ,<  ,<  ñ$  ë2B   +   ,Zp  ,<  ,<   ,<   Zw2B   +   ¯+   I-,   +   ²XBp  Z   XBw+   ´ZwXBp  [wXBw,<p  ,<  r$  ò,<  ,<   ,<   Zw-,   +   ¹+   CZ  XBp  Zwú3B   +   Á,<` ,<wú$  s3B   +   ÁZp  2B   +   ÀZ   XBwÿ+   C[wXBw+   ·Zwÿ/  XBwü3B   +   ÈZp  2B   +   ÇZ   XBwÿ+   I+   ­Zwÿ/  3B   +   NZp  2B   +   MZ   XBwÿ+   Ï[wXBw+   &Zwÿ/  3B   +   Û,<  óZw,<  ,<  t,<` (  ôXBp  B  ê3B   +   ÛZp  XB` Z   3B   +   Ú,<` ,<  u$  õZ` +    Z` 3B   +   ^Z   +    ,<` ,<  v,<  ö"  w2B   +   b,<  ÷"  wB  x2B   +   d7   Z   F  øXB` +   :iN*!R7AF@hÁR$b$F*ÂBtP      (FN . 1)
(NOERRORFLG . 1)
(SPELLFLG . 1)
(PROPFLG . 1)
(TAIL . 1)
(VARIABLE-VALUE-CELL DWIMFLG . 22)
(VARIABLE-VALUE-CELL USERWORDS . 38)
(VARIABLE-VALUE-CELL SPELLINGS2 . 49)
(VARIABLE-VALUE-CELL ADDSPELLFLG . 175)
GETD
EXPR
GETP
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
70
MISSPELLED?
TENEX
TOPS20
D
WHEREIS
FILEGROUP
BLOCKS
FILECOMSLST
MEMB
\
/
PACK*
0
ADDSPELL
"not a function"
LOAD
STKPOS
LOADFROM
RELSTK
ERROR
(URET3 BHC KT SKNLST KL20FLG CONSNL CF SKNLA KNIL ENTER5)  Þ @   
 Ê H   H Í 	  A    9  §    ¢                e 8 a ` ]  Ö 
 Ì 	0 G X @ h <   ·   / ` ­ 8 ¦ `  p  h  ( 	  h   0        

FNTYP1 BINARY
       
        -.          Z   3B   +   Z` Z  ,   XB` 3B   +   B  	,~   Z   ,~      (X . 1)
(VARIABLE-VALUE-CELL CLISPARRAY . 7)
FNTYP
(GETHSH KNIL ENTER1)   P       0      

FREEVARS BINARY
                -.           Z   ,~       (X . 1)
(KNIL ENTER1)         

LISPSOURCEFILEP BINARY
        ¸    +    ¶-.          +,<` "  ¬,<  Zp  3B   +   B  -2B   +   Z   +   *Z   ,<  @  ­  +   *Z   ,<  ,<  /,<  ¯,<   @  0 ` +   #Z   Z  ±XB ZwþZ8  3B   +   ,<  2,<  ZwýZ8  ,   ,   ,   ,<  ,<   ,   Z  ,   XB  Zwþ,<8  ,<  ²$  2+   ,<  3Zwþ,<8 ,<  ³$  4Zw~XB8  ,   Z  ,   XB  Zwþ,<8  "  ´Zw~XB8 Z   ,~   3B   +   %Z   +   ¥Z  5XB` D  µZ` 3B   +   )   6,~   Z` ,~   /  ,~   5jC s  4`        (FILE . 1)
(VARIABLE-VALUE-CELL LISPXHIST . 14)
(VARIABLE-VALUE-CELL RESETVARSLST . 62)
OPENP
RANDACCESSP
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
SETFILEPTR
0
((PROGN (CLOSEF? OLDVALUE)) . 0)
INPUT
OPENFILE
\LISPSOURCEFILEP1
ERROR
RESETRESTORE
ERROR!
(BHC KT ALIST2 CONS LIST2 ALIST3 MKN FGFPTR CF KNIL ENTER1)   0   0   h   x                         ( P $ `  H   `        

\LISPSOURCEFILEP1 BINARY
      O    Â    Ì-.          Â@  Ä  ,~   ,<  Å,<   ,<   @  F ` +   AZ   Z  ÇXB Zw,<8 Z   D  H2B  È+   ,<  I,<   ,<   Zw-,   +   +   Z  XBp  ,<  Zw},<8 Z  D  É,\  3B  +   Zp  2B   +   Z   XBwÿ+   [wXBw+   Zwÿ/  3B   +   Z   +   @Z   +   Z   +   @Zw,<8 "  JZw,<8 "  JZw,<8 Z  D  Ê-,   Z   Zw~XB8 ZwZ8 3B   +   (Zw~Z8 3B   +   @+   )Z   +   @,<  ,<   Z   Zw}XB8 Zwÿ2B   +   .    +   ®,   ,>  B,>  Zw~,<8 "  K2B   +   3   -+   ³,      ,^  /  2"  +   ?Zw~,<8 ,<w$  ËZw~,<8 Z   D  ÊXBp  -,   Z   Z  2B  L+   ?[p  Z  Zw}XB8 Z   /  Z   ,~   Z` ,~     C$HUP
E C        (FILE . 1)
(FL . 1)
(VARIABLE-VALUE-CELL FILERDTBL . 114)
(VARIABLE-VALUE-CELL MAX.FIXP . 100)
NIL
(((16 (ERROR!))) VARIABLE-VALUE-CELL ERRORTYPELST . 0)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
SKIPSEPRS
%(
((%( F I L E C R E A T E D % ) . 0)
READC
SKREAD
READ
GETEOFPTR
SETFILEPTR
FILEMAP
(SKLST IUNBOX SKI BHC KT SKNLST CF KNIL ENTER2)  8   @ /    ¢    À X     A 8             @ @ 2 P + ( ) x ¥ 0  (  H  @   H      

GETFILEMAP BINARY
      &        ¤-.          Z   3B   +   ,<   Z` 3B   +   Z` ,<  ,<` ,<  $   -,   Z   XBwÿZ  ,\  2B  +   [p  Z  +   ,<` ,<   $  !2B   +   ,<  ¡,<` ,   B  "+   ,<` "  ¢2B   +   Z   +   Z` ,   ,   XBp  ,<` ,<  #$  £,<` ,<   $  $,<  ,<` ,<w$  £,\  /  ,~   Z   ,~   @K3TD       (FILE . 1)
(FL . 1)
(VARIABLE-VALUE-CELL USEMAPFLG . 3)
FILEMAP
GETPROP
INPUT
OPENP
13
ERRORX
RANDACCESSP
0
SETFILEPTR
\LISPSOURCEFILEP1
(BHC KT MKN FGFPTR LIST2 SKLST KNIL ENTER2)   P      h   `         `  8     @        

LCSKIP BINARY
               -.          ,<   ,<      2B  +   ,<   Z   D  XBp  2B  +   
,<` ,<` ,<   ,<   J  +    ,<  ,<  $  XBwÿ3B   +   [wÿ,<  ,<` ,<` ,<   ,<   ,<wý "  ,   +    ,<  ,<` $  Z   +    Kd P    (FN . 1)
(FLG . 1)
(VARIABLE-VALUE-CELL FILERDTBL . 9)
PEEKC
% 
READ
BINARY
BINSKIP
CODEREADER
GETPROP
"Bad compiled function"
ERROR
(EVCC URET2 KNIL ENTER2)      P  (   H      	  P   (      

MAPRINT BINARY
    ª    £    )-.     8      £,<` @  '   ,~   ZwZ8 2B   +   Z  §ZwXB8 Z8 2B   +   
Z  (ZwXB8 Z8 3B   +   ,<  ,<8 $  §ZwZ8 -,   +   +   Zw,<8 Z8 ,<  Zw~,<8  "  ,   Zw[8 ZwXB8 2B   +   +   -,   +   ,<  ¨,<8 $  §Zw,<8 ,<8 ,<8  "  ,   +   ,<8 ,<8 $  §+   ZwZ8 3B   +   ¢,<  ,<8 $  §Z   ,~   $0 6@L$     (LST . 1)
(FILE . 1)
(LEFT . 1)
(RIGHT . 1)
(SEP . 1)
(PFN . 1)
(LSPXPRNTFLG . 1)
(VARIABLE-VALUE-CELL LISPXPRINTFLG . 0)
LISPXPRIN1
% 
" . "
(EVCC SKNLST KNIL ENTERF)   P      p   8 ! h          

MKLIST BINARY
               -.           Z` 3B   +   -,   +   ,   ,~   Z   ,~   @   (X . 1)
(CONSNL SKNLST KNIL ENTER1)             0      

NLIST BINARY
              -.          .   .   ,<8  ,<   Zwÿ0B   +   Zp  +    Zp  2B   +   
 wÿ."`  Z  3B   +    wÿ."`  Z  Zp  ,   XBp   wÿ/"  ,   XBwÿ+   B (N . 1)
(MKN CONS URET2 ASZ KNIL CF CFARP ENTERN) p   P    h    P       @    0    (      

PRINTBELLS BINARY
              -.           Z   ,<  ,<   $  ,~       (VARIABLE-VALUE-CELL BELLS . 3)
PRIN3
(KT ENTER0)          

PUTFILEMAP BINARY
        %         $-.           Z` 3B   +   Z   3B   +   ,<   ,<` ,<   $  "XBp  ,<  ,<  ¢,<` ,<` Z` 2B   +   ,<w~,<  ¢$  #[  [  Z  +   ,<  ,<   Zwÿ-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   Zwÿ,<  Zp  ,<  [wÿZ  ,   /  Zp  ,   XBp  [wÿXBwÿ+   /  ,   F  £Z   +    Z   ,~   "!1Q  (FILE . 1)
(FILEMAP . 1)
(FILCREATEDLST . 1)
(VARIABLE-VALUE-CELL BUILDMAPFLG . 6)
NAMEFIELD
FILEMAP
GETPROP
/PUT
(URET1 ALIST3 COLLCT BHC ALIST2 SKNLST KT KNIL ENTER3)                           h      (  x   X   0      

RAISEP BINARY
             -.           ,<   ,<` $  3B   +   ,<   ,<` $  Z   ,~   H   (TTBL . 1)
RAISE
(KT KNIL ENTER1)  h       (      

READFILE BINARY
                -.          @    ,~   Zw,<8 "  B  ZwXB8 ,<  ,<   ,<   @   ` +   Z   Z  XB Zw,<8 Z   D  Zw~XB8 Z   ,~   2B   +   Z` ,~   Z` 2B  +   Zw,<8 "  +   ,<` ,   D  XB` +   2*    (FILE . 1)
(VARIABLE-VALUE-CELL FILERDTBL . 23)
NIL
NIL
(NIL VARIABLE-VALUE-CELL HELPCLOCK . 0)
INFILE
INPUT
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
READ
STOP
CLOSEF
NCONC
(CONSNL KT CF KNIL ENTER1)           
              

READLINE BINARY
    ¢      -.         0@   (
,~   Z   -,   +   +   ý,<   " 2B   +   	,<   " Z   ,~   Z   XB   ,<` ZwþZ8 2B   +   Z   D XB` B XB` ,   A"  ¿,<  ,<   " ."  Z  ,\  2B  +   ,<` " Z  3B   +   eZ  3B   +   eZ` 2B   +   	,< ,<   $ +   	 ` A"  ¿,> ,>  Zw,<8 " .Bx  ,^  /  ."  [  1B  R+   © ` A"  ¿,> ,>  Zw,<8 " .Bx  ,^  /  ."  [  0B  Ð+   2,<` Zwþ,<8 $ Z   3B   +   e[  2B   +   eZ  -,<  Z   ,   D XB  ®+   eZ` ,<  Z"  ,\  2B  +   ? ` A"  ¿,> ,>  Zw,<8 " .Bx  ,^  /  ."  [  A"   1B   +   ?Z   XB  ,<` " +   
Z   2B +   C,<` Zwþ,<8 $ +   F,<  ,<` Zw~,<8  "  ,   XB` Z   2B  +   È+   
Z  1,<  ,   D XB  È,<` " B XB` ,   A"  ¿,> ,>  Zw,<8 " .Bx  ,^  /  ."  [  0B  Ð+   Ô+   e ` A"  ¿,> ,>  Zw,<8 " .Bx  ,^  /  ."  [  1B  R+   \+   	Z  «3B   +   áZ  =2B   +   á[  Ê[  2B   +   á+   eZ` 2B   +   	,< ,<   $ +   	Z  _-,   +   ñZ   3B   +   ñZ   XB  æ,< ,<   ,<   @  ` +   ïZ   Z XB Z  eB Z   ,~   2B   +   ñZ XB   Z` 3B   +   [  Z  [  Z  3B  +   w  +   û[  sZ  [  ,<  Z` ,    $   @` D ,<` ,< $ +   Z  wZ   2B  +  [  ýXB  ÿ+   Z  B XB 2B   +  +   XB` [ XB Z  í,<  Z` ,   D XB Z 2B   +   ý+     5 
A
$lDIDDbMI$1@L      (RDTBL . 1)
(VARIABLE-VALUE-CELL LINE . 272)
(VARIABLE-VALUE-CELL LISPXFLG . 184)
(VARIABLE-VALUE-CELL READBUF . 273)
(VARIABLE-VALUE-CELL LISPXREADFN . 126)
(VARIABLE-VALUE-CELL HISTSTR4 . 141)
(VARIABLE-VALUE-CELL CTRLUFLG . 209)
(VARIABLE-VALUE-CELL REREADFLG . 226)
(VARIABLE-VALUE-CELL HISTSTR0 . 252)
NIL
(NIL VARIABLE-VALUE-CELL SPACEFLG . 187)
NIL
T
NIL
READP
CLEARBUF
PEEKC
CHCON1
GETTERMTABLE
READC
...
PRIN1
GETREADTABLE
READ
NCONC
LASTC
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
EDITE
ABORT
SHOULDNT
RPLACA
-1
SETFILEPTR
LISPXREADBUF
(FIXT FGFPTR CF EVCC ASZ CONSNL BHC IUNBOX KNIL KT SKLST ENTERF)   0   (   P   h   @     Ê      Ò ( (    	`    
 8 s  k ( i   a p Ý  ® P  h  H 
  p   x ä 0 ½ 0  X   `   h        

REMPROPLIST BINARY
               -.           ,<   ,<   ,<   ,<` "  XBwXBwÿ2B   +   Z   +    Zwÿ-,   +   	+   ZwÿZ` ,   3B   +   ZwÿZw2B  +   [w[  XBw+   [wÿ[  XBp  3B   +   ,<wÿD  +   ,<w,<  ,<wþ&  B  +   [wÿ[  XBwÿ+   ,<` ,<wþ$  +   D"5b0  (ATM . 1)
(PROPS . 1)
GETPROPLIST
RPLNODE2
1
NLEFT
RPLACD
SETPROPLIST
(FMEMB SKNLST URET3 KNIL ENTER2) 0       x       p   8   (      

RESETBUFS BINARY
               -.               ,<   ,<   Z   F  ,<  Z  ,<  ,<` ,<  &  ,<  Zwÿ3B   +   
B  ,\  +    )F  (FORMS . 1)
(VARIABLE-VALUE-CELL READBUF . 7)
LINBUF
SYSBUF
CLBUFS
PROGN
INTERNAL
APPLY
BKBUFS
(URET1 KT KNIL ENTER1)             8      

TAB BINARY
                -.           ,<   ,<` "  XBp  ,   ,>  ,>  Z` -,   +   ^"  +   ,   .Bx  ,^  /  ,>  ,>   `    ,^  /  2b  +    ` ,>  ,>   p     ,^  /  /  ,   ,<  ,<` $  +   Z` 2B   +   +   ,<` "  ,<` ,<` $  Z   +      "B@R   (POS . 1)
(MINSPACES . 1)
(FILE . 1)
POSITION
SPACES
TERPRI
(URET1 KT MKN BHC SKNNM IUNBOX KNIL ENTER3)      X   (          h          (      

UNSAVED1 BINARY
        ¸    ¬    ¶-.          ¬,<   ,<   Z` -,   +   *Z` XBp  3B   +   ,<` ,<` $  ®+   ,<` Z  /XBwÿD  ®2B   +   ,<` Z  ¯XBwÿD  ®2B   +   ,<` Z  0XBwÿD  ®XBwÿ3B   +   ,<` "  °3B   +   ,<` "  1,<` ,<wÿ$  ±Z   3B   +   ,<` "  2,<` ,<w,<   &  ²Z   3B   +   ,<` "  3Zp  +    ,<` "  °2B   +   ",<` "  ³3B   +   &Z` 3B   +   %Z  4,   +    Z  ´+    ,<` ,<   $  5XBp  3B   +   *XB` +   ,<` ,<  µ$  6Z   +    DjU)TJE©@       (FN . 1)
(TYP . 1)
(VARIABLE-VALUE-CELL DFNFLG . 44)
(VARIABLE-VALUE-CELL ADDSPELLFLG . 53)
GETP
EXPR
CODE
SUBR
GETD
UNBREAK0
/REMPROP
SAVEDEF
/PUTD
ADDSPELL
GETPROPLIST
((not found) . 0)
((nothing found) . 0)
FNCHECK
"not a function"
ERROR
(CONS URET2 KT SKLA KNIL ENTER2)   P   P ¦ X     § (         ¬  £     @    0   0        

UNSAVEDEF BINARY
            -.           Z` -,   +   ,<  ,<   Zwÿ-,   +   Zp  Z   2B   +    "  +   
[  QD   "  +    Zwÿ,<  ,<p  ,<` $  /  Zp  ,   XBp  [wÿXBwÿ+   ,<  ,<` $  ,~   P     (X . 1)
(TYP . 1)
UNSAVED1
(COLLCT BHC URET2 SKNLST KNIL SKLST ENTER2)   p   `   0    X    x   H    0      

UPDATEFILEMAP BINARY
           y   -.          y,<  û,<  |$  ü,<  ,<   ,<   ,<   ,<   ,<` ,<  }$  ý,<` Z   D  ~,<` "  þ,<` Z  D  2B  ÿ+   Ç,<` "  ,<` "  ,<   ,<` "  þXBw2B +   Z   +   B ,   A"  ¿,>  ø,>  Z  
B .Bx  ,^  /  ."  [  1B  0+   Z   +   +   Zp  /  3B   +   ÇZ` ,   ,   XBw,<` Z  D  ,<  Z` ,   ,>  ø,>   wþ   ,^  /  /  ,   XBwÿ,\  XBwþ-,   +   Ç,<w~,<` ,<  ,< $ -,   +   ¬,   ,   F 2B   +   0,<w~,<` ,<  }& XBwþ3B   +   Ç,<` "  ,<` Z  D  2B +   Ç,<wþ,<   Z  3F ,   ,>  ø,>   p     ,^  /  2b  +   Ç,<` " ,< ,<   ,<   @  ` +   ÅZ   Z XB Zw,<8 ,< ,< ,<   ,< * 	Z   ,~   2B   +   È,<` " Z   +    ,<` ,<w~$  ý,< 
,<` $ Z` ,   ,   XBwþ,< ,<` $ ,<` ,< $ ,< " ,<  @   +   j,< Z   ,<  ,   ,   Z   ,   XB  VXB` ,< ,< ,<   @  ` +   aZ   Z XB Zw,<8 ,<8 Z  6F Zw~XB8 Z   ,~   2B   +   cZ XB   [` XB  W,< Z` Z  [  D Z  â3B   +   i  ,~   Z` ,~   ,< ,<` $ ,<` " ,< ,<` $ ,<` ,<wþ$  ý,< ,<wÿ,   ,<  ,<w~,<` & Z   3B   +   Ç,< ,<   $ ,<` ,<   ,<   & +   Ç  uI1 FJ2N(E=0(1	EiA           (FILE . 1)
(FILEMAP . 1)
(VARIABLE-VALUE-CELL FILERDTBL . 188)
(VARIABLE-VALUE-CELL RESETVARSLST . 199)
(VARIABLE-VALUE-CELL DFNFLG . 230)
"(DECLARE: DONTCOPY
  "
"(FILEMAP"
CONCAT
0
SETFILEPTR
SKIPSEPRS
READC
RATOM
FILECREATED
SKREAD
% 
CHCON1
GETREADTABLE
.9
TIMES
FFILEPOS
STOP
NCHARS
CLOSEF
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
BOTH
OLD
((DON'T.CHANGE.DATE) . 0)
OPENFILE
INFILE
"(DECLARE: DONTCOPY
  "
PRIN3
"(FILEMAP "
9
POSITION
10
RADIX
(VARIABLE-VALUE-CELL OLDVALUE . 168)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 205)
((DUMMY) . 0)
INTERNAL
PRIN2
ERROR
APPLY
ERROR!
"))"
PRIN1
TERPRI
PRINT
FIX
PRINTNUM
"****rewrote file map for "
(CONS CONSNL LIST2 URET5 CF SKNI SKI MKN FGFPTR BHC IUNBOX KT KNIL ENTER2) 
x   
h    V    I    \    8       	X - `     M       ; P  x     ¬ 8     ÷ ` ô  Å h     h   Z 	 Æ @ ¾ ` ± `      `   P        

USEDFREE BINARY
             -.          Z` ,~       (A . 1)
(ENTER1)     

WRITEFILE BINARY
    Ï    ¼    M-.          ¼Z   B  ¾,<  @  ?  ,~   ,<  ¾Z   ,<  ,   ,   Z   ,   XB  XB` ,<  A,<  Á,<   @  B ` +   ³Z   Z  ÃXB    D,<  ,<   Zw~Z8 -,   +   Z8 Zw~XB8 Z   XBp  Zw~,<8 "  ÄZw~Z8 -,   +   B  EZw~XB8 ,<  Å"  F   DB  Æ,<  G"  F   ÇB  F,<  H"  F   ÈB  F,<  I"  FZw~,<8 Zp  -,   +   ¢+   +Zp  ,<  ,<p  ,<   Zw-,   Z   Z  2B  É7   Z   F  J   Ê/  [p  XBp  +    /  ,<wÿ"  DZw~XB8 Zp  2B   +   0,<8 "  KZw~Z8 /  Zw~XB8 Z   ,~   2B   +   µZ  ËXB   [` XB  ,<  ¾Z` Z  [  D  LZ  53B   +   »   Ì,~   Z` ,~   U~1P"0        (X . 1)
(FILE . 1)
(VARIABLE-VALUE-CELL FILERDTBL . 3)
(VARIABLE-VALUE-CELL RESETVARSLST . 108)
SETREADTABLE
(VARIABLE-VALUE-CELL OLDVALUE . 10)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 114)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
OUTPUT
OUTFILE
EVAL
"
(PRIN1 (QUOTE %"
WRITEFILE OF "
PRIN1
PRIN2
" MADE BY "
USERNAME
" ON "
DATE
"
%")T)

"
DEFINEQ
PRINTDEF
TERPRI
ENDFILE
ERROR
APPLY
ERROR!
(BHC SKNLST SKA KT SKLST CF KNIL CONS CONSNL LIST2 ENTER2)    ,         p   8 ¨ 8   `         º H /   ¦ P  0       x    p      

XNLSETQ BINARY
            -.          ,<` ,<` ,<` &  ,~       (XNLSETQX . 1)
(XNLSETFLG . 1)
(XNLSETFN . 1)
ERRORSET
(ENTER3)     

PROG2 BINARY
                -.          .   .    8  0"  +   ,<  "  ,~   Z` ,~   p   (U . 1)
"Too few arguments"
ERROR
(CF CFARP ENTERN)   0    (      

RESETFORM BINARY
       *         ¨-.          Z` ,<  ,<  !$  ¡,<  @  "  ,~   ZwZ8 Z  ,<  Z   ,<  ,   ,   Z   ,   XB  XB` ,<  $,<  !,<   @  ¤ ` +   Z   Z  &XB Z  ¦,<  Zwþ[8 ,<  ,<  !&  'Zw~XB8 Z   ,~   2B   +   Z  §XB   [` XB  ZwZ8 Z  ,<  Z` Z  [  D  'Z  3B   +      (,~   Z` ,~     T00      (RESETZ . 1)
(VARIABLE-VALUE-CELL RESETVARSLST . 48)
INTERNAL
EVAL
(VARIABLE-VALUE-CELL OLDVALUE . 15)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 57)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
PROGN
APPLY
ERROR
ERROR!
(KT CF KNIL CONS CONSNL LIST2 ENTER1)  X   x   `  X   0             

RESETLST BINARY
                -.         Z   ,<  @    ,~   Z   ,<  Z  ZwþZ8 ,   ,<  ,<  $  XB` 3B   +   Z   +   Z  D  Z` 3B   +   Z` ,~      Z   ,~   2r      (RESETX . 1)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
(VARIABLE-VALUE-CELL RESETVARSLST . 8)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
PROGN
INTERNAL
ERRORSET
ERROR
RESETRESTORE
ERROR!
(KNIL CONS ENTER1)   X       x      

RESETTOPVALS BINARY
            -.         Z   ,<  @    ,~   Z   ,<  Z  [   ,   Z  ,   ,<  ,<  $  XB` 3B   +   Z   +   Z  D  Z` 3B   +   Z` ,~      Z   ,~   	9     (VARIABLE-VALUE-CELL RESETX . 11)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
(VARIABLE-VALUE-CELL RESETVARSLST . 8)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((RESETTOPVALS1 (CAR RESETX)) . 0)
PROGN
INTERNAL
ERRORSET
ERROR
RESETRESTORE
ERROR!
(KNIL CONS21 CONS ENTERF)    `  (        p      

RESETTOPVALS1 BINARY
                -.           ,<` Zp  -,   +   Z   +    Zp  ,<  Z  
,<  ,<wÿ$  /  [p  XBp  +   D  (VLIST . 1)
RESETSAVE
APPLY
(BHC URET1 KNIL SKNLST ENTER1)                      

CHARCODE BINARY
     ë    Ö    è-.          ÖZ` -,   +   Z  ×,<  Z` ,<  ,<`  "  ,   ,<  Z  ×,<  [` ,<  ,<`  "  ,   ,   ,~   -,   +   -,   +   ,<  XD  Ø,~   B  Y0B  +   ,<` "  Ù,~   ,<` ,<  Z$  Ú0B  /+   ^"  ,>  V,>  Z  ×,<  ,<` ,<  [,<  Û&  \,<  ,<`  "  ,   ,   ABx  ,^  /  ,   ,~   0B  +   ¨^"  @,>  V,>  Z  ×,<  ,<` ,<  [,<  Û&  \,<  ,<`  "  ,   ,   .Bx  ,^  /  ,   ,~   ,<` Zp  2B   +   «Z   +    2B  Ü+   ­Z"  +    2B  ]+   ¯Z"  +    3B  Ý+   ±2B  ^+   ²Z"  +    2B  Þ+   ´Z"  +    2B  _+   ½Z` 3B   +   8   ß+   ¹Z  `6@   Z  à3B  a+   »2B  á+   ¼Z"  +    Z"  +    2B  b+   ¿Z"  +    2B  â+   ÁZ"  +    2B  c+   ÃZ"  +    3B  ã+   Å2B  d+   ÆZ"  +    2B  ä+   ÈZ"   +    3B  e+   Ê2B  å+   ËZ"  ¿+    3B  f+   Í2B  æ+   ÎZ"  +    ,<  -,   +   QB  g+   QB  çXBwÿ,\  3B  +   T+   ),<  h,<` $  Ø+       @U5' ' 33=x3s<x<:      (C . 1)
(COMPFLG . 1)
CHARCODE
"BAD CHARACTER SPECIFICATION"
ERROR
NCHARS
CHCON1
1
NTHCHARCODE
2
-1
SUBATOM
CR
LF
SPACE
SP
TENEXEOL
EOL
COMPILEMODE
TENEX
TOPS20
D
ALTO
BS
TAB
BELL
ESC
ESCAPE
NULL
RUBOUT
DEL
FF
FORM
MKATOM
U-CASE
"BAD CHARACTER SPECIFICATION"
(SKSTP KL20FLG URET1 KNIL MKN BHC IUNBOX ASZ SKNSTP SKNA CONSS1 EVCC SKLST ENTER2)  P    ¹    Ö 	p L 	 G @ B   > P 5 0 0 ` ,    7 8 ª    ¨ `         ¦ @   	h Ë 	 Æ 8 Á x ½ H ´ ( ¯ X  H                 & 8   p    0      

SELCHARQ BINARY
        °    ,    /-.          ,Z` ,<  [` XB` ,\  ,<  ,<  ¬$  -,<  ,<   ,<   Z` -,   +   	+   ©Z  XBp  [` 2B   +   +   ©Zp  -,   +   Zp  ,<  Zp  -,   +   Z   +   Zp  ,<  ,<wÿ/  Zw~,<  Z  ­,<  ,<w "  ,   ,\  2B  7   Z   /  3B   +   Zp  +   [p  XBp  +   /  2B   +   ¤+   (Zw,<  Z  ­,<  Zw,<   "  ,   ,\  3B  +   ¤+   (Z  .,<  [wÿ,<  ,<  ¬&  ®+    [` XB` +   Z` ,<  ,<  ¬$  -+    2
 )c	@  (SELC . 1)
SELECTQ
EVAL
CHARCODE
PROGN
APPLY
(URET3 KT EVCC BHC SKLST SKNLST KNIL ENTER1) H ¨        # p   X  8   X                x        

CONSTANTOK BINARY
                -.           Z` 2B   +   Z"  2XB` Z` "   +   -,   +      +   Z` ,~   -,   +    ` ,   "   +   Z` ,~   Z   ,~   -,   +   B  ,   1b   +   Z` ,~   Z   ,~   -,   +   Z   ,~   Z` ,<   ` /"  ,   D  XB` 3B   +   [` XB` +   Z   ,~   
D d	  (X . 1)
(DEPTH . 1)
NCHARS
CONSTANTOK
(SKNLST IUNBOX SKLA MKN SKI FLOATT SKNSTP SMALLT ASZ KNIL ENTER2)               0       x    h   8            (   0      

ADDTOSCRATCHLIST BINARY
         	    
-.          	[   -,   +   Z  ,<  Z   ,      ,\  QD  [  XB  Z` XD  ,~       (VALUE . 1)
(VARIABLE-VALUE-CELL !SCRATCHTAIL . 14)
(CONSNL KNIL SKNLST ENTER1)                  

SCRATCHLIST BINARY
                -.          Z` ,<  ,<  $  -,   +   Z   ,   ,<  ,<   @   @ +   Z   XB   Z  ,<  Zwþ[8 ,<  ,<  &  Z  Z  2B  +   Z   ,~   [  ,<  Z  ,<  [  ,<  Z  ,<  ,<   $  ,\  D  Z        [  2D   +   Zp  QD  Zp  +    ,~   !$@   (ARGS . 1)
INTERNAL
EVAL
(VARIABLE-VALUE-CELL !SCRATCHLIST . 43)
(VARIABLE-VALUE-CELL !SCRATCHTAIL . 37)
PROGN
APPLY
RPLACD
(URET1 CONSNL KNIL SKNLST ENTER1) 0    `     x   X    H      

FLESSP BINARY
     
        -.           Z` ,   ,>  ,>  Z` ,      ,^  /  3b  7   Z   ,~         (X . 1)
(Y . 1)
(KT KNIL BHC FUNBOX ENTER2)      x    h    P        

FMAX BINARY
            -.         .   .   Z8  0B   +   Z   ,~   Z` "   +   ,   ,   ,<  ,<  ,<   Zw-,   +   ,<  ,<  ,   B  Zwÿ.   .   Z8  2B  +   Zw+    :wÿ wÿ."`  Z  "   +   ,   ,   XBp  ,   ,>  ,>  Zw,      ,^  /  3b  +   Zp  XBw+     BH@$  (K . 1)
(VARIABLE-VALUE-CELL MIN.FLOAT . 8)
1
10
ERRORX
(BHC URET3 LIST2 SKNNM KNIL MKFN FUNBOX FLOATT ASZ CF CFARP ENTERN)         H   (      P      `   x   8           0   `        

FMIN BINARY
            -.         .   .   Z8  0B   +   Z   ,~   Z` "   +   ,   ,   ,<  ,<  ,<   Zw-,   +   ,<  ,<  ,   B  Zwÿ.   .   Z8  2B  +   Zw+    :wÿZw,   ,>  ,>   wÿ."`  Z  "   +   ,   ,   XBp  ,      ,^  /  3b  +   Zp  XBw+     BHA $  (K . 1)
(VARIABLE-VALUE-CELL MAX.FLOAT . 8)
1
10
ERRORX
(BHC URET3 LIST2 SKNNM KNIL MKFN FUNBOX FLOATT ASZ CF CFARP ENTERN)         H   (      p      h   x   X           0   `        

GEQ BINARY
             -.           ,<` ,<` $  2B   +   7   Z   ,~   @   (X . 1)
(Y . 1)
LESSP
(KT KNIL ENTER2)         @      

IGEQ BINARY
               	-.            ` ,>  ,>   `    ,^  /  3"  +   7   Z   ,~        (X . 1)
(Y . 1)
(KNIL KT BHC ENTER2)    x    p    X      

ILEQ BINARY
               	-.            ` ,>  ,>   `    ,^  /  2b  +   7   Z   ,~        (X . 1)
(Y . 1)
(KNIL KT BHC ENTER2)    x    p    X      

IMAX BINARY
               -.         .   .   Z8  0B   +   Z   ,~   Z` ,<  ,<  Zp  .   .   Z8  2B  +   Zwÿ+    :p   wÿ,>  ,>   p  ."`  Z  ,      ,^  /  2"  +    p  ."`  Z  XBwÿ+     B    (K . 1)
(VARIABLE-VALUE-CELL MIN.INTEGER . 8)
1
(BHC IUNBOX URET2 ASZ CF CFARP ENTERN)     p   0    @          (      

IMIN BINARY
               -.         .   .   Z8  0B   +   Z   ,~   Z` ,<  ,<  Zp  .   .   Z8  2B  +   Zwÿ+    :p   wÿ,>  ,>   p  ."`  Z  ,      ,^  /  3b  +    p  ."`  Z  XBwÿ+     B    (K . 1)
(VARIABLE-VALUE-CELL MAX.INTEGER . 8)
1
(BHC IUNBOX URET2 ASZ CF CFARP ENTERN)     p   0    @          (      

LEQ BINARY
                -.           ,<` ,<` $  2B   +   7   Z   ,~   @   (X . 1)
(Y . 1)
GREATERP
(KT KNIL ENTER2)   P    X        

MAX BINARY
             -.         .   .   Z8  0B   +   Z   ,~   Z` ,<  ,<  ,<   Zw-,   +   ,<  ,<  ,   B  Zwÿ.   .   Z8  2B  +   Zw+    :wÿ wÿ."`  Z  XBp  ,<  ,<wþ$  3B   +   Zp  XBw+   B R    (K . 1)
(VARIABLE-VALUE-CELL MIN.FLOAT . 8)
1
10
ERRORX
GREATERP
(URET3 LIST2 SKNNM KNIL ASZ CF CFARP ENTERN) p   (      8           0   @        

MIN BINARY
             -.         .   .   Z8  0B   +   Z   ,~   Z` ,<  ,<  ,<   Zw-,   +   ,<  ,<  ,   B  Zwÿ.   .   Z8  2B  +   Zw+    :wÿ,<w w."`  Z  XBwÿD  3B   +   Zp  XBw+   B$    (K . 1)
(VARIABLE-VALUE-CELL MAX.FLOAT . 8)
1
10
ERRORX
GREATERP
(URET3 LIST2 SKNNM KNIL ASZ CF CFARP ENTERN) p   (      0           0   @        

POWEROFTWOP BINARY
       «    (    *-.           (Z  ¨6@   Z  )2B  ©+   Z` "   +   -,   +    ` 1b   +    ` A"ÿ0B   +    ` (Bx,   ,<   p  ,>  §,>   p  /"  ABx  ,^  /  0B   7   Z   /  ,~    ` (Bx0B   +    ` A"ÿ,   ,<   p  ,>  §,>   p  /"  ABx  ,^  /  0B   7   Z   /  ,~   Z   ,~   Z   ,~    ` 1b   7   7   +   ' ` ,>  §,>   ` /"  ABx  ,^  /  0B   7   Z   ,~     J"        (X . 1)
TENEX
TOPS20
D
(KT KNIL BHC MKN SKI SMALLT KL20FLG ENTER1) x ¡ H     '   `     `  0     h                    

IMOD BINARY
            -.            ` ,>  ,>   `    ,^  /  &     ,   XB` ,   1"   +   Z` ,~    ` ,>  ,>   ` .Bx  ,^  /  ,   ,~        (X . 1)
(N . 1)
(IUNBOX MKN BHC ENTER2)         p   X        

EVENP BINARY
            	    
-.          	Z` ,<  .   .   Z8  0B  +   Z` +   Z"  D  0B   7   Z   ,~      (X . 1)
IMOD
(KT KNIL ASZ CF CFARP ENTERN)            P    @    8      

ODDP BINARY
               -.          Z` ,<  .   .   Z8  0B  +   Z` +   Z"  D  
1B   +   7   Z   ,~      (X . 1)
IMOD
(KNIL KT ASZ CF CFARP ENTERN)            P    @    8      

NLAMBDA.ARGS BINARY
            -.           Z` -,   +   Z` 2B  +   [` ,~   Z` -,   +   Z` Z  2B  +   Z` [  Z  ,<  [` B  ,   ,~   Z` ,~   3B   +   ,   ,~   a (X . 1)
QUOTE
NLAMBDA.ARGS
(CONSNL KNIL CONSS1 SKLST ENTER1)       p   P    p        
(PRETTYCOMPRINT MACHINEINDEPENDENTCOMS)
(RPAQQ MACHINEINDEPENDENTCOMS ((COMS (* * random machine-independent utilities) (FNS LOAD? FILESLOAD DOFILESLOAD) (FNS DMPHASH 
HARRAYPROP.DUMMY HASHARRAY.DUMMY HASHARRAYP.DUMMY HASHOVERFLOW) (P (MOVD? (QUOTE HARRAYPROP.DUMMY) (QUOTE HARRAYPROP)) (MOVD? (QUOTE
 HASHARRAY.DUMMY) (QUOTE HASHARRAY)) (MOVD? (QUOTE HASHARRAYP.DUMMY) (QUOTE HASHARRAYP))) (FNS BKBUFS CONCATLIST CHANGENAME CHNGNM 
CLBUFS CLOSEF? DEFINE EQMEMB EQUALN FILEDATE FILEMAP FNCHECK FNTYP1 FREEVARS LISPSOURCEFILEP \LISPSOURCEFILEP1 GETFILEMAP LCSKIP 
MAPRINT MKLIST NAMEFIELD NLIST PRINTBELLS PROMPTCHAR PUTFILEMAP RAISEP READFILE READLINE REMPROPLIST RESETBUFS TAB UNSAVED1 
UNSAVEDEF UPDATEFILEMAP USEDFREE WRITEFILE XNLSETQ PROG2) (PROP ARGNAMES PROG2) (P (MOVD? (QUOTE COPYBYTES) (QUOTE COPYCHARS))) (FNS
 RESETFORM RESETLST RESETTOPVALS RESETTOPVALS1) (PROP INFO RESETTOPVALS) (BLOCKS (EQUALN EQUALN) (SUBPAIR SUBPAIR) (NIL PROMPTCHAR 
NAMEFIELD CLOSEF? CLBUFS BKBUFS (NOLINKFNS PRINTBELLS) (LINKFNS . T) (LOCALVARS . T)))) (COMS (* * LVLPRINT) (FNS LVLPRINT LVLPRIN1 
LVLPRIN2 LVLPRIN LVLPRIN0) (BLOCKS (LVLPRINTBLOCK LVLPRINT LVLPRIN1 LVLPRIN2 LVLPRIN LVLPRIN0 (ENTRIES LVLPRINT LVLPRIN1 LVLPRIN2) (
LOCALFREEVARS FILE PRIN2FLG)))) (COMS (* * SUBLIS and friends) (FNS SUBLIS SUBPAIR SUBLIS0 DSUBLIS SUBLIS1 DSUBLIS0) (BLOCKS (
SUBBLOCK DSUBLIS SUBLIS1 SUBLIS SUBLIS0 (LOCALFREEVARS ALST FLG) (ENTRIES SUBLIS DSUBLIS) DSUBLIS0)) (DECLARE: DONTEVAL@LOAD DOCOPY 
(* initialization of variables used in many places) (ADDVARS (CLISPARRAY) (CLISPFLG) (CTRLUFLG) (EDITCALLS) (EDITHISTORY) (
EDITUNDOSAVES) (EDITUNDOSTATS) (GLOBALVARS) (LCASEFLG) (LISPXBUFS) (LISPXCOMS) (LISPXFNS) (LISPXHIST) (LISPXHISTORY) (LISPXPRINTFLG)
 (NOCLEARSTKLST) (NOFIXFNSLST) (NOFIXVARSLST) (P.A.STATS) (PROMPTCHARFORMS) (READBUF) (READBUFSOURCE) (REREADFLG) (RESETSTATE) (
SPELLINGS1) (SPELLINGS2) (SPELLINGS3) (SPELLSTATS1) (USERWORDS)) (VARS (CHCONLST (QUOTE (NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
 NIL NIL NIL NIL NIL NIL NIL NIL NIL))) (CHCONLST1 (QUOTE (NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL 
NIL NIL))) (CHCONLST2 (QUOTE (NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL))) (CLEARSTKLST T) (
CLISPTRANFLG (QUOTE CLISP% )) (HISTSTR0 "<c.r.>") (HISTSTR2 "repeat") (HISTSTR3 "from event:") (HISTSTR4 "ignore") (LISPXREADFN (
QUOTE READ)) (USEMAPFLG T)))) (COMS (* * CHARCODE) (FNS CHARCODE SELCHARQ) (PROP MACRO CHARCODE SELCHARQ ALPHACHARP DIGITCHARP 
UCASECODE) (ALISTS (DWIMEQUIVLST SELCHARQ) (PRETTYEQUIVLST SELCHARQ))) (COMS (* * CONSTANTS) (FNS CONSTANTOK) (P (MOVD? (QUOTE EVQ) 
(QUOTE CONSTANT)) (MOVD? (QUOTE EVQ) (QUOTE DEFERREDCONSTANT)) (MOVD? (QUOTE EVQ) (QUOTE LOADTIMECONSTANT)))) (COMS (* * SCRATCHLIST
) (FNS ADDTOSCRATCHLIST SCRATCHLIST) (PROP MACRO SCRATCHLIST ADDTOSCRATCHLIST) (PROP INFO SCRATCHLIST)) (COMS (* * COMPARE) (FNS 
COMPARELST COMPARE1 COMPAREPRINT COMPAREPRINT1 COMPARELISTS COMPAREPRINTN COMPAREFAIL COMPAREMAX COUNTDOWN) (ADDVARS (
COMPARETRANSFORMS)) (DECLARE: EVAL@COMPILE DONTCOPY (PROP BLKLIBRARYDEF COUNTDOWN) (ADDVARS (BLKLIBARY COUNTDOWN))) (BLOCKS (
COMPARELISTSBLOCK COMPARELISTS COMPARELST COMPARE1 COMPAREPRINT COMPAREPRINT1 COMPAREMAX (ENTRIES COMPARELISTS COMPARELST) (
GLOBALVARS COMPARETRANSFORMS) (LOCALFREEVARS DIFFERENCES LOOSEMATCH) (NOLINKFNS . T) COMPAREPRINTN COMPAREFAIL (GLOBALVARS 
COMMENTFLG **COMMENT**FLG)) (COUNTDOWN COUNTDOWN))) (COMS (* * MIN and MAX) (FNS FLESSP FMAX FMIN GEQ IGEQ ILEQ IMAX IMIN LEQ MAX 
MIN) (GLOBALVARS MAX.INTEGER MIN.INTEGER MAX.FLOAT MIN.FLOAT)) (COMS (FNS POWEROFTWOP IMOD EVENP ODDP) (DECLARE: DONTCOPY (MACROS 
.2^NP.))) (GLOBALVARS SYSFILES LOADOPTIONS UPDATEMAPFLG LISPXCOMS CLISPTRANFLG COMMENTFLG **COMMENT**FLG HISTSTR4 LISPXREADFN 
REREADFLG HISTSTR0 FILEPKGFLG CTRLUFLG NOLINKMESS PROMPTCHARFORMS PROMPT#FLG USEMAPFLG FILERDTBL BUILDMAPFLG DFNFLG SPELLINGS2 
DWIMFLG USERWORDS ADDSPELLFLG BELLS LISPXPRINTFLG CLISPARRAY) (FNS NLAMBDA.ARGS) (P (COND (SHALLOWFLG (MOVD (QUOTE EVALV) (QUOTE 
GETATOMVAL)) (MOVD (QUOTE SET) (QUOTE SETATOMVAL)) (MOVD (QUOTE PROG) (QUOTE RESETVARS))) (T (MOVD (QUOTE GETTOPVAL) (QUOTE 
GETATOMVAL)) (MOVD (QUOTE SETTOPVAL) (QUOTE SETATOMVAL)))) (MAPC (QUOTE ((APPLY BLKAPPLY) (APPLY* BLKAPPLY*) (RPLACA FRPLACA) (
RPLACD FRPLACD) (STKNTH FSTKNTH) (STKNAME FSTKNAME) (CHARACTER FCHARACTER) (STKARG FSTKARG) (CHCON DCHCON) (UNPACK DUNPACK) (ADDPROP
 /ADDPROP) (ATTACH /ATTACH) (DREMOVE /DREMOVE) (DSUBST /DSUBST) (NCONC /NCONC) (NCONC1 /NCONC1) (PUT /PUT) (PUTPROP /PUTPROP) (PUTD 
/PUTD) (REMPROP /REMPROP) (RPLACA /RPLACA) (RPLACD /RPLACD) (SET /SET) (SETATOMVAL /SETATOMVAL) (SETTOPVAL /SETTOPVAL) (SETPROPLIST 
/SETPROPLIST) (SET SAVESET) (PRINT LISPXPRINT) (PRIN1 LISPXPRIN1) (PRIN2 LISPXPRIN2) (SPACES LISPXSPACES) (TAB LISPXTAB) (TERPRI 
LISPXTERPRI) (PRINT SHOWPRINT) (PRIN2 SHOWPRIN2) (PUTHASH /PUTHASH) (QUOTE *) (FNCLOSER /FNCLOSER) (FNCLOSERA /FNCLOSERA) (FNCLOSERD
 /FNCLOSERD) (EVQ DELFILE) (NILL SMASHFILECOMS) (PUTASSOC /PUTASSOC) (LISTPUT1 PUTL) (NILL I.S.OPR) (NILL RESETUNDO) (NILL 
LISPXWATCH) (QUOTE ADDSTATS))) (FUNCTION (LAMBDA (X) (MOVD? (CAR X) (CADR X))))) (MAPC (QUOTE ((TIME PRIN1 LISPXPRIN1) (TIME SPACES 
LISPXSPACES) (TIME PRINT LISPXPRINT) (DEFC PRINT LISPXPRINT) (DEFC PUTD /PUTD) (DEFC PUTPROP /PUTPROP) (DOLINK FNCLOSERD /FNCLOSERD)
 (DOLINK FNCLOSERA /FNCLOSERA) (DEFLIST PUTPROP /PUTPROP) (SAVEDEF1 PUTPROP /PUTPROP) (MKSWAPBLOCK PUTD /PUTD))) (FUNCTION (LAMBDA (
X) (AND (CCODEP (CAR X)) (APPLY (QUOTE CHANGENAME) X))))) (MAPC (QUOTE ((EVALQT (LAMBDA NIL (PROG (TEM) (RESETRESTORE NIL (QUOTE 
RESET)) LP (PROMPTCHAR (QUOTE _) T) (LISPX (LISPXREAD T T)) (GO LP)))) (LISPX (LAMBDA (LISPXX) (PRINT (AND LISPXX (PROG (LISPXLINE 
LISPXHIST TEM) (RETURN (COND ((AND (NLISTP LISPXX) (SETQ LISPXLINE (READLINE T NIL T))) (APPLY LISPXX (CAR LISPXLINE))) (T (EVAL 
LISPXX)))))) T T))) (LISPXREAD (LAMBDA (FILE RDTBL) (COND (READBUF (PROG1 (CAR READBUF) (SETQ READBUF (CDR READBUF)))) (T (READ FILE
 RDTBL))))) (LISPXREADP (LAMBDA (FLG) (COND ((AND READBUF (SETQ READBUF (LISPXREADBUF READBUF))) T) (T (READP T FLG))))) (
LISPXUNREAD (LAMBDA (LST) (SETQ READBUF (APPEND LST (CONS HISTSTR0 READBUF))))) (LISPXREADBUF (LAMBDA (RDBUF) (PROG NIL LP (COND ((
NLISTP RDBUF) (RETURN NIL)) ((EQ (CAR RDBUF) HISTSTR0) (SETQ RDBUF (CDR RDBUF)) (GO LP)) (T (RETURN RDBUF)))))) (LISPX/ (LAMBDA (X) 
X)) (LOWERCASE (LAMBDA (FLG) (PROG1 LCASEFLG (RAISE (NULL FLG)) (RPAQ LCASEFLG FLG)))) (FILEPOS (LAMBDA (STR FILE) (PROG NIL LP (
COND ((EQ (PEEKC FILE) (NTHCHAR STR 1)) (RETURN T))) (READC FILE) (GO LP)))) (FILEPKGCOM (NLAMBDA NIL NIL)))) (FUNCTION (LAMBDA (L) 
(OR (GETD (CAR L)) (PUTD (CAR L) (CADR L))))))) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA 
SCRATCHLIST SELCHARQ RESETTOPVALS RESETLST RESETFORM USEDFREE RESETBUFS DMPHASH FILESLOAD) (NLAML CHARCODE XNLSETQ FILEMAP) (LAMA 
ODDP EVENP MIN MAX IMIN IMAX FMIN FMAX PROG2 NLIST HARRAYPROP.DUMMY))) (LOCALVARS . T)))
(MOVD? (QUOTE HARRAYPROP.DUMMY) (QUOTE HARRAYPROP))
(MOVD? (QUOTE HASHARRAY.DUMMY) (QUOTE HASHARRAY))
(MOVD? (QUOTE HASHARRAYP.DUMMY) (QUOTE HASHARRAYP))
(PUTPROPS PROG2 ARGNAMES (NIL (FIRST SECOND ...) . U))
(MOVD? (QUOTE COPYBYTES) (QUOTE COPYCHARS))
(PUTPROPS RESETTOPVALS INFO (EVAL BINDS))
(ADDTOVAR CLISPARRAY)
(ADDTOVAR CLISPFLG)
(ADDTOVAR CTRLUFLG)
(ADDTOVAR EDITCALLS)
(ADDTOVAR EDITHISTORY)
(ADDTOVAR EDITUNDOSAVES)
(ADDTOVAR EDITUNDOSTATS)
(ADDTOVAR GLOBALVARS)
(ADDTOVAR LCASEFLG)
(ADDTOVAR LISPXBUFS)
(ADDTOVAR LISPXCOMS)
(ADDTOVAR LISPXFNS)
(ADDTOVAR LISPXHIST)
(ADDTOVAR LISPXHISTORY)
(ADDTOVAR LISPXPRINTFLG)
(ADDTOVAR NOCLEARSTKLST)
(ADDTOVAR NOFIXFNSLST)
(ADDTOVAR NOFIXVARSLST)
(ADDTOVAR P.A.STATS)
(ADDTOVAR PROMPTCHARFORMS)
(ADDTOVAR READBUF)
(ADDTOVAR READBUFSOURCE)
(ADDTOVAR REREADFLG)
(ADDTOVAR RESETSTATE)
(ADDTOVAR SPELLINGS1)
(ADDTOVAR SPELLINGS2)
(ADDTOVAR SPELLINGS3)
(ADDTOVAR SPELLSTATS1)
(ADDTOVAR USERWORDS)
(RPAQQ CHCONLST (NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL))
(RPAQQ CHCONLST1 (NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL))
(RPAQQ CHCONLST2 (NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL))
(RPAQQ CLEARSTKLST T)
(RPAQQ CLISPTRANFLG CLISP% )
(RPAQ HISTSTR0 "<c.r.>")
(RPAQ HISTSTR2 "repeat")
(RPAQ HISTSTR3 "from event:")
(RPAQ HISTSTR4 "ignore")
(RPAQQ LISPXREADFN READ)
(RPAQQ USEMAPFLG T)
(PUTPROPS CHARCODE MACRO (C (KWOTE (APPLY* (QUOTE CHARCODE) (CAR C) T))))
(PUTPROPS SELCHARQ MACRO (F (CONS (QUOTE SELECTQ) (CONS (CAR F) (MAPLIST (CDR F) (FUNCTION (LAMBDA (I) (COND ((CDR I) (CONS (APPLY* 
(FUNCTION CHARCODE) (CAAR I)) (CDAR I))) (T (CAR I))))))))))
(PUTPROPS ALPHACHARP MACRO ((CHAR) ((LAMBDA (UCHAR) (DECLARE (LOCALVARS UCHAR)) (AND (IGEQ UCHAR (CHARCODE A)) (ILEQ UCHAR (CHARCODE
 Z)))) (LOGAND CHAR 95))))
(PUTPROPS DIGITCHARP MACRO (LAMBDA (CHAR) (AND (IGEQ CHAR (CHARCODE 0)) (ILEQ CHAR (CHARCODE 9)))))
(PUTPROPS UCASECODE MACRO (OPENLAMBDA (CHAR) (COND ((AND (IGEQ CHAR (CHARCODE a)) (ILEQ CHAR (CHARCODE z))) (LOGAND CHAR 95)) (T 
CHAR))))
(ADDTOVAR DWIMEQUIVLST (SELCHARQ . SELECTQ))
(ADDTOVAR PRETTYEQUIVLST (SELCHARQ . SELECTQ))
(MOVD? (QUOTE EVQ) (QUOTE CONSTANT))
(MOVD? (QUOTE EVQ) (QUOTE DEFERREDCONSTANT))
(MOVD? (QUOTE EVQ) (QUOTE LOADTIMECONSTANT))
(PUTPROPS SCRATCHLIST MACRO ((SCRATCHLIST . FORMS) ((LAMBDA (!SCRATCHLIST !SCRATCHTAIL) (DECLARE (SPECVARS !SCRATCHLIST !SCRATCHTAIL
)) (SETQ !SCRATCHTAIL !SCRATCHLIST) (PROGN . FORMS) (COND ((EQ !SCRATCHTAIL !SCRATCHLIST) NIL) (T (PROG ((L2 (CDR !SCRATCHLIST))) (
RPLACD !SCRATCHLIST (PROG1 (CDR !SCRATCHTAIL) (RPLACD !SCRATCHTAIL NIL))) (FRPLACD (FLAST !SCRATCHLIST) L2) (RETURN L2))))) (OR (
LISTP SCRATCHLIST) (CONS)) NIL)))
(PUTPROPS ADDTOSCRATCHLIST MACRO ((VALUE) (FRPLACA (SETQ !SCRATCHTAIL (OR (LISTP (CDR !SCRATCHTAIL)) (CDR (FRPLACD !SCRATCHTAIL (
CONS))))) VALUE)))
(PUTPROPS SCRATCHLIST INFO EVAL)
(ADDTOVAR COMPARETRANSFORMS)
(COND (SHALLOWFLG (MOVD (QUOTE EVALV) (QUOTE GETATOMVAL)) (MOVD (QUOTE SET) (QUOTE SETATOMVAL)) (MOVD (QUOTE PROG) (QUOTE RESETVARS)
)) (T (MOVD (QUOTE GETTOPVAL) (QUOTE GETATOMVAL)) (MOVD (QUOTE SETTOPVAL) (QUOTE SETATOMVAL))))
(MAPC (QUOTE ((APPLY BLKAPPLY) (APPLY* BLKAPPLY*) (RPLACA FRPLACA) (RPLACD FRPLACD) (STKNTH FSTKNTH) (STKNAME FSTKNAME) (CHARACTER 
FCHARACTER) (STKARG FSTKARG) (CHCON DCHCON) (UNPACK DUNPACK) (ADDPROP /ADDPROP) (ATTACH /ATTACH) (DREMOVE /DREMOVE) (DSUBST /DSUBST)
 (NCONC /NCONC) (NCONC1 /NCONC1) (PUT /PUT) (PUTPROP /PUTPROP) (PUTD /PUTD) (REMPROP /REMPROP) (RPLACA /RPLACA) (RPLACD /RPLACD) (
SET /SET) (SETATOMVAL /SETATOMVAL) (SETTOPVAL /SETTOPVAL) (SETPROPLIST /SETPROPLIST) (SET SAVESET) (PRINT LISPXPRINT) (PRIN1 
LISPXPRIN1) (PRIN2 LISPXPRIN2) (SPACES LISPXSPACES) (TAB LISPXTAB) (TERPRI LISPXTERPRI) (PRINT SHOWPRINT) (PRIN2 SHOWPRIN2) (PUTHASH
 /PUTHASH) (QUOTE *) (FNCLOSER /FNCLOSER) (FNCLOSERA /FNCLOSERA) (FNCLOSERD /FNCLOSERD) (EVQ DELFILE) (NILL SMASHFILECOMS) (PUTASSOC
 /PUTASSOC) (LISTPUT1 PUTL) (NILL I.S.OPR) (NILL RESETUNDO) (NILL LISPXWATCH) (QUOTE ADDSTATS))) (FUNCTION (LAMBDA (X) (MOVD? (CAR X
) (CADR X)))))
(MAPC (QUOTE ((TIME PRIN1 LISPXPRIN1) (TIME SPACES LISPXSPACES) (TIME PRINT LISPXPRINT) (DEFC PRINT LISPXPRINT) (DEFC PUTD /PUTD) (
DEFC PUTPROP /PUTPROP) (DOLINK FNCLOSERD /FNCLOSERD) (DOLINK FNCLOSERA /FNCLOSERA) (DEFLIST PUTPROP /PUTPROP) (SAVEDEF1 PUTPROP 
/PUTPROP) (MKSWAPBLOCK PUTD /PUTD))) (FUNCTION (LAMBDA (X) (AND (CCODEP (CAR X)) (APPLY (QUOTE CHANGENAME) X)))))
(MAPC (QUOTE ((EVALQT (LAMBDA NIL (PROG (TEM) (RESETRESTORE NIL (QUOTE RESET)) LP (PROMPTCHAR (QUOTE _) T) (LISPX (LISPXREAD T T)) (
GO LP)))) (LISPX (LAMBDA (LISPXX) (PRINT (AND LISPXX (PROG (LISPXLINE LISPXHIST TEM) (RETURN (COND ((AND (NLISTP LISPXX) (SETQ 
LISPXLINE (READLINE T NIL T))) (APPLY LISPXX (CAR LISPXLINE))) (T (EVAL LISPXX)))))) T T))) (LISPXREAD (LAMBDA (FILE RDTBL) (COND (
READBUF (PROG1 (CAR READBUF) (SETQ READBUF (CDR READBUF)))) (T (READ FILE RDTBL))))) (LISPXREADP (LAMBDA (FLG) (COND ((AND READBUF (
SETQ READBUF (LISPXREADBUF READBUF))) T) (T (READP T FLG))))) (LISPXUNREAD (LAMBDA (LST) (SETQ READBUF (APPEND LST (CONS HISTSTR0 
READBUF))))) (LISPXREADBUF (LAMBDA (RDBUF) (PROG NIL LP (COND ((NLISTP RDBUF) (RETURN NIL)) ((EQ (CAR RDBUF) HISTSTR0) (SETQ RDBUF (
CDR RDBUF)) (GO LP)) (T (RETURN RDBUF)))))) (LISPX/ (LAMBDA (X) X)) (LOWERCASE (LAMBDA (FLG) (PROG1 LCASEFLG (RAISE (NULL FLG)) (
RPAQ LCASEFLG FLG)))) (FILEPOS (LAMBDA (STR FILE) (PROG NIL LP (COND ((EQ (PEEKC FILE) (NTHCHAR STR 1)) (RETURN T))) (READC FILE) (
GO LP)))) (FILEPKGCOM (NLAMBDA NIL NIL)))) (FUNCTION (LAMBDA (L) (OR (GETD (CAR L)) (PUTD (CAR L) (CADR L))))))
(PUTPROPS MACHINEINDEPENDENT COPYRIGHT ("Xerox Corporation" T 1983 1984))
NIL
   