(FILECREATED "31-Dec-84 02:43:48" ("compiled on " <NEWLISP>WEDIT..164) (2 . 2) brecompiled changes: nothing in 
"INTERLISP-10  14-Sep-84 ..." dated "14-Sep-84 00:05:07")
(FILECREATED "18-Sep-84 18:17:50" {ERIS}<LISPCORE>SOURCES>WEDIT.;3 29773 changes to: (USERMACROS LOWER) previous date: 
"13-SEP-84 00:51:09" {ERIS}<LISPCORE>SOURCES>WEDIT.;2)
SETTERMCHARS BINARY
    �    N    �-.     0      N-.      Q    R,<w�,  �XBw�3B   +   �,<  �,<  RZ   F  �,<w�,  �XBw�3B   +   �,<  �,<  SZ  �F  �,<w�,<  �$  T,<w�,  �XBw�3B   +   �,<  �,<  �Z  F  �,<w�,<  �$  T,<w~,  �XBw~3B   +   �,<  �,<  UZ  F  �,<w~,<  �$  T,<w,  �XBw3B   +    ,<  �,<  �,<   &  �,<w,<   Z  F  �,<p  ,  �XBp  3B   +    ,<  �,<  VZ  F  �,<p  ,<  �$  T+    ,<p  ,<   Zw�-,   +   *Zw�XBw�2B   +   ,Z   +    -,   +   .B  �XBw� w�1b   +   � w�/"   ,   XBw�,<w�"  W2B   +   �Zw�+    Zw-,   +   �,<  �,<   $  X w�."   ,   A"  �Z   ." Z  ,<  �,<   $  X,<  �,<   $  X,<   "  Y+   +[wZ  XBp  3B   +   �-,   +   DB  �XBp   p  1b   +   � p  /"   ,   XBp  ,<p  ,<w"  �2B   +   �   Z[  ,   B  �+   �,<w�"  �+   �JRV�4URQ!X �P,,l        (NEXTCHAR . 1)
(BKCHAR . 1)
(LASTCHAR . 1)
(UNQUOTECHAR . 1)
(2CHAR . 1)
(PPCHAR . 1)
(VARIABLE-VALUE-CELL EDITRDTBL . 71)
(VARIABLE-VALUE-CELL FCHARAR . 115)
((MACRO FIRST IMMEDIATE (LAMBDA NIL (CHARMACRO NXP))) . 0)
/SETSYNTAX
((MACRO FIRST IMMEDIATE (LAMBDA NIL (CHARMACRO -1P))) . 0)
IGNORE
/ECHOCONTROL
((MACRO FIRST IMMEDIATE (LAMBDA NIL (CHARMACRO 2P))) . 0)
((MACRO FIRST IMMEDIATE ESCQUOTE (LAMBDA NIL (CHARMACRO BKP))) . 0)
((MACRO FIRST (LAMBDA (FILE RDTBL) (EVAL (READ FILE RDTBL)))) . 0)
((SPLICE FIRST IMMEDIATE ESCQUOTE (LAMBDA NIL (TERPRI T) (## PP*) (PRIN1 (QUOTE *) T) NIL)) . 0)
CHCON1
GETINTERRUPT
"control-"
PRIN1
" is an interrupt and can't be an edit control-character"
TERPRI
INTCHAR
HELP
(CONSS1 SKNLST MKN SKNI URET3 SKLST URET6 KT KNIL BLKENT ENTER6)  L    6    �  �    C P   P �    )    ' 0   p > H � x     J   � @ +   � @    
  X    (      
CHARMACRO BINARY
        �    �-.      �    � "  �   �,<   "  Z` �,~       (X . 1)
TERPRI
(KT ENTER1)    8      
FIRSTATOM BINARY
            �-.           Z` �-,   +   �,~   Z` �XB` �+   �   (X . 1)
(SKNLST ENTER1)   0      
NEGATE BINARY
         �   �-.          �-.        �Zp  -,   Z   Z  3B �+   2B +   �[p  Z  +    2B �+   �[p  ,<  �,  �Z ,   +    2B +   �[p  ,<  �,  �Z �,   +    2B �+   �[p  [  2B   +   �[p  Z  [  [  2B   +   �Z �[p  Z  ,   XBp  +   [p  ,<  �,  �Z �,   +    2B +   �[p  Z  ,<  �[w�[  ,<  �,<   ,<   ,<   Zw�-,   +   �ZwZ   2B   +   � "  +   ([  QD   "  +   4,<w�[p  3B   +   /Zp  Z  ,<  �Zw�[  ,<  �,  b,   +   �Zp  ,<  �,  /  �Zw,   XBw[w�XBw�+   "/  ,   Z ,   +    2B �+   :[p  ,<  �,  bB +    2B �+   @[p  Z  ,<  �,  [p  [  ,   Z �,   +    2B +   �[p  Z  2B   +   �7   Z   +    2B �+   I[p  ,<  �Z   ,   D B +    Z   ,<  �,<   ,<   Zw-,   +   M+   �Z  XBp  Zp  Zw�2B  +   R[p  [w�,   +   X[p  Zw�2B  +   VZp  [w�,   +   X[wXBw+   KZw�/  �2B   +    Zp  2B   +   \Z   +    3B   +   a-,   +   a-,   +   a,< �,<  �,   +    Z   +    [p  2B   +   fZp  ,<  �,  ,   +    Zp  ,<  �[w�,<  �,  b,   +    ,<p  ,<   Zw�-,   +   qZp  Z   2B   +   o "  +   �[  QD   "  +    Zw�,<  �,  Zp  ,   XBp  [w�XBw�+   �Zp  2B   +   �,<   ,<   ,   ,   +    Zp  [  2B   +  �Zp  Z  ,<  �,  ,<  �[w�2B   +  �Z   +  [w�,<  �,  �XBw�3B   +  �Z �Zw�,   +  Z   ,   ,   +    Zp  Z  ,<  �Zw�[  ,<  �,  b,   ,<  �Zw�Z  3B   +  [w�,<  �,  �+  �Z   ,   +    f30L`"H	31	D�@0""X@�
@L@�     (X . 1)
(VARIABLE-VALUE-CELL NEGATIONS . 146)
NOT
NULL
AND
OR
COND
SELECTQ
PROGN
MKPROGN
PROG1
QUOTE
CONS
APPEND
(ALIST2 URET3 LIST2 SKNSTP SKNNM CONSNL KT COLLCT BHC CONSS1 SKNLST CONS CONS21 URET1 KNIL SKLST BLKENT ENTER1)   p       a    _    ^   �  f 	    `�  x P \ @   @ �    Y P �   � @ � X /    l 	H �   � 
` R p     @ h �  �      z   � ( � H Z 	 E  � p       � 8 � 8 w ` � 0 �   [  � 	0 � H C ( � P �   � h �  P    H    (      
MKPROGN BINARY
      *    �    �-.           �-.       $    $,<p  ,  	XBp  [  3B   +   Z  $Zp  ,   +    Zp  +    [p  2B   +   Zp  Z  2B  $+   Zp  [  +    Zp  +    Zp  -,   +   [p  XBp  +   	Zp  Z  3B  $+   3B  �+   3B  %+   3B  �+   3B  &+   3B  �+   2B  '+   �Zp  [  ,<  �[w�D  �XBp  +   	2B  (+    [p  XBp  +   	Zp  ,<  �[w�,<  �,  	,   +    F�a9     (L . 1)
PROGN
LIST
CONS
CAR
CDR
NOT
NULL
APPEND
QUOTE
(CONSS1 SKNLST URET1 CONS KNIL BLKENT ENTER1)  8      @ � h �        (     �       
MAKEFN BINARY
    N    B    �-.           BZ` �-,   +   �Z` �B  �3B   +   �[` �2B   +   �Z` 2B   +   �Z` �Z` �,   ,   B  D,<` �"  �B  E,~   ,<` [` �,<  �,<   Z` �-,   +   Z` �3B   +   Z` �-,   +   ,<` �,<  �,<   &  FZw�-,   +   �Zw-,   +   ,,<` Zw-,   +   Zw+   *,<  �Zp  -,   +   Z   +   �Zp  ,<  �,<w�/  �Zp  Z` ,   2B   +   #7   Z   /  �3B   +   &Zp  +   �[p  XBp  +   �/  �Z  2B   +   *   G,   XBw�D  �XB` ZwZw�3B  +   8,<  H,<   ,<   @  � ` +   8Z   Z  JXB Zw�Z?,<  �Zw~Z?�,<  �Zw~,<8 �&  �Z   ,~   [wXBw[w�XBw�+   Z` �,<  �Z` Z` �,   Z  K,   XBw�,   ,   B  D,<p  "  EZ   +    R!0	*$,P)C   B@      (FORM . 1)
(ARGLIST . 1)
(BODY . 1)
FNTYP
DEFINE
GETD
FIXEDITDATE
"? "
ERROR
((X Y Z A B C D) . 0)
GENSYM
NCONC
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
ESUBST
LAMBDA
(URET3 ALIST2 CONS21 CF FMEMB BHC SKNLST KT SKNLA SKLST CONSNL CONS KNIL SKLA ENTER3)  �    �    �    2    "    � H �           � 8         �       + (   X 
    B   � P $ (      �  P            
EDITGETD BINARY
       Y    M    �-.          MZ` �-,   +   LZ` �,<  �,<   ,<   Zw-,   +   Zw2B  O+   [wZ  ,<  �[` �,<  �[w~[  F  �B  P+    2B  �+   ,<w[` �D  Q+    Z   +    ,<  �Z   D  �3B   +   ,<` �,<   $  RXBw�Z` �,   2B   +   ,<w�"  �+    ,<w,<  S$  �3B   +   &,<` �,<   Z` 2B   +   �Z  TF  �ZwZ` �3B  +   "Z` �+    Z` �Z   ,   XBw�3B   +    B  �+    ,<w"  UXBw�3B   +    [w�[  ,<  �,<   Zw�-,   +   1Zp  Z   2B   +   / "  +   �[  QD   "  +   �Zw�,<  �Zp  3B  �+   47   Z   /  �3B   +   8Zw�Zp  ,   XBp  [w�XBw�+   �/  XBp  [w�Z  2B   +   �,<p  "  PB  �+    Zw�3B  V+   B[w�Z  -,   +   GZw�,<  �[wZ  Zw�,   ,   [w�,   +    [w�Z  ,<  �[` �,<  �,<w,<   (  �B  P+    Z   ,~   `R
4  "D�f     (X . 1)
(EDITCHAIN . 1)
(VARIABLE-VALUE-CELL COMPILERMACROPROPS . 35)
(VARIABLE-VALUE-CELL CLISPARRAY . 69)
LAMBDA
SUBPAIR
MKPROGN
OPENLAMBDA
EXPANDOPENLAMBDA
GETLIS
EXPANDMACRO
COPY
CLISPWORD
GETPROP
((NIL) . 0)
DWIMIFY
GETDEF
*
NLAMBDA
(CONSS1 CONS COLLCT BHC SKNLST GETHSH EQUAL KT URET3 KNIL SKLST ENTER2)   `   p �    8    � X     ,    $        K H  P   	H � p ) h � ( �  � X   	P � ` 5 ` � 0 � P  8 � 8   X     �  0      
MAKECOM BINARY
      ;    4    9-.      �   4,<   "  �,<  �,<   Zw�XB   ,<  �,<   ,<w�&  6XBp  -,   +   Z` �XB  Zp  ,   2B   +   �,<` �,<   ,<w"  �,<  �,<   (  7XB` �2B   +   �   �,<p  ,<   ,<   ,<   ,<   Z"  XBwZw~-,   +   +   �Z  XBw�Z` �2B  +   +Z` 2B   +   [w}3B   +   [w}[  2B   +   Zw,   +    [w}3B   +   %,<w[` 3B   +   �Z` +   $Z` ,   +    ,<p  [` 3B   +   (Z` +   �Z` ,   D  8Z  �,   +    [w}XBw}2B   +   /Z   Zp  ,   XBp   w."  �,   XBw[w~XBw~+      �Zw�+     DLB$ EL `     (VAR . 1)
(VALS . 1)
(VARIABLE-VALUE-CELL COM . 17)
##
SMARTARGLIST
APPEND
FIXSPELL
ERROR!
NCONC
N
(MKN CONS CONS21 ALIST2 URET7 CONSNL SKNLST ASZ FMEMB SKLST KNIL ENTER2)   1    /    +    %    � 8 � x        �        �        . P ' ( � X �   � 0 �    h � 0   @ �       
SWAPPEDCOND BINARY
    �    �    �-.          �Z` �3B  2+   2B  �+   �,<` �,<   Z   F  3Z` �2B  �+   �Z` �+   �Z` �Z   ,   2B   +   �   4B  �[  B  5,~   2B  �+   �[` �Z  ,<  �[` �[  ,<  �[` �[  Z  ,<  �[w2B   +   �   4ZwB  �,<  �Zw�2B   +   [w�2B   +   Zw2B   +   Z   ,   +   Z  �Zw,   ,   ,   ,<  �[w�[  2B   +   �[w�Z  Z  2B  �+   �[w�Z  [  +   �[w�Z  2B   +   �[w�[  2B   +   �Z   +   �Z   [w�,   ,   ,   Z  �,   +       6,~   EPu@"$`�D"A      (CND . 1)
(VARIABLE-VALUE-CELL L . 10)
(VARIABLE-VALUE-CELL CLISPARRAY . 18)
IF
if
DWIMIFY
COND
ERROR!
SWAPPEDCOND
COND.TO.IF
NEGATE
SHOULDNT
(URET3 CONS21 CONSS1 CONS CONSNL KNIL GETHSH KT ENTER1)      x   h      � p   ` � P   8 �  " H �    0   (   H �  X      
BQUOTIFY BINARY
     �    .    2-.           .Z` �-,   +   �Z` �2B  �+   �[` �Z  ,   ,~   2B  /+   [` �,<  �,<   ,<   ,<   Zw�-,   +   +   Z  XBw�,<wB  �2B   +   �,<  0,<w�,   D  �XBw[w�XBw�+   
Zw/  ,   ,~   2B  1+   �[` �Z  B  �2B   +   �,<  0[` �Z  ,   ,<  �[` �[  Z  B  �,<  �Zp  3B   +    Zp  +   �,<  �[` �[  Z  ,   /  �D  �,   ,~   Z   ,~   -,   +   �-,   +   �3B   7   7   +   �Z` �3B   +   ,Z   ,~   Z   Z` �,   ,~   a@12!K EA	   (FORM . 1)
QUOTE
LIST
BQUOTIFY
,
NCONC
CONS
.,
(KT SKNSTP SKNNM ALIST2 BHC LIST2 SKNLST KNIL CONSNL SKLST ENTER1)   -  �    �    �    # 0   8 �        �    , 0 � X    ( 
    ` � P �           
COND.TO.IF BINARY
     �    �    �-.           �,<` �,<   ,<   ,<   Zw�-,   +   Zw+   Zw�,<  �Zp  2B   +   �Zp  Z` �3B  +   �Z   [p  ,   +   �Zp  ,<  �[w�3B   +   [w�B  �Z  !,   ,   Z  �,   /  �XBp  -,   +   �Zw�3B   +   �Zp  QD  +   �Zp  XBw   �   [  2D   +   XBw�[w�XBw�+   �/  [  Z  ",   ,~   H�HH (CONDCLAUSES . 1)
else
APPEND
then
elseif
if
(SKLST BHC CONSS1 CONS21 CONS KT SKNLST KNIL ENTER1)   H   ` �        � 0 �    �    �         `   @ �  0      
FIXEDITDATE BINARY
       6    �    �-.          �Z   3B   +   �Z` �-,   +   �Z` �Z   ,   3B   +   �[` �-,   +   �[` �[  ,<  �Zp  -,   +   �Z   +    Zp  -,   +   �Zp  Z  3B  �+   2B  0+   �[p  XBp  +   
2B  �+   �Zp  [  Z  Z  2B  1+   �Zp  [  Z  [  XBp  +   
2B  �+   +   �Zp  Z  Z   2B  +   �Zp  [  Z  2B  2+   �[p  XBp  +   
[p  -,   +   �Zp  B  �3B   +   �,<p  Zw�,<  �Z  �D  3D  �+   �,<   Z  �D  3,<  �,<w�$  4Z` �+    Z   ,~   !!p`x#�!d@  (EXPR . 1)
(VARIABLE-VALUE-CELL INITIALS . 82)
(VARIABLE-VALUE-CELL LAMBDASPLST . 10)
(VARIABLE-VALUE-CELL COMMENTFLG . 56)
CLISP:
DECLARE
BREAK1
PROGN
ADV-PROG
DECLARATIONS:
EDITDATE?
EDITDATE
/RPLACA
/ATTACH
(URET1 SKNLST FMEMB SKLST KNIL ENTER1)  - P   8    h   0   �    �  % H   0      
EDITDATE? BINARY
    0    *    �-.          *Z` �-,   +   �Z` �Z   2B  7   7   +   �Z   2B   +   	,<` �"  ,XB` �[` �Z  Z   3B  7   7   +   �[` �Z  -,   +   �[` �[  [  [  [  [  2B   +   [` �[  Z  -,   +   �[` �Z  ,<  �,<  �$  -,<  �Z"  ,\  3B  7   7   +   �[` �Z  2B  �+   �[` �[  Z  2B  .+   �[` �[  [  [  [  [  [  [  [  2B   +   �7   Z   ,~   Z   ,~   Z   ,~   -,   Z   ,~   P@B	F      (COMMENT . 1)
(VARIABLE-VALUE-CELL COMMENTFLG . 7)
(VARIABLE-VALUE-CELL NORMALCOMMENTSFLG . 12)
(VARIABLE-VALUE-CELL INITIALS . 20)
GETCOMMENT
-1
NTHCHARCODE
Edited
by
(SKSTP ASZ SKNSTP SKLA KT KNIL SKLST ENTER1)   �            �    & (   `     � x � P  ( �  x �           
EDITDATE BINARY
       �    �    �-.          �,<      XBp  ,<  �,<  �,<  H  �XBp  Z` �-,   +   �Z` �Z   2B  +   �[` �[  Z  -,   +   �Z  �,<  �,<` ,<w,   +    [` �,<  �,<` $  [  ,<  �,<w�$  Z` �+    q @    (OLDATE . 1)
(INITLS . 1)
(VARIABLE-VALUE-CELL COMMENTFLG . 23)
DATE
1
15
SUBSTRING
RPLACA
(URET1 LIST3 SKNSTP SKLST KNIL ENTER2)   p   h   8    p    (      
SETINITIALS BINARY
       �        �-.           @    ,~   ,<      B  �Z   7  �[  Z  Z  1H  +   	2D   +   �XBp  3B   +   [p  -,   +   ,<  [w�D  �+    ,<  [w�Z  D  �,<  [w�[  Z  D  �+    ,<  Z   D  �+    `)LT    (VARIABLE-VALUE-CELL INITIALSLST . 9)
(VARIABLE-VALUE-CELL DEFAULTINITIALS . 39)
(NIL VARIABLE-VALUE-CELL FILEPKGFLG . 0)
(T VARIABLE-VALUE-CELL DFNFLG . 0)
USERNAME
MKATOM
INITIALS
SAVESET
FIRSTNAME
(URET1 SKNLST KNIL ENTER0) X � h   @   ( 	  @      
(PRETTYCOMPRINT WEDITCOMS)
(RPAQQ WEDITCOMS ((VARS EDITOPS MAXLOOP (EDITRACEFN) (UPFINDFLG T) MAXLEVEL FINDFLAG (EDITQUIETFLG)) (INITVARS (EDITSMASHUSERFN) (
EDITEMBEDTOKEN (QUOTE &)) (EDITUSERFN) (CHANGESARRAY) (EDITUNSAVEBLOCKFLG T) (EDITLOADFNSFLG (QUOTE (T)))) (INITVARS (EDITMACROS) (
USERMACROS)) (ADDVARS (HISTORYCOMS ?? REDO REPEAT FIX USE ... NAME RETRIEVE DO !N !E !F TYPE-AHEAD  BUFS ;) (DONTSAVEHISTORYCOMS
 SAVE P ? PP PP* E ;) (EDITCOMSA OK STOP SAVE TTY: E ? PP PP* PPV P ^ !0 MARK UNDO !UNDO TEST UNBLOCK _ \ \P __ F BF UP DELETE NX BK
 !NX ?? REDO REPEAT FIX USE NAME RETRIEVE DO !N !E !F TYPE-AHEAD) (EDITCOMSL S R R1 RC RC1 E I N P F FS F= ORF BF NTH IF RI RO LI LO
 BI BO M NX BK ORR MBD XTR THRU TO A B : AFTER BEFORE MV LP LPQ LC LCL _ BELOW SW BIND COMS ORIGINAL INSERT REPLACE CHANGE DELETE 
EMBED SURROUND MOVE EXTRACT SWITCH ?? REDO REPEAT FIX USE NAME RETRIEVE DO MARK \)) (USERMACROS CAP LOWER RAISE 2ND 3RD %%F %% NEX 
REPACK * >* SHOW EXAM PP*) (* * control chars for moving around in the editor) (FNS SETTERMCHARS INTCHECK CHARMACRO) (INITVARS (
EDITCHARACTERS)) (VARS NEGATIONS) (USERMACROS 2P NXP BKP -1P) (ADDVARS (COMPACTHISTORYCOMS 2P NXP BKP -1P)) (DECLARE: DONTCOPY (
MACROS CFOBF)) (BLOCKS (SETTERMCHARS SETTERMCHARS INTCHECK (NOLINKFNS . T) (GLOBALVARS EDITRDTBL)) (NIL CHARMACRO (LOCALVARS . T))) 
(* * macros for calling editor) (USERMACROS EF EV EP) (ADDVARS (DONTSAVEHISTORYCOMS EF EV EP)) (FNS FIRSTATOM) (BLOCKS (NIL 
FIRSTATOM (LOCALVARS . T))) (* * Misc edit macros) (USERMACROS EVAL Q GETD GETVAL MAKEFN D NEGATE GO SWAP MAKE SWAPC BQUOTE IFY 
SPLITC JOINC) (FNS MAKEFN EDITGETD NEGATE NEGL NEGLST NEGC MKPROGN MKPROGN1 MAKECOM SWAPPEDCOND BQUOTIFY COND.TO.IF) (BLOCKS (NEGATE
 NEGATE NEGL NEGLST NEGC (NOLINKFNS . T) (GLOBALVARS NEGATIONS)) (MKPROGN MKPROGN MKPROGN1 (NOLINKFNS . T))) (GLOBALVARS CLISPARRAY 
MACROPROPS) (LOCALVARS . T) (* * Time stamp on functions when edited) (DECLARE: DONTCOPY (P (* User enables this by an (ADDTOVAR 
INITIALSLIST (USERNAME . initials:)) in his INIT.LISP. E.g. (ADDTOVAR INITIALSLIST (MASINTER . lmm:)) - The date fixup is enabled by
 the variable INITIALS. The function SETINITIALS sets INITIALS from INITIALSLIST and USERNAME at load time, and after a sysin.))) (
FNS FIXEDITDATE EDITDATE? EDITDATE SETINITIALS) (INITVARS (INITIALS) (INITIALSLST) (DEFAULTINITIALS (QUOTE edited:))) (GLOBALVARS 
LAMBDASPLST NORMALCOMMENTSFLG COMMENTFLG FIRSTNAME INITIALS INITIALSLST DEFAULTINITIALS FILEPKGFLG DFNFLG) (P (MOVD? (QUOTE NILL) (
QUOTE PREEDITFN))) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA) (NLAML MAKECOM CHARMACRO) (LAMA))))
)
(RPAQQ EDITOPS ((INSERT (BEFORE AFTER FOR) (EDIT: #2 #3 #1)) (REPLACE (WITH BY) (EDIT: : #1 #3)) (CHANGE (TO) (EDIT: : #1 #3)) (
DELETE NIL (EDIT: : #1)) (EMBED (IN WITH) (EDITMBD #1 #3)) (SURROUND (WITH IN) (EDITMBD #1 #3)) (MOVE (TO) (EDITMV #1 (CAR #3) (CDR 
#3))) (EXTRACT (FROM) (EDITXTR #3 #1)) (SWITCH (AND) (EDITSW #1 #3))))
(RPAQQ MAXLOOP 30)
(RPAQQ EDITRACEFN NIL)
(RPAQQ UPFINDFLG T)
(RPAQQ MAXLEVEL 300)
(RPAQQ FINDFLAG NIL)
(RPAQQ EDITQUIETFLG NIL)
(RPAQ? EDITSMASHUSERFN)
(RPAQ? EDITEMBEDTOKEN (QUOTE &))
(RPAQ? EDITUSERFN)
(RPAQ? CHANGESARRAY)
(RPAQ? EDITUNSAVEBLOCKFLG T)
(RPAQ? EDITLOADFNSFLG (QUOTE (T)))
(RPAQ? EDITMACROS)
(RPAQ? USERMACROS)
(ADDTOVAR HISTORYCOMS ?? REDO REPEAT FIX USE ... NAME RETRIEVE DO !N !E !F TYPE-AHEAD  BUFS ;)
(ADDTOVAR DONTSAVEHISTORYCOMS SAVE P ? PP PP* E ;)
(ADDTOVAR EDITCOMSA OK STOP SAVE TTY: E ? PP PP* PPV P ^ !0 MARK UNDO !UNDO TEST UNBLOCK _ \ \P __ F BF UP DELETE NX BK !NX ?? REDO 
REPEAT FIX USE NAME RETRIEVE DO !N !E !F TYPE-AHEAD)
(ADDTOVAR EDITCOMSL S R R1 RC RC1 E I N P F FS F= ORF BF NTH IF RI RO LI LO BI BO M NX BK ORR MBD XTR THRU TO A B : AFTER BEFORE MV 
LP LPQ LC LCL _ BELOW SW BIND COMS ORIGINAL INSERT REPLACE CHANGE DELETE EMBED SURROUND MOVE EXTRACT SWITCH ?? REDO REPEAT FIX USE 
NAME RETRIEVE DO MARK \)
(ADDTOVAR EDITMACROS (LOWER NIL UP (I 1 (L-CASE (## 1))) 1) (CAP NIL UP (I 1 (L-CASE (## 1) T)) 1) (REPACK NIL (IF (LISTP (##)) (1) 
NIL) (I : ((LAMBDA (X Y) (SETQ COM (QUOTE REPACK)) (SETQ Y (APPLY (QUOTE CONCAT) (EDITE (UNPACK X)))) (COND ((NOT (STRINGP X)) (SETQ
 Y (MKATOM Y)))) (PRINT Y T T)) (##)))) (* X MARK (ORR ((I >* (COND ((RAISEP) (CONS (QUOTE *) (CONS (QUOTE %%) (QUOTE X)))) (T (CONS
 (QUOTE *) (QUOTE X)))))) ((E (QUOTE CAN'T)))) __) (LOWER (C) (I R (QUOTE C) (L-CASE (QUOTE C)))) (RAISE (C) (I R (L-CASE (QUOTE C))
 (QUOTE C))) (RAISE NIL UP (I 1 (U-CASE (## 1))) 1) (2ND X (ORR ((LC . X) (LC . X)))) (3RD X (ORR ((LC . X) (LC . X) (LC . X)))) (%%F
(X Y) (E (EDITQF (L-CASE (QUOTE X) (QUOTE Y))) T)) (%% X (COMS (CONS (CAR (QUOTE X)) (COMMENT3 (CDR (QUOTE X)) (CAR (LAST L)))))) (
NEX NIL (BELOW _) NX) (NEX (X) (BELOW X) NX) (REPACK NIL (IF (LISTP (##)) (1) NIL) (I : ((LAMBDA (X Y) (SETQ COM (QUOTE REPACK)) (
SETQ Y (APPLY (QUOTE CONCAT) (EDITE (UNPACK X)))) (COND ((NOT (STRINGP X)) (SETQ Y (MKATOM Y)))) (PRINT Y T T)) (##)))) (REPACK (X) 
(LC . X) REPACK) (>* (X) (BIND (MARK #1) 0 (_ ((*ANY* PROG PROGN COND SELECTQ LAMBDA NLAMBDA ASSEMBLE) --)) (MARK #2) (E (SETQ #3 (
SELECTQ (## 1) ((COND SELECTQ) 2) 1)) T) (\ #1) (ORR (1 1) (1) NIL) (BELOW (\ #2) #3) (IF (QUOTE X) ((ORR (NX (B X)) ((IF (EQ (## (\
 #2) 0 1) (QUOTE PROG)) NIL (BK)) (A X)) ((\ #2) (>* X)))) NIL))) (SHOW X (F (*ANY* . X) T) (LPQ MARK (ORR (1 !0) NIL) P __ (F (
*ANY* . X) N)) (E (QUOTE done))) (EXAM X (F (*ANY* . X) T) (BIND (LPQ (MARK #1) (ORR (1 !0 P) NIL) (MARK #2) TTY: (MARK #3) (IF (EQ 
(## (\ #3)) (## (\ #2))) ((\ #1)) NIL) (F (*ANY* . X) N))) (E (QUOTE done))) (PP* NIL (RESETVAR **COMMENT**FLG NIL PP)))
(ADDTOVAR EDITCOMSA CAP LOWER RAISE NEX REPACK PP*)
(ADDTOVAR EDITCOMSL LOWER RAISE 2ND 3RD %%F %% REPACK * >* EXAM SHOW)
(ADDTOVAR DONTSAVEHISTORYCOMS PP*)
(RPAQ? EDITCHARACTERS)
(RPAQQ NEGATIONS ((NEQ . EQ) (NLISTP . LISTP) (GO . GO) (ERROR . ERROR) (ERRORX . ERRORX) (RETURN . RETURN) (RETFROM . RETFROM) (
RETTO . RETTO) (IGREATERP . ILEQ) (ILESSP . IGEQ)))
(ADDTOVAR EDITMACROS (NXP NIL (ORR (NX) (!NX (E (PRIN1 "> " T) T)) ((E (PROGN (SETQQ COM NX) (ERROR!))))) P) (-1P NIL (ORR (-1 P) ((
E (PROGN (SETQQ COM -1) (ERROR!)))))) (BKP NIL (ORR (BK) (!0) ((E (PROGN (SETQQ COM BK) (ERROR!))))) P) (2P NIL (ORR (2) (1) ((E (
PROGN (SETQQ COM 2) (ERROR!))))) P))
(ADDTOVAR EDITCOMSA NXP -1P BKP 2P)
(ADDTOVAR COMPACTHISTORYCOMS 2P NXP BKP -1P)
(ADDTOVAR COMPACTHISTORYCOMS 2P NXP BKP -1P)
(ADDTOVAR EDITMACROS (EV NIL (ORR ((E (LISPXEVAL (LIST (QUOTE EDITV) (FIRSTATOM (##))) (QUOTE EV->)))) ((E (QUOTE EV?))))) (EP NIL (
ORR ((E (LISPXEVAL (LIST (QUOTE EDITP) (FIRSTATOM (##))) (QUOTE EP->)))) ((E (QUOTE EP?))))) (EF NIL (ORR ((E (LISPXEVAL (LIST (
QUOTE EDITF) (FIRSTATOM (##))) (QUOTE EF->)))) ((E (QUOTE EF?))))))
(ADDTOVAR EDITCOMSA EV EP EF)
(ADDTOVAR DONTSAVEHISTORYCOMS EF EV EP)
(ADDTOVAR DONTSAVEHISTORYCOMS EF EV EP)
(ADDTOVAR USERMACROS (IFY NIL (F (COND --) T) UP (I 1 (COND.TO.IF (CDR (## 1)))) 1))
(ADDTOVAR EDITMACROS (BQUOTE NIL UP (ORR ((I 1 (OR (CONS (QUOTE BQUOTE) (OR (BQUOTIFY (## 1)) (ERROR!))) (ERROR!)))) ((E (QUOTE 
BQUOTE?)))) 1) (SWAP (LC1 LC2) (BIND (MARK #3) (LC . LC1) UP (MARK #1) (\ #3) (LC . LC2) UP (IF (NOT (OR (FMEMB (CAAR #1) L) (FMEMB 
(CAAR L) #1))) ((E (SETQ #2 (CAR (##))) T) (\ #1) (E (SETQ #1 (CAR (##))) T) (I 1 #2) \ (I 1 #1)) ((E (QUOTE (NESTED EXPRESSIONS))))
) (\ #3))) (EVAL NIL (ORR ((E (LISPXEVAL (## (ORR (UP 1) NIL)) (QUOTE *)))) ((E (QUOTE EVAL?))))) (GO (LAB) (ORR ((_ ((*ANY* PROG 
ASSEMBLE DPROG RESETLST) -- LAB --)) F LAB (ORR 2 1) P) ((E (PROGN (SETQQ COM LAB) (ERROR!)))))) (JOINC NIL (F COND T) UP (BI 1 2) 1
 (BO 2) (2) (RO 1) (BO 1)) (NEGATE NIL UP (I 1 (NEGATE (## 1))) 1) (SPLITC (X) (F COND T) (BI 1 X) (IF (AND (EQ (## 2 1) T) (## 2 2)
 (NULL (CDDR (##)))) ((BO 2) (2)) ((-2 COND) (LI 2))) UP (BO 1)) (SWAPC NIL (F ((*ANY* COND IF if) --) T) UP (I 1 (SWAPPEDCOND (## 1
))) 1) (MAKE (VAR . VALS) (COMS (MAKECOM VAR VALS))) (D NIL (:) 1 P) (Q NIL (MBD QUOTE)) (MAKEFN (FORM ARGS N M) (IF (QUOTE M) ((BI 
N M) (LC . N) (BELOW \)) ((IF (QUOTE N) ((BI N -1) (LC . N) (BELOW \)) ((LI 1))))) (E (MAKEFN (QUOTE FORM) (QUOTE ARGS) (##)) T) UP 
(1 FORM) 1) (GETD NIL UP (ORR ((I 1 (OR (EDITGETD (## 1) (AND (CDR L) (EDITL0 L (QUOTE (!0))))) (ERROR!)))) ((E (QUOTE GETD?)))) 1) 
(GETVAL NIL UP (ORR ((I 1 (EVAL (## 1) (QUOTE *)))) ((E (QUOTE GETVAL?)))) 1))
(ADDTOVAR EDITCOMSA BQUOTE JOINC EVAL NEGATE SWAPC D Q GETD GETVAL)
(ADDTOVAR EDITCOMSL SPLITC MAKE MAKEFN SWAP GO)
(RPAQ? INITIALS)
(RPAQ? INITIALSLST)
(RPAQ? DEFAULTINITIALS (QUOTE edited:))
(MOVD? (QUOTE NILL) (QUOTE PREEDITFN))
(PUTPROPS WEDIT COPYRIGHT ("Xerox Corporation" 1982 1983 1984))
NIL
