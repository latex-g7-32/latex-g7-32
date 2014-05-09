# GOST 7.32
# Author : Inflianskas Roman <infroma@gmail.com>

# Standard textclass definition file. Taken from initial LyX source code
# Author : Matthias Ettrich <ettrich@informatik.uni-tuebingen.de>
# Transposed by Pascal André <andre@via.ecp.fr>
# Heavily modifed and enhanced by several developers.

# This include files contains all numbered sectionning-related
# commands that are useful for article-like document classes, but not
# for letters.

Format 49

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
    HTMLTag               h1
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
    HTMLTag               h2
End

Style "Пункт"
	CopyStyle             "Подраздел"
	LabelCounter	      point
	TocLevel              2
	LatexName             subsection
	TopSep                0.4
	BottomSep             0
	ParSep                0.4
    HTMLTag               h3
End

Style "Подпункт"
	CopyStyle             "Пункт"
	LabelType             No_Label
	TocLevel              3
	LatexName             subsubsection
	TopSep                0.3
	BottomSep             0
	ParSep                0.2
    HTMLTag               h4
End

Style "Параграф"
    CopyStyle             "Подпункт"
    LabelCounter          paragraph
    TocLevel              4
    LatexName             paragraph
	TopSep                0.2
	BottomSep             0
	ParSep                0.2
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
