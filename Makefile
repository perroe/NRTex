MAIN  = nrreport
TEX   = $(MAIN).tex

.SUFFIXES: .nw .tex .dvi .pdf

src:
	noweb $(MAIN).nw

all:	src pdf install

dvi: 	src
	latex '\scrollmode \input '"$(MAIN)";\
	latex '\scrollmode \input '"$(MAIN)";\
	while ( \
	grep -s 'No file $(MAIN).toc' $(MAIN).log || \
	grep -s 'Rerun to get cross-references right'\
	$(MAIN).log ); \
	do latex '\scrollmode \input '"$(MAIN)";\
	done

bib:
	latex '\scrollmode \input '"$(MAIN)"; \
	bibtex $(MAIN)

pdf:    dvi
	dvipdfm -p a4 -o   $(MAIN).pdf $(MAIN).dvi


install:
	cp nrreport.cls /nr/user/soleng/texinputs/tex/
clean:
	rm -f *.html *.tex *~ *.aux *.dvi \
	*.log *.pdf *.bbl *.out *.blg  

