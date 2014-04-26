# Standard textclass definition file. Taken from initial LyX source code
# Author : Matthias Ettrich <ettrich@informatik.uni-tuebingen.de>
# Transposed by Pascal André <andre@via.ecp.fr>
# Heavily modifed and enhanced by several developers.

# This include files contains all non numbered versions of the
# sectioning-related commands that are useful for article-like
# document classes, but not for letters. It should be Input after
# modifying the style of the regular sectioning layouts.


Format 11

Style "Исполнители"
    Category              "Структурный элемент"
    Margin                Static
    TocLevel              1
    LabelType             Centered_Top_Environment
    LabelString           "ИСПОЛНИТЕЛИ"
    LabelCounter          ""
    LatexType             Command
    LatexName             Executors
    Newline               0
    OptionalArgs          1
    KeepEmpty             1
    NeedProtect           1
    NextNoIndent          1
    LabelSep              xxx
    #LeftMargin            MMM
    #RightMargin           MMM
    #ParIndent             MM
    ItemSep               0
    TopSep                1.5
    BottomSep             0
    ParSep                0

    Align                 Block
    LabelBottomSep        0.0
    Font
      Size                Normal
    EndFont
    LabelFont
      Series              Bold
      Size                Large
    EndFont
End

Style "Реферат"
    CopyStyle       "Исполнители"
    LabelString     "РЕФЕРАТ"
    LatexName       Referat   
End

Style "Определения"
    CopyStyle       "Исполнители"
    LabelString     "ОПРЕДЕЛЕНИЯ"
    LatexName       Defines
End

Style "Обозначения и сокращения"
    CopyStyle       "Исполнители"
    LabelString     "ОБОЗНАЧЕНИЯ И СОКРАЩЕНИЯ"
    LatexName       Abbreviations
End

Style "Нормативные ссылки"
# непонятно нужен ли, но в стиле latex есть, потому и скопирован
    CopyStyle       "Исполнители"
    LabelString     "НОРМАТИВНЫЕ ССЫЛКИ"
    LatexName       NormRefs
End

Style "Введение"
    CopyStyle       "Исполнители"
    LabelString     "ВВЕДЕНИЕ"
    LatexName       Introduction
End

Style "Заключение"
    CopyStyle       "Исполнители"
    LabelString     "ЗАКЛЮЧЕНИЕ"
    LatexName       Conclusion
End