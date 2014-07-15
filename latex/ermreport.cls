%%%% file ermreport.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ermreport}[2014/08/01 v0.0 MRM report]
\LoadClassWithOptions{memoir}%[⟨date⟩]
%% Package
\RequirePackage{ifthen}%[1994/06/01]
\RequirePackage{etoolbox}
\RequirePackage{graphicx}

\newcommand{\maxLength}[2]{%
  \ifdimcomp{#1}{>}{#2}{#1}{#2}
}


\newcommand{\setTitle}[1]{\def\mrmTitle{#1}}
\newcommand{\setDate}[1]{\def\mrmDate{#1}}

\newlength{\lengthAut}
\newlength{\lengthSup}
\setlength{\lengthAut}{0pt}
\setlength{\lengthSup}{0pt}
\newlength{\lengthB}
\newcommand{\setAuthor}[2][]{%
  \settowidth{\lengthB}{#2}%
  \setlength{\lengthAut}{\maxLength{\lengthAut}{\lengthB}}
  \settowidth{\lengthB}{#2}%
  \setlength{\lengthSup}{\maxLength{\lengthSup}{\lengthB}}
  \fbox{\makebox[\lengthAut]{#2}}
  \listadd{\AuthorList}{#2}
  \listadd{\SupAuthorList}{#1}
}
\newcommand{\setSupervisor}[1]{%
  \listadd{\SupervisorList}{#1}}
\newcommand{\setTrustpage}[1]{\def\mrmTrustpage{#1}}
\newcommand{\setCover}[1]{\def\mrmCover{#1}}
\newcommand{\mrmTitlepage}{}
%boks


