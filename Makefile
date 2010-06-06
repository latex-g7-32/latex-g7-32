PDFLATEX=pdflatex -interaction=nonstopmode
PDF=rpz.pdf
MAINTEX=rpz.tex
BIBFILE=rpz
TEX=tex
DIA=dia
PREAMBLE=preamble-std.tex
STYLES=$(TEX)/GostBase.clo $(TEX)/G7-32.sty $(TEX)/G7-32.cls $(TEX)/G2-105.sty
DIA_PDF = $(patsubst $(DIA)/%.dia,$(DIA)/%.pdf, $(wildcard $(DIA)/*.dia))

all: $(PDF)

.PHONY: all tarball clean

$(PDF): $(TEX)/$(MAINTEX) $(TEX)/$(PREAMBLE) $(STYLES) $(DIA_PDF)
	cd tex && $(PDFLATEX) $(MAINTEX) && bibtex $(BIBFILE) && $(PDFLATEX) $(MAINTEX) && $(PDFLATEX) $(MAINTEX) && cp $(PDF) ..

$(DIA)/%.pdf: $(DIA)/%.dia
	dia -e $(patsubst %.dia, %.eps, $<) -t eps $< && epstopdf --outfile $@ $(patsubst %.dia, %.eps, $<)

clean:
	find $(TEX)/ -regextype posix-egrep -type f ! -regex ".*\.(sty|tex|clo|cls|bib|bst|gitignore)" -exec $(RM) {} \; ;
	$(RM) -f $(DIA)/*.pdf $(DIA)/*.eps

tarball: $(PDF) clean
	rm latex-G7-32.tar.gz; cd $(TEX) && tar -czf ../latex-G7-32.tar.gz *
