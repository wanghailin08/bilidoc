\ProvidesClass{bilidoc}[2020/09/10]

\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\DeclareOption*{
  \ClassWarning{bilidoc}{Unknown option ‘\CurrentOption’}
}
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{ctexart}
}
\ProcessOptions\relax
\LoadClass[10pt,UTF8]{ctexart}

\RequirePackage{parallel}% 提供双栏排版支持
\RequirePackage{graphicx}% 图形支持
\RequirePackage{geometry}% 用于页面设置
\RequirePackage{lscape} %页面横置
\RequirePackage{pdflscape} %页面横置
\RequirePackage{bm} %公式加粗
\RequirePackage{amsmath} %公式
\RequirePackage{amsfonts}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{makecell}
\RequirePackage{threeparttable}
\RequirePackage{rotating}
\RequirePackage{longtable}
\RequirePackage[font=normalsize,justification=centerlast]{caption}
\RequirePackage{subfigure}
\RequirePackage[table]{xcolor}
\RequirePackage[authoryear, round]{natbib}
\RequirePackage{pdfpages}
\RequirePackage{iftex}
\RequirePackage{pgffor}
\RequirePackage{texnames}
\RequirePackage{listings}
\RequirePackage{float}
\RequirePackage[
    hyperfootnotes=true,
    colorlinks=true,
    linkcolor=red,
    anchorcolor=blue,
    citecolor=blue,
    urlcolor=red
]{hyperref}
\RequirePackage[doipre={doi:~}]{uri}
\RequirePackage{paracol}
\RequirePackage{xparse}
\RequirePackage{xifthen}
\RequirePackage{etoolbox}
\RequirePackage{verbatim}
\RequirePackage{xkeyval}
\RequirePackage{fancyvrb}
\RequirePackage{indentfirst}

\setcolumnwidth{0.60\textwidth}
\footnotelayout{m}
\globalcounter{figure}
\globalcounter{table}

\renewcommand\tablename{Table}
\renewcommand\figurename{Figure}
\renewcommand\refname{Reference 参考文献}
\newcommand{\tabincell}[2]{\begin{tabular}{@{}#1@{}}#2\end{tabular}} 
\newcommand{\Paragraph}[1]{\vspace{10pt}\noindent\textbf{\large{#1}}\vspace{10pt}}
\newcommand{\HangingIndent}{
  \noindent
  \hangafter=1
  \setlength{\hangindent}{2em}
}
\newcommand{\OptionsShow}[3]{\ttfamily\textcolor[RGB]{34,139,34}{#1}~=~#2\hspace{\fill}#3\normalfont\normalsize}
\newcommand{\ColorCode}[1]{\ttfamily\textcolor[RGB]{34,139,34}{#1}\normalfont}
\newcommand{\Equation}[1]{\end{ParaColumn} #1 \begin{ParaColumn} \switchcolumn}
  \newcommand{\CrossColumnText}[1]{\end{ParaColumn} #1 \begin{ParaColumn} \switchcolumn}

\renewcommand{\figureautorefname}{Fig.}
\newcommand{\subfigureautorefname}{Fig.}
\newcommand{\cnfigureref}[1]{\renewcommand{\figureautorefname}{图}\autoref{#1}~\renewcommand{\figureautorefname}{Fig.}}
\newcommand{\cnsubfigureref}[1]{\renewcommand{\subfigureautorefname}{图}\autoref{#1}~\renewcommand{\subfigureautorefname}{Fig.}}
\newcommand{\cntableref}[1]{\renewcommand{\tableautorefname}{表}\autoref{#1}~\renewcommand{\tableautorefname}{Table}} 
\renewcommand{\equationautorefname}{Eq.}
\newcommand{\cnequationref}[1]{\renewcommand{\equationautorefname}{式}\autoref{#1}~\renewcommand{\equationautorefname}{Eq.}}
\newcommand{\cnappendixref}[1]{\renewcommand{\appendixautorefname}{附录}\autoref{#1}~\renewcommand{\appendixautorefname}{Appendix}}

\newcommand{\cnautoref}[1]{\renewcommand{\figureautorefname}{图}\renewcommand{\subfigureautorefname}{图}\renewcommand{\tableautorefname}{表}\renewcommand{\equationautorefname}{式}\renewcommand{\appendixautorefname}{附录}\autoref{#1}}
\newcommand{\enautoref}[1]{\renewcommand{\figureautorefname}{Fig.}\renewcommand{\subfigureautorefname}{Fig.}\renewcommand{\tableautorefname}{Table}\renewcommand{\equationautorefname}{Eq.}\renewcommand{\appendixautorefname}{Appendix}\autoref{#1}}

\geometry{
  a4paper,%
  left = 1.5cm,%
  right = 1.5cm,%
  top = 2.54cm,%
  bottom = 2.54cm%
}%

\makeatletter
\def\@xobeysp{\hspace{0pt}\mbox{}\hspace{0pt}}
\appto\verbatim@font{\hyphenchar\font`-\relax}
\makeatother 

\tolerance=1000
\emergencystretch=\maxdimen
\hyphenpenalty=5000
\hbadness=10000

\AtBeginDocument{
	\setlength{\abovedisplayskip}{6pt}
	\setlength{\belowdisplayskip}{6pt}
	\setlength{\abovedisplayshortskip}{0pt}
	\setlength{\belowdisplayshortskip}{0pt} 
}
\newcommand{\Crosscolumn}{false}
\newcommand{\Orientation}{vertical}
\newcommand{\Label}{-NoValue-}
\newcommand{\Verticalalignment}{b}

% Equation Environment

\makeatletter
\define@boolkey+{align}{crosscolumn}{
  \ifKV@align@crosscolumn
    \renewcommand{\Crosscolumn}{true}
  \else
    \renewcommand{\Crosscolumn}{false}
  \fi
}{
  \ClassWarning{bilidoc}{Crosscolumn input for align not exists.}
}
\makeatother


% Bilingual Table
% Key Defination
\makeatletter
\define@choicekey*+{BiliTable}{orientation}[\val\nr]{vertical,horizontal,v,h}{
  \ifcase\nr\relax
    \renewcommand{\Orientation}{vertical}
  \or
    \renewcommand{\Orientation}{horizontal}
  \or
    \renewcommand{\Orientation}{vertical}
  \or
    \renewcommand{\Orientation}{horizontal}
  \fi
}{
  \ClassWarning{bilidoc}{Orientation input for BiliTable not exists.}
}
\define@boolkey+{BiliTable}{crosscolumn}{
  \ifKV@BiliTable@crosscolumn
    \renewcommand{\Crosscolumn}{true}
  \else
    \renewcommand{\Crosscolumn}{false}
  \fi
}{
  \ClassWarning{bilidoc}{Crosscolumn input for BiliTable not exists.}
}
\define@key{BiliTable}{label}{
  \renewcommand{\Label}{#1}
}
\makeatother
\ProvideDocumentEnvironment{align}{O{}}{
  \setkeys{align}{crosscolumn=false}
  \setkeys{align}{#1}
  \ifthenelse{\equal{\Crosscolumn}{true}}{
    \end{ParaColumn}
  }{}
  \begin{flalign}
}{
  \end{flalign}
  \ifthenelse{\equal{\Crosscolumn}{true}}{
    \begin{ParaColumn}
    \switchcolumn
  }{}
}

% Environment Definition
\NewDocumentEnvironment{BiliTable}{O{} O{htbp} m m}{
  \setkeys{BiliTable}{orientation=vertical,crosscolumn=false}
  \setkeys{BiliTable}{#1}
  \ifthenelse{\equal{\Crosscolumn}{true}}{
    \ifthenelse{\equal{\Orientation}{horizontal}}{
        \begin{sidewaystable*}[#2]
     }{
        \begin{table*}[#2]
    }
  }{
    \ifthenelse{\equal{\Orientation}{horizontal}}{
      \begin{sidewaystable}[#2]
    }{
      \begin{table}[#2]
    }
  }
  \centering
  \renewcommand{\tablename}{Table}
  \caption{#3}
  \addtocounter{table}{-1}
  \vspace{-12pt}
  \renewcommand{\tablename}{表}
  \caption{#4}
  \vspace{-12pt}
  \ifthenelse{\equal{\Label}{-NoValue-}}{}{
    \label{\Label}
    \renewcommand{\Label}{-NoValue-}
  }
}{
  \ifthenelse{\equal{\Crosscolumn}{true}}{
    \ifthenelse{\equal{\Orientation}{horizontal}}{
        \end{sidewaystable*}
    }{
        \end{table*}
    }
  }{
    \ifthenelse{\equal{\Orientation}{horizontal}}{
        \end{sidewaystable}
    }{
        \end{table}
    }
  }
}
 
% Bilingual Figure
\makeatletter
\define@choicekey*+{BiliFigure}{orientation}[\val\nr]{vertical,horizontal,v,h}{
  \ifcase\nr\relax
    \renewcommand{\Orientation}{vertical}
  \or
    \renewcommand{\Orientation}{horizontal}
  \or
    \renewcommand{\Orientation}{vertical}
  \or
    \renewcommand{\Orientation}{horizontal}
  \fi
}{
  \ClassWarning{bilidoc}{Orientation input for BiliFigure not exists.}
}
\define@boolkey+{BiliFigure}{crosscolumn}{
  \ifKV@BiliFigure@crosscolumn
    \renewcommand{\Crosscolumn}{true}
  \else
    \renewcommand{\Crosscolumn}{false}
  \fi
}{
  \ClassWarning{bilidoc}{Crosscolumn input for BiliFigure not exists.}
}
\define@key{BiliFigure}{label}{
  \renewcommand{\Label}{#1}
}
\makeatother
% Environment Definition
\NewDocumentEnvironment{BiliFigure}{O{} O{htbp} m m}{
  \setkeys{BiliFigure}{orientation=vertical,crosscolumn=false}
  \setkeys{BiliFigure}{#1}
  \ifthenelse{\equal{\Crosscolumn}{true}}{
    \ifthenelse{\equal{\Orientation}{horizontal}}{
        \begin{sidewaysfigure*}[#2]
     }{
        \begin{figure*}[#2]
    }
  }{
    \ifthenelse{\equal{\Orientation}{horizontal}}{
      \begin{sidewaysfigure}[#2]
    }{
      \begin{figure}[#2]
    }
  }
  \centering
}{
  \renewcommand{\figurename}{Figure}
  \vspace{-12pt}
  \caption{#3}
  \addtocounter{figure}{-1}
  \vspace{-12pt}
  \renewcommand{\figurename}{图}
  \caption{#4}
  \ifthenelse{\equal{\Label}{-NoValue-}}{}{
    \label{\Label}
    \renewcommand{\Label}{-NoValue-}
  }
  \ifthenelse{\equal{\Crosscolumn}{true}}{
    \ifthenelse{\equal{\Orientation}{horizontal}}{
        \end{sidewaysfigure*}
    }{
        \end{figure*}
    }
  }{
    \ifthenelse{\equal{\Orientation}{horizontal}}{
        \end{sidewaysfigure}
    }{
        \end{figure}
    }
  }
}

% Side by Side Charts
\makeatletter
\define@boolkey+{sidebyside}{crosscolumn}{
  \ifKV@sidebyside@crosscolumn
    \renewcommand{\Crosscolumn}{true}
  \else
    \renewcommand{\Crosscolumn}{false}
  \fi
}{
  \ClassWarning{bilidoc}{Crosscolumn input for sidebyside not exists.}
}
\define@choicekey*+{sidebyside}{verticalalignment}[\val\nr]{top,center,bottom,t,c,b}{
  \ifcase\nr\relax
    \renewcommand{\Verticalalignment}{t}
  \or
    \renewcommand{\Verticalalignment}{c}
  \or
    \renewcommand{\Verticalalignment}{b}
  \or
    \renewcommand{\Verticalalignment}{t}
  \or
    \renewcommand{\Verticalalignment}{c}
  \or
    \renewcommand{\Verticalalignment}{b}
  \fi
}{
  \ClassWarning{bilidoc}{Horizontalignment input for sidebyside not exists.}
}
\makeatother
% Default Key Value
\NewDocumentCommand{\sidebyside}{O{} O{htbp} m m m m o o}{
  \setkeys{sidebyside}{crosscolumn=false,verticalalignment=bottom}
  \setkeys{sidebyside}{#1}
  \ifthenelse{\equal{\Crosscolumn}{true}}{
    \begin{figure*}[#2]
  }{
    \begin{figure}[#2]
  }
  \centering
  \begin{minipage}[\Verticalalignment]{#3} #4 \end{minipage}
  \hspace{\fill}
  \begin{minipage}[\Verticalalignment]{#5} #6 \end{minipage}
  \IfValueT{#7}{
    \hspace{\fill}
    \begin{minipage}[\Verticalalignment]{#7} #8 \end{minipage}
  }
  \ifthenelse{\equal{\Crosscolumn}{true}}{
    \end{figure*}
  }{
    \end{figure}
  }
}

% End by End Charts
\makeatletter
\define@boolkey+{endbyend}{crosscolumn}{
  \ifKV@sidebyside@crosscolumn
    \renewcommand{\Crosscolumn}{true}
  \else
    \renewcommand{\Crosscolumn}{false}
  \fi
}{
  \ClassWarning{bilidoc}{Crosscolumn input for BiliTable not exists.}
}
\makeatother
% Default Key Value
\NewDocumentCommand{\endbyend}{O{} O{htbp} m m m o}{
  \setkeys{endbyend}{crosscolumn=false}
  \setkeys{endbyend}{#1}
  \ifthenelse{\equal{\Crosscolumn}{true}}{
    \begin{figure*}[#2]
  }{
    \begin{figure}[#2]
  }
  \noindent
  \begin{minipage}[b]{#3} #4 \end{minipage}\newline{}
  \begin{minipage}[b]{#3} #5 \end{minipage}\newline{}
  \IfValueT{#6}{
    \begin{minipage}[b]{#3} #6 \end{minipage}\newline{}
  }
  \ifthenelse{\equal{\Crosscolumn}{true}}{
    \end{figure*}
  }{
    \end{figure}
  }
}

% ParaColumn
\NewDocumentEnvironment{ParaColumn}{O{} O{0.60\textwidth}}{
  \setcolumnwidth{#2}
  \begin{paracol}{2}[#1]
}{\end{paracol}}

% Abstract 
\NewDocumentEnvironment{Abstract}{m m O{0.60\textwidth}}{
  \setcolumnwidth{#3}
  \newcommand{\enkeywords}{#1}
  \newcommand{\cnkeywords}{#2}
  \section*{Abstract 摘要}
  \begin{paracol}{2}
}{
  \textbf{关键词：}\cnkeywords
  \switchcolumn[0]{\textbf{Key Words: }\enkeywords}
  \end{paracol}
}
 
\newfontfamily\courier{Courier New}
\lstdefinelanguage{LaTeX}[LaTeX]{TeX}{
  morekeywords={begin,end,title,author,date,maketitle,section,textbf,switchcolumn,sidebyside,endbyend,textwidth,linewidth,toprule,midrule,bottomrule,includegraphics,subsection,lstinputlisting,subfigure,CrossColumnText},
}
\lstset{linewidth=\linewidth,
    %numbers=left, %设置行号位置 
    basicstyle=\small\courier,
    numberstyle=\tiny\courier, %设置行号大小  
    keywordstyle=\color{blue}\courier, %设置关键字颜色  
    %identifierstyle=\bf，
    commentstyle=\it\color{gray}\courier, %设置注释颜色 
    stringstyle=\it\color[RGB]{128,0,0}\courier,
    %framexleftmargin=10mm,
    frame=single, %设置边框格式  
    backgroundcolor=\color[RGB]{245,245,244},
    %escapeinside=``, %逃逸字符(1左面的键)，用于显示中文  
    breaklines, %自动折行
    columns=fullflexible,
    extendedchars=false, %解决代码跨页时，章节标题，页眉等汉字不显示的问题  
    %xleftmargin=2em,xrightmargin=2em, aboveskip=1em, %设置边距  
    tabsize=4, %设置tab空格数  
    showspaces=false %不显示空格  
} 