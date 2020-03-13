@device(File)
@make(Report)
@PageHeading(left "SCRIBE Expert's Manual",right "@value(page)")
@define(FileExample=Example,Free,BlankLines Kept,
	FaceCode F)
@begin(TitlePage)
@begin(TitleBox)
@MajorHeading(SCRIBE

Expert's Manual)
@Heading(First Edition)

Brian K. Reid
@value(Date)

@end(TitleBox)
@begin(Heading)
Carnegie-Mellon University
Computer Science Department
@end(Heading)
@Begin(ResearchCredit)
This research was funded in part by the
Rome Air Development Center under Contract No. F306-2-75-C-0218,
and in part by the Defense Advanced Research Projects Agency under
contract No. F44620-73-C-0074.
@End(ResearchCredit)
@end(TitlePage)
@PrefaceSection(Preface)
This manual is for experienced S@c[cribe] users who would like to
try a hand at producing their own definition files and other such
complicated stuff.   Because some of the more complicated pieces
of SCRIBE aren't completely independent of the host operating
@index(operating system independence)
system, this manual tries to point out the operating-system
dependencies, but as of the time of this writing (@value(Month) 
@value(Year)) S@c[cribe] exists only on the TOPS-10 monitor, so
there might be some subtle operating-system dependencies that
are as yet undiscovered.

@enter(Display,FlushRight)
Brian K. Reid
@value(date)
@leave(display)
@chap(Processing Sequence and Database Access)
When run, SCRIBE executes the following sequence of actions:
@index(SCRIBE execution sequence)
@begin(enumerate)
System initialization: preset owns and globals, reset available
space and IO buffers, print sign-on line, and so forth.

Read in filename and processing options, either from the terminal
or from a CCL file.
@index(CCL file) @index(processing options) 

Read in the cross-reference data in the .AUX file, if one exists.
@index(cross references) @index(AUX file)

Begin processing the manuscript file.  This step further divides
into
@begin(enumerate,numbered "A.")
Process the file prelude: read forward through the file, storing
@index(file prelude) @index(set-up commands) @index(@@Make)
@index(@@Style) @index(@@Font) @index(@@File) @index(@@Device)
the text of all @@Device, @@Make, @@Style, and @@Font commands until
some text is found or until a command that is not one of those
four is found.  @@File commands, though not a "prelude" command,
will be processed normally.

Process the @@Device command.  The device named in the most recent
@index(@@Device)
@@Device command will be used unless the external command language
specified a device, in which case the one specified by the external
@index(external command language)
command language will be used instead.  The details of the external
command language are operating-system dependent; on TOPS-10, for 
@index(operating system dependencies)
example, a /X option requests the XGP, a /L option requests the line
@index(XGP) @index(line printer) @index(/X option) @index(/L option)
printer, and so on.

Process the @@Make command.  SCRIBE retrieves from its database the
@index(@@Make)
text of the document-type definition file named in the most recent
@@Make command, and processes all of the commands found in that
definition file.  One of those commands should be an @@Enter.
@index(@@Enter)
During the processing of that first @@Enter command, the @@Style
@index(@@Style)
and @@Font commands will be processed, as follows:
@index(@@Font)
@begin(itemize)
The @@Font command is processed; i.e. the text of the font
@index(@@Font)
definition file is retrieved and the commands inside it are 
@index(font definition file)
processed.

The parameter values specified in the @@Enter are loaded into the
@index(@@Enter)
new state vector, according to the algorithm discussed in chapter
@index(state vector)
@ref(StateVector).

The @@Style parameter values are processed.  If any of them redefines
@index(@@Style)
some value that is currently in the state vector, then the old value
@index(state vector)
will be lost and the new one (from the @@Style command) used.

The state vector is produced from the preliminary new state vector:
@index(state vector)
type coercions are performed as needed; for example, font-relative
distances are converted to absolute distance.

The page margins are set to equal the left and right margins now in
@index(page margins) @index(page frame box)
effect, the page frame box is created, and then the left and right
margins in the state vector are set to zero.
@end(itemize)

The remainder of the input file is processed.
@leave(enumerate)

The index, table of contents, and any other generated portions
@index(index) @index(table of contents) @index(generated portions)
are output.

If any cross references were produced, an .AUX file is written.
@index(cross references) @index(AUX file)

The output file and error message files are closed, and execution
@index(error message file)
is terminated.
@leave(enumerate)
@chap(The Organization of the Database)
@index(SCRIBE database) @index(operating system dependencies)
Since the database is stored in files, and since every aspect of
files is particularly operating-system dependent, the database
must necessarily have some system-dependent characteristics.
It is therefore somewhat difficult to give an ideal description
of the data base. To be specific, we have to delve into
system-dependent details.

@sec(Storing the Database in ASCII Files With Restricted Names)
@index(database file names)
The data base is a set of sequential ASCII files, each with a
3-part name.  For example, the name of the device definition file
@index(device definition files) @index(device definition file names)
@index(file names)
for device DECwriter is (DEVICE,DECWRITER,).  The name of the
@index(DECwriter) @index(device DECwriter))
document-type definition file for the document type TEXT for device
XGP is (MAKE,TEXT,XGP).  
@index(XGP) @index(device XGP)

Many operating systems (most commercial operating systems) will not
@index(operating system dependencies)
support files with such long and peculiar names; SCRIBE therefore
imbeds its database files inside regular operating-system
files.  This imbedding can be regarded as a sort of hash coding.
On the PDP-10 in TOPS-10, for example, file names are limited to
6 characters, a period, then 3 more.  The SCRIBE database entry
name is hashed to produce a TOPS-10 filename, which SCRIBE then
searches line by line to find the marker that indicates the beginning
of the database entry that SCRIBE wants.

An implementation of SCRIBE on an operating system that supported long
filenames could eliminate the hashing process and use a one-to-one
correspondence between SCRIBE database entry names and system files.

@sec(The Format of Database Files)

@index(database file format) @index(database file contents)
The name of a database file is constrained by operating-system 
considerations, as described in the previous section.  The contents
of a database file, however, is independent of the host operating
system.  This section describes their internal format.

Each @i[database file] is a sequence of one or more database entries.
@index(database file) @index(database entries)
Each entry consists of an @@Marker command, followed by the sequence
@index(@@Marker)
of lines that makes up the entry proper.  For what it's worth, that
sequence can be empty.  As an example, a database file with two
entries might look like this:
@begin(example)
@@Marker(A,B,C)
text of the database entry whose name
is (A,B,C)
@@Marker(A,B1,D)
Text of the database entry
whose name is (A,B1,D)
@end(example)

To take a serious example, consider the database file that defines the
document types LETTER and LETTERHEAD on TOPS-10.  The file's name
@index(LETTER document type) @index(LETTERHEAD document type)
@index(document type definitions)
is LETTER.MAK, and its contents are:
@begin(example)
@@Marker(Make,Letter,XGP)
Commands to define document type LETTER for device XGP.
These commands are the contents of the database entry
whose name is (Make,Letter,XGP)
@@Marker(Make,Letter,Diablo)
Commands to define document type letter for device
DIABLO.
@@Marker(Make,Letter,LPT,File,TTY)
Commands to define document type LETTER for devices
LPT, FILE, or TTY.
@@Marker(Make,Letter)
Commands to define document type LETTER for any device 
not previously named.
@@Marker(Make,Letterhead,XGP)
Commands to define document type LETTERHEAD for the XGP.
@@Marker(Make,Letterhead,Diablo)
Commands to define document type LETTERHEAD for the 
Diablo.
@end(example)

The name of each database entry usually has three parts: (A,B,C).
@index(database entry name) @index(database entry retrieval key)
@index(retrieval key)
By convention, the A field is the name of the command that causes
the database access, the B field is the primary retrieval
key, and the C field is used for finer qualification
when needed.  Thus, the name of the entry that defines the 
device XGP is 
@index(XGP database entry name) @index(device database entry name)
@example{(DEVICE,XGP)}
Since device names don't need further qualification, there
is no C field.  The name of
the entry that defines the document type LETTER would be
@index(document type database entry name) @index(LETTER database entry
name)
@example[(MAKE,LETTER)]
except that we'd like to be able to use different definition
files to define the same document type for different devices.
Thus we can, if we want to, divide (MAKE,LETTER) into
finer divisions:
@begin(example)
(DEVICE,LETTER,XGP)
(DEVICE,LETTER,LPT)
(DEVICE,LETTER,TTY)
@end(example)
This lets us provide different definitions of the document type
LETTER for different devices.  As a convenience, if one entry
can work for more than one device, the multiple device names
may all be provided:
@begin(example)
(DEVICE,LETTER,LPT,TTY)
@end(example)
If one entry will work for all devices, the C field may be
omitted completely.  Since SCRIBE searches sequentially through
the file to find an entry, you may follow a set of entries
that have C fields with one that doesn't have a C field; this
last entry will have a "none of the above" effect: if it didn't
match on any of the special cases, it will match there. 
@sec(Details of Database Entry Requirements)
@index(constructing definition files)
This section gives the gory details that you need to know in 
order to be able to construct various definition files.

@subsec(Device Definition Files)
@index(new devices) @index(new device types) @index(device 
definition files)
A new device, but not a new device type, can be added to SCRIBE
by adding a device definition file.  Adding a new device type
requires modification of the program.  This program modification
is not difficult, but it's a task of more magnitude than the simple
addition of a device definition file.

@para(Device Types and Device Drivers)
To explain what a device type is, let's list the ones that are
@index(device types)
currently (@value(month) @value(year)) in SCRIBE.  Each device type
has a corresponding BLISS module in SCRIBE to implement it.
@begin(enumerate)
Line-printer-class devices.  Characterized by fixed-width characters,
@index(line-printer-class devices)
fixed horizontal and vertical spacing, and absence of special
control codes.  Devices LPT, TTY, FILE, and the like all fall into
@index(device LPT) @index(LPT) @index(device TTY) @index(TTY)
@index(device FILE) @index(FILE)
this class.  

Diablo-class devices.  Fixed-width characters, but variable spacing
@index(Diablo-class devices) @index(device Diablo) @index(Diablo)
available through control codes.  This variable spacing allows
superscripts, subscripts, and the construction of special characters
@index(special characters)
through overprinting.  Different typewheels may be used.
@index(typewheels) @index(character sets) @index(fonts)

XGP.  This is a device "class" that contains all CMU XGP's, i.e.
@index(device XGP) @index(XGP) @index(XGP-class devices)
it's a special-case hack.  XGP's at other sites would need to
@index(operating system dependencies) 
modify the program to include their XGP's control codes.  
@end(enumerate)

Any device being defined must fall into one of these types.  Other
characteristics that must be declared are, for example, whether
@index(device characteristics) @index(device definitions)
or not the device can overprint, how wide is its print line or
@index(overprinting) @index(print line width)
carriage, whether it can underline, etc.  These attributes must
@index(underlining)
be specified with a series of @@Declare commands; details on this
@index(@@Declare)
command will follow.

@para(Device Attribute Declarations)
Besides the @@Declare commands, a device definition file must 
@index(@@Declare)
contain a definition of all standard SCRIBE environments for
that device; this would be a series of @@Define commands.
@index(@@Define)

A device definition file must specify the value of all of the
following parameters, using the @@Declare command.  The syntax
of @@Declare is exactly the same as @@Style: 
@index(device attributes) @index(device definition file)
@display{@@Declare(PARM=value,PARM=value,...)}

@begin(description)
BACKSPACE   A Boolean variable; set True if the device can process
@index(^H character) @index(LPT-class devices)
a ^H backspace character to move the cursor one character to
the left.  This variable is interrogated only by the driver
for LPT-class devices.

BARECR   A Boolean variable; set True if the device can process a
@index(BACKSPACE device attribute) @index(LPT-class devices)
bare carriage return (CR), i.e. one without a following line feed.
@index(overstriking)
SCRIBE generates bare carriage returns for LPT-class devices that
cannot process ^H backspace characters in case overstriking is
needed.

DEVICENAME   The full string name of the device, capitalized
@index(DEVICENAME device attribute) @index(error messages)
as you would like it capitalized.  This string is used in 
labels, error messages, and the like.  Put quotes around the
string, as for example DEVICENAME="DECwriter".

DRIVER    The name of the device class, i.e. the name of the
@index(DRIVER device attribute) @index(device class)
routine in SCRIBE that will be used as the final output driver.
Its argument must be one of LPT, XGP, or DIABLO, unquoted.

FINALNAME   A string which is a template for the creation of
@index(FINALNAME device attribute) @index(output file name)
an output file name.  The exact contents of this string depends
on the file naming convention of the operating system.  Wherever
a "#" (pound sign) appears in that string, the capitalized 
name of the manuscript file will be substituted.  The TOPS-10
XGP declaration is, for example, FINALNAME="#.XGO".
@index(XGP)

FONTS    Set True if this device can print with more than one
@index(FONTS device attribute) @index(fonts)
font.

HRASTER   The numerator of a fraction that specifies horizontal raster
@index(HRASTER device attribute) @index(horizontal raster size)
size.  Usually specified as a decimal integer.  The raster size is the
smallest amount by which two distances can differ.

@index(device attributes)
HUNITS   Horizontal Units: the denominator of a fraction that specifies
@index(HUNITS device attributes) @index(horizontal raster size)
horizontal raster size.  Usually specified as INCH or CM, but may be
a decimal value in tenths of a millimeter.  As an example, if HRASTER is
64 and HUNITS is 50, then the horizontal raster unit is defined to be
64 units per 5 millimeters.  HRASTER=10 and HUNITS=INCH is the standard
value for typewriter-like devices.

OVERSTRIKE   A Boolean value; set True if the device is capable of
@index(OVERSTRIKE device attribute) @index(overstriking)
overstriking.  Unless either BACKSPACE or BARECR is true, then it 
doesn't really matter whether the device can overstrike, because there
is no way to ask it to overstrike.

PAPERHEIGHT   The height of the usual paper page loaded in the device.
@index(PAPERHEIGHT device attribute) @index(paper size)
Specify this height in absolute distance units or inches or whatever
you like.

PAPERWIDTH   The width of the usual paper.
@index(PAPERWIDTH device attribute) @index(paper size)


SCRIPTHEIGHT   The amount, in vertical raster units, by which characters
@index(SCRIPTHEIGHT device attribute) 
to be superscripted are raised and by which characters to be subscripted
@index(superscripts) @index(subscripts)
are lowered.

UNDERLINE   A Boolean value; set True if the device is capable of underlining.
@index(UNDERLINE device attribute) @index(underlining)
If UNDERLINE is true and OVERSTRIKE is true, then Scribe will underline
by overstriking the character with UNDERSCORECHARACTER.

UNDERSCORECHARACTER   A one-character quoted string, which specifies the
@index(UNDERSCORECHARACTER device attribute) @index(underlining) 
@index(underscoring)
character to be used for generating an underscore.

VRASTER   Like HRASTER, but for vertical raster unit definition.
@index(VRASTER device attribute) @index(vertical raster unit)

VUNITS    Like HUNITS, but for vertical raster unit definition.
@index(VUNITS device attribute) @index(vertical raster unit)
@index(device attributes)
@end(description)

@para(Definitions of Standard Environments)
A device definition file must define all of the standard
@index(device definition file) @index(standard environments)
environments listed in Appendix I of the SCRIBE User's Manual.
It must also define the following environments that are used internally
by various pieces of SCRIBE:
@begin(description)
HDG   The page-heading environment.  Must use the FIXED parameter to
@index(HDG environment) @index(page-heading environment)
locate the heading on the page.

FTG   The page-footing environment.  Like HDG, but it goes at the
@index(FTG environment) @index(page-footing environment)
bottom.

PSPACE   Used by @@Picture.  All @@Picture commands do an enter/leave
@index(PSPACE environment) @index(@@Picture) @index(Picture environment)
of PSPACE around the picture.

BSPACE   Used by @@Blankspace.  All @@Blankspace commands do an
@index(BSPACE environment) @index(@@Blankspace) @index(Blankspace
environment)
enter/leave of BSPACE around the blank space.

TRANSPARENT   The null environment.
@index(TRANSPARENT environment) @index(null environment)

FNENV   The environment for footnotes.  Must have attribute FOOT.
@index(FNENV environment) @index(footnote environment) @index(FOOT
environment attribute)

FOOTSEPENV   The environment for the footnote separator.  
@index(FOOTSEPENV environment) @index(footnote separator
environment)
@leave(description)

@para(Examples of Device Declarations)
Here are two complete examples, the definition files for device types
@index(Device definition files) @index(device definition file example)
@index(device declaration)
	XGP and DECwriter.
@index(device XGP) @index(XGP) @index(device DECwriter) @index(DECwriter)
@begin(FileExample)
@@marker(device,XGP)
@@Declare(DeviceName="XGP",FinalName="#.XGO")
@@declare(driver XGP,hunits inch,hraster 183,
	vunits inch,vraster 183)
@@declare(underline available,backspace available,
	overstrike available,fonts,
	paperwidth 8.5inch,paperheight 11inch)
@@Declare(UnderscoreCharacter "")
@@declare(ScriptHeight=10raster)
@@Declare(TopMargin 1inch,BottomMargin 1inch,
	LeftMargin 1inch,LineWidth 6.5inch)
@@Define(C,Capitalized,FaceCode C)
@@Define(I,FaceCode I)
@@Define(B,FaceCode B)
@@Define(R,FaceCode R)
@@Define(T,FaceCode T)
@@Define(Z,FaceCode Z)
@@Define(G,FaceCode G)
@@Define(U,Underline NonBlank)
@@Define(UN,Underline Alphanumerics)
@@Define(UX,Underline All)
@@Define(W,Spaces NoBreak)
@@Counter(Page,Inline,Numbered <1>,Referenced <1>,Init 1)
@index(device definition file example)
@@Counter(EquationCounter,Inline,Numbered <(1)>,
	 Referenced (1),IncrementedBy tag,Init 0)
@@Counter(TheoremCounter,Inline,Numbered <1.>,
@index(device definition file example)
	 Referenced <1>,IncrementedBy Use,Init 0)
@@Define(Hdg,Font BodyFont,FaceCode R,Fixed 0.5inch,
	Nofill,LeftMargin 0,RightMargin 0,Spread 0,Indent 0)
@@Define(Text,Fill,Justification,Spaces compact,Break)
@@Define(Multiple,Indent 0)
@@Define(Transparent)
@@Define(Comment,Break,Continue,Invisible,Nofill)
@@Define(Bspace,Break,Above 0,Below 0,Group,Nofill,
	LeftMargin 0,RightMargin 0)
@@Define(Pspace,Break,Above 0,Below 0,Group,Nofill,
	LeftMargin 0,RightMargin 0)
@@Define(Verbatim,Break,Continue,Nofill,Spaces Kept,
	BlankLines kept,Spacing 1,FaceCode F)
@@Define(Format,Font BodyFont,Break,Continue,Nofill,
	Spaces Kept,FaceCode R,BlankLines kept,Spacing 1,
	Justification off)
@@Define(Insert,Break,Continue,Above 0.5line,
	Below 0.5line,LeftMargin +4,RightMargin +4,
	spacing 1,BlankLines kept)
@@Define(Center,Break,Continue,Above 0.5line,Below 0.5line,
	Spacing 1,Centered,BlankLines kept)
@@Define(Heading,Use Center,Font TitleFont,Continue off,
	Above 1,Below 1,FaceCode 3)
@@Define(SubHeading,Use Insert,Indent 0,Font TitleFont,
	LeftMargin 0,Continue off,Above 1,Below 1,
	FaceCode 1)
@@Define(Display,Use Insert,Nofill,Use R,Group,
	Blanklines Hinge,Spaces Kept)
@@Define(Example,Use Insert,Nofill,Spaces Kept,
	Group,Blanklines Hinge,FaceCode T)
@@Define(Itemize,Break,Continue,Fill,LeftMargin +5,
	Indent -5,RightMargin 5,numbered <->,
	NumberLocation lfr,BlankLines break,Spacing 1,
	Above 1,below 1,Spread 1)
@@Define(Enumerate,Use Itemize,Numbered <1.>)
@@Define(Description,Break,Fill,LeftMargin +16,
	Indent -16,Spaces tab,Spacing 1)
@@Define(Quotation=insert,Font BodyFont,Fill,Indent 2,
	Use R,BlankLines break)
@@Define(Verse,Use Insert,Font BodyFont,Fill,Spaces Kept,
	Justification off,Crbreak,Use R,indent -3,
	Spread 0,LeftMargin +8,RightMargin +4)
@@Define(Equation,Use Insert,Nofill,Spaces Kept,Use R,
	BlankLines kept,NumberLocation rfr,
	Counter EquationCounter)
@@Define(Theorem,Use Insert,Fill,BlankLines break,
	Numbered <(1)>,NumberLocation rfr,
	Counter TheoremCounter)
@@Define(Fnenv,Use Text,Font SmallBodyFont,Above 1,Foot,
	Use R,LeftMargin 0,Indent 2,Spread 1,spacing 1,
	Break off)
@@Define(FootSepEnv,Font SmallBodyFont,Break,
	SaveBox <FootSep>,Nofill,LeftMargin 0,Above 0,
	Below 1)
@@Equate(Begin=enter,End=leave,Tabstops=tabs,
	Skip=blankspace,File=require,
	Enumeration=Enumerate,Itemization=Itemize)



@@Marker(Device,DECwriter)
@@Declare(DeviceName="DECwriter",FinalName="#.TXT")
@@Declare(Driver LPT,Hunits inch,Hraster 10,Vunits inch,
	Vraster 6)
@@Declare(Underline available,Backspace available,
	overstrike available,Barecr available)
@@Declare(Paperheight 66,Paperwidth 132,ScriptHeight=1)
@@Declare(LeftMargin 0,TopMargin 3,BottomMargin 4,
	LineWidth 69)
@@DefineFont(CharDef,R=<ascii "LA36">)
@@Define(I,Underline Alphanumerics,Capitalized off)
@@Define(B,Overstruck 2,Capitalized off)
@@Define(C,Capitalized)
@@Define(R,Underline off,Capitalized off,Overstruck 0)
@@Define(U,Underline NonBlank)
@@Define(UN,Underline Alphanumerics)
@@Define(UX,Underline All)
@@Define(W,Spaces NoBreak)
@@Define(T=R)
@@Define(G=R)
@@Counter(Page,Inline,Numbered <1>,Referenced <1>,Init 1)
@@Counter(EquationCounter,Inline,Numbered <(1)>,
	 Referenced (1),IncrementedBy tag,Init 0)
@@Counter(TheoremCounter,Inline,Numbered <1.>,
	 Referenced <1>,IncrementedBy Use,Init 0)
@@Define(Hdg,Fixed 1,Nofill,LeftMargin 0,RightMargin 0,
	Spread 0,Indent 0,Use R)
@@Define(Text,Fill,Justification,Spaces compact,Break)
@@Define(Multiple,Indent 0)
@@Define(Transparent)
@@Define(Comment,Break,Continue,Invisible,Nofill)
@@Define(Bspace,Break,Above 0,Below 0,Group,Nofill,
	LeftMargin 0,RightMargin 0)
@@Define(Pspace,Break,Above 0,Below 0,Group,Nofill,
	LeftMargin 0,RightMargin 0)
@@Define(Verbatim,Break,Continue,Nofill,Spaces Kept,
	BlankLines kept,Spacing 1)
@@Define(Format,Break,Continue,Nofill,Spaces Kept,
	BlankLines kept,Spacing 1,Justification off)
@@Define(Insert,Break,Continue,Above 1,Below 1,
	LeftMargin +4,RightMargin +4,spacing 1,
	BlankLines kept)
@@Define(Center,Use Insert,Centered)
@@Define(Heading,Use Center,Continue off,Use B,Use C)
@@Define(SubHeading,Use Insert,Indent 0,LeftMargin 0,
	Continue off,Use UX)
@@Define(Display,Use Insert,Nofill,Use R,Group,
	Blanklines Hinge,Spaces Kept)
@@Define(Example,Use Insert,Nofill,Spaces Kept,Group,
	Blanklines Hinge)
@@Define(Itemize,Break,Continue,Fill,LeftMargin +5,
	Indent -5,RightMargin 5,numbered <->,
	NumberLocation lfr,BlankLines break,Spacing 1,
	Above 1,below 1,Spread 1)
@@Define(Enumerate,Use Itemize,Numbered <1.>)
@@Define(Description,Break,Fill,LeftMargin +16,
	Indent -999,Spaces tab,Spacing 1)
@@Define(Quotation,Use Insert,Fill,Use R,BlankLines break)
@@Define(Verse,Use Insert,Fill,Spaces Kept,
	Justification off,Crbreak,Use R,
	indent -3,Spread 0,LeftMargin +8)
@@Define(Equation,Use Insert,Nofill,Spaces Kept,Use R,
	BlankLines kept,NumberLocation rfr,
	Counter EquationCounter)
@@Define(Theorem,Use Insert,Fill,BlankLines break,
	NumberLocation rfr,Counter TheoremCounter)
@@Define(Fnenv,Use Text,Above 1,Foot,Use R,LeftMargin 0,
	Indent 2,Spread 1,spacing 1,Break off)
@@Define(FootSepEnv,Break,SaveBox <FootSep>,Nofill,
	LeftMargin 0,Above 5,Below 1)
@@Equate(Begin=enter,End=leave,Tabstops=tabs,
	Skip=blankspace,File=require,
	Enumeration=Enumerate,Itemization=Itemize)
@end(FileExample)
@subsec(Document Type Definition Files)
Every SCRIBE run needs a document-type definition file, if for no
@index(document-type definition file)
other reason than to provide the first @@Enter, without 
@index(@@Enter)
which no processing is possible.
Usually a document type definition file will contain other commands, setting
fonts or style parameters or defining environments specific to the
document type.  

@para(Contents of a Document-type Definition File)
The document definition file is processed after the device definition
@index(device definition file)
file, so it may redefine the value of any parameter if it wants to.
The usual sequence of commands within a document definition file is:
@itemize{
@@Style parameters and @@Declare commands.
@index(@@Style) @index(@@Declare)

@@Define statements
@index(@@Define)

The mandatory @@Enter
@index(@@Enter)

Text, if any, plus any other commands.
}
A good deal of SCRIBE's initialization takes place during the
@index(SCRIBE initialization)
processing of the first @@Enter command.  This means that many
SCRIBE commands won't work right if they appear before it.
Rather than giving an elaborate set of rules, it's easier to 
@index(@@Enter, commands appearing before)
put all your text after the @@Enter and then stop worrying.
Don't put any commands before the first @@Enter except 
@@Define, @@Declare, and @@Style.

@para(Initializing Fonts)
@index(initializing fonts) @index(fonts)
During the initialization performed as part of the first 
@@Enter, the @@Font command that was saved from the manuscript
@index(SCRIBE initialization) @index(@@Font) @index(manuscript)
file will be processed.
No particular trickery is involved in this processing except
to note that the presence of a @@Font command in the user's
manuscript file will override any @@Font that might be in
the document definition file.  Even for devices that don't
support fonts, a dummy FONT parameter and a FACECODE parameter
@index(FONT environment parameter) @index(FACECODE environment parameter)
must be used in the @@Enter in order to trigger the 
initialization code.  For devices that don't support different
fonts, a font named CHARDEF will have been defined in the
@index(CHARDEF pseudo-font) @index(devices and fonts) @index(fonts
and devices)
device definition file, and the FONT parameter in this @@Enter
may refer to that pseudo-font.


@para(Style parameters and Initialization)
@index(initialization) @index(state vector) @index(@@Enter)
When the first @@Enter is processed, its own parameters
are stored into the state vector.  Then all of the various
@@Style parameters that have been collected are processed.
@index(@@Style)
Some @@Style parameters are stored into global variables,
while others are stored into the state vector.  When all
of the style parameters have been processed, the normal
@@Enter processing is resumed.

@para(Initializing Margins)
The page margins will also be
@index(page margins)
set during this first @@Enter.  It will always be possible
to go outside the page margins, but the values set by this
first @@Enter will be used to define the zero points for
the two margins, i.e. what you get when you ask for a zero
left margin or a zero right margin.  This means that sometimes
@index(zero margins)
a bit of trickery is called for: if you want the zero
margins to differ from the initial margins, then do @u[two]
@index(initial margins)
@@Enters, one to set the zero margins and another, inside
the first, to set the initial margins.  If the EOFOK parameter
(End Of File OK) is not used in these @@Enters, then
@index(EOFOK parameter) @index(End OF File OK parameter)
a @@Leave must be provided at the end of the user's manuscript
file (ugly).  If the EOFOK parameter is provided, then the end of
the manuscript file will serve as the @@Leave commmands.

It's time for an example.  Consider the sequence:
@index(page margin example)
@Begin(FileExample)
@@Enter(First,LeftMargin 1inch,RightMargin 1inch)
@@Enter(Second,LeftMargin 3inches)
Text
@@Leave(Second)
@@Leave(First)
@leave(fileexample)
This will cause the page margins to be set to 1 inch from
the edge of the paper, and the inner margin 4 inches from
the left edge of the paper.  The "T" in "Text" will be 4
inches from the left edge of the paper.  If the EOFOK 
parameter is added to the @@Enter(First) and the @@Enter(Second),
then the two @@Leave commands at the end need not be 
provided.

As a further example, let's look at a piece of the document definition file
@index(LETTER document definition file)
for LETTER.  We want 1-inch page margins, but the opening 
margins put the return address over at the right.  The 
definition file for LETTER includes
@begin(FileExample)
@@Style(LeftMargin 1inch,TopMargin 1inch,
	BottomMargin 1inch,LineWidth 6.5inches)
@@Define(Ends,Nofill,LeftMargin 3in,Spread 0,Break,Use R)
@@Define(Address=Ends,LeftMargin 0)
@@Define(Body=Text,Spread 10raster,Indent 0,Font BodyFont,
	Use R,LeftMargin 0)
@@enter(Text,Justification,Font CharDef,FaceCode R)
@@enter(Ends,EofOK)
@@PageHeading(Center "@@value(page)")
@leave(FileExample)
The manuscript file to use that definition would be
@index(LETTER manuscript file example)
@begin(FileExample)
@@Make(Letter)
Return address
goes here
@@Enter(Address)
Inside Address
@@Leave(Address)
@@enter(body)
Body of letter, including greeting
@@leave(body)
Yours Truly,

Signature
@end(fileexample)
Note that the @@Leave(Ends) and @@Leave(Text) aren't needed
at the end, though their presence wouldn't hurt anything.

@para(Comments In Document Definition Files)
Since @@Comment is just another environment, you can't use
@index(@@Comment) 
it to enter comments into a document definition until the
first @@Enter has been seen, else the first @@Enter
initialization code will be triggered by that @@Comment, and
all kinds of awful things will happen.  Use the generated-text
@index(generated-text sequence) 
sequence for comments in definition files:
@example<
@@[[This is a comment]]
@@((This is also a comment))
>
A generated-text sequence is begun by an @@ and a double delimiter,
and is closed by a double closing delimiter.  It may not cross
a line boundary.
@subsec(Font Definition Files)
@index(Font definition files) @index(fonts)
@label(FontDefinition)
@label(FontIntroduction)
Let's first talk about just what a font file is. The word
"font" is terribly ambiguous: it can mean an alphabet in a
particular size and style; it can mean a set of similarly
styled alphabets in different sizes. It can even mean
@index(alphabet styles)
the bowl in a church where people get baptized.

In S@c[cribe], we use the following terms:
@enter[description]
FONT       A family of typefaces in different styles and sizes,
@index(font) 
           chosen to be harmonious when used with one another.

TYPEFACE       A set of letters, numbers, and symbols all in a
@index(typeface)
          particular size, style, and darkness.
@leave[description]
There needs to be a word for that attribute of a typeface of which
italics, boldface, and small capitals are examples.

There is a bit of an interaction between document definition files and
font files: document definition files expect that fonts with
@index(document definition files) @index(font files)
certain names will be defined, and that a standard set of typefaces
@index(standard typefaces)
will be available in each font.

A FONT database entry actually defines more than one font; they are
@index(FONT database entry)
grouped together because they are often used together. Let's look at
the database entry for NewsGothic10 for the XGP:
index(News Gothic 10 font) @index(XGP) @index(device XGP)
@enter[FileExample]
@@Marker(Font,NewsGothic10,XGP)
@@DefineFont(BodyFont,	
	R=<ascii "NGR25.KST[A730KS00]">,
	I=<ascii "NGI25.KST[A730KS00]">,
	B=<ascii "NGB25.KST[A730KS00]">,
	C=<ascii "NGR20.KST[A730KS00]">,
	G=<ascii "GRK25.KST[A730KS00]">,
	T=<ascii "LPT128.KST[A730KS00]">,
	F=<ascii "FIX25.KST[A730KS00]">,
	Z=<ascii "MATH40.KST[A730KS00]">)
@@DefineFont(TitleFont,	
	0=<ascii "NGR25.KST[A730KS00]">,
	1=<ascii "NGB25.KST[A730KS00]">,
	2=<ascii "NGR30.KST[A730KS00]">,
	3=<ascii "NGB30.KST[A730KS00]">,
	4=<ascii "NGR40.KST[A730KS00]">,
	5=<ascii "BDR40.KST[A730KS00]">)
@@DefineFont(SmallBodyFont,
	R=<ascii "NGR20.KST[A730KS00]">,
	I=<ascii "NGI20.KST[A730KS00]">,
	T=<ascii "DEL20.KST[A730KS00]">,
	F=<ascii "FIX20.KST[A730KS00]">)
@@Equate(DisplayFont=BodyFont)
@leave[FileExample]
Notice that several fonts are defined, each with a set of
typeface codes. The document type REPORT will select
SmallBodyFont for notes and long quotations; it will
@index(SmallBodyFont)
select BodyFont for the normal text body.
@index(BodyFont)

The names given in the various lines of the font definition,
e.g. "NGR25", are the TOPS-10 file names of the files that
@index(operating system dependencies)
contain the detailed definition of the faces. These files,
called KST (for character set) files, define the sizes and
@index(KST files) @index(character set files)
shapes of the letters.

S@c[cribe] uses font definition files even for devices that
don't have varying fonts. For Diablo typewriters and such
@index(Diablo) @index(typewheels)
devices, a font file corresponds to a typewheel; there is,
for example, a font file named ELITE for device DIABLO
@index(ELITE font)
that corresponds to the "Elite 10" typewheel.

@subsec[TFont (Typewriter Font) Files]
@index(TFont Files) @index(Typewriter Font Files)
Remember that a font definition file for device XGP 
contains pointers to the KST files that actually define 
the individual characters and their widths. For other
devices, like typewriters and like printers, the character
is defined by the shape of the plastic type slug or the
shape of the letter on the printing drum. A means of
recording character widths must exist, however, and that's
what a TFont (Typewriter Font) file is: a file that records
the width of various characters on a type wheel. As an
extra added attraction, TFont files may also define special
characters; more on that below.
@index(special characters)

Because typewriters and line printers can't change
@index(typewriter devices) @index(line-printer-class devices)
fonts in the middle of a document, a font file for such a
@index(font files)
device is usually pretty straight-forward. Thus, the
entire ELITE font file for the Diablo (and the LPT) is
@index(font file example) @index(ELITE font) @index(Diablo) @index(
line printer)
@enter[FileExample]
@@Marker(Font,Elite,Diablo)
@@DefineFont(CharDef,R=<ascii "ELITE.TFO[A800DP99]">)
@@Marker(Font,Elite,LPT)
@@DefineFont(CharDef,R=<ascii "ELITE.TFO[A800DP99]">)
@leave[FileExample]

TFont files do two things: they provide S@c[cribe] with information
@index(TFont files) @index(character widths)
about character widths, and they define special character
@index(special characters)
construction sequences. The internal format of a TFont file is pretty
@index(TFont file format)
awful; it's full of sequences of decimal numbers. Maybe someday
somebody will write an editor for that format; until then, just be
thankful that they don't need to be changed very often.

S@c[cribe] reads a TFont file the first time that its information is
needed; on all subsequent times it re-uses the information from core.
Each line of a TFont file has four fields, separated by commas.
@index(TFont file format)
@enter[enumerate]
Character number. If 1-127, it's the decimal value of an
ASCII character. If 128 or more, it's a special character.

Character width, in device-dependent horizontal units.
@index(character widths)

Entry type:
@enter[enumerate]
Multiple-character entry. Field 4 is a count; N 
characters beginning with the character in field 1 will
be assigned the specified width.

Translation: the character denoted by field 1 is to be
translated into the character named in field 4.

Special character specified with a decimal byte sequence.
@index(special characters)
Field 4 is actually a sequence of decimal numbers, which will
be used to construct this character.

Special character specified with a quoted string. Field 4 is
@index(special characters)
a verbatim sequence of ASCII characters, delimited at the end 
by the same character with which it was begun, that will be
used to construct this character.
@leave[enumerate]

See "Entry Type" to find out what field 4 is good for.
@leave[enumerate]
As an example, let's look at two TFont files. First, the
@index(TFont file example) @index(device DECwriter) @index(DECwriter)
font for a DECWriter:
@enter[FileExample]
00100	@@Marker(TFONT,LA36)
00150	32,1,0,95
00200	1,1,1,1111
00300	4,2,1,1066
00400	5,1,1,1084
00500	6,1,1,1054
00600	14,1,1,1122
00700	15,1,1,1126
00800	16,1,1,1045
00900	17,1,1,1046
01000	18,1,1,1057
01100	19,1,1,1058
01200	20,1,1,1125
01300	21,1,1,1124
01400	22,1,1,1088
01500	23,1,1,1101
01600	24,1,1,95
01700	25,1,1,1097
01800	26,1,1,126
01900	27,1,1,1010
02000	28,1,1,1028
02100	29,1,1,1029
02200	30,1,1,1011
02300	31,1,1,1065
02400	1001,1,2,"X^HX"
02500	1002,1,2,"X^HX"
02600	1004,1,2,"+^H_"
02700	1006,1,2,"T^H-"
02800	1009,1,2,'=^H"'
02900	1010,1,2,"=^H/"
03000	1011,1,2,"=^H_"
03100	1013,1,2,"-^H:"  
03200	1017,1,2,"~^H_"
03300	1018,1,2,"~^H="
03400	1019,1,2,"~^H."
03500	1026,1,2,"<^H)"
03600	1027,1,2,">^H("
03700	1028,1,2,"<^H_"
03800	1029,1,2,">^H_"
03900	1041,2,2,">>"
04000	1042,2,2,"<<"
04100	1045,1,2,"{^H<"
04200	1046,1,2,"}^H>"
04300	1053,1,2,"C^H-"
04400	1054,1,2,"C^H-"
04500	1055,1,2,"C^H-^H/"
04600	1057,1,2,"h^H-"
04700	1058,1,2,"U^HV"
04800	1057,1,2,"h^H-"
04900	1060,1,2,"U^HV"
05000	1065,2,2,"\/"
05100	1066,2,2,"/\"
05200	1073,1,2,"/_"
05300	1075,1,2,"|^H_"
05400	1084,2,2,"~~"
05500	1088,1,2,"O^H+"
05600	1097,2,2,"--^H>"
@leave[FileExample]
Line 00150 assigns a width of 1 to characters 32 through
126. Lines 00200 through 02300 translate the so-called
"Stanford" character set into S@c[cribe] special
@index(special characters)
character numbers, and lines 02400 through 05600 define
the character sequences that will be used to construct
an approximation to these characters on the terminal.

Here's a font that provides the full French  alphabet,
@index(TFont file example) @index(French alphabet) @index(accent marks)
@index(Diablo)
with accent marks, on the Diablo:
@enter[FileExample]
00100	@@marker(TFONT,French,Diablo)
00200	32,10,0,95
00300	17,1,1,1089
00400	7,1,1,1090
00500	18,1,1,1091
00600	1,1,1,1092
00700	1089,0,3,27,51,8,8,8,8,8,44,32,32,32,32,32,27,52
00800	1090,0,3,27,51,8,8,8,8,8,27,10,27,10,27,10,27,10,
	27,10,46,32,27,10,46,10,10,10,10,10,10,32,32,32,
	32,27,52
00900	1091,0,3,27,51,8,8,8,8,27,10,27,10,27,10,27,10,
	27,10,46,8,27,10,46,10,10,10,10,10,10,32,32,32,
	32,32,27,52
01000	1092,0,3,27,51,8,8,8,8,8,27,10,27,10,94,10,10,32,
	32,32,32,32,27,52
@leave[FileExample]

Line 00200 assigns a width of 10 to characters 32 through 126.
Lines 00300 through 00600 specify translation of certain of the
non-printing ASCII characters into  SCRIBE special characters.
Lines 00700 through 01000 detail how to construct each of those
characters on the Diablo. They are all accent marks of various
@index(special characters) @index(accent marks)
kinds, and thus have a zero width -- notice that field 2 is zero.
@index(character widths)
@chap(Environment Definition and the State Vector)
@label(StateVector)
@index(environment definition)
This chapter should teach you everything that you
need to know to be able to define your own environments
successfully.  Environment definition is a powerful tool;
use it wisely.

@sec(Internal Representation of Environments)

An environment is a pair list of typed values.  Each cell of the
pair list corresponds to one parameter of the @@Define command
@index(@@Define)
that defined the environment.  The first element of each pair
is the small-integer index of the state vector element to which
that parameter applies.  The second element of the pair is
either empty or is the value of the parameter.  Sometimes a
type conversion will have been performed on the value, sometimes
not -- it depends on the parameter involved.  Some values will
be stored as strings, some as integers.  All values will have
an associated type field that indicates whether or not a conversion
has been made.

When the @@Enter is processed, SCRIBE performs the following
@index(@@Enter)  @index(state vector)
steps:
@begin(enumerate)
Iterates over the cells of the environment list, storing their
values into a scratch copy of the state vector.  This step is just
a sort.

Iterate over the scratch copy of the state vector, taking each
value and performing the necessary type conversions.  Some type
conversions require multiplication by the size of the current font,
so the font parameter must be first in the state vector.  Other type
@index(FONT parameter)
conversions require access to the old value, so the old (outer)
state vector must be accessible.  If a value was not provided in
an environment, then the previous value is copied.

Compare @tag(envcompare)the new state vector with the old one to see
if any special processing is required as a result of the change.  For
example, if fonts differ, then the command sequence necessary to load
a new font is generated.
@index(state vector) @index(font loading)
@leave(enumerate)
It is interesting to notice that the "non-procedural" nature of SCRIBE
@index(non-procedural language)
depends on all of the processing in step @ref(envcompare): all of
the procedurality is hidden there.
As might be expected, there is quite a large amount of code in the
implementation of step @ref(envcompare).

@sec(The State Vector)
@index(state vector)
The state-vector is a vector of about 100 words in which most of
the state of SCRIBE is maintained.  Each time an @@Enter is performed,
@index(@@Enter)
a new state vector is made and the old one is pushed; each time a
@@Leave is performed, the current (inner) state vector is deallocated
@index(@@Leave)
and the old (outer) one is resumed.

Some parts of SCRIBE's state are not maintained in the state vector
because they are too complex.  Others are not maintained there because
they shouldn't be restored on a @@Leave.  For example, the data structure
in which a page image is built is much too large to put in the state
vector, so only a pointer is stored there.  The output assembly buffers
are not stored in the state vector, because one doesn't normally want
to pop back to a previous line of the text when an environment is
left.  Footnotes and floating figures are an exception, however: at the
end of a footnote, which has been assembled at the bottom of a page,
one wants to pop back to the line that called the footnote and
resume exactly where he left off.  

Each element of the state vector has an associated type.  These types
are fixed at compile time: the 23rd element of the state vector has type,
say, Horizontal Distance in every SCRIBE run.  The type information is used
only during @@Enter processing to coerce environment values into
the correct type.  The code that references various cells of the 
state vector is irrevocably committed to that cell's containing a value
of the correct type.  No type checking or type coercion is ever
performed during the @i[use] of state vector data.

With no further ado, let's get to the discussion, in alphabetical order,
of the various fields of the state vector and the environment parameters
that set them.
@sec(Environment Parameters and the State Vector)
This section lists all of the legal parameters to an environment
definition, explains how their value is used by SCRIBE, and 
@index(environment definitions) @index(state vector)
specifies the constraints on them.  
Parameter names may be specified in any mixture of capital or
lower-case letters; we use a mixture here that seems to
make the names a bit more readable.

@begin(description)
@b[Above]@\The white space above a box or a line.  Specified
@index(ABOVE environment parameter) @index(space above environments)
in units of vertical distance.  When an environment is
entered, if the Break parameter is set (q.v.), then 
@index(BREAK environment parameter)
"Above" units of white space will be left above the
environment's topmost line.  This white space will
merge with the top margin or with the "Below" space
below the box above.
If the "Break" parameter is not set, then "Above" will
have no effect.

@b[Below]@\The white space below a box or line.  Specified
@index(BELOW environment parameter) @index(space below an
environment parameter)
in units of vertical distance.  When an environment is
exited, if the Break parameter (q.v.) is set, then
"Below" units of white space will be left below the
environment's bottom line.  This white space will merge
with the bottom margin of the page, or with the "Above"
space above the following box.  If the "Break" parameter
is not set, then "Below" will have no effect.

@b[BlankLines]@\Specifies the disposition of blank lines.  Its
@index(BLANKLINES environment parameter)
argument must be a keyword from the set
KEPT, BREAK, IGNORED, or HINGE.  "BlankLines Kept" means
that blank lines are passed through to the output: 4 blank
lines in the manuscript file will produce 4 blank lines in the
finished output file.  If the environment is not NOFILL (q.v.),
then the actual number of blank lines that will be left in
the final text can differ by one from the number in the
input file.  "BlankLines Break" means that any number of blank
lines are to be treated as a single blank line and will cause
a paragraph break.  "BlankLines Ignored" means just that; SCRIBE
will act as if they weren't there.  "BlankLines Hinge" is meaningful
only in environments with the GROUP parameter set; it specifies that
a @@Hinge command is to be simulated at each blank line.  

@b[Bottommargin]@\Sets the page bottom margin.  Specified in units
@index(BOTTOMMARGIN environment parameter) @index(page bottom margin)
@index(page margin)
of vertical distance.  The BottomMargin parameter will take effect
on the first page after the one where it is specified.
The @@Enter in a document type definition file should declare
a value for BottomMargin, which will be the prevailing
bottom margin for the document.
Related parameters are "TopMargin", "LeftMargin", and "RightMargin".

@b[Break]@\Declares whether or not SCRIBE should perform
@index(BREAK environment parameter) @index(CONTINUE environment
parameter)
a text break when it enters this environment.  BREAK is set
to a Boolean value (one of the set {TRUE, FALSE, ON, OFF,
YES, or NO}).  Many other environment parameters interact
with BREAK; see in particular the CONTINUE parameter.

@b[Capitalized]@\Declares whether or not SCRIBE should
@index(CAPITALIZED environment parameter) @index(idempotent output)
capitalize the text inside the environment.  CAPITALIZED
is set to a boolean value.  If idempotent output mode is
set, the text in the idempotent output file will not
be capitalized.

@b[Centered]@\Declares whether or not SCRIBE should center
@index(CENTERED environment parameter) @index(NOFILL environment)
@index(FILL environment)
each line of the environment.  Results are not guaranteed
unless it is a NOFILL environment, but something reasonable
may happen in a FILL environment.  CENTERED is a Boolean; it
should be given a value from the set 
{TRUE, FALSE, YES, NO, ON, OFF}

@b[Continue]@\The "Continue" parameter determines whether
@index(CONTINUE environment parameter) @index(paragraph breaks)
the "Break" parameter causes a line break or a paragraph
break.  If "Continue" is given the value True, then
it means "continue in the current paragraph", i.e. just
cause a line break.  If "Continue" is given the value
False, then
it means "don't continue in the current paragraph", i.e.
cause a paragraph break.  "Continue" is meaningless unless
"Break" is True.

@b[Copy]@\The "Copy" parameter is really a pseudo-parameter.
@index(COPY environment parameter)
It takes an environment name as its argument, and copies the
entire definition of that environment into the environment
being defined, at the point where the "Copy" appears.
Thus, if a @example{@@Define(FOO,BREAK,ABOVE 1inch)} has been processed,
and then SCRIBE sees
@example{@@Define(NEW,COPY FOO,BELOW 1inch)}
then the NEW that is stored away will be exactly the same as if
you had said
@example{@@Define(NEW,BREAK,ABOVE 1inch,
	BELOW 1inch)}
Compare this "Copy" pseudo-parameter with the similar "Use"
@index(USE environment parameter)
pseudo-parameter, which doesn't make a copy but just stores a
pointer.

@b[Counter]@\The "Counter" parameter is used in a numbered
@index(COUNTER environment parameter) @index(numbered environments)
environment to specify the counter that will be used for numbering.
If no "Counter" parameter is provided to a numbered environment, then
SCRIBE will use a scratch counter that starts from 1 each time.  If a
"Counter" parameter is used, specifying the name of a counter that
has been defined via the @@Counter command, then SCRIBE will use that
counter to number the paragraphs of the environment.  See the
"Numbered" parameter (following) and the discussion of the @@Counter
command (in a later section) for more information.

@b[CRbreak]@\The "CRbreak" command is a Boolean.  When it is False,
@index(CRBREAK environment parameter) @index(paragraph breaks)
which is the default, no unusual action is taken.  When it is True, 
then a paragraph break is taken at every carriage return found in
the input file.  The VERSE environment (see User's Manual) uses the
@index(VERSE environment)
CRbreak parameter.

@b[CRspace]@\The "CRspace" parameter is equivalent to "CRbreak False".
@index(CRSPACE environment parameter)
It is included in SCRIBE for historical reasons.

@b[EofOk]@\The "EofOk" parameter means "End Of File OK".  If it is set
@index(EOFOK environment parameter) @index(End OF File OK environment
parameter) @index(@@Leave)
(true) in an environment, then SCRIBE will not complain if the @@Leave
to end that environment is never found.  If "EofOk" is False, which is
the default, then SCRIBE will print an error message if the end of the
document is reached and no @@Leave command is found.

@b[FaceCode]@\The "FaceCode" parameter specifies which typeface code
@index(FACECODE environment parameter) @index(fonts) @index(font
definition files)
will be used out of the several that are in the font specified by a
"Font" parameter (q.v.).  Typical typeface codes are "I" (Italic),
"R" (Roman), and so forth.  Typeface codes are defined in font
definition files, whose format is described in section
@ref(FontDefinition) of this manual.

@b[Fill]@\The "Fill" parameter is a Boolean that determines
@index(FILL environment parameter) @index(filling) @index(justification)
whether or not SCRIBE will try to fill text.  Filling is
putting as many words on a line as will fit there before
moving to the next line; it differs from Justifying, which
is taking the lines as they stand and adding blanks to make
the right margin even.  Normal text is both filled and
justified.  "NoFill" is a parameter that is equivalent
@index(NOFILL environment parameter)
to "Fill False".  

@b[Fixed]@\The "Fixed" parameter to an environment specifies
@index(FIXED environment parameter) @index(page headings)
@index(page footings) @index(title page)
that every invocation of that environment should be printed at
a fixed place on the page.  Its primary use is for page headings
and footings, though it's also nice for title pages and
certain specialized formatting.  "Fixed" takes a vertical distance
as an argument.  When the environment is invoked, the top line
of the environment is started that far from the top edge of the
paper.  An environment with the "Fixed" parameter specified must
have "Break" specified.  When SCRIBE processes an environment
with the "Fixed" parameter specified, it builds a separate 
text box that contains all of the text of the environment.  At the
close of the page, the box will be output on the page in the
requested spot.  If normal text and "Fixed" text are trying to
fit onto the same spot on the page, the "Fixed" text will be
moved down until it fits.

@b[Float]@\The "Float" parameter takes no arguments.  When present,
@index(FLOAT environment parameter) @index(environment floating)
it specifies that the text in the environment should be floated
to the text page if it won't fit on the current page.  A discussion
of environment floating is in the User's Manual.  "Free" (q.v.)
is the opposite of "Float".

@b[FlushRight]@\The "FlushRight" parameter takes no arguments.
@index(FLUSHRIGHT environment parameter) @index(page right margin)
When present, it specifies that all of the text in the environment
should be flushed to the right margin.  If you specify "FlushRight",
then SCRIBE will also assume "NoFill".
@index(NOFILL environment parameter) @index(page margins) @index(right
margin)

@b[Font]@\The "Font" parameter names the font that is to be
@index(FONT environment parameter) @index(fonts) @index(character set)
used in the environment.  Together with the "FaceCode" parameter
(q.v.), "Font" determines the particular character set in which
the text will be printed.  The meaning of "font", "face", and
other such words is discussed in section @ref(FontIntroduction).

@b[Foot]@\The "Foot" parameter takes no arguments.  When
@index(FOOT environment parameter) @index(footnotes)
present, it specifies that the environment has the many 
exotic properties needed to make footnotes work.  If you
specify the "Foot" parameter on any environment other than
the predefined "FNOTE" environment, then you are taking
your life in your hands.  Similarly, if you are defining
a new device type and neglect to include an environment
named "FNOTE" that has the "Foot" parameter specified, you
will encounter similar disasters.

@b[Free]@\The "Free" parameter takes no arguments.
@index(FREE environment parameter) @index(FLOAT environment
parameter) @index(GROUP environment parameter)
It means the same as "Group False" and "Float False"; i.e.
it turns off the "Group" or "Float" parameters if they
happen to be set.  "Free" is the default.

@b[Group]@\The "Group" parameter takes no arguments.
@index(GROUP environment parameter) @index(FREE environment
parameter) @index(FLOAT environment parameter)
When present, it specifies
that the current environment is grouped.
For a discussion of what that means, see the User's Manual.
"Free" is the negation of "Group" (and also of "Float").

@b[Indent]@\The "Indent" parameter specifies indentation.
@index(INDENT environment parameter) @index(Page left margin)
@index(page margins) @index(left margin) @index(paragraph 
indentation)
Its argument is a signed horizontal distance.  Indentation
is measured from the left margin.  "Indent 0" means that
paragraphs are not indented.  "Indent 3" or "Indent +3"
specifies an indentation of 3 characters to the right of
the left margin.  "Indent -3" specifies an indentation
of 3 characters to the left of the left margin.

@b[Initialize]@\The "Initialize" parameter specifies text
@index(INITIALIZE environment parameter)
to be inserted at the front of an environment.  It takes
a quoted string as an argument.  As an example, if the
environment "ABC" is defined as:
@example{@@Define(ABC,Initialize "---")}
then if the manuscript file contained 
@example{this is @@ABC(text).}
then the finished output would be
@example{this is ---text.}
The quoted string may contain any characters at all, including
SCRIBE commands.

@b[Invisible]@\The "Invisible" parameter, when specified, makes
@index(INVISIBLE environment parameter) @index(idempotent output)
the environment's text not show up in the finished document.
It does not interact well with the idempotent output feature.
"Invisible" is a Boolean, and takes a Boolean argument if
desired; "Invisible False" means the same thing as "Visible".

@b[Justification]@\The "Justification" parameter is a Boolean.
@index(JUSTIFICATION) @index(filling) @index(page right margin)
@index(page margins) @index(right margin)
When specified True it causes SCRIBE to justify (make even) the
right margin.  Justification is different from filling; see the
"Fill" parameter for comparison.

@b[LeadingSpaces]@\The "LeadingSpaces" parameter specifies
@index(LEADINGSPACES environment parameter) @index(disposition of
spaces)
the disposition of leading spaces, i.e. of spaces at the 
beginning of a line.  It takes as an argument a keyword from
the set
{KEPT, COMPACT, TAB, NORMALIZE, NOBREAK, DISCARDED}.
At the time of this writing, "Normalize" is not implemented.
"Kept" means to preserve the spaces as they stand in the 
manuscript file.  "Compact" means to squeeze them down to 
one or two spaces (two if the spaces follow a sentence
terminator; one if they follow everything else).  "Tab" 
means to treat a sequence of 3 or more spaces as a "@@\"
sequence; 2 or 1 spaces will be left intact.  "Normalize"
means to place the correct number of spaces for normal
English text regardless of how many are in the manuscript
file.  "NoBreak" means that a space is a letter and not
a special character.  "Discarded" means that spaces
are to be thrown away.  Not all of these parameter values
are particularly meaningful on the "LeadingSpaces"
parameter; see "Spaces".

@b[LeftMargin]@\The "LeftMargin" parameter specifies the
@index(LEFTMARGIN environment parameter) @index(left margin)
@index(page left margin) @index(page margins) @index(@@Enter)
left margin of the paper.  It is specified in vertical distance
units.  A newly-specified left margin will take place on the page
after the one where it is specified.  The @@Enter in a document
type definition file should declare a value for LeftMargin; this
value will be the prevailing left margin for the document.
Related parameters are "TopMargin", "BottomMargin", and "RightMargin".

@b[LineWidth]@\The "LineWidth" parameter provides a means of
@index(LINEWIDTH environment parameter) @index(page margins)
@index(line length) @index(right margin) @index(page right margin)
@index(RIGHTMARGIN environment parameter)
specifying the length of the text line, regardless of the size
of the paper and the size of the right margin.  You may specify
either "RightMargin" (q.v.) or "LineWidth", but not both.
The argument to "LineWidth" is a horizontal distance.

@b[Need]@\The "Need" parameter is a bit of a hack.  It takes
@index(NEED environment parameter) @index(page breaks)
a vertical distance as an argument.  When an environment having
a "Need" parameter is entered, then if the amount of space
remaining on the page is less than the specified "Need" value,
SCRIBE will begin a new page before placing the text of the
environment.

@b[NoFill]@\The "NoFill" parameter turns off the "Fill" parameter;
"NoFill" is equivalent to "Fill False".

@b[Numbered]@\The "Numbered" parameter specifies that the paragraphs
@index(NUMBERED environment parameter)
of an environment should be numbered, and gives a template for printing
the number.  Each time a new paragraph is started, a new number
will be generated and printed somewhere on the first line of
the paragraph.  The precise position of that number will be
controlled by the NumberLocation parameter, q.v.

@b[NumberLocation]@\The "NumberLocation" parameter determines
@index(NUMBERLOCATION  environment parameter)
where on a line the paragraph number will be printed.  There
are four options, each denoted by a keyword.  The number may be
on the left-hand or right-hand side of the line, and it may be
flush-left or flush-right within those positions.  The four
keywords that may be used as an argument to NumberLocation are
LFL, LFR, RFL, and RFR; these stand for Left Flush Left, and so forth.

@b[Overstruck]@\The "Overstruck" parameter controls how many times
@index(OVERSTRUCK environment parameter) @index(overstriking)
(if any) the enclosed text is to be overstruck.  It is only meaningful
on devices capable of overstriking (e.g. line printers).  The default,
"Overstruck 0", means no overstriking.  "Overstruck 1" means overstrike
once (thus producing a double-strike), and so forth.  You may provide
an integer as large as you want, but your printer must suffer the
consequences of large numbers.

@b[PageBreak]@\The "PageBreak" parameter causes page breaks before,
@index(PAGEBREAK environment parameter) @index(page breaks)
after, or around the environment.  It takes one of four keywords
as an argument: OFF, BEFORE, AFTER, or AROUND.  The default is
"PageBreak Off".

@b[RightMargin]@\See "LeftMargin" and "LineWidth".
@index(RIGHTMARGIN environment parameter) @index(right margin)
@index(page right margin) @index(page magins)


@b[SaveBox]@\The "SaveBox" parameter is specialized and obscure.
@index(SAVEBOX environment parameter) @index(footnote separator)
It takes an identifier as an argument, and upon exit from the
environment, the entire contents of the environment -- text,
control commands, and all -- is saved in SCRIBE's symbol table
in text-box format with the name provided, and does not appear
in the actual text.  SaveBox is used to build a box containing
a footnote separator.

@b[Spaces]@\The "Spaces" parameter specifies the disposition
@index(SPACES environment parameter) @index(disposition of spaces)
of spaces in text.  Its arguments and behavior are similar to
the "LeadingSpaces" parameter (q.v.).  "Spaces" defaults to
COMPACT (see "LeadingSpaces").  If "Spaces" is specified and
"LeadingSpaces" is not, then "LeadingSpaces" will not
be inherited from the surrounding environment
but will be set equal to the value of the "Spaces" parameter.

@b[Spacing]@\The "Spacing" paramter specifies the between-line
@index(SPACING environment parameter) @index(inter-line spacing)
spacing of normal text.  It needs an argument in vertical
distance units or an unsigned integer or decimal.  The distance
specified by "Spacing" is baseline-to-baseline distance.
Thus, "Spacing 1" sets spacing to single (which means different
@index(single spacing)
things on different devices; the definition of single spacing
is contained in a routine in the device driver routine), while
"Spacing 0.5inch" means that 1/2 inch of space will be used
between the bottom of one row of text and the bottom of the next.
On the XGP, "Spacing 0" will not cause overstriking, but will cause
@index(XGP) @index(device XGP)
the text rows to be abutted with no spacing in between.  On other
devices, "Spacing 0" will cause overstriking.
@index(overstriking)

@b[Spread]@\The "Spread" parameter controls inter-paragraph
@index(SPREAD environment parameter) @index(inter-paragraph spacing)
spacing.  It wants a vertical distance specification as an argument.
"Spread" amount of distance is added to the normal inter-line spacing
to get the inter-paragraph spacing.  "Spread 1" will cause double 
spacing between paragraphs.
@index(double spacing between paragraphs)

@b[TopMargin]@\See "BottomMargin".
@index(TOPMARGIN environment parameter) @index(page margins)
@index(top margin) @index(page top margin)

@b[Underline]@\The "Underline" parameter controls underlining
@index(UNDERLINE environment parameter) @index(underlining)
inside the environment.  It takes as an argument a keyword
describing what is to be underlined.  The argument must
be from the set
{ALL, OFF, NONBLANK, ALPHANUMERICS}.  "Underline All" causes
all characters in the environment to be underlined, etc.

@b[Use]@\The "Use" parameter is a subroutine call to another
@index(USE environment parameter) @index(COPY environment parameter)
environment.  It is similar to the "Copy" parameter, with one
important exception.  The "Copy" parameter makes a copy of the
environment and stores it in the definition of the environment
being defined; the "Use" parameter just makes a note of the
name of the referenced environment.  Then, each time the
environment that contains the "Use" parameter is entered, the
@@Enter processor will process the parameters of the environment
that it references.  "Use" saves core over "Copy", and also allows
a single @@Modify to change many environments: if you @@Modify
@index(@@Modify)
some environment that many others "Use", then they will all
process the modified version rather than the unmodified version.

@b[Visible]@\See "Invisible".
@index(VISIBLE environment parameter)

@b[Within]@\The "Within" parameter to an environment is used 
@index(WITHIN environment parameter) @index(numbered paragraphs)
in paragraph numbering when there is no "Counter" parameter.
If there is a "Counter" parameter, the "Numbered" parameter will
@index(COUNTER environment parameter)
be ignored, and therefore the "Within" parameter will be ignored.
When a "Numbered" template is being evaluated to generate a numeric
string to place into the text, it might contain a "#" character,
which means 'value of parent counter'.  The "Within" parameter
@index(parent counter)
specifies a parent counter.  Thus, if you do
@example{@@Enter(Enumerate,Numbered "#.1",
	Within Chapter)}
and (say) the chapter is number 6, then the paragraphs of the
enumeration will be numbered 6.1, 6.2, 6.3, etc.

@leave(Description)
@chap(Counters, Portions, Figures, Tables, and such)
In this chapter we describe the S@c[cribe] counter mechanism and the
various pieces of S@c[cribe] that talk to it.

A "counter" is a data type; examples of counters that are predeclared
@index(counter)
are "Page", "FootNote", and possibly "Chapter" (if a sectioned
@index(PAGE counter) @index(FOOTNOTE counter) @index(CHAPTER counter)
document type is being produced).

A "Portion" is a piece of the document that is collated 
@index(Portion)
separately from the rest, even though it is generated
in parallel.  The table of contents is the best example
@index(table of contents)
of a portion.  For each portion, there is a symbol-table
entry of type "Portion", which has an associated scratch file.
At the end of execution, after the end of the manuscript
file has been reached, S@c[cribe] will read in all of the
portion files and process the text in them.
The @@Generate command declares portions; the first reference to
@index(@@Generate)
a portion creates the scratch file and opens it for output.
  