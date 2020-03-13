!* -*- Teco -*-				Library created by KMP@MIT-MC	!
!* This is a just-for-fun package to show people how Eliza-type programs!
!* might interface to Teco.						!

!~Filename~:! !Macros for playing doctor in Teco!
DOCTOR

!DOCTOR Mode:! !& Enter wierd mode !
M(M.M&_Init_Buffer_Locals)
5*.:f..D_A			    !* Make dot like whitespace !
1,(m.m ^R_Diagnose)m(m.mMake_Local_Q-Reg).
1,(m.m ^R_Diagnose)m(m.mMake_Local_Q-Reg)?
1,(m.m ^R_Diagnose)m(m.mMake_Local_Q-Reg)!
!<! zj i 
>_ -4  @v
1m(m.m &_Set_Mode_Line)Doctor


!^R Diagnose:! !^R Insert diagnosis...!

fm(qA)@v			    !* Insert period(s) and display	!
.-z"n 0 '			    !* Self-insert if not eof		!
[0 .:\u0 fn zj i 
>_ 0,.@v !* Jump to end of buffer when ready	!
!<! i 
 -2  @v		    !* Insert and display CRLF		!
-:s
>"ej'c			    !* Find head of sentence		!

  q..0-?"e 
    zj !""! i I'll_ask_the_questions,_if_you_don't_mind!
	   Now_then,_please_tell_me_more_about_your_developing_mental_illness.
        0'

  :s mother  father  brother  sister"l

  zj i Tell_me_more_about_your_family.  0'

  :s drug  grass  cocaine  dealer  junk "l

  zj i Are_you_heavily_into_drugs?  0'

  :s kill  death  rape  mame "l

  zj i These_are_not_wholesome_thoughts.  0'

  :s club  gun  knife "l

  zj !""! i I_don't_approve_of_weapons.__You're_sick.  0'

  :s sex  women  men "l

  zj i Tell_me_more_about_your_sex_life.  0'

  :s upset    angry   depressed  annoyed  excited     !* ...
!    worried  lonely  pissed     jealous "l

  [0 fk x0 zj i Are_you_0 -fq0 fc i _often?  ]0 0'

  :s headache  fever  sore  ache  hurt "l

     zj !"! i Maybe_you_should_see_a_doctor_of_medicine.__I'm_just
              a_psychiatrist.
     0'

  :s hi  hello "l

     zj !"! i Hi_there.__What's_the_trouble? 0'

  :s bye  quit  exit "l

     zj i See_you_later. m(m.m Text_Mode) w 0'

  :s yes  yeah  yup  yep  yeh "l

     zj i You_seem_quite_affirmative.  0'

  :s you "l 

     zj i We_were_discussing_you!__Now_please_tell_me_about  
        oRandom-Topics'

  :s no "l

    zj i Why_not?  0'

  3:<fwl>"n
    zj !"! i You're_being_quite_brief.__Please_elaborate.   0'

zj  &7[R

&7"e i Hmmm..._  '

qR"e i Tell_me_more.  0' qR-1uR
qR"e i Go_on.  0' qR-1uR
qR"e i Maybe_problems_as_a_child_have_something_to_do_with_this.  0' qR-1uR
qR"e i Tell_me_something_about_life_at_home.  0' qR-1uR
qR"e !"! i Tell_me_about_some_dream_you've_had_recently.  0' qR-1uR
qR"e i I_understand.  0' qR-1uR
qR"e i Please,_continue.  0' qR-1uR
qR"e i I_see.__Continue,_...  0' qR-1uR

!"! i I'm_a_bit_confused.__Please_report_this_conversation_to_my_shrink.
      Bye...  m(m.m Text_Mode)

0

!Random-Topics!

&3[R
qR"e i _your_sex_life.  0' qR-1uR
qR"e i _your_problems_at_home.  0' qR-1uR
qR"e i _your_childhood.  0' qR-1uR
qR"e i _your_relationships_with_others.  0' qR-1uR

0