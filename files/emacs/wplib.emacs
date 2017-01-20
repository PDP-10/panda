!* -*-TECO-*- *!

!~Filename~:! !Library of functions and setup commands for "word processing".!
WPLIB

!& Setup WPLIB Library:! !S Set up state (keys etc.) for WPLIB.!
 [0[1				    !* save some regs!
 6 fs :et modew		    !* use connected directory as default!
				    !* when reading filenames!
 @:i*|2fsecholinesw |fsttymacw m(fsttymac)    !* make the echo area!
				    !* 2 lines to allow equal windows!

 :i*HERMESm.vMail reader program  !* Make C-X R call Hermes for mail!
 @:i:.x(M)|f:m(m.aBABYLM& Mail Message)|	    !* use BABYL composing!

 m.m& Babyl Auto Savingu1	    !* set up for autosaving!
				    !* message drafts!
 q1m.vBabyl R Hookw q1m.vBabyl M Hookw

 72uFill Column		    !* ordinary fill column!
 2m.vTags Find File		    !* M-. should read new files into their!
				    !* own buffers!

 !* Taking care of Hook variables to have things local to Text and Scribe!
 @:i0|	65m.lFill Column	    !* adjust fill column!
  m.m^R Down Indented Linem.q..N !* Put Down on M-N, replaces Comment!
  m.m^R Up Indented Linem.q..P  !* Put Up on M-P, replaces Comment!
  1uDisplay Matching Paren |	    !* show parentheses matching!
 0fo..qText Mode Hooku1	    !* find existing hook!
 q1"e q0u1'			    !* if none, just install ours!
   "# @:i1| 01w 1|'	    !* otherwise, glue them together!
 q1m.vText Mode Hookw		    !* install result in hook variable!

 :@i0|				    !* put stuff for our hook in Q0!
  m.m^R Down Indented Linem.q..N !* Put Down on M-N, replaces Comment!
  m.m^R Up Indented Linem.q..P  !* Put Up on M-P, replaces Comment!
  65m.lFill Column|		    !* revise fill column for text!
 0fo..qScribe Mode Hooku1	    !* find any existing hook!
 q1"e q0u1'			    !* if none existing just install ours!
   "# :@i1|01w1|'	    !* otherwise glue them together!
 q1m.vScribe Mode Hookw	    !* install result on hook variable!

 f~ModeScribe"e		    !* if already in Scribe mode, force!
   m(m.m Scribe Mode)w'	    !* the Scribe hook to be run!

 1m(m.mAuto Fill Mode)		    !* default with auto fill!

 1,m(m.mLoad Library)WORDAB	    !* load the word abbrev library!
 -uSave Word Abbrevs		    !* always save new abbrevs on exit!
 1m(m.mWord Abbrev Mode)	    !* always set abbrev mode!
 m(m.mRead Word Abbrev File)	    !* load WORDAB.DEFNS!

 1,m(m.mLoad Library)TMACS	    !* load TMACS for buffer support!
 m.m^R Select Bufferu:.x()	    !* use Buffer Menu on C-X C-B!

 1,m(m.mLoad Library)AUTO-SAVE-MODE	    !* use powerful auto save!
 1uAuto Save Default		    !* auto saving on for each buffer!
 

!& Babyl Auto Saving:! !S Support for autosaving of message drafts.!
etDSK:MESSAGE.BACKUP fsHSnamefsDSnamew
				    !* get DSK:<logindir>MESSAGE.BACKUP!
				    !* as filename!
	fsDFileuBuffer Filenames 1fsModeChw	    !* set buffer filenames!
						    !* so there's something!
						    !* to save under!
	m(m.mAuto Save Mode)w	    !* and turn on auto save mode!
	!* put Subj and CC fields into standard form!
	.[1 j s--Text follows this line-- q1-."g z-q1u1 fnz-q1j'
	"# fnq1j' 0l iCC: i
Subject: i
				    !* force trailing blanks on fields!
  

