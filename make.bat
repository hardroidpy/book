@ECHO OFF

REM Command file for TeX documentation

set PATH=%PATH%;%USERPROFILES%/Apps/Git/bin
set PATH=%PATH%;"%USERPROFILES%/AppData/Local/Programs/MiKTeX 2.9/miktex/bin/x64"
set PATH=%PATH%;"%USERPROFILES%/AppData/Local/Pandoc"
REM set LANG=en_US

if "%1" == "" goto help

if "%1" == "help" (
    :help
   	echo.Please use `make ^<target^>` where ^<target^> is one of
	echo.  docx       to make Docx File
	echo.  latex      to make LaTeX files, you can set PAPER=a4 or PAPER=letter
	echo.  text       to make Markdown files
	echo.  clean      to clean the dir
	echo.  view       to view
	goto end

)

if "%1" == "docx" (
    pandoc --bibliography=referencias.bib -t docx %2.tex -o %2.docx
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. The Docx is in .
	goto end
)

if "%1" == "latex" (
    pdflatex -interaction nonstopmode tesis 
    bibtex tesis 
    makeindex tesis.nlo -s nomencl.ist -o tesis.nls
    pdflatex -interaction nonstopmode tesis 
    pdflatex -interaction nonstopmode tesis 
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. 
	goto end
)

if "%1" == "view" (
    start explorer tesis.pdf
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished.
	goto end
)

if "%1" == "viewtex" (
    start explorer tesis.tex
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished.
	goto end
)

if "%1" == "text" (
    for /r %%i in (*.tex) do pandoc -t markdown_mmd %%i -o %%~ni.md
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished.
	goto end
)

if "%1" == "clean" (
for /r %%i in (*.aux, *.bbl, *.bcf, *.blg, *.log, *.lof, *.loa, *.lot, *.pdf, *.run.xml, *.toc, *.nlo, *.md, *.docx *.ild *.ind *.out *.ilg *.lyx~ *.brf *.nls)do del /q /s %%i
    echo.
	echo.Build finished.
	goto end
)

:end
