%%%% file ermreport.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ermreport}[2014/08/01 v0.0 erm report]
\LoadClassWithOptions{memoir}%[⟨date⟩]
%% Package
%\RequirePackage{ifthen}%[1994/06/01]
\RequirePackage{etoolbox}
\RequirePackage{graphicx}
%%%

%%%%%%%%
\RequirePackage{microtype} 
\microtypesetup{expansion=false}%
\DeclareRobustCommand{\spacedallcaps}[1]{\textls[160]{\MakeTextUppercase{#1}}}%
\DeclareRobustCommand{\spacedlowsmallcaps}[1]{\textls[80]{\scshape\MakeTextLowercase{#1}}}
%%%%%%%%

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

\newcommand{\setTrustpage}[1]{\def\ermTrustpage{#1}}
\newcommand{\setCover}[1]{\def\ermCover{#1}}

\newcommand{\setCoverLogo}[1]{\def\coverLogo{#1}}
\setCoverLogo{%
  \includegraphics[width=0.44\textwidth]{sdu_segl}
  \hfill
  \includegraphics[width=0.47\textwidth]{aau_segl}
}
\newcommand{\setTitleLogo}[1]{\def\titleLogo{#1}}
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
  \let\do=\@doList
  \large\dolistloop{\AuthorList}
  \vfill
  \coverLogo
  \thispagestyle{empty}
  \end{center}
  \end{adjustwidth}
  \end{adjustwidth*}}
%
% Title page
\newcommand{\titlepage}{
  \frontmatter
  \thispagestyle{empty}
  \begin{center}
  \large\textsc\ermSubject\par 
  \large\textsc\ermStudy\par
  \large\textsc\ermUniversity\par
  \vfill
  \Large\textsc\ermTitle\par
  \vspace{2em}
  \normalsize
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
  \vfill
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
  \titleLogo
  \end{center}
\cleartorecto
}
% Declaration page
\newcommand{\trustpage}{%
  \vspace*{\fill}
  \begin{quote}
  \ermTrustText\par
  \vspace{2em}
  \ermPlace, \ermDate\par
  \vspace{2cm}
  \end{quote}
  \begin{center}
  \begin{minipage}{0.8\textwidth}
    \let\do=\@doList@ii
    \dolistloop{\AuthorList}
  \end{minipage}
  \end{center}
  \vspace*{\fill}
}

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

% box enverioment
 \newcommand{\boxname}{\bfseries Box}
 \newcommand{\listboxname}{List of boxes}
 \newlistof{listofboxs}{lob}{\listboxname}
 \newfloat{boxx}{lob}{\boxname}
 \newfixedcaption{\fboxcaption}{\fb boks}
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

\pagestyle{erm}

\endinput
%%
%% End of file `ermreport.cls'.

