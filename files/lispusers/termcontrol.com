(FILECREATED "30-Sep-86 11:34:27" ("compiled on " 
<LISPUSERS>TERMCONTROL.LSP.40522) (2 . 2) recompiled changes: TerminalType 
TerminalSetup DISPLAYTERMP in "INTERLISP-10  31-Dec-84 ..." dated 
"31-Dec-84 20:42:07")
(FILECREATED "30-Sep-86 11:33:56" <LISPUSERS>TERMCONTROL.LSP.40522 6357 changes 
to: (VARS TERMCONTROLCOMS TERMCONTROLFNS) (FNS TerminalType TerminalSetup 
DISPLAYTERMP))

TerminalType BINARY
       �    *    4-.         8 *@  .  ,~   Z   ,<  �   �   �+    +    +       ."  �,   D  �Z  XB   Z   2B   +   Z  	,~   Z  �Z  ,   3B   +   +   Z  ,<  �,<   Z   ,<  ,<   (  0XB  3B   +   �+   ,<   ,<  �,<  �,<   (  1Z   ,~   Z   ,<  �Z   ,<  Z  �,<  Z   ,<  Z   ,<  ,<  �$  2,<  �Z   ,<  �Z  Z  �2B  +   �Z   +    Z  �,<  ,<  �$  3N  �XB      %   �   �   a+    +    +    +     � @`M 0�b   (VARIABLE-VALUE-CELL term . 64)
(VARIABLE-VALUE-CELL TERMINALS . 52)
(VARIABLE-VALUE-CELL t . 63)
(VARIABLE-VALUE-CELL in . 50)
(VARIABLE-VALUE-CELL bind . 54)
(VARIABLE-VALUE-CELL _ . 56)
(VARIABLE-VALUE-CELL do . 61)
(VARIABLE-VALUE-CELL count . 69)
(NIL VARIABLE-VALUE-CELL oldType . 22)
(NIL VARIABLE-VALUE-CELL tnum . 75)
((33 35 37 EXECUPORT ADM-3A DATAMEDIA-2500 VT132 CONCEPT-100 TERMINET IDEAL VT05
 VT50 LA30 GT40 LA36 VT52 VT100 LA38 LA120 HAZELTINE-1500 CONCEPT-108 
CONCEPT-GRAPHICS-108 DATAMEDIA-1520 SOROC-120 HP2640 VC404 WICAT ANSI ADM-6 
SELANAR V1 V2 ADDS TEKTRONIX-4025 TELEVIDEO-912 VT125 VK100 VT102 H19 VT131 
VT200 GLASS TEKTRONIX-4014) VARIABLE-VALUE-CELL spellingList . 33)
NTH
FIXSPELL
"Strange terminal type - "
printout
0
count
1
add
for
(URET6 KT FMEMB KNIL MKN ENTERF)   0   p � (   `       � 0         

TerminalSetup BINARY
       n   �   �-.          �@ D  ,~     �XB   Z   3B E+   �3B �+   �3B F+   �3B �+   �3B G+   �3B �+   �3B H+   �3B �+   �3B I+   �2B �+   �,< J" �,< K,< �Z  �F L,< �,< M,< K,< �,< N,   B �B O,<  �Z  �F �,< P,< K,< �,< �,   B �B O,<  �Z  F �,< Q,< K,< �,< �,   B �B O,<  �Z  F �,< �,< RZ   F �,< �,< SZ  "F �,< �,< TZ  $F �+  �2B �+   �,< K,< �Z  &F L,< �,< K,< U,   B �B O,<  �Z  �F �,< P,< K,< �,< K,< N,   B �B O,<  �Z  .F �,< Q,< K,< �,< K,< N,   B �B O,<  �Z  �F �,< �,< �Z  9F �,< �,< VZ  ;F �,< �,< �Z  =F �+  �2B W+   [,< K,< �Z  ?F L,< J,< �Z  �F L,< �,< M,< K,< �,   B �B O,<  �Z  �F �,< P,< J,< X,< J,   B �B O,<  �Z  �F �,< Q,< J,< X,< J,   B �B O,<  �Z  �F �,< �,< �Z  �F �,< �,< YZ  �F �,< �,< �Z  �F �+  �2B Z+   u,< �,< �Z  �F L,< J,< �Z  ]F L,< �,< [,< �,   B �B O,<  �Z  _F �,< P,< J,< X,< J,   B �B O,<  �Z  �F �,< Q,< J,< X,< J,   B �B O,<  �Z  �F �,< �,< �Z  �F �,< �,< \Z  �F �,< �,< �Z  �F �+  �3B ]+   x3B �+   x2B ^+  ,< J,< �Z  �F L,< �,< �Z  yF L,< K,< �Z  {F L,< _,< �Z  }F L,< �,< M,< �,   B �B O,<  �Z  F �,< P,< J,< X,< J,   B �B O,<  �Z �F �,< Q,< J,< X,< J,   B �B O,<  �Z �F �,< �,< `Z �F �,< �,< �Z �F �,< �,< aZ �F �+  �2B �+  �,< J,< �Z �F L,< K,< �Z F L,< _,< �Z F L,< �,< M,< K,   B �,<  �,< b$ �B O,<  �Z F �,< P,< J,< X,< J,   B �B O,<  �Z !F �,< Q,< J,< X,< J,   B �B O,<  �Z &F �,< �,< cZ +F �,< �,< �Z -F �+  �,< K,< dZ /F L,< J,< �Z �F L,< �,< �Z �F L,< _,< �Z �F L,< �,< �Z �F �,< P,< eZ �F �,< Q,< �Z �F �,< �,< fZ �F �,< �,< gZ �F �Z   ,~   �{3v�;{l~�lw;{_gl}Nw~wY{g;_}�o3v>gw?;^�{3]ww;]n@          (VARIABLE-VALUE-CELL termType . 8)
(NIL VARIABLE-VALUE-CELL ttbl . 387)
GETTERMTABLE
VT100
VK100
VT102
VT125
VT131
VT132
VT200
SELANAR
V1
V2
8
INTERRUPTCHAR
27
REAL
ECHOCONTROL
LINEDELETE
13
91
75
PACKC
MKSTRING
DELETECONTROL
1STCHDEL
68
NTHCHDEL
POSTCHDEL
""
EMPTYCHDEL
""
NOECHO
""
VT52
77
""
""
""
TELEVIDEO-912
84
32
""
""
""
HAZELTINE-1500
19
126
""
""
""
DATAMEDIA-2500
DATAMEDIA-1520
CONCEPT-100
23
30
UPARROW
""
""
""
H19
K
CONCAT
""
""
SIMULATE
"##
"
"\"
""
"\"
ECHO
""
(KNIL LIST2 LIST3 LIST4 ENTERF)   8   h� ( -   * P� x � x � 	X � p     8 (        

DISPLAYTERMP BINARY
      �        -.               Z  �,   3B   +   Z   ,~   Z   ,~   @   TerminalType
((33 35 37 EXECUPORT TERMINET IDEAL LA30 LA36 LA38 LA120) . 0)
(KT KNIL FMEMB ENTER0)  `    P     �       
(PRETTYCOMPRINT TERMCONTROLCOMS)
(RPAQQ TERMCONTROLCOMS ((FNS * TERMCONTROLFNS) (P (OR (BOUNDP (QUOTE TERMINALS))
 (RPAQQ TERMINALS (33 35 37 EXECUPORT ADM-3A DATAMEDIA-2500 VT132 CONCEPT-100 
TERMINET IDEAL VT05 VT50 LA30 GT40 LA36 VT52 VT100 LA38 LA120 HAZELTINE-1500 
CONCEPT-108 CONCEPT-GRAPHICS-108 DATAMEDIA-1520 SOROC-120 HP2640 VC404 WICAT 
ANSI ADM-6 SELANAR V1 V2 ADDS TEKTRONIX-4025 TELEVIDEO-912 VT125 VK100 VT102 H19
 VT131 VT200 GLASS TEKTRONIX-4014))))))
(RPAQQ TERMCONTROLFNS (TerminalType TerminalSetup DISPLAYTERMP))
(OR (BOUNDP (QUOTE TERMINALS)) (RPAQQ TERMINALS (33 35 37 EXECUPORT ADM-3A 
DATAMEDIA-2500 VT132 CONCEPT-100 TERMINET IDEAL VT05 VT50 LA30 GT40 LA36 VT52 
VT100 LA38 LA120 HAZELTINE-1500 CONCEPT-108 CONCEPT-GRAPHICS-108 DATAMEDIA-1520 
SOROC-120 HP2640 VC404 WICAT ANSI ADM-6 SELANAR V1 V2 ADDS TEKTRONIX-4025 
TELEVIDEO-912 VT125 VK100 VT102 H19 VT131 VT200 GLASS TEKTRONIX-4014)))
NIL
    