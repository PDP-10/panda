(FILECREATED "24-SEP-81 00:38:55" ("compiled on " 
<LISPUSERS>DWIMLOAD.;14) (2 . 3) bcompl'd in WORK dated NOBIND)
(FILECREATED "23-JAN-79 23:09:18" <LISPUSERS>DWIMLOAD.;14 1648 changes 
to: DWIMLOADFNS? previous date: " 7-JAN-79 15:37:27" 
<LISPUSERS>DWIMLOAD.;13)

DWIMLOADFNS? BINARY
     *    �    �-.          @ �,<   ,<   Z   3B   +   �Z   2B   +   Z   3B   +   �Z   XBw�-,   +   +   Z  -,   +   Z  �XBw�-,   +   ."  �Z  2B   +   Z   3B   +   ,<w�,<  �,<  �,<  %(  �XBp  3B   +    +   Z   +    ,<  &,<w,   ,<  �,<   ,<   &  �,<w�,<w�$  'Z   2B   +   �Z   ,<  ,<  �$  ([  XB   Z  +    ID%b I      (VARIABLE-VALUE-CELL DWIMIFYFLG . 5)
(VARIABLE-VALUE-CELL DWIMIFYING . 8)
(VARIABLE-VALUE-CELL FAULTAPPLYFLG . 11)
(VARIABLE-VALUE-CELL FAULTX . 63)
(VARIABLE-VALUE-CELL FILELST . 30)
(VARIABLE-VALUE-CELL TYPE-IN? . 54)
(VARIABLE-VALUE-CELL LISPXHIST . 57)
(VARIABLE-VALUE-CELL SIDES . 62)
FNS
((NOERROR NOCOPY NODWIM FAST) . 0)
GETDEF
loaded
LISPXPRINT
/PUTD
SIDE
LISTGET1
(KT LIST2 URET2 SKLST SKLA KNIL ENTER0)           ! h             H  H � p   X   0 �       
(PRETTYCOMPRINT DWIMLOADCOMS)
(RPAQQ DWIMLOADCOMS ((* turn off system DWIMLOADFNSFLG and instead use a
 different (and faster) one - doesn't do LOADFNS, and therefore, doesn't
 do UPDATEFILES) (FNS DWIMLOADFNS?) (BLOCKS (NIL DWIMLOADFNS? (LOCALVARS
 . T) (NOLINKFNS . T) (SPECVARS DWIMIFYFLG FAULTAPPLYFLG FAULTX FAULTFN 
FAULTARGS)))))
NIL
  