@Comment{ Document type used for the Green DOD-1 language reference
	  manual. }
@Marker(Make,lrm,XGP)

@Define(BodyStyle,Font BodyFont,Spacing 1.3,Spread 0.5)
@Define(NoteStyle,Font SmallBodyFont,FaceCode R,Spacing 1.3,Spread 0.5)
@font(NewsGothic10A)

@Generate(Index,Contents)
@Send(Contents "@Style(PageNumber <@i>)@Set(Page=1)")
@Send(Contents "@PageFooting()")
@Send(Contents "@PrefaceSection(Table of Contents)")
@send(#Index	"@UnNumbered(Index)",
      #Index	"@Enter(IndexEnv)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 5,Justification Off)
@Define	(Hd0,Use HdX,Font TitleFont5,FaceCode R,Above 1inch,Below 0.5inch)
@Define(Hd1,Use HdX,Font TitleFont5,FaceCode R,Above .5inch,PageBreak UntilOdd)
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
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0,Numbered [@I],
	  IncrementedBy Use,Announced)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1],Announced)
@Counter(Appendix,TitleEnv HD1,ContentsEnv tc1,Numbered [@A.],
	  IncrementedBy,Referenced [@A],Announced,Alias Chapter)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced,Alias Chapter)
@Counter(Section,Within Chapter,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1],Referenced [@#.@1],IncrementedBy Use,Announced)
@Counter(aSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1],Referenced [@#.@1],IncrementedBy Use,Announced)
@Counter(SubSection,Within Section,TitleEnv Hd3,ContentsEnv tc3,
	  Numbered [@#@:.@1],IncrementedBy Use,Referenced [@#@:.@1],
          announced)

@Counter(asubSection,Within asection,TitleEnv Hd3,ContentsEnv tc3,
	  Numbered [@#@:.@1],IncrementedBy Use,Referenced [@#@:.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use)

@Counter(PrefaceSection,TitleEnv HD1A,Alias Chapter)
@Define(IndexEnv,break,CRBreak,Fill,BlankLines break,
	Spread 0,Spacing 1,Spaces Kept,LeftMargin 18,Indent -8)

@Counter(FigureCounter,Within Chapter,Numbered <Figure @#@:-@1: >,
	 Referenced "@#@:-@1",Init 0)
@Define(Figure,Break,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,Counter FigureCounter,NumberLocation LFL)
@Define(FullPageFigure,Use Figure,FloatPage)
@Define(CaptionEnv=Center,FaceCode R)

@Define(TitlePage,Break,PageBreak Around,Centered,
	BlankLines Kept,Above 3inches)
@Define(TitleBox,Break,Fixed 1.8inches)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,Fixed 8.5inches,Fill,Justification)
@Define(CopyrightNotice,Fixed 8.0inches,Centered,
	Initialize "Copyright -C- @value{year} ")

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2,RightMargin 0)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=aSection)

@Modify(Bspace,Below 0,Above 0)
@Modify(HDG,Fixed 0.15inch)
@Modify(FTG,Fixed -0.2inch)
@Enter(Text,Indent 3,Use BodyStyle,LineWidth 6.5inches,
	Spaces Compact,
	BottomMargin 0.5inch,TopMargin 0.3inch,
	LeftMargin 0.8inch,RightMargin 0.8inch,
	Justification,Font BodyFont,FaceCode R)
@set(page=0)
@define(list,above 1,below 1,fill,leftmargin +5,
	indent -3,numbered [@a) ],numberlocation lfr,break,
	spacing 1,continue on)
@define(slist=list,crbreak,spacing 1,spread 0)
@define(listn=list,numbered [@1) ])
@define(slistn=slist,numbered [@1) ])
@define(asis=format)
@define(bnf=asis,above 2,below 2,break,continue off,invisible,blanklines ignored)
@define(prog=asis,above 1,below 1,leftmargin +7,FaceCode P)
@define(title=asis,use ux,above 1.5,break around,continue off)
@define(titlenb=title,break before)
@define(titlec=title,break before,continue on)
@define(p,FaceCode P)
@equate(s=i)
@define(minus)
@define(notes,Use NoteStyle,Break)
@style(scriptheight=0)
@modify(b,overstruck 0)
@textform(diag="@blankspace(@parm(text) inches)")
@textform{
  mind= [@ind1{q=<@parm{text}@ a>,
               r="@parm{text}",
               s="" }
           ],
  ind = [@ind1{q=<@parm{text}@ a>,
               r="@parm{text}",
               s="@parmvalue{sectionnumber}" } 
	]}
@form{
   sind  = [@ind1{q=<@parm{m}@ b @parm{s}>,
                  r="@ @ @ @parm{s}",
                  s="@parmvalue{sectionnumber}"}],
   see   = [@ind1{q=<@parm{m}@ c @parm{s}>,
                  r=<@ @ @ @ @ See also>,
                  s=<@parm{s}>}] }
@form{
  ind1 = [@indexentry{ Key<@parm{q}>, Entry<@parm{r}>,
                       number<@parm{s}>}]}
@pageheading(left "@b[RED LRM] @value(date)",
	right "@b[Section @value(sectionnumber)       Page @ref(page)]")
@PageFooting(
  center "@c{Intermetrics Inc.  @+[.]  701 Concord Ave. @+[.]  Cambridge, MA  02138  @+[.] (617) 661-1840}")
@counter(lexcnt,referenced[@A],numbered[@A],incrementedby reference)
@textform(ldiag="@label(diag@parmref(lexcnt))" )
@counter(syncnt,referenced[@1],numbered[@1],incrementedby reference)
@textform(sdiag="@label(diag@parmref(syncnt))" )
@textform{np='@newpage
                  @parm(text)
@pageheading(immediate,left "@b[RED LRM] @value(date)",
right "@b[Section @value(sectionnumber)       Page @ref(page)]")'}
@style(doublesided)
@Marker(Make,lrm,Diablo)
@Define(BodyStyle,Spacing 1.7,Spread 0.8)
@Define(TitleStyle,Spacing 1,Spread 0)
@Define(NoteStyle,Spacing 1,Spread 0.3)

@Generate(Outline,Index,Contents)
@Send(Contents "@Style(PageNumber <@i>)@Set(Page=1)")
@Send(Contents "@PrefaceSection(Table of Contents)")
@send(#Index	"@UnNumbered(Index)",
      #Index	"@Enter(IndexEnv)")

@Define	(HDX,LeftMargin 0,Indent 0,Fill,Spaces compact,Above 1,Below 0,
	  break,Need 5,Justification Off)
@Define	(Hd0,Use HdX,Above 1inch,Below 0.5inch)
@Define(Hd1,Use HdX,,Above .5inch,PageBreak UntilOdd)
@Define(HD1A=HD1,Centered)
@Define(Hd2,Use HdX,Above 0.4inch)
@Define(Hd3,Use HdX,Above 0.4inch)
@Define(Hd4,Use HdX,Above 0.3inch)
@Define(TcX,LeftMargin 5,Indent -5,RightMargin 5,Fill,Spaces compact,
	Above 0,Spacing 1,Below 0,Break,Spread 0)
@Define(Tc0=TcX)
@Define(Tc1=TcX,Above 0.2,Below 0.2)
@Define(Tc2=TcX,LeftMargin 10)
@Define(Tc3=TcX,LeftMargin 15)
@Define(Tc4=TcX,LeftMargin 20)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0,Numbered [@I],
	  IncrementedBy Use,Announced)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1],Announced)
@Counter(Appendix,TitleEnv HD1,ContentsEnv tc1,Numbered [@A.],
	  IncrementedBy,Referenced [@A],Announced,Alias Chapter)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced,Alias Chapter)
@Counter(Section,Within Chapter,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use,Announced)
@Counter(ASection,Within Appendix,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use,Announced)
@Counter(SubSection,Within Section,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@:.@1],IncrementedBy Use,Referenced [@#@:.@1])
@Counter(asubsection,Within asection,TitleEnv HD3,ContentsEnv tc3,
	  Numbered [@#@:.@1],IncrementedBy Use,Referenced [@#@:.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use)

@Counter(PrefaceSection,TitleEnv HD1A,Alias Chapter)
@Define(IndexEnv,Break,CRBreak,Fill,BlankLines Kept,
	Spread 0,Spacing 1,Spaces Kept,LeftMargin 18,Indent -8)
@counter(ReferenceCounter,Numbered "[@1]",Referenced "@1",
        IncrementedBy tag)
@define(Bibliography=Description,LeftMargin 5,Indent -5,
        Counter ReferenceCounter,NumberLocation LFL,Spaces Tab,
        Spread 1,Spacing 1,Justification Off)

@Counter(FigureCounter,Within Chapter,Numbered <Figure @#@:-@1: >,
	 Referenced "@#@:-@1",Init 0)
@Define(Figure,Break,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
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
	SubSubSec=Paragraph,AppendixSec=ASection)
@Enter(Text,Indent 5,Use BodyStyle,LeftMargin .25inch,TopMargin .85inch,
	BottomMargin .75inch,LineWidth 7inches,Justification,
	Spaces Normalized,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
@define(list,above 2,below 2,fill,leftmargin +8,
indent -3,numbered [@a) ],numberlocation lfr,break,spacing 1,continue on)
@define(slist=list,crbreak,spacing 1,spread 0)
@define(listn=list,numbered [@1) ])
@define(slistn=slist,numbered [@1) ])
@define(asis=verbatim,above 2,below 2)
@define(bnf=asis,above 3,below 3,break,continue off)
@define(prog=asis,above 2,below 2,leftmargin +10,use b)
@define(title=asis,use ux,above 3,break around,continue off)
@define(titlenb=title,break before)
@define(titlec=title,break before)
@define(p=b)
@define(s)
@define(-)
@style(scriptheight=0,doublesided)
@pageheading(left "@b[RED LRM-INTERMETRICS INC.]",
center "@b[COMPANY CONFIDENTIAL]",
right "@b[@value(date) @ref(page)]")
@Marker(Make,Lrm)
@Define(BodyStyle,Spacing 2)
@Define(TitleStyle,Spacing 1)
@Define(NoteStyle,Spacing 1)

@Generate(Outline,Index,Contents)
@Send(Contents "@Style(PageNumber <@i>)@Set(Page=1)")
@Send(Contents "@PrefaceSection(Table of Contents)")
@send(#Index	"@unnumbered(INDEX)",
      #Index	"@Enter(IndexEnv)")

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
@Define(Tc2=TcX,LeftMargin 10)
@Define(Tc3=TcX,LeftMargin 15)
@Define(Tc4=TcX,LeftMargin 20)
@Counter(MajorPart,TitleEnv HD0,ContentsEnv tc0,Numbered [@I],
	  IncrementedBy Use,Announced)
@Counter(Chapter,TitleEnv HD1,ContentsEnv tc1,Numbered [@1.],
	  IncrementedBy Use,Referenced [@1.],Announced)
@Counter(Appendix,TitleEnv HD1,ContentsEnv tc1,Numbered [@A.],
	  IncrementedBy,Referenced [@A.],Announced,Alias Chapter)
@Counter(UnNumbered,TitleEnv HD1,ContentsEnv tc1,Announced,Alias Chapter)
@Counter(Section,Within Chapter,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@1],Referenced [@#@1],IncrementedBy Use,Announced)
@Counter(aSection,Within Appendix,TitleEnv HD2,ContentsEnv tc2,
	  Numbered [@#@1],Referenced [@#@1],IncrementedBy Use,Announced)
@Counter(SubSection,Within Section,TitleEnv Hd3,ContentsEnv tc3,
	  Numbered [@#@:.@1],IncrementedBy Use,Referenced [@#@:.@1],
          announced)

@Counter(asubSection,Within asection,TitleEnv Hd3,ContentsEnv tc3,
	  Numbered [@#@:.@1],IncrementedBy Use,Referenced [@#@:.@1])
@Counter(Paragraph,Within SubSection,TitleEnv HD4,ContentsEnv tc4,
	  Numbered [@#@:.@1],Referenced [@#@:.@1],IncrementedBy Use)

@Counter(PrefaceSection,TitleEnv HD1A,Alias Chapter)
@Define(IndexEnv,break,CRBreak,Fill,BlankLines break,
	Spread 0,Spacing 1,Spaces Kept,LeftMargin 18,Indent -8)
@counter(ReferenceCounter,Numbered "[@1]",Referenced "@1",
        IncrementedBy tag)
@define(Bibliography=Description,LeftMargin 5,Indent -5,
        Counter ReferenceCounter,NumberLocation LFL,Spaces Tab,
        Spread 1,Spacing 1,Justification Off)

@Counter(FigureCounter,Within Chapter,Numbered <Figure @#@:-@1: >,
	 Referenced "@#@:-@1",Init 0)
@Define(Figure,Break,Nofill,Spaces Kept,Use R,BlankLines kept,Float,
	Above 1,Below 1,Counter FigureCounter,NumberLocation LFL)
@Define(FullPageFigure,Use Figure,FloatPage)
@Define(CaptionEnv=Center,FaceCode R)

@Define(TitlePage,Break,PageBreak Around,Centered,
	BlankLines Kept,Above 3inches)
@Define(TitleBox,Break,Fixed 1.8inches)
@Define(Abstract=Text,Spacing 1,Indent 0,Fill,Justification,
	Initialize "@heading{Abstract}")
@Define(ResearchCredit,Fixed 8.5inches,Fill,Justification)
@Define(CopyrightNotice,Fixed 8.0inches,Centered,
	Initialize "Copyright -C- @value{year} ")

@define(FileExample,Break,Use NoteStyle,FaceCode F,CRbreak,LeftMargin 16,
        Fill,BlankLines Kept,Indent -10,Spacing 1,Spread 0,Above 1,Below 1)
@Define(OutputExample=Verbatim,LeftMargin 2,RightMargin 0)

@Equate(Sec=Section,Subsec=SubSection,Chap=Chapter,Para=Paragraph,
	SubSubSec=Paragraph,AppendixSec=aSection)
@Enter(Text,Indent 5,Spread 1,Use BodyStyle,LineWidth 80,
	Spaces Normalized,
	Justification,Font CharDef,FaceCode R)
@set(page=0)
@PageHeading(Center "@value(page)")
@define(list,above 1,below 1,fill,leftmargin +8,
indent -3,numbered [@a) ],numberlocation lfr,break,
spacing 1,continue on)
@define(slist=list,crbreak,spacing 1,spread 0)
@define(listn=list,numbered [@1) ])
@define(slistn=slist,numbered [@1) ])
@define(asis=verbatim)
@define(bnf=asis,above 2,below 2,break,continue off,invisible,blanklines ignored)
@define(prog=asis,above 1,below 1,leftmargin +10,use b)
@define(title=asis,use ux,above 2,break around,continue off)
@define(titlenb=title,break before)
@define(titlec=title,break before,continue on)
@define(p,use b)
@define(s)
@define(minus)
@define(notes)
@style(scriptheight=0)
@modify(b,overstruck 0)
@textform(diag="@blankspace(@parm(text) inches)")
@textform{
  mind= [@ind1{q=<@parm{text}@ a>,
               r="@parm{text}",
               s="" }
     @ind1{q=<@parm{text}@ d>,
           r="
",
           s=""} ],
  ind = [@ind1{q=<@parm{text}@ a>,
               r="@parm{text}",
               s="@parmvalue{sectionnumber}" } 
         @ind1{q=<@parm{text}@ d>,
               r="
",            s=""}  ]}
@form{
   sind  = [@ind1{q=<@parm{m}@ b @parm{s}>,
                  r="@ @ @ @parm{s}",
                  s="@parmvalue{sectionnumber}"}],
   see   = [@ind1{q=<@parm{m}@ c @parm{s}>,
                  r=<@ @ @ @ @ See also>,
                  s=<@parm{s}>}] }
@form{
  ind1 = [@indexentry{ Key<@parm{q}>, Entry<@parm{r}>,
                       number<@parm{s}>}]}
@pageheading(left "@b[RED LRM @value(date)]",
center "@b[***DRAFT***]",
right "@b[Section @value(sectionnumber) Page @ref(page)]")
@counter(lexcnt,referenced[@A],numbered[@A],incrementedby reference)
@textform(ldiag="@label(diag@parmref(lexcnt))" )
@counter(syncnt,referenced[@1],numbered[@1],incrementedby reference)
@textform(sdiag="@label(diag@parmref(syncnt))" )
@textform{np='@newpage
                  @parm(text)
@pageheading(immediate,left "@b[RED LRM @value(date)]",
center "@b[***DRAFT***]",
right "@b[Section @value(sectionnumber) Page @ref(page)]")'}
@style(doublesided)
    