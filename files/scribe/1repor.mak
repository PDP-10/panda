@Comment[ Copyright (C) 1979 Brian K. Reid ]

@Comment{

Document type for form-1 Report.  This form was used to print
the Graduate Admissions booklet (titled "Graduate Studies in
Computer Science")

}
@Marker(Make,1Report,XGP)

@Define(BodyStyle,Font BodyFont,Spacing 1.3,Spread 0)
@Define(NoteStyle,Font SmallBodyFont,FaceCode R,Spacing 1)
@font(Nonie 12)

@Generate(Contents,Outline)
@Send(Contents "@PageHeading()@PageFooting()")
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=1)")
@Send(Contents "@PrefaceSection(Table of Contents)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 7,Justification Off)
@Define	(Hd0,Use HdX,Font TitleFont5,FaceCode R,Above 1inch,Below 0.5inch)
@Define(Hd1,Use HdX,Centered,Font TitleFont5,FaceCode R,Above .5inch,PageBreak UntilOdd)
@Define(HD1A=HD1,Centered)
@Define(Hd2,Use HdX,Font TitleFont3,FaceCode R,Above 0.4inch)
@Define(Hd3,Use HdX,Font TitleFont1,FaceCode R,Above 0.4inch)
@Define(Hd4,Use HdX,Font TitleFont1,FaceCode R,Above 0.3inch)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc0=TcX,Font TitleFont3,FaceCode R)
@Define(Tc1=TcX,Font TitleFont1,FaceCode R,Above 20raster,
	Below 20raster)
@Define(Tc2=TcX,LeftMargin 8,Font TitleFont0,FaceCode R)
@Define(Tc3=TcX,LeftMargin 12,Font TitleFont0,FaceCode R)
@Define(Tc4=TcX,LeftMargin 16,Font TitleFont0,FaceCode R)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1)
@Counter(Section,TitleEnv HD2,ContentsEnv tc2)
@Counter(SubSection,TitleEnv HD3,ContentsEnv tc3)
@Counter(Paragraph,TitleEnv HD4,ContentsEnv tc4)

@Counter(PrefaceSection,TitleEnv HD1A,Alias Chapter)

@LibraryFile(Figures)
@LibraryFile(Math)
@LibraryFile(TitlePage)

@Modify(EquationCounter,Within Chapter,Numbered <(@#@:.@1)>,
	Referenced "(@#@:.@1)")
@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph)
@Begin(Text,Indent 1Quad,LeftMargin 1inch,TopMargin 1inch,BottomMargin 1inch,
	LineWidth 6.2inches,
	Use BodyStyle,Justification,FaceCode R,Spaces Compact)
@Set(Page=0)
@Style(DoubleSided,BindingMargin=0.6inch)
@PageHeading(even,left "@value(page)")
@PageHeading(odd,right "@value(page)")
@Marker(Make,1Report,Diablo)
@Define(BodyStyle,Spacing 1.7,Spread 0.8)
@Define(TitleStyle,Spacing 1,Spread 0)
@Define(NoteStyle,Spacing 1,Spread 0.3)
@TypeWheel(Elite 12)

@Generate(Contents,Outline)
@Send(Contents "@PageHeading()@PageFooting()")
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=1)")
@Send(Contents "@PrefaceSection(Table of Contents)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  Use B,break,Need 5,Justification Off)
@Define	(Hd0,Use HdX,Above 1inch,Below 0.5inch)
@Define(Hd1,Use HdX,Above .5inch,PageBreak UntilOdd)
@Define(HD1A=HD1,Centered)
@Define(Hd2,Use HdX,Above 0.4inch)
@Define(Hd3,Use HdX,Above 0.4inch)
@Define(Hd4,Use HdX,Above 0.3inch)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc0=TcX)
@Define(Tc1=TcX,Above 0.2,Below 0.2,Use B)
@Define(Tc2=TcX,LeftMargin 5)
@Define(Tc3=TcX,LeftMargin 10)
@Define(Tc4=TcX,LeftMargin 15)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0,Numbered [@I],
	  IncrementedBy Use,Announced)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1],Announced)
@Counter(Appendix,TitleEnv HD1,ContentsEnv tc1,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced,Alias Chapter)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced,Alias Chapter)
@Counter(Section,Within Chapter,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use,Announced)
@Counter(AppendixSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use,Announced)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@:.@1],IncrementedBy Use,Referenced [@#@:.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use)

@Counter(PrefaceSection,TitleEnv HD1A,Alias Chapter)

@LibraryFile(Figures)
@LibraryFile(Math)
@LibraryFile(Titlepage)

@Modify(EquationCounter,Within Chapter,Numbered <(@#@:.@1)>,
	Referenced "(@#@:.@1)")
@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Begin(Text,Indent 3,Use BodyStyle,LeftMargin 1inch,TopMargin 1inch,
	BottomMargin 1inch,LineWidth 6.2inches,Justification,
	Spaces Compact,Font CharDef,FaceCode R)
@set(page=0)
@Style(DoubleSided,BindingMargin=0.6inch)
@PageHeading(Center "@value(page)")
@Marker(Make,1Report,File,PagedFile,CRT)
@Define(BodyStyle,Spacing 1)
@Define(TitleStyle,Spacing 1)
@Define(NoteStyle,Spacing 1)

@Generate(Contents,Outline)
@Send(Contents "@PageHeading()@PageFooting()")
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=1)")
@Send(Contents "@PrefaceSection(Table of Contents)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 5,Justification Off)
@Define	(Hd0,Use HdX,Above 1inch,Below 0.5inch)
@Define(Hd1,Use HdX,Above 3,PageBreak UntilOdd)
@Define(HD1A=HD1,Centered)
@Define(Hd2,Use HdX,Above 1)
@Define(Hd3,Use HdX,Above 3)
@Define(Hd4,Use HdX,Above 2)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc0=TcX)
@Define(Tc1=TcX,Above 1,Below 1)
@Define(Tc2=TcX,LeftMargin 5)
@Define(Tc3=TcX,LeftMargin 10)
@Define(Tc4=TcX,LeftMargin 15)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0,Numbered [@I],
	  IncrementedBy Use,Announced)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1],Announced)
@Counter(Appendix,TitleEnv HD1,ContentsEnv tc1,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced,Alias Chapter)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced,Alias Chapter)
@Counter(Section,Within Chapter,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use,Announced)
@Counter(AppendixSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use,Announced)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@:.@1],IncrementedBy Use,Referenced [@#@:.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use)

@Counter(PrefaceSection,TitleEnv HD1A,Alias Chapter)

@Libraryfile(Figures)
@LibraryFile(Math)
@Libraryfile(Titlepage)

@Modify(EquationCounter,Within Chapter,Numbered <(@#@:.@1)>,
	Referenced "(@#@:.@1)")
@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Begin(Text,Indent 2,Spread 1,Use BodyStyle,LineWidth 7.9inches,
	Spaces Compact,
	Justification,Font CharDef,FaceCode R)
@set(page=0)
@Style(DoubleSided,BindingMargin=0.6inch)
@PageHeading(Center "@value(page)")
@Marker(Make,1Report,GSI)

@Define(BodyStyle,Font BodyFont,Size 10,Spacing 13pts,Spread 0,FaceCode R)
@Define(NoteStyle,Font BodyFont,FaceCode R,Spacing 1,Size -2)
@font(CMU 3)

@Generate(Contents,Outline)
@Send(Contents "@PageHeading()@PageFooting()")
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=1)")
@Send(Contents "@PrefaceSection(Table of Contents)")

@Modify(SubHeading,Size +1)

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 7,Justification Off,Font HeadingFont,FaceCode B)
@Define	(Hd0,Use HdX,Size 16,Above 1inch,Below 0.5inch)
@Define(Hd1,Use HdX,Centered,Above .5inch,PageBreak UntilOdd,Size 13)
@Define(HD1A=HD1,Centered)
@Define(Hd2,Use HdX,Above 0.4inch,Size 11)
@Define(Hd3,Use HdX,Above 0.4inch,Size 10)
@Define(Hd4,Use HdX,Above 0.3inch,Size 10)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0,Font TitleFont,
	Use R)
@Define(Tc0=TcX)
@Define(Tc1=TcX,Size 12,Above 20raster,
	Below 20raster)
@Define(Tc2=TcX,LeftMargin 8,Size 10)
@Define(Tc3=TcX,LeftMargin 12,Size 10)
@Define(Tc4=TcX,LeftMargin 16,Size 10,FaceCode L)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1)
@Counter(Section,TitleEnv HD2,ContentsForm "@begin(Tc2)@parm(title)@end(Tc2)")
@Counter(SubSection,TitleEnv HD3)
@Counter(Paragraph,TitleEnv HD4)

@Counter(PrefaceSection,TitleEnv HD1A,Alias Chapter)

@LibraryFile(Figures)
@LibraryFile(Math)
@LibraryFile(TitlePage)

@Modify(EquationCounter,Within Chapter,Numbered <(@#@:.@1)>,
	Referenced "(@#@:.@1)")
@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph)
@Begin(Text,Indent 1Quad,LeftMargin 0.5 inch,TopMargin 1inch,
	BottomMargin 1inch,
	LineWidth 5inches,
	Use BodyStyle,Justification,FaceCode R,Spaces Compact)
@Set(Page=0)
@Style(DoubleSided,BindingMargin=0.6inch)
@PageHeading(even,left "@value(page)")
@PageHeading(odd,right "@value(page)")
@Marker(Make,1Report)
@Define(BodyStyle,Spacing 2)
@Define(TitleStyle,Spacing 1)
@Define(NoteStyle,Spacing 1)

@Generate(Contents)
@Send(Contents "@PageHeading()@PageFooting()")
@Send(Contents "@Style(PageNumber <@i>)@NewPage(0)@Set(Page=1)")
@Send(Contents "@PrefaceSection(Table of Contents)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 2,Below 1,
	  Use B,break,Need 5,Justification Off)
@Define	(Hd0,Use HdX,Above 1inch,Below 0.5inch)
@Define(Hd1,Use HdX,Above 3,PageBreak UntilOdd)
@Define(HD1A=HD1,Centered)
@Define(Hd2,Use HdX)
@Define(Hd3,Use HdX)
@Define(Hd4,Use HdX)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc0=TcX)
@Define(Tc1=TcX,Above 1,Below 1,Use B)
@Define(Tc2=TcX,LeftMargin 5)
@Define(Tc3=TcX,LeftMargin 10)
@Define(Tc4=TcX,LeftMargin 15)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0,Numbered [@I],
	  IncrementedBy Use,Announced)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1],Announced)
@Counter(Appendix,TitleEnv HD1,ContentsEnv tc1,Numbered [@I.],
	  IncrementedBy,Referenced [@I],Announced,Alias Chapter)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced,Alias Chapter)
@Counter(Section,Within Chapter,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use,Announced)
@Counter(AppendixSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use,Announced)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@:.@1],IncrementedBy Use,Referenced [@#@:.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use)

@Counter(PrefaceSection,TitleEnv HD1A,Alias Chapter)

@Libraryfile(Figures)
@LibraryFile(Math)
@Libraryfile(Titlepage)

@Modify(EquationCounter,Within Chapter,Numbered <(@#@:.@1)>,
	Referenced "(@#@:.@1)")
@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Begin(Text,Indent 2,Spread 1,Use BodyStyle,LineWidth 6.5inches,
	Spaces Compact,
	Justification,Font CharDef,FaceCode R)
@set(page=0)
@Style(DoubleSided,BindingMargin=0.6inch)
@PageHeading(Center "@value(page)")
  