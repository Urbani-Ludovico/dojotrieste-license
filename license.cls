\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{license}[2026/11/01 Latex class for Dojo Trieste license]


% ========================================%
% OPTIONS                                 %
% ========================================%

\RequirePackage{kvoptions}

\SetupKeyvalOptions{
    family=options,
    prefix=option@
}

\DeclareStringOption{Age}
\DeclareStringOption[10pt]{FontSize}
\DeclareStringOption[11cm]{PaperWidth}
\DeclareStringOption[15cm]{PaperHeight}

\ProcessKeyvalOptions*


% ========================================%
% CLASS EXTENSION                        %
% ========================================%

\PassOptionsToClass{\option@FontSize}{book}

\LoadClass[
    twoside
]{book}


% ========================================%
% PAPER SETTINGS                          %
% ========================================%

% Paper size and margins
\RequirePackage{geometry}
\geometry{
    paperwidth = \option@PaperWidth,
    paperheight = \option@PaperHeight,
    margin = 0.8cm,
    footskip = 0.5cm
}

% Font encoding
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

% Font family
\RequirePackage{helvet}
\renewcommand{\familydefault}{\sfdefault}

% Paragraph settings
\RequirePackage[
	skip = 0pt,
	indent = 0pt
]{parskip}

% Graphics
\RequirePackage{graphicx}
\graphicspath{ {./images} }

% Other packages
\RequirePackage{tabularray}
\RequirePackage{textcomp}


% ========================================%
% FANCY STYLE                             %
% ========================================%

\RequirePackage{fancyhdr}

\fancypagestyle{std}{
    \renewcommand{\headrulewidth}{0pt}
	\fancyfoot[C]{-- \thepage\ --}
}


%========================================%
% COLORS                                 %
%========================================%

\RequirePackage{xcolor}

\definecolor{main}{RGB}{0, 60, 160}
\color{main}


%========================================%
% TIKZ                                   %
%========================================%

\RequirePackage{tikz}
\RequirePackage{tikzpagenodes}

\renewcommand{\frame}{
    \tikz[remember picture, overlay] \draw
        (current page text area.south west)
        rectangle
        (current page text area.north east);
}


%========================================%
% TABLES                                 %
%========================================%

\NewTblrEnviron{logtable}
\SetTblrInner[logtable]{
    width = {\textwidth},
    rows = {
        ht = 0.84cm,
        valign = m,
        abovesep = 0.12cm
    },
    row{1} = {
        ht = 1.5cm,
        valign = m,
        abovesep = 0.2cm,
        font = {\large\bfseries}
    },
    row{2} = {
        abovesep = 0.1cm
    },
    hlines, vlines
}


%========================================%
% TOC                                    %
%========================================%

\RequirePackage{tocloft}

\renewcommand{\contentsname}{}
\renewcommand{\cfttoctitlefont}{}
\renewcommand{\cftaftertoctitle}{}
\setlength{\cftbeforetoctitleskip}{0pt}
\setlength{\cftaftertoctitleskip}{0pt}


%========================================%
% DOCUMENT BEGIN                         %
%========================================%

\AtBeginDocument{
    \frontmatter
    \pagestyle{empty}
    \begin{titlepage}
        \centering
        \includegraphics[height = 3cm]{logo.pdf} \\[0.5cm]
        \textbf{\Large A.S.D. DOJO Trieste}
        \vfill
        \textbf{Libretto personale del} \\[0.5cm]
        \textbf{\Huge SOCIO}
        \ifx\option@Age\@empty
        \else
            \\[0.5cm]
            \textbf{\option@Age}
        \fi
        \vfill
        \includegraphics[height = 1cm]{fijlkam.pdf} \\
        Associazione sportiva affiliata \\
        alla FIJLKAM e al CONI
    \end{titlepage}
    \mainmatter{}
    \pagestyle{std}
}


%========================================%
% DOCUMENT END                           %
%========================================%

\AtEndDocument{
    \backmatter
    \tableofcontents
    \thispagestyle{empty}
}


%========================================%
% ELEMENTS                               %
%========================================%

\newcommand{\PersonData}{
    \addcontentsline{toc}{chapter}{DATI SOCIO}
    \frame
    \begin{center}
        \textit{Associazione Sportiva Dilettantistica} \\[0.2cm]
        \textbf{\LARGE DOJO TRIESTE}
    \end{center}
    \vfill
    \begin{center}
        \begin{tikzpicture}
            \draw (0,0) rectangle (35mm,45mm) node[midway, text opacity = 0.5] {FOTO};
        \end{tikzpicture}
    \end{center}
    \vfill\vfill
    \begin{tblr}{
        width = {\textwidth},
        colspec = {l X},
        hline{2-Y} = {solid},
        rows = {
            ht = 0.5cm,
            valign = m
        }
    }
        COGNOME & \\
        NOME \\
        DATA DI NASCITA \\
        LUOGO DI NASCITA \\
        CODICE FISCALE \\
        RESIDENZA \\
        DATA DI EMISSIONE
    \end{tblr}
}