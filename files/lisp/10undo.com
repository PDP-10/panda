(FILECREATED "24-Aug-84 00:02:50" ("compiled on " <NEWLISP>10UNDO..1) (2 . 2) bcompl'd in "INTERLISP-10  18-Aug-84 ..." dated 
"18-Aug-84 15:06:21")
(FILECREATED "23-Aug-84 18:18:52" {ERIS}<LISPCORE>SOURCES>10UNDO.;2 1160 changes to: (VARS 10UNDOCOMS) (FNS /FNCLOSERA /FNCLOSERD 
/FNCLOSER /CLOSER) previous date: "23-Aug-84 18:13:53" {ERIS}<LISPCORE>LIBRARY>10UNDO.;1)

/CLOSER BINARY
               -.          Z   3B   +   ,<  Z   ,<        ,   ,   B     ,<   Z   ,   ,\   B  ,   ,~      (VARIABLE-VALUE-CELL ADR . 14)
(VARIABLE-VALUE-CELL VAL . 16)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
/CLOSER
UNDOSAVE
(GUNBOX ALIST3 MKN KNIL ENTERF)   	          h    0      

/FNCLOSER BINARY
               -.          Z   3B   +   	,<  Z   ,<  Z   ,<  Z  ,<      ,<   ,   ,   ,   B  Z  ,<      ,<       ,   ,   ,~      (VARIABLE-VALUE-CELL HANDLE . 19)
(VARIABLE-VALUE-CELL N . 21)
(VARIABLE-VALUE-CELL X . 23)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
/FNCLOSER
UNDOSAVE
(FFNCLR ALIST4 MKN FFNOPR KNIL ENTERF)       	            0      

/FNCLOSERA BINARY
              -.          Z   3B   +   	,<  Z   ,<  Z   ,<  Z  ,<      ,<   ,   ,   B  Z  ,<      ,<   Z   ,   ,~      (VARIABLE-VALUE-CELL HANDLE . 18)
(VARIABLE-VALUE-CELL N . 20)
(VARIABLE-VALUE-CELL X . 22)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
/FNCLOSERA
UNDOSAVE
(FFNCLA ALIST4 FFNOPA KNIL ENTERF)   H          0      

/FNCLOSERD BINARY
              -.          Z   3B   +   	,<  Z   ,<  Z   ,<  Z  ,<      ,<   ,   ,   B  Z  ,<      ,<   Z   ,   ,~      (VARIABLE-VALUE-CELL HANDLE . 18)
(VARIABLE-VALUE-CELL N . 20)
(VARIABLE-VALUE-CELL X . 22)
(VARIABLE-VALUE-CELL LISPXHIST . 3)
/FNCLOSERD
UNDOSAVE
(FFNCLD ALIST4 FFNOPD KNIL ENTERF)   H          0      
(PRETTYCOMPRINT 10UNDOCOMS)
(RPAQQ 10UNDOCOMS ((FNS /CLOSER /FNCLOSER /FNCLOSERA /FNCLOSERD) (ADDVARS (/FNS /CLOSER /FNCLOSER /FNCLOSERA /FNCLOSERD))))
(ADDTOVAR /FNS /CLOSER /FNCLOSER /FNCLOSERA /FNCLOSERD)
NIL
