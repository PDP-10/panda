(FILECREATED "14-FEB-83 23:02:06" ("compiled on " <LISPUSERS>PERFORMTRAN.;9) (2 . 2) recompiled exprs:
 PERFORMTRAN in USYS dated "23-JAN-83 16:22:07")
(FILECREATED "14-FEB-83 23:01:54" <LISPUSERS>PERFORMTRAN.;9 5117 changes to: (FNS PERFORMTRAN) 
previous date: " 4-SEP-81 21:44:36" <LISPUSERS>PERFORMTRAN.;8)
PERFORMOPSTRAN BINARY
      �    �    �-.           �[` �Z  -,   7   7   +   �[` �XB` �Z  ,   Z  !,   ,<  �,<  �,<  ",   ,<  �,<  !,<  �[` �,<  �,<   Zw�-,   +   Zp  Z   2B   +    "  +   �[  QD   "  +   Zw�,<  �Zp  ,<  �[w�3B   +   3B   +   -,   +   ,<  �,<  �,   ,   /  �Zp  ,   XBp  [w�XBw�+   �/  ,   ,   D  #,~   !A
 +  (DECL . 1)
ACCESSFNS
PERFORMOPS
DATUM
QUOTE
NCONC
(ALIST3 COLLCT BHC ALIST2 SKNNM SKNLST LIST2 CONS21 CONSNL KT KNIL SKLA ENTER1) x   H   p �      0      `   ( 
            �  H   h  x   @    8      

PERFORMTRAN BINARY
     s    �    �-.           �Z` 3B   +   Z  �Z` �,   XB` �Z` 2B   +   Z   ,<  �@  �   ,~   Zw[8 �Z  ,<  �,<   ,<   ,<   Zw�-,   +   B  `+   %,<   ,<   ,<   ,<  �Zp  2B   +   +   $ p  ."  �,   XBp  ,<w�,<  �,<  a,<w{F  �XBw3B   +    w/"  �,   +   �Z   F  bXBw�Zw3B   +   �,<  �Zw,   XBw�,\  QB  +   �Zw�,   XBwXBw�+   Zw�/  XBw�B  �XBw�Z  XBw,<  c,<w$  �,<  d,<   ,<   @  � ` �+   �Z   Z  fXB Zw�,<?�"  �+    Z  XBp  2B   +   �,<wZ   D  g[  XBp  3B   +   �Z  �3B   +   �,<  �Z   ,<  ,<  h&  �,<  �,<   $  iZ  52B   +   DZp  -,   +   D,<  �Z  7,<  ,<  j&  �,<  �,<   $  iZw},<8 �,<   $  �   kZw}Z8 2B   +   K[8 �[  ,<  �Zw�,<8 �,<   ,<   ,<   Z  >L  �Zp  ,<  �Zw�[8 �[  ,<  �[wB  lF  �XBp  Zw}Z8 3B   +   W,<  m,<w~,<  �Zw�-,   +   VZ  n,   ,   +    Z   3B   +   Z,<8 �,<  �$  �Zw},<8 �,<w�$  o+     b`)
�Y(B"f$f#C&�         (FORM . 1)
(MASTERSCOPEFLAG . 1)
(VARIABLE-VALUE-CELL DWIMESSGAG . 117)
(VARIABLE-VALUE-CELL PERFORMOPS . 100)
(VARIABLE-VALUE-CELL FAULTFN . 148)
(VARIABLE-VALUE-CELL LCASEFLG . 174)
perform
APPEND
0
"."
STRPOS
SUBATOM
LAST
PERFORMOPS
ATTACH
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
RECORDACCESS
ASSOC
"{in "
"}  Using global perform definition
"
CONCAT
LISPXPRIN1
" {in "
"}  Undefined PERFORM operator in form
	"
LISPXPRINT
ERROR!
DWIMIFY0?
MKPROGN
SUBPAIR
fetch
of
ppe
RPLACA
CLISPTRAN
(URET4 ALIST4 SKNLST KT CF BHC CONSNL MKN SKLST CONS KNIL ENTER2)   ] 
x   
p   
P �    �  �    -    �    �   #     0             � 
  � 	  � ` < h 5  + (  @  (    P � @ �  0      
PT.RECREDECLARE1 BINARY
       �    �    -.          �Z` 3B  
+   2B  �+   �,<` ,<   Z   F  ,~   ,<` �,<` $  �,~   D   (TRAN . 1)
(ORIG . 1)
(VARIABLE-VALUE-CELL CLISPARRAY . 10)
perform
PERFORM
/PUTHASH
PT.OLDRECREDECLARE1
(KNIL ENTER2)  X      
(PRETTYCOMPRINT PERFORMTRANCOMS)
(RPAQQ PERFORMTRANCOMS ((LOCALVARS . T) (FNS PERFORMOPSTRAN PERFORMTRAN PT.RECREDECLARE1) (P (MOVD? (
QUOTE RECREDECLARE1) (QUOTE PT.OLDRECREDECLARE1)) (MOVD (QUOTE PT.RECREDECLARE1) (QUOTE RECREDECLARE1)
)) (PROP CLISPWORD PERFORM perform) (ADDVARS (CLISPRECORDTYPES PERFORMOPS) (PERFORMOPS)) (P (MOVD (
QUOTE RECORD) (QUOTE PERFORMOPS)) (SETTEMPLATE (QUOTE PERFORM) (QUOTE (MACRO ARGS (PERFORMTRAN ARGS T)
))) (SETTEMPLATE (QUOTE perform) (GETTEMPLATE (QUOTE PERFORM))) (SETSYNONYM (QUOTE PERFORM) (QUOTE 
FETCH) T) (SETSYNONYM (QUOTE PERFORMS) (QUOTE FETCHES) T) (SETSYNONYM (QUOTE PERFORMING) (QUOTE 
FETCHING) T) (SETSYNONYM (QUOTE PERFORMED) (QUOTE FETCHED) T)) (PROP USERRECORDTYPE PERFORMOPS)))
(MOVD? (QUOTE RECREDECLARE1) (QUOTE PT.OLDRECREDECLARE1))
(MOVD (QUOTE PT.RECREDECLARE1) (QUOTE RECREDECLARE1))
(PUTPROPS PERFORM CLISPWORD (PERFORMTRAN . perform))
(PUTPROPS perform CLISPWORD (PERFORMTRAN . perform))
(ADDTOVAR CLISPRECORDTYPES PERFORMOPS)
(ADDTOVAR PERFORMOPS)
(MOVD (QUOTE RECORD) (QUOTE PERFORMOPS))
(SETTEMPLATE (QUOTE PERFORM) (QUOTE (MACRO ARGS (PERFORMTRAN ARGS T))))
(SETTEMPLATE (QUOTE perform) (GETTEMPLATE (QUOTE PERFORM)))
(SETSYNONYM (QUOTE PERFORM) (QUOTE FETCH) T)
(SETSYNONYM (QUOTE PERFORMS) (QUOTE FETCHES) T)
(SETSYNONYM (QUOTE PERFORMING) (QUOTE FETCHING) T)
(SETSYNONYM (QUOTE PERFORMED) (QUOTE FETCHED) T)
(PUTPROPS PERFORMOPS USERRECORDTYPE PERFORMOPSTRAN)
NIL
   