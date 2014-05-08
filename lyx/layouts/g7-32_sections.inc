# Standard textclass definition file. Taken from initial LyX source code
# Author : Matthias Ettrich <ettrich@informatik.uni-tuebingen.de>
# Transposed by Pascal André <andre@via.ecp.fr>
# Heavily modifed and enhanced by several developers.

# This include files contains all numbered sectionning-related
# commands that are useful for article-like document classes, but not
# for letters.

Format 11

Style "Раздел"
    Category              "Раздел"
    Margin                Dynamic
    LabelType             Counter
    LabelCounter          section
    TocLevel              0
    LatexType             Command
    LatexName             chapter
    NeedProtect           1
    NextNoIndent          1
    LabelSep              xxx
    ParSkip               0.4
    TopSep                1.3
    BottomSep             0.7
    ParSep                0.7
    Align                 Block
    AlignPossible         Block, Left
    OptionalArgs          1
    Font
      Series              Bold
      Size                Larger
    EndFont
End


Style "Подраздел"
	CopyStyle             "Раздел"
	LabelCounter	      subsection
	TocLevel              1
	LatexName             section
	TopSep                0.9
	BottomSep             0.5
	ParSep                0.5
	Font
	  Series              Bold
	  Size                Large
	EndFont
End

Style "Пункт"
    Category              "Раздел"
    Margin                Dynamic
    LabelType             Counter
    LabelCounter          point
    KeepEmpty             1
    TocLevel              2
    LatexType             Command
    LatexName             subsection
#   LatexParam            1
    NeedProtect           0
    NextNoIndent          0
    LabelSep              xxx
    ParSkip               0.4
    TopSep                0.4
    BottomSep             0
    Align                 Block
    AlignPossible         Block, Left
End


Style "Подпункт"
    Category              "Раздел"
    Margin                Dynamic
    LabelType             Counter
    LabelCounter          subpoint
    KeepEmpty             1
    TocLevel              3
    LatexType             Command
    LatexName             subsubsection
#   LatexParam            1
    NeedProtect           0
    NextNoIndent          0
    LabelSep              xxx
    ParSkip               0.4
    TopSep                0.4
    BottomSep             0
    Align                 Block
    AlignPossible         Block, Left
End


Style "Параграф"
    CopyStyle             "Подпункт"
    LabelCounter          paragraph
    TocLevel              4
    LatexName             paragraph
    TopSep                0.4
    BottomSep             0
    Font
        Series              Bold
        Size                Normal
    EndFont
    HTMLTag               h5
End


Style "Приложение"
    Category              "Раздел"
    Margin                Dynamic
    LabelType             Static
    LabelCounter          appendix
    TocLevel              1
    LatexType             Command
    LatexName             appendix
    NeedProtect           1
    NextNoIndent          1
    LabelSep              xxx
    ParSkip               0.4
    TopSep                1.3
    BottomSep             0.7
    ParSep                0.7
    Align                 Block
    AlignPossible         Block, Left
    OptionalArgs          2
    Font
      Series              Bold
      Size                Larger
    EndFont
End

Input numarticle.inc
