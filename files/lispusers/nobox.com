(FILECREATED "17-FEB-83 17:47:14" ("compiled on " <LISPUSERS>NOBOX.;7) (2 . 2) bcompl'd in WORK dated 
"10-FEB-83 22:45:37")
(FILECREATED "13-FEB-83 19:09:17" {PHYLUM}<LISPUSERS>NOBOX.;6 5644 changes to: (MACROS FBOX IBOX) 
previous date: " 9-FEB-83 21:41:43" {PHYLUM}<LISPUSERS>NOBOX.;5)

IBOX BINARY
      �    �    -.           �,<      ,   XBp  ,<  �Zw�,<  �Z   2B   +   �^"P+   ,      �,\  � D  ,\  �/  �,~     B @  (VARIABLE-VALUE-CELL IVAL . 10)
(BHC IUNBOX MKN KNIL ENTERF)       �    �    �  (      

FBOX BINARY
       �    �    -.           �,<      ,   XBp  ,<  �Zw�,<  �Z   2B   +   �   +   ,      �,\  � D  ,\  �/  �,~        @  (VARIABLE-VALUE-CELL FVAL . 10)
(BHC FUNBOX MKFN KNIL ENTERF)      �    �    �  (      

NBOX BINARY
           �    -.           �Z      +   �,<      �,   XBp  ,<  �Zw�,<  �Z  �,      �,\  � D  ,\  �/  �,~   ,<      ,   XBp  ,<  �Zw�,<  �   �   �,\  � D  ,\  �/  �,~          B @        (VARIABLE-VALUE-CELL NVAL . 28)
(MKN BHC FUNBOX MKFN KNIL FLOATT ENTERF)   H    �            �  @    0      
(PRETTYCOMPRINT NOBOXCOMS)
(RPAQQ NOBOXCOMS ((* use of this package is not recommended for interlisp-d. it is supplied for 
compatibility with old code) (FNS IBOX FBOX NBOX) (P (MOVD? (QUOTE LIST) (QUOTE LBOX)) (MOVD? (QUOTE 
CONS) (QUOTE CBOX))) (DECLARE: EVAL@COMPILE (RECORDS FBOX IBOX) (MACROS NOBOX.MAKEFLOAT 
NOBOX.MAKELARGE) (MACROS IBOX FBOX NBOX) (MACROS CBOX LBOX) (I.S.OPRS scratchcollect) (ADDVARS (
SYSLOCALVARS $$SCCONS $$SCPTR) (INVISIBLEVARS $$SCCONS $$SCPTR)))))
(MOVD? (QUOTE LIST) (QUOTE LBOX))
(MOVD? (QUOTE CONS) (QUOTE CBOX))
(DECLARE: EVAL@COMPILE (BLOCKRECORD FBOX ((F FLOATING)) (CREATE (NOBOX.MAKEFLOAT))) (BLOCKRECORD IBOX 
((I INTEGER)) (CREATE (NOBOX.MAKELARGE))))
(DECLARE: EVAL@COMPILE (PUTPROPS NOBOX.MAKEFLOAT 10MACRO (NIL (FPLUS 0.0))) (PUTPROPS NOBOX.MAKEFLOAT 
DMACRO (NIL (CREATECELL (CONSTANT \FLOATP)))) (PUTPROPS NOBOX.MAKELARGE 10MACRO (NIL (IPLUS 1000000)))
 (PUTPROPS NOBOX.MAKELARGE DMACRO (NIL (CREATECELL (CONSTANT \FIXP)))))
(DECLARE: EVAL@COMPILE (PUTPROPS IBOX 10MACRO (ARGS (COND ((CAR ARGS) (LIST (QUOTE ASSEMBLE) NIL (LIST
 (QUOTE CQ) (LIST (QUOTE VAG) (LIST (QUOTE FIX) (CAR ARGS)))) (QUOTE (MOVE 2 , 1)) (LIST (QUOTE CQ) (
create IBOX)) (QUOTE (MOVEM 2 , 0 (1))))) (T (QUOTE (create IBOX)))))) (PUTPROPS IBOX DMACRO (ARGS (
COND (ARGS (APPEND (QUOTE (create IBOX smashing (CONSTANT (create IBOX)) I _)) ARGS)) (T (QUOTE (
create IBOX)))))) (PUTPROPS FBOX 10MACRO (ARGS (COND ((CAR ARGS) (LIST (QUOTE ASSEMBLE) NIL (LIST (
QUOTE CQ) (LIST (QUOTE VAG) (LIST (QUOTE FLOAT) (CAR ARGS)))) (QUOTE (MOVE 2 , 1)) (LIST (QUOTE CQ) (
create FBOX)) (QUOTE (MOVEM 2 , 0 (1))))) (T (QUOTE (create FBOX)))))) (PUTPROPS FBOX DMACRO (ARGS (
COND (ARGS (APPEND (QUOTE (create FBOX smashing (CONSTANT (create FBOX)) F _)) ARGS)) (T (QUOTE (
create FBOX)))))) (PUTPROPS NBOX 10MACRO (ARGS (SUBPAIR (QUOTE (NVAL FBOX)) (LIST (CAR ARGS) (create 
FBOX)) (QUOTE (ASSEMBLE NIL (CQ NVAL) (CQ (COND ((FLOATP (AC)) (ASSEMBLE NIL (MOVE 2 , 0 (1)) (CQ FBOX
) (MOVEM 2 , 0 (1)))) (T (IBOX (AC)))))))))) (PUTPROPS NBOX DMACRO (OPENLAMBDA (NVAL) (COND ((FLOATP 
NVAL) (FBOX NVAL)) (T (IBOX NVAL))))))
(DECLARE: EVAL@COMPILE (PUTPROPS CBOX MACRO ((X Y) (FRPLNODE (CONSTANT (CONS)) X Y))) (PUTPROPS CBOX 
DMACRO (= . CONS)) (PUTPROPS LBOX MACRO (ARGLIST (PROG (NILIST (FORM (QUOTE $X$))) (MAP ARGLIST (
FUNCTION (LAMBDA (ARG) (SETQ NILIST (CONS NIL NILIST)) (SETQ FORM (LIST (QUOTE FRPLACA) FORM (CAR ARG)
)) (AND (CDR ARG) (SETQ FORM (LIST (QUOTE CDR) FORM)))))) (RETURN (LIST (LIST (QUOTE LAMBDA) (QUOTE (
$X$)) (QUOTE (DECLARE (LOCALVARS $X$))) FORM (QUOTE $X$)) (KWOTE NILIST)))))) (PUTPROPS LBOX DMACRO (=
 . LIST)))
(DECLARE: EVAL@COMPILE (I.S.OPR (QUOTE scratchcollect) (QUOTE (SETQ $$SCPTR (FRPLACA (OR (CDR $$SCPTR)
 (CDR (FRPLACD $$SCPTR (CAR (FRPLACA $$SCCONS (CONS)))))) BODY))) (QUOTE (BIND $$SCPTR $$SCCONS _ (
CONSTANT (CONS)) FIRST (SETQ $$SCPTR $$SCCONS) FINALLY (SETQ $$VAL (AND (NEQ $$SCPTR $$SCCONS) (PROG1 
(CDR $$SCCONS) (COND ((CDR $$SCPTR) (FRPLACD $$SCCONS (PROG1 (CDR $$SCPTR) (FRPLACD $$SCPTR NIL) (
FRPLACD (PROG1 (CAR $$SCCONS) (FRPLACA $$SCCONS $$SCPTR)) (CDR $$SCCONS)))))))))))))
(ADDTOVAR SYSLOCALVARS $$SCCONS $$SCPTR)
(ADDTOVAR INVISIBLEVARS $$SCCONS $$SCPTR)
(PUTPROPS NOBOX COPYRIGHT ("Xerox Corporation" 1983))
NIL
