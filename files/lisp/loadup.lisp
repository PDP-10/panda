((PRELOADUP (SETQQ COMPILE.EXT COM) (LOADUPROFILE (COND ((EQ (EVALV (
QUOTE BYTELISPFLG)) T) (QUOTE (BOOTSTRAP MAXCCODEFORMAT BASIC MISC 
MAXCSWAP ASSEMBLE LOADUP MACHINEDEPENDENT MACHINEINDEPENDENT DATATYPE)))
 (T (QUOTE (BOOTSTRAP CODEFORMAT BASIC MISC SWAP ASSEMBLE LOADUP 
MACHINEDEPENDENT MACHINEINDEPENDENT DATATYPE)))) T)) (COMP (LOADUPROFILE
 (QUOTE PRELOADUP) T) (LOADUPROFILE (QUOTE (COMPILE COMP LAP 10MACROS 
MACROS)) CONTINUEFLG)) (TINY (LOADUPROFILE (QUOTE PRELOADUP) T) (
LOADUPROFILE (QUOTE (HELPDL BREAK MAC LMMAC LOADFNS FFILEPOS ARITH)) 
CONTINUEFLG)) (SMALL (LOADUPROFILE (QUOTE PRELOADUP) T) (LOADUPROFILE (
QUOTE (EDIT WEDIT HELPDL PRETTY COMMENT BREAK ADVISE MAC LMMAC LOADFNS 
FFILEPOS ARITH FILEPKG)) CONTINUEFLG) (AND (NULL CONTINUEFLG) (SETQ 
UPDATEMAPFLG (SETQ BUILDMAPFLG (SETQ FILEPKGFLG T))))) (BIG (
LOADUPROFILE (QUOTE SMALL) T) (LOADUPROFILE (QUOTE (HIST 10UNDO UNDO SPELL DWIM
 WTFIX CLISP DWIMIFY CLISPIFY RECORD ASSIST)) CONTINUEFLG) (DWIM (QUOTE 
C)) (AND (NULL CONTINUEFLG) (ENDLOAD T))) (HUGE (PROG ((MKSWAPSIZE 30)) 
(MAPC (QUOTE (COMP SMALL BIG)) (FUNCTION (LAMBDA (X) (LOADUPROFILE X T))
)) (SETQ LOADUPROFILELST NIL) (LOADUPROFILE (QUOTE (MSANALYZE MSPARSE 
MASTERSCOPE UTILITY BRKDWN HPRINT))) (AND (NULL CONTINUEFLG) (ENDLOAD T)
))) (WOODS (PROG ((EXCEPTFILES (UNION EXCEPTFILES (QUOTE (CLISPIFY 
RECORD))))) (LOADUPROFILE (QUOTE BIG) CONTINUEFLG))) (KAY (PROG ((
MKSWAPSIZE 30)) (PROG ((EXCEPTFILES (APPEND EXCEPTFILES (QUOTE (EDIT 
WEDIT ADVISE FILEPKG))))) (LOADUPROFILE (QUOTE SMALL) T)) (LOADUPROFILE 
(QUOTE (ASSIST)) T) (COND ((NULL CONTINUEFLG) (ENDLOAD) (SETQ 
BUILDMAPFLG T) (SETQ FILEPKGFLG NIL))))))
