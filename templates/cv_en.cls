\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{templates/cv_en}[2019/03/28 Custom CV class]
\LoadClass{article}
\pagestyle{empty}

\RequirePackage[utf8]{inputenc}
\RequirePackage[left=1.5cm,top=0.5cm,right=1.5cm,bottom=0.2cm,nohead,nofoot]{geometry}
\RequirePackage{enumitem}
\RequirePackage{eurosym}
\RequirePackage{fontawesome}
\RequirePackage{hyperref}
\RequirePackage{ragged2e}
\RequirePackage{titlesec}


\titleformat{\section}{\Large\scshape\raggedright}{}{0em}{}[\titlerule]
\titleformat{\subsection}{\large\raggedright}{}{0em}{}


\newcommand{\edu}[3]{%
  \subsection[#1]{{\bfseries #1}, #2 \hfill #3}%
}
\newcommand{\workxp}[4]{%
  \subsection[#1]{{\bfseries #1}, #2 - #3  \hfill #4}%
}
\newcommand{\other}[2]{%
  \subsection[#1]{{\bfseries #1}: \normalsize #2}%
}


\newcommand{\name}[1]{%
  \centerline{\Huge{#1}}
}

\newcommand{\boxedlink}[2]{%
  \href{#1}{#2}%
}

\newcommand{\contact}[3]{%
  \vspace{1em}
  \centerline{%
    \faPhone{} #1
    {\large\textperiodcentered}
    \faEnvelope{}~\boxedlink{mailto:#2}{#2}
    {\large\textperiodcentered}
    \faHome{} #3
    }
}

\newcommand{\socials}[2]{%
  \vspace{1em}
  \centerline{%
    \faLinkedinSquare{}~\boxedlink{#1}{LinkedIn}
    {\large\textperiodcentered}
    \faGithub{}~\boxedlink{#2}{GitHub}
    }
}

\newcommand{\subject}[1]{%
\vspace{1em}
  \centerline{#1}
}


\newcommand{\oneitem}[1]{%
  \begin{itemize}[leftmargin=*,label={}]
    \itemsep0em
    \item #1
  \end{itemize}%
}

\newcommand{\twoitems}[2]{%
  \begin{itemize}[leftmargin=*,label={}]
    \itemsep0em
    \item #1
    \item #2
  \end{itemize}%
}

\newcommand{\threeitems}[3]{%
  \begin{itemize}[leftmargin=*,label={}]
    \itemsep0em
    \item #1
    \item #2
    \item #3
  \end{itemize}%
}

\newcommand{\fouritems}[4]{%
  \begin{itemize}[leftmargin=*,label={}]
    \itemsep0em
    \item #1
    \item #2
    \item #3
    \item #4
  \end{itemize}%
}

\newcommand{\fiveitems}[5]{%
  \begin{itemize}[leftmargin=*,label={}]
    \itemsep0em
    \item #1
    \item #2
    \item #3
    \item #4
    \item #5
  \end{itemize}%
}

\newcommand{\sixitems}[6]{%
  \begin{itemize}[leftmargin=*,label={}]
    \itemsep0em
    \item #1
    \item #2
    \item #3
    \item #4
    \item #5
    \item #6
  \end{itemize}%
}
