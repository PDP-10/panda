(FILECREATED "31-Dec-84 03:21:24" ("compiled on " <NEWLISP>ASSIST..168) (2 . 2) brecompiled changes: NORMALCOMMENTS in 
"INTERLISP-10  14-Sep-84 ..." dated "14-Sep-84 00:05:07")
(FILECREATED "12-Oct-84 09:26:25" {ERIS}<LISP>HARMONY>SOURCES>ASSIST.;2 80356 changes to: (FNS NORMALCOMMENTS) previous date: 
"23-Aug-84 10:56:45" {ERIS}<LISP>HARMONY>SOURCES>ASSIST.;1)
PRINTPROPS BINARY
      �    �    �-.           �-.      0    1,<  1"  �,<  �@  2  �+   /,<  �Z   ,<  �,   ,   Z   ,   XB  �XB` ,<  4,<  �,<   @  5 ` +   &Z   Z  �XB Zw�,<8  "  72B   +   �Zw�,<8  ,<   Z   F  �2B   +   Zw�Z8  B  7,<  �Zp  -,   +   �Z   +   �,<  �Zp  ,<  �,<   ,<   &  8,<  �,<   $  9[p  Z  ,<  �,<   ,<   &  �/  �[p  [  XBp  +   /  �ZwXB8 �Z   ,~   2B   +   (Z  :XB   [` XB  �,<  �Z` Z  [  D  �Z  �3B   +   .   ;,~   Z` �,~   +    V jE
"AP!L       (AT . 1)
(VARIABLE-VALUE-CELL RESETVARSLST . 81)
(VARIABLE-VALUE-CELL USERWORDS . 38)
((2 . 3) . 0)
PRINTLEVEL
(VARIABLE-VALUE-CELL OLDVALUE . 13)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 87)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
GETPROPLIST
MISSPELLED?
PRIN2
" : "
PRIN1
SHOWPRINT
ERROR
APPLY
ERROR!
(URET1 BHC KT SKNLST CF KNIL CONS CONSNL LIST2 BLKENT ENTER1)      H "    &  � ` � @      h   P '   8 � H              (      
PRINTBINDINGS BINARY
     w    �    �-.           �-.      `    �,<  �,<  a$  �,<  �@  b  �+   ^,<  �Z   ,<  �,   ,   Z   ,   XB  	XB` ,<  d,<  �,<   @  e ` +   UZ   Z  �XB ,<   ,<   ,<   Zw~Z8  2B   +   �Z   Zw~XB8  ,<  gD  �Zw~,<?,<8  $  �,<  hZw�,<8  $  �Zw~,<8  "  �,<  iZw�Z?�2B   +   Z  �D  jZw~XB?�Zw~,<?,<?�,<?�&  �Zw~XB?�2B   +   �+   I,<?D  kXBw�,<  �Zw�,<8  $  �Zw~,<?�"  l,<  �Zw�,<8  ,<   &  �Zw~,<?�"  m2B   +   �,<  �Zw�,<8  $  �,<  nZw�,<?�,<w&  jXBp  ,<p  "  m3B   +   �,<p  "  l,<  �Zw�,<8  ,<   &  �+   �,<  n,<w�,<w&  jXBp  3B   +   �+   �,<  �Zw�,<8  $  �,<  oZw�,<8  $  �,<w�Zw�,<8  ,<   &  �,<  nZw�,<?�,<?�&  jZw~XB?�3B   +   I+   �,<p  "  p,<  �Zw�,<8  $  �,<  qZw�,<8  $  �Zw~,<?"  �,<  �Zw�,<8  ,<   &  �Z   /  �ZwXB8 �Z   ,~   2B   +   WZ  rXB   [` XB  
,<  �Z` Z  [  D  �Z  �3B   +   ]   s,~   Z` �,~   +    k 5 #L8�TH%L%CIf!DldBDL         (AT . 1)
(POS . 1)
(FL . 1)
(VARIABLE-VALUE-CELL RESETVARSLST . 175)
2
3
PRINTLEVEL
(VARIABLE-VALUE-CELL OLDVALUE . 14)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 181)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
"bindings for "
PRIN1
": "
TERPRI
0
PRINTBINDINGS
STKNTH
STKSCAN
STKARG
" @ "
STKNAME
PRIN2
REALFRAMEP
"/"
1
"? "
" : "
SHOWPRINT
RELSTK
" @ "
"TOP : "
GETTOPVAL
ERROR
APPLY
ERROR!
(URET3 BHC KT CF KNIL CONS CONSNL LIST2 BLKENT ENTER3)  p   
8   
P R @ 9 @         \ 
` S 	 = X � @ � 0 �  � P   (          (      
ASKUSERBLOCK BINARY
     '   �   
-.          �-.     x2p�    �   P  @  ,  �,~   -.    �Z   ,<  �@ =  ,~   Z   ,<  �,< �,< ?,<   @ � ` �+  �Z   Z AXB Z   2B   +   Z   XB  �,<  �Zw�,<8 �,<8 @ � `x$+  �Z   2B   +   �Z   XB  �+   3B   +   +   �  �XB   ,< �Z   b L,   ,   Z  	,   XB  �ZwZ8 �3B   +   �,<    MZwXB8 �+   �  N  O,<   ,<   Z   f PXB` �ZwZ8 �-,   +   1Z8 �,<  �,<   , �Zw[8 �ZwXB8 �3B   +   /,< Q,<   , �+   5,< �,<   , �+   53B   +   5,<  �,<   , �Z   ZwXB8 �  R,<    M3B   +   �  S  R,<    �ZwZ8 �2B   +   <+   C-,   +   ?,<  �,<   , �+   C,<  �,<   ,<   ,< �,<   ,<   Z   n UZwZ8 �-,   +   QZ8 2B   +   G+   Q3B   +   �-,   +   �,   ZwXB8  8 �$" t,   b V2B   +   Q,< W,<    �ZwZ8 XB` �+   _Z  �-,   +   [,<  �,<    M2B   +   [Z   XB  Q  �XB  �,< �Z  �b L,   ,   Z  �,   XB  �Z  �b �XB` �Z   XB   Z   ZwXB8 Z  �,<  �,<   ,<   ,<   ,<   Zw~-,   +   d+   Z  XBp  ,<  �, �,<` �Z   ,<  �,<`  �XB` ,<  �, +3B   +   �+  �Z` 2B   +  �Zw�2B   +  �Z` �2B �+   �+  �,< [, �2B   +  ,< �, �3B   +  ,<p  ,<` �, �3B   +  Z   ,<  �,< \, �2B   +   �Z  �,   d �XB  wZ   2B   +  �Z   ,<  ,< \, �2B   +  Z  z,   d �XB  �Z   3B   +  Z ,<  ,<  �,<    �,   d �XB ,< �, �XB  _Z"  �XB` +  �Z   -,   +  �,<` �,<  �,  3B   +  �+  Z` �3B �+  2B ^+  �Z  |2B   +  �Z �,<  Z` �,   d �XB �Zp  XBw�Zw3B   +  �,<  �Zw,   XBw�,\  QB  +  �Zw�,   XBwXBw�[w~XBw~+   bZw�/  �+  �/  �+   _XB` �3B   +  %XB 	+  �Z  �2B   +  1Z` 0B  �+  1ZwZ8 2B   +  1Z` �3B ^+  �2B �+  1Z 2B   +  �,<` �,<    �Z  [b �+   QZ` �3B �+  �Z -,   +  7,<` �,<  �,  3B   +  �+  �Z` �3B �+  �2B ^+  �Z $,<  �,<` �,<` , dXB` 2B   +  >+  � ` ."  �,   XB` ZwZ8 2B   +  CZ �b �[ �2B   +  E+  DZ` �3B �+  �2B ^+  r,< `,<    �+  r,<` � �XB` ,   A"  �,<  �,<    �."  Z  ,\  3B  +  � ` A"  �,<  �,<    �."  �Z  ,\  2B  +  �+  �ZwZ8 2B   +  �Z B2B   +  �,<` �,< �, �   �,\  �7  �[  Z  Z  1H  +  �2D   +  \XB` 3B   +  �,<    �Z  �b L[` b bZ  �b L+   QZwZ8 2B   +  Z` �2B �+  Z �2B   +  ,<    c,<    �,< d,<   ,<   @ � ` �+  �Z   Z AXB Z   ,<  �,< �, �2B   +  �Z e,<  �,<    �Z C,<  �Z ,<  Z q,<  ,< �, �2B   +  �Z f,<  �, PZ   ,~   ,<    cZ   3B   +  -,   +  ,<  �,<   , �+  ,<  �,<   ,<   ,< �,<   ,<   Z  Bn UZ w,<  �Zp  -,   +  
+  �Zp  ,<  �,<p  ,<    �/  �[p  XBp  +  /  �Z` 1B  �+   QZ v-,   +  Z �+  Z [  [  ,<  �,< \, �2B   +  Z Z  ,<  �,< F ` /"  �,   f g,<  �,<    �+   QZ ,<  �,<   ,<   Zw-,   +  !+  �Z  XBp  3B h+  %3B �+  %2B �+  &XB �+  7-,   +  :Zp  2B h+  0,<p  ,< i �XB` 3B   +  �,<  �,<` � "  �,   3B   +  :Zp  XB %+  73B �+  22B �+  �Zp  XB /+  7Zp  -,   +  :Zp  XB �3B   +  :Zp  2B   +  9Z   XBw�+  �[wXBw+  Zw�/  �XB` �3B   +  �Z �2B h+  E,<` �Z` �-,   +  �[` �+  CZ   ,   ,   XB +  �Z i2B   +  H,<` �,<    �Z bb L,< �,<   ,<   @ � ` �+  �Z   Z AXB Z >2B �+  �Z E,<  ,<    kZw|XB8 +  Z2B �+  �@ l  +  X,<    �Zw|XB8 Z   ,~   +  Zb bZw|XB8 +    ,<  �Z db L,\  �2B   +  ^+  �Z` �-,   Z   ,<  �,<` [w�Z  [w�[  ,   ,   /  �,   XB D,<`  �,   ."  �,   XB` Z   XB  ]Z Ob �XB` �b �XB` ,   A"  �,> 1,>  �,<    �.Bx  ,^  �/  �."  [  A"   1B   +  �Z �[  ,<  �Z` �,   ,<  �Z �[  [  ,   Z [,   d �+  � ` A"  �,> 1,>  �,<    �.Bx  ,^  �/  �."  [  A"  @1B   +  +   QZ ib �XB` �Z �ZwXB8 +   _Z 3B   +  �  rZwZ8 2B   +  �Z �b �ZwZ8 �3B   +  +  �  S  R,<    �+   QZwZ8 2B   +  �Z �b �Z �,<  �, �[ �2B   +   ` ,> 1,>  �Z �b �,      �,^  �/  �2"  +  �Z �2B   +  %Z �2B   +  %,< \, �XB` 3B   +  �,<  �,<`  �+  "Z` �XB` 3B   +  %,<  �,<    � ` ."  �,   XB` ,< s, �3B   +  rZ ,<  �,<` �,<` , dXB` 3B   +  r[ )2B   +  3Z` XB` ,<  �Z b �,\  2B  +  3+  D ` ."  �,   XB` +  rZ 2B   +  DZ �2B   +  DZ` ,<  �Z 0b �,\  2B  +  D,< \, �XB` 3B   +  �,<  �,<`  �+  AZ` �XB` 3B   +  D,<  �,<    �Z %,<  �,< \, �2B   +  �Z �,   d �XB DZ �2B   +  �Z ,<  ,< \, �2B   +  NZ G,   d �XB �Z �3B   +  �,< �, �XB` 3B   +  V,<` �,<  �,  3B   +  �Z O,<  �Z �,<  ,<    �,   d �XB VZ I2B   +  �Z 72B   +  � ` ,> 1,>  �Z �b �,      �,^  �/  �3b  +  �Z` �2B �+  �,< �, �2B   +  �Z` �+  hZ ^,<  �,<    �Z �3B   +  F-,   +  o,<` �,<  �,  3B   +  w+  FZ` �3B �+  F2B ^+  w+  FZw[8 ZwXB8 2B   +  �+   QZ8 XB` �+   _,< t, �3B   +  �,< �,<    �Z \-,   +  �,<  �,<    M2B   +  �Z   XB �  �XB H,< �Z [b L,   ,   Z  �,   XB Zw[8 ZwXB8 3B   +  �Z8 +  �Z b �XB` �b �XB` ,   A"  �,<  �,<    �."  Z  ,\  3B  +  � ` A"  �,<  �,<    �."  �Z  ,\  2B  +  �+  �Z �-,   +  (,<` �,<  �,  3B   +  �Z W3B   +  �,< �, �XB` 3B   +  �,<` �,<  �,  3B   +  �Z Z,<  �Z �,<  ,<    �,   d �XB  Z �2B   +  F,< ^,<    �+  FZ` �3B ^+  �2B �+  4Z �2B   +  FZ $,<  ,< �, �2B   +  0Z` �+  �Z ^,<  �,<    �,   d �XB ,+  F,<` �,< �, �   �,\  �7  �[  Z  Z  1H  +  �2D   +  7XB` 3B   +  �Z  b L[` b bZ b L+  wZ` �3B �+  D,< u,<    �  R,<    �,< �,<    �+  w,< �, �XB` 3B   +  �XB -Z"  �XB` +  rZ 3B   +  TZ 3,<  Zp  -,   +  O+  �Zp  ,<  �,<p  ,<   , �/  �[p  XBp  +  M/  �Z` �3B   +  Vb vZ wZ   ,   2B   +  ZZ wZ x,   XB` 3B   +  �Z <b L,< �,<   ,<   @ � ` �+  �Z   Z AXB Zw|[8 Z  b b+    XB` 3B   +  fZ` ,~   Z >b L+  �Z �3B   +  jb x,~     yZ _,~   ZwZ8 �3B   +  n+  �,< z,<    �  R,<    �Z` �XB �Z   XB LZ"  �XB` Z   XB �+   Q  N  O,<   ,<   Z  �f PXB` �,< �Z �,<  Z` 1B  �+  �Z �-,   +  Z |Z  +  �Z �,<  �,< F ` /"  �,   f g,   +  Z   ,<  �Z` �,   f �d {XB` Z` �2B   +  Z   Z` ,   XB` �+  ,<  �[` �3B   +  ,<` [` �d |+  �Z` d �Z   ZwXB8 �Z   XB �Z` �XB Z �ZwXB8 �Z` �XB8 Z   XB �,<    c+   �Zw~XB8 Z   ,~   3B   +  �Z   +  Z }XB` �d �Z` �3B   +  �  r,~   Z` ,~   ,<   Zw�Z �,   XBp  3B   +  �[p  Z  +    Zw�Z Y,   XBp  3B   +    [p  Z  +    Zw�Zp  3B  7   7   +    Z   2B   +  �Zp  3B   +  �,<w� �XBw�,<p   �XBp   w�1b  0+  ; w�0"  �+  ; w�/"  ,   Zp  2B  7   Z   +     p  1b  0+  � p  0"  �7   7   +    +  �Z   +    Zw�,<  � w�/"  ,   ,\  2B  7   Z   +    Z   +    [w�[  ,<  �,< �, �,<  �,<   ,<   ,<   Zw�-,   +  M+  cZ  XBw�-,   +  �+  PZw�XBp  3B h+  �3B �+  �3B �+  �-,   +  �,<  �,< F �XBp  Zw~3B  +  �2B   +  �Zw�-,   +  �[w�-,   +  �,<w�,<w�, �3B   +  �Zw�2B   +  �Z   XBw+  c[w�XBw�+  KZw+    -.    �Z ,<  �,<   ,<   ,<   ,<   ,<   Zw�-,   +  �+  
Z  XBw�-,   +  m+  �Zw�XB �3B �+  �2B �+  �+  �Zw�2B   +  �Z e-,   +  �Z r+  �Z �Z  XBw�b �XBw+  �,<w,<   ,< F p  ,> 1,>  � w   �,^  �/  �2b  +  Z �,<  �,<w� �,<  �,<w�,<w �,\  3B  +  �+   p  ."  �,   XBp  +  y p  /"  �,   /  �XBw[w�XBw�+  �Zw3B   +   w,> 1,>  � ` �   �,^  �/  �2"  +  Z   +    Z �,<  �, �,< �, �XBp  3B   +  �,<` ,<  �,  3B   +   ,< \, �2B   +  Z �,<  �,<` �,<w� �Zw~2B  +  �Z"�+  Zw~f g+  �Z   XBp  Z �2B   +  �Zp  3B   +  �,<  �,<    �Zw+    ,<   Zw�-,   +  �XB �Z   XB !Z   XB �,< [Z ',<  ,  XBp  3B   +  0[p  Z  +  �Z   XB �+  B[w�-,   +  �Zw�XB �[w�XB �Z   XB �,< [Z �,<  ,  XBp  3B   +  ;[p  Z  +  �Z   XB �+  BZw�XB �[w�Z  XB �[w�[  XB �,< [, �XB �,< , �XB !,< �, �XB .Z �3B   +  �Z   XB CZ �3B   +  �-,   +  �,<  �,<    M3B   +  �Z   XB GZ   XB �Z   +         , Q,~   -.    Z ,<  �Zp  -,   +  �Z   +    Zp  ,<  �@ �  8+  �Zw�,<8  , �,< �, �XB` �3B   +  �,<  �Z @,<  ,< �, �XB` �3B   +  �Zw�,<8 ,   d +  mZw�,<8 Z M2B   +  �,< \, �2B   +  �Z =,   +  iZ   ,<  �Z N3B   +  l,   +  �Z   f ,<  �Z �,<  �Zw�,<8 , P,~   Zw,<8 Zp  -,   +  �+  �Zp  ,<  �Zp  -,   +  x,<  �,<    U+  �,<  �,<    �/  �[p  XBp  +  �/  �Z �,<  �,< �, �XB` �3B   +  �-,   +  �,<  �,<    U+  ,<  �,<    �+  ,< \, �2B   +  Z gXB` �3B   +  Z �2B   +  Z` �3B �+  3B h+  ,<  �,<    �Z �3B   +  ,<  �,<    �,<    1B   +  Zw,<8 ,<    �,~   /  �[p  XBp  +  SZ �2B   +  �Zp  2B   +  ,<w�,<    �+  ,<w�,<   ,<   ,<w� 	Zw�+    Zp  -,   +  �Z   +  'Zw�Zp  2B  +  �Zp  +  '[p  XBp  +   +    Zw�-,   +  *Z   +  �Zw�Zp  2B  +  �[w�Z  +  �[w�-,   Z   [  XBw�+  �+      �R!UKT'Dm]D� -	T K%{RM4DDKy	J$/�x&�{ B1,JVV*DSCDPhD`gu6 �$$Y)D�` 
 $)�l)A�	B$&	LIR$9(%/Y[p�4J* Ad�A#7�,U@)+voacJB#4�EI
B  L @ D@ @c?,)I" 1OIE"� J�PJa$H	@1B
9�T0LD2�t%r%"&(R(H                           (ASKUSERBLOCK#0 . 1)
(VARIABLE-VALUE-CELL LISPXHIST . 13)
(VARIABLE-VALUE-CELL RESETVARSLST . 1032)
(VARIABLE-VALUE-CELL DEFAULTKEYLST . 32)
(VARIABLE-VALUE-CELL ASKUSERTTBL . 1228)
(VARIABLE-VALUE-CELL READBUF . 1263)
(VARIABLE-VALUE-CELL OPTIONS . 1784)
(VARIABLE-VALUE-CELL OPTIONSLST . 1755)
(VARIABLE-VALUE-CELL NOCASEFLG . 1673)
(VARIABLE-VALUE-CELL KEY . 1805)
(VARIABLE-VALUE-CELL NOECHOFLG . 1809)
(VARIABLE-VALUE-CELL PROMPTSTRING . 1820)
(VARIABLE-VALUE-CELL CONFIRMFLG . 1667)
(VARIABLE-VALUE-CELL ECHOEDFLG . 1674)
(VARIABLE-VALUE-CELL FILE . 1679)
(VARIABLE-VALUE-CELL LISPXPRNTFLG . 1839)
ASKUSER
ASKUSEREXPLAIN
*ASKUSER*
((UNBOXED-NUM . 4) VARIABLE-VALUE-CELL KEYLST . 1700)
((UNBOXED-NUM . 6) VARIABLE-VALUE-CELL LISPXPRNTFLG . 0)
((UNBOXED-NUM . 7) VARIABLE-VALUE-CELL OPTIONSLST . 0)
((UNBOXED-NUM . 8) VARIABLE-VALUE-CELL FILE . 0)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(0 . 1)
(VARIABLE-VALUE-CELL ORIGMESS . 1319)
(0 . 1)
(NIL VARIABLE-VALUE-CELL OLDTTBL . 1207)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL ANSWER . 1316)
NIL
1
(NIL VARIABLE-VALUE-CELL KEY . 0)
(NIL VARIABLE-VALUE-CELL PROMPTSTRING . 0)
(NIL VARIABLE-VALUE-CELL OPTIONS . 0)
(NIL VARIABLE-VALUE-CELL NOECHOFLG . 0)
(NIL VARIABLE-VALUE-CELL CONFIRMFLG . 0)
(NIL VARIABLE-VALUE-CELL NOCASEFLG . 0)
(NIL VARIABLE-VALUE-CELL PRINTLST . 1325)
(NIL VARIABLE-VALUE-CELL ECHOEDFLG . 0)
(NIL)
(LINKED-FN-CALL . GETTERMTABLE)
SETTERMTABLE
(NIL)
(LINKED-FN-CALL . SETTERMTABLE)
(NIL)
(LINKED-FN-CALL . READP)
(NIL)
(LINKED-FN-CALL . LINBUF)
(NIL)
(LINKED-FN-CALL . SYSBUF)
(NIL)
(LINKED-FN-CALL . CLBUFS)
" "
" ? "
(NIL)
(LINKED-FN-CALL . DOBE)
PRINTBELLS
(NIL)
(LINKED-FN-CALL . CLEARBUF)
" ? "
(NIL)
(LINKED-FN-CALL . MAPRINT)
(NIL)
(LINKED-FN-CALL . WAITFORINPUT)
"..."
(NIL)
(LINKED-FN-CALL . PRIN1)
(NIL)
(LINKED-FN-CALL . PEEKC)
(NIL)
(LINKED-FN-CALL . NTHCHAR)
?
CONFIRMFLG
KEYLST
KEYSTRING
(NIL)
(LINKED-FN-CALL . NCONC)
%

% 
(NIL)
(LINKED-FN-CALL . READC)

%
(NIL)
(LINKED-FN-CALL . CHCON1)
MACROCHARS
(NIL)
(LINKED-FN-CALL . EVAL)
(NIL)
(LINKED-FN-CALL . TERPRI)
((DUMMY) . 0)
EXPLAINSTRING
"one of:
"
EXPLAINDELIMITER
"
"
" ? "
(NIL)
(LINKED-FN-CALL . SUBSTRING)
&

CLASS
(NIL)
(LINKED-FN-CALL . LISTGET1)
((DUMMY) . 0)
(NIL)
(LINKED-FN-CALL . READ)
(NIL VARIABLE-VALUE-CELL READBUF . 0)
(NIL)
(LINKED-FN-CALL . READLINE)
(NIL)
(LINKED-FN-CALL . NCHARS)
(NIL)
(LINKED-FN-CALL . LASTC)
(NIL)
(LINKED-FN-CALL . GETREADTABLE)
(NIL)
(LINKED-FN-CALL . RPLACD)
((T) . 0)
(NIL)
(LINKED-FN-CALL . ERROR!)
AUTOCOMPLETEFLG
PROMPTON
PROMPTCONFIRMFLG
" [confirm] "
%?
" [confirm] "
(NIL)
(LINKED-FN-CALL . BKBUFS)
RETURN
((DUMMY) . 0)
(NIL)
(LINKED-FN-CALL . PACK)
(NIL)
(LINKED-FN-CALL . NOTCHECKED)
"___
"
CONCAT
(NIL)
(LINKED-FN-CALL . APPLY)
(NIL)
(LINKED-FN-CALL . CONCAT)
ERROR
(NIL)
(LINKED-FN-CALL . RESETRESTORE)
*ASKUSER$*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL KEYLST . 0)
(NIL)
(LINKED-FN-CALL . NTHCHARCODE)
COMPLETEON
NOECHOFLG
NOCASEFLG
*ASKUSEREXPLAIN*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL KEYLST . 0)
((UNBOXED-NUM . 3) VARIABLE-VALUE-CELL OPTIONSLST . 0)
(NIL VARIABLE-VALUE-CELL KEY . 0)
(NIL VARIABLE-VALUE-CELL CONFIRMFLG . 0)
(NIL VARIABLE-VALUE-CELL NOECHOFLG . 0)
(NIL VARIABLE-VALUE-CELL PROMPTSTRING . 0)
NIL
(NIL VARIABLE-VALUE-CELL OPTIONS . 0)
(T VARIABLE-VALUE-CELL FILE . 0)
(NIL)
(LINKED-FN-CALL . APPEND)
(NIL)
(LINKED-FN-CALL . POSITION)
(NIL)
(LINKED-FN-CALL . LISPXPRIN1)
(URET1 URET6 URET2 FMEMB CONS21 CONSS1 EVCC IUNBOX BHC ASZ SKSTP MKN SKNM SKNLST SKLST CONS CONSNL ALIST2 KT CF KNIL BINDB BLKENT 
ENTER1)  j`   dp� \H   v( tP XpF X� W8� U8* Tp   U$ K(X   y   x ,@D   .    < -Hg @   rh� o(� a} JH� <(� /h� ,H= !x� (�    ch| N@J "( (   i | 
(   a � X89 P(5 4ph #0@ 	H   P   u� n0� f0� ^8� ] � Yp� Ih� " �   � 	 =   / pv [@� OX =@� (5 $p4 H (   � @H� 0    l mb P`� L@3 D@� ; O 9� ,P[ (H 0 x 8 Z 	       �    s@ r  q` p � nx� i8I hx< f� \� Wp; UX� S x N� J� H@� F � D0� ?X� =� ;D 7% 3P 0`� -hi *`Q ) � '� !H� h� `� 8�  Y � h V 
@ O  � h %  � p   LM     � u � sh� s� q � ph� mPk mg lP` k@� ix� iH� g6 eh+ e � d@� d� bx b� _r ]� ] � \p` [hY Y8K Y(� XP� Wh� V� U`� TP� Sx� S8 R( QP� Q� Nxu N0� Me Kh^ K8� JXL I< G(/ E@& D � C0� B(� @x� ?u =hk <h\ :`� :� 9(G 8(� 6p� 5P) 48� 38� 2� 1` +XX )0� (8> '7 %h� #x "p�  `  (  0t hn xa x� (� HB X� `* h$ � p  �   w H � h m 0 �   �  � X U 	X H h �   A h � x � 8 2  � P * H   `  @   j e  h    (      
ASKUSER BINARY
      	        �-.     @      ,<    �,~       (WAIT . 1)
(DEFAULT . 1)
(MESS . 1)
(VARIABLE-VALUE-CELL KEYLST . 0)
(TYPEAHEAD . 1)
(VARIABLE-VALUE-CELL LISPXPRNTFLG . 0)
(VARIABLE-VALUE-CELL OPTIONSLST . 0)
(VARIABLE-VALUE-CELL FILE . 0)
ASKUSER
(NIL)
(LINKED-FN-CALL . ASKUSERBLOCK)
(ENTERF)     
ASKUSEREXPLAIN BINARY
              �-.            ,<    �,~       (VARIABLE-VALUE-CELL KEYLST . 0)
(PREV . 1)
(VARIABLE-VALUE-CELL OPTIONSLST . 0)
(DELIMITER . 1)
ASKUSEREXPLAIN
(NIL)
(LINKED-FN-CALL . ASKUSERBLOCK)
(ENTERF)    
GAINSPACEBLOCKA0013 BINARY
    �    �    -.          �,<` �Z   D  �,~       (ATM . 1)
(VARIABLE-VALUE-CELL SMASHPROPSLST1 . 4)
REMPROPLIST
(ENTER1)     
GAINSPACEBLOCK BINARY
   �   R   �-.          R-.     P�h�        �    �     Z   XB   Z   ,<  Zp  -,   +   	+   &Zp  ,<  �@ Y  �+   $,<    �1B   +   �,<    �,< �,<   ,<   @ \ ` +   �Z   Z �XB Zw�Z8  b ^3B   +   "Z   ,<  �,< _Zw�[8  Z  ,   ,<  �Zw~[8  [  [  Z  ,<  �,<   
 �XB   3B _+   "Zw�[8  [  Z  b ^+   �Z   Z   ,~   ,~   /  �[p  XBp  +   /  �Z  �3B   +   4,<    �,< �,<    aZ bb �Z  �,<  �Zp  -,   +   �+   �Zp  ,<  �Zp  -,   +   �b ^/  �[p  XBp  +   �/  �Z �,~       ,  �,~   -.    dZ  �,<  �Z   d eXB  �Z  �2B f+   ],<    �,< �,<    aZ   ,<  �Zp  -,   +   �Z   +    Zp  ,<  �[p  ,<  �Zp  -,   +   FZ   +   RZp  ,<  �,<w�/  �Zp  -,   +   �,<  �Z  �d g2B   +   �7   Z   +   NZ   /  �3B   +   �Zp  +   R[p  XBp  +   �/  �3B   +   [,<   ,<   Zw,   ,<  �,<   ,<   
 �2B f+   [[p  ,<  �Z  Jd eXB  �/  �[p  XBp  +   ?3B h+   _2B �+   vZ  >,<  ,<   ,<   ,<   Zw�-,   +   dZw+   �Zw�,<  �[p  b i/  �XBp  -,   +   oZw�3B   +   kZp  QD  +   lZp  XBw   �   [  2D   +   �XBw�[w�XBw�+   �/  XB  �Z  :2B �+   uZ  qb jB k,~   Z   ,~     �,~       @ l  +  %Zw�Z8  2B �+   �Z   XB   +  �2B f+  ,<   ,<   ,< �,< m,<   
 �Zw�XB8  ,<    �,<   ,<   ,< �,<   ,<   
 �2B f7   Z   XB  �+  �  �Z   ,<  �Zw~,<8  , �Z   ,<  �Zw~,<8  , �Z   ,<  �Zw~,<8  , �Z 3B   +  $Z   ,<  Zw~,<8  , �Z   ,<  �Zp  -,   +  +  �Zp  ,<  �Zp  -,   +  �Zw�Z8  3B   +  �,<p  ,< n �+  �,<p  ,< n �[  [  Z  ,<  �, ?/  �[p  XBp  +  /  �Z   ,~   +    Zw�-,   +  (Z   +    Zp  3B   +  �,<w�,<    �+    Zw�Z 2B  +  �Zw�,<  �Zp  -,   +  1Z   +  �Zp  ,<  �[p  [  ,<  �,< � r/  �[p  XBp  +  �/  �+    Zw�,<  �Zp  -,   +  ;Z   +  >Zp  ,<  �, ?[p  XBp  +  �/  �+    ,<   ,<w�,< s �XBp  3B   +  �[w�[  ,<  �,< s,<w,< n,<w�,< n �,   d �,<p  Zp  -,   +  �+  �Zp  ,<  �, ?[p  XBp  +  �/  �+  Q[w�[  ,<  �,<    �Z   +    `*eE ,[C�! (HR Cp
#1g4$c�C.aH!�DEhdP@           (GAINSPACEBLOCK#0 . 1)
(VARIABLE-VALUE-CELL SMASHPROPSLST1 . 230)
(VARIABLE-VALUE-CELL GAINSPACEFORMS . 12)
(VARIABLE-VALUE-CELL DWIMWAIT . 43)
(VARIABLE-VALUE-CELL SMASHPROPSLST . 113)
(VARIABLE-VALUE-CELL SMASHPROPSMENU . 190)
(VARIABLE-VALUE-CELL LISPXHISTORY . 273)
(VARIABLE-VALUE-CELL EDITHISTORY . 344)
(VARIABLE-VALUE-CELL LASTHISTORY . 283)
(VARIABLE-VALUE-CELL ARCHIVELST . 291)
(VARIABLE-VALUE-CELL LISPXCOMS . 296)
GAINSPACE
ERASEPROPS
PURGEHISTORY
(NIL VARIABLE-VALUE-CELL RESPONSE . 227)
(NIL)
(LINKED-FN-CALL . POSITION)
(NIL)
(LINKED-FN-CALL . TERPRI)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(NIL)
(LINKED-FN-CALL . EVAL)
N
(NIL)
(LINKED-FN-CALL . ASKUSER)
"mapatoms called to erase the indicated properties..."
(NIL)
(LINKED-FN-CALL . PRIN1)
GAINSPACEBLOCKA0013
(NIL)
(LINKED-FN-CALL . MAPATOMS)
done
*ERASEPROPS*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL RESPONSE . 0)
(NIL)
(LINKED-FN-CALL . UNION)
Y
"indicate which ones:
"
(NIL)
(LINKED-FN-CALL . MEMB)
A
E
(NIL)
(LINKED-FN-CALL . APPEND)
(NIL)
(LINKED-FN-CALL . SORT)
EDITE
HELP
(NIL VARIABLE-VALUE-CELL ARCHIVEFLG . 288)
"purge everything, or just the properties, e.g. SIDE, LISPXPRINT, etc. ? "
(((Y "es - everything" RETURN T) (N "o - just the properties" RETURN (QUOTE NIL)) (E "verything" RETURN T) (J "ust the properties" 
RETURN (QUOTE NIL))) . 0)
"ARCHIVELST and named commands too ? "
*HISTORY*
(NIL)
(LINKED-FN-CALL . REMPROP)
(NIL)
(LINKED-FN-CALL . GETPROP)
(NIL)
(LINKED-FN-CALL . RPLACA)
%
(NIL)
(LINKED-FN-CALL . RPLNODE)
*GROUP*
(NIL)
(LINKED-FN-CALL . LISTGET1)
(NIL)
(LINKED-FN-CALL . RPLACD)
(ALIST4 URET2 SKLA URET1 BINDB SKLST BHC CONSNL CF ASZ KT SKNLST KNIL BLKENT ENTER1)     (�  ,     �   &     x     1   � p� X� ( � p \ 
0 O 	 � ( ' P   
` �    �    �   ( x� (� @ � 	P > H �  � X  h �   J  0 p� 0 E  .     Q (@ 01 0� P�  P 8  h v h �   �  W 
P � 
8 � 	h � 	@ F  ( 0 �      �       
GAINSPACE BINARY
              �-.            ,<    �,~       GAINSPACE
(NIL)
(LINKED-FN-CALL . GAINSPACEBLOCK)
(ENTER0)      
ERASEPROPS BINARY
     �        -.           ,<  �  ,~       (VARIABLE-VALUE-CELL RESPONSE . 0)
ERASEPROPS
(NIL)
(LINKED-FN-CALL . GAINSPACEBLOCK)
(ENTERF)      
PURGEHISTORY BINARY
      �        -.           ,<  �  ,~       (TYPE . 1)
PURGEHISTORY
(NIL)
(LINKED-FN-CALL . GAINSPACEBLOCK)
(ENTER1)      
READ' BINARY
     �    �    0-.          �Z   b  )b  *,<  �@  +   ,~       A"  �,>  ',>  �Z   b  �.Bx  ,^  �/  �."  [  A"   0B   +      A"  �,>  ',>  �Z  b  �.Bx  ,^  �/  �."  [  1B  R+      A"  �,>  ',>  �Z  b  �.Bx  ,^  �/  �."  [  0B  �+   Z  �,~   Z  �,<  �Z"  ,\  2B  +   �Z   3B   +   �Z  �b  -,<  .,<  �Z  �,<  �Z  �d  /,   ,~   ,<  .Z  �,<  �Z  �d  /,   ,~     �B  I@K�    (VARIABLE-VALUE-CELL FILE . 72)
(VARIABLE-VALUE-CELL RDTBL . 74)
(VARIABLE-VALUE-CELL INBQUOTE . 58)
(NIL)
(LINKED-FN-CALL . PEEKC)
(NIL)
(LINKED-FN-CALL . CHCON1)
(VARIABLE-VALUE-CELL CH . 52)
(NIL)
(LINKED-FN-CALL . GETREADTABLE)
'
(NIL)
(LINKED-FN-CALL . READC)
QUOTE
,
(NIL)
(LINKED-FN-CALL . READ)
(ALIST2 ALIST3 KNIL ASZ BHC ENTERF) p   8   h   @   x         
READLINEP BINARY
        �    -.          �@  �  ,~   Z   ,<  �,<  Z   F  �XB   3B   +   �,<  ,<  �,<   H  B  �2B  7   Z   ,<  �Z  �B  �,\  �,~   Z   ,~   )N      (VARIABLE-VALUE-CELL POS . 9)
(VARIABLE-VALUE-CELL LISPXREADFN . 6)
(NIL VARIABLE-VALUE-CELL SCRATCHPOS . 23)
-1
STKPOS
REALSTKNTH
STKNAME
READLINE
RELSTK
(KT KNIL ENTERF) 8   h          
DO?=A0014 BINARY
          �    �-.          �Z   ,<  �,<   ,<  �,<  	(  �,<  �Z   ,<  �,<   &  
,~   a   (VARIABLE-VALUE-CELL X . 3)
(VARIABLE-VALUE-CELL FILE . 10)
10
3
RETDWIM3
PRIN2
(KT KNIL ENTERF)      �       
DO?=A0015 BINARY
          �    �-.          �Z   ,<  �,<   ,<  �,<  	(  �,<  �Z   ,<  �,<   &  
,~   a   (VARIABLE-VALUE-CELL X . 3)
(VARIABLE-VALUE-CELL FILE . 10)
10
3
RETDWIM3
PRIN2
(KT KNIL ENTERF)      �       
DO?= BINARY
         �   �-.           �,<  �,<   ,<   @   ` +   {Z   Z �XB ,< " �,<  �@   �+   �,< �Z   ,<  �,   ,   Z   ,   XB  �XB` ,< ,< �,<   @   ` +   �Z   Z �XB @   �+   �Z   2B   +   Z   XB  �Z   2B   +   �Z"   XB  Z   2B   +   Z XB   Z   -,   +     �Z  XB  �Z  ,<  �,<   Z  F XB   -,   +   ([  �2B   +   (Z  �B �XB   1B  +   '0B  �+   (Z  "XB  'Z  �3B   +   �-,   +   �[  �2B   +   �Z  �Z  (,   ,<  �Z  �,<  �,<   & +   �,<   [  ,XB  13B   +   �Z  �2B   +   �Zp  +   NZ  1B   +   �,<  �Z  .D �Z  33B 	+   �Z  �,<  �Z  �,<  �,<   & [  :XB  =+   @,< �Z  ;D �,< 
Z  ?D �Z  �3B   +   �Z  �,<  �,<   ,< ,< ( �+   GZ  C,<  �Z  �,<  �,<   & [  �2B   +   �Z  �3B   +   �Z  �B +   1/  �Z  �2B   +   �Z  K2B 	+   �,< �Z  �D �[  PZ  ,<  �Z  R,<  �,<   & ,< Z  �D �+   �Z  �3B   +   a,<  �Z  W,<  ,< �,< ,<   Z  �3B   +   �Z �+   `Z L +   �Z  S3B   +   �,<  �Z  ],<  ,<   ,< �,< * +   �,<  �Z  cD �[  �,<  �Z  g,<  �,< �,< ,<   3B   +   �Z +   nZ L Z   ,~   Zw}XB8 �Z   ,~   2B   +   �Z �XB   [` XB  �,< �Z` Z  [  D Z  s3B   +   �  �,~   Z` �,~   +    ,~   +,UR1@IJ
 %%A$<,.@�?y|L           (VARIABLE-VALUE-CELL TAIL . 71)
(VARIABLE-VALUE-CELL FORM . 208)
(VARIABLE-VALUE-CELL FILE . 210)
(VARIABLE-VALUE-CELL LEFT . 107)
(VARIABLE-VALUE-CELL RESETVARSLST . 232)
(VARIABLE-VALUE-CELL COM . 53)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
3
PRINTLEVEL
(VARIABLE-VALUE-CELL OLDVALUE . 19)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 238)
((DUMMY) . 0)
INTERNAL
(NIL VARIABLE-VALUE-CELL ARGNAMES . 194)
(NIL VARIABLE-VALUE-CELL TEM . 73)
?=
ERROR!
SMARTARGLIST
ARGTYPE
PRIN2
SPACES
...
2
" = "
PRIN1
10
RETDWIM3
TERPRI
".
.
"
" = "
"plus  ... "
%)
DO?=A0014
MAPRINT
" = "
,
" = ... "
DO?=A0015
ERROR
APPLY
(BHC SKLST SKNLST ASZ CONS CONSNL LIST2 CF KNIL KT ENTERF)   	p   ( "    �    7 p &    `     � @   8    �    � ( � @ e ( �   � 	0 E H 3  ,  �   � P �  8    � h � 
  � 0 =     `        
DO?A0016 BINARY
           �    �-.           �Z   ,<  �,<   ,<   &  ,~   @   (VARIABLE-VALUE-CELL X . 3)
PRIN2
(KT ENTERF)    8      
DO?A0017 BINARY
         �    �-.           �Z   ,<  �,<   ,<   &  ,~   @   (VARIABLE-VALUE-CELL X . 3)
PRIN2
(KT ENTERF)    8      
DO? BINARY
    -   �   (-.         �@ �  0,~   Z   B �XB   Z  2B   +   �Z  3B +   �3B �+   �2B +   �  �3B   +   Z   XB   3B   +   Z   3B   +     1B  �+   �Z   2B   +   Z  XB   Z  ,   XB   Z  �+   Z  �XB  �XB   2B   +   -Z  ,<  �Z  B �XB  �,   A"  �,> ,>  �Z   B .Bx  ,^  �/  �."  [  A"   0B   +   (   �A"  �,> ,>  �Z  B .Bx  ,^  �/  �."  [  A"  @1B   +   )Z �+   ,,< �Z  �,<  �Z  #D D �D ,~   Z  !2B +   �,< �,< ,<   @ � ` �+   IZ   Z XB Z   ,<  �Z  XB  3,\  3B  +   �Z  �3B   +   �[  �3B   +   �Z  8,<  �,<   ,<   ,<   Z  4J �3B   +   �Z  �B ,<  �,< �Z  >,<  �,< ( �+   �Z  <,<  �Z  �B 3B   +   �Z +   GZ   D �XB   Z   ,~   3B   +   �Z  �2B   +   �,< �,<   $ +   �Z  �,<  Z  �D XB  J2B �+   \Z  �B �2B +   \,< �,<   ,<   @ � ` �+   �Z   Z XB Z  �,<  �Z  @D  Z  QB �Z   ,~   +   �Z  �B �,<  �Z"  /,\  2B  +   qZ  �B �2B +   q,< !,<   ,<   @ � ` �+   �Z   Z XB Z �,<  �Z  �,<  �Z  \B ",   1b  �+   �Z  h,<  �,< �,< #& �+   nZ   ,<  � "  ,   Z   ,~   +   �Z  �,<  �,< �Z  �D �D ,~   [  q[  3B   +   �Z  �,<  �Z  �   �   [  2D   +   �,\  QB  ,<   " �Z  3B   +   ,<  �,<   ,<   & $Z  �3B   +  �[  ,<  �,<   ,< �,< %,<   Z �L &Z  �3B   +  Z �,<  �,<   ,< �,< ',<   Z �L &Z ,~     �E~DiD@� xsj@I*8]	X[e!Je(�pa �	Hl           (VARIABLE-VALUE-CELL FILE . 191)
(VARIABLE-VALUE-CELL RDTBL . 157)
(VARIABLE-VALUE-CELL LST . 278)
(VARIABLE-VALUE-CELL LINE . 40)
(VARIABLE-VALUE-CELL LISPXFLG . 26)
(VARIABLE-VALUE-CELL LAST? . 105)
(NIL VARIABLE-VALUE-CELL C . 90)
(NIL VARIABLE-VALUE-CELL TAIL . 175)
(NIL VARIABLE-VALUE-CELL FORM . 206)
(NIL VARIABLE-VALUE-CELL FN . 249)
(NIL VARIABLE-VALUE-CELL TEM . 229)
(NIL VARIABLE-VALUE-CELL LN . 259)
PEEKC
%

=
^
READLINEP
INREADMACROP
CHCON1
GETREADTABLE
?
READ
PACK*
TCONC
((DUMMY) . 0)
NOBREAK
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
FNCHECK
LENGTH
ARGS
FD
HELPSYS
FNTYP
"unavailable subject.
"
PRIN1
((DUMMY) . 0)
DO?=
TERPRI
((DUMMY) . 0)
PF
NCHARS
2
-1
SUBATOM
PRIN2
" "
" "
DO?A0016
MAPRINT
"("
" "
DO?A0017
(EVCC CF BHC IUNBOX CONS ASZ KNIL KT ENTERF)       X W (   `     j 0   @   h    � p  ~ ( � h � 
P � 	  � X > @ �   � x � h  0   �   � H � 0 � 
H M 	 � 8        
READVBAR BINARY
       �        �-.           Z   B  �2B  +   �Z  �B  �Z   ,<  �Z  �,<  Z   D  D  �,~   2B  +   Z  �B  �+   �3B  �+   3B  +   2B  �+   Z  �,<  �Z  �B  D  �,~   Z  ,~    m     (VARIABLE-VALUE-CELL FILE . 30)
(VARIABLE-VALUE-CELL RDTBL . 13)
(VARIABLE-VALUE-CELL TC . 34)
PEEKC
'
READC
READBQUOTE
TCONC
% 
%(
{
^
HREAD
(ENTERF)      
READBQUOTE BINARY
        �        *-.          Z   ,<  �@  !  ,~   Z   ,<  �,<  �,<  #,<   @  � ` �+   Z   Z  %XB ,<  �,<  &,<  &,<  �Z   F  �,<  �Z  �,<  �,   ,<  �,<   ,   Z  ,   XB  @  '  +   �,<  �Z   ,<  �Z  D  (,   ,~   XB   Z   ,~   3B   +   Z   +   �Z  �XB   D  )Z  �3B   +      �,~   Z  �,~   +h�14`      (VARIABLE-VALUE-CELL FILE . 39)
(VARIABLE-VALUE-CELL RDTBL . 41)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
(VARIABLE-VALUE-CELL RESETVARSLST . 34)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
(NIL VARIABLE-VALUE-CELL RESETY . 60)
(NIL VARIABLE-VALUE-CELL RESETZ . 55)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
SETSYNTAX
,
((MACRO FIRST READBQUOTECOMMA) . 0)
(T VARIABLE-VALUE-CELL INBQUOTE . 0)
BQUOTE
READ
ERROR
RESETRESTORE
ERROR!
(KT ALIST2 CONS LIST2 LIST4 CF KNIL ENTERF)      �    �    �        	                 
READBQUOTECOMMA BINARY
     �    �    -.           �Z   B  �2B  +   �Z  �B  �Z  ,~   2B  �+   �Z  �B  �Z  ,~   2B  �+   �Z  �B  �Z  ,~   Z  �,~   6mP (VARIABLE-VALUE-CELL FILE . 19)
(VARIABLE-VALUE-CELL RDTBL . 0)
PEEKC
%.
READC
,.
!
,!
@
,@
,
(ENTERF)      
EXPANDBQUOTE BINARY
      N    �    �-.           �Z   -,   +   �Z  �3B   +   B3B   +   B-,   +   B,<  C,<  �,   ,~   Z  2B  �+   �,<   ,<   ,<   [  �Z  3B  �+   +   �Z  �,<  �[  XB  ,\  �XBp  Zw�3B   +   ,<  �Zw�,   XBw,\  QB  +   Zp  ,   XBw�XBw+   �Zw/  �,<  �[  �Z  ,   D  DB  �,<  �[  [  B  ED  �,~   2B  F+   #[  Z  B  EXB  �+   �3B  �+   '3B  G+   '3B  �+   '2B  H+   3[  "[  3B   +   �Z  '3B  G+   �2B  �+   �Z  D+   -Z  �,<  �[  )Z  ,<  �[  �[  B  E,   ,~   [  /Z  ,~   Z  �B  E,<  �[  3B  E,<  �@  I @,~   Z   B  KXB   3B   +   �Z   B  KXB   3B   +   �,<  CZ  �Z  ;,   ,   ,~   Z  �,<  �Z  :D  �,~   ,~   + @B�~x	DS        (VARIABLE-VALUE-CELL X . 105)
QUOTE
,
NCONC
BQ.PROGN
EXPANDBQUOTE
BQ.CONS
BQUOTE
,.
.,
,@
,!
APPEND
(VARIABLE-VALUE-CELL BCAR . 127)
(VARIABLE-VALUE-CELL BCDR . 129)
(NIL VARIABLE-VALUE-CELL AV . 122)
(NIL VARIABLE-VALUE-CELL DV . 123)
CONSTANTEXPRESSIONP
(ALIST2 CONS ALIST3 BHC CONSNL LIST2 SKNNM KT KNIL SKNLST ENTERF)  x   p          @ � H       h    X   H :  � @ � 0 �           
BQUOTE BINARY
    �        -.      �    ,<` �"  �,~       (BQUOTEX . 1)
DOBQUOTE
(ENTER1)      
DOBQUOTE BINARY
     �    �    %-.           �Z` �-,   +   �,~   Z` �2B   +   �[` �Z  B  �,<  �[` �[  B  !,   ,~   2B  �+   [` �Z  B  "XB` �+   �3B  �+   3B  #+   3B  �+   2B  $+   �[` �Z  B  �,<  �[` �[  B  !D  �,~   Z` �B  !,<  �[` �B  !,<  �Zw�Z` �2B  +   �Zp  [` �2B  +   �Z` �+    Zw�Zp  ,   +    2~F$       (BQUOTEX . 1)
,
EVAL
DOBQUOTE
BQUOTE
EXPANDBQUOTE
,.
.,
,@
,!
APPEND
(CONS URET2 CONSS1 SKNLST ENTER1)   x         �           
BQ.CONS BINARY
            �    -.           �Z   -,   Z   Z  3B  �+   �2B  +   �Z   [  �,   Z  ,   ,~   2B  �+   �Z  �[  ,   Z  �,   ,~   Z  
3B   +   ,<  �Z  �,<  ,<  �,   ,~   ,<  �Z  �,<  ,   ,~   xL!A     (VARIABLE-VALUE-CELL XA . 35)
(VARIABLE-VALUE-CELL XD . 25)
CONS
LIST*
LIST
(LIST2 LIST3 CONS21 CONS KNIL SKLST ENTERF)  8      H �    �  x   ` �           
BQ.PROGN BINARY
       �        -.           [   3B   +   Z  �Z  �,   ,~   Z  �,~       (VARIABLE-VALUE-CELL L . 10)
PROGN
(CONS KNIL ENTERF)  P    0      
READCOMMENT BINARY
          �   -.         ( �@  �  H,~   Z   3B   +   Z  2B   +   Z   3B   +   Z   3B   +   Z  B 2B   +   �Z  �,<  �Z   D �,~   Z  	B XB   ,   0"  7   Z   XB   Z  �,   ,   XB   Z  �,<  Z   D �XB   3B +   s3B �+   s3B +   s3B �+   s3B +   s3B �+   s3B +   s3B �+   s2B +   �+   s-,   +   !+   sZ  2B  +   #+   �Z   3B   +   )Z   3B   +   ),<  �Z  �D �3B   +   )+   sZ  �B 3B �+   s3B �+   s2B �+   �+   sZ  ),<  �   .  �,   XB   D 	Z  �0B  +   6Z  �,<     0.  �,   XB  �D 	Z  �B �2B �+   �Z  6,<  �Z  �D 	Z  ,<  �Z  !D �,~   Z  8,   ,   XB   ,   ,>  x,>  �   5   �,^  �/  �/  ,   XB   Z  �,<     >/"  �,   D 	Z  �3B   +   h,<  �Zp  -,   +   RZp  Z 7@  7   Z  2B 
+   Q,<p  ,<   Z   F �B 3B   +   RZ   +   �Z   /  �3B   +   �Z  �Z 7@  7   Z  XB   ,<  �,< �$ 2B   +   ]Z  TXB  �,<  �,< �$ 3B   +   hZ  Z,   ,   XB  �Z  �,<  Z  ],<  Z  @,<  Z  �H �Z  _,<  �   b/"  �,   D 	Z  �XB  aZ  �XB  cZ  :,<  �,<   Z  ;,<  �Z  �,<  Z  C,<  Z  XBw�Z  �2B   +   �  ,<  �,<w~^"  �,   /  �D �,~   Z  �,<  �Z  9D 	Z  h,<  �Z  �D �,~     �$JD@?~fI7|$�8D �j  @      (VARIABLE-VALUE-CELL FL . 230)
(VARIABLE-VALUE-CELL RDTBL . 41)
(VARIABLE-VALUE-CELL LST . 234)
(VARIABLE-VALUE-CELL NORMALCOMMENTSFLG . 206)
(VARIABLE-VALUE-CELL COMMENTFLG . 236)
(VARIABLE-VALUE-CELL CLISPFLG . 70)
(VARIABLE-VALUE-CELL CLISPCHARRAY . 73)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 157)
(NIL VARIABLE-VALUE-CELL X . 0)
(NIL VARIABLE-VALUE-CELL START . 213)
(NIL VARIABLE-VALUE-CELL END . 200)
(NIL VARIABLE-VALUE-CELL NCHARS . 215)
(NIL VARIABLE-VALUE-CELL POS . 232)
(NIL VARIABLE-VALUE-CELL TEM . 204)
(NIL VARIABLE-VALUE-CELL FLG . 217)
(NIL VARIABLE-VALUE-CELL FL1 . 192)
(NIL VARIABLE-VALUE-CELL N . 98)
RANDACCESSP
TCONC
POSITION
RATOM
%(
%)
%[
%]
%"
'
%.
DECLARATIONS:
E
STRPOSL
PEEKC
_
SETFILEPTR
SKREAD
NOBIND
STKSCAN
RELSTK
OUTPUT
OPENP
COPYBYTES
INPUT
LCONC
(LIST KNOB SKLA BHC ASZ SKNM MKN FGFPTR IUNBOX KT KNIL ENTERF)      
h �    J    � 
8 �    �    �    f p � 8 � X � 8   h > 0   x     R  	  x   p j P � 
@ S 
 O 	  � ` �    ` �       
GETCOMMENT BINARY
    �      �-.         @@ �  0,~   [   Z  XB   -,   +   �-,   +  �Z  -,   +  �[  �-,   +  �Z  ,   $" t,> �,>  �[  �,   .Bx  ,^  �/  �,   XB  3B   +  �[  [  Z  XB   -,   +  �[  �[  [  Z  XB   3B   +  �[  �[  [  [  Z  XB   3B   +   2B   +  �[  [  [  [  [  2B   +  �Z  �Z   3B  +  �   1"   +  �Z  �,<  �Zp  -,   +   �Zp  Z 7@  7   Z  2B �+   �,<p  ,<   Z   F B �3B   +   �Z   +   .Z   /  �3B   +   �Z  #Z 7@  7   Z  XB  �Z  2,<  �,< $ �2B   +   �,< ,<   ,<   @ � ` �+   �Z   Z XB Z  �,<  �,< $ �XB  :Z   ,~   2B   +   �Z XB   ,<  �Z   ,<  ,< �$ D �2B   +   �Z  ?,<  �,<   $ [  [  [  Z  ,<  �,<   $ �,< ,<   $ Z  �,~   ,< �Z  <,<  �,   ,<  �,<   ,   Z   ,   XB  OZ  L,<  �Z  �D Z   2B   +   Z@ �  �+   �Z  �,<  �Z  �,<  Z   D D �,~   ,~   Z   3B   +   �Z   B XB   Z  �3B   +   �  �,<  ,<   ,<   & �+   �  �XB  �,   ."  �,> �,>  �       �,^  �/  �3b  +   �Z  �,<  �,<   ,<   & �+   �   �,> �,>  �   b   �,^  �/  �/  ,   B !Z   3B   +   �B Z   3B �+   {Z  �B "2B   +   {[  �,<  �Z  s,   ,   D �[  u[  [  ,<  �Z  vD �Z  �,<  �Z  z,<  Z  �,<     },> �,>  �   .Bx  ,^  �/  �,   H #Z  �3B   +  �B Z  Z3B   +  �Z  ]3B   +  �  �  �Z   ,~   Z  x,~     �
$ 
1T �:4@9b(  &'            (VARIABLE-VALUE-CELL X . 275)
(VARIABLE-VALUE-CELL DESTFL . 248)
(VARIABLE-VALUE-CELL DEF . 265)
(VARIABLE-VALUE-CELL BOUNDPDUMMY . 84)
(VARIABLE-VALUE-CELL LISPXHIST . 128)
(VARIABLE-VALUE-CELL RESETVARSLST . 160)
(VARIABLE-VALUE-CELL FILERDTBL . 175)
(VARIABLE-VALUE-CELL DEFAULTFONT . 183)
(VARIABLE-VALUE-CELL FIRSTCOL . 213)
(VARIABLE-VALUE-CELL COMMENTFONT . 223)
(VARIABLE-VALUE-CELL NORMALCOMMENTSFLG . 227)
(NIL VARIABLE-VALUE-CELL ST . 252)
(NIL VARIABLE-VALUE-CELL NC . 255)
(NIL VARIABLE-VALUE-CELL FL . 246)
(NIL VARIABLE-VALUE-CELL FLG . 268)
(NIL VARIABLE-VALUE-CELL STR . 261)
(NIL VARIABLE-VALUE-CELL TEM . 216)
NOBIND
STKSCAN
RELSTK
INPUT
OPENP
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
OPENFILE
"can't find file "
*LISPXPRINT*
LISTGET1
MEMB
LISPXPRIN1
LISPXPRIN2
" - comments lost
"
CLOSEF?
SETFILEPTR
(T VARIABLE-VALUE-CELL NORMALCOMMENTSFLG . 0)
READ
/RPLNODE2
CHANGEFONT
ENDLINE1
10
POSITION
SPACES
DONTUPDATE
DISPLAYP
/RPLACA
COPYBYTES
(FGFPTR CONS LIST2 CF KNOB SKLA KT KNIL MKN BHC IUNBOX SKNM SKLST SKNNM ENTERF)   x   
   	x N    �    2     X     a 	( I X � X    � x @ u  �  � 8 T 	p � h � p � x � H � x  p �   �   � x     � p / p   8 � 0   8 �      h    X      
PRINTCOMMENT BINARY
      �    �    �-.           �@    ,~   Z   3B   +   Z   2B   +   �Z   B  �,~      XB   B  �3B   +   Z   3B   +   B  Z   ,~   Z   2B   +   �Z  B  �3B   +   Z  B  �,~   Z  �,<  �Z  �,<  Z  F  �,~   %*0U    (VARIABLE-VALUE-CELL X . 36)
(VARIABLE-VALUE-CELL DEF . 40)
(VARIABLE-VALUE-CELL FORMFLG . 9)
(VARIABLE-VALUE-CELL **COMMENT**FLG . 20)
(VARIABLE-VALUE-CELL CHANGEFLG0 . 26)
(NIL VARIABLE-VALUE-CELL FL . 38)
GETCOMMENT
OUTPUT
DISPLAYP
PRIN1
(KNIL ENTERF)   � P �     H      

NORMALCOMMENTS BINARY
           �    -.          �Z   ,<  �Z   3B  +   �Z  �2B   +   �,<  �,<  Z   F  �,<  �Z   D  2B   +   �,<  �"  +   �,<  �,<  �Z  �F  �Z  XB  �,\  �,~   Nkz      (VARIABLE-VALUE-CELL FLG . 27)
(VARIABLE-VALUE-CELL NORMALCOMMENTSFLG . 28)
(VARIABLE-VALUE-CELL FILERDTBL . 25)
(VARIABLE-VALUE-CELL PRETTYPRINTMACROS . 16)
*
((INFIX ALONE NOESC READCOMMENT) . 0)
SETSYNTAX
ASSOC
((PRETTYPRINTMACROS (CONS (QUOTE (* . PRINTCOMMENT)) PRETTYPRINTMACROS)) . 0)
SAVESETQ
OTHER
(KNIL ENTERF)   
  X      
SHOWPRINT BINARY
    �    �    -.          �Z   3B   +   �Z   ,<  ,<   ,<   ,<   ,<   Z   L  �Z  B  +   �Z  ,<  Z  ,<  Z   F  �Z  �,~   0  (VARIABLE-VALUE-CELL X . 23)
(VARIABLE-VALUE-CELL FILE . 19)
(VARIABLE-VALUE-CELL RDTBL . 21)
(VARIABLE-VALUE-CELL SYSPRETTYFLG . 3)
PRINTDEF
TERPRI
PRINT
(KT KNIL ENTERF)    P    h   X        
SHOWPRIN2 BINARY
          �    �-.          �Z   3B   +   �Z   ,<  ,<   ,<   ,<   ,<   Z   L  �+   �Z  ,<  Z  ,<  Z   F  Z  �,~   A  (VARIABLE-VALUE-CELL X . 21)
(VARIABLE-VALUE-CELL FILE . 17)
(VARIABLE-VALUE-CELL RDTBL . 19)
(VARIABLE-VALUE-CELL SYSPRETTYFLG . 3)
PRINTDEF
PRIN2
(KT KNIL ENTERF)  P    h   X        
MAKEKEYLST BINARY
     �    �    �-.            �@  �  ,~   Z   ,<  �,<   Zw�-,   +   Zp  Z   2B   +   	 "  +   �[  QD   "  +   %Zw�,<  �@  Q   �+   "Z   ,<  �,<   ,<  �Z   3B   +   Z  �,<  �B  R,\  ,   3B   +   Z  B  �+   �Z  �,<  �,<  S$  �,<  �,<  T,<   ,<  �Z   ,<  �,<  UZ  3B   +   �3B   +   �-,   +   �,<  �,<  �,   ^,  ,   ,~   Zp  ,   XBp  [w�XBw�+   �/  XB   ,<  �,<  �@  V  0�+   �Z` �-,   +   �+   �Z  XB   ,<  �,<  �$  �XB   Z   ,<  ,<  �,<  Z,<   ,<  �,<  ,<  [F  �,<  �,<  T,<   ,<  U,<  �,<  \Z  +3B   +   :3B   +   :-,   +   :,<  �,<  �,   ,   ^,  ,   XB` Z` �3B   +   A,<  �Z` ,   XB` �,\  QB  +   CZ` ,   XB` �XB` [` �XB` �   �."  �,   XB  D+   �Z` ,~   ,<  �Z   2B   +   KZ  �,   +   �-,   +   MZ   +   �,   F  ],~   (JEM$V !&+.V @@T        (VARIABLE-VALUE-CELL LST . 6)
(VARIABLE-VALUE-CELL DEFAULTKEY . 144)
(VARIABLE-VALUE-CELL LCASFLG . 31)
(VARIABLE-VALUE-CELL AUTOCOMPLETEFLG . 52)
(NIL VARIABLE-VALUE-CELL TEM . 75)
(VARIABLE-VALUE-CELL KEY . 55)
KEYSTRING
U-CASE
L-CASE
" "
CONCAT
CONFIRMFLG
AUTOCOMPLETEFLG
RETURN
QUOTE
(0 . 1)
NIL
NIL
NIL
(NIL VARIABLE-VALUE-CELL X . 106)
(NIL VARIABLE-VALUE-CELL KEYSTRING . 90)
(1 VARIABLE-VALUE-CELL I . 139)
LISTGET
NOECHOFLG
EXPLAINSTRING
" - "
PROGN
((TERPRI T) . 0)
(("No - none of the above " "" CONFIRMFLG T AUTOCOMPLETEFLG T RETURN NIL) . 0)
NCONC
(MKN CONSNL ALIST3 BHC COLLCT ALIST LIST2 SKNNM KT EQUAL SKNLST KNIL ENTERF)  F    N 	0 � x   0   `   8   @ "    �         � @ � `         L       M 	 � h  H  x   x        
COROUTINE BINARY
      �    �    �-.       �    �Z   ,<  �Z  �Z 7@  7   Z  -,   +   �,<  �,<   $      �,\  �,   XB  �Z   ,<  �Z  �Z 7@  7   Z  -,   +   �,<  �,<   $      �,\  �,   XB  �,<  �,<  �,<  !$   ,<  �Z  F  �Z   B  "Z  	,<  �Z   ,<  ,<  �,<  !$   ,<  �,<   ,<   (  �,<  �,<   &  #,~   @PrCD@ (VARIABLE-VALUE-CELL CALLPTR## . 44)
(VARIABLE-VALUE-CELL COROUTPTR## . 40)
(VARIABLE-VALUE-CELL COROUTFORM## . 42)
(VARIABLE-VALUE-CELL ENDFORM## . 46)
0
STKNTH
-1
COROUTINE
RESUME
EVAL
ENVEVAL
RETTO
(KNIL SET KT SKNSTK KNOB ENTERF) 0    �     8 �  x   `       P      
OLDRESUME BINARY
            �-.           ,<  �,<  	Z   F  �Z   ,<  �Z   ,<  ,<   &  
,~      (VARIABLE-VALUE-CELL FROMPTR . 5)
(VARIABLE-VALUE-CELL TOPTR . 7)
(VARIABLE-VALUE-CELL VAL . 9)
-1
RESUME
STKNTH
RETTO
(KT ENTERF)  �       
GENERATOR BINARY
      �        �-.      �    Z   3B   +   B  XB  �-,   +   
,<  �,<   $  ,<  �,<  �,<   $  ,   XB  �+   Z  	-,   +   Z  
,<  �,<  �,<   $  ,\  XB  [  �-,   +   Z  ,<  �,<  �,<   $  ,\  QB  [  �,<  �,<  �,<   Z  F  ,<  �Z  F  �Z   B  Z  �,<  �Z  �,<  �,<   &  !,~   R%�!RA  (VARIABLE-VALUE-CELL FORM## . 49)
(VARIABLE-VALUE-CELL COMVAR## . 53)
EVAL
0
STKNTH
-1
GENERATOR
RESUME
RETTO
(SKNSTK CONSS1 KT SKNLST KNIL ENTERF)   � 8      H  ` �  h    P    0      
GENERATE BINARY
             �-.           Z   ,<  �[  �,<  �Z   F  ,~       (VARIABLE-VALUE-CELL HANDLE . 5)
(VARIABLE-VALUE-CELL VAL . 7)
RESUME
(ENTERF)      
PRODUCE BINARY
                �-.          [   ,<  �Z  �,<  �Z   F  ,~       (VARIABLE-VALUE-CELL VAL . 7)
(VARIABLE-VALUE-CELL COMVAR## . 5)
RESUME
(ENTERF)      
GENERATEFN BINARY
        !         -.           Z   -,   +   ,<  ,<   $  �,<  �,<  ,<   $  �,   XB  �+   Z  -,   +   Z  ,<  �,<  ,<   $  �,\  XB  [  �-,   +   Z  ,<  �,<  ,<   $  �,\  QB  [  �,<  �,<  ,<  �Z  F  �,<  �Z  F  Z   ,<  � "   ,   Z  �,<  �Z  �,<  �,<   &  �,~   *$PJ   (VARIABLE-VALUE-CELL FN . 45)
(VARIABLE-VALUE-CELL COMVAR## . 51)
0
STKNTH
-1
GENERATEFN
RESUME
RETTO
(EVCC SKNSTK CONSS1 KT SKNLST ENTERF)      �     x   8  @ �  H    0      
ADIEU BINARY
        �    �    -.         �Z   1B   +   Z` �B  Z   ,<  �Z   ,<  �Z   XB  ,\  �,<  �,<   &  �,~   @  (VARIABLE-VALUE-CELL VAL## . 3)
(VARIABLE-VALUE-CELL COMVAR## . 8)
(VARIABLE-VALUE-CELL POSSLIST## . 13)
NOTE
RETTO
(KT KNIL ASZ ENTERF)   	               
AU-REVOIR BINARY
      �    �    -.         �Z   1B   +   Z` �B  Z   B  [  ,<  �Z  ,<  �Z   ,<  �Z   XB  ,\  �F  �,~   P  (VARIABLE-VALUE-CELL VAL## . 3)
(VARIABLE-VALUE-CELL COMVAR## . 12)
(VARIABLE-VALUE-CELL POSSLIST## . 17)
NOTE
RESUME
(KNIL ASZ ENTERF)     0      
CLEANPOSLST BINARY
       �    �    -.           �Z   ,<  �Zp  -,   +   Z   +    Zp  ,<  �@     +   Z   -,   +   �Z  �-,   +   �Z  	B  �[  �B  �,~   [p  XBp  +   �BI(@(VARIABLE-VALUE-CELL PLST . 3)
(VARIABLE-VALUE-CELL X . 23)
RELSTK
(SKSTK SKLST URET1 KNIL SKNLST ENTERF)   (       X    P    @      
NOTE BINARY
    
    �    �-.          �Z   ,<  �Z   3B   +   Z   +   Z  ,   D  	XB  �,~   R   (VARIABLE-VALUE-CELL VAL . 10)
(VARIABLE-VALUE-CELL LSTFLG . 5)
(VARIABLE-VALUE-CELL POSSLIST## . 13)
NCONC
(CONSNL KNIL ENTERF)  �           
POSSIBILITIES BINARY
       �        -.      �    @  �  ,~   ,<  �,<  $  �,<  �,<  ,<   $  �,   XB   ,   B  �Z   B     �Z   ,~   j  (VARIABLE-VALUE-CELL FORM## . 17)
(NIL VARIABLE-VALUE-CELL COMVAR## . 14)
(NIL VARIABLE-VALUE-CELL POSSLIST## . 0)
-1
POSSIBILITIES
STKNTH
0
PRODUCE
EVAL
ADIEU
(KNIL CONSNL CONSS1 KT ENTERF) 0       x    h      
TRYNEXT BINARY
      �    �    �-.      �    �@    ,~   Z   ,<  �B  �,<  �Z   B  �D  XB   [     �,\  �,   Z  �2B   +   �,<  �Z   D  +   �Z  	,~   Z   ,~   &X      (VARIABLE-VALUE-CELL PLST## . 6)
(VARIABLE-VALUE-CELL ENDFORM## . 22)
(VARIABLE-VALUE-CELL VAL## . 10)
(NIL VARIABLE-VALUE-CELL PL1## . 25)
EVAL
TRYNEXT1
TRYNEXT
RETEVAL
(KNIL SET ENTERF) h �    �       
TRYNEXT1 BINARY
       �    �    -.           �@  �  ,~   Z   2B   +   �Z   ,~   Z  XB   -,   +   	Z  -,   +   
Z  �,~   Z  �,<  �[  
,<  �Z   F  ,<  �[  	D  �XB  �+    HP(VARIABLE-VALUE-CELL PLST## . 29)
(VARIABLE-VALUE-CELL MSG## . 24)
(NIL VARIABLE-VALUE-CELL PL1## . 22)
RESUME
NCONC
(SKNSTK SKLST KNIL ENTERF)       x    X �       
POSSIBILITYFN BINARY
       �    �    -.           �,<  ,<  �$  ,<  �,<  �,<   $  ,   XB   ,   B  ,<` � "   ,      �,~   Q  (FN . 1)
(VARIABLE-VALUE-CELL COMVAR## . 11)
(VARIABLE-VALUE-CELL POSSLIST## . 0)
-1
POSSIBILITYFN
STKNTH
0
PRODUCE
ADIEU
(EVCC CONSNL CONSS1 KT ENTERF)   	                   
(PRETTYCOMPRINT ASSISTCOMS)
(RPAQQ ASSISTCOMS ((COMS (FILEPKGCOMS CONSTANTS)) (COMS * BQUOTECOMS) (COMS (FNS READCOMMENT GETCOMMENT PRINTCOMMENT NORMALCOMMENTS)
 (INITVARS (NORMALCOMMENTSFLG T)) (USERMACROS GET*) (DECLARE: DOEVAL@COMPILE DONTCOPY (RECORDS COMMENTBOX))) (COMS (* Read macros 
for ' * and ^W) (FNS READ') (P (PROGN (SETSYNTAX (QUOTE ') (QUOTE (MACRO FIRST NOESC READ')) EDITRDTBL) (SETSYNTAX (QUOTE ') 
EDITRDTBL T)) (MAPC (CHARCODE (^A ^B ^C ^D ^E ^F)) (FUNCTION (LAMBDA (X) (ECHOCONTROL X (QUOTE IGNORE))))))) (COMS (FNS PRINTPROPS 
PRINTBINDINGS) (LISPXMACROS PL PB ;) (BLOCKS (PRINTPROPS PRINTPROPS (NOLINKFNS . T) (GLOBALVARS SPELLINGS1 SPELLINGS2 USERWORDS)) (
PRINTBINDINGS PRINTBINDINGS (NOLINKFNS . T)))) (COMS (FNS SHOWPRINT SHOWPRIN2) (INITVARS (SYSPRETTYFLG)) (GLOBALVARS SYSPRETTYFLG)) 
(COMS (FNS DO? DO?=) (VARS (LAST?)) (P (SETSYNTAX (QUOTE ?) (QUOTE (INFIX FIRST NOESC DO?)) T) (SETSYNTAX (QUOTE ?) T EDITRDTBL)) (
PROP ARGNAMES DEFINEQ) (USERMACROS ?=)) (COMS * ASKUSERCOMS) (COMS (* Coroutine package.) (FNS * COFNS) (FNS * GENERFNS) (ADDVARS (
SYSSPECVARS COMVAR## POSSLIST##)) (P (MOVD? (QUOTE OLDRESUME) (QUOTE RESUME))) (PROP (MACRO INFO) * COMACROS) (I.S.OPRS OUTOF) (PROP
 BYTEMACRO GENERATOR POSSIBILITIES)) (COMS * GAINSPACECOMS) (BLOCKS (NIL READ' (LINKFNS . T)) (NIL READLINEP (GLOBALVARS LISPXREADFN
)) (NIL DO?= DO? (GLOBALVARS LAST?) (NOLINKFNS HELPSYS))) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (
NLAMA) (NLAML TRYNEXT POSSIBILITIES GENERATOR COROUTINE BQUOTE ASKUSERLOOKUP) (LAMA AU-REVOIR ADIEU)))))
(PUTDEF (QUOTE CONSTANTS) (QUOTE FILEPKGCOMS) (QUOTE ((COM MACRO (X (DECLARE: EVAL@COMPILE (VARS . X) (P (CONSTANTS . X))))))))
(RPAQQ BQUOTECOMS ((* BQUOTE AND FRIENDS) (FNS READVBAR READBQUOTE READBQUOTECOMMA) (MACROS LIST*) (FNS EXPANDBQUOTE BQUOTE DOBQUOTE
 BQ.CONS BQ.PROGN) (MACROS BQUOTE) (P (SETSYNTAX (QUOTE %|) (QUOTE (INFIX READVBAR)) FILERDTBL) (SETSYNTAX (QUOTE %|) (QUOTE (INFIX 
READVBAR)) T) (SETSYNTAX (QUOTE %|) (QUOTE (INFIX READVBAR)) EDITRDTBL) (SETSYNTAX (QUOTE `) (QUOTE (MACRO FIRST READBQUOTE)) T) (
SETSYNTAX (QUOTE `) (QUOTE (MACRO FIRST READBQUOTE)) EDITRDTBL)) (VARS (INBQUOTE))))
(PUTPROPS LIST* MACRO (X (COND ((NULL X) NIL) ((NULL (CDR X)) (CAR X)) ((NULL (CDDR X)) (CONS (QUOTE CONS) X)) (T (LIST (QUOTE CONS)
 (CAR X) (CONS (QUOTE LIST*) (CDR X)))))))
(PUTPROPS BQUOTE MACRO (FORM (EXPANDBQUOTE (CAR FORM))))
(SETSYNTAX (QUOTE %|) (QUOTE (INFIX READVBAR)) FILERDTBL)
(SETSYNTAX (QUOTE %|) (QUOTE (INFIX READVBAR)) T)
(SETSYNTAX (QUOTE %|) (QUOTE (INFIX READVBAR)) EDITRDTBL)
(SETSYNTAX (QUOTE `) (QUOTE (MACRO FIRST READBQUOTE)) T)
(SETSYNTAX (QUOTE `) (QUOTE (MACRO FIRST READBQUOTE)) EDITRDTBL)
(RPAQQ INBQUOTE NIL)
(RPAQ? NORMALCOMMENTSFLG T)
(ADDTOVAR EDITMACROS (GET* NIL (BIND (IF (NEQ (SETQ #1 (GETCOMMENT (##))) (##)) ((I : #1) 1) NIL))))
(ADDTOVAR EDITCOMSA GET*)
(PROGN (SETSYNTAX (QUOTE ') (QUOTE (MACRO FIRST NOESC READ')) EDITRDTBL) (SETSYNTAX (QUOTE ') EDITRDTBL T))
(MAPC (CHARCODE (^A ^B ^C ^D ^E ^F)) (FUNCTION (LAMBDA (X) (ECHOCONTROL X (QUOTE IGNORE)))))
(ADDTOVAR LISPXHISTORYMACROS (PL (COND (LISPXLINE (MAPC (NLAMBDA.ARGS LISPXLINE) (FUNCTION PRINTPROPS))) (T (QUOTE (E PL))))) (PB (
COND (LISPXLINE (MAPC (NLAMBDA.ARGS LISPXLINE) (FUNCTION (LAMBDA (X) (PRINTBINDINGS X (AND (EQ LISPXID (QUOTE :)) LASTPOS)))))) (T (
QUOTE (E PB))))) (; NIL NIL))
(ADDTOVAR HISTORYCOMS ;)
(RPAQ? SYSPRETTYFLG)
(RPAQQ LAST? NIL)
(SETSYNTAX (QUOTE ?) (QUOTE (INFIX FIRST NOESC DO?)) T)
(SETSYNTAX (QUOTE ?) T EDITRDTBL)
(PUTPROPS DEFINEQ ARGNAMES (NIL (X1 XI ... XN) . X))
(ADDTOVAR EDITMACROS (?= NIL (E (PROGN (DO?= (##)) (TERPRI T)) T)))
(ADDTOVAR EDITCOMSA ?=)
(RPAQQ ASKUSERCOMS ((* Askuser package.) (FNS ASKUSER ASKUSERLOOKUP ASKUSERCHAR ASKUSER$ ASKUSER1 ASKUSERSETUP ASKUSEREXPLAIN 
ASKUSERPRIN1 MAKEKEYLST) (INITVARS (DEFAULTKEYLST (QUOTE ((Y "es
") (N "o
")))) (ASKUSERTTBL (COPYTERMTABLE))) (DECLARE: DONTEVAL@LOAD DOCOPY (P (CONTROL T ASKUSERTTBL) (ECHOMODE NIL ASKUSERTTBL))) (BLOCKS 
(ASKUSERBLOCK ASKUSER ASKUSERLOOKUP ASKUSERCHAR ASKUSER1 ASKUSER$ ASKUSERSETUP ASKUSEREXPLAIN ASKUSERPRIN1 (GLOBALVARS DEFAULTKEYLST
 ASKUSERTTBL) (LOCALFREEVARS KEY CONFIRMFLG NOECHOFLG PROMPTSTRING OPTIONS OPTIONSLST FILE NOCASEFLG ECHOEDFLG LISPXPRNTFLG) (
SPECVARS PRINTLST KEYLST ORIGMESS) (SPECVARS ANSWER OLDTTBL) (BLKLIBRARY LISTGET MEMB) (ENTRIES ASKUSER ASKUSEREXPLAIN) (NOLINKFNS 
PRINTBELLS))) (DECLARE: DOEVAL@COMPILE DONTCOPY (PROP BLKLIBRARYDEF LISTGET) (RECORDS ASKUSER OPTIONS))))
(RPAQ? DEFAULTKEYLST (QUOTE ((Y "es
") (N "o
"))))
(RPAQ? ASKUSERTTBL (COPYTERMTABLE))
(CONTROL T ASKUSERTTBL)
(ECHOMODE NIL ASKUSERTTBL)
(RPAQQ COFNS (COROUTINE OLDRESUME GENERATOR GENERATE PRODUCE GENERATEFN))
(RPAQQ GENERFNS (ADIEU AU-REVOIR CLEANPOSLST NOTE POSSIBILITIES TRYNEXT TRYNEXT1 POSSIBILITYFN))
(ADDTOVAR SYSSPECVARS COMVAR## POSSLIST##)
(MOVD? (QUOTE OLDRESUME) (QUOTE RESUME))
(RPAQQ COMACROS (COROUTINE GENERATOR TRYNEXT POSSIBILITIES))
(PUTPROPS COROUTINE MACRO ((P1 P2 F1 F2) (PROGN (OR (STACKP P1) (SETQ P1 (STKNTH 0 T))) (OR (STACKP P2) (SETQ P2 (STKNTH 0 T))) ((
LAMBDA (..MACROX.) (COND ((EQ ..MACROX. P2) P2) (T (RESUME P2 ..MACROX. P2) F1 (RETTO P1 F2 T)))) (STKNTH -1)))))
(PUTPROPS GENERATOR MACRO (X (PROG ((Y (SUBST (CAR X) (QUOTE FORM##) (QUOTE (LAMBDA (COMVAR## ..MACROX.) (COND ((EQ (SETQ ..MACROX. 
(STKNTH -1 (QUOTE *PROG*LAM) (CAR COMVAR##))) COMVAR##) COMVAR##) (T (RESUME (CDR COMVAR##) ..MACROX. COMVAR##) FORM## (RETTO (CAR 
COMVAR##) COMVAR## T)))))))) (RETURN (COND ((CADR X) (FRPLACD (CDR Y) (CONS (QUOTE (OR (STACKP (CAR COMVAR##)) (FRPLACA COMVAR## (
STKNTH 0 T)))) (CONS (QUOTE (OR (STACKP (CDR COMVAR##)) (FRPLACD COMVAR## (STKNTH 0 T)))) (CDDR Y)))) (LIST Y (LIST (QUOTE OR) (LIST
 (QUOTE LISTP) (CADR X)) (QUOTE (CONS (STKNTH 0 T) (STKNTH 0 T)))))) (T (LIST Y (QUOTE (CONS (STKNTH 0 T) (STKNTH 0 T))))))))))
(PUTPROPS TRYNEXT MACRO ((PLST NOMORE MSG) (COND ((SETQ PLST (TRYNEXT1 PLST MSG)) (PROG1 (CAR PLST) (SETQ PLST (CDR PLST)))) (T (
SETQ PLST (CDR PLST)) NOMORE))))
(PUTPROPS POSSIBILITIES MACRO ((FORM) (PROG (COMVAR## POSSLIST##) (PRODUCE (LIST (SETQ COMVAR## (CONS (STKNTH -1 (QUOTE *PROG*LAM)) 
(STKNTH 0 T))))) FORM (ADIEU))))
(PUTPROPS COROUTINE INFO EVAL)
(PUTPROPS GENERATOR INFO EVAL)
(PUTPROPS TRYNEXT INFO EVAL)
(PUTPROPS POSSIBILITIES INFO EVAL)
(I.S.OPR (QUOTE OUTOF) NIL (QUOTE (SUBST (GENSYM) (QUOTE GENVAR) (QUOTE (BIND GENVAR _ (GENERATOR BODY) EACHTIME (COND ((EQ (SETQ 
I.V. (GENERATE GENVAR)) GENVAR) (GO $$OUT))) FINALLY (RELSTK (CDR GENVAR)))))) T)
(PUTPROPS GENERATOR BYTEMACRO ((FORM COMVAR) (GENERATEFN (FUNCTION (LAMBDA NIL FORM)) COMVAR)))
(PUTPROPS POSSIBILITIES BYTEMACRO ((FORM) (POSSIBILITYFN (FUNCTION (LAMBDA NIL FORM)))))
(RPAQQ GAINSPACECOMS ((* gainspace package) (FNS GAINSPACE ERASEPROPS PURGEHISTORY PURGEHISTORY1 PURGEHISTORY2) (VARS SMASHPROPSMENU
 (SMASHPROPSLST)) (ADDVARS (GAINSPACEFORMS ((CAR LISPXHISTORY) "purge history lists" (PURGEHISTORY RESPONSE) ((Y "es") (N "o") (E . 
"verything"))) (T "discard definitions on property lists" (SETQ SMASHPROPSLST1 (CONS (QUOTE EXPR) (CONS (QUOTE CODE) (CONS (QUOTE 
SUBR) SMASHPROPSLST1))))) (T "discard old values of variables" (SETQ SMASHPROPSLST1 (CONS (QUOTE VALUE) SMASHPROPSLST1))) (T 
"erase properties" (ERASEPROPS RESPONSE) ((Y "es" EXPLAINSTRING "Yes - you will be asked which properties are to be erased") (N "o")
 (A "ll" CONFIRMFLG T EXPLAINSTRING "All - all properties on mentioned on SMASHPROPSMENU") (E "dit
" EXPLAINSTRING "Edit - you will be allowed to edit a list of property names"))) (CLISPARRAY "erase CLISP translations" (CLRHASH 
CLISPARRAY)) (CHANGESARRAY "erase changes array" (CLRHASH CHANGESARRAY)) (SYSHASHARRAY "erase system hash array" (CLRHASH)) ((
GETPROP (QUOTE EDIT) (QUOTE LASTVALUE)) "discard context of last edit" (REMPROP (QUOTE EDIT) (QUOTE LASTVALUE))) (GREETHIST 
"discard information saved for undoing your greeting" (SETQ GREETHIST)))) (BLOCKS (GAINSPACEBLOCK GAINSPACE ERASEPROPS PURGEHISTORY 
PURGEHISTORY1 PURGEHISTORY2 (ENTRIES GAINSPACE ERASEPROPS PURGEHISTORY) (GLOBALVARS GAINSPACEFORMS SMASHPROPSMENU SMASHPROPSLST 
SMASHPROPSLST1 DWIMWAIT ARCHIVELST LASTHISTORY ARCHIVEFLG LISPXCOMS LISPXHISTORY EDITHISTORY) (SPECVARS RESPONSE))) (DECLARE: 
DOEVAL@COMPILE DONTCOPY (RECORDS GAINSPACE))))
(RPAQQ SMASHPROPSMENU (("old values of variables" VALUE) ("function definitions on property lists" EXPR CODE) ("advice information" 
ADVISED ADVICE READVICE (SETQ ADVISEDFNS NIL)) ("filemaps" FILEMAP) ("clisp information (warning: this will disable clisp!)" 
ACCESSFN BROADSCOPE CLISPCLASS CLISPCLASSDEF CLISPFORM CLISPIFYISPROP CLISPINFIX CLISPISFORM CLISPISPROP CLISPNEG CLISPTYPE 
CLISPWORD CLMAPS I.S.OPR I.S.TYPE LISPFN SETFN UNARYOP) ("compiler information (warning: this will disable the compiler!)" AMAC 
BLKLIBRARYDEF CROPS CTYPE GLOBALVAR MACRO MAKE OPD UBOX) ("definitions of named history commands" *HISTORY*) (
"context of edits exited via save command" EDIT-SAVE)))
(RPAQQ SMASHPROPSLST NIL)
(ADDTOVAR GAINSPACEFORMS ((CAR LISPXHISTORY) "purge history lists" (PURGEHISTORY RESPONSE) ((Y "es") (N "o") (E . "verything"))) (T 
"discard definitions on property lists" (SETQ SMASHPROPSLST1 (CONS (QUOTE EXPR) (CONS (QUOTE CODE) (CONS (QUOTE SUBR) SMASHPROPSLST1
))))) (T "discard old values of variables" (SETQ SMASHPROPSLST1 (CONS (QUOTE VALUE) SMASHPROPSLST1))) (T "erase properties" (
ERASEPROPS RESPONSE) ((Y "es" EXPLAINSTRING "Yes - you will be asked which properties are to be erased") (N "o") (A "ll" CONFIRMFLG 
T EXPLAINSTRING "All - all properties on mentioned on SMASHPROPSMENU") (E "dit
" EXPLAINSTRING "Edit - you will be allowed to edit a list of property names"))) (CLISPARRAY "erase CLISP translations" (CLRHASH 
CLISPARRAY)) (CHANGESARRAY "erase changes array" (CLRHASH CHANGESARRAY)) (SYSHASHARRAY "erase system hash array" (CLRHASH)) ((
GETPROP (QUOTE EDIT) (QUOTE LASTVALUE)) "discard context of last edit" (REMPROP (QUOTE EDIT) (QUOTE LASTVALUE))) (GREETHIST 
"discard information saved for undoing your greeting" (SETQ GREETHIST)))
(PUTPROPS ASSIST COPYRIGHT ("Xerox Corporation" T 1978 1982 1983 1984))
NIL
 