@Marker(Make,Brochure,XGP)

@Define(BodyStyle,Font BodyFont,Spacing 1.5,Spread 0.8)
@Define(NoteStyle,Font SmallBodyFont,FaceCode R,Spacing 1)
@font(NewsGothic10)

@Generate(Contents,Outline)
@Send(Contents "@PageHeading()@PageFooting()")
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
@counter(ReferenceCounter,Numbered "[@1]",Referenced "@1",
        IncrementedBy tag)
@define(Bibliography=Description,LeftMargin 5,Indent -5,
        Counter ReferenceCounter,NumberLocation LFL,Spaces Tab,
        Spread 1,Spacing 1,Justification Off)

@Counter(FigureCounter,Numbered <Figure @1. >,
	 Referenced "@1",Init 0)
@Define(Figure,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,Counter FigureCounter,NumberLocation LFL)
@Define(FullPageFigure,Use Figure,FloatPage)
@Define(CaptionEnv=Center,FaceCode R)

@Define(TitlePage,Break,PageBreak Around,Centered,
	BlankLines Kept,Above 4.4inches)
@Define(TitleBox,Break,Fixed 1.8inches)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,Fixed 8.5inches,Fill,Justification)
@Define(CopyrightNotice,Fixed 8.0inches,Centered,
	Initialize "Copyright -C- @value{year} ")

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph)
@Enter(Text,Indent 1Quad,LeftMargin 1inch,TopMargin 1inch,BottomMargin 1inch,
	LineWidth 6.5inches,Spread 15raster,
	Use BodyStyle,Justification,FaceCode R,Spaces Compact)
@Set(Page=0)
@PageHeading(even,left "@value(page)")
@PageHeading(odd,right "@value(page)")
@Marker(Make,Brochure,Diablo)
@Define(BodyStyle,Spacing 1.7,Spread 0.8)
@Define(TitleStyle,Spacing 1,Spread 0)
@Define(NoteStyle,Spacing 1,Spread 0.3)

@Generate(Contents,Outline)
@Send(Contents "@PageHeading()@PageFooting()")
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
@counter(ReferenceCounter,Numbered "[@1]",Referenced "@1",
        IncrementedBy tag)
@define(Bibliography=Description,LeftMargin 5,Indent -5,
        Counter ReferenceCounter,NumberLocation LFL,Spaces Tab,
        Spread 1,Spacing 1,Justification Off)

@Counter(FigureCounter,Within Chapter,Numbered <Figure @#@:-@1: >,
	 Referenced "@#@:-@1",Init 0)
@Define(Figure,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,Counter FigureCounter,NumberLocation LFL)
@Define(FullPageFigure,Use Figure,FloatPage)
@Define(CaptionEnv=Center,FaceCode R)

@Define(TitlePage,Break,PageBreak Around,Centered,
	BlankLines Kept,Above 4.4inches)
@Define(TitleBox,Break,Fixed 1.8inches)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,Fixed 8.5inches,Fill,Justification)
@Define(CopyrightNotice,Fixed 8.0inches,Centered,
	Initialize "Copyright -C- @value{year} ")

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Enter(Text,Indent 3,Use BodyStyle,LeftMargin 1inch,TopMargin 1inch,
	BottomMargin 1inch,LineWidth 6.5inches,Justification,
	Spaces Compact,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Brochure,File,Editor,SOS,TECO)
@Define(BodyStyle,Spacing 1)
@Define(TitleStyle,Spacing 1)
@Define(NoteStyle,Spacing 1)

@Generate(Contents,Outline)
@Send(Contents "@PageHeading()@PageFooting()")
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
@counter(ReferenceCounter,Numbered "[@1]",Referenced "@1",
        IncrementedBy tag)
@define(Bibliography=Description,LeftMargin 5,Indent -5,
        Counter ReferenceCounter,NumberLocation LFL,Spaces Tab,
        Spread 1,Spacing 1,Justification Off)

@Counter(FigureCounter,Within Chapter,Numbered <Figure @#@:-@1: >,
	 Referenced "@#@:-@1",Init 0)
@Define(Figure,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,Counter FigureCounter,NumberLocation LFL)
@Define(FullPageFigure,Use Figure,FloatPage)
@Define(CaptionEnv=Center,FaceCode R)

@Define(TitlePage,Break,PageBreak Around,Centered,
	BlankLines Kept,Above 4.4inches)
@Define(TitleBox,Break,Fixed 1.8inches)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,Fixed 8.5inches,Fill,Justification)
@Define(CopyrightNotice,Fixed 8.0inches,Centered,
	Initialize "Copyright -C- @value{year} ")

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Enter(Text,Indent 2,Spread 1,Use BodyStyle,LineWidth 7.9inches,
	Spaces Compact,
	Justification,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Brochure,WideLpt)
@Define(BodyStyle,Spacing 2)
@Define(TitleStyle,Spacing 1)
@Define(NoteStyle,Spacing 1)

@Generate(Contents)
@Send(Contents "@PageHeading()@PageFooting()")
@Send(Contents "@PrefaceSection(Table of Contents)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  Use B,break,Need 5,Justification Off)
@Define	(Hd0,Use HdX,Above 1inch,Below 0.5inch)
@Define(Hd1,Use HdX,Above 3,PageBreak UntilOdd)
@Define(HD1A=HD1,Centered)
@Define(Hd2,Use HdX,Above 1)
@Define(Hd3,Use HdX,Above 3)
@Define(Hd4,Use HdX,Above 2)
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
@counter(ReferenceCounter,Numbered "[@1]",Referenced "@1",
        IncrementedBy tag)
@define(Bibliography=Description,LeftMargin 5,Indent -5,
        Counter ReferenceCounter,NumberLocation LFL,Spaces Tab,
        Spread 1,Spacing 1,Justification Off)

@Counter(FigureCounter,Within Chapter,Numbered <Figure @#@:-@1: >,
	 Referenced "@#@:-@1",Init 0)
@Define(Figure,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,Counter FigureCounter,NumberLocation LFL)
@Define(FullPageFigure,Use Figure,FloatPage)
@Define(CaptionEnv=Center,FaceCode R)

@Define(TitlePage,Break,PageBreak Around,Centered,
	BlankLines Kept,Above 4.4inches)
@Define(TitleBox,Break,Fixed 1.8inches)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,Fixed 8.5inches,Fill,Justification)
@Define(CopyrightNotice,Fixed 8.0inches,Centered,
	Initialize "Copyright -C- @value{year} ")

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Enter(Text,Indent 2,Spread 1,Use BodyStyle,LineWidth 10inches,
	Spaces Compact,LeftMargin 1inch,
	Justification,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
@Marker(Make,Brochure)
@Define(BodyStyle,Spacing 2)
@Define(TitleStyle,Spacing 1)
@Define(NoteStyle,Spacing 1)

@Generate(Contents)
@Send(Contents "@PageHeading()@PageFooting()")
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
@counter(ReferenceCounter,Numbered "[@1]",Referenced "@1",
        IncrementedBy tag)
@define(Bibliography=Description,LeftMargin 5,Indent -5,
        Counter ReferenceCounter,NumberLocation LFL,Spaces Tab,
        Spread 1,Spacing 1,Justification Off)

@Counter(FigureCounter,Within Chapter,Numbered <Figure @#@:-@1: >,
	 Referenced "@#@:-@1",Init 0)
@Define(Figure,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,Counter FigureCounter,NumberLocation LFL)
@Define(FullPageFigure,Use Figure,FloatPage)
@Define(CaptionEnv=Center,FaceCode R)

@Define(TitlePage,Break,PageBreak Around,Centered,
	BlankLines Kept,Above 4.4inches)
@Define(TitleBox,Break,Fixed 1.8inches)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,Fixed 8.5inches,Fill,Justification)
@Define(CopyrightNotice,Fixed 8.0inches,Centered,
	Initialize "Copyright -C- @value{year} ")

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=AppendixSection)
@Enter(Text,Indent 2,Spread 1,Use BodyStyle,LineWidth 6.5inches,
	Spaces Compact,
	Justification,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
    