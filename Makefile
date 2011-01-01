# Tools

PDFLATEX=pdflatex -interaction=nonstopmode
TD=./utils/texdepend

# Output file
PDF=rpz.pdf

# Input paths
DIA=dia
TEX=tex
DEPS=.deps
SRC=src
INC=$(TEX)/inc

# Input files
MAINTEX=rpz.tex
BIBFILE=rpz
PREAMBLE=preamble-std.tex
STYLES=$(TEX)/GostBase.clo $(TEX)/G7-32.sty $(TEX)/G7-32.cls $(TEX)/G2-105.sty
PARTS_TEX = $(wildcard $(TEX)/[0-9][0-9]-*.tex)

all: $(PDF)

.PHONY: all tarball clean

PARTS_DEPS=$(PARTS_TEX:tex/%=$(DEPS)/%-deps.mk)
-include $(PARTS_DEPS)

$(DEPS)/%-deps.mk: $(TEX)/% Makefile
	mkdir -p $(DEPS)
	(echo -n "$(PDF): " ; $(TD) -print=fi -format=1 $< | grep -v '^#' | xargs echo) > $@

$(PDF): $(TEX)/$(MAINTEX) $(TEX)/$(PREAMBLE) $(PARTS_TEX) $(STYLES)
	cd tex && $(PDFLATEX) $(MAINTEX) && bibtex $(BIBFILE) && $(PDFLATEX) $(MAINTEX) && $(PDFLATEX) $(MAINTEX) && cp $(PDF) ..

$(INC)/dia/%.pdf: $(DIA)/%.dia
	mkdir -p $(INC)/dia
	dia -e $(patsubst %.dia, %.eps, $<) -t eps $< && epstopdf --outfile $@ $(patsubst %.dia, %.eps, $<)

$(INC)/src/%: $(SRC)/%
	mkdir -p $(INC)/src
	cp $< $@

clean:
	find $(TEX)/ -regextype posix-egrep -type f ! -regex ".*\.(sty|tex|clo|cls|bib|bst|gitignore)" -exec $(RM) {} \; ;
	$(RM) $(DIA)/*.pdf $(DIA)/*.eps
	$(RM) -r $(DEPS)
	$(RM) -r $(INC)

distclean: clean

tarball: $(PDF) clean
	rm latex-G7-32.tar.gz; cd $(TEX) && tar -czf ../latex-G7-32.tar.gz *
