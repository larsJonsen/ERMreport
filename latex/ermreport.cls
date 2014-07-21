%%%% file ermreport.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ermreport}[2014/08/01 v0.0 erm report]
%
\newif\if@danish
  \@danishfalse
\DeclareOption{danish}{\@danishtrue}
\ProcessOptions\relax
\LoadClassWithOptions{memoir}%[⟨date⟩]
%% Package
%\RequirePackage{ifthen}%[1994/06/01]
\RequirePackage{etoolbox}
\RequirePackage{graphicx}
%%%
\PassOptionsToPackage{osf,sc}{mathpazo}%
\RequirePackage{mathpazo} % Palatino with real small caps and old style figures
\linespread{1.05} % a bit more for Palatino
%%%%%%%%
\RequirePackage{microtype} 
\microtypesetup{expansion=false}%
\DeclareRobustCommand{\spacedallcaps}[1]{\textls[160]{\MakeTextUppercase{#1}}}%
\DeclareRobustCommand{\spacedlowsmallcaps}[1]{\textls[80]{\scshape\MakeTextLowercase{#1}}}
% for TOC and friends
\renewcommand{\cftchapterfont}[1]{\textls[80]{\scshape{#1}}}
\renewcommand{\cftpartfont}[1]{\textls[80]{\scshape{#1}}}
\renewcommand{\cftbookfont}[1]{\textls[80]{\scshape{#1}}}
\let\@tmp\addcontentsline
\renewcommand{\addcontentsline}[3]{
\forcsvlist{\listadd\@list}{book, part, chapter, appendix}
  \ifinlist{#2}{\@list}%
    {\@tmp{#1}{#2}{\texorpdfstring{\MakeTextLowercase{#3}}{#3}}}
    {\@tmp{#1}{#2}{#3}}
}
%%%%%%%%
%\newfont{\chapterNumber}{pplr9d scaled 7000}
\newfont{\chapterNumber}{eurb10 scaled 7000}
%%%%%%%%
\PassOptionsToPackage{dvipsnames}{xcolor}
  \RequirePackage{xcolor} % [dvipsnames] 
\definecolor{halfgray}{gray}{0.55} % chapter numbers 
\definecolor{webgreen}{rgb}{0,.5,0}
\definecolor{webbrown}{rgb}{.6,0,0}
%\definecolor{Maroon}{cmyk}{0, 0.87, 0.68, 0.32}
%\definecolor{RoyalBlue}{cmyk}{1, 0.50, 0, 0}
%%%
\RequirePackage{hyperref} 


%%%
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
% Title
\newcommand{\setTitle}[1]{\def\ermTitle{#1}}
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
  \settowidth{\len@B}{#2}%
  \setlength{\len@Aut}{\maxLength{\len@Aut}{\len@B}}
  \settowidth{\len@B}{#1}%
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
  \includegraphics[width=0.44\textwidth]{sdu_segl}
  \hfill
  \includegraphics[width=0.47\textwidth]{aau_segl}
}
\newcommand{\setTitleLogo}[1]{\def\titleLogo{#1}}
%
\setTitleLogo{%
  \includegraphics[width=0.47\textwidth]{sdu_logo}
  \hfill
  \includegraphics[width=0.44\textwidth]{aau_logo}
}
% Trust Text
\newcommand{\setTrustText}[1]{\def\ermTrustText{#1}}
%
% Cover
\newcommand{\coverpage}{%
  \calccentering{\unitlength}
  \begin{adjustwidth*}{\unitlength}{-\unitlength}
  \begin{adjustwidth}{-1.5cm}{-1.5cm} 
  \begin{center}
  \vspace*{\fill}
  \LARGE\spacedallcaps\ermTitle\par
  \vspace{2cm}
  \ifdefined\AuthorList
    \let\do=\@doList
    \large\dolistloop{\AuthorList}
  \fi  
  \vfill
  \coverLogo
  \thispagestyle{empty}
  \end{center}
  \end{adjustwidth}
  \end{adjustwidth*}}
%
% Title page
\newcommand{\titlepage}{
  \clearforchapter
  \thispagestyle{empty}
  \begin{center}
  \large\textsc\ermSubject\par 
  \large\textsc\ermStudy\par
  \large\textsc\ermUniversity\par
  \vfill
  \Large\textsc\ermTitle\par
  \vspace{2em}
  \normalsize
  \ifdefined\AuthorList
    \begin{minipage}[t]{\len@Aut}%
      \let\do=\@doList%
      \dolistloop{\AuthorList}%
    \end{minipage}%
    \hspace{2ex}%
    \begin{minipage}[t]{\len@Sup}%
      \let\do=\@doList
      \raggedleft
      \dolistloop{\SupAuthorList} 
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
% Declaration page
\newcommand{\trustpage}{%
  \chapter{\@trustHead}
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
}
% Gluing evrything togheteher, for LYX
\newcommand{\ermFront}{%
  \coverpage
  \frontmatter
  \titlepage
  \trustpage
}
% Abstract
% Make it start on new page
\renewcommand{\setup@bstract}{%
  \clearforchapter
  \abs@leftindent=\absleftindent
  \pagestyle{resume}
  \if@twocolumn
    \if@bsonecol
    \else
      \abs@leftindent=\z@
      \absrightindent=\z@
      \renewcommand*{\abstractnamefont}{\abscolnamefont}
      \renewcommand*{\abstracttextfont}{\abscoltextfont}
      \renewcommand*{\absnamepos}{flushleft}
      \setlength{\abstitleskip}{-2ex}
    \fi
  \fi}
% Table fo content and friends
\renewcommand{\tocheadstart}{%
  \parindent\z@
  \parskip\z@
  \clearpage%
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

\newcommand{\boxname}{Box}
\newcommand{\listboxname}{List of boxes}
\newlistof{listofboxs}{lob}{\listboxname}
\newfloat{boxx}{lob}{\boxname}
%\newfixedcaption{\fboxcaption}{boks}
\newlistentry{boks}{lob}{0}

\newenvironment{boks}%
  {\begin{boxx}\begin{framed}}
  {\end{framed}\end{boxx}}

% Pagestyle

\makepagestyle{erm}
\makeevenfoot{erm}{\thepage}{}{}
\makeoddfoot{erm}{}{}{\thepage}
\makeheadrule{erm}{\textwidth}{\normalrulethickness}
\newcommand{\@ermmarks}{%
  \let\@mkboth\markboth
  \def\chaptermark##1{%
    \markboth{%
      \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter
          \thechapter. \ %
        \fi
      \fi
      ##1}{}}
  \def\sectionmark##1{\markright{%
    \ifnum \c@secnumdepth>\z@
      \thesection. \ %
    \fi
    ##1}}
  \def\tocmark{\markboth{\contentsname}{Indhold}}
  \def\lofmark{\markboth{\listfigurename}{}}
  \def\lotmark{\markboth{\listtablename}{}}
  \def\bibmark{\markboth{\bibname}{}}
  \def\indexmark{\markboth{\indexname}{}}
}
\makepsmarks{erm}{\@ermmarks}
\makeevenhead{erm}{\slshape\leftmark}{}{}
\makeoddhead{erm}{}{}{\slshape\rightmark}


 %% Bringhurst page style
\newlength{\bringi}
\newlength{\bringii}
\newlength{\bringiii}
\newlength{\bringiv}
\makepagestyle{bringhurst}
\makeevenfoot{bringhurst}{\thepage}{}{}
\makeoddfoot{bringhurst}{}{}{\thepage}
\setlength{\bringi}{\headsep}
\addtolength{\bringi}{\topskip}
\addtolength{\bringi}{7.3\onelineskip}
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
       
\setlength{\bringii}{\marginparsep}
\addtolength{\bringii}{\marginparwidth}
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
  \def\chaptermark##1{\markboth{##1}{##1}}
  \def\sectionmark##1{\markright{##1}}
}    
\makeevenhead{bringhurst}{\bringpicl{\rightmark}}{}{}
\makeoddhead{bringhurst}{}{}{\bringpicr{\leftmark}}
\pagestyle{bringhurst}

\setlength{\bringiii}{\textwidth}
\addtolength{\bringiii}{\marginparsep}
\setlength{\bringiv}{7.3\onelineskip}
%%%%%%%%%%
%% Headstyle modifyed bringhust from memoir
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
      %\resizebox{!}{\beforechapskip}{\color{halfgray}\chapnumfont \thechapter}
      }
    \end{picture}%
  }
  \renewcommand*{\afterchapternum}{}
  \renewcommand*{\printchaptertitle}[1]{%
    \memRTLraggedright\spacedallcaps{##1}}
  \renewcommand*{\afterchaptertitle}{%
  \vskip\onelineskip \hrule\vskip\onelineskip}}

\afterchaptertitle

\makeheadstyles{Bringhurst}{%
\chapterstyle{Bringhurst}
  \setbeforesecskip{-1\onelineskip
                    \@plus -0.5\onelineskip \@minus -.5\onelineskip}%
  \setaftersecskip{1\onelineskip \@plus 0.1\onelineskip}%
%%%  \setsecheadstyle{\normalfont\raggedright\scshape\MakeLowercase}%
  \setsecheadstyle{\memRTLraggedright\spacedlowsmallcaps}%
  \setbeforesubsecskip{-1.0\onelineskip
                       \@plus -0.25\onelineskip \@minus -0.25\onelineskip}%
  \setaftersubsecskip{1.0\onelineskip \@plus 0.1\onelineskip}%
%%%  \setsubsecheadstyle{\sethangfrom{\noindent ####1}\normalfont\itshape\raggedright}%
  \setsubsecheadstyle{\sethangfrom{\noindent ####1}\normalfont\itshape\memRTLraggedright}%
  \setbeforesubsubsecskip{1.0\onelineskip
                          \@plus 0.5\onelineskip \@minus 0.2\onelineskip}%
  \setaftersubsubsecskip{-1em}%
  \setsubsubsecheadstyle{\normalfont\normalsize\scshape\MakeTextLowercase}%
  \setbeforeparaskip{1.0\onelineskip
                     \@plus 0.5\onelineskip \@minus 0.2\onelineskip}%
  \setafterparaskip{-1em}%
  \setparaheadstyle{\normalfont\normalsize\itshape\addperiod}%
  \setsubparaindent{\parindent}%
  \setbeforesubparaskip{1.0\onelineskip
                        \@plus 0.5\onelineskip \@minus 0.2\onelineskip}%
  \setaftersubparaskip{-1em}%
  \setsubparaheadstyle{\normalfont\normalsize\itshape\addperiod}}

\headstyles{Bringhurst}


  

%%%%%%%% 
\renewenvironment{abstract}{%
\chapter*{\@abstractHead}
}{}

\newenvironment{resume}{%
\chapter*{\@resumeHead}
}{}

\newcommand{\@dedicationHead}{Dedication}
\newcommand{\@resumeHead}{Resume}
\newcommand{\@abstractHead}{Abstract}
\newcommand{\@trustHead}{Declaration}

%%%%%% Standard text input

\if@danish
  \setUniversity{Syddansk Universitet, Esbjerg}
  \setStudy{Milj\o{} og Resource Management}
  \setTrustText{Det erkl\ae{}res herved p\aa{} tro og love, at undertegnede egenh\ae{}ndigt og selvst\ae{}ndigt har udformet denne rapport. Alle citater i teksten er markeret som s\aa{}danne, og rapporten eller v\ae{}sentlige dele af den har ikke tidligere v\ae{}ret fremlagt i anden bed\o{}mmelsessammenh\ae{}ng.}
  \setSupervisorText{Vejleder:}{Vejledere:}
  \setTitle{Dette ufattelige store projekt som jeg har arbejdet p\aa{} b\aa{}de dag og nat for s\aa{} l\ae{}nge og som endelig er overst\aa{}et}
  \setDate{}
  \setPlace{Esbjerg}
  \setSubject{}
  \renewcommand{\boxname}{Boks}
  %\newcommand*{\abstractname}{Abstract}
  % from memoir
\renewcommand*{\contentsname}{Indhold}
\renewcommand*{\listfigurename}{Figure}
\renewcommand*{\listtablename}{Tabeler}
\renewcommand*{\bookname}{Bog}
\renewcommand*{\partname}{Part}
\renewcommand*{\chaptername}{Kapitel}
\renewcommand*{\appendixname}{Bilag}
\renewcommand*{\appendixtocname}{Bilag}
\renewcommand*{\appendixpagename}{Bilag}
\renewcommand*{\bibname}{Litteratur}
\renewcommand*{\indexname}{Indeks}
\renewcommand*{\glossaryname}{Forkortelser}
\renewcommand*{\figurename}{Figur}
\renewcommand*{\tablename}{Tabel}
\renewcommand*{\figurerefname}{Figur}
\renewcommand*{\tablerefname}{Tabel}
\renewcommand*{\pagename}{side}
\renewcommand*{\pagerefname}{side}
\renewcommand*{\bookrefname}{Bog~}
\renewcommand*{\partrefname}{Part~}
\renewcommand*{\chapterrefname}{Kapitel~}
\renewcommand*{\sectionrefname}{\S}
\renewcommand*{\appendixrefname}{Bilag~}
\else
  \setUniversity{University of Southern Denmark, Esbjerg}
  \setStudy{Environmental and Resource Management}
  \setTrustText{Det erkl\ae{}res herved p\aa{} tro og love, at undertegnede egenh\ae{}ndigt og selvst\ae{}ndigt har udformet denne rapport. Alle citater i teksten er markeret som s\aa{}danne, og rapporten eller v\ae{}sentlige dele af den har ikke tidligere v\ae{}ret fremlagt i anden bed\o{}mmelsessammenh\ae{}ng.}
  \setSupervisorText{Vejleder:}{Vejledere:}
  \setTitle{An Incredible Piece of Work over Which I have Struggled
   Day and Night for Far Too Long and now It is Over}
  \setDate{}
  \setPlace{Esbjerg}
  \setSubject{}
\fi

\appto\appendix{\appendixpage}


%%  Center figures and tables

 \renewcommand\@memmain@floats{%
   \counterwithout{figure}{chapter} 
   \counterwithout{table}{chapter}}   

\setfloatadjustment{figure}{\centering}
\setfloatadjustment{table}{\centering}

 \captionnamefont{}
%%
\endinput
%% End of file `ermreport.cls'.

