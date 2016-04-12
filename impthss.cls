% vim:ft=tex:ts=2:sw=2
%
% Dissertation document class for the Institute of Modern Physics, Chinese Academy of Scieneces.
% It is modified from the Peking University dissertation document class "impthss"
%
% Copyright (c) 2008-2009 solvethis
% Copyright (c) 2010-2015 Casper Ti. Vector
% Copyright (c) 2015      ufan
%
% This work may be distributed and/or modified under the conditions of the
% LaTeX Project Public License, either version 1.3 of this license or (at
% your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX version
% 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% The current maintainer of this work is Casper Ti. Vector.
%
% This work consists of the following files:
%   impthss.cls
%   impthss-gbk.def
%   impthss-utf8.def
%   impthss-extra.sty
%   implogo.eps
%   impword.eps

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{impthss}
	[2015/06/30 v1.6.3 Peking University dissertation document class]

% Process the encoding options.
\newif\ifimpthss@opt@gbk \impthss@opt@gbktrue
\DeclareOption{GBK}{\impthss@opt@gbktrue\PassOptionsToClass{GBK}{ctexbook}}
\DeclareOption{UTF8}%
	{\impthss@opt@gbkfalse\PassOptionsToClass{UTF8}{ctexbook}}
% Whether to enable `\Uppercase' (works problematically) in heading marks.
\newif\ifimpthss@opt@uppermark \impthss@opt@uppermarkfalse
\DeclareOption{uppermark}{\impthss@opt@uppermarktrue}
\DeclareOption{nouppermark}{\impthss@opt@uppermarkfalse}
% Whether to enable the default extra settings.
\newif\ifimpthss@opt@extra \impthss@opt@extratrue
\DeclareOption{extra}{\impthss@opt@extratrue}
\DeclareOption{noextra}{\impthss@opt@extrafalse}

% eg. `\impthss@int@extraopt{spacing}' will expand to:
%   \DeclareOption{spacing}{\PassOptionsToPackage{spacing}{impthss-extra}}
%   \DeclareOption{nospacing}{\PassOptionsToPackage{nospacing}{impthss-extra}}
\def\impthss@int@extraopt#1{
	\DeclareOption{#1}{\PassOptionsToPackage{#1}{impthss-extra}}
	\DeclareOption{no#1}{\PassOptionsToPackage{no#1}{impthss-extra}}
}
% Pass options to `impthss-extra'.
% See impthss-extra.sty for an explanation of the options.
\impthss@int@extraopt{footfmt}
\impthss@int@extraopt{pkuspace}
\impthss@int@extraopt{spacing}
\impthss@int@extraopt{pdftoc}
\impthss@int@extraopt{spechap}
\impthss@int@extraopt{pdfprop}
\impthss@int@extraopt{colorlinks}
% Pass all other options to `ctexbook' document class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
% Process all class options now.
\ProcessOptions\relax

% impthss is based on ctexbook; we use `xiao 4' as default font size.
% CJKfntef provides `\CJKunderline' used in `\maketitle'.
% fancyhdr provides utilities for setting up headers and footers.
\LoadClass[zihao=-4]{ctexbook}[2011/03/11]
% Tables
\RequirePackage{tablefootnote}
\RequirePackage{booktabs}
\RequirePackage{tabulary}
\RequirePackage{longtable}
\RequirePackage{tabu}
\AtBeginEnvironment{longtabu}{\small}{}{}
\AtBeginEnvironment{tabu}{\small}{}{}
% Provide hyperlinks of references
\RequirePackage{hyperref}
% For customized header/footer
\RequirePackage{fancyhdr}
% Provides support for `key = val' grammar.
\RequirePackage{keyval}
% Graphics support.
\RequirePackage{graphicx}[1999/02/16]
% Provides utilities for setting up page layout.
\RequirePackage{geometry}

% Whether to enable the default extra settings.
\ifimpthss@opt@extra\RequirePackage{impthss-extra}\fi

\ifimpthss@opt@gbk
	\ifxetex
		% No support for XeLaTeX compilation in non-unicode encoding, i.e. GBK.
		\ClassError{impthss}%
			{XeLaTeX compilation is not supported without UTF-8}%
			{%
				XeLaTeX compilation without UTF-8 is very problematic.\MessageBreak
				Therefore please use UTF-8 encoding for the LaTeX code.%
			}
	\else\ifpdf
		% Fix garbled text in bookmarks for pdfLaTeX compilation in GBK.
		% Compatibility settings for ctex 1.x, to be removed in 2017; ctex 2.x
		% loads xCJK2uni by itself when necessary.
		\RequirePackage{xCJK2uni}
	\fi\fi
\fi

\AtEndOfClass{
	% Set up chinese captions and labels.
	\ifimpthss@opt@gbk\input{impthss-gbk.def}
	\else\input{impthss-utf8.def}
	\fi
}

% eg. `\impthss@int@infoitema{ctitle}' will expand to:
%   \def\ctitle#1{\def\@ctitle{#1}}
%   \define@key{impthss@info}{ctitle}{\ctitle{#1}}
\def\impthss@int@infoitema#1{
	\@namedef{#1}##1{\@namedef{@#1}{##1}}
	\define@key{impthss@info}{#1}{\@nameuse{#1}{##1}}
}
% eg. `\impthss@int@infoitemb{cuniversity}' will expand to:
%   \define@key{impthss@info}{cuniversity}{\def\cuniversity{#1}}
\def\impthss@int@infoitemb#1{
	\define@key{impthss@info}{#1}{\@namedef{#1}{##1}}
}
% Set up document information entries.
\impthss@int@infoitema{ctitle}
\impthss@int@infoitema{etitle}
\impthss@int@infoitema{cauthor}
\impthss@int@infoitema{eauthor}
\impthss@int@infoitema{studentid}
\impthss@int@infoitema{date}
\impthss@int@infoitema{school}
\impthss@int@infoitema{cmajor}
\impthss@int@infoitema{emajor}
\impthss@int@infoitema{direction}
\impthss@int@infoitema{cmentor}
\impthss@int@infoitema{ementor}
\impthss@int@infoitema{ckeywords}
\impthss@int@infoitema{ekeywords}
\impthss@int@infoitemb{cuniversity}
\impthss@int@infoitemb{euniversity}
\impthss@int@infoitemb{cthesisname}
\impthss@int@infoitemb{ethesisname}
\impthss@int@infoitemb{cabstractname}
\impthss@int@infoitemb{eabstractname}
% Set up document information using the `key = value' grammar.
\newcommand*{\impthssinfo}[1]{\setkeys{impthss@info}{#1}}

% Set up page layout.
\geometry{
	a4paper, includefoot, 
	hmargin = {3.25cm,3cm}, vmargin = {3.8cm,3cm},
	headheight = 1.5cm, headsep = 0.5cm, footskip = 0.75cm
}

% Set up spacing for displayed formulae.
\setlength{\abovedisplayskip}{6bp plus 1.5bp minus 3.5bp}
\setlength{\abovedisplayshortskip}{3bp plus 0.75bp minus 1.75bp}
\setlength{\belowdisplayshortskip}{3bp plus 0.75bp minus 1.75bp}
\setlength{\belowdisplayskip}{6bp plus 1.5bp minus 3.5bp}

% Set up chapter/section/... captions.
\ctexset{
	chapter={
		format = {\zihao{4}\bfseries\centering},
% 		beforeskip = {0bp}, afterskip = {0bp},
		beforeskip = {0.0em}, 
                afterskip = {1.8em},
		pagestyle = {hfmain}
	},
	section={
% 		number = {\arabic{chapter}．\arabic{section}},
		format = {\zihao{-4}\bfseries},
		beforeskip = {20bp plus 1ex minus 0.2ex},
		afterskip = {6bp plus 0.2ex}
	},
	subsection={
		format = {\zihao{-4}\bfseries},
% 		number = {\arabic{chapter}．\arabic{section}．\arabic{subsection}},
		beforeskip = {12bp plus 1ex minus 0.2ex},
		afterskip = {6bp plus 0.2ex}
	}
% 	subsubsection={
% 		format = {\zihao{-4}\bfseries},
		%number = {\arabic{chapter}．\arabic{section}．\arabic{subsection}．\arabic{subsubsection}},
% 		beforeskip = {12bp plus 1ex minus 0.2ex},
% 		afterskip = {6bp plus 0.2ex}
% 	}
}

% Internal command to set up headers and footers.
\def\impthss@int@setpagestyle{
	% Footer/Header for the abstract pages
	\fancypagestyle{plain}{
		\fancyhf{}
		\renewcommand*{\headrulewidth}{0.75bp}
		\renewcommand*{\footrulewidth}{0.0bp}
		\fancyfoot[C]{\zihao{5}{\thepage}}
		\fancyhead[C]{\zihao{5}{\leftmark}}
	}
}

% redefine the plain pagestyle, which is intended for use in the body pages.
\fancypagestyle{hfmain}{
	\fancyhf{}
	\renewcommand*{\headrulewidth}{0.75bp}
	\renewcommand*{\footrulewidth}{0.0bp}
% 	\fancyfoot[C]{\zihao{5}\normalfont{\thepage}}
	\if@twoside
		\fancyhead[RO,LE]{\zihao{5}{\thepage}}
		\fancyhead[LO]{\zihao{5}{\leftmark}}
		\fancyhead[RE]{\zihao{5}{\cthesisname}}
	\else
		\fancyhead[C]{\zihao{5}{\leftmark}}
	\fi
}


% `\MakeUppercase' works problematically.
% eg. it converts `\cite{ctex}' into `\cite{CTEX}'.
% This option can disable `\MakeUppercase' in left/right heading marks.
\ifimpthss@opt@uppermark
	\def\impthss@int@setcase#1{#1}
	\impthss@int@setpagestyle
\else
	% Code copied from fancyhdr's `\nouppercase', with the redefinition of
	% `\uppercase' dropped to avoid disrupting CJKutf8.
	% cf. <https://code.google.com/p/ctex-kit/issues/detail?id=147>.
	\def\impthss@int@setcase#1{%
		\let\MakeUppercase\relax%
		\expandafter\let\csname MakeUppercase \endcsname\relax%
		#1%
	}
	\impthss@int@setpagestyle
\fi

% This places a bookmark pointing to somewhere near the page header;
% Result of simple `\chapter{...} \pdfbookmark{...}' does not look nice,
% because the bookmark will point to somewhere below the chapter mark.
\def\impthss@int@pdfmark#1#2{%
	\if@openright\cleardoublepage\else\clearpage\fi
	\pdfbookmark[1]{#1}{#2}%
}

% Usage: \impthss@int@fillinblank{(number of lines)}{(line width)}{(contents)}
\def\impthss@int@fillinblank#1#2#3{%
	\makebox[0pt][l]{\parbox[t]{#2}{\centering{#3}}}\mbox{}%
	\parbox[t]{#2}{%
		\newcount\impthss@tmp@linecount
		\impthss@tmp@linecount=#1
		\loop\ifnum\impthss@tmp@linecount>0
			% Fill specified space with underline on the bottom line. `\underline'
			% draws line on the baseline (not the bottom line), and this is why
			% `\CJKunderline' is used here instead.
			\ifnum\impthss@tmp@linecount=1
				\CJKunderline{\makebox[#2]{}}
			\else
				\CJKunderline{\makebox[#2]{}}\\
			\fi
		\advance\impthss@tmp@linecount by -1\relax
		\repeat%
	}%
}

% Set up format of the title page (cover).
\renewcommand{\maketitle}{%
	\impthss@int@pdfmark{\titlepagename}{titlepage}
	\begin{titlepage}
		% It will be nicer to use this line skip level in the title page.
		\linespread{1.6}\selectfont
		% Make the title page centered.
		\begin{center}
			% Emblem and inscription of the university, and type of thesis.
			{%
				\zihao{1}%
				\includegraphics[height = 2.4em]{pkulogo}\hspace{0.4em}%
				\raisebox{0.4em}{\includegraphics[height = 1.6em]{pkuword}}\\[0.8em]
				{\bfseries{\cthesisname}}%
			}
			\vfill
			% Title of the thesis.
			{%
				\zihao{2}{\label@ctitle}%
				\impthss@int@fillinblank{2}{0.64\textwidth}{\textbf{\@ctitle}}%
			}
			\vfill
			% Information about the author.
			{%
				% Slightly adjust the line skip when using new font size.
				\zihao{3}\linespread{1.75}\selectfont
				\def\impthss@tmp@len{0.56\textwidth}
				\begin{tabular}{l@{\extracolsep{0.2em}}c}
					{\bfseries\label@cauthor}		&
					\impthss@int@fillinblank{1}{\impthss@tmp@len}{\fangsong\@cauthor}		\\
					{\bfseries\label@studentid}	&
					\impthss@int@fillinblank{1}{\impthss@tmp@len}{\fangsong\@studentid}	\\
					{\bfseries\label@school}		&
					\impthss@int@fillinblank{1}{\impthss@tmp@len}{\fangsong\@school}		\\
					{\bfseries\label@cmajor}		&
					\impthss@int@fillinblank{1}{\impthss@tmp@len}{\fangsong\@cmajor}		\\
					{\bfseries\label@direction}	&
					\impthss@int@fillinblank{1}{\impthss@tmp@len}{\fangsong\@direction}	\\
					{\bfseries\label@cmentor}		&
					\impthss@int@fillinblank{1}{\impthss@tmp@len}{\fangsong\@cmentor}		\\
				\end{tabular}%
			}
			\vfill
			% Date.
			{\zihao{-2}\@date}
		\end{center}
	\end{titlepage}%
}


% Typeset the Chinese abstract.
\newenvironment{cabstract}{%
	\impthss@int@pdfmark{\cabstractname}{cabstract}
	\chapter*{\cabstractname}
	\markboth{\cabstractname}{}%
	\thispagestyle{plain}
}{% Keywords at the bottom of the page.
	\par\noindent\linebreak\textbf{\label@ckeywords}{\@ckeywords}%
}

% Typeset the English abstract.
\newenvironment{eabstract}{%
	\impthss@int@pdfmark{\eabstractname}{eabstract}
	\chapter*{\eabstractname}
	\markboth{\eabstractname}{}
	\thispagestyle{plain}
	\begin{center}
		{\sffamily\bf\large\@etitle}\\
		{\@eauthor} ({\@emajor})\\
		{\label@ementor}{\@ementor}\\[2em]
	\end{center}
	\par%
}{% Keywords at the bottom of the page.
	\par\noindent\linebreak\textbf{\label@ekeywords}{\@ekeywords}%
}

% new table of contents
\AtBeginDocument{
  \renewcommand\tableofcontents{%
      \if@twocolumn
	\@restonecoltrue\onecolumn
      \else
	\@restonecolfalse
      \fi
      \chapter*{\contentsname}%
      \pdfbookmark[1]{\contentsname}{table}
      \markboth{\contentsname}{}%页眉显示'目录'
      \thispagestyle{plain}    
      \@starttoc{toc}%
      \if@restonecol\twocolumn\fi
  }
}

% This command is used to start a chapter without numbering, and correctly set
% up the headers and footers in the chapter.
\newcommand\specialchap[1]{%
	\chapter*{#1}\phantomsection\addcontentsline{toc}{chapter}{#1}
	\markboth{#1}{}%
}

% Declare customized page style, so user needn't care about the header/footer themself
\newcommand\covermatter{%
  \pagestyle{empty}
  \pagenumbering{arabic}
}
\renewcommand\frontmatter{%
  \cleardoublepage
  \pagestyle{plain}
  \@mainmatterfalse
  \pagenumbering{roman}
}
\renewcommand\mainmatter{%
  \cleardoublepage
  \pagestyle{hfmain}
  \@mainmattertrue
  \pagenumbering{arabic}
}
% \renewcommand\backmatter{%
%   \if@openright
%     \cleardoublepage
%   \else
%     \clearpage
%   \fi
%   \@mainmatterfalse
% }

% Provides control over the format of toc, lof, lot
\@ifpackageloaded{tocloft}{%
  \renewcommand{\cftchapfont}{\zihao{-4}\songti\bfseries}
%   \renewcommand{\cftdot}{,}
%   \renewcommand{\cftdotsep}{\cftnodots}
  \renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
  \renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
  \renewcommand{\cftsubsecleader}{\cftdotfill{\cftdotsep}}
%   \renewcommand{\cftsubsubsecleader}{\bfseries\cftdotfill{\cftdotsep}}
  \renewcommand{\cftsubsubsecleader}{\cftdotfill{\cftdotsep}}
  
}{
  \RequirePackage[titles]{tocloft}
  \renewcommand{\cftchapfont}{\zihao{-4}\songti\bfseries}
%   \renewcommand{\cftdot}{,}
%   \renewcommand{\cftdotsep}{\cftnodots}
  \renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
  \renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
  \renewcommand{\cftsubsecleader}{\cftdotfill{\cftdotsep}}
%   \renewcommand{\cftsubsubsecleader}{\bfseries\cftdotfill{\cftdotsep}}
  \renewcommand{\cftsubsubsecleader}{\cftdotfill{\cftdotsep}}
}

% hyperref setup: extract the left bar of pdf viewer
\hypersetup{
  bookmarksnumbered = true,
  bookmarksopen = true
}

% Show subsubsection numbering
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}

\endinput
