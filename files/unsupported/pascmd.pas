{Copyright (c) 1982, Charles L. Hedrick

Distribution and use of this software is subject to conditions described
in the Installation Document.}

const {declarations to help using break masks}

 {Standard Field break mask
  all control chars, space through comma, dot, slash, 
  colon through question mark, atsign, open bracket through accent grave,
  and close bracket through tilde}
    fldb0=777777777760B;
    fldb1=777754001760B;
    fldb2=400000000760B;
    fldb3=400000000760B;

 {Keyword break set.  Same as standard field for now}
    keyb0=777777777760B;
    keyb1=777754001760B;
    keyb2=400000000760B;
    keyb3=400000000760B;

 {Username break set.  Breaks on everything except dot and alphabetics.}
    usrb0=777777777760B;
    usrb1=747544001760B;
    usrb2=400000000740B;
    usrb3=400000000760B;

 {Account mask currently the same as user mask}
    actb0=777777777760B;
    actb1=747544001760B;
    actb2=400000000740B;
    actb3=400000000760B;

 {Filespec field - filespec punctuation characters are legal ( :, <, >, ., ;)}
    filb0=777777777760B;
    filb1=74544000120B;
    filb2=400000000240B;
    filb3=400000000760B;

 {Read Device Name - like standard field, but allow dollarsign and underscore}
    devb0=777777777760B;
    devb1=757754001760B;
    devb2=400000000740B;
    devb3=400000000760B;

 {Read To End Of Line - break on linefeed and carraige return}
    eolb0=000220000000B;
    eolb1=000000000000B;
    eolb2=000000000000B;
    eolb3=000000000000B;

type
 t=array[0:100]of integer;
 table=^t;
 tadrec=packed record
	year:0..777777B; month:0..777777B;
	dayofmonth:0..777777B; dayofweek:0..777777B;
	zoneused:boolean;
	daylightsavings:boolean;
	zoneinput:boolean;
	julianday:boolean;
	dum:0..377B;
	zone:0..77B;
	seconds:0..777777B
	end;
 cmmodes=(normal,rescan);
 brkmsk=array [0..3] of integer;
	
procedure cmini(prompt:string);extern;
  {Use this procedure first.  It will issue the prompt, and set things
   up for reparsing in case of errors.  Beware that if an error occurs
   in any of the other CM functions, control may be returned to the
   statement after the CMINI.  Effectively this is done with a non-local
   GOTO.  Thus the code between the CMINI and the end of the parse must
   be designed so that it can be restarted.  Also, you must not exit the
   block in which the CMINI is issued until the entire parse is done.
   Since control will be returned to the CMINI in case of an error, it
   would cause serious troubles if that block was no longer active. }

procedure cminir(prompt:string);extern;
{Special version of CMINI to be used when you want to read a rescanned
   command from the EXEC.  If this is done in a loop, the second time
   it is done, the program exits.}

procedure cmfni(prompt: string; flag:integer); extern;
procedure cmfnir(prompt: string; flag:integer); extern;
{Special versions of CMINI and CMINIR.  The left half of FLAG is set in
    the .CMFLG word of the COMND JSYS state block.  This is needed when
    you want to set CM%RAI, CM%XIF, or CM%WKF}

function cmmode:cmmodes;extern;
{Says what "mode" we are running in.  At the moment normal or rescan.
   Rescan means that a CMINIR succeeded in finding valid rescanned data.}

procedure cmrscn; extern;
{Clears the RSCANF flag saying whether a RSCAN was done by CMINIR so
    the next time CMINIR is called it will try for a rescaned command
    again.  The old value of RSCANF is returned. }

{The following two procedures are used in making up tables of commands
 and switches.  Note that tables and their contents are stored in the
 heap.  So you can use MARK and RELEASE to release them.}
function tbmak(size:integer):table;extern;
    {Issue this one first.  It allocates space for a table with the
     specified number of entries.  It returns a table pointer,
     which is used for the other functions that operate on tables.}
procedure tbadd(t:table;value:integer;key:string;bits:integer);extern;
    {Issue this once for each entry to go in the table.
	T - the value return by the call to TBMAK that allocated the table.
	VALUE - This is the value that will be returned when this entry
		in the table is found.
	KEY - This string is the name of the table entry.
	BITS - as documented in the JSYS manual.  Normally zero.
     For example, one entry in a table of terminal types might be
	tbadd( termtable, 6, 'I400', 0)
     This entry will be matched by the string 'I400' (or any unique
     abbreviation), and will return the value 6, presumably the internal
     code for the I400 terminal.}
  {WARNING:  You must issue these in reverse alphabetical order, i.e.
   the last entry in the table must be done first.  This may be a
   monitor bug.}

{The following procedures are used to parse individual fields in a command.
 They should be issued in the same order that the user is expected to
 type the fields.}

function cmkey(t:table):integer;extern;
   {Expects the user to type one of the keywords in the table.  It returns
    the value that was specified by TBADD when the keyword was put in the
    table.  E.g. if the user typed I400, this would return 6 if the
    table had the entry shown above.}

function cmswi(t:table):integer;extern;
   {Similar to cmkey, except the table is of switches.  The slash should
    not be part of the name in the table.

    If the user ended the switch with a colon (i.e. you can
    expect a value after the switch), the negative of the value 
    normally returned will be returned.}

procedure cmifi(var f:file);extern;
   {Expects the user to type an input file name.  The argument should
    be a Pascal file.  That file will be preset to use the file specified.
    E.g. if you say CMIFI(INPUT), you can then use RESET(INPUT) and INPUT
    will be open on the file that the user specified.  This function
    actually gets a jfn for the file specified by the user.  That jfn is
    then stored in the file's file control block.}

procedure cmofi(var f:file);extern;
   {Expects an output file name.}

procedure cmfil(var f:file);extern;
   {Expects a general file spec.  You must set up an extended gtjfn
    block appropriately to read the file spec.  This is done with
    the gjxxx procedures below.  At least gjgen must be used.}

function cmnum:integer; extern;
   {Get a decimal number.}

function cmnum8:integer; extern;
   {Get an octal number.}

function cmnux:integer; extern;
   {Get a decimal number, ends with any non-numeric}

function cmnux8:integer; extern;
   {Get an octal number, ends with any non-numeric}

function cmflt:real; extern;
   {Get a real number}

procedure cmnoi(stuff:string);extern;
   {Puts out a noise word if the user types altmode.  Note that the
    parentheses are not part of the noise word.}

procedure cmcfm; extern;
   {Expects the user to type a carriage return.  This would usually be
    the last call made for parsing a command.}

procedure cmcma; extern;
   {Expects the user to type a comma.  If this is for an optional
    field, you should set CMAUTO(false) first, to prevent an error
    trap if there isn't one.}

procedure cmtok(stuff:string);extern;
   {Expects the user to type that particular thing.  See cmcma.}

procedure cmctok(c:char);extern;
   {like CMTOK, but takes a single character instead of a string.}

function cmdir:integer; extern;
   {Expects a directory name: returns the 36-bit dir. number.  To
    see the text, use CMATOM.}

function cmdirw:integer; extern;
   {as above, but allows wildcards}

function cmusr:integer; extern;
   {Expects a user name:  returns a 36-bit user number.(CMATOM for text)}

function cmdev:integer; extern;
   {Expects a device name:  returns a device designator (CMATOM for text)}

{The following functions parse date and/or time.  We have the following
 method:
   TAD - both date and time       null - returns internal form
   T - time only		  N - puts unconverted form into a record
   D - date only}

function cmtad:integer; extern;
function cmt:integer; extern;
function cmd:integer; extern;
procedure cmtadn(var r:tadrec); extern;
procedure cmtn(var r:tadrec); extern;
procedure cmdn(var r:tadrec); extern;

{The following procedures all return strings where you specify, and
 a count indicating how many characters were actually seen.  Any
 extra characters in the destination array are filled with blanks.
 If there is not enough space, an error message is given and a
 reparse triggered.}

function cmatom(var s:string):integer; extern;
   {This returns the contents of the "atom buffer".  It is useful when
    you want to see what the user actually typed for the last field.  It
    not cause any extra parsing, the data comes from the last field parsed.}

function cmfld(var s:string):integer; extern;
   {Field delimited by first non-alphanumeric}

function cmtxt(var s:string):integer; extern;
   {To next end of line}

function cmqst(var s:string):integer; extern;
   {String in double quotes.  Quotes not returned.}

function cmuqs(var s: string; break_mask: brkmsk; var b: char):integer;
extern;
   {Unquoted string.  NOTE: Do NOT use CMBRK to set the break mask for
    this function.  Use the second argument provided for that task.
    The third argument has the break character that was used returned in
    it.  This doesn't seem to work for some special characters (like escape)
    also you might want to set the CM%WKF bit in the comnd state block to
    cause a wakeup on each field while parsing.  See CMFIN procedure for
    how to do that.}

function cmact(var s:string):integer; extern;
   {Account string.  Not verified for legality}

function cmnod(var s:string):integer; extern;
   {network node name.  Not verified for legality}

{The following procedures are used to set up the extended gtjfn block
 for cmfil.  They must be given before the cmfil call.  gjgen must 
 always be used, and must be the first one of these to be called, as
 it clears the rest of the block.  These procedures simply set the
 corresponding words in the gtjfn block, so see the jsys manual for
 details.}

procedure gjgen(flags_and_generation:integer);extern;

procedure gjdev(default_device:string);extern;

procedure gjdir(default_directory:string);extern;

procedure gjnam(default_name:string);extern;

procedure gjext(default_extension:string);extern;

procedure gjpro(default_protectin:string);extern;

procedure gjact(default_account:string);extern;

procedure gjjfn(try_to_use_this_jfn:integer);extern;


{The following procedures are only needed for more complex parsers.
 They allow one to turn off various of the features that are normally
 supplied by default.}

procedure cmauto(useauto:Boolean);extern;
   {Turn on or off automatic error processing.  It is turned on by default.

    When automatic error processing is in effect, if the user does not
    type what is requested, an error message is issued and the prompt is
    reissued.  At that point he can either type a new command, or type
    ^H to have the old command repeated up to the point of the error.  
    Thus in the normal mode, the programmer does not need to worry about
    errors.  Reparsing is done until the user types something valid.

    When automatic error processing has been turned off, no automatic
    reparsing is done for errors.  Instead the procedure that was trying
    to read the field returns with a null value (if any).  The user is
    expected to check for errors with cmerr.  This is useful in the
    case where there are several valid responses.  For example suppose
    either a keyword or a file is valid.  Then you could do
      cmauto(false);  % turn off error handling \
      cmifi(input);
      if cmerr % wasn't a valid file \
        then key := cmkey(keytable);
    In general one should probably turn cmauto back on before trying
    the last alternative, so that a reparse is done if it isn't valid.

    Note that even with cmauto false, some automatic reparses are still
    done if the user backspaces into a previously parsed fields.  cmauto
    only controls what happens on a genuine error.

    cmini reinitializes cmauto to true.}
   
function cmerr:Boolean; extern;
   {Returns true if the most recent parse call got an error.}

procedure cmagain; extern;
   {Abort the current parse, reissue the prompt and try again.  If
    cmauto is in effect, this is done automatically whenever there is
    an error.  Note that cmagain does not print an error message.
    It is assumed that if you want the normal error message, you will
    turn on cmauto and let everything happen automatically.}

procedure cmuerr(s:string); extern;
   {Print ?, clear the input buffer, print the string supplied,
    and call cmagain.  This is equivalent to the usual error
    processing, but with a user-supplied error message.}

procedure cmerrmsg; extern;
   {This prints the official error message from the last failure.
    This followed by cmagain is equivalent to the usual error processing.}

function cmeof(trap: boolean):boolean; extern;
   {This function is used to trap end of file conditions detected by the
    COMND jsys.  If TRAP is TRUE then the next eof will cause a reparse
    (instead of an illegal instruction trap) and cmeof will return true
    to indicate that the eof has happened.  Use of this is as followes:
	CMINI('prompt');
	IF CMEOF(TRUE) THEN eof_code;
	normal parsing stuff

    NOTE: Because a reparse is done when the error is seen, you should
    place the call to CMEOF just after your call to CMINI (or CMINIR)
    and before ANY CALLES TO OTHER PROCEDURES IN THIS PACKAGE.  If you
    fail to do this the program will go into an infinite loop. }

function cmioj(newjfns: integer):integer; extern;
   {This function sets .CMIOJ of the COMND state block to NEWJFNS and
    returns the old value of that word.  This is useful for "pushing"
    the current JFNs.}

procedure cmhlp(helptext:string); extern;
   {Used to supply your own help message when the user types ?.  The
    text given will be used for the next field parsed.  To supply a
    message taking up more than one line, just call cmhlp several
    times.  Each call will add a line to the message.  (Thus cmhlp
    is vaguely like writeln.)  Note that the help message stays in
    effect only for the next field parsed.}

procedure cmdef(default:string); extern;
   {Used to supply a default value for the next field parsed.  This
    default stays in effect only for the next field.}

function cmstat:integer; extern;
   {Returns the address of the COMND state block.  Don't write into
    unless you really know what you're doing.}

procedure cmbrk(break_mask: brkmsk); extern;
   {Used to supply a break mask for use in parsing the next field.}

procedure brini(var break_mask: brkmsk; w0, w1, w2, w3: integer); extern;
   {Used to copy w0 through w3 into BREAK_MASK.  Hint use this an the
    predefined CONSTants (at the beginning of this file) to set up break
    masks.  For example to be able to parse keywords with ^ in them:

	    brini(break,fldb0,fldb1,fldb2,flbd3);
	    brmsk(break,'^','');
	    ...
	    cmbrk(break);
	    which := cmkey(keyword_table);
    }

procedure brmsk(var break_mask: brkmsk; allow, disallow: string); extern;
   {Use to make a break mask with the characters, ALLOW, allowed and
    DISALLOW, disallowed.}

{In some cases you may want to allow a choice of several alternatives.
 To do this, issue CMMULT, to go into "multiple choice mode".  Once
 in this mode, issue CMxxx calls as usual.  Instead of being done
 immediately, these calls store away specifications of the legal
 alternatives.  For those that are functions, the values returned are
 garbage.  Once you have specified all the alternatives, call
 CMDO.  This returns an integer, 1..the number of alternatives,
 telling you which (if any) succeeded, 0 if none did.
	For alternatives that return values, you can then do
 CMINT to get the returned value if it is an integer, or CMREAL if it
 is real.  Alternatives that return values in variables passed by
 reference will do so, using the variable passed when the original
 CMxxx was called.  (Needless to say, that variable has better still
 be accessible.)}

procedure cmmult; extern;
  {Enter multiple choice mode.  All CMxxx procedures until the next
   CMDO are interpreted as specifications, rather than done immediately.}

function cmdo:integer; extern;
  {Do a COMND jsys, specifying the alternatives stored up since the
   last CMMULT.  Returns a code indicating which succeeded, or 0 if
   none did.  Since the return value is used to indicate which
   alternative was found, there is a possible question:  how do we
   get the returned value, if there is one (i.e. if the alternative
   found is a Pascal function that returns some value)?  The answer
   to this is that the value returned is stored away internally
   and is available by CMINT or CMREAL, depending upon its type.
   Note that files and strings are returned through variables
   passed by reference.  They do not need this mechanism, since
   that will be set automatically.  (What happens is that the
   addresses of all reference variables are stored away when the
   alternative is first set up, and the appropriate one is set when
   we find out which alternative is actually there.)}

function cmint:integer; extern;
  {Return a value from the last CMDO, if the alternative that succeeded
   was an integer}

function cmreal:real; extern
  {Return a value from the last CMDO, if the alternative that succeeded
   was a real}


.
