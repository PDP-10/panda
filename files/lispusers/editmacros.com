(FILECREATED "26-SEP-83 06:02:26" ("compiled on " <LISPUSERS>EDITMACROS.;11) (2 . 2) bcompl'd in WORK 
dated "19-JUN-83 15:13:55")
(FILECREATED "23-SEP-83 13:40:58" {PHYLUM}<LISPUSERS>EDITMACROS.;11 9384 changes to: (FNS 
\EDIT.BQUOTIFY \EDIT.PREPARESWITCH \EDIT.BQUOTIFY.1) (VARS EDITMACROSCOMS) (USERMACROS BQUOTE) 
previous date: " 3-JUL-83 07:19:03" {PHYLUM}<LISPUSERS>EDITMACROS.;9)

\EDIT.CONDCLAUSES.TO.IF BINARY
       R    G    �-.           G@  �  ,~   Z   B  �,   /"  �,   ,<  �,<   ,<   Z"  �XBp   p  ,>  �,>  � w   �,^  �/  �3b  +   +   �Z  [  2B   +   �,<  IZ  Z  ,<  �[  �3B   +   [  B  �+   �Z   ,   ,<  �Z  JZ   ,   ,   XB  +   �Z  �[  B  �,<  �,<  KZ  �Z  ,<  �,<  �,   ,<  �Z  �F  LXB  Z  ,<  �[  �XB  �,\  � p  ."  �,   XBp  +   Z  ![  2B   +   �Z  �Z  ,<  �Z  JZ  ,   ,   +   �Z  �[  B  �,<  �Z  �Z  B  �3B   +   3Z  �Z  B  M3B   +   3Z  J,   +   6,<  KZ  /Z  ,<  �,<  �,   ,<  �Z  �F  LXB  �Zw�/  �Z  �B  �XB  9Z  :2B  J+   �[  �[  3B   +   �Z  <,<  �,<  N$  �+   �[  >Z  XB  �+   �2B  �+   �Z  �,<  �,<  O$  �Z  �,~     �@0XB(D D""K1L'0     (VARIABLE-VALUE-CELL X . 103)
(NIL VARIABLE-VALUE-CELL L . 139)
(NIL VARIABLE-VALUE-CELL TEM . 0)
LENGTH
OR
\EDIT.CONDCLAUSES.TO.IF
else
REVERSE
then
elseif
NCONC
CONSTANTEXPRESSIONP
EVAL
DREVERSE
PROGN
RPLACA
if
(CONSNL LIST3 CONSS1 CONS ALIST3 BHC ASZ KNIL MKN IUNBOX ENTERF)  0   h     �       �    �    � @       ` � p � P � p �  p   @            

\EDIT.IF.TO.CONDCLAUSES BINARY
     �    �    N-.           �Z   B  F3B  �+      GZ  �,<  �[  XB  ,\  �Z  �,<  �[  �XB  �,\  �,   ,<  �@  �  (,~   ,<   Z  -,   +   +   �Z  ,<  �[  XB  ,\  �XB   -,   +   B  F+   �Z   XB   Z   2B   +   Z  �3B  �+   -2B  K+   �+   -Z  �Z   ,   XB  +   92B  �+   �Z  �2B  �+   Z   XB  +   92B  L+   �Z  KXB  Z  Z   ,   XB  �Z   XB  !+   9   G+   92B  K+   �Z  3B  �+   -2B  K+   �+   -   G3B   +   9+   -   �3B   +   9Z  �B  MZ  �,   XB  .Z  �2B  �+   �Z   Z  �,   Z  /,   XB  �+   �Z  �,<  �[  �XB  �,\  �,   XB  -Z  �XB  �+   Z  �2B   +   >Z  �B  MZ  �,   XB  <+   B2B  �+   @   G+   B2B  K+   �+   B   �Zp  /  �Z  =B  MZ  �,   ,~   @�a>g@}}j?q@     (VARIABLE-VALUE-CELL X . 108)
U-CASE
IF
ERROR
(VARIABLE-VALUE-CELL CLAUSE . 118)
(THEN VARIABLE-VALUE-CELL CONDITIONFLG . 115)
(NIL VARIABLE-VALUE-CELL ITEM . 49)
(NIL VARIABLE-VALUE-CELL UITEM . 95)
(NIL VARIABLE-VALUE-CELL L . 134)
(NIL VARIABLE-VALUE-CELL TEM . 0)
ELSE
ELSEIF
THEN
THENRET
SHOULDNT
DREVERSE
COND
(CONS21 BHC KT CONS SKLA SKNLST KNIL CONSNL ENTERF)  X   8       X 4 0 � 0 �        �    ; P + @ � X  H     
       

\EDIT.PREPARECOPY BINARY
      �    7    �-.           7Z   ,<  �,<   ,<   ,<   Zw�XB  �Z  �-,   +   Z  2B  �+   �+   Z  �XBp  Zw�3B   +   �,<  �Zw�,   XBw,\  QB  +   �Zp  ,   XBw�XBw[  �XB  �+   Z  ,<  �[  XB  ,\  �Zw/  ,<  �Z  �,<  �[  XB  ,\  �,<  �Z  �,<  �@  8 ` ,~   Z   3B   +    Z   2B   +   !Z   2B   +   !Z  �,~   ,<  :Z  3B   +   �Z  �Z  �,   ,   +   &Z   ,<  �,<  ;Z  �3B   +   +Z  �Z  ',   ,   +   �Z   ,<  �,<  �,<  <Z  �2B  �+   �Z  =+   0Z  �,<  �,<  >,<  �Z  -,<  �,<  ?,   ,   ,   ,   ,<  �,<  �.  @,~   p@�  IS1v�@    (VARIABLE-VALUE-CELL LL . 50)
TO
(VARIABLE-VALUE-CELL FROM.LOCATOR . 71)
(VARIABLE-VALUE-CELL I.OP . 99)
(VARIABLE-VALUE-CELL TO.LOCATOR . 82)
(((E (QUOTE ?))) . 0)
((BIND MARK) . 0)
LC
(((MARK #1) (S #3) _) . 0)
(((MARK #2)) . 0)
IF
N
((AND (LISTP (CAR #1)) (MEMB (CAR #1) #2)) . 0)
((AND (LISTP (CAR #1)) (MEMB (CAR #1) (CDR #2))) . 0)
(((E (QUOTE (NESTED LOCATIONS)))) . 0)
I
((COPY #3) . 0)
((__) . 0)
APPEND
(ALIST4 LIST3 CONS BHC CONSNL SKLST KNIL ENTERF) P   @   ( %        � H + X  P    h   @ � h #   � P   H   8      

\EDIT.PREPARESWITCH BINARY
       �    +    1-.           +Z   ,<  �,<   ,<   ,<   Zw�XB  �Z  �-,   +   �Z  ,<  �,<  �$  ,3B   +   
+   �Z  �XBp  Zw�3B   +   ,<  �Zw�,   XBw,\  QB  +   Zp  ,   XBw�XBw[  
XB  +   Z  �,<  �[  �XB  �,\  �Zw/  ,<  �Z  ,<  �@  � @ ,~   Z   2B   +   Z   2B   +   Z  �,~   ,<  .Z  3B   +   �Z  �Z  �,   ,   +   #Z   ,<  �,<  /Z  �3B   +   (Z  �Z  $,   ,   +   �Z   ,<  �,<  �,<  0,  �,~   6i�N   (VARIABLE-VALUE-CELL LL . 47)
((WITH TO) . 0)
MEMB
(VARIABLE-VALUE-CELL FROM.LOCATOR . 65)
(VARIABLE-VALUE-CELL TO.LOCATOR . 76)
(((E (QUOTE ?))) . 0)
((BIND MARK) . 0)
LC
(((MARK #1) _) . 0)
(((IF (OR (AND (LISTP (CAR #1)) (FMEMB (CAR #1) (CDR L))) (AND (LISTP (CAR L)) (FMEMB (CAR L) (CDR #1)
))) ((E (QUOTE (NESTED LOCATIONS)))) (UP (MARK #2) (\ #1) UP (I 1 (PROG1 (CAAR #2) (SETQ #1 (CAAR L)))
) (\ #2) UP (I 1 #1)))) . 0)
((__) . 0)
APPEND
(CONS BHC CONSNL SKLST KNIL ENTERF)  x "    �    ( ( � h    h    � 8   P � H �  H   8      

\EDIT.BQUOTIFY BINARY
       m    ^    j-.           ^Z   -,   +   [Z  �2B  �+   �[  Z  ,   ,~   2B  _+   [  �,<  �,<   ,<   ,<   Zw�-,   +   �Zw+   �Zw�,<  �@  �   +   �Z   ,<  �,<  `$  �,~   XBp  -,   +   Zw�3B   +   Zp  QD  +   Zp  XBw   �   [  2D   +   �XBw�[w�XBw�+   
/  ,   ,~   2B  a+   )[  �Z  ,<  �,<  `$  �,<  �[  [  Z  B  �2B   +   ',<  b[  ![  Z  ,   ,   Z  D  �,   ,~   2B  c+   <[  �,<  �@  �  +   7Z` �XB   Z  --,   +   6[  �2B   +   1+   6,<` Z  /,<  �,<  e$  �D  �XB` [  �XB  �+   �Z` ,~   ,<  �[  *B  �Z  ,<  �,<  b$  �D  �,   ,~   2B  �+   V[  �,<  �@  f  +   PZ` �XB  5Z  @-,   +   �+   O,<` Z  �B  �XB  3B   +   I[  C2B   +   HZ  D+   �Z   +    ,<  bZ  �,   Z  �,<  �,<  e$  �D  �XB` [  �XB  �+   �Z` ,~   ,<  �@  h   +   �Z   3B   +   �,   ,~   Z   ,~   ,~   2B  �+   ZZ  =,<  �,<   $  iXB  W+   �Z   ,~   B  �3B   +   �Z  Y,   ,~   a@)&$@D1�@LPL�s�q
 �    (VARIABLE-VALUE-CELL FORM . 185)
QUOTE
LIST
(VARIABLE-VALUE-CELL X . 142)
,
\EDIT.BQUOTIFY.1
CONS
\EDIT.BQUOTIFY
,.
NCONC
APPEND
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL L . 156)
,@
LAST
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL L . 0)
(NIL VARIABLE-VALUE-CELL X . 0)
(VARIABLE-VALUE-CELL Z . 164)
LIST@
EXPANDMACRO
CONSTANTEXPRESSIONP
(KT URET1 ALIST2 BHC SKNLST KNIL CONSNL SKLST ENTERF)     	   	0 '    �    B 8   H [ 
X � 	 G X � @ � H �   �    ^ 
H <  � P �    / 0        

\EDIT.BQUOTIFY.1 BINARY
       �    �    -.           �Z   B  �2B   +   Z   ,<  �Z  �,<  ,   ,~       (VARIABLE-VALUE-CELL Z . 9)
(VARIABLE-VALUE-CELL UNQUOTER . 7)
\EDIT.BQUOTIFY
(LIST2 KNIL ENTERF)  h    8      
(PRETTYCOMPRINT EDITMACROSCOMS)
(RPAQQ EDITMACROSCOMS ((* These useful EDIT macros, which everybody needs, ought to go into the 
statndard) (FNS \EDIT.CONDCLAUSES.TO.IF \EDIT.IF.TO.CONDCLAUSES \EDIT.PREPARECOPY \EDIT.PREPARESWITCH 
\EDIT.BQUOTIFY \EDIT.BQUOTIFY.1) (USERMACROS IFY CONDIFY COPY SWITCH BQUOTE) (P (PROG (X) 
"Remove those anachronistic FIX8 and FIX9 macros!" A (COND ((OR (SETQ X (ASSOC (QUOTE FIX8) EDITMACROS
)) (SETQ X (ASSOC (QUOTE FIX9) EDITMACROS))) (SETQ EDITMACROS (DREMOVE X EDITMACROS)) (GO A)))))))
(ADDTOVAR USERMACROS (CONDIFY NIL (ORR ((IF (FMEMB (## 1) (QUOTE (IF if))))) ((ORF (IF --) (if --)))) 
UP (I 1 (\EDIT.IF.TO.CONDCLAUSES (## 1))) 1) (COPY L (COMS (CONS (QUOTE COMSQ) (\EDIT.PREPARECOPY (
QUOTE L))))) (SWITCH L (COMS (CONS (QUOTE COMSQ) (\EDIT.PREPARESWITCH (QUOTE L))))) (IFY NIL (F (COND 
(& --) --) T) UP (I 1 (\EDIT.CONDCLAUSES.TO.IF (CDR (## 1)))) 1))
(ADDTOVAR EDITMACROS (BQUOTE NIL UP (ORR ((I 1 (OR (CONS (QUOTE BQUOTE) (OR (\EDIT.BQUOTIFY (## 1)) (
ERROR!))) (ERROR!)))) ((E (QUOTE BQUOTE?)))) 1))
(ADDTOVAR EDITCOMSA BQUOTE)
(ADDTOVAR EDITCOMSL COPY SWITCH)
(PROG (X) "Remove those anachronistic FIX8 and FIX9 macros!" A (COND ((OR (SETQ X (ASSOC (QUOTE FIX8) 
EDITMACROS)) (SETQ X (ASSOC (QUOTE FIX9) EDITMACROS))) (SETQ EDITMACROS (DREMOVE X EDITMACROS)) (GO A)
)))
(PUTPROPS EDITMACROS COPYRIGHT ("Xerox Corporation" 1983))
NIL
  