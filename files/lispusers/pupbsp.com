(FILECREATED "16-DEC-81 00:33:20" ("compiled on " <LISPUSERS>PUPBSP.;2) (2 . 2) bcompl'd in WORK dated
 "10-DEC-81 01:25:37")
(FILECREATED "16-DEC-81 00:24:14" <LISPUSERS>PUPBSP.;2 6281 changes to: PUPBSPCOMS previous date: 
"16-DEC-81 00:22:54" <LISPUSERS>PUPBSP.;1)

CONN# BINARY
              -.           ^"  ,>  ,>  Z  Z 7@  7   Z  -,   +   ^"   +   ,   ."  ,   XB   ,   .Bx  ,^  /  ,   ,~     @  (VARIABLE-VALUE-CELL CONN# . 18)
CONN#
(BHC MKN IUNBOX SKNI KNOB ENTER0)  @   H          h    X      

MAKEJOB BINARY
    #        "-.           ` ,>  ,>  ,>  ,>  ,>  ,>  ,>  ,>  ,>  ,>  Z` 2B   3B   +    "  QBÿ,<` "   ,   XB` Z` 3B   +   ,   QB}Z   ,    "    1B  +   XF}Z` \"              +    !"bP+      !,<  ,<   ,<   &  ¡!"P $|   +   /  ,   ,~          "$@ _(B1  (FILE . 1)
(ENTRY . 1)
(TTY . 1)
(VARIABLE-VALUE-CELL MACSCRATCHSTRING . 29)
EXEC
SUBSYSJFN
ERSTR
ERROR
(MKN BHC KT UPATM IUNBOX GUNBOX KNIL ENTER3)                            X 	       

MAKESUBSYS BINARY
        !         -.           ,<   ,<` "  ,   ,>  ,>     XBp  ,      ,^  /  Q"     @Z` 3B   +    p  ,>  ,>   ` ,>  ,>   ` QBx  ,^  /  ,^  /     Ã p     6 p  ,>  ,>   p     Â   ,>  ,>  Z` 2B   +   ^"   +   ,   .Bx  ,^  /     ,^  /     ·Zp  +      PH B   (FILE . 1)
(ENTRY . 1)
(PRIMIO . 1)
SUBSYSJFN
CFORK
(URET1 BHC IUNBOX KNIL ENTER3)       (  x       h               

FTP BINARY
             -.     8      ,<` "  3B   +   ,<` ,<` ,<` ,<` ,<` ,<` ,<` .  ,~   ,<` ,<` ,<` ,<` ,<` ,<` ,<` .  ,~    @ (HOST . 1)
(FILE . 1)
(ACCESS . 1)
(USER . 1)
(PWD . 1)
(ACCT . 1)
(BYTESIZE . 1)
PUPHOSTP
PUPFTP
ARPAFTP
(KNIL ENTERF)   8      

PUPHOSTP BINARY
                -.           ,<  ,<` $  B  ,~       (X . 1)
"PUP:."
PACK*
INFILEP
(ENTER1)     

PUPOPENF BINARY
     4    '    ²-.     0      'Z` -,   +   B  *,<  ,<  ª$  ++   	2B   +   	   «B  *,<  ,<  ,$  +,<  ,<   ,<   ,<wZ` 3B   +   ,<  ,<  ¬Z` -,   +   B  *+   2B   +   Z  -,   +   Z   Z  ­,   ,   Z  .,   B  ®XBwÿB  /2B   +   Zp  +   ,<  ¯,<wþ$  +XBw+   /  ,<p  ,<` ,<   ,<  0Z` 3B   +   #Z` 3B   +   "Z  °+   &Z  1+   &Z` 3B   +   ¥Z  ±+   &Z   J  2+    ;X
;RUT>t    (LSKT . 1)
(HOST . 1)
(FSKT . 1)
(ACCESS . 1)
(LISTEN . 1)
(DONTWAIT . 1)
OCTAL
"!A"
CONCAT
CONN#
"!J"
"+"
TELNET
"."
"PUP:"
PACK
OPENP
"0"
8
(((MODE 3)) . 0)
(((MODE 2)) . 0)
(((MODE 1)) . 0)
OPENFILE
(URET2 BHC CONSS1 CONS21 ALIST3 KNIL SKI ENTER6)   §             H   (   h ¤   `  8  H  (       0      

PUPPAIR BINARY
            -.     (     ,<` ,<` ,<` ,<  ,<` ,<` ,  XB   Z  B  ,      Þ+       ,   ,<  ,<` ,<` ,<  ,<` ,<` ,  XB   ,~    H      (LSKT . 1)
(HOST . 1)
(SKT . 1)
(LISTEN . 1)
(DONTWAIT . 1)
(VARIABLE-VALUE-CELL INF . 11)
(VARIABLE-VALUE-CELL OUTF . 25)
INPUT
PUPOPENF
OPNJFN
OUTPUT
(MKN IUNBOX ENTER5)             

PUPSERVER BINARY
            -.           ,<   ,<     ,   (B  ,>  ,>  Z` 2B   +   ^"   +   ,   GBx  ,^  /  ,   ,<  ,<   Z` 2B   +   7   Z   J  ,~     "@	 (PUP# . 1)
(WAITFLG . 1)
PUPSERVER
USERNUMBER
MAKENEWCONNECTION
(KT MKN BHC IUNBOX KNIL ENTER2) X   (             H   h        

PUPUSER BINARY
              -.            Z` 2B   +      ,<  ,<  Z` -,   +   B  ,   +   ,   (B  ,>  ,>  Z` 2B   +   ^"   +   ,   GBx  ,^  /  ,   ,<  ,<   Z` 2B   +   7   Z   J  ,~     &HP@    (HOST . 1)
(USER . 1)
(PUP# . 1)
(WAITFLG . 1)
HOSTNAME
PUP
USERNUMBER
MAKENEWCONNECTION
(KT MKN BHC IUNBOX SKNNM KNIL ENTER4)      p   h   P   x    `   (      0      

SENDPUPPARAMETER BINARY
             -.            ` ,>  ,>   `    ,^  /         ` ,>  ,>   `    ,^  /      `       ,~             	 @ (J . 1)
(MARK . 1)
(VAL . 1)
(BHC ENTER3)           

SUBSYSJFN BINARY
            -.           Z` 3B   +   2B  +   ,<  ,<   ,<   ,<  (  2B   +   +   ,<  ,<  ,<  &  ,<  ,<   ,<   ,<  (  2B   +   ,<` ,<  ,<   ,<  (  2B   +   ,<` ,<  $  ,~   fvÚ@    (FILE . 1)
EXEC
<SYSTEM>EXEC.SAV
32768
GTJFN
<SUBSYS>
.SAV
PACK*
32768
32768
"not found"
ERROR
(KNIL ENTER1)   X  8   `   0      
(PRETTYCOMPRINT PUPBSPCOMS)
(RPAQQ PUPBSPCOMS ((FNS CONN# MAKEJOB MAKESUBSYS FTP PUPHOSTP PUPOPENF PUPPAIR PUPSERVER PUPUSER 
SENDPUPPARAMETER SUBSYSJFN) (LOCALVARS . T) (FILES (FROM VALUEOF LISPUSERSDIRECTORIES) NET) (DECLARE: 
EVAL@COMPILE DONTCOPY (FILES (LOADCOMP) NET))))
(FILESLOAD (FROM VALUEOF LISPUSERSDIRECTORIES) NET)
NIL
    