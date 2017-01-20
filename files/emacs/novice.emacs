!*-*-TECO-*-!
!* To use this feature, give the user a profile file (uname EPRFIL or
EMACS.PROFILE) containing 640 characters, one for each standard command
character and and then one for each C-X subcommand character, each being
either E to enable the command character or D to disable it.  The command M-X
Turn Off Everything was designed to aid in producing new profile files.  A
standard beginners profile resides in emacs:minimal.profile.  The profile file
is automatically updated if the user turns any commands on or off.  !

!~Filename~:! !Supervises incremental learning, starting with subset of EMACS.!
NOVICE

!& Setup Novice Library:! !S Get things set for using NOVICE as a novice.
The variable Novice Status controls whether the library setup function runs.
Value 0 inhibits running the setup.  If no Status variable exists, it tries to
load a profile file.  If the user doesn't have one, it queries about whether
to create one for the user.  If user wants one, it sets them up with a
profile; otherwise it defines them with Novice Status 0 and writes or revises
a VARS file.  When the setup is not being run, it returns 0 so that an INIT
file could look after unloading the library and cleaning up.  It doesn't do
any cleanup in the setup itself, because someone might be trying out the
library in order to create a profile.  Some general variables and options get
created here.  NOVICE collects data on usage unless Collect Novice Data is 0.
 !
 [0 [1[2[3[4 [5
 0fo..qNovice_Setup_Hookf"n u0	!* 0: user hook if any!
   m0'			!* either use user hook!
 -1fo..qNovice_Statusu0	!* load unless Novice Status is 0 or neg!
 q0"e				!* inhibiting if 0!
   :i*Novice_Status_is_0.__Not_completing_library_setup.fsERR'	!* give up!

 1m.cSaving_Disable_Profile*  1_is_normal_operation;_0_inhibits_changing_profile
 1m.vDisable_Profile_Changed	!* flag for use by What Keys command!

 f[DFile			!* make variable for the profile file to use!
 etDSK:EMACS_PROFILE fsHSnamefsDSname	!* default: use LOGIN diry!
 fs osteco"e etFOO_EPRFIL fs xuname fs d fn1'
 fsDFilem.vNovice_Profile_File	!* create standard variable!
 q0"l				!* no novice status variable!
   e?"n			!* and no profile file!
   @fg ft
Help_(in_the_form_of_a_NOVICE_facility)_is_available_for_people
learning_EMACS.__NOVICE_starts_you_with_a_small_subset_of_EMACS
commands_that_expands_automatically_as_you_learn.

Do_you_want_this_help_with_EMACS?_	!* find out if they might want profile!
   f[BBind			!* buffer for profile or VARS file!
   m(m.m&_Yes_or_No)"l		!* query on screen!
     fsosteco"e etEMACS;MINMAL_EPRFIL'	!* yes, copy the default one!
     "# etEMACS;MINIMAL_PROFILE'
     1:< er @y >"n		!* no default one available!
       1m(m.m&_Load_Disable_Profile)-2"n	!* set up the vars!
         :i*Problems_with_loading_NOVICE_libraryfsERR'	!* bail out!
       1m(m.mTurn_Off_Everything)	!* turn em all off in lieu of default!
       m(m.m&_Save_Disable_Profile)'	!* and save it!
     "# qNovice_Profile_FilefsDFile	!* get the name for users copy!
       eihpef'			!* put into users login directory!
     ft

Creating_EMACS_profile_for_you.'	!* and notify!
   "# fsosteco"e etFOO_EVARS fs xuname fs d fn1'	!* no help wanted!
      "# etDSK:EMACS_VARSw fsHSnamefsDSName'
				!* set up vars file to inhibit question!
     1:< er @y zj bu5>		!* get the VARS file if they have one!
     0u1			!* 1: found flag!
     <q5,z:fbLoad_Library; .u5	!* does VARS load any libraries?!
       :fbNOVICE"l 0l 1u1 0;'>	!* see if VARS loads NOVICE!
     q1"g iNovice_Status:0
 '				!* create the variable for next time!
     0m.vNovice_Status		!* set the variable for now!
     eihpef			!* write out the file!
     hk
     0u..h @v			!* try to arrange for screen to clear!
     :i*Novice_facility_not_wanted.__Not_completing_library_setup.fsERR'	!* go!
   hk				!* oops still in temp bbind!
   0u..h @v			!* arrange for screen to clear!
   '				!* end of no-profile condition!
  '				!* end of no-variable condition!

 @:i5|				!* 5: macro to build a vector of pointers!
 m(m.m&_Count_Lines)u1		!* 1: find how long a vector we need!
 q1*5fsq vectoru2		!* 2: make it!
 j 0u4				!* 4: index!
 q1<1:x3			!* 3: run individual line from temp buffer!
     1:< m3u:2(q4) >w		!* store pointer returned in vector slot!
   l %4>			!* iterate and all that!
 |
 f[BBind			!* create list of untouchable functions!
 @i| 0fs^R INIT
 Afs^R INIT
 m.m^R_Disabled_Command
 m.m^R_Disabled_prefix_command
 m.m^R_Abbrev_Expand_and_Self-Insert
 m.m^R_Abbrev_Expand_and_Call_Old_Char
 m.m^R_CRLF
 m.m^R_Quit
 |				!* add any others to this list!
 m(m.m&_Load_Bare)		!* ensure all necessary functions are avail!
 m5				!* make the qvec in 2!
 q2m.vDont_Touch_These		!* store the vector in named var!
 zj @i| afs^R INIT
 136fs^R INIT
 200fs^R INIT
 m.m^R_Prefix_Meta
 m.m^R_Prefix_Control-Meta
 m.m&_Prefix_Character_Driver
 |				!* add some more things to the buffer!
				!* determined empirically--problems exist!
 m5				!* make another qvec based on new buffer!
 q2m.vDont_Report_These	!* 2:qvec for things to filter from key status!

				!* NOW setup user codes!
 hk				!* clear the temp buffer!
 0fo..qNovice_Users_File"e	!* is a file name specified already!
   fs osteco"e etEMACS;LIST_NOVICE '	!* no, user default names!
   "# etEMACS;NOVICE-USERS_LIST'	!* find the users code list!
   fsDFilem.vNovice_Users_File'
 "# qNovice_Users_FilefsDFile'	!* yes, prepare to use it!
 1:< er >"e @y'		!* get the user code file!
 fs xunameu0			!* 0: string with home directory!
 1:s0_"l \u3			!* 3: determine user ID from stored list!
   @:i*|@ft
Remember_Control-Underscore_or_the_Help_key_for_help.
   0fsechoactivew|m.vNovice_Reminder
   0m.vNovice_Novice'		!* probably not their first time!
 "# zj z"n -fwl \u3'		!* not there, 3: last code in file!
        "# 0u3'			!* 3: init in case buffer empty!
   %3				!* 3: incr for brand new code!
   hk				!* clear out the original list!
   i0_ g3 i
				!* make a new entry if user not in list!
   hx0				!* 0: the new line!
   5-(fq0-(fq0/5*5))u3		!* 3: remainder, for nonword aligned string!
   q3-5"e 0u3'			!* arghgh.  no remainder for full word string!
   0:l				!* get at end of new line!
   q3,32i			!* make buffer wordaligned with space fill!
   1:< @:ei >"e			!* file exists!
     fsOF lengthfsOF access	!*  setup to append to end of file!
     1:< @hp ef >"n		!* hope you can append new user code to file!
				!* some kind of file error!
       0m.vCollect_Novice_Data''	!* so dont attempt to collect data!
   "# 1:<ei @hp ef>"n		!* no user list, try to make file!
     0m.vCollect_Novice_Data''	!* cant make the file!
   @:i*|@ft
Press_Control-Underscore_for_help_if_your_terminal_does_not_have_a_help_key.
   0fsechoactivew|m.vNovice_Reminder
   1m.vNovice_Novice'		!* their first time maybe!
 q3m.vNovice_User_Code		!* save the code always!

				!* NOW set up to deal with data collection!
 qNovice_User_Code"e		!* code 0 is a user who has refused permission!
   0m.vCollect_Novice_Data'	!* so always prohibit collection, option owise!
 "# 1m.cCollect_Novice_Data*  1_allows_data_collection;_0_prohibits_it'
 0fo..qNovice_Data_File"e	!* if not standard data file name already!
   fs osteco"e etEMACS;DATA NOVICE'	!* ITS name!
   "# etEMACS;NOVICE-USERS_DATA'	!* TWENEX name!
   fsDFilem.vNovice_Data_File'
 200000000000.m.vData_Mword_Mask
 177400000000.m.vData_User_Mask
 377740000.m.vData_Runtime_Mask
 36000.m.vData_Choice_Mask
 1000.m.vData_Prefix_Mask
 777.m.vData_Char_Mask
 qCollect_Novice_Data"n	!* collection OK, save identifier for user!
   fsmachine:f6u2		!* 2: host name!
   0,fsdate:fs fd convertu1	!* 1: timestamp!
   q3:\u3			!* 3: convert code to string!
   @:i0|[2]_3_0_1|	!* 0: full identifier [host] code uname tstamp!
   q0,m(m.m&_Grab_Novice_Data)	!* save it!
   '
				!* NOW arrange for our own help stuff!
 fshelp macm.vMM_Old_Help_Mac	!* save original help!
 m.m^R_Mini_Documentationm.vMini_Help_Mac	!* a simpler version!
 m.m&_What_Keysfshelp mac	!* and install new one!
 (fslinesf"e fsHeight-(fsecholines)-1'-1)/2m.vDefault_Window_2_Size
 1+qDefault_Window_2_Size/2m.cHelp_Window_Visible*  No_of_lines_for_unselected_help_buffer;_0_to_make_help_disappear	!* how much to adjust!
 :i*fo..qBuffer_Selection_Hooku1	!* 1: reminder printer on handy hook!
 @:i*|mNovice_Reminderw
1w|m.vBuffer_Selection_Hook	!* check to see if users like this!

 :m(m.m&_Load_Disable_Profile)	!* now load users profile!

!& Kill Novice Library:! !S Take away the variables and pointers to disablers.
Leaving the pointers there will cause errors if the keys are pressed.  Might
be better to make the library unkillable though.  !
 qMM_Old_Help_Macfshelp mac	!* make standard help standard again!
 1m(m.mEnable_All_Commands)
 1:f<
 m(m.mKill_Variable)Control-X_Working_Definitions
 m(m.mKill_Variable)Control-X_Initial_Definitions
 m(m.mKill_Variable)Standard_Working_Definitions
 m(m.mKill_Variable)Standard_Initial_Definitions
 >				!* let it be quiet if these aren't around!
 

!& Load Disable Profile:! !S Disable commands according to user's profile.
This applies to the standard 9-bit character set and to the dispatch vector .X
for the C-X prefix character.
The profile is a file containing 512+128 characters, each E or D.
We disable each command whose character is a D and save the previous meaning in
order to support reinstatement of original.
Returns -1 if the profile file exists, 0 if not.  With a numarg, assumes that
it is supposed to be setting up for creating a profile file if none exists and
returns -2.  The variable Novice Profile File holds the file name to read in.
!
 [0[1[2
 f[b bind
 qNovice_Profile_Filef[DFile	!* which file to use!
 e?"n				!* any nonzero code is failure!
   fff"e'w		!* returns 0 on no arg!
   m(m.m &_Ensure_Disable_Vars)	!* setup the data base!
   -2'			!* all set now to make a file!
 "# er @y			!* File exists, read the data!
   m(m.m &_Ensure_Disable_Vars)	!* setup the data base if necessary!
   -1u0				!* 0: loop counter!
   0u1				!* 1: erroneous profile if nonzero, flag!
   qStandard_Working_Definitionsu2	!* 2: qvector for standard commands!
   512< %0j 1a-D"e		!* check each key for D in profile!
     q0,q2m(m.m&_Disable_One_Command)q1u1	!* turn it off if D!
     ' >			!* returns 0 on success, failure means!
				!* that profile is wrong and needs update!
   qControl-X_Working_Definitionsu2	!* 2: vector for Control-X!
   128< %0j 1a-D"e		!* for C-X prefix subcommands!
     q0-512,q2m(m.m&_Disable_One_Command)q1u1	!* turn off if D!
     ' >
   q1"n :m(m.m&_Save_Disable_Profile)'	!* save profile if necessary!
   -1'

!& Ensure Disable Vars:! !S Create the database of flags and pointers.
Standard Initial Definitions is a q-vector holding the original definitions for
the keys when the library is first loaded.  Standard Working Definitions is the
q-vector for holding the information that applies when keys have been disabled.
Similarly, Control-X Initial Definitions and Control-X Working Definitions
contain the original and actual functions for C-X prefix subcommands.
Element 0 of the q-vector is 0 for the standard 9-bit commands and contains the
character for C-X for the Control-X prefix commands.  Element 1
points to a q-vector containing the pointers to the functions that the keys
actually run.  Element 2 points to a q-vector containing the "backup" functions
which are 0 unless the command has been disabled.  Element 3 is a string
containing the E/D profile.  Value E means the key operates normally; D means
that it is disabled.  These structures are deliberately redundant.
Numarg means allow reinitializing the Working Definitions structures. !
!* Question: does this need FS no quit to ensure validity!
 [0[1[2
 0fo..q Standard_Initial_Definitions"e	!* only if initials dont exist!
   0m(m.m&_Make_Structure)u0	!* 0: make vector for standard stuff!
   0u2				!* 2: for actual commands!
   512<q2u:(q:0(1))(q2)	!* save actual command for each!
    %2w >
   512,E:i:0(3)		!* for profile, all enabled!
   q0m.v Standard_Initial_Definitions	!* sock it away!
   fs^R Indirectu1         !* 1: code that C-X runs!
   q1m(m.m&_Make_Structure)u0  !* 0: vector for C-X stuff!
   0u2                          !* 2:loop control!
   128< q:.x(q2)u:(q:0(1))(q2) %2w >    !* copy the .x dispatch into actual!
   128,E:i:0(3)		!* for profile, all enabled!
   q0m.v Control-X_Initial_Definitions'	!*  save it!
 ff"e			!* if no arg to function, check existence!
   0fo..q Standard_Working_Definitions"n 0''	!* exists!
 qStandard_Initial_Definitions,0m(m.m&_Make_Structure)u1
				!* make vector for disable stuff by copying!
 q1m.vStandard_Working_Definitions	!* name it!
 qControl-X_Initial_Definitions,(fs^R Indirect)m(m.m&_Make_Structure)u0
 q.xu:0(1)                      !* working stuff is just .x itself!
 q0m.vControl-X_Working_Definitions'   !* ready stuff for C-X handling too!
 0

!Disable Command:! !C Disable a particular command character.
Prompts for you to type the key to be disabled.  Asks for confirmation.
Some keys cannot be disabled because doing so would prevent proper EMACS
operation.  It decides.  !
    [0[1[2
    @ftPress_key_to_disable:_	!* print prompt!
    m(m.m &_Read_Q-reg)[.1	!* ask what character to put it in!
    @ft__Go_ahead 1m(m.m&_Yes_or_No)"e 0' !* allow reneging!
    m(m.m &_Disable_Commands).1	!* go do it, cant use :m here!
    

!& Disable Commands:! !S Turn off some commands.
Takes any number of string args, each specifying a command to be turned off,
as a q-register name (such as ...W for C-M-W, or ..[ for M-).  Uses the
string returned by & Read Q-reg Name, which returns the right thing for C-X
subcommands.  These commands are disabled until the user tries to use them and
asks for them to be enabled again.  A null string argument terminates the
call.  !
 [0 [1 [2 0[3 [4[5[6 0[7
 0fo..q Standard_Working_Definitions"e  !* means that nothing is ready!
   1m(m.m &_Load_Disable_Profile)w'	    !* load or create users profile!
 qStandard_Working_Definitionsu4	!* 4: dispatcher for standard command!
 qControl-X_Working_Definitionsu6	!* 6: dispatcher for prefix commands!
 1u3				!* 3: flag for updating profile!
 < :i0 -fq0;		!* 0: Get next arg, exit if null.!
   1:f< f0 fs^R Indirectu2 >"n	!* 2: the real key code.  9-bit char!
     f0f"l :i*0_Bad_Q-register_stringfsERR'+1:g0u2
				!* 2: index for a prefix subcommand, assum C-X!
     512u7			!* save base for data collection!
     q2,q6m(m.m&_Disable_One_Command)u5'	!* do it!
   "# 0u7			!* save base for data collection!
      q2,q4m(m.m&_Disable_One_Command)u5'	!* returns 0 on success!
   q3&q5u3			!* 3: will be zero if anything changed!
   q5"n @fg @ft
5  0fsechoactive'		!* or a message to print!
   				!* if change made, save data for it!
   "#  q7+q2,6m(m.m&_Grab_Novice_Data)	!* 6 is code for turn key off!
   ' >
 q3"e:m(m.m &_Save_Disable_Profile)'	!* see whether to save result!

!& Disable One Command:! !S Turn off a working command.
Takes two args, indicating where the command information is.  Precomma arg is
index into the dispatch vectors; numarg is a qvector containing pointers to the
various other qvectors involved.  Always checks to be
sure that this is a command that it makes sense to disable.  !
 [i [v [0[1[2[3 0[4 0[5
 q:v(0)u2			!* 2: type, prefix command code or 0 for 9bit!
 q2"e  qifs^R Indirectui'      !* i: real index, already real for prefix!
 :i3This_command_must_stay_enabled.    !* 3: message!
 q:(q:v(2))(qi)"n		!* the backup has to be zero before disabling!
   :i*Continuing_would_affect_backup'	!* leave with message!
 q:(q:v(1))(qi)u0		!* 0: actual pointer!
 q0"e :i*Cannot_disable_undefined_command_key'
 qDont_Touch_Theseu4		!* list of functions that must stay!
 fq4/5< q:4(q5)-q0"e q3' %5>	!* compare pointer to each element of list!
 1f[no quit			!* make sure this happens together!
 qi:f:v(3)D			!* change E to D in profile!
 q:(q:v(1))(qi)u:(q:v(2))(qi)	!* actual goes into backup!
 q2"e				!* 9-bit command code!
   m.m^R_Disabled_Commandu3	!* 3: disabling pointer to install!
   q3ui'		!* put disabler into standard qreg!
 "# m.m^R_Disabled_Prefix_Commandu3'	!* 3: disabling pointer of other kind!
 q3u:(q:v(1))(qi)		!* put disable into actual!
 1uDisable_Profile_Changed
 0

!& Save Disable Profile:! !S Record user's profile of disabled commands.
We write the profile as 512+128 characters, each E or D for enabled or
disabled, into the file <uname> EPRFIL or EMACS.PROFILE.  No args.  The
variable Novice Profile File should contain the file name to use.
!
 qSaving_Disable_Profile"e @ft
Saving_disable_profile_is_disabled. 0'	!* check the variable!
 f[b bind			!* temp buffer!
 g:Standard_Working_Definitions(3)	!* the E/D profile!
 g:Control-X_Working_Definitions(3)	!* profile for prefix subcoms!
 qNovice_Profile_Filef[D File	!* get the file name !
 eihpef			!* save the profile!
 0

!& Enable One Command:! !S Turn on a disabled command.
Takes two args, indicating where the command information is.  Precomma arg is
index into the dispatch vectors; numarg is a qvector containing pointers to the
various other qvectors involved.  Notifies if the command being requested is
not actually disabled (that is, if its backup pointer is 0) by returning 0 if
everything is OK and a string pointer otherwise.  !
 [i [v [1[2			!* i: index, v: pointers!
 q:v(0)u2			!* 2: type. prefix code or 0 for 9-bit!
 q2"e m.m^R_Disabled_Commandu1'	!* 1: standard disabler!
   "# m.m^R_Disabled_Prefix_Commandu1'	!* 1: prefix disabler!
 q:(q:v(2))(qi)"e		!* is the backup command 0?, might be ok!
   q:(q:v(1))(qi)-q2"e		!* unless actual contains the disabler!
     :i*Command_disabled_but_no_backup_available''	!* get out!
 1f[no quit			!* protect structure against inconsistency!
 qi:f:v(3)E			!* put E in profile!
 q:(q:v(2))(qi)u:(q:v(1))(qi)	!* move backup into actual!
 0u:(q:v(2))(qi)		!* move 0 into backup!
 q2"e q:(q:v(1))(qi)ui'	!* 9-bit command, move actual into qreg also!
 1uDisable_Profile_Changed
 0				!* return 0 indicating success!

!^R Disabled Prefix Command:! !^R This function runs when you press a disabled key.
To turn a disabled key back on, press it, and answer "Y" at the prompt.

The original command runs the function q0,(q:(q:Control-X Working Definitions(2))(30f0f"lw :i*Invalid subcommand.fsERR'+1:g0))m(m.mDescribe)  !
				!* preceding lookup macro believes that the!
				!* q-reg name is in Q0, .X(^^P) for example!
 fs qp ptru9			!* 9: unwind spot!
 [0[3[4[5[9[8[7
 q..1u0				!* 0: teco leaves the subcommand in ..1!
 512+q0u5			!* 5: number in range 512 to 639!
 qControl-X_Working_Definitionsu4	!* 4: definition vector!
 q:(q:4(2))(q0)u3			!* 3: actual command!
 @:i7|q3m(m.m^R_Describe)w|	!* 7: full documenter!
 @:i8|ftC-X_ q0,q3m(m.m &_^R_Briefly_Describe)|	!* 8: short documenter!
 f@:m(m.m&_Disable_Handler)	!* pass args on through!

!^R Disabled Command:! !^R This function runs when you press a disabled key.
To turn a disabled key back on, try to use it and answer "Y".

The original command q0,(q:(q:Standard Working Definitions(2))(q0))m(m.m^R Describe)!
				!* reserves 0,3,4,5,7,8,9!
 fs qp ptr[9			!* teco leaves key code in ..0 for us!
 q..0fs^r indir[0		!* 0: the code for the command typed!
 q0u5				!* code in range 0 to 511!
 qStandard_Working_Definitionsu4	!* 4: main qvec!
 q:(q:4(2))(q0)[3
				!* 3: gets actual ptr for command!
 @:i7|q0m(m.m&_Charprint)  ft_	!* 7: full documenter!
   q0,q3m(m.m ^R_Describe)|
 @:i8|q0,q3m(m.m &_^R_Briefly_Describe)|	!* 8: short documenter!
 f@:m(m.m&_Disable_Handler)	!* run and pass args on through!

!& Disable Handler:! !S Internal function to handle general disabling stuff.
Handles prompting and showing documentation.  Is called by ^R Disabled Command
and ^R Disabled Prefix Command.  Expects some standard q-registers from caller.
 0: the index into the actual command vector
 3: the actual command pointer
 4: the structure of definitions
 5: the command code, 0 to 639
 7: a macro that runs the right full documenter
 8: a macro that runs the right brief documenter
 9: stack pointer for unwinding   ??is that really sensible??
!
 [1[2[6				!* 2: full prompt!
 fstyi countu6			!* 6: save this to clean up for later echo!
 @:i2|ft You_have_several_options,_according_to_the_next_character_you_type:
_1__Execute_the_function_just_once.__Leave_the_key_turned_off.
_Y__Execute_the_function_and_leave_the_key_turned_on_from_now_on.
_N__Do_not_execute_the_function.__Leave_the_key_turned_off.
_?__Show_a_full_description_of_what_the_function_does.
 |
 fq3"l m(m.m &_Load_Bare)'
 !Startover!
 m8				!* show the brief documentation!
 ft This_key_has_been_disabled_for_you_while_you_are_learning.

 !Retype!
 m2				!* the full help message!
 !ShortPrompt!
 ft
Type_1,_Y,_N,_or_?_		!* prompt user for input!
 @:i*\2 q5,1m(m.m&_Grab_Novice_Data)	!* 1 is code for help!
 \f[helpmac			!* replace help!
 @fg				!* clear typeahead!
 fi:fcu1			!* 1: get a char. Dont use m.i!
 ft1			!* echo it!
 f]helpmac			!* back to standard help!
				
 :o1 @fg oShortPrompt	!* now case on 1, Y, N, or ?!
 !1! q5,2m(m.m&_Grab_Novice_Data)	!* 2 is code for do it once!
   @ft
Done,_and_command_remains_turned_off.
   0fsechoactive		!* remind user about state requested!
   0u..h @v			!* reinstate screen then do fcn just once!
   fstyicount-q6u6		!* 6: how many characters to peel back!
   q6<fs.tyi backw>		!* back up input pointer!
   fstyi beg+q6fstyi beg	!* kludge this so m.i gets right count!
   f:@m(q3 (q9fsqpunw))	!* runs it and returns from there!
 !?!				!* show the full docn!
   q5,3m(m.m&_Grab_Novice_Data)	!* 3 is code for show documentation!
   :ft				!* makes it start from fs Top Line!
   m7				!* 7: run long documenter!
   o ShortPrompt		!* try again for real instruction!
 !Y!				!* Turn it on and do it once!
   q5,4m(m.m&_Grab_Novice_Data)	!* 4 is code for turn it on!
   q0,q4m(m.m&_Enable_One_Command)	!* restore whatever it is!
   0u..h @v			!* force showing screen!
   @ft
Command_now_turned_on.__Use_M-X_Disable_Command_to_turn_it_off_again.
   0fsechoactive		!* notify user!
   m(m.m&_Save_Disable_Profile)	!* save profile now in case QUIT in @m!
   fstyicount-q6u6		!* 6: how many characters to peel back!
   q6<fs.tyi backw>		!* back up input pointer!
   fstyi beg+q6fstyi beg	!* kludge this so m.i gets right count!
   f:@m(q3)			!* execute it!
 !&!				!* Intended for maintainer only; no data!
   q0,q4m(m.m&_Enable_One_Command)	!* just turn on whatever it is!
   0u..h @v			!* force showing screen!
   @ft
OK,_command_now_turned_on.	!* CHEAT -- just turn on without doing!
   0fsechoactive		!* notify me!
   :m(m.m&_Save_Disable_Profile)	!* probably saving is disabled but...!
 !N! q5,5m(m.m&_Grab_Novice_Data)	!* 5 is code for leave it off!
   @ft
Command_remains_turned_off.  0fsechoactive	!* Last case -- user said NO!
   0u..h			!* pretend nothing on screen so repaints!

!Enable All Commands:! !C Restore the default bindings of all keys.
Restores any commands that have been disabled, sets the Disabled Command
Definitions Qvector to its initial state, and saves a bland profile file.
Inhibits saving the profile file if numarg exists.  !
 [0[1[2[3
 0u0				!* 0: loop control!
 0u3				!* 3: result accumulator!
 qStandard_Working_Definitionsu1	!* 1: standard structure!
 512<q:(q:1(2))(q0)u2		!* 2: check the backup command!
   q2"n				!* something real is there!
   q0,q1m(m.m&_Enable_One_Command)"e %3w''	!* enable it!
   %0w >			!* loop control!
 0u0                            !* 0: loop control!
 qControl-X_Working_Definitionsu1     !* 1: .x dispatch stuff!
 128< q:(q:1(2))(q0)u2          !* 2: check the backup command!
   q2"n
   q0,q1m(m.m&_Enable_One_Command)"e %3w''      !* turn it on!
   %0w >
 q3:\u3
 @ft3_commands_enabled. 0fsechoactive	!* report!

 ff"e :m(m.m&_Save_Disable_Profile)'	!* maybe save clean slate!


!Turn Off Everything:! !C Make all commands run the disabler function.
This is for maintainers who are building new environments for people.  It is
much easier to turn a few things on again than to figure out the 501 things
that need to be turned off.  This does not touch the self-inserting characters,
the undefined commands, or a few commands that are necessary in order for EMACS
to operate correctly, like ^R Quit.  The list of things that are not
affected is in the variable Dont Touch These.  A numarg means to do it
quietly, with no user message.  !
 [0[1[6
 0u1				!* success counter!
 qStandard_Working_Definitionsu6	!* 6: access to the standard structure!
 -1u0				!* 0: setup to loop!
 512< (%0)fs^R Indirect,q6m(m.m&_Disable_One_Command)"e
     %1w' >			!* maybe turn off command!
 qControl-X_Working_Definitionsu6	!* 6: access to C-X structure!
 -1u0				!* 0: loop control!
 128< (%0),q6m(m.m&_Disable_One_Command)"e
     %1w' >
 q1:\u1
 "n @fg @ft
1_commands_turned_off. 0fsechoactivew'	!* report if no numarg!
 0

!Tune Profile:! !C Modify or create a disable profile file.
This prompts for the name of the file to be modified.  The default file to use
is EMACS.PROFILE in the connected directory.  This file gets created if it
doesn't exist already.  This function does not affect the present disable
state of the job that is running.  That is, it saves the current key profile
and restores it when finished.  It also turns off the data saving and profile
saving while the tuning is being done, to avoid spurious data and surprises
later in the profile.  NUMARG applies only when no EMACS.PROFILE exists.  It
means to create the profile file with everything initially off.  With no
numarg, the initial state for a new file is to leave everything on.  !
 1f[fnam syntax
 f[DFile
 etDSK:EMACS_PROFILE fsMSnamefsDSname	!* apply to connected diry!
 5,fProfile_filef"n fsDFile'	!* get string arg from function or tty!
 [f[9
 fsDFileuf			!* save the file name from any trouble!
 0[Saving_Disable_Profile	!* clobber this flag for now!
 0[Collect_Novice_Data	!* turn off any data collection!
 @fn| m(m.m&_Ensure_^R_Q-regs)|	!* ensure that Working matches q-regs!
 fsnoquitu9			!* 9: quit flag, cant push!
 1fsnoquit			!* protect for internal consistency!
 q:Control-X_Initial_Definitions(1)[.x	!* adjust .x for new Working!
 qStandard_Initial_Definitions,0m(m.m&_Make_Structure)[Standard_Working_Definitions
 qControl-X_Initial_Definitions,(fs^R Indirect)m(m.m&_Make_Structure)[Control-X_Working_Definitions
 m(m.m&_Ensure_^R_Q-regs)	!* fix ^Rs by copying in from new Working!
 q9fsnoquit			!* restore it!
 qf,1m(m.m&_Load_Disable_Profile)+2"e	!* load the profile if one exists!
   ff&1"n m(m.mTurn_Off_Everything)''	!* ifnot maybe do minimal one!
 0[..f				!* avert any autosaving!
 :i*_Push_keys_to_tune_profile_[..j	!* new mode line reminder!
 f[BBind			!* bare buffer!
 g(m(m.m&_Return_Disable_Status))	!* put in a list of stuff!
 				!* recursive edit!
 1uSaving_Disable_Profile	!* make saving possible!
 qf,m(m.m&_Save_Disable_Profile)	!* and save it !
 0

!& Ensure ^R Q-regs:! !S Copy from actuals of standard into ^R Q-regs.
This assumes that the current contents of Standard Working Definitions is
correct and copies from there into the relevant Q-regs.  !
 -1[0[1
 qStandard_Working_Definitionsu1
 512< %0
   q:(q:1(1))(q0)u0 >
 0

!& What Keys:! !S Select buffer showing current key bindings.
This is a subroutine to keep it from being reported as a recursive editing
level.  No arguments.  NOVICE installs this function in fs help mac$ during
the setup.  It creates and keeps selected a window for viewing documentation.
Size of window when not selected is in variable Help Window Visible (0 is OK).
!
 [0[1[2[3[5
 qEditor_Nameu1		!* 1: in case customized!
 @:i*|This_is_a_help_buffer_showing_what_the_keys_in_1_do.__You_can_inspect
the_list_using_Space,_Backspace,_<,_>,_N,_and_P.__(The_?_key_explains.)

|u5				!* 5: top level explanation!
 @:i*|Some_1_notation:
____When_you_want_to_insert_text_in_your_file,_just_type_it_in.
C-G_Any_time_you_are_confused,_use_C-G.__It_cancels_any_command.
--MORE--__Whenever_you_see_this_at_the_bottom_right_of_the_screen,_it_means
____that_you_can_see_more_by_pressing_Space.__If_you_press_anything_else,_and
____you_see_FLUSHED,_it_means_that_there_was_more_to_see_but_you_decided
____not_to_see_it_with_Space.
C-__Means_a_control_character.__C-F_means_hold_the_control_key_down
____and_press_F.__(Just_a_different_kind_of_shift_key_really.)
M-__Means_a_meta_character.__For_M-F_on_most_terminals,_you_press_the_key
____labeled_ESC_or_Altmode,_let_it_up,_and_then_press_F.__Some_terminals
____have_a_Meta_key.__On_them,_you_hold_the_Meta_key_down_and_then_press_F.
C-M-__Means_a_control-meta_character.__For_C-M-Z_on_most_terminals,_you_first
____press_C-Z,_which_is_called_the_Control-Meta_prefix,_let_it_up,_and_then_
____press_Z.__On_terminals_with_a_Meta_key,_you_hold_down_the_Control_key_and
____the_Meta_key,_and_then_press_Z.__(Multiple_shift_keys!)
Argument__Documentation_for_some_commands_says_that_they_take_an_argument.
____This_means_that_you_can_give_a_number_before_the_command_and_1_does
____the_command_that_many_times.__The_usual_way_to_give_an_argument_is_with
____the_Meta_key.__Use_M-2_for_2,_M-2_9_for_29.
|u3

 -1f[noquit			!* No C-G here.  Leaves confusing state!
 1:<				!* wrap whole thing in errset so ^G means Q!
 [Previous_Buffer		!* so *Keys* doesnt show up as prev!
 0fo..qWindow_2_Size"e m(m.m^R_Two_Windows)'	!* get into 2 windows!
 "# fsTop Line"e		!* if in window 1, !
    m(m.m^R_Other_Window)''	!* switch to window 2!
 :i*--------Documentation_Window----------Remember_Help_key----[..j
 m(m.mSelect_Buffer)*Keys*	!* ensure the documentation window shows!
 qDefault_Window_2_Size,2m(m.m&_Ensure_Window_Size)	!* grow it!
 z"e 1'qDisable_Profile_Changed"n	!* if buffer empty or profile changed!
   :ftConstructing_help_buffer...

 0u..h				!* tell people to expect wait!
   hk				!* clear buffer and recompute contents!
   g5				!* short header!
   g3				!* long boring explanation!
   i
Command_____Function_Name_(the_^R_is_just_part_of_the_name,_nothing_special)
				!* list header!
   g(m(m.m&_Return_Disable_Status))	!* show whats available.  Format??!
   j				!* at top of display!
   0uDisable_Profile_Changed'
 q5,7m(m.m&_Grab_Novice_Data)	!* 7 is code for Help at top level!
!show!				!* prompt for character!
 @v				!* make buffer show!
 !prompt!
 :I*CFSECHODIS		!* clear echo area to start!
 @:ftOptions:_Help,_Space,_Backspace,_<,_>,_N,_P,_?,_or_Q:__ 0fsechoactive
 0f[helpmac			!* allow Help as input!
 FI:FCU0			!* no m.i, makes confusing echoes in echo area!
 q0-4110."e Hu0'		!* make Help key act like an H option!
 f]help mac			!* reactivate standard Help!
 :O0@FG Oshow		!* jump to label or loop if cant jump!
				!* little jump table here!
 !Q! :i*Cfsechodisplay	!* clear prompt from echo area!
     qHelp_Window_Visiblef"n ,2m(m.m&_Ensure_Window_Size)	!* shrink!
     :m(m.m^R_Other_Window)'	!* leave display selected!
     w :m(m.m^R_One_Window)	!* owise make help disappear!
 !_! @m(m.m^R_Next_Screen)w oshow
 !! @m(m.m^R_Previous_Screen)w oshow
 !<! j oshow			!* left angle bracket for top!
 !>! zj oshow			!* right angle bracket for bottom!
 !N! 1@m(m.m^R_Next_Screen)w oshow	!* scroll by!
 !P! 1@m(m.m^R_Previous_Screen)w oshow	!* single lines!
 !H! mMini_Help_Macw 0u..h Oprompt
 !?! :ftThis_help_buffer_lists_the_commands_that_work_in_1.__You_can_move_around
to_see_more_of_the_buffer_or_use_the_Help_key_for_more_help.__Select_an_option:
____Space___shows_the_next_screen
_Backspace__shows_the_previous_screen
______<_____positions_you_at_the_top_of_the_list
______>_____positions_you_at_the_bottom_of_the_list
______N_____shows_one_more_line_at_the_bottom
______P_____shows_one_more_line_at_the_top
______Q_____returns_to_the_editing_buffer
 0u..h Oprompt
 >u0				!* caught some err!
 f~0QIT-4"e oQ'		!* let C-G be handled nicely!
 1:<:m(m.m^R_One_Window)>	!* just get out owise!
 				!* and hope window stuff didnt fail!


!& Return Disable Status:! !S Creates a string containing survey of keys.
Returns the string for further munging.
Format to be decided.  Usage to be decided.  !
 [b[e[c[n[v[p [0[1[2[3[4[5	!* try letter qreg names here!
 m(m.m&_Load_Bare)		!* we need this somehow or & macro name dies!
 qDont_Report_Theseun		!* n: filter out names!
 m.m&_Novice_Charprintue	!* e: returns printing name!
 m.m&_Check_Black_Listuc	!* c: returns flag to keep it from printing!
 m.m&_Macro_Nameub		!* b: printing name of fcn!
 @:i*| < %5-q3; %0j		!* 0: buffer pointer, 5: vector pointer!
   1a-E"e			!* look only at things enabled by profile!
     q:(q:v(1))(q5)mcu1		!* 1: 0 for no go, else fcn ptr!
     q1"n q1mbu2		!* 2: string with macro name!
       q2"e :i2runs_an_internal_function'	!* nameless impure string...!
     q4,q5meu1			!* 1: string with character name!
     zj i
				!* crlf!
     g1				!* command!
     10-(fshpos)f"lw 2',32i	!* pad somewhat with spaces!
     g2''			!* name!
  >|up				!* a macro to do the right thing!
 f[bbind			!* working buffer!
 g:Standard_Working_Definitions(3)	!* load E/D strings into it!
 g:Control-X_Working_Definitions(3)
 -1u0				!* 0: for character index into buffer!
 qStandard_Working_Definitionsuv	!* w: std!
 -1u5				!* 5: character index into dispatch!
 :i4				!* 4: empty prefix!
 fq:v(3)u3			!* 3: where to stop!
 mp				!* work out standard names!
 qControl-X_Working_Definitionsuv	!* setup to do C-X names!
 -1u5				!* 5: character index into dispatch!
 :i4C-X_			!* 4: prefix!
 fq:v(3)u3			!* 3: new stopping place!
 mp				!* collect C-X names!
 0,640k				!* ouch, hardwired number!
 hx*

!& Check Black List:! !S Check each element of Dont Report These qvec -- in N!
 -1u9				!* check each element of Dont Report qvec!
 fqn/5< %9			!* arg is function pointer!
   -q:n(q9)"e 0' >		!* return 0 if not supposed to report!
    			!* or ptr called with if supposed to!

!& Make Structure:! !S Returns Q vector needed for NOVICE command fiddling.
Has a 4 element Qvector.  No arg or 0 means standard type.  Otherwise, the arg
is taken to be the prefix character.  A precomma arg means use the structure
it points to to initialize the new one.
 Element Contents
 0       "type", meaning 0 for standard kind or prefix character code
 1       Qvector containing the actual commands to run for key press
 2       Qvector containing the backup commands in case actual holds disabler
 3       String containing the E/D flags for the profile
This correctly makes new copies of the q-vecs and string BUT needs to be
changed if this data structure happens to change, especially in levels.
!
 0[0[1[2[3 0[4[5
 ff&1"n u0'		!* 0: type!
 ff&2"n u4'		!* 4: vector to use in initializing new struc!
 q4"n				!* if something to copy from!
   0fsqvectoru1		!* 1: pointer to new one!
   q1[..o			!* push buffer and select the new structure!
   g4				!* make a copy of the old one!
   ]..o				!* pop pdl to get back buffer!
   -1u2				!* now make copies of individual elements!
   fq4/5< %2			!* 2: loop index!
     q:4(q2)u3			!* 3: the old element!
     0fsqvectoru5		!* 5: a new vec element!
     q3fp"g			!* if old ele is q-vec or string!
       q5[..o			!* make a copy of it!
       g3
       ]..o
       q5u:1(q2)'		!* install new ele in new vec!
    >'
 "#				!* otherwise make from scratch!
   4*5fsqvectoru1		!* 1: the vector being built!
   q0u:1(0)			!* load the type!
   q0"e 512u2'			!* 2: length for 9-bit character!
   "# 128u2'			!* 2: dispatch table length needed!
   q2*5fsqvectoru:1(1)		!* install vector for actual!
   q2*5fsqvectoru:1(2)		!* install vector for backup!
   q2,0:i:1(3)'			!* install null string of right length!
 q1				!* return qvec!

!& Grab Novice Data:! !S Save this data point in file.
 numarg indicates choice code to save.
 precomma arg is the index of the character being processed.  0-511 is for
   standard ones, 512-639 is for C-X prefix ones.  If precomma arg is a string
   pointer, then this is a different kind of entry, saving a multiword entry
   whose contents are the string pointer.
Bit assignments:
 34     Flag for multiword entry.  Word count is in rightmost 10 bits.
 33-26  User code (mask 177400000000.)
 25-14  Current teco runtime in seconds (mask 377740000.)
 13-10  Choice made (mask 36000.)
 9      Flag for prefix character (mask 1000.)
 8-0    Character number index (mask 777.)
Append this stuff to the appropriate file.  !
 qCollect_Novice_Data"e '	!* 0 means no saving going on!
 0[0 [1 0[2
 qNovice_Data_Filef[D File
 5f[BBind 0,0fsWord		!* make a word of zeros in a temp buffer!
 ff&1"n *2000.&qData_Choice_Masku0'	!* 0: shift and mask choice!
 fp-101"n			!* what is the precomma arg!
   &1777.q0u0'		!* 0: add in the character index!
 "# u1			!* 1: string pointer we hope!
   q0qData_MWord_Masku0	!* 0: add multiword flag!
   zj g1			!* get arg into buffer!
   5-(fq1-(fq1/5*5))u2		!* 2: remainder, for nonword aligned string!
   q2-5"e 0u2'			!* arghgh.  no remainder for full word string!
   q2,32i			!* make buffer wordaligned!
   fq1/5+(q2f"nw 1')q0u0'	!* 0: word count in right half!
 qNovice_User_Code*400000000.&qData_User_Maskq0u0	!* 0: put in user code!
 fsrun time/1000*40000.&qData_Runtime_Maskq0u0	!* 0: runtime convert!
 Q0,0fs Word			!* install data word in buffer!
 1f[no quit			!* protect consistency!
 e\				!* push the output channel!
 fn e^				!* be sure to pop output channel properly!
 0u2 !Again!			!* 2: error counter!
 e?"e 1:< @:ei			!* file exists, setup to append to end of file!
  fsOF lengthfsOF access >u0'	!* 0: file error!
 "# 1:< ei >u0'			!* file doesnt exist, just open it!
 q0"n q2-2"e			!* check which error, after 3 failures give up!
     :i*
Data_file_busy.__Discarding_data.fsecho out	!* give up on data but warn!
     0fsechoactive 0'	!* and continue on!
   0,7:g0u1			!* 1: pick up file error type!
   f~1OPN0130"n q0fserr'	!* unless 0130 for simult access, bail out!
   30				!* sleep for a second if file is just busy!
   %2				!* flag that we failed!
   oAgain'			!* give it several chances!
 @hp ef			!* binary write.  leave bit alone.  need :ef??!
 0

!& Return Novice Data:! !S Return string containing data from data file.
Converts stuff to string format from packed word format.
!
 [0[1[2[3[4[5[p
 :ip				!* p: the data string, initially empty!
 qNovice_Data_Filef[DFile	!* where is/are the data!
 f[BBind
 1:< er fy ec>f"n fsERR'w	!* read binary file!
 0u0				!* 0: index into data buffer!
 :<q0fsWordu1			!* 1: next word!
   q1&qData_MWord_Mask"e	!* single data point?!
     q1&qData_User_Mask/400000000.:\u2	!* yes, 2: user code!
     q1&qData_Runtime_Mask/40000.:\u3	!* 3: timestamp string!
     q1&qData_Choice_Mask/2000.:\u4	!* 4: choice made!
     q1&qData_Prefix_Masku5	!* 5: nonzero if prefix char!
     q1&qData_Char_Masku6	!* 6: char code!
     q5"n :i*C-X_,'q6m(m.m&_Novice_Charprint)u5
     :ipp2_3_4_5
				!* p: aggregate data point string!
     q0+5u0'			!* for next word!
   "# q1&qData_Char_Masku2	!* no, 2: word count of multiword item!
     q0+5u0			!* for next word!
     q0,q2*5+q0x3		!* 3: string!
     :ipp3
    q2*5+q0u0'			!* 0: adjust pointer past string!
  >f"nu3 f~3NIB-4"n		!* presumbly just errs out when done!
    q3fsERR''w			!* NIB is ok, report err otherwise!
 qp

!& Novice Charprint:! !Version of Charprint for NOVICE library.
Numarg is a standard command code (0 to 511).  Precomma arg is a string to
prefix to the character name -- e.g. pass it C-X for a prefix subcommand.
It returns a string to print for the character name.  !
 [0[1[2 :i1			!* prefix string!
 -4110."E :I*Help'		!* special case!
 u0				!* 0: the character code!
 ff&2"n u1'		!* 1: the prefix string!
 fq1"g -32"l q0+100.200.u0''	!* adjust num and add control bit!
 q0&200."N :I11C-'
 q0&400."N :I11M-''
 q0&177.U0			!* just the number part!
 Q0-127"E :I*1Rubout'	!* splice together with C- and return!
 Q0-27"E :I*1Altmode'
 Q0-8"E :I*1Backspace'
 Q0-9"E :I*1Tab'
 Q0-10"E :I*1Linefeed'
 Q0-13"E :I*1Return'
 Q0-32"E :I*1Space'
 q0:i2 :i*12		!* none of the above means self!

!^R Mini Documentation:! !Runs subset of the usual EMACS documentation function.
This was designed for use in the NOVICE package.  Initial tests showed that
features like tecord, info, and recursive levels were just too much help to be
useful to a real beginner.  !

 0[A[B
 q5,8m(m.m&_Grab_Novice_Data)	!* 8 is code for Help within Help!
 !Prompt!
 :i*CHelp_Option_(A,_C,_D,_Q,_or_?):_fsEchodis
 0F[HELPMAC
 FI:FCUB
 QB-4110."E_?UB'
 F]HELPMAC
 -1fstypeout			!* on this short window, start all from top!
 :OB @FG OPrompt	!* dispatch on input char, loop on error!
 !A!:IBAproposOXX
 !C!:I*CCharacter:_FSECHODIS
    :M(M.M^R_Describe)
 !D!:IBDescribe8UAOXX
 !Q! 				!* just return!
 !?!!"!:FT
 This_is_the_menu_of_Help_options.__Press_the_key_for_the_kind_of_help_you_want.
 ___C___Says_what_a_certain_Command_(character)_does.__You_type_the_character.
 ___D___Describes_a_function.__You_type_the_name.
 ___A___lists_all_function_names_containing_some_word.__You_type_the_word.
 ___Q___Quits_--_you_don't_really_want_help_this_kind_of_help.
 
 For_a_basic_tutorial_to_EMACS,_run_the_program_
 fsosteco"e ftTEACHEMACS.'"# ftTEACH-EMACS.'ft
 
 0U..H OPrompt
 !XX!				!* do whatever command has been constructed!
 QA+1,M(M.M&_Read_Line)B:_UA
 QA"E '
 !EXECUTE!
 F~BApropos"E 1'M(M.MB)A
 
				!* took out the following!
 !NF[DFILEM(M.MView_File)EMACS;EMACS_NEWS!	!* news file too hairy!
 !I:M(M.M^R_Info)!		!* take out INFO!
 !L:M(M.M^R_What_Lossage)!	!* not clear this one is illuminating!
 !M.*100/(FSZ):\UB:FT..J--B%--FSMODIF"N_FT_*'FT
 !				!* print contents of mode line -- trash it!
 !T:IBTecdocOXX!		!* tecdoc goes!
 !V:IBList_VariablesOXX!	!* take out !
 !W:IBWhere_Is8UAOXX!		!* esoteric!
 !R 0[D1,M(M.M&_Read_Line_Help)!	!* confusing!
				!* The following lines were removed!
!* ___L___tells_you_the_Last_60_characters_you_typed.
  ___N___prints_a_file_of_EMACS_news.
  ___I___runs_the_INFO_program_for_detailed_documentation.
  ___R___describes_current_Recursive_editing_level.

 More_advanced_options:
 T_-_run_TECDOC;_V_-_run_List_Variables;_W_-_run_Where_Is;
 M_-_print_the_contents_of_the_mode_line_(for_printing_ttys).
 SPACE_repeats_previous_A,_D,_T,_V_or_W_request.
!

!Where Is:! !C Find what command would run a function.
This is a Where Is function for the NOVICE library.  The standard Where Is
cannot be used with NOVICE because it does not report bindings for disabled
commands.  This function really should be called "Where Would Be"...
Numarg is the function pointer; any string arg is the function name.
Semantics and code for precomma arg comes from original Where Is and is a 
complete mystery to me.  !
				!* uses 0,1,2,3,4,5,6,x,p!
 FF&1"N [1'		!* numarg is function ptr!
 "# 9,FFunction:_[1WM.M1U1'	!* or string arg is function name!
 [x[p[5[6
 ux				!* x: the precomma arg!
 @:ip| -1U0			!* 0: where to start in qvec!
 <%0,Q1F4U0Q0:;		!* p: check for occurrences of target ptr!
   Q2-4"G FT,_etc.		!* stop when youre up to 4 total!
     '
   qx-2"N %2"E qx"N FT__which'	!* for first one, print which stuff!
       FT_can_be_invoked_via:_'
       "# FT,_''		!* for later ones, print comma separator!
    q3,Q0M(M.M&_Novice_Charprint)u6	!* return the command name!
    ft6_
    qx-2"E -1'		!* bit 2 is off, now return a -1!
   > |
 Q1:"L M(M.M&_Load_BARE)'	!* get BARE if pointer indicates!
 -[2				!* 2: number of bindings found!
 qx"E				!* no precomma arg!
    FTThe_function_		!* print a standard line!
    Q1M(M.M&_Macro_Name)[5	!* showing name of function!
    FT5'
 -[0				!* 0: default value is l!
 qx-2"E				!* precomma arg has bit 2 off!
    400.,Q1:FU0		!* look through the C-M- ones first...!
    Q0"L 0,Q1:FU0'
    Q0:"L Q0M(M.M&_Novice_Charprint)-1''
				!* now go through all the possible places!
  :i3				!* 3: null name prefix!
  q:Standard_Working_Definitions(1)u4	!* 4: where to look!
  mp				!* look for it!
  q:Standard_Working_Definitions(2)u4
  mp
  :i3C-X_			!* 3: name prefix!
  q:Control-X_Working_Definitions(1)u4
  mp
  q:Control-X_Working_Definitions(2)u4
  mp

 Q2"L qx-2"E 0'qx"N '	!* didnt find any, return if precomma arg!
    FT_is_not_bound_to_a_key.
 Use_M-X_5_<cr>_to_invoke_it.'	!* say what to do!
				 !* owise, say not bound!
 FT
 				!* print a closing CRLF for report!


!& Ensure Window Size:! !S Force a window to a certain target size.
NUMARG says which window is being specified.  Precomma arg holds the target
size for the window.  0 means that the window will end up disappearing;
anything too large means that the window takes over the screen.  !
 [0[1[2[3
 0fo..qWindow_2_Size"e		!* only one window now!
   -1"e "e ''		!* quit if W2 target size is 0!
   m(m.m^R_Two_Windows)	!* if W2 needed, make it!
   fm(m.m&_Ensure_Window_Size)	!* call self to ensure size!
   :m(m.m^R_Other_Window)'	!* return to where we started!
 u2				!* 2: target size for window!
 :\u0				!* 0: window name as string!
 qWindow_0_Sizeu1		!* 1: current size of relevant window!
 q2-q1"e '			!* already there!
 q2"n				!* target size not zero!
   (fsheight-(fsecholines)-1)-q2"g	!* and target size within reason!
     fstop linef"n w 1'#(-1)"n -'(q2-q1):m(m.m^R_Grow_Window)'
				!* if current is target OK, owise minus adjust!
   "#				!* target size exceeds max!
     -1"e :m(m.m^R_One_Window)'	!* W1 takes over!
     1:m(m.m^R_One_Window)''	!* or W2 takes over!
 "#				!* target size is zero!
   -1"e 1:m(m.m^R_One_Window)'	!* W1 must disappear!
   :m(m.m^R_One_Window)'	!* or W2 must disappear!

 