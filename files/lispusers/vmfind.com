(FILECREATED "18-FEB-83 19:47:24" ("compiled on " <LISPUSERS>VMFIND.;6) (2 . 2) brecompiled exprs: 
VOPEN in WORK dated "10-FEB-83 22:52:39")
(FILECREATED "18-FEB-83 19:47:07" <LISPUSERS>VMFIND.;6 4437 changes to: (VARS VMFINDCOMS) (FNS VOPEN) 
previous date: " 2-FEB-78 14:02:45" <LISPUSERS>VMFIND.;5)

VFBLOCK BINARY
   g   =   `-.          =-.     (>p@        D   Z   ,<   @ A   +   CZ   ,<   ,< C,< C,<   @ D ` +   <Z   Z EXB ,  pZw,<8  ,<   ,<   Zw2B   +   +   9-,   +   XBp  Z   XBw+   ZwXBp  [wXBw,< F,<w,< F& G,<   Z   ,<   ,< G& HXB   3B   +   8,< H,<   ,<   @ D ` +   8Z   Z EXB @ I  +   7  J  J  J,<     JXB` 2B K+   'Zp  +   (,<   , +   $/   Z   ,   ,   XB    JXB` 3B K+   .2B L+   4  L `  1b   +   2 `  /"   ,   XB`  +   .,<` , +   #2B K+   6:`  +   +Z   ,~   Z   ,~     L+   Zw/  ZwXB8 Z   ,~   3B   +   >Z   +   >Z MXB` D MZ` 3B   +   B  N,~   Z` ,~   +         Z  ,<   @ A   ,~   Z  ,<   ,< N,< C,<   @ D ` +   iZ   Z EXB ,  p,< O,<   ,<   @ D ` +   fZ   Z EXB @ O  +   e,<   Z  *2B   +   UZ"   D Q  J,<   , ,<     JXB` 2B K+   ZZp  +   \,<   , +   W/     Q2B R+   b,<     J2B K+   aZp  +   a+   ^/   ,<` , Z   ,   ,   XB  S+   WZ   ,~     LZwXB8 Z   ,~   3B   +   kZ   +   kZ MXB` D MZ` 3B   +   o  N,~   Z` ,~   ,< R,< S,<   Z   F SB T,   ,<   ,<   ,   Z  F,   XB  u,< T  RXB  ,   ,<   ,<   ,   Z  v,   XB  z,<   " U,<   @ U   ,~   ,< UZ   ,<   ,   ,   Z  {,   XB XB` ,< W,< C,<   @ D ` +  
Z   Z EXB Z   ZwXB8 Z   ,~   2B   +  Z MXB   [` XB ,< UZ` Z  [  D XZ 3B   +    N,~   Z` ,~   Zp  2B X+    YZ  B Y+    2B Z+  '  JXBp  2B Z+  %  UB [,<   ,< [" \,<     JXBw2B \+  Zp  +  !,<   , +  /   ,< ]" \,<p  " ]Z   /   +    ,< Z" \,<p  " \+    3B ^+    3B ^+    3B _+    2B _+  ,+    2B K+  4  Q2B R+  2,<     J2B K+  1Zp  +  2+  //   ,<p  " \+    2B L+  :  UB [,   &"         ^"  /  ,   B ]+    2B `+  <  J+    B \+    ET,3/Z`_^4`U2U+[]H$L3 ` (0uo5VQU-{Yxh            (VFBLOCK#0 . 1)
(VARIABLE-VALUE-CELL LISPXHIST . 136)
(VARIABLE-VALUE-CELL RESETVARSLST . 281)
(VARIABLE-VALUE-CELL VM . 239)
(VARIABLE-VALUE-CELL VLAST . 201)
(VARIABLE-VALUE-CELL HELPSYSDIRLST . 227)
VF
VMORE
(VARIABLE-VALUE-CELL LISPXHIST . 0)
NIL
NIL
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
"
|"
"["
CONCAT
0
FFILEPOS
((DUMMY) . 0)
0
NIL
(NIL VARIABLE-VALUE-CELL HELPFLAG . 0)
READC
%

% 
%	
TERPRI
ERROR
RESETRESTORE
ERROR!
((DUMMY) . 0)
((DUMMY) . 0)
(NIL VARIABLE-VALUE-CELL HELPFLAG . 0)
0
NIL
SETFILEPTR
PEEKC
%.
INPUT
VM.PUB
FINDFILE
INFILE
CLOSEF
OUTPUT
(VARIABLE-VALUE-CELL OLDVALUE . 254)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 287)
((DUMMY) . 0)
APPLY
%
READ
TAB
*
<
POSITION
"
----------------------
"
PRIN1
>
"
----------------------
"
SPACES
%
%
%|
%
%
(IUNBOX CONSNL CONS LIST2 ALIST2 ASZ URET1 KT MKN FGFPTR BHC SKNLST CF KNIL BLKENT ENTER1) p      ( { h    z X    t    U   > P; H, 0* ( X @     |   i h <       e   +    d (   0%   b P :        p P 	8   @   x$ P 0 P z P n 0 j @ _   T 
8 N 	` I  > P 7   $ `  @    p 
           

VF BINARY
              -.          ,<    ,~       (X . 1)
VF
(NIL)
(LINKED-FN-CALL . VFBLOCK)
(ENTER1)      

VMORE BINARY
                -.            ,<    ,~       VMORE
(NIL)
(LINKED-FN-CALL . VFBLOCK)
(ENTER0)    
(PRETTYCOMPRINT VMFINDCOMS)
(RPAQQ VMFINDCOMS ((* VF - print def from VM) (FNS VF VMORE VOPEN VMECHO) (VARS (VLAST 0)) (BLOCKS (
VFBLOCK VF VMORE VOPEN VMECHO (ENTRIES VF VMORE) (GLOBALVARS VLAST VM HELPSYSDIRLST) (NOLINKFNS . T)))
 (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA VF) (NLAML)))))
(RPAQQ VLAST 0)
(PRETTYCOMPRINT VMFINDCOMS)
(RPAQQ VMFINDCOMS ((* VF - print def from VM) (FNS VF VMORE VOPEN VMECHO) (VARS (VLAST 0)) (BLOCKS (
VFBLOCK VF VMORE VOPEN VMECHO (ENTRIES VF VMORE) (GLOBALVARS VLAST VM HELPSYSDIRLST) (NOLINKFNS . T)))
 (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA VF) (NLAML) (LAMA)))))
(PUTPROPS VMFIND COPYRIGHT ("Xerox Corporation" 1983))
NIL
