(FILECREATED "30-Sep-86 11:34:27" ("compiled on " 
<LISPUSERS>TERMCONTROL.LSP.40522) (2 . 2) recompiled changes: TerminalType 
TerminalSetup DISPLAYTERMP in "INTERLISP-10  31-Dec-84 ..." dated 
"31-Dec-84 20:42:07")
(FILECREATED "30-Sep-86 11:33:56" <LISPUSERS>TERMCONTROL.LSP.40522 6357 changes 
to: (VARS TERMCONTROLCOMS TERMCONTROLFNS) (FNS TerminalType TerminalSetup 
DISPLAYTERMP))

TerminalType BINARY
       5    *    4-.         8 *@  .  ,~   Z   ,<      )   a+    +    +       ."   ,   D  /Z  XB   Z   2B   +   Z  	,~   Z  	Z  ,   3B   +   +   Z  ,<   ,<   Z   ,<  ,<   (  0XB  3B   +   +   ,<   ,<  0,<   ,<   (  1Z   ,~   Z   ,<   Z   ,<  Z  ,<  Z   ,<  Z   ,<  ,<  1$  2,<   Z   ,<   Z  Z  2B  +   "Z   +    Z  !,<  ,<  2$  3N  3XB      %       )   a+    +    +    +      @`M 0b   (VARIABLE-VALUE-CELL term . 64)
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
(URET6 KT FMEMB KNIL MKN ENTERF)   0   p  (   `        0         

TerminalSetup BINARY
       n   C   g-.          C@ D  ,~     DXB   Z   3B E+   3B E+   3B F+   3B F+   3B G+   3B G+   3B H+   3B H+   3B I+   2B I+   ',< J" J,< K,< KZ  F L,< L,< M,< K,< M,< N,   B NB O,<   Z  F O,< P,< K,< M,< P,   B NB O,<   Z  F O,< Q,< K,< M,< P,   B NB O,<   Z  F O,< Q,< RZ   F O,< R,< SZ  "F O,< S,< TZ  $F O+  B2B T+   @,< K,< KZ  &F L,< L,< K,< U,   B NB O,<   Z  )F O,< P,< K,< P,< K,< N,   B NB O,<   Z  .F O,< Q,< K,< P,< K,< N,   B NB O,<   Z  3F O,< Q,< UZ  9F O,< R,< VZ  ;F O,< S,< VZ  =F O+  B2B W+   [,< K,< KZ  ?F L,< J,< KZ  BF L,< L,< M,< K,< W,   B NB O,<   Z  DF O,< P,< J,< X,< J,   B NB O,<   Z  IF O,< Q,< J,< X,< J,   B NB O,<   Z  NF O,< Q,< XZ  SF O,< R,< YZ  UF O,< S,< YZ  WF O+  B2B Z+   u,< Z,< KZ  YF L,< J,< KZ  ]F L,< L,< [,< Z,   B NB O,<   Z  _F O,< P,< J,< X,< J,   B NB O,<   Z  cF O,< Q,< J,< X,< J,   B NB O,<   Z  hF O,< Q,< [Z  mF O,< R,< \Z  oF O,< S,< \Z  qF O+  B3B ]+   x3B ]+   x2B ^+  ,< J,< KZ  sF L,< ^,< KZ  yF L,< K,< KZ  {F L,< _,< _Z  }F L,< L,< M,< ^,   B NB O,<   Z  F O,< P,< J,< X,< J,   B NB O,<   Z F O,< Q,< J,< X,< J,   B NB O,<   Z F O,< Q,< `Z F O,< R,< `Z F O,< S,< aZ F O+  B2B a+  0,< J,< KZ F L,< K,< KZ F L,< _,< _Z F L,< L,< M,< K,   B N,<   ,< b$ bB O,<   Z F O,< P,< J,< X,< J,   B NB O,<   Z !F O,< Q,< J,< X,< J,   B NB O,<   Z &F O,< Q,< cZ +F O,< S,< cZ -F O+  B,< K,< dZ /F L,< J,< _Z 1F L,< ^,< _Z 3F L,< _,< _Z 5F L,< L,< dZ 7F O,< P,< eZ 9F O,< Q,< eZ ;F O,< Q,< fZ =F O,< f,< gZ ?F OZ   ,~   }{3v;;{l~glw;{_gl}Nw~wY{g;_}no3v>gw?;^\{3]ww;]n@          (VARIABLE-VALUE-CELL termType . 8)
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
(KNIL LIST2 LIST3 LIST4 ENTERF)   8   h ( -   * P x l x R 	X H p     8 (        

DISPLAYTERMP BINARY
              -.               Z  ,   3B   +   Z   ,~   Z   ,~   @   TerminalType
((33 35 37 EXECUPORT TERMINET IDEAL LA30 LA36 LA38 LA120) . 0)
(KT KNIL FMEMB ENTER0)  `    P            
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
