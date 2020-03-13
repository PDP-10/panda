!* -*- TECO -*-			Library created by KMP@MC	!

!~Filename~:! !Macros for editting IBM/370 assembler!
IBM370

!IBM370 Mode:! !S Mode for making IBM/370 tolerable
Makes space tab to tab stop, stopping at columns 10, 16, 35, and then spacing.
Space is put on tab in case it is needed. * reads a comment in echo area and
then inserts it (hence, *'d lines can contain spaces without space macro
running). The comment is inserted before the current line and leaves cursor
before the next line.!

M(M.M &_Init_Buffer_Locals)	    !* Init local stuff			!
200.+@fs^RInitm.q	    !* Rubout hacks tabs		!
     @fs^RInitm.q.	    !* C-Rubout doesn't hack tabs	!
m.m^R_IBM370_Commentm.q*	    !* * enters comment field		!
m.m^R_Tab_to_Tab_Stopm.q_	    !* Space tabs			!
m.m^R_IBM370_Spacem.q	   !* Tab spaces			!
1,2 m.lDisplay_Matching_Paren	    !* Make local paren matching happen !
1,0 m.lPermit_UnMatched_Paren	    !* Disallow unmatched parens	!
1,(:i*__________:_____:__________________:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::)m.lTab_Stop_Definitions
1M(M.M&_Set_Mode_Line)IBM/370   !* Set mode line			!


!^R IBM370 Space:! !^R Insert arg spaces!

.,(,_i.)			    !* Insert them and return		!


!^R IBM370 Comment:! !^R Insert a comment!

1,fComment:_[1		    !* Read comment in echo area	!
fq1"l0'			    !* Return if over-rubout		!
0l .,( i*_ g1 i
 .)				    !* Get comment into buffer		!

