!Paginate:! !C Inserts a page mark after <arg> lines.
Default 25.  It also creates two blank lines before page mark for page number.
It will insert only blank lines (no ^L) if it runs into the end of the file.
With a negative arg, loops till eof using -<arg> lines.  With zero arg, loops
till eof using -<default>.!

 FF"E 25'"#'[1
 Q1"E -25U1'
 Q1"L -Q1U1 9999999 '"# 1' <
   Q1L  i 
 
  .-z"Ni'"# 0;'>
 

!Renumber Pages:! !C Renumbers pages of file.
It assumes it ownes the two lines previous to any ^L and the last two lines
in the file.!

 ff"EJ 0'"#-1'[1
 < @:fL
   0:L 
   0K I-_ %1\ i_-
   @M(M.M^R_Center_Line)
   2:L
   .-z; 
   > 

!Unpaginate:! !C Deletes page marks and their owned lines. !

J 
 < @:fL
   :CW -2K
   .-z;> 
