@make(bbnarticle)
@Comment{@device(penguin)}
@Case{device,
penguin `@specialfont(f1=<APL8>)'
,else `@Define(f1=R)
	@Modify(format,longlines wrap, indent +10)
	@Modify(example,longlines wrap,indent +10)
	@Style(linewidth 7.0in)'}
@modify(minus, script -0.9)

@begin(Titlepage)
@begin(TitleBox)
@Majorheading(BIBLIO)
@Heading(An Aid for
Entering and Updating
Bibliographic Files)
@end(TitleBox)
@Blankspace(2inches)
Craig Taylor
USC/ISI
@end(TitlePage)
@section(Introduction)
 BIBLIO is an extension of EMACS@cite(stallman) designed to aid in creating and
maintaining SCRIBE bibliographic (.BIB) files.@foot(See chapter 11 of the
SCRIBE manual@cite(scribe) for more information on bibliographic files.)@ @ @  
BIBLIO provides three types of aid: bibliographic entry templates, predefined
function keys and directly callable functions.  A template is an empty copy of
a bibliography entry which greatly simplifies typing entries by providing
matching delimiters, a complete set of field names for an entry and a reminder
of the fields' type.  A template is inserted in the bibliographic file by
typing its name and can easily be modified and formatted using the predefined
function keys.  For the advanced user, BIBLIO provides a group of directly
callable functions to sort entries, convert old files, allow word abbreviations
and do personal customization.

@section(Conventions)

The following notations are used throughout this document:

@begin(format)
@p(M-) = Ascii escape character.  In Emacs terminology the meta-key.

@p(C-M-) = Ascii control Z(^Z).  In Emacs the control-meta-key.

$ = Ascii escape character.

@z(@ ) = Ascii space character.

@z(M) = Ascii return character.

@ux(@ @ )@ = underlined characters are the minimum needed to identify a directly callable function.

@i(names) = italicized names are generic.

@i(entry) = refers to an entire bibliographic entry such as Article or Book.

@i(field) = refers to a subpart of an entry (e.g., key, publisher, etc.)
@end(format)

@section(How to use BIBLIO)
 BIBLIO is an EMACS library.@foot( If you are interested in using EMACS and
would like an EMACS manual@cite(emacs), send a message to <EMACS>@@ISIF or
PUBLICATIONS@@AI and ask for AI Memo 555.)@ @ @  To use it type @p(M-X @u(Lo)ad
Library$BIBLIO@z(M)); when the library is loaded, `@b(biblio)' will be
displayed on the mode line.  To invoke a bibliographic entry template, type
@p(@@Entry Name@z( )); after typing the space, the template for that entry will
expand.  The lines of the entry will indicate with @p(@@?)@ @  which fields are
optional and which can be satisfied by an alternative field.  Any field not
marked with a @p(@@?)@ @  is a required field.  These field types are used by
BIBLIO to remind the user which fields SCRIBE requires.

  Once an entry has been expanded it can be filled out by entering text in the
usual way or by using the predefined function keys.  The predefined keys
provide movement and manipulation functions described in the examples below and
completely defined, along with the directly callable functions, in sections
@ref(basic) and @ref(adv).

@section(Examples)
Three examples are given below.  The first example expands a template and
discusses the type of fields displayed.  The second example shows how to move
among the fields using BIBLIO's predefined keys.  Finally, the last example
shows how to clean up an entry by removing the useless fields.
@newpage
@begin(figure)
@ux(@>)
@blankspace(1line)
@begin(format)
@tabset(.3inches,3inches,5inches)
@@proc@z( )@\@\;Comment 1

@@Proceedings[@ @ ,@-(@z(t))@\@\;Comment 2
@\Key=<>,@\@\;Comment 3
@\Editor=<>,@\@@? or Organization@\;Comment 4
@\Organization=<>,@\@@? or Editor
@\Publisher=<>,
@\Title=<>,
@\Year=<>,
@\Address=<>,@\@@? Optional@\;Comment 5
@\Note=<>,@\@@? Optional
@\]

@@proc@z( )@-(@z(t))@\@\;Comment 6
@blankspace(1line)
@caption(Expanding a template)
@end(format)
@ux(@>)
@blankspace(2line)
Comments:
@begin(enumerate)
Entering @p(@@proc@z( )) causes the Proceedings bibliographic entry to be
expanded, displaying all the associated fields.

The typing cursor is represented as @z(t).  After the entry is expanded the
cursor is at the codeword position waiting for codeword to be entered.

This is an example of a required field.  See the SCRIBE manual for a
description of the field types.

This is an example of an alternative field.

Here's an optional field.

Typing @p(C-M-u) when the cursor is at the position shown on comment line 2,
results in the original word and space (i.e., It unexpands the entry).  This is
useful if you accidentally expand the wrong entry.
@end(enumerate)
@end(figure)

@begin(figure)
@ux(@>)
@blankspace(1line)
@begin(format)
@tabset(.3inches,3inches,5inches)
@@Misc[@ @ ThisIsTheCodeWord,@-(@z(t)@f1(1))@\@\;Comment 1
@\Key=<BIBLIO>,@\@\;Comment 2
@\Author=<>,@-(@z(t)@f1(3))@\@@? Optional@\;Comment 3
@\HowPublished=<>,@\@@? Optional
@\Note=<>,@\@@? Optional
@\Title=<>,@\@@? Optional
@\Year=<>@\@@? Optional
@\]@-(@z(t)@f1(4))@\@\Comment 4
@blankspace(1line)
@caption(Using the motion commands)
@end(format)
@ux(@>)
@blankspace(2line)
Comments:
@begin(enumerate)
This is where the cursor (@p(@z(t)@f1(1))) would be after expanding the
Misc entry and entering a codeword.

To move to and enter a value for a new field, type @p(M-n) (the next entry) and
the value.  In this case BIBLIO was entered.

Typing another @p(M-n) moves the cursor to @p(@z(t)@f1(3)).  Use @p(M-p)
(the previous entry) to move the cursor @i(prior) to the word BIBLIO on
the previous line.

A @b(]) indicates the end of the entry.  Typing @p(M-]) (move to end of entry)
will position the cursor to the right of the @b(]) (@p(@z(t)@f1(4))).
@p(M-[) (move to start of entry) moves the cursor to the beginning of the
codeword.
@end(enumerate)
@end(figure)

@begin(figure)
@ux(@>)
@blankspace(1line)
@begin(format)
@tabset(.3inches,3inches,5inches)
@@Proceedings[@ @ Test,@\@\Comment 1
@\Key=<AKey>,@\@\;Comment 2
@\Editor=<>,@\@@? or Organization@\;Comment 3
@\Organization=<Instead of an Editor>,@\@@? or Editor
@\Publisher=<Penguin>,
@\Title=<CleanupExample>,
@\Year=<1980>,
@\Address=<>,@\@@? Optional@\;Comment 4
@\Note=<>,@\@@? Optional
@\]

@@Proceedings[@ @ Test,@\@\;Comment 5
@\Key=<AKey>,
@\Organization=<Instead of an Editor>,
@\Publisher=<Penguin>,
@\Title=<CleanupExample>,
@\Year=<1980>,
@\]@-(@z(t))
@blankspace(1line)
@caption(Cleaning up an entry)
@end(format)
@ux(@>)
@blankspace(2line)
Comments:
@begin(enumerate)
When a entry is expanded all possible fields for that entry are displayed.  You
probably don't want to enter information for all of the fields displayed.
After the entry is completed to suit your needs, type @p(M-.) to delete empty
optional and empty satisfied alternative entries.  If you have forgotten one of
the required fields, you will be warned and the cursor left at the required
field needing information.  Enter the missing information and retype @p(M-.).
When the entire entry is acceptable, no message will be displayed and the
cursor will be after the closing @b(]).

A required field must be filled in, otherwise @p(M-.) will complain.

To satisfy @p(M-.) either the Editor or the Organization field must be filled
in.

If you don't fill in an optional field @p(M-.), won't care and will delete
the line if the field is empty.

This would be the result of typing @p(M-.) on the top half of this example.
Notice that the cursor is at the end of the entry.
@end(enumerate)
@end(figure)

@newpage
@section(Basic BIBLIO functions)
@label(basic)
 The process of loading the BIBLIO library automatically defines a set of
functions and connects these functions to predefined characters on the
keyboard.  These functions override any previously defined action for the
characters and are specifically tailored to work with bibliographic entries.

A list of basic functions, their predefined key and a description follow:
@begin(description)

@blankspace(1line)
@group{Next bibliographic field (@p(M-n)):@\Skips to the start of the next
field, positioning the typing cursor at the beginning of the field's value.}

@blankspace(1line)
@group{Previous bibliographic field (@p(M-p)):@\Skips to the previous field,
also positions the cursor at the value.}

@blankspace(1line)
@group{Skip to end of field (@p(M-s)):@\Skips to the end of the current field.}

@blankspace(1line)
@group{Next blank bibliographic field (@p(C-M-n)):@\Initially all of the field
values for a entry are empty and @p(M-n) and @p(C-M-n) work the same.  As you
fill in values, you may want to skip over the fields with values, @p(C-M-n)
does this.  @p(C-M-n) skips forward to the next @i(blank) field.}

@blankspace(1line)
@group{Previous blank bibliographic field (@p(C-M-p)):@\Similar to @p(C-M-n),
but skips backwards to a blank field value.}

@blankspace(1line)
@group{Start of entry (@p(M-[)):@\Moves the typing cursor to the beginning of
the codeword for the current entry.}

@blankspace(1line)
@group{End of entry (@p(M-])):@\Moves the cursor to the end of the current
entry (i.e., after the closing @b(])).}

@blankspace(1line)
@group{Unexpand entry (@p(C-M-u)):@\If you expanded an entry template by
accident, this function will restore the entry name as it was before the
expansion.  This function is only valid immediately after the template has been
expanded.}

@blankspace(1line)
@group{Copy codeword (@p(C-M-c)):@\Makes a copy of the codeword for this entry
after the typing cursor.  This is useful for copying the codeword into the key
and author's fields, when the fields all use the author's last name.}

@blankspace(1line)
@group{Create no field (@p(C-M-f)):@\Creates a value by combining the word
@i(no) with the current @i(field name) and inserts the combination in the
field's value.  Helpful when you don't know what to enter but want something to
show up in the bibliography.}

@blankspace(1line)
@group{Remove blank entries (@p(M-.)):@\When a entry is expanded all possible
fields for that entry are displayed.  You probably don't want to enter
information for all of the fields displayed.  After the entry is completed to
suit your needs, type @p(M-.), to delete empty optional and empty satisfied
alternative entries.  If you have forgotten one of the required fields, you
will be warned and the cursor left at the required field needing information.
Enter the missing information and retype @p(M-.).  When the entire entry is
acceptable, no message will be displayed and the cursor will be after the
closing @b(]).}

@blankspace(1line)
@group{Restore blank entries (@p(M-/)):@\After typing @p(M-.), all of the
empty fields will have been deleted.  To reinstate these fields use @p(M-/).
Typing @p(M-/) will redisplay all of the blank fields at the end of the entry
and place the cursor at the first blank field.}

@blankspace(1line)
@group{Print bibliographic summary (@p(M-?)):@\Displays a short summary.
The summary is two pages long; if you want to see the second page type a space,
otherwise type @p(^G).}

@blankspace(1line)
@group{Permanently display entry names (@p(M-X @u(Sh)ow
BIBLIO entries in window$@z(M))):@\Creates a second window at the top of the
screen and displays the bibliographic entry names in it for quick reference.}

@blankspace(1line)
@group{Disable BIBLIO keys (@p(M-X @u(BI)BLIO$@z(M))):@\Toggles between the
standard character definitions and those specially defined for BIBLIO.  By
toggling BIBLIO off the library remains loaded but inactive.}
@end(description)

All of the BIBLIO motion commands take an optional argument.  For example,
@p(M-3 M-]) will skip to the end of the third entry starting from the current
cursor position.

@section(Advanced BIBLIO functions)
@label(adv)
 The BIBLIO library is, in reality, a series of extensions built on the Word
Abbreviation Library.@foot{Detailed information on Word Abbreviation Library
@i[(WORDAB)] library can be found in INFO or the EMACS manual.}@ @ @ That is to
say, SCRIBE bibliographic entries are just very elaborate word abbreviations.
For the sophisticated user this can be of an enormous benefit since all the
power of the WORDAB library is available while using BIBLIO; e.g., customizing
the entry templates.

  Below are some of the features of WORDAB and the remaining features of
BIBLIO:

@begin(description)

@blankspace(1line)
@group{Sort by codeword (@p(M-X @u(So)rt entries by codeword$@z(M))):@\Sorts
the bibliographic entries by codeword.  This function will be automatically
invoked by @p(M-.) if the variable @b(automatic codeword sort) is set
non-zero.}

@blankspace(1line)
@group{Mark bibliographic entry (@p(C-M-m)):@\Places the mark at the end of the
entry and the point at the beginning.  This is useful for deleting or moving an
entire bibliographic entry.  With an argument, n entries from the
cursor are marked.}

@blankspace(1line)
@group{Add Global Word Abbreviation[WORDAB] (@p(C-X +)):@\Typed after a word
asks for its abbreviation and stores the abbreviation with word in the word
abbreviation list for later use.  If this function is given a negative
argument, it will delete a prior abbreviation.}

@blankspace(1line)
@group{Inverse Add Global Word Abbreviation[WORDAB] (@p(C-X -)):@\Typed after
an abbreviation asks for a word, stores the abbreviation with the word and
expands the abbreviation.}

@blankspace(1line)
@group{ Abbreviation Expand Only[WORDAB] (@p(C-M-@z( ))):@\Normally
an abbreviation is expanded after the punctuation is entered.  @p(C-M-@z( ))
forces the immediate expansion without any punctuation.}

@blankspace(1line)
@group{View an entry[WORDAB] (@p(M-X @u(L)ist @u(W)ord Abbrevs$)@i(Entry
Name)@p($@z(M))):@\Displays the fields of an entry.}

@blankspace(1line)
@group{Edit Word Abbreviations[WORDAB] (@p(M-X @u(E)dit @u(W)ord
Abbrevs$@z(M))):@\Calls EMACS recursively on the word abbreviations, allowing
modifications of the bibliographic entries to suit your tastes.  To exit use
@p(C-M-z).}

@blankspace(1line)
@group{Write Word Abbreviation File[WORDAB] (@p(M-X @u(Wr)ite @u(W)ord Abbrev
file$<)@i(Your Directory Name)@p(>$@z(M))):@\This stores a personal copy of the
words you've added plus any changes made to the bibliographic entries.  Next
time BIBLIO is loaded it will automatically restore your copy if it is
available.}
@end(description)

@section(Changing to a BIBLIO formatted file) 

@subheading(Converting existing bibliography files)

 BIBLIO provides a conversion function to rewrite any bibliographic file into
the form expected by BIBLIO.  This conversion is not guaranteed to be complete,
so you may have to hand translate a small portion.  Try it and see.  To do this
type, @p(M-X @u(Conv)ert to BIBLIO format$@z(M)).

@subheading(Assumptions)

 The TECO macros implementing the BIBLIO library make several assumptions.
If you didn't create your .BIB file using BIBLIO here are somethings to
consider:
@begin(enumerate)

The bibliographic file must contain only bibliographic entries.

All bibliographic entries start with @@@i(entry-name) then a @b([) and end
with a @b(]).

A field has the form `@i(field-name)=<@i(text)>' and an empty field is
considered to be `@i(field-name)=<>'.  The text of a field must not contain
`=<'.

The @b(@@?) is reserved for BIBLIO.  @p(M-.) will complain if @b(@@?) isn't
followed by the `optional' or the `alternative' indicators.

Optional fields have the indicator, `@@?@ Optional'.

Alternative fields are commented, `@@? or @i(Alt. field) {, @i(Alt.
field)}' where a value for any one of the alternative fields will allow this
field value to be empty.

All field names in the word abbreviations file should have a comma after them
including the last one.  @p(M-.) removes the trailing comma automatically.
@end(enumerate)

@newpage
@section(Summary)
@begin(figure)
@ux(@>)
@begin(format)
@tabset(.5inch,3inches)
@\Article
@\Book,  Booklet
@\InBook,  @u(InColl)ection,  @u(InProc)eedings
@\@u(Master)sThesis,  Manual,  Misc
@\@u(PhD)Thesis,  @u(Proc)eedings
@\@u(Tech)Report
@\@u(Unpub)lished
@end(format)
NOTE: The bibliographic entry names can be abbreviated as indicated by underlined characters.
@caption(Bibliographic Entry Names)
@end(figure)
@begin(figure)
@ux(@>)
@begin(format)
@tabset(.5inch,3inches)
@\@p(M-n) = Next field;@\@p(M-p) = Previous field;
@\@p(M-[) = Start of entry;@\@p(M-]) = End of entry;
@\@p(M-.) = Remove all blank fields;@\@p(M-/) = Reinsert blank fields;
@\@p(C-M-n) = Next blank field;@\@p(C-M-p) = Previous blank field;
@\@p(M-s) = Skip to end of field;@\@p(C-M-m) = Mark entry;
@\@p(C-M-u) = Unexpand entry;@\@p(M-u) = Unexpand word;
@\@p(C-M-c) = Copy codeword;@\@p(C-M-f) = Create no field;
@\@p(M-?) = BIBLIO summary.
@end(format)
@caption(Predefined Characters and their Functions)
@end(figure) 
@begin(figure)
@ux(@>)
@begin(format)
@tabset(.5inch,3inches)
@begin(p)
@\M-X@ @u(Lo)ad Library$BIBLIO@z(M)
@\M-X @u(Sh)ow BIBLIO entries in window$@z(M)
@\M-X @u(BI)BLIO$@z(M)
@\M-X @u(So)rt entries by codeword$@z(M)
@\M-X @u(Conv)ert to BIBLIO format$@z(M)
@\M-X @u(Wr)ite @u(W)ord Abbrev$<@i(Your Directory Name)>$@z(M)
@\M-X @u(E)dit @u(W)ord Abbrev$@z(M)
@\M-X @u(L)ist @u(W)ord Abbrevs$@i(Entry Name)$@z(M)
@end(p)
@end(format)
@caption(Directly Callable Functions)
@ux(@>)
@end(figure)
@newpage
@section(Conclusion)
 If you have any suggestions about the design, function and/or implementation
of this library send them to <CTaylor>@@ISIF.

@unnumbered(References)
@blankspace(1lines)
@bibliography
@newpage(1)    