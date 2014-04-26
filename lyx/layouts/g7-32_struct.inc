# Standard textclass definition file. Taken from initial LyX source code
# Author : Matthias Ettrich <ettrich@informatik.uni-tuebingen.de>
# Transposed by Pascal André <andre@via.ecp.fr>
# Heavily modifed and enhanced by several developers.
# Title definitions moved to stdtitle.inc by Hartmut Goebel <harmut@noris.net>

# This include files contains all layouts that handle the structure of
# a document, like abstract, bibliography and such.


Format 11
Style Abstract
	Margin                Static
	LatexType             Environment
	LatexName             abstract
	Category              FrontMatter
	NextNoIndent          1
	LeftMargin            MMM
	RightMargin           MMM
	ParIndent             MM
	ItemSep               0
	TopSep                0.7
	BottomSep             0.7
	ParSep                0
	Align                 Block
	LabelType             Centered_Top_Environment
	LabelString           "Abstract"
	LabelBottomSep    0.5
	Font
	  Size                Small
	EndFont
	LabelFont
	  Series              Bold
	  Size                Large
	EndFont
End


Style Bibliography
	Margin                First_Dynamic
	LatexType             Bib_Environment
	LatexName             thebibliography
	Category              BackMatter
	NextNoIndent          1
	LeftMargin            MM
	ParSkip               0.4
	ItemSep               0
	TopSep                0.7
	BottomSep             0.7
	ParSep                0.5
	Align                 Block
	AlignPossible         Block, Left
	LabelType             Bibliography
	LabelString           "СПИСОК ИСПОЛЬЗОВАННЫХ ИСТОЧНИКОВ"
	LabelBottomSep        1.2
	LabelFont
	  Series              Bold
	  Size                Larger
	EndFont
End
