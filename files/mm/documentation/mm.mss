@Make(Manual)
@Device(Penguin)
@Font(Helvetica10)
@LibraryFile(MultiLevelIndex)

@Style(DoubleSided yes, WidowAction Force,
	Indentation 0, Spacing 1, Spread 0.75)
@PageHeading()

@Define(KeyDescription, Break, Continue, Above 0.75, Below 0.75, Fill,
		LeftMargin +1.6inch, Indent -1.2inch, Spacing 1, Spread 0)
@Define(SwiDescription, Break, Continue, Above 0.75, Below 0.75, Fill,
		LeftMargin +2.0inch, Indent -1.6inch, Spacing 1, Spread 0)
@Define(ValDescription, Break, Continue, Above 0.75, Below 0.75, Fill,
		LeftMargin +0.8inch, Indent -0.8inch, Spacing 1, Spread 0)
@Modify(Appendix, Numbered [@A.],Referenced [@A],
	TitleForm "@Hd1(@=Appendix @parm(referenced)

	 @=@parm(Title))")
@Modify(Center, Above 0.75,Below 0.75,FaceCode F)
@Modify(Chapter, 
	TitleForm "@Hd1(@=Chapter @parm(referenced)

	 @=@parm(Title))")
@Modify(Description, Above 1.5,Below 1.5,Spread 1.5)
@Modify(Hd1, Above 0,Below 1.5,Capitalized off)
@Modify(Hd2, Above 1.5,Below 0.75)
@Modify(Hd3, Above 0.75,Below 0.75)
@Modify(Hd4, Above 0.75,Below 0)
@Modify(IndexEnv, Columns 2,ColumnMargin 0.5inch,LineWidth 3.0inch,Boxed,
		LeftMargin 0.8inch,Indent -0.8inch)
@Modify(Itemize, Above 0.75,Below 0.75,
		LeftMargin +0.4inch,Indent -0.4inch,RightMargin 0.4inch)
@Modify(PrefaceSection,
	TitleForm "@Hd1(@=@parm(Title))")
@Modify(UnNumbered,
	TitleForm "@Hd1(@=@parm(Title))")

@Begin(TitlePage)
@TitleBox[
@MajorHeading(MM

User's Manual)]
MM version 8140

November 1982
@BlankSpace(10)
@B(Dale S. Russell)

USC Information Sciences Institute
4676 Admiralty Way
Marina del Rey; CA 90291

@NewPage
@>MM version 7400, July 1982
@>MM version 7610, August 1982
@>MM version 8140, November 1982

@End(TitlePage)

@PageHeading(odd,Left="@c[@Title(Chapter)]",Right="@Value[Page]")
@PageHeading(even,Left="@Value<Page>",Right="@c[MM User's Manual]")

@Set(Page 3)
@Style(PageNumbers <@i>)
@UnNumbered(Preface)
MM was originally written by Michael McMahon at SRI International,
presently at Symbolics.
In the summer of 1978, Ted Hess at DEC converted MM to MACRO
and made it use the COMND JSYS.
At this point, MM and the program which later became DEC's MS diverged.
Since the summer of 1979, McMahon and Mark Crispin at Stanford University
have handled a majority of the maintenance and development efforts.
Several contributions have also been made by others too numerous to mention.
This large user base has helped MM mature into a powerful and reliable
mail system.

ISI is one of many sites which became interested in MM.
As it gained wide user acceptance, necessary corrections and useful
enhancements were handled by Craig M. Rogers and Dale S. Russell.
To date, most of the changes made at ISI have been accepted into the
standard version released from Stanford University.
This document was produced to describe MM as it is today,
adapted in part from earlier documents found at SU-SCORE:
@Begin(Itemize)
DOC:MM.DOC; "MM Reference Manual", September 1981.

DOC:MM.INTRODUCTION; "Introduction to MM", October 1981.

DOC:MM.PRIMER; "An MM Primer", September 1981.
@End(Itemize)

This document attempts to serve the needs of a wide range of users,
from the novice to the expert.
Those users not experienced with TOPS-20 will find helpful information
about MM (and a few other utility subsystems)
in "An Introductory Guide to TOPS-20", ISI publication ISI/TM-82-22.

@NewPage(1)
@Style(PageNumbers <@1>)

@Set(Page 0)
@Chapter(Introduction)

MM is an electronic mail management system, providing facilities for
reading and processing incoming messages;
composing, refining and sending outgoing messages;
and classifying, filing and retrieving messages.

This chapter introduces MM with a simple example session showing the
basic facilities for reading, answering, composing and sending messages.
The next three chapters provide basic information about the nature of mail,
and a general overview of MM's structure, appearance, and operation.
The following chapters present detailed command descriptions.
At the end are two appendixes,
one listing all commands and expected arguments,
and the other presenting a sample MM.INIT file.

@Section(Terminal Conventions)
Throughout this document, example terminal snapshots
will indicate user input with @U(underlined text), and
certain terminal keys will be shown by the abbreviations listed below
(sometimes within square brackets for clarity):
@Begin(KeyDescription, Spread 0.75)
 CTRL/x@\means to press the key "x" while holding down the key
  labeled CTRL or CNTL.

 DEL@\means to press the key labeled DEL or RUBOUT;
  depending on the terminal, you may also need to hold down the Shift key.

 ESC@\means to press the key labeled ESC or ESCAPE.

 RETURN@\means to press the key labeled RETURN or ENTER.
@End(KeyDescription)

@Section(A Sample Session in MM)
The following example session demonstrates the basic commands which allow
you to read and respond to incoming mail, and compose and send mail;
and illustrates how recognition may or may not be used in command input,
depending upon your desire to see the full command and/or be prompted for
the next argument:
@Begin(Verbatim, Above 0.75,Below 0.75)
@@@U(MM [RETURN])
 MM Version 4(17714)-3, Edit 8140
N       2) 18-Jun Unsuram Berthold     Flour shortage - NO crumpets (254)

 Last read: 18-Jun-82 11:04:18, 2 messages (1 old), 1 page
MM>@UX(H A[RETURN])
        1) 17-Jun T B Purser           Annual report (17937)
N       2) 18-Jun Unsuram Berthold     Flour shortage - NO crumpets (254)
MM>@U(READ[ESC]) (msgs) @U([RETURN])

 #2 N (247)
Date: 18 Jun 1982 1106-PDT
Subject: Flour shortage - NO crumpets
From: Unsuram Berthold <CourtBaker at Witherhold>
To: MJRoyalty

We are suffering from a shortage of flour.  There will be no
crumpets with tea until further notice.
-------
R>@U(R[ESC])EPLY (TO) @U(/SENDER[RETURN])
 Message (ESCAPE to MM command level, ^Z to send):
@UX(Dispatch a page to the mills at once!  This is an outrage!!
[ESC])
S>@U(DIS[ESC])PLAY (MESSAGE FIELD) @U([RETURN])
Date: 18 Jun 1982 1107-PDT
Subject: Re: Flour shortage - NO crumpets
From: His Royal Highness <MJRoyalty@@Witherhold>
To: CourtBaker
In-Reply-To: Your message of 18 Jun 1982 1106-PDT

Dispatch a page to the mills at once!  This is an outrage!!
-------
S>@UX(CC .)@U([RETURN])
S>@U(SEND [RETURN])
 CourtBaker -- ok
 MJRoyalty -- ok
 There is 1 additional message
N       3) 18-Jun To: CourtBaker       Re: Flour shortage - NO crumpe (246)
 Currently at message 2.
R>@U([RETURN])

 #3 N (277)
Date: 18 Jun 1982 1108-PDT
Subject: Re: Flour shortage - NO crumpets
From: His Royal Highness <MJRoyalty@@Witherhold>
To: CourtBaker
cc: MJRoyalty
In-Reply-To: Your message of 18 Jun 1982 1106-PDT

Dispatch a page to the mills at once!  This is an outrage!!
-------
R>@U([RETURN])
MM>@U(S[ESC])END (message to) @U([RETURN])
 To: @U(ADTrusty [RETURN])
 cc: @U(LYQueen [RETURN])
 Subject: @UX(Unfortunate circumstances)@U([RETURN])
 Message (ESCAPE to MM command level, ^Z to send):
@UX(Our kingdom is in disorder -- we cannot even get together a proper
tea.  Summon the appropriate persons to witness our abdication.
CTRL/Z)
 ADTrusty -- ok
 LYQueen -- ok
 There is 1 additional message
N       4) 18-Jun To: ADTrusty         Unfortunate circumstances (260)
 Currently at message 3.
MM>@U(QUIT [RETURN])
@@@UX(;sigh, my kingdom for a crumpet...)
@End(Verbatim)

@Chapter(The Basics)

This chapter provides basic information about messages and mail files,
and a general overview of MM's facilities and operation.

@Section(A Message)
A message consists of lines of text, usually taking the appearance of a memo.
@Index(Message header)
The first several lines make up the message header,
providing such information as who sent the message, when, who received it,
what it's about, etc.
These lines are expected to observe the format:
@Center[field-name@ :@ field-body]
Each field-name must begin on the left margin, and identifies the type
of information the field-body describes.  A colon separates these two,
and may be preceded and/or followed by any number of spaces or tabs.
Should the field-body be too large to fit on one line, it may continue
on as many succeeding lines as necessary,
each indented with at least one space or tab.
A blank line marks the end of the message header, with the message
text beginning with the next line.
@Index(Message text)
The message text is not expected to conform to any format,
and may be omitted if all necessary information can be placed
in the message header.

Detailed information about messages headers may be found in RFC 822,
entitled "Standard for the Format of ARPA Internet Text Messages".

@Section(A Mail File)
A mail file holds a collection of messages.
The standard TOPS-20 mail file which receives incoming mail is named
MAIL.TXT.1, and is addressed by the name of the directory in which it resides.
Additional mail files may be created to assist in organizing messages,
moving them from MAIL.TXT.1 as appropriate.
A mail file is an ASCII text file with a simple (but strict) format.
Before each message is a leader-line:
@Index(leader-line)
@Center[dd-mmm-yy hh:mm:ss-zzz,size;bbbbbbbbbbbb]
showing the date and time the message was appended to the mail file;
the decimal count of characters (excluding the leader-line);
and the message flag bits,
represented by a twelve digit octal number
(36 bits numbered 0 to 35, left to right).
There is no universal agreement between the various mail handling programs
as to the use of the bits;
MM uses them as follows:
@Begin(KeyDescription, Spread 0.75)
@Index(Message flag bits)
@Index(Keyflags)
 B0:29@\are keyflags; named according to the value of the variable KEYWORDS.
  You may set them for purposes of classification.

 B30:31@\are reserved for future MM definition.

@Index(ANSWER bit)
 B32@\is the ANSWER bit.
  It is set to show the message has been responded to.

@Index(FLAG bit)
 B33@\is the FLAG bit.
  You may set it to call attention to the message,
  possibly as a reminder for some future action.

@Index(DELETE bit)
 B34@\is the DELETE bit.
  It is set to show the message has been deleted.
  Deleted messages are not removed from the mail file until the command
  EXPUNGE or EXIT is given.

@Index(SEEN bit)
 B35@\is the SEEN bit.
  It is set to show the message has been seen.
@End(KeyDescription)

Messages are logically numbered by their order within the mail file.
Whenever the mail file changes, as with the removal of deleted messages,
any given message may assume a new logical number which corresponds
with its new order within the mail file.

@Section(MM Concepts)

@Subsection(User tailoring)
@Label(VarFil)
@IndexSecondary(Primary="Variables",Secondary="")
There are a number of internal variables which you may modify to tailor
MM's behavior to your personal preferences.
When MM is first started, it takes the values recorded in the text file
MM.INIT in your login directory.
This file may be initially created with the PROFILE command, and
later refined with commands SET and CREATE-INIT.
You may also make changes to this file with your favorite editor.
Values may be declared for a specific mail file foo.TXT by
recording them in foo.MM-INIT.
Whenever you instruct MM to read foo.TXT,
it re-initializes accordingly.
Chapter @Ref"VarDef" lists the variables you may modify,
their function and their default value.

@Subsection(Editor selection)
@Label(EdtSel)
MM provides simple editing facilities for entering the message text;
see the descriptions of CTRL/R, CTRL/U, CTRL/V, CTRL/W and DEL
in section @Ref(CmdEnt).
For tasks beyond the scope of these facilities, or if you simply prefer
using your editor of choice, you may instruct MM to transfer control
to the editor specified by the logical name EDITOR:.
Normally, the editor of choice is EMACS,
which interfaces very well with MM through shared memory.
Other editors may be used,
but the text must often be passed back and forth through temporary files.

@Subsection(String matching)
MM uses two algorithms for matching strings,
both of which ignore the case of the alphabetic characters.
The first employs substring matching, and has no wild-cards.
In substring matching,
given a message line L of length m, and a test pattern P of length q,
there is no possibility of a match if m is less than q.
Otherwise, there are m-q+1 substrings of L which might match, where the
n'th substring begins with the n'th character of L.
The line matches if any one substring equals the test pattern.
This method is used by the message-sequences FROM, SUBJECT, TEXT and TO.

@Index(Wild-card strings)
@Label(WldCrd)
The second requires complete matching, and has the following wild-cards:
@ValDescription[
@>*@ @ @ @ @\matches any number of characters (including none)

@>%@ @ @ @ @\matches any one character
]
A given phrase matches if and only if every character is covered
by the test pattern.
This method is used by the command TYPE, when it tries to recognize field
names specified by the variables DONT-TYPE-HEADERS and ONLY-TYPE-HEADERS;
and the command REMOVE, when it tries to recognize mailbox names.

@Subsection(Current message)
@Index(Current Message)
In general, the last message involved in the previous command is known
as the "current message".
In the case of reading a mail file, the current message is set to
the last message received prior to the read date of the mail file.
If you are unsure which is the current message, type @UX"HEADERS CURRENT".

@Subsection(Header-line)
@Label(HdrLin)
@Index(header-line)
The header-line, output by HEADERS,
is a tailored, single line summary of a given message:
@Center[fffff@ nnn)@ dd-mmm@ from@ {keyflags}@ subject@ (size)]
showing flags, the message number, the day and month of composition,
the author (the recipients if yourself), any keyflags,
the subject, and the character count.
The flags (listed in order of appearance):
@Begin(KeyDescription, Spread 0.75)
 N or R@\if the message is new or recent, respectively;
  see the description of message-sequences NEW and RECENT.

 U@\if the message SEEN bit is clear.

 F@\if the message FLAG bit is set.

 A@\if the message ANSWER bit is set.

 D@\if the message DELETE bit is set.
@End(KeyDescription)
are shown as a space if the stated condition is false.
The from, keyflags, and subject fields are truncated as necessary,
so that the header-line fits within the current terminal width.

@Subsection(Prefix-line)
@Label(PfxLin)
The prefix-line (a reformatted, mini header-line)
appears before each message output:
@Center[#nnn@ fffff@ {keyflags}@ (size)]
showing the message number, any flags, any keyflags,
and the character count.
The flags are shown without place holding;
nothing is shown if the condition is false.

@Section(MM Operation)

@Subsection(Starting up)
You generally enter MM from the EXEC, by typing @U"MM [RETURN]".
MM then does a number of things before you may issue commands.
First, it initializes to your preferences (as described in section
@Ref"VarFil").
Next, it attempts to GET MAIL.TXT.1 from the login or connected directory,
as directed by the variable GET-CONNECTED-DIRECTORY;
and shows header-lines for all recent messages
(those messages received since the last read of the mail file).
It also shows header-lines for messages whose FLAG bit is set,
if the variable FLAGGED-MESSAGES-AUTOTYPE-SUPPRESS is zero.
Then it TAKEs the file MM.CMD (from your login directory), if it exists.
Finally, it puts you at top-level command, ready for your instructions.

MM may also be started with an initial command
by typing @UX"MM command argument(s) [RETURN]".
There is no command recognition at this point, so you must type enough
to uniquely specify your intensions.

@Subsection(Command levels)
MM has four different levels of command entry, each identified by a unique
prompt (which you may change).  The levels and prompts are
listed below, and described in detail in following chapters.
@Begin(KeyDescription, Spread 0.75)
 MM>@\Top-level is the initial and main command level.
  All of MM's power is available through several commands here.
  The prompt is defined by the variable TOP-LEVEL-PROMPT.

 R>@\READ-mode is a special environment where attention is focused
  on a single message at a time.
  It is entered from top-level by the command READ.
  The prompt is defined by the variable READ-PROMPT.

 S>@\SEND-mode is the special environment where outgoing messages
  are composed, refined and sent.
  It is entered from top-level or READ-mode by the command SEND.
  The prompt is defined by the variable SEND-PROMPT.

 M>@\Message sequence command level is where multi-line message sequence
  selectors may be input.
  It is entered by typing a comma and RETURN, before any selectors,
  anywhere a message-sequence is expected.
  The prompt is defined by the variable MESSAGE-SEQUENCE-PROMPT.
@End(KeyDescription)

@Subsection(Command entry)
@Label(CmdEnt)
MM uses the same mechanism as the TOPS-20 command interpreter (EXEC) for
parsing commands, the COMND JSYS.
You may type just enough to uniquely recognize commands and arguments,
or use ESC to have the system complete the partial input
and prompt for the next input.
The following control characters have special functions:
@Begin(KeyDescription, Spread 0.75)
 ESC@\attempts to recognize the partial input.
  If the input is ambiguous, the terminal beeps, signaling a need for
  more input.  Otherwise, the input is completed, and you are
  prompted for the next field with "(noise)".

 CTRL/F@\behaves like ESC, except there is no noise word prompt.

 CTRL/R@\retypes the current line of input.

 CTRL/U@\deletes the line of input from the cursor to the prompt
  (or left margin).

 CTRL/V@\causes the next character to be taken as normal text,
  bypassing any special function it may otherwise have
  (like the characters listed here).

 CTRL/W@\deletes the last word input.

 DEL@\deletes the last character input.

 RETURN@\confirms the current line of input, initiating command execution.
@End(KeyDescription)

MM also supports command input from a file.
If a particular command sequence is likely to be used often, it may be
placed in a text file and read as command input with the command TAKE.
MM closes the file and resumes command input from the terminal with the
first occurrence of one of the following conditions:
end of file, command error, an ALIAS command,
or a TAKE command without an argument.
MM will signal this by typing a line such as "[End of STANDARD.CMD]",
unless the last line of the file gives a TAKE command with no argument.

@Subsection(Date entry)
@Label(DatEnt)
There are a number of message-sequence selectors which take a date argument.
The following responses are valid:
@Begin(KeyDescription, Spread 0.75)
date@\any reasonable string giving the year, month, and day of month;
  for example, July 4, 1982; 4-Jul-82; 7/4/82.

time@\any reasonable string giving time of day

date&time@\both date and time

keyword@\the name of a weekday, or holiday, or one of the following:
 FIRST, LAST, TODAY, YESTERDAY

-n@\n days in the past

#m@\the receive date&time of message number m

.@\the receive date&time of the current message

%@\the receive date&time of the last message
@End(KeyDescription)
The beginning of the day (00:00:00) will be assumed if the time is not given.

@Subsection(Panic aborts)
The following control characters provide the means for stopping
command execution.
@Begin(KeyDescription, Spread 0.75)
 CTRL/O@\stops output to the terminal, but allows the command to continue
  execution until completion (or aborted).

 CTRL/N@\aborts command execution (and thus any terminal output),
  as governed by the variable CONTROL-N-ABORT,
  returning control to current command level.
  You may need to type it several times.

 CTRL/C@\interrupts MM execution, returning control to the superior fork.
  If MM is continued, command execution will continue from the point
  of interruption.
@End(KeyDescription)

@Subsection(On-line help facilities)
There are two basic ways of receiving on-line help.  During command entry,
typing a question mark will show a list of alternative commands at that
point, or a helpful message describing the type of input expected.
Secondly, typing HELP followed by a command name or topic will show
a short description, similar to what is shown in this document.

@Section(Command Description Conventions)
Most MM commands require an argument (or qualifier).
An expression will follow the command name to show the type
of argument(s) that should/may be entered with the command.
The argument is required if the expression is within parentheses,
or optional if the expression is within square brackets.
Many arguments assume a default value if omitted during command entry.
Default values (if any) are shown at the end of the expression inside
square brackets.
The expressions used are:
@Begin(KeyDescription, Spread 0.75)
 (address-list)@\One or more mail addresses; see section @Ref"AdrEnt".

 (date)@\A date specifier (excluding time); see section @Ref"DatEnt".

 (field)@\Some part of a message.

 (file-list)@\A list of file specifications.

 (filename)@\The name field of a file specification;
  MAIL is the filename of MAIL.TXT.1.

 (file-spec)@\A new or old file specification.

 (keyflag)@\Any of the keyflags defined by variable KEYWORDS.

 (keys)@\Either keyflag(s) or keyword(s)

 (keyword)@\Words which are to match entries in the message header
  field "Keywords:".

 (message-sequence)@\A message selector, as described in chapter @Ref"MsgSeq".

 (number)@\A decimal number.

 (octal)@\An octal number.

 (old-file)@\The file specification of an existing file.

 (switch)@\A command atom, with the appearance /SWITCH, or /SWITCH:value.

 (text)@\A character, a word, a phrase, a pattern, etc.

 (topic)@\A command name or subject.

 (user-name)@\A valid user name (both upper case and lower case letters
  may be used).

 (variable)@\One of MM's defined internal variables; see chapter
  @Ref"VarDef".

 (value)@\An appropriate value for a given variable.
@End(KeyDescription)

@Chapter(Processing Outgoing Messages)

Outgoing messages are basically handled in SEND-mode,
though the prompting for various message fields will depend upon
the command initiating message output.
If an address-list was not entered with the command, it will be prompted
for with "To:" and "cc:", and possibly "Bcc:" if the variable
PROMPT-FOR-BCC is non-zero.
If a subject is needed, it will be prompted for with "Subject:".
Then you will enter the message text.
The character you use to terminate message text entry determines whether
the message is then sent, or you enter SEND-mode command level where
refinements may be made to the message being composed.

@Section(Address Entry)
@Label(AdrEnt)
@Index(Addresses)
An address must provide delivery information,
and may identify the recipient.
A complete machine-usable address specifies both the mailbox name and
the site (computer) at which it is located, written as @UX"name@@site".
An earlier form, @UX"name at site", is also recognized when input,
but will not be used in outgoing mail.
Local mailbox addresses may be entered as @UX"name@@" or @UX"name".
To send a message to a local file, type: @UX"*file-spec".

While this form is sufficient to tell the mail system where to send a
given message, it hides the identify of the people who receive it
whenever the machine-usable name has no obvious (or unique) connection
with the personal name(s).
This information may be included as comments (as many as desired),
written as @UX"(comment phrase)".
Also, if the machine-usable address is enclosed in angle brackets,
@UX"<name@@site>", then all characters outside the angle brackets are taken
as a comment, with or without parentheses.

The machine-usable address is derived from analysis of the lexical
symbols of the full address string.
Comments are viewed as a single space, and each occurrence of white space
is reduced to a single space.
Spaces are removed if they immediately precede or follow the @@,
or any period.
Strings enclosed within double quotes are treated as a single word,
and are exempt from reduction.
The following addresses are equivalent:
@Begin(Verbatim, LeftMargin +0.4inch,Above 0.75,Below 0.75)
Dale S. Russell <Dale@@USC-ISIB>
Dale@@USC-ISIB (Dale S. Russell)
Dale (aka Red) Russell <Dale@@USC-ISIB>
(the red headed) Dale @@ USC-ISIB
@End(Verbatim)

An address-list may consist of none, one, or several (with a comma
between each) addresses.
When entering several addresses common to one site, you may type:
@Begin(Verbatim, LeftMargin +0.4inch,Above 0.75,Below 0.75)
@UX"@@siteDefault,name1, name2@@, name3, name4@@site4, ..., nameZ"
@End(Verbatim)
The default site "siteDefault" is applied to each address entered
only as @UX"name", and remains in force until a new default is specified
or the entry is confirmed with a [RETURN].
In the example above, name2 is a local mailbox, name4 is at site4, and
the rest are at siteDefault.

Some address-lists are best shown in the outgoing message by a group-name,
rather than each individual address.
These group lists may be entered by typing:
@Begin(Verbatim, LeftMargin +0.4inch,Above 0.75,Below 0.75)
@UX"group-name: name1@@site1, ..., nameZ@@siteZ;"
@End(Verbatim)
This helps keep the message size reasonable when there are numerous
recipients, such as a staff list for a company.

Some address-lists are quite large or are often used.
They may be placed in a text file and read in as an indirect file,
by typing @U"@@file-spec [RETURN]".

@Subsection(Name strings)
As a convenience, MM transforms a name consisting of a single period
into your own, whether or not the given site is the local system.
You may use this either during command entry, or when editing the header
of an outgoing message.

@Subsection(Site strings)
Every site has one official name, and possibly one or more nicknames.
At present, these names are a single word, or multiple words joined by hyphens.
During initialization, MM builds a table of all known official
names and nicknames to allow recognition during command entry.
You may use any valid name during command entry, but MM
uses the official name in outgoing mail.
This helps to insure that replies can be generated at remote sites which
may not know your pet nicknames, but do know the official name.

In the near future, site names will be known as domain names,
taking the format "site.network", where site may also consist of multiple
words separated by periods (no spaces are allowed).
Thus, USC-ISIB would become USC-ISIB.ARPANET, and maybe B.USC-ISI.ARPANET.
At this time, MM will recognize domain names, but will not use them
in outgoing messages.

@Index(domain literal)
Sites may also be specified by their Internet address,
by typing @UX"[w.x.y.z]".
This is a domain literal; four decimal numbers representing the four
address octets, separated by periods, and enclosed within square brackets.
MM will always use the site name in preference to the domain literal
when known.

@Section(Message Text Entry)
@Index(Message text entry)
@Label(TxtEnt)
Message text entry is handled either by MM or the editor selected by the
logical name EDITOR: (see section @Ref(EdtSel)),
as directed by the variable USE-EDITOR-AUTOMATICALLY.
If the variable is non-zero, you enter the editor to input the message text,
returning to SEND-mode when you have completed it.
If the variable is zero (the usual case), you input the message text
through MM, after one of the following prompts:
@Begin(Itemize)
Message (^Z to MM command level, ESCAPE to send)

Message (end with ESCAPE or ^Z)

Message (ESCAPE to MM command level, ^Z to send)
@End(Itemize)
The prompt (determined by the value of ESCAPE-AUTOMATIC-SENDS)
reminds you of the action of ESC and CTRL/Z.
During message text entry,
the following control characters have special functions:
@Begin(KeyDescription, Spread 0.75)
CTRL/B@\asks for a file name, and inserts its contents at the point
 you are currently typing.  You may continue typing after the file
 has been read in.

CTRL/E@\transfers control to the editor, as directed by the variable
 CONTROL-E-EDITOR, passing it all existing text.

CTRL/K@\retypes the message text entered so far.

CTRL/R@\retypes the current line of input.

CTRL/U@\deletes the line of input from the cursor to the prompt
  (or left margin).

CTRL/V@\causes the next character to be taken as normal text,
 bypassing any special function it may otherwise have
 (like the characters listed here).

CTRL/W@\deletes the last word input.

DEL@\deletes the last character input.

CTRL/Z@\terminates message text input,
 then sends the message if ESCAPE-AUTOMATIC-SEND is negative,
 otherwise it returns to SEND-mode.

ESC@\terminates message text input,
 then sends the message if ESCAPE-AUTOMATIC-SEND is positive,
 otherwise it returns to SEND-mode.
@End(KeyDescription)
If your initial termination of the message text returns to SEND-mode
to allow refinements, then all subsequent text terminations (of that
specific outgoing message) will do the same, whether ESC or CTRL/Z.
To send the message, you will have to use the SEND command.

@Section(Default Field Settings)
There are two header fields MM will always set in outgoing messages.
The "Date:" field will show the date and time message delivery begins.
The "From:" field will identify who wrote the message, usually yourself,
shown in the style directed by the variable RFC-733.
You may set the value of this field to another address with the command FROM,
in which case, MM will show you as the "Sender:".

You may elect to have MM automatically fill in other fields for each
outgoing message, which may be subsequently refined in SEND-mode.
See the variables DEFAULT-BCC-LIST, DEFAULT-CC-LIST, DEFAULT-FROM,
DEFAULT-FCC, DEFAULT-REPLY-TO, HEADER-OPTIONS and SAVED-MESSAGES-FILE.

@Subsection(Default "Date:")
The "Date:" field of all outgoing messages is automatically set by MM
to the date and time that delivery is initiated.

@Subsection(Default "From:")
If you elect not to set the value of DEFAULT-FROM; then MM will compose
one of two strings, depending upon the value of RFC733-STYLE-HEADERS:
@ValDescription[
@>0@ @ @\address (personal name); "Doe@@SITE (John Q. Doe)"

@>-1@ @ @\personal name <address>; John Q. Doe <Doe@@SITE>"
]
If you have not set the variable PERSONAL-NAME, MM acquires it via FINGER.

@Subsection(Default "Sender:")
If you set the "From:" field of an outgoing message so that your mailbox
name is not identified, MM automatically includes the "Sender:" field
which identifies you as the sending agent.

@Section(Mail Delivery)
MM always queues remote mail in the file [--NETWORK-MAIL--]..-1,
which will be delivered by the background system mailer.
This queue file is placed in your login directory to allow you to
initiate delivery with the command NET-MAIL, and observe the actual
delivery to the remote mailboxes.
For local mail, an attempt is made to directly append to the mailbox,
and if that fails, it also is queued.

A special mailbox may be specified by the variable SAVED-MESSAGES-FILE,
which receives a copy of each outgoing message with a full-blown
header, showing addresses normally hidden from view:
group member addresses, and file addresses.

If the variable MAIL-COPY-FILE specifies a file, then a complete copy
of each outgoing message is written to a new version of it.
This provides a useful backup, and may be used to send the same message
to multiple recipients under separate cover.
This file is appropriate input for the RESTORE-DRAFT command.

@Subsection("Bcc:" recipients)
@Index(Blind carbon-copies)
The message copy sent to blind carbon-copy recipients identifies them
in the "Bcc:" header field.
They are not identified in
the message copy received by "To:" and "cc:" recipients.

@Subsection("Fcc:" recipients)
@Index(File carbon-copies)
The message copy sent to file carbon-copy recipients has a full-blown
header; all addresses are shown, including those which are normally
hidden: group member addresses, and file addresses.

@Chapter(Processing Incoming Messages)
Incoming messages may be handled either at top-level or in READ-mode.
Several messages may be dealt with at one time at top-level,
while in READ-mode, attention is focused on one message at any given time.
READ-mode does, however, relax restrictions on doing things with
deleted messages.

@Section(Viewing)
There are several commands for viewing messages, or portions there of.
HEADERS shows an index of header-lines (described in section @Ref"HdrLin")
of selected message(s) on the terminal.
TYPE and LITERAL-TYPE show selected message(s) on the terminal,
and LIST, FILE-LIST and XPRESS print them;
remember that a prefix-line (see section @Ref"PfxLin")
appears before each message.

The output of TYPE is subject to the values of DONT-TYPE-HEADERS and
ONLY-TYPE-HEADERS, which identify header fields not to, or only to show.
These variables take string arguments (commas separate multiple strings),
which may use the wild-cards described in section @Ref"WldCrd".
If there are no arguments for these variables, then TYPE behaves like
LITERAL-TYPE, which shows the entire message.

The variables LIST-INCLUDE-HEADERS and LIST-ON-SEPARATE-PAGES
determine whether or not LIST, FILE-LIST and XPRESS:
1) print an index of header-lines before the messages; and
2) print each message on a separate page.
LIST prints to the device specified by the variable LIST-DEVICE;
FILE-LIST prints to the device specified in the command entry; and
XPRESS prints to the device PNG:.

@Section(Answering)
@Label(AnsMsg)
To respond to a given message use the command ANSWER or REPLY.
MM presets the subject to "Re: original-subject"
(care is taken not to duplicate "Re:"),
and discovers the automatic receivers list(s):
REPLY-SENDER-ONLY-DEFAULT determines whether to reply to the author only,
or to everyone who received a copy of the message;
and if the latter, REPLY-CC-OTHERS determines whether
the receivers are listed under "To:" and/or "cc:".
These lists are then purged of all addresses which match any value
of REPLY-REMOVE.
This allows you to remove your own address if you don't wish to
automatically receive replies.

During command entry you have the opportunity to enter switches which will
override the values of applicable variables,
and/or name additional receivers.
The union of the automatic receivers, your additional receivers,
and the default recipients comprise the reply audience.
Then you may enter the text of your reply (see section @Ref(TxtEnt)).
The original message will be inserted just before your reply text
(delimited by two indented lines of dashes) if
REPLY-INSERT-CURRENT-MESSAGE-DEFAULT is non-zero.
Refinements may be made as directed by the termination of
the initial comments.

@Section(Forwarding)
@Label(FwdMsg)
If you would like to pass on some number of messages to others, possibly
with comments of your own, use the command FORWARD.
You have the opportunity to specify the recipients, and then any
initial comments you'd like to make.
MM then appends a copy of all selected messages to the initial comments.
Refinements may be made as directed by the termination of
the initial comments.

@Section(Remailing)
@Label(RemMsg)
If you wish to pass along messages without comment,
use the command REMAIL.
You specify the recipient(s) and then MM resends the message with some
additional header lines appended to the original header:
@Begin(Verbatim, LeftMargin +0.4inch,Above 0.75,Below 0.75)
Resent-Date: dd mmm yy hh:mm:ss-zzz
Resent-Sender: address
Resent-From: address
Resent-To: address-list
@End(Verbatim)
The "Resent-Sender:" field is included only if "Resent-From:"
does not identify you.
If RFC822-STYLE-HEADERS is zero, the prefix "Remailed-" will be used
in place of "Resent-".

@Section(Keying)
@Index(Keyflags) @Index(Keywords)
One way to organize your messages is to mark them with a set of keys.
MM supports two methods: keyflags and keywords.
Keyflags are the top thirty bits of the message flag word.
They are quick to recognize; however,
they are severely limited in number, and they are subject to change
through indiscriminate modification of the variable KEYWORDS.
Keywords are entries in the "Keywords:" header field.
They are slower to recognize because they require text recognition,
but they are essentially unlimited in number, and they aren't suddenly
scrambled due to a variable change.
Both keyflags and keywords follow a message as it moves from file to file;
however, keyflags may lose their identity if the KEYWORDS value does not
name the given bit, or renames it; keywords remain unchanged.
MM will keep a table of known keywords to allow recognition during
command entry.

@Section(Filing)
Another way to organize messages is to file them in other mail files,
by subject, time period, etc.  The commands COPY and MOVE facilitate
such actions.

@Section(Sorting)
The command SORT allows you to chronologically order the selected messages
within their logical positions in the mail file.

@Chapter(Message Sequences)
@Label(MsgSeq)

A message-sequence consists of any number of selectors (listed below),
and/or a single list of numbers.
The messages selected are those which satisfy all the specified selectors.

MM will only remember the last numeric list entered, so be sure to
specify all the numbers at one time.  The list may contain single
numbers, ranges, and sets, with commas separating them.
Ranges are entered as @U(k:m), meaning messages k through m.
Sets are entered as @U(k#n), meaning n messages beginning with k.

The numeric list and the selectors which take a date argument must be
entered last because they require [RETURN] confirmation.
Those selectors which take a text argument may be followed by other selectors
if the text is entered as a quoted string, @U("text"); otherwise,
they too must be entered last.
If you need to enter several such selectors, enter message sequence command
level by typing a comma and RETURN before specifying any selectors.
At this level, usually identified by the prompt M>, you may enter several
command lines, terminating the sequence by typing a @U"[RETURN]" at the prompt.

@Section(Message-sequence Selectors)
@Begin(KeyDescription, Spread 0.75)
@Index(message-sequence)
.@\selects the current message

%@\selects the last message in the mail file

AFTER (date)@\messages after the given date

ALL@\every message in the file, whether deleted or not

ANSWERED@\messages whose ANSWER bit is set

BEFORE (date)@\messages before the given date

CC-ME@\messages whose "cc:" field includes your address

CURRENT@\the current message

DELETED@\messages whose DELETE bit is set

FLAGGED@\messages whose FLAG bit is set

FROM (text)@\messages whose "From:" field contains the text pattern

FROM-ME@\messages sent by you

INVERSE@\process the sequence in inverse order

KEYWORDS (keys)@\messages marked with the given keyflag(s), and/or
 having the given keyword(s) in their "Keywords:" field

LAST (number)@\the last 'number' messages of the mail file

LONGER (number)@\messages whose size is greater than the given number

NEW@\messages (not yet seen) whose date/time is more recent than the
 date/time of the mail file, noted at the start of this MM session

ON (date)@\messages on the given date

PREVIOUS-SEQUENCE@\the last sequence used in an MM command

RECENT@\new messages that have been seen

SEEN@\messages whose SEEN bit is set

SHORTER (number)@\messages whose size is less than or equal to the given number

SINCE (date)@\equivalent to AFTER

SUBJECT (text)@\messages whose "Subject:" field contains the text pattern

TEXT (text)@\messages whose text portion contains the text pattern

TO (text)@\messages whose "To:" or "cc:" fields contain the text pattern

TO-ME@\messages whose "To:" field includes your address

UNANSWERED@\messages whose ANSWER bit is clear

UNDELETED@\messages whose DELETE bit is clear

UNFLAGGED@\messages whose FLAG bit is clear

UNKEYWORDS (keys)@\messages not marked with the given keyflag(s), and/or
 not containing the given keyword(s) in their "Keywords:" field

UNSEEN@\messages whose SEEN bit is clear
@End(KeyDescription)

@Chapter(Top Level)

The top-level is the initial and main command level.  Here, all of
MM's power is available through a variety of commands.

@Section(Top-level Commands)
Top-level is identified by the prompt stored in the variable TOP-LEVEL-PROMPT;
usually MM>.  The following commands are available:
@IndexSecondary(Primary="Commands, Top-level",Secondary="")
@Begin(Description)
ALIAS (user-name)
@IndexSecondary(Primary="Commands, Top-level",Secondary="ALIAS")
@\causes MM to behave as though you were the given user.
 MM re-initializes from that user's MM.INIT file, reads his mail file,
 and shows all subsequent outgoing messages as sent "From:" him,
 with yourself as the "Sender:".

ANSWER (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="ANSWER")
@\allows you to respond individually to each selected message
 (see section @Ref(AnsMsg)).
 MM prompts for addresses and the message text (see section @Ref(TxtEnt)),
 then sets the ANSWER bit;
 selected messages whose DELETE bit is set are ignored.
 Immediately before address entry, the following switches may be used:
@SwiDescription(
 /ALL@\reply to every recipient of the message

 /EXCLUDE-CURRENT-MESSAGE@\don't insert the message at the beginning of the reply

 /INCLUDE-CURRENT-MESSAGE@\insert the message at the beginning of the reply

 /SENDER@\reply only to the author of the message
)

APPEND (message-sequence)
@IndexSecondary(Primary="Commands, Top-level",Secondary="APPEND")
@\concatenates the selected messages into one, and replaces the
 first message of the sequence with it.

BBOARD (filename [MAIL])
@IndexSecondary(Primary="Commands, Top-level",Secondary="BBOARD")
@\is like @UX(GET PS:<BBOARD>filename.TXT);
 you pick filename from a table of names MM discovered at startup.

BLANK
@IndexSecondary(Primary="Commands, Top-level",Secondary="BLANK")
@\clears the terminal screen.

BUG
@IndexSecondary(Primary="Commands, Top-level",Secondary="BUG")
@\is a convenient facility for reporting problems or offering suggestions
 to the MM maintainers.  MM predefines the address-list, then prompts
 for the message text (see section @Ref(TxtEnt)).

CHECK
@IndexSecondary(Primary="Commands, Top-level",Secondary="CHECK")
@\sees if new messages have arrived,
 and shows header-lines for those which have.

CONTINUE
@IndexSecondary(Primary="Commands, Top-level",Secondary="CONTINUE")
@\resumes the last SEND, if it was aborted or QUIT out of.

COPY (file-spec) (message-sequence [CURRENT]) [switch]
@IndexSecondary(Primary="Commands, Top-level",Secondary="COPY")
@\appends a copy of each selected message to the given file (compare MOVE);
 selected messages whose DELETE bit is set are ignored.
 One of the following switches may be used to restrict the copy:
@SwiDescription(
 /HEADER-ONLY@\copy only the message header

 /TEXT-ONLY@\copy only the message text
)

COUNT (message-sequence [ALL])
@IndexSecondary(Primary="Commands, Top-level",Secondary="COUNT")
@\shows the number of messages in the given sequence.

CREATE-INIT
@IndexSecondary(Primary="Commands, Top-level",Secondary="CREATE-INIT")
@\writes the current names and values of MM's variables
 into a new version of MM.INIT in your login directory.
 (Also see PROFILE, SET, and SHOW.)

DAYTIME
@IndexSecondary(Primary="Commands, Top-level",Secondary="DAYTIME")
@\shows the current date and time.

DELETE (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="DELETE")
@\sets the DELETE bit of each selected message.
 Deleted messages may be removed from the mail file
 with the commands EXPUNGE or EXIT.

DIRED (message-sequence [ALL])
@IndexSecondary(Primary="Commands, Top-level",Secondary="DIRED")
@\runs the DIRED subsystem of EMACS' MMAIL package over the selected messages.
 To use DIRED, your editor must be EMACS and you must load the MMAIL library;
 the default EMACS.INIT will do this for you.

DISABLE
@IndexSecondary(Primary="Commands, Top-level",Secondary="DISABLE")
@\disables your capabilities (if you had any),
 and makes the current mail file "read-only".

ECHO (text)
@IndexSecondary(Primary="Commands, Top-level",Secondary="ECHO")
@\shows the text string on the terminal; it is useful in "TAKE" files.

EDIT (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="EDIT")
@\passes the selected messages, one at a time, to the editor
 (see section @Ref(EdtSel)) for modification;
 selected messages whose DELETE bit is set are ignored.

ENABLE
@IndexSecondary(Primary="Commands, Top-level",Secondary="ENABLE")
@\enables your capabilities (if you have any),
 and returns the mail file to its original state (usually "read-write").

EXAMINE (old-file)
@IndexSecondary(Primary="Commands, Top-level",Secondary="EXAMINE")
@\is like GET, except that no changes may be made in the file; it's "read-only".

EXIT
@IndexSecondary(Primary="Commands, Top-level",Secondary="EXIT")
@\removes all deleted messages from the current mail file,
 and halts MM, returning control to the superior fork.

EXPUNGE
@IndexSecondary(Primary="Commands, Top-level",Secondary="EXPUNGE")
@\removes all deleted messages from the current mail file.

FILE-LIST (file-spec) (message-sequence [CURRENT]) [switches]
@IndexSecondary(Primary="Commands, Top-level",Secondary="FILE-LIST")
@\prints an index of header-lines
 and then the selected messages to the specified file (compare LIST).
 The following switches are defined:
@SwiDescription(
 /HEADER-ONLY@\print only the message header

 /INDEX-ONLY@\print only an index of header-lines

 /SEPARATE-PAGES@\print each message on a new page

 /TEXT-ONLY@\print only the message text
)

FLAG (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="FLAG")
@\sets the FLAG bit of the selected messages.

FORWARD (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="FORWARD")
@\allows you to send a concatenation of the selected messages and
 your comments; selected messages whose DELETE bit is set are ignored.
 MM prompts for addresses and the initial message text, then
 concatenates a copy of all selected messages to the text input.
 Any further refinements depend upon the termination of the initial text
 (see section @Ref(FwdMsg)).

FROM (address-list)
@IndexSecondary(Primary="Commands, Top-level",Secondary="FROM")
@\specifies the address(es) of the "From:" field for all subsequent
 outgoing messages; a blank line defaults to the normal contents
 composed by MM.

GET (old-file)
@IndexSecondary(Primary="Commands, Top-level",Secondary="GET")
@\specifies the mail file MM should work with.  The file is
 scanned for message information and correctness, and a summary shown.

HEADERS (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="HEADERS")
@\shows the header-line for each selected message.

HELP (topic)
@IndexSecondary(Primary="Commands, Top-level",Secondary="HELP")
@\shows a short description of the specified command or topic.

JUMP (number)
@IndexSecondary(Primary="Commands, Top-level",Secondary="JUMP")
@\changes "current message" to refer to the stated message.

KEYWORDS (keys) (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="KEYWORDS")
@\sets the given keyflag(s) and/or includes the given keyword(s) in the
 "Keywords:" field of each selected message.

LIST (message-sequence [CURRENT]) [switches]
@IndexSecondary(Primary="Commands, Top-level",Secondary="LIST")
@\prints an index of header-lines
 and then the selected messages to the device specified by the variable
 LIST-DEVICE (compare FILE-LIST).  The following switches are defined:
@SwiDescription(
 /HEADER-ONLY@\print only the message header

 /INDEX-ONLY@\print only an index of header-lines

 /SEPARATE-PAGES@\print each message on a new page

 /TEXT-ONLY@\print only the message text
)

LITERAL-TYPE (message-sequence [CURRENT]) [switches]
@IndexSecondary(Primary="Commands, Top-level",Secondary="LITERAL-TYPE")
@\shows the selected messages without regard to the variables
 ONLY-TYPE-HEADERS and DONT-TYPE-HEADERS (compare TYPE),
 and sets the SEEN bit;
 selected messages whose DELETE bit is set are ignored.
 The following switches are defined:
@SwiDescription(
 /HEADER-ONLY@\show only the message header

 /SEPARATE-PAGES@\show each message on a new page

 /TEXT-ONLY@\show only the message text
)

LOGOUT
@IndexSecondary(Primary="Commands, Top-level",Secondary="LOGOUT")
@\expunges the mail file, and logs you out from the system.

MARK (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="MARK")
@\sets the SEEN bit of each selected message.

MOVE (file-spec) (message-sequence [CURRENT]) [switch]
@IndexSecondary(Primary="Commands, Top-level",Secondary="MOVE")
@\appends a copy of each selected message to the given file, and
 sets the DELETE bit (compare COPY);
 selected messages whose DELETE bit is set are ignored.
 One of the following switches may be used to restrict the copy:
@SwiDescription(
 /HEADER-ONLY@\copy only the message header

 /TEXT-ONLY@\copy only the message text
)

NET-MAIL
@IndexSecondary(Primary="Commands, Top-level",Secondary="NET-MAIL")
@\attempts to send any queued mail.

NEXT
@IndexSecondary(Primary="Commands, Top-level",Secondary="NEXT")
@\jumps to the next message in the file, and TYPEs it if undeleted.

PREVIOUS
@IndexSecondary(Primary="Commands, Top-level",Secondary="PREVIOUS")
@\jumps to the previous message in the file, and TYPEs it if undeleted.

PROFILE
@IndexSecondary(Primary="Commands, Top-level",Secondary="PROFILE")
@\assists you (through question and answer) in establishing values for a basic
 set of variables, which tailor MM's environment to your preferences.
 Then it writes the names and values of all variables into MM.INIT
 in your login directory.  (Also see CREATE-INIT, SET, and SHOW.)

PUSH
@IndexSecondary(Primary="Commands, Top-level",Secondary="PUSH")
@\places you in an inferior fork, running the EXEC.
 You may return to MM by issuing the command POP.

QUIT
@IndexSecondary(Primary="Commands, Top-level",Secondary="QUIT")
@\halts MM without removing any deleted messages from the current mail file.

READ (message-sequence [NEW])
@IndexSecondary(Primary="Commands, Top-level",Secondary="READ")
@\enters READ mode, typing and allowing operation(s) on each of the selected
 messages, one at a time.

REMAIL (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="REMAIL")
@\allows you to re-send each selected message, without comment.
 MM prompts for addresses, then proceeds to individually send each selected
 message to the named recipients, with the header modified to show that you
 remailed it, when, and to whom.

REPLY (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="REPLY")
@\is equivalent to ANSWER.

REPLY-TO (address-list)
@IndexSecondary(Primary="Commands, Top-level",Secondary="REPLY-TO")
@\adds the address(es) to the "Reply-To:" field for all subsequent
 outgoing messages; a blank line results in no "Reply-To:" field.

RESTORE-DRAFT (old-file) (switch [/TEXT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="RESTORE-DRAFT")
@\enters SEND-mode, resetting the outgoing message fields to the
 values of the message draft saved in the given file.
 The following switches are defined:
@SwiDescription(
 /COMMAND@\resume at SEND-mode command level

 /SEND@\initiate message delivery, and return to top-level

 /TEXT@\resume with message text input
)

SEND [address-list]
@IndexSecondary(Primary="Commands, Top-level",Secondary="SEND")
@\enters SEND-mode, prompting for addresses (if not entered), a subject,
 and the message text (see section @Ref(TxtEnt)).

SET (variable) (value)
@IndexSecondary(Primary="Commands, Top-level",Secondary="SET")
@\changes the value of the named variable for this MM session.
 Changes may be made "permanent" with the command CREATE-INIT.
 Type @UX"HELP SET (variable)" to see a description of the function of the
 named variable, and its current value.
 (Also see CREATE-INIT, PROFILE, and SHOW.)

SHOW
@IndexSecondary(Primary="Commands, Top-level",Secondary="SHOW")
@\displays the current MM variable settings,
 as established by MM.INIT, and/or SET commands.
 (Also see CREATE-INIT, PROFILE, and SET.)

SORT (message-sequence [ALL])
@IndexSecondary(Primary="Commands, Top-level",Secondary="SORT")
@\reorders the selected messages chronologically by date of composition,
 within the positions they initially hold in the mail file.

STATUS
@IndexSecondary(Primary="Commands, Top-level",Secondary="STATUS")
@\shows relevant information and statistics about the current mail file,
 for example, how many messages are deleted and unseen,
 and how large the file is.

SYSTEM-MSGS
@IndexSecondary(Primary="Commands, Top-level",Secondary="SYSTEM-MSGS")
@\is equivalent to @UX"GET SYSTEM:MAIL.TXT.1".

TAKE (old-file)
@IndexSecondary(Primary="Commands, Top-level",Secondary="TAKE")
@\causes MM to take command input from the file, instead of the terminal.
 MM closes the file and restores input from the terminal when any of
 the following happens: end of file, command error, an ALIAS command,
 or a TAKE command with no argument (this suppresses the "[End of ...]"
 message).

TYPE (message-sequence [CURRENT]) [switches]
@IndexSecondary(Primary="Commands, Top-level",Secondary="TYPE")
@\shows the selected messages as directed by the variables ONLY-TYPE-HEADERS
 and DONT-TYPE-HEADERS (compare LITERAL-TYPE),
 and sets the SEEN bit;
 selected messages whose DELETE bit is set are ignored.
 The following switches are defined:
@SwiDescription(
 /HEADER-ONLY@\show only the message header

 /SEPARATE-PAGES@\show each message on a new page

 /TEXT-ONLY@\show only the message text
)

UNANSWER (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="UNANSWER")
@\clears the ANSWER bit of each selected message.

UNDELETE (message-sequence [PREVIOUS-SEQUENCE])
@IndexSecondary(Primary="Commands, Top-level",Secondary="UNDELETE")
@\clears the DELETE bit of each selected message.

UNFLAG (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="UNFLAG")
@\clears the FLAG bit of each selected message.

UNKEYWORDS (keys) (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="UNKEYWORDS")
@\clears the given keyflag(s) and/or removes the given keyword(s)
 from the "Keywords:" field of each selected message.

UNMARK (message-sequence [CURRENT])
@IndexSecondary(Primary="Commands, Top-level",Secondary="UNMARK")
@\clears the SEEN bit of each selected message.

VERSION
@IndexSecondary(Primary="Commands, Top-level",Secondary="VERSION")
@\shows the version number and configuration of MM.

XPRESS (message-sequence [CURRENT]) [switches]
@IndexSecondary(Primary="Commands, Top-level",Secondary="XPRESS")
@\prints an index of header-lines
 and the selected messages on the device PNG:.
 The following switches are defined:
@SwiDescription(
 /HEADER-ONLY@\print only the message header

 /INDEX-ONLY@\print only an index of header-lines

 /SEPARATE-PAGES@\print each message on a new page

 /TEXT-ONLY@\print only the message text
)
@End(Description)

@Section(Rescan Commands)
MM may also be entered by typing @UX"MM command arguments" to the EXEC.
There is no recognition available, so you'll have to uniquely specify
the command, and any arguments (if needed).
The following subset of top-level commands are available (commands
recognized by the initial character(s) are indicated with underlining):
@Begin(Format, Above 0.75,Below 0.75)
ALIAS (user-name)
BBOARD (filename [MAIL])
BUG
EXAMINE (old-file)
GET (old-file)
HEADERS message-sequence [CURRENT])
@U(R)EAD (message-sequence [NEW])
RESTORE-DRAFT (old-file) (switch [/TEXT])
@U(S)END [address-list]
SYSTEM-MSGS
TAKE (old-file)
@U(T)YPE (message-sequence [CURRENT]) [switches]
@End(Format)

@Chapter(READ mode)

READ-mode is a special command environment which focuses attention on the
current message.
It is entered from top-level with the command READ.
If the message-sequence argument is not given, NEW is assumed.

As each message selected by the message-sequence
becomes the object of READ-mode, it is defined to be the current message.
MM will first TYPE the message (if it is undeleted),
then allow you to issue commands as desired.

@Section(READ-mode Commands)
@IndexSecondary(Primary="Commands, READ-mode",Secondary="")
READ-mode is identified by the prompt stored in the variable READ-PROMPT,
usually R>.
Typing a @U"[RETURN]" at the prompt will default to the command NEXT.
The following commands are available, most referring to the
message currently being read:

@Begin(Description)
ANSWER [switches] [address-list]
@IndexSecondary(Primary="Commands, READ-mode",Secondary="ANSWER")
@\allows you to respond to the current message (see section @Ref(AnsMsg)).
 MM prompts for the addresses (if not already entered) and the message
 text (see section @Ref(TxtEnt)), then sets the ANSWER bit.
 Immediately before address entry, the following switches may be used:
@SwiDescription(
 /ALL@\reply to every recipient of the message

 /EXCLUDE-CURRENT-MESSAGE@\don't insert the message at the beginning of the reply

 /INCLUDE-CURRENT-MESSAGE@\insert the message at the beginning of the reply

 /SENDER@\reply only to the author of the message
)

BLANK
@IndexSecondary(Primary="Commands, READ-mode",Secondary="BLANK")
@\clears the terminal screen.

CONTINUE
@IndexSecondary(Primary="Commands, READ-mode",Secondary="CONTINUE")
@\resumes the last SEND, if it was aborted or QUIT out of.

COPY (file-spec) [switch]
@IndexSecondary(Primary="Commands, READ-mode",Secondary="COPY")
@\appends a copy of the current message to the given file (compare MOVE);
 ignored if the current message is deleted.
 One of the following switches may be used to restrict the copy:
@SwiDescription(
 /HEADER-ONLY@\copy only the message header

 /TEXT-ONLY@\copy only the message text
)

DAYTIME
@IndexSecondary(Primary="Commands, READ-mode",Secondary="DAYTIME")
@\shows the current date and time.

DELETE
@IndexSecondary(Primary="Commands, READ-mode",Secondary="DELETE")
@\sets the DELETE bit of the current message.

ECHO (text)
@IndexSecondary(Primary="Commands, READ-mode",Secondary="ECHO")
@\shows the text string on the terminal; it is useful in "TAKE" files.

EDIT
@IndexSecondary(Primary="Commands, READ-mode",Secondary="EDIT")
@\passes the current message to the editor (see section @Ref(EdtSel))
 for modification.

FILE-LIST (file-spec) [switches]
@IndexSecondary(Primary="Commands, READ-mode",Secondary="FILE-LIST")
@\prints the current message to the specified file (compare LIST).
 The following switches are defined:
@SwiDescription(
 /HEADER-ONLY@\print only the message header

 /TEXT-ONLY@\print only the message text
)

FLAG
@IndexSecondary(Primary="Commands, READ-mode",Secondary="FLAG")
@\sets the FLAG bit of the current message.

FORWARD [address-list]
@IndexSecondary(Primary="Commands, READ-mode",Secondary="FORWARD")
@\allows you to send a concatenation of the current message and
 your comments (see section @Ref(FwdMsg)).
 MM prompts for addresses (if not already given with FORWARD) and the
 initial message text, then appends a copy of the current message to the
 text input.
 Any further refinements depend upon the termination of the initial text.

HEADER
@IndexSecondary(Primary="Commands, READ-mode",Secondary="HEADER")
@\shows the header-line for the current message.

HELP (topic)
@IndexSecondary(Primary="Commands, READ-mode",Secondary="HELP")
@\shows a short description of the specified command or topic.

KEYWORDS (keys)
@IndexSecondary(Primary="Commands, READ-mode",Secondary="KEYWORDS")
@\sets the given keyflag(s) and/or includes the given keyword(s) in
 the "Keywords:" field of the current message.

LIST [switches]
@IndexSecondary(Primary="Commands, READ-mode",Secondary="LIST")
@\outputs the current message to the device specified by the variable
 LIST-DEVICE (compare FILE-LIST).  The following switches are defined:
@SwiDescription(
 /HEADER-ONLY@\print only the message header

 /TEXT-ONLY@\print only the message text
)

LITERAL-TYPE [switches]
@IndexSecondary(Primary="Commands, READ-mode",Secondary="LITERAL-TYPE")
@\shows the current message without regard to the variables ONLY-TYPE-HEADERS
 and DONT-TYPE-HEADERS (compare TYPE), and sets the SEEN bit.
 The following switches are defined:
@SwiDescription(
 /HEADER-ONLY@\show only the message header

 /TEXT-ONLY@\show only the message text
)

MARK
@IndexSecondary(Primary="Commands, READ-mode",Secondary="MARK")
@\sets the SEEN bit of the current message.

MOVE (file-spec) [switch]
@IndexSecondary(Primary="Commands, READ-mode",Secondary="MOVE")
@\appends a copy of the current message to the given file, and then
 sets the DELETE bit (compare COPY);
 ignored if the current message is deleted.
 One of the following switches may be used to restrict the copy:
@SwiDescription(
 /HEADER-ONLY@\copy only the message header

 /TEXT-ONLY@\copy only the message text
)

NET-MAIL
@IndexSecondary(Primary="Commands, READ-mode",Secondary="NET-MAIL")
@\attempts to send any queued mail.

NEXT
@IndexSecondary(Primary="Commands, READ-mode",Secondary="NEXT")
@\goes to the next message specified by the message sequence,
 and types it if undeleted; or, returns to top-level if there is none.

PREVIOUS
@IndexSecondary(Primary="Commands, READ-mode",Secondary="PREVIOUS")
@\goes to the previous message specified by the message sequence,
 and types it if undeleted.

PUSH
@IndexSecondary(Primary="Commands, READ-mode",Secondary="PUSH")
@\places you in an inferior fork, running the EXEC.
 You may return to READ-mode by issuing the command POP.

QUIT
@IndexSecondary(Primary="Commands, READ-mode",Secondary="QUIT")
@\returns to top-level.

REMAIL [address-list]
@IndexSecondary(Primary="Commands, READ-mode",Secondary="REMAIL")
@\allows you to re-send the current message, without comment.
 MM prompts for the addresses (if they were not given with the command),
 then proceeds to send the message to the named recipients, with the
 header modified to show that you remailed it, when, and to whom.

REPLY [switches] [address-list]
@IndexSecondary(Primary="Commands, READ-mode",Secondary="REPLY")
@\is equivalent to ANSWER.

SEND [address-list]
@IndexSecondary(Primary="Commands, READ-mode",Secondary="SEND")
@\enters SEND-mode, prompting for addresses (if not entered), a subject,
 and the message text (see section @Ref(TxtEnt)).

SPELL
@IndexSecondary(Primary="Commands, READ-mode",Secondary="SPELL")
@\invokes the SPELL program over the current message.

TAKE (old-file)
@IndexSecondary(Primary="Commands, READ-mode",Secondary="TAKE")
@\causes MM to take command input from the file, instead of the terminal.
 MM closes the file and restores input from the terminal when any of
 the following happen: end of file, command error, an ALIAS command,
 or a TAKE command with no argument (this suppresses the "[End of ...]"
 message).

TYPE [switches]
@IndexSecondary(Primary="Commands, READ-mode",Secondary="TYPE")
@\shows the current message as directed by the variables ONLY-TYPE-HEADERS
 and DONT-TYPE-HEADERS (compare LITERAL-TYPE), and sets the SEEN bit.
 The following switches are defined:
@SwiDescription(
 /HEADER-ONLY@\show only the message header

 /TEXT-ONLY@\show only the message text
)

UNANSWER
@IndexSecondary(Primary="Commands, READ-mode",Secondary="UNANSWER")
@\clears the ANSWER bit of the current message.

UNDELETE
@IndexSecondary(Primary="Commands, READ-mode",Secondary="UNDELETE")
@\clears the DELETE bit of the current message.

UNFLAG
@IndexSecondary(Primary="Commands, READ-mode",Secondary="UNFLAG")
@\clears the FLAG bit of the current message.

UNKEYWORDS (keys)
@IndexSecondary(Primary="Commands, READ-mode",Secondary="UNKEYWORDS")
@\clears the given keyflags and/or removes the given keywords from the
 "Keywords:" field of the current message.

UNMARK
@IndexSecondary(Primary="Commands, READ-mode",Secondary="UNMARK")
@\clears the SEEN bit of the current message.

XPRESS [switches]
@IndexSecondary(Primary="Commands, READ-mode",Secondary="XPRESS")
@\prints the current message on the device PNG:.
 The following switches are defined:
@SwiDescription(
 /HEADER-ONLY@\print only the message header

 /TEXT-ONLY@\print only the message text
)
@End(Description)

@Chapter(SEND mode)

SEND-mode is the special command environment where outgoing messages
are composed, refined, and sent.
It is entered from either top-level or READ-mode by the command SEND.

SEND-mode will prompt for "To:" and "cc:" recipients if an address-list was
not entered after the command SEND.  Then it will ask for the subject
of the message.  Finally, it prompts for the message text.
If the variable USE-EDITOR-AUTOMATICALLY is non-zero, then MM
automatically transfers control to the editor selected by the logical
name EDITOR: to enter the message text.  Otherwise, MM collects the
text itself, with the following control characters having special functions:
@Begin(KeyDescription, Spread 0.75)
CTRL/B@\asks for a file name, and inserts its contents at the point
 you are currently typing.  You may continue typing after the file
 has been read in.

CTRL/E@\invokes the editor specified by the logical name EDITOR: on the
 message text entered so far.

CTRL/K@\retypes the message text entered so far.

CTRL/R@\retypes the current line of input.

CTRL/U@\deletes the line of input from the cursor to the prompt
  (or left margin).

CTRL/V@\causes the next character to be taken as normal text,
 bypassing any special function it may otherwise have
 (like the characters listed here).

CTRL/W@\deletes the last word input.

DEL@\deletes the last character input.

ESC or CTRL/Z@\terminates message text input, then acts as directed
 by the variable ESCAPE-AUTOMATIC-SEND.
@End(KeyDescription)

@Section(SEND-mode Commands)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="")
SEND-mode is identified by the prompt stored in the variable SEND-PROMPT,
usually S>.
Typing a @U"[RETURN]" at the prompt may default to the command SEND,
depending upon the value of SEND-RETURN-SENDS.
The following commands affect the message being composed, unless
otherwise stated:

@Begin(Description)
BCC (address-list)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="BCC")
@\adds the address(es) to the "Bcc:" field.
 These recipients receive blind carbon-copies, and are not included in the
 header of the outgoing copy sent to "To:" and "cc:" recipients.

BLANK
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="BLANK")
@\clears the terminal screen.

CC (address-list)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="CC")
@\adds the address(es) to the "cc:" field.

DAYTIME
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="DAYTIME")
@\shows the current date and time.

DISPLAY (field [ALL]) [switch]
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="DISPLAY")
@\@Multiple[shows the specified outgoing message field:
@KeyDescription(
 ALL@\the entire message

 BCC@\the "Bcc:" field

 CC@\the "cc:" field

 FCC@\the "Fcc:" field

 FROM@\the "From:" field

 HEADER@\the message header

 KEYWORDS@\the "Keywords:" field

 REPLY-TO@\the "Reply-To:" field

 SUBJECT@\the "Subject:" field

 TEXT@\the message text

 TO@\the "To:" field
)
 The following switches may be used:
@SwiDescription(
 /IMAGE@\shows the part as it will appear in the outgoing message;
  such things as addresses within groups are not visible in the outgoing
  header, but it is useful to be able to see them during message
 composition.
)
]

ECHO (text)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="ECHO")
@\shows the text string on the terminal; it is useful in "TAKE" files.

EDIT (field [TEXT])
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="EDIT")
@\transfers control to the editor (see section @Ref(EdtSel))
 to allow modification of the specified outgoing message field:
@KeyDescription(
 HEADERS@\the message header

 TEXT@\the message text
)
 
ERASE (field)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="ERASE")
@\clears the specified outgoing message field:
@KeyDescription(
 ALL@\the entire message

 BCC@\the "Bcc:" field

 CC@\the "cc:" field

 FCC@\the "Fcc:" field

 IN-REPLY-TO@\the "In-Reply-To:" field

 KEYWORDS@\the "Keywords:" field

 REPLY-TO@\the "Reply-To:" field

 SUBJECT@\the "Subject:" field

 TEXT@\the message text

 TO@\the "To:" field
)

FCC (file-list)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="FCC")
@\adds the file(s) to the "Fcc:" field.
 These recipients receive file carbon-copies, and are not included in the
 header of the outgoing copy sent to "To:" and "cc:" recipients.

FROM (address-list)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="FROM")
@\specifies the address(es) of the "From:" field;
 a blank line defaults to the normal contents composed by MM.

HELP (topic)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="HELP")
@\shows a short description of the specified command or topic.

INSERT (old-file)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="INSERT")
@\appends the file contents to the existing message text.

KEYWORDS (keywords)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="KEYWORDS")
@\adds the given keywords to the "Keywords:" field.

LITERAL-TYPE [switch]
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="LITERAL-TYPE")
@\shows the current message (not the one being composed) without regard to
 the variables ONLY-TYPE-HEADERS and DONT-TYPE-HEADERS (compare TYPE),
 and sets the SEEN bit.
 The following switches are defined:
@SwiDescription(
 /HEADER-ONLY@\show only the message header

 /TEXT-ONLY@\show only the message text
)

PUSH
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="PUSH")
@\places you in an inferior fork, running the EXEC.
 You may return to SEND-mode by issuing the command POP.

QUIT
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="QUIT")
@\returns to top-level or READ-mode, as appropriate.

REMOVE (address-list)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="REMOVE")
@\removes the given address(es) from the "To:", "cc:", "Bcc:", "Fcc:" and
 "Reply-To:" fields.
 Wild-card strings may be used here, but special note is given regarding
 the entry of an initial wild-card "*".
 Normal address entry interprets an asterisk to mean a file name follows.
 To enter an asterisk wild-card in the first character position,
 you must quote it with a CTRL/V.

 A file name address will not remove a mailbox address, nor vice versa.
 When a group name is specified, then the entire group is removed.

REPLY-TO (address-list)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="REPLY-TO")
@\adds the given address(es) to the list of addresses
 shown in the "Reply-To:" field;
 a blank line results in no "Reply-To:" field.

RESTORE-DRAFT (old-file) (switch [/COMMAND])
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="RESTORE-DRAFT")
@\resets the outgoing message fields to the
 values of the message draft saved in the given file.
 The following switches are defined:
@SwiDescription(
 /COMMAND@\resume at SEND-mode command level

 /SEND@\initiate message delivery, and return to top-level

 /TEXT@\resume with message text input
)

SAVE-DRAFT (file-spec)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="SAVE-DRAFT")
@\saves a draft of the outgoing message in the given file.
 Later you may restore the draft for final composition and sending
 with the command RESTORE.

SEND
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="SEND")
@\initiates delivery of the outgoing message,
 and returns to top-level or READ-mode, as appropriate.

SPELL
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="SPELL")
@\invokes the SPELL program over the message text.

SUBJECT (text)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="SUBJECT")
@\specifies the content of the "Subject:" field;
 a blank line results in no "Subject:" field.

TAKE (old-file)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="TAKE")
@\causes MM to take command input from the file, instead of the terminal.
 MM closes the file and restores input from the terminal when any of
 the following happens: end of file, command error, an ALIAS command,
 or a TAKE command with no argument (this suppresses the "[End of ...]"
 message).

TEXT
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="TEXT")
@\resumes input of the text of the message.

TO (address-list)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="TO")
@\adds the address(es) to the "To:" field.

TYPE [switch]
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="TYPE")
@\shows the current message (not the one being composed) as directed by
 the variables ONLY-TYPE-HEADERS and DONT-TYPE-HEADERS (see LITERAL-TYPE),
 and sets the SEEN bit.
 The following switches are defined:
@SwiDescription(
 /HEADER-ONLY@\show only the message header

 /TEXT-ONLY@\show only the message text
)

UNKEYWORDS (keywords)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="UNKEYWORDS")
@\removes the given keywords from the "Keywords:" field;
 keywords must match completely (there is no partial recognition).

USER-HEADER (field) (text)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="USER-HEADER")
@\inserts "field: text" into the message header;
 field must be defined by the variable USER-HEADERS.
@End(Description)

@Chapter(Variables)
@Label(VarDef)

The variables listed below are open for user modification to tailor MM's
behavior to personal preference.  The initial settings are taken from
the text file MM.INIT in the user's login directory.  If this file does
not exist, then MM assumes the default values shown below.  The commands
CREATE-INIT, PROFILE, SET, and SHOW facilitate variable management.

The type of argument each variable expects is shown in parentheses.  The
default value (if any) is shown within square brackets.
Those variables which take a list of something expect a comma to separate
list elements.

@Section(Variable Names)
@Begin(Description)
@IndexSecondary(Primary="Variables",Secondary="")
BLANK-SCREEN-STARTUP (number [-1])
@IndexSecondary(Primary="Variables",Secondary="BLANK-SCREEN-STARTUP")
@\controls whether or not the the terminal screen is automatically cleared
 at startup, and before each message is typed in READ-mode:
@ValDescription[
@>0@ @ @\no

@>-1@ @ @\yes
]

COMMAND-IMMEDIATE-WAKEUP (number [0])
@IndexSecondary(Primary="Variables",Secondary="COMMAND-IMMEDIATE-WAKEUP")
@\controls when command input is parsed:
@ValDescription[
@>0@ @ @\after a break character (RETURN, ESC, CTRL/F, question mark)

@>-1@ @ @\after each command field; this is not recommended as
 this results in additional system overhead
]

CONTROL-E-EDITOR (number [0])
@IndexSecondary(Primary="Variables",Secondary="CONTROL-E-EDITOR")
@\controls how (if) CTRL/E transfers to the editor during message
 text entry:
@ValDescription[
@>+1@ @ @\always transfer

@>0@ @ @\require confirmation to transfer

@>-1@ @ @\never transfer
]

CONTROL-N-ABORT (number [0])
@IndexSecondary(Primary="Variables",Secondary="CONTROL-N-ABORT")
@\controls how (if) CTRL/N aborts:
@ValDescription[
@>+1@ @ @\always abort

@>0@ @ @\require confirmation for each abort

@>-1@ @ @\never abort
]

DEFAULT-BCC-LIST (address-list)
@IndexSecondary(Primary="Variables",Secondary="DEFAULT-BCC-LIST")
@\specifies a default list of recipients to be Bcc'd on outgoing messages.

DEFAULT-CC-LIST (address-list)
@IndexSecondary(Primary="Variables",Secondary="DEFAULT-CC-LIST")
@\specifies a default list of recipients to be cc'd on outgoing messages.

DEFAULT-FCC-LIST (address-list)
@IndexSecondary(Primary="Variables",Secondary="DEFAULT-FCC-LIST")
@\specifies a default list of recipients to be Fcc'd on outgoing messages.

DEFAULT-FROM (address-list)
@IndexSecondary(Primary="Variables",Secondary="DEFAULT-FROM")
@\specifies the default address(es) to appear in the "From:" field
 of all outgoing messages.

DEFAULT-REPLY-TO (address-list)
@IndexSecondary(Primary="Variables",Secondary="DEFAULT-REPLY-TO")
@\specifies a default list of addresses to appear in the "Reply-To:" field
 of all outgoing messages.

DONT-TYPE-HEADERS (fields)
@IndexSecondary(Primary="Variables",Secondary="DONT-TYPE-HEADERS")
@\specifies the list of header fields which you do not want TYPE to show
 (see ONLY-TYPE-HEADERS).

ESCAPE-AUTOMATIC-SEND (number [0])
@IndexSecondary(Primary="Variables",Secondary="ESCAPE-AUTOMATIC-SEND")
@\controls the action of ESC and CTRL/Z after terminating message text input:
@ValDescription[
@>+1@ @ @\ESC sends the message, and CTRL/Z returns to SEND-mode

@>0@ @ @\both ESC and CTRL/Z return to SEND-mode

@>-1@ @ @\ESC returns to SEND-mode, and CTRL/Z sends the message
]

FLAGGED-MESSAGES-AUTOTYPE-SUPPRESS  (number [0])
@IndexSecondary(Primary="Variables",Secondary="FLAGGED-MESSAGES-AUTOTYPE-SUPPRESS")
@\controls the automatic output of header-lines
 for those messages whose FLAG bit is set:
@ValDescription[
@>+1@ @ @\show them only when reading in a mail file

@>0@ @ @\show them when reading in a mail file, and when new mail arrives

@>-1@ @ @\never automatically show them
]

GET-CONNECTED-DIRECTORY (number [0])
@IndexSecondary(Primary="Variables",Secondary="GET-CONNECTED-DIRECTORY")
@\controls where MM GETs the mail file (login or connected directory) at
 normal startup:
@ValDescription[
@>+1@ @ @\always get it from the connected directory

@>0@ @ @\try the connected directory first, but ask for
  user confirmation if it is not the login directory

@>-1@ @ @\always get it from the login directory
]

HEADER-OPTIONS (text)
@IndexSecondary(Primary="Variables",Secondary="HEADER-OPTIONS")
@\specifies one user-defined header field and content, which should
 initially be inserted when entering SEND mode;
 this variable may be listed several times, once for each field you
 wish to automatically include in each outgoing message.

KEYWORDS (keyflags)
@IndexSecondary(Primary="Variables",Secondary="KEYWORDS")
@\defines the names of keyflags which may be used to classify messages;
 names are assigned to keyflags in the order listed.
 If you desire to remove a keyflag from the middle of the list, replace
 it with a dummy name to serve as a place holder for a future keyflag.
 If you don't, the effect is as if messages were globally rekeyed.

LIST-DEVICE (file-spec [LPT:MM.LST])
@IndexSecondary(Primary="Variables",Secondary="LIST-DEVICE")
@\specifies the output device for LIST.

LIST-INCLUDE-HEADERS (number [-1])
@IndexSecondary(Primary="Variables",Secondary="LIST-INCLUDE-HEADERS")
@\controls whether or not an index of header-lines
 is printed before the messages:
@ValDescription[
@>0@ @ @\no

@>-1@ @ @\yes
]

LIST-ON-SEPARATE-PAGES (number [-1])
@IndexSecondary(Primary="Variables",Secondary="LIST-ON-SEPARATE-PAGES")
@\defines the default choice of message separation for LIST and FILE-LIST:
@ValDescription[
@>0@ @ @\a blank line (/SEPARATE-PAGES overrides)

@>-1@ @ @\a form-feed, thus each message starts on a new page
]

MAIL-COPY-FILE (file-spec [<login-directory>MAIL.CPY])
@IndexSecondary(Primary="Variables",Secondary="MAIL-COPY-FILE")
@\defines the name of the temporary file to receive a copy of each outgoing
 message; a new version is created for each outgoing message.
 If a blank name is given, no copy is kept.

MAILER-IS-MTP (number [0])
@IndexSecondary(Primary="Variables",Secondary="MAILER-IS-MTP")
@\determines which mailer to use for delivering queued mail:
@ValDescription[
@>0@ @ @\use the system default mailer (MAILER, XMAILR)

@>-1@ @ @\use MTP, the internet mailer
]

MESSAGE-SEQUENCE-PROMPT (text [M>])
@IndexSecondary(Primary="Variables",Secondary="MESSAGE-SEQUENCE-PROMPT")
@\defines the prompt shown at message sequence command entry.

NEW-FILE-PROTECTION (octal [0])
@IndexSecondary(Primary="Variables",Secondary="NEW-FILE-PROTECTION")
@\specifies the protection code to be given text files created by
 the commands COPY, MOVE, etc; if zero, the system default is used.

ONLY-TYPE-HEADERS (fields)
@IndexSecondary(Primary="Variables",Secondary="ONLY-TYPE-HEADERS")
@\specifies the list of header fields which you only want TYPE to show
 (see DONT-TYPE-HEADERS).

PERSONAL-NAME (text)
@IndexSecondary(Primary="Variables",Secondary="PERSONAL-NAME")
@\defines the personal name to be used in outgoing messages.  If this
 string is not supplied, MM asks FINGER for it.

PROMPT-FOR-BCC (number [0])
@IndexSecondary(Primary="Variables",Secondary="PROMPT-FOR-BCC")
@\controls whether or not SEND-mode asks for "Bcc:" recipients:
@ValDescription[
@>0@ @ @\no

@>-1@ @ @\yes
]

READ-PROMPT (text [R>])
@IndexSecondary(Primary="Variables",Secondary="READ-PROMPT")
@\defines the prompt shown at READ-mode command entry.

REPLY-CC-OTHERS (number [-1])
@IndexSecondary(Primary="Variables",Secondary="REPLY-CC-OTHERS")
@\controls how recipients are listed in message replies:
@ValDescription[
@>0@ @ @\"To:" or "cc:" as they were in the original message

@>-1@ @ @\"To:" for the author, and "cc:" for all others
]

REPLY-INITIAL-DISPLAY (number [0])
@IndexSecondary(Primary="Variables",Secondary="REPLY-INITIAL-DISPLAY")
@\controls whether or not there is an initial display of header information
 for ANSWER (REPLY):
@ValDescription[
@>0@ @ @\no

@>-1@ @ @\yes
]

REPLY-INSERT-CURRENT-MESSAGE-DEFAULT (number [0])
@IndexSecondary(Primary="Variables",Secondary="REPLY-INSERT-CURRENT-MESSAGE-DEFAULT")
@\defines whether or not to insert a copy of the original message
 at the beginning of the response for ANSWER (REPLY):
@ValDescription[
@>0@ @ @\no (/INCLUDE-CURRENT-MESSAGE overrides)

@>-1@ @ @\yes (/EXCLUDE-CURRENT-MESSAGE overrides)
]

REPLY-REMOVE (address-list)
@IndexSecondary(Primary="Variables",Secondary="REPLY-REMOVE")
@\specifies a list of addresses to be automatically removed from the
 list of addresses discovered from each message replied to;
 wild-card strings may be used.

REPLY-SENDER-ONLY-DEFAULT (number [-1])
@IndexSecondary(Primary="Variables",Secondary="REPLY-SENDER-ONLY-DEFAULT")
@\defines the default choice of recipients for ANSWER (REPLY):
@ValDescription[
@>0@ @ @\everyone who received the original message (/SENDER overrides)

@>-1@ @ @\author only (/ALL overrides)
]

RFC733-STYLE-HEADERS (number [-1])
@IndexSecondary(Primary="Variables",Secondary="RFC733-STYLE-HEADERS")
@\controls how addresses are formatted in outgoing mail:
@ValDescription[
@>0@ @ @\address (personal name); "Doe@@Site (John Q. Doe)"

@>-1@ @ @\personal name <address>; "John Q. Doe <Doe@@Site>"
]

RFC822-STYLE-HEADERS (number [0])
@IndexSecondary(Primary="Variables",Secondary="RFC822-STYLE-HEADERS")
@\controls the use of new features and field names defined by RFC 822;
 at present, this means using the prefix "Resent-" instead of "Remailed-"
 for the fields generated in outgoing messages sent via the command
 REMAIL.
@ValDescription[
@>0@ @ @\no

@>-1@ @ @\yes
]

SAVED-MESSAGES-FILE (old-file)
@IndexSecondary(Primary="Variables",Secondary="SAVED-MESSAGES-FILE")
@\specifies the mail file to receive copies of all outgoing messages;
 if this file does not already exist,
 MM will ask if it should create it.

SEND-PROMPT (text [S>])
@IndexSecondary(Primary="Variables",Secondary="SEND-PROMPT")
@\specifies the prompt shown at SEND-mode command entry.

SEND-RETURN-SENDS (number [-1])
@IndexSecondary(Primary="Variables",Secondary="SEND-RETURN-SENDS")
@\controls whether or not a blank line entered at SEND-mode equates
 to the command SEND:
@ValDescription[
@>0@ @ @\no

@>-1@ @ @\yes
]

SEND-VERBOSE-FLAG (number [+1])
@IndexSecondary(Primary="Variables",Secondary="SEND-VERBOSE-FLAG")
@\controls which addresses delivery information is reported for:
@ValDescription[
@>+1@ @ @\all addresses

@>0@ @ @\local addresses

@>-1@ @ @\none
]

SHORT-MESSAGE-LENGTH (number [1500])
@IndexSecondary(Primary="Variables",Secondary="SHORT-MESSAGE-LENGTH")
@\defines the maximum length (in characters) of short messages;
 those larger than this are known as long messages.

TOP-LEVEL-PROMPT (text [MM>])
@IndexSecondary(Primary="Variables",Secondary="TOP-LEVEL-PROMPT")
@\defines the prompt shown at top-level command entry.

USE-EDITOR-AUTOMATICALLY (number [0])
@IndexSecondary(Primary="Variables",Secondary="USE-EDITOR-AUTOMATICALLY")
@\controls whether or not to immediately enter the editor to input the
 message text for outgoing messages:
@ValDescription[
@>0@ @ @\no

@>-1@ @ @\yes
]

USER-HEADERS (fields)
@IndexSecondary(Primary="Variables",Secondary="USER-HEADERS")
@\specifies a list of user defined header fields which may be individually
 set in outgoing messages with the command USER-HEADER.

USER-NAME (user-name [your login user name])
@IndexSecondary(Primary="Variables",Secondary="USER-NAME")
@\defines how your user name should be cased in outgoing mail (for example,
 user SMITH may wish to change the initial setting to "USER-NAME Smith").
@End(Description)

@Appendix(List of Commands)

This appendix lists the commands and their arguments for Top-level,
READ-mode, SEND-mode and message-sequence command level.
MM has made special provision for the most useful commands,
such that they might be recognized by the first letter(s);
these are indicated with underlining.

@AppendixSection(Top-level Commands)
@IndexSecondary(Primary="Commands, Top-level",Secondary="")
@Begin(Verbatim, Above 0.75,Below 0.75)
ALIAS (user-name)
@U(A)NSWER (message-sequence [CURRENT])
APPEND (message-sequence)
BBOARD (filename [MAIL])
BLANK
BUG
CHECK
CONTINUE
COPY (file-spec) (message-sequence [CURRENT]) [switch]
COUNT (message-sequence [ALL])
CREATE-INIT
DAYTIME
@U(D)ELETE (message-sequence [CURRENT])
DIRED (message-sequence [ALL])
DISABLE
ECHO (text)
EDIT (message-sequence [CURRENT])
ENABLE
EXAMINE (old-file)
@U(EX)IT
EXPUNGE
FILE-LIST (file-spec) (message-sequence [CURRENT]) [switches]
FLAG (message-sequence [CURRENT])
FORWARD (message-sequence [CURRENT])
FROM (address-list)
GET (old-file)
@U(H)EADERS (message-sequence [CURRENT])
HELP (topic)
JUMP (number)
KEYWORDS (keys) (message-sequence [CURRENT])
LIST (message-sequence [CURRENT]) [switches]
LITERAL-TYPE (message-sequence [CURRENT]) [switches]
LOGOUT
@U(MA)RK (message-sequence [CURRENT])
MOVE (file-spec) (message-sequence [CURRENT]) [switch]
NET-MAIL
@U(N)EXT
PREVIOUS
PROFILE
PUSH
QUIT
@U(R)EAD (message-sequence [NEW])
REMAIL (message-sequence [CURRENT])
REPLY (message-sequence [CURRENT])
REPLY-TO (address-list)
RESTORE-DRAFT (old-file) (switch [/TEXT])
@U(S)END [address-list]
SET (variable) (value)
SHOW
SORT (message-sequence [ALL])
STATUS
SYSTEM-MSGS
TAKE (old-file)
@U(T)YPE (message-sequence [CURRENT]) [switches]
UNANSWER (message-sequence [CURRENT])
@U(U)NDELETE (message-sequence [PREVIOUS-SEQUENCE])
UNFLAG (message-sequence [CURRENT])
UNKEYWORDS (keys) (message-sequence [CURRENT])
UNMARK (message-sequence [CURRENT])
VERSION
XPRESS (message-sequence [CURRENT]) [switches]
@End(Verbatim)

@AppendixSection(READ-mode Commands)
@IndexSecondary(Primary="Commands, READ-mode",Secondary="")
@Begin(Verbatim, Above 0.75,Below 0.75)
ANSWER [switches] [address-list]
BLANK
CONTINUE
COPY (file-spec) [switch]
DAYTIME
@U(D)ELETE
ECHO (text)
EDIT
FILE-LIST (file-spec) [switches]
FLAG
FORWARD [address-list]
@U(H)EADER
HELP (topic)
KEYWORDS (keys)
@U(L)IST [switches]
LITERAL-TYPE [switches]
MARK
@U(M)OVE (file-spec) [switch]
NET-MAIL
@U(N)EXT
@U(P)REVIOUS
PUSH
QUIT
REMAIL [address-list]
@U(R)EPLY [switches] [address-list]
@U(S)END [address-list]
SPELL
TAKE (old-file)
@U(T)YPE [switches]
UNANSWER
@U(U)NDELETE
UNFLAG
UNKEYWORDS (keys)
UNMARK
XPRESS [switches]
@End(Verbatim)

@AppendixSection(SEND-mode Commands)
@IndexSecondary(Primary="Commands, SEND-mode",Secondary="")
@Begin(Verbatim, Above 0.75,Below 0.75)
BCC (address-list)
BLANK
CC (address-list)
DAYTIME
@U(D)ISPLAY (field [ALL]) [switch]
ECHO (text)
EDIT (field [TEXT])
ERASE (field)
FCC (file-list)
FROM (address-list)
HELP (topic)
INSERT (old-file)
KEYWORDS (keywords)
LITERAL-TYPE [switch]
PUSH
QUIT
REMOVE (address-list)
REPLY-TO (address-list)
RESTORE-DRAFT (old-file) (switch [/COMMAND])
SAVE-DRAFT (file-spec)
@U(S)END
SPELL
SUBJECT (text)
TAKE (old-file)
TEXT
TO (address-list)
@U(T)YPE [switch]
UNKEYWORDS (keywords)
USER-HEADER (field) (text)
@End(Verbatim)

@AppendixSection(Rescan Commands)
@Index(Rescan commands)
@Begin(Verbatim, Above 0.75,Below 0.75)
ALIAS (user-name)
BBOARD (filename [MAIL])
BUG
EXAMINE (old-file)
GET (old-file)
HEADERS message-sequence [CURRENT])
@U(R)EAD (message-sequence [NEW])
RESTORE-DRAFT (old-file) (switch [/TEXT])
@U(S)END [address-list]
SYSTEM-MSGS
TAKE (old-file)
@U(T)YPE (message-sequence [CURRENT]) [switches]
@End(Verbatim)

@AppendixSection(Message-sequence Selectors)
@Index(Message-sequence)
@Begin(Verbatim, Above 0.75,Below 0.75)
.
%
AFTER (date)
@U(A)LL
ANSWERED
BEFORE (date)
CC-ME
@U(C)URRENT
DELETED
FLAGGED
@U(F)ROM (text)
FROM-ME
INVERSE
KEYWORDS (keys)
@U(L)AST (number)
LONGER (number)
NEW
ON (date)
PREVIOUS-SEQUENCE
RECENT
SEEN
SHORTER (number)
SINCE (date)
SUBJECT (text)
TEXT (text)
@U(T)O (text)
TO-ME
UNANSWERED
UNDELETED
UNFLAGGED
UNKEYWORDS (keys)
@U(U)NSEEN
@End(Verbatim)

@Appendix(Sample MM.INIT)

In the following example MM.INIT file, you will observe that some
variables are listed without values, and others are not present at all.
In those cases, MM will simply apply the default value.

@Begin(Verbatim, Above 0.75,Below 0.75)
BLANK-SCREEN-STARTUP 0
COMMAND-IMMEDIATE-WAKEUP 0
CONTROL-E-EDITOR 0
CONTROL-N-ABORT 0
DEFAULT-BCC-LIST 
DEFAULT-CC-LIST 
DEFAULT-FROM Dale S. Russell <Dale@@USC-ISIB>
DEFAULT-REPLY-TO
ESCAPE-AUTOMATIC-SEND -1
FLAGGED-MESSAGES-AUTOTYPE-SUPPRESS -1
GET-CONNECTED-DIRECTORY 0
HEADER-OPTIONS Phone: (213)822-1511
HEADER-OPTIONS Address: 4676 Admiralty Way; Marina del Rey; CA 90291
LIST-DEVICE LPT:MM.LST
LIST-INCLUDE-HEADERS -1
LIST-ON-SEPARATE-PAGES 0
MAIL-COPY-FILE PS:<DALE>MAIL.CPY
MAILER-IS-MTP 0
MESSAGE-SEQUENCE-PROMPT M>
NEW-FILE-PROTECTION 0
PERSONAL-NAME Dale S. Russell
PROMPT-FOR-BCC 0
READ-PROMPT R>
REPLY-CC-OTHERS 0
REPLY-INITIAL-DISPLAY 0
REPLY-REMOVE Dale@@USC-ISI*
REPLY-SENDER-ONLY-DEFAULT 0
RFC733-STYLE-HEADERS -1
RFC822-STYLE-HEADERS -1
SAVED-MESSAGES-FILE 
SEND-PROMPT S>
SEND-RETURN-SENDS -1
SEND-VERBOSE-FLAG 1
TOP-LEVEL-PROMPT MM>
USE-EDITOR-AUTOMATICALLY 0
USER-NAME Dale
@End(Verbatim)
   