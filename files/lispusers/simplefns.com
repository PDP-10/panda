(FILECREATED "11-JUL-82 23:42:06" ("compiled on " <LISPUSERS>SIMPLEFNS.;5) (2 . 2) brecompiled exprs: 
nothing in USYS dated "11-JUL-82 23:39:35")
(FILECREATED "11-JUL-82 23:41:59" <LISPUSERS>SIMPLEFNS.;5 8475 changes to: (VARS SIMPLEFNSCOMS) 
previous date: " 2-MAR-82 09:09:24" <LISPUSERS>SIMPLEFNS.;4)
OCCURRENCES BINARY
             -.           -.          -.     @     ,~   Zp  ,<8 ,  Z   ,~   Z   Zp  2B  +      ."   ,   XB  
+    Zp  -,   +   Z   +    Zp  ,<   ,  [p  ,<   ,  +    a     (VARIABLE-VALUE-CELL ITEM . 16)
(STRUCTURE . 1)
(VARIABLE-VALUE-CELL ITEM . 0)
(VARIABLE-VALUE-CELL COUNT . 23)
*OCCURRENCES*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL ITEM . 0)
(0 VARIABLE-VALUE-CELL COUNT . 0)
(KT SKNLST URET1 MKN BINDB BLKENT ENTERF)           x                    
COMBINATIONS BINARY
        0    .    /-.           .[`  3B   +   "[`  B  .,<   ,<   ,<   ,<   Zw~-,   +   Zw+    Zw~,<   Z`  ,<   ,<   Zw-,   +   Zp  Z   2B   +    "  +   [  QD   "  +   Zw,<   Zp  Zw~,   /   Zp  ,   XBp  [wXBw+   /  XBp  -,   +    Zw3B   +   Zp  QD  +   Zp  XBw       [  2D   +   XBw[w~XBw~+   Z`  ,<   ,<   Zw-,   +   *Zp  Z   2B   +   ( "  +   )[  QD   "  +    Zw,   Zp  ,   XBp  [wXBw+   #@@Q I"@  (CLIST . 1)
COMBINATIONS
(CONSNL URET2 SKLST COLLCT BHC CONS URET4 SKNLST KNIL ENTER1)   8   (      H      P   H      P   x   p & @   0  `   h   X        
DKILL BINARY
     !         -.           Z` -,   +   ,~   Z`  Z` 2B  +   Z` [` 2B  +   Z` Z   XD  Z   QD  Z   ,~   [` 3B   +   Z` [` Z  XD  [` [  QD  ,~   Z` Z   XD  Z   ,~   ,<` [p  -,   +   Z`  [p  Z  2B  +   Zp  [p  [  QD  +   Z` ,<   [wXBw,\  3B  +   +   Z` +    @  0 (X . 1)
(L . 1)
(URET1 SKLST KNIL SKNLST ENTER2) x   P   0  H    	           
DKILLQ BINARY
            -.           ,<`  ,<` "  D  ,~       (X . 1)
(L . 1)
EVAL
DKILL
(ENTER2)     
FILE BINARY
    1    %    /-.         %[`  3B   +   Z`  B  &,<   [`  Z  -,   +   [`  [  2B   +   [`  Z  Z 7@  7   Z  +   [`  D  ',<  '"  (,<   @  (  ,~   ,<  (Z   ,<   ,   ,   Z   ,   XB  XB` ,<  *,<  +,<   @  + ` +   Z   Z  -XB ZwZ8  B  -Zw~XB8 Z   ,~   2B   +   Z  .XB   [` XB  ,<  (Z` Z  [  D  .Z  3B   +   $   /,~   Z` ,~   B$*1	     (ARGS . 1)
(VARIABLE-VALUE-CELL RESETVARSLST . 62)
FILECOMS
/SETATOMVAL
10
RADIX
(VARIABLE-VALUE-CELL OLDVALUE . 33)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 68)
((DUMMY) . 0)
INTERNAL
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
MAKEFILE
ERROR
APPLY
ERROR!
(KT CF CONS CONSNL LIST2 KNOB SKLA KNIL ENTER1)   H      @   0   (   8    h   8  h   0      
FIRSTPART BINARY
        	    -.           	,<`  ,<` "  
D  XB`  3B   +   Z` [`  ,   3B   +   Z`  ,~   Z   ,~   @  (WHOLE . 1)
(TAIL . 1)
LENGTH
LASTN
(EQUAL KNIL ENTER2)   p      P      
IFF BINARY
         	    
-.           	Z`  2B   +   7   Z   ,<   Z` 2B   +   7   Z   ,\  2B  7   Z   ,~      (ARG1 . 1)
(ARG2 . 1)
(KT KNIL ENTER2)    @      `   0      
KILL BINARY
        
    -.           
Z` -,   +   ,~   Z`  Z` 2B  +   [` ,~   Z` ,<   ,<`  [` D  ,   ,~     (ELT . 1)
(LIST . 1)
KILL
(CONSS1 SKNLST ENTER2)   
           
LEAVES BINARY
            -.           Z`  -,   +   ,   ,~   ,<   ,<   ,<   ,<   Zw~-,   +   Zw+    Zw~B  XBp  -,   +   Zw3B   +   Zp  QD  +   Zp  XBw       [  2D   +   XBw[w~XBw~+    DI    (X . 1)
LEAVES
(SKLST URET4 KNIL CONSNL SKNLST ENTER1)       	     H   `           0      
SEARCH BINARY
               -.           ,<` ,<   ,<   ZwXBp  Zp  -,   +   +   Z`  Zp  2B  +   	Zp  +    ,<`  ZwD  XBw3B   +   Zw+    [p  XBp  +   +   !`(ELT . 1)
(STRUCT . 1)
SEARCH
(URET3 SKNLST KNIL ENTER2)  X 	          8        
SINGLES BINARY
                -.           Z`  -,   +   ,<   ,<   ,<   ,<   Z`  -,   +   +   Z  XBp  -,   +   Zp  Zw~,   3B   +   +   ,<   ,<w~$  3B   +   +   Zp  XBwZw3B   +   ,<   Zw,   XBw~,\  QB  +   Zw,   XBwXBw~[`  XB`  +   ZwZ`  QD  Zw~+    ,~   2a   (LST . 1)
MEMBER
(URET4 CONSNL FMEMB SKLA SKNLST KNIL SKLST ENTER1)  8   h         	         h   X   H            
STRINGSUBST BINARY
    {    q    x-.            qZ` -,   +   B  sXB` ,<`  "  s,<   ,<` "  s,<    w,>  p,>    p      ,^   /   2B  +   Z` 3B   +   ,<` "  t+   ,<` "  sXB` ,<   ,<  t,<` ,<` ,<w&  uXBp  2B   +   +   ,<` ,<   ,<`  &  u p  ,>  p,>    w~.Bx  ,^   /   ,   XBp  +   Zw/  +   o w,>  p,>    p      ,^   /   2"  +   JZ` 3B   +   %,<` "  t+   &,<` "  sXB`  w,>  p,>    p      ,^   /   /  /"   ,   ,<   ,<   ,<   ,<  t,<` ,<` ,<w&  uXBp  2B   +   1+   I,<` ,<   ,<`  &  u,<`  w,>  p,>    w}.Bx  ,^   /   ,   ,<   ,<   Z  vH  vXBw3B   +   A,<`  w,>  p,>    w}.Bx  ,^   /   ,   ,<   ,<w~&  u,<` ,<  t,<w},<` (  v p  ,>  p,>    w}.Bx  ,^   /   ,   XBp  +   -Zw/  +   o,<   ,<   ,<  t,<` ,<` $  u3B   +   P,<` "  tXB` +   UZ` 3B   +   S,<` "  t+   n,<` "  s+   nZp  2B   +   W+   l,<w,<` ,<   ,<` ,<` F  uXBw~3B   +   b w~/"   ,   ,<    w~,>  p,>    w|.Bx  ,^   /   ,   XBw~,\   F  vXBw3B   +   h,<   Zw3B   +   gZ`  ,   ,   +   kZw3B   +   kZ`  ,   D  wXBw+   UZ  t,<   ,<w~$  w/  XB` Z` +        %R&(	i &I ) $JRl` 	Id    (NEW . 1)
(OLD . 1)
(STRING . 1)
(COPYFLG . 1)
MKSTRING
NCHARS
CONCAT
1
STRPOS
RPLSTRING
""
SUBSTRING
NCONC
APPLY
(URET2 CONSS1 CONSNL MKN KNIL BHC SKNSTP ENTER4)   q    h    k       ] 	 @  , 8     f H [ 
h R 	h L 	8 ;  1 X - 8       o  J 	  @   *   0            
SUBSETP BINARY
                -.           ,<`  ,<   ,<   Zw-,   +   +   Z  XBp  ,<   ,<` $  3B   +   	+   
Z   +    [wXBw+   Z   +    0X  (SMALL . 1)
(LARGE . 1)
MEMBER
(KT URET3 SKNLST KNIL ENTER2)   H   P 
        
    0      
UNATTACH BINARY
             -.           Z`  -,   +   [`  Z  XD  [`  [  QD  ,~   Z   ,~       (L . 1)
(KNIL SKLST ENTER1)    x    0      
(PRETTYCOMPRINT SIMPLEFNSCOMS)
(RPAQQ SIMPLEFNSCOMS ((DECLARE: EVAL@COMPILE DONTCOPY (P (RESETSAVE DWIMIFYCOMPFLG T))) (FNS 
COMBINATIONS DKILL DKILLQ FILE FIRSTPART IFF KILL LEAVES SEARCH SINGLES STRINGSUBST SUBSETP UNATTACH) 
(PROP MACRO IFF) (COMS (FNS OCCURRENCES OCCURRENCES1) (BLOCKS (OCCURRENCES OCCURRENCES OCCURRENCES1)))
 (LOCALVARS . T) (DECLARE: DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA FILE) (
NLAML DKILLQ) (LAMA)))))
(PUTPROPS IFF MACRO ((ARG1 ARG2) (EQ (NOT ARG1) (NOT ARG2))))
NIL
