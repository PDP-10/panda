(FILECREATED "14-Aug-84 01:59:24" ("compiled on " <NEWLISP.DCROSS>DCODEFOR10..5) (2 . 2) recompiled changes: nothing in 
"INTERLISP-10  14-Aug-84 ..." dated "14-Aug-84 00:36:23")
(FILECREATED "14-Aug-84 01:59:16" <NEWLISP.DCROSS>DCODEFOR10..5 16631 changes to: (VARS DCODEFOR10COMS) previous date: 
"14-Aug-84 01:56:23" <NEWLISP.DCROSS>DCODEFOR10..4)
(MOVD? (QUOTE OPENFILE) (QUOTE 10OPENFILE))
(MOVD? (QUOTE ARRAYSIZE) (QUOTE OLDARRAYSIZE))
NTHCHARCODE BINARY
              -.            Z   3B   +   Z   ,<  Z   ,<  ,<  Z   H  B  ,~   Z  -,   +   +   -,   +   ."  [  XB  +   ,<  Z  ,<  Z  ,<  Z  H  B  ,~         Z  ,   7   ..  4n  0n   +   /.  &.  .&8  `  =0  "  1B   "  ."   +   Z   ,~     (VARIABLE-VALUE-CELL X . 36)
(VARIABLE-VALUE-CELL N . 34)
(VARIABLE-VALUE-CELL FLG . 28)
(VARIABLE-VALUE-CELL RDTBL . 30)
NTHCHAR
CHCON1
(ASZ UPATM SKLA SKSTP KNIL ENTERF)              	      0      
ASSIGNDATATYPE BINARY
            -.     (      Z   ,~       (VARIABLE-VALUE-CELL NAME . 0)
(VARIABLE-VALUE-CELL DESCRIPTORS . 0)
(VARIABLE-VALUE-CELL SIZE . 0)
(VARIABLE-VALUE-CELL SPECS . 0)
(VARIABLE-VALUE-CELL PTRFIELDS . 0)
(KNIL ENTERF)          
INFILE BINARY
        
    -.           
Z   3B   +   ,<  ,<  $  2B   +   	Z  ,<  ,<  ,<  &  +   	Z   B  ,~   it  (VARIABLE-VALUE-CELL FILE . 11)
INPUT
OPENP
OLD
OPENFILE
(KNIL ENTERF)    0      
OPENFILE BINARY
             -.     (      Z   ,<  Z   ,<  Z   ,<  Z   2B   +   Z  2B  +   +   2B  +   +   2B  +   +   Z  2B  +   Z  ,<  ,<  $  XB  +   Z   ,<  Z   J  ,~   YQ     (VARIABLE-VALUE-CELL FILE . 25)
(VARIABLE-VALUE-CELL ACCESS . 22)
(VARIABLE-VALUE-CELL RECOG . 12)
(VARIABLE-VALUE-CELL BYTESIZE . 29)
(VARIABLE-VALUE-CELL MACHINE.DEPENDENT.PARAMETERS . 33)
NEW
OLD
OLD/NEW
INPUT
BYTESIZE
GETFILEINFO
10OPENFILE
(KNIL ENTERF)         
AIN BINARY
       ;    ą    9-.     (     ąZ   ,<  ,<  ī$  5,<  Z   ,<  @  ĩ @ ,~   Z   ,   ,<  ,<  ķ$  71B  +      ·Z  ,>  °,>  Z   2B   +   Z   Z   ,   2B  8+       A"  $"     ^"  /  (B  ,>  °,>     (B.Bx  ,^  /  .  1."  +   §2B  ļ+   Ķ   ,>  °,>     .Bx  ,^  /  ,   XB      A"  $"     ^"  /  (B  ,>  °,>     (Bĸ.Bx  ,^  /  .  1."  +   §   ·,   ,>  °,>  Z  .Bx  ,^  /  ,>  °,>     "     ,^  /  ,^  /     Z   ,~          "P A        (VARIABLE-VALUE-CELL ARRAY . 81)
(VARIABLE-VALUE-CELL INDEX . 69)
(VARIABLE-VALUE-CELL N . 54)
(VARIABLE-VALUE-CELL FILE . 3)
(VARIABLE-VALUE-CELL ATYP . 24)
(VARIABLE-VALUE-CELL ARRAYTYPHA . 28)
OUTPUT
GETSTREAM
(VARIABLE-VALUE-CELL FF . 21)
(VARIABLE-VALUE-CELL NBYTES . 87)
OPENBYTESIZE
GETFILEINFO
SHOULDNT
CODE
SMALLPOSP
(IUNBOX BHC GETHSH KNIL ASZ MKN ENTERF)     x Ū 0 Ĩ X         ° X       `        
AOUT BINARY
      ŧ    2    đ-.     (     2Z   ,<  ,<  5$  ĩ,<  Z   ,<  @  6 @ +   0Z   ,   ,<  ,<  7$  ·1B  +      8Z  ,>  1,>  Z   2B   +   Z   Z   ,   2B  ļ+       A"  $"     ^"  /  (B  ,>  1,>     (B.Bx  ,^  /  .  ą."  +   §2B  9+   Ķ   ,>  1,>     .Bx  ,^  /  ,   XB      A"  $"     ^"  /  (B  ,>  1,>     (Bĸ.Bx  ,^  /  .  ą."  +   §   8,   ,>  1,>  Z  .Bx  ,^  /  ,>  1,>     "     ,^  /  ,^  /     ,~   Z  Ļ,~          
"P A        (VARIABLE-VALUE-CELL ARRAY . 96)
(VARIABLE-VALUE-CELL INDEX . 69)
(VARIABLE-VALUE-CELL N . 54)
(VARIABLE-VALUE-CELL FILE . 3)
(VARIABLE-VALUE-CELL ATYP . 24)
(VARIABLE-VALUE-CELL ARRAYTYPHA . 28)
OUTPUT
GETSTREAM
(VARIABLE-VALUE-CELL FF . 21)
(VARIABLE-VALUE-CELL NBYTES . 87)
OPENBYTESIZE
GETFILEINFO
SHOULDNT
CODE
SMALLPOSP
(IUNBOX BHC GETHSH KNIL ASZ MKN ENTERF)     x Ū 0 Ĩ X             
            
NEWARRAYSIZE BINARY
              -.          Z   Z   ,   2B  +   Z  B  ,   /"  (B  ,   ,~   2B  +   Z  B  ,   (B  ,   ,~   Z  B  ,~   P4 (VARIABLE-VALUE-CELL A . 23)
(VARIABLE-VALUE-CELL ARRAYTYPHA . 4)
CODE
OLDARRAYSIZE
WORD
(MKN IUNBOX GETHSH ENTERF) 8       `    8      
\CODEARRAY BINARY
                -.          ^"  ,>  ,>      ."  (B.Bx  ,^  /  ,   ,<  ^"  ,>  ,>     ."  (B.Bx  ,^  /  ,   D  ,<  @     ,~   Z   ,<  ,<  Z  F  Z  ,<  ,<  Z   F  Z  ,~       

P    (VARIABLE-VALUE-CELL NBYTES . 32)
(VARIABLE-VALUE-CELL NTSIZE . 0)
(VARIABLE-VALUE-CELL ARRAYTYPHA . 37)
ARRAY
(VARIABLE-VALUE-CELL A . 39)
1
SETA
CODE
PUTHASH
(MKN BHC ENTERF) H       h      
\BYTELT BINARY
              -.           Z   ,>  ,>      (B.Bx  ,^  /  ."     ,>  ,>     A"  $"     ^"  /  "     ,^  /  (B  A"  ĸ,   ,~        (VARIABLE-VALUE-CELL CA . 3)
(VARIABLE-VALUE-CELL LOC . 15)
(MKN BHC ENTERF)   h   P        
\BYTESETA BINARY
      $    Ą    #-.           ĄZ   ,>  ,>      (B.Bx  ,^  /  ."  XB     A"  ,   0B   +   Z  ,<         ,\  d     ,   ,~   0B  +   Z  	,<     
   ,\  d      ,   ,~   0B  +   Z  ,<        ,\  d      ,   ,~   0B  +   Z  ,<        ,\  d  !   ,   ,~   Z   ,~     8   (          AA  (VARIABLE-VALUE-CELL CA . 51)
(VARIABLE-VALUE-CELL LOC . 13)
(VARIABLE-VALUE-CELL NEWVAL . 53)
(KNIL ASZ MKN BHC ENTERF)   p     h 	       X            
\FIXCODENUM BINARY
            -.           Z   ,<      /"  ,   ,<      (B|,   F  Z  ,<  Z  ,<  Z  F  Z  ,~     (VARIABLE-VALUE-CELL A . 13)
(VARIABLE-VALUE-CELL POS . 15)
(VARIABLE-VALUE-CELL VAL . 19)
\BYTESETA
(MKN ENTERF)    H      
POINTERARRAY BINARY
              -.          Z   ,<  ,<   Z   F  ,<  @     ,~   Z   ,<  ,<  Z   F  Z  ,~   PP  (VARIABLE-VALUE-CELL N . 3)
(VARIABLE-VALUE-CELL INIT . 6)
(VARIABLE-VALUE-CELL ARRAYTYPHA . 15)
ARRAY
(VARIABLE-VALUE-CELL A . 17)
POINTER
PUTHASH
(KNIL ENTERF)    8      
ELT0 BINARY
            -.           Z   ,<      ."  ,   D  ,~       (VARIABLE-VALUE-CELL A . 3)
(VARIABLE-VALUE-CELL N . 5)
ELT
(MKN ENTERF)  H      
SETA0 BINARY
                -.           Z   ,<      ."  ,   ,<  Z   F  ,~      (VARIABLE-VALUE-CELL A . 3)
(VARIABLE-VALUE-CELL N . 5)
(VARIABLE-VALUE-CELL V . 9)
SETA
(MKN ENTERF)  H      
ADD1A BINARY
            	    -.           	Z   ,<      ."  ,   XB  ,<  Z  ,<  D  
,   ."  ,   F  ,~     (VARIABLE-VALUE-CELL A . 10)
(VARIABLE-VALUE-CELL N . 8)
ELT
SETA
(IUNBOX MKN ENTERF)   x           
ARRAYREFC BINARY
              -.           Z   ,<  [  Z  ,<  @   @,~   Z   -,   +   7   Z   XB   3B   +   ,<  Z  ,<  ,   XB  
,<  Z   ,<  Z  ,<  ,   ,<  Z  -,   +   Z  +   Z  F  ,<  Z  3B   +   Z"  +   ^"x,   ,   ,~   !b@   (VARIABLE-VALUE-CELL X . 5)
(VARIABLE-VALUE-CELL A . 31)
(VARIABLE-VALUE-CELL N . 27)
(NIL VARIABLE-VALUE-CELL U . 39)
VAG
((A N) . 0)
((ASSEMBLE NIL (CQ N) (VAR (ADD 1 , A))) . 0)
((VAG (IPLUS (LOC A) (LOC N))) . 0)
SUBPAIR
(CONSS1 MKN ASZ SKLA LIST2 KNIL KT SKNLA ENTERF)                   @   P          p      
ARRAYSTOREC BINARY
       Ą         -.     (      [   Z  -,   +   Z  +   Z  ,<  @     ,~   Z  -,   +   Z   ,<  ,<  $  +   ,<  Z  ,<  ,<  &  XB  ,<  Z  ,<  ,<  Z   ,<  ,<  Z   ,<  ,<  Z   ,<  ,<  Z   ,<  ,<  2  F   ,~   tfH$p   (VARIABLE-VALUE-CELL X . 29)
(VARIABLE-VALUE-CELL PREL . 32)
(VARIABLE-VALUE-CELL POSTL . 35)
(VARIABLE-VALUE-CELL OPL . 38)
(VARIABLE-VALUE-CELL SETL . 41)
(((CQ N) (SUBI 1 , ASZ -2)) . 0)
(((CQ (VAG (IPLUS N 2)))) . 0)
(VARIABLE-VALUE-CELL N . 27)
(((VAR (HRRZ 2 , A))) . 0)
APPEND
(((CQ A) (PUSH PP , 1)) . 0)
(((POP PP , 2)) . 0)
((A N V) . 0)
((ASSEMBLE NIL) . 0)
(((CAIL 1 , 2) (CAML 1 , 0 (2)) (JUMPA BAD) (ADD 2 , 1)) . 0)
(((JUMPA GOOD) BAD (PUSH PP , 2) (ADDI 1 , ASZ -2)) . 0)
((GOOD) . 0)
SUBPAIR
(SKLA ENTERF)         
WORDARRAY BINARY
              -.              ."  (Bĸ,   XB  ,<  D  ,<  @     ,~   Z   ,<  ,<  Z   F  Z  ,~     (VARIABLE-VALUE-CELL N . 7)
(VARIABLE-VALUE-CELL ARRAYTYPHA . 17)
ARRAY
(VARIABLE-VALUE-CELL A . 19)
WORD
PUTHASH
(MKN ENTERF)         
FIXPARRAY BINARY
              -.          Z   ,<  D  ,<  @  
   ,~   Z   ,<  ,<  Z   F  Z  ,~   B@  (VARIABLE-VALUE-CELL N . 3)
(VARIABLE-VALUE-CELL ARRAYTYPHA . 13)
ARRAY
(VARIABLE-VALUE-CELL A . 15)
FIXP
PUTHASH
(ENTERF)      
UNIQUE# BINARY
      (    Ē    Ķ-.          ĒZ   "   +   Ą   A" ĸ,   ,<  @  Ģ  ,~   Z   2B   +   ,<  %"  ĨXB  ,>  ",>  Z   .Bx  ,^  /  ZxXB   XB   Z  2B   +   Z  Z  ,   ,<  Z  /"Z  	,\  0"  2"  5   .  XF  5   ,<  .",<     F  &Z  ,~      ,>  ",>  Z  ,      ,^  /  2B  +    Z  ,~   [  XB   +   ,~     : !     (VARIABLE-VALUE-CELL X . 52)
(VARIABLE-VALUE-CELL UNIQUE#ARRAY . 37)
(VARIABLE-VALUE-CELL N . 35)
(NIL VARIABLE-VALUE-CELL LL . 65)
(NIL VARIABLE-VALUE-CELL L1 . 32)
512
POINTERARRAY
SETA0
(IUNBOX ASZ CONS BHC KNIL MKN SMALLT ENTERF)        0      h           P    0      
READBITMAP BINARY
                -.           Z   3B   +   ,<  Z   ,<  Z   ,<  ,   @  
D  ,~      
,~      (VARIABLE-VALUE-CELL WIDTH . 3)
(VARIABLE-VALUE-CELL HEIGHT . 7)
(VARIABLE-VALUE-CELL BPI . 9)
READ
APPEND
(LIST3 KNIL ENTERF)              
PRINTBITMAP BINARY
            -.           Z` -,   +   Z` Z 7@  7   Z  +   ,<  Zp  -,   Z   Z  -,   +   [p  -,   Z   Z  -,   +   [p  [  -,   Z   Z  -,   +   [p  [  -,   Z   Z  -,   +   ,<p  "  +   ,<  ,<   $  ,<` ,<   $  ,<  ,<   $  ,<   "  Z   +    &P  (BITMAP . 1)
PRINT
"********* "
PRIN1
" IS NOT A BITMAP REPRESENTATION."
TERPRI
(URET1 KT SKNSTP SKI KNIL SKLST KNOB SKLA ENTER1) @   (             H      (  8      h       X    0      
CREATEPOSITION BINARY
            -.            Z"   Z$   ,   ,~       (CONS ASZ ENTER0)        (      
CREATEREGION BINARY
              -.            ,<  ,<  ,<  ,<  ,   ,~       0
1000
(LIST4 ENTER0)    H      
CURSORCREATE BINARY
              -.           Z   ,<  Z   ,<  Z   ,<  ,   ,~       (VARIABLE-VALUE-CELL BM . 3)
(VARIABLE-VALUE-CELL X . 5)
(VARIABLE-VALUE-CELL Y . 7)
(LIST3 ENTERF)         
PRINTCURSOR BINARY
    9    0    7-.           0Z   Z 7@  7   Z  ,<  @  °  ,~   Z   -,   +   )Z  XB   -,   Z   Z  -,   +   )[  -,   Z   Z  -,   +   )[  [  -,   Z   Z  -,   +   [  [  -,   Z   Z  -,   +   )[  Z  -,   +   )[  [  Z  -,   +   )[  [  [  2B   +   ),<  ą,<   $  2Z  ,<  ,<   $  2,<  ē,<   $  3Z  ģ[  ,   Z  4,   ,<  ,<   $  2,<  ī,<   $  2,<   "  5Z  ĄB  ĩ+   /,<  6,<   $  2Z  ,<  ,<   $  2,<  ķ,<   $  2,<   "  5Z   ,~   @AC#25:@      (VARIABLE-VALUE-CELL VAR . 85)
(VARIABLE-VALUE-CELL VALUE . 79)
(NIL VARIABLE-VALUE-CELL BM . 35)
"(RPAQ "
PRIN1
1
SPACES
((READBITMAP) . 0)
CURSORCREATE
")"
TERPRI
PRINTBITMAP
"********* "
" IS NOT A CURSOR REPRESENTATION."
(KT CONS21 CONS SKNSTP SKI KNIL SKLST KNOB ENTERF)  p . H Š    $    #         p  `     0 x Ķ P ! x  @        8  H   x    @      
(PRETTYCOMPRINT DCODEFOR10COMS)
(RPAQQ DCODEFOR10COMS ((FNS NTHCHARCODE ASSIGNDATATYPE) (COMS (* I/O) (DECLARE: FIRST (P (MOVD? (QUOTE OPENFILE) (QUOTE 10OPENFILE))
)) (FNS INFILE OPENFILE) (DECLARE: DONTEVAL@LOAD DOCOPY (P (PRIN1 "relinking world..." T) (RELINK (QUOTE WORLD)) (TERPRI T))) (FNS 
AIN AOUT) (DECLARE: EVAL@COMPILE DONTCOPY (PROP (MACRO DMACRO) IEQ))) (COMS (* array access) (VARS (ARRAYTYPHA (LIST (HARRAY 100))))
 (DECLARE: FIRST (P (MOVD? (QUOTE ARRAYSIZE) (QUOTE OLDARRAYSIZE)))) (FNS NEWARRAYSIZE) (DECLARE: DONTEVAL@LOAD DOCOPY (P (MOVD (
QUOTE NEWARRAYSIZE) (QUOTE ARRAYSIZE)))) (COMS (* CODE ARRAYS) (FNS \CODEARRAY \BYTELT \BYTESETA \FIXCODENUM)) (COMS (* pointer 
arrays) (FNS POINTERARRAY) (FNS ELT0 SETA0 ADD1A) (DECLARE: EVAL@COMPILE DONTCOPY (PROP (DMACRO MACRO) * FAMACFNS) (FNS ARRAYREFC 
ARRAYSTOREC))) (COMS (* Integer arrays) (FNS WORDARRAY FIXPARRAY)) (COMS (* IGETHASH, IPUTHASH) (DECLARE: EVAL@COMPILE (PROP (MACRO 
DMACRO) IGETHASH IPUTHASH)) (FNS UNIQUE#) (VARS (UNIQUE#ARRAY)) (GLOBALVARS UNIQUE#ARRAY))) (COMS (* Display compatibility fns) (FNS
 READBITMAP PRINTBITMAP CREATEPOSITION CREATEREGION CURSORCREATE PRINTCURSOR)) (DECLARE: EVAL@COMPILE DONTCOPY (FILES (SYSLOAD) 
CJSYS (SOURCE) MODARITH))))
(PRIN1 "relinking world..." T)
(RELINK (QUOTE WORLD))
(TERPRI T)
(RPAQ ARRAYTYPHA (LIST (HARRAY 100)))
(MOVD (QUOTE NEWARRAYSIZE) (QUOTE ARRAYSIZE))
(PUTPROPS IGETHASH MACRO ((X ARR) (GETHASH (UNIQUE# X) ARR)))
(PUTPROPS IPUTHASH MACRO ((ITEM VAL HARRAY) (PUTHASH (UNIQUE# ITEM) VAL HARRAY)))
(PUTPROPS IGETHASH DMACRO T)
(PUTPROPS IPUTHASH DMACRO T)
(RPAQQ UNIQUE#ARRAY NIL)
(PUTPROPS DCODEFOR10 COPYRIGHT ("Xerox Corporation" 1984))
NIL
   