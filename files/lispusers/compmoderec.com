(FILECREATED "25-JAN-83 21:46:20" ("compiled on " <LISPUSERS>COMPMODEREC.;2) (2 . 2) tcompl'd in WORK 
dated "23-JAN-83 14:11:13")
(FILECREATED "25-JAN-83 16:27:35" {PHYLUM}<LISPUSERS>COMPMODEREC.;2 1476 changes to: (FNS COMPRECTRAN)
 previous date: "16-DEC-81 09:22:16" {PHYLUM}<LISPUSERS>COMPMODEREC.;1)

COMPRECTRAN BINARY
       �    �    �-.           �   \2B  �+   �[   [  ,<  �Zp  -,   +   Z   +   �Zp  ,<  �,<w�/  �@  ]   +   Z  �Z   1B  +   �*  -,   +   *  ,   2B   7       ,~   3B   +   Zp  +   �[p  XBp  +   �/  �+   �3B  �+   �3B  ^+   �2B  �+   +[  [  ,<  �Zp  -,   +   �Z   +   *Zp  ,<  �,<w�/  �@  ]   +   �Z  �Z  1B  +   %*  -,   +   �*  ,   2B   7       ,~   3B   +   �Zp  +   *[p  XBp  +   /  �+   �2B  _+   �[  �[  ,<  �Zp  -,   +   0Z   +   �Zp  ,<  �,<w�/  �@  ]   +   :Z  _Z  �1B  +   �*  -,   +   9*  ,   2B   7       ,~   3B   +   <Zp  +   �[p  XBp  +   �/  �+   �2B  �+   R[  ,[  ,<  �Zp  -,   +   �Z   +   QZp  ,<  �,<w�/  �@  ]   +   �Z  �Z  41B  +   L*  -,   +   �*  ,   2B   7       ,~   3B   +   �Zp  +   Q[p  XBp  +   A/  �+   �   `Z  [  Z  ,<  �@  �   ,~   Z   2B   +   XZ  a,<  �[  �Z  [  V,   ,   ,~   I�%~I%`PY \
$K     (VARIABLE-VALUE-CELL DECL . 177)
COMPILEMODE
D
(VARIABLE-VALUE-CELL X . 143)
PDP-10
MAXC/10
MAXC
VAX
JERICHO
SHOULDNT
(VARIABLE-VALUE-CELL RESULT . 179)
RECORD
(CONSS1 CONS KT FMEMB SKLST BHC KNIL SKNLST ENTERF)   8   0   	P � ` �    L  % x   	( 7 8     R ` � ( + p �    
x � 	X � 8 ;   9   � h � H     p   ( / 8        
(PRETTYCOMPRINT COMPMODERECCOMS)
(RPAQQ COMPMODERECCOMS ((E (RESETSAVE CLISPIFYPRETTYFLG NIL)) (ADDVARS (CLISPRECORDTYPES COMPREC)) (P 
(MOVD? (QUOTE RECORD) (QUOTE COMPREC))) (PROP USERRECORDTYPE COMPREC) (FNS COMPRECTRAN)))
(ADDTOVAR CLISPRECORDTYPES COMPREC)
(MOVD? (QUOTE RECORD) (QUOTE COMPREC))
(PUTPROPS COMPREC USERRECORDTYPE COMPRECTRAN)
(PUTPROPS COMPMODEREC COPYRIGHT ("Xerox Corporation" 1983))
NIL
 