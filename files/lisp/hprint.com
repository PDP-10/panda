(FILECREATED "31-Dec-84 03:26:17" ("compiled on " <NEWLISP>HPRINT..164) (2 . 2) brecompiled changes: HVBAKREAD in 
"INTERLISP-10  14-Sep-84 ..." dated "14-Sep-84 00:05:07")
(FILECREATED "28-Sep-84 20:32:13" {ERIS}<LISPCORE>SOURCES>HPRINT.;3 32123 changes to: (FNS HVBAKREAD) previous date: 
"30-Jun-84 01:33:39" {ERIS}<LISPCORE>SOURCES>HPRINT.;2)
COPYALLA0009 BINARY
       	        �-.          ,<` "  �,<  �,<` �"  �,<  �Z   F  ,~   H   (X . 1)
(Y . 1)
(VARIABLE-VALUE-CELL NH . 9)
COPYALL
PUTHASH
(ENTER2)     
COPYALL BINARY
      �    ^    o-.           ^-.      �    _Zp  -,   +   �Zp  ,<  �,  ,   ,<  �,<   Zw�XBp  [wXBw-,   +   �3B   +   �,<p  ,<  �,  D  _Zw�+   �,<p  Zw�,<  �,  ,   XBw�D  _+   �/  +    -,   +   �   +   +    B  �,<  �Zp  Z   ,   3B   +   �Zw�+   �Zp  2B  `+   �,<w�"  �+   �2B  a+   �Zw�,   ,   +   �2B  �+   # w�,   +   �2B  b+   -,<w�"  �,<  �,<w,<  c$  �D  d,<  �@  �   �+   �Zw�,<?�Z  eD  �Z   ,~   +   �2B  f+   �,<w�"  �+   �2B  g+   2,<w�"  �+   �2B  h+   �,<w�"  �,<  �,<w"  i,<  �,<w�"  �,<  �,<   ,<w�,<w�,<   ,<w~(  jXBp  ,<  � w~4b  E,>  �,>  �,<w�,<w�,<w|,<w�$  �,<  �,  F  k w."  �,   XBw>`x  5   �/  ,\  �/  +   �2B  �+   I,<w�"  l+   �2B  �+   KZw�+   �,<   ,<   ,<w�"  mXBw�3B   +   �,<w,<w~$  �XBp  ,<w�Zp  -,   +   S+   ZZp  ,<  �,<p  ,<w�,<w,<w|$  n,<  �,  F  �/  �[p  XBp  +   Q/  �Zp  +   \Zw�/  /  �+      �$&�E Vx�')N{i #`Gz!@�         (X . 1)
(VARIABLE-VALUE-CELL DONTCOPYDATATYPES . 47)
RPLACD
TYPENAME
STRINGP
CONCAT
FLOATP
FIXP
HARRAYP
HARRAYSIZE
OVERFLOW
HARRAYPROP
HARRAY
(VARIABLE-VALUE-CELL NH . 87)
COPYALLA0009
MAPHASH
READTABLEP
COPYREADTABLE
TERMTABLEP
COPYTERMTABLE
ARRAYP
ARRAYSIZE
ARRAYTYP
ARRAYORIG
ARRAY
ELT
SETA
BITMAP
BITMAPCOPY
CCODEP
GETDESCRIPTORS
NCREATE
FETCHFIELD
REPLACEFIELD
(MKN MKFN FUNBOX FMEMB SMALLT SKNLA URET1 BHC SKNLST KNIL CONSNL SKLST BLKENT ENTER1) 8 #    �             �    �    ^ h     � P [  � X �    � (   	h � 	@ :  � 8     �  p    H    (      
EQUALALLA0010 BINARY
         
    �-.          
Z` -,   +   Z   ,   ,<  �,<` �$  2B   +   �Z  �B  ,~   Z   ,   XB  ,~   @  (VAL . 1)
(KEY . 1)
(VARIABLE-VALUE-CELL AR2 . 6)
(VARIABLE-VALUE-CELL UNMATCHED . 18)
EQUALALL
EQUALHASH
RETFROM
(CONS KNIL GETHSH SKLA ENTER2)   �    �    �           
EQUALALLA0011 BINARY
           �    -.          �Z` -,   +   �Z   ,   2B   +   Z  �B  ,~   Z   ,<  Zp  -,   +   
Z   +   Zp  ,<  �,<w�/  �,<` ,<w�$  �3B   +   �,<` �Zw�Z  ,   D  �+   Z   /  �3B   +   �Zp  +   [p  XBp  +   �/  �3B   +   �Z   ,~   Z   Z  �B  ,~   
CH`  (VAL . 1)
(KEY . 1)
(VARIABLE-VALUE-CELL AR1 . 31)
(VARIABLE-VALUE-CELL UNMATCHED . 13)
EQUALHASH
RETFROM
EQUALALL
(KT BHC SKNLST KNIL GETHSH SKLA ENTER2)   �     0 �    	    � x � ( �         H    0      
EQUALALL BINARY
    �   �   ^-.          �-.     �   �Zw�Zp  3B  7   7   +    ,<p  " �,<  �,<   Zw�,<  �,<w~" �,\  2B  +  �Zw�3B M+   2B �+   Z   +  ;2B N+   � w�,> J,>  � w   �,^  �/  �2B  7   Z   +  ;2B �+   �Zw�Zw,   +  ;2B O+   "Zw�,<  �Zw�,<  �,  3B   +   ![w�,<  �[w�XBw�,\  �XBw�/  +   Z   +  ;2B �+   %Zw�Zw,   +  ;2B P+   �,<w�" �,<  �,<w�" �,\  2B  +   �,<w�" Q,<  �,<w�" Q,\  ,   3B   +   �,<w�" �XBp  ,<  �,<w�" �,\  ,   3B   +   �,<p  ,<w~" �,<  �,<   ,<   Z"  �XBw� w�,> J,>  � w�   �,^  �/  �3b  +   �+   H,<w�,<w�$ R,<  �,<w�,<w~$ R,<  �,  2B   +   �Z   XBp  +   H w."  �,   XBw w�."  �,   XBw�+   �Zp  /  +  ;Z   +  ;2B �+   �,<w�,<w�, <+  ;2B S+   `,< �,< T,<    w�,> J,>  � w   �,^  �/  �3b  +   U+   �,<w�,<w�$ �,<  �,<w,<w�$ �,<  �,  2B   +   \Z   XBp  +   � w�."  �,   XBw�+   PZp  /  �+  ;2B U+  &,<w�" �,<  �,<w�" �,\  2B  +  %,<w�" V,<  �,<w�" V,\  2B  +  %,<w�" �,<  �,<w�" �,\  2B  +  %,<w�" W,<  �,<w�" W,\  2B  +  %Z   ,<  �Zp  -,   +   �Z   +   Zp  ,<  �,<w�/  �Zp  ,<  �,<w}$ �,<  �Zw�,<  �,<w}$ �,\  ,   /  �2B   +   �Z   +   [p  XBp  +   r/  �3B   +  %,< �,< T,<    w�,> J,>  � w   �,^  �/  �3b  +  +  ,<w�,<   ,<w|& X,<  �,<w,<   ,<w|& X,\  3B  +  �Z   XBp  +   w�."  �,   XBw�+  Zp  /  �3B   +  %Z   ,<  �Zp  -,   +  �Z   +  $Zp  ,<  �,<w�/  �Zp  ,<  �,<   ,<w�& �,<  �Zw�,<  �,<   ,<w�& �,\  ,   /  �2B   +  �Z   +  $[p  XBp  +  /  �+  ;Z   +  ;Zw�Zw,   2B   +  ;,<w�" YXBw�3B   +  �,<  �,<   ,<   Zw-,   +  �+  8Z  XBw�,<  �,<w�$ �,<  �,<w,<w�$ �,<  �,  2B   +  �Z   XBp  +  8[wXBw+  �Zp  /  �+  ;Z   +  ;Z   /  +    -.    Z,<   Z   ,<  �,< �$ \,<  �Z   ,<  �,< �$ \,\  ,   2B   +  �+  �Z �,<  �Z �D ]Z @,<  �Z �D ]/  �Z   ,~     �/:cB@.:%""R�HEH'$R))P!IdIB@!JBH�$Jc�L         (X . 1)
(Y . 1)
(VARIABLE-VALUE-CELL ORIGTERMSYNTAX . 226)
(VARIABLE-VALUE-CELL ORIGDELETECONTROL . 296)
TYPENAME
LITATOM
SMALLP
FIXP
FLOATP
LISTP
STRINGP
ARRAYP
ARRAYORIG
ARRAYTYP
ARRAYSIZE
ELT
HARRAYP
READTABLEP
127
0
GETSYNTAX
TERMTABLEP
GETCONTROL
GETRAISE
GETECHOMODE
GETDELETECONTROL
31
ECHOCONTROL
DELETECONTROL
GETDESCRIPTORS
FETCHFIELD
EQUALHASH
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL AR1 . 393)
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL AR2 . 397)
OVERFLOW
HARRAYPROP
EQUALALLA0010
MAPHASH
EQUALALLA0011
(BINDB SKNLST MKN ASZ EQUAL STREQUAL EQP BHC URET2 KNIL KT BLKENT ENTER2)   P   `� 8    ^ x �    �   �  � 0 .    %   (    < %  8  } p ` 
@ � 8 ! @   H �   D `� (6 P� 0� `� � 8 p � h � 8 � 	( C   � 8 �    P      J P� 8 � 
 7 X �    �       
HCOPYALL BINARY
       �    �    -.          �Z   B  �2B   +   Z  �-,   Z   Z  B  �3B   +   �Z  �B  +   
,<  �"  XB  ,<` �"  �,~   <@ (X . 1)
(VARIABLE-VALUE-CELL HPRINTHASHARRAY . 19)
HARRAYP
CLRHASH
100
HASHARRAY
HCOPYALL1
(SKLST KNIL ENTER1)        X �       
HCOPYALL1A0012 BINARY
      	        �-.          ,<` "  �,<  �,<` �"  �,<  �Z   F  ,~   H   (X . 1)
(Y . 1)
(VARIABLE-VALUE-CELL NEW . 9)
HCOPYALL1
PUTHASH
(ENTER2)     
HCOPYALL1 BINARY
      �    �    x-.           �-.      g    hZp  -,   +   �   +   +    B  h,<  �,<   ,<   ,<w�"  hXBwZ   ,   3B   +   �Zw�+   eZw�Z   ,   2B   +   eZw2B  �+   �,<w�Z   ,   ,<  �Z  F  i,<  �Zw~,<  �,  ,<  �[w�,<  �,     �,\  �XCp  QEp  ,\  �+   e2B  �+   ,<w�,<w~"  j,<  �Z  �F  i+   e2B  �+   $,<w�Zw~,   ,   ,<  �Z  �F  i+   e2B  k+   �,<w� w~,   ,<  �Z  �F  i+   e2B  �+   >,<w�"  l,<  �,<w~"  �,<  �,<w�"  m,<  �,<w},<w�,<w�,<   ,<w~(  �XBw~,<  �Z  'F  i w4b  �,>  f,>  �,<w�,<w�,<w|,<w�$  n,<  �,  F  � p  ."  �,   XBp  >`x  5   5/  Zw�/  �+   e2B  o+   �,<w�,<w~"  �,<  �,<w�,<  p$  �D  qXBw�,<  �Z  2F  i,<p  @  �   �+   �Zw�,<?�Z  rD  �,~   Zp  +   e2B  s+   M,<w�"  �+   e2B  t+   �,<w�,<w~"  �,<  �Z  DF  i+   e2B  u+   T,<w�"  �+   eB  vXBw�3B   +   �,<w�,<w�"  �XBw�,<  �Z  PF  i,<w�Zp  -,   +   \+   cZp  ,<  �,<p  ,<w�,<w,<w|$  w,<  �,  F  �/  �[p  XBp  +   Z/  �Zp  +   eZw�/  �+      �*(,O�`z$,9*g<O9	       (X . 1)
(VARIABLE-VALUE-CELL DONTCOPYDATATYPES . 19)
(VARIABLE-VALUE-CELL HPRINTHASHARRAY . 177)
TYPENAME
LISTP
PUTHASH
STRINGP
CONCAT
FLOATP
FIXP
ARRAYP
ARRAYSIZE
ARRAYTYP
ARRAYORIG
ARRAY
ELT
SETA
HARRAYP
HARRAYSIZE
OVERFLOW
HARRAYPROP
HARRAY
(VARIABLE-VALUE-CELL NH . 0)
HCOPYALL1A0012
MAPHASH
READTABLEP
COPYREADTABLE
BITMAP
BITMAPCOPY
TERMTABLEP
COPYTERMTABLE
GETDESCRIPTORS
NCREATE
FETCHFIELD
REPLACEFIELD
(SKNLST BHC MKN MKFN FUNBOX CONSNL GETHSH FMEMB KNIL URET1 SMALLT SKNLA BLKENT ENTER1)  �    f @ b ` =    ; p   (       (   h   0   
` �    8 �     h �    �    �    �       
HPRINTBLOCKA0013 BINARY
    �    �    -.           �Z` �B  �,   ,>  	,>  �Z` B  �,      �,^  �/  �2"  7   Z   ,~     �   (X . 1)
(Y . 1)
ABS
(KT KNIL BHC IUNBOX ENTER2)        x    ` �       
HPRINTBLOCKA0014 BINARY
            �-.          Z` Z   ,   XB  ,~       (V . 1)
(K . 1)
(VARIABLE-VALUE-CELL VALS . 6)
(CONS ENTER2)    8      
HPRINTBLOCK BINARY
          �   �-.          �-.    Ap�    �   $     ,  �,~   -.    �Z   ,<  �@ L  ,~   Z   ,<  �,< �,< N,<   @ � ` �+   �Z   Z PXB Zw,<8 �@ �  +   �,< �,< S" �,   ,   Z  	,   XB  �ZwZ8 �3B   +   �+    Z   B �2B   +   Z  �-,   Z   Z  B �3B   +   �Z  �B T+    ,< �" UXB    �,< VZ   B V,   ,   Z  �,   XB  #,< �Z   B �,   ,   Z  $,   XB  'ZwZ8 �3B   +   �,<8 �,<   ,<   ,<   , $+   I  VB W3B   +   �Zw,<8 �,<   ,<   ,<   , $,  +   I  VXB  !Z   B �,< X  V,   ,<  �,<   ,   Z  (,   XB  �,< �  V,   ,<  �,<   ,   Z  �,   XB  =Zw,<8 �,<   ,<   ,<   , $,    V,   ,   XB`   VB �B YB �,<  �Z  4,<  �,< Z,<` ( �  [Z   ,~   Zw~XB8 Z   ,~   3B   +   �Z   +   OZ �XB` �D \Z` �3B   +   �  �,~   Z` ,~   Zw�Z   3B  +   �Zp  3B   +   \Zw�Z  T,   3B   +   \    ."  �,   XB  �+    Z  [,<  �Z  �,<  ,<   ,  �Zw�XB  ]Z"  �XB  \+     w0"  +   mZp  2B   +   gZw�-,   +   g   +   m w4b  �,> @,>  �,<w�" ],< �" ^>`x  5   i/  +     w0"  +   � w4b  s,> @,>  �,<w�, �>`x  5   �/  +    ,< �" ^,<w" ],< _" ^,<w�,<   ,<   ,<   , $,< �" ^,< `" �+    Z  �,<  �Z  �,<  ,<   ,  �,< �" ^,~     V,   ,   ,<  �Z   ,<  �Z aD �Z ,<  �,<   ,<   ,< `Zw�-,   +  �+  �Z  XBw�  V,<  �ZwB b,   /"  �,   D �Zw�,   5" Z c+  �Z �B d[w�B �,<  �Zp  -,   +  �+  �Zp  ,<  �  V,<  �,<w�$ �,<w" d,< �" d/  �[p  XBp  +  �/  �[w�XBw� p  ."  �,   XBp  +  �Zw/    V,<  �,<w�$ �Z   +         ,<   ,<   ,<   ,<   ,<w�" eXBw�3B �+  �2B f+  �Zw}3B   +  /Zw�3B   +  2,< �" ^,<w�" ]+  2,<w�" ]+  2Z   2B   +  4Zw�Z  �,   +  �Z   XBw�3B   +  RZw}3B   +  �,< g" ^,< �" ^  V,   /"  �,   XBwZ   ,<  ,<    w�0b   +  @Zp  +  �Z"   A"  �Z   ." Z  B d w�&"  ,   XBw�+  �/  Zw�-,   +  N,<w�,<  �,<w~,   Z ,   XB �Z  ,<  �Z �F hZ   +  2,<  �Zw�[w~,      �,\  �QD  +  2Zw}3B   +  VZw�-,   +  V,< �" ^Z �2B   +  d,< `" �,<w�Zw�3B   +  �Zw|-,   +  �  V,   "  �,   +  `  V,   ,   ,<  �Z LF h  <."  � $   @ �+  �Zw~2B   +  �,< `" �Zw�-,   +  |Zw}3B   +  �Zw�,<  �,<   ,<   ,<   , $[w�,<  �,<   ,<   Z   XBw�,\  �XBw�,\  �XBw�,\  �XBw�/  +  $,< i" ^Zw�,<  �,<   ,<   ,<   , $[w�,<  �,<   ,<   ,<   , $,< �" ^+  2Zw�2B   +  Zw�Z   7  �[  Z  Z  1H  +  �2D   +  XBw3B   +  ,< jZ  �D ^[w,<  �,<w|Z �,<  � "  ,   ,<  �,< �" ^,\  �2B   +  2Zw�3B �+  �3B k+  �2B �+  ,<w�" ]+  22B l+  �,<w�" �,<  �Z   ,   ,<  �,<w�" m,<  �@ � `
+  >,< p" ^,<` �" ],< `" �Zw�,<?�" �XB` �B ],< `" �,<` �" ],< `" � ` �4b �,> @,>  �Zw�,<?�,<` �$ q,<  �,<   ,  � ` �."  �,   XB` �>`x  5  �/  Z` �-,   +  �Z` �Z` �,   2B   +  �,<` � ` �."  �,   ,<  �,<    w�,> @,>  � w   �,^  �/  �3b  +  6Zp  +  <Zw},<?�,<w$ �,<  �,<   ,  � w�."  �,   XBw�+  �/  �,  �Z   ,~   +  22B �+  Z   ,   ,<  �@ r  +  �,< t" ^Zw�,<?�" �XB` ,<  �Zw~,<?�,< u$ �,   B ],< `" �  v,   ,> @,>  � `    �,^  �/  �2"  +  n  �,<  �,<`  w�,> @,>  � p     �,^  �/  �2"  +  VZp  +  �Zw�/  B �,<  �@ w  �+  n,< �Z   ,<  �,   ,   Z  >,   XB \XB` ,< y,< N,<   @ � ` +  eZ   Z PXB   �Zw}XB8 �Z   ,~   2B   +  gZ �XB   [` XB ],< �Z` Z  [  D zZ �3B   +  m  �,~   Z` �,~   Zw�,<?�Z �D {Z   g  [  2B   9 q   ,   B ],< `" �,<   Z p2B   +  xZp  +  ~Z �Zw~Z?�,   ,<  �, �Z x,<  �, �[ {XB �+  �/  �,< �" ^Z   ,~   +  22B �+  +Z   ,   ,<  �@ |  +  �,< }" ^,< �,<   ,<   ,<   ,< Z p  ,> @,>  � w~   �,^  �/  �3b  +  �+  �,<p  Zw�,<?�$ ~,<  �,<w�,< �$ ~,\  ,   3B   +  +  Zp  XBw�Zw3B   +  ,<  �Zw,   XBw�,\  QB  +  Zw�,   XBwXBw� p  ."  �,   XBp  +  �Zw�/  �B ],<  �Zp  -,   +  �+  )Zp  ,<  �,<p  Zw},<?�$ ~,<  �,<   ,  �/  �[p  XBp  +  �/  �,  �,~   +  22B +  ,< �" ^,<w�"  3B   +  0,< �, 3Z   ,   ,<  �,<   ,<w�$ 2B   +  �,<   ,<w�$ ,< , 3,\  �,   Z   ,   ,<  �,<   ,<w�$ �2B   +  �,<   ,<w�$ �,<   , 3+  B0B   +  B,< Z,<w�$ �,< Z, 3,\  �,   Z   ,   ,<  �,< ,<w�$ �2B +  I,< " �,< , 3,\  �,   Z   ,<  �Zp  -,   +  M+  �Zp  ,<  �Zp  ,<  �,<w{$ ~[p  ,   2B   +  �Zp  ,<  �, 3Zp  ,<  �,<w{$ ~,<  �, 3/  �[p  XBp  +  K/  �,< �,<   ,< Z p  ,> @,>  � w   �,^  �/  �3b  +  `Zw�+  �,<p  ,<   ,<wz& ,<  �Zw�Z   7  �[  Z  Z  1H  +  �2D   +  d[  2B   +  �Z �,\  3B  +  o,<p  ,<   ,<wz& ,<  �, 3,<p  , 3 p  ."  �,   XBp  +  �/  �Z   ,<  �Zp  -,   +  u+  �Zp  ,<  �[p  ,<  �Zw�,<  �,<   ,<wz& �XBw~,\  ,   2B   +  �Zp  ,<  �, 3,<w�, 3/  �[p  XBp  +  s/  �  ],< �" ^+  22B +  ,< �" ^Zw�,   B ],< �" ^+  22B +  �,< �" ^,< " ^,<w�" �,< �" ^+  2B XBw3B   +  �Z   2B   +  �,< �" ^,<w�" ],< `" �+  !,< 	" ^,<w�" ],< `" �Zw�Z �7  �[  Z  Z  1H  +  �2D   +  2B   +  !,<w�,<w�" ],   Z ,   XB �Z   ,   ,<  �@ �  +  0Zw�,<?�" �,<  �Zp  -,   +  (+  �Zp  ,<  �,<p  Zw},<?�$ ,<  �,<   ,  �/  �[p  XBp  +  &/  �,  �,~   +  2,< �,<w|, �/  ,~   ,<p  " ],< `" �+    ,<p  ,<   ,<   ,<   , $,< " ^+    ,<w�,<   $ ^,< �,<   $ �,<p  ,<   ,<   & ,<p  " ]+      �R!U�@B^h( �@0 8�0&! 	�J7`t�hd\ @Im�	| P! �DcI �
4�wP+\�X$BDBN!^@b�@TD`a($YbxP1a H`HW�N%�A	*@Q S( `J|�oIonR$0$VGFE                         (HPRINTBLOCK#0 . 1)
(VARIABLE-VALUE-CELL LISPXHIST . 13)
(VARIABLE-VALUE-CELL RESETVARSLST . 719)
(VARIABLE-VALUE-CELL HPRINTHASHARRAY . 449)
(VARIABLE-VALUE-CELL HPRINTRDTBL . 74)
(VARIABLE-VALUE-CELL HPRINT.SCRATCH . 105)
(VARIABLE-VALUE-CELL RPTLAST . 249)
(VARIABLE-VALUE-CELL RPTCNT . 247)
(VARIABLE-VALUE-CELL BACKREFS . 405)
(VARIABLE-VALUE-CELL U . 428)
(VARIABLE-VALUE-CELL CELLCOUNT . 454)
(VARIABLE-VALUE-CELL FCHARAR . 386)
(VARIABLE-VALUE-CELL HPRINTMACROS . 508)
(VARIABLE-VALUE-CELL FILE . 526)
(VARIABLE-VALUE-CELL ORIGTERMSYNTAX . 916)
(VARIABLE-VALUE-CELL ORIGECHOCONTROL . 966)
(VARIABLE-VALUE-CELL ORIGDELETECONTROL . 996)
(VARIABLE-VALUE-CELL DATATYPESEEN . 1089)
HPRINT
HPRINT1
*HPRINT*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL FILE . 0)
((UNBOXED-NUM . 4) VARIABLE-VALUE-CELL DATATYPESEEN . 0)
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
(VARIABLE-VALUE-CELL U . 0)
(NIL VARIABLE-VALUE-CELL BACKREFS . 0)
(0 VARIABLE-VALUE-CELL CELLCOUNT . 0)
NIL
RADIX
10
HARRAYP
CLRHASH
100
HASHARRAY
HPINITRDTBL
OUTPUT
SETREADTABLE
RANDACCESSP
OUTFILE
DELFILE
CLOSEF
INFILE
INPUT
0
COPYBYTES
TERPRI
ERROR
RESETRESTORE
ERROR!
PRIN2
% 
PRIN1
"{R"
" "
}
1
SPACES
HPRINTBLOCKA0013
SORT
ABS
SETFILEPTR
`
^
PRIN3
DREVERSE
TYPENAME
SMALLP
LITATOM
" . "
" . "
{% 
PUTHASH
" . "
"("
")"
{
STRINGP
FLOATP
FIXP
ARRAYP
ARRAYSIZE
ARRAYORIG
(0 . 1)
(VARIABLE-VALUE-CELL RPTLAST . 0)
(0 . 1)
(0 VARIABLE-VALUE-CELL RPTCNT . 0)
NIL
"{Y"
ARRAYTYP
ELT
ELTD
(VARIABLE-VALUE-CELL RPTLAST . 0)
(0 VARIABLE-VALUE-CELL RPTCNT . 0)
(NIL VARIABLE-VALUE-CELL VALS . 762)
NIL
"{H"
HARRAYSIZE
OVERFLOW
HARRAYPROP
GCTRP
MINFS
(VARIABLE-VALUE-CELL OLDVALUE . 692)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 725)
((DUMMY) . 0)
RECLAIM
APPLY
HPRINTBLOCKA0014
MAPHASH
READTABLEP
(VARIABLE-VALUE-CELL RPTLAST . 0)
(0 VARIABLE-VALUE-CELL RPTCNT . 0)
"{D"
127
GETSYNTAX
ORIG
TERMTABLEP
"{T"
GETCONTROL
CONTROL
ECHOMODE
RAISE
ECHO
DELETECONTROL
NOECHO
31
ECHOCONTROL
UPARROW
VAG
"{#"
BITMAP
"{("
"READBITMAP)"
PRINTBITMAP
GETFIELDSPECS
"{~"
"{$"
(VARIABLE-VALUE-CELL RPTLAST . 0)
(0 VARIABLE-VALUE-CELL RPTCNT . 0)
GETDESCRIPTORS
FETCHFIELD
"cannot print this item"
" "
2
PRINT
(CONSS1 INTERRUPTABLE EQUAL SKI EVCC FIXT GETHSH URET1 GUNBOX IUNBOX SKNLST URET3 BHC SMALLT SKNLA ASZ URET2 EQP MKN FGFPTR LIST2 KT
 SKLST CONS CONSNL ALIST2 CF KNIL BINDB BLKENT ENTER1)  D    9(� 889 7 �   � :   +   �   �   � @   G 6 @   p   )8�   � >H� 4 U x     @ t X   F0� EX� ?x� ;h� :x* 5   1H *x� )h= &H* 8� � ( � P   p   `   7xA    H b H   %P Y   � > .@� & ( � P< p�   � @    � 0� 8   +@J X 9   � G`� G0 7`� 78� ,P� x� 	H -   h @    ! +X� 0 �   � H    � 38� 08� ( x � @   ) < x ' 0 �   b `   G � Fp� D � CH� ?@y =Hi <x� ;(R 8@: 75 6@1 5p' 2h� 1 0x 0w .`� -@f , � '`� &� $`� !@  (� (z p� xo Hl 8� X� x� `> x6 P2 H+ h& X% 8� ` �  �   � p � 
p � 	h � 	( �  � P � ( 2  � H , (  8 � p     �    �       
HPRINT BINARY
            �-.            ,<    �,~       (EXPR . 1)
(FILE . 1)
(UNCIRCULAR . 1)
(VARIABLE-VALUE-CELL DATATYPESEEN . 0)
HPRINT
(NIL)
(LINKED-FN-CALL . HPRINTBLOCK)
(ENTERF)     
HPRINT1 BINARY
                �-.            ,<    �,~       (X . 1)
(CDRFLG . 1)
(NOMACROSFLG . 1)
(NOSPFLG . 1)
HPRINT1
(NIL)
(LINKED-FN-CALL . HPRINTBLOCK)
(ENTER4)      
MAKEHVPRETTYCOMS BINARY
           �    -.      �    �   �,<` �Zp  -,   +   �+   Zp  ,<  �Zp  -,   +   	,<  �,<  ,<   &  �/  �[p  XBp  +   �/  �,<  Z  �Z` �,   ,   ,<  �,<  Z` 3B   +   �Z"   Z` �,   +   Z` �Z  �,   ,   ,   ,~   a(X$P    (VARS . 1)
(FLG . 1)
HPINITRDTBL
"invalid in HORRIBLEVARS"
ERROR
P
READVARS
E
HPRINT0
(CONS21 ASZ KNIL ALIST2 CONS BHC KT SKNLA SKNLST ENTER2)   �    �    �    � P �    � `   @ 
    	               
READVARS BINARY
               -.      �      @  �  ,~   ,<   Z   D  3B  �+   �   Zw,<8 �Zp  -,   +   �+   �Zp  ,<  �Zp  -,   +   �,<  �,<   Z  D  �,<  �,<   &  /  �[p  XBp  +   �/  �,<   Z  D  3B  �+      Z   ,~       (VARS . 1)
(VARIABLE-VALUE-CELL HPRINTRDTBL . 37)
HPINITRDTBL
(NIL VARIABLE-VALUE-CELL BACKREFS . 0)
(0 VARIABLE-VALUE-CELL BACKREFCNT . 0)
(NIL VARIABLE-VALUE-CELL DATATYPESEEN . 0)
RATOM
%(
HVREADERR
READ
SAVESET
%)
(BHC KT SKLA SKNLST KNIL ENTER1)  �    x   @      `  X �       
HPINITRDTBL BINARY
    �        �-.            Z  Z 7@  7   Z  B  �3B   +   �Z   ,~   Z   ,<  "  �,<  �,<  ,<  �Z  ,   ,<  �,<w&  �,<  ,<  �Z  ,   ,<  �,<w&  �,<  �,<  �Z   ,   ,<  �,<w&  �,<  �,<  !,<w&  �,<  �,<  !,<w&  �,<  ,<w�$  "/  �Z   ,~   (n;Z   HPRINTRDTBL
READTABLEP
ORIG
COPYREADTABLE
94
MACRO
HVFWDREAD
SETSYNTAX
96
INFIX
HVFWDCDREAD
123
HVBAKREAD
0
SEPR
125
/SETATOMVAL
(BHC ALIST2 KT KNIL KNOB ENTER0)        � 0     �    �  X    @      
HVFWDCDREAD BINARY
       �    �    -.          �,<` �,<   $      ."  �,   XB  [` �Z   ,   XB  �Z  �,<  �,<` �,<` $  �,\  XB  Z` �,~      (FILE . 1)
(RDTBL . 1)
(TCONCPTR . 1)
(VARIABLE-VALUE-CELL BACKREFCNT . 9)
(VARIABLE-VALUE-CELL BACKREFS . 14)
TCONC
READ
(CONS MKN KNIL ENTER3)                  

HVBAKREAD BINARY
   V   �   �-.         (�@ �  8,~   Zw,<8 �,<8 $ /Zw,<8 �" �XB` �2B 0+   Zw,<8 �,<8 $ /Zw,<8 �" �2B �+   +     1+  $2B �+   �Zw,<8 �,<8 $ /2B 2+   Z �,<  �Zw�,<8 �,<8 $ 3D �+   �Zw,<8 �,<8 $ 4B �XB` �ZwZ8 �3B   +   Z` �XD  Zw,<8 �,<8 $ 4,   4b  (,> ',>  �Zw,<8 �,<8 $ 3XB` �Zw,<8 �,<8 $ 3,<  �,<` �,<` �& 5>`x  5    /  Zw,<8 �,<8 $ �+  $3B 6+   �2B �+   �Zw,<8 �,<8 $ 3XB` ,<  �Zw�,<8 �,<8 $ 3XB` �,<  �,<   Z` �2B �+   7Zw�,<8 �,<8 $ 3+   �Z"  �XB` H 7XB` �ZwZ8 �3B   +   <Z` �XD  ,<` �" �,   4b  F,> ',>  �,<` �,<` Zw~,<8 �,<8 $ 8F � ` ."  �,   XB` >`x  5   ?/  Z` �-,   +   ^ ` ,> ',>  � ` �   �,^  �/  �3B  +   ^Z` �3B �+   OZ` �1B   +   ^,<`  ` �."  �,   ,<  �,<    w�,> ',>  � w   �,^  �/  �3b  +   �Zp  +   �,<` �,<wZw�,<8 �,<8 $ 8F 9 w�."  �,   XBw�+   R/  �Zw,<8 �,<8 $ �+  $3B �+   �2B :+  Zw,<8 �,<8 $ 4XB` Z` �2B :+   �,<` " �XB` �+   �Z` Z   7  �[  Z  Z  1H  +   �2D   +   j[  XB` �2B   +   �Zw,<8 �,<8 $ 3XB` �,<` " ;3B   +   y,<` �,<` " ;,\  ,   2B   +   y,< �,<` $ <,<` ,<` ,<` �$ �XB` �,   Z  i,   XB  |,<` " =XB` �ZwZ8 �3B   +  Z` �XD  ,<` �Zp  -,   +  �+  Zp  ,<  �,<p  ,<` �Zw},<8 �,<8 $ 8F �/  �[p  XBp  +  �/  �Zw,<8 �,<8 $ �+  $2B >+  �ZwZ8 �3B   +  �  1Z   ,~   2B �+  �Zw,<8 �,<8 $ 4,   ,<  �Zw�,<8 �,<8 $ �,\  �,~   2B ?+  �Zw,<8 �,<8 $ 4B �,~   2B @+  1,< �" AXB` �ZwZ8 �3B   +  #Z` �XD  ,<8 �,<8 $ 3,<  �Zp  -,   +  '+  .Zp  ,<  �,<p  Zw�,<8 �,<8 $ 8,<  �,<` �& �/  �[p  XBp  +  %/  �Zw,<8 �,<8 $ �+  $2B   +  �,< �" BXB` �ZwZ8 �3B   +  �Z` �XD  ,<   Zw�,<8 �,<8 $ 4XB` �2B   +  �Zp  +  �2B �+  �,<   ,<` �$ �+  k2B C+  �,<   ,<` �$ C+  k3B �+  �3B D+  �3B �+  �2B E+  JZw�,<8 �,<8 $ 3,<  �,<` �,<` �& �+  k3B F+  O3B �+  O3B G+  O3B �+  O2B H+  �Zw�,<8 �Z   D 3,<  �Zp  -,   +  �+  �Zp  ,<  �,<p  ,<` �,<` �& �/  �[p  XBp  +  �/  �+  k3B �+  �3B I+  �3B �+  �3B J+  �2B �+  c,<  �Zw~,<8 �,<8 $ 3,<  �,<` �& K+  k3B   +  e0B   +  g,<  �,<` �$ �+  k2B L+  �,< L,<   ,<` �& K+  k  1+  7/  �Zw,<8 �,<8 $ �+  $1B   +  �1B  �+  �1B  +  �1B  �+  �1B  +  �1B  �+  �1B  +  �1B  �+  �1B  +  �0B  �+  �ZwZ8 �3B   +  {  1Z` �XB` �,<   Zw�,<8 �" �XB` �"   +  �Zp  +   ` �$"  ,> ',>  � ` �.Bx  ,^  �/  �,   XB` �+  �/  �Z   ,<  �    ,> ',>  � ` �   �,^  �/  �/  ."  �   �,\  �5d    �Z   ,   +  [  2B   =d �Z  2B   +  �  1,~   2B 2+  �Zw,<8 �,<8 $ 3,<  �Zw�,<8 �,<8 $ 4,\  �,<  �Zw�,<8 � "  �,   ,<  �Zw�,<8 �,<8 $ �,\  �XB` �ZwZ8 �3B   +  �Z` �XD  Z` �,~     1Z   1B   +  �  1+  �,~     �b?�CFEqd0@Y @Paq@Q	$4 BD3�0nsgxF_~	T�pjU*F	$6@N             (FILE . 1)
(RDTBL . 1)
(BKRF . 1)
(VARIABLE-VALUE-CELL DATATYPESEEN . 250)
(VARIABLE-VALUE-CELL HPRPTSTRING . 291)
(VARIABLE-VALUE-CELL FILERDTBL . 416)
(VARIABLE-VALUE-CELL BACKREFS . 525)
(VARIABLE-VALUE-CELL BACKREFCNT . 527)
NIL
NIL
NIL
NIL
(0 VARIABLE-VALUE-CELL RPTCNT . 584)
(NIL VARIABLE-VALUE-CELL RPTVAL . 0)
NIL
SKIPSEPRS
READC
}
{
HVREADERR
H
%(
HASHARRAY
READ
APPLY
RATOM
HARRAY
PUTHASH
HVREADEND
A
Y
ARRAY
ARRAYSIZE
HVRPTREAD
SETA
SETD
$
~
GETDESCRIPTORS
GETFIELDSPECS
"attempt to read DATATYPE with different field specification than currently defined"
ERROR
/DECLAREDATATYPE
NCREATE
REPLACEFIELD
R
#
!
AT2VC
D
ORIG
COPYREADTABLE
SETSYNTAX
COPYTERMTABLE
CONTROL
ECHOMODE
UPARROW
IGNORE
REAL
SIMULATE
ECHOCONTROL
CTRLV
RETYPE
LINEDELETE
CHARDELETE
EOL
DELETELINE
1STCHDEL
NTHCHDEL
POSTCHDEL
EMPTYCHDEL
DELETECONTROL
RAISE
NOECHO
(EVCC SMALLT KT GUNBOX SKNLST CONS CONSS1 EQUAL SKI MKN ASZ BHC IUNBOX KNIL ENTER3) #H   x   @�     h   0� @   !x �    �    w    �   � P � H   $X� x� X� 8� � xe 	p 8   �  p H� x/ P   � 
` � h �    > p   $� " P� � (� X"  x t x � 
( ; 8        
HVRPTREAD BINARY
          �    -.          �    1b   +      �/"  �,   XB  Z   ,~   ,<` �,<` $  XB  Z   2B  +   ,<` �,<` $  XB  �,<` �,<` $  XB  �,<` �,<` $  �+   � DD0     (FILE . 1)
(RDTBL . 1)
(VARIABLE-VALUE-CELL RPTCNT . 22)
(VARIABLE-VALUE-CELL RPTVAL . 26)
(VARIABLE-VALUE-CELL HPRPTSTRING . 16)
READ
HVREADEND
(MKN ENTER2)   P      
HVFWDREAD BINARY
    �    �    (-.          �,<   ,<       ."  �,   XB  �Z   Z   ,   XB  ,<` �"  �XBw�2B  $+   Z  ,<  Z   ,   ,\  XB  Z  	,<  �,<` �,<` $  �   �,\  �    D  +    3B  %+   2B  �+   �,<` �"  &+   �2B  �+   �,<` �"  &,<` �,<` Z  XBw�F  'XBp  Zw�2B   +   �   �Zp  +    Z  �,<  ,<` �,<` $  �   �,\  �XD  Z  +     X �o!      (FILE . 1)
(RDTBL . 1)
(VARIABLE-VALUE-CELL BACKREFCNT . 8)
(VARIABLE-VALUE-CELL BACKREFS . 57)
PEEKC
%(
READ
%

% 
READC
{
HVBAKREAD
HVREADERR
(URET2 CONSNL CONS MKN KNIL ENTER2)         8    h    H   0   X   (      
HREAD BINARY
            �    �-.          �,<` �"  �B  �,<  �@    ,~   Z   B  2B   +   �   �,<` �Z  D  ,~   EH  (FILE . 1)
(VARIABLE-VALUE-CELL HPRINTRDTBL . 16)
INPUT
(0 . 1)
(NIL VARIABLE-VALUE-CELL BACKREFS . 0)
(0 VARIABLE-VALUE-CELL BACKREFCNT . 0)
(NIL VARIABLE-VALUE-CELL DATATYPESEEN . 0)
READTABLEP
HPINITRDTBL
READ
(KNIL ENTER1)          
HPRINT0 BINARY
                -.      �    Z` �0B   +   [` �+   �Z` �,<  �,<   Zw�-,   +   Zp  Z   2B   +   
 "  +   �[  QD   "  +   �Zw�,<  �Zp  -,   +   �,<  �,<  �,<   &  Zp  Z 7@  7   Z  /  �Zp  ,   XBp  [w�XBw�+   �/  ,<  �,<   Z` �0B   7   Z   F  �,~   A
T    (VARS . 1)
"not a var, in HORRIBLEVARS"
ERROR
HPRINT
(COLLCT BHC KNOB KT SKNLA SKNLST KNIL ASZ ENTER1)       � @   0   ( �    �          	      �  0      
HVREADERR BINARY
    
        �-.           Z` �2B   +   �Z  ,<  �Z` 2B   +   Z  �D  	,~      (M1 . 1)
(M2 . 1)
"incorrect format on file"
((in HREAD) . 0)
ERROR
(KNIL ENTER2)   �  0      
HVREADEND BINARY
    �    �    �-.           �@  �  ,~   Z   B  �B  XB   0B  �+   Z` �,~      �A"  �,>  ,>  �Z   B  �.Bx  ,^  �/  �."  [  A"   0B   +   �   +     �d`     (VARIABLE-VALUE-CELL FILE . 6)
(VARIABLE-VALUE-CELL RDTBL . 18)
NIL
(NIL VARIABLE-VALUE-CELL CHAR . 14)
READC
CHCON1
GETREADTABLE
HVREADERR
(BHC ASZ ENTERF)  @    `      
(PRETTYCOMPRINT HPRINTCOMS)
(RPAQQ HPRINTCOMS ((FNS MAKEHVPRETTYCOMS READVARS HPRINT0) (FILEPKGCOMS HORRIBLEVARS UGLYVARS) (FNS HPRINT HPRINT1 HPRINTEND 
RPTPRINT RPTEND RPTPUT HPRINTSP HPERR HVFWDCDREAD HVBAKREAD HVREADEND HVRPTREAD HVFWDREAD HREAD HPINITRDTBL HVREADERR HPRINSP) (FNS 
COPYALL HCOPYALL HCOPYALL1) (FNS EQUALALL EQUALHASH) (BLOCKS (COPYALL COPYALL (NOLINKFNS . T) (GLOBALVARS SYSHASHARRAY)) (EQUALALL 
EQUALALL EQUALHASH (RETFNS EQUALHASH) (NOLINKFNS . T) (GLOBALVARS SYSHASHARRAY)) (NIL HCOPYALL (LOCALVARS . T)) (HCOPYALL1 HCOPYALL1
 (NOLINKFNS . T) (GLOBALVARS SYSHASHARRAY)) (HPRINTBLOCK HPRINT RPTPRINT RPTPUT RPTEND HPRINTEND HPRINT1 HPRINSP HPRINTSP HPERR (
LOCALFREEVARS DATATYPESEEN BACKREFS CELLCOUNT RPTLAST RPTCNT U) (NOLINKFNS . T) (GLOBALVARS SYSHASHARRAY FCHARAR) (ENTRIES HPRINT 
HPRINT1)) (NIL MAKEHVPRETTYCOMS READVARS HPINITRDTBL HVFWDCDREAD HVBAKREAD HVRPTREAD HVFWDREAD HREAD HPRINT0 HVREADERR (NOLINKFNS . 
T) (LOCALVARS . T) (SPECVARS BACKREFS BACKREFCNT DATATYPESEEN RPTCNT RPTVAL) (GLOBALVARS FILERDTBL))) (GLOBALVARS HPRINTHASHARRAY 
HPRINTRDTBL HPBAKCHAR HPFORWRDCDRCHR HPFORWRDCHR HPFILLCHAR HPFINALCHAR HPFILLSTRING HPRPTSTRING CIRCLMARKER DONTCOPYDATATYPES 
ORIGTERMSYNTAX ORIGECHOCONTROL ORIGDELETECONTROL HPRINTMACROS) (DECLARE: EVAL@COMPILE DONTCOPY (VARS HPFORWRDCHR HPFORWRDCDRCHR 
HPBAKCHAR HPFILLCHAR HPFINALCHAR (HPFILLSTRING (PACKC (LIST HPBAKCHAR HPFILLCHAR)))) (PROP MACRO HPRINTSTRING HPRINTENDSTR)) (VARS (
HPRINTMACROS) (HPRINTHASHARRAY) (HPRINTRDTBL) (HPRPTSTRING "<repeat>") (DONTCOPYDATATYPES) ORIGDELETECONTROL ORIGTERMSYNTAX 
ORIGECHOCONTROL (HPRINT.SCRATCH (SELECTQ (SYSTEMTYPE) ((TENEX TOPS20) (QUOTE HPRINT.SCRATCH;T)) (D (QUOTE {CORE}HPRINT.SCRATCH;1)) (
QUOTE HPRINT.SCRATCH)))) (ADDVARS (GAINSPACEFORMS ((OR HPRINTHASHARRAY HPRINTRDTBL) "discard HPRINT initialization" (PROGN (CLRHASH 
HPRINTHASHARRAY) (SETQ HPRINTHASHARRAY (SETQ HPRINTRDTBL)))))) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS
 (NLAMA HPRINT0 READVARS) (NLAML MAKEHVPRETTYCOMS) (LAMA)))))
(PUTDEF (QUOTE HORRIBLEVARS) (QUOTE FILEPKGCOMS) (QUOTE ((COM MACRO (X (COMS * (MAKEHVPRETTYCOMS X))) CONTENTS (LAMBDA (COM NAME 
TYPE) (AND (EQ TYPE (QUOTE VARS)) (INFILECOMTAIL COM)))))))
(PUTDEF (QUOTE UGLYVARS) (QUOTE FILEPKGCOMS) (QUOTE ((COM MACRO (X (COMS * (MAKEHVPRETTYCOMS X T))) CONTENTS (LAMBDA (COM NAME TYPE)
 (AND (EQ TYPE (QUOTE VARS)) (INFILECOMTAIL COM)))))))
(RPAQQ HPRINTMACROS NIL)
(RPAQQ HPRINTHASHARRAY NIL)
(RPAQQ HPRINTRDTBL NIL)
(RPAQ HPRPTSTRING "<repeat>")
(RPAQQ DONTCOPYDATATYPES NIL)
(RPAQQ ORIGDELETECONTROL ((DELETELINE . "##
") (1STCHDEL . "\") (NTHCHDEL . "") (POSTCHDEL . "\") (EMPTYCHDEL . "##
")))
(RPAQQ ORIGTERMSYNTAX ((CTRLV 22) (RETYPE 18) (LINEDELETE 17) (CHARDELETE 1) (EOL 31)))
(RPAQQ ORIGECHOCONTROL ((0 . IGNORE) (1 . IGNORE) (7 . REAL) (8 . UPARROW) (9 . SIMULATE) (10 . REAL) (13 . REAL) (17 . IGNORE) (18 
. IGNORE) (27 . SIMULATE) (31 . REAL)))
(RPAQ HPRINT.SCRATCH (SELECTQ (SYSTEMTYPE) ((TENEX TOPS20) (QUOTE HPRINT.SCRATCH;T)) (D (QUOTE {CORE}HPRINT.SCRATCH;1)) (QUOTE 
HPRINT.SCRATCH)))
(ADDTOVAR GAINSPACEFORMS ((OR HPRINTHASHARRAY HPRINTRDTBL) "discard HPRINT initialization" (PROGN (CLRHASH HPRINTHASHARRAY) (SETQ 
HPRINTHASHARRAY (SETQ HPRINTRDTBL)))))
(PUTPROPS HPRINT COPYRIGHT ("Xerox Corporation" 1982 1983 1984))
NIL
