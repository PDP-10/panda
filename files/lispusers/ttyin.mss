@comment{@PART(introduction, root "<csd.emycin.manual>manual.mss")}
@Define(Appendix=Heading)
@Define(PrefaceSection=Subheading)
@appendix(TTYIN: EMYCIN's Input Facility)

TTYIN is an Interlisp function to read input from the terminal.  It
features altmode completion, spelling correction, help facility, and
fancy editing, and can also serve as a glorified free text input
function.

@B{(TTYIN PROMPT SPLST HELP OPTIONS FILE TABSTOPS UNREADBUF)}

TTYIN prints PROMPT, then waits for input, terminated with crlf.  Value
returned is a list of all atoms on the line, with comma and parens
returned as individual atoms.

User may edit with ^A or RUBOUT to delete characters, ^Q or ^X to delete
the line [^U on TOPS20], ^W to delete a "word", and ^R to retype line.
Characters are deleted in accordance with the terminal typebackspace
on displays, backslashes otherwise.  Fancier editing is also available
on displays (see below).  Escape invokes tenex-style recognition on
the latest word typed, using SPLSTTTYIN will fill in as many
characters as are uniquely determined so far, or ring the bell.
@begin(description)

PROMPT@\ is an atom or string (anything else is stringified first).
    If NIL, the value of DEFAULTPROMPT, initially "** ", will be used.
    If T, no prompt will be given.  PROMPT may also be a dotted pair
    (prompt1 . prompt2), giving the prompt for the first and subsequent
    (or overflow) lines, each prompt being a string/atom or NIL to
    denote absence of prompt.  Note that rebinding DEFAULTPROMPT gives
    a convenient way to affect all the "ordinary" prompts in some 
    program module.

SPLST @\is a spelling list, i.e. atoms or dotted pairs (synonym . root).
    If supplied, it is used to check and correct user responses, and to
    provide completion if user types Escape.  If it is a Lisp-style
    spelling list (i.e. contains one of the funny SPELLSTR1/2
    separators), words that are escape-completed get moved to the
    front, just as if a FIXSPELL had found them.  Autocompletion is also
    performed when user types a break character (cr, space, paren, etc),
    unless one of the "nofixspell" options below is selected; i.e. if
    the word just typed would uniquely complete by Escape, TTYIN behaves
    as though Escape had been typed.

HELP@\If non-NIL, determines what happens when the user types ? or HELP.
If HELP = T, program prints back SPLST in suitable form.  If HELP
is any other atom, or a string containing no spaces, it performs
(DISPLAYHELP HELP).  Anything else is simply printed using a
function called SPRINTT, i.e., (SPRINTT HELP).  If HELP is
NIL, ? and HELP are treated as any other atoms the user types.
@foot[DISPLAYHELP and SPRINTT are EMYCIN functions not supplied in TTYIN
itself; they may be redefined to do different things in other
environments.] 

OPTIONS@\OPTIONS is an atom or list of atoms chosen from among the following:
@begin(description)

    NOFIXSPELL@\use SPLST for help and Escape completion, but do not
	attempt any FIXSPELLing.  Mainly useful if SPLST is incomplete
	and the caller wants to handle corrections in a more flexible
	way than a straight FIXSPELL.

    MUSTAPPROVE@\do spelling correction, but require confirmation.

    CRCOMPLETE@\require confirmation on spelling correction, but also
	do autocompletion on <cr> (i.e. if what user has typed so far
	uniquely identifies a member of SPLST, complete it).  This
	allows you to have the benefits of autocompletion and still
	allow new words to be typed.

    DIRECTORY@\(only if SPLST=NIL) interpret Escape to mean directory
	name completion.

    USER@\like DIRECTORY, but do username completion.  This is
	identical to DIRECTORY on TENEX.

    FILE@\(only if SPLST=NIL) interpret Escape to mean filename
	completion, i.e. do a GTJFN [TENEX and TOPS20 only].

    FIX@\if response is not on, or does not correct to, SPLST,
	interact with user until an acceptable response is entered.  A
	blank line (returning NIL) is always accepted.  Note that if you
	are willing to accept responses that are not on SPLST, you
	probably should specify one of the options NOXFISPELL,
	MUSTAPPROVE or CRCOMPLETE, lest the user's new response get
	fixspelled away without her approval.

    STRING@\line is read as a string, rather than list of atoms.
	Good for free text.

    NORAISE@\do not convert lower case letters to upper case.

    NOVALUE@\for use principally with FILE argument (below).  Does not
	compute a value, but returns T if user typed anything, NIL if
	just a blank line.

    REPEAT@\for multi-line input.  Repeatedly prompts until user
	types ^Z (as in sndmsg).  Returns one long list; with STRING
	option returns a single string of everything typed, with
	carriage returns (EOL) included in the string.

    TEXT@\implies REPEAT NORAISE NOVALUE; additionally, input may be
	terminated with ^V, in which case the global flag CTRLVFLG
	will be set true (it is set to NIL on any other termination).
@comment(This flag may be utilized in any way the caller desires (it is
	mainly a hack I put into some Emycin fns to allow the user to
	call a text editor on what's been typed so far)

    COMMAND@\only the first word on the line is treated as belonging
	to SPLST, the remainder of the line being arbitrary text; i.e.
	"command format".  If other options are supplied, COMMAND
	still applies to the first word typed.  Basically, it always
	returns (cmd . rest-of-input), where rest-of-input is whatever
	the other options dictate for the remainder.  For example, COMMAND
	NOVALUE returns (cmd) or (cmd . T), depending on whether there
	was further input; COMMAND STRING returns (command . "rest of
	input").  When used with REPEAT, COMMAND is only in effect for
	the first line typed; furthermore, if the first line consists
	solely of a command, the REPEAT is ignored, i.e. the entire
	input is taken to be just the command.

    READ@\parens, brackets, and quotes are treated a la READ, rather
	than being returned as individual atoms.  Control chars may be
	input via the ^V<x> notation.  Input is terminated roughly along
	the lines of Lisp READ conventions:  a balancing or
	over-balancing right paren/bracket will activate the input, or
	<cr> when no parens remain open.  READ overrides all other
	options (except NORAISE).

    LISPXREAD@\like READ, but implies that TTYIN should behave even
	more like a Lisp READ, i.e. do NORAISE, not be
	errorset-protected, etc.

    EVALQT@\like LISPXREAD, but with the added convention that the
	input "atom]" is read as "atom NIL", consistent with EVALQT
	convention; for use in a LISPXREADFN (see below).
@end(description)

FILE@\if specified, user's input is copied to this file, i.e. TTYIN can
    be used as a glorious COPY TTY: (to) file if NOVALUE is used.  If
    FILE is a list, copies to all files in list.  PROMPT(s) are not
    included on the file.

TABSTOPS@\special addition for tabular input.  Is list of tabstops
    (numbers).  When user types a tab, TTYIN automatically spaces over
    to next tabstop (thus the first tabstop is actually the second
    "column" of input).  Also treats specially the characters * and
    "they echo normally, and then automatically tab over.

UNREADBUF@\allows caller to "preload" the TTYIN buffer with a line of
    input.  UNREADBUF is a list, the elements of which are unread into
    the buffer (i.e. "the outer parens are stripped off") to be edited
    further as desired; a simple <cr> (or ^Z for REPEAT input) will thus
    cause the buffer's contents to be returned unchanged.  If doing READ
    input, the "prin2 pnames" of the input list are used, i.e. quotes
    and %'s will appear as needed; otherwise the buffer will look as
    though UNREADBUF had been PRIN1'ed.  UNREADBUF is treated somewhat
    like Lisp's READBUF, so that if it contains a pseudo-cr (the value
    of HISTSTR0), the input line terminates there.

@\Input can also be unread from a file, using the histstr1 format:
    UNREADBUF = (<value of HISTSTR1> (file start . end)), where start
    and end are file byte pointers.  This makes TTYIN a mini-TVEDIT.
@end(description)

If the global variable TYPEAHEADFLG is T, or option LISPXREAD is given,
TTYIN permits type-ahead; otherwise it clears the buffer before
prompting the user.

During TEXT and READ input, TTYIN is in "autofill" mode: if a space is
typed near the right margin, a <cr> is simulated to start a new line.
This discourages run-on lines (in fact, on cursor-addressable displays,
autofill also takes over if you type past the last column even without
having typed a space recently).  The "pseudo-<cr>" is still read as a
space, however; i.e. the program keeps track of whether a line ends in a
<cr> or is merely broken at some convenient pointyou won't get <cr>'s
in your strings unless you explicitly type them.  Similarly, the J
command (below) will not create <cr>s.

In addition to the simple editing chars (delete, ^W, ^Q) the following
exist for all terminals:
@begin(description)
^R@\refreshes current line.  Two in a row refreshes the whole
	buffer (when doing multi-line input).

<esc>@\when SPLST is provided, tries to complete the current word
	from it, or complete as far as is uniquely determined on
	SPLST.  If SPLST is NIL, but the word begins with a "<", tries
	directory name completion (or filename if there is already a
	matching ">" in the current word).

^F@\invokes GTJFN completion on current "word".

?@\if typed in the middle of a word will supply alternative
	completions from SPLST (if any).  ?ACTIVATEFLG must be true to
	enable this feature.

^Y@\escapes to a Lisp USEREXEC, from which you may return by the
	command OK.  This is simpler and faster than going into a break.
	However, when in READ mode, ^Y is treated as Lisp's unquote
	macro instead (if there is anything in the buffer), so you have
	to use edit-^Y (below) to invoke the userexec.

lf@\retrieves characters from the previous buffer (sometimes);
	That is, a linefeed at the beginning of the line echoes as the
	previous line you typed at TTYIN, while a linefeed in the
	middle of a line leaves you with some new line, the rest old.
	Any intervening blank lines are ignored.

;@\if typed as the first character of the line means the line is a
	comment; it is ignored, and TTYIN loops back for more input.
@end(description)

@prefacesection(Special Display Handling)

If you're on a display, TTYIN reads from the terminal in binary mode,
allowing many more editing commands via the edit key, in the style of
TVEDIT/EMACS commands (assuming your display has an edit key; see
"Display types" below for more details).  Most commands can be preceded
by numbers or escape (infinity), only the first of which requires the
edit key.  Some commands also accept negative arguments, but some only
look at the magnitude of the arg.  Note that due to Tenex's unfortunate
way of handling typeahead, it is not possible to type ahead edit
commands before TTYIN has started (i.e. before its prompt appears),
because the edit bit will be thrown away (except see note under
TYPEAHEADFLG below).  Also, since Escape (altmode) has numerous other
meanings in Lisp and even in TTYIN (for completion), Escape is not used
as a substitute for the edit key.

In the descriptions below, "current word" means the word the cursor is
under, or if under a space, the previous word.  Currently parens are
treated as spaces, which is usually what you want, but can occasionally
cause confusion in the word deletion commands.

The following edit commands are roughly the same as in TVEDIT:
@verbatim{
	< > ( ) ^ lf space del K
}

In addition, the following new or modified commands exist ([char] means
edit-char; $ = escape):
@begin(description)
[tab]@\moves to end of line; with an argument moves to nth end of
	line; [$tab] goes to end of buffer.

[^L]@\moves to start of line (or nth previous, or start of buffer).

[{] and [}]@\go to start and end of buffer, respectively (like [$^L]
	and [$tab]).

[S]<x> and [Z]<x>@\Skip or Zap (i.e., kill) to text  until the next
instance of <x>.

[B]@\is a backward search, i.e. short for [-S] or [-nS].

[A]@\(or [R] for E hackers) repeat the last S, B or Z command,
	regardless of any intervening input (note this differs from
	TVEDIT's A command).

[I]@\begin inserting.  Exit insert with any edit command.  Inserting
	<cr> behaves slightly different from in TVEDIT; the sequence
	[I<cr>] behaves as in TVEDIT -- it inserts a blank line ahead of
	the cursor; <cr> typed any other time while in insert mode
	actually inserts a <cr>, behaving somewhat like TV's [B].  [$I]
	is the same as [I<cr>].

[cr]@\when the buffer is empty is the same as <lf>, i.e. restores
	buffer's previous contents.  Otherwise is just like a <cr>
	(except that it also terminates an insert).  Thus, [<cr><cr>]
	will repeat the previous input (as will <lf><cr> without the
	edit key).

[O]@\does "Open line", inserting a crlf AFTER the cursor, i.e. it
	breaks the line but leaves the cursor where it is.

[T]@\transposes the characters before and after the cursor.  When
	typed at the end of a line, transposes the previous two
	characters.  Refuses to handle funny cases, such as tabs.

[G]@\grabs the contents of the previous line from the cursor
	position onward.  [nG] grabs the nth previous line.

[L]@\lowercases current word, or n words on line.  [$L] lowercases the
	rest of the line, or if given at the end of line lowercases the
	entire line.

[U]@\uppercases analogously.

[C]@\capitalize.  If you give it an argument, only the first word is
	capitalized; the rest are just lowercased.

[^Q]@\deletes the current line.  [$^Q] deletes from the current
	cursor position to the end of the buffer.  No other arguments
	are handled.  This is all slightly inconsistent; suggestions
	for better interpretations are welcome.

[^W]@\deletes the current word, or the previous word if sitting on a
	space.

[D<del>] and [D<cr>]@\are [^W] and [^Q] for approximate
	compatibility with tvedit.

[[]@\(i.e. edit-left-bracket) Moves to beginning of the current
	list, where cursor is currently under an element of that list or
	its closing paren.  (See also the auto-parenthesis-matching
	feature below under "Flags".)

[]@\ Moves to end of current list.

[J]@\"Justify" this line, defined as breaking it if it is too long,
	or moving words up from the next line if too short.  Will not
	join to an empty line, or one starting with a tab (both of
	which are interpreted as paragraph breaks).  [nJ] justifies n
	lines.  Linelength is defined as TTYJUSTLENGTH, ignoring any
	prompt characters at the margin.  TTYJUSTLENGTH is initially 72.

[N]@\Refresh line -- same as ^R.  [$N] refreshes the whole buffer;
	[nN] refreshes n lines.  Cursor movement in TTYIN depends on
	TTYIN being the only source of output to the screen; if you do a
	^T, or a system message appears, or line noise occurs, you may
	need to refresh the line for best results.  If for some reason
	your terminal falls out of binary mode (e.g. can happen when
	returning to a Lisp running in a lower fork), Edit-<anything> is
	unreadable, so you'd have to type ^R instead.

[$F]@\"Finishes" the input, regardless of where the cursor is.
	Specifically, it goes to the end of the input and enters a
	<cr>, ^Z or "]", depending on whether normal, REPEAT or READ
	input is happening.  [Note that a "]" won't necessarily end a
	READ, but it seems likely to in most cases where you would be
	inclined to use this command, and makes for more predictable
	behavior.]

[^Y]@\gets USEREXEC.  When doing a READ, and the buffer is non-empty,
	a regular ^Y echoes as itself to implement the ^Y read macro, so
	you need the edit key down to get this function.

[$^Y]@\gets a USEREXEC, but first unreads the contents of the buffer
	from the cursor onward.  Thus if you typed at TTYIN something
	destined for Lisp, you can do [^L$^Y] and give it to Lisp.

[_]@\adds current word to spelling list USERWORDS.  With zero arg,
	removes word.  See TTYINCOMPLETEFLG discussion below.
@end(description)

In addition to simple cursor movement commands and insert/delete, TTYIN
uses the display's cursor-addressing capability to optimize cursor
movements longer than a few characters, e.g. [tab] to go to the end of
the line.  In order to be able to address the cursor, TTYIN has to know
where it is to begin with.  Lisp keeps track of the current print
position within the line, but does not keep track of the line on the
screen (in fact, it knows precious little about displays, much like
Tenex).  Thus, TTYIN establishes where it is by @i(forcing) the cursor to
appear on the last line of the screen.  Ordinarily this is the case
anyway (except possibly on startup), but if the cursor happens to be
only halfway down the screen at the time, there is a possibly unsettling
leap of the cursor.
@newpage
@prefacesection(Using TTYIN for Lisp Input)


TTYIN's capabilities can be used in ordinary Lisp input by setting the
variable LISPXREADFN to TTYINREAD (i.e. this "redefines" READ for
LISPX).  This happens automatically when TTYIN is loaded, or a sysout is
started up if the terminal is a display (the function (SETREADFN) does
this; if the terminal is non-display, SETREADFN will set the variable
back to READ, so sysouts will start up correctly).

TTYINREAD is defined to call TTYIN with OPTIONS of EVALQT and a
PROMPT suitable for the current Lisp prompt char.  The main differences
between this and Lisp READ are (1) the input does not activate on an
exactly balancing right paren/bracket unless the input started with a
paren/bracket, e.g. "USE (FOO) FOR (FIE)" will all be on one line,
terminated by <cr>; and (2) there is no read table (TTYIN behaves as
though using the default initial Lisp terminal input readtable), so read
macros and redefinition of syntax characters are not supported; however,
"'" (QUOTE) and "^Y" (EVAL) are built in, and a simple implementation of
? and ?= is supplied.  Also, the TTYINREADMACROS facility described
below can accomplish some of this.

Additionally, the edit macro ED loads the current expression into the
ttyin buffer to be edited (good for editing comments and strings).  ^E
or clearing the buffer will abort ED.  The macro BUF loads the current
expression into the buffer, preceded by E, to be used as input however
desired; as a trivial example, to evaluate the current expression, BUF
followed by a <cr> to activate the buffer will do.  Of course, you can
edit the E to something else to make it an edit command.

BUF is also defined as a LISPXHISTORYMACRO which loads the buffer with
the VALUEOF the indicated event, to be edited as desired.  TV is a
Lispxmacro like EV [EDITV] which performs an ED on the value of the
variable.

And finally, if the event is considered "short" enough, the command FIX
will load the buffer with the event's input, rather than calling the
editor.


@prefacesection(Read Macros)


When doing READ input, no Lisp-style read macros are available (but the
' and ^Y macros are built in).  Principally because of the usefulness of
the editor read macros (set by Lisp's SETTERMCHARS), the following
exists as a hack:
@begin(description)

TTYINREADMACROS@\this is a set of shorthand inputs useable during
    READ input.  It is an alist of entries (charcode . synonym).  If
    the user types the indicated char (edit bit is denoted by the 200Q
    bit in charcode), TTYIN behaves as though the synonym character had
    been typed.  Special cases: 0the character is ignored; 
200Qpure Edit bit; means to read another char and turn on its edit bit;
    400Qmacro quote: read another char and use its original meaning.
    E.g. if you have macros ((33Q . 200Q) (30Q . 33Q)), then Escape
    (33Q) will behave as an edit prefix, and ^X (30Q) will behave like
    Escape. @foot[Currently, synonyms for edit commands are not
    well-supported, working only when the command is typed with no
    argument.] 

@\Slightly more powerful macros also exist; they occur when a
    character is typed on an empty line, i.e. as the first thing after
    the prompt.  In this case, the TTYINREADMACROS entry is of the form
    (charcode T . response) or (charcode condition . response), where
    condition is a List that evaluates true.  If "response" is a list,
    it is EVALed; otherwise it is left unevaluated.  The result of this
    invocation is treated as follows:

NIL@\the macro is ignored and the character reads normally, i.e. as
	though TTYINREADMACROS had never existed.

Integer@\a character code, treated as above.  Special case: -1like
        0, but says that the display may have been altered in the 
	evaluation of the macro, so TTYIN should reset itself appropriately.

Anything else@\this TTYIN input is terminated (with a crlf) and
	returns the value of "response" (listified if necessary).  This
	is the principal use of this facilitythe macro character
	thus stands for the (possibly computed) reponse, terminated if
	necessary with a crlf.  The original character is not echoed.

@\Interrupt characters, of course, cannot be read macros, as TTYIN
    never sees them, but any other characters, even non-control chars,
    are allowed.  The ability to return NIL allows you to have
    conditional macros, which only apply in specified situations (e.g.
    the macro might check the prompt (LISPXID) or other contextual
    variables).  This is used by CHARMACRO? (below) to implement the
    editor read macros.

(CHARMACRO? EDITCOM)@\NLAMBDA function to serve as a TTYIN macro.
    If the macro was typed to the Lisp editor (identified by prompt
    "*"), clears the output buffer and returns its argument; returns NIL
    in any other case.  This effectively mimics the behavior of the edit
    readmacros (except that they only work at the start of a line (which
    tends to be the most useful time anyway)); e.g. you could implement
    the <lf> macro by putting (12Q T . (CHARMACRO? NXP)) on
    TTYINREADMACROS.

@\Note that (12Q T . NXP) would also have the effect of returning "NXP" from
    the READ call so that the editor would do an NXP; however, TTYIN
    would also return NXP outside the editor (probably resulting in a
    u.b.a. error, or convincing dwim to enter the editor), and also the
    clearing of the output buffer would not happen.
@end(description)
@newpage
@prefacesection(Display Types)


TTYIN determines the type of display by calling (DISPLAYTERMP), which is
initially defined to test the value of the GTTYP jsys.  It returns
either NIL (for printing terminals) or a small number giving TTYIN's
internal code for the terminal type.  The types TTYIN currently knows
about:
@begin(description)
0@\glass tty (capable of deleting chars by backspacing, but
		little else);

1@\Datamedia;

2@\Heath.
@end(description)

Only the Datamedia has full editing power.  DISPLAYTERMP has built into
it the correct terminal types for Sumex and Stanford campus 20's: DM =
11 on tenex, 5 on tops20; Heath = 18 on Tenex, 25 on tops20.  You can
override those values by setting the variable DISPLAYTYPES to be an
alist associating the GTTYP value with one of these internal codes.
For example, Sumex displays correspond to DISPLAYTYPES = ((11 . 1) (18 .
2))
[although this is actually compiled into DISPLAYTERMP for speed].
Any display terminal other than DM and Heath can probably safely be
assigned to "0" for glass tty.

To add new terminal types, you have to choose a number for it, add new
code to TTYIN for it and recompile.  The TTYIN code specifies what the
capabilities of the terminal are, and how to do the primitive
operations: up, down, left, right, address cursor, erase screen, erase
to end of line, insert character, etc.

For terminals lacking an Edit key (currently only dm's have it), set the
variable EDITPREFIXCHAR to the ascii code of an Edit "prefix" (i.e.
anything typed preceded by the prefix is considered to have the edit bit
on).  If your EDITPREFIXCHAR is 33Q (Escape), you can type a real Escape
by typing 3 of them (2 won't do, since that means "Edit-Escape", a
legitimate argument to another command).  You could also define an
Escape synonym with TTYINREADMACROS if you wanted (but currently it
doesn't work in filename completion).  Setting EDITPREFIXCHAR for a
terminal that is not equipped to handle the full range of editing
functions (only the Heath is currently so equipped) is not guaranteed to
work, i.e. the display will not always be up to date; but if you can
keep track of what you're doing, together with an occasional ^R to help
out, go right ahead. For Heaths we suggest backspace as the
EDITPREFIXCHAR edit key (10Q).
@newpage
@prefacesection(Assorted Flags)

These flags control aspects of TTYIN's behavior.  Some have already been
mentioned.  Their initial values are all NIL.
@begin(description)

TYPEAHEADFLG@\if true, TTYIN always permits typeahead; otherwise it
	clears the buffer for any but LISPXREAD input.  If TYPEAHEADFLG
	is the atom ALWAYS and you're using TTYIN for LISPXREAD, TTYIN
	will leave your terminal in binary mode, rather than take it in
	and out of binary mode for each input.  This is slightly faster
	and also allows you to type ahead edit commands; however, it
	also means Lisp does its output in binary mode, which may
	occasionally cause problems (control characters are not visible,
	and may even be interpreted as display commands by the terminal;
	the TAB character will misbehave if your terminal doesn't know
	about Tabs (Heath does, normal datamedias don't)).  Also, Lisp
	may take you out of binary mode without warning, since it
	doesn't know about it (e.g. ASKUSER will do this).

?ACTIVATEFLG@\if true, enables the feature whereby ? lists alternate
	completions from the current spelling list.

EMACSFLG@\affects display editing.  When true, TTYIN tries to behave
	a little more like EMACS (vanMelle style) than TVEDIT.
	Specifically, it has the following effects currently:
	(1) all non-edit characters self-insert (i.e. behave as if
	you're always in Insert mode); (2) [D] is the EMACS delete to
	end of word command.

TTYINMAILFLG@\when true, performs mail checking, etc. before most
	inputs (except EVALQT inputs, where it is assumed this has
	already been done, or inputs indented by more than a few
	spaces).  MAILWATCH package must be loaded for this (works on
	Tenex only).

SHOWPARENFLG@\if true, then whenever you are typing Lisp input
	and type a right paren/bracket, TTYIN will briefly move the
	cursor to the matching paren/bracket, assuming it is still on
	the screen.  The cursor stays there for about 1 second (or the
	value of SHOWPARENFLG), or until you type another character
	(i.e. if you type fast you'll never notice it).  This feature
	was inspired by a similar EMACS feature, and turned out to be
	pretty easy to implement.

TTYINRESPONSES@\an alist of special responses that will be handled by
	routines designated by the programmer.  See "Special Responses",
	below.

TTYINCOMPLETEFLG@\if true, enables Escape completion from USERWORDS
	during READ inputs.  Read on for details:
@end(description)

USERWORDS, as described in the dwim chapter, contains words you
mentioned recently: functions you have defined or edited, variables you
have set or evaluated at the evalqt level, etc.  This happens to be a
very convenient list for context-free escape completion; if you have
recently edited a function, chances are good you may want to edit it
again (typing "EF xx$") or type a call to it.  If there is no completion
for the current word from USERWORDS, the escape echoes as "$", i.e.
nothing special happens; if there is more than one possible completion,
you get beeped.  If there is no current word, Escape completes to the
value of LASTWORD, i.e. the last thing you typed that the p.a. "noticed"
(setting TTYINCOMPLETEFLG to 0 disables this latter feature), except
that Escape at the beginning of the line is left alone (it is a p.a.
command; see 22.19 of the Interlisp manual).

If you really wanted to enter an escape, you can, of course, just quote
it with a ^V, like you can other control chars.

You may explicitly add words to USERWORDS yourself that wouldn't get
there otherwise.  To make this convenient online I have added the edit
command [_] to mean "add the current atom to USERWORDS" (I view it as
"pointing out this atom") -- e.g. you might be entering a function
definition and want to "point to" one or more of its arguments or prog
variables.  Giving an argument of zero to this command will instead
remove the indicated atom from USERWORDS.

Note that this feature loses some of its value if the spelling list is
too long, for then the completion takes too long computationally and,
more important, there are too many alternative completions for you to
get by with typing a few characters followed by escape.  Lisp's
maintenance of the spelling list USERWORDS keeps the "temporary" section
(which is where everything goes initially unless you say otherwise)
limited to #USERWORDS atoms, initially 100.  Words fall off the end if
they haven't been used (they are "used" if FIXSPELL corrects to one, or
you use <escape> to complete one).
@newpage
@prefacesection(Special Responses)

There is a facility for handling "special responses" during @i(any) TTYIN
input.  This action is independent of the particular call to TTYIN, and
exists to allow you to effectively "advise" TTYIN to intercept certain
commands.  After the command is processed, control returns to the
original TTYIN call.  The facility is implemented via the list
TTYINRESPONSES.

TTYINRESPONSES is a list of elements, each of the form
@verbatim{
	(commands response-form [LINE | STRING])
}
where commands is a single atom or list of commands to be recognized;
response-form is EVALed (if a list), or APPLYed (if atom) to the command
and the rest of the line.  Variables COMMAND and LINE refer to the
command the user typed and the rest of the line.  LINE option means pass
rest of line as a list; STRING means pass it as a string; if neither is
specified, the command is only valid if there is nothing else on the
line.  If the response form returns IGNORE, it is not treated as a
special response (i.e. the input is returned normally as the result of
TTYIN).

In MYCIN, the COMMENT command is handled this way; any time the user
types COMMENT as the first word of input, TTYIN passes the rest of the
line to a MYCIN-defined function which prompts for the text of the
comment (recursively using TTYIN with the TEXT option).  When control
returns, TTYIN goes back and prompts for the original input again.  The
TTYINRESPONSES entry for this is (COMMENT (GRIPE LINE) LIST); GRIPE is a
MYCIN function of one argument (the one-line comment, or NIL for
extended comments).

Suggested use: global commands or options can be added to the toplevel
value of TTYINRESPONSES.  For more specialized commands, rebind
TTYINRESPONSES to (APPEND '(your entries) TTYINRESPONSES) inside any
module where you want to do this sort of special processing.

Special responses are not checked for during READ-style input.
  