BASELINE_SRC = resume.tex coverletter.tex
BASELINE_PDFS = $(BASELINE_SRC:.tex=.pdf)

VARIANT_SRC = $(wildcard variants/*/*.tex)
VARIANT_PDFS = $(VARIANT_SRC:.tex=.pdf)

all:	clean baseline variants

baseline:	$(BASELINE_PDFS)

variants:	$(VARIANT_PDFS)

en:	clean
	xelatex resume.tex

zh_CN:	clean
	xelatex resume-zh_CN.tex

# Build a .pdf next to its .tex (works for both root files and variants/<name>/<doc>.tex).
%.pdf:  %.tex
	xelatex -output-directory=$(dir $<) $<

ifeq ($(OS),Windows_NT)
  RM = cmd //C del
else
  RM = rm -f
endif

clean:
	$(RM) *.log *.aux *.bbl *.blg *.synctex.gz *.out *.toc *.lof *.idx *.ilg *.ind *.pdf *.fdb_latexmk *.fls *.xdv
	$(RM) variants/*/*.log variants/*/*.aux variants/*/*.synctex.gz variants/*/*.out variants/*/*.toc variants/*/*.fdb_latexmk variants/*/*.fls variants/*/*.xdv variants/*/*.pdf

.PHONY: all baseline variants en zh_CN clean
