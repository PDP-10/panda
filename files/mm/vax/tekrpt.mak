@Comment[
	Strings which much be defined:
		@String(ReportDate="June 14, 1985")
		@String(Number="1223")
	]

@Marker(Make,TEKRPT,ImPress,X2700,NonScaleableLaser)
@Define(BodyStyle,Font BodyFont,Spacing 1.5,Spread 0.8)
@Define(NoteStyle,Font SmallBodyFont,FaceCode R,Spacing 1,Spread 0.5)
@LibraryFile(Serif)

@Generate(Contents)
@Send(Contents "@NewPage(0)@Set(Page=1)@Style(PageNumber <@i>)")
@Send(Contents "@PrefaceSection(Table of Contents)")
@Send(Contents "@define(foot,invisible)")

@Pageheading(Left="@B(Technical Report No. @Value(number))",
	right="@B(Page @Value(page))")
@Pagefooting(Left="@B(Wesleyan University)",right="@B(@Value(ReportDate))")

@Modify(zone,spacing .5)
@Modify(Heading,Above .9,Below .6)

@Define(Mast1,Nofill,LeftMargin 0,Break,Use B,Spacing .5,Spaces Kept,
	Font TitleFont2,Indent 0,Fixed 1inch,Below 1.5", AfterEntry
"@tabclear()
@tabdivide(2)
@Bar()
@Blankspace(3.5mm)
  Computing Center@\*@>Wesleyan University  @\
@Bar()",below .5)
@Define(Mast2,Nofill,LeftMargin 0,Break,Use B,Spacing .5,Spaces Kept,
	Font TitleFont2,Indent 0,Fixed 9.5inch,Below 0, AfterEntry
"@tabclear()
@tabdivide(2)
@Bar()
@Blankspace(3.5mm)
  Technical Report@\*@>@value(reportdate)  @\
@Bar()")

@Define(Credit,nofill,leftmargin 0,break,Facecode B,spaces kept,
	Font Titlefont2,Indent 0,Fixed 5.25inch,afterentry "@tabclear()
@tabdivide(2)")

@Define(ReportTitle,Break,Fixed 3inches)

@Define(Copyrite,Fixed 9inches,Facecode B,
	AfterEntry "@center[Copyright (C) @Value(year)]")

@Define(HDX,Hyphenation off,LeftMargin 0,Indent 0,Fill,Spaces compact,
	 Below 0,Break,Need 4,Justification Off,FaceCode R)
@Define(Hd2,Use HdX,Font TitleFont3,Above 0.4inch,FaceCode B,
	Below 0.4in,PageBreak Before)
@Define(Hd2A=HD2,Centered)
@Define(Hd3,Use HdX,Font TitleFont2,Above 0.4inch,FaceCode B)
@Define(Hd4,Use HdX,Font TitleFont1,Above 0.3inch,FaceCode B)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	 Above 0,Spacing 1,Below 0,Break,Spread 0,Font TitleFont0,FaceCode R)
@Define(Tc2=TcX,LeftMargin 8)
@Define(Tc3=TcX,LeftMargin 12)
@Define(Tc4=TcX,LeftMargin 16)
@Counter(Section,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1.],Referenced [@#@:.@1],IncrementedBy
Use,Announced)
@Counter(Appendix,TitleEnv hd2,ContentsEnv TC2,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced,Alias Section)
@Counter(AppendixSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1.],Referenced [@#@:.@1],IncrementedBy
Use,Announced)
@Counter(UnNumbered,TitleEnv HD2,ContentsEnv TC2,Announced,Alias Section)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@:.@1.],IncrementedBy Use,Referenced [@#@:.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,
	  Numbered [@#@:.@1.],IncrementedBy Use)
@Counter(PrefaceSection,TitleEnv HD2A,Alias Section)

@Equate(Chapter=Section,Sec=Section,Subsec=SubSection,Para=Paragraph,
	 SubSubSec=Paragraph)

@LibraryFile(Figures)
@LibraryFile(TitlePage)

@Begin(Text,Indent 5,LeftMargin 1inch,TopMargin 1inch,BottomMargin 1inch,
	LineWidth 6.5in,Use BodyStyle,FaceCode R)
@Set(Page=0)
