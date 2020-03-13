!* -*-TECO-*- Library created and maintained by KMP@MIT-OZ	!

!~Filename~:! !Macro support for editing Twenex exec .CMD files !
CMD

!& CMD Mode:!!CMD Mode:!!CTL Mode:! !C Set up for editing Twenex exec .CMD files !

!* Note: We do not try to hack the matchfix type of comments because Emacs   !
!*       doesn't deal well enough with them to make it worthwhile	     !

m(m.m &_Init_Buffer_Locals)		 !* Standard Major Mode init routine !

1,0           m.l Space_Indent_Flag	 !* No continuation line auto indent !
1,(:i*)      m.l Paragraph_Delimiter	 !* No paragraph delimiter	     !
1,40	      m.l Comment_Column	 !* Comment column = 40		     !
1,(:i*!) m.l Comment_Start	 !* Exclam is comment start char     !
1,(:i*!_)m.l Comment_Begin	 !* Exclam space starts comment	     !
1,(:i*!) m.l Comment_End		 !* Exclam is comment end char       !

1,q(1,q. m.qw )m.q .	 !* Exchange Rubout and c-Rubout     !

m.q ..D				 !* Get a local ..D (syntax table)   !
0fo..Q CMD_..D f"n u..D'		 !* Use our magic table if set up    !
"#w :g..D u..D				 !* Or make one if it doesnt exist   !
					 !* Set up Word and Sexp syntax	     !
  0m(m.m &_Alter_..D) @_ ._ ,_ <_ >_ (_ )_ !_ :_ ;_ 
  1m(m.m &_Alter_..D) !| |A / /_ <( >) [( ]) "| 'A {( }) ,_ @A .A :A ;A
  q..D m.v CMD_..D'			 !* Save the info that this is made  !
1m(m.m &_Set_Mode_Line) CMD  
