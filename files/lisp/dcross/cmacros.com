(FILECREATED "14-Aug-84 01:14:49" ("compiled on " <NEWLISP.DCROSS>CMACROS..1) (2 . 2) bcompl'd in "INTERLISP-10  14-Aug-84 ..." 
dated "14-Aug-84 00:36:23")
(FILECREATED " 5-MAR-83 00:26:43" <BLISP>CMACROS.;48 3645 changes to: (FNS \FIXCODEPTR) previous date: "13-FEB-83 16:38:06" 
<BLISP>CMACROS.;47)
(SELECTQ (SYSTEMTYPE) ((ALTO D) (SHOULDNT)) NIL)

\FIXCODEPTR BINARY
          
    -.           
Z   ,<   Z   ,<  Z   B  F  Z  ,<      /"  ,   ,<   Z  B  F  Z  ,~   0  (VARIABLE-VALUE-CELL A . 10)
(VARIABLE-VALUE-CELL POS . 12)
(VARIABLE-VALUE-CELL PTR . 19)
\LOLOC
\FIXCODENUM
\HILOC
\BYTESETA
(MKN ENTERF)          

\HILOC BINARY
               -.           Z   -,   +   Z"   ,~   -,   +   
   3b  +   
       ^"   3b  +   
Z"  ,~   Z  -,   +      
1"   +          ^"3"  +   Z"  ,~   Z"  ,~   ~  $     (VARIABLE-VALUE-CELL X . 26)
(SKI ASZ SKLA ENTERF)     P                  

\LOLOC BINARY
       6    2    4-.          2Z   -,   +   2B   +   Z"   ,~   Z  Z   ,   ,<   @  3   +   Z   3B   +   Z  g  [  2B   9     ,   ,~   Z  ,<  Z  [  ,   ,\  QB  Z  ,<   Z  ,   ."   ,       ,\   XD  Z  ,~   ,~   -,   +      3b  1+          ^"3"  +      A",   ,~   Z  ,<   Z   D  4,<   @  3   +   1Z  
3B   +   (Z  "g  [  2B   9  %   ,   ,~   Z  ,<  Z  [  (,   ,\  QB  Z  ),<   Z  +,   ."   ,       ,\   XD  Z  ,~   ,~   ~  @R  a T    (VARIABLE-VALUE-CELL X . 82)
(VARIABLE-VALUE-CELL ATOMLIST . 37)
(VARIABLE-VALUE-CELL PTRLIST . 89)
(VARIABLE-VALUE-CELL R . 72)
MEMBER
(SKI IUNBOX CONS MKN FMEMB ASZ KNIL SKLA ENTERF)     `     +    p ( h  `    p    P   h $ H 
  @    0      

\VAG2 BINARY
      ,    (    *-.          (Z   0B   +   Z   0B   +   Z   ,~   Z   ,<   Z  ,   ,>  ',>          ,^   /   /  ."      ,\   5d      Z   ,   +   [  2B   =d  Z  ,~   0B  +   Z  ,~   0B  +   ^",>  ',>      FBx  ,^   /   "   ,   ,~   0B  +   &Z   ,<   Z  ,   ,>  ',>          ,^   /   /  ."      ,\   5d  $    Z   ,   +   %[  2B   =d  $Z  ,~      *,~        $E @    (VARIABLE-VALUE-CELL HI . 3)
(VARIABLE-VALUE-CELL LO . 59)
(VARIABLE-VALUE-CELL ATOMLIST . 13)
(VARIABLE-VALUE-CELL PTRLIST . 55)
SHOULDNT
(MKN CONS BHC IUNBOX KNIL ASZ ENTERF)       $ p      0   P     % 8  h      H   H        

CATOMNAME BINARY
            -.           ,<  Z   D  ,~       (VARIABLE-VALUE-CELL X . 4)
0
\VAG2
(ENTERF)     
(PRETTYCOMPRINT CMACROSCOMS)
(RPAQQ CMACROSCOMS ((* IMPLEMENTS PSEUDO DEFINITIONS FOR HILOC, VAG2, ETC. IN INTERLISP-10) (DECLARE: FIRST (P (SELECTQ (SYSTEMTYPE)
 ((ALTO D) (SHOULDNT)) NIL))) (FNS \FIXCODEPTR \HILOC \LOLOC \VAG2 CATOMNAME) (P (MAPC (QUOTE (\ATOMVALINDEX \ATOMDEFINDEX 
\ATOMPNAMEINDEX \ATOMPROPINDEX)) (FUNCTION (LAMBDA (X) (MOVD? (QUOTE \LOLOC) X)))) (MAPC (QUOTE (\INDEXATOMVAL \INDEXATOMDEF 
\INDEXATOMPNAME \INDEXATOMPROP)) (FUNCTION (LAMBDA (X) (MOVD? (QUOTE CATOMNAME) X))))) (VARS (ATOMLIST (QUOTE (0))) (PTRLIST (QUOTE 
(0)))) (DECLARE: EVAL@COMPILE DONTCOPY (GLOBALVARS ATOMLIST PTRLIST))))
(MAPC (QUOTE (\ATOMVALINDEX \ATOMDEFINDEX \ATOMPNAMEINDEX \ATOMPROPINDEX)) (FUNCTION (LAMBDA (X) (MOVD? (QUOTE \LOLOC) X))))
(MAPC (QUOTE (\INDEXATOMVAL \INDEXATOMDEF \INDEXATOMPNAME \INDEXATOMPROP)) (FUNCTION (LAMBDA (X) (MOVD? (QUOTE CATOMNAME) X))))
(RPAQQ ATOMLIST (0))
(RPAQQ PTRLIST (0))
(PUTPROPS CMACROS COPYRIGHT ("Xerox Corporation" 1983))
NIL
