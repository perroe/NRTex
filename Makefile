DESTDIR =

MAIN           = nrdoc
MANUAL         = manual
PRINT          = printmanual
DATE           = $(shell date)
VERSION        = $(shell cat version)
RELEASE        = $(shell cat release)
CLASSPATH      = $(DESTDIR)/usr/share/texmf/tex/latex/nrtex
BIBSTYPATH     = $(CLASSPATH)/bst
DOCPATH        = $(DESTDIR)/usr/share/doc/nrtex
TGZNAME        = nrtex-${VERSION}
NR_INSTALLPATH = /nr/group/maler/nrdoc
NR_WEBPATH     = /nr/www/virtual/files.nr.no/htdocs


.SUFFIXES: .tex .dvi .pdf
.PHONY:    all clean manual printmanual html install

all:	manual

manual:  
	pdflatex '\scrollmode \input $(MANUAL)'
	makeindex $(MANUAL)
	bibtex $(MANUAL)
	pdflatex '\scrollmode \input $(MANUAL)'
	while ( \
	    grep -s 'No file $(MANUAL).toc' $(MANUAL).log || \
	    grep -s 'Rerun to get cross-references right' $(MANUAL).log ); \
	    do pdflatex '\scrollmode \input '"$(MANUAL)"; \
	    done; 

printmanual: 
	perl -pe '$$. < 10 && s/,screen,/,twoside,/' manual.tex > printmanual.tex
	pdflatex '\scrollmode \input $(PRINT)'
	makeindex $(PRINT)
	bibtex $(PRINT)
	pdflatex '\scrollmode \input $(PRINT)'
	while ( \
	    grep -s 'No file $(PRINT).toc' $(PRINT).log || \
	    grep -s 'Rerun to get cross-references right' $(PRINT).log ); \
	    do pdflatex '\scrollmode \input '"$(PRINT)"; \
	    done; 

html:	
	perl -pe 's/<<version_number>>/$(VERSION)/; s/<<patch_number>>/$(RELEASE)/; s/<<date>>/$(DATE)/;' nrdoc.html.in > nrdoc.html
	latex2html -split 0 -no_navigation -dir manual.web -local_icons manual

install: html manual printmanual
	install -m 775 -d $(CLASSPATH)
	install -m 775 -d $(CLASSPATH)/elements
	install -m 775 -d $(CLASSPATH)/logos
	install -m 775 -d $(BIBSTYPATH)
	install -m 775 -d $(DOCPATH)
	install -m 775 -d $(DOCPATH)/$(MANUAL).web
	install -m 664 nrdoc.cls $(CLASSPATH)
	install -m 664 elements/* $(CLASSPATH)/elements
	install -m 664 logos/* $(CLASSPATH)/logos
	install -m 664 nrdocold.cls $(CLASSPATH)
	install -m 664 nrfoils.cls $(CLASSPATH)
	install -m 664 background.sty $(CLASSPATH)
	install -m 664 pause.sty $(CLASSPATH)
	install -m 664 manual.pdf $(CLASSPATH)
	install -m 664 apalike-url-norsk.bst $(BIBSTYPATH)
	install -m 664 apalike-url.bst $(BIBSTYPATH)
	install -m 664 unsrturl.bst $(BIBSTYPATH)
	install -m 664 nrdoc.html $(DOCPATH)/index.html
	install -m 664 $(MANUAL).pdf $(DOCPATH)
	install -m 664 $(MANUAL).tex $(DOCPATH)
	install -m 664 $(MANUAL).web/* $(DOCPATH)/$(MANUAL).web
	install -m 664 $(PRINT).pdf $(DOCPATH)

install_nr: html manual printmanual
	install -m 664 nrdoc.cls $(NR_INSTALLPATH)
	install -m 664 elements/* $(NR_INSTALLPATH)/elements
	install -m 664 logos/* $(NR_INSTALLPATH)/logos
	install -m 664 nrdocold.cls $(NR_INSTALLPATH)
	install -m 664 nrfoils.cls $(NR_INSTALLPATH)
	install -m 664 background.sty $(NR_INSTALLPATH)
	install -m 664 pause.sty $(NR_INSTALLPATH)
	install -m 664 manual.pdf $(NR_INSTALLPATH)
	install -m 664 apalike-url-norsk.bst $(NR_INSTALLPATH)
	install -m 664 apalike-url.bst $(NR_INSTALLPATH)
	install -m 664 unsrturl.bst $(NR_INSTALLPATH)
	install -T -m 664 nrdoc.html $(NR_WEBPATH)/latex-maler/index.html
	install -m 664 $(MANUAL).pdf $(NR_WEBPATH)/latex-maler
	install -m 664 $(MANUAL).tex $(NR_WEBPATH)/latex-maler
	install -m 664 $(MANUAL).web/* $(NR_WEBPATH)/latex-maler/$(MANUAL).web
	install -m 664 $(PRINT).pdf $(NR_WEBPATH)/latex-maler
#	cp $(RPMPATH)/$(RPMFILE) $(WEBPATH)/latex-maler/
#	rm -f $(WEBPATH)/latex-maler/nrtex.i586.rpm
#	ln -s $(WEBPATH)/latex-maler/$(RPMFILE) $(WEBPATH)/latex-maler/nrtex.i586.rpm

tgz:	manual
	mkdir -p ${TGZNAME}
	mkdir -p ${TGZNAME}/elements
	mkdir -p ${TGZNAME}/logos
	cp logos/*.pdf logos/*.eps logos/*.jpg logos/*.png  ${TGZNAME}/logos;
	cp elements/*.eps elements/*.pdf ${TGZNAME}/elements; 
	cp ${MAIN}.cls ${MAIN}old.cls nrfoils.cls background.sty pause.sty \
	$(MANUAL).pdf apalike-url.bst apalike-url-norsk.bst \
	unsrturl.bst \
	nrunsrt.bst nrnorsk.bst  nrplain.bst ${TGZNAME}
	tar cvfz rpm/${TGZNAME}.tar.gz ${TGZNAME}

clean:
	make -C rpm clean
	rm -f  nrdoc.html printmanual.tex manual.web/* *~ *.aux *.dvi \
	*.log *.pdf *.bbl *.out *.blg *.brf *.ind *.ps *.toc \
	*.idx *.lof *.ilg
	rm -rf ${TGZNAME}
