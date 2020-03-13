!* -*- Teco -*- *!

!* ZBABYL: A library of extensions to Babyl inspired by ZMail,
	    the Lisp Machine's mail reader.

 This library was created by and is maintained by KMP@MC.
 It is an extension to the Babyl mail reader, developed primarily
   by EAK@MC and ECC@MC.

 Modification History:

06/03/85 46	KMP	Make re-entry after c-X c-C not reload EMACS;ZBABYL LISP.
04/27/85 45	KMP	Optimizations to conserve compiler stack space.
04/14/85 42	KMP	Install as a normal Emacs library, changing
			 references to the KMP directory to EMACS references.
10/11/84 41	KMP	Make file loader not say 
			 "Loading ... into package ...", preferring
			 prefixed comment "Loading Lisp file ...".
10/11/84 40	KMP	Make # Babyl # suggest redisplay after returning.
10/11/84 39	KMP	Inline a ~P hack to # Babyl # support, so it says 
			"message" and "messages" in the right places.
10/10/84 38	KMP	Fix map bug where D was doing N-after-D and 
			 the map wasn't seeing the N'd-to message.
10/09/84 37	KMP	Changed format of *FILTER-COMMAND-LIST*, renaming
			 it to *FILE-FILTER-DAEMONS*.
10/08/84 36	KMP	Added support for *FILTER-COMMAND-LIST*.
			 This support is not yet announced and needs fixing
			 before it is. It must somehow do error-checking to
			 assure that it is run after G only in the user's
			 primary mail file, or else it must be a per-mail file
			 option.
10/08/84 34	KMP	Changed default for Babyl Survey Before Expunge to 1.
10/08/84 33	KMP	Added support for the # (mapping) command.
			Changed | to prompt for filter instead of label.
--/--/-- 32	KMP	** This update, which survived awhile, was not documented **
04/26/84 29	KMP	Make ZBabyl use and update Expiration-Check-Time and
			 Expiration-Check-Interval for each file.
01/12/84 28	KMP	Make Babyl autoload if not present so this can be
			 a Mail Reader Library.
01/12/84 27	KMP	Fix UVN error for All Babyl Filter Names 
			 in & Filter Call which happened sometimes if 
			 interactive filter caller wasn't called before
			 non-interactive one.
			Fix bug in & Query related to superquoting.
01/12/84 26	KMP	Let LOAD work inside a filter init file to indirect
			 to other files.
			Make ZBabyl Startup get called from Babyl G Done Hook
			 unless user has specified something better.
			 Some of the things in this Babyl G Done Hook are
			 heuristic; the right way to hack survey on startup
			 is to make it a per-babyl-file option so it gets
			 reset correctly upon I but not on G.
01/11/84 25	KMP	Introduced subroutine ZBabyl Startup to survey
			 initial messages.
01/11/84 24	KMP	Introduced a LET primitive into Lisp. It's really
			 a COMPILER-LET since it happens only at compile time,
			 but it looks like the right thing. Now we can write
			 recipient filter as
			  (LET ((RCPT (PROMPT STRING "Recipient")))
			    (OR (SEARCH-FIELD TO RCPT) (SEARCH-FIELD CC RCPT)))
01/10/84 23	KMP	Introduced internal routines & Query and & Remark
			 to save a little space and make things more readable.
			Made the thing that decides if it wants to check
			 for expired mail wait a second, peeking for an N
			 and deciding not to do survey if that happens.
			Made the query about editing the expired mail survey
			 allow Rubout to mean No. Space still doesn't mean
			 yes because it could be taken for a command; that's
			 less likely for Rubout.
01/05/84 18	KMP	Added support for auto-expiration check to happen
			 less often by using some periodicity information.
			 To be really effective, this needs support from
			 Babyl itself.
01/03/84 17	KMP	Added ^R Grow Window on c-X ^
12/21/83 16	KMP	Autoload support for LispM mouse when %TOFCI non-zero.
12/09/83 15	KMP	Fixed some bugs/misfeatures related to what happens
			 when you type only a partial label name.
			Fixed a bug in error cleanup when you answer no to
			 the create a new filter query.
12/09/83 13	KMP	Added c-X 1, c-X 2, c-X O.
12/09/83 12	KMP	Made PUR errors in Survey at least try to be trapped.
			Made ^G quit during Survey type out Aborted and then
			 propagate the error outward. In version 11, ^G was
			 accidentally caught by the @:<...> in the surveyor.
12/09/83 11	KMP	& Babyl Expunge says "Checking for expired mail"
			 instead of "... dead mail".
			Introduced control variable that lets 
			 & Babyl Expunge say it doesn't want "Done", etc.
			 typed out.
			Made & Survey Filtered Messages say what filter it
			 was that failed.
			Made URK errors in surveys get trapped better.
12/08/83 10	KMP	Fixed a bug in c-X E which made it make the Start Date
			 be at the given time rather than two days before.
12/08/83 9	KMP	Made & Babyl Expunge use & Survey Filtered Messages.
			Fixed bug in c-X dispatch that made ^@ print out
			 on commands that weren't defined.
			Made c-X upcase the its dispatch char before using.
			Added c-X E, c-X R, c-X S, and c-X X.
12/08/83 8	KMP	Flushed PROMPTED-LABEL and PROMPTED-SEARCH in favor
			 of (PROMPT STRING string), (PROMPT LABEL string),
			 and (PROMPT FILTER string), which can replace any
			 string arg.
			Flushed NO-LABEL in favor of (NOT (LABEL)).
12/07/83 7	KMP	Made c-X be a dispatch character. What used to be
			 c-X is now c-X c-C (or c-X c-Z for Twenex).
			 Added new command c-X c-B to Edit Mail Files.
12/04/83 6	KMP	Fixed minor harmless typo in a filter definition.

12/03/83 5	KMP	Made & Next Filtered Message faster by having it
			 not recompute current message number.
12/03/83 4	KMP	Made m-X Survey All Messages
			     m-X Survey Messages Containing String
			     m-X Survey (Un)Deleted Messages 
			     m-X Survey (Un)Labeled Messages
			     m-X Survey (Un)Seen Messages 
			 drive off of explicit filters.
			To support these, also introduced 
			 New Lisp macros PROMPTED-LABEL and PROMPTED-SEARCH
			  which are like LABEL and SEARCH but use string arg to
			  prompt user for a string each time filter is used.
			 New Lisp symbols T and NIL which are true and false.
12/03/83 2	KMP	Changes to & Survey Filtered Messages to make it
			 not type out at all when no messages found.
			 A side-effect of this change is that the *Survey*
			 buffer has old contents if a survey fails. This is
			 good interactively but may be confusing for messages
			 that want to map across surveys; they may have to
			 manually flush the survey buffer to avoid getting
			 stale data.
			Fixed a bug in & Next Filtered Message which caused
			 an error if ^G'd during because buffer bounds were
			 usually narrow and the FNQ1J it wanted to do to 
			 restore . was usually outside the buffer bounds.
12/03/83 1	KMP	Created the ZBABYL library by merging
			 KMP;FILTER 217 and KMP;BABBLE 145

Before this point, this library was in two parts which were mutually
dependent upon each other. 

Modification history for MC:KMP;BABBLE >

12/03/83 145	KMP	Make m-X Survey Expired Messages and
			 m-X Survey Reminders use real filters.
12/03/83 144	KMP	More stuff to preserve original point.
			Make m-X Yank References do better formatting.
12/03/83 143	KMP	Make m-X Yank References preserve original
			 point better.
			Make & Babyl Message Descriptor not err on bad
			 msg format
12/03/83 142	KMP	Make @ accumulate reference info from touched
			 messages in addition to msg info itself.
12/03/83 141	KMP	The Before-Expunge filter referenced BEFORE
			 instead of PRECEDES.
12/03/83 140	KMP	Added m-X Set Stop Date.
12/01/83 139	KMP	Made K/Y preserve Included-Msgs, etc.
			Introduced new commands @ and
			 m-X Yank References.
11/29/83 138	KMP	Fixed lurking bug that had the message sorter
			 calling # Babyl J rather than recomputing the
			 message number.
11/23/83 137	KMP	Made & Babyl Expunge bind the flag saying if
			 the expired check needs doing, so it won't
			 recurse if user types E or Q in the survey
11/23/83 136	KMP	Fixed bug in & Babyl Expunge where the
			 Message Number was not being correctly set
			 before calling & Babyl Select Message,
			 causing Babyl to become hopelessly confused
			 later about what the current message number
			 was.
			Changed 0,(fsz) to 0,fsz in misc places
			 to save a couple chars...
11/21/83 135	KMP	Fixed foolish bug in & Babyl Expunge that made
			 expired message notice happen always instead
			 of only when message really expired.
11/20/83 134	KMP	Made & Babyl Expunge offer a real survey
			 instead of querying per-item.
			Renamed the Babyl Remind to Delete variable
			 to Babyl Survey Before Expunge, and the
			 default filter to Before-Expunge.
			Fixed a bug that made Expunge lose track of
			 the current message number.
11/22/83 102	KMP	[Retroactive Patch] Fixed bug in
			 & Babyl Expunge which sometimes read q0
			 without binding it first (since binding was
			 being done in a conditional)
11/11/83 101	KMP	Made m-X Set Expiration Date warn if the given
			 date is in the past.
			Changed argument conventions so that
			 m-X Set ... Date defaults to "now" and needs
			 a minus arg to remove
11/05/83 96	KMP	Made m-X Set Expiration Date and friends work
			 not only on Babyl messages but also on a
			 *Mail* buffer.
10/26/83 93	KMP	Added this modification history by perusing
			 backup copies of sources that were still
			 online. Functionally same as version 92.
10/20/83 92	KMP	Add SEARCH-WITHIN-MSG to the ZMail support.
10/20/83 91	KMP	Hacked & Babyl Expunge to maybe look for
			 things it should remind user to delete.
			Added Read Filter Library, with support for
			 understanding ZMail init files
10/17/83 38	KMP	Removed _ command. Not general enough. Too
			 hard to do reasonable error checking.
10/14/83 23	KMP	Experimental _ command to set start/expiration
			 date for seminar notices.
10/12/83 22	KMP	Fix bug where our Survey Reminders only took
			 effect if this library was loaded second
10/01/83 21	KMP	& Survey Several Messages takes string arg,
			rather than numarg
09/30/83 20	KMP	Beginning of prehistory for MC:KMP;BABBLE >

Modification history for MC:KMP;FILTER >

11/29/83 217	KMP	Fixed ^E to not return a value so its argument
			 gets flushed like it should when it's done.
11/29/83 216	KMP	Renamed AFTER/BEFORE to FOLLOWS/PRECEDES.
			 Old names will work for a short while for
			 compatibility, but will disappear very soon.
11/28/83 213	KMP	Made compilation more solid. Introduced
			 provisions to quote questionable text
			 appropriately in output
			Introduced provision for comments in code.
			Fixed argument defaulting for BEFORE, AFTER,
			 and SEARCH-FIELD.
11/23/83  186	KMP	Added autoload trampoline for & Edit Filter
			 which is in FMENU, but which had been left
			out of the changes in version 185.
11/11/83  185	KMP	Moved the menu stuff into its own library
			 (FMENU) so it can be loaded only when
			 really needed.
10/28/83  184	KMP	Added this modification history by perusing
			 backup copies of sources that were still
			 online. Functionally same as version 183
10/20/83  183	KMP	Cosmetic changes to output of Show Filter.
10/19/83  182	KMP	Fix Filter ..D was to up paren syntax right.
10/19/83  180	KMP	Create & Prepare to Use Next Filter as a
			 common subroutine for use in multiple places
10/16/83  178	KMP	Change setup of Filter ..D to be done from
			 scratch instead of from Lisp mode.
10/07/83  177	KMP	Introduced support for FILTER-CALL and
			 NO-LABEL in Lisp
10/05/83  164	KMP	Beginning of prehistory for MC:KMP;FILTER >

*!

!~Filename~:! !Extensions to Babyl inspired by ZMail!
ZBABYL

!& Setup ZBABYL Library:! !& Setup stuff !

 !*  Set up a special syntax table for our compiler			*!

  0fo..QFilter_..D"e		    !* If no Filter ..D exists		    !
   [0[..D			    !*  Bind temp qregs			    !
    :g..Du..D			    !*   Init our ..D from previous one	    !
    0u0				    !*   Init counter			    !
    <q0-128; 5*q0+1:f..DA %0>    !*   Default all Lisp syntax to alpha   !
				    !*   Set up special syntax chars	    !
    1m(m.m&_Alter_..D)__	_
_"|/(()) !'!
    q..Dm.vFilter_..D		    !*   Save this syntax info		    !
   ]..D]0'			    !*  Unbind temps			    !

 1,m(m.m&_Get_Library_Pointer)TPARSE"e
  m(m.mLoad_Library)TPARSE'

 :i*fo..QBabyl_K_Msgsm.vBabyl_K_Msgs
 :i*fo..QBabyl_K_Refsm.vBabyl_K_Refs
 :i*fo..QBabyl_@_Refsm.vBabyl_@_Refs

 !*  Shadow some normal Babyl command(s)				*!

 m(m.m&_Get_Library_Pointer)ZBABYL[L

 qLm.mSurvey_Reminders           m.v MM_Survey_Reminders
 qLm.mSurvey_All_Messages	  m.v MM_Survey_All_Messages
 qLm.mSurvey_Messages_Containing m.v MM_Survey_Messages_Containing_String
 qLm.mSurvey_Deleted_Messages    m.v MM_Survey_Deleted_Messages
 qLm.mSurvey_Undeleted_Messages  m.v MM_Survey_Undeleted_Messages
 qLm.mSurvey_Labeled_Messages    m.v MM_Survey_Labeled_Messages
 qLm.mSurvey_Unlabeled_Messages  m.v MM_Survey_Unlabeled_Messages
 qLm.mSurvey_Seen_Messages	  m.v MM_Survey_Seen_Messages
 qLm.mSurvey_Unseen_Messages     m.v MM_Survey_Unseen_Messages

 qLm.m&_Babyl_Expunge            m.v MM_&_Babyl_Expunge

 qLm.m#_Babyl_Y		  m.v MM_#_Babyl_Y
 qLm.m#_Babyl_K		  m.v MM_#_Babyl_K
 qLm.m#_Babyl_|		  m.v MM_#_Babyl_|
 qLm.m#_Babyl_^S		  m.v MM_#_Babyl_^S
 qLm.m#_Babyl_^X		  m.v MM_#_Babyl_^X

 :i*fo..QBabyl_Mail_File_Namesm.vBabyl_Mail_File_Names

 :i*Remindersm.vFilter_Default

 1m.vFilter_Verbose


 0fo..QBabyl_^X_Dispatch"e
   0m.vBabyl_^X_Dispatch
   m(m.mMake_Prefix_Character)Babyl_^X_Dispatch'
 [D
    qBabyl_^X_DispatchuD
    m.mEdit_Babyl_Mail_Files   u:D()
    m.mExit_Babyl_Temporarilyf(u:D())u:D()

    m.mSet_Event_Date		u:D(E)
    m.mSet_Start_Date		u:D(R)
    m.mSet_Stop_Date		u:D(S)
    m.mSet_Expiration_Date     u:D(X)

    m.m^R_One_Window		u:D(1)
    m.m^R_Two_Windows		u:D(2)
    m.m^R_Grow_Window		u:D(^)
    m.m^R_Other_Window		u:D(O)

 ]D

 1fo..QBabyl_Survey_Before_Expungem.vBabyl_Survey_Before_Expunge

 0fo..QBabyl_G_Done_Hook"e
   @:i*|m(m.mZBabyl_Startup)|m.vBabyl_G_Done_Hook'

 0fo..QZBabyl_Init_Loaded"e	    !* If no init loaded...		!
  m(m.m Read_Filter_Library)EMACS;ZBABYL_LISP'

 fs%tofci"n m(m.m Load_Library)ZMOUSE '	    !* Assure ZMouse	    !
 1,m(m.m&_Get_Lib)Babyl"e m(m.mLoad_Lib)Babyl'  !* Assure Babyl	    !

 				    !* Return		!


!<ENTRY>:! !S ZMail-like Mail file editor subsystem.!

 f:m(m.mBabyl)


!& Query:! !& Ask a question (string arg) in echo area !

 :i*Cfsechodisplay		    !* Clear echo area	!
 @ft			    !* Type the query	!
 1m(m.m&_Yes_or_No)		    !* Read reply	!


!& Remark:! !& Type string arg in echo area!

 :i*Cfsechodisplay			    !* Clear echo area		    !
 @ft
 					    !* Display string arg + CR	    !
 0fsechoactive				    !* Assure typeout is preserved  !
 					    !* Return			    !


!Set Expiration Date:! !C Set the Expiration Date for this message.
Default date is "now". With a negative arg, removes the Expiration Date!

 :i*Expiration[T		    !* qT: date type	!
 1,(f):m(m.m&_Set_Date)	    !* Go do it		!


!Set Event Date:! !C Set the Start/Stop/Expiration date for an Event.
The default is for the message to start 48 hrs in advance and end 1 hr after.
With a positive arg,  n, the message Expires n  hours after the event.
With a negative arg, -n, the message Stops   -n hours after the event.
A precomma arg can change the number of hours in advance the message starts.!

 [0[1[2[T			    !* Temps			!
 48u1 ff&2"n u1 ' q1:\u1	    !* 1: String precomma arg	!
  1u2 ff&1"n u2 '		    !* 2: Postcomma arg		!
 :iT Expiration 		    !* T: guess Expiration	!
 q2"l -q2u2 :iT Stop ' q2:\u2	    !*    Nope, guess was wrong	!
 1,fEvent_date:_u0		    !* 0: Event date/time	!
 m(m.m Set_Start_Date)1_hours_before_0
 m(m.m &_Set_Date)2_hours_after_0
 				    !* Return			!


!Set Start Date:! !C Set the Start Date for this message (Reminder)
Default date is "now". With a negative arg, removes the Start Date!

 :i*Start[T			    !* qT: date type	!
 0,(f):m(m.m&_Set_Date)	    !* Go do it		!


!Set Stop Date:! !C Set the Stop Date for this message.
Default date is "now". With a negative arg, removes the Stop Date!

 :i*Stop[T			    !* qT: date type	!
 0,(f):m(m.m&_Set_Date)	    !* Go do it		!


!& Set Date:! !& Set the start/expiration date,etc for this babyl message
Expects the type of date to be in qT!

 "l0'"#			    !* Dont read string arg if -numarg	!
   1,fT_Date:_'[D		    !* D: date to be inserted		!
 0[0				    !* 0: non-zero if not babyl buffer	!
 f~Buffer_Name*Babyl*"e	    !* If Babyl buffer,...		!
  m(m.m &_Push_Message)	    !*  Restore this message when done	!
  m(m.m &_Bounds_of_Header)fsbound!*  Bind buffer bounds to header	!
 '"# z-.[1			    !* Else, ...   1: saved point	!
     j f[vbw f[vz		    !* Else,...				!
     qBabyl_Header/Text_Separatoru0
     s0 fkc b,.fsbound 	    !* Bind buffer bound to header area	!
     .-(z-q1)"g @fn| j s0 l | '
	     "#  fn  z-q1j    '
     @fn| 0,fsz fsbound |'
 j				    !* Jump to top of that range	!
 "l <:s
T-Date:;0lk-l>  '   !* If negative arg, remove field	!
 fqD:"g :iDnow '		    !* If no text given,		!
				    !*  default to now			!
 qD,m(m.m&_Parse_Date)[D[W	    !* qD: Date, qW: Weekday		!
 "n fsdate:fsfdconv,qDm(m.m&_Compare_Dates):"g
       m(m.m &_Remark)Warning:_The_specified_T-Date,_D,_is_in_the_past.''
 :s
T-Date:"e		    !* Make a field if there is none,	!
      zj q0"e -l ' iT-Date:_
              0:l' "# :k i_ '	    !* Or just modify existing field	!
 qW"n gW i,_ ' gD		    !* Yank date into buffer		!
 j 				    !* Return				!


!Survey Expired Messages:! !C Survey expired messages.
Expired messages are those matching the Expired filter.!

 fm(m.m Survey_Filtered_Messages)Expired


!Survey Reminders:! !C Survey reminders.
Reminders are those messages matching the Reminders filter.!

 fm(m.m Survey_Filtered_Messages)Reminders


!Survey All Messages:! !C Survey all messages.
Works by surveying messages matching the All filter.!

 fm(m.m Survey_Filtered_Messages)All


!Survey Messages Containing String:! !C Survey messages with a given string.
The string is prompted for.
Works by surveying messages matching the Containing-String filter.!

 fm(m.m Survey_Filtered_Messages)Containing-String


!Survey Deleted Messages:! !C Survey messages which have been deleted.
Works by surveying messages matching the Deleted filter.!

 fm(m.m Survey_Filtered_Messages)Deleted


!Survey Undeleted Messages:! !C Survey messages which have not been deleted.
Works by surveying messages matching the Undeleted filter.!

 fm(m.m Survey_Filtered_Messages)Undeleted
 

!Survey Labeled Messages:! !C Surveys messages with a given label.
The label is prompted for.
If no label is given, any message with a user-defined label matches.
Works by surveying messages matching the Labeled filter.!

 fm(m.m Survey_Filtered_Messages)Labeled


!Survey Unlabeled Messages:! !C Survey messages without a given label.
The label is prompted for.
If no label is given, any message with no user-defined labels matches.
Works by surveying messages matching the Unlabeled filter.!

 fm(m.m Survey_Filtered_Messages)Unlabeled


!Survey Seen Messages:! !C Survey seen messages.
Seen messages are those matching the Seen filter.!

 fm(m.m Survey_Filtered_Messages)Seen


!Survey Unseen Messages:! !C Survey unseen messages.
Unseen messages are those matching the Unseen filter.!

 fm(m.m Survey_Filtered_Messages)Unseen


!& Survey Filtered Messages:! !& Surveys messages given by some filter.
Surveys messages which pass a generalized filter. 
Name of macro to drive filter (NOT of filter itself) is string arg.!

 0f[modemac				!* Disable mode line handler	!
					!*  since realtime handlers are	!
					!*  prone to cause URKs we 	!
					!*  couldnt trap		!
 [0[1[2[3[4[5 0[6 0[7			!* Temp q-regs			!
				        !* 6: Number of messages seen	!
				        !* 7: Non-0 if output flushed	!
 fm(m.m&_Survey_Args)u2u1		!* 1,2: Message#,itercount	!
 m.m&_Babyl_Survey_Several_Messagesu3	!* 3: Briefer			!
 m.mu4			        !* 4: Finder			!	
 m.m&_Maybe_Flush_Outputu5		!* 5: Toilet			!
					!*				!
 m(m.m&_Push_Message)			!* Return to . when done	!
 q1m(m.m#_Babyl_J)			!* Move to starting message	!
 0fsVBw -s			        !* Move back a bit so that we	!
				        !*  find the starting msg if it	!
					!*  matches.			!
 qMessage_Number-1uMessage_Number	!* and decrement message number	!
				        !*  so our counter isnt confused!
				        !* Simpler than usual Make Space! 
 m.m&_Quiet_Error_Handler[..P		!* Dont run Make Space here	!
 -1f[noquit				!* Make ^G signal a QIT error	!
 q2:@<1,m4;				!* Find next matching msg if any!
      m5 1u7 1;			!* Stop if user types ahead	!
      q6"e 0m3w ' %6		        !* Maybe print survey label	!
      1,m3w				!* Survey it, no label, and dont!
					!*  kill the rest of the survey	!
      m5 1u7 1;			!* Again stop if typeahead	!
      zj >f"nu1				!* Move to end of message	!
	    q1-(@feQIT)"e fg :i*Abortedf;Babyl-Command-Abort'"#
            ft..._Survey_has_been_flushed_due_to_error.
	      
	    q1-(@fePUR)*(q1-(@feURK))"e
	      ft____No_more_memory.
	      q*Survey*_Bufferf"n[..O
 	        zj -11l
		ft_Making_space_by_
	        ."n ft flushing_10_survey_buffer_lines.
		       l zk '
	         "# ft flushing_text_in_survey_buffer.
		       hk ' 
                22.f? ]..O'w'
	    "# ft____1'
	    ft
	      ' 1u7'
					!*				!
					!* Flusher types out on its own	!
 qFilter_Verbose"n			!* Only if typeout enabled...	!
  q7"e				        !* If not flushed,		!
				        !*  declare we are done.	!
   q6"n ftDone.
'   "# m(m.m &_Filter_Failure)'''
 					!* Return			!


!& Filter Failure:! !S ...!

 :i*[2			    !* 2: String arg !
 qFilter_Default[0
 0fo..QBabyl_Filter-Comment_0f"n[1
  m(m.m &_Remark)No_12.'
 "# m(m.m &_Remark)No_messages_matching_filter_"0"2. !''!'
 


!& Quiet Error Handler:! !& Like & Error Handler, but won't run Make Space!

 :? 
 fserr-(@feQIT)"e       fserrfserrthrow'
 fserr-(@feURK)"e 22.f? fserrfserrthrow'
 fserr-(@fePUR)"e       fserrfserrthrow'
 f:m(m.m &_Error_Handler)


!Sort All Messages By Date:! !C Sort Babyl by date forward.
With a negative argument, sorts by date backward. !

 fsmodified"n			    !* If buffer is modified, query...	!
  m(m.m&_Query)Save_current_state_first?_"n
   @m(m.m #_Babyl_S)''		    !*   Maybe save state		!
 q..O( f[bbind			    !* Bind buffer but remember old	!
       q..O[O			    !* O: Temp buffer			!
     )[..O			    !* Restore (bound) previous buffer	!
 m.m&_Message_Date_as_Sort_Key[D   !* D: Date extractor		!
 m.m&_Parse_Date[P		    !* P: Date parser			!
 :i*Cfsechodisplay
 qBabyl_No_Reformation_Option"n   !* Maybe warn of header reformer	!
  @ft This_may_not_work_well_unless_I_can_reform_some_of_your_message_headers.
      Should_I_do_that_where_necessary?_
  1m(m.m &_Yes_or_No)'"# 1 '(	    !* Remember reply for a sec...	!
 1f[noquit			    !* Bind tty interrupts off		!
 0f[clkmacro			    !* Bind realtime interrupts off	!
 0,fsz fsbound		    !* Widen buffer bounds		!
 )"n				    !* Recall reply to earlier query..	!
  @ftChecking_headers..._
  m.m &_Reform_Header[R	    !* R: Header reformer		!
  j<:s
    ; 1a-1"n mRw '		    !* Check header reformation		!
    0,fsz fsbound > '		    !* Restore buffer bounds		!
 j s .fsvb			    !* Narrow to exclude babyl options	!
 z[Z				    !* Z: Old Z				!
 @ftSorting..._
 1:< "l :'  mD  s$ 	    !* Sort				!
     "l @ftReverse_ ' @ftSort_complete.
   >(				    !* Remember if we erred		!
 0uQ				    !* Q: Flag saying if bug happened	!
 )f"n[0 1uQ ftWarning:_Sort_failed_due_to_error:
	      _0
               '
 qZ-Zf"n:\[0 1uQ ft Warning:_Buffer_changed_size_(by_0)_during_sort.
                     '
 0fsvbw j 2fwf~Babyl_Options"n 1uQ
                 ft Warning:_Babyl_file_in_improper_format_after_search.
		     '
 qQ"n ftThis_behavior_should_not_have_happened._Please_report_it_as_a_bug.
        '
 0fsechoactive
 m(m.m&_Babyl_Select_Message)	    !* Set bounds around found message	!
 m(m.m&_Calculate_Message_Number)  !* Figure out where we ended up.	!
 				    !* Return				!


!& Message Date as Sort Key:! !S ... !

 s
***_EOOH_***		    !* Find end of message header	!
 .,(s
 .):fb
Date::"l 0  '  !* Find Date field			!
 .f[vbw s
 r z-.f[vz	    !* Bind buffer bounds		!
 g( j mP( qO[..O hk ) )		    !* Get parsed form in temp buffer	!
 j fsfdconv			    !* Return key			!


!& Babyl Expunge:! !S Maybe ask about deleting some messages, then expunge.
Expired messages are always prompted about, never deleted behind user's back.
Babyl Survey Before Expunge controls whether the system should even bother
looking for them. -1 means no, 1 means yes, 0 means query.
The filter named Before-Expunge controls which messages are considered for
this scan. The default is to look for messages which are expired but not 
deleted.!

 0 [0				            !* 0: Number of msgs shown	    !
 m(m.m &_Check_For_Expired_Messages)"n	    !* If non-zero, do the check    !
     0u..H				    !* Pretend no typeout	    !
     :i*Cfsechodisplay		    !* Clear echo area		    !
     @ftChecking_for_expired_mail...
     0[Filter_Verbose
        m(m.m Survey_Filtered_Messages)Before-Expunge
      ]Filter_Verbose
     q..H"n
      q*Survey*_Bufferf"n[..O j l .-z"n 1u0 l .-z"n 2u0 '' 
			   ]..O''
     q0"g
       fslisten"e			    !* If no typeahead,...	    !
	ft--The_above_message q0-1"g ft s_have  '"# ft _has  '
	ft _expired--'
       [5				    !* 5: Holds query reply	    !
       0f[helpmac			    !* Handle Help char explicitly  !
       :i*Cfsechodisw		    !* Clear echo area		    !
       @ftEdit_the_survey_(Y,_N,_or_?):_   !* Prompt for input		    !
       < fi:fcu5			    !* Read input		    !
         q5-_"e fg !<! >'		    !* Ignore rubout and space	    !
	 q5-"e Nu5'		    !* Treat rubout like N	    !
	 q5fsechoout			    !* Echo other things	    !
         !"! q5fYN'"l 		    !* If not a Y/N, give help	    !
         :i*Cfsechodis
         !"! @ftNo_message_will_be_deleted_unless_you've_marked_it_with_a_"D".
                Do_you_want_to_edit_the_survey_(Y_or_N):_!''! !<! >'
         0; >				    !* Else exit loop		    !
       q5-N"n 
	 :fo..Q MM_#_Babyl_E"l m.m#_Babyl_Em.v MM_#_Babyl_E'
	 fs^RInit[MM_#_Babyl_E
         -1[Babyl_Survey_Before_Expunge   !*  Avoid recursion	(eg, E or Q)!
         0u..H @m(m.mSurvey_Menu)'	    !* Maybe survey these messages  !
       :i*Cfsechodis		    !* Clear echo area		    !
       q5-N"e @ftNo_action_taken_on_messages_shown._'
       @ftExpunging..._''		    !* Say we are expunging	    !
					    !* Go call real expunger...     !
 fm(m(m.m&_Get_Library_Pointer)BABYLm.m&_Babyl_Expunge)(
 q0"g @ftExpunge_complete.
          0fsechoactive'		    !* If need be, say we are done  !
 )					    !* Return			    !


!& Check For Expired Messages:! !S Returns non-zero if should check!

 qBabyl_Survey_Before_Expunge[F	    !* F: User preference flag	    !
 qF"l 0 '				    !* Not if flag is -1	    !
 0fo..QBabyl_Expiration-Check-Time_Option[T
 fqT"l :iT July_4,_1976  '		    !* A long time ago		    !
 0fo..QBabyl_Expiration-Check-Interval_Option[I
 fqI"l :iI one_day  '			    !* Fairly often		    !
 qT,(:i*I_before_now)m(m.m &_Compare_Dates)"l0'  !* Not yet time ...  !
 qF"e					    !* Maybe query...		    !
   m(m.m&_Query)Check_for_expired_messages?_'
 30:"n :fi:fcfN:"l fiw		    !* Give user 1 sec to say No    !
   m(m.m&_Remark)Not_checking_for_expired_messages. w 0''
 fsdate:fsfdconvm(m.m &_Update_Babyl_Option)Expiration-Check-Time
 -1					    !* If we got this far, do check !


!Read Filter Library:! !C Reads a filter init file. 
The file may be either a normal Filter init or an uncompiled ZMail init.
With a negative argument, loads only new things (doesn't redefine 
existing things)!

 [0[1[2[3[4[5			            !* Temp qreg!
 qFilter_..D[..D			    !* Lispy ..D		!
 f[dfile				    !* Bind default filename	!
 f[bbind				    !* Bind buffer		!
 0m.vAll_Babyl_Filter_Names		    !* Decache			!
 5,fInit_fileu1 et1		    !* 1: Init file name	!
 fsdfileu1
 @ft
    Reading_Lisp_file_1
 e[ fne]				    !* Bind input channels	!
 1:<er@y>"n 0 '			    !* Yank or exit		!

 !*  This was a fun hack, but I guess it really is the sort
     of joke that gets tiring and costs time/space... -kmp

       j :fb-*-"l :fbPackage:"l :@fll .,(fb_;-*-fkc.)x*[0
				  @ft_into_package_0 ]0''
 *!					    !* Heh,heh !


 j <:s
(define-filter;		    !* Find filter form		!
    fkc c .( m(m.m &_Read_One_Filter)
           )j fll >			    !*  and loop seeking more	!
 j <:s
(load; :@fll 1a-"!'!"e 
    .+1,(@fll.-1)x*u1 m(m.mRead_Filter_Library)1'>
 :i4 j
 1:<:s*FILE-FILTER-DAEMONS*;
      .u0 -ful c @fll -4 f~SETQ@:;
      q0j :@fll !"! 1a-'@:;
      c @fl-1u0w :@fll 1a-(@:; c  !* 0: End of expression	!
      <.,q0:fb(;		    !* Find sublists		!
        :@fll .+1,(@fll.-1)fx5	    !* 5: Mail file name	!
      <.,q0:fb(;		    !* Find sublists		!
        :@fll 1au1		    !* 1: command letter	!
       2:@fll @flx2		    !* 2: filter name		!
         @fll :i3 1a-)"n	    !* 3: optional arg		!
         :@fll 1a-"!'!"n omit'   !* Maybe it is omitted	!
	 .+1,(@fll.-1)x3 :i33'!* 3: string plus an alt	!
       :@fll 1a-)"n omit' c
       :i*messages_matching_"2"!''!fo..QBabyl_Filter-Comment_2[0
       @:i4|4@ftChecking_for_0...
            1,m(m.m#_Babyl_#)32f"ew @ft_No_messages
					       '"#:\[0@ft_0_message
						m0-1"n @fts' ]0'
            @ft_processed.
             
       | ]0
       !mit!>
       fq4"g @:i4|0[Filter_Verbose
		  4
		  ]Filter_Verbose|
       et5 fsdfileu5
       q4m.vBabyl_Filter-Daemons_5
       :@fll 1a-)@:; c >>
 "l fqBabyl_Mail_File_Names"g oNoFile''
 :i1 j 1:< :s*OTHER-MAIL-FILE-NAMES*;
            .u0 -ful c @fll -4 f~SETQ@:;
            q0j @f
_	l !"! 1a-'@:;
            c @flu0w 0s"!'!
            <.,q0:fb;
             .,(.,q0fb.-1)x2 :i112
	     > q1uBabyl_Mail_File_Names >
 !NoFile!
 @ft
     0fsechoactive			    !* Say we are done		!
 0					    !* Return			!

!& Read One Filter:! !S ...!

 qFilter_..D[..D			    !* Lispy ..D		!
 g( flx*( f[bbindw ) )			    !* Get temp buffer		!
 j <!Top! 1:<:@fll>:@;			    !* Find start of next form	!
          1a-;"e    k oTop'		    !*  flush comments		!
          1a-:"e    d oTop'		    !*  ignore package prefixes	!
      !"! 2 f=':"e 2d oTop'		    !*  keywords become strings	!
          1af'():"l c oTop'		    !*  ignore quote, parens	!
	  1a-|"e d i" s/| -d i" !''! !*  |...| becomes string	!
		   oTop '
	  1a-"!'!"e @fll oTop'	    !*  pass string as a unit	!
	  fwl>				    !*  hop over atoms		!

 j c 2@:fll 1a"a .,(@fll.)'"# .+1,(@fll.-1)'x*[F    !* F: Filter name	!

 "l 0fo..QBabyl_Filter_F"n  ''	    !* Maybe ignore this	!

 :i*[A					    !* A: Dummy filter arg	!
  @:fll 1a-("e 		            !* If maybe arg		!
   2@:fll 1a-)"n			    !*  and more forms		!
    -fll c @:fll @flxA''		    !* A: Real filter arg	!

 zj r -2@fll 0,1a-"!'!"e		    !* Find filter comment?	!
  .+1,(@fll .-1)x*'"#			    !* Save it or a 0		!
  0'm.vBabyl_Filter-Comment_F

 j <:s(MSG-FITS-FILTER-P_;		    !* Find filter calls	!
    @:fll @flf~A"n oLose '		    !* Current message?		!
    2:@fll !"! 1a-'"e c '		    !* Skip any single quote	!
    g( 1a-"!'!"e .+1,(@fll .-1)'"# 1a"a .,(@fll.)'"# oLose''x*(
       -ful flk i(FILTER-CALL_" !'!))
    i") !'! >				    !* Loop			!

 j <:s#.USER-ID; fkd fsxuname:f6[1 i"1" !''! >

 j <:s(NOT_KEYWORDS)(NULL_KEYWORDS); fkd i(NOT_(LABEL))>

 j <:s(SEARCH-WITH-MSG_; -@flk iSEARCH-TEXT_ >

 j <:s(GET_; @:fll @flf~STATUS"n oLose' -@flk @flk iLABEL
       @:fll 1a-("e oLose '	    	    !* Be afraid of (...) forms	!
       !"! 1a-'"e d '		    	    !* Ignore singlequote	!
       1a-"!'!"n i" !'! @fll i" !'! ' > !* Assure doublequotes	!

 j <:s(MEMQ_; -@flk iLABEL_ 2:@fll @flf~KEYWORDS"n oLose ' @flk
    -@f_	
k 0a-"!'!"n -@fll i" @fll i" !''! '>

 [0[1 0[2				    !* 2: If non-zero, exact match!
 j <:s(MSG-HEADER-ADDRESS-SEARCH(MSG-HEADER-SEARCH; fk+18"n 1u2 '
    :@fll @flf~RECIPIENT"e :i0(TO_CC) '
    "# !"! 1a-'"n oLose ' c flx0 '
    2@:fll @flx1 
    q2"n 1,(fq1-1):g1u1 :i1"1" !''! '
    -ful flk g( q0,q1 m(m.m &_Simplify_ZMAIL_Header_Search) ) >

 j fll r -@fll 1a-("n 1a:"a oLose''	    !* If not list, maybe lose	!
 @flx* m.vBabyl_Filter_F		    !* Accept the filter	!
 					    !* Return buffer contents	!

 !Lose!

 ftFilter_F_failed_to_be_defined.
 
 0					    !* Return 0			!


!& Simplify ZMAIL Header Search:! !S ... !

 f[bbindw				    !* Get temp buffer		!
 g() -d j d				    !* Yank stuff		!
 <1:<:@flk>:@;				    !* Iterate across arg1	!
  i(SEARCH-FIELD_ @fll i_ g() i)>	    !* Flush out text		!
 j 1:< 2fll j i(OR_ zj i) j >
 hfx*					    !* Return			!


!# Babyl @:! !C# Append information about this message to references list.
See m-X Yank References for how to recall this info. !

 ff"n "e :iBabyl_@_Refs '	!* Zero arg means flush refs	!
          :m(m.m Yank_References)'	!* Else yank instead		!
 m(m.m &_Babyl_Message_Descriptor)[0	!* 0: Message descriptor	!
 m.m &_ZBabyl_Append_Refs[A		!* A: Reference appender	!
 qBabyl_@_Refs,q0mAuBabyl_@_Refs	!* Save this msg info away	!
 m(m.m &_Babyl_Message_References)
Included-Msgs:
References:
Included-References:
In-Reply-To:u0
 qBabyl_@_Refs,q0mAuBabyl_@_Refs	!* Also save msg reference info !
 					!* Return			!


!Yank References:! !C Yank references set up by the Babyl @ command.!

 .[P @fn| qP"l fsz+qP j '"# qPj ' |	!* P: Info about target point	!
 :i*References,qBabyl_@_Refs m(m.m &_Babyl_Insert_Refs)
 :iBabyl_@_Refs  
  


!# Babyl K:! !C# Delete message and append to text to be Y(ank)ed.
K kills current message.  nK kills message n.
0K kills current message, but only appends the text of the message.!

 [1[2
 m(m.m&_Push_Message)			!* Will come back here when done!
 ff&1*"e				!* No or 0 argument, select	!
    m(m.m&_Babyl_Select_Message)'	!*  current message		!
 "# m(m.m#_Babyl_J)'			!* Go to message NUMARG		!
 m(m.m&_Add_Basic_Label)deletedw	!* Mark it deleted		!
 "e m(m.m&_Bounds_of_Header)w'	!* Move past header if 0K	!
 .,zx1					!* 1: Killed text of this msg	!
 zj 0a-10"n :i11
'					!* 1: Ensure it ends with CRLF	!
 qBabyl_K_Textu2			!* 2: Old killed text		!
 :iBabyl_K_Text2
1					!* Append to killed text	!

 m(m.m &_Babyl_Message_Descriptor)[0	!* 0: Message descriptor	!
 m.m &_ZBabyl_Append_Refs[A		!* A: Reference appender	!
 qBabyl_K_Msgs,q0mAuBabyl_K_Msgs
 m(m.m &_Babyl_Message_References)
Included-Msgs:u0
 qBabyl_K_Msgs,q0mAuBabyl_K_Msgs	    
 m(m.m &_Babyl_Message_References)
References:
Included-References:
In-Reply-To:u0
 qBabyl_K_Refs,q0mAuBabyl_K_Refs

 


!# Babyl Y:! !C# Yank and reset (empty) text saved by K.
nY yanks into message number n.
0Y or -nY just discards the saved text, in case you mistakenly typed K.!

 [0[1[2
 ff&1"n "g m(m.m#_Babyl_J)'	!* goto message NUMARG!
	    "# :iBabyl_K_Msgs
	       :iBabyl_K_Refs
	       :iBabyl_K_Text ''	!* 0 or -n means just reset.!
 .[P @fn| qP"l fsz+qP j '"# qPj ' |	!* P: Info about target point	!
 .( zj 0a-10"n i
'					!* Ensure CRLF after 1st message.!
    gBabyl_K_Text )j			!* Append Babyl K Text to end of!
					!* this message.!

 m.m&_Babyl_Insert_Refsu0
 :i*Included-Msgs, qBabyl_K_Msgs m0
 :i*References,    qBabyl_K_Refs m0

 :iBabyl_K_Refs		        !* and put null in Babyl K Refs!
 :iBabyl_K_Msgs		        !* and put null in Babyl K Msgs!
 :iBabyl_K_Text			!* and put null in Babyl K Text!
 qMessage_Number:\u0			!* 0: message# as string.!
 :fo..qBabyl_Modified_Messagesu1	!* 1: index of old list/macro.!
 q:..q(%1)u2				!* 2: old list/macro.!
 :i:..q(q1)20m0
					!* Add in our part. (Line count has!
					!* changed).!
 


!& Babyl Insert Refs:! !& ...!
!* Expects P to contain original buffer point !

 [0 [1				!* 0,1: Field name, Field value	!
 qBabyl_Header/Text_Separator[2	!* 2: Header/text thing		!
 fq1:"g zj oFix '			!* Only if non-null field value	!
 j .,(s

2 fkcc .):fb
0::"l .-qP"l -(fsz-qP) uP '
       i0:
 2r '"# 
         s


2 fkcc -@f_	
l
         .-qP"l -(fsz-qP) uP '
         i, ' i
	 g1 
 !Fix!
 f[vbw f[vz				!* Bind buffer bounds		!
 .,(-:s
0"e' c .)f fsbound	!* Narrow bounds		!
 j s: @f
	_l		!* Skip whitespace		!
 fsshposu0				!* 0: Indent level		!
 <l .-z; q0,_i @f_	k>	!* Fix remaining indent		!
 


!& ZBabyl Append Refs:! !& ...!

 [0 [1				!* 0,1: Numargs			!
 fq0:"g  ' fq1:"g  '		!* If no new text, use old	!
 fq0"g :i00, '			!* If old text, append a comma	!
 :i*0
	1				!* Append the two references	!



!& Babyl Message References:! !S ...!

 :i*[4 [0[1[2 .[3 fnq3j		!* Save point		!
 m.m &_ZBabyl_Append_Refs[A		!* A: Reference appender!
 fsvb-1f[vb				!* Widen us a touch...	!
 j s
r fsz-.f[vz			!* Find end of header	!
 bu0 zu1				!* 0,1: B,Z		!
 :i2					!* 2: Null string	!

 j <q0,q1 fsbound
    :s4;
    .fsvbw :s
:"l zj ' "#r' fsz-.fsvz
    q2,(j @f
_	lw .,( zj -@f
_	l 
			    .)x*)m(m.m&_ZBabyl_Append_Refs)u2
   >
 q2


!& Babyl Message Descriptor:! !S ...!

 1:<

 [0[1[2 .[3 fnq3j		    !* Save point.!
 fsvb-1f[vb			    !* Widen us a touch...!
 j s
r .u0			    !* Find end of header.!
 b,q0:fb
Message-Id:"l fb< r .,(fb>.)x* '
 b,q0fb
Date: @f_	l .,(s

 r -@f	_
l.)x1
 b,q0fb
From: @f_	l .,(s

 r -@f	_
l.)x2
 f[bbind i Msg_of_1_from_ .f[vbw
 g2 j :s<"l .,(s>r.)fsbound '
 zj-:s@_at_:"l zj i_@_ fsosteco"e iMIT- ' g(fsmachine:f6) '
 0,fszfsboundw hfx*

 >w :i*			    !* In worst case, return null string !


!& Filter Call:! !& Reads a filter name with defaulting, calls a continuation.
Amazingly hairy arg conventions. See the source.!

!* On entry, qF should contain a prompt string.				!
!* On exit,  qF will contain the filter name prompted for		! 
!* This must be called with :M, so that f's info will be set up right	!
!* Precomma arg is continuation to call (with :M) when done.		!
!* If a postcomma arg is given, it means the filter should be created	!
!*  if it doesn't exist.						!
!* Args to the continuation are passed ON THE PAREN PDL			!
!*									!
!* Warning: Read code carefully before changing pushing/popping of qregs!
!*	    We're doing lots of explicit pops that assume pushing in a	!
!*	    certain order.						!

 [0[1				    !* Temp storage			!
 qFilter_Defaultu0		    !* 0: Default filter name		!
 fq0:"g :i0Filter-1 '		    !* Assure a good default		!
 0fo..QAll_Babyl_Filter_Names"e
  :fo..QBabyl_Filter_   [0
  :fo..QBabyl_Filter_  [1
  q:..Q(0)[2
  f[bbind
  q1-q0/q2<q:..Q(q0)u3 g(13,fq3:g3) q0+q2u0 q1-q0@; i,>
  hfx*( f]bbindw ]2]1]0
      ) m(m.m&_Make_Babyl_Label_Table)m.vAll_Babyl_Filter_Names'
 :f"l				    !* If called from c-R mode,...	!
				    !*  then 1: text prompted for	!
        qAll_Babyl_Filter_Names[CRL_List
	:i*[CRL_Prefix
	fqF< fqF-1:gFf:_	:; 0,fqF-1:gFuF > !* Strip trailing colons!
        m(@:i*|32+16+2+1,m(m.m&_Read_Command_Name)F_(0):_|)u1 '
     "# q0(]1]0 :i*(	    !*  else pop env and get string arg	!
           [0[1         )u1)u0'	    !*       1: string arg		!
 fq1"g q1u0 '			    !* Accept input if non-null		!
 fq1"l oPunt '
 qAll_Babyl_Filter_Namesf"n  [B   !* B: completion structure		!
  0:foB0f"gu0 q:B(q0)u0 ' ]B'  !* If matches, expand		!
 q0m.vFilter_Default		    !* Update defaults			!
 q0( ]1]0			    !* Undo local pushed state		!
   )uF				    !* F: Filter name			!
 ff&1"n
  0fo..QBabyl_Filter_F"e
   m(m.m&_Query)A_filter_named_F_does_not_exist.__Create_it?_"e oPunt '
   m(m.m&_Edit_Filter)''
 ) :m()			    !* Jump to continuation		!
 !Punt! :i*Abortedf;Babyl-Command-Abort
  


!& Compile Lisp Filter to Teco:! !& Compile a filter into Teco 
Expects the filter name to be set up already in qF!


!* Comments about the Lisp to Teco Compiler ...				!
!*									!
!* Useful macros will be available at runtime in certain q-registers	!
!* as shown here. Uses of these registers may appear in compiled code.	!
!*									!
!* qW - Macro to get bounds of Whole message				!
!* qH - Macro to get bounds of Header					!
!* qT - Macro to get bounds of Text					!
!* qL - Macro to get bounds of Label line (in internal format)		!
!* qF - Macro to get bounds of Field (reads string arg of field name)	!
!*									!
!*	Any of the above may return 0 instead of bounds to fail		!
!*									!
!* qA - Macro takes bounds numargs and date stringarg, returns nonzero	!
!*	if date parsed in bounds range is After date numarg		!
!* qB - Like qA, but returns nonzero if Before given date		!
!* qS - Searches bounds given by numarg, returning nonzero if success	!
!* qN - Assumes args are bounds of label area. Returns nonzero iff	!
!*      there are no user labels					!
!*									!
!* Sample intended use ...						!
!*  mWmSfoo			Search whole message for "foo"		!
!*  mFTomSfoo			Search To-field for "foo"		!
!*  mFExpiration-DatemAnow	Search Expiration-Date for past date	!
!*  mFDatemB2-Jun		Search Date for date before June 2	!

 0fo..QBabyl_Filter_F[0	    !* 0: Filter body, if any		!
 fq0"l :i*NSF	No_Such_Filterfserr '
 5fsqvector[B			    !* B: Binding table			!
 ff&2"e			    !* Precomma arg means this is a	!
				    !*  recursive call, so avoid extra	!
				    !*  stack pushing...		!
  m.m &_Compile_Lisp_Expression[C  !* C: Expression compiler		!
  m.m &_Compile_Lisp_Close_Paren[E !* E: End of exp compiler		!
  m.m &_Compile_Lisp_Prompt[P	    !* P: Variable string compiler	!
  m.m &_Compile_Lisp_String[Q	    !* Q: String quotes compiler	!
  m.m &_Compile_Lisp_Optional[O    !* O: Optional string compiler	!
  m.m &_Compile_Lisp_Variable[V    !* V: Variable compiler		!
  m.m &_Compile_Lisp_Whitespace[W  !* W: Whitespace compiler		!
				    !* S: Syntax error macro		!
  @:i*| :i*SYN	Syntax_error_in_filter fserr |[S
  qFilter_..D[..D'		    !* Use lispy syntax for filters	!
 f[bbindw q..O[I		    !* I: Input Buffer			!
 g0 j mC 			    !* Compile whole expression		!



!& Compile Lisp Expression:! !& Compile a Filter Lisp expression into Teco!

 mW				    !* Skip whitespace			!
 0,1a-("n
  @flf~ T   "e :i*1 '
  @flf~ NIL "e :i*0 '
  mS '				    !* Syntax error			!
 c mW				    !* Go into sexp, find first token	!
 .,(@fll .)x*[N 		    !* N: Operator name			!
 :m(m.m &_Compile_Filter_N_Expression)


!& Compile Lisp Whitespace:! !S ... !

 < :@fll 1a-;:@; l > 		    !* Skip over whitespace		!


!& Compile Lisp Close Paren:! !S ...!

  mW 1a-)"n mS ' c		    !* Cross whitespace, err if not )	!


!& Compile Lisp Prompt:! !S ... !

 0,1a-("n oVar ' c mW	    !* If not an expression, give up	!
 .,(@fll .)x*[N			    !* N: Operator name			!
 f~N PROMPT "n mS ' mW		    !* Err if not a PROMPT specform	!
 0,1a:"a mS ' .,(@fll .)xN	    !* N: Dispatch name			!
 :m(m.m &_Compile_Filter_N_Prompt)
 !Var! 
 1a"a .,(@fll.)x*[1		    !* 1: Variable name			!
 q:B(0)-1[2			    !* 2: Pointer to most recent var	!
 <q2@;				    !* Iterate across bound vars	!
  f~:B(q2)1"e q:B(q2+1)'	    !* Return val if one matches	!
  q2-2u2 >'			    !* Decrement our stack index	!
 mS				    !* Else syntax error		!


!& Compile Lisp String:! !S ... !

 :i*( :i*(		    !* Read string arg			    !
 [0[7[8				    !* Bind temp qregs			    !
  )u8 )u7			    !* 7,8: String args			    !
  qI[..O			    !*  Bind buffer to input stream	    !
   mW 1a-"!'!"n mP u0 '	    !*   0: Maybe prompt user		    !
   "# .+1,( @fll .-1 )x0 '	    !*      or take text between quotes	    !
  ]..O				    !*  Unbind buffer			    !
 [1[2[3[4[5[6			    !* Bind more temp qregs		    !
 f[bbind			    !* Bind temp buffer			    !
  g0				    !*  Yank text			    !
  0u1 0u2			    !*  1,2: Number of trailers needed	    !
  0u3 0u4			    !*  3,4: Number of leaders needed	    !
    j <:s"';			    !*  Seek quotes			    !
       0a-"!'!"e %1 '		    !*   Unconditionally increment	    !
       "# q1"g q1-1u1 '"# %3 '' >   !*   But conditionally decrement	    !
    j <:s<>;			    !*  Seek brackets			    !
       0a-<!>!"e %2 '		    !*   Unconditionally increment	    !
       "# q2"g q2-1u2 '"# %4 '' >   !*   But conditionally decrement	    !
    j <:s; 0,1a-"n -d ' :c>!*  Delete spurious c-Qs		    !
    j <:s; r i c >	    !*  Quote any c-]s			    !
    j <:s ; r i c >	    !*  Quote any alts			    !
  :i5 :i6			    !*  5,6: Null string		    !
  q3"g q3,":i5 !'! '		    !*  5: Pre-text quotes		    !
  q4"g q4,<:i6 !>! '		    !*  6: Pre-text brackets		    !
  :i556			    !*  5: q5+q6			    !
  j				    !*  Jump to top of message		    !
  fq5"g i! g5 i! '		    !*  If pre-text, insert it		    !
  i7 zj i8 i	    !*  Yank bounding text		    !
  :i5 :i6			    !*  5,6: Null string		    !
  q1"g !"! q1,':i5 '		    !*  5: Post-text quotes		    !
  q2"g !<! q2,>:i6 '		    !*  6: Post-text brackets		    !
  :i556			    !*  5: q5+q6			    !
  fq5"g i! g5 i! '		    !*  If post-text, insert it		    !
 hfx*				    !* Return result, unwinding stack	    !


!& Compile Lisp Variable:! !S ...!

 f[bbind			    !* Get temp buffer			!
 qI[..O mW			    !* Find start of variable		!
 g(.,(@fll .)x*(]..O))		    !* Pick up the variable		!
 j<.-z; 1a:"a 1a--"n mS '' c>	    !* Assure alphabetic		!
 zj i j i		    !* Insert leader, end with altmode	!
 hfx* 			    !* Return buffer contents		!


!& Compile Lisp Optional:! !S ...!

 qI[..O mW			    !* Skip whitespace			!
 :i*( :i*( :i*(	    !* Read string args			!
 )[2 )[1 )[0			    !* 0,1,2: String args		!
 1a-)"n mQ02'		    !* Arg is present, ignore default	!
       "# @:i*|012|'	    !* Arg not present; use default	!


!& Compile Filter LET Expression:! !S ...!

 mW 0,1a-("n mS ' c		    !* Find binding list		!
 q:B(0)[1 fn q1u:B(0) 		    !* Set up unwind			!
 [1				    !* Get a fresh copy of our pointer	!
 < mW 1a-(@:; c		    !* Exit if not a clause		!
   q1+2u1			    !* Increment stack pointer		!
   qB[..O q1*5-z"g zj 2*5,0i'	    !* Maybe extend table by two words	!
     ]..O			    !*					!
   .,(@fll.)x*u:B(q1-1)		    !* Store variable name		!
   mW mP u:B(q1)		    !* Compile and save value		!
   mW mE >			    !* Pass close paren and whitespace	!
 q1u:B(0)			    !* Make the bindings visible	!
 mE mC( mE )			    !* Compile body and return		!


!& Compile Filter AND Expression:! !& Compiles an AND expression!

 f[bbind			    !* Bind output buffer		!
 i1				    !* Handle trivial case		!
 < qI[..O			    !* Go to Input Buffer		!
   mW 0,1a-)"e c		    !* If a close paren,		!
     ]..O hfx* '		    !*  Clean up and return		!
   g( mC( ]..O if"nw )) i'	    !* Recursively compile and yank	!
 >				    !* Loop				!


!& Compile Filter OR Expression:! !& Compiles an OR expression!

 f[bbind			    !* Bind output buffer		!
 i0				    !* Handle trivial case		!
 < qI[..O			    !* Go to Input Buffer		!
   mW 0,1a-)"e c		    !* If a close paren,		!
     ]..O hfx* '		    !*  Clean up and return		!
   g( mC( ]..O if"ew )) i'	    !* Recursively compile and yank	!
 >				    !* Loop				!


!& Compile Filter NOT Expression:! !& Compiles a NOT expression!

 f[bbind			    !* Bind output buffer		!
 qI[..O				    !* Begin result expression		!
 g( mC( mE ]..O ))		    !* Compile this and check syntax	!
 i"'e				    !* Close output buffer		!
 hfx*				    !* Return				!


!& Compile Filter LABEL Expression:! !& ...!

 mO mLmS,_   , [0 mE		    !* 0: Result			!
 f~0mLmS,_,"n q0 '	    !* Return result if not null label	!
 :i*mLmN"'e			    !* Else return check for any label	!


!& Compile Filter FILTER-CALL Expression:! !& ... !

 m( mQ :i*  )[F		    !* F: Filter name			!
 mE				    !* Assure close paren		!
 1,m(m.m &_Compile_Lisp_Filter_To_Teco)


!& Compile Filter SEARCH Expression:! !S ...!

 mQ mWmS ( mE )		    !* Compile just 1 string arg using mWmS !


!& Compile Filter SEARCH-HEADER Expression:! !S ...!

 mQ mHmS ( mE )		    !* Compile just 1 string arg using mHmS !


!& Compile Filter SEARCH-TEXT Expression:! !S ...!

 mQ mTmS ( mE )		    !* Compile just 1 string arg using mTmS !


!& Compile Filter STRING Prompt:! !& ...!

 1,(m.m&_Read_Line)m(m.m&_Compile_Prompted_Expression)


!& Compile Filter LABEL Prompt:! !& ...!

 m.m&_Prompt_for_Babyl_Labelm(m.m&_Compile_Prompted_Expression)


!& Compile Filter FILTER Prompt:! !& ...!

 m.m&_Prompt_for_Babyl_Filterm(m.m&_Compile_Prompted_Expression)


!& Compile Prompted Expression:! !& ...!

 [0[1[2[3				!* Bind temps			!
 u0 u1				!* 0,1: Bits, Reader		!
 @:i*| q0,m1:_ |u2		!* 2: Modified reader		!
 m( mQ m2 ( mE ))u3			!* 3: String prompted for	!
 fq3"l				        !* If over-rubout,		!
   :i*Aborted f;Babyl-Command-Abort '	!*  then abort			!
 f[bbind				!* Else get temp buffer		!
 .( g3 )j				!* Yank text string		!
 fq3< 1af"!'!:"l i ' c >	!* Hack quoting if needed	!
 hfx*					!* Return			!


!& Compile Filter SEARCH-FIELD Expression:! !& ... !

 f[bbind			    !* Bind output buffer		!
 g(mV mF )			    !* Compile code to locate field	!
 g(mO mS   )		    !* Compile code to search field	!
 hfx*( qI[..O mE )		    !* Return, checking for close paren	!


!& Compile Filter AFTER Expression:! !& ...!

 f:m(m.m &_Compile_Filter_FOLLOWS_Expression)


!& Compile Filter FOLLOWS Expression:! !& ...!

 f[bbind			    !* Bind output buffer		!
 g(mV mF )			    !* Compile code to locate field	!
 g(mO mA  now )		    !* Compile optional time field	!
 hfx*( qI[..O mE )		    !* Return, checking for close paren	!


!& Compile Filter BEFORE Expression:! !& ...!

 f:m(m.m &_Compile_Filter_PRECEDES_Expression)


!& Compile Filter PRECEDES Expression:! !& ... !

 f[bbind			    !* Bind output buffer		!
 g(mV mF )			    !* Compile code to locate field	!
 g(mO mB  now )		    !* Compile optional time field	!
 hfx*( qI[..O mE )		    !* Return, checking for close paren	!


!Edit Filter:! !C Edits a filter!

 1,m(m.m &_Get_Library_Pointer)ZMENU[0    !* Get ZMENU library pointer!
 q0"e m(m.mLoad_Library)ZMENUu0'	    !*  loading it if needed	!
 f:m(q0(]0)m.mEdit_Filter)		    !* Jump to its Edit Filter	!


!& Edit Filter:! !S Internal filter edit entry point!

 1,m(m.m &_Get_Library_Pointer)ZMENU[0    !* Get FMENU library pointer!
 q0"e m(m.mLoad_Library)ZMENUu0'	    !*  loading it if needed	!
 f:m(q0(]0)m.m&_Edit_Filter)		    !* Jump to its & Edit Filter!


!Show Filter:! !C Shows a filter (source and compiled form)!

 :i*Show_Filter[F		    !* F: Prompt			!
 f( m.m&_Show_Filter,:m(m.m &_Filter_Call)


!& Show Filter:! !& ... !

 0fo..QBabyl_Filter_F[0	    !* 0: Contents			!
 fq0"l :i*NSF	No_such_filterfserr'
 f[bbind
 iFilter_F_...
  _
  Lisp_Source:
  g0				    !* Get lisp code			!
 .[0
 i
  Compiled_Teco:
  
 1:< g(m(m.m &_Compile_Lisp_Filter_to_Teco))
   >"n q0,.k i
The_above_Lisp_expression_will_not_compile. '
 i 
  
 ht 				    !* Display and return		!



!& Label Bounds:! !& ...!

 j l .,(:l .)


!& Whole Bounds:! !& ...!

 j s***_EOOH_*** .,z


!& Header Bounds:! !& ...!

 j s***_EOOH_*** .f[vb
 .,(:s
"e h' r.)


!& Text Bounds:! !& ...!

 j s***_EOOH_*** .f[vb
 :s
"e h' c .,z


!& Field Bounds:! !& ...!

 j s***_EOOH_*** .f[vb
 .[0 :s
"e zj' "# r ' .[1 
 q0,q1:fb
:"e0'
 .,( .,q1 :fb
"e q1 '"# r .')


!& Filter Search-P:! !& ...!

 ff&2"e :i*w 0'
 ,:fb


!& Filter After-P:! !& ...!

:i*[D			    !* Read date	!
ff&2"e 0'
fqD:"g fsdate:fsfdconvuD'	    !* Default current	!
,x*,qDm(m.m&_Compare_Dates)"l -1 ' "# 0 '


!& Filter Before-P:! !& ...!

:i*[D			    !* Read date	!
ff&2"e 0'
fqD:"g fsdate:fsfdconvuD'	    !* Default current	!
,x*,qDm(m.m&_Compare_Dates)"g -1 ' "# 0 ' 


!& No User Label-P:! !& ...!

 ff&2"e -1'		    !* This would be wierd, but...	!
 f[vbw f[vz			    !* Bind buffer bounds		!
 ffsboundw j 		    !* Bind buffer bounds		!
 <:fb_; fb, 0,1a-,"n 0  ' c>  !* Find a user label? Return -1	!
 -1				    !* 0 iff no user labels		!


!Survey Filtered Messages:! !C Surveys expired messages !

 :i*Survey_by_Filter[F		    !* F: Prompt			!
 f( m.m&_Continue_Survey_Filtered_Messages,1:m(m.m&_Filter_Call)


!& Prepare to Use Filter:! !S Set up for calling a filter.
qF must have filter name. This binds qX to compiled filter and
qregs A,B,F,H,L,N,S,T,W to utilities for the filter!

 m(m.m&_Compile_Lisp_Filter_to_Teco)[X	    !* X: Compiled filter	!

				            !* Now set up things that   !
					    !*  the compiled filter is	!
					    !*  going to expect to find	!

 m.m&_Whole_Bounds    [W		    !* W: Whole  bounds finder	!
 m.m&_Header_Bounds   [H		    !* H: Header bounds finder	!
 m.m&_Text_Bounds     [T		    !* T: Text   bounds finder	!
 m.m&_Field_Bounds    [F		    !* F: Field  bounds finder	!
 m.m&_Label_Bounds    [L		    !* L: Labels bounds finder	!

 m.m&_Filter_After-P  [A		    !* A: After-P    predicate	!
 m.m&_Filter_Before-P [B		    !* B: Before-P   predicate	!
 m.m&_Filter_Search-P [S		    !* S: Search-P   predicate	!
 m.m&_No_User_Label-P [N		    !* N: No-Label-P predicate	!


!& Continue Survey Filtered Messages:! !S ...!

 m(m.m &_Prepare_to_Use_Filter)    !* Set up magic registers		!
 fm(m.m&_Survey_Filtered_Messages)&_Next_Filtered_Message


!# Babyl #:! !C Maps some action across a set of messages (selected by filter)!

 [C ff&2"n :fcuC'"#	    !* Prefer precomma arg to prompting	!
 :i*Cfsechodisp		    !* Clear echo area			!
 !ver!				    !* Come here to retry		!
 ff&2"n :i*Error_in_execution_stream.f;Babyl-Command-Abort'
 @ftCommand_to_Map:_ fi&177.:fcuC  !* C: Dispatch character		!
 @ftC'
 [1[2[3				    !* 1,2,3: Arg preset temps		!
				    !* OK to bind, but not to assign yet!
				    !* First must handle string args	!
 qC-"e 0f;Babyl-Command-Abort' !* On Rubout, abort quietly		!
 qC-O"e			    !* On O, Output to file		!
  f[dfile
  5,fMap,_filing_tofsdfile
  fsdfilem.vBabyl_O_Filename
  f]dfile
  @:i1| m(m.m #_Babyl_J)w_1,m(m.m #_Babyl_O) | 
  :i2File :i3Filed ok'
 qC-D"e
  @:i1| 0,m(m.m #_Babyl_D)|	    !* Call D (should we just hack label?) !
				    !* The 0, arg is important to keep	   !
				    !*  from doing auto N-after-D	   !
  :i2Delete :i3Deleted ok'
 qC-U"e
  @:i1|   m(m.m #_Babyl_U)|	    !* Call U (should we just hack label?) !
  :i2Undelete :i3Undeleted ok'
 qC-L"e
  ff&2"n :i*'"#
   m(m.m &_Prompt_for_Babyl_Label)Map,_attaching_label:_'[L 
  fqL:"g :i*No_label_specifiedf;Babyl-Command-Abort'
  @:i1| m(m.m #_Babyl_J)w_m(m.mLabel_Message)L |
  :i2Attach_label_"L"_to !''! 
  ]L :i3Labeled ok'
 qC--"e f&2"e fi&177.:fcuC @ftC qC-L"n oops''
  ff&2"n :i*'"#
   m(m.m &_Prompt_for_Babyl_Label)Map,_removing_label:_'[L 
  fqL:"g :i*No_label_specifiedf;Babyl-Command-Abort'
  @:i1| m(m.m #_Babyl_J)w_-m(m.mLabel_Message)L |
  :i2Remove_label_"L"_from !''!
  ]L :i3Unlabeled ok'
 !ops!
 :i*Cfsechodispw @ft_O=Output,_D=Delete,_U=Undelete,_L=Label,_-L=Unlabel
		        over
 !k! :i*2_messages_matching_filter[F
     q1,q3:m(m.m&_Map_Filtered_Messages)


!& Map Filtered Messages:! !S Internal mapping entry point!

 !* Expects qF to be set up correctly with a prompt string	!

 ff&2"e :i*,(:i*No_action_taken)'"#,f"ew:i*OK''( !* Arg setup!
 m.m&_Continue_Map_Filtered_Messages,1:m(m.m&_Filter_Call)


!& Continue Map Filtered Messages:! !S ... !

 m(m.m &_Prepare_to_Use_Filter)    !* Set up magic registers		!
 m.m&_Next_Filtered_Message[0	    !* 0: Finder			!
 qFilter_Verbose[1		    !* 1: Verbose flag			!
 [2				    !* 2: Macro to execute		!
 [3				    !* 3: Descriptor string		!
 0[4				    !* 4: Message count			!
 [5				    !* 5: Temp for message number	!
 @:i*| fg ft **_Failed_**  |[6	    !* 6: Error reporter		!
 qMessage_Number[7		    !* 7: Original message number	!
 0f[vbw 0f[vzw j		    !* Jump to top, Message 0		!
				    !* Upon return, ...			!
				    !*  Restore current pos, redisplay	!
 @fn| j m(m.m&_Calculate_Message_Number)w q7m(m.m#_Babyl_J)w f| 
 0[Message_Number
 <m0; %4			    !* Find next matching message	!
  qMessage_Numberu5
  q1"n ftMessage_ q5:= ft:_ '
  q6[..N q5 m2w ]..N
  q1"n ft3.
         '
 >w q1"n q4"n ftMap_Complete.
                ' "# m(m.m &_Filter_Failure)''
 q4				    !* Return number of messages	!


!# Babyl |:! !C Finds next message matching a given filter!

 :i*Find_using_Filter[F	    !* F: Prompt			!
 f( m.m&_Continue_Find_Filtered_Message,1:m(m.m&_Filter_Call)


!& Continue Find Filtered Message:! !S ...!

 m(m.m &_Prepare_to_Use_Filter)    !* Set up magic registers		!
 m(m.m &_Next_Filtered_Message):"l !* Find it, or...			!
  qFilter_Verbose"n		    !* Unless typeout suppressed,...	!
   m(m.m &_Filter_Failure)_follow'   !*  Complain we lost		!
  0f;Babyl-Command-Abort'	    !*  Abort				!
 				    !* Else return			!


!& Next Filtered Message:! !& Compiled filter is in qX !

 0[0				    !* 0: Number of messages forward	!
 [1 0f[vbw 0f[vz .u1 
    @fn| 0,fszfsboundw q1j |	    !* Save current state of things in	!
				    !*  case search fails		!
 <:s"e  0 '		    !* Exit if failure			!
  %0				    !* Increment count of msgs past	!
  ., (s r .)fsbound		    !* Set bounds			!
  mX:@; zj			    !* Apply test criterion		!
  0,(fsz)fsbound		    !* Bind wide again			!
 >				    !* ...				!
 ]..N ]*w ]*w			    !* Throw away saved state (ugh)	!
 m(m.m&_Babyl_Select_Message)	    !* Set bounds around found message	!
 qMessage_Number+q0uMessage_Number
 -1				    !* Return success			!


!# Babyl ^E:! !C Edit Filter (or with an arg just Show Filter)!

 ff"e @:m(m.m Edit_Filter)'
       "# @:m(m.m Show_Filter)'


!# Babyl ^S:! !C# Survey-prefix.  Also ignores ^S^Q for VT52 lossage etc.
^S^A or ^SA is M-X Survey All Messages
^S^D or ^SD is M-X Survey Deleted Messages
       ^SUD is M-X Survey Undeleted Messages
^S^F or ^SF is M-X Survey Filtered Messages
^S^L or ^SL is M-X Survey Labeled Messages (reads a label)
       ^SUL is M-X Survey Unlabeled Messages (reads a label)
^S^M or ^SM is M-X Survey Messages Containing String (reads a string)
^S^R or ^SR is M-X Survey Reminders
	^SS is M-X Survey Seen Messages
       ^SUS is M-X Survey Unseen Messages
^S^X or ^SX is M-X Survey Expired Messages
^S? shows this description and then reads another character.
To correct for stupid terminals, any number of ^S's followed by a ^Q
	are ignored.  This is for VT52s, H19s, maybe others.!
 [1 0[2					!* 2: 0 if have not prompted.!
 20:"e				!* If no typing from user, prompt.!
    1u2					!* 2: Remember that we prompted.!
    :i*CfsEchoDisplay		!* Clear prompt area.!
    @ftKind_of_survey_(A,D,F,L,M,R,S,X,UD,UL,US,_or_?):_'	!* ...!
 <  2,m.i fi:fcu1			!* 1: Dispatch character.!
    q1-:@; >			!* Exit when not a ^S, thus we!
					!* ignore ^S^S...^S^Q.!
 (q1-177."'e)(q1-"'e)"n '	!* Exit quietly, no-op, if it was a!
					!* rubout or ^Q.!
 q1-32"l q1@u1'			!* 1: Turn ^A to A, etc.!
 q2"n @ft1'			!* Extend the prompt.!
 fsRGETTY"e ft
'					!* New line if printing tty.!
 q1-A"e				!* ^S^A or ^SA.!
    f:m(m.mSurvey_All_Messages)'	!* ...!
 q1-D"e				!* ^S^D or ^SD.!
    f:m(m.mSurvey_Deleted_Messages)'	!* ...!
 q1-F"e
    f@:m(m.mSurvey_Filtered_Messages)'
 q1-L"e				!* ^S^L or ^SL.!
    fm(m.mSurvey_Labeled_Messages) '	!* Null STRARG means it should!
						!* use the reader to get!
						!* label.!
 q1-M"e			        !* ^S^M or ^SM.!
    f@:m(m.mSurvey_Messages_Containing_String)'	!* ...!
 q1-R"e				!* ^S^R or ^SR.!
    f:m(m.mSurvey_Reminders)'	!* ...!
 q1-S"e				!* ^SS (not ^S^S...)!
    f:m(m.mSurvey_Seen_Messages)'	!* ...!
 q1-U"e				!* ^S^U or ^SU.  Another char follows.!
    < q2"e 20:"e			!* If no typing from user, prompt.!
	1u2				!* 2: Remember that we prompted.!
	:i*CfsEchoDisplay		!* Clear prompt area.!
	@ft^SU_(D,L,S):_''		!* ...!
      2,m.i fi:fc@u1		!* 1: Uppercase char.!
      q2"n @ft1'			!* Extend the prompt.!
      q1-D"e f:m(m.mSurvey_Undeleted_Messages)'	!* ^SUD.!
      q1-L"e f:m(m.mSurvey_Unlabeled_Messages)'	!* ^SUL.!
      q1-S"e f:m(m.mSurvey_Unseen_Messages)'	!* ^SUS.!
      1u2 fg @ft
^SU_(D,L,S):_ >'			!* 2: Help and repeat if illegal.!
 q1-X"e			        !* ^S^X or ^SX.!
    f:m(m.mSurvey_Expired_Messages)' !* ...!
 q1-?"e m(m.mDescribe)#_Babyl_^S	!* ? gives help and then!
	  f:m(m.m#_Babyl_^S)'	!* reads another character.!
 fg 					!* Illegal choice.  Complain noisily.!


!# Babyl ^X:! !C# Babyl extended command prefix. Type ^X ? for documentation.!

 qBabyl_^X_Dispatch[D		    !* D: Dispatch table		!
 fi[C qC-4110."e ?uC ' qC&177.uC  !* C: Dispatch char			!
 qC:fcuC @ftC		    !* Output the char			!
 fqD/5-qC"g q:D(qC)f"n [0 f@m0 ''
 qC-?"e 
  ftControl-X_is_a_prefix_for_some_Babyl_extended_commands.
    It_has_these_subcommands:
    
  m.m&_Maybe_Flush[A		    !* A: Cache macro			!
  -1[0 fqD/5<			    !* Iterate over table		!
  q:D(%0)"n mA   ft___
            q0,q:D(q0)m(m.m &_^R_Briefly_Describe)' > '
 fg 


!Edit Babyl Mail Files:! !C Enter recursive edit a list of Babyl mail files.!

 [0 fn 0u..H @v 		    !* 0: Temp				!
 fsqpptr(			    !* Remember this stack location	!
 0[..F				    !* Can't hack buffers/files		!
 f[bbind			    !* Bind temp buffer			!
 f[dfile			    !* Bind Teco filename defaults	!
 fsosteco"e :i*C '"# :i*Z '[C    !* C: Exit char name		!
 :i*(Mail_Files)_c-m-C_on_a_line_with_a_filename_selects_it,_c-]_aborts[..J
 gBabyl_Mail_File_Names
 qBuffer_Filenames[F qF"n[L	    !* F: Current Babyl Filenames	!
  etF fsdfileuF		    !* Assure F is in canonical form	!
  j <@f
	_l .-z;    !* Skip whitespace, stop at end	!
     0l .,(:l.)xL		    !* L: Filename given by current line! 
     etL fsdfileuL		    !* Assure L is in canonical form	!
     f~LF"e !<! 0; > oWin '   !* If F found, skip this stuff	!
    >				    !* Loop				!
  j gF i 
 2r '		    !* If F not found, insert it	!
 !Win! 0l 			    !* Get ready to edit the list	!
 m.m^R_Babyl_Mail_File_Space[_   !* DWIM-ish Space macro		!
 !Retry! 			    !* Edit				!
 hx*uBabyl_Mail_File_Names	    !* Retrieve any changes		!
 0l .,(:l.):fb:"l 0'	    !* If no text on line, ignore	!
 qF f"n fsdfile '		    !* Get back old defaults		!
 0l :x0				    !* 0: Designated filename		!
 et0 fsdfileu0		    !* Assure 0 is in canonical form	!
 qF"n f~0F"e 0 ''		    !* Exit if already visiting it	!
 :i*Cfsechodis		    !* Clear echo area			!
 e?0"n @ftFile_"0"_not_found._Try_again. !''! 0fsechoactivew oRetry'
 qF"n @ftSave_"F"._!''!'	    !* Say if going to write		!
 @ftMove_to_"0"_...!''!	    !* Say what we're up to		!
 )fsqpunwind			    !* Unwind back to original position	!
 q0,(ff&1"n')@m(m.m#_Babyl_I)!* Call the Babyl I command		!
 				    !* Return				!


!^R Babyl Mail File Space:! !^R At head of non-empty line, selects it.
Otherwise, self-inserts.!

 
,0a-
"n f:m(qA) '
 :m(fs^RInit)


!Exit Babyl Temporarily:! !C Temporarily exit Babyl. Same as Babyl ^]!

 f:m(m.m_#_Babyl_^])


!& Prompt for Babyl Label:! !& Returns a valid label or null string!

 0f[modemac			    !* Disable mode line	!
 m(m.m&_Use_Babyl_Label_Table)	    !* Use Babyl label stuff	!
 qCRL_List[B			    !* B: completion structure	!
 :i*[P :i*[1		    !* P: Prompt string		!
				    !* 1: Initial text		!
 6[CRL_Non-match_Method	    !* Allow non-match w/ CR,LF	!
 < 16+2,q1m(m.m&_Read_Command_Name)Pf"e 
     :i*CfsEchoDisplayw 0 'u1 !* Return 0 if abort	!
   fq1"e q1'			    !* Null string is ok	!
   0:foB1f"gu1 q:B(q1)u1 0; '  !* If matches, accept	!
   fg >				    !* Beep and retry		!
 0fo..qBabyl_1_Labelabf"n u1'  !* Maybe expand abbrev	!
 q1				    !* Return label		!


!& Prompt for Babyl Filter:! !& Returns a filter name!

  :i*[F			    !* F: Prompt string		!
  [Filter_Default		    !* Bind default filter name	!
  ( :i*qF,1 @:m(m.m &_Filter_Call)


!ZBabyl Startup:! !C Survey to run at ZBabyl startup time!

 -qMessage_Number+1[1	    !* 1: Number of new messages	!
 q1:\[2				    !* 3: Convert to string format	! 
 q1-1"n :i*s' "# :i* '[3	    !* 2: s if necessary		!
 0[4				    !* 4: Non-zero if first time	!
 0fo..QZBabyl_Init_Loaded"e	    !* If no init loaded...		!
 1u4 1m.vZBabyl_Init_Loaded	    !* It is now...			!
 [0 f[dfile			    !* Bind default filename		!
 fshsnamefsdsname		    !* Default dir is home dir		!
 fsosteco"e
  fsxunamefsdfn1		    !* Default fn1 is user name		!
  f6 ZBABYL fsdfn2'		    !* Default fn2 is ZBABYL		!
 "#
  et ZBABYL-INIT.LISP '	    !* Default is ZBABYL-INIT.LISP	!
 1:<erec>"e fsdfileu0		    !* If that file exists...		!
  m(m.m Read_Filter_Library)0'  !*  Read it				!
 fsosteco"e f6 ZMAIL fsdfn2'	    !* Look for xuname ZMAIL, too	!
          "# et ZMAIL-INIT.LISP '  !*  or ZMAIL-INIT.LISP on Twenex	!
 1:<erec>"e fsdfileu0	    !* If that file exists...		!
  -m(m.m Read_Filter_Library)0''!*  Read it				!
 [..J f[modech			    !* Bind mode line status		!
 m(m.m &_Babyl_Set_Mode_Line)w fr  !* Force a normal Babyl mode line	!

 "n				    !* If new mail, say so		!
  m(m.m &_Remark)2_new_message3.'
 45:"n :fif_:"l fiw ' '    !* Watch for typeahead...		!
 q4"e "e ''			    !* Exit after first time if no mail !
 "n				    !* Iff mail came, process it	!
  qBuffer_Filenames[0 0fo..QBabyl_Filter-Daemons_0f"nu0 m0w' ]0'
 q4"n
  0fo..QBabyl_Filter-Comment_After-Startupf"ew
   :i*recent_mail_and_reminders'[1 @ftSurveying_1... 
				 ]1
  1@:f<!Babyl-Command-Abort! :ft    !* Assure starting on top line	!
       m(m.m Survey_Filtered_Messages)After-Startup>'
 "# @ftSurveying_new_message3...
    1@:f<!Babyl-Command-Abort! :ft
         q1m(m.m Survey_All_Messages)>'
 


!& Update Babyl Option:! !S ...!

 :i*[0			    !* 0: String arg			!
  m.vBabyl_0_Option	    !* Make sure to keep var consistent	!
 0f[vbw 0f[vzw z-.[Z fn z-qZj    !* Remember to come back here	!
 j :s
0:+1"e :k'	    !* Find field or end of options	!
   "# ri0: 
 2r '	    !* If not found, then make room	!
 fq()"e 0:k' "# g()'	    !* Yank (unless null, then kill)	!
