(FILECREATED "18-NOV-81 22:36:43" ("compiled on " <LISPUSERS>MAIL.;21) (2 . 2) brecompiled explicitly:
 MSGSTUB in "INTERLISP-MAXC " dated "18-NOV-81 22:01:03")
(FILECREATED "15-MAY-79 16:57:59" <LISPUSERS>MAIL.;21 6057 changes to: SETMAILFILE1 previous date: 
"12-JUL-78 18:16:23" <LISPUSERS>MAIL.;18)
(ADDTOVAR NOSWAPFNS MAILWATCHER)
MAILWATCHER BINARY
                -.            Z   3B   +   :    "  1"   +    "{XB     K,>  ,>       2bx  +       .x  ,   XB  ,<   ,<   $  /  Z   ,~       (VARIABLE-VALUE-CELL MAILFILESTR . 3)
(VARIABLE-VALUE-CELL MAILEVENTCOUNT . 11)
(VARIABLE-VALUE-CELL MAILTIME . 21)
(VARIABLE-VALUE-CELL MAILINTERVAL . 18)
MAILCHECK
(BHC KT MKN ASZ KNIL ENTER0)  X   H   0    `      @        
MAILCHECK BINARY
      =    3    ;-.          3,<   ,<   ,<   Z`  3B   +   ,<  5,<   ,<  5&  6+   Z   ,      S"     +   -XBw   1 &     3d  +   -   ,   XBw,   ,>  1,>           ,^   /   2b  7   7   +   Z` 2B   +   Z   +   Z`  3B   +   +,<  6,<   $  7,<w,<  7Z  8F  8,<   ,<   $  7Zw,   +   ^"   +    ,      2   2   +    +    +       (Bw,   XBp  1B   +   )1B   +   ),<  9,<   $  7,<p  "  9,<  :,<   $  7Z`  2B   +   -ZwXB  Zw3B   +   0,   B  :Zp  +                 7D	&\J`-P      (USER . 1)
(FLG . 1)
(VARIABLE-VALUE-CELL MAILFILESTR . 14)
(VARIABLE-VALUE-CELL LASTKNOWNMAIL . 90)
"<"
">MESSAGE.TXT;1 "
CONCAT
"[Mail waiting - "
PRIN1
-34309144576
""
GDATE
" from "
PRINTUSERNAME
"]
"
RLJFN
(URET3 ASZ KT BHC IUNBOX MKN UPATM KNIL ENTER2)    p &    +     8   (        0 P  h      p ,    @   8   (      
PRINTUSERNAME BINARY
             -.          Z   ,      Z`  /$      5    (    0     4B  1H   9  
1b  -1"   g  ."  ,   5   ,<  ,<   $  ,~    h (N . 1)
(VARIABLE-VALUE-CELL MACSCRATCHSTRING . 3)
"unknown"
PRIN1
(KT FOUT ASZ UPATM ENTER1)                     

MSGSTUB BINARY
      8    *    6-.           *Z   3B   +   ,<  +,<   ,<   @  , ` +   	Z   Z  -XB Z  B  .Z   ,~   3B   +   Z  ,~   ,<   "  .,<  /"  /Z   B  /,<  0"  /,<   "  0,<   @  1  +   ),<  0Z   ,<   ,   ,   Z   ,   XB  XB` ,<  3,<  3,<   @  , ` +    Z   Z  -XB ,<   "  4,<  4"  .XB  
Zw~XB8 Z   ,~   2B   +   "Z  5XB   [` XB  ,<  0Z` Z  [  D  5Z  !3B   +   (   6,~   Z` ,~   Z  ,~   u`)`1         (VARIABLE-VALUE-CELL MSGFORK . 82)
(VARIABLE-VALUE-CELL MAILFILE . 27)
(VARIABLE-VALUE-CELL RESETVARSLST . 69)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
SUBSYS
CLEARBUF
" "
BKSYSBUF
"

"
CONTROL
(VARIABLE-VALUE-CELL OLDVALUE . 38)
NIL
NIL
(NIL VARIABLE-VALUE-CELL RESETSTATE . 75)
((DUMMY) . 0)
INTERNAL
READC
<SUBSYS>MSG.SAV
ERROR
APPLY
ERROR!
(CONS CONSNL LIST2 KT CF KNIL ENTER0)  h   X   P           0     '   (   H        
SETMAILFILE1 BINARY
                -.          Z   ,<   Z  6@   Z  2B  +   	,<  ,<   ,<   $  ,<   ,<  &  +   2B  +   ,<  ,<   ,<   $  ,<   ,<  &  +      XB  ,\  3B  +   Z   +   Z`  3B   +   Z  ,<   ,<  $  XB   Z"XB   ,~   y?E&    (FLG . 1)
(VARIABLE-VALUE-CELL MAILFILE . 38)
(VARIABLE-VALUE-CELL MAILFILESTR . 42)
(VARIABLE-VALUE-CELL LASTKNOWNMAIL . 44)
TENEX
TOPS20
"<"
DIRECTORYNAME
">MESSAGE.TXT;1"
PACK*
"<"
">MAIL.TXT.1"
SHOULDNT
" "
CONCAT
(ASZ KT KNIL KL20FLG ENTER1)        @      8            
(PRETTYCOMPRINT MAILCOMS)
(RPAQQ MAILCOMS ((* check periodically if you have new mail) (DECLARE: FIRST (ADDVARS (NOSWAPFNS 
MAILWATCHER))) (FNS MAILWATCHER MAILCHECK PRINTUSERNAME MSGSTUB) (FNS SETMAILFILE1) (VARS MAILINTERVAL
 (MAILTIME -1) (LASTKNOWNMAIL -1) (MAILEVENTCOUNT -20) (MAILFILE) (MAILFILESTR) (MSGFORK)) (P (MOVD? (
QUOTE SETMAILFILE1) (QUOTE SETMAILFILE)) (SETMAILFILE T) (MOVD? (QUOTE MSGSTUB) (QUOTE MSG))) (ADDVARS
 (AFTERSYSOUTFORMS (SETMAILFILE))) (DECLARE: EVAL@LOADWHEN (CCODEP (QUOTE MAILWATCHER)) (ADDVARS (
PROMPTCHARFORMS (MAILWATCHER)))) (LOCALVARS . T) (GLOBALVARS MAILTIME MAILINTERVAL MAILFILESTR 
LASTKNOWNMAIL MAILEVENTCOUNT) (DECLARE: EVAL@COMPILE DONTCOPY (P (OR (GETD (QUOTE CJSYS)) (LOAD (QUOTE
 <LISPUSERS>CJSYS.COM)))))))
(RPAQQ MAILINTERVAL 300)
(RPAQ MAILTIME -1)
(RPAQ LASTKNOWNMAIL -1)
(RPAQ MAILEVENTCOUNT -20)
(RPAQ MAILFILE NIL)
(RPAQ MAILFILESTR NIL)
(RPAQ MSGFORK NIL)
(MOVD? (QUOTE SETMAILFILE1) (QUOTE SETMAILFILE))
(SETMAILFILE T)
(MOVD? (QUOTE MSGSTUB) (QUOTE MSG))
(ADDTOVAR AFTERSYSOUTFORMS (SETMAILFILE))
(ADDTOVAR PROMPTCHARFORMS (MAILWATCHER))
NIL
