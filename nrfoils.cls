%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	Identification 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nrfoils}[2004/10/05]

\RequirePackage{ifthen}
\RequirePackage{babel}

\RequirePackage{color} 

\RequirePackage[urlcolor=yellow]{hyperref}

\RequirePackage{pause}
\RequirePackage{moreverb}
\RequirePackage{background}
\RequirePackage{graphicx}
\RequirePackage{helvet}
\RequirePackage{paralist}
\RequirePackage[latin1]{inputenc} 


\newboolean{draftversion}
\setboolean{draftversion}{false}
\newboolean{handouts}
\setboolean{handouts}{false}
\newboolean{white}
\setboolean{white}{false}
% -------  Options


\DeclareOption{pdftex,english,norsk,american}{%

\PassOptionsToPackage{english,norsk,american}{babel}
\PassOptionsToPackage{pdftex}{geometry,color,graphicx}}

\DeclareOption{window}{\setboolean{draftversion}{true}}
\DeclareOption{handout}{\setboolean{handouts}{true}}
\DeclareOption{white}{\setboolean{white}{true}}

\DeclareOption{pdftex}{%
\PassOptionsToClass{pdftex}{foils}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{foils}}





\ProcessOptions 



% -------  Package loading -------


\LoadClass[30pt,landscape]{foils}


% -------  Main code
\usepackage{geometry}
\geometry{headsep=3ex,hscale=0.9}


\hypersetup{pdfpagemode=UseThumbs}
 

\definecolor{nrblue}{RGB}{8,46,154}

\rightfooter{}
\rightheader{%
\mbox{}\makebox[\textwidth]{%
\begin{minipage}{1.05\paperwidth}
\raisebox{-15mm}[0pt][0pt]{%
\mbox{}\hspace{-0mm}\textcolor{nrblue}{%
\rule{1.05\paperwidth}{30mm}}}\\[-\baselineskip]%
\raisebox{-205.5mm}[0pt][0pt]{%
\mbox{}\hspace{-0mm}\textcolor{nrblue}{%
\rule{1.05\paperwidth}{25mm}}}\\[-\baselineskip]%
\raisebox{-205.5mm}[0pt][0pt]{%
\mbox{}\hspace{7mm}\includegraphics[height=25mm]{logos/NR_wave}}\\[-\baselineskip]%
\raisebox{-195mm}[0pt][0pt]{%
\hspace{270mm}\textcolor{white}{\textsf{\tiny\thepage}}}%
\end{minipage}
}}

\MyLogo{} 
\parindent 0pt % do not indent paragraphs
\rightskip 0pt plus 1fil % allow ragged right
%% select colors
%%   for the frames/page numbers etc.
\ifthenelse{\boolean{handouts}}{%
\typeout{Making handouts}%
\renewcommand{\pause}{} 
\makeatletter
\def\@pdfborder{0 0 0}
\makeatother
\color{black}% 
\renewcommand\normalcolor{\color{black}}%
}{%
\hypersetup{colorlinks=true}%

\color{white}    % text


%% choose some colored item labels
\renewcommand{\labelitemi}{\textcolor{red}{$\bullet$}}
\renewcommand{\labelitemii}{\textcolor{yellow}{$\star$}}
\renewcommand{\labelitemiii}{\textcolor{magenta}{$\ast$}}
\renewcommand{\labelitemiv}{\textcolor{cyan}{$\circ$}}}


\def\maketitle{\par
  \begingroup
    \setcounter{page}{0}
    \def\thefootnote{\fnsymbol{footnote}} \newpage
	
    \@maketitle
    \thispagestyle{foilheadings}
    \@thanks
  \endgroup
  \setcounter{footnote}{0}
  \let\maketitle\relax \let\@maketitle\relax
  \gdef\@thanks{}\gdef\@author{}\gdef\@title{}\let\thanks\relax%
  %
  \pagebreak[4]\LogoOff
  \ifthenelse{\boolean{white}}{%
  \pagecolor{white}\color{black}}{}
}
\def\@maketitle{\newpage\pagecolor{nrblue} % background
\zerolistvertdimens
  \if@compatibility\else
    \advance\abovetitleskip -\baselineskip % \null adds this space
  \fi
  \null\vskip\abovetitleskip
  \mbox{}\hspace{210mm}\makebox[0pt]{\raisebox{-165mm}[0pt][0pt]{%	
	\includegraphics[width=0.4\paperwidth]{logos/NR_ball_rgb}}}\\
	\raisebox{40mm}[0pt][0pt]{%
	\mbox{}\hspace{-15mm}%
	\includegraphics[height=25mm]{logos/NR_wave}}%
	\hspace{90mm}%
	\raisebox{45mm}[0pt][0pt]{\small\texttt{www.nr.no}}%

  \vspace{-4em}  

  \vspace*{\stretch{2}}
  \begin{flushleft}
    
     {\large\bfseries \@title \par}
     \vskip\titleauthorskip
     {\small\lineskip \authorauthorskip
       \@author
       \par}
	
     {\small\vskip\authordateskip {\@date}}
  \end{flushleft}
  \par
  \vspace*{\stretch{0.5}}
  %\vfil
}

\newcommand{\section}[1]{\foilhead{\raisebox{10mm}[0pt]{\textcolor{white}{#1}}}\par\vspace{-25mm}\par}