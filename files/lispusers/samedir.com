(FILECREATED "21-NOV-82 00:03:31" ("compiled on " <LISPUSERS>SAMEDIR.;2) (2 . 2) bcompl'd in WORK 
dated "25-SEP-82 15:31:38")
(FILECREATED "15-OCT-82 23:31:50" {PHYLUM}<LISPUSERS>SAMEDIR.;3 3155 changes to: (FNS CHECKSAMEDIR) 
previous date: "22-OCT-81 11:31:47" {PHYLUM}<LISPUSERS>SAMEDIR.;2)

CHECKSAMEDIR BINARY
      �    �   �-.          �Z   ,<  �,<  l$  �,<  �@  m  0,~   Z   -,   +   Z   ,~   ,<   ,<   $  �XB   Z  q6@   Z  �2B  q+   �Z  �+   �2B  �+   Z  �,<  �,<  r$  �2B   +   Z  �XB  �+   �Z  B  sXB   ,<  �,<  �$  tXB   Z  ,<  ,<  r$  tXB  �Z  Z   7  �[  Z  Z  1H  +   2D   +   �[  XB   Z  �,<  Zp  -,   +   �Z   +   �Zp  ,<  �,<w�/  �@  �   �+   0[   ,<  �,<  r$  �XB  &2B   +   �Z   ,~   Z  �3B  7   7   +   �Z  (Z  �2B  7   Z   ,~   3B   +   2Z   +   �[p  XBp  +    /  �3B   +   �,<  u,<  �,<  vZ  �,<  �,<  �Z  ,<  ,<  w^"  �,   ,<  �,<  �"  x3B   +   �Z  �,   +   ?Z   ,<  �,<  y$  �H  z2B  �+   �+   2B  �+   �   {+   2B  �+   �Z  |Z   7  �[  Z  Z  1H  +   �2D   +   G[  Z  B  �+   �2B  }+   �,<  �,<   ,<   @  ~ ` �+   UZ   Z  �XB ,<   ,<   $  B  �Z   ,~   +   �  �+   ,< ,<   ,< �Z  [  H B �XB   3B   +   Z  X[  3B  +   ,< ,<  �Z  �[  ,<  �,< �Z  Z,<  �,< $  �B ,<  �,< �,< ^"  �,   F  z2B  �+   �+   2B  �+   �   {+     �+   !;M)F P)H�ISx|T3�b;|          (VARIABLE-VALUE-CELL FILE . 109)
(VARIABLE-VALUE-CELL MIGRATIONS . 51)
(VARIABLE-VALUE-CELL LISPXMACROS . 140)
FILEDATES
GETP
(VARIABLE-VALUE-CELL DATES . 189)
(NIL VARIABLE-VALUE-CELL HOST/DIR . 112)
(NIL VARIABLE-VALUE-CELL DIR2 . 91)
(NIL VARIABLE-VALUE-CELL HOST . 44)
(NIL VARIABLE-VALUE-CELL DIR . 85)
(NIL VARIABLE-VALUE-CELL LST . 0)
(NIL VARIABLE-VALUE-CELL NEWV . 193)
DIRECTORYNAME
TENEX
TOPS20
DIRECTORY
FILENAMEFIELD
UNPACKFILENAME
HOST
LISTGET
(VARIABLE-VALUE-CELL X . 90)
10
Y
"You haven't loaded or written"
"in your connected directory"
"-- should I write it out anyway"
CNDIR
GETD
((C "onnect to: ") . 0)
(((Y "es
") (N "o
") (E "XEC
")) . 0)
NCONC
ASKUSER
N
ERROR!
E
EXEC
EVAL
C
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
READ
SHOULDNT
VERSION
BODY
PACKFILENAME
INFILEP
15
"is not the most recent version (version"
MKSTRING
"has since appeared)."
"Do you want to make the file anyway"
(CF CONSNL LIST BHC KL20FLG KT KNIL SKNLST ENTERF) 
   h   ` ;    � P   8   
P � 
0 0 H � ( �    8 X 	x O 	( � P 5   1 x -        �  p      
(PRETTYCOMPRINT SAMEDIRCOMS)
(RPAQQ SAMEDIRCOMS ((FNS CHECKSAMEDIR) (ADDVARS (MAKEFILEFORMS (OR (NLSETQ (CHECKSAMEDIR FILE)) (
RETFROM (QUOTE MAKEFILE)))) (MIGRATIONS)) (GLOBALVARS MIGRATIONS)))
(ADDTOVAR MAKEFILEFORMS (OR (NLSETQ (CHECKSAMEDIR FILE)) (RETFROM (QUOTE MAKEFILE))))
(ADDTOVAR MIGRATIONS)
NIL
