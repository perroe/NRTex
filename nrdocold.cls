
\NeedsTeXFormat{LaTeX2e}[1995/12/01]

\ProvidesClass{nrdocold}[2004/03/19 v1.0.3-4 NR report class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Adding logic and math to latex for easy programming
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\usepackage{ifthen}		% for logic in class file
\usepackage{calc}		% for math in class file


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Adding new variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifpdf
\ifx\pdfoutput\undefined
    \pdffalse
\else
    \pdfoutput=1
    \pdftrue
    \pdfcompresslevel=9
\fi
\newlength{\addresslinesep}
\setlength{\addresslinesep}{-0.15em}  
\newboolean{longreport}    
\newboolean{draftversion}  
\newboolean{report}        
\newboolean{screen}        
\newboolean{closedavailability} 
\newboolean{bluelines} 

\newboolean{language_selected}
\newboolean{norsk_selected}
\newboolean{nynorsk_selected}
\newboolean{english_selected}
\newboolean{firstindent}
\newboolean{timesroman}
\setboolean{timesroman}{false}
\newboolean{citenumeric}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Adding new functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\providecommand{\authorname}		{Author} 
\providecommand{\availabilityname}	{Availability}
\providecommand{\closedavailable}	{Closed}
\providecommand{\datename}		{Date}
\providecommand{\examplename}		{Example} 
\providecommand{\emailname}		{e-mail} 
\providecommand{\keywordsname}		{Keywords}
\providecommand{\listexamplename}	{List of Examples}
\providecommand{\numbername}		{no.}
\providecommand{\numberofpagesname}	{No.\ of pages}
\providecommand{\notename} 		{Note} 
\providecommand{\nrdocument}		{NR Document}
\providecommand{\openavailable}		{Open} 
\providecommand{\projectname}		{Project}
\providecommand{\projectnumbername}	{Project no.}
\providecommand{\publicationnumbername}	{Publication no.} 
\providecommand{\researchfieldname}	{Research field}
\providecommand{\reportname}		{Report}
\providecommand{\targetgroupname}	{Target group}
\providecommand{\titlename}		{Title}
\providecommand{\yearname}		{Year}

\providecommand{\printnraddress}{%
 	Norwegian Computing Center\\[\addresslinesep]
	Gaustadall{\'e}en 23, P.O. Box 114 Blindern, 
	NO-0314 Oslo, Norway\\[\addresslinesep]
	Telephone: +47 2285 2500, telefax: +47 2269 7660, 
	\url{http://www.nr.no}
}
\providecommand{\email}[1]{\ifthenelse{\boolean{titlepage}}{%
\ifthenelse{\equal{#1}{}}{}{%  
\xspace\href{mailto:#1}{\texttt{<#1>}}}%
}{\ignorespaces}}


\providecommand{\printyear}{\number\year}
\providecommand{\publicationyear}[1]{\renewcommand{\printyear}{#1}}

\providecommand{\printshorttitle}{\@title}
\providecommand{\shorttitle}[1]{\renewcommand{\printshorttitle}{#1}}

\providecommand{\printtitle}{\@title}
\providecommand{\nrtitle}[1]{\renewcommand{\printtitle}{#1}}

\providecommand{\printisbn}{\typeout{NRdoc warning: ISBN number not set}}
\providecommand{\isbn}[1]{%
\renewcommand{\printisbn}{\MakeUppercase{isbn #1}}}
\providecommand{\shortisbn}[1]{%
\renewcommand{\printisbn}{\MakeUppercase{isbn 82-536-#1}}}

\providecommand{\printreportnumber}{%
\typeout{NRdoc warning: Report number not set}No number}
\providecommand{\reportnumber}[1]{\renewcommand{\printreportnumber}{%
\MakeUppercase{#1}}}

\providecommand{\printkeywords}{%
                \typeout{NRdoc warning: Keywords not defined}}
\providecommand{\keywords}[1]{\renewcommand{\printkeywords}{#1}}

\providecommand{\printproject}{%
                \typeout{NRdoc warning: Project not defined}}
\providecommand{\project}[1]{\renewcommand{\printproject}{#1}}

\providecommand{\printprojectnumber}{%
\typeout{NRdoc warning: Project number not defined}}
\providecommand{\projectnumber}[1]{\renewcommand{\printprojectnumber}{#1}}

\providecommand{\printtarget}{%
                \typeout{NRdoc warning: Target group not defined}}
\providecommand{\target}[1]{\renewcommand{\printtarget}{#1}}

\providecommand{\printresearchfield}{%
\typeout{NRdoc warning: Reserach field not defined}}
\providecommand{\researchfield}[1]{\renewcommand{\printresearchfield}{#1}}

\newboolean{frontpagefiguredefined}
\providecommand{\frontpagefigurefile}{}
\providecommand{\frontpagefigure}[1]{%
\renewcommand{\frontpagefigurefile}{#1}%
\setboolean{frontpagefiguredefined}{true}}

\providecommand{\frontpagefigurecommands}{}
\providecommand{\frontpagefigurecommand}[1]{%
\renewcommand{\frontpagefigurecommands}{#1}}

\providecommand{\nrbarwidth}{1pt}
\providecommand{\nrhorizontalbarwidth}{22mm}
\providecommand{\nrhorizontalbarstartpos}{-29mm}
\newenvironment{titlepagefont}{%
\fontencoding{T1}\fontfamily{ptm}\selectfont}{}
\renewcommand{\ttdefault}{aett}
\renewcommand{\and}{\linebreak}

\newboolean{titlepage}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Handling options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption{long}{\setboolean{longreport}{true}}
\DeclareOption{10pt}{%
\PassOptionsToClass{10pt}{book}\PassOptionsToClass{10pt}{article}}
\DeclareOption{11pt}{%
\PassOptionsToClass{11pt}{book}\PassOptionsToClass{11pt}{article}}
\DeclareOption{12pt}{%
\PassOptionsToClass{12pt}{book}\PassOptionsToClass{12pt}{article}}

\DeclareOption{draft}{%
\setboolean{draftversion}{true}%
\PassOptionsToPackage{draft}{graphicx}%
\PassOptionsToClass{draft}{book}%
\PassOptionsToClass{draft}{article}%
}
\DeclareOption{note}{\setboolean{report}{false}}
\DeclareOption{report}{\setboolean{report}{true}}
\DeclareOption{screen}{\setboolean{screen}{true}%
		       \setboolean{bluelines}{true}}
\DeclareOption{closed}{\setboolean{closedavailability}{true}}
\DeclareOption{bluelines}{\setboolean{bluelines}{true}}
\DeclareOption{american}{\PassOptionsToPackage{american}{babel}
			\setboolean{language_selected}{true}
			\setboolean{english_selected}{true}
			\setboolean{firstindent}{false}}
\DeclareOption{british}{\PassOptionsToPackage{british}{babel}
			\setboolean{language_selected}{true}
			\setboolean{english_selected}{true}
			\setboolean{firstindent}{false}}
\DeclareOption{english}{\PassOptionsToPackage{english}{babel}
			\setboolean{language_selected}{true}
			\setboolean{english_selected}{true}	
			\setboolean{firstindent}{false}}
\DeclareOption{UKenglish}{\PassOptionsToPackage{UKenglish}{babel}
			\setboolean{language_selected}{true}
			\setboolean{english_selected}{true}	
			\setboolean{firstindent}{false}}
\DeclareOption{USenglish}{\PassOptionsToPackage{USenglish}{babel}
			\setboolean{language_selected}{true}
			\setboolean{english_selected}{true}	
			\setboolean{firstindent}{false}}
\DeclareOption{norsk}{\PassOptionsToPackage{norsk}{babel}
			\setboolean{norsk_selected}{true}	
			\setboolean{firstindent}{true}
			\setboolean{language_selected}{true}}
\DeclareOption{nynorsk}{\PassOptionsToPackage{nynorsk}{babel}
			\setboolean{nynorsk_selected}{true}	
			\setboolean{firstindent}{true}
			\setboolean{language_selected}{true}}
\DeclareOption{times}{\setboolean{timesroman}{true}}
\DeclareOption{twoside}{%
\PassOptionsToClass{twoside}{book}%
\PassOptionsToClass{twoside}{article}}%

\DeclareOption{oneside}{%
\PassOptionsToClass{oneside}{book}%
\PassOptionsToClass{oneside}{article}}%
\DeclareOption{citenumeric}{%
\setboolean{citenumeric}{true}}

\ExecuteOptions{11pt,note}
\ProcessOptions*

%  Norwegian translation of cover and title side expressions
\ifthenelse{\boolean{norsk_selected} \or 
	    \boolean{nynorsk_selected}}{% 
	\renewcommand{\authorname}		{Forfatter}  
	\renewcommand{\availabilityname}	{Tilgjengelighet} 
	\renewcommand{\closedavailable}		{Lukket} 
	\renewcommand{\datename}		{Dato}
	\renewcommand{\examplename}             {Eksempel}
	\renewcommand{\emailname}		{e-post}  
	\renewcommand{\keywordsname}		{Emneord}
	\renewcommand{\listexamplename}		{Eksempler}
	\renewcommand{\numbername}		{nr.}
	\renewcommand{\numberofpagesname}	{Antall sider}
	\renewcommand{\notename}		{Notat} 
	\renewcommand{\openavailable}		{{\AA}pen} 
	\renewcommand{\reportname}		{Rapport}  
	\renewcommand{\projectname}		{Prosjekt}
	\renewcommand{\projectnumbername}	{Prosjektnr.}
	\renewcommand{\publicationnumbername}	{Publikasjonsnr.} 
	\renewcommand{\researchfieldname}	{Satsningsomr\aa de}
	\renewcommand{\targetgroupname}		{M\aa lgruppe}
	\renewcommand{\titlename}		{Tittel}
	\renewcommand{\yearname}		{{\AA}r}
 
	\renewcommand{\printnraddress}{%
	Norsk Regnesentral\\[\addresslinesep]
	Gaustadall{\'e}en 23, Postboks 114 Blindern, 
	0314 Oslo\\[\addresslinesep]
        Telefon: 22 85 25 00, telefaks: 22 69 76 60, 
        \url{http://www.nr.no}
	}

%  New Norwegian	
\ifthenelse{\boolean{nynorsk_selected}}{%	
        \renewcommand{\listexamplename}		{Eksempel} 
	\renewcommand{\authorname}		{Forfattar} 
	\renewcommand{\availabilityname}	{Tilgjengeleg}
	\renewcommand{\numberofpagesname}	{Tal p\aa\ sider} 
	\renewcommand{\closedavailable}		{Lukka} 
 	}{}
}{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Loading other packages and the base class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifthenelse{\boolean{firstindent}}{% 
 \RequirePackage{indentfirst}}{}
\ifthenelse{\boolean{timesroman}}{\RequirePackage{times}}{}
\RequirePackage[latin1]{inputenc}  
\RequirePackage{amsmath}	% for advanced math
\RequirePackage{fancyhdr}	% for headers
\RequirePackage{rotating}       % for text rotation
\RequirePackage{makeidx}        % for index
\RequirePackage{multicol}       % for multiple columns
\RequirePackage{paralist}	% for list environments
\RequirePackage{verbatim}	% extra verbatims
\RequirePackage{xspace}         % for space control


\ifpdf\RequirePackage{thumbpdf} \fi      % for thumbnails


\RequirePackage{afterpage}      % for float control
\RequirePackage{color}          % for colour
\RequirePackage{graphicx}	% for graphics inclusion
\ifthenelse{\boolean{language_selected}}{%
	\RequirePackage{babel}
	}{} 

\ifthenelse{\boolean{longreport}}%
{\LoadClass{book}[2000/05/19]}%
{\LoadClass{article}[2000/05/19]}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Loading other packages after the base class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifthenelse{\boolean{citenumeric}}{%
 \usepackage[numbers,sort&compress]{natbib}}{%
 \usepackage[sort,round]{natbib}
}
        

\definecolor{nrgreen}{rgb}{0,0.65,0}

\ifthenelse{\boolean{screen}}{
% use hypertex tools 
\ifpdf
  \usepackage[pdftex,colorlinks=true,%
	      plainpages=false,citecolor=nrgreen,%
	      backref=page]{hyperref}
\else
  \usepackage[dvipdfm,colorlinks=true,%
	      plainpages=false,citecolor=nrgreen,%
	      backref=page]{hyperref}
\fi
  }{%
% Set all hypertex links black %
\ifpdf 
  \usepackage[pdftex,colorlinks=true,plainpages=false,% 
	      linkcolor=black,citecolor=black,% 
              pagecolor=black,urlcolor=black]{hyperref} 
\else
  \usepackage[dvipdfm,colorlinks=true,plainpages=false,% 
              linkcolor=black,citecolor=black,% 
              pagecolor=black,urlcolor=black]{hyperref} 
\fi 
} 
\providecommand{\clearemptydoublepage}{% 
                \newpage{\thispagestyle{empty}\cleardoublepage}}


\setlength{\headheight}{14pt}
\usepackage[a4paper]{geometry}
\usepackage{a4wide}   


\ifcase \@ptsize
    \textheight 56\baselineskip  % original 53 
\or
    \textheight 48\baselineskip  % original 46
\or
    \textheight 44\baselineskip  % original 42
\fi

\advance\textheight by \topskip


\ifthenelse{\boolean{screen}}{%
\setlength{\evensidemargin}{\oddsidemargin}}{} 

\definecolor{nrblue}{cmyk}{1,0.72,0,0.18}
\providecommand{\nrwhitebar}{%
\noindent\hspace{-20mm}%
\makebox[0pt]{\raisebox{\nrhorizontalbarstartpos}[0pt][0pt]{%
{\textcolor{white}{\rule{2\paperwidth}{\nrhorizontalbarwidth}}}}}%
}

\providecommand{\nrtopbar}{%
\ifthenelse{\boolean{bluelines}}{%
\makebox[0pt]{\raisebox{\nrhorizontalbarstartpos}[0pt][0pt]{%
 \rule{2\paperwidth}{\nrbarwidth}}}}{}
}

\providecommand{\nrbotbar}{%
\ifthenelse{\boolean{bluelines}}{%
\makebox[0pt]{\raisebox{\nrhorizontalbarstartpos + \nrhorizontalbarwidth}
 [0pt][0pt]{\rule{2\paperwidth}{\nrbarwidth}}}}{}
}

\providecommand{\nrlogobar}{%
\raisebox{\nrhorizontalbarstartpos + 5mm}
[0pt][0pt]{\hspace{-5mm}%
\ifthenelse{\not\boolean{bluelines}}{}{%
\ifthenelse{\boolean{language_selected}}{%
\ifthenelse{\boolean{english_selected}}{%
\includegraphics[height=15mm]{logos/logoeng}}{%
\includegraphics[height=15mm]{logos/logonor}}
}{% 
\includegraphics[height=15mm]{logos/logoeng}
}}}%
\hfill%
\raisebox{\nrhorizontalbarstartpos + 8mm}[0pt][0pt]{%
\ifthenelse{\not\boolean{bluelines}}{}{%
\scalebox{1}[1.1]{%
\textbf{\Huge{\ifthenelse{\boolean{report}}{\MakeUppercase{\reportname}}{%
 \MakeUppercase{\notename}}}}}}\makebox[0mm]{}
}}

\providecommand{\nrhorizontalbar}{%
\nrwhitebar%
\nrtopbar%
\nrbotbar%
\nrlogobar%
}
\providecommand{\nrverticalbar}{%
 \hspace{8mm}%
 \begin{rotate}{90}
\ifthenelse{\boolean{bluelines}}{%
\makebox[0pt]{\raisebox{-20mm}[0pt][0pt]{%
{\color{nrblue}{\rule{2\paperheight}{\nrbarwidth}}}}}}{}%
\end{rotate}
}
\providecommand{\nrtitlebar}{%
\raisebox{10mm}[0pt][0pt]{%
\makebox[80mm]{}
\makebox[40mm]{%
\begin{minipage}[c]{120mm}
\begin{center}
\Huge\textbf{\@title}
\end{center}
\end{minipage}}}%
\par}
\providecommand{\nrfigurebar}{%
\raisebox{-140mm}[0pt][0pt]{%
\makebox[80mm]{}\makebox[40mm]{%
\begin{minipage}[c]{120mm}
\begin{center}
\ifthenelse{\boolean{frontpagefiguredefined}}{%
   \includegraphics[width=120mm]{\frontpagefigurefile}}{
   \frontpagefigurecommands} 
\end{center}
\end{minipage}}}%
\par}
\providecommand{\nrauthorbar}{%
\raisebox{-200mm}[0pt][0pt]{%
\hspace{-25mm}%
\begin{minipage}[b]{45mm}
\begin{flushright}

\ifthenelse{\boolean{report}}%
{\textbf{\printisbn}}
{\textbf{\printreportnumber}}

\vspace{1em}

\@author

\vspace{2em}

\@date
\end{flushright}
\end{minipage}}\par%
} 
\providecommand{\nrfrontpage}{%
\ifthenelse{\boolean{draftversion}}{}{% else final version
\thispagestyle{empty}%
\nrtitlebar%
\nrfigurebar%
\nrauthorbar%
\textcolor{nrblue}{%
\nrverticalbar%
\nrhorizontalbar}%
\clearemptydoublepage}
}


\providecommand{\nrtitlepagetop}{%
\mbox{}

\vspace{-20mm}

\noindent
 \ifthenelse{\boolean{language_selected}}%
{\ifthenelse{\boolean{english_selected}}%
 {\includegraphics[height=15mm]{logos/logoeng}%
 }%
 {\includegraphics[height=15mm]{logos/logonor}
 }%
}%
{\includegraphics[height=15mm]{logos/logoeng}
} \hfill\textbf{NR \ifthenelse{\boolean{report}}{\reportname}{\notename} }

\noindent
\rule{\linewidth}{1pt}
}

\providecommand{\nrtitlepage}{%
 \clearemptydoublepage\setboolean{titlepage}{true}
\thispagestyle{empty} 

\nrtitlepagetop

\vspace{1.0em}

\noindent
\begin{minipage}[t]{0.7\linewidth}
\textbf{\titlename:} 
\begin{minipage}[t]{80mm}\raggedright
\printtitle 
\end{minipage}

\vspace{2em}

\noindent
\textbf{\authorname:} 
\begin{minipage}[t]{80mm}\raggedright\@author \end{minipage}

\end{minipage}%
\begin{minipage}[t]{0.3\linewidth}
\textbf{\datename:} \@date\\
\textbf{\yearname:} \printyear \\
\ifthenelse{\boolean{report}}{\textbf{\printisbn}\\ }{}%
\textbf{%
\ifthenelse{\boolean{report}}%
{\publicationnumbername:}%
{\notename\ \numbername:}} \printreportnumber 
\end{minipage}% 

\vspace{2em}



\vspace{3em}\par
}

\newboolean{titlepagemade}

\providecommand{\mainmatter}{\pagenumbering{arabic}}

\ifthenelse{\boolean{longreport}}{%
\newenvironment{abstract}{%
 \ifthenelse{\not\boolean{titlepagemade}}{%
 \typeout{NRdoc warning: abstract must be put after "\protect\titlepage" command.}}{}
\begin{titlepagefont}
\noindent\textbf{\abstractname:}}%
{\vfill
\noindent\textbf{\keywordsname:} \printkeywords \vspace{1em}\par
\noindent\textbf{\targetgroupname:} \printtarget \vspace{1em}\par
\noindent\textbf{\availabilityname:} 
\ifthenelse{\boolean{closedavailability}}{%
            \closedavailable}{\openavailable} %
\vspace{1em}\par
\noindent\textbf{\projectname:} \printproject \vspace{1em}\par
\noindent\textbf{\projectnumbername:} \printprojectnumber \vspace{1em}\par
\noindent\textbf{\researchfieldname:} \printresearchfield \vspace{1em}\par
\noindent\textbf{\numberofpagesname:} \pageref*{LastPage} \vspace{2em}\par
\noindent\rule{\linewidth}{1pt} 
 {\footnotesize\printnraddress
 \par\noindent		
  Copyright \copyright\ \printyear\
  by Norwegian Computing Center, Oslo, Norway\\
  All rights reserved. Printed in Norway.
    }
\end{titlepagefont}
\clearemptydoublepage 
  }}{
\renewenvironment{abstract}{% 
 \ifthenelse{\not\boolean{titlepagemade}}{%
 \typeout{NRdoc warning: abstract must be put after "\protect\titlepage" command.}}{}
\begin{titlepagefont}
\noindent\textbf{\abstractname:}}%
{\vfill
\noindent\textbf{\keywordsname:} \printkeywords \vspace{1em}\par
\noindent\textbf{\targetgroupname:} \printtarget \vspace{1em}\par
\noindent\textbf{\availabilityname:} 
\ifthenelse{\boolean{closedavailability}}{%
            \closedavailable}{\openavailable} %
\vspace{1em}\par
\noindent\textbf{\projectname:} \printproject \vspace{1em}\par
\noindent\textbf{\projectnumbername:} \printprojectnumber \vspace{1em}\par
\noindent\textbf{\researchfieldname:} \printresearchfield \vspace{1em}\par
\noindent\textbf{\numberofpagesname:} \pageref*{LastPage} \vspace{2em}\par
\noindent\rule{\linewidth}{1pt} 
 {\footnotesize\printnraddress
 \par\noindent		
  Copyright \copyright\ \printyear\
  by Norwegian Computing Center, Oslo, Norway\\
  All rights reserved. Printed in Norway.
    }
\end{titlepagefont}
\clearemptydoublepage 
  }}


\renewcommand{\maketitle}[1]{%
        \setboolean{titlepagemade}{true} 
	\hypersetup{pdftitle={\printtitle},		    
		    pdfauthor={Norwegian Computing Center}}
	\addtocounter{page}{-2}
	\begin{titlepagefont}
	\nrfrontpage		
	\pagenumbering{roman}
	\nrtitlepage	
	\addtocounter{page}{-\value{page}}
	\addtocounter{page}{1}
	\end{titlepagefont}
	\relax
}

\ifthenelse{\boolean{longreport}}{%
\renewcommand{\tableofcontents}{%
\clearemptydoublepage
    \thispagestyle{empty}
    \chapter*{\contentsname
        \@mkboth{%
           \contentsname}{\contentsname}}%          
      \addtocontents{toc}{\protect\hypertarget{toc}{}%	
        \protect\pdfbookmark[0]{\contentsname}{toc}}             
    \@starttoc{toc}%
\clearemptydoublepage
}}{
\renewcommand{\tableofcontents}{%
\clearemptydoublepage
    \thispagestyle{empty}
    \section*{\contentsname
        \@mkboth{%
           \contentsname}{\contentsname}}%          
      \addtocontents{toc}{\protect\hypertarget{toc}{}%	
        \protect\pdfbookmark[1]{\contentsname}{toc}}             
    \@starttoc{toc}%
      \clearemptydoublepage
}}

\ifthenelse{\boolean{longreport}}{%
\renewcommand{\listoffigures}{% 
   \thispagestyle{empty}
    \chapter*{\listfigurename
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}}%
      
      \addtocontents{toc}{\protect\hypertarget{toc}{}%	
        \protect\pdfbookmark[0]{\listfigurename}{toc}}
    \@starttoc{lof}% 
    \clearemptydoublepage
    }
}{% else
\renewcommand{\listoffigures}{% 
    \thispagestyle{empty}
    \section*{\listfigurename
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}}% 
         \addtocontents{toc}{\protect\hypertarget{toc}{}%	
        \protect\pdfbookmark[1]{\listfigurename}{toc}} 
    \@starttoc{lof}% 
    \clearemptydoublepage
    }
  }	

\ifthenelse{\boolean{longreport}}{%
\renewcommand{\listoftables}{% 
   \thispagestyle{empty}
    \chapter*{\listtablename
      \@mkboth{\MakeUppercase\listtablename}%
              {\MakeUppercase\listtablename}}%
      
      \addtocontents{toc}{\protect\hypertarget{toc}{}%	
        \protect\pdfbookmark[0]{\listtablename}{toc}}
    \@starttoc{lot}% 
    \clearemptydoublepage
    }
}{% else
\renewcommand{\listoftables}{% 
    \thispagestyle{empty}
    \section*{\listtablename
      \@mkboth{\MakeUppercase\listtablename}%
              {\MakeUppercase\listtablename}}% 
         \addtocontents{toc}{\protect\hypertarget{toc}{}%	
        \protect\pdfbookmark[1]{\listtablename}{toc}} 
    \@starttoc{lot}% 
    \clearemptydoublepage
    }
  }	
\ifthenelse{\boolean{longreport}}{%
\newcommand{\listofexamples}{% 
   \thispagestyle{empty}
    \chapter*{\listexamplename
      \@mkboth{\MakeUppercase\listexamplename}%
              {\MakeUppercase\listexamplename}}%
      
      \addtocontents{toc}{\protect\hypertarget{toc}{}%	
        \protect\pdfbookmark[0]{\listexamplename}{toc}}
    \@starttoc{loe}% 
    \clearemptydoublepage
    }
}{% else
\newcommand{\listofexamples}{% 
    \thispagestyle{empty}
    \section*{\listexamplename
      \@mkboth{\MakeUppercase\listexamplename}%
              {\MakeUppercase\listexamplename}}% 
         \addtocontents{toc}{\protect\hypertarget{toc}{}%	
        \protect\pdfbookmark[1]{\listexamplename}{toc}} 
    \@starttoc{loe}% 
    \clearemptydoublepage
    }
  }	

\ifthenelse{\boolean{longreport}}{
  \newcounter{example}[chapter]
  \def\theexample{\thechapter.\@arabic\c@example}
}{
  \newcounter{example}[section]
  \def\theexample{\thesection.\@arabic\c@example}
}



\let\l@example\l@figure

\providecommand\ext@example{loe}
\providecommand\fnum@example{\examplename~\theexample}
%
\def\toclevel@example{0}
\def\ftype@example{2}

\newenvironment{example}{
\def\@captype{example} 
}{}



\pagestyle{fancy}

\ifthenelse{\boolean{@twoside}}
{%
\cfoot[]{}\rfoot[]{}\lfoot[]{}\chead[]{}

\rhead[\fancyplain{\bf\ifthenelse{\boolean{report}}{%
\printisbn}{\printreportnumber}}{%
\bf\ifthenelse{\boolean{report}}{\printisbn}{\printreportnumber}}]
{\fancyplain{\bf\thepage}{\bf\thepage}}
\lhead[\fancyplain{\bf\thepage}{\bf\thepage}]
{\fancyplain{\bf\printshorttitle}{\bf\printshorttitle}}

\fancypagestyle{fancy}{%
\cfoot[]{}\rfoot[]{}\lfoot[]{}\chead[]{}
\rhead[\fancyplain{\bf\ifthenelse{\boolean{report}}{%
\printisbn}{\printreportnumber}}{%
\bf\ifthenelse{\boolean{report}}{\printisbn}{\printreportnumber}}]
{\fancyplain{\bf\thepage}{\bf\thepage}}
\lhead[\fancyplain{\bf\thepage}{\bf\thepage}]
{\fancyplain{\bf\printshorttitle}{\bf\printshorttitle}}
}}
{%
\cfoot[]{}\rfoot[]{}\lfoot[]{}\chead[]{}

\rhead[\fancyplain{\bf\thepage}{\bf\thepage}]
{\fancyplain{\bf\thepage}{\bf\thepage}}
\lhead[\fancyplain{\bf\thepage}{\bf\thepage}]
{\fancyplain{\bf\printshorttitle}{\bf\printshorttitle}}

\fancypagestyle{fancy}{%
\cfoot[]{}\rfoot[]{}\lfoot[]{}\chead[]{}
\rhead[\fancyplain{\bf\thepage}{\bf\thepage}]
{\fancyplain{\bf\thepage}{\bf\thepage}}
\lhead[\fancyplain{\bf\thepage}{\bf\thepage}]
{\fancyplain{\bf\printshorttitle}{\bf\printshorttitle}}
}
}

% Fancy heading for first chapter page also
\ifthenelse{\boolean{longreport}}{}{%
\fancypagestyle{plain}{%
\cfoot[]{}\rfoot[]{}\lfoot[]{}\chead[]{}
\rhead[\fancyplain{\bf\printreportnumber}{\bf\printreportnumber}]
{\fancyplain{\bf\thepage}{\bf\thepage}}
\lhead[\fancyplain{\bf\thepage}{\bf\thepage}]
{\fancyplain{\bf\printshorttitle}{\bf\printshorttitle}}
}}

\renewcommand{\sectionmark}[1]{\markboth{}{}}

\ifthenelse{\boolean{citenumeric}}{%	
            \bibliographystyle{unsrtnat} %\bibliographystyle{nrunsrt}
            \typeout{nrdoc uses numeric citation labels}
}{% 
\ifthenelse{\boolean{norsk_selected}%
		\or%
	    \boolean{nynorsk_selected}}{%
            \typeout{nrdoc uses alphabethic citation labels}
	    \bibliographystyle{nrnorsk}
}{% 
            \bibliographystyle{plainnat} %\bibliographystyle{nrplain}
           \typeout{nrdoc uses alphabethic citation labels}
}
}
 
\ifthenelse{\boolean{longreport}}{%
\renewenvironment{theindex}{%                
                 \clearemptydoublepage
                \chapter*{\indexname}%
		\thispagestyle{empty}%
                 \addcontentsline{toc}{chapter}{\indexname}
		 
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem\begin{multicols}{2}}
               {\end{multicols}}
}{% else
\renewenvironment{theindex}{%                
                 \clearemptydoublepage
                \section*{\indexname}%	
	        \thispagestyle{empty}%
                 \addcontentsline{toc}{section}{\indexname}
		 
                \@mkboth{\MakeUppercase\indexname}%
                        {\MakeUppercase\indexname}%
                \parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem\begin{multicols}{2}}
               {\end{multicols}}
  }


\ifthenelse{\boolean{longreport}}{%
\renewenvironment{thebibliography}[1]
     {\chapter*{\refname
        \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}% 
       \addcontentsline{toc}{chapter}{\refname}
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist} 
}{% 
\renewenvironment{thebibliography}[1]
     {\section*{\refname
        \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}% 
      \addcontentsline{toc}{section}{\refname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}% 
      \endlist}
}
 


\ifthenelse{\boolean{longreport}}{%
\renewcommand\chapter{
                    \clearemptydoublepage		      
                    \thispagestyle{empty}%
                    \global\@topnum\z@
                    \@afterindentfalse
		      \secdef\@chapter\@schapter}}




\def\lastpage@putlabel{\addtocounter{page}{-1}%
   \immediate\write\@auxout{\string
   \newlabel{LastPage}{{}{\thepage}{\relax}{}{}}}%
   \addtocounter{page}{1}}


\providecommand{\floor}[1]{\lfloor #1 \rfloor}
\providecommand{\ceil}[1]{\lceil #1 \rceil}


\AtBeginDocument{} 

\AtEndDocument{%
   \printindex%
   \clearpage\lastpage@putlabel%
} 
