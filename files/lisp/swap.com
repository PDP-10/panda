(FILECREATED "30-Dec-83 01:37:26" ("compiled on " <NEWLISP>SWAP..7) (2 . 2) bcompl'd in WORK dated 
"30-Dec-83 01:23:53")
(FILECREATED " 8-OCT-78 02:25:01" <NETLISP>SWAP.;8 10538 changes to: SWAPCOMS MKSWAPP MKSWAP2 previous
 date: " 8-OCT-78 02:11:59" <NETLISP>SWAP.;7)

MKSWAPBLOCK BINARY
       E    3    C-.           3-.       3p 3            Zp  -,   +   ,<   ,  "+    b  43B   +   
Zp  +    Zp  -,   +   b  5-,   +   ,<  6,<w  7+    ,<p  ,<w  5,<   ,  "d  8Zp  +        ,<p    93B   +   ,<p  ,  *+    ,<p    42B   +   ,<  :,<w  7+    ,<p  ^"  ,>  2,>   ,<w  5,<   ,  *.Bx  ,^   /   d  8Zp  +    -.     :@  ;  ,~   Z   b  <XB  $b  =XB   b  >XB` ,<   Z  ?d  @Z` ,~   @  A  +   2Zw~,<8    =XB  &b  BXB  %Zw~,<8  Z  Cd  @Z  .,~   +       E(6E%Q#%      (MKSWAPBLOCK#0 . 1)
MKSWAP
MKUNSWAP
(NIL)
(LINKED-FN-CALL . SCODEP)
(NIL)
(LINKED-FN-CALL . GETD)
"MKSWAP -- Arg illegal:"
(NIL)
(LINKED-FN-CALL . ERROR)
(NIL)
(LINKED-FN-CALL . PUTD)
(NIL)
(LINKED-FN-CALL . SWPARRAYP)
"MKUNSWAP -- Arg illegal:"
*MKSWAP1*
((UNBOXED-NUM . 1) VARIABLE-VALUE-CELL ARR . 98)
(NIL VARIABLE-VALUE-CELL SIZE . 91)
NIL
(NIL)
(LINKED-FN-CALL . ARRAYBEG)
(NIL)
(LINKED-FN-CALL . ARRAYSIZE)
(NIL)
(LINKED-FN-CALL . SWPARRAY)
MKSWAP2
(NIL)
(LINKED-FN-CALL . SWPPOS)
(NIL VARIABLE-VALUE-CELL ARR . 0)
(NIL VARIABLE-VALUE-CELL SIZE . 0)
(NIL)
(LINKED-FN-CALL . ARRAY)
MKUNSWAP2
(BINDB BHC SKNAR SKLA KNIL URET1 SKAR BLKENT ENTER1)   0      P   8        0 " 8  8  (                

MKSWAP BINARY
               -.           ,<    ,~       (X . 1)
MKSWAP
(NIL)
(LINKED-FN-CALL . MKSWAPBLOCK)
(ENTER1)     

MKUNSWAP BINARY
                -.           ,<    ,~       (X . 1)
MKUNSWAP
(NIL)
(LINKED-FN-CALL . MKSWAPBLOCK)
(ENTER1)      

MKSWAP2BLOCK BINARY
      e    Y    b-.           Y-.      Zp [            ,<  \Zp  ,<   Z   "   ,\   B  Z  ,<   ,<w^"   ,>  X,>       .Bx  Zw~.Bx  ,^   /   ,<   ,  V[  3B  Y+   Z     1b   +   ,<w,<w  \,<wZ  ,<   ,<   ,  /,<w,<   ,  HZ   +        Zp     0"   +   Z  b  ],<p  Z  d  ^+    ,<p  Z  ,<   ^"   ,>  X,>      .Bx  Z  .Bx  ,^   /   ,<   ,  V[p  2B  Y+   (Z   +    Z   Z  ",<   ,   d  \,<p  Z  (,<   ,<   ,  /Z  +,<   ,<   ,  H+    -.     _ $  ,>  X,>  Z  -Z, Z`  Z. Z
  .*  Z` 2B   7  G   F2B8  +   9.x  .x  Z` 2B   +   B 8  3B0  +   >`b  +   @l"    B8  ..   2.  +   G9  :,>  ,<  `,^   d  a 0  3B8  +   Dd"   B0  ..   2.  +   G9  B-.   -.   /  ,~   Zp  3B   +   PZwZ$   Z 1F   XD   Z&   3D  OXF +   O-.   +    ZwZ$   Z 1F   XD   Z&   3D  UXF +   U-.   +    QwXwZp  *%   +            P ,H$ J h%R       (MKSWAP2BLOCK#0 . 1)
(VARIABLE-VALUE-CELL ARR . 100)
(VARIABLE-VALUE-CELL SIZE . 67)
MKSWAP2
MKUNSWAP2
2097152
(NIL)
(LINKED-FN-CALL . RELOC)
(NIL)
(LINKED-FN-CALL . CLRHASH)
(NIL)
(LINKED-FN-CALL . REHASH)
*BREGIFY*
((UNBOXED-NUM . 2) VARIABLE-VALUE-CELL ARR . 0)
"Unrelocatable instruction at location: "
(NIL)
(LINKED-FN-CALL . ERROR)
(URET3 ENTERB ENTERF SBLKNT BR BINDB MKN KT URET1 URET2 KNIL BHC BLKENT ENTER1)     
 L    R 	8   
@ P 	    `      (   p -      ( p   
h P    	  : h (   h   	 % h   
` N x        

MKSWAP2 BINARY
              -.           ,<    ,~       (BFPOS . 1)
MKSWAP2
(NIL)
(LINKED-FN-CALL . MKSWAP2BLOCK)
(ENTER1)    

MKUNSWAP2 BINARY
               -.           ,<    ,~       (BFPOS . 1)
MKUNSWAP2
(NIL)
(LINKED-FN-CALL . MKSWAP2BLOCK)
(ENTER1)     

MKSWAPP BINARY
              -.          Z   -,   +   Z  Z   ,   2B   +   Z   2B   +   Z   2B   +   
Z  B  XB  -,   +       ,>  ,>   Z  	B  ,       ,^   /   2"  7   Z   ,~   Z   ,~      	R      (VARIABLE-VALUE-CELL FNAME . 17)
(VARIABLE-VALUE-CELL CDEF . 25)
(VARIABLE-VALUE-CELL NOSWAPFNS . 7)
(VARIABLE-VALUE-CELL NOSWAPFLG . 11)
(VARIABLE-VALUE-CELL MKSWAPSIZE . 22)
GETD
ARRAYSIZE
(KT BHC IUNBOX SKAR KNIL FMEMB SKLA ENTERF)                       p                
(PRETTYCOMPRINT SWAPCOMS)
(RPAQQ SWAPCOMS ((FNS * SWAPFNS) (BLOCKS * SWAPBLOCKS) (VARS (NOSWAPFNS (QUOTE (LAPRD BINRD FNTYP 
NOLINKDEF LISPXPRINT LISPXPRIN1 LISPXPRIN2 LISPXSPACES LISPXTERPRI ADDSPELLBLOCK SAVESET /PUT 
DCHCONBLOCK MKSWAP2BLOCK KFORK RFSTS USERNUMBER)))) (DECLARE: DONTCOPY DOEVAL@COMPILE (PROP MACRO 
ASSEM)) (GLOBALVARS NOSWAPFNS MKSWAPSIZE NOSWAPFLG)))
(RPAQQ SWAPFNS (MKSWAP MKUNSWAP MKSWAP1 MKUNSWAP1 MKSWAP2 MKUNSWAP2 BREGIFY DO.CODE.MODS BLT MKSWAPP))
(RPAQQ SWAPBLOCKS ((MKSWAPBLOCK MKSWAP MKUNSWAP MKSWAP1 MKUNSWAP1 (ENTRIES MKSWAP MKUNSWAP) (SPECVARS 
ARR SIZE)) (MKSWAP2BLOCK MKSWAP2 MKUNSWAP2 BREGIFY DO.CODE.MODS BLT (ENTRIES MKSWAP2 MKUNSWAP2) (
SPECVARS ARR SIZE))))
(RPAQQ NOSWAPFNS (LAPRD BINRD FNTYP NOLINKDEF LISPXPRINT LISPXPRIN1 LISPXPRIN2 LISPXSPACES LISPXTERPRI
 ADDSPELLBLOCK SAVESET /PUT DCHCONBLOCK MKSWAP2BLOCK KFORK RFSTS USERNUMBER))
NIL
