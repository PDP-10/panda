(FILECREATED " 3-JAN-83 22:41:30" ("compiled on " <LISPUSERS>PQUOTE.;4) (2 . 2) recompiled exprs: 
nothing in WORK dated "30-DEC-82 00:01:56")
(FILECREATED " 3-JAN-83 22:41:24" <LISPUSERS>PQUOTE.;4 1706 changes to: (VARS PQUOTECOMS) (FNS 
PRINTQUOTE) previous date: "20-APR-82 17:42:48" <LISPUSERS>PQUOTE.;1)
PRINTQUOTE BINARY
       �         %-.           Z   3B   +   �Z   3B   +   �[   -,   +   �[  �[  2B   +   �[  Z  -,   +   [  Z  Z  3B  "+   �+   [  
Z  3B  �+   �[  Z  ,<  �,<   $  #,   ,>  �,>  �   �,   .Bx  ,^  �/  �."  ,>  �,>  �       �,^  �/  �2b  +   �,<  �"  $[  Z  2B   +   ,<   "  �,~   Z  ,~     �$"aP 8P      (VARIABLE-VALUE-CELL X . 61)
(VARIABLE-VALUE-CELL FORMFLG . 3)
(VARIABLE-VALUE-CELL FILEQUOTEFLG . 6)
(VARIABLE-VALUE-CELL LASTCOL . 46)
*
%'
NCHARS
POSITION
PRIN1
PRIN2
(BHC IUNBOX KT SKLST KNIL ENTERF)        � (             P   H        
(PRETTYCOMPRINT PQUOTECOMS)
(RPAQQ PQUOTECOMS ((E (RESETSAVE FILEQUOTEFLG) (* so this file doesn%'t have %' in it)) (FNS 
PRINTQUOTE) (ALISTS (PRETTYPRINTMACROS QUOTE)) (VARS (FILEQUOTEFLG T)) (GLOBALVARS FILEQUOTEFLG) (P (*
 Set up readmacros. note that naked %' prints with escape) (SETSYNTAX (QUOTE %') (QUOTE (MACRO FIRST 
READ%')) T) (SETSYNTAX (QUOTE %') (QUOTE (MACRO FIRST READ%')) FILERDTBL))))
(ADDTOVAR PRETTYPRINTMACROS (QUOTE . PRINTQUOTE))
(RPAQQ FILEQUOTEFLG T)
(SETSYNTAX (QUOTE %') (QUOTE (MACRO FIRST READ%')) T)
(SETSYNTAX (QUOTE %') (QUOTE (MACRO FIRST READ%')) FILERDTBL)
(PUTPROPS PQUOTE COPYRIGHT ("Xerox Corporation" 1982 1983))
NIL
  