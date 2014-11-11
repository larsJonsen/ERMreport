 %%%% file ermreport.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ermreport}[2014/10/14 v0.1 erm report]
\newif\if@danish\@danishfalse
\newif\if@note\@notefalse
\newif\if@biblatex\@biblatexfalse
\newif\if@biber\@biberfalse
\newif\if@chapfig\@chapfigfalse
% ********************************************************************
% Options
% ******************************************************************** 
\DeclareOption{danish}{\@danishtrue%
  \PassOptionsToClass{danish}{memoir}%
  \PassOptionsToPackage{danish}{bable}
}
\DeclareOption{note}{\@notetrue}
\DeclareOption{biblatex}{\@biblatextrue}
\DeclareOption{biber}{\@bibertrue}
\DeclareOption{chapfig}{\@chapfigtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions\relax
% ********************************************************************
% Package
% ********************************************************************
\LoadClass{memoir}%[⟨date⟩]
\RequirePackage{etoolbox}
\RequirePackage{graphicx}
\RequirePackage{pdfpages}
\PassOptionsToClass{breaklinks}{hyperref}
\RequirePackage{hyperref}
% Palatino with real small caps and old style figures 
\PassOptionsToPackage{osf,sc}{mathpazo}
\RequirePackage{mathpazo} 
\RequirePackage{microtype} 
% utf8 needed for biber
\RequirePackage[utf8]{inputenc}
% qutation marks set to english style even for danish
\RequirePackage[style=english]{csquotes}
\PassOptionsToPackage{dvipsnames}{xcolor}
\RequirePackage{xcolor}
% ********************************************************************
% Page layout
% ********************************************************************
\setlxvchars %65 characters
\linespread{1.05}\selectfont % a bit more line space for Palatino
\newlength{\text@height}
\setlength{\text@height}{39\baselineskip}
\addtolength{\text@height}{\topskip} %40 lines
\settypeblocksize{\text@height}{1.08\lxvchars}{*}
\setlrmargins{*}{*}{1.5}
\setulmargins{*}{*}{1.5}
\setmarginnotes{17pt}{51pt}{\onelineskip}
\checkandfixthelayout
%% No extra space at '.'
\frenchspacing
% *******************************************************************
% Fonts declaration
% ********************************************************************

\microtypesetup{expansion=false}%
% Capital nummbers for all caps headings
\DeclareRobustCommand\liningnums{\fontfamily{pplx}\selectfont}%
% Spaced all caps for headings
\DeclareRobustCommand{\spacedsmallcaps}[1]{\textls[80]{\scshape{#1}}} 
\DeclareRobustCommand{\spacedcaps}[1]{\textls[160]{\liningnums{#1}}}%
\DeclareRobustCommand{\spacedallcaps}[1]{\spacedcaps{\MakeTextUppercase{#1}}}%
\DeclareRobustCommand{\spacedlowsmallcaps}[1]{\spacedsmallcaps{\MakeTextLowercase{#1}}}
\DeclareRobustCommand{\smallcaps}[1]{{\scshape\MakeTextLowercase{#1}}}
% Chapter number font
\newfont{\chapterNumber}{eurb10 scaled 7000}
% ********************************************************************
% Colors for hyperlinks and chapter
% ********************************************************************
\definecolor{halfgray}{gray}{0.55} % chapter numbers 
\definecolor{webgreen}{rgb}{0,.5,0}
\definecolor{webbrown}{rgb}{.6,0,0}
%\definecolor{Maroon}{cmyk}{0, 0.87, 0.68, 0.32}
\definecolor{RoyalBlue}{cmyk}{1, 0.50, 0, 0}
% ********************************************************************
% Bibliography
% ********************************************************************
\if@biber
  \PassOptionsToPackage{authordate,natbib,backend=biber,isbn=false}{biblatex-chicago}
  \RequirePackage{biblatex-chicago}
\else
  \if@biblatex
    \PassOptionsToPackage{authordate,natbib,backend=bibtex,isbn=false}{biblatex-chicago}
    %\PassOptionsToPackage{style=authoryear,natbib=true,backend=bibtex,isbn=false}{biblatex}
    \RequirePackage{biblatex-chicago}
  \else
    \PassOptionsToPackage{authoryear}{natbib}
    \RequirePackage{natbib}
  \fi
\fi
% ********************************************************************
% Title pages and freinds
% ********************************************************************
\newcommand{\maxLength}[2]{%
  \ifdimcomp{#1}{>}{#2}{#1}{#2}
}
% For list loops
\newcommand*{\@doList}[1]{#1\\}
\newcommand*{\@doList@i}[1]{#1\\[2ex]}
\newcommand*{\@doList@ii}[1]{%
  \rule[0.5ex]{0.8\textwidth}{1pt}\par
  #1\par
  \vspace{3em}
}
\newcommand*{\@doList@iii}[1]{, #1}
% Title
\newcommand{\setTitle}[1]{\def\ermTitle{#1}}
\newcommand{\setSubtitle}[1]{\def\ermSubtitle{#1}}
% Date
\newcommand{\setDate}[1]{\def\ermDate{#1}}
\newcommand{\setPlace}[1]{\def\ermPlace{#1}}
\newcommand{\setSubject}[1]{\def\ermSubject{#1}}
\newcommand{\setStudy}[1]{\def\ermStudy{#1}}
\newcommand{\setUniversity}[1]{\def\ermUniversity{#1}}
% Author
\newlength{\len@Aut}
\newlength{\len@Sup}
\setlength{\len@Aut}{0pt}
\setlength{\len@Sup}{0pt}
\newlength{\len@B}
\newlength{\len@C}
\newcommand{\setAuthor}[2][\mbox{}]{%
  \settowidth{\len@B}{\large{#2}}%
  \setlength{\len@Aut}{\maxLength{\len@Aut}{\len@B}}
  \settowidth{\len@B}{\large\liningnums{#1}}%
  \setlength{\len@Sup}{\maxLength{\len@Sup}{\len@B}}
  \listadd{\AuthorList}{#2}
  \listadd{\SupAuthorList}{#1}
}
% Supervisor
\newcounter{count@Sup}
\newcommand{\setSupervisor}[1]{%
  \stepcounter{count@Sup}
  \listadd{\SupervisorList}{#1}}
  % Supervisor text
\newcommand{\setSupervisorText}[2]{%
  \def\ermSup@i{#1}
  \def\ermSup@ii{#2}
}
% Input pdfs
\newcommand{\setTrustpage}[1]{\def\ermTrustpage{#1}}
\newcommand{\setCover}[1]{\def\ermCover{#1}}
% Logo
\newcommand{\setCoverLogo}[1]{\def\coverLogo{#1}}
\setCoverLogo{%
  \includegraphics[width=0.39\textwidth]{sdu_segl}
  \hfill
  \includegraphics[width=0.42\textwidth]{aau_segl}
}
\newcommand{\setTitleLogo}[1]{\def\titleLogo{#1}}
%
\setTitleLogo{%
  \includegraphics[width=0.47\textwidth]{sdu_logo}
  \hfill
  \includegraphics[width=0.44\textwidth]{aau_logo}
}
% Colophon text
\newcommand{\setColophon}[1]{\def\ermColophonText{#1}}
% Trust Text
\newcommand{\setTrustText}[1]{\def\ermTrustText{#1}}
% Cover
\newcommand{\coverpage}{%
  \ifdefined\ermCover
    \includepdf{\ermCover}
  \else
    \calccentering{\unitlength}
    \begin{adjustwidth*}{\unitlength}{-\unitlength}
    \begin{center}
    \vspace*{\fill}
    \spacedallcaps\ermTitle\par
    \ifdefined\ermSubtitle
      \spacedlowsmallcaps\ermSubtitle\par
    \fi
    \bigskip
    \ifdefined\AuthorList
      \let\do=\@doList
      \large{\dolistloop{\AuthorList}}
    \fi  
    \vfill
    \vfill
    \coverLogo
    \thispagestyle{empty}
    \end{center}
    \end{adjustwidth*}
  \fi
}
% Title page
\newcommand{\titlepage}{
  \clearforchapter
  \thispagestyle{empty}
  \begin{center}
  \spacedallcaps\ermSubject\par 
  \spacedlowsmallcaps\ermStudy\par
  \spacedlowsmallcaps\ermUniversity\par
  \vfill
  \spacedallcaps\ermTitle\par
  \ifdefined\ermSubtitle
    \spacedlowsmallcaps\ermSubtitle\par
  \fi
  \vspace{2em}
  \ifdefined\AuthorList
    \begin{minipage}[t]{\len@Aut}%
          \let\do=\@doList%
          \large{\dolistloop{\AuthorList}}%
        \end{minipage}%
    \hspace{2ex}%
    \begin{minipage}[t]{\len@Sup}%
          \let\do=\@doList
          \raggedleft
          \large\liningnums{\dolistloop{\SupAuthorList}}
    \end{minipage}\par 
  \fi
  \vfill
  \ifdefined\SupervisorList
    \setlength{\len@B}{\textwidth}
    \ifnumless{\value{count@Sup}}{2}{%
    \ermSup@i\settowidth{\len@C}{\ermSup@i\hspace{2ex}}%
    }{%
    \ermSup@ii\settowidth{\len@C}{\ermSup@ii\hspace{2ex}}%
    }\hfill%
    \addtolength{\len@B}{-\len@C}
    \begin{minipage}[t]{\len@B}
      \let\do=\@doList@i
      \dolistloop{\SupervisorList} 
    \end{minipage}\par
  \fi
  \titleLogo
  \end{center}
}
% Colophon
\newcommand{\colophon}{%
  \ifdefined\ermColophonText
    \clearpage
    \thispagestyle{empty}
    \vspace*{\fill}
    \calccentering{\unitlength}
    \begin{adjustwidth*}{\unitlength}{-\unitlength}
    \begin{center}
    \ermColophonText
    \end{center}
    \end{adjustwidth*}
    \vfill
    \vspace*{\fill}
  \else
    \relax
  \fi
}
% Declaration page
\newcommand{\trustpage}{%
  \ifdefined\ermTrustpage
    \includepdf{\ermTrustpage}
    \addcontentsline{toc}{chapter}{\trustHead}
  \else
    \chapter{\trustHead}
    \vspace*{\fill}
    \begin{quote}
    \ermTrustText\par
    \vspace{2em}
    \ermPlace, \ermDate\par
    \vspace{2cm}
    \end{quote}
    \ifdefined\AuthorList
      \begin{center}
      \begin{minipage}{0.8\textwidth}
        \let\do=\@doList@ii
        \dolistloop{\AuthorList}
      \end{minipage}
      \end{center}
    \fi
    \vspace*{\fill}
  \fi
}
% Title page for note mode
\newcommand{\notetitlepage}{%
  \newpage
  \null
  \thispagestyle{plain}
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\Large \spacedallcaps\ermTitle \par
    \ifdefined\ermSubtitle
      \spacedlowsmallcaps\ermSubtitle \par
    \fi}%
    \vskip 1.5em%
    {\large \ifdefined\AuthorList
      \let\do=\@doList
      \large{\dolistloop{\AuthorList}}
    \fi}% 
    \vskip 1em%
    {\large \ifdefempty\ermDate{\today}{\ermDate}}%    
  \end{center}%
  \par
  \vskip 1.5em}
% ********************************************************************
% Specific for lyx
% ********************************************************************
% Gluing evrything togheteher, for LYX
\newcommand{\ermFront}{%
  \if@note
    \pdfsetup
    \mainmatter
    \notetitlepage
  \else
    \pdfsetup
    \coverpage
    \frontmatter
    \titlepage
    \colophon
    \trustpage
  \fi
}
% Making chapter start mainmatter. For Lyx
\def\ermChapter{%
  \@ifnextchar[%
    {\ermChapter@i}
    {\ermChapter@i[]}%
}
\def\ermChapter@i[#1]{%
  \@ifnextchar[%
  {\ermChapter@ii{#1}}
  {\ermChapter@ii{#1}[]}%
}
\def\ermChapter@ii#1[#2]#3{%
  \ifanappendix
    \relax
  \else
    \ifnum\value{chapter} = 0 \mainmatter \fi
  \fi
  \chapter[#1][#2]{#3}%   
}
% If note, normal article style 
\if@note
  \let\ermChapter=\chapter
  \aliaspagestyle{chapter}{note}
\fi
% ********************************************************************
%Abstract and freinds
% ********************************************************************
\renewenvironment{abstract}{%
  \chapter*{\abstractHead}
}{}
\newenvironment{resume}{%
  \chapter*{\resumeHead}
}{}
\newenvironment{dedication}{%
  \clearforchapter
  \thispagestyle{empty}
  \vspace*{\fill}
  \calccentering{\unitlength}
  \begin{adjustwidth*}{\unitlength}{-\unitlength}
  \begin{center}
}{
  \end{center}
  \end{adjustwidth*}
  \vspace*{\fill}\clearpage
}
\newenvironment{acknowledgment}{%
  \chapter*{\acknowledgmentHead}
}{}
% Start apendix with a appendix page
\appto\appendix{\appendixpage}
% ********************************************************************
% Flots and capiton
% ********************************************************************
% New boxfloat speled boks
\newlistof{listoffboxes}{lob}{\listboxname}
\newfloat[chapter]{boxx}{lob}{\boxname}
\newlistentry{boxx}{lob}{0}
\newenvironment{boks}%
  {\begin{boxx}\begin{framed}}
  {\end{framed}\end{boxx}}
%  Center figures and tables
\setfloatadjustment{figure}{\centering}
\setfloatadjustment{table}{\centering}
\if@chapfig%
  \relax
\else
  \counterwithout{figure}{chapter}
  \counterwithout{table}{chapter}
  \counterwithout{boxx}{chapter}
  \renewcommand\@memfront@floats{}
  \renewcommand\@memmain@floats{}
  \renewcommand\@memback@floats{}
\fi

% Tabular with math numbers
\BeforeBeginEnvironment{tabular}{\liningnums}
\BeforeBeginEnvironment{tabular*}{\liningnums}
% Captions 
\captionnamefont{\scshape\lsstyle}
% Captionname have to be set in lower case
% It have to be done after begin document else 
% bable change it
% ********************************************************************
% TOC and friends
% ********************************************************************
\renewcommand{\tocheadstart}{%
  \parindent\z@
  \parskip\z@
  \clearforchapter%
}
\renewcommand{\lofheadstart}{%
  \parindent\z@
  \parskip\z@
  \clearpage%
}
\renewcommand{\lotheadstart}{%
  \parindent\z@
  \parskip\z@
  \clearpage%
}
\renewcommand{\lobheadstart}{%
  \parindent\z@
  \parskip\z@
  \clearpage%
}
% Small all caps for book part and chpater. 
% Tolowercase have to be preproced before add contentsline
\renewcommand{\cftchapterfont}[1]{\spacedsmallcaps{#1}}
\renewcommand{\cftpartfont}[1]{\spacedsmallcaps{#1}}
\renewcommand{\cftbookfont}[1]{\spacedsmallcaps{#1}}
% TOC with numbers after heading. Number space all caps
\def\tocspace{\hspace{.4em}} 
\renewcommand{\cftchapterleader}{\tocspace}
\renewcommand{\cftchapterafterpnum}{\cftparfillskip}
\renewcommand{\cftchapterpagefont}{\scshape\MakeTextLowercase}
\renewcommand{\cftsectionleader}{\tocspace}
\renewcommand{\cftsectionpresnum}{\scshape\MakeTextLowercase}
\renewcommand{\cftsectionafterpnum}{\cftparfillskip}
\renewcommand{\cftsectionpagefont}{\scshape\MakeTextLowercase}
\renewcommand{\cftsubsectionleader}{\tocspace}
\renewcommand{\cftsubsectionpresnum}{\scshape\MakeTextLowercase}
\renewcommand{\cftsubsectionafterpnum}{\cftparfillskip}
\renewcommand{\cftsubsubsectionleader}{\tocspace}
\renewcommand{\cftsubsubsectionpresnum}{\scshape\MakeTextLowercase}
\renewcommand{\cftsubsubsectionafterpnum}{\cftparfillskip}
\renewcommand{\cftparagraphleader}{\tocspace}
\renewcommand{\cftparagraphpresnum}{\scshape\MakeTextLowercase}
\renewcommand{\cftparagraphafterpnum}{\cftparfillskip}
\renewcommand{\cftsubparagraphleader}{\tocspace}
\renewcommand{\cftsubparagraphpresnum}{\scshape\MakeTextLowercase}
\renewcommand{\cftsubparagraphafterpnum}{\cftparfillskip}
\renewcommand{\cftfigureleader}{\tocspace}
\renewcommand{\cftfigurepresnum}{\scshape\MakeTextLowercase}
\renewcommand{\cftfigureafterpnum}{\cftparfillskip}
\renewcommand{\cfttableleader}{\tocspace}
\renewcommand{\cfttablepresnum}{\scshape\MakeTextLowercase}
\renewcommand{\cfttableafterpnum}{\cftparfillskip}
\renewcommand{\cftboxxleader}{\tocspace}
\renewcommand{\cftboxxpresnum}{\scshape\MakeTextLowercase}
\renewcommand{\cftboxxafterpnum}{\cftparfillskip}
\if@chapfig%
  \setlength{\cftfigurenumwidth}{\cftsectionnumwidth}
  \setlength{\cfttablenumwidth}{\cftsectionnumwidth}
  \setlength{\cftboxxnumwidth}{\cftsectionnumwidth}
\else
  \setlength{\cftfigurenumwidth}{\cftchapternumwidth}
  \setlength{\cfttablenumwidth}{\cftchapternumwidth}
  \setlength{\cftboxxnumwidth}{\cftchapternumwidth}
\fi

% This hack have to be after loading of hyperref
\let\@tmp\addcontentsline
\renewcommand{\addcontentsline}[3]{
\forcsvlist{\listadd\@list}{book, part, chapter, appendix}
  \ifinlist{#2}{\@list}%
    {\@tmp{#1}{#2}{\texorpdfstring{\MakeTextLowercase{#3}}{#3}}}
    {\@tmp{#1}{#2}{#3}}
}  
% ********************************************************************
% Pagestyle
% ********************************************************************
% Bringhurst page style
\newlength{\bringi}
\newlength{\bringii}
\newlength{\bringiii}
\newlength{\bringiv}
\setlength{\bringi}{\headsep}
\addtolength{\bringi}{\topskip}
\addtolength{\bringi}{7.3\onelineskip}
\setlength{\bringii}{\marginparsep}
\addtolength{\bringii}{\marginparwidth}
\setlength{\bringiii}{\textwidth}
\addtolength{\bringiii}{\marginparsep}
\setlength{\bringiv}{7.3\onelineskip}
\makepagestyle{bringhurst}
\makeevenfoot{bringhurst}{\thepage}{}{}
\makeoddfoot{bringhurst}{}{}{\thepage}
\newcommand{\bringpicr}[1]{%
  \setlength{\unitlength}{1pt}
  \begin{picture}(0,0)
   \put(\strip@pt\marginparsep, -\strip@pt\bringi){%
    \begin{minipage}[t]{\marginparwidth}
      \raggedright\itshape #1
    \end{minipage}
    }
  \end{picture}
}      
\newcommand{\bringpicl}[1]{%
  \setlength{\unitlength}{1pt}
  \begin{picture}(0,0)
    \put(-\strip@pt\bringii, -\strip@pt\bringi){%
      \begin{minipage}[t]{\marginparwidth}
        \raggedleft\itshape #1
      \end{minipage}
    }
  \end{picture}
}
\makepsmarks{bringhurst}{%
  \nouppercaseheads
  \def\chaptermark##1{\markboth{##1}{##1}}
  \def\sectionmark##1{\markright{##1}}
}    
\makeevenhead{bringhurst}{\bringpicl{\leftmark}}{}{}
\makeoddhead{bringhurst}{}{}{\bringpicr{\rightmark}}
% note chapter page style
\makepagestyle{note}
\makeevenfoot{note}{\thepage}{}{}
\makeoddfoot{note}{}{%
  \ifnum\value{page} = 1 \thepage\fi}{%
  \ifnum\value{page} = 1 \relax\else\thepage\fi}
\makepsmarks{note}{%
  \nouppercaseheads
  \def\chaptermark##1{\markboth{##1}{##1}}
  \def\sectionmark##1{\markright{##1}}
}    
\makeevenhead{note}{\bringpicl{\leftmark}}{}{}
\makeoddhead{note}{}{}{%
  \ifnum\value{page} = 1 
    \relax
  \else
    \bringpicr{\rightmark}
  \fi}
%
% ********************************************************************
% Chapterstyles
% ********************************************************************
% Chapterstyle modifyed bringhust from memoir
\makechapterstyle{Bringhurst}{%
  \chapterstyle{default}
  \renewcommand*{\chapterheadstart}{}
  \renewcommand*{\printchaptername}{}
  \renewcommand*{\chapternamenum}{}
  \renewcommand*{\printchapternum}{
    \setlength{\unitlength}{1pt}
    \begin{picture}(0,0)
      \put(\strip@pt\bringiii,-\strip@pt\bringiv){
      \color{halfgray}\chapterNumber\thechapter
      }
    \end{picture}%
  }
  \renewcommand*{\afterchapternum}{}
  \renewcommand*{\printchaptertitle}[1]{%
    \memRTLraggedright\spacedallcaps{##1}}
  \renewcommand*{\afterchaptertitle}{%
  \vskip\onelineskip \hrule\vskip\onelineskip}}
 % Bringhurst chapter style as in memoir, but with number
 \makechapterstyle{note}{%
   \chapterstyle{default}
  \renewcommand*{\chapterheadstart}{}
  \renewcommand*{\printchaptername}{}
  \renewcommand*{\chapternamenum}{}
  \renewcommand*{\printchapternum}{\spacedallcaps\thechapter}
  \renewcommand*{\afterchapternum}{.\hspace{2ex}}
  \renewcommand*{\printchaptertitle}[1]{%
    \memRTLraggedright\spacedallcaps{##1}}
  \renewcommand*{\afterchaptertitle}{%
  \par\nobreak\vskip\onelineskip \hrule\par\nobreak\vskip\onelineskip
  }
  \renewcommand\clearforchapter{\vspace{4\onelineskip}}
}
% ********************************************************************
% Headstyle
% ********************************************************************
\makeheadstyles{Bringhurst}{%
  \chapterstyle{Bringhurst}
  \setbeforesecskip{-1\onelineskip
                    \@plus -0.5\onelineskip \@minus -.5\onelineskip}%
  \setaftersecskip{1\onelineskip \@plus 0.1\onelineskip}%
  \setsecheadstyle{\memRTLraggedright\spacedlowsmallcaps}%
  \setbeforesubsecskip{-1.0\onelineskip
                       \@plus -0.25\onelineskip \@minus -0.25\onelineskip}%
  \setaftersubsecskip{1.0\onelineskip \@plus 0.1\onelineskip}%
  \setsubsecheadstyle{\sethangfrom{\noindent ####1}\normalfont\itshape\memRTLraggedright}%
  \setbeforesubsubsecskip{1.0\onelineskip
                          \@plus 0.5\onelineskip \@minus 0.2\onelineskip}%
  \setaftersubsubsecskip{-1em}%
  \setsubsubsecheadstyle{\normalfont\normalsize\spacedlowsmallcaps}%
  \setbeforeparaskip{1.0\onelineskip
                     \@plus 0.5\onelineskip \@minus 0.2\onelineskip}%
  \setafterparaskip{-1em}%
  \setparaheadstyle{\normalfont\normalsize\itshape\addperiod}%
  \setsubparaindent{\parindent}%
  \setbeforesubparaskip{1.0\onelineskip
                        \@plus 0.5\onelineskip \@minus 0.2\onelineskip}%
  \setaftersubparaskip{-1em}%
  \setsubparaheadstyle{\normalfont\normalsize\itshape\addperiod}}
%
% ********************************************************************
% Layout
% ********************************************************************
\pagestyle{bringhurst}
\headstyles{Bringhurst}
\if@note\chapterstyle{note}\fi
\maxsecnumdepth{subsection}
\settocdepth{section}
% ********************************************************************
% Hyperref setup
% ********************************************************************
\hypersetup{%
    colorlinks=true, pdfstartpage=3, pdfstartview=FitV,%, linktocpage=true
    breaklinks=true, pdfpagemode=UseNone, pageanchor=true, pdfpagemode=UseOutlines,%
    plainpages=false, bookmarksnumbered, bookmarksopen=true, bookmarksopenlevel=1,%
    hypertexnames=true, pdfhighlight=/O, pdfdisplaydoctitle=true,
    urlcolor=webbrown, linkcolor=RoyalBlue, citecolor=webgreen, 
}
\newcommand{\pdfsetup}{
  \ifdefined\AuthorList
    \let\do=\@doList@iii
    \def\ermAuthors{\dolistloop{\AuthorList}}
  \else
    \def\ermAuthors{}
  \fi
  \hypersetup{%
    pdftitle={\ermTitle},%
    pdfauthor={\textcopyright\ermAuthors},%
    pdfsubject={\ermSubject, \ermStudy, \ermUniversity},%
    pdfkeywords={},%
    pdfcreator={pdfLaTeX},%
    pdfproducer={LaTeX with hyperref and ERMreport}%
}}
% ********************************************************************
% Standard text input
% ********************************************************************
\newcommand{\resumeHead}{Resumé}
\newcommand{\abstractHead}{Abstract}
\newcommand{\trustHead}{Declaration}
\newcommand{\acknowledgmentHead}{Acknowledgment}
\newcommand{\boxname}{box}
\newcommand{\listboxname}{List of boxes}
%
\if@danish
  \setUniversity{Syddansk Universitet, Esbjerg}
  \setStudy{Milj\o{} og Resource Management}
  \setTrustText{Det erkl\ae{}res herved p\aa{} tro og love, at undertegnede egenh\ae{}ndigt og selvst\ae{}ndigt har udformet denne rapport. Alle citater i teksten er markeret som s\aa{}danne, og rapporten eller v\ae{}sentlige dele af den har ikke tidligere v\ae{}ret fremlagt i anden bed\o{}mmelsessammenh\ae{}ng.}
  \setSupervisorText{Vejleder:}{Vejledere:}
  \setTitle{Dette ufattelige store projekt som jeg har arbejdet p\aa{} b\aa{}de dag og nat for s\aa{} l\ae{}nge og som endelig er overst\aa{}et}
  \setDate{}
  \setPlace{Esbjerg}
  \setSubject{}
  \renewcommand{\boxname}{boks}
  \renewcommand*{\contentsname}{Indhold}
  \renewcommand*{\listfigurename}{Figure}
  \renewcommand*{\listtablename}{Tabeler}
  \renewcommand*{\listboxname}{Bokse}
  \renewcommand*{\bookname}{Bog}
  \renewcommand*{\partname}{Part}
  \renewcommand*{\chaptername}{Kapitel}
  \renewcommand*{\appendixname}{Bilag}
  \renewcommand*{\appendixtocname}{Bilag}
  \renewcommand*{\appendixpagename}{Bilag}
  \renewcommand*{\bibname}{Litteratur}
  \renewcommand*{\indexname}{Indeks}
  \renewcommand*{\glossaryname}{Forkortelser}
  \renewcommand*{\figurerefname}{Figur}
  \renewcommand*{\tablerefname}{Tabel}
  \renewcommand*{\pagename}{side}
  \renewcommand*{\pagerefname}{side}
  \renewcommand*{\bookrefname}{Bog~}
  \renewcommand*{\partrefname}{Part~}
  \renewcommand*{\chapterrefname}{Kapitel~}
  \renewcommand*{\trustHead}{Tro og love}
  \renewcommand*{\acknowledgmentHead}{Anerkendelse}
  \renewcommand*{\appendixrefname}{Bilag~}
  \AfterEndPreamble{% set after bable to lower small case
    \renewcommand*{\figurename}{figur}
    \renewcommand*{\tablename}{\MakeTextLowercase{tabel}}
  }
\else
  \setUniversity{University of Southern Denmark, Esbjerg}
  \setStudy{Environmental and Resource Management}
  \setTrustText{I hereby solemnly declare that I have personally and independently prepared this paper. All quotations in the text have been marked as such, and the paper or considerable parts of it have not previously been subject to any examination or assessment.}
  \setSupervisorText{Supervisor:}{Supervisors:}
  \setTitle{An Incredible Piece of Work over Which I have Struggled
   Day and Night for Far Too Long and now It is Over}
  \setDate{}
  \setPlace{Esbjerg}
  \setSubject{}
  \AfterEndPreamble{% set after bable to lower small case
    \renewcommand*{\figurename}{figure}
    \renewcommand*{\tablename}{\MakeTextLowercase{table}}
  }
\fi
% Bibliography
\@ifpackageloaded{biblatex}{
  % Headings for bibliography
  \DefineBibliographyStrings{danish}{%
    bibliography = {Lit\-te\-ra\-tur},}
  \DefineBibliographyStrings{danish}{%
    andothers = {et\addabbrvspace al\adddot}
  }
  \DefineBibliographyStrings{english}{%
    bibliography = {References},}
  % To let biblatex divide urls
  \setcounter{biburlnumpenalty}{100}
  \setcounter{biburlucpenalty}{100}
  \setcounter{biburllcpenalty}{100}
}
%% For Refstyle
\AtEndPreamble{%
  \@ifpackageloaded{refstyle}{
    % No \S in sections
    \newref{sec}{%
      name      = \RSsectxt,
      names     = \RSsecstxt,
      Name      = \RSSectxt,
      Names     = \RSSecstxt,
      refcmd    = {\ref{#1}},
      rngtxt    = \RSrngtxt,
      lsttwotxt = \RSlsttwotxt,
      lsttxt    = \RSlsttxt}
    %%-- TEMPLATE FOR BOX -----------------------
    \newref{box}{%
      name      = \RSboxtxt,
      names     = \RSboxstxt,
      Name      = \RSBoxtxt,
      Names     = \RSBoxstxt,
      rngtxt    = \RSrngtxt,
      lsttwotxt = \RSlsttwotxt,
      lsttxt    = \RSlsttxt}
    \RSaddto{\RSdanish}{%
      \def\RSboxtxt{boks~}%
      \def\RSboxstxt{boks~}%
      \def\RSBoxtxt{Boks~}%
    \def\RSBoxstxt{Boks~}%
    }
    \RSaddto{\RSenglish}{%
      \def\RSboxtxt{box~}%
      \def\RSboxstxt{boxes~}%
      \def\RSBoxtxt{Box~}%
    \def\RSBoxstxt{Boxes~}%
    }
  }{}
}
%
\endinput
%% End of file `ermreport.cls'.

