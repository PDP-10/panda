(FILECREATED "21-Dec-82 17:45:39" ("compiled on " <DONC>COMMENTS..5) (2 . 2) 
tcompl'd in MEVAL dated "18-Oct-82 12:28:53")
(FILECREATED "21-Dec-82 17:44:42" <DONC>COMMENTS..5 7377 changes to: (FNS 
PRINT-COMMENT SKIPCOMMENT) previous date: "21-Dec-82 17:36:16" <DONC>COMMENTS..4
)

COMPILE-COMMENT BINARY
      ¡         -.          Z   B  ,<  Z   ,<  @   @ ,~   ,<   [   [  2B   +   	Zp  +   Z  ,<  [  	XB  
,\  +   /  Z  Z  2B  +   Z  [  Z  ,<  Z  [  [  ,<  Z   D  D  Z  Z   QD  Z  Z  XD  +   ,<  "   Z   B  Z   ,~    (@.@  (VARIABLE-VALUE-CELL WHERE . 37)
(VARIABLE-VALUE-CELL LCFIL . 3)
(VARIABLE-VALUE-CELL OTHERS . 6)
OUTPUT
(VARIABLE-VALUE-CELL OUTFILE . 49)
(VARIABLE-VALUE-CELL OTHERSTail . 43)
DC
APPEND
PRINT-COMMENT
*
"The file you are compiling has confused the documentation package.
It expects all (un-character-quoted) occurrences of <ESC> to be in comments."
HELP
(BHC KNIL ENTERF) P   (           

DC BINARY
         i    -.         iZ   ,<  ,<  ë$  l,<  @  ì   
,~   Z   ,<  @  o  +   Z` -,   +   
+   Z  XB   Z   Z  2B  +   Z  2B   +   Z   XB` +   [` XB` +   Z` ,~   XB   3B   +   $,<  ð,<  qZ  ,<  ,<  ñZ  ,<  ^"  ,   ,<  ,<   $  rZ   [  Z  ,   2B   +   $   ò2B   +   ",<  s,<  ó,<  t,<  ô(  u2B  õ+   $[  ,<  Z  D  v   ò2B   +   (,<  ö,<   $  w,<   "  ÷   ò3B   +   3,<  x,<   ,<   @  ø ` +   3Z   Z  zXB ,<      ú2B  {+   1Zp  +   ±+   ®/  Z   ,~      ò3B   +   JZ   2B   +   J,<  û,<   ,<   @  ø ` +   DZ   Z  zXB    ò,   ,   XB   ,<      ú2B  |+   ¿Zp  +   @+   =/  Z   ,   ,   XB   Z   Z   ,~   3B   +   J   ò,<  Z  <,<     B/"  ,   ,   XB   +   Ì,<   Z   D  üXB  I   ú   ò3B   +   ×,<  },<   ,<   @  ø ` +   ×Z   Z  zXB ,<      ú2B  {+   ÕZp  +   V+   S/  Z   ,~   Z  "3B   +   Û[  ×,<  Z  ËD  ý+   ãZ  ,<  ,<  ë,<  ,<  ë$  l,<  Z  ,<  Z  #Z  Z,   ,   ,   D  ~F  þZ  Û,<  ,<  Z  Y2B   +   g7   Z   F  ÿZ  ã,~   !&I  oøZlTvJPv 0	6*;2`I           (VARIABLE-VALUE-CELL WORD . 208)
(VARIABLE-VALUE-CELL ID . 190)
(VARIABLE-VALUE-CELL DESCR . 192)
(VARIABLE-VALUE-CELL DC-DEFINE . 105)
(VARIABLE-VALUE-CELL COMMENTRDTBL . 149)
COMMENT
GETPROP
(VARIABLE-VALUE-CELL COMMENTS . 11)
(NIL VARIABLE-VALUE-CELL OLDCMT . 202)
(NIL VARIABLE-VALUE-CELL STR . 193)
(NIL VARIABLE-VALUE-CELL STARTBYTE . 140)
(NIL VARIABLE-VALUE-CELL ENDBYTE . 142)
(0 . 1)
NIL
(NIL VARIABLE-VALUE-CELL C . 26)
redefining
comment
of
PRINT
INPUT
5
N
"Change the description? "
(((Y . "es") (N . "o")) . 0)
ASKUSER
Y
RPLACA
"Enter comment ending with <esc><return>"
PRIN1
TERPRI
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
READC
%

((DUMMY) . 0)
%
RSTRING
((DUMMY) . 0)
RPLACD
NCONC
PUTPROP
COMMENTS
MARKASCHANGED
(CONSNL CONSS1 CONS ALIST3 MKN FGFPTR BHC CF EQUAL LIST KT KNIL SKNLST ENTERF)   c    â    b    É    I ( ¼    B @   
p A (   
  : X   H      x × 	` D H 3  ( p ¥ h  x     æ  Ó 
  Ï 	0 E 8 Á X 8 x 6 p « 0  @            

DOC BINARY
     D    9    B-.          9Z   -,   3B   7    ,   XB  ,<  Zp  -,   +   Z   +    Zp  ,<  @  ¹   +   ·Z   ,<  ,<  :$  º,<  Zp  -,   +   +    Zp  ,<  @  ;   +   6Z  
,<  Z   ,<  [  Z  F  »3B   +   µ[  [  -,   +   [  [  B  <+   5[  [  Z  ,<  ,<  ¼$  =2B   +   -,<  ½,<   ,<   @  > ` +   &Z   Z  ¿XB [  [  Z  ,<  ,<  ¼$  @Z   ,~   2B   +   -,<   "  À,<  A,<   $  <[  "[  Z  ,<  ,<   $  <+   5[  ©[  Z  ,<  ,<   [  -[  [  Z  ,<  [  ¯[  [  [  Z  H  Á   À,~   [p  XBp  +   [p  XBp  +   
1
	C2Pbh     (VARIABLE-VALUE-CELL WORDS . 8)
(VARIABLE-VALUE-CELL W . 34)
COMMENT
GETPROP
(VARIABLE-VALUE-CELL C . 100)
DOCFILTER
PRIN1
INPUT
OPENP
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
OPENFILE
TERPRI
"Unable to read file "
COPYBYTES
(KT CF SKSTP URET1 SKNLST CONSNL KNIL SKLST ENTERF) H ©   &    ¡             `         0 p  p  X   8    0      

DOCFILTER BINARY
               -.           Z   ,<  Z   ,<  Z   ,<  ,   B  Z  2B   +   Z   ,~   ,<   ,<   ,<  ,<  (  2B  7   Z   ,~   	@ (VARIABLE-VALUE-CELL WORD . 3)
(VARIABLE-VALUE-CELL ID . 11)
(VARIABLE-VALUE-CELL DESCR . 7)
PRINT
" Print it? (y/n) "
(((Y "es
") (N "o
")) . 0)
ASKUSER
Y
(KT KNIL LIST3 ENTERF)   H       	  p    X      

INCOMMENTS BINARY
      $        #-.           Z   2B  !+   [   Z  2B  ¡+   [  [  2B   +   Z  Z  2B  +   [  Z  2B  ¡+   [  	[  Z  Z 7@  7   Z  +   [  +   Z   ,<  @  "   ,~   Z   2B   +   Z   3B   +   7   Z   ,~   -,   +   ,<  Z  D  ¢,~   2B   +   Z  ,~   Z  Z  ,   3B   +   Z   ,~   1	@)	H (VARIABLE-VALUE-CELL COM . 30)
(VARIABLE-VALUE-CELL NAME . 56)
(VARIABLE-VALUE-CELL TYPE . 14)
VARS
*
(VARIABLE-VALUE-CELL CONTENTS . 57)
INTERSECTION
(FMEMB SKLST KT KNOB KNIL ENTERF)            h          0  X   p      

PP-COMMENTS BINARY
             -.          Z   ,<  Zp  -,   +   +   Zp  ,<  @     +   Z   ,<  ,<  $  ,<  Zp  -,   +   +    Zp  ,<  @     +   Z  ,<  Z   D  ,~   [p  XBp  +   [p  XBp  +   /  Z   ,~   eE    (VARIABLE-VALUE-CELL L . 3)
(VARIABLE-VALUE-CELL WORD . 28)
COMMENT
GETPROP
(VARIABLE-VALUE-CELL C . 30)
PRINT-COMMENT
(KNIL BHC URET1 SKNLST ENTERF) P   H   @   0        

PRINT-COMMENT BINARY
     X    È    Õ-.          È   J,<  ÊZ   ,<  Z   ,<  [  Z  ,   B  K,<  Ë"  L   J@  Ì  +   Ç,<  Í,<   ,<   @  N ` +   Z   Z  ÏXB    P,   ,   XB   Z   ,~   [  [  -,   +   [  [  B  L+   ´[  [  Z  ,<  ,<  Ð$  Q2B   +   ¢,<  Ñ,<   ,<   @  N ` +   ¡Z   Z  ÏXB [  [  Z  ,<  ,<  Ð$  RZ   ,~   3B   +   /[  [  Z  ,<  ,<   [  ¢[  [  Z  ,<  [  %[  [  [  Z  H  Ò[  §[  Z  B  S[  ª[  Z  B  S+   ´,<   "  J,<  Ó,<   $  L[  ¬[  Z  ,<  ,<   $  L,<  T"  L,<  Ô,<   ,<   @  N ` +   =Z   Z  ÏXB    P,   ,   XB   Z   ,~   Z  3B   +   GZ  »3B   +   GZ   2B   +   G[  ±@  P,<  Z  =,<     ¾/"  /"  ,   ,   D  U,~      J,~   v*@&JAD Z (     (VARIABLE-VALUE-CELL WORD . 5)
(VARIABLE-VALUE-CELL COMMENT . 131)
(VARIABLE-VALUE-CELL DC-RETAIN . 128)
TERPRI
DC
PRIN2
%(%% 
PRIN1
(NIL VARIABLE-VALUE-CELL STARTBYTE . 134)
(NIL VARIABLE-VALUE-CELL ENDBYTE . 136)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
OUTPUT
INPUT
OPENP
((DUMMY) . 0)
OPENFILE
COPYBYTES
READC
"Unable to read file "
%%)
((DUMMY) . 0)
RPLACD
(ALIST3 SKSTP KT MKN FGFPTR CF KNIL ALIST4 ENTERF)   G        = H ±   ¡    h <     8     ¹ P     Á   ¾ x 7 X ¢ 0    0    h      

SKIPCOMMENT BINARY
     *         ¨-.            Z   B  !2B  ¡+   Z  B  "3B   +   Z  B  !2B  ¢+   @  #  +   Z  B  "Z  	,   ,   XB   ,<  £,<   ,<   @  $ ` +   Z   Z  ¥XB ,<   Z  
B  "2B  &+   Zp  +   +   /  Z   ,~   ,<  ¦,<  ',<  §,<  (Z  ,<  Z  ,<  Z  ,   /"  ,   ,   ,   ,   ,   ,~   ,~   Z  &,~   +j	¨l<       (VARIABLE-VALUE-CELL FILE . 52)
(VARIABLE-VALUE-CELL RDTBL . 0)
PEEKC
% 
READC
%

(NIL VARIABLE-VALUE-CELL STARTBYTE . 50)
((DUMMY) . 0)
(0 . 1)
(0 . 1)
(0 . 1)
ERRORSET
%
DECLARE:
EVAL@COMPILE
COMPILE-COMMENT
QUOTE
(ALIST2 ALIST3 KT BHC CF MKN FGFPTR KNIL ENTERF)   `      P   `   X       H      8     X        
(PRETTYCOMPRINT COMMENTSCOMS)
(RPAQQ COMMENTSCOMS ((P (OR (BOUNDP (QUOTE OriginalFILERDTBL)) (SETQ 
OriginalFILERDTBL (COPYREADTABLE FILERDTBL))) (SETQ COMMENTRDTBL (COPYREADTABLE 
T)) (SETSEPR NIL NIL COMMENTRDTBL) (SETBRK (QUOTE (27)) NIL COMMENTRDTBL) (
SETSYNTAX 27 (QUOTE (SPLICE ALONE SKIPCOMMENT)) FILERDTBL)) (FNS * COMMENTSFNS) 
(FILEPKGCOMS * COMMENTSFILEPKGCOMS) (VARS * COMMENTSVARS) (DECLARE: 
DONTEVAL@LOAD DOEVAL@COMPILE DONTCOPY COMPILERVARS (ADDVARS (NLAMA DOC) (NLAML 
PP-COMMENTS DC) (LAMA)))))
(OR (BOUNDP (QUOTE OriginalFILERDTBL)) (SETQ OriginalFILERDTBL (COPYREADTABLE 
FILERDTBL)))
(SETQ COMMENTRDTBL (COPYREADTABLE T))
(SETSEPR NIL NIL COMMENTRDTBL)
(SETBRK (QUOTE (27)) NIL COMMENTRDTBL)
(SETSYNTAX 27 (QUOTE (SPLICE ALONE SKIPCOMMENT)) FILERDTBL)
(RPAQQ COMMENTSFNS (COMPILE-COMMENT DC DOC DOCFILTER INCOMMENTS PP-COMMENTS 
PRINT-COMMENT SKIPCOMMENT))
(RPAQQ COMMENTSFILEPKGCOMS (COMMENTS))
(PUTDEF (QUOTE COMMENTS) (QUOTE FILEPKGCOMS) (QUOTE ((COM MACRO (X (E (
PP-COMMENTS X))) CONTENTS INCOMMENTS) (TYPE DESCRIPTION "documentation" GETDEF (
LAMBDA (NAME TYPE OPTIONS) (GETPROP NAME (QUOTE COMMENT))) PUTDEF (LAMBDA (NAME 
TYPE DEFN) (PUTPROP NAME (QUOTE COMMENT) DEFN)) DELDEF (LAMBDA (NAME TYPE) (
REMPROP NAME (QUOTE COMMENT)))))))
(RPAQQ COMMENTSVARS (DC-DEFINE DC-RETAIN))
(RPAQQ DC-DEFINE NIL)
(RPAQQ DC-RETAIN NIL)
NIL
    