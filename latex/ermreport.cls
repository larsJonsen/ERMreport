%%%% file ermreport.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ermreport}[2014/08/01 v0.0 erm report]
\LoadClassWithOptions{memoir}%[⟨date⟩]
%% Package
\RequirePackage{ifthen}%[1994/06/01]
\RequirePackage{etoolbox}
\RequirePackage{graphicx}

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
% Author
\newlength{\len@Aut}
\newlength{\len@Sup}
\setlength{\len@Aut}{0pt}
\setlength{\len@Sup}{0pt}
\newlength{\len@B}
\newlength{\len@C}
\newcommand{\setAuthor}[2][]{%
  \settowidth{\len@B}{#2}%
  \setlength{\len@Aut}{\maxLength{\len@Aut}{\len@B}}
  \settowidth{\len@B}{#2}%
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

% Trust Text
\newcommand{\setTrustText}[1]{\def\ermTrustText{#1}}
% Cover
\newcommand{\coverpage}{%
  \thispagestyle{empty}
  \begin{center}
  \LARGE\ermTitle\par
  \vspace{4cm}
  \let\do=\@doList
  \large\dolistloop{\AuthorList}
  \end{center}
  \cleartorecto
}
% Title page
\newcommand{\titlepage}{
  \frontmatter
  \thispagestyle{empty}
  \begin{center}
  \Large\ermTitle\par
  \vspace{2em}
  \normalsize{
    \begin{minipage}{\len@Aut}
    \let\do=\@doList
    \dolistloop{\AuthorList} 
    \end{minipage}}%
  \hspace{2ex}%
  \begin{minipage}{\len@Sup}
  \let\do=\@doList
  \dolistloop{\SupAuthorList} 
  \end{minipage}\par
  \end{center}
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
  \end{minipage}%
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
%  \renewcommand*{\do}[1]{#1 \\}
%  \dolistloop{\AuthorList} 
}
\newcommand{\ermChapter}[1]{%
  \ifanappendix
    \relax
  \else
    \ifnumequal{\value{chapter}}{0}{\mainmatter}{}
  \fi
  \chapter{#1}%
}
%boks


