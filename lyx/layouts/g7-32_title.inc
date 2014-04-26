# Standard textclass definition file. Taken from initial LyX source code
# Author : Matthias Ettrich <ettrich@informatik.uni-tuebingen.de>
# Transposed by Pascal André <andre@via.ecp.fr>
# Heavily modifed and enhanced by several developers.
# Split from stdstruct.inc by Hartmut Goebel <hartmut@noris.net>

# This include files contains all layouts that handle the title area
# a document, like title, author and such.


Format 11
Style Title
	Margin                Static
	LatexType             Command
	Category              FrontMatter
	InTitle               1
	LatexName             title
	ParSkip               0.4
	ItemSep               0
	TopSep                0
	BottomSep             1
	ParSep                1
	Align                 Center
	LabelType             No_Label
	Font
	  Size                Largest
	EndFont
End


Style Author
	Margin                Static
	LatexType             Command
	Category              FrontMatter
	InTitle               1
	LatexName             author
	LabelSep              xxx
	ParSkip               0.4
	TopSep                1.3
	BottomSep             0.7
	ParSep                0.7
	Align                 Center
	LabelType             No_Label
	Font
	  Size                Large
	EndFont
End


Style Date
	Margin                Dynamic
	LatexType             Command
	Category              FrontMatter
	InTitle               1
	LatexName             date
	LabelSep              xxx
	ParSkip               0.4
	TopSep                0.9
	BottomSep             0.5
	ParSep                1
	Align                 Center
	LabelType             No_Label
	Font
	  Size                Large
	EndFont
End
