;This is the command file for assembling the exec.  Assuming it's stored
;in MKEXEC.CMD, you can create a new EXEC.EXE by saying
;
;		@EXECUTE @MKEXEC
;
;You will then be asked a question about symbols.  Type "Y" and <cr>.
;
;Note:  In order to use this .CMD file, you must run exec version 4(546)
;or later, since earlier execs don't allow comments in .CMD files.  9/4/79

EXEC:EXECDE.MAC+EXEC:EXECGL.MAC EXECGL	;Universal symbols
EXEC:EXECPR.MAC EXECPR		;Global storage, *NOT* for individual local
				;  command storage; use TRVAR and STKVAR
EXEC:EDEXEC+EXEC:EXECVR.MAC EXECVR  ;Version information and auto-increment
EXEC:EXECF0.MAC+EXEC:EXECCA.MAC EXECC0 ;Configuration varients
EXEC:EXEC0.MAC EXEC0		;Top-level command input, SYSTAT
EXEC:EXEC1.MAC EXEC1		;Miscellaneous commands
EXEC:EXECSE.MAC EXECSE		;SET commands and ^ESET commands
EXEC:EXECMT.MAC EXECMT		;Tape and disk mounting
EXEC:EXECP.MAC EXECP		;Program commands (like RUN, DDT, CONTINUE)
EXEC:EXECIN.MAC EXECIN		;INFORMATION commands
EXEC:EXEC2.MAC EXEC2		;COPY, APPEND, TYPE
EXEC:EXEC3.MAC EXEC3		;DIRECTORY-class commands
EXEC:EXEC4.MAC EXEC4		;BUILD, ^ECREATE, INFO DIRECTORY
EXEC:EXECED.MAC EXECED		;EDIT, CREATE commands
EXEC:EXECCS.MAC EXECCS		;COMPIL-class commands
EXEC:EXECQU.MAC EXECQU		;QUEUE-class commands
EXEC:EXECSU.MAC EXECSU		;Subroutines
SYS:MACREL.REL

