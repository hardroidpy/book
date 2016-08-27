%% vim:syntax=tex
%% Plantilla de la UNA hija de la plantilla de la UCA con menos detalles
%% y orientado al estilo book
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{./util/unathesis}[2016/07/19 v0.01 Formato para tesis de la UNA]

\LoadClass[12pt,oneside,spanish]{book}[1996/10/31]

\RequirePackage[spanish,activeacute]{babel}
\addto\shorthandsspanish{\spanishdeactivate{~<>}}

% Formato de archivo
\usepackage{graphics} % for improved inclusion of graphics
\usepackage{wrapfig} % to include figure with text wrapping around it
\usepackage{setspace}

\usepackage{algorithm}
%\usepackage{algorithmic}
\bibliographystyle{plainnat} % Numeros ordenados por entrada
\AtBeginDocument{\renewcommand\cite{\citep}}

% class fields %
\renewcommand{\@author}{\ClassError{unathesis}{Falta especificar \string\author{}}
 {Usa el comando \string\author{} en el preambulo para especificar tu nombre.}}
\renewcommand{\author}[1]{\gdef\@author{#1}}

\renewcommand{\@title}{\ClassError{unathesis}{Falta especificar \string\title{}}
 {Usa el comando \string\title{} en el preambulo para especificar \MessageBreak
  el titulo de tu tesis.}}
\renewcommand{\title}[1]{\gdef\@title{#1}}

\newcommand{\@degree}{\ClassError{unathesis}{Falta especificar \string\degree{}}
 {Usa el comando \string\degree{} en el preambulo para especificar la carrera \MessageBreak
  que estas estudiando: \protect Matem\'aticas, F\'{\i}sica, Actuaria.}}
\newcommand{\degree}[1]{\gdef\@degree{#1}}

\newcommand{\@advisorname}{}
\newcommand{\@advisortitle}{}
\newcommand{\@advisor}{\ClassError{unathesis}{Falta especificar \string\advisor{}{}}
 {Usa el comando \string\advisor[]{}{} en el preambulo para especificar a tu \MessageBreak
  director de tesis. El primer argumento es su titulo (Dr., M. en C.) \MessageBreak
  y el segundo su nombre completo. Opcionalmente puedes modificar su puesto \MessageBreak
  en el jurado si es distinto a `Vocal y Director'.}}
\newcommand{\advisor}[3][Orientador:]%
  {\gdef\@advisorname{#1}\gdef\@advisortitle{#2}\gdef\@advisor{#3}}


\newcommand{\@institution}{Universidad Nacional de Asunci\'on}
\newcommand{\institution}[1]{\gdef\@institution{#1}}
\newcommand{\@nameinstitution}{"Facultad Polit\'ecnica"}
\newcommand{\nameinstitution}[1]{\gdef\@institution{#1}}
\newcommand{\@faculty}{Facultad Polit\'ecnica}
\newcommand{\faculty}[1]{\gdef\@faculty{#1}}
\newcommand{\@department}{Departamento de Inform\'atica}
\newcommand{\department}[1]{\gdef\@department{#1}}
\newcommand{\@grade}{Ingeniero}
\newcommand{\grade}[1]{\gdef\@grade{#1}}
\newcommand{\@address}{Asuncion - Paraguay}
\newcommand{\address}[1]{\gdef\@address{#1}}
\newcommand{\@termyear}{\thisterm}
\newcommand{\termyear}[1]{\gdef\@termyear{#1}}
\newcommand{\@monthyear}{\thismonth}
\newcommand{\monthyear}[1]{\gdef\@monthyear{#1}}
\renewcommand{\@date}{\longdate}
\renewcommand{\date}[1]{\gdef\@date{#1}}

\newcommand{\logosource}[1]{\gdef\@logosource{#1}}

% default date/time strings %
\newcommand{\monthname}{\ifcase\month\or Enero\or Febrero\or
      Marzo\or Abril\or Mayo\or Junio\or Julio\or Agosto\or Septiembre\or
      Octubre\or Noviembre\or Diciembre\fi}
\newcommand{\termname}{\ifcase\month\or Primavera\or Primavera\or
      Primavera\or Primavera\or Primavera\or Verano\or Verano\or Oto\~no\or Oto\~no\or
      Oto\~no\or Oto\~no\or Oto\~no\fi}

\newcount\hours \newcount\minutes
\def\SetTime{\hours=\time
        \global\divide\hours by 60
        \minutes=\hours
        \multiply\minutes by 60
        \advance\minutes by-\time
        \global\multiply\minutes by-1 }
\SetTime

\newcommand{\thisterm}{\termname\ de \the\year}
\newcommand{\thismonth}{\monthname\ de \the\year}
\newcommand{\longdate}{\@arabic\day\ de \monthname\ de \the\year}
\newcommand{\shortdate}{\@arabic\day/\@arabic\month/\@arabic\year}
\newcommand{\shorttime}{\number\hours:\ifnum\minutes<10 0\fi\number\minutes}

\newcommand{\blankpagelegend}{(esta p\'agina se dej\'o en blanco de manera intencional)}

% Margenes y espaciado
\usepackage[a4paper]{geometry}
\geometry{verbose,tmargin=20mm,bmargin=1in,lmargin=35mm,rmargin=1in}

% PDF
\ifpdf
    \DeclareGraphicsExtensions{.png, .jpg, .jpeg, .pdf, .gif} %GIF doesn't work??
    \usepackage[pdftex]{graphicx}
    \pdfcompresslevel=9
    %% Enlaces
    \usepackage[unicode=true,
                bookmarks=true,
                bookmarksnumbered=true,
                bookmarksopen=true,
                bookmarksopenlevel=1,
                breaklinks=false,
                pdfborder={0 0 0},
                pdfborderstyle={},
                backref=page,
                colorlinks = false
            ]{hyperref}
\else
    \usepackage[ dvips, 
                 bookmarks,
                 bookmarksopen = true,
                 bookmarksnumbered = true,
                 breaklinks = true,
                 linktocpage,
                 pagebackref,
                 colorlinks = true,
                 linkcolor = blue,
                 urlcolor  = blue,
                 citecolor = red,
                 anchorcolor = green,
                 hyperindex = true,
                 hyperfigures
                 ]{hyperref}

    \DeclareGraphicsExtensions{.eps, .ps}
    \usepackage{epsfig}
    \usepackage{graphicx}
\fi

% support for \and in author%
\newcounter{@count}
\newcounter{@index}

\def\@undefineand{
 \def\and{
   \ClassError{ucathesis}{Illegal use of \string\and}%
     {Do not use the \string\and\space command outside the author field}
 }
}

\@undefineand

\newcommand{\@typeauthor}[2]{
 \def\and{\stepcounter{@index}\relax
          \ifnum\value{@index}=\value{@count}%
             #2
          \else
             #1
          \fi}%
 \setbox0=\vbox{\setcounter{@count}{1}\def\and{\stepcounter{@count}}\@author}
 \setcounter{@index}{1}\@author\@undefineand
}

%% Espacios
\newcommand*{\@normalsize}{\normalsize}
\def\setspace@size{\ifx\@currsize\normalsize\@normalsize\else\@currsize\fi}
\def\doublespacing{\def\baselinestretch{1.660} \setspace@size}
\def\singlespacing{\def\baselinestretch{1} \setspace@size}

%\onehalfspacing
\doublespacing

%% Titulo
\newlength{\@line}
\setlength{\@line}{12pt}

\renewcommand\maketitle{
  \begingroup\doublespacing % always typeset title pages in doublespacing %
  \begin{titlepage}%
  \begin{center}
    \vspace{1.5\@line}\textbf{\large\MakeUppercase{\@institution}}\par
    %\vspace{1.5\@line}\textbf{\large\MakeUppercase{\@nameinstitution}}\par
    \vspace{\@line}\textbf{\large\@faculty}\par
    %\textbf{\large\@department}\par
    %%\vspace{2\@line}\includegraphics{logo.png}\par
    \vspace{2\@line}\includegraphics[width=4cm]{\@logosource}\par
    \vspace{0.5\@line}\textsc{\Large``\@title''}\par
    \vspace{0.5\@line}
    \begin{singlespace}
      \textsc{Trabajo Final de Grado presentado por}\par
      \vfill{\scshape \@typeauthor{\unskip,\par}{\unskip\par y{} }}\par
      \vfill\textsc{como requisito}\par
      \textsc{para obtener el t\'itulo de \@grade}\par
      \textsc{en \@degree}\par
      \vfill\textsc{\@advisorname}\par\vspace{4pt}
      \textsc{\@advisortitle\ \@advisor}\par\vspace{4pt}
    \end{singlespace}
    \vfill\textrm{\@address. \hfill \@monthyear}
  \end{center}
  \end{titlepage}%
  \endgroup
}

\renewcommand{\part}{\ClassError{ucathesis}{Invalid command \string\part}%
  {The \string\part\space command is not available in ucathesis class}}

% Cabeceras
\usepackage{fancyhdr}
\pagestyle{fancy}
%\fancyhead[R]{\fontsize{10}{11}\selectfont \thepage}
%\fancyhead[L]{\ifthenelse{\isodd{\value{page}}}{\leftmark}{\rightmark}}

% Nomenclatura
\usepackage[intoc]{nomencl}
\providecommand{\printnomenclature}{\printglossary}
\providecommand{\makenomenclature}{\makeglossary}
\renewcommand{\nomname}{Glosario}
\renewcommand{\nomlabel}[1]{\hypertarget{#1}{#1}}
\newcommand{\abbr}[1]{\hyperlink{#1}{#1}}

\@ifundefined{chapter}
  {\def\wilh@nomsection{section}}
  {\def\wilh@nomsection{chapter}}

\usepackage{multicol}
\def\thenomenclature{%
  \begin{multicols}{2}[%
    \csname\wilh@nomsection\endcsname*{\nomname}
    \if@intoc\addcontentsline{toc}{\wilh@nomsection}{\nomname}\fi
    \nompreamble]
  \list{}{%
    \labelwidth\nom@tempdim
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \itemsep\nomitemsep
    \let\makelabel\nomlabel}%
}
\def\endthenomenclature{%
  \endlist
  \end{multicols}
  \nompostamble}

\let\@oldlistoffigures=\listoffigures
\let\@oldlistoftables=\listoftables
\renewcommand{\listoffigures}{\@oldlistoffigures\addcontentsline{toc}{chapter}{\'Indice de figuras}}
\renewcommand{\listoftables}{\@oldlistoftables\addcontentsline{toc}{chapter}{\'Indice de cuadros}}
\renewcommand{\listofalgorithms}{\listof{algorithm}{\'Indice de algoritmos}\addcontentsline{toc}{chapter}{\'Indice de algoritmos}}


\let\@oldbibliography=\bibliography
\let\end@oldbibliography=\endbibliography
\renewenvironment{bibliography}[1]{
   \phantomsection\addcontentsline{toc}{chapter}{\bibname}\nocite{*}
   \@oldbibliography{#1}
}{\end{@oldbibliography}}

%% End of unathesis.cls
