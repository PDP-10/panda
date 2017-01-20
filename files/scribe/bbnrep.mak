@Marker(Make,BBNReport,Diablo)
@Comment{

BBNReport Document Type in format approved by BBN Publications Dept
(See user documentation maintained in <scribe>local.mss)

Changes from standard Scribe document types:
	Title page--macro available
	Draft switch used for draft pagefootings
	Table and Figure titles upper case.
	Index available

}

@Define(BodyStyle,Spacing 1.5,Spread 1.0)
@Define(TitleStyle,Spacing 1,Spread 0)
@Define(NoteStyle,Spacing 1,Spread 0.3)
@TypeWheel(Elite 12)
@Message[
(Use Style command to specify different Typewheel.)
]

@Enable(Outline,Index,Contents,FigureContents,TableContents)
@Send(Contents "@Style(PageNumber <@i>)@Set(Page=0)")
@Send(Contents "@NewPage(0)@!@PrefaceSection(Table of Contents)")
@Send(Contents "@>Page@*")

@Send(#Index "@UnNumbered(Index)",
	#Index "@Begin(IndexEnv)")
@SendEnd(#Index "@End(IndexEnv)")
@Define(IndexEnv,Break,CrBreak,Fill,BlankLines Kept,
	Use TitleStyle,Spaces Kept,LeftMargin +18,Indent -8)

@Send(FigureContents "@Style(PageNumber <@i>)")
@Send(FigureContents "@PrefaceSection(List of Figures)")

@Send(TableContents "@Style(PageNumber <@i>)")
@Send(TableContents "@PrefaceSection(List of Tables)")

@Comment(

Canonical environment for placing titles of counters [HDX].
See also all the other HD environments and the form defined
in the TitleForm attribute of the various counter definitions.

)
@Define(HDX,Use TitleStyle,LeftMargin 0,Indent 0,
	Break,Fill,Justification Off,Spaces Compact,
	Use B,TabExport False)
@Comment{Hd0 is the heading for a MajorPart, an undocumented
counter for major manuscript divisions}
@Define(Hd0,Use HdX,
	Sink 3in,Below 2in,
	Centered,Capitalized,PageBreak UntilOdd)

@Comment{Hd1 is environment for Level 1 titles, chapter}
@Define(Hd1,Use HdX,
	PageBreak UntilOdd,Capitalized,
	Above 3,Below 2)

@Comment{Hd1A is for centered titles, appendix, unnumbered}
@Define(Hd1A,Use HdX,
	PageBreak UntilOdd,Capitalized,Centered,
	Below 4.5)

@Comment{Hd2 is environment for Level 2 titles, section,
	appendixsection}
@Define(Hd2,Use HdX,
	Above 2.5,Below 2,Need 5)

@Comment{Hd3 is environment for Level 3 titles }
@Define(Hd3,Use HdX,
	Above 1.5,Below 1.5,Need 4.5)

@Comment{Hd4 is environment for Level 4 titles }
@Define(Hd4,Use HdX,
	Above 1.5,Below 0,Need 3)

@Comment{TCX is canonical environment for Table of Contents
titles.  See also the ContentsForm attribute of the counter
definition}
@Define(TCX,Use TitleStyle,LeftMargin 0,RightMargin 5,Indent 0,
	Break,Fill,Justification Off,Spaces Compact)

@Comment{Tc0 is environment for MajorPart entry, see Hd0}
@Define(Tc0,Use TcX,
	Above 1inch,Below 0.5inch,Need 1inch,Centered,Capitalized,Use B,
	TabExport False)

@Comment{Tc1 is environment for Level 1 entries}
@Define(Tc1,Use TcX,
	Use B,TabExport False,
	Above 3,Below 1.5,Need 3)

@Comment{Tc2 is environment for Level 2 entries}
@Define(Tc2,Use TcX,
	Need 3)

@Comment{Tc3 is environment for Level 3 entries}
@Define(Tc3,Use TcX,
	Above 0,Below 0,Need 2)

@Comment{Tc4 is environment for Level 4 entries. 
BBN documents do not have Level 4 entries in the table
of contents, so this definition has been converted
to a comment.
@Define(Tc4,Use TcX,
	Above 0,Below 0,Need 2)}

@Comment{Table of Contents format for table/figure titles}
@Define(TcC,Use TcX,
	Above 0,Below 0,Need 2)

@Comment{Counter definitions -- Sectioning Commands}
@Counter(MajorPart,Incrementedby Use,Announced,Numbered <@I>,
TitleForm "@Hd0{@text[@blankspace(2inch)]PART @parm(referenced)@blankspace(1cm)@parm(title)}",
ContentsForm "@Tc0{@parm(numbered)@ @ @rfstr(@parm(page))@parm(title)}")

@Counter(Chapter,Incrementedby Use,Announced,
	Numbered <@1.>,Referenced <@1>,
TitleForm "@Hd1{@parm(numbered)@ @ @$@parm(title)}",
ContentsForm "@Tc1{SECTION @parm(numbered)@ @ @$@!@rfstr(@parm(page))@parm(title)}")

@Counter(Section,Incrementedby Use,Announced,Within Chapter,
Numbered <@#@:.@1>,Referenced <@#@:.@1>,
TitleForm "@Hd2{@parm(numbered)@ @ @$@parm(title)}",
ContentsForm "@Tc2{@/@parm(numbered)@ @ @$@rfstr(@parm(page))@parm(title)}")

@Counter(SubSection,Incrementedby Use,Announced,Within Section,
Numbered <@#@:.@1>,Referenced <@#@:.@1>,
TitleForm "@Hd3{@parm(numbered)@ @ @$@parm(title)}",
ContentsForm "@Tc3{@/@parm(numbered)@ @ @$@rfstr(@parm(page))@parm(title)}")

@Counter(Paragraph,Incrementedby Use,Announced,Within SubSection,
Numbered <@#@:.@1>,Referenced <@#@:.@1>,
TitleForm "@Hd4{@parm(numbered)@ @ @$@parm(title)}")

@Counter(PrefaceSection,Alias Chapter,
	TitleForm "@Hd1A{@$@parm(title)}")

@Counter(UnNumbered,Alias Chapter,Announced,
	TitleForm "@Hd1A{@$@parm(title)}",
	ContentsForm "@Tc1{@$@rfstr(@parm(page))@parm(title)}")

@Counter(Appendix,Alias Chapter,Announced,Incrementedby Use,
Numbered <@A>,Referenced <@A>,
TitleForm "@Hd1A{Appendix @parm(referenced)@*@parm(title)}",
ContentsForm "@Tc1(APPENDIX @parm(numbered).@ @ @$@!@rfstr(@parm(page))@parm(title))")

@Counter(AppendixSection,Incrementedby Use,Announced,Within Appendix,
Numbered <@#@:.@1>,Referenced <@#@:.@1>,
TitleForm "@Hd2{@parm(numbered)@ @ @$@parm(title)}",
ContentsForm "@Tc2{@/@parm(numbered)@ @ @$@rfstr(@parm(page))@parm(title)}")

@Counter(AppendixSubSection,Incrementedby Use,Announced,Within AppendixSection,
Numbered <@#@:.@1>,Referenced <@#@:.@1>,
TitleForm "@Hd3{@parm(numbered)@ @ @$@parm(title)}",
ContentsForm "@Tc3{@/@parm(numbered)@ @ @$@rfstr(@parm(page))@parm(title)}")

@Comment{Changes to standard environments
Most local modifications of the standard environments are
in LOCALM.LIB.  A few, which are specific to BBN report, are here}
@Modify(Itemize,Numbered <-  @,*  >,LeftMargin +6)

@Comment{Redefine the standard figure and table definitions to
accommodate local numbering needs.}
@Counter(FigureCounter,Numbered <FIG.  @1.  @@$>,Referenced <@1>,
Table "FigureContents",Init 0,
ContentsForm "@TcC{@parm(numbered)@ @ @$@rfstr(@parm(page))@parm(title)}")
@Define(Figure,Counter FigureCounter,
	Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,NumberLocation LFL,TabExport False)

@Counter(TableCounter,Numbered <TABLE @1.  @@$>,Referenced <@1>,
Table "TableContents",Init 0,
ContentsForm "@TcC{@parm(numbered)@ @ @$@rfstr(@parm(page))@parm(title)}")
@Define(Table,Counter TableCounter,
	Break,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,NumberLocation LFL,TabExport False)

@Define(CaptionEnv,Fill,Break,Continue Off,Indent 0,Use NoteStyle,
	Justification Off,Capitalized,Initialize "@TabClear()",
	Above 2,Below 2)

@Define(FullPageFigure=Figure,FloatPage)
@Define(FullPageTable=Table,FloatPage)

@Comment{

			TITLE PAGES

We have the standard title page mechanisms from the TitlePage
library, a titlepage environment called BBNTitlepage that can
include the same environments as the standard one but is flushleft,
and a Form for collecting title page information and putting it
out in BBN cover page format.

}

@LibraryFile(TitlePage)

@Define(BBNTitlePage,Break,PageBreak Around,Above 4.4inches,
	FlushLeft,Indent 0,BlankLines Kept,Spacing 1)
@Define(DocLine,Break,FlushLeft,Fixed 2cm)
@Define(AuthorBox,Fill,Fixed 7cm,Use TitleStyle)
@Define(ExtraBox,Fixed 4.8inches,Break,NoFill,Use TitleStyle)
@Define(ClientBox,NoFill,Fixed 16cm,Break,
	Initialize "Prepared by:@*
Bolt Beranek and Newman Inc.
50 Moulton Street
Cambridge, Massachusetts @ 02138@*@*
Prepared for:@*
"
)

@Comment{     Definition of Synonyms      }
@Equate(Sec=Section,Subsec=Subsection,SubsubSection=Paragraph,
	Subsubsec=Paragraph,AppendixSec=AppendixSection,
	AppendixSubSec=AppendixSubSection,AppSubSec=AppendixSubSection,
	Para=Paragraph)

@Comment{Here is the mandatory Text environment that encloses the
whole document.  This sets the global defaults that can be overriden
with Style keywords in the manuscript.}
@Comment{Modify the placement of the running footer
	so that it falls in the right place on BBN Model
	Paper.  The same justification goes for the Top and Bottom
	Margin values in the overall text environment below.}
@Modify(FTG,Fixed 58)
@Begin(Text,Indent 2,Use BodyStyle,LineWidth 6.5inches,
	LeftMargin 0.5inch,BottomMargin 1.1inch,TopMargin 1.0inch,
	Justification,Spaces Compact,
	Font CharDef,FaceCode R)
@Style(DoubleSided,BindingMargin 0.3inch)
@Style(PaperLength 10inches)
@Style(TimeStamp "8 Mar 52 at 16:30")
@Style(Date "8 March 1952")
@String(BBN="Bolt Beranek and Newman Inc.")
@String(DocNumberString="Unassigned")
@Set(page=0)

@Comment{The Form defining the TitlePage stuff}
@Form(TitlePageInfo={@Begin(BBNTitlePage)
@DocLine(Report No. @parm[DocNumber,Default "DocNumber field unassigned"])
@Begin(TitleBox,Fill,Use B,Use C)@parm(DocTitle,Default 
"DocTitle field to be supplied")@end(TitleBox)
@Value(Month)@ @Value(Year)
@ExtraBox(@parm(ExtraLines,Default ""))
@AuthorBox(@parm(DocAuthors,Default "DocAuthors field to be supplied"))
@ClientBox(@parm(DocClient,Default "DocClient field to be supplied"))
@End(BBNTitlePage)
@String(DocNumberString="@parm(DocNumber,Default <Unassigned>)")
@Case[DocNumberString,
Null <@PageHeading(Immediate,Odd,
	right "Bolt Beranek and Newman Inc.")
@PageHeading(Immediate,Even,
	left "Bolt Beranek and Newman Inc.")>,
Else <@PageHeading(Immediate,Odd,
	left "Report No. @value(DocNumberString)",
	right "Bolt Beranek and Newman Inc.")
@PageHeading(Immediate,Even,
	right "Report No. @value(DocNumberString)",
	left "Bolt Beranek and Newman Inc.")>]
})
@Case[DocNumberString,
Null <@PageHeading(Immediate,Odd,
	right "Bolt Beranek and Newman Inc.")
@PageHeading(Immediate,Even,
	left "Bolt Beranek and Newman Inc.")>,
Else <@PageHeading(Immediate,Odd,
	left "Report No. @value(DocNumberString)",
	right "Bolt Beranek and Newman Inc.")
@PageHeading(Immediate,Even,
	right "Report No. @value(DocNumberString)",
	left "Bolt Beranek and Newman Inc.")>]
@Case{Draft,
1 "@Style(SingleSided)
   @PageFooting[Immediate,Left <DRAFT>,
	Center <@Value(Page)>,
	Right `@value(weekday)@*@value(SourceFile)@>@value(timestamp)']",
Else "@PageFooting[Immediate,Center <@Value(Page)>]"}


@Marker(Make,BBNReport,LPT)

@Define(BodyStyle,Spacing 2,Spread 1.0)
@Define(TitleStyle,Spacing 1,Spread 0)
@Define(NoteStyle,Spacing 1,Spread 0.3)
@Define(AboveBelowStyle,Above 2,Below 2)

@Enable(Outline,Index,Contents,FigureContents,TableContents)
@Send(Contents "@Style(PageNumber <@i>)@Set(Page=0)")
@Send(Contents "@NewPage(0)@!@PrefaceSection(Table of Contents)")
@Send(Contents "@>Page@*")

@Send(#Index "@UnNumbered(Index)",
	#Index "@Begin(IndexEnv)")
@SendEnd(#Index "@End(IndexEnv)")
@Define(IndexEnv,Break,CrBreak,Fill,BlankLines Kept,
	Use TitleStyle,Spaces Kept,LeftMargin +18,Indent -8)

@Send(FigureContents "@Style(PageNumber <@i>)")
@Send(FigureContents "@PrefaceSection(List of Figures)")

@Send(TableContents "@Style(PageNumber <@i>)")
@Send(TableContents "@PrefaceSection(List of Tables)")

@Define(HDX,Use TitleStyle,LeftMargin 0,Indent 0,
	Break,Fill,Justification Off,Spaces Compact,
	Use B,TabExport False)
@Comment{Hd0 is the heading for a MajorPart, an undocumented
counter for major manuscript divisions}
@Define(Hd0,Use HdX,
	Sink 3in,Below 2in,
	Centered,Capitalized,PageBreak UntilOdd)

@Define(Hd1,Use HdX,
	PageBreak UntilOdd,Capitalized,
	Above 3,Below 2)

@Define(Hd1A,Use HdX,
	PageBreak UntilOdd,Capitalized,Centered,
	Below 4.5)

@Define(Hd2,Use HdX,
	Above 2.5,Below 2,Need 5)

@Define(Hd3,Use HdX,
	Above 1.5,Below 1.5,Need 4.5)

@Define(Hd4,Use HdX,
	Above 1.5,Below 0,Need 3)

@Define(TCX,Use TitleStyle,LeftMargin 0,RightMargin 5,Indent 0,
	Break,Fill,Justification Off,Spaces Compact)

@Define(Tc0,Use TcX,
	Above 1inch,Below 0.5inch,Need 1inch,Centered,Capitalized,Use B,
	TabExport False)

@Define(Tc1,Use TcX,
	Use B,TabExport False,
	Above 3,Below 1.5,Need 3)

@Define(Tc2,Use TcX,
	Need 3)

@Define(Tc3,Use TcX,
	Above 0,Below 0,Need 2)

@Define(TcC,Use TcX,
	Above 0,Below 0,Need 2)

@Counter(MajorPart,Incrementedby Use,Announced,Numbered <@I>,
TitleForm "@Hd0{@text[@blankspace(2inch)]PART @parm(referenced)@blankspace(1cm)@parm(title)}",
ContentsForm "@Tc0{@parm(numbered)@ @ @rfstr(@parm(page))@parm(title)}")

@Counter(Chapter,Incrementedby Use,Announced,
	Numbered <@1.>,Referenced <@1>,
TitleForm "@Hd1{@parm(numbered)@ @ @$@parm(title)}",
ContentsForm "@Tc1{SECTION @parm(numbered)@ @ @$@!@rfstr(@parm(page))@parm(title)}")

@Counter(Section,Incrementedby Use,Announced,Within Chapter,
Numbered <@#@:.@1>,Referenced <@#@:.@1>,
TitleForm "@Hd2{@parm(numbered)@ @ @$@parm(title)}",
ContentsForm "@Tc2{@/@parm(numbered)@ @ @$@rfstr(@parm(page))@parm(title)}")

@Counter(SubSection,Incrementedby Use,Announced,Within Section,
Numbered <@#@:.@1>,Referenced <@#@:.@1>,
TitleForm "@Hd3{@parm(numbered)@ @ @$@parm(title)}",
ContentsForm "@Tc3{@/@parm(numbered)@ @ @$@rfstr(@parm(page))@parm(title)}")

@Counter(Paragraph,Incrementedby Use,Announced,Within SubSection,
Numbered <@#@:.@1>,Referenced <@#@:.@1>,
TitleForm "@Hd4{@parm(numbered)@ @ @$@parm(title)}")

@Counter(PrefaceSection,Alias Chapter,
	TitleForm "@Hd1A{@$@parm(title)}")

@Counter(UnNumbered,Alias Chapter,Announced,
	TitleForm "@Hd1A{@$@parm(title)}",
	ContentsForm "@Tc1{@$@rfstr(@parm(page))@parm(title)}")

@Counter(Appendix,Alias Chapter,Announced,Incrementedby Use,
Numbered <@A>,Referenced <@A>,
TitleForm "@Hd1A{Appendix @parm(referenced)@*@parm(title)}",
ContentsForm "@Tc1(APPENDIX @parm(numbered).@ @ @$@!@rfstr(@parm(page))@parm(title))")

@Counter(AppendixSection,Incrementedby Use,Announced,Within Appendix,
Numbered <@#@:.@1>,Referenced <@#@:.@1>,
TitleForm "@Hd2{@parm(numbered)@ @ @$@parm(title)}",
ContentsForm "@Tc2{@/@parm(numbered)@ @ @$@rfstr(@parm(page))@parm(title)}")

@Counter(AppendixSubSection,Incrementedby Use,Announced,Within AppendixSection,
Numbered <@#@:.@1>,Referenced <@#@:.@1>,
TitleForm "@Hd3{@parm(numbered)@ @ @$@parm(title)}",
ContentsForm "@Tc3{@/@parm(numbered)@ @ @$@rfstr(@parm(page))@parm(title)}")

@Comment{Changes to standard environments}
@Modify(Itemize,Numbered <-  @,*  >,LeftMargin +6)

@Counter(FigureCounter,Numbered <FIG.  @1.  @@$>,Referenced <@1>,
Table "FigureContents",Init 0,
ContentsForm "@TcC{@parm(numbered)@ @ @$@rfstr(@parm(page))@parm(title)}")
@Define(Figure,Counter FigureCounter,
	Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,NumberLocation LFL,TabExport False)

@Counter(TableCounter,Numbered <TABLE @1.  @@$>,Referenced <@1>,
Table "TableContents",Init 0,
ContentsForm "@TcC{@parm(numbered)@ @ @$@rfstr(@parm(page))@parm(title)}")
@Define(Table,Counter TableCounter,
	Break,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,NumberLocation LFL,TabExport False)

@Define(CaptionEnv,Fill,Break,Continue Off,Indent 0,Use NoteStyle,
	Justification Off,Capitalized,Initialize "@TabClear()",
	Above 2,Below 2)

@Define(FullPageFigure=Figure,FloatPage)
@Define(FullPageTable=Table,FloatPage)

@LibraryFile(TitlePage)

@Define(BBNTitlePage,Break,PageBreak Around,Above 4.4inches,
	FlushLeft,Indent 0,BlankLines Kept,Spacing 1)
@Define(DocLine,Break,FlushLeft,Fixed 2cm)
@Define(AuthorBox,Fill,Fixed 7cm,Use TitleStyle)
@Define(ExtraBox,Fixed 4.8inches,Break,NoFill,Use TitleStyle)
@Define(ClientBox,NoFill,Fixed 16cm,Break,
	Initialize "Prepared by:@*
Bolt Beranek and Newman Inc.
50 Moulton Street
Cambridge, Massachusetts @ 02138@*@*
Prepared for:@*
"
)

@Comment{     Definition of Synonyms      }
@Equate(Sec=Section,Subsec=Subsection,SubsubSection=Paragraph,
	Subsubsec=Paragraph,AppendixSec=AppendixSection,
	AppendixSubSec=AppendixSubSection,AppSubSec=AppendixSubSection,
	Para=Paragraph)

@Modify(FTG,Fixed 58)
@Begin(Text,Indent 2,Use BodyStyle,LineWidth 6.5inches,
	LeftMargin 0.5inch,BottomMargin 1.1inch,TopMargin 1.0inch,
	Justification,Spaces Compact,
	Font CharDef,FaceCode R)
@Style(DoubleSided,BindingMargin 0.3inch)
@Style(PaperLength 10inches)
@Style(TimeStamp "8 Mar 52 at 16:30")
@Style(Date "8 March 1952")
@String(BBN="Bolt Beranek and Newman Inc.")
@String(DocNumberString="Unassigned")
@Set(page=0)

@Form(TitlePageInfo={@Begin(BBNTitlePage)
@DocLine(Report No. @parm[DocNumber,Default "DocNumber field unassigned"])
@Begin(TitleBox,Fill,Use B,Use C)@parm(DocTitle,Default 
"DocTitle field to be supplied")@end(TitleBox)
@Value(Month)@ @Value(Year)
@ExtraBox(@parm(ExtraLines,Default ""))
@AuthorBox(@parm(DocAuthors,Default "DocAuthors field to be supplied"))
@ClientBox(@parm(DocClient,Default "DocClient field to be supplied"))
@End(BBNTitlePage)
@String(DocNumberString="@parm(DocNumber,Default <Unassigned>)")
@Case[DocNumberString,
Null <@PageHeading(Immediate,Odd,
	right "Bolt Beranek and Newman Inc.")
@PageHeading(Immediate,Even,
	left "Bolt Beranek and Newman Inc.")>,
Else <@PageHeading(Immediate,Odd,
	left "Report No. @value(DocNumberString)",
	right "Bolt Beranek and Newman Inc.")
@PageHeading(Immediate,Even,
	right "Report No. @value(DocNumberString)",
	left "Bolt Beranek and Newman Inc.")>]
})
@Case[DocNumberString,
Null <@PageHeading(Immediate,Odd,
	right "Bolt Beranek and Newman Inc.")
@PageHeading(Immediate,Even,
	left "Bolt Beranek and Newman Inc.")>,
Else <@PageHeading(Immediate,Odd,
	left "Report No. @value(DocNumberString)",
	right "Bolt Beranek and Newman Inc.")
@PageHeading(Immediate,Even,
	right "Report No. @value(DocNumberString)",
	left "Bolt Beranek and Newman Inc.")>]
@Case{Draft,
1 "@Style(SingleSided)
   @PageFooting[Immediate,Left <DRAFT>,
	Center <@Value(Page)>,
	Right `@value(weekday)@*@value(SourceFile)@>@value(timestamp)']",
Else "@PageFooting[Immediate,Center <@Value(Page)>]"}

