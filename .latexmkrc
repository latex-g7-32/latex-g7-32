$ENV{'TEXINPUTS'}='./tex//:./library//:./G7-32//:' . $ENV{'TEXINPUTS'}; 
$ENV{'BIBINPUTS'}='./tex//:' . $ENV{'BIBINPUTS'};
$ENV{'BSTINPUTS'}='./GOST/bibtex/bst/gost//:' . $ENV{'BSTINPUTS'};

$pdflatex = 'xelatex -interaction=nonstopmode -shell-escape %O %S';
$pdf_mode = 1;
$bibtex_use = 1;
