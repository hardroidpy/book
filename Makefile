# Command file for TeX documentation

#set PATH=%PATH%;%USERPROFILES%/Apps/Git/bin
#set PATH=%PATH%;"%USERPROFILES%/AppData/Local/Programs/MiKTeX 2.9/miktex/bin/x64"
#set PATH=%PATH%;"%USERPROFILES%/AppData/Local/Pandoc"
#set LANG=en_US

objects = *.aux *.bbl *.bcf *.blg *.log *.lof *.loa *.lot *.pdf *.run.xml *.toc *.nlo *.md *.docx *.ild *.ind *.out *.ilg *.lyx~ *.nav *.snm *.vrb *.brf *.nls
makelatex = pdflatex -draftmode -interaction nonstopmode 
makepdf = pdflatex -interaction nonstopmode 

all: help

help:
	@echo "Please use make <target> where <target> is one of"
	@echo "  docx       to make Docx File"
	@echo "  latex      to make PDF File"
	@echo "  text       to make Markdown files"
	@echo "  clean      to clean the dir"
	@echo "  view       to view"
	@echo "  tex        to make Latex files"

docx:
	LANG=en_US pandoc --bibliography=referencias.bib -t docx tesis.tex -o tesis.docx
	@echo 
	@echo "Build finished. The Docx is in ."

latex:
	$(makelatex) tesis || bibtex tesis ;
	makeindex tesis.nlo -s nomencl.ist -o tesis.nls ;
	$(makelatex) tesis || $(makepdf) tesis || echo ;
	@echo
	@echo Build finished. 

latex-slide:
	cd slides && $(makelatex) presentacion.tex && $(makepdf) presentacion.tex ;
	@echo
	@echo Build finished. 

slide-final:
	cd slides && lyx presentacion-final.lyx -e pdflatex -f all;
	cd slides && $(makelatex) presentacion-final.tex && $(makepdf) presentacion-final.tex ;
	@echo
	@echo Build finished. 

view:
	evince tesis.pdf
	@echo 
	@echo Build finished.

ppt:
	evince slides/presentacion.pdf
	@echo 
	@echo Build finished.

tex:
	lyx tesis_har.lyx -e pdflatex -f all
	rm capitulo-3/capitulo-3l.tex
	@echo 
	@echo Build finished.

tex-slide:
	cd slides && lyx presentacion.lyx -e pdflatex -f all
	@echo 
	@echo Build finished.

text:
	find . -name *.tex -exec pandoc -t markdown_mmd {} -o basename({}).md \;
	@echo 
	@echo Build finished.
    
pan2ltx:
	pandoc -t latex ${FILENAME} -o ${FILENAME}
	@echo 
	@echo Build finished.

clean:
	for m in $(objects); do find . -name $$m -and -not -path ./paper/\* -exec rm {} \; ; done
	@echo 
	@echo Build finished.
