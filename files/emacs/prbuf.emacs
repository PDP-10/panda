!* -*-TECO-*-!

!~Filename~:! !Print uncontrolified buffers!
PRBUF

!Print Buffer:! !C Uncontrolify buffer and send it to the lineprinter.
^Ls at the beginnings of lines are left alone.!

 g(q..o(f[BBind))		    !* get a scratch buffer!
 e\ fne^			    !* save old output file!
 f[DFile			    !* save default file specs!
 jm(m.m Uncontrolify) 	    !* uncontrolify, leave ^Ls alone!
 j<:s
; -di^L>		    !* uncontrolify middle-line ^Ls!
 qBuffer_Name[0		    !* get buffer name!
 et LPT:0.LPT		    !* include it in lpt file name!
 ei hp ef 			    !* print the file and return!

!Dover Buffer:! !C Like Print Buffer, but sends it to the Dover.!

 g(q..o(f[BBind))		    !* get a scratch buffer!
 e\ fne^			    !* save old output file!
 f[DFile			    !* save default file specs!
 jm(m.m Uncontrolify) 	    !* uncontrolify, leave ^Ls alone!
 j<:s
; -di^L>		    !* uncontrolify middle-line ^Ls!
 j<:s^%; >		    !* change caret to SAIL caret!
 j<:s_; >		    !* change underbar to SAIL underbar!

 qBuffer_Name[0		    !* get buffer name!
 fs MS Name[1			    !* and connected directory!
 et 10.DOV ei hp ef	    !* make a temporary file!

 fs DFileu0			    !* get default filenames!
 
 f[Window			    !* dont mung window!
 0f[Lines 0f[Top Line f+	    !* clear whole screen!
 -(fz SYS:DOVER.EXE_0
)fz	    !* run DOVER and kill the fork!
 1:<@ed>			    !* delete the output file and expunge it!
 
