MAIN  = nrdoc
MANUAL = manual

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

manual:
	latex '\scrollmode \input '"$(MANUAL)";\
	makeindex $(MANUAL); \
	bibtex $(MANUAL); \
	latex '\scrollmode \input '"$(MANUAL)";\
	while ( \
	grep -s 'No file $(MANUAL).toc' $(MANUAL).log || \
	grep -s 'Rerun to get cross-references right'\
	$(MANUAL).log ); \
	do latex '\scrollmode \input '"$(MANUAL)"; \
	done; \
	dvipdfm -p a4 -o   $(MANUAL).pdf $(MANUAL).dvi


install:
	cp nrreport.cls /nr/user/soleng/texinputs/tex/
clean:
	rm -f *.html  *~ *.aux *.dvi \
	*.log *.pdf *.bbl *.out *.blg *.brf *.ind *.ps *.toc \
	*.idx *.lof *.ilg

