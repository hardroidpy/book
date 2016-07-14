@ECHO OFF

REM Command file for TeX documentation

set PATH=%PATH%;%USERPROFILES%/Apps/Git/bin
set PATH=%PATH%;"%USERPROFILES%/AppData/Local/Programs/MiKTeX 2.9/miktex/bin/x64"
set PATH=%PATH%;"%USERPROFILES%/AppData/Local/Pandoc"
set LANG=en_US

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
    pandoc --bibliography=referencias.bib -t docx tesis.tex -o tesis.docx
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. The Docx is in .
	goto end
)

if "%1" == "latex" (
    start pdflatex tesis && biber tesis && pdflatex tesis && pdflatex tesis
	if errorlevel 1 exit /b 1
	echo.
	echo.Build finished. 
	goto end
)

if "%1" == "view" (
    start texworks tesis.pdf
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
for /r %%i in (*.aux, *.bbl, *.bcf, *.blg, *.log, *.lof, *.loa, *.lot, *.pdf, *.run.xml, *.toc, *.nlo, *.md, *.docx *.ild *.ind *.out *.ilg *.lyx~)do del /q /s %%i
    echo.
	echo.Build finished.
	goto end
)

:end
