(FILECREATED " 5-JAN-83 18:06:52" ("compiled on " <LISPUSERS>LABEL.;12) (2 . 2) tcompl'd in WORK dated
 "30-DEC-82 00:01:56")
(FILECREATED " 5-JAN-83 18:06:12" <LISPUSERS>LABEL.;12 991 changes to: (FNS DOLABEL) previous date: 
"15-FEB-82 08:29:06" <LISPUSERS>LABEL.;5)

DOLABEL BINARY
        �        �-.           [   Z  ,<  �[  �[  Z  ,<  �[  [  [  ,<  �@  � ` ,~   Z   ,<  �Z   Z   ,   ,<  �Z  �Z  �,   Z  ,   Z   ,   ,   Z  �,   ,<  �Z  Z   ,   Z  �,   Z   ,   Z  ,   Z   ,   ,   Z   ,   ,   Z  �,   ,~    @"   (VARIABLE-VALUE-CELL X . 10)
(VARIABLE-VALUE-CELL NAME . 23)
(VARIABLE-VALUE-CELL ARGS . 34)
(VARIABLE-VALUE-CELL FORMS . 35)
APPLY*
LAMBDA
FUNCTION
(CONSS1 CONS21 CONS KNIL ENTERF)    �        @  h     P  x � 8     � H  0      
(PRETTYCOMPRINT LABELCOMS)
(RPAQQ LABELCOMS ((FNS DOLABEL) (ALISTS (LAMBDATRANFNS LABEL)) (ADDVARS (LAMBDASPLST LABEL)) (FILES (
SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) LAMBDATRAN)))
(ADDTOVAR LAMBDATRANFNS (LABEL DOLABEL))
(ADDTOVAR LAMBDASPLST LABEL)
(FILESLOAD (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) LAMBDATRAN)
(PUTPROPS LABEL COPYRIGHT ("Xerox Corporation" 1983))
NIL
    