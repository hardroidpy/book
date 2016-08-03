# Command file for TeX documentation

#set PATH=%PATH%;%USERPROFILES%/Apps/Git/bin
#set PATH=%PATH%;"%USERPROFILES%/AppData/Local/Programs/MiKTeX 2.9/miktex/bin/x64"
#set PATH=%PATH%;"%USERPROFILES%/AppData/Local/Pandoc"
#set LANG=en_US

objects = *.aux *.bbl *.bcf *.blg *.log *.lof *.loa *.lot *.pdf *.run.xml *.toc *.nlo *.md *.docx *.ild *.ind *.out *.ilg *.lyx~
makelatex = pdflatex -interaction nonstopmode tesis

all: help

help:
	@echo "Please use make <target> where <target> is one of"
	@echo "  docx       to make Docx File"
	@echo "  latex      to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  text       to make Markdown files"
	@echo "  clean      to clean the dir"
	@echo "  view       to view"

docx:
	LANG=en_US pandoc --bibliography=referencias.bib -t docx tesis.tex -o tesis.docx
	@echo 
	@echo "Build finished. The Docx is in ."

latex:
	$(makelatex) || bibtex tesis ;
	makeindex tesis.nlo -s nomencl.ist -o tesis.nls ;
	$(makelatex) || $(makelatex) ;
	@echo
	@echo Build finished. 

view:
	evince tesis.pdf
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
	for m in $(objects); do find . -name $$m -exec rm {} \; ; done
	@echo 
	@echo Build finished.