@new1
*(setq *load-verbose* t)
*(load "lclc.clisp")
*(load "clc.clisp")
*(load "clc.lap")
*(in-package (quote lisp))
*(compile-file (quote error))
*(exit)
@submit clisp /time:10:00 /batch-log:supersede /output:nolog /unique:no /restart:yes
@logout
